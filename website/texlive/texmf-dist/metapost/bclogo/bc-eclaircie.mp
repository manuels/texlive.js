prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (1.000000,1.000000,0.000000));
linecap := butt;
linejoin := mitered;
fill (9.199220,9.339840)..controls (9.199220,11.164100) and (7.734380,12.628900)..(5.910160,12.628900)
    ..controls (4.085940,12.628900) and (2.621090,11.164100)..(2.621090,9.339840)
    ..controls (2.621090,7.511720) and (4.085940,6.050780)..(5.910160,6.050780)
    ..controls (7.734380,6.050780) and (9.199220,7.511720)..(9.199220,9.339840)
    --cycle;
drawoptions (withcolor (1.000000,0.501961,0.250980));
pickup pencircle scaled 0.199250bp;
linejoin := rounded;
draw (9.199220,9.339840)..controls (9.199220,11.164100) and (7.734380,12.628900)..(5.910160,12.628900)
    ..controls (4.085940,12.628900) and (2.621090,11.164100)..(2.621090,9.339840)
    ..controls (2.621090,7.511720) and (4.085940,6.050780)..(5.910160,6.050780)
    ..controls (7.734380,6.050780) and (9.199220,7.511720)..(9.199220,9.339840)
    --cycle;
draw (5.910160,9.339840);
draw (9.257810,11.269500)--(10.593800,12.043000);
draw (7.843750,12.683600)--(8.613280,14.023400);
draw (5.910160,13.203100)--(5.910160,14.746100);
draw (3.980470,12.683600)--(3.207030,14.023400);
draw (2.566410,11.269500)--(1.226560,12.043000);
draw (2.046880,9.339840)--(0.503906,9.339840);
draw (2.566410,7.406250)--(1.226560,6.636720);
drawoptions (withcolor (0.854902,0.854902,0.854902));
pickup pencircle scaled 0.000000bp;
fill (3.316410,4.925780)..controls (3.699220,3.902340) and (15.824200,4.156250)..(16.601601,4.925780)
    ..controls (19.074200,7.394530) and (15.902300,10.476600)..(13.507800,7.929690)
    ..controls (12.671900,12.179700) and (7.644530,12.539100)..(6.925780,8.890630)
    ..controls (3.574220,9.007810) and (2.703130,6.562500)..(3.316410,4.925780)
    --cycle;
drawoptions (withcolor (0.725490,0.725490,0.725490));
pickup pencircle scaled 0.797010bp;
draw (3.316410,4.925780)..controls (3.699220,3.902340) and (15.824200,4.156250)..(16.601601,4.925780)
    ..controls (19.074200,7.394530) and (15.902300,10.476600)..(13.507800,7.929690)
    ..controls (12.671900,12.179700) and (7.644530,12.539100)..(6.925780,8.890630)
    ..controls (3.574220,9.007810) and (2.703130,6.562500)..(3.316410,4.925780)
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
draw (z1-(10.5,4));
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,-1pt))--(z1-(8.5pt,1pt))--cycle);
endfig;
end
