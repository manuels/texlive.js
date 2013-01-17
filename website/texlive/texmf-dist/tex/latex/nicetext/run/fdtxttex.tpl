\ProvidesFile{fdtxttex.tpl}[2011/09/13 fifinddo correction template]
\RequirePackage{fifinddo}
\input{mdoccorr.cfg} 
\ResultFile{sample.tex}
\WriteProvides
\ProcessFileWith{sample.txt}{%
  \typeout{\CorrectedInputLine}%
  \WriteResult{\CorrectedInputLine}%
}
\CloseResultFile
\stop
