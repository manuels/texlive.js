prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (0.309800,0.027500,0.086300));
fill (0.347656,4.429690)--(11.953100,5.679690)--(16.445299,2.445310)
    --(4.839840,1.195310)--cycle;
pickup pencircle scaled 0.100000bp;
draw (0.347656,4.429690)--(11.953100,5.679690)--(16.445299,2.445310)
    --(4.839840,1.195310)--cycle;
drawoptions (withcolor (0.368600,0.035300,0.102000));
pickup pencircle scaled 0.000000bp;
fill (11.953100,5.679690)--(11.953100,17.632799)--(16.445299,14.394500)
    --(16.445299,2.445310)--cycle;
pickup pencircle scaled 0.100000bp;
draw (11.953100,5.679690)--(11.953100,17.632799)--(16.445299,14.394500)
    --(16.445299,2.445310)--cycle;
drawoptions (withcolor (0.788200,0.070600,0.215700));
pickup pencircle scaled 0.000000bp;
fill (0.347656,4.429690)--(0.347656,16.378901)--(11.953100,17.632799)
    --(11.953100,5.679690)--cycle;
pickup pencircle scaled 0.100000bp;
draw (0.347656,4.429690)--(0.347656,16.378901)--(11.953100,17.632799)
    --(11.953100,5.679690)--cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (11.953100,5.679690)--(16.445299,2.445310);
draw (11.953100,5.679690)--(11.953100,17.632799);
draw (0.347656,4.429690)--(11.953100,5.679690);
drawoptions (withcolor (0.788200,0.070600,0.215700));
pickup pencircle scaled 0.000000bp;
fill (4.839840,1.195310)--(16.445299,2.445310)--(16.445299,14.394500)
    --(4.839840,13.144500)--cycle;
pickup pencircle scaled 0.100000bp;
draw (4.839840,1.195310)--(16.445299,2.445310)--(16.445299,14.394500)
    --(4.839840,13.144500)--cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (16.445299,2.445310)--(4.839840,1.195310);
draw (16.445299,14.394500)--(16.445299,2.445310);
drawoptions (withcolor (0.368600,0.035300,0.102000));
pickup pencircle scaled 0.000000bp;
fill (0.347656,16.378901)--(0.347656,4.429690)--(4.839840,1.195310)
    --(4.839840,13.144500)--cycle;
pickup pencircle scaled 0.100000bp;
draw (0.347656,16.378901)--(0.347656,4.429690)--(4.839840,1.195310)
    --(4.839840,13.144500)--cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (4.839840,1.195310)--(0.347656,4.429690);
draw (4.839840,1.195310)--(4.839840,13.144500);
draw (0.347656,16.378901)--(0.347656,4.429690);
drawoptions (withcolor (0.309800,0.027500,0.086300));
pickup pencircle scaled 0.000000bp;
fill (0.347656,16.378901)--(4.839840,13.144500)--(16.445299,14.394500)
    --(11.953100,17.632799)--cycle;
pickup pencircle scaled 0.100000bp;
draw (0.347656,16.378901)--(4.839840,13.144500)--(16.445299,14.394500)
    --(11.953100,17.632799)--cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (0.347656,16.378901)--(4.839840,13.144500);
draw (11.953100,17.632799)--(16.445299,14.394500);
draw (4.839840,13.144500)--(16.445299,14.394500);
draw (11.953100,17.632799)--(0.347656,16.378901);
picture pic;
pic:=currentpicture;
currentpicture:=nullpicture;
drawoptions();
draw pic scaled(1.008);
z0=.5*urcorner(currentpicture)+.5*ulcorner(currentpicture);
z1=.5*lrcorner(currentpicture)+.5*llcorner(currentpicture);
draw (z0+(10.5,2));
draw (z1-(10.5,2));
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,0))--(z1-(8.5pt,0))--cycle);
endfig;
end
