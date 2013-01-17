prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (1.000000,0.831373,0.000000));
linecap := butt;
linejoin := mitered;
fill (9.964840,3.820310)--(6.769530,5.523440)--(3.554690,3.859380)
    --(4.187500,7.421880)--(1.609370,9.964840)--(5.195310,10.464800)
    --(6.816410,13.699200)--(8.402340,10.445300)--(11.980500,9.906250)
    --(9.371090,7.394530)--cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
pickup pencircle scaled 0.400000bp;
linecap := rounded;
linejoin := rounded;
draw (9.964840,3.820310)--(6.769530,5.523440)--(3.554690,3.859380)
    --(4.187500,7.421880)--(1.609370,9.964840)--(5.195310,10.464800)
    --(6.816410,13.699200)--(8.402340,10.445300)--(11.980500,9.906250)
    --(9.371090,7.394530)--cycle;
r:=17pt/(xpart(urcorner(currentpicture))-xpart(ulcorner(currentpicture)));
picture pic;
pic:=currentpicture;
currentpicture:=nullpicture;
drawoptions();
draw pic scaled(1.3);
z0=.5*urcorner(currentpicture)+.5*ulcorner(currentpicture);
z1=.5*lrcorner(currentpicture)+.5*llcorner(currentpicture);
draw (z0+(10.5,2));
draw (z1-(10.5,3));
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,-1pt))--(z1-(8.5pt,1pt))--cycle);
endfig;
end
