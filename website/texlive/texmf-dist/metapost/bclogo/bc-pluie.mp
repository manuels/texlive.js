prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (0.854902,0.854902,0.854902));
linecap := butt;
linejoin := mitered;
fill (1.312500,7.531250)..controls (1.750000,6.363280) and (15.585900,6.652340)..(16.468800,7.531250)
    ..controls (19.292999,10.343800) and (15.675800,13.859400)..(12.941400,10.960900)
    ..controls (11.984400,15.808600) and (6.250000,16.218800)..(5.429690,12.050800)
    ..controls (1.605470,12.187500) and (0.609375,9.398440)..(1.312500,7.531250)
    --cycle;
drawoptions (withcolor (0.725490,0.725490,0.725490));
pickup pencircle scaled 0.797010bp;
linejoin := rounded;
draw (1.312500,7.531250)..controls (1.750000,6.363280) and (15.585900,6.652340)..(16.468800,7.531250)
    ..controls (19.292999,10.343800) and (15.675800,13.859400)..(12.941400,10.960900)
    ..controls (11.984400,15.808600) and (6.250000,16.218800)..(5.429690,12.050800)
    ..controls (1.605470,12.187500) and (0.609375,9.398440)..(1.312500,7.531250)
    --cycle;
drawoptions (withcolor (0.717647,0.717647,0.717647));
draw (2.289060,6.382810)--(0.515625,3.585940);
draw (4.933590,6.382810)--(3.160160,3.585940);
draw (7.578130,6.382810)--(5.804690,3.585940);
draw (10.222700,6.382810)--(8.449220,3.585940);
draw (12.867200,6.382810)--(11.093800,3.585940);
draw (15.511700,6.382810)--(13.738300,3.585940);
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
