
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


#$Id: Makefile.0,v 1.9 1994/09/27 15:03:36 berg Exp $

all: $(MANSS)

make:
	@$(SHELL) -c "exit 0"

.PRECIOUS: Makefile

../config.check:
	@cd ..; $(MAKE) config.check

man.sed: man_sed

man_sed:
	@cd ../src; $(MAKE) ../man/man.sed

clean:
	$(RM) $(MANSS) man.sed* _Makefile *core*

Makefile: ../Makefile Makefile.0
	@echo "You have made changes to the master Makefile, in order for"
	@echo "these changes to show through, you will first have to do:"
	@echo "$(MAKE) makefiles"

makefiles Makefiles makefile:
	cd ..; $(MAKE) makefiles

init:
	cd ..; $(MAKE) $@

../new/procmail.1: procmail.1 ../config.check
	@test -d ../new || mkdir ../new
	@$(RM) $@
	$(LN) ../man/procmail.1 $@

../new/formail.1: formail.1 ../config.check
	@test -d ../new || mkdir ../new
	@$(RM) $@
	$(LN) ../man/formail.1 $@

../new/lockfile.1: lockfile.1 ../config.check
	@test -d ../new || mkdir ../new
	@$(RM) $@
	$(LN) ../man/lockfile.1 $@

../new/procmailrc.5: procmailrc.5 ../config.check
	@test -d ../new || mkdir ../new
	@$(RM) $@
	$(LN) ../man/procmailrc.5 $@

../new/procmailsc.5: procmailsc.5 ../config.check
	@test -d ../new || mkdir ../new
	@$(RM) $@
	$(LN) ../man/procmailsc.5 $@

../new/procmailex.5: procmailex.5 ../config.check
	@test -d ../new || mkdir ../new
	@$(RM) $@
	$(LN) ../man/procmailex.5 $@

procmail.1: procmail.man man.sed mansed
	$(SHELL) ./mansed $(SHELL) procmail.man $@ "$(RM)" $(DEVNULL)

formail.1: formail.man man.sed mansed
	$(SHELL) ./mansed $(SHELL) formail.man $@ "$(RM)" $(DEVNULL)

lockfile.1: lockfile.man man.sed mansed
	$(SHELL) ./mansed $(SHELL) lockfile.man $@ "$(RM)" $(DEVNULL)

procmailrc.5: procmailrc.man man.sed mansed
	$(SHELL) ./mansed $(SHELL) procmailrc.man $@ "$(RM)" $(DEVNULL)

procmailsc.5: procmailsc.man man.sed mansed
	$(SHELL) ./mansed $(SHELL) procmailsc.man $@ "$(RM)" $(DEVNULL)

procmailex.5: procmailex.man man.sed mansed
	$(SHELL) ./mansed $(SHELL) procmailex.man $@ "$(RM)" $(DEVNULL)
#
