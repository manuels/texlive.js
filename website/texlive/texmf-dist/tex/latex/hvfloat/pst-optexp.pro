%
% PostScript prologue for pst-optexp.tex.
% version 0.3 2009-11-05 (cb)
% For distribution, see pstricks.tex.
%
/tx@OptexpDict 20 dict def
tx@OptexpDict begin
%
% str1 str2 append str1str2
/strcat {
    exch 2 copy
    length exch length add
    string dup dup 5 2 roll
    copy length exch
    putinterval
} bind def
%
% expects: XB YB  XA YA XG YG
/calcNodes {% def
    /YG exch def /XG exch def
    /ay YG 3 -1 roll sub def
    /ax XG 3 -1 roll sub def
    /by exch YG sub def
    /bx exch XG sub def
    /a ax ay Pyth def
    /modA a def % for external use
    /b bx by Pyth def
    /cx ax a div bx b div add def
    /cy ay a div by b div add def
    /c@tmp cx cy Pyth def
    /c ax bx add ay by add Pyth def
    /OEangle c dup mul a dup mul sub b dup mul sub -2 a b mul mul div Acos def
    %
    % if c=0, then set the coordinates of the vector manually
    % depending on the dotproduct (and thus, if 'a' and 'b'
    % are parallel or antiparallel
    c 0 eq
	{ax bx mul ay by mul add 0 gt
            % if dotprod > 0 then a and b are parallel
		{/cx ax def
              /cy ay def}
             % else a and b are antiparallel
             {/cx ay def
              /cy ax neg def} ifelse
           /c@tmp a def
          } if
        /X@A XG cx c@tmp div add def
        /Y@A YG cy c@tmp div add def
        /X@B XG cx c@tmp div sub def
        /Y@B YG cy c@tmp div sub def
        %
        % chirality:
        % test the order of the input points as a input angle > 90°
        % doesn't really make sens.
        % So if 'chir' <= 0 exchange the calculated coordinates of 
        % A and B and otherwise leave it as is
	/chirality ax by mul ay bx mul sub def
	chirality 0 le
          {Y@A X@A 
           /X@A X@B def
           /Y@A Y@B def
           /X@B exch def
           /Y@B exch def}if
} bind def
%
% called with: R1 height
% leaves on stack: a1
/segLen {% def
    dup mul neg exch abs dup 3 1 roll dup mul add sqrt sub
} bind def
%
% called with:  height R1
% leaves on stack: y |R1| alpha_bottom alpha_top R1
/leftConvex {% def
   /R1 exch def /h exch def
   /a1  R1 h segLen def
   0 R1 abs
   R1 a1 sub neg dup
   h exch atan exch
   h neg exch atan
   /ArcL /arc load def
   R1
} bind def
%
% called with: height R1
% leaves on stack: y |R1| alpha_bottom alpha_top R1
/leftConcave {% def
   /R1 exch def /h exch def
   /a1 R1 h segLen def
   0 R1 abs
   R1 neg a1 sub dup
   h exch atan exch
   h neg exch atan
   /ArcL /arcn load def
   /a1 0.5 a1 mul def
   R1
} bind def
%
% called with: height R2
% leaves on stack: y |R2| alpha_bottom alpha_top R2
/rightConvex {%def
   /R2 exch def /h exch def
   /a2 R2 h segLen def
   0 R2 abs
   R2 a2 sub dup
   h neg exch atan exch
   h exch atan
   R2
   /ArcR /arc load def
} bind def
%
% called with: height R2
% leaves on stack: y |R2| alpha_bottom alpha_top R2
/rightConcave {%def
   /R2 exch def /h exch def
   /a2 R2 h segLen def
   0 R2 abs
   R2 a2 add dup
   h neg exch atan exch
   h exch atan
   /ArcR /arcn load def
   /a2 0.5 a2 mul def
   R2
} bind def
%
/mwNode {%def
    exch 3 1 roll add 2 div 3 1 roll add 2 div exch
} bind def
%
/FiberAngleB {%
    N@tempNode@A GetCenter N@tempNode@B GetCenter exch 3 1 roll sub 3 1 roll sub atan
} bind def
%
/FiberAngleA {%
    FiberAngleB 180 add
} bind def
%
/ExtNode {%
    @@x0 @xref @@x mul add 
    @@y0 @yref @@y mul add 
} bind def
% basicnodename reverse GetInternalNodeNames
/GetInternalNodeNames {% def
    /reverse exch def
    (N@) exch strcat 
    1 % counter
    {% counter and name on stack
	2 copy dup 3 string cvs 3 -1 roll exch strcat dup
	tx@NodeDict exch known {%
	    reverse { 4 1 roll pop } { exch 2 add 1 roll } ifelse
	} {
	    reverse { pop pop pop (N) strcat } { pop pop exch (N) strcat exch 1 roll } ifelse
	    exit
	} ifelse
	1 add
    } loop
} bind def
%
% basicnodename reverse GetInternalBeamNodes x_n y_n ... x_1 y_1 (if reverse = false)
/GetInternalBeamNodes {% def
    [ 3 1 roll GetInternalNodeNames ]
    { cvn tx@NodeDict begin load GetCenter end } forall
} bind def
%
%
/InitOptexpComp {%
    tx@Dict begin
	/@@x 0 def
	/@@y 0 def
	/@@x0 0 def
	/@@y0 0 def
        /@xref 0 def
        /@yref 0 def
    end
} bind def
%
% defaultbasicnodename basicnodename CloseOptexpComp
/CloseOptexpComp {% def
    2 copy eq {
	exch pop [ exch false GetInternalNodeNames ] { tx@NodeDict exch undef } forall
    } { pop pop } ifelse
} bind def
%
% xa ya xb yb ExchCoor true|false
/ExchCoor {% def
    exch 4 -1 roll% ya yb xb xa
    2 copy % ya yb xb xa
    gt 
    { pop pop pop pop false } % xB > xA
    { eq % xA == xB
	3 1 roll gt % yA < yB
	and
        { false } 
        { true } ifelse
    } ifelse
} bind def
end % tx@OptexpDict
