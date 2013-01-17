%%
%% Copyright (C) 2006-2008 by:
%% Josef Kleber
%% <josef.kleber@gmx.net>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2003/12/01 or later.
%% 
%% This work has the LPPL maintenance status "author-maintained".
%% 
%% This Current Maintainer of this work is Josef Kleber.
%%
%% This work consists of all files listed in manifest.txt.
%%
%
\NeedsTeXFormat{LaTeX2e}%
%
\ProvidesClass{dvdcoll}[2008/04/21 dvdcoll.cls v1.1a - Josef Kleber (C) 2006-2008]%
%
\RequirePackage{xkeyval}%
\RequirePackage{ifthen}%
%
%
% define class option language for setting a language
\define@key{dvdcoll.cls}{language}[babel]%
{%
  \ifthenelse{\NOT\equal{#1}{babel}}%
  {%no babel
    \def\dc@option@language{#1}%
  }%
  {%babel
    \def\dc@option@language{#1}%
	\AtBeginDocument%
	{%
	  \ifthenelse{\NOT\equal{\dc@option@language}{babel}}%
	  {%no babel
	    \InputIfFileExists{\dc@option@language.dcl}%
        {}%
        {%
          \input{english.dcl}%
	      \ClassWarningNoLine{dvdcoll}%
	      {%
	        You tried to use option language=\dc@option@language\MessageBreak
	        <\dc@option@language> is at the moment not available\MessageBreak
	        dvdcoll.cls is using english instead!\MessageBreak
	        Please take a look at <english.dcl>,\MessageBreak
	        translate it to your language and email\MessageBreak
	        it to:  dvdcoll@web.de
	      }%
        }%
	  }%
	  {%babel
	    \@ifpackageloaded{babel}%
		{% yes
	      \def\dc@option@language{\languagename}%
	      \InputIfFileExists{\dc@option@language.dcl}%
          {}%
          {%
            \input{english.dcl}%
	        \ClassWarningNoLine{dvdcoll}%
	        {%
	          You tried to use babel with option <\dc@option@language>\MessageBreak
	          <\dc@option@language> is at the moment not available\MessageBreak
	          dvdcoll.cls is using english instead!\MessageBreak
	          Please take a look at <english.dcl>,\MessageBreak
	          translate it to your language and email\MessageBreak
	          it to:  dvdcoll@web.de
	        }%
          }%
		}%
		{% no
		  \input{english.dcl}%
		  \ClassWarningNoLine{dvdcoll}%
		  {%
		    You did not specify a language via Package <babel>\MessageBreak
			or with the dvdcoll option language.\MessageBreak
			dvdcoll is using <english> as default instead
		  }%
		}%
	  }%
	}%
  }%
}%
%
% define class option dvdlabel for horizontal positioning of the label
\define@choicekey*{dvdcoll.cls}{dvdlabel}[\valuedvdcoll\nr]{wide,narrow}[wide]%
{%
  \ifcase\nr\relax%
    \def\dc@option@dvdlabel{\hfill}%
  \or%
    \def\dc@option@dvdlabel{\hspace{1em}}%
  \fi%
}%
%
% define class option dvdskip for vertical space after Dvd
\define@choicekey*{dvdcoll.cls}{dvdskip}[\valuedvdskip\nr]{small,medium,big}[medium]%
{%
  \ifcase\nr\relax%
    \def\dc@addvspace@endDvd{\dc@smallskip}%
  \or%
    \def\dc@addvspace@endDvd{\dc@medskip}%
  \or%
    \def\dc@addvspace@endDvd{\dc@bigskip}%
  \fi%
}%
%
% define class option pagenumbers (yes,no)
\define@choicekey*{dvdcoll.cls}{pagenumbers}[\valuepagenumbers\nr]{yes,no}[yes]%
{%
  \ifcase\nr\relax%
    {}%
  \or%
    \AtBeginDocument%
	{%
	  \pagestyle{empty}%
	  \let\ps@plain=\ps@empty% LaTeX Begleiter S.231
	}%
  \fi%
}%
%
% define class option heading for numbered or unnumbered headings
\define@choicekey*{dvdcoll.cls}{heading}[\valueheading\nr]{number,nonumber}[nonumber]%
{%
  \ifcase\nr\relax%
  {%
	\AtBeginDocument%
	{%
	  \setcounter{secnumdepth}{4}%
	  \SetTOCSecIndent{2.2em}%
	  \SetLFRSecNumwidth{4.5em}%
	}%
  }%
  \or%
    \AtEndOfClass{\SetTOCNumwidth{2.2em}}% default
    \AtBeginDocument%
	{%
	  \setcounter{secnumdepth}{-2}%
	  \SetTOCSecIndent{0em}%
	  \SetLFRSecNumwidth{0em}%
	}%
  \fi%
}%
%
% define class option pdfencoding (pdfdocencoding,unicode)
\define@choicekey*{dvdcoll.cls}{pdfencoding}[\valuepdfdocencoding\nr]{pdfdocencoding,unicode}[pdfdocencoding]%
{%
  \ifcase\nr\relax%
    {%
	  \ClassInfo{dvdcoll.cls}{set unicode=false}
	  \PassOptionsToPackage{unicode=false}{hyperref}%
	  % use simplified but runtime optimized version for pdf encoding
	  \AtEndOfClass%
	  {%
	    \renewcommand\Description[1]%
        {%
          \def\dc@dummy{}%
          \pn@pdf@string@def\dc@dummy{##1}%
          \gdef\pn@pdf@desc{\dc@dummy}%
        }%
	  }%
	}%
  \or%
	{%
	  \ClassInfo{dvdcoll.cls}{set unicode=true}
	  \PassOptionsToPackage{unicode=true}{hyperref}%
	  % use standard \pdfstringdef (hyperref) for pdf encoding
	  \AtEndOfClass%
	  {%
	    \renewcommand\Description[1]%
        {%
          \def\dc@dummy{}%
          \pdfstringdef\dc@dummy{##1}%
          \gdef\pn@pdf@desc{\dc@dummy}%
        }%
	  }%
	}%
  \fi%
}%
%
% define command option (DvdSeries) dvdnumbering for dvd numbering style
\define@choicekey*{DvdSeries}{dvdnumbering}[\valuedvdnumbering\nr]{normal,season}[normal]%
{%
  \ifcase\nr\relax%
    \renewcommand{\dc@option@dvdnumbering}{normal}%
	\renewcommand*\toclevel@dcdvd{1}%
  \or%
    \renewcommand{\dc@option@dvdnumbering}{season}%
	\renewcommand*\toclevel@dcdvd{2}%
  \fi%
}%
%
% define command option (DvdSeries) titlenumbering for dvd title numbering style
\define@choicekey*{DvdSeries}{titlenumbering}[\valuetitlenumbering\nr]{normal,season}[normal]%
{%
  \ifcase\nr\relax%
    \renewcommand{\dc@option@titlenumbering}{normal}%
  \or%
    \renewcommand{\dc@option@titlenumbering}{season}%
  \fi%
}%
%
% define command option (DvdSeries) labelbase for setting a base counter in automatic labeling
\define@key{DvdSeries}{labelbase}[-1]%
{%
  \renewcommand*\dc@option@labelbase{#1}%
  \setcounter{labelcount}{#1}%
  \addtocounter{labelcount}{-1}%
}%
%
% define command option (DvdSeries) labelbase for setting a prefix of the base counter in automatic labeling
\define@key{DvdSeries}{labelbaseprefix}[]%
{%
  \renewcommand*\dc@option@labelbaseprefix{#1}%
}%
%
% define command option (DvdSeries) labelbase for setting a suffix of the base counter in automatic labeling
\define@key{DvdSeries}{labelbasesuffix}[]%
{%
  \renewcommand*\dc@option@labelbasesuffix{#1}%
}%
%
% define command option (DvdSeries) labelbase for setting the length of the base counter in automatic labeling
\define@key{DvdSeries}{labelbaselength}[4]%
{%
  \ifnum#1<1%
    \ClassError{dvdcoll}{labelbaselength < 1}{labelbaselength < 1 makes no sense\MessageBreak%
	                                          please increase labelbaselength}%
  \fi%
  \renewcommand*\dc@option@labelbaselength{#1}%
}%
%
% setting defaults
\ExecuteOptionsX{dvdlabel,dvdskip,pagenumbers,heading,language,pdfencoding}%
%
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{scrreprt}}%
%
\ProcessOptionsX\relax%
%
\LoadClass{scrreprt}%
%
\RequirePackage{tabularx}%
\RequirePackage{booktabs}%
\RequirePackage{array}%
\RequirePackage{multicol}%
\RequirePackage{ragged2e}%
\RequirePackage{pdfnotiz}%
\RequirePackage{dcwrtbib}%
\RequirePackage[naturalnames=true,hypertexnames=false]{hyperref}[2008/04/12]%
%--- naturalnames=true,hypertexnames=false --- verhindert das mehrfache Anlegen von hyperref-Ankern
%                                              (bedingt durch das Rücksetzen des Zahlers chapter)
%                                              und beseitigt die Warnungen (ext4) von hyperref
%
%
%--- Package adjustments ---
%
%avoid ugly looking frame overlays in \DvdTitleWithDescription
\setlength\extrarowheight{2pt}%
%
%
%--- Counters ---
%
\newcounter{dvdcount}[chapter]%
\newcounter{titlecount}[dvdcount]%
\newcounter{season}%
\newcounter{seasontitlecount}%
\newcounter{seasondvd}%
% for generation of labelbase
\newcounter{labelcount}%
% to produce a unique hyperref destination for season bookmark
\newcounter{bookmarkcount}%
\setcounter{bookmarkcount}{0}%
%to prevent several bookmarks for the same season
\newcounter{bookmarkseason}%
%
%
%--- Variables ---
%
\def\dc@part{}%
\def\dc@series{}%
\def\dc@title{}%
%
%
%--- Internal Commands ---
%
\def\dc@third{min}%
\def\dc@addhspace@title@count{0.7em}%
% used hspace in the BibTeX file
\def\DvdBibSpace{\string\hspace{0.7em}}%
%
% \***skip aus source2e; etwas vergrößert
\def\dc@smallskip{\vspace{6pt plus 2pt minus 2pt}}%
\def\dc@medskip{\vspace{12pt plus 4pt minus 4pt}}%
\def\dc@bigskip{\vspace{18pt plus 6pt minus 6pt}}%
%
% font sizes used in the tables
\def\dc@size@table@cells{\large}%
\def\dc@size@table@title{\Large}%
%
% dummy for .dcl definitons
\newcommand*\dc@miss{}%
\newcommand*\dc@lfrname{}%
\newcommand*\dc@ledname{}%
\newcommand*\dc@pdf@subject{}%
\newcommand*\dc@dvdlist{}%
\newcommand*\dc@season{}%
\newcommand*\dc@pdftitle{}%
\newcommand*\dc@dvd@shorthand@off{}%
\newcommand*\dc@dvd@shorthand@on{}%
%
%
\newcommand*\dc@option@titlenumbering{}%
\newcommand*\dc@option@dvdnumbering{}%
\newcommand*\dc@option@labelbase{}%
\newcommand*\dc@option@labelbaseprefix{}%
\newcommand*\dc@option@labelbasesuffix{}%
\newcommand*\dc@option@labelbaselength{}%
%
%
\newcommand*\dc@pcwlz[1]% PrintCounterWithLeadingZero
{%
  \ifnum\value{#1}<10{0}\fi%
  \arabic{#1}%
}%
%
%
\newcommand*\dc@print@counter%
{%
  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
  {%season
    \dc@pcwlz{season}x\dc@pcwlz{seasontitlecount}%
  }%
  {%normal
    \thetitlecount{}.%
  }%
}%
%
%
\newcommand*\dc@calc@dvdcounter%
{%
  \ifthenelse{\equal{\dc@option@dvdnumbering}{season}}%
  {%season
    \def\dc@dvdcounter{\theseason.\theseasondvd}%
  }%
  {%normal
    \def\dc@dvdcounter{\thedvdcount}%
  }%
}%
%
%
\newcommand*\dc@print@dvdlabel[1]%
{%
  \ifthenelse{\equal{}{#1}}%
  {}% no label!
  {%
    \textbf{[#1]}%
  }%
}%
%
% all \leadzeros provided by Heiko Oberdiek in d.c.t.t, Msg-Id: <eqrquu$f52$1@news.BelWue.DE>
\newcommand*{\leadzero}[2]{%
  \ifnum#2<0 %
    -%
    \expandafter\@leadzero\expandafter{%
      \romannumeral\number#1000\expandafter
    }\expandafter{%
      \number-#2%
    }%
    \expandafter\@firstofone\expandafter{\number-#2}%
  \else
    \expandafter\@leadzero\expandafter{%
      \romannumeral\number#1000\expandafter
    }\expandafter{%
      \number#2%
    }%
    \expandafter\@firstofone\expandafter{\number#2}%
  \fi
}
\def\@leadzero#1#2{%
  \ifx\\#2\\%
    \@@leadzero#1\@nil
  \else
    \ifx\\#1\\%
    \else
      \expandafter\@@@leadzero\expandafter{\@gobble#2}{#1}%
    \fi
  \fi
}
\def\@@leadzero#1\@nil#2\fi\fi{%
  \fi
  \ifx\\#1\\%
  \else
    0%
    \expandafter\@@leadzero\@gobble#1\@nil
    \iftrue\fi
  \fi
}
\def\@@@leadzero#1#2\fi\fi{%
  \fi
  \fi
  \expandafter\@leadzero\expandafter{\@gobble#2}{#1}%
}
%
\renewcommand*{\thelabelcount}{%
  \leadzero{\dc@option@labelbaselength}{\value{labelcount}}%
}%
%
% create new toc type with same definition as section
\let\l@dcdvd\l@section
%
% define a bookmark level (section) for dcdvd toc-entry
\newcommand*\toclevel@dcdvd{1}%
\newcommand*\toclevel@lfrsec{1}%
\newcommand*\toclevel@ledsec{1}%
%
\hypersetup{pdfkeywords={LaTeX,dvdcoll.cls,DVD,Archiv,archives}}%
\AtEndOfClass{\AtBeginDocument{\hypersetup{pdfcreator={LaTeX with dvdcoll.cls},pdftitle={\dc@pdftitle}}}}%
%
%
%--- Commands ---
%
\newcommand*\SetLFRName[1]%
{%
  \renewcommand*\dc@lfrname{#1}%
}%
%
%
\newcommand\Description[1]%
{%
  \def\dc@dummy{}%
  \pn@pdf@string@def\dc@dummy{#1}%
  \gdef\pn@pdf@desc{\dc@dummy}%
}%
%
%
\newcommand*\SetCounterSpace[1]%
{%
  \def\dc@addhspace@title@count{#1}%
}%
%
%
\newcommand*\SetThirdColumnAddition[1]%
{%
  \def\dc@third{#1}%
}%
%
%
\newcommand*\DvdCounter%
{%
  \DvdSpace\dc@dvdcounter%
}%
%
%
\newcommand*\AutoTitle%
{%
  \dc@series\DvdCounter\DvdSpace%
}%
%
%
\newcommand*\DvdSpace%
{%
  \hspace{\dc@addhspace@title@count}%
}%
%
%
\newcommand*\SetSeason[2][1]%
{%
  \setcounter{season}{#2}%
  \ifthenelse{#1 = 1}%
  {%
    \setcounter{seasondvd}{0}% just reset if #1 = 1
  }%
  {}% 
  %if dvdnumbering=season
  \ifthenelse{\equal{\dc@option@dvdnumbering}{season}}%
  {% and bookmark is to be set for the first time
	\ifthenelse{\thebookmarkseason = #2}%
    {}%
    {% create season bookmark
      \pdfbookmark[1]{\dc@season{} \theseason}{seasonbookmark*.\thebookmarkcount.\theseason}%
      % store season in bookmarkseason to prevent several bookmarks of the same season
      \setcounter{bookmarkseason}{#2}%
    }%
  }%
  {}%
  \setcounter{seasontitlecount}{#1}%
  \addtocounter{seasontitlecount}{-1}%
}%
%
%
\newcommand*\DvdPart[1]%
{%
  \part{#1}%
  \def\dc@part{#1}%
  \setcounter{chapter}{0}%
}%
%
%
\newcommand*\DvdSeries[2][titlenumbering=normal,dvdnumbering=normal,labelbase=-1,labelbaseprefix={},labelbasesuffix={},labelbaselength=4]%
{%default - default setting of xkeyval seem not to work??? all or nothing???
  \renewcommand*\dc@option@dvdnumbering{normal}%
  \renewcommand*\dc@option@titlenumbering{normal}%
  \renewcommand*\dc@option@labelbase{-1}%
  \renewcommand*\dc@option@labelbaseprefix{}%
  \renewcommand*\dc@option@labelbasesuffix{}%
  \renewcommand*\dc@option@labelbaselength{4}%
%
  \setkeys{DvdSeries}{#1}%
  %reset season bookmark indicator
  \setcounter{bookmarkseason}{-1}%
  % create unique hyperref destination for season bookmark
  \stepcounter{bookmarkcount}%
  \ifthenelse{\equal{\dc@option@dvdnumbering}{season}}%
  {%adjust toclevel for dvd bookmark (with or without season bookmark)
    \renewcommand*\toclevel@dcdvd{2}%
  }%
  {%
    \renewcommand*\toclevel@dcdvd{1}%
  }%
  %\SetSeason{1}%
  %would produce double season bookmark entries, therefore ...
  \setcounter{season}{1}%
  \setcounter{seasondvd}{0}%
  \setcounter{seasontitlecount}{0}%
  \chapter{#2}%
  \def\dc@series{#2}%
  \setcounter{season}{-1}%
  \ifthenelse{\equal{\valueheading}{nonumber}}%
  {%
    \setcounter{dvdcount}{0}%
  }%
  % setting heading=nonumber (secnumdepth=-2) means no automatic reset 
  % of dvdcount because chapter get not reset
  {}%
}%
%
%
\newcommand*\DvdTitle[2]%
{%
  %increasing counter depending on titlenumbering
  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
  {\refstepcounter{seasontitlecount}}%
  {\refstepcounter{titlecount}}%
  %if marker F is set
  \ifthenelse{\equal{\dc@miss}{#2}}%
  {%
    %lfr entry absolutly before tabular line, otherwise error in the table - don't no why!
    %lfr entry without numbers if heading=nonumber
	\ifthenelse{\equal{\valueheading}{nonumber}}%
    {%
      \addcontentsline{lfr}{lfrsec}{\protect\numberline{} \dc@series\ - #1}%
    }%
    {%
	  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
      {%season
        \addcontentsline{lfr}{lfrsec}{\protect\numberline{\thepart.\thechapter.\theseason.\theseasontitlecount} \dc@series\ - #1}%
      }%
      {%normal
        \addcontentsline{lfr}{lfrsec}{\protect\numberline{\thepart.\thechapter.\thedvdcount.\thetitlecount} \dc@series\ - #1}%
      }%
    }%
    %construct table
    \dc@print@counter & #1\strut & \hfill\dc@miss \tabularnewline%
  }%
  {%
    \ifthenelse{\equal{}{#2}}%
	  % no min
      {\dc@print@counter & #1\strut & \tabularnewline}%
	  % with min
      {\dc@print@counter & #1\strut & \hfill{}#2~\dc@third \tabularnewline}%
  }%
}%
%
%
\newcommand*\DvdTitleWithDescription[2]%
{%
  %increasing counter depending on titlenumbering
  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
  {\refstepcounter{seasontitlecount}}%
  {\refstepcounter{titlecount}}%
  %if description is empty
  \ifthenelse{\equal{\pn@pdf@desc}{}}%
  {%
    %led entry without numbers if heading=nonumber
	\ifthenelse{\equal{\valueheading}{nonumber}}%
    {%
      \addcontentsline{led}{ledsec}{\protect\numberline{} \dc@series\ - #1}%
    }%
    {%
	  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
      {%season
        \addcontentsline{led}{ledsec}{\protect\numberline{\thepart.\thechapter.\theseason.\theseasontitlecount} \dc@series\ - #1}%
      }%
      {%normal
        \addcontentsline{led}{ledsec}{\protect\numberline{\thepart.\thechapter.\thedvdcount.\thetitlecount} \dc@series\ - #1}%
      }%
	}%	
  }%
  {}%
  % if marker F is set
  \ifthenelse{\equal{\dc@miss}{#2}}%
  {%
    %lfr entry absolutly before tabular line, otherwise error in the table - don't no why!
    %lfr entry without numbers if heading=nonumber
	\ifthenelse{\equal{\valueheading}{nonumber}}%
    {%
      \addcontentsline{lfr}{lfrsec}{\protect\numberline{} \dc@series\ - #1}%
    }%
    {%
	  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
      {%season
        \addcontentsline{lfr}{lfrsec}{\protect\numberline{\thepart.\thechapter.\theseason.\theseasontitlecount} \dc@series\ - #1}%
      }%
      {%normal
        \addcontentsline{lfr}{lfrsec}{\protect\numberline{\thepart.\thechapter.\thedvdcount.\thetitlecount} \dc@series\ - #1}%
      }%
	}%	
    \dc@print@counter & \makebox[0pt]{}\pdfnote{#1\strut} & \hfill\dc@miss \tabularnewline%
  }%
  {%
    \ifthenelse{\equal{}{#2}}%
	  % no min
      {\dc@print@counter & \makebox[0pt]{}\pdfnote{#1\strut} & \tabularnewline}%
	  % with min
      {\dc@print@counter & \makebox[0pt]{}\pdfnote{#1\strut} & \hfill{}#2~\dc@third \tabularnewline}%
  }%
}%
%
%
\setlength\columnseprule{0.5pt}
\addtolength\columnsep{5pt}
%no automatic heading -> clash with multicols
\renewcommand*\bib@heading{\@mkboth{\refname}{\refname}}
%labels without brackets
\renewcommand\@biblabel[1]{#1}
\newcommand*\dc@bibpreamble{\begin{multicols}{\dc@bib@col}\RaggedRight\small}
\newcommand*\dc@bibend{\end{multicols}}%
\newcommand{\listofdvds}[2][]%
{%
  \ifthenelse{\equal{}{#2}}{\def\dc@bib@col{2}}{\def\dc@bib@col{#2}}%
  \bibliographystyle{dcbib}%
  \nocite{*}%
  \ifthenelse{\equal{}{#1}}%
  {\renewcommand\refname{\dc@dvdlist}}%
  {\renewcommand\refname{#1}}%
  \clearpage%
  \chapter*{\refname}%
  \addcontentsline{toc}{part}{\dc@dvdlist{}}%
  \phantomsection%
  \dc@bibpreamble%
  \bibliography{dc_\jobname}%
  \dc@bibend%
}%
%
\newcommand{\listoffaultyrecordings}%
{%
  \setboolean{@restonecol}{false}%
  \ifthenelse{\boolean{@twocolumn}}%
    {\setboolean{@restonecol}{true}\onecolumn}%
    {}%
  \@ifundefined{chapter}%
    {\section*{\dc@lfrname\@mkboth{\dc@lfrname}{\dc@lfrname}}}%
    {\chapter*{\dc@lfrname\@mkboth{\dc@lfrname}{\dc@lfrname}}}%
  {%
    \setlength{\parindent}{0pt}%
    \@starttoc{lfr}%
  }%
  \ifthenelse{\boolean{@restonecol}}%
    {\twocolumn}%
    {}%
  \addcontentsline{toc}{part}{\dc@lfrname{}}%
}%
%
%
\newcommand{\listofemptydescriptions}%
{%
  \setboolean{@restonecol}{false}%
  \ifthenelse{\boolean{@twocolumn}}%
    {\setboolean{@restonecol}{true}\onecolumn}%
    {}%
  \@ifundefined{chapter}%
    {\section*{\dc@ledname\@mkboth{\dc@ledname}{\dc@ledname}}}%
    {\chapter*{\dc@ledname\@mkboth{\dc@ledname}{\dc@ledname}}}%
  {%
    \setlength{\parindent}{0pt}%
    \@starttoc{led}%
  }%
  \ifthenelse{\boolean{@restonecol}}%
    {\twocolumn}%
    {}%
  \addcontentsline{toc}{part}{\dc@ledname}%
}%
%
%
\newcommand\l@lfrsec{\@dottedtocline{1}{0em}{0em}}%
%
%
\newcommand\l@ledsec{\@dottedtocline{1}{0em}{0em}}%
%
%
\newcommand\SetLFRSecNumwidth[1]%
{%
  \renewcommand*\l@lfrsec{\@dottedtocline{1}{0pt}{#1}}%
}%
%
%
\newcommand\SetTOCSecIndent[1]%
{%
  \renewcommand*\l@dcdvd{\@dottedtocline{1}{#1}{0pt}}%
}%
%
%
\newcommand*\SetTOCNumwidth[1]%
{%
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne%
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@%
    \setlength\@tempdima{#1}%
    \if@tocleft%
      \ifx\toc@l@number\@empty\else%
        \setlength\@tempdima{0\toc@l@number}%
      \fi%
    \fi%
    \begingroup%
      \parindent \z@ \rightskip \@pnumwidth%
      \parfillskip -\@pnumwidth%
      \leavevmode \sectfont%
      \advance\leftskip\@tempdima%
      \hskip -\leftskip%
      ##1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss ##2}\par%
      \penalty\@highpenalty%
    \endgroup%
  \fi}%
%
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax%
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{#1}%
    \if@tocleft%
      \ifx\toc@l@number\@empty\else%
        \setlength\@tempdima{0\toc@l@number}%
      \fi%
    \fi%
    \begingroup%
      \parindent \z@ \rightskip \@pnumwidth%
      \parfillskip -\@pnumwidth%
      \leavevmode\sectfont\large%
      \advance\leftskip\@tempdima%
      \hskip -\leftskip%
      ##1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss ##2}\par%
      \penalty\@highpenalty%
    \endgroup%
  \fi}%
}%
%
%  
%--- Environments ---
%
%
\newenvironment{Dvd}[2]%
{%
  %prevents unwanted spaces in the table
  \endlinechar=-1%
  %switching off language dependant shorthands (babel) within environment Dvd
  \dc@dvd@shorthand@off%
  %Hack von Markus Kohm zur Behebung des \bottomrule-Problems bei \endtabularx in Environments (-> Google-Groups)
  \expandafter\let\expandafter\SavedEndTab\csname endtabular*\endcsname%
  \expandafter\renewcommand\expandafter*\csname endtabular*\endcsname{%
    \midrule%
    \SavedEndTab%
  }%
  \refstepcounter{dvdcount}% \refstepcounter für hyperref-Link auf die jeweilige DVD
  \refstepcounter{seasondvd}%
  \stepcounter{labelcount}%
  \dc@calc@dvdcounter% to have correct counter in "text" form
  \ifthenelse{\equal{}{#1}}{\def\dc@title{\dc@series\DvdCounter}}{\def\dc@title{#1}}%
  {%local redefinition for BibTeX export
    \renewcommand*\DvdSpace{\DvdBibSpace}%
	\ifthenelse{\equal{}{#1}}{\xdef\dc@bib@title{\dc@series\DvdCounter}}{\xdef\dc@bib@title{#1}}%
  }
  %create label
  \ifthenelse{\equal{}{#2}}%
  {%#2 empty
    \ifthenelse{\equal{\dc@option@labelbase}{-1}}%
	{%default
	  \def\dc@dvd@label{}%
	}%
	{%labelbase set
	  \def\dc@dvd@label{\dc@option@labelbaseprefix\thelabelcount\dc@option@labelbasesuffix}%
	}%
  }%
  {%#2 not empty
    \def\dc@dvd@label{#2}%
  }%
  \addcontentsline{toc}{dcdvd}{\dc@title}%
  \phantomsection% korrigiert fehlerhafte (falsch positionierte) Links auf dvd-Tabellen
  \ifthenelse{\equal{}{\dc@dvd@label}}%
  {}%
  {%
    \bibwrite{@misc{\dc@dvd@label ,author={{\dc@bib@title}},year={\dc@dvd@label}}}%
  }%
  \noindent%
  % verhindert overfull \hbox Errors wegen \tabularx{\linewidth}...
  \tabularx{\linewidth}{>{\dc@size@table@cells}r>{\dc@size@table@cells}X>{\dc@size@table@cells}r}%
	\multicolumn{3}{l}{\dc@size@table@title\dc@title\dc@option@dvdlabel\dc@print@dvdlabel{\dc@dvd@label}}\\%
    \midrule%
}%
{%
  %\midrule% bereits in der Definition enthalten durch Hack von Markus Kohm siehe oben
  \endtabularx%
  \dc@addvspace@endDvd%
  %switching on shorthands again
  \dc@dvd@shorthand@on%
}%
%
\endinput%