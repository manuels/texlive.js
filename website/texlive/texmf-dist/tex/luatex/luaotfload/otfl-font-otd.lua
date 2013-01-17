if not modules then modules = { } end modules ['font-otd'] = {
    version   = 1.001,
    comment   = "companion to font-ini.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local trace_dynamics = false  trackers.register("otf.dynamics", function(v) trace_dynamics     = v end)

fonts     = fonts     or { }
fonts.otf = fonts.otf or { }

local otf      = fonts.otf
local fontdata = fonts.ids

otf.features         = otf.features         or { }
otf.features.default = otf.features.default or { }

local context_setups  = fonts.define.specify.context_setups
local context_numbers = fonts.define.specify.context_numbers

local a_to_script   = { }  otf.a_to_script   = a_to_script
local a_to_language = { }  otf.a_to_language = a_to_language

function otf.set_dynamics(font,dynamics,attribute)
    local features = context_setups[context_numbers[attribute]] -- can be moved to caller
    if features then
        local script   = features.script   or 'dflt'
        local language = features.language or 'dflt'
        local ds = dynamics[script]
        if not ds then
            ds = { }
            dynamics[script] = ds
        end
        local dsl = ds[language]
        if not dsl then
            dsl = { }
            ds[language] = dsl
        end
        local dsla = dsl[attribute]
        if dsla then
        --  if trace_dynamics then
        --      logs.report("otf define","using dynamics %s: attribute %s, script %s, language %s",context_numbers[attribute],attribute,script,language)
        --  end
            return dsla
        else
            local tfmdata = fontdata[font]
            a_to_script  [attribute] = script
            a_to_language[attribute] = language
            -- we need to save some values
            local saved = {
                script    = tfmdata.script,
                language  = tfmdata.language,
                mode      = tfmdata.mode,
                features  = tfmdata.shared.features
            }
            tfmdata.mode     = "node"
            tfmdata.language = language
            tfmdata.script   = script
            tfmdata.shared.features = { }
            -- end of save
            local set = fonts.define.check(features,otf.features.default)
            dsla = otf.set_features(tfmdata,set)
            if trace_dynamics then
                logs.report("otf define","setting dynamics %s: attribute %s, script %s, language %s, set: %s",context_numbers[attribute],attribute,script,language,table.sequenced(set))
            end
            -- we need to restore some values
            tfmdata.script          = saved.script
            tfmdata.language        = saved.language
            tfmdata.mode            = saved.mode
            tfmdata.shared.features = saved.features
            -- end of restore
            dynamics[script][language][attribute] = dsla -- cache
            return dsla
        end
    end
    return nil -- { }
end
