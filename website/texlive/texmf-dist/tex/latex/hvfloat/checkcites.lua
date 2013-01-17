#!/usr/bin/env texlua
-- ******************************************************************
-- checkcites.lua
-- Copyright 2012 Enrico Gregorio, Paulo Roberto Massa Cereda
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either version 1.3
-- of this license or (at your option) any later version.
--
-- The latest version of this license is in
--   http://www.latex-project.org/lppl.txt
-- and version 1.3 or later is part of all distributions of LaTeX
-- version 2005/12/01 or later.
--
-- This work has the LPPL maintenance status `maintained'.
-- 
-- The Current Maintainers of this work are the original authors.
--
-- This work consists of the file checkcites.lua.
--
-- Project page: http://github.com/cereda/checkcites
-- ******************************************************************

-- version and date, to be updated on each release/commit
VERSION = "1.0h"
DATE = "March 16, 2012"

-- globals
-- warning about \citation{*}
globalAsteriskWarning = true

-- The following code adds a 'split' function to the string type,
-- thanks to the codebase available here:
-- http://lua-users.org/wiki/SplitJoin
string.split = function(str, pattern)

    pattern = pattern or "[^%s]+"
    
    if pattern:len() == 0 then
    
        pattern = "[^%s]+"
    
    end
    
    local parts = {__index = table.insert}
    
    setmetatable(parts, parts)
    
    str:gsub(pattern, parts)
    
    setmetatable(parts, nil)
    
    parts.__index = nil
    
    return parts

end

-- In order to make our lives easier, we borrowed the following
-- codes for implementing common set operations, available here:
-- http://www.phailed.me/2011/02/common-set-operations-in-lua/
function setFind(a, tbl)

	for _,a_ in ipairs(tbl) do
        
        if a_==a then
            
            return true
        end
    
    end

end

-- This code returns a table containing the difference between
-- the two other tables, also available here:
-- http://www.phailed.me/2011/02/common-set-operations-in-lua/
function setDifference(a, b)

	local ret = {}

	for _,a_ in ipairs(a) do

		if not setFind(a_,b) then
            
            table.insert(ret, a_)
        
        end

	end

	return ret

end

-- Code to remove duplicates from a table array.
function removeDuplicates(tb)

    -- new table
    local ret = {}

    -- flag to spot new insertions
    local flag

    -- set local variables
    local i
    local k
    local j
    local l

    -- iterate through the original table
    for i, k in pairs(tb) do

        -- at first, insert element
        flag = true

        -- iterate through the new table
        for j, l in pairs(ret) do

            -- if the element already exists
            if k == l then

                -- set flag to false, so the
                -- new element won't be inserted
                flag = false

            end

        end

        -- if it's ok to insert
        if flag then

            -- insert new element
            table.insert(ret, k)

        end

    end

    -- return new table
    return ret
end

-- This function opens and gets all data from the provided
-- aux file.
-- Return:
--   * list of citations
--   * list of bibfiles
function getDataFromAuxFile(theAuxFile)

    -- open a file handler
	local fileHandler = io.open(theAuxFile,"r")

    -- check if the handler is valid
	if fileHandler then

        -- create a local table for citations
		local theCitations = {}

        -- and a local reference to the bib file
		local theBibFiles = {}

        -- define local variables
        local currentLine
        local citation
        local index
        local theCitation
        local theBibFile
        local entry

        -- now let's iterate through the lines
		for currentLine in fileHandler:lines() do

            -- if the citation matches, extract it
			for citation in string.gmatch(currentLine, '\\citation{(.+)}') do

                -- sanity check, in case it's an '*'
				if citation ~= "*" then

                    -- break the citations list, in case of multiple
                    -- citations in the same \citation{}
					local parts = string.split(citation, "[^,%s]+" )

                    -- for every entry in the citations list
					for index, theCitation in pairs(parts) do
                        
                        -- insert the reference
						table.insert(theCitations, theCitation)

					end

                -- found a '*'
                else

                    -- check if warning is still valid, that is,
                    -- if not displayed yet
                    if globalAsteriskWarning then

                        -- show message
                        print("Warning: '\\nocite{*}' found, I'll do the check nonetheless.\n")

                        -- warning already displayed, so
                        -- set flag to false
                        globalAsteriskWarning = false

                    end

                end

            -- end of citation in current line
            end

            -- in the same current line, check if there's the 
            -- bibdata entry and extract it
			for entry in string.gmatch(currentLine, '\\bibdata{(.+)}') do

                -- break the bib files list, in case of multiple
                -- files in the same \bibdata{}
				local parts = string.split(entry, "[^,%s]+" )

                -- for every entry in the bib files list
				for index, theBibFile in pairs(parts) do

                    -- insert the file
        			table.insert(theBibFiles, theBibFile)

				end

            -- end of bib files in the current line
            end

        -- end of current line
        end

        -- close the file handler
		fileHandler:close()

        -- remove duplicated citations
        theCitations = removeDuplicates(theCitations)

        -- print a message about the citations
		print("I found " .. #theCitations .. " citation(s).")

        -- remove possible duplicated files
        theBibFiles = removeDuplicates(theBibFiles)

        -- if there are no bib files
        if #theBibFiles == 0 then

            -- show message
            print("I couldn't find any bibliography files.\nI'm afraid I have nothing to do now.")

            -- and abort the script
    		os.exit()

        -- if there is only one bib file
        elseif #theBibFiles == 1 then

            -- show message
            print("Great, there's only one 'bib' file. Let me check it.")

        -- there are more bib files
        else

            -- show message
            print("Oh no, I have to check more than one 'bib' file. Please wait.")

        end

        -- return both citations and bib files
        return theCitations, theBibFiles

    -- the file handler is invalid
    else

        -- print an error message
		print("File '" .. theAuxFile .. "' does not exist or is unavailable. Aborting script.")

        -- and abort the script
		os.exit()

    end

-- end of function
end

-- This function opens and gets all data from all the available
-- bib files.
function getDataFromBibFiles(theBibFiles)

    -- create a table to store the citations
	local theReferences = {}

    -- set local variables
    local index
    local theBibFile
    local currentLine
    local reference

    -- iterate through all bib files
    for index, theBibFile in pairs(theBibFiles) do

        -- open the bib file
		local fileHandler = io.open(theBibFile .. ".bib","r")

        -- check if the handler is valid
		if fileHandler then

            -- iterate through every line of the bib file
			for currentLine in fileHandler:lines() do

                -- if a reference is found
				for reference in string.gmatch(currentLine, '@%w+{(.+),') do

                    -- insert the reference
					table.insert(theReferences, reference)

                end

            -- end current line
            end

            -- close the file handler
			fileHandler:close()

        -- bib file does not exist
        else

            -- error message
			print("File '" .. theBibFile .. ".bib' does not exist. Aborting.")

			-- abort script
			os.exit()

        end

    -- end iteration through the bib files
    end

    -- remove duplicated references
    theReferences = removeDuplicates(theReferences)

    -- print message
	print("I found " .. #theReferences .. " reference(s).")

    -- return references
	return theReferences

-- end of function
end

-- This function show all the undefined references. It's very
-- simple, it's a difference between two sets.
function showUndefinedReferences(citations, references)

    -- get all undefined references
	local undefined = setDifference(citations, references)

    -- print message
    print("\nUndefined reference(s) in your TeX file: " .. #undefined)

	-- if there are undefined references
	if #undefined ~= 0 then

        -- local variables
        local index
        local reference

		-- iterate
		for index, reference in pairs(undefined) do

			-- and print
			print("- " .. reference)

		end

    end

-- end of function
end

-- This function show all the unused references. It's very
-- simple, it's a difference between two sets.
function showUnusedReferences(citations, references)

-- get all undefined references
	local unused = setDifference(references, citations)

    -- print message
   	print("\nUnused reference(s) in your bibliography file(s): " .. #unused)

	-- if there are unused references
	if #unused ~= 0 then

        -- local variables
        local index
        local reference

		-- iterate
		for index, reference in pairs(unused) do

			-- and print
			print("- " .. reference)

		end
        
    end

-- end of function
end

-- This function parses the command line arguments and returns a
-- bunch of info for us to use.
-- Return:
--   * an argument code
--   * the filename
--   * an action code
function parseArguments(theArgs)

    -- check if there are no arguments
    if #theArgs == 0 then

        -- return usage code
        return 0, nil, nil

    -- there is one argument
    elseif #theArgs == 1 then

        -- check if it's help
        if theArgs[1] == "--help" then

            -- return help code
            return 1, nil, nil

            -- check if it's version
        elseif theArgs[1] == "--version" then

            -- return version code
            return 2, nil, nil

        -- check if it's invalid
        elseif string.sub(theArgs[1], 1, 1) == "-" then

            -- return invalid code
            return 3, nil, nil

        -- it seems a clean argument
        else

            -- return it as a valid argument
            return 4, theArgs[1], nil

        -- end for one parameter
        end

    -- there are two arguments
    elseif #theArgs == 2 then

        -- check if both are valid
        if ((theArgs[1] == "--all" or theArgs[1] == "--unused" or theArgs[1] == "--undefined") and string.sub(theArgs[2], 1, 1) ~= "-") or ((theArgs[2] == "--all" or theArgs[2] == "--unused" or theArgs[2] == "--undefined") and string.sub(theArgs[1], 1, 1) ~= "-") then

            -- create an action code
            local actionCode

            -- check which one is the file name
            if string.sub(theArgs[1], 1, 1) ~= "-" then

                -- check for --all
                if theArgs[2] == "--all" then

                    -- set the action code
                    actionCode = 0

                -- check for --unused
                elseif theArgs[2] == "--unused" then

                    -- set the action code
                    actionCode = 1

                -- it's --undefined
                else

                    -- set the action code
                    actionCode = 2

                end

                -- it's the first
                return 4, theArgs[1], actionCode

            else

                -- check for --all
                if theArgs[1] == "--all" then

                    -- set the action code
                    actionCode = 0

                -- check for --unused
                elseif theArgs[1] == "--unused" then

                    -- set the action code
                    actionCode = 1

                else

                    -- it's --undefined
                    actionCode = 2

                end

                -- it's the second
                return 4, theArgs[2], actionCode

            end

        else

            -- return invalid code
            return 3, nil, nil

        end

    else

        -- more than two arguments, return usage code
        return 0, nil, nil

    end

-- end of function
end

-- This function prints the script header.
function printHeader()

    -- print message
	print("checkcites.lua -- a reference checker script (v" .. VERSION .. ")")
	print("Copyright (c) 2012 Enrico Gregorio, Paulo Roberto Massa Cereda\n")

-- end of function
end

-- This function prints the script usage
function printUsage()

    -- show message
	print("Usage: " .. arg[0] .. " [--all | --unused | --undefined] file.aux\n")
    print("--all         Lists all unused and undefined references.")
    print("--unused      Lists only unused references in your 'bib' file.")
    print("--undefined   Lists only undefined references in your 'tex' file.\n")
    print("If no flag is provided, '--all' is set by default.")
	print("Be sure to have all your 'bib' files in the same directory.")

-- end of function
end

function printHelp()

    -- show message
    print("checkcites.lua is a Lua script written for the sole purpose of")
    print("detecting undefined/unused references from LaTeX auxiliary or")
    print("bibliography files. It's very easy to use!\n")

    -- print usage
    printUsage()

-- end of function
end

-- This function prints the script version.
function printVersion()

    -- print message
    print("checkcites.lua version " .. VERSION .. " (dated " .. DATE .. ")")
    print("You can find more information about this script in the official")
    print("source code repository:\n")
    print("http://github.com/cereda/checkcites\n")
    print("checkcites.lua is licensed under the LaTeX Project Public License.")

-- end of function
end

-- This function prints a message for invalid parameters.
function printInvalid()

    -- print message
    print("Oh no, it seems you used an invalid argument.\n")

    -- print usage
    printUsage()

-- end of function
end

-- This is our main function.
function runMain(theArgs)

   	-- print the script header
	printHeader()

    -- set local variables
    local argCode
    local fileName
    local actionCode

    -- parse arguments and get the result
    argCode, fileName, actionCode = parseArguments(theArgs)

    -- check for usage
    if argCode == 0 then

        -- print usage
        printUsage()

    -- it's help
    elseif argCode == 1 then

        -- print help
        printHelp()

    -- it's version
    elseif argCode == 2 then

        -- print version
        printVersion()

    -- it's an invalid parameter
    elseif argCode == 3 then

        -- print invalid
        printInvalid()

    -- it's a valid operation
    else

        -- get data from aux
        a, b = getDataFromAuxFile(fileName)

        -- get data from bib
        c = getDataFromBibFiles(b)

        -- if there is an action code
        if actionCode ~= nil then

            -- it's --all
            if actionCode == 0 then

                -- do everything
                showUnusedReferences(a,c)
                showUndefinedReferences(a,c)

            -- it's --unused
            elseif actionCode == 1 then

                -- only show unused
                showUnusedReferences(a,c)

            -- it's --undefined
            else

                -- only show undefined
                showUndefinedReferences(a,c)

            end

        -- there's only one parameter, the file name,
        -- so we set --all
        else

            -- show everything
            showUnusedReferences(a,c)
            showUndefinedReferences(a,c)

        end

    end

-- end of function
end

-- run the main function
runMain(arg)
