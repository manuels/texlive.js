%                           -*- Mode: Postscript -*-
% pst-math.pro --- PostScript header file pst-math.pro
%
% Author          : Christophe JORSSEN 
% Author          : Herbert Voß <hvoss@tug.org>
% Created the     : Sat 20 March 2004
% Last Mod        : $Date: 2010/10/02 $
% Version         : 0.62 $
%
/PI 3.14159265359 def
/ENeperian 2.71828182846 def
%
/DegToRad {PI mul 180 div} bind def
/RadToDeg {180 mul PI div} bind def
%
/COS {RadToDeg cos} bind def
/SIN {RadToDeg sin} bind def
/TAN {dup SIN exch COS Div} bind def
/tan {dup sin exch cos Div} bind def
/ATAN {neg -1 atan 180 sub DegToRad} bind def
/ACOS {dup dup mul neg 1 add sqrt exch atan DegToRad} bind def
/acos {dup dup mul neg 1 add sqrt exch atan} bind def
/ASIN {neg dup dup mul neg 1 add sqrt neg atan 180 sub DegToRad} bind def
/asin {neg dup dup mul neg 1 add sqrt neg atan 180 sub} bind def
%
/EXP {ENeperian exch exp} bind def
%
/COSH {dup EXP exch neg EXP add 2 div} bind def
/SINH {dup EXP exch neg EXP sub 2 div} bind def
/TANH {dup SINH exch COSH div} bind def
/ACOSH {dup dup mul 1 sub sqrt add ln} bind def
/ASINH {dup dup mul 1 add sqrt add ln} bind def
/ATANH {dup 1 add exch neg 1 add Div ln 2 div} bind def
%
%/SINC {dup SIN exch Div} bind def
/SINC { dup 0 eq { pop 1 } { dup SIN exch div } ifelse } bind def

/GAUSS {dup mul 2 mul dup 4 -2 roll sub dup mul exch div neg EXP exch PI mul sqrt div} bind def
%
/GAMMA { 2 dict begin				% hv 2007-08-30
  /z exch def
  1.000000000190015				% p(0)
  0 1 5 {					% on stack is 0 1 2 3 4 5 
    dup 					% n-1 n-1
    [ 76.18009172947146 
     -86.50532032941677 
      24.0140982483091 
      -1.231739572450155
       0.1208650973866179E-2 
      -0.5395239384953E-5      ] exch get exch 	% p(n) n-1
      1 add z add div			     	% p(n)/(z+n)
      add					% build the sum
    } for
    Pi 2 mul sqrt z div mul
    z 5.5 add z 0.5 add exp mul ENeperian z 5.5 add neg exp mul 
  end } bind def
%    
/GAMMALN {dup dup dup 5.5 add dup ln 3 -1 roll .5 add mul sub neg 1.000000000190015
    0 1 5 {
    [76.18009172947146 -86.50532032941677 24.0140982483091 -1.231739572450155
    .1208650973866179E-2 -.5395239384953E-5 2.5066282746310005] exch get
    4 -1 roll 1 add dup 5 1 roll div add} for
    4 -1 roll div 2.5066282746310005 mul ln add exch pop} bind def
/BETA {2 copy add GAMMALN neg exch GAMMALN 3 -1 roll GAMMALN EXP} bind def
%
/HORNER {aload length
    dup 2 add -1 roll
    exch 1 sub {
        dup 4 1 roll
        mul add exch
    } repeat
    pop
} bind def
%
/BESSEL_J0 {dup abs 8 lt {
    dup mul dup [57568490574 -13362590354 651619640.7 -11214424.18 77392.33017 -184.9052456] HORNER
    exch [57568490411 1029532985 9494680.718 59272.64853 267.8532712 1] HORNER
    Div}
    {abs dup .636619772 exch div sqrt exch dup .785398164 sub exch 8 exch div dup dup mul dup 
    [1 -1.098628627E-2 .2734510407E-4 -.2073370639E-5 .2093887211E-6] HORNER
    3 index COS mul
    exch [-.1562499995E-1 .1430488765E-3 -.6911147651E-5 .7621095161E-6 -.934945152E-7] HORNER
    4 -1 roll SIN mul 3 -1 roll mul neg add mul} 
    ifelse} bind def
%
/BESSEL_Y0 {dup 8 lt {
    dup dup mul dup [-2957821389 7062834065 -512359803.6 10879881.29 -86327.92757 228.4622733] HORNER
    exch [40076544269 745249964.8 7189466.438 47447.26470 226.1030244 1] HORNER
    Div exch dup ln exch BESSEL_J0 .636619772 mul mul add}
    {dup .636619772 exch div sqrt exch dup .785398164 sub exch 8 exch div dup dup mul dup 
    [1 -.1098628627E-2 .2734510407E-4 -.2073370639E-5 .2093887211E-6] HORNER
    3 index SIN mul
    exch [-.1562499995E-1 .1430488765E-3 -.6911147651E-5 .7621095161E-6 -.934945152E-7] HORNER
    4 -1 roll COS mul 3 -1 roll mul add mul} 
    ifelse} bind def
%
/BESSEL_J1 {dup abs 8 lt {
    dup dup mul dup 3 -2 roll [72362614232 -7895059235 242396853.1 -2972611.439 15704.48260 -30.16036606] HORNER mul
    exch [144725228442 2300535178 18583304.74 99447.43394 376.9991397 1] HORNER
    Div}
    {dup abs dup .636619772 exch div sqrt exch dup 2.356194491 sub exch 8 exch div dup dup mul dup 
    [1 .183105E-2 -.3516396496E-4 .2457520174E-5 -.240337019E-6] HORNER
    3 index COS mul
    exch [.04687499995 6.2002690873E-3 .8449199096E-5 -.88228987E-6 .105787412E-6] HORNER
    4 -1 roll SIN mul 3 -1 roll mul neg add mul exch dup abs Div mul} 
    ifelse} bind def
%
/BESSEL_Y1 {dup 8 lt {
    dup dup dup mul dup [-.4900604943E13 .1275274390E13 -.5153428139E11 .7349264551E9 -.4237922726E7 .8511937935E4] HORNER
    exch [.2499580570E14 .4244419664E12 .3733650367E10 .2245904002E8 .1020426050E6 .3549632885E3 1] HORNER
    Div mul exch dup dup ln exch BESSEL_J1 mul exch 1 exch div sub .636619772 mul add}
    {dup .636619772 exch div sqrt exch dup 2.356194491 sub exch 8 exch div dup dup mul dup 
    [1 .183105E-2 -.3516396496E-4 .2457520174E-5 -.240337019E-6] HORNER
    3 index SIN mul
    exch [.04687499995 -.2002690873E-3 .8449199096E-5 6.88228987E-6 .105787412E-6] HORNER
    4 -1 roll COS mul 3 -1 roll mul add mul} 
    ifelse} bind def
%
% En cours...
/BESSEL_Yn {dup 0 eq {pop BESSEL_Y0}{dup 1 eq {pop BESSEL_Y1}{
    exch dup BESSEL_Y0 exch dup BESSEL_Y1 exch 2 exch Div {
        mul 3 -1 roll mul 2 index sub pstack} for
    } ifelse } ifelse } bind def
%
/SIMPSON { 1 dict begin  %% on stack a b var f ierr  Dominik Rodriguez
  3 index 5 index sub                                % compute h
  1                                                  % a b var f ierr h n
  4 index 7 index def 3 index exec                   % a b var f ierr h n f(a)
  5 index 7 index def 4 index exec add               % a b var f ierr h n f(a)+f(b)
  5 index 8 index 4 index 2 div add def 4 index exec % a b var f ierr h n f(a)+f(b) f(a+h/2)
  exch 1 index 4 mul add 0  % a b var f ierr h n old=f(a+h/2) Estim=f(a)+f(b)+4f(a+h/2) NbLoop
    {                                                % a b var f ierr h n old Estim NbLoop
      5 -1 roll 2 div dup 6 1 roll              % h<-h/2
      5 -1 roll 2 mul 5 1 roll                  % n<-2n
                                                % a b var f ierr h n old Estim NbLoop h
      2 div 10 index add 0                      % a b var f ierr h n old Estim NbLoop a+h/2 Cumul
      5 index { 
        1 index 10 index exch def 8 index exec add exch 6 index add exch 
      } repeat                                  % a b var f ierr h n old Estim NbLoop a+nh/2 Cumul
      exch pop                                  % a b var f ierr h n old Estim NbLoop New
      2 index 1 index 4 mul 6 -1 roll 2 mul sub sub % a b var f ierr h n Estim NbLoop New Diff
      4 -1 roll 2 mul 1 index sub 4 1 roll          % a b var f ierr h n Estim NbLoop New Diff
      exch 4 1 roll                             % a b var f ierr h n old Estim NbLoop Diff
      5 index 6 div mul abs 6 index lt { exit } if
      1 add dup 9 eq { exit } if
  } loop                                        % a b var f ierr h n old Estim NbLoop
  exch 5 -1 roll 6 div mul mark 10 2 roll cleartomark
end 
} def
% ------------------------------------ math stuff ----------------------------------
%
% Matrix A in arrays of rows A[[row1][row2]...]
% with [row1]=[a11 a12 ... b1]
% returns on stack solution vector X=[x1 x2 ... xn]
/SolveLinEqSystem { 				% on stack matrix M=[A,b] (A*x=b)
  10 dict begin					% hold all ocal
    /A exch def
    /Rows A length def         			% Rows = number of rows
    /Cols A 0 get length def   			% Cols = number of columns
    /Index [ 0 1 Rows 1 sub { } for ] def	% Index = [0 1 2 ... Rows-1]
    /col 0 def
    /row  0 def
    /PR Rows array def 				% PR[c] = pivot row for row row
  { 						% starts the loop, find pivot entry in row r
    col Cols ge row  Rows ge or { exit } if	% col < Cols and row < Rows else exit
    /pRow row def  				% pRow = pivot row		
    /max A row  get col get abs def		% get A[row[col]], first A[0,0] 
    row 1 add 1 Rows 1 sub { 			% starts for loop 1 1 Rows-1
      /j exch def				% index counter
      /x A j get col get abs def		% get A[j[r]]
      x max gt {				% x>max, then save position
        /pRow j def
        /max x def
      } if
    } for					% now we have the row with biggest A[0,1]
						% with pRow = the pivot row
    max 0 gt {					% swap entries pRow and row  in i 
      /tmp Index row  get def
      Index row  Index pRow get put
      Index pRow tmp put			% and columns pRow and row  in A
      /tmp A row get def
      A row  A pRow get put
      A pRow tmp put   				% pivot
      /row0  A row  get def 			% the pivoting row
      /p0 row0  col get def 			% the pivot value
      row 1 add 1 Rows 1 sub { 			% start for loop
        /j exch def
        /c1 A j get def
        /p c1 col get p0 div def
        c1 col p put				% subtract (p1/p0)*row[i] from row[j]
        col 1 add 1 Cols 1 sub {		% start for loop
          /i exch def
          c1 dup i exch 			% c1 i c1
          i get row0 i get p mul sub put
        } for
      } for
      PR row col put
      /col col 1 add def
      /row row 1 add def
    }{						% all zero entries
      /row row 1 add def			% continue loop with same row
    } ifelse
  } loop
  /X A def					% solution vector
  A Rows 1 sub get dup
  Cols 1 sub get exch
  Cols 2 sub get div
  X Rows 1 sub 3 -1 roll put  			% X[n]
  Rows 2 sub -1 0 {				% for loop to calculate X[i]
    /xi exch def				% current index
    A xi get 					% i-th row
    /Axi exch def
    /sum 0 def
    Cols 2 sub -1 xi 1 add { 
      /n exch def
      /sum sum Axi n get X n get mul add def 
    } for
    Axi Cols 1 sub get 				% b=Axi[Cols-1]
    sum sub 					% b-sum
    Axi xi get div				% b-sum / Axi[xi]
    X xi 3 -1 roll put  			% X[xi]
  } for
  X
  end 
} def
%
/c@_0 2.515517 def 
/c@_1 0.802853 def 
/c@_2 0.010328 def 
/d@_1 1.432788 def 
/d@_2 0.189269 def 
/d@_3 0.001308 def 
/norminv {
  5 dict begin
  neg 1 add 1 exch div ln 2 mul sqrt 
  /t exch def 
  /t2 t dup mul def 
  /t3 t2 t mul def 
  c@_0 c@_1 t mul add c@_2 t2 mul add 1 d@_1 t mul add 
  d@_2 t2 mul add d@_3 t3 mul add div neg t add 
  end
} def 
%end{norminv Michael Sharpe}
%
%
% END pst-math.pro
