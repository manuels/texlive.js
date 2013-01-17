#! /usr/bin/perl -w
use strict;
$^W=1; # turn warning on
#
# pkfix.pl
#
# Copyright (C) 2001, 2005, 2007, 2009, 2011, 2012 Heiko Oberdiek.
#
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3
# of this license or (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3 or later is part of all distributions of LaTeX
# version 2003/12/01 or later.
# This work has the LPPL maintenance status "maintained".
# This Current Maintainer of this work is Heiko Oberdiek.
#
# See file "README" for a list of files that belongs to this project.
#
# This file "pkfix.pl" may be renamed to "pkfix"
# for installation purposes.
#
my $file        = "pkfix.pl";
my $program     = uc($&) if $file =~ /^\w+/;
my $project     = lc($program);
my $version     = "1.7";
my $date        = "2012/04/18";
my $author      = "Heiko Oberdiek";
my $copyright   = "Copyright (c) 2001, 2005, 2007, 2009, 2011, 2012 by $author.";
#
# Reqirements: Perl5, dvips
# History:
#   2001/04/12 v0.1:
#     * First try.
#   2001/04/13 v0.2:
#     * TeX/dvips is called for each font for the case of errors.
#     * First release.
#   2001/04/15 v0.3:
#     * Call of kpsewhich with option --progname.
#     * Extracting of texps.pro from temporary PostScript file,
#       if kpsewhich failed.
#     * Option -G0 for dvips run added.
#   2001/04/16 v0.4:
#     * Support for merging PostScript fonts added.
#     * \special{!...}/@fedspecial detection added.
#     * Bug fix: I detection.
#   2001/04/17 v0.5:
#     * Redirection of stderr (dvips run) if possible.
#   2001/04/20 v0.6:
#     * Bug fix: dvips font names can contain numbers.
#   2001/04/21 v0.7:
#     * Bug fix: long dvi file name in ps file.
#   2001/04/23 v0.8:
#     * Bug fix: post string parsing.
#   2001/04/26 v0.9:
#     * Check of version number of dvips in PostScript file.
#   2001/06/30 v1.0:
#     * Problem with DOS line endings fixed.
#   2005/01/28 v1.1:
#     * Bug fix: encoding files are now included also.
#     * The intermediate DVI files are written directly.
#     * LPPL 1.3
#   2005/01/29 v1.2:
#     * Merging is now based on type 1 names. This solves
#       the problem, if different bitmap fonts maps to the
#       same type 1 font, eg. (ecrm1000, larm1000) -> SFRM1000.
#     * Suppression of PK generation, if environment variable
#       MKTEXPK is supported.
#     * If output file is "-" (standard output) then messages of
#       pkfix are written to standard error output.
#   2005/02/25 v1.3:
#     * Bug fix: Detection of "@fedspecial end" improved.
#     * Bug fix: Typo corrected (PRT -> $PRT).
#   2007/11/07 v1.4:
#     * Deprecation warning of perl 5.8.8 fixed.
#   2009/03/18 v1.5:
#     * Patch to support dvips 5.399 (submitted by Melissa O'Neill).
#   2011/04/22 v1.6:
#     * Bug fix: input and output files are read and written in
#       binary mode (thanks M.S. Dousti for bug report).
#   2012/04/18 v1.7:
#     * Option --version added.
#
### program identification
my $title = "$program $version, $date - $copyright\n";

### error strings
my $Error = "!!! Error:"; # error prefix
my $Warning = "!!! Warning:"; # warning prefix

### variables
my $envvar    = uc($project);
my $infile    = "";
my $outfile   = "";
my $texpsfile = "texps.pro";
my $prefix    = "_${project}_$$";
# my $prefix    = "_${project}_";
my $tempfile  = "$prefix";
my $texfile   = "$tempfile.tex";
my $dvifile   = "$tempfile.dvi";
my $logfile   = "$tempfile.log";
my $psfile    = "$tempfile.ps";
my $missfile  = "missfont.log";
my @cleanlist = ($dvifile, $psfile);
push(@cleanlist, $missfile) unless -f $missfile;

my $err_redirect = " 2>&1";
$err_redirect = "" if $^O =~ /dos/i ||
                      $^O =~ /os2/i ||
                      $^O =~ /mswin32/i ||
                      $^O =~ /cygwin/i;

my $x_resolution    = 0;
my $y_resolution    = 0;
my $blocks_found    = 0;
my $fonts_converted = 0;
my $fonts_merged    = 0;
my $fonts_misses    = 0;
my $PRT = \*STDOUT;

### option variables
my @bool = ("false", "true");
$::opt_tex        = "tex";
$::opt_dvips      = "dvips";
$::opt_kpsewhich  = "kpsewhich --progname $project";
$::opt_options    = "-Ppdf -G0";
$::opt_usetex     = 0;
$::opt_help       = 0;
$::opt_quiet      = 0;
$::opt_debug      = 0;
$::opt_verbose    = 0;
$::opt_clean      = 1;
$::opt_version    = 0;

my $usage = <<"END_OF_USAGE";
${title}Syntax:   \L$program\E [options] <inputfile.ps> <outputfile.ps>
Function: This program tries to replace pk fonts in <inputfile.ps>
          by the type 1 versions. The result is written in <outputfile.ps>.
Options:                                                         (defaults:)
  --help            print usage
  --version         print version number
  --(no)quiet       suppress messages                            ($bool[$::opt_quiet])
  --(no)verbose     verbose printing                             ($bool[$::opt_verbose])
  --(no)debug       debug informations                           ($bool[$::opt_debug])
  --(no)clean       clear temp files                             ($bool[$::opt_clean])
  --(no)usetex      use TeX for generating the DVI file          ($bool[$::opt_usetex])
  --tex texcmd      tex command name (plain format)              ($::opt_tex)
  --dvips dvipscmd  dvips command name                           ($::opt_dvips)
  --options opt     dvips options                                ($::opt_options)
END_OF_USAGE

### environment variable PKFIX
if ($ENV{$envvar}) {
    unshift(@ARGV, split(/\s+/, $ENV{$envvar}));
}

### process options
my @OrgArgv = @ARGV;
use Getopt::Long;
GetOptions(
    "help!",
    "version!",
    "quiet!",
    "debug!",
    "verbose!",
    "clean!",
    "usetex!",
    "tex=s",
    "dvips=s",
    "options=s"
) or die $usage;
if ($::opt_version) {
    print "$project $date v$version\n";
    exit(0);
}
!$::opt_help or die $usage;
@ARGV < 3 or die "$usage$Error Too many files!\n";
@ARGV == 2 or die "$usage$Error Missing file names!\n";

$::opt_quiet = 0 if $::opt_verbose;
$::opt_clean = 0 if $::opt_debug;

push(@cleanlist, $texfile, $logfile) if $::opt_usetex;

### get file names
$infile = $ARGV[0];
$outfile = $ARGV[1];

### suppress PK generation
$ENV{'MKTEXPK'} = "0";

$PRT = \*STDERR if $outfile eq "-";

print $PRT $title unless $::opt_quiet;

print $PRT "*** input file: `$infile'\n" if $::opt_verbose;
print $PRT "*** output file: `$outfile'\n" if $::opt_verbose;

if ($::opt_debug) {
    print $PRT <<"END_DEB";
*** OSNAME: $^O
*** PERL_VERSION: $]
*** ARGV: @OrgArgv
END_DEB
}

### get texps.pro
my $texps_data   = 0;
my $texps_string = get_texps_pro();

### Encoding definitions
my %encoding_files = ();
my $encoding_string = "";

### open input and output files
open(IN, $infile) or die "$Error Cannot open `$infile'!\n";
binmode(IN);
open(OUT, ">$outfile") or die "$Error Cannot write `$outfile'!\n";
binmode(OUT);

##################################
# expected format:
#   ...
#   %%DVIPSParameters:... dpi=([\dx]+)...
#   ...
#   TeXDict begin \d+ \d+ \d+ \d+ \d+ \(\S+\)
#   @start ...
#   ...
#   %DVIPSBitmapFont: (\S+) (\S+) ([\d\.]+) (\d+)
#   /(\S+) ...
#   ...
#   %EndDVIPSBitmapFont
#   ...
#   ... end
#   %%EndProlog
#
# or if \special{!...} was used, the lines with TeXDict:
#   TeXdict begin @defspecial
#
#   ...
#
#   @fedspecial end TeXDict begin
#   \d+ \d+ \d+ \d+ \d+ \(\S+\) @start
#
# or
#   @fedspecial end
#   ...
#
# bitmap font:
# start:
#   %%DVIPSBitmapFont: {dvips font} {font name} {at x pt} {chars}
#   /{dvips font} {chars} {max. char number + 1} df
# character, variant a:
#   <{hex code}>{char number} D
# character, variant b:\
#   [<{hex code}>{num1} {num2} {num3} {num4} {num5} {char number} D
# end:
#   E
#   %%EndDVIPSBitmapFont
#
# type 1 font:
# before TeXDict line:
#   %%BeginFont: CMR10
#   ...
#   %%EndFont
# after @start:
#   /Fa ... /CMR10 rf
#
# Font names: /[F-Z][a-zA-Z0-9]
#
# Encoding files before texps.pro:
#   %%BeginProcSet: {file name}.enc 0 0
#   ...
#   %%EndProcSet
#
# Melissa O'Neill reported small variations for dvips 5.399:
#   TeXDict begin \d+ \d+ \d+
# and
#   \d+ \d+ \d+ \(\d+\) @start
#
###################################

my $x_comment_resolution = 0;
my $y_comment_resolution = 0;
my $start_string = "";
my $post_string = "";
my $dvips_resolution = "";
my $texps_found = 0;
my @font_list = ();
my %font_txt = ();
my %font_count = ();
my %font_entry = ();

sub init {
    $x_comment_resolution = 0;
    $y_comment_resolution = 0;
    $x_resolution = 0;
    $y_resolution = 0;
    $start_string = "";
    $texps_found = 0;
    @font_list = ();
    %font_txt = ();
    %font_count = ();
    %font_entry = ();
}

init();

while (<IN>) {

    if (/^%%Creator: (dvips\S*) (\S+)\s/) {
        print $PRT "*** %%Creator: $1 $2\n" if $::opt_debug;
        my $foundversion = $2;
        if ($foundversion =~ /(\d+\.\d+)/) {
            $foundversion = $1;
            # 5.62 is ok, 5.58 does not produce font comments
            if ($foundversion <= 5.58) {
                print $PRT "$Warning dvips version $1 does not generate " .
                           "the required font comments!\n";
            }
        }
    }

    if (/^%%BeginProcSet:\s*(.+)\.enc/) {
        $encoding_files{$1} = "";
    }

    if (/^%DVIPSParameters:.*dpi=([\dx]+)/) {
        print OUT;
        my $str = $1;
        $x_comment_resolution = 0;
        $y_comment_resolution = 0;
        if ($str =~ /^(\d+)x(\d+)$/) {
            $x_comment_resolution = $1;
            $y_comment_resolution = $2;
        }
        if ($str =~ /^(\d+)$/) {
            $x_comment_resolution = $1;
            $y_comment_resolution = $1;
        }
        print $PRT "*** %DVIPSParameters: dpi=$str " .
                   "(x=$x_comment_resolution, y=$y_comment_resolution)\n"
            if $::opt_debug;
        $x_comment_resolution > 0 && $y_comment_resolution > 0 or
            die "$Error Wrong resolution value " .
                "($x_comment_resolution x $y_comment_resolution)!\n";
        next;
    }

    if (/^%%BeginProcSet: texps.pro/) {
        $texps_found = 1;
        print $PRT "*** texps.pro found\n" if $::opt_debug;
    }

    if (/^TeXDict begin \@defspecial/) {
        my $saved = $_;
        print $PRT "*** \@defspecial found.\n" if $::opt_debug;
        $start_string = $_;
        while (<IN>) {
            $start_string .= $_;
            if (/^\@fedspecial end/) {
                s/^\@fedspecial end\s*(\S)/$1/;
                last;
            }
        }
    }
    elsif (/^TeXDict begin \d+ \d+ \d+ \d+ \d+/) {
        print $PRT "*** TeXDict begin <5 nums> found.\n" if $::opt_debug;
        $start_string = $_;
    }
    elsif (/^TeXDict begin \d+ \d+ \d+/) { # dvips 5.399
        print $PRT "*** TeXDict begin <3 nums> found.\n" if $::opt_debug;
        $start_string = $_;
    }
    if ($start_string ne "") {
        # look for @start
        unless (/\@start/) {
            while (<IN>) {
                $start_string .= $_;
                last if /\@start/;
            }
        }

        # divide post part
        $start_string =~ /^([\s\S]*\@start)\s*([\s\S]*)$/ or
            die "$Error Parse error (\@start)!\n";
        $start_string = "$1\n";
        $post_string = $2;
        $post_string =~ s/\s*$//;
        $post_string .= "\n" unless $post_string eq "";

        $start_string =~
            /\d+\s+\d+\s+\d+\s+(\d+)\s+(\d+)\s+\((.*)\)\s+\@start/ or
            /\d+\s+(\d+)\s+(\d+)\s+\@start/ or # dvips 5.399
            die "$Error Parse error (\@start parameters)!\n";

        $blocks_found++;
        print $PRT "*** dvi file: $3\n" if $::opt_debug and defined $3;

        # get and check resolution values
        $x_resolution = $1;
        $y_resolution = $2;
        print $PRT "*** resolution: $x_resolution x $y_resolution\n"
            if $::opt_debug;
        $x_comment_resolution > 0 or
            die "$Error Missing comment `%DVIPSParameters'!\n";
        $x_resolution == $x_comment_resolution &&
        $y_resolution == $y_comment_resolution or
            die "$Error Resolution values in comment and PostScript " .
                "does not match!\n";
        # setting dvips resolution option(s)
        if ($x_resolution == $y_resolution) {
            $dvips_resolution = "-D $x_resolution";
        }
        else {
            $dvips_resolution = "-X $x_resolution -Y $y_resolution";
        }

        while (<IN>) {
            if (/^%%EndProlog/) {
                print OUT $encoding_string;
                $texps_data > 0 or die "$Error File `texps.pro' not found!\n";
                print OUT $texps_string unless $texps_found;
                foreach (@font_list) {
                    my $fontname = $_;
                    print $PRT "*** Adding font `$fontname'\n"
                        if $::opt_debug;
                    my ($dummy1, $dummy2, $err);
                    if ($font_count{$fontname} > 1) {
                        $fonts_merged++;
                        print $PRT "*** Merging font `$fontname' ($font_count{$fontname}).\n"
                            unless $::opt_quiet;
                        ($dummy1, $font_txt{$fontname}, $dummy2, $err) =
                            get_font($font_entry{$fontname});
                        $err == 0 or die "$Error Cannot merge font `$fontname'!\n";
                    }
                    print OUT $font_txt{$fontname};
                }
                print OUT $start_string,
                          $post_string,
                          $_;
                print $PRT "*** %%EndProlog\n" if $::opt_debug;
                init();
                last;
            }

            if (/^%DVIPSBitmapFont: (\S+) (\S+) ([\d.]+) (\d+)/) {
                my $bitmap_string = $_;
                my $dvips_fontname = $1;
                my $fontname = $2;
                my $entry = "\\Font\{$1\}\{$2\}\{$3\}\{";
                print $PRT "*** Font $1: $2 at $3pt, $4 chars\n" if $::opt_verbose;
                my $line = "";
                my $num = -1;
                my $chars = $4;
                my $count = 0;
                while (<IN>) {
                    $bitmap_string .= $_;
                    last if /^%EndDVIPSBitmapFont/;
                    s/\r$//; # remove \r of possible DOS line ending
                    chomp;
                    $line .= " " . $_;
                }
                $line =~ s/<[0-9A-F ]*>/ /g;

                print $PRT "*** <Font> $line\n" if $::opt_debug;

                while ($line =~ /\s(\d+)\s+D(.*)/) {
                    $num = $1;
                    $count++;
                    $entry .= "$num,";
                    $line = $2;
                    while ($line =~ /^[\s\d\[]*I(.*)/) {
                        $num++;
                        $count++;
                        $entry .= "$num,";
                        $line = $1;
                    }
                }
                $chars == $count or
                    die "$Error Parse error, $count chars of $chars found " .
                        "($fontname)!\n";

                $entry =~ s/,$//;
                $entry .= "\}";

                print $PRT "*** Font conversion of `$fontname' started.\n"
                    if $::opt_verbose;
                my ($newfontname, $font_part, $start_part, $err) = get_font($entry);
                if ($err == 0) {
                    print $PRT "*** Font conversion: `$fontname' -> `$newfontname'.\n"
                        unless $::opt_quiet;
                    if (defined($font_count{$newfontname})) {
                        $font_count{$newfontname}++;
                        $font_entry{$newfontname} .= "\n$entry";
                    }
                    else {
                        push @font_list, $newfontname;
                        $font_txt{$newfontname} = $font_part;
                        $font_count{$newfontname} = 1;
                        $font_entry{$newfontname} = $entry;
                    }
                    $start_part =~ s/\/Fa/\/$dvips_fontname/;
                    $start_string .= $start_part;
                    $fonts_converted++;
                }
                else {
                    print $PRT "!!! Failed font conversion of `$fontname'!\n";
                    $start_string .= $bitmap_string;
                    $fonts_misses++;
                }

                next;
            }

            $post_string .= $_;
        }
        next;
    }

    print OUT;
}

close(IN);
close(OUT);

if ($::opt_clean) {
    print $PRT "*** clear temp files\n" if $::opt_verbose;
    map {unlink} @cleanlist;
}

if (!$::opt_quiet) {
    if ($blocks_found > 1) {
        print $PRT "==> $blocks_found blocks.\n";
    }
    if ($fonts_misses) {
        print $PRT "==> $fonts_misses font conversion",
              (($fonts_misses > 1) ? "s" : ""),
              " failed.\n";
    }
    if ($fonts_converted) {
        print $PRT "==> ",
              (($fonts_converted > 0) ? $fonts_converted : "No"),
              " converted font",
              (($fonts_converted > 1) ? "s" : ""),
              ".\n";
        if ($fonts_merged) {
            print $PRT "==> $fonts_merged merged font",
                  (($fonts_merged > 1) ? "s" : ""),
                  ".\n";
        }
    }
    else {
        print $PRT "==> no fonts converted\n";
    }
}


# get type 1 font
# param:  $entry: font entry as TeX string
# return: $name:  type 1 font name
#         $font:  font file as string
#         $start: font definition after @start
#         $err:   error indication
sub get_font {
    my $entry = shift;
    my $name = "";
    my $font = "";
    my $start = "";
    my $err = 0;
    my @err = ("", "", "", 1);
    local *OUT;
    local *IN;

    if ($::opt_usetex) {
        ### write temp tex file
        open(OUT, ">$texfile") or die "$Error Cannot write `$texfile'!\n";
        print OUT <<'TEX_HEADER';
\nonstopmode
\nopagenumbers
\def\Font#1#2#3#4{%
  \expandafter\font\csname font@#1\endcsname=#2 at #3pt\relax
  \csname font@#1\endcsname
  \hbox to 0pt{%
    \ScanChar#4,\NIL
    \hss
  }%
}
\def\ScanChar#1,#2\NIL{%
  \char#1\relax
  \ifx\\#2\\%
  \else
    \ReturnAfterFi{%
      \ScanChar#2\NIL
    }%
  \fi
}
\long\def\ReturnAfterFi#1\fi{\fi#1}
\noindent
TEX_HEADER

        print OUT "$entry\n\\bye\n";
        close(OUT);

        ### run tex
        {
            print $PRT "*** run TeX\n" if $::opt_verbose;

            my $cmd = "$::opt_tex $tempfile";
            print $PRT ">>> $cmd\n" if $::opt_verbose;
            my @capture = `$cmd`;
            if (!@capture) {
                print $PRT "$Warning Cannot execute TeX!\n";
                return @err;
            }
            if ($::opt_verbose) {
                print $PRT @capture;
            }
            else {
                foreach (@capture) {
                    print $PRT if /^!\s/;
                }
            }
            if ($?) {
                my $exitvalue = $?;
                if ($exitvalue > 255) {
                    $exitvalue >>= 8;
                    print $PRT "$Warning Closing TeX (exit status: $exitvalue)!\n";
                    return @err;
                }
                print $PRT "$Warning Closing TeX ($exitvalue)!\n";
                return @err;
            }
        }
    }
    else {
        # write dvi directly

        # DVI format description: dvitype.web
        my $DVI_pre = 247;
        my $DVI_id_byte = 2;
        my $DVI_num = 25400000;
        my $DVI_den = 473628672; # 7227 * 2^16
        my $DVI_mag = 1000;
        my @t = localtime(time);
        my $DVI_comment = "$program $version output "
                . sprintf("%04d/%02d/%02d %02d:%02d:%02d",
                ($t[5] + 1900), ($t[4] + 1), $t[3], $t[2], $t[1], $t[0]);
        my $DVI_comment_len = length($DVI_comment);
        my $DVI_bop = 139;
        my $DVI_eop = 140;
        my $DVI_fontdef1 = 243;
        my $DVI_fontdef2 = 244;
        my $DVI_fontdef4 = 246;
        my $DVI_design_size = 10; # an arbitrary value
        # A wrong value will trigger a dvips warning
        # (it can be seen in verbose mode):
        #   dvips: Design size mismatch in [...].tfm
        # But other consequences could not be noticed.
        # Thus a TFM lookup will be saved.
        my $DVI_checksum = 0; # because of unknown checksum
        my $DVI_fnt_num_0 = 171;
        my $DVI_fnt1 = 235;
        my $DVI_fnt2 = 236;
        my $DVI_fnt4 = 238;
        my $DVI_set1 = 128;
        my $DVI_push = 141;
        my $DVI_pop = 142;
        my $DVI_post = 248;
        my $DVI_u = 67108864; # 1024 pt, an arbitrary value
        my $DVI_l = 67108864; # 1024 pt, an arbitrary value
        my $DVI_post_post = 249;
        my $DVI_trailing = 223;

        open(OUT, ">$dvifile") or die "$Error Cannot write `$dvifile'!\n";
        binmode(OUT);

        # Preamble (pre)
        print OUT pack("C2N3Ca$DVI_comment_len",
            $DVI_pre, $DVI_id_byte, $DVI_num, $DVI_den, $DVI_mag,
            $DVI_comment_len, $DVI_comment);
        # Begin of page (bop)
        my $pos_bop = tell(OUT);
        print OUT pack("CN1x[N9]l", $DVI_bop, 1, -1);

        my $font_defs = "";
        my $font_num = 0;
        foreach(split("\n", $entry)) {
            my $font_def = "";
            /\\Font\{[^}]*\}\{([^}]*)\}\{([^}]*)\}\{([^}]*)\}/ or
                die "!!! Error: Internal parsing error!\n";
            my $font_name = $1;
            my $font_name_len = length($font_name);
            my $font_size = $2;
            my $font_chars = $3;

            # define font
            if ($font_num < 256) {
                $font_def = pack("CC", $DVI_fontdef1, $font_num);
            }
            # The other cases are very unlikely, especially there are
            # more than one font in the merging case only.
            elsif ($font_num < 65536) {
                $font_def = pack("Cn", $DVI_fontdef2, $font_num);
            }
            else {
                $font_def = pack("CN", $DVI_fontdef4, $font_num);
            }
            $font_def .= pack("x[N]N2xCa$font_name_len",
                    ($font_size * 65536), $DVI_design_size,
                    $font_name_len, $font_name);
            print OUT $font_def;
            $font_defs .= $font_def;

            # use font
            my $fnt_num;
            if ($font_num < 64) {
                $fnt_num = pack("C", $DVI_fnt_num_0 + $font_num);
            }
            # Other cases are unlikely, see above.
            elsif ($font_num < 256) {
                $fnt_num = pack("CC", $DVI_fnt1, $font_num);
            }
            elsif ($font_num < 65536) {
                $fnt_num = pack("Cn", $DVI_fnt2, $font_num);
            }
            else {
                $fnt_num = pack("CN", $DVI_fnt4, $font_num);
            }
            print OUT $fnt_num;

            # print characters
            print OUT pack("C", $DVI_push);
            foreach (split(",", $font_chars)) {
                if ($_ < 128) {
                    print OUT pack("C", $_);
                }
                else {
                    print OUT pack("CC", $DVI_set1, $_);
                }
            }
            print OUT pack("C", $DVI_pop);

            $font_num++;
        }

        print OUT pack("C", $DVI_eop);

        # Begin of postamble (post)
        my $pos_post = tell(OUT);
        print OUT pack("CN6n2",
                $DVI_post, $pos_bop, $DVI_num, $DVI_den, $DVI_mag,
                $DVI_l, $DVI_u, 1, 1);
        print OUT $font_defs;
        # End of postamble (post_post)
        print OUT pack("CNC5",
                $DVI_post_post, $pos_post, $DVI_id_byte,
                $DVI_trailing, $DVI_trailing, $DVI_trailing, $DVI_trailing);
        my $t_num = (4 - (tell(OUT) % 4)) % 4;
        print OUT pack("C", $DVI_trailing) x $t_num;
        close(OUT);
    }

    ### run dvips
    {
        print $PRT "*** run dvips\n" if $::opt_verbose;

        my $cmd = "$::opt_dvips $::opt_options $dvips_resolution $tempfile";
        print $PRT ">>> $cmd\n" if $::opt_verbose;
        # dvips writes on stderr :-(
        my @capture = `$cmd$err_redirect`;
        if ($::opt_verbose) {
            print $PRT @capture;
        }
        if ($?) {
            my $exitvalue = $?;
            if ($exitvalue > 255) {
                $exitvalue >>= 8;
                print $PRT "$Warning Closing dvips (exit status: $exitvalue)!\n";
                return @err;
            }
            print $PRT "$Warning Closing dvips ($exitvalue)!\n";
            return @err;
        }
    }

    ### get font and start part
    open(IN, $psfile) or die "$Error Cannot open `$psfile'!\n";

    while (<IN>) {
        ### get possible encoding files
        if (/^%%BeginProcSet:\s*(.+)\.enc/) {
            my $encoding_file = $1;
            print $PRT "*** encoding file `$encoding_file.enc' found.\n"
                if $::opt_debug;
            next if defined($encoding_files{$encoding_file});
            $encoding_files{$encoding_file} = "";
            $encoding_string .= $_;
            while (<IN>) {
              $encoding_string .= $_;
              last if /^%%EndProcSet/;
            }
            next;
        }

        ### get texps.pro if get_texps_pro() has failed
        if ($texps_data == 0 && /^%%BeginProcSet: texps.pro/) {
            $texps_string = $_;
            while (<IN>) {
              $texps_string .= $_;
              last if /^%%EndProcSet/;
            }
            $texps_data = 1;
            print $PRT "*** texps.pro extracted.\n" if $::opt_debug;
            next;
        }

        if (/^%%BeginFont:\s*(\S+)/) {
            $name = $1;
            $font .= $_;
            while (<IN>) {
                $font .= $_;
                last if /^%%EndFont/;
            }
            next;
        }
        if (/^\@start/) {
            s/^\@start\s*//;
            $start .= $_;
            while (<IN>) {
                last if /^%%EndProlog/;
                $start .= $_;
            }
            if (($start =~ s/\s*end\s*$/\n/) != 1) {
              $err = 1;
              print $PRT "$Warning Parse error, `end' not found!\n";
            }
            print $PRT "*** start: $start" if $::opt_debug;
            last;
        }
    }
    close(IN);

    if ($font eq "") {
        print $PRT "$Warning `%%BeginFont' not found!\n";
        return @err;
    }
    return ($name, $font, $start, $err);
}


# get_texps_pro
# return: string with content of texps.pro
sub get_texps_pro {
    $texps_data = 0;
    # get file name
    my $backupWarn = $^W;
    $^W = 0;
    my $file = `$::opt_kpsewhich $texpsfile`;
    $^W = $backupWarn;
    if (!defined($file) or $file eq "") {
        print $PRT "$Warning: Cannot find `$texpsfile' with kpsewhich!\n"
            if $::opt_debug;
        return "";
    }
    chomp $file;
    print $PRT "*** texps.pro: $file\n" if $::opt_debug;

    # read file
    local *IN;
    open(IN, $file) or die "$Error: Cannot open `$file'!\n";
    my @lines = <IN>;
    @lines > 0 or die "$Error: Empty file `$file'!\n";
    chomp $lines[@lines-1];
    my $str = "%%BeginProcSet: texps.pro\n";
    $"="";
    $str .= "@lines\n";
    $"=" ";
    $str .= "%%EndProcSet\n";
    $texps_data = 1;
    return $str;
}

__END__
