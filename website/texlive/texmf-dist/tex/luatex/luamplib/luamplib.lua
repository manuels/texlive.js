-- 
--  This is file `luamplib.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luamplib.dtx  (with options: `lua')
--  
--  See source file 'luamplib.dtx' for licencing and contact information.
--  
module('luamplib', package.seeall)
local err, warn, info, log = luatexbase.provides_module({
    name          = "luamplib",
    version       =  1.09,
    date          = "2011/11/09",
    description   = "Lua package to typeset Metapost with LuaTeX's MPLib.",
})

local function term(...)
    texio.write_nl('term', 'luamplib: ' .. string.format(...))
end

local format, concat, abs = string.format, table.concat, math.abs

local data = ""

local function resetdata()
    data = ""
end
function addline(line)
    data = data .. '\n' .. line
end
function processlines()
    process(data)
    resetdata()
end

local mpkpse = kpse.new("luatex", "mpost")

local function finder(name, mode, ftype)
    if mode == "w" then
        return name
    else
        return mpkpse:find_file(name,ftype)
    end
end

local currentformat = "plain"

function setformat (name)
    currentformat = name
end

function load()
    local mpx = mplib.new {
        find_file   = finder,
        ini_version = true,
    }
    mpx:execute(format("input %s ;", currentformat))
    return mpx
end

function report(result)
    if not result then
        err("no result object")
    elseif result.status > 0 then
        local t, e, l, f = result.term, result.error, result.log
        if l then
            log(l)
        end
        if t then
            term(t)
        end
        if e then
            if result.status == 1 then
                warn(e)
            else
                err(e)
            end
        end
        if not t and not e and not l then
            if result.status == 1 then
                warn("unknown error, no error, terminal or log messages, maybe missing beginfig/endfig")
            else
                err("unknown error, no error, terminal or log messages, maybe missing beginfig/endfig")
            end
        end
    else
        return true
    end
    return false
end

function process(data)
    local converted, result = false, {}
    local mpx = load()
    if mpx and data then
        local result = mpx:execute(data)
        if report(result) then
            if result.fig then
                converted = convert(result)
            else
                warn("no figure output")
            end
        end
    else
        err("Mem file unloadable. Maybe generated with a different version of mplib?")
    end
    return converted, result
end

local function getobjects(result,figure,f)
    return figure:objects()
end

function convert(result, flusher)
    flush(result, flusher)
    return true -- done
end

local function pdf_startfigure(n,llx,lly,urx,ury)
    tex.sprint(format("\\mplibstarttoPDF{%s}{%s}{%s}{%s}",llx,lly,urx,ury))
end

local function pdf_stopfigure()
    tex.sprint("\\mplibstoptoPDF")
end

function pdf_literalcode(fmt,...) -- table
    tex.sprint(format("\\mplibtoPDF{%s}",format(fmt,...)))
end

function pdf_textfigure(font,size,text,width,height,depth)
    text = text:gsub(".","\\hbox{%1}") -- kerning happens in metapost
    tex.sprint(format("\\mplibtextext{%s}{%s}{%s}{%s}{%s}",font,size,text,0,-( 7200/ 7227)/65536*depth))
end

local bend_tolerance = 131/65536

local rx, sx, sy, ry, tx, ty, divider = 1, 0, 0, 1, 0, 0, 1

local function pen_characteristics(object)
    if mplib.pen_info then
        local t = mplib.pen_info(object)
        rx, ry, sx, sy, tx, ty = t.rx, t.ry, t.sx, t.sy, t.tx, t.ty
        divider = sx*sy - rx*ry
        return not (sx==1 and rx==0 and ry==0 and sy==1 and tx==0 and ty==0), t.width
    else
        rx, sx, sy, ry, tx, ty, divider = 1, 0, 0, 1, 0, 0, 1
        return false, 1
    end
end

local function concat(px, py) -- no tx, ty here
    return (sy*px-ry*py)/divider,(sx*py-rx*px)/divider
end

local function curved(ith,pth)
    local d = pth.left_x - ith.right_x
    if abs(ith.right_x - ith.x_coord - d) <= bend_tolerance and abs(pth.x_coord - pth.left_x - d) <= bend_tolerance then
        d = pth.left_y - ith.right_y
        if abs(ith.right_y - ith.y_coord - d) <= bend_tolerance and abs(pth.y_coord - pth.left_y - d) <= bend_tolerance then
            return false
        end
    end
    return true
end

local function flushnormalpath(path,open)
    local pth, ith
    for i=1,#path do
        pth = path[i]
        if not ith then
            pdf_literalcode("%f %f m",pth.x_coord,pth.y_coord)
        elseif curved(ith,pth) then
            pdf_literalcode("%f %f %f %f %f %f c",ith.right_x,ith.right_y,pth.left_x,pth.left_y,pth.x_coord,pth.y_coord)
        else
            pdf_literalcode("%f %f l",pth.x_coord,pth.y_coord)
        end
        ith = pth
    end
    if not open then
        local one = path[1]
        if curved(pth,one) then
            pdf_literalcode("%f %f %f %f %f %f c",pth.right_x,pth.right_y,one.left_x,one.left_y,one.x_coord,one.y_coord )
        else
            pdf_literalcode("%f %f l",one.x_coord,one.y_coord)
        end
    elseif #path == 1 then
        -- special case .. draw point
        local one = path[1]
        pdf_literalcode("%f %f l",one.x_coord,one.y_coord)
    end
    return t
end

local function flushconcatpath(path,open)
    pdf_literalcode("%f %f %f %f %f %f cm", sx, rx, ry, sy, tx ,ty)
    local pth, ith
    for i=1,#path do
        pth = path[i]
        if not ith then
           pdf_literalcode("%f %f m",concat(pth.x_coord,pth.y_coord))
        elseif curved(ith,pth) then
            local a, b = concat(ith.right_x,ith.right_y)
            local c, d = concat(pth.left_x,pth.left_y)
            pdf_literalcode("%f %f %f %f %f %f c",a,b,c,d,concat(pth.x_coord, pth.y_coord))
        else
           pdf_literalcode("%f %f l",concat(pth.x_coord, pth.y_coord))
        end
        ith = pth
    end
    if not open then
        local one = path[1]
        if curved(pth,one) then
            local a, b = concat(pth.right_x,pth.right_y)
            local c, d = concat(one.left_x,one.left_y)
            pdf_literalcode("%f %f %f %f %f %f c",a,b,c,d,concat(one.x_coord, one.y_coord))
        else
            pdf_literalcode("%f %f l",concat(one.x_coord,one.y_coord))
        end
    elseif #path == 1 then
        -- special case .. draw point
        local one = path[1]
        pdf_literalcode("%f %f l",concat(one.x_coord,one.y_coord))
    end
    return t
end

function flush(result,flusher)
    if result then
        local figures = result.fig
        if figures then
            for f=1, #figures do
                log("flushing figure %s",f)
                local figure = figures[f]
                local objects = getobjects(result,figure,f)
                local fignum = tonumber((figure:filename()):match("([%d]+)$") or figure:charcode() or 0)
                local miterlimit, linecap, linejoin, dashed = -1, -1, -1, false
                local bbox = figure:boundingbox()
                local llx, lly, urx, ury = bbox[1], bbox[2], bbox[3], bbox[4] -- faster than unpack
                if urx < llx then
                    -- invalid
                    pdf_startfigure(fignum,0,0,0,0)
                    pdf_stopfigure()
                else
                    pdf_startfigure(fignum,llx,lly,urx,ury)
                    pdf_literalcode("q")
                    if objects then
                        for o=1,#objects do
                            local object = objects[o]
                            local objecttype = object.type
                            if objecttype == "start_bounds" or objecttype == "stop_bounds" then
                                -- skip
                            elseif objecttype == "start_clip" then
                                pdf_literalcode("q")
                                flushnormalpath(object.path,t,false)
                                pdf_literalcode("W n")
                            elseif objecttype == "stop_clip" then
                                pdf_literalcode("Q")
                                miterlimit, linecap, linejoin, dashed = -1, -1, -1, false
                            elseif objecttype == "special" then
                                -- not supported
                            elseif objecttype == "text" then
                                local ot = object.transform -- 3,4,5,6,1,2
                                pdf_literalcode("q %f %f %f %f %f %f cm",ot[3],ot[4],ot[5],ot[6],ot[1],ot[2])
                                pdf_textfigure(object.font,object.dsize,object.text,object.width,object.height,object.depth)
                                pdf_literalcode("Q")
                            else
                                local cs = object.color
                                if cs and #cs > 0 then
                                    pdf_literalcode(colorconverter(cs))
                                end
                                local ml = object.miterlimit
                                if ml and ml ~= miterlimit then
                                    miterlimit = ml
                                    pdf_literalcode("%f M",ml)
                                end
                                local lj = object.linejoin
                                if lj and lj ~= linejoin then
                                    linejoin = lj
                                    pdf_literalcode("%i j",lj)
                                end
                                local lc = object.linecap
                                if lc and lc ~= linecap then
                                    linecap = lc
                                    pdf_literalcode("%i J",lc)
                                end
                                local dl = object.dash
                                if dl then
                                    local d = format("[%s] %i d",concat(dl.dashes or {}," "),dl.offset)
                                    if d ~= dashed then
                                        dashed = d
                                        pdf_literalcode(dashed)
                                    end
                                elseif dashed then
                                   pdf_literalcode("[] 0 d")
                                   dashed = false
                                end
                                local path = object.path
                                local transformed, penwidth = false, 1
                                local open = path and path[1].left_type and path[#path].right_type
                                local pen = object.pen
                                if pen then
                                   if pen.type == 'elliptical' then
                                        transformed, penwidth = pen_characteristics(object) -- boolean, value
                                        pdf_literalcode("%f w",penwidth)
                                        if objecttype == 'fill' then
                                            objecttype = 'both'
                                        end
                                   else -- calculated by mplib itself
                                        objecttype = 'fill'
                                   end
                                end
                                if transformed then
                                    pdf_literalcode("q")
                                end
                                if path then
                                    if transformed then
                                        flushconcatpath(path,open)
                                    else
                                        flushnormalpath(path,open)
                                    end
                                    if objecttype == "fill" then
                                        pdf_literalcode("h f")
                                    elseif objecttype == "outline" then
                                        pdf_literalcode((open and "S") or "h S")
                                    elseif objecttype == "both" then
                                        pdf_literalcode("h B")
                                    end
                                end
                                if transformed then
                                    pdf_literalcode("Q")
                                end
                                local path = object.htap
                                if path then
                                    if transformed then
                                        pdf_literalcode("q")
                                    end
                                    if transformed then
                                        flushconcatpath(path,open)
                                    else
                                        flushnormalpath(path,open)
                                    end
                                    if objecttype == "fill" then
                                        pdf_literalcode("h f")
                                    elseif objecttype == "outline" then
                                        pdf_literalcode((open and "S") or "h S")
                                    elseif objecttype == "both" then
                                        pdf_literalcode("h B")
                                    end
                                    if transformed then
                                        pdf_literalcode("Q")
                                    end
                                end
                                if cr then
                                    pdf_literalcode(cr)
                                end
                            end
                       end
                    end
                    pdf_literalcode("Q")
                    pdf_stopfigure()
                end
            end
        end
    end
end

function colorconverter(cr)
    local n = #cr
    if n == 4 then
        local c, m, y, k = cr[1], cr[2], cr[3], cr[4]
        return format("%.3f %.3f %.3f %.3f k %.3f %.3f %.3f %.3f K",c,m,y,k,c,m,y,k), "0 g 0 G"
    elseif n == 3 then
        local r, g, b = cr[1], cr[2], cr[3]
        return format("%.3f %.3f %.3f rg %.3f %.3f %.3f RG",r,g,b,r,g,b), "0 g 0 G"
    else
        local s = cr[1]
        return format("%.3f g %.3f G",s,s), "0 g 0 G"
    end
end
-- 
--  End of File `luamplib.lua'.
