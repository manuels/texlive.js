if not modules then modules = { } end modules ['font-ini'] = {
    version   = 1.001,
    comment   = "companion to font-ini.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

--[[ldx--
<p>Not much is happening here.</p>
--ldx]]--

local utf = unicode.utf8
local format, serialize = string.format, table.serialize
local write_nl = texio.write_nl
local lower = string.lower

if not fontloader then fontloader = fontforge end

fontloader.totable = fontloader.to_table

-- vtf comes first
-- fix comes last

fonts     = fonts     or { }

fonts.ids = fonts.ids or { } fonts.identifiers = fonts.ids -- aka fontdata
fonts.chr = fonts.chr or { } fonts.characters  = fonts.chr -- aka chardata
fonts.qua = fonts.qua or { } fonts.quads       = fonts.qua -- aka quaddata

fonts.tfm = fonts.tfm or { }

fonts.mode    = 'base'
fonts.private = 0xF0000 -- 0x10FFFF
fonts.verbose = false -- more verbose cache tables

fonts.ids[0] = { -- nullfont
    characters   = { },
    descriptions = { },
    name         = "nullfont",
}

fonts.chr[0] = { }

fonts.methods = fonts.methods or {
    base = { tfm = { }, afm = { }, otf = { }, vtf = { }, fix = { } },
    node = { tfm = { }, afm = { }, otf = { }, vtf = { }, fix = { }  },
}

fonts.initializers = fonts.initializers or {
    base = { tfm = { }, afm = { }, otf = { }, vtf = { }, fix = { }  },
    node = { tfm = { }, afm = { }, otf = { }, vtf = { }, fix = { }  }
}

fonts.triggers = fonts.triggers or {
    'mode',
    'language',
    'script',
    'strategy',
}

fonts.processors = fonts.processors or {
}

fonts.manipulators = fonts.manipulators or {
}

fonts.define                  = fonts.define                  or { }
fonts.define.specify          = fonts.define.specify          or { }
fonts.define.specify.synonyms = fonts.define.specify.synonyms or { }

-- tracing

if not fonts.color then

    fonts.color = {
        set   = function() end,
        reset = function() end,
    }

end

-- format identification

fonts.formats = { }

function fonts.fontformat(filename,default)
    local extname = lower(file.extname(filename))
    local format = fonts.formats[extname]
    if format then
        return format
    else
        logs.report("fonts define","unable to determine font format for '%s'",filename)
        return default
    end
end
