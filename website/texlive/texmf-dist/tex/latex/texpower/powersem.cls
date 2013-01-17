%%
%% This is file `powersem.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% powersem.dtx  (with options: `powersem')
%% 
%% --------------------------------------------------------------
%% TeXPower bundle - dynamic online presentations with LaTeX
%% Copyright (C) 1999-2004 Stephan Lehmke
%% Copyright (C) 2003-2005 Hans Fredrik Nordhaug
%% 
%% This program is free software; you can redistribute it and/or
%% modify it under the terms of the GNU General Public License
%% as published by the Free Software Foundation; either version 2
%% of the License, or (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% --------------------------------------------------------------
%% 
%% The list of all files belonging to the TeXPower bundle is
%% given in the file `00readme.txt'.
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{powersem}
    [2004/07/27 v0.8a Create online Presentations with seminar.]
\RequirePackage{ifthen}
\newboolean{display}
\DeclareOption{display}
{\setboolean{display}{true}\PassOptionsToClass{slidesonly}{seminar}}
\newboolean{truepn@PS}
\DeclareOption{truepagenumbers}{\setboolean{truepn@PS}{true}}
\newboolean{BaseClass@PS}
\DeclareOption{KOMA}
{\setboolean{BaseClass@PS}{true}\providecommand{\baseclass}{scrartcl}}
\DeclareOption{UseBaseClass}
{\setboolean{BaseClass@PS}{true}\providecommand{\baseclass}{article}}
\DeclareOption{reportclass}
{\setboolean{BaseClass@PS}{true}\providecommand{\baseclass}{report}}
\DeclareOption{bookclass}
{\setboolean{BaseClass@PS}{true}\providecommand{\baseclass}{book}}
\DeclareOption{a4paper}{\PassOptionsToClass{a4}{seminar}}
\newboolean{calcdim@PS}
\DeclareOption{calcdimensions}{\setboolean{calcdim@PS}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{seminar}}

\ProcessOptions
\let\oldLC@PS=\LoadClass

\ifthenelse{\boolean{BaseClass@PS}}
{%
  \def\article@PS{article}
  \let\oldPOTC@PS=\PassOptionsToClass
  \def\PassOptionsToClass#1#2%
  {\edef\cls@PS{#2}%
   \ifx\article@PS\cls@PS\oldPOTC@PS{#1}{\baseclass}%
   \else\oldPOTC@PS{#1}{#2}%
   \fi}
  \renewcommand{\LoadClass}[2][]%
  {%
    \edef\cls@PS{#2}%
    \ifx\article@PS\cls@PS
      \let\paperheight\sem@paperheight\let\paperwidth\sem@paperwidth
      \oldLC@PS[#1]{\baseclass}%
      \ifarticle\else\portraittrue\fi
     \else
      \oldLC@PS[#1]{#2}%
    \fi
  }%
}
{}
\oldLC@PS{seminar}

\AtBeginDocument
{%
\input{seminar.bug}%
\input{seminar.bg2}%
}

\expandafter\def\expandafter\set@slidesize\expandafter
{\set@slidesize\@colht\vsize}

\g@addto@macro\@arrayparboxrestore\slide@rightskip

\ifthenelse{\boolean{truepn@PS}}{\truepagenumbers}{}

\AtBeginDocument{%
\ifthenelse{\boolean{BaseClass@PS}}{\sliderotation{none}}{}}
\AtBeginDocument{%
\ifarticle
\else
  \def\output@slide{%
    \begingroup
      \hoffset=-\inverseslidesmag in
      \voffset=-\inverseslidesmag in
      \setslidelength\@tempdima{%
        \ifportrait\paperwidth\else\paperheight\fi}%
      \setslidelength\@tempdimb{%
        \ifportrait\paperheight\else\paperwidth\fi}%
      \ifrotateheaders
        \@ifrotateslide{%
          \dimen@=\@tempdima
          \@tempdima=\@tempdimb
          \@tempdimb=\dimen@}%
      \fi
      % \oddsidemargin, \evensidemargin, \headheight, \footheight
      % used for scratch:
      \setslidelength\headheight\slidetopmargin
      \setslidelength\footheight\slidebottommargin
      \ifautoslidemargins
        \textwidth=\wd\@slidebox
        \oddsidemargin=\@tempdima
        \advance\oddsidemargin-\textwidth
        \divide\oddsidemargin 2
      \else
        \setslidelength\oddsidemargin\slideleftmargin
        \setslidelength\evensidemargin\sliderightmargin
        \textwidth=\@tempdima
        \advance\textwidth-\oddsidemargin
        \advance\textwidth-\evensidemargin
      \fi
      \setbox\@slidebox=\hbox to \@tempdima{{%
      %
        \kern\oddsidemargin
        \vbox to\@tempdimb{{%
          \ifnum\fancyput@flag>-1
            \hbox{\kern-\oddsidemargin\do@fancyput}%
          \fi
          \let\label\@gobble
          \let\index\@gobble
          \let\glossary\@gobble
          \vbox to\headheight{{%
            \vfill
            \color@hbox
            \normalcolor
           \slideheadfont\relax%\strut         Removed (STL)
           \hb@xt@\textwidth{\@oddhead}%
            \color@endbox
            \kern\z@}}%
          \nointerlineskip
          \vss
          \hbox to\textwidth{{\hss\box\@slidebox\hss}}%
          \vss
          \nointerlineskip
          \vbox to\footheight{{%
            \vfill
              \color@hbox
              \normalcolor
             \slidefootfont\relax%\strut         Removed (STL)
             \hb@xt@\textwidth{\@oddfoot}%
              \color@endbox
            \vfill}}%
        }}\hss}}%
      \ifrotateheaders\@ifrotateslide\rotate@slide\fi
      \insert@specials
      \shipout\box\@slidebox
    \endgroup
    \let\firstmark\botmark
    \ifthenelse{\boolean{truepn@PS}}{\stepcounter{page}}{}%
    }%
  \@ifundefined{fancyput@flag}{\def\fancyput@flag{-1}}{}%
\fi
}
\ifthenelse{\boolean{display}}
{%
  \centerslidesfalse
  \extraslideheight{0pt}%
  \renewcommand{\slideshrink}{0}%
  \def\@makeslide{%
    \ifcenterslides
      \setbox\@slidebox\vbox{{%
        \@begindvi % added 1997/04/15 SPQR
        \unvbox\@cclv
        \ifvoid\slide@footins\else
          \vskip\skip\slide@footins
          \footnoterule
          \unvbox\slide@footins
        \fi
        \vskip\z@}}
     \else
      \setbox\@slidebox\vbox to \slide@vsize{{%
        \@begindvi % added 1997/04/15 SPQR
        \unvbox\@cclv
        \ifvoid\slide@footins\vfil\else
          \vfil\vskip\skip\slide@footins
          \footnoterule
          \unvbox\slide@footins
        \fi
        \vskip\z@}}%
    \fi
    }%
  }
{}
\def\relax@PS{\relax}

\ifthenelse{\boolean{calcdim@PS}}
{%
  \AtBeginDocument
  {%
    \setlength{\slidewidth}{\paperwidth}%
    \advance\slidewidth by -\slideleftmargin\relax
    \advance\slidewidth by -\sliderightmargin\relax
    \ifx\theslideframe\relax@PS
     \else
      \advance\slidewidth by -2\slideframewidth\relax
      \advance\slidewidth by -2\slideframesep\relax
    \fi
    \setlength{\slideheight}{\paperheight}%
    \advance\slideheight by -\slidetopmargin\relax
    \advance\slideheight by -\slidebottommargin\relax
    \ifx\theslideframe\relax@PS
     \else
      \advance\slideheight by -2\slideframewidth\relax
      \advance\slideheight by -2\slideframesep\relax
    \fi
    }%
  }
{}

\AtBeginDocument
{%
  \@ifundefined{headwidth}{}
  {%
    \setslidelength{\headwidth}{\paperwidth}%
    \addtoslidelength{\headwidth}{-\slideleftmargin}%
    \addtoslidelength{\headwidth}{-\sliderightmargin}%
  }%
}
\endinput
%%
%% End of file `powersem.cls'.
