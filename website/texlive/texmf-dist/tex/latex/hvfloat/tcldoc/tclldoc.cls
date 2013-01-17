%%
%% This is file `tclldoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% tclldoc.dtx  (with options: `class')
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
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tclldoc}
         [2003/04/05 v2.40
              Tcl documentation
              class]
\DeclareOption{a5paper}{%
   \ClassError{tclldoc}{The a5paper option is not supported}\@eha
}
\DeclareOption{olddocinclude}{%
   \ClassError{tclldoc}{The olddocinclude option is not supported}\@eha
}
\DeclareOption{notrawchar}{%
  \PassOptionsToPackage{notrawchar}{tclldoc}%
}
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{article}}
\InputIfFileExists{tclldoc.cfg}
           {\typeout{*************************************^^J%
                     * Local config file tclldoc.cfg used^^J%
                     *************************************}}
           {}
\ProcessOptions\relax
\LoadClass{article}
\setlength{\textwidth}{355pt}
\addtolength\oddsidemargin{20pt}
\addtolength\evensidemargin{20pt}
\def\@tempa#1{%
   \expandafter\def \expandafter#1\expandafter{#1\TD@list}%
}
\def\TD@list{%
   \advance \itemsep \parsep
   \parsep=\z@\@plus\p@\relax
   \advance \itemsep -\parsep
   \listparindent=1em\relax
}
\@tempa\@listi
\let\@listI\@listi
\@tempa\@listii
\@tempa\@listiii
\@tempa\@listiv
\@tempa\@listv
\@tempa\@listvi
\RequirePackage[dolayout]{tclldoc}
\AtBeginDocument{\MakeShortTclverb{\|}}
\DeclareFontShape{OT1}{cmtt}{bx}{n}{<-> ssub * cmtt/m/n}{}
\DeclareFontFamily{OMS}{cmtt}{\skewchar\font'60}
\DeclareFontShape{OMS}{cmtt}{m}{n}{<-> ssub * cmsy/m/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{n}{<-> ssub * cmsy/b/n}{}
\DeclareFontShape{OT1}{cmss}{m}{it}{<->ssub*cmss/m/sl}{}
\setlength\marginparwidth{\evensidemargin}
\addtolength\marginparwidth{1in}
\addtolength\marginparwidth{-\marginparsep}
\addtolength\marginparwidth{-1cm}
\CodelineNumbered
\DisableCrossrefs
\setcounter{StandardModuleDepth}{1}
\endinput
%%
%% End of file `tclldoc.cls'.
