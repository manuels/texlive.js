#!/usr/bin/env perl
use strict;
$^W=1; # turn warning on
#
# pdfcrop.pl
#
# Copyright (C) 2002, 2004, 2005, 2008-2012 Heiko Oberdiek.
#
# This program may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.2
# of this license or (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.2 or later is part of all distributions of LaTeX
# version 1999/12/01 or later.
#
# See file "README" for a list of files that belong to this project.
#
# This file "pdfcrop.pl" may be renamed to "pdfcrop"
# for installation purposes.
#
my $prj         = 'pdfcrop';
my $file        = "$prj.pl";
my $program     = uc($&) if $file =~ /^\w+/;
my $version     = "1.33";
my $date        = "2012/02/01";
my $author      = "Heiko Oberdiek";
my $copyright   = "Copyright (c) 2002-2012 by $author.";
#
# Reqirements: Perl5, Ghostscript
# History:
#   2002/10/30 v1.0:  First release.
#   2002/10/30 v1.1:  Option --hires added.
#   2002/11/04 v1.2:  "nul" instead of "/dev/null" for windows.
#   2002/11/23 v1.3:  Use of File::Spec module's "devnull" call.
#   2002/11/29 v1.4:  Option --papersize added.
#   2004/06/24 v1.5:  Clear map file entries so that pdfTeX
#                     does not touch the fonts.
#   2004/06/26 v1.6:  Use mgs.exe instead of gswin32c.exe for MIKTEX.
#   2005/03/11 v1.7:  Support of spaces in file names
#                     (open("-|") is used for ghostscript call).
#   2008/01/09 v1.8:  Fix for moving the temporary file to the output
#                     file across file system boundaries.
#   2008/04/05 v1.9:  Options --resolution and --bbox added.
#   2008/07/16 v1.10: Support for XeTeX added with new options
#                     --pdftex, --xetex, and --xetexcmd.
#   2008/07/22 v1.11: Workaround for open("-|").
#   2008/07/23 v1.12: Workarounds for the workaround (error detection, ...).
#   2008/07/24 v1.13: open("-|")/workaround removed.
#                     Input files with unsafe file names are linked/copied
#                     to temporary file with safe file name.
#   2008/09/12 v1.14: Error detection for invalid Bounding Boxes.
#   2009/07/14 v1.15: Fix for negative coordinates in Bounding Boxes
#                     (David Menestrina).
#   2009/07/16 v1.16: Security fixes:
#                     * -dSAFER added for Ghostscript,
#                     * -no-shell-escape added for pdfTeX/XeTeX.
#   2009/07/17 v1.17: Security fixes:
#                     * Backticks and whitespace are forbidden
#                       for options --(gs|pdftex|xetex)cmd.
#                     * Validation of options --papersize and --resolution.
#   2009/07/18 v1.18: * Restricted mode added.
#                     * Option --version added.
#   2009/09/24 v1.19: * Ghostscript detection rewritten.
#                     * Cygwin: `gs' is preferred to `gswin32c'.
#   2009/10/06 v1.20: * File name sanitizing in .tex file.
#   2009/12/21 v1.21: * Option --ini added for IniTeX mode.
#                     * Option --luatex and --luatexcmd added for LuaTeX.
#   2009/12/29 v1.22: * Syntax description for option --bbox fixed
#                       (Lukas Prochazka).
#   2010/01/09 v1.23: * Options --bbox-odd and -bbox-even added.
#   2010/08/16 v1.24: * Workaround added for buggy ghostscript ports
#                       that print the BoundingBox data twice.
#   2010/08/26 v1.25: * Fix for the case that the PDF file contains
#                       an entry /CropBox different to /MediaBox.
#                     * \pageinclude implemented for XeTeX.
#                     * XeTeX: --clip does not die, but this option
#                       is ignored, because XeTeX always clip.
# 2010/08/26 v1.26: * XeTeX's \XeTeXpdffile expects keyword
#                     `media', not `mediabox'.
#                   * New option --pdfversion.
#                     Default is `auto' that means the PDF version
#                     is inherited from the input file. Before
#                     pdfcrop has used the TeX engine's default.
#                   * Option --luatex fixed (extra empty page at end).
# 2010/09/03 v1.27: * Workaround of v1.24 fixed.
# 2010/09/06 v1.28: * The Windows registry is searched if Ghostscript
#                     is not found via PATH.
#                   * Windows only: support of spaces in command
#                     names in unrestricted mode.
# 2010/09/06 v1.29: * Find the latest Ghostscript version in registry.
# 2010/09/15 v1.30: * Warning of pdfTeX because of \pdfobjcompresslevel
#                     avoided when reducing \pdfminorversion.
#                   * Fix for TeX syntax characters in input file names.
# 2010/09/17 v1.31: * Passing the input file name via hex string to TeX.
#                   * Again input file names restricted for Ghostscript
#                     command line, switch then to symbol link/copy
#                     method.
# 2011/08/10 v1.32: * Detection for gswin64c.exe added.
# 2012/02/01 v1.33: * Input file can be `-' (standard input).
# 2012/04/18 v1.34: * Format of --version changed
#                     from naked version number to a line with
#                     program name, date and version.

### program identification
my $title = "$program $version, $date - $copyright\n";

### error strings
my $Error = "!!! Error:"; # error prefix

### make ENV safer
delete @ENV{qw(IFS CDPATH ENV BASH_ENV)};

# Windows detection (no SIGHUP)
my $Win = 0;
$Win = 1 if $^O =~ /mswin32/i;
$Win = 1 if $^O =~ /cygwin/i;
use Config;
my $archname = $Config{'archname'};
$archname = 'unknown' unless defined $Config{'archname'};

### string constants for Ghostscript run
# get Ghostscript command name
$::opt_gscmd = '';
sub find_ghostscript () {
    return if $::opt_gscmd;
    my $system = 'unix';
    $system = "dos" if $^O =~ /dos/i;
    $system = "os2" if $^O =~ /os2/i;
    $system = "win" if $^O =~ /mswin32/i;
    $system = "cygwin" if $^O =~ /cygwin/i;
    $system = "miktex" if defined($ENV{"TEXSYSTEM"}) and
                          $ENV{"TEXSYSTEM"} =~ /miktex/i;
    print "* OS name: $^O\n" if $::opt_debug;
    print "* Arch name: $archname\n" if $::opt_debug;
    print "* System: $system\n" if $::opt_debug;
    my %candidates = (
        'unix' => [qw|gs gsc|],
        'dos' => [qw|gs386 gs|],
        'os2' => [qw|gsos2 gs|],
        'win' => [qw|gswin32c gs|],
        'cygwin' => [qw|gs gswin32c|],
        'miktex' => [qw|mgs gswin32c gs|]
    );
    if ($system eq 'win' or $system eq 'cygwin' or $system eq 'miktex') {
        if ($archname =~ /mswin32-x64/i) {
            my @a = ();
            foreach my $name (@{$candidates{$system}}) {
                push @a, 'gswin64c' if $name eq 'gswin32c';
                push @a, $name;
            }
            $candidates{$system} = \@a;
        }
    }
    my %ext = (
        'unix' => '',
        'dos' => '.exe',
        'os2' => '.exe',
        'win' => '.exe',
        'cygwin' => '.exe',
        'miktex' => '.exe'
    );
    my $candidates_ref = $candidates{$system};
    my $ext = $Config{'_exe'};
    $ext = $ext{$system} unless defined $ext;
    use File::Spec;
    my @path = File::Spec->path();
    my $found = 0;
    foreach my $candidate (@$candidates_ref) {
        foreach my $dir (@path) {
            my $file = File::Spec->catfile($dir, "$candidate$ext");
            if (-x $file) {
                $::opt_gscmd = $candidate;
                $found = 1;
                print "* Found ($candidate): $file\n" if $::opt_debug;
                last;
            }
            print "* Not found ($candidate): $file\n" if $::opt_debug;
        }
        last if $found;
    }
    if (not $found and $Win) {
        $found = SearchRegistry();
    }
    if ($found) {
        print "* Autodetected ghostscript command: $::opt_gscmd\n" if $::opt_debug;
    }
    else {
        $::opt_gscmd = $$candidates_ref[0];
        print "* Default ghostscript command: $::opt_gscmd\n" if $::opt_debug;
    }
}

sub SearchRegistry () {
    my $found = 0;
    eval 'use Win32::TieRegistry qw|KEY_READ REG_SZ|;';
    if ($@) {
        if ($::opt_debug) {
            print "* Registry lookup for Ghostscript failed:\n";
            my $msg = $@;
            $msg =~ s/\s+$//;
            foreach (split /\r?\n/, $msg) {
                print "  $_\n";
            }
        }
        return $found;
    }
    my $open_params = {Access => KEY_READ(), Delimiter => '/'};
    my $key_name_software = 'HKEY_LOCAL_MACHINE/SOFTWARE/';
    my $current_key = $key_name_software;
    my $software = new Win32::TieRegistry $current_key, $open_params;
    if (not $software) {
        print "* Cannot find or access registry key `$current_key'!\n"
                if $::opt_verbose;
        return $found;
    }
    print "* Search registry at `$current_key'.\n" if $::opt_debug;
    my %list;
    foreach my $key_name_gs (grep /Ghostscript/i, $software->SubKeyNames()) {
        $current_key = "$key_name_software$key_name_gs/";
        print "* Registry entry found: $current_key\n" if $::opt_debug;
        my $key_gs = $software->Open($key_name_gs, $open_params);
        if (not $key_gs) {
            print "* Cannot open registry key `$current_key'!\n" if $::opt_debug;
            next;
        }
        foreach my $key_name_version ($key_gs->SubKeyNames()) {
            $current_key = "$key_name_software$key_name_gs/$key_name_version/";
            print "* Registry entry found: $current_key\n" if $::opt_debug;
            if (not $key_name_version =~ /^(\d+)\.(\d+)$/) {
                print "  The sub key is not a version number!\n" if $::opt_debug;
                next;
            }
            my $version_main = $1;
            my $version_sub = $2;
            $current_key = "$key_name_software$key_name_gs/$key_name_version/";
            my $key_version = $key_gs->Open($key_name_version, $open_params);
            if (not $key_version) {
                print "* Cannot open registry key `$current_key'!\n" if $::opt_debug;
                next;
            }
            $key_version->FixSzNulls(1);
            my ($value, $type) = $key_version->GetValue('GS_DLL');
            if ($value and $type == REG_SZ()) {
                print "  GS_DLL = $value\n" if $::opt_debug;
                $value =~ s|([\\/])([^\\/]+\.dll)$|$1gswin32c.exe|i;
                my $value64 = $value;
                $value64 =~ s/gswin32c\.exe$/gswin64c.exe/;
                if ($archname =~ /mswin32-x64/i and -f $value64) {
                    $value = $value64;
                }
                if (-f $value) {
                    print "  EXE found: $value\n" if $::opt_debug;
                }
                else {
                    print "  EXE not found!\n" if $::opt_debug;
                    next;
                }
                my $sortkey = sprintf '%02d.%03d %s',
                        $version_main, $version_sub, $key_name_gs;
                $list{$sortkey} = $value;
            }
            else {
                print "  Missing key `GS_DLL' with type `REG_SZ'!\n" if $::opt_debug;
            }
        }
    }
    foreach my $entry (reverse sort keys %list) {
        $::opt_gscmd = $list{$entry};
        print "* Found (via registry): $::opt_gscmd\n" if $::opt_debug;
        $found = 1;
        last;
    }
    return $found;
}

# restricted mode
my $restricted = 0;
if ($0 =~ /rpdfcrop/ or $0 =~ /restricted/) {
    $restricted = 1;
}

# "null" device
use File::Spec::Functions qw(devnull);
my $null = devnull();

### variables
my $inputfile   = "";
my $outputfile  = "";
my $tmp = "tmp-\L$program\E-$$";

### paper sizes

my @papersizes = qw[
  11x17 ledger legal letter lettersmall
  archE archD archC archB archA
  a0 a1 a2 a3 a4 a4small a5 a6 a7 a8 a9 a10
  isob0 isob1 isob2 isob3 isob4 isob5 isob6
  c0 c1 c2 c3 c4 c5 c6
  jisb0 jisb1 jisb2 jisb3 jisb4 jisb5 jisb6
  b0 b1 b2 b3 b4 b5
  flsa flse halfletter
];
my %papersizes;
foreach (@papersizes) {
    $papersizes{$_} = 1;
}

### option variables
my @bool = ("false", "true");
$::opt_version    = 0;
$::opt_help       = 0;
$::opt_debug      = 0;
$::opt_verbose    = 0;
$::opt_pdftexcmd  = "pdftex";
$::opt_xetexcmd   = "xetex";
$::opt_luatexcmd  = "luatex";
$::opt_tex        = "pdftex";
$::opt_margins    = "0 0 0 0";
$::opt_clip       = 0;
$::opt_hires      = 0;
$::opt_papersize  = "";
$::opt_resolution = "";
$::opt_bbox       = "";
$::opt_bbox_odd   = "";
$::opt_bbox_even  = "";
$::opt_initex     = 0;
$::opt_pdfversion = "auto";

sub usage ($) {
    my $ret = shift;
    find_ghostscript();
    my $usage = <<"END_OF_USAGE";
${title}Syntax:   \L$program\E [options] <input[.pdf]> [output file]
Function: Margins are calculated and removed for each page in the file.
Options:                                                       (defaults:)
  --help              print usage
  --version           print version number
  --(no)verbose       verbose printing                         ($bool[$::opt_verbose])
  --(no)debug         debug informations                       ($bool[$::opt_debug])
  --gscmd <name>      call of ghostscript                      ($::opt_gscmd)
  --pdftex | --xetex | --luatex
                      use pdfTeX | use XeTeX | use LuaTeX      ($::opt_tex)
  --pdftexcmd <name>  call of pdfTeX                           ($::opt_pdftexcmd)
  --xetexcmd <name>   call of XeTeX                            ($::opt_xetexcmd)
  --luatexcmd <name>  call of LuaTeX                           ($::opt_luatexcmd)
  --margins "<left> <top> <right> <bottom>"                    ($::opt_margins)
                      add extra margins, unit is bp. If only one number is
                      given, then it is used for all margins, in the case
                      of two numbers they are also used for right and bottom.
  --(no)clip          clipping support, if margins are set     ($bool[$::opt_clip])
                      (not available for --xetex)
  --(no)hires         using `%%HiResBoundingBox'               ($bool[$::opt_hires])
                      instead of `%%BoundingBox'
  --(no)ini           use iniTeX variant of the TeX compiler   ($bool[$::opt_initex])
Expert options:
  --restricted        turn on restricted mode                  ($bool[$restricted])
  --papersize <foo>   parameter for gs's -sPAPERSIZE=<foo>,
                      use only with older gs versions <7.32    ($::opt_papersize)
  --resolution <xres>x<yres>                                   ($::opt_resolution)
  --resolution <res>  pass argument to ghostscript's option -r
                      Example: --resolution 72
  --bbox "<left> <bottom> <right> <top>"                       ($::opt_bbox)
                      override bounding box found by ghostscript
                      with origin at the lower left corner
  --bbox-odd          Same as --bbox, but for odd pages only   ($::opt_bbox_odd)
  --bbox-even         Same as --bbox, but for even pages only  ($::opt_bbox_even)
  --pdfversion <1.x> | auto | none
                      Set the PDF version to 1.x, 1 < x < 8.
                      If `auto' is given as value, then the
                      PDF version is taken from the header
                      of the input PDF file.
                      An empty value or `none' uses the
                      default of the TeX engine.               ($::opt_pdfversion)

Input file: If the name is `-', then the standard input is used and
  the output file name must be explicitly given.
Examples:
  \L$program\E --margins 10 input.pdf output.pdf
  \L$program\E --margins '5 10 5 20' --clip input.pdf output.pdf
In case of errors:
  Try option --verbose first to get more information.
In case of bugs:
  Please, use option --debug for bug reports.
END_OF_USAGE
    if ($ret) {
        die $usage;
    }
    else {
        print $usage;
        exit(0);
    }
}

### process options
my @OrgArgv = @ARGV;
use Getopt::Long;
GetOptions(
  "help!",
  "version!",
  "debug!",
  "verbose!",
  "gscmd=s",
  "pdftexcmd=s",
  "xetexcmd=s",
  "luatexcmd=s",
  "pdftex" => sub { $::opt_tex = 'pdftex'; },
  "xetex"  => sub { $::opt_tex = 'xetex'; },
  "luatex" => sub { $::opt_tex = 'luatex'; },
  "initex!",
  "margins=s",
  "clip!",
  "hires!",
  "papersize=s",
  "resolution=s",
  "bbox=s",
  "bbox-odd=s" => \$::opt_bbox_odd,
  "bbox-even=s" => \$::opt_bbox_even,
  "restricted" => sub { $restricted = 1; },
  "pdfversion=s" => \$::opt_pdfversion,
) or usage(1);
!$::opt_help or usage(0);

if ($::opt_version) {
    print "$prj $date v$version\n";
    exit(0);
}

$::opt_verbose = 1 if $::opt_debug;

@ARGV >= 1 or usage(1);

print $title;

print "* Restricted mode: ", ($restricted ? "enabled" : "disabled"), "\n"
        if $::opt_debug;

$::opt_pdfversion =~ /^(|none|auto|1\.([2-7]))$/
        or die "!!! Error: Invalid value `$::opt_pdfversion' for option `--pdfversion'!\n";
print "* Option `pdfversion': $::opt_pdfversion\n" if $::opt_debug;
$::opt_pdfversion = $2 if $2;
$::opt_pdfversion = '' if $::opt_pdfversion eq 'none';

find_ghostscript();

if ($::opt_bbox) {
    $::opt_bbox =~ s/^\s+//;
    $::opt_bbox =~ s/\s+$//;
    $::opt_bbox =~ s/\s+/ /;
    if ($::opt_bbox =~ /^-?\d*\.?\d+ -?\d*\.?\d+ -?\d*\.?\d+ -?\d*\.?\d+$/) {
        print "* Explicite Bounding Box: $::opt_bbox\n" if $::opt_debug;
    }
    else {
        die "$Error Parse error (option --bbox \"$::opt_bbox\")!\n";
    }
}
if ($::opt_bbox_odd) {
    $::opt_bbox_odd =~ s/^\s+//;
    $::opt_bbox_odd =~ s/\s+$//;
    $::opt_bbox_odd =~ s/\s+/ /;
    if ($::opt_bbox_odd =~ /^-?\d*\.?\d+ -?\d*\.?\d+ -?\d*\.?\d+ -?\d*\.?\d+$/) {
        print "* Explicite Bounding Box for odd pages: $::opt_bbox_odd\n"
                if $::opt_debug;
    }
    else {
        die "$Error Parse error (option --bbox-odd \"$::opt_bbox_odd\")!\n";
    }
}
if ($::opt_bbox_even) {
    $::opt_bbox_even =~ s/^\s+//;
    $::opt_bbox_even =~ s/\s+$//;
    $::opt_bbox_even =~ s/\s+/ /;
    if ($::opt_bbox_even =~ /^-?\d*\.?\d+ -?\d*\.?\d+ -?\d*\.?\d+ -?\d*\.?\d+$/) {
        print "* Explicite Bounding Box for even pages: $::opt_bbox_even\n"
                if $::opt_debug;
    }
    else {
        die "$Error Parse error (option --bbox-even \"$::opt_bbox_even\")!\n";
    }
}

@ARGV <= 2 or die "$Error Too many files!\n";

### input file
$inputfile = shift @ARGV;

if ($inputfile eq '-') {
    @ARGV == 1 or die "$Error Missing output file name!\n";
    print "* Input file: <stdin>\n" if $::opt_debug;
}
else {
    if (! -f $inputfile) {
        if (-f "$inputfile.pdf") {
            $inputfile .= ".pdf";
        }
        else {
            die "$Error Input file `$inputfile' not found!\n";
        }
    }
    print "* Input file: $inputfile\n" if $::opt_debug;
}

### output file
if (@ARGV) {
    $outputfile = shift @ARGV;
}
else {
    $outputfile = $inputfile;
    $outputfile =~ s/\.pdf$//i;
    $outputfile .= "-crop.pdf";
}

print "* Output file: $outputfile\n" if $::opt_debug;

### margins
my ($llx, $lly, $urx, $ury) = (0, 0, 0, 0);
if ($::opt_margins =~
        /^\s*([\-\.\d]+)\s+([\-\.\d]+)\s+([\-\.\d]+)\s+([\-\.\d]+)\s*$/) {
    ($llx, $lly, $urx, $ury) = ($1, $2, $3, $4);
}
else {
    if ($::opt_margins =~ /^\s*([\-\.\d]+)\s+([\-\.\d]+)\s*$/) {
        ($llx, $lly, $urx, $ury) = ($1, $2, $1, $2);
    }
    else {
        if ($::opt_margins =~ /^\s*([\-\.\d]+)\s*$/) {
            ($llx, $lly, $urx, $ury) = ($1, $1, $1, $1);
        }
        else {
            die "$Error Parse error (option --margins)!\n";
        }
    }
}
print "* Margins: $llx $lly $urx $ury\n" if $::opt_debug;

### papersize validation (security)
if ($::opt_papersize ne '') {
    $::opt_papersize =~ /^[0-9A-Za-z]+$/
            or die "$Error Invalid papersize ($::opt_papersize)!\n";
    $papersizes{$::opt_papersize}
            or die "$Error Unknown papersize ($::opt_papersize),"
                   . " see ghostscript's documentation for option `-r'!\n";
}

### resolution validation (security)
if ($::opt_resolution ne '') {
    $::opt_resolution =~ /^\d+(x\d+)?$/
            or die "$Error Invalid resolution ($::opt_resolution),"
                   . " see ghostscript's documentation!\n";
}

### command name validation (security)
my %cmd = (
    'gscmd' => \$::opt_gscmd,
    'pdftexcmd' => \$::opt_pdftexcmd,
    'luatexcmd' => \$::opt_luatexcmd,
    'xetexcmd' => \$::opt_xetexcmd
);
foreach my $cmd (keys %cmd) {
    my $cmd_ref = $cmd{$cmd};
    $$cmd_ref =~ s/^\s+//;
    $$cmd_ref =~ s/\s+$//;
    my $val = $$cmd_ref;
    next unless $val;
    next unless $val;
    if ($val =~ /`/) {
        die "$Error Forbidden backtick for option `--$cmd' ($val)!\n";
    }
    if ($val =~ /\s/) {
        my $err = 0;
        if ($restricted or not $Win) {
            $err = 1;
        }
        else {
            $err = 1 if $val =~ /\.exe.*\s/i;
            $err = 1 if $val =~ /\s[-\/@+]/;
        }
        die "$Error Forbidden whitespace for option `--$cmd' ($val)!\n" if $err;
    }
}
if ($restricted) {
    if ($::opt_pdftexcmd and $::opt_pdftexcmd ne 'pdftex') {
        die "$Error pdfTeX program name must not be changed in restricted mode!\n";
    }
    if ($::opt_xetexcmd and $::opt_xetexcmd ne 'xetex') {
        die "$Error XeTeX program name must not be changed in restricted mode!\n";
    }
    if ($::opt_luatexcmd and $::opt_luatexcmd ne 'luatex') {
        die "$Error LuaTeX program name must not be changed in restricted mode!\n";
    }
    if ($::opt_gscmd) {
        $::opt_gscmd =~ /^(gs|mgs|gswin32c|gs386|gsos2)$/
        or $::opt_gscmd =~ /^gs[\-_]?(\d|\d[\.-_]?\d\d)c?$/
        or die "$Error: Invalid Ghostscript program name in restricted mode!\n";
    }
}
if ($Win and $::opt_gscmd =~ /\s/) {
    $::opt_gscmd = "\"$::opt_gscmd\"";
}

### cleanup system
my @unlink_files = ();
my $exit_code = 1;
sub clean {
    print "* Cleanup\n" if $::opt_debug;
    if ($::opt_debug) {
        print "* Temporary files: @unlink_files\n";
    }
    else {
        for (; @unlink_files>0; ) {
            unlink shift @unlink_files;
        }
    }
}
sub cleanup {
    clean();
    exit($exit_code);
}
$SIG{'INT'} = \&cleanup;
$SIG{'__DIE__'} = \&clean;

### Calculation of BoundingBoxes

# use safe file name for use within cmd line of gs (unknown shell: space, ...)
# and XeTeX (hash, curly braces, ...)
my $inputfilesafe = $inputfile;
if ($inputfile eq '-') {
    $inputfilesafe = "$tmp-stdin.pdf";
    print "* Temporary input file: $inputfilesafe\n" if $::opt_debug;
    push @unlink_files, $inputfilesafe;
    open(OUT, '>', $inputfilesafe) or die "$Error Cannot write `$inputfilesafe'!\n";
    binmode(OUT);
    my $size = 0;
    my $len = 0;
    my $buf = '';
    my $buf_size = 65536;
    do {
        $len = read STDIN, $buf, $buf_size;
        if (not defined $len) {
            my $msg = $!;
            chomp $msg;
            die "$Error Reading standard input ($msg)!\n";
        }
        print OUT $buf or die "$Error Writing `$inputfilesafe'!\n";
        $size += $len;
    }
    while ($len);
    close(OUT);
    print "* File size (STDIN): $size\n" if $::opt_debug;
}
elsif (not $inputfile =~ /^[\w\d\.\-\:\/@]+$/) { # /[\s\$~'"#{}%]/
    $inputfilesafe = "$tmp-img.pdf";
    push @unlink_files, $inputfilesafe;
    my $symlink_exists = eval { symlink("", ""); 1 };
    print "* Input file name `$inputfile' contains special characters.\n"
          . "* " . ($symlink_exists ? "Link" : "Copy")
          . " input file to temporary file `$inputfilesafe'.\n"
            if $::opt_verbose;
    if ($symlink_exists) {
        symlink($inputfile, $inputfilesafe)
            or die "$Error Link from `$inputfile' to"
                   . " `$inputfilesafe' failed: $!\n";
    }
    else {
        use File::Copy;
        copy($inputfile, $inputfilesafe)
                or die "$Error Copy from `$inputfile' to"
                       . " `$inputfilesafe' failed: $!\n";
    }
}

if ($::opt_pdfversion eq 'auto') {
    open(IN, '<', $inputfilesafe) or die "!!! Error: Cannot open `$inputfilesafe'!\n";
    my $buf;
    read(IN, $buf, 1024) or die "!!! Error: Cannot read the header of `$inputfilesafe' failed!\n";
    close(IN);
    if ($buf =~ /%PDF-1.([0-7])\s/) {
        $::opt_pdfversion = $1;
        print "* PDF header: %PDF-1.$::opt_pdfversion\n" if $::opt_verbose;
        $::opt_pdfversion = 2 if $::opt_pdfversion < 2;
    }
    else {
        die "!!! Error: Cannot find PDF header of `$inputfilesafe'!\n";
    }
}
print '* Using PDF minor version: ',
      ($::opt_pdfversion ? $::opt_pdfversion : "engine's default"),
      "\n" if $::opt_debug;

my @gsargs = (
    "-sDEVICE=bbox",
    "-dBATCH",
    "-dNOPAUSE"
);
push @gsargs, "-sPAPERSIZE=$::opt_papersize" if $::opt_papersize;
push @gsargs, "-r$::opt_resolution" if $::opt_resolution;
push @gsargs,
    "-c",
    "save",
    "pop",
    "-f",
    $inputfilesafe
;

my $tmpfile = "$tmp.tex";
push @unlink_files, $tmpfile;
open(TMP, ">$tmpfile") or
    die "$Error Cannot write tmp file `$tmpfile'!\n";
print TMP <<'END_TMP';
\catcode37 14 % percent
\catcode33 12 % exclam
\catcode34 12 % quote
\catcode35  6 % hash
\catcode39 12 % apostrophe
\catcode40 12 % left parenthesis
\catcode41 12 % right parenthesis
\catcode45 12 % minus
\catcode46 12 % period
\catcode60 12 % less
\catcode61 12 % equals
\catcode62 12 % greater
\catcode64 12 % at
\catcode91 12 % left square
\catcode93 12 % right square
\catcode96 12 % back tick
\catcode123 1 % left curly brace
\catcode125 2 % right curly brace
\catcode126 12 % tilde
\catcode`\#=6 %
\escapechar=92 %
\def\IfUndefined#1#2#3{%
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname#1\endcsname\relax
    #2%
  \else
    #3%
  \fi
}
END_TMP
my $pdffilehex = unpack 'H*', $inputfilesafe;
$pdffilehex = "\U$pdffilehex\E";
print TMP "\\def\\pdffilehex{$pdffilehex}\n";
print TMP <<'END_TMP';
\IfUndefined{pdfunescapehex}{%
  \begingroup
    \gdef\pdffile{}%
    \def\do#1#2{%
      \ifx\relax#2\relax
        \ifx\relax#1\relax
        \else
          \errmessage{Invalid hex string, should not happen!}%
        \fi
      \else
        \lccode`0="#1#2\relax
        \lowercase{%
          \xdef\pdffile{\pdffile0}%
        }%
        \expandafter\do
      \fi
    }%
    \expandafter\do\pdffilehex\relax\relax
  \endgroup
}{%
  \edef\pdffile{\pdfunescapehex{\pdffilehex}}%
}
\immediate\write-1{Input file: \pdffile}
END_TMP
if ($::opt_tex eq 'luatex') {
    print TMP <<'END_TMP';
\begingroup\expandafter\expandafter\expandafter\endgroup
\expandafter\ifx\csname directlua\endcsname\relax
  \errmessage{LuaTeX not found!}%
\else
  \begingroup
    \newlinechar=10 %
    \endlinechar=\newlinechar %
    \ifnum0%
        \directlua{%
          if tex.enableprimitives then
            tex.enableprimitives('TEST', {
              'luatexversion',
              'pdfoutput',
              'pdfcompresslevel',
              'pdfhorigin',
              'pdfvorigin',
              'pdfpagewidth',
              'pdfpageheight',
              'pdfmapfile',
              'pdfximage',
              'pdflastximage',
              'pdfrefximage',
              'pdfminorversion',
              'pdfobjcompresslevel',
            })
            tex.print('1')
          end
        }%
        \ifx\TESTluatexversion\UnDeFiNeD\else 1\fi %
        =11 %
      \global\let\luatexversion\luatexversion %
      \global\let\pdfoutput\TESTpdfoutput %
      \global\let\pdfcompresslevel\TESTpdfcompresslevel %
      \global\let\pdfhorigin\TESTpdfhorigin %
      \global\let\pdfvorigin\TESTpdfvorigin %
      \global\let\pdfpagewidth\TESTpdfpagewidth %
      \global\let\pdfpageheight\TESTpdfpageheight %
      \global\let\pdfmapfile\TESTpdfmapfile %
      \global\let\pdfximage\TESTpdfximage %
      \global\let\pdflastximage\TESTpdflastximage %
      \global\let\pdfrefximage\TESTpdfrefximage %
      \global\let\pdfminorversion\TESTpdfminorversion %
      \global\let\pdfobjcompresslevel\TESTpdfobjcompresslevel %
    \else %
      \errmessage{%
        Missing \string\luatexversion %
      }%
    \fi %
  \endgroup %
\fi
END_TMP
}
if ($::opt_tex eq 'pdftex' or $::opt_tex eq 'luatex') {
    print TMP <<'END_TMP_HEAD';
\pdfoutput=1 %
\pdfcompresslevel=9 %
\csname pdfmapfile\endcsname{}
\def\setpdfversion#1{%
  \IfUndefined{pdfobjcompresslevel}{%
  }{%
    \ifnum#1<5 %
      \pdfobjcompresslevel=0 %
    \else
      \pdfobjcompresslevel=2 %
    \fi
  }%
  \IfUndefined{pdfminorversion}{%
    \IfUndefined{pdfoptionpdfminorversion}{%
    }{%
      \pdfoptionpdfminorversion=#1\relax
    }%
  }{%
    \pdfminorversion=#1\relax
  }%
}
\def\page #1 [#2 #3 #4 #5]{%
  \count0=#1\relax
  \setbox0=\hbox{%
    \pdfximage page #1 mediabox{\pdffile}%
    \pdfrefximage\pdflastximage
  }%
  \pdfhorigin=-#2bp\relax
  \pdfvorigin=#3bp\relax
  \pdfpagewidth=#4bp\relax
  \advance\pdfpagewidth by -#2bp\relax
  \pdfpageheight=#5bp\relax
  \advance\pdfpageheight by -#3bp\relax
  \ht0=\pdfpageheight
  \shipout\box0\relax
}
\def\pageclip #1 [#2 #3 #4 #5][#6 #7 #8 #9]{%
  \count0=#1\relax
  \dimen0=#4bp\relax \advance\dimen0 by -#2bp\relax
  \edef\imagewidth{\the\dimen0}%
  \dimen0=#5bp\relax \advance\dimen0 by -#3bp\relax
  \edef\imageheight{\the\dimen0}%
  \pdfximage page #1 mediabox{\pdffile}%
  \setbox0=\hbox{%
    \kern -#2bp\relax
    \lower #3bp\hbox{\pdfrefximage\pdflastximage}%
  }%
  \wd0=\imagewidth\relax
  \ht0=\imageheight\relax
  \dp0=0pt\relax
  \pdfhorigin=#6pt\relax
  \pdfvorigin=#7bp\relax
  \pdfpagewidth=\imagewidth
  \advance\pdfpagewidth by #6bp\relax
  \advance\pdfpagewidth by #8bp\relax
  \pdfpageheight=\imageheight\relax
  \advance\pdfpageheight by #7bp\relax
  \advance\pdfpageheight by #9bp\relax
  \pdfxform0\relax
  \shipout\hbox{\pdfrefxform\pdflastxform}%
}%
\def\pageinclude#1{%
  \pdfhorigin=0pt\relax
  \pdfvorigin=0pt\relax
  \pdfximage page #1 mediabox{\pdffile}%
  \setbox0=\hbox{\pdfrefximage\pdflastximage}%
  \pdfpagewidth=\wd0\relax
  \pdfpageheight=\ht0\relax
  \advance\pdfpageheight by \dp0\relax
  \shipout\hbox{%
    \raise\dp0\box0\relax
  }%
}
END_TMP_HEAD
    print TMP "\\setpdfversion{$::opt_pdfversion}\n" if $::opt_pdfversion;
}
else { # XeTeX
    print TMP <<'END_TMP_HEAD';
\expandafter\ifx\csname XeTeXpdffile\endcsname\relax
  \errmessage{XeTeX not found or too old!}%
\fi
\def\page #1 [#2 #3 #4 #5]{%
  \count0=#1\relax
  \setbox0=\hbox{%
    \XeTeXpdffile "\pdffile" page #1 media\relax
  }%
  \pdfpagewidth=#4bp\relax
  \advance\pdfpagewidth by -#2bp\relax
  \pdfpageheight=#5bp\relax
  \advance\pdfpageheight by -#3bp\relax
  \shipout\hbox{%
    \kern-1in%
    \kern-#2bp%
    \vbox{%
      \kern-1in%
      \kern#3bp%
      \ht0=\pdfpageheight
      \box0 %
    }%
  }%
}
\def\pageclip #1 [#2 #3 #4 #5][#6 #7 #8 #9]{%
  \page {#1} [#2 #3 #4 #5]%
}
\def\pageinclude#1{%
  \setbox0=\hbox{%
    \XeTeXpdffile "\pdffile" page #1 media\relax
  }%
  \pdfpagewidth=\wd0\relax
  \pdfpageheight=\ht0\relax
  \advance\pdfpageheight by \dp0\relax
  \shipout\hbox{%
    \kern-1in%
    \vbox{%
      \kern-1in%
      \ht0=\pdfpageheight
      \box0 %
    }%
  }%
}
END_TMP_HEAD
}

print "* Running ghostscript for BoundingBox calculation ...\n"
    if $::opt_verbose;
print "* Ghostscript call: $::opt_gscmd @gsargs\n" if $::opt_debug;

my @bbox;
my @bbox_all;
my @bbox_odd;
my @bbox_even;
if ($::opt_bbox) {
     $::opt_bbox =~ /([-\d\.]+) ([-\d\.]+) ([-\d\.]+) ([-\d\.]+)/;
     @bbox_all = ($1, $2, $3, $4);
}
if ($::opt_bbox_odd) {
     $::opt_bbox_odd =~ /([-\d\.]+) ([-\d\.]+) ([-\d\.]+) ([-\d\.]+)/;
     @bbox_odd = ($1, $2, $3, $4);
}
if ($::opt_bbox_even) {
     $::opt_bbox_even =~ /([-\d\.]+) ([-\d\.]+) ([-\d\.]+) ([-\d\.]+)/;
     @bbox_even = ($1, $2, $3, $4);
}

sub getbbox ($$$$$) {
    my $page = shift;
    my $a = shift;
    my $b = shift;
    my $c = shift;
    my $d = shift;
    if ($page % 2 == 1) {
        if ($::opt_bbox_odd) {
            return @bbox_odd;
        }
    }
    else {
        if ($::opt_bbox_even) {
            return @bbox_even;
        }
    }
    if ($::opt_bbox) {
        return @bbox_all;
    }
    return ($a, $b, $c, $d);
}
my $page = 0;
my $gs_pipe = "$::opt_gscmd -dSAFER @gsargs 2>&1";
$gs_pipe .= " 1>$null" unless $::opt_verbose;
$gs_pipe .= "|";

open(GS, $gs_pipe) or
        die "$Error Cannot call ghostscript ($::opt_gscmd)!\n";
my $bb = ($::opt_hires) ? "%%HiResBoundingBox" : "%%BoundingBox";
my $previous_line = 'Previous line';
# Ghostscript workaround for buggy ports that prints
# the bounding box data twice on STDERR.
while (<GS>) {
    print $_ if $::opt_verbose;
    if (/^$bb:\s*(-?[\.\d]+) (-?[\.\d]+) (-?[\.\d]+) (-?[\.\d]+)/o) {
    }
    else {
        $previous_line = $_;
        next;
    }
    next if $previous_line eq $_;
    $previous_line = $_;
    $page++;
    @bbox = getbbox($page, $1, $2, $3, $4);

    my $empty = 0;
    $empty = 1 if $bbox[0] >= $bbox[2];
    $empty = 1 if $bbox[1] >= $bbox[3];
    if ($empty) {
        print <<"END_WARNING";

!!! Warning: Empty Bounding Box is returned by Ghostscript!
!!!   Page $page: @bbox
!!! Either there is a problem with the page or with Ghostscript.
!!! Recovery is tried by embedding the page in its original size.

END_WARNING
        print TMP "\\pageinclude{$page}\n";
        next;
    }

    print "* Page $page: @bbox\n" if $::opt_verbose;

    my @bb = ($bbox[0] - $llx, $bbox[1] - $ury,
             $bbox[2] + $urx, $bbox[3] + $lly);

    $empty = 0;
    $empty = 1 if $bb[0] >= $bb[2];
    $empty = 1 if $bb[1] >= $bb[3];
    if ($empty) {
        print <<"END_WARNING";

!!! Warning: The final Bounding Box is empty!
!!!   Page: $page: @bb
!!! Probably caused by too large negative margin values.
!!! Recovery by ignoring margin values.

END_WARNING
        print TMP "\\page $page [@bbox]\n";
        # clipping shouldn't make a difference
        next;
    }
    if ($::opt_clip) {
        print TMP "\\pageclip $page [@bbox][$llx $lly $urx $ury]\n";
    }
    else {
        print TMP "\\page $page [@bb]\n";
    }
}
close(GS);

if ($? & 127) {
    die sprintf  "$Error Ghostscript died with signal %d!\n",
                 ($? & 127);
}
elsif ($? != 0) {
    die sprintf "$Error Ghostscript exited with error code %d!\n",
                $? >> 8;
}

print TMP "\\csname \@\@end\\endcsname\n\\end\n";
close(TMP);

if ($page == 0) {
    die "$Error Ghostscript does not report bounding boxes!\n";
}

### Run pdfTeX/XeTeX

push @unlink_files, "$tmp.log";
my $cmd;
my $texname;
if ($::opt_tex eq 'pdftex') {
    $cmd = $::opt_pdftexcmd;
    $texname = 'pdfTeX';
}
elsif ($::opt_tex eq 'luatex') {
    $cmd = $::opt_luatexcmd;
    $texname = 'LuaTeX';
}
else {
    $cmd = $::opt_xetexcmd;
    $texname = 'XeTeX';
}
$cmd = "\"$cmd\"" if $Win and $cmd =~ /\s/;
$cmd .= ' -no-shell-escape';
if ($::opt_initex) {
    $cmd .= ' --ini --etex';
}
if ($::opt_verbose) {
    $cmd .= " -interaction=nonstopmode $tmp";
}
else {
    $cmd .= " -interaction=batchmode $tmp";
}
print "* Running $texname ...\n" if $::opt_verbose;
print "* $texname call: $cmd\n" if $::opt_debug;
if ($::opt_verbose) {
    system($cmd);
}
else {
    `$cmd`;
}
if ($?) {
    die "$Error $texname run failed!\n";
}

### Check pdf version of temp file
if ($::opt_pdfversion) {
    open(PDF, '+<', "$tmp.pdf") or die "!!! Error: Cannot open `$tmp.pdf'!\n";
    my $header;
    read PDF, $header, 9 or die "!!! Error: Cannot read header of `$tmp.pdf'!\n";
    $header =~ /^%PDF-1\.(\d)\s$/ or die "!!! Error: Cannot find header of `$tmp.pdf'!\n";
    if ($1 ne $::opt_pdfversion) {
        seek PDF, 7, 0 or die "!!! Error: Cannot seek in `$tmp.pdf'!\n";
        print PDF $::opt_pdfversion or die "!!! Error: Cannot write in `$tmp.pdf'!\n";
        print "* PDF version correction in output file: 1.$::opt_pdfversion\n"
                if $::opt_debug;
    }
    close(PDF);
}

### Move temp file to output
if (!rename("$tmp.pdf", $outputfile)) {
    use File::Copy;
    move "$tmp.pdf", $outputfile or
            die "$Error Cannot move `$tmp.pdf' to `$outputfile'!\n";
}

print "==> $page page", (($page == 1) ? "" : "s"),
      " written on `$outputfile'.\n";

$exit_code = 0;
cleanup();

__END__
