#!/usr/bin/env ruby

load 'languages.rb'

# this file auto-generates loaders for hyphenation patterns - to be improved

$package_name="hyph-utf8"
$ctan_url = "http://www.ctan.org/tex-archive/language/hyph-utf8/tex/generic/hyph-utf8"

# TODO - make this a bit less hard-coded
$path_tex_generic="../../../tex/generic"

$l = Languages.new
# TODO: should be singleton
languages = $l.list.sort{|a,b| a.name <=> b.name}

language_grouping = {
	'norwegian' => ['nb', 'nn'],
	'german' => ['de-1901', 'de-1996','de-ch-1901'],
	'mongolian' => ['mn-cyrl', 'mn-cyrl-x-2a'],
	'greek' => ['el-monoton', 'el-polyton'],
	'ancientgreek' => ['grc', 'grc-x-ibycus'],
	'chinese' => ['zh-latn-pinyin'],
	# TODO - until someone tells what to do
	#'serbian' => ['sr-latn', 'sr-cyrl'],
	'serbian' => ['sh-latn'],
}

language_used_in_group = Hash.new
language_grouping.each_value do |group|
	group.each do |code|
		language_used_in_group[code] = true
	end
end

# a hash with language name as key and array of languages as the value
language_groups = Hash.new
# single languages first
languages.each do |language|
	# temporary remove cyrilic serbian until someone explains what is needed
	if language.code == 'sr-cyrl' then
		languages.delete(language)
	elsif language.code == 'sh-latn' then
		language.code = 'sr-latn'
	elsif language_used_in_group[language.code] == nil then
		language_groups[language.name] = [language]
	end
end
# then groups of languages
language_grouping.each do |name,group|
	language_groups[name] = []
	group.each do |code|
		language_groups[name].push($l[code])
	end
end

language_groups.sort.each do |language_name,language_list|
	first_line_printed = false
	language_list.each do |language|
		if language != nil then
			if not first_line_printed then
				puts "<tr>\n\t<td><b>#{language_name.capitalize}</b></td>"
				first_line_printed = true;
			else
				puts "<tr>\n\t<td>&nbsp;</td>"
			end
	
			# synonyms
			if language.synonyms != nil and language.synonyms.length > 0 then
				synonyms=", #{language.synonyms.join(', ')}"
			else
				synonyms=""
			end
			puts "\t<td>#{language.name}#{synonyms}</td>"
	
	#		if language.use_old_patterns == false then
			if language.use_new_loader == true then
				url_patterns = "#{$ctan_url}/patterns/tex/hyph-#{language.code}.tex"
				code = "<a href=\"#{url_patterns}\">#{language.code}</a>"
			else
				url_patterns = ""
				code = language.code
			end
			
			puts "\t<td>#{code}</td>"
	
			# lefthyphenmin/righthyphenmin
			if language.hyphenmin == nil or language.hyphenmin.length == 0 then
				lmin = ''
				rmin = ''
			elsif language.filename_old_patterns == "zerohyph.tex" then
				lmin = ''
				rmin = ''
			else
				lmin = language.hyphenmin[0]
				rmin = language.hyphenmin[1]
			end
			puts "\t<td>(#{lmin},#{rmin})</td>"
			# which file to use
			if language.use_new_loader then
				file = "loadhyph-#{language.code}.tex"
			else
				file = "#{language.filename_old_patterns}"
			end
			#puts "\t<td>#{file}</td>"
			if language.encoding == nil then
				encoding = ""
			else
				encoding = language.encoding.upcase
			end
			puts "\t<td>#{encoding}</td>"
			puts "</tr>\n"
		end
	end
end

