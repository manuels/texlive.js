#!/usr/bin/perl
# --------------------------------------------------------------
#  svn-multi.pl for the svn-multi v2.0 LaTeX package
#  version 0.1, Mar 1st, 2009
# --------------------------------------------------------------
#
# Copyright (C) 2006-2012 Martin Scharrer
# E-mail: martin@scharrer-online.de
# Code repository: https://bitbucket.org/martin_scharrer/svn-multi
#
# This program works only in combination with the LaTeX package 'svn-multi' and
# generates .svx files with '\svnidlong' macros holding Subversion keywords for
# files declared with '\svnexternal' inside the LaTeX document.
#
# This program is free software under the GPL v3 and LPPL v1.3c or later.
#
#
# GPL v3:
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# LPPL v1.3c:
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3c
# of this license or (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3c or later is part of all distributions of LaTeX
# version 2008/05/04 or later.
#
# This work has the LPPL maintenance status `maintained'.
#
# The Current Maintainer of this work is Martin Scharrer.
#
# This work consists of the files svn-multi.dtx, svn-multi-pl.dtx and
# svn-multi.ins and the derived files svn-multi.sty, svnkw.sty and svn-multi.pl.
#
# The file 'svn-multi.pl' may be renamed to 'svn-multi' for installation
# purposes.
#
#
use strict;
use warnings;
use File::Basename;
my $VERSION = "0.2";
my ($REV,$DATE) =
  (split ' ','$Id$')[2,3];

my $dollar  = '$';
my @PATH;
my %EXCLUDE = map { $_ => 1 } qw(sty tex aux log out toc fff ttt svn svx);

sub create_svxfile ($@);
sub usage;

if (!@ARGV or grep { $_ eq '--help' or $_ eq '-h' } @ARGV) {
  usage();
}

print STDOUT "This is svn-multi.pl, Version $VERSION-$REV, $DATE\n";

my ($jobname, $dir, $suffix) = fileparse(shift @ARGV, qr/\.(tex|ltx|dtx|svn)$/);
if ($dir && $dir ne './') {
  printf STDOUT "Main directory is '$dir'.\n";
  chdir($dir);
}

if ($jobname =~ /^-/) {
  usage();
}
my $outfile = "$jobname.svx";

my %external;

my $resvnexternalpath = qr/
        ^                   # at begin of line
   \s*                      # allow for spaces
      \\\@svnexternalpath   # the macro name
   \s*
        {                   # begin token group
   \s*
        (?:                 # paths:
            {               # { of first path
              (.*)          # everything else, e.g: 'patha}{pathb}{pathc'
            }               # } of last path
            |               # or nothing
        )
   \s*
        }                   # end token group
   \s*
        $                   # end of line
   /x;

my $resvnexternal = qr/
        ^                   # at begin of line
   \s*                      # allow for spaces
      \\\@svnexternal       # the macro name
   \s*
        (?:                 # optional:
            \[              # opening [
                ([^\]]*)    # group name (everything until ])
            \]              # closing ]
        )?
   \s*
        {                   # begin token group
            ([^}]+)         # file name (everything until })
        }                   # end token group
   \s*
        {                   # begin token group
   \s*
        (?:                 # paths:
            {               # { of first file
              (.*)          # everything else, e.g: 'filea}{fileb}{filec'
            }               # } of last file
            |               # or nothing
        )
   \s*
        }                   # end token group
   \s*
        $                   # end of line
   /x;

if (-e "$jobname.aux" and open( my $svnfh, '<', "$jobname.aux")) {
  print STDOUT "Reading '$jobname.aux'.\n";
  while (<$svnfh>) {
    chomp;
    if  (/$resvnexternalpath/) {
      push @PATH, ( split /}\s*{/, $1 );
    }
    elsif (/$resvnexternal/) {
      my ($group,$file,$list) = ($1||"",$2,$3||"");
      $file =~ s/^\.\///;
      push @{$external{$file}{$group} ||= []}, ( split /}\s*{/, $list );
    }
  }
  close ($svnfh);
}
else {
  warn "No .aux file found for '$jobname'!\n";
}

# Add TEXINPUTS to path
push @PATH, map { $_ =~ s/(?<!\/)$/\//; $_ } grep { $_ }
        split(':', $ENV{'TEXINPUTS'}||"");

my @mainfilepairs;
my $maintex = "$jobname.tex";
if (exists $external{$maintex}) {
  while ( my ($group,$list) = each %{$external{$maintex}} ) {
  push @mainfilepairs, [ $group, [ @$list ] ];
  }
  delete $external{$maintex};
}

push @mainfilepairs, parse_args(@ARGV);
create_svxfile("$jobname.svx", @mainfilepairs )
  if @mainfilepairs;

foreach my $file (keys %external) {
  my @pairs;
  my $svxfile = $file;
  $svxfile =~ s/\.(tex|ltx)$/.svx/;
  while ( my ($group,$list) = each %{$external{$file}} ) {
  push @pairs, [ $group, [ @$list ] ];
  }
  create_svxfile($svxfile, @pairs);
}


sub parse_args {
  my @args = @_;
  my $group = '';
  my @files;
  my $readfg;
  my @pairs;

  foreach my $arg (@args) {
    if ($readfg) {
      $readfg = 0;
      $group = $arg;
      $group =~ s/^["']|["']$//; # '
    }
    elsif ($arg =~ /^--group|^-?-fg/) {
      push @pairs, [ $group, [ @files ] ];
      @files = ();
      if ($arg =~ /^--group=(.*)/) {
        $group = $1;
        $group =~ s/^["']|["']$//; # '
      }
      else {
        $readfg = 1;
      }
    }
    elsif ($arg =~ /^--fls/) {
      push @files, read_fls("$jobname.fls");
    }
    else {
      push @files, $arg;
    }
  }
  push @pairs, [ $group, [ @files ] ] if @files;
  return @pairs;
}

sub path_search {
  my $file = shift;
  $file =~ s/##/#/g;
  return $file if not $file or -e $file or not @PATH;

  foreach my $dir (@PATH) {
    if (-e "$dir$file") {
      return "$dir$file";
    }
  }

  return $file;
}

sub create_svxfile ($@) {
  my ($svxfile, @fgpair) = @_;
  my $lastgroup;
  my $fgused = 0;
  my %seen;
  return if not @fgpair or not $svxfile;

  open(my $svxfh, '>', $svxfile) or do {
    warn "ERROR: Could not create SVX file '$svxfile'!\n";
    return;
  };
  print STDOUT "Generating .svx file '$svxfile'.\n";
  select $svxfh;
  print "% Generated by svn-multi.pl v$VERSION\n\n";

  while ( my ($group, $files) = @{shift @fgpair||[]}) {
    no warnings 'uninitialized';
    if ( (not defined $lastgroup and $group) or ($group ne $lastgroup) ) {
      print "\\svngroup{$group}\n";
    }
    use warnings;
    if ($group) {
      $fgused = 1;
    }

    foreach my $file (@$files) {
      $file = path_search($file);

      # Only print the file once per group and .svx file
      next if $seen{$group}{$file};
      $seen{$group}{$file} = 1;

      open(my $infoh, '-|', "svn info '$file' 2>/dev/null") or next;
      my %info = map { chomp; split /\s*:\s*/, $_, 2 } <$infoh>;
      close($infoh);
      if (not keys %info) {
        print "% Could not receive keywords for '$file'!\n\n";
        next;
      }
      print "% Keywords for '$file'\n";
      print svnidlong(\%info);
      print "\\svnexternalfile";
      print "[$group]" if $group;
      print "{$file}\n";
      print "\n"
    }

    $lastgroup = $group;
  }
  print "\n";
  close ($svxfh);
}

sub svnid {
  use Date::Parse;
  use Date::Format;
  my $href = shift;
  return "" if (not defined $href->{Name});
  my $date = time2str("%Y-%m-%d %XZ", str2time($href->{'Last Changed Date'}), 'Z');
  return <<"EOT";
\\svnid{${dollar}Id: $href->{Name} $href->{'Last Changed Rev'} $date $href->{'Last Changed Author'} \$}
EOT
}

sub svnidlong {
  my $href = shift;
  return <<"EOT";
\\svnidlong
{${dollar}HeadURL: $href->{URL} \$}
{${dollar}LastChangedDate: $href->{'Last Changed Date'} \$}
{${dollar}LastChangedRevision: $href->{'Last Changed Rev'} \$}
{${dollar}LastChangedBy: $href->{'Last Changed Author'} \$}
EOT
}

sub read_fls {
  my $fls = shift;
  my %stack;
  open (my $fh, '<', $fls) or return;
  while (<$fh>) {
    chomp;
    if (/^INPUT ([^\/].*)$/) {
      my $file = $1;
      my $ext = substr($file, rindex($file,'.')+1);
      $stack{$1} = 1 if not exists $EXCLUDE{$ext};
    }
  }
  close($fh);
  return keys %stack;
}

sub usage {
  print STDOUT <<'EOT';
Usage:
 svn-multi.pl jobname[.tex] [--fls] [--group|-g <group name>] [input_files] ...
 ... [--group|-g <group name>] [input_files] ...

Description:
 This LaTeX helper script collects Subversion keywords from non-(La)TeX files
 and provides it to the 'svn-multi' package using '.svx' files.  It will first
 scan the file '<jobname>.aux' for files declared by the '\svnextern' macro but
 also allows to provide additional files including the corresponding groups. The
 keywords for the additional files will be written in the file '<jobname>.svx'.

Options:
 jobname[.tex] : The LaTeX `jobname`, i.e. the basename of your main LaTeX file.
 --group <GN>  : Use given group name <GN> for all following files,
 or -g <GN>      including the one read by a '--fls' option, until the next
                 group is specified.
 --fls  : Read list of (additional) files from the file '<jobname>.fls'. This
          file is produced by LaTeX when run with the '--recorder' option and
          contains a list of all input and output files used by the LaTeX main
          file. Only input files with a relative path will be used.  A
          previously selected group will be honoured.

Examples:
The main LaTeX file here is 'mymainlatexfile.tex'.

 svn-multi.pl mymainlatexfile
    Creates Subversion keywords for all files declared by '\svnextern' inside
    the LaTeX code.

 svn-multi.pl mymainlatexfile --group=FLS --fls
    Creates Subversion keywords for all files declared by '\svnextern' inside
    the LaTeX code. In addition it does the same for all relative input files
    mentioned in the .fls file which are placed in the 'FLS' group.

 svn-multi.pl mymainlatexfile a b c --group=B e d f
    In addition to the '\svnextern' declared files the keywords for the files
    'a', 'b' and 'c' will be added without a specific group, i.e. the last group
    specified in the LaTeX file before the '\svnextern' macro will be used. The
    keywords for 'e', 'd', 'f' will be part of group 'B'.

 svn-multi.pl mymainlatexfile --group=A a --group=B b --group='' c
    File 'a' is in group 'A', 'b' is in 'B' and 'c' is not in any group.

Further Information:
See the svn-multi package manual for more information about this script.
EOT
  exit(0);
}

__END__
