%%
%% This is file `omdoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% omdoc.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{omdoc}[2012/01/28 v1.0 OMDoc Documents]
\DeclareOption{showmeta}{\PassOptionsToPackage{\CurrentOption}{metakeys}}
\def\omdoc@class{article}
\DeclareOption{report}{\def\omdoc@class{report}\PassOptionsToPackage{\CurrentOption}{omdoc}}
\DeclareOption{book}{\def\omdoc@class{book}\PassOptionsToPackage{\CurrentOption}{omdoc}}
\DeclareOption{chapter}{\PassOptionsToPackage{\CurrentOption}{omdoc}}
\DeclareOption{part}{\PassOptionsToPackage{\CurrentOption}{omdoc}}
\DeclareOption{showignores}{\PassOptionsToPackage{\CurrentOption}{omdoc}}
\DeclareOption{extrefs}{\PassOptionsToPackage{\CurrentOption}{sref}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{\omdoc@class}
\RequirePackage{omdoc}
\let\orig@document=\document
\srefaddidkey{document}
\renewcommand{\document}[1][]{\metasetkeys{document}{#1}\orig@document}
\endinput
%%
%% End of file `omdoc.cls'.
