#!/usr/bin/perl
#
# Helper Perl script for ulqda
# A LaTeX package supporting Qualitative Data Analysis
#
# Copyright (C) 2009 by Ivan Griffin
#
# This file may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either
# version 1.2 of this license or (at your option) any later
# version. The latest version of this license is in:
#
# http://www.latex-project.org/lppl.txt
#
# and version 1.2 or later is part of all distributions of
# LaTeX version 1999/12/01 or later.
#

use Getopt::Long;
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);

sub Display_Version()
{
    print "Version: ulqda.pl [2009/06/11 v1.1 Qualitative Data Analysis package]\n\n";
    exit;
}

sub Display_Usage()
{
    print<<"EOF";
Usage: $0 \\
    <--list>|<--graphflat>|<--graphnet>|<--cloud>|<--help>|<--version>  \\
     [<--filter section>] [<--number-->] infile.csv outfile

--filter:      filter based on document section label
--graphflat:   Generate GraphViz .dot output of codes (unconnected)
--graphnet:    Generate GraphViz .dot output of codes (connected)
--cloud:       Generate Cloud output of codes
--help:        Print this help and exit
--list:        Generate LaTeX table of codes (labelled as table:qda_codes)
--number:      Output quantity details
--version:     Dispaly version information
EOF
    exit;
}

sub sort_codes_hashvalue_descending {
    $codes{$b} <=> $codes{$a};
}

sub sort_codes_alphabetic {
    $a cmp $b;
}

@colors = ("#d40000", "#e35a24", "#f67c00", "#faa800", "#ffc000", "#ffde00", "#aae900", "#62dc68", "#bbcced", "#a3bbe0", "#8aaad4", "#7299c7", "#5676b5", "#4554a3", "#2e3191", "#000472");

$result = GetOptions("number" => \$options{'n'},
           "list" => \$options{'l'},
           "cloud" => \$options{'c'},
           "graphflat" => \$options{'g'},
           "filter=s" => \$options{'f'},
           "graphnet" => \$options{'G'},
           "version" => \$options{'v'},
           "help" => \$options{'h'});

&Display_Usage() if !$result;
&Display_Usage() if $options{'h'};

&Display_Version() if $options{'v'};

if (!($options{'c'} || $options{'l'} || $options{'g'} || $options{'G'}))
{
    print "Requires one of --cloud, --list, --graphflat, --graphnet, --version or  --help\n\n";
    &Display_Usage()
}

if (($ARGV[0]) && ($ARGV[1]))
{
    open(FILEIN, "<$ARGV[0]") or die "Could not open input file $ARGV[0]\n";
    open(FILEOUT, ">$ARGV[1]") or die "Could not open output file $ARGV[1]\n";
}
else
{
    &Display_Usage();
}

if ($options{'l'})
{
    print FILEOUT << "EOF";
{
\\vspace{0.1in}
\\hrule

\\begin{multicols}{3}
\\label{table:qda_codes}
EOF
}
elsif ($options{'c'})
{
    #
    print FILEOUT << "EOF";
{
\\begin{center}
\\noindent%
EOF
}
elsif ($options{'g'} || $options{'G'})
{
    print FILEOUT << "EOF";
digraph codes {
overlap=scale
ratio=compress
smoothType=spring
repulsiveforce=1.2
splines=true

#
# Nodes
#
EOF
}

<FILEIN>; # gobble first line (it is just header)

# now, for each line, parse into comma separated values
# codes are further split based on the '!' separator character
# e.g. risk!business becomes two codes, risk and business, with a
# connection between risk->business
GOBBLE_LOOP: while (<FILEIN>)
{
    chomp;
    ($page, $section, $code_list, $text) = split(/\,/, $_, 4);
#print"DEBUG: >>$code_list<< $_ \n";

    if (($options{'f'}) && ($options{'f'} != $section))
    {
        # filtering selected so if no match, then skip
        next GOBBLE_LOOP;
    }

    foreach $code ( split(/\!/, $code_list) )
    {
        $code =~ s/^ //g;
        $codes{$code} += 1;
    }

    @connections = (@connections, $code_list);
}
close(FILEIN);

#
# Find the maximum number of connections and the minimum number of connections
# This will be used for scaling subsequently
#
$iterationCount = 0; $nodeCount = 0;
$maxConnections = 0; $minConnections=65535;

if ($options{'c'})
{
    @key_list = (sort sort_codes_alphabetic keys %codes);
}
else
{
    @key_list = (sort sort_codes_hashvalue_descending keys %codes);
}

LOOP: foreach $i (sort sort_codes_hashvalue_descending keys %codes)
{
    if ($codes{$i} > $maxConnections) { $maxConnections = $codes{$i} }
    if ($codes{$i} < $minConnections) { $minConnections = $codes{$i} }
}

#
# For each code, output it as requested
#
foreach $i (@key_list)
{
    $digest = sha1_hex($i);

    if ($options{'l'} && ($iterationCount))
    {
         print FILEOUT "\\\\\n";
    }
    elsif ($options{'c'})
    {
         my $base = int(7 + ($codes{$i}/3));
         my $lead = $base + 3;
         my $raisept = int(($base - 7)/4);

         if ($raisept) { print FILEOUT "\\raisebox{-${raisept}pt}";}
         print FILEOUT "{\\fontsize{$base}{$lead}\\selectfont ";
    }
    elsif ($options{'g'} || $options{'G'})
    {
         $nodeCount++;
         print FILEOUT "Node$digest [label=\"";
    }

    $i =~ s/!/:/g;
    print FILEOUT "$i";

    if ($options{'c'})
     {
        print FILEOUT "}\n";
    }
    elsif ($options{'n'})
    {
        print FILEOUT "{\\textcolor{red}{" if ($options{'l'});
        print FILEOUT "($codes{$i})";
        print FILEOUT "}}" if ($options{'l'});
    }

    if ($options{'g'} || $options{'G'})
    {
         $fontSize = 15 + ((60 * $codes{$i})/$maxConnections);
         print FILEOUT "\", fontsize=$fontSize";
         #if ($iterationCount <= 5)
         {
             # heatmap based colors
             # $colorIndex = 6 - int((6*($codes{$i} - $minConnections))/($maxConnections - $minConnections));
             # index based colors
             $colorIndex = int(($iterationCount*16)/(keys %codes));
             print FILEOUT ",color=\"$colors[$colorIndex]\",style=filled";
         }
         print FILEOUT "]\n";
    }
    elsif (! ($options{'l'} || $options{'c'}) )
    {
        print FILEOUT "\n";
    }
    $iterationCount++;
}

#
# For connection graphs, process each connection between points
#
if ($options{'G'})
{
    print FILEOUT <<"EOF";

#
# Connections
#
EOF

    for $code_list (@connections)
    {
        print FILEOUT "// $code_list\n";
        @code_list_array = split(/\!/, $code_list);
        $previous_code = shift(@code_list_array);
        $previous_code =~ s/^ //g;

        if (defined($previous_code))
        {
            foreach $code ( @code_list_array )
            {
                $code =~ s/^ //g;
                $previous_digest = sha1_hex($previous_code);
                $digest = sha1_hex($code);

                # ensure only 1 connection between points
                if (!defined($connection{"$previous_digest-$digest"}))
                {
                    $connection{"$previous_digest-$digest"} = 1;
                    $len=0.25+(0.75*$codes{$previous_code}/$maxConnections);
                    $w=0.25+(0.75*$codes{$previous_code}/$maxConnections);
                    print FILEOUT "Node$previous_digest->Node$digest [label=\"\", w=$w, len=$len]\n";
                }

                $previous_code = $code;
            }
        }
    }
}

#
# Tidy up
#
if ($options{'l'})
{
    print FILEOUT << "EOF";
\\end{multicols}
\\hrule
EOF
}
elsif ($options{'c'})
{
    print FILEOUT << "EOF";
\\end{center}
EOF
}

print FILEOUT "\n}\n";

close(FILEOUT);
