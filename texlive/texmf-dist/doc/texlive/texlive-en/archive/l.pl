require "status.pl";
require "texlive.pl";
while (<>) {
    chop;
    s/,$//;
 if (/^\@TeXIndex/)
 { 
   ($nam) = /^\@TeXIndex.(.*)/;
   print "\@TeXIndex\{$nam";
   $Status=1;
   $Texlive=1;
   $Modified=0;
   }
 elsif (/^ *modified/) { s/, *$//; $mod=$_; }
 elsif (/^ *status/) { $Status=0; 
     if ($L{$nam}) 
	    { print ",\n  status\t= \{$L{$nam}\}"; 
	      $Modified=1;} 
	else {	       print ",\n$_"; }
		   }
 elsif (/^ *texlive/) { $Texlive=0; 
     if ($texlive{$nam} ne "") 
	    { print ",\n  texlive\t= \{$texlive{$nam}\}"; 
	      $Modified=1;} 
		   }
 elsif (/^}/) {  
     if ($Status) {
           print ",\n  status\t= \{unknown\}"; 
      }
     if ($Texlive && $texlive{$nam} ne "")
       { print ",\n  texlive\t= \{$texlive{$nam}\},\n"; }
     if ($Modified) 
        { print ",\n  modified\t= {1999/03/26 10:00:00 <s.rahtz\@elsevier.co.uk>}\n"; }
     elsif ($M{$nam} ne "")
        { print ",\n  modified\t= \{$M{$nam}\}\n"; }
     else
        {print ",\n$mod\n"; }
     print "}\n";
 }

 elsif (/= {/)  { print ",\n$_"; }
 else  { print "\n$_"; }
    }

