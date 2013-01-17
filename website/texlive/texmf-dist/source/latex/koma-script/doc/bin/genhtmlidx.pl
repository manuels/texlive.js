#! /usr/bin/perl -w
eval 'exec perl -S $0 ${1+"$@"}'
    if 0; #$running_under_some_shell

# ======================================================================
# genhtmlidx.pl
# Copyright (c) Markus Kohm, 2002-2006
#
# This file is part of the LaTeX2e KOMA-Script bundle.
#
# This work may be distributed and/or modified under the conditions of
# the LaTeX Project Public License, version 1.3c of the license.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3c or later is part of all distributions of LaTeX 
# version 2005/12/01 or later and of this work.
#
# This work has the LPPL maintenance status "author-maintained".
#
# The Current Maintainer and author of this work is Markus Kohm.
#
# This work consists of all files listed in manifest.txt.
# ----------------------------------------------------------------------
# genhtmlidx.pl
# Copyright (c) Markus Kohm, 2002-2006
#
# Dieses Werk darf nach den Bedingungen der LaTeX Project Public Lizenz,
# Version 1.3c, verteilt und/oder veraendert werden.
# Die neuste Version dieser Lizenz ist
#   http://www.latex-project.org/lppl.txt
# und Version 1.3c ist Teil aller Verteilungen von LaTeX
# Version 2005/12/01 oder spaeter und dieses Werks.
#
# Dieses Werk hat den LPPL-Verwaltungs-Status "author-maintained"
# (allein durch den Autor verwaltet).
#
# Der Aktuelle Verwalter und Autor dieses Werkes ist Markus Kohm.
# 
# Dieses Werk besteht aus den in manifest.txt aufgefuehrten Dateien.
# ======================================================================
# This perl script generates a html file with an index using the
# \newlabel entries at the aux files.
#
# Usage: genhtmlidx.pl <aux-file> ...
# ----------------------------------------------------------------------
# Dieses perl-Script erzeugt aus den \newlabel-Eintraegen der 
# aux-Dateien eine html-Datei mit einer Art Index.
#
# Verwendung: genhtmlidx.pl <aux-file> ...
# ======================================================================

use strict;

my $auxfile;
my @option;
my @macro;
my @environment;
my @plength;
my @variable;
my @pagestyle;
my @counter;
my @floatstyle;
my @fontelement;
my @file;

my $baselink;
my $htmlhead;
my $htmlend;
my %titles;

my $setup="";
open SETUP,"<htmlsetup" || die "Cannot open htmlsetup!\n";
while (<SETUP>) {
    $setup .= $_;
}
close SETUP;
eval $setup;

while ( $auxfile=shift ) {
    open AUX,"<$auxfile" or die "Cannot read $auxfile!\n";
    while (<AUX>) {
	my $line=$_;
	if ( /^\\newlabel{desc:[^}]+}{{[^}]*}{([^}]*)}{[^}]*}{([^}]*)}/ ) {
	    my $anchor=$2;
	    my $page=$1;
	    my $entry;
	    if ( $anchor =~ /^([^.]+)\.([^.]+)\.([^.]+)$/ ) {
		$entry = "$3.$page.$1.$2";
		if ( "$2" eq "option" ) {
		    push @option,$entry;
		} elsif ( "$2" eq "cmd" ) {
		    push @macro,$entry;
		} elsif ( "$2" eq "env" ) {
		    push @environment,$entry;
		} elsif ( "$2" eq "plength" ) {
		    push @plength,$entry;
		} elsif ( "$2" eq "variable" ) {
		    push @variable,$entry;
		} elsif ( "$2" eq "pagestyle" ) {
		    push @pagestyle,$entry;
		} elsif ( "$2" eq "counter" ) {
		    push @counter,$entry;
		} elsif ( "$2" eq "floatstyle" ) {
		    push @floatstyle,$entry;
		} elsif ( "$2" eq "fontelement" ) {
		    push @fontelement,$entry;
		} elsif ( "$2" eq "package" ) {
		    push @file,$entry;
		} else {
		    print STDERR "Unknown type $2!\n";
		}
	    }
	}
    }
    close AUX;
}

sub process {
    my $group=shift;
    my $prefix=shift;
    my $arrayref=shift;
    my @entries=sort { $a cmp $b } @$arrayref;
    my $entry="";
    if ( @entries > 0 ) {
	print "<h2><a name=\"$group\">$titles{$group}</a></h2>\n";
	print "<ul>\n";
	map {
	    $_ =~ /^([^.]+)\.([^.]+)\.([^.]+)\.([^.]+)$/;
	    if ( $entry ne $1 ) {
		print "</li>\n" if ( $entry ne "" );
		$entry=$1;
		print "<li><a name=\"$4.$entry\"></a><a href=\"\#$4.$entry\">$prefix$entry</a> --&gt; ";
	    } else {
		print ", ";
	    }
	    print "<a href=\"$baselink\#$3.$4.$1\">$2</a>";
	} @entries;
	print "</li>\n" if ( $entry ne "" );
	print "</ul>\n";
    }
}

print $htmlhead;

print "<ul>\n";
print "<li><a href=\"#option\">$titles{option}</a></li>" if ( @option );
print "<li><a href=\"#macro\">$titles{macro}</a></li>" if ( @macro );
print "<li><a href=\"#environment\">$titles{environment}</a></li>" if ( @environment );
print "<li><a href=\"#plength\">$titles{plength}</a></li>" if ( @plength );
print "<li><a href=\"#variable\">$titles{variable}</a></li>" if ( @variable );
print "<li><a href=\"#pagestyle\">$titles{pagestyle}</a></li>" if ( @pagestyle );
print "<li><a href=\"#counter\">$titles{counter}</a></li>" if ( @counter );
print "<li><a href=\"#floatstyle\">$titles{floatstyle}</a></li>" if ( @floatstyle );
#print "<li><a href=\"#fontelement\">$titles{fontelement}</a></li>" if ( @fontelement );
#print "<li><a href=\"#file\">$titles{file}</a></li>" if ( @fontelement );
print "</ul>\n";

process "option","",\@option;
process "macro","\\",\@macro;
process "environment","",\@environment;
process "plength","",\@plength;
process "variable","",\@variable;
process "pagestyle","",\@pagestyle;
process "counter","",\@counter;
process "floatstyle","",\@floatstyle;
#process "fontelement","",\@fontelement;
#process "file","",\@file;
print $htmlend;
