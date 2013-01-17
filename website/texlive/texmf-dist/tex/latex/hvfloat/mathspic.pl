#!/usr/bin/perl
#
#(c) Copyright 2005-2010  VERSION 1.13 April 26, 2010  
#                    Apostolos Syropoulos   &  R.W.D. Nickalls
#                    asyropoulos@yahoo.com     dick@nickalls.org
#
# This program can be redistributed and/or modified under the terms
# of the LaTeX Project Public License Distributed from CTAN
# archives in directory macros/latex/base/lppl.txt; either
# version 1 of the License, or any later version.
#
package DummyFH;
my $index = 0;
sub TIEHANDLE {
    my $class = shift;
    my $self= shift;
    bless $self, $class;
}
sub READLINE {
    my $self = shift;
    #shift @$self;
    if ($index > $#$self) {
      $index = 0;
      return undef;
    }
    else {
      return $self->[$index++];
    }
}

package main;
use Math::Trig;
our $version_number = "1.13 Apr 26, 2010";
our $commandLineArgs = join(" ", @ARGV);
our $command  = "";
our $curr_in_file = "";
our %PointTable = ();
our %VarTable = ();
our %ConstTable = ();
our $no_errors = 0;
our $xunits = "1pt";
our $yunits = "1pt";
our $units = "pt|pc|in|bp|cm|mm|dd|cc|sp";
our $defaultsymbol = "\$\\bullet\$";
our $defaultLFradius = 0;
use constant PI => atan2(1,1)*4;
use constant R2D => 180 / PI;
use constant D2R => PI / 180;
our $arrowLength = 2;
our $arrowLengthUnits = "mm";
our $arrowAngleB = 30;
our $arrowAngleC = 40; 
our %DimOfPoint = ();
our $GlobalDimOfPoints = 0;
our @Macros = ();
our $LineThickness = 0.4;

  sub mpp {
    my $in_line;
    chomp($in_line = shift);
    my $LC = shift;
    my $out_line = $in_line;
    my $macro_name = "";
    my @macro_param = ();
    my $macro_code = "";
    if ($in_line =~ s/^%def\s*//) {
      if ($in_line =~ s/^(\w+)\s*//){
        $macro_name = $1;
      }
      else {
        PrintErrorMessage("No macro name has been found",$LC);
        return ""
      }
      if ($in_line =~ s/^\(\s*//) {
        # do nothing
      }
      else {
        PrintErrorMessage("No left parenthesis after macro name has been found",$LC);
        return "";
      }
      if ($in_line =~ s/^\)//) {
        # Macro has no parameters!
      }
      else {
        MACROS: while (1) {
          if ($in_line =~ s/^(\w+)\s*//) {
            push (@macro_param, $1);
          }
          else {
            PrintErrorMessage("No macro parameter name has been found",$LC);
            return "";
          }
          if ($in_line =~ s/^,\s*//) {
            next MACROS;
          }
          else {
            last MACROS;
          } 
        }
        if ($in_line =~ s/^\)//) {
          # do nothing!
        }
        else {
          PrintErrorMessage("No closing parenthesis after macro parameters",$LC);
          return "";
        }
      }
      $in_line =~ s/([^%]+)(%.*)/$1/;
      $macro_code = $in_line;
      push ( @Macros , { 'macro_name' => $macro_name,
                         'macro_code' => $macro_code,
                         'macro_param' => \@macro_param }); 
      return $out_line;
    }
    elsif ($in_line =~ s/^%undef\s*//) {
      if ($in_line =~ s/^(\w+)//) {
        my $undef_macro = $1;
        for(my $i = $#Macros; $i >= 0; $i--) {
          if ($Macros[$i]->{'macro_name'} eq $undef_macro) {
           splice(@Macros,$i,1);
          }   
        }
      }
      return $out_line;
    }
    elsif ($in_line =~ s/^\s*%//) {
      return $out_line;
    }
    else {
      my $comment = $2 if $in_line =~ s/([^%]+)(%.+)/$1/;
      EXPANSIONLOOP: while () {
        my $org_in_line = $in_line;
        for(my $i = $#Macros; $i >= 0; $i--) {
          my $macro_name = $Macros[$i]->{'macro_name'};
          if ($in_line =~ /&$macro_name\b/) {       ############################
            my $num_of_macro_args = @{$Macros[$i]->{'macro_param'}};
            if ( $num_of_macro_args > 0 ) { 
            # Macro with parameters
              my $pattern = "&$macro_name\\(";
              foreach my $p ( 1..$num_of_macro_args ) {
                my $comma = ($p == $num_of_macro_args) ? "\\s*" : "\\s*,\\s*";
                $pattern .= "\\s*[^\\s\\)]+$comma";
              }
              $pattern .= "\\)";
              while($in_line =~ /&$macro_name\b/) {
                if ($in_line =~ /$pattern/) {   
                  my $before = $`;
                  my $after = $';
                  my $match = $&;
                  my $new_code = $Macros[$i]->{'macro_code'};
                  $match =~ s/^&$macro_name\(\s*//;
                  $match =~ s/\)$//; 
                  foreach my $arg ( 0..($num_of_macro_args - 1) ) {
                    my $old = $Macros[$i]->{'macro_param'}->[$arg];
                    my $comma = ($arg == ($num_of_macro_args - 1)) ? "" : ",";
                    $match =~ s/^\s*([^\s,]+)\s*$comma//;
                    my $new = $1; 
                    # 'g': Parameter may occur several times
                    # in $new_code.
                    # '\b': Substitute only whole words
                    # not x in xA
                    $new_code =~ s/\b$old\b/$new/g;
                  }
                  $in_line = "$before$new_code$after"; 
                }
                else {
                  PrintErrorMessage("Usage of macro &$macro_name does not " .
                                    "match its definition", $LC); 
                  return "";
                }
              }
            }
            else {
              # Macro without parameters
              my $replacement = $Macros[$i]->{'macro_code'};
              # '\b': Substitute only whole words
              # not x in xA
              $in_line =~ s/&$macro_name\b/$replacement/g;
            }
          }
        } 
        last EXPANSIONLOOP if ( $org_in_line eq $in_line );
      }
      return "$in_line$comment";   
    }
  }

      sub PrintErrorMessage {
        my $errormessage = shift;
        my $error_line   = shift;
        my ($l,$A);
        $l = 1+length($command)-length;
        $A = substr($command,0,$l);
        $l += 7 +length($error_line);

        for my $fh (STDOUT, LOG) {
          print $fh "$curr_in_file", "Line $error_line: $A\n";
          print $fh " " x $l  ,$_,"***Error: $errormessage\n";
        }
        if ($comments_on) {  #print to output file file
          print OUT "%% *** $curr_in_file", "Line $error_line: $A\n";
          print OUT "%% *** "," " x $l  ,$_,"%% ... Error: $errormessage\n";
        }
        $no_errors++;
      }

      sub PrintWarningMessage {
        my $warningMessage = shift;
        my $warning_line   = shift;
        my ($l,$A);
        $l = 1+length($command)-length;
        $A = substr($command,0,$l);
        $l += 7 +length($warning_line);

        for my $fh (STDOUT, LOG) {
          print $fh "$curr_in_file", "Line $warning_line: $A\n";
          print $fh " " x $l  ,$_,"***Warning: $warningMessage\n";
        }
        if ($comments_on) {  #print to output file file
          print OUT "%% *** $curr_in_file", "Line $warning_line: $A\n";
          print OUT "%% *** "," " x $l  ,$_,"%% ... Warning: $warningMessage\n";
        }
      }

      sub PrintFatalError {
        my $FatalMessage = shift;
        my $fatal_line   = shift;
        my ($l,$A);
        $l = 1+length($command)-length;
        $A = substr($command,0,$l);
        $l += 7 +length($fatal_line);

        die "$curr_in_file", "Line $fatal_line: $A\n" .
            (" " x $l) . $_ . "***Fatal Error: $FatalMessage\n";
      }

  sub chk_lparen {
    my $token = $_[0];
    my $lc    = $_[1];
    s/\s*//;
    if (/^[^\(]/) {
      PrintErrorMessage("Missing ( after $token",$lc);
    }
    else {
      s/^\(\s*//;
    }
  }

  sub chk_rparen {
    my $token = $_[0];
    my $lc    = $_[1];
    s/\s*//;
    if (s/^\)//) {
      s/\s*//;
    }
    else {
      PrintErrorMessage("Missing ) after $token",$lc);
    }
  }


  sub chk_lcb {
    my $token = $_[0];
    my $lc    = $_[1];
    s/\s*//;
    if ($_ !~ /^\{/) {
      PrintErrorMessage("Missing { after $token",$lc);
    }
    else {
      s/^{\s*//;
    }
  }

  sub chk_rcb {
    my $token = $_[0];
    my $lc    = $_[1];
    if ($_ !~ /^\s*\}/) {
      PrintErrorMessage("Missing } after $token",$lc);
    }
    else {
      s/^\s*}\s*//;
    }
  }

  sub chk_lsb {
     my $token = $_[0];
     my $lc    = $_[1];

     s/\s*//;
     if ($_ !~ /^\[/) {
       PrintErrorMessage("Missing [ after  $token",$lc);
     }
     else {
        s/^\[\s*//;
     }
  }

  sub chk_rsb {
     my $token = $_[0];
     my $lc    = $_[1];

     s/\s*//;
     if ($_ !~ /^\]/) {
       PrintErrorMessage("Missing ] after  $token",$lc);
     }
     else {
       s/^\]\s*//;
     }
  }

  sub chk_comma {
    my $lc  = $_[0];

    s/\s*//;
    if (/^[^,]/) {
      PrintErrorMessage("Did not find expected comma",$lc);
    }
    else {
      s/^,\s*//;
    }
  }

  sub chk_comment {
     my $lc = $_[0];

     s/\s*//;
     if (/^%/) {
       # do nothing!
     }
     elsif (/^[^%]/) {
       PrintWarningMessage("Trailing text is ignored",$lc);
     }
  }

    sub print_headers
    {
       my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime;
       $year+=1900;
       $mon+=1;
       $now_string = "$year/" . ($mon>9 ? "$mon/" : "0$mon/") .
                     ($mday>9 ? "$mday    " : "0$mday    ") .
                     ($hour>9 ? "$hour:" : "0$hour:") .
                     ($min>9 ? "$min:" : "0$min:") .
                     ($sec>9 ? "$sec" : "0$sec");
       print OUT "%* -----------------------------------------------\n";
       print OUT "%* mathspic (Perl version $version_number)\n";
       print OUT "%* A filter program for use with PiCTeX\n";
       print OUT "%* Copyright (c) 2005-2010 A Syropoulos & RWD Nickalls \n";
       print OUT "%* Command line: $0 $commandLineArgs\n";
       print OUT "%* Input filename : $source_file\n";
       print OUT "%* Output filename: $out_file\n";
       print OUT "%* Date & time: $now_string\n";
       print OUT "%* -----------------------------------------------\n";
       #
       print LOG "----\n";
       print LOG "$now_string\n";
       print LOG "mathspic (Perl version $version_number)\n";
       print LOG "Copyright (c) 2005-2010 A Syropoulos & RWD Nickalls \n";
       print LOG "Input file  = $source_file\n";
       print LOG "Output file = $out_file\n";
       print LOG "Log file    = $log_file\n";
       print LOG "----\n";
    }

     sub get_point {

         my ($lc) = $_[0];
         my ($PointName);

         if (s/^([^\W\d_]\d{0,4})\s*//i) { #point name
           $PointName = $1;
           if (!exists($PointTable{lc($PointName)})) {
             PrintErrorMessage("Undefined point $PointName",$lc);
             return "_undef_";
           }
           else {
             return lc($PointName);
           }
         }
         else {
           PrintErrorMessage("Point name expected",$lc);
           return "_undef_";
         }
     }

    sub perpendicular {
        my ($xP, $yP, $xA, $yA, $xB, $yB) = @_;
        my ($xF, $yF, $deltax, $deltay, $m1, $m2, $c1, $c2, $factor);

        $deltax = $xA - $xB;
        return ($xA, $yP) if abs($deltax) < 0.0000001;
        $deltay = $yA - $yB;
        return ($xP, $yA) if abs($deltay) < 0.0000001;
        $m1 = $deltay / $deltax;
        eval { $m2 = (-1) / $m1;};
        PrintFatalError("Division by zero",$lc) if $@;
        $c1 = $yA - $m1 * $xA;
        $c2 = $yP - $m2 * $xP;
        eval { $factor = 1 / ($m1 - $m2)};
        PrintFatalError("Division by zero",$lc) if $@;
        return (($c2 - $c1) * $factor, ($m1 * $c2 - $m2 * $c1) * $factor);
    }

    sub Length {
        my ($xA, $yA, $xB, $yB)=@_;
        return sqrt(($xB - $xA)**2 + ($yB - $yA)**2);
    }

    sub triangleArea {
        my ($xA, $yA, $xB, $yB, $xC, $yC)=@_;
        my ($lenAB, $lenBC, $lenCA, $s);

        $lenAB = Length($xA,$yA,$xB,$yB);
        $lenBC = Length($xB,$yB,$xC,$yC);
        $lenCA = Length($xC,$yC,$xA,$yA);
        $s = ($lenAB + $lenBC + $lenCA) / 2;
        return sqrt($s * ($s - $lenAB)*($s - $lenBC)*($s - $lenCA));
    }

    sub pointOnLine {
        my ($xA, $yA, $xB, $yB, $dist)=@_;
        my ($deltax, $deltay, $xPol, $yPol);

        $deltax = $xB - $xA;
        $deltay = $yB - $yA;
        $xPol = $xA + ($dist * $deltax / &Length($xA,$yA,$xB,$yB));
        $yPol = $yA + ($dist * $deltay / &Length($xA,$yA,$xB,$yB));
        return ($xPol, $yPol);
    }


  
    sub circumCircleCenter {
       my ($xA, $yA, $xB, $yB, $xC, $yC, $lc)=@_;
       my ($deltay12, $deltax12, $xs12, $ys12);
       my ($deltay23, $deltax23, $xs23, $ys23);
       my ($xcc, $ycc);
       my ($m23, $mr23, $c23, $m12, $mr12, $c12);
       my ($sideA, $sideB, $sideC, $a, $radius);

       if (abs(triangleArea($xA, $yA, $xB, $yB, $xC, $yC)) < 0.0000001)
       {
          PrintErrorMessage("Area of triangle is zero!",$lc);
          return (0,0,0);
       }
       $deltay12 = $yB - $yA;
       $deltax12 = $xB - $xA;
       $xs12 = $xA + $deltax12 / 2;
       $ys12 = $yA + $deltay12 / 2;
       #
       $deltay23 = $yC - $yB;
       $deltax23 = $xC - $xB;
       $xs23 = $xB + $deltax23 / 2;
       $ys23 = $yB + $deltay23 / 2;
       #
       CCXYLINE:{
       if (abs($deltay12) < 0.0000001)
       {
          $xcc = $xs12;
          if (abs($deltax23) < 0.0000001)
          {
             $ycc = $ys23;
             last CCXYLINE;
          }
          else
          {
             $m23 = $deltay23 / $deltax23;
             $mr23 = -1 / $m23;
             $c23 = $ys23 - $mr23 * $xs23;
             $ycc = $mr23 * $xs12 + $c23;
             last CCXYLINE;
          }
       }
       if (abs($deltax12) < 0.0000001)
       {
          $ycc = $ys12;
          if (abs($deltay23) < 0.0000001)
          {
             $xcc = $xs23;
             last CCXYLINE;
          }
          else
          {
             $m23 = $deltay23 / $deltax23;
             $mr23 = -1 / $m23;
             $c23 = $ys23 - $mr23 * $xs23;
             $xcc = ($ys12 - $c23) / $mr23;
             last CCXYLINE;
          }
       }
       if (abs($deltay23) < 0.0000001)
       {
          $xcc = $xs23;
          if (abs($deltax12) < 0.0000001)
          {
             $ycc = $ys12;
             last CCXYLINE;
          }
          else
          {
             $m12 = $deltay12 / $deltax12;
             $mr12 = -1 / $m12;
             $c12 = $ys12 - $mr12 * $xs12;
             $ycc = $mr12 * $xcc + $c12;
             last CCXYLINE;
          }
       }
       if (abs($deltax23) < 0.0000001)
       {
          $ycc = $ys23;
          if (abs($deltay12) < 0.0000001)
          {
             $xcc = $xs12;
             last CCXYLINE;
          }
          else
          {
             $m12 = $deltay12 / $deltax12;
             $mr12 = -1 / $m12;
             $c12 = $ys12 - $mr12 * $xs12;
             $xcc = ($ycc - $c12) / $mr12;
             last CCXYLINE;
          }
       }
       $m12 = $deltay12 / $deltax12;
       $mr12 = -1 / $m12;
       $c12 = $ys12 - $mr12 * $xs12;
       #-----
       $m23 = $deltay23 / $deltax23;
       $mr23 = -1 / $m23;
       $c23 = $ys23 - $mr23 * $xs23;
       $xcc = ($c23 - $c12) / ($mr12 - $mr23);
       $ycc = ($c23 * $mr12 - $c12 * $mr23) / ($mr12 - $mr23);
       }
       #
       $sideA = &Length($xA,$yA,$xB,$yB);
       $sideB = &Length($xB,$yB,$xC,$yC);
       $sideC = &Length($xC,$yC,$xA,$yA);
       $a = triangleArea($xA, $yA, $xB, $yB, $xC, $yC);
       $radius = ($sideA * $sideB * $sideC) / (4 * $a);
       #
       return ($xcc, $ycc, $radius);
    }

    sub ComputeDist {
       my ($lc) = $_[0];
       my ($v1, $v2);

       if (s/^((\+|-)?\d+(\.\d+)?([eE](\+|-)?\d+)?)//) #is it a number?
       {
           return ($1, 1);
       }
       elsif (/^[^\W\d_]\d{0,4}[^\W\d_]\d{0,4}/) #it is a pair of IDs?
       {
          s/^([^\W\d_]\d{0,4})//i;
          $v1 = $1;
          if (!exists($PointTable{lc($v1)})) {  
             if (exists($VarTable{lc($v1)})) {
                return ($VarTable{lc($v1)}, 1);
             }
             PrintErrorMessage("Point $v1 has not been defined", $lc);
             s/^\s*[^\W\d_]\d{0,4}//i;
             return (0,0);
          }
          $v1 = lc($v1);
          s/^\s*([^\W\d_]\d{0,4})//i;
          $v2 = $1;
          if (!exists($PointTable{lc($v2)}))
          {
             PrintErrorMessage("Point $v2 has not been defined", $lc);
             return (0,0);
          }
          $v2 = lc($v2);
          my ($x1,$y1,$pSV1,$pS1) = unpack("d3A*",$PointTable{$v1});
          my ($x2,$y2,$pSV2,$pS2) = unpack("d3A*",$PointTable{$v2});
          return (Length($x1,$y1,$x2,$y2), 1);
       }
       elsif (s/^([^\W\d_]\d{0,4})//i) # it is a single id
       {
         $v1 = $1;
         if (!exists($VarTable{lc($v1)})) #it isn't a variable
         {
           PrintErrorMessage("Variable $v1 has not been defined", $lc);
           return (0,0);
         }
         return ($VarTable{lc($v1)}, 1);
       }
       else
       {
          PrintErrorMessage("Unexpected token", $lc);
          return (0,0);
       }
     }

     sub intersection4points {
       my ($x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4) = @_;
       my ($deltay12, $deltax12, $deltay34, $deltax34);
       my ($xcc, $ycc, $m34, $c34, $m12, $c12);

       $deltay12 = $y2 - $y1;
       $deltax12 = $x2 - $x1;
       #
       $deltay34 = $y4 - $y3;
       $deltax34 = $x4 - $x3;
       I4PXYLINE:{
          if (abs($deltay12) < 0.0000001)
          {
             $ycc = $y1;
             if (abs($deltax34) < 0.0000001)
             {
                $xcc = $x3;
                last I4PXYLINE;
             }
             else
             {
                $m34 = $deltay34 / $deltax34;
                $c34 = $y3 - $m34 * $x3;
                $xcc = ($ycc - $c34) / $m34;
                last I4PXYLINE;
             }
          }
          if (abs($deltax12) < 0.0000001)
          {
             $xcc = $x1;
             if (abs($deltay34) < 0.0000001)
             {
                $ycc = $y3;
                last I4PXYLINE;
             }
             else
             {
                $m34 = $deltay34 / $deltax34;
                $c34 = $y3 - $m34 * $x3;
                $ycc = $m34 * $xcc + $c34;
                last I4PXYLINE;
             }
          }
          if (abs($deltay34) < 0.0000001)
          {
             $ycc = $y3;
             if (abs($deltax12) < 0.0000001)
             {
                $xcc = $x1;
                last I4PXYLINE;
             }
             else
             {
                $m12 = $deltay12 / $deltax12;
                $c12 = $y1 - $m12 * $x1;
                $xcc = ($ycc - $c12) / $m12;
                last I4PXYLINE;
             }
          }
          if (abs($deltax34) < 0.0000001)
          {
             $xcc = $x3;
             if (abs($deltay12) < 0.0000001)
             {
                $ycc = $y1;
                last I4PXYLINE;
             }
             else
             {
                $m12 = $deltay12 / $deltax12;
                $c12 = $y1 - $m12 * $x1;
                $ycc = $m12 * $xcc + $c12;
                last I4PXYLINE;
             }
          }
          $m12 = $deltay12 / $deltax12;
          $c12 = $y1 - $m12 * $x1;
          $m34 = $deltay34 / $deltax34;
          $c34 = $y3 - $m34 * $x3;
          $xcc = ($c34 - $c12) / ($m12 - $m34);
          $ycc = ($c34 * $m12 - $c12 * $m34) / ($m12 - $m34);
       }
       return ($xcc, $ycc);
     }

    sub IncircleCenter {
       my ($Ax, $Ay, $Bx, $By, $Cx, $Cy) = @_;
       my ($sideA, $sideB, $sideC);
       my ($ba1, $xA1, $yA1, $cb1, $ac1, $xB1, $yB1, $xC1, $yC1, $a, $s, $r);

       #determine the lengths of the sides
       $sideA = Length($Bx, $By, $Cx, $Cy);
       $sideB = Length($Cx, $Cy, $Ax, $Ay);
       $sideC = Length($Ax, $Ay, $Bx, $By);
       #
       $ba1 = ($sideC * $sideA) / ($sideB + $sideC);
       ($xA1, $yA1) = pointOnLine($Bx, $By, $Cx, $Cy, $ba1);
       $cb1 = ($sideA * $sideB) / ($sideC + $sideA);
       ($xB1, $yB1) = pointOnLine($Cx, $Cy, $Ax, $Ay, $cb1);
       $ac1 = ($sideB * $sideC) / ($sideA + $sideB);
       ($xC1, $yC1) = pointOnLine($Ax, $Ay, $Bx, $By, $ac1);
       ($xcenter, $ycenter) = &intersection4points($Ax, $Ay, $xA1, $yA1,
                                                   $Bx, $By, $xB1, $yB1);
       # get radius
       $a = &triangleArea($Ax, $Ay, $Bx, $By, $Cx, $Cy);
       $s = ($sideA + $sideB +$sideC) / 2;
       $r = $a / $s;
       return ($xcenter, $ycenter, $r);
    }

    sub Angle {
      my ($Ax, $Ay, $Bx, $By, $Cx, $Cy) = @_;
      my ($RAx, $RAy, $RBx, $RBy, $RCx, $RCy, $deltax, $deltay);
      my ($lineBA, $lineBC, $lineAC, $k, $kk, $angle);
      my ($T, $cosT, $sinT) = (0.3, cos(0.3), sin(0.3));

      $RAx = $Ax * $cosT + $Ay * $sinT;
      $RAy = -$Ax * $sinT + $Ay * $cosT;
      $RBx = $Bx * $cosT + $By * $sinT;
      $RBy = -$Bx * $sinT + $By * $cosT;
      $RCx = $Cx * $cosT + $Cy * $sinT;
      $RCy = -$Cx * $sinT + $Cy * $cosT;
      $deltax = $RBx - $RAx;
      $deltay = $RBy - $RAy;
      $lineBA = sqrt($deltax*$deltax + $deltay*$deltay);
      if ($lineBA < 0.0000001)
      {
         return -500;
      }
      $deltax = $RBx - $RCx;
      $deltay = $RBy - $RCy;
      $lineBC = sqrt($deltax*$deltax + $deltay*$deltay);
      if ($lineBC < 0.0000001)
      {
         return -500;
      }
      $deltax = $RAx - $RCx;
      $deltay = $RAy - $RCy;
      $lineAC = sqrt($deltax*$deltax + $deltay*$deltay);
      if ($lineAC < 0.0000001)
      {
         return -500;
      }
      $k = ($lineBA*$lineBA + $lineBC*$lineBC - $lineAC*$lineAC ) /
           (2 * $lineBA * $lineBC);
      $k = -1 if $k < -0.99999;
      $k = 1 if $k > 0.99999;
      $kk = $k * $k;
      if (($kk * $kk) == 1)
      {
         $angle = PI if $k == -1;
         $angle = 0 if $k == 1;
      }
      else
      {
         $angle = (PI / 2) - atan2($k / sqrt(1 - $kk),1);
      }
      return $angle * 180 / PI;
    }

    sub excircle {
      my ($A, $B, $C, $D, $E) = @_;
      my ($Ax,$Ay,$Bx,$By,$Dx,$Dy,$Ex,$Ey,$ASVA,$ASA);
      ($Ax,$Ay,$ASVA,$ASA)=unpack("d3A*",$PointTable{$A});
      ($Bx,$By,$ASVA,$ASA)=unpack("d3A*",$PointTable{$B});
      ($Cx,$Cy,$ASVA,$ASA)=unpack("d3A*",$PointTable{$C});
      ($Dx,$Dy,$ASVA,$ASA)=unpack("d3A*",$PointTable{$D});
      ($Ex,$Ey,$ASVA,$ASA)=unpack("d3A*",$PointTable{$E});
      my ($sideA, $sideB, $sideC, $s, $R, $theAdeg, $d);
      my ($Xmypoint, $Ymypoint, $deltax, $deltay, $mylength, $xc, $yc);

      $sideA = &Length($Bx, $By, $Cx, $Cy);
      $sideB = &Length($Cx, $Cy, $Ax, $Ay);
      $sideC = &Length($Ax, $Ay, $Bx, $By);
      $s = ($sideA + $sideB + $sideC) / 2;
      $R = triangleArea($Ax, $Ay, $Bx, $By, $Cx, $Cy) /
           ($s - &Length($Dx, $Dy, $Ex, $Ey));
      if (($D eq $A && $E eq $B) || ($D eq $B && $E eq $A))
      {
        $theAdeg = &Angle($Bx, $By, $Cx, $Cy, $Ax, $Ay);
        $Xmypoint = $Cx;
        $Ymypoint = $Cy;
      }
      elsif (($D eq $B && $E eq $C) || ($D eq $C && $E eq $B))
      {
        $theAdeg = &Angle($Cx, $Cy, $Ax, $Ay, $Bx, $By);
        $Xmypoint = $Ax;
        $Ymypoint = $Ay;
      }
      elsif (($D eq $C && $E eq $A) || ($D eq $A && $E eq $C))
      {
        $theAdeg = &Angle($Ax, $Ay, $Bx, $By, $Cx, $Cy);
        $Xmypoint = $Bx;
        $Ymypoint = $By;
      }
      else
      {
         return (0,0,0);
      }
      $d = $R  / sin($theAdeg * PI / 180 / 2);
      my ($xIn, $yIn, $rin) = &IncircleCenter($Ax, $Ay, $Bx, $By, $Cx, $Cy);
      $deltax = $xIn - $Xmypoint;
      $deltay = $yIn - $Ymypoint;
      $mylength = sqrt($deltax*$deltax + $deltay*$deltay);
      $xc = $Xmypoint + $d * $deltax / $mylength;
      $yc = $Ymypoint + $d * $deltay / $mylength;
      return ($xc, $yc, $R);
    }

     sub DrawLineOrArrow {      
       my $draw_Line = shift;
       my $lc = shift;
       my $lineLength = -1;
       my $stacklen = 0;
       my @PP = ();
  #     if ($draw_Line != 2) {
  #       s/\s*//;
  #       if (s/^\[\s*//) { # optional length specifier 
  #         $lineLength = expr($lc);
  #         if ($lineLength <= 0) {
  #           PrintErrorMessage("length must greater than zero",$lc);
  #           $lineLength = -1;
  #         } 
  #         chk_rsb("optional part",$lc);
  #       }
  #     } 
       chk_lparen("$cmd",$lc);
       DRAWLINES:while(1) {
         @PP = () ;
         while(1) {
           if (s/^([^\W\d_]\d{0,4})\s*//i) { #point name
             $P = $1;
             if (!exists($PointTable{lc($P)})) {
               PrintErrorMessage("Undefined point $P",$lc);
             }
             else {
               push (@PP,$P);
             }
           }
           else {
             $stacklen = @PP;
             if ($draw_Line != 2) {
               if ($stacklen <= 1) {
                 PrintErrorMessage("Wrong number of points",$lc);
               }
               else {
                 push(@PP,$lc);
                 if ($draw_Line == 0) {
                   drawarrows(@PP); 
                 }
                 elsif ($draw_Line == 1) {
                   drawlines(@PP); 
                 }
               }
             }
             if (s/^,\s*// and $draw_Line != 2) {
               next DRAWLINES;
             }
             else {
               last DRAWLINES;
             }
           }
         }
       }
       if ($draw_Line == 2) {
         $stacklen =  @PP;
         if ($stacklen < 2) {
           PrintErrorMessage("Wrong number of points",$lc);
         }
         elsif ($stacklen % 2 == 0) {
           PrintErrorMessage("Number of points must be odd",$lc);
         }
         else {
           drawCurve(@PP);        
         }
       }
       chk_rparen("arguments of $cmd",$lc);
       chk_comment($lc);
     }

    sub drawarrows {
      my ($NoArgs);
      $NoArgs = @_;
      my ($lc) = $_[$NoArgs-1]; #line number is the last argument
      my ($NumberOfPoints, $p, $q, $r12, $d12);
      my ($px,$py,$pSV,$pS, $qx,$qy,$qSV,$qS);

      $NumberOfPoints = $NoArgs - 1;
      LOOP: for(my $i=0; $i < $NumberOfPoints - 1; $i++)
      {
         $p = $_[$i];
         $q = $_[$i+1];
         ($px,$py,$pSV,$pS) = unpack("d3A*",$PointTable{lc($p)});
         ($qx,$qy,$qSV,$qS) = unpack("d3A*",$PointTable{lc($q)});
         $pSV = $defaultLFradius if $pSV == 0;
         $qSV = $defaultLFradius if $qSV == 0;
         $r12 = $pSV + $qSV;
         $d12 = Length($px,$py,$qx,$qy);
         if ($d12 <= $r12)
         {
            if($d12 == 0)
            {
               PrintErrorMessage("points $p and $q are the same", $lc);
               next LOOP;
            }
            PrintWarningMessage("arrow $p$q not drawn: points too close or ".
                                  "radii too big", $lc);
            next LOOP;
         }
         ($px, $py) = pointOnLine($px, $py, $qx, $qy, $pSV) if $pSV > 0;
         ($qx, $qy) = pointOnLine($qx, $qy, $px, $py, $qSV) if $qSV > 0;
         my ($beta, $gamma);
         $beta  = tan($arrowAngleB * D2R / 2);
         $gamma = 2 * tan($arrowAngleC * D2R / 2);
         printf OUT "\\arrow <%.5f%s> [%.5f,%.5f] from %.5f %.5f to %.5f %.5f\n",
                $arrowLength, $arrowLengthUnits, $beta, $gamma, $px, $py, $qx, $qy;
      }
    }

    sub drawlines {
      my ($NoArgs);
      $NoArgs = @_;
      my ($lc) = $_[$NoArgs-1]; #line number is the last argument
      my ($NumberOfPoints, $p, $q, $r12, $d12);
      my ($px,$py,$pSV,$pS, $qx,$qy,$qSV,$qS);

      $NumberOfPoints = $NoArgs - 1;
      LOOP: for(my $i=0; $i < $NumberOfPoints - 1; $i++)
      {
         $p = $_[$i];
         $q = $_[$i+1];
         ($px,$py,$pSV,$pS) = unpack("d3A*",$PointTable{lc($p)});
         ($qx,$qy,$qSV,$qS) = unpack("d3A*",$PointTable{lc($q)});
         $pSV = $defaultLFradius if $pSV == 0;
         $qSV = $defaultLFradius if $qSV == 0;
         $r12 = $pSV + $qSV;
         $d12 = Length($px,$py,$qx,$qy);
         if ($d12 <= $r12)
         {
            if($d12 == 0)
            {
               PrintErrorMessage("points $p and $q are the same", $lc);
               next LOOP;
            }
            PrintWarningMessage("line $p$q not drawn: points too close or ".
                                  "radii too big", $lc);
            next LOOP;
         }
         ($px, $py) = pointOnLine($px, $py, $qx, $qy, $pSV) if $pSV > 0;
         ($qx, $qy) = pointOnLine($qx, $qy, $px, $py, $qSV) if $qSV > 0;
         if ($px == $qx || $py == $qy)
         {
            printf OUT "\\putrule from %.5f %.5f to %.5f %.5f %%%% %s%s\n",
                       $px,$py,$qx,$qy,$p,$q;
         }
         else
         {
            printf OUT "\\plot %.5f %.5f\t%.5f %.5f / %%%% %s%s\n",
                       $px, $py,$qx,$qy,$p,$q;
         }
      }
    }

    sub drawCurve {
      my ($NoArgs);
      $NoArgs = @_;
      my ($lc) = $_[$NoArgs-1]; #line number is the last argument
      my ($NumberOfPoints, $p);

      $NumberOfPoints = $NoArgs - 1;
      print OUT "\\setquadratic\n\\plot\n";
      for(my $i=0; $i <= $NumberOfPoints; $i++)
      {
         $p = $_[$i];
         my ($px,$py,$pSV,$pS) = unpack("d3A*",$PointTable{lc($p)});
         printf OUT "\t%0.5f  %0.5f", $px, $py;
         print OUT (($i == $NumberOfPoints) ? " / %$p\n" : " %$p\n");  
      }
      print OUT "\\setlinear\n";
    }

    sub drawpoints {
      my ($NumberOfPoints,$p);
      $NumberOfPoints = @_;
      my ($px,$py,$pSV,$pS);

      for($i=0; $i < $NumberOfPoints; $i++)
      {
         $p = $_[$i];
         ($px,$py,$pSV,$pS) = unpack("d3A*",$PointTable{lc($p)});
         if ($pS eq "" and $defaultsymbol =~ /circle|square/) {
           $pS = $defaultsymbol;
         }
         POINTSWITCH: {
           if ($pS eq "") # no plot symbol specified
           {
             printf OUT "\\put {%s} at %.5f %.5f %%%% %s\n",
                        $defaultsymbol, $px, $py, $p;
             last POINTSWITCH;
           }
           if ($pS eq "circle") # plot symbol is a circle
           { 
             my $radius = (defined($DimOfPoint{lc($p)})) ? $DimOfPoint{lc($p)} : 
                           $GlobalDimOfPoints; 
             if ($radius > 0) # draw a circle using the current units
             {
                if ($radius == 1.5) # use \bigcirc
                {
                  printf OUT "\\put {\$\\bigcirc\$} at %.5f %.5f  %%%% %s\n",
                             $px, $py, $p;
                }
                else
                {
                  printf OUT "\\circulararc 360 degrees from %.5f %.5f center at %.5f %.5f %%%% %s\n",
                             $px+$radius, $py, $px, $py, $p;
                }
             }
             else #use \circ symbol
             {
               printf OUT "\\put {\$\\circ\$} at %.5f %.5f %%%% %s\n",
                           $px,$py,$p;
             }
             last POINTSWITCH;
           }
           if ($pS eq "square")
           {
             my $side = (defined($DimOfPoint{lc($p)})) ? $DimOfPoint{lc($p)} : 
                           $GlobalDimOfPoints;
             printf OUT "\\put {%s} at %.5f %.5f %%%% %s\n",
                           drawsquare($side), $px, $py, $p;
             last POINTSWITCH;
           }
           printf OUT "\\put {%s} at %.5f %.5f %%%% %s\n", $pS,$px,$py,$p;
         }
      }
    }

  sub drawAngleArc {
    my ($P1, $P2, $P3, $radius, $inout, $direction) = @_;
    my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$P1});
    my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$P2});
    my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$P3});

    my $internalAngle = Angle($x1, $y1, $x2, $y2, $x3, $y3);
    my $externalAngle = 360 - $internalAngle;
    my ($x, $y) = pointOnLine($x2, $y2, $x1, $y1, $radius);
    my $code = "";
    if ($inout eq "internal" and $direction eq "clockwise" ) {
       $code = sprintf "\\circulararc %.5f degrees from %.5f %.5f center at %.5f %.5f\n",
               -1 * $internalAngle, $x, $y, $x2, $y2;
    }
    elsif ($inout eq "internal" and $direction eq "anticlockwise" ) {
       $code = sprintf "\\circulararc %.5f degrees from %.5f %.5f center at %.5f %.5f\n",
               $internalAngle, $x, $y, $x2, $y2;
    }
    elsif ($inout eq "external" and $direction eq "clockwise" ) {
       $code = sprintf "\\circulararc %.5f degrees from %.5f %.5f center at %.5f %.5f\n",
               -1 * $externalAngle, $x, $y, $x2, $y2;
    }
    elsif ($inout eq "external" and $direction eq "anticlockwise" ) {
       $code = sprintf "\\circulararc %.5f degrees from %.5f %.5f center at %.5f %.5f\n",
               $externalAngle, $x, $y, $x2, $y2;
    }
    return $code;
  }

  sub drawAngleArrow {
     my ($P1, $P2, $P3, $radius, $inout, $direction) = @_;
     my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$P1});
     my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$P2});
     my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$P3});

     my $code = drawAngleArc($P1, $P2, $P3, $radius, $inout, $direction);

     my ($xqp, $yqp) = pointOnLine($x2, $y2, $x1, $y1, $radius);
     my ($deltax, $deltay) = ($x1 - $x2, $y1 - $y2);
     my $AL;

     if ($xunits =~ /mm/) {
       $AL = 1;
     }
     elsif ($xunits =~ /cm/) {
       $AL = 0.1;
     }
     elsif ($xunits =~ /pt/) {
       $AL = 2.845;
     }
     elsif ($xunits =~ /bp/) {
       $AL = 2.835;
     }
     elsif ($xunits =~ /pc/) {
       $AL = 0.2371;
     }
     elsif ($xunits =~ /in/) {
       $AL = 0.03937;
     }
     elsif ($xunits =~ /dd/) {
       $AL = 2.659;
     }
     elsif ($xunits =~ /cc/) {
       $AL = 0.2216;
     }
     elsif ($xunits =~ /sp/) {
       $AL = 186467.98;
     }
     my $halfAL = $AL / 2;
     my $d = sqrt($radius * $radius - $halfAL * $halfAL);
     my $alpha = atan2($d / $halfAL, 1) * R2D;
     my $beta = 2 * (90 - $alpha);
     my $thetaqr;
     if (abs($deltay) < 0.00001) {
       if ($deltax > 0 ) {$thetaqr = 0 }
       elsif ($deltax < 0) {$thetaqr = -180}
     }
     else {
       if (abs($deltax) < 0.00001) {
          $thetaqr = 90;
       }
       else {
         $thetaqr = atan2($deltay / $deltax, 1) * R2D;
       }
     }
     my ($xqr, $yqr) = pointOnLine($x2, $y2, $x3, $y3, $radius);
     $deltax = $x3 - $x2;
     $deltay = $y3 - $y2;
     $alpha = atan2(sqrt($radius * $radius - $halfAL * $halfAL) / $halfAL, 1) /
              D2R;
     $beta = 2 * (90 - $alpha);
     LINE2 : {
       if (abs($deltax) < 0.00001) {
         if ($deltay > 0) { $thetaqr = 90 }
         elsif ($deltay < 0) { $thetaqr = - 90 }
         last LINE2;
       }
       else {
         $thetaqr = atan2($deltay / $deltax, 1) * R2D;
       }
       if (abs($deltay) < 0.00001) {
         if ($deltax > 0)    { $thetaqr = 0 }
         elsif ($deltax < 0) { $thetaqr = -180 }
         last LINE2;
       }
       else {
         $thetaqr = atan2($deltay / $deltax, 1) * R2D;
       }
       if ($deltax < 0 and $deltay > 0) { $thetaqr += 180 }
       elsif ($deltax < 0 and $deltay < 0) { $thetaqr += 180 }
       elsif ($deltax > 0 and $deltay < 0) { $thetaqr += 360 }
     }
     my $xqrleft  = $x2 + $radius * cos(($thetaqr + $beta) * D2R);
     my $yqrleft  = $y2 + $radius * sin(($thetaqr + $beta) * D2R);
     my $xqrright = $x2 + $radius * cos(($thetaqr - $beta) * D2R);
     my $yqrright = $y2 + $radius * sin(($thetaqr - $beta) * D2R);
     if ($inout eq "internal" and $direction eq "clockwise") {
       $code .= sprintf "\\arrow <1.5mm> [0.5, 1] from %.5f %.5f to %.5f %.5f\n",
                $xqrleft, $yqrleft, $xqr, $yqr;
     }
     elsif ($inout eq "internal" and $direction eq "anticlockwise") {
       $code .= sprintf "\\arrow <1.5mm> [0.5, 1] from %.5f %.5f to %.5f %.5f\n",
                $xqrright, $yqrright, $xqr, $yqr;
     }
     elsif ($inout eq "external" and $direction eq "clockwise") {
       $code .= sprintf "\\arrow <1.5mm> [0.5, 1] from %.5f %.5f to %.5f %.5f\n",
                $xqrleft, $yqrleft, $xqr, $yqr;
     }
     elsif ($inout eq "external" and $direction eq "anticlockwise") {
       $code .= sprintf "\\arrow <1.5mm> [0.5, 1] from %.5f %.5f to %.5f %.5f\n",
                $xqrright, $yqrright, $xqr, $yqr;
     }
     return $code;
  }

  sub expr {
    my $lc = $_[0];
    my($left,$op,$right);

    $left = term($lc);
    while ($op = addop()) {
      $right = term($lc);
      if ($op eq '+')
        { $left += $right }
      else
        { $left -= $right }
    }
    return $left;
  }

  sub addop {
    s/^([+-])// && $1;
  }

  sub term {
    my $lc = $_[0];
    my ($left, $op, $right);
    $left = factor($lc);
    while ($op = mulop()) {
      $right = factor($lc);
      if ($op eq '*')
        { $left *= $right }
      elsif ($op =~ /rem/i) {
        eval {$left %= $right};
        PrintFatalError("Division by zero", $lc) if $@;
      }
      else {
        eval {$left /= $right};
        PrintFatalError("Division by zero", $lc) if $@;
      }
    }
    return $left;
  }

  sub mulop {
    (s#^([*/])## || s/^(rem)//i) && lc($1);
  }

  sub factor {
    my $lc = $_[0];
    my ($left);

    $left = primitive($lc);
    if (s/^\*\*//) {
      $left **= factor($lc);
    }
    return $left;
  }

  sub primitive {
    my $lc = $_[0];
    my $val;
    s/\s*//;
    if (s/^\(//) {  #is it an expr in parentheses
      $val = expr($lc);
      s/^\)// || PrintErrorMessage("Missing right parenthesis", $lc);
    }
    elsif (s/^-//) { # is it a negated primitive
       $val = - primitive();
    }
    elsif (s/^\+//) { # is it a positive primitive
       $val = primitive();
    }
    elsif (s/^angledeg//i) {
       chk_lparen("angledeg",$lc);
       my $point_1 = get_point($lc);
       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_1});
       my $point_2 = get_point($lc);
       my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point_2});
       my $point_3 = get_point($lc);
       my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point_3});
       my $d12 = Length($x1, $y1, $x2, $y2);
       my $d23 = Length($x2, $y2, $x3, $y3);
       my $d31 = Length($x3, $y3, $x1, $y1);
       if ( $d12 == 0 ) {
         PrintErrorMessage("points `$point_1' and `$point_2' are the same", $lc);
         $val = 0;
       }
       elsif ( $d23 == 0 ) {
         PrintErrorMessage("points `$point_2' and `$point_3' are the same", $lc);
         $val = 0;
       }
       elsif ( $d31 == 0 ) {
         PrintErrorMessage("points `$point_1' and `$point_3' are the same", $lc);
         $val = 0;
       }
       else {  
         $val = Angle($x1, $y1, $x2, $y2, $x3, $y3);
         $val = 0 if $val == -500;
       }
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^angle//i) {
       chk_lparen("angle",$lc);
       my $point_1 = get_point($lc);
       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_1});
       my $point_2 = get_point($lc);
       my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point_2});
       my $point_3 = get_point($lc);
       my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point_3});
       my $d12 = Length($x1, $y1, $x2, $y2);
       my $d23 = Length($x2, $y2, $x3, $y3);
       my $d31 = Length($x3, $y3, $x1, $y1);
       if ( $d12 == 0 ) {
         PrintErrorMessage("points `$point_1' and `$point_2' are the same", $lc);
         $val = 0;
       }
       elsif ( $d23 == 0 ) {
         PrintErrorMessage("points `$point_2' and `$point_3' are the same", $lc);
         $val = 0;
       }
       elsif ( $d31 == 0 ) {
         PrintErrorMessage("points `$point_1' and `$point_3' are the same", $lc);
         $val = 0;
       }
       else {
         $val =  Angle($x1, $y1, $x2, $y2, $x3, $y3);
         if ($val == -500) {
           $val = 0;
         }
         else {
           $val = D2R * $val;
         }
       }
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^area//i) {
       chk_lparen("angledeg",$lc);
       my $point_1 = get_point($lc);
       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_1});
       my $point_2 = get_point($lc);
       my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point_2});
       my $point_3 = get_point($lc);
       my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point_3});
       $val = triangleArea($x1, $y1, $x2, $y2, $x3, $y3);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^asin//i) {
       chk_lparen("asin");
       $val = expr();
       PrintFatalError("Can't take asin of $val", $lc) if $val < -1 || $val > 1;
       $val = asin($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^acos//i) {
       chk_lparen("acos");
       $val = expr();
       PrintFatalError("Can't take acos of $val", $lc) if $val < -1 || $val > 1 ;
       $val = acos($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^atan//i) {
       chk_lparen("atan");
       $val = expr();
       $val = atan($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^cos//i) {
       chk_lparen("cos");
       $val = expr();
       $val = cos($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^directiondeg//i) {
       chk_lparen("directiondeg",$lc);
       my $point_1 = get_point($lc);
       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_1});
       my $point_2 = get_point($lc);
       my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point_2});
       my $x3 = $x1+1;
       if ( ($y2 - $y1) >= 0) {
         $val = Angle($x3, $y1, $x1, $y1, $x2, $y2);
         $val = 0 if $val == -500;
       }
       else {
         $val = 360 - Angle($x3, $y1, $x1, $y1, $x2, $y2);
         $val = 0 if $val == -500;  
       }
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^direction//i) {
       chk_lparen("direction",$lc);
       my $point_1 = get_point($lc);
       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_1});
       my $point_2 = get_point($lc);
       my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point_2});
       my $x3 = $x1+1;
       if ( ($y2 - $y1) >= 0) {
         $val = Angle($x3, $y1, $x1, $y1, $x2, $y2);
         $val = 0 if $val == -500;
         $val = D2R * $val;
       }
       else {
         $val = 360 - Angle($x3, $y1, $x1, $y1, $x2, $y2);
         $val = 0 if $val == -500;
         $val = D2R * $val;  
       }
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^exp//i) {
       chk_lparen("exp");
       $val = expr();
       $val = exp($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^int//i) {
       chk_lparen("int");
       $val = expr();
       $val = int($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^log//i) {
       chk_lparen("log");
       $val = expr();
       PrintFatalError("Can't take log of $val", $lc) if $val <= 0;
       $val = log($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^sin//i) {
       chk_lparen("sin");
       $val = expr();
       $val = sin($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^sgn//i) {
       chk_lparen("sgn");
       $val = expr();
       if ($val > 0) { 
         $val = 1;
       }
       elsif ($val == 0) {
         $val = 0;
       }
       else {
         $val = -1;
       }
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^sqrt//i) {
       chk_lparen("sqrt");
       $val = expr();
       $val = sqrt($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^tan//i) {
       chk_lparen("tan");
       $val = expr();
       $val = sin($val)/cos($val);
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^xcoord//i) {
       chk_lparen("xcoord");
       my $point_name = get_point;
       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_name});
       $val = $x1;
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^ycoord//i) {
       chk_lparen("ycoord");
       my $point_name = get_point;
       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_name});
       $val = $y1;
       chk_rparen("Missing right parenthesis", $lc);
    }
    elsif (s/^_pi_//i) {
       $val = PI;
    }
    elsif (s/^_e_//i) {
       $val = 2.71828182845905;
    }
    elsif (s/^_linethickness_//i) {
       $val = $LineThickness / $xunits;
    }
    else  {
      my $err_code;
      ($val,$err_code) = ComputeDist($lc);
    }
    s/\s*//;
    return $val;
  }

  sub memberOf {
     my $elem = shift(@_);

     my $found = 0;
     foreach $item (@_){
         if ($item eq $elem){
            $found = 1;
            last;
         }
     }
     return $found;
  }

  sub midpoint {
    my ($x1, $y1, $x2, $y2)=@_;
    return ($x1 + ($x2 - $x1)/2, 
            $y1 + ($y2 - $y1)/2);
  }


  sub tand {
    my $d = $_[0];
    $d = $d * PI / 180;
    return sin($d)/cos($d);
  }

  sub get_string {
    my $string = shift;
    my $lc = shift;

    $string =~ s/^\s+//;
    if ($string !~ s/^\"//) {
      PrintErrorMessage("No starting \" found",$lc);
      return (1,$string,$string);
    }
    my @ch = split //,$string;
    my @cmd;
    while (@ch and $ch[0] ne "\"") {
      if ($ch[0] eq "\\" and (defined $ch[1]) and $ch[1] eq "\"") {
         shift @ch;
         push @cmd, $ch[0];
         shift @ch;
      }
      else {
        push @cmd, $ch[0];
        shift @ch;
      }
    }
    if (! defined $ch[0]) {
       PrintErrorMessage("No closing \" found",$lc);
       return (1,join("",@cmd), join("",@ch))
    }
    else {
      shift @ch;
      return (0, join("",@cmd), join("",@ch))
    }
  }

  sub is_tainted {
    my $arg = shift;
    my $nada = substr($arg,0,0);
    local $@;
    eval { eval "# $nada"};
    return length($@) != 0;
  }

  sub noOfDigits {
    my $num = $_[0];

    if ($num =~ /^[\+-]?\d+(?!\.)/) {
      return 0;
    }
    elsif ($num =~ /^[\+-]\d+\.(\d+)?/) {
      return length($1);
    }
  }

  sub drawsquare {
     my $s = $_[0];
     #$s *= sqrt(2);
     $s = sprintf "%.5f", $s;
     my $code = "\\setlength{\\unitlength}{$xunits}%\n";
     $code .= "\\begin{picture}($s,$s)\\put(0,0)" .
              "{\\framebox($s,$s){}}\\end{picture}";
     return $code;
  }

  sub X2sp {
     my $LT = shift;
     my $units = shift;

     if ($units eq "pc") {
       return $LT * 786432;
     }
     elsif ($units eq "pt") {
       return $LT * 65536;
     }
     elsif ($units eq "in") {
       return $LT * 4736286.72;
     }
     elsif ($units eq "bp") {
       return $LT * 65781.76;
     }
     elsif ($units eq "cm") {
       return $LT * 1864679.811023622;
     }
     elsif ($units eq "mm") {
       return $LT * 186467.981102362;
     }
     elsif ($units eq "dd") {
       return $LT * 70124.086430424;
     }
     elsif ($units eq "cc") {
       return $LT * 841489.037165082;
     }
     elsif ($units eq "sp") {
       return $LT;
     }
  }


  sub sp2X {
     my $LT = shift;
     my $units = shift;

     if ($units eq "pc") {
       return $LT / 786432;
     }
     elsif ($units eq "pt") {
       return $LT / 65536;
     }
     elsif ($units eq "in") {
       return $LT / 4736286.72;
     }
     elsif ($units eq "bp") {
       return $LT / 65781.76;
     }
     elsif ($units eq "cm") {
       return $LT / 1864679.811023622;
     }
     elsif ($units eq "mm") {
       return $LT / 186467.981102362;
     }
     elsif ($units eq "dd") {
       return $LT / 70124.086430424;
     }
     elsif ($units eq "cc") {
       return $LT / 841489.037165082;
     }
     elsif ($units eq "sp") {
       return $LT;
     }
  }

  sub setLineThickness {
    my $Xunits = shift;
    my $LT = shift;
    $Xunits =~ s/^((\+|-)?\d+(\.\d+)?([eE](\+|-)?\d+)?)//;
    my $xlength = "$1";
    $Xunits =~ s/^\s*($units)//;
    my $x_in_units = $1;
    $LT =~ s/^((\+|-)?\d+(\.\d+)?([eE](\+|-)?\d+)?)//;
    my $LTlength = "$1";
    $LT =~ s/^\s*($units)//;
    my $LT_in_units = $1;
    $LTlength = X2sp($LTlength,$LT_in_units);
    $LTlength = sp2X($LTlength,$x_in_units);
    return $LTlength;
  }

    sub process_input {
      my ($INFILE,$currInFile) = @_;
      my $lc = 0;
      my $no_output = 0;
      $curr_in_file = $currInFile;
      LINE: while(<$INFILE>) {
        $lc++;
        chomp($command = $_);
        s/^\s+//;
        if (/^beginSkip\s*/i) {
          $no_output = 1;
          print OUT "%%$_" if $comments_on;
          next LINE;
        }
        elsif (/^endSkip\s*/i) {
          if ($no_output == 0) {
            PrintErrorMessage("endSkip without beginSkip",$lc);
          }
          else {
            $no_output = 0;
          }
          print OUT "%%$_" if $comments_on and !$no_output;
          next LINE;
       }
       elsif ($no_output == 1) {
         next LINE;
       }
       else {
          if (/^[^\\]/) {
            my $out_line  = mpp($command,$lc) unless /^\\/;  #call macro pre-processor
            $_ = "$out_line\n";
          }
         
           if (/^\s*%/)
           {
              print OUT "$_" if $comments_on;
           }
           elsif (s/^\s*(beginloop(?=\W))//i) {
             s/\s+//;
             my $times = expr($lc);
             print OUT "%% BEGINLOOP $times\n" if $comments_on;
             my @C = ();
             REPEATCOMMS: while (<$INFILE>) {
               if (/^\s*endloop/i) {
                 last REPEATCOMMS;
               }
               else {
                 push @C, $_;
               }
             }
             if (! /^\s*endloop/i) {
               PrintFatalError("unexpected end of file",$lc);
             }
             else {
               s/^\s*endloop//i;
               for(my $i=1; $i<=$times; $i++) {
                 tie *DUMMY, 'DummyFH', \@C;
                 process_input(DUMMY, $currInFile);
                 untie *DUMMY;
               }
               print OUT "%% ENDLOOP\n" if $comments_on;
             }
           }
           elsif (s/^\s*(ArrowShape(?=\W))//i)
           {
               my $cmd = $1;
               print OUT "%% $cmd$_" if $comments_on;
              
                      chk_lparen("$cmd",$lc);
                      if (s/^default//i) {
                        $arrowLength = 2;
                        $arrowLengthUnits = "mm";
                        $arrowAngleB = 30;
                        $arrowAngleC = 40;
                      }
                      else {
                        my ($LocalArrowLength, $LocalArrowAngleB ,$LocalArrowAngleC) = (0,0,0);
                        $LocalArrowLength = expr($lc);
                        if (s/^\s*($units)//i) {
                          $arrowLengthUnits = "$1";
                        }
                        else {
                          $xunits =~ /(\d+(\.\d+)?)\s*($units)/;
                          $LocalArrowLength *= $1;
                          $arrowLengthUnits = "$3";
                        }
                        chk_comma($lc);
                        $LocalArrowAngleB = expr($lc);
                        chk_comma($lc);
                        $LocalArrowAngleC = expr($lc);
                        $arrowLength = ($LocalArrowLength == 0 ? 2  : $LocalArrowLength);
                        $arrowLengthUnits = ($LocalArrowLength == 0 ? "mm" : $arrowLengthUnits);
                        $arrowAngleB = ($LocalArrowAngleB == 0 ? 30 : $LocalArrowAngleB);
                        $arrowAngleC = ($LocalArrowAngleC == 0 ? 40 : $LocalArrowAngleC);
                      }
                      chk_rparen("after $cmd arguments",$lc);
                      chk_comment("after $cmd command",$lc);
                      print OUT "%% arrowLength = $arrowLength$arrowLengthUnits, ",
                                "arrowAngleB = $arrowAngleB ",
                                "and arrowAngleC = $arrowAngleC\n" if $comments_on;

           }
           elsif (s/^\s*(const(?=\W))//i)
           {
              print OUT "%% $1$_" if $comments_on;
                  do{
                    s/\s*//;
                    PrintErrorMessage("no identifier found after token const",$lc)
                      if $_ !~ s/^([^\W\d_]\d{0,4})//i;
                    my $Constname = $1;
                    my $constname = lc($Constname);
                    if (exists $ConstTable{$constname}) {
                      PrintErrorMessage("Redefinition of constant $constname",$lc);
                    }
                    s/\s*//; #remove leading white space
                    PrintErrorMessage("did not find expected = sign",$lc)
                      if $_ !~ s/^[=]//i;
                    my $val = expr($lc);
                    $VarTable{$constname} = $val;
                    $ConstTable{$constname} = 1;
                    print OUT "%% $Constname = $val\n" if $comments_on;
                  }while (s/^,//);
                  chk_comment($lc);
                  s/\s*//;
                  if (/^[^%]/) {
                    PrintWarningMessage("Trailing text is ignored",$lc);
                  }

           }
           elsif (s/^\s*(dasharray(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
                    chk_lparen($cmd,$lc);
                    my @DashArray = ();
                    my $dash = "";
                    my $dashpattern = "";
                    PATTERN: while (1) {
                      $dash = sprintf("%.5f", expr($lc));
                      if (s/^\s*($units)//i) {
                         push (@DashArray, "$dash$1");
                      }
                      else {
                        PrintErrorMessage("Did not found unit after expression", $lc);
                      }
                      s/\s*//;
                      if (/^[^,]/) {
                        last PATTERN;
                      }
                      else {
                        s/^,\s*//;
                      }
                    }
                    print OUT "\\setdashpattern <";
                    while (@DashArray) {
                      $dashpattern .= shift @DashArray;
                      $dashpattern .= ",";
                    }
                    $dashpattern =~ s/,$//;
                    print OUT $dashpattern, ">\n";
                    chk_rparen("arguments of $cmd",$lc);
                    chk_comment($lc);

           }
           elsif (s/^\s*(drawAngleArc(?=\W))//i or s/^\s*(drawAngleArrow(?=\W))//i )
           {
              my $cmd = $1;
              print OUT "%% $cmd$_" if $comments_on;
              
                    chk_lcb($cmd,$lc);
                          my ($P1, $P2, $P3);
                          if (s/^angle(?=\W)//i) {
                            chk_lparen("token angle of command $cmd",$lc);
                            $P1 = get_point($lc);
                            next LINE if $P1 eq "_undef_";
                            $P2 = get_point($lc);
                            next LINE if $P2 eq "_undef_";
                            $P3 = get_point($lc);
                            next LINE if $P3 eq "_undef_";
                            my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$P1});
                            my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$P2});
                            my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$P3});
                            my $Angle = Angle($x1, $y1, $x2, $y2, $x3, $y3);
                            if ($Angle <= 0) {
                              if ($Angle == 0) {
                                PrintErrorMessage("Angle is equal to zero",$lc);
                                next LINE;
                              }
                              elsif ($Angle < -400) {
                                PrintErrorMessage("Something is wrong with the points",$lc);
                                next LINE;
                              }
                            }
                            chk_rparen("angle part of command $cmd",$lc);
                          }
                          else {
                            PrintErrorMessage("Did not find expected angle part",$lc);
                            next LINE;
                          }

                    s/^,\s*// or s/\s*//; #parse optional comma
                    
                         my $radius;
                         if (s/^radius(?=\W)//i) {
                           chk_lparen("token radius of command $cmd",$lc);
                           $radius = expr($lc);
                           chk_rparen("radius part of command $cmd",$lc);
                         }
                         else {
                           PrintErrorMessage("Did not found expected angle part",$lc);
                           next LINE;
                         }

                    s/^,\s*// or s/\s*//; #parse optional comma
                    my $inout = "";
                    if (s/^(internal(?=\W))//i or s/^(external(?=\W))//i) {
                      $inout = $1;
                    }
                    else {
                      PrintErrorMessage("Did not find expected 'internal' specifier", $lc);
                      next LINE;
                    }
                    s/^,\s*// or s/\s*//; #parse optional comma
                    my $direction = "";
                    if (s/^(clockwise(?=\W))//i or s/^(anticlockwise(?=\W))//i) {
                      $direction = $1;
                    }
                    else {
                      PrintErrorMessage("Did not find expected 'direction' specifier", $lc);
                      next LINE;
                    }
                    chk_rcb("arguments of $cmd",$lc);
                    chk_comment($lc);
                    my $code;
                    if (lc($cmd) eq "drawanglearc") {
                      $code = drawAngleArc($P1, $P2, $P3, $radius, $inout, $direction);
                    }
                    else {
                      $code = drawAngleArrow($P1, $P2, $P3, $radius, $inout, $direction);
                    }
                    print OUT $code if $code ne "";

           }
           elsif (s/^\s*(drawArrow(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
              DrawLineOrArrow(0,$lc);
           }
           elsif (s/^\s*(drawcircle(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
                    chk_lparen("drawcircle",$lc);
                    my $Point = get_point($lc);
                    next LINE if $Point eq "_undef_";
                    chk_comma($lc);
                    my $R = expr($lc);
                    if ($R <= 0) {
                       PrintErrorMessage("Radius must be greater than zero",$lc);
                       next LINE;
                    }
                    my ($x,$y,$pSV,$pS)=unpack("d3A*",$PointTable{lc($Point)});
                    printf OUT "\\circulararc 360 degrees from %.5f %.5f center at %.5f %.5f\n",
                                $x+$R, $y, $x, $y;
                    chk_rparen("arguments of $cmd",$lc);
                    chk_comment($lc);

           }
           elsif (s/^\s*(drawcurve(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
              DrawLineOrArrow(2,$lc);
           }
           elsif (s/^\s*(drawcircumcircle(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
                    chk_lparen("drawcircumcircle",$lc);
                    my $point1 = get_point($lc);
                    next LINE if $point1 eq "_undef_";
                    my $point2 = get_point($lc);
                    next LINE if $point2 eq "_undef_";
                    my $point3 = get_point($lc);
                    next LINE if $point3 eq "_undef_";
                    my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point1});
                    my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point2});
                    my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point3});
                    my ($xc, $yc,$r) = circumCircleCenter($x1,$y1,$x2,$y2,$x3,$y3,$lc);
                    next LINE if $xc == 0 and  $yc == 0 and $r == 0;
                    print OUT "%% circumcircle center = ($xc,$yc), radius = $r\n" if $comments_on;
                    printf OUT "\\circulararc 360 degrees from %.5f %.5f center at %.5f %.5f\n",
                                $xc+$r, $yc, $xc, $yc;
                    chk_rparen("arguments of $cmd",$lc);
                    chk_comment($lc);

           }
           elsif (s/^\s*(drawexcircle(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
                   chk_lparen("drawexcircle",$lc);
                   my $point1 = get_point($lc);
                   next LINE if $point1 eq "_undef_";
                   my $point2 = get_point($lc);
                   next LINE if $point2 eq "_undef_";
                   my $point3 = get_point($lc);
                   next LINE if $point3 eq "_undef_";
                   my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point1});
                   my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point2});
                   my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point3});
                   if (triangleArea($x1, $y1, $x2, $y2, $x3, $y3) < 0.0001) {
                     PrintErrorMessage("Area of triangle is zero!",$lc);
                     next LINE;
                   }
                   chk_comma($lc);
                   my $point4 = get_point($lc);
                   if (!memberOf($point4, $point1, $point2, $point3)) {
                     PrintErrorMessage("Current point isn't a side point",$lc);
                     next LINE;
                   }
                   next LINE if $point4 eq "_undef_";
                   my $point5 = get_point($lc);
                   next LINE if $point5 eq "_undef_";
                   if (!memberOf($point5, $point1, $point2, $point3)) {
                     PrintErrorMessage("Current point isn't a side point",$lc);
                     next LINE;
                   }
                   if ($point4 eq $point5) {
                     PrintErrorMessage("Side points are identical",$lc);
                     next LINE;
                   }
                   chk_rparen("arguments of $cmd",$lc);
                   my ($xc, $yc, $r) = excircle($point1, $point2, $point3,
                                                $point4, $point5);
                   my $R=$r;
                   if (s/^\s*\[\s*//) {
                      $R += expr($lc);
                      if ($R < 0.0001) {
                        PrintErrorMessage("Radius has become equal to zero!",$lc);
                        next LINE;
                      }
                      chk_rsb($lc);
                   }
                   if ($R > (500 / 2.845)) {
                     PrintErrorMessage("Radius is greater than 175mm!",$lc);
                     next LINE;
                   }
                   print OUT "%% excircle center = ($xc,$yc) radius = $R\n" if $comments_on;
                   printf OUT "\\circulararc 360 degrees from %.5f %.5f center at %.5f %.5f\n",
                                $xc+$R, $yc, $xc, $yc;
                   chk_comment($lc);

           }
           elsif (s/^\s*(drawincircle(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
                   chk_lparen("drawincircle",$lc);
                   my $point1 = get_point($lc);
                   next LINE if $point1 eq "_undef_";
                   my $point2 = get_point($lc);
                   next LINE if $point2 eq "_undef_";
                   my $point3 = get_point($lc);
                   next LINE if $point3 eq "_undef_";
                   my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point1});
                   my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point2});
                   my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point3});
                   if (triangleArea($x1, $y1, $x2, $y2, $x3, $y3) < 0.0001) {
                     PrintErrorMessage("Area of triangle is zero!",$lc);
                     next LINE;
                   }
                   my ($xc, $yc, $r) = IncircleCenter($x1,$y1,$x2,$y2,$x3,$y3);
                   my $R=$r;
                   if (s/^\s*\[\s*//) {
                      $R += expr($lc);
                      if ($R < 0.0001) {
                        PrintErrorMessage("Radius has become equal to zero!",$lc);
                        next LINE;
                      }
                      chk_rsb($lc);
                   }
                   if ($R > (500 / 2.845)) {
                     PrintErrorMessage("Radius is greater than 175mm!",$lc);
                     next LINE;
                   }
                   print OUT "%% incircle center = ($xc,$yc) radius = $R\n" if $comments_on;
                   printf OUT "\\circulararc 360 degrees from %.5f %.5f center at %.5f %.5f\n",
                                $xc+$R, $yc, $xc, $yc;
                   chk_rparen("arguments of $cmd",$lc);
                   chk_comment($lc);

           }
           elsif (s/^\s*(drawline(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
              DrawLineOrArrow(1,$lc);
           }
           elsif (s/^\s*(drawthickarrow(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
              print OUT "\\setplotsymbol  ({\\usefont{OT1}{cmr}{m}{n}\\large .})%\n";
              print OUT "{\\setbox1=\\hbox{\\usefont{OT1}{cmr}{m}{n}\\large .}%\n";
              print OUT " \\global\\linethickness=0.31\\wd1}%\n";
              DrawLineOrArrow(0,$lc);
              print OUT "\\setlength{\\linethickness}{0.4pt}%\n";
              print OUT "\\setplotsymbol  ({\\usefont{OT1}{cmr}{m}{n}\\tiny .})%\n";
           }
           elsif (s/^\s*(drawthickline(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
              print OUT "\\setplotsymbol  ({\\usefont{OT1}{cmr}{m}{n}\\large .})%\n";
              print OUT "{\\setbox1=\\hbox{\\usefont{OT1}{cmr}{m}{n}\\large .}%\n";
              print OUT " \\global\\linethickness=0.31\\wd1}%\n";
              DrawLineOrArrow(1,$lc);
              print OUT "\\setlength{\\linethickness}{0.4pt}%\n";
              print OUT "\\setplotsymbol  ({\\usefont{OT1}{cmr}{m}{n}\\tiny .})%\n";
           }
           elsif (s/^\s*(drawperpendicular(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
              
                    chk_lparen($cmd,$lc);
                    my $A = get_point($lc);
                    next LINE if $A eq "_undef_";
                    chk_comma($lc);
                    my $B = get_point($lc);
                    next LINE if $A eq "_undef_";
                    s/\s*//; #ignore white space
                    my $C = get_point($lc);
                    next LINE if $A eq "_undef_";
                    chk_rparen("arguments of $cmd",$lc);
                    chk_comment($lc);
                    #
                    #start actual computation
                    #
                    my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$A});
                    my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$B});
                    my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$C});
                    my ($xF, $yF) = perpendicular($x1, $y1, $x2, $y2, $x3, $y3);
                    printf OUT "\\plot  %.5f %.5f    %.5f %.5f  /\n",
                           $x1, $y1, $xF, $yF;

           }
           elsif (s/^\s*(drawpoint(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
                    my ($stacklen);
                    chk_lparen("$cmd",$lc);
                    if (/^\)/) {
                      PrintErrorMessage("There are no point to draw",$lc);
                      next LINE;
                    }
                    my(@PP);
                    DRAWPOINTS:while(1) {
                      if (s/^([^\W\d_]\d{0,4})//i) { #point name
                        $P = $1;
                        if (!exists($PointTable{lc($P)})) {
                          PrintErrorMessage("Undefined point $P",$lc);
                          next DRAWPOINTS;
                        }
                        else {
                          push (@PP,$P);
                          s/\s*//;
                        }
                      }
                      else {
                        last DRAWPOINTS;
                      }
                    }
                    drawpoints(@PP);
                    chk_rparen("arguments of $cmd",$lc);
                    chk_comment($lc);

           }
           elsif (s/^\s*(drawRightAngle(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
              
                   chk_lparen("drawRightAngle",$lc);
                   my $point1 = get_point($lc);
                   next LINE if $point1 eq "_undef_";
                   my $point2 = get_point($lc);
                   next LINE if $point2 eq "_undef_";
                   my $point3 = get_point($lc);
                   next LINE if $point3 eq "_undef_";
                   my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point1});
                   my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point2});
                   my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point3});
                   chk_comma($lc);
                   my $dist = expr($lc);
                   chk_rparen("arguments of $cmd",$lc);
                   chk_comment($lc);
                   #
                   #actual computation
                   #
                   my ($Px, $Py) = pointOnLine($x2, $y2, $x1, $y1, $dist);
                   my ($Qx, $Qy) = pointOnLine($x2, $y2, $x3, $y3, $dist);
                   my ($Tx, $Ty) = midpoint($Px, $Py, $Qx, $Qy);
                   my ($Ux, $Uy) = pointOnLine($x2, $y2, $Tx, $Ty, 2*Length($x2, $y2, $Tx, $Ty));
                   if ($Px == $Ux || $Py == $Uy) {
                     printf OUT "\\putrule from %.5f %.5f to %.5f %.5f \n", $Px,$Py,$Ux,$Uy;
                   }
                   else {
                     printf OUT "\\plot %.5f %.5f\t%.5f %.5f / \n", $Px, $Py,$Ux,$Uy;
                   }
                   if ($Ux == $Qx || $Uy == $Qy) {
                     printf OUT "\\putrule from %.5f %.5f to %.5f %.5f \n", $Ux,$Uy,$Qx,$Qy;
                   }
                   else {
                     printf OUT "\\plot %.5f %.5f\t%.5f %.5f / \n", $Ux, $Uy,$Qx,$Qy;
                   }


           }
           elsif (s/^\s*(drawsquare(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
                 chk_lparen("drawSquare",$lc);
                 my $p = get_point($lc);
                 chk_comma($lc);
                 my $side = expr($lc);
                 $side = $side - (1.1 * $LineThickness/$xunits); #Suggested by RWDN
                 my ($x,$y,$pSV,$pS) = unpack("d3A*",$PointTable{$p});
                 printf OUT "\\put {%s} at %.5f %.5f %%drawsquare\n", drawsquare($side), $x, $y;
                 chk_rparen("arguments of $cmd",$lc);
                 chk_comment($lc);

           }
           elsif (s/^\s*inputfile\*//i)
           {
                   chk_lparen("inputfile*",$lc);
                   my $row_in = "";
                   if (s/^((\w|-|\.)+)//) {
                     $row_in = $1;
                   }
                   else {
                     PrintErrorMessage("No input file name found",$lc);
                     next LINE;
                   }
                   if (!(-e $row_in)) {
                     PrintErrorMessage("File $row_in does not exist",$lc);
                     next LINE;
                   }
                   open(ROW, "$row_in")|| die "Can't open file $row_in\n";
                   while (defined($in_line=<ROW>)) { print OUT $in_line; }
                   print OUT "%% ... end of input file <$row_in>\n";
                   close ROW;
                   chk_rparen("input file name",$lc);
                   chk_comment($lc);


           }
           elsif (s/^\s*(inputfile(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
              
                   chk_lparen("inputfile",$lc);
                   my $comm_in = "";
                   if (s/^((\w|-|\.)+)//) {
                     $comm_in = $1;
                   }
                   else {
                     PrintErrorMessage("No input file name found",$lc);
                     next LINE;
                   }
                   if (!(-e $comm_in)) {
                     PrintErrorMessage("File $comm_in does not exist",$lc);
                     next LINE;
                   }
                   chk_rparen("input file name",$lc);
                   my $input_times = 1; #default value
                   if (s/^\[//) {
                     $input_times = expr($lc);       
                     chk_rsb("optional argument",$lc);
                   }
                   print OUT "%% ... start of file <$comm_in> loop [$input_times]\n";
                   for (my $i=0; $i<int($input_times); $i++) {
                     open(COMM,"$comm_in") or die "Can't open file $comm_in\n";
                     print OUT "%%% Iteration number: ",$i+1,"\n";
                     my $old_file_name = $curr_in_file;
                     process_input(COMM,"File $comm_in, ");
                     $curr_in_file = $old_file_name;
                     close COMM;
                   }
                   print OUT "%% ... end of file <$comm_in> loop [$input_times]\n";
                   chk_comment($lc);

           }
           elsif (s/^\s*(linethickness(?=\W))//i)
           {
              my $cmd = $1;
              print OUT "%% $cmd$_" if $comments_on;
                   chk_lparen("linethickness", $lc);
                   if (s/^default//i) {
                     print OUT "\\linethickness=0.4pt\\Linethickness{0.4pt}%%\n";
                     print OUT "\\setplotsymbol  ({\\usefont{OT1}{cmr}{m}{n}\\tiny .})%\n";
                     $LineThickness = setLineThickness($xunits,"0.4pt");
                   }
                   else {
                     my $length = expr($lc);
                     if (s/^\s*($units)//i) {
                       my $units = $1;
                       printf OUT "\\linethickness=%.5f%s\\Linethickness{%.5f%s}%%\n",
                              $length, $units, $length, $units;
                       $LineThickness = setLineThickness($xunits,"$length$units");
                       my $mag;
                       if ($units eq "pc") {
                         $mag = $length * 12;
                       }
                       elsif ($units eq "in") {
                         $mag = $length * 72.27;
                       }
                       elsif ($units eq "bp") {
                         $mag = $length * 1.00375;
                       }
                       elsif ($units eq "cm") {
                         $mag = $length * 28.45275;
                       }
                       elsif ($units eq "mm") {
                         $mag = $length * 2.845275;
                       }
                       elsif ($units eq "dd") {
                         $mag = $length * 1.07001;
                       }
                       elsif ($units eq "cc") {
                         $mag = $length * 0.08917;
                       }
                       elsif ($units eq "sp") {
                         $mag = $length * 0.000015259;
                       }
                       elsif ($units eq "pt") {
                         $mag = $length;
                       }
                       $mag = 10 * $mag / 1.00278219;
                       printf OUT "\\font\\CM=cmr10 at %.5fpt%%\n", $mag;
                       print OUT "\\setplotsymbol  ({\\CM .})%\n";
                     }
                     else {
                       PrintErrorMessage("Did not found expect units part",$lc);
                     }
                   }
                   chk_rparen("linethickness", $lc);
                   chk_comment($lc);


           }
           elsif (s/^\s*(paper(?=\W))//i)
           {
              my ($cmd) = $1;
              print OUT "%% $cmd$_" if $comments_on;
                   chk_lcb("paper", $lc);
                   if (s/^units(?=\W)//i)
                   {
                      
                              chk_lparen("units",$lc);
                              if(s/^\)//)
                              {
                                PrintWarningMessage("Missing value in \"units\"--default is 1pt",
                                                       $lc);
                                $xunits = "1pt";          
                              }
                              else {
                                $xunits = expr($lc);
                                s/\s*//;
                                if (s/^($units)//i) {
                                  $xunits .= "$1";
                                  $LineThickness = setLineThickness($xunits,"0.4pt");
                                }
                                elsif(s/^(\w)+//i) {
                                  PrintErrorMessage("$1 is not a valid mathspic unit",$lc);
                                  $xunits = "1pt";
                                }
                                else {
                                  PrintErrorMessage("No x-units found",$lc);
                                  $xunits = "1pt";
                                }
                                s/\s*//; #ignore white space
                                if (s/^,//) {  # there is a comma so expect an y-units
                                  s/\s*//; #ignore white space
                                  $yunits = expr($lc);
                                  s/\s*//; #ignore white space
                                  if (s/^($units)//i) {
                                    $yunits .= "$1";
                                  }
                                  elsif(s/^(\w)+//i) {
                                    PrintErrorMessage("$1 is not a valid mathspic unit",$lc);
                                    $yunits = "1pt";
                                  }
                                  else {
                                    PrintErrorMessage("No y-units found",$lc);
                                    $yunits = $xunits;
                                  }
                                }
                                else {
                                  $yunits = $xunits;
                                }
                                chk_rparen("units",$lc);
                              }

                      $nounits = 0;
                   }
                   else
                   {
                      $nounits = 1;
                   }
                   s/^,\s*// or s/\s*//;
                   if (s/^xrange//i)
                   {
                      
                              chk_lparen("xrange",$lc);
                              my $ec;
                              ($xlow,$ec) = ComputeDist($lc);
                              next LINE if $ec == 0;
                              chk_comma($lc);
                              ($xhigh,$ec) = ComputeDist($lc);
                              next LINE if $ec == 0;
                              if ($xlow >= $xhigh)
                              {
                                 PrintErrorMessage("xlow >= xhigh in xrange",$lc);
                                 next LINE;
                              }
                              chk_rparen("$xhigh",$lc);

                      $noxrange = 0;
                   }
                   else
                   {
                      $noxrange = 1;
                   }
                   s/^,\s*// or s/\s*//;
                   if (s/^yrange//i)
                   {
                      
                              chk_lparen("yrange",$lc);
                              my $ec;
                              ($ylow,$ec) = ComputeDist($lc);
                              next LINE if $ec == 0;
                              chk_comma($lc);
                              ($yhigh,$ec) = ComputeDist($lc);
                              next LINE if $ec == 0;
                              if ($ylow >= $yhigh)
                              {
                                 PrintErrorMessage("ylow >= yhigh in yrange",$lc);
                                 next LINE;
                              }
                              chk_rparen("$yhigh",$lc);

                      $noyrange = 0;
                   }
                   else
                   {
                      $noyrange = 1;
                   }
                   
                       if (!$nounits)
                       {
                          printf OUT "\\setcoordinatesystem units <%s,%s>\n",
                                     $xunits,$yunits;
                       }
                       if(!$noxrange && !$noyrange)
                       {
                          printf OUT "\\setplotarea x from %.5f to %.5f, y from %.5f to %.5f\n",
                                     $xlow, $xhigh, $ylow, $yhigh;

                       }

                   s/^,\s*// or s/\s*//;
                   $axis = "";
                   if (s/^ax[ei]s(?=\W)//i)
                   {
                      
                              chk_lparen("axis",$lc);
                              while(/^[^\)]/)
                              {
                                  if (s/^([lrtbxy]{1}\*?)//i)
                                  {
                                     $axis .= $1;
                                  }
                                  elsif (s/^([^lrtbxy])//i)
                                  {
                                     PrintErrorMessage("Non-valid character \"$1\" in axis()",$lc);
                                  }
                                  s/\s*//;
                              }
                              chk_rparen("axis(arguments",$lc);

                   }
                   $axis = uc($axis);
                   s/^,\s*// or s/\s*//;
                   if (s/^ticks(?=\W)//i)
                   {
                              chk_lparen("ticks",$lc);
                              my $ec;
                              ($xticks,$ec) = ComputeDist($lc);
                              next LINE if $ec == 0;
                              chk_comma($lc);
                              ($yticks,$ec) = ComputeDist($lc);
                              next LINE if $ec == 0;
                              chk_rparen("ticks(arguments",$lc);

                   }
                   else
                   {
                      $xticks = $yticks = 0;
                   }
                   chk_rcb("paper", $lc);
                   YBRANCH: {
                      if (index($axis, "Y")>-1)
                      {
                         if (index($axis, "Y*")>-1)
                         {
                            print OUT "\\axis left shiftedto x=0 / \n";
                            last YBRANCH;
                         }
                         if ($yticks > 0)
                         {
                            if (index($axis, "T")>-1 && index($axis, "B")==-1)
                            {
                               print OUT "\\axis left shiftedto x=0 ticks numbered from ";
                               print OUT "$ylow to -$yticks by $yticks\n      from $yticks to ";
                               print OUT $yhigh-$yticks," by $yticks /\n";
                            }
                            elsif (index($axis, "T")==-1 && index($axis, "B")>-1)
                            {
                               print OUT "\\axis left shiftedto x=0 ticks numbered from ";
                               print OUT $ylow+$yticks," to -$yticks by $yticks\n      from ";
                               print OUT "$yticks to $yhigh by $yticks /\n";
                            }
                            elsif (index($axis, "T")>-1 && index($axis, "B")>-1)
                            {
                               print OUT "\\axis left shiftedto x=0 ticks numbered from ";
                               print OUT $ylow+$yticks," to -$yticks by $yticks\n      from ";
                               print OUT "$yticks to ",$yhigh-$yticks," by $yticks /\n";
                            }
                            else
                            {
                               print OUT "\\axis left shiftedto x=0 ticks numbered from ";
                               print OUT "$ylow to -$yticks by $yticks\n      from ";
                               print OUT "$yticks to $yhigh by $yticks /\n";
                            }
                         }
                         else
                         {
                            print OUT "\\axis left shiftedto x=0 /\n";
                         }
                      }
                      }
                      XBRANCH: { if (index($axis, "X")>-1)
                      {
                         if (index($axis, "X*")>-1)
                         {
                            print OUT "\\axis bottom shiftedto y=0 /\n";
                            last XBRANCH;
                         }
                         if ($xticks > 0)
                         {
                            if (index($axis, "L")>-1 && index($axis, "R")==1)
                            {
                               print OUT "\\axis bottom shiftedto y=0 ticks numbered from ";
                               print OUT $xlow + $xticks," to -$xticks by $xticks\n      from";
                               print OUT " $xticks to $xhigh by $xticks /\n";
                            }
                            elsif (index($axis, "L")==-1 && index($axis, "R")>-1)
                            {
                               print OUT "\\axis bottom shiftedto y=0 ticks numbered from ";
                               print OUT "$xlow to -$xticks by $xticks\n      from ";
                               print OUT "$xticks to ",$xhigh-$xticks," by $xticks /\n";
                            }
                            elsif (index($axis, "L")>-1 && index($axis, "R")>-1)
                            {
                               print OUT "\\axis bottom shiftedto y=0 ticks numbered from ";
                               print OUT $xlow + $xticks," to -$xticks by $xticks\n      from ";
                               print OUT "$xticks to ",$xhigh - $xticks," by $xticks /\n";
                            }
                            else
                            {
                               print OUT "\\axis bottom shiftedto y=0 ticks numbered from ";
                               print OUT "$xlow to -$xticks by  $xticks\n      from ";
                               print OUT "$xticks to $xhigh by $xticks /\n";
                            }
                         }
                         else
                         {
                            print OUT "\\axis bottom shiftedto y=0 /\n";
                         }
                      } }
                      LBRANCH: {if (index($axis, "L")>-1)
                      {
                         if (index($axis, "L")>-1)
                         {
                            if (index($axis, "L*")>-1)
                            {
                               print OUT "\\axis left /\n";
                               last LBRANCH;
                            }
                            if ($yticks > 0)
                            {
                               print OUT "\\axis left ticks numbered from ";
                               print OUT "$ylow to $yhigh by $yticks /\n";
                            }
                            else
                            {
                               print OUT "\\axis left /\n";
                            }
                         }
                      } }
                      RBRANCH: { if (index($axis, "R")>-1)
                      {
                         if (index($axis, "R*")>-1)
                         {
                            print OUT "\\axis right /\n";
                            last RBRANCH;
                         }
                         if ($yticks > 0)
                         {
                            print OUT "\\axis right ticks numbered from $ylow to $yhigh by ";
                            print OUT "$yticks /\n";
                         }
                         else
                         {
                            print OUT "\\axis right /\n";
                         }
                      } }
                      TBRANCH: { if (index($axis, "T")>-1)
                      {
                         if (index($axis, "T*")>-1)
                         {
                            print OUT "\\axis top /\n";
                            last TBRANCH;
                         }
                         if ($xticks > 0)
                         {
                            print OUT "\\axis top ticks numbered from $xlow to $xhigh by ";
                            print OUT "$xticks /\n";
                         }
                         else
                         {
                            print OUT "\\axis top /\n";
                         }
                      } }
                      BBRANCH: { if (index($axis, "B")>-1)
                      {
                         if (index($axis, "B*")>-1)
                         {
                            print OUT "\\axis bottom /\n";
                            last BBRANCH;
                         }
                         if ($xticks > 0)
                         {
                            print OUT "\\axis bottom ticks numbered from $xlow to $xhigh by ";
                            print OUT "$xticks /\n";
                         }
                         else
                         {
                            print OUT "\\axis bottom /\n";
                         }
                      } }


                   chk_comment($lc);

           }
           elsif (s/^\s*(PointSymbol(?=\W))//i)
           {
               my $cmd = $1;
               print OUT "%% $cmd$_" if $comments_on;
              
                      chk_lparen("$cmd",$lc);
                      if (s/^default//i) #default point symbol
                      {
                         $defaultsymbol = "\$\\bullet\$";
                      }
                      elsif (s/^(circle|square)//i) {
                        $defaultsymbol = $1;
                        chk_lparen($defaultsymbol, $lc);
                        $GlobalDimOfPoints = expr($lc);
                        chk_rparen("expression", $lc);          
                      }
                      elsif (s/^(((\\,){1}|(\\\)){1}|(\\\s){1}|[^\),\s])+)//) #arbitrary LaTeX point
                      {
                         $defaultsymbol = $1;
                         $defaultsymbol=~ s/\\\)/\)/g;
                         $defaultsymbol=~ s/\\,/,/g;
                         $defaultsymbol=~ s/\\ / /g;
                      }
                      else
                      {
                         PrintErrorMessage("unrecognized point symbol",$lc);
                      }
                      if (s/\s*,\s*//) {
                        $defaultLFradius = expr($lc);
                      }
                      chk_rparen("after $cmd arguments",$lc);
                      chk_comment("after $cmd command",$lc);

           }
           elsif (s/^\s*point(?=\W)//i)
           {
              my ($Point_Line);
              chomp($Point_Line=$_);
                   my ($pointStar, $PointName, $origPN);
                   $pointStar = 0; # default value: he have a point command
                   $pointStar = 1 if s/^\*//;
                   chk_lparen("point" . (($pointStar)?"*":""),$lc);
                   if (s/^([^\W\d_](?![^\W\d_])\d{0,4})//i) {
                   #
                   # Note: the regular expression (foo)(?!bar) means that we are
                   # looking a foo not followed by a bar. Moreover, the regular
                   # expression [^\W\d_] means that we are looking for letter.
                   #
                     $origPN = $1;
                     $PointName = lc($1);
                   }
                   else {
                     PrintErrorMessage("Invalid point name",$lc);
                     next LINE;
                   }
                   #if ($pointStar and !exists($PointTable{$PointName})) {
                   #  PrintWarningMessage("Point $origPN has not been defined",$lc);       
                   #}
                   if (!$pointStar and exists($PointTable{$PointName})) {
                      PrintWarningMessage("Point $origPN has been used already",$lc);
                   }
                   chk_rparen("point" . (($pointStar)?"*":""). "($origPN",$lc);
                   chk_lcb("point" . (($pointStar)?"*":""). "($origPN)",$lc);
                   my ($Px, $Py);
                          if (s/^perpendicular(?=\W)//i) {
                                      chk_lparen("perpendicular",$lc);
                                      my $FirstPoint = &get_point($lc);
                                      next LINE if $FirstPoint eq "_undef_";
                                      chk_comma($lc);
                                      my $SecondPoint = &get_point($lc);
                                      next LINE if $SecondPoint eq "_undef_";
                                      my $ThirdPoint = &get_point($lc);
                                      next LINE if $ThirdPoint eq "_undef_";
                                      chk_rparen("No closing parenthesis found",$lc);
                                      my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$FirstPoint});
                                      my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$SecondPoint});
                                      my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$ThirdPoint});
                                      ($Px, $Py) = perpendicular($x1,$y1,$x2,$y2,$x3,$y3);

                          }
                          elsif (s/^intersection(?=\W)//i) {
                                       chk_lparen("intersection",$lc);
                                       my $FirstPoint = get_point($lc);
                                       next LINE if $FirstPoint eq "_undef_";
                                       my $SecondPoint = get_point($lc);
                                       next LINE if $SecondPoint eq "_undef_";
                                       chk_comma($lc);
                                       my $ThirdPoint = get_point($lc);
                                       next LINE if $ThirdPoint eq "_undef_";
                                       my $ForthPoint = get_point($lc);
                                       next LINE if $ForthPoint eq "_undef_";
                                       chk_rparen("No closing parenthesis found",$lc);
                                       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$FirstPoint});
                                       my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$SecondPoint});
                                       my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$ThirdPoint});
                                       my ($x4,$y4,$pSV4,$pS4)=unpack("d3A*",$PointTable{$ForthPoint});
                                       ($Px, $Py) = intersection4points($x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4);


                          }
                          elsif (s/^midpoint(?=\W)//i) {
                                      chk_lparen("midpoint",$lc);
                                      my $FirstPoint = &get_point($lc);
                                      next LINE if $FirstPoint eq "_undef_";
                                      my $SecondPoint = &get_point($lc);
                                      next LINE if $SecondPoint eq "_undef_";
                                      chk_rparen("No closing parenthesis found",$lc);
                                      my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$FirstPoint});
                                      my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$SecondPoint});
                                      ($Px, $Py) = midpoint($x1, $y1, $x2, $y2);

                          }
                          elsif (s/^pointonline(?=\W)//i) {
                                      chk_lparen("pointonline",$lc);
                                      my $FirstPoint = &get_point($lc);
                                      next LINE if $FirstPoint eq "_undef_";
                                      my $SecondPoint = &get_point($lc);
                                      next LINE if $SecondPoint eq "_undef_";
                                      chk_comma($lc);
                                      # now get the distance
                                      my $distance = expr($lc);
                                      chk_rparen("No closing parenthesis found",$lc);
                                      my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$FirstPoint});
                                      my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$SecondPoint});
                                      ($Px, $Py) = pointOnLine($x1,$y1,$x2,$y2,$distance);

                          }
                          elsif (s/^circumcircleCenter(?=\W)//i) {
                                       chk_lparen("circumCircleCenter",$lc);
                                       my $FirstPoint = &get_point($lc);
                                       next LINE if $FirstPoint eq "_undef_";
                                       my $SecondPoint = &get_point($lc);
                                       next LINE if $SecondPoint eq "_undef_";
                                       my $ThirdPoint = &get_point($lc);
                                       next LINE if $ThirdPoint eq "_undef_";
                                       chk_rparen("No closing parenthesis found",$lc);
                                       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$FirstPoint});
                                       my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$SecondPoint});
                                       my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$ThirdPoint});
                                       ($Px, $Py,$r) = &circumCircleCenter($x1,$y1,$x2,$y2,$x3,$y3,$lc);
                                       next LINE if $Px == 0 and $Py == 0 and $r == 0;

                          }
                          elsif (s/^IncircleCenter(?=\W)//i) {
                                       chk_lparen("IncircleCenter",$lc);
                                       my $FirstPoint = &get_point($lc);
                                       next LINE if $FirstPoint eq "_undef_";
                                       my $SecondPoint = &get_point($lc);
                                       next LINE if $SecondPoint eq "_undef_";
                                       my $ThirdPoint = &get_point($lc);
                                       next LINE if $ThirdPoint eq "_undef_";
                                       chk_rparen("No closing parenthesis found",$lc);
                                       my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$FirstPoint});
                                       my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$SecondPoint});
                                       my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$ThirdPoint});
                                       ($Px, $Py, $r) = IncircleCenter($x1,$y1,$x2,$y2,$x3,$y3);

                          }
                          elsif (s/^ExcircleCenter(?=\W)//i) {
                                       chk_lparen("ExcircleCenter",$lc);
                                       my $PointA = get_point($lc);
                                       next LINE if $PointA eq "_undef_";
                                       my $PointB = get_point($lc);
                                       next LINE if $PointB eq "_undef_";
                                       my $PointC = get_point($lc);
                                       next LINE if $PointC eq "_undef_";
                                       chk_comma($lc);
                                       my $PointD = &get_point($lc);
                                       next LINE if $PointD eq "_undef_";
                                       if (!memberOf($PointD, $PointA, $PointB, $PointC)) {
                                         PrintErrorMessage("Current point isn't a side point",$lc);
                                         next LINE;
                                       }
                                       my $PointE = get_point($lc);
                                       next LINE if $PointE eq "_undef_";
                                       if (!memberOf($PointE, $PointA, $PointB, $PointC)) {
                                         PrintErrorMessage("Current point isn't a side point",$lc);
                                         next LINE;
                                       }
                                       if ($PointD eq $PointE) {
                                         PrintErrorMessage("Side points are identical",$lc);
                                         next LINE;
                                       }
                                       ($Px, $Py, $r) = excircle($PointA, $PointB, $PointC,
                                                                  $PointD, $PointE);
                                       chk_rparen("after coordinates part",$lc);

                          }
                          elsif (/^[^\W\d_]\d{0,4}\s*[^,\w]/) {
                            m/^([^\W\d_]\d{0,4})\s*/i;
                            if (exists($PointTable{lc($1)})) {         
                              my $Tcoord = get_point($lc);
                              my ($x,$y,$pSV,$pS)=unpack("d3A*",$PointTable{$Tcoord});
                              $Px = $x;
                              $Py = $y;
                            }
                            else {
                              $Px = expr();
                              chk_comma($lc);
                              $Py = expr();
                            }
                          }
                          elsif (/[^\W\d_]\d{0,4}\s*,\s*shift|polar|rotate|vector/i) { #a point?
                            s/^([^\W\d_]\d{0,4})//i;
                            my $PointA = $1;
                            if (exists($PointTable{lc($PointA)})) {
                              s/\s*//;
                              if (s/^,//) {
                                s/\s*//;
                                if (s/^shift(?=\W)//i) {
                                  
                                            chk_lparen("shift",$lc);
                                            my $dist1 = expr($lc);
                                            chk_comma($lc);
                                            my $dist2 = expr($lc);
                                            my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{lc($PointA)});
                                            $Px = $x1 + $dist1;
                                            $Py = $y1 + $dist2;
                                            chk_rparen("shift part",$lc);

                                }
                                elsif (s/^polar(?=\W)//i) {
                                            chk_lparen("polar",$lc);
                                            my ($R1, $Theta1);
                                            $R1 = expr($lc);
                                            chk_comma($lc);
                                            $Theta1 = expr($lc);
                                            my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{lc($PointA)});
                                            s/\s*//;
                                            if (s/^rad(?=\W)//i) {
                                               # do nothing!
                                            }
                                            elsif (s/^deg(?=\W)//i) {
                                              $Theta1 = $Theta1 * PI / 180;
                                            }
                                            else {
                                              #$Theta1 = $Theta1 * PI / 180; 
                                            }
                                            $Px = $x1 + $R1 * cos($Theta1);
                                            $Py = $y1 + $R1 * sin($Theta1);
                                            chk_rparen("after polar part",$lc);

                                }
                                elsif (s/^rotate(?=\W)//i) {
                                            chk_lparen("rotate",$lc);
                                            my $Q = lc($PointA);
                                            my $P = get_point($lc);
                                            next LINE if $P eq "_undef_";
                                            chk_comma($lc);
                                            my $Theta1 = expr($lc);
                                            my ($xP,$yP,$pSV1,$pS1)=unpack("d3A*",$PointTable{$P});
                                            my ($xQ,$yQ,$pSV2,$pS2)=unpack("d3A*",$PointTable{$Q});
                                            s/\s*//;
                                            if (s/^rad(?=\W)//i)
                                            {
                                               # do nothing!
                                            }
                                            elsif (s/^deg(?=\W)//i)
                                            {
                                                $Theta1 = $Theta1 * PI / 180;
                                            }
                                            else
                                            {
                                                $Theta1 = $Theta1 * PI / 180;
                                            }
                                            # shift origin to P
                                            $xQ -= $xP;
                                            $yQ -= $yP;
                                            # do the rotation
                                            $Px = $xQ * cos($Theta1) - $yQ * sin($Theta1);
                                            $Py = $xQ * sin($Theta1) + $yQ * cos($Theta1);
                                            # return origin back to original origin
                                            $Px += $xP;
                                            $Py += $yP;
                                            chk_rparen("after rotate part",$lc);

                                }
                                elsif (s/^vector(?=\W)//i) {
                                            chk_lparen("vector",$lc);
                                            my ($x0,$y0,$pSV0,$pS0) = unpack("d3A*",$PointTable{lc($PointA)});
                                            my $P = get_point($lc);
                                            my $Q = get_point($lc);
                                            my ($x1,$y1,$pSV1,$pS1) = unpack("d3A*",$PointTable{$P});
                                            my ($x2,$y2,$pSV2,$pS2) = unpack("d3A*",$PointTable{$Q});
                                            $Px = $x0 + $x2 - $x1;
                                            $Py = $y0 + $y2 - $y1;
                                            chk_rparen("vector part",$lc);


                                }
                                else {
                                  PrintErrorMessage("unexpected token",$lc);
                                  next LINE;
                                }
                              }
                              else {
                                my ($xA,$yA,$pSVA,$pSA)=unpack("d3A*",$PointTable{lc($PointA)});
                                $Px = $xA;
                                $Py = $yA;
                              }
                            }
                            else {
                              PrintErrorMessage("Undefined point $PointA",$lc);
                              next LINE;
                            }
                          }
                          else {
                            $Px = expr();
                            chk_comma($lc);
                            $Py = expr();
                          }

                   chk_rcb("coordinates part",$lc);
                   my $sv = $defaultsymbol;
                   my $sh = $defaultLFradius;
                   my $side_or_radius = undef;
                   if (s/^\[\s*//) { # the user has opted to specify the optional part
                                if (/^(symbol|radius|side)\s*/i) {
                                  my @previous_options = ();
                                  my $number_of_options = 1;
                                  my $symbol_set = 0;        
                                  while (s/^(symbol|radius)\s*//i and $number_of_options <= 2) {
                                    my $option = lc($1);
                                    if (s/^=\s*//) {
                                      if (memberOf($option,@previous_options)) {
                                        PrintErrorMessage("Option \"$option\" has been already defined", $lc);
                                        my $dummy = expr($lc);
                                      } 
                                      elsif ($option eq "radius") {
                                        $sh = expr($lc);
                                        $sv = $defaultsymbol if ! $symbol_set;
                                      }
                                      elsif ($option eq "symbol") {
                                        if (s/^circle\s*//i) {
                                          $sv = "circle";
                                          chk_lparen("after token circle",$lc);
                                          $side_or_radius = expr($lc);
                                          chk_rparen("expression",$lc);
                                        }
                                        elsif (s/^square\s*//i) {
                                          $sv = "square";
                                          chk_lparen("after token square",$lc);
                                          $side_or_radius = expr($lc);
                                          chk_rparen("expression",$lc);
                                        }
                                        elsif (s/^(((\\\]){1}|(\\,){1}|(\\\s){1}|[^\],\s])+)//) {
                                          $sv = $1;
                                          $sv =~ s/\\\]/\]/g;
                                          $sv =~ s/\\,/,/g;
                                          $sv =~ s/\\ / /g;
                                          s/\s*//;
                                        }
                                        $symbol_set = 1;
                                      }
                                    }
                                    else {
                                      PrintErrorMessage("unexpected token", $lc);
                                      next LINE;
                                    }
                                    $number_of_options++;
                                    push (@previous_options, $option);
                                    s/^,\s*//;
                                  }
                                }
                                else {
                                  PrintErrorMessage("unexpected token", $lc);
                                  next LINE;
                                }

                      chk_rsb("optional part",$lc);
                   }
                   # to avoid truncation problems introduced by the pack function, we
                   # round each number up to five decimal digits
                   $Px = sprintf("%.5f", $Px);
                   $Py = sprintf("%.5f", $Py);
                   print OUT "%% point$Point_Line \t$origPN = ($Px, $Py)\n" if $comments_on;
                   chk_comment($lc);
                   $PointTable{$PointName} = pack("d3A*",$Px,$Py,$sh,$sv);
                   if (defined($side_or_radius)) {
                     $DimOfPoint{$PointName} = $side_or_radius;
                   } 

           }
           elsif (/^\s*setPointNumber(?=\W)/i)
           {
              PrintWarningMessage("Command setPointNumber is ignored",$lc);
              next LINE;
           }
           elsif (s/^\s*(showAngle(?=\W))//i)
           {
                     chk_lparen("showangle",$lc);
                     my $point_1 = get_point($lc);
                     my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_1});
                     my $point_2 = get_point($lc);
                     my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point_2});
                     my $point_3 = get_point($lc);
                     my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point_3});
                     my $angle = Angle($x1, $y1, $x2, $y2, $x3, $y3);
                     $angle = 0 if $angle == -500;
                     printf OUT "%%%% angle(%s%s%s) = %.5f deg ( %.5f rad)\n", $point_1,
                            $point_2, $point_3, $angle, $angle*D2R;
                     chk_rparen("Missing right parenthesis", $lc);

           }
           elsif (s/^\s*(showArea(?=\W))//i)
           {
                     chk_lparen("showarea",$lc);
                     my $point_1 = get_point($lc);
                     my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_1});
                     my $point_2 = get_point($lc);
                     my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point_2});
                     my $point_3 = get_point($lc);
                     my ($x3,$y3,$pSV3,$pS3)=unpack("d3A*",$PointTable{$point_3});
                     print OUT "%% area($point_1$point_2$point_3) = ",
                           triangleArea($x1, $y1, $x2, $y2, $x3, $y3), "\n";
                     chk_rparen("Missing right parenthesis", $lc);

           }
           elsif (s/^\s*(showLength(?=\W))//i)
           {
                     chk_lparen("showlength",$lc);
                     my $point_1 = get_point($lc);
                     my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{$point_1});
                     my $point_2 = get_point($lc);
                     my ($x2,$y2,$pSV2,$pS2)=unpack("d3A*",$PointTable{$point_2});
                     print OUT "%% length($point_1$point_2) = ",
                           Length($x1, $y1, $x2, $y2), "\n";
                     chk_rparen("Missing right parenthesis", $lc);


           }
           elsif (/^\s*showPoints(?=\W)/i)
           {
              print OUT "%%-------------------------------------------------\n";
              print OUT "%%            L I S T  O F  P O I N T S            \n";
              print OUT "%%-------------------------------------------------\n";
              foreach my $p (keys(%PointTable)) {
                my ($x, $y, $pSV, $pS) = unpack("d3A*",$PointTable{$p});
                printf OUT "%%%%\t%s\t= ( %.5f, %.5f ), LF-radius = %.5f, symbol = %s\n",
                        $p, $x, $y, $pSV, $pS;
              }
              print OUT "%%-------------------------------------------------\n";
              print OUT "%%      E N D  O F  L I S T  O F  P O I N T S      \n";
              print OUT "%%-------------------------------------------------\n";
              next LINE;
           }
           elsif (/^\s*showVariables(?=\W)/i)
           {
              print OUT "%%-------------------------------------------------\n";
              print OUT "%%       L I S T  O F  V A R I A B L E S           \n";
              print OUT "%%-------------------------------------------------\n";
              foreach my $var (keys(%VarTable)) {
                print OUT "%%\t", $var, "\t=\t", $VarTable{$var}, "\n";
              }
              print OUT "%%-------------------------------------------------\n";
              print OUT "%%   E N D  O F  L I S T  O F  V A R I A B L E S   \n";
              print OUT "%%-------------------------------------------------\n";
              next LINE;
           }
           elsif (s/^\s*(system(?=\W))//i)
           {
              print OUT "%% $1$_" if $comments_on;
              
                   chk_lparen("$cmd",$lc);
                   my ($error, $command, $rest) = get_string($_);
                   next LINE if $error == 1;
                   $_ = $rest;
                   if (! is_tainted($command)) {
                      system($command);
                   }
                   else {
                      PrintErrorMessage("String \"$command\" has tainted data", $lc);
                      next LINE;
                   }
                   chk_rparen("after $cmd arguments",$lc);
                   chk_comment("after $cmd command",$lc);

           }
           elsif (s/^\s*(text(?=\W))//i)
           {
              print OUT "%% $1$_" if $comments_on;
              
                      chk_lparen("text",$lc);
                      my ($level,$text)=(1,"");
                      TEXTLOOP: while (1)
                      {
                        $level++ if /^\(/;
                        $level-- if /^\)/;
                        s/^(.)//;
                        last TEXTLOOP if $level==0;
                        $text .= $1;
                      }
                      chk_lcb("text part",$lc);
                      my ($Px, $Py,$dummy,$pos);
                      $pos="";
                      s/\s*//;
                      
                        if (/^[^\W\d_]\d{0,4}\s*[^,\w]/) {
                          my $Tcoord = get_point($lc);
                          my ($x,$y,$pSV,$pS)=unpack("d3A*",$PointTable{$Tcoord});
                          $Px = $x;
                          $Py = $y;
                        }
                        elsif (/[^\W\d_]\d{0,4}\s*,\s*shift|polar/i) {
                          s/^([^\W\d_]\d{0,4})//i;
                          my $PointA = $1;
                          if (exists($PointTable{lc($PointA)})) {
                            s/\s*//;
                            if (s/^,//) {
                              s/\s*//;
                              if (s/^shift(?=\W)//i) {
                                
                                          chk_lparen("shift",$lc);
                                          my $dist1 = expr($lc);
                                          chk_comma($lc);
                                          my $dist2 = expr($lc);
                                          my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{lc($PointA)});
                                          $Px = $x1 + $dist1;
                                          $Py = $y1 + $dist2;
                                          chk_rparen("shift part",$lc);

                              }
                              elsif (s/^polar(?=\W)//i) {
                                          chk_lparen("polar",$lc);
                                          my ($R1, $Theta1);
                                          $R1 = expr($lc);
                                          chk_comma($lc);
                                          $Theta1 = expr($lc);
                                          my ($x1,$y1,$pSV1,$pS1)=unpack("d3A*",$PointTable{lc($PointA)});
                                          s/\s*//;
                                          if (s/^rad(?=\W)//i) {
                                             # do nothing!
                                          }
                                          elsif (s/^deg(?=\W)//i) {
                                            $Theta1 = $Theta1 * PI / 180;
                                          }
                                          else {
                                            #$Theta1 = $Theta1 * PI / 180; 
                                          }
                                          $Px = $x1 + $R1 * cos($Theta1);
                                          $Py = $y1 + $R1 * sin($Theta1);
                                          chk_rparen("after polar part",$lc);

                              }
                            }
                          }
                          else {
                            PrintErrorMessage("undefined point/var",$lc);
                            next LINE;
                          }
                        }
                        else {
                          $Px = expr();
                          chk_comma($lc);
                          $Py = expr();
                        }

                      chk_rcb("coordinates part of text command",$lc);
                      if (s/^\[//)
                      {
                        s/\s*//;
                        
                          if (s/^(\w{1})\s*//) {
                            $pos .= $1;
                            if (memberOf($pos, "l", "r")) {
                              if (s/^(\w{1})\s*//) {
                                my $np = $1;
                                if (memberOf($np, "t", "b", "B")) {
                                  $pos .= $np;
                                }
                                else {
                                  if (memberOf($np, "l", "r")) {
                                     PrintErrorMessage("$np can't follow 'l' or 'r'", $lc);
                                  }
                                  else {
                                    PrintErrorMessage("$np is not a valid positioning option", $lc);
                                  }
                                  next LINE;
                                }
                              }
                            }
                            elsif (memberOf($pos, "t", "b", "B")) {
                              if (s/^(\w{1})\s*//) {
                                my $np = $1;
                                if (memberOf($np, "l", "r")) {
                                  $pos .= $np;
                                }
                                else {
                                  if (memberOf($np, "t", "b", "B")) {
                                     PrintErrorMessage("$np can't follow 't', 'b', or 'B'", $lc);
                                  }
                                  else {
                                    PrintErrorMessage("$np is not a valid positioning option", $lc);
                                  }
                                  next LINE;
                                }
                              }
                            }
                            else {
                              PrintErrorMessage("$pos is not a valid positioning option", $lc);
                              next LINE;
                            }
                          }
                          else {
                            PrintErrorMessage("illegal token in optional part of text command",$lc);
                            next LINE;
                          }

                        s/\s*//;
                        chk_rsb("optional part of text command",$lc);
                      }
                      chk_comment($lc);
                      if ($pos eq "")
                      {
                         printf OUT "\\put {%s} at %f %f\n", $text, $Px, $Py;
                      }
                      else
                      {
                         printf OUT "\\put {%s} [%s] at %f %f\n", $text, $pos, $Px, $Py;
                      }

           }
           elsif (s/^\s*(var(?=\W))//i)
           {
              print OUT "%% $1$_" if $comments_on;
                  do{
                    s/\s*//;
                    PrintErrorMessage("no identifier found after token var",$lc)
                      if $_ !~ s/^([^\W\d_]\d{0,4})//i;
                    my $Varname = $1;
                    my $varname = lc($Varname);
                    if (exists $ConstTable{$varname}) {
                      PrintErrorMessage("Redefinition of constant $varname",$lc);
                    }
                    s/\s*//; #remove leading white space
                    PrintErrorMessage("did not find expected = sign",$lc)
                      if $_ !~ s/^[=]//i;
                    my $val = expr($lc);
                    $VarTable{$varname} = $val;
                    print OUT "%% $Varname = $val\n" if $comments_on;
                  }while (s/^,//);
                  chk_comment($lc);
                  s/\s*//;
                  if (/^[^%]/) {
                    PrintWarningMessage("Trailing text is ignored",$lc);
                  }
           }
           elsif (/^\s*\\(.+)/)
           {
              my $line = $1;
              if ($line =~ /^\s+(.+)/)
              {
                 print OUT " $line\n";
              }
              else
              {
                print OUT "\\$line\n";
              }
              next LINE;
           }
           elsif (0==length) #empty line
           {
              next LINE;
           }
           else {
             PrintErrorMessage("command not recognized",$lc);
             next LINE;
           }

       }
     }
   }


our $alarm="";
our $comments_on=1;
our $out_file="default";
our $argc=@ARGV;
if ($argc == 0 || $argc > 5 ){ # no command line arguments or more than 4
                               # arguments
  die "\nmathspic version $version_number\n" .
      "Usage: mathspic [-h] [-b] [-c] [-o <out file>] <in file>\n\n";
}
else {
     our $file = "";
     SWITCHES:
     while($_ = $ARGV[0]) {
       shift;     
       if (/^-h$/) {
         die "\nThis is mathspic version $version_number\n" .
             "Type \"man mathspic\" for detailed help\n".
             "Usage:\tmathspic  [-h] [-b] [-c] [-o <out file>] <in file>\n" . 
             "\twhere,\n" . 
             "\t[-b]\tenables bell sound if error exists\n" .
             "\t[-c]\tdisables comments in output file\n" .
             "\t[-h]\tgives this help listing\n" .
             "\t[-o]\tcreates specified output file\n\n"; 
       }
       elsif (/^-b$/) {
         $alarm = chr(7);
       }
       elsif (/^-c$/) {
         $comments_on = 0;
       }
       elsif (/^-o$/) {
         die "No output file specified!\n" if !@ARGV;
         $out_file = $ARGV[0];
         shift;
       }
       elsif (/^-\w+/) {
         die "$_: Illegal command line switch!\n";
       }
       else {
         $file = $_;
       }
     }my ($xA, $yA, $xB, $yB, $dist)=@_;
     die "No input file specified!\n" if $file eq "";

  print "This is mathspic version $version_number\n";
}
   our ($source_file, $log_file);
   if (! -e $file) {
      die "$file: no such file!\n" if (! (-e "$file.m"));
      $source_file = "$file.m";
   }
   else {
      $source_file = $file;
      $file = $1 if $file =~ /(\w[\w-\.]+)\.\w+/;
   }
   $out_file= "$file.mt" if $out_file eq "default";
   $log_file= "$file.mlg";


  open(IN,"$source_file")||die "Can't open source file: $source_file\n";
  open(OUT,">$out_file")||die "Can't open output file: $out_file\n";
  open(LOG,">$log_file")||die "Can't open log file: $log_file\n";
  print_headers;
  process_input(IN,"");

print $alarm if $no_errors > 0;
__END__

