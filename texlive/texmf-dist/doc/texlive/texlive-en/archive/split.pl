#@TeXIndex{a0poster,
open TMP, ">/dev/null";
while (<>) {
       chop;
    if (/\@TeXIndex/) {
	print TMP "\n";
       close TMP;
	$keep=$_;
	s/\@TeXIndex{(.*),.*/$1/;
	print "[$_]\n";	   
       open TMP, ">$_.bib";
     print TMP "$keep\n";
    }
       else { print TMP "$_\n" ; }

}
