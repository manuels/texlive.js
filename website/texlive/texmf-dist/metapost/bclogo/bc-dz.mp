prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (1.000000,0.000000,0.000000));
linecap := butt;
linejoin := mitered;
fill (0.539063,2.386720)..controls (0.062500,3.054690) and (0.417969,3.679690)..(3.828130,9.566410)
    ..controls (7.230470,15.437500) and (7.667970,16.332001)..(8.425780,16.332001)
    ..controls (9.203130,16.332001) and (9.546880,15.644500)..(12.906300,9.839840)
    ..controls (16.246099,4.074220) and (16.789101,3.378910)..(16.304701,2.550780)
    ..controls (15.828100,1.730470) and (14.902300,1.925780)..(8.371090,1.906250)
    ..controls (1.863280,1.886720) and (1.015630,1.726560)..(0.539063,2.386720)
    --cycle;
drawoptions (withcolor (0.976471,0.976471,0.976471));
fill (14.859400,3.312500)--(2.042970,3.312500)--(8.449220,14.281300)
    --cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
linecap := rounded;
pickup pencircle scaled 1.117530bp;
linejoin := mitered;
draw (7.164060,9.410160)..controls (9.523440,9.652340) and (9.851560,9.390630)..(10.046900,9.023440)
    ..controls (10.632800,7.937500) and (6.195310,6.769530)..(6.410160,5.710940)
    ..controls (6.621090,4.656250) and (8.519530,5.039060)..(10.906300,5.105470);
pickup pencircle scaled 0.000000bp;
fill (7.226560,9.800780)..controls (7.023440,9.886720) and (6.460940,9.441410)..(6.457030,9.382810)
    ..controls (6.457030,9.312500) and (7.023440,8.921880)..(7.226560,9.027340)
    ..controls (7.429690,9.132810) and (7.429690,9.710940)..(7.226560,9.800780)
    --cycle;
pickup pencircle scaled 0.223506bp;
draw (7.226560,9.800780)..controls (7.023440,9.886720) and (6.460940,9.441410)..(6.457030,9.382810)
    ..controls (6.457030,9.312500) and (7.023440,8.921880)..(7.226560,9.027340)
    ..controls (7.429690,9.132810) and (7.429690,9.710940)..(7.226560,9.800780)
    --cycle;
pickup pencircle scaled 0.01bp;
draw (14.859400,3.312500)--(2.042970,3.312500)--(8.449220,14.281300)
    --cycle;
draw (0.539063,2.386720)..controls (0.062500,3.054690) and (0.417969,3.679690)..(3.828130,9.566410)
    ..controls (7.230470,15.437500) and (7.667970,16.332001)..(8.425780,16.332001)
    ..controls (9.203130,16.332001) and (9.546880,15.644500)..(12.906300,9.839840)
    ..controls (16.246099,4.074220) and (16.789101,3.378910)..(16.304701,2.550780)
    ..controls (15.828100,1.730470) and (14.902300,1.925780)..(8.371090,1.906250)
    ..controls (1.863280,1.886720) and (1.015630,1.726560)..(0.539063,2.386720)
    --cycle;
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
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,-1pt))--(z1-(8.5pt,1pt))--cycle);
endfig;
end
