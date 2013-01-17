%%
%% This is file `pst-li3d.pro',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pst-li3d.dtx  (with options: `postscript-header')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from pst-li3d.pro.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file pst-li3d.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%%
%% Package `pst-li3d.dtx'
%%
%% Denis Girou (CNRS/IDRIS - France) <Denis.Girou@idris.fr>
%% and Peter Kleiweg (Rijksuniversiteit Groningen - Nederlands)
%% <kleiweg@let.rug.nl> %% %% July 10, 2003
%%
%% This program can be redistributed and/or modified under
%% the terms of the LaTeX Project Public License Distributed
%% from CTAN archives in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-li3d' is a PSTricks package for three dimensional
%%   lighten effect on characters and PSTricks graphics.
%%
%%
/tx@LightThreeDDict 40 dict def
tx@LightThreeDDict begin
/LightThreeDMove {
  /y0c exch def
  /x0c exch def
  /xc x0c def
  /yc y0c def
  newpath } def
/LightThreeDLine {
  /yyc exch def
  /xxc exch def
  yyc yc sub xxc xc sub 1 index 0 eq 1
  index 0 eq and not { atan
  /ac exch def
  ac LightThreeDMINangle le ac LightThreeDMAXangle ge or
    { ac LightThreeDAngle sub 2 mul cos 1 add LightThreeDColorPsCommand
    xc yc moveto xxc yyc lineto LightThreeDDXa LightThreeDDYa
    rlineto xc LightThreeDDXa add yc LightThreeDDYa add
    lineto closepath fill } if } if
    /xc xxc def
    /yc yyc def } def
/LightThreeDCurve {
  /y4c exch def
  /x4c exch def
  /y3c exch def
  /x3c exch def
  /y2c exch def
  /x2c exch def
  /y1c yc def
  /x1c xc def
1 LightThreeDSteps div 1 LightThreeDSteps div 1 {
  /t exch def
  3 t sub x1c mul t 2 sub x2c mul 1 t sub x3c mul add 3 mul add x4c
  t mul add t mul x2c x1c sub 3 mul add t mul x1c add % X
  3 t sub y1c mul t 2 sub y2c mul
  1 t sub y3c mul add 3 mul add y4c t mul add t
  mul y2c y1c sub 3 mul add t mul y1c add % Y
  LightThreeDLine
  } for
} def
/LightThreeDClose {
  x0c 0 eq {x0c} {x0c 1 add} ifelse y0c 0 eq {y0c} {y0c 1 add} ifelse
  LightThreeDLine newpath
} def
/LightThreeDPathForAll {
  { LightThreeDMove} { LightThreeDLine } { LightThreeDCurve } { LightThreeDClose }
    pathforall} def
end
%%
%% End of file `pst-li3d.pro'.
