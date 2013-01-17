%% $Id: pst-mirror.pro 169 2009-12-08 17:55:59Z herbert $
%%
%% This is file `pst-mirror.pro',
%%
%% IMPORTANT NOTICE:
%%
%%  PostScript prologue for pst-mirror.tex
%%
%% Manuel Luque 
%% Herbert Voss 
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory CTAN:/macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-mirror' is a PSTricks package to view objects ob a spherical sphere
%%
%% version 1.0 2009-09-12
%
/tx@Sphere3DDict 100 dict def
tx@Sphere3DDict begin
%% macros de
%% Jean-Paul Vignault
%% dans pst-solides3d
%%%%% ### defpoint ###
%% syntaxe : xA yA /A defpoint
/defpoint {
1 dict begin
   /t@mp@r@ire exch def
   [ 3 1 roll ] cvx t@mp@r@ire exch 
end def
} def

%%%%% ### vecteur ###
%% syntaxe~: A B vecteur
/vecteur {
                %% xA yA xB yB 
   3 -1 roll    %% xA xB yB yA 
   sub          %% xA xB yB-yA 
   3 1 roll     %% yB-yA xA xB 
   exch sub     %% yB-yA xB-xA 
   exch
} def

%%%%% ### mulv ###
%% syntaxe : u a mulv --> au
/mulv {   %% xA, yA, a
   dup          %% xA, yA, a, a
   3 1 roll     %% xA, a, yA, a
   mul 3 1 roll %% ayA, xA, a
   mul exch
} def

%%%%% ### addv ###
%% syntaxe : u v addv --> u+v
/addv {         %% xA yA xB yB
   3 1 roll     %% xA yB yA xB 
   4 1 roll     %% xB xA yB yA 
   add 3 1 roll %% yB+yA xB xA 
   add exch
} def

%% syntaxe : n currentpathsegmenteline --> ajoute n-1 points sur chaque
%% segment droit sur le chemin courant
/currentpathsegmenteline {
6 dict begin
  /n exch def
%  /warp {2 copy ptojpoint point} def
  %% pour remplacer 'move'
  /warpmove{
     2 index {
       newpath
     } if
     moveto
     pop false
  } def
%
  %% pour remplacer 'lineto'
  /warpline {
     currentpoint /A defpoint
     /B defpoint
     A B vecteur /u defpoint
     1 1 n {
        /i exch def
        A u i n div mulv addv
%% la ligne ci-dessous est a decommenter pour verifier que ca marche
%        2 copy ptojpoint point
        lineto
     } for
  } bind def
%
  true
  { warpmove } {  warpline } { curveto } { closepath } pathforall
  pop
end
} def
%% fin des macros de JPV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
/Cube{%
    /XA M11 A mul M12 B mul add M13 C mul add CX add def
    /YA M21 A mul M22 B mul add M23 C mul add CY add def
    /ZA M31 A mul M32 B mul add M33 C mul add CZ add def
    /XB M11 A mul neg M12 B mul add M13 C mul add CX add def
    /YB M21 A mul neg M22 B mul add M23 C mul add CY add def
    /ZB M31 A mul neg M32 B mul add M33 C mul add CZ add def
    /XC M11 A mul neg M12 B mul neg add M13 C mul add CX add def
    /YC M21 A mul neg M22 B mul neg add M23 C mul add CY add def
    /ZC M31 A mul neg M32 B mul neg add M33 C mul add CZ add def
    /XD M11 A mul M12 B mul neg add M13 C mul add CX add def
    /YD M21 A mul M22 B mul neg add M23 C mul add CY add def
    /ZD M31 A mul M32 B mul neg add M33 C mul add CZ add def
    /XE M11 A mul M12 B mul add M13 C mul sub CX add def
    /YE M21 A mul M22 B mul add M23 C mul sub CY add def
    /ZE M31 A mul M32 B mul add M33 C mul sub CZ add def
    /XF M11 A mul neg M12 B mul add M13 C mul sub CX add def
    /YF M21 A mul neg M22 B mul add M23 C mul sub CY add def
    /ZF M31 A mul neg M32 B mul add M33 C mul sub CZ add def
    /XG M11 A mul neg M12 B mul sub M13 C mul sub CX add def
    /YG M21 A mul neg M22 B mul sub M23 C mul sub CY add def
    /ZG M31 A mul neg M32 B mul sub M33 C mul sub CZ add def
    /XH M11 A mul M12 B mul sub M13 C mul sub CX add def
    /YH M21 A mul M22 B mul sub M23 C mul sub CY add def
    /ZH M31 A mul M32 B mul sub M33 C mul sub CZ add def
% Centres des faces : condition de visibilité
% FACE 1
% OC1
    /XC1 M13 C mul CX add def
    /YC1 M23 C mul CY add def
    /ZC1 M33 C mul CZ add def
% Normale à la face 1
    /NX1 M13 C mul def
    /NY1 M23 C mul def
    /NZ1 M33 C mul def
% produit scalaire
%  ? /PS1 XC1 NX1 mul YC1 NY1 mul add ZC1 Rayon add NZ1 mul add def
    /PS1 XC1 NX1 mul YC1 NY1 mul add ZC1 NZ1 mul add def
% FACE 2
% OC2
    /XC2 M11 A mul CX add def
    /YC2 M21 A mul CY add def
    /ZC2 M31 A mul CZ add def
% normale à la face 2
    /NX2 M11 A mul def
    /NY2 M21 A mul def
    /NZ2 M31 A mul def
% produit scalaire
% ?  /PS2 XC2 NX2 mul YC2 NY2 mul add ZC2 Rayon add NZ2 mul add def
    /PS2 XC2 NX2 mul YC2 NY2 mul add ZC2 NZ2 mul add def
% FACE 3
% OC3
    /XC3 M13 C neg mul CX add def
    /YC3 M23 C neg mul CY add def
    /ZC3 M33 C neg mul CZ add def
% normale à la face 3
    /NX3 M13 C neg mul def
    /NY3 M23 C neg mul def
    /NZ3 M33 C neg mul def
% produit scalaire
%  ? /PS3 XC3 NX3 mul YC3 NY3 mul add ZC3 Rayon add NZ3 mul add def
    /PS3 XC3 NX3 mul YC3 NY3 mul add ZC3 NZ3 mul add def
% FACE 4
% OC4
    /XC4 M11 A neg mul CX add def
    /YC4 M21 A neg mul CY add def
    /ZC4 M31 A neg mul CZ add def
% normale à la face 4
    /NX4 M11 A neg mul def
    /NY4 M21 A neg mul def
    /NZ4 M31 A neg mul def
% produit scalaire
% ?    /PS4 XC4 NX4 mul YC4 NY4 mul add ZC4 Rayon add NZ4 mul add def
    /PS4 XC4 NX4 mul YC4 NY4 mul add ZC4 NZ4 mul add def
% FACE 5
% OC5
    /XC5 M12 B neg mul CX add def
    /YC5 M22 B neg mul CY add def
    /ZC5 M32 B neg mul CZ add def
% normale à la face 5
    /NX5 M12 B neg mul def
    /NY5 M22 B neg mul def
    /NZ5 M32 B neg mul def
% produit scalaire
%    /PS5 XC5 NX5 mul YC5 NY5 mul add ZC5 Rayon add NZ5 mul add def
    /PS5 XC5 NX5 mul YC5 NY5 mul add ZC5 NZ5 mul add def
% FACE 6
% OC6
    /XC6 M12 B mul CX add def
    /YC6 M22 B mul CY add def
    /ZC6 M32 B mul CZ add def
% normale à la face 6
    /NX6 M12 B mul def
    /NY6 M22 B mul def
    /NZ6 M32 B mul def
% produit scalaire
%   /PS6 XC6 NX6 mul YC6 NY6 mul add ZC6 Rayon add NZ6 mul add def
    /PS6 XC6 NX6 mul YC6 NY6 mul add ZC6 NZ6 mul add def
% faceOne
PS1 0 le { %
reduction reduction scale
1 setlinejoin
    /Yordonnee YA def
    /Zcote ZA def
    /Xabscisse XA def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZB mul 1 K sub ZA mul add def
    /Xabscisse K XB mul 1 K sub XA mul add def
    /Yordonnee K YB mul 1 K sub YA mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZC mul 1 K sub ZB mul add def
    /Xabscisse K XC mul 1 K sub XB mul add def
    /Yordonnee K YC mul 1 K sub YB mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZD mul 1 K sub ZC mul add def
    /Xabscisse K XD mul 1 K sub XC mul add def
    /Yordonnee K YD mul 1 K sub YC mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZA mul 1 K sub ZD mul add def
    /Xabscisse K XA mul 1 K sub XD mul add def
    /Yordonnee K YA mul 1 K sub YD mul add def
    CalcCoordinates
    lineto
    } for
} if
% faceTwo
PS2 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XA def
    /Yordonnee YA def
    /Zcote ZA def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZD mul 1 K sub ZA mul add def
    /Xabscisse K XD mul 1 K sub XA mul add def
    /Yordonnee K YD mul 1 K sub YA mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZH mul 1 K sub ZD mul add def
    /Xabscisse K XH mul 1 K sub XD mul add def
    /Yordonnee K YH mul 1 K sub YD mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZE mul 1 K sub ZH mul add def
    /Xabscisse K XE mul 1 K sub XH mul add def
    /Yordonnee K YE mul 1 K sub YH mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZA mul 1 K sub ZE mul add def
    /Xabscisse K XA mul 1 K sub XE mul add def
    /Yordonnee K YA mul 1 K sub YE mul add def
    CalcCoordinates
    lineto
    } for
} if
% face three
PS3 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XE def
    /Yordonnee YE def
    /Zcote ZE def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZF mul 1 K sub ZE mul add def
    /Xabscisse K XF mul 1 K sub XE mul add def
    /Yordonnee K YF mul 1 K sub YE mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZG mul 1 K sub ZF mul add def
    /Xabscisse K XG mul 1 K sub XF mul add def
    /Yordonnee K YG mul 1 K sub YF mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZH mul 1 K sub ZG mul add def
    /Xabscisse K XH mul 1 K sub XG mul add def
    /Yordonnee K YH mul 1 K sub YG mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZE mul 1 K sub ZH mul add def
    /Xabscisse K XE mul 1 K sub XH mul add def
    /Yordonnee K YE mul 1 K sub YH mul add def
    CalcCoordinates
    lineto
    } for
} if
% face four
PS4 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XB def
    /Yordonnee YB def
    /Zcote ZB def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZF mul 1 K sub ZB mul add def
    /Xabscisse K XF mul 1 K sub XB mul add def
    /Yordonnee K YF mul 1 K sub YB mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZG mul 1 K sub ZF mul add def
    /Xabscisse K XG mul 1 K sub XF mul add def
    /Yordonnee K YG mul 1 K sub YF mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZC mul 1 K sub ZG mul add def
    /Xabscisse K XC mul 1 K sub XG mul add def
    /Yordonnee K YC mul 1 K sub YG mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZB mul 1 K sub ZC mul add def
    /Xabscisse K XB mul 1 K sub XC mul add def
    /Yordonnee K YB mul 1 K sub YC mul add def
    CalcCoordinates
    lineto
    } for
} if
% face five
PS5 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XC def
    /Yordonnee YC def
    /Zcote ZC def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZD mul 1 K sub ZC mul add def
    /Xabscisse K XD mul 1 K sub XC mul add def
    /Yordonnee K YD mul 1 K sub YC mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZH mul 1 K sub ZD mul add def
    /Xabscisse K XH mul 1 K sub XD mul add def
    /Yordonnee K YH mul 1 K sub YD mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZG mul 1 K sub ZH mul add def
    /Xabscisse K XG mul 1 K sub XH mul add def
    /Yordonnee K YG mul 1 K sub YH mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZC mul 1 K sub ZG mul add def
    /Xabscisse K XC mul 1 K sub XG mul add def
    /Yordonnee K YC mul 1 K sub YG mul add def
    CalcCoordinates
    lineto
    } for
} if
% face six
PS6 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XB def
    /Yordonnee YB def
    /Zcote ZB def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZA mul 1 K sub ZB mul add def
    /Xabscisse K XA mul 1 K sub XB mul add def
    /Yordonnee K YA mul 1 K sub YB mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZE mul 1 K sub ZA mul add def
    /Xabscisse K XE mul 1 K sub XA mul add def
    /Yordonnee K YE mul 1 K sub YA mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZF mul 1 K sub ZE mul add def
    /Xabscisse K XF mul 1 K sub XE mul add def
    /Yordonnee K YF mul 1 K sub YE mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZB mul 1 K sub ZF mul add def
    /Xabscisse K XB mul 1 K sub XF mul add def
    /Yordonnee K YB mul 1 K sub YF mul add def
    CalcCoordinates
    lineto
    } for
} if
    }
def
%
/PointsDie{%
PS6 0 le { %
reduction reduction scale
A 2 div neg A A 2 div {
    /XCpoint exch def
C 2 div neg C C 2 div {
    /ZCpoint exch def
newpath
    /Zpoint Rpoint ZCpoint add def
    /Xpoint XCpoint def
    /Ypoint B def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Zpoint Rpoint Angle cos mul ZCpoint add def
    /Xpoint Rpoint Angle sin mul XCpoint add def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
    } for
    } for
 } if
PS5 0 le { %
reduction reduction scale
newpath
    /Ypoint B neg def
    /XCpoint A 2 div neg def
    /ZCpoint C 2 div def
    /Xpoint Rpoint XCpoint add def
    /Zpoint ZCpoint def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Xpoint Rpoint Angle cos mul XCpoint add def
    /Zpoint Rpoint Angle sin mul ZCpoint add def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
%
newpath
    /XCpoint A 2 div def
    /ZCpoint C 2 div neg def
    /Xpoint Rpoint XCpoint add def
    /Zpoint ZCpoint def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Xpoint Rpoint Angle cos mul XCpoint add def
    /Zpoint Rpoint Angle sin mul ZCpoint add def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
%
newpath
    /XCpoint 0 def
    /ZCpoint 0 def
    /Xpoint Rpoint XCpoint add def
    /Zpoint ZCpoint def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Xpoint Rpoint Angle cos mul XCpoint add def
    /Zpoint Rpoint Angle sin mul ZCpoint add def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
} if
PS4 0 le { %
reduction reduction scale
C 2 div neg C C 2 div {
    /ZCpoint exch def
B 2 div neg B B 2 div {
    /YCpoint exch def
newpath
    /Zpoint Rpoint ZCpoint add def
    /Ypoint YCpoint def
    /Xpoint A neg def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Zpoint Rpoint Angle cos mul ZCpoint add def
    /Ypoint Rpoint Angle sin mul YCpoint add def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
    } for
    } for
% le point du milieu
newpath
    /Zpoint Rpoint def
    /Ypoint 0 def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Zpoint Rpoint Angle cos mul def
    /Ypoint Rpoint Angle sin mul def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
} if
PS3 0 le { %
reduction reduction scale
A 2 div neg A A 2 div {
    /XCpoint exch def
B 2 div neg B 2 div B 2 div {
    /YCpoint exch def
newpath
    /Xpoint Rpoint XCpoint add def
    /Ypoint YCpoint def
    /Zpoint C neg def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Xpoint Rpoint Angle cos mul XCpoint add def
    /Ypoint Rpoint Angle sin mul YCpoint add def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
    } for
    } for
} if
PS2 0 le { %
reduction reduction scale
newpath
    /Xpoint A def
    /Ypoint Rpoint B 2 div add def
    /Zpoint C 2 div neg def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Ypoint Rpoint Angle cos mul B 2 div add def
    /Zpoint Rpoint Angle sin mul C 2 div sub def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
newpath
    /Xpoint A def
    /Ypoint Rpoint B 2 div sub def
    /Zpoint C 2 div def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Xpoint A def
    /Ypoint Rpoint Angle cos mul B 2 div sub def
    /Zpoint Rpoint Angle sin mul A 2 div add def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
} if
PS1 0 le { %
reduction reduction scale
newpath
    /Xpoint Rpoint def
    /Ypoint 0 def
    /Zpoint C def
CalculsPointsAfterTransformations
CalcCoordinates
    moveto
0 1 359 {%
    /Angle exch def
    /Xpoint Rpoint Angle cos mul def
    /Ypoint Rpoint Angle sin mul def
CalculsPointsAfterTransformations
CalcCoordinates
    lineto
    } for
closepath
0 setgray
fill
} if
} def
/SommetsTetraedre{%
    /xA RayonBaseTetraedre neg def
    /yA 0 def
    /zA 0 def
    /xB 0.5 RayonBaseTetraedre mul def
    /yB RayonBaseTetraedre 0.866 mul neg def
    /zB 0 def
    /xC xB def
    /yC yB neg def
    /zC 0 def
    /xD 0 def
    /yD 0 def
    /zD RayonBaseTetraedre 1.414 mul def
% coordonnées centre des faces
    /xFaceA xA xB xC add add 3 div def
    /yFaceA yA yB yC add add 3 div def
    /zFaceA zA zB zC add add 3 div def
    /xFaceB xD xA xB add add 3 div def
    /yFaceB yD yA yB add add 3 div def
    /zFaceB zD zA zB add add 3 div def
    /xFaceC xA xD xC add add 3 div def
    /yFaceC yA yD yC add add 3 div def
    /zFaceC zA zD zC add add 3 div def
    /xFaceD xD xB xC add add 3 div def
    /yFaceD yD yB yC add add 3 div def
    /zFaceD zD zB zC add add 3 div def
% sommets après rotation et translation
    /XA M11 xA mul M12 yA mul add M13 zA mul add CX add def
    /YA M21 xA mul M22 yA mul add M23 zA mul add CY add def
    /ZA M31 xA mul M32 yA mul add M33 zA mul add CZ add def
    /XB M11 xB mul M12 yB mul add M13 zB mul add CX add def
    /YB M21 xB mul M22 yB mul add M23 zB mul add CY add def
    /ZB M31 xB mul M32 yB mul add M33 zB mul add CZ add def
    /XC M11 xC mul M12 yC mul add M13 zC mul add CX add def
    /YC M21 xC mul M22 yC mul add M23 zC mul add CY add def
    /ZC M31 xC mul M32 yC mul add M33 zC mul add CZ add def
    /XD M11 xD mul M12 yD mul add M13 zD mul add CX add def
    /YD M21 xD mul M22 yD mul add M23 zD mul add CY add def
    /ZD M31 xD mul M32 yD mul add M33 zD mul add CZ add def
% centres de faces après transformations
    /XFaceA M11 xFaceA mul M12 yFaceA mul add M13 zFaceA mul add CX add def
    /YFaceA M21 xFaceA mul M22 yFaceA mul add M23 zFaceA mul add CY add def
    /ZFaceA M31 xFaceA mul M32 yFaceA mul add M33 zFaceA mul add CZ add def
    /XFaceB M11 xFaceB mul M12 yFaceB mul add M13 zFaceB mul add CX add def
    /YFaceB M21 xFaceB mul M22 yFaceB mul add M23 zFaceB mul add CY add def
    /ZFaceB M31 xFaceB mul M32 yFaceB mul add M33 zFaceB mul add CZ add def
    /XFaceC M11 xFaceC mul M12 yFaceC mul add M13 zFaceC mul add CX add def
    /YFaceC M21 xFaceC mul M22 yFaceC mul add M23 zFaceC mul add CY add def
    /ZFaceC M31 xFaceC mul M32 yFaceC mul add M33 zFaceC mul add CZ add def
    /XFaceD M11 xFaceD mul M12 yFaceD mul add M13 zFaceD mul add CX add def
    /YFaceD M21 xFaceD mul M22 yFaceD mul add M23 zFaceD mul add CY add def
    /ZFaceD M31 xFaceD mul M32 yFaceD mul add M33 zFaceD mul add CZ add def
% Normales aux faces
    /NxA XFaceA XD sub def
    /NyA YFaceA YD sub def
    /NzA ZFaceA ZD sub def
    /NxB XFaceB XC sub def
    /NyB YFaceB YC sub def
    /NzB ZFaceB ZC sub def
    /NxC XFaceC XB sub def
    /NyC YFaceC YB sub def
    /NzC ZFaceC ZB sub def
    /NxD XFaceD XA sub def
    /NyD YFaceD YA sub def
    /NzD ZFaceD ZA sub def
% Conditions de visibilité
    /PSA XFaceA NxA mul YFaceA NyA mul add ZFaceA NzA mul add def
    /PSB XFaceB NxB mul YFaceB NyB mul add ZFaceB NzB mul add def
    /PSC XFaceC NxC mul YFaceC NyC mul add ZFaceC NzC mul add def
    /PSD XFaceD NxD mul YFaceD NyD mul add ZFaceD NzD mul add def
    }
    def
/Tetraedre{%
SommetsTetraedre
% face ABC
 PSA 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XA def
    /Yordonnee YA def
    /Zcote ZA def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZB mul 1 K sub ZA mul add def
    /Xabscisse K XB mul 1 K sub XA mul add def
    /Yordonnee K YB mul 1 K sub YA mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZC mul 1 K sub ZB mul add def
    /Xabscisse K XC mul 1 K sub XB mul add def
    /Yordonnee K YC mul 1 K sub YB mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZA mul 1 K sub ZC mul add def
    /Xabscisse K XA mul 1 K sub XC mul add def
    /Yordonnee K YA mul 1 K sub YC mul add def
    CalcCoordinates
    lineto
    } for
} if
% face DAB
 PSB 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XD def
    /Yordonnee YD def
    /Zcote ZD def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZA mul 1 K sub ZD mul add def
    /Xabscisse K XA mul 1 K sub XD mul add def
    /Yordonnee K YA mul 1 K sub YD mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZB mul 1 K sub ZA mul add def
    /Xabscisse K XB mul 1 K sub XA mul add def
    /Yordonnee K YB mul 1 K sub YA mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZD mul 1 K sub ZB mul add def
    /Xabscisse K XD mul 1 K sub XB mul add def
    /Yordonnee K YD mul 1 K sub YB mul add def
    CalcCoordinates
    lineto
    } for
} if
% face DAC
PSC 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XD def
    /Yordonnee YD def
    /Zcote ZD def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZA mul 1 K sub ZD mul add def
    /Xabscisse K XA mul 1 K sub XD mul add def
    /Yordonnee K YA mul 1 K sub YD mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZC mul 1 K sub ZA mul add def
    /Xabscisse K XC mul 1 K sub XA mul add def
    /Yordonnee K YC mul 1 K sub YA mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZD mul 1 K sub ZC mul add def
    /Xabscisse K XD mul 1 K sub XC mul add def
    /Yordonnee K YD mul 1 K sub YC mul add def
    CalcCoordinates
    lineto
    } for
} if
% face DBC
 PSD 0 le { %
reduction reduction scale
1 setlinejoin
    /Xabscisse XD def
    /Yordonnee YD def
    /Zcote ZD def
    CalcCoordinates
     moveto
0 0.01 1 { % k
    /K exch def
    /Zcote K ZB mul 1 K sub ZD mul add def
    /Xabscisse K XB mul 1 K sub XD mul add def
    /Yordonnee K YB mul 1 K sub YD mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZC mul 1 K sub ZB mul add def
    /Xabscisse K XC mul 1 K sub XB mul add def
    /Yordonnee K YC mul 1 K sub YB mul add def
    CalcCoordinates
    lineto
    } for
0 0.01 1 { % k
    /K exch def
    /Zcote K ZD mul 1 K sub ZC mul add def
    /Xabscisse K XD mul 1 K sub XC mul add def
    /Yordonnee K YD mul 1 K sub YC mul add def
    CalcCoordinates
    lineto
    } for
} if
}
def
% 2 aout 2002
/SommetsPyramide{%
    /xA A def
    /yA A neg def
    /zA 0 def
    /xB A def
    /yB A def
    /zB 0 def
    /xC A neg def
    /yC A def
    /zC 0 def
    /xD A neg def
    /yD A neg def
    /zD 0 def
    /xS 0 def
    /yS 0 def
    /zS Hpyramide def
% coordonnées centre des faces
    /Alpha A Hpyramide atan def
    /xFaceSAB Hpyramide Alpha dup sin exch cos mul mul def
    /yFaceSAB 0 def
    /zFaceSAB Hpyramide Alpha sin dup mul mul def
    /xFaceSBC 0 def
    /yFaceSBC xFaceSAB def
    /zFaceSBC zFaceSAB def
    /xFaceSCD xFaceSAB neg def
    /yFaceSCD 0 def
    /zFaceSCD zFaceSAB def
    /xFaceSDA 0 def
    /yFaceSDA xFaceSAB neg def
    /zFaceSDA zFaceSAB def
% sommets après rotation et translation
    /XA M11 xA mul M12 yA mul add M13 zA mul add CX add def
    /YA M21 xA mul M22 yA mul add M23 zA mul add CY add def
    /ZA M31 xA mul M32 yA mul add M33 zA mul add CZ add def
    /XB M11 xB mul M12 yB mul add M13 zB mul add CX add def
    /YB M21 xB mul M22 yB mul add M23 zB mul add CY add def
    /ZB M31 xB mul M32 yB mul add M33 zB mul add CZ add def
    /XC M11 xC mul M12 yC mul add M13 zC mul add CX add def
    /YC M21 xC mul M22 yC mul add M23 zC mul add CY add def
    /ZC M31 xC mul M32 yC mul add M33 zC mul add CZ add def
    /XD M11 xD mul M12 yD mul add M13 zD mul add CX add def
    /YD M21 xD mul M22 yD mul add M23 zD mul add CY add def
    /ZD M31 xD mul M32 yD mul add M33 zD mul add CZ add def
    /XS M11 xS mul M12 yS mul add M13 zS mul add CX add def
    /YS M21 xS mul M22 yS mul add M23 zS mul add CY add def
    /ZS M31 xS mul M32 yS mul add M33 zS mul add CZ add def
% centres de faces après transformations
    /XFaceSAB M11 xFaceSAB mul M12 yFaceSAB mul add M13 zFaceSAB mul add CX add def
    /YFaceSAB M21 xFaceSAB mul M22 yFaceSAB mul add M23 zFaceSAB mul add CY add def
    /ZFaceSAB M31 xFaceSAB mul M32 yFaceSAB mul add M33 zFaceSAB mul add CZ add def
    /XFaceSBC M11 xFaceSBC mul M12 yFaceSBC mul add M13 zFaceSBC mul add CX add def
    /YFaceSBC M21 xFaceSBC mul M22 yFaceSBC mul add M23 zFaceSBC mul add CY add def
    /ZFaceSBC M31 xFaceSBC mul M32 yFaceSBC mul add M33 zFaceSBC mul add CZ add def
    /XFaceSCD M11 xFaceSCD mul M12 yFaceSCD mul add M13 zFaceSCD mul add CX add def
    /YFaceSCD M21 xFaceSCD mul M22 yFaceSCD mul add M23 zFaceSCD mul add CY add def
    /ZFaceSCD M31 xFaceSCD mul M32 yFaceSCD mul add M33 zFaceSCD mul add CZ add def
    /XFaceSDA M11 xFaceSDA mul M12 yFaceSDA mul add M13 zFaceSDA mul add CX add def
    /YFaceSDA M21 xFaceSDA mul M22 yFaceSDA mul add M23 zFaceSDA mul add CY add def
    /ZFaceSDA M31 xFaceSDA mul M32 yFaceSDA mul add M33 zFaceSDA mul add CZ add def
% Normales aux faces
    /NxSAB XFaceSAB CX sub def
    /NySAB YFaceSAB CY sub def
    /NzSAB ZFaceSAB CZ sub def
    /NxSBC XFaceSBC CX sub def
    /NySBC YFaceSBC CY sub def
    /NzSBC ZFaceSBC CZ sub def
    /NxSCD XFaceSCD CX sub def
    /NySCD YFaceSCD CY sub def
    /NzSCD ZFaceSCD CZ sub def
    /NxSDA XFaceSDA CX sub def
    /NySDA YFaceSDA CY sub def
    /NzSDA ZFaceSDA CZ sub def
    /NxABCD CX XS sub def
    /NyABCD CY YS sub def
    /NzABCD CZ ZS sub def
% Conditions de visibilité
    /PSAB XFaceSAB NxSAB mul YFaceSAB NySAB mul add ZFaceSAB NzSAB mul add def
    /PSBC XFaceSBC NxSBC mul YFaceSBC NySBC mul add ZFaceSBC NzSBC mul add def
    /PSCD XFaceSCD NxSCD mul YFaceSCD NySCD mul add ZFaceSCD NzSCD mul add def
    /PSDA XFaceSDA NxSDA mul YFaceSDA NySDA mul add ZFaceSDA NzSDA mul add def
    /PSABCD CX NxABCD mul CY NyABCD mul add CZ NzABCD mul add def
    }
    def
%
/FormulesSphere { %
        /RHO Zcote dup mul Yordonnee dup mul add sqrt def
        /incidence RHO Xabscisse Atan 2 div def
        /RHO' incidence sin Rayon mul def
        RHO 0 eq {/Xi 0 def /Yi 0 def}
        {/Yi RHO' RHO div Zcote mul def
         /Xi RHO' RHO div Yordonnee mul neg def }
         ifelse }
        def
%
/CalcCoordinates{%
    FormulesSphere
    Xi 28.45 mul Yi 28.45 mul
    }
    def
% pour la 3D conventionnelle
/formulesTroisD{%
    /xObservateur Xabscisse Sin1 mul neg Yordonnee Cos1 mul add def
    /yObservateur Xabscisse Cos1Sin2 mul neg Yordonnee Sin1Sin2 mul sub Xabscisse Cos2 mul add def
    /zObservateur Xabscisse neg Cos1Cos2 mul Yordonnee Sin1Cos2 mul sub Xabscisse Sin2 mul sub Dobs add def
    /xScreen DScreen xObservateur mul zObservateur div def
    /yScreen DScreen yObservateur mul zObservateur div def
  xScreen 28.45 mul yScreen 28.45 mul}
def
%
/CalculsPointsAfterTransformations{%
    /Xabscisse M11 Xpoint mul M12 Ypoint mul add M13 Zpoint mul add CX add def
    /Yordonnee M21 Xpoint mul M22 Ypoint mul add M23 Zpoint mul add CY add def
    /Zcote M31 Xpoint mul M32 Ypoint mul add M33 Zpoint mul add CZ add def
    }
def
%
%
/tx@WARP{
%% D'après un fichier original de
%%(c) P. Kleiweg 1997
%% adapté par :
%% Manuel Luque
%% Arnaud Schmittbuhl
%% Jean-Paul Vignault
%% les commentaires sont de Jean-Paul Vignault
/warpmove{
   %% on teste le booleen place 2 tokens plus en avant sur la pile
   %% si c'est 'true', alors on en est au 1er appel => on initialise
   %% le chemin
   2 index { newpath } if
   %% puis on applique warp a notre point
   warp  moveto
   %% on enleve le 'true' pour mettre un 'false' a la place
   pop false
} bind def
%% pour remplacer 'lineto
/warpline { warp lineto } bind def
%% pour remplacer 'curveto'
/warpcurve {
   6 2 roll warp
   6 2 roll warp
   6 2 roll warp
   curveto
}  bind def
%% 'warpit' declenche la transformation du chemin courant
/warpit { true { warpmove } { warpline } { warpcurve } { closepath } pathforall pop } bind def
} def

/tx@PathForAll{
/warp {
  5 dict begin
    /Ypoint exch def 
    /Xpoint exch def 
   2dto3d
   /Zpoint exch def
   /Ypoint exch def
   /Xpoint exch def
   CalculsPointsApresTransformations
   3dto2d
  end
} bind def
tx@WARP  
warpit 
} def

/tx@TransformPlan{  % le calcul des coefficients
%% pour passer des coordonnées du plan aux coordonnées
%% (x,y,z) du repère absolu
%% les coordonnées sphériques du vecteur normal
%% au plan
%% l'origine du plan
/zO' exch def
/yO' exch def
/xO' exch def
%% les coefficients de la matrice de transformation
/C11 {K_theta sin neg} def
/C12 {K_theta cos K_phi sin mul neg} bind def
/C21 {K_theta cos} bind def
/C22 {K_phi sin K_theta sin mul neg } bind def
/C31 {K_phi cos} bind def
/2dto3d {
%% coordonnées dans le repère absolu
3 dict begin
  C11 Xpoint mul C12 Ypoint mul add xO' add % x
  C21 Xpoint mul C22 Ypoint mul add yO' add % y
  C31 Ypoint mul zO' add
end } def 
}  def
%
end
