%%
%% This is file `kerntest.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% kerntest.dtx  (with options: `class')
%% 
%%   kerntest class
%% 
%%   Copyright  2004 Harald Harders
%% 
%%   This program can be redistributed and/or modified under the terms
%%   of the LaTeX Project Public License Distributed from CTAN
%%   archives in directory macros/latex/base/lppl.txt; either
%%   version 1.3 of the License, or any later version.
%% 
%%   h.harders@tu-bs.de
%% 
\ProvidesClass{kerntest}
  [2004/04/14  v1.32  Generate kerning tables]
\LoadClass[10pt]{article}
\RequirePackage[top=18mm,left=15mm,right=15mm,bottom=20mm]{geometry}
\renewcommand*\familydefault{\sfdefault}
\RequirePackage{helvet}
\RequirePackage{calc}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{color}
\RequirePackage{ifthen}
\RequirePackage{keyval}
\pagestyle{myheadings}
\def\@oddfoot{Kerning data, marked with $\ast$, are automatically reused
  from values given before.
  Repeated values are marked by $\dagger$.\hfill}
\def\@evenfoot{\@oddfoot}
\setlength{\parindent}{0mm}
\newlength\krntst@size
\newlength\krntst@baselineskip
\def\krntst@encoding{T1}
\def\krntst@series{m}
\def\krntst@shape{n}
\setlength\krntst@size{17.28pt}
\setlength\krntst@baselineskip{1.2\krntst@size}
\def\krntst@example{example}
\def\krntst@extraname{}
\definecolor{oldcolor}{gray}{0.5}
\definecolor{newcolor}{gray}{0}
\newboolean{krntst@writeall}
\newcommand\krntst@designsize{1em}
\def\ProcessOptionsWithKV#1{%
  \let\@tempc\relax
  \let\KVo@tempa\@empty
  \edef\KVo@tempa{%
    \noexpand\setkeys{#1}{%
      \@ptionlist{\@currname.\@currext}%
    }%
  }%
  \KVo@tempa
  \let\CurrentOption\@empty
}
\define@key{krntst}{encoding}{\def\krntst@encoding{#1}}
\define@key{krntst}{family}{\def\krntst@family{#1}}
\define@key{krntst}{series}{\def\krntst@series{#1}}
\define@key{krntst}{shape}{\def\krntst@shape{#1}}
\define@key{krntst}{size}{%
  \setlength\krntst@size{#1}%
  \setlength\krntst@baselineskip{1.2\krntst@size}%
}
\define@key{krntst}{baselineskip}{\setlength\krntst@baselineskip{#1}}
\define@key{krntst}{designsize}{\def\krntst@designsize{#1}}%
\define@key{krntst}{example}{\def\krntst@example{#1}}
\define@key{krntst}{papersize}{\geometry{#1}}
\define@key{krntst}{extraname}{\def\krntst@extraname{-#1}}
\define@key{krntst}{color}[true]{%
  \csname if#1\endcsname
    \definecolor{oldcolor}{gray}{0}%
    \definecolor{newcolor}{rgb}{1,0,0}%
  \else
    \definecolor{oldcolor}{gray}{0.5}%
    \definecolor{newcolor}{gray}{0}%
  \fi
}
\define@key{krntst}{copyquotation}[true]{%
  \csname if#1\endcsname
    \newglyphclass{left}{leftguillemots}{guillemotleft,guilsinglleft}%
    \newglyphclass{right}{leftguillemots}{guillemotleft,guilsinglleft}%
    \newglyphclass{left}{rightguillemots}{guillemotright,guilsinglright}%
    \newglyphclass{right}{rightguillemots}{guillemotright,guilsinglright}%
    \newglyphclass{left}{leftquotes}{quotedblleft,quoteleft}%
    \newglyphclass{right}{leftquotes}{quotedblleft,quoteleft}%
    \newglyphclass{left}{rightquotes}{quotedblright,quoteright}%
    \newglyphclass{right}{rightquotes}{quotedblright,quoteright}%
    \newglyphclass{left}{basequotes}{quotedblbase,quotesinglbase}%
    \newglyphclass{right}{basequotes}{quotedblbase,quotesinglbase}%
  \fi
}
\define@key{krntst}{writeall}[true]{%
  \setboolean{krntst@writeall}{#1}%
  \ClassWarningNoLine{kerntest}{You are writing the new and the
    original kerning data\MessageBreak
    to the mtx file (option `writeall'). Normally, it is\MessageBreak
    not necessary to write original data}%
}
\define@key{krntst}{footer}[true]{%
  \csname if#1\endcsname
  \else
    \def\@oddfoot{}%
    \def\@evenfoot{\@oddfoot}%
  \fi
}
\newcommand\kernsetup{\setkeys{krntst}}
\@onlypreamble\kernsetup
\AtEndOfClass{%
  \InputIfFileExists{kerntest.cfg}{%
    \message{Configuration file `kerntest.cfg' loaded.}%
  }{%
    \message{No configuration file `kerntest.cfg' found.}%
  }
  \ProcessOptionsWithKV{krntst}
  \let\@unprocessedoptions\relax
}
\ifx\krntst@family\relax
  \ClassError{kerntest}{Class option family not or incorrect
    given\@gobble}{%
    You have to specify the font family by using the
    class\MessageBreak
    option family=<fontfamily>}%
  \stop
\fi
\AtEndOfClass{%
  \define@key{krntst}{family}{%
    \ClassError{kerntest}{Option `family' used outside
      \string\documentclass\space command}{%
      The option `family=<fontfamily>' has to be specified in the
      optional argument\MessageBreak
      of the \string\documentclass\space command.}%
  }
}
\newcommand\mtxcomment[1]{%
  \protected@write\mtxfile{}{\@percentchar\space #1}%
}
\newcommand\krntst@helpfont{\normalfont\normalsize}
\newcounter{@glyphslot}%
\AtBeginDocument{%
  \RequirePackage[\krntst@encoding,T1]{fontenc}
  \edef\reserved@f{%
    \lowercase{\def\noexpand\reserved@f{\krntst@encoding mtx.clo}}}%
  \reserved@f
  \InputIfFileExists\reserved@f{}{%
    \ClassWarningNoLine{kerntest}{Postscript name file `\reserved@f'
      not found.\MessageBreak
      The kerning table will be okay, but the generated mtx file will
      not be usable}%
    \newcommand\getpsname[1]{unknown character `##1'}%
  }%
  \setcounter{@glyphslot}{0}%
  \whiledo{\the\c@@glyphslot<256}{%
    \expandafter\edef
    \csname slotnumber@glyph@\getpsname{\the\c@@glyphslot}\endcsname{%
      \the\c@@glyphslot}%
    \stepcounter{@glyphslot}%
  }%
  \begingroup
    \usefont{\krntst@encoding}{\krntst@family}{\krntst@series}{\krntst@shape}%
    \fontsize{\krntst@size}{\krntst@baselineskip}\selectfont%
    \psunit=\krntst@designsize\relax
    \global\psunit=0.001\psunit
    \typeout{Requested: \krntst@encoding-\krntst@family-%
      \krntst@series-\krntst@shape, size \the\krntst@size}%
    \typeout{Using:\space\space\space\space\space \f@encoding-\f@family-%
      \f@series-\f@shape, size \f@size pt}%
    \expandafter\ifdim\the\krntst@size=\f@size pt\relax
    \else
      \ClassWarningNoLine{kerntest}{Using different font size than
        requested}%
    \fi
    \setlength{\@tempdima}{\krntst@designsize}%
    \typeout{Postscript font unit for design size \the\@tempdima:
      \the\psunit}%
    \expandafter\ifdim\the\@tempdima=\f@size pt\relax
    \else
      \ClassWarningNoLine{kerntest}{The design size (\the\@tempdima,
        1em by default,\MessageBreak
        or given value from option `designsize') of the
        font\MessageBreak
        is not equal to the LaTeX font size (\f@size pt).\MessageBreak
        This can have two reasons:\MessageBreak
        1. The font does not define 1em to be the design
        size\MessageBreak
        \space\space\space (for example, Computer
        Modern).\MessageBreak
        2. The font is implicitely scaled by the fd-file\MessageBreak
        \space\space\space (for example, when using
        helvet.sty).\MessageBreak
        This can cause the PostScript font unit length to
        be\MessageBreak
        incorrect.
        You may set the design size for calculation\MessageBreak
        of the font unit explicitely by using the class\MessageBreak
        option `designsize'}%
    \fi
    \edef\mtxfilename{%
      \lowercase{\gdef\noexpand\mtxfilename{%
          \f@encoding-\f@family-\f@series-\f@shape\krntst@extraname}}}%
    \mtxfilename
    \markboth{\upshape Font \mtxfilename}{\upshape Font \mtxfilename}%
    \typeout{^^JWriting mtx file `\mtxfilename.mtx'^^J}%
    \immediate\openout\mtxfile\mtxfilename.mtx
    \protected@write\mtxfile{}{\@percentchar\@percentchar}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      This is file `\mtxfilename.mtx',}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      generated on \number\year/\number\month/\number\day\space
      by kerntest.cls, (c) 2004 Harald Harders.}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      The original source file was:}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      \jobname\space (.tex?) with these font options:}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      Encoding: \f@encoding}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      Family: \space\space\f@family}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      Series: \space\space\f@series}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      Shape: \space\space\space\f@shape}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      User-defined name: \krntst@extraname}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar}%
    \protected@write\mtxfile{}{\string\relax}%
    \protected@write\mtxfile{}{\string\metrics}%
    \protected@write\mtxfile{}{\string\needsfontinstversion{1.926}}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      Kerning data for single characters and}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      the first members of the glyph classes.}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      After each \string\setkern\space entry, the glyph classes}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar\space
      for both glyphs are given (./. means no class).}%
    \protected@write\mtxfile{}{\@percentchar\@percentchar}%
  \endgroup
}
\newwrite\mtxfile
\def\krntst@round#1.#2#3#4\@empty{%
  \setlength\@tempdimc{#1pt}%
  \if#2.%
  \else
    \ifnum#2>4
      \ifnum#1#2<0
        \addtolength\@tempdimc{-1.1pt}%
      \else
        \addtolength\@tempdimc{1.1pt}%
      \fi
    \fi
  \fi
  \edef\rnd@tempa{\strip@pt\@tempdimc}%
  \expandafter\krntst@@round\rnd@tempa.000\@empty
}
\def\krntst@@round#1.#2#3\@empty{\def\kernlen{#1}}
\newcommand*\round[1]{%
  \setlength\@tempdimc{#1}%
  \edef\rnd@tempa{\strip@pt\@tempdimc}%
  \expandafter\krntst@round\rnd@tempa.000\@empty
}
\newlength\psunit
\newcommand\getpsunit[1]{%
  \setlength\@tempdima{1pt*\ratio{#1}{\psunit}}%
}
\newcommand\getkern[2]{%
  \settowidth\@tempdima{#1#2}%
  \settowidth\@tempdimb{#1\kern0pt#2}%
  \setlength\@tempdima{1pt*\ratio{(\@tempdima-\@tempdimb)*1000}{1em}}%
  \round{\@tempdima}%
}
\def\@saveslotnumber#1#2\@empty{%
  \if#1"\relax
    \setcounter{@glyphslot}{#1#2}%
  \else
    \if#1'\relax
      \setcounter{@glyphslot}{#1#2}%
    \else
      \ifnum9<1#1\relax
        \setcounter{@glyphslot}{#1#2}%
      \else
        \begingroup\expandafter\expandafter\expandafter\endgroup
        \expandafter\ifx\csname slotnumber@glyph@#1#2\endcsname\relax
          \setcounter{@glyphslot}{-1}%
        \else
          \setcounter{@glyphslot}{\csname slotnumber@glyph@#1#2\endcsname}%
        \fi
      \fi
    \fi
  \fi
  \ifnum\the\c@@glyphslot>255\relax
    \setcounter{@glyphslot}{-1}%
  \fi
}
\DeclareRobustCommand*\saveslotnumber[2]{%
  \expandafter\@saveslotnumber#2\@empty
  \setcounter{#1}{\the\c@@glyphslot}%
}
\newcommand\getslotnumber[1]{%
  \expandafter\@saveslotnumber#1\@empty
  \ifnum\the\c@@glyphslot<0\relax
    \textbf{???}%
  \else
    \ifnum\c@@glyphslot<100\relax0\fi
    \ifnum\c@@glyphslot<10\relax0\fi
    \the\c@@glyphslot
  \fi
}
\newcommand*\printglyph[1]{%
  \expandafter\@saveslotnumber#1\@empty
  \char\the\c@@glyphslot
}
\edef\@minussign{-}%
\newcounter{@slota}
\newcounter{@slotb}
\newcounter{@slotc}
\newcommand\testkern[5]{%
  \xdef\@kernlena{#2}%
  \xdef\@kernlenb{#4}%
  \saveslotnumber{@slota}{#1}%
  \ifnum\the\c@@slota<0%
    \ClassError{kerntest}{Used unknown glyph `#1'}{%
      You may have misspelled the glyph or you have taken an invalid
      number.}%
    \setcounter{@slota}{0}%
  \fi
  \saveslotnumber{@slotb}{#3}%
  \ifnum\the\c@@slotb<0%
    \ClassError{kerntest}{Used unknown glyph `#3'}{%
      You may have misspelled the glyph or you have taken an invalid
      number.}%
    \setcounter{@slotb}{0}%
  \fi
  \saveslotnumber{@slotc}{#5}%
  \ifnum\the\c@@slotc<0%
    \ClassError{kerntest}{Used unknown glyph `#5'}{%
      You may have misspelled the glyph or you have taken an invalid
      number.}%
    \setcounter{@slotc}{0}%
  \fi
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname kt@kerning@\getpsname{\the\c@@slota}@%
  \getpsname{\the\c@@slotb}\endcsname\relax
    \gdef\oldkerna{}%
  \else
    \gdef\oldkerna{%
      \kern
      \csname kt@kerning@\getpsname{\the\c@@slota}@%
      \getpsname{\the\c@@slotb}\endcsname
      \psunit
    }%
    \ifx\@kernlena\@minussign
      \typeout{Kerning pair for \getpsname{\the\c@@slota}-%
        \getpsname{\the\c@@slotb} reused (value
        \csname kt@kerning@\getpsname{\the\c@@slota}@%
        \getpsname{\the\c@@slotb}\endcsname).}%
    \else
      \ifnum\@kernlena=\csname kt@kerning@\getpsname{\the\c@@slota}@%
      \getpsname{\the\c@@slotb}\endcsname\relax
        \ClassWarning{kerntest}{Kerning for
          \getpsname{\the\c@@slota}-\getpsname{\the\c@@slotb}\MessageBreak
          repeated (value #2)}%
      \else
        \ClassError{kerntest}{Conflicting kerning for
          \getpsname{\the\c@@slota}-\getpsname{\the\c@@slotb}\MessageBreak
          (new value #2 != old value
          \csname kt@kerning@\getpsname{\the\c@@slota}@%
          \getpsname{\the\c@@slotb}\endcsname)%
        }{%
          You have given the kerning for the specified glyph pair
          twice with different\MessageBreak
          values. This may also appear when using glyph classes.
          You have to give the\MessageBreak
          kerning only once per glyph class.\MessageBreak
          You may leave out the second kerning pair, or you may
          give\MessageBreak
          the kerning `-'. Then, the old value is reused.
        }%
      \fi
    \fi
  \fi
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname kt@kerning@\getpsname{\the\c@@slotb}@%
  \getpsname{\the\c@@slotc}\endcsname\relax
    \gdef\oldkernb{}%
  \else
    \gdef\oldkernb{%
      \kern
      \csname kt@kerning@\getpsname{\the\c@@slotb}@%
      \getpsname{\the\c@@slotc}\endcsname
      \psunit
    }%
    \ifx\@kernlenb\@minussign
      \typeout{Kerning pair for \getpsname{\the\c@@slotb}-%
        \getpsname{\the\c@@slotc} reused (value
        \csname kt@kerning@\getpsname{\the\c@@slotb}@%
        \getpsname{\the\c@@slotc}\endcsname).}%
    \else
      \ifnum\@kernlenb=\csname kt@kerning@\getpsname{\the\c@@slotb}@%
      \getpsname{\the\c@@slotc}\endcsname\relax
        \ClassWarning{kerntest}{Kerning for
          \getpsname{\the\c@@slotb}-\getpsname{\the\c@@slotc}\MessageBreak
          repeated (value #4)}%
      \else
        \ClassError{kerntest}{Conflicting kerning for
          \getpsname{\the\c@@slotb}-\getpsname{\the\c@@slotc}\MessageBreak
          (new value #4 != old value
          \csname kt@kerning@\getpsname{\the\c@@slotb}@%
          \getpsname{\the\c@@slotc}\endcsname)%
        }{%
          You have given the kerning for the specified glyph pair
          twice with different\MessageBreak
          values. This may also appear when using glyph classes.
          You have to give the\MessageBreak
          kerning only once per glyph class.\MessageBreak
          You may leave out the second kerning pair, or you may
          give\MessageBreak
          the kerning `-'. Then, the old value is reused.
        }%
      \fi
    \fi
  \fi
  \krntst@helpfont\getslotnumber{#3}%
  &
  \krntst@helpfont\getpsname{\the\c@@slotb}%
  &
  \char\the\c@@slota\char\c@@slotb\char\c@@slotc%
  &
  \char\the\c@@slota%
  \ifx\@kernlena\@minussign
    \oldkerna
  \else
    \kern#2\psunit
  \fi
  \char\the\c@@slotb%
  \ifx\@kernlenb\@minussign
    \oldkernb
  \else
    \kern#4\psunit
  \fi
  \char\the\c@@slotc%
  &
  \color{oldcolor}%
  \makebox[0pt][l]{\char\the\c@@slota\char\the\c@@slotb\char\the\c@@slotc}%
  \ifx\@kernlena\@minussign
    \ifthenelse{\equal{\oldkerna}{}}{}{\color{newcolor}}%
  \else
    \color{newcolor}%
  \fi
  \ifx\@kernlenb\@minussign
    \ifthenelse{\equal{\oldkernb}{}}{}{\color{newcolor}}%
  \else
    \color{newcolor}%
  \fi
  \char\the\c@@slota%
  \ifx\@kernlena\@minussign
    \oldkerna
  \else
    \kern#2\psunit
  \fi
  \char\the\c@@slotb%
  \ifx\@kernlenb\@minussign
    \oldkernb
  \else
    \kern#4\psunit
  \fi
  \char\the\c@@slotc%
  &
  \getkern{\char\the\c@@slota}{\char\the\c@@slotb}%
  \krntst@helpfont
  \ifx\@kernlena\@minussign
    \ifthenelse{\equal{\oldkerna}{}}{%
      \textcolor{oldcolor}{\small
        \ifdim\kernlen pt<0pt-\fi
        \ifdim\kernlen pt>0pt+\fi
        \kernlen}%
    }{%
      \ifnum\kernlen=0\relax
      \else
        \textcolor{oldcolor}{\small(%
          \ifdim\kernlen pt<0pt-\fi
          \ifdim\kernlen pt>0pt+\fi
          \kernlen)}%
      \fi
      ~\textcolor{newcolor}{\large
        \ifnum
        \csname kt@kerning@\getpsname{\the\c@@slota}@%
        \getpsname{\the\c@@slotb}\endcsname<0-\fi
        \csname kt@kerning@\getpsname{\the\c@@slota}@%
        \getpsname{\the\c@@slotb}\endcsname
        \makebox[0pt][l]{$^\ast$}%
      }%
    }%
    \ifthenelse{\boolean{krntst@writeall}\and\not\equal{\kernlen}{0}}{%
      \writemtxkern[original kerning]{\the\c@@slota}{%
        \ifdim\kernlen pt>0pt+\fi\kernlen}{\the\c@@slotb}%
      }{}%
  \else
    \ifdim\kernlen pt=0pt
    \else
      \textcolor{oldcolor}{\small(%
        \ifdim\kernlen pt<0pt-\fi
        \ifdim\kernlen pt>0pt+\fi
        \kernlen)}
    \fi
    \textcolor{newcolor}{\large
      \ifnum#2<0-\fi#2%
      \ifthenelse{\equal{\oldkerna}{}}{%
      }{\makebox[0mm][l]{$^\dagger$}}%
    }%
    \ifthenelse{\equal{\oldkerna}{}}{%
      \writemtxkern{\the\c@@slota}{#2}{\the\c@@slotb}%
    }{}%
  \fi
  &
  \getkern{\char\the\c@@slotb}{\char\the\c@@slotc}%
  \krntst@helpfont
  \ifx\@kernlenb\@minussign
    \ifthenelse{\equal{\oldkernb}{}}{%
      \textcolor{oldcolor}{\small
        \ifdim\kernlen pt<0pt-\fi
        \ifdim\kernlen pt>0pt+\fi
        \kernlen}%
    }{%
      \ifnum\kernlen=0\relax
      \else
        \textcolor{oldcolor}{\small(%
          \ifdim\kernlen pt<0pt-\fi
          \ifdim\kernlen pt>0pt+\fi
          \kernlen)}%
      \fi
      ~\textcolor{newcolor}{\large
        \ifnum
        \csname kt@kerning@\getpsname{\the\c@@slotb}@%
        \getpsname{\the\c@@slotc}\endcsname<0-\fi
        \csname kt@kerning@\getpsname{\the\c@@slotb}@%
        \getpsname{\the\c@@slotc}\endcsname
        \makebox[0pt][l]{$^\ast$}%
      }%
    }%
    \ifthenelse{\boolean{krntst@writeall}\and\not\equal{\kernlen}{0}}{%
      \writemtxkern[original kerning]{\the\c@@slotb}{%
        \ifdim\kernlen pt>0pt+\fi\kernlen}{\the\c@@slotc}%
    }{}%
  \else
    \ifdim\kernlen pt=0pt
    \else
      \textcolor{oldcolor}{\small(%
        \ifdim\kernlen pt<0pt-\fi
        \ifdim\kernlen pt>0pt+\fi
        \kernlen)}
    \fi
    \textcolor{newcolor}{\large
      \ifnum#4<0-\fi#4%
      \ifthenelse{\equal{\oldkernb}{}}{%
        }{\makebox[0mm][l]{$^\dagger$}}%
    }%
    \ifthenelse{\equal{\oldkernb}{}}{%
      \writemtxkern{\the\c@@slotb}{#4}{\the\c@@slotc}%
    }{}%
  \fi
  &
  \char\the\c@@slota\char\the\c@@slotb
  \krntst@example
  \char\the\c@@slotb\char\the\c@@slotc
  &
  \char\the\c@@slota%
  \ifx\@kernlena\@minussign
  \else
    \kern#2\psunit
  \fi
  \char\the\c@@slotb\krntst@example\char\the\c@@slotb
  \ifx\@kernlenb\@minussign
  \else
    \kern#4\psunit
  \fi
  \char\the\c@@slotc%
  &
  \krntst@helpfont\ignorespaces
}
\newenvironment{kerntable}{%
  \usefont{\krntst@encoding}{\krntst@family}{\krntst@series}{\krntst@shape}%
  \fontsize{\krntst@size}{\krntst@baselineskip}\selectfont%
  \begin{longtable}[l]{@{}lll@{~}l@{~}l@{~}rrlll@{}}
    \krntst@helpfont slot&
    \krntst@helpfont name&
    \krntst@helpfont orig&
    \krntst@helpfont new&
    \krntst@helpfont both&
    \krntst@helpfont k.\,1&
    \krntst@helpfont k.\,2&
    \krntst@helpfont orig.&
    \krntst@helpfont new&
    \krntst@helpfont comment\\
    \endhead
    \krntst@helpfont slot&
    \krntst@helpfont name&
    \krntst@helpfont orig&
    \krntst@helpfont new&
    \krntst@helpfont both&
    \krntst@helpfont k.\,1&
    \krntst@helpfont k.\,2&
    \krntst@helpfont orig.&
    \krntst@helpfont new&
    \krntst@helpfont comment\\
    \endfoot
  }{%
  \end{longtable}%
  \ignorespacesafterend
}
\newif\if@tempswb
\newcommand\writemtxkern[4][\@empty]{%
  \expandafter\@saveslotnumber#2\@empty
  \edef\@firstglyphname{\getpsname{\c@@glyphslot}}%
  \expandafter\@saveslotnumber#4\@empty
  \edef\@secondglyphname{\getpsname{\c@@glyphslot}}%
  \ifthenelse{\equal{#1}{\@empty}}{%
    \edef\rightkern{\getclassofglyph{right}{\@firstglyphname}}%
    \ifthenelse{\equal{\rightkern}{\@empty}}{%
      \edef\textright{./.}%
      \def\rightkern{@firstglyphname}%
    }{%
      \edef\textright{\expandafter\@getclassname\rightkern\@empty}%
    }%
    \edef\leftkern{\getclassofglyph{left}{\@secondglyphname}}%
    \ifthenelse{\equal{\leftkern}{\@empty}}{%
      \edef\textleft{./.}%
      \def\leftkern{@secondglyphname}%
    }{%
      \edef\textleft{\expandafter\@getclassname\leftkern\@empty}%
    }%
    \@tempswbtrue
    \@forallinclass{\rightkern}{first}{%
      \@forallinclass{\leftkern}{second}{%
        \if@tempswb
          \protected@write\mtxfile{}{%
            \string\setkern
            {\first}{\second}{#3}%
            \@percentchar\space\space\textright\space-- \textleft
          }% protected@write
          \@tempswbfalse
        \fi
        \setcounter{@tmpscale}{#3*\first@scaling*\second@scaling/1000000}%
        \typeout{\first-\second: \the@tmpscale}%
        \expandafter\xdef\csname kt@kerning@\first @\second\endcsname{%
          \the@tmpscale}%
      }% forallinclass second
    }% forallinclass first
  }{%
    \protected@write\mtxfile{}{%
      \string\setkern
      {\@firstglyphname}{\@secondglyphname}{#3}%
      \@percentchar\space\space #1%
    }%
    \expandafter\xdef
      \csname kt@kerning@\@firstglyphname@\@secondglyphname\endcsname{#3}%
  }%
}%
\newcounter{@tmpscale}
\newcounter{@firstscale}
\newcommand\defglyphclass[3]{%
  \AtBeginDocument{%
    \@ifundefined{glyphclasslist@#1}{%
      \expandafter\def\csname glyphclasslist@#1\endcsname{%
        glyphclass@#1@#2}%
    }{%
      \begingroup
      \@tempswatrue
      \forallclasses{#1}{@tmpcls}{%
        \ifthenelse{\equal{\@tmpcls}{glyphclass@#1@#2}}{%
          \@tempswafalse
        }{}%
      }%
      \if@tempswa
        \expandafter\xdef\csname glyphclasslist@#1\endcsname{%
          \csname glyphclasslist@#1\endcsname,glyphclass@#1@#2}%
      \fi
      \endgroup
    }%
    \expandafter\def\csname glyphclass@#1@#2\endcsname{}%
    \edef\@tempa{#3}%
    \@tempswbtrue
    \@forallinclass{@tempa}{@tmpglyph}{%
      \saveslotnumber{@glyphslot}{\@tmpglyph}%
      \ifnum\the\c@@glyphslot<0%
        \ClassError{kerntest}{Used unknown glyph `\@tmpglyph'}{%
          You may have misspelled the glyph or you have taken an invalid
          number.
          This incorrect glyph is ignored.}%
        \edef\thisglyphname{???}%
      \else
        \edef\thisglyphname{\getpsname{\the\c@@glyphslot}}%
        \if@tempswb
          \global\@tempswbfalse
          \setcounter{@firstscale}{\@tmpglyph@scaling}%
        \fi
        \setcounter{@tmpscale}{1000*\@tmpglyph@scaling/\the@firstscale}%
        \@tempswatrue
        \forallclasses{#1}{@tmpcls}{%
          \@ifglyphinclass{\@tmpcls}{\@tmpglyph}{%
            \@tempswafalse
            \ClassError{kerntest}{Glyph `\@tmpglyph'
              (`\thisglyphname',\MessageBreak
              glyph class #1/#2) already\MessageBreak
              in glyph
              class (\expandafter\@getclassname\@tmpcls\@empty)%
            }{%
              Each glyph may only be once in one glyph class for
              each side.
            }%
          }{}%
        }%
        \if@tempswa
          \ifthenelse{\equal{\csname glyphclass@#1@#2\endcsname}{}}{%
            \expandafter\edef\csname glyphclass@#1@#2\endcsname{%
              \thisglyphname[\the@tmpscale]}%
            \edef\firstglyphinclass{\thisglyphname}%
          }{%
            \expandafter\edef\csname glyphclass@#1@#2\endcsname{%
              \csname glyphclass@#1@#2\endcsname,%
              \thisglyphname[\the@tmpscale]}%
          }%
          \expandafter\edef
          \csname glyphclass@glyph@#1@\thisglyphname\endcsname{%
            glyphclass@#1@#2}%
        \fi
      \fi
    }%
    \typeout{Glyph class `#1/#2' (\csname glyphclass@#1@#2\endcsname)
      defined.}%
  }%
}
\newcommand\newglyphclass[3]{%
  \AtBeginDocument{%
    \@tempswatrue
    \forallclasses{#1}{@tmpcls}{%
      \ifthenelse{\equal{\@tmpcls}{glyphclass@#1@#2}}{%
        \ClassError{kerntest}{Class `#1/#2' already exists}{%
          The command is ignored.}%
        \@tempswafalse
      }{}%
    }%
    \if@tempswa
      \defglyphclass{#1}{#2}{#3}%
    \fi
  }%
}
\newcommand\renewglyphclass[3]{%
  \AtBeginDocument{%
    \@tempswafalse
    \forallclasses{#1}{@tmpcls}{%
      \ifthenelse{\equal{\@tmpcls}{glyphclass@#1@#2}}{%
        \@tempswatrue
      }{}%
    }%
    \if@tempswa
      \defglyphclass{#1}{#2}{#3}%
    \else
      \ClassError{kerntest}{Class `#1/#2' does not exists}{%
        The command is ignored.}%
    \fi
  }%
}
\newcommand\provideglyphclass[3]{%
  \AtBeginDocument{%
    \@tempswatrue
    \forallclasses{#1}{@tmpcls}{%
      \ifthenelse{\equal{\@tmpcls}{glyphclass@#1@#2}}{%
        \@tempswafalse
      }{}%
    }%
    \if@tempswa
      \defglyphclass{#1}{#2}{#3}%
    \fi
  }%
}
\def\@getclassname#1@#2@#3\@empty{#2/#3}
\newcommand*\getclassofglyph[2]{%
  \expandafter\ifx\csname glyphclass@glyph@#1@#2\endcsname\relax
    \@empty
  \else
    \csname glyphclass@glyph@#1@#2\endcsname
  \fi
}
\newif\if@glyphfound
\newcommand\ifglyphinclass[5]{%
  \@ifundefined{glyphclass@#1@#2}{%
    \ClassError{kerntest}{Glyph class #1/#2 not available}{}%
  }{%
    \edef\@tempa{#3}%
    \saveslotnumber{@tempcnta}{\@tempa}%
    \ifnum\the\c@@tempcnta<0%
      \ClassError{kerntest}{Used unknown glyph `#2'}{%
        You may have misspelled the glyph or you have taken an invalid
        number.}%
    \else
      \ifthenelse{\equal{glyphclass@#1@#2}{%
          \getclassofglyph{#1}{\getpsname{\the\c@@tempcnta}}}}{%
        #4%
      }{%
        #5%
      }%
    \fi
  }%
}
\newcounter{@tempcnta}
\newcommand\@ifglyphinclass[4]{%
  \@ifundefined{#1}{%
    \ClassError{kerntest}{Glyph class #1 not available}{}%
  }{%
    \def\krntst@side##1@##2@##3\@empty{\edef\krntst@side{##2}}%
    \expandafter\krntst@side#1\@empty
    \edef\@tempa{#2}%
    \saveslotnumber{@tempcnta}{\@tempa}%
    \ifnum\the\c@@tempcnta<0\relax
      \ClassError{kerntest}{Used unknown glyph `#2'}{%
        You may have misspelled the glyph or you have taken an invalid
        number.}%
    \else
      \ifthenelse{\equal{#1}{%
          \getclassofglyph{\krntst@side}{\getpsname{\the\c@@tempcnta}}}}{%
        #3%
      }{%
        #4%
      }%
    \fi
  }%
}
\newcommand\forallinclass[4]{%
  \@forallinclass{glyphclass@#1@#2}{#3}{#4}%
}
\newcommand\@forallinclass[3]{%
  \renewcommand\stoploop[1][#2]{%
    \expandafter\edef\csname ##1\endcsname{}%
  }%
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname #1\endcsname\relax
    \edef\kt@tempa{}%
  \else
    \edef\kt@tempa{\csname #1\endcsname}%
  \fi
  \expandafter\@nextglyphinclass\kt@tempa,\@empty{#2}%
  \whiledo{\not\equal{\csname #2\endcsname}{}}{%
    #3%
    \ifthenelse{\equal{\csname #2\endcsname}{}}{%
    }{%
      \edef\kt@tempa{\csname #2@rest\endcsname}%
      \expandafter\@nextglyphinclass\kt@tempa,\@empty{#2}%
    }%
  }%
}
\def\@@parseglyphname#1[#2]#3\@empty#4{%
  \expandafter\edef\csname#4\endcsname{#1}%
  \expandafter\xdef\csname#4@scaling\endcsname{#2}%
}
\def\@nextglyphinclass#1,#2\@empty#3{%
  \expandafter\edef\csname#3@rest\endcsname{#2}%
  \expandafter\@@parseglyphname#1[1000]\@empty{#3}%
}
\newcommand\forallclasses[3]{%
  \renewcommand\stoploop[1][#2]{%
    \expandafter\edef\csname ##1\endcsname{}%
  }%
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname glyphclasslist@#1\endcsname\relax
  \edef\kt@tempa{}%
  \else
    \edef\kt@tempa{\csname glyphclasslist@#1\endcsname}%
  \fi
  \expandafter\@nextclass\kt@tempa,\@empty{#2}%
  \whiledo{\not\equal{\csname #2\endcsname}{}}{%
    #3%
    \ifthenelse{\equal{\csname #2\endcsname}{}}{%
    }{%
      \edef\kt@tempa{\csname #2@rest\endcsname}%
      \expandafter\@nextclass\kt@tempa,\@empty{#2}%
    }%
  }%
}
\newcommand\stoploop[1][]{%
  \expandafter\edef\csname #1\endcsname{}%
}
\def\@nextclass#1,#2\@empty#3{%
  \expandafter\edef\csname #3@rest\endcsname{#2}%
  \expandafter\edef\csname #3\endcsname{#1}%
}
\newcommand\encodingsetup[1]{%
  \AtBeginDocument{%
    \typeout{Setup for font encoding.
      This differs from encoding to encoding.}%
    \setkeys{krnenc}{#1}%
  }%
}
\@onlypreamble\encodingsetup
\AtEndDocument{%
  \typeout{Writing kerning factors for glyph classes to mtx file}%
  \protected@write\mtxfile{}{\@percentchar\@percentchar}%
  \protected@write\mtxfile{}{\@percentchar\@percentchar\space
    Kerning factors for the different glyph classes.}%
  \protected@write\mtxfile{}{\@percentchar\@percentchar}%
  \def\@writeclass#1{%
    \forallclasses{#1}{@tmpcls}{%
      \typeout{\space\space for class
        \expandafter\@getclassname\@tmpcls\@empty}%
      \@tempswatrue
      \@forallinclass{\@tmpcls}{@tmpglyph}{%
        \if@tempswa
          \edef\firstglyphinclass{\@tmpglyph}%
          \@tempswafalse
        \else
          \protected@write\mtxfile{}{%
            \string\set#1kerning%
            {\@tmpglyph}{\firstglyphinclass}{\@tmpglyph@scaling}%
            \@percentchar\space\space
            \expandafter\@getclassname\@tmpcls\@empty
          }%
        \fi
      }%
    }%
  }%
  \@writeclass{left}%
  \protected@write\mtxfile{}{\@percentchar\@percentchar}%
  \@writeclass{right}%
  \protected@write\mtxfile{}{\@percentchar\@percentchar}%
  \protected@write\mtxfile{}{\string\endmetrics}%
  \protected@write\mtxfile{}{\@percentchar\@percentchar}%
  \protected@write\mtxfile{}{\@percentchar\@percentchar\space
    End of file `\mtxfilename.mtx'.}%
  \closeout\mtxfile
  \typeout{^^JWritten mtx file `\mtxfilename.mtx'^^J}%
}

\endinput
%%
%% End of file `kerntest.cls'.
