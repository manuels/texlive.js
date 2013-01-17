% $Id: pst-node.pro 645 2012-02-12 09:09:51Z herbert $
%%
%% PostScript prologue for pst-node.tex.
%% Version 1.13, 2011/11/21.
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%
/tx@NodeDict 400 dict def tx@NodeDict begin
tx@Dict begin 			% from main pstricks dict
 /T /translate load def 
 /CP /currentpoint load def 
end
/NewNode { % on stack: { x y } boolean N@name type InitXnode 
  gsave 
  NodeScale                     % a bugfix for xelatex, it's empty for dvips
  /next exch def 		% { x y } boolean N@name type  
  dict dup 			% { x y } boolean N@name dict dict
  3 1 roll def 			% { x y } boolean dict N@name dict def
  exch { dup 3 1 roll def } if  % { x y } dict boolean
  begin 			% { x y } dict begin
  tx@Dict begin 
    STV CP T exec 		% set scaling
  end 
  /NodeMtrx CM def 		% save CM
  next 				% InitXNode
  end
  grestore 
} def
%
/InitPnode { 
  /Y ED /X ED 
  /NodePos { NodeSep Cos mul NodeSep Sin mul } def
} def
%
/InitCnode { 
  /r ED /Y ED /X ED 
  /NodePos { NodeSep r add dup Cos mul exch Sin mul } def 
} def
%
/GetRnodePos { 
  Cos 0 gt { /dx r NodeSep add def } { /dx l NodeSep sub def } ifelse 
  Sin 0 gt { /dy u NodeSep add def } { /dy d NodeSep sub def } ifelse 
  dx Sin mul abs dy 
  Cos mul abs gt { dy Cos mul Sin div dy } { dx dup Sin mul Cos Div } ifelse 
} def
%
/InitRnode { 
  /Y ED /X ED X sub /r ED /l X neg def Y add neg /d ED Y sub /u ED 
  /NodePos { GetRnodePos } def 
} def
%
/DiaNodePos { 
  w h mul w Sin mul abs h Cos mul abs add Div NodeSep add dup
  Cos mul exch Sin mul 
} def
%
/TriNodePos { 
  Sin s lt 
    { d NodeSep sub dup Cos mul Sin Div exch } 
    { w h mul w Sin mul h Cos abs mul add Div 
      NodeSep add dup Cos mul exch Sin mul 
    } ifelse 
} def
%
/InitTriNode { 
  sub 2 div exch 
  2 div exch 
  2 copy T 
  2 copy 4 index index /d ED 
  pop pop pop pop 
  -90 mul rotate 
  /NodeMtrx CM def 
  /X 0 def /Y 0 def 
  d sub abs neg /d ED 
  d add /h ED 
  2 div h mul h d sub Div /w ED 
  /s d w Atan sin def 
  /NodePos { TriNodePos } def 
} def
%
/OvalNodePos { 
  /ww w NodeSep add def 
  /hh h NodeSep add def 
  Sin ww mul Cos hh mul Atan dup cos ww mul exch sin hh mul 
} def
%
/GetCenter { begin X Y NodeMtrx transform CM itransform end } def
%
/XYPos { 
  dup sin exch cos Do 
  /Cos ED /Sin ED /Dist ED 
  Cos 0 gt 
    { Dist Dist Sin mul Cos div }
    { Cos 0 lt 
      { Dist neg Dist Sin mul Cos div neg }
      { 0 Dist Sin mul } ifelse 
    } ifelse 
  Do 
} def
%
/GetEdge {
  dup 0 eq 
    { pop begin 1 0 NodeMtrx dtransform 
      CM idtransform 
      exch atan sub 
      dup 
      sin /Sin ED 
      cos /Cos ED 
      /NodeSep ED 
      NodePos NodeMtrx dtransform CM idtransform end }
    { 1 eq {{exch}} {{}} ifelse /Do ED pop XYPos } ifelse 
} def
%
/AddOffset { 
  1 index 0 eq 
    { pop pop } 
    { 2 copy 5 2 roll cos mul add 4 1 roll sin mul sub exch } ifelse 
} def
%
/GetEdgeA { 
  NodeSepA AngleA NodeA NodeSepTypeA GetEdge 
  OffsetA AngleA AddOffset 
  yA add /yA1 ED 
  xA add /xA1 ED 
} def
%
/GetEdgeB { 
  NodeSepB AngleB NodeB NodeSepTypeB GetEdge 
  OffsetB AngleB AddOffset 
  yB add /yB1 ED 
  xB add /xB1 ED 
} def
%
/GetArmA { 
  ArmTypeA 0 eq 
    { /xA2 ArmA AngleA cos mul xA1 add def 
      /yA2 ArmA AngleA sin mul yA1 add def } 
    { ArmTypeA 1 eq {{exch}} {{}} ifelse 
      /Do ED 
      ArmA AngleA XYPos OffsetA AngleA AddOffset 
      yA add /yA2 ED 
      xA add /xA2 ED } ifelse 
} def
%
/GetArmB { 
  ArmTypeB 0 eq 
    { /xB2 ArmB AngleB cos mul xB1 add def 
      /yB2 ArmB AngleB sin mul yB1 add def } 
    { ArmTypeB 1 eq {{exch}} {{}} ifelse 
      /Do ED
      ArmB AngleB XYPos OffsetB AngleB AddOffset 
      yB add /yB2 ED 
      xB add /xB2 ED } ifelse 
} def
%
/InitNC { 
  /b ED /a ED % second and first node
  /NodeSepTypeB ED /NodeSepTypeA ED 
  /NodeSepB ED /NodeSepA ED 
  /OffsetB ED /OffsetA ED 
  tx@NodeDict a known tx@NodeDict b known and dup { 
    /NodeA a load def 
    /NodeB b load def 
    NodeA GetCenter /yA ED /xA ED 
    NodeB GetCenter /yB ED /xB ED } if 
} def
%
/LPutLine { 
  4 copy 
  3 -1 roll sub neg 3 1 roll sub Atan /NAngle ED 
  1 t sub mul 
  3 1 roll 1 t sub mul 
  4 1 roll t mul add /Y ED 
  t mul add /X ED 
} def
%
/LPutLines { 
  mark LPutVar counttomark 2 div 1 sub /n ED 
%  t floor dup n gt 
  t floor dup n ge 		% to allow npos<= hv 2008-08-14
  { pop n 1 sub /t 1 def } { dup t sub neg /t ED } ifelse 
  cvi 2 mul { pop } repeat 
  LPutLine 
  cleartomark 
} def
%
/BezierMidpoint { 
  /y3 ED /x3 ED /y2 ED /x2 ED /y1 ED /x1 ED /y0 ED /x0 ED /t ED 
  /cx x1 x0 sub 3 mul def 
  /cy y1 y0 sub 3 mul def 
  /bx x2 x1 sub 3 mul cx sub def 
  /by y2 y1 sub 3 mul cy sub def 
  /ax x3 x0 sub cx sub bx sub def 
  /ay y3 y0 sub cy sub by sub def 
  ax t 3 exp mul bx t t mul mul add 
  cx t mul add x0 add ay t 3 exp mul 
  by t t mul mul add cy t mul add
  y0 add 3 ay t t mul mul mul 2 
  by t mul mul add cy add 3 ax t t mul mul mul 
  2 bx t mul mul add cx add atan /NAngle ED 
  /Y ED /X ED 
} def
%
/HPosBegin { yB yA ge { /t 1 t sub def } if /Y yB yA sub t mul yA add def
} def
/HPosEnd { /X Y yyA sub yyB yyA sub Div xxB xxA sub mul xxA add def
/NAngle yyB yyA sub xxB xxA sub Atan def } def
/HPutLine { HPosBegin /yyA ED /xxA ED /yyB ED /xxB ED HPosEnd  } def
/HPutLines { HPosBegin yB yA ge { /check { le } def } { /check { ge } def
} ifelse /xxA xA def /yyA yA def mark xB yB LPutVar { dup Y check { exit
} { /yyA ED /xxA ED } ifelse } loop /yyB ED /xxB ED cleartomark HPosEnd 
} def
/VPosBegin { xB xA lt { /t 1 t sub def } if /X xB xA sub t mul xA add def
} def
/VPosEnd { /Y X xxA sub xxB xxA sub Div yyB yyA sub mul yyA add def
/NAngle yyB yyA sub xxB xxA sub Atan def } def
/VPutLine { VPosBegin /yyA ED /xxA ED /yyB ED /xxB ED VPosEnd  } def
/VPutLines { VPosBegin xB xA ge { /check { le } def } { /check { ge } def
} ifelse /xxA xA def /yyA yA def mark xB yB LPutVar { 1 index X check {
exit } { /yyA ED /xxA ED } ifelse } loop /yyB ED /xxB ED cleartomark
VPosEnd  } def
/HPutCurve { gsave newpath /SaveLPutVar /LPutVar load def LPutVar 8 -2
roll moveto curveto flattenpath /LPutVar [ {} {} {} {} pathforall ] cvx
def grestore exec /LPutVar /SaveLPutVar load def } def
/NCCoor { /AngleA yB yA sub xB xA sub Atan def /AngleB AngleA 180 add def
GetEdgeA GetEdgeB /LPutVar [ xB1 yB1 xA1 yA1 ] cvx def /LPutPos {
LPutVar LPutLine } def /HPutPos { LPutVar HPutLine } def /VPutPos {
LPutVar VPutLine } def LPutVar } def
%
/NCLine { 
  NCCoor 
  tx@Dict begin 
  ArrowA CP 4 2 roll 
  ArrowB 
  lineto pop pop
  end 
} def
%
/NCLines { 
  false NArray 
  n 0 eq 
    { NCLine } 
    { 2 copy yA sub exch xA sub Atan /AngleA ED 
      n 2 mul dup index exch index yB sub exch xB sub 
      Atan /AngleB ED 
      GetEdgeA GetEdgeB 
      /LPutVar [ xB1 yB1 n 2 mul 4 add 4 roll xA1 yA1 ] cvx def 
      mark LPutVar 
      tx@Dict begin false Line end 
      /LPutPos { LPutLines } def 
      /HPutPos { HPutLines } def 
      /VPutPos { VPutLines } def 
    } ifelse 
} def
%
/NCCurve { 
  GetEdgeA 
  GetEdgeB 
  xA1 xB1 sub yA1 yB1 sub Pyth 2 div dup 3 -1
roll mul /ArmA ED mul /ArmB ED /ArmTypeA 0 def /ArmTypeB 0 def GetArmA
GetArmB xA2 yA2 xA1 yA1 tx@Dict begin ArrowA end xB2 yB2 xB1 yB1 tx@Dict
begin ArrowB end curveto /LPutVar [ xA1 yA1 xA2 yA2 xB2 yB2 xB1 yB1 ]
cvx def /LPutPos { t LPutVar BezierMidpoint } def /HPutPos { { HPutLines
} HPutCurve } def /VPutPos { { VPutLines } HPutCurve } def } def
%
/NCAngles { 
  GetEdgeA GetEdgeB GetArmA GetArmB 
  /mtrx AngleA matrix rotate def 
  xA2 yA2 mtrx transform pop 
  xB2 yB2 mtrx transform exch pop 
  mtrx itransform 
  /y0 ED /x0 ED 
  mark ArmB 0 ne { xB1 yB1 } if 
  xB2 yB2 x0 y0 xA2 yA2 
  ArmA 0 ne { xA1 yA1 } if 
  tx@Dict begin false Line end 
  /LPutVar [ xB1 yB1 xB2 yB2 x0 y0 xA2 yA2 xA1 yA1 ] cvx def 
  /LPutPos { LPutLines } def
  /HPutPos { HPutLines } def 
  /VPutPos { VPutLines } def } def
%
/NCAngle { 
  GetEdgeA GetEdgeB GetArmB 
  /mtrx AngleA matrix rotate def 
  xB2 yB2 mtrx itransform pop xA1 yA1 mtrx itransform exch pop mtrx transform
  /y0 ED /x0 ED 
  mark 
  ArmB 0 ne { xB1 yB1 } if 
  xB2 yB2 x0 y0 xA1 yA1
  tx@Dict begin false Line end 
  /LPutVar [ xB1 yB1 xB2 yB2 x0 y0 xA1 yA1 ] cvx def 
  /LPutPos { LPutLines } def 
  /HPutPos { HPutLines } def 
  /VPutPos { VPutLines } def 
} def
%
/NCBar { 
  GetEdgeA GetEdgeB GetArmA GetArmB 
  /mtrx AngleA matrix rotate def
  xA2 yA2 mtrx itransform pop 
  xB2 yB2 mtrx itransform pop 
  sub dup 0 mtrx transform 
  3 -1 roll 0 gt 
    { /yB2 exch yB2 add def /xB2 exch xB2 add def }
    { /yA2 exch neg yA2 add def /xA2 exch neg xA2 add def } ifelse 
  mark 
  ArmB 0 ne { xB1 yB1 } if 
  xB2 yB2 xA2 yA2 ArmA 0 ne { xA1 yA1 } if 
  tx@Dict begin false Line end 
  /LPutVar [ xB1 yB1 xB2 yB2 xA2 yA2 xA1 yA1 ] cvx def 
  /LPutPos { LPutLines } def 
  /HPutPos { HPutLines } def 
  /VPutPos { VPutLines } def 
} def
%
/NCDiag { 
  /lineAngle ED
  GetEdgeA GetEdgeB GetArmA GetArmB mark
  lineAngle abs 0 gt {
    /xTemp xA2 10 add def
    /yTemp yA2 lineAngle dup sin exch cos div 10 mul add def
    /dY1 yTemp yA2 sub def
    /dX1 xTemp xA2 sub def
    /dY2 yB2 yB1 sub def
    /dX2 xB2 xB1 sub def
    dX1 abs 0.01 lt {
      /m2 dY2 dX2 div def
      /xB2 xA2 def
      /yB2 xA2 xB1 sub m2 mul yB1 add def
    }{
      dX2 abs 0.01 lt {
        /m1 dY1 dX1 div def
        /xB2 xB1 def
        /yB2 xB1 xA2 sub m1 mul yA2 add def
      }{%
        /m1 dY1 dX1 div def
        /m2 dY2 dX2 div def
        /xB2 m1 xA2 mul m2 xB1 mul sub yA2 sub yB1 add m1 m2 sub div def
        /yB2 xB2 xA2 sub m1 mul yA2 add def
      } ifelse
    } ifelse
  } if
  ArmB 0 ne { xB1 yB1 } if
  xB2 yB2 xA2 yA2 
  ArmA 0 ne { xA1 yA1 } if 
  tx@Dict begin false Line end
  /LPutVar [ xB1 yB1 xB2 yB2 xA2 yA2 xA1 yA1 ] cvx def 
  /LPutPos { LPutLines } def 
  /HPutPos { HPutLines } def 
  /VPutPos { VPutLines } def 
%
%  GetEdgeA GetEdgeB GetArmA GetArmB mark 
%  ArmB 0 ne { xB1 yB1 } if
%  xB2 yB2 xA2 yA2 
%  ArmA 0 ne { xA1 yA1 } if 
%  tx@Dict begin false Line end
%  /LPutVar [ xB1 yB1 xB2 yB2 xA2 yA2 xA1 yA1 ] cvx def 
%  /LPutPos { LPutLines } def 
%  /HPutPos { HPutLines } def 
%  /VPutPos { VPutLines } def 
} def
%
/NCDiagg { 
  /lineAngle ED
  GetEdgeA GetArmA 
  lineAngle abs 0 gt 
    { lineAngle }
    { yB yA2 sub xB xA2 sub Atan 180 add } ifelse 
  /AngleB ED
  GetEdgeB mark
  lineAngle abs 0 gt {
    /dY2 yA2 yA1 sub def
    /dX2 xA2 xA1 sub def
    lineAngle abs 90 eq {
      /m2 dY2 dX2 div def
      /yA2 xB xA2 sub m2 mul yA2 add def
      /xA2 xB def
    }{
      /m1 lineAngle dup sin exch cos div def % tan alpha
      dX2 abs 0.01 lt {
        /yA2 xA1 xB sub m1 mul yB add def
        /xA2 xA1 def
      }{%
        /m2 dY2 dX2 div def
        /xA2 m1 xB mul m2 xA2 mul sub yA2 add yB sub m1 m2 sub div def
        /yA2 xA2 xB sub m1 mul yB add def
      } ifelse
    } ifelse
  } if
  xB1 yB1 xA2 yA2
  ArmA 0 ne { xA1 yA1 } if
  tx@Dict begin false Line end
  /LPutVar [ xB1 yB1 xA2 yA2 xA1 yA1 ] cvx def
  /LPutPos { LPutLines } def
  /HPutPos { HPutLines } def
  /VPutPos { VPutLines } def
%
%  GetEdgeA GetArmA 
%  yB yA2 sub xB xA2 sub Atan 180 add /AngleB ED
%  GetEdgeB 
%  mark 
%  xB1 yB1 xA2 yA2 
%  ArmA 0 ne { xA1 yA1 } if 
%  tx@Dict begin false Line end 
%  /LPutVar [ xB1 yB1 xA2 yA2 xA1 yA1 ] cvx def 
%  /LPutPos { LPutLines } def 
%  /HPutPos { HPutLines } def 
%  /VPutPos { VPutLines } def 
} def
%
/NCLoop { 
  GetEdgeA GetEdgeB GetArmA GetArmB 
  /mtrx AngleA matrix rotate def 
  xA2 yA2 mtrx transform loopsize add /yA3 ED /xA3 ED 
  /xB3 xB2 yB2 mtrx transform pop def 
  xB3 yA3 mtrx itransform /yB3 ED /xB3 ED 
  xA3 yA3 mtrx itransform /yA3 ED /xA3 ED 
  mark ArmB 0 ne { xB1 yB1 } if 
  xB2 yB2 xB3 yB3 xA3 yA3 xA2 yA2 ArmA 0 ne { xA1 yA1 } if 
  tx@Dict begin false Line end 
  /LPutVar [ xB1 yB1 xB2 yB2 xB3 yB3 xA3 yA3 xA2 yA2 xA1 yA1 ] cvx def 
  /LPutPos { LPutLines } def 
  /HPutPos { HPutLines } def 
  /VPutPos { VPutLines } def 
} def
%
% DG/SR modification begin - May 9, 1997 - Patch 1
%/NCCircle { 0 0 NodesepA nodeA \tx@GetEdge pop xA sub 2 div dup 2 exp r
%r mul sub abs sqrt atan 2 mul /a ED r AngleA 90 add PtoC yA add exch xA add
%exch 2 copy /LPutVar [ 4 2 roll r AngleA ] cvx def /LPutPos { LPutVar t 360
%mul add dup 5 1 roll 90 sub \tx@PtoC 3 -1 roll add /Y ED add /X ED /NAngle ED
%
/NCCircle { 
  NodeSepA 0 NodeA 0 GetEdge pop 
  2 div dup 2 exp r r mul sub abs sqrt 
  atan 2 mul /a ED 
  r AngleA 90 add PtoC yA add exch xA add 
  exch 2 copy 
  /LPutVar [ 4 2 roll r AngleA ] cvx def 
  /LPutPos { 
    LPutVar t 360 mul add dup 5 1 roll 90 sub PtoC 
    3 -1 roll add 
    /Y ED add /X ED /NAngle ED
% DG/SR modification end
  } def 
  /HPutPos { LPutPos } def 
  /VPutPos { LPutPos } def 
  r AngleA 90 sub a add AngleA 270 add a sub 
  tx@Dict begin 
  /angleB ED /angleA ED /r ED 
  /c 57.2957 r Div def 
  /y ED /x ED 
} def
%
/NCBox { 
  /d ED /h ED 
  /AngleB yB yA sub xB xA sub Atan def 
  /AngleA AngleB 180 add def 
  GetEdgeA GetEdgeB 
  /dx d AngleB sin mul def 
  /dy d AngleB cos mul neg def 
  /hx h AngleB sin mul neg def 
  /hy h AngleB cos mul def 
  /LPutVar [ 
    xA1 hx add yA1 hy add xB1 hx add yB1 hy add 
    xB1 dx add yB1 dy add xA1 dx add yA1 dy add ] cvx def 
  /LPutPos { LPutLines } def 
  /HPutPos { xB yB xA yA LPutLine } def 
  /VPutPos { HPutPos } def 
  mark 
  LPutVar tx@Dict begin false Polygon end 
} def
%
/NCArcBox { 
  /l ED neg /d ED /h ED /a ED 
  /AngleA yB yA sub xB xA sub Atan def 
  /AngleB AngleA 180 add def 
  /tA AngleA a sub 90 add def 
  /tB tA a 2 mul add def 
  /r xB xA sub tA cos tB cos sub Div dup 0 eq { pop 1 } if def
  /x0 xA r tA cos mul add def 
  /y0 yA r tA sin mul add def 
  /c 57.2958 r div def 
  /AngleA AngleA a sub 180 add def 
  /AngleB AngleB a add 180 add def
  GetEdgeA GetEdgeB 
  /AngleA tA 180 add yA yA1 sub xA xA1 sub Pyth c mul sub def 
  /AngleB tB 180 add yB yB1 sub xB xB1 sub Pyth c mul add def 
  l 0 eq { 
    x0 y0 r h add AngleA AngleB arc x0 y0 r d add AngleB AngleA arcn 
  }{ 
    x0 y0 translate 
    /tA AngleA l c mul add def 
    /tB AngleB l c mul sub def
    0 0 r h add tA tB arc r h add 
    AngleB PtoC r d add 
    AngleB PtoC 2 copy 
    6 2 roll l arcto 4 { pop } repeat 
    r d add tB PtoC l arcto 4 { pop } repeat 
    0 0 r d add tB tA arcn r d add 
    AngleA PtoC r h add 
    AngleA PtoC 2 copy 6 2 roll 
    l arcto 4 { pop } repeat 
    r h add tA PtoC l arcto 4 { pop } repeat 
  } ifelse 
  closepath 
  /LPutVar [ x0 y0 r AngleA AngleB h d ] cvx def 
  /LPutPos { 
    LPutVar /d ED /h ED 
    /AngleB ED /AngleA ED 
    /r ED /y0 ED /x0 ED 
    t 1 le { 
      r h add AngleA 1 t sub mul AngleB t mul add dup 90 add /NAngle ED PtoC 
    }{t 2 lt { 
        /NAngle AngleB 180 add def r 2 t sub 
        h mul t 1 sub d mul add add AngleB PtoC 
      }{ 
        t 3 lt { 
          r d add AngleB 3 t sub mul AngleA 2 t sub
          mul add dup 90 sub /NAngle ED PtoC 
        }{ 
          /NAngle AngleA 180 add def 
          r 4 t sub d mul t 3 sub h mul add add AngleA PtoC 
        } ifelse 
      } ifelse 
    } ifelse
    y0 add /Y ED x0 add /X ED 
  } def 
  /HPutPos { LPutPos } def 
  /VPutPos { LPutPos } def 
} def
%
/Tfan { /AngleA yB yA sub xB xA sub Atan def GetEdgeA w xA1 xB sub yA1 yB
sub Pyth Pyth w Div CLW 2 div mul 2 div dup AngleA sin mul yA1 add /yA1
ED AngleA cos mul xA1 add /xA1 ED /LPutVar [ xA1 yA1 m { xB w add yB xB
w sub yB } { xB yB w sub xB yB w add } ifelse xA1 yA1 ] cvx def /LPutPos
{ LPutLines } def /VPutPos@ { LPutVar flag { 8 4 roll pop pop pop pop }
{ pop pop pop pop 4 2 roll } ifelse } def /VPutPos { VPutPos@ VPutLine }
def /HPutPos { VPutPos@ HPutLine } def mark LPutVar tx@Dict begin
/ArrowA { moveto } def /ArrowB { } def false Line closepath end } def
%
/LPutCoor { 
  NAngle 
  tx@Dict begin /NAngle ED end 
  gsave 
  CM STV 
  CP Y sub neg exch X sub neg exch moveto 
  setmatrix CP 
  grestore 
} def
%
/LPut { 
  tx@NodeDict /LPutPos known 
    { LPutPos } { CP /Y ED /X ED /NAngle 0 def } ifelse 
  LPutCoor  
} def
%
/HPutAdjust { 
  Sin Cos mul 0 eq 
    { 0 } 
    { d Cos mul Sin div flag not { neg } if 
      h Cos mul Sin div flag { neg } if 
      2 copy gt { pop } { exch pop } ifelse 
    } ifelse 
  s add flag { r add neg }{ l add } ifelse 
  X add /X ED 
} def
%
/VPutAdjust { 
  Sin Cos mul 
  0 eq 
    { 0 }
    { l Sin mul Cos div flag { neg } if
      r Sin mul Cos div flag not { neg } if 
      2 copy gt { pop } { exch pop } ifelse 
    } ifelse 
  s add flag { d add } { h add neg } ifelse 
  Y add /Y ED 
} def
%
%
end
%
% END pst-node.pro
