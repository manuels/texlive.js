%% $Id: pst-solarsystem.pro 620 2012-01-01 14:09:57Z herbert $
%%
%% This is file `pst-solarsystem.pro',
%%
%% IMPORTANT NOTICE:
%%
%%  PostScript prologue for pst-solarsystem.tex
%%
%% Manuel Luque 
%% Herbert Voss 
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory CTAN:/macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-solarsystem' is a PSTricks package for plotting the solar system
%%                     for a specific date
%%
%% version 0.12 2012-01-01
%%
%%%% pst-solarsystem.pro ------------------------------------
/Pi 3.14159265359 def
/Rad2Deg tx@Dict begin /RadtoDeg load end bind def 
/Deg2Rad tx@Dict begin /DegtoRad load end bind def
%%%%%%%%%%  DATAS  ---------------------------------------------
% longitude moyenne
/merLM [4.402608842 26088.14707 5.305219e-4 3.098e-7] def
/venLM [3.176146696 10213.52942 5.521e-4 2.535e-7] def
/earLM [1.73470314 6283.319663 5.3001819e-4 3.69e-7] def
/marLM [6.203480913 3340.856278 5.4274843e-4 2.66e-7] def
/jupLM [0.5595464972 529.9348075 3.9049899e-4 4.37e-7] def
/satLM [0.8740167563 213.542926 9.067344e-4 -5.57e-8] def
% LP = longitude du périhélie
% terme KA = excentricité x cos(LP)
/merKA [0.044660598 -0.054483487 -0.01806305 0.000663185] def
/venKA [-0.004492821 -0.000923135 0.000225036 -0.000001441] def
/earKA [-0.003740816 -0.004793106 0.000281128 0.000073831] def
/marKA [0.085365603 0.013005053 0.004287376 -0.000259837] def
/jupKA [0.046985721 -0.001796949 -0.002042137 -0.000040262] def
/satKA [-0.002960036 -0.018813138 0.001283285 0.000384811] def
% terme HA = excentricité x sin(LP)
/merHA [0.200723314 0.012331538 -0.007334087 -0.000065185] def
/venHA [0.005066847 -0.001456941 -0.000058477 0.000022573] def
/earHA [0.01628447 -0.001532379 -0.000720171 0.000032299] def
/marHA [-0.037899732 0.02706276 0.002245677 -0.000451825] def
/jupHA [0.012003857 0.013628604 0.000042602 -0.000210827] def
/satHA [0.055429643 -0.004477771 -0.003261143 0.000200072] def
% terme Q
/merQ [0.040615634 -0.009342389 -0.000919439 0.000065185] def
/venQ [0.006824101 -0.004512949 -0.000118430 0.000017766] def
/earQ [0 0 0 0] def
/marQ [0.010470426 -0.001689431 -0.000082811 0.000003613] def
/jupQ [-0.002065611 -0.001905724 0.000108273 0.000008934] def
/satQ [-0.008717474 -0.002914183 0.000157351 0.000012382] def
% terme P
/merP [0.045635505 0.008527127 -0.000955462 -0.000067142] def
/venP [0.028822858 0.001158456 -0.000349201 -0.000008779] def
/earP [0 0 0 0] def
/marP [0.012284493 0.001371039 -0.000107356 -0.000002604] def
/jupP [0.011183772 -0.000839731 -0.000159489 0.000007916] def
/satP [0.019891473 -0.001633044 -0.000223323 0.000011193] def
% demi-grand axe en u.a.
/amer 0.38709830982 def
/aven 0.72332981996 def
/aear 1.0000101778 def
/amar 1.52367934191 def
/ajup {5.20260319132 1.913e-6 T mul add} def
/asat {9.55490959574 -2.139e-5 T mul add} def
%%%%%%%% Calculs -------------------------------------------
/Calc {aload pop T3 mul 3 -2 roll T2 mul 3 -2 roll T mul add add add} def
/orbitalparameters{
/P exch Calc def
/Q exch Calc def
/HA exch Calc def
/KA exch Calc def
/LM exch Calc Rad2Deg def
 LM 0 le {/LM LM LM neg 360 div round 360 mul add 360 add def} if
 LM 360 ge {/LM LM LM 360 div round 360 mul sub def} if
/LP HA KA atan def
/E HA LP sin div abs def
/AM LM LP sub def
 AM 360 ge {/AM AM 360 sub def} if
 AM 0 lt {/AM AM 360 add def} if
 /AE AM def
 10{/AETemp
  AM E Rad2Deg AE sin mul add def
  /AE AETemp def} repeat
 /AV AE 2 div sin AE 2 div cos div 1 E add 1
 E sub div sqrt mul 1 atan 2 mul def
 AV 360 gt {/AV AV AV 360 div floor  360 mul sub def} if
P 0 eq Q 0 eq and {
  /LO LP AV add def
   }{
 /LN P Q atan def
/APL LP AV add LN sub def
%%%%%%%%%% inclinaison de l'orbite --------------------
 /SINIO1 P LN sin div def
 /COSIO1 1 SINIO1 dup mul sub sqrt def
 /IO SINIO1 COSIO1 atan 2 mul def
 /SINLA1 IO sin APL sin mul def
 /COSLA1 1 SINLA1 dup mul sub sqrt def
%%%%%%%%%% latitude -----------------------------------
 /LA SINLA1 COSLA1 atan def
  LA 180 ge {/LA LA 360 sub def}if
 /COSLO1 APL cos LA cos div def
 /SINLO1 1 COSLO1 dup mul sub sqrt def
 /LO SINLO1 COSLO1 atan LN add def
 LA 0 lt {/LO 360  LO sub 2 LN mul add def} if
 } ifelse
 LO 360 gt {/LO LO 360 sub def} if
} def
%%%%% pour l'affichage des valeurs ----------------
/Times-Roman findfont
 100 scalefont
 setfont
 /MG 72 def
 /LigneSuivante
  { currentpoint 16 sub
  exch pop
  MG exch
  moveto } def
 /chaine 15 string def
 /affiche {chaine cvs show } def
