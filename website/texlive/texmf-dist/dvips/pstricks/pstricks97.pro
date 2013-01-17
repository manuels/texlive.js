%!
% PostScript prologue for pstricks.tex.
% Version 97 patch 3, 98/06/01
% For distribution, see pstricks.tex.
%
/tx@Dict 200 dict def tx@Dict begin
/ADict 25 dict def
/CM { matrix currentmatrix } bind def
/SLW /setlinewidth load def
/CLW /currentlinewidth load def
/CP /currentpoint load def
/ED { exch def } bind def
/L /lineto load def
/T /translate load def
/TMatrix { } def
/RAngle { 0 } def
/Atan { /atan load stopped { pop pop 0 } if } def
/Div { dup 0 eq { pop } { div } ifelse } def
/NET { neg exch neg exch T } def
/Pyth { dup mul exch dup mul add sqrt } def
/PtoC { 2 copy cos mul 3 1 roll sin mul } def
/PathLength@ { /z z y y1 sub x x1 sub Pyth add def /y1 y def /x1 x def }
def
/PathLength { flattenpath /z 0 def { /y1 ED /x1 ED /y2 y1 def /x2 x1 def
} { /y ED /x ED PathLength@ } {} { /y y2 def /x x2 def PathLength@ }
/pathforall load stopped { pop pop pop pop } if z } def
/STP { .996264 dup scale } def
/STV { SDict begin normalscale end STP  } def
/DashLine { dup 0 gt { /a .5 def PathLength exch div } { pop /a 1 def
PathLength } ifelse /b ED /x ED /y ED /z y x add def b a .5 sub 2 mul y
mul sub z Div round z mul a .5 sub 2 mul y mul add b exch Div dup y mul
/y ED x mul /x ED x 0 gt y 0 gt and { [ y x ] 1 a sub y mul } { [ 1 0 ]
0 } ifelse setdash stroke } def
/DotLine { /b PathLength def /a ED /z ED /y CLW def /z y z add def a 0 gt
{ /b b a div def } { a 0 eq { /b b y sub def } { a -3 eq { /b b y add
def } if } ifelse } ifelse [ 0 b b z Div round Div dup 0 le { pop 1 } if
] a 0 gt { 0 } { y 2 div a -2 gt { neg } if } ifelse setdash 1
setlinecap stroke } def
/LineFill { gsave abs CLW add /a ED a 0 dtransform round exch round exch
2 copy idtransform exch Atan rotate idtransform pop /a ED .25 .25
% DG/SR modification begin - Dec. 12, 1997 - Patch 2
%itransform translate pathbbox /y2 ED a Div ceiling cvi /x2 ED /y1 ED a
itransform pathbbox /y2 ED a Div ceiling cvi /x2 ED /y1 ED a
% DG/SR modification end
Div cvi /x1 ED /y2 y2 y1 sub def clip newpath 2 setlinecap systemdict
/setstrokeadjust known { true setstrokeadjust } if x2 x1 sub 1 add { x1
% DG/SR modification begin - Jun.  1, 1998 - Patch 3 (from Michael Vulis)
% a mul y1 moveto 0 y2 rlineto stroke /x1 x1 1 add def } repeat grestore }
% def
a mul y1 moveto 0 y2 rlineto stroke /x1 x1 1 add def } repeat grestore
pop pop } def
% DG/SR modification end
/BeginArrow { ADict begin /@mtrx CM def gsave 2 copy T 2 index sub neg
exch 3 index sub exch Atan rotate newpath } def
/EndArrow { @mtrx setmatrix CP grestore end } def
/Arrow { CLW mul add dup 2 div /w ED mul dup /h ED mul /a ED { 0 h T 1 -1
scale } if w neg h moveto 0 0 L w h L w neg a neg rlineto gsave fill
grestore } def
/Tbar { CLW mul add /z ED z -2 div CLW 2 div moveto z 0 rlineto stroke 0
CLW moveto } def
/Bracket { CLW mul add dup CLW sub 2 div /x ED mul CLW add /y ED /z CLW 2
div def x neg y moveto x neg CLW 2 div L x CLW 2 div L x y L stroke 0
CLW moveto } def
/RoundBracket { CLW mul add dup 2 div /x ED mul /y ED /mtrx CM def 0 CLW
2 div T x y mul 0 ne { x y scale } if 1 1 moveto .85 .5 .35 0 0 0
curveto -.35 0 -.85 .5 -1 1 curveto mtrx setmatrix stroke 0 CLW moveto }
def
/SD { 0 360 arc fill } def
/EndDot { { /z DS def } { /z 0 def } ifelse /b ED 0 z DS SD b { 0 z DS
CLW sub SD } if 0 DS z add CLW 4 div sub moveto } def
/Shadow { [ { /moveto load } { /lineto load } { /curveto load } {
/closepath load } /pathforall load stopped { pop pop pop pop CP /moveto
load } if ] cvx newpath 3 1 roll T exec } def
/NArray { aload length 2 div dup dup cvi eq not { exch pop } if /n exch
cvi def } def
/NArray { /f ED counttomark 2 div dup cvi /n ED n eq not { exch pop } if
f { ] aload /Points ED } { n 2 mul 1 add -1 roll pop } ifelse } def
/Line { NArray n 0 eq not { n 1 eq { 0 0 /n 2 def } if ArrowA /n n 2 sub
def n { Lineto } repeat CP 4 2 roll ArrowB L pop pop } if } def
/Arcto { /a [ 6 -2 roll ] cvx def a r /arcto load stopped { 5 } { 4 }
ifelse { pop } repeat a } def
/CheckClosed { dup n 2 mul 1 sub index eq 2 index n 2 mul 1 add index eq
and { pop pop /n n 1 sub def } if } def
/Polygon { NArray n 2 eq { 0 0 /n 3 def } if n 3 lt { n { pop pop }
repeat } { n 3 gt { CheckClosed } if n 2 mul -2 roll /y0 ED /x0 ED /y1
ED /x1 ED x1 y1 /x1 x0 x1 add 2 div def /y1 y0 y1 add 2 div def x1 y1
moveto /n n 2 sub def n { Lineto } repeat x1 y1 x0 y0 6 4 roll Lineto
Lineto pop pop closepath } ifelse } def
/Diamond { /mtrx CM def T rotate /h ED /w ED dup 0 eq { pop } { CLW mul
neg /d ED /a w h Atan def /h d a sin Div h add def /w d a cos Div w add
def } ifelse mark w 2 div h 2 div w 0 0 h neg w neg 0 0 h w 2 div h 2
div /ArrowA { moveto } def /ArrowB { } def false Line closepath mtrx
setmatrix } def
% DG modification begin - Jan. 15, 1997
%/Triangle { /mtrx CM def translate rotate /h ED 2 div /w ED dup 0 eq {
%pop } { CLW mul /d ED /h h d w h Atan sin Div sub def /w w d h w Atan 2
%div dup cos exch sin Div mul sub def } ifelse mark 0 d w neg d 0 h w d 0
%d /ArrowA { moveto } def /ArrowB { } def false Line closepath mtrx
%setmatrix } def
/Triangle { /mtrx CM def translate rotate /h ED 2 div /w ED dup
CLW mul /d ED /h h d w h Atan sin Div sub def /w w d h w Atan 2
div dup cos exch sin Div mul sub def mark 0 d w neg d 0 h w d 0
d /ArrowA { moveto } def /ArrowB { } def false Line closepath mtrx
% DG/SR modification begin - Jun.  1, 1998 - Patch 3 (from Michael Vulis)
% setmatrix } def
setmatrix pop } def
% DG/SR modification end
/CCA { /y ED /x ED 2 copy y sub /dy1 ED x sub /dx1 ED /l1 dx1 dy1 Pyth
def } def
/CCA { /y ED /x ED 2 copy y sub /dy1 ED x sub /dx1 ED /l1 dx1 dy1 Pyth
def } def
/CC { /l0 l1 def /x1 x dx sub def /y1 y dy sub def /dx0 dx1 def /dy0 dy1
def CCA /dx dx0 l1 c exp mul dx1 l0 c exp mul add def /dy dy0 l1 c exp
mul dy1 l0 c exp mul add def /m dx0 dy0 Atan dx1 dy1 Atan sub 2 div cos
abs b exp a mul dx dy Pyth Div 2 div def /x2 x l0 dx mul m mul sub def
/y2 y l0 dy mul m mul sub def /dx l1 dx mul m mul neg def /dy l1 dy mul
m mul neg def } def
/IC { /c c 1 add def c 0 lt { /c 0 def } { c 3 gt { /c 3 def } if }
ifelse /a a 2 mul 3 div 45 cos b exp div def CCA /dx 0 def /dy 0 def }
def
/BOC { IC CC x2 y2 x1 y1 ArrowA CP 4 2 roll x y curveto } def
/NC { CC x1 y1 x2 y2 x y curveto } def
/EOC { x dx sub y dy sub 4 2 roll ArrowB 2 copy curveto } def
/BAC { IC CC x y moveto CC x1 y1 CP ArrowA } def
/NAC { x2 y2 x y curveto CC x1 y1 } def
/EAC { x2 y2 x y ArrowB curveto pop pop } def
/OpenCurve { NArray n 3 lt { n { pop pop } repeat } { BOC /n n 3 sub def
n { NC } repeat EOC } ifelse } def
/AltCurve { { false NArray n 2 mul 2 roll [ n 2 mul 3 sub 1 roll ] aload
/Points ED n 2 mul -2 roll } { false NArray } ifelse n 4 lt { n { pop
pop } repeat } { BAC /n n 4 sub def n { NAC } repeat EAC } ifelse } def
/ClosedCurve { NArray n 3 lt { n { pop pop } repeat } { n 3 gt {
CheckClosed } if 6 copy n 2 mul 6 add 6 roll IC CC x y moveto n { NC }
repeat closepath pop pop } ifelse } def
/SQ { /r ED r r moveto r r neg L r neg r neg L r neg r L fill } def
/ST { /y ED /x ED x y moveto x neg y L 0 x L fill } def
/SP { /r ED gsave 0 r moveto 4 { 72 rotate 0 r L } repeat fill grestore }
def
/FontDot { DS 2 mul dup matrix scale matrix concatmatrix exch matrix
rotate matrix concatmatrix exch findfont exch makefont setfont } def
/Rect { x1 y1 y2 add 2 div moveto x1 y2 lineto x2 y2 lineto x2 y1 lineto
x1 y1 lineto closepath } def
/OvalFrame { x1 x2 eq y1 y2 eq or { pop pop x1 y1 moveto x2 y2 L } { y1
y2 sub abs x1 x2 sub abs 2 copy gt { exch pop } { pop } ifelse 2 div
exch { dup 3 1 roll mul exch } if 2 copy lt { pop } { exch pop } ifelse
/b ED x1 y1 y2 add 2 div moveto x1 y2 x2 y2 b arcto x2 y2 x2 y1 b arcto
x2 y1 x1 y1 b arcto x1 y1 x1 y2 b arcto 16 { pop } repeat closepath }
ifelse } def
/Frame { CLW mul /a ED 3 -1 roll 2 copy gt { exch } if a sub /y2 ED a add
/y1 ED 2 copy gt { exch } if a sub /x2 ED a add /x1 ED 1 index 0 eq {
pop pop Rect } { OvalFrame } ifelse } def
/BezierNArray { /f ED counttomark 2 div dup cvi /n ED n eq not { exch pop
} if n 1 sub neg 3 mod 3 add 3 mod { 0 0 /n n 1 add def } repeat f { ]
aload /Points ED } { n 2 mul 1 add -1 roll pop } ifelse } def
/OpenBezier { BezierNArray n 1 eq { pop pop } { ArrowA n 4 sub 3 idiv { 6
2 roll 4 2 roll curveto } repeat 6 2 roll 4 2 roll ArrowB curveto }
ifelse } def
/ClosedBezier { BezierNArray n 1 eq { pop pop } { moveto n 1 sub 3 idiv {
6 2 roll 4 2 roll curveto } repeat closepath } ifelse } def
/BezierShowPoints { gsave Points aload length 2 div cvi /n ED moveto n 1
sub { lineto } repeat CLW 2 div SLW [ 4 4 ] 0 setdash stroke grestore }
def
/Parab { /y0 exch def /x0 exch def /y1 exch def /x1 exch def /dx x0 x1
sub 3 div def /dy y0 y1 sub 3 div def x0 dx sub y0 dy add x1 y1 ArrowA
x0 dx add y0 dy add x0 2 mul x1 sub y1 ArrowB curveto /Points [ x1 y1 x0
y0 x0 2 mul x1 sub y1 ] def } def
/Grid { newpath /a 4 string def /b ED /c ED /n ED cvi dup 1 lt { pop 1 }
if /s ED s div dup 0 eq { pop 1 } if /dy ED s div dup 0 eq { pop 1 } if
/dx ED dy div round dy mul /y0 ED dx div round dx mul /x0 ED dy div
round cvi /y2 ED dx div round cvi /x2 ED dy div round cvi /y1 ED dx div
round cvi /x1 ED /h y2 y1 sub 0 gt { 1 } { -1 } ifelse def /w x2 x1 sub
0 gt { 1 } { -1 } ifelse def b 0 gt { /z1 b 4 div CLW 2 div add def
/Helvetica findfont b scalefont setfont /b b .95 mul CLW 2 div add def }
if systemdict /setstrokeadjust known { true setstrokeadjust /t { } def }
{ /t { transform 0.25 sub round 0.25 add exch 0.25 sub round 0.25 add
exch itransform } bind def } ifelse gsave n 0 gt { 1 setlinecap [ 0 dy n
div ] dy n div 2 div setdash } { 2 setlinecap } ifelse /i x1 def /f y1
dy mul n 0 gt { dy n div 2 div h mul sub } if def /g y2 dy mul n 0 gt {
dy n div 2 div h mul add } if def x2 x1 sub w mul 1 add dup 1000 gt {
pop 1000 } if { i dx mul dup y0 moveto b 0 gt { gsave c i a cvs dup
stringwidth pop /z2 ED w 0 gt {z1} {z1 z2 add neg} ifelse h 0 gt {b neg}
{z1} ifelse rmoveto show grestore } if dup t f moveto g t L stroke /i i
w add def } repeat grestore gsave n 0 gt
% DG/SR modification begin - Nov. 7, 1997 - Patch 1
%{ 1 setlinecap [ 0 dx n div ] dy n div 2 div setdash }
{ 1 setlinecap [ 0 dx n div ] dx n div 2 div setdash }
% DG/SR modification end
{ 2 setlinecap } ifelse /i y1 def /f x1 dx mul
n 0 gt { dx n div 2 div w mul sub } if def /g x2 dx mul n 0 gt { dx n
div 2 div w mul add } if def y2 y1 sub h mul 1 add dup 1000 gt { pop
1000 } if { newpath i dy mul dup x0 exch moveto b 0 gt { gsave c i a cvs
dup stringwidth pop /z2 ED w 0 gt {z1 z2 add neg} {z1} ifelse h 0 gt
{z1} {b neg} ifelse rmoveto show grestore } if dup f exch t moveto g
exch t L stroke /i i h add def } repeat grestore } def
/ArcArrow { /d ED /b ED /a ED gsave newpath 0 -1000 moveto clip newpath 0
1 0 0 b grestore c mul /e ED pop pop pop r a e d PtoC y add exch x add
exch r a PtoC y add exch x add exch b pop pop pop pop a e d CLW 8 div c
mul neg d } def
/Ellipse { /mtrx CM def T scale 0 0 1 5 3 roll arc mtrx setmatrix } def
/Rot { CP CP translate 3 -1 roll neg rotate NET  } def
/RotBegin { tx@Dict /TMatrix known not { /TMatrix { } def /RAngle { 0 }
def } if /TMatrix [ TMatrix CM ] cvx def /a ED a Rot /RAngle [ RAngle
dup a add ] cvx def } def
/RotEnd { /TMatrix [ TMatrix setmatrix ] cvx def /RAngle [ RAngle pop ]
cvx def } def
/PutCoor { gsave CP T CM STV exch exec moveto setmatrix CP grestore } def
/PutBegin { /TMatrix [ TMatrix CM ] cvx def CP 4 2 roll T moveto } def
/PutEnd { CP /TMatrix [ TMatrix setmatrix ] cvx def moveto } def
/Uput { /a ED add 2 div /h ED 2 div /w ED /s a sin def /c a cos def /b s
abs c abs 2 copy gt dup /q ED { pop } { exch pop } ifelse def /w1 c b
div w mul def /h1 s b div h mul def q { w1 abs w sub dup c mul abs } {
h1 abs h sub dup s mul abs } ifelse } def
/UUput { /z ED abs /y ED /x ED q { x s div c mul abs y gt } { x c div s
mul abs y gt } ifelse { x x mul y y mul sub z z mul add sqrt z add } { q
{ x s div } { x c div } ifelse abs } ifelse a PtoC h1 add exch w1 add
exch } def
/BeginOL { dup (all) eq exch TheOL eq or { IfVisible not { Visible
/IfVisible true def } if } { IfVisible { Invisible /IfVisible false def
} if } ifelse } def
/InitOL { /OLUnit [ 3000 3000 matrix defaultmatrix dtransform ] cvx def
/Visible { CP OLUnit idtransform T moveto } def /Invisible { CP OLUnit
neg exch neg exch idtransform T moveto } def /BOL { BeginOL } def
/IfVisible true def } def
end
% END pstricks.pro
