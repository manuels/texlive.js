%!PS-Adobe-1.0
%%Creator: Ross Cartlidge <rossc@extro.ucc.su.oz.au>
%%Title: Multiple pages on one page
%%CreationDate: Tue Apr 10 09:37:26 EST 1990
%%Pages: 0
%%DocumentFonts:
%%BoundingBox: 0 0 0 0
%%EndComments
%
% Uncomment the next line if you wish to load multi into the "exitserver"
% state of the PostScript device
% serverdict begin 0 exitserver
%
%
%	make each operator to overlay a procedure so a bind in 
%	a prolog will not stop the overlaying by "multi"
%

[
	/gsave
	/grestore
	/grestoreall
	/initgraphics
	/initmatrix
	/currentmatrix
	/setmatrix
	% Path construction operators
	/initclip
	% Virtual memory operators
	/save
	% ones which needed special overloading
	/showpage
	/erasepage
	/copypage
	/restore
	% ignore these
	/letter
	/legal
	/a4
	/b5
	/lettersmall
	/note
]
{
%	if exists check if operator else define {}
	dup where
	{
		pop
% 		If operator then make into procedure
		dup load type /operatortype eq
		{
			1 array cvx dup
			0
			3 index cvx		% /n -> n
			put			% {}[0] -> n
			bind
			def
		}
		{
			pop
		}
		ifelse
	}
	{
		{} def
	}
	ifelse
}
forall

%
%	Initialise endmulti to execute an error
%
/endmulti
{
	count array astore /ostack exch def
	250 array execstack /estack exch def
	20 array dictstack /dstack exch def
	$error /newerror true put
	$error /errorname (No matching multi) cvn put
	$error /command (endmulti) put
	$error /ostack ostack put
	$error /estack estack put
	$error /dstack dstack put
	stop
}
bind
def

%
%	Put multiple logical pages on one physical page
%	until "endmulti" called
%	
%	landscape nrows ncols left_right up_down row_major dividers multi -
%	landscape nrows ncols up_down row_major dividers multi -
%	landscape nrows ncols row_major dividers multi -
%	landscape nrows ncols dividers multi -
%	landscape nrows ncols multi -
%
%	Go into multi page representation
%
%	landscape	boolean:true - divide page in landscape orientation
%				false- divide page in portrait orirntation
%	nrows		integer:number of logical pages down physical page
%	ncols		integer:number of logical pages across physical page
%	left_right(*)	boolean:true - rows fill left to right
%				false- rows fill right to left
%	up_down(*)	boolean:true - columsn fill top to bottom
%				false- columns fill bottom to top
%	row_major(*)	boolean:true - fill rowwise
%				false- fill columnwise
%	dividers(*)	boolean:true - divide logical pages by lines
%				false- don't divide logical pages
%	
%	NB: Optional parameters(*) default to true.
%
/multi
{
	currentdict
	64 dict begin
	/initdict exch def	% store initial dict for backward reference
%
%	Initialise the Optional Parameters (right to left)
%
	[
		/dividers
		/row_major
		/up_down
		/left_right
	]
	{
		exch dup type /booleantype ne
		{
			exch	% put non bool back
			true def % default to true
		}
		{
			def
		}
		ifelse
		
	}
	forall
	/cols exch def
	/rows exch def

%
%	get size of current page
%
	initgraphics clippath pathbbox
	/Y exch def	% Max Y
	/X exch def	% Max X
	/y exch def	% Min Y
	/x exch def	% Min X
	/W X x add def	% Width of Page
	/H Y y add def	% Height of page

%
%	functions to turn page# into row and column
%	depending on whether rows or cols fill first
%
	row_major
	{
		/tocol { cols mod } def
		/torow { cols idiv } def
	}
	{
		/tocol { rows idiv } def
		/torow { rows mod } def
	}
	ifelse
%	if landscape
	{
%
%		Note: x and y are reversed
%
		/w Y y sub def	% Width of imageable region
		/h X x sub def	% Height of imageable region
		/ox y def	% origin of physical page
		/oy x def
		/L		% Map to landscape
			-90 matrix rotate
			0 H matrix translate
			matrix concatmatrix
		def
	}
	{
		/w X x sub def
		/h Y y sub def
		/ox x def
		/oy y def
		/L matrix def
	}
	ifelse
%
%	Calculate origin fudge so that scaled margin = fudge
%	This means that the clippath of the logical page
%	will align with the physical clippath.
%	(wf/W)x = xf where,
%			wf = new width = w + 2xf, 
%			x = margin xf = scaled margin
%	so xf = wx/(COLS.W-2x)

	/xf w x mul W cols mul 2 x mul sub div def
	/yf h y mul H rows mul 2 y mul sub div def
	/w w 2 xf mul add def
	/h h 2 yf mul add def

%
%	CTM (multi) = C x T x M x L x I
%	CTM (normal) = C x I
%	CTM (normal) = CTM (multi) x (T x M x L x I)-1 x I
%	M = (Scale rows/cols) x (Scale logical to physical) x
%		(Translate to physical clip origin + fudge)
%	T = (Convert logical page to spot and physical)
%	L = (Convert to landscape)
%	I = Initial Physical CTM
%	C = Random transform on logical page

	/M
			w W div cols div
			h H div rows div
		matrix scale
		ox xf sub oy yf sub matrix translate	% Move to origin
		matrix concatmatrix
	def
	/I
		matrix currentmatrix
	def
	/I_inv
		I matrix invertmatrix
	def

%	matrix T <current T>
	/T
	{
		page# tocol
		left_right not
		{
			cols 1 sub exch sub
		}
		if
		W mul
		page# torow
		up_down
		{
			rows 1 sub exch sub
		}
		if
		H mul
		3 -1 roll translate
	}
	def

%
%	Utility functions
%	NB: *_t1 are temporary variables
%

%	matrix fromcanon <I-1 x T x M x L x I>
	/From_t1 matrix def
	/From_t2 matrix def
	/From_t3 matrix def
	/From_t4 matrix def
	/fromcanon
	{
		I_inv
		From_t1 T
		M
		L
		I
		From_t2 concatmatrix	
		From_t3 concatmatrix
		From_t4 concatmatrix
		3 -1 roll concatmatrix
	}
	def

%	/n {} mkmulti -
%	makes a new function called "n" in previous dict with:-
%		{}[0] = /n
%		{}[1] = currentdict
%		currentdict.n = prevdict.n
%
	/mkmulti
	{
		1 index dup load def	%define old val in current dict
		5 array cvx
		dup 3 4 -1 roll put	% A[3] = {}
		dup 0 3 index put	% A[0] = /n
		dup 1 currentdict put	% A[1] = currentdict
		dup 2 /begin cvx put	% A[2] = begin
		dup 4 /exec cvx put	% A[4] = exec
		initdict 3 1 roll
		put			% define initdict.n to multi function
	}
	def

%
%	path_to_proc {}
%		make proc represenation of current path
%
	/path_to_proc
	{
		{
			[
				/newpath cvx
				{ /moveto cvx}
				{ /lineto cvx}
				{ /curveto  cvx}
				{ /closepath cvx }
				pathforall
			]
			cvx
			exch pop
		}
		stopped
		{
			$error /errorname get /invalidaccess eq
			{
				cleartomark
				$error /newerror false put
				(%%Warning%% charpath in path - path nulled) =
				cvx exec
			}
			{
				stop
			}
			ifelse
		}
		if
	}
	def
	/path_def
	{
		{ currentpoint } stopped
		{
			$error /newerror false put
			{ newpath }
		}
		{
			/newpath cvx 3 1 roll /moveto cvx 4 array astore cvx
		}
		ifelse
	}
	cvlit def

%
%	Draw lines round logical pages
%
	/draw_dividers
	{
		initgraphics
		L concat
		M concat
		1 1 cols 1 sub
		{
			W mul
			dup
			0 moveto
			rows H mul lineto
		}
		for
		1 1 rows 1 sub
		{
			H mul
			dup
			0 exch moveto
			cols W mul exch lineto
		}
		for
		stroke
	}
	def

%
%	for each graphics operator which affects absolute state
%
	/M1 matrix def
	/M3 matrix def
	/M2 matrix def
	[
		/gsave
		/grestore
		/grestoreall
		/initgraphics
		/initmatrix
		/currentmatrix
		/setmatrix
		% Path construction operators
		/initclip
		% Virtual memory operators
		/save
	]
	{
		{
%			Save paths
			path_def path_to_proc
			clippath  { {} } path_to_proc

%
%			CTM <- CTM x Tocano (canon mode)
%
			M1 currentmatrix
			Tocanon
			M2
			concatmatrix
			setmatrix

%			Restore paths
			initclip exec clip
			exec

			load exec

%			Save paths
			path_def path_to_proc
			clippath  { {} } path_to_proc

%
%			CTM <- CTM x Fromcanon (Non canon mode)
%
			M1 currentmatrix
			Fromcanon
			M2
			concatmatrix
			setmatrix

%			Restore paths
			initclip exec clip
			exec
			end
		}
		mkmulti
	}
	forall

%
%	Define the operators which can't use the standard template
%
	/showpage
	{
		/page# page# 1 add def

%		Update the transform matrices
		page# npages eq
		{
			dividers
			{
				draw_dividers
			}
			if
			load exec	% the previous showpage
			/page# 0 def
		}
		{
			pop
		}
		ifelse
		/Fromcanon Fromcanon fromcanon def
		/Tocanon Fromcanon Tocanon invertmatrix def
		end
		initgraphics	% the new initgraphics
	}
	mkmulti

	/copypage
	{
		pop
		end
		gsave
		showpage
		grestore
	}
	mkmulti

	/erasepage
	{
		pop
		end
		gsave
		initclip
		clippath
		1 setgray fill
		grestore
	}
	mkmulti
	[
		/letter
		/legal
		/a4
		/b5
		/lettersmall
		/note
	]
	{
		{
			pop end
			(%%Warning%% Device change ignored) =
		}
		mkmulti
	}
	forall

%
%	Define restore separately as it affects the value of page#, etc
%
	/restore
	{
		pop
%		Push the values to restore after restore
		mark exch 	% put mark under -save-
		page#
		Fromcanon aload pop
		Tocanon aload pop

		counttomark -1 roll	% get -save- to the top
		restore

%		Restore popped values
		Tocanon astore pop
		Fromcanon astore pop
		/page# exch def
		pop	% mark

%		Save paths
		path_def path_to_proc
		clippath  { { } } path_to_proc

%
%		CTM <- CTM x Fromcanon (Non canon mode)
%
		M1 currentmatrix
		Fromcanon
		M2
		concatmatrix
		setmatrix

%		Restore paths
		initclip exec clip
		exec
		end
	}
	mkmulti
%
%	procedure to undo the effect of multi
%
	/endmulti
	{
		pop	% don't need /endmulti
		[
			/gsave
			/grestore
			/grestoreall
			/initgraphics
			/initmatrix
			/currentmatrix
			/setmatrix
			% Path construction operators
			/initclip
			% Virtual memory operators
			/save
			% ones which needed special overloading
			/showpage
			/erasepage
			/copypage
			/restore
			% ignore these
			/letter
			/legal
			/a4
			/b5
			/lettersmall
			/note
			%
			/endmulti
		]
		{
			initdict exch
			dup load 		% get old value
			put			% restore old value
		}
		forall
		page# 0 ne	% if not at new page show uncomplete page
		{
			dividers
			{
				draw_dividers
			}
			if
			showpage
		}
		if
		end
	}
	mkmulti

%
%	Set up in multi(non canon) mode
%
	/page# 0 def
	/npages rows cols mul def
	/Fromcanon matrix fromcanon def
	/Tocanon Fromcanon matrix invertmatrix def
	end
	initgraphics
}
bind
def
%%%%%%%%
/end-hook { endmulti } def

true 1 2 multi
