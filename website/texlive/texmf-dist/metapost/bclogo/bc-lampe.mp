prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
linecap := butt;
fill (7.386720,3.144530)--(9.726560,3.144530)--(9.726560,5.484380)
    --(7.386720,5.484380)--cycle;
pickup pencircle scaled 0.600000bp;
draw (7.386720,3.144530)--(9.726560,3.144530)--(9.726560,5.484380)
    --(7.386720,5.484380)--cycle;
drawoptions (withcolor (1.000000,1.000000,0.000000));
pickup pencircle scaled 0.000000bp;
fill (9.726560,5.484380)--(9.726560,6.261720)..controls (9.726560,8.601560) and (10.894500,8.992190)..(11.675800,10.160200)
    ..controls (12.843800,12.109400) and (12.066400,15.621100)..(8.558590,15.621100)
    ..controls (5.046880,15.621100) and (4.269530,12.109400)..(5.437500,10.160200)
    ..controls (6.218750,8.992190) and (7.386720,8.601560)..(7.386720,6.261720)
    --(7.386720,5.484380)--cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
pickup pencircle scaled 0.600000bp;
draw (9.726560,5.484380)--(9.726560,6.261720)..controls (9.726560,8.601560) and (10.894500,8.992190)..(11.675800,10.160200)
    ..controls (12.843800,12.109400) and (12.066400,15.621100)..(8.558590,15.621100)
    ..controls (5.046880,15.621100) and (4.269530,12.109400)..(5.437500,10.160200)
    ..controls (6.218750,8.992190) and (7.386720,8.601560)..(7.386720,6.261720)
    --(7.386720,5.484380);
draw (6.609380,4.312500)--(10.507800,4.312500);
pickup pencircle scaled 0.200000bp;
draw (8.558590,3.535160)..controls (8.945310,7.042970) and (8.167970,10.160200)..(10.117200,11.722700)
    ..controls (9.335940,12.890600) and (7.386720,12.500000)..(6.996090,11.722700)
    ..controls (8.945310,10.160200) and (8.167970,7.042970)..(8.558590,3.535160);
pickup pencircle scaled 0.600000bp;
draw (4.660160,16.007799)--(2.320310,18.347700);
draw (8.558590,17.570299)--(8.558590,20.296900);
draw (12.457000,15.621100)--(14.882800,17.660200);
draw (13.625000,12.890600)--(15.964800,12.890600);
draw (3.488280,12.890600)--(0.761719,12.890600);
r:=17pt/(xpart(urcorner(currentpicture))-xpart(ulcorner(currentpicture)));
picture pic;
pic:=currentpicture;
currentpicture:=nullpicture;
drawoptions();
draw pic scaled(r);
z0=.5*urcorner(currentpicture)+.5*ulcorner(currentpicture);
z1=.5*lrcorner(currentpicture)+.5*llcorner(currentpicture);
draw (z0+(10.5,2));
draw (z1-(10.5,2));
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,-2pt))--(z1-(8.5pt,2pt))--cycle);
endfig;
end
