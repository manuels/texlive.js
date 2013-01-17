%version 14 May 2004
% allégée de 3D.pro
/tx@mapII3DDict 100 dict def
tx@mapII3DDict begin
%
 /CalculsPoints{%
  /region exch def
  newpath
  /nbr region length def % nombre de régions
  nbr 2 sub -2 2  {
   /Counter exch def
     region Counter get
     /Y exch def
     region Counter 1 add get
     /X exch def
     /Xpoint { Y cos X cos mul Rsphere mul } def
     /Ypoint { Y cos X sin mul Rsphere mul } def
     /Zpoint { Y sin Rsphere mul } def
     CalculsPointsAfterTransformations
     CalcCoordinates
     Test
     PS 0 lt {% marque le point
        moveto
        exit % termine
        } {pop pop} ifelse
  } for
  /ncount 0 def % hv 2004-05-04
  /stepPoint Counter step div 2 lt { 1 }{ step } ifelse def  % hv 2004-05-04
  Counter 2 sub -2 2 {
    /Counter exch def
    /ncount ncount 1 add def % hv 2004-05-04
    ncount stepPoint ge Counter 2 le or { % hv 2004-05-04
      region Counter get
      /Y exch def
      region Counter 1 add get
      /X exch def
      /Xpoint { Y cos X cos mul Rsphere mul } def
      /Ypoint { Y cos X sin mul Rsphere mul } def
      /Zpoint { Y sin Rsphere mul } def
      CalculsPointsAfterTransformations
      CalcCoordinates
      Test
      PS 0 lt { lineto }{ pop pop } ifelse
      /ncount 0 def % hv 2004-05-04
    }{ /ncount ncount 1 add def } ifelse % hv 2004-05-04
  } for
} def
%
/MatriceTransformation{%
    /Sin1 THETA sin def
    /Sin2 PHI sin def
    /Cos1 THETA cos def
    /Cos2 PHI cos def
    /Cos1Sin2 Cos1 Sin2 mul def
    /Sin1Sin2 Sin1 Sin2 mul def
    /Cos1Cos2 Cos1 Cos2 mul def
    /Sin1Cos2 Sin1 Cos2 mul def
    /XpointVue Dobs Cos1Cos2 mul def
    /YpointVue Dobs Sin1Cos2 mul def
    /ZpointVue Dobs Sin2 mul def
    /M11 RotZ cos RotY cos mul def
    /M12 RotZ cos RotY sin mul RotX sin mul
         RotZ sin RotX cos mul sub def
    /M13 RotZ cos RotY sin mul RotX cos mul
         RotZ sin RotX sin mul add def
    /M21 RotZ sin RotY cos mul def
    /M22 RotZ sin RotY sin RotX sin mul mul
         RotZ cos RotX cos mul add def
    /M23 RotZ sin RotY sin mul RotX cos mul
         RotZ cos RotX sin mul sub def
    /M31 RotY sin neg def
    /M32 RotX sin RotY cos mul def
    /M33 RotX cos RotY cos mul def
   } def
/CalcCoordinates{%
  formulesTroisD
  Xi xunit Yi yunit
} def
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
    /Xabscisse M11 Xpoint mul M12 Ypoint mul add M13 Zpoint mul add def
    /Yordonnee M21 Xpoint mul M22 Ypoint mul add M23 Zpoint mul add def
    /Zcote M31 Xpoint mul M32 Ypoint mul add M33 Zpoint mul add def
    }
def
%
/Test { % test de visibilité d'un point
% rayon vers point de vue
    /RXvue Xabscisse XpointVue sub def
    /RYvue Yordonnee YpointVue sub def
    /RZvue Zcote ZpointVue sub def
% test de visibilité
    /PS RXvue Xabscisse mul % produit scalaire
    RYvue Yordonnee mul add
    RZvue Zcote mul add
    def
} def
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
    /nXfacette xCentreFacette def
    /nYfacette yCentreFacette def
    /nZfacette zCentreFacette def
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
gsave
0 setgray
stroke
grestore
} def
%
/DrawCitys {
  /CITY exch def
  /Rayon exch def
  /nbr CITY length def % nombre de villes
  0 1 nbr 1 sub {
    /compteur exch def
    CITY compteur get aload pop
    /X exch def /Y exch def
    /Xpoint { Y cos X cos mul Rsphere mul } def
    /Ypoint { Y cos X sin mul Rsphere mul } def
    /Zpoint { Y sin Rsphere mul } def
    CalculsPointsAfterTransformations
    CalcCoordinates
    Test
    PS 0 lt %
      { 1 0 0 setrgbcolor newpath Rayon 0 360 arc closepath fill }{ pop pop } ifelse
  } for
} def
end
