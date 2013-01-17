#!/usr/bin/perl -w
$/ = "";

use File::Basename;

$kl = $ARGV[0]; 
if ($kl && ($kl =~ /-h|-\?/)) {&message(); exit(1);}

$file = @ARGV;
if ($file < 1) {&message(); exit(1);} 

$a = $ARGV[0];
open(VCHOD, "$a") || die "Sorry, I cannot open $a: $!\n";

print STDERR "Making reference tags... \n";

&hesh_stup(); 

while(<VCHOD>){

	&format1();
	&name_href();
	&format2();
	print;
}

sub hesh_stup {
	$schet_stup = 0;
	while(<VCHOD>){
		if (/\\TEZA{(\w\w)}/) {$schet_stup++; $stup{"$1"} = "$schet_stup";}
		if (/\\STEZA{(\w\w)}{(\w\w)}/) {$schet_stup++; $stup{"$1"} = "$schet_stup";}
	}
	seek (VCHOD, 0, 0);
}

END {
	close (VCHOD);
}

sub format1 {
	s@<!--(.*)-->@$1@g;
	s@(\\TEZA{\w\w})@<span class="TEZA">$1\.</span>@gi;
	s@(\\STEZA{\w\w}{\w\w})@<span class="STEZA">$1\.</span>@gi;
	s@(\\SSYLKA{\w\w})@ ... <span class="SSYLKA">$1\.</span>@gi;
}

sub name_href {
	s@\\TEZA{(\w\w)}@<a name=\"$1\">$stup{$1}<\/a>@g;
	s@\\STEZA{(\w\w)}{(\w\w)}@<a name=\"$1\">$stup{$1}<\/a>\(<a href=\"#$2\">$stup{$2}<\/a>\)@g;
	s@\\SSYLKA{(\w\w)}@<a href=\"#$1\">$stup{$1}<\/a>@g;
}

sub format2 {
	s@\\documentclass.*@@gi;
	s@\\usepackage.*@@gi;
	s@\\begin.*@@gi;
	s@\\end.*@@gi;
	s@<p>%@@gi;
	s@\\i *{}@i@gsi;
	s@\$\\times\$@&times\;@gi;
	s@\\#@-@gi;
	s@\\<|<<@&laquo\;@g;
	s@\\>|>>@&raquo\;@g;
	s@~@&nbsp\;@gi;
	s@---|\\---@&mdash;@gi;
	s@(\\T+?)(.*?)\n\n@ ... 
		<!--<a href="">--><span class="SP">$2</span><!--</a>-->\n\n@gsi;
	s@\\KN (.+?) @<em>$1</em> @gsi;
	s@\\NN (.+?) (.+?) @<em>$1 $2</em> @gsi;
	s@\\K *{(.+?)}@<em>$1</em>@gsi;
	s@\\J *{(.+?)}@<strong>$1</strong>@gsi;
	s@\\textit *{(.+?)}@<em>$1</em>@gsi;
	s@\\textbf *{(.+?)}@<strong>$1</strong>@gsi;
	s@<p>\\FK@<p class="FK">@sgi;
	s@<p>@<p class="ST">@sgi;
	s@\\AN@&ndash;@gi;
	s@\\AAN|\\AAAN@=@gi;
	s@  +?@ @sgi;
	s@\\'@@sgi;
	s@\\i{}@@sgi;
}

sub message {
$Me = basename($0);
print <<END_OF_MESSAGE
USAGE: $Me [-h|-?] File1 [>File2]
END_OF_MESSAGE
}
#