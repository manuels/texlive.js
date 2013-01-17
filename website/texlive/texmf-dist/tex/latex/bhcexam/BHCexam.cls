%%
%% This is file `BHCexam.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% BHCexam.dtx  (with options: `cls')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2011 by Charles Bao <charley792@gmail.com>
%% 
%% This file was generated from file(s) of the BHCexam package project.
%% ----------------------------------------------------------------------
%% 
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.2
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%% 
%% This file may only be distributed together with a copy of original
%% source files. You may however distribute original source files
%% without such generated files. Copying of this file is authorized
%% only if either:
%% (1) you make absolutely no changes to your copy, including name; OR
%% (2) if you do make changes, you first rename it to some other name.
%% 
%% To produce the documentation run the original source files ending
%% with `.dtx' through LaTeX.
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
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{BHCexam}
  [2011/07/27 v0.2 BHCexam
   document class]


\input{ctex-common-opts.def}
\input{ctex-class-opts.def}
\input{ctex-caption-opts.def}
\newif\if@sixteenkpaper \@sixteenkpapertrue
\DeclareOption{16kpaper}{\@sixteenkpaperfalse}
\newif\if@marginline \@marginlinefalse
\DeclareOption{marginline}{\@marginlinetrue}
\newif\if@noindent \@noindentfalse
\DeclareOption{noindent}{\@noindenttrue}
\DeclareOption{answers}{\PassOptionsToClass{\CurrentOption}{exam}}

\newif\if@printbox \@printboxfalse
\DeclareOption{printbox}{\@printboxtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions
\LoadClass[addpoints]{exam}
\input{ctex-common.def}
\input{ctex-caption.def}
\input{ctex-class.def}
\RequirePackage{amsmath,amssymb,bm}
\RequirePackage{graphicx}
\RequirePackage{ifpdf,ifxetex}
\if@marginline
\if@sixteenkpaper
\RequirePackage[papersize={184mm,260mm},hmargin={3cm,2cm},
vmargin={2cm,2cm},marginparsep=0.5cm,hoffset=0cm,voffset=0cm,
footnotesep=0.5cm,headsep=0.5cm,twoside]{geometry}
\else
\RequirePackage[paper=a4paper,hmargin={3cm,2cm},vmargin={2cm,2cm},
marginparsep=0.5cm,hoffset=0cm,voffset=0cm,footnotesep=0.5cm,
headsep=0.5cm,twoside]{geometry}
\fi
\else
\if@sixteenkpaper
\RequirePackage[papersize={184mm,260mm},hmargin={2cm,2cm},
vmargin={2cm,2cm},marginparsep=0.5cm,hoffset=0cm,voffset=0cm,
footnotesep=0.5cm,headsep=0.5cm]{geometry}
\else
\RequirePackage[paper=a4paper,hmargin={2cm,2cm},vmargin={2cm,2cm},
marginparsep=0.5cm,hoffset=0cm,voffset=0cm,footnotesep=0.5cm,
headsep=0.5cm]{geometry}
\fi
\fi
\renewcommand{\baselinestretch}{1.5}
\pagestyle{headandfoot}
\header{}{}{}
\footer{}{\small \kaishu{\@kemu}\quad 第~\thepage~页(共~\numpages~页)}{}
\pointname{分}
\pointformat{\kaishu (\thepoints)}
\renewcommand{\solutiontitle}{\noindent\heiti{解：}\noindent}
\renewcommand{\thepartno}{\arabic{partno}}
\renewcommand{\partlabel}{(\thepartno)}
\renewcommand{\partshook}{
  \settowidth{\leftmargin}{(3).\hskip\labelsep}
  \if@noindent \setlength\leftmargin{0pt} \fi
}
\renewcommand{\choiceshook}{
  \settowidth{\leftmargin}{W.\hskip\labelsep}
  \if@noindent \setlength\leftmargin{0pt} \fi
}
\renewenvironment{solution}%
  {%
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        \penalty 0
        \vfill%
        \if@printbox \if@houpinfen \houpinfen \fi \fi
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%
\if@marginline
\newsavebox{\zdxl}
\sbox{\zdxl}{
\begin{minipage}{0.7\paperheight}
\begin{center}
\heiti 班级\underline{\hspace{15ex}} \quad
姓名 \underline{\hspace{15ex}} \quad
学号 \underline{\hspace{15ex}} \quad \\
\vspace{3ex}
\dotfill 装 \dotfill 订 \dotfill 线 \dotfill
\end{center}
\end{minipage}
}
\newsavebox{\zdxr}
\sbox{\zdxr}{
\begin{minipage}{0.7\paperheight}
\begin{center}
\heiti \hfill 请 \hfill 不 \hfill 要 \hfill 在 \hfill
 装 \hfill 订 \hfill 线 \hfill 内 \hfill 答 \hfill 题 \hfill \\
\vspace{3ex}
\dotfill 装 \dotfill 订 \dotfill 线 \dotfill
\end{center}
\end{minipage}
}
\newcommand{\printmlol}{
\marginpar{\rotatebox{90}{\usebox{\zdxl}}}
}
\newcommand{\printmlor}{
\marginpar{\rotatebox{-90}{\usebox{\zdxr}}}
}
\reversemarginpar
\fi
\newcommand\biaoti[1]{\def\@biaoti{#1}}
\newcommand\kemu[1]{\def\@kemu{#1}}
\renewcommand\maketitle{
  \begin{center}{\heiti \Large{\@biaoti}}\end{center}
  \begin{center}{\heiti \Large{\@kemu}}\end{center}
}
\newcommand\xinxi[2]{
  \def\@zongfen{#1}
  \def\@shijian{#2}
}
\newcommand\mininotice{
  \begin{center}{
    \kaishu (本试卷满分~\@zongfen~分, 考试时间~\@shijian~分钟)}
  \end{center}
}
\newcommand{\notice}{
  \heiti 注意事项： \songti
  \begin{enumerate}
  \item 答卷前, 考生务必将姓名、高考准考证号、校验码等填写清楚.
  \item 本试卷共~\numquestions{}~道试题, 满分~\@zongfen~分,考试时间~\@shijian~分钟.
  \end{enumerate}
}
\newlength\@boxwidth
\setlength\@boxwidth{0ex}
\if@printbox \setlength\@boxwidth{18ex} \fi
\newcommand\pinfen{
  \heiti
  \begin{minipage}{\@boxwidth}
  \begin{tabular}{|c|c|}
  \hline
  得分 & 评卷人\\
  \hline
      &       \\
  \hline
  \end{tabular}
  \end{minipage}
}
\newcommand{\houpinfen}{
  \hfill
  \begin{tabular}{|l|l|}
    \hline
    得分 & \hspace*{1.5cm}\\
    \hline
  \end{tabular}
  \bigskip
}
\newcommand\oneb{\underline{\hspace{1em}}\hspace{0.001em}}
\newcommand\twob{\oneb\oneb}
\newcommand{\sixb}{\twob\twob}
\newcommand\tenb{\twob\twob\twob\twob\twob}
\newcounter{@dati}
\newif\if@houpinfen \@houpinfenfalse
\newcommand\settk[3]{
  \def\@tiankong@zongfen{#1}
  \def\@tiankong@tishu{#2}
  \def\@tiankong@fen{#3}
}
\newcommand\tiankong{
  \@houpinfenfalse
  \stepcounter{@dati}
  \fullwidth{
    \if@printbox \pinfen \fi
    \begin{minipage}{\textwidth-\@boxwidth}
    \heiti \chinese{@dati}. 填空题(\kaishu 本大题满分~\@tiankong@zongfen~分) \heiti 本大题有~\@tiankong@tishu~题, 考生应在答题纸相应编号的空格内直接写结果, 每个空格填对得~\@tiankong@fen~分, 否则一律得零分.
    \end{minipage}
  }
}
\newcommand\setxz[3]{
  \def\@xuanze@zongfen{#1}
  \def\@xuanze@tishu{#2}
  \def\@xuanze@fen{#3}
}
\newcommand\xuanze{
  \@houpinfenfalse
  \stepcounter{@dati}
  \fullwidth{
    \if@printbox \pinfen \fi
    \begin{minipage}{\textwidth-\@boxwidth}
      \heiti \chinese{@dati}. 选择题(\kaishu 本大题满分~\@xuanze@zongfen~分) \heiti 本大题共有~\@xuanze@tishu~题, 每题有且只有一个正确答案, 考生应在答题纸的相应编号上, 将代表答案的小方格涂黑, 选对得~\@xuanze@fen~分, 否则一律得零分.
    \end{minipage}
  }
}
\newcommand\setjd[2]{
  \def\@jianda@zongfen{#1}
  \def\@jianda@tishu{#2}
}
\newcommand\jianda{
  \@houpinfentrue
  \qformat{\hskip\labelsep \kaishu \thequestion.~~(本题满分~\totalpoints~分)\hfill}
  \stepcounter{@dati}
  \fullwidth{
    \if@printbox \pinfen \fi
    \begin{minipage}{\textwidth-\@boxwidth}
      \heiti \chinese{@dati}. 简答题(\kaishu 本大题满分~\@jianda@zongfen~分)~\heiti 本大题共有~\@jianda@tishu~题, 解答下列各题必须在答题纸相应的编号规定区域内写出必要的步骤.
    \end{minipage}
  }
}
\newcommand{\rc}{\text{C}}
\newcommand{\ri}{\text{i}}
\newcommand{\ra}{\text{A}}
\newcommand{\rd}{\text{d}}
\newcommand\tian{\ensuremath{\text{d}}}
\newcommand\A{\ensuremath{\text{A}}}
\def\m{\ensuremath{\text{m}}}
\newcommand\g{\ensuremath{\text{g}}}
\newcommand\kg{\ensuremath{\text{kg}}}
\newcommand\degree{\ensuremath{^\circ}}
\newcommand\ssd{\ensuremath{\text{\textcelsius}}}
\newcommand\rad{\ensuremath{\text{rad}}}
\newcommand\N{\ensuremath{\text{N}}}
\newcommand\Pa{\ensuremath{\text{Pa}}}
\newcommand\J{\ensuremath{\text{J}}}
\newcommand\W{\ensuremath{\text{W}}}
\newcommand\ohm{\ensuremath{\Omega}}
\newcommand\mol{\ensuremath{\text{mol}}}
\newcommand\K{\ensuremath{\text{K}}}
\newcommand\h{\ensuremath{\text{h}}}
\newcommand\ton{\ensuremath{\text{t}}}
\newcommand\squarem{\ensuremath{\text{m$^2$}}}
\newcommand\cubicm{\ensuremath{\text{m$^3$}}}
\newcommand\cm{\ensuremath{\text{cm}}}
\newcommand\mm{\ensuremath{\text{mm}}}
\newcommand\squarecm{\ensuremath{\text{cm$^2$}}}
\newcommand\cubiccm{\ensuremath{\text{cm$^3$}}}
\newcommand\squaremm{\ensuremath{\text{mm$^2$}}}
\newcommand\cubicmm{\ensuremath{\text{mm$^3$}}}
\newcommand\liter{\ensuremath{\text{L}}}
\newcommand{\abs}[1]{\left|#1\right|}
\newcommand\arccot{\mathop{\text{arccot}}}
\newcommand\pingxing{\parallel}
\AtEndOfPackage{\makeatletter\input{BHCexam.cfg}\makeatother}

\endinput
%%
%% End of file `BHCexam.cls'.
