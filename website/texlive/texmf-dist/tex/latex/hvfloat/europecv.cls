%!TEX encoding = UTF-8 Unicode
%
% European curriculum vitae class
% Author: Nicola Vitacolonna (vitacolo@dimi.uniud.it)
% This material is subject to the LaTeX Project Public License.
% See  http://www.ctan.org/tex-archive/help/Catalogue/licenses.lppl.html
% for the details of that license
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{europecv}[2006/04/24 (beta) European curriculum vitae class]

% CV models and instructions:
%   http://europass.cedefop.eu.int/htm/index.htm
% Recommendations:
%   http://europa.eu.int/scadplus/leg/en/cha/c11057.htm

\newcommand\ecv@utf[1]{{\inputencoding{utf8x}#1}}

% Set language
\DeclareOption{english}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecven.def}{}{%
    \ClassError{europecv}{English definition file 'ecven.def' not found}%
     {The file should be inside the europecv folder.\MessageBreak
    Try to re-install the europecv class.}}%
  }%
}
\DeclareOption{italian}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvit.def}{}{%
    \ClassWarningNoLine{europecv}{Italian definition file 'ecvit.def' not found}}%
  }%
}
\DeclareOption{spanish}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecves.def}{}{%
    \ClassWarningNoLine{europecv}{Spanish definition file 'ecves.def' not found}}%
  }%
}
\DeclareOption{french}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvfr.def}{}{%
    \ClassWarningNoLine{europecv}{French definition file 'ecvfr.def' not found}}%
  }%
}
\DeclareOption{danish}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvda.def}{}{%
    \ClassWarningNoLine{europecv}{Danish definition file 'ecvda.def' not found}}%
  }%
}
\DeclareOption{german}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvde.def}{}{%
    \ClassWarningNoLine{europecv}{German definition file 'ecvde.def' not found}}%
  }%
}
\DeclareOption{finnish}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvfi.def}{}{%
    \ClassWarningNoLine{europecv}{Finnish definition file 'ecvfi.def' not found}}%
  }%
}
\DeclareOption{portuges}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvpt.def}{}{%
    \ClassWarningNoLine{europecv}{Portuguese definition file 'ecvpt.def' not found}}%
  }%
}
\DeclareOption{portuguese}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvpt.def}{}{%
    \ClassWarningNoLine{europecv}{Portuguese definition file 'ecvpt.def' not found}}%
  }%
}
\DeclareOption{swedish}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvsv.def}{}{%
    \ClassWarningNoLine{europecv}{Swedish definition file 'ecvsv.def' not found}}%
  }%
}
\DeclareOption{norwegian}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvno.def}{}{%
    \ClassWarningNoLine{europecv}{Norwegian definition file 'ecvno.def' not found}}%
  }%
}
\DeclareOption{dutch}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvnl.def}{}{%
    \ClassWarningNoLine{europecv}{Dutch definition file 'ecvnl.def' not found}}%
  }%
}
\DeclareOption{catalan}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvca.def}{}{%
    \ClassWarningNoLine{europecv}{Catalan definition file 'ecvca.def' not found}}%
  }%
}
\DeclareOption{polish}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvpl.def}{}{%
    \ClassWarningNoLine{europecv}{Polish definition file 'ecvpl.def' not found}}%
  }%
}
\DeclareOption{hungarian}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvhu.def}{}{%
    \ClassWarningNoLine{europecv}{Hungarian definition file 'ecvhu.def' not found}}%
    \ecvpage{\thepage\ifx\@empty\ecv@totpages.\else\ecv@totpages\fi~\ecv@pagekey}
    \def\ecv@lfoot{%
  \footnotesize\textrm{\ecv@page~- \textrm{\ecv@footername} \ecv@cvofkey}}%
  }%
}
\DeclareOption{estonian}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvet.def}{}{%
    \ClassWarningNoLine{europecv}{Estonian definition file 'ecvet.def' not found}}%
  }%
}
\DeclareOption{icelandic}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvis.def}{}{%
    \ClassWarningNoLine{europecv}{Icelandic definition file 'ecvis.def' not found}}%
  }%
}
\DeclareOption{lithuanian}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvlt.def}{}{%
    \ClassWarningNoLine{europecv}{Lithuanian definition file 'ecvlt.def' not found}}%
  }%
}
\DeclareOption{czech}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvcs.def}{}{%
    \ClassWarningNoLine{europecv}{Czech definition file 'ecvcs.def' not found}}%
  }%
}
\DeclareOption{slovak}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvsk.def}{}{%
    \ClassWarningNoLine{europecv}{Slovak definition file 'ecvsk.def' not found}}%
  }%
}
\DeclareOption{latvian}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvlv.def}{}{%
    \ClassWarningNoLine{europecv}{Latvian definition file 'ecvlv.def' not found}}%
  }%
}
\DeclareOption{slovenian}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvsl.def}{}{%
    \ClassWarningNoLine{europecv}{Slovenian definition file 'ecvsl.def' not found}}%
  }%
}
\DeclareOption{romanian}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvro.def}{}{%
    \ClassWarningNoLine{europecv}{Romanian definition file 'ecvro.def' not found}}%
  }%
}
\DeclareOption{maltese}{%
  \AtEndOfPackage{%
    \InputIfFileExists{ecvmt.def}{}{%
    \ClassWarningNoLine{europecv}{Maltese definition file 'ecvmt.def' not found}}%
  }%
}
\DeclareOption{bulgarian}{%
  \AtEndOfPackage{%
      \InputIfFileExists{ecvbg.def}{}{%
      \ClassWarningNoLine{europecv}{Bulgarian definition file 'ecvbg.def' not found}}%
  }%
}
\DeclareOption{greek}{%
  \AtEndOfPackage{%
     \InputIfFileExists{ecvgr.def}{}{%
    \ClassWarningNoLine{europecv}{Greek definition file 'ecvgr.def' not found}}%
  }%
}
\DeclareOption{galician}{%
  \AtEndOfPackage{%
     \InputIfFileExists{ecvgl.def}{}{%
    \ClassWarningNoLine{europecv}{Galician definition file 'ecvgl.def' not found}}%
  }%
}
\DeclareOption{serbian}{%
  \AtEndOfPackage{%
     \InputIfFileExists{ecvsr.def}{}{%
    \ClassWarningNoLine{europecv}{Serbian definition file 'ecvsr.def' not found}}%
  }%
}


% Input encodings
\DeclareOption{ascii}{\AtEndOfClass{\inputencoding{ascii}}}
\DeclareOption{latin1}{\AtEndOfClass{\inputencoding{latin1}}}
\DeclareOption{latin2}{\AtEndOfClass{\inputencoding{latin2}}}
\DeclareOption{latin3}{\AtEndOfClass{\inputencoding{latin3}}}
\DeclareOption{latin4}{\AtEndOfClass{\inputencoding{latin4}}}
\DeclareOption{latin5}{\AtEndOfClass{\inputencoding{latin5}}}
\DeclareOption{latin9}{\AtEndOfClass{\inputencoding{latin9}}}
\DeclareOption{latin10}{\AtEndOfClass{\inputencoding{latin10}}}
\DeclareOption{decmulti}{\AtEndOfClass{\inputencoding{decmulti}}}
\DeclareOption{cp850}{\AtEndOfClass{\inputencoding{cp850}}}
\DeclareOption{cp852}{\AtEndOfClass{\inputencoding{cp852}}}
\DeclareOption{cp858}{\AtEndOfClass{\inputencoding{cp858}}}
\DeclareOption{cp437}{\AtEndOfClass{\inputencoding{cp437}}}
\DeclareOption{cp437de}{\AtEndOfClass{\inputencoding{cp437de}}}
\DeclareOption{cp865}{\AtEndOfClass{\inputencoding{cp865}}}
\DeclareOption{applemac}{\AtEndOfClass{\inputencoding{applemac}}}
\DeclareOption{next}{\AtEndOfClass{\inputencoding{next}}}
\DeclareOption{cp1250}{\AtEndOfClass{\inputencoding{cp1250}}}
\DeclareOption{cp1252}{\AtEndOfClass{\inputencoding{cp1252}}}
\DeclareOption{cp1257}{\AtEndOfClass{\inputencoding{cp1257}}}
\DeclareOption{ansinew}{\AtEndOfClass{\inputencoding{ansinew}}}
\DeclareOption{utf8}{\AtEndOfClass{\inputencoding{utf8x}}}
\DeclareOption{utf8x}{\AtEndOfClass{\inputencoding{utf8x}}}
\DeclareOption{koi8-r}{\AtEndOfClass{\inputencoding{koi8-r}}}
\DeclareOption{koi8-ru}{\AtEndOfClass{\inputencoding{koi8-ru}}}
\DeclareOption{koi8-u}{\AtEndOfClass{\inputencoding{koi8-u}}}
\DeclareOption{cp1251}{\AtEndOfClass{\inputencoding{cp1251}}}
\DeclareOption{cp855}{\AtEndOfClass{\inputencoding{cp855}}}
\DeclareOption{cp866}{\AtEndOfClass{\inputencoding{cp866}}}
\DeclareOption{maccyr}{\AtEndOfClass{\inputencoding{maccyr}}}
\DeclareOption{macukr}{\AtEndOfClass{\inputencoding{macukr}}}

% Set font
\DeclareOption{helvetica}{%                       
  \renewcommand{\rmdefault}{phv}
  \renewcommand{\sfdefault}{phv}
}
\DeclareOption{arial}{%                       
  \renewcommand{\rmdefault}{ma1} % (this font is NOT installed by default!)
  \renewcommand{\sfdefault}{ma1}
}
\DeclareOption{narrow}{
  \renewcommand{\seriesdefault}{mc} % Narrow
  \renewcommand{\bfdefault}{bc}  % Boldface narrow
}
% No title
% This must come *after* language definitions
\DeclareOption{notitle}{%
  \AtEndOfPackage{\renewcommand*\ecvtitle{}}%
}

% Europass logo
\DeclareOption{logo}{%
\providecommand*\draweuropasslogo{%
   \includegraphics[width=\ecv@logowidth]{europasslogo}}
}
\DeclareOption{nologo}{\renewcommand*\draweuropasslogo{}}

% Flag pictures of the EC can be found at 
%   http://europa.eu.int/abc/symbols/emblem/index_en.htm
\DeclareOption{noflag}{\providecommand*\draweuropeflag{}}
\DeclareOption{flagWB}{%
  \renewcommand*\draweuropeflag{%
    \includegraphics[width=\ecv@flagwidth]{EuropeFlagWB}}
}
\DeclareOption{flagBW}{%
  \renewcommand*\draweuropeflag{%
    \includegraphics[width=\ecv@flagwidth]{EuropeFlagBW}}
}
\DeclareOption{flagCMYK}{%
  \renewcommand*\draweuropeflag{%
    \includegraphics[width=\ecv@flagwidth]{EuropeFlagCMYK}}
}
\DeclareOption{flagBlueCMYK}{%
 \renewcommand*\draweuropeflag{%
   \includegraphics[width=\ecv@flagwidth]{EuropeFlagBlueCMYK}}
}

% Page numbering
\DeclareOption{totpages}{%
  \AtEndOfPackage{\RequirePackage{totpages}%
  \def\ecv@totpages{~/~\ref{TotPages}}
  %\ecvpage{\ecv@pagekey~\thepage~/~\ref{TotPages}}%
  }%
}

\DeclareOption{booktabs}{%
  \AtEndOfPackage{\RequirePackage{booktabs}}
  \def\ecv@booktabs{}
}
% Pass all other options (a4paper, 10pt, draft, openbib, etc...) to article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
} 

\ExecuteOptions{english,noflag,logo,hrule} % Default options

\ProcessOptions\relax

\LoadClass{article}
\RequirePackage{ucs}
\RequirePackage[utf8x]{inputenc}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{fancyhdr} % For page numbering

\def\ecv@totpages{}
\newcommand*{\ecvpage}[1]{\def\ecv@page{#1}}
\ecvpage{\ecv@pagekey~\thepage\ecv@totpages}

% Page number
\def\ecv@lfoot{%
  \footnotesize\textrm{\ecv@page~-~\ecv@cvofkey}\\
  \textrm{\ecv@footername}
}

% Right Footnote to be shown on every page
\newcommand\ecvfootnote[1]{\def\ecv@rfoot{#1}}
\ecvfootnote{}

\AtBeginDocument{%
% Ensure that \ecv@leftcolwidth and \ecv@rightcolwidth
% are correctly defined
\ecvLeftColumnWidth{\ecv@leftcolwidth}
% Set layout
\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}
\fancyfoot[L]{\begin{minipage}{\ecv@leftcolwidth}
\begin{flushright}\footnotesize\ecv@lfoot\end{flushright}%
\end{minipage}
}
\fancyfoot[R]{\begin{minipage}{\ecv@rightcolwidth}
\footnotesize\ecv@rfoot
\end{minipage}}
\renewcommand{\headrulewidth}{0pt}%
} % End \AtBeginDocument

% Thanks to Roman Bertle for suggesting the following:
\renewcommand{\labelitemi}{\normalfont\bfseries \textendash}
\renewcommand{\labelitemii}{\textasteriskcentered}
\renewcommand{\labelitemiii}{\textperiodcentered}

\newcommand*{\ecvfirstname}[1]{\def\ecv@firstname{#1}} % Deprecated
\newcommand*{\ecvlastname}[1]{\def\ecv@lastname{#1}} % Deprecated
\newcommand*{\ecvname}[1]{\def\ecv@name{#1}} % Replaces the above
\newcommand*{\ecvfootername}[1]{\def\ecv@footername{#1}}
\newcommand*{\ecvaddress}[1]{\def\ecv@address{#1}}
\newcommand*{\ecvtelephone}[2][]{\def\ecv@telephone{#2}\def\ecv@mobile{#1}}
\newcommand*{\ecvfax}[1]{\def\ecv@fax{#1}}
\newcommand*{\ecvemail}[1]{\def\ecv@email{#1}}
\newcommand*{\ecvhomepage}[1]{\def\ecv@homepage{#1}}
\newcommand*{\ecvnationality}[1]{\def\ecv@nationality{#1}}
\newcommand*{\ecvdateofbirth}[1]{\def\ecv@birth{#1}}
\newcommand*{\ecvgender}[1]{\def\ecv@gender{#1}}
% Personal picture
\newcommand*{\ecvdrawpicture}{}
\newcommand*{\ecvbeforepicture}[1]{\def\ecv@beforepic{#1}}
\newcommand*{\ecvafterpicture}[1]{\def\ecv@afterpic{#1}}
\newcommand*\ecvpicture{%
\@ifnextchar[\ecv@picture{\ecv@picture[]}}
\def\ecv@picture[#1]#2{%
\def\ecvarg{#2}
\ifx\@empty\ecvarg\renewcommand*{\ecvdrawpicture}{}\else
\renewcommand*{\ecvdrawpicture}{\includegraphics[#1]{#2}}
\fi}
% The following must be used inside \ecvbeforepicture
% or \ecvafterpicture
\newcommand*{\ecvspace}[1]{\tabularnewline[#1] &}
\ecvbeforepicture{\raggedleft}
\ecvafterpicture{}
\ecvfirstname{}
\ecvlastname{}
\ecvname{\ecv@lastname\ \ecv@firstname}
\ecvfootername{\ecv@name}
\ecvaddress{}
\ecvtelephone{}
\ecvfax{}
\ecvemail{}
\ecvnationality{}
\ecvdateofbirth{}
\ecvgender{}
\ecvpicture{}

\providecommand{\ecvpersonalinfo}[1][0pt]{%
& \tabularnewline
\ifx\@empty\ecvdrawpicture\else
   &\ecv@beforepic\ecvdrawpicture\ecv@afterpic\tabularnewline
\fi
{\large\par\textbf{\ecv@infosectionkey}} & \tabularnewline
& \tabularnewline
\ecv@namekey & \large\textbf{\ecv@name}\tabularnewline[5pt]
\ifx\@empty\ecv@address\else
\ecv@addresskey     &\ecv@address   \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@telephone\else
\ecv@telkey         &\ecv@telephone
 \ifx\@empty\ecv@mobile\else\qquad\ecv@mobilekey: \ecv@mobile\fi
\tabularnewline[5pt]
\fi
\ifx\@empty\ecv@fax\else
\ecv@faxkey         &\ecv@fax \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@email\else
\ecv@emailkey       &\ecv@email \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@nationality\else
\ecv@nationalitykey & \ecv@nationality \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@birth\else
\ecv@birthkey       & \ecv@birth \tabularnewline[5pt]
\fi
\ifx\@empty\ecv@gender\else
\ecv@genderkey      & \ecv@gender \tabularnewline[#1]
\fi
}

% Spoken language information
\newcommand*\ecvmothertongue[2][0pt]{%
{\large\ecv@mothertonguekey} & \large\textbf{#2}\tabularnewline[#1]
}
\newlength\ecv@langparwidth

\ifx\ecv@booktabs\undefined % Use table conforming to EU model
  \newcommand*\ecvlanguageheader[1]{%
  {\large\textit{\ecv@assesskey}}\\ \textit{\ecv@levelkey}${}^{\mbox{\scriptsize#1}}$&
  \setlength\extrarowheight{2pt}
  \begin{tabular}[t]{|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|}
  \firsthline
  \multicolumn{2}{|c|}{\textbf{\ecv@understandkey}}&\multicolumn{2}{c|}{\textbf{\ecv@speakkey}}&\centering\textbf{\ecv@writekey}\tabularnewline\cline{1-4}
  \centering\small{\ecv@listenkey}   & \centering \small{\ecv@readkey} &\centering \small{\ecv@interactkey} &\centering \small{\ecv@productkey} & \tabularnewline
  %\lasthline
  \hline
  \end{tabular} \tabularnewline[-\arrayrulewidth]
  }
  \newcommand*\ecvlanguage[7][0pt]{
  {\textbf{#2}} &
  \setlength\extrarowheight{0pt}
  \begin{tabular}{|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|m{\ecv@langparwidth}|}
  \hline
   #3 & #4 & #5 & #6 & #7 \tabularnewline
  \hline
  \end{tabular}\vspace{#1}
  \tabularnewline[-\arrayrulewidth]
  }
  \newcommand*\ecvlastlanguage[7][0pt]{\ecvlanguage[#1]{#2}{#3}{#4}{#5}{#6}{#7}}
\else % Use booktabs
  \newcommand*\ecvlanguageheader[1]{%
  {\large\textit{\ecv@assesskey}}\\ \textit{\ecv@levelkey}${}^{\mbox{\scriptsize#1}}$&
  \setlength\extrarowheight{0pt}
  \begin{tabular}[t]{m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}}
  \toprule
  \multicolumn{2}{c}{\textbf{\ecv@understandkey}}&\multicolumn{2}{c}{\textbf{\ecv@speakkey}}&\centering\textbf{\ecv@writekey}\tabularnewline
  \centering\small{\ecv@listenkey}   & \centering \small{\ecv@readkey} &\centering \small{\ecv@interactkey} &\centering \small{\ecv@productkey} & \tabularnewline
  \midrule
  \end{tabular}\vspace{2\arrayrulewidth}\tabularnewline
  }
  \newcommand*\ecvlanguage[7][0pt]{
  {\textbf{#2}} &
  \setlength\extrarowheight{0pt}
  \begin{tabular}{m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}}
   #3 & #4 & #5 & #6 & #7\tabularnewline \midrule
  \end{tabular}\vspace{#1}
  \tabularnewline
  }
  \newcommand*\ecvlastlanguage[7][0pt]{
  {\textbf{#2}} &
  \setlength\extrarowheight{0pt}
  \begin{tabular}{m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}m{\ecv@langparwidth}}
   #3 & #4 & #5 & #6 & #7\tabularnewline \bottomrule
  \end{tabular}\vspace{#1}
  \tabularnewline
  }
\fi

\newcommand*\ecvlanguagefooter[2][0pt]{\ecvitem[#1]{}{\quad\footnotesize{${}^{\mbox{\tiny#2}}$\textit{\ecv@langfooterkey}}}}

% See the Common European Framework of Reference for Languages:
% http://www.coe.int/T/E/Cultural_Co-operation/education/Languages/Language_Policy/Common_Framework_of_Reference/default.asp
\ifx\ecv@booktabs\undefined % Use table conforming to EU model
  \newcommand*\ecvCEF[2]{%
  %\setlength\tabcolsep{1mm}
  \begin{tabular}{@{}>{\footnotesize}p{.2\ecv@langparwidth}@{\hspace{1mm}}>{\footnotesize\centering}p{.74\ecv@langparwidth}@{}}
#1 & #2\tabularnewline
  \end{tabular}
  }
\else
  \newcommand*\ecvCEF[2]{%
  %\setlength\tabcolsep{1mm}
  \begin{tabular}{@{}>{\footnotesize}p{.2\ecv@langparwidth}@{\hspace{1mm}}>{\footnotesize\centering}p{.74\ecv@langparwidth}@{}}
#1 & #2\tabularnewline
  \end{tabular}
  }
\fi

\newcommand*\ecvAOne{\ecvCEF{A1}{\ecv@cefbasickey}}
\newcommand*\ecvATwo{\ecvCEF{A2}{\ecv@cefbasickey}}
\newcommand*\ecvBOne{\ecvCEF{B1}{\ecv@cefindepkey}}
\newcommand*\ecvBTwo{\ecvCEF{B2}{\ecv@cefindepkey}}
\newcommand*\ecvCOne{\ecvCEF{C1}{\ecv@cefprofkey}}
\newcommand*\ecvCTwo{\ecvCEF{C2}{\ecv@cefprofkey}}

\def\ecv@kern{\kern0.5pt}
%\def\ecv@kern{}
\newcommand*{\ecvTitleKern}[1]{\def\ecv@kern{\kern#1}}
\newlength\ecv@rulewidth
\newlength\ecv@colsep
\newlength\ecv@leftcolwidth
\newlength\ecv@rightcolwidth
\newlength\ecv@extrarowheight
\newcommand*{\ecvRuleWidth}[1]{\setlength\ecv@rulewidth{#1}}
\newcommand*{\ecvColSep}[1]{%
  \addtolength{\ecv@leftcolwidth}{\ecv@colsep}
  \addtolength{\ecv@rightcolwidth}{\ecv@colsep}
  \setlength\ecv@colsep{#1}
  \addtolength{\ecv@leftcolwidth}{-\ecv@colsep}
  \addtolength{\ecv@rightcolwidth}{-\ecv@colsep}}
\newcommand*{\ecvLeftColumnWidth}[1]{\setlength\ecv@leftcolwidth{#1}%
             \setlength{\ecv@rightcolwidth}{\textwidth}
            \addtolength{\ecv@rightcolwidth}{-\ecv@leftcolwidth}
            \addtolength{\ecv@rightcolwidth}{-2\ecv@colsep}
            \addtolength{\ecv@rightcolwidth}{-\ecv@rulewidth}}
\newcommand*{\ecvExtraRowHeight}[1]{\setlength\ecv@extrarowheight{#1}}
\newcommand*{\ecvNoHorRule}{\def\ecv@hrule{}}
\newcommand*{\ecvWithHorRule}{\def\ecv@hrule{\cline{1-1}}}
% Initialization
\ecvRuleWidth{\arrayrulewidth}
\setlength\ecv@colsep{12pt}
\setlength\ecv@leftcolwidth{50mm} % Default left column width
\ecvExtraRowHeight{0pt}
\ecvWithHorRule

% Flag size
\newlength\ecv@flagwidth
\newcommand*{\ecvFlagWidth}[1]{\setlength\ecv@flagwidth{#1}}
\ecvFlagWidth{10mm}

% Logo size
\newlength\ecv@logowidth
\newlength\ecv@logooffset
\newcommand*{\ecvLogoWidth}[1]{\setlength\ecv@logowidth{#1}}
\newcommand*{\ecvLogoOffset}[1]{\setlength\ecv@logooffset{#1}}
\ecvLogoWidth{2.30cm}
\ecvLogoOffset{1cm}
%\typeout{logo width=\the\ecv@logowidth}
%\typeout{logo offset=\the\ecv@logooffset}

% Text bullet
\newcommand{\ecvbullet}{\raisebox{.35ex}[0cm][0cm]{\tiny\textbullet}}
                                          
\newenvironment{europecv}{%
  \ecvLeftColumnWidth{\ecv@leftcolwidth}
  \setlength\arrayrulewidth{\ecv@rulewidth}
  \setlength\extrarowheight{\ecv@extrarowheight}
  \setlength\LTleft{0pt}
  \setlength\LTright{0pt}
  % Language table paragraph width
  \setlength\ecv@langparwidth{.199\ecv@rightcolwidth}
  \addtolength{\ecv@langparwidth}{-2\tabcolsep}
  \addtolength{\ecv@langparwidth}{-2\arrayrulewidth}
% Begin
\begin{longtable}[l]{@{}>{\raggedleft}p{\ecv@leftcolwidth}@{\hspace{\ecv@colsep}}|@{\extracolsep{\ecv@colsep}}p{\ecv@rightcolwidth}@{}}
  \ecv@hrule
  \ifx\@empty\draweuropasslogo\else
    % Any better way of achieving the same result?!?
    \vskip-\ecv@logooffset\draweuropasslogo\hfill\phantom{.}& \tabularnewline
  \fi
  \ifx\@empty\ecvtitle\else
     \ifx\@empty\draweuropasslogo
       & \tabularnewline[-.5em]
     \fi
     \ecvtitle &\tabularnewline
  \fi
  \ifx\@empty\draweuropeflag\else
     & \tabularnewline
     \draweuropeflag& \tabularnewline
  \fi
}
{\end{longtable}}

\newcommand{\ecvsection}[2][10pt]{%
  {\large{\par\textbf{#2}}}\vspace{#1} & \tabularnewline\nopagebreak
}
          
\newif\if@ecvitemstar
\newcommand\ecvitem{\@ifstar{\@ecvitemstartrue \@ecvitem}%
  {\@ecvitemstarfalse\@ecvitem}}
\newcommand\@ecvitem[3][2pt]{%
  \if@ecvitemstar \ecvbullet\ \fi #2\vspace{#1} & #3
    \vspace{#1}\tabularnewline}
