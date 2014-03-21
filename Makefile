#$Id: Makefile,v 1.76 2001/07/12 01:27:19 guenther Exp $

# BASENAME should point to where the whole lot will be installed
# change BASENAME to your home directory if need be
BASENAME	= /usr
# For display in the man pages
VISIBLE_BASENAME= $(BASENAME)

# You can predefine ARCHITECTURE to a bin directory suffix
ARCHITECTURE	=
#ARCHITECTURE	=.sun4

BINDIR_TAIL	= bin$(ARCHITECTURE)
MANDIR		= $(DESTDIR)$(BASENAME)/share/man
BINDIR		= $(DESTDIR)$(BASENAME)/$(BINDIR_TAIL)
VISIBLE_BINDIR	= $(VISIBLE_BASENAME)/$(BINDIR_TAIL)
# MAN1SUFFIX for regular utility manuals
MAN1SUFFIX	=1
# MAN5SUFFIX for file-format descriptions
MAN5SUFFIX	=5
MAN1DIR		= $(MANDIR)/man$(MAN1SUFFIX)
MAN5DIR		= $(MANDIR)/man$(MAN5SUFFIX)

# Uncomment to install compressed man pages (possibly add extra suffix
# to the definitions of MAN?DIR and/or MAN?SUFFIX by hand)
#MANCOMPRESS = compress

############################*#
# Things that can be made are:
#
# help (or targets)	Displays this list you are looking at
# init (or makefiles)	Performs some preliminary sanity checks on your system
#			and generates Makefiles accordingly
# bins			Preinstalls only the binaries to ./new
# mans			Preinstalls only the man pages to ./new
# all			Does both
# install.bin		Installs the binaries from ./new to $(BINDIR)
# install.man		Installs the man pages from ./new to $(MAN[15]DIR)
# install		Does both
# recommend		Show some recommended suid/sgid modes
# install-suid		Impose the modes shown by 'make recommend'
# clean			Attempts to restore the package to pre-make state
# realclean		Attempts to restore the package to pre-make-init state
# deinstall		Removes any previously installed binaries and man
#			pages from your system by careful surgery
# procmail		Preinstalls just all procmail related stuff to ./new
# formail		Preinstalls just all formail related stuff to ./new
# lockfile		Preinstalls just all lockfile related stuff to ./new
# setid			Creates the setid binary needed by the SmartList
#			installation
######################*#

# Makefile.0 - mark, don't (re)move this, a sed script needs it

LOCKINGTEST=__defaults__

#LOCKINGTEST=/tmp .	# Uncomment and add any directories you see fit.
#			If LOCKINGTEST is defined, autoconf will NOT
#			prompt you to enter additional directories.
#			See INSTALL for more information about the
#			significance of the locking tests.

########################################################################
# Only edit below this line if you *think* you know what you are doing #
########################################################################

#LOCKINGTEST=100	# Uncomment (and change) if you think you know
#			it better than the autoconf lockingtests.
#			This will cause the lockingtests to be hotwired.
#			100	to enable fcntl()
#			010	to enable lockf()
#			001	to enable flock()
#			Or them together to get the desired combination.

# Optional system libraries we search for
SEARCHLIBS = -lm -ldir -lx -lsocket -lnet -linet -lnsl_s -lnsl_i -lnsl -lsun \
 -lgen -lsockdns -ldl
#			-lresolv	# not really needed, is it?

# Informal list of directories where we look for the libraries in SEARCHLIBS
LIBPATHS=/lib /usr/lib /usr/local/lib

GCC_WARNINGS = -O2 -pedantic -Wreturn-type -Wunused -Wformat -Wtraditional \
 -Wpointer-arith -Wconversion -Waggregate-return \
 #-Wimplicit -Wshadow -Wid-clash-6 #-Wuninitialized

# The place to put your favourite extra cc flag
CFLAGS0 = -O #$(GCC_WARNINGS)
LDFLAGS0= -s
# Read my libs :-)
LIBS=

CFLAGS1 = $(CFLAGS0) #-posix -Xp
LDFLAGS1= $(LDFLAGS0) $(LIBS) #-lcposix

####CC	= cc # gcc
# object file extension
O	= o
RM	= /bin/rm -f
MV	= mv -f
LN	= ln
BSHELL	= /bin/sh
INSTALL = cp
DEVNULL = /dev/null
STRIP	= strip
MKDIRS	= new/mkinstalldirs

SUBDIRS = src man
BINSS	= procmail lockfile formail mailstat
MANS1S	= procmail formail lockfile
MANS5S	= procmailrc procmailsc procmailex

# Possible locations for the sendmail.cf file
SENDMAILCFS = /etc/mail/sendmail.cf /etc/sendmail.cf /usr/lib/sendmail.cf

# Makefile.1 - mark, don't (re)move this, a sed script needs it

FGREP	= grep -F
STRIP	= 
CFLAGS	= $(CFLAGS1)
LDFLAGS	= $(LDFLAGS1) -lm -ldl -lc

BINS= new/procmail new/lockfile new/formail new/mailstat
MANS= new/procmail.1 new/formail.1 new/lockfile.1 new/procmailrc.5 new/procmailsc.5 new/procmailex.5
MANS1= procmail.$(MAN1SUFFIX) formail.$(MAN1SUFFIX) lockfile.$(MAN1SUFFIX)
MANS5= procmailrc.$(MAN5SUFFIX) procmailsc.$(MAN5SUFFIX) procmailex.$(MAN5SUFFIX)
MANSS= procmail.1 formail.1 lockfile.1 procmailrc.5 procmailsc.5 procmailex.5
NBINS= ../new/procmail ../new/lockfile ../new/formail ../new/mailstat
NMANS= ../new/procmail.1 ../new/formail.1 ../new/lockfile.1 ../new/procmailrc.5 ../new/procmailsc.5 ../new/procmailex.5

#$Id: Makefile.1,v 1.52 2001/07/12 01:27:20 guenther Exp $

all: bins mans recommend
	@echo If you would like to inspect the results before running make \
install:
	@echo All installable files can be found in the new/ subdirectory.

make:
	@$(SHELL) -c "exit 0"

.PRECIOUS: Makefile

help target targets:
	@sed "/^##*\*#$$/,/^##*\*#$$/ !d" <Makefile

bins: config.check src/Makefile
	cd src; $(MAKE) $(NBINS)

mans: config.check man/Makefile
	cd man; $(MAKE) $(NMANS)

procmail: config.check src/Makefile man/Makefile
	cd src; $(MAKE) ../new/$@ ../new/mailstat
	cd man; $(MAKE) ../new/$@.1 ../new/$@rc.5 ../new/$@ex.5 ../new/$@sc.5

mailstat: procmail

formail lockfile: config.check src/Makefile man/Makefile
	cd src; $(MAKE) ../new/$@
	cd man; $(MAKE) ../new/$@.1

setid multigram: config.check src/Makefile man/Makefile
	cd src; $(MAKE) $@

config.check: config.h
	echo Housekeeping file >$@
	@-if $(FGREP) -n -e '`' config.h $(DEVNULL) | $(FGREP) -v EOFName ; \
 then \
 echo;echo '   ^^^^^^^^^^^^^^^^^^^^ WARNING ^^^^^^^^^^^^^^^^^^^^^';\
      echo '   * Having backquotes in there could be unhealthy! *';\
 echo;fi;exit 0

recommend: src/Makefile
	@cd src; $(MAKE) $@
	@echo ================================================================\
===============
	@if $(FGREP) CF_no_procmail_yet autoconf.h >$(DEVNULL); \
 then echo If you are a system administrator you should consider \
integrating procmail; echo into the mail-delivery system -- for advanced \
functionality, speed AND; echo SECURITY "--.  For" more information about \
this topic you should look in the; echo examples/advanced file.; elif \
 cat $(SENDMAILCFS) 2>$(DEVNULL) | \
 grep 'Mlocal.*procmail.*F=[a-zA-Z]*u' >$(DEVNULL) ; then \
 echo The recommendation for the sendmail.cf entry of procmail has \
changed.; echo I suggest you remove the '`u'"'"-flag 'like in:'; echo ; \
 sed -n 's/.*\(Mlocal.*procmail.*F=[a-zA-Z]*\)u/\1/p' `if test -f \
 /etc/sendmail.cf; then echo /etc/sendmail.cf; else \
 echo /usr/lib/sendmail.cf; fi`; fi
	@echo
	@echo \
 "Also, HIGHLY RECOMMENDED (type 'make install-suid' to execute it):"
	@echo
	@src/$@ $(BINDIR)/procmail $(BINDIR)/lockfile >suid.sh
	@src/$@ $(BINDIR)/procmail $(BINDIR)/lockfile
	@echo ================================================================\
===============

suid.sh: recommend

install-suid: suid.sh install.bin
	@cat suid.sh
	@$(SHELL) ./suid.sh
	@cd $(BINDIR); echo Installed in $(BINDIR); ls -l $(BINSS)

$(MANS): mans

$(BINS): bins

$(BASENAME):
	$(MKDIRS) $(BASENAME)

install.man: $(MANS) $(BASENAME)
	@-$(MKDIRS) $(MANDIR) 2>$(DEVNULL); exit 0
	@-test -d $(MAN1DIR) || $(RM) $(MAN1DIR); exit 0
	@-$(MKDIRS) $(MAN1DIR) 2>$(DEVNULL); exit 0
	@-test -d $(MAN5DIR) || $(RM) $(MAN5DIR); exit 0
	@-$(MKDIRS) $(MAN5DIR) 2>$(DEVNULL); exit 0
	@chmod 0644 $(MANS)
	@for a in $(MANS1S); \
  do $(INSTALL) new/$$a.1 $(MAN1DIR)/$$a.$(MAN1SUFFIX) || exit 1; \
     if test "X$(MANCOMPRESS)" != "X"; \
     then $(MANCOMPRESS) -c new/$$a.1 >$(MAN1DIR)/$$a.$(MAN1SUFFIX); \
     else :; fi; \
  done
	@for a in $(MANS5S); \
  do $(INSTALL) new/$$a.5 $(MAN5DIR)/$$a.$(MAN5SUFFIX) || exit 1; \
     if test "X$(MANCOMPRESS)" != "X"; \
     then $(MANCOMPRESS) -c new/$$a.5 >$(MAN5DIR)/$$a.$(MAN5SUFFIX); \
     else :; fi; \
  done
	echo Housekeeping file >install.man

install.bin: $(BINS) $(BASENAME)
	@-$(MKDIRS) $(BINDIR) 2>$(DEVNULL); exit 0
	@chmod 0755 $(BINS)
	$(INSTALL) $(BINS) $(BINDIR)
	@-dirname / >$(DEVNULL) || $(INSTALL) examples/dirname $(BINDIR)
	echo Housekeeping file >install.bin

install:
	@$(MAKE) install.man install.bin
	@echo
	@cd $(BINDIR); echo Installed in $(BINDIR); ls -l $(BINSS)
	@cd $(MAN1DIR); echo Installed in $(MAN1DIR); ls -l $(MANS1)
	@cd $(MAN5DIR); echo Installed in $(MAN5DIR); ls -l $(MANS5)
	@$(MAKE) recommend

deinstall:
	@echo ============================= Deinstalling the procmail package.
	@$(RM) install.man install.bin
	@echo ============================= Checking if everything was removed:
	@-cd $(BINDIR); $(RM) $(BINSS); ls -l $(BINSS); exit 0
	@-cd $(MAN1DIR); $(RM) $(MANS1); ls -l $(MANS1); exit 0
	@-cd $(MAN5DIR); $(RM) $(MANS5); ls -l $(MANS5); exit 0
	@echo ============================= Ready.

clean: config.check
	-for a in $(SUBDIRS); do cd $$a; $(MAKE) $@; cd ..; done; exit 0
	cd SmartList; $(RM) targetdir.h targetdir.tmp install.list asked.patch
	$(RM) $(MANS) $(BINS) install.man install.bin suid.sh _Makefile \
 *core*

realclean: clean _init
	$(RM) config.check
	-for a in $(SUBDIRS); do $(MV) $$a/Makefile.init $$a/Makefile; done; \
 exit 0

veryclean clobber: realclean

_init:
	sed -e '/^# Makefile.1 - mark/,$$ d' <Makefile >_Makefile
	cat Makefile.0 >>_Makefile
	$(MV) _Makefile Makefile
	$(RM) Makefile.0

man/Makefile: man/Makefile.0 Makefile

src/Makefile: src/Makefile.0 Makefile

HIDEMAKE=$(MAKE)

man/Makefile src/Makefile Makefile: Makefile.1 initmake
	sed -e '/^# Makefile.1 - mark/,$$ d' <Makefile >_Makefile
	cat Makefile.0 >>_Makefile
	$(MV) _Makefile Makefile
	$(RM) Makefile.0
	$(HIDEMAKE) init

init makefiles Makefiles makefile: man/Makefile src/Makefile
