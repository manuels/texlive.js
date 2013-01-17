#! /usr/bin/env perl
use strict;
use warnings;
use Term::ANSIColor;
use Text::Wrap;
use Encode;
use utf8; # Because the script itself is UTF-8 encoded

##### Version information

my $versionnumber="2.3";
my $versiondate="2011 Jul 30";

###### Set global settings and variables

### Global data about TeXcount
my %GLOBALDATA=
   ('versionnumber'  => $versionnumber
   ,'versiondate'    => $versiondate
   ,'maintainer'     => "Einar Andreas Rodland"
   ,'copyrightyears' => "2008-2011"
   ,'website'        => "http://app.uio.no/ifi/texcount/"
   );

### Options and states

# Outer object (for error reports not added by a TeX object)
my $Main=getMain();

# Global options and settings
my $htmlstyle=0; # Flag to print HTML
my $encoding=undef; # Selected input encoding (default will be guess)
my @encodingGuessOrder=qw/ascii utf8 latin1/; # Encoding guessing order
my $outputEncoding; # Encoding used for output
my @AlphabetScripts=qw/Digit Is_alphabetic/; # Letters minus logograms: defined later
my @LogogramScripts=qw/Ideographic Katakana Hiragana Thai Lao Hangul/; # Scripts counted as whole words
my $WordPattern; # Regex matching a word (defined in apply_language_options())

# Parsing rules options
my $includeTeX=0; # Flag to parse included files
my $includeBibliography=0; # Flag to include bibliography
my %substitutions; # Substitutions to make globally

# Counting options
my @sumweights; # Set count weights for computing sum
my $optionWordFreq=0; # Count words of this frequency, or don't count if 0
my $optionWordClassFreq=0; # Count words per word class (language) if set

# Parsing details options
my $strictness=0; # Flag to check for undefined groups 
my $verbose=0; # Level of verbosity
my $showcodes=1; # Flag to show overview of colour codes (2=force)
my $showstates=0; # Flag to show internal state in verbose log
my $showsubcounts=0; # Write subcounts if #>this, or not (if 0)
my $separatorstyleregex='^word'; # Styles (regex) after which separator should be added
my $separator=''; # Separator to add after words/tokens

# Final summary output options
my $showVersion=0; # Indicator that version info be included (1) or not (-1)
my $totalflag=0; # Flag to write only total summary
my $briefsum=0; # Flag to set brief summary
my $outputtemplate; # Output template
my $finalLineBreak=1; # Add line break at end

# Global settings
my $optionFast=1; # Flag inticating fast method 

# Global variables and internal states (for internal use only)
my $blankline=0; # Number of blank lines printed
my $errorcount=0; # Number of errors in parsing
my %warnings=(); # Warnings
my %WordFreq; # Hash for counting words

# String data storage
my $STRINGDATA;

###### Set CMD specific settings and variables

## Preset command line options
# List of options (stings) separated by comma,
# e.g. ("-inc","-v") to parse included files and
# give verbose output by default.
my @StartupOptions=();

# CMD specific global variables
my @filelist; # List of files to parse
my $workdir; # Root directory (taken from filename)
my $globalworkdir=""; # Overrules workdir (default=present root)
my $fileFromSTDIN=0; # Flag to set input from STDIN
my $_STDIN_="<STDIN>"; # File name to represent STDIN

# CMD specific settings
$Text::Wrap::columns=76; # Page width for wrapped output

###### Set status identifiers and methods


### Counter indices from 0 to $SIZE_CNT-1
#   0: Number of files
#   1: Text words
#   2: Header words
#   3: Caption words
#   4: Number of headers
#   5: Number of floating environments
#   6: Number of inlined math
#   7: Number of displayed math
my $SIZE_CNT=8;
my $CNT_FILE=0;
my $CNT_WORDS_TEXT=1;
my $CNT_WORDS_HEADER=2;
my $CNT_WORDS_CAPTION=3;
my $CNT_COUNT_HEADER=4;
my $CNT_COUNT_FLOAT=5;
my $CNT_COUNT_INLINEMATH=6;
my $CNT_COUNT_DISPLAYMATH=7;

# Labels used to describe the counts
my @countlabel=('Files','Words in text','Words in headers',
      'Words in float captions','Number of headers','Number of floats',
      'Number of math inlines','Number of math displayed');

### Parsing statuses
## Note that status numbers are used in rule definitions and should
## not be changed.
#
## Status for regions that should not be counted
#    0 = exclude from count
## Statuses for regions in which words should not be counted
#   -1 = float (exclude, but include captions)
#   -2 = strong exclude, ignore begin-end groups
#   -3 = stronger exclude, do not parse macro parameters
#   -4 = ignore everything except end marker: even {
#   -9 = preamble (between \documentclass and \begin{document})
## Statuses for regions in which words should be counted
#    1 = text
#    2 = header text
#    3 = float text
## Status change: not used in parsing, but to switch status then ignore contents
#    6 = switch to inlined math
#    7 = switch to displayed math
## Note that positive statuses must correspond to CNT codes!
#
my $STATUS_IGNORE=0;
my $STATUS_FLOAT=-1;
my $STATUS_EXCLUDE_STRONG=-2;
my $STATUS_EXCLUDE_STRONGER=-3;
my $STATUS_EXCLUDE_ALL=-4;
my $STATUS_PREAMBLE=-9;
my $STATUS_TEXT=1;
my $STATUS_TEXT_HEADER=2;
my $STATUS_TEXT_FLOAT=3;
my $STATUS_TO_INLINEMATH=6;
my $STATUS_TO_DISPLAYMATH=7;

# When combining two statuses, use the first one; list must be complete!
my @STATUS_PRIORITY_LIST=(-4,-3,-2,-1,0,-9,3,2,1);

# Status: is a text status..."include status" is more correct
sub status_is_text {
  my $st=shift @_;
  return ($st>0);
}

# Status: get CNT corresponding to text status (or undef)
sub status_text_cnt {
  my $st=shift @_;
  if ($st==$STATUS_TEXT) {return $CNT_WORDS_TEXT;}
  if ($st==$STATUS_TEXT_HEADER) {return $CNT_WORDS_HEADER;}
  if ($st==$STATUS_TEXT_FLOAT) {return $CNT_WORDS_CAPTION;}
  return undef;
}

# Status: is an exclude status
sub status_is_exclude {
  my $st=shift @_;
  return ($st<0);
}

# Status: \begin and \end should be processed
sub status_inc_envir {
  my $st=shift @_;
  return ($st>-2);
}

# Map status number to CNT value
sub status_to_cnt {
  my $st=shift @_;
  if ($st==$STATUS_TO_INLINEMATH) {return $CNT_COUNT_INLINEMATH;}
  if ($st==$STATUS_TO_DISPLAYMATH) {return $CNT_COUNT_DISPLAYMATH;}
  return undef;
}

# Status as text
sub status_to_text {
  my $st=shift @_;
  return $st;
}

# Status as text
sub status_to_style {
  return 'word'.status_to_text(@_);
}

### Token types
#  -1: space
#   0: comment
#   1: word (or other forms of text or text components)
#   2: symbol (not word, e.g. punctuation)
#   3: macro
#   4: curly braces {}
#   5: brackets []
#   6: maths
#   9: line break in file
# 999: end of line or blank line
# 666: TeXcount instruction (%TC:instruction)
my $TOKEN_SPACE=-1;
my $TOKEN_COMMENT=0;
my $TOKEN_WORD=1;
my $TOKEN_SYMBOL=2;
my $TOKEN_MACRO=3;
my $TOKEN_BRACE=4;
my $TOKEN_BRACKET=5;
my $TOKEN_MATH=6;
my $TOKEN_LINEBREAK=9;
my $TOKEN_TC=666;
my $TOKEN_END=999;

###### Set global definitions


### Break points
# Definition of macros that define break points that start a new subcount.
# The values given are used as labels.
my %BreakPointsOptions;
$BreakPointsOptions{'none'}={};
$BreakPointsOptions{'part'}={%{$BreakPointsOptions{'none'}},'\part'=>'Part'};
$BreakPointsOptions{'chapter'}={%{$BreakPointsOptions{'part'}},'\chapter'=>'Chapter'};
$BreakPointsOptions{'section'}={%{$BreakPointsOptions{'chapter'}},'\section'=>'Section'};
$BreakPointsOptions{'subsection'}={%{$BreakPointsOptions{'section'}},'\subsection'=>'Subsection'};
$BreakPointsOptions{'default'}=$BreakPointsOptions{'subsection'};
my %BreakPoints=%{$BreakPointsOptions{'none'}};

### Print styles
# Definition of different print styles: maps of class labels
# to ANSI codes. Class labels are as used by HTML styles.
my @STYLES=();
my %STYLE;
$STYLES[0]={'error'=>'bold red'};
$STYLES[1]={%{$STYLES[0]},''=>'normal',' '=>'normal',
            'word1'=>'blue','word2'=>'bold blue','word3'=>'blue',
            'grouping'=>'red','document'=>'red','mathgroup'=>'magenta',
            'state'=>'cyan underline','cumsum'=>'yellow'};
$STYLES[2]={%{$STYLES[1]},
            'command'=>'green','ignore'=>'cyan',
            'exclcommand'=>'yellow','exclgroup'=>'yellow','exclmath'=>'yellow'};
$STYLES[3]={%{$STYLES[2]},
            'tc'=>'bold yellow','comment'=>'yellow','option'=>'yellow',
            'fileinclude'=>'bold green'};
$STYLES[4]={%{$STYLES[3]}};

###### Define what a word is and language options


# Patters matching a letter. Should be a single character or
# ()-enclosed regex for substitution into word pattern regex.
my @LetterMacros=qw/ae AE o O aa AA oe OE ss
   alpha beta gamma delta epsilon zeta eta theta iota kappa lamda
   mu nu xi pi rho sigma tau upsilon phi chi psi omega
   Gamma Delta Theta Lambda Xi Pi Sigma Upsilon Phi Psi Omega 
   /;
my $specialchars='\\\\('.join('|',@LetterMacros).')(\{\}|\s*|\b)';
my $modifiedchars='\\\\[\'\"\`\~\^\=](@|\{@\})';
my %NamedLetterPattern;
$NamedLetterPattern{'restricted'}='@';
$NamedLetterPattern{'default'}='('.join('|','@',$modifiedchars,$specialchars).')';
$NamedLetterPattern{'relaxed'}=$NamedLetterPattern{'default'};
my $LetterPattern=$NamedLetterPattern{'default'};

# List of regexp patterns that should be analysed as words.
# Use @ to represent a letter, will be substituted with $LetterPattern.
# Named patterns may replace or be appended to the original patterns.
my %NamedWordPattern;
$NamedWordPattern{'letters'}='@';
$NamedWordPattern{'words'}='(@+|\{@+\})([\-\'\.]?(@+|\{@+\}))*';
my @WordPatterns=($NamedWordPattern{'words'});

### Macro option regexp list
# List of regexp patterns to be gobbled as macro option in and after
# a macro.
my %NamedMacroOptionPattern;
$NamedMacroOptionPattern{'default'}='\[(\w|[,\-\s\~\.\:\;\+\?\*\_\=])*\]';
$NamedMacroOptionPattern{'relaxed'}='\[[^\[\]\n]*\]';
$NamedMacroOptionPattern{'restricted'}=$NamedMacroOptionPattern{'default'};
my $MacroOptionPattern=$NamedMacroOptionPattern{'default'};

### Alternative language encodings
my %NamedEncodingGuessOrder;
$NamedEncodingGuessOrder{'chinese'}=[qw/utf8 gb2312 big5/];
$NamedEncodingGuessOrder{'japanese'}=[qw/utf8 euc-jp iso-2022-jp jis shiftjis/];
$NamedEncodingGuessOrder{'korean'}=[qw/utf8 euc-kr iso-2022-kr/];


###### Define character classes (alphabets)


### Character classes to use as Unicode properties

# Character group representing digits 0-9 (more restrictive than Digits)
sub Is_digit { return <<END;
0030\t0039
END
}

# Character group representing letters (excluding logograms)
sub Is_alphabetic { return <<END;
+utf8::Alphabetic
-utf8::Ideographic
-utf8::Katakana
-utf8::Hiragana
-utf8::Thai
-utf8::Lao
-utf8::Hangul
END
}

# Character group representing letters (excluding logograms)
sub Is_alphanumeric { return <<END;
+utf8::Alphabetic
+utf8::Digit
-utf8::Ideographic
-utf8::Katakana
-utf8::Hiragana
-utf8::Thai
-utf8::Lao
-utf8::Hangul
END
}

# Character class for punctuation excluding special characters
sub Is_punctuation { return <<END;
+utf8::Punctuation
-0024\t0025
-005c
-007b\007e
END
}

# Character group representing CJK characters
sub Is_cjk { return <<END;
+utf8::Han
+utf8::Katakana
+utf8::Hiragana
+utf8::Hangul
END
}

# Character group for CJK punctuation characters
sub Is_cjkpunctuation { return <<END;
3000\t303f
2018\t201f
ff01\tff0f
ff1a\tff1f
ff3b\tff3f
ff5b\tff65
END
}

###### Define core rules

### Macros for headers
# Macros that identify headers: i.e. following token or
# {...} is counted as header. The =>[2] indicates transition to
# state 2 which is used within headers (although the value is
# actually never used). This is copied to %TeXmacro and the
# only role of defining it here is that the counter for the number
# of headers is incremented by one.
my %TeXheader=('\title'=>[2],'\part'=>[2],'\chapter'=>[2],
     '\section'=>[2],'\subsection'=>[2],'\subsubsection'=>[2],
     '\paragraph'=>[2],'\subparagraph'=>[2]);

### Macros indicating package inclusion
# Will always be assumed to take one parameter (plus options).
my %TeXpackageinc=('\usepackage'=>1);

### Macros that are counted within the preamble
# The preamble is the text between \documentclass and \begin{document}.
# Text and macros in the preamble is ignored unless specified here. The
# value is the status (1=text, 2=header, etc.) they should be interpreted as.
# Note that only the first unit (token or {...} block) is counted.
my %TeXpreamble=(
     '\newcommand'=>[-3,-3],'\renewcommand'=>[-3,-3],
     '\newenvironment'=>[-3,-3,-3], '\renewenvironment'=>[-3,-3,-3],
     '\title'=>[2]);

### In floats: include only specific macros
# Macros used to identify caption text within floats.
my %TeXfloatinc=('\caption'=>[3]);

### How many tokens to gobble after macro
# Each macro is assumed to gobble up a given number of
# tokens (or {...} groups), as well as options [...] before, within
# and after. The %TeXmacro hash gives a link from a macro
# (or beginNAME for begin-end groups without the backslash)
# to either an integer giving the number of tokens to ignore
# or to an array (specified as [num,num,...]) of length N where
# N is the number of tokens to be read with the macro and the
# array values tell how each is to be interpreted (see the status
# values: 0=ignore, 1=count, etc.). Thus specifying a number N is
# equivalent to specifying an array [0,...,0] of N zeros.
#
# For macros not specified here, the default value is 0: i.e.
# no tokens are excluded, but [...] options are. Header macros
# specified in %TeXheader are automatically included here.
my %TeXmacro=(%TeXheader,%TeXpreamble,%TeXfloatinc,
     '\documentclass'=>1,'\documentstyle'=>1,'\usepackage'=>1, '\hyphenation'=>1,
     '\pagestyle'=>1,'\thispagestyle'=>1, '\pagenumbering'=>1,'\markboth'=>1, '\markright'=>1,
     '\newcommand'=>[-3,-3],'\renewcommand'=>[-3,-3],
     '\newenvironment'=>[-3,-3,-3], '\renewenvironment'=>[-3,-3,-3],
     '\newfont'=>2,'\newtheorem'=>2,'\bibliographystyle'=>1, '\bibliography'=>1,
     '\parbox'=>1, '\marginpar'=>[3],'\makebox'=>0, '\raisebox'=>1, '\framebox'=>0,
     '\newsavebox'=>1, '\sbox'=>1, '\savebox'=>2, '\usebox'=>1,'\rule'=>2,
     '\footnote'=>[3],'\label'=>1, '\ref'=>1, '\pageref'=>1, '\bibitem'=>1,
     '\cite'=>1, '\citep'=>1, '\citet'=>1, '\citeauthor'=>1, '\citealt'=>1, '\nocite'=>1,
     '\eqlabel'=>1, '\eqref'=>1,'\hspace'=>1, '\vspace'=>1, '\addvspace'=>1,
     '\input'=>1, '\include'=>1, '\includeonly'=>1,'\includegraphics'=>1,
     '\newlength'=>1, '\setlength'=>2, '\addtolength'=>2,'\settodepth'=>2,
     '\settoheight'=>2, '\settowidth'=>2,'\newcounter'=>1, '\setcounter'=>2,
     '\addtocounter'=>2,'\stepcounter'=>1, '\refstepcounter'=>1, '\usecounter'=>1,
     '\alph'=>1, '\arabic'=>1, '\fnsymbol'=>1, '\roman'=>1, '\value'=>1,
     '\cline'=>1, '\multicolumn'=>3,'\typeout'=>1, '\typein'=>1,
     'beginlist'=>2, 'beginminipage'=>1, 'begintabular'=>1,
     'beginthebibliography'=>1,'beginlrbox'=>1,
     '\begin'=>1,'\end'=>1,'\title'=>[2],
     '\addtocontents'=>2,'\addcontentsline'=>3,
     '\uppercase'=>0,'\lowercase'=>0);

### Macros that should be counted as one or more words
# Macros that represent text may be declared here. The value gives
# the number of words the macro represents.
my %TeXmacroword=('\LaTeX'=>1,'\TeX'=>1);

### Begin-End groups
# Identified as begin-end groups, and define =>state. The
# states used corresponds to the elements of the count array, and
# are:
#    0: Not included
#    1: Text, words included in text count
#    2: Header, words included in header count
#    3: Float caption, words included in float caption count
#    6: Inline mathematics, words not counted
#    7: Displayed mathematics, words not counted
#   -1: Float, not included, but looks for captions
#
#    4 and 5 are used to count number of headers and floats
#    and are not used as states.
#
# Groups that are not defined will be counted as the surrounding text.
#
# Note that some environments may only exist within math-mode, and
# therefore need not be defined here: in fact, they should not as it
# is not clear if they will be in inlined or displayed math.
my %TeXgroup=('document'=>1,'letter'=>1,'titlepage'=>0,
     'center'=>1,'flushleft'=>1,'flushright'=>1,
     'abstract'=>1,'quote'=>1,'quotation'=>1,'verse'=>1,'minipage'=>1,
     'verbatim'=>-4,'tikzpicture'=>-4,
     'description'=>1,'enumerate'=>1,'itemize'=>1,'list'=>1,
     'theorem'=>1,'lemma'=>1,'definition'=>1,'corollary'=>1,'example'=>1,
     'math'=>6,'displaymath'=>7,'equation'=>7,'eqnarray'=>7,'align'=>7,
     'equation*'=>7,'eqnarray*'=>7,'align*'=>7,
     'figure'=>-1,'float'=>-1,'picture'=>-1,'table'=>-1,
     'tabbing'=>0,'tabular'=>0,'thebibliography'=>0,'lrbox'=>0);

### Macros for including tex files
# Allows \macro{file} or \macro file. If the value is 0, the filename will
# be used as is; if it is 1, the filetype .tex will be added if the
# filename is without filetype; if it is 2, the filetype .tex will be added.
my %TeXfileinclude=('\input'=>1,'\include'=>2);

###### Define package specific rules

### Package rule definitions

my %PackageTeXmacro=(); # TeXmacro definitions per package
my %PackageTeXmacroword=(); # TeXmacroword definitions per package
my %PackageTeXheader=(); # TeXheader definitions per package
my %PackageTeXgroup=(); # TeXgroup definitions per package
my %PackageTeXfileinclude=(); # TeXgroup definitions per package

# Rules for package psfig
$PackageTeXmacro{'psfig'}={('\psfig'=>1)};

# Rules for bibliography inclusion
$PackageTeXmacroword{'%incbib'}={'thebibliography'=>1};
$PackageTeXmacro{'%incbib'}={};
$PackageTeXgroup{'%incbib'}={'thebibliography'=>1};
$PackageTeXfileinclude{'%incbib'}={'\bibliography'=>'bbl'};

###### Main script


###################################################

MAIN(@ARGV);
exit; # Just to make sure it ends here...

###################################################


#########
######### Main routines
#########

# MAIN ROUTINE: Handle arguments, then parse files
sub MAIN {
  my @args;
 push @args,@StartupOptions;
 push @args,@_;
  Initialise();
  Check_Arguments(@args);
  my @toplevelfiles=Parse_Arguments(@args);
  Apply_Options();
  if (scalar @toplevelfiles>0 || $fileFromSTDIN) {
    if ($showVersion && !$htmlstyle && !($briefsum && $totalflag)) {
      print "\n=== LaTeX word count (TeXcount version $versionnumber) ===\n\n";
    }
    conditional_print_help_style();
    my $totalcount=Parse_file_list(@toplevelfiles);
    conditional_print_total($totalcount);
    Report_Errors();
    if ($optionWordFreq || $optionWordClassFreq) {print_word_freq();}
  } elsif ($showcodes>1) {
    conditional_print_help_style();
  } else {
    error($Main,'No files specified.');
  }
  Close_Output();
}

# Initialise, overrule initial settings, etc.
sub Initialise {
  _option_subcount();
  # Windows settings
  if ($^O=~/^MSWin/) {
    option_ansi_colours(0);
  }
}

# Check arguments, exit on exit condition
sub Check_Arguments {
  my @args=@_;
  if (!@args) {
    print_version();
    print_syntax();
    print_reference();
    exit;
  } elsif ($args[0]=~/^(--?(h|\?|help)|\/(\?|h))$/) {
    print_help();
    exit;
  } elsif ($args[0]=~/^(--?(h|\?|help)|\/(\?|h))=/) {
    print_help_on("$'");
    exit;
  } elsif ($args[0]=~/^--?(ver|version)$/) {
    print_version();
    exit;
  } elsif ($args[0]=~/^--?(lic|license|licence)$/) {
    print_license();
    exit;
  }
  return 1;
}

# Parse arguments, set options (global) and return file list
sub Parse_Arguments {
  my @args=@_;
  my @files;
  foreach my $arg (@args) {
    if (parse_option($arg)) {next;}
    if ($arg=~/^\-/) {
      print 'Invalid opton '.$arg."\n";
      print_syntax();
      exit;
    }
    $arg=~s/\\/\//g;
    push @files,$arg;
  }
  return @files;
}

# Parse individual option parameters
sub parse_option {
  my $arg=shift @_;
  return parse_options_preset($arg) 
  || parse_options_parsing($arg)
  || parse_options_counts($arg)
  || parse_options_output($arg)
  || parse_options_format($arg)
  ;
}

# Parse presetting options
sub parse_options_preset {
  my $arg=shift @_;
  if ($arg=~/^-(opt|option|options|optionfile)=/) {
    _parse_optionfile($');
  }
  else {return 0;}
  return 1;
}

# Parse parsing options
sub parse_options_parsing {
  my $arg=shift @_;
  if    ($arg eq '-') {$fileFromSTDIN=1;}
  elsif ($arg eq '-merge') {$includeTeX=2;}
  elsif ($arg eq '-inc') {$includeTeX=1;}
  elsif ($arg eq '-noinc') {$includeTeX=0;}
  elsif ($arg =~/^-(includepackage|incpackage|package|pack)=(.*)$/) {include_package($2);}
  elsif ($arg eq '-incbib') {$includeBibliography=1;}
  elsif ($arg eq '-nobib') {$includeBibliography=0;}
  elsif ($arg eq '-dir') {$globalworkdir=undef;}
  elsif ($arg=~/^-dir=(.*)$/) {
    $globalworkdir=$1;
    $globalworkdir=~s:([^\/\\])$:$1\/:;
  }
  elsif ($arg =~/^-(enc|encode|encoding)=(.+)$/) {$encoding=$2;}
  elsif ($arg =~/^-(utf8|unicode)$/) {$encoding='utf8';}
  elsif ($arg =~/^-(alpha(bets?)?)=(.*)$/) {set_script_options(\@AlphabetScripts,$3);}
  elsif ($arg =~/^-(logo(grams?)?)=(.*)$/) {set_script_options(\@LogogramScripts,$3);}
  elsif ($arg =~/^-([-a-z]+)$/ && set_language_option($1)) {}
  elsif ($arg eq '-relaxed') {
    $MacroOptionPattern=$NamedMacroOptionPattern{'relaxed'};
    $LetterPattern=$NamedLetterPattern{'relaxed'};
  }
  elsif ($arg eq '-restricted') {
    $MacroOptionPattern=$NamedMacroOptionPattern{'restricted'};
    $LetterPattern=$NamedLetterPattern{'restricted'};
  }
  else {return 0;}
  return 1;
}

# Parse count and summation options
sub parse_options_counts {
  my $arg=shift @_;
  if    ($arg =~/^-sum(=(.+))?$/) {_option_sum($2);}
  elsif ($arg =~/^-nosum/) {@sumweights=();}
  elsif ($arg =~/^-(sub|subcounts?)(=(.+))?$/) {_option_subcount($3);}
  elsif ($arg =~/^-(nosub|nosubcounts?)/) {$showsubcounts=0;}
  elsif ($arg eq '-freq') {$optionWordFreq=1;}
  elsif ($arg =~/^-freq=(\d+)$/) {$optionWordFreq=$1;}
  elsif ($arg eq '-stat') {$optionWordClassFreq=1;}
  else {return 0;}
  return 1;
}

# Apply sum option
sub _option_sum {
  my $arg=shift @_;
  if (!defined $arg) {
    @sumweights=(1,1,1,0,0,1,1);
  } elsif ($arg=~/^(\d+(\.\d*)?(,\d+(\.\d*)?){0,6})$/) {
    @sumweights=split(',',$1);
  } else {
    print STDERR "Warning: Option value ".$arg." not valid, ignoring option.\n";
  }
}

# Apply subcount options
sub _option_subcount {
  my $arg=shift @_;
  $showsubcounts=2;
  if (!defined $arg) {
    %BreakPoints=%{$BreakPointsOptions{'default'}};
  } elsif (my $option=$BreakPointsOptions{$arg}) {
    %BreakPoints=%{$option};
  } else {
    print STDERR "Warning: Option value ".$arg." not valid, using default instead.\n";
    %BreakPoints=%{$BreakPointsOptions{'default'}};
  }
}

# Parse output and verbosity options
sub parse_options_output {
  my $arg=shift @_;
  if    ($arg eq '-strict') {$strictness=1;}
  elsif ($arg eq '-v0') {$verbose=0;}
  elsif ($arg eq '-v1') {$verbose=1;}
  elsif ($arg eq '-v2') {$verbose=2;}
  elsif ($arg eq '-v3' || $arg eq '-v') {$verbose=3;}
  elsif ($arg eq '-v4') {$verbose=3; $showstates=1;}
  elsif ($arg =~/^-showstates?$/ ) {$showstates=1;}
  elsif ($arg =~/^-(q|quiet)$/ ) {$verbose=-1;}
  elsif ($arg =~/^-(template)=(.*)$/ ) {_set_output_template($2);}
  elsif ($arg eq '-split') {$optionFast=1;}
  elsif ($arg eq '-nosplit') {$optionFast=0;}
  elsif ($arg eq '-showver') {$showVersion=1;}
  elsif ($arg eq '-nover') {$showVersion=-1;}
  elsif ($arg =~/^-nosep(s|arators?)?$/ ) {$separator='';}
  elsif ($arg =~/^-sep(arators?)?=(.*)$/ ) {$separator=$2;}
  else {return 0;}
  return 1;
}

# Set output template
sub _set_output_template {
  my $template=shift @_;
  $outputtemplate=$template;
  if ($template=~/\{(S|SUM)[\?\}]/i && !@sumweights) {
    @sumweights=(1,1,1,0,0,1,1);
  }
  if ($template=~/\{SUB\?/i && !$showsubcounts) {
    _option_subcount();
  }
}

# Parse output formating options
sub parse_options_format {
  my $arg=shift @_;
  if    ($arg eq '-brief') {$briefsum=1;}
  elsif ($arg eq '-total') {$totalflag=1;}
  elsif ($arg eq '-0') {$briefsum=1;$totalflag=1;$verbose=-1;$finalLineBreak=0;}
  elsif ($arg eq '-1') {$briefsum=1;$totalflag=1;$verbose=-1;}
  elsif ($arg eq '-html' ) {option_ansi_colours(0);$htmlstyle = 2;}
  elsif ($arg eq '-htmlcore' ) {option_ansi_colours(0);$htmlstyle = 1;}
  elsif ($arg =~/^\-(nocol|nc$)/) {option_ansi_colours(0);}
  elsif ($arg =~/^\-(col)$/) {option_ansi_colours(1);}
  elsif ($arg eq '-codes') {$showcodes=2;}
  elsif ($arg eq '-nocodes') {$showcodes=0;}
  else {return 0;}
  return 1;
}

# Include options from option file
sub _parse_optionfile {
  my $filename=shift @_;
  open(FH,"<",$filename)
    || die "Option file not found: ".$filename."\n";
  my @options=<FH>;
  close(FH);
  s/^\s*(#.*|)//s for @options;
  my $text=join('',@options);
  $text=~s/(\n|\r|\r\n)\s*\\//g;
  @options=split("\n",$text);
  foreach my $arg (@options) {
    __optionfile_tc($arg)
      || parse_option($arg)
      || die "Invalid option ".$arg." in ".$filename."\n";
  }
}

# Parse option file TC options
sub __optionfile_tc {
  my $arg=shift @_;
  $arg=~s/^\%\s*// || return 0;
  if ($arg=~/^subst\s+(\\\w+)\s+/i) {
    $substitutions{$1}=$';
  } elsif ($arg=~/^(\w+)\s+([\\]*\w+)\s+([^\s\n]+)(\s+([0-9]+))?/i) {
    tc_macro_param_option($1,$2,$3,$5) || die "Invalid TC option: ".$arg."\n";
  } else {
    print "Invalid TC option format: ".$arg."\n";
    return 0;
  }
  return 1;
}

# Parse file list and return total count
sub Parse_file_list {
  my @files=@_;
  my $listtotalcount=new_count("Total");
  foreach (@files) {s/\\/\//g; s/ /\\ /g;}
 if (@files) {
   @files=<@files>; # For the sake of Windows: expand wildcards!
    for my $file (@files) {
      my $filetotalcount=parse_file($file);
      add_to_total($listtotalcount,$filetotalcount);
    }
  }
  if ($fileFromSTDIN) {
    my $filetotalcount=parse_file($_STDIN_);
    add_to_total($listtotalcount,$filetotalcount);
 }
  return $listtotalcount;
}

# Parse file and included files, and return total count
sub parse_file {
  my $file=shift @_;
  $workdir=$globalworkdir;
  if (!defined $workdir) {
    $workdir=$file;
    $workdir =~ s/^((.*[\\\/])?)[^\\\/]+$/$1/;
  }
  if ($htmlstyle && ($verbose || !$totalflag)) {print "\n<div class='filegroup'>\n";}
  my $filetotalcount=new_count("File(s) total: ".$file);
  @filelist=();
  _add_file($filetotalcount,$file);
  foreach my $f (@filelist) {
    _add_file($filetotalcount,$f,"Included file: ".$f);
  }
  if (!$totalflag && get_count($filetotalcount,$CNT_FILE)>1) {
    if ($htmlstyle) {formatprint("Sum of files: ".$file."\n",'h2');}
    print_count($filetotalcount,'sumcount');
  }
  if ($htmlstyle && ($verbose || !$totalflag)) {print "</div>\n\n";}
  return $filetotalcount;
}

# Parse single file, included files will be appended to @filelist.
sub _add_file {
  my ($filetotalcount,$f,$title)=@_;
  my $tex=TeXfile($f,$title);
  my $fpath=$f;
  $fpath=~s/^((.*[\\\/])?)[^\\\/]+$/$1/;
  if (!defined $tex) {
    error($Main,'File not found or not readable: '.$f);
  } else {
    parse($tex);
    my $filecount=next_subcount($tex);
    if (!$totalflag) {print_count($filecount);}
    add_to_total($filetotalcount,$filecount);
  }
}

######
###### Subroutines
######

###### CMD specific implementations


# Add file to list of files scheduled for parsing
sub include_file {
  my ($tex,$fname)=@_;
  my $fpath=$workdir.$fname;
  if ($includeTeX==2) {
    my $bincode=read_binary($fpath) || BLOCK {
      error($tex,"File $fpath not found.");
      return;
    };
    flush_next($tex);
    line_return(0,$tex);
    prepend_code($tex,$bincode,$fname);
  } else {
    push @filelist,$fpath;
  }
}

# Print count (total) if conditions are met
sub conditional_print_total {
  my $sumcount=shift @_;
  if ($totalflag || number_of_subcounts($sumcount)>1) {
    if ($totalflag && $briefsum && @sumweights) {
      print get_sum_count($sumcount),"\n";
    } else {
      if ($htmlstyle) {formatprint("Total word count",'h2');}
      print_count($sumcount,'sumcount');
    }
  }
}

# Set or unset use of ANSI colours
sub option_ansi_colours {
  my $flag=shift @_;
  $ENV{'ANSI_COLORS_DISABLED'} = $flag?undef:1;
}

# Print text using ANSI colours
sub ansiprint {
  my ($text,$colour)=@_;
  print Term::ANSIColor::colored($text,$colour);
}

###### Option handling


# Apply options to set values
sub Apply_Options {
  if ($showcodes>1 && $verbose<1) {$verbose=3;}
  %STYLE=%{$STYLES[$verbose]};
  if (defined $encoding && $encoding eq 'guess') {$encoding=undef;}
  if (!defined $encoding) {
  } elsif (ref(find_encoding($encoding))) {
    if (!$htmlstyle) {$outputEncoding=$encoding;}
  } else {
    error($Main,"Unknown encoding $encoding ignored.");
    error_details($Main,'Valid encodings are: '.wrap('','',join(', ',Encode->encodings(':all'))));
    $encoding=undef;
  }
  if (!defined $outputEncoding) {$outputEncoding='utf8';}
  binmode STDIN;
  binmode STDOUT,':encoding('.$outputEncoding.')';
  if ($htmlstyle>1) {html_head();}
  flush_errorbuffer($Main);
  apply_language_options();
  if ($includeBibliography) {apply_include_bibliography();}
}

# Set or add scripts to array of scripts
sub set_script_options {
  my ($scriptset,$str)=@_;
  if ($str=~s/^\+//) {} else {splice(@$scriptset,0,scalar $scriptset);}
  my @scripts=split(/[+,]/,$str);
  foreach my $scr (@scripts) {
    $scr=~tr/_/ /;
    if ($scr eq 'Alphabetic') {
      warning($Main,'Using alphabetic instead of Unicode class Alphabetic');
      $scr='alphabetic';
    }
    if ($scr=~/^[a-z]/) {$scr='Is_'.$scr;}
    if (is_property_valid($scr)) {push @$scriptset,$scr;}
    else {error($Main,"Unknown script $scr ignored.");}
  }
}

sub is_property_valid {
  my $script=shift @_;
  eval {' '=~/\p{$script}/};
  if ($@) {return 0;} else {return 1;}
}

# Set language option, return language if applied, undef if not
sub set_language_option {
  my $language=shift @_;
  if ($language=~/^(count\-?)all$/) {
    @AlphabetScripts=qw/Digit Is_alphabetic/;
    @LogogramScripts=qw/Ideographic Katakana Hiragana Thai Lao Hangul/;
  } elsif ($language=~/^words(-?only)?$/) {
    @LogogramScripts=();
  } elsif ($language=~/^(ch|chinese|zhongwen)(-?only)?$/) {
    @LogogramScripts=qw/Han/;
    if (defined $2) {$LetterPattern=undef;}
    @encodingGuessOrder=@{$NamedEncodingGuessOrder{'chinese'}};
    return 'chinese';
  } elsif ($language=~/^(jp|japanese)(-?only)?$/) {
    @LogogramScripts=qw/Han Hiragana Katakana/;
    if (defined $2) {$LetterPattern=undef;}
    @encodingGuessOrder=@{$NamedEncodingGuessOrder{'japanese'}};
    return 'japanese';
  } elsif ($language=~/^(kr|korean)(-?only)?$/) {
    @LogogramScripts=qw/Han Hangul/;
    if (defined $2) {$LetterPattern=undef;}
    @encodingGuessOrder=@{$NamedEncodingGuessOrder{'korean'}};
    return 'korean';
  } elsif ($language=~/^(kr|korean)-?words?(-?only)?$/) {
    if (defined $2) {
      @AlphabetScripts=qw/Hangul/;
      @LogogramScripts=qw/Han/;
    } else {
      @AlphabetScripts=qw/Digit Is_alphabetic Hangul/;
      @LogogramScripts=qw/Han Katakana Hiragana Thai Lao/;
    }
    @encodingGuessOrder=@{$NamedEncodingGuessOrder{'korean'}};
    return 'korean-words';
  } elsif ($language=~/^(char|character|letter)s?(-?only)?$/) {
    @WordPatterns=($NamedWordPattern{'letters'});
    if (defined $2) {@LogogramScripts=();}
    $countlabel[1]='Letters in text';
    $countlabel[2]='Letters in headers';
    $countlabel[3]='Letters in captions';
    return 'letter';
  } else {
    return undef;
  }
}

# Apply language options
sub apply_language_options {
  my @tmp;
  if (defined $LetterPattern && @AlphabetScripts && scalar @AlphabetScripts>0) {
    @tmp=@AlphabetScripts;
    foreach (@tmp) {$_='\\p{'.$_.'}';}
    my $letterchars='['.join('',@tmp).']';
    my $letter=$LetterPattern;
    $letter=~s/@/$letterchars/g;
    @WordPatterns=map { s/\@/$letter/g ; qr/$_/ } @WordPatterns;
  } else {
    @WordPatterns=();
  }
  if (@LogogramScripts && scalar @LogogramScripts>0) {
    @tmp=@LogogramScripts;
    foreach (@tmp) {$_='\\p{'.$_.'}';}
    push @WordPatterns,'['.join('',@tmp).']';
  }
  if (scalar @WordPatterns==0) {
    error($Main,'No script (alphabets or logograms) defined. Using fallback mode.');
    push @WordPatterns,'\\w+';
  }
  $WordPattern=join '|',@WordPatterns;
}

# Apply incbib rule
sub apply_include_bibliography {
  include_package('%incbib');
}

# Process package inclusion
sub include_package {
  my $incpackage=shift @_;
  my $sub;
  _add_to_hash_if_exists(\%TeXmacro,\%PackageTeXmacro,$incpackage);
  _add_to_hash_if_exists(\%TeXmacroword,\%PackageTeXmacroword,$incpackage);
  _add_to_hash_if_exists(\%TeXheader,\%PackageTeXheader,$incpackage);
  _add_to_hash_if_exists(\%TeXgroup,\%PackageTeXgroup,$incpackage);
  _add_to_hash_if_exists(\%TeXfileinclude,\%PackageTeXfileinclude,$incpackage);
}

# Add package rules if defined
sub _add_to_hash_if_exists {
  my ($target,$source,$name)=@_;
  my $sub;
  if ($sub=$source->{$name}) {
    while (my ($key,$val)=each(%$sub)) {
      $target->{$key}=$val;
    }
  }
}

# Process TC instruction
sub tc_macro_param_option {
  my ($instr,$macro,$param,$option)=@_;
  if ($param=~/^\[([0-9,]+)\]$/) {$param=[split(',',$1)];}
  if (!defined $option) {$option=1;}
  if (($instr eq 'macro') || ($instr eq 'exclude')) {$TeXmacro{$macro}=$param;}
  elsif ($instr eq 'header') {$TeXheader{$macro}=$param;$TeXmacro{$macro}=$param;}
  elsif ($instr eq 'macroword') {$TeXmacroword{$macro}=$param;}
  elsif ($instr eq 'preambleinclude') {$TeXpreamble{$macro}=$param;}
  elsif ($instr eq 'group') {
    $TeXmacro{'begin'.$macro}=$param;
    $TeXgroup{$macro}=$option;
  }
  elsif ($instr eq 'floatinclude') {$TeXfloatinc{$macro}=$param;}
  elsif ($instr eq 'fileinclude') {$TeXfileinclude{$macro}=$param;}
  elsif ($instr eq 'breakmacro') {$BreakPoints{$macro}=$param;}
  else {return 0;}
  return 1;
}


###### TeX code handle



# Return object capable of capturing errors for use when
# no TeXcode object is available.
sub getMain {
  my %main=();
  $main{'errorcount'}=0;
  $main{'errorbuffer'}=[];
  $main{'warnings'}={};
  return \%main;
}


## Make TeX handle for LaTeX code: the main TeXcount object
# The "TeX object" is a data containser: a hash containing
#  - filename: name of LaTeX file being parsed
#  - filepath: path to LaTeX file
#  - countsum: count object with total count (incl. subcounts)
#  - subcount: count object for subcount (to be added to countsum)
#  - subcounts: list of subcounts
# plus following elements used for the processing the LaTeX code 
#  - line: the LaTeX paragraph being processed
#  - texcode: what remains of LaTeX code to process (after line)
#  - texlength: length of LaTeX code
#  - next: the next token, i.e. the one being processed
#  - type: the type of the next token
#  - style: the present output style (for verbose output)
#  - printstate: present parsing state (for verbose output only)
#  - eof: set once the end of the input is reached
# which are passed to methods by passing the TeX object. It is used when parsing
# the LaTeX code, and discarded once the parsing is done. During parsing, counts
# are added to the subcount element; whenever a break point is encountered, the
# subcount is added to the countsum (next_subcount) and a new subcount object
# prepared. Note that this requires that the last subcount object be added to
# the countsum once the end of the document is reached.
sub TeXcode {
  my ($bincode,$filename,$title)=@_;
  my $tex=_TeXcode_blank($filename,$title);
  _TeXcode_setcode($tex,$bincode);
  more_texcode($tex);
  return $tex;
}

# Return a blank TeXcode object
sub _TeXcode_blank {
  my ($filename,$title)=@_;
  if (defined $title) {}
  elsif (defined $filename) {$title="File: ".$filename;}
  else {$title="Word count";}
  my %TeX=();
  $TeX{'errorcount'}=0;
  $TeX{'filename'}=$filename;
  if (!defined $filename) {$TeX{'filepath'}='';}
  elsif ($filename=~/^(.*[\\\/])[^\\\/]+$/) {$TeX{'filepath'}=$1;}
  else {$TeX{'filepath'}='';}
  $TeX{'line'}='';
  $TeX{'next'}=undef;
  $TeX{'type'}=undef;
  $TeX{'style'}=undef;
  $TeX{'printstate'}=undef;
  $TeX{'eof'}=0;
  my $countsum=new_count($title);
  $TeX{'countsum'}=$countsum;
  $countsum->{'TeXcode'}=\%TeX;
  my $count=new_count("_top_");
  $TeX{'subcount'}=$count;
  inc_count(\%TeX,$CNT_FILE);
  my @countlist=();
  $countsum->{'subcounts'}=\@countlist;
  return \%TeX;
}

# Set the texcode element of the TeXcount object
sub _TeXcode_setcode {
  my ($tex,$bincode)=@_;
  $tex->{'texcode'}=_prepare_texcode($tex,$bincode);
  $tex->{'texlength'}=length($tex->{'texcode'});
  # TODO: Comment out this test
  if ($tex->{'texcode'} =~ /([[:^ascii:]])/) {warning($tex,"Code contains non-ASCII characters.");}
}

# Decode and return TeX/LaTeX code
sub _prepare_texcode {
  my ($tex,$texcode)=@_;
  $texcode=_decode_texcode($tex,$texcode);
  foreach my $key (keys %substitutions) {
    my $value=$substitutions{$key};
    $texcode=~s/(\w)\Q$key\E/$1 $value/g;
    $texcode=~s/\Q$key\E/$value/g;
  }
  return $texcode;
}

# Return text decoder
sub _decode_texcode {
  my ($tex,$texcode)=@_;
  my $decoder;
  if (defined $encoding) {
    $decoder=find_encoding($encoding);
    eval {
      $texcode=$decoder->decode($texcode);
    };
    if ($@) {
      error($tex,'Decoding file/text using the '.$decoder->name.' encoding failed.');
    }
  } else {
    ($texcode,$decoder)=_guess_encoding($texcode);
    if (!ref($decoder)) {
      error($tex,'Failed to identify encoding or incorrect encoding specified.');
      $tex->{'encoding'}='[FAILED]';
      return $texcode;
    }
  }
  __set_encoding_name($tex,$decoder->name);
  $texcode =~ s/^\x{feff}//; # Remove BOM (relevant for UTF only)
  if ($texcode =~/\x{fffd}/ ) {
    error($tex,'File/text was not valid '.$decoder->name.' encoded.');
  }
  return $texcode;
}

# Guess the right encoding to use
sub _guess_encoding {
  my ($texcode)=@_;
  foreach my $enc (@encodingGuessOrder) {
    my $dec=find_encoding($enc);
    if (ref($dec)) {
      eval {
        $texcode=$dec->decode($texcode,Encode::FB_CROAK)
      };
      if (!$@) {return $texcode,$dec;}
    }
  }
  return $texcode,undef;
}

# Set name of current encoding
sub __set_encoding_name {
  my ($tex,$enc)=@_;
  my $cur=$tex->{'encoding'};
  if (!defined $enc) {$enc='[FAILED]';} # Shouldn't happen here though...
  if (!defined $cur) {}
  elsif ($enc eq 'ascii') {$enc=$cur;}
  elsif ($cur eq 'ascii') {}
  elsif ($cur ne $enc) {
    error($tex,"Mismatching encodings: $cur versus $enc.");
  }
  $tex->{'encoding'}=$enc;
}

# Apply substitution rule
sub apply_substitution_rule {
  my ($tex,$from,$to)=@_;
  $tex->{'line'}=~s/(\w)\Q$from\E\b\s*/$1 $to/g;
  $tex->{'line'}=~s/\Q$from\E\b\s*/$to/g;
  $tex->{'texcode'}=~s/(\w)\Q$from\E\b\s*/$1 $to/g;
  $tex->{'texcode'}=~s/\Q$from\E\b\s*/$to/g;
}

## Get more TeX code from texcode buffer if possible, return 1 if done
sub more_texcode {
  my ($tex)=@_;
  if (!defined $tex->{'texcode'}) {return 0;}
  if ( $optionFast && $tex->{'texcode'} =~ s/^.*?(\r{2,}|\n{2,}|(\r\n){2,})//s ) {
    $tex->{'line'}.=$&;
    return 1;
  }
  $tex->{'line'}.=$tex->{'texcode'};
  $tex->{'texcode'}=undef;
  return 1;
}

## Prepend LaTeX code to TeXcode object
sub prepend_code {
  my ($tex,$code,$fname)=@_;
  my $prefix="\n% --- Start of included file ".$fname."\n";
  my $suffix="\n% --- End of included file ".$fname."\n";
  $code=_decode_texcode($tex,$code);
  $tex->{'length'}+=length($code);
  $tex->{'texcode'}=$prefix.$code.$suffix.$tex->{'line'}.$tex->{'texcode'};
  $tex->{'line'}='';
  more_texcode();
}

## Returns size of TeX code in bytes
sub get_texsize {
  my $tex=shift @_;
  return $tex->{'texlength'}
}


###### TeX file reader


# Read LaTeX file into TeX object
sub TeXfile {
  my ($filename,$title)=@_;
  if ($filename eq $_STDIN_) {
    if ($verbose>0) {
      formatprint("File from STDIN\n",'h2');
      $blankline=0;
    }
   return TeXcode(_read_stdin(),'STDIN',$title);
 } else {
    my $bincode=read_binary($filename) || return undef;
    if ($verbose>0) {
      formatprint("File: ".$filename."\n",'h2');
      $blankline=0;
    }
    return TeXcode($bincode,$filename,$title);
  }
}

# Read file to string without regard for encoding
sub read_binary {
  my $filename=shift @_;
  open(FH,$filename) || return undef;
  binmode(FH);
  my $bincode;
  read(FH,$bincode,-s FH);
  close(FH);
  return $bincode;
}

# Read file from STDIN
sub _read_stdin {
  my @text=<STDIN>;
  my $latexcode=join('',@text);
  return $latexcode;
}

###### Error handling


# Add warning to list of registered warnings (optionally to be reported at the end)
sub warning {
  my ($tex,$text)=@_;
  $tex->{'warnings'}->{$text}++;
  $warnings{$text}++;
}

# Register error and print error message
sub error {
  my ($tex,$text,$type)=@_;
  if (defined $type) {$text=$type.': '.$text;}
  $errorcount++;
  $tex->{'errorcount'}++;
  #print STDERR $text,"\n";
  if (my $err=$tex->{'errorbuffer'}) {push @$err,$text;}
  if ($verbose>=0) {_print_error($text);}
}

# Print error details
sub error_details {
  my ($tex,$text)=@_;
  print STDERR $text,"\n";
}

###### Parsing routines


# Parse LaTeX document
sub parse {
  my ($tex)=@_;
  if ($htmlstyle && $verbose) {print "<div class='parse'><p>\n";}
  while (!($tex->{'eof'})) {
    _parse_unit($tex,$STATUS_TEXT);
  }
  if ($htmlstyle && $verbose) {print "</p></div>\n";}
}

# Parse one block or unit
sub _parse_unit {
  # Status:
  #    0 = exclude from count
  #    1 = text
  #    2 = header text
  #    3 = float text
  #   -1 = float (exclude)
  #   -2 = strong exclude, ignore begin-end groups
  #   -3 = stronger exclude, do not parse macro parameters
  #   -4 = ignore everything except end marker: even {
  #   -9 = preamble (between \documentclass and \begin{document})
  my ($tex,$status,$end)=@_;
  if (!defined $status) {
    error($tex,'Undefined parser status!','CRITICAL ERROR');
    exit;
  } elsif (ref($status) eq 'ARRAY') {
    error($tex,'Invalid parser status!','CRITICAL ERROR');
    exit;
  }
  if ($showstates) {
    if (defined $end) {
      $tex->{'printstate'}=':'.status_to_text($status).':'.$end.':';
    } else {
      $tex->{'printstate'}=':'.status_to_text($status).':';
    }
    flush_next($tex);
  }
  while (defined (my $next=_next_token($tex))) {
    # Parse next token until token matches $end
    set_style($tex,"ignore");
    if ((defined $end) && ($end eq $next)) {return;}
    # Determine how token should be interpreted
    if ($status==$STATUS_PREAMBLE && $next eq '\begin' && $tex->{'line'}=~/^\{\s*document\s*\}/) {
      # \begin{document}
      $status=$STATUS_TEXT;
    }
    if ($status==$STATUS_EXCLUDE_ALL) {
      # Ignore everything
    } elsif ($tex->{'type'}==$TOKEN_SPACE) {
      # space or other code that should be passed through without styling
      flush_next($tex,' ');
    } elsif ($next eq '\documentclass') {
      # starts preamble
      set_style($tex,'document');
      __gobble_option($tex);
      __gobble_macro_parms($tex,1);
      while (!($tex->{'eof'})) {
       _parse_unit($tex,$STATUS_PREAMBLE);
      }
    } elsif ($tex->{'type'}==$TOKEN_TC) {
      # parse TC instructions
      _parse_tc($tex,$next);
    } elsif ($tex->{'type'}==$TOKEN_WORD) {
      # word
      if (my $cnt=status_text_cnt($status)) {
        _process_word($tex,$next,$status);
        inc_count($tex,$cnt);
        set_style($tex,status_to_style($status));
      }
    } elsif ($next eq '{') {
      # {...}
      _parse_unit($tex,$status,'}');
    } elsif ($next eq '}') {
      error($tex,'Encountered } without corresponding {.');
    } elsif ($tex->{'type'}==$TOKEN_MACRO && $status==$STATUS_EXCLUDE_STRONGER) {
      # ignore macro call
      set_style($tex,'ignore');
    } elsif ($tex->{'type'}==$TOKEN_MACRO) {
      # macro call
      _parse_macro($tex,$next,$status);
    } elsif ($next eq '$') {
      # math inline
      _parse_math($tex,$status,$CNT_COUNT_INLINEMATH,'$');
    } elsif ($next eq '$$') {
      # math display (unless already in inlined math)
      if (!(defined $end && $end eq '$')) {
        _parse_math($tex,$status,$CNT_COUNT_DISPLAYMATH,'$$');
      }
    }
    if (!defined $end) {return;}
  }
  if (defined $end) {
    error($tex,'Reached end of file while waiting for '.$end.'.');
  }
}

# Process word with a given status (>0, i.e. counted)
sub _process_word {
  my ($tex,$word,$status)=@_;
  $WordFreq{$word}++;
}

# Parse unit when next token is a macro
sub _parse_macro {
  my ($tex,$next,$status)=@_;
  # substat = parameter status settings
  my $substat;
  if (my $label=$BreakPoints{$next}) {
    if ($tex->{'line'}=~ /^[*]?(\s*\[.*?\])*\s*\{((.|\{.*\})*)\}/ ) {
      $label=$label.': '.$2;
    }
    next_subcount($tex,$label);
  }
  set_style($tex,status_is_text($status)?'command':'exclcommand');
  if ($next eq '\begin' && status_inc_envir($status)) {
    _parse_begin_end($tex,$status);
  } elsif ($next eq '\end' && status_inc_envir($status)) {
    error($tex,'Encountered \end without corresponding \begin');
  } elsif ($next eq '\verb') {
    _parse_verb_region($tex,$status);
  } elsif ( (status_is_text($status) || $status==$STATUS_PREAMBLE)
           && defined ($substat=$TeXpackageinc{$next}) ) {
    _parse_include_package($tex,$substat);
  } elsif (($status==$STATUS_FLOAT) && ($substat=$TeXfloatinc{$next})) {
    # text included from float
    set_style($tex,'command');
    __gobble_macro_parms($tex,$substat);
  } elsif ($status==$STATUS_PREAMBLE && defined ($substat=$TeXpreamble{$next})) {
   # parse preamble include macros
    set_style($tex,'command');
   if (defined $TeXheader{$next}) {inc_count($tex,$CNT_COUNT_HEADER);}
    __gobble_macro_parms($tex,$substat,1);
  } elsif (status_is_exclude($status)) {
   # ignore
    __gobble_option($tex);
  } elsif ($next eq '\(') {
    # math inline
    _parse_math($tex,$status,$CNT_COUNT_INLINEMATH,'\)');
  } elsif ($next eq '\[') {
    # math display
    _parse_math($tex,$status,$CNT_COUNT_DISPLAYMATH,'\]');
  } elsif ($next eq '\def') {
    # ignore \def...
    $tex->{'line'} =~ s/^([^\{]*)\{/\{/;
    flush_next($tex);
    print_style($1,'ignore');
    _parse_unit($tex,$STATUS_EXCLUDE_STRONG);
  } elsif (defined (my $addsuffix=$TeXfileinclude{$next})) {
   # include file: queue up for parsing
    _parse_include_file($tex,$status,$addsuffix);
  } elsif (defined ($substat=$TeXmacro{$next})) {
    # macro: exclude options
    if (defined $TeXheader{$next}) {inc_count($tex,$CNT_COUNT_HEADER);}
    __count_macroword($tex,$next,$status);
    __gobble_macro_parms($tex,$substat,$status);
  } elsif (defined __count_macroword($tex,$next,$status)) {
    # count macro as word (or a given number of words)
    set_style($tex,'word'.$status);
  } elsif ($next =~ /^\\[^\w\_]/) {
  } else {
    __gobble_option($tex);
  }
}

# Parse TC instruction
sub _parse_tc {
  my ($tex,$next)=@_;
  set_style($tex,'tc');
  flush_next($tex);
  $next=~s/^\%+TC:\s*(\w+)\s*//i || BLOCK {
    error($tex,'TC command should have format %TC:instruction [macro] [parameters]');
    return;
  };
  my $instr=$1;
  $instr=~tr/[A-Z]/[a-z]/;
  if ($instr=~/^(break)$/) {
    if ($instr eq 'break') {next_subcount($tex,$next);}
  } elsif ($instr=~/^(incbib|includebibliography)$/) {
    $includeBibliography=1;
    apply_include_bibliography();
  } elsif ($instr eq 'ignore') {
    __gobble_tc_ignore($tex);
  } elsif ($instr eq 'endignore') {
    error($tex,'TC:endignore without corresponding TC:ignore.');
  } elsif ($instr eq 'newtemplate') {$outputtemplate='';
  } elsif ($instr eq 'template') {$outputtemplate.=$next;
  } elsif ($instr eq 'subst') {
    if ($next=~/^(\\\S+)\s+/) {
      my $from=$1;
      my $to=$';
      $substitutions{$from}=$to;
      apply_substitution_rule($tex,$from,$to);
    } else {
      error($tex,'Invalid TC:subst format.');
    }
  } elsif ($next=~/^([\\]*\S+)\s+([^\s\n]+)(\s+(-?[0-9]+))?/) {
    # Format = TC:word macro
    my $macro=$1;
    my $param=$2;
    my $option=$4;
    if (tc_macro_param_option($instr,$macro,$param,$option)) {}
    else {error($tex,'Unknown TC command: '.$instr);}
  } else {
    error($tex,'Invalid TC command format: '.$instr);
  }
}

# Parse through ignored LaTeX code
sub __gobble_tc_ignore {
  my ($tex)=@_;
  set_style($tex,'ignore');
  _parse_unit($tex,$STATUS_EXCLUDE_ALL,'%TC:endignore');
  set_style($tex,'tc');
  flush_next($tex);
}

# Parse math formulae
sub _parse_math {
  my ($tex,$status,$cnt,$end)=@_;
  my $localstyle;
  if (status_is_text($status)) {
    $localstyle='mathgroup';
    inc_count($tex,$cnt);
  } else {
    $localstyle='exclmath';
  }
  set_style($tex,$localstyle);
  _parse_unit($tex,$STATUS_IGNORE,$end);
  set_style($tex,$localstyle);
}

# Parse \verb region
sub _parse_verb_region {
 my ($tex,$status)=@_;
 flush_next($tex);
 set_style($tex,'ignore');
 if (!($tex->{'line'} =~ s/^[^\s]// )) {
  error($tex,'Invalid \verb: delimiter required.');
 }
 my $dlm=$&;
 print_style($dlm,'command');
 if (!($tex->{'line'} =~ s/^([^$dlm]*)($dlm)// )) {
  error($tex,'Invalid \verb: could not find ending delimiter ('.$dlm.').');
 }
 print_style($1,'ignore');
 print_style($2,'command');
}

# Parse begin-end group
sub _parse_begin_end {
  my ($tex,$status)=@_;
  my $localstyle=status_is_text($status) ? 'grouping' : 'exclgroup';
  flush_next_gobble_space($tex,$localstyle,$status);
  #__gobble_option($tex); # no option before group name
  my ($groupname,$next);
  if ($tex->{'line'} =~ s/^\{([^\{\}\s]+)\}[ \t\r\f]*//) {
    # gobble group type
    $groupname=$1;
    print_style('{'.$1.'}',$localstyle);
    $next='begin'.$groupname;
    if (defined (my $substat=$TeXmacro{$next})) {
      __gobble_macro_parms($tex,$substat);
    }
  } else {
    $groupname='???'; $next='???';
    error($tex,'Encountered \begin without environment name provided.');
  }
  # find group status (or leave unchanged)
  my $substat=$TeXgroup{$1};
  if (!defined $substat) {
    $substat=$status;
    if ($strictness>=1) {
      warning($tex,"Using default rule for group ".$groupname);
    }
  } elsif (!status_is_text($status)) {
    # Do not raise status
    $substat=__new_status($substat,$status);
  } elsif ($substat==$STATUS_FLOAT) {
    # Count float
    inc_count($tex,$CNT_COUNT_FLOAT);
  } elsif (my $cnt=status_to_cnt($substat)) {
    # Count as given type (was: if $substat>3)
    inc_count($tex,$cnt);
    $substat=0;
  } else {
    # Use $substat value as given
  }
  if ($includeBibliography && $groupname eq 'thebibliography' && $substat>0) {
    # Add bibliography header
    inc_count($tex,$CNT_COUNT_HEADER);
    __count_macroword($tex,$groupname,$STATUS_TEXT_HEADER);
  }
  if (!status_inc_envir($substat)) {
    # Keep parsing until appropriate end group arrives
    while (!$tex->{'eof'}) {
      _parse_unit($tex,$substat,'\end');
      if ($tex->{'line'} =~ s/^\s*\{$groupname\}[ \t\r\f]*//) {
        # gobble end group parameter
        flush_next($tex,$localstyle,$status);
        print_style($&,$localstyle);
        return;
      }
    }
  } else {
    # Parse until \end arrives, and check that it matches
    _parse_unit($tex,$substat,'\end');
    flush_next_gobble_space($tex,$localstyle,$status);
    if ($tex->{'line'} =~ s/^\{([^\{\}\s]+)\}[ \t\r\f]*//) {
      # gobble group type
      print_style('{'.$1.'}',$localstyle);
      if ($groupname ne $1) {
        error($tex,'Group \begin{'.$groupname.'} ended with end{'.$1.'}.');
      }
    } else {
      error($tex,'Group ended while waiting for \end{'.$groupname.'}.');
    }
  }
}

# Parse and process file inclusion
sub _parse_include_file {
  my ($tex,$status,$addsuffix)=@_;
  if ($addsuffix eq 'bbl') {
    _parse_include_bbl($tex,$status);
    return;
  }
  flush_next($tex);
  $tex->{'line'} =~ s/^\s*\{([^\{\}\s]+)\}//
  || $tex->{'line'} =~ s/^\s*([^\{\}\%\\\s]+)//
  || $tex->{'line'} =~ s/^\s*\{(.+?)\}//
  || BLOCK {
    error($tex,'Failed to read or interpret file name for inclusion.');
    return;
  };
  if (status_is_text($status)) {
    print_style($&,'fileinclude');
    my $fname=$1;
    if ($addsuffix==2) {$fname.='.tex';}
    elsif ($addsuffix==1 && ($fname=~/^[^\.]+$/)) {$fname.='.tex';}
    if ($includeTeX) {include_file($tex,$fname);}
  } else {
    print_style($&,'ignored');
  }
}

# Parse and process bibliography file
sub _parse_include_bbl {
  my ($tex,$status)=@_;
  __gobble_macro_parms($tex,1,$status);
  if (status_is_text($status) && $includeBibliography) {
    my $fname=$tex->{'filename'};
    $fname=~s/\.\w+$/\.bbl/;
    include_file($tex,$fname);
  }
}

# Parse and process package inclusion
sub _parse_include_package {
  my ($tex)=@_;
  set_style($tex,'document');
  __gobble_option($tex);
  if ( $tex->{'line'}=~s/^\{((\w+)(\s*,\s*\w+)*)\}// ) {
    print_style('{'.$1.'}','document');
    foreach (split(/\s*,\s*/,$1)) {
      include_package($_);
    }
  } else {
    _parse_unit($tex,$STATUS_IGNORE);
    error($tex,"Could not recognise package list, ignoring it instead.");
  }
  __gobble_options($tex);
}

# Count macroword using given status
sub __count_macroword {
  my ($tex,$next,$status)=@_;
  my $n=$TeXmacroword{$next};
  if (defined $n && (my $cnt=status_text_cnt($status))) {
    inc_count($tex,$cnt,$n);
  }
  return $n;
}

# Gobble next option, return option or undef if none
sub __gobble_option {
  my $tex=shift @_;
  flush_next_gobble_space($tex);
  if ($tex->{'line'}=~s/^($MacroOptionPattern)//) {
    print_style($1,'option');
    return $1;
  }
  return undef;
}

# Gobble all options
sub __gobble_options {
  while (__gobble_option(@_)) {}
}

# Gobble macro modifyer (e.g. following *)
sub __gobble_macro_modifier {
  my $tex=shift @_;
  flush_next($tex);
  if ($tex->{'line'} =~ s/^\*//) {
    print_style($1,'option');
    return $1;
  }
  return undef;
}

# Gobble macro parameters as specified in parm plus options
sub __gobble_macro_parms {
  my ($tex,$parm,$oldstat)=@_;
  my $n;
  if (ref($parm) eq 'ARRAY') {
    $n=scalar @{$parm};
  } else {
    $n=$parm;
    $parm=[($STATUS_IGNORE)x$n];
  }
  if ($n>0) {__gobble_macro_modifier($tex);}
  __gobble_options($tex);
  for (my $j=0;$j<$n;$j++) {
    _parse_unit($tex,__new_status($parm->[$j],$oldstat));
    __gobble_options($tex);
  }
}

# Return new parsing status given old and substatus
sub __new_status {
  my ($substat,$oldstat)=@_;
  if (!defined $oldstat) {return $substat;}
  foreach my $st (@STATUS_PRIORITY_LIST) {
    if ($oldstat==$st || $substat==$st) {return $st;}
  }
  error($Main,'Could not determine new status in __new_status!','BUG');
  return $oldstat;
}

# Get next token skipping comments and flushing output buffer
sub _next_token {
  my $tex=shift @_;
  my ($next,$type);
  my $style=$tex->{'style'};
  if (defined $tex->{'next'}) {print_style($tex->{'next'},$tex->{'style'});}
  $tex->{'style'}=undef;
  while (defined ($next=__get_next_token($tex))) {
    $type=$tex->{'type'};
    if ($type==$TOKEN_COMMENT) {
      print_style($next,'comment');
    } elsif ($type==$TOKEN_LINEBREAK) {
      if ($verbose>0) {line_return(-1,$tex);}
    } else {
      return $next;
    }
  }
  return $next;
}

# Read, interpret and return next token
sub __get_next_token {
  # Token (or token group) category:
  #   -1: space
  #   0: comment
  #   1: word (or other forms of text or text components)
  #   2: symbol (not word, e.g. punctuation)
  #   3: macro
  #   4: curly braces {}
  #   5: brackets []
  #   6: maths
  #   9: line break in file
  #   999: end of line or blank line
  #   666: TeXcount instruction (%TC:instruction)
  my $tex=shift @_;
  my $next;
  my $ch;
  while (!$tex->{'eof'}) {
    $ch=substr($tex->{'line'},0,1);
    if ($ch eq '') {
      if (!more_texcode($tex)) {$tex->{'eof'}=1;}
      next;
    } elsif ($ch=~/^[ \t\f]/) {
      $tex->{'line'}=~s/^([ \t\f]+)//;
      return __set_token($tex,$1,$TOKEN_SPACE);
    } elsif ($ch eq "\n" || $ch eq "\r") {
      $tex->{'line'}=~s/^(\r\n?|\n)//;
      return __set_token($tex,$1,$TOKEN_LINEBREAK);
    } elsif ($tex->{'line'}=~s/^($WordPattern)//) {
      return __set_token($tex,$1,$TOKEN_WORD);
    } elsif ($ch eq '$') {
      $tex->{'line'}=~s/^(\$\$?)//;
      return __set_token($tex,$1,$TOKEN_MATH);
    } elsif ($ch eq '{' || $ch eq '}') {
      return __get_chtoken($tex,$ch,$TOKEN_BRACE);
    } elsif ($ch eq '[' || $ch eq ']') {
      return __get_chtoken($tex,$ch,$TOKEN_BRACKET);
    } elsif ($ch=~/^['"`:.,()[]!+-*=\/^_@<>~#&]$/) {
      return __get_chtoken($tex,$ch,$TOKEN_SYMBOL);
    } elsif ($ch eq '%') {
      if ($tex->{'line'}=~s/^(\%+TC:\s*endignore\b[^\r\n]*)//i) {
        __set_token($tex,$1,$TOKEN_TC);
        return "%TC:endignore";
      }
      if ($tex->{'line'}=~s/^(\%+[tT][cC]:[^\r\n]*)//) {return __set_token($tex,$1,$TOKEN_TC);}
      if ($tex->{'line'}=~s/^(\%+[^\r\n]*)//) {return __set_token($tex,$1,$TOKEN_COMMENT);}
      return __get_chtoken($tex,$ch,$TOKEN_COMMENT);
    } elsif ($ch eq '\\') {
      if ($tex->{'line'}=~s/^(\\[{}%])//) {return __set_token($tex,$1,$TOKEN_SYMBOL);}
      if ($tex->{'line'}=~s/^(\\([a-zA-Z_]+|[^a-zA-Z_]))//) {return __set_token($tex,$1,$TOKEN_MACRO);}
      return __get_chtoken($tex,$ch,$TOKEN_END);
    } else {
      return __get_chtoken($tex,$ch,$TOKEN_END);
    }
  }
  return undef;
}

# Set next token and its type
sub __set_token {
  my ($tex,$next,$type)=@_;
  $tex->{'next'}=$next;
  $tex->{'type'}=$type;
  return $next;
}

# Set character token and remove from line
sub __get_chtoken {
  my ($tex,$ch,$type)=@_;
  $tex->{'line'}=substr($tex->{'line'},1);
  $tex->{'next'}=$ch;
  $tex->{'type'}=$type;
  return $ch;
}


###### Count handling routines



## Make new count object
# The "count object" is a hash containing
#  - title: the title of the count (name of file, section, ...)
#  - counts: a list of numbers (the counts: files, text words, ...)
# upon creation, but where the element
#  - subcounts: list of count objects (added by the TeX object)
# may exist if the count contains subcounts. The elements of the
# count are (by their index):
#  0 = #files: counts the number of files
#  1 = text words: counts the number of words in the text
#  2 = header words: number of words in headers
#  3 = caption words: number of words in float captions
#  4 = #headers: number of headers
#  5 = #floats: number of tables, figures, floats, etc.
#  6 = #inline formulae: number of math elements in text ($...$)
#  7 = #displayed formulae: number of displayed equations
sub new_count {
  my ($title)=@_;
  my @cnt=(0) x $SIZE_CNT;
  my %count=('counts'=>\@cnt,'title'=>$title);
  # files, text words, header words, float words,
  # headers, floats, math-inline, math-display;
  return \%count;
}

# Increment TeX count for a given count type
sub inc_count {
  my ($tex,$cnt,$value)=@_;
  my $count=$tex->{'subcount'};
  if (!defined $value) {$value=1;}
  ${$count->{'counts'}}[$cnt]+=$value;
}

# Get count value for a given count type
sub get_count {
  my ($count,$cnt)=@_;
  return ${$count->{'counts'}}[$cnt];
}

# Compute sum count for a count object
sub get_sum_count {
  my $count=shift @_;
  my $sum=0;
  for (my $i=scalar(@sumweights);$i-->0;) {
    $sum+=get_count($count,$i+1)*$sumweights[$i];
  }
  return $sum;
}

# Returns the number of subcounts
sub number_of_subcounts {
  my $count=shift @_;
  if (my $subcounts=$count->{'subcounts'}) {
    return scalar(@{$subcounts});
  } else {
    return 0;
  }
}

# Is a null count? (counts 1-7 zero, title starts with _)
sub _count_is_null {
  my $count=shift @_;
  if (!$count->{'title'}=~/^_/) {return 0;}
  for (my $i=1;$i<$SIZE_CNT;$i++) {
    if (get_count($count,$i)>0) {return 0;}
  }
  return 1;
}

# Add one count to another
sub _add_to_count {
  my ($a,$b)=@_;
  for (my $i=0;$i<$SIZE_CNT;$i++) {
   ${$a->{'counts'}}[$i]+=${$b->{'counts'}}[$i];
  }
}

# Add subcount to sum count and prepare new subcount
sub next_subcount {
  my ($tex,$title)=@_;
  add_to_total($tex->{'countsum'},$tex->{'subcount'});
  $tex->{'subcount'}=new_count($title);
  return $tex->{'countsum'};
}

# Add count to total as subcount
sub add_to_total {
  my ($total,$count)=@_;
  _add_to_count($total,$count);
  if (!_count_is_null($count)) {
    push @{$total->{'subcounts'}},$count;
    $count->{'parentcount'}=$total;
  }
}


###### Result output routines


# Close the output, e.g. adding HTML tail
sub Close_Output {
  if ($htmlstyle>1) {
    html_tail();
  }
}

# Report if there were any errors occurring during parsing
sub Report_Errors {
  if (defined $outputtemplate) {return;}
  if ( !$briefsum && !$totalflag && $verbose>=0 ) {
    foreach (keys %warnings) {formatprint($_,"p","nb");print "\n";}
  }
  if ($errorcount==0) {return;}
  if ($briefsum && $totalflag) {print " ";}
  if ($htmlstyle) {
    print "<div class='error'><p>\n";
    print "There were ".$errorcount." error(s) reported!\n";
    print "</p></div>\n";
  } elsif ($briefsum && $totalflag) {
    print "(errors:".$errorcount.")";
  } else {
    print "(errors:".$errorcount.")\n";
  }
}

# Print word frequencies (as text only)
sub print_word_freq {
  my ($word,$wd,$freq,%Freq,%Word,%Class);
  my %regs;
  foreach my $cg (@AlphabetScripts,@LogogramScripts) {
    $regs{$cg}=qr/\p{$cg}/;
  }
  my $sum=0;
  for $word (keys %WordFreq) {
    $wd=lc $word;
    $Freq{$wd}+=$WordFreq{$word};
    $sum+=$WordFreq{$word};
    $Word{$wd}=__lc_merge($word,$Word{$wd});
  }
  if ($htmlstyle) {print "<table class='stat'>\n<thead>\n";}
  __print_word_freq("Word","Freq","th");
  if ($htmlstyle) {print "</thead>\n";}
  if ($optionWordClassFreq>0) {
    for $word (keys %Freq) {$Class{__word_class($word,\%regs)}+=$Freq{$word};}
    __print_sorted_freqs('langstat',\%Class);
  }
  if ($htmlstyle) {print "<tbody class='sumstat'>\n";}
  __print_word_freq("All words",$sum,,'td','sum');
  if ($htmlstyle) {print "</tbody>\n";}
  if ($optionWordFreq>0) {__print_sorted_freqs('wordstat',\%Freq,\%Word,$optionWordFreq);}
  if ($htmlstyle) {print "</table>\n";}
}

# Merge to words which have the same lower case
sub __lc_merge {
  my ($word,$w)=@_;
  if (defined $w) {
    for (my $i=length($word);$i-->0;) {
      if (substr($word,$i,1) ne substr($w,$i,1)) {
        substr($word,$i,1)=lc substr($word,$i,1);
      }
    }
  }
  return $word;
}

# Return the word class based on script groups it contains
sub __word_class {
  my ($wd,$regs)=@_;
  my @classes;
  $wd=~s/\\\w+({})?/\\{}/g;
  foreach my $name (keys %{$regs}) {
    if ($wd=~$regs->{$name}) {push @classes,$name;}
  }
  my $cl=join('+',@classes);
  if ($cl) {}
  elsif ($wd=~/\\/) {$cl='(macro)';}
  else {$cl='(unidentified)';} 
  return $cl;
}

# Print table body containing word frequencies
sub __print_sorted_freqs {
  my ($class,$Freq,$Word,$min)=@_;
  my $sum=0;
  my ($word,$wd,$freq);
  if (!defined $min) {$min=0;}
  if ($htmlstyle) {print "<tbody class='",$class,"'>\n";}
  else {print "---\n";}
  for $wd (sort {$Freq->{$b} <=> $Freq->{$a}} keys %{$Freq}) {
    if (defined $Word) {$word=$Word->{$wd};} else {$word=$wd;}
    $freq=$Freq->{$wd};
    if ($freq>=$min) {
      $sum+=$freq;
      __print_word_freq($word,$freq);
    }
  }
  if ($min>0) {__print_word_freq("Sum of subset",$sum,'td','sum');}
  if ($htmlstyle) {print "</tbody>\n";}
}

# Print one word freq line
sub __print_word_freq {
  my ($word,$freq,$tag,$class)=@_;
  if (!defined $tag) {$tag='td';}
  if (defined $class) {$class=' class=\''.$class.'\'';} else {$class='';}
  if ($htmlstyle) {
    print "<tr",$class,"><",$tag,">",$word,"</",$tag,"><",$tag,">",$freq,"</",$tag,"></tr>\n";
  } else {
    print $word,": ",$freq,"\n";
  }
}

###### Printing routines


# Print text using given style/colour
sub print_with_style {
  my ($text,$style,$colour)=@_;
  if ($style eq ' ') {
    print text_to_print($text);
  } elsif ($style eq '') {
    print text_to_print($text);
    error($Main,'Empty style should not occur in print_with_style!','BUG');
  } elsif ($htmlstyle) {
    print "<span class='$style'>".text_to_print($text).'</span>';
  } else {
    ansiprint(text_to_print($text),$colour);
    if ($style=~/$separatorstyleregex/) {print $separator;}
  }
}

# Prepare text string for print: convert special characters
sub text_to_print {
  my $text=join('',@_);
  if ($htmlstyle) {
    $text=~s/&/&amp;/g;
    $text=~s/</&lt;/g;
    $text=~s/>/&gt;/g;
    $text=~s/[ \t]{2}/\&nbsp; /g;
  }
  return $text;
}

# Print text, using appropriate tags for HTML
sub formatprint {
  my ($text,$tag,$class)=@_;
  my $break=($text=~s/(\r\n?|\n)$//);
  if ($htmlstyle && defined $tag) {
    print '<'.$tag;
    if ($class) {print " class='".$class."'";}
    print '>'.text_to_print($text).'</'.$tag.'>';
  } else {
    print text_to_print($text);
  }
  if ($break) {print "\n";}
}

# Add a line break to output
sub linebreak {
  if ($htmlstyle) {print "<br>\n";} else {print "\n";}
}

###### Routines for printing count summary


# Print count summary for a count object
sub print_count {
  my ($count,$class)=@_;
  if ($htmlstyle) {print "<div class='".($class||'count')."'>\n";}  
  if ($outputtemplate) {
    _print_count_template($count,$outputtemplate);
  } elsif ($briefsum && @sumweights) {
    _print_sum_count($count);
  } elsif ($briefsum) {
    if ($htmlstyle) {print "<p class='count'>";}
    _print_count_brief($count);
    if ($htmlstyle) {print "</p>\n";}
  } else {
    _print_count_details($count);
  }
  if ($htmlstyle) {print "</div>\n";}  
}

# Return count,header,... list filling in header if missing
sub __count_and_header {
  my $count=shift @_;
  my $header=__count_header($count);
  return $count,$header,@_;
}

# Return count title or "" if missing
sub __count_header {
  my $count=shift @_;
  return $count->{'title'}||'';
}

# Print total count (sum) for a given count object
sub _print_sum_count {
  my ($count,$header)=__count_and_header(@_);
  if ($htmlstyle) {print "<p class='count'>".text_to_print($header).": ";}
  print get_sum_count($count);
  if ($htmlstyle) {print "</p>\n";}
  else {print ": ".text_to_print($header);}
  print "\n";
}

# Print brief summary of count object
sub _print_count_brief {
  my ($count,$header,$tag1,$tag2)=__count_and_header(@_);
  my @cnt=@{$count->{'counts'}};
  if ($htmlstyle && $tag1) {print "<".$tag1.">";}
  print $cnt[$CNT_WORDS_TEXT]."+".$cnt[$CNT_WORDS_HEADER]."+".$cnt[$CNT_WORDS_CAPTION].
      " (".$cnt[$CNT_COUNT_HEADER]."/".$cnt[$CNT_COUNT_FLOAT].
		"/".$cnt[$CNT_COUNT_INLINEMATH]."/".$cnt[$CNT_COUNT_DISPLAYMATH].")";
  if ($htmlstyle && $tag2) {
    print "</".$tag1."><".$tag2.">";
    $tag1=$tag2;
  } else {print " ";}
  print text_to_print($header);
  if ($htmlstyle && $tag1) {print "</".$tag1.">";}
  if ($finalLineBreak) {print "\n";}
}

# Print detailed summary of count object
sub _print_count_details {
  my ($count,$header)=__count_and_header(@_);
  if ($htmlstyle) {print "<ul class='count'>\n";}
  if ($header) {formatprint($header."\n",'li','header');}
  if (my $tex=$count->{'TeXcode'}) {
    if (!defined $encoding) {formatprint('Encoding: '.$tex->{'encoding'}."\n",'li');}
  }
  if (@sumweights) {formatprint('Sum count: '.get_sum_count($count)."\n",'li');}
  for (my $i=1;$i<$SIZE_CNT;$i++) {
    formatprint($countlabel[$i].': '.get_count($count,$i)."\n",'li');
  }
  if (get_count($count,$CNT_FILE)>1) {
    formatprint($countlabel[$CNT_FILE].': '.get_count($count,$CNT_FILE)."\n",'li');
  }
  my $subcounts=$count->{'subcounts'};
  if ($showsubcounts && defined $subcounts && scalar(@{$subcounts})>=$showsubcounts) {
    formatprint("Subcounts:\n",'li');
    if ($htmlstyle) {print "<span class='subcount'>\n";}
    formatprint("  text+headers+captions (#headers/#floats/#inlines/#displayed)\n",'li','fielddesc');
    foreach my $subcount (@{$subcounts}) {
      print '  ';
      _print_count_brief($subcount,'li');
    }
    if ($htmlstyle) {print "</span>\n";}
  }
  if ($htmlstyle) {print "</ul>\n";} else {print "\n";}
}

# Print summary of count object using template
sub _print_count_template {
  my ($count,$header,$template)=__count_and_header(@_);
  $template=~s/\\n/\n/g;
  if ($htmlstyle) {$template=~s/\n/<br>/g;}
  my ($subtemplate,$posttemplate);
  while ($template=~/\{SUB\?((.*?)\|)?(.*?)(\|(.*?))?\?SUB\}/is) {
    __print_count_using_template($count,$`);
    if (number_of_subcounts($count)>1) {
      if (defined $2) {print $2;}
      __print_subcounts_using_template($count,$3);
      if (defined $5) {print $5;}
    }
    $template=$';
  }
  __print_count_using_template($count,$template);
}

# Print counts using template
sub __print_count_using_template {
  my ($count,$template)=@_;
  for (my $i=0;$i<$SIZE_CNT;$i++) {
    $template=__process_template($template,$i,get_count($count,$i));
  }
  $template=~s/\{VER\}/$versionnumber/gi;
  # TODO: Should base warnings and errors on TeXcode or Main object
  $template=__process_template($template,"W|WARN|WARNING|WARNINGS",length(%warnings));
  $template=__process_template($template,"E|ERR|ERROR|ERRORS",$errorcount);
  $template=__process_template($template,"S|SUM",get_sum_count($count));
  $template=__process_template($template,"T|TITLE",$count->{'title'}||"");
  $template=__process_template($template,"SUB",number_of_subcounts($count));
  print $template;
}

# Print subcounts using template
sub __print_subcounts_using_template {
  my ($count,$template)=@_;
  my $subcounts=$count->{'subcounts'};
  if ($template && defined $subcounts && scalar(@{$subcounts})>=$showsubcounts) {
    foreach my $subcount (@{$subcounts}) {
      __print_count_using_template($subcount,$template);
    }
  }
}

# Process template for specific label
sub __process_template {
  my ($template,$label,$value)=@_;
  if ($value) {
    $template=~s/\{($label)\?(.*?)(\|(.*?))?\?(\1)\}/$2/gis;
  } else {
    $template=~s/\{($label)\?(.*?)\|(.*?)\?(\1)\}/$3/gis;
    $template=~s/\{($label)\?(.*?)\?(\1)\}//gis;
  }
  if (!defined $value) {$value="";}
  $template=~s/\{($label)\}/$value/gis;
  return $template;
}


###### Routines for printing parsing details


# Print next token
sub flush_next {
  my ($tex,$style)=@_;
  my $ret=undef;
  if (defined $style && $style ne '') {
   set_style($tex,$style);
  }
  if (defined $tex->{'next'}) {
    $ret=print_style($tex->{'next'},$tex->{'style'},$tex->{'printstate'});
  }
  $tex->{'printstate'}=undef;
  $tex->{'style'}='-';
  return $ret;
}

# Print next token and gobble following spaces
sub flush_next_gobble_space {
  my ($tex,$style,$status)=@_;
  my $ret=flush_next($tex,$style);
  if (!defined $ret) {$ret=0;}
  if (!defined $status) {$status=$STATUS_IGNORE;}
  my $prt=($verbose>0);
  if ($tex->{'line'}=~s/^([ \t\f]*)(\r\n?|\n)([ \t\f]*)//) {
    if (!$prt) {
    } elsif ($verbose>2 || $ret) {
      print $1;
      line_return(-1,$tex);
      my $space=$3;
      if ($htmlstyle) {$space=~s/  /\&nbsp;/g;}
      print $space;
    } else {
      line_return(0,$tex);
    }
  } elsif ($tex->{'line'}=~s/^([ \t\f]*)//) {
    if ($prt) {print $1;}
  }
}

# Set presentation style
sub set_style {
  my ($tex,$style)=@_;
  if (!(($tex->{'style'}) && ($tex->{'style'} eq '-')) && $style ne '') {$tex->{'style'}=$style;}
}

# Print text using the given style, and log state if given
sub print_style {
  my ($text,$style,$state)=@_;
  (($verbose>=0) && (defined $text) && (defined $style)) || return 0;
  my $colour;
  ($colour=$STYLE{$style}) || return;
  if (($colour) && !($colour eq '-')) {
    print_with_style($text,$style,$colour);
    if ($state) {print_style($state,'state');}
    if ($style ne "cumsum") {$blankline=-1;}
    return 1;
  } else {
    return 0;
  }
}

# Conditional line return
sub line_return {
  my ($blank,$tex)=@_;
  if ($blank<0 && $verbose<3) {$blank=1;}
  if ($blank<0 || $blank>$blankline) {
    if ((defined $tex) && @sumweights) {
      my $num=get_sum_count($tex->{'subcount'});
      print_style(" [".$num."]","cumsum");
    }
    linebreak();
    $blankline++;
  }
}

# Print error message
sub _print_error {
  my $text=shift @_;
  line_return(1);
  print_style("!!!  ".$text."  !!!",'error');
  line_return(1);
}

# Print errors in buffer and delete errorbuffer
sub flush_errorbuffer {
  my $source=shift @_;
  my $err=$source->{'errorbuffer'} || return;
  foreach (@$err) {_print_error($_);}
  $source->{'errorbuffer'}=undef;
}

###### Print help on style/colour codes


# Print output style codes if conditions are met
sub conditional_print_help_style {
  if ($showcodes) {_print_help_style();}
  return $showcodes;
}

# Print help on output styles
sub _print_help_style {
  if ($verbose<=0) {return;}
  if ($htmlstyle) {print "<div class='stylehelp'><p>";}
  formatprint("Format/colour codes of verbose output:","h2");
  print "\n\n";
  _help_style_line('Text which is counted',"word1","counted as text words");
  _help_style_line('Header and title text',"word2","counted as header words");
  _help_style_line('Caption text and footnotes',"word3","counted as caption words");
  _help_style_line("Ignored text or code","ignore","excluded or ignored");
  _help_style_line('\documentclass',"document","document start, beginning of preamble");
  _help_style_line('\macro',"command","macro not counted, but parameters may be");
  _help_style_line('\macro',"exclcommand","macro in excluded region");
  _help_style_line("[Macro options]","option","not counted");
  _help_style_line('\begin{group}  \end{group}',"grouping","begin/end group");
  _help_style_line('\begin{group}  \end{group}',"exclgroup","begin/end group in excluded region");
  _help_style_line('$  $',"mathgroup","counted as one equation");
  _help_style_line('$  $',"exclmath","equation in excluded region");
  _help_style_line('% Comments',"comment","not counted");
  _help_style_line('%TC:TeXcount instructions',"tc","not counted");
  _help_style_line("File to include","fileinclude","not counted but file may be counted later");
  if ($showstates) {
    _help_style_line('[state]',"state","internal TeXcount state");
  }
  if (@sumweights) {
    _help_style_line('[cumsum]',"cumsum","cumulative sum count");
  }
  _help_style_line("ERROR","error","TeXcount error message");
  if ($htmlstyle) {print "</p></div>";}
  print "\n\n";
}

# Print one line of help
sub _help_style_line {
  my ($text,$style,$comment)=@_;
  if ($htmlstyle) {
    $comment="&nbsp;&nbsp;....&nbsp;&nbsp;".text_to_print($comment);
  } else {
    $comment=" .... ".$comment;
  }
  if (print_style($text,$style)) {
    print $comment;
    linebreak();
  }
}


###### Help routines


# Print TeXcount version
sub print_version {
  wprintstringdata('Version');
}

# Print TeXcount reference text
sub print_reference {
  wprintstringdata('Reference');
}

# Print TeXcount licence text
sub print_license {
  wprintstringdata('License');
}

# Print TeXcount parameter list
sub print_syntax {
  wprintstringdata('OptionsHead');
  wprintstringdata('Options','@ -          :');
}

# Print complete TeXcount help
sub print_help {
  print_help_title();
  print_syntax();
  print_help_text();
  print_reference();
}

# Print help title 
sub print_help_title {
  wprintstringdata('HelpTitle');
}

# Print help text
sub print_help_text {
  wprintstringdata('HelpText');
  wprintstringdata('TCinstructions');
}

# Print help on specific macro or group
sub print_help_on {
  my $arg=shift @_;
  my $def;
  my %rules=(
    '\documentclass' => 'Initiates LaTeX document preamble.',
    '\begin' => 'Treatmend depends on group handling rules.',
    '\def' => 'Excluded from count.',
    '\verb' => 'Strong exclude for enclosed region.',
    '$'    => 'Opens or closes inlined equation',
    '$$'   => 'Opens or closes displayed equation.',
    '\('   => 'Opens inlined equation.',
    '\)'   => 'Closes inlined equation initiated by \(.',
    '\['   => 'Opens displayed equation.',
    '\]'   => 'Closes displayed equation initiated by \[.');
  if (!defined $arg || $arg=~/^\s*$/) {
    print "Specify macro or group name after the -h= option.\n";
    return;
  }
  if ($def=$rules{$arg}) {
    print "Special rule (hard coded) for $arg\n";
    print $def."\n";
  } elsif ($arg=~/^\\/) {
    if ($def=$TeXfileinclude{$arg}) {
      print "Rule for macro $arg\n";
      print "Takes file name as parameter which is included in document.\n";
    } elsif ($def=$TeXmacro{$arg}) {
      print "Rule for macro $arg\n";
      _print_rule_macro($arg,$def);
      if ($def=$TeXheader{$arg}) {
        print "This macro is counted as a header\n";
      }
      if ($def=$TeXfloatinc{$arg}) {
        print "This macro is also counted inside floats as captions.\n";
      }
    } elsif ($def=$TeXmacroword{$arg}) {
      print "Rule for macro $arg\n";
      print "Count as ".$def." word(s).\n";
    } else {
      print "No macro rule defined for $arg.\nParameters treated as surrounding text.\n";
    }
  } else {
    if ($def=$TeXgroup{$arg}) {
      print "Rule for group $arg\n";
      _print_rule_group($arg,$def);
    } else {
      print "No default group rule defined for $arg.\nContent handled as surrounding text.\n";
    }
  }
}

# Print macro handling rule
sub _print_rule_macro {
  my ($arg,$def)=@_;
  my %rules=(
     0 => 'Exclude from count',
     1 => 'Count as text',
     2 => 'Count as header',
     3 => 'Count as caption',
    -1 => 'Exclude as float (i.e. include captions)',
    -2 => 'Strong exclude (ignore begin-end groups)',
    -3 => 'Stronger exclude (ignore all macros)',
    -9 => 'Exclude as preamble');
  if (ref($def) eq 'ARRAY') {
    print "Takes ".scalar(@{$def})." parameter(s):\n";
    foreach my $i (@{$def}) {
      print " - ".$rules{$i}."\n";
    }
  } else {
    print "Takes ".$def." parameter(s), not included in counts.\n";
  }
}

# Print group handling rule
sub _print_rule_group {
  my ($arg,$def)=@_;
  my %rules=(
     0 => 'Not included',
     1 => 'Text, words included in text count',
     2 => 'Header, words included in header count',
     3 => 'Float caption, words included in float caption count',
     6 => 'Inline mathematics, words not counted',
     7 => 'Displayed mathematics, words not counted',
    -1 => 'Float, not included, but looks for captions');
  print "Rule used: ".$rules{$def}."\n";
  if ($def=$TeXmacro{'begin'.$arg}) {
    _print_rule_macro($def);
  }
}


###### HTML routines


# Print HTML header
sub html_head {
  print "<html>\n<head>";
  print "\n<meta http-equiv='content-type' content='text/html; charset=$outputEncoding'>\n";
  _print_html_style();
  print "</head>\n\n<body>\n";
  print "\n<h1>LaTeX word count";
  if ($showVersion>0) {print " (version ",_html_version(),")"}
  print "</h1>\n";
}

# Print HTML tail
sub html_tail {
  print "</body>\n\n</html>\n";
}

# Return version number using HTML
sub _html_version {
  my $htmlver=$versionnumber;
  $htmlver=~s/\b(alpha|beta)\b/&$1;/g;
  return $htmlver;
}

# Print HTML STYLE element
sub _print_html_style {
print <<END
<style>
<!--
body {width:auto;padding:5;margin:5;}
.error {font-weight:bold;color:#f00;font-style:italic;}
.word1,.word2,.word3 {color: #009; border-left: 1px solid #CDF; border-bottom: 1px solid #CDF;}
.word2 {font-weight: 700;}
.word3 {font-style: italic;}
.command {color: #c00;}
.exclcommand {color: #f99;}
.option {color: #cc0;}
.grouping, .document {color: #900; font-weight:bold;}
.mathgroup {color: #090;}
.exclmath {color: #6c6;}
.ignore {color: #999;}
.exclgroup {color:#c66;}
.tc {color: #999; font-weight:bold;}
.comment {color: #999; font-style: italic;}
.state {color: #990; font-size: 70%;}
.cumsum {color: #999; font-size: 80%;}
.fileinclude {color: #696; font-weight:bold;}
.warning {color: #c00; font-weight: 700;}

div.filegroup, div.parse, div.stylehelp, div.count, div.sumcount, div.error {
   border: solid 1px #999; margin: 4pt 0pt; padding: 4pt;
}
div.stylehelp {font-size: 80%; background: #fffff0; margin-bottom: 16pt;}
div.filegroup {background: #dfd; margin-bottom: 16pt;}
div.count {background: #ffe;}
div.sumcount {background: #cec;}
div.error {background: #fcc;}
.parse {font-size: 80%; background: #f8fff8; border-bottom:none;}

ul.count {list-style-type: none; margin: 4pt 0pt; padding: 0pt;}
.count li.header {font-weight: bold; font-style: italic;}
.subcount li.header {font-weight: normal; font-style: italic;}
.subcount li {margin-left: 16pt; font-size: 80%;}
.fielddesc {font-style: italic;}
.nb {color: #900;}

table.stat {border:2px solid #339; background:#666; border-collapse:collapse;}
table.stat tr {border:1px solid #CCC;}
table.stat th, table.stat td {padding:1pt 4pt;}
table.stat col {padding:4pt;}
table.stat thead {background: #CCF;}
table.stat tbody {border:1px solid #333;}
table.stat tbody.sumstat {background:#FFC;}
table.stat tbody.langstat {background:#FEE;}
table.stat tbody.wordstat {background:#EEF;}
table.stat .sum {font-weight:bold; font-style:italic;}
-->
</style>
END
}

###### Read text data



# Return the STRINGDATA hash (lazy instantiation)
sub STRINGDATA {
  if (!defined $STRINGDATA) {
    my @DATA=<DATA>;
    foreach (@DATA) {
      $_=~s/\$\{(\w+)\}/__apply_globaldata($1)/ge;
    }
    $STRINGDATA=splitlines(':{3,}\s*(\w+)?',\@DATA);
  }
  return $STRINGDATA;
}

# Return value from STRINGDATA hash
sub StringData {
  my $name=shift @_;
  return STRINGDATA()->{$name};
}

# Insert value from GLOBALDATA
sub __apply_globaldata {
  my $name=shift @_;
  if (my $value=$GLOBALDATA{$name}) {
    return $value;
  }
  return '[['.$name.']]';
}

# Print value from STRINGDATA using wprintlines
sub wprintstringdata {
  my $name=shift @_;
  my $data=StringData($name);
  if (!defined $data) {
    error($Main,"No StringData $name.",'BUG');
  }
  wprintlines(@_,@$data);  
}

# Divide array of lines by identifying headers
sub splitlines {
  my ($pattern,$lines)=@_;
  if (!defined $lines) {return;}
  my $id=undef;
  my %hash;
  foreach my $line (@$lines) {
    if ($line=~/^$pattern$/) {
      $id=$1;
      if (defined $id) {
        $hash{$id}=[];
        if (defined $2) {push @{$hash{$id}},$2;}
      }
    } elsif (defined $id) {
      chomp $line;
      push @{$hash{$id}},$line;
    }
  }
  return \%hash;
}

# Print string with word wrapping and indentation using
# wprintlines.
sub wprint {
  my $text=shift @_;
  my @lines=split(/\n/,$text);
  wprintlines(@lines);
}

# Print with word wrapping and indentation. A line with
# @  -    :
# sets two column tabs. A tab or multiple spaces is taken
# to indicate indentation. If the first column value is
# only a single '|', this is just an indication to skip
# one tab.
sub wprintlines {
  my @lines=@_;
  my $ind1=2;
  my $ind2=6;
  my $i;
  foreach my $line (@lines) {
    if ($line=~s/^@//) {
      $ind2=1+index($line,':');
      $ind1=1+index($line,'-');
      if ($ind1<1) {$ind1=$ind2;}
      next;
    }
    my $firstindent=0;
    if ($line=~s/^(\t|\s{2,})(\S)/$2/) {$firstindent=$ind1;}
    my $indent=$firstindent;
    if ($line=~/^(.*\S)(\t|\s{2,})/) {
      $indent=$ind2;
      if ($1 eq '|') {$line=' ';}
      else {$line=$1."   ";}
      $i=$indent-$firstindent-length($line);
      if ($i>0) {$line.=' ' x $i;}
      $line.=$';
    }
    print wrap(' ' x $firstindent,' ' x $indent,$line)."\n";
  }
}


########################################
##### TEXT DATA

__DATA__

::::::::::::::::::::::::::::::::::::::::
:::::::::: Version
TeXcount version ${versionnumber}, ${versiondate}.

:::::::::: Reference
The TeXcount script is copyright of ${maintainer} (${copyrightyears}) and published under the LaTeX Project Public Licence.

Go to the TeXcount web page
    ${website}
for more information about the script, e.g. news, updates, help, usage tips, known issues and short-comings, or to access the script as a web application. Feedback such as problems or errors can be reported to einarro@ifi.uio.no.

:::::::::: License
TeXcount version ${versionnumber}
  
Copyright ${copyrightyears} ${maintainer}

The TeXcount script is published under the LaTeX Project Public License (LPPL)
    http://www.latex-project.org/lppl.txt
which grants you, the user, the right to use, modify and distribute the script. However, if the script is modified, you must change its name or use other technical means to avoid confusion.

The script has LPPL status "maintained" with ${maintainer} being the current maintainer.

::::::::::::::::::::::::::::::::::::::::
:::::::::: HelpTitle
***************************************************************
*   TeXcount version ${versionnumber}, ${versiondate}
*

Count words in TeX and LaTeX files, ignoring macros, tables, formulae, etc.

::::::::::::::::::::::::::::::::::::::::
:::::::::: OptionsHead

Syntax: TeXcount.pl [options] files

Options:

:::::::::: OptionsPrefix
@ -          :
:::::::::: Options
  -relaxed      Uses relaxed rules for word and option handling: i.e. allows more general cases to be counted as either words or macros.
  -restricted    Restricts the rules for word and option handling.
  -v            Verbose (same as -v3).
  -v0           Do not present parsing details.
  -v1           Verbose: print parsed words, mark formulae.
  -v2           More verbose: also print ignored text.
  -v3           Even more verbose: include comments and options.
  -v4           Same as -v3 -showstate.
  -showstate    Show internal states (with verbose).
  -brief        Only prints a brief, one line summary of counts.
  -q, -quiet    Quiet mode, no error messages. Use is discouraged!
  -strict       Strict mode, warns against begin-end groups for which rule are not defined.
  -sum, -sum=   Make sum of all word and equation counts. May also use -sum=#[,#] with up to 7 numbers to indicate how each of the counts (text words, header words, caption words, #headers, #floats, #inlined formulae, #displayed formulae) are summed. The default sum (if only -sum is used) is the same as -sum=1,1,1,0,0,1,1.
  -nosum        Do not compute sum.
  -sub, -sub=   Generate subcounts. Option values are none, part, chapter, section or subsection. Default (-sub) is set to subsection, whereas unset is none. (Alternative option name is -subcount.)
  -nosub        Do not generate subcounts.
  -col          Use ANSI colours in text output.
  -nc, -nocol   No colours (colours require ANSI).
  -nosep, -noseparator   No separating character/string added after each word (default).
  -sep=, -separator=   Separating character or string to be added after each word.
  -html         Output in HTML format.
  -htmlcore     Only HTML body contents.
  -opt, -optionfile   Read options/parameters from file.
  -             Read LaTeX code from STDIN.
  -inc          Parse included TeX files (as separate file).
  -merge        Merge included TeX files into code (in place).
  -noinc        Do not include included tex files (default).
  -incbib       Include bibliography in count, include bbl file if needed.
  -nobib        Do not include bibliography in count (default).
  -incpackage=    Include rules for the given package.
  -total        Do not give sums per file, only total sum.
  -1            Same as -brief and -total. Ensures there is only one line of output. If used in conjunction with -sum, the output will only be the total number. (NB: Character is the number one, not the letter L.)
  -template=    Speficy an output template. Use {1},...,{7}, {SUM} and {TITLE} to include values, {1?...?1} etc. to conditionally include sections, {1?....|...?1} etc. to specify an alternative text if zero. To include subcounts, use {SUB?...?SUB} where ... is replaced with the template to use per subcount. Line shift may be specified using \\n.
  -dir, -dir=   Specify the working directory using -dir=path. Remember that the path must end with \\ or /. If only -dir is used, the directory of the parent file is used.
  -enc=, -encoding=    Specify encoding (default is to guess the encoding).
  -utf8, -unicode    Selects Unicode (UTF-8) for input and output. This is automatic with -chinese, and is required to handle e.g. Korean text. Note that the TeX file must be save in UTF-8 format (not e.g. GB2312 or Big5), or the result will be unpredictable.
  -alpha=, -alphabets=    List of Unicode character groups (or digit, alphabetic) permitted as letters. Names are separated by ',' or '+'. If list starts with '+', the alphabets will be added to those already included. The default is Digit+alphabetic.
  -logo=, -logograms=    List of Unicode character groups interpreted as whole word characters, e.g. Han for Chinese characters. Names are separated by ',' or '+'. If list starts with '+', the alphabets will be added to those already included. By default, this is set to include Ideographic, Katakana, Hiragana, Thai and Lao.
  -ch, -chinese, -zhongwen    Turns on support for Chinese characters. TeXcount will then count each Chinese character as a word.
  -jp, -japanese    Turns on support for Japanese characters. TeXcount will count each Japanese character (kanji, hiragana, and katakana) as one word, i.e. not do any form of word segmentation.
  -kr, -korean    Turns on support for Korean. This will count hangul and han characters, i.e. with no word separation. NB: Experimental!
  -kr-words, -korean-words    Turns on support for Korean words, i.e. hangul words separated by characters. Han characters are still counted as characters. NB: Experimental!
  -ch-only, ..., -korean-words-only    As options -chinese, ..., -korean-words, but also excludes letter-based words or trims down the character set to the minimum.
  -char, -character, -letters    Counts letters/characters instead of words. Note that spaces and punctuation is not counted.
  -char-only, ..., -letters-only    Like -letters, but counts alphabetic letters only.
  -countall, -count-all    The default setting in which all characters are included as either alphabets og logograms.
  -freq         Produce individual word frequency table.
  -stat         Produce statistics on language/script usage. 
  -codes        Display output style code overview and explanation. This is on by default.
  -nocodes      Do not display output style code overview.
  -h, -?, -help, /?    Help text.
  -h=, -?=, -help=, /?=    Takes a macro or group name as option and returns a description of the rules for handling this if any are defined. If handling rule is package specific, use -incpackage=package name: -incpackage must come before -h= on the command line to take effect.
  -ver, -version    Print version number.
  -lic, -license, -licence    Licence information.

::::::::::::::::::::::::::::::::::::::::
:::::::::: HelpText
The script counts words as either words in the text, words in headers/titles or words in floats (figure/table captions). Macro options (i.e. \\macro[...]) are ignored; macro parameters (i.e. \\macro{...}) are counted or ignored depending on the macro, but by default counted. Begin-end groups are by default ignored and treated as 'floats', though some (e.g. center) are counted.

Mathematical formulae are not counted as words, but are instead counted separately with separate counts for inlined formulae and displayed formulae. Similarly, the number of headers and the number of 'floats' are counted. Note that 'float' is used here to describe anything defined in a begin-end group unless explicitly recognized as text or mathematics.

The verbose options (-v1, -v2, -v3, showstate) produces output indicating how the text has been interpreted. Check this to ensure that words in the text has been interpreted as such, whereas mathematical formulae and text/non-text in begin-end groups have been correctly interpreted.

Summary, as well as the verbose output, may be produced as text (default) or as HTML code using the -html option. The HTML may then be sent to file which may be viewed with you favourite browser.

Under UNIX, unless -nocol (or -nc) has been specified, the output will be colour coded using ANSI colour codes. Counted text is coloured blue with headers are in bold and in HTML output caption text is italicised. Use 'less -r' instead of just 'less' to view output: the '-r' option makes less treat text formating codes properly. Windows does not support ANSI colour codes, and so this is turned off by default.

:::::::::: TCinstructions
Parsing instructions may be passed to TeXcount using comments in the LaTeX files on the format
@ -      :
  %TC:instruction arguments
and are used to control how TeXcount parses the document. The following instructions are used to set parsing rules which will apply to all subsequent parsing (including other files):
  %TC:macro [macro] [param.states]
    |    macro handling rule, no. of and rules for parameters
  %TC:macroword [macro] [number]
    |    macro counted as a given number of words
  %TC:header [macro] [param.states]
    |    header macro rule, as macro but counts as one header
  %TC:breakmacro [macro] [label]
    |    macro causing subcount break point
  %TC:group [name] [param.states] [content-state]
    |    begin-end-group handling rule
  %TC:floatinclude [macro] [param.states]
    |    as macro, but also counted inside floats
  %TC:preambleinclude [macro] [param.states]
    |    as macro, but also counted inside the preamble
  %TC:fileinclue [macro] [rule]
    |    file include, add .tex if rule=2, not if rule=0, if missing when rule=1
The [param.states] is used to indicate the number of parameters used by the macro and the rules of handling each of these: the format is [#,#,...,#] with # representing one number for each parameter giving the parsing state to use for that parameter, alternatively just a single number (#) indicating how many parameters to ignore (parsing state 0). The option [content-state] is used to give the parsing state to use for the contents of a begin-end group. The main parsing states are 0 to ignore and 1 to count as text.

Parsing instructions which may be used anywhere are:
@ -                    :
  %TC:ignore           start block to ignore
  %TC:endignore        end block to ignore
  %TC:break [title]    add subcount break point here
See the documentation for more details.

Command line options and most %TC commands (prefixed by % rather than %TC:) may be placed in an options file. This is particularly useful for defining your own output templates and macro handling rules.

::::::::::::::::::::::::::::::::::::::::

