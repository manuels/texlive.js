% $Id: pstricks.pro 647 2012-02-12 15:03:40Z herbert $
%
%% PostScript prologue for pstricks.tex.
%% Version 1.12, 2012/02/12
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%
%
% Define the follwing gs-functions if not known, eg when using distiller
%
systemdict /.setopacityalpha known not {/.setopacityalpha { pop } def } if
systemdict /.setblendmode known not {/.setblendmode { pop } def } if
systemdict /.setshapealpha known not {/.setshapealpha { pop } def } if
%
/tx@Dict 200 dict def 				% the main PSTricks dictionary
tx@Dict begin
/ADict 25 dict def				% The arrow dictionaray
/CM { matrix currentmatrix } bind def
/SLW /setlinewidth load def
/CLW /currentlinewidth load def
/CP /currentpoint load def
/ED { exch def } bind def
/L /lineto load def
/T /translate load def
/TMatrix { } def
/RAngle { 0 } def
/Sqrt { dup 0 lt { pop 0 } { sqrt } ifelse } def  % return 0 for negative arguments 
/Atan { /atan load stopped { pop pop 0 } if } def % return 0 if atan not known
/ATAN1 {neg -1 atan 180 sub } def		% atan(x) (only one parameter)
/Div { dup 0 eq { pop } { div } ifelse } def  	% control the division
/tan { dup cos abs 1.e-10 lt 
  { pop 1.e10 } 				% return 1.e10 as infinit
  { dup sin exch cos div } ifelse 		% default sin/cos
} def
/Tan { dup sin exch cos Div } def 		% sin(x)/cos(x) x in degrees
/Acos {dup dup mul neg 1 add dup 0 lt {		% arc cos, returns 0 when negative root
  pop pop 0 }{ sqrt exch atan} ifelse } def
/NET { neg exch neg exch T } def	      	% change coordinate system to the negative one		
/Pyth { dup mul exch dup mul add sqrt } def   	% Pythagoras, expects 2 parameter
/Pyth2 {					% Pythagoras, xA yA xB yB
  3 -1 roll 		% xA xB yB yA
  sub			% xA xB yB-yA
  3 1 roll 		% yB-yA xA xB
  sub			% yB-yA xA-xB
  Pyth } def
/PtoC { 2 copy cos mul 3 1 roll sin mul } def 	% Polar to Cartesian
/Rand { rand 4294967295 div } def		% a real random number
%----------------- hv added 20050516 ---------------
/PiDiv2 1.57079632680 def
/Pi 3.14159265359 def 
/TwoPi 6.28318530718 def
/Euler 2.71828182846 def 
%/e Euler bind def
%
/RadtoDeg { 180 mul Pi div } bind def 		% convert from radian to degrees
/DegtoRad { Pi mul 180 div } bind def 		% viceversa
%----------------- hv end---------------------------
/PathLength@ { /z z y y1 sub x x1 sub Pyth add def /y1 y def /x1 x def } def
%
/PathLength { 
  flattenpath /z 0 def 
  { /y1 ED /x1 ED /y2 y1 def /x2 x1 def }
  { /y ED /x ED PathLength@ } 
  {} 
  { /y y2 def /x x2 def PathLength@ }
  /pathforall load stopped { pop pop pop pop } if 
  z 
} def
%
/STP { .996264 dup scale } def			% BP/PT scaling
/STV { SDict begin normalscale end STP  } def	% 
%
/DashLine {
    dup 0 gt
    { /a .5 def PathLength exch div }
    { pop /a 1 def PathLength } ifelse
    /b ED % pattern should fit evenly in b
    dup /X ED % pattern array
    0 get /y ED % length of first black segment
    /z 0 X {add} forall def % length of the full pattern
    %% Computation of the scaling factor as described by van Zandt:
    b a .5 sub 2 mul y mul sub z Div round
    z mul a .5 sub 2 mul y mul add b exch Div
    %%%% scaling factor on stack.
    /z ED %% now, z is the scaling factor
    false % for the length test below
    X { z mul } forall X astore %% modification TN 04-08-07
    %%% Checking whether at least one dash in X has positive length:
    {0 gt or} forall
    { X 1 a sub y mul }
    { [ 1 0 ] 0 }
    ifelse
    setdash stroke
} def
%
/DotLine { 
  /b PathLength def 
  /a ED /z ED /y CLW def 
  /z y z add def 
  a 0 gt { 
    /b b a div def 
  }{ 
    a 0 eq { 
      /b b y sub def 
    }{ a -3 eq { 
      /b b y add def } if 
    } ifelse 
  } ifelse 
  [ 0 b b z Div round Div dup 0 le { pop 1 } if ] 
  a 0 gt { 0 }{ y 2 div a -2 gt { neg }if } ifelse 
  setdash 1 setlinecap stroke 
} def
%
/SymbolLine {   % on stack [ x y x y ...
  counttomark 					% number of elements
  2 div cvi /n ED     				% n pairs
  /YA ED /XA ED					% the start point
  n 1 sub { 
    /YB ED /XB ED
    /XLength XB XA sub def
    /YLength YB YA sub def
    /PAngle YLength XLength Atan def
    /XYLength XLength YLength Pyth def

    %% for negative SymStep we calculate the distance 
    SymStep 0 lt 
      { %XYLength SymStep div abs cvi 
        /nSym SymStep abs cvi def } 
      { /nSym XYLength SymStep div cvi def }
    ifelse
    0.5 setflat
    /Shift Symbol stringwidth pop 2 div def 
    /deltaX XLength nSym div def
    /deltaY YLength nSym div def
    curveticks 
      { XA YA moveto }
      { XA Shift sub YA Shift sub moveto }
    ifelse 
    nSym { 
      gsave 
      curveticks 
        { PAngle 180 sub CorrAngle sub tickAngle add /rotAngle ED  
          currentpoint translate rotAngle rotate 
          0 SymbolWidth 2 div moveto 0 SymbolWidth 2 div neg lineto 
          SymbolLinewidth setlinewidth stroke
        }
        { 
          rotateSymbol { PAngle 180 sub CorrAngle sub rotate } if
          Symbol show 
        }
      ifelse 
      grestore 
      deltaX deltaY rmoveto
    } repeat
    /YA YB def /XA XB def
  } repeat 
  curveticks 
    { XA YA moveto }
    { XA Shift sub YA Shift sub moveto }
  ifelse 
  gsave 
  curveticks 
    { PAngle 180 sub CorrAngle sub tickAngle add /rotAngle ED  
      XA YA translate rotAngle rotate 
      0 SymbolWidth 2 div moveto 0 SymbolWidth 2 div neg lineto 
      SymbolLinewidth setlinewidth stroke
    }
    { 
      rotateSymbol { PAngle 180 sub CorrAngle sub rotate } if
      Symbol show 
    }
  ifelse 
  grestore
  pop 				% delete the mark symbol
} def
%
/LineFill { % hv ------------ patch 7 -------------
  gsave 
  abs /hatchWidthInc ED
  abs /hatchSepInc ED
  abs CLW add /a ED 
  a 0 dtransform round exch round exch
  2 copy idtransform 
  exch Atan rotate 
  idtransform pop /a ED 
  .25 .25 itransform pathbbox 
  /y2 ED 
  a Div ceiling cvi /x2 ED /y1 ED 
  a Div cvi /x1 ED /y2 y2 y1 sub def 
  clip 
  newpath 
  2 setlinecap 
  systemdict
  /setstrokeadjust known { true setstrokeadjust } if 
  x2 x1 sub 1 add { 
    x1 a mul y1 moveto 0 y2 rlineto stroke 
    /x1 x1 1 add 
      hatchWidthInc 0 gt { CLW add } if 
    def 
    hatchSepInc 0 gt hatchWidthInc 0 gt or { 
      /a a hatchSepInc add def
      CLW hatchWidthInc add SLW 
    } if
  } repeat 
  grestore 
  pop pop } def
%
/DotFill {%	 on stack: dot radius
  /dotRadius ED
  abs CLW add /a ED 
  a 0 dtransform round exch round exch
  2 copy idtransform 
  exch Atan rotate 
  idtransform pop /a ED 
  .25 .25 itransform 
  pathbbox % llx lly urx ury of smallest bounding box
  /y2 ED /x2 ED /y1 ED /x1 ED 
  y2 y1 sub a div 2 add cvi /Ny ED
  x2 x1 sub a div 2 add cvi /Nx ED
  clip 
  newpath 
  /yA y1 dotRadius add CLW add def
  /xA0 x1 dotRadius add CLW add def
  Ny {
     /xA xA0 def
     Nx { 
       newpath 
       xA yA dotRadius 0 360 arc 
       SolidDot { gsave fill grestore } if 
       stroke
       xA a add /xA ED
     } repeat
     yA a add /yA ED
  } repeat
  grestore
} def
%
/PenroseFill {%	 on stack: scaling factor
  dup dup scale
  1 exch div round /penroseFactor ED 
  a 0 dtransform round exch round exch
  2 copy idtransform 
  exch Atan rotate 
  idtransform pop /a ED 
  .25 .25 itransform pathbbox 
  /y2 ED 
  a Div ceiling cvi /x2 ED /y1 ED 
  a Div cvi /x1 ED /y2 y2 y1 sub def 
  clip 
  newpath 
  systemdict
  /setstrokeadjust known { true setstrokeadjust } if 
  /I/S/L/W/G/+/Z/F/E/D[/def/exch/for{E D}/add{s E get mul}
 { Z -36.2001 1 33 }{25 E S rlineto}{/q Z dup q G E q 1 + G}{Z 2 2}]{cvx def}forall
  [0 72 1008 {dup sin E cos }F ]1 setlinejoin/s W{/a W{/b I 10{/i I 4{/m I moveto
  i m +/j I 10{/l Z b m l + G a l G sub s m get div .2 + floor .3 + 25
  mul j l + S rmoveto}F i L j L stroke }F}F}F}F 
  grestore 
  pop pop 
} def
%
/TruchetFill { %	 on stack: scaling factor
  10 dict begin
  dup dup scale
  1 exch div round /penroseFactor ED 
  a 0 dtransform round exch round exch
  2 copy idtransform 
  exch Atan rotate 
  idtransform pop /a ED 
  .25 .25 itransform pathbbox 
  /y2 ED 
  a Div ceiling cvi /x2 ED /y1 ED 
  a Div cvi /x1 ED /y2 y2 y1 sub def 
  clip 
  newpath 
  systemdict
  /setstrokeadjust known { true setstrokeadjust } if 
  /ma a neg def
  /ha a 2 div def 
  /mha ha neg def
  /tile { 
    rand dup 2 idiv 2 mul eq { 90 rotate } if
    mha mha moveto ha mha lineto
    ha ha lineto mha ha lineto
%    closepath .1 setlinewidth stroke
    contents
  } def
  /contents{ 
    0 ha moveto ha 0 lineto
    0 mha moveto mha 0 lineto
%    1 setlinewidth stroke
  } def
  /dotiling {
    f ma mul a f a mul { 
      /i exch def
      f ma mul a f a mul { 
        /j exch def
        gsave i j translate
        tile stroke grestore
      } for
    } for
  } def
%
  /f 3 def 
  5 srand dotiling 
  end % local user dict
} def
%
/BeginArrow { 
  ADict begin 			% hold it local, for end see EndArrow
  /@mtrx CM def 
  gsave 
  2 copy T 
  2 index sub neg exch 
  3 index sub exch Atan 
  rotate newpath 
} def
%
/EndArrow { @mtrx setmatrix CP grestore end } def % end the ADict
%
/Arrow { 
  CLW mul add dup 
  2 div /w ED 
  mul dup /h ED 
  mul /a ED 
  { 0 h T 1 -1 scale } if 
  w neg h moveto 
  0 0 L w h L w neg a neg rlineto 
  gsave fill grestore 
} def
%
/ArrowD { % the sides are drawn as curves (hv 20071211)
  CLW mul add dup 
  2 div /w ED 
  mul dup /h ED 
  mul /Inset ED 
  { 0 h T 1 -1 scale } if % changes the direction
% we use y=w/h^2 * x^2 as equation for the control points
% for the coordinates the arrow is seen from top to bottom
% the bottom (tip) is (0;0)
  w neg h moveto % lower left of >
  w 9 div 4 mul neg h 3 div 2 mul
  w 9 div neg       h 3 div  
  0 0 curveto    % tip of >
  w 9 div        h 3 div  
  w 9 div 4 mul  h 3 div 2 mul
  w h curveto % upper left of >
  w neg Inset neg rlineto % move to x=0 and inset
  gsave fill grestore 
} def 
%
/Tbar { 
  CLW mul add /z ED 
  z -2 div CLW 2 div moveto 
  z 0 rlineto stroke 
  0 CLW moveto 
} def
%
/Bracket { 
  CLW mul add dup CLW sub 2 div 
  /x ED mul CLW add /y ED /z CLW 2 div def 
  x neg y moveto 
  x neg CLW 2 div L x CLW 2 div L x y L stroke 
  0 CLW moveto 
} def
%
/RoundBracket { 
  CLW mul add dup 2 div 
  /x ED mul /y ED /mtrx CM def 
  0 CLW 2 div T x y mul 0 ne { x y scale } if 
  1 1 moveto 
  .85 .5 .35 0 0 0 curveto 
  -.35 0 -.85 .5 -1 1 curveto 
  mtrx setmatrix stroke 0 CLW moveto 
} def
%
/SD { 0 360 arc fill } def
%
/EndDot { % DS is the dot size 
  { /z DS def } { /z 0 def } ifelse  	% outer or inner dimen 
  /b ED 				% the color definition
  0 z DS SD 
  b { 0 z DS CLW sub SD } if 
  0 DS z add CLW 4 div sub 
  moveto 
} def
%
/Shadow { [ { /moveto load } { /lineto load } { /curveto load } {
  /closepath load } /pathforall load stopped { pop pop pop pop CP /moveto
  load } if ] cvx newpath 3 1 roll T exec } def
%
/NArray { % holds the coordinates and on top of stack the showpoints boolean
  /showpoints ED 
  counttomark 2 div dup cvi /n ED  	% n 2 div on stack 
  n eq not { exch pop } if		% even numbers of points? delete one
  ] aload /Points ED 
  showpoints not { Points aload pop } if
%    { ] aload /Points ED } 
%    { n 2 mul 1 add -1 roll pop } ifelse	% delete the mark symbol 
} def
%
/Line { 
  NArray n 0 eq not 
    { n 1 eq { 0 0 /n 2 def } if ArrowA /n n 2 sub def 
      n { Lineto } repeat 
      CP 4 2 roll ArrowB L pop pop 
    } if 
} def
%
/LineToYAxis {
  /Ox ED		% Save the x origin value 
  NArray            % all x-y pairs on stack
  n { 2 copy moveto % go to current point
    Ox exch Lineto   % line to y-axis
    pop             % delete old x-value
  } repeat
} def
%
/LineToXAxis{
  /Oy ED		% Save the y origin value 
  NArray		% all x-y pairs on stack
  n 0 eq not
    { n 1 eq { 0 0 /n 2 def } if
      ArrowA
      /n n 2 sub def
      CP 2 copy moveto pop Oy Lineto
      n { 2 copy moveto pop Oy Lineto } repeat
      CP
      4 2 roll
      ArrowB
      2 copy moveto pop Oy
      L
      pop pop } if
} def
%
/Arcto { 
  /a [ 6 -2 roll ] cvx def 
  a r 
  /arcto load stopped { 5 } { 4 } ifelse { pop } repeat 
  a 
} def
%
/CheckClosed { 
  dup n 2 mul 1 sub index eq 2 index n 2 mul 1 add index eq
  and { pop pop /n n 1 sub def } if 
} def
%
/Polygon { 
  NArray n 2 eq { 0 0 /n 3 def } if 
  n 3 lt 
    { n { pop pop } repeat } 
    { n 3 gt { CheckClosed } if 
      n 2 mul -2 roll 
      /y0 ED /x0 ED /y1 ED /x1 ED  
      x1 y1 
      /x1 x0 x1 add 2 div def 
      /y1 y0 y1 add 2 div def 
      x1 y1 moveto 
      /n n 2 sub def 
      n { Lineto } repeat 
      x1 y1 x0 y0 6 4 roll Lineto
      Lineto pop pop closepath } ifelse 
} def
%
/SymbolPolygon {   % on stack [ x y x y ...
  counttomark 					% number of elements
  2 add /m ED
  2 copy m 2 roll				% copy last two
  m 2 div cvi /n ED    				% n pairs
  /YA ED /XA ED					% the start point
  n 1 sub { 
    /YB ED /XB ED
    /XLength XB XA sub def
    /YLength YB YA sub def
    /PAngle YLength XLength Atan def
    /XYLength XLength YLength Pyth def
    /nSym XYLength SymStep Div cvi def
    /Shift Symbol stringwidth pop 2 Div def 
    /deltaX XLength nSym Div def
    /deltaY YLength nSym Div def
    XA Shift sub YA Shift sub moveto 
    nSym { 
      gsave rotateSymbol { PAngle 180 sub CorrAngle sub rotate } if
      Symbol show 
      grestore 
      deltaX deltaY rmoveto
    } repeat
%    XB Shift sub YB Shift sub moveto Symbol show
    /YA YB def /XA XB def
  } repeat 
  pop	% delete the mark symbol
} def
%
/Diamond { 
  /mtrx CM def 
  T rotate 
  /h ED 
  /w ED 
  dup 0 eq { pop } { CLW mul neg 
    /d ED 
    /a w h Atan def 
    /h d a sin Div h add def 
    /w d a cos Div w add def } ifelse 
  mark w 2 div h 2 div w 0 0 h neg w neg 0 0 h w 2 div h 2 div 
  /ArrowA { moveto } def 
  /ArrowB { } def 
  false Line 
  closepath mtrx setmatrix } def
%
/Triangle { 
  /mtrx CM def 
  translate 
  rotate /h ED 2 div /w ED 
  dup CLW mul /d ED 
  /h h d w h Atan sin Div sub def 
  /w w d h w Atan 2 div dup cos exch sin Div mul sub def 
  mark 
  0 d w neg d 0 h w d 0 d 
  /ArrowA { moveto } def 
  /ArrowB { } def 
  false 
  Line 
  closepath 
  mtrx
% DG/SR modification begin - Jun.  1, 1998 - Patch 3 (from Michael Vulis)
% setmatrix } def
  setmatrix pop 
} def
% DG/SR modification end
%
/CCA { 
  /y ED /x ED 
  2 copy y sub /dy1 ED 
  x sub /dx1 ED 
  /l1 dx1 dy1 Pyth def 
} def
%
/CC { 
  /l0 l1 def 
  /x1 x dx sub def 
  /y1 y dy sub def 
  /dx0 dx1 def 
  /dy0 dy1 def 
  CCA 
  /dx dx0 l1 c exp mul dx1 l0 c exp mul add def 
  /dy dy0 l1 c exp mul dy1 l0 c exp mul add def 
  /m dx0 dy0 Atan dx1 dy1 Atan sub 2 div cos abs b exp a mul dx dy Pyth Div 2 div def 
  /x2 x l0 dx mul m mul sub def
  /y2 y l0 dy mul m mul sub def 
  /dx l1 dx mul m mul neg def 
  /dy l1 dy mul m mul neg def 
} def
%
/IC { 
  /c c 1 add def 
  c 0 lt { /c 0 def } { c 3 gt { /c 3 def } if } ifelse 
  /a a 2 mul 3 div 45 cos b exp div def 
  CCA 
  /dx 0 def 
  /dy 0 def 
} def
%
/BOC { IC CC x2 y2 x1 y1 ArrowA CP 4 2 roll x y curveto } def
/NC { CC x1 y1 x2 y2 x y curveto } def
/EOC { x dx sub y dy sub 4 2 roll ArrowB 2 copy curveto } def
/BAC { IC CC x y moveto CC x1 y1 CP ArrowA } def
/NAC { x2 y2 x y curveto CC x1 y1 } def
/EAC { x2 y2 x y ArrowB curveto pop pop } def
%
/OpenCurve { 
  NArray n 3 lt 
    { n { pop pop } repeat } 
    { BOC /n n 3 sub def n { NC } repeat EOC } ifelse 
} def
%
/CurvePath { 
  %% for negative SymStep we calculate the distance 
  SymStep 0 lt { gsave PathLength SymStep div abs /SymStep ED grestore } if
  0.5 setflat
  flattenpath /z 0 def /z0 0 def
  { /y1 ED /x1 ED /y2 y1 def /x2 x1 def 
    x1 Shift sub y1 Shift sub moveto 
    gsave 
    curveticks 
      { x1 y1 translate startAngle rotate 
        0 SymbolWidth 2 div moveto 0 SymbolWidth 2 div neg lineto 
        SymbolLinewidth setlinewidth stroke      
      }
      { startAngle rotate Symbol show }
    ifelse 
    grestore /z0 z def }
  { /y ED /x ED PathLength@ z z0 sub SymStep ge {
      x Shift sub y Shift sub moveto 
      gsave 
      curveticks 
        { y yOld sub x xOld sub Atan 180 sub CorrAngle sub /rotAngle ED  
          x y translate rotAngle rotate 
          0 SymbolWidth 2 div moveto 0 SymbolWidth 2 div neg lineto 
          SymbolLinewidth setlinewidth stroke
        }
        { 
          rotateSymbol { y yOld sub x xOld sub Atan 180 sub CorrAngle sub rotate } if        
          Symbol show 
        }
      ifelse 
      grestore /z0 z def } if 
    /yOld y def /xOld x def } 
  {} %% the lineto part
  { /y y2 def /x x2 def PathLength@ 
    x Shift sub y Shift sub moveto 
    gsave
    curveticks 
      { y yOld sub x xOld sub Atan 180 sub /rotAngle ED  
        x y translate rotAngle rotate 
        0 SymbolWidth 2 div moveto 0 SymbolWidth 2 div neg lineto 
        SymbolLinewidth setlinewidth stroke
      }
      { 
        x Shift sub y Shift sub moveto 
        rotateSymbol { y yOld sub x xOld sub Atan 180 sub CorrAngle sub rotate } if        
        Symbol show 
      }
    ifelse 
    grestore
  }
  pathforall 
%  curveticks 
%   { gsave 
%     x y translate rotAngle rotate 
%     0 SymbolWidth 2 div moveto 0 SymbolWidth 2 div neg lineto 
%     SymbolLinewidth setlinewidth stroke grestore
%   } if
  z 
} def
%
/OpenSymbolCurve { 
  OpenCurve
  0.1 setflat
  /Shift Symbol stringwidth pop 2 div def 
  CurvePath 
} def
%
/AltCurve { 
  { false NArray n 2 mul 2 roll 
    [ n 2 mul 3 sub 1 roll ] aload
    /Points ED 
    n 2 mul -2 roll } 
  { false NArray } ifelse 
  n 4 lt { n { pop pop } repeat } { BAC /n n 4 sub def n { NAC } repeat EAC } ifelse 
} def
%
/AltOpenSymbolCurve { 
  AltCurve
  0.1 setflat
  /Shift Symbol stringwidth pop 2 div def 
  CurvePath 
} def
%
/ClosedCurve { 
  NArray n 3 lt 
    { n { pop pop } repeat } 
    { n 3 gt { CheckClosed } if 
      6 copy n 2 mul 6 add 6 roll 
      IC CC x y moveto n { NC } repeat 
      closepath pop pop 
    } ifelse 
} def
%
/ClosedSymbolCurve { 
  ClosedCurve
  0.1 setflat
  /Shift Symbol stringwidth pop 2 div def 
  CurvePath 
} def
%
/SQ { /r ED r r moveto r r neg L r neg r neg L r neg r L fill } def
/ST { /y ED /x ED x y moveto x neg y L 0 x L fill } def
/SP { /r ED gsave 0 r moveto 4 { 72 rotate 0 r L } repeat fill grestore } def
%
/FontDot { 
  DS 2 mul dup 
  matrix scale matrix concatmatrix exch matrix
  rotate matrix concatmatrix exch 
  findfont exch makefont setfont 
} def
%
/Rect { 
  x1 y1 y2 add 2 div moveto 
  x1 y2 lineto 
  x2 y2 lineto 
  x2 y1 lineto
  x1 y1 lineto 
  closepath 
} def
%
/OvalFrame { 
  x1 x2 eq y1 y2 eq or 
    { pop pop x1 y1 moveto x2 y2 L } 
    { y1 y2 sub abs x1 x2 sub abs 2 copy gt 
      { exch pop } { pop } ifelse 
      2 div exch { dup 3 1 roll mul exch } if 
      2 copy lt { pop } { exch pop } ifelse
      /b ED 
      x1 y1 y2 add 2 div moveto 
      x1 y2 x2 y2 b arcto 
      x2 y2 x2 y1 b arcto
      x2 y1 x1 y1 b arcto 
      x1 y1 x1 y2 b arcto 
      16 { pop } repeat 
      closepath 
    } ifelse 
} def
%
/Frame { 
  CLW mul /a ED 
  3 -1 roll 
  2 copy gt { exch } if 
  a sub /y2 ED 
  a add /y1 ED 
  2 copy gt { exch } if 
  a sub /x2 ED 
  a add /x1 ED 
  1 index 0 eq { pop pop Rect } { OvalFrame } ifelse 
} def
%
/BezierNArray { 
  /f ED 
  counttomark 2 div dup cvi /n ED 
  n eq not { exch pop } if 
  n 1 sub neg 3 mod 3 add 3 mod { 0 0 /n n 1 add def } repeat 
  f { ] aload /Points ED } { n 2 mul 1 add -1 roll pop } ifelse 
} def
%
/OpenBezier { 
  BezierNArray 
  n 1 eq 
    { pop pop } 
    { ArrowA n 4 sub 3 idiv 
      { 6 2 roll 4 2 roll curveto } repeat 
      6 2 roll 4 2 roll ArrowB curveto } ifelse 
} def
%
/OpenSymbolBezier { 
  OpenBezier
  0.1 setflat
  /Shift Symbol stringwidth pop 2 div def 
  CurvePath 
} def
%
/ClosedBezier { 
  BezierNArray 
  n 1 eq 
    { pop pop } 
    { moveto n 1 sub 3 idiv 
      { 6 2 roll 4 2 roll curveto } repeat 
      closepath } ifelse 
} def
%
/ClosedSymbolBezier { 
  /f ED				 % save showpoints value 
  2 copy /yEnd ED /xEnd ED
  counttomark -2 roll 2 copy /yStart ED /xStart ED
  counttomark 2 roll
  f
  ClosedBezier
  0.1 setflat
  /Shift Symbol stringwidth pop 2 div def 
  CurvePath 
  [ xEnd yEnd xStart yStart SymbolLine 
} def
%
/BezierShowPoints { 
  gsave 
  Points aload length 2 div cvi /n ED 
  moveto 
  n 1 sub { lineto } repeat 
  CLW 2 div SLW [ 4 4 ] 0 setdash stroke 
  grestore 
} def
%
/Parab { 
  /y0 ED /x0 ED /y1 ED /x1 ED 
  /dx x0 x1 sub 3 div def 
  /dy y0 y1 sub 3 div def 
  x0 dx sub y0 dy add x1 y1 ArrowA
  x0 dx add y0 dy add x0 2 mul x1 sub y1 ArrowB 
  curveto 
  /Points [ x1 y1 x0 y0 x0 2 mul x1 sub y1 ] def 
} def
%
/Parab1 { % 1 end  |  0 SP
  /ySP ED /xSP ED /y1 ED /x1 ED 
  /dx xSP x1 sub 3 div def 
  /dy ySP y1 sub 3 div def 
  newpath x1 y1 moveto xSP y1 lineto xSP ySP lineto 
                       x1 ySP lineto closepath clip 
  currentpoint
  newpath moveto
  xSP dx sub ySP dy add x1 y1 ArrowA
  xSP dx add ySP dy add xSP 2 mul x1 sub y1 ArrowB 
  curveto 
  /Points [ x1 y1 xSP ySP xSP 2 mul x1 sub y1 ] def 
} def
%
/Grid { 
  newpath 
  /a 4 string def 
  /b ED % 				psk@gridlabels in pt
  /c ED % 				{ \pst@usecolor\psgridlabelcolor }
  /n ED % 				psk@griddots
  cvi dup 1 lt { pop 1 } if 
  /s ED % 				\psk@subgriddiv
  s div dup 0 eq { pop 1 } if 
  /dy ED s div dup 0 eq { pop 1 } if %	\pst@number\psyunit abs
  /dx ED dy div round dy mul %		\pst@number\psxunit abs
  /y0 ED dx div round dx mul 
  /x0 ED dy div round cvi 
  /y2 ED dx div round cvi 
  /x2 ED dy div round cvi 
  /y1 ED dx div round cvi 
  /x1 ED 
  /h y2 y1 sub 0 gt { 1 } { -1 } ifelse def 
  /w x2 x1 sub 0 gt { 1 } { -1 } ifelse def 
  b 0 gt { 
    /z1 b 4 div CLW 2 div add def
%    /Helvetica findfont b scalefont setfont 
    /b b .95 mul CLW 2 div add def } if 
  systemdict /setstrokeadjust known 
    { true setstrokeadjust /t { } def }
    { /t { transform 0.25 sub round 0.25 add exch 0.25 sub round 0.25 add
       exch itransform } bind def } ifelse 
  gsave n 0 gt { 1 setlinecap [ 0 dy n div ] dy n div 2 div setdash } { 2 setlinecap } ifelse 
  /i x1 def 
  /f y1 dy mul n 0 gt { dy n div 2 div h mul sub } if def 
  /g y2 dy mul n 0 gt { dy n div 2 div h mul add } if def 
  x2 x1 sub w mul 1 add dup 1000 gt { pop 1000 } if 
  { i dx mul dup y0 moveto 
    b 0 gt 
      { gsave c i a cvs dup stringwidth pop 
        /z2 ED w 0 gt {z1} {z1 z2 add neg} ifelse 
	h 0 gt {b neg}{z1} ifelse 
        rmoveto show grestore } if 
    dup t f moveto 
    g t L stroke 
    /i i w add def 
  } repeat 
  grestore 
  gsave 
  n 0 gt
  % DG/SR modification begin - Nov. 7, 1997 - Patch 1
  %{ 1 setlinecap [ 0 dx n div ] dy n div 2 div setdash }
    { 1 setlinecap [ 0 dx n div ] dx n div 2 div setdash }
  % DG/SR modification end
    { 2 setlinecap } ifelse 
  /i y1 def 
  /f x1 dx mul n 0 gt { dx n div 2 div w mul sub } if def 
  /g x2 dx mul n 0 gt { dx n div 2 div w mul add } if def 
  y2 y1 sub h mul 1 add dup 1000 gt { pop 1000 } if 
  { newpath i dy mul dup x0 exch moveto 
    b 0 gt { gsave c i a cvs dup stringwidth pop 
      /z2 ED 
      w 0 gt {z1 z2 add neg} {z1} ifelse 
      h 0 gt {z1} {b neg} ifelse 
      rmoveto show grestore } if 
    dup f exch t moveto 
    g exch t L stroke 
    /i i h add def 
  } repeat 
  grestore 
} def
%
/ArcArrow { 
  /d ED /b ED /a ED 
  gsave 
  newpath 0 -1000 moveto clip 
  newpath 
  0 1 0 0 b 
  grestore 
  c mul 
  /e ED 
  pop pop pop r a e d PtoC y add exch x add
  exch r a PtoC y add exch x add exch b pop pop pop pop a e d CLW 8 div c
  mul neg d 
} def
%
/Ellipse { 
  /rotAngle ED
  /mtrx CM def 
  T 
  rotAngle rotate
  scale 0 0 1 5 3 roll arc 
  mtrx setmatrix 
} def
%
/ArcAdjust { %%%% Vincent Guirardel
% given a target length (targetLength) and an initial angle (angle0) [in the stack],
% let  M(angle0)=(rx*cos(angle0),ry*sin(angle0))=(x0,y0).
% This computes an angle t such that (x0,y0) is at distance 
% targetLength from the point M(t)=(rx*cos(t),ry*sin(t)).
% NOTE: this an absolute angle, it does not have to be added or substracted to angle0
% contrary to TvZ's code.
% To achieve, this, one iterates the following process: start with some angle t,
% compute the point M' at distance targetLength of (x0,y0) on the semi-line [(x0,y0) M(t)].
% Now take t' (= new angle) so that (0,0) M(t') and M' are aligned.
%
% Another difference with TvZ's code is that we need d (=add/sub) to be defined.
% the value of d = add/sub is used to know on which side we have to move.
% It is only used in the initialisation of the angle before the iteration.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input stack:  1: target length 2: initial angle
% variables used : rx, ry, d (=add/sub)
%
  /targetLength ED /angle0 ED
  /x0 rx angle0 cos mul def
  /y0 ry angle0 sin mul def
% we are looking for an angle t such that (x0,y0) is at distance targetLength 
% from the point M(t)=(rx*cos(t),ry*sin(t)))
%initialisation of angle (using 1st order approx = TvZ's code)
  targetLength 57.2958 mul
  angle0 sin rx mul dup mul
  angle0 cos ry mul dup mul
  add sqrt div 
% if initialisation angle is two large (more than 90 degrees) set it to 90 degrees
% (if the ellipse is very curved at the point where we draw the arrow, %
% the value can be much more than 360 degrees !)
% this should avoid going on the wrong side (more than 180 degrees) or go near
% a bad attractive point (at 180 degrees)
  dup 90 ge { pop 90 } if 
  angle0 exch d % add or sub
% maximum number of times to iterate the iterative procedure:
% iterative procedure: takes an angle t on top of stack, computes a 
% better angle (and put it on top of stack)
  30 { dup
% compute distance D between (x0,y0) and M(t)
    dup cos rx mul x0 sub dup mul exch sin ry mul y0 sub dup mul add sqrt
% if D almost equals targetLength, we stop
    dup targetLength sub abs 1e-5 le { pop exit } if
% stack now contains D t
% compute the point M(t') at distance targetLength of (x0,y0) on the semi-line [(x0,y0) M(t)]:
% M(t')= ( (x(t)-x0)*targetLength/d+x0 , (y(t)-y0)*targetLength/d+y0 )
    exch dup cos rx mul x0 sub  exch sin ry mul y0 sub
% stack contains:  y(t)-y0, x(t)-x0, d
    2 index Div targetLength mul y0 add ry Div exch
    2 index Div targetLength mul x0 add rx Div
% stack contains x(t')/rx , y(t')/ry , d
% now compute t', and remove D from stack
    atan exch pop
  } repeat
% we don't look at what happened... in particular, if targetLength is greater 
% than the diameter of the ellipse...
% the final angle will be around /angle0 + 180. maybe we should treat this pathological case...
% after iteration, stack contains an angle t such that M(t) is the tail of the arrow
% to give back the result as a an angle relative to angle0 we could add the following line:
% angle0 sub 0 exch d
%
% begin bug fix 2006-01-11
% we want to adjust the new angle t' by a multiple of 360 so that  | t'-angle0 | <= 180
%(we don't want to make the ellipse turn more or less than it should)...
dup angle0 sub dup abs 180 gt { 180 add 360 div floor 360 mul sub } { pop } ifelse
% end bug fix
} def
%
/EllipticArcArrow {
  /d ED      % is add or sub
  /b ED      % arrow procedure
  /a1 ED     % angle
  gsave
  newpath
  0 -1000 moveto
  clip                  % Set clippath far from arrow.
  newpath
  0 1 0 0 b             % Draw arrow to determine length.
  grestore
% Length of arrow is on top of stack. Next 3 numbers are junk.
%
  a1 exch ArcAdjust   % Angular position of base of arrow.
  /a2 ED
  pop pop pop
  a2 cos rx mul xOrig add % hv 2007-08-29   x->xOrig
  a2 sin ry mul yOrig add % hv 2007-08-29   y->yOrig
  a1 cos rx mul xOrig add % 
  a1 sin ry mul yOrig add % 
% Now arrow tip coor and base coor are on stack.
  b pop pop pop pop       % Draw arrow, and discard coordinates.
  a2 CLW 8 div
% change value of d (test it by looking if  `` 1 1 d '' gives 2 or not )
  1 1 d 2 eq { /d { sub } def } { /d { add } def } ifelse
  ArcAdjust
% resets original value of d
  1 1 d 2 eq { /d { sub } def } { /d { add } def } ifelse  % Adjust angle to give overlap.
} def
%%------------------ tvz/DG/hv (2004-05-10) end -------------------%%
%
/Rot { CP CP translate 3 -1 roll neg rotate NET  } def
%
/RotBegin { 
  tx@Dict /TMatrix known not { /TMatrix { } def /RAngle { 0 } def } if 
  /TMatrix [ TMatrix CM ] cvx def 
  /a ED 
  a Rot /RAngle [ RAngle dup a add ] cvx def 
} def
%
/RotEnd { 
  /TMatrix [ TMatrix setmatrix ] cvx def 
  /RAngle [ RAngle pop ] cvx def 
} def
%
/PutCoor { gsave CP T CM STV exch exec moveto setmatrix CP grestore } def
/PutBegin { /TMatrix [ TMatrix CM ] cvx def CP 4 2 roll T moveto } def
/PutEnd { CP /TMatrix [ TMatrix setmatrix ] cvx def moveto } def
%
/Uput { 
  /a ED 
  add 2 div /h ED 2 
  div /w ED 
  /s a sin def 
  /c a cos def 
  /b s abs c abs 2 copy gt dup 
    /q ED 
    { pop } { exch pop } ifelse def 
  /w1 c b div w mul def 
  /h1 s b div h mul def 
  q { w1 abs w sub dup c mul abs }{ h1 abs h sub dup s mul abs } ifelse 
} def
%
/UUput { 
  /z ED 
  abs /y ED 
  /x ED 
  q { x s div c mul abs y gt }{ x c div s mul abs y gt } ifelse 
    { x x mul y y mul sub z z mul add sqrt z add } 
    { q { x s div } { x c div } ifelse abs 
    } ifelse 
  a PtoC 
  h1 add exch 
  w1 add exch 
} def
%
/BeginOL { 
  dup (all) eq exch TheOL eq or 
    { IfVisible not { Visible /IfVisible true def } if } 
    { IfVisible { Invisible /IfVisible false def } if } ifelse 
} def
%
/InitOL { 
  /OLUnit [ 3000 3000 matrix defaultmatrix dtransform ] cvx def
  /Visible { CP OLUnit idtransform T moveto } def 
  /Invisible { CP OLUnit neg exch neg exch idtransform T moveto } def 
  /BOL { BeginOL } def
  /IfVisible true def 
} def
%
%%%%%%%%%%%%%%%%% tools %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ### bubblesort ###
%% syntax : array bubblesort --> array2 trie par ordre croissant
%% code de Bill Casselman
%% http://www.math.ubc.ca/people/faculty/cass/graphics/text/www/
/bubblesort {
4 dict begin
   /a exch def
   /n a length 1 sub def
   n 0 gt {
      % at this point only the n+1 items in the bottom of a remain to
      % the sorted largest item in that blocks is to be moved up into
      % position n
      n {
         0 1 n 1 sub {
            /i exch def
            a i get a i 1 add get gt {
               % if a[i] > a[i+1] swap a[i] and a[i+1]
               a i 1 add
               a i get
               a i a i 1 add get
               % set new a[i] = old a[i+1]
               put
               % set new a[i+1] = old a[i]
               put
            } if
         } for
         /n n 1 sub def
      } repeat
   } if
   a
end
} def
%
%
/concatstringarray{  %  [(a) (b) ... (z)] --> (ab...z)  20100422
  0 1 index { length add } forall 
  string     
  0 3 2 roll      
  { 3 copy putinterval length add }forall 
  pop  
} bind def
%
/dot2comma {% on stack a string (...) 
  2 dict begin
  /Output exch def
  0 1 Output length 1 sub { 
    /Index exch def 
    Output Index get 46 eq { Output Index 44 put } if 
  } for
  Output
  end
} def
%
end
%-----------------------------------------------------------------------------%
%
% END pstricks.pro
