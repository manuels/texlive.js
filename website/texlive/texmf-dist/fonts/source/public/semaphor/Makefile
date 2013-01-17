# Semafor font (c) 1998-2008 Vit Zyka
# Generation: (with Metatype1)
#   make         (old_lig := true)
#   make cp-tfm
#   make         (old_lig := false)
#   make example
#   make all-otf (on cygwin with FontForge)
#   make cp

PILAR := smfr10 smfb10 smfsl10 smfbsl10 smftt10

EMPTY := smfer10 smfeb10 smfesl10 smfebsl10 smfett10

PERSON := smfpr10 smfpb10 smfpsl10 smfpbsl10 smfptt10

FONTS = $(PILAR) $(EMPTY) $(PERSON)

PFB_FONTS = $(addsuffix .pfb, $(FONTS))
AFM_FONTS = $(PFB_FONTS:.pfb=.afm)
OTF_FONTS = $(PFB_FONTS:.pfb=.otf)

RM_EXT     := *.aux *.log *.bak *.clg *.cnt *.lo1 *.lo2
RM_ALL_EXT := $(RM_EXT) *.*~ *~ *.dvi *.pdf *.map *.enc *.pfb *.pfm *.afm *.tfm *.otf

all: $(PFB_FONTS)
	cat *.map > semaf.map

all-otf: $(OTF_FONTS)

$(foreach a,$(join $(addsuffix :,$(FONTS)),$(PFB_FONTS)),$(eval $(a)))

.SUFFIXES: .mp .pfb .afm .otf
.PHONY: touch copy clean cleanall test example $(OTF_FONTS)

.SECONDEXPANSION:

$(PFB_FONTS): $$*.mp semaf.mp
	mkfont1 $*

$(OTF_FONTS): #$$*.mp semaf.mp
	fontforge -script pfb2otf.pe $*.pfb

TDS_BASE :=  ./texmf
CTAN_BASE := ./distr/semaf
CP_VENDOR := public/semaf

copy:
	cp *.afm $(TDS_BASE)/fonts/afm/$(CP_VENDOR)
	cp *.pfb *.pfm $(TDS_BASE)/fonts/type1/$(CP_VENDOR)
	cp *.otf $(TDS_BASE)/fonts/opentype/$(CP_VENDOR)
	cp *.mp Makefile README pfb2otf.pe $(TDS_BASE)/fonts/source/$(CP_VENDOR)
	cp semaf.map $(TDS_BASE)/fonts/map/dvips
	cp *.enc $(TDS_BASE)/fonts/enc/dvips
	cp semaf.tex $(TDS_BASE)/tex/plain/semaf
	cp *.fd $(TDS_BASE)/tex/latex/semaf
	cp t-type-*.tex $(TDS_BASE)/tex/context/third/semaf
	cp example.tex example.pdf $(TDS_BASE)/doc/fonts/$(CP_VENDOR)
	cp test-context.tex test-context.pdf $(TDS_BASE)/doc/fonts/$(CP_VENDOR)
	cp README $(TDS_BASE)/doc/fonts/$(CP_VENDOR)
	#cp *.tfm $(TDS_BASE)/fonts/tfm/$(CP_VENDOR)
	#cp *.tfm $(CTAN_BASE)/support/tfm
	cp *.afm *.pfb *.pfm $(CTAN_BASE)/type1
	cp *.otf $(CTAN_BASE)/opentype
	cp README $(CTAN_BASE)
	cp test-context.pdf $(CTAN_BASE)/test-semaf.pdf
	cp *.mp Makefile pfb2otf.pe $(CTAN_BASE)/metatype1
	cp semaf.map *.enc $(CTAN_BASE)/support
	cp semaf.tex *.fd t-type-*.tex $(CTAN_BASE)/support
	cp example.tex example.pdf $(CTAN_BASE)/doc
	cp test-context.tex test-context.pdf $(CTAN_BASE)/doc

touch:
	touch *.mp

test:
	-pdfclose --file smf.pdf
	pdftex smf.tex
	-pdfopen --file smf.pdf

example:
	-pdfclose --file example.pdf
	pdftex example.tex
	-pdfopen --file example.pdf

context:
	texmfstart texexec test-context

RM = rm -f

clean:
	$(RM) $(wildcard $(RM_EXT))

clean-all:
	$(RM) $(wildcard $(RM_ALL_EXT))
