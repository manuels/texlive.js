#! /usr/bin/perl

##################################################
# Convert stylized Metafont to PostScript Type 1 #
# By Scott Pakin <scott+mf@pakin.org>            #
##################################################

########################################################################
# mf2pt1                                                               #
# Copyright (C) 2012 Scott Pakin                                       #
#                                                                      #
# This program may be distributed and/or modified under the conditions #
# of the LaTeX Project Public License, either version 1.3c of this     #
# license or (at your option) any later version.                       #
#                                                                      #
# The latest version of this license is in:                            #
#                                                                      #
#    http://www.latex-project.org/lppl.txt                             #
#                                                                      #
# and version 1.3c or later is part of all distributions of LaTeX      #
# version 2006/05/20 or later.                                         #
########################################################################

our $VERSION = "2.4.6";   # mf2pt1 version number
require 5.6.1;            # I haven't tested mf2pt1 with older Perl versions

use File::Basename;
use File::Spec;
use Getopt::Long;
use Pod::Usage;
use Math::Trig;
use warnings;
use strict;

# Define some common encoding vectors.
my @standardencoding =
    ((map {"_a$_"} (0..31)),
     qw (space exclam quotedbl numbersign dollar percent ampersand
         quoteright parenleft parenright asterisk plus comma hyphen
         period slash zero one two three four five six seven eight
         nine colon semicolon less equal greater question at A B C D E
         F G H I J K L M N O P Q R S T U V W X Y Z bracketleft
         backslash bracketright asciicircum underscore quoteleft a b c
         d e f g h i j k l m n o p q r s t u v w x y z braceleft bar
         braceright asciitilde),
     (map {"_a$_"} (127..160)),
     qw (exclamdown cent sterling fraction yen florin section currency
         quotesingle quotedblleft guillemotleft guilsinglleft
         guilsinglright fi fl _a176 endash dagger daggerdbl
         periodcentered _a181 paragraph bullet quotesinglbase
         quotedblbase quotedblright guillemotright ellipsis
         perthousand _a190 questiondown _a192 grave acute circumflex
         tilde macron breve dotaccent dieresis _a201 ring cedilla
         _a204 hungarumlaut ogonek caron emdash),
     (map {"_a$_"} (209..224)),
     qw (AE _a226 ordfeminine _a228 _a229 _a230 _a231 Lslash Oslash OE
         ordmasculine _a236 _a237 _a238 _a239 _a240 ae _a242 _a243
         _a244 dotlessi _a246 _a247 lslash oslash oe germandbls _a252
         _a253 _a254 _a255));
my @isolatin1encoding =
    ((map {"_a$_"} (0..31)),
     qw (space exclam quotedbl numbersign dollar percent ampersand
         quoteright parenleft parenright asterisk plus comma minus
         period slash zero one two three four five six seven eight
         nine colon semicolon less equal greater question at A B C D E
         F G H I J K L M N O P Q R S T U V W X Y Z bracketleft
         backslash bracketright asciicircum underscore quoteleft a b c
         d e f g h i j k l m n o p q r s t u v w x y z braceleft bar
         braceright asciitilde),
     (map {"_a$_"} (128..143)),
     qw (dotlessi grave acute circumflex tilde macron breve dotaccent
         dieresis _a153 ring cedilla _a156 hungarumlaut ogonek
         caron space exclamdown cent sterling currency yen brokenbar
         section dieresis copyright ordfeminine guillemotleft
         logicalnot hyphen registered macron degree plusminus
         twosuperior threesuperior acute mu paragraph periodcentered
         cedilla onesuperior ordmasculine guillemotright onequarter
         onehalf threequarters questiondown Agrave Aacute Acircumflex
         Atilde Adieresis Aring AE Ccedilla Egrave Eacute Ecircumflex
         Edieresis Igrave Iacute Icircumflex Idieresis Eth Ntilde
         Ograve Oacute Ocircumflex Otilde Odieresis multiply Oslash
         Ugrave Uacute Ucircumflex Udieresis Yacute Thorn germandbls
         agrave aacute acircumflex atilde adieresis aring ae ccedilla
         egrave eacute ecircumflex edieresis igrave iacute icircumflex
         idieresis eth ntilde ograve oacute ocircumflex otilde
         odieresis divide oslash ugrave uacute ucircumflex udieresis
         yacute thorn ydieresis));
my @ot1encoding =
    qw (Gamma Delta Theta Lambda Xi Pi Sigma Upsilon Phi
        Psi Omega ff fi fl ffi ffl dotlessi dotlessj grave acute caron
        breve macron ring cedilla germandbls ae oe oslash AE OE Oslash
        suppress exclam quotedblright numbersign dollar percent
        ampersand quoteright parenleft parenright asterisk plus comma
        hyphen period slash zero one two three four five six seven
        eight nine colon semicolon exclamdown equal questiondown
        question at A B C D E F G H I J K L M N O P Q R S T U V W X Y
        Z bracketleft quotedblleft bracketright circumflex dotaccent
        quoteleft a b c d e f g h i j k l m n o p q r s t u v w x y z
        endash emdash hungarumlaut tilde dieresis);
my @t1encoding =
    qw (grave acute circumflex tilde dieresis hungarumlaut ring caron
        breve macron dotaccent cedilla ogonek quotesinglbase
        guilsinglleft guilsinglright quotedblleft quotedblright
        quotedblbase guillemotleft guillemotright endash emdash cwm
        perthousand dotlessi dotlessj ff fi fl ffi ffl space exclam
        quotedbl numbersign dollar percent ampersand quoteright
        parenleft parenright asterisk plus comma hyphen period slash
        zero one two three four five six seven eight nine colon
        semicolon less equal greater question at A B C D E F G H I J K L
        M N O P Q R S T U V W X Y Z bracketleft backslash bracketright
        asciicircum underscore quoteleft a b c d e f g h i j k l m n o p
        q r s t u v w x y z braceleft bar braceright asciitilde
        sfthyphen Abreve Aogonek Cacute Ccaron Dcaron Ecaron Eogonek
        Gbreve Lacute Lcaron Lslash Nacute Ncaron Eng Ohungarumlaut
        Racute Rcaron Sacute Scaron Scedilla Tcaron Tcedilla
        Uhungarumlaut Uring Ydieresis Zacute Zcaron Zdotaccent IJ
        Idotaccent dcroat section abreve aogonek cacute ccaron dcaron
        ecaron eogonek gbreve lacute lcaron lslash nacute ncaron eng
        ohungarumlaut racute rcaron sacute scaron scedilla tcaron
        tcedilla uhungarumlaut uring ydieresis zacute zcaron zdotaccent
        ij exclamdown questiondown sterling Agrave Aacute Acircumflex
        Atilde Adieresis Aring AE Ccedilla Egrave Eacute Ecircumflex
        Edieresis Igrave Iacute Icircumflex Idieresis Eth Ntilde Ograve
        Oacute Ocircumflex Otilde Odieresis OE Oslash Ugrave Uacute
        Ucircumflex Udieresis Yacute Thorn SS agrave aacute acircumflex
        atilde adieresis aring ae ccedilla egrave eacute ecircumflex
        edieresis igrave iacute icircumflex idieresis eth ntilde ograve
        oacute ocircumflex otilde odieresis oe oslash ugrave uacute
        ucircumflex udieresis yacute thorn germandbls);

# Define font parameters that the user can override.
my $fontversion;
my $creationdate;
my $comment;
my $familyname;
my $weight;
my $fullname;
my $fixedpitch;
my $italicangle;
my $underlinepos;
my $underlinethick;
my $fontname;
my $uniqueID;
my $designsize;
my ($mffile, $pt1file, $pfbfile, $ffscript);
my $encoding;
my $rounding;
my $bpppix;

# Define all of our other global variables.
my $progname = basename $0, ".pl";
my $mag;
my @fontbbox;
my @charbbox;
my @charwd;
my @glyphname;
my @charfiles;
my $filebase;
my $filedir;
my $filenoext;
my $versionmsg = "mf2pt1 version $VERSION

Copyright (C) 2012 Scott Pakin

This program may be distributed and/or modified under the conditions
of the LaTeX Project Public License, either version 1.3c of this
license or (at your option) any later version.

The latest version of this license is in:

   http://www.latex-project.org/lppl.txt

and version 1.3c or later is part of all distributions of LaTeX
version 2006/05/20 or later.
";


######################################################################

# The routines to compute the fractional approximation of a real number
# are heavily based on code posted by Ben Tilly
# <http://www.perlmonks.org/?node_id=26179> on Nov 16th, 2000, to the
# PerlMonks list.  See <http://www.perlmonks.org/index.pl?node_id=41961>.


# Takes numerator/denominator pairs.
# Returns a PS fraction string representation (with a trailing space).
sub frac_string (@)
{
    my $res = "";

    while (@_) {
        my $n = shift;
        my $d = shift;
        $res .= $n . " ";
        $res .= $d . " div " if $d > 1;
    }

    return $res;
}


# Takes a number.
# Returns a numerator and denominator with the smallest denominator
# so that the difference of the resulting fraction to the number is
# smaller or equal to $rounding.
sub frac_approx ($)
{
    my $num = shift;
    my $f = ret_frac_iter ($num);

    while (1) {
        my ($n, $m) = $f->();
        my $approx = $n / $m;
        my $delta = abs ($num - $approx);
        return ($n, $m) if ($delta <= $rounding);
    }
}


# Takes a number, returns the best integer approximation and (in list
# context) the error.
sub best_int ($)
{
    my $x = shift;
    my $approx = sprintf '%.0f', $x;
    if (wantarray) {
        return ($approx, $x - $approx);
    }
    else {
        return $approx;
    }
}


# Takes a numerator and denominator, in scalar context returns
# the best fraction describing them, in list the numerator and
# denominator.
sub frac_standard ($$)
{
    my $n = best_int(shift);
    my $m = best_int(shift);
    my $k = gcd($n, $m);
    $n /= $k;
    $m /= $k;
    if ($m < 0) {
        $n *= -1;
        $m *= -1;
    }
    if (wantarray) {
        return ($n, $m);
    }
    else {
        return "$n/$m";
    }
}


# Euclidean algorithm for calculating a GCD.
# Takes two integers, returns the greatest common divisor.
sub gcd ($$)
{
    my ($n, $m) = @_;
    while ($m) {
        my $k = $n % $m;
        ($n, $m) = ($m, $k);
    }
    return $n;
}


# Takes a list of terms in a continued fraction, and converts it
# into a fraction.
sub ints_to_frac (@)
{
    my ($n, $m) = (0, 1);     # Start with 0
    while (@_) {
        my $k = pop;
        if ($n) {
            # Want frac for $k + 1/($n/$m)
            ($n, $m) = frac_standard($k*$n + $m, $n);
        }
        else {
            # Want $k
            ($n, $m) = frac_standard($k, 1);
        }
    }
    return frac_standard($n, $m);
}


# Takes a number, returns an anon sub which iterates through a set of
# fractional approximations that converges very quickly to the number.
sub ret_frac_iter ($)
{
    my $x = shift;
    my $term_iter = ret_next_term_iter($x);
    my @ints;
    return sub {
        push @ints, $term_iter->();
        return ints_to_frac(@ints);
    }
}


# Terms of a continued fraction converging on that number.
sub ret_next_term_iter ($)
{
    my $x = shift;
    return sub {
        (my $n, $x) = best_int($x);
        if (0 != $x) {
            $x = 1/$x;
        }
        return $n;
    }
}

######################################################################

# Round a number to the nearest integer.
sub round ($)
{
    return int($_[0] + 0.5*($_[0] <=> 0));
}


# Round a number to a given precision.
sub prec ($)
{
  return round ($_[0] / $rounding) * $rounding;
}


# Set a variable's value to the first defined value in the given list.
# If the variable was not previously defined and no value in the list
# is defined, do nothing.
sub assign_default (\$@)
{
    my $varptr = shift;        # Pointer to variable to define
    return if defined $$varptr && $$varptr ne "UNSPECIFIED";
    foreach my $val (@_) {
        next if !defined $val;
        $$varptr = $val;
        return;
    }
}


# Print and execute a shell command.  An environment variable with the
# same name as the command overrides the command name.  Return 1 on
# success, 0 on failure.  Optionally abort if the command fails, based
# on the first argument to execute_command.
sub execute_command ($@)
{
    my $abort_on_failure = shift;
    my @command = @_;
    $command[0] = $ENV{uc $command[0]} || $command[0];
    my $prettyargs = join (" ", map {/[\\ ]/ ? "'$_'" : $_} @command);
    print "Invoking \"$prettyargs\"...\n";
    my $result = system @command;
    die "${progname}: \"$prettyargs\" failed ($!)\n" if $result && $abort_on_failure;
    return !$result;
}


# Output the font header.
sub output_header ()
{
    # Show the initial boilerplate.
    print OUTFILE <<"ENDHEADER";
%!FontType1-1.0: $fontname $fontversion
%%CreationDate: $creationdate
% Font converted to Type 1 by mf2pt1, written by Scott Pakin.
11 dict begin
/FontInfo 11 dict dup begin
/version ($fontversion) readonly def
/Notice ($comment) readonly def
/FullName ($fullname) readonly def
/FamilyName ($familyname) readonly def
/Weight ($weight) readonly def
/ItalicAngle $italicangle def
/isFixedPitch $fixedpitch def
/UnderlinePosition $underlinepos def
/UnderlineThickness $underlinethick def
end readonly def
/FontName /$fontname def
ENDHEADER

    # If we're not using an encoding that PostScript knows about, then
    # create an encoding vector.
    if ($encoding==\@standardencoding) {
        print OUTFILE "/Encoding StandardEncoding def\n";
    }
    else {
        print OUTFILE "/Encoding 256 array\n";
        print OUTFILE "0 1 255 {1 index exch /.notdef put} for\n";
        foreach my $charnum (0 .. $#{$encoding}) {
            if ($encoding->[$charnum] && $encoding->[$charnum]!~/^_a\d+$/) {
                print OUTFILE "dup $charnum /$encoding->[$charnum] put\n";
            }
        }
        print OUTFILE "readonly def\n";
    }

    # Show the final boilerplate.
    print OUTFILE <<"ENDHEADER";
/PaintType 0 def
/FontType 1 def
/FontMatrix [0.001 0 0 0.001 0 0] readonly def
/UniqueID $uniqueID def
/FontBBox{@fontbbox}readonly def
currentdict end
currentfile eexec
dup /Private 5 dict dup begin
/RD{string currentfile exch readstring pop}executeonly def
/ND{noaccess def}executeonly def
/NP{noaccess put}executeonly def
ENDHEADER
}


# Use MetaPost to generate one PostScript file per character.  We
# calculate the font bounding box from these characters and store them
# in @fontbbox.  If the input parameter is 1, set other font
# parameters, too.
sub get_bboxes ($)
{
    execute_command 1, ("mpost", "-mem=mf2pt1", "-progname=mpost",
                        "\\mode:=localfont; mag:=$mag; bpppix $bpppix; nonstopmode; input $mffile");
    opendir (CURDIR, ".") || die "${progname}: $! ($filedir)\n";
    @charfiles = sort
                   { ($a=~ /\.(\d+)$/)[0] <=> ($b=~ /\.(\d+)$/)[0] }
                   grep /^$filebase.*\.\d+$/, readdir(CURDIR);
    close CURDIR;
    @fontbbox = (1000000, 1000000, -1000000, -1000000);
    foreach my $psfile (@charfiles) {
        # Read the character number from the output file's extension.
        $psfile =~ /\.(\d+)$/;
        my $charnum = $1;

        # Process in turn each line of the current PostScript file.
        my $havebbox = 0;
        open (PSFILE, "<$psfile") || die "${progname}: $! ($psfile)\n";
        while (<PSFILE>) {
            my @tokens = split " ";
            if ($tokens[0] eq "%%BoundingBox:") {
                # Store the MetaPost-produced bounding box, just in case
                # the given font doesn't use beginchar.
                @tokens = ("%", "MF2PT1:", "glyph_dimensions", @tokens[1..4]);
                $havebbox--;
            }
            next if $#tokens<1 || $tokens[1] ne "MF2PT1:";

            # Process a "special" inserted into the generated PostScript.
          MF2PT1_CMD:
            {
                # glyph_dimensions llx lly urx ury -- specified glyph dimensions
                $tokens[2] eq "glyph_dimensions" && do {
                    my @bbox = @tokens[3..6];
                    $fontbbox[0]=$bbox[0] if $bbox[0]<$fontbbox[0];
                    $fontbbox[1]=$bbox[1] if $bbox[1]<$fontbbox[1];
                    $fontbbox[2]=$bbox[2] if $bbox[2]>$fontbbox[2];
                    $fontbbox[3]=$bbox[3] if $bbox[3]>$fontbbox[3];
                    $charbbox[$charnum] = \@bbox;
                    $havebbox++;
                    last MF2PT1_CMD;
                };

                # If all we want is the bounding box, exit the loop now.
                last MF2PT1_CMD if !$_[0];

                # glyph_name name -- glyph name
                $tokens[2] eq "glyph_name" && do {
                    $glyphname[$charnum] = $tokens[3];
                    last MF2PT1_CMD;
                };

                # charwd wd -- character width as in TFM
                $tokens[2] eq "charwd" && do {
                    $charwd[$charnum] = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_identifier name -- full font name
                $tokens[2] eq "font_identifier" && do {
                    $fullname = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_size number -- font design size (pt, not bp)
                $tokens[2] eq "font_size" && $tokens[3] && do {
                    $designsize = $tokens[3] * 72 / 72.27;
                    last MF2PT1_CMD;
                };

                # font_slant number -- italic amount
                $tokens[2] eq "font_slant" && do {
                    $italicangle = 0 + rad2deg (atan(-$tokens[3]));
                    last MF2PT1_CMD;
                };

                # font_coding_scheme string -- font encoding
                $tokens[2] eq "font_coding_scheme" && do {
                    $encoding = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_version string -- font version number (xxx.yyy)
                $tokens[2] eq "font_version" && do {
                    $fontversion = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_comment string -- font comment notice
                $tokens[2] eq "font_comment" && do {
                    $comment = join (" ", @tokens[3..$#tokens]);
                    last MF2PT1_CMD;
                };

                # font_family string -- font family name
                $tokens[2] eq "font_family" && do {
                    $familyname = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_weight string -- font weight (e.g., "Book" or "Heavy")
                $tokens[2] eq "font_weight" && do {
                    $weight = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_fixed_pitch number -- fixed width font (0=false, 1=true)
                $tokens[2] eq "font_fixed_pitch" && do {
                    $fixedpitch = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_underline_position number -- vertical underline position
                $tokens[2] eq "font_underline_position" && do {
                    # We store $underlinepos in points and later
                    # scale it by 1000/$designsize.
                    $underlinepos = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_underline_thickness number -- thickness of underline
                $tokens[2] eq "font_underline_thickness" && do {
                    # We store $underlinethick in points and later
                    # scale it by 1000/$designsize.
                    $underlinethick = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_name string -- font name
                $tokens[2] eq "font_name" && do {
                    $fontname = $tokens[3];
                    last MF2PT1_CMD;
                };

                # font_unique_id number (as string) -- globally unique font ID
                $tokens[2] eq "font_unique_id" && do {
                    $uniqueID = 0+$tokens[3];
                    last MF2PT1_CMD;
                };
            }
        }
        close PSFILE;
        if (!$havebbox) {
            warn "${progname}: No beginchar in character $charnum; glyph dimensions are probably incorrect\n";
        }
    }
}


# Convert ordinary, MetaPost-produced PostScript files into Type 1
# font programs.
sub output_font_programs ()
{
    # Iterate over all the characters.  We convert each one, line by
    # line and token by token.
    print "Converting PostScript graphics to Type 1 font programs...\n";
    foreach my $psfile (@charfiles) {
        # Initialize the font program.
        $psfile =~ /\.(\d+)$/;
        my $charnum = $1;
        my $gname = $glyphname[$charnum] || $encoding->[$charnum];
        my @fontprog;
        push @fontprog, ("/$gname {",
                         frac_string (frac_approx ($charbbox[$charnum]->[0]),
                                      frac_approx ($charwd[$charnum] * $mag))
                         . "hsbw");
        my ($cpx, $cpy) =
            ($charbbox[$charnum]->[0], 0);  # Current point (PostScript)

        # Iterate over every line in the current file.
        open (PSFILE, "<$psfile") || die "${progname}: $! ($psfile)\n";
        while (my $oneline=<PSFILE>) {
            next if $oneline=~/^\%/;
            next if $oneline=~/set/;   # Fortunately, "set" never occurs on "good" lines.
            my @arglist;   # Arguments to current PostScript function

            # Iterate over every token in the current line.
          TOKENLOOP:
            foreach my $token (split " ", $oneline) {
                # Number: Round and push on the argument list.
                $token =~ /^[-.\d]+$/ && do {
                    push @arglist, prec ($&);
                    next TOKENLOOP;
                };

                # curveto: Convert to vhcurveto, hvcurveto, or rrcurveto.
                $token eq "curveto" && do {
                    my ($dx1, $dy1) = ($arglist[0] - $cpx,
                                       $arglist[1] - $cpy);
                    my ($dx1n, $dx1d) = frac_approx ($dx1);
                    my ($dy1n, $dy1d) = frac_approx ($dy1);
                    $cpx += $dx1n / $dx1d;
                    $cpy += $dy1n / $dy1d;

                    my ($dx2, $dy2) = ($arglist[2] - $cpx,
                                       $arglist[3] - $cpy);
                    my ($dx2n, $dx2d) = frac_approx ($dx2);
                    my ($dy2n, $dy2d) = frac_approx ($dy2);
                    $cpx += $dx2n / $dx2d;
                    $cpy += $dy2n / $dy2d;

                    my ($dx3, $dy3) = ($arglist[4] - $cpx,
                                       $arglist[5] - $cpy);
                    my ($dx3n, $dx3d) = frac_approx ($dx3);
                    my ($dy3n, $dy3d) = frac_approx ($dy3);
                    $cpx += $dx3n / $dx3d;
                    $cpy += $dy3n / $dy3d;

                    if (!$dx1n && !$dy3n) {
                        push @fontprog, frac_string ($dy1n, $dy1d,
                                                     $dx2n, $dx2d,
                                                     $dy2n, $dy2d,
                                                     $dx3n, $dx3d)
                                        . "vhcurveto";
                    }
                    elsif (!$dy1n && !$dx3n) {
                        push @fontprog, frac_string ($dx1n, $dx1d,
                                                     $dx2n, $dx2d,
                                                     $dy2n, $dy2d,
                                                     $dy3n, $dy3d)
                                        . "hvcurveto";
                    }
                    else {
                        push @fontprog, frac_string ($dx1n, $dx1d,
                                                     $dy1n, $dy1d,
                                                     $dx2n, $dx2d,
                                                     $dy2n, $dy2d,
                                                     $dx3n, $dx3d,
                                                     $dy3n, $dy3d)
                                        . "rrcurveto";
                    }
                    next TOKENLOOP;
                };

                # lineto: Convert to vlineto, hlineto, or rlineto.
                $token eq "lineto" && do {
                    my ($dx, $dy) = ($arglist[0] - $cpx,
                                     $arglist[1] - $cpy);
                    my ($dxn, $dxd) = frac_approx ($dx);
                    my ($dyn, $dyd) = frac_approx ($dy);
                    $cpx += $dxn / $dxd;
                    $cpy += $dyn / $dyd;

                    if (!$dxn) {
                        push @fontprog, frac_string ($dyn, $dyd)
                                        . "vlineto" if $dyn;
                    }
                    elsif (!$dyn) {
                        push @fontprog, frac_string ($dxn, $dxd)
                                        . "hlineto";
                    }
                    else {
                        push @fontprog, frac_string ($dxn, $dxd, $dyn, $dyd)
                                        . "rlineto";
                    }
                    next TOKENLOOP;
                };

                # moveto: Convert to vmoveto, hmoveto, or rmoveto.
                $token eq "moveto" && do {
                    my ($dx, $dy) = ($arglist[0] - $cpx,
                                     $arglist[1] - $cpy);
                    my ($dxn, $dxd) = frac_approx ($dx);
                    my ($dyn, $dyd) = frac_approx ($dy);
                    $cpx += $dxn / $dxd;
                    $cpy += $dyn / $dyd;

                    if (!$dxn) {
                        push @fontprog, frac_string ($dyn, $dyd)
                                        . "vmoveto";
                    }
                    elsif (!$dyn) {
                        push @fontprog, frac_string ($dxn, $dxd)
                                        . "hmoveto";
                    }
                    else {
                        push @fontprog, frac_string ($dxn, $dxd, $dyn, $dyd)
                                        . "rmoveto";
                    }
                    next TOKENLOOP;
                };

                # closepath: Output as is.
                $token eq "closepath" && do {
                    push @fontprog, $token;
                    next TOKENLOOP;
                };
            }
        }
        close PSFILE;
        push @fontprog, ("endchar",
                         "} ND");
        print OUTFILE join ("\n\t", @fontprog), "\n";
    }
}


# Output the final set of code for the Type 1 font.
sub output_trailer ()
{
    print OUTFILE <<"ENDTRAILER";
/.notdef {
        0 @{[frac_string (frac_approx ($fontbbox[2] - $fontbbox[0]))]} hsbw
        endchar
        } ND
end
end
readonly put
noaccess put
dup/FontName get exch definefont pop
mark currentfile closefile
cleartomark
ENDTRAILER
}

######################################################################

# Parse the command line.  Asterisks in the following represents
# commands also defined by Plain Metafont.
my %opthash = ();
GetOptions (\%opthash,
            "fontversion=s",       # font_version
            "comment=s",           # font_comment
            "family=s",            # font_family
            "weight=s",            # font_weight
            "fullname=s",          # font_identifier (*)
            "fixedpitch!",         # font_fixed_pitch
            "italicangle=f",       # font_slant (*)
            "underpos=f",          # font_underline_position
            "underthick=f",        # font_underline_thickness
            "name=s",              # font_name
            "uniqueid=i",          # font_unique_id
            "designsize=f",        # font_size (*)
            "encoding=s",          # font_coding_scheme (*)
            "rounding=f",
            "bpppix=f",
            "ffscript=s",
            "h|help",
            "V|version") || pod2usage(2);
if (defined $opthash{"h"}) {
    pod2usage(-verbose => 1,
              -output  => \*STDOUT,    # Bug workaround for Pod::Usage
              -exitval => "NOEXIT");
    print "Please e-mail bug reports to scott+mf\@pakin.org.\n";
    exit 1;
}
do {print $versionmsg; exit 1} if defined $opthash{"V"};
pod2usage(2) if $#ARGV != 0;

# Extract the filename from the command line.
$mffile = $ARGV[0];
my @fileparts = fileparse $mffile, ".mf";
$filebase = $fileparts[0];
$filedir = $fileparts[1];
$filenoext = File::Spec->catfile ($filedir, $filebase);
$pt1file = $filebase . ".pt1";
$pfbfile = $filebase . ".pfb";

assign_default $bpppix, $opthash{bpppix}, 0.02;

# Make our first pass through the input, to set values for various options.
$mag = 100;           # Get a more precise bounding box.
get_bboxes(1);        # This might set $designsize.

# Sanity-check the specified precision.
assign_default $rounding, $opthash{rounding}, 1;
if ($rounding<=0.0 || $rounding>1.0) {
    die sprintf "%s: Invalid rounding amount \"%g\"; value must be a positive number no greater than 1.0\n", $progname, $rounding;
}

# Ensure that every user-definable parameter is assigned a value.
assign_default $fontversion, $opthash{fontversion}, "001.000";
assign_default $creationdate, scalar localtime;
assign_default $comment, $opthash{comment}, "Font converted to Type 1 by mf2pt1, written by Scott Pakin.";
assign_default $weight, $opthash{weight}, "Medium";
assign_default $fixedpitch, $opthash{fixedpitch}, 0;
assign_default $uniqueID, $opthash{uniqueid}, int(rand(1000000)) + 4000000;
assign_default $designsize, $opthash{designsize};
die "${progname}: a design size must be specified in $mffile or on the command line\n" if !defined $designsize;
die "${progname}: the design size must be a positive number\n" if $designsize<=0.0;
assign_default $underlinepos, $opthash{underpos}, -1;
$underlinepos = round(1000*$underlinepos/$designsize);
assign_default $underlinethick, $opthash{underthick}, 0.5;
$underlinethick = round(1000*$underlinethick/$designsize);
assign_default $fullname, $opthash{fullname}, $filebase;
assign_default $familyname, $opthash{family}, $fullname;
assign_default $italicangle, $opthash{italicangle}, 0;
assign_default $fontname, $opthash{name}, "$familyname-$weight";
$fontname =~ s/\s//g;
assign_default $encoding, $opthash{encoding}, "standard";
my $encoding_name = $encoding;
ENCODING:
{
    if (-e $encoding) {
        # Filenames take precedence over built-in encodings.
        my @enc_array;
        open (ENCFILE, "<$encoding") || die "${progname}: $! ($encoding)\n";
        while (my $oneline = <ENCFILE>) {
            $oneline =~ s/\%.*$//;
            foreach my $word (split " ", $oneline) {
                push @enc_array, substr($word, 1) if substr($word, 0, 1) eq "/";
            }
        }
        close ENCFILE;
        $encoding_name = substr (shift @enc_array, 1);
        $encoding = \@enc_array;
        last ENCODING;
    }
    $encoding=\@standardencoding,  last ENCODING  if $encoding eq "standard";
    $encoding=\@isolatin1encoding, last ENCODING  if $encoding eq "isolatin1";
    $encoding=\@ot1encoding,       last ENCODING  if $encoding eq "ot1";
    $encoding=\@t1encoding,        last ENCODING  if $encoding eq "t1";
    $encoding=\@glyphname,         last ENCODING  if $encoding eq "asis";
    warn "${progname}: Unknown encoding \"$encoding\"; using standard Adobe encoding\n";
    $encoding=\@standardencoding;     # Default to standard encoding
}
assign_default $fixedpitch, $opthash{fixedpitch}, 0;
$fixedpitch = $fixedpitch ? "true" : "false";
assign_default $ffscript, $opthash{ffscript};

# Output the final values of all of our parameters.
print "\n";
print <<"PARAMVALUES";
mf2pt1 is using the following font parameters:
    font_version:              $fontversion
    font_comment:              $comment
    font_family:               $familyname
    font_weight:               $weight
    font_identifier:           $fullname
    font_fixed_pitch:          $fixedpitch
    font_slant:                $italicangle
    font_underline_position:   $underlinepos
    font_underline_thickness:  $underlinethick
    font_name:                 $fontname
    font_unique_id:            $uniqueID
    font_size:                 $designsize (bp)
    font_coding_scheme:        $encoding_name
PARAMVALUES
    ;
print "\n";

# Scale by a factor of 1000/design size.
$mag = 1000.0 / $designsize;
get_bboxes(0);
print "\n";

# Output the font in disassembled format.
open (OUTFILE, ">$pt1file") || die "${progname}: $! ($pt1file)\n";
output_header();
printf OUTFILE "2 index /CharStrings %d dict dup begin\n",
               1+scalar(grep {defined($_)} @charbbox);
output_font_programs();
output_trailer();
close OUTFILE;
unlink @charfiles;
print "\n";

# Convert from the disassembled font format to Type 1 binary format.
if (!execute_command 0, ("t1asm", $pt1file, $pfbfile)) {
    die "${progname}: You'll need either to install t1utils and rerun $progname or find another way to convert $pt1file to $pfbfile\n";
    exit 1;
}
print "\n";
unlink $pt1file;

# Use FontForge to autohint the result.
my $user_script = 0;   # 1=script file was provided by the user; 0=created here
if (defined $ffscript) {
    # The user provided his own script.
    $user_script = 1;
}
else {
    # Create a FontForge script file.
    $ffscript = $filebase . ".pe";
    open (FFSCRIPT, ">$ffscript") || die "${progname}: $! ($ffscript)\n";
    print FFSCRIPT <<'AUTOHINT';
Open($1);
SelectAll();
RemoveOverlap();
AddExtrema();
Simplify(0, 2);
CorrectDirection();
Simplify(0, 2);
RoundToInt();
AutoHint();
Generate($1);
Quit(0);
AUTOHINT
    ;
    close FFSCRIPT;
}
if (!execute_command 0, ("fontforge", "-script", $ffscript, $pfbfile)) {
    warn "${progname}: You'll need to install FontForge if you want $pfbfile autohinted (not required, but strongly recommended)\n";
}
unlink $ffscript if !$user_script;
print "\n";

# Finish up.
print "*** Successfully generated $pfbfile! ***\n";
exit 0;

######################################################################

__END__

=head1 NAME

mf2pt1 - produce a PostScript Type 1 font program from a Metafont source


=head1 SYNOPSIS

mf2pt1
[B<--help>]
[B<--version>]
[B<--comment>=I<string>]
[B<--designsize>=I<number>]
[B<--encoding>=I<encoding>]
[B<--family>=I<name>]
[B<-->[B<no>]B<fixedpitch>]
[B<--fontversion>=I<MMM.mmm>]
[B<--fullname>=I<name>]
[B<--italicangle>=I<number>]
[B<--name>=I<name>]
[B<--underpos>=I<number>]
[B<--underthick>=I<number>]
[B<--uniqueid>=I<number>]
[B<--weight>=I<weight>]
[B<--rounding>=I<number>]
[B<--bpppix>=I<number>]
[B<--ffscript>=I<file.pe>]
I<infile>.mf


=head1 WARNING

The B<mf2pt1> Info file is the main source of documentation for
B<mf2pt1>.  This man page is merely a brief summary.


=head1 DESCRIPTION

B<mf2pt1> facilitates producing PostScript Type 1 fonts from a
Metafont source file.  It is I<not>, as the name may imply, an
automatic converter of arbitrary Metafont fonts to Type 1 format.
B<mf2pt1> imposes a number of restrictions on the Metafont input.  If
these restrictions are met, B<mf2pt1> will produce valid Type 1
output.  (Actually, it produces "disassembled" Type 1; the B<t1asm>
program from the B<t1utils> suite will convert this to a true Type 1
font.)

=head2 Usage

    mf2pt1 myfont.mf

=head1 OPTIONS

Font parameters are best specified within a Metafont program.  If
necessary, though, command-line options can override any of these
parameters.  The B<mf2pt1> Info page, the primary source of B<mf2pt1>
documentation, describes the following in greater detail.

=over 4

=item B<--help>

Provide help on B<mf2pt1>'s command-line options.

=item B<--version>

Output the B<mf2pt1> version number, copyright, and license.

=item B<--comment>=I<string>

Include a font comment, usually a copyright notice.

=item B<--designsize>=I<number>

Specify the font design size in points.

=item B<--encoding>=I<encoding>

Designate the font encoding, either the name of a---typically
F<.enc>---file which contains a PostScript font-encoding vector or one
of C<standard> (the default), C<ot1>, C<t1>, or C<isolatin1>.

=item B<--family>=I<name>

Specify the font family.

=item B<--fixedpitch>, B<--nofixedpitch>

Assert that the font uses either monospaced (B<--fixedpitch>) or
proportional (B<--nofixedpitch>) character widths.

=item B<--fontversion>=I<MMM.mmm>

Specify the font's major and minor version number.

=item B<--fullname>=I<name>

Designate the full font name (family plus modifiers).

=item B<--italicangle>=I<number>

Designate the italic angle in degrees counterclockwise from vertical.

=item B<--name>=I<name>

Provide the font name.

=item B<--underpos>=I<number>

Specify the vertical position of the underline in thousandths of the
font height.

=item B<--underthick>=I<number>

Specify the thickness of the underline in thousandths of the font
height.

=item B<--uniqueid>=I<number>

Specify a globally unique font identifier.

=item B<--weight>=I<weight>

Provide a description of the font weight (e.g., ``Heavy'').

=item B<--rounding>=I<number>

Specify the fraction of a font unit (0.0 < I<number> <= 1.0) to which
to round coordinate values [default: 1.0].

=item B<--bpppix>=I<number>

Redefine the number of big points per pixel from 0.02 to I<number>.

=item B<--ffscript>=I<file.pe>

Name a script to pass to FontForge.

=back


=head1 FILES

F<mf2pt1.mem> (which is generated from F<mf2pt1.mp> and F<mfplain.mp>)


=head1 NOTES

As stated in L</"WARNING">, the complete source of documentation for
B<mf2pt1> is the Info page, not this man page.


=head1 SEE ALSO

mf(1), mpost(1), t1asm(1), fontforge(1)


=head1 AUTHOR

Scott Pakin, I<scott+mf@pakin.org>
