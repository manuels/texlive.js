#!/usr/bin/env perl
#
# Copyright (C) 2006-2012 Boris Veytsman & Leila Akhmadeeva
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.
#
#
=pod

=head1 NAME

pedigree - create a TeX file for pedigree from a csv file

=head1 SYNOPSIS

B<pedigree> [-c I<configuration_file>] [-d] [-o I<output_file>] [-s I<start_id>] I<input_file>

B<pedigree> -v

=head1 DESCRIPTION

The program converts a comma separated I<input_file> into a TeX file
with pst-pdgr macros.  

=head1 OPTIONS

=over 4

=item B<-c> I<configuration_file>

The configuration file to read along with the system-wide and user's
configuration files

=item B<-d>

Debug mode on

=item B<-o> -I<output_file> 

The ouput file instead of I<input_file.tex>

=item B<-s> -I<start_id> 

If this option is selected, the pedigree is constructed starting from
the node with the Id i<start_id>. Otherwise it is started from the 
proband node.

This option allows to create pedigrees with multiple probands or absent
probands, or show people who are not proband's relatives.

=item B<-v>

Print version information

=back

=head1 FILES

=over 4

=item B</etc/pedigree.cfg>

Global configuration file

=item B<$HOME/.pedigreerc>

User configuration file

=back 

=head1 SEE ALSO

The manual distributed with this program describes the format of the
configuration file and the input file.

The library functions are described in Pedigree::Language(3),
Pedigree::Parser(3), Pedigree::Node(3), Pedigree::PersonNode(3),
Pedigree::MarriageNode(3), Pedigree::Area(3).

=head1  AUTHOR

Boris Veytsman, Leila Akhmadeeva, 2006-2012


=cut


#########################################################
#   Packages and Options                                #
#########################################################

use strict;
use vars qw($opt_c $opt_d $opt_o $opt_s $opt_v);

our $TLCONF;        # TL config file
our $TLCONFLOCAL;   # TL local config file

BEGIN {
    # find files relative to our installed location within TeX Live
    chomp(my $TLMaster = `kpsewhich -var-value=SELFAUTOPARENT`); # TL root
    if (length($TLMaster)) {
	unshift @INC, "$TLMaster/texmf-dist/scripts/pedigree-perl";
	$TLCONF = "$TLMaster/texmf-config/pedigree/pedigree.cfg";
	chomp($TLCONFLOCAL = `kpsewhich -var-value=TEXMFLOCAL`);
	$TLCONFLOCAL .= "/pedigree/pedigree.cfg";
    }
}

use Getopt::Std;
use FileHandle;
use Pedigree;

#########################################################
#   Options Reading and Global Variables                #
#########################################################

my $USAGE="Usage: $0 [-c configuration_file] [-d] [-o output_file] [-s start_id] input_file\n";
my $COPYRIGHT=<<END;
$0 Version 1.0, April 2012

Copyright (C) 2006-2012 Boris Veytsman & Leila Akhmadeeva

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330,
END

my $GLOBALCONF="/etc/pedigree.cfg";

my $USERCONF="$ENV{HOME}/.pedigreerc";


our $IN = new FileHandle;
our $OUT = new FileHandle;

getopts('c:do:s:v') or die $USAGE;
    
if ($opt_v) {
    die $COPYRIGHT;
}

our $DEBUG = $opt_d ||0;

if (scalar @ARGV != 1) {
    die $USAGE;
}

our $start_id = $opt_s;

#########################################################
#   Opening Files                                       #
#########################################################


if ($ARGV[0] eq '-') {
    $IN->fdopen(fileno(STDIN),"r");
} else {
    $IN->open($ARGV[0], "r") or die "Cannot read from $ARGV[0]\n";
}

my $outfile=$ARGV[0];
if ($opt_o) {
    $outfile = $opt_o;
} else {
    $outfile =~ s/\.[^\.]*$/.tex/;
}
if ($outfile eq '-') {
    $OUT->fdopen(fileno(STDOUT),"w");
} else {
    $OUT->open($outfile, "w") or die "Cannot write to $outfile\n";
}

#########################################################
#   Configuration                                       #
#########################################################

#
# First, the defaults.  Even if we do not find any
# configuration file, these will work.
#    


#
# Do we want to have a full LaTeX file or just a fragment?
#
our $fulldoc=1;

#
# What kind of document do we want
#
# our $documentheader='\documentclass[landscape]{article}';
our $documentheader='\documentclass{article}';

#
# Define additional packages here
#
# our $addtopreamble=<<END;
# \\usepackage{graphics}
# END
our $addtopreamble=<<END;
\\psset{descarmA=1}
END



#
# Do we want to print a legend?
#
our $printlegend=1;

#
# Fields to include in the legend.  Delete Name for privacy 
# protection. 
#
our @fieldsforlegend = qw(Name DoB AgeAtDeath Comment);

#
# Fields to put at the node.  Delete Name for privacy 
# protection. 
#
our @fieldsforchart = qw(Name);

#
# Language
#
# our $language="russian";
our $language="english";

#
# Override the encoding
#
# our $encoding="koi8-r";

our $encoding;

#
#  descarmA
#
our $descarmA = 0.8;

#
# Fonts for nodes
#
our $belowtextfont='\small';
our $abovetextfont='\scriptsize';

#
# Distances between nodes (in cm)
#
our $xdist=2;
our $ydist=2;

#
# Maximal width and height of the pedigree in cm.
# Set this to 0 to switch off scaling
#
our $maxW = 15;
our $maxH = 19;

#
# Whether to rotate the page.  The values are 'yes', 'no' and 'maybe'
# If 'maybe' is chosen, the pedigree is rotated if it allows better
# scaling
#
our $rotate = 'maybe';

#
# Read the global configuration file(s)
#
foreach my $conffile ($GLOBALCONF, $TLCONF, $TLCONFLOCAL) {
    if (-r $conffile) {
	if ($DEBUG) {
	    print STDERR "Reading global configuration file $conffile\n";
	}
	require "$conffile";
    } else {
	if ($DEBUG) {
	    print STDERR "Cannot find global configuration file $conffile; going without it\n";
	}
    }
}

#
# Read the user configuration file
#
if (-r $USERCONF) {
    if ($DEBUG) {
	print STDERR "Reading user configuration file $USERCONF\n";
    }
    require "$USERCONF";
} else {
    if ($DEBUG) {
	print STDERR "Cannot find user configuration file $USERCONF; going without it\n";
    }
}

#
# Read the option configuration file
#
if ($opt_c) {
    if (-r $opt_c) {
	if ($DEBUG) {
	    print STDERR "Reading optional configuration file $opt_c\n";
	}
	require "$opt_c";
    } else {
	die "Cannot find $opt_c\n";
    }
}

#########################################################
#   Setting up                                          #
#########################################################

my $lang = new Pedigree::Language($language, $encoding);
$_=<$IN>;
my $parser = new Pedigree::Parser($_,$lang);
my $start;

#########################################################
#   Reading input                                       #
#########################################################

while (<$IN>) {
    my $node = Pedigree->MakeNode($parser->Parse($_));
    if (ref($node)) {
	if ($start_id) {
	    if ($start_id eq $node->Id()) {
		$start = $node;
		if ($DEBUG) {
		    print STDERR "Found start: ", $start->Id(), "\n";
		}
	    }
	} else {
	    if ($node->isProband()) {
		if (ref($start)) {
		    print STDERR "Two probands?  I got ", $start->Id(), 
		    " and ", $node->Id(), "\n";
		}
		$start=$node;
		if ($DEBUG) {
		    print STDERR "Found proband: ", $start->Id(), "\n";
		}
	    }
	}
    }
}

if (!ref($start)) {
    die "Cannot find the start!\n";
}

#########################################################
#   Process Pedigree                                    #
#########################################################

#
# Check all parents
#
$start->CheckAllParents();


#
# The root is the root of the tree to which the proband
# belongs
#

my ($root, undef)=@{$start->FindRoot(0)};
if ($DEBUG) {
    print STDERR "Root: ", $root->Id(), "\n";
}

#
# Calculate relative coordinates
#
$root->SetRelX(0);
$root->SetRelY(0);
$root->SetArea();

#
# Calculate the absolute coordinates
#
$root->CalcAbsCoor(0,0);

#
# Check for consanguinic marriages
#
$root->AddConsanguinicMarriages();

#
# And twins
#
$root->AddTwins($ydist);

#
#  Get the frame
#
my ($xmin, $ymin, $xmax, $ymax) = @{$root->SetFrame($xdist, $ydist)};



#########################################################
#   Printing headers                                    #
#########################################################

if ($fulldoc) {
    printheader($OUT,$lang,$addtopreamble);
}

#########################################################
#   Calculate scale and check whether to rotate         #
#########################################################

my $scale=1;
my $scaleRotated = 1;

if ($maxH && $maxW) {
    if ($maxH/($ymax-$ymin) < $scale) {
	$scale = $maxH/($ymax-$ymin);
    }
    if ($maxW/($xmax-$xmin) < $scale) {
	$scale = $maxW/($xmax-$xmin);
    }
    if ($maxW/($ymax-$ymin) < $scaleRotated) {
	$scaleRotated = $maxW/($ymax-$ymin);
    }
    if ($maxH/($xmax-$xmin) < $scaleRotated) {
	$scaleRotated = $maxH/($xmax-$xmin);
    }
}

my $doRotate = ($rotate =~ /yes/i) || (($rotate =~ /maybe/i) &&
				       ($scaleRotated > $scale));

#########################################################
#   Printing pspicture                                  #
#########################################################

my $pre;
my $post ='}'."\n"; 

if ($doRotate) {
    $descarmA *=  $scaleRotated;
    $pre="\\rotatebox{90}{%\n\\psset{descarmA=$descarmA}%\n";
    if ($scaleRotated<1) {
	$pre .= '\psset{unit='.$scaleRotated.'}%'."\n";
    }
} else {
    $descarmA *= $scale;
    $pre="{%\n\\psset{descarmA=$descarmA}%\n";
    if ($scale<1) {
	$pre .= '{\psset{unit='.$scale.'}%'."\n";
    }
}

print $OUT $pre;

print $OUT '\begin{pspicture}',"($xmin,$ymin)($xmax,$ymax)\n";

print $OUT $root->DrawAll($xdist, $ydist, $belowtextfont, 
			  $abovetextfont, @fieldsforchart);

print $OUT '\end{pspicture}%',"\n";

print $OUT $post;

#########################################################
#   Printing legend                                     #
#########################################################


if ($printlegend) {
    print $OUT $root->PrintAllLegends($lang, @fieldsforlegend);
}

#########################################################
#   Printing end                                        #
#########################################################


if ($fulldoc) {
    printend($OUT);
}

#########################################################
#   Exiting                                             #
#########################################################

exit 0;

#########################################################
#   Subroutines                                         #
#########################################################

#
# Printing headers & footers
#

sub printheader {
    my ($OUT,$lang,$addtopreamble)=@_;
    print $OUT <<END;
$documentheader
\\usepackage{pst-pdgr}
END

    print $OUT $lang->Header;
    print $OUT <<END;
$addtopreamble
\\begin{document}
END
    return 0;
}


sub printend {
    my $OUT=shift;
    print $OUT "\\end{document}\n";
    return 0;
}


