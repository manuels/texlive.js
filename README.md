texlive.js
==========

This is a port of TeX live 2012 to Javascript. It is based on my port of the pdftex TeX compiler to Javascript using emscripten.
It creates PDF files from LaTeX code and supports (some) packages.

Supported Packages
------------------

To use packages in texlive.js, the corresponding package file must be downloaded *before* compilation, otherwise pdftex will not be able to find these files.

For adding support for new packages, find out which files are required by this package (e.g. by running `strace -e open pdflatex test.tex` on your computer for some test file that uses the package). Then add these files to texlive.js (see [for example the entries for the geometry package](https://github.com/manuels/texlive.js/blob/master/website/texlive.js#L55)).

Currently supported packages:

 * geometry
 * graphicx
 * begriff

Related Projects
----------------
[bibtex.js](https://github.com/brianmingus/bibtex.js/) - bibtex ported to javascript
[ep_latex](https://github.com/manuels/ep_latex) - etherpad-lite plugin for texlive.js
