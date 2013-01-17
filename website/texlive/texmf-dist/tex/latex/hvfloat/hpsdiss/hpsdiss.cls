%%
%% This is file `hpsdiss.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% hpsdiss.dtx 
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from hpsdiss.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file hpsdiss.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{hpsdiss}[2000/10/26 PhD thesis class by Hanspeter Schmid]
\DeclareOption{twocolumn}{%
  \@latex@warning{hpsdiss.cls does not accept the option `twocolumn'.}%
  \OptionNotUsed}
\DeclareOption{raggedright}{\newcommand{\TextAlignment}{\RaggedRight}}
\DeclareOption{specialfonts}{\newcommand{\SpecialFonts}{\relax}}
\DeclareOption{deutsch}{\newcommand{\DT@deutsch}{\relax}}
\DeclareOption{francais}{\newcommand{\DT@francais}{\relax}}
\DeclareOption{italiano}{\newcommand{\DT@italiano}{\relax}}
\DeclareOption{scnat}{\newcommand{\DT@scnat}{\relax}}
\DeclareOption{scmath}{\newcommand{\DT@scmath}{\relax}}
\DeclareOption{female}{\newcommand{\DT@female}{\relax}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\PassOptionsToClass{twoside}{book}
\ProcessOptions
\LoadClass{book}
\RequirePackage{geometry}
\RequirePackage{calc}
\RequirePackage{ragged2e}
\RequirePackage{rotating}
\RequirePackage{mparhack}
\RequirePackage{graphicx}
\RequirePackage{colordvi}
\newcommand{\MarginParWidth}{26mm}
\newcommand{\MarginParSep}{4mm}
\newcommand{\TotalWidth}{118.5mm}
\geometry{paper=a5paper,dvips=true,twoside=true}
\geometry{width=\TotalWidth,height=192mm,top=7mm,twosideshift=7mm}
\geometry{headheight=4mm,headsep=9mm}
\geometry{nofoot}
\geometry{marginparsep=\MarginParSep,marginparwidth=\MarginParWidth}
\ifx\SpecialFonts\undefined
  \newcommand{\CapFont}{\em}
  \newcommand{\CapNumFont}{\sf\bfseries}
  \newcommand{\SecFont}{\sf\bfseries}
  \newcommand{\SecNumFont}{\sf\bfseries}
  \newcommand{\ChapFont}{\sf\bfseries}
  \newcommand{\TitleFont}{\sf\bfseries}
  \newcommand{\HeaderFont}{\sf\small}
  \newcommand{\BackgroundFont}{\em}
  \newcommand{\DTfont@author}{\sf\bfseries}
  \newcommand{\DTfont@normal}{\sf}
  \newcommand{\DTfont@series}{\sf\bfseries}
  \newcommand{\DTfont@title}{\sf\bfseries}
\else
  \newcommand{\CapFont}{\em}
  \newcommand{\CapNumFont}{\usefont{T1}{bgs}{b}{r}\selectfont}
  \newcommand{\SecFont}{\usefont{T1}{bgs}{b}{r}\selectfont}
  \newcommand{\SecNumFont}{\usefont{T1}{bgs}{b}{r}\selectfont}
  \newcommand{\ChapFont}{\usefont{T1}{bgs}{b}{r}\selectfont}
  \newcommand{\TitleFont}{\usefont{T1}{bgs}{b}{r}\selectfont}
  \newcommand{\HeaderFont}{\usefont{T1}{bgs}{r}{r}\selectfont}
  \newcommand{\BackgroundFont}{%
    \usefont{T1}{bc9}{r}{r}\selectfont%
    \renewcommand{\emph}[1]{{##1}}}
  \newcommand{\DTfont@author}{\usefont{T1}{bgs}{b}{r}\selectfont}
  \newcommand{\DTfont@normal}{\usefont{T1}{bgs}{r}{r}\selectfont}
  \newcommand{\DTfont@series}{\usefont{T1}{bgs}{b}{r}\selectfont}
  \newcommand{\DTfont@title}{\usefont{T1}{bgs}{b}{r}\selectfont}
\fi
\newcommand{\noparskip}{\parskip=\z@ \@plus\z@ \@minus\z@}
\ifx\TextAlignment\undefined
  \newcommand{\TextAlignment}{\relax}
  \parindent=0pt
\else\fi
\AtBeginDocument{\TextAlignment}
\parskip=2ex \@plus 0.5ex \@minus 0.5ex
\widowpenalty 10000
\clubpenalty 10000
\@clubpenalty 10000
\def\@listi{\leftmargin\leftmargini
  \parsep \z@ \@plus2\p@ \@minus\z@
  \topsep \z@ \@plus2\p@ \@minus\z@
  \itemsep\z@ \@plus2\p@ \@minus\z@}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
  \labelwidth\leftmarginii
  \advance\labelwidth-\labelsep
  \topsep \z@ \@plus2\p@  \@minus\z@
  \parsep \z@ \@plus\p@ \@minus\z@
  \itemsep \parsep}
\def\@listiii{\leftmargin\leftmarginiii
  \labelwidth\leftmarginiii
  \advance\labelwidth-\labelsep
  \topsep \z@ \@plus\p@ \@minus\z@
  \parsep \z@ \@minus\z@
  \partopsep \z@ \plus\z@ \@minus\z@
  \itemsep \topsep}
\def\@listiv {\leftmargin\leftmarginiv
  \labelwidth\leftmarginiv
  \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
  \labelwidth\leftmarginv
  \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
  \labelwidth\leftmarginvi
  \advance\labelwidth-\labelsep}
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xpt\@xiipt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus\z@
   \abovedisplayshortskip \z@ \@plus3\p@ \@minus\z@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\renewcommand\small{%
   \@setfontsize\small\@ixpt{11}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus\z@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep \z@ \@plus2\p@ \@minus\z@
               \parsep \z@ \@plus\p@ \@minus\z@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
   }
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize\@viiipt{9.5}%
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus\z@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep \z@ \@plus\p@ \@minus\z@
               \parsep \z@ \@plus\p@ \@minus\z@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\def\ps@headings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{%
    \hskip-\marginparsep\hskip-\marginparwidth%
    \makebox[\marginparsep+\marginparwidth][l]{\HeaderFont\thepage}%
    {\makebox[\textwidth][l]{\HeaderFont\vphantom{g}\leftmark}}}
  \def\@oddhead{%
    {\makebox[\textwidth][r]{\HeaderFont\vphantom{g}\rightmark}}%
    \makebox[\marginparsep+\marginparwidth][r]{\HeaderFont\thepage}%
    \hskip-\marginparsep\hskip-\marginparwidth}
  \let\@mkboth\markboth
  \def\chaptermark##1{%
    \markboth {%
      \ifnum \c@secnumdepth >\m@ne %
        \if@mainmatter \@chapapp\ \thechapter. \ \fi %
      \fi %
      ##1}{}}%
  \def\sectionmark##1{%
    \markright {%
      \ifnum \c@secnumdepth >\z@ %
      \thesection. \ %
      \fi %
      ##1}}}
\pagestyle{headings}
\renewcommand\tableofcontents{%
  \chapter*{\contentsname\@mkboth{\contentsname}{\contentsname}}%
  \@starttoc{toc}}
\renewcommand\listoffigures{%
  \chapter*{\listfigurename\@mkboth{\listfigurename}{\listfigurename}}%
  \@starttoc{lof}}
\renewcommand\listoftables{%
  \chapter*{\listtablename\@mkboth{\listtablename}{\listtablename}}%
  \@starttoc{lot}}
\newcounter{autolabels}%
\renewenvironment{thebibliography}[1]
{\chapter*{\bibname\@mkboth{\bibname}{\bibname}}%
  \small %
  \addcontentsline{toc}{chapter}{\bibname}
  \renewcommand{\@mklab}[1]{%
    \refstepcounter{autolabels}%
    \label{autolabel:\theautolabels}%
    \expandafter\ifx\csname r@autolabel:\theautolabels \endcsname\relax %
      \edef\ThePage{1}%
    \else %
      \edef\ThePage{\pageref{autolabel:\theautolabels}}%
    \fi %
    \makebox[0pt][l]{\hbox{}\hskip\textwidth \hskip\marginparsep %
      \ifodd\ThePage {##1}\else \phantom{##1}\fi}%
    \makebox[0pt][l]{\hbox{}\hskip-\marginparsep \makebox[0pt][r]{%
        \ifodd\ThePage \phantom{##1}\else{##1}\fi }}%
    \hfil\hbox{}}
  \list{\@biblabel{\@arabic\c@enumiv}}%
  {\labelwidth=0pt%
    \leftmargin=0pt%
    \labelsep=0pt%
    \itemsep=1ex%
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}
{%
  \normalsize %
  \def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}
\renewcommand\sidewaysfigure{\let\inside@rotated@float=\relax %
  \@rotfloat{figure}}
\renewcommand\sidewaystable{\let\inside@rotated@float=\relax %
  \@rotfloat{table}}
\def\caption{%
  \ifx\@captype\@undefined
    \@latex@error{\noexpand\caption outside float}\@ehd
    \expandafter\@gobble
  \else
    \stepcounter{autolabels}%
    \refstepcounter\@captype
    \label{autolabel:\theautolabels}%
    \expandafter\@firstofone
  \fi
  {\@dblarg{\@caption\@captype}}%
  }
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \expandafter\ifx\csname r@autolabel:\theautolabels \endcsname\relax %
    \edef\ThePage{1}%
  \else %
    \edef\ThePage{\pageref{autolabel:\theautolabels}}%
  \fi
  \ifx\inside@rotated@float\undefined
      \makebox[0pt][r]{\makebox[0pt][l]{\CapNumFont %
          \ifodd\ThePage \phantom{#1}\else {#1}\fi}%
        \hskip\marginparsep \hskip\marginparwidth \hbox{}}%
      \makebox[0pt][l]{%
        \ifodd\ThePage %
        \parbox[t]{\TotalWidth-\MarginParWidth-\MarginParSep}%
        {\raggedleft \CapFont #2}%
        \else %
        \phantom{\parbox[t]{\TotalWidth-\MarginParWidth-\MarginParSep}%
          {\raggedleft \CapFont #2}}%
        \fi}%
      \makebox[0pt][l]{%
        \ifodd\ThePage %
        \phantom{\parbox[t]{\TotalWidth-\MarginParWidth-\MarginParSep}%
          {\raggedright \CapFont #2}}%
        \else %
        \parbox[t]{\TotalWidth-\MarginParWidth-\MarginParSep}%
        {\raggedright \CapFont #2}%
        \fi}%
      \hfill %
      \makebox[0pt][l]{\hbox{}\hskip\marginparsep \hskip\marginparwidth %
        \makebox[0pt][r]{\CapNumFont %
          \ifodd\ThePage {#1}\else \phantom{#1}\fi}}%
    \vskip\belowcaptionskip %
  \else
    \sbox\@tempboxa{{\CapNumFont #1:} \CapFont #2}%
    \ifdim \wd\@tempboxa >\hsize
      {\CapNumFont #1:} \CapFont #2\par
    \else
      \global \@minipagefalse
      \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
    \fi %
  \fi}
\setlength\abovecaptionskip{6\p@}
\setlength\belowcaptionskip{10\p@}
\renewcommand\part{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \thispagestyle{empty}%
  \@tempswafalse
  \null\vfil
  \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    \fullwidthbox{%
      \centering
      \interlinepenalty \@M
      \normalfont
      \ifnum \c@secnumdepth >-2\relax
        \huge\ChapFont \partname~\thepart
        \par
        \vskip 20\p@
      \fi
      \Huge \ChapFont #2\par%
    }
    \@endpart}
\def\@spart#1{%
    \fullwidthbox{
      \centering
      \interlinepenalty \@M
      \normalfont
      \Huge \ChapFont #1\par%
    }
    \@endpart}
\renewcommand\chapter{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \thispagestyle{empty}%
  \@tempswafalse
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}
\def\@makechapterhead#1{%
  {\parindent \z@ \raggedleft \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \huge \ChapFont \@chapapp\space \thechapter
        \par\nobreak
        \vskip 12\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \ChapFont #1\par\nobreak
    \vskip 12\p@
  }}
\def\@makeschapterhead#1{%
  {\parindent \z@ \raggedleft
    \normalfont
    \interlinepenalty\@M
    \Huge \ChapFont  #1\par\nobreak
    \vskip 40\p@
  }}
\newcommand{\chapquote}[2]{%
  {\ChapFont
    \RaggedLeft #1

    (#2)
    \vskip 40\p@
    }}
\newcommand{\chapnoquote}{\null\vskip 28\p@}
\newenvironment{chapabstract}{%
  \setlength{\leftskip}   {\z@skip}%
  \setlength{\@rightskip} {\z@skip}%
  \setlength{\rightskip}  {\@rightskip}%
  \parfillskip=0pt plus 1fil %
  }{\par}
\renewcommand{\section}{%
  \@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\SecFont\Large}}
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\SecFont\large}}
\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\SecFont\normalsize}}
\renewcommand{\paragraph}[1]{\noindent\textbf{#1}}
\def\@seccntformat#1{\csname the#1\endcsname}
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
    \edef\ThePage{1}
  \else
    \stepcounter{autolabels}
    \refstepcounter{#1}%
    \expandafter\ifx\csname r@autolabel:\theautolabels \endcsname\relax %
      \edef\ThePage{1}%
    \else %
      \edef\ThePage{\pageref{autolabel:\theautolabels}}%
    \fi
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      {%
        \makebox[0pt][l]{%
          \hbox{}\hskip\textwidth \hskip\marginparsep %
          \hskip\marginparwidth \makebox[0pt][r]{#6\SecNumFont %
            \ifodd \ThePage \@svsec \else \phantom{\@svsec}\fi %
            }}%
        \makebox[0pt][r]{%
          \makebox[0pt][l]{#6\SecNumFont %
            \ifodd \ThePage \phantom{\@svsec}\else \@svsec \fi }%
          \hskip\marginparwidth \hskip\marginparsep}%
        #6{\interlinepenalty \@M #8\@@par}}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}%
  \ifnum #2>\c@secnumdepth %
  \else %
  \label{autolabel:\theautolabels}%
  \fi %
  }
\long\def\fullwidthbox#1{%
  \stepcounter{autolabels}%
  \def\@fullwidthboxlabel{autolabel:\theautolabels}%
  \expandafter\ifx\csname r@autolabel:\theautolabels \endcsname\relax %
    \edef\ThePage{1}%
  \else %
    \edef\ThePage{\pageref{autolabel:\theautolabels}}%
  \fi %
  \ifodd\ThePage %
  \else %
    \hbox{}\hskip-\marginparwidth \hskip-\marginparsep %
  \fi %
  \makebox[0pt][l]{%
    \begin{minipage}{\linewidth+\marginparwidth+\marginparsep}%
      #1%
    \end{minipage}%
    }%
      \protected@edef\@currentlabel{\relax}%
      \label{\@fullwidthboxlabel}%
  }
\long\def\fullwidthinfloat#1#2{%
  \expandafter\ifx\csname r@#1\endcsname\relax %
    \edef\ThePage{1}%
  \else %
    \edef\ThePage{\pageref{#1}}%
  \fi %
  \ifodd\ThePage %
  \else %
    \hbox{}\hskip-\marginparwidth \hskip-\marginparsep %
  \fi %
  \makebox[0pt][l]{%
    \parbox{\linewidth+\marginparwidth+\marginparsep}{%
      \ifodd\ThePage %
      \else %
      \null \hfill %
      \fi %
      \ifodd\ThePage \raggedright \else \raggedleft \fi %
      #2%
      }%
    }%
  }%
\newcommand{\Abstract}[1]{%
  {\footnotesize %
  \marginpar[\footnotesize\raggedright\hspace{0pt}{#1}]%
  {\footnotesize\raggedleft\hspace{0pt}{#1}}}}
\newcommand{\MarginPar}[1]{%
  \marginpar[\RaggedRight\hspace{0pt}{#1}]{\RaggedLeft\hspace{0pt}{#1}}}
\newcommand{\MarginParVar}[1]{%
  \marginpar[\RaggedLeft\hspace{0pt}{#1}]{\RaggedRight\hspace{0pt}{#1}}}
\newenvironment{bkgnd}{\begingroup \BackgroundFont}{\endgroup}
\newcommand{\DTauthor}{Hanspeter Schmid}
\newcommand{\DTborn}{February 8, 1969}
\newcommand{\DTcitizen}{H\"arkingen SO}
\newcommand{\DTdate}{November 2000}
\newcommand{\DTdegree}{dipl.\ El.-Ing.\ ETH}
\newcommand{\DTexaminers}{Prof.\ Dr.\ George S. Moschytz, examiner\\
  Prof.\ Dr.\ Qiuting Huang, co-examiner}
\newcommand{\DTnumber}{13878}
\newcommand{\DTtitle}{Single-Amplifier\\ Biquadratic\\ MOSFET--C Filters}
\newcommand{\DTvolume}{1}
\newcommand{\DTissn}{1616-671X}
\newcommand{\DTisbn}{3-89649-616-6}
\newcommand{\DTprice}{98,--}
\newcommand{\DT@accepted}{accepted on the recommendation of}
\newcommand{\DT@born}{born on}
\newcommand{\DT@citizen}{citizen of}
\newcommand{\DT@dissertation}{A dissertation submitted to the\\
  Swiss Federal Institute of Technology, Z\"urich\\
  for the degree of}
\newcommand{\DT@dissertationB}{}
\newcommand{\DT@doctor}{Doctor of Technical Sciences}
\ifx\DT@scnat\undefined\else
  \renewcommand{\DT@doctor}{Doctor of Natural Sciences}
\fi
\ifx\DT@scmath\undefined\else
  \renewcommand{\DT@doctor}{Doctor of Mathematics}
\fi
\newcommand{\DT@number}{Diss.~ETH No~}
\newcommand{\DT@presented}{presented by}
\ifx\DT@deutsch\undefined\else
  \renewcommand{\DT@accepted}{Angenommen auf Antrag von}
  \renewcommand{\DT@born}{geboren am}
  \renewcommand{\DT@citizen}{von}
  \renewcommand{\DT@dissertation}{Abhandlung\\
    zur Erlangung des Titels}
  \renewcommand{\DT@dissertationB}{\\der Eidgen\"ossischen
    Technischen Hochschule Z\"urich}
  \ifx\DT@female\undefdined
    \newcommand{\DT@@doctor}{Doktor}
  \else
    \newcommand{\DT@@doctor}{Doktorin}
  \fi
  \renewcommand{\DT@doctor}{\DT@@doctor\ der technischen
    Wissenschaften}
  \ifx\DT@scnat\undefined\else
    \renewcommand{\DT@doctor}{\DT@@doctor\ der Naturwissenschaften}
  \fi
  \ifx\DT@scmath\undefined\else
    \renewcommand{\DT@doctor}{\DT@@doctor\ der Mathematik}
  \fi
  \renewcommand{\DT@number}{Diss.~ETH Nr.~}
  \renewcommand{\DT@presented}{vorgelegt von}
\fi
\ifx\DT@italiano\undefined\else
  \renewcommand{\DT@accepted}{accettata su proposta di}
  \renewcommand{\DT@born}{nato il}
  \renewcommand{\DT@citizen}{attinente di}
  \renewcommand{\DT@dissertation}{Dissertatzione presentata al\\
    Politecnico Federale di Zurigo\\
    per il conseguimento del titolo di}
  \renewcommand{\DT@doctor}{Dottore in scienze techniche}
  \ifx\DT@scnat\undefined\else
    \renewcommand{\DT@doctor}{Dottore in scienze naturali}
  \fi
  \ifx\DT@scmath\undefined\else
    \renewcommand{\DT@doctor}{Dottore in matematica}
  \fi
  \renewcommand{\DT@number}{Diss.~ETH no~}
  \renewcommand{\DT@presented}{da}
\fi
\ifx\DT@francais\undefined\else
  \renewcommand{\DT@accepted}{accept\'ee sur proposition du}
  \ifx\female\undefined
    \renewcommand{\DT@born}{n\'e le}
  \else
    \renewcommand{\DT@born}{n\'ee le}
  \fi
  \renewcommand{\DT@citizen}{originaire de}
  \renewcommand{\DT@dissertation}{pr\'esent\'ee \`a\\
    L'\'Ecole Polytechnique F\'ed\'erale Z\"urich\\
    pour l'obtention du titre de}
  \renewcommand{\DT@doctor}{Docteur d\'es sciences techniques}
  \ifx\DT@scnat\undefined\else
    \renewcommand{\DT@doctor}{Docteur d\'es sciences naturelles}
  \fi
  \ifx\DT@scmath\undefined\else
    \renewcommand{\DT@doctor}{Docteur d\'es sciences math\'ematiques}
  \fi
  \renewcommand{\DT@number}{Th\`ese~EPFZ No~}
  \renewcommand{\DT@presented}{par}
\fi
\newcommand{\dissinnertitle}{%
  \newcommand{\DT@innertitle}{\relax}%
  \disstitle}
\newcommand{\disstitle}{%
  \thispagestyle{empty}%
  {\parskip=0pt%
    \parindent=0pt%
    \unitlength=0.1mm%
    \null\vfill%
    \begin{picture}(0,0)(220,110)%
      \ifx\DT@innertitle\undefined
      \put(40,40){%
        \makebox(0,0)[bl]{%
          \ifx\DTimage\undefined %
          \rule{32mm}{202mm}%
          \else %
          \includegraphics[width=32mm,height=202mm]{\DTimage}%
          \fi %
          }}
      \fi
      \put(60,2020){%
        \makebox(0,0)[tl]{%
          \hbox to 28mm{%
            \vbox to 194mm{%
              \begin{minipage}[t]{28mm}
                \DTfont@series \Large \raggedleft
                \White{Series in}%
                \makebox[0cm][l]{\null\hspace*{6mm}\hbox{%
                    \normalsize \DTfont@normal %
                    \DT@number \DTnumber}}\\
                \White{Signal and}\\
                \White{Information}\\
                \White{Processing}\\[1.5ex]
                \White{Volume \DTvolume}
              \end{minipage}

              \vfill

              \begin{minipage}[b]{28mm}
                \DTfont@series \Large \raggedleft
                \White{Hartung}\\
                \White{Gorre}\\
                \White{Konstanz}%
                \makebox[0cm][l]{\null\hspace*{6mm}\hbox{%
                    \normalsize \DTfont@normal %
                    \ifx\DT@innertitle\undefined\else %
                      Hartung-Gorre Verlag, Konstanz, %
                    \fi %
                    \DTdate}}
              \end{minipage}}}}}
      \put(400,2020){%
        \makebox(0,0)[tl]{%
          \hbox to 97mm{%
            \vbox to 194mm{%
              \DTfont@normal \phantom{\DT@number \DTnumber}

              \vfill

              \Huge {\DTfont@title \DTtitle}

              \normalsize

              \vfill

              \DT@dissertation\\
              \DT@doctor \DT@dissertationB

              \vfill

              \DT@presented

              \medskip

              \LARGE {\DTfont@author \DTauthor}
              \normalsize

              \medskip
              \DTdegree\\
              \DT@born\ \DTborn\\
              \DT@citizen\ \DTcitizen

              \vfill

              \DT@accepted\\
              \DTexaminers

              \bigskip

              \phantom{\DTdate}
              }}}}%
    \end{picture}%
    }%
  \clearpage
  \thispagestyle{empty}
  \hbox{}
  \clearpage}
\newcommand{\dissback}{%
  \thispagestyle{empty}
  \hbox{}
  \clearpage
  \thispagestyle{empty}%
  {\parskip=0pt%
    \parindent=0pt%
    \unitlength=0.1mm%
    \null\vfill%
    \begin{picture}(0,0)(360,110)%
      \put(80,2020){%
        \makebox(0,0)[tl]{%
          \hbox to 132.5mm{%
            \vbox to 194mm{%
              \null\vfill

              \begin{minipage}[b]{132.5mm}
              \Large
              \DTfont@series
              Series in Signal and Information Processing\\
              \DTfont@normal edited by Hans-Andrea Loeliger\\[1.5ex]
              $\boldsymbol \sum$ Hartung-Gorre Verlag
              Konstanz\\[1.5ex]
              ISSN \DTissn\quad ISBN \DTisbn\quad DM \DTprice
              \end{minipage}
              }}}}%
    \end{picture}%
    }}
\endinput
%%
%% End of file `hpsdiss.cls'.
