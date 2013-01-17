prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (1.000000,1.000000,0.000000));
linecap := butt;
linejoin := mitered;
fill (0.632813,2.179690)--(6.820310,13.019500)--(13.078100,2.179690)
    --cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
pickup pencircle scaled 0.243079bp;
draw (0.632813,2.179690)--(6.820310,13.019500)--(13.078100,2.179690)
    --cycle;
drawoptions (withcolor (1.000000,0.000000,0.000000));
pickup pencircle scaled 0.000000bp;
fill (6.671880,10.074200)--(4.843750,6.515630)--(7.078130,6.062500)
    --(4.992190,3.312500)--(9.015630,6.320310)--(6.222660,6.902340)
    --(7.972660,9.980470)--cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
pickup pencircle scaled 0.243079bp;
draw (6.671880,10.074200)--(4.843750,6.515630)--(7.078130,6.062500)
    --(4.992190,3.312500)--(9.015630,6.320310)--(6.222660,6.902340)
    --(7.972660,9.980470)--cycle;
picture pic;
pic:=currentpicture;
currentpicture:=nullpicture;
drawoptions();
draw pic scaled(1.324);
z0=.5*urcorner(currentpicture)+.5*ulcorner(currentpicture);
z1=.5*lrcorner(currentpicture)+.5*llcorner(currentpicture);
draw (z0+(10.5,2));
draw (z1-(10.5,2));
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,-2pt))--(z1-(8.5pt,2pt))--cycle);
endfig;
end
