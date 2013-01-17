%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%||||||||||||||||||||«makecirc.mp»|||||||||||||||||||||||||%%
%%==========================================================%%
%<------------------- version 1.1 ------------------------->%%
% A MetaPost library for drawing electrical circuit diagrams.
% Copyright (c) 2003 GS Bustamante Argañaraz. 
% It uses latex.mp by JL Diaz.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This program may be distributed and/or modified under the conditions
% of the LaTeX Project Public License, either version 1.2 of this
% license or (at your option) any later version.  The latest version
% of this license is in http://www.latex-project.org/lppl.txt and
% version 1.2 or later is part of all distributions of LaTeX version
% 1999/12/01 or later.
%
% This program consists of the files makecirc.mp and latex.mp
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
input latex;
%
% Commands definitions to do the labeled easier %
%
LaTeXsetup:=LaTeXsetup & 
"\def\ohm{\ensuremath{\,\Omega}}" &
"\def\kohm{\,k\ensuremath{\Omega}}" &
"\def\modarg#1#2{\setbox0=\hbox{$\mkern-1mu/#2^\circ$}" &
"\dp0=.21ex $#1\underline{\box0}$}";
%
newinternal labeling, rotatelabel, norotatelabel;
labeling:=0; norotatelabel:=labeling; rotatelabel:=1;

% Macros for the pens, I define them as such so when they expand,
% look for the last value assigned to linewd and use it
% (thanks to JLD). The linewd value assigns it as newinternal to
% be able to change it «from out».

newinternal linewd;
linewd:=0.25mm;

def line = pencircle scaled linewd enddef;
def misc = pencircle scaled .8linewd enddef;

% Arrowhead definitions %

vardef miscahead expr p =
save A,u,a,b; pair A,u; path a,b;
A := point length(p) of p;
u := unitvector(direction length(p)/2 of p);
a := A--(A - ahlength*u rotated 15);
b := A--(A - ahlength*u rotated -15);
(a & reverse(a) & b & reverse(b))--cycle
enddef;

vardef bjtahead expr p =
save A,u,a,b; pair A,u; path a,b;
A := point 0.7length(p) of p;
u := unitvector(direction length(p)/2 of p);
a := A--(A - ahlength*u rotated 20);
b := A--(A - ahlength*u rotated -20);
(a & reverse(a) & b & reverse(b))--cycle
enddef;

vardef txtahead expr p =
save A,B,u,a; pair A,B,u; path a;
A := point length p of p;
B := point .97length p of p;
u := unitvector(direction length p of p);
a := A{-u}..(A - 7*u rotated 15)--B
	--(A - 7*u rotated -15)..A{u}--cycle;
a
enddef;

% Macros for wire the symbols %

newinternal nsq, udsq, rlsq, usq;
nsq:=0; udsq:=2; rlsq:=3; usq:=4;

def wire(expr pin_beg,pin_end,type)=
	if type=nsq:
		draw pin_beg--pin_end withpen line
	elseif type=udsq:
		draw pin_beg--(xpart pin_beg,ypart pin_end)--pin_end withpen line
	elseif type=rlsq:
		draw pin_beg--(xpart pin_end,ypart pin_beg)--pin_end withpen line
	fi;
enddef;

% Macro to connect two branches in parallel %

def wireU(expr pin_beg,pin_end,dist,type)=
	if type=udsq:
		draw pin_beg--(pin_beg+(0,dist))--(xpart pin_end,ypart pin_beg + dist)
		--pin_end withpen line
	elseif type=rlsq:
		draw pin_beg--(pin_beg+(dist,0))--(xpart pin_beg + dist,ypart pin_end)
		--pin_end withpen line
	fi;
enddef;

% Variable to find the center of two pins, for to include a symbols. It returns the point
% and the input angle for the symbol that we want to place.
 
vardef centreof@#(expr pin_beg,pin_end,lchar)=
	pair c@#; numeric phi@#;
		c@#= -lchar*dir angle(xpart(pin_end)-xpart(pin_beg),
		ypart(pin_end)-ypart(pin_beg)) shifted .5[pin_beg,pin_end];
		phi@#=angle(xpart(pin_end)-xpart(pin_beg),
		ypart(pin_end)-ypart(pin_beg));
enddef;

% Variable to center an element regarding the pins of another, at 
% a distance «dist» of the same one. It returns the point in which we should
% place the symbol that we want to center.

vardef centerto.@#(expr pinref_beg,pinref_end)(expr dist,elem)=
	pair @#;
	if (xpart(pinref_beg)=xpart(pinref_end)):
		@#:=(.5[pinref_beg,pinref_end]+(dist,-elem))
	elseif (ypart(pinref_beg)=ypart(pinref_end)):
		@#:=(.5[pinref_beg,pinref_end]+(-elem,dist))
	fi
enddef;

% Macro for scale the circuit when it is concluded. %

def scalecirc expr factor =
	currentpicture:=currentpicture scaled factor
enddef;

% Macro to include text into the circuits %

vardef puttext@#(expr txt, point)=
	label@#(latex(txt),point);
enddef;

% Macro to center text among two pins %

newinternal witharrow, noarrow;
witharrow:=0; noarrow:=1;

vardef ctext@#(expr pin_beg,pin_end,txt,type)=
	save ctxt; picture ctxt;
	ctxt:=nullpicture;
	%ahlength:=10;
	if type=noarrow:
		addto ctxt also thelabel(latex(txt),.5[pin_beg,pin_end]);
	elseif type=witharrow:
		addto ctxt doublepath pin_beg--pin_end;
		addto ctxt contour txtahead pin_beg--pin_end;
		addto ctxt contour txtahead reverse(pin_beg--pin_end);
		addto ctxt also thelabel@#(latex(txt),.5[pin_beg,pin_end]);
	fi;
	draw ctxt withpen line;
enddef;

% Definition of lbsep (label separation), distance among symbol and label. %

newinternal lbsep;
lbsep:=3mm;

% Macros to facilitate the one labeled of the symbols %

def putlabel(expr pin_beg,pin_end,lchar,lcharv,ang,name,val)=
if labeling=rotatelabel:
		if ((ang > (-90)) and (ang <= 90)) or ((ang > 270) and (ang <= 450)):
			label(latex("$" & name & "$") rotatedaround (.5[pin_beg,pin_end],ang), 
			(lchar+lbsep)*dir (90+ang) shifted .5[pin_beg,pin_end]);
			
			label(latex(val) rotatedaround (.5[pin_beg,pin_end],ang),
			(lcharv+lbsep)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		elseif ((ang > 90) and (ang <= 270)) or ((ang > (-270)) and (ang <= (-90))):
			label(latex("$" & name & "$") rotatedaround (.5[pin_beg,pin_end],180+ang), 
			(lchar+lbsep)*dir (90+ang) shifted .5[pin_beg,pin_end]);
			
			label(latex(val) rotatedaround (.5[pin_beg,pin_end],180+ang),
			(lcharv+lbsep)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		fi;
	elseif labeling=norotatelabel:
		if (ang = 0):
			label.top(latex("$" & name & "$"), (lchar+.25lbsep)*dir (90+ang) 
			shifted .5[pin_beg,pin_end]);
			
			label.bot(latex(val),(lcharv+.25lbsep)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		elseif (ang > 0) and (ang < 90):
			label.ulft(latex("$" & name & "$"), (lchar)*dir (90+ang) 
			shifted .5[pin_beg,pin_end]);
			
			label.lrt(latex(val),(lcharv)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		elseif (ang = 90):
			label.lft(latex("$" & name & "$"),(lchar+.25lbsep)*dir (90+ang)
			shifted .5[pin_beg,pin_end]);
			
			label.rt(latex(val),(lcharv+.25lbsep)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		elseif (90 < ang) and (ang < 180):
			label.llft(latex("$" & name & "$"),(lchar)*dir (90+ang)
			shifted .5[pin_beg,pin_end]);
			
			label.urt(latex(val),(lcharv)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		elseif (ang = 180) or (ang = (-180)):
			label.bot(latex("$" & name & "$"), (lchar+.25lbsep)*dir (90+ang) 
			shifted .5[pin_beg,pin_end]);
			
			label.top(latex(val),(lcharv+.25lbsep)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		elseif ((ang > 180) and (ang < 270)) or ((ang > (-180)) and (ang < (-90))):
			label.lrt(latex("$" & name & "$"),(lchar)*dir (90+ang)
			shifted .5[pin_beg,pin_end]);
			
			label.ulft(latex(val),(lcharv)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		elseif (ang = 270) or (ang = (-90)):
			label.rt(latex("$" & name & "$"), (lchar+.25lbsep)*dir (90+ang) 
			shifted .5[pin_beg,pin_end]);
			
			label.lft(latex(val),(lcharv+.25lbsep)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		elseif ((270 < ang) and (ang < 360)) or ((ang < 0) and (ang > (-90))):
			label.urt(latex("$" & name & "$"),(lchar)*dir (90+ang)
			shifted .5[pin_beg,pin_end]);
			
			label.llft(latex(val),(lcharv)*dir (270+ang) shifted .5[pin_beg,pin_end]);
		fi;
	fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Here the symbols begin %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%<---Inductor (bobina) --->%%%

newinternal coil, Up, Down;
coil:=2mm; Up:=0; Down:=1;

vardef inductor@#(expr z,type,ang,name,val)=
	save bobina;
	pair L@#.l, L@#.r; % pines %
	L@#.l=z; L@#.r=(z+(6coil,0)) rotatedaround (z,ang);
	picture bobina;
	bobina:=nullpicture;
	
	if type=Up:
		addto bobina doublepath z--(z+(coil,0)){up}.. for i=2 upto 4:
		{down}(z+(i*coil,0)){up}.. endfor {down}(z+(5coil,0))--(z+(6coil,0));
		putlabel(L@#.l,L@#.r,coil,.5coil,ang,name,val);
	elseif type=Down:
		addto bobina doublepath z--(z+(coil,0)){down}.. for i=2 upto 4:
		{up}(z+(i*coil,0)){down}.. endfor {up}(z+(5coil,0))--(z+(6coil,0));
		putlabel(L@#.l,L@#.r,coil,.5coil,(ang-180),name,val);
	fi;
	
	draw bobina rotatedaround(z,ang) withpen line;
enddef;

%%%<---Capacitor (condensador)--->%%%

newinternal normal, electrolytic, variable, variant, platsep;
normal:=0; electrolytic:=1; variable:=2; platsep:=1mm; variant:=3;

vardef capacitor@#(expr z,type,ang,name,val)=
	save cap;
	pair C@#.l, C@#.r; % pines %
	C@#.l:=z;
	C@#.r:=(xpart(z)+7platsep,ypart(z)) rotatedaround(z,ang);
	picture cap; cap:=nullpicture;
	
	addto cap doublepath z--(xpart(z)+3platsep,ypart(z)) withpen line;
	addto cap doublepath (xpart(z)+4platsep,ypart(z))
	--(xpart(z)+7platsep,ypart(z)) withpen line;
	
	if type=normal:
		addto cap doublepath (xpart(z)+3platsep,ypart(z)-2.5platsep)
		--(xpart(z)+3platsep,ypart(z)+2.5platsep) withpen line;
		addto cap doublepath (xpart(z)+4platsep,ypart(z)-2.5platsep)
		--(xpart(z)+4platsep,ypart(z)+2.5platsep) withpen line;
	elseif type=electrolytic:
		addto cap doublepath (xpart(z)+3platsep,ypart(z)-1.8platsep)
		--(xpart(z)+3platsep,ypart(z)+1.8platsep) withpen line;
		addto cap doublepath (xpart(z)+2platsep,ypart(z)-2.5platsep)
		--(xpart(z)+4platsep,ypart(z)-2.5platsep)--(xpart(z)+4platsep,ypart(z)+2.5platsep)
		--(xpart(z)+2platsep,ypart(z)+2.5platsep) withpen line;
	elseif type=variable:
		addto cap doublepath (xpart(z)+3platsep,ypart(z)-2.5platsep)
		--(xpart(z)+3platsep,ypart(z)+2.5platsep) withpen line;
		addto cap doublepath (xpart(z)+4platsep,ypart(z)-2.5platsep)
		--(xpart(z)+4platsep,ypart(z)+2.5platsep) withpen line;
		addto cap doublepath (xpart(z)+platsep,ypart(z)-2.5platsep)
		--(xpart(z)+6platsep,ypart(z)+2.5platsep) withpen misc;
		ahlength:=1.7platsep;
		addto cap contour miscahead (xpart(z)+platsep,ypart(z)-2.5platsep)
		--(xpart(z)+6platsep,ypart(z)+2.5platsep) withpen misc;
	elseif type=variant:
		addto cap doublepath (xpart(z)+3platsep,ypart(z)-2.5platsep)
		--(xpart(z)+3platsep,ypart(z)+2.5platsep) withpen line;
		addto cap doublepath (z+(4.5platsep,-2.5platsep))..(z+(4platsep,0))
		..(z+(4.5platsep,2.5platsep)) withpen line;
	fi;
	
	draw cap rotatedaround(z,ang);
	
	putlabel(C@#.l,C@#.r,2.5platsep,2.5platsep,ang,name,val);
enddef;

%%%<--- Electrical machines (maquinas electricas) --->%%%

vardef motor@#(expr z,ang,name,val)=
	save mot, p, q, r, s, ca, cb, c, hc;
	pair M@#.D, M@#.B; % pines %
	M@#.D:=z; M@#.B:=(z+(2ssize,0)) rotatedaround(z,ang);
	picture mot; mot:=nullpicture;
	
	addto mot doublepath z--(z+(.4ssize,0));
	addto mot doublepath (z+(1.6ssize,0))--(z+(2ssize,0));
	addto mot doublepath fullcircle scaled ssize shifted (z+(ssize,0));
	addto mot also thelabel(latex("\textsf{M}") scaled (ssize/6mm) 
	rotated (-ang), (z+(ssize,0)));
	
	path p,q,r,s,ca,cb,c,hc;
	p=(z+(.6ssize,.075ssize))--(z+(.4ssize,.075ssize));
	q=(z+(.4ssize,.075ssize))--(z+(.4ssize,-.075ssize));
	ca=(z+(.4ssize,-.075ssize))--(z+(.6ssize,-.075ssize));
	
	
	r=(z+(1.4ssize,.075ssize))--(z+(1.6ssize,.075ssize));
	s=(z+(1.6ssize,.075ssize))--(z+(1.6ssize,-.075ssize));
	cb=(z+(1.6ssize,-.075ssize))--(z+(1.4ssize,-.075ssize));
	
	c=fullcircle scaled ssize shifted (z+(ssize,0));
	hc=halfcircle scaled ssize rotated 270 shifted (z+(ssize,0));
	
	addto mot contour buildcycle(p,q,ca,c);
	addto mot doublepath buildcycle(p,q,ca,c);
	
	addto mot contour buildcycle(cb,s,r,hc);
	addto mot doublepath buildcycle(cb,s,r,hc);
	
	draw mot rotatedaround(z,ang) withpen line;
	
	putlabel(M@#.D,M@#.B,.5ssize,.5ssize,ang,name,val);
enddef;

vardef generator@#(expr z,ang,name,val)=
	save gen;
	pair G@#.D, G@#.B; % pines %
	G@#.D:=z; G@#.B:=(z+(2ssize,0)) rotatedaround(z,ang);
	picture gen; gen:=nullpicture;
	
	addto gen doublepath z--(z+(.5ssize,0));
	addto gen doublepath (z+(1.5ssize,0))--(z+(2ssize,0));
	addto gen doublepath fullcircle scaled ssize shifted (z+(ssize,0));
	addto gen also thelabel(latex("\textsf{G}") scaled (ssize/6mm) 
	rotated (-ang), (z+(ssize,0)));
	
	draw gen rotatedaround(z,ang) withpen line;
	
	putlabel(G@#.D,G@#.B,.5ssize,.5ssize,ang,name,val);
enddef;

newinternal mid, Fe, auto;
mid:=1; Fe:=2; auto:=3;

vardef transformer@#(expr z,type,ang)=
	save trafo;
	pair tf@#.pi, tf@#.ps, tf@#.si, tf@#.ss, tf@#.m;
	tf@#.pi:=z; tf@#.ps:=(z+(0,8coil)) rotatedaround(z,ang);
	tf@#.si:=(z+(2.4coil,0)) rotatedaround(z,ang);
	tf@#.ss:=(z+(2.4coil,8coil)) rotatedaround(z,ang);
	tf@#.m:=(z+(3.4coil,4coil)) rotatedaround(z,ang);
	
	picture trafo; trafo:=nullpicture;
	
	if type=normal:
	tf@#.pi:=z; tf@#.ps:=(z+(0,8coil)) rotatedaround(z,ang);
	tf@#.si:=(z+(2.4coil,0)) rotatedaround(z,ang);
	tf@#.ss:=(z+(2.4coil,8coil)) rotatedaround(z,ang);
		addto trafo doublepath z--(z+(0,coil)){right}..
		for i=2 upto 6:	{left}(z+(0,i*coil)){right}.. endfor
		{left}(z+(0,7coil))--(z+(0,8coil));
		addto trafo doublepath (z+(coil,coil))--(z+(coil,7coil));
		addto trafo doublepath (z+(1.4coil,coil))--(z+(1.4coil,7coil));
		addto trafo doublepath (z+(2.4coil,0))--(z+(2.4coil,coil)){left}..
		for i=2 upto 6:	{right}(z+(2.4coil,i*coil)){left}.. endfor
		{right}(z+(2.4coil,7coil))--(z+(2.4coil,8coil));
	elseif type=mid:
	tf@#.pi:=z; tf@#.ps:=(z+(0,8coil)) rotatedaround(z,ang);
	tf@#.si:=(z+(2.4coil,0)) rotatedaround(z,ang);
	tf@#.ss:=(z+(2.4coil,8coil)) rotatedaround(z,ang);
	tf@#.m:=(z+(3.4coil,4coil)) rotatedaround(z,ang);
		addto trafo doublepath z--(z+(0,coil)){right}..
		for i=2 upto 6:	{left}(z+(0,i*coil)){right}.. endfor
		{left}(z+(0,7coil))--(z+(0,8coil));
		addto trafo doublepath (z+(coil,coil))--(z+(coil,7coil));
		addto trafo doublepath (z+(1.4coil,coil))--(z+(1.4coil,7coil));
		addto trafo doublepath (z+(2.4coil,0))--(z+(2.4coil,coil)){left}..
		for i=2 upto 6:	{right}(z+(2.4coil,i*coil)){left}.. endfor
		{right}(z+(2.4coil,7coil))--(z+(2.4coil,8coil));
		addto trafo doublepath (z+(2.4coil,4coil))--(z+(3.4coil,4coil));
	elseif type=Fe:
	tf@#.pi:=z rotatedaround(z,ang); tf@#.ps:=(z+(0,5.3coil)) rotatedaround(z,ang);
	tf@#.si:=(z+(14coil,0)) rotatedaround(z,ang);
	tf@#.ss:=(z+(14coil,5.228coil)) rotatedaround(z,ang);
		addto trafo doublepath z+(2coil,-2.5coil)--z+(12coil,-2.5coil)
		--z+(12coil,7.5coil)--z+(2coil,7.5coil)--cycle;
		addto trafo doublepath z+(4coil,-.5coil)--z+(10coil,-.5coil)
		--z+(10coil,5.5coil)--z+(4coil,5.5coil)--cycle;
		addto trafo doublepath z--z+(2coil,0)--z+(4coil,0.728coil)
		{right}..{left}z+(4coil,1.3*coil);
		for i=1 upto 4:
			addto trafo doublepath z+(2coil,(i+.5)*coil){left}..
			{right}z+(2coil,i*coil)--z+(4coil,(i+0.728)*coil)
			{right}..{left}z+(4coil,(i+1.3)*coil);
		endfor;
		addto trafo doublepath z+(2coil,5.3coil)--z+(0,5.3coil);
		for i=0 upto 3:
			addto trafo doublepath z+(10coil,i*coil){left}..
			{right}z+(10coil,(i+.5)*coil)--z+(12coil,(i+.5+0.728)*coil)
			{right}..{left}z+(12coil,(i+.656)*coil);
		endfor;
		addto trafo doublepath z+(10coil,4coil){left}..{right}
		z+(10coil,4.5coil)--z+(12coil,5.228coil)--z+(14coil,5.228coil);
		addto trafo doublepath z+(12coil,0)--z+(14coil,0);
	elseif type=auto:
	tf@#.pi:=z rotatedaround(z,ang); tf@#.ps:=(z+(0,4coil)) rotatedaround(z,ang);
	tf@#.si:=(z+(4coil,-6coil)) rotatedaround(z,ang);
	tf@#.ss:=(z+(4coil,4coil)) rotatedaround(z,ang);
		addto trafo doublepath z--z+(2coil,0);
		addto trafo doublepath z+(2coil,-6coil)--z+(2coil,-5coil){right}..
		for i=2 upto 10: {left}(z+(2coil,(i-6)*coil)){right}.. endfor
		{left}(z+(2coil,5coil))--z+(2coil,6coil)--z+(0,6coil);
		addto trafo doublepath z+(2coil,6coil)--z+(4coil,6coil);
		addto trafo doublepath z+(2coil,-6coil)--z+(4coil,-6coil);
	fi;
	
	draw trafo rotatedaround(z,ang) withpen line;
enddef;

%%%<---Sources (fuentes de alimentaci'on)--->%%%

newinternal AC,DC,I,V,ssize;
AC:=1; DC:=0; I:=2; V:=3; ssize:=6mm; 

vardef source@#(expr z,type,ang,name,val)=
	save fuente, positive, negative, seno;
	pair S@#.p,S@#.n; % pines %
	if (type=AC) or (type=I) or (type=V):
		S@#.n:=z;
		S@#.p:=(z+(2ssize,0)) rotatedaround(z,ang);
	elseif type=DC:
		S@#.p:=(z+(ssize,0)) rotatedaround(z,ang);
		S@#.n:=z;
	fi;
	
	picture fuente, positive, negative, seno;
	positive:=nullpicture; negative:=nullpicture;
	
	addto positive doublepath (z+(1.05ssize,0))--(z+(1.45ssize,0)) withpen misc;
	addto positive doublepath (z+(1.25ssize,-.2ssize))--(z+(1.25ssize,.2ssize))	withpen misc;
	addto negative doublepath (z+(.95ssize,0))--(z+(.55ssize,0)) withpen misc;
	
	seno:=nullpicture;
	addto seno doublepath (z+(2ssize/3,0)){dir 45}
	..{right}.5[z+(2ssize/3,.2ssize),z+(ssize,.2ssize)]..{dir -45}(z+(ssize,0))
	..{right}.5[z+(ssize,-.2ssize),z+(4ssize/3,-.2ssize)]..{dir 45}(z+(4ssize/3,0))
	withpen line;
	
	fuente:=nullpicture;
	if (type=AC) or (type=I) or (type=V):
		addto fuente doublepath z--(z+(.5ssize,0)) withpen line;
		addto fuente doublepath (z+(1.5ssize,0))--(z+(2ssize,0)) withpen line;
		addto fuente doublepath fullcircle scaled ssize shifted (z+(ssize,0))
		 withpen line;
		if type=AC:
			addto fuente also seno rotatedaround((z+(ssize,0)),-ang);
		elseif type=I:
			ahlength:=4ssize/15; ahangle:=30;
			addto fuente doublepath (z+(ssize-ssize/3,0))--(z+(ssize+ssize/3,0))
			 withpen line;
			addto fuente contour arrowhead (z+(ssize-ssize/3,0))--(z+(ssize+ssize/3,0))
			withpen line;
			ahlength:=4; ahangle:=45;
		elseif type=V:
			addto fuente also positive rotatedaround(z+(1.25ssize,0),-ang);
			addto fuente also negative rotatedaround(z+(.75ssize,0),-ang);
		fi;
	elseif type=DC:
		addto fuente doublepath z--(z+(0.4ssize,0)) withpen line;
		addto fuente doublepath (z+(.6ssize,0))--(z+(ssize,0)) withpen line;
		addto fuente doublepath (z+(.4ssize,-.2ssize))--(z+(.4ssize,.2ssize)) withpen line;
		addto fuente doublepath (z+(.6ssize,-.6ssize))--(z+(.6ssize,.6ssize)) withpen line;
	fi;
	
	if (type=AC) or (type=V) or (type=I):
		putlabel(S@#.n,S@#.p,.5ssize,.5ssize,ang,name,val);
	elseif (type=DC):
		putlabel(S@#.n,S@#.p,.6ssize,.6ssize,ang,name,val);
	fi;
	
	draw fuente rotatedaround (z,ang);
enddef;

%%%<---Resistor (Resistencia)--->%%%

newinternal rstlth;
rstlth:=2mm;

vardef resistor@#(expr z,type,ang,name,val)=
	save rst;
	pair R@#.l,R@#.r; % pines %
	R@#.l:=z;
	R@#.r:=(z+(7rstlth,0)) rotatedaround(z,ang);
	picture rst;
	rst:=nullpicture;
	addto rst doublepath z--(z+(2rstlth,0))--(z+(2.25rstlth,.75rstlth))--
	for i=.5 step .5 until 2.5:	(z+((2.25+i)*rstlth,((-1)**(2i))*.75rstlth))--
	endfor (z+(5rstlth,0))--(z+(7rstlth,0)) withpen line;
	if type=normal:
		% no change %
	elseif type=variable:
		ahlength:=.8rstlth;
		addto rst doublepath (z+(2rstlth,-rstlth))--(z+(5.5rstlth,rstlth)) withpen misc;
		addto rst contour miscahead (z+(2rstlth,-rstlth))--(z+(5.5rstlth,rstlth))
		 withpen misc;
	fi;
	
	putlabel(R@#.l,R@#.r,.8rstlth,.8rstlth,ang,name,val);
	
	draw rst rotatedaround(z,ang);
enddef;

%%%<--- Diode (diodo) --->%%%
newinternal zener, LED, diodeht, pinK, pinA;
zener:=1; LED:=2; diodeht:=3.5mm; pinK:=3; pinA:=4;

vardef diode@#(expr z,type,ang,pin,name,val)=
	save diodo;
	pair D@#.K,D@#.A; % pines %
	picture diodo;
	diodo:=nullpicture;
	
	addto diodo doublepath z--(z+(diodeht,0))--(z+(diodeht,.5diodeht))
	--(z+(2diodeht,0))--(z+(diodeht,-.5diodeht))--(z+(diodeht,0)) withpen line;
	addto diodo doublepath (z+(2diodeht,0))--(z+(3diodeht,0)) withpen line;
	
	if type=normal:
		addto diodo doublepath (z+(2diodeht,-.5diodeht))--(z+(2diodeht,.5diodeht))
		withpen line;
	elseif type=zener:
		addto diodo doublepath (z+(2.5diodeht,-.5diodeht))--(z+(2diodeht,-.5diodeht))
		--(z+(2diodeht,.5diodeht))--(z+(1.5diodeht,.5diodeht)) withpen line;
	elseif type=LED:
		addto diodo doublepath (z+(2diodeht,-.5diodeht))--(z+(2diodeht,.5diodeht))
		withpen line;
		
		addto diodo doublepath (0.25diodeht*dir
		(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))) shifted (z+(2diodeht,.5diodeht)))
		--(diodeht*dir(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))+270) shifted
		(0.25diodeht*dir(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))) shifted 
		(z+(2diodeht,.5diodeht)))) withpen misc;
		
		addto diodo doublepath (0.6diodeht*dir
		(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))) shifted (z+(2diodeht,.5diodeht)))
		--(diodeht*dir(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))+270) shifted
		(0.6diodeht*dir(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))) shifted 
		(z+(2diodeht,.5diodeht)))) withpen misc;
		
		ahlength:=.4diodeht; ahangle:=30;
		addto diodo contour arrowhead (0.25diodeht*dir
		(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))) shifted (z+(2diodeht,.5diodeht)))
		--(diodeht*dir(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))+270) shifted
		(0.25diodeht*dir(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))) shifted 
		(z+(2diodeht,.5diodeht)))) withpen misc;
		
		addto diodo contour arrowhead (0.6diodeht*dir
		(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))) shifted (z+(2diodeht,.5diodeht)))
		--(diodeht*dir(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))+270) shifted
		(0.6diodeht*dir(angle(xpart(z+(diodeht,.5diodeht))-xpart(z+(2diodeht,0)),
		ypart(z+(diodeht,.5diodeht))-ypart(z+(2diodeht,0)))) shifted 
		(z+(2diodeht,.5diodeht)))) withpen misc;
		ahlength:=4; ahangle:=45;
	fi;
	
	if pin=pinA:
		D@#.A:=z;
		D@#.K:=(z+(3diodeht,0)) rotatedaround(z,ang);
		draw diodo rotatedaround(z,ang);
	elseif pin=pinK:
		D@#.K:=z;
		D@#.A:=(z+(3diodeht,0)) rotatedaround(z,ang);
		diodo:=diodo rotatedaround(.5[z,(z+(3diodeht,0))],180);
		draw diodo rotatedaround(z,ang);
	fi;
	
	if (type=normal) or (type=zener):
		putlabel(D@#.A,D@#.K,.6diodeht,.6diodeht,ang,name,val);
	elseif (type=LED):
		putlabel(D@#.A,D@#.K,1.5diodeht,.6diodeht,ang,name,val);
	fi;
enddef;

%%%<--- Transistor --->%%%
newinternal npn, pnp, cnpn, cpnp, bjtlth;
npn:=1; pnp:=-1; cnpn:=0; cpnp:=2; bjtlth:=7mm;

vardef transistor@#(expr z,type,ang)=
	save BJT;
	pair T@#.B,T@#.E,T@#.C; % pines: Base, Emisor, Colector %
	T@#.B:=z;
	T@#.E:=(z+(bjtlth,-.75bjtlth)) rotatedaround(z,ang);
	T@#.C:=(z+(bjtlth,.75bjtlth)) rotatedaround(z,ang);
	picture BJT;
	BJT:=nullpicture;
	
	addto BJT doublepath z--(z+(.5bjtlth,0)) withpen line;
	addto BJT doublepath (z+(.5bjtlth,-.5bjtlth))--(z+(.5bjtlth,.5bjtlth)) withpen line;
	addto BJT doublepath (z+(.5bjtlth,.2bjtlth))--(z+(bjtlth,.5bjtlth))
	--(z+(bjtlth,.75bjtlth)) withpen line;
	
	if type=npn:
		addto BJT doublepath (z+(.5bjtlth,-.2bjtlth))--(z+(bjtlth,-.5bjtlth))
		--(z+(bjtlth,-.75bjtlth)) withpen line;
		addto BJT contour bjtahead (z+(.5bjtlth,-.2bjtlth))
		--(z+(bjtlth,-.5bjtlth)) withpen line;
	elseif type=cnpn:
		addto BJT doublepath (z+(.5bjtlth,-.2bjtlth))--(z+(bjtlth,-.5bjtlth))
		--(z+(bjtlth,-.75bjtlth)) withpen line;
		addto BJT contour bjtahead (z+(.5bjtlth,-.2bjtlth))
		--(z+(bjtlth,-.5bjtlth)) withpen line;
		addto BJT doublepath fullcircle scaled 1.3bjtlth shifted (z+(.65bjtlth,0))
		 withpen line;
	elseif type=pnp:
		addto BJT doublepath (z+(bjtlth,-.75bjtlth))--(z+(bjtlth,-.5bjtlth))
		--(z+(.5bjtlth,-.2bjtlth)) withpen line;
		addto BJT contour bjtahead (z+(bjtlth,-.5bjtlth))
		--(z+(.5bjtlth,-.2bjtlth)) withpen line;
	elseif type=cpnp:
		addto BJT doublepath (z+(bjtlth,-.75bjtlth))--(z+(bjtlth,-.5bjtlth))
		--(z+(.5bjtlth,-.2bjtlth)) withpen line;
		addto BJT contour bjtahead (z+(bjtlth,-.5bjtlth))
		--(z+(.5bjtlth,-.2bjtlth)) withpen line;
		addto BJT doublepath fullcircle scaled 1.3bjtlth shifted (z+(.65bjtlth,0)) withpen line;
	fi;
	
	draw BJT rotatedaround(z,ang);
enddef;

%%%<--- Measurement instruments (Intrumentos de medicion)--->%%%
newinternal volt, ampere, watt;
volt:=0; ampere:=1; watt:=2;

vardef meains@#(expr z,type,ang,name)=
	save meter;
	pair mi@#.l, mi@#.r, mi@#.p; % pines %
	mi@#.l:=z; mi@#.r:=(z+(2ssize,0)) rotatedaround(z,ang);
	
	picture meter; meter:=nullpicture;
	addto meter doublepath z--(z+(.5ssize,0));
	addto meter doublepath (z+(1.5ssize,0))--(z+(2ssize,0));
	if (type=volt) or (type=ampere):	
		addto meter doublepath fullcircle scaled ssize shifted (z+(ssize,0));
		if type=volt:
			addto meter also thelabel(latex("\textsf{V}") scaled (ssize/6mm) 
			rotated (-ang), (z+(ssize,0)));
		elseif type=ampere:
			addto meter also thelabel(latex("\textsf{A}") scaled (ssize/6mm) 
			rotated (-ang), (z+(ssize,0)));
		fi;
	elseif (type=watt):
		mi@#.p:=(z+(ssize,-ssize)) rotatedaround(z,ang);
		addto meter doublepath (z+(.5ssize,-.5ssize))--(z+(.5ssize,.5ssize))
		--(z+(1.5ssize,.5ssize))--(z+(1.5ssize,-.5ssize))--cycle;
		addto meter doublepath (z+(ssize,-.5ssize))--(z+(ssize,-ssize));
		addto meter also thelabel(latex("\textsf{W}") scaled (ssize/6mm) 
		rotated (-ang), (z+(ssize,0)));
	fi;
	
	draw meter rotatedaround(z,ang) withpen line;
	
	if labeling=rotatelabel:
		if ((ang > (-90)) and (ang <= 90)) or ((ang > 270) and (ang <= 450)):
			label(latex(name) rotatedaround (.5[mi@#.l,mi@#.r],ang), 
			(.5ssize+lbsep)*dir (90+ang) shifted .5[mi@#.l,mi@#.r]);
		elseif ((ang > 90) and (ang <= 270)) or ((ang > (-270)) and (ang <= (-90))):
			label(latex(name) rotatedaround (.5[mi@#.l,mi@#.r],180+ang), 
			(.5ssize+lbsep)*dir (90+ang) shifted .5[mi@#.l,mi@#.r]);
		fi;
	elseif labeling=norotatelabel:
		if (ang = 0):
			label.top(latex(name), (.5ssize+.25lbsep)*dir (90+ang) 
			shifted .5[mi@#.l,mi@#.r]);
		elseif (ang > 0) and (ang < 90):
			label.ulft(latex(name), (.5ssize)*dir (90+ang) 
			shifted .5[mi@#.l,mi@#.r]);
		elseif (ang = 90):
			label.lft(latex(name),(.5ssize+.25lbsep)*dir (90+ang)
			shifted .5[mi@#.l,mi@#.r]);
		elseif (90 < ang) and (ang < 180):
			label.llft(latex(name),(.5ssize)*dir (90+ang)
			shifted .5[mi@#.l,mi@#.r]);
		elseif (ang = 180) or (ang = (-180)):
			label.bot(latex(name), (.5ssize+.25lbsep)*dir (90+ang) 
			shifted .5[mi@#.l,mi@#.r]);
		elseif ((ang > 180) and (ang < 270)) or ((ang > (-180)) and (ang < (-90))):
			label.lrt(latex(name),(.5ssize)*dir (90+ang)
			shifted .5[mi@#.l,mi@#.r]);
		elseif (ang = 270) or (ang = (-90)):
			label.rt(latex(name), (.5ssize+.25lbsep)*dir (90+ang) 
			shifted .5[mi@#.l,mi@#.r]);
		elseif ((270 < ang) and (ang < 360)) or ((ang < 0) and (ang > (-90))):
			label.urt(latex(name),(.5ssize)*dir (90+ang)
			shifted .5[mi@#.l,mi@#.r]);
		fi;
	fi;
enddef;

%%%<--- Miscellaneous symbols --->%%%

newinternal gndlth, implth, simple, shield;
gndlth:=5mm; implth:=7mm; simple:=1; shield:=2;

vardef ground@#(expr z,type,ang)=
	save GND;
	pair gnd@#; % unico pin %
	gnd@#:=z;
	picture GND; GND:=nullpicture;
	addto GND doublepath z--(z+(0,-.5gndlth)) withpen line;
	if type=shield:
		addto GND doublepath (z+(-.5gndlth,-.5gndlth))--(z+(.5gndlth,-.5gndlth)) withpen line;
		addto GND doublepath (z+(-.35gndlth,-.6gndlth))--(z+(.35gndlth,-.6gndlth)) withpen line;
		addto GND doublepath (z+(-.2gndlth,-.7gndlth))--(z+(.2gndlth,-.7gndlth)) withpen line;
	elseif type=simple:
		addto GND doublepath (z+(-.5gndlth,-.5gndlth))--(z+(.5gndlth,-.5gndlth)) 
		withpen pencircle scaled 2linewd;
	fi;
	draw GND rotatedaround(z,ang);
enddef;

newinternal junctiondiam;
junctiondiam:=1.25mm;

vardef junction@#(expr z,name)(suffix $)=
	pair J@#; J@#:=z;
	draw z withpen pencircle scaled junctiondiam;
	label.$(latex(name),z);
enddef;

vardef impedance@#(expr z,ang,name,val)=
	save imp;
	pair Z@#.l, Z@#.r; % pines %
	Z@#.l:=z;
	Z@#.r:=(z+(1.5implth,0)) rotatedaround(z,ang);
	picture imp; imp:=nullpicture;
	
	addto imp doublepath z--(z+(.25implth,0));
	addto imp doublepath (z+(.25implth,-.18implth))--(z+(.25implth,.18implth))
	--(z+(1.25implth,.18implth))--(z+(1.25implth,-.18implth))--cycle;
	addto imp doublepath (z+(1.25implth,0))--(z+(1.5implth,0));
		
	draw imp rotatedaround(z,ang) withpen line;
	
	putlabel(Z@#.l,Z@#.r,.2implth,.2implth,ang,name,val);
enddef;

vardef lamp@#(expr z,ang,name,val)=
	save ampl, p, q, r, s;
	pair La@#.l,La@#.r; % pines %
	La@#.l:=z; La@#.r:=(z+(2ssize,0)) rotatedaround(z,ang);
	
	picture ampl; ampl:=nullpicture;
	
	addto ampl doublepath z--(z+(.5ssize,0));
	addto ampl doublepath fullcircle scaled ssize shifted (z+(ssize,0));
	addto ampl doublepath (z+(1.5ssize,0))--(z+(2ssize,0));
	
	pair p, q, r, s;
	p=(-ssize*dir 45 shifted (z+(ssize,0))--(z+(ssize,0))) intersectionpoint
	(fullcircle scaled ssize shifted (z+(ssize,0)));
	q=(ssize*dir 45 shifted (z+(ssize,0))--(z+(ssize,0))) intersectionpoint
	(fullcircle scaled ssize shifted (z+(ssize,0)));
	r=(-ssize*dir (-45) shifted (z+(ssize,0))--(z+(ssize,0))) intersectionpoint
	(fullcircle scaled ssize shifted (z+(ssize,0)));
	s=(ssize*dir (-45) shifted (z+(ssize,0))--(z+(ssize,0))) intersectionpoint
	(fullcircle scaled ssize shifted (z+(ssize,0)));
	
	addto ampl doublepath p--q;
	addto ampl doublepath r--s;
	
	draw ampl rotatedaround(z,ang) withpen line;
	
	putlabel(La@#.l,La@#.r,.5ssize,.5ssize,ang,name,val);
enddef;

%%%<--- Switches (Llaves) --->%%%

newinternal NO, NC, ssep, swt;
NO:=0; NC:=1; ssep:=3mm; swt:=1.2ssep;

vardef switch@#(expr z,type,ang,name,val)=
	save swt; 
	pair st@#.l, st@#.r;
	st@#.l:=z; st@#.r:= (z+(2.4ssep,0)) rotatedaround(z,ang);
	picture swt; swt:=nullpicture;
	
	addto swt doublepath z--(z+(.7ssep,0));
	addto swt doublepath (z+(1.7ssep,ssep/3))--(z+(1.7ssep,0))--(z+(2.4ssep,0));
	
	if type=NO:
		addto swt doublepath (z+(.7ssep,0))--(z+(1.8ssep,.7ssep));
	elseif type=NC:
		addto swt doublepath (z+(.7ssep,0))--(z+(2ssep,ssep/3));
	fi;
	
	draw swt rotatedaround(z,ang) withpen line;
	
	putlabel(st@#.l,st@#.r,.6ssep,.6ssep,ang,name,val);
enddef;

%%%<--- Battery (bater'ia) --->%%%

vardef battery@#(expr z,ang,name,val)=
		save bat;
		pair B@#.n, B@#.p;
		B@#.n:=z; B@#.p:=(z+(1.8ssize,0)) rotatedaround(z,ang);
		
		picture bat; bat:=nullpicture;
		addto bat doublepath z--(z+(0.4ssize,0)) withpen line;
		addto bat doublepath (z+(1.4ssize,0))--(z+(1.8ssize,0));
		for i=0 upto 2:
		addto bat doublepath (z+((.4+.4i)*ssize,-.2ssize))--(z+((.4+.4i)*ssize,.2ssize));
		addto bat doublepath (z+((.6+.4i)*ssize,-.6ssize))--(z+((.6+.4i)*ssize,.6ssize));
		endfor;
		
		draw bat rotatedaround(z,ang) withpen line;
		
		putlabel(B@#.n,B@#.p,.6ssize,.6ssize,ang,name,val);
enddef;

%%%<--- Current (Corriente) --->%%%

vardef current@#(expr z,ang,name,val)=
	save cur;
	pair i@#.s,i@#.d;
	i@#.s:=z; i@#.d:=(z+(3platsep,0)) rotatedaround(z,ang);
	ahangle:=20; ahlength:=3platsep;
	picture cur; cur:=nullpicture;
	addto cur contour arrowhead z--(z+(3platsep,0));
	
	draw cur rotatedaround(z,ang) withpen line;
	
	putlabel(i@#.s,i@#.d,.5platsep,.5platsep,ang,name,val);
	
	ahangle:=45; ahlength:=4;
enddef;

%%%<--- Mesh current (corriente de malla) --->%%%

newinternal cw, ccw;
cw:=0; ccw:=1;

def imesh(expr c,wd,ht,dire,ang,name)=
	save im,r; picture im; numeric r;
	ahlength:=3platsep; ahangle:=20;
	if ht > wd: r=.2wd elseif ht < wd: r=.2ht fi;
	im:=nullpicture;
	if dire=cw:
		addto im doublepath (xpart c - .5wd, ypart c - .5ht)
		--(xpart c - .5wd, ypart c + .5ht-r){up}
		..{right}(xpart c - .5wd + r, ypart c + .5ht)
		--(xpart c + .5wd - r, ypart c + .5ht){right}
		..{down}(xpart c + .5wd,ypart c + .5ht - r)
		--(xpart c + .5wd,ypart c - .5ht + r){down}
		..{left}(xpart c + .5wd - r,ypart c - .5ht)
		--(xpart c - .25wd, ypart c - .5ht);
		addto im contour arrowhead (xpart c - .5wd, ypart c - .5ht)
		--(xpart c - .5wd, ypart c + .5ht-r){up}
		..{right}(xpart c - .5wd + r, ypart c + .5ht)
		--(xpart c + .5wd - r, ypart c + .5ht){right}
		..{down}(xpart c + .5wd,ypart c + .5ht - r)
		--(xpart c + .5wd,ypart c - .5ht + r){down}
		..{left}(xpart c + .5wd - r,ypart c - .5ht)
		--(xpart c - .25wd, ypart c - .5ht);
	elseif dire=ccw:
		addto im doublepath (xpart c + .5wd, ypart c - .5ht)
		--(xpart c + .5wd, ypart c + .5ht-r){up}
		..{left}(xpart c + .5wd - r, ypart c + .5ht)
		--(xpart c - .5wd + r, ypart c + .5ht){left}
		..{down}(xpart c - .5wd,ypart c + .5ht - r)
		--(xpart c - .5wd,ypart c - .5ht + r){down}
		..{right}(xpart c - .5wd + r,ypart c - .5ht)
		--(xpart c + .25wd, ypart c - .5ht);
		addto im contour arrowhead (xpart c + .5wd, ypart c - .5ht)
		--(xpart c + .5wd, ypart c + .5ht-r){up}
		..{left}(xpart c + .5wd - r, ypart c + .5ht)
		--(xpart c - .5wd + r, ypart c + .5ht){left}
		..{down}(xpart c + .5wd,ypart c + .5ht - r)
		--(xpart c - .5wd,ypart c - .5ht + r){down}
		..{right}(xpart c - .5wd + r,ypart c - .5ht)
		--(xpart c + .25wd, ypart c - .5ht);
	fi;
	
	if labeling=rotatelabel:
		addto im also thelabel(latex("$" & name & "$"),c);
	elseif labeling=norotatelabel:
		addto im also thelabel(latex("$" & name & "$") rotatedaround(c,-ang),c);
	fi;
	
	draw im rotatedaround (c,ang) withpen line;
enddef;

%%%<--- Reostatos --->%%%

newinternal rheolth, Rrheo, Lrheo; 
rheolth:=2mm; Rrheo:=1; Lrheo:=2;

vardef rheostat@#(expr z,type,ang)=
	save reo; picture reo; reo:=nullpicture;
	pair rh@#.i, rh@#.s, rh@#.r;
	rh@#.i:=z; rh@#.s:=(z+(0,6rheolth)) rotatedaround(z,ang);
	rh@#.r:=(z+(3rheolth,6rheolth)) rotatedaround(z,ang);
	
	ahangle:=20; ahlength:=rheolth;

	if type=Lrheo:
		addto reo doublepath (z+(6rheolth,-3rheolth))--(z+(4rheolth,-3rheolth))
		--(z+(4rheolth,-.7rheolth));
		addto reo contour arrowhead (z+(6rheolth,-3rheolth))--(z+(4rheolth,-3rheolth))
		--(z+(4rheolth,-.9rheolth));
	
		addto reo doublepath z--(z+(rheolth,0)){down}.. for i=2 upto 4:
		{up}(z+(i*rheolth,0)){down}.. endfor {up}(z+(5rheolth,0))--(z+(6rheolth,0));
	
		reo:=reo rotatedaround(z,90);
	elseif type=Rrheo:
		addto reo doublepath (z+(6rheolth,-3rheolth))--(z+(4rheolth,-3rheolth))
		--(z+(4rheolth,-.7rheolth));
		addto reo contour arrowhead (z+(6rheolth,-3rheolth))--(z+(4rheolth,-3rheolth))
		--(z+(4rheolth,-.9rheolth));
	
		addto reo doublepath z--(z+(1.5rheolth,0))--(z+(1.75rheolth,.75rheolth))--
		for i=.5 step .5 until 2.5:	(z+((1.75+i)*rheolth,((-1)**(2i))*.75rheolth))--
		endfor (z+(4.5rheolth,0))--(z+(6rheolth,0)) withpen line;
	
		reo:=reo rotatedaround(z,90);
	fi;
	draw reo rotatedaround(z,ang) withpen line;
enddef;

% Definiciones de las longitudes de centrado,
% las hago como macros para que cambien de
% valor cuando lo hagan las dimensiones
% caracter'isticas de cada s'imbolo.

def res = 3.5rstlth enddef;		% 1
def ind = 3coil enddef;			% 2
def cap = 3.5platsep enddef;	% 3
def sac = ssize enddef;			% 4
def sv = ssize enddef;			% 5
def si = ssize enddef;			% 6
def sdc = .5ssize enddef;		% 7
def mot = ssize enddef;			% 8
def gen = ssize enddef;			% 9
def tra = 4coil enddef;			%10
def ins = ssize enddef;			%11
def dio = 1.5diodeht enddef;	%12
def bjt = .5bjtlth enddef;		%13
def imp = .75implth enddef;		%14
def lam = ssize enddef;			%15
def swt = 1.2ssep enddef;		%16
def bat = .9ssize enddef;		%17
def cur = 1.5platsep enddef;	%18

%% END %%