function matlab2pgfplots(varargin )
% matlab2pgfplots(outfile )
% matlab2pgfplots( outfile, OPTIONS )
%
% Generate LaTeX code for use in package pgfplots to
% draw line plots.
%
% It will use every (2d) line plot in the figure specified by handler fighandle.
% 
% It understands
% - axis labels,
% - legends,
% - any 2d line plots,
% - line styles/markers (in case of styles=1),
% - tick positions, labels and axis limits (in case of axes=1).
%
% Linestyles and markers will follow as an option. However, pgfplots has its
% own line styles which may be appropriate.
%
% Although pgfplots can also handle bar and area plots, this script is not yet
% capable of converting them. Feel free to modify it and send the final version
% to me!
%
% OPTIONS are key value pairs. Known options are
% - 'fig',HANDLE
%		a figure handle (default is 'gcf').
% - 'styles',0|1
% 		a boolean indicating whether line styles, markers and colors shall be exported (default 1).
% - 'axes',0|1
% 		a boolean indicating whether axis ticks, tick labels and limits shall be exported (default 0).
% - 'maxpoints',100000
%       an integer denoting the maximum number of points exported to tex. If the actual number is larger,
%       the data will be interpolated to 'maxpoints'. The interpolation assumes
%       parametric plots if x and y are not monotonically increasing.
% 
% See
%   http://tug.ctan.org/tex-archive/graphics/pgf/contrib/pgfplots/
% for details about pgfplots.
%
%
%
% Copyright Christian Feuersaenger 2008
%
% This script requires Matlab version 7.4 (or above).
parser = inputParser;

parser.addRequired( 'outfile', @(x) ischar(x) );
parser.addParamValue( 'fig', gcf, @(x) ishandle(x) );
parser.addParamValue( 'styles', 1, @(x) x==0 || x==1 );
parser.addParamValue( 'axes' , 0, @(x) x==0 || x==1 );
parser.addParamValue( 'maxpoints', 100000, @(x) isnumeric(x) );

parser.parse( varargin{:} );


fighandle = parser.Results.fig;

lineobjs = findobj(fighandle, 'Type', 'line' );
axesobj = findobj( fighandle, 'Type', 'axes' );

% As far as I know, 'scatter' and 'scatter3' produce groups of this class:
scatterobjs = findobj(fighandle, 'Type', 'hggroup' );
lineobjs = [ lineobjs scatterobjs ];

legendobj = findobj( fighandle, 'tag', 'legend' );
if length(legendobj) > 0 
	allchildsoflegend = [ findobj( legendobj ) ];
	lineobjs = setdiff( lineobjs, allchildsoflegend );
	axesobj = setdiff( axesobj, allchildsoflegend );
end

FID=fopen( parser.Results.outfile, 'w' );
assert( FID >= 0, [ 'could not open file ' parser.Results.outfile ' for writing' ] );

ENDL=sprintf('\n');
TAB=sprintf('\t');
fwrite( FID, [ ...
	'\begin{tikzpicture}%' ENDL ...
	'\begin{axis}'] );

xislog = 0;
yislog = 0;

if length(axesobj) > 0
	axis = axesobj(1);
	xlabel = get( get(axis, 'XLabel'), 'String');
	ylabel = get( get(axis, 'YLabel'), 'String');
	zlabel = get( get(axis, 'ZLabel'), 'String');
	xscale = get(axis,'XScale');
	yscale = get(axis,'YScale');

	axisoptions = {};
	if length(xlabel) > 0
		axisoptions = [ axisoptions [ 'xlabel={' xlabel '}'] ];
	end
	if length(ylabel) > 0
		axisoptions = [ axisoptions ['ylabel={' ylabel '}'] ];
	end
	if strcmp(xscale,'log')
		xislog=1;
		axisoptions = [ axisoptions ['xmode=log'] ];
	end
	if strcmp(yscale,'log')
		yislog = 1;
		axisoptions = [ axisoptions ['ymode=log'] ];
	end
	if parser.Results.axes
		for k = 'xy'
			L = get(gca, [ k 'Lim'] );
			axisoptions = [ axisoptions [ k 'min=' num2str(L(1)) ] ];
			axisoptions = [ axisoptions [ k 'max=' num2str(L(2)) ] ];
		end

		for k = 'xy'
			L = get(gca, [ k 'Tick'] );
			opt = [ k 'tick={' ];
			for q=1:length(L)
				if q>1
					opt = [opt ',' ];
				end
				opt = [opt num2str(L(q)) ];
			end
			opt = [ opt '}' ];
			axisoptions = [axisoptions opt ];
		end

	end


	axisoptstr = [];
	for i = 1:length(axisoptions)
		if i>1
			axisoptstr = [axisoptstr ',' ENDL TAB];
		end
		axisoptstr = [axisoptstr axisoptions{i}];
	end
	if length( axisoptstr ) 
		fwrite( FID, [ '[' ENDL TAB axisoptstr ']' ENDL ] );
	end
end
fwrite( FID, ENDL );

if length(legendobj) > 0 
	legentries = get(legendobj, 'String');
	if length(legentries) > 0
		legstr = ['\legend{%' ENDL TAB ];
		for i = 1:length(legentries)
			legstr = [ legstr legentries{i} '\\%' ENDL ];
			if i ~= length(legentries)
				legstr = [ legstr TAB ];
			end
		end
		legstr = [ legstr '}%' ENDL ];
		fwrite( FID, legstr );
	end
end

xpointformat = '%f';
ypointformat = '%f';
if xislog
	xpointformat = '%e';
end
if yislog
	ypointformat = '%e';
end

for i = 1:length(lineobjs)
	
	x = get(lineobjs(i), 'XData');
	y = get(lineobjs(i), 'YData');
	z = get(lineobjs(i), 'ZData');

	if size(x,1) > 1
		disp( ['line element ' num2str(i) ' skipped: size ' num2str(size(x)) ' not supported']);
	end
	if abs(max(z) > 0)
		disp( ['line element ' num2str(i) ' skipped: only 2d-plots supported up to now']);
	end

	if size(x,2) > parser.Results.maxpoints
		% we need to re-interpolate the data!
		q = find( diff(x) < 0 );
		if length(q) 
			% parametric plot  x(t), y(t), z(t). 
			% we assume t = 1:size(x,2)
			X = 1:parser.Results.maxpoints;
			x = interp1( 1:size(x,2),x,  X);
			y = interp1( 1:size(y,2),y,  X);
			z = interp1( 1:size(z,2),z,  X);

		else
			% a normal plot y(x):
			X = linspace( min(x), max(x), parser.Results.maxpoints );
			y = interp1( x,y, X );
			x = X;
		end
	end

	coordstr = [];
	for j = 1:size(x,2)
		coordstr = [coordstr  sprintf(['\t(' xpointformat ',\t' ypointformat ')\n'], x(j), y(j)) ];
	end

	addplotoptstr = [];
	if parser.Results.styles
		markOpts = {};
		mark = [];
		linestyle = [];
		color = [];

		C = matlabColorToPGFColor( get(lineobjs(i), 'Color') );
		if length(C)
			color = [ 'color=' C ];
		end

		L = get(lineobjs(i), 'LineStyle' );
		switch L
		case 'none'
			linestyle = 'only marks';
		case '-'
			linestyle = [];
		case ':'
			linestyle = 'densely dotted';
		case '-:'
			linestyle = 'dash pattern={on 2pt off 3pt on 1pt off 3pt}';
		case '--'
			linestyle = 'densely dashed';
		end

		M = get(lineobjs(i), 'Marker');
		switch M
		case '.'
			mark = '*';
			markOpts = [ markOpts 'scale=0.1' ];
		case 'o'
			mark = '*';
		case 'x'
			mark = 'x';
		case '+'
			mark = '+';
		case '*'
			mark = 'asterisk';
		case 'square'
			mark = 'square*';
		case 'diamond'
			mark = 'diamond*';
		case '^'
			mark = 'triangle*';
		case 'v'
			mark = 'triangle*';
			markOpts = [ markOpts 'rotate=180' ];
		case '<'
			mark = 'triangle*';
			markOpts = [ markOpts 'rotate=90' ];
		case '>'
			mark = 'triangle*';
			markOpts = [ markOpts 'rotate=270' ];
		case 'pentagramm'
			mark = 'pentagon*';
		case 'hexagram'
			mark = 'oplus*';
		end

		M = matlabColorToPGFColor( get(lineobjs(i), 'MarkerFaceColor') );
		if length(M)
			markOpts = [ markOpts ['fill=' M] ];
		end

		M = matlabColorToPGFColor( get(lineobjs(i), 'MarkerEdgeColor') );
		if length(M)
			markOpts = [ markOpts ['draw=' M] ];
		end

		if length(color)
			if length(addplotoptstr)
				addplotoptstr = [addplotoptstr ',' ];
			end
			addplotoptstr = [ addplotoptstr color ];
		end

		if length(linestyle)
			if length(addplotoptstr)
				addplotoptstr = [addplotoptstr ',' ];
			end
			addplotoptstr = [ addplotoptstr linestyle ];
		end

		if length(mark)
			if length(addplotoptstr)
				addplotoptstr = [addplotoptstr ',' ];
			end
			addplotoptstr = [ addplotoptstr [ 'mark=' mark ] ];

			if length(markOpts)
				markOptsStr = 'mark options={';
				for q = 1:length(markOpts)
					if q > 1
						markOptsStr = [markOptsStr ',' ];
					end
					markOptsStr = [ markOptsStr markOpts{q} ];
				end
				markOptsStr = [ markOptsStr '}' ];

				addplotoptstr = [ addplotoptstr ',' markOptsStr ];
			end
		end
		

		if length(addplotoptstr)
			addplotoptstr = [ '[' addplotoptstr ']' ];
		end

	end
	fwrite( FID, [ ...
		'\addplot' addplotoptstr ' plot coordinates {' ENDL coordstr '};' ENDL ] );

end


fwrite( FID, [ ...
	'\end{axis}' ENDL ...
	'\end{tikzpicture}%' ENDL ] );
fclose(FID);

end

function cstr = matlabColorToPGFColor( C )

if length(C) ~= 3 | ischar(C) & strcmp(C,'none'),				cstr = [];
elseif norm( C - [0   0   1 ], 'inf' ) < 1e-10,		cstr = 'blue';
elseif norm( C - [0   1   0 ], 'inf' ) < 1e-10,	  cstr = 'green';  
elseif norm( C - [1   0   0 ], 'inf' ) < 1e-10,	  cstr = 'red';    
elseif norm( C - [0   1   1 ], 'inf' ) < 1e-10,	  cstr = 'cyan';   
elseif norm( C - [1   0   1 ], 'inf' ) < 1e-10,	  cstr = 'magenta';
elseif norm( C - [1   1   0 ], 'inf' ) < 1e-10,	  cstr = 'yellow'; 
elseif norm( C - [0   0   0 ], 'inf' ) < 1e-10,	  cstr = 'black';  
elseif norm( C - [1   1   1 ], 'inf' ) < 1e-10,	  cstr = 'white';  
else
	cstr= 'blue'; % FIXME
% cstr = [ '{rgb:red,' num2str( floor( C(1)*100) ) ';green,' num2str(floor(C(2)*100)) ';blue,' num2str(floor(C(3)*100)) '}' ];
end

end
