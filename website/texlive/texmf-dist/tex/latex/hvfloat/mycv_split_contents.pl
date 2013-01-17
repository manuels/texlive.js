#!/usr/bin/perl

# -------------------------------------------------------
# Copyright 2012 Ghersi Andrea (ghanhawk@gmail.com).
#
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License version
# 1.3c, available at 'http://www.latex-project.org/lppl'.
# -------------------------------------------------------

# $Id: mycv_split_contents.pl 89 2012-05-19 18:23:03Z ghangenit $

use Getopt::Long;
use File::Path;
use warnings;
use strict;
use Cwd;

# hashes with errors and warnings messages

my %errors = (
    OME => "$0: ERROR opening <%s> in output mode (CWD: %s): %s\n",
    IME => "$0: ERROR opening <%s> in input mode (CWD: %s): %s\n",
    NIF => "$0: ERROR: no input file provided!\nUse the option <-i infile>.\n",
    NOD => "$0: ERROR: no output dir. provided!\nUse the option <-o outdir>.\n",
    IOE => "$0: ERROR: input file and output dir are the same!\n"
);

my %warnings = (
    NVC => "WARNING:: <%s> is not recognized as a valid component!\n" .
           "A component can only be 'header', 'body' or 'footer'.\n"
);

my $outdir = 'Contents';         # default output dir
my $infile = 'cv_contents.tex';  # default input file
my $cwd = getcwd();              # current directory
my %opt = ();                    # hash for options

###
###

sub _usage()
{
    print STDERR << "EOF";

    Usage: $0 [-h] [-e] [-i infile] [-o outdir] [-m modelfile]
    Version <1.0>

    Options:
    ========

    -o outdir  \t  : uses <outdir> as output dir {default: 'Contents'}
    -m mdlfile \t  : writes basic model directives to the <mdlfile> file
    -i infile  \t  : uses <infile> as input file {default: 'cv_contents.tex'}
    -e         \t  : keeps file names extension in model directives
    -h         \t  : this help message

    Examples:
    =========

    1) Splits the input file 'cv_contents.tex' into multiple files (they
       will be created in the directory 'Contents'), as specified in the
       file itself - the input file is not modified:

          [$0 -i cv_contents.tex]

    2) As above but, in addiction, a basic model file (model-spl.tex) for
       multiple files is created (in the model directives, the file names
       extension will be removed):

          [$0 -i cv_contents.tex -m model-spl.tex]

    3) As above, but file names in the model directives will keep their
       own extension:

          [$0 -i cv_contents.tex -m model-spl.tex -e]

EOF
    exit 0;
}

###
###

sub mcdie { printf STDERR @_, $!; exit 1; }

###
###

sub processCommandLine()
{
    GetOptions (
      'o=s' => \$opt{o}, 'i=s' => \$opt{i},
      'm=s' => \$opt{m}, 'h'   => \$opt{h},
      'e'   => \$opt{e}
    ) or _usage();

    $opt{h} and _usage();
    _usage() if ( $#ARGV > -1 );

    _dealWithInOutFiles();
    return \%opt;
}

###
###

sub _dealWithInOutFiles
{
    $opt{o} and $outdir = $opt{o};
    $opt{i} and $infile = $opt{i};

    if ( $infile eq "" ){ die $errors{NIF} }
    if ( $outdir eq "" ){ die $errors{NOD} }
    if ( $infile eq $outdir ){ die $errors{IOE} }

    $opt{outdir} = $outdir;
    $opt{infile} = $infile;
}

###
###

sub fileprocess ($)
{
    my $cmdoptions = shift;
    my $outdir = $cmdoptions->{'outdir'};
    my $linehook = '###';
    my %components;
    my $sep = '::';

    open INFILE, $cmdoptions->{'infile'} or
        mcdie( $errors{IME}, $cmdoptions->{'infile'}, $cwd );

    mkpath($outdir);
    (-d $outdir) or mcdie( $errors{OME}, $outdir, $cwd );

    while ( my $line = <INFILE> )
    {
        my @info; my $ctype='';
        if ( $line =~ /$linehook/ )
        {
            PROCESSLINE:
            @info = split(/$sep/, $line);

            $ctype=$info[2]; # contains the component type (header,...)
            chomp($ctype);

            if ( $info[2] )
            {
                if ( $ctype =~ /header/ ) { push (@{$components{h}}, $line) }
                elsif ( $ctype =~ /body/ ){ push (@{$components{b}}, $line) }
                elsif ( $ctype =~ /footer/ ){ push (@{$components{f}}, $line) }
                else { printf STDERR $warnings{NVC}, $ctype }
            }

            if ( $info[1] ) # contains the file name to write
            {
                open OUTFILE, '>', "$outdir/$info[1]" or
                    mcdie( $errors{OME}, $info[1], $cwd );

                while ( $line = <INFILE> )
                {
                    if ( $line =~ /$linehook/ )
                    {
                        close OUTFILE;
                        goto PROCESSLINE;
                    }
                    else { print OUTFILE $line } # write to file
                }
            }
        }
    }

    close INFILE;
    if ( $cmdoptions->{'m'} )
    {
        open OUTFILE, '>', $cmdoptions->{'m'} or
            mcdie( $errors{OME}, $cmdoptions->{'m'}, $cwd );

        for my $key ( keys %components )
        {
            if ( $key eq "b" )    { print OUTFILE "\\def\\bodylayoutlist{%\n" }
            elsif ( $key eq "h" ) { print OUTFILE "\\def\\headerlayoutlist{%\n" }
            elsif ( $key eq "f" ) { print OUTFILE "\\def\\footerlayoutlist{%\n" }

            my @info; my $cnt=0; my $fname='';
            while ( $components{$key}[$cnt] )
            {
                @info = split(/$sep/, $components{$key}[$cnt]);
                $cnt++;

                $fname=$info[1];
                if ( !$cmdoptions->{'e'} ){ $fname =~ s{\.[^.]+$}{} }
                if ( $info[1] ){ chomp($fname); print OUTFILE "   $fname@" }
                if ( $info[3] ){ chomp($info[3]); print OUTFILE ":$info[3]" }
                print OUTFILE ",\n";
            }
            print OUTFILE "}\n";
        }
        close OUTFILE;
    }
}

##
## MAIN
##

fileprocess( processCommandLine() );
