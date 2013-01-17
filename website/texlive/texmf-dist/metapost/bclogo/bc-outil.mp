outputtemplate:="%j.mps";
prologues := 1;
beginfig(1);
linecap := butt;
linejoin := mitered;
fill (6.656250,2.863280)
    --(10.671900,1.898440)
    --(52.574200,45.480499)
    ..controls (58.933601,42.566399) and (66.656303,43.812500)..(71.859398,49.214802)
    ..controls (76.187500,53.726601) and (77.742203,60.058601)..(76.511703,65.871101)
    --(71.335899,60.484402)
    --(70.078102,59.175800)
    --(66.148399,55.093800)
    --(60.890598,56.472698)
    --(55.632801,57.855499)
    --(52.972698,68.792999)
    --(58.160198,74.191399)
    --(60.832001,76.972702)
    --(63.335899,79.574203)
    ..controls (57.750000,80.855499) and (51.656300,79.242203)..(47.320301,74.734398)
    ..controls (42.125000,69.328102) and (40.929699,61.292999)..(43.734402,54.675800)
    --(1.824220,11.097700)
    ..controls (-0.609375,8.566410) and (-0.609375,4.429690)..(1.824220,1.898440)
    ..controls (4.257810,-0.632813) and (8.234370,-0.632813)..(10.671900,1.898440)
    --(6.656250,2.863280)
    ..(2.867190,7.007810)
    ..(6.656250,10.43749)
    ..(10.441400,7.007810)
    ..(6.656250,2.863280)
    --cycle withcolor(.5,.5,.5);

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
