%!
TeXDict begin
/!BP{ 72 72.27 div dup scale } def /!smartarct { /!r exch def /!y2
exch def /!x2 exch def /!y1 exch def /!x1 exch def currentpoint /!y0
exch def /!x0 exch def /!d0 !y0 !y1 sub dup mul !x0 !x1 sub dup mul
add sqrt def /!d2 !y2 !y1 sub dup mul !x2 !x1 sub dup mul add sqrt
def !d0 !d2 add 0 gt { !d0 !d2 le { /!xp !x1 !x2 !x1 sub !d0 mul !d2
div add def /!yp !y1 !y2 !y1 sub !d0 mul !d2 div add def /!d !yp !y0
sub dup mul !xp !x0 sub dup mul add sqrt 2 div def } { /!xp !x1 !x0
!x1 sub !d2 mul !d0 div add def /!yp !y1 !y0 !y1 sub !d2 mul !d0 div
add def /!d !yp !y2 sub dup mul !xp !x2 sub dup mul add sqrt 2 div
def } ifelse } { /!d 0 def } ifelse !d !r lt { /!r !d def } if !x1
!y1 !x2 !y2 !r arct } def /!psarrow { gsave 2 copy translate 3 -1 roll
sub neg /!y exch def sub /!x exch def !x 0 eq !y 0 eq and {/!x 1 def}
if !y !x atan rotate /L2 exch def /L1 exch def /ang exch def /dist
exch def /nb exch def 1 1 nb { pop L2 0 eq { newpath L1 ang cos mul
L1 ang sin mul 2 copy moveto 0 0 lineto neg lineto stroke } { newpath
0 0 moveto L1 ang cos mul L1 ang sin mul 2 copy lineto L2 0 lineto
neg lineto closepath fill } ifelse dist 0 translate } for grestore
} def /!psvect { /y exch def /x exch def newpath 0 0 moveto x y lineto
stroke 0 0 x y !psarrow x y 0 0 !psarrow } def /!pslines { /ra exch
def /n exch def /yn exch def /xn exch def /yn_1 exch def /xn_1 exch
def /x xn def /y yn def /xx xn_1 def /yy yn_1 def newpath xn yn moveto
3 1 n { pop /x xx def /y yy def /yy exch def /xx exch def x y xx yy
ra !smartarct } for xx yy lineto stroke xn_1 yn_1 xn yn !psarrow x
y xx yy !psarrow } def /!psrectpath { /y1 exch def /x1 exch def /y0
exch def /x0 exch def newpath x0 y0 moveto x1 y0 lineto x1 y1 lineto
x0 y1 lineto closepath } def /!pscirclepath { newpath 0 360 arc closepath
} def /!psovalpath { /rmax exch dup 0.1 le { pop 0.1 } if def /H exch
2 div dup 0.1 le { pop 0.1 } if def /W exch 2 div dup 0.1 le { pop
0.1 } if def /y exch def /x exch def H W le { /R H def }{ /R W def
} ifelse rmax R le { /R rmax def } if newpath x y H add moveto x W
add y H add x W add y R arct x W add y H sub x y H sub R arct x W sub
y H sub x W sub y R arct x W sub y H add x y H add R arct closepath
} def /!pspolygonpath { /ra exch def /n exch def dup n 2 mul 1 add
1 roll 1 index n 2 mul 2 add 1 roll n 2 mul 1 sub index n 2 mul 1 sub
index /yy exch def /xx exch def /y exch def /x exch def newpath xx
x add 2 div yy y add 2 div moveto 1 1 n { pop /yy exch def /xx exch
def x y x xx add 2 div y yy add 2 div ra !smartarct /x xx def /y yy
def } for closepath } def /!psrpolygonpath { /rd exch def /ra exch
def /a exch def /r exch def /n exch def /y exch def /x exch def /b
360 n div def /c b def x y translate a rotate rd 0 ne { r rd b 2 div
cos div sub r div dup scale } if /x1 r b cos mul def /y1 r b sin mul
def newpath r x1 add 2 div y1 2 div moveto 1 1 n { pop /c c b add def
/x2 r c cos mul def /y2 r c sin mul def x1 y1 x1 x2 add 2 div y1 y2
add 2 div ra !smartarct /x1 x2 def /y1 y2 def } for closepath rd 0
ne { r r rd b 2 div cos div sub div dup scale } if a neg rotate x neg
y neg translate } def /!psccurvepath { /n exch def n 2 mul 1 sub index
n 2 mul 1 sub index n 2 mul 1 sub index n 2 mul 1 sub index n 2 mul
4 add array astore /coef exch def /alpha 3.5 def /px0 coef n 2 mul
2 sub get def /py0 coef n 2 mul 1 sub get def /px1 coef 0 get def /py1
coef 1 get def /px2 coef 2 get def /py2 coef 3 get def /d0 px1 px0
sub dup mul py1 py0 sub dup mul add sqrt def /d2 px1 px2 sub dup mul
py1 py2 sub dup mul add sqrt def /ppx d2 d0 div px0 px1 sub mul px1
add def /ppy d2 d0 div py0 py1 sub mul py1 add def /d1 ppx px2 sub
dup mul ppy py2 sub dup mul add sqrt def /qx d2 d1 div px2 ppx sub
mul alpha div px1 add def /qy d2 d1 div py2 ppy sub mul alpha div py1
add def newpath px1 py1 moveto 4 2 n 2 mul 2 add { /i exch def /px0
px1 def /px1 px2 def /px2 coef i get def /py0 py1 def /py1 py2 def
/py2 coef i 1 add get def /d0 d2 def /d2 px1 px2 sub dup mul py1 py2
sub dup mul add sqrt def /ppx d0 d2 div px2 px1 sub mul px1 add def
/ppy d0 d2 div py2 py1 sub mul py1 add def /d1 ppx px0 sub dup mul
ppy py0 sub dup mul add sqrt def /rx d0 d1 div px0 ppx sub mul alpha
div px1 add def /ry d0 d1 div py0 ppy sub mul alpha div py1 add def
qx qy rx ry px1 py1 curveto /ppx d2 d0 div px0 px1 sub mul px1 add
def /ppy d2 d0 div py0 py1 sub mul py1 add def /d1 ppx px2 sub dup
mul ppy py2 sub dup mul add sqrt def /qx d2 d1 div px2 ppx sub mul
alpha div px1 add def /qy d2 d1 div py2 ppy sub mul alpha div py1 add
def } for closepath } def /!pscurve { /n exch def n 2 mul array astore
/coef exch def /alpha 3.5 def /px1 coef 0 get def /py1 coef 1 get def
/px2 coef 2 get def /py2 coef 3 get def /d2 px1 px2 sub dup mul py1
py2 sub dup mul add sqrt def /qx px1 def /qy py1 def newpath px1 py1
moveto 4 2 n 2 mul 2 sub { /i exch def /px0 px1 def /px1 px2 def /px2
coef i get def /py0 py1 def /py1 py2 def /py2 coef i 1 add get def
/d0 d2 def /d2 px1 px2 sub dup mul py1 py2 sub dup mul add sqrt def
/ppx d0 d2 div px2 px1 sub mul px1 add def /ppy d0 d2 div py2 py1 sub
mul py1 add def /d1 ppx px0 sub dup mul ppy py0 sub dup mul add sqrt
def /rx d0 d1 div px0 ppx sub mul alpha div px1 add def /ry d0 d1 div
py0 ppy sub mul alpha div py1 add def qx qy rx ry px1 py1 curveto /ppx
d2 d0 div px0 px1 sub mul px1 add def /ppy d2 d0 div py0 py1 sub mul
py1 add def /d1 ppx px2 sub dup mul ppy py2 sub dup mul add sqrt def
/qx d2 d1 div px2 ppx sub mul alpha div px1 add def /qy d2 d1 div py2
ppy sub mul alpha div py1 add def } for /px1 coef n 2 mul 2 sub get
def /py1 coef n 2 mul 1 sub get def /rx px1 def /ry py1 def qx qy rx
ry px1 py1 curveto stroke /px0 coef n 2 mul 6 sub get def /py0 coef
n 2 mul 5 sub get def /px1 coef n 2 mul 4 sub get def /py1 coef n 2
mul 3 sub get def /px2 coef n 2 mul 2 sub get def /py2 coef n 2 mul
1 sub get def /d0 px1 px0 sub dup mul py1 py0 sub dup mul add sqrt
def /d2 px1 px2 sub dup mul py1 py2 sub dup mul add sqrt def /ppx d2
d0 div px0 px1 sub mul px1 add def /ppy d2 d0 div py0 py1 sub mul py1
add def /d1 ppx px2 sub dup mul ppy py2 sub dup mul add sqrt def /qx
d2 d1 div px2 ppx sub mul alpha div px1 add def /qy d2 d1 div py2 ppy
sub mul alpha div py1 add def px1 py1 qx qy px2 py2 px2 py2 !ps_cbezier_arrow
/px0 coef 0 get def /py0 coef 1 get def /px1 coef 2 get def /py1 coef
3 get def /px2 coef 4 get def /py2 coef 5 get def /d0 px1 px0 sub dup
mul py1 py0 sub dup mul add sqrt def /d2 px1 px2 sub dup mul py1 py2
sub dup mul add sqrt def /ppx d0 d2 div px2 px1 sub mul px1 add def
/ppy d0 d2 div py2 py1 sub mul py1 add def /d1 ppx px0 sub dup mul
ppy py0 sub dup mul add sqrt def /rx d0 d1 div px0 ppx sub mul alpha
div px1 add def /ry d0 d1 div py0 ppy sub mul alpha div py1 add def
px1 py1 rx ry px0 py0 px0 py0 !ps_cbezier_arrow } def /!ps_cbezier
{ /y3 exch def /x3 exch def /y2 exch def /x2 exch def /y1 exch def
/x1 exch def /y0 exch def /x0 exch def newpath x0 y0 moveto x1 y1 x2
y2 x3 y3 curveto stroke x0 y0 x1 y1 x2 y2 x3 y3 !ps_cbezier_arrow x3
y3 x2 y2 x1 y1 x0 y0 !ps_cbezier_arrow } def /!ps_cbezier_arrow { /y3
exch def /x3 exch def /y2 exch def /x2 exch def /y1 exch def /x1 exch
def /y0 exch def /x0 exch def /xa x1 x2 sub 3 mul x3 x0 sub add def
/xb x0 x1 sub x1 sub x2 add 3 mul def /xc x1 x0 sub 3 mul def /ya y1
y2 sub 3 mul y3 y0 sub add def /yb y0 y1 sub y1 sub y2 add 3 mul def
/yc y1 y0 sub 3 mul def /L2 exch def /L1 exch def /ang exch def /dist
exch def /nb exch def L2 0 le { /L L1 ang cos mul 2 div def } { /L
L2 def } ifelse /t4 1 def 1 1 nb { pop /x4 t4 !calculx def /y4 t4 !calculy
def L 0 le { /dx t4 !calculdx def /dy t4 !calculdy def dx dup mul dy
dup mul add sqrt dup 0 eq { /dx 1 def /dy 0 def pop 1 } if L1 exch
div dup dx neg mul /xx exch def dy neg mul /yy exch def } { /t1 0 def
/t2 t4 def 0 1 !max { pop /t t1 t2 add 2 div def t !calculx x4 sub
dup mul t !calculy y4 sub dup mul add sqrt L ge { /t1 t def } { /t2
t def } ifelse } for /x6 t !calculx def /y6 t !calculy def L1 L div
dup x6 x4 sub mul /xx exch def y6 y4 sub mul /yy exch def } ifelse
/x5 x4 xx ang cos mul add yy ang sin mul sub def /y5 y4 xx ang sin
mul add yy ang cos mul add def /x7 x4 xx ang cos mul add yy ang sin
mul add def /y7 y4 xx ang sin mul sub yy ang cos mul add def L2 0 le
{ newpath x5 y5 moveto x4 y4 lineto x7 y7 lineto stroke } { newpath
x4 y4 moveto x5 y5 lineto x6 y6 lineto x7 y7 lineto closepath fill
} ifelse /t1 0 def /t2 t4 def 0 1 !max { pop /t t1 t2 add 2 div def
t !calculx x4 sub dup mul t !calculy y4 sub dup mul add sqrt dist ge
{ /t1 t def } { /t2 t def } ifelse } for /t4 t def } for } def /!ps_qbezier
{ /y3 exch def /x3 exch def /yy exch def /xx exch def /y0 exch def
/x0 exch def /x1 xx 2 mul x0 add 3 div def /y1 yy 2 mul y0 add 3 div
def /x2 xx 2 mul x3 add 3 div def /y2 yy 2 mul y3 add 3 div def x0
y0 x1 y1 x2 y2 x3 y3 !ps_cbezier } def /!max 10 def /!ps_r_cbezier
{ /y3 exch def /x3 exch def /y2 exch def /x2 exch def /y1 exch def
/x1 exch def /y0 exch def /x0 exch def /xa x1 x2 sub 3 mul x3 x0 sub
add def /xb x0 x1 sub x1 sub x2 add 3 mul def /xc x1 x0 sub 3 mul def
/ya y1 y2 sub 3 mul y3 y0 sub add def /yb y0 y1 sub y1 sub y2 add 3
mul def /yc y1 y0 sub 3 mul def /t1 0 def /t2 1 def 0 1 !max { pop
/t t1 t2 add 2 div def t !calculx t !calculy path!a inufill { /t1 t
def } { /t2 t def } ifelse } for /ta t def /t1 0 def /t2 1 def 0 1
!max { pop /t t1 t2 add 2 div def t !calculx t !calculy path!b inufill
{ /t2 t def } { /t1 t def } ifelse } for /tb t def ta !calculx ta !calculy
ta !calculdx 3 div tb ta sub mul ta !calculx add ta !calculdy 3 div
tb ta sub mul ta !calculy add tb !calculdx 3 div ta tb sub mul tb !calculx
add tb !calculdy 3 div ta tb sub mul tb !calculy add tb !calculx tb
!calculy !ps_cbezier } def /!calculx { dup dup xa mul xb add mul xc
add mul x0 add } def /!calculy { dup dup ya mul yb add mul yc add mul
y0 add } def /!calculdx { dup 3 xa mul mul 2 xb mul add mul xc add
} def /!calculdy { dup 3 ya mul mul 2 yb mul add mul yc add } def /!node_mark
{ /ma exch def /ml exch def /y exch def /x exch def /x1 x def /y1 y
def /x2 x 500 ma cos mul add def /y2 y 500 ma sin mul add def 0 1 !max
{ pop /x x1 x2 add 2 div def /y y1 y2 add 2 div def x y path!a inufill
{ /x1 x def /y1 y def } { /x2 x def /y2 y def } ifelse } for /x1 x
def /y1 y def /x2 x ml ma cos mul add def /y2 y ml ma sin mul add def
newpath x1 y1 moveto x2 y2 lineto stroke x2 y2 x1 y1 !psarrow x1 y1
x2 y2 !psarrow } def /!sign {dup 0 lt {pop -1} {0 eq {0} {1} ifelse}
ifelse} def /!pslatexline { /L exch def /b exch def /a exch def a 0
eq {0 L b !sign mul} {L a !sign mul dup b mul a div} ifelse newpath
0 0 moveto lineto stroke } def /!pslatexvector { /L exch def /b exch
def /a exch def a 0 eq {0 L b !sign mul} {L a !sign mul dup b mul a
div} ifelse !psvect } def /!pscircle { 2 div newpath 0 0 3 2 roll 0
360 arc stroke } def /!psdisk { 2 div newpath 0 0 3 2 roll 0 360 arc
fill } def
end