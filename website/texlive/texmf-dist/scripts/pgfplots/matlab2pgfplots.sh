#!/bin/sh


CONVERT_STYLES=1
CONVERT_AXES=1
OUTFILE=""
MAXPOINTS=100000

echoHelp()
{
	echo "matlab2pgfplots.sh [--maxpoints N]  [--styles [0|1] ]   [ --axes [0|1] ]  [ -o OUTFILE ]  INFILE ..."
	echo "converts Matlab figures (.fig-files) to pgfplots-files (.pgf-files)."
	echo "This script is a front-end for matlab2pgfplots.m (which needs to be in matlab's search path)"
	echo "type"
	echo " >> help matlab2pgfplots"
	echo "at your matlab prompt for more information."
	exit 0
}

LONGOPTS="styles:,axes:,help,maxpoints:"
SHORTOPTS="o:"
ARGS=`getopt -l "$LONGOPTS" "$SHORTOPTS" "$@"`
if [ $? -ne 0 ]; then
	echo "`basename $0`: Could not process command line arguments. Use the '--help' option for documentation."
	exit 1
fi

eval set -- "$ARGS"
while [ $# -gt 0 ]; do
	ARG=$1
	# echo "PROCESSING OPTION '$ARG' (next = $@)"
	case "$ARG" in
		--maxpoints)	shift; MAXPOINTS=$1; shift;;
		--styles)		shift; CONVERT_STYLES="$1"; shift;;
		--axes)			shift; CONVERT_AXES="$1"; shift;;
		-o)				shift; OUTFILE="$1"; shift;;
		--help)			shift; echoHelp;;
		--)				shift; break;;
		*)				break;
	esac
done

if [ $# -eq 0 ]; then
	echo "No input files specified."
	exit 1
fi

HAS_OUTFILE=0
if [ $# -gt 1 -a -n "$OUTFILE" ]; then
	HAS_OUTFILE=1
fi

for A; do
	INFILE="$A"
	if [ $HAS_OUTFILE -eq 0 ]; then
		OUTFILE="${INFILE%%.*}.pgf"
	fi
	echo "$INFILE -> $OUTFILE ... "

	M_LOGFILE=`mktemp`
	matlab -nojvm -nodesktop -nosplash 1>/dev/null 2>&1 -logfile $M_LOGFILE  <<-EOF
		f=hgload( '$INFILE' );
		matlab2pgfplots( '$OUTFILE', 'fig', f, 'styles', $CONVERT_STYLES, 'axes', $CONVERT_AXES, 'maxpoints', $MAXPOINTS );
		exit
	EOF
	grep -q "Error" $M_LOGFILE
	CODE=$?
	if [ $CODE -eq 0 ]; then
		echo "Matlab output:" 1>&2
		cat $M_LOGFILE  1>&2
		CODE=1
	else
		CODE=0
	fi
	rm -f $M_LOGFILE
	if [ $CODE -ne 0 ]; then
		exit $CODE
	fi
done
