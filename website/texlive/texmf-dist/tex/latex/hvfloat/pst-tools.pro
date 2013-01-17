% $Id: pst-tools.pro 622 2012-01-01 15:36:14Z herbert $
%
%% PostScript tools prologue for pstricks.tex.
%% Version 0.02, 2012/01/01
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%
%
/Pi2 1.57079632679489661925640 def
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

%%%%% ### bubblesort ###
%% syntax : array bubblesort --> array2 trie par ordre croissant
%% code de Bill Casselman
%% http://www.math.ubc.ca/people/faculty/cass/graphics/text/www/
/bubblesort { % on stack must be an array [ ... ]
4 dict begin
   /a exch def
   /n a length 1 sub def
   n 0 gt {
      % at this point only the n+1 items in the bottom of a remain to
      % the sorted largest item in that blocks is to be moved up into
      % position n
      n {
         0 1 n 1 sub {
            /i exch def
            a i get a i 1 add get gt {
               % if a[i] > a[i+1] swap a[i] and a[i+1]
               a i 1 add
               a i get
               a i a i 1 add get
               % set new a[i] = old a[i+1]
               put
               % set new a[i+1] = old a[i]
               put
            } if
         } for
         /n n 1 sub def
      } repeat
   } if
   a % return the sorted array
end
} def
%
/concatstringarray{  %  [(a) (b) ... (z)] --> (ab...z)  20100422
  0 1 index { length add } forall 
  string     
  0 3 2 roll      
  { 3 copy putinterval length add }forall 
  pop  
} bind def
%
/dot2comma {% on stack a string (...) 
  2 dict begin
  /Output exch def
  0 1 Output length 1 sub { 
    /Index exch def 
    Output Index get 46 eq { Output Index 44 put } if 
  } for
  Output
  end
} def
%
%-----------------------------------------------------------------------------%
% END pst-tools.pro
