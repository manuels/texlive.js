#!/usr/bin/perl -w

print STDERR "Making HTML title and paragrafs tags... \n";

while(<>){
	s@^\s+?$@\n<p>@g;
print;
}

BEGIN {
print <<END_OF_BEGIN
<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">
<html>
<head>
	\t<meta http-equiv=\"Content-Type\" content=\"text/html\">
	\t<link type="text/css" rel="stylesheet" href="ws_key.css">
</head>
<body>

END_OF_BEGIN
}

END{
print <<END_OF_END

</body>
</html>
END_OF_END
}

#