%!
%                           -*- Mode: Postscript -*- 
% pst-ghsb.pro --- PostScript header file pst-ghsb.pro
%                  For the PSTricks HSB mode gradient fillstyle
%                  Based on pst-grad.pro from Timothy van Zandt
%                  Syntax:
%                    H0 S0 B0 H1 S1 B1 MidPoint NumLines Angle GradientFillHSB
% 
% Author          : Denis GIROU (CNRS/IDRIS - France) <Denis.Girou@idris.fr>
% Created the     : Tue May 13 11:12:36 1997
% Version         : 1.0
% Last mod. by    : Denis GIROU (CNRS/IDRIS - France) <Denis.Girou@idris.fr>
% Last mod. the   : Wed May 14 18:48:03 1997
% 

% Syntax:
%   H0 S0 B0 H1 S1 B1 NumLines MidPoint Angle GradientFillHSB

/tx@GradientHSBDict 40 dict def
tx@GradientHSBDict begin
/GradientFillHSB {
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

end
% END pst-ghsb.pro
