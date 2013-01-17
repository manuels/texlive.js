%!
% $Id: pst-circ.pro 3 2007-12-23 16:23:22Z herbert $
%
% PostScript prologue for pst-circ.tex.
% version 0.01 2007-03-23 (hv)
% For distribution, see pstricks.tex.
%
/GetNode {
  tx@NodeDict begin
    tx@NodeDict 1 index known { load GetCenter } { pop 0 0 } ifelse
  end
} bind def 
/ZeroEq { abs 1E-10 lt } bind def /EqDr {
  4 copy 3 -1 roll sub 7 1 roll exch sub 5 1 roll 4 -1 roll
  mul 3 1 roll mul exch sub } bind def
/InterLines {
  EqDr /D1c exch def /D1b exch def /D1a exch def
  EqDr /D2c exch def /D2b exch def /D2a exch def
  D1a D2b mul D1b D2a mul sub dup ZeroEq
  { pop pop pop 0 0 }
  {
    /Det exch def
    D1b D2c mul D1c D2b mul sub Det div
    D1a D2c mul D2a D1c mul sub Det div
  }
  ifelse  } bind def
% END pst-circ.pro
