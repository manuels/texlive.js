00readme.txt for AMS document classes amsart/book/proc 2.20.1 [2009/07/02]

See manifest.txt for a list of all the files in the distribution.

See install.txt for installation instructions.

The document classes amsart, amsbook, amsproc and related packages are
provided by the American Mathematical Society for authors to use with
LaTeX. They produce the overall layout and appearance of AMS
publications.

In order to use an AMS document class you need to have TeX software
installed first. TeX is not an AMS product. If you need information on
getting TeX see one of the following:

  http://www.tug.org/
  http://www.ams.org/tex/tex-resources.html

Documentation for the AMS document classes is found in

  instr-l.pdf
  diffs-c.txt
  amsthdoc.pdf
  thmtest.tex
  thmtest.pdf

which are included in the collection.  Additional documentation can be
found in the amsclass FAQ:

  http://www.ams.org/tex/amsclass-faq.html

The recommended procedure for making a custom document class based on an
AMS class is to make a copy of the relevant .cls file using a different
name and edit the copy---e.g., copy amsbook.cls to mybook.cls. (In
general we advise against using \LoadClass, unless the base class is
frozen or changes to the base class are under your control.)

For technical support:

  American Mathematical Society
  Technical Support
  Publications Technical Group
  P. O. Box 6248
  Providence, RI 02940-6248
  Phone: 800-321-4AMS (321-4267) (USA/Canada) or 401-455-4080
  tech-support@ams.org

========================================================================
RECENT CHANGES

---amsclass.dtx 2.20.1 2009/07/02
Added 2010 as a valid version of the Mathematics Subject Classification.
========================================================================
PREVIOUS CHANGES

---ams-c1.ins 2.20 2004/08/03
Added amsmidx package.

---amsclass.dtx 2.20 2004/08/06
1. Added facility for additional line(s) in copyright block.
2. Corrected handling of section heading with no title.
3. Got rid of spurious "Appendix" in t-of-c in \backmatter.
4. Changed MR number formatting to use new style as on MathSciNet.
5. Created commands for various style elements and substituted them
   for hard-coded values to simplify building derived classes.
6. Added sectioning and otherwise cleaned up commentary.

---amsclass.faq - 2004/08/06
Removed from distribution; replaced by on-line FAQ at
http://www.ams.org/tex/amsclass-faq.html

---amsdtx.dtx 2.06 2004/08/06
1. Reworked indexing commands for compatibility with doc.sty.
2. Added option environment for enhanced indexing.
3. Improved formatting.

---amsthdoc.tex 2.20 2004/08/03
1. Substantially rewritten for clarity.
2. Added documentation for \newtheoremstyle.

---instr-l.tex 2.20 2004/08/05
Substantially rewritten for clarity and to add instructions for new
features; see note on amsclass.dtx regarding features.

---mrabbrev.bib - 2004/08/05
Removed from distribution; this is now available separately from
http://www.ams.org/tools/mrabbrev.bib 

---thmtest.tex 2.01 2004/08/02
1. Corrected counter for theorems with switched headers.
2. Added section headings for clarity.
3. Added example ending with a display and \qedhere.

---upref.dtx 2.01 2004/07/29
1. Added code to make package work with hyperref.
2. Improved documentation.

---amsclass.dtx 2.14 2004/04/26 (not released)
1. Incorporated pending changes left by Michael Downes:
  - Added trap in headings in case \thanks was set within \author,
    and added \thanks@warning.
  - Cleaned up and completed unfinished documentation.
2. Added braces in \uppercasenonmath to limit scope.
3. Added \contrib mechanism to handle "non-author" authors.
4. Segregated definitions of administrative footnotes to permit easier
   customization for AMS journals.
5. Added explicit \bibliofont to permit easy change for special uses.
6. Changed MR number formatting to correspond to new access numbers
   used by MathSciNet.
7. Added \@citestyle and \citeform to simplify font changes in citations.
8. Added OT1 defaults for \DH, \dh, \DJ, \dj, required for author names.
9. Added \markleft to permit changing of only left running head

---amsclass.dtx 2.13 2002/12/04 (not released)
1. Fixed handling of theorem head punctuation with \swapnumbers.
2. Changed \proofname to \providecommand in case it's already defined.
3. Made \small, \Small, etc., robust.
4. Better spacing in \l@figure to prevent overprinting of figure number.
5. Changed handling of author names to prevent internal line breaks.
6. Added \@noparitemfalse in \dth@everypar to prevent weird results in
   certain (rare) kinds of usage.
7. Some other cosmetic changes.

---amsthdoc.tex 2.02 2000/06/06
Use article class instead of amsldoc (which is overkill).

---amsldoc.cls - 2000/06/06
Removed from distribution, no longer needed by amsthdoc.

---amsclass.dtx 2.07 2000/06/05
Guard against \\ in argument of \author.

---amsclass.dtx 2.06 2000/06/02
Avoid using \@elt in qed stack because LaTeX output routine falls over
if triggered when something else is using \@elt.

---amsclass.dtx 2.05 2000/05/16
1. Added \indexintro.
2. Fixed erroneous init for thm@preskip, thm@postskip.

---amsclass.dtx 2.04 2000/03/10
\newtoks fix for old versions of LaTeX. Added some commentary about \cal.

---amsclass.dtx 2.03 2000/01/17
1. Removed dependency on amsgen package.
2. Added a warning about graphics for the draft option.
3. Improved qedhere handling for article/amsthm combination.

---amsclass.dtx 2.02 2000/01/17
Some fixes for the fleqn/qedhere case.
========================================================================
