%% psMath.pro (c) Aug 28, 1996 Matthias T. Kromann
%% version 0.02 2009/11/08  changes to knot subroutines
%%                          (hv)
/tx@KnotDict 11 dict def
tx@KnotDict begin
/PSMsysd 200 dict def
/PSMusrd 200 dict def
/PSMtexd 200 dict def
/PSMinit {
  PSMtexd begin
  PSMsysd begin
  PSMusrd begin
  line-std
  Times setfontfamily 10 setfontsize 0 setfontstyle setupfont
  -1 0 TeXsetfill
} def
/PSMclose { end end end } def
/PSMreload { PSMclose (psm.pro) run PSMinit } def
/PSMni { (not implemented) = } def
% -----------------------------------------------------------------
PSMsysd begin
  /bdef {bind def} bind def
  /xdef {exch def} bdef
  /lidef {
    0 begin /ini xdef /vars xdef cvlit dup /value xdef
    length 3 add array /obj xdef
    /obj load 0 vars dict begin ini currentdict end put
    /obj load 1 {begin} putinterval
    /obj load 2 /value load putinterval
    /obj load dup length 1 sub {end} putinterval
    /obj load cvx end def
  } def
  /lidef load 0 4 dict put
  /ldef { {} lidef } def
  /pt {1 mul} def
  /mm {2.845 mul} def
  /cm {28.45 mul} def
  /inch {72.27 mul} def
  /un {1 mm mul} def
  /black	{ 0 setgray } def
  /white	{ 1 setgray } def
  /gray		{ 0.5 setgray } def
  /darkgray	{ 0.25 setgray } def
  /lightgray	{ 0.75 setgray } def
  /red		{ 1 0 0 setrgbcolor } def
  /green	{ 0 1 0 setrgbcolor } def
  /blue		{ 0 0 1 setrgbcolor } def
  /cyan		{ 0 1 1 setrgbcolor } def
  /magenta	{ 1 0 1 setrgbcolor } def
  /yellow	{ 1 1 0 setrgbcolor } def
  /gold		{ 0.93 0.93 0.4 setrgbcolor } def
  /thin { 0.5 setlinewidth } def
  /medium { 1 setlinewidth } def
  /thick { 2 setlinewidth } def
  /lw-std { thin } def
  /lw-dec { currentlinewidth 2 div setlinewidth } def
  /lw-inc { currentlinewidth 2 mul setlinewidth } def
  /nodash { [] 0 setdash } def
  /dash { [2 2] 0 setdash } def
  /line-std { lw-std nodash 0 setgray } def
% -----------------------------------------------------------------
PSMtexd begin
  /ISOfont { % font ISOfont
    /isofont xdef /font xdef
    font findfont
    dup length dict begin
      { 1 index /FID ne {def} {pop pop} ifelse 
      } forall
      /Encoding ISOLatin1Encoding def
      currentdict
    end
    isofont exch definefont pop
  } 2 ldef
  /Times-Roman /Times-Roman-ISOLatin1 ISOfont
  /Times-Bold /Times-Bold-ISOLatin1 ISOfont
  /Times-Italic /Times-Italic-ISOLatin1 ISOfont
  /Times-BoldItalic /Times-BoldItalic-ISOLatin1 ISOfont
  /Times [(ptm) /Times-Roman-ISOLatin1 /Times-Bold-ISOLatin1
    /Times-Italic-ISOLatin1 /Times-BoldItalic-ISOLatin1] def
  /Helvetica /Helvetica-ISOLatin1 ISOfont
  /Helvetica-Bold /Helvetica-Bold-ISOLatin1 ISOfont
  /Helvetica-Oblique /Helvetica-Oblique-ISOLatin1 ISOfont
  /Helvetica-BoldOblique /Helvetica-BoldOblique-ISOLatin1 ISOfont
  /Helvetica [(phv) /Helvetica-ISOLatin1 /Helvetica-Bold-ISOLatin1
    /Helvetica-Oblique-ISOLatin1 /Helvetica-BoldOblique-ISOLatin1] def
  /Symbol [(psy) /Symbol /Symbol /Symbol /Symbol] def
  /getfontfamily {PSMtexd /fontfamily get} def
  /setfontfamily {PSMtexd /fontfamily 3 -1 roll put} def
  /getfontsize {PSMtexd /fontsize get} def
  /setfontsize {PSMtexd /fontsize 3 -1 roll put} def
  /getfontstyle {PSMtexd /fontstyle get} def
  /setfontstyle {PSMtexd /fontstyle 3 -1 roll put} def
  /setupfont {
    font 0 getfontfamily 0 get putinterval
    font 3 getfontstyle 1 add 1000 mul fontsize cvi add
    fontext cvs putinterval
    PSMtexd font cvn known not {
      PSMtexd font cvn getfontfamily getfontstyle 1 add get
      findfont getfontsize scalefont put } if
    font cvn cvx exec setfont
  } 2 { /font 7 string def /fontext 4 string def } lidef
end
% -----------------------------------------------------------------
/pi 3.1415926535 def
/sqr {dup mul} def
/sgn {dup 0 gt {pop 1} {0 lt {-1} {0} ifelse} ifelse} def
/min
	{	/B xdef /A xdef
		A type /arraytype eq {/a A 0 get def} {/a A def} ifelse
		B type /arraytype eq {/b B 0 get def} {/b B def} ifelse
		a b gt {B} {A} ifelse
	} 4 ldef
 /max
	 {	/B xdef /A xdef
 		A type /arraytype eq {/a A 0 get def} {/a A def} ifelse
 		B type /arraytype eq {/b B 0 get def} {/b B def} ifelse
 		a b gt {A} {B} ifelse
	 } 4 ldef
/acos {dup sqr 1 exch sub sqrt exch atan} def
/asin {dup sqr 1 exch sub sqrt atan} def
/extrema
	{	/fct xdef /t2 xdef /t1 xdef
		/t t1 def /ft t1 fct def
		1/T t1 def /fT t1 fct def
		t1 t2 t1 sub 200 div t2
			{	/x xdef /fx x fct def
				fx ft lt {/t x def /ft fx def} if
				fx fT gt {/T x def /fT fx def} if
			} for
		t T
	} 9 ldef
/p2r*
	{	/v xdef aload pop /phi xdef /r xdef
		phi cos r mul phi sin r mul v astore
	} 3 ldef
/p2r {2 array p2r*} def
/r2p*
	{	/v xdef aload pop /y xdef /x xdef
		x x mul y y mul add sqrt y x atan v astore
	} 3 ldef
/r2p {2 array r2p*} def
/rotpnt*
	{	/v xdef /angle xdef aload pop /y xdef /x xdef
			angle cos x mul angle sin y mul sub
			angle sin x mul angle cos y mul add v astore
	} 4 ldef
/rotpnt {2 array rotpnt*} def
/p2l*
	{	/v xdef aload pop /qy xdef /qx xdef aload pop /py xdef /px xdef
		/a py qy sub def /b qx px sub def
		a b a qx mul b qy mul add v astore
	} 7 ldef
/p2l {3 array p2l*} def
/l2p*
	{	/v xdef aload pop /c2 xdef /b2 xdef /a2 xdef
		aload pop /c1 xdef /b1 xdef /a1 xdef
		/det a1 b2 mul a2 b1 mul sub def
			c1 b2 mul c2 b1 mul sub det div
			a1 c2 mul a2 c1 mul sub det div
		v astore
	} 8 ldef
/l2p {2 array l2p*} def
/altitude*
	{	/r xdef /C xdef /B xdef /A xdef
		A B l p2l* pop
		A B v vsub* 90 v rotpnt* C v vadd* C m p2l* pop
		l m r l2p*
	} 7 {/v 2 array def /l 3 array def /m 3 array def} lidef
/altitude {2 array altitude*} def
/angle
	{	pnt2num /qy exch def /qx exch def
		pnt2num /py exch def /px exch def
		qy py sub qx px sub 2 copy abs exch abs add 0 eq
			{pop pop -360} {atan} ifelse
	} 4 ldef
/vaddsub*
	{	/addsub xdef /uv xdef /v xdef /u xdef /i 0 def
		u {v i get addsub /i i 1 add def} forall
		uv astore
	} 5 ldef
/vadd* {{add} vaddsub*} def
/vadd {dup length array {add} vaddsub*} def
/vsub* {{sub} vaddsub*} def
/vsub {dup length array {sub} vaddsub*} def
/smuldiv*
	{	/muldiv xdef /As xdef /A xdef /s xdef
		A {s muldiv} forall As astore
	} 4 ldef
/smul*
	{	3 1 roll dup type /arraytype eq not {exch} if
		3 -1 roll {mul} smuldiv*} def
/smul
	{	dup type /arraytype eq not {exch} if dup length array
		{mul} smuldiv*} def
/sdiv*
	{	3 1 roll dup type /arraytype eq not {exch} if
		3 -1 roll {div} smuldiv*} def
/sdiv
	{	dup type /arraytype eq not {exch} if dup length array
		{div} smuldiv*} def
/norm {0 exch {dup mul add} forall sqrt} def
/ip
	{	/B xdef /A xdef /i 0 def
		0 A {B i get mul add /i i 1 add def} forall
	} 3 ldef
/v2u* {exch dup norm 3 -1 roll sdiv*} def
/v2u {dup norm sdiv} def
/dist
	{	/B xdef /A xdef /i 0 def
		0 A {B i get sub dup mul add /i i 1 add def} forall sqrt
	} 3 ldef
/cp*
	{	/AxB xdef
		aload pop /b3 xdef /b2 xdef /b1 xdef
		aload pop /a3 xdef /a2 xdef /a1 xdef
			a2 b3 mul a3 b2 mul sub
			a3 b1 mul a1 b3 mul sub
			a1 b2 mul a2 b1 mul sub
			AxB astore
	} 7 ldef
/cp {3 array cp*} def
/tvec*
	{	/C xdef /B xdef /A xdef /t xdef /i 0 def
		A	{	dup B i get exch sub t mul add
				/i i 1 add def
			} forall
		C astore
	} 5 ldef
/tvec {dup length array tvec*} def
/nullmatrix
	{/n xdef /m xdef n {m array} repeat n array astore } 2 ldef
/mget {exch 3 1 roll get exch get} bdef
/mput {4 1 roll exch 4 1 roll get 3 1 roll put} bdef
/mstore
	{	/M xdef /i M length 1 sub def
		M length {M i get astore pop /i i 1 sub def} repeat
	} 2 ldef
/madd*
	{	/AB xdef /B xdef /A xdef
		0 1 A length 1 sub
			{/i xdef A i get B i get AB i get vadd* pop} for AB
	} 4 ldef
/madd
	{	/B xdef /A xdef A B A 0 get length B length nullmatrix madd*
	} 2 ldef
/msub*
	{	/AB xdef /B xdef /A xdef
		0 1 A length 1 sub
			{/i xdef A i get B i get AB i get vsub* pop} for AB
	} 4 ldef
/msub
	{	/B xdef /A xdef A B A 0 get length B length nullmatrix msub*
	} 2 ldef
/msmul*
	{	/Ms xdef dup type /arraytype eq {exch} if
		/s xdef /M xdef /i 0 def
		M {s Ms i get smul* pop /i i 1 add def} forall Ms
	} 5 ldef
/msmul
	{	dup type /arraytype eq not {exch} if /M xdef
		M M 0 get length M length nullmatrix msmul*
	} 1 ldef
/msdiv*
	{	/Ms xdef dup type /arraytype eq {exch} if
		/s xdef /M xdef /i 0 def
		M {s Ms i get sdiv* pop /i i 1 add def} forall Ms
	} 5 ldef
/msdiv
	{	dup type /arraytype eq not {exch} if /M xdef
		M M 0 get length M length nullmatrix msdiv*
	} 1 ldef
/mmul*
	{	/AB xdef /B xdef /A xdef
		/m A 0 get length def /n A length def /r B length def
		0 1 r 1 sub
		{	/j xdef
			0 1 m 1 sub
			{	/i xdef 0
				0 1 n 1 sub
					{ /k xdef A i k mget B k j mget mul add} for
			} for
		} for
		AB mstore AB
	} 9 ldef
/mmul
	{	/B xdef /A xdef A B A 0 get length B length nullmatrix mmul*
	} 2 ldef
/mvmul*
	{	/Mv xdef /v xdef /M xdef
		/m M 0 get length def /n M length def
		0 1 m 1 sub
		{ /i xdef 0
			0 1 n 1 sub
				{ /j xdef M i j mget v j get mul add
				} for
		} for
		Mv astore
	} 7 ldef
/mvmul {exch dup 0 get length array exch 3 1 roll mvmul*} def
/minv {PSMni} def
/minvmul {PSMni} def
/mtrace
	{	/M xdef /i 0 def
		0 M {i get add /i i 1 add def} forall
	} 2 ldef
/mtrans*
	{	/TM xdef /M xdef /m M 0 get length def /n M length def
		0 1 m 1 sub
			{ /i xdef
				0 1 n 1 sub {M i 3 -1 roll mget} for
			} for
		TM mstore TM
	} 5 ldef
/mtrans {/M xdef M M length M 0 get length nullmatrix mtrans*} 1 ldef
/m2v {/M xdef [M {aload pop} forall]} 1 ldef
/v2mc {1 array astore} def
/v2mr
	{	dup length /n xdef {1 array astore} forall n array astore
	} 1 ldef
/dot-size 1.5 def
/pnt2numx
	{	/n xdef n 1 sub index type exec
	} 5
	{	/integertype {} def /realtype {} def
		/arraytype
			{	n -1 roll dup
				0 get type /arraytype eq
				{	 0 get aload pop}
				{	 dup length 2 eq
					 { aload pop} { p 3D* aload pop} ifelse
				} ifelse
				n 1 add 2 roll
			 } def
		/p 2 array def
	} lidef
/pnt2num {1 pnt2numx} def
/pnt2vctx*
	{	/p xdef /n xdef n 1 sub index type exec
	} 5
	{	/integertype {n 1 add -2 roll p astore n 1 roll} def
		/realtype {integertype} def
		/arraytype
			{ 	n -1 roll dup
				0 get type /arraytype eq
				{	0 get }
				{	dup length 2 eq {} {p 3D*} ifelse
				} ifelse
				aload pop p astore n 1 roll
			 } def
	} lidef
/pnt2vctx {2 array pnt2vctx*} def
/pnt2vct* {1 exch pnt2vctx*} def
/pnt2vct {1 pnt2vctx} def
/-moveto /moveto load def
/-rmoveto /rmoveto load def
/-lineto /lineto load def
/-rlineto /rlineto load def
/-arc /arc load def
/-arcn /arcn load def
/-arcto /arcto load def
/-curveto /curveto load def
/-rcurveto /rcurveto load def
/Moveto {aload pop -moveto} def
/rMoveto {aload pop -rmoveto} def
/Lineto {aload pop -lineto} def
/rLineto {aload pop -rlineto} def
/moveto {pnt2num -moveto} def
/rmoveto {pnt2num -rmoveto} bdef
/lineto {pnt2num -lineto} bdef
/rlineto {pnt2num -rlineto} bdef
/line {pnt2num 3 pnt2numx 4 2 roll -moveto -lineto} def
/lines {dup 0 get moveto {lineto} forall} def
/xline
	{	/dB xdef /dA xdef B pnt2vct* pop A pnt2vct* pop
		B A BA vsub* BA v2u*
		dA neg A' smul* A A' vadd* Moveto
		BA dB B' smul* B B' vadd* Lineto
	} 9
	{	/A 2 array def /B 2 array def /BA 2 array def
		/A' 2 array def /B' 2 array def
	} lidef
/arc {4 pnt2numx -arc} def
/arcn {4 pnt2numx -arcn} def
/curve
	{	1 pnt2numx 3 pnt2numx 5 pnt2numx 7 pnt2numx
		8 -2 roll -moveto -curveto} def
/curveto {1 pnt2numx 3 pnt2numx 5 pnt2numx -curveto} def
/dotx {newpath pnt2num dot-size 0 360 -arc} def
/dot-bullet {gsave dotx fill grestore} def
/dot-circ {gsave dotx stroke grestore} def
/dot {dot-bullet} def
/perpsign
	{	/rsize xdef /B xdef /A xdef
		B A v vsub* v v2u* rsize v smul* pop
		v 90 h rotpnt* rsize sgn h smul* pop
		A Moveto h rlineto v rlineto h -1 smul rlineto
			closepath B lineto
	} 5 {/v 2 array def /h 2 array def} lidef
/turtle-init {PSMsysd /turtle-angle 3 -1 roll put Moveto pendown} def
/pendown {PSMsysd /turtle-state {rlineto} put} def
/penup {PSMsysd /turtle-state {rmoveto} put} def
/fwd
	{	dup PSMsysd /turtle-angle get dup 3 1 roll cos mul
		3 1 roll sin mul PSMsysd /turtle-state get exec
	} def
/bwd {neg fwd} def
/lht
	{	PSMsysd /turtle-angle get add PSMsysd /turtle-angle
		3 -1 roll put
	} def
/rht {neg lht} def
/box
	{	pnt2num /by xdef /bx xdef pnt2num /ay xdef /ax xdef
		ax ay -moveto ax by -lineto
		bx by -lineto bx ay -lineto closepath
	} 4 ldef
/circle {newpath 2 pnt2numx 0 360 -arc closepath} def
/ellipsearc
	{	newpath /a2 xdef /a1 xdef /yr xdef /xr xdef
		pnt2num /oy xdef /ox xdef
		/mtrx matrix currentmatrix def
		ox oy translate xr yr scale 0 0 1 a1 a2 -arc
		mtrx setmatrix
	} 7 ldef
/ellipse {0 360 ellipsearc closepath} def
/arrow {currentlinewidth 3.5 mm 40 0.7 arrowx} def
/varrow {currentlinewidth 2.5 mm 40 1 arrowx} def
/arcarrow {currentlinewidth 3.5 mm 45 0.7 arcarrowx} def
/varcarrow {currentlinewidth 2.5 mm 40 1 arcarrowx} def
/sarcarrow {currentlinewidth 2 mm 45 0.7 arcarrowx} def
/arrowx
	{	/rhead xdef 2 div /a xdef /hlen xdef 2 div /lw xdef
		head pnt2vct* pop tail pnt2vct* pop
		head tail vsub r2p aload pop /dir xdef
		/shaftl exch hlen rhead mul sub def
		/wingsz hlen a cos div def
		/lwing [wingsz dir 180 sub a sub] p2r head vadd def
		/rwing [wingsz dir 180 sub a add] p2r head vadd def
		/ltail [lw dir 90 add] p2r tail vadd def
		/rtail [lw dir 90 sub] p2r tail vadd def
		/lshaft	[shaftl dir] p2r ltail  vadd def
		/rshaft [shaftl dir] p2r rtail vadd def
		head  Moveto lwing  Lineto lshaft Lineto ltail Lineto
		rtail Lineto rshaft Lineto rwing  Lineto closepath
	} 16 {/head 2 array def /tail 2 array def} lidef
/arcarrowx
	{ 	/rhead xdef 2 div /a xdef /hlen xdef 2 div /lw xdef
		/ha xdef /ta xdef /r xdef O pnt2vct* pop
		ta ha gt /clockw xdef
		clockw {/hlen hlen neg def /lw lw neg def} if
		/head [r ha] p2r O vadd def
		/rheada 1 rhead add 0.5 mul def
		/ang 90 hlen rheada mul r div 28.6479 mul add def
		/wingsz hlen a cos div def
		/iwing [wingsz ha ang sub a sub] p2r head vadd def
		/owing [wingsz ha ang sub a add] p2r head vadd def
		/shafta ha hlen rhead mul r div 57.29578 mul sub def
		head Moveto iwing Lineto
		O aload pop r lw sub shafta ta clockw {-arc} {-arcn} ifelse
		O aload pop r lw add ta shafta clockw {-arcn} {-arc} ifelse
		owing Lineto closepath
	} 16 {/O 2 array def} lidef
/bboxray2p
	{	/phi xdef /P xdef
		aload pop /ury xdef /urx xdef /lly xdef /llx xdef
		/ray P [1 phi] p2r vadd P p2l def /P' P def
		phi cos	0.05 gt {/P' ray [1 0 urx] l2p def} if
		phi cos -0.05 lt {/P' ray [1 0 llx] l2p def} if
		phi sin	0.05 gt {/P' P' ray [0 1 ury] l2p P closestne def} if
		phi sin -0.05 lt {/P' P' ray [0 1 lly] l2p P closestne def} if
		P'
	} 9 ldef
/closestne
	{	/P xdef /P2 xdef /P1 xdef
		/d1 P1 P dist def /d2 P2 P dist def
		d1 0 eq
			{	P2 }
			{	d2 0 eq {P1}
					{d1 d2 lt {P1} {P2} ifelse} ifelse
			} ifelse
	} 5 ldef
/cdbbox
	{	/cd xdef
		/pnt cd 0 get def /lbl cd 1 get def
		/bbox [lbl TeXbbox] def
		/dy 3 def /dhx 5 def /dhy 3 def
		/x pnt 0 get bbox 0 get bbox 2 get add 2 div sub def
		/y pnt 1 get dy sub def
		/bbox bbox [x dhx sub y dhy sub x dhx add y dhy add] vadd def
		bbox [x y]
	} 9 ldef
/cdarrowpts
	{	/cd2 xdef /cd1 xdef
		/pnt1 cd1 0 get def /lbl1 cd1 1 get def
		/pnt2 cd2 0 get def /lbl2 cd2 1 get def
		/bbox1 cd1 cdbbox pop def
		/bbox2 cd2 cdbbox pop def
		/angle pnt2 pnt1 vsub r2p 1 get def
		/tail bbox1 pnt1 angle bboxray2p def
		/head bbox2 pnt2 angle 180 add bboxray2p def
		tail head
		PSMsysd begin
				/cdarrowhead xdef
				/cdarrowtail xdef
		end
		tail head
	} 11 ldef
/cdarrow-lw 0.3 def
/cdarrow {cdarrowpts cdarrow-std} def
/cdarrow-std
	{	/head xdef /tail xdef
		 			/u head tail vsub v2u 2.5 smul def
		/up u 90 rotpnt def
		gsave
			newpath cdarrow-lw setlinewidth
			tail head u cdarrow-lw smul 0.5 smul vsub line
				stroke nodash
			[head u vsub up vadd head  head u vsub up vsub]
				lines stroke
		grestore
		head moveto
} 4 ldef
/cdarrow-eq
	{	cdarrowpts /head xdef /tail xdef
		/orth head tail vsub 90 rotpnt v2u def
		tail orth vadd head orth vadd line stroke
		tail orth vsub head orth vsub line stroke
		head Moveto
		head Moveto
	} 2 ldef
/cdarrow-surj
	{	cdarrowpts /head xdef /tail xdef
		gsave
			newpath cdarrow-lw setlinewidth
			tail head cdarrow-std stroke
			tail
				tail head dist dup 1.5 sub exch div
				tail head tvec
			cdarrow-std stroke
		grestore
		head Moveto
	} 2 ldef
/cdarrow-incl
	{	cdarrowpts /head xdef /tail xdef
		/u head tail vsub v2u 2 smul def
		/up u 90 rotpnt def
		gsave
			newpath cdarrow-lw setlinewidth
			tail u vadd up vadd
			tail up vadd
			tail
			tail u vadd curve
			tail u vadd head cdarrow-std stroke
		grestore
		head Moveto
	} 4 ldef
/cdarrow-line
	{	cdarrowpts
		dup 3 1 roll
		gsave newpath line stroke grestore
		Moveto
	} def
/cdarrow-down {cdarrow-up} def
/cdarrow-up
	{	cdarrowpts /head xdef /tail xdef
		/u head tail vsub v2u def /v [u aload pop exch neg] def
		tail v 2 smul vadd head v 2 smul vadd cdarrow-std
	} 4 ldef
/cdentry {2 array astore dup cdlbl} def
/cdlbl
	{	/cd xdef /lbl cd 1 get def
		cd cdbbox Moveto pop lbl TeX
	} 3 ldef
/cdarrowlbl
	{	/ypos xdef /xpos xdef /lbl xdef
		lbl 0.5 cdarrowtail cdarrowhead tvec xpos ypos label
	} 3 ldef
/cdpnt
	{	dup type dup /integertype eq exch /realtype eq or not
			{0.5} if
		cdarrowtail cdarrowhead tvec
	} def
/cdlist % ListOfWords cdentry dx dy => ListOfCDentry
{   0 begin
        /dy xdef /dx xdef
        0 get [0 dy neg] vadd /P xdef
        /L xdef
        /n L length def
        /N n array def
        /width 0 L {stringwidth pop add} forall n 1 sub dx mul add def
        /x width 2 div neg def
        0 1 n 1 sub
        {   /i xdef
            /w L i get stringwidth pop def
            N i [P [w 2 div x add 0] vadd L i get] put
            /x x w add dx add def
        } for
        N
    end
    {   dup 1 get cvn exch dup cdlbl def
    } forall
} def
/cdlist load 0 12 dict put
/cdsuper % [cdpnt1 cdpnt2 ... cdpntn] => pnt
{   /list xdef
    % Find initial xmin, xmax, ymin
    /pnt list 0 get 0 get def
    /xmin pnt 0 get def
    /xmax pnt 0 get def
    /ymax pnt 1 get def

    % Find xmin, xmax, ymin
    list {
        0 get /pnt xdef
        /x pnt 0 get def
        /y pnt 1 get def
        x xmin lt {/xmin x def} if
        x xmax gt {/xmax x def} if
        y ymax gt {/ymax y def} if
    } forall

    % Return super point
    [xmin xmax add 2 div  ymax vspace add]
} 8 ldef

/3Dinit
	{	PSMsysd begin
		/3Ddist xdef /3Dcenter xdef /3Dfocal xdef
		/3Dnormal 3Dfocal 3Dcenter vsub v2u def
		/3Dorigo 3Ddist 3Dnormal smul 3Dcenter vadd def
		/3Dex 3Dnormal [0 0 1] cp def
		3Dex norm 1e-8 lt
			{/3Dex [1 0 0] def} {/3Dex 3Dex v2u def} ifelse
		/3Dey 3Dex 3Dnormal cp def
		/3Dmatrix [3Dex 3Dey 3Dnormal] mtrans def
		end
	} def
/3D*
	{ /p' xdef /p xdef
		PSMsysd begin
		p 3Dcenter p" vsub*
		dup 3Dnormal ip p" sdiv*
		3Dnormal p" vsub*
		3Ddist p" smul*
		3Dmatrix exch p" mvmul*
		aload pop pop p' astore
		end
	} 3 {/p" 3 array def} lidef
/3D {2 array 3D*} def
/P2L*
	{	/line xdef /p' xdef /p xdef
		p' p p" vsub* aload pop
		p aload pop
		line astore
	} 4 {/p" 3 array def} lidef
/P2L {6 array P2L*} def
/LP2P*
	{	/p xdef aload pop /d xdef n astore pop aload pop
			p0 astore pop r astore pop
		/s d n p0 ip sub n r ip div def
		r s r smul*
		p0 p vadd*
	} 6 {/n 3 array def /r 3 array def /p0 3 array def} lidef
/LP2P {3 array LP2P*} def
/PL2P*
	{	/pi xdef aload pop p0 astore pop r astore pop /p xdef
		r p p0 n vsub*  n cp* aload pop
		n p0 ip
		pi astore
	} 6 {/n 3 array def /r 3 array def /p0 3 array def} lidef
/PL2P {4 array PL2P*} def
/s2r*
	{	/p xdef aload pop /theta xdef /phi xdef /r xdef
			r theta sin mul phi cos mul
			r theta sin mul phi sin mul
			r theta cos mul
		p astore
	} 4 ldef
/s2r {3 array s2r*} def
/r2s*
	{	/p xdef aload pop /z xdef /y xdef /x xdef
			x sqr y sqr add z sqr add sqrt
			y x atan
			dup y exch sin z mul atan
		p astore
	} 4 ldef
/r2s {3 array r2s*} def
/3Dpoints2gcircle*
	{	/C xdef /ey xdef /ex xdef
		/ex' C 0 get def /ey' C 1 get def /ez' C 2 get def
		ex ey ez cp* ez v2u* pop
		ez ex ey' cp* pop
			ex aload pop ex' astore pop
			ez aload pop ez' astore pop
		C
	} 7 {/ez 3 array def} lidef
/3Dpoints2gcircle {3 3 nullmatrix 3Dpoints2gcircle*} def
/3Dgcircle-t2p*
	{	/p xdef /t xdef
		t cos t sin 0 p' astore p mvmul*
	} 3 {/p' 3 array def} lidef
/3Dgcircle-t2p {3 array 3Dgcircle-t2p*} def
/3Dgcircle-p2t
	{	exch M mtrans* exch v mvmul*
		aload pop pop exch atan
	} 2 {/M 3 3 nullmatrix def /v 3 array def} lidef
/3Dgcircle-draw
	{	/tmax xdef /tmin xdef /M xdef
		M tmin v 3Dgcircle-t2p* moveto
		tmin tmax { M exch v 3Dgcircle-t2p*} plot
	} 5 {/v 3 array def} lidef
PSMtexd begin
/TeX-mm false def
/TeX-script 0.65 def
/TeX-lower 0.2 def
/TeX-raise 0.25 def
/TeXshow {show} def
/TeX-tok
{	/s xdef
	s length 0 eq
	{	() () }
	{	/s0 s 0 get def
		47 s0 eq 123 s0 eq or
		{	s0 47 eq
			{	/n 1 def
				s {	/sn xdef
					sn 64 gt sn	91 lt and
					sn 96 gt sn 123 lt and or
					{/n n 1 add def} {n 1 ne {exit} if} ifelse
				} forall
				s n s length n sub getinterval /S xdef
				S length 0 eq not
				{	S 0 get 32 eq
					{/S S 1 S length 1 sub getinterval def} if
				} if S
				s 0 n getinterval
			} if
			s0 123 eq
			{	/n 0 def /bl 0 def
				s {	dup
					123 eq {/bl bl 1 add def} if
					125 eq {/bl bl 1 sub def} if
					/n n 1 add def
					bl 0 eq {exit} if
				} forall
				s n s length n sub getinterval
				s 1 n 2 sub getinterval
			} if
		}
		{	s 1 s length 1 sub getinterval s 0 1 getinterval
		} ifelse
	} ifelse
} 5 ldef
/PSMtexld 3 dict def PSMtexld begin /TeXnest 0 def end
/TeX
{	/TeXnest where {pop} {PSMtexld begin} ifelse
	/TeXnest TeXnest 1 add def
	TeX-tok /tok xdef /tail xdef
	tok length dup 0 eq exch 1 gt or
	{	tok length 0 eq
		{	tail length 0 eq not {{tail TeX}} {{}} ifelse}
		{	tok 0 get 47 eq
			{{tail tok 1 tok length 1 sub getinterval cvn cvx
				PSMtexd exch get exec TeX}}
			{{tail tok TeX TeX}}
				ifelse
		} ifelse
	}
	{	
		% Both text and math mode
		($) tok eq {{tail PSMtexd begin /TeX-mm TeX-mm not def
			getfontstyle 2 xor setfontstyle setupfont end TeX}} if
		(_) tok eq {{tail subscript TeX}} if
		(^) tok eq {{tail supscript TeX}} if

		% Math mode only
		TeX-mm {
			( ) tok eq {{tail TeX}} if
			(=) tok eq {{tail spc tok romanshow spc TeX}} if
			(+) tok eq {{tail spc tok romanshow spc TeX}} if
			(-) tok eq {{tail spc (\261) romanshow spc TeX}} if
			(()0123456789[]:) tok search {pop pop pop {tok romanshow
				tail TeX}} {pop} ifelse
			(_^$ =+-()0123456789[]:) tok search {pop pop pop}
				{pop {tail tok TeXshow TeX}} ifelse
		} {
			(_$^) tok search {pop pop pop} 
				{pop {tail tok TeXshow TeX}} ifelse
		} ifelse
	} ifelse
	bind exec
	/TeXnest TeXnest 1 sub def
	TeXnest 0 eq {end} if
} def
/romanshow
	{	getfontstyle 0 setfontstyle setupfont exch TeXshow
		setfontstyle setupfont
	} def
/subsup {gsave 0 -1 rmoveto subscript grestore supscript} def
/lit {TeX-tok show} def
/subscript
	{	0 getfontsize PSMtexd /TeX-lower get mul neg rmoveto script
		0 getfontsize PSMtexd /TeX-lower get mul rmoveto
	} def
/supscript
	{	0 getfontsize PSMtexd /TeX-raise get mul rmoveto script
		0 getfontsize PSMtexd /TeX-raise get mul neg rmoveto
	} def
/script
	{	getfontsize PSMtexd /TeX-script get mul setfontsize setupfont
		TeX-tok TeX getfontsize TeX-script div setfontsize setupfont
	} def
/overline
	{	TeX-tok dup TeXbbox
		/ury xdef /urx xdef pop /llx xdef
		gsave llx ury 1 add rmoveto urx llx sub 0 rlineto
		0.5 setlinewidth stroke grestore TeX
	} 3 ldef
/spc {getfontsize 0.2 mul 0 rmoveto} bdef
/nspc {getfontsize -0.2 mul 0 rmoveto} bdef
/phantom {TeX-tok gsave TeX grestore} def
/roman
	{	TeX-tok {TeX 1 setfontstyle setupfont} dup 1
			PSMtexd /fontstyle get put
		0 setfontstyle setupfont exec
	} def
/bold
	{	TeX-tok {TeX 1 setfontstyle setupfont} dup 1
			PSMtexd /fontstyle get put
		getfontstyle 1 or setfontstyle setupfont exec
	} def
/italic
	{	TeX-tok {TeX 1 setfontstyle setupfont} dup 1
			PSMtexd /fontstyle get put
		getfontstyle 2 or setfontstyle setupfont exec
	} def
/symbol
	{	TeX-tok {TeX 1 setfontfamily getfontsize 0.825 div
			setfontsize setupfont} dup 1 PSMtexd /fontfamily get put
		Symbol setfontfamily getfontsize 0.825 mul setfontsize
			setupfont exec
	} def
/symbol-show
	{	TeX-tok {show 1 setfontfamily getfontsize 0.825 div
			setfontsize setupfont} dup 1 PSMtexd /fontfamily get put
		Symbol setfontfamily getfontsize 0.825 mul setfontsize
			setupfont exec
	} def
/xlabel
	{	/vpos xdef /hpos xdef /dy xdef /dx xdef pnt2vct /pnt xdef /lbl xdef
		lbl () ne
		{	lbl TeXbbox /ury xdef /urx xdef /lly xdef /llx xdef
			pnt Moveto dx dy rmoveto
			hpos 0 eq not {llx neg 0 rmoveto hpos 1 sub urx llx sub
				2 div mul neg 0 rmoveto} if
			vpos 0 eq not {0 lly neg rmoveto 0 vpos 1 sub ury lly sub
				2 div mul neg rmoveto} if
			fill? { gsave currentpoint newpath moveto
				llx filldist sub lly filldist sub rmoveto
				urx llx sub filldist 2 mul add 0 rlineto
				0 ury lly sub filldist 2 mul add rlineto
				llx urx sub filldist 2 mul sub 0 rlineto
				closepath fillcol setgray fill grestore	 } if
			lbl TeX
		} if
	} 13 {/fill? false def /fillcol 1 def /filldist 3 def} lidef
/label
	{	/vpos xdef /hpos xdef
		/dx [1 1 0 -1] hpos get def
		/dy [1 1 0 -1] vpos get def
		/dabs dx abs dy abs add sqrt def
		dabs 0 eq not {/dabs 4 dabs div def} if
		dx dabs mul dy dabs mul hpos vpos xlabel
	} 5 ldef
/TeXsetfill
	{	/xlabel load 0 get begin
		/filldist xdef
		dup 0 lt {pop /fill? false def}
			{/fillcol xdef /fill? true def} ifelse
		end
	} def
/TeXbbox
	{ TeXbbdict begin
		/llx 1e30 def /lly 1e30 def /urx -1e30 def /ury -1e30 def
		gsave newpath 0 0 moveto TeX grestore
		llx lly itransform urx ury itransform
		/ury xdef /urx xdef /lly xdef /llx xdef
		llx urx gt {llx urx /llx xdef /urx xdef} if
		lly ury gt {lly ury /lly xdef /ury xdef} if
		llx lly urx ury end
	} def
/TeXbbdict 14 dict def
TeXbbdict begin
	/show {false charpath currentpoint maxbbox moveto} def
	/stroke {maxbbox} def
	/fill {maxbbox} def
	/maxbbox
		{	gsave TeXbbdict begin
				flattenpath pathbbox
				transform /ury' xdef /urx' xdef
				transform /lly' xdef /llx' xdef
				/llx llx' urx' min llx min def
				/lly lly' ury' min lly min def
				/urx urx' llx' max urx max def
				/ury ury' lly' max ury max def
			end grestore newpath
		} def
end
/alpha	{(a) symbol pop} def	/Alpha	{(A) symbol pop} def
/beta	{(b) symbol pop} def	/Beta	{(B) symbol pop} def
/chi	{(c) symbol pop} def	/Chi	{(C) symbol pop} def
/delta	{(d) symbol pop} def	/Delta	{(D) symbol pop} def
/epsilon{(e) symbol pop} def	/Epsilon{(E) symbol pop} def
/phi	{(f) symbol pop} def	/Phi	{(F) symbol pop} def
/gamma	{(g) symbol pop} def	/Gamma	{(G) symbol pop} def
/eta	{(h) symbol pop} def	/Eta	{(H) symbol pop} def
/iota	{(i) symbol pop} def	/Iota	{(I) symbol pop} def
/phi1	{(j) symbol pop} def	/theta1	{(J) symbol pop} def
/kappa	{(k) symbol pop} def	/Kappa	{(K) symbol pop} def
/lambda	{(l) symbol pop} def	/Lambda	{(L) symbol pop} def
/mu		{(m) symbol pop} def	/Mu		{(M) symbol pop} def
/nu		{(n) symbol pop} def	/Nu		{(N) symbol pop} def
/omicron{(o) symbol pop} def	/Omicron{(O) symbol pop} def
/pi		{(p) symbol pop} def	/Pi		{(P) symbol pop} def
/theta	{(q) symbol pop} def	/Theta	{(Q) symbol pop} def
/rho	{(r) symbol pop} def	/Rho	{(R) symbol pop} def
/sigma	{(s) symbol pop} def	/Sigma	{(S) symbol pop} def
/tau	{(t) symbol pop} def	/Tau	{(T) symbol pop} def
/upsilon{(u) symbol pop} def	/Upsilon{(U) symbol pop} def
/omega1	{(v) symbol pop} def	/sigma1	{(V) symbol pop} def
/omega	{(w) symbol pop} def	/Omega	{(W) symbol pop} def
/xi		{(x) symbol pop} def	/Xi		{(X) symbol pop} def
/psi	{(y) symbol pop} def	/Psi	{(Y) symbol pop} def
/zeta	{(z) symbol pop} def	/Zeta	{(Z) symbol pop} def
/do {TeX-tok cvx exec} def
/prime	{(\242) symbol pop} def
/dprime {(\262) symbol pop} def
/tensor {(\304) symbol pop} def
/oplus	{(\305) symbol pop} def
/isom	{(\100) symbol pop} def
/in		{(\316) symbol pop} def
/times	{(\264) symbol pop} def
/union	{(\310) symbol pop} def
/intsct {(\307) symbol pop} def
/into	{(\256) symbol pop} def
/slash	{(/) show} def
/ul		{(_) show} def
/lbr {({) show} def
/rbr {(}) show} def
/exists	{(\044) symbol-show pop} def
/all	{(\042) symbol pop} def
/lnot   {(\330) symbol pop} def
/land   {(\331) symbol pop} def
/lor    {(\332) symbol pop} def
/iff    {(\333) symbol pop} def
/implies {(\336) symbol pop} def
/perp {(\136) symbol pop} def
/prod
	{	gsave currentpoint translate
		[0.2 -0.57] getfontsize smul Moveto (P) symbol pop grestore
		0.9 getfontsize mul 0 rmoveto
	} def
/Prod
	{	getfontsize dup 1.5 mul setfontsize setupfont prod
		setfontsize setupfont
	} def
/dlim
{	getfontstyle 0 setfontstyle setupfont
	/P1 [currentpoint] def (lim) show
	/P2 [currentpoint] def /un {getfontsize mul} def
	gsave newpath P1 [0 -0.2 un] vadd P2 [-0.2 un -0.2 un] vadd
	0.05 un setlinewidth 0 0.12 un 90 0 xArrow stroke grestore
	setfontstyle setupfont
} 3 ldef
/ilim
{	 getfontstyle 0 setfontstyle setupfont
	/P1 [currentpoint] def (lim) show
	/P2 [currentpoint] def /un {getfontsize mul} def
	gsave newpath P1 [0 -0.2 un] vadd P2 [-0.2 un -0.2 un] vadd exch
	0.05 un setlinewidth 0 0.12 un 90 0 xArrow stroke grestore
		 		setfontstyle setupfont
 			} 3 ldef
/coprod
{	gsave currentpoint translate 1 -1 scale
	[0.2 -0.57] getfontsize smul Moveto (P) symbol pop grestore
	0.9 getfontsize mul 0 rmoveto
} def
/Coprod
{	getfontsize dup 1.5 mul setfontsize setupfont coprod
	setfontsize setupfont
} def
/ell
{	gsave currentpoint translate newpath
	getfontsize 1000 div dup scale 35 112	moveto
	101 173	245 319  299 474 curveto 363 652  271 735  160 295 curveto
	130 178	 95 -87  263  59 curveto 342 127  357 100  301  49 curveto
	134 -81	 35  57  112 346 curveto 215 726  429 718  317 440 curveto
	251 277	124 165	58 101 curveto 11  58	-3  78	35 112 curveto
	closepath fill grestore 0.5 getfontsize mul 0 rmoveto
} def
end
/CSmaxplots 20000 def
/CSminplots 20 def
/CSmaxdev 5 def
/CSplot0 {moveto} def
/CSplot  {lineto} def
%/CSpnt0 2 array def
%/CSplot0 {2 copy moveto CSpnt0 astore pop gsave CSpnt0 dot grestore} def
%/CSplot  {2 copy lineto CSpnt0 astore pop gsave CSpnt0 dot grestore} def
/CS-xmarks 20 def
/CS-ymarks 15 def
/CS-xbase 1 def
/CS-ybase 1 def
/CS-axismarklen 4 def
/CSxlabel {CS-xun div cvi CS-xmul mul s cvs exch 2 3 label} def
/CSylabel {CS-yun div cvi CS-ymul mul s cvs exch 1 2 label} def
/CS-xunitname () def
/CS-yunitname () def
/CS-labelfontsize 6 def
/CS-dimsfontsize 8 def
/CS-axismarklen 4 def
/CSunits
	{	/base xdef /idealn xdef /tmax xdef /tmin xdef
		% Make the first, rough guess -- probably too small
		/unit tmax tmin sub abs base div log 3 div floor 1 sub
			1000 exch exp base mul def
		% Now multiply unit by 2,5,10,... until too big, and pick best
		/best 1 rating def
		0 1 idealn dup add log floor 3 add
			{	10 exch exp /e xdef
				/best best
					[ 2 e mul dup rating exch] max
					[ 5 e mul dup rating exch] max
					[10 e mul dup rating exch] max
				def
				best 1 get 10 e mul ne {exit} if
			} for
		% OK, now find the best unit, and new tmin and tmax
		/unit best 1 get unit mul tmax tmin sub sgn mul def
		/tmin tmin unit div floor unit mul def
		/tmax tmax unit div ceiling 1 add unit mul def
		/origo tmax tmin mul 0 gt {tmin} {0} ifelse def
		/mult best 1 get dup 500 gt {1000 div} if cvi def
		tmin tmax unit origo mult
	} 12
	{	% How good is the choice of unit? This routine measures it!
		/rating % k => n(2*idealn-n) where n=dt/(unit*k)
			{	tmax tmin sub abs exch div unit div dup
				idealn dup add exch sub mul
			} def
	} lidef
/CSframe % [xmin ymin] [xmax ymax] => -
	{	PSMsysd begin
		aload pop /CS-fymax xdef /CS-fxmax xdef
		aload pop /CS-fymin xdef /CS-fxmin xdef
		end
	} def
[0 mm 0 mm] [80 mm 50 mm] CSframe
/CSinit % xmin xmax ymin ymax => -
	{	CS-ymarks CS-ybase CSunits
		PSMsysd begin
			/CS-ymul xdef /CS-yorigo xdef /CS-yun xdef /CS-ymax xdef /CS-ymin xdef
		end
		CS-xmarks CS-xbase CSunits
		PSMsysd begin
			/CS-xmul xdef /CS-xorigo xdef /CS-xun xdef /CS-xmax xdef /CS-xmin xdef
			/CS-sx CS-fxmax CS-fxmin sub CS-xmax CS-xmin sub div def
			/CS-sy CS-fymax CS-fymin sub CS-ymax CS-ymin sub div def
			/CS-tx CS-fxmin CS-sx CS-xmin mul sub def
			/CS-ty CS-fymin CS-sy CS-ymin mul sub def
			/CS-xaxis [CS-xmax CS-yorigo cs] def
			/CS-yaxis [CS-xorigo CS-ymax cs] def
		end
	} def
/cs {pnt2num CS-sy mul CS-ty add exch CS-sx mul CS-tx add exch} def
/CSaxes
	{	gsave [CS-xorigo CS-ymin cs] [CS-xorigo CS-ymax cs] arrow fill
		[CS-xmin CS-yorigo cs] [CS-xmax CS-yorigo cs] arrow fill
		grestore
	} def
/CSaxismarks
	{	CS-xmin CS-xun dup CS-xmax exch sub
		{	gsave 0 cs moveto CS-axismarklen dup -2 div 0 exch rmoveto
			0 exch rlineto stroke grestore } for
		CS-ymin CS-yun dup CS-ymax exch sub
		{	gsave 0 exch cs moveto CS-axismarklen dup -2 div 0 rmoveto
			0 rlineto stroke grestore } for
	} def
/sconcat % s1 s2 => s
	{	/s2 xdef /s1 xdef
		s1 length s2 length add string dup
		0 s1 putinterval dup s1 length s2 putinterval
	} 2 ldef
/CSaxislabels % - => -
{   /fs getfontsize def
	CS-labelfontsize setfontsize setupfont
	/dx (-9999) stringwidth pop CS-sx CS-xun mul div 1.5 mul def
	/dy CS-labelfontsize CS-sy CS-yun mul div 1.5 mul def
	/dx [1 2 5 10 20] {dup dx lt {pop} {exit} ifelse} forall CS-xun mul def
	/dy [1 2 5 10 20] {dup dy lt {pop} {exit} ifelse} forall CS-yun mul def
	CS-xorigo dx add dx CS-xmax dx 0.6 mul sub
		{/x xdef [x 0 cs] x CSxlabel} for
	CS-xorigo dx sub dx neg CS-xmin dx 0.1 mul sub
		{/x xdef [x 0 cs] x CSxlabel} for
	CS-yorigo dy add dy CS-ymax dy 0.6 mul sub
		{/y xdef [0 y cs] y CSylabel} for
	CS-yorigo dy sub dy neg CS-ymin dy 0.1 mul sub
		{/y xdef [0 y cs] y CSylabel} for
	/xexp CS-xun CS-xbase div CS-xmul div log round cvi def
	/yexp CS-yun CS-ybase div CS-ymul div log round cvi def
	CS-dimsfontsize setfontsize setupfont
	xexp 0 eq
		{()} {($\26410^{) xexp s cvs sconcat (}$ ) sconcat} ifelse
	CS-xunitname sconcat CS-xaxis -8 -6 1 3 xlabel
	yexp 0 eq
		{()} {($\26410^{) yexp s cvs sconcat (}$ ) sconcat} ifelse
	CS-yunitname sconcat CS-yaxis 6 -2 1 3 xlabel
	fs setfontsize setupfont
} 7 {/s 20 string def} lidef

/plot
	{	/fct xdef /tmax xdef /tmin xdef
		/dtmin tmax tmin sub CSmaxplots div def
		/dtmax tmax tmin sub CSminplots div def
		/t tmin def /dt dtmax def
		% Initialize
		t fct pnt2num /y xdef /x xdef x y CSplot0
		/dev x y t dtmin 10 div add fct pnt2num angle def
		% Start plotting
		{	% Predicted point
			/tp t dt add dup tmax sub dt mul 0 lt not {pop tmax} if def
			tp fct pnt2num /yp xdef /xp xdef
			/devp x y xp yp angle def
			% Test for correct change in dev
			devp dev sub abs CSmaxdev lt dt abs dtmin abs lt or
				{	/x xp def /y yp def /t tp def /dev devp def /dt dt 1.2 mul def
					x y CSplot tp tmax eq {exit} if }
				{	/dt dt 2 div def }
			ifelse
		} loop
	} 15 ldef
/plimits
{	/pfct xdef /tmax xdef /tmin xdef
	/xmin 1e36 def /xmax -1e36 def
	/ymin 1e36 def /ymax -1e36 def
	tmin tmax tmin sub cs-plots div tmax
	{	/t xdef t pfct aload pop /y xdef /x xdef
		x xmin lt {/xmin x def} {x xmax gt {/xmax x def} if } ifelse
		y ymin lt {/ymin y def} {y ymax gt {/ymax y def} if } ifelse
	} for
	xmin xmax ymin ymax
} 7 ldef
%
/knot-bgcolour { 1 setgray } def
/knot-bgline {currentlinewidth 5 mul setlinewidth} def
/knot-line {1 setlinewidth} def
/chequer-line 0 def
/chequer-bg 1 def
/chequer-fill 0 def
/braid-dx 20 def
/braid-v 0 def
/braid-angle 0 def
/braid-dot {pop} def
/spline{
  /spline xdef
   spline 0 get dup 0 get exch 1 get moveto
   spline {aload pop 8 -2 roll pop pop curveto} forall
} 1 ldef
/splinestroke {spline stroke} def
/msplinestroke{
  /spline xdef 
  /n spline length def
  0 2 n 1 sub {
    /i xdef 
    spline i get aload pop 8 -2 roll moveto curveto
    spline i 1 add n mod get aload pop 8 -2 roll pop pop
    curveto
  } for
  stroke
} 3 ldef
/splinesplit
	{	aload pop
		/y3 xdef /x3 xdef /y2 xdef /x2 xdef
		/y1 xdef /x1 xdef /y0 xdef /x0 xdef
		[	x0
			y0
			x1 x0 add 2 div
			y1 y0 add 2 div
			x2 x1 add x1 add x0 add 4 div
			y2 y1 add y1 add y0 add 4 div
			x2 x1 add 3 mul x3 add x0 add 8 div
			y2 y1 add 3 mul y3 add y0 add 8 div
		]
		[ x2 x1 add 3 mul x3 add x0 add 8 div
			y2 y1 add 3 mul y3 add y0 add 8 div
			x3 x2 x2 add add x1 add 4 div
			y3 y2 y2 add add y1 add 4 div
			x3 x2 add 2 div
			y3 y2 add 2 div
			x3
			y3
		]
	} 8 ldef
/crossings2spline
	{	aload pop pop /v2 xdef /a2 xdef aload pop /y2 xdef /x2 xdef
		aload pop pop /v1 xdef /a1 xdef aload pop /y1 xdef /x1 xdef
		[	x1
			y1
			x1 a1 cos v1 mul add
			y1 a1 sin v1 mul add
			x2 a2 cos v1 mul sub
			y2 a2 sin v1 mul sub
			x2
			y2
		]
	} 8 ldef
/countsplines
	{	/C xdef /upper 0 def /lower 0 def
		C { 3 get 0 lt
			{/lower lower 2 add def} {/upper upper 2 add def} ifelse
		} forall
		C 0 get 3 get 0 lt
		{/lower lower 1 sub def} {/upper upper 1 sub def} ifelse
		C dup length 1 sub get 3 get 0 lt
		{/lower lower 1 sub def} {/upper upper 1 sub def} ifelse
		lower upper
	} 3 ldef
/crossings2layer
	{	/C xdef
		C countsplines array /upperlayer xdef array /lowerlayer xdef
		/upper 0 def /lower 0 def
		/first true def
		[ C
		{	first
			{	/prev xdef /first false def	 }
			{	/curr xdef
				prev curr crossings2spline /spline xdef
				spline splinesplit /currspline xdef /prevspline xdef
				prev 3 get 0 lt
				{	lowerlayer lower prevspline put
					/lower lower 1 add def }
				{	upperlayer upper prevspline put
					/upper upper 1 add def }
				ifelse
				curr 3 get 0 lt
				{	lowerlayer lower currspline put
					/lower lower 1 add def }
				{	upperlayer upper currspline put
					/upper upper 1 add def }
				ifelse
				/prev curr def spline
			} ifelse
		} forall
		] /layer xdef
		C 0 get 3 get 0 lt
		{ lowerlayer aload length 1 roll lowerlayer astore pop }
		{ upperlayer aload length 1 roll upperlayer astore pop }
		ifelse
		layer lowerlayer upperlayer
	} 12 ldef
%
/drawcrossings{
  crossings2layer
  /upperlayer xdef 
  /lowerlayer xdef 
  /layer xdef
  layer splinestroke
  gsave knot-bgcolour knot-bgline upperlayer msplinestroke grestore
  upperlayer msplinestroke
} 3 ldef
/knot{
  /crossings xdef 
  [ crossings aload 0 get ] drawcrossings
} 1 ldef
/chequerboard
	{	/crossings xdef [ crossings aload 0 get ] crossings2layer
		/upperlayer xdef /lowerlayer xdef spline closepath
		gsave chequer-fill 0 lt not
			{chequer-fill setgray eofill} if grestore
		gsave chequer-bg setgray knot-bgline stroke grestore
		chequer-line setgray stroke
		gsave chequer-bg setgray knot-bgline upperlayer msplinestroke
		grestore chequer-line setgray upperlayer msplinestroke
	} 3 ldef
/string-s2angle
	{ /s2 xdef /s1 xdef
		s1 -2 eq {/s1 -1 def} if
		s1	2 eq {/s1  1 def} if
		s2 -2 eq {/s2 -1 def} if
		s2	2 eq {/s2  1 def} if
		s1 s2 eq
		{45 s1 mul neg}
		{ s1 s2 neg eq {0} {s1 s2 add braid-angle mul neg} ifelse }
		ifelse
	} 2 ldef
/stroke-string
{	/s xdef /i xdef
	/n s length def /j 0 def
	/angle1 0 def
	/s [s aload pop 0] def
	/x1 i braid-dx mul def
	/y1 j braid-dx mul def
	x1 y1 moveto
	[ 0 1 n 1 sub
		{	/j xdef
			/s1 s j get def
			/s2 s j 1 add get def
			/angle2 s1 s2 string-s2angle def
			s1 0 gt {/i i 1 add def} if
			s1 0 lt {/i i 1 sub def} if
			/x4 i braid-dx mul def
			/y4 j 1 add braid-dx mul def
			[x1 y1] [braid-v braid-dx mul angle1 90 add] p2r vadd
			aload pop /y2 xdef /x2 xdef
			[x4 y4] [braid-v braid-dx mul angle2 270 add] p2r vadd
			aload pop /y3 xdef /x3 xdef
			x2 y2 x3 y3 x4 y4 curveto
			s1 abs 2 eq {[x2 y2 x3 y3 x4 y4 x1 y1]} if
			/x1 x4 def
			/y1 y4 def
			/angle1 angle2 def
		} for
	]
	knot-line stroke
} 16 ldef
/braid2string
{	/braid xdef /i xdef
	[ braid
		{	/j xdef /s 0 def /ii i def
			i j abs eq
				{/ii i 1 add def /s j 0 gt { 2} { 1} ifelse def} if
			i j abs 1 add eq j abs 0 gt and
				{/ii i 1 sub def /s j 0 gt {-1} {-2} ifelse def} if
			/i ii def s
		} forall
	]
} 5 ldef
/braid
{	/braid xdef /n xdef
	[ 1 1 n
		{	 dup braid braid2string stroke-string
		} for
	] { {	aload pop moveto curveto
			gsave knot-bgline 1 setgray stroke grestore stroke
		} forall
	} forall
	/y1 0 def /y2 braid length braid-dx mul def
	1 1 n
	{	braid-dx mul /x xdef [x y1] braid-dot [x y2] braid-dot
	} for
} 5 ldef
/knot-0-1 {[currentpoint] 12.5 mm circle stroke} def
/hopf-link
{	/cpoint [currentpoint] def /angle 60 def /radius 10 mm def
	/A cpoint [angle cos radius mul neg 0] vadd def
	/B cpoint [angle cos radius mul	 0] vadd def
	/dtheta gsave knot-bgline currentlinewidth grestore	radius
		div 57.2958 mul def
	/theta1 angle dtheta add def /theta2 angle dtheta sub def
	A Moveto [radius theta1] p2r rMoveto
	A radius theta1 theta2 Arc
	B Moveto [radius theta1 180 sub] p2r rMoveto
	B radius theta1 180 sub theta2 180 sub Arc
} 8 ldef
/knot-3-1
{ /A [10 mm -90] p2r [currentpoint] vadd def
	/B [10 mm	30] p2r [currentpoint] vadd def
	/C [10 mm 150] p2r [currentpoint] vadd def
	/v 5 mm def /w 15 mm def
	[	[A	45 v -1] [B  75 w  1] [C 285 v -1]
		[A -45 w	1] [B 165 v -1] [C 195 w  1] ]
} 5 ldef
/knot-4-1
{ /A [currentpoint] def
	/B A [12 mm	90] p2r vadd def
	/C A [12 mm 240] p2r vadd def
	/D A [12 mm 300] p2r vadd def
	/u 4 mm def /v 8 mm def /w 12 mm def
	[ [A	45 u -1] [B 135 w  1] [C -30 u -1]
		[D	40 w  1] [B 225 u -1] [A -45 u  1]
		[D -90 v -1] [C	90 u  1] ]
} 7 ldef
/knot-5-1
{ /O [currentpoint] def
	/A O [10 mm -90] p2r vadd def
	/B O [10 mm -18] p2r vadd def
	/C O [10 mm	54] p2r vadd def
	/D O [10 mm 126] p2r vadd def
	/E O [10 mm 198] p2r vadd def
	/v 5 mm def /w 10 mm def
	[ [A	36 v  1] [B  36 w -1] [C 180 v  1]
		[D 180 w -1] [E 324 v	1] [A 324 w -1]
		[B 468 v	1] [C 468 w -1] [D 612 v  1]
		[E 612 w -1] ]
} 8 ldef
/knot-5-2
{ /A [currentpoint] def
	/B A [13 mm	90] p2r vadd def
	/C A [9 mm 225] p2r vadd def
	/D A [13 mm -90] p2r vadd def
	/E A [9 mm -45] p2r vadd def
	/u 4 mm def /v 9 mm def /w 13 mm def
	[ [A	45 v -1] [B 135 w  1] [C -45 u -1]
		[D -45 v	1] [E 135 u -1] [A 135 v  1]
		[B	45 w -1] [E 225 u  1] [D 225 v -1]
		[C	45 u  1] ]
} 8 ldef
/knot-6-1
{ /A [currentpoint] def
	/B A [13 mm	90] p2r vadd def
	/C A [13 mm 210] p2r vadd def
	/D C [10 mm -45] p2r vadd def
	/F A [13 mm -30] p2r vadd def
	/E F [10 mm 225] p2r vadd def
	/u 4 mm def /v 10 mm def /w 13 mm def
	[ [A	45 u -1] [B 135 w  1] [C -45 u -1]
		[D -45 u	1] [E  45 u -1] [F  45 w  1]
		[B 225 u -1] [A -45 u	1] [F -45 v -1]
		[E 135 u	1] [D 225 v -1] [C  45 u  1] ]
} 9 ldef
/knot-6-2
{ /A [currentpoint] def
	/B A [10 mm	45] p2r vadd def
	/C A [10 mm 135] p2r vadd def
	/D A [10 mm -45] p2r vadd def
	/E D [10 mm 225] p2r vadd def
	/F A [10 mm 225] p2r vadd def
	/u 3 mm def /v 7 mm def /w 10 mm def
	[ [A	45 u  1] [B  90 v -1] [C -90 u  1]
		[A -45 u -1] [D -45 v	1] [E 135 u -1]
		[F 135 w	1] [C   0 u -1] [B   0 w  1]
		[D 225 u -1] [E 225 v	1] [F  45 u -1] ]
} 9 ldef
/knot-6-3
{ /A [currentpoint] def
	/B A [10 mm 150] p2r vadd def
	/C A [10 mm	30] p2r vadd def
	/D A [ 7 mm -90] p2r vadd def
	/E D [10 mm 225] p2r vadd def
	/F D [10 mm -45] p2r vadd def
	/u 4 mm def /v 7 mm def /w 10 mm def
	[ [A 180 u	1] [B  90 v -1] [C -90 u  1]
		[D 225 u -1] [E -90 v	1] [F  90 u -1]
		[D 135 u	1] [A  90 u -1] [B 200 v  1]
		[E	 0 u -1] [F   0 v  1] [C 180 u -1] ]
} 9 ldef
/knot-7-1
{ /O [currentpoint] def /da 360 7 div def
	/A O [11 mm da 0 mul 90 sub] p2r vadd def
	/B O [11 mm da 1 mul 90 sub] p2r vadd def
	/C O [11 mm da 2 mul 90 sub] p2r vadd def
	/D O [11 mm da 3 mul 90 sub] p2r vadd def
	/E O [11 mm da 4 mul 90 sub] p2r vadd def
	/F O [11 mm da 5 mul 90 sub] p2r vadd def
	/G O [11 mm da 6 mul 90 sub] p2r vadd def
	/u 4 mm def /v 8 mm def
	[ [A	25.7 u  1] [B  25.7 v -1] [C 128.6 u  1]
		[D 128.6 v -1] [E 231.4 u	1] [F 231.4 v -1]
		[G 334.3 u	1] [A 334.3 v -1] [B 437.1 u  1]
		[C 437.1 v -1] [D 540.0 u	1] [E 540.0 v -1]
		[F 643.9 u	1] [G 643.9 v -1] ]
} 11 ldef
/knot-7-2
{ /A [currentpoint] def
	/B A [8 mm	90] p2r vadd def
	/O A [8 mm -90] p2r vadd def
	/C O [8 mm	30] p2r vadd def
	/D O [8 mm -30] p2r vadd def
	/E O [8 mm -90] p2r vadd def
	/F O [8 mm 210] p2r vadd def
	/G O [8 mm 150] p2r vadd def
	/u 3 mm def /v 8 mm def /w 12 mm def
	[ [A 150 u	1] [B  30 w -1] [C 250 u  1]
		[D -70 v -1] [E 130 u	1] [F 170 v -1]
		[G	10 u  1] [A  50 u -1] [B 150 w  1]
		[G -70 u -1] [F 250 v	1] [E  50 u -1]
		[D	10 v  1] [C 170 u -1] ]
} 11 ldef
/knot-7-3
{ /A [currentpoint] def
	/B A [ 7 mm	90] p2r vadd def
	/C B [ 7 mm	90] p2r vadd def
	/D A [10 mm -30] p2r vadd def
	/E D [ 7 mm 225] p2r vadd def
	/G A [10 mm 210] p2r vadd def
	/F G [ 7 mm -45] p2r vadd def
	/u 4 mm def /v 10 mm def /w 13 mm def
	[ [A	45 u -1] [B 135 u  1] [C  45 w -1]
		[D 225 u	1] [E 225 u -1] [F 135 u  1]
		[G 135 w -1] [C -45 u	1] [B 225 u -1]
		[A -45 u	1] [D -45 v -1] [E 135 u  1]
		[F 225 v -1] [G	45 u  1] ]
} 10 ldef
/knot-7-4
{ /A [currentpoint] def
	/B A [10 mm 120] p2r vadd def
	/C A [10 mm 180] p2r vadd def
	/D A [10 mm 240] p2r vadd def
	/E A [10 mm 300] p2r vadd def
	/F A [10 mm 360] p2r vadd def
	/G A [10 mm 420] p2r vadd def
	/u 4 mm def /v 7 mm def /w 10 mm def
	[ [A 120 u	1] [B 120 w -1] [C -60 u  1]
		[D -60 v -1] [E	60 u  1] [F  60 w -1]
		[G 240 u	1] [A 240 u -1] [D 240 w  1]
		[C	60 u -1] [B  60 v  1] [G -60 u -1]
		[F -60 w	1] [E 120 u -1] ]
} 10 ldef
/knot-7-5
{ /A [currentpoint] def
	/B A [ 7 mm	90] p2r vadd def
	/C B [ 7 mm 120] p2r vadd def
	/D B [ 7 mm	60] p2r vadd def
	/E A [ 7 mm -45] p2r vadd def
	/F E [ 7 mm 225] p2r vadd def
	/G A [ 7 mm 225] p2r vadd def
	/u 5 mm def /v 10 mm def /w 15 mm def
	[ [A	45 u  1] [B 135 u -1] [C  90 u  1]
		[D -90 u -1] [B 225 u	1] [A -45 u -1]
		[E -45 v	1] [F 135 u -1] [G 135 w  1]
		[C	 5 u -1] [D  -5 w  1] [E 225 u -1]
		[F 225 v	1] [G  45 u -1] ]
} 10 ldef
/knot-7-6
	{ /A [currentpoint] def
		/B A [ 7 mm	75] p2r vadd def
		/C B [ 7 mm 105] p2r vadd def
		/D A [10 mm 180] p2r vadd def
		/E A [10 mm 240] p2r vadd def
		/F A [10 mm -60] p2r vadd def
		/G A [10 mm	 0] p2r vadd def
		/u 5 mm def /v 10 mm def /w 15 mm def
		[ [A	60 u -1] [B  90 u  1] [C 135 w -1]
			[D -60 u	1] [E -60 u -1] [F  60 u  1]
			[G	60 w -1] [C 225 u  1] [B   0 u -1]
			[G -60 v	1] [F 120 u -1] [A 120 u  1]
			[D 240 v -1] [E	60 u  1] ]
	} 10 ldef
/knot-7-7
	{ /O [currentpoint] def
		/A O [ 4 mm 180] p2r vadd def
		/B A [ 8 mm	60] p2r vadd def
		/C O [12 mm	 0] p2r vadd def
		/D C [ 8 mm 240] p2r vadd def
		/E A [ 8 mm 240] p2r vadd def
		/F O [12 mm 180] p2r vadd def
		/G O [ 4 mm	 0] p2r vadd def
		/u 5 mm def /v 8 mm def /w 12 mm def
		[ [A	60 u -1] [B  60 w  1] [C 240 u -1]
			[D 240 v	1] [E 120 u -1] [F 120 w  1]
			[B -60 u -1] [G -60 u	1] [D -60 v -1]
			[C 180 u	1] [G 180 u -1] [A 180 u  1]
			[F 180 v -1] [E	60 u  1] ]
	} 11 ldef
/art
{ /A [currentpoint] def
	/B A [ 8 mm	90] p2r vadd def
	/C B [ 8 mm	90] p2r vadd def
	/D A [13 mm 210] p2r vadd def
	/E D [10 mm -45] p2r vadd def
	/F A [13 mm -30] p2r vadd def
	/G F [10 mm 225] p2r vadd def
	/u 4 mm def /v 10 mm def /w 13 mm def
	A dot B dot C dot D dot E dot F dot G dot
	[ [A	45 u -1] [B 135 u  1] [C  45 w -1]
		[D -45 u	1] [E -45 u -1] [F 135 u  1]
		[G 135 w -1] [C -45 u	1] [B 225 u -1]
		[A -45 u	1] [D -45 v -1] [E  45 u  1]
		[F 225 v -1] [G	45 u  1] ]
} 10 ldef
/chemdist 6 mm def
/chempoints 20 array def
/chemlabels 50 array def
% general procedures
/cheminit % pnt angle => -
{	/chemangle xdef /chempoint xdef
	chempoints 0 0 put
	chemlabels 0 0 put
	1 1 TeXsetfill
} def
/chemclose
{	chemlabels 1 chemlabels 0 get getinterval
	{aload pop exch 2 2 label} forall
} def
/atom % label
{	/lbl xdef chemlabels [chempoint lbl] spush
} def
/bondlines % pnta pntb n => -
{	gsave
	newpath /n xdef line /c 0 def /lw currentlinewidth def
	n 2 mul 1 sub -2 0
	{	gsave lw mul setlinewidth c setgray stroke /c 1 c sub def
		grestore
	} for
	grestore
} 3 ldef
/spush % stack any => -
{	/a xdef /s xdef /n s 0 get 1 add def s 0 n put s n a put
} 3 ldef
/spop % stack => top element
{	/s xdef /n s 0 get def s n get s 0 n 1 sub put
} 2 ldef
/xbond % angle n length => -
	{	/l xdef /n xdef /a xdef
		chempoint
			/chemangle chemangle a add def
			/chempoint chempoint [l chemangle] p2r vadd def
		chempoint n bondlines
	} def
/chempush {chempoints [chempoint chemangle] spush} def
/single {1 chemdist xbond} def
/double	{2 chemdist xbond} def
/triple	{3 chemdist xbond} def
/single* {chempush single} def
/double* {chempush double} def
/triple* {chempush triple} def
/back
{	chempoints spop aload pop
	/chemangle xdef /chempoint xdef
} def
/benzene
{	chempoint [chemdist chemangle] p2r vadd
	chemdist 3 sqrt 2 div mul 2 sub circle stroke
	-60 single* 5 {60 single*} repeat
} def

% DATA TYPES
%	
%	label:		string
%	node:		[xcenter ybaseline label]
%	leaf:		[label]
%	branch:		[label node1 ... noden]
%	tree:		leaf | node | [label tree1 ... treen]
%	ctree:		a tree, but not a branch, leaf or node	
%
% METHOD
%	
%	The program takes a tree and returns its top node. 
%	a tree as above. The program applies the following rules to
%	the tree:
%
%		1	a)	It is a label; leave it. 
%			b)	It is a node; leave it.
%
%		2	a)	It is a leaf; draw it and return node.
%			b)	It is a branch; draw it and return top node.
%
%		3		It is a tree; process each entry separately and
%				astore the tree into a branch; then reprocess it. 

% MAIN

/tree % tree => node
{	dup treetype 					% tree treetype
	cvx exec
} def

% TREETYPE CASES

/TeXstringwidth {TeXbbox pop exch pop exch sub 0} def
/treelabel { } def

/node  { } def

/leaf % [string] => node
{	aload pop 					% string
	currentpoint pop 			% string x1
	1 index TeX currentpoint 	% string x1 x2 y 
	3 1 roll add 2 div exch		% string x y
	3 -1 roll 3 array astore	% [x y string]
	hspace 0 rmoveto
} def

/branch % [string node1 node2 ... noden] => node
{	dup length 1 sub /n exch def 	% branch
	dup aload pop 					% branch string node1 ... noden
	1 get n 1 sub					% branch string node1 ... noden-1 yn n-1
	{	exch 1 get max
	} repeat
	vspace add						% branch string y
	2 index dup 					% branch string y branch branch
	1 get 0 get exch n get 0 get	% branch string y x1 xn
	add 2 div exch 3 -1 roll		% branch string x y
	3 array astore exch 			% node branch
	dup 0 1 index 1 get put 		% node [node1 node1 ... noden]
	{	1 index nodeline
	} forall
	dup aload pop 3 1 roll			% node string x y 
	2 index TeXstringwidth pop 2 div  	% node string x y sw/2 
	3 -1 roll exch sub exch			% node string x y
	gsave moveto TeX grestore		% node
} def

/ctree % [string tree1 ... treen] => node
{	dup length 1 sub 1 1 3 -1 roll	% ctree 1 1 n
	{	1 index exch dup 2 index	% ctree ctree i i ctree
		exch get					% ctree ctree i treei 
		tree						% ctree ctree i nodei
		put							% ctree
	} for
	branch
} def

/nodeline % node1 node => -
{	gsave
		aload pop pop vspace- sub moveto
		aload pop pop vspace+ add lineto stroke
	grestore
} def

% TREETYPE TESTS: tree => bool

/node? 
{	dup type /arraytype eq
	{	0 get type dup
		/integertype eq exch /realtype eq or
	} 
	{	pop false
	} ifelse
} def

/treetype
{	dup type /stringtype eq						% tree bool
	{	pop /treelabel							% /treelabel
	}
	{	dup 0 get dup type /stringtype eq		% tree tree_0 bool
		{	pop dup length						% tree length
			dup 1 eq							% tree length bool
			{	pop pop /leaf					% /leaf
			}
			{	1 sub 1 1 						% tree length-1 1 1 
				3 -1 roll true					% tree 1 1 length-1 true
				4 1 roll						% tree true 1 1 length-1
				{ 	2 index						% tree bool i tree 
					exch get					% tree bool tree_i
					node? and					% tree bool
				} for
				{pop /branch} {pop /ctree} ifelse
			} ifelse
		}
		{	pop pop /node						% /node
		} ifelse
	} ifelse							
} def


% CREATE AN ISO-LATIN1 ENCODED TIMES FONT
%/TimesRoman findfont 
%dup length dict begin
%	{1 index /FID ne {def} {pop pop} ifelse} forall
%	/Encoding ISOLatin1Encoding def
%	currentdict
%end
%/TimesRoman-ISOLatin1 exch definefont pop
%/TimesRoman-ISOLatin1 findfont fontsize scalefont setfont

% DEFAULTS
/hspace 10 def
/vspace 20 def
/vspace+ 10 def
/vspace- 3.33 def

% Define procedures
/yxline % P Q
{	aload pop /y2 xdef /x2 xdef 
	aload pop /y1 xdef /x1 xdef
	x1 y1 moveto x1 y2 lineto x2 y2 lineto 
} 4 ldef

/nextline {/nextpnt nextpnt [0 -15] vadd def} def

/Root % Label Pnt
{	10 dict begin
	/rootpnt xdef /rootlabel xdef
	rootlabel rootpnt 2 -3 1 0 xlabel
	/nextpnt rootpnt [20 0] vadd def
	/rootpnt nextpnt [-5 -5] vadd def
	nextline
} def

/Subtree % Label
{	rootpnt nextpnt yxline stroke
	nextpnt Root
} def

/Endtree
{	nextpnt 1 get
	end 
	nextpnt 0 get exch
	2 array astore /nextpnt xdef
} def

/Endroot
{	end nextline
} def

/Node % Label
{	rootpnt nextpnt yxline stroke
	nextpnt 2 -3 1 0 xlabel 
	nextline
} def

%% Trees
/words {[0 0] ( ) cdentry hspace vspace cdlist} def
/cat {dup type /stringtype eq {[0 0]} {[0 vspace] smul} ifelse 
	3 -1 roll cdsuper vadd exch cdentry def} def
/trans {/vspace -10 def exch cdsuper exch cdentry} 1 ldef
/lex {gsave 2 setlinewidth cdarrow-line grestore} def
/head {gsave 2 setlinewidth cdarrow-line grestore} def
/comp {cdarrow-line} def
/adj {[3 1] 0 setdash cdarrow-line nodash} def
/landing {[1 3] 0 setdash cdarrow-line nodash} def
/filler {landing (_{fill}) 0.5 cdpnt 2 2 label} def
end
end
