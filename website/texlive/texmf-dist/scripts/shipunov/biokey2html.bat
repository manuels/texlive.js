@echo off
perl -w biokey2html1.pl %1 > %12 
perl -w biokey2html2.pl %12 > %1.tmp 
perl -w biokey2html3.pl %1.tmp > %1.html
if exist %1.tmp del %1.tmp