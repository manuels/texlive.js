prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (0.388200,0.035300,0.105900));
fill (17.000000,4.875000)--(4.175780,0.621094)--(0.488281,6.898440)
    --(17.000000,4.949220)--cycle;
pickup pencircle scaled 0.100000bp;
draw (17.000000,4.875000)--(4.175780,0.621094)--(0.488281,6.898440)
    --(17.000000,4.949220)--cycle;
drawoptions (withcolor (0.658800,0.058800,0.180400));
pickup pencircle scaled 0.000000bp;
fill (17.000000,4.949220)--(0.488281,6.898440)--(7.277340,17.460899)
    --(17.000000,5.140630)--cycle;
pickup pencircle scaled 0.100000bp;
draw (17.000000,4.949220)--(0.488281,6.898440)--(7.277340,17.460899)
    --(17.000000,5.140630)--cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (0.488281,6.898440)--(17.000000,4.949220);
drawoptions (withcolor (0.333300,0.031400,0.090200));
pickup pencircle scaled 0.000000bp;
fill (4.175780,0.621094)--(7.277340,17.460899)--(0.488281,6.898440)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (4.175780,0.621094)--(7.277340,17.460899)--(0.488281,6.898440)
    --cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (0.488281,6.898440)--(7.277340,17.460899);
draw (4.175780,0.621094)--(0.488281,6.898440);
drawoptions (withcolor (0.702000,0.062700,0.192200));
pickup pencircle scaled 0.000000bp;
fill (17.000000,5.140630)--(7.277340,17.460899)--(4.175780,0.621094)
    --(17.000000,4.875000)--cycle;
pickup pencircle scaled 0.100000bp;
draw (17.000000,5.140630)--(7.277340,17.460899)--(4.175780,0.621094)
    --(17.000000,4.875000)--cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (17.000000,4.875000)--(4.175780,0.621094);
draw (7.277340,17.460899)--(17.000000,5.140630);
draw (7.277340,17.460899)--(4.175780,0.621094);
r:=17pt/(xpart(urcorner(currentpicture))-xpart(ulcorner(currentpicture)));
picture pic;
pic:=currentpicture;
currentpicture:=nullpicture;
drawoptions();
draw pic scaled(r);
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
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,0))--(z1-(8.5pt,0))--cycle);
endfig;
end
