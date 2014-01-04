#!/bin/sh
# fmtutil - utility to maintain format files.
# Public domain.  Originally written by Thomas Esser.
# Run with --help for usage.

# program history:
#   further changes in texk/tetex/ChangeLog.
#   2007-01-04  patch by JK to support $engine subdir (enabled by default)
#   Fr Apr  8 19:15:05 CEST 2005 cleanup now has an argument for the return code
#   Do Mar 02 10:42:31 CET 2006 add tmpdir to TEXFORMATS
#   So Ma 27 18:52:06 CEST 2005 honor $TMPDIR, $TEMP and $TMP, not just $TMP
#   Sa Jan 15 18:13:46 CET 2005 avoid multiple variable assignments in one statement
#   Di Jan 11 11:42:36 CET 2005 fix --byhyphen with relative hyphenfile
#   Fr Dez 31 16:51:29 CET 2004 option catcfg added (for being called by texconfig)
#   Do Dez 30 21:53:27 CET 2004 rename variable verbose to verboseFlag
#   Sa Dez 25 12:44:23 CET 2004 implementation adopted for teTeX-3.0 (tcfmgr)
#   Do Okt 28 11:09:36 CEST 2004 added --refresh
#   Fr Sep 17 19:25:28 CEST 2004 save $0 in a variable before calling a function
#   Sun May  9 23:24:06 CEST 2004 changes for new web2c: format names
#                                 are now *.fmt, nothing else, disable
#                                 "plain" symlinks
#   Thu May  6 14:16:19 CEST 2004: "mv ...</dev/null" to avoid interaction.
#   Sun Mar 21 19:44:36 CET 2004: support aleph
#   Thu Dec 25 22:11:53 CET 2003: add version string
#   Thu Dec 25 12:56:14 CET 2003: new listcfg_loop lists only supported formats
#   Sun Dec 21 10:25:37 CET 2003 "mktexfmt pdflatex" did not work (if called
#                                as mktexfmt, an extention was mandatory)
#   Mon Sep 15 13:07:31 CEST 2003 add tmpdir to TEXINPUTS
#   Sun Aug  3 11:09:46 CEST 2003 special case for mptopdf
#   Sun Apr 20 10:27:09 CEST 2003 allow " " as well as tab in config file
#   Wed Feb 19 21:14:52 CET 2003   add eomega support
#   Sat Feb 15 22:01:35 CET 2003   let mf-nowin work without mf
#   Wed Dec 25 09:47:44 CET 2002   bugfix for localized pool files
#   Fri Oct 25 02:29:06 CEST 2002: now more careful about find_hyphenfile()
#   Tue Oct 22 22:46:48 CEST 2002: -jobname, oft extension
#   Fri Oct  4 22:33:17 CEST 2002: add more cli stuff: enablefmt
#                                  disablefmt listcfg
#   Sun Jul  7 21:28:37 CEST 2002: look at log file for possible problems,
#                                  and issue a warning
#   Tue Jun  4 21:52:57 CEST 2002: trap / cleanup code from updmap
#   Tue Jun  4 19:32:44 CEST 2002: be smarter about stdout / stderr
#   Tue Apr  9 22:46:34 CEST 2002: pass -progname=mpost for metafun
#   Tue Apr  2 00:37:39 CEST 2002: added mktexfmt functionality
#   Tue Jun  5 14:45:57 CEST 2001: added support for mf / mpost
###############################################################################

test -f /bin/ksh && test -z "$RUNNING_KSH" \
  && { UNAMES=`uname -s`; test "x$UNAMES" = xULTRIX; } 2>/dev/null \
  && { RUNNING_KSH=true; export RUNNING_KSH; exec /bin/ksh $0 ${1+"$@"}; }
unset RUNNING_KSH

test -f /bin/bsh && test -z "$RUNNING_BSH" \
  && { UNAMES=`uname -s`; test "x$UNAMES" = xAIX; } 2>/dev/null \
  && { RUNNING_BSH=true; export RUNNING_BSH; exec /bin/bsh $0 ${1+"$@"}; }
unset RUNNING_BSH

# hack around a bug in zsh:
test -n "${ZSH_VERSION+set}" && alias -g '${1+"$@"}'='"$@"'

progname=fmtutil
argv0=$0
version='$Id: fmtutil.sh 30365 2013-05-10 06:53:44Z peter $'

cnf=fmtutil.cnf   # name of the config file
export PATH

###############################################################################
# cleanup()
#   clean up the temp area and exit with proper exit status
###############################################################################
cleanup()
{
  rc=$1
  # for debugging, exit $rc here so $tmpdir with its logs sticks around.
  $needsCleanup && test -n "$tmpdir" && test -d "$tmpdir" \
    && { cd / && rm -rf "$tmpdir"; }
  (exit $rc); exit $rc
}   

###############################################################################
# help() and version()
#   display help (or version) message and exit
###############################################################################
help()
{
  cat <<eof
$version
Usage: fmtutil [OPTION]... CMD [ARG]...
Usage: mktexfmt FORMAT.fmt|BASE.base|MEM.mem|FMTNAME.EXT

Rebuild and manage TeX formats, Metafont bases and MetaPost mems.

If the command name ends in mktexfmt, only one format can be created.
The only options supported are --help and --version, and the command
line must consist of either a format name, with its extension, or a
plain name that is passed as the argument to --byfmt (see below).  The
full name of the generated file (if any) is written to stdout, and
nothing else.

If not operating in mktexfmt mode, the command line can be more general,
and multiple formats can be generated, as follows.

Optional behavior:
  --cnffile FILE             read FILE instead of fmtutil.cnf.
  --fmtdir DIRECTORY
  --no-engine-subdir         don't use engine-specific subdir of the fmtdir
  --no-error-if-no-format    exit successfully if no format is selected
  --quiet                    be silent
  --test                     (not implemented, just for compatibility)
  --dolinks                  (not implemented, just for compatibility)
  --force                    (not implemented, just for compatibility)

Valid commands for fmtutil:
  --all                      recreate all format files
  --missing                  create all missing format files
  --refresh                  recreate only existing format files
  --byengine ENGINENAME      (re)create formats using ENGINENAME
  --byfmt FORMATNAME         (re)create format for FORMATNAME
  --byhyphen HYPHENFILE      (re)create formats that depend on HYPHENFILE
  --enablefmt FORMATNAME     enable formatname in config file
  --disablefmt FORMATNAME    disable formatname in config file
  --listcfg                  list (enabled and disabled) configurations,
                             filtered to available formats
  --catcfg                   output the content of the config file
  --showhyphen FORMATNAME    print name of hyphenfile for format FORMATNAME
  --edit                     no-op in TeX Live
  --version                  show version info
  --help                     show this message

The default config file is named fmtutil.cnf, and
running  kpsewhich fmtutil.cnf  should show the active file.
The command  kpsewhich --engine=/ --all foo.fmt  should show the
locations of any and all foo.fmt files.

For more information about fmt generation in TeX Live, try
tlmgr --help or see http://tug.org/texlive/doc/tlmgr.html.
The \`generate' action in tlmgr does the work.

Report bugs to: tex-k@tug.org
TeX Live home page: <http://tug.org/texlive/>
eof
  cleanup 0
}

versionfunc()
{
  cat <<eof
$progname version $version
eof
  cleanup 0
}

###############################################################################
# setupTmpDir()
#   set up a temp directory and a trap to remove it
###############################################################################
setupTmpDir()
{
  $needsCleanup && return

  trap 'cleanup 1' 1 2 3 7 13 15
  needsCleanup=true
  (umask 077; mkdir "$tmpdir") \
    || abort "could not create directory \`$tmpdir'"
}

###############################################################################
# configReplace(file, pattern, line)
#   The first line in file that matches pattern gets replaced by line.
#   line will be added at the end of the file if pattern does not match.
###############################################################################
configReplace()
{
  file=$1; pat=$2; line=$3

  if grep "$pat" "$file" >/dev/null; then
    ed "$file" >/dev/null 2>&1 <<-eof
	/$pat/
	c
	$line
	.
	w
	q
eof
  else
    echo "$line" >> $file
  fi
}

###############################################################################
# setmatch(match)
#   setting the "match state" to true or false. Used to see if there was at
#   least one match.
###############################################################################
setmatch()
{
  match=$1
}

###############################################################################
# getmatch()
#    return success if there was at least one match.
###############################################################################
getmatch()
{
  test "x$match" = xtrue
}

###############################################################################
# initTexmfMain()
#   get $MT_TEXMFMAIN from $TEXMFMAIN
###############################################################################
initTexmfMain()
{
  case $MT_TEXMFMAIN in
    "") MT_TEXMFMAIN=`kpsewhich --var-value=TEXMFMAIN`;;
  esac
  export MT_TEXMFMAIN
}

###############################################################################
# cache_vars()
#   locate files / kpathsea variables and export variables to environment
#    this speeds up future calls to e.g. mktexupd
###############################################################################
cache_vars()
{
  : ${MT_VARTEXFONTS=`kpsewhich --expand-var='$VARTEXFONTS' | sed 's%^!!%%'`}
  : ${MT_MKTEXNAM=`kpsewhich --format='web2c files' mktexnam`}
  : ${MT_MKTEXNAM_OPT=`kpsewhich --format='web2c files' mktexnam.opt`}
  : ${MT_MKTEXDIR=`kpsewhich --format='web2c files' mktexdir`}
  : ${MT_MKTEXDIR_OPT=`kpsewhich --format='web2c files' mktexdir.opt`}
  : ${MT_MKTEXUPD=`kpsewhich --format='web2c files' mktexupd`}
  : ${MT_MKTEX_CNF=`kpsewhich --format='web2c files' mktex.cnf`}
  : ${MT_MKTEX_OPT=`kpsewhich --format='web2c files' mktex.opt`}
  export MT_VARTEXFONTS MT_MKTEXNAM MT_MKTEXNAM_OPT MT_MKTEXDIR
  export MT_MKTEXDIR_OPT MT_MKTEXUPD MT_MKTEX_CNF MT_MKTEX_OPT
}

###############################################################################
# abort(errmsg)
#   print `errmsg' to stderr and exit with error code 1
###############################################################################
abort()
{
  echo "$progname: $1." >&2
  cleanup 1
}

###############################################################################
# maybe_abort(errmsg)
#   print `errmsg' to stderr and 
#   unless noAbortFlag is set exit with error code 1
###############################################################################
maybe_abort()
{
  echo "$progname: $1." >&2
  $noAbortFlag || cleanup 1
}

###############################################################################
# verboseMsg(msg)
#   print `msg' to stderr is $verbose is true
###############################################################################
verboseMsg() {
  $verboseFlag && verbose echo ${1+"$@"}
}

###############################################################################
# byebye()
#   report any failures and exit the program
###############################################################################
byebye()
{
  if $has_warnings; then
    {
      cat <<eof

###############################################################################
$progname: Warning! Some warnings have been issued.
Visit the log files in directory
  $destdir
for details.
###############################################################################

This is a summary of all \`warning' messages:
$log_warning_msg
eof
    } >&2
  fi

  if $has_errors; then
    {
      cat <<eof

###############################################################################
$progname: Error! Not all formats have been built successfully.
Visit the log files in directory
  $destdir
for details.
###############################################################################

This is a summary of all \`failed' messages:
$log_failure_msg
eof
    } >&2
    cleanup 1
  else
    cleanup 0
  fi
}

###############################################################################
# init_log_warning()
#   reset the list of warning messages
###############################################################################
init_log_warning()
{
  log_warning_msg=
  has_warnings=false
}

###############################################################################
# init_log_failure()
#   reset the list of failure messages
###############################################################################
init_log_failure()
{
  log_failure_msg=
  has_errors=false
}

###############################################################################
# log_warning(errmsg)
#   report and save warning message `errmsg'
###############################################################################
log_warning()
{
  echo "Warning: $@" >&2
  if test -z "$log_warning_msg"; then
    log_warning_msg="$@"
  else
    OLDIFS=$IFS; IFS=
    log_warning_msg="$log_warning_msg
$@"
    IFS=$OLDIFS
  fi
  has_warnings=true
}

###############################################################################
# log_failure(errmsg)
#   report and save failure message `errmsg'
###############################################################################
log_failure()
{
  echo "Error: $@" >&2
  if test -z "$log_failure_msg"; then
    log_failure_msg="$@"
  else
    OLDIFS=$IFS; IFS=
    log_failure_msg="$log_failure_msg
$@"
    IFS=$OLDIFS
  fi
  has_errors=true
}

###############################################################################
# verbose (cmd)
#   execute cmd. Redirect output depending on $mktexfmtMode.
###############################################################################
verbose()
{
  $mktexfmtMode && ${1+"$@"} >&2 || ${1+"$@"}
}

###############################################################################
# mktexdir(args)
#   call mktexdir script, disable all features (to prevent sticky directories)
###############################################################################
mktexdir()
{      
  initTexmfMain
  MT_FEATURES=none "$MT_TEXMFMAIN/web2c/mktexdir" "$@" >&2
}

###############################################################################
# tcfmgr(args)
#   call tcfmgr script
###############################################################################
tcfmgr()
{
  initTexmfMain
  "$MT_TEXMFMAIN/texconfig/tcfmgr" "$@"
}

###############################################################################
# mktexupd(args)
#   call mktexupd script
###############################################################################
mktexupd()
{
  initTexmfMain
  "$MT_TEXMFMAIN/web2c/mktexupd" "$@"
}

###############################################################################
# main()
#   parse commandline arguments, initialize variables,
#   switch into temp. direcrory, execute desired command
###############################################################################
main()
{
  destdir=     # global variable: where do we put the format files?
  cnf_file=    # global variable: full name of the config file
  cmd=         # desired action from command line
  needsCleanup=false
  need_find_hyphenfile=false
  cfgparam=
  cfgmaint=
  verboseFlag=true
  noAbortFlag=false
  # eradicate double slashes to avoid kpathsea expansion.
  tmpdir=`echo ${TMPDIR-${TEMP-${TMP-/tmp}}}/$progname.$$ | sed s,//,/,g`

  # mktexfmtMode: if called as mktexfmt, set to true. Will echo the
  # first generated filename after successful generation to stdout then
  # (and nothing else), since kpathsea can only deal with one.
  mktexfmtMode=false
  case $argv0 in
    mktexfmt|*/mktexfmt)
      mktexfmtMode=true
      fullfmt=$1; shift
      case $fullfmt in
        ""|--help) help ;;
        --version) versionfunc ;;
              --*) abort "unknown option $fullfmt, try --help" ;;
        *.fmt|*.mem|*.base)
          set x --byfmt `echo $fullfmt | sed 's@\.[a-z]*$@@'` ${1+"$@"}
          shift
          ;;
        *.*) abort "unknown format type: $fullfmt" ;;
          *) set x --byfmt $fullfmt; shift ;;
      esac
      ;;
  esac

  use_engine_dir=true # whether to use web2c/$engine subdirs
  while
    case $1 in
      --cnffile)
          shift; cnf_file=$1; cfgparam=1;;
      --cnffile=*)
          cnf_file=`echo "$1" | sed 's/--cnffile=//'`; cfgparam=1; shift ;;
      --fmtdir)
          shift; destdir=$1;;
      --fmtdir=*)
          destdir=`echo "$1" | sed 's/--fmtdir=//'`; shift ;;
      --no-engine-subdir)
          use_engine_dir=false;;
      --all|-a)
          cmd=all;;
      --edit|-e)
          cmd=edit; cfgmaint=1;;
      --missing|-m)
          cmd=missing;;
      --refresh|-r)
          cmd=refresh;;
      --byengine)
          shift; cmd=byengine; arg=$1;;
      --byengine=*)
          cmd=byengine; arg=`echo "$1" | sed 's/--byengine=//'`; shift ;;
      --byfmt|-f)
          shift; cmd=byfmt; arg=$1;;
      --byfmt=*)
          cmd=byfmt; arg=`echo "$1" | sed 's/--byfmt=//'`; shift ;;
      --byhyphen|-h)
          shift; cmd=byhyphen; arg=$1;;
      --byhyphen=*)
          cmd=byhyphen; arg=`echo "$1" | sed 's/--byhyphen=//'`; shift ;;
      --showhyphen|-s)
          shift; cmd=showhyphen; arg=$1;;
      --showhyphen=*)
          cmd=showhyphen; arg=`echo "$1" | sed 's/--showhyphen=//'`; shift ;;
      --help|-help)
          cmd=help;;
      --version)
          cmd=version;;
      --enablefmt)
          shift; cmd=enablefmt; arg=$1; cfgmaint=1;;
      --enablefmt=*)
          cmd=enablefmt; arg=`echo "$1" | sed 's/--enablefmt=//'`; cfgmaint=1; shift;;
      --disablefmt)
          shift; cmd=disablefmt; arg=$1; cfgmaint=1;;
      --disablefmt=*)
          cmd=disablefmt; arg=`echo "$1" | sed 's/--disablefmt=//'`; cfgmaint=1; shift;;
      --catcfg)
          cmd=catcfg;;
      --listcfg)
          cmd=listcfg;;
      --no-error-if-no-format)
          noAbortFlag=true;;
      --quiet|-q|--silent)
          verboseFlag=false;;
      --test|--dolinks|--force)
          ;;
      "") break;;
      *) abort "unknown option \`$1'; try $progname --help if you need it";;
    esac
  do test $# -gt 0 && shift; done

  case "$cmd" in
         "") abort "missing command; try $progname --help if you need it";;
       help) help;;
    version) versionfunc;;
  esac

  if test -n "$cfgparam"; then
    test -f "$cnf_file" || abort "config file \`$cnf_file' not found (ls-R missing?)"
  fi

  if test -n "$cfgmaint"; then
    if test -z "$cfgparam"; then
      setupTmpDir
      co=`tcfmgr --tmp $tmpdir --cmd co --file $cnf`
      test $? = 0 || cleanup 1
      set x $co; shift
      id=$1; cnf_file=$3; orig=$4
      verboseMsg "$progname: initial config file is \`$orig'"
    fi
  else
    if test -z "$cfgparam"; then
      cnf_file=`tcfmgr --cmd find --file $cnf`
      test -f "$cnf_file" || abort "config file \`$cnf' not found"
    fi
  fi

  # these commands need no temp directory, so do them here:
  case "$cmd" in
    catcfg)
      grep -v '^ *#' "$cnf_file" | sed 's@^ *@@; s@ *$@@' | grep . | sort
      cleanup $? ;;
    edit)
      echo "$0: fmtutil --edit is disabled in TeX Live;" >&2
      echo "$0: use a file fmtutil-local.cnf instead." >&2
      echo "$0: See tlmgr --help or http://tug.org/texlive/doc/tlmgr.html." >&2
      cleanup 0 ;;
    enablefmt|disablefmt)
      $cmd $arg ;;  # does not return
    listcfg)
      listcfg_loop
      cleanup $? ;;
    showhyphen)
      show_hyphen_file "$arg"
      cleanup $? ;;
  esac

  if test -n "$cfgmaint"; then
    if test -z "$cfgparam"; then
      ci=`tcfmgr --tmp $tmpdir --cmd ci --id $id`
      if test $? = 0; then
        if test -n "$ci"; then
          verboseMsg "$progname: configuration file updated: \`$ci'"
        else
          verboseMsg "$progname: configuration file unchanged."
        fi
      else
        abort "failed to update configuration file."
      fi
    fi
    cleanup $?
  fi

  # set up destdir:
  if test -z "$destdir"; then
    : ${MT_TEXMFVAR=`kpsewhich -var-value=TEXMFVAR`}
    destdir=$MT_TEXMFVAR/web2c
  fi
  test -d "$destdir" || mktexdir "$destdir" >/dev/null 2>&1
  test -d "$destdir" || abort "format directory \`$destdir' does not exist"
  test -w "$destdir" || abort "format directory \`$destdir' is not writable"

  thisdir=`pwd`

  : ${KPSE_DOT=$thisdir}
  export KPSE_DOT

  # due to KPSE_DOT, we don't search the current directory, so include
  # it explicitly for formats that \write and later on \read
  TEXINPUTS="$tmpdir:$TEXINPUTS"; export TEXINPUTS
  # for formats that load other formats (e.g., jadetex loads latex.fmt), 
  # add the current directory to TEXFORMATS, too.  Currently unnecessary
  # for MFBASES and MPMEMS.
  TEXFORMATS="$tmpdir:$TEXFORMATS"; export TEXFORMATS

  setupTmpDir
  cd "$tmpdir" || cleanup 1

  # make local paths absolute:
  case "$destdir" in
    /*) ;;
    *)  destdir="$thisdir/$destdir";;
  esac
  case "$cnf_file" in
    /*) ;;
    *)  cnf_file="$thisdir/$cnf_file";;
  esac

  cache_vars
  init_log_failure
  init_log_warning
  # execute the desired command:
  case "$cmd" in 
    all)
      recreate_all;;
    missing)
      create_missing;;
    refresh)
      recreate_existing;;
    byengine)
      recreate_by_engine "$arg";;
    byfmt)
      recreate_by_fmt "$arg";;
    byhyphen)
      recreate_by_hyphenfile "$arg";;
  esac

  byebye
}

###############################################################################
# parse_line(config_line) sets global variables:
#   format:  name of the format, e.g. pdflatex
#   engine:  name of the TeX engine, e.g. tex, etex, pdftex
#   texargs: flags for initex and name of the ini file (e.g. -mltex frlatex.ini)
#   fmtfile: name of the format file (without directory, but with extension)
#
#   Support for building internationalized formats sets:
#     pool: base name of pool file (to support translated pool files)
#     tcx: translation file used when creating the format
#
#   Example (for fmtutil.cnf):
#     mex-pl tex mexconf.tex nls=tex-pl,il2-pl mex.ini
#
#   The nls parameter (pool,tcx) can only be specified as the first argument
#   inside the 4th field in fmtutil.cnf.
#
# exit code: returns error code if the ini file is not installed
###############################################################################
parse_line()
{
  case $1 in
    '#!') disabled=true; shift;;
    *) disabled=false;;
  esac
  format=$1
  engine=$2
  hyphenation=$3
  shift; shift; shift

  # handle nls support: pool + tcx
  pool=; tcx=
  case $1 in
    nls=*)
      pool=`echo $1 | sed 's@nls=@@; s@,.*@@'`
      tcx=`echo $1 | sed 's@nls=[^,]*@@; s@^,@@'`
      shift      # nls stuff is not handled by the engine directly,
                 # so we shift this away
      ;;
  esac

  texargs="$@"

  case "$engine" in
    mpost)           fmtfile="$format.mem";  kpsefmt=mp; texengine=metapost;;
    mf|mfw|mf-nowin) fmtfile="$format.base"; kpsefmt=mf; texengine=metafont;;
    *)               fmtfile="$format.fmt";  kpsefmt=tex; texengine=$engine;;
  esac

  # remove any * for the sake of the kpsewhich lookup.
  eval lastarg=\$$#
  inifile=`echo $lastarg | sed 's%^\*%%'`

  # See if we can find $inifile for return code:
  kpsewhich -progname=$format -format=$kpsefmt $inifile >/dev/null 2>&1
}

###############################################################################
# find_hyphenfile(format, hyphenation) searches for hyphenation along
#                                      searchpath of format
# exit code: returns error is file is not found
###############################################################################
find_hyphenfile()
{
  format="$1"; hyphenation="`echo $2 | sed 's/,/ /g'`"
  case $hyphenation in
    -) ;;
    *) kpsewhich -progname="$format" -format=tex $hyphenation;;
  esac
}

###############################################################################
# find_info_for_name(format) 
#   Look up the config line for format `format' and call parse_line to set
#   global variables.
###############################################################################
find_info_for_name()
{
  format="$1"

  # set x `awk '$1 == format {print; exit}' format="$format" "$cnf_file"`; shift
  set x `egrep "^$format( |	)" "$cnf_file" | sed q`; shift
  test $# = 0 && abort "no info for format \`$format'"
  parse_line "$@"
}

###############################################################################
# run_initex()
#   Calls initex. Assumes that global variables are set by parse_line.
###############################################################################
run_initex()
{

  # install a pool file and set tcx flag if requested in lang= option:
  rm -f *.pool
  poolfile=
  tcxflag=
  test -n "$pool" \
    && poolfile=`(kpsewhich -progname=$engine $pool.pool) 2>/dev/null`
  if test -n "$poolfile" && test -f "$poolfile"; then
    verboseMsg "$progname: attempting to create localized format using pool=$pool and tcx=$tcx."
    cp "$poolfile" $engine.pool
    test -n "$tcx" && tcxflag=-translate-file=$tcx
    localpool=true
  else
    localpool=false
  fi

  jobswitch="-jobname=$format"
  case "$format" in
    metafun)         prgswitch=-progname=mpost;;
    mptopdf|cont-??) prgswitch=-progname=context;;
    *)               prgswitch=-progname=$format;;
  esac

  rm -f $fmtfile

  # Check for infinite recursion before running the iniTeX:
  # We do this check only if we are running in mktexfmt mode
  # otherwise double format definitions will create an infinite loop, too
  $mktexfmtMode || mktexfmt_loop=
  case :$mktexfmt_loop: in
  *:"$format/$engine":*)
    abort "Infinite recursion detected, giving up!" ;;
  esac
  mktexfmt_loop=$mktexfmt_loop:$format/$engine
  export mktexfmt_loop

  verboseMsg "$progname: running \`$engine -ini  $tcxflag $jobswitch $prgswitch $texargs' ..."

  # run in a subshell to get a local effect of TEXPOOL manipulation:
  (
    # If necessary, set TEXPOOL. Use absolute path, because of KPSE_DOT.
    $localpool && { TEXPOOL="`pwd`:$TEXPOOL"; export TEXPOOL; }
    verbose $engine -ini $tcxflag $jobswitch $prgswitch $texargs
  ) </dev/null

  if test $use_engine_dir; then
    fulldestdir="$destdir/$texengine"
  else
    fulldestdir="$destdir"
  fi
  mkdir -p "$fulldestdir"
  if test -f "$fmtfile"; then
    grep '^! ' $format.log >/dev/null 2>&1 &&
      log_warning "\`$engine -ini $tcxflag $jobswitch $prgswitch $texargs' possibly failed."

    # We don't want user-interaction for the following "mv" commands:
    mv "$format.log" "$fulldestdir/$format.log" </dev/null
    #
    destfile=$fulldestdir/$fmtfile
    if mv "$fmtfile" "$destfile" </dev/null; then
      verboseMsg "$progname: $destfile installed."
      #
      # As a special special case, we create mplib-luatex.mem for use by
      # the mplib embedded in luatex if it doesn't already exist.  (We
      # never update it if it does exist.)
      # 
      # This is used by the luamplib package.  This way, an expert user
      # who wants to try a new version of luatex (hence with a new
      # version of mplib) can manually update mplib-luatex.mem without
      # having to tamper with mpost itself.
      # 
      if test "x$format" = xmpost && test "x$engine" = xmpost; then
        mplib_mem_name=mplib-luatex.mem
        mplib_mem_file=$fulldestdir/$mplib_mem_name
        if test \! -f $mplib_mem_file; then
          verboseMsg "$progname: copying $destfile to $mplib_mem_file"
          if cp "$destfile" "$mplib_mem_file" </dev/null; then
            mktexupd "$fulldestdir" "$mplib_mem_name"
          else
            log_warning "cp $destfile $mplib_mem_file failed."
          fi
        else
          verboseMsg "$progname: $mplib_mem_file already exists, not updating."
        fi
      fi
      #
      # Echo the (main) output filename for our caller.
      $mktexfmtMode && $mktexfmtFirst \
      && echo "$destfile" && mktexfmtFirst=false
      #
      mktexupd "$fulldestdir" "$fmtfile"
    fi
  else
    log_failure "\`$engine -ini $tcxflag $jobswitch $prgswitch $texargs' failed"
  fi
}

###############################################################################
# recreate_loop()
#   for each line in config file: check match-condition and recreate format
#   if there is a match
###############################################################################
recreate_loop()
{
  OIFS=$IFS
  IFS='
'
  set `echo x; sed '/^#/d; /^[ 	]*$/d' "$cnf_file"`; shift
  IFS=$OIFS
  for line
  do
    parse_line $line || continue
    check_match || continue
    run_initex
  done
}

###############################################################################
# listcfg_loop()
#   prints all format definitions in config files (enabled and disabled ones)
#   for supported formats (i.e. for those which have an existing ini file)
###############################################################################
listcfg_loop()
{
  OIFS=$IFS
  IFS='
'
  set `echo x; sed '/^#$/d; /^#[^!]/d; /^[ 	]*$/d' "$cnf_file"`; shift
  IFS=$OIFS
  for line
  do
    parse_line $line && echo "$line"
  done
}

###############################################################################
# check_match()
#   recreate all formats
###############################################################################
check_match()
{
  $need_find_hyphenfile && \
    this_hyphenfile="`find_hyphenfile "$format" "$hyphenation"`"

  eval $match_cmd && setmatch true
}

###############################################################################
# recreate_by_fmt(fmtname)
#   recreate all versions of fmtname
###############################################################################
recreate_by_fmt()
{
  fmtname=$1
  match_cmd="test x\$format = x$fmtname"
  recreate_loop
}

###############################################################################
# create_missing()
#   create all missing format files
###############################################################################
create_missing()
{
  # match_cmd='test ! -f $destdir/$fmtfile'
  match_cmd='test ! -f "`kpsewhich -engine=$texengine -progname=$format $fmtfile`"'
  recreate_loop
}

###############################################################################
# recreate_existing()
#   recreate only existing format files
###############################################################################
recreate_existing()
{
  match_cmd='test -f "`kpsewhich -engine=$texengine -progname=$format $fmtfile`"'
  recreate_loop
}

###############################################################################
# recreate_all()
#   recreate all formats
###############################################################################
recreate_all()
{
  match_cmd=true
  recreate_loop
}

###############################################################################
# recreate_by_hyphenfile(hyphenfile)
#   recreate all formats that depend on hyphenfile
###############################################################################
recreate_by_hyphenfile()
{
  hyphenfile=$1

  case $hyphenfile in
    /*)
      :
      ;;
    ./*)
      hyphenfile="$KPSE_DOT/"`echo "$hyphenfile" | sed 's@..@@'`
      ;;
    *)
      hyphenfile="$KPSE_DOT/$hyphenfile"
      ;;
  esac
  need_find_hyphenfile=true
  match_cmd="echo \"\$this_hyphenfile\" | grep \"$hyphenfile\" >/dev/null"

  # No match before the loop:
  setmatch false

  recreate_loop

  # Now check if there was at least one match:
  getmatch || maybe_abort "no format depends on hyphen file \`$hyphenfile'"
}

###############################################################################
# recreate_by_engine(enginename)
#   recreate all formats that are based on enginename
###############################################################################
recreate_by_engine()
{
  enginename=$1

  match_cmd="test x\$engine = x$enginename"

  # No match before the loop:
  setmatch false

  recreate_loop

  # Now check if there was at least one match:
  getmatch || maybe_abort "no format depends on engine \`$enginename'"
}



###############################################################################
# show_hyphen_file(format)
#   prints full name of the hyphenfile for format
#
# exit code: returns error code if the ini file is not installed or if
#            the hyphen file cannot be found
###############################################################################
show_hyphen_file()
{
  fmtname=$1

  find_info_for_name "$fmtname" || abort "no info for format \`$fmtname'"
  if test "x$hyphenation" = x-; then
    echo -
    cleanup 0
  fi
  find_hyphenfile "$format" "$hyphenation" \
    || abort "hyphenfile \`$hyphenation' not found"
}

###############################################################################
# disablefmt(format)
#   disables format in configuration file
###############################################################################
disablefmt()
{
  grep "^$1[ 	]" $cnf_file >/dev/null || { (exit 0); return 0; }

  ed $cnf_file >/dev/null 2>&1 <<-eof
	g/^$1[ 	]/s/^/#! /
	w
	q
eof
  (exit 0); return 0
}

###############################################################################
#  enablefmt(format)
#    enables format in configuration file
###############################################################################
enablefmt()
{
  grep "^#![ 	]*$1[ 	]" $cnf_file >/dev/null || { (exit 0); return 0; }
  ed $cnf_file >/dev/null 2>&1 <<-eof
	g/^#![ 	]*$1[ 	]/s/..[ 	]*//
	w
	q
eof
  (exit 0); return 0
}

main ${1+"$@"}
cleanup 0
