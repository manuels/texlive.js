%!PS-Adobe-2.0
%%Title: Dot Font for PSTricks
%%Creator: Timothy Van Zandt <tvz@Princeton.EDU>
%%Creation Date: May 7, 1993
%% Version 97 patch 1, 99/12/16
%% Modified by Etienne Riga <etienne.riga@skynet.be> - Dec. 16, 1999
%% to add /Diamond, /SolidDiamond and /BoldDiamond
10 dict dup begin
  /FontType 3 def
  /FontMatrix [ .001 0 0 .001 0 0 ] def
  /FontBBox [ 0 0 0 0 ] def
  /Encoding 256 array def
  0 1 255 { Encoding exch /.notdef put } for
  Encoding
    dup (b) 0 get /Bullet put
    dup (c) 0 get /Circle put
    dup (C) 0 get /BoldCircle put
    dup (u) 0 get /SolidTriangle put
    dup (t) 0 get /Triangle put
    dup (T) 0 get /BoldTriangle put
    dup (r) 0 get /SolidSquare put
    dup (s) 0 get /Square put
    dup (S) 0 get /BoldSquare put
    dup (q) 0 get /SolidPentagon put
    dup (p) 0 get /Pentagon put
    dup (P) 0 get /BoldPentagon put
% DG/SR modification begin - Dec. 16, 1999 - From Etienne Riga
    dup (l) 0 get /SolidDiamond put
    dup (d) 0 get /Diamond put
        (D) 0 get /BoldDiamond put
% DG/SR modification end
  /Metrics 13 dict def
  Metrics begin
    /Bullet        1000   def
    /Circle        1000   def
    /BoldCircle    1000   def
    /SolidTriangle 1344   def
    /Triangle      1344   def
    /BoldTriangle  1344   def
    /SolidSquare    886   def
    /Square         886   def
    /BoldSquare     886   def
    /SolidPentagon 1093.2 def
    /Pentagon      1093.2 def
    /BoldPentagon  1093.2 def
% DG/SR modification begin - Dec. 16, 1999 - From Etienne Riga
    /SolidDiamond  1008   def
    /Diamond       1008   def
    /BoldDiamond   1008   def
% DG/SR modification end
    /.notdef 0 def
  end
  /BBoxes 13 dict def
  BBoxes begin
    /Circle        { -550 -550 550 550 } def
    /BoldCircle    /Circle load def
    /Bullet        /Circle load def
    /Triangle      { -571.5 -330 571.5 660 } def
    /BoldTriangle  /Triangle load def
    /SolidTriangle /Triangle load def
    /Square        { -450 -450 450 450 } def
    /BoldSquare    /Square load def
    /SolidSquare   /Square load def
    /Pentagon      { -546.6 -465 546.6 574.7 } def
    /BoldPentagon  /Pentagon load def
    /SolidPentagon /Pentagon load def
% DG/SR modification begin - Dec. 16, 1999 - From Etienne Riga
    /Diamond       { -428.5 -742.5 428.5 742.5 } def
    /BoldDiamond   /Diamond load def
    /SolidDiamond  /Diamond load def
% DG/SR modification end
    /.notdef { 0 0 0 0 } def
  end
  /CharProcs 20 dict def
  CharProcs begin
    /Adjust {
      2 copy dtransform floor .5 add exch floor .5 add exch idtransform
      3 -1 roll div 3 1 roll exch div exch scale
    } def
    /CirclePath    { 0 0 500 0 360 arc closepath } def
    /Bullet        { 500 500 Adjust CirclePath fill } def
    /Circle        { 500 500 Adjust CirclePath .9 .9 scale CirclePath
                     eofill } def
    /BoldCircle    { 500 500 Adjust CirclePath .8 .8 scale CirclePath
                     eofill } def
    /BoldCircle    { CirclePath .8 .8 scale CirclePath eofill } def
    /TrianglePath  { 0  660 moveto -571.5 -330 lineto 571.5 -330 lineto
                     closepath } def
    /SolidTriangle { TrianglePath fill } def
    /Triangle      { TrianglePath .85 .85 scale TrianglePath eofill } def
    /BoldTriangle  { TrianglePath .7 .7 scale TrianglePath eofill } def
    /SquarePath    { -450 450 moveto 450 450 lineto 450 -450 lineto
                     -450 -450 lineto closepath } def
    /SolidSquare   { SquarePath fill } def
    /Square        { SquarePath .89 .89 scale SquarePath eofill } def
    /BoldSquare    { SquarePath .78 .78 scale SquarePath eofill } def
    /PentagonPath  {
      -337.8 -465   moveto
       337.8 -465   lineto
       546.6  177.6 lineto
         0    574.7 lineto
      -546.6  177.6 lineto
      closepath
    } def
    /SolidPentagon { PentagonPath fill } def
    /Pentagon      { PentagonPath .89 .89 scale PentagonPath eofill } def
    /BoldPentagon  { PentagonPath .78 .78 scale PentagonPath eofill } def
% DG/SR modification begin - Dec. 16, 1999 - From Etienne Riga
    /DiamondPath   { 0 742.5 moveto -428.5 0 lineto 0 -742.5 lineto
                     428.5 0 lineto closepath } def
    /SolidDiamond  { DiamondPath fill } def
    /Diamond       { DiamondPath .85 .85 scale DiamondPath eofill } def
    /BoldDiamond   { DiamondPath .7 .7 scale DiamondPath eofill } def
% DG/SR modification end
    /.notdef { } def
  end
  /BuildGlyph {
    exch
    begin
      Metrics 1 index get exec 0
      BBoxes 3 index get exec
      setcachedevice
      CharProcs begin load exec end
    end
  } def
  /BuildChar {
    1 index /Encoding get exch get
    1 index /BuildGlyph get exec
  } bind def
end
/PSTricksDotFont exch definefont pop
%END pst-dots.pro
