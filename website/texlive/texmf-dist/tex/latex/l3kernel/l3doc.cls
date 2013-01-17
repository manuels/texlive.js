%%
%% This is file `l3doc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% l3doc.dtx  (with options: `class')
%% 
%% 
%% EXPERIMENTAL CODE
%% 
%% Do not distribute this file without also distributing the
%% source files specified above.
%% 
%% Do not distribute a modified version of this file.
%% 
%% 
%% File: l3doc.dtx Copyright (C) 1990-2011 The LaTeX3 project
%%
%% It may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License (LPPL), either version 1.3c of this
%% license or (at your option) any later version.  The latest version
%% of this license is in the file
%%
%%    http://www.latex-project.org/lppl.txt
%%
%% This file is part of the "l3kernel bundle" (The Work in LPPL)
%% and all files in that bundle must be distributed together.
%%
%% The released version of this bundle is available from CTAN.
%%
%% -----------------------------------------------------------------------
%%
%% The development version of the bundle can be found at
%%
%%    http://www.latex-project.org/svnroot/experimental/trunk/
%%
%% for those people who are interested.
%%
%%%%%%%%%%%
%% NOTE: %%
%%%%%%%%%%%
%%
%%   Snapshots taken from the repository represent work in progress and may
%%   not work or may contain conflicting material!  We therefore ask
%%   people _not_ to put them into distributions, archives, etc. without
%%   prior consultation with the LaTeX3 Project.
%%
%% -----------------------------------------------------------------------
\RequirePackage{expl3,xparse,calc}
\let        \filenameOld        \ExplFileName
\let        \filedateOld        \ExplFileDate
\let     \fileversionOld        \ExplFileVersion
\let \filedescriptionOld        \ExplFileDescription
\GetIdInfo$Id: l3doc.dtx 3491 2012-03-04 06:13:18Z bruno $
          {L3 Experimental documentation class}
\ProvidesExplClass
  {\ExplFileName}{\ExplFileDate}{\ExplFileVersion}{\ExplFileDescription}
\let        \ExplFileName        \filenameOld
\let        \ExplFileDate        \filedateOld
\let        \ExplFileVersion     \fileversionOld
\let        \ExplFileDescription \filedescriptionOld
\cs_new_nopar:Npn\Team{%
  The~\LaTeX3~Project\thanks{%
  Frank~Mittelbach,~Denys~Duchier,~Chris~Rowley,~
  Rainer~Sch\"opf,~Johannes~Braams,~Michael~Downes,~
  David~Carlisle,~Alan~Jeffrey,~Morten~H\o{}gholm,~Thomas~Lotze,~
  Javier~Bezos,~Will~Robertson,~Joseph~Wright,~Bruno~Le~Floch}}
\coffin_new:N \l_doc_output_box
\coffin_new:N \l_doc_names_coffin
\coffin_new:N \l_doc_descr_coffin
\coffin_new:N \l_doc_syntax_coffin
\bool_new:N \l_doc_long_name_bool
\bool_new:N \g_doc_implementation_bool
\dim_new:N \l_doc_trial_width_dim
\tl_new:N \l_doc_macro_tl
\int_new:N \l_doc_macro_int
\int_new:N \g_doc_nested_macro_int
\prop_new:N \g_doc_missing_tests_prop
\clist_new:N \g_docinput_clist
\seq_new:N \g_doc_testfiles_seq
\seq_new:N \g_doc_functions_seq
\seq_new:N \g_doc_macros_seq
\seq_new:N \g_doc_not_tested_seq
\bool_new:N \l_doc_meta_TF_bool
\bool_new:N \l_doc_meta_pTF_bool
\bool_new:N \l_doc_meta_EXP_bool
\bool_new:N \l_doc_meta_rEXP_bool
\bool_new:N \l_doc_macro_internal_bool
\bool_new:N \l_doc_macro_aux_bool
\bool_new:N \l_doc_macro_TF_bool
\bool_new:N \l_doc_macro_pTF_bool
\bool_new:N \l_doc_macro_var_bool
\bool_new:N \g_doc_full_bool
\bool_new:N \g_doc_lmodern_bool
\bool_new:N \g_doc_checkfunc_bool
\bool_new:N \g_doc_checktest_bool
\cs_set_protected_nopar:Npn \coffin_gset_eq:NN #1#2
  {
    \coffin_if_exist:NT #1
      {
        \box_gset_eq:NN #1 #2
        \coffin_gset_eq_structure:NN #1 #2
      }
  }
\cs_generate_variant:Nn \coffin_gset_eq:NN { c , Nc , cc }
\DeclareOption{a5paper}{\@latexerr{Option not supported}{}}
\DeclareOption{full}{ \bool_set_true:N \g_doc_full_bool }
\DeclareOption{onlydoc}{ \bool_set_false:N \g_doc_full_bool }
\DeclareOption{check}{ \bool_set_true:N \g_doc_checkfunc_bool }
\DeclareOption{nocheck}{ \bool_set_false:N \g_doc_checkfunc_bool }
\DeclareOption{checktest}{ \bool_set_true:N \g_doc_checktest_bool }
\DeclareOption{nochecktest}{ \bool_set_false:N \g_doc_checktest_bool }
\DeclareOption{cm-default}{ \bool_set_false:N \g_doc_lmodern_bool }
\DeclareOption{lm-default}{ \bool_set_true:N \g_doc_lmodern_bool }
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{full,a4paper,nocheck,nochecktest,lm-default}
\InputIfFileExists{l3doc.cfg}
  {
    \typeout{*************************************^^J
             *~Local~config~file~l3doc.cfg~used   ^^J
             *************************************}
  }
  { \@input{l3doc.ltx} }
\ProcessOptions
\LoadClass{article}
\RequirePackage{doc}
\RequirePackage
  {
    array,
    alphalph,
    booktabs,
    color,
    colortbl,
    fixltx2e,
    enumitem,
    pifont,
    textcomp,
    trace,
    underscore,
    csquotes,
    fancyvrb
  }
\raggedbottom
\fvset{gobble=2}
\cs_set_eq:NN \verbatim \Verbatim
\cs_set_eq:NN \endverbatim \endVerbatim
\bool_if:NT \g_doc_lmodern_bool {
  \RequirePackage[T1]{fontenc}
  \RequirePackage{lmodern}
  \begingroup
    \ttfamily
    \DeclareFontShape{T1}{lmtt}{m}{it}{<->ec-lmtto10}{}
  \endgroup
}
\RequirePackage{hypdoc}
\let\doc@verbatim\verbatim
\let\enddoc@verbatim\endverbatim
\let\doc@@verbatim\@verbatim
\expandafter\let\csname doc@verbatim*\expandafter\endcsname
  \csname verbatim*\endcsname
\expandafter\let\csname enddoc@verbatim*\expandafter\endcsname
  \csname endverbatim*\endcsname
\expandafter\let\csname doc@@verbatim*\expandafter\endcsname
  \csname @verbatim*\endcsname
\RequirePackage{verbatim}
\AtBeginDocument{%
  \let\verbatim\doc@verbatim
  \let\endverbatim\enddoc@verbatim
  \let\@verbatim\doc@@verbatim
  \expandafter\let\csname verbatim*\expandafter\endcsname
    \csname doc@verbatim*\endcsname
  \expandafter\let\csname endverbatim*\expandafter\endcsname
    \csname enddoc@verbatim*\endcsname
  \expandafter\let\csname @verbatim*\expandafter\endcsname
    \csname doc@@verbatim*\endcsname
}
\cs_set_nopar:Npn \MakePrivateLetters {
  \char_set_catcode_letter:N \@
  \char_set_catcode_letter:N \_
  \char_set_catcode_letter:N \:
}
\setcounter{StandardModuleDepth}{1}
\@addtoreset{CodelineNo}{part}
\cs_set_nopar:Npn \theCodelineNo {
  \textcolor[gray]{0.5}{ \sffamily\tiny\arabic{CodelineNo} }
}
\setlength   \textwidth      { 385pt }
\addtolength \marginparwidth {  30pt }
\addtolength \oddsidemargin  {  20pt }
\addtolength \evensidemargin {  20pt }
\cs_set_eq:NN \@@oldlist\list
\cs_set_nopar:Npn \list#1#2{\@@oldlist{#1}{#2\listparindent\z@}}
\setlength \parindent  { 2em }
\setlength \itemindent { 0pt }
\setlength \parskip    { 0pt plus 3pt minus 0pt }
\cs_set_nopar:Npn \l@section #1#2 {
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{1.0em \@plus\p@}
    \setlength\@tempdima{2.5em}  % was 1.5em
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}
\cs_set_nopar:Npn\l@subsection{\@dottedtocline{2}{2.5em}{2.3em}}  % #2 = 1.5em
\AtBeginDocument {
  \MakeShortVerb \"
  \MakeShortVerb \|
}
\providecommand*\eTeX{
  \if b\expandafter\@car\f@series\@nil\boldmath\fi
  $\m@th\varepsilon$-\TeX
}
\providecommand*\IniTeX{Ini\TeX}
\providecommand*\Lua{Lua}
\providecommand*\LuaTeX{\Lua\TeX}
\providecommand*\pdfTeX{pdf\TeX}
\RequirePackage{graphicx}
\cs_if_free:NT \XeTeX {
  \cs_new_protected_nopar:Npn \XeTeX
    {X\kern-.125em\lower.5ex\hbox{\reflectbox{E}}\kern-.1667em\TeX}
}
\cs_set_nopar:Npn \cmd #1 { \cs{\expandafter\cmd@to@cs\string#1} }
\cs_set_nopar:Npn \cmd@to@cs #1#2 { \char\number`#2\relax }
\DeclareRobustCommand \cs [1] { \texttt { \char`\\ #1 } }
\providecommand\marg[1]{ \texttt{\char`\{} \meta{#1} \texttt{\char`\}} }
\providecommand\oarg[1]{ \texttt[ \meta{#1} \texttt] }
\providecommand\parg[1]{ \texttt( \meta{#1} \texttt) }
\cs_set_eq:NN \file \nolinkurl
\DeclareRobustCommand \env {\texttt}
\DeclareRobustCommand \pkg {\textsf}
\DeclareRobustCommand \cls {\textsf}
\newenvironment{texnote}{
  \endgraf
  \vspace{3mm}
  \small\textbf{\TeX~hackers~note:}
}{
  \vspace{3mm}
}
\newcommand\tn[1]{
  \texttt { \char`\\ #1 }
  \index{TeX~and~LaTeX2e~commands\actualchar
          \string\TeX{}~and~\string\LaTeXe{}~commands:\levelchar
          #1\actualchar{\string\ttfamily\string\bslash{}#1}}}
\cs_new:Npn \doc_implementation: {
  \cs_set:Npn \variable {\macro[var]}
  \cs_set_eq:NN \endvariable \endmacro
}
\cs_new:Npn \doc_docu: {
  \cs_set_eq:NN \variable \variabledoc
  \cs_set_eq:NN \endvariable \endvariabledoc
}
\AtEndOfPackage{\doc_docu:}
\newenvironment{documentation}{\doc_docu:}{}
\newenvironment{implementation}{\doc_implementation:}{}
\newcommand\EnableDocumentation{%
  \renewenvironment{documentation}{\doc_docu:}{}%
}
\newcommand\EnableImplementation{%
  \renewenvironment{implementation}{\doc_implementation:}{}%
}
\newcommand\DisableDocumentation{%
  \cs_set_eq:NN \documentation \comment
  \cs_set_eq:NN \enddocumentation \endcomment
}
\newcommand\DisableImplementation{%
  \cs_set_eq:NN \implementation \comment
  \cs_set_eq:NN \endimplementation \endcomment
}
\newenvironment{arguments}{
  \enumerate[
    nolistsep,
    label=\texttt{\#\arabic*}~:,
    labelsep=*,
  ]
}{
  \endenumerate
}
\keys_define:nn { l3doc/function }
  {
    TF .code:n =
      {
        \bool_gset_true:N \l_doc_meta_TF_bool
      } ,
    EXP .code:n =
      {
        \bool_gset_true:N \l_doc_meta_EXP_bool
        \bool_gset_false:N \l_doc_meta_rEXP_bool
      } ,
    rEXP .code:n =
      {
        \bool_gset_false:N \l_doc_meta_EXP_bool
        \bool_gset_true:N \l_doc_meta_rEXP_bool
      } ,
    pTF .code:n =
      {
        \bool_gset_true:N \l_doc_meta_pTF_bool
        \bool_gset_true:N \l_doc_meta_TF_bool
        \bool_gset_true:N \l_doc_meta_EXP_bool
      } ,
    added .tl_set:N = \l_doc_date_added_tl ,
    updated .tl_set:N = \l_doc_date_updated_tl ,
  }
\char_set_catcode_active:N \<
\DeclareDocumentEnvironment {function} { O{} } {

  \par\bigskip\noindent
  \phantomsection

  \coffin_clear:N \l_doc_descr_coffin
  \coffin_clear:N \l_doc_syntax_coffin
  \coffin_clear:N \l_doc_names_coffin

  \bool_set_false:N \l_doc_meta_TF_bool
  \bool_set_false:N \l_doc_meta_pTF_bool
  \bool_set_false:N \l_doc_meta_EXP_bool
  \bool_set_false:N \l_doc_meta_rEXP_bool

  \keys_set:nn { l3doc/function } {#1}

  \char_set_active_eq:NN < \doc_open_meta:w

  \group_begin:
    \MakePrivateLetters
    \char_set_catcode_other:N \|
    \char_set_catcode_space:N \~
    \char_set_catcode_ignore:N \ % space
    \char_set_catcode_ignore:N \^^M
    \char_set_catcode_ignore:N \^^I

    \function_aux:n
  }
  {
    \vcoffin_set_end:
    \bool_if:NTF \l_doc_long_name_bool
      {
        \coffin_join:NnnNnnnn
          \l_doc_output_box {hc} {vc}
          \l_doc_syntax_coffin {l} {T}
          {0pt} {0pt}
        \coffin_join:NnnNnnnn
          \l_doc_output_box {l} {t}
          \l_doc_names_coffin  {r} {t}
          {-\marginparsep} {0pt}
        \coffin_join:NnnNnnnn
          \l_doc_output_box {l} {b}
          \l_doc_descr_coffin  {l} {t}
          {0.75\marginparwidth + \marginparsep} {-\medskipamount}

        \coffin_typeset:Nnnnn \l_doc_output_box {\l_doc_descr_coffin-l} {\l_doc_descr_coffin-t} {0pt} {0pt}
      }
      {
        \coffin_join:NnnNnnnn
          \l_doc_output_box {hc} {vc}
          \l_doc_syntax_coffin {l} {t}
          {0pt} {0pt}
        \coffin_join:NnnNnnnn
          \l_doc_output_box {l} {b}
          \l_doc_descr_coffin  {l} {t}
          {0pt} {-\medskipamount}
        \coffin_join:NnnNnnnn
          \l_doc_output_box {l} {t}
          \l_doc_names_coffin  {r} {t}
          {-\marginparsep} {0pt}

        \coffin_typeset:Nnnnn
          \l_doc_output_box {\l_doc_syntax_coffin-l} {\l_doc_syntax_coffin-T}
          {0pt} {0pt}
      }
    \par
    \allowbreak
  }
\char_set_catcode_other:N \<
\cs_set_eq:NN \variabledoc \function
\cs_set_eq:NN \endvariabledoc \endfunction
\cs_set_nopar:Npn \function_aux:n #1 {

  \group_end:

  \tl_set:Nn \l_doc_function_input_tl {#1}

  \dim_zero:N \l_doc_trial_width_dim
  \hcoffin_set:Nn \l_doc_names_coffin { \function_typeset:n {#1} }
  \dim_set:Nn \l_doc_trial_width_dim { \box_wd:N \l_doc_names_coffin }

  \bool_set:Nn \l_doc_long_name_bool
    { \dim_compare_p:nNn \l_doc_trial_width_dim > \marginparwidth }

  \vcoffin_set:Nnw \l_doc_descr_coffin {\textwidth}
    \noindent\ignorespaces
}
\cs_gset_nopar:Npn \function_typeset:n #1 %^^A todo: use "\cs_new:Npn" here
  {
    \tl_gclear:N \g_doc_macro_tl

    % populate "\l_doc_functions_block_prop" with info on the functions present:
    \clist_map_function:nN {#1} \doc_parse_functions:n

    \small\ttfamily
    \begin{tabular}{ @{} l @{} r @{} }
      \toprule
      \prop_map_function:NN \l_doc_functions_block_prop \doc_typeset_functions:nn
      \doc_typeset_dates:
      \bottomrule
    \end{tabular}
    \normalfont\normalsize
  }
\prop_new:N \l_doc_functions_block_prop
\cs_generate_variant:Nn \prop_put:Nnn {Nxx}
\cs_new:Nn \doc_parse_functions:n
  {
    \exp_args:Nxx \tl_if_head_eq_charcode:nNTF { \token_to_str:N #1 } {\cs_to_str:N \\}
      {
        \tl_gset_eq:NN \l_doc_function_name_prefix_tl \@backslashchar
        % for the weird functions named "\::N" and so on:
\exp_args:Nx \tl_if_head_eq_charcode:nNTF { \cs_to_str:N #1 } { : }
{
  % again, no variants:
\prop_put:Nxx \l_doc_functions_block_prop { \cs_to_str:N #1 } { {-1} {} }
}
{
  % finally, for regular old csnames:
\exp_args:NNf \prop_get:NnNTF
  \l_doc_functions_block_prop
  { \cs_get_function_name:N #1 } \l_doc_tmp_tl
{
\prop_put:Nxx \l_doc_functions_block_prop
{ \cs_get_function_name:N #1 }
{
  \l_doc_tmp_tl ,
  {\cs_get_arg_count_from_signature:N #1}
  {\cs_get_function_signature:N #1}
}
}
{
\prop_put:Nxx \l_doc_functions_block_prop
{ \cs_get_function_name:N #1 }
{
  {\cs_get_arg_count_from_signature:N #1}
  {\cs_get_function_signature:N #1}
}
}
}
      }
    % for keys and things that aren't actually csnames:
      {
        % for now don't bother splitting into variants:
        \tl_gclear:N \l_doc_function_name_prefix_tl
\prop_put:Nxx \l_doc_functions_block_prop { #1 } { {-1} {} }
      }
  }

\cs_new:Nn \doc_typeset_functions:nn
  {
    \clist_gset:Nn \l_doc_variants_clist {#2}
    \clist_gpop:NN \l_doc_variants_clist \l_doc_tmp_tl
    \exp_args:Nc \doc_typeset_functions_aux:N
      {
         #1
         \int_compare:nT { \exp_after:wN \use_i:nn \l_doc_tmp_tl > -1 } {:}
         \int_compare:nT { \exp_after:wN \use_i:nn \l_doc_tmp_tl >  0 }
           { \exp_after:wN \use_ii:nn \l_doc_tmp_tl }
      }
    \\
  }

\cs_new_nopar:Nn \doc_typeset_functions_aux:N
{
  \bool_if:NT \l_doc_meta_pTF_bool {
    \tl_set:Nx \l_doc_pTF_name_tl { \doc_predicate_from_base:N #1 }
    \doc_special_main_index:o { \tl_to_str:N \l_doc_pTF_name_tl }
    \seq_gput_right:Nx \g_doc_functions_seq { \l_doc_function_name_prefix_tl \l_doc_pTF_name_tl }
  }

  \bool_if:NTF \l_doc_meta_TF_bool {
    \doc_special_main_index:o { \token_to_str:N #1 TF }
    \seq_gput_right:Nx \g_doc_functions_seq { \token_to_str:N #1 TF }
  }{
    \doc_special_main_index:o { \token_to_str:N #1 }
    \seq_gput_right:Nx \g_doc_functions_seq { \tl_to_str:n {#1}  }
  }

  \bool_if:NTF \l_doc_meta_pTF_bool {

    \bool_gset_false:N \l_doc_meta_TF_bool
    \exp_args:Nc \doc_typeset_function_block:N { \l_doc_pTF_name_tl }
    \bool_gset_true:N \l_doc_meta_TF_bool

    \\
    \doc_typeset_function_block:N #1

  }{
    \exp_args:Nx \tl_if_head_eq_charcode:nNTF { \exp_after:wN \use_none:n \token_to_str:N #1 } {:}
      { \doc_show_macro_unusual:N #1 }
      { \doc_typeset_function_block:N #1 }
  }
}
\cs_set_nopar:Nn \doc_typeset_function_block:N {
  \tl_gset:Nx \l_doc_function_name_tl { \cs_get_function_name:N #1 }
  \tl_gset:Nx \l_doc_function_sig_tl { \cs_get_function_signature:N #1 }
  \tl_gset:Nx \g_doc_macro_tl { \l_doc_function_name_prefix_tl \l_doc_function_name_tl }

  \doc_typeset_function_basename:N #1
  \bool_if:NT \l_doc_meta_TF_bool { \doc_typeset_TF: }
  \doc_typeset_expandability:
  \clist_if_empty:NF \l_doc_variants_clist { \doc_typeset_variants: }
  \bool_if:NT \g_doc_full_bool { \doc_label_function: }

}
\cs_set:Nn \doc_typeset_function_basename:N
  {
    \g_doc_macro_tl
    \int_compare:nT { \cs_get_arg_count_from_signature:N #1 >  -1 } { : }
    \int_compare:nT { \cs_get_arg_count_from_signature:N #1 >   0 }
      { \l_doc_function_sig_tl }
  }
\cs_set:Nn \doc_typeset_expandability:
  {
    &
    \bool_if:NT \l_doc_meta_EXP_bool {
      \hspace{\tabcolsep}
      \hyperlink{expstar} {$\star$}
    }
    \bool_if:NT \l_doc_meta_rEXP_bool {
      \hspace{\tabcolsep}
      \hyperlink{rexpstar} {\ding{73}} % hollow star
    }
  }
\cs_set:Nn \doc_typeset_variants:
  {
    \\
    \doc_typeset_aux:n \g_doc_macro_tl :
    \int_compare:nTF { \clist_length:N \l_doc_variants_clist == 1 }
      { \exp_after:wN \use_ii:nn \l_doc_variants_clist }
      {
        \textrm(
          \clist_pop:NN \l_doc_variants_clist \l_doc_tmp_tl
          \exp_after:wN \use_ii:nn \l_doc_tmp_tl
          \clist_map_inline:Nn \l_doc_variants_clist {\textrm| \use_ii:nn ##1}
        \textrm)
      }
      \bool_if:NT \l_doc_meta_TF_bool { \doc_typeset_TF: }
    &
    \bool_if:NT \l_doc_meta_EXP_bool {
      \hspace{\tabcolsep}
      \hyperlink{expstar} {$\star$}
    }
    \bool_if:NT \l_doc_meta_rEXP_bool {
      \hspace{\tabcolsep}
      \hyperlink{rexpstar} {\ding{73}} % hollow star
    }
  }
\cs_set:Nn \doc_label_function:
  {
    \exp_args:NNf \tl_replace_all:Nnn \g_doc_macro_tl {\token_to_str:N _} {/}
    \exp_args:NNf \tl_replace_all:Nnn \g_doc_macro_tl {\@backslashchar} {}
    \exp_args:Nx \label
      {
        doc/function//\g_doc_macro_tl
        \tl_if_empty:NF \l_doc_function_sig_tl { : \l_doc_function_sig_tl }
      }
  }
\cs_set_nopar:Nn \doc_show_macro_unusual:N {
  \tl_gset:Nx \g_doc_macro_tl { \token_to_str:N #1}
  \token_to_str:N #1 &

  \exp_args:NNf \tl_replace_all:Nnn \g_doc_macro_tl {\token_to_str:N _} {/}
  \exp_args:NNf \tl_replace_all:Nnn \g_doc_macro_tl {\@backslashchar} {}
  \bool_if:NT \g_doc_full_bool {
    \exp_args:Nx \label { doc/function//\g_doc_macro_tl }
  }
}
\cs_set:Nn \doc_typeset_dates:
  {
    \bool_if:nF { \tl_if_empty_p:N \l_doc_date_added_tl &&
                  \tl_if_empty_p:N \l_doc_date_updated_tl }
      { \midrule }

    \tl_if_empty:NF \l_doc_date_added_tl
      {
        \multicolumn{2}{@{}r@{}}
          { \scriptsize New:\,\l_doc_date_added_tl } \\
      }

    \tl_if_empty:NF \l_doc_date_updated_tl
      {
        \multicolumn{2}{@{}r@{}}
          { \scriptsize Updated:\,\l_doc_date_updated_tl } \\
      }
  }
\newenvironment{syntax}{
  \small\ttfamily
  \bool_if:NTF \l_doc_long_name_bool
    {
      \hcoffin_set:Nw \l_doc_syntax_coffin
      \arrayrulecolor{white}
      \begin{tabular}{@{}l@{}}
      \toprule
      \begin{minipage}
        { \textwidth+0.75\marginparwidth-\l_doc_trial_width_dim }
    }
    {
      \hcoffin_set:Nw \l_doc_syntax_coffin
      \arrayrulecolor{white}
      \begin{tabular}{@{}l@{}}
      \toprule
      \begin{minipage}{ \textwidth }
    }
  \raggedright
  \obeyspaces\obeylines
}{
  \end{minipage}
  \end{tabular}
  \arrayrulecolor{black}
  \hcoffin_set_end:
  \coffin_gset_eq:NN \l_doc_syntax_coffin \l_doc_syntax_coffin
  \ignorespacesafterend
}
\cs_new:Npn \doc_ensuremath_sb:n #1
  {
    \ensuremath{\sb{#1}}
  }
\cs_set_eq:NN \doc_meta:n \meta
\cs_set:Npn \meta
  {
    \group_begin:
      \char_set_active_eq:NN _ \doc_ensuremath_sb:n
      \doc_close_meta:n
  }
\cs_new:Npn \doc_open_meta:w
  {
    \group_begin:
      \char_set_active_eq:NN _ \doc_ensuremath_sb:n
      \doc_close_meta:w
  }
\cs_new:Npn \Arg
  {
    \texttt{ \char`\{ }
    \group_begin:
      \char_set_active_eq:NN _ \doc_ensuremath_sb:n
      \doc_close_Arg:n
  }
\cs_new_nopar:Npn \doc_close_meta:n #1  { \doc_meta:n {#1} \group_end: }
\cs_new_nopar:Npn \doc_close_meta:w #1> { \doc_meta:n {#1} \group_end: }
\cs_new_nopar:Npn \doc_close_Arg:n #1 {
  \doc_meta:n {#1}
  \group_end:
  \texttt{ \char`\} }
}
\keys_define:nn { l3doc/macro }
  {
    aux .code:n =
      { \bool_set_true:N \l_doc_macro_aux_bool } ,
    internal .code:n =
      { \bool_set_true:N \l_doc_macro_internal_bool } ,
    var .code:n =
      { \bool_set_true:N \l_doc_macro_var_bool } ,
    TF .code:n =
      { \bool_set_true:N \l_doc_macro_TF_bool } ,
    pTF .code:n =
      { \bool_set_true:N \l_doc_macro_pTF_bool } ,
  }
\renewcommand \macro [1][] {

  \int_compare:nNnTF \currentgrouplevel=2
    { \int_gzero:N \g_doc_nested_macro_int }
    { \int_incr:N  \g_doc_nested_macro_int }

  \bool_gset_false:N \l_doc_macro_aux_bool
  \bool_gset_false:N \l_doc_macro_internal_bool
  \bool_gset_false:N \l_doc_macro_TF_bool
  \bool_gset_false:N \l_doc_macro_pTF_bool
  \bool_gset_false:N \l_doc_macro_var_bool
  \bool_gset_false:N \l_doc_tested_bool

  \cs_set_eq:NN \doc_macroname_prefix:n \use:n
  \cs_set_eq:NN \doc_macroname_suffix: \c_empty_tl

  \keys_set:nn { l3doc/macro } {#1}

  \cs_set_eq:NN \testfile \doc_print_testfile:n

  \peek_meaning_ignore_spaces:NTF \c_group_begin_token
    {
      \group_begin:
        \MakePrivateLetters
        \char_set_catcode_letter:N \\
        \char_set_catcode_ignore:N \ % space
        \char_set_catcode_ignore:N \^^M
        \char_set_catcode_ignore:N \^^I
        \doc_macro_aux:n
    }
    {
      \doc_macro_verbatim:w
    }
}
\NewDocumentCommand {\doc_macro_verbatim:w} {v}
  {
    \group_begin: % pretty useless
    \doc_macro_aux:n {#1}
  }
\keys_define:nn { l3doc/macro }
  {
    unknown .code:n = { \use:c{doc_macro_opt_#1:} }
  }
\clist_new:N \l_doc_macro_input_clist
\cs_new_nopar:Npn \doc_macro_aux:n #1 {
  \group_end:
  \clist_set:Nn \l_doc_macro_input_clist {#1}
  \bool_if:NTF \l_doc_macro_pTF_bool
  {
    \clist_map_inline:Nn \l_doc_macro_input_clist
      {
        \exp_args:Nx \doc_macro_single:n { \doc_predicate_from_base:w ##1 \q_nil }
      }
    \bool_set_true:N \l_doc_macro_TF_bool
    \clist_map_function:NN \l_doc_macro_input_clist \doc_macro_single:n
    \bool_set_false:N \l_doc_macro_TF_bool
  }
  { \clist_map_function:NN \l_doc_macro_input_clist \doc_macro_single:n }
}
\cs_set:Nn \doc_predicate_from_base:N
  {
    \cs_get_function_name:N #1 _p: \cs_get_function_signature:N #1
  }
\cs_set:Npn \doc_predicate_from_base:w #1 : #2 \q_nil
  {
    #1 _p: #2
  }
\cs_set_nopar:Npn \doc_macro_single:n #1 {
  \int_incr:N \l_doc_macro_int
  \tl_set:Nx \saved@macroname { \token_to_str:N #1 }
  \topsep\MacroTopsep
  \trivlist
  \cs_set_nopar:Npn \makelabel ##1 { \llap{##1} }
  \if@inlabel
    \cs_set_eq:NN \@tempa \@empty
    \count@ \macro@cnt
    \loop \ifnum\count@>\z@
      \cs_set_nopar:Npx \@tempa{\@tempa\hbox{\strut}}
      \advance\count@\m@ne
    \repeat
    \cs_set_nopar:Npx \makelabel ##1 {
      \llap{\vtop to\baselineskip {\@tempa\hbox{##1}\vss}}
    }
    \advance \macro@cnt \@ne
  \else
    \macro@cnt \@ne
  \fi

  \bool_if:NT \l_doc_macro_aux_bool {
    \cs_set_eq:NN \doc_macroname_prefix:n \doc_typeset_aux:n
  }
  \bool_if:NT \l_doc_macro_TF_bool {
    \cs_set_eq:NN \doc_macroname_suffix: \doc_typeset_TF:
  }

  \bool_if:NF \l_doc_macro_aux_bool {
    \tl_gset:Nx \l_doc_macro_tl { \tl_to_str:n {#1} }
    \exp_args:NNf \tl_greplace_all:Nnn \l_doc_macro_tl {\token_to_str:N _} {/}
    \exp_args:NNf \tl_greplace_all:Nnn \l_doc_macro_tl {\@backslashchar} {}
  }

  \use:x {
    \exp_not:N \item [ \exp_not:N \doc_print_macroname:n {
      \tl_to_str:n {#1}
    }]
  }
  \global\advance \c@CodelineNo \@ne

  \bool_if:NF \l_doc_macro_aux_bool {
    \bool_if:NTF \l_doc_macro_TF_bool {
      \seq_gput_right:Nx \g_doc_macros_seq { \tl_to_str:n { #1 TF } }
      \seq_gput_right:Nx \g_doc_macros_seq { \tl_to_str:n { #1 T  } }
      \seq_gput_right:Nx \g_doc_macros_seq { \tl_to_str:n { #1 F  } }
    }{
      \seq_gput_right:Nx \g_doc_macros_seq { \tl_to_str:n {#1} }
    }
  }
  \bool_if:NTF \l_doc_macro_TF_bool {
    \SpecialMainIndex{#1 TF}\nobreak
    \DoNotIndex{#1 TF}
  }{
    \SpecialMainIndex{#1}\nobreak
    \DoNotIndex{#1}
  }

  \global\advance \c@CodelineNo \m@ne
  \ignorespaces
}
\tl_clear:N \l_doc_macro_tl
\cs_set_nopar:Npn \doc_print_macroname:n #1 {
  \strut
  \int_compare:nTF { \tl_length:n {#1} <= 28 }
    { \MacroFont } { \MacroLongFont }

  % INEFFICIENT: (!)
  \exp_args:NNx \seq_if_in:NnTF \g_doc_functions_seq
  { #1 \bool_if:NT \l_doc_macro_TF_bool { \tl_to_str:n {TF} } }
  {
    \hyperref [doc/function//\l_doc_macro_tl]
  }
  { \use:n }
  {
    \doc_macroname_prefix:n {#1} \doc_macroname_suffix: \ % space!
  }
}
\providecommand \MacroLongFont {
  \fontfamily{lmtt}\fontseries{lc}\small
}
\cs_set_nopar:Npn \doc_typeset_TF: {
  \hyperlink{explTF}{%
    \color{black}%
    \itshape TF%
    \makebox[0pt][r]{%
      \color{red}
      \underline { \phantom{\itshape TF} \kern-0.1em }
    }
  }
}
\cs_set_nopar:Npn \doc_typeset_aux:n #1 {
  {\color[gray]{0.7} #1}
}
\DeclareDocumentCommand \doc_print_testfile:n {m} {
  \bool_set_true:N \l_doc_tested_bool
  \tl_if_eq:nnF {#1} {*} {
    \seq_if_in:NnF \g_doc_testfiles_seq {#1}
    {
      \par{\footnotesize(\textit{
        The~ test~ suite~ for~ this~ command,~ and~ others~ in~ this~ file,~ is~ \textsf{#1}}.
      )\par}
      \seq_gput_right:Nn \g_doc_testfiles_seq {#1}
    }
  }
}
\DeclareDocumentCommand \TestFiles {m} {
  \par
  {\itshape
    The~ following~ test~ files~ are~ used~ for~ this~ code:~ \textsf{#1}.
  }
  \par\ignorespaces
}
\DeclareDocumentCommand \UnitTested {} {
  \testfile*
}
\cs_generate_variant:Nn \prop_gput:Nnn {NVx}
\DeclareDocumentCommand \TestMissing {m} {
  \prop_if_in:NVTF \g_doc_missing_tests_prop \l_doc_macro_input_clist
  {
    \prop_get:NVN \g_doc_missing_tests_prop \l_doc_macro_input_clist \l_tmpa_tl
    \prop_gput:NVx \g_doc_missing_tests_prop \l_doc_macro_input_clist
    {
      *~ \l_tmpa_tl
      ^^J \exp_not:n {\space\space\space\space\space\space}
      *~ #1
    }
  }
  { \prop_gput:NVn \g_doc_missing_tests_prop \l_doc_macro_input_clist {#1} }
}
\cs_set:Nn \doc_macro_wrap:n
  {
    #1 \bool_if:NT \l_doc_macro_TF_bool {TF}
  }
\cs_set:Nn \doc_texttt_comma:n {\,,~\texttt{#1}}
\cs_set:Npn \endmacro {
  \int_compare:nT {\g_doc_nested_macro_int<1}
  {
  \par\nobreak\noindent{\footnotesize(\emph{
    End~ definition~ for~
    \prg_case_int:nnn { \clist_length:N \l_doc_macro_input_clist }
    {
      {1} { \texttt{ \doc_macro_wrap:n { \clist_use:N \l_doc_macro_input_clist } }. }
      {2}
      {
        \tl_set:Nx \l_clist_first_tl { \clist_item:Nn \l_doc_macro_input_clist {0} }
        \tl_set:Nx \l_clist_last_tl { \clist_item:Nn \l_doc_macro_input_clist {1} }
        \texttt{\doc_macro_wrap:n\l_clist_first_tl}\,~ and~ \texttt{\doc_macro_wrap:n\l_clist_last_tl}\,.
      }
      {3}
      {
        \tl_set:Nx \l_clist_first_tl { \clist_item:Nn \l_doc_macro_input_clist {0} }
        \tl_set:Nx \l_clist_mid_tl   { \clist_item:Nn \l_doc_macro_input_clist {1} }
        \tl_set:Nx \l_clist_last_tl  { \clist_item:Nn \l_doc_macro_input_clist {2} }
        \texttt{\doc_macro_wrap:n\l_clist_first_tl}\,,~
        \texttt{\doc_macro_wrap:n\l_clist_mid_tl}\,,~
        and~ \texttt{\doc_macro_wrap:n\l_clist_last_tl}\,.
      }
    }
    {
      \tl_set:Nx \l_clist_first_tl { \clist_item:Nn \l_doc_macro_input_clist {0} }
      \texttt{\doc_macro_wrap:n\l_clist_first_tl}\,~and~others.
    }
    \bool_if:nT {
      !\l_doc_macro_aux_bool &&
      !\l_doc_macro_internal_bool &&
      \int_compare_p:n {\g_doc_nested_macro_int<1}
    }
    {
        \int_compare:nNnTF \l_doc_macro_int=1 {~This~} {~These~}
        \bool_if:NTF \l_doc_macro_var_bool{variable}{function}
        \int_compare:nNnTF \l_doc_macro_int=1 {~is~}{s~are~}
        documented~on~page~
        \exp_args:Nx\pageref{doc/function//\l_doc_macro_tl}.
    }
  })\par}
  }
  \bool_if:nT
  { \g_doc_checktest_bool &&
    !( \l_doc_macro_aux_bool || \l_doc_macro_var_bool ) &&
    !\l_doc_tested_bool
  }
  {
    \seq_gput_right:Nx \g_doc_not_tested_seq
    {
      \l_doc_macro_input_clist
      \bool_if:NT \l_doc_macro_pTF_bool {~(pTF)}
      \bool_if:NT \l_doc_macro_TF_bool {~(TF)}
    }
  }
}
\newcommand*{\DescribeOption}{
 \leavevmode
 \@bsphack
 \begingroup
   \MakePrivateLetters
   \Describe@Option
}
\newcommand*{\Describe@Option}[1]{
 \endgroup
 \marginpar{
   \raggedleft
   \PrintDescribeEnv{#1}
 }
 \SpecialOptionIndex{#1}
 \@esphack
 \ignorespaces
}
\newcommand*{\SpecialOptionIndex}[1]{
 \@bsphack
 \begingroup
   \HD@target
   \let\HDorg@encapchar\encapchar
   \edef\encapchar usage{
     \HDorg@encapchar hdclindex{\the\c@HD@hypercount}{usage}
   }
   \index{
     #1\actualchar{\protect\ttfamily#1}~(option)
     \encapchar usage
   }
   \index{
     options:\levelchar#1\actualchar{\protect\ttfamily#1}
     \encapchar usage
   }
 \endgroup
 \@esphack
}
\font\manual=manfnt
\cs_set_nopar:Npn \dbend { {\manual\char127} }
\newenvironment {danger} {
  \begin{trivlist}\item[]\noindent
  \begingroup\hangindent=2pc\hangafter=-2
  \cs_set_nopar:Npn \par{\endgraf\endgroup}
  \hbox to0pt{\hskip-\hangindent\dbend\hfill}\ignorespaces
}{
  \par\end{trivlist}
}
\newenvironment {ddanger} {
  \begin{trivlist}\item[]\noindent
  \begingroup\hangindent=3.5pc\hangafter=-2
  \cs_set_nopar:Npn \par{\endgraf\endgroup}
  \hbox to0pt{\hskip-\hangindent\dbend\kern2pt\dbend\hfill}\ignorespaces
}{
  \par\end{trivlist}
}
\newenvironment{TemplateInterfaceDescription}[1]
  {\subsection{The~object~type~`#1'}%
   \begingroup
   \@beginparpenalty\@M
   \description
   \def\TemplateArgument##1##2{\item[Arg:~##1]##2\par}%
   \def\TemplateSemantics{\enddescription\endgroup
       \subsubsection*{Semantics:}}%
  }
  {\par\bigskip}
\newenvironment{TemplateDescription}[2]
  {\subsection{The~template~`#2'~(object~type~#1)}%
   \subsubsection*{Attributes:}%
   \begingroup
   \@beginparpenalty\@M
   \description
   \def\TemplateKey##1##2##3##4{\item[##1~(##2)]##3%
     \ifx\TemplateKey##4\TemplateKey\else
         \hfill\penalty500\hbox{}\hfill Default:~##4%
         \nobreak\hskip-\parfillskip\hskip0pt\relax
     \fi
     \par}%
   \def\TemplateSemantics{\enddescription\endgroup
       \subsubsection*{Semantics~\&~Comments:}}%
  }
  {\par\bigskip}
\newenvironment{InstanceDescription}[4][xxxxxxxxxxxxxxx]
  {\subsubsection{The~instance~`#3'~(template~#2/#4)}%
   \subsubsection*{Attribute~values:}%
   \begingroup
   \@beginparpenalty\@M
   \def\InstanceKey##1##2{\>\textbf{##1}\>##2\\}%
   \def\InstanceSemantics{\endtabbing\endgroup
       \vskip-30pt\vskip0pt
       \subsubsection*{Layout~description~\&~Comments:}}%
   \tabbing
   xxxx\=#1\=\kill
  }
  {\par\bigskip}
\cs_set_nopar:Npn \AlsoImplementation {
  \bool_set_true:N \g_doc_implementation_bool
  \cs_set:Npn \StopEventually ##1 {
    \@bsphack
    \cs_gset_nopar:Npn \Finale { ##1 \check@checksum }
    \init@checksum
    \@esphack
  }
}
\AlsoImplementation
\cs_set_nopar:Npn \OnlyDescription {
  \@bsphack
  \bool_set_false:N \g_doc_implementation_bool
  \cs_set:Npn \StopEventually ##1 { ##1 \endinput }
  \@esphack
}
\cs_set_eq:NN \Finale \relax
\cs_set_nopar:Npn \partname{File}
\cs_set:Npn \DocInput #1 {
  \clist_map_inline:nn {#1} {
    \clist_put_right:Nn \g_docinput_clist {##1}
    \MakePercentIgnore
    \input{##1}
    \MakePercentComment
  }
}
\cs_set:Npn \DocInputAgain {
  \clist_map_inline:Nn \g_docinput_clist {
    \MakePercentIgnore
    \input{##1}
    \MakePercentComment
  }
}
\cs_set_nopar:Npn \partname{File}
\newcommand*{\DocInclude}[1]{%
  \relax\clearpage
  \docincludeaux
  \IfFileExists{#1.fdd}{
    \cs_set_nopar:Npn \currentfile{#1.fdd}
  }{
    \cs_set_nopar:Npn \currentfile{#1.dtx}
  }
  \ifnum\@auxout=\@partaux
    \@latexerr{\string\include\space cannot~be~nested}\@eha
  \else
    \@docinclude #1
  \fi
}
\cs_set_nopar:Npn \@docinclude #1 {
  \clearpage
  \immediate\write\@mainaux{\string\@input{#1.aux}}
  \@tempswatrue
  \if@partsw
    \@tempswafalse
    \cs_set_nopar:Npx \@tempb{#1}
    \@for\@tempa:=\@partlist\do{
      \ifx\@tempa\@tempb\@tempswatrue\fi
    }
  \fi
  \if@tempswa
    \cs_set_eq:NN \@auxout\@partaux
    \immediate\openout\@partaux #1.aux
    \immediate\write\@partaux{\relax}
    \cs_set_eq:NN \@ltxdoc@PrintIndex\PrintIndex
    \cs_set_eq:NN \PrintIndex\relax
    \cs_set_eq:NN \@ltxdoc@PrintChanges\PrintChanges
    \cs_set_eq:NN \PrintChanges\relax
    \cs_set_eq:NN \@ltxdoc@theglossary\theglossary
    \cs_set_eq:NN \@ltxdoc@endtheglossary\endtheglossary
    \part{\currentfile}
    {
      \cs_set_eq:NN \ttfamily\relax
      \cs_gset_nopar:Npx \filekey{\filekey, \thepart={\ttfamily\currentfile}}
    }
    \DocInput{\currentfile}
    \cs_set_eq:NN \PrintIndex\@ltxdoc@PrintIndex
    \cs_set_eq:NN \PrintChanges\@ltxdoc@PrintChanges
    \cs_set_eq:NN \theglossary\@ltxdoc@theglossary
    \cs_set_eq:NN \endtheglossary\@ltxdoc@endtheglossary
    \clearpage
    \@writeckpt{#1}
    \immediate\closeout\@partaux
  \else
    \@nameuse{cp@#1}
  \fi
  \cs_set_eq:NN \@auxout\@mainaux
}
\cs_gset_nopar:Npn \codeline@wrindex #1 {
  \immediate\write\@indexfile {
    \string\indexentry{#1}
    {\filesep\number\c@CodelineNo}
  }
}
\cs_set_eq:NN \filesep \@empty
\cs_set_nopar:Npn \docincludeaux {
  \cs_set_nopar:Npn \thepart {\alphalph{part}}
  \cs_set_nopar:Npn \filesep {\thepart-}
  \cs_set_eq:NN \filekey\@gobble
  \g@addto@macro\index@prologue{
    \cs_gset_nopar:Npn\@oddfoot{
      \parbox{\textwidth}{
        \strut\footnotesize
        \raggedright{\bfseries File~Key:}~\filekey
      }
    }
    \cs_set_eq:NN \@evenfoot\@oddfoot
  }
  \cs_gset_eq:NN \docincludeaux\relax
  \cs_gset_nopar:Npn\@oddfoot{
    \expandafter\ifx\csname ver@\currentfile\endcsname\relax
      File~\thepart :~{\ttfamily\currentfile}~
    \else
      \GetFileInfo{\currentfile}
      File~\thepart :~{\ttfamily\filename}~
      Date:~\ExplFileDate\ % space
      Version~\ExplFileVersion
    \fi
    \hfill\thepage
  }
  \cs_set_eq:NN \@evenfoot \@oddfoot
}
\iow_open:Nn \g_write_func_stream { \jobname.cmds }
\cs_new_nopar:Npn \doc_show_functions_defined: {
  \bool_if:nT { \g_doc_implementation_bool && \g_doc_checkfunc_bool } {
    \typeout{ ======================================== ^^J }

    \tl_clear:N \l_tmpa_tl
    \seq_map_inline:Nn \g_doc_functions_seq {
      \seq_if_in:NnT \g_doc_macros_seq {##1} {
        \tl_put_right:Nn \l_tmpa_tl { ##1 ^^J }
        \iow_now:Nn \g_write_func_stream { ##1 }
      }
    }
    \iow_close:N \g_write_func_stream
    \doc_functions_typeout:n {
      Functions~both~documented~and~defined:^^J (In~order~of~being~documented)
    }

    \seq_map_inline:Nn \g_doc_functions_seq {
      \seq_if_in:NnF \g_doc_macros_seq {##1} {
        \tl_put_right:Nn \l_tmpa_tl { ##1 ^^J }
      }
    }
    \doc_functions_typeout:n { Functions~documented~but~not~defined: }

    \seq_map_inline:Nn \g_doc_macros_seq {
      \seq_if_in:NnF \g_doc_functions_seq {##1} {
        \tl_put_right:Nn \l_tmpa_tl { ##1 ^^J }
      }
    }
    \doc_functions_typeout:n { Functions~defined~but~not~documented: }

    \typeout{ ======================================== }
  }
}
\AtEndDocument{ \doc_show_functions_defined: }
\cs_set_nopar:Npn \doc_functions_typeout:n #1 {
  \tl_if_empty:NF \l_tmpa_tl {
    \typeout{
      -------------------------------------- ^^J #1 ^^J
      -------------------------------------- ^^J \l_tmpa_tl
    }
    \tl_clear:N \l_tmpa_tl
  }
}
\cs_new:Npn \doc_show_not_tested: {
  \bool_if:NT \g_doc_checktest_bool
  {
    \bool_if:nT { !(\seq_if_empty_p:N  \g_doc_not_tested_seq) ||
                  !(\prop_if_empty_p:N \g_doc_missing_tests_prop) }
    {
      \tl_clear:N \l_tmpa_tl
      \prop_if_empty:NF \g_doc_missing_tests_prop
      {
        \tl_put_right:Nn \l_tmpa_tl
        {
          ^^J^^JThe~ following~ macro(s)~ have~ incomplete~ tests:^^J
        }
        \prop_map_inline:Nn \g_doc_missing_tests_prop
        {
          \tl_put_right:Nn \l_tmpa_tl
          {^^J\space\space\space\space ##1
           ^^J\space\space\space\space\space\space ##2}
        }
      }
      \seq_if_empty:NF \g_doc_not_tested_seq
      {
        \tl_put_right:Nn \l_tmpa_tl
        {
          ^^J^^J
          The~ following~ macro(s)~ do~ not~ have~ any~ tests:^^J
        }
        \seq_map_inline:Nn \g_doc_not_tested_seq
        {
          \clist_map_inline:nn {##1}
          {
            \tl_put_right:Nn \l_tmpa_tl {^^J\space\space\space\space ####1}
          }
        }
        \int_set:Nn \l_tmpa_int {\etex_interactionmode:D}
        \errorstopmode
        \ClassError{l3doc}{\l_tmpa_tl}{}
        \int_set:Nn \etex_interactionmode:D {\l_tmpa_int}
      }
    }
  }
}
\AtEndDocument{ \doc_show_not_tested: }
\g@addto@macro\theindex{\MakePrivateLetters}
\cs_set:Npn \verbatimchar {&}
\setcounter{IndexColumns}{2}
\IndexPrologue{
  \part*{Index}
  \markboth{Index}{Index}
  \addcontentsline{toc}{part}{Index}
  The~italic~numbers~denote~the~pages~where~the~
  corresponding~entry~is~described,~
  numbers~underlined~point~to~the~definition,~
  all~others~indicate~the~places~where~it~is~used.
}

\cs_set_nopar:Npn \doc_special_main_index:n #1 {
  \index{
    \@gobble#1
    \actualchar
    \string\verb\quotechar*\verbatimchar#1\verbatimchar
    \encapchar
    hdpgindex{\thepage}{usage}
  }
}
\cs_set_nopar:Npn \doc_special_main_index:o { \exp_args:No \doc_special_main_index:n }
\cs_set_nopar:Npn \hdpgindex #1#2#3 {
  \csname\ifx\\#2\\relax\else#2\fi\endcsname{
    \hyperlink{page.#1}{#3}
  }
}
\g@addto@macro \PrintIndex { \AtEndDocument{ \typeout{^^J
  ========================================^^J
  Generate~the~index~by~executing^^J
  \c_space_tl \c_space_tl \c_space_tl \c_space_tl
  makeindex~-s~l3doc.ist~-o~\jobname.ind~\jobname.idx^^J
  ========================================^^J
  }}
}
\GlossaryPrologue{
  \part*{Change~History}
  {\GlossaryParms\ttfamily\hyphenchar\font=`\-}
  \markboth{Change~History}{Change~History}
  \addcontentsline{toc}{part}{Change~History}
}
\g@addto@macro \PrintChanges { \AtEndDocument{ \typeout{^^J
  ========================================^^J
  Generate~the~change~list~by~executing^^J
  \c_space_tl \c_space_tl \c_space_tl \c_space_tl
   makeindex~-s~gglo.ist~~-o~\jobname.gls~\jobname.glo^^J
  ========================================^^J
  }}
}
\bool_if:NTF \g_doc_full_bool {
  \RecordChanges
  \CodelineIndex
  \EnableCrossrefs
  \AlsoImplementation
}{
  \CodelineNumbered
  \DisableCrossrefs
  \OnlyDescription
}
%% 
%%
%% End of file `l3doc.cls'.
