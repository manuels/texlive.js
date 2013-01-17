% Converted from PostScript(TM) to MetaPost by pstoedit
% MetaPost backend contributed by Scott Pakin <scott+ps2ed_AT_pakin.org>
% pstoedit is Copyright (C) 1993 - 2009 Wolfgang Glunz <wglunz35_AT_pstoedit.net>

% Generate structured PostScript
prologues := 1;

% Display a given string with its *baseline* at a given location
% and with a given rotation angle
vardef showtext(expr origin)(expr angle)(expr string) =
  draw string infont defaultfont scaled defaultscale
    rotated angle shifted origin;
enddef;
outputtemplate:="%j.mps";
beginfig(1);
pickup pencircle scaled 0.648166bp;
linecap := butt;
linejoin := mitered;
draw (4.605470,4.734380)..controls (4.746090,4.593750) and (4.488280,4.468750)..(4.375000,4.492190)
    ..controls (4.066410,4.558590) and (4.011720,4.960940)..(4.128910,5.203130)
    ..controls (4.347660,5.640630) and (4.917970,5.699220)..(5.296880,5.457030)
    ..controls (5.851560,5.101560) and (5.914060,4.316410)..(5.554690,3.796880)
    ..controls (5.074220,3.105470) and (4.093750,3.039060)..(3.449220,3.531250)
    ..controls (2.640630,4.148440) and (2.574220,5.355470)..(3.179690,6.140630)
    ..controls (3.917970,7.093750) and (5.316410,7.167970)..(6.222660,6.421880)
    ..controls (7.285160,5.546880) and (7.359380,3.910160)..(6.503910,2.859380)
    ..controls (5.511720,1.644530) and (3.691410,1.566410)..(2.527340,2.566410)
    ..controls (1.203130,3.699220) and (1.125000,5.765630)..(2.230470,7.078130)
    ..controls (3.476560,8.554690) and (5.722660,8.640630)..(7.144530,7.386720)
    ..controls (8.726560,5.996090) and (8.812500,3.496090)..(7.453130,1.921880);
endfig;
end
