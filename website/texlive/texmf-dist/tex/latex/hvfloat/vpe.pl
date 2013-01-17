#! /usr/bin/perl -w
use strict;
#
# vpe.pl
#
# Copyright (C) 2000, 2012 Heiko Oberdiek.
#
# This program may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.2
# of this license or (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.2 or later is part of all distributions of LaTeX
# version 1999/12/01 or later.
#
# See file "vpe.txt" for a list of files that belong to this project.
#
# This file "vpe.pl" may be renamed to "vpe"
# for installation purposes.
#
my $prj         = 'vpe';
my $file        = "$prj.pl";
my $program     = uc($&) if $file =~ /^\w+/;
my $version     = "0.2";
my $date        = "2012/04/18";
my $author      = "Heiko Oberdiek";
my $copyright   = "Copyright (c) 2000, 2012 by $author.";
#
# History:
#   2000/09/15 v0.1: First release.
#   2012/04/18 v0.2: Option --version added.
#

### program identification
my $title = "$program $version, $date - $copyright\n";

### editor call
# %F: file name
# %L: line number
my $EditorCall = "xterm -e joe +%d %s";
$EditorCall = $ENV{TEXEDIT} if $ENV{TEXEDIT};
$EditorCall = $ENV{VPE} if $ENV{VPE};

### error strings
my $Error = "!!! Error:"; # error prefix

my $usage = <<"END_OF_USAGE";
${title}
Depending on the name of the script `vpe' works in four modes:

* [vpe] Syntax: vpe <pdf file>[.pdf]
  The pdf file is scanned for actions created by VTeX,
  that start an editor with the source file at the
  specified line under Windows.
  A symbol link is made from the source file name
  extended by the extension `.vpe' to this script.
  The line number is encoded in the path and the
  action is changed to start this script.

* [sty] Internal for vpe.sty:
  Syntax: vpe --sty [--progname=...] <latex file> <vpe file>

* [system] Internal for vpe.sty:
  Syntax: vpe --system <vpe file>

* [launch] Syntax: <source file name>.vpe
  The script decodes the line number in the path of
  the source file name and starts an editor with
  this file at that line number.

Options:
  --help:     print usage
  --version   print version number
  --verbose:  print additional informations during running
  --force:    force symbol links
  --delete:   delete symbol links
  --sty:      internal for `vpe.sty' (get absolute file name and lines)
  --system:   internal for `vpe.sty' (get system info linux or win)
  --progname: latex, pdflatex, elatex, pdfelatex
END_OF_USAGE

### options
$::opt_verbose = 0;
$::opt_help = 0;
$::opt_version = 0;
$::opt_force = 0;
$::opt_delete = 0;
$::opt_sty = 0;
$::opt_system = 0;
$::opt_progname = "latex";
use Getopt::Long;
GetOptions(
  "help!",
  "version!",
  "verbose!",
  "force!",
  "delete!",
  "sty!",
  "system!",
  "progname=s",
) or die $usage;
if ($::opt_help) {
  die $usage;
}
if ($::opt_version) {
  print "$prj $date v$version\n";
  exit(0);
}

if ($::opt_sty and $::opt_system) {
  die "$usage" .
      "$Error Options --sty and --system cannot used together!\n";
}

###################
### launch mode ###
###################
if ($0 =~ /\.vpe/) {

  @ARGV == 0 or
    die "$usage$Error Too many arguments [launch mode]!\n";

  my $file = "";
  $0 =~ m|(^[\./]+\./)(.+)\.vpe$| or
    die "$Error Cannot extract line number ($0)!\n";
  my $str = $1;
  $file = "/$2";

  my $line = "";
  while ($str ne "") {
    $str =~ m|^(/*)(\.?)\./(.*)$| or
      die "$Error Parse error!\n";
    $line .= length($1) + (($2 eq ".") ? 5 : 0);
    $str = $3;
  }

  my $callstr = $EditorCall;
  $EditorCall =~ s/%s/$file/;
  $EditorCall =~ s/%d/$line/;
  print "File: $file, line: $line\n" if $::opt_verbose;
  exec($EditorCall);
  exit 1;
}

###
### used by both sty and system mode:
###
my $system = "linux";
$system = "" if $^O =~ /os2/i;
$system = "" if $^O =~ /mac/i;
$system = "win" if $^O =~ /dos/i;
$system = "win" if $^O =~ /win/i;

################
### sty mode ###
################
if ($::opt_sty) {

  @ARGV == 2 or
    die "$usage$Error Wrong arguments [sty mode]!\n";

  my $vpefile = $ARGV[1];
  print "VPE file: $vpefile\n" if $::opt_verbose;

  my $file = `kpsewhich -progname=$::opt_progname $ARGV[0]`;
  chomp $file;
  if (!($file =~ m|^/| or $file =~ m|^\w:|)) {
    use Cwd;
    $file = cwd() . "/" . $file;
    $file =~ s|/[^/]+/\.\./|/|g;
    $file =~ s|/\./|/|g;
  }
  -f $file or
    die "$Error Cannot find file `$file' [sty mode]!\n";
  print "File: $file\n" if $::opt_verbose;

  my $last = 0;
  if (open(IN, $file)) {
    while (<IN>) {
      $last++;
    }
  }
  if ($last == 0) {
    $last = 10000;
  }
  print "Last line: $last\n" if $::opt_verbose;

  open(OUT, ">>$vpefile") or
    die "$Error Cannot open file `$vpefile`!\n";
  print OUT "\\vpeentry{$file}{$last}\n";

  exit 1;
}

###################
### system mode ###
###################
if ($::opt_system) {

  @ARGV == 1 or
    die "$usage$Error Wrong arguments [system mode]!\n";

  my $vpefile = $ARGV[0];
  print "VPE file: $vpefile\n" if $::opt_verbose;

  open(OUT, ">>$vpefile") or
    die "$Error Cannot open file `$vpefile`!\n";
  print OUT "\\vpesystem{$system}\n";

  exit 1;
}

################
### vpe mode ###
################
if (@ARGV < 1) {
  die "$usage$Error Missing pdf file [vpe mode]!\n";
}
if (@ARGV > 2) {
  die "$usage$Error Too many arguments [vpe mode]!\n";
}

my $pdffile = $ARGV[0];
if (!-f $pdffile) {
  my $name = $pdffile;
  $pdffile .= ".pdf";
  -f $pdffile or
    die "$Error File `$name' not found [vpe mode]!\n";
}

open(IN, "+<$pdffile") or
  die "$Error Cannot open `$pdffile' [vpe mode]!\n";
binmode(IN);
my %symlinks = ();
while (<IN>) {

  if (m|/F\([\./]*(/.*)\.vpe\)|) {
    $symlinks{$1} = 1;
    next;
  }

  my $do = 0;
  my ($action, $file, $line, $type);
  # my $color; # only for debugging

  if (m|^
        /A \s* << \s*
          /Type \s* /Action \s*
          /S \s* /Launch \s*
          /Win \s* << \s*
            /F \s* \(aftcomp.exe\) \s*
            /P \s* \("(.*)\" \s+ \d+\-(\d+)\) \s*
          >> \s*
        >> \s*
        $
       |x
  ) {
    $action = $_;
    $file = $1;
    $line = $2;
    # $color = "/C[0 0 1]"; # only for debugging
    $type = "aftcomp";
    $do = 1;
  }

  if (m|^
        /A \s* << \s*
          /Type \s* /Action \s*
          /S \s* /Launch \s*
          /Win \s* << \s*
            /F \s* \(repos.exe\) \s*
            /P \s* \(
              "(.*)" \s*
              "(\d+)" \s*
              "(.*)" \s*
              "(\d+)"
            \) \s*
          >> \s*
        >> \s*
        $
       |x
  ) {
    $action = $_;
    if ($3 eq "") {
      $file = $1;
      $line = $2;
    }
    else {
      # ???
      $file = $1;
      $line = $2;
    }
    # $color = "/C[1 0 0]"; # only for debugging
    $type = "repos";
    $do = 1;
  }

  if ($do) {
    my $length = length($action);
    print "* File: $file, line: $line, type: $type\n" if $::opt_verbose;

    if (!($file =~ m|^/|)) {
      print STDERR "$Error File `$file' lacks of absolute path!\n";
      next;
    }

    if (!$::opt_delete) {
      if ($line <= 0) {
        $line = 1;
      }

      my $newaction = "";
      {
        my $digit = substr($line, 0, 1);
        if ($digit <= 5) {
          $newaction .= "/" x $digit;
        }
        else {
          $newaction .= "/" x ($digit - 5) . ".";
        }
        $newaction .= "./";
        my $rest = $line;
        while (($rest = substr($rest, 1)) ne "") {
          $digit = substr($rest, 0, 1);
          if ($digit < 5) {
            $newaction .= "/" x $digit;
          }
          else {
            $newaction .= "/" x ($digit - 5) . ".";
          }
          $newaction .= "./";
        }
      }
      $newaction .= substr($file, 1) . ".vpe";
      $newaction = # $color . # only for debugging
                   "/A<</Type/Action/S/Launch/F($newaction)>>";
      $newaction .= " " x ($length - length($newaction) - 1);
      if (length($newaction) > $length) {
         print STDERR "$Error Action too long!\n";
         next;
      }

      seek(IN, -length($action), 1);
      print IN $newaction;
    }

    $symlinks{$file} = 1;
  }
}

if (keys(%symlinks)) {

  my $this = $0;
  if (!$::opt_delete) {
    if (!-f $0 or !-x $0) {
      $this = `which $0`;
      ($this ne "") or die "$Error Cannot find this script!\n";
    }
    if (!($this =~ m|^/|)) {
      use Cwd;
      $this = cwd() . "/" . $this;
    }
    $this =~ s|/[^/]+/\.\./|/|g;
    $this =~ s|/\./|/|g;
  }

  if ($::opt_delete) {
    print "Delete symlinks:\n";
  }
  else {
    if ($::opt_force) {
      print "Forced symlinks to $this:\n";
    }
    else {
      print "Symlinks to $this:\n";
    }
  }

  foreach (keys(%symlinks)) {
    my $sym = $_ . ".vpe";
    print "  $sym [";

    if ($::opt_delete) {
      if (!-l $sym) {
        print "ok, not existing]\n";
        next;
      }
      unlink($sym);
      if (!-l $sym) {
        print "ok, deleted]\n";
        next;
      }
      print "failed]\n";
      next;
    }
    if ($::opt_force) {
      if (-l $sym) {
        unlink($sym);
        if (-l $sym) {
          print "deletion failed]\n";
          next;
        }
        if (symlink($this, $sym)) {
          print "ok, deleted and created]\n";
          next;
        }
        print "deleted, creation failed]\n";
        next;
      }
      if (symlink($this, $sym)) {
        print "ok, created]\n";
        next;
      }
      print "creation failed]\n";
      next;
    }
    if (-f $sym) {
      print "exists]\n";
      next;
    }
    if (symlink($this, $sym)) {
      print "ok, created]\n";
      next;
    }
    print "failed]\n";
    next;
  }
}
__END__
