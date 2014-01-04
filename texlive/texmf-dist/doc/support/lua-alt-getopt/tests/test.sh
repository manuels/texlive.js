#!/bin/sh

runtest (){
    printf '=================================================================\n'
    printf '======= args: %s\n' "$*"
    "$@" 2>&1 | awk '/stack traceback:/, /\[C\]: [?]/ {next} {print}'
}

do_test_getopt (){
    runtest ../alt_getopt -h -
    runtest ../alt_getopt --help
    runtest ../alt_getopt -h --help -v --verbose -V -o 123 -o234
    runtest ../alt_getopt --output 123 --output 234 -n 999 -n9999 --len 5 --fake /dev/null
    runtest ../alt_getopt -hVv -- -1 -2 -3
    runtest ../alt_getopt --fake -v -- -1 -2 -3
    runtest ../alt_getopt - -1 -2 -3
    runtest ../alt_getopt --fake -v - -1 -2 -3
    runtest ../alt_getopt -1 -2 -3
    runtest ../alt_getopt -hvV
    runtest ../alt_getopt -ho 123
    runtest ../alt_getopt -hoV 123
    runtest ../alt_getopt --unknown
    runtest ../alt_getopt --output='file.out' -nNNN --len=LENGTH
    runtest ../alt_getopt --output --file--

    runtest ../alt_getopt --output
    runtest ../alt_getopt -ho
    runtest ../alt_getopt --help -o
    runtest ../alt_getopt --help=value
    runtest ../alt_getopt -ofile1 --set_value 111 --output file2 \
	--set-output=file3

    true
}

do_test (){
    do_test_getopt
}

OBJDIR=${OBJDIR:=.}

do_test > $OBJDIR/_test.res 2>&1

if ! diff -u test.out $OBJDIR/_test.res; then
    echo "rewrite fails" 1>&2
    exit 1
fi

