# -*- coding: utf-8 -*-

class Language
	def initialize(language_hash,pattern_path)
        @pattern_path = pattern_path

		@use_new_loader = language_hash["use_new_loader"]
		@use_old_patterns = language_hash["use_old_patterns"]
		@use_old_patterns_comment = language_hash["use_old_patterns_comment"]
		@filename_old_patterns = language_hash["filename_old_patterns"]
		@filename_old_patterns_other = language_hash["filename_old_patterns_other"]
		@code = language_hash["code"]
		@name = language_hash["name"]
		@synonyms = language_hash["synonyms"] 
		@hyphenmin = language_hash["hyphenmin"]
		@encoding = language_hash["encoding"]
		@exceptions = language_hash["exceptions"]
		@message = language_hash["message"]
		
		if @synonyms==nil then @synonyms = [] end
	end

	# TODO: simplify this (reduce duplication)

	def get_exceptions
		if @exceptions1 == nil
          filename = "#{@pattern_path}/hyph-#{@code}.hyp.txt";
			lines = IO.readlines(filename, '.').join("")
			exceptions = lines.gsub(/%.*/,'');
			@exceptions1 = exceptions.
				gsub(/\s+/m,"\n").
				gsub(/^\s*/m,'').
				gsub(/\s*$/m,'').
				split("\n")
		end

		return @exceptions1
	end

	def get_patterns
		if @patterns == nil
			filename = "#{@pattern_path}/hyph-#{@code}.pat.txt"
			lines = IO.readlines(filename, '.').join("")
			@patterns = lines.gsub(/%.*/,'').
				gsub(/\s+/m,"\n").
				gsub(/^\s*/m,'').
				gsub(/\s*$/m,'').
				gsub(/'/,"’").
				split("\n")
			# Russian and Ukrainian have some extra patterns with dashes
			# we may combine these patterns with the main file anyway
			# if @code == 'ru' or @code == 'uk' then
			# 	filename = "../../../tex/generic/hyph-utf8/patterns/tex-special/exhyph-#{@code}.tex"
			# 	lines = IO.readlines(filename, '.').join("")
			# 	@patterns.concat(lines.gsub(/%.*/,'').
			# 		gsub(/.*\\patterns\s*\{(.*?)\}.*/m,'\1').
			# 		gsub(/\s+/m,"\n").
			# 		gsub(/^\s*/m,'').
			# 		gsub(/\s*$/m,'').
			# 		gsub(/'/,"’").
			# 		split("\n"))
			# end

			if @code == 'eo' then
				@patterns = lines.gsub(/%.*/,'').
					#
					gsub(/\\adj\{(.*?)\}/m,'\1a. \1aj. \1ajn. \1an. \1e.').
					gsub(/\\nom\{(.*?)\}/m,'\1a. \1aj. \1ajn. \1an. \1e. \1o. \1oj. \1ojn. \1on.').
					gsub(/\\ver\{(.*?)\}/m,'\1as. \1i. \1is. \1os. \1u. \1us.').
					#
					gsub(/\s+/m,"\n").
					gsub(/^\s*/m,'').
					gsub(/\s*$/m,'').
					split("\n")
			end
		end
		return @patterns
	end

	def get_comments_and_licence
		if @comments_and_licence == nil then
			filename = File.expand_path("#{@pattern_path}/hyph-#{@code}.lic.txt");
			lines = IO.readlines(filename, '.').join("")
			@comments_and_licence = lines
		end
		return @comments_and_licence
	end

    def get_classes
        if @classes == nil then
            filename = File.expand_path("#{@pattern_path}/hyph-#{@code}.chr.txt");
			lines = IO.readlines(filename, '.').join("")
			@classes = lines
		end
		return @classes
    end

	# def lc_characters
	# 	if @lc_characters == nil
	# 		lc_characters = Hash.new
	# 		p = self.patterns
	# 		p.each do |pattern|
	# 		end
	# 	end
	# 	return @lc_characters
	# end

	attr_reader :use_new_loader, :use_old_patterns, :use_old_patterns_comment, :filename_old_patterns, :code, :name, :synonyms, :hyphenmin, :encoding, :exceptions, :message
	# this hack is needed for Serbian
	attr_writer :code
end


authors = {
	"peter_heslin" => {
		"name" => "Peter",
		"surname" => "Heslin",
		"tried_to_contact" => false,
	},
	"dimitrios_filippou" => {
		"name"      => "Dimitrios",
		"surname"   => "Filippou",
		"email"     => "dfilipp{at}hotmail{dot}com",
		"contact"   => true,
		"cooperate" => true,
	},
	"claudio_beccari" => {
		"name" => "Claudio",
		"email" => "claudio{dot}beccari{at}polito{dot}it",
	}

}

# "use_new_loader"
# => true - create a new file and use that one
# => false - use "filename_old_patterns" in language.dat
# "filename_old_patterns"
# => [string] - the name used in language.dat if "use_new_loader" is false
# "eightbitfilename"
# => [string] - if set, load another file for 8-bit engines
# "code"
# => [string] - used in filenames, needs to conform to the standard
# "name"
# => [string] -
# "synonyms" => [],
# "hyphenmin" => [],
# "encoding" => nil,
# "exceptions" => false,
# "message" => nil,

class Languages < Hash
	@@list = []
	
	def initialize(pattern_path)
		languages = [
# --------------------------------------
# languages with no hyphenation patterns
# --------------------------------------
# arabic		zerohyph.tex
{
	"code" => "ar",
	"name" => "arabic",
	"use_new_loader" => false,
	"use_old_patterns" => false,
	"filename_old_patterns" => "zerohyph.tex",
#	"hyphenmin" => [], # not needed
	"encoding" => nil,
	"exceptions" => false,
	"message" => nil,
},
# farsi		zerohyph.tex
# =persian
{
	"code" => "fa",
	"name" => "farsi", "synonyms" => ["persian"],
	"use_new_loader" => false,
	"use_old_patterns" => false,
	"filename_old_patterns" => "zerohyph.tex",
#	"hyphenmin" => [], # not needed
	"encoding" => nil,
	"exceptions" => false,
	"message" => nil,
},
# -------------------------------
# special patterns, not converted
# -------------------------------
# ibycus ibyhyph.tex
{
	"code" => "grc-x-ibycus",
	"name" => "ibycus",
	"use_new_loader" => false,
	"use_old_patterns" => true,
	"filename_old_patterns" => "ibyhyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => nil,
	"exceptions" => false,
	"message" => "Ancient Greek Hyphenation Patterns for Ibycus encoding (v3.0)",
	
	"authors" => ["peter_heslin"],
},
# ----------------------------
# languages using old patterns
# ----------------------------
# greek		xu-grphyph4.tex
# =polygreek
{
	"code" => "el-polyton",
	"name" => "greek", "synonyms" => ["polygreek"],
	"use_new_loader" => true,
	"use_old_patterns" => true,
	"use_old_patterns_comment" => "Old patterns work in a different way, one-to-one conversion from UTF-8 is not possible.",
	"filename_old_patterns" => "grphyph5.tex",
	# left/right hyphen min for Greek can be as low as one (1),
	# but for aesthetic reasons keep them at 2/2.
	# Dimitrios Filippou
	"hyphenmin" => [1,1], # polyglosia
	"encoding" => nil,
	"exceptions" => true,
#	"message" => "Polytonic Greek Hyphenation Patterns",
	"message" => "Hyphenation patterns for multi-accent (polytonic) Modern Greek",
	
	"authors" => ["dimitrios_filippou"],
},
# monogreek	xu-grmhyph4.tex
{
	"code" => "el-monoton",
	"name" => "monogreek",
	"use_new_loader" => true,
	"use_old_patterns" => true,
	"use_old_patterns_comment" => "Old patterns work in a different way, one-to-one conversion from UTF-8 is not possible.",
	"filename_old_patterns" => "grmhyph5.tex",
	"hyphenmin" => [1,1], # polyglosia
	"encoding" => nil,
	"exceptions" => true,
#	"message" => "Monotonic Greek Hyphenation Patterns",
	"message" => "Hyphenation patterns for uni-accent (monotonic) Modern Greek",
	
	"authors" => ["dimitrios_filippou"],
},
# ancientgreek	xu-grahyph4.tex
{
	"code" => "grc",
	"name" => "ancientgreek",
	"use_new_loader" => true,
	"use_old_patterns" => true,
	"use_old_patterns_comment" => "Old patterns work in a different way, one-to-one conversion from UTF-8 is not possible.",
	"filename_old_patterns" => "grahyph5.tex",
	"hyphenmin" => [1,1], # polyglosia
	"encoding" => nil,
	"exceptions" => false,
	"message" => "Hyphenation patterns for Ancient Greek",
	
	"authors" => ["dimitrios_filippou"],
},
# coptic		xu-copthyph.tex
{
	"code" => "cop",
	"name" => "coptic",
	"use_new_loader" => true,
	"use_old_patterns" => true,
	"use_old_patterns_comment" => "TODO: automatic conversion could be done, but was too complicated; leave for later.",
	"filename_old_patterns" => "copthyph.tex",
	"hyphenmin" => [1,1], # polyglosia TODO: no documentation found
	"encoding" => nil,
	"exceptions" => false,
	"message" => "Coptic Hyphenation Patterns",
	
	"authors" => ["claudio_beccari"],
},
# german		xu-dehypht.tex
{
	"code" => "de-1901",
	"name" => "german",
	"use_new_loader" => true,
	"use_old_patterns" => true,
	"use_old_patterns_comment" => "Kept for the sake of backward compatibility, but newer and better patterns by WL are available.",
	"filename_old_patterns" => "dehypht.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "German Hyphenation Patterns (Traditional Orthography)",
},
# ngerman		xu-dehyphn.tex
{
	"code" => "de-1996",
	"name" => "ngerman",
	"use_new_loader" => true,
	"use_old_patterns" => true,
	"use_old_patterns_comment" => "Kept for the sake of backward compatibility, but newer and better patterns by WL are available.",
	"filename_old_patterns" => "dehyphn.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "German Hyphenation Patterns (Reformed Orthography)",
},
# swissgerman
{
	"code" => "de-ch-1901",
	"name" => "swissgerman", # TODO: how is it going to be called
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Swiss-German Hyphenation Patterns (Traditional Orthography)",
},
# russian	xu-ruhyphen.tex
{
	"code" => "ru",
	"name" => "russian",
	"use_new_loader" => true,
	"use_old_patterns" => true,
	"use_old_patterns_comment" => "The old system allows choosing patterns and encodings manually. That mechanism needs to be implemented first in this package, so we still fall back on old system.",
	"filename_old_patterns" => "ruhyphen.tex",
	"hyphenmin" => [2,2],
	"encoding" => "t2a",
	"exceptions" => false,
	"message" => "Russian Hyphenation Patterns",
},
# ukrainian	xu-ukrhyph.tex
{
	"code" => "uk",
	"name" => "ukrainian",
	"use_new_loader" => true,
	"use_old_patterns" => true,
	"use_old_patterns_comment" => "The old system allows choosing patterns and encodings manually. That mechanism needs to be implemented first in this package, so we still fall back on old system.",
	"filename_old_patterns" => "ukrhyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "t2a",
	"exceptions" => false,
	"message" => "Ukrainian Hyphenation Patterns",
},
# ----------------------------
# languages using new patterns
# ----------------------------
# afrikaans
{
	"code" => "af",
	"name" => "afrikaans",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => nil,
	"hyphenmin" => [1,2], # in babel: 2,2
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Afrikaans Hyphenation Patterns",
},
# catalan		cahyph.tex
{
	"code" => "ca",
	"name" => "catalan",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "cahyph.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Catalan Hyphenation Patterns",
},
# czech		xu-czhyph.tex
{
	"code" => "cs",
	"name" => "czech",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "czhyph.tex",
	"filename_old_patterns_other" => ["czhyphen.tex","czhyphen.ex"],
	# Both Czech and Slovak: \lefthyphenmin=2, \righthyphenmin=3
	# Typographical rules allow \righthyphenmin=2 when typesetting in a
	# narrow column (newspapers etc.).
	# (used to be 2,2)
	"hyphenmin" => [2,3],
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Czech Hyphenation Patterns (Pavel Sevecek, v3, 1995)",
},
# slovak		xu-skhyph.tex
{
	"code" => "sk",
	"name" => "slovak",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "skhyph.tex",
	"filename_old_patterns_other" => ["skhyphen.tex","skhyphen.ex"],
	# see czech
	"hyphenmin" => [2,3],
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Slovak Hyphenation Patterns (Jana Chlebikova, 1992)",
},
# welsh		cyhyph.tex
{
	"code" => "cy",
	"name" => "welsh",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "cyhyph.tex",
	"hyphenmin" => [2,3],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Welsh Hyphenation Patterns",
},
# danish		dkhyph.tex
{
	"code" => "da",
	"name" => "danish",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "dkhyph.tex",
	"filename_old_patterns_other" => ["dkcommon.tex", "dkspecial.tex"],
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Danish Hyphenation Patterns",
},
# esperanto	xu-eohyph.tex
# TODO
{
	"code" => "eo",
	"name" => "esperanto",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "eohyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "il3", # TODO
	"exceptions" => false,
	"message" => "Esperanto Hyphenation Patterns",
},
# spanish		xu-eshyph.tex
# =espanol
{
	"code" => "es",
	"name" => "spanish", "synonyms" => ["espanol"],
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "eshyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Spanish Hyphenation Patterns",
},
# basque		xu-bahyph.tex
{
	"code" => "eu",
	"name" => "basque",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "bahyph.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Basque Hyphenation Patterns",
},
# french		xu-frhyph.tex
# =patois
# =francais
{
	"code" => "fr",
	"name" => "french", "synonyms" => ["patois","francais"],
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "frhyph.tex",
	"hyphenmin" => [2,3],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "French hyphenation patterns (V2.12, 2002/12/11)",
},
# galician	xu-glhyph.tex
{
	"code" => "gl",
	"name" => "galician",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "glhyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Galician Hyphenation Patterns",
},
# estonian	xu-ethyph.tex
{
	"code" => "et",
	"name" => "estonian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "ethyph.tex",
	"hyphenmin" => [2,3], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Estonian Hyphenation Patterns",
},
# finnish		fihyph.tex
{
	"code" => "fi",
	"name" => "finnish",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "fihyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Finnish Hyphenation Patterns",
},
# croatian	xu-hrhyph.tex
{
	"code" => "hr",
	"name" => "croatian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "hrhyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Croatian Hyphenation Patterns",
},
# hungarian	xu-huhyphn.tex
{
	"code" => "hu",
	"name" => "hungarian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "huhyphn.tex",
	"hyphenmin" => [2,2], # polyglosia
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Hungarian Hyphenation Patterns (v20031107)",
},
# armenian
# Sahak Petrosyan <sahak at mit dot edu>
{
	"code" => "hy",
	"name" => "armenian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => nil,
	"hyphenmin" => [1,2], # taken from Hyphenator.js; check the value
	"encoding" => nil,
	"exceptions" => false,
	"message" => "Armenian Hyphenation Patterns",
},
# interlingua	iahyphen.tex
{
	"code" => "ia",
	"name" => "interlingua",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "iahyphen.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "ascii",
	"exceptions" => true,
	"message" => "Hyphenation Patterns for Interlingua",
},
# indonesian	inhyph.tex
{
	"code" => "id",
	"name" => "indonesian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "inhyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ascii",
	"exceptions" => true,
	"message" => "Indonesian Hyphenation Patterns",
},
# icelandic	icehyph.tex
{
	"code" => "is",
	"name" => "icelandic",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "icehyph.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Icelandic Hyphenation Patterns",
},
# irish		gahyph.tex
{
	"code" => "ga",
	"name" => "irish",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "gahyph.tex",
	"hyphenmin" => [2,3], # babel
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Irish Hyphenation Patterns",
},
# italian		ithyph.tex
{
	"code" => "it",
	"name" => "italian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "ithyph.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "ascii",
	"exceptions" => false,
	"message" => "Italian Hyphenation Patterns",
},
# kurmanji
{
	"code" => "kmr",
	"name" => "kurmanji",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "kmrhyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Kurmanji Hyphenation Patterns (v. 1.0 2009/06/29 JKn and MSh)",
},
# latin		xu-lahyph.tex
{
	"code" => "la",
	"name" => "latin",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"use_old_patterns_comment" => "Old patterns support both EC & OT1 encodings at the same time.",
	"filename_old_patterns" => "lahyph.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Latin Hyphenation Patterns",
},
# lithuanian
{
	"code" => "lt",
	"name" => "lithuanian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [2,2],
	"encoding" => "l7x",
	"exceptions" => false,
	"message" => "Lithuanian Hyphenation Patterns",
},
# latvian
{
	"code" => "lv",
	"name" => "latvian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [2,2],
	"encoding" => "l7x",
	"exceptions" => false,
	"message" => "Latvian Hyphenation Patterns",
},
# dutch		nehyph96.tex
{
	"code" => "nl",
	"name" => "dutch",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "nehyph96.tex",
	# quoting Hans Hagen:
	# patterns generated with 2,2 (so don't go less) but use prefered values 2,3 (educational publishers want 4,5 -)
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Dutch Hyphenation Patterns",
},
# norsk		xu-nohyphbx.tex
# =norwegian
# nynorsk         nnhyph.tex
# bokmal          nbhyph.tex
# polish		xu-plhyph.tex
{
	"code" => "pl",
	"name" => "polish",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "plhyph.tex",
	#{}"hyphenmin" => [1,1],
	"hyphenmin" => [2,2],
	"encoding" => "qx",
	"exceptions" => true,
	"message" => "Polish Hyphenation Patterns",
},
# portuguese	pthyph.tex
# =portuges
{
	"code" => "pt",
	"name" => "portuguese", "synonyms" => ["portuges"],
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "pthyph.tex",
	"hyphenmin" => [2,3], # babel
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Portuguese Hyphenation Patterns",
},
# pinyin		xu-pyhyph.tex
{
	"code" => "zh-latn",
	"name" => "pinyin",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "pyhyph.tex",
	"hyphenmin" => [1,1],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Hyphenation patterns for unaccented pinyin syllables (CJK 4.8.0)",
},
# romanian	xu-rohyphen.tex
{
	"code" => "ro",
	"name" => "romanian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "rohyphen.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Romanian Hyphenation Patterns", # : `rohyphen' 1.1 <29.10.1996>
},
# slovenian	xu-sihyph.tex
# =slovene
{
	"code" => "sl",
	"name" => "slovenian", "synonyms" => ["slovene"],
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "sihyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Slovenian Hyphenation Patterns",
},
# uppersorbian	xu-sorhyph.tex
{
	"code" => "hsb",
	"name" => "uppersorbian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "sorhyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Upper Sorbian Hyphenation Patterns (E. Werner)",
#	\message{Hyphenation patterns for Upper Sorbian, E. Werner}
#	\message{Completely new revision 1997, March 22}
},
# swedish		svhyph.tex
{
	"code" => "sv",
	"name" => "swedish",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "svhyph.tex",
	"hyphenmin" => [2,2], # patters say it could be 1,2; babel says 2,2 - double check
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Swedish hyphenation patterns (Jan Michael Rynning, 1994-03-03)",
},
# turkmen
{
	"code" => "tk",
	"name" => "turkmen",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => nil,
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Turkmen Hyphenation Patterns",
},
# turkish		xu-tkhyph.tex
{
	"code" => "tr",
	"name" => "turkish",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "tkhyph.tex",
	"hyphenmin" => [2,2], # polyglosia
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Turkish Hyphenation Patterns",
},
# ukenglish	ukhyphen.tex
# TODO - should we rename it or not?
{
	"code" => "en-gb",
	"name" => "ukenglish", "synonyms" => ["british", "UKenglish"],
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "ukhyphen.tex",
	"hyphenmin" => [2,3], # confirmed, same as what Knuth says
	"encoding" => "ascii",
	"exceptions" => true,
	"message" => "Hyphenation Patterns for British English",
},
# US english
{
	"code" => "en-us",
	"name" => "usenglishmax",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "ushyphmax.tex",
	"hyphenmin" => [2,3], # confirmed, same as what Knuth says
	"encoding" => "ascii",
	"exceptions" => true,
	"message" => "Hyphenation Patterns for American English",
},
# US english
# {
# 	"code" => "en-us-x-knuth",
# 	"name" => "english",
# 	"use_new_loader" => false,
# 	"use_old_patterns" => false,
# 	"filename_old_patterns" => "hyphen.tex",
# 	"hyphenmin" => [2,3], # confirmed, same as what Knuth says
# 	"encoding" => "ascii",
# 	"exceptions" => true,
# 	"message" => "Hyphenation Patterns for American English",
# },
# TODO: FIXME!!!
# serbian		xu-srhyphc.tex
{
	"code" => "sr-latn",
	"name" => "serbian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "shhyphl.tex",
	# It is allowed to leave one character at the end of the row.
	# However, if you think that it is graphicaly not very
	# pleasent these patterns will work well with \lefthyphenmin=2.
	# \lefthyphenmin=1 \righthyphenmin=2
	"hyphenmin" => [2,2],
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Serbian hyphenation patterns in Latin script",
},
# serbianc
{
	"code" => "sr-cyrl",
	"name" => "serbianc",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "srhyphc.tex",
	"hyphenmin" => [2,2],
	"encoding" => "t2a",
	"exceptions" => true,
	"message" => "Serbian hyphenation patterns in Cyrillic script",
},
# mongolian (used to be mongolian2a)
{
	"code" => "mn-cyrl",
	"name" => "mongolian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "mnhyphn.tex",
	"hyphenmin" => [2,2],
	"encoding" => "t2a",
	"exceptions" => false,
	"message" => "(New) Mongolian Hyphenation Patterns",
},
# mongolianlmc	xu-mnhyph.tex (used to be mongolian)
{
	"code" => "mn-cyrl-x-lmc",
	"name" => "mongolianlmc",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "mnhyph.tex",
	"hyphenmin" => [2,2],
	"encoding" => "lmc",
	"exceptions" => false,
	"message" => "Mongolian hyphenation patterns",
},
# bulgarian	xu-bghyphen.tex
{
	"code" => "bg",
	"name" => "bulgarian",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"filename_old_patterns" => "bghyphen.tex",
	"hyphenmin" => [2,2], # babel
	"encoding" => "t2a",
	"exceptions" => false,
	"message" => "Bulgarian Hyphenation Patterns",
},
# sanskrit
{
	"code" => "sa",
	"name" => "sanskrit",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,3], # polyglosia
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Sanskrit Hyphenation Patterns (v0.6, 2011/09/14)",
},
# norwegian	nohyph.tex
{
	"code" => "no",
	"name" => "norwegian", # TODO: fixme
	"use_new_loader" => false,
	"use_old_patterns" => false,
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => false,
	"message" => "Norwegian Hyphenation Patterns",
},
# norsk	xu-nohyphbx.tex
{
	"code" => "nb",
	"name" => "bokmal", "synonyms" => ["norwegian", "norsk"],
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Norwegian Bokmal Hyphenation Patterns",
},
# nynorsk	nnhyph.tex
{
	"code" => "nn",
	"name" => "nynorsk",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [2,2], # babel
	"encoding" => "ec",
	"exceptions" => true,
	"message" => "Norwegian Nynorsk Hyphenation Patterns",
},
#####
# assamese
{
	"code" => "as",
	"name" => "assamese",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Assameze Hyphenation Patterns",
},
# bengali
{
	"code" => "bn",
	"name" => "bengali",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Bengali Hyphenation Patterns",
},
# gujarati
{
	"code" => "gu",
	"name" => "gujarati",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Gujarati Hyphenation Patterns",
},
# hindi
{
	"code" => "hi",
	"name" => "hindi",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Hindi Hyphenation Patterns",
},
# kannada
{
	"code" => "kn",
	"name" => "kannada",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Kannada Hyphenation Patterns",
},
# malayalam
{
	"code" => "ml",
	"name" => "malayalam",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Malayalam Hyphenation Patterns",
},
# marathi
{
	"code" => "mr",
	"name" => "marathi",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Marathi Hyphenation Patterns",
},
# oriya
{
	"code" => "or",
	"name" => "oriya",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Oriya Hyphenation Patterns",
},
# panjabi
{
	"code" => "pa",
	"name" => "panjabi",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Panjabi Hyphenation Patterns",
},
# tamil
{
	"code" => "ta",
	"name" => "tamil",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Tamil Hyphenation Patterns",
},
# telugu
{
	"code" => "te",
	"name" => "telugu",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Telugu Hyphenation Patterns",
},
# lao
{
	"code" => "lo",
	"name" => "lao",
	"use_new_loader" => true,
	"use_old_patterns" => false,
	"hyphenmin" => [1,1], # TODO
	"encoding" => nil, # no patterns for 8-bit TeX
	"exceptions" => false,
	"message" => "Lao Hyphenation Patterns",
},
# dumylang -> dumyhyph.tex
# nohyphenation -> zerohyph.tex
# arabic -> zerohyph.tex
# farsi zerohyph.tex
# =persian
		]

		languages.each do |l|
			language = Language.new(l,pattern_path)
			@@list.push(language)
			self[language.code] = language
		end
	end
	
	def list
		return @@list
	end
end
