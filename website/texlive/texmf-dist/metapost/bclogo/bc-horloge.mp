prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
linecap := butt;
linejoin := mitered;
pickup pencircle scaled 0bp;
drawoptions (withcolor (1,1,1));
fill fullcircle scaled(17) shifted(80.5,711.5);
drawoptions (withcolor (0,0,0));
pickup pencircle scaled 0.199253bp;
draw fullcircle scaled(17) shifted(80.5,711.5);
pickup pencircle scaled 0.099626bp;
draw fullcircle scaled(15.726494) shifted(80.5,711.5);
pickup pencircle scaled 0bp;
for i=0 upto 11:
z[i]=(80.5,711.5)+6.5*(cosd(30*i),sind(30*i));
filldraw fullcircle scaled(0.7) shifted(z[i]);
endfor;
for i=0 upto 3:
filldraw fullcircle scaled(0.9) shifted(z[3*i]);
endfor;
drawoptions (withcolor (0.311800,0.311800,0.311800));
linejoin := rounded;
fill (82.687500,713.078003)--(85.671898,714.456970)--(80.300797,710.659973)
    --(79.699203,711.698975)--cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
pickup pencircle scaled 0.099626bp;
draw (82.687500,713.078003)--(85.671898,714.456970)--(80.300797,710.659973)
    --(79.699203,711.698975)--cycle;
drawoptions (withcolor (0.311800,0.311800,0.311800));
pickup pencircle scaled 0.000000bp;
fill (78.851601,712.281006)--(77.039101,713.918030)--(81.355499,711.629028)
    --(80.667999,710.645020)--cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
pickup pencircle scaled 0.099626bp;
draw (78.851601,712.281006)--(77.039101,713.918030)--(81.355499,711.629028)
    --(80.667999,710.645020)--cycle;
r:=17pt/(xpart(urcorner(currentpicture))-xpart(ulcorner(currentpicture)));
picture pic;
pic:=currentpicture;
currentpicture:=nullpicture;
drawoptions();
draw pic scaled(r);
z20=.5*urcorner(currentpicture)+.5*ulcorner(currentpicture);
z21=.5*lrcorner(currentpicture)+.5*llcorner(currentpicture);
draw (z20+(10.5,2));
draw (z21-(10.5,2));
clip currentpicture to ((z20-(8.5pt,0))--(z20+(8.5pt,0))--(z21+(8.5pt,-1pt))--(z21-(8.5pt,1pt))--cycle);
endfig;
end
