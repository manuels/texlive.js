\ProvidesFile{makedoc.tpl}[2011/09/14 
                           makedoc preprocessing template]
\RequirePackage{makedoc}
\renewcommand*{\mdJobName}{SAMPLE}
\input{mdoccorr.cfg} 
\LaTeXresultFile{\mdJobName.doc}
\HeaderLines{0}
\ProcessLineMessage{}
\MainDocParser{%
%   \WriteResult{\ProcessInputWith{dots}}% 
  \WriteResult{\CorrectedInputLine}%
}
\MakeCloseDoc{\mdJobName.TEX}
\stop
