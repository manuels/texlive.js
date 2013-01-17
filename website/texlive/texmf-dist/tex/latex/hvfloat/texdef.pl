#!/usr/bin/env perl
################################################################################
#  texdef -- Show definitions of TeX commands
#  Copyright (c) 2011-2012 Martin Scharrer <martin@scharrer-online.de>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################
use strict;
use warnings;
use File::Temp qw/tempdir/; 
use File::Basename;
use Cwd;

my ($scriptname) = fileparse($0, qw(\.pl \.perl));

my $TEX = 'pdflatex';
if ($scriptname =~ /^(.*)def$/) {
    $TEX = $1;
}
my $TEXOPTIONS = " -interaction nonstopmode ";

## Variables for options and settings
my $CLASS      = undef;
my $USERCLASS  = 0;
my @PACKAGES   = ();
my @OTHERDEFS  = ();
my $INPREAMBLE = 0;
my $PRINTVERSION = 0;
my $TMPDIR     = '';
my $SHOWVALUE  = 0;
my $ISENVIRONMENT = 0;
my $PRINTORIGDEF  = 0;
my $FINDDEF    = 0;
my $LISTCMD    = 0;
my $LISTCMDDEF = 0;
my $BEFORECLASS = 0;
my $PGFKEYS      = 0;
my $PGFKEYSPLAIN = 0;
my $FAKECMD    = "\0FAKECOMMAND\0";
my $EDIT = 0;
my $EDITOR;
my $EDITORCMDLN;
my @ENVCODE = ();
my %DEFS;
my $LISTSTR = '@TEXDEF@LISTDEFS@'; # used as a dummy command to list definitions
my @FILES; # List of files (sty, cls, ...)
my @FILEORDER; # Order of files
my %ALIAS; # list of aliases; required for registers
my $currfile = ''; # current file name
# Operating system:
my $OS = $^O;
my $WINDOWS = ($OS =~ /MSWin/);

my @IGNOREDEFREG = (# List of definitions to be ignored. Can be a regex or string
   qr/^ver\@.*\.(?:sty|cls)$/,
   qr/^opt\@.*\.(?:sty|cls)$/,
   qr/^reserved\@[a-z]$/,
   qr/-h\@\@k$/,
   qr/^catcode\d+$/,
   qr/^l\@ngrel\@x$/,
   qr/^\@temp/,
   qr/^KV\@/,
   qr/^KVO\@/,
   qr/^KVOdyn\@/,
   qr/^KVS\@/,
   qr/^currfile/,
   qr/^filehook\@atbegin\@/,
   qr/^filehook\@atend\@/,
   qr/^count\d+$/,
   qr/^pgfk@\//
);
my %IGNOREDEF = map { $_ => 1 } qw(
   usepackage RequirePackage documentclass LoadClass  @classoptionslist
   CurrentOption tracingassigns in@@ escapechar
   @unprocessedoptions @let@token @gtempa @filelist @filef@und 
   @declaredoptions @currnamestack @currname @currext
   @ifdefinable default@ds ds@ @curroptions
   filename@area filename@base filename@ext
);

## Adds arguments to %IGNOREDEF
sub addignore {
  my $opt  = shift;
  my $arg  = shift;
  my @args = split (/,/, $arg);
  if ($opt eq 'ignore-cmds') {
    @IGNOREDEF{@args} = (1) x scalar @args;
  }
  else {
    push @IGNOREDEFREG, map { qr/$_/ } @args;
  }
}

use Getopt::Long;
my $data = "file.dat";
my $length = 24;
my $verbose;

my $ISLATEX = 0;
my $ISTEX   = 0;
my $ISCONTEXT = 0;

my $BEGINENVSTR = '%s';
my $ENDENVSTR   = '%s';

my $VERSION = 'Version 1.7b -- 2012/05/15';
sub usage {
    my $option = shift;
    my $ret    = ($option) ? 0 : 1;
print << 'EOT';
texdef -- Show definitions of TeX commands
Version 1.7b -- 2012/05/15
Copyright (C) 2011-2012  Martin Scharrer <martin@scharrer-online.de>
This program comes with ABSOLUTELY NO WARRANTY;
This is free software, and you are welcome to redistribute it under certain conditions;

Usage:
  texdef   [options] commandname [commandname ...]
  latexdef [options] commandname [commandname ...]

Other program names are possible. See the 'tex' option.  Command names do not need to start with `\`.

Options:
  --tex <format>, -t <format>   : Use given format of TeX: 'tex', 'latex', 'context'.
                                  Variations of 'tex' and 'latex', like 'luatex', 'lualatex', 'xetex', 'xelatex' are supported.
                                  The default is given by the used program name: 'texdef' -> 'tex', 'latexdef' -> 'latex', etc.
  --source, -s                  : Try to show the original source code of the command definition (L).
  --value, -v                   : Show value of command instead (i.e. \the\command).
  --Environment, -E             : Every command name is taken as an environment name. This will show the definition of
                                  both \Macro\foo and \Macro\endfoo if \texttt{foo} is used as command name (L).
  --preamble, -P                : Show definition of the command inside the preamble.
  --beforeclass, -B             : Show definition of the command before \documentclass.
  --package <pkg>, -p <pkg>     : (M) Load given tex-file, package or module depending on whether '*tex', '*latex'
                                  or 'context' is used. For LaTeX the <pkg> can start with `[<options>]` and end 
                                  with `<pkgname>` or `{<pkgname>}`.
  --class <class>, -c <class>   : (LaTeX only) Load given class instead of default ('article').
                                  The <class> can start with `[<classs options>]` and end 
                                  with `<classname>` or `{<classname>}`.
  --environment <env>, -e <env> : (M) Show definition inside the given environment <env>.
  --othercode <code>, -o <code> : (M) Add other code into the preamble before the definition is shown.
                                  This can be used to e.g. load PGF/TikZ libraries.
  --before <code>, -b <code>    : (M) Place <code> before definition is shown.
                                  The <code> can be arbitray TeX code and doesn't need be be balanced.
  --after  <code>, -a <code>    : (M) Place <code> after definition is shown.
                                  The <code> can be arbitray TeX code and doesn't need be be balanced.
  --find, -f                    : Find file where the command sequence was defined (L).
  --Find, -F                    : Show full filepath of the file where the command sequence was defined (L).
  --list, -l                    : List user level command sequences of the given packages (L).
  --list-defs, -L               : List user level command sequences and their shorten definitions of the given packages (L).
  --list-all, -ll               : List all command sequences of the given packages (L).
  --list-defs-all, -LL          : List all command sequences and their shorten definitions of the given packages (L).
  --ignore-cmds <cs,cs,..>,  -i : Ignore the following command sequence(s) in the above lists. (M)
  --ignore-regex <regex,..>, -I : Ignore all command sequences in the above lists which match the given Perl regular expression(s). (M)
  --pgf-keys, -k                : Takes commands as pgfkeys and displays their definitions. Keys must use the full path but the common '.\@cmd' prefix is applied.
  --pgf-Keys, -K                : Takes commands as pgfkeys and displays their definitions. Keys must use the full path.
  --version, -V                 : If used alone prints version of this script.
                                  (L) Together with -p or -c prints version of LaTeX package(s) or class, respectively.
  --edit                        : Opens the file holding the macro definition. Uses --Find and --source. (L)
                                  If the source definition can not be found the definition is printed as normal instead.
  --editor <editor>             : Can be used to set the used editor. If not used the environment variables TEXDEF_EDITOR, EDITOR and
                                  SELECTED_EDITOR are read in this order. If none of these are set a list of default
                                  editors are tried.  The <editor> string can include '%f' for the filename, '%n' for
                                  the line number and '%%' for a literal '%'.  If no '%' is used '+%n %f' is added to
                                  the given command.
  --tempdir <directory>         : Use given existing directory for temporary files.
  --help, -h                    : Print this help and quit.

 Long option can be shorten as long the are still unique.  Short options can be combined.
 If the option 'environment', 'before' and 'after' are used toegether the
 produced code will be inserted in the given order (reversed order for 'after').
 (M) = This option can be given multiple times.
 (L) = LaTeX only. Requires the packages 'filehook' and 'currfile'.

Examples:
Show the definition of '\chapter' with different classes ('article' (default), 'book' and 'scrbook'):

    latexdef chapter
    latexdef -c book chapter
    latexdef -c scrbook chapter

Show value of `\textwidth` with different class options:

    latexdef -c [a4paper]{book} -v paperwidth
    latexdef -c [letter]{book}  -v paperwidth

Show definition of TikZ's '\draw' outside and inside a 'tikzpicture' environment:

    latexdef -p tikz draw
    latexdef -p tikz --env tikzpicture draw

Show definition of TikZ's '\draw' inside a node, inside a 'beamer' frame in 'handout' mode:

    latexdef -c [handout]beamer -p tikz --env frame --env tikzpicture -b '\node {' -a '};' draw

List all user level command sequences (macros) defined by the 'xspace' LaTeX package:

    latexdef -l -p xspace

EOT
  exit ($ret);
}

sub envcode {
  my $opt = shift;
  my $arg = shift;
  push @ENVCODE, [ $opt, $arg ];
}

## Define and process options
Getopt::Long::Configure ("bundling");
GetOptions (
   'value|v!' => \$SHOWVALUE,
   'Environment|E!' => \$ISENVIRONMENT,
   'version|V!' => \$PRINTVERSION,
   'tempdir=s' => \$TMPDIR,
   'find|f!' => sub { $FINDDEF = 1 },
   'Find|F!' => sub { $FINDDEF = 2 },
   'source|s!' => \$PRINTORIGDEF,
   'list|l' => sub { $LISTCMD++ },
   'list-def|L' => sub { $LISTCMDDEF++ },
   'list-all' => sub { $LISTCMD=2 },
   'list-def-all' => sub { $LISTCMDDEF=2 },
   'ignore-cmds|i=s' => \&addignore,
   'ignore-regex|I=s' => \&addignore,
   'no-list|no-l' => sub { $LISTCMD=0; $LISTCMDDEF=0; },
   'no-list-def|no-L' => sub { $LISTCMDDEF=0 },
   'no-list-all|no-ll' => sub { $LISTCMD=0; $LISTCMDDEF=0; },
   'no-list-def-all|no-LL' => sub { $LISTCMDDEF=0 },
   'preamble|P!' => \$INPREAMBLE,
   'beforeclass|B!' => \$BEFORECLASS,
   'class|c=s' => \$CLASS,
   'package|p=s' => \@PACKAGES,
   'otherdefs|o=s' => \@OTHERDEFS,
   'environment|e=s' => \&envcode,
   'before|b=s' => \&envcode,
   'after|a=s' => \&envcode,
   'tex|t=s' => \$TEX,
   'help|h' => \&usage,
   'pgf-keys|k' => \$PGFKEYS,
   'pgf-Keys|K' => \$PGFKEYSPLAIN,
   'edit!' => sub { $EDIT=1; $FINDDEF = 2; $PRINTORIGDEF = 1; },
   'editor=s' => \$EDITOR,
) || usage();

# usage() unless @ARGV;

if ($EDIT && !$EDITOR) {
    $EDITOR = $ENV{'TEXDEF_EDITOR'} || $ENV{'EDITOR'} || $ENV{'SELECTED_EDITOR'};
    if (!$EDITOR) {
        if (!$WINDOWS && exists $ENV{HOME}) {
        # Check ~/.selected_editor file (Ubuntu)
        my $fn = "$ENV{HOME}/.selected_editor";
        if (-r $fn) {
            open (my $fh, '<', $fn);
            while (<$fh>) {
                s/#.*//;
                if (/^\s*SELECTED_EDITOR=(["']?)(.*)\1/) {
                    $EDITOR=$2;
                }
            }
            close ($fh);
        }
        }
    }
    if (!$EDITOR) {
        warn "No editor set. Using default!\n";
        if ($WINDOWS) {
            $EDITOR = 'texworks "%f"';
        }
        else {
            for my $ed (qw(/usr/bin/vim /usr/bin/emacs /usr/bin/nano)) {
                if (-x $ed) {
                    $EDITOR = $ed;
                    last;
                }
            }
            if (!$EDITOR) {
                for my $ed (qw(/usr/bin/editor /usr/bin/open /bin/open)) {
                    if (-x $ed) {
                        $EDITOR = "$ed \"%f\"";
                        last;
                    }
                }
            }
        }
    }
    if (!$EDITOR) {
        warn "No suitable editor found. Disable editing!\n";
        $EDIT = 0;
    }
}

## Format specific settings
if ($TEX =~ /latex$/) {
  $ISLATEX = 1;
  $BEGINENVSTR = '\begin{%s}' . "\n";
  $ENDENVSTR   = '\end{%s}'   . "\n";
}
elsif ($TEX =~ /tex$/) {
  $ISTEX   = 1;
  $BEGINENVSTR = '\%s' . "\n";
  $ENDENVSTR   = '\end%s' . "\n";
}
elsif ($TEX =~ /context$/) {
  $ISCONTEXT = 1;
  $BEGINENVSTR = '\start%s' . "\n";
  $ENDENVSTR   = '\stop%s'  . "\n";
}

$USERCLASS = $CLASS;
$CLASS = 'article' if not $CLASS;
$CLASS =~ /^(?:\[(.*)\])?{?(.*?)}?$/;
$CLASS = $2;
my $CLASSOPTIONS = $1 || '';

if ($FINDDEF == 1 && !$ISLATEX) { die "Error: The --find / -f option is only implemented for LaTeX!\n"; }
if ($FINDDEF == 2 && !$ISLATEX) { die "Error: The --Find / -F option is only implemented for LaTeX!\n"; }

my @cmds = @ARGV;
$LISTCMD = $LISTCMDDEF if $LISTCMDDEF;
if ($LISTCMD && !$ISLATEX) { die "Error: Listing for commands is only implemented for LaTeX!\n"; }
if ($LISTCMD) {
    @cmds = ($LISTSTR);
}

if ($PRINTVERSION) {
    if (!@PACKAGES && !$USERCLASS) {
        print STDERR "texdef: $VERSION\n";
        exit (0) if not @cmds;
    }
    elsif (!@cmds) {
        @cmds = ($FAKECMD);
    }
}

sub print_versions {
    my @files = map { $_.'.sty' } @PACKAGES;
    unshift @files, "$USERCLASS.cls" if $USERCLASS;

    foreach my $file (@files) {
        print "\\message{^^J:TEXDEF: $file: \\csname ver\@$file\\endcsname^^J}%\n";
    }
    $PRINTVERSION = 0;# only print it once
}

usage() if not @cmds;

my $cwd = getcwd();
my $DIRSEP;
if ($WINDOWS) {
    $DIRSEP = ';';
} else {
    $DIRSEP = ':';
}
$ENV{TEXINPUTS} = '.' . $DIRSEP . $cwd . $DIRSEP . ($ENV{TEXINPUTS} || '');

if (!$TMPDIR) {
   $TMPDIR = tempdir( 'texdef_XXXXXX', CLEANUP => 1, TMPDIR => 1 );
}
chdir $TMPDIR or die "Couldn't change into temporary directory '$TMPDIR'\n";
my $TMPFILE = 'texdeftmp.tex';

sub testdef {
    my $cmd = shift;
    my $def = shift;
    if ($def eq 'macro:->\@latex@error {Can be used only in preamble}\@eha ' && $cmd ne '\@notprerr') {
        unshift @cmds, '^' . $cmd;
    }
    elsif ($def =~ /^(?:\\[a-z]+ )?macro:.*?>(.*)/) {
        my $macrodef = $1;
        if ($macrodef =~ /^\\protect (.*?) ?$/) {
            my $protectedmacro = $1;
            unshift @cmds, $protectedmacro;
        }
        elsif ($macrodef =~ /^\\x\@protect (.*?) ?\\protect (.*?) ?$/) {
            my $protectedmacro = $2;
            unshift @cmds, $protectedmacro;
        }
        elsif ($macrodef =~ /^\\\@protected\@testopt {?\\.*? }? *(\\\\.*?) /) {
            unshift @cmds, $1;
        }
        elsif ($macrodef =~ /^\\\@testopt {?(\\.*?) }?/) {
            unshift @cmds, $1;
        }
    }
    elsif ($def =~ /^\\(char|mathchar)|(dimen|skip|muskip|count)\d/) {
        unshift @cmds, '#' . $cmd;
    }
}

my $bschar = 0;
my $pcchar = 0;
my $lbchar = 0;
my $rbchar = 0;

sub special_chars {
    return if (!$bschar && !$pcchar && !$lbchar && !$rbchar);
    print '\begingroup'."\n";
    if ($bschar) {
        print '\lccode`.=92 \lowercase{\expandafter\gdef\csname @backslashchar\endcsname{.}}'."\n";
    }
    if ($pcchar) {
        print '\lccode`.=37 \lowercase{\expandafter\gdef\csname @percentchar\endcsname{.}}'."\n";
    }
    if ($lbchar) {
        print '\lccode`.=123 \lowercase{\expandafter\gdef\csname @charlb\endcsname{.}}'."\n";
    }
    if ($rbchar) {
        print '\lccode`.=125 \lowercase{\expandafter\gdef\csname @charrb\endcsname{.}}'."\n";
    }
    print '\endgroup'."\n";
}

#######################################################################################################################
##  Loop around given commands                                                                                       ##
#######################################################################################################################
while (my $cmd = shift @cmds) {

next if $cmd eq '';
my $origcmd = $cmd; 
my $showvalue;
my $inpreamble;
if ($cmd ne $FAKECMD) {
if ($PGFKEYS) {
    $cmd = "pgfk\@$cmd/.\@cmd";
    push @PACKAGES, "pgfkeys";
}
if ($PGFKEYSPLAIN) {
    $cmd = "pgfk\@$cmd";
    push @PACKAGES, "pgfkeys";
}
if (length ($cmd) > 1) {
    $cmd =~ s/^([#^])?\\?//;
    my $type = $1 || '';
    $showvalue  = $type eq '#';
    $inpreamble = $type eq '^';
}
$bschar = $cmd =~ s/\\/\\csname\0\@backslashchar\\endcsname\0/g;
$pcchar = $cmd =~ s/\%/\\csname\0\@percentchar\\endcsname\0/g;
$lbchar = $cmd =~ s/\{/\\csname\0\@charlb\\endcsname\0/g;
$rbchar = $cmd =~ s/\}/\\csname\0\@charrb\\endcsname\0/g;
$cmd =~ s/\s/\\space /g;
$cmd =~ s/\0/ /g;
}

open (my $tmpfile, '>', $TMPFILE);
select $tmpfile;

print "\\nonstopmode\n";

if ($ISLATEX) {
    #print "\\nofiles\n";
    if ($FINDDEF || $LISTCMD || $PRINTORIGDEF) {
        # Load the 'filehook' and 'currfile' packages without 'kvoptions' by providing dummy definitions for the 'currfile' options:
        print '\makeatletter\expandafter\def\csname ver@kvoptions.sty\endcsname{0000/00/00}\let\SetupKeyvalOptions\@gobble';
        print '\newcommand\DeclareStringOption[2][]{}';
        print '\newcommand\DeclareBoolOption[2][false]{\expandafter\newif\csname ifcurrfile@#2\endcsname\csname currfile@#2#1\endcsname}';
        print '\let\DeclareVoidOption\@gobbletwo\def\ProcessKeyvalOptions{\@ifstar{}{}}';
        print '\def\currfile@mainext{tex}\def\currfile@maindir{\@currdir}\let\ifcurrfile@fink\iffalse\makeatother';
        print "\\RequirePackage{filehook}\n";
        print "\\RequirePackage{currfile}\n";
        print '\makeatletter\expandafter\let\csname ver@kvoptions.sty\endcsname\relax\let\SetupKeyvalOptions\@undefined\let\DeclareBoolOption\@undefined\let\DeclareStringOption\@undefined';
        print '\let\DeclareVoidOption\@undefined\let\ProcessKeyvalOptions\@undefined\makeatother';
    }
    if ($FINDDEF || $PRINTORIGDEF) {
        print '{\expandafter}\expandafter\ifx\csname ' . $cmd . '\expandafter\endcsname\csname @undefined\endcsname' . "\n";
        print '\AtBeginOfFiles{{{\expandafter}\expandafter\ifx\csname ' . $cmd . '\expandafter\endcsname\csname @undefined\endcsname\else' . "\n";
        print '  \ClearHook\AtBeginOfFiles{}\relax';
        print '  \ClearHook\AtEndOfFiles{}\relax';
        # Get parent filename
        print '  \csname currfile@pop\endcsname';
        print '  {\message{^^J:: \expandafter\string\csname '.$cmd.'\endcsname\space first defined in "\currfilename".^^J}}\fi}}', "\n";
        print '  \csname currfile@push\endcsname';
        print '\AtEndOfFiles{{{\expandafter}\expandafter\ifx\csname ' . $cmd . '\expandafter\endcsname\csname @undefined\endcsname\else' . "\n";
        print '  \ClearHook\AtBeginOfFiles{}\relax';
        print '  \ClearHook\AtEndOfFiles{}\relax';
        print '  {\message{^^J:: \expandafter\string\csname '.$cmd.'\endcsname\space first defined in "\currfilename".^^J}}\fi}}', "\n";
        print '\else'. "\n";
        print '  {\message{^^J:: \expandafter\string\csname '.$cmd.'\endcsname\space is defined by (La)TeX.^^J}}', "\n";
        print '\fi'. "\n";
    }
    if ($LISTCMD) {
        print '\AtBeginOfEveryFile{\message{^^J>> entering file "\currfilename"^^J}}'."\n";
        print '\AtEndOfEveryFile{\message{^^J<< leaving file "\currfilename"^^J}}'."\n";
    }
    if (!$BEFORECLASS) {
        print "\\documentclass[$CLASSOPTIONS]{$CLASS}\n";
        if ($LISTCMD) {
            print '\tracingonline=1\relax'. "\n";
            print '\tracingassigns=1\relax'. "\n";
        }

        foreach my $pkg (@PACKAGES) {
            $pkg =~ /^(?:\[(.*)\])?{?(.*?)}?$/;
            my ($pkgname,$pkgoptions) = ($2, $1 || '');
            print "\\usepackage[$pkgoptions]{$pkgname}\n";
        }
        {
            local $, = "\n";
            print @OTHERDEFS, '';
        }
        unless ($inpreamble || $INPREAMBLE) {
            print_versions if $PRINTVERSION;
            print '\tracingonline=0\relax'. "\n";
            print '\tracingassigns=0\relax'. "\n";
            print "\\begin{document}\n";
        }
    }
    else {
        if ($LISTCMD) {
            print '\tracingonline=1\relax'. "\n";
            print '\tracingassigns=1\relax'. "\n";
        }
    }
}
elsif ($ISCONTEXT) {
    foreach my $pkgname (@PACKAGES) {
        print "\\usemodule[$pkgname]\n";
    }
    {
        local $, = "\n";
        print @OTHERDEFS, '';
    }
    &special_chars();
    print "\\starttext\n" unless $inpreamble || $INPREAMBLE;
}
elsif ($ISTEX) {
    foreach my $pkgname (@PACKAGES) {
        print "\\input $pkgname \n";
    }
    {
        local $, = "\n";
        print @OTHERDEFS, '';
    }
    &special_chars();
}

foreach my $envc (@ENVCODE) {
    my ($envtype,$env) = @$envc;
    if ($envtype eq 'environment') {
        printf $BEGINENVSTR, $env;
    }
    elsif ($envtype eq 'before') {
        print "$env\n";
    }
}

if (!$LISTCMD && $cmd ne $FAKECMD) {

print '\immediate\write0{==============================================================================}%'."\n";
if (length ($cmd) > 1) {
if ($showvalue || $SHOWVALUE) {
    print '\immediate\write0{\string\the\expandafter\string\csname ', $cmd, '\endcsname}%'."\n";
    print '\immediate\write0{------------------------------------------------------------------------------}%'."\n";
    print '\immediate\write0{\expandafter\the\csname ', $cmd, '\endcsname}%'."\n";
} else {
    print '\begingroup';
    print '\immediate\write0{\expandafter\string\csname ', $cmd, '\endcsname}%'."\n";
    print '\immediate\write0{------------------------------------------------------------------------------}%'."\n";
    print '\expandafter\endgroup\expandafter\immediate\expandafter\write\expandafter0\expandafter{\expandafter\meaning\csname ', $cmd, '\endcsname}%'."\n";
}
}
else {
if ($showvalue || $SHOWVALUE) {
    print '\immediate\write0{\string\the\string\\', $cmd, '}%'."\n";
    print '\immediate\write0{------------------------------------------------------------------------------}%'."\n";
    print '\immediate\write0{\the\\', $cmd, '}%'."\n";
} else {
    print '\immediate\write0{\string\\', $cmd, '}%'."\n";
    print '\immediate\write0{------------------------------------------------------------------------------}%'."\n";
    print '\immediate\write0{\meaning\\', $cmd, '}%'."\n";
}
}
print '\immediate\write0{==============================================================================}%'."\n";

}

foreach my $envc (reverse @ENVCODE) {
    my ($envtype,$env) = @$envc;
    if ($envtype eq 'environment') {
        printf $ENDENVSTR, $env;
    }
    elsif ($envtype eq 'after') {
        print "$env\n";
    }
}

if ($ISLATEX) {
    print "\\documentclass[$CLASSOPTIONS]{$CLASS}\n" if $BEFORECLASS;
    if ($inpreamble || $INPREAMBLE || $BEFORECLASS) {
        print_versions if $PRINTVERSION;
        print '\tracingonline=0\relax'. "\n";
        print '\tracingassigns=0\relax'. "\n";
        print "\\begin{document}\n" 
    }
    print "\\end{document}\n";
}
elsif ($ISCONTEXT) {
    print "\\starttext\n" if $inpreamble || $INPREAMBLE;
    print "\\stoptext\n";
}
elsif ($ISTEX) {
    print "\\bye\n";
}

close ($tmpfile);

select STDOUT;

# Removes all '{' and '}' characters which no real braces.
sub remove_invalid_braces {
    $_[0] =~ s/\\[\\%]//g; # remove \\ and \%
    $_[0] =~ s/%.*$//;     # remove line comments
    $_[0] =~ s/\\[{}]//g;  # remove \{ and \}
}

sub env_braces {
    my $line = shift;
    remove_invalid_braces $line;
    my $level = shift || 0;
    my $count = shift || 0;
    for my $char (split //, $line) {
        if ($char eq '{') {
            $level++;
        }
        elsif ($char eq '}') {
            $level--;
            if ($level == 0) {
                $count++;
            }
        }
    }
    return ($level, $count);
}

sub call_editor {
    my $path = shift;
    my $linenumber = shift;
    print "Opening file '$path', line $linenumber.\n";
    if ($EDITOR =~ /%/) {
        $EDITOR =~ s/%%/\000/;
        $EDITOR =~ s/%f/$path/;
        $EDITOR =~ s/%n/$linenumber/;
        $EDITOR =~ s/\000/%/;
        system($EDITOR);
    }
    else {
        system($EDITOR, "+$linenumber", $path);
    }
}

sub print_orig_def {
    my $rmacroname = shift;
    my $file = shift;
    my $path = shift;
    my $linenumber;
    my $found = 0;
    open (my $fh, '<', $path) or return;
    my $rmacrodef  = qr/
        ^                                                        # Begin of line (no whitespaces!)
        (
        (?:(?:\\global|\\long|\\protected|\\outer)\s*)*       # Prefixes (maybe with whitespace between them)
        )
        \\(
              (?:[gex]?def) \s* \\                               # TeX definitions
            | (?:new|renew|provide)command\s* \*? \s* {? \s* \\  # LaTeX definitions
            | (?:new|renew|provide)robustcmd\s* \*? \s* {? \s* \\  # etoolbox definitions
            | (?:new(?:box|count|dimen|if|insert|read|skip|muskip|toks|write)) \s* \\ # TeX registers etc.
            | (?:char|count|dimen|mathchar|skip|toks)def \s* \\  # TeX chardefs etc.
            | \@namedef{?                                        # Definition by name only
            | Declare[a-zA-z]+ \s* \*? \s* {? \s* \\             # Declare... definitions
            | declare[a-zA-z]+ \s* \*? \s* {? \s* \\             # declare... definitions
        )
        $rmacroname                                              # Macro name without backslash
        [^a-zA-Z@]
        /xms;
    my $rmacrolet  = qr/
        ^                                                        # Begin of line (no whitespaces!)
        (?:global\s*)?                                           # Prefixes (maybe with whitespace between them)
        \\let \s* \\                                             # let
        $rmacroname                                              # Macro name without backslash
        \s* =?                                                   # Optional '='
        \s* \\ ([a-zA-Z@]+)                                      # Second macro
        /xms;
    my $renvdef = qr/
        ^                                                        # Begin of line (no whitespaces!)
        \\(
            (?:new|renew|provide)environment\s* { \s*            # LaTeX definitions
        )
        ($rmacroname)                                            # Environment names follow same rules as macro names
        \s* }                                                    # closing brace
        (.*)                                                     # Rest of line
        /xms;
    while (my $line = <$fh>) {
        if ($line =~ $rmacrodef) {
            my $defcmd = $1;
            $found = 1;
            $linenumber = $.;
            if ($EDIT) {
                call_editor($path, $linenumber);
                last;
            }
            print "% $file, line $linenumber:\n";
            print $line;
            last if $defcmd =~ /^(?:new(?:box|count|dimen|if|insert|read|skip|muskip|toks|write))/;
            last if $defcmd =~ /^(?:char|count|dimen|mathchar|skip|toks)def/;
            remove_invalid_braces $line;
            my $obrace = $line =~ tr/{/{/;
            my $cbrace = $line =~ tr/}/}/;
            while ($obrace != $cbrace) {
                my $line = <$fh>;
                print $line;
                remove_invalid_braces $line;
                $obrace += $line =~ tr/{/{/;
                $cbrace += $line =~ tr/}/}/;
            }
            print "\n";
            last;
        }
        elsif ($line =~ $rmacrolet) {
            my $letcmd = $1;
            $found = 1;
            $linenumber = $.;
            if ($EDIT) {
                call_editor($path, $linenumber);
                last;
            }
            print "% $file, line $linenumber:\n";
            print $line;
            print "\n";
            unshift @cmds, $letcmd;
            last;
        }
        elsif ($line =~ $renvdef) {
            $found = 2;
            $linenumber = $.;
            if ($EDIT) {
                call_editor($path, $linenumber);
                last;
            }
            print "% $file, line $linenumber:\n";
            print $line;
            my ($level, $count) = env_braces $line;
            while ($count < 3) {
                my $line = <$fh>;
                print $line;
                ($level, $count) = env_braces $line, $level, $count;
            }
            print "\n";
            last;
        }
    }
    close($fh);
    return $found;
}

open (my $texpipe, '-|', "$TEX $TEXOPTIONS \"$TMPFILE\" ");

my $name = '';
my $definition = '';
my $errormsg = '';
my $origdeffound = 0;

while (<$texpipe>) {
  if (/^::\s*(.*)/) {
    my $line = $1;
    if ($FINDDEF == 2) {
        if ($line =~ /first defined in "(.*)"/) {
            my $path = `kpsewhich "$1"`;
            chomp $path;
            $line =~ s/$1/$path/;
        }
    }
    if ($PRINTORIGDEF) {
        if ($line =~ /first defined in "(.*)"/) {
            my $file = $1;
            my $path = `kpsewhich "$file"`;
            chomp $path;
            $origdeffound = print_orig_def($cmd, $file, $path);
        }
        elsif ($line =~ /is defined by \(La\)TeX./) {
            my $file = 'latex.ltx';
            my $path = `kpsewhich "$file"`;
            chomp $path;
            $file = $path if $FINDDEF > 1;
            $origdeffound = print_orig_def($cmd, $file, $path);
        }
        if (!$origdeffound) {
            print "Source code definition of '$origcmd' could not be found.\n";
            print "$line\n";
        }
    }
    else {
        print "$line\n";
    }
    next;
  }
  if (/^(:TEXDEF:\s*(.*))/) {
    my $line = $1;
    chomp ($line);
    my $text = $2;
    while (length $line >= 79) {
        $line = <$texpipe>;
        chomp ($line);
        $text .= $line;
    }
    print "$text\n";
    next;
  }
  if ($LISTCMD) {
  if (/^>> entering file "(.*)"$/) {
      push @FILES, $currfile;
      $currfile = $1;
      push @FILEORDER, $currfile if not exists $DEFS{$currfile};
  }
  elsif (/^<< leaving file "(.*)"$/) {
      $currfile = pop @FILES;
  }
  elsif (/^{(?:into|reassigning) \s*(.*)}?$/) {
    my ($cs, $def) = split (/=/, $1, 2);
    $cs =~ s/^\\//;
    $def =~ s/\}$//;
    if ($LISTCMD > 1 || $cs !~ /[@ ]/) {
        if ($def =~ /^\\((?:skip|count|toks|muskip|box|dimen)\d+)$/) {
            $ALIAS{$1} = $cs;
        }
        elsif (exists $ALIAS{$cs}) {
            $cs = $ALIAS{$cs}
        }
        $DEFS{$currfile}{$cs} = $def;
    }
  }
  }
  last if /^=+$/;
  if ($_ =~ /^!\s*(.*)/ && !$errormsg) {
    chomp;
    my $line = $1;
    $errormsg = $line;
    while (length $line >= 79) {
        $line = <$texpipe>;
        chomp $line;
        $errormsg .= $line;
    }
  }
}
while (<$texpipe>) {
  last if /^-+$/;
  next if /^$/;
  chomp;
  $name .= $_;
}
while (<$texpipe>) {
  last if /^=+$/;
  next if /^$/;
  chomp;
  $definition .= $_;
  if ($_ =~ /^!\s*(.*)/ && !$errormsg) {
    $errormsg = $1;
  }
}
while (<$texpipe>) {
  if ($_ =~ /^!\s*(.*)/ && !$errormsg) {
    chomp;
    my $line = $1;
    $errormsg = $line;
    while (length $line >= 79) {
        $line = <$texpipe>;
        chomp $line;
        $errormsg .= $line;
    }
  }
}
close ($texpipe);

my $error = $? >> 8;

if ($error) {
  if ( ($SHOWVALUE || $showvalue) && ($errormsg =~ /^You can't use `.*' after \\the\./) ) {
    print STDERR "\n$name:\nError: Given command sequence does not contain a value.\n\n";
  }
  else {
    print STDERR "\n$name:\nCompile error: $errormsg\n\n";
  }
  next;
}

#last if $PRINTORIGDEF && $origdeffound && $EDIT;

next if $cmd eq $FAKECMD;
if ($cmd eq $LISTSTR) {
    foreach $currfile (@FILEORDER) {
        next if not keys %{$DEFS{$currfile}};
        print "\nDefined by file '$currfile':\n";
        CMD:
        foreach my $cmd (sort keys %{$DEFS{$currfile}}) {
            next CMD if exists $IGNOREDEF{$cmd};
            foreach my $pattern (@IGNOREDEFREG) {
                next CMD if $cmd =~ $pattern;
            }
            print "\\$cmd";
            print ": $DEFS{$currfile}{$cmd}" if ($LISTCMDDEF);
            print "\n";
        }
    }
} elsif (!$PRINTORIGDEF || !$origdeffound) {
    print "\n(in preamble)" if $inpreamble;
    print "\n$name:\n$definition\n\n";
}

if (!($PRINTORIGDEF && $origdeffound)) {
    testdef($origcmd,$definition);
}
if ($ISENVIRONMENT && $origdeffound < 2 && $cmd !~ /^end/) {
    unshift @cmds, 'end' . $cmd;
}

}

chdir $cwd;
__END__
