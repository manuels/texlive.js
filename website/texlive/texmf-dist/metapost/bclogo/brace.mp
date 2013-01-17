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
linecap := butt;
fill (10.371100,82.296898)..controls (2.140630,82.296898) and (10.371100,41.148399)..(2.140630,41.148399)
    ..controls (10.371100,41.148399) and (2.140630,0.000000)..(10.371100,0.000000)
    ..controls (2.140630,0.000000) and (16.042999,41.148399)..(2.140630,41.148399)
    ..controls (16.042999,41.148399) and (2.140630,82.296898)..(10.371100,82.296898)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (10.371100,82.296898)..controls (2.140630,82.296898) and (10.371100,41.148399)..(2.140630,41.148399)
    ..controls (10.371100,41.148399) and (2.140630,0.000000)..(10.371100,0.000000)
    ..controls (2.140630,0.000000) and (16.042999,41.148399)..(2.140630,41.148399)
    ..controls (16.042999,41.148399) and (2.140630,82.296898)..(10.371100,82.296898);
endfig;
end
