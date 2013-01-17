%%
%% This is file `tcldoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% tclldoc.dtx  (with options: `compclass')
%% 
%% This file may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.2 of this
%% license or (at your option) any later version. The latest version
%% of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%% 
%% This file may only be distributed together with a copy of the source
%% file from which it was generated. You may distribute that source file
%% without this generated file.
%% 
\ProvidesClass{tcldoc}
         [2003/04/05 v2.40
              tclldoc compatibility
              class]
\newif\if@rtkinenc@
\DeclareOption{macinputenc}{%
   \PassOptionsToPackage{applemac}{rtkinenc}%
   \@rtkinenc@true
}
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{tclldoc}}
\InputIfFileExists{tcldoc.cfg}
           {\typeout{*************************************^^J%
                     * Local config file tcldoc.cfg used^^J%
                     *************************************}}
           {}
\ProcessOptions\relax
\LoadClass{tclldoc}
\if@rtkinenc@
   \RequirePackage{rtkinenc}
   \DeclareTextCommand{\.}{OT1}[1]{%
      \IfInputModeCode{\TextSymbolUnavailable\.}%
         {\add@accent{95}{#1}}%
   }
   \DeclareTextCommand{\H}{OT1}[1]{%
      \IfInputModeCode{\TextSymbolUnavailable\H}%
         {\add@accent{125}{#1}}%
   }
   \DeclareTextCommand{\textemdash}{OT1}{%
      \IfInputModeCode{\TextSymbolUnavailable\textemdash}{\char 124 }%
   }
   \DeclareTextCommand{\textendash}{OT1}{%
      \IfInputModeCode{\TextSymbolUnavailable\textendash}{\char 123 }%
   }
   \DeclareTextCommand{\textexclamdown}{OT1}{!`}
   \DeclareTextCommand{\textquestiondown}{OT1}{?`}
   \DeclareTextCommand{\textquotedblleft}{OT1}{%
      \IfInputModeCode{\TextSymbolUnavailable\textquotedblleft}%
         {\char 92 }%
   }
   \def\@tempa{applemac}
   \ifx \@tempa\RIE@encoding
      \DeclareInputBoth{173}{\textneq}{\neq}
      \DeclareInputBoth{176}{\textinfty}{\infty}
      \DeclareInputBoth{177}{\textpm}{\pm}
      \DeclareInputBoth{178}{\textleq}{\leq}
      \DeclareInputBoth{179}{\textgeq}{\geq}
      \DeclareInputBoth{181}{\textmu}{\mu}
      \DeclareInputBoth{182}{\textpartial}{\partial}
      \DeclareInputBoth{183}{\textSigma}{\Sigma}
      \DeclareInputBoth{184}{\textPi}{\Pi}
      \DeclareInputBoth{185}{\textpi}{\pi}
      \DeclareInputBoth{186}{\textint}{\int}
      \DeclareInputBoth{189}{\textohm}{\Omega}
      \DeclareInputBoth{194}{\textlnot}{\lnot}
      \DeclareInputBoth{195}{\textsurd}{\surd}
      \DeclareInputBoth{197}{\textapprox}{\approx}
      \DeclareInputBoth{198}{\textDelta}{\Delta}
      \DeclareInputBoth{214}{\textdiv}{\div}
      \DeclareInputBoth{215}{\textdiamond}{\diamond}
      \DeclareInputBoth{218}{\textfractionsolidus}{/}
      \ProvideTextCommandDefault{\textneq}{%
         \TextSymbolUnavailable\textneq
      }
      \ProvideTextCommandDefault{\textapplelogo}{%
         \TextSymbolUnavailable\textapplelogo
      }
      \DeclareTextSymbol{\textinfty}{OMS}{49}
      \DeclareTextSymbol{\textpm}{OMS}{6}
      \DeclareTextSymbol{\textleq}{OMS}{20}
      \DeclareTextSymbol{\textgeq}{OMS}{21}
      \DeclareTextSymbol{\textpartial}{OML}{64}
      \DeclareTextSymbol{\textSigma}{OT1}{6}
      \DeclareTextSymbol{\textPi}{OT1}{5}
      \DeclareTextSymbol{\textpi}{OML}{25}
      \DeclareTextSymbol{\textint}{OMS}{115}
      \DeclareTextSymbol{\textohm}{OT1}{10} % Kind of \textOmega
      \DeclareTextSymbol{\textapprox}{OMS}{25}
      \DeclareTextSymbol{\textDelta}{OT1}{1}
      \DeclareTextSymbol{\textdiamond}{OMS}{5}
      \input{TS1enc.def}
   \fi
\fi
\let\if@rtkinenc@=\@undefined
\let\@rtkinenc@true=\@undefined
\let\@rtkinenc@false=\@undefined
\endinput
%%
%% End of file `tcldoc.cls'.
