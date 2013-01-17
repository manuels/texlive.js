outputtemplate:="%j.mps";
prologues := 1;
beginfig(1);
linecap := butt;
linejoin := mitered;
fill (63.867199,57.281300)--(70.945297,64.363297)--(77.445297,57.863300)
    --(80.000000,80.000000)--(57.863300,77.445297)--(64.363297,70.945297)
    --(57.281300,63.867199)
    --cycle;
pickup pencircle scaled(9.3);
draw fullcircle scaled(61.95) shifted(35.60745,35.60745);

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
