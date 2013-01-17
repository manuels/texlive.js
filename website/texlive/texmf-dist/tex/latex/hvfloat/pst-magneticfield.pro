%% $Id: pst-magneticfield.pro 346 2010-06-11 06:12:08Z herbert $
%%
%% This is file `pst-magneticfield.pro',
%%
%% IMPORTANT NOTICE:
%%
%% Package `pst-magneticfield.tex'
%% JÃ¼rgen Gilg
%% Manuel Luque
%% Herbert Voss 
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-magneticfield' is a PSTricks package to draw fields of Helmholtz coils
%%
%% version 0.02 / 2010-06-11  Herbert Voss <hvoss _at_ tug.org>
%%            
%
/tx@MFieldDict 60 dict def
tx@MFieldDict begin
%
% helper functions
/setpixel { 1 0 360 arc fill } bind def 
%
/fleche {
  gsave
  x2 y2 moveto
  y2 y1 sub x2 x1 sub atan rotate % 1 1 scale
%  -1 CLW mul  2 CLW mul rlineto
%   7 CLW mul -2 CLW mul rlineto
%  -7 CLW mul -2 CLW mul rlineto
   1 CLW mul  2 CLW mul rlineto
  -7 CLW mul -2 CLW mul rlineto
   7 CLW mul -2 CLW mul rlineto
  closepath
  fill
  grestore
} def
%
/Calcul_B_Spires {
  /Bx 0 def
  /By 0 def
  1 1 NombreSpires { % on calcule le champ resultant de toutes les spires
    /iS ED % numero de la spire
    /yi yA iS 1 sub inter mul sub def % position de la spire
    /Bx0 {
      /arz {1 Radius xP add dup mul yP yi add dup mul add sqrt div} def
      yP yi add xP div arz mul
      EllipticK neg
      Radius dup mul xP dup mul add yP yi add dup mul add
      Radius xP sub dup mul yP yi add dup mul add div
      EllipticE mul
      add
      mul
    } def
    /By0 {
      /arz {1 Radius xP add dup mul yP yi add dup mul add sqrt div} def
      arz
      EllipticK
      Radius dup mul xP dup mul sub yP yi add dup mul sub
      Radius xP sub dup mul yP yi add dup mul add div
      EllipticE mul
      add
      mul
    } def
    AntiHelmholtz { iS 2 eq {/Bx0 Bx0 neg def /By0 By0 neg def} if } if
    /Bx Bx Bx0 add def
    /By By By0 add def
  } for
} def
/EllipticKE{
  /K {2 Radius xP mul sqrt mul arz mul} def
  /m1 {1 K dup mul sub} def
  /m2 {m1 dup mul} def
  /m3 {m2 m1 mul} def
  /m4 {m2 dup mul} def
  /m_1 {1 m1 div} def
  /EllipticK {
     0.5
     0.12498593597 m1 mul add
     0.06880248576 m2 mul add
     0.03328355376 m3 mul add
     0.00441787012 m4 mul add
     m_1 ln mul
     1.38629436112 add
     0.09666344259 m1 mul add
     0.03590092383 m2 mul add
     0.03742563713 m3 mul add
     0.01451196212 m4 mul add
  } def
  /EllipticE {
    0.24998368310 m1 mul
    0.09200180037 m2 mul add
    0.04069697526 m3 mul add
    0.00526449639 m4 mul add
    m_1 ln mul
    1 add
    0.44325141463 m1 mul add
    0.062606012206 m2 mul add
    0.04757383546 m3 mul add
    0.01736506451 m4 mul add
  } def
  Calcul_B_Spires
% au point Pi
  /xPi xP def
  /yPi yP def
  /NormeB Bx dup mul By dup mul add sqrt def
  /dX Bx NormeB div Pas mul def
  /dXi dX def
  /dY By NormeB div Pas mul def
  /dYi dY def
  /xCi xPi dX add def
  /yCi yPi dY add def
  /xP xCi def
  /yP yCi def
  Calcul_B_Spires
% au point C
  /NormeB Bx dup mul By dup mul add sqrt def
  /dX Bx NormeB div Pas mul def
  /dY By NormeB div Pas mul def
  /yP yPi dY dYi add 2 div add def
} def
%
%0 0 translate
%
/setValues { % on stack +1 or -1
  /yfactor ED /xfactor ED
  Ligne_Champ dup length 1 sub 1.5 div cvi get aload pop 
  yfactor 0 gt {
    /y2 exch yfactor mul def 
    /x2 exch xfactor mul def
  }{
    /y1 exch yfactor mul def 
    /x1 exch xfactor mul def
  } ifelse
  Ligne_Champ dup length 1 sub 1.5 div cvi 1 add get aload pop 
  yfactor 0 gt {
    /y1 exch yfactor mul def 
    /x1 exch xfactor mul def
  }{
    /y2 exch yfactor mul def 
    /x2 exch xfactor mul def
  } ifelse
} def
%
/Lignes_Champ {
  /Ligne_Champ [
    NbrePoints {%
      EllipticKE
        [ xP yP yUnit mul exch xUnit mul exch  ]
        trace 1 eq {By 0 lt Bx 0 lt and {exit} if} if
      AntiHelmholtz not {  xP xMax ge yP yMax ge or {exit} if } if
    } repeat
  ] def
%
  Ligne_Champ 0 get aload pop moveto % xP yP
  1 1 Ligne_Champ length 1 sub {
    /iCompteur exch def
    Ligne_Champ iCompteur get aload pop lineto
  } for
  stroke
% les flèches (xP,yP)
  1 1 setValues
  nCount 0 eq {/yAxe1 y1 def /yAxe2 y2 def} if
  fleche
%
  Ligne_Champ 0 get aload pop neg moveto % xP -yP
  1 1 Ligne_Champ length 1 sub {
    /iCompteur ED
    Ligne_Champ iCompteur get aload pop neg lineto
  } for
  stroke
  trace 1 eq {
% (xP,-yP)
    1 -1 setValues
    fleche
  } if
  Ligne_Champ 0 get aload pop exch neg exch moveto % -xP yP
  1 1 Ligne_Champ length 1 sub {
    /iCompteur ED
    Ligne_Champ iCompteur get aload pop exch neg exch  lineto
  } for
  stroke
% (-xP,yP)
    -1 1 setValues
    fleche
    Ligne_Champ 0 get aload pop exch neg exch neg moveto % -xP -yP
    1 1 Ligne_Champ length 1 sub {
      /iCompteur ED
      Ligne_Champ iCompteur get aload pop exch neg exch neg lineto
    } for
    stroke
    trace 1 eq {
% (-xP,-yP)
      -1 -1 setValues
      fleche
    } if
  } def
%
/MagneticField {
StreamDensityPlot {
  /Bmax 0 def
  /Pas PasB def
  % recherche du Bmax
  AntiHelmholtz {
    Radius 0.1 sub 0.1 Radius 1.5 mul {
      /xP exch def
      0 0.1 yMax {
        /yP exch def
        EllipticKE
        NormeB Bmax gt {/Bmax NormeB def} if
      } for
    }for
  }{
    0.01 0.1 Radius 0.1 sub  {
      /xP exch def
      0 0.1 yMax {
        /yP exch def
        EllipticKE
        NormeB Bmax gt {/Bmax NormeB def} if
      } for
    }for
  } ifelse
%/xP 0.001 def
%/yP 0 def
%EllipticKE
%/Bmax NormeB def
  /StepPixel 
    1 Unit div store
    gsave
    0.009 StepPixel xMax  {
      /xPos ED
      /xP xPos def
      0.009 StepPixel yMax {
        /yPos ED
        /yP yPos def
        EllipticKE
        /HB NormeB Bmax div store
        Setgray { /HB HB 25 mul round 25 div def } if % 25 niveaux de gris
        xPos xUnit mul yPos yUnit mul
        Setgray { HB setgray setpixel }{ HB 0.7 1 sethsbcolor setpixel } ifelse
        xPos xUnit mul neg yPos yUnit mul
        Setgray { HB  setgray }{ HB 0.7 1 sethsbcolor } ifelse setpixel
        xPos xUnit mul neg yPos yUnit mul neg
        Setgray { HB  setgray }{ HB 0.7 1 sethsbcolor } ifelse setpixel
        xPos xUnit mul yPos yUnit mul neg
        Setgray { HB  setgray }{ HB 0.7 1 sethsbcolor } ifelse setpixel
     } for
   }for
   grestore
} if
%  lignes de champ de l'ensemble de la bobine
  /trace 1 def
  /nCount 0 def
% 0.1 Radius mul StepLines Radius mul 0.9 Radius mul {
  StepLines StepLines Radius 1.5 StepLines mul sub {
    /NbrePoints NbrePointsB def
    /xStart ED
    /yStart 0 def
    /Pas PasB def
    /xP xStart def
    /yP yStart Pas sub def
    Lignes_Champ
    /nCount nCount 1 add def
  } for
    AntiHelmholtz not {
      % l'axe oriente de la bobine
      0 yMin yUnit mul moveto
      0 yMax yUnit mul lineto
      stroke
      /x1 0 def
      /y1 yAxe1 def
      /y2 yAxe2 def
      /x2 0 def
      fleche
      %/x1 0 def
      /y1 yAxe2 neg def
      /y2 yAxe1 neg def
      %/x2 0 def
      fleche } if
    % quelques lignes de champ autour de chaque spire
    /trace 0 def
    /increment 0.25 Radius mul def
    AntiHelmholtz { /Pas PasS def /NbrePoints NbrePointsS def } if
    nS { % nS lignes
      0 1 TS length 1 sub {
        /nTemp ED
        /iS TS nTemp get def % numero de la spire en partant du haut
        iS 0 eq { /iS 1 def } if % iS ne peut pas = 0
        iS NombreSpires gt { /iS NombreSpires def } if % iS ne peut pas > nbre spires
	/yi yA iS 1 sub inter mul sub def % position du centre de la spire
        AntiHelmholtz not { /NbrePoints NbrePointsS def /Pas PasS def } if
        /xStart Radius increment add def
        /yStart yi def
        /xP xStart def
        /yP yStart Pas sub def
        Lignes_Champ
      } for
      AntiHelmholtz { /NbrePoints NbrePoints 750 add def } if 
      /increment increment 0.2 Radius mul add def
    } repeat
} def % /MagneticField
end
%%
