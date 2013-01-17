#!/usr/bin/perl
################################################################################
# Copyright (c) 2011-2012 Martin Scharrer <martin@scharrer-online.de>
# This is open source software under the GPL v3 or later.
################################################################################
use strict;
use warnings;

sub fromenv;
sub load_data;
sub save_data;

my $VERSION = 'v1.2c from 2012/05/08';
my %CTAN_SERVERURLS = (
    dante     => 'http://dante.ctan.org/upload.html',
    uktug     => 'http://www.tex.ac.uk/upload/',
);
my %CTAN_SERVERALIASES = (
    de        => 'dante',
    'uk-tug'  => 'uktug',
    uk        => 'uktug',
    cambridge => 'uktug',
);

my $CTAN_URL;

my @FIELDS = qw(contribution version name email summary directory DoNotAnnounce announce notes license freeversion file);
my @REQUIRED = qw(contribution version name email summary license file);
my %FIELDS = map { $_ => fromenv($_) } @FIELDS;


my %FIELDS_DESC = (
    contribution  => 'Name of your contribution',
    version       => 'Version number',
    name          => 'Your name',
    email         => 'Your email',
    summary       => 'Summary description',
    directory     => 'Suggested CTAN directory',
    DoNotAnnounce => 'No need to announce this update',
    announce      => 'Short description for announcement',
    notes         => 'Optional notes to the CTAN maintainers (DANTE only)',
    license       => 'License type',
    freeversion   => 'Which free license',
    file          => 'File to upload',
);

my @LICENSES = qw( free nocommercial nosell nosource shareware artistic other-nonfree);

my %LICENSES = (
    free          => 'Free',
    nocommercial  => 'Nocommercial',
    nosell        => 'Nosell',
    nosource      => 'Nosource',
    shareware     => 'Shareware',
    artistic      => 'Perl Artistic (Clarified or later)',
  'other-nonfree' => 'Other nonfree License',
);

my @FREEVERSIONS = qw( apache2 artistic fdl gfl gpl lgpl lppl ofl pd other-free);

my %FREEVERSIONS = (
        apache2    => 'Apache License v2.0',
        artistic   => 'Perl Artistic License (version 2)',
        fdl        => 'GNU Free Documentation License',
        gfl        => 'GUST Font License',
        gpl        => 'GNU General Public License',
        lgpl       => 'Lesser GPL',
        lppl       => 'LaTeX Project',
        ofl        => 'Open Font License',
        pd         => 'Public Domain',
      'other-free' => 'Other Free',
);

my $QUIET = 0;
my $ASK   = 1;
my $FORCE = 0;
my $PROMPT = -t STDIN ? 1 : 0;
my $LOG   = 0;

my $LOGFILE = $ENV{CTANUPLOAD_LOGFILE};

sub usage {
    my $warn = shift;
    if ($warn) {
        print STDERR "Unknown option '$warn'\n";
    }
    print STDERR <<"EOT";
ctanupload script $VERSION
Uploads a contribution to CTAN.

Usage:
ctanupload <options> --<name>=<value>

Arguments can also be given using the CTANUPLOAD environment variable which are processed first, so that
explicit arguments will overwrite them.

Options:
  -p         Prompt for missing values. (default if run in terminal)
  -P         Do not prompt for missing values. (default if not run in terminal)
  -y         Do not ask for confirmation, but submit immediately.
  -u <URL>   CTAN URL to upload to (defaults to CTAN_URL environment variable or random if not set)
  -U <name>  CTAN server to upload to, either 'dante' or 'uktug'.
  -F <file>  Read data from file
  -f         Force upload even if input seems incorrect (unknown license etc.).
  -v         Verbose mode.
  -q         Quiet mode.
  -l         Write log file.
  -L         Do not write log file. (default)
  -o <file>  Define log file. (still requires -l)
  -h         Print this help and exit.
  -V         Print version number.

The following fields exists and can be given as
--<name>=<value>, --<name> <value>, --<name>-file=<file>, --<name>-file <file>
or as environment variables: CTAN_<NAME>, CTAN_<name>, <NAME> or <name>.

EOT

    foreach my $field (@FIELDS) {
        printf STDERR " %15s     %s\n", $field, $FIELDS_DESC{$field};
    }

    printf STDERR "\nValid license types:\n";
    for my $license (@LICENSES) {
        printf STDERR " %15s     %s\n", $license, $LICENSES{$license};
    }

    printf STDERR "\nValid free license:\n";
    for my $license (@FREEVERSIONS) {
        printf STDERR " %15s     %s\n", $license, $FREEVERSIONS{$license};
    }

    exit ($warn ? 1 : 0);
}

if (exists $ENV{CTAN_URL}) {
    unshift @ARGV, ('-u', $ENV{'CTAN_URL'});
}
elsif (exists $ENV{CTAN_SERVER}) {
    unshift @ARGV, ('-U', $ENV{'CTAN_SERVER'});
}

if (exists $ENV{'CTANUPLOAD'}) {
    unshift @ARGV, (split /\s+/, $ENV{'CTANUPLOAD'});
}


while (my $arg = shift @ARGV) {
    if ($arg =~ /^--(.*?)(?:=(.*))?$/) {
        my $name = $1;
        my $value = defined $2 ? $2 : shift @ARGV;
        my $file;
        if ($name =~ /(.*)-file$/) {
            $name = $1;
            $file = $value;
        }
        if (exists $FIELDS{$name}) {
            if ($file) {
                if (open (my $valfile, '<', $file)) {
                    $value = join '', <$valfile>;
                    close ($valfile);
                }
                else {
                    warn "Couldn't read file '$file'!\n";
                    $value = '';
                }
            }
            $FIELDS{$name} = $value;
        }
        else {
            usage('--' . $name . ($file ? '-file' : ''));
        }
    }
    elsif ($arg =~ /^-([a-z]+)$/i) {
      for my $char (split //, $1) {
        if ($char eq 'h') {
            usage(0);
        }
        elsif ($char eq 'q') {
            $QUIET = 1;
        }
        elsif ($char eq 'v') {
            $QUIET = 0;
        }
        elsif ($char eq 'y') {
            $ASK = 0;
        }
        elsif ($char eq 'F') {
            my $file = shift @ARGV;
            load_data ($file);
        }
        elsif ($char eq 'f') {
            $FORCE = 1;
        }
        elsif ($char eq 'p') {
            $PROMPT = 1;
        }
        elsif ($char eq 'P') {
            $PROMPT = 0;
        }
        elsif ($char eq 'u') {
            $CTAN_URL = shift @ARGV;
        }
        elsif ($char eq 'U') {
            my $server = lc shift @ARGV;
            $server = $CTAN_SERVERALIASES{$server} || $server;
            if (not exists $CTAN_SERVERURLS{ $server }) {
                die "Error: Unknown CTAN server '$server'.\n";
            }
            $CTAN_URL = $CTAN_SERVERURLS{ $server };
        }
        elsif ($char eq 'l') {
            $LOG = 1;
        }
        elsif ($char eq 'L') {
            $LOG = 0;
        }
        elsif ($char eq 'o') {
            $LOGFILE = shift @ARGV;
        }
        elsif ($char eq 'V') {
            print STDERR "ctanupload script $VERSION.\n";
            exit (0);
        }
        else {
            usage('-' . $char);
        }
      }
    }
    else {
        usage($arg);
    }
}

$CTAN_URL = (values %CTAN_SERVERURLS)[int rand scalar values %CTAN_SERVERURLS]
    if not defined $CTAN_URL;

my $DANTE = $CTAN_URL =~ /dante/;

PROMPT:

if ($PROMPT) {
    foreach my $field (@FIELDS) {
        if (!defined $FIELDS{$field} || !length $FIELDS{$field}) {
            my $input = '';
            if ($field eq 'notes' || $field eq 'announce') {
                next if $field eq 'announce' and $FIELDS{DoNotAnnounce};
                next if $field eq 'notes' and not $DANTE;
                print "\u$FIELDS_DESC{$field}: (press CTRL-Z (Windows) or CTRL-D (Linux) to stop)\n";
                while (<STDIN>) {
                    $input .= $_;
                }
            }
            elsif ($field eq 'DoNotAnnounce') {
                print "\uNo need to announce upload? [y/N]: ";
                $input = <STDIN>;
            }
            elsif ($field eq 'license') {
                print "\u$FIELDS_DESC{$field}:\n";
                my $num = 1;
                foreach my $license (@LICENSES) {
                    printf " [%d] %s\n", $num++, $LICENSES{$license};
                }
                print "Selection: ";
                $input = lc (<STDIN> || '');
                if ($input =~ /^\s*(\d+)\s*$/) {
                    $input = $LICENSES[$1-1];
                }
            }
            elsif ($field eq 'freeversion') {
                next if $FIELDS{license} ne 'free';
                print "\u$FIELDS_DESC{$field}:\n";
                my $num = 1;
                foreach my $license (@FREEVERSIONS) {
                    printf " [%d] %s\n", $num++, $FREEVERSIONS{$license};
                }
                print "Selection: ";
                $input = lc (<STDIN> || '');
                if ($input =~ /^\s*(\d+)\s*$/) {
                    $input = $FREEVERSIONS[$1-1];
                }
            }
            else {
                print "\u$FIELDS_DESC{$field}: ";
                $input = <STDIN>;
            }
            $input = '' if not defined $input;
            chomp $input;
            $input =~ s/^\s+//;
            $input =~ s/\s+$//;
            $FIELDS{$field} = $input;
        }
    }
}

my $abort = '';
foreach my $required (@REQUIRED) {
    if (!length $FIELDS{$required}) {
        $abort .= "Required field '$required' is missing!\n";
    }
}
if (not exists $LICENSES{ $FIELDS{license} }) {
    $abort .= "Unknown license type '$FIELDS{license}'!\n"
        if not $FORCE;
}
if ($FIELDS{license} ne 'free') {
    $FIELDS{freeversion} = '-not-selected-';
} elsif (!$FIELDS{freeversion}) {
    $abort .= "Required field 'freeversion' is missing!\n";
} elsif (not exists $FREEVERSIONS{ $FIELDS{freeversion} }) {
    $abort .=  "Unknown free license '$FIELDS{freeversion}'!\n"
        if not $FORCE;
}
if ($FIELDS{file} && ! -f $FIELDS{file}) {
    $abort .= "File '$FIELDS{file}' not found!\n";
}

if ($LOG) {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    my $DATE = sprintf ('%04d-%02d-%02d %02d:%02d:%02d', $year+1900, $mon+1, $mday, $hour, $min, $sec);
    if (!$LOGFILE) {
        $LOGFILE = 'ctanupload-' . $FIELDS{contribution} . " $DATE.log";
        $LOGFILE =~ tr/: /-_/;
    }
    save_data($LOGFILE, 1, "# $DATE");
    if (!open (LOG, '>>', $LOGFILE)) {
        warn "Couldn't open logfile '$LOGFILE'.\n";
        $LOG = 0;
    }
}

if ($abort) {
    print $abort, "Aborting!\n";
    if ($LOG) {
        $abort =~ s/\n/\n# /gms;
        print LOG "# $abort\n# Aborting!\n";
    }
    exit (2);
}

my $DoNotAnnounce = ($FIELDS{DoNotAnnounce}) ? '[x]' : '[ ]';

if (!$FIELDS{directory}) {
    $FIELDS{directory} = '/macros/latex/contrib/' . $FIELDS{contribution};
}


print "\nThe following data will be submitted to CTAN ($CTAN_URL):\n";

foreach my $field (@FIELDS) {
    if ($field eq 'DoNotAnnounce') {
        print "$FIELDS_DESC{$field}: $DoNotAnnounce\n";
    }
    elsif ($field eq 'license') {
        print "$FIELDS_DESC{$field}: $LICENSES{$FIELDS{$field}}\n";
    }
    elsif ($field eq 'freeversion') {
        print "$FIELDS_DESC{$field}: $FREEVERSIONS{$FIELDS{$field}}\n";
    }
    else {
        print "$FIELDS_DESC{$field}: ", $FIELDS{$field} || '', "\n";
    }
}

eval {
    my $file = $FIELDS{file};
    die if not -f $file;
    print "\n$file (", (-s $file), "):\n";
    if ($file =~ /\.tar\.gz$/) {
        system ('tar', 'tzvf', $file);
    }
};

if ($ASK) {
    print "\nUpload? [(y/N/(e)dit/(s)ave] ";
    my $response = lc <STDIN>;
    chomp ($response);

    unless ($response eq 'y' or $response eq 'yes') {
        if ($response eq 'e' or $response eq 'edit') {
            my $file = 'ctanupload.dat';
            save_data($file);
            my $editor = $ENV{'CTANUPLOAD_EDITOR'} || $ENV{'EDITOR'};
            if (not defined $editor) {
                print "No EDITOR environment variable defined.\n";
                print "Data was stored in file '$file'. Please edit manually and load with the -F option.\n";
                exit (1);
            }
            else {
                system($editor, $file);
                load_data($file);
                goto PROMPT;
            }
        }
        elsif ($response eq 's' or $response eq 'save') {
            my $file = 'ctanupload.dat';
            save_data($file);
            print "Data was stored in file '$file'.\n";
            print LOG "\n# Data was stored in file '$file'.\n" if $LOG;
            exit (2);
        }
        else {
            print "\nUpload aborted!\n";
            print LOG "\n# Upload aborted!\n" if $LOG;
            exit (1);
        }
    }
}

if ($FIELDS{DoNotAnnounce}) {
    if ($DANTE) {
        $FIELDS{DoNotAnnounce} = 'No';
        delete $FIELDS{'to_announce'};
        $FIELDS{notes} = '';
    } else {
        $FIELDS{'to_announce'} = 'Yes';
        delete $FIELDS{DoNotAnnounce};
        delete $FIELDS{notes};
    }
}
else {
    if ($DANTE) {
        $FIELDS{DoNotAnnounce} = 'Yes';
        delete $FIELDS{to_announce};
    } else {
        delete $FIELDS{'to_announce'};
        delete $FIELDS{DoNotAnnounce};
        delete $FIELDS{notes};
    }
}
# Add Submit button for the sake of completeness:
$FIELDS{'SUBMIT'} = ($DANTE) ? 'Submit' : 'Submit contribution';

use WWW::Mechanize;
my $mech = WWW::Mechanize->new(quiet => $QUIET, autocheck => 1);

print "Accessing CTAN upload page ...\n";
$mech->get( $CTAN_URL );
print "Uploading ...\n";
$mech->submit_form(
 form_number => 1,
 fields => \%FIELDS,
);

if ($mech->success()) {
    print "HTTP response code: ", $mech->response()->message(), "\n";
}

print "\nResponse:\n";
print LOG "\n# Response:\n" if $LOG;
eval {
    if ($mech->response()->header('Content-Type') eq 'text/plain') {
        #open (my $DEBUGFILE, '>', 'ctanupload.dbg');
        #print {$DEBUGFILE} $mech->content();
        #close ($DEBUGFILE);
        print $mech->content();
        print LOG $mech->content() if $LOG;
    }
    else {
        use HTML::TreeBuilder;
        use HTML::FormatText;
        my $tree = HTML::TreeBuilder->new_from_content( $mech->content() );
        my $formatter = HTML::FormatText->new(leftmargin => 0, rightmargin => 80);
        my @response = split /\n/, $formatter->format($tree);
        local $, = "\n";
        print @response[3..$#response-3];
        local $, = "\n# ";
        print LOG '', @response[3..$#response-3] if $LOG;
    }
    1;
} or do {
    print "Can't display HTML response, storing reponse if log file 'ctanupload_response.html'\n";
    open (HLOG, '>', 'ctanupload_response.html');
    print HLOG $mech->content();
    close (HLOG);
};

print "\n";
close LOG if $LOG;
exit (0);


sub fromenv {
    my $name = shift;
    foreach my $var ('CTAN_' . uc $name, uc $name, 'CTAN_' . $name, $name) {
        return $ENV{$var} if exists $ENV{$var};
    }
    return undef;
}

sub load_data {
    my $file = shift;
    open (my $load, '<', $file) or die "Couldn't open data file '$file'!\n";
    LOAD_LOOP:
    while (my $line = <$load>) {
        next if ($line =~ /^\s*(#|$)/);
        if ($line =~ /^([a-z]+)\s*=\s*(.*)$/i) {
            my ($name,$value) = ($1,$2);
            if (!exists $FIELDS{$name}) {
                print STDERR "Ignoring unknown variable '$name' from file '$file' (line $.)!\n";
                next;
            }
            $FIELDS{$name} = $value;
            if ($name eq 'announce' || $name eq 'notes') {
                $FIELDS{$name} .= "\n";
                while ($line = <$load>) {
                    next if ($line =~ /^\s*#/);
                    last if ($line =~ /^[a-z]+\s*=/i);
                    $FIELDS{$name} .= $line;
                }
                $FIELDS{$name} =~ s/^[\s\n]+//;
                $FIELDS{$name} =~ s/[\s\n]+$//;
                redo LOAD_LOOP if not eof $load;
           }
        }
        else {
            print STDERR "Ignoring incorrect line '$line' from file '$file' (line $.)!\n";
        }
    }
    close ($load);
}

sub save_data {
    my $file = shift;
    my $storefileinfo = shift;
    my $header = shift;
    $file = 'ctanupload.dat' if not defined $file;
    open (my $save, '>', $file) or do { warn "Couldn't save data to file '$file'!\n"; return; };
    print {$save} "$header\n" if $header;
    foreach my $field (@FIELDS) {
        if ($field eq 'DoNotAnnounce') {
            print {$save} "$field = ", $FIELDS{DoNotAnnounce} ? '1' : '0', "\n";
        }
        else {
            print {$save} "$field = ", $FIELDS{$field} || '', "\n";
        }
    }
    if ($storefileinfo && -f $FIELDS{file}) {
        my $file = $FIELDS{file};
        print {$save} "\n# $file (", (-s $file), "):\n";
        if ($file =~ /\.tar\.gz$/) {
            open (my $TAR, '-|', "tar tzvf $file");
            print {$save} map { "# $_" } <$TAR>;
            print {$save} "\n";
            close ($TAR);
        }
    }
    close ($save);
    return;
}



__END__
