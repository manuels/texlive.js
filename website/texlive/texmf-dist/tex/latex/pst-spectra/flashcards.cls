%%
%% This is file `flashcards.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% flashcards.dtx  (with options: `flashcards')
%% 
%% FlashCards LaTeX2e Class for Typesetting Double Sided Cards
%% Copyright (C) 2000  Alexander M. Budge <ambudge@mit.edu>
%% 
%% This program is free software; you can redistribute it and/or modify
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
%% along with this program (the file COPYING); if not, write to the
%% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
%% 
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{flashcards}[2010/08/13 1.0.1 (matthew@debian.org)]
\RequirePackage{ifthen}
\LoadClass{article}
\newboolean{flashcards@dvips}\setboolean{flashcards@dvips}{false}
\newboolean{flashcards@grid}\setboolean{flashcards@grid}{false}
\newboolean{flashcards@frame}\setboolean{flashcards@frame}{false}
\newboolean{flashcards@fronts}\setboolean{flashcards@fronts}{true}
\newboolean{flashcards@backs}\setboolean{flashcards@backs}{true}
\newlength{\cardheight}
\newlength{\cardwidth}
\newlength{\topoffset}
\newlength{\oddoffset}
\newlength{\evenoffset}
\newlength{\oddevenshift}
\newlength{\cardmargin}
\newlength{\cardinnerheight}
\newlength{\cardinnerwidth}
\DeclareOption{dvips}{
  \setboolean{flashcards@dvips}{true}}
\DeclareOption{grid}{
  \setboolean{flashcards@grid}{true}}
\DeclareOption{frame}{
  \setboolean{flashcards@frame}{true}}
\DeclareOption{fronts}{
  \setboolean{flashcards@backs}{false}}
\DeclareOption{backs}{
  \setboolean{flashcards@fronts}{false}}
\DeclareOption*{
  \InputIfFileExists{\CurrentOption.cfg}{}{
    \typeout{Coudln't find \CurrentOption.cfg, using defualt.}
    \OptionNotUsed}}
\ProcessOptions
\pagestyle{empty}
\RequirePackage[\cardpaper]{geometry}
\setlength{\oddevenshift}{\oddoffset}
\addtolength{\oddevenshift}{-\evenoffset}
\addtolength{\oddoffset}{-\oddevenshift}
\addtolength{\evenoffset}{\oddevenshift}
\geometry{\cardpapermode,
          \cardpaper,
          top=\topoffset,
          left=\oddoffset,
          right=\evenoffset,
          bottom=0.0in,
          noheadfoot}
\ifthenelse{\boolean{flashcards@dvips}}{\geometry{dvips}}{}
\newcounter{flashcards@row}
\newcounter{flashcards@col}[flashcards@row]
\ifthenelse{\boolean{flashcards@grid}}
 {\newcommand{\flashcards@gridbox}[1]{%
              \setlength{\fboxsep}{0in}\fbox{#1}}
  \addtolength{\cardwidth}{-2\fboxrule}
  \addtolength{\cardheight}{-2\fboxrule}}
 {\newcommand{\flashcards@gridbox}[1]{#1}}
\ifthenelse{\boolean{flashcards@frame}}
 {\newcommand{\flashcards@beginframebox}{%
    \begin{tabular}{|@{\hspace*{\fboxsep}}c@{\hspace*{\fboxsep}}|}%
      \hline}%
  \newcommand{\flashcards@endframebox}{\\ \hline
    \end{tabular}}}
 {\newcommand{\flashcards@beginframebox}{}%
  \newcommand{\flashcards@endframebox}{}}
\whiledo{\value{flashcards@row} < \cardrows}{%
  \stepcounter{flashcards@row}%
  \whiledo{\value{flashcards@col} < \cardcolumns}{%
    \stepcounter{flashcards@col}%
    \expandafter\newsavebox
      \csname flashcardFrontR\roman{flashcards@row}%
              C\roman{flashcards@col}\endcsname%
      \global\expandafter\setbox%
        \csname flashcardFrontR\roman{flashcards@row}%
                C\roman{flashcards@col}\endcsname%
        \hbox{\flashcards@gridbox{%
          \parbox[t][\cardheight]
                 [c]{\cardwidth}%
                 {\rule{\cardwidth}{0pt}%
                  \rule{0pt}{\cardheight}}}}%
    \expandafter\newsavebox
      \csname flashcardBackR\roman{flashcards@row}%
              C\roman{flashcards@col}\endcsname%
      \global\expandafter\setbox%
        \csname flashcardBackR\roman{flashcards@row}%
                C\roman{flashcards@col}\endcsname%
        \hbox{\flashcards@gridbox{%
          \parbox[t][\cardheight]
                 [c]{\cardwidth}%
                 {\rule{\cardwidth}{0pt}%
                  \rule{0pt}{\cardheight}}}}%
  }
}
\setcounter{flashcards@row}{1}
\setcounter{flashcards@col}{1}
\newcommand{\flashcards@frontfoot}{}
\newcommand{\flashcards@ps@front@empty}[3]{\@gobble{#1}\@gobble{#2}%
  \flashcards@format@front#3}
\newcommand{\flashcards@ps@front@plain}[3]{\@gobble{#1}\@gobble{#2}%
  \vspace*{\fill}\par%
  \begin{center}\flashcards@format@front#3\end{center}%
  \par\vspace*{\fill}}
\newcommand{\flashcards@ps@front@headings}[3]{%
  {\flashcards@ps@front@head{\flashcards@format@front@head#2}}\par%
  \vspace*{\fill}\begin{center}\flashcards@format@front#3\end{center}%
  \vspace*{\fill}%
  {\flashcards@ps@front@foot{\flashcards@format@front@foot#1}\par%
  \vspace*{\fboxsep}}%
}
\newcommand{\flashcards@ps@back@begin@empty}{\flashcards@format@back}
\newcommand{\flashcards@ps@back@end@emtpy}{}
\newcommand{\flashcards@ps@back@begin@plain}
  {\vspace*{\fill}\center\flashcards@format@back}
\newcommand{\flashcards@ps@back@end@plain}{\vspace*{\fill}}
\newcommand{\flashcards@ps@front@head@left}[1]{#1}
\newcommand{\flashcards@ps@front@head@right}[1]{\hspace*{\fill}#1}
\newcommand{\flashcards@ps@front@head@center}[1]{\centerline{#1}}
\newcommand{\flashcards@ps@front@foot@left}[1]{#1}
\newcommand{\flashcards@ps@front@foot@right}[1]{\hspace*{\fill}#1}
\newcommand{\flashcards@ps@front@foot@center}[1]{\centerline{#1}}
\newcommand{\flashcards@ps@front}
  {\flashcards@ps@front@plain}
\newcommand{\flashcards@ps@front@head}
  {\flashcards@ps@front@head@left}
\newcommand{\flashcards@ps@front@foot}
  {\flashcards@ps@front@foot@right}
\newcommand{\flashcards@ps@back@begin}
  {\flashcards@ps@back@begin@plain}
\newcommand{\flashcards@ps@back@end}
  {\flashcards@ps@back@end@plain}
\newlength{\flashcards@savelineskip}
\newcommand{\flashcards@lineskip@zero}
  {\setlength{\flashcards@savelineskip}{\lineskip}%
   \setlength{\lineskip}{0pt}}
\newcommand{\flashcards@lineskip@restore}
  {\setlength{\lineskip}{\flashcards@savelineskip}}
\newcommand{\flashcards@format@front}
  {\large\bfseries}
\newcommand{\flashcards@format@front@head}
  {\normalsize\scshape}
\newcommand{\flashcards@format@front@foot}
  {\normalsize\scshape}
\newcommand{\flashcards@format@back}{}
\setlength{\cardmargin}{0.035\cardwidth}
\newcommand{\flashcards@flush}
  {\flashcards@flushfronts\flashcards@flushbacks}
\ifthenelse{\boolean{flashcards@fronts}}{%
  \newcommand{\flashcards@flushfronts}{%
    \flashcards@lineskip@zero%
    \noindent\raggedright\par%
    \setcounter{flashcards@row}{0}
    \whiledo{\value{flashcards@row} < \cardrows}{%
      \stepcounter{flashcards@row}%
      \whiledo{\value{flashcards@col} < \cardcolumns}{%
        \stepcounter{flashcards@col}%
        \flashcards@gridbox{\usebox{%
          \csname flashcardFrontR\roman{flashcards@row}%
                  C\roman{flashcards@col}\endcsname}}%
        \global\expandafter\setbox%
          \csname flashcardFrontR\roman{flashcards@row}%
                  C\roman{flashcards@col}\endcsname%
          \hbox{\flashcards@gridbox{%
            \parbox[t][\cardheight]
                   [c]{\cardwidth}%
                   {\rule{\cardwidth}{0pt}%
                    \rule{0pt}{\cardheight}}}}%
      }
      \noindent\raggedright\par%
    }
    \clearpage%
    \flashcards@lineskip@restore%
    \setcounter{flashcards@row}{1}%
    \setcounter{flashcards@col}{1}%
  }
}{%
  \newcommand{\flashcards@flushfronts}{}%
}
\ifthenelse{\boolean{flashcards@backs}}{%
  \newcommand{\flashcards@flushbacks}{%
    \flashcards@lineskip@zero%
    \noindent\raggedright\par%
    \setcounter{flashcards@row}{0}
    \whiledo{\value{flashcards@row} < \cardrows}{%
      \stepcounter{flashcards@row}%
      \setcounter{flashcards@col}{\cardcolumns}
      \whiledo{\value{flashcards@col} > 0}{%
        \flashcards@gridbox{\usebox{%
          \csname flashcardBackR\roman{flashcards@row}%
                  C\roman{flashcards@col}\endcsname}}%
        \global\expandafter\setbox
          \csname flashcardBackR\roman{flashcards@row}%
                  C\roman{flashcards@col}\endcsname%
        \hbox{\flashcards@gridbox{%
          \parbox[t][\cardheight]
                 [c]{\cardwidth}%
                 {\rule{\cardwidth}{0pt}%
                  \rule{0pt}{\cardheight}}}}%
        \addtocounter{flashcards@col}{-1}%
      }
      \noindent\raggedright\par%
    }
    \clearpage%
    \flashcards@lineskip@restore%
    \setcounter{flashcards@row}{1}%
    \setcounter{flashcards@col}{1}%
  }
}{%
  \newcommand{\flashcards@flushbacks}{}%
}
\AtEndDocument{%
  \ifthenelse{\value{flashcards@row} = 1}{%
    \ifthenelse{\value{flashcards@col} = 1}{}{%
  \flashcards@flush}}{\flashcards@flush}%
}
\newcommand{\cardfrontstyle}[2][]
  {\renewcommand{\flashcards@ps@front}
                {\csname flashcards@ps@front@#2\endcsname}
   \ifthenelse{\equal{#1}{}}{}{%
     \renewcommand{\flashcards@format@front}{#1}}}
\newcommand{\cardbackstyle}[2][]
  {\renewcommand{\flashcards@ps@back@begin}
                {\csname flashcards@ps@back@begin@#2\endcsname}
   \renewcommand{\flashcards@ps@back@end}
                {\csname flashcards@ps@back@end@#2\endcsname}
   \ifthenelse{\equal{#1}{}}{}{%
     \renewcommand{\flashcards@format@back}{#1}}}
\newcommand{\cardfrontheadstyle}[2][]
  {\renewcommand{\flashcards@ps@front@head}
                {\csname flashcards@ps@front@head@#2\endcsname}
   \ifthenelse{\equal{#1}{}}{}{%
     \renewcommand{\flashcards@format@front@head}{#1}}}
\newcommand{\cardfrontfootstyle}[2][]
  {\renewcommand{\flashcards@ps@front@foot}
                {\csname flashcards@ps@front@foot@#2\endcsname}
   \ifthenelse{\equal{#1}{}}{}{%
     \renewcommand{\flashcards@format@front@foot}{#1}}}
\newcommand{\cardfrontfoot}[1]
  {\renewcommand{\flashcards@frontfoot}{#1}}
\newenvironment{flashcard}[2][]{%
  \setlength{\cardinnerwidth}{\cardwidth}%
  \addtolength{\cardinnerwidth}{-2\cardmargin}%
  \setlength{\cardinnerheight}{\cardheight}%
  \addtolength{\cardinnerheight}{-2\cardmargin}%
  \ifthenelse{\boolean{flashcards@fronts}}{%
    \global\expandafter\setbox%
      \csname flashcardFrontR\roman{flashcards@row}%
              C\roman{flashcards@col}\endcsname%
      \hbox{\begingroup\aftergroup}%
        \begin{minipage}[t][\cardheight]
                        [c]{\cardwidth}%
          \begin{center}%
            \flashcards@beginframebox%
              \begin{minipage}[t][\cardinnerheight]
                              [t]{\cardinnerwidth}%
                \flashcards@ps@front{\flashcards@frontfoot}{#1}{#2}%
              \end{minipage}%
            \flashcards@endframebox%
          \end{center}%
        \end{minipage}%
      \endgroup%
  }{\@gobble{#1}}%
  \global\expandafter\setbox%
    \csname flashcardBackR\roman{flashcards@row}%
            C\roman{flashcards@col}\endcsname%
    \hbox{\begingroup\aftergroup}%
      \begin{minipage}[t][\cardheight]
                      [c]{\cardwidth}%
        \begin{center}%
          \flashcards@beginframebox%
            \begin{minipage}[t][\cardinnerheight]
                            [t]{\cardinnerwidth}%
               \flashcards@ps@back@begin%
}{%
               \flashcards@ps@back@end%
            \end{minipage}%
          \flashcards@endframebox%
        \end{center}%
      \end{minipage}%
    \endgroup%
  \stepcounter{flashcards@col}%
  \ifthenelse{\value{flashcards@col} > \cardcolumns}{%
    \stepcounter{flashcards@row}%
    \ifthenelse{\value{flashcards@row} > \cardrows}{%
      \flashcards@flush%
    }{%
      \setcounter{flashcards@col}{1}%
    }%
  }{}%
}

\endinput
%%
%% End of file `flashcards.cls'.
