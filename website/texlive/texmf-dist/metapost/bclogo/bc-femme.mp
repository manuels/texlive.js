outputtemplate:="%j.mps";
prologues := 1;
beginfig(1);
linecap := butt;
linejoin := mitered;
fill (19.687500,13.554700)--(19.687500,5.851560)--(26.531300,5.851560)
    --(26.531300,0.000000)--(34.511700,0.000000)--(34.511700,5.851560)
    --(40.824200,5.851560)--(40.824200,13.554700)--(34.511700,13.554700)
    --(34.507801,19.226601)--(26.531300,19.226601)--(26.531300,13.554700)
    --cycle;
pickup pencircle scaled(7.980470);
draw fullcircle scaled(53.052764) shifted(61.042999/2,49.4);

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
