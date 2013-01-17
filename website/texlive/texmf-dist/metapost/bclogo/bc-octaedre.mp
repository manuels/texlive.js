prologues:=1;
outputtemplate:="%j.mps";
beginfig(1);
drawoptions (withcolor (0.517600,0.047100,0.141200));
fill (8.316410,17.667999)--(15.410200,11.484400)--(2.816410,12.097700)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (8.316410,17.667999)--(15.410200,11.484400)--(2.816410,12.097700)
    --cycle;
drawoptions (withcolor (0.843100,0.078400,0.231400));
pickup pencircle scaled 0.000000bp;
fill (8.316410,1.085940)--(2.816410,12.097700)--(15.410200,11.484400)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (8.316410,1.085940)--(2.816410,12.097700)--(15.410200,11.484400)
    --cycle;
drawoptions (withcolor (0.345100,0.031400,0.094100));
pickup pencircle scaled 0.000000bp;
fill (8.316410,1.085940)--(1.222660,7.265630)--(2.816410,12.097700)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (8.316410,1.085940)--(1.222660,7.265630)--(2.816410,12.097700)
    --cycle;
drawoptions (withcolor (0.164700,0.015700,0.043100));
pickup pencircle scaled 0.000000bp;
fill (8.316410,1.085940)--(15.410200,11.484400)--(13.816400,6.656250)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (8.316410,1.085940)--(15.410200,11.484400)--(13.816400,6.656250)
    --cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (8.316410,1.085940)--(2.816410,12.097700);
draw (15.410200,11.484400)--(2.816410,12.097700);
draw (15.410200,11.484400)--(8.316410,1.085940);
drawoptions (withcolor (0.517600,0.047100,0.141200));
pickup pencircle scaled 0.000000bp;
fill (8.316410,1.085940)--(13.816400,6.656250)--(1.222660,7.265630)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (8.316410,1.085940)--(13.816400,6.656250)--(1.222660,7.265630)
    --cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (8.316410,1.085940)--(1.222660,7.265630);
draw (8.316410,1.085940)--(13.816400,6.656250);
drawoptions (withcolor (0.345100,0.031400,0.094100));
pickup pencircle scaled 0.000000bp;
fill (8.316410,17.667999)--(13.816400,6.656250)--(15.410200,11.484400)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (8.316410,17.667999)--(13.816400,6.656250)--(15.410200,11.484400)
    --cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (15.410200,11.484400)--(8.316410,17.667999);
draw (13.816400,6.656250)--(15.410200,11.484400);
drawoptions (withcolor (0.843100,0.078400,0.231400));
pickup pencircle scaled 0.000000bp;
fill (8.316410,17.667999)--(1.222660,7.265630)--(13.816400,6.656250)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (8.316410,17.667999)--(1.222660,7.265630)--(13.816400,6.656250)
    --cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (1.222660,7.265630)--(13.816400,6.656250);
draw (13.816400,6.656250)--(8.316410,17.667999);
drawoptions (withcolor (0.164700,0.015700,0.043100));
pickup pencircle scaled 0.000000bp;
fill (8.316410,17.667999)--(2.816410,12.097700)--(1.222660,7.265630)
    --cycle;
pickup pencircle scaled 0.100000bp;
draw (8.316410,17.667999)--(2.816410,12.097700)--(1.222660,7.265630)
    --cycle;
drawoptions (withcolor (1.000000,0.713700,0.756900));
pickup pencircle scaled 0.800000bp;
draw (2.816410,12.097700)--(1.222660,7.265630);
draw (8.316410,17.667999)--(2.816410,12.097700);
draw (1.222660,7.265630)--(8.316410,17.667999);
picture pic;
pic:=currentpicture;
currentpicture:=nullpicture;
drawoptions();
draw pic scaled(1.05);
z0=.5*urcorner(currentpicture)+.5*ulcorner(currentpicture);
z1=.5*lrcorner(currentpicture)+.5*llcorner(currentpicture);
draw (z0+(10.5,2));
draw (z1-(10.5,2));
clip currentpicture to ((z0-(8.5pt,0))--(z0+(8.5pt,0))--(z1+(8.5pt,0))--(z1-(8.5pt,0))--cycle);
endfig;
end
