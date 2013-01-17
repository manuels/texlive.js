% $Id: pst-bspline.pro 2011-07-30 23:45:00Z michael $
%%
%% PostScript prologue for pst-bspline.tex.
%% Version 1.00, 2011/07/30.
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%
%
%
tx@Dict begin
%
% numerically stable cubic root finding
%
/cubic_roots {% solve c3*t^3+c2*t^2+c1*t+c0==0
% call with c3 c2 c1 c0 cubic_root, return solution array roots, numroots, zroot on stack
% zroot is either (a) 2, if no solution in [0,1], or 
% (b) a solution in [0,1].
  15 dict begin % all variables are local
  /numroots 0 def /roots 3 array def /zroot 2 def /epsilon 1e-6 def %
  /c0 ED /c1 ED /c2 ED /c3 ED %
  c3 abs epsilon lt { %quadratic case
    c2 abs epsilon le { c1 abs epsilon ge { %
   roots 0 c0 c1 div neg put /numroots 1 def} if }%
   { %c2 neq 0
   /bb c1 dup mul def %
   /q bb 4 c0 c2 mul mul sub def %
   q abs epsilon lt {  roots 0 c1 c2 -2 mul div put /numroots 1 def } %
     { q 0.0 gt { % in fact, q>= epsilon
       /q q sqrt def %
       c1 0.0 lt { /q q neg def } if %
       /q c1 q add -2 div def %
       roots 0 q c2 div put /numroots 1 def % know |c2|>=epsilon
       q abs epsilon ge { roots numroots c0 q div put /numroots numroots 1 add def } if %
     } if %
      } ifelse } ifelse } %
  {% true cubic
  /c2 c2 c3 div def /c1 c1 c3 div def /c0 c0 c3 div def % normalize
  /Q c2 dup mul 3 c1 mul sub 9 div def /QQQ Q dup dup mul mul def %
  /R c2 dup dup mul mul 2 mul c2 c1 9 mul mul sub 27 c0 mul add 54 div def %
  /RR R dup mul def %
  /c2 c2 3 div def %
  RR QQQ lt {%
    /theta R QQQ sqrt div Acos 3 div def % in degrees
    /numroots 3 def %
    /r2 Q sqrt -2 mul def %
    roots 0 r2 theta cos mul c2 sub put %
    roots 1 r2 theta 120 add cos mul c2 sub put %
    roots 2 r2 theta 120 sub cos mul c2 sub put %
  }{% One or two real roots
    /r0 0 def %
    /A R abs RR QQQ sub sqrt add 1 3 div exp neg def %
    A abs epsilon gt { %
      R 0.0 lt { /A A neg def } if %
      /r0 A Q A div add def } if %
    roots 0 r0 c2 sub put /numroots 1 def %
    A dup mul Q sub abs A abs epsilon mul lt {%
     roots numroots A c2 add neg put /numroots numroots 1 add def } if %
    } ifelse %
  } ifelse %
  0 1 numroots 1 sub {/j ED roots j get dup 2 mul 1 sub abs 1 le { /zroot ED } if } for %
  roots numroots zroot %leave these three items on stack
  end } def %
%
end % tx@Dict
%
% END pst-bspline.pro
