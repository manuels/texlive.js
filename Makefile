SOURCE_DIR=pdftex-1.40.11
PDFTEX_URL=http://mirrors.ctan.org/obsolete/systems/pdftex/pdftex-1.40.11.zip
BASE_TEXLIVE_URL=http://mirrors.ctan.org/macros/latex/base.zip
#BASE_TEXLIVE_URL=ftp://ftp.ctan.org/pub/tex/macros/latex/base.zip
SHELL=bash
all: pdftex-worker.js create_latex_format texlive.lst
#all: unpack_pdftex create_binary_pdftex configure get_texlive unpack_texlive create_latex_format compile_bc compile_js

pdftex-1.40.11.zip:
	wget $(PDFTEX_URL)

unpack_pdftex: pdftex-1.40.11.zip
	unzip -o pdftex-1.40.11.zip

configure: unpack_pdftex
	-@cd ${SOURCE_DIR} && \
	EMCONFIGURE_JS=0 emconfigure ./build-pdftex.sh -C \
		--disable-all-pkgs \
		--enable-pdftex \
		--enable-static \
		CC=emcc CFLAGS=-DELIDE_CODE

texlive.lst: ./texlive
	find texlive -type d -exec echo {}/. \; | sed 's/^texlive//g' >texlive.lst
	find texlive -type f | sed 's/^texlive//g' >>texlive.lst

./binary/${SOURCE_DIR}/build-pdftex/texk/web2c/pdftex: pdftex-1.40.11.zip
	mkdir -p binary
	cd binary && wget $(PDFTEX_URL)
	cd binary && unzip -o pdftex-1.40.11.zip
	cd binary && cd ${SOURCE_DIR} && ./build-pdftex.sh -C \
		--disable-all-pkgs \
		--enable-pdftex \
		--enable-static

install-tl-unx.tar.gz:
	wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

./texlive: install-tl-unx.tar.gz
	mkdir -p texlive
	cd texlive && tar xzvf ../install-tl-unx.tar.gz
	echo selected_scheme scheme-basic > texlive/profile.input
	echo TEXDIR `pwd`/texlive >> texlive/profile.input
	echo TEXMFLOCAL `pwd`/texlive/texmf-local >> texlive/profile.input
	echo TEXMFSYSVAR `pwd`/texlive/texmf-var >> texlive/profile.input
	echo TEXMFSYSCONFIG `pwd`/texlive/texmf-config >> texlive/profile.input
	echo TEXMFVAR `pwd`/home/texmf-var >> texlive/profile.input

	cd texlive && ./install-tl-*/install-tl -profile profile.input
	echo "Removing unnecessary files"
	cd texlive && rm -rf bin readme* tlpkg install* *.html texmf-dist/doc texmf-var/web2c
	echo ""
	echo "Done! Please run 'make texlive.lst' now!"

./latex_format/base.zip:
	mkdir -p latex_format
	cd latex_format && wget ${BASE_TEXLIVE_URL} && unzip -o base.zip

create_latex_format: ./latex_format/base.zip ./binary/${SOURCE_DIR}/build-pdftex/texk/web2c/pdftex ./texlive
	mkdir -p latex_format
	cd latex_format && unzip -o base.zip
	cd latex_format/base && ../../binary/${SOURCE_DIR}/build-pdftex/texk/web2c/pdftex -ini -etex unpack.ins
	touch latex_format/base/hyphen.cfg
	cd latex_format/base && ../../binary/${SOURCE_DIR}/build-pdftex/texk/web2c/pdftex -ini -etex latex.ltx
	mkdir -p ./texlive/texmf-var/web2c/pdftex/
	cp latex_format/base/latex.fmt ./texlive/texmf-var/web2c/pdftex/

compile_bc:	 ./binary/${SOURCE_DIR}/build-pdftex/texk/web2c/pdftex configure ./texlive
	find texlive -mindepth 2 -name texmf.cnf -exec cp {} ./${SOURCE_DIR}/src/texk/kpathsea \;
	cp ./binary/${SOURCE_DIR}/build-pdftex/texk/web2c/web2c/{fixwrites,web2c,splitup} ${SOURCE_DIR}/build-pdftex/texk/web2c/web2c/
	chmod +x ${SOURCE_DIR}/build-pdftex/texk/web2c/web2c/fixwrites
	chmod +x ${SOURCE_DIR}/build-pdftex/texk/web2c/web2c/web2c
	chmod +x ${SOURCE_DIR}/build-pdftex/texk/web2c/web2c/splitup

	cp ./binary/${SOURCE_DIR}/build-pdftex/texk/web2c/{ctangle,tangle,tie,pdftex-pool.c} ${SOURCE_DIR}/build-pdftex/texk/web2c/
	chmod +x ${SOURCE_DIR}/build-pdftex/texk/web2c/ctangle
	chmod +x ${SOURCE_DIR}/build-pdftex/texk/web2c/tie
	chmod +x ${SOURCE_DIR}/build-pdftex/texk/web2c/tangle

	-cd ${SOURCE_DIR}/build-pdftex/texk/web2c && emmake make pdftex  -o tangle -o tie -o web2c -o pdftex-pool.c


compile_kpathsea: configure
	-cd ${SOURCE_DIR}/build-pdftex/texk/kpathsea && make clean
	-cd ${SOURCE_DIR}/build-pdftex/texk/kpathsea && emmake make CC=emcc CFLAGS=-DELIDE_CODE

compile_lib: configure
	-cd ${SOURCE_DIR}/build-pdftex/texk/web2c/lib && make clean
	-cd ${SOURCE_DIR}/build-pdftex/texk/web2c/lib && emmake make CC=emcc CFLAGS=-DELIDE_CODE

pdftex-worker.js: compile_bc compile_lib compile_kpathsea
	opt -strip-debug ${SOURCE_DIR}/build-pdftex/texk/web2c/pdftex >pdftex.bc
	OBJFILES=$$(for i in `find ${SOURCE_DIR}/build-pdftex/texk/web2c/lib ${SOURCE_DIR}/build-pdftex/texk/kpathsea -name '*.o'` ; do llvm-nm $$i | grep main >/dev/null || echo $$i ; done) && \
		emcc  --memory-init-file 0 -v --closure 1 -s TOTAL_MEMORY=67108864 -O3  $$OBJFILES pdftex.bc -s INVOKE_RUN=0 --pre-js pre.js --post-js post.js -o pdftex-worker.js
#		emcc -v --minify 0 --closure 0 -s FS_LOG=1 -s TOTAL_MEMORY=67108864 -O2 -g3 $$OBJFILES pdftex.bc -s INVOKE_RUN=0 --pre-js pre.js --post-js post.js -o pdftex-worker.js

clean:
	rm -f pdftex-worker.js
	rm -f latex.fmt
	rm -f pdftex.bc
	rm -f texlive.lst
	rm -rf ${SOURCE_DIR} pdftex-1.40.11.zip
	rm -rf binary
	rm -rf latex_format
	rm -rf texlive
	rm -f install-tl-unx.tar.gz

ifeq ("x","y")
--------------------------------
configure' configures TeX Live 2010-07-20 to adapt to many kinds of systems.

Usage: /home/manuel/Projekte/pdflatex2/pdftex-1.40.11/src/configure [OPTION]... [VAR=VALUE]...

To assign environment variables (e.g., CC, CFLAGS...), specify them as
VAR=VALUE.  See below for descriptions of some of the useful variables.

Defaults for the options are specified in brackets.

Configuration:
	-h, --help              display this help and exit
			--help=short        display options specific to this package
			--help=recursive    display the short help of all the included packages
	-V, --version           display version information and exit
	-q, --quiet, --silent   do not print 'checking...' messages
			--cache-file=FILE   cache test results in FILE [disabled]
	-C, --config-cache      alias for '--cache-file=config.cache'
	-n, --no-create         do not create output files
			--srcdir=DIR        find the sources in DIR [configure dir or '..']

Installation directories:
	--prefix=PREFIX         install architecture-independent files in PREFIX
													[/usr/local]
	--exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
													[PREFIX]


For better control, use the options below.

Fine tuning of the installation directories:
	--bindir=DIR            user executables [EPREFIX/bin]
	--sbindir=DIR           system admin executables [EPREFIX/sbin]
	--libexecdir=DIR        program executables [EPREFIX/libexec]
	--sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
	--sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
	--localstatedir=DIR     modifiable single-machine data [PREFIX/var]
	--libdir=DIR            object code libraries [EPREFIX/lib]
	--includedir=DIR        C header files [PREFIX/include]
	--oldincludedir=DIR     C header files for non-gcc [/usr/include]
	--datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
	--datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
	--infodir=DIR           info documentation [DATAROOTDIR/info]
	--localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
	--mandir=DIR            man documentation [DATAROOTDIR/man]
	--docdir=DIR            documentation root [DATAROOTDIR/doc/tex-live]
	--htmldir=DIR           html documentation [DOCDIR]
	--dvidir=DIR            dvi documentation [DOCDIR]
	--pdfdir=DIR            pdf documentation [DOCDIR]
	--psdir=DIR             ps documentation [DOCDIR]

Program names:
	--program-prefix=PREFIX            prepend PREFIX to installed program names
	--program-suffix=SUFFIX            append SUFFIX to installed program names
	--program-transform-name=PROGRAM   run sed PROGRAM on installed program names

X features:
	--x-includes=DIR    X include files are in DIR
	--x-libraries=DIR   X library files are in DIR

System types:
	--build=BUILD     configure for building on BUILD [guessed]
	--host=HOST       cross-compile to build programs to run on HOST [BUILD]

Optional Features:
	--disable-option-checking  ignore unrecognized --enable/--with options
	--disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
	--enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
	--disable-missing       terminate if a requested program or feature must be
													disabled, e.g., due to missing libraries
	--disable-all-pkgs      do not build packages unless explicitly enabled
	--disable-native-texlive-build
													do not build for the TeX Live binary distribution
	--enable-multiplatform  put executables into bin/PLATFORM and libraries into
													lib/PLATFORM
	--enable-cxx-runtime-hack  link C++ runtime statically
	--enable-libtool-hack   ignore libtool dependency_libs
	--disable-chktex        do not build the chktex package
	--disable-dialog        do not build the dialog package
	--disable-ps2eps        do not build the ps2eps package
	--disable-psutils       do not build the psutils package
	--disable-t1utils       do not build the t1utils package
	--disable-tpic2pdftex   do not build the tpic2pdftex package
	--disable-vlna          do not build the vlna package
	--enable-xindy          build the xindy package
	--enable-xindy-rules      build and install make-rules package
	--enable-xindy-docs       build and install documentation
	--disable-xpdfopen      do not build the xpdfopen package
	--disable-web2c         do not build the web2c (TeX & Co.) package
	--enable-auto-core        cause TeX&MF to dump core, given a certain
														filename
	--disable-dump-share      make fmt/base/mem files architecture-dependent
	--disable-ipc             disable TeX's --ipc option, i.e., pipe to a
														program
	--disable-omfonts         do not compile and install omfonts (use Web2C
														versions)
	--disable-tex             do not compile and install TeX
	--enable-etex             compile and install e-TeX
	--disable-ptex            do not compile and install pTeX
	--disable-aleph           do not compile and install Aleph
	--disable-pdftex          do not compile and install pdfTeX
	--disable-luatex          do not compile and install luaTeX
	--disable-xetex           do not compile and install XeTeX
	--disable-mf              do not build METAFONT
	--disable-mf-nowin          do not build a separate non-windows-capable
															METAFONT
	--enable-epsfwin            include EPSF pseudo window support
	--enable-hp2627win          include HP 2627 window support
	--enable-mftalkwin          include mftalk (generic server) window support
	--enable-nextwin            include NeXT window support
	--enable-regiswin           include Regis window support
	--enable-suntoolswin        include old Suntools (not X) window support
	--enable-tektronixwin       include Tektronix window support
	--enable-unitermwin         include Uniterm window support
	--disable-mp              do not build METAPOST
	--disable-web-progs       do not build WEB programs bibtex ... weave
	--disable-afm2pl        do not build the afm2pl package
	--disable-bibtex8       do not build the bibtex8 package
	--disable-bibtexu       do not build the bibtexu package
	--disable-cjkutils      do not build the cjkutils package
	--disable-detex         do not build the detex package
	--disable-devnag        do not build the devnag package
	--disable-dtl           do not build the dtl package
	--disable-dvi2tty       do not build the dvi2tty package
	--disable-dvidvi        do not build the dvidvi package
	--disable-dviljk        do not build the dviljk package
	--disable-dvipdfmx      do not build the dvipdfmx package
	--disable-dvipng        do not build the dvipng package
	--disable-debug           Compile without debug (-d) option
	--enable-timing           Output execution time of dvipng
	--disable-dvipos        do not build the dvipos package
	--disable-dvipsk        do not build the dvipsk package
	--disable-dvisvgm       do not build the dvisvgm package
	--disable-gsftopk       do not build the gsftopk package
	--disable-lacheck       do not build the lacheck package
	--disable-lcdf-typetools
													do not build the lcdf-typetools package
	--disable-cfftot1         do not build the cfftot1 program
	--disable-mmafm           do not build the mmafm program
	--disable-mmpfb           do not build the mmpfb program
	--disable-otfinfo         do not build the otfinfo program
	--disable-otftotfm        do not build the otftotfm program
	--disable-t1dotlessj      do not build the t1dotlessj program
	--disable-t1lint          do not build the t1lint program
	--disable-t1rawafm        do not build the t1rawafm program
	--disable-t1reencode      do not build the t1reencode program
	--disable-t1testpage      do not build the t1testpage program
	--disable-ttftotype42     do not build the ttftotype42 program
	--disable-auto-cfftot1    disable running cfftot1 from otftotfm
	--disable-auto-t1dotlessj disable running t1dotlessj from otftotfm
	--disable-auto-ttftotype42
														disable running ttftotype42 from otftotfm
	--disable-auto-updmap     disable running updmap from otftotfm
	--disable-makeindexk    do not build the makeindexk package
	--disable-makejvf       do not build the makejvf package
	--disable-mendexk       do not build the mendexk package
	--disable-musixflx      do not build the musixflx package
	--disable-ps2pkm        do not build the ps2pkm package
	--disable-seetexk       do not build the seetexk package
	--disable-tex4htk       do not build the tex4htk package
	--disable-ttf2pk        do not build the ttf2pk package
	--disable-ttfdump       do not build the ttfdump package
	--disable-xdv2pdf       do not build the xdv2pdf package
	--disable-xdvik         do not build the xdvik package
	--disable-xdvipdfmx     do not build the xdvipdfmx package
	--disable-tetex         do not build the tetex (teTeX scripts) package
	--disable-texlive       do not build the texlive (TeX Live scripts) package
	--disable-mktexmf-default   do not run mktexmf if MF source missing
	--disable-mktexpk-default   do not run mktexpk if PK font missing
	--disable-mktextfm-default  do not run mktextfm if TFM file missing
	--disable-mkocp-default     do not run mkocp if OCP file missing
	--disable-mkofm-default     do not run mkofm if OFM file missing
	--disable-mktexfmt-default  do not run mktexfmt if format file missing
	--enable-mktextex-default   run mktextex if TeX source missing
	--disable-dependency-tracking  speeds up one-time build
	--enable-dependency-tracking   do not reject slow dependency extractors
	--enable-maintainer-mode  enable make rules and dependencies not useful
													(and sometimes confusing) to the casual installer
	--enable-shared[=PKGS]  build shared libraries [default=yes]
	--enable-static[=PKGS]  build static libraries [default=yes]
	--enable-fast-install[=PKGS]
													optimize for fast installation [default=yes]
	--disable-libtool-lock  avoid locking (might break parallel builds)
	--disable-largefile     omit support for large files
	--enable-compiler-warnings=[no|min|yes|max|all]
													Turn on compiler warnings [default: yes if
													maintainer-mode, min otherwise]

Optional Packages:
	--with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
	--without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
	--with-clisp-runtime=PATH
													pathname of clisp runtime to install for 'xindy',
													'default' to derive from clisp, or 'system' to use
													installed version
	--with-recode           use 'recode' instead of 'iconv' to build xindy
													[default: no]
	--with-banner-add=STR   add STR to version string appended to banner lines
	--with-editor=CMD       invoke CMD from the 'e' option [vi +%d %s]
	--without-mf-x-toolkit  do not use X toolkit for METAFONT
	--with-gs=/PATH/TO/gs   Hard-wire the location of GhostScript
	--with-system-libgs     build dvisvgm with installed gs headers and library
													[default: no]
	--with-libgs-includes=DIR
													libgs headers installed in DIR
	--with-libgs-libdir=DIR libgs library installed in DIR
	--with-xdvi-x-toolkit=KIT
													Use toolkit KIT (motif/xaw/xaw3d/neXtaw) for xdvi
													[default: Motif if available, else Xaw]
	--with-system-icu       use installed ICU headers and libraries (requires
													icu-config, not for XeTeX)
	--with-system-teckit    use installed teckit headers and library
	--with-teckit-includes=DIR
													teckit headers installed in DIR
	--with-teckit-libdir=DIR
													teckit library installed in DIR
	--without-graphite      build XeTeX without graphite support
	--with-system-graphite  use installed silgraphite headers and library
													(requires pkg-config)
	--with-system-zziplib   use installed zziplib headers and library (requires
													pkg-config)
	--with-system-xpdf      use installed poppler headers and library instead of
													xpdf (requires pkg-config)
	--with-system-gd        use installed gd headers and library
	--with-gd-includes=DIR  gd headers installed in DIR
	--with-gd-libdir=DIR    gd library installed in DIR
	--with-system-freetype2 use installed freetype2 headers and library
													(requires freetype-config)
	--with-system-freetype  use installed freetype headers and library
	--with-freetype-includes=DIR
													freetype headers installed in DIR
	--with-freetype-libdir=DIR
													freetype library installed in DIR
	--with-system-t1lib     use installed t1lib headers and library
	--with-t1lib-includes=DIR
													t1lib headers installed in DIR
	--with-t1lib-libdir=DIR t1lib library installed in DIR
	--with-system-libpng    use installed libpng headers and library
	--with-libpng-includes=DIR
													libpng headers installed in DIR
	--with-libpng-libdir=DIR
													libpng library installed in DIR
	--with-system-zlib      use installed zlib headers and library
	--with-zlib-includes=DIR
													zlib headers installed in DIR
	--with-zlib-libdir=DIR  zlib library installed in DIR
	--with-system-ptexenc   use installed ptexenc headers and library
	--with-ptexenc-includes=DIR
													ptexenc headers installed in DIR
	--with-ptexenc-libdir=DIR
													ptexenc library installed in DIR
	--with-system-kpathsea  use installed kpathsea headers and library
	--with-kpathsea-includes=DIR
													kpathsea headers installed in DIR
	--with-kpathsea-libdir=DIR
													kpathsea library installed in DIR
	--with-pic              try to use only PIC/non-PIC objects [default=use
													both]
	--with-gnu-ld           assume the C compiler uses GNU ld [default=no]
	--with-x                use the X Window System
	--without-ln-s          do build even if 'ln -s' does not work

Some influential environment variables:
	CC          C compiler command
	CFLAGS      C compiler flags
	LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
							nonstandard directory <lib dir>
	LIBS        libraries to pass to the linker, e.g. -l<library>
	CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
							you have headers in a nonstandard directory <include dir>
	CPP         C preprocessor
	XMKMF       Path to xmkmf, Makefile generator for X Window System
	CXX         C++ compiler command
	CXXFLAGS    C++ compiler flags
	CXXCPP      C++ preprocessor

Use these variables to override the choices made by 'configure' or to help
it to find libraries and programs with nonstandard names/locations.
endif
