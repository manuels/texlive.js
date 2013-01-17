%%
%% This is file `nkarta.mp',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% nkarta.dtx  (with options: `MP')
%% -------------------------------------------------------------------
%% Copyright 2002--2009, Daniel H. Luecking
%% 
%% Nkarta is in the public domain
%% 


pt#:=pt;
if (not known FontSize) or (not numeric FontSize):
  numeric FontSize;
  FontSize := 15pt#;
fi
FS# := FontSize/1000;
FS := FS#;

boolean debug; debug:=false;

path P[]; numeric P;
def setP = P[incr P] :=  enddef;

def drawthem =
if debug:                               % debug
  pickup pencircle scaled .4bp;         %
fi                                      %
  for n = 1 upto P:
if debug:                               %
    draw (P[n] scaled FS);              %
else:                                   %
    if ( turningnumber P[n] ) < 0 :
      unfill
    else :
      fill
    fi  (P[n] scaled FS);
fi                                      % debug
  endfor
enddef;


numeric w_, h_, d_;
def beginchar (expr num, wd, ht, dp) =
  beginfig (num); w_:=wd; h_:=ht; d_:=dp;
  P := 0;
enddef;

def endchar =
  drawthem;
  setbounds currentpicture to (0,-d_)--(w_,-d_)--(w_,h_)--(0,h_)--cycle;
  endfig;
enddef;

input nkchars;
end;
%%
%% End of file `nkarta.mp'.
