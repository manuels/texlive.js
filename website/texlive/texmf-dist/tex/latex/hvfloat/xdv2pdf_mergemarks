#!/usr/bin/perl

# /****************************************************************************\
#  Part of the XeTeX typesetting system
#  copyright (c) 1994-2005 by SIL International
#  written by Jonathan Kew
# 
#  This software is distributed under the terms of the Common Public License,
#  version 1.0.
#  For details, see <http://www.opensource.org/licenses/cpl1.0.php> or the file
#  cpl1.0.txt included with the software.
# \****************************************************************************/

BEGIN {
	# try to locate our private Perl module directory
	my $p = `kpsewhich -progname=xetex -format=texmfscripts Reuse.pm`;
	chomp $p;
	if ($p eq '') {
		# try a known location
		$p = '/usr/local/teTeX/share/texmf.local/scripts/xetex/perl/lib/PDF/Reuse.pm';
		die "can't find Reuse.pm!" unless -e $p;
	}
	$p =~ s!/PDF/Reuse.pm!!;
	die "perl/lib directory $p not found!" unless -d $p;
	unshift @INC, $p;
};

use strict;
use PDF::Reuse;

die "usage: $0 <pdf-file> <mark-file>\n" unless $#ARGV == 1;

my $infile = $ARGV[0];
my $markfile = $ARGV[1];
my $outfile = "$ARGV[0].tmp";

my $newlink = undef;
my $seenbox = 0;
my %dest;
my @links;
my @bookmarks;

sub toUtf16
{
	my $txt = shift;
	$txt =~ s/\\([\\\(\)])/$1/g;
	$txt = pack('n*', 0xfeff, unpack('U*', $txt));
	$txt =~ s/\\/\\\\/g;
	$txt =~ s/\(/\\(/g;
	$txt =~ s/\)/\\)/g;
	return $txt;
}

open FH, "<:utf8", "$markfile" or die "failed to read mark-file $markfile\n";
while (<FH>) {
	chomp;
	my ($page, $xpos, $ypos, $txt) = split(/\t/, $_, 4);
	if ($txt =~ /^\s*dest/o) {
		$txt =~ /^\s*dest\s+\(([^\)]+)\)\s*(\[.+\])/o;
		my $destname = $1;
		$dest{$destname} = $2;
		my $zp = $page - 1;
		$dest{$destname} =~ s/\/View\s\[(.+)\]/$1/;
		$dest{$destname} =~ s/\@thispage/$zp/;
		$dest{$destname} =~ s/\@xpos/$xpos/;
		$dest{$destname} =~ s/\@ypos/$ypos/;
	}

	elsif ($txt =~ /^\s*bann/o) {
		if ($txt =~ m!<+\s*/Type\s*/Annot\s*/Subtype\s*/Link\s*.*/A\s*<+([^>]+)>>\s*>>!o) {
			$newlink = { page => $page, x => $xpos, y => $ypos, action => $1 };
			if ($txt =~ m!/Border\s*(\[[^]]+\])!o) {
				$newlink->{border} = $1;
			}
			if ($txt =~ m!/C\s*(\[[^]]+\])!o) {
				$newlink->{color} = $1;
			}
		}
		$seenbox = 0;
	}
	
	elsif ($txt =~ /^\s*ABOX/o) {
		if (defined $newlink) {
			$txt =~ m/\[\s*(-?\d+(?:\.\d+)?)\s+(-?\d+(?:\.\d+)?)\s+(-?\d+(?:\.\d+)?)\s+(-?\d+(?:\.\d+)?)\s*\]/o;
			my $boxlink = { page => $newlink->{page}, action => $newlink->{action} };
			$boxlink->{border} = $newlink->{border} if exists $newlink->{border};
			$boxlink->{color} = $newlink->{color} if exists $newlink->{color};
			$boxlink->{x} = $1 < $3 ? $1 : $3;
			$boxlink->{y} = $2 < $4 ? $2 : $4;
			$boxlink->{width} = abs($1 - $3);
			$boxlink->{height} = abs($2 - $4);
			push @links, $boxlink;
			$seenbox = 1;
		}
	}

	elsif ($txt =~ /^\s*eann/o) {
		if ((defined $newlink) && ($seenbox == 0)) {
			$newlink->{width} = $xpos - $newlink->{x};
			if ($newlink->{width} < 0) {
				$newlink->{width} = -$newlink->{width};
				$newlink->{x} = $xpos;
			}
			$newlink->{height} = $ypos - $newlink->{y};
			if ($newlink->{height} < 0) {
				$newlink->{height} = -$newlink->{height};
				$newlink->{y} = $ypos;
			}
			push @links, $newlink;
			undef $newlink;
		}
	}
	
	elsif ($txt =~ /^\s*ann/o) {
		$txt =~ m!width\s+(\d+(?:\.\d*)?)pt\s+height\s+(\d+(?:\.\d*)?)pt\s+.*/A\s*<+([^>]+)>>!o;
		if (defined $1) {
			$newlink = { page => $page, x => $xpos, y => $ypos, width => $1, height => $2, action => $3 };
			if ($txt =~ m!/Border\s*(\[[^]]+\])!o) {
				$newlink->{border} = $1;
			}
			if ($txt =~ m!/C\s*(\[[^]]+\])!o) {
				$newlink->{color} = $1;
			}
			push @links, $newlink;
			undef $newlink;
		}
	}

	elsif ($txt =~ /^\s*outline/o) {
		$txt =~ m!outline\s+(-?\d+)\s*<+\s*/Title\s*\(((?:[^\)]|\\\))+)\)\s*/A\s*<+([^>]+)>>\s*>>!o;
		my ($level, $title, $action) = ($1, $2, $3);
		my $bm = { 'text' => &toUtf16($title), 'pdfact' => $action, '_lvl' => $level };
		if ((scalar @bookmarks == 0) || ($level <= $bookmarks[$#bookmarks]->{'_lvl'})) {
			push @bookmarks, $bm;
		}
		else {
			my $parent = $bookmarks[$#bookmarks];
			my $plevel = $parent->{'_lvl'};
			while ($plevel + 1 < $level) {
				if (exists $parent->{'kids'}) {
					$parent = $parent->{'kids'}[$#{$parent->{'kids'}}];
					$plevel = $parent->{'_lvl'};
				}
				else {
					last;
				}
			}
			push @{$parent->{'kids'}}, $bm;
		}
	}

}
close FH;

fixActions(\@bookmarks);

prFile("$outfile");

prBookmark(\@bookmarks);

foreach (@links) {
	my $action = $_->{action};
	if ($action =~ m!/S\s/GoTo\s/D\s\(([^\)]+)\)!o) {
		my $destname = $1;
		my $explicit = $dest{$destname};
		$action =~ s/\(.+\)/$explicit/;
		$_->{action} = $action;
	}
	prLink($_);
}

prDoc($infile);

prEnd();

unlink($markfile);

unlink($infile);
rename($outfile, $infile);

exit(0);

sub fixActions
{
	my $bookmarks = shift;
	foreach (@$bookmarks) {
		$_->{'pdfact'} = fixAct($_->{'pdfact'});
		if (exists $_->{'kids'}) {
			fixActions($_->{'kids'});
		}
	}
}

sub fixAct
{
	my $action = shift;
	if ($action =~ m!/S\s*/GoTo\s*/D\s*\(([^\)]+)\)!o) {
		my $destname = $1;
		if (exists $dest{$destname}) {
			$action = "/Type /Action /S /GoTo /D $dest{$destname}";
		}
	}
	return $action;
}

