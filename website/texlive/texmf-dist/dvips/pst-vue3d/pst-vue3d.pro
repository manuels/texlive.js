%version 33 march 2007
%
/tx@3DDict 100 dict def
tx@3DDict begin
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
% rayon vers point de vue
    /RXvue1 XC1 XpointVue sub def
    /RYvue1 YC1 YpointVue sub def
    /RZvue1 ZC1 ZpointVue sub def
% produit scalaire
    /PS1 RXvue1 NX1 mul RYvue1 NY1 mul add RZvue1 NZ1 mul add def
% FACE 2
% OC2
    /XC2 M11 A mul CX add def
    /YC2 M21 A mul CY add def
    /ZC2 M31 A mul CZ add def
% normale à la face 2
    /NX2 M11 A mul def
    /NY2 M21 A mul def
    /NZ2 M31 A mul def
% rayon vers point de vue
    /RXvue2 XC2 XpointVue sub def
    /RYvue2 YC2 YpointVue sub def
    /RZvue2 ZC2 ZpointVue sub def
% produit scalaire
    /PS2 RXvue2 NX2 mul RYvue2 NY2 mul add RZvue2 NZ2 mul add def
% FACE 3
% OC3
    /XC3 M13 C neg mul CX add def
    /YC3 M23 C neg mul CY add def
    /ZC3 M33 C neg mul CZ add def
% normale à la face 3
    /NX3 M13 C neg mul def
    /NY3 M23 C neg mul def
    /NZ3 M33 C neg mul def
% rayon vers point de vue
    /RXvue3 XC3 XpointVue sub def
    /RYvue3 YC3 YpointVue sub def
    /RZvue3 ZC3 ZpointVue sub def
% produit scalaire
    /PS3 RXvue3 NX3 mul RYvue3 NY3 mul add RZvue3 NZ3 mul add def
% FACE 4
% OC4
    /XC4 M11 A neg mul CX add def
    /YC4 M21 A neg mul CY add def
    /ZC4 M31 A neg mul CZ add def
% normale à la face 4
    /NX4 M11 A neg mul def
    /NY4 M21 A neg mul def
    /NZ4 M31 A neg mul def
% rayon vers point de vue
    /RXvue4 XC4 XpointVue sub def
    /RYvue4 YC4 YpointVue sub def
    /RZvue4 ZC4 ZpointVue sub def
% produit scalaire
    /PS4 RXvue4 NX4 mul RYvue4 NY4 mul add RZvue4 NZ4 mul add def
% FACE 5
% OC5
    /XC5 M12 B neg mul CX add def
    /YC5 M22 B neg mul CY add def
    /ZC5 M32 B neg mul CZ add def
% normale à la face 5
    /NX5 M12 B neg mul def
    /NY5 M22 B neg mul def
    /NZ5 M32 B neg mul def
% rayon vers point de vue
    /RXvue5 XC5 XpointVue sub def
    /RYvue5 YC5 YpointVue sub def
    /RZvue5 ZC5 ZpointVue sub def
% produit scalaire
    /PS5 RXvue5 NX5 mul RYvue5 NY5 mul add RZvue5 NZ5 mul add def
% FACE 6
% OC6
    /XC6 M12 B mul CX add def
    /YC6 M22 B mul CY add def
    /ZC6 M32 B mul CZ add def
% normale à la face 6
    /NX6 M12 B mul def
    /NY6 M22 B mul def
    /NZ6 M32 B mul def
% rayon vers point de vue
    /RXvue6 XC6 XpointVue sub def
    /RYvue6 YC6 YpointVue sub def
    /RZvue6 ZC6 ZpointVue sub def
% produit scalaire
    /PS6 RXvue6 NX6 mul RYvue6 NY6 mul add RZvue6 NZ6 mul add def
% faceOne
PS1 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YA def
    /Zcote ZA def
    /Xabscisse XA def
    CalcCoordinates
     moveto
    /Zcote ZB def
    /Xabscisse XB def
    /Yordonnee YB def
    CalcCoordinates
    lineto
    /Zcote ZC def
    /Xabscisse XC def
    /Yordonnee YC  def
    CalcCoordinates
    lineto
    /Zcote ZD def
    /Xabscisse XD def
    /Yordonnee YD def
    CalcCoordinates
    lineto
    /Zcote ZA def
    /Xabscisse XA def
    /Yordonnee YA def
    CalcCoordinates
    lineto
closepath
gsave
CubeColorFaceOne setrgbcolor
fill
grestore
stroke
} if
% faceTwo
PS2 0 Condition{ %
reduction reduction scale
1 setlinejoin
newpath
    /Xabscisse XA def
    /Yordonnee YA def
    /Zcote ZA def
    CalcCoordinates
     moveto
    /Zcote ZD def
    /Xabscisse XD def
    /Yordonnee YD def
    CalcCoordinates
    lineto
    /Zcote ZH def
    /Xabscisse XH def
    /Yordonnee YH def
    CalcCoordinates
    lineto
    /Zcote ZE def
    /Xabscisse XE def
    /Yordonnee YE def
    CalcCoordinates
    lineto
    /Zcote ZA def
    /Xabscisse XA def
    /Yordonnee YA def
    CalcCoordinates
    lineto
closepath
gsave
CubeColorFaceTwo setrgbcolor
fill
grestore
stroke
} if
% face three
PS3 0 Condition{ %
reduction reduction scale
1 setlinejoin
newpath
    /Xabscisse XE def
    /Yordonnee YE def
    /Zcote ZE def
    CalcCoordinates
     moveto
    /Zcote ZF def
    /Xabscisse XF def
    /Yordonnee YF def
    CalcCoordinates
    lineto
    /Zcote ZG def
    /Xabscisse XG def
    /Yordonnee YG def
    CalcCoordinates
    lineto
    /Zcote ZH def
    /Xabscisse XH def
    /Yordonnee YH def
    CalcCoordinates
    lineto
    /Zcote ZE def
    /Xabscisse XE def
    /Yordonnee YE def
    CalcCoordinates
    lineto
closepath
gsave
CubeColorFaceThree setrgbcolor
fill
grestore
stroke
} if
% face four
PS4 0 Condition{ %
reduction reduction scale
1 setlinejoin
newpath
    /Xabscisse XB def
    /Yordonnee YB def
    /Zcote ZB def
    CalcCoordinates
     moveto
    /Zcote ZF def
    /Xabscisse XF def
    /Yordonnee YF def
    CalcCoordinates
    lineto
    /Zcote ZG def
    /Xabscisse XG def
    /Yordonnee YG def
    CalcCoordinates
    lineto
    /Zcote ZC def
    /Xabscisse XC def
    /Yordonnee YC def
    CalcCoordinates
    lineto
    /Zcote ZB def
    /Xabscisse XB def
    /Yordonnee YB def
    CalcCoordinates
    lineto
closepath
gsave
CubeColorFaceFour setrgbcolor
fill
grestore
stroke
} if
% face five
PS5 0 Condition{ %
reduction reduction scale
1 setlinejoin
newpath
    /Xabscisse XC def
    /Yordonnee YC def
    /Zcote ZC def
    CalcCoordinates
     moveto
    /Zcote ZD def
    /Xabscisse XD def
    /Yordonnee YD def
    CalcCoordinates
    lineto
    /Zcote ZH def
    /Xabscisse XH def
    /Yordonnee YH def
    CalcCoordinates
    lineto
    /Zcote ZG def
    /Xabscisse XG def
    /Yordonnee YG def
    CalcCoordinates
    lineto
    /Zcote ZC def
    /Xabscisse XC def
    /Yordonnee YC def
    CalcCoordinates
    lineto
closepath
gsave
CubeColorFaceFive setrgbcolor
fill
grestore
stroke
} if
% face six
PS6 0 Condition{ %
reduction reduction scale
1 setlinejoin
newpath
    /Xabscisse XB def
    /Yordonnee YB def
    /Zcote ZB def
    CalcCoordinates
     moveto
    /Zcote ZA def
    /Xabscisse XA def
    /Yordonnee YA def
    CalcCoordinates
    lineto
    /Zcote ZE def
    /Xabscisse XE def
    /Yordonnee YE def
    CalcCoordinates
    lineto
    /Zcote ZF def
    /Xabscisse XF def
    /Yordonnee YF def
    CalcCoordinates
    lineto
    /Zcote ZB def
    /Xabscisse XB def
    /Yordonnee YB def
    CalcCoordinates
    lineto
closepath
gsave
CubeColorFaceSix setrgbcolor
fill
grestore
stroke
} if
}
def
%
/PointsDie{%
PS6 0 Condition{ %
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
PS5 0 Condition{ %
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
PS4 0 Condition{ %
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
PS3 0 Condition{ %
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
PS2 0 Condition{ %
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
PS1 0 Condition{ %
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
%
/CalcCoordinates{%
    formulesTroisD
% hv 2005-04-30   --->beg
%    Xi 28.45 mul Yi 28.45 mul
    Xi xUnit mul Yi yUnit mul
% hv 2005-04-30   <---beg
    }
    def
% pour la 3D conventionnelle
/formulesTroisD{%
    /xObservateur Xabscisse Sin1 mul neg Yordonnee Cos1 mul add def
    /yObservateur Xabscisse Cos1Sin2 mul neg Yordonnee Sin1Sin2 mul sub Zcote Cos2 mul add def
    /zObservateur Xabscisse neg Cos1Cos2 mul Yordonnee Sin1Cos2 mul sub Zcote Sin2 mul sub Dobs add def
    /Xi DScreen xObservateur mul zObservateur div def
    /Yi DScreen yObservateur mul zObservateur div def
  }
def
%
/CalculsPointsAfterTransformations{%
    /Xabscisse M11 Xpoint mul M12 Ypoint mul add M13 Zpoint mul add CX add def
    /Yordonnee M21 Xpoint mul M22 Ypoint mul add M23 Zpoint mul add CY add def
    /Zcote M31 Xpoint mul M32 Ypoint mul add M33 Zpoint mul add CZ add def
    }
def
%
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
% rayon vers point de vue
    /RXvueA XFaceA XpointVue sub def
    /RYvueA YFaceA YpointVue sub def
    /RZvueA ZFaceA ZpointVue sub def
    /RXvueB XFaceB XpointVue sub def
    /RYvueB YFaceB YpointVue sub def
    /RZvueB ZFaceB ZpointVue sub def
    /RXvueC XFaceC XpointVue sub def
    /RYvueC YFaceC YpointVue sub def
    /RZvueC ZFaceC ZpointVue sub def
    /RXvueD XFaceD XpointVue sub def
    /RYvueD YFaceD YpointVue sub def
    /RZvueD ZFaceD ZpointVue sub def
% produit scalaire
    /PSA RXvueA NxA mul RYvueA NyA mul add RZvueA NzA mul add def
    /PSB RXvueB NxB mul RYvueB NyB mul add RZvueB NzB mul add def
    /PSC RXvueC NxC mul RYvueC NyC mul add RZvueC NzC mul add def
    /PSD RXvueD NxD mul RYvueD NyD mul add RZvueD NzD mul add def
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
    /Xabscisse XB def
    /Yordonnee YB def
    /Zcote ZB def
    CalcCoordinates
    lineto
    /Xabscisse XC def
    /Yordonnee YC def
    /Zcote ZC def
    CalcCoordinates
    lineto
    /Xabscisse XA def
    /Yordonnee YA def
    /Zcote ZA def
    CalcCoordinates
    lineto
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
    /Xabscisse XA def
    /Yordonnee YA def
    /Zcote ZA def
    CalcCoordinates
    lineto
    /Xabscisse XB def
    /Yordonnee YB def
    /Zcote ZB def
    CalcCoordinates
    lineto
    /Xabscisse XD def
    /Yordonnee YD def
    /Zcote ZD def
    CalcCoordinates
    lineto
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
    /Xabscisse XA def
    /Yordonnee YA def
    /Zcote ZA def
    CalcCoordinates
    lineto
    /Xabscisse XC def
    /Yordonnee YC def
    /Zcote ZC def
    CalcCoordinates
    lineto
    /Xabscisse XD def
    /Yordonnee YD def
    /Zcote ZD def
    CalcCoordinates
    lineto
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
    /Xabscisse XB def
    /Yordonnee YB def
    /Zcote ZB def
    CalcCoordinates
    lineto
    /Xabscisse XC def
    /Yordonnee YC def
    /Zcote ZC def
    CalcCoordinates
    lineto
    /Xabscisse XD def
    /Yordonnee YD def
    /Zcote ZD def
    CalcCoordinates
    lineto
} if
}
def
%
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
    /zFaceSBC zFaceSAB fracHeight mul def
    /xFaceSCD xFaceSAB neg def
    /yFaceSCD 0 def
    /zFaceSCD zFaceSAB fracHeight mul def
    /xFaceSDA 0 def
    /yFaceSDA xFaceSAB neg def
    /zFaceSDA zFaceSAB fracHeight mul def
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
% rayon vers point de vue
    /RXvueSAB XFaceSAB XpointVue sub def
    /RYvueSAB YFaceSAB YpointVue sub def
    /RZvueSAB ZFaceSAB ZpointVue sub def
    /RXvueSBC XFaceSBC XpointVue sub def
    /RYvueSBC YFaceSBC YpointVue sub def
    /RZvueSBC ZFaceSBC ZpointVue sub def
    /RXvueSCD XFaceSCD XpointVue sub def
    /RYvueSCD YFaceSCD YpointVue sub def
    /RZvueSCD ZFaceSCD ZpointVue sub def
    /RXvueSDA XFaceSDA XpointVue sub def
    /RYvueSDA YFaceSDA YpointVue sub def
    /RZvueSDA ZFaceSDA ZpointVue sub def
    /RXvueABCD CX XpointVue sub def
    /RYvueABCD CY YpointVue sub def
    /RZvueABCD CZ ZpointVue sub def
    /PSAB RXvueSAB NxSAB mul RYvueSAB NySAB mul add RZvueSAB NzSAB mul add def
    /PSBC RXvueSBC NxSBC mul RYvueSBC NySBC mul add RZvueSBC NzSBC mul add def
    /PSCD RXvueSCD NxSCD mul RYvueSCD NySCD mul add RZvueSCD NzSCD mul add def
    /PSDA RXvueSDA NxSDA mul RYvueSDA NySDA mul add RZvueSDA NzSDA mul add def
    /PSABCD RXvueABCD NxABCD mul RYvueABCD NyABCD mul add RZvueABCD NzABCD mul add def
    }
    def
%
/MaillageSphere {
0 increment 360 increment sub {%
    /theta exch def
departPhi increment 90 increment sub {%
    /phi exch def
% newpath
    /Xpoint Rsphere theta cos mul phi cos mul def
    /Ypoint Rsphere theta sin mul phi cos mul def
    /Zpoint Rsphere phi sin mul def
CalculsPointsAfterTransformations
    CalcCoordinates
     moveto
% Centre de la facette
    /Xpoint Rsphere theta increment 2 div add cos mul phi increment 2 div add cos mul def
    /Ypoint Rsphere theta increment 2 div add sin mul phi increment 2 div add cos mul def
    /Zpoint Rsphere phi increment 2 div add sin mul def
CalculsPointsAfterTransformations
    /xCentreFacette Xabscisse def
    /yCentreFacette Yordonnee def
    /zCentreFacette Zcote def
% normale à la facette
    /nXfacette xCentreFacette CX sub def
    /nYfacette yCentreFacette CY sub def
    /nZfacette zCentreFacette CZ sub def
% rayon vers point de vue
    /RXvue xCentreFacette XpointVue sub def
    /RYvue yCentreFacette YpointVue sub def
    /RZvue zCentreFacette ZpointVue sub def
% test de visibilité
    /PSfacette RXvue nXfacette mul
    RYvue nYfacette mul add
    RZvue nZfacette mul add
    def
condition {
theta 1 theta increment add {%
    /theta1 exch def
    /Xpoint Rsphere theta1 cos mul phi cos mul def
    /Ypoint Rsphere theta1 sin mul phi cos mul def
    /Zpoint Rsphere phi sin mul def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
phi 1 phi increment add {
    /phi1 exch def
    /Xpoint Rsphere theta increment add cos mul phi1 cos mul def
    /Ypoint Rsphere theta increment add sin mul phi1 cos mul def
    /Zpoint Rsphere phi1 sin mul def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
theta increment add -1 theta {%
    /theta1 exch def
    /Xpoint Rsphere theta1 cos mul phi increment add cos mul def
    /Ypoint Rsphere theta1 sin mul phi increment add cos mul def
    /Zpoint Rsphere phi increment add sin mul def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
phi increment add -1 phi {
    /phi1 exch def
    /Xpoint Rsphere theta cos mul phi1 cos mul def
    /Ypoint Rsphere theta sin mul phi1 cos mul def
    /Zpoint Rsphere phi1 sin mul def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
        } for
} if
} for
} for
} def
%
/CylinderThreeD{
reduction reduction scale
1 setlinejoin
0 incrementANGLE 360 {%
    /theta exch def
 0 incrementHAUTEUR Hcylindre incrementHAUTEUR sub {%
    /H exch def
% newpath
    /X1 Rcylindre theta cos mul def
    /Y1 Rcylindre theta sin mul def
    /Z1 H def
    /Xpoint X1 def
    /Ypoint Y1 def
    /Zpoint Z1 def
CalculsPointsAfterTransformations
    /Xfacette Xabscisse  def
    /Yfacette Yordonnee  def
    /Zfacette Zcote def
    CalcCoordinates
     moveto
% coordonnées du centre de la facette
    /Xpoint Rcylindre theta incrementANGLE 2 div add cos mul def
    /Ypoint Rcylindre theta incrementANGLE 2 div add sin mul def
    /Zpoint H incrementHAUTEUR 2 div add def
CalculsPointsAfterTransformations
% Point sur l'axe du cylindre
% à la même hauteur que M1
    /Zpoint Z1 def
    /Xpoint 0 def
    /Ypoint 0 def
CalculsPointsAfterTransformations
% normale à la facette
    /nXfacette Xfacette Xabscisse sub def
    /nYfacette Yfacette Yordonnee sub def
    /nZfacette Zfacette Zcote sub def
% rayon vers point de vue
    /RXvue Xfacette XpointVue sub def
    /RYvue Yfacette YpointVue sub def
    /RZvue Zfacette ZpointVue sub def
% test de visibilité
    /PSfacette nXfacette RXvue mul
    nYfacette RYvue mul add
    nZfacette RZvue mul add
    def
PSfacette 0 le {
theta 1 theta incrementANGLE add {%
    /theta1 exch def
    /Xpoint Rcylindre theta1 cos mul def
    /Ypoint Rcylindre theta1 sin mul def
    /Zpoint H def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
H 1 H incrementHAUTEUR add {
    /H1 exch def
    /Xpoint Rcylindre  theta incrementANGLE add cos mul def
    /Ypoint Rcylindre theta incrementANGLE add sin mul def
    /Zpoint H1 def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
theta incrementANGLE add -1 theta {%
    /theta1 exch def
    /Xpoint Rcylindre theta1 cos mul def
    /Ypoint Rcylindre theta1 sin mul def
    /Zpoint H incrementHAUTEUR add def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
H incrementHAUTEUR add -1 H {
    /H1 exch def
    /Xpoint Rcylindre theta cos mul def
    /Ypoint Rcylindre theta sin mul def
    /Zpoint H1 def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
} if
} for
} for
% Face supérieure
% centre de la face supérieure
    /Xpoint 0 def
    /Zpoint Hcylindre def
    /Ypoint 0 def
CalculsPointsAfterTransformations
    /CxFaceSup Xabscisse def
    /CyFaceSup Yordonnee def
    /CzFaceSup Zcote def
% centre de la face inférieure
    /CxFaceInf CX def
    /CyFaceInf CY def
    /CzFaceInf CZ def
% Normale à la face supérieure
    /nXFaceSup CxFaceSup CxFaceInf sub def
    /nYFaceSup CyFaceSup CyFaceInf sub def
    /nZFaceSup CzFaceSup CzFaceInf sub def
% rayon vers point de vue verd la face inférieure
    /RXvueInf CxFaceInf XpointVue sub def
    /RYvueInf CyFaceInf YpointVue sub def
    /RZvueInf CzFaceInf ZpointVue sub def
% rayon vers point de vue verd la face supérieure
    /RXvueSup CxFaceSup XpointVue sub def
    /RYvueSup CyFaceSup YpointVue sub def
    /RZvueSup CzFaceSup ZpointVue sub def
% Visibilité face supérieure
    /PSfaceSup RXvueSup nXFaceSup mul
               RYvueSup nYFaceSup mul add
               RZvueSup nZFaceSup mul add def
% Visibilité face inférieure
    /PSfaceInf RXvueInf nXFaceSup neg mul
               RYvueInf nYFaceSup mul sub
               RZvueInf nZFaceSup mul sub def
PSfaceSup 0 le {
/TableauxPoints [
0 1 359 {% on décrit le cercle
    /theta exch def [
    /Xpoint Rcylindre theta cos mul def
    /Ypoint Rcylindre theta sin mul def
    /Zpoint Hcylindre def
CalculsPointsAfterTransformations
    CalcCoordinates ]
    } for
    ] def
gsave
newpath
 TableauxPoints 0 get aload pop moveto
0 1 359 {
    /compteur exch def
    TableauxPoints compteur get aload pop
    lineto } for
0.7 setgray
closepath
fill
grestore
 } if
% face inférieure
PSfaceInf 0 le {
/TableauxPoints [
0 1 359 {% on décrit le cercle
    /theta exch def [
    /Xpoint Rcylindre theta cos mul def
    /Ypoint Rcylindre theta sin mul def
    /Zpoint 0 def
CalculsPointsAfterTransformations
    CalcCoordinates ]
    } for
    ] def
gsave
newpath
 TableauxPoints 0 get aload pop moveto
 0 1 359 {
    /compteur exch def
    TableauxPoints compteur get aload pop
    lineto } for
0.7 setgray
closepath
fill
grestore
 } if
 } def
%
 %
/ConeThreeD{
    /AngleCone Rcone Hcone atan def
    /TanAngleCone AngleCone dup sin exch cos div def
    /incrementANGLE 10 def
    /incrementHAUTEUR Hcone fracHeight mul  5 div def
1 setlinejoin
newpath
0 incrementANGLE 360 {%
    /theta exch def
 0 incrementHAUTEUR Hcone fracHeight mul incrementHAUTEUR sub {%
    /H exch def
 % normale à la facette
    /nXfacette Hcone AngleCone dup sin exch cos mul theta incrementANGLE 2 div add cos mul
    mul def
    /nYfacette Hcone AngleCone dup sin exch cos mul theta incrementANGLE 2 div add sin mul
    mul def
    /nZfacette Hcone AngleCone sin dup mul mul def
    /Xpoint nXfacette def
    /Ypoint nYfacette def
    /Zpoint nZfacette def
CalculsPointsAfterTransformations
    /nXfacette Xabscisse CX sub def
    /nYfacette Yordonnee CY sub def
    /nZfacette Zcote CZ sub def
%
    /OK Hcone H sub TanAngleCone mul def
    /Xpoint OK theta cos mul def
    /Ypoint OK theta sin mul def
    /Zpoint H def
CalculsPointsAfterTransformations
    /Xfacette Xabscisse  def
    /Yfacette Yordonnee  def
    /Zfacette Zcote def
    CalcCoordinates
     moveto
% coordonnées du centre de la facette
    /OK Hcone H incrementHAUTEUR 2 div add sub TanAngleCone mul def
    /Xpoint OK theta incrementANGLE 2 div add cos mul def
    /Ypoint OK theta incrementANGLE 2 div add sin mul def
    /Zpoint H incrementHAUTEUR 2 div add def
CalculsPointsAfterTransformations
    /XcentreFacette Xabscisse  def
    /YcentreFacette Yordonnee  def
    /ZcentreFacette Zcote def
% rayon vers point de vue
    /RXvue XcentreFacette XpointVue sub def
    /RYvue YcentreFacette YpointVue sub def
    /RZvue ZcentreFacette ZpointVue sub def
% test de visibilité
    /PSfacette nXfacette RXvue mul
    nYfacette RYvue mul add
    nZfacette RZvue mul add
    def
PSfacette 0 le {
theta 1 theta incrementANGLE add {%
    /theta1 exch def
    /OK Hcone H sub TanAngleCone mul def
    /Xpoint OK theta1 cos mul def
    /Ypoint OK theta1 sin mul def
    /Zpoint H def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
H 1 H incrementHAUTEUR add {
    /H1 exch def
    /OK Hcone H1 sub TanAngleCone mul def
    /Xpoint OK theta incrementANGLE add cos mul def
    /Ypoint OK theta incrementANGLE add sin mul def
    /Zpoint H1 def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
theta incrementANGLE add -1 theta {%
    /theta1 exch def
    /OK Hcone H incrementHAUTEUR add sub TanAngleCone mul def
    /Xpoint OK theta1 cos mul def
    /Ypoint OK theta1 sin mul def
    /Zpoint H incrementHAUTEUR add def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
H incrementHAUTEUR add -1 H {
    /H1 exch def
    /OK Hcone H1 sub TanAngleCone mul def
    /Xpoint OK theta cos mul def
    /Ypoint OK theta sin mul def
    /Zpoint H1 def
CalculsPointsAfterTransformations
    CalcCoordinates
    lineto
    } for
} if
} for
} for
% centre de la base inférieure après transformations
    /CxFaceInf CX def
    /CyFaceInf CY def
    /CzFaceInf CZ def
% modification du 16/11/2002
%    /Xpoint CxFaceInf def
%    /Ypoint CyFaceInf def
%    /Zpoint CzFaceInf def
    /Xpoint 0 def
    /Ypoint 0 def
    /Zpoint 0 def
% fin modification du 16/11/2002
CalculsPointsAfterTransformations
    /CxBaseInf Xabscisse def
    /CyBaseInf Yordonnee def
    /CzBaseInf Zcote def
% centre de la base supérieure avant transformations
    /CxFaceSup 0 def
    /CyFaceSup 0 def
    /CzFaceSup Hcone fracHeight mul def
% Sommet du cone
    /Xpoint 0 def
    /Ypoint 0 def
    /Zpoint Hcone def
CalculsPointsAfterTransformations
    /XsommetCone Xabscisse def
    /YsommetCone Yordonnee def
    /ZsommetCone Zcote def
% Normale extérieure à la base inférieure
    /nXBaseInf CxFaceInf XsommetCone sub def
    /nYBaseInf CyFaceInf YsommetCone sub def
    /nZBaseInf CzFaceInf ZsommetCone sub def
% centre de la base supérieure
    /Xpoint CxFaceSup def
    /Ypoint CyFaceSup def
    /Zpoint CzFaceSup def
CalculsPointsAfterTransformations
    /CxBaseSup Xabscisse def
    /CyBaseSup Yordonnee def
    /CzBaseSup Zcote def
% Normale extérieure à la base supérieure
    /nXBaseSup XsommetCone CxFaceSup sub def
    /nYBaseSup YsommetCone CyFaceSup sub def
    /nZBaseSup ZsommetCone CzFaceSup sub def
% rayon vers point de vue
    /RXvueSup CxBaseSup XpointVue sub def
    /RYvueSup CyBaseSup YpointVue sub def
    /RZvueSup CzBaseSup ZpointVue sub def
    /RXvueInf CxBaseInf XpointVue sub def
    /RYvueInf CyBaseInf YpointVue sub def
    /RZvueInf CzBaseInf ZpointVue sub def
% Visibilité de la base inférieure
    /PSbaseInfCone nXBaseInf RXvueInf mul
                nYBaseInf RYvueInf mul add
                nZBaseInf RZvueInf mul add def
% Visibilité de la base supérieure
    /PSbaseSupCone nXBaseSup RXvueSup mul
                nYBaseSup RYvueSup mul add
                nZBaseSup RZvueSup mul add def
PSbaseInfCone 0 le {
/TableauxPoints [
0 1 359 {% on décrit le cercle
    /theta exch def [
    /Xpoint Rcone theta cos mul def
    /Ypoint Rcone theta sin mul def
    /Zpoint 0 def
CalculsPointsAfterTransformations
    CalcCoordinates ]
    } for
    ] def
gsave
newpath
 TableauxPoints 0 get aload pop moveto
0 1 359 {
    /compteur exch def
    TableauxPoints compteur get aload pop
    lineto } for
0.7 setgray
closepath
fill
grestore
 } if
%% PSbaseSupCone 0 le {
%% modifié le 31/10/2003
%PSbaseSupCone 0 ge {
PSbaseSupCone 0 le {
/TableauxPoints [
0 1 359 {% on décrit le cercle
    /theta exch def [
    /OK Hcone 1 fracHeight sub mul TanAngleCone mul def
    /Xpoint OK theta cos mul def
    /Ypoint OK theta sin mul def
    /Zpoint Hcone fracHeight mul def
CalculsPointsAfterTransformations
    CalcCoordinates ]
    } for
    ] def
gsave
newpath
 TableauxPoints 0 get aload pop moveto
0 1 359 {
    /compteur exch def
    TableauxPoints compteur get aload pop
    lineto } for
0.7 setgray
closepath
fill
grestore
 } if
 } def
/PortionSphere{%
    /Xpoint Rsphere psTHETA dTHETA neg add cos mul psPHI dPHI sub cos mul def
    /Ypoint Rsphere psTHETA dTHETA neg add sin mul psPHI dPHI sub cos mul def
    /Zpoint Rsphere psPHI dPHI sub sin mul def
CalculsPointsAfterTransformations
    /xCentreFacette Xabscisse def
    /yCentreFacette Yordonnee def
    /zCentreFacette Zcote def
% normale à la facette
    /nXfacette xCentreFacette CX sub def
    /nYfacette yCentreFacette CY sub def
    /nZfacette zCentreFacette CZ sub def
% rayon vers point de vue
    /RXvue xCentreFacette XpointVue sub def
    /RYvue yCentreFacette YpointVue sub def
    /RZvue zCentreFacette ZpointVue sub def
% test de visibilité
    /PSfacette RXvue nXfacette mul
    RYvue nYfacette mul add
    RZvue nZfacette mul add
    def
PSfacette 0 le {
CalcCoordinates
newpath
     moveto
psTHETA dTHETA sub 1 psTHETA dTHETA add {
    /Theta exch def
    /Xpoint Rsphere Theta cos psPHI dPHI sub cos mul mul def
    /Ypoint Rsphere Theta sin psPHI dPHI sub cos mul mul def
    /Zpoint Rsphere psPHI dPHI sub sin mul def
    CalculsPointsAfterTransformations
    CalcCoordinates
     lineto
     } for
psPHI dPHI sub 1 psPHI dPHI add {
    /Phi exch def
    /Xpoint Rsphere psTHETA dTHETA add cos Phi cos mul mul def
    /Ypoint Rsphere psTHETA dTHETA add sin Phi cos mul mul def
    /Zpoint Rsphere Phi sin mul def
    CalculsPointsAfterTransformations
    CalcCoordinates
     lineto
     } for
psTHETA dTHETA add -1 psTHETA dTHETA sub {
    /Theta exch def
    /Xpoint Rsphere Theta cos psPHI dPHI add cos mul mul def
    /Ypoint Rsphere Theta sin psPHI dPHI add cos mul mul def
    /Zpoint Rsphere psPHI dPHI add sin mul def
    CalculsPointsAfterTransformations
    CalcCoordinates
     lineto
     } for
psPHI dPHI add -1 psPHI dPHI sub {
    /Phi exch def
    /Xpoint Rsphere psTHETA dTHETA sub cos Phi cos mul mul def
    /Ypoint Rsphere psTHETA dTHETA sub sin Phi cos mul mul def
    /Zpoint Rsphere Phi sin mul def
    CalculsPointsAfterTransformations
    CalcCoordinates
     lineto
     } for
closepath
} if
} def
% Dodecahedron : 31 décembre 2003
% datas : Graphisme scientifique R.Dony
% Masson ed. page 240
/Dodecahedron{%
    /XA M11 0 mul M12 A 0.607062 mul mul add M13 A mul 0.794655 mul add CX add def
    /YA M21 0 mul M22 A 0.607062 mul mul add M23 A mul 0.794655 mul add CY add def
    /ZA M31 0 mul M32 A 0.607062 mul mul add M33 A mul 0.794655 mul add CZ add def
    /XB M11 A mul -0.5773503 mul M12 A mul  0.1875925 mul add M13 A mul 0.7946545 mul add CX add def
    /YB M21 A mul -0.5773503 mul M22 A mul  0.1875925 mul add M23 A mul 0.7946545 mul add CY add def
    /ZB M31 A mul -0.5773503 mul M32 A mul  0.1875925 mul add M33 A mul 0.7946545 mul add CZ add def
    /XC M11 A mul -0.3568221 mul M12 A mul -0.4911235 mul add M13 A mul 0.7946545 mul add CX add def
    /YC M21 A mul -0.3568221 mul M22 A mul -0.4911235 mul add M23 A mul 0.7946545 mul add CY add def
    /ZC M31 A mul -0.3568221 mul M32 A mul -0.4911235 mul add M33 A mul 0.7946545 mul add CZ add def
    /XD M11 A mul  0.3568221 mul M12 A mul -0.4911235 mul add M13 A mul 0.7946545 mul add CX add def
    /YD M21 A mul  0.3568221 mul M22 A mul -0.4911235 mul add M23 A mul 0.7946545 mul add CY add def
    /ZD M31 A mul  0.3568221 mul M32 A mul -0.4911235 mul add M33 A mul 0.7946545 mul add CZ add def
    /XE M11 A mul  0.5773503 mul M12 A mul  0.1875925 mul add M13 A mul 0.7946545 mul add CX add def
    /YE M21 A mul  0.5773503 mul M22 A mul  0.1875925 mul add M23 A mul 0.7946545 mul add CY add def
    /ZE M31 A mul  0.5773503 mul M32 A mul  0.1875925 mul add M33 A mul 0.7946545 mul add CZ add def
    /XF M11 A mul  0         mul M12 A mul   0.982247 mul add M13 A mul 0.175925  mul add CX add def
    /YF M21 A mul  0         mul M22 A mul   0.982247 mul add M23 A mul 0.175925  mul add CY add def
    /ZF M31 A mul  0         mul M32 A mul   0.982247 mul add M33 A mul 0.175925  mul add CZ add def
    /XG M11 A mul -0.9341724 mul M12 A mul   0.303531 mul add M13 A mul 0.1875925 mul add CX add def
    /YG M21 A mul -0.9341724 mul M22 A mul   0.303531 mul add M23 A mul 0.1875925 mul add CY add def
    /ZG M31 A mul -0.9341724 mul M32 A mul   0.303531 mul add M33 A mul 0.1875925 mul add CZ add def
    /XH M11 A mul -0.5773503 mul M12 A mul -0.7946545 mul add M13 A mul 0.1875925 mul add CX add def
    /YH M21 A mul -0.5773503 mul M22 A mul -0.7946545 mul add M23 A mul 0.1875925 mul add CY add def
    /ZH M31 A mul -0.5773503 mul M32 A mul -0.7946545 mul add M33 A mul 0.1875925 mul add CZ add def
    /XI M11 A mul  0.5773503 mul M12 A mul -0.7946545 mul add M13 A mul 0.1875925 mul add CX add def
    /YI M21 A mul  0.5773503 mul M22 A mul -0.7946545 mul add M23 A mul 0.1875925 mul add CY add def
    /ZI M31 A mul  0.5773503 mul M32 A mul -0.7946545 mul add M33 A mul 0.1875925 mul add CZ add def
    /XJ M11 A mul  0.9341724 mul M12 A mul   0.303531 mul add M13 A mul 0.1875925 mul add CX add def
    /YJ M21 A mul  0.9341724 mul M22 A mul   0.303531 mul add M23 A mul 0.1875925 mul add CY add def
    /ZJ M31 A mul  0.9341724 mul M32 A mul   0.303531 mul add M33 A mul 0.1875925 mul add CZ add def
    /XK M11 A mul  0         mul M12 A mul  -0.982247 mul add M13 A mul -0.1875925 mul add CX add def
    /YK M21 A mul  0         mul M22 A mul  -0.982247 mul add M23 A mul -0.1875925 mul add CY add def
    /ZK M31 A mul  0         mul M32 A mul  -0.982247 mul add M33 A mul -0.1875925 mul add CZ add def
    /XL M11 A mul  0.9341724 mul M12 A mul  -0.303531 mul add M13 A mul -0.1875925 mul add CX add def
    /YL M21 A mul  0.9341724 mul M22 A mul  -0.303531 mul add M23 A mul -0.1875925 mul add CY add def
    /ZL M31 A mul  0.9341724 mul M32 A mul  -0.303531 mul add M33 A mul -0.1875925 mul add CZ add def
    /XM M11 A mul  0.5773503 mul M12 A mul  0.7946545 mul add M13 A mul -0.1875925 mul add CX add def
    /YM M21 A mul  0.5773503 mul M22 A mul  0.7946545 mul add M23 A mul -0.1875925 mul add CY add def
    /ZM M31 A mul  0.5773503 mul M32 A mul  0.7946545 mul add M33 A mul -0.1875925 mul add CZ add def
    /XN M11 A mul -0.5773503 mul M12 A mul  0.7946545 mul add M13 A mul -0.1875925 mul add CX add def
    /YN M21 A mul -0.5773503 mul M22 A mul  0.7946545 mul add M23 A mul -0.1875925 mul add CY add def
    /ZN M31 A mul -0.5773503 mul M32 A mul  0.7946545 mul add M33 A mul -0.1875925 mul add CZ add def
    /XO M11 A mul -0.9341724 mul M12 A mul  -0.303531 mul add M13 A mul -0.1875925 mul add CX add def
    /YO M21 A mul -0.9341724 mul M22 A mul  -0.303531 mul add M23 A mul -0.1875925 mul add CY add def
    /ZO M31 A mul -0.9341724 mul M32 A mul  -0.303531 mul add M33 A mul -0.1875925 mul add CZ add def
    /XP M11 A mul -0.5773503 mul M12 A mul -0.1875925 mul add M13 A mul -0.7946545 mul add CX add def
    /YP M21 A mul -0.5773503 mul M22 A mul -0.1875925 mul add M23 A mul -0.7946545 mul add CY add def
    /ZP M31 A mul -0.5773503 mul M32 A mul -0.1875925 mul add M33 A mul -0.7946545 mul add CZ add def
    /XQ M11 A mul -0.3568221 mul M12 A mul  0.4911235 mul add M13 A mul -0.7946545 mul add CX add def
    /YQ M21 A mul -0.3568221 mul M22 A mul  0.4911235 mul add M23 A mul -0.7946545 mul add CY add def
    /ZQ M31 A mul -0.3568221 mul M32 A mul  0.4911235 mul add M33 A mul -0.7946545 mul add CZ add def
    /XR M11 A mul  0.3568221 mul M12 A mul  0.4911235 mul add M13 A mul -0.7946545 mul add CX add def
    /YR M21 A mul  0.3568221 mul M22 A mul  0.4911235 mul add M23 A mul -0.7946545 mul add CY add def
    /ZR M31 A mul  0.3568221 mul M32 A mul  0.4911235 mul add M33 A mul -0.7946545 mul add CZ add def
    /XS M11 A mul  0.5773503 mul M12 A mul -0.1875925 mul add M13 A mul -0.7946545 mul add CX add def
    /YS M21 A mul  0.5773503 mul M22 A mul -0.1875925 mul add M23 A mul -0.7946545 mul add CY add def
    /ZS M31 A mul  0.5773503 mul M32 A mul -0.1875925 mul add M33 A mul -0.7946545 mul add CZ add def
    /XT M11 0 mul M12 A -0.607062 mul mul add M13 A mul -0.794655 mul add CX add def
    /YT M21 0 mul M22 A -0.607062 mul mul add M23 A mul -0.794655 mul add CY add def
    /ZT M31 0 mul M32 A -0.607062 mul mul add M33 A mul -0.794655 mul add CZ add def
% Centres des faces : condition de visibilité
% FACE 1 pentagone régulier ABCDE
% OC1
    /XC1 XA XB add XC add XD add XE add 5 div def
    /YC1 YA YB add YC add YD add YE add 5 div def
    /ZC1 ZA ZB add ZC add ZD add ZE add 5 div def
% Normale à la face 1
    /NX1 XC1 CX sub def
    /NY1 YC1 CY sub def
    /NZ1 ZC1 CZ sub def
% rayon vers point de vue
    /RXvue1 XC1 XpointVue sub def
    /RYvue1 YC1 YpointVue sub def
    /RZvue1 ZC1 ZpointVue sub def
% produit scalaire
    /PS1 RXvue1 NX1 mul RYvue1 NY1 mul add RZvue1 NZ1 mul add def
% FACE 2 pentagone régulier EDILJ
% OC2
    /XC2 XE XD add XI add XL add XJ add 5 div def
    /YC2 YE YD add YI add YL add YJ add 5 div def
    /ZC2 ZE ZD add ZI add ZL add ZJ add 5 div def
% Normale à la face 2
    /NX2 XC2 CX sub def
    /NY2 YC2 CY sub def
    /NZ2 ZC2 CZ sub def
% rayon vers point de vue
    /RXvue2 XC2 XpointVue sub def
    /RYvue2 YC2 YpointVue sub def
    /RZvue2 ZC2 ZpointVue sub def
% produit scalaire
    /PS2 RXvue2 NX2 mul RYvue2 NY2 mul add RZvue2 NZ2 mul add def
% FACE 3 pentagone régulier EJMFA
% OC3
    /XC3 XE XJ add XM add XF add XA add 5 div def
    /YC3 YE YJ add YM add YF add YA add 5 div def
    /ZC3 ZE ZJ add ZM add ZF add ZA add 5 div def
% Normale à la face 2
    /NX3 XC3 CX sub def
    /NY3 YC3 CY sub def
    /NZ3 ZC3 CZ sub def
% rayon vers point de vue
    /RXvue3 XC3 XpointVue sub def
    /RYvue3 YC3 YpointVue sub def
    /RZvue3 ZC3 ZpointVue sub def
% produit scalaire
    /PS3 RXvue3 NX3 mul RYvue3 NY3 mul add RZvue3 NZ3 mul add def
% FACE 4 pentagone régulier AFNGB
% OC4
    /XC4 XA XF add XN add XG add XB add 5 div def
    /YC4 YA YF add YN add YG add YB add 5 div def
    /ZC4 ZA ZF add ZN add ZG add ZB add 5 div def
% Normale à la face 4
    /NX4 XC4 CX sub def
    /NY4 YC4 CY sub def
    /NZ4 ZC4 CZ sub def
% rayon vers point de vue
    /RXvue4 XC4 XpointVue sub def
    /RYvue4 YC4 YpointVue sub def
    /RZvue4 ZC4 ZpointVue sub def
% produit scalaire
    /PS4 RXvue4 NX4 mul RYvue4 NY4 mul add RZvue4 NZ4 mul add def
% FACE 5 pentagone régulier BGOHC
% OC5
    /XC5 XB XG add XO add XH add XC add 5 div def
    /YC5 YB YG add YO add YH add YC add 5 div def
    /ZC5 ZB ZG add ZO add ZH add ZC add 5 div def
% Normale à la face 5
    /NX5 XC5 CX sub def
    /NY5 YC5 CY sub def
    /NZ5 ZC5 CZ sub def
% rayon vers point de vue
    /RXvue5 XC5 XpointVue sub def
    /RYvue5 YC5 YpointVue sub def
    /RZvue5 ZC5 ZpointVue sub def
% produit scalaire
    /PS5 RXvue5 NX5 mul RYvue5 NY5 mul add RZvue5 NZ5 mul add def
% FACE 6 pentagone régulier CHKID
% OC6
    /XC6 XC XH add XK add XI add XD add 5 div def
    /YC6 YC YH add YK add YI add YD add 5 div def
    /ZC6 ZC ZH add ZK add ZI add ZD add 5 div def
% Normale à la face 6
    /NX6 XC6 CX sub def
    /NY6 YC6 CY sub def
    /NZ6 ZC6 CZ sub def
% rayon vers point de vue
    /RXvue6 XC6 XpointVue sub def
    /RYvue6 YC6 YpointVue sub def
    /RZvue6 ZC6 ZpointVue sub def
% produit scalaire
    /PS6 RXvue6 NX6 mul RYvue6 NY6 mul add RZvue6 NZ6 mul add def
% FACE 7 pentagone régulier KTSLI
% OC7
    /XC7 XK XT add XS add XL add XI add 5 div def
    /YC7 YK YT add YS add YL add YI add 5 div def
    /ZC7 ZK ZT add ZS add ZL add ZI add 5 div def
% Normale à la face 7
    /NX7 XC7 CX sub def
    /NY7 YC7 CY sub def
    /NZ7 ZC7 CZ sub def
% rayon vers point de vue
    /RXvue7 XC7 XpointVue sub def
    /RYvue7 YC7 YpointVue sub def
    /RZvue7 ZC7 ZpointVue sub def
% produit scalaire
    /PS7 RXvue7 NX7 mul RYvue7 NY7 mul add RZvue7 NZ7 mul add def
% FACE 8 pentagone régulier LSRMJ
% OC8
    /XC8 XL XS add XR add XM add XJ add 5 div def
    /YC8 YL YS add YR add YM add YJ add 5 div def
    /ZC8 ZL ZS add ZR add ZM add ZJ add 5 div def
% Normale à la face 8
    /NX8 XC8 CX sub def
    /NY8 YC8 CY sub def
    /NZ8 ZC8 CZ sub def
% rayon vers point de vue
    /RXvue8 XC8 XpointVue sub def
    /RYvue8 YC8 YpointVue sub def
    /RZvue8 ZC8 ZpointVue sub def
% produit scalaire
    /PS8 RXvue8 NX8 mul RYvue8 NY8 mul add RZvue8 NZ8 mul add def
% FACE 9 pentagone régulier MRQNF
% OC9
    /XC9 XM XR add XQ add XN add XF add 5 div def
    /YC9 YM YR add YQ add YN add YF add 5 div def
    /ZC9 ZM ZR add ZQ add ZN add ZF add 5 div def
% Normale à la face 6
    /NX9 XC9 CX sub def
    /NY9 YC9 CY sub def
    /NZ9 ZC9 CZ sub def
% rayon vers point de vue
    /RXvue9 XC9 XpointVue sub def
    /RYvue9 YC9 YpointVue sub def
    /RZvue9 ZC9 ZpointVue sub def
% produit scalaire
    /PS9 RXvue9 NX9 mul RYvue9 NY9 mul add RZvue9 NZ9 mul add def
% FACE 10 pentagone régulier NQPOG
% OC10
    /XC10 XN XQ add XP add XO add XG add 5 div def
    /YC10 YN YQ add YP add YO add YG add 5 div def
    /ZC10 ZN ZQ add ZP add ZO add ZG add 5 div def
% Normale à la face 6
    /NX10 XC10 CX sub def
    /NY10 YC10 CY sub def
    /NZ10 ZC10 CZ sub def
% rayon vers point de vue
    /RXvue10 XC10 XpointVue sub def
    /RYvue10 YC10 YpointVue sub def
    /RZvue10 ZC10 ZpointVue sub def
% produit scalaire
    /PS10 RXvue10 NX10 mul RYvue10 NY10 mul add RZvue10 NZ10 mul add def
% FACE 11 pentagone régulier OPTKH
% OC11
    /XC11 XO XP add XT add XK add XH add 5 div def
    /YC11 YO YP add YT add YK add YH add 5 div def
    /ZC11 ZO ZP add ZT add ZK add ZH add 5 div def
% Normale à la face 11
    /NX11 XC11 CX sub def
    /NY11 YC11 CY sub def
    /NZ11 ZC11 CZ sub def
% rayon vers point de vue
    /RXvue11 XC11 XpointVue sub def
    /RYvue11 YC11 YpointVue sub def
    /RZvue11 ZC11 ZpointVue sub def
% produit scalaire
    /PS11 RXvue11 NX11 mul RYvue11 NY11 mul add RZvue11 NZ11 mul add def
% FACE 12 pentagone régulier PQRST
% OC12
    /XC12 XP XQ add XR add XS add XT add 5 div def
    /YC12 YP YQ add YR add YS add YT add 5 div def
    /ZC12 ZP ZQ add ZR add ZS add ZT add 5 div def
% Normale à la face 12
    /NX12 XC12 CX sub def
    /NY12 YC12 CY sub def
    /NZ12 ZC12 CZ sub def
% rayon vers point de vue
    /RXvue12 XC12 XpointVue sub def
    /RYvue12 YC12 YpointVue sub def
    /RZvue12 ZC12 ZpointVue sub def
% produit scalaire
    /PS12 RXvue12 NX12 mul RYvue12 NY12 mul add RZvue12 NZ12 mul add def
% faceOne ABDCE
PS1 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YA def
    /Zcote ZA def
    /Xabscisse XA def
    CalcCoordinates
     moveto
    /Zcote ZB def
    /Xabscisse XB def
    /Yordonnee YB def
    CalcCoordinates
    lineto
    /Zcote ZC def
    /Xabscisse XC def
    /Yordonnee YC  def
    CalcCoordinates
    lineto
    /Zcote ZD def
    /Xabscisse XD def
    /Yordonnee YD def
    CalcCoordinates
    lineto
    /Zcote ZE def
    /Xabscisse XE def
    /Yordonnee YE def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.1 0.1 0 setcmykcolor
fill
grestore
stroke
} if
% face2 EDILJ
PS2 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YE def
    /Zcote ZE def
    /Xabscisse XE def
    CalcCoordinates
     moveto
    /Zcote ZD def
    /Xabscisse XD def
    /Yordonnee YD def
    CalcCoordinates
    lineto
    /Zcote ZI def
    /Xabscisse XI def
    /Yordonnee YI  def
    CalcCoordinates
    lineto
    /Zcote ZL def
    /Xabscisse XL def
    /Yordonnee YL def
    CalcCoordinates
    lineto
    /Zcote ZJ def
    /Xabscisse XJ def
    /Yordonnee YJ def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.15 0.15 0 setcmykcolor
fill
grestore
stroke
} if
% face3 EJMFA
PS3 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YE def
    /Zcote ZE def
    /Xabscisse XE def
    CalcCoordinates
     moveto
    /Zcote ZJ def
    /Xabscisse XJ def
    /Yordonnee YJ def
    CalcCoordinates
    lineto
    /Zcote ZM def
    /Xabscisse XM def
    /Yordonnee YM  def
    CalcCoordinates
    lineto
    /Zcote ZF def
    /Xabscisse XF def
    /Yordonnee YF def
    CalcCoordinates
    lineto
    /Zcote ZA def
    /Xabscisse XA def
    /Yordonnee YA def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.2 0.2 0 setcmykcolor
fill
grestore
stroke
} if
% face4 AFNGB
PS4 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YA def
    /Zcote ZA def
    /Xabscisse XA def
    CalcCoordinates
     moveto
    /Zcote ZF def
    /Xabscisse XF def
    /Yordonnee YF def
    CalcCoordinates
    lineto
    /Zcote ZN def
    /Xabscisse XN def
    /Yordonnee YN  def
    CalcCoordinates
    lineto
    /Zcote ZG def
    /Xabscisse XG def
    /Yordonnee YG def
    CalcCoordinates
    lineto
    /Zcote ZB def
    /Xabscisse XB def
    /Yordonnee YB def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.25 0.25 0 setcmykcolor
fill
grestore
stroke
} if
% face5 BGOHC
PS5 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YB def
    /Zcote ZB def
    /Xabscisse XB def
    CalcCoordinates
     moveto
    /Zcote ZG def
    /Xabscisse XG def
    /Yordonnee YG def
    CalcCoordinates
    lineto
    /Zcote ZO def
    /Xabscisse XO def
    /Yordonnee YO  def
    CalcCoordinates
    lineto
    /Zcote ZH def
    /Xabscisse XH def
    /Yordonnee YH def
    CalcCoordinates
    lineto
    /Zcote ZC def
    /Xabscisse XC def
    /Yordonnee YC def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.3 0.3 0 setcmykcolor
fill
grestore
stroke
} if
% face6 CHKID
PS6 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YC def
    /Zcote ZC def
    /Xabscisse XC def
    CalcCoordinates
     moveto
    /Zcote ZH def
    /Xabscisse XH def
    /Yordonnee YH def
    CalcCoordinates
    lineto
    /Zcote ZK def
    /Xabscisse XK def
    /Yordonnee YK  def
    CalcCoordinates
    lineto
    /Zcote ZI def
    /Xabscisse XI def
    /Yordonnee YI def
    CalcCoordinates
    lineto
    /Zcote ZD def
    /Xabscisse XD def
    /Yordonnee YD def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.35 0.35 0 setcmykcolor
fill
grestore
stroke
} if
% face7 KTSLI
PS7 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YK def
    /Zcote ZK def
    /Xabscisse XK def
    CalcCoordinates
     moveto
    /Zcote ZT def
    /Xabscisse XT def
    /Yordonnee YT def
    CalcCoordinates
    lineto
    /Zcote ZS def
    /Xabscisse XS def
    /Yordonnee YS  def
    CalcCoordinates
    lineto
    /Zcote ZL def
    /Xabscisse XL def
    /Yordonnee YL def
    CalcCoordinates
    lineto
    /Zcote ZI def
    /Xabscisse XI def
    /Yordonnee YI def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.4 0.4 0 setcmykcolor
fill
grestore
stroke
} if
% face8 LSRMJ
PS8 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YL def
    /Zcote ZL def
    /Xabscisse XL def
    CalcCoordinates
     moveto
    /Zcote ZS def
    /Xabscisse XS def
    /Yordonnee YS def
    CalcCoordinates
    lineto
    /Zcote ZR def
    /Xabscisse XR def
    /Yordonnee YR  def
    CalcCoordinates
    lineto
    /Zcote ZM def
    /Xabscisse XM def
    /Yordonnee YM def
    CalcCoordinates
    lineto
    /Zcote ZJ def
    /Xabscisse XJ def
    /Yordonnee YJ def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.45 0.45 0 setcmykcolor
fill
grestore
stroke
} if
% face9 MRQNF
PS9 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YM def
    /Zcote ZM def
    /Xabscisse XM def
    CalcCoordinates
     moveto
    /Zcote ZR def
    /Xabscisse XR def
    /Yordonnee YR def
    CalcCoordinates
    lineto
    /Zcote ZQ def
    /Xabscisse XQ def
    /Yordonnee YQ  def
    CalcCoordinates
    lineto
    /Zcote ZN def
    /Xabscisse XN def
    /Yordonnee YN def
    CalcCoordinates
    lineto
    /Zcote ZF def
    /Xabscisse XF def
    /Yordonnee YF def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.5 0.5 0 setcmykcolor
fill
grestore
stroke
} if
% face10 NQPOG
PS10 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YN def
    /Zcote ZN def
    /Xabscisse XN def
    CalcCoordinates
     moveto
    /Zcote ZQ def
    /Xabscisse XQ def
    /Yordonnee YQ def
    CalcCoordinates
    lineto
    /Zcote ZP def
    /Xabscisse XP def
    /Yordonnee YP  def
    CalcCoordinates
    lineto
    /Zcote ZO def
    /Xabscisse XO def
    /Yordonnee YO def
    CalcCoordinates
    lineto
    /Zcote ZG def
    /Xabscisse XG def
    /Yordonnee YG def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.55 0.55 0 setcmykcolor
fill
grestore
stroke
} if
% face11 OPTKH
PS11 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YO def
    /Zcote ZO def
    /Xabscisse XO def
    CalcCoordinates
     moveto
    /Zcote ZP def
    /Xabscisse XP def
    /Yordonnee YP def
    CalcCoordinates
    lineto
    /Zcote ZT def
    /Xabscisse XT def
    /Yordonnee YT  def
    CalcCoordinates
    lineto
    /Zcote ZK def
    /Xabscisse XK def
    /Yordonnee YK def
    CalcCoordinates
    lineto
    /Zcote ZH def
    /Xabscisse XH def
    /Yordonnee YH def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.6 0.6 0 setcmykcolor
fill
grestore
stroke
} if
% face12 PQRST
PS12 0 Condition { %
reduction reduction scale
1 setlinejoin
newpath
    /Yordonnee YP def
    /Zcote ZP def
    /Xabscisse XP def
    CalcCoordinates
     moveto
    /Zcote ZQ def
    /Xabscisse XQ def
    /Yordonnee YQ def
    CalcCoordinates
    lineto
    /Zcote ZR def
    /Xabscisse XR def
    /Yordonnee YR  def
    CalcCoordinates
    lineto
    /Zcote ZS def
    /Xabscisse XS def
    /Yordonnee YS def
    CalcCoordinates
    lineto
    /Zcote ZT def
    /Xabscisse XT def
    /Yordonnee YT def
    CalcCoordinates
    lineto
closepath
gsave
0.05 0.65 0.65 0 setcmykcolor
fill
grestore
stroke
} if
}
def
end
