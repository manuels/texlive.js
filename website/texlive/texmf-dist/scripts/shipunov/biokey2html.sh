#!/bin/bash

export PATH=.:{$PATH}
biokey2html1.pl $1 > $12 
biokey2html2.pl $12 > /tmp/$1.$$ 
biokey2html3.pl /tmp/$1.$$ > $1.html

#
