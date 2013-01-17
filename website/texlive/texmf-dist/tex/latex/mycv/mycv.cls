%%
%% This is file `mycv.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% mycv.dtx  (with options: `mycv.cls')
%% --------------------------------------------------------
%%  Author: Andrea Ghersi
%%  Copyright 2012 Ghersi Andrea (ghanhawk@gmail.com).
%% 
%%  This work may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License version
%%  1.3c, available at 'http://www.latex-project.org/lppl'.
%% 
%%  This work has the LPPL maintenance status "maintained".
%%  The Current Maintainer of this work is Andrea Ghersi.
%% 
%%  This work consists of the files listed in the README
%%  file.
%% --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}

\RequirePackage{svn-prov}
\input{mycv_version.def}

\ProvidesClassSVN
   {$Id: mycv.cls 87 2012-05-17 00:40:11Z ghangenit $}
   [v\@versionstr][My Curriculum Vitae class]

%% ========
%% Packages
%% ========

\RequirePackage{kvoptions} % for class options with key-value format
\RequirePackage{xstring}   % for string utilities
\RequirePackage{ifthen}    % for the <\ifthenelse> command

%% =============
%% Class Options
%% =============

\DeclareBoolOption{withDec}

\DeclareDefaultOption{%
   \PassOptionsToClass{\CurrentOption}{article}}

\DeclareStringOption[english]{language}
\DeclareStringOption[Contents]{cntdir}
\DeclareStringOption[mycv_style]{style}
\DeclareStringOption[]{mdlname}
\ProcessKeyvalOptions*

%% -----------------------------------------------------------
%% The value of an option declared with <\DeclareStringOption>
%% is stored in the macro \<class (or package) name>@<option>
%% -----------------------------------------------------------

\PassOptionsToPackage{\mycv@language}{babel}
\RequirePackage{babel}

\LoadClass{article}

\def\cvcontentsdir{\mycv@cntdir}

%% ===============
%% File inclusions
%% ===============

\input{mycv_base.def}
\input{mycv_misc.def}

%% -------------------------------------
%% use custom, default or any style file
%% -------------------------------------
\ifthenelse{\equal{\mycv@style}{none}}%
   {\relax}% file style is not wanted
   {\RequirePackage{\mycv@style}}

%% ----------------------
%% use decorations or not
%% ----------------------
\ifthenelse{\boolean{mycv@withDec}}%
   {\RequirePackage{mycv_dec}}%
   {\relax}

\DeclareRobustCommand{\ifmodel}[1]{%
   \begingroup
   \def\@mdlname{#1}
   \ifx\mycv@mdlname\@mdlname
      \endgroup
      \expandafter\@firstoftwo
   \else
      \endgroup
      \expandafter\@secondoftwo
   \fi
}

%% -----------------------------------------------
%% <\ifoption{optionname}{then block}{else block}>
%% -----------------------------------------------

\DeclareRobustCommand{\ifoption}[1]{%
   \begingroup
   \ifthenelse{\boolean{mycv@#1}}
      {\endgroup\expandafter\@firstoftwo}
      {\endgroup\expandafter\@secondoftwo}%
}
\endinput
%%
%% End of file `mycv.cls'.
