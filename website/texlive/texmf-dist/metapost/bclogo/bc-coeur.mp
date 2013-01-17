prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (0.929412,0.125490,0.027451));
linecap := butt;
linejoin := mitered;
fill (1.953130,9.832030)..controls (-0.582031,13.214800) and (5.628910,17.078100)..(6.792970,11.207000)
    ..controls (8.140630,17.093800) and (14.281300,13.476600)..(11.437500,9.710940)
    --(6.746090,3.285160)--cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
pickup pencircle scaled 0.2bp;
draw (1.953130,9.832030)..controls (-0.582031,13.214800) and (5.628910,17.078100)..(6.792970,11.207000)
    ..controls (8.140630,17.093800) and (14.281300,13.476600)..(11.437500,9.710940)
    --(6.746090,3.285160)--cycle;
picture pic;
pic:=currentpicture;
currentpicture:=nullpicture;
drawoptions();
draw pic scaled(1.4);
z0=.5*urcorner(currentpicture)+.5*ulcorner(currentpicture);
z1=.5*lrcorner(currentpicture)+.5*llcorner(currentpicture);
draw (z0+(10.5,2));
draw (z1-(10.5,2));
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,0))--(z1-(8.5pt,0))--cycle);
endfig;
end
