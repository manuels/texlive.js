#!/usr/bin/env perl
#
use strict;
$^W=1;

my $prj = 'dosepsbin';
my $version = '1.2';
my $date = '2012/03/22';
my $author = 'Heiko Oberdiek';
my $copyright = "Copyright 2011-2012 $author";

my $verbose = 0;
my $quiet = 0;
my $inputfile = '';
my $file_eps = '';
my $file_wmf= '';
my $file_tiff = '';
my $buf_size = 0x1000000;

my $title = "\U$prj\E $date v$version, $copyright\n";

sub die_error ($;$) {
    my $msg = shift;
    $msg = "\n!!! Error: $msg!\n";
    if (@_) {
        my $ref = shift;
        foreach my $key (sort keys %$ref) {
            my $value = $$ref{$key};
            $key =~ s/ /_/g;
            $key =~ s/^\d+_?//;
            $msg .= "    [$key: $value]\n";
        }
    }
    die $msg;
}

sub warning ($) {
    my $msg = shift;
    print "!!! Warning: $msg!\n";
}

sub verbose (@) {
    return unless $verbose;
    my @msg = @_;
    print "* @msg\n";
}

sub verbose_kv ($$) {
    return unless $verbose;
    my $key = shift;
    my $value = shift;
    $key =~ s/ /_/g;
    print "    [$key: $value]\n";
}

sub die_usage {
    my $msg = $_[0];
    pod2usage(
        -exitstatus => 2,
        -msg        => "\n==> $msg!\n");
}

use Getopt::Long;
use Pod::Usage;

GetOptions(
    'verbose'         => sub {
        $verbose = 1;
        $quiet = 0;
    },
    'quiet'           => sub {
        $quiet = 1;
        $verbose = 0;
    },
    'help|?'          => sub {
        print $title;
        pod2usage(1);
    },
    'man'             => sub {
        pod2usage(-exitstatus => 0, -verbose => 2);
    },
    'version'         => sub {
        print "$prj $date v$version\n";
        exit(0);
    },
    'inputfile=s'     => \$inputfile,
    'eps-file=s'       => \$file_eps,
    'wmf-file=s'       => \$file_wmf,
    'tiff-file=s'      => \$file_tiff,
) or die_usage('Unknown option');

print $title unless $quiet;

verbose_kv 'program name', $0;
verbose_kv 'osname', $^O;
verbose_kv 'perl version', $^V ? sprintf('v%vd', $^V) : $];

$inputfile = shift @ARGV if not $inputfile and @ARGV;
$inputfile or die_error "Missing input file";

# If input file does not exist, try with extension ".eps"
if (not -f $inputfile) {
    my $file = "$inputfile.eps";
    $inputfile = $file if -f $file;
}
-f $inputfile or
        die_error "Input file not found", {
            'input file' => $inputfile
        };
verbose_kv 'input file', $inputfile;

# Get file size of input file
my @tmp = stat $inputfile;
@tmp or die_error "Getting size of Input file `$inputfile' failed";
my $inputfile_size = $tmp[7];
$inputfile_size > 30 or
        die_error "Input file size is too small", {
            '1 input file' => $inputfile,
            '2 file size' => $inputfile_size,
        };
verbose_kv 'input file size', $inputfile_size;

# Open input file
open(IN, '<', $inputfile) or # die_error "Input file `$inputfile' not found";
        die_error "Cannot open input file", {
            '1 input file' => $inputfile,
            '2 os error' => $!,
        };
binmode(IN);

# Read header
my $header;
read IN, $header, 30 or
        die_error "Reading the header of the input file failed", {
            'file' => $inputfile,
            'os error' => $!,
        };
# Check ASCII PS header
if ('%!' eq substr $header, 0, 2) {
    $header =~ m/^(%![A-Za-z0-9\.\- \t]+)/;
    my $first_line = $1;
    die_error "Input file seems to be an ASCII PostScript file", {
        '1 input file' => $inputfile,
        '2 file header' => $first_line,
    }
}
my ($id,
    $offset_ps, $length_ps,
    $offset_wmf, $length_wmf,
    $offset_tiff, $length_tiff,
    $checksum) = unpack 'NV6n', $header;

my $id_hex = unpack 'H8', pack 'N', $id;
$id_hex = "0x\U$id_hex\E";
verbose_kv 'header id', $id_hex;
$id eq 0xC5D0D3C6 or
        die_error "Input file is not a `DOS EPS binary file'", {
            '1 input file' => $inputfile,
            '2 file header id' => $id_hex,
        };

# Check checksum
if ($checksum == 0xFFFF) {
    verbose_kv 'checksum', '0xFFFF (ignored)';
}
else {
    my $cs = 0;
    map { $cs ^= $_ } unpack 'n14', $header;
    if ($cs != $checksum) {
        my $cs_hex = unpack 'H4', pack 'n', $cs;
        $cs_hex = "0x\U$cs_hex\E";
        my $cs_found = unpack 'H4', pack 'n', $checksum;
        $cs_found = "0x\U$cs_found\E";
        die_error "Checksum mismatch", {
                '1 input file' => $inputfile,
                '2 checksum found' => $cs_found,
                '3 checksum expected' => $cs_hex,
        };
    }
}

verbose_kv 'offset of PS section', $offset_ps;
verbose_kv 'length of PS section', $length_ps;
verbose_kv 'offset of WMF section', $offset_wmf;
verbose_kv 'length of WMF section', $length_wmf;
verbose_kv 'offset of TIFF section', $offset_tiff;
verbose_kv 'length of TIFF section', $length_tiff;

{
    my %check_positions;
    sub check_section ($$$) {
        my $type = shift;
        my $ref_off = shift;
        my $ref_len = shift;
        if ($$ref_off == 0 and $$ref_len == 0) {
            print "--> $type section is not available.\n" unless $quiet;
            return '<not present>';
        }
        $$ref_off >= 30 and $$ref_off < $inputfile_size or
                die_error "Invalid offset of PS section", {
                    '1 input file' => $inputfile,
                    "2 offset of $type section" => $$ref_off,
                    "3 length of $type section" => $$ref_len,
                };
        $$ref_len >= 0 and $$ref_off + $$ref_len <= $inputfile_size or
                die_error "Invalid length of PS section", {
                    '1 input file' => $inputfile,
                    "2 offset of $type section" => $$ref_off,
                    "3 length of $type section" => $$ref_len,
                };
        $check_positions{$$ref_off} = $$ref_off + $$ref_len;
        print "--> $type section with $$ref_len bytes.\n" unless $quiet;
        return sprintf '%d..%d', $$ref_off, $$ref_off + $$ref_len - 1;
    }
    my $sec_ps   = check_section 'PS', \$offset_ps, \$length_ps;
    verbose_kv 'position of PS section', $sec_ps;
    my $sec_wmf  = check_section 'WMF', \$offset_wmf, \$length_wmf;
    verbose_kv 'position of WMF section', $sec_wmf;
    my $sec_tiff = check_section 'TIFF', \$offset_tiff, \$length_tiff;
    verbose_kv 'position of TIFF section', $sec_tiff;
    my $pos = 30;
    foreach my $beg (sort keys %check_positions) {
        $check_positions{$beg} >= $pos or
                die_error "Section overlap detected", {
                    '1 input file' => $inputfile,
                    '2 position of header' => "0..29",
                    '3 position of PS section' => $sec_ps,
                    '4 position of WMF section' => $sec_wmf,
                    '5 position of TIFF section' => $sec_tiff,
                };
    }
}

sub write_file ($$$$) {
    my $type = shift;
    my $file = shift;
    my $off = shift;
    my $len = shift;
    my $org_len = $len;
    return unless $file;
    verbose_kv "$type file", $file;
    if ($off <= 0 or $len <= 0) {
        warning "No $type section found";
        return;
    }
    my $position = $off;
    seek IN, $off, 0 or
            die_error "Moving to $type section offset failed", {
                '1 input file' => $inputfile,
                '2 position' => $off,
                '3 os error' => $!,
            };
    open(OUT, '>', $file) or
            die_error "Opening $type file for writing failed", {
                "1 $type file" => $file,
                '2 os error' => $!,
            };
    binmode(OUT);
    while ($len > 0) {
        my $read_len = ($len > $buf_size) ? $buf_size : $len;
        my $buf;
        my $read_count = read IN, $buf, $read_len;
        $read_count > 0 or
                die_error "Reading file failed", {
                    '1 input file' => $inputfile,
                    "2 $type file" => $file,
                    '3 offset' => $position,
                    '4 length' => $read_len,
                    '5 os error' => $!,
                };
        $position += $read_count;
        print OUT $buf or
                die_error "Writing $type file failed", {
                    "1 $type file" => $file,
                    '2 offset' => $org_len - $len,
                    '3 length' => $read_count,
                    '4 os error' => $!,
                };
        $len -= $read_count;
    }
    close(OUT);
    print "==> $type file written: [$file]\n" unless $quiet;
}

write_file 'TIFF', $file_tiff, $offset_tiff, $length_tiff;
write_file 'WMF', $file_wmf, $offset_wmf, $length_wmf;
write_file 'EPS', $file_eps, $offset_ps, $length_ps;

close(IN);

1;

__DATA__

=head1 NAME

dosepsbin -- Extract PS/WMF/TIFF sections from DOS EPS binary files

=head1 VERSION

2012-03-22 v1.2

=head1 SYNOPSIS

The progam B<dosepsbin> analyses an EPS file that is not
a plain ASCII PostScript file but given as DOS EPS binary file.

    dosepsbin [options] <input file>

First it analyzes the I<input file>, validates its header
and summarizes the available sections. Depending on the
given options, the sections are then written to files.

Options:

    --eps-file <file>      Write PS section to <file>.
    --wmf-file <file>      Write WMF section to <file>.
    --tiff-file <file>      Write TIFF section to <file>.
    --inputfile <file>     The name of the input file.
    --verbose              Verbose output.
    --quiet                Only errors and warnings are printed.
    --help                 Brief help message.
    --man                  Full documentation.
    --version              Print version identification.

The files for output must be different from the input file.

=head1 DESCRIPTION

=head2 DOS EPS Binary File Format

A Encapsulated PostScript (EPS) file can also given in a special
binary format to support the inclusion of a thumbnail. The file
format starts with a binary header that contains the positions of
the possible sections:

=over

=item * Postscript (PS)

=item * Windows Metafile Format (WMF)

=item * Tag Image File Format (TIFF)

=back

The PS section must be present and either the WMF file or the TIFF
file should be given.

=head1 OPTIONS

=over

=item B<->B<-eps-file>=<I<file>>

The PS section is written to <I<file>>. The output file must
be different from the input file.

=item B<->B<-wmf-file>=<I<file>>

The WMF section is written to <I<file>> if present. The output
file must be different from the input file.

=item B<->B<-tiff-file>=<I<file>>

The TIFF section is written to <I<file>> if present. The output
file must be different from the input file.

=item B<->B<-inputfile>=<I<file>>

The input file can also be given directly on the command line.
If the file does not exist, then the file with extension `.eps'
is tried.

=item B<->B<-verbose>

Verbose messages.

=item B<->B<-quiet>

No messages are printed except for errors and warnings.

=item B<->B<-help>

Display help screen.

=item B<->B<-man>

Prints manual page.

=item B<->B<-version>

Print version identification and exit.

=back

=head1 EXAMPLES

The following command extracts the PS section from file F<test.eps>
and stores the result in file F<test-ps.eps>:

    dosepsbin --eps-file test-ps.eps test.eps

=head1 AUTHOR

Heiko Oberdiek, email: heiko.oberdiek at googlemail.com

=head1 COPYRIGHT AND LICENSE

Copyright 2011-2012 by Heiko Oberdiek.

This library is free software; you may redistribute it and/or
modify it under the same terms as Perl itself
(Perl Artistic License/GNU General Public License, version 2).

=head1 SEE ALSO

The DOS EPS binary file format is described
in section "5.2 Windows Metafile or TIFF":

    Adobe Developer Support,
    Encapsulated PostScript File Format Specification,
    Version 3.0,
    1992-05-01,
    http://partners.adobe.com/public/developer/en/ps/5002.EPSF_Spec.pdf

=head1 HISTORY

=over 2

=item B<2011/11/10 v1.0>

=over 2

=item * First version.

=back

=item B<2011/12/05 v1.1>

=over 2

=item * Typo fixed in help text (thanks Peter Breitenlohner).

=back

=item B<2012/03/22 v1.2>

=over 2

=item * Fix in validation test for offset of PS section.

=back

=back

=cut
