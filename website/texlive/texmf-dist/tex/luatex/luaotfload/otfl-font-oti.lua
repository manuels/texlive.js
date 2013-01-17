if not modules then modules = { } end modules ['font-oti'] = {
    version   = 1.001,
    comment   = "companion to font-ini.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

-- i need to check features=yes|no also in relation to hashing

local lower = string.lower

local otf = fonts.otf

otf.default_language = 'latn'
otf.default_script   = 'dflt'

local languages = otf.tables.languages
local scripts   = otf.tables.scripts

function otf.features.language(tfmdata,value)
    if value then
        value = lower(value)
        if languages[value] then
            tfmdata.language = value
        end
    end
end

function otf.features.script(tfmdata,value)
    if value then
        value = lower(value)
        if scripts[value] then
            tfmdata.script = value
        end
    end
end

function otf.features.mode(tfmdata,value)
    if value then
        tfmdata.mode = lower(value)
    end
end

fonts.initializers.base.otf.language = otf.features.language
fonts.initializers.base.otf.script   = otf.features.script
fonts.initializers.base.otf.mode     = otf.features.mode
fonts.initializers.base.otf.method   = otf.features.mode

fonts.initializers.node.otf.language = otf.features.language
fonts.initializers.node.otf.script   = otf.features.script
fonts.initializers.node.otf.mode     = otf.features.mode
fonts.initializers.node.otf.method   = otf.features.mode

otf.features.register("features",true)     -- we always do features
table.insert(fonts.processors,"features")  -- we need a proper function for doing this

