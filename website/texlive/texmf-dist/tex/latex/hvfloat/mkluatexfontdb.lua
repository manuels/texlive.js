#!/usr/bin/env texlua
--[[
This file is copyright 2010 Elie Roux and Khaled Hosny and is under CC0
license (see http://creativecommons.org/publicdomain/zero/1.0/legalcode).

This file is a wrapper for the luaotfload's font names module. It is part of the
luaotfload bundle, please see the luaotfload documentation for more info.
--]]

kpse.set_program_name("luatex")

require("lualibs")
require("otfl-font-nms")
require("alt_getopt")

local name = 'mkluatexfontdb'
local version = '1.07' -- same version number as luaotfload

local names    = fonts.names

local function help_msg()
    texio.write(string.format([[
Usage: %s [OPTION]...
    
Rebuild the LuaTeX font database.

Valid options:
  -f --force                   force re-indexing all fonts
  -q --quiet                   don't output anything
  -v --verbose=LEVEL           be more verbose (print the searched directories)
  -vv                          print the loaded fonts
  -vvv                         print all steps of directory searching
  -V --version                 print version and exit
  -h --help                    print this message

The output database file is named otfl-fonts.lua and is placed under:

   %s"
]], name, names.path.localdir))
end

local function version_msg()
    texio.write(string.format(
        "%s version %s, database version %s.\n", name, version, names.version))
end

--[[
Command-line processing.
Here we fill cmdargs with the good values, and then analyze it.
--]]

local long_opts = {
    force            = "f",
    quiet            = "q",
    help             = "h",
    verbose          = 1  ,
    version          = "V",
}

local short_opts = "fqpvVh"

local force_reload = nil

local function process_cmdline()
    local opts, optind, optarg = alt_getopt.get_ordered_opts (arg, short_opts, long_opts)
    local log_level = 1
    for i,v in ipairs(opts) do
        if     v == "q" then
            log_level = 0
        elseif v == "v" then
            if log_level > 0 then
                log_level = log_level + 1
            else
                log_level = 2
            end
        elseif v == "V" then
            version_msg()
            os.exit(0)
        elseif v == "h" then
            help_msg()
            os.exit(0)
        elseif v == "f" then
            force_reload = 1
        end
    end
    names.set_log_level(log_level)
end

local function generate(force)
    local fontnames, saved
    fontnames = names.update(fontnames, force)
    logs.report("%s fonts in the database", #fontnames.mappings)
    saved = names.save(fontnames)
end

process_cmdline()
generate(force_reload)
