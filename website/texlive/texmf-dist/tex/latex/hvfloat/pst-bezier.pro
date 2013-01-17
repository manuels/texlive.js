%% $Id: pst-bezier.pro 87 2009-01-29 10:37:06Z herbert $
%% PostScript prologue for pstricks-add.tex.
%%
%% Version 0.01, 2009/01/29
%%
%% For distribution, see pst-bezier.tex.
%%
%% 
tx@Dict begin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Auxiliary routines:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% [x1 y1] [x2 y2] -> [ x1+y1  x2+y2 ]
/AddArrays2d {
    [ 3 1 roll %% Get the operands
    2 copy
    0 get exch
    0 get add %% first component finished
    %% second component:
    3 1 roll
    1 get exch
    1 get add ]} bind def

%% [x1 y1] [x2 y2] -> [ x1-x2  y1-y2 ]
/SubArrays2d {
    [ 3 1 roll exch
    2 copy
    0 get exch 0 get sub
    3 1 roll
    1 get exch
    1 get sub ] } bind def

%% [x y] s -> [s*x s*y]
/ScaleArray2d {
    [ 3 1 roll exch
    2 copy
    0 get mul
    3 1 roll
    1 get mul
    ] } bind def


%% << [Array of Bezier splines] /K 1 >> -> empty stack
%% Thereby, a Bezier spline is described by an array:
%% [x0 y0 x1 y1 x2 y2 x3 y3 sl sr]
%% (x0,y0) is the right control point
/pstBCurve {
begin %% LaTeX provides the dictionary (see above comments)
    1 1 Splines length 1 sub {
        /K exch def % K is the index of the spline.
%%
	%% First control point:
        Splines K get 0 get dup %% switch the cases /n and /s...
	/n eq { %% `not specified' -> automatically computed
            Splines K get 0 %% l(k) is going to be set...
		%% | -> p(k-1)+(p(k)-p(k-2))*sl(k)
                Splines K get 4 2 getinterval
                Splines K 2 sub get 4 2 getinterval
                SubArrays2d
                Splines K get 6 get ScaleArray2d
                Splines K 1 sub get 4 2 getinterval
                AddArrays2d
            putinterval %% ...setting l(k)
        } if
        /s eq { %% `symmetric' -> compute from r(k-1)
            Splines K get 0 %% l(k):=
		%% | -> 2*p(k-1)-r(k-1)
                Splines K 1 sub get 4 2 getinterval 2 ScaleArray2d
                Splines K 1 sub get 2 2 getinterval SubArrays2d
            putinterval %%
        } if

	%% Second control point:
        Splines K get 2 get dup %% (cases /n and /s)
	/n eq { %% `not specified' -> automatically computed
            Splines K get 2
		%% | -> p(k)+(p(k+1)-p(k-1))*sr(k)
                Splines K 1 sub get 4 2 getinterval
                Splines K 1 add get 4 2 getinterval
                SubArrays2d
                Splines K get 7 get ScaleArray2d
                Splines K get 4 2 getinterval
                AddArrays2d
            putinterval
        } if
        /s eq { %% `symmetric' -> compute from l(k+1)
            Splines K get 2
		%% | -> 2*p(k)-l(k+1)
                Splines K get 4 2 getinterval 2 ScaleArray2d
                Splines K 1 add get 0 2 getinterval SubArrays2d
            putinterval
        } if
    } for %% all splines.
    %%
    %% The current point is already correctly set by the LaTeX macro.
    %% So get ride of the 0th dummy spline.
    Splines 1 Splines length 1 sub getinterval {%
	aload pop pop pop %% get ride of the array itself and the scaling factor.
       curveto% now the actual spline is on the stack...
    } forall %% splines.
    /Points [ %% now save the points for the showpoints-feature.
        Splines 0 get 4 2 getinterval aload pop
        Splines 1 Splines length 1 sub getinterval { aload pop pop pop } forall
        ]
    end def %% Put points in the top dictionary
  } bind def
end %% tx@Dict
