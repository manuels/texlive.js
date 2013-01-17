%!
% PostScript prologue for pst-solides3d.tex.
% Version 4.20, 2010/04/27
%
%% COPYRIGHT 2009/10 by Jean-Paul Vignault
%% opacity changes by Herbert Voss
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt.
%
/SolidesDict 100 dict def
/SolidesbisDict 100 dict def
SolidesDict begin

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %% les variables globales gerees par PSTricks %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %% les lignes dessous sont a decommenter si l on veut utiliser le
%% %% fichier solides.pro independamment du package PSTricks
%% /Dobs 20 def
%% /THETA 20 def
%% /PHI 50 def
%% /Decran 30 def
%% /XpointVue {Dobs Cos1Cos2 mul} def
%% /YpointVue {Dobs Sin1Cos2 mul} def
%% /ZpointVue {Dobs Sin2 mul} def
%% /xunit 28.14 def
%% /solidhollow false def
%% /solidbiface false def
%% /xunit 28.45 def
%% /tracelignedeniveau? true def
%% /hauteurlignedeniveau 1 def
%% /couleurlignedeniveau {rouge} def
%% /linewidthlignedeniveau 4 def
%% /solidgrid true def
/aretescachees true def
/defaultsolidmode 2 def
%
/Stroke { strokeopacity .setopacityalpha stroke } def
/Fill { fillopacity .setopacityalpha fill } def
%
%% variables globales specifiques a PSTricks
%% /activationgestioncouleurs true def
/xmin -10 def
/xmax 10 def
/ymin -10 def
/ymax 10 def

/fillstyle {} def
/startest false def
/cm {} def
/cm_1 {} def
/yunit {xunit} def
/angle_repere 90 def

/hadjust 2.5 def
/vadjust 2.5 def
/pl@n-en-cours false def

/pointilles { [6.25 3.75] 1.25 setdash } def
/stockcurrentcpath {} def
/newarrowpath {} def
/chaine 15 string def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% choix d une fonte accentuee pour le .ps %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/ReEncode { exch findfont
dup length dict begin { 1 index /FID eq {pop pop} {def} ifelse
}forall /Encoding ISOLatin1Encoding def currentdict end definefont
pop }bind def
/Font /Times-Roman /ISOfont ReEncode /ISOfont def
%Font findfont 10 scalefont setfont

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% extrait de color.pro pour pouvoir recuperer ses couleurs %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/GreenYellow{0.15 0 0.69 0 setcmykcolor}def
/Yellow{0 0 1 0 setcmykcolor}def
/Goldenrod{0 0.10 0.84 0 setcmykcolor}def
/Dandelion{0 0.29 0.84 0 setcmykcolor}def
/Apricotq{0 0.32 0.52 0 setcmykcolor}def
/Peach{0 0.50 0.70 0 setcmykcolor}def
/Melon{0 0.46 0.50 0 setcmykcolor}def
/YellowOrange{0 0.42 1 0 setcmykcolor}def
/Orange{0 0.61 0.87 0 setcmykcolor}def
/BurntOrange{0 0.51 1 0 setcmykcolor}def
/Bittersweet{0 0.75 1 0.24 setcmykcolor}def
/RedOrange{0 0.77 0.87 0 setcmykcolor}def
/Mahogany{0 0.85 0.87 0.35 setcmykcolor}def
/Maroon{0 0.87 0.68 0.32 setcmykcolor}def
/BrickRed{0 0.89 0.94 0.28 setcmykcolor}def
/Red{0 1 1 0 setcmykcolor}def
/OrangeRed{0 1 0.50 0 setcmykcolor}def
/RubineRed{0 1 0.13 0 setcmykcolor}def
/WildStrawberry{0 0.96 0.39 0 setcmykcolor}def
/Salmon{0 0.53 0.38 0 setcmykcolor}def
/CarnationPink{0 0.63 0 0 setcmykcolor}def
/Magenta{0 1 0 0 setcmykcolor}def
/VioletRed{0 0.81 0 0 setcmykcolor}def
/Rhodamine{0 0.82 0 0 setcmykcolor}def
/Mulberry{0.34 0.90 0 0.02 setcmykcolor}def
/RedViolet{0.07 0.90 0 0.34 setcmykcolor}def
/Fuchsia{0.47 0.91 0 0.08 setcmykcolor}def
/Lavender{0 0.48 0 0 setcmykcolor}def
/Thistle{0.12 0.59 0 0 setcmykcolor}def
/Orchid{0.32 0.64 0 0 setcmykcolor}def
/DarkOrchid{0.40 0.80 0.20 0 setcmykcolor}def
/Purple{0.45 0.86 0 0 setcmykcolor}def
/Plum{0.50 1 0 0 setcmykcolor}def
/Violet{0.79 0.88 0 0 setcmykcolor}def
/RoyalPurple{0.75 0.90 0 0 setcmykcolor}def
/BlueViolet{0.86 0.91 0 0.04 setcmykcolor}def
/Periwinkle{0.57 0.55 0 0 setcmykcolor}def
/CadetBlue{0.62 0.57 0.23 0 setcmykcolor}def
/CornflowerBlue{0.65 0.13 0 0 setcmykcolor}def
/MidnightBlue{0.98 0.13 0 0.43 setcmykcolor}def
/NavyBlue{0.94 0.54 0 0 setcmykcolor}def
/RoyalBlue{1 0.50 0 0 setcmykcolor}def
/Blue{1 1 0 0 setcmykcolor}def
/Cerulean{0.94 0.11 0 0 setcmykcolor}def
/Cyan{1 0 0 0 setcmykcolor}def
/ProcessBlue{0.96 0 0 0 setcmykcolor}def
/SkyBlue{0.62 0 0.12 0 setcmykcolor}def
/Turquoise{0.85 0 0.20 0 setcmykcolor}def
/TealBlue{0.86 0 0.34 0.02 setcmykcolor}def
/Aquamarine{0.82 0 0.30 0 setcmykcolor}def
/BlueGreen{0.85 0 0.33 0 setcmykcolor}def
/Emerald{1 0 0.50 0 setcmykcolor}def
/JungleGreen{0.99 0 0.52 0 setcmykcolor}def
/SeaGreen{0.69 0 0.50 0 setcmykcolor}def
/Green{1 0 1 0 setcmykcolor}def
/ForestGreen{0.91 0 0.88 0.12 setcmykcolor}def
/PineGreen{0.92 0 0.59 0.25 setcmykcolor}def
/LimeGreen{0.50 0 1 0 setcmykcolor}def
/YellowGreen{0.44 0 0.74 0 setcmykcolor}def
/SpringGreen{0.26 0 0.76 0 setcmykcolor}def
/OliveGreen{0.64 0 0.95 0.40 setcmykcolor}def
/RawSienna{0 0.72 1 0.45 setcmykcolor}def
/Sepia{0 0.83 1 0.70 setcmykcolor}def
/Brown{0 0.81 1 0.60 setcmykcolor}def
/Tan{0.14 0.42 0.56 0 setcmykcolor}def
/Gray{0 0 0 0.50 setcmykcolor}def
/Black{0 0 0 1 setcmykcolor}def
/White{0 0 0 0 setcmykcolor}def
%% fin de l extrait color.pro

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             autres couleurs                        %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/bleu {0 0 1 setrgbcolor} def
/rouge {1 0 0 setrgbcolor} def
/vert {0 .5 0 setrgbcolor} def
/gris {.4 .4 .4 setrgbcolor} def
/jaune {1 1 0 setrgbcolor} def
/noir {0 0 0 setrgbcolor} def
/blanc {1 1 1 setrgbcolor} def
/orange {1 .65 0 setrgbcolor} def
/rose {1 .01 .58  setrgbcolor} def
/cyan {1 0 0 0 setcmykcolor} def
/magenta {0 1 0 0 setcmykcolor} def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             definition du point de vue             %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% pour la 3D conventionnelle
%% Dony : graphisme scientifique : page 187
%% Editeur : Masson

%% calcul des coefficients de la matrice
%% de transformation
/Sin1 {THETA sin} def
/Sin2 {PHI sin} def
/Cos1 {THETA cos} def
/Cos2 {PHI cos} def
/Cos1Sin2 {Cos1 Sin2 mul} def
/Sin1Sin2 {Sin1 Sin2 mul} def
/Cos1Cos2 {Cos1 Cos2 mul} def
/Sin1Cos2 {Sin1 Cos2 mul} def

/3dto2d {
6 dict begin
   /Zcote exch def
   /Yordonnee exch def
   /Xabscisse exch def
   /xObservateur
      Xabscisse Sin1 mul neg Yordonnee Cos1 mul add
   def
   /yObservateur
      Xabscisse Cos1Sin2 mul neg Yordonnee Sin1Sin2 mul sub Zcote Cos2
      mul add
   def
   /zObservateur
      Xabscisse neg Cos1Cos2 mul Yordonnee Sin1Cos2 mul sub Zcote Sin2
      mul sub Dobs add
   def
   %% maintenant on depose les resultats sur la pile
   Decran xObservateur mul zObservateur div cm
   Decran yObservateur mul zObservateur div cm
end
} def

/getpointVue {
   XpointVue
   YpointVue
   ZpointVue
} def

/GetCamPos {
   getpointVue
} def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%         jps modifie pour PSTricks                  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/solid {continu} def
/dashed {pointilles} def
/dotted { [2] 0 setdash } def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             geometrie basique                      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% syntaxe~: [x1 y1 ... xn yn] ligne
/ligne {
gsave
   newpath
      dup 0 getp smoveto
      ligne_
      starfill
   Stroke
grestore
} def

%% syntaxe~: [x1 y1 ... xn yn] ligne_
/ligne_ {
   reversep
   aload length 2 idiv
   {
      slineto
   } repeat
} def

%% syntaxe~: [x1 y1 ... xn yn] polygone
/polygone* {
1 dict begin
   /startest {true} def
   polygone
end
} def

/polygone_ {
   newpath
      aload length 2 idiv
      3 copy pop
      smoveto
      {
         slineto
      } repeat
   closepath
} def

/polygone {
   gsave
      polygone_
      starfill
      currentlinewidth 0 eq {} { Stroke } ifelse
   grestore
} def

%% syntaxe : x y point
/point {
gsave
   1 setlinecap
   newpath
      smoveto
      0 0 rlineto
      5 setlinewidth
   Stroke
grestore
} def

/point_ {
   1 setlinecap
   5 setlinewidth
      smoveto
      0 0 rlineto
} def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                                    %%%%
%%%%          insertion librairie jps                   %%%%
%%%%                                                    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%              le repere jps                         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### AAAopacity ###

%% les parametres pour la gestion de la transparence

/setstrokeopacity { /strokeopacity exch def } def
/setfillopacity { /fillopacity exch def } def

%% d apres un code de Jean-Michel Sarlat
%% http://melusine.eu.org/syracuse/swf/pdf2swf/setdash/
%% Mise en reserve de la procedure stroke originelle.
/sysstroke {systemdict /stroke get exec} def
/sysfill {systemdict /fill get exec} def
/sysatan {systemdict /atan get exec} def
/atan {2 copy 0 0 eqp {pop pop 0} {sysatan} ifelse} def
% Mise en place de la nouvelle procedure
/Stroke { /strokeopacity where { /strokeopacity get }{ 1 } ifelse
   .setopacityalpha sysstroke
} def
/Fill { /fillopacity where { /fillopacity get }{ 1 } ifelse
   .setopacityalpha sysfill
} def

%%%%% ### AAAscale ###
%%%%%%%%%%%%%%%% les deplacements a l echelle %%%%%%%%%%%%%%%%%%%

 /v@ct_I {xunit 0} def
 /v@ct_J {angle_repere cos yunit mul angle_repere sin yunit mul} def

/xscale {} def
/yscale {} def

/xscale-1 {} def
/yscale-1 {} def

/gtransform {} def
/gtransform-1 {} def

/jtoppoint {
2 dict begin
   gtransform
   /y exch yscale def
   /x exch xscale def
   v@ct_I x mulv
   v@ct_J y mulv
   addv
end
} def

/rptojpoint {
   xtranslate ytranslate 
   3 1 roll         %% xA yB yA xB 
   4 1 roll         %% xB xA yB yA 
   sub neg 3 1 roll %% yB-yA xB xA 
   sub neg exch
   ptojpoint
} def

/rptoppoint {
   xtranslate ytranslate 
   3 1 roll         %% xA yB yA xB 
   4 1 roll         %% xB xA yB yA 
   sub neg 3 1 roll %% yB-yA xB xA 
   sub neg exch
} def

/ptojpoint {
4 dict begin
   /Y exch yscale-1 def
   /X exch xscale-1 def
   /y Y yunit angle_repere sin mul div def
   /x X y yunit mul angle_repere cos mul sub xunit div def
   x y
   gtransform-1
end
} def

/smoveto {
   jtoppoint
   moveto
} def

/srmoveto {
   jtoppoint
   rmoveto
} def

/slineto {
   jtoppoint
   lineto
} def

/srlineto {
   jtoppoint
   rlineto
} def

/stranslate {
   jtoppoint
   translate
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%            methodes numeriques                     %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### solve2nddegre ###
%% syntaxe : a b c solve2nddegre --> x1 x2
/solve2nddegre {
5 dict begin
   /@c exch def
   /@b exch def
   /@a exch def
   /delt@ @b dup mul 4 @a mul @c mul sub def
   @b neg delt@ sqrt sub 2 @a mul div
   @b neg delt@ sqrt add 2 @a mul div
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                  la 2D                             %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                  points                            %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### tripointangle ###
%% syntaxe : A B C tripointangle --> angle ABC
/tripointangle {
9 dict begin
   /yC exch def
   /xC exch def
   /yB exch def
   /xB exch def
   /yA exch def
   /xA exch def
   /A {xA yA} def
   /B {xB yB} def
   /C {xC yC} def
   B C angle
   B A angle
   sub
end   
} def

%%%%% ### angle ###
%% syntaxe : A B angle
%% --> num, l'angle defini par le vecteur AB dans le repere orthonorme jps 
/angle {
   vecteur exch atan
   dup 180 gt 
      {360 sub}
   if
} def

%% syntaxe : A B pangle
%% --> num, l'angle defini par le vecteur AB dans le repere postscript
/pangle {
   jtoppoint exchp jtoppoint exchp vecteur exch atan
   dup 180 gt 
	 {360 sub}
   if
} def

%%%%% ### setxrange ###
/setxrange {
   /xmax exch def
   /xmin exch def
} def

%%%%% ### setyrange ###
/setyrange {
   /ymax exch def
   /ymin exch def
} def

%%%%% ### defpoint ###
%% syntaxe : xA yA /A defpoint
/defpoint {
1 dict begin
   /t@mp@r@ire exch def
   [ 3 1 roll ] cvx t@mp@r@ire exch 
end def
} def

%%%%% ### milieu ###
%% syntaxe~: A B milieu 
/milieu {  
                %% xA yA xB yB
   3 -1 roll    %% xA xB yB yA 
   add 2 div    %% xA xB yM
   3 1 roll     %% yM xA xB 
   add 2 div    %% yM xM
   exch
} def

%%%%% ### parallelopoint ###
%% syntaxe : A B C parallelopoint --> point D, tel que ABCD parallelogramme
/parallelopoint {
11 dict begin
   /yC exch def
   /xC exch def
   /yB exch def
   /xB exch def
   /yA exch def
   /xA exch def
   /A {xA yA} def
   /B {xB yB} def
   /C {xC yC} def
   /d1 {A B C paral} def
   /d2 {B C A paral} def
   d1 d2 interdroite
end
} def

%%%%% ### translatepoint ###
%% syntaxe : A u translatepoint --> B image de A par la translation de vecteur u
/translatepoint {
   addv
} def

%%%%% ### rotatepoint ###
%% syntaxe : B A r rotatepoint --> C image de B par la rotation de centre A,
%% d'angle r (en degre)
%% En prenant les affixes des pts associes, il vient
%%    (zC - zA) = (zB-zA) e^(ir)
%% soit 
%%    zC = (zB-zA) e^(ir) + zA
/rotatepoint {     %% B, A, r
   5 copy          %% B, A, r, B, A, r
   cos 5 1 roll    %% B, A, r, cos r, B, A
   4 1 roll        %% B, A, r, cos r, yA, B, xA
   4 1 roll        %% B, A, r, cos r, A, B 
   vecteur         %% B, A, r, cos r, xB-xA, yB-yA
   4 -1 roll sin   %% B, A, cos r, xB-xA, yB-yA, sin r
   4 copy mul      %% B, A, cos r, xB-xA, yB-yA, sin r, cos r, xB-xA, (yB-yA) sin r
   7 1 roll mul    %% B, A, (yB-yA) sin r, cos r, xB-xA, yB-yA, sin r, cos r (xB-xA)
   5 1 roll        %% B, A, (yB-yA) sin r, cos r (xB-xA), cos r, xB-xA, yB-yA, sin r
   exch            %% B, A, (yB-yA) sin r, cos r (xB-xA), cos r, xB-xA, sin r, yB-yA
   4 -1 roll mul   %% B, A, (yB-yA) sin r, cos r (xB-xA), xB-xA, sin r, (yB-yA)cos r
   3 1 roll mul    %% B, A, (yB-yA) sin r, cos r (xB-xA), (yB-yA) cos r, (xB-xA) sin r
   add             %% B, A, (yB-yA) sin r, cos r (xB-xA), (yB-yA) cos r +(xB-xA) sin r
   3 1 roll        %% B, A, (yB-yA) cos r + (xB-xA) sin r, (yB-yA) sin r, cos r (xB-xA), 
   exch sub        %% B, A, (yB-yA) cos r + (xB-xA) sin r, cos r (xB-xA)-(yB-yA) sin r 
   exch            %% B, zA, (zB-zA) e^(ir)
   addv
   3 -1 roll pop
   3 -1 roll pop
} def

%%%%% ### hompoint ###
%% syntaxe : B A alpha hompoint -> le point A' tel que AA' = alpha AB
/hompoint {
   5 copy
   pop
   vecteur      %% vecteur BA
   3 -1 roll
   neg
   mulv   %% alpha x vecteur AB
   addv
   4 -1 roll
   4 -1 roll
   pop pop
} def

%%%%% ### orthoproj ###
%% syntaxe : A D orthoproj --> B, le projete orthogonal de A sur D
/orthoproj {
   6 -1 roll
   6 -1 roll            %% D A
   6 copy               %% D A D A
   7 -1 roll pop
   7 -1 roll pop        %% D D A
   perp 
   interdroite
} def

%% syntaxe : A projx --> le projete orthogonal de A sur Ox
/projx {
   pop 0
} def

%% syntaxe : A projy --> le projete orthogonal de A sur Oy
/projy {
   exch pop 0 exch
} def

%%%%% ### sympoint ###
%% syntaxe : A I sympoint --> point A', le symetrique de A par rapport
%% au point I
/sympoint {
   4 copy
   pop pop
   vecteur 
   -2 mulv
   addv
} def

%%%%% ### axesympoint ###
%% syntaxe : A D axesympoint --> point B, le symetrique de A par rapport
%% a la droite D
/axesympoint {
2 dict begin
   6 copy
   pop pop pop pop
   /yA exch def
   /xA exch def
   orthoproj 
   xA yA vecteur 
   -2 mulv
   xA yA addv
end   
} def

%%%%% ### cpoint ###
%% syntaxe : alpha C cpoint -> M, le point du cercle C correspondant a
%% l'angle alpha
/cpoint {           %% a, xI, yI, r 
1 dict begin
   dup              %% a, xI, yI, r, r
   5 -1 roll        %% xI, yI, r, r, a
   /alpha exch def  
   alpha cos mul    %% xI, yI, r, r cos a
   exch
   alpha sin mul    %% xI, yI, r cos a, r sin a
   3 -1 roll add    %% xI, r cos a, yI + r sin a
   3 1 roll         %% yI + r sin a, xI, r cos a, 
   add exch         %% xI + r cos a, yI + r sin a
end
} def

%%%%% ### xdpoint ###
%% x A B xdpoint : le point de la droite (AB) d'abscisse x
/xdpoint {
5 dict begin
   /pt2 defpoint
   /pt1 defpoint
   /x exch def
   /a pt1 pt2 coeffdir def
   /b pt1 pt2 ordorig def
   x dup a mul b add
end   
} def

%%%%% ### ydpoint ###
%% y A B ydpoint : le point de la droite (AB) d'ordonnee y
/ydpoint {
5 dict begin
   /pt2 defpoint
   /pt1 defpoint
   /y exch def
   pt1 pt2 verticale? 
      {
         pt1 pop y
      }
      {
         /a pt1 pt2 coeffdir def
         /b pt1 pt2 ordorig def
         y b sub a div y
      }
   ifelse
end   
} def

%%%%% ### ordonnepoints ###
%% syntaxe : xA yA xB yB ordonnepoints --> idem si yB>yA ou si yB=yA
%% avec xB>xA, sinon xB yB xA yA
/ordonnepoints {
   4 copy
   exch pop             %% ... xA, yA, yB
   lt                   %% yA < yB ?
      {pop}                     %% oui, c'est fini
      {                         %% non : yA >= yB
         pop 4 copy  
         exch pop               %% ... xA, yA, yB
         eq                     %% yA = yB ?
            {
               3 copy                   %% oui, yA = yB
               pop pop                  %% ... xA, xB
               le                       %% xA =< xB ?
                  {}                          %% oui, c'est fini
                  {                           %% non, on echange A et B
                     4 -1 roll
                     4 -1 roll
                  }
               ifelse
            }
            {                           %% non : yA < yB => on echange A et B
               pop
               4 -1 roll
               4 -1 roll
            }
         ifelse
      } 
   ifelse
} def

%%%%% ### distance ###
%% syntaxe~: A B distance
/distance {      %% xA yA xB yB
   vecteur       %% x y
   dup mul exch  %% y^2 x
   dup mul       %% y^2 x^2
   add
   sqrt
} def

%%%%% ### dup ###
/dupp {2 copy} def
/dupc {3 copy} def
/dupd {4 copy} def

%%%%% ### fin insertion ###
/interdroites {interdroite} def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                 vecteurs                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%% ### normalize ###
%% syntaxe : u normalize -> u / ||u||
/normalize {
2 dict begin
   /u defpoint
   /n u norme def
   u 1 n div mulv
end
} def

%%%%% ### addv ###
%% syntaxe : u v addv --> u+v
/addv {         %% xA yA xB yB
   3 1 roll     %% xA yB yA xB 
   4 1 roll     %% xB xA yB yA 
   add 3 1 roll %% yB+yA xB xA 
   add exch
} def

%%%%% ### subv ###
%% syntaxe : u v subv --> u - v
/subv {	%% xA yA xB yB
   -1 mulv
   addv
} def

%%%%% ### mulv ###
%% syntaxe : u a mulv --> au
/mulv {   %% xA, yA, a
   dup          %% xA, yA, a, a
   3 1 roll     %% xA, a, yA, a
   mul 3 1 roll %% ayA, xA, a
   mul exch
} def

%%%%% ### scalprod ###
%% syntaxe : u v scalprod --> le produit scalaire de u par v
/scalprod {
2 dict begin
   /y' exch def
   exch 
   /y exch def
   mul y y' mul add
end
} def

%%%%% ### normal ###
%% syntaxe : u normal --> v tel u.v = 0
/normal {
   neg exch
} def

%%%%% ### norme ###
%% syntaxe : u norme --> |u|
/norme {
   dup mul
   exch
   dup mul
   add sqrt
} def

%%%%% ### oldarrow ###
%% syntaxe : A B oldarrow --> trace fleche en B, direction AB
/oldarrow {
4 dict begin
gsave
   /B defpoint
   /A defpoint
   oldarrowscale scale
   oldarrowangle rotate
   newpath 
   B smoveto
   A B vecteur normalize /u defpoint
   u neg exch /v defpoint
   u oldarrowpointe neg mulv rmoveto %% ainsi c'est la pointe qui est en (0, 0)
   %% le pt extremal arriere haut
      u oldarrowplume neg mulv        %% l'abscisse
      v oldarrow@ngle sin oldarrow@ngle cos div oldarrowplume mul mulv addv %% l'ordonnee
   rlineto
      u oldarrowplume oldarrowpointe add mulv
      v oldarrow@ngle sin oldarrow@ngle cos div oldarrowplume mul neg mulv addv
   rlineto 
      u oldarrowplume oldarrowpointe add neg mulv
      v oldarrow@ngle sin oldarrow@ngle cos div oldarrowplume mul neg mulv addv
   rlineto
   closepath Fill
grestore
end
} def

/oldarrowpointe {xunit 5 div} def
/oldarrowplume {xunit 10 div} def 
/oldarrow@ngle 45 def        
/oldarrowscale {1 1} def
/oldarrowangle 0 def     %% pour l'utilisateur

%%%%% ### drawvecteur ###
%% syntaxe : A B drawvecteur
/drawvecteur {
2 dict begin
   /B defpoint
   /A defpoint
   [A B] ligne
   A B oldarrow
end
} def

%%%%% ### orthovecteur ###
%% syntaxe : u orthovecteur --> v, vecteur orthogonal a u
/orthovecteur {
   neg exch
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                  cercles                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### defcercle ###
%% syntaxe : A r /d defcercle
/defcercle {
1 dict begin
   /t@mp@r@ire exch def
   [ 4 1 roll ] cvx t@mp@r@ire exch 
end def
} def

%%%%% ### interdroitecercle ###
%% intersection de la droite y = ax+b avec le cercle (x-x0)^2 + (y-y0)^2 = r^2
%% { --       b - y                   2          2           3
%% { |  x = - -----, y = (b + a x0 + a  y0 + (2 a  b y0 - 2 a  b x0 +
%% { --         a
%% 
%%       3          2  2    2  2    4  2    2   2    4   2             2
%%    2 a  x0 y0 - a  b  + a  r  + a  r  - a  y0  - a  x0 )^(1/2)) / (a  + 1)
%% 
%% 
%%    -- 
%%     |,
%%    -- 
%%     --       b - y                   2          2           3
%%     |  x = - -----, y = (b + a x0 + a  y0 - (2 a  b y0 - 2 a  b x0 +
%%     --         a
%% 
%%       3          2  2    2  2    4  2    2   2    4   2             2
%%    2 a  x0 y0 - a  b  + a  r  + a  r  - a  y0  - a  x0 )^(1/2)) / (a  + 1)
%% 
%%    -- }
%%     | }
%%    -- }

%% intersection de la droite x = a avec le cercle (x-x0)^2 + (y-y0)^2 = r^2
%%                              2    2     2 1/2
%% {[x = a, y = y0 + (2 a x0 - a  + r  - x0 )   ],
%% 
%%                                2    2     2 1/2
%%    [x = a, y = y0 - (2 a x0 - a  + r  - x0 )   ]}

%% intersection de la droite y = b avec le cercle (x-x0)^2 + (y-y0)^2 = r^2
%%                              2    2     2 1/2
%% {[y = b, x = x0 + (2 b y0 - b  + r  - y0 )   ],
%% 
%%                                2    2     2 1/2
%%    [y = b, x = x0 - (2 b y0 - b  + r  - y0 )   ]}

%% syntaxe : D I r interdroitecercle
/interdroitecercle {
16 dict begin
   /r exch def
   /y0 exch def
   /x0 exch def
   /yB exch def
   /xB exch def
   /yA exch def
   /xA exch def

   xA yA xB yB verticale?

   %% la droite est verticale
   {
      /xpt1 xA def
      /xpt2 xA def
      /quantite 
         2 xA mul x0 mul xA dup mul sub r dup mul add x0 dup mul sub sqrt
      def
      /ypt1
         y0 quantite add
      def
      /ypt2
         y0 quantite sub
      def
   }

   %% la droite n'est pas verticale
   {
      /a xA yA xB yB coeffdir def
      /b xA yA xB yB ordorig def

      0 a eq 
      %% la droite est horizontale
      {
         /quantite
            2 b mul y0 mul 
            b dup mul sub
            r dup mul add
            y0 dup mul sub
            sqrt
         def
         /xpt1 
            x0 quantite add
         def
         /xpt2 
            x0 quantite sub
         def
         /ypt1 b def
         /ypt2 b def
      } 

      %% la droite n'est pas horizontale
      {
         /quantite1 
            b 
            a x0 mul add
            a dup mul y0 mul add
         def
         /quantite2
            2 a dup mul mul b mul y0 mul 
            2 a 3 exp mul b mul x0 mul sub
            2 a 3 exp mul x0 mul y0 mul add
            a dup mul b dup mul mul sub
            a dup mul r dup mul mul add
            a 4 exp r dup mul mul add
            a dup mul y0 dup mul mul sub
            a 4 exp x0 dup mul mul sub 
            sqrt 
         def
         /quantite3 
            a dup mul 1 add 
         def
         /ypt1
            quantite1 quantite2 add quantite3 div
         def
         /xpt1 
            ypt1 b sub a div 
         def
         /ypt2
            quantite1 quantite2 sub quantite3 div
         def
         /xpt2 
            ypt2 b sub a div 
         def
      } 
      ifelse
   }
   ifelse
   
   xpt1 ypt1 
   xpt2 ypt2 
   ordonnepoints
end
} def

%%%%% ### intercercle ###
%% syntaxe : cerc1 cerc2 intercercle --> A B les points d'intersection
%% des 2 cercles, tries par 'ordonnepoints'
/intercercle {
12 dict begin
   /r2 exch def
   /y2 exch def
   /x2 exch def
   /r1 exch def
   /y1 exch def
   /x1 exch def

   %% on translate pour se ramener a (x1, y1) = (0, 0)
   x2 y2 x1 y1 subv
   /y2 exch def
   /x2 exch def

   %% on prepare l'equation du 2nd degre

%%                    2       2    2
%%   {y = RootOf((4 x2  + 4 y2 ) _Z
%% 
%%                  3        2              2       2            4
%%          + (-4 y2  - 4 r1~  y2 + 4 y2 r2~  - 4 x2  y2) _Z + x2
%% 
%%               4       2    2       2   2       2    2        2   2
%%          + r2~  - 2 y2  r2~  + 2 x2  y2  - 2 x2  r2~  - 2 r1~  x2
%% 
%%               4     4        2   2        2    2
%%          + r1~  + y2  + 2 r1~  y2  - 2 r1~  r2~ ), x = 1/2 (-2 y2
%% 
%%                     2       2    2
%%         RootOf((4 x2  + 4 y2 ) _Z
%% 
%%                  3        2              2       2            4
%%          + (-4 y2  - 4 r1~  y2 + 4 y2 r2~  - 4 x2  y2) _Z + x2
%% 
%%               4       2    2       2   2       2    2        2   2
%%          + r2~  - 2 y2  r2~  + 2 x2  y2  - 2 x2  r2~  - 2 r1~  x2
%% 
%%               4     4        2   2        2    2       2     2     2
%%          + r1~  + y2  + 2 r1~  y2  - 2 r1~  r2~ ) + r1~  + x2  + y2
%% 
%%               2
%%          - r2~ )/x2}

   %% coeff pour le degre 2
   /a 
      %%                    2       2    2
      %%   {y = RootOf((4 x2  + 4 y2 ) _Z
      4 x2 dup mul mul
      4 y2 dup mul mul add
   def

   %% coeff pour le degre 1
   %%
   /b 
      %%                    3        2              2       2        
      %%            + (-4 y2  - 4 r1~  y2 + 4 y2 r2~  - 4 x2  y2) _Z 
      -4 y2 3 exp mul
      4 r1 dup mul mul y2 mul sub
      4 r2 dup mul mul y2 mul add
      4 x2 dup mul mul y2 mul sub
   def

   %% coeff pour le degre 0
   %%
   /c {
      %%              4
      %%          + x2
      x2 4 exp
      %% 
      %%               4       2    2       2   2       2    2        2   2
      %%          + r2~  - 2 y2  r2~  + 2 x2  y2  - 2 x2  r2~  - 2 r1~  x2
      r2 4 exp add
      2 y2 dup mul mul r2 dup mul mul sub
      2 x2 dup mul mul y2 dup mul mul add
      2 x2 dup mul mul r2 dup mul mul sub
      2 x2 dup mul mul r1 dup mul mul sub
      %% 
      %%               4     4        2   2        2    2
      %%          + r1~  + y2  + 2 r1~  y2  - 2 r1~  r2~ )
      r1 4 exp add
      y2 4 exp add
      2 r1 dup mul mul y2 dup mul mul add
      2 r1 dup mul mul r2 dup mul mul sub
   } def

   a b c solve2nddegre
   /Y1 exch def
   /Y0 exch def
   
   /X0
      %% x = 1/2 (-2 y2  Y
      -2 y2 mul Y0 mul
      %% 
      %%        2     2     2
      %% + r1~  + x2  + y2
      r1 dup mul add
      x2 dup mul add
      y2 dup mul add
      %% 
      %%                 2
      %%            - r2~ )/x2}
      r2 dup mul sub
   
      2 x2 mul div
   def
   
   /X1
      %% x = 1/2 (-2 y2  Y
      -2 y2 mul Y1 mul
      %% 
      %%        2     2     2
      %% + r1~  + x2  + y2
      r1 dup mul add
      x2 dup mul add
      y2 dup mul add
      %% 
      %%                 2
      %%            - r2~ )/x2}
      r2 dup mul sub
   
      2 x2 mul div
   def

   %% on depose le resultat, en n'oubliant pas de retranslater en sens
   %% inverse

   X0 Y0 x1 y1 addv
   X1 Y1 x1 y1 addv
   ordonnepoints
end
} def

%%%%% ### ABcercle ###
%% syntaxe : A B C ABcercle --> le cercle passant par A, B, C
/ABcercle {
3 dict begin
   /@3 defpoint
   /@2 defpoint
   /@1 defpoint
   @1 @2 mediatrice
   @1 @3 mediatrice
   interdroite
   dupp
   @3 distance
end   
} def

%%%%% ### diamcercle ###
%% syntaxe : A B diamcercle --> le cercle de diametre [AB]
/diamcercle {
   4 copy
   distance 2 div
   5 1 roll 
   milieu
   3 -1 roll 
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                  droites                           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### horizontale ###
%% syntaxe : y horizontale 
/horizontale {
1 dict begin
   /y exch def
   xmin y xmax y
end
} def

%%%%% ### coeffdir ###
%% syntaxe~: A B coeffdir
/coeffdir {
   vecteur exch div
} def

%%%%% ### ordorig ###
%% syntaxe : A B ordorig
%% attention, la droite est supposee ne pas etre verticale
/ordorig {
   /dr@ite 4 array def
   dr@ite 3 3 -1 roll put
   dr@ite 2 3 -1 roll put
   dr@ite 1 3 -1 roll put
   dr@ite 0 3 -1 roll put
   dr@ite aload pop coeffdir /c@eff exch def
   dr@ite aload pop pop pop  %% xA yA
   exch                      %% yA xA 
   c@eff mul neg add
} def

%%%%% ### verticale ###
%% syntaxe~: A B verticale?
/verticale? {
   pop 2 1 roll pop
   eq
} def

%% syntaxe : x verticale
/verticale {
1 dict begin
   /x exch def
   x ymin x ymax
end
} def

%%%%% ### droite ###
%% %% syntaxe : A B droite
%% /droite {
%% gsave
%% 6 dict begin
%%    /yB exch def
%%    /xB exch def
%%    /yA exch def
%%    /xA exch def
%%    xA yA xB yB
%%    eqp
%%       {}
%%       { 
%%          xA yA xB yB
%%    	 verticale?
%%    	 {
%%    	 newpath
%%    	    xA ymin smoveto
%%    	    xA ymax slineto
%%             stockcurrentcpath
%%    	 stroke
%%    	 }
%%    	 {
%%    	 newpath
%%    	    /alpha xA yA xB yB coeffdir def
%%    	    /beta xA yA xB yB ordorig def
%%    	    xmin dup alpha mul beta add smoveto
%%    	    xmax dup alpha mul beta add slineto
%%             stockcurrentcpath
%%    	 stroke
%%    	 }
%%    	 ifelse
%%       }
%%    ifelse
%% end
%% grestore
%% } def

%% syntaxe : A B droite
/droite {
gsave
6 dict begin
   /B defpoint
   /A defpoint
   A pop B pop eq {
      %% droite verticale
      newpath
         A pop ymin smoveto
	 A pop ymax slineto
         stockcurrentcpath
      Stroke
   } {
      %% on cherche le point le + a gauche
      xmin A B xdpoint /C defpoint
      C exch pop ymin lt {
         %% trop a gauche
	 ymin A B ydpoint /C defpoint
      } if
      C exch pop ymax gt {
         %% trop a gauche
	 ymax A B ydpoint /C defpoint
      } if
      %% on cherche le point le + a droite
      xmax A B xdpoint /D defpoint
      D exch pop ymin lt {
         %% trop a droite
	 ymin A B ydpoint /D defpoint
      } if
      D exch pop ymax gt {
         %% trop a gauche
	 ymax A B ydpoint /D defpoint
      } if
      newpath
         C smoveto
         D slineto
         stockcurrentcpath
     Stroke
   } ifelse
end
grestore
} def

%%%%% ### defdroite ###
%% syntaxe : A B /d defdroite
/defdroite {
1 dict begin
   /t@mp@r@ire exch def
   [ 5 1 roll ] cvx t@mp@r@ire exch 
end def
} def

%%%%% ### paral ###
%% syntaxe : D A paral --> droite parallele a D passant par A
/paral {
4 dict begin
   /yA exch def
   /xA exch def
   vecteur
   /u2 exch def
   /u1 exch def
   xA yA
   2 copy
   u1 u2 translatepoint
end
} def

%%%%% ### interdroite ###
/interdroite {
                %% A B C D
   /dr@ite2 4 array def
   dr@ite2 3 3 -1 roll put
   dr@ite2 2 3 -1 roll put
   dr@ite2 1 3 -1 roll put
   dr@ite2 0 3 -1 roll put
   /dr@ite1 4 array def
   dr@ite1 3 3 -1 roll put
   dr@ite1 2 3 -1 roll put
   dr@ite1 1 3 -1 roll put
   dr@ite1 0 3 -1 roll put

%%%    %% trace pour deboguage
%%%    dr@ite1 aload pop droite
%%%    dr@ite2 aload pop droite

%%% Dans tous les cas, on suppose que l'intersection existe
%%% 
%%% * la 1ere droite est verticale. les equations reduites sont
%%%       x = a1      et       y = a2 x + b2
%%% Le point d'intersection est :
%%%       {{x = a1, y = b2 + a1 a2}}
%%% 
%%% * la 2eme droite est verticale. les equations reduites sont
%%%       x = a1 x+ b1     et       x = a2
%%% Le point d'intersection est :
%%%       {{x = a2, y = b1 + a1 a2}}
%%% 
%%% * aucune n'est verticale. Les equations reduites sont
%%%       y = a1 x + b1      et       y = a2 x + b2
%%% Le point d'intersection est :
%%%                 { {     b2 - b1      a1 b2 - a2 b1 } }
%%%                 { { x = -------, y = ------------- } }
%%%                 { {     a1 - a2         a1 - a2    } }

%%% remarque : pour le moment, je n'arrive pas a rendre mes variables
%%% locales : elle restent globales. Pour que cela ne soit pas trop
%%% genant, je les note respectivement @1, @@1, @2 et @@2 au lieu de a1,
%%% b1, a2 et b2.

   dr@ite1 aload pop verticale?
      {
         /@1 {dr@ite1 aload pop pop pop pop} def
         /@2 {dr@ite2 aload pop coeffdir} def
         /@@2 {dr@ite2 aload pop ordorig} def
         @1 
         @1 @2 mul @@2 add
      }
      {
      dr@ite2 aload pop verticale?
         {
            /@1 {dr@ite1 aload pop coeffdir} def
            /@@1 {dr@ite1 aload pop ordorig} def
            /@2 {dr@ite2 aload pop pop pop pop} def
            @2
            @1 @2 mul @@1 add
         }
         {
            /@1 {dr@ite1 aload pop coeffdir} def
            /@@1 {dr@ite1 aload pop ordorig} def
            /@2 {dr@ite2 aload pop coeffdir} def
            /@@2 {dr@ite2 aload pop ordorig} def
            @@2 @@1 sub @1 @2 sub div
            @1 @@2 mul @2 @@1 mul sub
            @1 @2 sub div
         }
      ifelse
      }
   ifelse
} def

%%%%% ### perp ###
%% syntaxe : D A perp --> droite perpendiculaire a D passant par A
/perp {
4 dict begin
   /yA exch def
   /xA exch def
   vecteur orthovecteur
   /u2 exch def
   /u1 exch def
   xA yA
   2 copy
   u1 u2 translatepoint
end
} def

%%%%% ### mediatrice ###
%% synaxe : A B mediatrice --> droite
/mediatrice {
   4 copy 
   milieu
   perp
} def

%%%%% ### bissectrice ###
%% syntaxe : A B C bissectrice --> B E ou E est un point de la bissectrice
/bissectrice {
10 dict begin
   /yC exch def
   /xC exch def
   /yB exch def
   /xB exch def
   /yA exch def
   /xA exch def
   /A {xA yA} def
   /B {xB yB} def
   /C {xC yC} def
   /alpha {A B C tripointangle} def
   B
   A B alpha rotatepoint
   A milieu
end
} def

%%%%% ### angledroit  ###
 /widthangledroit 5 def

%% syntaxe : A B C angledroit --> dessine un angle droit en B
/angledroit {
10 dict begin
   dup xcheck {
      /widthangledroit exch def
   } if
   /C defpoint
   /B defpoint
   /A defpoint
   B C vecteur normalize widthangledroit 20 div mulv /u defpoint
   B A vecteur normalize widthangledroit 20 div mulv /v defpoint
   [B u addv dupp v addv B v addv] ligne
end
} def

%%%%% ### translatedroite ###
%% syntaxe : A B u translatedroite --> C D images resp de A et B par la translation de vecteur u
/translatedroite {         %% A B u
   2 copy          %% A B u u
   6 1 roll       
   6 1 roll        %% A u B u 
   addv      %% A u D
   6 1 roll        
   6 1 roll        %% D A u 
   addv
   4 1 roll
   4 1 roll
} def

%%%%% ### rotatedroite ###
%% syntaxe : A B O r rotatedroite --> C D images resp de A et B par la
%% rotation de centre O et d'angle r (en degre)
/rotatedroite {
   5 copy rotatepoint   %% A B O r D
   6 -1 roll pop        %% A xB O r D
   6 -1 roll pop        %% A O r D
   7 1 roll
   7 1 roll rotatepoint %% D C
   4 1 roll 4 1 roll 
} def

/rotatevecteur {
   rotatedroite
} def

/rotatesegment {
   rotatedroite
} def

%%%%% ### axesymdroite ###
%% syntaxe : d D axesymdroite --> droite d', symetrique de la droite d par rapport
%% a la droite D
/axesymdroite {
2 dict begin
   /D defdroite
   /B defpoint
   D axesympoint
   B D axesympoint
end   
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                  polygones                         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### poltransformfile ###
%% syntaxe : pol u translatepol --> pol'
/translatepol {
2 dict begin   
   /uy exch def
   /ux exch def
   {ux uy translatepoint} papply
end
} def

%% syntaxe : pol u rotatepol --> pol'
/rotatepol {
2 dict begin   
   /alpha exch def
   /I defpoint
   {I alpha rotatepoint} papply
end
} def

%% syntaxe : pol I alpha hompol --> pol'
/hompol {
2 dict begin   
   /alpha exch def
   /I defpoint
   {I alpha hompoint} papply
end
} def

%% syntaxe : pol I sympol --> pol'
/sympol {
1 dict begin   
   /I defpoint
   {I sympoint} papply
end
} def

%% syntaxe : pol D axesympol --> pol'
/axesympol {
1 dict begin   
   /D defdroite
   {D axesympoint} papply
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                  les tests                         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### isbool ###
%% syntaxe : any isbool --> booleen
/isbool {
   type (booleantype) cvn eq
} def

%%%%% ### isarray ###
%% syntaxe : any isarray --> booleen
/isarray {
   type (arraytype) cvn eq
} def

%%%%% ### isstring ###
%% syntaxe : any isstring --> booleen
/isstring {
   type (stringtype) cvn eq
} def

%%%%% ### isinteger ###
%% syntaxe : any isinteger --> booleen
/isinteger {
   type (integertype) cvn eq
} def

%%%%% ### isnum ###
%% syntaxe : any isnum --> booleen
/isnum {
   dup isreal 
   exch isinteger or
} def

%%%%% ### isreal ###
%% syntaxe : any isreal --> booleen
/isreal {
   type (realtype) cvn eq
} def

%%%%% ### eq ###
%% syntaxe : A B eqp3d --> booleen = true si les points A et B sont identiques
/eqp3d {
               %% x1 y1 z1 x2 y2 z2
   4 -1 roll   %% x1 y1 x2 y2 z2 z1 
   eq {        %% x1 y1 x2 y2 
      eqp
   } {
      pop pop pop pop false
   } ifelse
} def

%% syntaxe : A B eqp --> booleen = true si les points A et B sont identiques
/eqp {
   3 -1 roll
   eq 
      {
         eq 
            {true} 
            {false}
         ifelse
      }
      {pop pop false}
   ifelse
} def

%% syntaxe : z z' eqc --> true si z = z', false sinon
/eqc {
   eqp
} def

%%%%% ### eqstring ###
/eqstring {
3 dict begin
   /str2 exch def
   /str1 exch def
   str1 length str2 length eq {
      /i 0 def
      true
      str1 length {
         str1 i get str2 i get eq and
         /i i 1 add store
      } repeat
   } {
      false
   } ifelse
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                conversions de types                %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### astr2str ###
%% syntaxe : array str astr2str --> str
%% convertit le contenu de array en chaines de caracteres puis les
%% concatene avec str, en inserant un caractere "space" apres chaque
%% element du tableau array
/astr2str {
5 dict begin
   /str exch def
   /table exch def
   /n table length def
   n 0 eq {
      str
   } {
      table 0 n 1 sub getinterval
      table n 1 sub get (                               ) cvs
      ( ) append
      str append
      astr2str
   } ifelse
end
} def

%%%%% ### numstr2array ###
%% syntaxe : str str2num --> num
/str2num {
5 dict begin
   /str exch def
   /n str length def
   /signnum 1 def
   /frct false def
   /k 0 def
   0 1 n 1 sub {
      /i exch def
      str i get
      dup 46 eq {
         %% il y a un point
         /frct true def
         pop
         i 0 eq {
            0
         } if
      } {
         dup 45 eq {
            /signnum -1 def
            pop
         } {
            frct not {
               i 1 ge signnum 0 ge and i 2 ge or {
                  exch 10 mul 48 sub add
               } {
                  48 sub
               } ifelse
            } {
               48 sub
               /k k 1 add store
               10 k exp div add
            } ifelse
         } ifelse
      } ifelse
   } for
   signnum mul
end
} def

/str2num {cvx exec} def

%% syntaxe : str numstr2array -> array
%% ou str est une chaine de nombres reels separes par des espaces
%% et array est constitue des elements numeriques de string.
%% exemple :
%% (0 -12 .234 54) --> [0 -12 0.234 54]
/numstr2array {
6 dict begin
   /str exch def
   /n str length def
   /separateurs [] def
   [
      0 1 n 1 sub {
         /i exch def
         str i get
         32 eq {
            /separateurs [separateurs aload pop i] def
         } if
      } for
      /j 0 def
      /oldsep 0 def
      0 1 separateurs length 1 sub {
         /i exch def
         str j separateurs i get oldsep sub getinterval str2num
         /j separateurs i get 1 add def
         /oldsep separateurs i get 1 add def
      } for
      str j n oldsep sub getinterval str2num
   ]
end
} def

%% syntaxe : array numstr2array -> array
/arraynumstr2arrayarray {
   {numstr2array} apply
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                macros de projection                %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### projtext ###
%% syntaxe : str x0 y0 z0 [normal_vect] ultextp3d --> -
%% syntaxe : str x0 y0 z0 [normal_vect] bool ultextp3d --> -
%% syntaxe : str x0 y0 plantype ultextp3d --> -
%% syntaxe : str x0 y0 plantype bool ultextp3d --> -
%% syntaxe : str1 solid i str2 ultextp3d --> -
%% syntaxe : str1 solid i str2 bool ultextp3d --> -
%% syntaxe : str1 solid i alpha str2 bool ultextp3d --> -
 /initpr@jtext {
5 dict begin
   dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   dup isplan {
      /type_plan_proj true def
      /lepl@n exch def
      lepl@n plangetbase aload pop
      /@V defpoint3d
      /@U defpoint3d
      lepl@n plangetorigine
      /z0 exch def
      /y0 exch def
      /x0 exch def
      /table [@U @U @V vectprod3d] def
   } {
      dup isarray {
         %% c est un planprojpath
         /type_plan_proj true def
         /table exch def
         /z0 exch def
         /y0 exch def
         /x0 exch def
         0 0
      } {
         %% c est un solidprojpath
         /type_plan_proj false def
         %% y a-t-il un str2
         dup isstring {
            /str2 exch def
         } {
            /str2 {} def
         } ifelse
         %% y a-t-il un alpha
         2 copy pop issolid {
            /alpha 0 def
         } {
            /alpha exch def
         } ifelse
         /i exch def
         /solid exch def
         0 0
      } ifelse
   } ifelse
} def
 /closepr@jtext {
   type_plan_proj {
      x0 y0 z0 table mybool projpath
   } {
      solid i alpha str2 mybool projpath
   } ifelse
   Fill
   Stroke
end
} def

%% syntaxe : str x0 y0 z0 [normal_vect] ultextp3d --> -
%% syntaxe : str x0 y0 z0 [normal_vect] bool ultextp3d --> -
%% syntaxe : str1 solid i str2 ultextp3d --> -
%% syntaxe : str1 solid i str2 bool ultextp3d --> -
%% syntaxe : str1 solid i alpha str2 bool ultextp3d --> -
/ultextp3d {initpr@jtext ultext_ closepr@jtext} def
/cltextp3d {initpr@jtext cltext_ closepr@jtext} def
/bltextp3d {initpr@jtext bltext_ closepr@jtext} def
/dltextp3d {initpr@jtext dltext_ closepr@jtext} def
/ubtextp3d {initpr@jtext ubtext_ closepr@jtext} def
/cbtextp3d {initpr@jtext cbtext_ closepr@jtext} def
/bbtextp3d {initpr@jtext bbtext_ closepr@jtext} def
/dbtextp3d {initpr@jtext dbtext_ closepr@jtext} def
/uctextp3d {initpr@jtext uctext_ closepr@jtext} def
/cctextp3d {initpr@jtext cctext_ closepr@jtext} def
/bctextp3d {initpr@jtext bctext_ closepr@jtext} def
/dctextp3d {initpr@jtext dctext_ closepr@jtext} def
/urtextp3d {initpr@jtext urtext_ closepr@jtext} def
/crtextp3d {initpr@jtext crtext_ closepr@jtext} def
/brtextp3d {initpr@jtext brtext_ closepr@jtext} def
/drtextp3d {initpr@jtext drtext_ closepr@jtext} def

%%%%% ### currentppathtransform ###
%% syntaxe : {f} currentppathtransform --> applique la transformation f
%% au chemin courant
/currentppathtransform {
6 dict begin
   /warp exch def
   %% pour remplacer 'move'
   /warpmove{
      2 index {
        newpath
      } if
      warp moveto
      pop false
   } def

   %% pour remplacer 'lineto'
   /warpline {
      warp lineto
   } bind def

   %% pour remplacer 'curveto'
   /warpcurve {
      6 2 roll warp
      6 2  roll warp
      6 2 roll warp
      curveto
   }  bind def

   true
   { warpmove } {  warpline } { warpcurve } { closepath } pathforall
   pop
end
} def

%% syntaxe : {f} currentpathtransform --> applique la transformation f
%% au chemin courant
/currentpathtransform {
7 dict begin
   /transform exch def
   /warp {ptojpoint transform} def
   %% pour remplacer 'move'
   /warpmove{
      2 index {
        newpath
      } if
      warp smoveto
      pop false
   } def

   %% pour remplacer 'lineto'
   /warpline {
      warp slineto
   } bind def

   %% pour remplacer 'curveto'
   /warpcurve {
      6 2 roll warp
      6 2  roll warp
      6 2 roll warp
      scurveto
   }  bind def

   true
   { warpmove } {  warpline } { warpcurve } { closepath } pathforall
   pop
end
} def

%%%%% ### normalvect_to_orthobase ###
%% syntaxe : [normal_vect] normalvect_to_orthobase
%%    --> imI imJ imK
/normalvect_to_orthobase {
4 dict begin
   dup length 3 eq {
      aload pop normalize3d /normal_vect defpoint3d
      normal_vect -1 0 0 eqp3d {
         /imageI {0 -1 0} def
         /imageK {-1 0 0} def
         /imageJ {0 0 1} def 
      } {
         %% on calcule l image de la base (I,J,K)
         /imageJ {normal_vect 1 0 0 vectprod3d normalize3d} def
         /imageK {normal_vect} def
         /imageI {imageJ imageK vectprod3d} def
         1 0 0 imageK angle3d 0 eq {
            0 1 0 normal_vect vectprod3d /imageI defpoint3d
            /imageJ {0 1 0} def
            normal_vect /imageK defpoint3d
         } if
      } ifelse
   } {
      dup length 6 eq {
         aload pop
         normalize3d /imageK defpoint3d
         normalize3d /imageI defpoint3d
         imageK imageI vectprod3d /imageJ defpoint3d
      } {
         dup length 7 eq {
            aload pop 
            /alpha exch 2 div def
            normalize3d /imageK defpoint3d
            normalize3d /imageI defpoint3d
            imageK imageI vectprod3d /imageJ defpoint3d
            %% et ensuite, on fait tourner la base autour de imageK
            imageI alpha cos mulv3d
            imageJ alpha sin mulv3d
            addv3d
   
            imageI alpha sin neg mulv3d
            imageJ alpha cos mulv3d
            addv3d
   
            /imageJ defpoint3d
            /imageI defpoint3d
         } {
            %% length = 4
            aload pop
            /alpha exch def
            normalize3d /normal_vect defpoint3d
   
            normal_vect -1 0 0 eqp3d {
               /imageI {0 -1 0} def
               /imageK {-1 0 0} def
               /imageJ {0 0 1} def 
            } {
               %% on calcule l image de la base (I,J,K)
               /imageJ {normal_vect 1 0 0 vectprod3d normalize3d} def
               /imageK {normal_vect} def
               /imageI {imageJ imageK vectprod3d} def
               1 0 0 imageK angle3d 0 eq {
                  0 1 0 normal_vect vectprod3d /imageI defpoint3d
                  /imageJ {0 1 0} def
                  normal_vect /imageK defpoint3d
               } if
            } ifelse
         } ifelse

         %% et ensuite, on fait tourner la base autour de imageK
         imageI alpha cos mulv3d
         imageJ alpha sin mulv3d
         addv3d

         imageI alpha sin neg mulv3d
         imageJ alpha cos mulv3d
         addv3d

         /imageJ defpoint3d
         /imageI defpoint3d
      } ifelse
   } ifelse
   imageI
   imageJ
   imageK
end
} def

%%%%% ### projpath ###
%% syntaxe : x y z [normal] projpath --> planprojpath
%% syntaxe : x y z [normal] bool projpath --> planprojpath
%% syntaxe : solid i projpath --> solidprojpath
%% syntaxe : solid i bool projpath --> solidprojpath
%% syntaxe : solid i str bool projpath --> solidprojpath
%% syntaxe : solid i alpha str bool projpath --> solidprojpath
/projpath {
2 dict begin
   dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   dup isplan {
      3 dict begin
         /lepl@n exch def
         lepl@n plangetbase aload pop
         /@V defpoint3d
         /@U defpoint3d
         lepl@n plangetorigine
         [@U @U @V vectprod3d] mybool planprojpath
      end
   } {
      dup isarray {
         mybool planprojpath
      } {
         mybool solidprojpath
      } ifelse
   } ifelse
end
} def


%% %% syntaxe : x y z [normal] projpath --> planprojpath
%% %% syntaxe : x y z [normal] bool projpath --> planprojpath
%% %% syntaxe : solid i projpath --> solidprojpath
%% %% syntaxe : solid i bool projpath --> solidprojpath
%% %% syntaxe : solid i str bool projpath --> solidprojpath
%% %% syntaxe : solid i alpha str bool projpath --> solidprojpath
%% /projpath {
%% 2 dict begin
%%    dup isbool {
%%       /mybool exch def
%%    } {
%%       /mybool true def
%%    } ifelse
%%    dup isarray {
%%       mybool planprojpath
%%    } {
%%       mybool solidprojpath
%%    } ifelse
%% end
%% } def
%% 
%% syntaxe : solid i str bool solidprojpath --> -
%% ou
%% syntaxe : solid i alpha str bool solidprojpath --> -
%% projette le chemin courant sur la face i du solide, apres
%% eventuellement une rotation d angle alpha autour de la normale
%% bool : pour savoir si on tient compte de la visibilite
/solidprojpath {
5 dict begin
   /visibility exch def
   dup isstring {
      /option exch def
   } if
   2 copy pop
   issolid {
      /alpha 0 def
   } {
      /alpha exch def
   } ifelse
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidprojpath) ==
   } if
   /n solid solidnombrefaces def
   i n 1 sub le {
      visibility not solid i solidfacevisible? or {
         currentdict /option known {
            option cvx exec
         } {
            solid i solidcentreface 
         } ifelse
         [
            solid 0 i solidgetsommetface 
            solid 1 i solidgetsommetface 
            vecteur3d normalize3d
            solid i solidnormaleface alpha 
         ] false planprojpath 
      } {
         newpath 0 0 smoveto
      } ifelse
   } {
      (Error : indice trop grand dans solidprojpath) ==
      quit
   } ifelse
end
} def

%% syntaxe : x y z [normal] bool planprojpath
/planprojpath {
6 dict begin
   /visibility exch def
   %% on calcule l image de la base (I,J,K)
   normalvect_to_orthobase
   /imageK defpoint3d
   /imageJ defpoint3d
   /imageI defpoint3d
   /z exch def
   /y exch def
   /x exch def

   visibility not x y z imageK planvisible? or {
      {ptojpoint 0
      imageI
      imageJ
      imageK
      transformpoint3d
      x y z addv3d
      3dto2d jtoppoint} currentppathtransform
   } {
      newpath
   } ifelse
end
} def

%%%%% ### projscene ###
%% syntaxe : plantype bool bprojscene ... eprojscene
/bprojscene {
10 dict begin
gsave
   dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   /l@pl@n exch def
   /saveStroke {SolidesDict /Stroke get exec} def
   /Stroke {l@pl@n mybool projpath saveStroke} def
   /savefill {SolidesDict /Fill get exec} def
   /Fill {l@pl@n mybool projpath savefill} def
   /masque {} def
   l@pl@n plangetrange aload pop 
   setyrange setxrange
   newpath
%%       xmin ymin l@pl@n pointplan smoveto
%%       xmin ymax l@pl@n pointplan slineto
%%       xmax ymax l@pl@n pointplan slineto
%%       xmax ymin l@pl@n pointplan slineto
%%       xmin ymin l@pl@n pointplan smoveto
%%  %   closepath
%% %gsave orange Fill grestore
%%    clip
} def
/eprojscene {
grestore
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%          fonctions numeriques                      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### courbeparam ###
/setresolution {
   /resolution exch def
} def
/resolution 200 def

/courbe_dic 2 dict def
courbe_dic /X {} put
courbe_dic /Y {} put

%% syntaxe : tmin tmax C@urbeparam_
 /C@urbeparam_ {
6 dict begin
   /tmax@ exch def
   /tmin@ exch def
   /t tmin@ def
   /dt tmax@ tmin@ sub resolution 1 sub div def
   tmin@ courbe_dic /X get exec
   pstrickactionR
   tmin@ courbe_dic /Y get exec
   pstrickactionR
   smoveto
   resolution 1 sub
   {
      t courbe_dic /X get exec
      pstrickactionR
      t courbe_dic /Y get exec
      pstrickactionR
      slineto

      /t t dt add store                      %% on incremente
   }
   repeat
   tmax@ courbe_dic /X get exec
   pstrickactionR
   tmax@ courbe_dic /Y get exec
   pstrickactionR
   slineto
end
} def

%% syntaxe : tmin tmax {X} {Y} Courbeparam_
/Courbeparam_ {
   courbe_dic exch /Y exch put
   courbe_dic exch /X exch put
   C@urbeparam_
} def

%% syntaxe : {X} {Y} courbeparam_
/courbeparam_ {
   tmin tmax
   4 -1 roll
   4 -1 roll
   Courbeparam_
} def

%% syntaxe : tmin tmax {X} {Y} Courbeparam
/Courbeparam {
gsave
6 dict begin
   dup isstring
      {
         /option exch def
      }
   if
   courbe_dic exch /Y exch put
   courbe_dic exch /X exch put
   /tmax exch def
   /tmin exch def

   newpath
      tmin courbe_dic /X get exec
      pstrickactionR
      tmin courbe_dic /Y get exec
      pstrickactionR
      smoveto                        %% on commence le chemin
      tmin tmax C@urbeparam_
      starfill

   stockcurrentcpath
   newarrowpath
   currentdict /option known
      {
         /dt tmax tmin sub resolution 1 sub div def
         tmin dt add courbe_dic /X get exec
         tmin dt add courbe_dic /Y get exec
         tmin courbe_dic /X get exec
         tmin courbe_dic /Y get exec
         arrowpath0
         tmax dt sub courbe_dic /X get exec
         tmax dt sub courbe_dic /Y get exec
         tmax courbe_dic /X get exec
         tmax courbe_dic /Y get exec
         currentdict /dt undef
         arrowpath1
         option
         gere_arrowhead
      }
   if

   currentlinewidth 0 eq {} { Stroke } ifelse

end
grestore
} def

%% syntaxe : {X} {Y} courbeparam
/courbeparam {
   dup isstring
      {
         tmin tmax
         5 -1 roll
         5 -1 roll
         5 -1 roll
      }
      {
         tmin tmax
         4 -1 roll
         4 -1 roll
      }
   ifelse
   Courbeparam
} def

%% syntaxe : tmin tmax {X} {Y} Courbeparam*
/Courbeparam* {
1 dict begin
   /startest {true} def
   Courbeparam
end
} def

%% syntaxe : {X} {Y} courbeparam*
/courbeparam* {
1 dict begin
   /startest {true} def
   courbeparam
end
} def

%%%%% ### courbe ###
%% syntaxe : {f} courbe
/courbe {
   dup isstring   %% y a-t-il une option de fin de ligne ?
      {
         xmin xmax 
         {} 
         5 -1 roll
         5 -1 roll
      }
      {
         xmin xmax 
         {} 
         4 -1 roll
      }
   ifelse
   Courbeparam
} def

%% syntaxe : mini maxi {f} Courbe
/Courbe {
   dup isstring {
      {}
      3 -1 roll
      3 -1 roll
   } {
      {}
      2 -1 roll
   } ifelse
   Courbeparam
} def

%% syntaxe : {f} courbe_
/courbe_ {
   xmin xmax 
   {} 
   4 -1 roll
   Courbeparam_
} def

%% syntaxe : mini maxi {f} Courbe_
/Courbe_ {
   {}
   2 -1 roll
   Courbeparam_
} def

%% syntaxe : mini maxi {f} Courbe*
/Courbe* {
1 dict begin
   /startest {true} def
   Courbe
end
} def

%% syntaxe : {f} courbe*
/courbe* {
1 dict begin
   /startest {true} def
   courbe
end
} def

%%%%% ### courbeR2 ###
%% syntaxe : tmin tmax C@urbeR2_
 /C@urbeR2_ {
6 dict begin
   /tmax@ exch def
   /tmin@ exch def
   /t tmin@ def
   /dt tmax@ tmin@ sub resolution 1 sub div def
   tmin@ courbe_dic /X get exec
   pstrickactionR2
   smoveto
   /t t dt add store
   resolution 2 sub
   {
      t courbe_dic /X get exec
      pstrickactionR2
      slineto
      /t t dt add store                      %% on incremente
   }
   repeat
   tmax@ courbe_dic /X get exec
   pstrickactionR2
   slineto
end
} def

%% syntaxe : tmin tmax {X} CourbeR2_
/CourbeR2_ {
   courbe_dic exch /X exch put
   C@urbeR2_
} def

%% syntaxe : {X} courbeR2_
/courbeR2_ {
   tmin tmax
   3 -1 roll
   3 -1 roll
   CourbeR2_
} def

%% syntaxe : tmin tmax {X} CourbeR2
/CourbeR2+ {
2 dict begin
   /slineto {} def
   /smoveto {} def
   CourbeR2
end
} bind def

/CourbeR2 {
gsave
6 dict begin
   dup isstring
      {
         /option exch def
      }
   if
   courbe_dic exch /X exch put
   /tmax exch def
   /tmin exch def

   newpath
      tmin tmax C@urbeR2_
      starfill
   currentlinewidth 0 eq {} { Stroke } ifelse

end
grestore
} def

%% syntaxe : {X} courbeR2
/courbeR2 {
   tmin tmax
   3 -1 roll
   CourbeR2
} def

%% syntaxe : tmin tmax {X} CourbeR2*
/CourbeR2* {
1 dict begin
   /startest {true} def
   CourbeR2
end
} def

%% syntaxe : {X} {Y} courbeR2*
/courbeR2* {
1 dict begin
   /startest {true} def
   courbeR2
end
} def

%%%%% ### courbeR3 ###
%% syntaxe : t1 t2 {f} (option) CourbeR3
/CourbeR3 {
2 dict begin
   dup isstring {
      /option exch def
   } if
   /lafonction exch def
   {lafonction 3dto2d}
   currentdict /option known
      {option}
   if
  CourbeR2
end
} def

%% syntaxe : {f} (option) CourbeR3
/courbeR3 {
   tmin tmax 3 -1 roll CourbeR3
} def

%%%%% ### cercle ###
%% syntaxe : x0 y0 r cercle
/cercle {
3 dict begin
   /r@y@n exch def
   /y@ exch def
   /x@ exch def
   0 360 {cos r@y@n mul x@ add} {sin r@y@n mul y@ add} Courbeparam
end
} def

%% syntaxe : x0 y0 r cercle_
/cercle_ {
3 dict begin
   /r@y@n exch def
   /y@ exch def
   /x@ exch def
   x@ r@y@n add y@ smoveto
   0 360 {cos r@y@n mul x@ add} {sin r@y@n mul y@ add} Courbeparam_
end
} def

%% syntaxe : x0 y0 r cercle-_
/cercle-_ {
3 dict begin
   /r@y@n exch def
   /y@ exch def
   /x@ exch def
   x@ r@y@n add y@ smoveto
   360 0 {cos r@y@n mul x@ add} {sin r@y@n mul y@ add} Courbeparam_
end
} def

%% syntaxe : x0 y0 r cercle*
/cercle* {
1 dict begin
   /startest true def
   cercle
end
} def

%% syntaxe : alpha beta x0 y0 r Cercle
/Cercle {
4 dict begin
   dup isstring
      {/option exch def}
   if
   /r@y@n exch def
   /y@ exch def
   /x@ exch def
   {cos r@y@n mul x@ add} {sin r@y@n mul y@ add} 
   currentdict /option known
      {option}
   if
   Courbeparam
end
} def

%% syntaxe : alpha beta x0 y0 r Cercle_
/Cercle_ {
3 dict begin
   /r@y@n exch def
   /y@ exch def
   /x@ exch def
   {cos r@y@n mul x@ add} {sin r@y@n mul y@ add} Courbeparam_
end
} def

%% syntaxe : alpha beta x0 y0 r Cercle
/Cercle* {
1 dict begin
   /startest {true} def
   Cercle
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%      fonctions et constantes mathematiques         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### math ###
%%%%%%%%%%% constantes mathematiques %%%%%%%%%%%%%%

/pi 3.14159 def
/e 2.71828 def

%%%%%%%%%%% fonctions mathematiques %%%%%%%%%%%%%%%

/rd {180 pi div mul} def        %% transforme des rd en degres
/deg {pi mul 180 div} def       %% transforme des degres en rd
/log {ln 10 ln div} def
/Exp {e exch exp} def
/Cos {rd cos} def
/Sin {rd sin} def
/tan {dup sin exch cos div} def
/cotan {dup cos exch sin div} def
/Tan {dup Sin exch Cos div} def
/Cotan {dup Cos exch Sin div} def
/coTan {Cotan} def
/arctan {
dup 0 ge
   {1 atan}
   {neg 1 atan neg}
ifelse
} def
/Arctan {arctan deg} def
/arccos {
   dup
   dup mul neg 1 add sqrt
   exch
   atan
} def
/Arccos {arccos deg} def
/arcsin {
   dup 1 eq {
      90
   } {
      dup
      dup mul neg 1 add sqrt
      atan
      dup 90 lt
         {}
         {360 sub}
      ifelse
   } ifelse
} def
/Arcsin {arcsin deg} def
/cosh {dup Exp exch neg Exp add 2 div} def
/sinh {dup Exp exch neg Exp sub 2 div} def
/tanh {dup sinh exch cosh div} def
/cotanh {dup cosh exch sinh div} def
/argcosh {dup dup mul 1 sub sqrt add ln} def
/argsinh {dup dup mul 1 add sqrt add ln} def
/argtanh {
   setxvar
   x 1 add
   1 x sub
   div
   ln
   2 div
} def
/factorielle {
      dup 0 eq
         {pop 1}
         {dup 1 sub factorielle mul}
      ifelse
} def
/Gauss {
3 dict begin
   /sigma exch def
   /m exch def
   /x exch def
   x m sub dup mul sigma dup mul 2 mul div neg Exp
   2 pi mul sigma dup mul mul sqrt div
end
} def
%% syntaxe : a n modulo
/modulo {
2 dict begin
   /n exch def
   /a exch def
   {
      a 0 lt {
         /a a n add store
      } {
         exit
      } ifelse
   } loop
   a n mod
end
} def

%%%%% ### max ###
/max {
   2 copy
   lt {exch} if
   pop
} def

%%%%% ### min ###
/min {
2 dict begin
   dup isarray {
      duparray /table exch def pop
      table 0 get
      1 1 table length 1 sub {
         /i exch def
         table i get
         min
      } for
   } {
      2 copy
      gt {exch} if
      pop
   } ifelse
end
} def

%%%%% ### setcolor ###
%% syntaxe : tableau setcolor
/setcolor {
   dup length 4 eq
      {aload pop setcmykcolor}
      {aload pop setrgbcolor}
   ifelse
} def

%%%%% ### in ###
%% cherche si un elt donne appartient au tableau donne
%% rque : utilise 3 variables locales
%% syntaxe : elt array in --> index boolean
/in {
3 dict begin
   /liste exch def
   /elt exch def
   /i 0 def
   false                        %% la reponse a priori
   liste length {
      liste i get elt eq {
         pop                    %% en enleve la reponse
         i true                 %% pour mettre la bonne
         exit
      } if
      /i i 1 add store
   } repeat
end
} def

%% cherche si un elt donne appartient au tableau donne
%% syntaxe : elt array in --> boolean
/In {
3 dict begin
   /liste exch def
   /elt exch def
   /i 0 def
   false                        %% la reponse a priori
   liste length {
      liste i get elt eq {
         pop                    %% en enleve la reponse
         true                 %% pour mettre la bonne
         exit
      } if
      /i i 1 add store
   } repeat
end
} def

%%%%% ### starfill ###
%% la procedure pour les objets "star"
%% si c est "star" on fait le fillstyle, sinon non
/starfill {
   startest {
      gsave
         clip
         fillstyle
      grestore
      /startest false def
   } if
} def

%%%%% ### addv ###
%% syntaxe : u v addv --> u+v
/addv {         %% xA yA xB yB
   3 1 roll     %% xA yB yA xB 
   4 1 roll     %% xB xA yB yA 
   add 3 1 roll %% yB+yA xB xA 
   add exch
} def

%%%%% ### continu ### 
/continu {
   [] 0 setdash 
} def

%%%%% ### trigospherique ### 
%% passage spherique --> cartesiennes
%% les formules de passage ont été récupérées ici :
%%    http://fr.wikipedia.org/wiki/Coordonn%C3%A9es_polaires
%% syntaxe : r theta phi rtp2xyz -> x y z
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

%% trace d'un arc sur une sphere de centre O
%% syntaxe : r theta1 phi1 r theta2 phi2 arcspherique
/arcspherique {
9 dict begin
   dup isstring {
      /option exch def
   } if
   /phi2 exch def
   /theta2 exch def
   pop
   /phi1 exch def
   /theta1 exch def
   /r exch def
   /n 12 def

   1 theta1 phi1 rtp2xyz /u defpoint3d
   1 theta2 phi2 rtp2xyz /v defpoint3d
   u v vectprod3d u vectprod3d dupp3d norme3d 1 exch div mulv3d /w defpoint3d

   /sinalpha u v vectprod3d norme3d def
   /cosalpha u v scalprod3d def
   /alpha sinalpha cosalpha atan def
   /n 12 def
   /pas alpha n div def

   gsave
      /t pas neg def
      [
         n 1 add {
            /t  t pas add store
            u t cos r mul mulv3d
            w t sin r mul mulv3d
            addv3d
         } repeat
      ] 
      currentdict /option known {
         option
      } if
      ligne3d
   grestore
end
} def

%% trace d'un arc sur une sphere de centre O
%% syntaxe : r theta1 phi1 r theta2 phi2 arcspherique
/arcspherique_ {
8 dict begin
   /phi2 exch def
   /theta2 exch def
   pop
   /phi1 exch def
   /theta1 exch def
   /r exch def
   /n 12 def

   1 theta1 phi1 rtp2xyz /u defpoint3d
   1 theta2 phi2 rtp2xyz /v defpoint3d
   u v vectprod3d u vectprod3d dupp3d norme3d 1 exch div mulv3d /w defpoint3d

   /sinalpha u v vectprod3d norme3d def
   /cosalpha u v scalprod3d def
   /alpha sinalpha cosalpha atan def
   /n 12 def
   /pas alpha n div def

   /t pas neg def
   [
      n 1 add {
         /t  t pas add store
         u t cos r mul mulv3d
         w t sin r mul mulv3d
         addv3d
      } repeat
   ] ligne3d_
end
} def

%% trace d'une geodesique sur une sphere de centre O
%% syntaxe : r theta1 phi1 r theta2 phi2 geodesique_sphere
/geodesique_sphere {
13 dict begin
   /phi2 exch def
   /theta2 exch def
   pop
   /phi1 exch def
   /theta1 exch def
   /r exch def
   /n 360 def

   1 theta1 phi1 rtp2xyz /u defpoint3d
   1 theta2 phi2 rtp2xyz /v defpoint3d
   u v vectprod3d u vectprod3d dupp3d norme3d 1 exch div mulv3d /w defpoint3d

   /sinalpha u v vectprod3d norme3d def
   /cosalpha u v scalprod3d def
   /alpha sinalpha cosalpha atan def
   /pas 360 n div def

   gsave
      /t pas neg def
      [
         n 1 add {
            /t  t pas add store
            u t cos r mul mulv3d
            w t sin r mul mulv3d
            addv3d
         } repeat
      ] ligne3d
   grestore
end
} def


%% syntaxe : A B C trianglespherique --> trace le rtiangle ABC
%% (coordonnees spheriques)
/trianglespherique* {
1 dict begin
   /startest {true} def
   trianglespherique
end
} def

/trianglespherique {
10 dict begin
   /C defpoint3d
   /B defpoint3d
   /A defpoint3d
   gsave
   newpath
      A rtp2xyz 3dto2d smoveto
      A B arcspherique_
      B C arcspherique_
      C A arcspherique_
   closepath
   starfill
   currentlinewidth 0 eq {} { Stroke } ifelse
   grestore
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%         operations sur les tableaux                %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### duparray ###
/duparray {
1 dict begin
   /table exch def
   table
   [ table aload pop ]
end
} def

%%%%% ### append ###
%% syntaxe : string1 string2 append --> concatene les 2 chaines ou fusionne 2 tableaux
/append {
3 dict begin
   dup isarray {
      /tab2 exch def
      /tab1 exch def
      [ tab1 aload pop tab2 aload pop ]
   } {
      /str2 exch def
      /str1 exch def
      /result str1 length str2 length add string def
      str1 result copy pop
      result str1 length str2 putinterval
      result
   } ifelse
end
} def

%%%%% ### rollparray ###
%% syntaxe : array n rollparray -> array
%% opere une rotation de n sur les couplets du tableau array
/rollparray {
4 dict begin
   /k exch def
   /table exch def
   /n table length def
   k 0 eq {
       table
   } {
       k 0 ge {
          [ table aload pop 2 {n 1 roll} repeat ]
           k 1 sub
       } {
          [ table aload pop 2 {n -1 roll} repeat ]
           k 1 add
       } ifelse
       rollparray
   } ifelse
end
} def

%%%%% ### bubblesort ###
%% syntaxe : array bubblesort --> array2 trie par ordre croissant
%% code de Bill Casselman
%% http://www.math.ubc.ca/people/faculty/cass/graphics/text/www/
/bubblesort {
4 dict begin
   /a exch def
   /n a length 1 sub def
   n 0 gt {
      % at this point only the n+1 items in the bottom of a remain to
      % the sorted largest item in that blocks is to be moved up into
      % position n
      n {
         0 1 n 1 sub {
            /i exch def
            a i get a i 1 add get gt {
               % if a[i] > a[i+1] swap a[i] and a[i+1]
               a i 1 add
               a i get
               a i a i 1 add get
               % set new a[i] = old a[i+1]
               put
               % set new a[i+1] = old a[i]
               put
            } if
         } for
         /n n 1 sub def
      } repeat
   } if
   a
end
} def

%% syntaxe : array1 doublebubblesort --> array2 array3, array3 est
%% trie par ordre croissant et array2 correspond a la position des
%% indices de depart, ie si array1 = [3 2 4 1], alors array2 = [3 1 0 2]
%% code de Bill Casselman, modifie par jpv, 15/08/2006
%% http://www.math.ubc.ca/people/faculty/cass/graphics/text/www/
/doublebubblesort {
5 dict begin
   /table exch def
   /n table length 1 sub def
   /indices [ 0 1 n {} for ] def
   n 0 gt {
      % at this point only the n+1 items in the bottom of a remain to
      % the sorted largest item in that blocks is to be moved up into
      % position n
      n {
         0 1 n 1 sub {
            /i exch def
            table i get table i 1 add get gt {
               % if a[i] > a[i+1] swap a[i] and a[i+1]
               table i 1 add
               table i get
               table i table i 1 add get
               % set new a[i] = old a[i+1]
               put
               % set new a[i+1] = old a[i]
               put

               indices i 1 add
               indices i get
               indices i indices i 1 add get
               % set new a[i] = old a[i+1]
               put
               % set new a[i+1] = old a[i]
               put
            } if
         } for
         /n n 1 sub def
      } repeat
   } if
   indices table
end
} def

%%%%% ### quicksort ###
%% src : http://www.math.ubc.ca/~cass/graphics/text/www/code/sort.inc
%% code de Bill Casselman, modifie par jpv, 18/10/2007

/qsortdict 8 dict def

qsortdict begin

% args: /comp a L R x
% effect: effects a partition into two pieces [L j] [i R]
%     leaves i j on stack

/partition { 8 dict begin
/x exch def
/j exch def
/i exch def
/a exch def
load /comp exch def
{
  {
    a i get x comp exec not {
      exit
    } if
    /i i 1 add def
  } loop
  {
    x a j get comp exec not {
      exit
    } if
    /j j 1 sub def
  } loop

  i j le {
    % swap a[i] a[j]
    a j a i get
    a i a j get
    put put
    indices j indices i get
    indices i indices j get
    put put
    /i i 1 add def
    /j j 1 sub def
  } if
  i j gt {
    exit
  } if
} loop
i j
end } def

% args: /comp a L R
% effect: sorts a[L .. R] according to comp

/subsort {
% /c a L R
[ 3 1 roll ] 3 copy
% /c a [L R] /c a [L R]
aload aload pop
% /c a [L R] /c a L R L R
add 2 idiv
% /c a [L R] /c a L R (L+R)/2
3 index exch get
% /c a [L R] /c a L R x
partition
% /c a [L R] i j
% if j > L subsort(a, L, j)
dup
% /c a [L R] i j j
3 index 0 get gt {
  % /c a [L R] i j
  5 copy
  % /c a [L R] i j /c a [L R] i j
  exch pop
  % /c a [L R] i j /c a [L R] j
  exch 0 get exch
  % ... /c a L j
  subsort
} if
% /c a [L R] i j
pop dup
% /c a [L R] i i
% if i < R subsort(a, i, R)
2 index 1 get lt {
  % /c a [L R] i
  exch 1 get
  % /c a i R
  subsort
}{
  4 { pop } repeat
} ifelse
} def

end

% args: /comp a
% effect: sorts the array a
% comp returns truth of x < y for entries in a

/quicksort { qsortdict begin
dup length 1 gt {
% /comp a
dup
% /comp a a
length 1 sub
% /comp a n-1
0 exch subsort
} {
pop pop
} ifelse
end } def

% ----------------------------------------

%% fin du code de Bill Casselman

%% syntaxe : array1 doublebubblesort --> array2 array3, array3 est
%% trie par ordre croissant et array2 correspond a la position des
%% indices de depart, ie si array1 = [3 2 4 1], alors array2 = [3 1 0 2]
%% code de Bill Casselman, modifie par jpv, 18/10/2007
%% http://www.math.ubc.ca/people/faculty/cass/graphics/text/www/
/doublequicksort {
qsortdict begin
   /comp exch
   /a exch def
   a dup length /n exch def
   /indices [0 1 n 1 sub {} for ] def
   dup length 1 gt {
      % /comp a
      dup
      % /comp a a
      length 1 sub
      % /comp a n-1
      0 exch subsort
   } {
      pop pop
   } ifelse
   indices a
end
} def

/comp {lt} def

%%%%% ### apply ###
%% syntaxe : [x1 ... xn] (f) apply --> [f(x1) ... f(xn)]
/apply {
3 dict begin
   dup isstring
      {/fonction exch cvx def}
      {/fonction exch def}
   ifelse
   /liste exch def
   /@i 0 def
   [
   liste length {
      liste @i get fonction
      /@i @i 1 add store
   } repeat
   counttomark
   0 eq
      {pop}
      {]}
   ifelse
end
} def

%% syntaxe : [x1 ... xn] (f) papply
/papply {
3 dict begin
   dup isstring
      {/fonction exch cvx def}
      {/fonction exch def}
   ifelse
   /liste exch def
   /@i 0 def
   [
   liste length 2 idiv {
      liste @i get
      liste @i 1 add get
      fonction
      /@i @i 2 add store
   } repeat
   counttomark
   0 eq
      {pop}
      {]}
   ifelse
end
} def

%% syntaxe : [x1 ... xn] (f) capply 
/capply {
3 dict begin
   dup isstring
      {/fonction exch cvx def}
      {/fonction exch def}
   ifelse   
   /liste exch def
   /@i 0 def
   [
   liste length 3 idiv {
      liste @i get 
      liste @i 1 add get 
      liste @i 2 add get 
      fonction
      /@i @i 3 add store
   } repeat
   counttomark 
   0 eq
      {pop}
      {]}
   ifelse
end
} def

%%%%% ### reverse ###
%% syntaxe : array reverse --> inverse l ordre des items dans
%% le tableau
/reverse {
3 dict begin
   /le_tableau exch def
   /n le_tableau length def
   /i n 1 sub def
   [
      n {
         le_tableau i get
         /i i 1 sub store
      } repeat
   ]
end
} def

%% syntaxe : array_points reversep --> inverse l ordre des points dans
%% le tableau
/reversep {
3 dict begin
   /le_tableau exch def
   /n le_tableau length 2 idiv def
   /i n 1 sub def
   [
      n {
         le_tableau i getp
         /i i 1 sub store
      } repeat
   ]
end
} def

%%%%% ### get ###
%% syntaxe : array_points n getp --> le n-ieme point du tableau de
%% points array_points
/getp {
   2 copy
   2 mul get
   3 1 roll
   2 mul 1 add get
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             matrices                               %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### linear ###
%% syntaxe : M i j any --> depose any dans M en a_ij
/put_ij {
5 dict begin
   /a exch def
   /j exch def
   /i exch def
   /M exch def
   /L M i get_Li def
   L j a put
   M i L put_Li
end
} def

%% syntaxe : M i j get_ij --> le coeff c_ij
/get_ij {
   3 1 roll   %% j M i
   get_Li     %% j L_i
   exch get
} def

%% syntaxe : M i L put_Li --> remplace dans M la ligne Li par L
/put_Li {
   put
} def

%% syntaxe : M i get_Li --> la ligne Li de M
/get_Li {
   get
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%          geometrie 3d (calculs)                    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### p3dtoplane ###
%% syntaxe : x y z P p3dtoplane --> X Y
/p3dtoplane {
5 dict begin
   /leplan exch def
   /M defpoint3d
   leplan plangetbase 0 getp3d /U defpoint3d
   leplan plangetbase 1 getp3d /V defpoint3d
   leplan plangetorigine /I defpoint3d
   I M vecteur3d U scalprod3d
   I M vecteur3d V scalprod3d
end
} def

%%%%% ### pplaneto3d ###
%% syntaxe : x y P pplaneto3d --> X Y Z
/pplaneto3d {
6 dict begin
   /leplan exch def
   /y exch def
   /x exch def
   leplan plangetbase 0 getp3d /U defpoint3d
   leplan plangetbase 1 getp3d /V defpoint3d
   leplan plangetorigine /I defpoint3d
   U x mulv3d
   V y mulv3d addv3d
   I addv3d
end
} def

%%%%% ### orthoprojplane3d ### 
%% Projection orthogonale d'un point 3d sur un plan
%% Mx My Mz (=le point a projeter) 
%% Ax Ay Az (=un point du plan) 
%% Vx Vy Vz (un vecteur normal au plan)
/orthoprojplane3d { 
4 dict begin
   dup isplan {
      /monplan exch def
      monplan plangetorigine
      monplan plangetbase aload pop vectprod3d
   } if
   /V defpoint3d
   /A defpoint3d
   /M defpoint3d
   /VN {V unitaire3d} def
   VN M A vecteur3d VN scalprod3d mulv3d
   M addv3d
end
} def

%%%%% ### sortp3d ### 
/sortp3d {
6 dict begin
   /M1 defpoint3d
   /M0 defpoint3d
   M1
   /z1 exch def
   /y1 exch def
   /x1 exch def
   M0
   /z0 exch def
   /y0 exch def
   /x0 exch def
   x0 x1 lt {
      M0 M1
   } {
      x0 x1 gt {
         M1 M0
      } {
         y0 y1 lt {
            M0 M1
         } {
            y0 y1 gt {
               M1 M0
            } {
               z0 z1 lt {
                  M0 M1
               } {
                  M1 M0
               } ifelse
            } ifelse
         } ifelse
      } ifelse
   } ifelse
end
} def

%%%%% ### dupp3d ### 
%% duplique le vecteur 3d
/dupp3d { %% x y z
        3 copy
} def
/dupv3d {dupp3d} def

%%%%% ### angle3d ###
%% syntaxe : vect1 vect2 angle3d
/angle3d {
4 dict begin
   normalize3d /vect2 defpoint3d
   normalize3d /vect1 defpoint3d
   /cosalpha vect1 vect2 scalprod3d def
   /sinalpha vect1 vect2 vectprod3d norme3d def
   sinalpha cosalpha atan
end
} def

%%%%% ### transformpoint3d ###
%% syntaxe : x y z a11 a21 a31 a12 a22 a32 a13 a23 a33
%%    transformpoint3d -> X Y Z
/transformpoint3d {
12 dict begin
   /a33 exch def
   /a23 exch def
   /a13 exch def
   /a32 exch def
   /a22 exch def
   /a12 exch def
   /a31 exch def
   /a21 exch def
   /a11 exch def
   /z   exch def
   /y   exch def
   /x   exch def
   a11 x mul a12 y mul add a13 z mul add
   a21 x mul a22 y mul add a23 z mul add
   a31 x mul a32 y mul add a33 z mul add
end
} def

%%%%% ### normalize3d ###
%% rend le vecteur 3d unitaire. Ne fait rien si u=0
/unitaire3d { %% x y z
2 dict begin
   /u defpoint3d
   /norme u norme3d def
   norme 0 eq {
      u
   } {
      u 1 norme div mulv3d
   } ifelse
end
} def
/normalize3d {unitaire3d} def

%%%%% ### geom3d ###
%% syntaxe : A k1 B k2 barycentre3d -> G, barycentre du systeme
%% [(A, k1) (B, k2)]
/barycentre3d {
4 dict begin
   /k2 exch def
   /B defpoint3d
   /k1 exch def
   /A defpoint3d
   A k1 mulv3d
   B k2 mulv3d
   addv3d
   1 k1 k2 add div mulv3d
end
} def

%% syntaxe : array isobarycentre3d --> G
/isobarycentre3d {
2 dict begin
   /table exch def
   /n table length 3 idiv def
   table 0 getp3d
   1 1 n 1 sub {
       table exch getp3d
       addv3d
   } for
   1 n div mulv3d
end
} def

%% syntaxe : M A alpha hompoint3d -> le point M' tel que AM' = alpha AM 
/hompoint3d {
3 dict begin
   /alpha exch def
   /A defpoint3d
   /M defpoint3d
   A M vecteur3d alpha mulv3d A addv3d
end
} def

%% syntaxe : M A sympoint3d -> le point M' tel que AM' = -AM
/sympoint3d {
2 dict begin
   /A defpoint3d
   /M defpoint3d
   A M vecteur3d -1 mulv3d A addv3d
end
} def

%% syntaxe : A u translatepoint3d --> B image de A par la translation de vecteur u
/translatepoint3d {
   addv3d
} def

/scaleOpoint3d {
6 dict begin
   /k3 exch def
   /k2 exch def
   /k1 exch def
   /z exch def
   /y exch def
   /x exch def
   k1 x mul
   k2 y mul
   k3 z mul
end
} def

% syntaxe : M alpha_x alpha_y alpha_z rotateOpoint3d --> M'
/rotateOpoint3d {
21 dict begin
   /RotZ exch def
   /RotY exch def
   /RotX exch def
   /Zpoint exch def
   /Ypoint exch def
   /Xpoint exch def
   /c1 {RotX cos} bind def
   /c2 {RotY cos} bind def
   /c3 {RotZ cos} bind def
   /s1 {RotX sin} bind def
   /s2 {RotY sin} bind def
   /s3 {RotZ sin} bind def
   /M11 {c2 c3 mul} bind def
   /M12 {c3 s1 mul s2 mul c1 s3 mul sub} bind def
   /M13 {c1 c3 mul s2 mul s1 s3 mul add} bind def
   /M21 {c2 s3 mul} bind def
   /M22 {s1 s2 mul s3 mul c1 c3 mul add} bind def
   /M23 {s3 s2 mul c1 mul c3 s1 mul sub} bind def
   /M31 {s2 neg} bind def
   /M32 {s1 c2 mul} bind def
   /M33 {c1 c2 mul} bind def
   M11 Xpoint mul M12 Ypoint mul add M13 Zpoint mul add
   M21 Xpoint mul M22 Ypoint mul add M23 Zpoint mul add
   M31 Xpoint mul M32 Ypoint mul add M33 Zpoint mul add
end
} def

%%%%% ### symplan3d ###
%% syntaxe : M eqplan/plantype symplan3d --> M'
%% ou M' symetrique de M par rapport au plan P defini par eqplan/plantype
/symplan3d {
13 dict begin
   dup isplan {
      plan2eq /args exch def
   } {
      /args exch def
   } ifelse
   /z exch def
   /y exch def
   /x exch def
   args aload pop
   /d1 exch def
   /c1 exch def
   /b1 exch def
   /a1 exch def
   /n_U a1 dup mul b1 dup mul add c1 dup mul add sqrt def
   /a a1 n_U div def
   /b b1 n_U div def
   /c c1 n_U div def
   /d d1 n_U div def
   /u a x mul b y mul add c z mul add d add def
   x 2 a mul u mul sub
   y 2 b mul u mul sub
   z 2 c mul u mul sub
end
} def

%%%%% ### vecteur3d ###
%% creation du vecteur AB a partir de A et B
/vecteur3d { %% xA yA zA xB yB zB
6 dict begin
   /zB exch def
   /yB exch def
   /xB exch def
   /zA exch def
   /yA exch def
   /xA exch def
   xB xA sub
   yB yA sub
   zB zA sub
end
}def

%%%%% ### vectprod3d ###
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

%%%%% ### papply3d ###
%% syntaxe : [A1 ... An] (f) papply3d --> [f(A1) ... f(An)]
/papply3d {
3 dict begin
   /fonction exch def
   /liste exch def
   /i 0 def
   [
   liste length 3 idiv {
      liste i get
      liste i 1 add get
      liste i 2 add get
      fonction
      /i i 3 add store
   } repeat
   counttomark
   0 eq
      {pop}
      {]}
   ifelse
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

%%%%% ### distance3d ###
/distance3d { %% A B
   vecteur3d norme3d
} def

%%%%% ### get3d ###
/getp3d { %% [tableau de points 3d] i --> donne le ieme point du tableau
   2 copy 2 copy
   3 mul get
   5 1 roll
   3 mul 1 add get
   3 1 roll
   3 mul 2 add get
} def

%%%%% ### norme3d ###
%% norme d un vecteur 3d
/norme3d { %% x y z
3 dict begin
   /z exch def
   /y exch def
   /x exch def
   x dup mul y dup mul add z dup mul add sqrt
end
} def

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

%%%%% ### milieu3d ###
/milieu3d { %% A B --> I le milieu de [AB]
   addv3d 0.5 mulv3d
} def

%%%%% ### exch ###
/exchp {
   4 -1 roll
   4 -1 roll
} def
/exchc {
   6 -1 roll
   6 -1 roll
   6 -1 roll
} def
/exchd {
   4 {8 -1 roll} repeat
} def
/exchp3d {
   6 -1 roll
   6 -1 roll
   6 -1 roll
} def

%%%%% ### ABpoint3d ###
%% syntaxe : A B k ABpoint3d --> M
%% M tel que vect(AM) = k vect (AB)
/ABpoint3d {
3 dict begin
   /k exch def
   /B defpoint3d
   /A defpoint3d
   A B vecteur3d
   k mulv3d
   A addv3d 
end
} def

%%%%% ### angle3doriente ###
%% syntaxe : vect1 vect2 vect3 angle3d
%% vect3 est la normale au plan (vect1, vect2)
/angle3doriente {
4 dict begin
   normalize3d /vect3 defpoint3d
   normalize3d /vect2 defpoint3d
   normalize3d /vect1 defpoint3d
   /cosalpha vect1 vect2 scalprod3d def
   /sinalpha vect1 vect2 vectprod3d vect3 scalprod3d def
   sinalpha cosalpha atan
end
} def

%%%%% ### points3dalignes ###
%% syntaxe : A B C points3dalignes -> bool
/points3dalignes {
3 dict begin
   /C defpoint3d
   /B defpoint3d
   /A defpoint3d
   A B vecteur3d /u defpoint3d
   A C vecteur3d /v defpoint3d
   u v vectprod3d norme3d 1E-7 lt
end
} def

%% syntaxe : M A B point3dsursegment --> true si M in [AB], false sinon
/point3dsursegment {
3 dict begin
   /B defpoint3d
   /A defpoint3d
   /M defpoint3d
   M A B points3dalignes {
      M A vecteur3d
      M B vecteur3d
      scalprod3d 0 lt {
         true
      } {
         false
      } ifelse
   } {
      false
   } ifelse
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%          geometrie 3d (dessins)                    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### point3d ###
/point3d { %% A
   3dto2d point
} def

/points3d { %% tableau de points3d
   tab3dto2d points
} def

%%%%% ### ligne3d ###
%% [tableau de points3d] option --> trace la ligne brisee
/ligne3d { 
1 dict begin
   dup isstring
      {/option exch def}
   if
   tab3dto2d
   currentdict /option known
      {option}
   if
   ligne
end
} def

%% [tableau de points3d] option --> trace la ligne brisee
/ligne3d_ { 
1 dict begin
   dup isstring
      {/option exch def}
   if
   tab3dto2d
   currentdict /option known
      {option}
   if
   ligne_
end
} def

%%%%% ### tab3dto2d ###
%% transforme un tableau de points 3d en tableau de points 2d
/tab3dto2d {
2 dict begin
   /T exch def
   /n T length def
   [ T aload pop
   n 1 sub -1 n 3 idiv 2 mul
   { 1 dict begin
   /i exch def
   3dto2d i 2 roll
   end } for ]
end
} def

%%%%% ### polygone3d ###
/polygone3d { %% tableau de points3d
   tab3dto2d polygone
} def

/polygone3d* { %% tableau de points3d
   tab3dto2d polygone*
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                 gestion du texte                   %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### marks ###
/xmkstep 1 def          % les marques sur Ox
/xmarkstyle {dctext} def
/ymarkstyle {(-1 0) bltext} def
/setxmkstep {
   /xmkstep exch def
} def
/xmark {
   dup xtick
   /Courier findfont .8 fontsize mul scalefont setfont
   dup dup truncate eq {
      cvi dup chaine cvs exch 
   } {
      dup chaine cvs exch 
   } ifelse
   Oy xmarkstyle
} def
/xmarks {
2 dict begin
   /n xmax xmax xmin sub 1000 div sub xmkstep div truncate cvi 
      xmkstep mul def                   % mark max
   /i xmin xmkstep div truncate cvi 
      xmkstep mul def                   % la 1ere
   i xmin lt {/i i xmkstep add store} if
   {
      i 0 ne {i xmark} if
      /i i xmkstep abs add store
      i n gt {exit} if
   } loop 
end
} def

/ymkstep 1 def          % les marques sur Oy
/setymkstep {
   /ymkstep exch def
} def
/ymark {
   dup ytick
   /Courier findfont .8 fontsize mul scalefont setfont
   dup chaine cvs exch 
   Ox exch ymarkstyle
} def
/ymarks {
2 dict begin
   /n ymax ymax ymin sub 1000 div sub ymkstep div truncate cvi 
      ymkstep mul def                   % mark max
   /i ymin ymkstep div truncate cvi 
      ymkstep mul def                   % la 1ere
   {
      i 0 ne {i ymark} if
      /i i ymkstep abs add store
      i n gt {exit} if
   } loop 
end
} def

/setmkstep {
   setymkstep
   setxmkstep
} def
/marks {
   xmarks
   ymarks
} def

%%%%% ### setfontsize ###
/setfontsize {
   /fontsize exch def
} def

%%%%% ### setCourrier ###
/Courier findfont 
dup length dict begin
   {
   1 index /FID ne 
      {def}
      {pop pop} 
   ifelse
   } forall
   /Encoding ISOLatin1Encoding def
   currentdict
end

/Courier-ISOLatin1 exch definefont pop

/setCourier {
   /Courier-ISOLatin1 findfont 
   fontsize scalefont 
   setfont
} def

%%%%% ### pathtext ###
%% syntaxe : string x y initp@thtext
 /initp@thtext {
7 dict begin
   /y exch def
   /x exch def
   /str exch def
   str 0 0 show_dim
   /wy exch def
   /wx exch def
   /lly exch def
   /llx exch def
   pop pop pop
   newpath 
      x y  smoveto
} def
 /closep@thtext {
      str true charpath
end
} def

%% syntaxe : string x y cctext_
/cctext_ {
   initp@thtext
   llx wx add lly wy add -.5 mulv rmoveto
   closep@thtext
} def

/brtext_ {
   initp@thtext
   hadjust 0 rmoveto
   llx neg 0 rmoveto
   closep@thtext
} def

/bbtext_ {
   initp@thtext
   0 0 rmoveto
   0 0 rmoveto
   closep@thtext
} def

/bltext_ {
   initp@thtext
   hadjust neg 0 rmoveto
   wx neg 0 rmoveto
   closep@thtext
} def

/bctext_ {
   initp@thtext
   0 0 rmoveto
   wx llx add -.5 mul 0 rmoveto
   closep@thtext
} def

/ubtext_ {
   initp@thtext
   0 vadjust rmoveto
   0 lly neg rmoveto
   closep@thtext
} def

/urtext_ {
   initp@thtext
   hadjust vadjust rmoveto
   llx neg lly neg rmoveto
   closep@thtext
} def

/ultext_ {
   initp@thtext
   hadjust neg vadjust rmoveto
   wx neg lly neg rmoveto
   closep@thtext
} def

/uctext_ {
   initp@thtext
   0 vadjust rmoveto
   llx wx add -.5 mul lly neg rmoveto
   closep@thtext
} def

/drtext_ {
   initp@thtext
   hadjust vadjust neg rmoveto
   llx neg wy neg rmoveto
   closep@thtext
} def

/dbtext_ {
   initp@thtext
   0 vadjust neg rmoveto
   0 wy neg rmoveto
   closep@thtext
} def

/dltext_ {
   initp@thtext
   hadjust neg vadjust neg rmoveto
   wx neg wy neg rmoveto
   closep@thtext
} def

/dctext_ {
   initp@thtext
   0 vadjust neg rmoveto
   llx wx add -2 div wy neg rmoveto
   closep@thtext
} def

/crtext_ {
   initp@thtext
   hadjust 0 rmoveto
   llx neg lly wy add -2 div rmoveto
   closep@thtext
} def

/cbtext_ {
   initp@thtext
   0 0 rmoveto
   0 lly wy add -2 div rmoveto
   closep@thtext
} def

/cltext_ {
   initp@thtext
   hadjust neg 0 rmoveto
   wx neg lly wy add -2 div rmoveto
   closep@thtext
} def

/cctext_ {
   initp@thtext
   0 0 rmoveto
   llx wx add lly wy add -.5 mulv rmoveto
   closep@thtext
} def

%%%%% ### text3d ###
%%%% Version 3d des commandes jps TEXTE
 /pr@p@re3d {
2 dict begin
%   /vect_echelle [1 1] def
%   /angle_de_rot {0} def
%   dup xcheck
%      {/angle_de_rot exch def}
%   if
%   dup isarray
%      {/vect_echelle exch def}
%   if%   CamView vect_echelle {angle_de_rot}
   3dto2d
} def

/bbtext3d {
   pr@p@re3d
   bbtext
end
} def

/bbtexlabel3d {
   pr@p@re3d
   bbtexlabel
end
} def

/bctext3d {
   pr@p@re3d
   bctext
end
} def

/bctexlabel3d {
   pr@p@re3d
   bctexlabel
end
} def

/bltext3d {
   pr@p@re3d
   bltext
end
} def

/bltexlabel3d {
   pr@p@re3d
   bltexlabel
end
} def

/brtext3d {
   pr@p@re3d
   brtext
end
} def

/brtexlabel3d {
   pr@p@re3d
   brtexlabel
end
} def

/cbtext3d {
   pr@p@re3d
   cbtext
end
} def

/cbtexlabel3d {
   pr@p@re3d
   cbtexlabel
end
} def

/cctext3d {
   pr@p@re3d
   cctext
end
} def

/cctexlabel3d {
   pr@p@re3d
   cctexlabel
end
} def

/cltext3d {
   pr@p@re3d
   cltext
end
} def

/cltexlabel3d {
   pr@p@re3d
   cltexlabel
end
} def

/crtext3d {
   pr@p@re3d
   crtext
end
} def

/crtexlabel3d {
   pr@p@re3d
   crtexlabel
end
} def

/dbtext3d {
   pr@p@re3d
   dbtext
end
} def

/dbtexlabel3d {
   pr@p@re3d
   dbtexlabel
end
} def

/dctext3d {
   pr@p@re3d
   dctext
end
} def

/dctexlabel3d {
   pr@p@re3d
   dctexlabel
end
} def

/dltext3d {
   pr@p@re3d
   dltext
end
} def

/dltexlabel3d {
   pr@p@re3d
   dltexlabel
end
} def

/drtext3d {
   pr@p@re3d
   drtext
end
} def

/drtexlabel3d {
   pr@p@re3d
   drtexlabel
end
} def

/ubtext3d {
   pr@p@re3d
   ubtext
end
} def

/ubtexlabel3d {
   pr@p@re3d
   ubtexlabel
end
} def

/uctext3d {
   pr@p@re3d
   uctext
end
} def

/uctexlabel3d {
   pr@p@re3d
   uctexlabel
end
} def

/ultext3d {
   pr@p@re3d
   ultext
end
} def

/ultexlabel3d {
   pr@p@re3d
   ultexlabel
end
} def

/urtext3d {
   pr@p@re3d
   urtext
end
} def

/urtexlabel3d {
   pr@p@re3d
   urtexlabel
end
} def

%%%%% ### fin insertion ###

%% La macro provisoire de developpement (27/01/2009)
%% syntaxe : solid table tablez --> -
/solidcolorz {
10 dict begin
   %% les hauteurs
   /tablez exch def
   %% les couleurs
   /usertable exch def
   /solid exch def
   %% a-t-on des couleurs nommees ?
   usertable 0 get isstring {
      %% oui, et autant que d etages
      usertable length 1 sub tablez length eq {
         /table usertable def
      } {
         %% oui, mais moins que d etages
	 %% ==> on definit les 2 premieres en RGB
         /a0 usertable 0 get def
         /a1 usertable 1 get def
         /lacouleurdepart {
            gsave
               [a0 cvx exec] length 0 eq {
                  a0 cvx exec currentrgbcolor
               } {
                  a0 cvx exec
               } ifelse 
            grestore
         } def
         /lacouleurarrivee {
            gsave
               [a1 cvx exec] length 0 eq {
                  a1 cvx exec currentrgbcolor
               } {
                  a1 cvx exec
               } ifelse 
            grestore
         } def
         /usertable [lacouleurdepart lacouleurarrivee] def
      } ifelse
   } if
   usertable 0 get isnum {
      %% c est un degrade : nb de couleurs a definir
      /n tablez length 1 add def
%      
      usertable length 4 eq {
          /a0 usertable 0 get def
          /a1 usertable 1 get def
          /A {a0 i a1 a0 sub mul n 1 sub div add} def
          /B usertable 2 get def
          /C usertable 3 get def
          /D {} def
          /espacedecouleurs (sethsbcolor) def
      } if
%      
      usertable length 6 eq {
          /a0 usertable 0 get def
          /b0 usertable 1 get def
          /c0 usertable 2 get def
          /a1 usertable 3 get def
          /b1 usertable 4 get def
          /c1 usertable 5 get def
          /A {a0 i a1 a0 sub mul n 1 sub div add} def
          /B {b0 i b1 b0 sub mul n 1 sub div add} def
          /C {c0 i c1 c0 sub mul n 1 sub div add} def
          /D {} def
          /espacedecouleurs (setrgbcolor) def
      } if
%
      usertable length 7 eq {
          /a0 usertable 0 get def
          /b0 usertable 1 get def
          /c0 usertable 2 get def
          /a1 usertable 3 get def
          /b1 usertable 4 get def
          /c1 usertable 5 get def
          /A {a0 i a1 a0 sub mul n 1 sub div add} def
          /B {b0 i b1 b0 sub mul n 1 sub div add} def
          /C {c0 i c1 c0 sub mul n 1 sub div add} def
          /D {} def
          /espacedecouleurs (sethsbcolor) def
      } if
%   
      usertable length 8 eq {
          /a0 usertable 0 get def
          /b0 usertable 1 get def
          /c0 usertable 2 get def
          /d0 usertable 3 get def
          /a1 usertable 4 get def
          /b1 usertable 5 get def
          /c1 usertable 6 get def
          /d1 usertable 7 get def
          /A {a0 i a1 a0 sub mul n 1 sub div add} def
          /B {b0 i b1 b0 sub mul n 1 sub div add} def
          /C {c0 i c1 c0 sub mul n 1 sub div add} def
          /D {d0 i d1 d0 sub mul n 1 sub div add} def
          /espacedecouleurs (setcmykcolor) def
      } if
%
      usertable length 2 eq {
         /a0 usertable 0 get def
         /a1 usertable 1 get def
         0 1 n 1 sub {
            /i exch def
            /A {a0 i a1 a0 sub mul n 1 sub div add} def
            /B {1} def
            /C {1} def
            /D {} def
            /espacedecouleurs (sethsbcolor) def
         } for
      } if
%
      %% on affecte la table des couleurs
      /table [
         0 1 n 1 sub {
            /i exch def
            [A B C D] espacedecouleurs astr2str
         } for
      ] def
   } if
%
   /n solid solidnombrefaces def
   0 1 n 1 sub {
      /i exch def
      solid i solidcentreface /z exch def pop pop
      /resultat 0 def
      0 1 tablez length 1 sub {
         /j exch def
         /ztest tablez j get def
         z ztest le {
	    /resultat j store
            exit
         } {
	    /resultat j 1 add store
	 } ifelse
      } for
      solid i table resultat get solidputfcolor
   } for
end
} def


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             bibliotheque sur les solides           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### solide ###
%% solid = [Sommets Faces Colors_Faces InOut_Table]
/solidgetsommets {
   0 get
} def
/solidgetpointstable {solidgetsommets} def

/solidgetfaces {
   1 get
} def

/solidgetface {
1 dict begin
   /i exch def
   solidgetfaces i get
end
} def

/solidgetfcolors {
   2 get
} def

%% syntaxe : solid i solidgetfcolor --> str
/solidgetfcolor {
1 dict begin
   /i exch def
   solidgetfcolors i get
end
} def

%% syntaxe : solid i str solidputfcolor --> -
/solidputfcolor {
2 dict begin
   /str exch def
   /i exch def
   solidgetfcolors i str put
end
} def

/solidgetinouttable {
   3 get
} def

/solidputsommets {
   0 exch put
} def
/solidputpointstable {solidputsommets} def

/solidputfaces {
   1 exch put
} def

%% syntaxe : solid solidfacesreverse -> -
/solidfacesreverse {
5 dict begin
   /solid exch def
   /n solid solidnombrefaces def
   0 1 n 1 sub {
      /i exch def
      /F solid i solidgetface reverse def
      /m F length def
      solid i [F aload pop m 0 roll ] solidputface
   } for
end
} def

/solidputfcolors {
   2 exch put
} def

/solidputinouttable {
   3 exch put
} def

%% syntaxe : any issolid --> booleen, vrai si any est de type solid
/issolid {
1 dict begin
   /candidat exch def
   candidat isarray {
      candidat length 4 eq {
         candidat 0 get isarray
         candidat 1 get isarray and
         candidat 2 get isarray and
         candidat 3 get isarray and {
            /IO candidat 3 get def
            IO length 4 eq 
            IO 0 get isnum and
            IO 1 get isnum and
            IO 2 get isnum and
            IO 3 get isnum and
	 } {
	    false
	 } ifelse
      } {
         false
      } ifelse
   } {
      false
   } ifelse
end
} def

/dupsolid {
5 dict begin
   /solid exch def
   /S solid solidgetsommets def
   /F solid solidgetfaces def
   /FC solid solidgetfcolors def
   /IO solid solidgetinouttable def
   solid
   [
      S duparray exch pop
      F duparray exch pop
      FC duparray exch pop
      IO duparray exch pop
   ]
end
} def

%% syntaxe : solid array solidputinfaces --> -
/solidputinfaces {
4 dict begin
   /facesinternes exch def
   /solid exch def
   /n2 facesinternes length def
   /IO solid solidgetinouttable def
   /facesexternes solid solidgetoutfaces def
   /n1 facesexternes length def
   solid
      [facesexternes aload pop facesinternes aload pop]
      solidputfaces
   IO 0 0 put
   IO 1 n1 1 sub put
   IO 2 n1 put
   IO 3 n1 n2 add 1 sub put
end
} def

%% syntaxe : solid array solidputoutfaces --> -
/solidputoutfaces {
4 dict begin
   /facesexternes exch def
   /solid exch def
   /n1 facesexternes length def
   /IO solid solidgetinouttable def
   /facesinternes solid solidgetinfaces def
   /n2 facesinternes length def
   solid
      [facesexternes aload pop facesinternes aload pop]
      solidputfaces
   IO 0 0 put
   IO 1 n1 1 sub put
   IO 2 n1 put
   IO 3 n1 n2 add 1 sub put
end
} def

/solidnombreinfaces {
1 dict begin
   /solid exch def
   solid solidwithinfaces {
      /IO solid solidgetinouttable def
      IO 3 get IO 2 get sub 1 add
   } {
      0
   } ifelse
end
} def

/solidnombreoutfaces {
1 dict begin
   /solid exch def
   /IO solid solidgetinouttable def
   IO 1 get IO 0 get sub 1 add
end
} def

%% syntaxe : solid solidgetinfaces --> array
/solidgetinfaces {
4 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetinfaces) ==
      quit
   } if
   solid solidwithinfaces {
      /IO solid solidgetinouttable def
      /F solid solidgetfaces def
      /n1 IO 2 get def
      /n2 IO 3 get def
      /n n2 n1 sub 1 add def
      F n1 n getinterval
   } {
      []
   } ifelse
end
} def

%% syntaxe : solid solidgetoutfaces --> array
/solidgetoutfaces {
4 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetoutfaces) ==
      quit
   } if
   /IO solid solidgetinouttable def
   /F solid solidgetfaces def
   /n1 IO 0 get def
   /n2 IO 1 get def
   /n n2 n1 sub 1 add def
   F n1 n getinterval
end
} def

%% /tracelignedeniveau? false def
%% /hauteurlignedeniveau 1 def
%% /couleurlignedeniveau {rouge} def
%% /linewidthlignedeniveau 4 def

/solidgridOn {
   /solidgrid true def
} def
/solidgridOff {
   /solidgrid false def
} def

%% syntaxe : solid i string solidputfcolor
%% syntaxe : solid str outputcolors
%% syntaxe : solid str1 str2 inoutputcolors
%% syntaxe : solid string n solidputncolors
%% syntaxe : solid array solidputincolors --> -
%% syntaxe : solid array solidputoutcolors --> -
%% syntaxe : solid solidgetincolors --> array
%% syntaxe : solid solidgetoutcolors --> array

%% syntaxe : solid array solidputinfaces --> -
%% syntaxe : solid array solidputoutfaces --> -
%% syntaxe : solid solidgetinfaces --> array
%% syntaxe : solid solidgetoutfaces --> array

%% syntaxe : solid1 solid2 solidfuz -> solid

%% syntaxe : solid i solidgetsommetsface -> array
%% array = tableau de points 3d
/solidgetsommetsface {
1 dict begin
   /i exch def
   /solid exch def
   /F solid i solidgetface def
   [
      0 1 F length 1 sub {
         /k exch def
         solid F k get solidgetsommet
      } for
   ]
end
} def

%% syntaxe : solid index table solidputface -> -
/solidputface {
1 dict begin
   /table exch def
   /i exch def
   solidgetfaces i table put
end
} def

%% syntaxe : solid table solidaddface -> -
%% syntaxe : solid table (couleur) solidaddface -> -
%% on ne se preoccupe pas des faces internes
/solidaddface {
6 dict begin
   dup isstring {
      /lac@uleur exch def
   } {
      /lac@uleur () def
   } ifelse
   /table exch def
   /solid exch def
   /IO solid solidgetinouttable def
   /n2 IO 1 get def
   /FC solid solidgetoutcolors def
   IO 1 n2 1 add put
   solid [ solid solidgetfaces aload pop table ] solidputfaces
   solid IO solidputinouttable
%   solid solidnombrefaces
    solid [
      FC aload pop lac@uleur
    ] solidputoutcolors
end
} def

/solidnombrefaces {
1 dict begin
   /solid exch def
   solid solidnombreinfaces
   solid solidnombreoutfaces
   add 
end
} def

%% syntaxe : solid M solidaddsommetexterne -> -
%% on ajoute le sommet sans se preoccuper de rien
/solidaddsommetexterne {
2 dict begin
   /M defpoint3d
   /solid exch def
   solid
   [ solid solidgetsommets aload pop M ]
   solidputsommets
end
} def

%% syntaxe : solid array solidaddsommets -> -
/solidaddsommets {
2 dict begin
   /table exch def
   /solid exch def
   /n table length 3 idiv def
   0 1 0 {
      /i exch def
      solid table i getp3d solidaddsommet pop
   } for
end
} def

%% syntaxe : solid M solidaddsommet -> k
%% on ajoute le sommet M. Si il est deja sur une arete,
%% on l incorpore a la face concernee 
%% s il est deja present, on ne le rajoute pas.
%% Renvoie l indice du sommet rajoute.
/solidaddsommet {
10 dict begin
   /M defpoint3d
   /solid exch def
   /nbf solid solidnombrefaces def
   /N solid solidnombresommets def
   /sortie -1 def
   %% le sommet est-il deja dans la structure
   0 1 N 1 sub {
      /i exch def
%%       (addsommet) ==
%%       solid i solidgetsommet == == == 
%%       M == == ==
%%       solid i solidgetsommet M eqp3d ==
   
%      solid i solidgetsommet M eqp3d {
      solid i solidgetsommet M distance3d 1e-5 le {
         %% oui => c est fini
         /sortie i store
      } if
   } for
   sortie 0 lt {
      %% non => on le rajoute
      /sortie N def
      solid M solidaddsommetexterne
      %% est il sur une arete deja codee
      0 1 nbf 1 sub {
         %% face d indice i
         /i exch def
         solid i solidgetface /F exch def
         /nbsf F length def
         0 1 nbsf 1 sub {
            /j exch def
            M
            solid j i solidgetsommetface 
            solid j 1 add nbsf mod i solidgetsommetface 
            point3dsursegment {
               %% il est sur l arete concernee
               solid i [
                  0 1 j {
                     /k exch def
                     F k get
                  } for
                  N
                  j 1 add nbsf mod dup 0 eq {
                     pop
                  } {
                     1 nbsf 1 sub {
                        /k exch def
                        F k get
                     } for
                  } ifelse
               ]  solidputface
               exit
            } if
         } for 
      } for
   } if
   sortie
end
} def

%%%%% ### solidrmsommet ###
%% syntaxe : solid i solidrmsommet -> -
/solidrmsommet {
5 dict begin
   /i exch def
   /solid exch def
   solid issolid not {
      (Erreur : mauvais type d argument dans solidrmsommet) ==
      quit 
   } if
   solid i solidsommetsadjsommet length 0 gt {
      (Erreur : sommet non isole dans solidrmsommet) ==
      quit 
   } if

   %% on s occupe des sommets
   /n solid solidnombresommets def
   /S [
      0 1 n 1 sub {
         /j exch def
         j i ne {
            solid j solidgetsommet
         } if
      } for
   ] def
   solid S solidputsommets
   %% on s occupe des faces
   /n solid solidnombrefaces def
   /F [
      0 1 n 1 sub {
         %% face d indice j
         /j exch def
         /Fj solid j solidgetface def
         [0 1 Fj length 1 sub {
            %% sommet d indice k de la face Fj
            /k exch def
            Fj k get dup i gt {
               1 sub
            } if
         } for]
      } for
   ] def
   solid F solidputfaces
end
} def

%%%%% ### solidsommetsadjsommet ###
%% syntaxe : solid i solidsommetsadjsommet --> array
%% array est le tableau des indices des sommets adjacents au
%% sommet d indice i
/solidsommetsadjsommet {
6 dict begin
   /no exch def
   /solid exch def
   solid no solidfacesadjsommet /facesadj exch def
   /sommetsadj [] def
   /nbadj facesadj length def
   0 1 nbadj 1 sub {
      /j exch def
      %% examen de la jieme face
      %/j 0 def
      /F solid facesadj j get solidgetface def
      /nbsommetsface F length def
      no F in {
         /index exch def
         /i1 F index 1 sub nbsommetsface modulo get def
         /i2 F index 1 add nbsommetsface mod get def
         %% si i1 n est pas deja note, on le rajoute
         i1 sommetsadj in {
            pop
         } {
            /sommetsadj [ sommetsadj aload pop i1 ] store
         } ifelse
         %% si i2 n est pas deja note, on le rajoute
         i2 sommetsadj in {
            pop
         } {
            /sommetsadj [ sommetsadj aload pop i2 ] store
         } ifelse
      } {
         (Error : bug dans solidsommetsadjsommet) ==
         quit
      } ifelse
   } for
   sommetsadj
end
} def

%%%%% ### solidfacesadjsommet ###
%% syntaxe : solid i solidfacesadjsommet --> array
%% array est le tableau des indices des faces adjacentes au
%% sommet d indice i
/solidfacesadjsommet {
6 dict begin
   /no exch def
   /solid exch def
   /n solid solidnombrefaces def
   /indicesfacesadj [] def
   0 1 n 1 sub {
      /j exch def
      /F solid j solidgetface def
      no F in {
         pop
         /indicesfacesadj [ indicesfacesadj aload pop j ] store
      } if
   } for
   indicesfacesadj
end
} def

%%%%% ### ordonnepoints3d ###
%% syntaxe : array1 M ordonnepoints3d --> array2
%% array1 = tableau de points 3d coplanaires (plan P)
%% M = point3d indiquant la direction de la normale a P
%% array2 = les indices des points de depart, ranges dans le 
%% sens trigo par rapport a la normale
/ordonnepoints3d {
5 dict begin
   /M defpoint3d
   /table exch def
   table isobarycentre3d /G defpoint3d
   %% calcul de la normale
   table 0 getp3d /ptref defpoint3d
   table 1 getp3d /A defpoint3d
   G ptref vecteur3d
   G A vecteur3d
   vectprod3d /vecteurnormal defpoint3d
   vecteurnormal G M vecteur3d scalprod3d 0 lt {
      vecteurnormal -1 mulv3d /vecteurnormal defpoint3d
   } if
   %% la table des angles
   table duparray exch pop
   {1 dict begin
      /M defpoint3d
      G ptref vecteur3d
      G M vecteur3d
      vecteurnormal angle3doriente
   end} papply3d
%   [0 1 table length 3 idiv 1 sub {} for]
%   exch
    doublebubblesort pop
end
} def

%%%%% ### fin insertion ###

%% /tracelignedeniveau? false def
%% /hauteurlignedeniveau 1 def
%% /couleurlignedeniveau {rouge} def
%% /linewidthlignedeniveau 4 def
%% 
%% /solidgrid true def
%% /aretescachees true def
%% /defaultsolidmode 2 def

%% syntaxe : alpha beta r h newpie --> solid
/newpie {
6 dict begin
   [[/resolution /nbetages] [8 1] [10 1] [12 1] [18 3] [36 5]] gestionsolidmode
   /h exch def
   /r exch def
   /beta exch def
   /alpha exch def
   [
      0 0
%      alpha cos r mul alpha sin r mul
      alpha beta {1 dict begin /t exch def t cos r mul t sin r mul end} CourbeR2+
   ] 0 h [nbetages] newprismedroit
end
} def

%%%%% ### newsolid ###
%% syntaxe : newsolid --> depose le solide nul sur la pile
/newsolid {
   [] [] generesolid
} def

%%%%% ### generesolid ###
/generesolid {
2 dict begin
   /F exch def
   /S exch def
   [S F [F length {()} repeat] [0 F length 1 sub -1 -1]]
end
} def

%%%%% ### nullsolid ###
%% syntaxe : solide nullsolid -> booleen, vrai si le solide est nul
/nullsolid {
1 dict begin
   /candidat exch def
   candidat issolid not {
      (Error type argument dans "nullsolid") ==
      quit
   } if
   candidat solidgetsommets length 0 eq {
      true
   } {
      false
   } ifelse
end
} def

%%%%% ### solidnombreoutfaces ###
/solidnombreoutfaces {
4 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidnombreoutfaces) ==
      quit
   } if
   solid nullsolid {
      0
   } {
      /IO solid solidgetinouttable def
      IO 1 get
      IO 0 get sub
      1 add
   } ifelse
end
} def

%%%%% ### solidnombreinfaces ###
/solidnombreinfaces {
4 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidnombreinfaces) ==
      quit
   } if
   solid solidwithinfaces {
      /IO solid solidgetinouttable def
      IO 3 get
      IO 2 get sub
      1 add
   } {
      0
   } ifelse
end
} def

%%%%% ### solidtests ###
%% syntaxe : solid solidwithinfaces --> bool, true si le solide est vide
/solidwithinfaces {
2 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidwithinfaces) ==
      quit
   } if
   /table solid solidgetinouttable def
   table 2 get -1 ne {
      true
   } {
      false
   } ifelse
end
} def

%%%%% ### solidgetsommet ###
%% syntaxe : solid i j solidgetsommetface --> sommet i de la face j
/solidgetsommetface {
6 dict begin
   /j exch def
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetsommetface) ==
      quit
   } if
   /table_faces solid solidgetfaces def
   /table_sommets solid solidgetsommets def
   /k table_faces j get i get def
   table_sommets k getp3d
end
} def

%% syntaxe : solid i solidgetsommetsface --> array, tableau des
%% sommets de la face i du solide
/solidgetsommetsface {
6 dict begin
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetsommetsface) ==
      quit
   } if
   /table_faces solid solidgetfaces def
   /table_sommets solid solidgetsommets def
   /table_indices table_faces i get def
   [
      0 1 table_indices length 1 sub {
         /j exch def
         table_sommets table_indices j get getp3d
      } for
   ]
end
} def

%% syntaxe : solid i solidgetsommet --> sommet i du solide
/solidgetsommet {
3 dict begin
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetsommet) ==
      quit
   } if
   /table_sommets solid solidgetsommets def
   table_sommets i getp3d
end
} def

%%%%% ### solidcentreface ###
%% syntaxe : solid i solidcentreface --> M
/solidcentreface {
   solidgetsommetsface isobarycentre3d
} def

%%%%% ### solidnombre ###
/solidnombresommets {
   solidgetsommets length 3 idiv
} def

/solidfacenombresommets {
   solidgetface length
} def

/solidnombrefaces {
   solidgetfaces length
} def

%%%%% ### solidshowsommets ###
/solidshowsommets {
8 dict begin
   dup issolid not {
      %% on a un argument
      /option exch def
   } if
   /sol exch def
   /n sol solidnombresommets def
   /m sol solidnombrefaces def
   currentdict /option known not {
      /option [0 1 n 1 sub {} for] def
   } if
   0 1 option length 1 sub {
      /k exch def
      option k get /i exch def       %% indice du sommet examine
      sol i solidgetsommet point3d
   } for
end
} def

%%%%% ### solidnumsommets ###
/solidnumsep 15 def
/solidnumsommets {
8 dict begin
%   Font findfont 10 scalefont setfont
   dup issolid not {
      %% on a un argument
      /option exch def
   } if
   /sol exch def
   /n sol solidnombresommets def
   /m sol solidnombrefaces def
   currentdict /option known not {
      /option [0 1 n 1 sub {} for] def
   } if
   /result [
      n {false} repeat
   ] def
   0 1 option length 1 sub {
      /k exch def
      option k get /i exch def       %% indice du sommet examine
      0 1 m 1 sub {
         /j exch def %% indice de la face examinee
         i sol j solidgetface in {
            %% le sommet i est dans la face j
            pop
            exit
         } if
      } for
      sol i solidgetsommet /S defpoint3d
      i (   ) cvs
      m 0 ne {
         %% le sommet i est dans la face j
         sol j solidcentreface /G defpoint3d
         G S vecteur3d normalize3d
         solidnumsep dup ptojpoint pop
         mulv3d
         S addv3d
         3dto2d cctext 
      } {
         S 3dto2d uctext
      } ifelse
   } for
end
} def

%%%%% ### gestionsolidmode ###
%% table = [ [vars] [mode0] [mode1] [mode2] [mode3] [mode4] ]
/gestionsolidmode {
5 dict begin
   /table exch def
   dup xcheck {
      /mode exch def
   } {
      dup isarray {
         /tableaffectation exch def
         /mode -1 def
      } {
         /mode defaultsolidmode def
      } ifelse
   } ifelse
   /vars table 0 get def
   /nbvars vars length def
   mode 0 ge {
      /tableaffectation table mode 1 add 5 min get def
   } if
   0 1 nbvars 1 sub {
      /i exch def
      vars i get
      tableaffectation i get
   } for
   nbvars 
end
   {def} repeat
} def

%%%%% ### solidfuz ###
%% syntaxe : solid1 solid2 solidfuz -> solid
/solidfuz {
5 dict begin
   /solid2 exch def
   /solid1 exch def
   /S1 solid1 solidgetsommets def
   /S2 solid2 solidgetsommets def
   /n S1 length 3 idiv def

   %% les sommets
   /S S1 S2 append def

   %% les faces internes et leurs couleurs
   /FI1 solid1 solidgetinfaces def
   /FIC1 solid1 solidgetincolors def
   solid2 solidnombreinfaces 0 eq {
      /FI2 [] def
      /FIC2 [] def
   } {
      /FI2 solid2 solidgetinfaces {{n add} apply} apply def
      /FIC2 solid2 solidgetincolors def
   } ifelse
   /FI [FI1 aload pop FI2 aload pop] def
   /FIC [FIC1 aload pop FIC2 aload pop] def

   %% les faces externes et leurs couleurs
   /FO1 solid1 solidgetoutfaces def
   /FOC1 solid1 solidgetoutcolors def
   /FO2 solid2 solidgetoutfaces {{n add} apply} apply def
   /FOC2 solid2 solidgetoutcolors def
   /FO [FO1 aload pop FO2 aload pop] def
   /FOC [FOC1 aload pop FOC2 aload pop] def

   /F [FO aload pop FI aload pop] def
   /FC [FOC aload pop FIC aload pop] def
   /IO [
      0 FO length 1 sub
      FI length 0 gt {
         dup 1 add dup FI length add 1 sub
      } {
         -1 -1
      } ifelse
   ] def

   S F generesolid
   dup FC solidputfcolors
   dup IO solidputinouttable
end
} def

%%%%% ### solidnormaleface ###
%% syntaxe : solid i solidnormaleface --> u, vecteur normale a la
%% face d indice i du solide
/solidnormaleface {
4 dict begin
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetsommetface) ==
      quit
   } if
%%    solid 0 i solidgetsommetface /G defpoint3d
%%    G
%%    solid 1 i solidgetsommetface
%%    vecteur3d
%%    G
%%    solid 2 i solidgetsommetface
%%    vecteur3d
%
   /n solid i solidfacenombresommets def
   n 3 ge {
      [
         solid 0 i solidgetsommetface
         solid 1 i solidgetsommetface
         solid 2 i solidgetsommetface
      ] isobarycentre3d /G defpoint3d
   } {
      solid i solidcentreface /G defpoint3d
   } ifelse
  %% debug %%   G 3dto2d point
   G
   solid 0 i solidgetsommetface
   /A defpoint3d
  %   gsave bleu A point3d grestore
   A
   vecteur3d normalize3d
   G
   solid 1 i solidgetsommetface
   /A defpoint3d
  %   gsave orange A point3d grestore
   A
   vecteur3d normalize3d
   vectprod3d
   /resultat defpoint3d
   resultat normalize3d
end
} def

%%%%% ### solidtransform ###
%% syntaxe : solid1 {f} solidtransform --> solid2, solid2 est le
%% transforme de solid1 par la transformation f : R^3 -> R^3
/solidtransform {
3 dict begin
   /@f exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidtransform) ==
      quit
   } if
   /les_sommets
      solid solidgetsommets {@f} papply3d
   def
   solid les_sommets solidputsommets
   solid
end
} def

%%%%% ### solidputcolor ###
%% syntaxe : solid i string solidputfcolor
/solidputfcolor {
3 dict begin
   /str exch def
   /i exch def
   /solid exch def
   /FC solid solidgetfcolors def
   i FC length lt {
      FC i str put
   } if
end
} def

%% syntaxe : solid solidgetincolors --> array
/solidgetincolors {
3 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetincolors) ==
      quit
   } if
   solid solidwithinfaces {
      /fcol solid solidgetfcolors def
      /IO solid solidgetinouttable def
      /n1 IO 2 get def
      /n2 IO 3 get def
      /n n2 n1 sub 1 add def
      fcol n1 n getinterval
   } {
      []
   } ifelse
end
} def

%% syntaxe : solid solidgetoutcolors --> array
/solidgetoutcolors {
3 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetoutcolors) ==
      quit
   } if
   /fcol solid solidgetfcolors def
   /IO solid solidgetinouttable def 
   /n1 IO 0 get def
   /n2 IO 1 get def
   /n n2 n1 sub 1 add def
   fcol n1 n getinterval 
end
} def
 
%% syntaxe : solid array solidputincolors --> -
/solidputincolors {
4 dict begin
   /newcolorstable exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidputincolors) ==
      quit
   } if
   /n newcolorstable length def
   n solid solidnombreinfaces ne {
      (Error : mauvaise longueur de tableau dans solidputincolors) ==
      quit
   } if
   n 0 ne {
      /FC solid solidgetfcolors def
      /IO solid solidgetinouttable def
      /n1 IO 2 get def
      FC n1 newcolorstable putinterval
   } if
end
} def

%% syntaxe : solid array solidputoutcolors --> -
/solidputoutcolors {
4 dict begin
   /newcolorstable exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidputoutcolors) ==
      quit
   } if
   /n newcolorstable length def
   n solid solidnombreoutfaces ne {
      (Error : mauvaise longueur de tableau dans solidputoutcolors) ==
      quit
   } if
   n 0 ne {
      /FC solid solidgetfcolors def
      /IO solid solidgetinouttable def
      /n1 IO 0 get def
      FC n1 newcolorstable putinterval
   } if
end
} def

%% syntaxe : solid str outputcolors
/outputcolors {
5 dict begin
   /color exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans inoutputcolors) ==
      quit
   } if
   /n solid solidnombreoutfaces def
   solid [ n {color} repeat ] solidputoutcolors
end
} def

%% syntaxe : solid str inputcolors
/inputcolors {
5 dict begin
   /color exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans inoutputcolors) ==
      quit
   } if
   /n solid solidnombreinfaces def
   solid [ n {color} repeat ] solidputincolors
end
} def

%% syntaxe : solid str1 str2 inoutputcolors
/inoutputcolors {
5 dict begin
   /colout exch def
   /colin exch def
   /solid exch def
   solid colin inputcolors
   solid colout outputcolors
end
} def

%% syntaxe : solid array solidputoutcolors --> -
/solidputoutcolors {
4 dict begin
   /newcolorstable exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidputoutcolors) ==
      quit
   } if
   /n newcolorstable length def
   n solid solidnombreoutfaces ne {
      (Error : mauvaise longueur de tableau dans solidputoutcolors) ==
      quit
   } if
   n 0 ne {
      /FC solid solidgetfcolors def
      /IO solid solidgetinouttable def
      /n1 IO 0 get def
      FC length n n1 add lt {
         solid newcolorstable solidputfcolors
      } {
         FC n1 newcolorstable putinterval
      } ifelse
   } if
end
} def

/solidputcolors {
3 dict begin
   2 copy pop
   isstring {
      inoutputcolors
   } {
      outputcolors
   } ifelse
end
} def

%%%%% ### solidputhuecolors ###
%% syntaxe : solid table solidputhuecolors --> -
/solidputhuecolors {
1 dict begin
   2 copy pop
   solidgetinouttable /IO exch def
   IO 0 get
   IO 1 get
   s@lidputhuec@l@rs
end
} def

/solidputinhuecolors {
2 dict begin
   /table exch def
   /solid exch def
   solid solidgetinouttable /IO exch def
   solid solidwithinfaces {
      solid table
      IO 2 get
      IO 3 get
      s@lidputhuec@l@rs
   } if
end
} def

/solidputinouthuecolors {
1 dict begin
   2 copy pop
   solidgetinouttable /IO exch def
   IO 0 get
   IO 3 get IO 1 get max
   s@lidputhuec@l@rs
end
} def

%% syntaxe : solid table n1 n2 s@lidputhuec@l@rs --> -
%% affecte les couleurs des faces d indice n1 a n2 du solid solid, par
%% un degrade defini par la table.
 /s@lidputhuec@l@rs {
9 dict begin
   /n2 exch def
   /n1 exch def
   /table exch def
   /solid exch def
   /n n2 n1 sub def

   table length 2 eq {
       /a0 table 0 get def
       /a1 table 1 get def
       a1 isstring {
          /lacouleurdepart {
             gsave
                [a0 cvx exec] length 0 eq {
                   a0 cvx exec currentrgbcolor
                } {
                   a0 cvx exec
                } ifelse 
             grestore
          } def
          /lacouleurarrivee {
             gsave
                [a1 cvx exec] length 0 eq {
                   a1 cvx exec currentrgbcolor
                } {
                   a1 cvx exec
                } ifelse 
             grestore
          } def
          /table [lacouleurdepart lacouleurarrivee] def
       } {
          /A {a0 i a1 a0 sub mul n 1 sub div add} def
          /B {1} def
          /C {1} def
          /D {} def
          /espacedecouleurs (sethsbcolor) def
       } ifelse
   } if

   table length 4 eq {
       /a0 table 0 get def
       /a1 table 1 get def
       /A {a0 i a1 a0 sub mul n 1 sub div add} def
       /B table 2 get def
       /C table 3 get def
       /D {} def
       /espacedecouleurs (sethsbcolor) def
   } if

   table length 6 eq {
       /a0 table 0 get def
       /b0 table 1 get def
       /c0 table 2 get def
       /a1 table 3 get def
       /b1 table 4 get def
       /c1 table 5 get def
       /A {a0 i a1 a0 sub mul n 1 sub div add} def
       /B {b0 i b1 b0 sub mul n 1 sub div add} def
       /C {c0 i c1 c0 sub mul n 1 sub div add} def
       /D {} def
       /espacedecouleurs (setrgbcolor) def
   } if

   table length 7 eq {
       /a0 table 0 get def
       /b0 table 1 get def
       /c0 table 2 get def
       /a1 table 3 get def
       /b1 table 4 get def
       /c1 table 5 get def
       /A {a0 i a1 a0 sub mul n 1 sub div add} def
       /B {b0 i b1 b0 sub mul n 1 sub div add} def
       /C {c0 i c1 c0 sub mul n 1 sub div add} def
       /D {} def
       /espacedecouleurs (sethsbcolor) def
   } if

   table length 8 eq {
       /a0 table 0 get def
       /b0 table 1 get def
       /c0 table 2 get def
       /d0 table 3 get def
       /a1 table 4 get def
       /b1 table 5 get def
       /c1 table 6 get def
       /d1 table 7 get def
       /A {a0 i a1 a0 sub mul n 1 sub div add} def
       /B {b0 i b1 b0 sub mul n 1 sub div add} def
       /C {c0 i c1 c0 sub mul n 1 sub div add} def
       /D {d0 i d1 d0 sub mul n 1 sub div add} def
       /espacedecouleurs (setcmykcolor) def
   } if

   n1 1 n2 {
      /i exch def
      solid i
      [A B C D] espacedecouleurs astr2str
      solidputfcolor
   } for
   
end
} def

%%%%% ### solidrmface ###
%% syntaxe : solid i solidrmface -> -
/solidrmface {
5 dict begin
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidrmface) ==
      quit
   } if
   %% on enleve la face
   /F solid solidgetfaces def
   F length 1 sub i lt {
      (Error : indice trop grand dans solidrmface) ==
      quit
   } if
   [
      0 1 F length 1 sub {
         /j exch def
         i j ne {
            F j get
         } if
      } for
   ]
   /NF exch def
   solid NF solidputfaces
   %% on enleve la couleur correspondante
   /FC solid solidgetfcolors def
   [
      0 1 FC length 1 sub {
         /j exch def
         i j ne {
            FC j get
         } if
      } for
   ]
   /NFC exch def
   solid NFC solidputfcolors
   %% on ajuste la table inout
   /IO solid solidgetinouttable def
   solid i solidisoutface {
      IO 1 IO 1 get 1 sub put 
      solid solidwithinfaces {
         IO 2 IO 2 get 1 sub put
         IO 3 IO 3 get 1 sub put
      } if
   } if
   solid i solidisinface {
      IO 1 IO 1 get 1 sub put
      IO 2 IO 2 get 1 sub put
      IO 3 IO 3 get 1 sub put
   } if
   solid IO solidputinouttable
end
} def

%% syntaxe : solid table solidrmfaces --> -
/solidrmfaces {
2 dict begin
   /table exch bubblesort reverse def
   /solid exch def
   table {solid exch solidrmface} apply
end
} def

%%%%% ### videsolid ###
%% syntaxe : solid videsolid -> -
/videsolid {
5 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans videsolid) ==
      quit
   } if
   solid solidwithinfaces not {
      /IO solid solidgetinouttable def
      /FE solid solidgetfaces def
      /n FE length def
      IO 2 n put
      IO 3 2 n mul 1 sub put
      solid IO solidputinouttable
      %% on inverse chaque face
      /FI FE {reverse} apply def
      solid FE FI append solidputfaces
      %% et on rajoute autant de couleurs vides que de faces
      /FEC solid solidgetfcolors def
%      /FIC [FI length {()} repeat] def
%      solid FEC FIC append solidputfcolors
      solid FEC duparray append solidputfcolors
   } if 
end
} def

%%%%% ### solidnumfaces ###
%% syntaxe : solid array solidnumfaces
%% syntaxe : solid array bool solidnumfaces
%% array, le tableau des indices des faces a numeroter, est optionnel
%% si bool=true, on ne numerote que les faces visibles
/solidnumfaces {
5 dict begin
   dup isbool {
      /bool exch def
   } {
      /bool true def
   } ifelse
%   setTimes
   dup issolid not {
      %% on a un argument
      /option exch def 
   } if
   /sol exch def
   /n sol solidnombrefaces def
   currentdict /option known not {
      /option [0 1 n 1 sub {} for] def
   } if

   0 1 option length 1 sub {
      /i exch def
      /j option i get def
      j (     ) cvs sol j bool cctextp3d
   } for
end
} def

%%%%% ### creusesolid ###
%% syntaxe : solid creusesolid -> -
/creusesolid {
5 dict begin
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans creusesolid) ==
      quit
   } if
   %% on enleve le fond et le chapeau
   solid 1 solidrmface
   solid 0 solidrmface
   %% on inverse chaque face
   solid videsolid
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                 dessin des solides                 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### solidisinface ###
%% syntaxe : solid i solidisinface --> bool
%% true si i est l indice d une face interne, false sinon
/solidisinface {
4 dict begin
   /i exch def
   solidgetinouttable /IO exch def
   /n1 IO 2 get def
   /n2 IO 3 get def
   n1 i le 
   i n2 le and
end
} def

%%%%% ### solidisoutface ###
%% syntaxe : solid i solidisoutface --> bool
%% true si i est l indice d une face externe, false sinon
/solidisoutface {
4 dict begin
   /i exch def
   solidgetinouttable /IO exch def
   /n1 IO 0 get def
   /n2 IO 1 get def
   n1 i le 
   i n2 le and
end
} def

%%%%% ### planvisible ###
%% syntaxe : A k planvisible? --> true si le plan est visible
/planvisible? {
4 dict begin
   /normale_plan defpoint3d
   /origine defpoint3d
   /ligne_de_vue {
      origine
      GetCamPos
      vecteur3d
   } def
   ligne_de_vue normale_plan scalprod3d 0 gt
end
} def

%%%%% ### solidlight ###
/setlightintensity {
   /lightintensity exch def
} def

/setlightsrc {
   /lightsrc defpoint3d
} def

/setlight {
1 dict begin
gsave
   exec
   [ currentrgbcolor ] /lightcolor exch 
grestore
end
def
} def

%%%%% ### drawsolid ###
/solidlightOn {
   /s@lidlight true def
} def
/solidlightOff {
   /s@lidlight false def
} def
solidlightOff

%% syntaxe : solid i solidfacevisible? --> true si la face est visible
/solidfacevisible? {
4 dict begin
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans solidgetsommetface) ==
      quit
   } if
   solid i solidgetface length 2 le {
      true
   } {
      /ligne_de_vue {
         solid i solidcentreface
         GetCamPos
         vecteur3d
      } def
   
      /normale_face {
         solid i solidnormaleface
      } def
      ligne_de_vue normale_face scalprod3d 0 gt
   } ifelse
end
} def

%% syntaxe : solid i affectecouleursolid_facei --> si la couleur de
%% la face i est definie, affecte fillstyle a cette couleur
/affectecouleursolid_facei {
3 dict begin
   /i exch def
   /solid exch def
   solid solidgetfcolors /FC exch def
   FC length 1 sub i ge {
      FC i get length 1 ge {
         /fillstyle FC i get ( Fill) append cvx
         solidgrid not {
            FC i get cvx exec
         } if
         true
      } {
         false
      } ifelse
   } {
      false
   } ifelse
end
{def} if
} def

%% syntaxe : solid i dessinefacecachee
/dessinefacecachee {
11 dict begin
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans dessinefacecachee) ==
      quit
   } if

   /F solid solidgetfaces def
   /S solid solidgetsommets def

   %% face cachee => on prend chacune des aretes de la face et on
   %% la dessine
   4 dict begin
      /n F i get length def %% nb de sommets de la face
      0 1 n 1 sub {
         /k exch def
         /k1 F i k get_ij def              %% indice sommet1
         /k2 F i k 1 add n mod get_ij def  %% indice sommet2
         gsave
            currentlinewidth .5 mul setlinewidth
            pointilles
            [S k1 getp3d
            S k2 getp3d sortp3d] ligne3d
         grestore
      } for

   %% trace de la ligne de niveau
   solidintersectiontype 0 ge {
      /face_a_dessiner [  %% face visible : F [i]
         0 1 n 1 sub {
            /j exch def
            solid j i solidgetsommetface
         } for
      ] def 
      0 1 solidintersectionplan length 1 sub {
         /k exch def
         /lignedeniveau [] def
         gsave
	    solidintersectiontype 0 eq {
	       pointilles
	    } {
	       continu
	    } ifelse
            k solidintersectionlinewidth length lt {
               solidintersectionlinewidth k get setlinewidth
            } {
               solidintersectionlinewidth 0 get setlinewidth
            } ifelse
            k solidintersectioncolor length lt {
               solidintersectioncolor k get cvx exec
            } {
               solidintersectioncolor 0 get cvx exec
            } ifelse
            0 1 n 1 sub {
               /j exch def
               face_a_dessiner j getp3d
               face_a_dessiner j 1 add n mod getp3d
               solidintersectionplan k get
               dup isarray {
                  segment_inter_plan
               } {
                  segment_inter_planz
               } ifelse {
               1 dict begin
                  /table exch def
                  table length 6 eq {
                     /lignedeniveau table store
                     exit
                  } {
                     /lignedeniveau [ 
                        lignedeniveau aload pop 
                        table 0 getp3d
                     ] store
                  } ifelse
               end
               } if
            } for
            
            %% dessin de la ligne
            lignedeniveau length 4 ge {
               [lignedeniveau aload pop sortp3d] ligne3d
            } if
         grestore
      } for         
   } if
   
   end
end
} def

%% syntaxe : solid i dessinefacevisible
/dessinefacevisible {
8 dict begin
   /i exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans dessinefacevisible) ==
      quit
   } if
   /F solid solidgetfaces def
   /S solid solidgetsommets def

   /n F i get length def %% nb de sommets de la face

   startest {
      s@lidlight {
         /coeff
            lightintensity
            solid i solidnormaleface normalize3d
            solid i solidcentreface lightsrc vecteur3d normalize3d
            scalprod3d mul
            0 max 1 min
         def
         /lightcolor where {
            pop
            /lacouleur lightcolor def
         } {
            /lacouleur [
               gsave
                  solid solidgetfcolors i get cvx exec currentrgbcolor
               grestore
            ] def
         } ifelse
         /fillstyle {
             lacouleur {coeff mul} apply setcolor Fill
         } def
         solidgrid not {
            lacouleur {coeff mul} apply setcolor
         } if
      } {
         n 2 eq {
            1 dict begin
               solidgridOff
               solid i affectecouleursolid_facei
            end
         } {
            solid i affectecouleursolid_facei
         } ifelse
      } ifelse
   } if

   /face_a_dessiner [  %% face visible : F [i]
      0 1 n 1 sub {
         /j exch def
         solid j i solidgetsommetface
      } for
   ] def 
   face_a_dessiner polygone3d

   %% trace de la ligne de niveau
   solidintersectiontype 0 ge {
      0 1 solidintersectionplan length 1 sub {
         /k exch def
         /lignedeniveau [] def
         gsave
            k solidintersectionlinewidth length lt {
               solidintersectionlinewidth k get setlinewidth
            } {
               solidintersectionlinewidth 0 get setlinewidth
            } ifelse
            k solidintersectioncolor length lt {
               solidintersectioncolor k get cvx exec
            } {
               solidintersectioncolor 0 get cvx exec
            } ifelse
            0 1 n 1 sub {
               /j exch def
               face_a_dessiner j getp3d
               face_a_dessiner j 1 add n mod getp3d
               solidintersectionplan k get
               dup isarray {
                  segment_inter_plan
               } {
                  segment_inter_planz
               } ifelse {
               1 dict begin
                  /table exch def
                  /lignedeniveau [ 
                     lignedeniveau aload pop 
                     table 0 getp3d
                     table length 4 ge {
                        table 1 getp3d
                     } if
                  ] store
               end
               } if
            } for
            
            %% dessin de la ligne
            lignedeniveau length 4 ge {
               solid i solidisinface solidintersectiontype 0 eq and {
                  pointilles 
               } if
               lignedeniveau ligne3d
            } if
         grestore
      } for         
   } if
      
end
} def

/drawsolid* {
1 dict begin
   /startest {true} def
   drawsolid
end
} def

/peintrealgorithme false def

/drawsolid** {
2 dict begin
   /aretescachees false def
   /peintrealgorithme true def
   drawsolid*
end
} def

%% syntaxe : solid array drawsolid
%% array est en option, il indique les faces triees
/drawsolid {
8 dict begin
   dup issolid not {
      /ordre exch def
   } if
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans drawsolid) ==
      quit
   } if
   solid nullsolid not {
      solid solidgetfaces
      /F exch def
      solid solidgetsommets
      /S exch def
      /n S length 3 idiv def

      currentdict /ordre known not {
         peintrealgorithme {
            %% tri des indices des faces par distance decroissante
            [
               0 1 F length 1 sub {
                  /i exch def
                  solid i solidcentreface
                  GetCamPos
                  distance3d
               } for
            ] doublequicksort pop reverse
         } {
            [
               0 1 F length 1 sub {
               } for
            ]
         } ifelse
         /ordre exch def
      } if

      0 1 F length 1 sub {
         /k exch def
         /i ordre k get def
         gsave
            solid i solidfacevisible? {
               solid i dessinefacevisible
            } if
         grestore
      } for
      aretescachees {
         0 1 F length 1 sub {
            /k exch def
            /i ordre k get def
            gsave
               solid i solidfacevisible? not {
                  solid i dessinefacecachee
               } if 
            grestore
         } for
      } if

%%       %% si on veut repasser les traits des faces visibles
%%       0 1 F length 1 sub {
%%          /k exch def
%%          /i ordre k get def
%%          gsave
%%          1 dict begin
%%             /startest false def
%%             solid i solidfacevisible? {
%%             solid i dessinefacevisible
%%             } if
%%          end
%%          grestore
%%       } for
   } if
end
} def

%%%%% ### segment_inter_planz ###
%% syntaxe : A B k segment_inter_planz --> array true ou false
/segment_inter_planz {
4 dict begin
   /k exch def
   /B defpoint3d
   /A defpoint3d
   A /zA exch def pop pop
   B /zB exch def pop pop
   zA k sub zB k sub mul dup 0 gt {
      %% pas d intersection
      pop
      false
   } {
      0 eq {
         %% intersection en A ou en B
         [ 
            zA k eq {A} if
            zB k eq {B} if
         ] true
      } {
         %% intersection entre A et B
         [
            A B vecteur3d
            k zA sub zB zA sub div mulv3d
            A addv3d
         ] true
      } ifelse
   } ifelse
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                  plans affines                     %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### planaffine ###
%% plan : origine, base, range, ngrid
%% [0 0 0 [1 0 0 0 1 0] [-3 3 -2 2] [1. 1.] ]

/explan [0 0 0 [1 0 0 0 1 0 0 0 1] [-3 3 -2 2] [1. 1.] ] def

%% syntaxe : any isplan --> bool
/isplan {
1 dict begin
   /candidat exch def
   candidat isarray {
      candidat length 6 eq {
         candidat 3 get isarray {
            candidat 4 get isarray {
               candidat 5 get isarray              
            } {
               false
            } ifelse
         } {
            false
         } ifelse
      } {
         false
      } ifelse
   } {
      false
   } ifelse
end
} def

/newplanaffine {
   [0 0 0 [1 0 0 0 1 0] [-3 3 -2 2] [1 1]] 
} def

/dupplan {
4 dict begin
   /leplan exch def
   /result newplanaffine def
   result leplan plangetorigine planputorigine
   result leplan plangetbase planputbase
   result leplan plangetrange planputrange
   result leplan plangetngrid planputngrid
   result
end
} def

%% syntaxe : plantype getorigine --> x y z
/plangetorigine {
1 dict begin
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans plangetorigine) ==
      Error
   } if
   plan 0 get 
   plan 1 get 
   plan 2 get 
end
} def

%% syntaxe : plantype getbase --> [u v]
%% ou u, v et w vecteurs de R^3
/plangetbase {
1 dict begin
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans plangetbase) ==
      Error
   } if
   plan 3 get 
end
} def

%% syntaxe : plantype getrange --> array
%% ou array = [xmin xmax ymin ymax]
/plangetrange {
1 dict begin
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans plangetrange) ==
      Error
   } if
   plan 4 get 
end
} def

%% syntaxe : plantype getngrid --> array
%% ou array = [n1 n2]
/plangetngrid {
1 dict begin
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans plangetngrid) ==
      Error
   } if
   plan 5 get 
end
} def

%% ===================

%% syntaxe : plantype x y z putorigine --> -
/planputorigine {
4 dict begin
   /z exch def
   /y exch def
   /x exch def
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans planputorigine) ==
      Error
   } if
   plan 0 x put 
   plan 1 y put 
   plan 2 z put 
end
} def

%% syntaxe : plantype [u v w] putbase --> -
%% ou u, v et w vecteurs de R^3
/planputbase {
2 dict begin
   /base exch def
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans planputbase) ==
      Error
   } if
   plan 3 base put 
end
} def

%% syntaxe : plantype array putrange --> -
%% ou array = [xmin xmax ymin ymax]
/planputrange {
2 dict begin
   /table exch def
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans planputrange) ==
      Error
   } if
   plan 4 table put 
end
} def

%% syntaxe : plantype array putngrid --> -
%% ou array = [n1 n2]
/planputngrid {
2 dict begin
   /table exch def
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans planputngrid) ==
      quit
   } if
   plan 5 table put 
end
} def

%% -3 3 -2 2 1. 1. newgrille
%% drawsolid

%orange

%% plan : origine, base, range, ngrid

%% syntaxe : plantype drawplanaffine --> -
/drawplanaffine {
5 dict begin
   /plan exch def
   plan plangetbase 
   aload pop
   /imK defpoint3d
   /imJ defpoint3d
   /imI defpoint3d
   newpath
      plan plangetrange plan plangetngrid aload pop  quadrillagexOy_
      plan plangetorigine [imI imK] false planprojpath
   Stroke
end
} def


%% %% syntaxe : [a b c d] (x0 y0 z0) alpha defeqplanaffine --> plantype
%% %% plan defini par l equation ax+by+cz+d=0, 
%% %% rotation de alpha autour de la normale (alpha est optionnel)
%% %% origine (x0, y0, z0). l origine est optionnelle
%% /defeqplanaffine {
%% 5 dict begin
%%    dup isarray {
%%       /alpha 0 def
%%    } {
%%       dup isstring {
%%          /alpha 0 def
%%       } {
%%          /alpha exch def
%%       } ifelse
%%    } ifelse
%%    dup isstring {
%%       cvx /origine exch def
%%    } if
%%    /table exch def
%%    table length 4 ne {
%%       (Erreur : mauvais type d argument dans defeqplanaffine) ==
%%       Error
%%    } if
%%    table 0 get /a exch def
%%    table 1 get /b exch def
%%    table 2 get /c exch def
%%    table 3 get /d exch def
%%    /resultat newplanaffine def
%%    [a b c alpha] normalvect_to_orthobase
%%    /imK defpoint3d
%%    /imJ defpoint3d
%%    /imI defpoint3d
%%    resultat [imI imJ imK] planputbase
%%    currentdict /origine known {
%%       origine /z exch def /y exch def /x exch def
%%       a x mul b y mul add c z mul add d add 0 ne {
%%          (Erreur : mauvaise origine dans defeqplanaffine) ==
%%          Error
%%       } if
%%       resultat origine planputorigine
%%    } {
%%       c 0 ne {
%%          resultat 0 0 d neg c div planputorigine
%%       } {
%%          a 0 ne {
%%             resultat d neg a div 0 0 planputorigine
%%          } {
%%             resultat 0 d neg b div 0 planputorigine
%%          } ifelse
%%       } ifelse
%%    } ifelse
%%    resultat
%% end
%% } def

%% /explan [0 0 0 [1 0 0 0 1 0 0 0 1] [-3 3 -2 2] [1 1] ] def
%% explan drawplanaffine
%% noir
%% /explan [0 0 2 [1 0 0 0 1 0 0 0 1] [-3 3 -2 2] [1 .5] ] def
%% explan drawplanaffine

%% orange
%% [0 0 1 -2] defeqplanaffine
%% drawplanaffine
%% noir
%% [0 0 1 0] defeqplanaffine
%% drawplanaffine
%% bleu
%% [1 1 1 0] (1 -1 0) defeqplanaffine
%% drawplanaffine
%% 

/dessinebase {
4 dict begin
gsave
   /V3 defpoint3d
   /V2 defpoint3d
   /V1 defpoint3d
   /M0 defpoint3d
   rouge
   V3 newvecteur 
   {M0 translatepoint3d} solidtransform
   drawsolid**
   bleu
   V2 newvecteur 
   {M0 translatepoint3d} solidtransform
   drawsolid**
   orange
   V1 newvecteur 
   {M0 translatepoint3d} solidtransform
   drawsolid**
grestore
end
} def

%% syntaxe : solid i solidface2eqplan --> [a b c d]
%% equation cartesienne de la face d'indice i du solide solid
/solidface2eqplan {
8 dict begin
   /i exch def
   /solid exch def
   solid i solidnormaleface
   /c exch def
   /b exch def
   /a exch def
   solid 0 i solidgetsommetface
   /z exch def
   /y exch def
   /x exch def
   [a b c a x mul b y mul add c z mul add neg]
end
} def


%% syntaxe : plantype newplan --> solid
/newplan {
5 dict begin
   /lepl@n exch def
   lepl@n plangetbase /@base exch def
   @base 0 getp3d /@U defpoint3d
   @base 1 getp3d /@V defpoint3d
   lepl@n plangetorigine /@M defpoint3d
   lepl@n plangetrange /@range exch def
   lepl@n plangetngrid /@ngrid exch def
   /@F {
   2 dict begin
      /@y exch def
      /@x exch def
      @U @x mulv3d
      @V @y mulv3d
      addv3d
      @M addv3d
   end
   } def
   @range aload pop @ngrid {@F} newsurfaceparametree
end
} def

%% syntaxe : M eqplan --> real
%% image de M par la fonction definie par l equation eqplan
/pointeqplan {
8 dict begin
   /eqplan exch def
   /@z exch def
   /@y exch def
   /@x exch def
   /@a eqplan 0 get def
   /@b eqplan 1 get def
   /@c eqplan 2 get def
   /@d eqplan 3 get def
   @a @x mul @b @y mul add @c @z mul add @d add
end
} def

/plan2eq {
6 dict begin
   /leplan exch def
   leplan plangetbase aload pop vectprod3d
   /c exch def
   /b exch def
   /a exch def
   leplan plangetorigine
   /z0 exch def
   /y0 exch def
   /x0 exch def
   [a b c a x0 mul b y0 mul add c z0 mul add neg]
end
} def

%% syntaxe : [a b c d] (x0 y0 z0) alpha defeqplanaffine --> plantype
%% plan defini par l equation ax+by+cz+d=0, 
%% rotation de alpha autour de la normale (alpha est optionnel)
%% origine (x0, y0, z0). l origine est optionnelle
/eq2plan {
5 dict begin
   dup isarray {
      /alpha 0 def
   } {
      dup isstring {
         /alpha 0 def
      } {
         /alpha exch def
      } ifelse
   } ifelse
   dup isstring {
      cvx /origine exch def
   } if
   /table exch def
   table length 4 ne {
      (Erreur : mauvais type d argument dans eq2plan) ==
      quit
   } if
   table 0 get /a exch def
   table 1 get /b exch def
   table 2 get /c exch def
   table 3 get /d exch def
   /resultat newplanaffine def
   [a b c alpha] normalvect_to_orthobase
   /imK defpoint3d
   /imJ defpoint3d
   /imI defpoint3d
   resultat [imI imJ] planputbase
   currentdict /origine known {
      origine /z exch def /y exch def /x exch def
      a x mul b y mul add c z mul add d add 0 ne {
         (Erreur : mauvaise origine dans eq2plan) ==
         quit
      } if
      resultat origine planputorigine
   } {
      c 0 ne {
         resultat 0 0 d neg c div planputorigine
      } {
         a 0 ne {
            resultat d neg a div 0 0 planputorigine
         } {
            b 0 ne {
               resultat 0 d neg b div 0 planputorigine
            } {
               (Error dans eq2plan : (a,b,c) = (0,0,0)) ==
            } ifelse
         } ifelse
      } ifelse
   } ifelse
   resultat
end
} def

/points2eqplan {
10 dict begin
   /C defpoint3d
   /B defpoint3d
   /A defpoint3d
   A B vecteur3d
   A C vecteur3d
   vectprod3d
   normalize3d
   /c exch def
   /b exch def
   /a exch def
   A
   /zA exch def
   /yA exch def
   /xA exch def
   [a b c a xA mul b yA mul add c zA mul add neg]
end
} def

%% /monplan 
%% %[0 0 -2 [1 0 0 0 1 0 0 0 1] [-3 3 -2 2] [1. 1.]]
%% [0 0 1 1] 30 eq2plan
%% def
%% 
%% [0 0 1 -2] eq2plan newplan
%% dup (blanc) outputcolors
%% monplan newplan
%% dup (blanc) outputcolors
%% solidfuz
%% drawsolid**
%% monplan plangetorigine
%% monplan plangetbase aload pop dessinebase

%% syntaxe : x0 y0 z0 [normalvect] norm2plan
/norm2plan {
9 dict begin
   normalvect_to_orthobase
   /imK defpoint3d
   /imJ defpoint3d
   /imI defpoint3d
   imK
   /c exch def
   /b exch def
   /a exch def
   /z0 exch def
   /y0 exch def
   /x0 exch def
   [a b c a x0 mul b y0 mul add c z0 mul add neg] eq2plan
   dup x0 y0 z0 planputorigine
   dup [imI imJ] planputbase
end
} def

%% syntaxe : plantype planxmarks
/planxmarks {
5 dict begin
   dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   /leplan exch def
   leplan plangetrange aload pop
   /ymax exch def
   /ymin exch def
   /xmax exch def
   /xmin exch def
   newpath
      xmin truncate cvi 0 smoveto
      xmax truncate cvi 0 slineto
      leplan mybool projpath
   Stroke
   xmin truncate cvi xmkstep xmax truncate cvi {
      dup 0 ne {
         /x exch def
         x
         x x truncate eq {
            cvi
         } if
         dup chaine cvs exch 0 leplan mybool dctextp3d
         newpath
            x 0 smoveto
            0 2.5 rmoveto
            0 -5 rlineto
            leplan mybool projpath
         Stroke
      } {
         pop (0) 0 0 leplan mybool dltextp3d 
      } ifelse
   } for
end
} def

%% syntaxe : plantype planymarks
/planymarks {
5 dict begin
   dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   /leplan exch def
   leplan plangetrange aload pop
   /ymax exch def
   /ymin exch def
   /xmax exch def
   /xmin exch def
   newpath
      0 ymin truncate cvi smoveto
      0 ymax truncate cvi slineto
      leplan mybool projpath
   Stroke
   ymin truncate cvi ymkstep ymax truncate cvi {
      dup 0 ne {
         /y exch def
         y
         y y truncate eq {
             cvi
         } if
         dup chaine cvs exch 0 exch leplan mybool cltextp3d
         newpath
            0 y smoveto
            2.5 0 rmoveto
            -5 0 rlineto
            leplan mybool projpath
         Stroke
      } {
         pop (0) 0 0 leplan mybool dltextp3d 
      } ifelse
   } for
end
} def

%% syntaxe : plantype planmarks
/planmarks {
1 dict begin
    dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   dup mybool planxmarks mybool planymarks
end
} def

%% bleu
%% [-3 3 -2 2] quadrillagexOy_
%% Stroke
%% noir

%% syntaxe : [xmin xmax ymin ymax] dx dy quadrillagexOy_
/quadrillagexOy_ {
4 dict begin
   dup isarray {
      /dx 1 def
      /dy 1 def
   } {
      /dy exch def
      dup isarray {
         /dx dy def
      } {
         /dx exch def
      } ifelse
   } ifelse
   /table exch def
   table 0 get /xmin exch def
   table 1 get /xmax exch def
   table 2 get /ymin exch def
   table 3 get /ymax exch def
   ymin dy ymax {
      /y exch def
      xmin y smoveto
      xmax y slineto
   } for
   xmin dx xmax {
      /x exch def
      x ymin smoveto
      x ymax slineto
   } for
end
} def

%% syntaxe : plan [ngrid] planquadrillage
/planquadrillage {
4 dict begin
   dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   dup isplan {
      /ngrid [1 1] def
   } {
      /ngrid exch def
   } ifelse
   /leplan exch def
   /dx ngrid 0 get def
   /dy ngrid 1 get def
   /table leplan plangetrange def
   table 0 get cvi truncate /xmin exch def
   table 1 get cvi truncate /xmax exch def
   table 2 get cvi truncate /ymin exch def
   table 3 get cvi truncate /ymax exch def
   newpath
      ymin dy ymax {
         /y exch def
         xmin y smoveto
         xmax y slineto
      } for
      xmin dx xmax {
         /x exch def
         x ymin smoveto
         x ymax slineto
      } for
      leplan mybool projpath
   Stroke
end
} def

%% syntaxe : plantype str1 str2 planshowbase -> - 
%% syntaxe : plantype str2 planshowbase -> - 
%% syntaxe : plantype planshowbase -> - 
/planshowbase {
3 dict begin
   dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   dup isstring {
      /couleur2 exch def
      dup isstring {
         /couleur1 exch def
      } {
         /couleur1 (rouge) def
      } ifelse
   } {
      /couleur1 (rouge) def
      /couleur2 (vert) def
   } ifelse
   mybool bprojscene
      couleur1 cvx exec
      newpath
         0 0 smoveto
         1 0 slineto
      Stroke
      0 0 1 0 oldarrow
      couleur2 cvx exec
      newpath
         0 0 smoveto
         0 1 slineto
      Stroke
      0 0 0 1 oldarrow
   eprojscene
end
} def

%% syntaxe : plantype str1 str2 str3 planshowbase3d -> - 
%% syntaxe : plantype str2 str3 planshowbase3d -> - 
%% syntaxe : plantype str3 planshowbase3d -> - 
%% syntaxe : plantype planshowbase3d -> - 
%% syntaxe : plantype str1 str2 str3 array planshowbase3d -> - 
%% syntaxe : plantype str2 str3 array planshowbase3d -> - 
%% syntaxe : plantype str3 array planshowbase3d -> - 
%% syntaxe : plantype array planshowbase3d -> - 
/planshowbase3d {
7 dict begin
   dup isbool {
      /mybool exch def
   } {
      /mybool true def
   } ifelse
   dup dup isarray exch isplan not and {
      /table exch def
   } {
      /table {} def
   } ifelse
   dup isstring {
      /couleur3 exch def
      dup isstring {
         /couleur2 exch def
         dup isstring {
            /couleur1 exch def
         } {
            /couleur1 (rouge) def
         } ifelse
      } {
         /couleur2 (vert) def
         /couleur1 (rouge) def
      } ifelse
   } {
      /couleur1 (rouge) def
      /couleur2 (vert) def
      /couleur3 (bleu) def
   } ifelse
   /plan exch def
   plan couleur1 couleur2 mybool planshowbase
   plan plangetorigine /I defpoint3d
   plan plangetbase
   dup 0 getp3d /u defpoint3d
   1 getp3d /v defpoint3d
   u v vectprod3d table newvecteur
   {I addv3d} solidtransform
   dup couleur3 solidputcolors
   solidgridOff
   drawsolid**
end
} def

%% syntaxe : plantype x y z plantranslate --> -
/plantranslate {
4 dict begin
   /M defpoint3d
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans plantranslate) ==
      quit
   } if
   plan plan plangetorigine M addv3d planputorigine
end
} def

% syntaxe : alpha_x alpha_y alpha_z rotateOpplan --> -
/rotateOplan {
4 dict begin
   /Rxyz defpoint3d
   /plan exch def
   plan isplan not {
      (Erreur : mauvais type d argument dans rotateOplan) ==
      quit
   } if
   plan plan plangetorigine Rxyz rotateOpoint3d planputorigine

   plan plangetbase 0 getp3d /U defpoint3d
   plan plangetbase 1 getp3d /V defpoint3d
   plan [
      U Rxyz rotateOpoint3d
      V Rxyz rotateOpoint3d
   ] planputbase
end
} def

%% syntaxe : plantype phi rotateplan --> -
/rotateplan {
5 dict begin
   /phi exch def
   /leplan exch def
   leplan plangetbase 0 getp3d /U defpoint3d
   leplan plangetbase 1 getp3d /V defpoint3d
   U phi cos mulv3d
   V phi sin mulv3d addv3d /U0 defpoint3d
   U phi sin neg mulv3d
   V phi cos mulv3d addv3d /V0 defpoint3d
   leplan [U0 V0] planputbase
end
} def

%% syntaxe : solid i solidface2plan --> plantype
%% syntaxe : solid i I solidface2plan --> plantype
/solidface2plan {
5 dict begin
   2 copy pop issolid {
      /i exch def
      /solid exch def
      solid i solidcentreface /I defpoint3d
   } {
      /I defpoint3d
      /i exch def
      /solid exch def
   } ifelse
   /result newplanaffine def
   solid i solidcentreface /G defpoint3d
   solid i solidnormaleface /K defpoint3d
   solid 0 i solidgetsommetface
   solid 1 i solidgetsommetface
   milieu3d /A defpoint3d
   G A vecteur3d normalize3d /U defpoint3d
   K U vectprod3d /V defpoint3d
   result [U V] planputbase
   result I planputorigine
   result
end
} def

%%%%% ### fin insertion ###
%% syntaxe : x y plantype pointplan --> X Y Z
/pointplan {
5 dict begin
   /leplan exch def
   /y exch def
   /x exch def
   leplan plangetbase 0 getp3d /U defpoint3d
   leplan plangetbase 1 getp3d /V defpoint3d
   U x mulv3d V y mulv3d addv3d
end
} def

%%%%% ### fin insertion ###


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%     operations sur des solides particuliers        %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/piedist {
4 dict begin
   /mypie exch def
   mypie 0 solidgetface length /n exch def
   mypie n 2 idiv solidgetsommet /A defpoint3d
   mypie n 2 idiv 1 add solidgetsommet /B defpoint3d
   A B milieu3d GetCamPos distance3d
end
} def

/sortpieset {
5 dict begin
   dup issolid {
      ]
   } if
   /table exch def
   [
      0 1 table length 1 sub {
         /i exch def
         table i get piedist
      } for
   ]
   doublequicksort pop reverse
   /result exch def
   [
      0 1 result length 1 sub {
         /i exch def
         table result i get get 
      } for
   ]
end
} def

/drawpieset {
1 dict begin
   /startest true def
   sortpieset dup {drawsolid**} apply {0 dessinefacevisible} apply
end
} def

%%%%% ### solidchanfreine ###
%% syntaxe : solid coeff solidchanfreine --> solid
/solidchanfreine {
10 dict begin
   /coeff exch def
   /solid exch def
   /result newsolid def
   solid issolid not {
      (Erreur : mauvais type d argument dans solidchanfreine) ==
      quit
   } if
   /n solid solidnombresommets def
   /nf solid solidnombrefaces def

   %% ajout des faces reduites
   0 1 nf 1 sub {
      /i exch def
      /Fsommets solid i solidgetsommetsface def
      /Findex solid i solidgetface def
      /ns Fsommets length 3 idiv def
      /couleurfaceorigine solid i solidgetfcolor def
      Fsommets isobarycentre3d /G defpoint3d
      %% on ajoute les nouveaux sommets
      /Sindex [] def
      0 1 ns 1 sub {
         /j exch def
         /Sindex [ Sindex aload pop
            Fsommets j getp3d /M defpoint3d
            result M G coeff hompoint3d solidaddsommet
         ] store
      } for
      %% Sindex contient les indices des nouveaux sommets
      result Sindex couleurfaceorigine solidaddface
   } for

   %% ajout des faces rectangulaires entre faces d'origines adjacentes
   %% pour chaque face de depart
   0 1 nf 2 sub {
      /i exch def
      /F solid i solidgetface def
      /couleurfaceorigine solid i solidgetfcolor def
      /Fres result i solidgetface def
      %% pour chaque arete de la face
      0 1 F length 1 sub {
         /j exch def
         /trouve false def
         /indice1 F j get def
         /indice2 F j 1 add F length mod get def
         /a1 j def
         /a2 j 1  add F length mod def
         %% on regarde toutes les autres faces
         i 1 add 1 nf 1 sub {
            /k exch def
            /Ftest solid k solidgetface def
            indice1 Ftest in {pop true} {false} ifelse
            indice2 Ftest in {pop true} {false} ifelse
            and {
               /indiceFadj k def
               indice1 Ftest in pop /k1 exch def
               indice2 Ftest in pop /k2 exch def
               /trouve true def
            exit
            } if
         } for
         trouve {
            /Fadj solid indiceFadj solidgetface def
            result [
               Fres a1 get
               result indiceFadj solidgetface k1 get
               result indiceFadj solidgetface k2 get
               Fres a2 get
            ] couleurfaceorigine solidaddface
         } if
      } for
   } for

   %% pour chaque face
   0 1 nf 2 sub {
      /i exch def
      /F solid i solidgetface def
      /couleurfaceorigine solid i solidgetfcolor def
      %% et pour chaque sommet de cette face
      0 1 F length 1 sub {
         /j exch def
         /k F j get def
         solid k solidfacesadjsommet /adj exch def
         %% adj est le tableau des indices des faces adjacentes
         %% au sommet d'indice k
         %% rque : toutes les faces d'indice strict inferieur a i
         %% sont deja traitees
         %% Pour chaque face adjacente, on repere l'indice du sommet concerne dans
         %% la face
         adj min i lt not {
            /indadj [] def
            0 1 adj length 1 sub {
               /m exch def
               k solid adj m get solidgetface in {
                  /ok exch def
                  /indadj [indadj aload pop ok] store
               } if
            } for
         
            /aajouter [
               0 1 adj length 1 sub {
                  /m exch def
                  result adj m get solidgetface indadj m get get
               } for
            ] def

            %% la table des sommets
            [0 1 aajouter length 1 sub {
               /m exch def
               result aajouter m get solidgetsommet
            } for]
            solid k solidgetsommet %% le point indiquant la direction de la normale
            ordonnepoints3d
            /indicestries exch def

            result [
               0 1 indicestries length 1 sub {
                  /m exch def
                  aajouter indicestries m get get
               } for
            ] couleurfaceorigine solidaddface
         } if
      } for
   } for

   result
end
} def

%%%%% ### solidplansection ###
%% syntaxe : M eqplan --> real
%% image de M par la fonction definie par l equation eqplan
/pointeqplan {
8 dict begin
   /@qplan exch def
   /@z exch def
   /@y exch def
   /@x exch def
   /@a @qplan 0 get def
   /@b @qplan 1 get def
   /@c @qplan 2 get def
   /@d @qplan 3 get def
   @a @x mul @b @y mul add @c @z mul add @d add 
end
} def

%% syntaxe : A B eqplan segment_inter_plan --> array true ou false
%% array contient 1 point M si [AB] inter plan = {M}
%% array contient les 2 points A et B si [AB] inter plan = [AB]
/segment_inter_plan {
4 dict begin
   dup isplan {plan2eq} if
   /plan exch def
   plan aload pop
   /d exch def
   /c exch def
   /b exch def
   /a exch def
   /B defpoint3d
   /A defpoint3d
   A 
   /zA exch def
   /yA exch def
   /xA exch def
   B 
   /zB exch def
   /yB exch def
   /xB exch def
   /imA a xA mul b yA mul add c zA mul add d add def
   /imB a xB mul b yB mul add c zB mul add d add def
   imA imB mul dup 0 gt {
      %% pas d intersection
      pop
      false
   } {
      0 eq {
         %% intersection en A ou en B
         [ 
            imA 0 eq {A} if 
            imB 0 eq {B} if 
         ] true
      } {
         %% intersection entre A et B
         /k 
            imA neg
            xB xA sub a mul
            yB yA sub b mul add
            zB zA sub c mul add
            dup 0 eq {
               (Error dans segment_inter_plan) ==
               quit
            } if
            div
         def
         [
            A B vecteur3d
            k mulv3d
            A addv3d
         ] true
      } ifelse
   } ifelse
end
} def

%% syntaxe : solid i solidface2eqplan --> [a b c d]
%% equation cartesienne de la face d'indice i du solide solid
/solidface2eqplan {
8 dict begin
   /i exch def
   /solid exch def
   solid i solidnormaleface
   /c exch def
   /b exch def
   /a exch def
   solid 0 i solidgetsommetface
   /z exch def
   /y exch def
   /x exch def
   [a b c a x mul b y mul add c z mul add neg]
end
} def

%% syntaxe : array1 arrayrmdouble --> array2
%% remplace 2 elts identiques consecutifs par 1 elt
/arrayrmdouble {
5 dict begin
   /table exch def
   /result [table 0 get] def
   /j 0 def
   1 1 table length 1 sub {
      /i exch def
      table i get
      result j get
      eq not {
         /result [result aload pop table i get] store
         /j j 1 add store
      } if
   } for
   result
end
} def

%% syntaxe : solid eqplan/plantype solidplansection --> solid2
/solidplansection {
10 dict begin
   dup isbool {
      /tr@nsmit exch def
   } {
      /tr@nsmit false def
   } ifelse
   dup isplan {
      plan2eqplan
      /eqplan exch def
   } {
      /eqplan exch def
   } ifelse
   dupsolid /result exch def
   /solid exch def
   /aenlever [] def
   /indnouveauxsommets [] def
   /nouvellesaretes [] def

   %% pour chaque face d'indice i
   0 1 solid solidnombrefaces 1 sub {
      /i exch def
      /lacouleur solid i solidgetfcolor def
      /F solid i solidgetface def %% table des indices des sommets
      /n F length def %% nb d'aretes
      /k1 -1 def
      /k2 -1 def
      /k3 -1 def
      /k4 -1 def
      /k3a -3 def
      /k4a -3 def
      %% pour chaque arete [AB]
      0 1 n 1 sub {
         /j exch def
         %% arete testee : [j, j+1 mod n] (indices relatifs a la face i)
         solid j i solidgetsommetface /A defpoint3d
         solid j 1 add n mod i solidgetsommetface /B defpoint3d
         %% y a-t-il intersection
         A B eqplan segment_inter_plan {
            %% il y a intersection
            dup length 6 eq {
               %% l'intersection, c'est [AB]
               /k1 -1 def
               /k2 -1 def
               /k3 -1 def
               /k4 -1 def
               /k3a -1 def
               /k4a -1 def
               dup 0 getp3d /A defpoint3d
               1 getp3d /B defpoint3d
               result A solidaddsommet /a1 exch def
               result B solidaddsommet /a2 exch def
               /indnouveauxsommets [
                  indnouveauxsommets aload pop a1 a2
               ] store
               /nouvellesaretes [
                  [a1 a2]
                  nouvellesaretes aload pop
               ] store
               exit %% c est deja scinde
            } if
            %% il y a intersection <> [AB]
            k1 0 lt {
            %% 1ere intersection de la face
               /k1 j def %% sommet precedent intersection 1
               result exch aload pop solidaddsommet
               /k1a exch def %% sommet intersection 1
            } {
               k2 0 lt {
               %% 2eme intersection de la face
                  /k2 j def %% sommet precedent intersection 2
                  result exch aload pop solidaddsommet
                  /k2a exch def %% sommet intersection 2
               } {
                  k3 0 lt {
                  %% 3eme intersection de la face
                     /k3 j def %% sommet precedent intersection 3
                     result exch aload pop solidaddsommet
                     /k3a exch def %% sommet intersection 3
                  } {
                  %% 4eme intersection de la face
                     /k4 j def %% sommet precedent intersection 4
                     result exch aload pop solidaddsommet
                     /k4a exch def %% sommet intersection 4
                  } ifelse
               } ifelse
            } ifelse
         } if
      } for
      
      %% y a-t-il eu une coupe ?
      %% si oui, il faut scinder la face d'indice i en cours 
      k1 0 ge {
%% (coupe) ==
%% (n) == n ==
%% k1 == k2 == k3 == k4 ==
%% (a) ==
%% k1a == k2a == k3a == k4a ==
         k1a k2a eq k3 0 lt and {
            %% 1 pt d'intersection
         } {
            %% il y a coupe, on cherche a eliminer les
            %% doublons dans {k1a, k2a, k3a, k4a}
            k1a k2a eq k3 0 ge and {
               %% 2 pts d'intersection
               /k2a k3a def
               /k2 k3 def
            } if
            k1a k3a eq k4 0 ge and {
               %% 2 pts d'intersection
               /k2a k4a def
               /k2 k4 def
            } if
            /nouvellesaretes [
               [k1a k2a]
               nouvellesaretes aload pop
            ] store
            [
               k1a F k1 1 add n mod get ne {
                  k1a
               } if
               k1 1 add n mod 1 k2 {F exch get} for
               k2a F k2 get ne {
                  k2a
               } if
            ]
            result exch lacouleur solidaddface
            /indnouveauxsommets [indnouveauxsommets aload pop k1a k2a] store
            [
               k2a F k2 1 add n mod get ne {
                  k2a
               } if
               k2 1 add n ne {
                  k2 1 add n mod 1 n 1 sub {F exch get} for
               } if
               0 1 k1 {F exch get} for
               k1a F k1 get ne {
                  k1a
               } if
            ]
            result exch lacouleur solidaddface
            /aenlever [aenlever aload pop i] store
         } ifelse
      } if
   } for
   result aenlever solidrmfaces

   nouvellesaretes separe_composantes
   /composantes exch def

   %% pour chacune des composantes
   0 1 composantes length 1 sub {
      %% on oriente et on ajoute la face
      /icomp exch def
      %indnouveauxsommets bubblesort arrayrmdouble
      /indnouveauxsommets composantes icomp get def
      %% maintenant, on ajoute la face de plan de coupe
      /nouveauxsommets [
         0 1 indnouveauxsommets length 1 sub {
            /i exch def
            result indnouveauxsommets i get solidgetsommet
         } for
      ] def
   
      0 0 0 eqplan pointeqplan 0 eq {
         /ptref {0 1 1} def
      } {
         /ptref {0 0 0} def
      } ifelse
   
      %% restera a traiter le cas limite ou la nouvelle face existe deja
      %% tester si max(indicestries) < nb sommets avant section
      nouveauxsommets ptref ordonnepoints3d
      /indicestries exch def
      /nvelleface [
         0 1 indicestries length 1 sub {
            /m exch def
            indnouveauxsommets indicestries m get get
         } for
      ] def
      /F result solidgetfaces def
      /FC result solidgetfcolors def
      /IO result solidgetinouttable def
      /n1 IO 1 get def
      IO 1 n1 1 add put
      result IO solidputinouttable
      result [nvelleface F aload pop] solidputfaces
      result [lacouleur FC aload pop] solidputfcolors
   } for
   result
   tr@nsmit {
      composantes length 
   } if
end    
} def

%% syntaxe : elt array compteoccurences
%% ou array est un tableau du type [ [a1 a2] [b1 b2] [c1 c2] ... ]
/compteoccurences {
5 dict begin
   /table exch def
   /elt exch def
   /n 0 def
   0 1 table length 1 sub {
      /i exch def
      elt table i get in {
         pop
         /n n 1 add store
      } if
   } for
   n
end
} def

/separe_composantes {
10 dict begin
   /result [] def %% les composantes deja faites
   /table exch def %% ce qui reste a faire

%   (recu) == table {==} apply
   {
      /ext1 table 0 get 1 get def
      /ext0 table 0 get 0 get def
      /composante [] def
   
      { %% maintenant on suit les extremites et on epluche une composante
         /change false def
         /aenlever [] def
         0 1 table length 1 sub {
            /i exch def
            ext1 table i get In
            ext0 table i get In or {
               /aenlever [aenlever aload pop i] store
               /change true store
               %% l'arete i contient l'extremite ext0 ou ext1
               ext0 table i get in {
                  %% index = 0 ou 1
                  neg 1 add table i get exch get
                  /ext0 exch store
                  ext0 composante In not {
                     /composante [composante aload pop ext0] store
                  } if
                  %% on verifie que ext0 est legitime
                  ext0 table compteoccurences 2 gt {
                     /ext0 -1 store
                  } if
               } if
               ext1 table i get in {
                  %% index = 0 ou 1
                  neg 1 add table i get exch get
                  /ext1 exch store
                  ext1 composante In not {
                     /composante [composante aload pop ext1] store
                  } if
                  %% on verifie que ext1 est legitime
                  ext1 table compteoccurences 2 gt {
                     /ext1 -1 store
                  } if
               } if
            } if
         } for
         %% il faut reconstruire table
         /table [
            0 1 table length 1 sub {
               /i exch def
               i aenlever in {
                  pop
               } {
                  table i get
               } ifelse
            } for
         ] store
         change not {exit} if
      } loop
      %% on vient de finir une composante
      /result [result aload pop composante] store
      %% (nouvelle comp) == composante {==} apply
      table length 0 eq {exit} if
   } loop
   result
%   (renvoie) == result {==} apply
end
} def

/solideqplansepare {solidplansepare} def
    
%% syntaxe : solid eqplan/plantype solidplansepare --> solid1 solid2
/solidplansepare {
10 dict begin
   dup isplan {
      plan2eq
      /eqplan exch def
   } {
      /eqplan exch def
   } ifelse
   eqplan true solidplansection
   /nbcomposantes exch def
   /solid exch def
   /n solid solidnombrefaces def

   /F [] def
   /FC [] def
   %% on retire les faces de coupe
   0 1 nbcomposantes 1 sub {
      /i exch def
      /F [F aload pop solid i solidgetface] store
      /FC [FC aload pop solid i solidgetfcolor] store
   } for
   solid [0 1 nbcomposantes 1 sub {} for] solidrmfaces
   /n n nbcomposantes sub store

   %% on separe les autres faces en 2 parties
   /lesneg [] def %% indices des faces "positives"
   /lespos [] def %% indices des faces negatives"
   0 1 n 1 sub {
      /i exch def
      solid i solidcentreface /G defpoint3d
      G eqplan pointeqplan dup 0 gt {
         pop
         /lespos [lespos aload pop i] store
      } {
         0 lt {
            /lesneg [lesneg aload pop i] store
         } {
%           /lesneg [lesneg aload pop i] store
%           /lespos [lespos aload pop i] store
         } ifelse
      } ifelse
   } for
   solid
   dupsolid dup lesneg solidrmfaces
   /result1 exch def
   dupsolid dup lespos solidrmfaces
   /result2 exch def
   pop

   0 1 nbcomposantes 1 sub {
      /i exch def
      /facecoupe F i get def
      /couleurfacecoupe FC i get def
      /lesfaces1 result1 solidgetfaces def
      /lescouleurs1 result1 solidgetfcolors def
      /IO1 result1 solidgetinouttable def
      /lesfaces2 result2 solidgetfaces def
      /lescouleurs2 result2 solidgetfcolors def
      /IO2 result2 solidgetinouttable def
      %% on rajoute maintenant la face du plan de coupe
%      result1 facecoupe couleurfacecoupe solidaddface
      result1 [facecoupe lesfaces1 aload pop] solidputfaces
      result1 [couleurfacecoupe lescouleurs1 aload pop] solidputfcolors
      result1 IO1 dup dup 1 get 1 add 1 exch put solidputinouttable
      %% et on verifie l'orientation
%      result1 dup solidnombrefaces 1 sub solidnormaleface 
%      result1 dup solidnombrefaces 1 sub solidcentreface addv3d
      result1 0 solidnormaleface 
      result1 0 solidcentreface addv3d
      eqplan pointeqplan 0 gt {
         %% l'orientation est mauvaise
         result1 0 solidrmface 
         result2 [facecoupe lesfaces2 aload pop] solidputfaces
         result2 [couleurfacecoupe lescouleurs2 aload pop] solidputfcolors
         result2 IO2 dup dup 1 get 1 add 1 exch put solidputinouttable
         result1 [facecoupe reverse lesfaces1 aload pop] solidputfaces
         result1 [couleurfacecoupe lescouleurs1 aload pop] solidputfcolors
         result1 dup solidgetinouttable dup dup 1 get 1 add 1 exch put solidputinouttable
      } {
         %% l'orientation est ok
         result2 IO2 dup dup 1 get 1 add 1 exch put solidputinouttable
         result2 [facecoupe reverse lesfaces2 aload pop] solidputfaces
         result2 [couleurfacecoupe lescouleurs2 aload pop] solidputfcolors
      } ifelse
   } for
   
   %% maintenant on enleve les sommets isoles
   /sommetspos [] def
   /sommetsneg [] def
   %% pour chaque face du cote negatif
   0 1 lesneg length 1 sub {
      lesneg exch get /i exch def
      /F solid i solidgetface def
      %% pour chaque sommet de cette face
      0 1 F length 1 sub {
         /j exch def
         /sommet F j get def
         %% si le sommet n'est pas encore note
         sommet sommetsneg in not {
            %% et s'il est isole, on peut l'enlever
            result1 sommet solidsommetsadjsommet length 0 eq {
               /sommetsneg [sommetsneg aload pop sommet] store
            } if
         } {
            pop
         } ifelse
      } for
   } for
   sommetsneg bubblesort reverse {result1 exch solidrmsommet} apply

   %% pour chaque face du cote positif
   0 1 lespos length 1 sub {
      lespos exch get /i exch def
      /F solid i solidgetface def
      %% pour chaque sommet de cette face
      0 1 F length 1 sub {
         /j exch def
         /sommet F j get def
         %% si le sommet n'est pas encore note
         sommet sommetspos in not {
            %% et s'il est isole, on peut l'enlever
            result2 sommet solidsommetsadjsommet length 0 eq {
               /sommetspos [sommetspos aload pop sommet] store
            } if
         } {
            pop
         } ifelse
      } for
   } for
   sommetspos bubblesort reverse {result2 exch solidrmsommet} apply

   result1 result2
end
} def

%%%%% ### solidaffine ###
%% syntaxe : solid coeff i solidaffine -> -
%% syntaxe : solid coeff array solidaffine -> -
%% syntaxe : solid coeff solidaffine -> -
%% syntaxe : solid coeff str solidaffine -> -
%% syntaxe : solid coeff bool solidaffine -> -
/solidaffine {
10 dict begin
   dup isbool {
      /rmfacecentrale exch def
   } {
      /rmfacecentrale true def
   } ifelse
   dup isstring {
      /couleurface exch def
   } if
   2 copy pop issolid {
      %% 2 arguments --> on affine tout
      2 copy pop solidnombrefaces /n exch def
      /table [n 1 sub -1 0 {} for] def 
   } {
      %% 1 tableau --> il donne les faces a enlever
      dup isarray {
         /table exch bubblesort reverse def
      } {
      %% 1 seule face a enlever
         [ exch ] /table exch def
      } ifelse
   } ifelse
   /coeff exch def
   /solid exch def
   0 1 table length 1 sub {
      /i exch def
      solid coeff table i get 
      currentdict /couleurface known {
         couleurface 
      } if
      rmfacecentrale s@lidaffineface
   } for
end
} def

%% syntaxe : solid coeff i s@lidaffineface
 /s@lidaffineface {
10 dict begin
   /rmfacecentrale exch def
   dup isstring {
      /couleurface exch def
   } if
   /indice_a_chamfreiner exch def
   /i indice_a_chamfreiner def
   /coeff exch def
   /solid exch def
   solid issolid not {
      (Erreur : mauvais type d argument dans affine) ==
      quit
   } if
   /n solid solidnombresommets def
   /F solid i solidgetsommetsface def
   /Findex solid i solidgetface def
   /ni F length 3 idiv def
   /couleurfaceorigine solid i solidgetfcolor def
   F isobarycentre3d /G defpoint3d
   %% on ajoute les nouveaux sommets
   /Sindex [] def
   0 1 ni 1 sub {
      /j exch def
      /Sindex [ Sindex aload pop
         solid G F j getp3d vecteur3d coeff mulv3d G addv3d solidaddsommet
      ] store
   } for
   %% Sindex contient les indices des nouveaux sommets
   %% on prepare les faces a ajouter
   /facestoadd [] def
   /facestoadd [facestoadd aload pop
   0 1 ni 1 sub {
      /j exch def
      [Findex j get
      Findex j 1 add ni mod get
      Sindex j 1 add ni mod get
      Sindex j get]
   } for
   ] store
   0 1 ni 1 sub {
      /i exch def
      solid facestoadd i get solidaddface
   } for
   %% on enleve la face d origine
   solid indice_a_chamfreiner solidrmface
   %% on ajuste les couleurs des nouvelles faces
   /N solid solidnombrefaces def
   0 1 ni 1 sub {
      /i exch def
      solid N 1 sub i sub couleurfaceorigine solidputfcolor
   } for
   %% puis on ajoute eventuellement la face centrale
   rmfacecentrale not {
      solid
      [0 1 ni 1 sub {
         /j exch def
         Sindex j get
      } for]
      solidaddface
      %% en ajustant la couleur de cette derniere
      solid N
      currentdict /couleurface known {
            couleurface 
      } {
         couleurfaceorigine
      } ifelse
      solidputfcolor
   } if
end
} def

%%%%% ### solidtronque ###
%% syntaxe : solid indicesommet k solidtronque --> solid
%% syntaxe : solid array k solidtronque --> solid
%% syntaxe : solid k solidtronque --> solid
%% k entier > 0, array = tableau des indices des sommets
/solidtronque {
10 dict begin
   /coeff exch def
   dup issolid {
      dup solidnombresommets /N exch def
      /table [0 1 N 1 sub {} for] def
   } {
      dup isarray {
         /table exch def
      } {
         [ exch ] /table exch def
      } ifelse
   } ifelse
   /solid exch def
   solid dupsolid /result exch def pop
   /n solid solidnombrefaces def
   0 1 table length 1 sub {
      table exch get /no exch def
      result no solidgetsommet /sommetvise defpoint3d
      %% on recup les sommets adjacents au sommet vise
      /sommetsadj solid no solidsommetsadjsommet def
      %% on calcule les nouveaux sommets
      /nouveauxsommets [
         0 1 sommetsadj length 1 sub {
            /i exch def
            solid sommetsadj i get solidgetsommet
         } for
      ] {sommetvise exchp3d coeff ABpoint3d} papply3d def 
      %% on pose G = barycentre de ces points
      nouveauxsommets isobarycentre3d /G defpoint3d
      %% il faut ordonner ces sommets
      nouveauxsommets 0 getp3d /ptref defpoint3d
      G result no solidgetsommet vecteur3d /vecteurnormal defpoint3d
      %% on construit le tableau des angles ordonnes par rapport
      %% a la normale
      nouveauxsommets duparray exch pop
      {1 dict begin
         /M defpoint3d
         G ptref vecteur3d
         G M vecteur3d
         vecteurnormal angle3doriente
      end} papply3d
      doublebubblesort pop
      %% nos sommets sont tries
      /indicesommetstries exch def
      %% on rajoute les sommets au solide, et on note les nouveaux indices
      /nouveauxindices [
         0 1 nouveauxsommets length 3 idiv 1 sub {
            /k exch def
            result nouveauxsommets k getp3d solidaddsommet
         } for
      ] def
      %% on ajoute la face concernee
      result [
         0 1 indicesommetstries length 1 sub {
            /k exch def
         nouveauxindices indicesommetstries k get get
         } for 
      ] solidaddface
      result no solidfacesadjsommet /lesfaces exch def
      %% on examine la face d indice i, et on elimine le
      %% sommet vise
      0 1 lesfaces length 1 sub {
         /i exch def
         /j lesfaces i get def
         /F result j solidgetface def 
         result [
            0 1 F length 1 sub {
               /k exch def 
               F k get dup no eq {pop} if
            } for
         ] j exch solidputface 
      } for
   } for
   table bubblesort reverse {result exch solidrmsommet} apply
   result
end
} def

%%%%% ### dualpolyedre ###
%% syntaxe : solid dualpolyedreregulier --> solid
%% syntaxe : solid r dualpolyedreregulier --> solid
%% si le nombre r est present, projette les nouveaux sommets sur la sphere de centre O , de rayon r
/dualpolyedreregulier {
20 dict begin
   dup isnum {
      /r exch def
      /projection true def
   } {
      /projection false def
   } ifelse
   /solid exch def
   solid dupsolid /result exch def pop
   /n solid solidnombrefaces def
   /N solid solidnombresommets def
   /facesaenlever [] def
   %% pour chacun des sommets
   0 1 N 1 sub {
      %% sommet d indice i
      /i exch def
      %% indicesfacesadj = liste des indices des faces ou on trouve le sommet i
      /indicesfacesadj solid i solidfacesadjsommet def
      %% on recupere les centres des faces concernees
      /nouveauxsommets [
         0 1 indicesfacesadj length 1 sub {
            /k exch def 
            solid indicesfacesadj k get solidgetsommetsface isobarycentre3d
         } for
      ] def
      %% et on pose G = barycentre de ces points
      nouveauxsommets isobarycentre3d /G defpoint3d
      %% il faut ordonner ces sommets
      nouveauxsommets 0 getp3d /ptref defpoint3d
      G solid i solidgetsommet vecteur3d /vecteurnormal defpoint3d
      nouveauxsommets duparray exch pop
      {1 dict begin
         /M defpoint3d
         G ptref vecteur3d
         G M vecteur3d
         vecteurnormal angle3doriente
      end} papply3d
      doublebubblesort pop
      %% nos sommets sont tries
      /indicesommetstries exch def
      projection {
         %% on projette les sommets sur la sphere
         /nouveauxsommets [ nouveauxsommets {normalize3d r mulv3d} papply3d aload pop ] store
      } if
      %% puis on les rajoute au solide
      /nouveauxindices [
         0 1 nouveauxsommets length 3 idiv 1 sub {
            /k exch def
            result nouveauxsommets k getp3d solidaddsommet
         } for
      ] def
      %% ainsi que la face concernee
      result [
         0 1 indicesommetstries length 1 sub {
            /k exch def
         nouveauxindices indicesommetstries k get get
         } for 
      ] solidaddface
      /facesaenlever [ facesaenlever aload pop indicesfacesadj aload pop ] store
   } for
   result [0 1 n 1 sub {} for] solidrmfaces
   [N 1 sub -1 0 {} for] {result exch solidrmsommet} apply
   result
end
} def

%%%%% ### newgeode ###
%% syntaxe : solid r newgeode --> solid
%% syntaxe : N r newgeode --> solid
%% N in {3,4,5} -> polyhedre de depart, r = niveau de recursion
/newgeode {
2 dict begin
   /r exch def
   dup issolid not {
      /N exch def
      N 3 eq {
         1 newtetraedre
      } {
         N 4 eq {
            1 newoctaedre
         } {
            1 newicosaedre
         } ifelse
      } ifelse
   } if

   r {
      15 dict begin   
         /solid exch def
         solid dupsolid /result exch def pop
         /n solid solidnombrefaces def
         n 1 sub -1 0 {
            /i exch def
            %% la face d indice i
            solid i solidgetface /F exch def
            /i0 F 0 get def
            /i1 F 1 get def
            /i2 F 2 get def
            solid i0 solidgetsommet /A0 defpoint3d
            solid i1 solidgetsommet /A1 defpoint3d
            solid i2 solidgetsommet /A2 defpoint3d
            A0 A1 milieu3d normalize3d /A01 defpoint3d
            A1 A2 milieu3d normalize3d /A12 defpoint3d
            A2 A0 milieu3d normalize3d /A20 defpoint3d
            result A01 solidaddsommet /i01 exch def
            result A12 solidaddsommet /i12 exch def
            result A20 solidaddsommet /i20 exch def
            result i solidrmface
            result [i0 i01 i20] solidaddface
            result [i01 i1 i12] solidaddface
            result [i01 i12 i20] solidaddface
            result [i20 i12 i2] solidaddface
         } for
         result
      end
   } repeat
end
} def

%% syntaxe : N r newdualgeode --> solid
/newdualgeode {
   newgeode 1
   dualpolyedreregulier
} def

%%%%% ### fin insertion ###


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             quelques solides precalcules           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ### newface ### 
%% syntaxe : array newmonoface -> solid
%% ou array = tableau de points 2d
/newmonoface {
4 dict begin
   /table exch def
   /n table length 2 idiv def
   /S table {0} papply def

   /F [
       [0 1 n 1 sub {} for]
   ] def
   S F generesolid
end
} def

%% syntaxe : array newbiface -> solid
%% ou array = tableau de points 2d
/newbiface {
   newmonoface
   dup videsolid
} def

%%%%% ### newpolreg ### 
%% syntaxe : r n newpolreg --> solid
/newpolreg {
5 dict begin
   /n exch def
   /r exch def
   /S [
       0 360 n div 360 360 n div sub {
           /theta exch def
           theta cos r mul
           theta sin r mul
           0
       } for
   ] def
   /F [
       [0 1 n 1 sub {} for]
   ] def

   S F generesolid
   dup videsolid
end
} def

%%%%% ### newgrille ### 
%% syntaxe : xmin xmax ymin ymax [dx dy] newgrille -> solid
%% syntaxe : xmin xmax ymin ymax [nx ny] newgrille -> solid
%% syntaxe : xmin xmax ymin ymax {mode} newgrille -> solid
%% syntaxe : xmin xmax ymin ymax newgrille -> solid
/newgrille {
10 dict begin
   [[/nx /ny] [1 1] [1. 1.] [1. 1.] [1. 1.] [.5 .5]] gestionsolidmode
   %% ny nb d etages en y
   %% nx nb d etages en x
   /biface false def
   [nx ny] {0} newsurfaceparametree
end
} def

%% %% syntaxe : xmin xmax ymin ymax [dx dy] {f} newsurface -> solid
%% %% f : R^2 -> R
/newsurface {
   true newsurfaceparametree
} def

/biface true def

/newsurfaceparametree {
10 dict begin
   dup isbool {
      pop /surfz true def
   } {
      /surfz false def
   } ifelse
   /f_surface exch def
   [[/nx /ny] [2 2] [4 4] [1. 1.] [1. 1.] [.25 .25]] gestionsolidmode
   %% ny nb d etages en y
   %% nx nb d etages en x
   /ymax exch def
   /ymin exch def
   /xmax exch def
   /xmin exch def

   nx isinteger not {
       %% alors nx est un dx
       /nx xmax xmin sub nx div cvi store
   } if
   ny isinteger not {
       %% alors ny est un dy
       /ny ymax ymin sub ny div cvi store
   } if
   /dy ymax ymin sub ny div def %% le pas sur y
   /dx xmax xmin sub nx div def %% le pas sur x

   /S [
       0 1 nx {
           /i exch def
           0 1 ny {
               /j exch def
               /u xmin i dx mul add def
               /v ymin j dy mul add def
               u v
               surfz {2 copy} if
               f_surface
               pstrickactionR3
           } for
       } for
   ] def

   /F [
       0 1 nx 1 sub {
          /i exch def
          0 1 ny 1 sub {
             /j exch def
             [
                j 1 add        i ny 1 add mul add
                j              i ny 1 add mul add
                j ny 1 add add i ny 1 add mul add
                j ny 2 add add i ny 1 add mul add
             ]
          } for
       } for
%%       0 1 0 {%nx 1 sub {
%%          /i exch def
%%          0 1 0 {%ny 2 sub {
%%             /j exch def
%%             [
%%             j 1 add        %% i ny mul add
%%             j              %% i ny mul add
%%             ny 1 add j add       %% i ny mul add
%%             ny 2 add j add     %% i ny mul add
%%             ]
%%          } for
%%       } for
   ] def
   S F generesolid
   biface pl@n-en-cours not and {dup videsolid} if
end
} def

%%%%% ### newgrillecirculaire ### 
%% syntaxe : r option newgrillecirculaire -> solid
/newgrillecirculaire {
6 dict begin
   [[/K /N] [6 6] [6 8] [10 8] [16 12] [16 36]] gestionsolidmode

   %% N = nb de meridiens (diviseur de 360 = 2^4 * 3^2 * 5)
   %% K = nb d horizontales (diviseur de 160 = 2^5 * 5)

   /r exch def
   /F [
       %% 1er etage
       1 1 N {
           /i exch def
           [0 i i N mod 1 add]
       } for
       %% etages suivants
       0 1 K 2 sub {
           /j exch def
           1 1 N {
               /i exch def
               [i      j N mul add
               i N add j N mul add
               i N mod N add 1 add j N mul add
               i N mod 1 add j N mul add]
           } for
      } for
   ] def

   %% tableau des sommets
   /S [
       0 0 0
       1 1 K {
           /j exch def
           1 1 N {
             /i exch def
             /theta i 360 mul N div def
             theta cos r j mul K div mul
             theta sin r j mul K div mul
             0 %2 copy f %exch atan 90 div
          } for
       } for
   ] def

   S F generesolid
end
} def

%% syntaxe : r [dx dy] {f} newsurface* -> solid
/newsurface* {
7 dict begin
   /f_surface exch def
   [[/nx /ny] [6 6] [6 8] [10 8] [16 12] [16 36]] gestionsolidmode

   nx isinteger not {
       %% alors nx est un dx
       /nx xmax xmin sub nx div cvi store
   } if
   ny isinteger not {
       %% alors ny est un dy
       /ny ymax ymin sub ny div cvi store
   } if
   /dy ymax ymin sub ny div def %% le pas sur y
   /dx xmax xmin sub nx div def %% le pas sur x

   %% ny = nb de meridiens
   %% nx = nb d horizontales

   /r exch def
   /F [
       %% 1er etage
       1 1 ny {
           /i exch def
           [0 i i ny mod 1 add]
       } for
       %% etages suivants
       0 1 nx 2 sub {
           /j exch def
           1 1 ny {
               /i exch def
               [i      j ny mul add
               i ny add j ny mul add
               i ny mod ny add 1 add j ny mul add
               i ny mod 1 add j ny mul add]
           } for
      } for
   ] def

   %% tableau des sommets
   /S [
       0 0 0 0 f_surface
       1 1 nx {
           /j exch def
           1 1 ny {
             /i exch def
             /theta i 360 mul ny div def
             theta cos r j mul nx div mul
             theta sin r j mul nx div mul
             2 copy f_surface
          } for
       } for
   ] def

   S F generesolid
end
} def

%%%%% ### newruban ### 
%% syntaxe : array h u [n] newruban -> solid d axe (O, u), de maillage vertical n
%% syntaxe : array h u newruban -> solid d axe (O, u),
%% syntaxe : array h newruban -> solid d axe (O, k),
%% ou array tableau de points 2d
/newruban {
7 dict begin
   %% N = nb d etages
   [[/N] [1] [1] [1] [3] [4]] gestionsolidmode
   2 copy pop isarray {
      /u {0 0 1} def
   } {
      /u defpoint3d
   } ifelse
   u 0 eq {
      (Error : 3eme composante nulle dans le vecteur pour newruban) ==
      quit
   } if
   pop pop
   /h exch def
   /table exch def
   %% n = indice du dernier point
   /n table length 2 idiv 1 sub def
   %% vecteur de translation
   u
   h u norme3d div
   mulv3d /v defpoint3d

   %% tableau des sommets
   /S [
      0 1 N {
         /j exch def
         0 1 n {
             /i exch def
             table i getp
             0
             v N j sub N div mulv addv3d
         } for
      } for
   ] def

   /F [
      %% faces etage
      1 1 N {
         /j exch def
         1 1 n {
             /i exch def
             [i                   j 1 sub n 1 add mul add
              i 1 sub             j 1 sub n 1 add mul add
              n 1 add i add 1 sub j 1 sub n 1 add mul add
              n 1 add i add       j 1 sub n 1 add mul add]
         } for
     } for
   ] def

   S F generesolid
   dup videsolid
end
} def

%%%%% ### newicosaedre ### 
/newicosaedre {
3 dict begin
   /a exch def
   /S [
      0.8944271  0              0.4472137
      0.2763932  0.8506507      0.4472137
      -0.7236067 0.5257311      0.4472137
      -0.7236067 -0.5257311     0.4472137
      0.2763932  -0.8506507     0.4472137
      0          0              1
      0          0              -1
      -0.8944271 0              -0.4472137
      -0.2763932 -0.8506507     -0.4472137
      0.7236067  -0.5257311     -0.4472137
      0.7236067  0.5257311      -0.4472137
      -0.2763932 0.8506507      -0.4472137
   ] {a mulv3d} papply3d def

   /F [
      [0 1 5]   %% 1  2 6  ]
      [1 2 5]   %% 2  3 6  ]
      [2 3 5]   %% 3  4 6  ]
      [3 4 5]   %% 4  5 6  ]
      [4 0 5]   %% 5  1 6  ]
      [9 0 4]   %% 10 1 5  ]
      [0 9 10]  %% 1  10 11]
      [10 1 0]  %% 11 2 1  ]
      [1 10 11] %% 2  11 12]
      [11 2 1]  %% 12 3 2  ]
      [2 11 7]  %% 3  12 8 ]
      [2 7 3]   %% 3  8 4  ]
      [3 7 8]   %% 4  8 9  ]
      [3 8 4]   %% 4  9 5  ]
      [4 8 9]   %% 5  9 10 ]
      [6 7 11]  %% 7  8 12 ]
      [6 8 7]   %% 7  9 8  ]
      [6 9 8]   %% 7  10 9 ]
      [6 10 9]  %% 7  11 10]
      [6 11 10] %% 7  12 11]
   ] def

   S F generesolid
end
} def

%%%%% ### newdodecaedre ### 
/newdodecaedre {
3 dict begin
   /a exch def
   /S [
      0          0.607062   0.7946545
      -0.5773503 0.1875925  0.7946545
      -0.3568221 -0.4911235 0.7946545
      0.3568221  -0.4911235 0.7946545
      0.5773503  0.1875925  0.7946545
      0          0.982247   0.1875925
      -0.9341724 0.303531   0.1875925
      -0.5773503 -0.7946645 0.1875925
      0.5773503  -0.7946645 0.1875925
      0.9341724  0.303531   0.1875925
      0          -0.982247  -0.1875925
      0.9341724  -0.303531  -0.1875925
      0.5773503  0.7946545  -0.1875925
      -0.5773503 0.7946545  -0.1875925
      -0.9341724 -0.303531  -0.1875925
      -0.5773503 -0.1875925 -0.7946545
      -0.3568221 0.4911235  -0.7946545
      0.3568221  0.4911235  -0.7946545
      0.5773503  -0.1875925 -0.7946545
      0          -0.607062  -0.7946545
   ] {a mulv3d} papply3d def

   /F [
      [0 1 2 3 4]
      [4 3 8 11 9]
      [4 9 12 5 0]
      [0 5 13 6 1]
      [1 6 14 7 2]
      [2 7 10 8 3]
      [10 19 18 11 8]
      [11 18 17 12 9]
      [12 17 16 13 5]
      [13 16 15 14 6]
      [14 15 19 10 7]
      [15 16 17 18 19]
   ] def
   S F generesolid
end
} def

%%%%% ### newoctaedre ### 
/newoctaedre {
3 dict begin
   /a exch def
   %%Sommets
   /S [
      0  0  1
      1  0  0
      0  1  0
      -1 0  0
      0  -1 0
      0  0  -1
   ] {a mulv3d} papply3d def

   /F [
      [0 4 1]
      [1 2 0]
      [0 2 3]
      [3 4 0]
      [1 5 2]
      [2 5 3]
      [3 5 4]
      [4 5 1]
   ] def

   S F generesolid
end
} def

%%%%% ### newtetraedre ### 
/newtetraedre {
3 dict begin
   /r exch def
   %%Tetraedre
   /S [
      0          0          1
      -0.4714045 -0.8164965 -1 3 div
      0.942809   0          -1 3 div
      -0.4714045 0.8164965  -1 3 div
   ] {r mulv3d} papply3d def

   /F [
      [0 1 2]
      [0 2 3]
      [0 3 1]
      [1 3 2]
   ] def

   S F generesolid
end
} def

%%%%% ### newcube ### 
/newcube {
3 dict begin
   [[/n] [1] [1] [1] [3] [4]] gestionsolidmode
   /a exch 2 div def

   n 1 le {
      /F [
     [0 1 2 3]
     [0 4 5 1]
     [1 5 6 2]
     [2 6 7 3]
     [0 3 7 4]
     [4 7 6 5]
      ] def

      %% tableau des sommets
      /S [
      1  1  1 %% 0
     -1  1  1 %% 1
     -1 -1  1 %% 2
      1 -1  1 %% 3
      1  1 -1 %% 4
     -1  1 -1 %% 5
     -1 -1 -1 %% 6
      1 -1 -1 %% 7
      ] {a mulv3d} papply3d def
      S F generesolid
   } {
      /dl 2 n div def
      /N n dup mul n add 4 mul def
      /n1 n 1 sub dup mul def %% nb sommets centre d une face

      %% tableau des sommets
      /S1 [
     0 1 n 1 sub {
        /j exch def
        0 1 n {
           /i exch def
           -1 i dl mul add
           -1 j dl mul add
        1
        } for
     } for
      ] def

      /S2 S1 {-90 0 0 rotateOpoint3d} papply3d def
      /S3 S2 {-90 0 0 rotateOpoint3d} papply3d def
      /S4 S3 {-90 0 0 rotateOpoint3d} papply3d def

      /S5 [
     1 1 n 1 sub {
        /j exch def
        1 1 n 1 sub {
           /i exch def
        1
           -1 i dl mul add
           -1 j dl mul add
        } for
     } for
      ] def

      /S6 [
     1 1 n 1 sub {
        /j exch def
        1 1 n 1 sub {
           /i exch def
           -1
           -1 i dl mul add
           -1 j dl mul add
        } for
     } for
      ] def

      %% tableau des faces
      /F1 [
     0 1 n 1 sub {
        /j exch def
        0 1 n 1 sub {
           /i exch def
           [
          i n 1 add j mul add
          dup 1 add
          dup n 1 add add
          dup 1 sub
           ]
        } for
     } for
      ] def

      %% syntaxe : i sommettourgauche --> l indice du i-eme sommet du tour
      %% de la face gauche (en commencant par l indice 0). ATTENTION :
      %% utilise la variable globale n = nb d etages
      /sommettourgauche {
      1 dict begin
     /i exch def
     i 4 n mul ge {
        i
        (Error: indice trop grand dans sommettourgauche) ==
        exit
     } if
     n n 1 add i mul add
      end
      } def

      %% syntaxe : i sommetcentregauche --> l indice du i-eme sommet du centre
      %% de la face gauche (en commencant par l indice 0). ATTENTION :
      %% utilise les variables globales n = nb d etages, et N = nb sommets
      %% des 4 1eres faces
      /sommetcentregauche {
      1 dict begin
     /i exch def
     i n 1 sub dup mul ge {
        i
        (Error: indice trop grand dans sommetcentregauche) ==
        exit
     } if
     N i add
      end
      } def

      /F5 [
     %%%%% la face gauche %%%%%
     %% le coin superieur gauche
     [
        1 sommettourgauche
        0 sommettourgauche
        n 4 mul 1 sub sommettourgauche
        n1 n 1 sub sub sommetcentregauche
     ]

     %% la bande superieure (i from 1 to n-2)
     1 1 n 2 sub {
        /i exch def
        [
           i 1 add sommettourgauche
           i sommettourgauche
           n1 n sub i add sommetcentregauche
           n1 n sub i 1 add add sommetcentregauche
        ]
     } for

     %% le coin superieur droit
     [
        n sommettourgauche
        n 1 sub sommettourgauche
        n1 1 sub sommetcentregauche
        n 1 add sommettourgauche
     ]

     %% la descente gauche
     %% j from 1 to n-2
     1 1 n 2 sub {
        /j exch def
        [
           n1 n 1 sub j mul sub sommetcentregauche
           n 4 mul j sub sommettourgauche
           n 4 mul j 1 add sub sommettourgauche
           n1 n 1 sub j 1 add mul sub sommetcentregauche
        ]
     } for

     %% les bandes centrales (j from 1 to n-2 et i from 1 to n-2)
     1 1 n 2 sub {
        /j exch def
        1 1 n 2 sub {
           /i exch def
           [
          n1 i n 1 sub j 1 sub mul add sub sommetcentregauche
          n1 i 1 add n 1 sub j 1 sub mul add sub sommetcentregauche
          n1 i 1 add n 1 sub j mul add sub sommetcentregauche
          n1 i n 1 sub j mul add sub sommetcentregauche
           ]
        } for
     } for

     %% la descente droite
     1 1 n 2 sub {
        /j exch def
        [
           n j add sommettourgauche
           n1 1 sub j 1 sub n 1 sub mul sub sommetcentregauche
           n1 1 sub j n 1 sub mul sub sommetcentregauche
           n j 1 add add sommettourgauche
        ]
     } for

     %% le coin inferieur gauche
     [
        0 sommetcentregauche
        n 3 mul 1 add sommettourgauche
        n 3 mul sommettourgauche
        n 3 mul 1 sub sommettourgauche
     ]

     %% la bande inferieure (i from 1 to n-2)
     1 1 n 2 sub {
        /i exch def
        [
           i sommetcentregauche
           i 1 sub sommetcentregauche
           n 3 mul i sub sommettourgauche
           n 3 mul i sub 1 sub sommettourgauche
        ]
     } for

     %% le coin inferieur droit
     [
        n 2 mul 1 sub sommettourgauche
        n 2 sub sommetcentregauche
        n 2 mul 1 add sommettourgauche
        n 2 mul sommettourgauche
     ]
      ] def

      %% syntaxe : i sommettourdroit --> l indice du i-eme sommet du tour
      %% de la face droit (en commencant par l indice 0). ATTENTION :
      %% utilise la variable globale n = nb d etages
      /sommettourdroit {
      1 dict begin
     /i exch def
     i 4 n mul ge {
        i
        (Error: indice trop grand dans sommettourdroit) ==
        exit
     } if
     n 1 add i mul
      end
      } def

      %% syntaxe : i sommetcentredroit --> l indice du i-eme sommet du centre
      %% de la face droit (en commencant par l indice 0). ATTENTION :
      %% utilise les variables globales n = nb d etages, et N = nb sommets
      %% des 4 1eres faces
      /sommetcentredroit {
      1 dict begin
     /i exch def
     i n 1 sub dup mul ge {
        i
        (Error: indice trop grand dans sommetcentredroit) ==
        exit
     } if
     N n1 add i add
      end
      } def

      /F6 [
     %% coin superieur droit
     [
        0 sommettourdroit
        1 sommettourdroit
        n1 n 1 sub sub sommetcentredroit
        4 n mul 1 sub sommettourdroit
     ]
     %% coin superieur gauche
     [
        n 1 sub sommettourdroit
        n sommettourdroit
        n 1 add sommettourdroit
        n1 1 sub sommetcentredroit
     ]
     %% coin inferieur gauche
     [
        n 2 sub sommetcentredroit
        2 n mul 1 sub sommettourdroit
        2 n mul sommettourdroit
        2 n mul 1 add sommettourdroit
     ]
     %% coin inferieur droit
     [
        3 n mul 1 add sommettourdroit
        0 sommetcentredroit
        3 n mul 1 sub sommettourdroit
        3 n mul sommettourdroit
     ]
     %% bande superieure
     1 1 n 2 sub {
        /i exch def
        [
           i sommettourdroit
           i 1 add sommettourdroit
           n 1 sub n 2 sub mul i add sommetcentredroit
           n 1 sub n 2 sub mul i 1 sub add sommetcentredroit
        ]
     } for
     %% bande inferieure
     1 1 n 2 sub {
        /i exch def
        [
           i 1 sub sommetcentredroit
           i sommetcentredroit
           3 n mul 1 sub i sub sommettourdroit
           3 n mul i sub sommettourdroit
        ]
     } for
     %% descente gauche
     1 1 n 2 sub {
        /i exch def
        [
           n1 1 sub i 1 sub n 1 sub mul sub sommetcentredroit
           n i add sommettourdroit
           n i 1 add add sommettourdroit
           n1 1 sub i n 1 sub mul sub sommetcentredroit
        ]
     } for
     %% descente droite
     1 1 n 2 sub {
        /i exch def
        [
           4 n mul i sub sommettourdroit
           n 1 sub n 1 sub i sub mul sommetcentredroit
           n 1 sub n 2 sub i sub mul sommetcentredroit
           4 n mul i sub 1 sub sommettourdroit
        ]
     } for
     %% bandes interieures
     1 1 n 2 sub {
        /j exch def
        1 1 n 2 sub {
           /i exch def
           [
          n 1 sub j mul i 1 sub add sommetcentredroit
          n 1 sub j mul i add sommetcentredroit
          n 1 sub j 1 sub mul i add sommetcentredroit
          n 1 sub j 1 sub mul i 1 sub add sommetcentredroit
           ]
        } for
     } for

      ] def

      /F2 F1 {{n dup mul n add add} apply} apply def
      /F3 F2 {{n dup mul n add add} apply} apply def
      /F4 F3 {{n dup mul n add add} apply} apply def


      S1 S2 append S3 append S4 append S5 append S6 append {a mulv3d} papply3d
      F1 F2 append F3 append F4 append {{N mod} apply} apply F5 append F6 append
      generesolid
   } ifelse
end
} def

%%%%% ### newparallelepiped ### 
% 14 octobre 2006
/newparallelepiped {
2 dict begin
   /c exch 2 div def
   /b exch 2 div def
   /a exch 2 div def
   /F [
      [0 1 2 3]
      [0 4 5 1]
      [1 5 6 2]
      [2 6 7 3]
      [0 3 7 4]
      [4 7 6 5]
    ] def

    %% tableau des sommets
    /S [
       a     b     c %% 0
       a neg b     c %% 1
       a neg b neg c %% 2
       a     b neg c %% 3
       a     b     c neg %% 4
       a neg b     c neg %% 5
       a neg b neg c neg %% 6
       a     b neg c neg %% 7
    ] def
    S F generesolid
end
} def

%%%%% ### newcylindre ### 
%% syntaxe : z0 r0 z1 newcylindre -> solide
%% syntaxe : z0 r0 z1 {mode} newcylindre -> solide
%% syntaxe : z0 r0 z1 [n1 n2] newcylindre -> solide
%% syntaxe : a b {f} {u} h [n1 n2] newcylindre
/newcylindre {
2 dict begin
   [[/n2 /n1] [1 6] [1 8] [1 10] [3 12] [5 18]] gestionsolidmode
   2 copy pop xcheck {
      %% cylindre cas general
      /h exch def
      /U exch def
      U normalize3d /u defpoint3d
      /lafonction exch def
      /b exch def
      /a exch def
      /pas b a sub n1 div def
      /vpas h n2 div def
      /S [
         0 1 n2 {
            /j exch def
            0 1 n1 {
               /i exch def
               a i pas mul add lafonction
               u j vpas mul mulv3d addv3d
            } for
         } for
      ] def
      /F [
         0 1 n2 1 sub {
            /j exch def
            0 1 n1 1 sub {
               /i exch def
               [
                  i n1 1 add j mul add 
                  dup 1 add
                  dup n1 1 add add
                  dup 1 sub
               ]
            } for
         } for
      ] def
      
      S F generesolid
%      dup videsolid
   } {
      %% cylindre de revolution
      2 copy pop [n2 n1] newtronccone
   } ifelse
end
} def

%% syntaxe : z0 r0 z1 newcylindrecreux -> solide
/newcylindrecreux {
   newcylindre
   dup creusesolid
} def

%%%%% ### newtronccone ### 
%% syntaxe : z0 r0 z1 r1 newtronccone -> solid
/newtronccone {
11 dict begin
   [[/n /N] [1 6] [1 8] [1 10] [3 12] [5 18]] gestionsolidmode

   /r1 exch def
   /z1 exch def
   /r0 exch def
   /z0 exch def
   /dz z1 z0 sub n div def
   /dr r1 r0 sub n div def

   /FE [
      [0 1 N 1 sub {} for]
      [n 1 add N mul 1 sub -1 n N mul {} for]

      0 1 n 1 sub {
      /k exch def
         k N mul 1 add 1 k 1 add N mul 1 sub {
             /i exch def
             [i i 1 sub N i add 1 sub N i add]
         } for
         [k N mul k 1 add N mul 1 sub k 2 add N mul 1 sub k 1 add N mul]
      } for

   ] def

   %% tableau des sommets
   /S [
      n -1 0 {
         /k exch def
         0 1 N 1 sub {
             /i exch def
             360 N idiv i mul cos r0 dr k mul add mul
             360 N idiv i mul sin r0 dr k mul add mul
             z0 dz k mul add
         } for
      } for
   ] def
   S FE generesolid
end
} def

%% syntaxe : z0 r0 z1 r1 newtroncconecreux -> solid
/newtroncconecreux {
   newtronccone
   dup creusesolid
} def

%%%%% ### newcone ### 
%% syntaxe : z0 r0 z1 newcone -> solid
%% syntaxe : z0 r0 z1 {mode} newcone -> solid
%% syntaxe : z0 r0 z1 [n1 n2] newcone -> solid
%% syntaxe : a b {f} {sommet} [n1 n2] newcone -> solid
/newcone {
11 dict begin
   [ [/n /N] [1 6] [1 8] [1 10] [3 12] [5 18] ] gestionsolidmode
   dup xcheck {
      %% cas general
      /sommet exch def
      /lafonction exch def
      /b exch def
      /a exch def

      /pas b a sub N div def
      /S [
         sommet
         0 1 n 1 sub {
            /j exch def
            0 1 N {
               /i exch def
               a i pas mul add lafonction
               dupp3d sommet vecteur3d j n div mulv3d addv3d
            } for
         } for
         1 1 n {
            /j exch def
            0 1 N {
               /i exch def
               a i pas mul add lafonction
               sommet vecteur3d j n div mulv3d sommet addv3d
            } for
         } for
      ] def

      /F [
         %% les etages inferieurs
         0 1 n 2 sub {
            /j exch def
            1 1 N {
               /i exch def
               [
                  i j N 1 add mul add
                  dup 1 add
                  dup N add 1 add
                  dup 1 sub
               ]
            } for
         } for
         %% dernier etage inferieur
         1 1 N {
            /i exch def
            [
               i N 1 add n 1 sub mul add
               dup 1 add
               0
            ]
         } for
         %% premier etage superieur
         1 1 N {
            /i exch def
            [
               i N 1 add n mul add
               dup 1 add
               0
               exch
            ]
         } for
         %% les etages superieurs
         n 1 n 2 mul 2 sub {
            /j exch def
            1 1 N {
               /i exch def
               [
                  i j N 1 add mul add
                  dup 1 add
                  dup N add 1 add
                  dup 1 sub
               ]
            } for
         } for
      ] def

      S F generesolid
%      dup videsolid
   } {
      %% cylindre de revolution
      /z1 exch def
      /r0 exch def
      /z0 exch def
      /dz z1 z0 sub n div def
      /dr r0 n div def
   
      /F [
         %% la base
         [N 1 sub -1 0 {} for]
         %% le dernier etage
         n 1 sub N mul 1 add 1 n N mul 1 sub {
              /i exch def
              [i 1 sub i n N mul]
         } for
         [n N mul 1 sub n 1 sub N mul n N mul]
         %% les autres etages
         0 1 n 2 sub {
            /j exch def
            0 N j mul add 1 N N j mul add 2 sub {
               /i exch def
               [i i 1 add dup N add dup 1 sub]
            } for
            [N N j mul add 1 sub N j mul dup N add dup N add 1 sub]
         } for
      ] def
   
      %% tableau des sommets
      /S [
         %% etage no j (in [1; n])
         0 1 n 1 sub {
            /j exch def
            0 1 N 1 sub {
                /i exch def
                360 N idiv i mul cos r0 dr j mul sub mul
                360 N idiv i mul sin r0 dr j mul sub mul
                z0 dz j mul add
            } for
         } for
         0 0 z1
      ] def
      S F generesolid
   } ifelse
end
} def

%% %% syntaxe : z0 r0 z1 newconecreux -> solid
 /newconecreux {
    newcone
    dup 0 solidrmface
    dup videsolid
 } def

%%%%% ### newtore ### 
%% syntaxe : r R newtore -> solid
/newtore {
10 dict begin
   [[/n1 /n2] [4 5] [6 10] [8 12] [9 18] [18 36]] gestionsolidmode
   /n2 n2 3 max store
   /n1 n1 2 max store
   /R exch def
   /r exch def
   /S [
         0 1 n1 1 sub {
            /i exch def
            360 n1 div i mul cos r mul R add
            360 n1 div i mul sin r mul
         } for
      ]
   def
   S [n2] newanneau
end
} def

%%%%% ### newprisme ### 
%% syntaxe : array z0 z1 newprisme -> solid d axe (O, u),
/newprismedroit {
   [[/N] [1] [1] [1] [3] [6]] gestionsolidmode
   0 0 1 [N] newprisme
} def

%% syntaxe : array z0 z1 u newprisme -> solid d axe (O, u),
%% ou array tableau de points 2d
/newprisme {
7 dict begin
   [[/N] [1] [1] [1] [3] [6]] gestionsolidmode
   dup 0 eq {
      (Error : 3eme composante nulle dans le vecteur pour newprisme) ==
      quit
   } if
   /u defpoint3d
   /z1 exch def
   /z0 exch def
   %% N = nb d etages
   /table exch def
   %% n = indice du dernier point
   /n table length 2 idiv 1 sub def
   %% vecteur de translation
   u
   z1 z0 sub u norme3d div
   mulv3d /v defpoint3d

   %% tableau des sommets
   /S [
      0 1 N {
         /j exch def
         0 1 n {
             /i exch def
             table i getp
             z0
             v N j sub N div mulv addv3d
         } for
      } for
   ] def

   /F [ 
      %% face superieure
      [0 1 n {} for]
      %% base
      [N 1 add n 1 add mul 1 sub -1 N n 1 add mul {} for]
      %% faces etage
      1 1 N {
         /j exch def
         1 1 n {
             /i exch def
             [i                   j 1 sub n 1 add mul add
              i 1 sub             j 1 sub n 1 add mul add
              n 1 add i add 1 sub j 1 sub n 1 add mul add
              n 1 add i add       j 1 sub n 1 add mul add]
         } for
         [0            j 1 sub n 1 add mul add
         n             j 1 sub n 1 add mul add
         2 n mul 1 add j 1 sub n 1 add mul add
         n 1 add       j 1 sub n 1 add mul add]
     } for
   ] def

   S F generesolid
end
} def

%%%%% ### newsphere ### 
%% syntaxe : r option newsphere -> solid
/newsphere {
2 dict begin
   [[/K /N] [6 6] [8 8] [10 12] [16 12] [16 36]] gestionsolidmode
   -90 90 [K N] newcalottesphere
end
} def

%% syntaxe : r phi theta option newcalottesphere -> solid
/newcalottesphere {
6 dict begin
   [[/K /N] [6 6] [8 8] [10 12] [16 12] [16 36]] gestionsolidmode

   %% test de beta (ex-theta)
   dup 90 eq {
      /beta exch def
      /idebut 1 def
   } {
      /beta exch 80 min -80 max def
      /idebut 0 def
   } ifelse
   %% test de alpha (ex-phi)
   dup -90 eq {
      /alpha exch def
   } {
      /alpha exch beta min -80 max def
   } ifelse
   /r exch def
   beta 90 eq {
       alpha -90 eq {
           /ifin K def
          /db alpha beta sub K 1 add div def
       } {
           /ifin K def
          /db alpha beta sub K div def
       } ifelse
   } {
       alpha -90 eq {
           /ifin K 1 sub def
          /db alpha beta sub K div def
       } {
           /ifin K 1 sub def
          /db alpha beta sub K 1 sub div def
       } ifelse
   } ifelse

   %% nombre de sommets -2
   /nb N K mul def

   %% tableau des sommets
   /S [
       idebut 1 ifin {
           /j exch def
           /phi beta j db mul add def
           phi cos r mul /r_tmp exch def
           0 1 N 1 sub {
                /i exch def
                360 N idiv i mul cos r_tmp mul
                360 N idiv i mul sin r_tmp mul
                phi sin r mul
            } for
       } for
      0 0 r neg
      0 0 r
   ] def

   /F [
     %% calotte inferieure
     alpha -90 eq {
         1 1 N 1 sub {
         /i exch def
            [
                nb
                nb i sub
                nb i 1 add sub
            ]
         } for
         [nb nb N sub nb 1 sub]
     } {
        [nb 1 sub -1 nb N sub {} for ]
     } ifelse

     %% calotte superieure
     beta 90 eq {
         0 1 N 1 sub {
            /i exch def
             [i i 1 add N mod N K mul 1 add]
         } for
      } {
         [0 1 N 1 sub {} for]
      } ifelse

     1 1 K 1 sub {
          /j exch def
       [
           j N mul
           j N mul 1 add
           j 1 sub N mul 1 add
           j 1 sub N mul
       ]
       N 2 sub {dup {1 add} apply} repeat
       [
           j 1 add N mul 1 sub
           j N mul
           j 1 sub N mul
           j N mul 1 sub
       ]
    } for
   ] def

   S F generesolid
end
} def

%% syntaxe : r phi theta option newcalottespherecreuse -> solid
/newcalottespherecreuse {
6 dict begin
   [[/K /N] [6 6] [8 8] [10 12] [16 12] [16 36]] gestionsolidmode

   %% test de beta (ex-theta)
   dup 90 eq {
      /beta exch def
      /idebut 1 def
   } {
      /beta exch 80 min -80 max def
      /idebut 0 def
   } ifelse
   %% test de alpha (ex-phi)
   dup -90 eq {
      /alpha exch def
   } {
      /alpha exch beta min -80 max def
   } ifelse
   /r exch def
   beta 90 eq {
       alpha -90 eq {
           /ifin K def
          /db alpha beta sub K 1 add div def
       } {
           /ifin K def
          /db alpha beta sub K div def
       } ifelse
   } {
       alpha -90 eq {
           /ifin K 1 sub def
          /db alpha beta sub K div def
       } {
           /ifin K 1 sub def
          /db alpha beta sub K 1 sub div def
       } ifelse
   } ifelse

   %% nombre de sommets -2
   /nb N K mul def

   %% tableau des sommets
   /S [
       idebut 1 ifin {
           /j exch def
           /phi beta j db mul add def
           phi cos r mul /r_tmp exch def
           0 1 N 1 sub {
                /i exch def
                360 N idiv i mul cos r_tmp mul
                360 N idiv i mul sin r_tmp mul
                phi sin r mul
            } for
       } for
      0 0 r neg
      0 0 r
   ] def

   /F [
     %% calotte inferieure
     alpha -90 eq {
         1 1 N 1 sub {
         /i exch def
            [
                nb
                nb i sub
                nb i 1 add sub
            ]
         } for
         [nb nb N sub nb 1 sub]
     } {
%        [nb 1 sub -1 nb N sub {} for ]
     } ifelse

     %% calotte superieure
     beta 90 eq {
         0 1 N 1 sub {
            /i exch def
             [i i 1 add N mod N K mul 1 add]
         } for
      } {
%         [0 1 N 1 sub {} for]
      } ifelse

     1 1 K 1 sub {
          /j exch def
       [
           j N mul
           j N mul 1 add
           j 1 sub N mul 1 add
           j 1 sub N mul
       ]
       N 2 sub {dup {1 add} apply} repeat
       [
           j 1 add N mul 1 sub
           j N mul
           j 1 sub N mul
           j N mul 1 sub
       ]
    } for
   ] def

   S F generesolid
   dup videsolid
end
} def

%%%%% ### newanneau ### 
%% syntaxe : array n newanneau --> solid
%% syntaxe : array {mode} newanneau --> solid
%% ou array est un tableau de points de R^2 et n un nombre entier positif
/newanneau {
10 dict begin
   dup isnum {
      /n exch def
      [n]
   } if
   [[/n2] [6] [12] [24] [32] [36]] gestionsolidmode
   /n2 n2 3 max store
   %% on plonge la section dans R^3 par projection sur yOz
   /S1 exch {0 3 1 roll} papply def
   %% nombre de sommets
   /n1 S1 length 3 idiv def

   /S S1
      n2 {
         duparray
         {0 0 360 n2 div rotateOpoint3d} papply3d
      } repeat
      n2 {append} repeat
   def

   /F [
      0 1 n2 1 sub {
         /j exch def
         n1 j mul 1 j 1 add n1 mul 2 sub {
            /i exch def
            [i 1 add i dup n1 add i n1 1 add add]
         } for
         [n1 j mul j 1 add n1 mul 1 sub j 2 add n1 mul 1 sub j 1 add n1 mul]
      } for
   ] def

   S F generesolid
end
} def

%%%%% ### newvecteur ### 
%% syntaxe : x y z newvecteur
%% syntaxe : x y z array newvecteur
/newvecteur {
4 dict begin
   dup isarray {
      /table exch def
      /h@uteur table 1 get def
      /r@y@n table 0 get def
   } {
      /h@uteur .3 def
      /r@y@n .1 def
   } ifelse
   /A defpoint3d
   %%Sommets
   /S [0 0 0 A] def
   /F [
      [0 1]
   ] def
   S F generesolid
   [ A ]
   normalvect_to_orthobase
   /imK defpoint3d
   /imJ defpoint3d
   /imI defpoint3d

   A norme3d /z exch h@uteur sub def 
   0 r@y@n h@uteur [1 8] newcone
   dup (noir) outputcolors
   {0 0 z translatepoint3d} solidtransform
   {imI imJ imK transformpoint3d} solidtransform
   solidfuz
end
} def

%%%%% ### readsolidfile ###
%% syntaxe : str readsolidfile -> solid
/readsolidfile {
1 dict begin
   /str exch def
   [str (-sommets.dat) append run] 
   [str (-faces.dat) append run]
   generesolid
   dup [str (-couleurs.dat) append run] solidputfcolors
   dup [str (-io.dat) append run] solidputinouttable
end
} def

%%%%% ### writesolidfile ###
%% syntaxe : solid str writesolidfile -> -
/writesolidfile {
10 dict begin
   /str exch def
   /solid exch def
   solid issolid not {
      (Error : mauvais type d argument dans writesolidfile) ==
      quit
   } if
   str (-sommets.dat) append (w) file /lefichiersommets exch def
   str (-faces.dat) append (w) file /lefichierfaces exch def
   str (-couleurs.dat) append (w) file /lefichiercouleurs exch def
   str (-io.dat) append (w) file /lefichierio exch def

   /S solid solidgetsommets def
   0 1 S length 3 idiv 1 sub {
      /i exch def
      solid i solidgetsommet
      /z exch def
      /y exch def
      /x exch def
      lefichiersommets x chaine cvs writestring
      lefichiersommets 32 write %% espace
      lefichiersommets y chaine cvs writestring
      lefichiersommets 32 write %% espace
      lefichiersommets z chaine cvs writestring
      lefichiersommets 10 write %% CR
   } for
   lefichiersommets closefile

   /F solid solidgetfaces def
   0 1 F length 1 sub {
      /i exch def
      /Fi solid i solidgetface def
      lefichierfaces 91 write %% [
      0 1 Fi length 1 sub {
         /j exch def
         lefichierfaces Fi j get chaine cvs writestring
         lefichierfaces 32 write %% espace
      } for
      lefichierfaces 93 write %% ]
      lefichierfaces 10 write %% CR
   } for
   lefichierfaces closefile

   /C solid solidgetfcolors def
   0 1 C length 1 sub {
      /i exch def
      lefichiercouleurs 40 write %% (
      lefichiercouleurs C i get writestring
      lefichiercouleurs 41 write %% )
      lefichiercouleurs 10 write %% CR
   } for
   lefichiercouleurs closefile

   /IO solid solidgetinouttable def
   0 1 3 {
      /i exch def
      lefichierio IO i get chaine cvs writestring
      lefichierio 32 write %% space
   } for
   lefichierio closefile
end
} def

%%%%% ### writeobjfile ###
%% syntaxe : solid str writeobjfile -> -
/writeobjfile {
10 dict begin
   /str exch (.obj) append def
   /solid exch def
   solid issolid not {
      (Erreur : mauvais type d argument dans writeobjfile) ==
      quit
   } if
   /n solid solidnombresommets def
   str (w) file /lefichier exch def
   0 1 n 1 sub {
      /i exch def
      solid i solidgetsommet
      /z exch def
      /y exch def
      /x exch def
      lefichier (v ) writestring
      lefichier x chaine cvs writestring
      lefichier 32 write %% espace
      lefichier y chaine cvs writestring
      lefichier 32 write %% espace
      lefichier z chaine cvs writestring
      lefichier 10 write %% CR
   } for
   /n solid solidnombrefaces def
   0 1 n 1 sub {
      /i exch def
      lefichier (f ) writestring
      /F solid i solidgetface {1 add} apply def
      F {
         lefichier exch
         chaine cvs writestring
         lefichier  32  write %% espace
      } apply
      lefichier  10  write %% CR
   } for
   lefichier closefile
end
} def

%%%%% ### writeofffile ###
%% syntaxe : solid str writeobjfile -> -
/writeofffile {
12 dict begin
   /str exch (.off) append def
   /solid exch def
   solid issolid not {
      (Erreur : mauvais type d argument dans writeofffile) ==
      quit
   } if
   /n solid solidnombresommets def
   /nf solid solidnombrefaces def
   str (w) file /lefichier exch def
   lefichier (OFF) writestring
   lefichier 10 write %% CR
   lefichier n chaine cvs writestring
   lefichier 32 write %% espace
   lefichier nf chaine cvs writestring
   lefichier 32 write %% espace
   lefichier 0 chaine cvs writestring
   lefichier 10 write %% CR
   0 1 n 1 sub {
      /i exch def
      solid i solidgetsommet
      /z exch def
      /y exch def
      /x exch def
      lefichier x chaine cvs writestring
      lefichier 32 write %% espace
      lefichier y chaine cvs writestring
      lefichier 32 write %% espace
      lefichier z chaine cvs writestring
      lefichier 10 write %% CR
   } for
   0 1 nf 1 sub {
      /i exch def
      /F solid i solidgetface def
      lefichier F length chaine cvs writestring
      lefichier 32 write %% espace
      F {
         lefichier exch
         chaine cvs writestring
         lefichier  32  write %% espace
      } apply
      lefichier  10  write %% CR
   } for
   lefichier closefile
end
} def

%%%%% ### newobjfile ###
/newobjfile {
3 dict begin
   /objfilename exch (.obj) append def
   /v {} def
   /ok true def
   /f {
       ok {
        %% 1ere fois
           ] %% ferme les sommets
        [ [ %% ouvre les faces
        /ok false store
       } {
        %% les autres fois
           ] %% ferme la face
        [ %% ouvre la nouvelle
       } ifelse
   } def
   [ 0 0 0 %% sommet fantome pour respecter l'indexation (a partir de l'indice 1)
   objfilename run
   ]]
   /F exch def
   /S exch def

   S F generesolid
%   dup videsolid
end
} def

%%%%% ### newofffile ###
/newofffile {
3 dict begin
   /str 35 string def
   /offfilename exch (.off) append def
   offfilename (r) file
   /offfile exch def
   offfile str readline pop pop
   offfile str readline pop
   numstr2array
   dup 0 get /ns exch def
   1 get /nf exch def
   [ns {
      offfile str readline pop numstr2array aload pop
%      3 1 roll
   } repeat]
   /S exch def
   [nf {
      [
      offfile str readline pop numstr2array
      /table exch def
      1 1 table length 1 sub {
         /i exch def
         table i get
      } for
      ]
   } repeat]
   /F exch def

   S F generesolid
%   dup videsolid
end
} def

%%%%% ### newtube ###
 /tub@dernierk1 [1 0 0] def
 /tub@dernierk2 [0 1 0] def
 /tub@dernierk3 [0 0 1] def

/inittube {
2 dict begin
   normalize3d /vect3 defpoint3d
   normalize3d /vect2 defpoint3d
   normalize3d /vect1 defpoint3d
   vect1 norme3d 0 eq {
      vect2 vect3 vectprod3d /vect1 defpoint3d
   } if
   vect2 norme3d 0 eq {
      vect3 vect1 vectprod3d /vect2 defpoint3d
   } if
   vect3 norme3d 0 eq {
      vect1 vect2 vectprod3d /vect3 defpoint3d
   } if
   /tub@dernierk1 [vect1] store
   /tub@dernierk2 [vect2] store
   /tub@dernierk3 [vect3] store
end
} def
 
%% syntaxe : tmin tmax (f) array r newtube -> solid
%% array = [K N]
/newtube {
10 dict begin
   /table exch def
   /K table 0 get def %% nb d etages
   /N table 1 get def %% nb de points sur le perimetre
   /@r exch def       %% le rayon du tube
   /str exch def
   /lafonction str cvx def
   /laderivee str (') append cvx def
%%   /laderivee2nd str ('') append cvx def
   /tmax exch def
   /tmin exch def
   /pas tmax tmin sub K 1 sub div def

   %% definition des sommets
   [
   /@k 0 def
   K {
      /a0 tmin @k pas mul add def
   
      %% definition du repere de Frenet (k1, k2, k3) au point f(a)
      a0 lafonction /M defpoint3d

      str (') append cvlit where {
         pop 
         a0 laderivee normalize3d /k1 defpoint3d
%         pop /avecderiv true def
      } {
         M a0 pas 100 div add lafonction vecteur3d normalize3d /k1 defpoint3d
%         /avecderiv false
      } ifelse

      k1 baseplannormal /K3 defpoint3d /K2 defpoint3d
%      a0 laderivee2nd normalize3d /k2 defpoint3d

      %% projete orthogonal du dernier rayon sur le plan actuel
      %% (normal a la vitesse)
      K2 tub@dernierk2 aload pop K2 scalprod3d mulv3d 
      K3 tub@dernierk2 aload pop K3 scalprod3d mulv3d addv3d /k2 defpoint3d
%      M k1 K2 K3 dessinebase
      k1 norme3d 0 eq {
         tub@dernierk1 aload pop /k1 defpoint3d
      } {
         /tub@dernierk1 [k1] store
      } ifelse
      k2 norme3d 0 eq {
         tub@dernierk2 aload pop /k2 defpoint3d
      } {
         /tub@dernierk2 [k2] store
      } ifelse
      k1 k2 vectprod3d normalize3d /k3 defpoint3d
      k3 norme3d 0 eq {
          tub@dernierk3 aload pop /k3 defpoint3d
      } {
         /tub@dernierk3 [k3] store
      } ifelse
      k3 k1 vectprod3d normalize3d /k2 defpoint3d
%%      M k1 k2 k3 dessinebase
      /tub@dernierk2 [k2] store
      /@n 360 N div def %% le pas angulaire
      0 @n 360 @n sub {
         /@i exch def
         M
         k2 @i cos @r mul mulv3d addv3d
         k3 @i sin @r mul mulv3d addv3d
      } for
      /@k @k 1 add store
   } repeat
   ]

   dup length 3 idiv /nb exch def
   %% definition des faces
   [
      %% face de depart
      [N 1 sub -1 0 {} for]
      %% face d arrivee
      [nb 1 sub N 1 sub {dup 1 sub} repeat] reverse
   
      %% les etages
      /j 0 def
      K 1 sub {
         0 1 N 1 sub {
            /i exch def
            [
               i                   N j mul add
               i 1 add N mod       N j mul add
               i 1 add N mod N add N j mul add
               i N add             N j mul add
            ]
         } for
         /j j 1 add store
      } repeat
   ]
   generesolid
end
} def

%%%%% ### newcourbe ###
%% syntaxe : a b {f} array newcourbe --> solid
/newcourbe {
10 dict begin
   dup xcheck not {
      0 get /n exch def
   } {
      /n 80 def
   } ifelse
   /l@f@nct exch def
   /b exch def
   /a exch def
   /pas b a sub n 1 sub div def
   /S [
   0 1 n 1 sub {
      /@i exch def
      a @i pas mul add
      l@f@nct
      pstrickactionR3
   } for
   ] def
   /@F [
      0 1 n 2 sub {
         /@i exch def
         [@i @i 1 add]
      } for
   ] def
   S @F generesolid
end
} def

%%%%% ### baseplannormal ###
%% syntaxe : x y z baseplannormal -> x1 y1 z1 x2 y2 z2
/baseplannormal {
5 dict begin
   /K defpoint3d
   1 0 0 K vectprod3d normalize3d /U defpoint3d
   U norme3d 0 eq {
      0 1 0 K vectprod3d normalize3d /U defpoint3d
   } if
   K U vectprod3d normalize3d /V defpoint3d
   U V
end
} def

%%%%% ### fin insertion ###

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                                    %%%%
%%%%      fin insertion librairie jps                   %%%%
%%%%                                                    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%          gestion de chaine de caracteres           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/Times-Roman findfont 
dup length dict begin
   {
   1 index /FID ne 
      {def}
      {pop pop} 
   ifelse
   } forall
   /Encoding ISOLatin1Encoding def
   currentdict
end
/Times-Roman-ISOLatin1 exch definefont pop

/setTimesRoman {
   /Times-Roman-ISOLatin1 findfont 
   fontsize scalefont 
   setfont
} def

/setTimes {
   setTimesRoman
} def

%% syntaxe : string x y cctext
/cctext {
5 dict begin
   /y exch def
   /x exch def
   /str exch def
   str stringwidth
   /wy exch def
   /wx exch def
   gsave
      x y smoveto
      wx -2 div wy -2 div rmoveto
      str show
   grestore
end
} def

/dbtext {gsave newpath dbtext_ Fill grestore} def
/dctext {gsave newpath dctext_ Fill grestore} def
/dltext {gsave newpath dltext_ Fill grestore} def
/drtext {gsave newpath drtext_ Fill grestore} def

/bbtext {gsave newpath bbtext_ Fill grestore} def
/bctext {gsave newpath bctext_ Fill grestore} def
/bltext {gsave newpath bltext_ Fill grestore} def
/brtext {gsave newpath brtext_ Fill grestore} def

/cbtext {gsave newpath cbtext_ Fill grestore} def
/cctext {gsave newpath cctext_ Fill grestore} def
/cltext {gsave newpath cltext_ Fill grestore} def
/crtext {gsave newpath crtext_ Fill grestore} def

/ubtext {gsave newpath ubtext_ Fill grestore} def
/uctext {gsave newpath uctext_ Fill grestore} def
/ultext {gsave newpath ultext_ Fill grestore} def
/urtext {gsave newpath urtext_ Fill grestore} def


%% syntaxe : str x y show_dim --> str x y llx lly wx wy 
%% attention, doit laisser la pile intacte
/show_dim {
   3 copy pop pop
   newpath
      0 0 moveto
      true charpath flattenpath pathbbox 
   closepath
   newpath
} def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             procedures pour PSTricks               %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% les 3 procedures utilisees pour transformer les depots de AlgToPs en nombres
/pstrickactionR3 { 
3 dict begin 
  /len@3 exch def 
  /len@2 exch def 
  /len@1 exch def 
  len@1 exec 
  len@2 exec 
  len@3 exec 
end 
} def 

/pstrickactionR2 {
   exec exch exec exch
} def

/pstrickactionR {
   exec
} def

/gere_pst-deffunction {
   counttomark
   dup 1 eq {
      pop
      pstrickactionR
      ] aload pop
   } {
      2 eq {
         pstrickactionR2
         ] aload pop
      } {
         pstrickactionR3
         ] aload pop
      } ifelse
   } ifelse
} def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             procedures pour \psSolid               %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/all (all) def

/draw {drawsolid} def
/draw* {drawsolid*} def
/draw** {drawsolid**} def
/writeobj {solidfilename writeobjfile} def
/writesolid {solidfilename writesolidfile} def
/writeoff {solidfilename writeofffile} def
/none {pop} def
/vecteur_en_c@urs false def

/gere_pstricks_color_inout {
   gsave
      dup  [fillincolor] (setrgbcolor) astr2str
         [fillcolor] (setrgbcolor) astr2str inoutputcolors
   grestore
} def

/gere_pstricks_color_out {
   gsave
      dup  [fillcolor] (setrgbcolor) astr2str outputcolors
   grestore
} def

/gere_pstfont {
   fontsize mul setfontsize
   %setTimes
   PSfont dup /Symbol ne isolatin and {
      /ISO-Font ReEncode /ISO-Font
   } if
   findfont fontsize scalefont setfont
} def

/gere_pstricks_opt {
%   /CourbeR2 {CourbeR2+} def
   1 gere_pstfont
   linecolor
   linestyle
   solidlinewidth setlinewidth
   solidtrunc length 0 ne {
      solidtrunc 0 get isstring {
         dup trunccoeff solidtronque
      } {
         dup solidtrunc trunccoeff solidtronque
      } ifelse
   } if
   solidgeode {
      1 newgeode
   } if
   soliddualreg {
      dualpolyedreregulier
   } if
   chanfrein {
      dup chanfreincoeff solidchanfreine
   } if
   RotX 0 ne RotY 0 ne or RotZ 0 ne or {
      {RotX RotY RotZ rotateOpoint3d} solidtransform
   } if
   CX 0 ne CY 0 ne or CZ 0 ne or {
      {CX CY CZ translatepoint3d} solidtransform
   } if
   plansection length 0 gt {
      0 1 plansection length 1 sub {
         /i exch def
         plansection i get solidplansection
         dup 0 solidrmface
      } for
   } if
   /rmfaces rmfaces bubblesort reverse store
   0 1 rmfaces length 1 sub {
      /i exch def
      dup rmfaces i get solidrmface
   } for
   tx@Dict /pst-transformoption known {
      dup {pst-transformoption} solidtransform 
   } if
   solidaffinage length 0 ne {
      %% si on affine, il faut colorier avant
      activationgestioncouleurs {
         gere_pstricks_color_out
      } if
      solidaffinage 0 get isstring {
         dup affinagecoeff
         /solidfcolor where {
            pop
            solidfcolor
         } if
         affinagerm solidaffine
      } {
         dup affinagecoeff solidaffinage
         /solidfcolor where {
            pop
            solidfcolor
         } if
         affinagerm solidaffine
      } ifelse
      %% et il faut evider et coloriier l'interieur si necessaire
      solidhollow {
         dup videsolid
         activationgestioncouleurs {
            gsave
               dup  [fillincolor] (setrgbcolor) astr2str inputcolors
            grestore
         } if
      } if
      /activationgestioncouleurs false def
   } if
   tx@Dict /plansepare known {
      plansepare solidplansepare
      tx@Dict /plansepare undef
      tx@Dict /solidname known {
         solidname (1) append cvlit exch def
         dup solidname (0) append cvlit exch def
         %%
         solidname (1) append cvx exec
         solidhollow {
            dup videsolid
         } if
         activationgestioncouleurs {
            dup solidwithinfaces {
               gere_pstricks_color_inout 
            } {
               gere_pstricks_color_out
            } ifelse
         } if
         solidinouthue length 0 gt { 
            dup solidinouthue solidputinouthuecolors 
         } {
            solidhue length 0 gt {
               dup solidhue solidputhuecolors
            } if
            solidinhue length 0 gt {
               dup solidinhue solidputinhuecolors
            } if
         } ifelse
         pop
         tx@Dict /solidname undef
      } {
         /solid1 exch def
         /solid2 exch def
      } ifelse
   } if
   solidhollow {
      dup videsolid
   } if
   activationgestioncouleurs {
      zcolor length 0 ne {
         dup zcolor tablez solidcolorz 
      } {
         dup solidwithinfaces {
            gere_pstricks_color_inout 
         } {
            gere_pstricks_color_out
         } ifelse
         solidinouthue length 0 gt { 
            dup solidinouthue solidputinouthuecolors 
         } {
            solidhue length 0 gt {
               dup solidhue solidputhuecolors
            } if
            solidinhue length 0 gt {
               dup solidinhue solidputinhuecolors
            } if
         } ifelse
      } ifelse
   } {
      /activationgestioncouleurs true def
   } ifelse

   0 1 fcol length 2 idiv 1 sub {
      /i exch def 
      dup fcol 2 i mul get fcol 2 i mul 1 add get solidputfcolor
   } for
   vecteur_en_c@urs not {
      /lightsrc where {pop solidlightOn} if
   } {
      /vecteur_en_c@urs false def
   } ifelse
   dup action cvx exec
   noir
   solidnumf length 0 ne {
      solidnumf 0 get isstring {
         dup projectionsifacevisible solidnumfaces
      } {
         dup solidnumf projectionsifacevisible solidnumfaces
      } ifelse
   } if
   solidshow length 0 ne {
      solidshow 0 get isstring {
         dup solidshowsommets
      } {
         dup solidshow solidshowsommets
      } ifelse
   } if
   solidnum length 0 ne {
      solidnum 0 get isstring {
         .8 gere_pstfont
         dup solidnumsommets
      } {
         dup solidnum solidnumsommets
      } ifelse
   } {
      %% pop
   } ifelse
   tx@Dict /solidname known {
      solidname cvlit exch bind def
      tx@Dict /solidname undef
   } {
      pop
   } ifelse
} def

/pst-octahedron {
   a newoctaedre
   gere_pstricks_opt
} def

/pst-dodecahedron {
   a newdodecaedre
   gere_pstricks_opt
} def

/pst-icosahedron {
   a newicosaedre
   gere_pstricks_opt
} def

/pst-cube {
   a
   ngrid length 1 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   newcube 
%%    solidhollow {
%%       dup videsolid
%%    } if
   gere_pstricks_opt
} def

/pst-parallelepiped {
   a b c
   newparallelepiped
   gere_pstricks_opt
} def

/pst-tetrahedron {
   r newtetraedre
   gere_pstricks_opt
} def

/pst-tore {
   r0 r1
   ngrid length 2 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   newtore
   gere_pstricks_opt
} def

/pst-sphere {
   % rayon
   % mode
  %   r {Mode} newsphere
   r
   ngrid length 2 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   newsphere
   gere_pstricks_opt
} def
%
/pst-cylindre {
   /save-cylinderhollow solidhollow def
   tx@Dict /function known {
      range aload pop function cvx {axe} h ngrid newcylindre
      tx@Dict /function undef
      /solidhollow true def
   } {
      % rayon
      % mode
      0 r h
      ngrid length 2 eq {
         ngrid
      } {
         {Mode}
      } ifelse
      newcylindre
      solidhollow {
         dup creusesolid
      } if
   } ifelse
   gere_pstricks_opt
   /solidhollow save-cylinderhollow store
} def
%
/pst-cylindrecreux {
   % rayon
   % mode
   0 r h
   ngrid length 2 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   newcylindre
   dup creusesolid
   gere_pstricks_opt
} def

/pst-cone {
   /save-conehollow solidhollow def
   tx@Dict /function known {
      range aload pop function cvx {origin} ngrid newcone
      tx@Dict /function undef
      /solidhollow true def
   } {
      % rayon
      % mode
      0 r h
      ngrid length 2 eq {
         ngrid
      } {
         {Mode}
      } ifelse
      solidhollow {
         newconecreux
      } {
         newcone
      } ifelse
   } ifelse
   gere_pstricks_opt
   /solidhollow save-conehollow store
} def

/pst-tronccone {
   % rayon
   % mode
   0 r0 h r1
   ngrid length 2 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   solidhollow {
      newtroncconecreux
   } {
      newtronccone
   } ifelse
   gere_pstricks_opt
} def

/pst-troncconecreux {
   % rayon
   % mode
   0 r0 h r1
   ngrid length 2 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   newtroncconecreux
   gere_pstricks_opt
} def

/pst-conecreux {
   % rayon
   % mode
   0 r h
   ngrid length 2 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   newconecreux
   gere_pstricks_opt
} def

/pst-anneau {
   [ section ]
   ngrid length 1 ge {
      [ngrid 0 get]
   } {
      [24]
   } ifelse
   newanneau
   gere_pstricks_opt
} def


/pst-prisme {
   % tableau des points de la base
   % h hauteur du prisme
   % axe : vecteur direction de l axe
   base decal rollparray
   0 h axe
   ngrid length 1 ge {
      [ngrid 0 get]
   } if
   newprisme
   solidhollow {
      dup creusesolid
   } if
   gere_pstricks_opt
} def

/pst-prismecreux {
   % tableau des points de la base
   % h hauteur du prisme
   % axe : vecteur direction de l axe
   base
   0 h axe
   ngrid length 1 ge {
      [ngrid 0 get]
   } if
   newprisme
   dup creusesolid
   gere_pstricks_opt
} def

/pst-grille {
   base aload pop
   ngrid length 2 ge {
      [ngrid 0 get ngrid 1 get]
   } {
      ngrid length 1 eq {
         [ngrid 0 get dup]
      } if
   } ifelse
   newgrille
   gere_pstricks_opt
} def

%% syntaxe : array N h u newruban -> solid d axe (O, u),
/pst-ruban {
   % tableau des points de la base
   % h hauteur du prisme
   % axe : vecteur direction de l axe
   base
   h axe 
   ngrid length 1 ge {
      [ngrid 0 get]
   } if
   newruban
   gere_pstricks_opt
} def

%% syntaxe : r phi option newcalottesphere -> solid
/pst-calottesphere {
   % rayon
   % mode
   % r phi theta option newcalottesphere
   r
   phi theta
   ngrid length 2 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   solidhollow {
      newcalottespherecreuse
   } {
      newcalottesphere
   } ifelse
   gere_pstricks_opt
} def

%% syntaxe : r phi option newcalottesphere -> solid
/pst-calottespherecreuse {
   % rayon
   % mode
   % r phi theta option newcalottespherecreuse
   r
   phi theta
   ngrid length 2 eq {
      ngrid
   } {
      {Mode}
   } ifelse
   newcalottespherecreuse
   gere_pstricks_opt
} def

/pointtest{2 2 2} def

/pst-face {
   % tableau des points de la base
   % h hauteur du prisme
   % axe : vecteur direction de l axe
   base
   solidbiface {
      newbiface
   } {
      newmonoface 
   } ifelse
   gere_pstricks_opt
} def

/pst-Surface {
   base
   base aload pop
   ngrid length 2 ge {
      [ngrid 0 get ngrid 1 get]
   } {
      ngrid length 1 eq {
         [ngrid 0 get dup]
      } ifelse
   } ifelse
   {f} newsurface
   solidbiface {
      dup videsolid
   } if
   gere_pstricks_opt
} def

/pst-Surface* {
   r
   ngrid length 2 ge {
      [ngrid 0 get ngrid 1 get]
   } {
      ngrid length 1 eq {
         [ngrid 0 get dup]
      } ifelse
   } ifelse
   {f} newsurface*
   solidbiface {
      dup videsolid
   } if
   gere_pstricks_opt
} def

/pst-surface {
   base
   base aload pop
   ngrid length 2 ge {
      [ngrid 0 get ngrid 1 get]
   } {
      ngrid length 1 eq {
         [ngrid 0 get dup]
      } ifelse
   } ifelse
   { function cvx exec } newsurface
   solidbiface {
      dup videsolid
   } if
   gere_pstricks_opt
} def

/pst-polygoneregulier {
   r ngrid 0 get
   newpolreg
   solidbiface {
   } {
      dup 1 solidrmface
   } ifelse
   gere_pstricks_opt
} def

/pst-fusion {
1 dict begin
   /activationgestioncouleurs false def
   /n base length def
   base aload pop n 1 sub {solidfuz} repeat
   gere_pstricks_opt
end
} def

/pst-new {
   sommets faces
   generesolid
%%    solidhollow {
%%       dup videsolid
%%    } if
   gere_pstricks_opt
} def

/pst-courbe {
   solidlinewidth setlinewidth
   r 0 eq {
      range aload pop function cvx [resolution] newcourbe
      gere_pstricks_opt
   } {
      range aload pop function r
      ngrid length 2 lt {
         [300 4]
      } {
         ngrid
      } ifelse
      newtube
      gere_pstricks_opt %% r function [36 12] newtube
   } ifelse
} def
%
/pst-surfaceparametree {
   base aload pop
   ngrid length 2 ge {
      [ngrid 0 get ngrid 1 get]
   } {
      ngrid length 1 eq {
         [ngrid 0 get dup]
      } if
   } ifelse
   { function cvx exec } newsurfaceparametree
   dup videsolid
   gere_pstricks_opt
   tx@Dict /function undef
} def
%
/pst-surface* {
   r
   ngrid length 2 ge {
      [ngrid 0 get ngrid 1 get]
   } {
      ngrid length 1 eq {
         [ngrid 0 get dup]
      } if
   } ifelse
   { function cvx exec } newsurface*
   dup videsolid
   gere_pstricks_opt
} def

/pst-vecteur {
gsave
   /activationgestioncouleurs false def
   /vecteur_en_c@urs true def
   solidlinewidth setlinewidth
   2 setlinejoin
   1 setlinecap
   linecolor
   linestyle
   tx@Dict /solidname known {
      args definition cvx exec
      solidname cvlit defpoint3d
      tx@Dict /solidname undef
   } if
   args definition cvx exec newvecteur
   dup
   gsave
      [linecolor currentrgbcolor] ( ) astr2str (setrgbcolor) append 
      outputcolors
   grestore
   gere_pstricks_opt
grestore
} def

%/pst-vect- {} def
%/pst-vect-2points {vecteur3d} def
/pst-line {
   gsave
      linestyle 
      linecolor
      [args] ligne3d
   grestore
} def

/pst-objfile {
   solidfilename newobjfile
   gere_pstricks_opt
} def

/pst-offfile {
   solidfilename newofffile
   gere_pstricks_opt
} def

/pst-datfile {
   solidfilename readsolidfile
%   /activationgestioncouleurs false def
   gere_pstricks_opt
} def

/pst-plantype {
%   args definition
   args (pst-plan-) definition append cvx exec
   dup phi rotateplan
   base length 4 eq {
      dup base planputrange
   } if
   origin eqpl@n pointeqplan 0 eq {
      dup origin planputorigine
   } if
   ngrid length 0 ne {
      dup ngrid planputngrid
   } if
   tx@Dict /solidname known {
      solidname cvlit exch bind def
      tx@Dict /solidname undef
   } {
      pop
   } ifelse
} def
/pst-plan- {pst-plan-plantype} def

%x0 y0 z0 [normalvect] norm2plan
/pst-plan-plantype {
   dup plan2eq /eqpl@n exch def
   /plan-@k true def
} def

/pst-plan {
%   args definition
   args (pst-plan-) definition append cvx exec
   /pl@n-en-cours true def
   definition length 0 ne {
%   plan-@k not {
      dup
      base 0 get base 1 get lt
      base 2 get base 3 get lt and {
         base
      } {
         [-3 3 -2 2] %pop base %aload pop boum
      } ifelse
      planputrange
      origin eqpl@n pointeqplan 0 eq {
         dup origin planputorigine
      } if
      CX isreal
      CX 0 eq and
      CY isreal and
      CY 0 eq and
      CZ isreal and
      CZ 0 eq and not {
         dup CX CY CZ planputorigine
      } if
      /CX 0. def
      /CY 0. def
      /CZ 0. def
      ngrid length 0 ne {
         dup ngrid planputngrid
      } if
   } if
%   dup RotX RotY RotZ rotateOplan
   dup phi rotateplan
   /l@pl@n exch def
   tx@Dict /solidname known {
      l@pl@n solidname cvlit exch bind def
      /solidname solidname (_s) append store
   } if
   l@pl@n newplan
   gere_pstricks_opt
   /pl@n-en-cours false def
%   action ==
%   noir
   l@pl@n RotX RotY RotZ rotateOplan
%   l@pl@n CX CY CZ plantranslate
%   fontsize setfontsize
%   setTimes
   1 gere_pstfont
   solidplanmarks {l@pl@n projectionsifacevisible planmarks} if
   solidplangrid {linecolor l@pl@n projectionsifacevisible planquadrillage} if
   solidshowbase {l@pl@n projectionsifacevisible planshowbase} if
   solidshowbase3d {l@pl@n projectionsifacevisible planshowbase3d} if
} def


/pst-plan-normalpoint {
   /plan-@k false def
   norm2plan
   dup plan2eq /eqpl@n exch def
} def

/pst-plan-equation {
   /plan-@k false def
   dup isarray {
      dup /eqpl@n exch def
   } {
      2 copy pop /eqpl@n exch def
   } ifelse
   eq2plan 
} def

/pst-plan-solidface {
   /plan-@k false def
   solidface2plan
   CX isreal
   CX 0 eq and
   CY isreal and
   CY 0 eq and
   CZ isreal and
   CZ 0 eq and not {
      dup CX CY CZ planputorigine
   } if
   
%   dup plangetrange aload pop boum
%   dup origin planputorigine
   dup plan2eq /eqpl@n exch def
} def

/pst-geode {
   ngrid aload pop newgeode
   gere_pstricks_opt
} def

/pst-load {
   solidloadname 
%   /activationgestioncouleurs false def
   gere_pstricks_opt
} def

/pst-point {
gsave
   linecolor
   1 gere_pstfont
   action (none) eqstring not {
      args definition cvx exec point3d
   } if
   texte args definition cvx exec pos (text3d) append cvx exec
   tx@Dict /solidname known {
      args definition cvx exec
      solidname cvlit defpoint3d
      tx@Dict /solidname undef
   } if
grestore
} def

%% syntaxe : alpha beta r h newpie --> solid
/pst-pie {
   phi theta r h 
   ngrid length 2 ge {
      [ngrid 0 get ngrid 1 get]
   } if
   newpie
   gere_pstricks_opt
} def

/pst-trigospherique {
3 dict begin
gsave
   solidlinewidth setlinewidth
   linecolor
   linestyle
   args definition cvx exec
grestore
end
} def

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%         procedures pour \psProjection              %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/gere_pstricks_proj_opt {
      /planprojpst where {
         pop
         planprojpst projectionsifacevisible projpath
%        /planprojpst where pop /planprojpst undef
      } {
         /solidprojname where {
            /solidprojname get noface phi  
            xorigine 0 eq
            yorigine 0 eq and
            zorigine 0 eq and 
            xorigine isinteger not and
            yorigine isinteger not and
            yorigine isinteger not and {
            } {
               [xorigine yorigine zorigine] (                 ) astr2str 
            } ifelse
            projectionsifacevisible solidprojpath
         } {
            xorigine yorigine zorigine [ normale ] projectionsifacevisible planprojpath
         } ifelse
      } ifelse
} def

/proj-pst-chemin {
   solidlinewidth setlinewidth
   1 dict begin
   newpath
      /cercle {cercle_} def
      path
      linecolor
      gere_pstricks_proj_opt
   end
} def

/proj-pst-courbeR2 {
   l@pl@n plangetrange aload pop 
   setyrange setxrange
   newpath
      xmin ymin l@pl@n pointplan smoveto
      xmin ymax l@pl@n pointplan slineto
      xmax ymax l@pl@n pointplan slineto
      xmax ymin l@pl@n pointplan slineto
      xmin ymin l@pl@n pointplan slineto
      planprojpst projpath
   clip
   solidlinewidth setlinewidth
   newpath
      linecolor
      range aload pop { function cvx exec } CourbeR2_
      gere_pstricks_proj_opt
} def

/proj-pst-courbe {
   l@pl@n plangetrange aload pop 
   setyrange setxrange
   newpath
      xmin ymin l@pl@n pointplan smoveto
      xmin ymax l@pl@n pointplan slineto
      xmax ymax l@pl@n pointplan slineto
      xmax ymin l@pl@n pointplan slineto
      xmin ymin l@pl@n pointplan slineto
      planprojpst projpath
   clip
   solidlinewidth setlinewidth
   newpath
      linecolor
      range aload pop {} { function cvx exec } Courbeparam_
      gere_pstricks_proj_opt
} def

/proj-pst-point {
   [proj-args] length 0 eq {
      xorigine yorigine /proj-args defpoint
   } if
   /projname where {
      pop
      [proj-args proj-definition cvx exec]
      dup 0 getp projname cvlit defpoint
      dup length 2 gt {
         1 getp projname (0) append cvlit defpoint
      } if
      /projname where pop /projname undef
   } if
   proj-action (none) eqstring not {
      solidlinewidth setlinewidth
      linecolor
      [proj-args proj-definition cvx exec] 0 getp point_
      gere_pstricks_proj_opt
      Stroke
   } if
%   1 1 0 0 1 1 Diamond
   texte length 0 gt {
      proj-fontsize setfontsize
      %setTimes 
      solidlinewidth setlinewidth
      newpath
      linecolor
      texte [proj-args proj-definition cvx exec 0 0 phi neg rotatepoint] 0 getp 
      pos (text_) append cvx exec
%%    /planprojpst where {
%%       planprojpst dupplan dup phi rotateplan /planprojpst exch def
%%       pop
%%       xorigine yorigine
%%       0 0 phi neg rotatepoint
%%    } {
%%       0 0
%%    } ifelse
      %gere_pstricks_proj_opt
      planprojpst dupplan dup phi rotateplan projectionsifacevisible projpath
      Fill
   } if
} def

/proj-pst-vecteur {
   proj-action (none) eqstring not {
      planprojpst bprojscene
      solidlinewidth setlinewidth
      linestyle
      linecolor
      xorigine yorigine 2 copy proj-args proj-definition cvx exec addv drawvecteur
      eprojscene
   } if
   /projname where {
      pop
      proj-args proj-definition cvx exec projname cvlit defpoint
      /projname where pop /projname undef
   } if
} def

/proj-pst-droite {
   proj-action (none) eqstring not {
      l@pl@n plangetrange aload pop 
      setyrange setxrange
%%       newpath
%%          xmin ymin l@pl@n pointplan smoveto
%%          xmin ymax l@pl@n pointplan slineto
%%          xmax ymax l@pl@n pointplan slineto
%%          xmax ymin l@pl@n pointplan slineto
%%          xmin ymin l@pl@n pointplan smoveto
%% 	 planprojpst projpath
%%       clip
      planprojpst bprojscene
      solidlinewidth setlinewidth
      linestyle
      linecolor
      proj-args proj-definition cvx exec droite
      eprojscene
   } if
   /projname where {
      pop
      proj-args proj-definition cvx exec projname cvlit defdroite
      /projname where pop /projname undef
   } if
} def

/proj-pst-polygone {
   proj-action (none) eqstring not {
      l@pl@n plangetrange aload pop 
      setyrange setxrange
      newpath
         xmin ymin l@pl@n pointplan smoveto
         xmin ymax l@pl@n pointplan slineto
         xmax ymax l@pl@n pointplan slineto
         xmax ymin l@pl@n pointplan slineto
         xmin ymin l@pl@n pointplan slineto
	 planprojpst projpath
      clip
      solidlinewidth setlinewidth
      linestyle
      linecolor
      proj-definition length 0 eq {
         [proj-args]
      } {
         proj-args 
      } ifelse
      proj-definition cvx exec polygone_
      planprojpst projectionsifacevisible projpath
   } if
   /projname where {
      pop
      proj-definition length 0 eq {
         [proj-args]
      } {
         proj-args 
      } ifelse
      proj-definition cvx exec projname cvlit exch def
      /projname where pop /projname undef
   } if
} def

/proj-pst-cercle {
   /projname where {
      pop
      proj-args proj-definition cvx exec projname cvlit defcercle
      /projname where pop /projname undef
   } if
   proj-action (none) eqstring not {
      l@pl@n plangetrange aload pop 
      setyrange setxrange
%%       newpath
%%          xmin ymin l@pl@n pointplan smoveto
%%          xmin ymax l@pl@n pointplan slineto
%%          xmax ymax l@pl@n pointplan slineto
%%          xmax ymin l@pl@n pointplan slineto
%%          xmin ymin l@pl@n pointplan slineto
%% 	 planprojpst projpath
%%       clip
      solidlinewidth setlinewidth
      linestyle
      linecolor
      newpath
      range aload pop proj-args
      proj-definition cvx exec Cercle_
      planprojpst projectionsifacevisible projpath
   } if
} def

/proj-pst-line {
   proj-action (none) eqstring not {
      l@pl@n plangetrange aload pop 
      setyrange setxrange
%%       newpath
%%          xmin ymin l@pl@n pointplan smoveto
%%          xmin ymax l@pl@n pointplan slineto
%%          xmax ymax l@pl@n pointplan slineto
%%          xmax ymin l@pl@n pointplan slineto
%%          xmin ymin l@pl@n pointplan slineto
%%          planprojpst projpath
%%       clip
      planprojpst bprojscene
      solidlinewidth setlinewidth
      linestyle
      linecolor
      proj-definition length 0 eq {
         [proj-args]
      } {
         proj-args 
      } ifelse
      proj-definition cvx exec ligne
      eprojscene
   } if
   /projname where {
      pop
      proj-definition length 0 eq {
         [proj-args]
      } {
         proj-args 
      } ifelse
      proj-definition cvx exec projname cvlit exch def
      /projname where pop /projname undef
   } if
} def

/proj-pst-rightangle {
   proj-action (none) eqstring not {
      planprojpst bprojscene
      solidlinewidth setlinewidth
      linestyle
      linecolor
      proj-args proj-definition cvx exec angledroit
      eprojscene
   } if
} def

/proj-pst-texte {
2 dict begin
   proj-fontsize setfontsize
   %setTimes
   1 gere_pstfont
   solidlinewidth setlinewidth
   newpath
   linecolor
   texte 
   /planprojpst where {
      planprojpst dupplan dup phi rotateplan /planprojpst exch def
      pop
      xorigine yorigine
      0 0 phi neg rotatepoint
   } {
      0 0
   } ifelse
   pos (text_) append cvx exec
   gere_pstricks_proj_opt
Fill
end
} def

% END solides.pro
