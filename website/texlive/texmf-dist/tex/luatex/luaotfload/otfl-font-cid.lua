if not modules then modules = { } end modules ['font-cid'] = {
    version   = 1.001,
    comment   = "companion to font-otf.lua (cidmaps)",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local format, match, lower = string.format, string.match, string.lower
local tonumber = tonumber
local lpegmatch = lpeg.match

local trace_loading = false  trackers.register("otf.loading",      function(v) trace_loading      = v end)

fonts         = fonts         or { }
fonts.cid     = fonts.cid     or { }
fonts.cid.map = fonts.cid.map or { }
fonts.cid.max = fonts.cid.max or 10


-- original string parser: 0.109, lpeg parser: 0.036 seconds for Adobe-CNS1-4.cidmap
--
-- 18964 18964 (leader)
-- 0 /.notdef
-- 1..95 0020
-- 99 3000

local number  = lpeg.C(lpeg.R("09","af","AF")^1)
local space   = lpeg.S(" \n\r\t")
local spaces  = space^0
local period  = lpeg.P(".")
local periods = period * period
local name    = lpeg.P("/") * lpeg.C((1-space)^1)

local unicodes, names = { }, { }

local function do_one(a,b)
    unicodes[tonumber(a)] = tonumber(b,16)
end

local function do_range(a,b,c)
    c = tonumber(c,16)
    for i=tonumber(a),tonumber(b) do
        unicodes[i] = c
        c = c + 1
    end
end

local function do_name(a,b)
    names[tonumber(a)] = b
end

local grammar = lpeg.P { "start",
    start  = number * spaces * number * lpeg.V("series"),
    series = (spaces * (lpeg.V("one") + lpeg.V("range") + lpeg.V("named")) )^1,
    one    = (number * spaces  * number) / do_one,
    range  = (number * periods * number * spaces * number) / do_range,
    named  = (number * spaces  * name) / do_name
}

function fonts.cid.load(filename)
    local data = io.loaddata(filename)
    if data then
        unicodes, names = { }, { }
        lpegmatch(grammar,data)
        local supplement, registry, ordering = match(filename,"^(.-)%-(.-)%-()%.(.-)$")
        return {
            supplement = supplement,
            registry   = registry,
            ordering   = ordering,
            filename   = filename,
            unicodes   = unicodes,
            names      = names
        }
    else
        return nil
    end
end

local template = "%s-%s-%s.cidmap"


local function locate(registry,ordering,supplement)
    local filename = format(template,registry,ordering,supplement)
    local hashname = lower(filename)
    local cidmap = fonts.cid.map[hashname]
    if not cidmap then
        if trace_loading then
            logs.report("load otf","checking cidmap, registry: %s, ordering: %s, supplement: %s, filename: %s",registry,ordering,supplement,filename)
        end
        local fullname = resolvers.find_file(filename,'cid') or ""
        if fullname ~= "" then
            cidmap = fonts.cid.load(fullname)
            if cidmap then
                if trace_loading then
                    logs.report("load otf","using cidmap file %s",filename)
                end
                fonts.cid.map[hashname] = cidmap
                cidmap.usedname = file.basename(filename)
                return cidmap
            end
        end
    end
    return cidmap
end

function fonts.cid.getmap(registry,ordering,supplement)
    -- cf Arthur R. we can safely scan upwards since cids are downward compatible
    local supplement = tonumber(supplement)
    if trace_loading then
        logs.report("load otf","needed cidmap, registry: %s, ordering: %s, supplement: %s",registry,ordering,supplement)
    end
    local cidmap = locate(registry,ordering,supplement)
    if not cidmap then
        local cidnum = nil
        -- next highest (alternatively we could start high)
        if supplement < fonts.cid.max then
            for supplement=supplement+1,fonts.cid.max do
                local c = locate(registry,ordering,supplement)
                if c then
                    cidmap, cidnum = c, supplement
                    break
                end
            end
        end
        -- next lowest (least worse fit)
        if not cidmap and supplement > 0 then
            for supplement=supplement-1,0,-1 do
                local c = locate(registry,ordering,supplement)
                if c then
                    cidmap, cidnum = c, supplement
                    break
                end
            end
        end
        -- prevent further lookups
        if cidmap and cidnum > 0 then
            for s=0,cidnum-1 do
                filename = format(template,registry,ordering,s)
                if not fonts.cid.map[filename] then
                    fonts.cid.map[filename] = cidmap -- copy of ref
                end
            end
        end
    end
    return cidmap
end
