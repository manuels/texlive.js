% $Id: pst-dots.pro 130 2009-08-27 08:55:03Z herbert $
%
%% PostScript prologue for pstricks.tex.
%% Version 2.02,  2009/06/16
%%
%% For distribution, see pstricks.tex.
%%
%% Timothy Van Zandt <tvz@Princeton.EDU>
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% Modified by Etienne Riga  - Dec. 16, 1999
%% Modified by Etienne Riga  - 2005/01/01 (er)
%% to add /Diamond, /SolidDiamond and /BoldDiamond
%% Modified by Herbert Voss (hv) - 2008/04/17 
%
10 dict dup begin			% hold local
  /FontType 3 def
  /FontMatrix [.001 0 0 .001 0 0] def
%  /FontBBox [-571.5 -742.5 571.5 742.5] def % changed to next line 20060616 hv
  /FontBBox [-1000 -1000 1000 1000] def  % See end of file in /BuildGlyph
  /Encoding 256 array def
  0 1 255 {Encoding exch /.notdef put} for % fill the array with /.notdef
  Encoding				   % replace with given dot names
    dup (b) 0 get /Bullet put		   % get the numerical position of b in ASCII
%					   % and save /Bullet at this place in Encoding 
    dup (c) 0 get /Circle put
    dup (C) 0 get /BoldCircle put	% 67
    dup (u) 0 get /SolidTriangle put
    dup (t) 0 get /Triangle put
    dup (T) 0 get /BoldTriangle put
    dup (r) 0 get /SolidSquare put
    dup (s) 0 get /Square put
    dup (S) 0 get /BoldSquare put
    dup (q) 0 get /SolidPentagon put
    dup (p) 0 get /Pentagon put
    dup (P) 0 get /BoldPentagon put
%%%		  
    dup (k) 0 get /Asterisk put
    dup (K) 0 get /BoldAsterisk put
    dup (J) 0 get /SolidAsterisk put
    dup (h) 0 get /Hexagon put
    dup (H) 0 get /BoldHexagon put
    dup (G) 0 get /SolidHexagon put
    dup (f) 0 get /Octogon put		% 2008-04-18 hv
    dup (F) 0 get /BoldOctogon put	% 2008-04-18 hv
    dup (g) 0 get /SolidOctogon put	% 2008-04-18 hv
    dup (a) 0 get /Add put
    dup (A) 0 get /BoldAdd put 		% 65
    dup (x) 0 get /Mul put
    dup (X) 0 get /BoldMul put
    dup (m) 0 get /Oplus put
    dup (M) 0 get /BOplus put
    dup (e) 0 get /SolidOplus put
    dup (n) 0 get /Otimes put
    dup (N) 0 get /BOtimes put
    dup (E) 0 get /SolidOtimes put
    dup (i) 0 get /Bar put
    dup (I) 0 get /BoldBar put
    dup (l) 0 get /SolidDiamond put
    dup (d) 0 get /Diamond put
        (D) 0 get /BoldDiamond put
%%%  
/CharProcs 47 dict def
CharProcs begin
  /CirclePath {0 0 500 0 360 arc closepath} def
  /Bullet {CirclePath fill} def
  /Circle {CirclePath .9 .9 scale CirclePath eofill} def
  /BoldCircle {CirclePath .8 .8 scale CirclePath eofill} def
  /TrianglePath {0 660 moveto -571.5 -330 lineto 571.5 -330 lineto closepath} def
  /SolidTriangle {TrianglePath fill} def
  /Triangle {TrianglePath .85 .85 scale TrianglePath eofill} def
  /BoldTriangle {TrianglePath .7 .7 scale TrianglePath eofill} def
  /SquarePath {-450 450 moveto 450 450 lineto 450 -450 lineto -450 -450 lineto closepath} def
  /SolidSquare {SquarePath fill} def
  /Square {SquarePath .89 .89 scale SquarePath eofill} def
  /BoldSquare {SquarePath .78 .78 scale SquarePath eofill} def
  /PentagonPath {
    -337.8 -465 moveto 337.8 -465 lineto 546.6 177.6 lineto
    0 574.7 lineto -546.6 177.6 lineto closepath
  } def
  /SolidPentagon {PentagonPath fill} def
  /Pentagon {PentagonPath .89 .89 scale PentagonPath eofill} def
  /BoldPentagon {PentagonPath .78 .78 scale PentagonPath eofill} def
%-------------- hv begin 2004/07/25   from: er 2003/03/24
  /HexagonPath {
    0 550 moveto -476 275 lineto -476 -275 lineto
    0 -550 lineto 476 -275 lineto 476 275 lineto closepath
  } def
  /SolidHexagon {HexagonPath fill} def
  /Hexagon {HexagonPath .89 .89 scale HexagonPath eofill} def
  /BoldHexagon {HexagonPath .79 .79 scale HexagonPath eofill} def
%					2008-04-18 hv
  /OctogonPath { 
     550 dup 22.5 tan mul dup neg dup add /xMove exch def 
     exch moveto 7 { xMove 0 rlineto 45 rotate } repeat closepath } def 
  /SolidOctogon { OctogonPath fill                             } def
  /Octogon {      OctogonPath .89 .89 scale OctogonPath eofill } def
  /BoldOctogon {  OctogonPath .79 .79 scale OctogonPath eofill } def
%
  /AsteriskPath {
    20 0 moveto 10 250 180 500 0 500 curveto
    -180 500 -10 250 -20 0 curveto closepath
  } def
  /Asterisk {
    AsteriskPath 60 rotate AsteriskPath 60 rotate AsteriskPath
    60 rotate AsteriskPath 60 rotate AsteriskPath 60 rotate AsteriskPath fill
  } def
%
  /Basterp {50 250 220 500 0 500 curveto -220 500 -50 250 -50 30 cos 100 mul curveto} def
  /BoldAsteriskPath {
    50 30 cos 100 mul moveto  Basterp
    60 rotate Basterp 60 rotate Basterp
    60 rotate Basterp 60 rotate Basterp
    60 rotate Basterp closepath
  } def
  /BoldAsterisk {BoldAsteriskPath fill} def
  /SolidAsterisk {CirclePath .9 .9 scale BoldAsteriskPath eofill} def
  /CrossPath {
    40 550 moveto -40 550 lineto -40 40 lineto -550 40 lineto
    -550 -40 lineto -40 -40 lineto -40 -550 lineto 40 -550 lineto 
    40 -40 lineto 550 -40 lineto 550 40 lineto 40 40 lineto closepath
  } def
  /BoldCrossPath {80 550 moveto -80 550 lineto -80 80 lineto -550 80 lineto
    -550 -80 lineto -80 -80 lineto -80 -550 lineto 80 -550 lineto 
    80 -80 lineto 550 -80 lineto 550 80 lineto 80 80 lineto closepath
  } def
  /Add {CrossPath fill} def
  /Mul {45 rotate CrossPath fill} def
  /BoldAdd {BoldCrossPath fill} def
  /BoldMul {45 rotate BoldCrossPath fill} def
  /Oplus {CirclePath .9 .9 scale CirclePath eofill .775 .775 scale CrossPath fill } def 
  /SolidOplus {CirclePath .775 .775 scale BoldCrossPath eofill} def 
  /BOplus {CirclePath .8 .8 scale CirclePath eofill .775 .775 scale BoldCrossPath fill} def 
  /Otimes {CirclePath .9 .9 scale CirclePath eofill 45 rotate .775 .775 scale CrossPath fill} def 
  /BOtimes {CirclePath .8 .8 scale CirclePath eofill 45 rotate .775 .775 scale BoldCrossPath fill } def 
  /SolidOtimes {CirclePath 45 rotate .775 .775 scale BoldCrossPath eofill} def 
  /BarPath {40 660 moveto -40 660 lineto -40 -660 lineto 40 -660 lineto closepath} def
  /Bar {BarPath fill} def
  /BoldBarPath {80 660 moveto -80 660 lineto -80 -660 lineto 80 -660 lineto closepath} def
  /BoldBar {BoldBarPath fill} def
  /DiamondPath {0 742.5 moveto -428.5 0 lineto 0 -742.5 lineto 428.5 0 lineto closepath} def
  /SolidDiamond {DiamondPath fill} def
  /Diamond {DiamondPath .865 .865 scale DiamondPath eofill} def
  /BoldDiamond {DiamondPath .73 .73 scale DiamondPath eofill} def
%%%
  /.notdef { } def
end
%
/BuildGlyph {
  exch
  begin 		
%  Metrics 1 index get exec 0
    0 0
%      BBoxes 3 index get exec
    -1000 -1000 1000 1000
%     -571.5 -742.5 571.5 742.5
    setcachedevice
    CharProcs begin load exec end
  end
} def
%
/BuildChar {
  1 index /Encoding get exch get
  1 index /BuildGlyph get exec
} bind def
%
end
/PSTricksDotFont exch definefont pop
%
%% end