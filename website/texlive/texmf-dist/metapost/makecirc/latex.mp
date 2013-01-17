%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% latex.mp  Parametrizable latex labels for metapost
%% Copyright (c) 2003 JL Diaz
%% based on an idea taken from Metafun, by Hans Hagen
%
% This program may be distributed and/or modified under the conditions
% of the LaTeX Project Public License, either version 1.2 of this
% license or (at your option) any later version.  The latest version
% of this license is in http://www.latex-project.org/lppl.txt and
% version 1.2 or later is part of all distributions of LaTeX version
% 1999/12/01 or later.
%
% This program consists of the file latex.mp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For the impatient: Jump to "USAGE"
%
% Introduction: The problem
%
%  Let us suppose that you need to typeset several labels of the form
%  $x_1$, $x_2$, ... $x_{10}$. Since each label is a formula, the
%  construction btex/etex is required to typeset it through TeX (or
%  LaTeX). So, the straighforward solution is:
%
%    label(btex $x_1$ etex, (1u,0u));
%    label(btex $x_2$ etex, (2u,0u));
%      ...
%    label(btex $x_{10}$ etex, (10u,0u));
%
%  This repeated structure is inviting us to convert it into a for
%  loop. A naive attempt would be:
%
%    for i=1 upto 10:
%       label (btex $x_{i}$ etex, (i*u, 0));
%    endfor;
%
%  Unfortunately the above would produce ten times the same label
%  $x_{i}$, because i is not evaluated in this context as a variable.
%
%  A second, more clever attempt would be:
%
%    for i=1 upto 10:
%      label("btex $x_{" & decimal i & "}$ etex", (i*u, 0));
%    endfor;
%
%  where we are making use of the string concatenation operator (&),
%  and the "decimal" operator, which produces an string whith the
%  decimal representation of its argument. This way, the macro label
%  will receive successively as first argument the strings: "btex
%  $x_{1}$ etex", "btex $x_{2}$ etex", end so on.
%
%  This solution does not work either, because label is receiving a
%  string, instead of a picture (which is the result of a proper
%  btex/etex construction). When a string is received, label simply
%  outputs that string, without calling TeX (LaTeX) for formatting it.
%
%  Metapost provides a way of "executing" the code which is stored in
%  a string, it is the scantokens primitive. So, it appears that a
%  modification of the label primitive would be possible, which
%  applies the scantokens primitive on the string which it receives as
%  parameter. Unfortunately this does not work either, because the way
%  in which btex/etex works procludes it use as argument of
%  scantokens.
%
%  So, apparently, there is not an easy solution to the problem of
%  passing arguments to the etex/btex construct.
%
% The solution
%
%  Since the construct btex/etex can only be used at the "top level"
%  of a source file, and not embedded in any string, the only way to
%  achieve the desired result is to store the string "btex ... etex"
%  in an external temporal file, and input back that file.
%
%  This solution is implemented in the macro package "TEX.mp" which is
%  part of the standard metapost distribution. Using this package, the
%  problem of printing the ten labels $x_1$ .. $x_{10}$ becomes simple:
%
%    for i=0 upto 10:
%      label(TEX("$x_{" & decimal i & "}$", (u*i,0));
%    endfor;
%
%  The macro TEX receives an string as argument, and uses TeX to
%  typeset it. This is achieved, as already explained, by creating a
%  new string which encapsulated the given argument into a btex/etex
%  pair, writing this new string in an external file, and inputting
%  that file back.
%
%  This approach has two main drawbacks:
%
%   1) An external file is created, and processed each time TEX is
%   used. This is very inefficient, and the slowdown is noticeable if
%   TEX is used often.
%
%   2) If we want to use latex istead of tex, the TEX macro will not
%   work, because the external file created through this macro does
%   not include the verbatimtex header required to initialize latex.
%
% Metafun approach: a clever solution
%
%  In the excelent macro package Metafun (by Hans Hagens), a nice
%  solution is found to the first problem. Instead of writing the
%  auxiliar file and inputting it again, what is wrote is an auxiliar
%  metapost program which defines a serie of picture variables, each
%  one with the result of a btex/etex pair. In the first run of
%  metapost, this auxiliar file is write-only. In the second run, the
%  file is read at the beginning, so all picture variables get
%  defined. In this second run, each time the TEX macro is called, it
%  checks if the corresponding picture variable is already defined,
%  and in this case it simply returns its value.
%
%  This approach is much more efficient, since a single externa file
%  is produced and processed, no matter how much the TEX macro is
%  called. The only drawback is that two metapost runs are required.
%
% latex.mp: my solution
%
%  I liked very much the metafun solution, but I did not want to use
%  the whole Metafun package only to obtain this
%  functionality. Moreover, metafun relies in a set of external
%  scripts, which decide to input or not the external file, depending
%  on the existence of that file. I would prefer do not require perl
%  nor any other scripting language. Only metapost.
%
%  This is why I wrote "latex.mp". It implements the idea in the
%  metafun package, but it does not require any external script in
%  order to check the existence of the auxiliar file.
%
% ================================================================
%
%  USAGE
%
%   input "latex";
%   initlatex(...);
%   ...
%
%   latex("string to be formatted by latex");
%   % Returns a picture which can be used in a label
%
% The initlatex macro writes a latex header in an auxiliar file. You
% do not need to call this macro if you use TeX as typesetting engine.
%
% On the other hand, if you want to use LaTeX as typesetting engine,
% you need to call this macro before the first beginfig(). The macro
% requires a mandatory argument, which is a string with adittional
% macro commands to be placed before the "\begin{document}". For
% example:
%
%   initlatex("\usepackage[latin1]{inputenc}\usepackage{amsmath}");
%
% If you do not need any aditional package, you can use "" as
% argument.
%
% You can use the latex macro in any place where a picture is
% expected, as in the first argument of a label comand. For example:
%
%   for i=0 upto 10:
%     label(latex("$x_{$ & decimal i & "}$", (u*i,0));
%   endfor;
%
% In order to correctly obtain the labels which use the latex macro,
% you need to process your source file twice through metapost. The
% first run all labels will show as "[?]", but the second run they
% will have the correct value.
%
% IMPORTANT:
%
% If the text passed to the latex macro contains errors, latex will be
% unable to complete its run. This will make impossible to run mpost
% on the source, even if the errors are corrected, until you delete
% the auxiliar file (which has .mpt extension)
%
%
%================================================================
% Implementation
%
numeric NumPic;  % Total number of times that latex() macro has been
		 % called
picture LaTeXPic[]; % Picture array which stores the result of each
		    % latex macro call. This array is filled when the
		    % axiliar file is read.
string LaTeXsetup;  % additional packages and macro definitions for latex

% Initialization
NumPic:=0;
LaTeXsetup:="\documentclass{article}";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Entry point
%
% The auxiliar file is read, but only if it exists
%
if readfrom(jobname&".mpt") <> EOF:
  scantokens ("input "&jobname & ".mpt");
fi;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initlatex()
%
% By calling this function, the user can specify aditional packages and
% macro definitions to the be used by latex.
%
% For example:
% 
%   initlatex("\usepackage[latin1]{inputenc}\usepackage{amsmath}");
%
% The global variable LaTeXsetup is also provided, mainly for third
% party libraries which require to define their own macros. The
% programmers of these libraries should append their own material to
% the LaTeXsetup variable, by using the & operator. For example:
%
% LaTeXsetup:=LaTeXsetup & "\def\TO{\Longrightarrow}";
%
def initlatex primary s =
  write "verbatimtex" to jobname & ".mpt";
  write "%&latex" to jobname & ".mpt";
  write LaTeXsetup to jobname & ".mpt";
  write s to jobname & ".mpt";
  write "\begin{document}" to jobname & ".mpt";
  write "etex" to jobname & ".mpt";
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% latex()
%
% This macro receives a string, and returns a picture which contains
% the result of running the string by latex. The result can be used
% whenever a picture argument is expected, as for example in a label.

vardef latex@#(expr txt) =
  NumPic := NumPic + 1 ;
  if string txt :
    write "% figure " & decimal charcode & " : " & char(10) &
    "LaTeXPic[" & decimal NumPic & "] := btex " &
    txt & " etex ;" to jobname & ".mpt" ;
    if unknown LaTeXPic[NumPic] :
      thelabel@#("[??]",origin)
    else :
      thelabel@#(LaTeXPic[NumPic],origin)
    fi
  else :
    thelabel@#(txt,origin)
  fi
enddef ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EOF
