%% $Id: pst-3dplot.pro 298 2010-03-13 08:46:53Z herbert $
%%
%% This is file `pst-3dplot.pro',
%%
%% IMPORTANT NOTICE:
%%
%% Package `pst-3dplot.tex'
%%
%% Herbert Voss <voss _at_ PSTricks.de>
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-3dplot' is a PSTricks package to draw 3d curves and graphical objects
%%
%%
%% version 0.31 / 2010-02-20  Herbert Voss <hvoss _at_ tug.org>
%% with contributions of Darrell Lamm <darrell.lamm _at_ gtri.gatech.edu<
%%            
%
/tx@3DPlotDict 200 dict def
tx@3DPlotDict begin
%
/printDot { gsave 2 copy 2 0 360 arc fill stroke grestore } def
%
/saveCoor { 
  dzUnit mul /z ED
  dyUnit mul /y ED
  dxUnit mul /x ED
} def
%
/3Dto2D { % true or false on stack
  { RotatePoint } if
  1 { %  dummy loop, will run only 1 time, allows exit 
    coorType 0 le {                                               % the default |
      /x2D x leftHanded not { neg } if Alpha cos mul y Alpha sin mul add def %  /\  co system
      /y2D x leftHanded { neg } if Alpha sin mul y Alpha cos mul add neg Beta sin mul z Beta cos mul add def
      exit } if
    coorType 1 le { 
      /x2D y x Alpha 90 sub sin mul sub def  %  |/_  co system, no shortened x axis
      /y2D z x Alpha 90 sub cos mul sub def 
      exit } if
    coorType 2 le { % coorType |/_ with a 1/sqrt(2) shortend x-axis and 135 degrees 
      /x2D y x 0.5 mul sub def
      /y2D z x 0.5 mul sub def 
      exit } if
    coorType 3 le { % coorType |/_ with a 1/sqrt(2) shortend x-axis and 135 degrees 
      /x2D y x -0.5 mul sub def
      /y2D z x -0.5 mul sub def 
      exit } if
    coorType 4 le { % Normalbild in Trimetrie Skalierung so, dass coorType2
       /x2D x -0.5 mul y 1 mul add def
       /y2D x -0.5 mul y -0.25 mul add z 1 mul add def
       exit } if
  } repeat
} def
/ConvertTo2D { true 3Dto2D } def
/ConvertTo2DWithoutRotating { false 3Dto2D } def
%
/Conv3D2D { /z ED /y ED /x ED ConvertTo2D x2D y2D } def
%
/ConvertToCartesian {
  /latitude exch def
  /longitude exch def
  /Radius exch def
  1 { %  dummy loop, will run only 1 time, allows exit
    SphericalCoorType 0 le {                                               % the default |
     /z { Radius latitude sin mul } def
     /x { Radius longitude cos mul latitude cos mul } def
     /y { Radius longitude sin mul latitude cos mul } def
      exit } if
    SphericalCoorType 2 le {
     /z { Radius longitude cos mul } def
     /x { Radius longitude sin mul latitude cos mul} def
     /y { Radius longitude sin mul latitude sin mul } def
      exit } if
  } repeat
} def
%
/ConvCylToCartesian { % r phi h -> x y z
  3 1 roll			% h r phi
  /Phi ED
  /Radius ED			% h->z on stack
  Radius Phi cos mul exch 	% x z
  Radius Phi sin mul exch	% x y z
} def
%
/SphericalTo2D {
  x y z ConvertToCartesian ConvertTo2D
} def
%
/CylinderTo2D { %  r phi h
  x y z ConvCylToCartesian ConvertTo2D
} def
%
/convertStackTo2D {
  counttomark
  /n ED /n3 n 3 div cvi def
  n3 {
    n -3 roll
    SphericalCoor { ConvertToCartesian } { saveCoor } ifelse
    ConvertTo2D
    x2D xUnit y2D yUnit
    /n n 1 sub def
  } repeat
} def
%
% the angle in the parameter equation for an ellipse is not proportional to the real angle!
% phi=atan(b*tan(angle)/a)+floor(angle/180+0.5)*180
%
/getPhi { % on stack: vecA vecB angle 
  3 dict begin
  /angle exch def /vecB exch def /vecA exch def
  angle cvi 90 mod 0 eq { angle } { vecA angle tan mul vecB atan 
  angle 180 div .5 add floor 180 mul add } ifelse 
  end
} def
%
/RotSet (set ) def
%
/eulerRotation false def
% Matrix multiplication procedure
/matmul {

  /M@tMulDict 20 dict def
  M@tMulDict begin
  /m2 ED
  /m1 ED
  m1 dup length 2 sub 2 getinterval aload pop
  /col1max ED
  /row1max ED
  m2 dup length 2 sub 2 getinterval aload pop
  /col2max ED
  /row2max ED
  /m3 row1max col2max mul 2 add array def
  m3 dup length 2 sub row1max col2max 2 array astore putinterval
  0 1 row1max 1 sub {
   /row ED
   0 1 col2max 1 sub {
    /col ED
    /sum 0 def
    0 1 col1max 1 sub{
    /rowcol ED
    sum
    m1 row col1max mul rowcol add get
    m2 rowcol col2max mul col add get
    mul add 
    /sum ED
    } for
    m3 row col2max mul col add sum put
   } for
  } for
  m3
  end % end of M@tMulDict

} def
%
/SetMQuaternion {

  /MnewTOold 11 array def

  /Qu@ternionDict 30 dict def
  Qu@ternionDict begin

  /normRotVec  xRotVec yRotVec zRotVec 3 array astore VecNorm  def
  normRotVec 0 gt
  {/xRotVecNorm xRotVec normRotVec div def
   /yRotVecNorm yRotVec normRotVec div def
   /zRotVecNorm zRotVec normRotVec div def
   RotAngle}
  {/xRotVecNorm 1 def
   /yRotVecNorm 0 def
   /zRotVecNorm 0 def 
   0} ifelse

  2 div dup
  /q0 exch cos def
      sin dup dup
  /q1 exch xRotVecNorm mul def
  /q2 exch yRotVecNorm mul def
  /q3 exch zRotVecNorm mul def

  /q0q0 q0 q0 mul def
  /q0q1 q0 q1 mul def
  /q0q2 q0 q2 mul def
  /q0q3 q0 q3 mul def

  /q1q1 q1 q1 mul def
  /q1q2 q1 q2 mul def
  /q1q3 q1 q3 mul def

  /q2q2 q2 q2 mul def
  /q2q3 q2 q3 mul def

  /q3q3 q3 q3 mul def

  MnewTOold 0 q0q0 q1q1 add q2q2 sub q3q3 sub put
  MnewTOold 1 q1q2 q0q3 sub 2 mul put
  MnewTOold 2 q1q3 q0q2 add 2 mul put

  MnewTOold 3 q1q2 q0q3 add 2 mul put
  MnewTOold 4 q0q0 q1q1 sub q2q2 add q3q3 sub put
  MnewTOold 5 q2q3 q0q1 sub 2 mul put

  MnewTOold 6 q1q3 q0q2 sub 2 mul put
  MnewTOold 7 q2q3 q0q1 add 2 mul put
  MnewTOold 8 q0q0 q1q1 sub q2q2 sub q3q3 add put

  MnewTOold 9 3 put
  MnewTOold 10 3 put

  end % end of Qu@ternionDict

} def
%
/SetMxyz {
  1.0 0.0 0.0  0.0 1.0 0.0  0.0 0.0 1.0  3 3  11 array astore /MnewTOold ED
  RotSequence cvx exec % Now create a new MnewTOold using xyz, etc.
} def
%
/ConcatMQuaternion {
  MnewTOold % Push onto stack
  SetMQuaternion % Uses [xyz]RotVec and RotAngle to make MnewToOld 
  MnewTOold matmul /MnewTOold ED
} def
%
/ConcatMxyz {
  MnewTOold % Push onto stack
  SetMxyz % Uses RotX, etc. to set MnewTOold 
  MnewTOold matmul /MnewTOold ED
} def
%
/RotatePoint{
  MnewTOold x y z  3 1  5 array astore matmul
  0 3 getinterval aload pop 
  /z ED 
  /y ED 
  /x ED 
} def
%
/makeMoldTOnew {
  /MoldTOnew 11 array def
  MoldTOnew 0 MnewTOold 0 get put
  MoldTOnew 1 MnewTOold 3 get put
  MoldTOnew 2 MnewTOold 6 get put
  MoldTOnew 3 MnewTOold 1 get put
  MoldTOnew 4 MnewTOold 4 get put
  MoldTOnew 5 MnewTOold 7 get put
  MoldTOnew 6 MnewTOold 2 get put
  MoldTOnew 7 MnewTOold 5 get put
  MoldTOnew 8 MnewTOold 8 get put
  MoldTOnew 9               3 put
  MoldTOnew 10              3 put
} def
%
/RotXaxis { 
  eulerRotation 
  {1 0 0}
  {makeMoldTOnew MoldTOnew  1 0 0  3 1  5 array astore matmul
   0 3 getinterval aload pop} ifelse
  /zRotVec ED
  /yRotVec ED
  /xRotVec ED
  /RotAngle RotX def
  ConcatMQuaternion
} def
/RotYaxis { 
  eulerRotation 
  {0 1 0}
  {makeMoldTOnew MoldTOnew  0 1 0  3 1  5 array astore matmul
   0 3 getinterval aload pop} ifelse
  /zRotVec ED
  /yRotVec ED
  /xRotVec ED
  /RotAngle RotY def
  ConcatMQuaternion
} def
/RotZaxis { 
  eulerRotation 
  {0 0 1}
  {makeMoldTOnew MoldTOnew  0 0 1  3 1  5 array astore matmul
   0 3 getinterval aload pop} ifelse
  /zRotVec ED
  /yRotVec ED
  /xRotVec ED
  /RotAngle RotZ def
  ConcatMQuaternion
} def
/xyz { RotXaxis RotYaxis RotZaxis } def
/yxz { RotYaxis RotXaxis RotZaxis } def
/yzx { RotYaxis RotZaxis RotXaxis } def
/xzy { RotXaxis RotZaxis RotYaxis } def
/zxy { RotZaxis RotXaxis RotYaxis } def
/zyx { RotZaxis RotYaxis RotXaxis } def
/quaternion { } def % Null
%
/VecNorm { 0 exch { dup mul add } forall sqrt } def
%
/UnitVec {			% on stack is [a]; returns a vector with [a][a]/|a|=1 
  dup VecNorm /norm ED
  norm 0 lt {/norm 0 def} if
  { norm div } forall 3 array astore } def
%
/AxB {				% on the stack are the two vectors [a][b]
    aload pop /b3 ED /b2 ED /b1 ED
    aload pop /a3 ED /a2 ED /a1 ED
    a2 b3 mul a3 b2 mul sub
    a3 b1 mul a1 b3 mul sub
    a1 b2 mul a2 b1 mul sub
    3 array astore } def
%
/AaddB {			% on the stack are the two vectors [a][b]
    aload pop /b3 ED /b2 ED /b1 ED
    aload pop /a3 ED /a2 ED /a1 ED
    a1 b1 add a2 b2 add a3 b3 add
    3 array astore } def
%
/AmulC {			% on stack is [a] and c; returns [a] mul c
    /factor ED { factor mul } forall 3 array astore } def
%
%
/setColorLight { % expects 7 values on stack C M Y K xL yL zL
% les rayons de lumi�re
  xLight dup mul yLight dup mul zLight dup mul add add sqrt /NormeLight ED
% the color values
  /K ED
  /Yellow ED
  /Magenta ED
  /Cyan ED
} def
%
/facetteSphere {
  newpath
  /Xpoint Rsphere theta cos mul phi cos mul CX add def
  /Ypoint Rsphere theta sin mul phi cos mul CY add def
  /Zpoint Rsphere phi sin mul CZ add def
  Xpoint Ypoint Zpoint tx@3Ddict begin ProjThreeD end moveto
  theta 1 theta increment add {%
    /theta1 ED
    /Xpoint Rsphere theta1 cos mul phi cos mul CX add def
    /Ypoint Rsphere theta1 sin mul phi cos mul CY add def
    /Zpoint Rsphere phi sin mul CZ add def
    Xpoint Ypoint Zpoint tx@3Ddict begin ProjThreeD end  lineto
  } for
  phi 1 phi increment add {
    /phi1 ED
    /Xpoint Rsphere theta increment add cos mul phi1 cos mul CX add def
    /Ypoint Rsphere theta increment add sin mul phi1 cos mul CY add def
    /Zpoint Rsphere phi1 sin mul CZ add def
    Xpoint Ypoint Zpoint tx@3Ddict begin ProjThreeD end lineto
  } for
  theta increment add -1 theta {%
    /theta1 ED
    /Xpoint Rsphere theta1 cos mul phi increment add cos mul CX add def
    /Ypoint Rsphere theta1 sin mul phi increment add cos mul CY add def
    /Zpoint Rsphere phi increment add sin mul CZ add def
    Xpoint Ypoint Zpoint tx@3Ddict begin ProjThreeD end lineto
  } for
  phi increment add -1 phi {
    /phi1 ED
    /Xpoint Rsphere theta cos mul phi1 cos mul CX add def
    /Ypoint Rsphere theta sin mul phi1 cos mul CY add def
    /Zpoint Rsphere phi1 sin mul CZ add def
    Xpoint Ypoint Zpoint tx@3Ddict begin ProjThreeD end lineto
  } for
  closepath 
} def
%
/MaillageSphere { 
% on stack must be x y z Radius increment C M Y K 
  setColorLight
  /increment ED
  /Rsphere ED
  /CZ ED
  /CY ED
  /CX ED
  /StartTheta 0 def
  /condition { PSfacetteSphere 0 ge } def
  -90 increment 90 increment sub {%
    /phi ED
    StartTheta increment 360 StartTheta add increment sub {%
      /theta ED
      % Centre de la facette
      /Xpoint Rsphere theta increment 2 div add cos mul phi increment 2 div add cos mul CX add def
      /Ypoint Rsphere theta increment 2 div add sin mul phi increment 2 div add cos mul CY add def
      /Zpoint Rsphere phi increment 2 div add sin mul CZ add def
      % normale a la facette
      /nXfacette Xpoint CX sub def
      /nYfacette Ypoint CY sub def
      /nZfacette Zpoint CZ sub def
      % test de visibilite
      /PSfacetteSphere 
        vX nXfacette mul
        vY nYfacette mul add
        vZ nZfacette mul add
      def
      condition {
        gsave
        facetteSphere
        /cosV { 1 xLight nXfacette mul
          yLight nYfacette mul
          zLight nZfacette mul
          add add
          NormeLight
          nXfacette dup mul
          nYfacette dup mul
          nZfacette dup mul
          add add sqrt mul div sub } bind def
        Cyan cosV mul Magenta cosV mul Yellow cosV mul K cosV mul setcmykcolor fill 
	grestore
%	0 setgray
        showgrid { facetteSphere stroke } if
      } if 
    } for
    % /StartTheta StartTheta increment 2 div add def
  } for
} def
%
%---------------------- Cylinder ---------------------------
%
/PlanCoupeCylinder { %
  /TableauxPoints [
    0 1 359 { 
      /phi ED 
      [ Radius phi Height ConvCyl2d ] % on décrit le cercle
    } for
  ] def
  newpath
  TableauxPoints 0 get aload pop moveto
  1 1 359 { TableauxPoints exch get aload pop lineto } for
  closepath
} def
%
/facetteCylinder { % 
    newpath
    Radius phi currentHeight ConvCyl2d moveto
    phi 1 phi dAngle add  { % loop variable on stack
      Radius exch currentHeight ConvCyl2d lineto        
    } for
    phi dAngle add -1 phi { %	fill dHeight
      Radius exch currentHeight dHeight add ConvCyl2d lineto 
    } for
    closepath
  } def % facette
%
/MaillageCylinder { % on stack true or false for saving values
    { setColorLight  % expects 4 values on stack C M Y K
      /dHeight ED /dAngle ED /Height ED /Radius ED
      /CZ ED /CY ED /CX ED } if
%     
    0 dHeight Height dHeight sub {
      /currentHeight ED
      0 dAngle 360 dAngle sub {
        /phi ED
% Normal vector of the center
        /nXfacetteCylinder Radius phi dAngle 2 div add cos mul CX add def 
        /nYfacetteCylinder Radius phi dAngle 2 div add sin mul CY add def 
        /nZfacetteCylinder currentHeight dHeight 2 div add CZ add def 
        /NormeN 
          nXfacetteCylinder dup mul
          nYfacetteCylinder dup mul
          nZfacetteCylinder dup mul
          add add sqrt def
        NormeN 0 eq { /NormeN 1e-10 def } if
% test de visibilité
       /PSfacetteCylinder 
    	    vX nXfacetteCylinder mul
            vY nYfacetteCylinder mul add
            vZ nZfacetteCylinder mul add def
       condition {
         facetteCylinder
         /cosV 
	   1 xLight nXfacetteCylinder mul
           yLight nYfacetteCylinder mul
           zLight nZfacetteCylinder mul
           add add
	   NormeLight NormeN mul div sub def
         Cyan Magenta Yellow K
         cosV mul 4 1 roll cosV mul 4 1 roll 
	 cosV dup mul mul 4 1 roll cosV dup mul mul 4 1 roll
         setcmykcolor fill
          showgrid { 
            0 setgray
            facetteCylinder % drawing the segments
            stroke } if
       } if
     } for
    } for
} def
%
%------------------------ Cylinder type II -----------------------
%
/MoveTo { Conv3D2D moveto } def
/LineTo { Conv3D2D lineto } def

/IIIDEllipse { % x y z rA rB startAngle endAngle Wedge
  /dAngle 1 def
  /isWedge ED
  /endAngle ED
  /startAngle ED
  /radiusB ED
  /radiusA ED
  startAngle cos radiusA mul startAngle sin radiusB mul 0 
  isWedge { 0 0 moveto LineTo }{ MoveTo } ifelse
  /Angle startAngle def
  startAngle dAngle endAngle {
    /Angle ED
    Angle cos radiusA mul Angle sin radiusB mul 0 LineTo  
  } for
  isWedge { 0 0 lineto } if
} def

/IIIDCircle { % x y z r startAngle endAngle Wedge
  7 3 roll % startAngle endAngle Wedge x y z r
  dup      % startAngle endAngle Wedge x y z r r
  8 -3 roll
  IIIDEllipse 
} def

/IIIDWedge { % x y z r startAngle endAngle
  true IIIDCircle
} def

/IIIDCylinder {% x y z r h start end wedge
  /isWedge ED
  /increment ED
  /endAngle ED
  /startAngle ED
  /height ED
  /radius ED
  startAngle increment endAngle {
    /Angle ED
    radius Angle 0 ConvCylToCartesian MoveTo  
    radius Angle height ConvCylToCartesian LineTo  
  } for
  stroke
} def
%
%---------------------- Box ---------------------------
%
/PlanCoupeBox { % x y z
  /TableauxPoints [
      [ CX CY CZ Height add ConvBox2d ] % top or bottom
      [ CX CY Depth add CZ Height add ConvBox2d ]
      [ CX Width add CY Depth add CZ Height add ConvBox2d ] 
      [ CX Width add CY CZ Height add ConvBox2d ] 
      [ CX CY CZ Height add ConvBox2d ] % bottom
    ] def
    newpath
    TableauxPoints 0 get aload pop moveto
    0 1 3 {
      TableauxPoints exch get aload pop
      lineto } for
    closepath
} def
%
/facetteBox { % 
    newpath
    dup
    1 eq { % back
      CX CY CZ ConvBox2d moveto
      CX CY CZ Height add ConvBox2d lineto
      CX Width add CY CZ Height add ConvBox2d lineto
      CX Width add CY CZ ConvBox2d lineto
      CX CY CZ ConvBox2d lineto
    } if
    dup
    2 eq { % right
      CX CY CZ ConvBox2d moveto
      CX CY CZ Height add ConvBox2d lineto
      CX CY Depth add CZ Height add ConvBox2d lineto
      CX CY Depth add CZ ConvBox2d lineto
      CX CY CZ ConvBox2d lineto
    } if
    dup
    3 eq { % left
      CX Width add CY CZ ConvBox2d moveto
      CX Width add CY Depth add CZ ConvBox2d lineto
      CX Width add CY Depth add CZ Height add ConvBox2d lineto
      CX Width add CY CZ Height add ConvBox2d lineto
      CX Width add CY CZ ConvBox2d lineto
    } if
    4 eq { % front
      CX CY Depth add CZ ConvBox2d moveto
      CX CY Depth add CZ Height add ConvBox2d lineto
      CX Width add CY Depth add CZ Height add ConvBox2d lineto
      CX Width add CY Depth add CZ ConvBox2d lineto
      CX CY Depth add CZ ConvBox2d lineto
    } if
    closepath
  } def % facette
%
/TestPlane { % on stack x y z of the plane center and # of plane
  /nZfacetteBox ED /nYfacetteBox ED /nXfacetteBox ED
  /Plane ED
  /NormeN 
    nXfacetteBox dup mul
    nYfacetteBox dup mul
    nZfacetteBox dup mul
    add add sqrt def
  NormeN 0 eq { /NormeN 1e-10 def } if
% test de visibilite
  /PSfacetteBox 
    vX nXfacetteBox mul
    vY nYfacetteBox mul add
    vZ nZfacetteBox mul add def
  condition {
    Plane facetteBox
         /cosV 
	   1 xLight nXfacetteBox mul
           yLight nYfacetteBox mul
           zLight nZfacetteBox mul
           add add
	   NormeLight NormeN mul div sub def
         Cyan Magenta Yellow K
         cosV mul 4 1 roll cosV mul 4 1 roll 
	 cosV dup mul mul 4 1 roll cosV dup mul mul 4 1 roll
         setcmykcolor fill
         0 setgray
         Plane facetteBox % drawing the segments
         stroke
       } if
} def
%
/MaillageBox { % on stack true or false for saving values
    { setColorLight  % expects 4 values on stack C M Y K 
      /Depth ED /Height ED /Width ED
      /CZ ED /CY ED /CX ED } if
%
% Normal vector of the box center
  /PlaneSet [
    [ Width 2 div CX add 
      CY 
      Height 2 div CZ add ] % normal back
    [ CX 
      Depth 2 div CY add 
      Height 2 div CZ add ] % normal right
    [ Width CX add 
      Depth 2 div CY add 
      Height 2 div CZ add ] % normal left
    [ Width 2 div CX add 
      Depth CY add 
      Height 2 div CZ add ] % normal front
  ] def
  PlaneSequence length 0 eq { % user defined?
    Alpha abs cvi 360 mod /iAlpha ED
    iAlpha 90 lt { [ 1 2 3 4 ]  
      }{ iAlpha 180 lt { [ 2 4 1 3 ]  
        }{ iAlpha 270 lt { [ 3 4 1 2 ] }{ [ 3 1 4 2] } ifelse } ifelse } ifelse 
  }{ PlaneSequence } ifelse 
  { dup 1 sub PlaneSet exch get aload pop TestPlane } forall
} def
%
%--------------------------- Paraboloid -----------------------------
/PlanCoupeParaboloid {
    /Z height store
    /V {Z sqrt} bind def
    /TableauxPoints [
      0 1 359 { 
        /U ED [ U U Z V calculate2DPoint ] % on decrit le cercle
      } for
    ] def
    newpath
    TableauxPoints 0 get aload pop moveto
    0 1 359 {
      /compteur ED
      TableauxPoints compteur get aload pop
      lineto } for
    closepath
} def
%
/facetteParaboloid{
    newpath
    U U Z V calculate2DPoint moveto
    U 1 U increment add  {%
      /U1 ED
      U1 U1 Z V calculate2DPoint lineto
    } for
    Z pas10 Z pas add pas10 add{
      /Z1 ED
      /V {Z1 sqrt} bind def
      U1 U1 Z1 V calculate2DPoint lineto
    } for
    U increment add -1 U {%
      /U2 ED
      U2 U2 Z pas add V calculate2DPoint lineto
    } for
    Z pas add pas10 sub pas10 neg Z pas10 sub {
      /Z2 ED
      /V Z2 abs sqrt def
      U U Z2 V calculate2DPoint lineto
    } for
    closepath
} def % facette
%
/MaillageParaboloid {
  % on stack true or false for saving values
    { setColorLight  % expects 7 values on stack C M Y K xL yL zL 
%      /CZ ED /CY ED /CX ED 
    } if    
    0 pas height pas sub {%
      /Z ED
      /V Z sqrt def
      0 increment 360 increment sub {%
        /U ED
% Centre de la facette
        /Ucentre U increment 2 div add def
        /Vcentre Z pas 2 div add sqrt def
% normale à la facette
        /nXfacetteParaboloid 2 Vcentre dup mul mul Ucentre cos mul radius mul def
        /nYfacetteParaboloid 2 Vcentre dup mul mul Ucentre sin mul radius mul def
        /nZfacetteParaboloid Vcentre neg radius dup mul mul def
        /NormeN {
          nXfacetteParaboloid dup mul
          nYfacetteParaboloid dup mul
          nZfacetteParaboloid dup mul
          add add sqrt} bind def
        NormeN 0 eq {/NormeN 1e-10 def} if
% test de visibilit�
       /PSfacetteParaboloid vX nXfacetteParaboloid mul
                  vY nYfacetteParaboloid mul add
                  vZ nZfacetteParaboloid mul add def
       condition {
         facetteParaboloid
         /cosV 1 xLight nXfacetteParaboloid mul
           yLight nYfacetteParaboloid mul
           zLight nZfacetteParaboloid mul
           add add
           NormeLight
           NormeN mul div sub def
         Cyan Magenta Yellow K  
         cosV mul 4 1 roll cosV mul 4 1 roll cosV dup mul mul 4 1 roll cosV dup mul mul 4 1 roll
         setcmykcolor fill
         showgrid {
           0 setgray
           facetteParaboloid
           stroke } if
       } if
     } for
    } for
} def
%
% ------------------------------------ math stuff ----------------------------------
%
% Matrix A in arrays of rows A[[row1][row2]...]
% with [row1]=[a11 a12 ... b1]
% returns on stack solution vector X=[x1 x2 ... xn]
/SolveLinEqSystem { 				% on stack matrix M=[A,b] (A*x=b)
  10 dict begin					% hold all ocal
    /A exch def
    /Rows A length def         			% Rows = number of rows
    /Cols A 0 get length def   			% Cols = number of columns
    /Index [ 0 1 Rows 1 sub { } for ] def	% Index = [0 1 2 ... Rows-1]
    /col 0 def
    /row  0 def
    /PR Rows array def 				% PR[c] = pivot row for row row
  { 						% starts the loop, find pivot entry in row r
    col Cols ge row  Rows ge or { exit } if	% col < Cols and row < Rows else exit
    /pRow row def  				% pRow = pivot row		
    /max A row  get col get abs def		% get A[row[col]], first A[0,0] 
    row 1 add 1 Rows 1 sub { 			% starts for loop 1 1 Rows-1
      /j exch def				% index counter
      /x A j get col get abs def		% get A[j[r]]
      x max gt {				% x>max, then save position
        /pRow j def
        /max x def
      } if
    } for					% now we have the row with biggest A[0,1]
						% with pRow = the pivot row
    max 0 gt {					% swap entries pRow and row  in i 
      /tmp Index row  get def
      Index row  Index pRow get put
      Index pRow tmp put			% and columns pRow and row  in A
      /tmp A row get def
      A row  A pRow get put
      A pRow tmp put   				% pivot
      /row0  A row  get def 			% the pivoting row
      /p0 row0  col get def 			% the pivot value
      row 1 add 1 Rows 1 sub { 			% start for loop
        /j exch def
        /c1 A j get def
        /p c1 col get p0 div def
        c1 col p put				% subtract (p1/p0)*row[i] from row[j]
        col 1 add 1 Cols 1 sub {		% start for loop
          /i exch def
          c1 dup i exch 			% c1 i c1
          i get row0 i get p mul sub put
        } for
      } for
      PR row col put
      /col col 1 add def
      /row row 1 add def
    }{						% all zero entries
      /row row 1 add def			% continue loop with same row
    } ifelse
  } loop
  /X A def					% solution vector
  A Rows 1 sub get dup
  Cols 1 sub get exch
  Cols 2 sub get div
  X Rows 1 sub 3 -1 roll put  			% X[n]
  Rows 2 sub -1 0 {				% for loop to calculate X[i]
    /xi exch def				% current index
    A xi get 					% i-th row
    /Axi exch def
    /sum 0 def
    Cols 2 sub -1 xi 1 add { 
      /n exch def
      /sum sum Axi n get X n get mul add def 
    } for
    Axi Cols 1 sub get 				% b=Axi[Cols-1]
    sum sub 					% b-sum
    Axi xi get div				% b-sum / Axi[xi]
    X xi 3 -1 roll put  			% X[xi]
  } for
  X
  end 
} def
%
% u -> e_u with |e_u|=1 
/vector-unit { 1 dict begin
  dup vector-length 1 exch div 
  vector-scale
  end 
} def
%
% u v -> u+v
/vector-add { 1 dict begin
  /v exch def
  [ exch
  0 	     	% u i
  exch { 	% i u[i]
    v 		% i u[i] v
    2 index get add 	% i u[i]+v[i]
    exch 1 add	% i
  } forall
  pop
  ]
  end 
} def
%
% u v -> u-v
/vector-sub { 1 dict begin
  /v exch def
  [ exch
  0 	     	% u i
  exch {	% i u[i]
    v 		% i u[i] v
    2 index get sub 	% i u[i]+v[i]
    exch 1 add	% i
  } forall
  pop
  ]
end } def
%
% [v] c -> [c.v]
/vector-scale { 1 dict begin
  /c exch def
  [ exch
  { 		% s i u[i]
    c mul	% s i u[i] v 
  } forall
  ]
  end } def
%
%
% [u] [v] -> [u x v]
/vector-prod { %% x1 y1 z1 x2 y2 z2
6 dict begin
  aload pop 
  /zp exch def /yp exch def /xp exch def
  aload pop 
  /z exch def /y exch def /x exch def
  [ y zp mul z yp mul sub
   z xp mul x zp mul sub
   x yp mul y xp mul sub ]
end
} def
%
% [u] [v] -> u.v
/vector-mul { %% x1 y1 z1 x2 y2 z2
6 dict begin
  aload pop 
  /zp exch def /yp exch def /xp exch def
  aload pop 
  /z exch def /y exch def /x exch def
  x xp mul y yp mul add z zp mul add
end
} def
%
% [x y z ... ] -> r
% watch out for overflow
/vector-length { 1 dict begin
dup
% find maximum entry
/max 0 def
{ % max 
  abs dup max gt {
    % if abs gt max
    /max exch def
  } {
    pop
  } ifelse
} forall
max 0 ne {
  0 exch 
  {  % 0 v[i]
    max div dup mul add
  } forall
  sqrt
  max mul
} {
  pop 0
} ifelse
end } def
%
end % tx@3DPlotDict
%