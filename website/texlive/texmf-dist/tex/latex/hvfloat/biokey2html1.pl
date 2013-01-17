#!/usr/bin/perl -w

$/="";

print STDERR "Making relative LaTeX key... \n";

&ochki();

print "\n";
while(<>){
	s/\\Z(\d+)\./\\TEZA{$ochki[$1-1]}/g;
	s/\\T+?\s*(\d+)\./\\SSYLKA{$ochki[$1-1]}/sg;
	s/\\ZZ(\d+)\((\d+)\)\./\\STEZA{$ochki[$1-1]}{$ochki[$2-1]}/g;
	print;
}

# fill array to links
sub ochki { 
$B0 = $B1 = $nom = "";
@ochki = ();
	for ($x = 0; $x < 26; $x++) {
		for ($y = 0; $y < 26; $y++) {
			$B0 = chr($y + 65);
			$B1 = chr($x + 65);
			$nom = "$B1$B0";
			@ochki = (@ochki, $nom)
		}
	}
}
#