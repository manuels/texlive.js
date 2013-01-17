%% Characters of semaphore alphabet, METATYPE1 parametric file "smfr10.mp"
%%       family: roman, series: medium, shape: upper, size: 10pt;
%%       base part: pillar
%%
%% Znaky semaforove abecedy, parametricky soubor pro METATYPE1.
%%       rodina: roman, duktus: stredni, tvar: rovny, velikost: 10pt;
%%       zakladna: sloupek
%%
%% (c) Vit ZYKA, 1998-2008, vit.zyka@seznam.cz
%% 1998 1.0 metafont
%% 2008 1.1 metatype1 (sources for Type1 and OpenType)

input fontbase;

pf_info_fontname "Semafor-Regular";

boolean proportional; string center;

u:=100;                 % unit (=1/10 font size)
series:=1;              % series factor (1=medium)
slant:=0;               % slant factor (0=upper)
proportional:=true;     % font proportionality (false=nonproportial)
center="base_pillar";	% type of center part of character

beginfont

input semaf;

endfont.
