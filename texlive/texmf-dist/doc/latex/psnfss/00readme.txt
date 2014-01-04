------------------------------------------------------------
           PSNFSS 9.2 -- installation instructions
------------------------------------------------------------
                                                  2004-09-15
                                              Walter Schmidt
                               

Contents
--------

- Overview
- Removing obsolete files
- Installing the virtual fonts, metrics and .fd files
- Installing the PSNFSS macro packages
- Installing the documentation
- Fonts required for PSNFSS
- Font map files
- The encoding vector 8r.enc
- Extra packages required for PSNFSS
- Making sure that everything works
- Files from PSNFSS v7.x, which are no longer part of the
  distribution.



Overview
--------

PSNFSS, originally developed by Sebastian Rahtz, is a set of
LaTeX2e package files to use common PostScript text and
symbol fonts, together with packages for typesetting math
using virtual math fonts to match Times and Palatino.

The macro packages are useless without the font description
(fd) files, virtual fonts (vf) and font metric (tfm) files
for the font families used.  On CTAN, those for the Base 35
fonts are provided in the archive lw35nfss.zip.  The
metrics, fd's and font map files for the free Utopia,
Charter, FPL and Pazo fonts are provided in the archive file
freenfss.zip.

The PSNFSS collection does, however, NOT include the actual
PostScript fonts, i.e., the .pfb and .afm files.  See the
below section "Fonts required for PSNFSS" .

This document describes how to _install_ or _update_ PSNFSS.
Detailed instructions how to _use_ PSNFSS with LaTeX can be
found in the PDF document psnfss2e.pdf.



Removing obsolete files
-----------------------

* If your current version of PSNFSS is 7.0 or older, you
should remove manually _all_ macro files, .fd files, font
metrics and virtual fonts, that have to do with the PSNFSS
system or with the Base35, Utopia, Charter or Pazo fonts.

* If your current version of PSNFSS is 8.x or 9.1, delete
the files ot1fplmbb.fd and t1fplmbb.fd.  In a TDS-compliant
TeX system, they should reside in the directory
texmf/tex/latex/psnfss.

* Previous distributions of PSNFSS 9.0x would erroneously
comprise a number of files named *8a.tfm in the directory
texmf/fonts/tfm/adobe/palatino.  These files did not do any
harm, yet they are useless and should be deleted -- unless
you are using VTeX, which does require them.



Installing the virtual fonts, metrics and .fd files
---------------------------------------------------
Obtain the archive files lw35nfss.zip and freenfss.zip from
CTAN:macros/latex/required/psnfss.  If the file system
layout of your TeX system complies with TDS, unzip them in
the texmf root directory (usually named texmf) of your TeX
system; all files will be unpacked into the right
directories then.  Otherwise you have to sort out manually
the files from the .zip archives and copy them to the
appropriate directories of your TeX system.

The archives do _not_ include TFM files for the "raw" (= not
re-encoded) PostScript text fonts.  These files are required
by VTeX only (and they are not PSNFSS-specific, anyway).



Installing the PSNFSS macro packages
------------------------------------

Copy the files 

  00readme.txt
  changes.txt
  manifest.txt
  mathtest.tex
  pitest.tex
  psfonts.dtx
  psfonts.ins
  psnfss2e.tex
  test0.tex
  test1.tex
  test2.tex
  test3.tex

to a directory where you keep documented LaTeX sources.
In a TDS-compliant system this should be the directory

  texmf/source/latex/psnfss/ .

Run LaTeX on the installation script psfonts.ins to create
the package (.sty) files.  Move them to a directory where
LaTeX will find them.  In a TDS-compliant system this should
be the directory

  texmf/tex/latex/psnfss/ .

The latter step is executed automagically by the
installation script, provided that your DocStrip program has
been configured appropriately and the target directory
exists already.



Installing the documentation
----------------------------

Copy the documentation file psnfss2e.pdf to a suitable
directory; in a TDS-compliant system this should be

  texmf/doc/latex/psnfss .



Fonts required for PSNFSS
-------------------------

The "Base 35" fonts
  Free substitutes for the commercial PostScript Base fonts 
  are available from the CTAN directory fonts/urw/base35.
  
Adobe Utopia
Bitstream Charter
  The Type1 font files can be obtained for free from various
  sources, e.g., CTAN:fonts/utopia and CTAN:fonts/charter.

| The Utopia fonts are no longer a "required" component of
| the LaTeX system, because of their license conditions.
| Yet YOU MUST NOT OMIT the related font metrics and map
| file records, regardless of whether or not the Type1 font
| files are actually installed.  Thus, the user will be
| able to add the fonts without any further changes;
| besides, other packages or virtual fonts may rely on
| these TFMs.

FPL (=Palatino SC/OsF)
  Free substitutes for the commercial Palatino SC/OsF fonts
  are available from CTAN:fonts/fpl

Pazo 
  The Type1 fonts can be obtained from the CTAN directory
  fonts/mathpazo.  Notice that PSNFSS 9 needs version 1.003
  (2002-05-17) of the Pazo fonts.
  
Computer Modern
RSFS (Ralph Smith's Formal Script)
Euler Math
  These font families are required when typesetting math
  using the packages mathptm, mathptmx, mathpple, or
  mathpazo.  They are available in Type1 as well as METAFONT
  format Make sure to install at least the Type1 variants,
  possibly beside .mf.



Font map files
--------------

The following font map files (in a format that suits dvips
and pdfTeX) are provided in the PSNFSS distribution.  Use
them immediately or merge them into one common map file:

  psnfss.map:     for the Base35 fonts, eurmo10 and eurbo10
  charter.map:    for Bitstream Charter
  utopia.map:     for Adobe Utopia
  pazo.map        for the Pazo math fonts
  fpls.map        for the free substitutes (FPL) of the
                  Palatino SC/OsF fonts

psnfss.map is primarily destined for use with dvips.  The
entries for the fonts "eurmo10" and "eurbo10" may need to be
customized:  Feel free to change the /FontName's (EURM10 and
EURB10) to lower case, if you have got the Type1 fonts from
MicroPress rather than the BlueSky collection.  This
particular change is _not_ regarded as a violation of the
license conditions.

psnfss.map does _not_ make dvips embed the Base35 fonts.
For use with pdfTeX you will, most likely, have to create a
modified copy, which specifies embedding of all Base fonts.
The other map files are equally suitable for use with either
dvips or pdfTeX.

Other applications, such as VTeX, need a different format of
the font map files.  They may also require entries for the
raw (= not reencoded) fonts.  When creating these map files,
take those for dvips/pdfTeX as a model!



The encoding vector 8r.enc
--------------------------

Most Type1 text fonts, when used from TeX, are reencoded to
the so-called TeXBase1 encoding, in order to make all glyphs
accessible.  This is performed using the reencoding file

  8r.enc
  
which distributed with PSNFSS.  Consult the documentation of
your TeX system, where to store this file!

|
| PSNFSS 9.x includes version 2.0 of 8r.enc.  Make sure
| that there exist no other, obsolete, instances of 8r.enc
| in the applicable search path of your TeX system
|



Extra packages required for PSNFSS
----------------------------------

The "Graphics" bundle must be installed, since PSNFSS makes
use of the package keyval.sty.



Making sure that everything works
---------------------------------

Run the test following files through LaTeX:

  test0.tex
  test1.tex
  test2.tex
  test3.tex
  mathtest.tex 
  pitest.tex



Files from PSNFSS v7.x, which are no longer part of the
distribution
-------------------------------------------------------

The files to support the commercial Lucida Bright and
MathTime fonts are now distributed from the CTAN directories
macros/latex/contrib/psnfssx/ and fonts/metrics/bh/lucida/.


-- finis
