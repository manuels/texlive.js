%% $Id: pst-3d.pro 247 2010-01-04 22:45:42Z herbert $
% PostScript prologue for pst-3d.tex.
% Version 0.01, 2010/01/01 
%
/tx@3Ddict 300 dict def 
tx@3Ddict begin
%
/SetMatrixThreeD {
  dup sin /e ED cos /f ED
  /p3 ED /p2 ED /p1 ED
  p1 0 eq
  { /a 0 def /b p2 0 le { 1 } { -1 } ifelse def
    p3 p2 abs
  }
  { p2 0 eq
    { /a p1 0 lt { -1 } { 1 } ifelse def /b 0 def
      p3 p1 abs
    }
    { p1 dup mul p2 dup mul add sqrt dup
      p1 exch div /a ED
      p2 exch div neg /b ED
      p3 p1 a div
    }
    ifelse
  }
  ifelse
  atan dup sin /c ED cos /d ED
  /Matrix3D
  [
    b f mul c a mul e mul sub
    a f mul c b mul e mul add
    d e mul
    b e mul neg c a mul f mul sub
    a e mul neg c b mul f mul add
    d f mul
  ] def
} def
%
/ProjThreeD {
  /z ED /y ED /x ED
  Matrix3D aload pop
  z mul exch y mul add exch x mul add
  4 1 roll
  z mul exch y mul add exch x mul add
  exch
} def
%
/SetMatrixEmbed {
  SetMatrixThreeD
  Matrix3D aload pop
  /z3 ED /z2 ED /z1 ED /x3 ED /x2 ED /x1 ED
  SetMatrixThreeD
  [
  Matrix3D aload pop
  z3 mul exch z2 mul add exch z1 mul add 4 1 roll
  z3 mul exch z2 mul add exch z1 mul add
  Matrix3D aload pop
  x3 mul exch x2 mul add exch x1 mul add 4 1 roll
  x3 mul exch x2 mul add exch x1 mul add
  3 -1 roll 3 -1 roll 4 -1 roll 8 -3 roll 3 copy
  x3 mul exch x2 mul add exch x1 mul add 4 1 roll
  z3 mul exch z2 mul add exch z1 mul add
  ]
  concat
} def
%
/TMSave {
  tx@Dict /TMatrix known not { /TMatrix { } def /RAngle { 0 } def } if 
  /TMatrix [ TMatrix CM ] cvx def 
} def
%
/TMRestore { CP /TMatrix [ TMatrix setmatrix ] cvx def moveto } def
%
/TMChange {
  TMSave
  /cp [ currentpoint ] cvx def % ??? Check this later.
  CM
  CP T STV
  CM matrix invertmatrix    % Inv(M')
  matrix concatmatrix       % M Inv(M')
  exch exec
  concat cp moveto
} def
%
end % of tx@3Ddict
%%
%% End of file `pst-3d.pro'.
