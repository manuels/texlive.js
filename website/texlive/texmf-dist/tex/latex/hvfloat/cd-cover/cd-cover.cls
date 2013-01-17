%%
%% This is file `cd-cover.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cd-cover.dtx  (with options: `class')
%% LaTeX2e class `cd-cover' for typesetting a variaty of cd covers
%% Copyright (C) 1999 Christian Holm <cholm@nbi.dk>
%% 
%% This class is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the
%%   Free Software Foundation, Inc.
%%   675 Mass Ave
%%   Cambridge
%%   MA 02139
%%   USA
%% 
%% For more information see `cd-cover.dtx'
%% 
\NeedsTeXFormat{LaTeX2e}
\def\fileversion{v1.4}
\def\filedate{2002/01/28}  % Format is YYYY/MM/DD
\ProvidesClass{cd-cover}[\filedate\space\fileversion
\space cd-cover class.]
\newlength{\temp@length}
\newlength{\temp@@length}
\newlength{\booklet@even@margins}
\newlength{\booklet@odd@margins}
\newlength{\back@even@margins}
\newlength{\back@odd@margins}
\newlength{\sleeve@even@margins}
\newlength{\sleeve@odd@margins}
\newlength{\single@even@margins}
\newlength{\single@odd@margins}
\def\cd@cover@setup@margins{
  % This is some old stuff, that I'm not sure is needed, but I leave it
  % \global\paperheight=\temp@length
  % \global\paperwidth=\temp@@length
  \advance\temp@length-\booklet@height
  \divide\temp@length2
  \advance\temp@length-1in
  \advance\temp@length-\headheight
  \global\topmargin=\temp@length
  \advance\temp@@length-\booklet@width
  \divide\temp@@length2
  \advance\temp@@length-1in
  \oddsidemargin=\temp@@length}
\AtBeginDocument{\cd@cover@setup@margins}
\DeclareOption{a4paper}{
  \global\temp@length=210mm
  \global\temp@@length=297mm}
\DeclareOption{letterpaper}{
  \global\temp@length=8.5in
  \global\temp@@length=11in}
\DeclareOption{legalpapar}{
  \setlength\temp@length{8.5in}
  \setlength\temp@@length{14in}}
\DeclareOption{executivepaper}{
  \setlength\temp@length{7.25in}
  \setlength\temp@@length{10.5in}}
\DeclareOption{a5paper}{\cd@cover@paper@error{a5paper}}
\DeclareOption{b5paper}{\cd@cover@paper@error{b5paper}}
\DeclareOption{landscape}{
  \ClassWarning{cd-cover}{Option `landscape' redundant to this %
    class.}}
\newif\ifcd@cover@foldlines\cd@cover@foldlinestrue
\DeclareOption{nofoldlines}{\cd@cover@foldlinesfalse}
\DeclareOption{foldlines}{\cd@cover@foldlinestrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{letterpaper}
\ProcessOptions\relax
\def\cd@cover@paper@error#1{
  \ClassError{cd-cover}{^^J%
    Paper format `#1' is too small for the covers}{^^J%
    You have given the option `#1' to this class.^^J%
    However, that paper size is too small to hold^^J%
    the covers.^^J%
    Please change the paper size option to another^^J%
    format that CAN hold the covers (e.g., `a4paper',^^J%
    `letterpaper', etc.)}}
\LoadClass{article}
\paperheight=\temp@length
\paperwidth=\temp@@length
\RequirePackage{rotating}
\newlength{\booklet@width}     \setlength{\booklet@width}{240mm}
\newlength{\booklet@height}    \setlength{\booklet@height}{120mm}
\newlength{\back@width}        \setlength{\back@width}{137mm}
\newlength{\back@height}       \setlength{\back@height}{118mm}
\newlength{\back@slip@width}   \setlength{\back@slip@width}{7mm}
\newlength{\sleeve@height}     \setlength{\sleeve@height}{128mm}
\newlength{\sleeve@width}      \setlength{\sleeve@width}{266mm}
\newlength{\single@height}     \setlength{\single@height}{120mm}
\newlength{\single@width}      \setlength{\single@width}{137mm}
\newlength{\single@slip@width} \setlength{\single@slip@width}{15mm}
\newlength{\single@back@width} \setlength{\single@back@width}{3mm}
\newlength{\CDbookletTopMargin} \setlength{\CDbookletTopMargin}{5mm}
\newlength{\CDbookletMargin}    \setlength{\CDbookletMargin}{5mm}
\newlength{\CDbackTopMargin}    \setlength{\CDbackTopMargin}{5mm}
\newlength{\CDbackMargin}       \setlength{\CDbackMargin}{5mm}
\newlength{\CDsleeveTopMargin}  \setlength{\CDsleeveTopMargin}{5mm}
\newlength{\CDsleeveMargin}     \setlength{\CDsleeveMargin}{5mm}
\newlength{\CDsingleTopMargin}  \setlength{\CDsingleTopMargin}{5mm}
\newlength{\CDsingleMargin}     \setlength{\CDsingleMargin}{5mm}
\pagestyle{empty}
\def\ps@bookletsheets{
  \let\@oddhead\booklet@border\let\@evenhead\@oddhead
  \let\@oddfoot\@empty\let\@evenfoot\@oddfoot}
\def\init@booklet{
  \temp@length=\booklet@height
  \advance\temp@length-2\CDbookletTopMargin
  \global\textheight=\temp@length
  \global\headsep=\CDbookletTopMargin
  \temp@length=\booklet@width
  \advance\temp@length-2\CDbookletMargin
  \global\textwidth=\temp@length
  \global\@colht=\textheight
  \global\columnsep=2\CDbookletMargin}
\newenvironment{bookletsheets}{
  \init@booklet\twocolumn\pagestyle{bookletsheets}}{
  \clearpage\pagestyle{empty}}
\def\booklet@border{%
  \kern-\CDbookletMargin%
  \setlength{\unitlength}{1mm}%
  \begin{picture}(100,1)%
    \put(0,0){\line(1,0){240}}%     Top most horizontal line
    \put(0,0){\line(0,-1){120}}%    Left most vertical line
    \put(0,-120){\line(1,0){240}}%  Bottom most horizontal line
    \put(240,0){\line(0,-1){120}}%  Right most vertical line
    \put(120,0){\line(0,1){5}}%     Top folding mark
    \put(120,-120){\line(0,-1){5}}% Bottom folding mark
    \ifcd@cover@foldlines
      \multiput(120,-1)(0,-5){24}{\line(0, -1){3}} % Fold line
    \fi
    \put(110,2){\vector(1,0){10}}%  Arrow
    \put(95,1){Fold here}%          Helping text
  \end{picture}\hfill}
\def\ps@backsheet{
  \let\@oddhead\back@border\let\@evenhead\@oddhead
  \let\@oddfoot\@empty\let\@evenfoot\@empty}
\def\init@back{
  \temp@length=\back@height
  \advance\temp@length-2\CDbackTopMargin
  \global\textheight=\temp@length
  \temp@length=\back@width
  \advance\temp@length-2\CDbackMargin
  \global\textwidth=\temp@length
  \global\headsep=\CDbackTopMargin}
\newsavebox{\back@title}
\newif\ifback@anglereverse\back@anglereversefalse
\newenvironment{backsheet}[1]{
  \back@anglereversefalse%
  \init@back%
  \savebox{\back@title}[\textheight]{%
    \parbox[t][6mm]{\textheight}{#1}}
  \onecolumn\pagestyle{backsheet}
  \clearpage}{\clearpage\pagestyle{empty}}
\newenvironment{backsheet*}[1]{
  \back@anglereversetrue%
  \init@back%
  \savebox{\back@title}[\textheight]{%
    \parbox[t][6mm]{\textheight}{#1}}
  \onecolumn\pagestyle{backsheet}
  \clearpage}{\clearpage\pagestyle{empty}}
\def\back@border{%
  \kern-\CDbackMargin%
  \kern-\back@slip@width%
  \setlength{\unitlength}{1mm}%
  \begin{picture}(0,0)%
    \put(0,0){\line(1,0){151}}%     Top most horizontal line
    \put(0,-118){\line(1,0){151}}%  Bottom most horizontal line
    \put(0,0){\line(0,-1){118}}%    Left most vertical line
    \put(151,0){\line(0,-1){118}}%  Right most vertical line
    \put(7,0){\line(0,1){5}}%       Left top folding mark
    \put(7,-118){\line(0,-1){5}}%   Left bottom folding mark
    \ifcd@cover@foldlines
      \multiput(7,-1)(0,-5){24}{\line(0, -1){3}} % Fold line
    \fi
    \put(144,0){\line(0,1){5}}%     Right top folding mark
    \put(144,-118){\line(0,-1){5}}% Right bottom folding mark
    \ifcd@cover@foldlines
      \multiput(144,-1)(0,-5){24}{\line(0, -1){3}} % Fold line
    \fi
    \put(17,2){\vector(-1,0){10}}%  Left help arrow
    \put(17,1){Fold here}%          Left help text
    \put(134,2){\vector(1,0){10}}%  Right help arrow
    \put(119,1){Fold here}%         Right help text
    \ifback@anglereverse%
      \put(1,0){\begin{rotate}{-90}\usebox{\back@title}\end{rotate}}%
      \put(150,-118){\begin{rotate}{90}\usebox{\back@title}\end{rotate}}%
    \else%
      \put(6,-118){\begin{rotate}{90}\usebox{\back@title}\end{rotate}}%
      \put(145,0){\begin{rotate}{-90}\usebox{\back@title}\end{rotate}}%
    \fi%
    %\put(3,-118){\begin{rotate}{90}\usebox{\back@title}\end{rotate}}%
    %\put(148,0){\begin{rotate}{-90}\usebox{\back@title}\end{rotate}}%
  \end{picture}\hfill}
\def\ps@sleevesheet{%
  \let\@oddhead\sleeve@border\let\@evenhead\@oddhead
  \let\@oddfoot\@empty\let\@evenfoot\@oddfoot}
\def\init@sleeve{
  \temp@length=\sleeve@height
  \advance\temp@length-2\CDsleeveTopMargin
  \global\textheight=\temp@length
  \global\@colht=\textheight
  \temp@length=\sleeve@width
  \advance\temp@length-2\CDsleeveMargin
  \global\textwidth=\temp@length
  \global\headsep=\CDsleeveTopMargin
  \global\columnsep=2\CDsleeveMargin}
\newenvironment{sleevesheet}{%
  \init@sleeve
  \twocolumn\pagestyle{sleevesheet}
  \global\let\@outputdblcol\sleeve@outputdblcol}{
  \clearpage\pagestyle{empty}
  \global\let\@outputdblcol\ltx@outputdblcol}
\def\sleeve@border{%
  \kern-\CDsleeveMargin%
  \setlength{\unitlength}{1mm}%
  \begin{picture}(100,1)%
    \put(0,0){\line(3,4){6}}%        Top flap
    \put(6,8){\line(1,0){121}}%
    \put(133,0){\line(-3,4){6}}%
    \ifcd@cover@foldlines
      \multiput(133,-1)(0,-5){25}{\line(0, -1){3}} % Fold line
    \fi
    \put(50,1){Fold and clue}%       Help text in top flap
    \put(0,-123){\line(3,-4){6}}%    Bottom flap
    \put(6,-131){\line(1,0){121}}%
    \put(133,-123){\line(-3,-4){6}}%
    \put(50,-131){Fold and clue}%    Help text in bottom flap
    \put(0,0){\line(1,0){266}}%      Top most horizontal line
    \put(0,0){\line(0,-1){123}}%     Left most vertical line
    \put(0,-123){\line(1,0){266}}%   Bottom most horizontal line
    \put(266,0){\line(0,-1){123}}%   Right most vertical line
  \end{picture}\hfill}
\def\ps@singlesheet{
  \let\@oddhead\odd@single@border
  \let\@evenhead\even@single@border
  \let\@oddfoot\@empty\let\@evenfoot\@oddfoot}
\newsavebox{\single@title}
\newsavebox{\single@slip}
\def\init@single{
  \temp@length=\single@height
  \advance\temp@length-2\CDsingleTopMargin
  \advance\temp@length-4mm
  \global\textheight=\temp@length
  \temp@length=\single@width
  \advance\temp@length-2\CDsingleMargin
  \global\textwidth=\temp@length
  \global\headsep=\CDsingleTopMargin}
\newenvironment{singlesheet}[2]{
  \init@single
  \savebox{\single@title}[\textwidth]{%
    \parbox[t][3mm]{\textwidth}{#1}}
  \savebox{\single@slip}[\textwidth]{%
    \parbox[t][\single@slip@width]{\textwidth}{#2}}
  \onecolumn\pagestyle{singlesheet}
  \clearpage}{\clearpage\pagestyle{empty}}
\def\odd@single@border{
  \kern-\CDsingleMargin%
  \kern-\single@slip@width%
  \kern-\single@back@width%
  \setlength{\unitlength}{1mm}%
  \begin{picture}(0,0)%
    \put(0,0){\line(0,-1){116}}%                  Left most vertical line
    \put(0,0){\line(1,0){36}}%                    First top horizontal line
    \put(36,0){\line(0,1){2}}%                    Jump
    \put(15,0){\line(0,1){5}}%                    Fold mark
    \ifcd@cover@foldlines
      \multiput(15,-1)(0,-5){24}{\line(0, -1){3}} % Fold line
    \fi
    \put(18,0){\line(0,1){5}}%                    Fold mark
    \ifcd@cover@foldlines
      \multiput(18,-1)(0,-5){24}{\line(0, -1){3}} % Fold line
    \fi
    \put(36,2){\line(1,0){119}}%                  Second top line
    \put(155,2){\line(0,-1){120}}%                Right most vertical line
    \put(0,-116){\line(1,0){36}}%                 First bottom line
    \put(36,-116){\line(0,-1){2}}%                Jump
    \put(15,-116){\line(0,-1){5}}%                Fold Mark
    \put(18,-116){\line(0,-1){5}}%                Fold Mark
    \put(36,-118){\line(1,0){119}}%               Second bottom line
    \put(5,4){\vector(1,0){10}}%                  Arrows
    \put(28,4){\vector(-1,0){10}}%                Arrows
    \put(28,3){Fold here}%                        Help text
    \put(0,0){\begin{rotate}{-90}\usebox{\single@title}\end{rotate}}%
    \put(15,0){\begin{rotate}{-90}\usebox{\single@slip}\end{rotate}}%
  \end{picture}\hfill}
\def\even@single@border{
  \kern-\CDsingleMargin%
  \setlength{\unitlength}{1mm}%
  \begin{picture}(0,0)%
    \put(0,2){\line(0,-1){120}}%    1st left vert line
    \put(119,0){\line(1,0){36}}%    2nd top horiz line
    \put(119,0){\line(0,1){2}}%     2nd top right vert line
    \put(137,0){\line(0,1){5}}%     1st top fold mark
    \put(140,0){\line(0,1){5}}%     2nd top fold mark
    \put(0,2){\line(1,0){119}}%     1st top horiz line
    \put(155,0){\line(0,-1){116}}%  1st right vert line
    \put(119,-116){\line(1,0){36}}% 2nd bototm horiz line
    \put(119,-116){\line(0,-1){2}}% 2nd bottom right vert line
    \put(137,-116){\line(0,-1){5}}% 1st bottom fold mark
    \put(140,-116){\line(0,-1){5}}% 2nd bottom fold mark
    \put(0,-118){\line(1,0){119}}%  1st bottom horiz line
    \put(127,4){\vector(1,0){10}}%  1st help arrow
    \put(150,4){\vector(-1,0){10}}% 2nd help arrow
    \put(112,3){Fold here}%         Help text
  \end{picture}\hfill}
\let\ltx@outputdblcol\@outputdblcol
\def\sleeve@outputdblcol{%
  \if@firstcolumn
    \global\@firstcolumnfalse
    \global\setbox\@leftcolumn\box\@outputbox
  \else
    \global\@firstcolumntrue
    \setbox\@outputbox\vbox{%
      \hb@xt@\textwidth{%
        \hb@xt@\columnwidth{%
          \box\@outputbox\hss}%  \@leftcolumn changed to \@outputbox
        \hfil\vrule\@width\columnseprule\hfil
        \hb@xt@\columnwidth{%
          \box\@leftcolumn\hss}}}% \@outputbox changed to \@leftcolumn
    \@combinedblfloats
    \@outputpage
    \begingroup
      \@dblfloatplacement
      \@startdblcolumn
      \@whilesw\if@fcolmade\fi
        {\@outputpage
          \@startdblcolumn}%
    \endgroup
  \fi
}
\def\cdcover@endmessage{cd-cover class: Remember that this document is
    type set in landscape^^J mode, and therefore dvips should be
    passed the `-t landscape' option.}
\@ifundefined{Gin@driver}{%
  \AtEndDocument{\typeout{\cdcover@endmessage}}}{%
  \filename@parse{\Gin@driver}%
  \def\reserved@a{dvips}%
  \ifx\filename@base\reserved@a\relax%
    \message{DVIPS driver found}
    \AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}%
    \AtBeginDvi{\special{papersize=\the\paperheight,\the\paperwidth}}%
  \else
    \def\reserved@a{pdftex}\relax%
    \ifx\filename@base\reserved@a
      \message{PDF driver found}
      \pdfpagewidth=\the\paperwidth\pdfpageheight=\the\paperheight%
    \else
      \def\reserved@a{vtex}\relax%
      \ifx\filename@base\reserved@a
        \message{VTeX driver found}
        \mediawidth=\the\paperwidth\mediaheight=\the\paperheight%
      \else
        \AtEndDocument{\typeout{\cdcover@endmessage}}
      \fi
    \fi
  \fi}
\endinput
%%
%% End of file `cd-cover.cls'.
