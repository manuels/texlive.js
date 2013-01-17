%%
%% This is file `hwexam.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% hwexam.dtx  (with options: `cls')
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{hwexam}[2012/01/28 v0.9b assignment and exam documents]
\DeclareOption{test}{\PassOptionsToPackage{\CurrentOption}{hwexam}}
\DeclareOption{multiple}{\PassOptionsToPackage{\CurrentOption}{hwexam}}
\DeclareOption{showmeta}{\PassOptionsToPackage{\CurrentOption}{metakeys}}
\DeclareOption{extrefs}{\PassOptionsToPackage{\CurrentOption}{sref}}
\DeclareOption{notes}{\PassOptionsToPackage{\CurrentOption}{problem}}
\DeclareOption{hints}{\PassOptionsToPackage{\CurrentOption}{problem}}
\DeclareOption{solutions}{\PassOptionsToPackage{\CurrentOption}{problem}}
\DeclareOption{pts}{\PassOptionsToPackage{\CurrentOption}{problem}}
\DeclareOption{min}{\PassOptionsToPackage{\CurrentOption}{problem}}
\DeclareOption{boxed}{\PassOptionsToPackage{\CurrentOption}{problem}}
\DeclareOption{extract}{\PassOptionsToPackage{\CurrentOption}{problem}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{omdoc}}
\ProcessOptions
\LoadClass{omdoc}
\RequirePackage{stex}
\RequirePackage{hwexam}
\RequirePackage{graphicx}
\RequirePackage{a4wide}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsmath}
\endinput
%%
%% End of file `hwexam.cls'.
