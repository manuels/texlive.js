%% SEMAPHORE ALPHABET FONT, METAFONT driver file "semaf.mf"
%%
%% Font znaku semaforove abecedy, ridici soubor pro METAFONT.
%%
%% Copyright (C) 1998-2008 Vit ZYKA, vit.zyka@seznam.cz
%%
%% The SIL Open Font License (ofl)
%% This font is copyright but you are granted a license which gives you,
%% the "user" of the font, legal permission to copy, distribute,
%% and/or modify the font. However, if you modify the font you must
%% change the name of the font, unless you have the copyright holder's
%% permission to do otherwise.
%%
%% Please check the font's license before using the software.
%% http://scripts.sil.org/OFL
%%
%% 1998 1.0 metafont
%% 2008 1.1 metatype1 (sources for Type1 and OpenType)
%%

% ------------------------------------------------------- fontdimen parameters
pf_info_designsize 10pt;
designsize:=8pt;
pf_info_familyname "Semafor";
pf_info_author "Vit Zyka, OFL";
pf_info_version "2.0";
pf_info_space if proportional: 6u, 3u, 1.5u else: 10u, 0u, 0u fi; % base,stretch,shrink
pf_info_xheight 10u;
pf_info_quad if proportional: 12u else: 20u fi;
pf_info_extra_space if proportional: 5u else: 10u fi;
pf_info_capheight 10u;
pf_info_ascender 10u;
pf_info_descender 0u;
%pf_info_fixedpitch ;
%pf_info_stdvstem ;
%pf_info_stdhstem ;
%pf_info_forcebold ;
pf_info_adl 10u, 0, 0;
pf_info_overshoots (1000,10), (0, -10);
pf_info_encoding "ec";
pf_info_underline -2u, .4u;
%pf_info_overshoots (0, -o), (ht,o);
pf_info_weight if series=1: "Normal" else: "Bold" fi;
pf_info_pfm jobname, if series=1: 0 else: 1 fi, if slant=0: 0 else: 1 fi;
pf_info_creationdate;

u# := 1pt; % for kerning pairs !?!

if false:
font_identifier:="SEMAF";
font_coding_scheme:="TEX CS TEXT";
designsize := 10pt; %10u;
font_slant:=slant;               % fontdimen 1
font_height:=10u#;               %           5
if proportional:
  font_normal_space:=8u#;        %           2
  font_normal_stretch:=4u#;      %           3
  font_normal_shrink:=2u#;       %           4
  font_extra_space:=5u#;         %           7
  font_quad:=16u#;               %           6
else:
  font_normal_space:=10u#;       %           2
  font_normal_stretch:=0u#;      %           3
  font_normal_shrink:=0u#;       %           4
  font_extra_space:=10u#;        %           7
  font_quad:=20u#;               %           6
fi;
fi;

% ----------------------------------------------------------------------- CODE
L:=4.75u;     % left width
C:=1u;        % center width
R:=4.75u;     % right width
H:=10u;       % character height
HC:=H/2;      % center height
%% |width#|, |height#|, |WC#|, |HC#| (center width, height)
%% is evaluated in macro |beginchar|
%define_pixels(u,C);

% ----------------------------------------------------------------------- BASE
%def base_empty=
%  pickup pencircle scaled (series*1*u);
%  drawdot origin slanted slant;
%enddef;
def base_empty=
  default_nib := fix_nib( series*1*u, series*1*u, 0 );
  pen_stroke() (origin--(0,1)) (Pa10);
  Center := Pa10 slanted slant;
enddef;

%def base_pillar=
%  pickup pencircle scaled (series*1*u);
%  drawdot origin slanted slant;
%  pickup pencircle scaled (series*.2*u);
%  draw (origin--(0,-HC)) slanted slant;
%  draw ((-C,-HC)--(C,-HC)) slanted slant;
%enddef;
def base_pillar=
  default_nib := fix_nib( series*1*u, series*1*u, 0 );
  pen_stroke() (origin--(1,1)) (Pa10);
  default_nib := fix_nib( series*.2*u, series*.2*u, 0 );
  pen_stroke() (origin--(0,-HC-1)) (Pa11);
  pen_stroke() ((-C,-HC)--(C,-HC)) (Pa12);
  find_outlines(Pa11,Pa12)(Res);
  Pa13 := Res1;
  find_outlines(Pa13,Pa10)(Res);
  Center := Res1 slanted slant;
enddef;

%def base_person=
%  pickup pencircle scaled (series*1.2*u);
%  drawdot (0,.4*HC) slanted slant;
%  pickup pencircle scaled (series*.2*u);
%  draw ((0,.4*HC)--(0,-.2*HC)) slanted slant;
%  draw ((-.7C,-HC)--(0,-.2*HC)--(.7C,-HC)) slanted slant;
%enddef;
if false:
def base_person=
  default_nib := fix_nib( series*1.2u, series*1.2u, 0 );
  %pen_stroke() ((0,.4*HC)--(1,.4*HC)) (Pa10);
  pen_stroke() ((0,.4*HC)--(0,(.4*HC+1))) (Pa10);
  default_nib := fix_nib( series*.2u, series*.2u, 0 );
  pen_stroke() ((0,.4*HC)--(0,-.2*HC)) (Pa11);
  default_nib := fix_nib( series*.2u, series*.2u, 0 );
  pen_stroke() ((-.7C,-HC)--(0,-.2*HC)--(.7C,-HC)) (Pa12);
  find_outlines(Pa11,Pa12)(Res);
  Pa13 := Res1;
  find_outlines(Pa13,Pa10)(Res);
  Center := Res1 slanted slant;
  pen_stroke() (origin--(0,-.2*HC)) (Pa19);
  Center := Pa19;
enddef;
fi;
def base_person=
  default_nib := fix_nib( series*1.2u, series*1.2u, 0 );
  pen_stroke() ((0,.4*HC)--(0,(.4*HC+1))) (Pa10);
  default_nib := fix_nib( series*.51u, series*.51u, 0 );
  pen_stroke() ((0,.4*HC)--(0,-.3*HC)) (Pa11);
  default_nib := fix_nib( series*.3u, series*.3u, 0 );
  pen_stroke() ((-.7C,-HC)--(0,-.2*HC)--(.7C,-HC)) (Pa12);
  find_outlines(Pa11,Pa12)(Res);
  Pa13 := Res1;
  find_outlines(Pa10,Pa13)(Res);
  Pa14 := Res1;
  Center := Pa14 slanted slant;
enddef;

% ---------------------------------------------------------------------- FLAG
r:=if proportional: 4.5u else: 4.3u fi;        % flag radius
a:=1.5u;          % flag width
b:=1.8u;          % flag height
%def flag=
%  pickup pencircle scaled (series*.5*u);
%  draw (origin--(r,0)) withweight 2;
%  pickup pencircle scaled (series*.3*u);
%  unfill ((r,0)--(r-a,0)--(r-a,b)--cycle);
%  draw ((r-a,0)--(r-a,b)--(r,b)--(r,0));
%  fill ((r,0)--(r-a,b)--(r,b)--cycle);
%enddef;
def flag(expr angel,reverse_direction)=
  FlagCount := FlagCount + 1;
  Pa1 := origin--(r,0);
  default_nib := fix_nib( series*.5*u, series*.5*u, 0 );
  pen_stroke() (Pa1) (Pa2);
  Pa3 := (r-a,0)--(r-a,b)--(r,b)--(r,0);
  default_nib := fix_nib( series*.3*u, series*.3*u, 0 );
  pen_stroke() (Pa3) (Pa4);
  find_outlines(Pa2,Pa4)(Res);
  Pa5 := Res1 transformed currenttransform;
  Pa6 := ((r,0)--(r-a,0)--(r-a,b)--cycle) transformed currenttransform;
  if reverse_direction:
    Pa5 := reverse Pa5;
    Pa6 := reverse Pa6;
  fi;
  FlagFill[FlagCount] := Pa5;
  FlagUnfill[FlagCount] := Pa6;
enddef;
def flagL(expr angel)=
  begingroup;
    save currenttransform; transform currenttransform;
    currenttransform:= identity rotated angel slanted slant;
    flag(angel,false);
  endgroup;
enddef;
def flagR(expr angel)=
  begingroup;
    save currenttransform; transform currenttransform;
    currenttransform:= identity reflectedabout ((0,0),(1,0))
        rotated angel slanted slant;
    flag(angel,true);
  endgroup;
enddef;

uu:=0.95;       % upper portion of |L#| (|R#|)
bb:=0.8;        % botton
dd:=0.55;       % character d

def charA=
  if SL<(uu*L): SL:= bb*L fi;
  flagL(-135);
enddef;

def charB=
  SL:= L;
  flagL(180);
enddef;

def charC=
  if SL<L: SL:= uu*L fi;
  SH:= H;
  flagL(135);
enddef;

def charD=
  if SL<(bb*L): SL:= dd*L; fi;
  charic:= slant*HC;
  SH:= H;
  flagL(90);
enddef;

def charE=
  if SR<R: SR:= uu*R fi;
  SH:= H;
  if charic=0: charic:=.5*slant*HC fi;
  flagR(45);
enddef;

def charF=
  SR:= R;
  flagR(0);
enddef;

def charG=
  if SR<(uu*R): SR:= bb*R fi;
  flagR(-45);
enddef;

%def sipka(expr length, direct, point)=
%  begingroup
%    save x,y;
%    z1=origin; x2=x3=-length; -y2=y3=3/7length;
%    draw (z2..{dir 5}z1) rotated direct shifted point slanted slant;
%    draw (z3..{dir -5}z1) rotated direct shifted point slanted slant;
%  endgroup
%enddef;
def sipka(expr length, direct, point)=
  begingroup
    save x,y;
    z1=origin; x2=x3=-length; -y2=y3=3/7length;
    %draw (z2..{dir 5}z1) rotated direct shifted point slanted slant;
    %draw (z3..{dir -5}z1) rotated direct shifted point slanted slant;
    ((z2..{dir 5}z1{dir 175}..z3) rotated direct shifted point)
  endgroup
enddef;
def sipkaL(expr length, direct, point)=
  begingroup
    save x,y;
    z1=origin; x2=x3=-length; -y2=y3=3/7length;
    ((z3..{dir -5}z1) rotated direct shifted point)
  endgroup
enddef;
def sipkaR(expr length, direct, point)=
  begingroup
    save x,y;
    z1=origin; x2=x3=-length; -y2=y3=3/7length;
    ((z2..{dir 5}z1) rotated direct shifted point)
  endgroup
enddef;

% ------------------------------------ extensions tokens into begin and end char
extra_beginglyph:=
  %"width:=10u; height:=10u; WC:=5u; HC:=5u;" &
  "SL:= 0.75u; SR:= 0.75u; SH:= HC+(C/2);" &
  %"u=u#; HC=HC#; WC=WC#; C=C#;" &
  "path Pa[], Res[], Center, FlagFill[], FlagUnfill[];" &
  "numeric FlangCount;" &
  %"transform currenttransform;" &
  "scantokens center;";
%extra_endglyph:=
%  "if proportional:" &
%    "WC:= (C/2)+SL;" &
%    "charwd:= SL+C+SR; charht:= SH; chardp:= 0u;" &
%  "else:" &
%    "charwd:= L+(C/2)+R; WC:= charwd/2; charht:= SH; chardp:= 0u;" &
%  "fi;" &
%  %"w:=hround(charwd*hppp); h:=vround(charht*hppp); d:= vround(chardp*hppp);" &
%  "w:=charwd*hppp; h:=charht*hppp; d:= chardp*hppp;" &
%  %"define_pixels( WC, HC);" &
%  "currentpicture:= currentpicture shifted (WC,HC);" &
%  %fix_hstem(band,pa1,pa2,pa3,pb,pe) y<3band;
%  %fix_vstem(band,pa1,pa2,pa3,pb,pe) abs(x-1/2size)>3band;
%  %ghost_stem top;
%  "fix_hsbw(size,0,0);";

def Beginglyph(expr glname) =
  encode (glname) (ASCII glname); introduce glname (utilize) (0) ();
  beginglyph(glname);
  FlagCount := 0;
enddef;

def BeginGlyph(expr glname,glnumber) =
  encode (glname) (glnumber); introduce glname (utilize) (0) ();
  beginglyph(glname);
  FlagCount := 0;
enddef;

def Endglyph=
  if proportional:
    charwd:= SL+C+SR; charht:= SH; chardp:= 0u;
    WC:= (C/2)+SL;
  else:
    charwd:= L+(C/2)+R; charht:= SH; chardp:= 0u;
    WC:= charwd/2;
  fi;

  Pa40 := Center;
  for i:=1 upto FlagCount: 
    find_outlines(Pa40,FlagFill[i])(Res);
    Pa40 := Res1;
  endfor;
  Fill Pa40 shifted (WC,HC);

  for i:=1 upto FlagCount:
    unFill FlagUnfill[i] shifted (WC,HC);
  endfor;

  %"w:=hround(charwd*hppp); h:=vround(charht*hppp); d:= vround(chardp*hppp);
  w:=charwd*hppp; h:=charht*hppp; d:= chardp*hppp;
  %"define_pixels( WC, HC);
  %fix_hstem(Pa40)(1,2);
  %fix_vstem(Pa40);
  %ghost_stem top;
  fix_hsbw(charwd,0,0);

  endglyph;
enddef;

% ------------------------------------------------------------ lowercase letter
Beginglyph("a");
  charA;
Endglyph;

Beginglyph("b");
  charB;
Endglyph;

Beginglyph("c");
  charC;
Endglyph;

Beginglyph("d");
  charD;
Endglyph;

Beginglyph("e");
  charE;
Endglyph;

Beginglyph("f");
  charF;
Endglyph;

Beginglyph("g");
  charG;
Endglyph;

Beginglyph("h");
  charA; charB;
Endglyph;

Beginglyph("i");
  charA; charC;
Endglyph;

Beginglyph("k");
  charA; charD;
Endglyph;

Beginglyph("l");
  charA; charE;
Endglyph;

Beginglyph("m");
  charA; charF;
Endglyph;

Beginglyph("n");
  charA; charG;
Endglyph;

Beginglyph("o");
  charB; charC;
Endglyph;

Beginglyph("p");
  charB; charD;
Endglyph;

Beginglyph("q");
  charB; charE;
Endglyph;

Beginglyph("r");
  charB; charF;
Endglyph;

Beginglyph("s");
  charB; charG;
Endglyph;

Beginglyph("t");
  charC; charD;
Endglyph;

Beginglyph("u");
  charC; charE;
Endglyph;

Beginglyph("y");
  charC; charF;
Endglyph;

Beginglyph("j");
  charD; charF;
Endglyph;

Beginglyph("v");
  charD; charG;
Endglyph;

Beginglyph("w");
  charE; charF;
Endglyph;

Beginglyph("x");
  charE; charG;
Endglyph;

Beginglyph("z");
  charF; charG;
Endglyph;

% -------------------------------------------------------------- capital letter
%if false:

Beginglyph("A");
  charA;
Endglyph;

Beginglyph("B");
  charB;
Endglyph;

Beginglyph("C");
  charC;
Endglyph;

Beginglyph("D");
  charD;
Endglyph;

Beginglyph("E");
  charE;
Endglyph;

Beginglyph("F");
  charF;
Endglyph;

Beginglyph("G");
  charG;
Endglyph;

Beginglyph("H");
  charA; charB;
Endglyph;

Beginglyph("I");
  charA; charC;
Endglyph;

Beginglyph("K");
  charA; charD;
Endglyph;

Beginglyph("L");
  charA; charE;
Endglyph;

Beginglyph("M");
  charA; charF;
Endglyph;

Beginglyph("N");
  charA; charG;
Endglyph;

Beginglyph("O");
  charB; charC;
Endglyph;

Beginglyph("P");
  charB; charD;
Endglyph;

Beginglyph("Q");
  charB; charE;
Endglyph;

Beginglyph("R");
  charB; charF;
Endglyph;

Beginglyph("S");
  charB; charG;
Endglyph;

Beginglyph("T");
  charC; charD;
Endglyph;

Beginglyph("U");
  charC; charE;
Endglyph;

Beginglyph("Y");
  charC; charF;
Endglyph;

Beginglyph("J");
  charD; charF;
Endglyph;

Beginglyph("V");
  charD; charG;
Endglyph;

Beginglyph("W");
  charE; charF;
Endglyph;

Beginglyph("X");
  charE; charG;
Endglyph;

Beginglyph("Z");
  charF; charG;
Endglyph;

%fi;

% --------------------------------------------------- accented letters (in EC)
BeginGlyph("Abreve", 128);
  charA;
Endglyph;

BeginGlyph("Aogonek", 129);
  charA;
Endglyph;

BeginGlyph("Cacute", 130);
  charC;
Endglyph;

BeginGlyph("Ccaron", 131);
  charC;
Endglyph;

BeginGlyph("Dcaron", 132);
  charD;
Endglyph;

BeginGlyph("Ecaron", 133);
  charE;
Endglyph;

BeginGlyph("Eogonek", 134);
  charE;
Endglyph;

BeginGlyph("Gbreve", 135);
  charG;
Endglyph;

BeginGlyph("Lacute", 136);
  charA; charE;
Endglyph;

BeginGlyph("Lcaron", 137);
  charA; charE;
Endglyph;

BeginGlyph("Lslash", 138);
  charA; charE;
Endglyph;

BeginGlyph("Nacute", 139);
  charA; charG;
Endglyph;

BeginGlyph("Ncaron", 140);
  charA; charG;
Endglyph;

BeginGlyph("Ohungarumlaut", 142);
  charB; charC;
Endglyph;

BeginGlyph("Racute", 143);
  charB; charF;
Endglyph;

BeginGlyph("Rcaron", 144);
  charB; charF;
Endglyph;

BeginGlyph("Sacute", 145);
  charB; charG;
Endglyph;

BeginGlyph("Scaron", 146);
  charB; charG;
Endglyph;

BeginGlyph("Scedilla", 147);
  charB; charG;
Endglyph;

BeginGlyph("Tcaron", 148);
  charC; charD;
Endglyph;

BeginGlyph("Tcedilla", 149);
  charC; charD;
Endglyph;

BeginGlyph("Uhungarumlaut", 150);
  charC; charE;
Endglyph;

BeginGlyph("Uring", 151);
  charC; charE;
Endglyph;

BeginGlyph("Ydieresis", 152);
  charC; charF;
Endglyph;

BeginGlyph("Zacute", 153);
  charF; charG;
Endglyph;

BeginGlyph("Zcaron", 154);
  charF; charG;
Endglyph;

BeginGlyph("Zdotaccent", 155);
  charF; charG;
Endglyph;

BeginGlyph("Idotaccent", 157);
  charA; charC;
Endglyph;

BeginGlyph("dcroat", 158);
  charD;
Endglyph;

BeginGlyph("abreve", 160);
  charA;
Endglyph;

BeginGlyph("aogonek", 161);
  charA;
Endglyph;

BeginGlyph("cacute", 162);
  charC;
Endglyph;

BeginGlyph("ccaron", 163);
  charC;
Endglyph;

BeginGlyph("dcaron", 164);
  charD;
Endglyph;

BeginGlyph("ecaron", 165);
  charE;
Endglyph;

BeginGlyph("eogonek", 166);
  charE;
Endglyph;

BeginGlyph("gbreve", 167);
  charG;
Endglyph;

BeginGlyph("lacute", 168);
  charA; charE;
Endglyph;

BeginGlyph("lcaron", 169);
  charA; charE;
Endglyph;

BeginGlyph("lslash", 170);
  charA; charE;
Endglyph;

BeginGlyph("nacute", 171);
  charA; charG;
Endglyph;

BeginGlyph("ncaron", 172);
  charA; charG;
Endglyph;

BeginGlyph("ohungarumlaut", 174);
  charB; charC;
Endglyph;

BeginGlyph("racute", 175);
  charB; charF;
Endglyph;

BeginGlyph("rcaron", 176);
  charB; charF;
Endglyph;

BeginGlyph("sacute", 177);
  charB; charG;
Endglyph;

BeginGlyph("scaron", 178);
  charB; charG;
Endglyph;

BeginGlyph("scedilla", 179);
  charB; charG;
Endglyph;

BeginGlyph("tcaron", 180);
  charC; charD;
Endglyph;

BeginGlyph("tcedilla", 181);
  charC; charD;
Endglyph;

BeginGlyph("uhungarumlaut", 182);
  charC; charE;
Endglyph;

BeginGlyph("uring", 183);
  charC; charE;
Endglyph;

BeginGlyph("ydieresis", 184);
  charC; charF;
Endglyph;

BeginGlyph("zacute", 185);
  charF; charG;
Endglyph;

BeginGlyph("zcaron", 186);
  charF; charG;
Endglyph;

BeginGlyph("zdotaccent", 187);
  charF; charG;
Endglyph;

BeginGlyph("Agrave", 192);
  charA;
Endglyph;

BeginGlyph("Aacute", 193);
  charA;
Endglyph;

BeginGlyph("Acircumflex", 194);
  charA;
Endglyph;

BeginGlyph("Atilde", 195);
  charA;
Endglyph;

BeginGlyph("Adieresis", 196);
  charA;
Endglyph;

BeginGlyph("Aring", 197);
  charA;
Endglyph;

BeginGlyph("Ccedilla", 199);
  charC;
Endglyph;

BeginGlyph("Egrave", 200);
  charE;
Endglyph;

BeginGlyph("Eacute", 201);
  charE;
Endglyph;

BeginGlyph("Ecircumflex", 202);
  charE;
Endglyph;

BeginGlyph("Edieresis", 203);
  charE;
Endglyph;

BeginGlyph("Igrave", 204);
  charA; charC;
Endglyph;

BeginGlyph("Iacute", 205);
  charA; charC;
Endglyph;

BeginGlyph("Icircumflex", 206);
  charA; charC;
Endglyph;

BeginGlyph("Idieresis", 207);
  charA; charC;
Endglyph;

BeginGlyph("Ntilde", 209);
  charA; charG;
Endglyph;

BeginGlyph("Ograve", 210);
  charB; charC;
Endglyph;

BeginGlyph("Oacute", 211);
  charB; charC;
Endglyph;

BeginGlyph("Ocircumflex", 212);
  charB; charC;
Endglyph;

BeginGlyph("Otilde", 213);
  charB; charC;
Endglyph;

BeginGlyph("Odieresis", 214);
  charB; charC;
Endglyph;

BeginGlyph("Oslash", 216);
  charB; charC;
Endglyph;

BeginGlyph("Ugrave", 217);
  charC; charE;
Endglyph;

BeginGlyph("Uacute", 218);
  charC; charE;
Endglyph;

BeginGlyph("Ucircumflex", 219);
  charC; charE;
Endglyph;

BeginGlyph("Udieresis", 220);
  charC; charE;
Endglyph;

BeginGlyph("Yacute", 221);
  charC; charF;
Endglyph;

BeginGlyph("agrave", 224);
  charA;
Endglyph;

BeginGlyph("aacute", 225);
  charA;
Endglyph;

BeginGlyph("acircumflex", 226);
  charA;
Endglyph;

BeginGlyph("atilde", 227);
  charA;
Endglyph;

BeginGlyph("adieresis", 228);
  charA;
Endglyph;

BeginGlyph("aring", 229);
  charA;
Endglyph;

BeginGlyph("ccedilla", 231);
  charC;
Endglyph;

BeginGlyph("egrave", 232);
  charE;
Endglyph;

BeginGlyph("eacute", 233);
  charE;
Endglyph;

BeginGlyph("ecircumflex", 234);
  charE;
Endglyph;

BeginGlyph("edieresis", 235);
  charE;
Endglyph;

BeginGlyph("igrave", 236);
  charA; charC;
Endglyph;

BeginGlyph("iacute", 237);
  charA; charC;
Endglyph;

BeginGlyph("icircumflex", 238);
  charA; charC;
Endglyph;

BeginGlyph("idieresis", 239);
  charA; charC;
Endglyph;

BeginGlyph("ntilde", 241);
  charA; charG;
Endglyph;

BeginGlyph("ograve", 242);
  charB; charC;
Endglyph;

BeginGlyph("oacute", 243);
  charB; charC;
Endglyph;

BeginGlyph("ocircumflex", 244);
  charB; charC;
Endglyph;

BeginGlyph("otilde", 245);
  charB; charC;
Endglyph;

BeginGlyph("odieresis", 246);
  charB; charC;
Endglyph;

BeginGlyph("oslash", 248);
  charB; charC;
Endglyph;

BeginGlyph("ugrave", 249);
  charC; charE;
Endglyph;

BeginGlyph("uacute", 250);
  charC; charE;
Endglyph;

BeginGlyph("ucircumflex", 251);
  charC; charE;
Endglyph;

BeginGlyph("udieresis", 252);
  charC; charE;
Endglyph;

BeginGlyph("yacute", 253);
  charC; charF;
Endglyph;

if false:

BeginGlyph("Agrave", 152);
  charA;
Endglyph;

BeginGlyph("Lcaron", 165);
  charA; charE;
Endglyph;

BeginGlyph("Scaron", 169);
  charB; charG;
Endglyph;

BeginGlyph("Tcaron", 171);
  charC; charD;
Endglyph;

BeginGlyph("Zcaron", 174);
  charF; charG;
Endglyph;

BeginGlyph("lcaron", 181);
  charA; charE;
Endglyph;

BeginGlyph("agrave", 184);
  charA;
Endglyph;

BeginGlyph("scaron", 185);
  charB; charG;
Endglyph;

BeginGlyph("tcaron", 187);
  charC; charD;
Endglyph;

BeginGlyph("zcaron", 190);
  charF; charG;
Endglyph;

BeginGlyph("Racute", 192);
  charB; charF;
Endglyph;

BeginGlyph("Aacute", 193);
  charA;
Endglyph;

BeginGlyph("Adieresis", 196);
  charA;
Endglyph;

BeginGlyph("Lacute", 197);
  charA; charE;
Endglyph;

BeginGlyph("Ccaron", 200);
  charC;
Endglyph;

BeginGlyph("Eacute", 201);
  charE;
Endglyph;

BeginGlyph("Ecaron", 204);
  charE;
Endglyph;

BeginGlyph("Iacute", 205);
  charA; charC;
Endglyph;

BeginGlyph("Dcaron", 207);
  charD;
Endglyph;

BeginGlyph("Ncaron", 210);
  charA; charG;
Endglyph;

BeginGlyph("Oacute", 211);
  charB; charC;
Endglyph;

BeginGlyph("Ocircumplex", 212);
  charB; charC;
Endglyph;

BeginGlyph("Odieresis", 214);
  charB; charC;
Endglyph;

BeginGlyph("Rcaron", 216);
  charB; charF;
Endglyph;

BeginGlyph("Uring", 217);
  charC; charE;
Endglyph;

BeginGlyph("Uacute", 218);
  charC; charE;
Endglyph;

BeginGlyph("Udieresis", 220);
  charC; charE;
Endglyph;

BeginGlyph("Yacute", 221);
  charC; charF;
Endglyph;

BeginGlyph("racute", 224);
  charB; charF;
Endglyph;

BeginGlyph("aacute", 225);
  charA;
Endglyph;

BeginGlyph("adieresis", 228);
  charA;
Endglyph;

BeginGlyph("lacute", 229);
  charA; charE;
Endglyph;

BeginGlyph("ccaron", 232);
  charC;
Endglyph;

BeginGlyph("eacute", 233);
  charE;
Endglyph;

BeginGlyph("ecaron", 236);
  charE;
Endglyph;

BeginGlyph("iacute", 237);
  charA; charC;
Endglyph;

BeginGlyph("dcaron", 239);
  charD;
Endglyph;

BeginGlyph("ncaron", 242);
  charA; charG;
Endglyph;

BeginGlyph("oacute", 243);
  charB; charC;
Endglyph;

BeginGlyph("ocircumplex", 244);
  charB; charC;
Endglyph;

BeginGlyph("odieresis", 246);
  charB; charC;
Endglyph;

BeginGlyph("rcaron", 248);
  charB; charF;
Endglyph;

BeginGlyph("uring", 249);
  charC; charE;
Endglyph;

BeginGlyph("uacute", 250);
  charC; charE;
Endglyph;

BeginGlyph("udieresis", 252);
  charC; charE;
Endglyph;

BeginGlyph("yacute", 253);
  charC; charF;
Endglyph;

fi;

% --------------------------------------------------------------------- digits
%if false:

Beginglyph("1");
  charA;
Endglyph;

Beginglyph("2");
  charB;
Endglyph;

Beginglyph("3");
  charC;
Endglyph;

Beginglyph("4");
  charD;
Endglyph;

Beginglyph("5");
  charE;
Endglyph;

Beginglyph("6");
  charF;
Endglyph;

Beginglyph("7");
  charG;
Endglyph;

Beginglyph("8");
  charA; charB;
Endglyph;

Beginglyph("9");
  charA; charC;
Endglyph;

Beginglyph("0");
  charA; charD;
Endglyph;

%fi;

% ---------------------------------------------------------- special characters
BeginGlyph("space",32);             % space
  glyph_width  := if proportional: 6u else: 10u fi; %L+C+R;
  glyph_height := 0;
  glyph_depth  := 0;
  glyph_shift  := 0;
  %fix_hsbw(glyph_width,0,0);
endglyph;

BeginGlyph("asterisk",42);                  % all flag positions (asterisk)
  charA; charB; charC; charD; charE; charF; charG;
Endglyph;

BeginGlyph("period",46);                  % separator (period)
  begingroup;
    save currenttransform; transform currenttransform;
    currenttransform:= identity rotated -90 slanted slant;
    flag(-90,false);
    currenttransform:= identity reflectedabout ((0,0),(1,0))
        rotated -90 slanted slant;
    %flag(-90,true);
  endgroup;
  SL:= L; SR:= R;
  if proportional:
    charwd:= SL+C+SR; charht:= SH; chardp:= 0u; WC:= (C/2)+SL;
  else:
    charwd:= L+(C/2)+R; charht:= SH; chardp:= 0u; WC:= charwd/2;
  fi;
  k:= (r-a)++b;
  default_nib := fix_nib( series*.2u, series*.2u, 0 );
  z1=(0,-k) rotated -50; z2=(0,-k) rotated 50;
  %draw (z1..(-k,0)..(0,k)..(k,0)..z2) slanted slant;
  pen_stroke() (z1..(-k,0)..(0,k)..(k,0)..z2) (Pa20);
  Pa21 := sipka( 2/5b, -50-5, z1);
  pen_stroke() (Pa21) (Pa23);
  Pa25 := sipka( 2/5b, 180+50+5, z2);
  pen_stroke() (Pa25) (Pa27);
  find_outlines(Pa20,Pa23)(Res);
  Pa29 := Res1;
  find_outlines(Pa29,Pa27)(Res);
  %Fill Res1 slanted slant shifted (WC,HC);
  Fill Pa23 slanted slant shifted (WC,HC);
  Fill Pa27 slanted slant shifted (WC,HC);
  Fill Pa20 slanted slant shifted (WC,HC);

  %if proportional:
  %  charwd:= SL+C+SR; charht:= SH; chardp:= 0u; WC:= (C/2)+SL;
  %else:
  %  charwd:= L+(C/2)+R; charht:= SH; chardp:= 0u; WC:= charwd/2;
  %fi;
  %
  %Pa40 := Center;
  %for i:=1 upto FlagCount: 
  %  find_outlines(Pa40,FlagFill[i])(Res);
  %  Pa40 := Res1;
  %endfor;
  %Fill Pa40 shifted (WC,HC);
  %
  %fix_hsbw(charwd,0,0);
%endglyph;
Endglyph;

BeginGlyph("tilda",126);                  % mistake
  charC; charG;
Endglyph;

BeginGlyph("dollar",36);                  % begin digits
  charD; charE;
Endglyph;

BeginGlyph("numbersign",35);                  % end digits
  charD; charF;
Endglyph;

% ------------------------------------------------------ kernings and ligatures
boolean old_lig; old_lig := false;
if old_lig:

def chars="a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
  "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
  "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", % #52
  %152, 165, 169, 171, 174, 181, 184, 185, 187, 190, 192, 193, 196, 197,
  %200, 201, 204, 205, 207, 210, 211, 212, 214, 216, 217, 218, 220, 221,
  %224, 225, 228, 229, 232, 233, 236, 237, 239, 242, 243, 244, 246, 248,
  %249, 250, 252, 253
  224,225,227,228,192,193,195,196, % A 128 129 160 161 197 229 226 194
  130,131,162,163, % C 199 231
  132,164, % D 158
  133,165,200,201,203,232,233,235, % E 134 166 202 234
  % G 135 167
  157,204,205,236,237, % I 206 207 239 238
  136,137,168,169, % L 138 170
  140,172,209,241, % N 139 171 #43
  142,174,210,211,214,216,242,243,246,248, % O 212 213 244 245
  143,144,175,176, % R
  145,146,177,178, % S 147 179
  148,180, % T 149 181
  150,151,182,183,217,218,220,249,250,252, % U 219 251
  152,184,221,253, % Y
  153,154,185,186 % Z 155 187 #42
enddef;
def digits="1", "2", "3", "4", "5", "6", "7", "8", "9", "0" enddef;
def chars_tr="e", "l", "q", "u", 36, "E", "L", "Q", "U",
  %165, 181, 197, 201, 204, 217, 218, 220, 229, 233, 236, 249, 250, 252
  133,165,200,201,203,232,233,235, % E
  136,137,138,168,169,170, % L
  150,151,182,183,217,218,219,220,249,250,251,252 % U
enddef;
def chars_br="g", "n", "s", 126, "v", "G", "N", "S", "V",
  %169, 185, 210, 242
  % G
  140,172,209,241, % N
  145,146,177,178 % S
enddef;
def digits_tr="5" enddef;
def digits_br="7" enddef;
def chars_nr="a", "b", "c", "d", "f", "h", "i", "j", "k", "m",
  "o", "p", "r", "t", "w", "x", "y", "z",
  "A", "B", "C", "D", "F", "H", "I", "J", "K", "M",
  "O", "P", "R", "T", "W", "X", "Y", "Z",
  %152, 171, 174, 184, 187, 190, 192, 193, 196, 200, 205, 207, 211, 212,
  %214, 216, 221, 224, 225, 228, 232, 237, 239, 243, 244, 246, 248, 253
  224,225,227,228,192,193,195,196, % A
  130,131,162,163, % C
  132,164, % D
  157,204,205,236,237, % I
  142,174,210,211,214,216,242,243,245,248, % O
  143,144,175,176, % R
  148,180, % T
  152,184,221,253, % Y
  153,154,185,186 % Z
enddef;
def digits_nr="1", "2", "3", "4", "6", "8", "9", "0" enddef;
def tr=chars_tr, digits_tr enddef;
def br=chars_br, digits_br enddef;
def tl="c", "t", "u", "y", 126, "C", "T", "U", "Y", "3",
  %171, 187, 200, 217, 218, 220, 221, 232, 249, 250, 252, 253
  130,131,162,163, % C
  148,180, % T
  150,151,182,183,217,218,220,249,250,252, % U
  152,184,221,253 % Y
enddef;
def bl="a", "l", "m", "n", "A", "L", "M", "N", "1",
  %152, 165, 181, 184, 193, 196, 197, 210, 225, 228, 229, 242
  224,225,227,228,192,193,195,196, % A  
  136,137,168,169, % L
  140,172,209,241 % N
enddef;
def td="d", 36, "j", "v", "D", "J", "V", "4",
  %207, 239
  132,164 % D
enddef;
boundarychar:=1;

ligtable for i=chars_tr: i: endfor for i=digits: i|=:|>>36, endfor skipto 1;
ligtable for i=digits_tr: i: endfor for i=chars: i|=:|>>35, endfor
  1|=:|35, skipto 1;
ligtable 1:: if proportional: for i=bl: i kern-1u#, endfor fi 32 kern 0u#;
ligtable for i=chars_br: i: endfor for i=digits: i|=:|>>36, endfor skipto 2;
ligtable for i=digits_br: i: endfor for i=chars: i|=:|>>35, endfor
  1|=:|35, skipto 2;
ligtable 2:: if proportional: for i=tl: i kern-1u#, endfor
  for i=td: i kern-.5u#, endfor fi 32 kern 0u#;
ligtable for i=chars_nr: i: endfor for i=digits: i|=:|>>36, endfor
  32|=:>32;
ligtable for i=digits_nr: i: endfor for i=chars: i|=:|>>35, endfor
  1|=:|35;
ligtable ||: for i=digits: i|=:|>>36, endfor 32|=:>32;

else: % ------------------ new lig

def Chars="a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
  "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
  "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
  "Abreve", "Aogonek", "abreve", "aogonek", "agrave", "aacute", "acircumflex", "atilde", "adieresis", "aring",
  "Agrave", "Aacute", "Acircumflex", "Atilde", "Adieresis", "Aring",
  "Cacute", "Ccaron", "cacute", "ccaron", "Ccedilla", "ccedilla",
  "Dcaron", "dcroat", "dcaron",
  "Ecaron", "Eogonek", "ecaron", "eogonek", "Egrave", "Eacute", "Ecircumflex", "Edieresis",
  "egrave", "eacute", "ecircumflex", "edieresis",
  "Gbreve", "gbreve",
  "Idotaccent", "Igrave", "Iacute", "Icircumflex", "Idieresis",
  "igrave", "iacute", "icircumflex", "idieresis",
  "Lacute", "Lcaron", "Lslash", "lacute", "lcaron", "lslash",
  "Nacute", "Ncaron", "nacute", "ncaron", "Ntilde", "ntilde",
  "Ohungarumlaut", "ohungarumlaut", "Ograve", "Oacute", "Ocircumflex", "Otilde", "Odieresis", "Oslash",
  "ograve", "oacute", "ocircumflex", "otilde", "odieresis", "oslash",
  "Racute", "Rcaron", "racute", "rcaron",
  "Sacute", "Scaron", "Scedilla", "sacute", "scaron", "scedilla",
  "Tcaron", "Tcedilla", "tcaron", "tcedilla",
  "Uhungarumlaut", "Uring", "uhungarumlaut", "uring", "Ugrave", "Uacute", "Ucircumflex", "Udieresis",
  "ugrave", "uacute", "ucircumflex", "udieresis",
  "Ydieresis", "ydieresis", "Yacute", "yacute",
  "Zacute", "Zcaron", "Zdotaccent", "zacute", "zcaron", "zdotaccent"
  enddef;
def Digits="1", "2", "3", "4", "5", "6", "7", "8", "9", "0" enddef;
def Chars_tr="e", "l", "q", "u", "dollar", "E", "L", "Q", "U",
  "Ecaron", "Eogonek", "ecaron", "eogonek", "Egrave", "Eacute", "Ecircumflex", "Edieresis",
  "egrave", "eacute", "ecircumflex", "edieresis",
  "Lacute", "Lcaron", "Lslash", "lacute", "lcaron", "lslash",
  "Uhungarumlaut", "Uring", "uhungarumlaut", "uring", "Ugrave", "Uacute", "Ucircumflex", "Udieresis",
  "ugrave", "uacute", "ucircumflex", "udieresis"
  enddef;
def Chars_br="g", "n", "s", "tilda", "v", "G", "N", "S", "V",
  "Gbreve", "gbreve",
  "Nacute", "Ncaron", "nacute", "ncaron", "Ntilde", "ntilde",
  "Sacute", "Scaron", "Scedilla", "sacute", "scaron", "scedilla"
  enddef;
def Digits_tr="5" enddef;
def Digits_br="7" enddef;
def Chars_nr="a", "b", "c", "d", "f", "h", "i", "j", "k", "m",
  "o", "p", "r", "t", "w", "x", "y", "z",
  "A", "B", "C", "D", "F", "H", "I", "J", "K", "M",
  "O", "P", "R", "T", "W", "X", "Y", "Z",
  "Abreve", "Aogonek", "abreve", "aogonek", "agrave", "aacute", "acircumflex", "atilde", "adieresis", "aring",
  "Agrave", "Aacute", "Acircumflex", "Atilde", "Adieresis", "Aring",
  "Cacute", "Ccaron", "cacute", "ccaron", "Ccedilla", "ccedilla",
  "Dcaron", "dcroat", "dcaron",
  "Ohungarumlaut", "ohungarumlaut", "Ograve", "Oacute", "Ocircumflex", "Otilde", "Odieresis", "Oslash",
  "ograve", "oacute", "ocircumflex", "otilde", "odieresis", "oslash",
  "Racute", "Rcaron", "racute", "rcaron",
  "Tcaron", "Tcedilla", "tcaron", "tcedilla",
  "Ydieresis", "ydieresis", "Yacute", "yacute",
  "Zacute", "Zcaron", "Zdotaccent", "zacute", "zcaron", "zdotaccent"
  enddef;
def Digits_nr="1", "2", "3", "4", "6", "8", "9", "0" enddef;
def Tr=Chars_tr, Digits_tr enddef;
def Br=Chars_br, Digits_br enddef;
def Tl="c", "t", "u", "y", "tilda", "C", "T", "U", "Y", "3",
  "Cacute", "Ccaron", "cacute", "ccaron", "Ccedilla", "ccedilla",
  "Tcaron", "Tcedilla", "tcaron", "tcedilla",
  "ugrave", "uacute", "ucircumflex", "udieresis",
  "Ydieresis", "ydieresis", "Yacute", "yacute"
  enddef;
def Bl="a", "l", "m", "n", "A", "L", "M", "N", "1",
  "Abreve", "Aogonek", "abreve", "aogonek", "agrave", "aacute", "acircumflex", "atilde", "adieresis", "aring",
  "Agrave", "Aacute", "Acircumflex", "Atilde", "Adieresis", "Aring",
  "Lacute", "Lcaron", "Lslash", "lacute", "lcaron", "lslash",
  "Nacute", "Ncaron", "nacute", "ncaron", "Ntilde", "ntilde"
  enddef;
def Td="d", "dollar", "j", "v", "D", "J", "V", "4",
  "Dcaron", "dcroat", "dcaron"
enddef;
boundarychar:=1;

for i=Chars_tr:
  LK(i)
    for j=Digits: LP(j)("dollar") endfor
    if proportional: for j=Bl: KP(j)(-1u#) endfor fi
    KP("space")(0u#)
  KL;
endfor
for i=Digits_tr:
  LK(i)
    for j=Chars: LP(j)("numbersign") endfor
    %LP(boundarychar)("numbersign")
    if proportional: for j=Bl: KP(j)(-1u#) endfor fi
    KP("space")(0u#)
  KL;
endfor

for i=Chars_br:
  LK(i)
    for j=Digits: LP(j)("numbersign") endfor
    if proportional: for j=Tl: KP(j)(-1u#) endfor
                     for j=Td: KP(j)(-.5u#) endfor fi
    KP("space")(0u#)
  KL;
endfor
for i=Digits_br:
  LK(i)
    for j=Chars: LP(j)("numbersign") endfor
    LP(boundarychar)("numbersign")
    if proportional: for j=Tl: KP(j)(-1u#) endfor
                     for j=Td: KP(j)(-.5u#) endfor fi
    KP("space")(0u#)
  KL;
endfor

for i=Chars_nr:
  LK(i)
    for j=Digits: LP(j)("dollar") endfor
    LP("space")("space")
  KL;
endfor
for i=Digits_nr:
  LK(i)
    for j=Chars: LP(j)("numbersign") endfor
    %LP(boundarychar)("numbersign")
  KL;
endfor
%LK(boundarychar)
%  for j=Digits: LP(j)("dollar") endfor
%  LP("space")("space")
%KL;

fi;

endinput;
