%!
% PostScript prologue for pst-grad.tex.
% Version 1.05, 2006/11/04 
% prepared by Herbert Voss
% For copying restrictions, see pstricks.tex.
%
% For the PSTricks gradient fillstyle.%
% Based on some EPS files by leeweyr!bill@nuchat.sccsi.com (W. R. Lee).%
% Syntax:% D.G. modification begin - Apr.  9, %1998
%%%%%% R0 G0 B0 R1 G1 B1 NumLines MidPoint Angle GradientFill
%   ifGradientCircle GradientScale %GradientPosX GradientPosY
%     R0 G0 B0 R1 G1 B1 NumLines MidPoint %Angle GradientFill
% D.G. modification end
%
/tx@GradientDict 40 dict def
tx@GradientDict begin
/GradientFill {
 /ifCMYK exch def   % do we have rgb or cmyk? hv 1.06
 rotate
 /MidPoint ED
 /NumLines ED
 ifCMYK {
    /LastBlack ED	% 1.06
    /LastYellow ED	% 1.06
    /LastMagenta ED	% 1.06
    /LastCyan ED	% 1.06
    /FirstBlack ED	% 1.06
    /FirstYellow ED	% 1.06
    /FirstMagenta ED	% 1.06
    /FirstCyan ED	% 1.06
 }{ /LastBlue ED
    /LastGreen ED
    /LastRed ED
    /FirstBlue ED
    /FirstGreen ED
    /FirstRed ED
 } ifelse
 /GradientPosY ED
 /GradientPosX ED
 /GradientScale ED
 /ifGradientCircle ED
 % This avoids gaps due to rounding errors:
 clip
 pathbbox           %leave llx,lly,urx,ury on stack
 4 copy /ury ED /urx ED /lly ED /llx ED
 /y ED /x ED
 ifGradientCircle
   { 0 GradientPosX eq { 0 GradientPosX eq {2 copy translate} if } if }
   {2 copy translate} ifelse
 y sub neg /y ED
 x sub neg /x ED  % This avoids gaps due to rounding errors:
 ifCMYK {				% 1.06
    LastCyan FirstCyan add 2 div	% 1.06
    LastMagenta FirstMagenta add 2 div	% 1.06
    LastYellow FirstYellow add 2 div	% 1.06
    LastBlack FirstBlack add 2 div	% 1.06
    setcmykcolor			% 1.06
  }{
    LastRed FirstRed add 2 div
    LastGreen FirstGreen add 2 div
    LastBlue FirstBlue add 2 div
    setrgbcolor
  } ifelse
 ifGradientCircle
   { /YSizePerLine y NumLines div def
     /CurrentY y 2 div def
     /MidLine NumLines 2 div 1 MidPoint sub mul abs cvi def
   }{
     fill
     /YSizePerLine y NumLines div def
     /CurrentY 0 def
     /MidLine NumLines 1 MidPoint sub mul abs cvi def
   } ifelse
 MidLine NumLines 2 sub gt 
   { /MidLine NumLines def }
   { MidLine 2 lt { /MidLine 0 def } if } ifelse
 MidLine 0 gt {
  ifCMYK {
    /Cyan FirstCyan def
    /Magenta FirstMagenta def
    /Yellow FirstYellow def
    /Black FirstBlack def
    /CyanIncrement LastCyan FirstCyan sub MidLine 1 sub div def
    /MagentaIncrement LastMagenta FirstMagenta sub MidLine 1 sub div def
    /YellowIncrement LastYellow FirstYellow sub MidLine 1 sub div def
    /BlackIncrement LastBlack FirstBlack sub MidLine 1 sub div def
  }{
    /Red FirstRed def
    /Green FirstGreen def
    /Blue FirstBlue def
    /RedIncrement LastRed FirstRed sub MidLine 1 sub div def
    /GreenIncrement LastGreen FirstGreen sub MidLine 1 sub div def
    /BlueIncrement LastBlue FirstBlue sub MidLine 1 sub div def
  } ifelse
  MidLine { GradientLoop } repeat
 } if
 MidLine NumLines lt {
  ifCMYK {
    /Cyan LastCyan def
    /Magenta LastMagenta def
    /Yellow LastYellow def
    /Black LastBlack def
    /CyanIncrement FirstCyan LastCyan sub NumLines MidLine sub 1 sub div def
    /MagentaIncrement FirstMagenta LastMagenta sub NumLines MidLine sub 1 sub div def
    /YellowIncrement FirstYellow LastYellow sub NumLines MidLine sub 1 sub div def
    /BlackIncrement FirstBlack LastBlack sub NumLines MidLine sub 1 sub div def
  }{
    /Red LastRed def
    /Green LastGreen def
    /Blue LastBlue def
    /RedIncrement FirstRed LastRed sub NumLines MidLine sub 1 sub div def
    /GreenIncrement FirstGreen LastGreen sub NumLines MidLine sub 1 sub div def
    /BlueIncrement FirstBlue LastBlue sub NumLines MidLine sub 1 sub div def
  } ifelse
  NumLines MidLine sub { GradientLoop } repeat  
 } if
} def/GradientLoop {
% D.G. modification begin - Jul. 23, 1997 / Apr.  9, 1998
  ifGradientCircle
   {CurrentY 0 gt {
% The default center used is the center of the bounding box of the object
      0 GradientPosX eq        {0 GradientPosX eq
           {/GradientPosX urx llx sub 2 div def
            /GradientPosY ury lly sub 2 div def} if} if
      GradientPosX GradientPosY CurrentY GradientScale mul 0 360 arc
      ifCMYK { Cyan Magenta Yellow Black setcmykcolor }
           { Red Green Blue setrgbcolor } ifelse 
      fill
      /CurrentY CurrentY YSizePerLine sub def
      ifCMYK {
        /Cyan Cyan CyanIncrement add def
        /Magenta Magenta MagentaIncrement add def
        /Yellow Yellow YellowIncrement add def
        /Black Black BlackIncrement add def
      }{	
        /Blue Blue BlueIncrement add def
        /Green Green GreenIncrement add def
        /Red Red RedIncrement add def
      } ifelse
  } if }   { 0 CurrentY moveto    x 0 rlineto
    0 YSizePerLine rlineto    x neg 0 rlineto    closepath
      ifCMYK { Cyan Magenta Yellow Black setcmykcolor }
           { Red Green Blue setrgbcolor } ifelse 
      fill    
      /CurrentY CurrentY YSizePerLine add def
      ifCMYK {
        /Cyan Cyan CyanIncrement add def
        /Magenta Magenta MagentaIncrement add def
        /Yellow Yellow YellowIncrement add def
        /Black Black BlackIncrement add def
      }{	
        /Blue Blue BlueIncrement add def
        /Green Green GreenIncrement add def
        /Red Red RedIncrement add def
      } ifelse
      } ifelse% D.G. modification end
    }def
%
/GradientFillHSB { %	hv 2006-11-04
  rotate
  /MidPoint ED
  /NumLines ED
  /LastBrightness ED
  /LastSaturation ED
  /LastHue ED
  /FirstBrightness ED
  /FirstSaturation ED
  /FirstHue ED
  % This avoids gaps due to rounding errors:
  clip
  pathbbox           %leave llx,lly,urx,ury on stack
  /y ED /x ED
  2 copy translate
  y sub neg /y ED
  x sub neg /x ED
  % This avoids gaps due to rounding errors:
  LastHue FirstHue add 2 div
  LastSaturation FirstSaturation add 2 div
  LastBrightness FirstBrightness add 2 div
  sethsbcolor
  fill
  /YSizePerLine y NumLines div def
  /CurrentY 0 def
  /MidLine NumLines 1 MidPoint sub mul abs cvi def
  MidLine NumLines 2 sub gt
  { /MidLine NumLines def }
  { MidLine 2 lt { /MidLine 0 def } if }
  ifelse
  MidLine 0 gt
  {
    /Hue FirstHue def
    /Saturation FirstSaturation def
    /Brightness FirstBrightness def
    /HueIncrement LastHue FirstHue sub MidLine 1 sub div def
    /SaturationIncrement LastSaturation FirstSaturation sub MidLine 1 sub
                         div def
    /BrightnessIncrement LastBrightness FirstBrightness sub MidLine 1 sub
                         div def
    MidLine { GradientLoopHSB } repeat
  } if
  MidLine NumLines lt
  {
    /Hue LastHue def
    /Saturation LastSaturation def
    /Brightness LastBrightness def
    /HueIncrement FirstHue LastHue sub NumLines MidLine sub 1 sub div def
    /SaturationIncrement FirstSaturation LastSaturation sub
                         NumLines MidLine sub 1 sub div def
    /BrightnessIncrement FirstBrightness LastBrightness sub
                         NumLines MidLine sub 1 sub div def
    NumLines MidLine sub { GradientLoopHSB } repeat
  } if
} def
/GradientLoopHSB {
  0 CurrentY moveto
  x 0 rlineto
  0 YSizePerLine rlineto
  x neg 0 rlineto
  closepath
  Hue Saturation Brightness sethsbcolor fill
  /CurrentY CurrentY YSizePerLine add def
  /Brightness Brightness BrightnessIncrement add def
  /Saturation Saturation SaturationIncrement add def
  /Hue Hue HueIncrement add def
} def
%
end
%
% END pst-grad.pro
