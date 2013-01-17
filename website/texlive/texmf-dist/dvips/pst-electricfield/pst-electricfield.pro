%% $Id: pst-electricfield.pro 479 2011-03-26 10:12:49Z herbert $
%%
%% This is file `pst-electricfield.pro',
%%
%% IMPORTANT NOTICE:
%%
%% Package `pst-electricfield.tex'
%% Jürgen Gilg
%% Manuel Luque
%% Patrice Megrét
%% Herbert Voss 
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-electricfield' is a PSTricks package to draw fields of charges
%%
%% version 0.05 / 2011-03-26  Herbert Voss <hvoss _at_ tug.org>
%%            
%
/tx@EFieldDict 60 dict def
tx@EFieldDict begin
%
% helper functions
/getX { xCoor exch get } def
/getY { yCoor exch get } def
/getQ { Qcharges exch get } def
% /getR { Radius exch get } def
%
/setValues {
  /xCoor [
    0 1 NoQ {
      /i exch def
      /qi QXYN i get def
      qi 1 get} for
  ] def
  /yCoor [
    0 1 NoQ {
    /i exch def
    /qi QXYN i get def
    qi 2 get} for
  ] def
} def
/Radius {xP i getX sub yP i getY sub Pyth} def
%
/fleche {
    gsave
    x2 y2 moveto
    y2 y1 sub x2 x1 sub atan rotate % 1 1 scale
    arrowscale 
    -1 CLW mul 2 CLW mul rlineto
     7 CLW mul -2 CLW mul rlineto
    -7 CLW mul -2 CLW mul rlineto
    closepath
    fill
    grestore
} def
%
%% syntaxe : any isbool --> booleen
/isbool { type (booleantype) cvn eq } def
%% syntaxe : any isinteger --> booleen
/isinteger { type (integertype) cvn eq } def
%
/drawChargeCircle { % qi x y r on the stack
  0 360 arc 
  gsave 
  0 ge {1}{0} ifelse setgray fill 
  grestore 
  0 setgray stroke
} def
%
/Electricfield {
  % extraction des donnees = qi, xi, yi, Ni, plotCharge
  /NoQ QXYN length 1 sub def % nombre de charges -1
  /NL [ % les lignes
    0 1 NoQ  {
      /i exch def
      /qi QXYN i get def
      qi length 3 eq 
        { /nL N def } 
        { qi 3 get dup isinteger
          { /nL ED }
          { pop /nL N def } ifelse } ifelse
      nL } for
  ] def
  /plotCharge [ % les lignes
    0 1 NoQ  {
      /i exch def
      /qi QXYN i get def
      qi length 3 eq 
        { /pC true def } 
        { qi length 4 eq 
          { qi 3 get dup isbool 
            { /pC ED } 
            { pop /pC true def } ifelse }
          { qi 4 get /pC ED } ifelse } ifelse
      pC } for
  ] def
  /Qcharges [ % les charges
  0 1 NoQ {
    /i exch def
    /qi QXYN i get def
    qi 0 get} for
  ] def
  setValues
  0 0 moveto
  /Lignes [ % on stroke dans un tableau toutes lignes
    0 1 NoQ {
      /iQ ED % on considere chacune des charges
      /dAngle 360 NL iQ get 1 sub div def
      /pasX iQ getQ 0 ge {Pas} {Pas neg} ifelse def
      /xStart iQ getX def
      /yStart iQ getY def
      [ 
        0 dAngle 360 dAngle sub {
          /iA ED % on en fait le tour
          /xP xStart pasX iA cos mul add def
          /yP yStart pasX iA sin mul add def
          [ NbrePoints { % nombre de points
            0 0
            0 1 NoQ { 
              /i ED
              i getQ xP i getX sub mul Radius 3 exp Div add exch
              i getQ yP i getY sub mul Radius 3 exp Div add exch
            } for
            /Ex ED  
            /Ey ED
            /NormeE Ex Ey Pyth def
            /dX Ex NormeE div pasX mul def
            /dY Ey NormeE div pasX mul def
            /xP xP dX add def /yP yP dY add def
            [ xP xUnit mul yP yUnit mul ]
          } repeat
         ]
       } for
     ]
    } for
  ] def
% on lit les tableaux et on dessine les lignes
  0 1 Lignes length 1 sub {
    /iQ ED % chaque charge
    /qi iQ getQ def
    /Lignes_Champ Lignes iQ get def
    0 1 Lignes_Champ length 1 sub {
      /iLi ED
      /Ligne_Champ Lignes_Champ iLi get def % une ligne
      Ligne_Champ 0 get aload pop moveto % xP yP
      1 1 Ligne_Champ length 1 sub {
        /iCompteur exch def
        Ligne_Champ iCompteur get aload pop lineto
      } for
      stroke
      % les fleches
      Ligne_Champ dup length 1 sub posArrow mul cvi get aload pop 
      /y1 ED
      /x1 ED
      Ligne_Champ dup length 1 sub posArrow mul cvi 1 add get aload pop 
      /y2 ED 
      /x2 ED
      /X1 x2 def 
      /X2 x1 def 
      /Y1 y2 def 
      /Y2 y1 def
      qi 0 le { /x1 X1 def /x2 X2 def /y1 Y1 def /y2 Y2 def} if
      fleche
    } for
  } for
  0 1 NoQ {
    /i exch def
    Qcharges i get dup /qi ED
    xCoor i get xUnit mul
    yCoor i get yUnit mul % now on stack: qi x y
    plotCharge i get % relative or absolute radii?
      { ChargeRadius qi abs mul drawChargeCircle }
      { ChargeRadius 0 gt 
        { ChargeRadius drawChargeCircle }
        { pop pop pop } ifelse } ifelse
  } for
} def % Electricfield
%
%
/Equipotential {
% extraction des donnees = qi, xi, yi,
  /NoQ QXYN length 1 sub def % nombre de charges -1
  /Qcharges [ % les charges
    0 1 NoQ {
      /i exch def
      /qi QXYN i get def
      qi 0 get} for
  ] def
  setValues
  /Func {
    0 
    0 1 NoQ {/i exch def
    /qi QXYN i get def
    qi 0 get
    Radius div add } for
    9 mul % V en volts q en nC
    V sub
  } def
  % code extrait de pst-func
  /xPixel xMax xMin sub xUnit mul round cvi def
  /yPixel yMax yMin sub yUnit mul round cvi def
  /dx xMax xMin sub xPixel div def
  /dy yMax yMin sub yPixel div def
  /setpixel {
    dy div exch
    dx div exch
    LW 2 div 0 360 arc fill 
  } bind def
%
  Vmin StepV Vmax {
    /V ED
    /VZ true def % suppose that F(x,y)>=0
    /xP xMin def 
    /yP yMin def 
    Func 0.0 lt { /VZ false def } if % first value
    xMin dx StepFactor mul xMax {
      /xP exch def
      yMin dy StepFactor mul yMax {
        /yP exch def
        Func 0 lt
          { VZ { xP yP setpixel /VZ false def} if }
          { VZ {}{ xP yP setpixel /VZ true def } ifelse } ifelse
      } for
    } for
%
    /xP xMin def /y yMin def Func 0.0 lt { /VZ false def } if % erster Wert
    yMin dy StepFactor mul yMax {
      /yP exch def
      xMin dx StepFactor mul xMax {
        /xP exch def
        Func 0 lt
          { VZ { xP yP setpixel /VZ false def} if }
          { VZ {}{ xP yP setpixel /VZ true def } ifelse } ifelse
      } for
    } for
  } for
} def % Equipotential 
%
end % tx@EFieldDict
%