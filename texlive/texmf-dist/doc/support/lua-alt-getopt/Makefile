PREFIX?=/usr/local
LUAVER?=5.1
LUAMODDIR?=${PREFIX}/lib/lua/${LUAVER}

##################################################

VERSION=		0.7.0
PROJECTNAME=		lua-alt-getopt
BIRTHDATE=		2009-01-10

FILES=			alt_getopt.lua
FILESDIR=		${LUAMODDIR}

INST_DIR?=		${INSTALL} -d

##################################################
.PHONY: install-dirs
install-dirs:
	$(INST_DIR) ${DESTDIR}${LUAMODDIR}

.PHONY: test
test:
	@echo 'running tests...'; \
	ln -f -s ${.CURDIR}/alt_getopt.lua ${.CURDIR}/tests; \
	export OBJDIR=${.OBJDIR}; \
	if cd ${.CURDIR}/tests && ./test.sh; \
	then echo '   succeeded'; \
	else echo '   failed'; false; \
	fi

.include <bsd.prog.mk>
