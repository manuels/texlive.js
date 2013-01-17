%%
%% This is file `isodoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% isodoc.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2006 by Wybo Dekker <wybo@dekkerdocumenten.nl>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{isodoc}%
           [2012/02/21 v0.10 isodoc class for letters and invoices]
\ifx\pdfoutput\undefined\else%
\ifnum\pdfoutput=1\else\ClassError{isodoc}{Compile me with pdflatex or xelatex!}{}
\fi\fi
%% \StopEventually{}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}
\RequirePackage{ctable,eurosym,graphicx,stringstrings,calc}
\RequirePackage{forarray}
\RequirePackage[nofoot,head=\baselineskip]{geometry}
\RequirePackage[absolute,overlay]{textpos}
\geometry{papersize={210mm,297mm},margin=35mm}
\TPGrid{210}{297}
\definecolor{headcolor}{gray}{0}
\definecolor{headingcolor}{gray}{0}
\definecolor{markercolor}{gray}{0}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\AtBeginDocument{\addtolength{\headheight}{\baselineskip}}
\newif\ifpreamble\preambletrue
\AtBeginDocument{\preamblefalse}
\definecolor{isodocpink}{rgb}{1,.7,.7}
\def\Undefined#1{\colorbox{isodocpink}{Undefined #1}}
\def\@hft{\footnotesize\sffamily\color{headcolor}}
\def\@xyshift#1,#2@@@{\def\@xshift{#1}\def\@yshift{#2}}
\define@key{isodoc}{shift}{%
  \@xyshift#1@@@
  \AtBeginDocument{\textblockorigin{\@xshift mm}{\@yshift mm}}
}
\define@key{isodoc}{foreign}[\foreigntrue]{\foreigntrue}
                                           \newif\ifforeign\foreignfalse
\define@key{isodoc}{cityzip}[\cityziptrue]{\cityziptrue}
                                           \newif\ifcityzip\cityzipfalse
\define@key{isodoc}{localbank}[\localbanktrue]{\localbanktrue}
                                           \newif\iflocalbank\localbankfalse
\define@key{isodoc}{dutch}   []{\isodoc@dutch}
\define@key{isodoc}{english} []{\isodoc@UKenglish}
\define@key{isodoc}{german}  []{\isodoc@german}
\define@key{isodoc}{american}[]{\isodoc@USenglish}
\define@key{isodoc}{french}  []{\isodoc@french}
\define@key{isodoc}{language}{\csname isodoc@#1\endcsname}
\define@key{isodoc}{fill}  []{\rightskip=1\rightskip}
\define@key{isodoc}{nofill}[]{\rightskip=0mm plus 35mm}
                              \rightskip=0mm plus 35mm
\define@key{isodoc}{company}    {\def\company{#1}}
                                 \def\company{\Undefined{company}}
\define@key{isodoc}{logoaddress}{\def\logoaddress{#1}}
\define@key{isodoc}{who}        {\def\who{#1}}
                                 \def\who{\Undefined{who}}
\define@key{isodoc}{street}     {\def\street{#1}}
                                 \def\street{\Undefined{street}}
\define@key{isodoc}{city}       {\def\city{#1}}
                                 \def\city{\Undefined{city}}
\define@key{isodoc}{country}    {\def\country{#1}}
                                 \def\country{\Undefined{country}}
\define@key{isodoc}{countrycode}{\def\countrycode{#1}}
                                 \def\countrycode{\Undefined{countrycode}}
\define@key{isodoc}{zip}        {\def\zip{#1}}
                                 \def\zip{\Undefined{zip}}
\def\prezip{\ifforeign\countrycode\else\fi}
\define@key{isodoc}{leftaddress} []{\def\xaddress{35}}
                                    \def\xaddress{35}
\define@key{isodoc}{rightaddress}[]{\def\xaddress{105}}
\define@key{isodoc}{addresscenter} {\def\addresscenter{#1}}
                                    \def\addresscenter{63.5}
\define@key{isodoc}{addresswidth}  {\def\addresswidth{#1}}
                                    \def\addresswidth{70}
\define@key{isodoc}{to}{\processto{#1}}\def\toname{Various people}
                                       \def\toaddress{\Undefined{to}}
\long\def\processto#1{\xproc #1\\@@@\ifx\toaddress\empty
    \else \yproc #1@@@\fi}
\long\def\xproc #1\\#2@@@{\def\toname{#1}\def\toaddress{#2}}
\long\def\yproc #1\\#2@@@{\def\toaddress{#2}}
\define@key{isodoc}{return}     []{\returntrue}
                    \newif\ifreturn\returnfalse
\define@key{isodoc}{noreturn}   []{\returnfalse}
\define@key{isodoc}{returnaddress}{\def\returnaddress{#1}}
\define@key{isodoc}{header}  []{\headertrue}
                 \newif\ifheader\headertrue
\define@key{isodoc}{noheader}[]{\headerfalse}
\define@key{isodoc}{bodyshift} {\advance\headerpos#1}
\newcount\headerpos\headerpos=98
\newcount\footerpos\footerpos=275
\newcount\subjectpos
\newcount\openingpos
\newcount\textskip
\define@key{isodoc}{footorder} {\def\footorder{#1}}
                                \def\footorder{website;phone;cellphone;fax;email}
\define@key{isodoc}{footer}  []{\footertrue}
                 \newif\iffooter\footerfalse
\define@key{isodoc}{nofooter}[]{\footerfalse}
\define@key{isodoc}{areacode}   {\def\areacode{#1}}
                                 \def\areacode{\Undefined{areacode}}
\define@key{isodoc}{phone}      {\def\isodoc@phone{#1}}
                                 \def\isodoc@phone{}
\define@key{isodoc}{phoneprefix}{\def\phoneprefix{#1}}
                                 \def\phoneprefix{0}
\define@key{isodoc}{cellphone}  {\def\isodoc@cellphone{#1}}
                                 \def\isodoc@cellphone{}
\define@key{isodoc}{fax}        {\def\isodoc@fax{#1}}
                                 \def\isodoc@fax{}
\define@key{isodoc}{website}    {\def\website{#1}}
                                 \def\website{}
\define@key{isodoc}{email}      {\def\email{#1}}
                                 \def\email{}
\define@key{isodoc}{nofold}[]{\yfold=-1mm}
               \newdimen\yfold\yfold=-1mm
\define@key{isodoc}{foldleft}[]{\xfold=9mm}
               \newdimen\xfold\xfold=201mm
\define@key{isodoc}{foldright}[]{\xfold=201mm}
\define@key{isodoc}{fold2}[]{\yfold=158mm}
\define@key{isodoc}{fold3}[]{\yfold=107mm}
\define@key{isodoc}{fold}{\yfold=#1mm}
\define@key{isodoc}{ourref}  {\def\ourref{#1}}
                              \def\ourref{}
\define@key{isodoc}{yourref}   {\def\yourref{#1}}
                              \def\yourref{}
\define@key{isodoc}{yourletter}{\def\yourletter{#1}}
                              \def\yourletter{}
\define@key{isodoc}{date}{\@isomakedate{#1}}
                          \def\date{\Undefined{date}}
\define@key{isodoc}{forcedate}{\def\forcedate{#1}}\def\forcedate{}
\define@key{isodoc}{subject}{\def\subject{#1}}
                             \def\subject{}
\define@key{isodoc}{opening}     {\def\opening{#1}}
                                  \def\openingcomma{,}
\define@key{isodoc}{openingcomma}{\def\openingcomma{#1}}
                                  \def\opening{\Undefined{opening}}
\define@key{isodoc}{closing}    {\def\closing{#1}}
 \def\closingcomma{,}
                                 \def\closing{\Undefined{closing}}
\define@key{isodoc}{closingskip}{\closingskip=#1}
            \newdimen\closingskip\closingskip=2\baselineskip
\define@key{isodoc}{autograph}[2]{\def\autographversion{#1}}
                                  \def\autographversion{0}
\define@key{isodoc}{signature}{\def\signature{#1}}
                               \def\signature{\Undefined{signature}}
\define@key{isodoc}{enclosures} {\def\enclosures{#1}}
                                 \def\enclosures{}
\define@key{isodoc}{term}   [30]{\def\term{#1}}
\define@key{isodoc}{accountno}  {\def\accountno{#1}}
\define@key{isodoc}{routingno}  {\def\routingno{#1}}
\define@key{isodoc}{accountname}{\def\accountname{#1}}
\define@key{isodoc}{iban}       {\def\iban{#1}}
\define@key{isodoc}{bic}        {\def\bic{#1}}
\define@key{isodoc}{vatno}      {\def\vatno{#1}}
\define@key{isodoc}{chamber}    {\def\chamber{#1}}
                                 \def\chamber{Undefined{chamber}}
\define@key{isodoc}{currency}   {\def\currency{#1}}
                                 \def\currency{\EuroSymbol}
\define@key{isodoc}{accept}[E05]{\def\accepttype{#1}
                                 \newfont\ocrb{ocrb10}
                                }
\define@key{isodoc}{acceptaccount}    {\def\acceptaccount{#1}}
                                       \def\acceptaccount{}
\define@key{isodoc}{acceptaddress}    {\def\acceptaddress{#1}}
                                       \def\acceptaddress{}
\define@key{isodoc}{acceptcents}      {\def\acceptcents{#1}}
                                       \def\acceptcents{Undefined{}}
\define@key{isodoc}{acceptdescription}{\def\acceptdescription{#1}}
                                       \def\acceptdescription{}
\define@key{isodoc}{acceptdesc}       {\def\acceptdesc{#1}}
                                       \def\acceptdesc{}
\define@key{isodoc}{accepteuros}      {\def\accepteuros{#1}}
                                       \def\accepteuros{Undefined{}}
\define@key{isodoc}{acceptreference}  {\def\acceptreference{#1}}
                                       \def\acceptreference{Undefined{ref}}
\def\xacceptdescription{105}\def\yacceptdescription{200}\def\wacceptdescription{100} %T
\def\xacceptref{7}          \def\yacceptref{212}        \def\wacceptref{30}          %T
\def\xaccepteuros{60}       \def\yaccepteuros{216}      \def\waccepteuros{32}        %C
\def\xacceptcents{89}       \def\yacceptcents{216}      \def\wacceptcents{13}        %C
\def\xacceptreference{125}  \def\yacceptreference{216}  \def\wacceptreference{55}    %C
\def\xaccepteur{14.4}       \def\yaccepteur{228.5}      \def\waccepteur{21}          %C
\def\xacceptct{32}          \def\yacceptct{228.5}       \def\wacceptct{9}            %C
\def\xacceptaccount{75}     \def\yacceptaccount{228.5}  \def\wacceptaccount{65}      %C
\def\xacceptdesc{7}         \def\yacceptdesc{241}       \def\wacceptdesc{26}         %T
\def\xacceptaddress{58}     \def\yacceptaddress{241}    \def\wacceptaddress{90}      %T
\newdimen\acceptreferenceskip\acceptreferenceskip=5.15mm
\RequirePackage{isodocsymbols}
\newdimen\myoutdent
\newdimen\signskip
\newdimen\mydown
\def\autograph#1#2#3#4#5#6#7{%
  \ifnum #1<2
    \ClassError{isodoc}{autograph #1 cannot be changed (first arg must be 2..9)}{}
  \fi
  \ifnum #1>9
    \ClassError{isodoc}{autograph #1 cannot be changed (first arg must be 2..9)}{}
  \fi
  \bgroup
  \lccode`2=`A \lccode`6=`E
  \lccode`3=`B \lccode`7=`F
  \lccode`4=`C \lccode`8=`G
  \lccode`5=`D \lccode`9=`H
  \lowercase{\def\temp{#1}}%
  \expandafter\egroup\expandafter\def\csname autograph\temp\endcsname{%
    \myoutdent=#3
    \signskip=#5\advance\signskip-#4
    \mydown=#6\advance\mydown-#4
    \par\hspace*{-#2\myoutdent}%
    \raisebox{-#2\mydown}[0bp][0bp]{\includegraphics[scale=#2]{#7}}\\[-\baselineskip]
    \closing\\[-2\baselineskip]\\[#2\signskip]\signature%
  }
}
\newcommand{\zippedcity}{\ifcityzip\city\ \prezip\ \zip\else\prezip\ \zip\ \city\fi}
\newcommand{\logo}{%
  { \parskip=0pt\parindent=0pt
    \begin{textblock}{140}[0,1](35,20)%
        \textsf{\LARGE\company}\\[-1.7ex] % large company name
        \rule{\hsize}{.3pt}               % on top a rule
    \end{textblock}
  }
  \Tbox{140}{22}{35}{\noindent
     \footnotesize\sffamily
     \ifx\undefined\logoaddress%
       \ifx\undefined\tbfigures\else\tbfigures\fi
       \ifx\who\empty\else\who\\\fi
       \ifx\street\empty\else\street\\\fi
       \zippedcity
       \ifforeign\\\country\fi
     \else\logoaddress\fi
  }
}
\def\returnaddress{%
  \ifx\undefined\tbfigures\else\tbfigures\fi % when using osf-txfonts... just for me
  \company\\
  \street\\
  \zippedcity
  \ifforeign\\\country\fi
}
\newcommand{\setupdocument}[1]{
  \setkeys{isodoc}{#1}
  \iffooter\else\geometry{bottom=25mm}\fi
}
\newcount\@isoyear   \@isoyear=\year  \year=0
\newcount\@isomonth \@isomonth=\month
\newcount\@isoday     \@isoday=\day
\def\@isomakedate#1{%
  \def\@isoarg{#1}\def\@isotoday{today}
  \ifx\@isoarg\@isotoday
     \year=\@isoyear
    \month=\@isomonth
      \day=\@isoday
  \else
    \stringlength[q]{\@isoarg}
    \ifnum\theresult=10
      \substring[q]{\@isoarg}{5}{5}
      \if\thestring-\else\ClassError{isodoc}{
        Illegal date separator: \thestring (must be -)}{}\fi
      \substring[q]{\@isoarg}{8}{8}
      \if\thestring-\else\ClassError{isodoc}{
        Illegal date separator: \thestring (must be -)}{}\fi
    \else
      \ifnum\theresult=8\else\ClassError{isodoc}{
        Illegal date: not yyyymmdd | yyyy-mm-dd | today}{}\fi
    \fi
    \Treatments{0}{0}{0}{1}{0}{0}
    \substring[q]{\@isoarg}{1}{$} \let\@isodigits=\thestring \def\@isoarg{\thestring}
    \stringlength[q]{\@isodigits}
    \ifnum\theresult=8\else\ClassError{isodoc}{Illegal date: must have 8 digits}{}\fi
    \substring[q]{\@isoarg}{1}{4}  \year=\thestring \def\@isoarg{\@isodigits}
    \substring[q]{\@isoarg}{5}{6} \month=\thestring \def\@isoarg{\@isodigits}
    \substring[q]{\@isoarg}{7}{8}   \day=\thestring \def\@isoarg{\@isodigits}
    \ifnum \month > 12 \ClassError{isodoc}{Illegal date: month>12}{}\fi
    \ifnum \day   > 31 \ClassError{isodoc}{Illegal date: day>31}{}\fi
  \fi
}
\def\accountdata{
  \textbf{\accountdatatext:}\\
  \begin{tabular}{@{}rl@{}}
    \ifx\term\undefined\else
             \termtext: & \term\ \daystext\\
    \fi
        \accountnotext: & \accountno\\
    \ifx\accountname\undefined\else
       \accountnametext: & \accountname{}\\
    \fi
    \ifx\routingno\undefined\else
       \routingnotext: & \routingno{}\\
    \fi
        \referencetext: & \ourref\\
    \ifforeign
      \iflocalbank\else
                  iban: & \scshape \iban\\
                   bic: & \scshape \bic\\
      \fi
    \fi
    \ifx\vatno\undefined\else
      \vatnotext: & \vatno\\
    \fi
  \end{tabular}
}
\def\showkeys{%
  \begin{tabular}{ll}
              accept & \accept\NN
       acceptaccount & \acceptaccount\NN
       acceptaddress & \acceptaddress\NN
         acceptcents & \acceptcents\NN
          acceptdesc & \acceptdesc\NN
   acceptdescription & \acceptdescription\NN
         accepteuros & \accepteuros\NN
     acceptreference & \acceptreference\NN
         accountname & \accountname\NN
           accountno & \accountno\NN
       addresscenter & \addresscenter\NN
        addresswidth & \addresswidth\NN
            american & \american\NN
            areacode & \areacode\NN
           autograph & \autograph\NN
                 bic & \bic\NN
           bodyshift & \bodyshift\NN
           cellphone & \cellphone\NN
             chamber & \chamber\NN
                city & \city\NN
             cityzip & \cityzip\NN
             closing & \closing\NN
         closingskip & \closingskip\NN
             company & \company\NN
             country & \country\NN
         countrycode & \countrycode\NN
            currency & \currency\NN
                date & \date\NN
               dutch & \dutch\NN
               email & \email\NN
          enclosures & \enclosures\NN
             english & \english\NN
                 fax & \fax\NN
                fill & \fill\NN
                fold & \fold\NN
               fold2 & \fold2\NN
               fold3 & \fold3\NN
            foldleft & \foldleft\NN
           foldright & \foldright\NN
              footer & \footer\NN
           footorder & \footorder\NN
           forcedate & \forcedate\NN
             foreign & \foreign\NN
              french & \french\NN
              german & \german\NN
              header & \header\NN
                iban & \iban\NN
            language & \language\NN
         leftaddress & \leftaddress\NN
           localbank & \localbank\NN
         logoaddress & \logoaddress\NN
              nofill & \nofill\NN
              nofold & \nofold\NN
            nofooter & \nofooter\NN
            noheader & \noheader\NN
            noreturn & \noreturn\NN
             opening & \opening\NN
        openingcomma & \openingcomma\NN
              ourref & \ourref\NN
               phone & \phone\NN
         phoneprefix & \phoneprefix\NN
              return & \return\NN
       returnaddress & \returnaddress\NN
        rightaddress & \rightaddress\NN
           routingno & \routingno\NN
               shift & \shift\NN
           signature & \signature\NN
              street & \street\NN
             subject & \subject\NN
                term & \term\NN
                  to & \to\NN
               vatno & \vatno\NN
             website & \website\NN
                 who & \who\NN
          yourletter & \yourletter\NN
             yourref & \yourref\NN
                 zip & \zip\NN
  \end{tabular}
}
\AtEndOfClass{%
  \usepackage{hyperref}
   \year=0
}
\AtEndDocument{%
  \hypersetup{pdfauthor={\who},
              pdfproducer={isodoc v\fileversion}
  }
}
\def\itable#1{
  \begin{tabularx}{\hsize}{@{}X@{\barsep\quad\qquad}r@{}}
    \multicolumn{2}{@{}c@{}}{\sffamily\descriptiontext\hfill
    \amounttext (\currency)}\ML
    #1
  \end{tabularx}
}
\def\iitem#1#2{#1&#2\NN}
\def\itotal#1{\cmidrule[.05em]{2-2}\totaltext&\textbf{#1}\NN}
\newcounter{lettercount}\setcounter{lettercount}{0}
\newif\ifclosing\closingtrue
\newcount\footcount
\newcommand{\invoice}[2][]{%
  \closingfalse
  \def\barsep{\raisebox{-1.5ex}[0pt][0pt]{\rule{.05em}{4ex}}}%
  \letter[#1,
    opening={\bfseries\scshape\Large\invoicetext},
    openingcomma={},
    closing={},
    signature={}]{\Tbox{35}{127}{140}{\ignorespaces#2}}
}
\newcommand{\letter}[2][]{{%
  \newpage
  \setkeys{isodoc}{#1}
  \def\isodoc@lead{\ifforeign+\areacode-\else\phoneprefix\fi}
  \ifx\isodoc@phone\empty\else\def\phone{\isodoc@lead\isodoc@phone}\fi
  \ifx\isodoc@cellphone\empty\else\def\cellphone{\isodoc@lead\isodoc@cellphone}\fi
  \ifx\isodoc@fax\empty\else\def\fax{\isodoc@lead\isodoc@fax}\fi
  \ifx\yourlettertext\undefined\ClassWarning{isodoc}{
    You did not use the language option; using the default: UKenglish
  }\isodoc@UKenglish\fi
  \ifnum\value{lettercount}=0%
    \hypersetup{pdftitle={letter to \toname\ dated \today},
                pdfsubject={\subject}}
  \fi
  \addtocounter{lettercount}{1}
  \setcounter{page}{1}
  \setcounter{footnote}{0}
  \fancyhf{}
  \if@twoside
    \fancyhead[LE,RO]{\color{headingcolor}%
    \pagetext\ \thepage\ \oftext{}
    \begin{NoHyper}\pageref{LastPageOf\thelettercount}\end{NoHyper}}
    \fancyhead[RE,LO]{\color{headingcolor}%
       \totext: \toname\ (\date)}
  \else
    \fancyhead[L]{\color{headingcolor}%
    \totext: \toname\ (\date)}
    \fancyhead[R]{\color{headingcolor}%
    \pagetext\ \thepage\ \oftext{}
    \begin{NoHyper}\pageref{LastPageOf\thelettercount}\end{NoHyper}}
  \fi
  \logo
  { \parskip=0pt\parindent=0pt
    \begin{textblock}{\addresswidth}[0,.5](\xaddress,\addresscenter)%
        \ifreturn
          {\def\\{\unskip\enspace\textbullet\enspace\ignorespaces}%
            \sffamily\bfseries\scriptsize\returnaddress
          }\\[-.8\baselineskip]
          \rule{\hsize}{.2pt}\\
        \fi
        \toname\\\toaddress
    \end{textblock}
  }
  \subjectpos=\headerpos
  \textskip=\headerpos\advance\textskip-12
  \ifx\subject\empty\advance\textskip-10\else\advance\subjectpos10\fi
  \openingpos=\subjectpos
  \ifheader
    \openingpos=\subjectpos\advance\openingpos12
    \Tbox{35}{\headerpos}{35}{\noindent
      {\@hft\yourlettertext}\\
      \yourletter
    }
    \Tbox{70}{\headerpos}{35}{\noindent
      {\@hft\yourreftext}\\
      \raggedright\yourref
    }
    \Tbox{105}{\headerpos}{35}{\noindent
      {\@hft\ourreftext}\\
      \raggedright\ourref
    }
    \Tbox{140}{\headerpos}{35}{\noindent
      {\@hft\datetext}\\
      \ifx\forcedate\empty%
        \ifnum\year=0\Undefined{date}\else\date\fi
      \else\forcedate\fi
    }
    \ifx\subject\empty\else%
      \Tbox{35}{\subjectpos}{140}{\noindent
        \begin{tabularx}{\hsize}{@{}l>{\raggedright}X@{}}
          \@hft\subjecttext&\subject
        \end{tabularx}
      }
    \fi
  \else
    \advance\textskip-12
  \fi
  \footcount=35
  \iffooter
    \ForEachX{;}{%
      \setbox0=\hbox{\csname\thislevelitem\endcsname}
      \ifdim\wd0=0pt\else
        \Tbox{\footcount}{\footerpos}{35}{\noindent
          {\@hft\csname\thislevelitem text\endcsname}\\
            \csname\thislevelitem\endcsname
        }
        \advance\footcount35
      \fi
    }{\footorder}
  \fi
  { \parskip=0pt\parindent=0pt
    \begin{textblock*}{3mm}(\xfold,\yfold)%
       {\color{markercolor}\rule{\hsize}{.2pt}}
    \end{textblock*}
  }
  \ifx\undefined\accepttype\else\accept\fi
  \noindent\Tbox{35}{\openingpos}{140}{\opening\openingcomma}
  \vspace{\textskip mm}
  \thispagestyle{empty}
  \noindent\ignorespaces#2
  {\parindent=0pt\parskip=\baselineskip
    \ifclosing
      \ifcase\autographversion
        \par\closing\closingcomma\\\signature   % 0: closing on the next line
      \or\par\closing\closingcomma\\[\closingskip]\signature % 1: whiteskip
      \or\autographA
      \or\autographB
      \or\autographC
      \or\autographD
      \or\autographE
      \or\autographF
      \or\autographG
      \or\autographH
      \else
        \par\Undefined{autograph: \autographversion}\\
      \fi
    \fi
    \ifx\enclosures\empty\else
      \vfill
      \setbox1=\vbox{\enclosures}%
      \textbf{\ifdim\ht1>\baselineskip\enclosurestext\else\enclosuretext\fi}%
      \\\enclosures
    \fi
  }
  \label{LastPageOf\thelettercount}
}}
\def\Cbox#1#2#3#4{%
  { \parskip=0pt\parindent=0pt
    \begin{textblock}{#3}[.5,.5](#1,#2)%
        \begin{center}
          #4
        \end{center}
    \end{textblock}
  }
}
\long\def\Tbox#1#2#3#4{%
  { \parskip0pt\parindent=0pt
    \begin{textblock}{#3}(#1,#2)%
        \begin{minipage}[t]{\hsize}
          \noindent#4
        \end{minipage}
    \end{textblock}
  }
}
\def\accept{
  \Tbox{\xacceptdescription}
       {\yacceptdescription}
       {\wacceptdescription}
       {\acceptdescription}
  \Tbox{\xacceptdesc}
       {\yacceptdesc}
       {\wacceptdesc}
       {\acceptdesc}
  \Tbox{\xacceptaddress}
       {\yacceptaddress}
       {\wacceptaddress}
       {\ifx\acceptaddress\empty\toname\\\toaddress\else\acceptaddress\fi}
  \Cbox{\xacceptreference}
       {\yacceptreference}
       {\wacceptreference}
       {\ocrb\acceptreference}
  \Tbox{\xacceptref}
       {\yacceptref}
       {\wacceptref}
       {\baselineskip=\acceptreferenceskip\ocrb\acceptreference}
  \Cbox{\xaccepteuros}
       {\yaccepteuros}
       {\waccepteuros}
       {\ocrb\accepteuros}
  \Cbox{\xacceptaccount}
       {\yacceptaccount}
       {\wacceptaccount}
       {\ocrb\acceptaccount}
  \Cbox{\xacceptcents}
       {\yacceptcents}
       {\wacceptcents}
       {\ocrb\acceptcents}
  \Cbox{\xaccepteur}
       {\yaccepteur}
       {\waccepteur}
       {\ocrb\accepteuros}
  \Cbox{\xacceptct}
       {\yacceptct}
       {\wacceptct}
       {\ocrb\acceptcents}
}
\def\isodoc@catalan{%
  \gdef\accountdatatext {Dades banc\`aries}
  \gdef\accountnametext {a nom de}
  \gdef\accountnotext   {N\'um. de compte}
  \gdef\amounttext      {Quantitat}
  \gdef\ccname          {cc}
  \gdef\cellphonetext   {M\`obil}
  \gdef\chambertext     {Cambra de comer\c{c}}
  \gdef\datetext        {Data}
  \gdef\daystext        {dies}
  \gdef\descriptiontext {Descripci\'o}
  \gdef\emailtext       {E-mail}
  \gdef\enclosurestext  {Annexos:}
  \gdef\enclosuretext   {Annex:}
  \gdef\faxtext         {Fax}
  \gdef\invoicetext     {factura}
  \gdef\oftext          {de}
  \gdef\ourreftext      {La nostra refer\`encia}
  \gdef\pagetext        {P\`agina}
  \gdef\phonetext       {Tel\`efon}
  \gdef\referencetext   {Refer\`encia}
  \gdef\routingnotext   {Nombre de ruta}
  \gdef\subjecttext     {Assumpte}
  \gdef\termtext        {Termini del pagament}
  \gdef\totaltext       {Total}
  \gdef\totext          {A}
  \gdef\vatnotext       {N\'um. IVA}
  \gdef\vattext         {IVA}
  \gdef\websitetext     {Web}
  \gdef\yourlettertext  {La seva carta del}
  \gdef\yourreftext     {La seva refer\`encia}
  \gdef\date            {\number\day\space\ifcase\month\or
    gener\or febrer\or mar\c{c}\or abril\or maig\or juny\or
    juliol\or agost\or setembre\or octubre\or novembre\or desembre\fi
    \space \number\year
  }
}
\def\isodoc@dutch{%
  \gdef\accountdatatext {Betalingsgegevens}
  \gdef\accountnametext {ten name van}
  \gdef\accountnotext   {rekening nr}
  \gdef\amounttext      {Bedrag}
  \gdef\ccname          {Cc:}
  \gdef\cellphonetext   {mobiel}
  \gdef\chambertext     {kvk}
  \gdef\datetext        {Datum}
  \gdef\daystext        {dagen}
  \gdef\descriptiontext {Omschrijving}
  \gdef\emailtext       {e-mail}
  \gdef\enclosurestext  {Bijlagen:}
  \gdef\enclosuretext   {Bijlage:}
  \gdef\faxtext         {telefax}
  \gdef\invoicetext     {rekening}
  \gdef\oftext          {van}
  \gdef\ourreftext      {Ons kenmerk}
  \gdef\pagetext        {Bladnummer}
  \gdef\phonetext       {telefoon}
  \gdef\referencetext   {kenmerk}
  \gdef\routingnotext   {banknummer}
  \gdef\subjecttext     {Onderwerp:}
  \gdef\termtext        {betalingstermijn}
  \gdef\totaltext       {Totaal}
  \gdef\totext          {Aan}
  \gdef\vatnotext       {btw nr}
  \gdef\vattext         {Btw}
  \gdef\websitetext     {webstek}
  \gdef\yourlettertext  {Uw brief van}
  \gdef\yourreftext     {Uw kenmerk}
  \gdef\date            {\number\day\space\ifcase\month\or
    januari\or februari\or maart\or april\or mei\or juni\or juli\or
    augustus\or september\or oktober\or november\or december\fi
    \space \number\year}
}
\def\isodoc@french{%
  \gdef\accountdatatext {Donn\'ees banquaires}
  \gdef\accountnametext {au nom de}
  \gdef\accountnotext   {no. compte}
  \gdef\amounttext      {Montant}
  \gdef\ccname          {Copie \`a}
  \gdef\cellphonetext   {portable}
  \gdef\chambertext     {c.c.i.}
  \gdef\datetext        {Date:}
  \gdef\daystext        {jours}
  \gdef\descriptiontext {Description}
  \gdef\emailtext       {email}
  \gdef\enclosurestext  {Pi\`eces jointes:}
  \gdef\enclosuretext   {Pi\`ece jointe:}
  \gdef\faxtext         {t\'el\'efax}
  \gdef\invoicetext     {facture}
  \gdef\oftext          {de}
  \gdef\ourreftext      {Nos r\'ef\'erences:}
  \gdef\pagetext        {Page}
  \gdef\phonetext       {t\'el\'ephone}
  \gdef\referencetext   {r\'ef\'erence}
  \gdef\routingnotext   {num\'ero d'acheminement}
  \gdef\subjecttext     {Objet:}
  \gdef\termtext        {terme}
  \gdef\totaltext       {Total}
  \gdef\totext          {\`A l'attention de}
  \gdef\vatnotext       {no. T.V.A.}
  \gdef\vattext         {T.V.A.}
  \gdef\websitetext     {site Web}
  \gdef\yourlettertext  {Votre lettre du}
  \gdef\yourreftext     {Vos r\'ef\'erences:}
  \gdef\date            {\number\day\ifnum\day=1$^{er}$\fi\space\ifcase\month\or
    janvier\or f\'evrier\or mars\or avril\or mai\or juin\or
    juillet\or ao\^ut\or septembre\or octobre\or
    novembre\or d\'ecembre\fi \space \number\year}
}
\def\isodoc@german{%
  \gdef\accountdatatext {Bezahlungsdaten}
  \gdef\accountnametext {Name}
  \gdef\accountnotext   {Konto Nr}
  \gdef\amounttext      {Betrag}
  \gdef\ccname          {Kopien an}
  \gdef\cellphonetext   {Handy}
  \gdef\chambertext     {Register Nr}
  \gdef\datetext        {Datum}
  \gdef\daystext        {Tage}
  \gdef\descriptiontext {Umschreibung}
  \gdef\emailtext       {E-mail}
  \gdef\enclosurestext  {Anlagen:}
  \gdef\enclosuretext   {Anlage:}
  \gdef\faxtext         {Telefax}
  \gdef\invoicetext     {rechnung}
  \gdef\oftext          {aus}
  \gdef\ourreftext      {Unser Zeichen}
  \gdef\pagetext        {Seite}
  \gdef\phonetext       {Telefon}
  \gdef\referencetext   {Beleg Nr}
  \gdef\routingnotext   {BLZ}
  \gdef\subjecttext     {Betrifft:}
  \gdef\termtext        {Zahlungstermin}
  \gdef\totaltext       {Insgesamt}
  \gdef\totext          {An}
  \gdef\vatnotext       {Ustid Nr}
  \gdef\vattext         {MwSt}
  \gdef\websitetext     {Webseite}
  \gdef\yourlettertext  {Ihr Brief vom}
  \gdef\yourreftext     {Ihr Zeichen}
  \gdef\date            {\number\day.\space\ifcase\month\or
    Januar\or Februar\or M\"arz\or April\or Mai\or Juni\or
    Juli\or August\or September\or Oktober\or November\or Dezember\fi
    \space\number\year}
}
\def\isodoc@italian{%
  \gdef\accountdatatext {Coordinate bancarie}
  \gdef\accountnametext {intestato a}
  \gdef\accountnotext   {n$^o$~del conto}
  \gdef\amounttext      {Prezzo}
  \gdef\ccname          {Per conoscenza a:}
  \gdef\cellphonetext   {cellulare:}
  \gdef\chambertext     {}
  \gdef\datetext        {Data:}
  \gdef\daystext        {giorni}
  \gdef\descriptiontext {Descrizione}
  \gdef\emailtext       {e-mail:}
  \gdef\enclosurestext  {Allegati:}
  \gdef\enclosuretext   {Allegato:}
  \gdef\faxtext         {fax:}
  \gdef\invoicetext     {fattura}
  \gdef\oftext          {di}
  \gdef\ourreftext      {Nostro riferimento:}
  \gdef\pagetext        {Pagina}
  \gdef\phonetext       {telefono:}
  \gdef\referencetext   {riferimento}
  \gdef\routingnotext   {numero di routing}
  \gdef\subjecttext     {Oggetto:}
  \gdef\termtext        {scadenza}
  \gdef\totaltext       {Totale}
  \gdef\totext          {All'attenzione di:}
  \gdef\vatnotext       {Partita I.V.A.}
  \gdef\vattext         {I.V.A.}
  \gdef\websitetext     {sito Web:}
  \gdef\yourlettertext  {Vostra lettera del:}
  \gdef\yourreftext     {Vostro riferimento:}
  \gdef\date            {\number\day\ifnum\day=1\fi
    ~\ifcase\month\or
    Gennaio\or Febbraio\or Marzo\or Aprile\or Maggio\or Giugno\or
    Luglio\or Agosto\or Settembre\or Ottobre\or Novembre\or Dicembre\fi
    \space \number\year}
}
\def\isodoc@norsk       {%
  \gdef\accountdatatext {betales til}
  \gdef\accountnametext {til}
  \gdef\accountnotext   {faktura nr}
  \gdef\amounttext      {Bel\o{}p}
  \gdef\ccname          {kopi til:}
  \gdef\cellphonetext   {mobil}
  \gdef\chambertext     {}
  \gdef\datetext        {Dato}
  \gdef\daystext        {dager}
  \gdef\descriptiontext {Beskrivelse}
  \gdef\emailtext       {e-post}
  \gdef\enclosurestext  {Vedlegg:}
  \gdef\enclosuretext   {Vedlegg:}
  \gdef\faxtext         {telefaks}
  \gdef\invoicetext     {faktura}
  \gdef\oftext          {av}
  \gdef\ourreftext      {V\aa{}r ref:}
  \gdef\pagetext        {Side}
  \gdef\phonetext       {telefon}
  \gdef\referencetext   {referanse}
  \gdef\routingnotext   {routing-nummer}
  \gdef\subjecttext     {Vedr:}
  \gdef\termtext        {betalingsfrist}
  \gdef\totaltext       {Total}
  \gdef\totext          {Til}
  \gdef\vatnotext       {Org. nr.}
  \gdef\vattext         {Mva}
  \gdef\websitetext     {hjemmeside}
  \gdef\yourlettertext  {Deres brev av}
  \gdef\yourreftext     {Deres ref:}
  \gdef\date            {\number\day.\space\ifcase\month\or
    januar\or februar\or mars\or april\or mai\or juni\or
    juli\or august\or september\or oktober\or november\or desember\fi
   \space \number\year}
}
\def\isodoc@serbian {%
  \gdef\totaltext {Ukupno}
  \gdef\vattext {PDV}
  \gdef\accountdatatext {Podaci o bankarskom sektoru}
  \gdef\accountnametext {na ime}
  \gdef\accountnotext {Ra\v cun br.}
  \gdef\amounttext {Iznos}
  \gdef\ccname {Kopije}
  \gdef\cellphonetext {Mobilni}
  \gdef\chambertext {Spisak br.}
  \gdef\datetext {Datum}
  \gdef\daystext {dana}
  \gdef\descriptiontext {Opis}
  \gdef\emailtext {Email}
  \gdef\enclosurestext {Prilozi:}
  \gdef\enclosuretext {Prilog:}
  \gdef\faxtext {Telefax}
  \gdef\invoicetext {faktura}
  \gdef\oftext {od}
  \gdef\ourreftext {Na\v s broj}
  \gdef\pagetext {Strana}
  \gdef\phonetext {Telefon}
  \gdef\referencetext {Dokumet br.}
  \gdef\routingnotext   {BLZ}
  \gdef\subjecttext {Predmet:}
  \gdef\termtext {rok pla\' canja}
  \gdef\totext {U}
  \gdef\vatnotext {porez br.}
  \gdef\websitetext {Website}
  \gdef\yourlettertext {Va\v se pismo od}
  \gdef\yourreftext {Va\v s broj}
  \gdef\date{\number\day.~\ifcase\month\or
    Januar\or Februar\or Mart\or April\or Maj\or Jun\or
    Jul\or Avgust\or Septembar\or Oktobar\or Novembar\or Decembar\fi
    \space\number\year}
}
\def\isodoc@spanish{%
  \gdef\accountdatatext {Datos bancarios}
  \gdef\accountnametext {a nombre de}
  \gdef\accountnotext   {N\'um. de cuenta}
  \gdef\amounttext      {Cantidad}
  \gdef\ccname          {cc}
  \gdef\cellphonetext   {M\'ovil}
  \gdef\chambertext     {C\'amara de comercio}
  \gdef\datetext        {Fecha}
  \gdef\daystext        {d\'{\i}as}
  \gdef\descriptiontext {Descripci\'on}
  \gdef\emailtext       {E-mail}
  \gdef\enclosurestext  {Anexos:}
  \gdef\enclosuretext   {Anexo:}
  \gdef\faxtext         {Fax}
  \gdef\invoicetext     {factura}
  \gdef\oftext          {de}
  \gdef\ourreftext      {Nuestra referencia}
  \gdef\pagetext        {P\'agina}
  \gdef\phonetext       {Tel\'efono}
  \gdef\referencetext   {Referencia}
  \gdef\routingnotext   {n\'umero de ruta}
  \gdef\subjecttext     {Asunto}
  \gdef\termtext        {Plazo de pago}
  \gdef\totaltext       {Total}
  \gdef\totext          {A}
  \gdef\vatnotext       {N\'um. IVA}
  \gdef\vattext         {IVA}
  \gdef\websitetext     {Web}
  \gdef\yourlettertext  {Su carta de}
  \gdef\yourreftext     {Su referencia}
  \gdef\date            {\number\day\space\ifcase\month\or
    enero\or febrero\or marzo\or abril\or mayo\or junio\or
    julio\or agosto\or septiembre\or octubre\or noviembre\or diciembre\fi
    \space \number\year
  }
}
\def\isodoc@UKenglish{%
  \gdef\accountdatatext {Banking data}
  \gdef\accountnametext {in the name of}
  \gdef\accountnotext   {Account no.}
  \gdef\amounttext      {Amount}
  \gdef\ccname          {cc}
  \gdef\cellphonetext   {cellphone}
  \gdef\chambertext     {ch.comm.}
  \gdef\datetext        {Date}
  \gdef\daystext        {days}
  \gdef\descriptiontext {Description}
  \gdef\emailtext       {email}
  \gdef\enclosurestext  {Enclosures:}
  \gdef\enclosuretext   {Enclosure:}
  \gdef\faxtext         {telefax}
  \gdef\invoicetext     {invoice}
  \gdef\oftext          {of}
  \gdef\ourreftext      {Our reference}
  \gdef\pagetext        {Page}
  \gdef\phonetext       {telephone}
  \gdef\referencetext   {Reference}
  \gdef\routingnotext   {Routing no}
  \gdef\subjecttext     {Subject:}
  \gdef\termtext        {term of payment}
  \gdef\totaltext       {Total}
  \gdef\totext          {To}
  \gdef\vatnotext       {vat no.}
  \gdef\vattext         {Vat}
  \gdef\websitetext     {website}
  \gdef\yourlettertext  {Your letter of}
  \gdef\yourreftext     {Your reference}
  \gdef\date{\ifcase\day\or
     1st\or  2nd\or  3rd\or  4th\or  5th\or
     6th\or  7th\or  8th\or  9th\or 10th\or
    11th\or 12th\or 13th\or 14th\or 15th\or
    16th\or 17th\or 18th\or 19th\or 20th\or
    21st\or 22nd\or 23rd\or 24th\or 25th\or
    26th\or 27th\or 28th\or 29th\or 30th\or
    31st\fi\space\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space \number\year}
}
\def\isodoc@USenglish{%
  \gdef\accountdatatext {Bank details}
  \gdef\accountnametext {in the name of}
  \gdef\accountnotext   {Account no.}
  \gdef\amounttext      {Amount}
  \gdef\ccname          {cc}
  \gdef\cellphonetext   {cellphone}
  \gdef\chambertext     {ch.comm.}
  \gdef\datetext        {Date}
  \gdef\daystext        {days}
  \gdef\descriptiontext {Description}
  \gdef\emailtext       {email}
  \gdef\enclosurestext  {Enclosures:}
  \gdef\enclosuretext   {Enclosure:}
  \gdef\faxtext         {telefax}
  \gdef\invoicetext     {invoice}
  \gdef\oftext          {of}
  \gdef\ourreftext      {Our reference}
  \gdef\pagetext        {Page}
  \gdef\phonetext       {telephone}
  \gdef\referencetext   {Reference}
  \gdef\routingnotext   {Routing no}
  \gdef\subjecttext     {Subject:}
  \gdef\termtext        {term of payment}
  \gdef\totaltext       {Total}
  \gdef\totext          {To}
  \gdef\vatnotext       {vat no.}
  \gdef\vattext         {Vat}
  \gdef\websitetext     {website}
  \gdef\yourlettertext  {Your letter of}
  \gdef\yourreftext     {Your reference}
  \gdef\date            {\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space\number\day, \number\year}
}
\endinput
%%
%% End of file `isodoc.cls'.
