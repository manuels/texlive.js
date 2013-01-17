%!ps
% PostScript prologue for pst-coil.tex.
% Version 1.06, 2011/09/18
% For distribution, see pstricks.tex.
%
/tx@CoilDict 40 dict def tx@CoilDict begin
/CoilLoop { 
  /t ED 
  t sin AspectSin mul t 180 div AspectCos mul add t cos lineto } def
/Coil { 
  /Inc ED 
  dup sin /AspectSin ED 
  cos /AspectCos ED 
  /ArmB ED 
  /ArmA ED
  /h ED /w ED /y1 ED /x1 ED /y0 ED /x0 ED 
  x0 y0 translate y1 y0 sub x1 x0 sub 2 copy Pyth 
  /TotalLength ED 
  Atan rotate 
  /BeginAngle ArmA AspectCos Div w h mul Div 360 mul def 
  /EndAngle TotalLength ArmB sub AspectCos Div
    w h mul Div 360 mul def 
  1 0 0 0 ArrowA ArmA 0 lineto 
  /mtrx CM def 
  w h mul 2 Div w 2 Div scale BeginAngle Inc 
  EndAngle { CoilLoop } for
  EndAngle CoilLoop mtrx setmatrix TotalLength ArmB sub 0 lineto CP
% DG/SR modification begin - Jun.  2, 1998 - Patch 1 (from Michael Vulis)
% TotalLength 0 ArrowB lineto } def
  TotalLength 0 ArrowB lineto
  pop pop pop pop } def
% DG/SR modification end
%
/Sin { 
  /Func ED
  /PointsPerPeriod ED
  /ArmB ED 
  /ArmA ED
  /Amplitude ED 
  /roundValue ED
  /relativePeriod ED 
  /Periods ED 
  /y1 ED /x1 ED /y0 ED /x0 ED 
  x0 y0 translate y1 y0 sub x1 x0 sub 2 copy Pyth 
  dup /TotalLength ED
  ArmA sub ArmB sub /SinLength ED 
  Atan rotate 
  1 0 0 0 ArrowA ArmA 0 lineto 
  /mtrx CM def 
  relativePeriod 
    {} 
    { SinLength Periods div 
      roundValue dup 0 eq { pop cvi } { 1 eq { round } if } ifelse
      /Periods ED } ifelse
  /dxStep SinLength 360 div def         % the default step for x pos
  /xStep 360 PointsPerPeriod div def    % the step for the for loop
  1 xStep 360 {                         % PointsPerPeriod times
    dup dxStep mul ArmA add exch        % x pos and value for the func
    Periods mul Func Amplitude mul lineto
  } for
  mtrx setmatrix TotalLength ArmB sub 0 lineto CP
  TotalLength 0 ArrowB lineto
  pop pop pop pop 
} def
%
/AltCoil { 
  /Inc ED 
  dup sin /AspectSin ED 
  cos /AspectCos ED /h ED /w ED /EndAngle ED /BeginAngle ED 
  /mtrx CM def 
  w h mul 2 Div w 2 Div scale BeginAngle sin AspectSin mul 
  BeginAngle 180 div AspectCos mul add BeginAngle cos 
  /lineto load stopped { moveto } if 
  BeginAngle Inc EndAngle { CoilLoop } for 
  EndAngle CoilLoop mtrx setmatrix } def
/ZigZag { 15 dict begin 
  /ArmB ED /ArmA ED 
  2 div /w ED 
  w mul /h ED /y1 ED /x1 ED /y0 ED /x0 ED 
  x1 y1 translate y0 y1 sub x0 x1 sub 2 copy Pyth 
  /TotalLength ED
  Atan rotate TotalLength ArmA sub ArmB sub dup h div cvi /n ED n h mul
  sub 2 div dup ArmA add 
  /ArmA ED ArmB add 
  /ArmB ED 
  /x ArmB h 2 div add def 
  mark 0 0 ArmB 0 
  n { x w /w w neg def /x x h add def } repeat
  TotalLength ArmA sub 0 TotalLength 0 
  end } def
%
 /ZigZagCirc { % x0 y0 x1 y1 bow h w ArmA ArmB on stack
  /bow ED 
  /ArmB ED /ArmA ED 
  2 div /w ED 
  w mul /h ED /y1 ED /x1 ED /y0 ED /x0 ED 
  x1 y1 translate %
  y0 y1 sub x0 x1 sub 2 copy Pyth 2 div 
  /HalfLength ED
  Atan /ang ED %angle of A relative to B
  %rotate % so end B is origin and BA is horizontal, A to right
  /theta bow abs HalfLength Atan 2 mul def %halfangular sector for arc
  /theta2 theta 2 mul def % full arc
  %/psi ang 90 sub theta sub def % angle of B from center if bow>0
  /rho HalfLength theta sin div def % radius of circle
  bow 0 gt { /direc 1 def /thetaB ang 90 sub theta sub def } % travel B to A in pos drn
  { /direc -1 def /thetaB ang 90 add theta add def } ifelse % travel B to A in neg drn
  %thetaB=angle from center to B
  rho thetaB 180 add PtoC translate % origin now at center
  /h h rho div RadtoDeg def
  /ArmA ArmA rho div RadtoDeg def /ArmB ArmB rho div RadtoDeg def
  theta2 ArmA sub ArmB sub dup h div cvi /n ED n h mul
  %HalfLength 2 mul ArmA sub ArmB sub dup h div cvi /n ED n h mul
  sub 2 div dup ArmA add 
  /ArmA ED ArmB add /ArmB ED 
  /h h direc mul def % h is now angle increment for half-period
  /rhoo rho w add def /rhoi rho w sub def % outer and inner radii
  /arg thetaB ArmB direc mul add def % argument for 2nd point
%  thetaB = direc = bow = HalfLength = theta = rho = arg = h = n =
  mark rho thetaB  PtoC  rho arg PtoC /arg arg h 2 div add def
  n { w 0 gt { rhoo }{ rhoi } ifelse arg PtoC /w w neg def /arg arg h add def } repeat
  rho thetaB theta2 ArmA sub direc mul add  PtoC rho thetaB theta2 direc mul add PtoC  
  } def 
%
end
% END pst-coil.pro
