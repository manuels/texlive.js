#!/bin/bash
#
# ATTENTION: this file is more or less deprecated.
# Please take a look at the 'external' library which has been added to pgf.
# At the time of this writing, this library is only available for pgf cvs (newer than 2.00).

TEX_FILE=""
TEX_LOG_FILE=""

TEX_DEFINES=""

OLD_DIR=`pwd`

DRIVER="pdftex"

ALSO_EPS_OUTPUT=0
WARN_ONLY_IF_TEXFILE_DOESNOT_INCLUDE_TARGET=0
VERBOSE_LEVEL=0

function dumpHelp() {
	echo -e \
		"`basename $0` [OPTIONS] [--texdefs <defsfile> | --mainfile <latexmainfile>.tex ]  [plot1.pgf plot2.pgf .... plotn.pgf]\n"\
		"converts each plot*.pgf to plot*.pdf.\n"\
		"This is done by running \n"\
		"  latex --jobname plot1 latexmainfile\n"\
		"for each single plot. See the pgfmanual section \"Externalizing graphics\".\n"\
		"Options:\n"\
		"--eps\n"\
		"    will also produce eps output files.\n"\
		"--driver D\n"\
		"    will use either \"dvipdfm\", \"dvips\" or \"pdflatex\"\n"\
		"    please note that only pdflatex works without additional\n"\
		"    work.\n"\
		"--mainfile FILE\n"\
		"    A tex-file which has been configured for externalized graphics.\n"\
		"    Two conditions must be met to perform the conversion of\n"\
		"      \"plot.pgf\"  -> \"plot.pdf\":\n"\
		"    1. FILE needs the command\n"\
		"         \pgfrealjobname{FILE}\n"\
		"       (see the pgf manual for details)\n"\
		"    2. It needs to include \"plot.pgf\" somewhere (using \input{plot.pgf})\n"\
		"\n"\
		"--warnonly\n"\
		"    Use this flag if the argument of --mainfile does not contain\n"\
		"      \input{TARGET.pgf},\n"\
		"    i.e. if (2.) is not fulfilled. In this case, the conversion for this\n"\
		"    input file will be skipped.\n"\
		"\n"\
		"--texdefs FILE\n"\
		"    Generates a temporary tex-file\n"\
		"    \documentclass{article}\n"\
		"    \input{FILE}\n"\
		"    \begin{document}\n"\
		"    \input{plot1.pgf}\n"\
		"    \end{document}\n"\
		"    and converts this one to pdf.\n"\
		"    If FILE is '-', the input step is omitted.\n"
		"-v\n"\
		"    each -v option increases the verbosity.\n"\
		""
	exit 0;
}


LONGOPTS="mainfile:,eps,driver:,texdefs:,warnonly,help"
SHORTOPTS="f:t:v"
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
		--texdefs|-t)	shift; TEX_DEFINES="$1"; shift;;
		--driver)		shift; DRIVER="$1"; shift;;
		--mainfile|-f)	shift; TEX_FILE="$1"; TEX_LOG_FILE="${1%%.tex}.log"; shift;;
		--eps)			shift; ALSO_EPS_OUTPUT=1;;
		--warnonly)		shift; WARN_ONLY_IF_TEXFILE_DOESNOT_INCLUDE_TARGET=1;;
		-v)				shift; VERBOSE_LEVEL=$((VERBOSE_LEVEL+1));;
		--)				shift; break;;
		--help)			dumpHelp;;
		*)				break;
	esac
done
if [ -n "${TEX_DEFINES}" ]; then
	if [ "${TEX_DEFINES:0:1}" != "/" ]; then
		TEX_DEFINES=`pwd`/${TEX_DEFINES}
	fi
fi


if [ $# -ne 0 ]; then
	PGF_FILES=("$@")
elif [ -n "${TEX_LOG_FILE}" ]; then
	# search for lines with
	#  (XXXX.pgf
	PGF_FILES=(`sed -n '{s/.*(\([a-zA-Z0-9._-+^~]\+\.pgf\).*/\1/g;T ende;p};: ende' < $TEX_LOG_FILE`)
	#PGF_FILES=(./errplot_L2.pgf)
else
	echo "No input files." 1>&2
	exit 1
fi

for A in "${PGF_FILES[@]}"; do
	if [ ! -f "$A" ]; then
		echo "$A not found: no such file" 1>&2
		exit 1
	fi

	CONTINUE_ON_ERROR=0
		
	TARGET_FILE=$(sed -n '{s/.*\\beginpgfgraphicnamed{\(.*\)}.*/\1/g;T ende;p};: ende' < "$A")
	if [ $? -ne 0 -o -z "$TARGET_FILE" ]; then
		echo "There is no valid \\beginpgfgraphicnamed{TARGET}...\\endpgfgraphicnamed command in $A. Can't be exported to pdf. Please see the PGF manual for details." 1>&2
		exit 1
	fi
	echo "processing \"$A\"" 1>&2

	CMD="latex"
	case $DRIVER in
		pdftex|pdflatex)
			CMD="pdflatex"
			;;
	esac

	if [ -z "${TEX_DEFINES}" ]; then
		# LaTeX cannot write into a \jobname in another directory.
		# But the TEX_FILE and $A may not necessarily be in the same directory!
		#
		# So, we have to build a work-around which simulates a \jobname in the directory of TEX_FILE
		# which does not fool \beginpgfgraphicnamed
		
		# modify the input file A:
		ORIGINAL_FILE="$A.orig"
		mv "$A" "$ORIGINAL_FILE" || exit 1
		cat - "$ORIGINAL_FILE" >"$A" <<-EOF
			\let\tmpXXXXXZEUGoldjobname=\jobname
			\def\jobname{${TARGET_FILE}}%
			\message{PGF2PDF: TEX HAS ENTERED THE TARGET FILE...}%
		EOF
		cat >> "$A" <<-EOF
			\let\jobname=\tmpXXXXXZEUGoldjobname
		EOF

		cd `dirname "${TEX_FILE}"`

		# generate a temp \jobname in the current directory:
		TMP_JOB_FILE=`mktemp ./tmppgf2pdfXXXXXX`
		if [ $? -ne 0 ]; then exit 1; fi
		rm -f "$TMP_JOB_FILE"

		$CMD --interaction nonstopmode --jobname "$TMP_JOB_FILE" "${TEX_FILE}" 1>/dev/null
		CODE=$?
		
		INTERM_EXTENSION="dvi"
		case $DRIVER in
			pdftex|pdflatex)
				INTERM_EXTENSION="pdf"
				;;
			dvipdfm)
				INTERM_EXTENSION="dvi"
				;;
			dvips)
				INTERM_EXTENSION="dvi"
				;;
		esac
		if [ ! -s "$TMP_JOB_FILE.$INTERM_EXTENSION" ]; then
			if [ $VERBOSE_LEVEL -ge 1 ]; then
				if [ $WARN_ONLY_IF_TEXFILE_DOESNOT_INCLUDE_TARGET -eq 1 ]; then
					echo -n "WARNING: ";
				else
					echo -n "ERROR: ";
				fi
				echo -e "running\n"\
					"  '$CMD --jobname $TMP_JOB_FILE $TEX_FILE'\n"\
					"resulted in a zero-size file \"$TMP_JOB_FILE.$INTERM_EXTENSION\"!\n"\
					"Please check\n"\
					"- if $TEX_FILE contains\n"\
					"    \pgfrealjobname{`basename ${TEX_FILE%%.tex}`}\n"\
					"- if $TEX_FILE contains\n"\
					"    \input{$A}\n"\
					"\n"\
					"You may take a look at\n\t$TARGET_FILE.log\n for more information.\n"\
					"Maybe `basename $0` --texdefs is more appropriate for this application?\n"\
					"It doesn't need \input{}...\n"\
					1>&2
			fi

			CODE=1
			if [ $WARN_ONLY_IF_TEXFILE_DOESNOT_INCLUDE_TARGET -eq 1 ]; then
				CONTINUE_ON_ERROR=1
			fi
			rm -f $TMP_JOB_FILE.{$INTERM_EXTENSION,pdf}
		fi


		# FIXME: this here may clash if A and TARGET_FILE have inconsistent paths!
		mv "$ORIGINAL_FILE" "$A" || exit 1
		for QQ in $TMP_JOB_FILE.*; do
			if [ "$TARGET_FILE.${QQ##*.}" != "$A" ]; then
				mv "$QQ" "$TARGET_FILE.${QQ##*.}" || exit 1
			fi
		done

		cd "$OLD_DIR"
	else
		# Die Idee hier ist wie folgt:
		# - Erstelle ein fast leeres Tex-File
		# - darin steht NUR 
		# 	\input $TEX_DEFINES
		#   und 
		#   \input $A
		# - das TeX-file wird mit pgflatex uebersetzt
		# - die ausgabe wird nach $TARGET_FILE geschrieben
		# - fertig.
		#
		# BUGS:
		# - TARGET_FILE != A wird nicht funktionieren (nur die endungen natuerlich)
		DRIVER="pdftex"
		cd `dirname "$A"`
		BASE=`basename $TARGET_FILE`
		TMP_TEX_FILE=`mktemp tmp_${BASE}_XXXXXX`
		mv "$TMP_TEX_FILE" "${TMP_TEX_FILE}.tex"
		TMP_TEX_FILE="$TMP_TEX_FILE.tex"
		rm -f "${BASE}.pdf"

		cat >"$TMP_TEX_FILE" <<-EOF
		\documentclass{report}

		\input{${TEX_DEFINES}}

		%\def\pgfsysdriver{pgfsys-dvipdfm.def}
		%\def\pgfsysdriver{pgfsys-pdftex.def}
		\usepackage{tikz}
		\pgfrealjobname{${TMP_TEX_FILE%%.tex}}
		\begin{document}
		\let\oldjobname=\jobname%
		% make sure that PGF recognises that jobname==target file name
		% even if --jobname has a different path.
		\def\jobname{${TARGET_FILE}}%
		\input{`basename $A`}%
		\let\jobname=\oldjobname
		\end{document}
		EOF
		$CMD --interaction nonstopmode --jobname "$BASE" "${TMP_TEX_FILE}" 1>/dev/null
		CODE=$?
		if [ $CODE -eq 0 ]; then
			rm -f "$TMP_TEX_FILE"
		fi
		cd $OLD_DIR
	fi

	if [ $CODE -ne 0 ]; then
		rm -f "${TARGET_FILE}.pdf"
		if [ $CONTINUE_ON_ERROR -eq 1 ]; then
			echo "WARNING: $A SKIPPED [use -v for messages]." 1>&2
			CODE=0
			continue
		else
			echo -e "FAILED: could not convert\n\t$A\n->\t$TARGET_FILE.pdf" 1>&2;
			exit 1;
		fi
	fi
	CMD=""
	case $DRIVER in
		dvipdfm)
			dvipdfm -o ${TARGET_FILE}.pdf "${TARGET_FILE}.dvi" || exit 1
			pdfcrop "${TARGET_FILE}.pdf" "${TARGET_FILE}.pdf" || exit 1
			;;
		dvips)
			dvipdfm -o ${TARGET_FILE}.ps "${TARGET_FILE}.dvi" || exit 1
			;;
	esac

	if [ $ALSO_EPS_OUTPUT -eq 1 ]; then
		pdftops -f 1 -l 1 -eps "${TARGET_FILE}.pdf" "${TARGET_FILE}.eps" 
		if [ $? -ne 0 ]; then
			echo "Conversion pdf -> eps FAILED!" 1>&2 
			exit 1
		fi
	fi
done
cd $OLD_DIR
