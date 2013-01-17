-- to do: clean up dtx file of remnants of classical sseq code
-- to do: documentation

function sseq_init()
--	sseqobject is a 2D-array containing arrays of all the nodes that are dropped at (x,y)
--	Thus the first object dropped at (2,3) is sseqobject[2][3][1].
--	The object itself is a dictionary, containing:
--		name		a given name
--		code		the TeX code (in math mode) to typeset
--		extends		if it's an extension, then what it extends
--		color		the color
--		nodetype	the pgf node type (circle etc)
--		cmd			pgf code for drawing it -- with one %s for the color
--		posx,posy	the absolute position on the picture (in sp) -- determined at the end
	sseqobject = {}
--	sseqname is a dictionary containing all the given names of dropped objects
--	Its value is a dictionary, containing
--		x, y, n	the triple index in the sseqobject array
	sseqname = {}
--	sseqlabel is an array of labels of sseqobjects
--	Its values are dictionaries, containing
--		x,y,n		the triple the label belongs to
--		pos			one of L,LU,U,RU,R,RD,D,LD
--		code		the TeX code (in math mode) to typeset
--		color		the color
	sseqlabel = {}
--	sseqconnection is an array containing all connection (lines)
--	the connection itself is a dictionary, containing:
--		from		an array (x,y,n)	if n=0 then source void
--		to			an array (x,y,n)	if n=0 then target void
--		color		the color
--		curving		a number denoting the curving factor
--		dashing		the pgf dashing code
--		arrowfrom	the arrowstyle at from (or nil)
--		arrowto		the arrowstyle at to (or nil)
	sseqconnection = {}
--
-- 	Initialize some global variables
--
	sseqcurrentindex = nil
	sseqpreviousindex = nil
	sseqopenconnection = nil

	sseqxstart = 0	-- minimal x
	sseqystart = 0 	-- minimal y
	
	sseqgriddrawer = sseq_grid_crossword
	sseqgridstrokethickness = 6554 -- 0.1pt in sp
	
	sseqxlabels = sseq_parse_label_list("&n")
	sseqylabels = sseq_parse_label_list("&n")
	
	sseqprefix = {}
	sseqposx, sseqposy = 0,0
	sseqcurrabsx, sseqcurrabsy = 0,0
	sseq_set_defaults()
end

function sseq_set_defaults()
	sseqentrysize	= 745860 -- 0.4 cm in scaled points
	sseqxgap		= 559409 -- 0.3 cm in scaled points
	sseqygap		= 559409
	sseqxstep		= 2 -- every other label is drawn
	sseqystep		= 2
	sseqdefaultarrowstyle = "to"
	ssequsescolor	= true
	sseqpacking = sseq_pack_auto
end


--	parselabelrange:	input = a string of the form a...b,c...d, etc.
--								defstart: the default start index
--						return = an array of dictionaries
--						min	a number
--						max	a number
function parselabelrange(s,defstart)
	local res = {}
	local mini,maxi,found
	for rng in string.gfind(s.."," , "([^,]+)") do
		found,_,mini,maxi = string.find(rng,"([+-]?[0-9]+)%.%.%.([+-]?[0-9]+)")
		if not found then
			mini = defstart
			maxi = tonumber(rng)
			if not maxi then error("invalid range : "..rng) end
			maxi = maxi+defstart-1
		else
			mini = tonumber(mini)
			maxi = tonumber(maxi)
		end
		table.insert(res,{min = mini, max = maxi})
	end
	return res
end	

function sseq_setup_ranges(xr,yr,defxstart,defystart)
	sseqxrange = parselabelrange(xr,defxstart)
	sseqyrange = parselabelrange(yr,defystart)
end

function sseq_get_rangepart(range,x,gap)
	local pos = 0
	for j,rng in ipairs(range) do
		if x >= rng.min and x <= rng.max then
			return pos,pos+(rng.max+1-rng.min)*sseqentrysize
		else
			pos = pos+(rng.max+1-rng.min)*sseqentrysize+gap
		end
	end
end
		
function sseq_getabsoluteposition(range,x,gap)
	local pos = 0
	for j,rng in ipairs(range) do
		if x >= rng.min and x <= rng.max then
		  return pos+sseqentrysize*(x-rng.min),false
		end
		pos = pos+(rng.max+1-rng.min)*sseqentrysize+gap
	end
end

function sseq_getcoords(x,y)
	local xpos,xout,ypos,yout
	xpos = sseq_getabsoluteposition(sseqxrange,x,sseqxgap)
	ypos = sseq_getabsoluteposition(sseqyrange,y,sseqygap)
	return xpos, ypos
end

function sseq_grid_none()
end

function sseq_grid_crossword(x,y,width,height)
	tex.print("\\pgfsetlinewidth{"..sseqgridstrokethickness.."sp}")
	tex.print("\\pgfpathgrid[stepx="..sseqentrysize.."sp,stepy="..sseqentrysize.."sp]{\\pgfpointorigin}{\\pgfpoint{"..width*sseqentrysize.."sp}{"..height*sseqentrysize.."sp}}")
	tex.print("\\pgfusepath{stroke}")
end

function sseq_grid_go(x,y,width,heigh)
	tex.print("\\pgfsetlinewidth{"..sseqgridstrokethickness.."sp}")
	tex.print("\\pgftransformxshift{"..(sseqentrysize/2).."sp}")
	tex.print("\\pgftransformyshift{"..(sseqentrysize/2).."sp}")
	tex.print("\\pgfpathgrid[stepx="..sseqentrysize.."sp,stepy="..sseqentrysize.."sp]{\\pgfpoint{"..(-sseqentrysize/2).."sp}{"..(-sseqentrysize/2).."sp}}{\\pgfpoint{"..(width*sseqentrysize-sseqentrysize/2).."sp}{"..(height*sseqentrysize-sseqentrysize/2).."sp}}")
	tex.print("\\pgfusepath{stroke}")
end

function sseq_grid_dots(x,y,width,height)
	tex.print("\\pgfsetlinewidth{1pt}")
	tex.print("\\pgfsetdash{{1pt}{"..(sseqentrysize-65536).."sp}}{"..(sseqentrysize/2+32768).."sp}")
	tex.print("\\pgftransformxshift{"..(sseqentrysize/2).."sp}")
	tex.print("\\pgftransformyshift{"..(sseqentrysize/2).."sp}")
	tex.print("\\pgfpathgrid[stepx="..sseqentrysize.."sp,stepy="..sseqentrysize.."sp]{\\pgfpoint{"..(-sseqentrysize/2).."sp}{"..(-sseqentrysize/2).."sp}}{\\pgfpoint{"..(width*sseqentrysize-sseqentrysize/2).."sp}{"..(height*sseqentrysize-sseqentrysize/2).."sp}}")
	tex.print("\\pgfusepath{stroke}")
end

function sseq_grid_chess(x,y,width,height)
	tex.print("\\pgfsetcolor{sslightgr}")
	if math.mod(x+y, 2) == 1 then	-- invert everything by first drawing a solid gray rectangle
									-- and then draw the grid in white. This way, even bidegree
									-- is always white.
	tex.print("\\pgfpathrectangle{\\pgfpoint{0sp}{0sp}}{\\pgfpoint{"
				..(width*sseqentrysize).."sp}{"..(height*sseqentrysize).."sp}}")
		tex.print("\\pgfusepath{fill}")
		tex.print("\\pgfsetcolor{white}")
	end

	tex.print("\\pgfsetlinewidth{"..sseqentrysize.."sp}")
	
	tex.print("\\pgfsetdash{{"..sseqentrysize.."sp}{"..sseqentrysize.."sp}}{"..sseqentrysize.."sp}")
	

	tex.print("\\pgftransformxshift{"..(sseqentrysize/2).."sp}")
	tex.print("\\pgftransformyshift{"..(sseqentrysize/2).."sp}")
	tex.print("\\pgfpathgrid[stepx="..(sseqentrysize*2).."sp,stepy="..(sseqentrysize*2).."sp]{\\pgfpoint{"..(-sseqentrysize/2).."sp}{"..(-sseqentrysize/2).."sp}}{\\pgfpoint{"..(width*sseqentrysize-sseqentrysize/2).."sp}{"..(height*sseqentrysize-sseqentrysize/2).."sp}}")
	tex.print("\\pgfusepath{stroke}")
end

function sseq_drawgrid()	-- draws the background grid. This seems like pgf patterns are made
							-- for this purpose, but you can't specify a phase for patterns,
							-- so they are useless except for ornamental purposes.
	local xmin,ymin,width,heigt
	for x,xrng in ipairs(sseqxrange) do
		for y,yrng in ipairs(sseqyrange) do
			xmin, ymin = sseq_getcoords(xrng.min,yrng.min)
			tex.print("\\begin{pgfscope}")
			tex.print("\\pgftransformshift{\\pgfpoint{"..xmin.."sp}{"..ymin.."sp}}")
			width = (xrng.max+1)-xrng.min
			height = (yrng.max+1)-yrng.min
			sseqgriddrawer(xrng.min,yrng.min,width,height)
			tex.print("\\end{pgfscope}")
		end
	end
end

-- A label list has the form x1;x2;...;xn,y1;y2;...;yn,... where x1 etc are labels
-- A label may contain the placeholders:	
--		&n	=	actual coordinate
--		&c	=	number of chunk (begin with 0)
--		&i	=	index within the chunk (begin with 0)

function sseq_parse_label_list(s)
	local res = {}
	local chunk = 0
	local index
	
	for rng in string.gfind(s.."," , "([^,]*),") do
		res[chunk] = {}
		index = 0
		for label in string.gfind(rng..";", "([^;]*);") do
			res[chunk][index] = label
			index = index+1
		end
		chunk = chunk+1
	end
	return res  
end

function sseq_format_label(label, n,c,i)
	local res
	res = string.gsub(label,"&n",n)
	res = string.gsub(res,"&c",c)
	res = string.gsub(res,"&i",i)
	res = string.gsub(res,"&&","&")
	return res
end

function sseq_label_fromlist(n,c,i,list)
-- will return list[c][i] unless this is out of range, then take the last one given
	local chunks = #list
	local chunklen
	local chunk
	if list[0] then chunks = chunks+1 else return "" end
	chunk = list[math.min(chunks-1,c)]
	chunklen = #chunk
	if chunk[0] then chunklen = chunklen+1 end
	return sseq_format_label(chunk[math.min(chunklen-1,i)],n,c,i)
end


function sseq_draw_horizontal_labels(range)
	local k
	
	if sseqxtep == 0 then return end -- old-fashioned way of disabling labels
	for c,rng in ipairs(range) do
		k=0
		for i=rng.min,rng.max,sseqxstep do
			x = sseq_getcoords(i,0)
			label = sseq_label_fromlist(i,c-1,k,sseqxlabels)
			-- bug fix with bounding box sizes in pgf
--			tex.print("\\sbox\\sseq@labelbox{\\strut\\ensuremath{"..label.."}}")
--			tex.print("\\dimen0=\\ht\\sseq@labelbox")
--			tex.print("\\advance\\dimen0 by \\dp\\sseq@labelbox")
--			tex.print("\\pgf@protocolsizes{0pt}{-\\dimen0}")
			tex.print("\\pgftext[top,at=\\pgfpoint{"..(x+sseqentrysize/2).."sp}{0sp}]{\\ensuremath{\\strut "..label.."}}")
			k=k+sseqxstep
		end
	end
end

function sseq_draw_vertical_labels(range)
	local k
	
	if sseqystep == 0 then return end -- old-fashioned way of disabling labels
	for c,rng in ipairs(range) do
		k=0
		for i=rng.min,rng.max,sseqystep do
			_,y = sseq_getcoords(0,i)
			label = sseq_label_fromlist(i,c,k,sseqylabels)
			tex.print("\\pgftext[right,at=\\pgfpoint{-2pt}{"..(y+sseqentrysize/2).."sp}]{\\ensuremath{"..label.."}}")
			k=k+sseqystep
		end
	end
end


function sseq_drawlabels()
	sseq_draw_horizontal_labels(sseqxrange)
	sseq_draw_vertical_labels(sseqyrange)
end

function sseq_getdroplist(x,y)
	return sseqobject[x] and sseqobject[x][y]
end

function sseq_openposition()
	local l = sseq_getdroplist(sseqposx,sseqposy)
	if not l then
		error(string.format("sseq: cannot open position (%d,%d): nothing dropped yet",sseqposx,sseqposy))
	elseif #l ~= 1 then
	  	error(string.format("sseq: cannot open position (%d,%d): multiple drops",sseqposx,sseqposy))
	else
	  sseqcurrentindex = {sseqposx,sseqposy,1}
	end
end

function sseq_assert_source()
	sseq_flush_connection()
	if not sseqcurrentindex then
		sseq_openposition()
	end
end

function sseq_finish_pos()
	sseq_flush_connection()
	if sseqcurrentindex then
		sseq_conclude_connection()
		sseqpreviousindex, sseqcurrentindex = sseqcurrentindex,nil
	end
end

function sseq_drop_and_open(x,y)
	if not sseqobject[x] then sseqobject[x] = {} end
	if not sseqobject[x][y] then sseqobject[x][y] = {} end
	table.insert(sseqobject[x][y],{})
	sseqcurrentindex = {x,y,#sseqobject[x][y]}
end

function sseq_drop_object(x,y,shape,pathusage,content,col)
	local obj
	sseq_finish_pos()
	sseq_drop_and_open(x,y)
	obj = sseqobject[x][y][sseqcurrentindex[3]]
	obj.code = content
	obj.color = col
	obj.nodetype = shape
	
	sseq_conclude_connection()
	-- now do the optimizations such as \bullet -> drawn black circle etc
	if (pathusage == "fill") or (obj.code == "\\bullet ") then
		if (obj.nodetype == "circle") or (obj.code == "\\bullet ") then
			obj.nodetype = "circle"
			obj.cmd = "\\pgfsetfillcolor{%s}\\pgfpathqcircle{2pt}\\pgfusepathqfill"
			obj.radius = 131072 -- 2pt in sp
			obj.wd,obj.ht = 262144,262144 -- 4pt in sp
		else
			obj.cmd = "\\pgfsetfillcolor{%s}\\pgfsys@rect{-2pt}{-2pt}{4pt}{4pt}\\pgfsys@fill"
			obj.wd,obj.ht = 262144,262144
			obj.radius = 370727
		end
	elseif(obj.code == "\\square ") then
		obj.nodetype="rectangle"
		obj.cmd = "\\pgfsetstrokecolor{%s}\\pgfsys@rect{-2pt}{-2pt}{4pt}{4pt}\\pgfsys@stroke"
		obj.wd,obj.ht = 262144,262144
		obj.radius = 370727
	else
		obj.cmd = "\\pgfsetstrokecolor{%s}\\pgfsetfillcolor{white}"..string.format("\\pgfnode{%s}{center}{\\color{%%s}\\ensuremath{%s}}{}{\\pgfusepath{fill,%s}}",obj.nodetype,obj.code,pathusage)
		tex.print (string.format("\\setbox%d=\\hbox{\\pgfinterruptpicture\\ensuremath{%s}\\endpgfinterruptpicture}",sseqboxno,obj.code))
		tex.print("\\directlua0{sseq_register_size()}")	
	end		
end

function sseq_drop_extension(shape,pathusage,col)
	local obj,refobj
	sseq_assert_source()
	table.insert(sseqobject[sseqposx][sseqposy],{})
	obj = sseqobject[sseqposx][sseqposy][#sseqobject[sseqposx][sseqposy]]
	obj.code = "" -- no TeX code to typeset
	obj.extends = sseqcurrentindex[3]
	obj.color = col
	obj.nodetype = shape
	refobj = sseqobject[sseqcurrentindex[1]][sseqcurrentindex[2]][sseqcurrentindex[3]]
	
	sseqcurrentindex[3] = #sseqobject[sseqposx][sseqposy]
	sseq_conclude_connection()
	
	if (shape=="circle") then
		obj.radius = refobj.radius+65536 -- add 1pt in sp
		obj.wd,obj.ht = 2*obj.radius,2*obj.radius
		obj.cmd = "\\pgfsetstrokecolor{%s}\\pgfpathqcircle{"..obj.radius.."sp}\\pgfusepath{stroke,"..pathusage.."}"
	else
		obj.wd,obj.ht = refobj.wd+131072,refobj.ht +131072 -- add 1 pt at each side
		obj.radius = 0.5*math.sqrt(obj.wd*obj.wd+obj.ht*obj.ht)
		obj.cmd = "\\pgfsetstrokecolor{%s}\\pgfsetshapeinnerxsep{"..(.5*obj.wd).."sp}\\pgfsetshapeinnerysep{"..(.5*obj.ht).."sp}\\pgfnode{rectangle}{center}{}{}{\\pgfusepath{stroke,"..pathusage.."}}"
	end
end
	
function sseq_register_size()
	local currobj = sseqobject[sseqcurrentindex[1]][sseqcurrentindex[2]][sseqcurrentindex[3]]
	currobj.wd = tex.wd[sseqboxno]
	currobj.ht = (tex.ht[sseqboxno]+tex.dp[sseqboxno])
	currobj.dp = tex.dp[sseqboxno]
	currobj.radius = 0.5*math.sqrt(currobj.wd*currobj.wd+currobj.ht*currobj.ht)
end

function sseq_drop_object_here(shape,pathusage,content,col)
	sseq_drop_object(sseqposx,sseqposy,shape,pathusage,content,col)
end

function sseq_bullstring(x,y,n,col)
	if n==0 then return end
	sseq_drop_object_here("circle","fill","\\bullet",col)
	for i=2,n do
		sseq_move(x,y)
		sseq_drop_object_here("circle","fill","\\bullet",col)
		sseq_late_connection("","",col,false,false)
	end
end

function sseq_moveto(x,y)
	sseq_conclude_connection()
	sseq_finish_pos()
	sseqposx = x
	sseqposy = y
end

function sseq_grayout(col)
	sseq_assert_source()
	sseqobject[sseqcurrentindex[1]][sseqcurrentindex[2]][sseqcurrentindex[3]].color = col
	for _,conn in pairs(sseqconnection) do
		if (conn.from[1] == sseqcurrentindex[1] and conn.from[2] == sseqcurrentindex[2] and conn.from[3] == sseqcurrentindex[3]) or (conn.to[1] == sseqcurrentindex[1] and conn.to[2] == sseqcurrentindex[2] and conn.to[3] == sseqcurrentindex[3]) then
			conn.color = col
		end
	end
end

function sseq_move(x,y)
	sseq_moveto(sseqposx+x,sseqposy+y)
end

function stringtolist(pref,name)
	local res = {}
	for i,p in ipairs(pref) do table.insert(res,p) end
	for w in string.gfind(name,"%w+") do
		table.insert(res,w)
	end
	table.sort(res)
	return res
end

function sseq_set_global_name(name)
	local namestring = table.concat(name)
	sseq_assert_source()
	if sseqname[namestring] then
		error("sseq: duplicate name "..namestring)
	else
		sseqname[namestring] = {sseqcurrentindex[1],sseqcurrentindex[2],sseqcurrentindex[3]}
	end
end

function sseq_global_name(name)
	return stringtolist(sseqprefix,name)
end

function sseq_name(name)
	sseq_set_global_name(sseq_global_name(name))
end

function sseq_global_goto(name)
	local namestring = table.concat(name)
	sseq_conclude_connection()
	sseq_finish_pos()
	if not sseqname[namestring] then
		error("sseq: goto name does not exist: "..namestring)
	else	
		sseqcurrentindex = { sseqname[namestring][1],sseqname[namestring][2],sseqname[namestring][3] }
		sseqposx,sseqposy = sseqname[namestring][1], sseqname[namestring][2]
	end
end

function sseq_abs_goto(name)
	sseq_global_goto(stringtolist({},name))
end

function sseq_prefix(pref)
	sseqprefix = stringtolist(sseqprefix,pref)
end

function sseq_reset_prefix()
	sseqprefix = {}
end

function sseq_goto(name)
	sseq_global_goto(sseq_global_name(name))
end

function sseq_flush_connection()
end

function sseq_conclude_connection()
	if not sseqopenconnection then return end
	if not sseqcurrentindex then
		sseq_openposition()
	end
	sseqopenconnection.to = { sseqcurrentindex[1],sseqcurrentindex[2],sseqcurrentindex[3] }
	table.insert(sseqconnection,sseqopenconnection)
	sseqopenconnection = nil
end

-- immediately register a connection between sseqpreviousindex and sseqcurrentindex
function sseq_late_connection(dash,bending,col,sourcevoid,targetvoid)
	local newconn
	
	sseq_flush_connection()	-- finish previous connection
	if not targetvoid then sseq_assert_source() end
	if (not sseqpreviousindex) or (not targetvoid and (sseqpreviousindex[3] == 0)) then
		error("sseq: connection without well-defined source")
	end
	newconn = { color = col, dashing = dash }
	if(bending ~= "") then newconn.curving = bending end
	if sourcevoid then
		newconn.from = {sseqpreviousindex[1],sseqpreviousindex[2],0}
	else
		newconn.from = {sseqpreviousindex[1],sseqpreviousindex[2],sseqpreviousindex[3]}
	end
	if targetvoid then
		newconn.to = {sseqposx,sseqposy,0}
	else
		newconn.to = {sseqcurrentindex[1],sseqcurrentindex[2],sseqcurrentindex[3]}
	end
	table.insert(sseqconnection,newconn)
end

function sseq_void_line(dash,bending,col,x,y)
	local newconn = { color = col, dashing = dash }
	
	if(bending ~= "") then newconn.curving = bending end
	sseq_assert_source();
	newconn.from = {sseqcurrentindex[1],sseqcurrentindex[2],sseqcurrentindex[3]}
	newconn.to = {sseqcurrentindex[1]+x,sseqcurrentindex[2]+y,0}
	table.insert(sseqconnection,newconn)
end

function sseq_open_connection(dash,bending,col,x,y)
	local newconn = { color = col, dashing = dash }
	
	if(bending ~= "") then newconn.curving = bending end
	sseq_assert_source(); sseq_finish_pos()
	newconn.from = {sseqpreviousindex[1],sseqpreviousindex[2],sseqpreviousindex[3]}
	sseqopenconnection = newconn
end

function sseq_add_arrow(fromto,type)
	if sseqopenconnection then
		sseqopenconnection[fromto] = type
	else
		sseqconnection[#sseqconnection][fromto] = type
	end
end

function sseq_drop_label(p,col,label)
	sseq_assert_source()
	table.insert(sseqlabel,{x = sseqcurrentindex[1], y = sseqcurrentindex[2], n = sseqcurrentindex[3],
							color = col, code = label, pos = p})
end


function sseq_pack_diagonal(i,n)
	return 	sseqentrysize/2+sseqentrysize*(n-i)/4,
			sseqentrysize/2-sseqentrysize*(n-i)/4
end

function sseq_pack_horizontal(i,n)
	return 	sseqentrysize/2+sseqentrysize*(i-1)/4,
			sseqentrysize/2
end
function sseq_pack_vertical(i,n)
	return 	sseqentrysize/2,
			sseqentrysize/2-sseqentrysize*(n-i)/4
end

sseqautopackdata = {	{{.5,.5}}, 	-- one
						{{.25,.75},{.75,.25}},	-- two
						{{.167,.833},{.5,.5},{.833,.167}},	-- three
						{{.167,.75},{.389,.25},{.611,.75},{.833,.25}}	-- four
					}
					
function sseq_pack_auto(i,n) -- return offset of the ith square out of n.
	if n > 4 then return sseq_pack_diagonal(i,n) end
	dat = sseqautopackdata[n][i]
	return dat[1]*sseqentrysize,dat[2]*sseqentrysize
	
end

function sseq_position_object_list(x,y,list)
	local absx,absy = sseq_getcoords(x,y) -- the lower left corner of the square
	local numobj = #list
	local j = 1
		
	if not absx or not absy then return end -- outside clipping area -- don't draw.
	
	for i,obj in ipairs(list) do
		if (obj.extends) then numobj = numobj-1 end
	end

	for i,obj in ipairs(list) do
		if (obj.extends) then
			obj.posx,obj.posy = list[obj.extends].posx,list[obj.extends].posy
		else
			obj.posx, obj.posy = sseqpacking(j,numobj)
			obj.posx = obj.posx + absx
			obj.posy = obj.posy + absy
			j = j+1
		end
		if not obj.color then obj.color = "black" end
	end
end

function sseq_position_objects()
	for x,ylist in pairs(sseqobject) do
		for y,olist in pairs(ylist) do
			sseq_position_object_list(x,y,olist)
		end
	end	
end

function sseq_dump_translation(x,y)
	tex.print("\\pgfsys@transformshift{"..(x-sseqcurrabsx).."sp}{"..(y-sseqcurrabsy).."sp}")
	sseqcurrabsx,sseqcurrabsy = x,y
end

function sseq_dump_object(x,y,obj)
	if not obj.posx or not obj.posy then return end
	sseq_dump_translation(obj.posx,obj.posy)
	tex.print(string.format(obj.cmd,obj.color,obj.color))
end

--
-- return the intersection of the vector to (fromx, fromy) with the boundary of obj
--
function sseq_correct_line_end(obj,fromx,fromy,curving)
	local distsq,posx,posy,deltax,deltay,dirx,diry
	posx,posy = obj.posx,obj.posy
	
	dirx = posx-fromx
	diry = posy-fromy
	
	if(curving) then
		dirx,diry = dirx/2-curving*diry,diry/2+curving*dirx
	end
	
	if obj.nodetype == "circle" then
		dist = math.sqrt(dirx*dirx + diry*diry)
		return posx - obj.radius*(dirx)/dist,
			   posy - obj.radius*(diry)/dist
	else
		deltax = dirx/diry*obj.ht/2 -- no problem with infinity in LUA
		deltay = diry/dirx*obj.wd/2
		if(math.abs(deltax) <= obj.wd/2) then -- boundary point on one of the horizontal lines
			if fromy > posy then
				return posx + deltax, posy + obj.ht/2
			else
				return posx - deltax, posy - obj.ht/2
			end
		else
			if fromx > posx then
				return posx + obj.wd/2, posy + deltay
			else
				return posx - obj.wd/2, posy - deltay
			end
		end
	end
end

--
-- return the intersection of the vector from (x,y) to the clipped object at
-- coordinate (clipi,clipj) with the boundary of the grid segment containing (i,j)
--
function sseq_fix_clipped_connection(clipi,clipj,i,j,x,y)
	local minx,maxx,miny,maxy,deltax,deltay
	
	minx,maxx = sseq_get_rangepart(sseqxrange,i,sseqxgap)
	miny,maxy = sseq_get_rangepart(sseqyrange,j,sseqygap)
	minx = minx - sseqxleak
	maxx = maxx + sseqxleak
	miny = miny - sseqyleak
	maxy = maxy + sseqyleak
	
	deltax = 1e10*(clipi-i)
	deltay = 1e10*(clipj-j)
	-- compute intersection of the vector (deltax, deltay) based at (x,y)
	-- with the rectangle minx,miny,maxx,maxy
	if(x+deltax > maxx) then deltax,deltay = maxx-x, deltay * (maxx-x)/deltax end
	if(x+deltax < minx) then deltax,deltay = minx-x, deltay*(minx-x)/deltax end
	if(y+deltay > maxy) then deltax,deltay = deltax * (maxy-y)/deltay, maxy-y end
	if(y+deltay < miny) then deltax,deltay = deltax * (miny-y)/deltay, miny-y end
	return x+deltax,y+deltay
end

function sseq_dump_connection(conn)
	local fromx, fromy, tox, toy, ctrlx,ctrly, helpx, helpy
	local fromobj,toobj
	
	-- possibilities:	* from, to not in the displayed range
	--					* from[3] = 0 or to[3] = 0 (void line)
	--					or any combination.
	
	-- if source or target is clipped, will make it a void line
	--
	fromx,fromy = sseq_getcoords(conn.from[1],conn.from[2])
	tox,toy = sseq_getcoords(conn.to[1],conn.to[2])

	if ((not fromx) or (not fromy) or (conn.from[3] == 0))
	and ((not tox) or (not toy) or (conn.to[3] == 0)) then
		--	 forget it -- source and target are clipped and/or void
		return
	end

	if ((not fromx) or (not fromy)) then -- source clipped: we can be sure the target is regular
		fromx,fromy = sseq_fix_clipped_connection(conn.from[1],conn.from[2],conn.to[1],conn.to[2],tox,toy)
		toobj = sseqobject[conn.to[1]][conn.to[2]][conn.to[3]]
		tox,toy = toobj.posx, toobj.posy		
	elseif ((not tox) or (not toy)) then -- target clipped: we can be sure the source is regular
		tox,toy = sseq_fix_clipped_connection(conn.to[1],conn.to[2],conn.from[1],conn.from[2],fromx,fromy)
		fromobj = sseqobject[conn.from[1]][conn.from[2]][conn.from[3]]
		fromx,fromy = fromobj.posx, fromobj.posy
	elseif conn.from[3] == 0 then -- source not clipped but void
		toobj = sseqobject[conn.to[1]][conn.to[2]][conn.to[3]]
		fromx = fromx+(toobj.posx-tox)
		fromy = fromy+(toobj.posy-toy)
		tox,toy = toobj.posx, toobj.posy
	elseif conn.to[3] == 0 then -- target not clipped but void
		fromobj = sseqobject[conn.from[1]][conn.from[2]][conn.from[3]]
		tox = tox+(fromobj.posx-fromx)
		toy = toy+(fromobj.posy-fromy)
		fromx,fromy = fromobj.posx, fromobj.posy
	else -- both source and target regular
		fromobj = sseqobject[conn.from[1]][conn.from[2]][conn.from[3]]
		fromx,fromy = fromobj.posx, fromobj.posy
		toobj = sseqobject[conn.to[1]][conn.to[2]][conn.to[3]]
		tox,toy = toobj.posx, toobj.posy
	end

	
	if fromobj then -- we have to be more careful where it ends
		fromx,fromy = sseq_correct_line_end(fromobj,tox,toy,conn.curving)
	end
	if toobj then
		tox,toy = sseq_correct_line_end(toobj,fromx,fromy,conn.curving and -conn.curving)
	end

	if conn.curving then
		ctrlx = tox/2+fromx/2-conn.curving*(toy-fromy)
		ctrly = toy/2+fromy/2+conn.curving*(tox-fromx)
	end
	
	if conn.arrowfrom or conn.arrowto or conn.curving then	-- got to use slow code
		tex.print("\\pgfsetdash{"..conn.dashing.."}{0pt}")
		tex.print("\\pgfsetstrokecolor{"..conn.color.."}")
		if (fromx and fromy) then
			if (tox and toy) then
				tex.print(string.format("\\pgfpathmoveto{\\pgfpoint{%dsp}{%dsp}}",fromx,fromy))
				if conn.curving then
					tex.print(string.format("\\pgfpathquadraticcurveto{\\pgfpoint{%dsp}{%dsp}}{\\pgfpoint{%dsp}{%dsp}}",ctrlx,ctrly,tox,toy))
				else
					tex.print(string.format("\\pgfpathlineto{\\pgfpoint{%dsp}{%dsp}}",tox,toy))
				end
				if conn.arrowfrom then tex.print("\\pgfsetarrowsstart{"..conn.arrowfrom.."}")end
				if conn.arrowto then tex.print("\\pgfsetarrowsend{"..conn.arrowto.."}") end		
				tex.print("\\pgfusepath{stroke}")
			end
		end
	else
		tex.print("\\pgfsetdash{"..conn.dashing.."}{0pt}")
		tex.print("\\pgfsetstrokecolor{"..conn.color.."}")
		if (fromx and fromy) then
			if (tox and toy) then
				tex.print(string.format("\\pgfsys@moveto{%dsp}{%dsp}",fromx,fromy))
				tex.print(string.format("\\pgfsys@lineto{%dsp}{%dsp}",tox,toy))
				tex.print("\\pgfsys@stroke")
			end
		end
	end
end

local labelpositioninrect = {	U = {0,.5,"bottom"},
								UL = {-.5,.5,"bottom,right"},
								LU = {-.5,.5,"bottom,right"},
								L = {-.5,0,"right"},
								DL = {-.5,-.5,"top,right"},
								LD = {-.5,-.5,"top,right"},
								D = {0,-.5,"top"},
								DR = {.5,-.5,"top,left"},
								RD = {.5,-.5,"top,left"},
								R = {.5,0,"left"},
								UR = {.5,.5,"bottom,left"},
								RU = {.5,.5,"bottom,left"}	}
local labelpositionincirc = {	U = {0,1,"bottom"},
								UL = {-.71,.71,"bottom,right"},
								LU = {-.71,.71,"bottom,right"},
								L = {-1,0,"right"},
								DL = {-.71,-.71,"top,right"},
								LD = {-.71,-.71,"top,right"},
								D = {0,-1,"top"},
								DR = {.71,-.71,"top,left"},
								RD = {.71,-.71,"top,left"},
								R = {1,0,"left"},
								UR = {.71,.71,"bottom,left"},
								RU = {.71,.71,"bottom,left"}	}
							
function sseq_dump_label(label)
	local labelledobj = sseqobject[label.x][label.y][label.n]
	local posx,posy
	tex.print("\\color{"..label.color.."}")
	if labelledobj.nodetype == "circle" then
		posx = labelledobj.posx+labelpositionincirc[label.pos][1]*labelledobj.radius
		posy = labelledobj.posy+labelpositionincirc[label.pos][2]*labelledobj.radius
		sseq_dump_translation(posx,posy)
		tex.print(string.format("\\pgftext[%s]{\\ensuremath{%s}}",labelpositioninrect[label.pos][3],label.code))
	else
		posx = labelledobj.posx+labelpositioninrect[label.pos][1]*labelledobj.wd
		posy = labelledobj.posy+labelpositioninrect[label.pos][2]*labelledobj.ht
		sseq_dump_translation(posx,posy)
		tex.print(string.format("\\pgftext[%s]{\\ensuremath{%s}}",labelpositioninrect[label.pos][3],label.code))
	end
end

-- Write out all the pgf code to produce the chart
function sseq_dump_code()
	if (not sseqxleak) then sseqxleak = 0.3*sseqxgap end
	if (not sseqyleak) then sseqyleak = 0.3*sseqygap end
	tex.print("\\makeatletter")
	tex.print("\\pgfset{inner sep=0pt}")
	-- connections
	for _,conn in pairs(sseqconnection) do
		sseq_dump_connection(conn)
	end
	-- objects
	tex.print("\\color{white}") -- background fill color
	for x,ylist in pairs(sseqobject) do
		for y,olist in pairs(ylist) do
			for z,obj in ipairs(olist) do
				sseq_dump_object(x,y,obj)
			end
		end
	end
	-- labels
	for _,label in pairs(sseqlabel) do
		sseq_dump_label(label)
	end
	tex.print("\\makeatother")
end

