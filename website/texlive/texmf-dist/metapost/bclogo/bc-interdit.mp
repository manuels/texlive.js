prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
linecap := butt;
linejoin := mitered;
drawoptions (withcolor (1.000000,1.000000,1.000000));
fill (89.019501,711.479980)..controls (89.019501,716.171997) and (85.210899,719.979980)..(80.519501,719.979980)
    ..controls (75.828102,719.979980) and (72.019501,716.171997)..(72.019501,711.479980)
    ..controls (72.019501,706.789001) and (75.828102,702.979980)..(80.519501,702.979980)
    ..controls (85.210899,702.979980) and (89.019501,706.789001)..(89.019501,711.479980)
    --cycle;
drawoptions (withcolor (0.000000,0.000000,0.000000));
pickup pencircle scaled 0.398506bp;
draw (89.019501,711.479980)..controls (89.019501,716.171997) and (85.210899,719.979980)..(80.519501,719.979980)
    ..controls (75.828102,719.979980) and (72.019501,716.171997)..(72.019501,711.479980)
    ..controls (72.019501,706.789001) and (75.828102,702.979980)..(80.519501,702.979980)
    ..controls (85.210899,702.979980) and (89.019501,706.789001)..(89.019501,711.479980)
    --cycle;
drawoptions (withcolor (1.000000,0.000000,0.000000));
pickup pencircle scaled 0.000000bp;
fill (88.246101,711.479980)..controls (88.246101,715.745972) and (84.785202,719.206970)..(80.519501,719.206970)
    ..controls (76.253899,719.206970) and (72.792999,715.745972)..(72.792999,711.479980)
    ..controls (72.792999,707.215027) and (76.253899,703.754028)..(80.519501,703.754028)
    ..controls (84.785202,703.754028) and (88.246101,707.215027)..(88.246101,711.479980)
    --cycle;
drawoptions (withcolor (1.000000,1.000000,1.000000));
linejoin := rounded;
fill (80.519501,710.320007)--(75.496101,710.320007)--(75.496101,712.640991)
    --(85.542999,712.640991)--(85.542999,710.320007)--cycle;
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
