%!
% PostScript prologue for pst-eucl.tex.
% Version 1.00 2011/08/04
% For distribution, see pstricks.tex.
%
/tx@EcldDict 40 dict def tx@EcldDict begin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Pi
/Pi 3.14159265359 def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% e
/E 2.718281828459045 def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x -> true (if |x| < 1E-6)
/ZeroEq { abs 1E-6 lt } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x1 y1 x2 y2 -> a b c (ax-by+c=0 with a^2+b^2=1)
/EqDr {
  4 copy 3 -1 roll sub 7 1 roll exch sub 5 1 roll 4 -1 roll
  mul 3 1 roll mul exch sub
  2 index dup mul 2 index dup mul add sqrt
  4 -1 roll 1 index div exch
  4 -1 roll 1 index div exch
  4 -1 roll 1 index div exch pop
} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% orthogonal projection of M1 onto (OM2)
%% x1 y1 x2 y2 -> x3 y3
/Project {
  2 copy dup mul exch dup mul add 5 1 roll 2 copy 5 -1 roll mul exch
  5 -1 roll mul add 4 -1 roll div dup 4 -1 roll mul exch 3 -1 roll mul
} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a b c (ax2+bx+c=0) -> x1 y1
/SolvTrin {
  /c exch def /b exch def /a exch def
  b dup mul a c mul 4 mul sub dup 0 lt
  { pop 0 0 } %% no solutions
  {sqrt dup b neg add a 2 mul div exch b add neg 2 a mul div }
  ifelse } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x1 y1 x2 y2 -> Dist
/ABDist { 3 -1 roll sub dup mul 3 1 roll sub dup mul add sqrt } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x1 y1 x2 y2 -> x1-x2  y1-y2
/ABVect { 3 -1 roll exch sub 3 1 roll sub exch } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x1 y1 x2 y2 x3 y3 x4 y4 -> x y
/InterLines {
  EqDr /D1c exch def /D1b exch def /D1a exch def
  EqDr /D2c exch def /D2b exch def /D2a exch def
  D1a D2b mul D1b D2a mul sub dup ZeroEq
%   { pop pop pop 0 0 } %% parallel lines  % --- hv 20110714
   { pop 0 0 } %% parallel lines             --- hv 20110714
   {
    /Det exch def
    D1b D2c mul D1c D2b mul sub Det div
    D1a D2c mul D2a D1c mul sub Det div
   } ifelse  } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a b c R -> x1 y1 x2 y2
/InterLineCircle {
  /CR exch def /Dc exch def neg /Db exch def /Da exch def
  ABVect /Vy exch def /Vx exch def
  %% Dc==0 then O belong to the line
  %% First project O on the line -> M (-ca;-cb)
  %% l'abscisse de M sur (OM) divisée par R donne le cosinus
  %Dc neg dup Db mul exch Da mul 2 copy 0 0
  %ABDist dup CR gt { pop pop pop 0 0 0 0 }
  %{ ZeroEq { pop pop Db Da } if Atan /alpha exch def
  Dc abs CR gt { 0 0 0 0 } 
  { Db neg Da neg Atan /alpha exch def
  Dc CR div dup dup mul 1 exch sub sqrt exch Atan /beta exch def
  alpha beta add dup cos CR mul exch sin CR mul
  alpha beta sub dup cos CR mul exch sin CR mul
  4 copy ABVect Vy mul 0 le exch Vx mul 0 le and
  { 4 2 roll } if } ifelse
 } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% R R' OO' -> x1 y1 x2 y2
/InterCircles {
  /OOP exch def /CRP exch def /CR exch def
  OOP dup mul CRP dup mul sub CR dup mul add OOP div 2 div
  dup dup mul CR dup mul exch sub dup
  0 lt { pop pop 0 0 0 0 } { sqrt 2 copy neg } ifelse
} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x y theta -> x' y' (rotation of theta)
/Rotate {
  dup sin /sintheta exch def cos /costheta exch def /y exch def /x exch def
  x costheta mul y sintheta mul sub
  y costheta mul x sintheta mul add
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% N -> x y
/GetNode {
  tx@NodeDict begin
    tx@NodeDict 1 index known { load GetCenter } { pop 0 0 } ifelse
  end
} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x -> ch(x)
/ch { dup Ex exch neg Ex add 2 div } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x -> sh(x)
/sh { dup Ex exch neg Ex sub 2 div } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x -> e^(x)
/Ex { E exch exp } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x f g -> x y n
/NewtonSolving {
  /g exch def /f exch def 0
  { %%% STACK: x0 n
    1 add exch %% one more loop
    dup ZeroEq
    { dup 0.0005 add fgeval
      1 index 0.0005 sub fgeval sub .001 div }
    { dup 1.0005 mul fgeval
      1 index 0.9995 mul fgeval sub .001 2 index mul div } ifelse  %%% STACK: n x0 fg'(x0)
    %%% compute x1=x0-fg(x0)/fg'(x0)
    1 index fgeval exch div dup 4 1 roll sub exch %% stack: dx x0 n
    3 -1 roll ZeroEq              %% exit if root found
    1 index 100 eq or { exit } if %% or looping for more than 100 times
  } loop
  dup 100 lt { exch dup /x exch def f } { pop 0 0 } ifelse
  3 -1 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/fgeval { /x exch def f g sub } bind def
end
% END ps-euclide.pro
