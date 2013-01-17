%!
% makegray.pro, PostScript header file for grayscale conversion.

%%%%%
% Siep Kroonenberg, n dot s dot kroonenberg at rug dot nl
% Public domain.
%%%%%

% This version only handles some basic color models,
% and doesn't handle image data at all.
% A more robust version would be warmly welcomed.

%%%%<< /ProcessColorModel /DeviceGray >> setpagedevice
userdict begin
% .11*B + .59*G + .3*R
/setrgbcolor {
  0.11 mul exch 0.59 mul add exch 0.3 mul add
  systemdict begin setgray end
} def
% 1.0 - min(1.0, .3*C + .59*M + .11*Y + B)
/setcmykcolor {
  exch 0.11 mul add
  exch 0.59 mul add
  exch 0.3 mul add
  dup 1 gt {pop 1} if
  1 exch sub
  systemdict begin setgray end
} def
% hsb: toss hue and saturation; keep brightness for gray setting
/sethsbcolor {
  pop pop systemdict begin setgray end
} def
end
