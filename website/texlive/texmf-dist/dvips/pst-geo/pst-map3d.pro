% premiere version 29 novembre 2003
% entierement modifiee le 11/08/2009
% allegee de 3D.pro
% version 1.01 2009-08-11 (hv)
% manuel.luque27@gmail.com
% hvoss@tug.org
%
/tx@map3DDict 100 dict def
tx@map3DDict begin
%%
/CalcCoor{
     /Y exch def /X exch def
     /Xpoint Y cos X cos mul Rsphere mul def
     /Ypoint Y cos X sin mul Rsphere mul def
     /Zpoint Y sin Rsphere mul def
     } def
     
 /CompteurRegions{%
/regions_visibles [] def
/compteur 0 def
{
   /region exch def
   /nbr region length def % nombre de points
   0 1 nbr 1 sub {
     /counter exch def % pour memoriser le premier point vu 
     region counter get aload pop
     CalcCoor
     CalculsPointsAfterTransformations
     Test
     PS condition {% marque le point
   /regions_visibles [regions_visibles aload pop compteur ] def
        exit % termine
     } if
  } for
 /compteur compteur 1 add def
} forall
/TableauRegionsVisibles [
0 1 regions_visibles length 1 sub {
    /NoRegion exch def
    /No regions_visibles NoRegion get def
    REGION No get
    } for
] def
TableauRegionsVisibles
} def

/CalculsPointsRegion{%
    /region1 exch def
     region1 0 get aload pop
     CalcCoor
        newpath
        CalculsPointsAfterTransformations
        CalcCoordinates
        Test 
        PS condition { moveto }{ 2 mul exch 2 mul exch moveto} ifelse
%
    0 1 region1 length 1 sub {
    /NoPoint exch def
    region1 NoPoint get aload pop
    CalcCoor
        CalculsPointsAfterTransformations
        CalcCoordinates
        Test
        PS condition { lineto }{ 2 mul exch 2 mul exch lineto} ifelse
    } for 
} def
   
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
% RotZ -> RotX -> RotY
/MatriceTransformationZXY{%
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
    /M11 RotZ cos RotY cos mul RotZ sin RotX sin mul RotY sin mul sub def
    /M12 RotZ sin RotY cos mul RotZ cos RotX sin mul RotY sin mul add def
    /M13 RotX cos RotY sin mul def
    /M21 RotZ sin RotX cos mul neg def
    /M22 RotZ cos RotX cos mul def
    /M23 RotX sin neg def
    /M31 RotZ cos neg RotY sin mul RotZ sin RotX sin mul RotY cos mul sub def
    /M32 RotZ sin neg RotY sin mul RotZ cos RotX sin mul RotY cos mul add def
    /M33 RotX cos RotY cos mul def
   } def
%
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
} def
%
/CalculsPointsAfterTransformations{%
    /Xabscisse M11 Xpoint mul M12 Ypoint mul add M13 Zpoint mul add def
    /Yordonnee M21 Xpoint mul M22 Ypoint mul add M23 Zpoint mul add def
    /Zcote M31 Xpoint mul M32 Ypoint mul add M33 Zpoint mul add def
    }
def
%
/Test { % test de visibilite d'un point
% rayon vers point de vue
    /RXvue XpointVue Xabscisse sub def
    /RYvue YpointVue Yordonnee sub def
    /RZvue ZpointVue Zcote sub def
% test de visibilite
    /PS RXvue Xabscisse mul % produit scalaire
        RYvue Yordonnee mul add
        RZvue Zcote mul add
    def
} def
%
/MaillageSphere {
gsave
maillagewidth
maillagecolor 
0.25 setlinewidth
0 increment 360 increment sub {%
    /theta exch def
-90 increment 90 increment sub {%
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
% normale a la facette
    /nXfacette xCentreFacette def
    /nYfacette yCentreFacette def
    /nZfacette zCentreFacette def
% rayon vers point de vue
    /RXvue XpointVue xCentreFacette sub def
    /RYvue YpointVue yCentreFacette sub def
    /RZvue ZpointVue zCentreFacette sub def
% test de visibilite
    /PSfacette RXvue nXfacette mul
    RYvue nYfacette mul add
    RZvue nZfacette mul add
    def
PSfacette condition {
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
stroke
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
  /Xpoint {%
    Y cos X cos mul Rsphere mul
    } def
  /Ypoint {%
    Y cos X sin mul Rsphere mul
    } def
  /Zpoint { Y sin Rsphere mul } def
CalculsPointsAfterTransformations
    CalcCoordinates
Test
PS condition %
 {1 0 0 setrgbcolor newpath Rayon 0 360 arc closepath fill}{pop pop}
 ifelse
} for
} def

/oceans_seas_hatched {
-90 circlesep 90 {
  /latitude_parallel exch def
  Parallel
  circlecolor
  circlewidth
  stroke
  } for
 } def

/meridien {
% liste des points vus
/TabPointsVusNeg[
-180 1 0{ % for
    /phi exch def
    /Xpoint Rsphere longitude_meridien cos mul phi cos mul def
    /Ypoint Rsphere longitude_meridien sin mul phi cos mul def
    /Zpoint Rsphere phi sin mul def
CalculsPointsAfterTransformations
    Test
    PS condition { phi } if
    } for 
] def 
%
/TabPointsVusPos[
0 1 180{ % for
    /phi exch def
    /Xpoint Rsphere longitude_meridien cos mul phi cos mul def
    /Ypoint Rsphere longitude_meridien sin mul phi cos mul def
    /Zpoint Rsphere phi sin mul def
CalculsPointsAfterTransformations
    Test
    PS condition { phi } if
    } for 
] def  
% plus grand et plus petit

/phi_minNeg 0 def
/phi_maxNeg -180 def

0 1 TabPointsVusNeg length 1 sub { % for
    /iPoint exch def
    /phi TabPointsVusNeg iPoint get def
     phi phi_minNeg le {/phi_minNeg phi def} if
    } for
0 1 TabPointsVusNeg length 1 sub { % for
    /iPoint exch def
    /phi TabPointsVusNeg iPoint get def
    phi phi_maxNeg ge {/phi_maxNeg phi def} if
    } for
    
/phi_minPos 180 def
/phi_maxPos   0 def 
    
0 1 TabPointsVusPos length 1 sub { % for
    /iPoint exch def
    /phi TabPointsVusPos iPoint get def
     phi phi_minPos le {/phi_minPos phi def} if
    } for
0 1 TabPointsVusPos length 1 sub { % for
    /iPoint exch def
    /phi TabPointsVusPos iPoint get def
     phi phi_maxPos ge {/phi_maxPos phi def} if
    } for

     /Xpoint Rsphere longitude_meridien cos mul phi_minNeg cos mul def
     /Ypoint Rsphere longitude_meridien sin mul phi_minNeg cos mul def
     /Zpoint Rsphere phi_minNeg sin mul def 
     CalculsPointsAfterTransformations
     CalcCoordinates
     moveto   
     
phi_minNeg 1 phi_maxNeg{
 /phi exch def
     /Xpoint Rsphere longitude_meridien cos mul phi cos mul def
     /Ypoint Rsphere longitude_meridien sin mul phi cos mul def
     /Zpoint Rsphere phi sin mul def
CalculsPointsAfterTransformations
   CalcCoordinates
   lineto
   } for
meridiencolor
meridienwidth
stroke

     /Xpoint Rsphere longitude_meridien cos mul phi_minPos cos mul def
     /Ypoint Rsphere longitude_meridien sin mul phi_minPos cos mul def
     /Zpoint Rsphere phi_minPos sin mul def 
     CalculsPointsAfterTransformations
     CalcCoordinates
     moveto 
     
phi_minPos 1 phi_maxPos{
 /phi exch def
     /Xpoint Rsphere longitude_meridien cos mul phi cos mul def
     /Ypoint Rsphere longitude_meridien sin mul phi cos mul def
     /Zpoint Rsphere phi sin mul def
CalculsPointsAfterTransformations
   CalcCoordinates
   lineto
   } for
meridiencolor
meridienwidth
stroke
}
def

%% macros de Jean-Paul Vignault
%% dans solides.pro
%% produit vectoriel de deux vecteurs 3d
/vectprod3d { %% x1 y1 z1 x2 y2 z2
6 dict begin
   /zp exch def
   /yp exch def
   /xp exch def
   /z exch def
   /y exch def
   /x exch def
   y zp mul z yp mul sub
   z xp mul x zp mul sub
   x yp mul y xp mul sub
end
} def

% coordonnees spheriques -> coordonnees cartesiennes
/rtp2xyz {
6 dict begin
   /phi exch def
   /theta exch def
   /r exch def
   /x phi cos theta cos mul r mul def
   /y phi cos theta sin mul r mul def
   /z phi sin r mul def
   x y z
end
} def

%% norme d'un vecteur 3d
/norme3d { %% x y z
3 dict begin
   /z exch def
   /y exch def
   /x exch def
   x dup mul y dup mul add z dup mul add sqrt
end
} def

%% duplique le vecteur 3d
/dupp3d { %% x y z
        3 copy
} def
/dupv3d {dupp3d} def

%%%%% ### mulv3d ###
%% (scalaire)*(vecteur 3d) Attention : dans l autre sens !
/mulv3d { %% x y z lambda
4 dict begin
   /lambda exch def
   /z exch def
   /y exch def
   /x exch def
   x lambda mul
   y lambda mul
   z lambda mul
end
} def

%%%%% ### defpoint3d ###
%% creation du point A a partir de xA yA yB et du nom /A
/defpoint3d { %% xA yA zA /nom
1 dict begin
   /memo exch def
   [ 4 1 roll ] cvx memo exch
end def
}def

%%%%% ### scalprod3d ###
%% produit scalaire de deux vecteurs 3d
/scalprod3d { %% x1 y1 z1 x2 y2 z2
6 dict begin
   /zp exch def
   /yp exch def
   /xp exch def
   /z exch def
   /y exch def
   /x exch def
   x xp mul y yp mul add z zp mul add
end
} def

%%%%% ### addv3d ###
%% addition de deux vecteurs 3d
/addv3d { %% x1 y1 z1 x2 y2 z2
6 dict begin
   /zp exch def
   /yp exch def
   /xp exch def
   /z exch def
   /y exch def
   /x exch def
   x xp add
   y yp add
   z zp add
end
} def

/arccos {
   dup
   dup mul neg 1 add sqrt
   exch
   atan
} def
%% fin des macros de Jean-Paul Vignault
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### rotV3d ###
%% rotation autour d'un vecteur u
%% defini par (ux,uy,uz)
%% ici l'axe des peles de la Terre
%% d'un angle theta
/rotV3d {
15 dict begin
    /N2uvw ux dup mul uy dup mul add uz dup mul add def
    /N2uv  ux dup mul uy dup mul add def
    /N2vw  uz dup mul uy dup mul add def
    /N2uw  uz dup mul ux dup mul add def
    /z exch def /y exch def /x exch def
    /uxvywz ux x mul uy y mul add uz z mul add def
    /uxvy   ux x mul uy y mul add def
    /uxwz   ux x mul uz z mul add def
    /vywz   uy y mul uz z mul add def
    /_wyvz  uz y mul neg uy z mul add def
    /wx_uz  uz x mul ux z mul sub def
    /_vxuy  uy x mul neg ux y mul add def
    ux uxvywz mul x N2vw mul ux vywz mul sub theta cos mul add N2uvw sqrt _wyvz mul theta sin mul add N2uvw div
    uy uxvywz mul y N2uw mul uy uxwz mul sub theta cos mul add N2uvw sqrt wx_uz mul theta sin mul add N2uvw div
    uz uxvywz mul z N2uv mul uz uxvy mul sub theta cos mul add N2uvw sqrt _vxuy mul theta sin mul add N2uvw div
end
 } def


/the_night{
50 dict begin
 /theta {180 hour 15 mul sub} bind def
% direction des rayons du soleil au solstice d'hiver
   u1 u2 u3 /u defpoint3d
% vecteur normal dans le plan meridien
% la latitude
%  /phi0 u2 neg u3 atan def
u1 u2 u3 rotV3d
    /nZ exch def /nY exch def pop
  /phi0 nY neg nZ atan def
% vecteur normal dans le plan equateur
   /theta0 u1 neg u2 atan def
    theta0 cos theta0 sin 0 /v defpoint3d
% w tels que le triadre u v w soit direct
   u v vectprod3d dupp3d norme3d 1 exch div mulv3d /w defpoint3d
/TabPointsVusNeg[
-180 1 0{ % for
   /t exch def
    v t cos Rsphere mul mulv3d
    w t sin Rsphere mul mulv3d
         addv3d
    rotV3d
   /Zpoint exch def /Ypoint exch def /Xpoint exch def
   CalculsPointsAfterTransformations
    Test
    PS 0 ge { t } if
    } for
] def
%
/TabPointsVusPos[
0 1 180{ % for
   /t exch def
    v t cos Rsphere mul mulv3d
    w t sin Rsphere mul mulv3d
         addv3d
    rotV3d
   /Zpoint exch def /Ypoint exch def /Xpoint exch def
   CalculsPointsAfterTransformations
    Test
    PS 0 ge { t } if
    } for
] def
/t_minNeg 0 def
/t_maxNeg -180 def

0 1 TabPointsVusNeg length 1 sub { % for
    /iPoint exch def
    /t TabPointsVusNeg iPoint get def
     t t_minNeg le {/t_minNeg t def} if
    } for
0 1 TabPointsVusNeg length 1 sub { % for
    /iPoint exch def
    /t TabPointsVusNeg iPoint get def
     t t_maxNeg ge {/t_maxNeg t def} if
    } for

/t_minPos 180 def
/t_maxPos   0 def

0 1 TabPointsVusPos length 1 sub { % for
    /iPoint exch def
    /t TabPointsVusPos iPoint get def
     t t_minPos le {/t_minPos t def} if
    } for
0 1 TabPointsVusPos length 1 sub { % for
    /iPoint exch def
    /t TabPointsVusPos iPoint get def
     t t_maxPos ge {/t_maxPos t def} if
    } for

theta -90 ge theta 90 le and {
          v t_minNeg cos Rsphere mul mulv3d
          w t_minNeg sin Rsphere mul mulv3d
         addv3d
   rotV3d
   /Zpoint exch def /Ypoint exch def /Xpoint exch def
   CalculsPointsAfterTransformations
   CalcCoordinates
     moveto

t_minNeg 1 t_maxPos{
         /t  exch def
          v t cos Rsphere mul mulv3d
          w t sin Rsphere mul mulv3d
         addv3d
   rotV3d
   /Zpoint exch def /Ypoint exch def /Xpoint exch def
   CalculsPointsAfterTransformations
   CalcCoordinates
   lineto
   } for
phi0 1 phi0 180 add { /t exch def
RsphereScreen t cos mul 
RsphereScreen t sin mul 
   lineto
   } for
}{
          v t_minPos cos Rsphere mul mulv3d
          w t_minPos sin Rsphere mul mulv3d
         addv3d
   rotV3d
   /Zpoint exch def /Ypoint exch def /Xpoint exch def
   CalculsPointsAfterTransformations
   CalcCoordinates
     moveto

t_minPos 1 t_maxPos {
         /t  exch def
          v t cos Rsphere mul mulv3d
          w t sin Rsphere mul mulv3d
         addv3d
   rotV3d
   /Zpoint exch def /Ypoint exch def /Xpoint exch def
   CalculsPointsAfterTransformations
   CalcCoordinates
   lineto
   } for
t_minNeg 1 t_maxNeg {
         /t  exch def
          v t cos Rsphere mul mulv3d
          w t sin Rsphere mul mulv3d
         addv3d
   rotV3d
   /Zpoint exch def /Ypoint exch def /Xpoint exch def
   CalculsPointsAfterTransformations
   CalcCoordinates
   lineto
   } for
phi0 1 phi0 180 add { /t exch def
RsphereScreen t cos mul 
RsphereScreen t sin mul 
   lineto
   } for
} ifelse
closepath
end
}
def

% ondes seismes
/ondes {
 50 dict begin
    /l exch def % latitude : phi
    /L exch def % longitude : theta
    /dlmax exch def % intervalle maximal en degres
    /nbr exch def % nombre de cercles
    /dl dlmax nbr div def
% le vecteur unitaire normal
% a la sphere au point considere
  L cos l cos mul
  L sin l cos mul
  l sin 
  /u defpoint3d
1 1 nbr {  /i exch def
    /l' l dl i mul add def
    /r  Rsphere dl i mul cos mul def
    /r' Rsphere dl i mul sin mul def
% le centre de l'onde
    /x_o r L cos mul l cos mul def
    /y_o r L sin mul l cos mul def
    /z_o r l sin mul def
% un vecteur unitaire du plan du cercle
% perpendiculaire a n et dans le plan meridien
% donc meme longitude
    /x_I Rsphere L cos mul l' cos mul def
    /y_I Rsphere L sin mul l' cos mul def
    /z_I Rsphere l' sin mul def
   x_I x_o sub
   y_I y_o sub
   z_I z_o sub
   /uOI defpoint3d
   uOI dupp3d norme3d 1 exch div mulv3d 
   /v defpoint3d
% un vecteur w normal a u et v dans le plan du cercle
   u v vectprod3d dupp3d norme3d 1 exch div mulv3d 
   /w defpoint3d
% on decrit le cercle
          v 0 cos r' mul mulv3d
          w 0 sin r' mul mulv3d
         addv3d x_o y_o z_o addv3d
   /Zpoint exch def /Ypoint exch def /Xpoint exch def
   MatriceTransformation  %%%%%%%%%%%%%%%%% hv 2009-08-11
   CalculsPointsAfterTransformations
   CalcCoordinates
   moveto
   0 1 360 {
         /t  exch def
          v t cos r' mul mulv3d
          w t sin r' mul mulv3d
         addv3d x_o y_o z_o addv3d
     /Zpoint exch def /Ypoint exch def /Xpoint exch def
     CalculsPointsAfterTransformations
     CalcCoordinates
     lineto
   } for 
   stroke
 } for
end
} def

%% nouvelle construction des paralleles
/Parallel {
0 1 360{ % for
    /theta exch def
    /Xpoint Rsphere theta cos mul latitude_parallel cos mul def
    /Ypoint Rsphere theta sin mul latitude_parallel cos mul def
    /Zpoint Rsphere latitude_parallel sin mul def
CalculsPointsAfterTransformations
    Test
    PS condition {
    CalcCoordinates 
    moveto
    /theta theta 1 add def
    /Xpoint Rsphere theta cos mul latitude_parallel cos mul def
    /Ypoint Rsphere theta sin mul latitude_parallel cos mul def
    /Zpoint Rsphere latitude_parallel sin mul def
CalculsPointsAfterTransformations
Test
    PS condition {
CalcCoordinates 
    lineto }
    {
        /theta theta 1 sub def
    /Xpoint Rsphere theta cos mul latitude_parallel cos mul def
    /Ypoint Rsphere theta sin mul latitude_parallel cos mul def
    /Zpoint Rsphere latitude_parallel sin mul def
CalculsPointsAfterTransformations 
CalcCoordinates 
    lineto
     } ifelse
    } if
    } for 
} def 
end
