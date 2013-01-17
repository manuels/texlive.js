%%
%% This is file `timesht.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% timesht.dtx  (with options: `style')
%% 
%% This file is part of the Timesheet package.
%% Copyright (C) 1996 Frank Bennett, Jr.
%% All rights reserved.
%% ------------------------------------------
%% This is a generated file.
%% 
%% IMPORTANT NOTICE:
%% 
%% You are not allowed to change this file.  You may however copy
%% this file to a file with a different name and then change the
%% copy if (a) you do not charge for the modified code, (b) you
%% acknowledge  the author(s) in the new file, if it
%% is distributed to others, and (c) you attach these same
%% conditions to the new file.
%% 
%% You are not allowed to distribute this file alone.  You are not
%% allowed to take money for the distribution or use of this file
%% (or a changed version) except for a nominal charge for copying
%% etc.
%% 
%% You are allowed to distribute this file under the condition that
%% it is distributed with all of its contents, intact.
%% 
%% For error reports, or offers to help make Timesheet a more powerful,
%% friendlier, and better package, please contact me on
%% `fb' at soas.ac.uk
%% 
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesPackage{timesht}
          [1996/11/09 v0.03 Timesheet generator (Frank Bennett)]
\DeclareOption{a4paper}{\OptionNotUsed}
\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{b5paper}{\OptionNotUsed}
\DeclareOption{letterpaper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{titlepage}{\OptionNotUsed}
\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption{10pt}{\PassOptionsToPackage{\CurrentOption}{article}}
\DeclareOption{11pt}{\PassOptionsToPackage{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToPackage{\CurrentOption}{article}}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{calendar}}
\ProcessOptions
\LoadClass[oneside]{article}
\pagestyle{empty}
\setlength{\parindent}{1em}
\setlength{\rightskip}{0pt plus \textwidth}
\setlength{\@rightskip}{\rightskip}
\setlength{\parfillskip}{0pt plus 2\textwidth}
\setlength{\columnsep}{2em}
\setlength{\textheight}{230mm}
\setlength{\topmargin}{-10mm}
\setlength{\linewidth}{\textwidth}
 \setlength{\textwidth}{180mm}
\setlength{\oddsidemargin}{-10mm}
\newcounter{timecount}
\newcounter{timecountlimit}
\newlength{\timesheetleft}
\newlength{\timesheetright}
\newif\if@makehash
\settowidth{\timesheetleft}{00:00\ --\ 00:00}
\addtolength{\timesheetleft}{5\arrayrulewidth}
\addtolength{\timesheetleft}{6\tabcolsep}
\addtolength{\timesheetleft}{\doublerulesep}
\setlength{\timesheetright}{\textwidth}
\addtolength{\timesheetright}{-\timesheetleft}
\def\@@maketimes#1{\xdef\timearg{\the\c@timecount}
\addtocounter{timecount}{1}%
\\\hline
\@makehashtrue
\timearg &00& \timearg &10&&\\
\timearg &10& \timearg &20&&\\
\timearg &20& \timearg &30&&\\
\timearg &30& \timearg &40&&\\
\timearg &40& \timearg &50&&\\
\timearg &50&\arabic{timecount}&00&&%
\@makehashfalse}
\def\@maketimes{\@@maketimes{\arabic{timecount}}%
 \ifnum\c@timecount>\c@timecountlimit%
  \let\next\\\else\let\next\@maketimes\fi%
 \next}
\def\maketimes#1#2{%
   \setcounter{timecount}{#1}%
   \setcounter{timecountlimit}{#2}%
\addtocounter{timecount}{1}%
\@makehashtrue
#1 &00& #1 &10&&\\
#1 &10& #1 &20&&\\
#1 &20& #1 &30&&\\
#1 &30& #1 &40&&\\
#1 &40& #1 &50&&\\
#1 &50&\arabic{timecount}&00&&
\@makehashfalse
\@maketimes}
\RequirePackage{longtable}[1996/05/24]
\RequirePackage{array}[1996/06/14]
\RequirePackage{calendar}
\IfFileExists{mygoth.sty}{\RequirePackage{mygoth}}{\let\textgoth\relax}
\setlength\LTleft{0pt}
\setlength\LTright{0pt}
\newenvironment{timesheet}
   {\begin{longtable}{%
     |r%
      @{:}%
      l%
      @{\ --\ }%
      r%
      @{:}%
      l%
     |p{0.33\timesheetright}%
     ||p{0.67\timesheetright}|%
}%
   \multicolumn{4}{l}{}&%
     \multicolumn{2}{l}{\large\bf\theweekday\hfill%
     {\Huge\textgoth{Timesheet}}\hfill%
     \theday{} %
     \themonth{} %
     \theyear}\\
   \multicolumn{6}{l}{}\\
     \multicolumn{4}{c}{\small Time}&%
     \multicolumn{1}{c}{\small Plan}&%
     \multicolumn{1}{c}{\small Action}\\
   \hline
   \endhead
   \hline
    \endfoot}
   {\end{longtable}}
\def\timesheets#1#2{%
  \everyday
   {#1}
   {#2}
   {\begin{timesheet}\maketimes{7}{22}\end{timesheet}}
}

\endinput
%%
%% End of file `timesht.cls'.
