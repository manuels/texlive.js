%%
%% This is file `recipecard.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% recipecard.dtx  (with options: `class')
%%  This is a generated file. Copyright (C) 2005
%% by Ben Reish This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.2
%% of this license or (at your option) any later version. The latest
%% version of this license is in: http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{recipecard}
[2006/10/03 v2.0 Recipecard Class typesets recipes to fit note
cards]
\RequirePackage{calc,ifthen,boxedminipage}
\RequirePackage[letterpaper,noheadfoot]{geometry} %showframe
\newboolean{fiveseven} \newboolean{foursix} \newboolean{threefive}
\newtoks{\@ta} \newtoks{\@tb} \newtoks{\@listone} \newtoks\@listtwo
\newtoks\@listthree \def\@nil{}

\renewcommand{\normalsize}{\fontsize{10pt}{12pt}\usefont{T1}{ptm}{m}{n}%
    \selectfont}
\setlength{\textwidth}{7in} \setlength{\textheight}{10.25in}
\setlength{\paperwidth}{8.5in} \setlength{\paperheight}{11in}
\newlength{\@ingredientlist} \newlength{\@cardheight}
\newcommand{\textdegree}{\textsuperscript{$\circ$}}
\DeclareOption{fivebyseven}{\geometry{%
    body={7in,10.25in},left=.75in}% centering,right=.75in
    \setlength{\@ingredientlist}{2in} \setlength{\@cardheight}{5in}%
    \setboolean{fiveseven}{true}}
\DeclareOption{fourbysix}{\geometry{%
    body={6in,8.15in},left=.75in}%right=1.75in
    \setlength\@ingredientlist{1.75in}%
    \setlength\@cardheight{4in} \setboolean{foursix}{true}}
\DeclareOption{threebyfive}{\geometry{%
    landscape,body={10.25in,6.25in},left=.375in}%,right=.375in
    \setlength\@ingredientlist{1.5in}%
    \setlength\@cardheight{3in} \setboolean{threefive}{true}}
\DeclareOption{nothing}{\relax}

\DeclareOption*{\typeout{What's \CurrentOption?}}

\ExecuteOptions{fivebyseven,nothing}

\ProcessOptions\relax

\newcounter{ingred@cnt}\setcounter{ingred@cnt}{0}
\newcommand{\ingredient}[1]{%
    \stepcounter{ingred@cnt}
    \@ddtoNgrdList{#1}
    %\typeout{\string\ingredient{#1}}
}
\newcounter{ingred@list} \setcounter{ingred@list}{7}
\newcommand{\changeingrdlistnum}[1]{%
    \setcounter{ingred@list}{#1}
}
\newdimen{\@cardwidth}
\ifthenelse{\boolean{fiveseven}}{\setlength\@cardwidth{7in}}{}
\ifthenelse{\boolean{foursix}}{\setlength\@cardwidth{6in}}{}
\ifthenelse{\boolean{threefive}}{\setlength\@cardwidth{5in}%
    \changeingrdlistnum{4}
    \renewcommand{\normalsize}{\fontsize{8pt}{10pt}%
    \usefont{T1}{ptm}{m}{n}\selectfont}}{}
\newsavebox{\@reccardbox} \newdimen{\@reccardh} \newdimen{\@rectemp}
\newdimen{\@hruleoffset} \newdimen{\@rectempa}
\newdimen{\@rectempb} \newdimen{\@rectempc} \newdimen{\BR@recd}
\setlength\@rectemp{\@cardheight-2\fboxsep-2\fboxrule-17pt}
\setlength{\@hruleoffset}{(\@cardwidth-2\fboxsep-2\fboxrule-.714\@cardwidth)/2}
\newenvironment{recipe}[2]{%
    \ifthenelse{\equal{#2}{\@empty}}{\def\@recserv{}}%
        {\def\@recserv{Serves: #2}}
    \def\@rectitle{#1 \raggedright}
    \ifthenelse{\equal{\the\@listtwo}{\@empty}}{\@listtwo={\item {}}}{}
    \ifthenelse{\equal{\the\@listthree}{\@empty}}{\@listthree={\item {}}}{}
    \begin{lrbox}{\@reccardbox}
    \begin{minipage}[t]{\@cardwidth-2\fboxsep-2\fboxrule}
    \noindent\fontsize{14.4}{17} \usefont{T1}{pzc}{mb}{it}%
    \@rectitle\hspace{\fill}\@recserv\normalsize\normalfont\par
    \begin{minipage}[t]{\@ingredientlist}
        \begin{list}{}{\setlength\leftmargin{.25in}%
            \setlength\itemindent{-.25in}\raggedright}\the\@listone%
            \end{list}\end{minipage}
        \typeout{first box}
    \hspace{3pt plus 0pt minus 6pt}
    \begin{minipage}[t]{\@ingredientlist}
        \begin{list}{}{\setlength\leftmargin{.25in}%
            \setlength\itemindent{-.25in}\raggedright}\the\@listtwo%
            \end{list}\end{minipage}
        \typeout{second box}
    \hspace{3pt plus 0pt minus 6pt}
    \begin{minipage}[t]{\@ingredientlist}
        \begin{list}{}{\setlength\leftmargin{.25in}%
            \setlength\itemindent{-.25in}\raggedright}\the\@listthree%
            \end{list}\end{minipage}
        \typeout{third box}
    \hspace{\fill}
    \par
    \vspace{3pt} \hspace{\@hruleoffset}%
    \rule{.714\@cardwidth}{0.7pt}%
    \par\vspace{3pt} \hspace{1em}%
    \everypar={\hspace{1em}}
    }{%
    \par \noindent \@cooktime \hspace{\fill} \@cooktemp%\par
    \end{minipage}\end{lrbox}
    \vspace{-.25in} \hspace{-21pt}
    \begin{boxedminipage}[t]{\@cardwidth}%
    \rule[-\@rectemp]{0pt}{\@rectemp} \hspace{-4pt}
    \usebox{\@reccardbox}%
    \end{boxedminipage}
    \ifthenelse{\boolean{threefive}}{\hspace{.5ex}}{\par\vspace{.35in}}
    \setcounter{ingred@cnt}{0}%
    \@listone={}
    \@listtwo={}
    \@listthree={}
    \gdef\@cooktime{} \gdef\@cooktemp{}
    \everypar={}
    %\typeout{\string\pagetotal\space\the\pagetotal}
    %\typeout{\string\@listone\space`\the\@listone'}
    }
\def\@cooktime{}
\newcommand{\cookingtime}[1]{%
    \def\@cooktime{\hbox{\hspace{-1em}\bfseries Cook Time: #1}}
}
\def\@cooktemp{}
\newcommand{\cooktemp}[2]{%
    \def\@cooktemp{\hbox{\bfseries %
        Temperature: #1\textdegree\hspace{-1.5pt}#2}}
}
\newcounter{@tempa}\newcounter{@tempb} \newcounter{@tempc}
\newcommand{\@ddtoNgrdList}[1]{%
    \setcounter{@tempa}{\theingred@list+1}%
    \setcounter{@tempb}{2*\theingred@list+1}%
    \setcounter{@tempc}{3*\theingred@list+1}%
    \ifthenelse{\value{ingred@cnt}=1}{%
    \@ta={} \@listone={} \@listtwo={} \@listthree={}%
    }{}
    \ifthenelse{\value{ingred@cnt}<\value{@tempa}}{%
        %\typeout{\string\@listone :\space\the\@listone}
        \expandafter\@ta\expandafter=%
            \expandafter{\the\@listone \item #1}
        \@listone=\@ta}{%
        \ifthenelse{\(\value{ingred@cnt}>\value{@tempa}%
            \or \value{ingred@cnt}=\value{@tempa}%
            \)\and\value{ingred@cnt}<\value{@tempb}}{%
            \expandafter\@ta\expandafter=%
                \expandafter{\the\@listtwo \item #1}
            \@listtwo=\@ta}{%
            \ifthenelse{\(\value{ingred@cnt}>\value{@tempb}%
                \or \value{ingred@cnt}=\value{@tempb}\)\and%
                \value{ingred@cnt}<\value{@tempc}}{%
                \expandafter\@ta\expandafter=%
                    \expandafter{\the\@listthree \item #1}
                \@listthree=\@ta}{%
                \ifthenelse{\(\value{ingred@cnt}>\value{@tempc}%
                    \or\value{ingred@cnt}=\value{@tempc}\)}{%
                    \setcounter{ingred@cnt}{2}
                    \expandafter\@ta\expandafter=%
                        \expandafter{\the\@listthree \item #1}
                    \@listthree=\@ta}{%
                    \ClassError{recipecard}{More than \the@tempc\space ingredients for
                    one recipe card}{Unfortunately, the card
                    design only allows for three columns of a total of
                    \the@tempc\space ingredients. Hint: change the value of
                    \string\changeingrdlistnum.
                    Congratulations! You have used more ingredients
                    than this Class was designed for.}
                }
            }
        }
    }
    %\typeout{ingred@cnt\space\theingred@cnt}
}
\endinput
%%
%% End of file `recipecard.cls'.
