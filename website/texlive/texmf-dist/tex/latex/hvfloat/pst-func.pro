%% $Id: pst-func.pro 391 2010-10-02 16:43:32Z herbert $
%%
%% This is file `pst-func.pro',
%%
%% IMPORTANT NOTICE:
%%
%% Package `pst-func'
%%
%% Herbert Voss <hvoss@tug.org>
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-func' is a PSTricks package to plot special math functions
%%
%%
%% version 0.13 / 2010-06-21  Herbert Voss
%
/tx@FuncDict 100 dict def
tx@FuncDict begin
%
/eps1 1.0e-05 def
/eps2 1.0e-04 def
/eps8 1.0e-08 def
/Pi2 1.57079632679489661925640 def
/CEuler 0.5772156649 def % Euler-Mascheroni constant
%
/factorial { % n on stack, returns n! 
  dup 0 eq { 1 }{ 
    dup 1 gt { dup 1 sub factorial mul } if }
  ifelse } def 
%
/MoverN { % m n on stack, returns the binomial coefficient m over n
  2 dict begin
  /n exch def /m exch def
  n 0 eq { 1 }{
    m n eq { 1 }{
      m factorial n factorial m n sub factorial mul div } ifelse } ifelse 
  end
} def
%
/Pascal [
  [                   1                   ] % 0
  [                 1   1                 ] % 1
  [               1   2   1               ] % 2
  [             1   3   3   1             ] % 3
  [           1   4   6   4   1           ] % 4
  [         1   5  10  10   5   1         ] % 5
  [       1   6  15  20  15   6   1       ] % 6
  [     1   7  21  35  35  21   7   1     ] % 7
  [   1   8  28  56  70  56  28  8    1   ] % 8
  [ 1   9  36  84 126 126  84  36  9    1 ] % 9
] def
%
/GetBezierCoor { 				% t on stack
  10 dict begin					% hold all local
  /t ED
  /t1 1 t sub def				% t1=1-t
  /Coeff Pascal BezierType get def		% get the coefficients
    0 0						% initial values for x y
    BezierType -1 0 {				% BezierType,...,2,1,0
      /I ED					% I=BezierType,...,2,1,0
      /J BezierType I sub def			% J=0,1,2,...,BezierType
      /T t I exp Coeff J get mul def		% coeff(J)*t^I
      /T1 t1 J exp def				% t1^J  
      Points I dup add 1 add get		% y(2*I+1)
      T mul T1 mul add				% the y coordinate
      exch					% y x	
      Points I dup add get			% x(2*I)
      T mul T1 mul add				% the x coordinate
      exch					% x y	
    } for					% x y on stack
  end
} def
%
/BezierCurve { % on stack [ coors psk@plotpoints BezierType
%  10 dict begin
  /BezierType ED
  1 exch div /epsilon ED	
  ] /Points ED 				% yi xi ... y3 x3 y2 x2 y1 x1 y0 x0
  epsilon GetBezierCoor 		% next Bezier point
  Points 0 get Points 1 get 		% starting point
  ArrowA moveto 
  epsilon epsilon 1 {
    /t ED
    t GetBezierCoor
    t 0.9999 lt { lineto }{ 1 epsilon sub GetBezierCoor 4 2 roll ArrowB pop pop pop pop } ifelse 
  } for 
%  end
} def
%
/Bernstein { % on stack tStart tEnd plotpoints i n
  12 dict begin				% hold all local
  /envelope ED				% plot envelope?
  /n ED 
  /i ED
  /ni n i sub def  
  /epsilon ED				% step=1/plotpoints
  /tEnd ED
  /tStart ED
%
% B_{i,n}(t)=\binom{n}{i}t^i(1-t)^{n-i}      (Bernstein)
% f_n(x)=\frac{1}{\sqrt{\pi n\cdot x(1-x)}}  (envelope)
%
  n i MoverN /noveri ED			% \binom{n}{i}
  [					% for the array of points
  tStart epsilon tEnd {
    dup dup /t ED			% leave one on stack
    neg 1 add /t1 ED			% t1=1-t
    envelope 
      { t t1 mul 4 mul Pi2 mul n mul sqrt 1 exch Div }	% envelope
      { noveri t i exp mul t1 ni exp mul } ifelse	% t f(t)
    ScreenCoor				% convert to screen coor
  } for
  end
  false /Lineto /lineto load def Line
} def
%
/Si { % integral sin from 0 to x (arg on stack)
  /arg exch def
  /Sum arg def
  /sign -1 def
  /index 3 def
  { 
    arg index exp index div index factorial div sign mul 
    dup abs eps8 lt { pop exit } if 
    Sum add /Sum exch def
    /sign sign neg def
    /index index 2 add def
  } loop
  Sum
} def
/si { % integral sin from x to infty -> si(x)=Si(x)-pi/2
  Si Pi2 sub
} def
/Ci { % integral cosin from x to infty (arg on stack)
  abs /arg exch def
  arg 0 eq { 0 } { 
    /argExp 1 def
    /fact 1 def
    /Sum CEuler arg ln add def
    /sign -1 def
    /index 2 def
    { 
      /argExp argExp arg arg mul mul def
      /fact fact index 1 sub index mul mul def
      argExp index div fact div sign mul 
      dup abs exch Sum add /Sum exch def
      eps8 lt { exit } if
      /sign sign neg def
      /index index 2 add def
    } loop
    Sum
  } ifelse
} def
/ci { % integral cosin from x to infty -> ci(x)=-Ci(x)+ln(x)+CEuler
  dup Ci neg exch abs ln add CEuler add
} def
%
/MaxIter 255 def
/func { coeff Derivation FuncValue } def
/func' { coeff Derivation 1 add FuncValue } def
/func'' { coeff Derivation 2 add FuncValue } def
%
/NewtonMehrfach {% the start value must be on top of the stack
  /Nx exch def 
  /Iter 0 def
  {
    /Iter Iter 1 add def
    Nx func /F exch def % f(Nx)
    F abs eps2 lt { exit } if
    Nx func' /FS exch def % f'(Nx) 
    FS 0 eq { /FS 1.0e-06 def } if
    Nx func'' /F2S exch def % f''(Nx)
    1.0 1.0 F F2S mul FS dup mul div sub div /J exch def
    J F mul FS div /Diff exch def 
    /Nx Nx Diff sub def
    Diff abs eps1 lt Iter MaxIter gt or { exit } if 
  } loop 
  Nx % the returned value ist the zero point
} def

/Steffensen {% the start value must be on top of the stack
  /y0 exch def % the start value
  /Iter 0 def
  {
    y0 func /F exch def
    F abs eps2 lt { exit } if
    y0 F sub /Phi exch def
    Phi func /F2 exch def
    F2 abs eps2 le { exit }{
      Phi y0 sub dup mul Phi F2 sub 2 Phi mul sub y0 add Div /Diff exch def
      y0 Diff sub /y0 exch def
      Diff abs eps1 le { exit } if
    } ifelse
    /Iter Iter 1 add def
    Iter MaxIter gt { exit } if
  } loop
  y0 % the returned value ist the zero point
} def 
%
/Horner {% x [coeff] must be on top of the stack
  aload length
  dup 2 add -1 roll
  exch 1 sub {
    dup 4 1 roll
    mul add exch
  } repeat
  pop % the y value is on top of the stack
} def
%
/FuncValue {% x [coeff] Derivation must be on top of the stack
  {
    aload 			% a0 a1 a2 ... a(n-1) [array]
    length                      % a0 a1 a2 ... a(n-1) n
    1 sub /grad exch def        % a0 a1 a2 ... a(n-1) 
    grad -1 1 {                 % for n=grad step -1 until 1
      /n exch def               % Laufvariable speichern
      n                         % a0 a1 a2 ... a(n-1) n
      mul                       % a0 a1 a2 ... a(n-1)*n 
      grad 1 add                % a0 a1 a2 ... a(n-1)*n grad+1 
      1 roll                    % an*na0 a1 a2 ... a(n-2)
    } for
    pop                         % loesche a0
    grad array astore           % [ a1 a2 ... a(n-2)]
  } repeat
  Horner
} def
%
/FindZeros { % dxN dxZ must be on top of the stack (x0..x1 the intervall) => []
  12 dict begin 
  /dxZ exch def /dxN exch def
  /pstZeros [] def 
  x0 dxZ x1 { % suche Nullstellen
    /xWert exch def
    xWert NewtonMehrfach 
    %xWert Steffensen 
    /xNull exch def 
    pstZeros aload length /Laenge exch def % now test if value is a new one
    Laenge 0 eq 
      { xNull 1 }
      { /newZero true def
        Laenge {
	  xNull sub abs dxN lt { /newZero false def } if
        } repeat
	pstZeros aload pop
        newZero { xNull Laenge 1 add } { Laenge } ifelse } ifelse
    array astore 
    /pstZeros exch def
  } for
  pstZeros  % the end array is now on the stack
  end
} def
%
/Simpson { % on stack must be a b M   --- simple version ---
% /SFunc must be defined 
  /M ED /b ED /a ED
  /h b a sub M 2 mul div def
  /s1 0 def
  /s2 0 def
  1 1 M {
    /k exch def
    /x k 2 mul 1 sub h mul a add def
    /s1 s1 x SFunc add def
  } for
  1 1 M 1 sub {
    /k exch def
    /x k 2 mul h mul a add def
    /s2 s2 x SFunc add def
  } for
  /I a SFunc b SFunc add s1 4 mul add s2 2 mul add 3 div h mul def
} def
%
/LogGamma { 5 dict begin	% z on stack
  /z ED
  /sum 0 def
  /k 1 def
  {
    z k div dup 1 add ln sub dup
    abs eps8 lt { pop exit } if
    sum add /sum exch def
    /k k 1 add def
  } loop
  sum z ln sub CEuler z mul sub
  end 
} def
%
/ChebyshevT { 5 dict begin	% z on stack
  /xtmp exch def
  /n exch def
  0 0 1 n .5 mul floor {
     /k exch def
     xtmp xtmp mul 1 sub k exp
     xtmp n 2 k mul sub exp mul
     n 2 k mul MoverN mul
     add
  } for
  end
} def
%
/ChebyshevU {5 dict begin	% z on stack
  /xtmp exch def
  /n exch def
  0 0 1 n .5 mul floor {
    /k exch def
    xtmp xtmp mul 1 sub k exp
    xtmp n 2 k mul sub exp mul
    n 1 add 2 k mul 1 add MoverN mul
    add
  } for
  end
} def
%
/vasicek{           %density=sqrt((1-R2)/R2)*exp(1/2*(norminv(x)2 - (1/sqrt(R2)*((sqrt(1-R2)*norminv(x)-norminv(pd)))2))
  2 dict begin
  /pd where { pop }{ /pd 0.22 def } ifelse    % element of (0,1) probability of default of portfolio  
  /R2 where { pop }{ /R2 0.11 def } ifelse    % element of (0,1) R_Squared of portfolio
  dup                 % x   x
  norminv             % x   norminv(x)
  dup mul             % x   norminv(x)^2
  exch                % norminv(x)2   x
  norminv             % norminv(x)2   norminv(x)
  1 R2 sub sqrt mul   % norminv(x)2   sqrt(1-R2)*norminv(x)
  pd norminv sub      % norminv(x)2   sqrt(1-R2)*norminv(x)-norminv(pd)
  R2 sqrt div         % norminv(x)2   1/sqrt(R2)*(sqrt(1-R2)*norminv(x)-norminv(pd))
  dup mul             % norminv(x)2  (1/sqrt(R2)*(sqrt(1-R2)*norminv(x)-norminv(pd)))2
  sub                 % norminv(x)2 -(1/sqrt(R2)*(sqrt(1-R2)*norminv(x)-norminv(pd)))2
  2 div               % 1/2*(norminv(x)2 -(1/sqrt(R2)*(sqrt(1-R2)*norminv(x)-norminv(pd)))2)
  ENeperian exch exp  % exp(1/2*(norminv(x)2 -(1/sqrt(R2)*(sqrt(1-R2)*norminv(x)-norminv(pd)))2)
  1 R2 sub            % exp(1/2*(norminv(x)2 -(1/sqrt(R2)*(sqrt(1-R2)*norminv(x)-norminv(pd)))2)   1-R2
  R2 div              % exp(1/2*(norminv(x)2 -(1/sqrt(R2)*(sqrt(1-R2)*norminv(x)-norminv(pd)))2)   (1-R2)/R2
  sqrt                % exp(1/2*(norminv(x)2 -(1/sqrt(R2)*(sqrt(1-R2)*norminv(x)-norminv(pd)))2)   sqrt((1-R2)/R2)
  mul                 % sqrt((1-R2)/R2)*exp(1/2*(norminv(x)2 - (1/sqrt(R2)*((sqrt(1-R2)*norminv(x)-norminv(pd)))2))
  end
} def
%end{vasicek density}
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subroutines for complex numbers, given as an array [a b] 
% which is a+bi = Real+i Imag
%
/cxadd {		% [a1 b1] [a2 b2] = [a1+a2 b1+b2]
  dup 0 get		% [a1 b1] [a2 b2] a2
  3 -1 roll		% [a2 b2] a2 [a1 b1]
  dup 0 get		% [a2 b2] a2 [a1 b1] a1
  3 -1 roll		% [a2 b2] [a1 b1] a1 a2
  add			% [a2 b2] [a1 b1] a1+a2
  3 1 roll		% a1+a2 [a2 b2] [a1 b1]
  1 get			% a1+a2 [a2 b2] b1
  exch 1 get		% a1+a2 b1 b2
  add 2 array astore
} def
%
/cxneg {		% [a b]
  dup 1 get		% [a b] b
  exch 0 get		% b a
  neg exch neg		% -a -b
  2 array astore
} def
%
/cxsub { cxneg cxadd } def  % same as negative addition
%
% [a1 b1][a2 b2] = [a1a2-b1b2 a1b2+b1a2] = [a3 b3]
/cxmul {		% [a1 b1] [a2 b2]
  dup 0 get		% [a1 b1] [a2 b2] a2
  exch 1 get		% [a1 b1] a2 b2
  3 -1 roll		% a2 b2 [a1 b1]
  dup 0 get		% a2 b2 [a1 b1] a1
  exch 1 get		% a2 b2 a1 b1
  dup			% a2 b2 a1 b1 b1
  5 -1 roll dup		% b2 a1 b1 b1 a2 a2
  3 1 roll mul		% b2 a1 b1 a2 b1a2
  5 -2 roll dup		% b1 a2 b1a2 b2 a1 a1
  3 -1 roll dup		% b1 a2 b1a2 a1 a1 b2 b2
  3 1 roll mul		% b1 a2 b1a2 a1 b2 a1b2
  4 -1 roll add		% b1 a2 a1 b2 b3
  4 2 roll mul		% b1 b2 b3 a1a2
  4 2 roll mul sub	% b3 a3
  exch 2 array astore
} def
%
% [a b]^2 = [a^2-b^2 2ab] = [a2 b2]
/cxsqr {		% [a b]   square root
  dup 0 get exch 1 get	% a b
  dup dup mul		% a b b^2
  3 -1 roll		% b b^2 a
  dup dup mul 		% b b^2 a a^2
  3 -1 roll sub		% b a a2
  3 1 roll mul 2 mul	% a2 b2	
  2 array astore
} def
%
/cxsqrt {		% [a b]
%  dup cxnorm sqrt /r exch def
%  cxarg 2 div RadtoDeg dup cos r mul exch sin r mul cxmake2 
  cxlog 		% log[a b]
  2 cxrdiv 		% log[a b]/2
  aload pop exch	% b a
  2.781 exch exp	% b exp(a)
  exch cxconv exch	% [Re +iIm] exp(a)
  cxrmul		%
} def
%
/cxarg { 		% [a b] 
  aload pop 		% a b
  exch atan 		% arctan b/a
  DegtoRad 		% arg(z)=atan(b/a)
} def
%
% log[a b] = [a^2-b^2 2ab] = [a2 b2]
/cxlog {		% [a b]
  dup 			% [a b][a b]
  cxnorm 		% [a b] |z|
  log 			% [a b] log|z|
  exch 			% log|z|[a b]
  cxarg 		% log|z| Theta
  cxmake2 		% [log|z| Theta]
} def
%
% square of magnitude of complex number
/cxnorm2 {		% [a b]
  dup 0 get exch 1 get	% a b
  dup mul			% a b^2
  exch dup mul add	% a^2+b^2
} def
%
/cxnorm {		% [a b]
  cxnorm2 sqrt
} def
%
/cxconj {		% conjugent complex
  dup 0 get exch 1 get	% a b
  neg 2 array astore	% [a -b]
} def
%
/cxre { 0 get } def	% real value
/cxim { 1 get } def	% imag value
%
% 1/[a b] = ([a -b]/(a^2+b^2)
/cxrecip {		% [a b]
  dup cxnorm2 exch	% n2 [a b]
  dup 0 get exch 1 get	% n2 a b
  3 -1 roll		% a b n2
  dup			% a b n2 n2
  4 -1 roll exch div	% b n2 a/n2
  3 1 roll div		% a/n2 b/n2
  neg 2 array astore
} def
%
/cxmake1 { 0 2 array astore } def % make a complex number, real given
/cxmake2 { 2 array astore } def	  % dito, both given
%
/cxdiv { cxrecip cxmul } def
%
% multiplikation by a real number
/cxrmul {		% [a b] r
  exch aload pop	% r a b
  3 -1 roll dup		% a b r r
  3 1 roll mul		% a r b*r
  3 1 roll mul		% b*r a*r
  exch 2 array astore   % [a*r b*r]
} def
%
% division by a real number
/cxrdiv {		% [a b] r
  1 exch div		% [a b] 1/r
  cxrmul
} def
%
% exp(i theta) = cos(theta)+i sin(theta) polar<->cartesian
/cxconv {		% theta
  RadtoDeg dup sin exch cos cxmake2
} def
%
end
