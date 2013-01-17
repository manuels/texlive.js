%%
%% This is file `pst-fractal.pro',
%%
%% IMPORTANT NOTICE:
%%
%% Package `pst-fractal'
%%
%% Herbert Voss <voss _at_ PSTricks.de>
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-fractal' is a PSTricks package to draw fractal objects
%%
%%
%% version 0.02 / 2010-02-10  Herbert Voss <hvoss _at_ tug.org>
%
/tx@fractalDict 20 dict def
tx@fractalDict begin
%
/tx@Fractal {
%    \pst@temp@A 
%    \pst@temp@B 
%    \pst@number\pst@fractal@xWidth
%    \pst@number\pst@fractal@yWidth
%    \pst@fractal@cx 
%    \pst@fractal@cy  
%    \pst@fractal@maxIter
%    \pst@fractal@dIter
%    \pst@fractal@maxRadius
%    {\pst@usecolor\pst@fractal@baseColor} 
%    \ifx\pst@fractal@type\pst@fractal@Julia true \else false \fi
%    \ifPst@CMYK true \else false \fi
%    tx@fractalDict begin tx@Fractal end
  /ifCMYK ED
  /ifJulia ED
  /baseColor ED
  /maxRadius ED
  /dIter ED
  /maxIter ED
  /cy ED 
  /cx ED
  /MaxYPixel ED
  /MaxXPixel ED
  /MaxY ED /MaxX ED
  /MinY ED /MinX ED
  /rPixel 0.5 def
  /totMaxIter maxIter dIter mul def
%
  /DX MaxX MinX sub def
  /DY MaxY MinY sub def
  /dx DX MaxXPixel div def /dy DY MaxYPixel div def
%
  /convertX { MinX sub DX sub dx div } def % user -> pt
  /convertY { MinY sub dy div } def        % user -> pt
  /convertXY { convertY exch convertX exch } def
%
  /putPixel {%  x y auf dem Stack in Benutzerkoordinaten
    convertXY
    rPixel 0 360 arc fill 
  } def
%
  MinX dx MaxX {
    ifJulia { /x exch def }{ /cx exch def /x 0.0 def } ifelse
    MinY dy MaxY {
      ifJulia { /y exch def }{ /cy exch def /y 0.0 def } ifelse
      /iter 0 def
      /zx x def
      /zy y def
      /plot true def
      totMaxIter cvi {
        zx dup mul zy dup mul add maxRadius gt {
         /plot false def 
         exit
        }{% Calculate next value
	  2 zx zy mul mul cy add
	  /zx zx dup mul zy dup mul sub cx add def
	  /zy exch def
	  /iter iter dIter add def
        } ifelse
      } repeat
      plot{ 
        baseColor x y putPixel 
      }{ iter 400 add tx@addDict begin 
	 ifCMYK { wavelengthToCMYK Cyan Magenta Yellow Black end setcmykcolor 
	 }{ wavelengthToRGB Red Green Blue end setrgbcolor } ifelse 
         ifJulia { x y }{ cx cy } ifelse
	 putPixel stroke
      }ifelse		% Plot point if point is in set
    } for
  } for
} def
%
/tx@Sierpinski { %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    \pst@temp@A 
%    \pst@temp@B 
%    \pst@temp@C  
%    { \pst@usecolor\pslinecolor }
%    \pst@fractal@plotpoints
  /plotpoints ED
  /setColor ED
  /Coor ED   
  /Sx 0 def /Sy 0 def
  /putPixel {	0.5 0 360 arc stroke } def % x y on stack
  /newPosition {			% point # on stack
    Coor exch 2 getinterval aload pop 
    /y exch def  /x exch def 
    x Sx sub 2 div Sx add /Sx exch def 
    y Sy sub 2 div Sy add /Sy exch def
    Sx Sy putPixel 
  } def
  /drawFrame {
    Coor aload pop
    newpath
    moveto
    nCoor 1 sub { lineto } repeat % n-1 times
    gsave 0.9 setgray fill grestore 
    setColor
    closepath
    stroke 
  } def
  /nCoor Coor length 2 div 0.5 add cvi def % # of dots
  drawFrame
  plotpoints cvi {
    rand nCoor mod 
    dup add newPosition   
  } repeat
} def
%
/tx@Phyllotaxis { %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%	\pst@tempA 
%	\pst@fractal@c 
%	\pst@fractal@angle 
%	\pst@fractal@maxIter CMYK
  /ifCMYK ED
  /maxIter ED
  /fractalAngle ED
  /c ED
  translate
  /angle fractalAngle dup 0 eq { pop 360 5 sqrt 1 add 2 div dup mul div } if def
  maxIter cvi -1 0 {
    angle rotate
    0 0 moveto
    dup sqrt c mul c lineto
    c c neg rlineto
    c neg dup rlineto
    closepath
    gsave
      1 exch maxIter cvi div 90 mul cos 0 
      ifCMYK { tx@addDict begin RGBtoCMYK end setcmykcolor }{ setrgbcolor } ifelse
      fill
    grestore
    stroke
  } for
} def
%
/tx@Fern { %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    \pst@fractal@scale 
%    \pst@tempA 
%    \pst@fractal@maxIter
%    \pst@fractal@radius
%    \pst@number\pslinewidth
%    { \pst@usecolor\pslinecolor }
  /setColor ED
  SLW
  /radius ED
  /maxIter ED  
  translate
  dup scale
  /m1 [  0.00  0.00  0.00  0.16  0.00 0.00 ] def
  /m2 [  0.85 -0.04  0.04  0.85  0.00 1.60 ] def
  /m3 [  0.20  0.23 -0.26  0.22  0.00 1.60 ] def
  /m4 [ -0.15  0.26  0.28  0.24  0.00 0.44 ] def
  1 setlinecap
  setColor
  0 0 % start point
  maxIter cvi {
  % get a transformation matrix probabilistically
  /r rand 100 mod def
  r  1 lt { /m m1 def }{ r 86 lt 
    { /m m2 def }{ r 93 lt { 
      /m m3 def }{ /m m4 def } ifelse } ifelse } ifelse
  % Make a linear transformation, then
  % plot a point at current location
   m transform 2 copy radius 0 360 arc
   stroke
  } repeat
} def
%
/tx@Kochflake { %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    \pst@tempA
%    { \pst@usecolor\pslinecolor }
%    \pst@fractal@scale
%    \pst@fractal@angle
%    CLW
%    \pst@fractal@maxIter
  /maxIter ED
  10 10 scale
  45 rotate
  /side {
    dup 0 gt { 
      1 sub 1 3 div dup scale side 60 rotate side 
      -120 rotate side 60 rotate side 3 dup scale 1 add
    }{ 1 1 rlineto 1 1 translate } ifelse 
  } def
  /star { 
    dup currentlinewidth 1 1 
    4 -1 roll { pop 3 div } for 
    setlinewidth
    0 0 moveto 
    side -120 rotate side -120 rotate side
    pop
    closepath
  } def
  maxIter star
} def
%
/tx@Appolonius { %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    \pst@fractal@dIter
%    \pst@number\pst@fractal@Radius
%    \ifPst@fractal@Color true \else false \fi
%    \ifPst@CMYK true \else false \fi
%    gsave
%    \pst@tempA translate
%    \pst@usecolor\pslinecolor
%    \pst@fractal@scale
%    \pst@number\pslinewidth SLW
%
  /ifCMYK ED
  /ifColor ED
  /Radius ED
  /dIter ED
  /icount 380 def
  /setWaveColor {
    /icount icount dup 780 gt { pop 380 }{ dIter add } ifelse def
    tx@addDict begin icount 
    ifCMYK { wavelengthToCMYK Cyan Magenta Yellow Black end setcmykcolor 
    }{ wavelengthToRGB Red Green Blue end setrgbcolor } ifelse 
  } def
  /collect { [ 4 1 roll ] } def
  /nget { exch dup 3 1 roll exch get } def
  /polydup { 1 add [ exch 1 roll ] aload aload pop } def
  /circle { aload pop newpath 0 360 arc closepath 
    ifColor { gsave setWaveColor fill grestore } if
    stroke } def
  /inverse {
     aload 4 1 roll 3 1 roll dup mul exch dup mul add exch dup mul sub
     dup 0 eq not {1 exch div} if
     exch
     aload pop
     4 -1 roll dup 5 1 roll mul 3 1 roll
     4 -1 roll dup 5 1 roll mul 3 1 roll
     4 -1 roll dup 5 1 roll mul 3 1 roll
     4 -1 roll pop
     dup 0 lt {neg} if
     collect
  } def
  /between {
     collect
     0 nget 2 get exch 1 nget 2 get exch 3 1 roll
     lt {aload pop 3 1 roll exch 3 -1 roll collect} if
     0 nget 2 get exch 2 nget 2 get exch 3 1 roll
     lt {aload pop 3 -1 roll exch 3 1 roll collect} if
     1 nget 0 get exch 2 nget 2 get exch
     2 nget 0 get exch 1 nget 2 get exch
     1 nget 2 get exch 2 nget 2 get exch
     7 1 roll add 5 1 roll mul 3 1 roll mul add exch div
     /xdisp exch def
     1 nget 1 get exch 2 nget 2 get exch
     2 nget 1 get exch 1 nget 2 get exch
     1 nget 2 get exch 2 nget 2 get exch
     7 1 roll add 5 1 roll mul 3 1 roll mul add exch div
     /ydisp exch def
     0 nget aload pop 3 1 roll ydisp sub 3 1 roll xdisp sub 3 1 roll
     collect
     inverse dup
     /first exch def
     /second exch def
     1 nget 1 get exch 2 nget 1 get exch 3 1 roll sub /xvect exch def
     2 nget 0 get exch 1 nget 0 get exch 3 1 roll sub /yvect exch def
     xvect dup mul yvect dup mul add sqrt
     dup 0.0 eq not { first 2 get 2 mul exch div} if
     dup xvect mul /xvect exch def
     yvect mul /yvect exch def
     first aload pop 3 1 roll yvect add 3 1 roll xvect add 3 1 roll
     collect
     inverse /first exch def
     second aload pop 3 1 roll yvect sub 3 1 roll xvect sub 3 1 roll
     collect
     inverse /second exch def
     first second
     first 2 get second 2 get sub
     0 gt { exch } if
     pop
     aload pop
     3 1 roll ydisp add 3 1 roll xdisp add 3 1 roll collect
     exch pop
  } def
  /appol {
     aload pop 3 polydup between
     dup circle
     2 nget CLW gt { 1 1 3 { pop 3 polydup collect 5 1 roll 4 -1 roll } for } if
     pop pop pop pop
  } def
  /inside {
     /temp exch def
     0 120 240 {
          /angle exch def
          temp aload pop
          3 sqrt 2 div 1 add div
          /radius exch def
          angle sin radius mul
          angle cos radius mul
          exch 4 -1 roll add
          3 1 roll add
          radius 3 sqrt 2 div mul
          collect
     } for
  } def
%
  [ 0 0 Radius ] dup inside 4 polydup
  1 1 4 { pop circle } for
  1 1 4 { pop 3 polydup collect 5 1 roll 4 1 roll } for
  pop pop pop pop { count 0 eq { exit } if appol } loop
} def
%
end
