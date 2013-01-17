outputtemplate:="%j.mps";
prologues := 1;
beginfig(1);
  picture trombone;
trombone=image(linecap := butt;
linejoin := mitered;
fill (31.867201,44.898399)--(31.867201,17.500000)..controls (31.867201,9.578130) and (25.421900,3.132810)..(17.500000,3.132810)
    ..controls (9.578130,3.132810) and (3.132810,9.578130)..(3.132810,17.500000)
    --(3.132810,65.632797)..controls (3.132810,71.828102) and (8.171880,76.867203)..(14.367200,76.863297)
    ..controls (20.558599,76.867203) and (25.597700,71.828102)..(25.597700,65.632797)
    --(25.597700,17.500000)..controls (25.597700,13.035200) and (21.964800,9.402340)..(17.500000,9.402340)
    ..controls (13.035200,9.402340) and (9.402340,13.035200)..(9.402340,17.500000)
    --(9.402340,44.898399)--(6.269530,44.898399)--(6.269530,17.500000)
    ..controls (6.269530,11.308600) and (11.304700,6.269530)..(17.500000,6.269530)
    ..controls (23.691401,6.269530) and (28.730499,11.308600)..(28.730499,17.500000)
    --(28.730499,65.632797)..controls (28.730499,73.554703) and (22.289101,80.000000)..(14.367200,80.000000)
    ..controls (6.445310,80.000000) and (0.000000,73.554703)..(0.000000,65.632797)
    --(0.000000,17.500000)..controls (0.000000,7.851560) and (7.851560,0.000000)..(17.500000,0.000000)
    ..controls (27.148399,0.000000) and (35.000000,7.851560)..(35.000000,17.500000)
    --(35.000000,44.898399)--cycle withcolor(.5,.5,.5);
    );


  draw trombone rotated 45;
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
