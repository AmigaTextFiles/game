#
# ``pinfocom'' datafile interpreter makefile
#
# $Header: /usr/opt/contrib/infocom/info/RCS/Makefile,v 3.0 1992/10/21 16:58:31 pds Stab pds $
#

#
# The first half of this makefile should be edited to build on your
# particular system.  For MS-DOS and Amiga systems, see the section for
# your system below and uncomment the variable declarations.
#
# Alternatively you might consider using one of the following make
# targets to configure automatically.  The default is to configure for
# UNIX with termcap and termio.
#
#	stream		- configures for simple stream io
#
#	sysv		- configures for UNIX with terminfo and termio
#	bsd		- configures for UNIX with termcap and sgtty
#	posix		- configures for UNIX with terminfo and termios
#

#----------------------------------------------------------------------
#
# Set PRODUCT to be the name of the program to create, and the
# directories to install it into:

PRODUCT = pinfo

PROGRAM = $(PRODUCT)

ROOTDIR = /usr/local
BINDIR  = $(ROOTDIR)/bin
MANDIR  = $(ROOTDIR)/man/man1

# Hopefully make sets this to something sane...
#CC=cc

LD=$(CC)

CDEBUG=-O

O       = o

CP      = cp
INSTALL = install -c -o bin -g bin
#INSTALL = $(CP)


#----------------------------------------------------------------------
#
# Set the following if you're on a UNIX system and need special
# commands to format your man pages (default just copies the unformatted
# pages).

BIN_CHAPTER = 1
LIB_CHAPTER = 3

MAKEMAN =
#MAKEMAN = | nroff -Tlp -man | col
#MAKEMAN = | groff -Tlatin1 -man -et | pr -o5 -t | col

#----------------------------------------------------------------------
#
# Set any host-specific flags here:
#
# - On Xenix/286 or Xenix/386 add -Ox and -CSON.
#
# - On Data General DG/UX systems compiling with TERMINFO support, add
#   -D_SYSV3_BAUD_RATE_FLAVOR or -D_POSIX_BAUD_RATE_FLAVOR (it doesn't
#   matter which).
#
# - set -DNEED_ERRNO since your errno.h doesn't include an
#   "extern int errno;" (MIPS systems running BSD)
#
# - set -DNO_STRERROR if you don't have the strerror() function
#
# - set -DNO_SIGNALS if you don't want any signals caught (Amiga's)
#
# - set -DMAXPATHLEN=nn if your max path len <1024 (80 for MS-DOS)
#
# - set -DAZTEC_C_BUG if you're using the Aztec C compiler on an Amiga
#   (see comment in support.c:change_status() for more details)

HFLAGS=

#----------------------------------------------------------------------
#
# Fill in any host-specific libraries you may need here (I doubt you'll
# need any; besides the terminal emulation there's nothing used except
# the standard C runtime library)

HLIBS=

#----------------------------------------------------------------------
#
# If you don't want real random numbers (cheat!:-) or don't have any
# time function uncomment this line.  If your time function isn't
# time() then edit infocom.c:seed_random().

RANDOM=
#RANDOM=-DNO_RANDOM

#----------------------------------------------------------------------
#
# To set the default context lines to something other than 2, change
# the value of this line:

CONTEXT=2

#----------------------------------------------------------------------
#
# To set the default right margin to something other than 2, change
# the value of this line:

RMARGIN=2

#----------------------------------------------------------------------
#
# To set the default left margin to something other than 0, change
# the value of this line (note that game prompts are not indented, only
# output descriptions):

LMARGIN=0

#----------------------------------------------------------------------
#
# If you want the interpreter to look for particular game files if one
# is not given on the command line, fill in the names and extensions here
# Note that the command line name name will be tried, then with all
# extensions, then the first name in FNAME_LST, then with all extensions,
# etc.

SQUOTE='

FNAME_LST=$(SQUOTE)"story","Story"$(SQUOTE)
FEXT_LST=$(SQUOTE)".dat",".Dat",".data",".Data"$(SQUOTE)

#----------------------------------------------------------------------
#
# Give the extension you'd like to have added to the game name to
# create the default save file name.

SAVE_EXT=$(SQUOTE)".sav"$(SQUOTE)

#----------------------------------------------------------------------
#
# Choose either SCRIPT_FILE *or* SCRIPT_EXT, *not* both.  This controls
# the default output name for script files.  If the default is to be a
# lineprinter or something with a set filename (say "PRT:") then set
# SCRIPT_FILE to that filename.  If the default is to be a disk file
# the set SCRIPT_EXT to be an extension which will be tacked onto the
# game name to create the default (a la SAVE_EXT, above).

SCRIPT_EXT=-DSCRIPT_EXT=$(SQUOTE)".scr"$(SQUOTE)

#----------------------------------------------------------------------
#
# This is the escape character recognized by the interpreter.  Change
# it if you like.

ESC_CHAR=$(SQUOTE)"@"$(SQUOTE)

#----------------------------------------------------------------------
#
# If you don't have getopt(3), uncomment this line:

#GETOPT=getopt.$O

#----------------------------------------------------------------------
#
# If you're not on a UNIX or other system with termcap or terminfo
# support, comment out all these lines and skip to the next section.

# Set the appropriate flags for the type of UNIX terminal support
# you want.  You must choose at least one of USE_TERMCAP or
# USE_TERMINFO.
#
#   -DUSE_TERMCAP       Use termcap (best if you have it)
#   -DUSE_TERMINFO      Use terminfo
#   -DUSE_TERMIO        SysV: Use termio line discipline control
#   -DUSE_TERMIOS       POSIX: Use termios line discipline control
#   -DUSE_SGTTY         BSD: Use sgtty line discipline control
#   -DNO_SHELL_ESC      Don't allow shell escapes
#   -DUSE_READLINE      Use the GNU readline library (also put -I<dir>
#                       if necessary to find the header files).

TERMTYPE=termcap

TERMFLAGS=-DUSE_TERMCAP -DUSE_TERMIO

# If using the readline library, uncomment this line:

#TERMOBJS=readline.$O

# Fill in libraries needed for terminal support: common ones are
# -ltermcap or -lcurses; if you're using the GNU readline library also
# specify -lreadline and, if necessary, a -L option to point to the
# GNU readline library directory.

TERMLIBS=-ltermcap

#----------------------------------------------------------------------
#
# If you're compiling for an Amiga, uncomment these and set them up.

#TERMTYPE=amiga
#TERMFLAGS=
#TERMOBJS=amiga_data.o amiga_sound.o amiga_console.o amiga_clip.o\
#	 amiga_script.o amiga_game.o
#TERMLIBS=-lc -lamiga

#CP=copy
#INSTALL=copy
#CONTEXT=1
#RMARGIN=0
#SQUOTE=
#FNAME_LST="Story"
#FEXT_LST=".Dat",".Data"
#SAVE_EXT=".Save"
#SCRIPT_FILE=-DSCRIPT_FILE="PRT:"
#GETOPT=getopt.o

# These are for use with GCC
#CC=gcc
#HFLAGS=-DNO_SIGNALS -fbaserel

# These are for use with Aztec C
#CC=cc
#LD=ln
#HFLAGS=-DNO_SIGNALS -DAZTEC_C_BUG


#----------------------------------------------------------------------
#
# If you're compiling for MS-DOS, uncomment all of these; they override
# the default settings above.
#
# The objects and libraries below are for Turbo C.

#MODEL=c		# compact memory model (64K code, 1MB data)
#LIBDIR=\bc\lib\	# directory containing your compiler's libraries

#TERMTYPE=msdos
#TERMFLAGS=
#TERMOBJS=$(LIBDIR)c0$(MODEL).obj
#TERMLIBS=$(LIBDIR)c$(MODEL)

#PROGRAM=$(PRODUCT).exe
#O=obj
#CP=copy
#INSTALL=copy
#SQUOTE=
#HFLAGS=-DMAXPATHLEN=80
#FNAME_LST="story"
#FEXT_LST=".dat"
#GETOPT=getopt.obj

#CC=bcc			# Use with Turbo C
#CC=cl			# Use with Microsoft C

#LD=tlink		# Use with Turbo C
#LD=link		# Use with other C compilers


#----------------------------------------------------------------------
#
# If you don't have any of the other supported terminal types,
# uncomment this line to get simple stream output.  Note that you will
# not get a status line in this case.

#TERMTYPE=stream
#TERMFLAGS=
#TERMOBJS=
#TERMLIBS=


###########################################################################
#
# Shortcut configuration targets:
#
# this can be changed if you like, or used as an FYI to change items above
#

SHELL=sh
MAKE=make

all: $(PROGRAM)

# Stream I/O:

stream:
	$(MAKE) TERMTYPE=stream

# UNIX systems:  note you'll have to set up GNU readline support yourself
#   if you want it: see the comments in the termcap TERMTYPE section above

sysv:
	$(MAKE) TERMFLAGS="-DUSE_TERMINFO -DUSE_TERMIO"

bsd:
	$(MAKE) TERMFLAGS="-DUSE_TERMCAP -DUSE_SGTTY"

posix:
	$(MAKE) TERMFLAGS="-DUSE_TERMINFO -DUSE_TERMIOS"


###########################################################################
#
# You shouldn't need to change anything after this point:
#

CFLAGS  = $(CDEBUG) $(HFLAGS)
IFLAGS  = -DCONTEXT=$(CONTEXT) -DRMARGIN=$(RMARGIN) -DLMARGIN=$(LMARGIN) $(RANDOM)
FFLAGS  = -DFNAME_LST=$(FNAME_LST) -DFEXT_LST=$(FEXT_LST) -DSAVE_EXT=$(SAVE_EXT) $(SCRIPT_FILE) $(SCRIPT_EXT)

OBJECTS = $(TERMOBJS) $(TERMTYPE).$O file.$O funcs.$O infocom.$O init.$O\
	  input.$O interp.$O jump.$O object.$O options.$O page.$O print.$O\
	  property.$O support.$O variable.$O $(GETOPT)

LIBS    = $(TERMLIBS) $(HLIBS)

MPAGES  = $(PRODUCT).$(BIN_CHAPTER) pinfo_ti.$(LIB_CHAPTER)


# This is for very losing makes...
.c.$O:
	$(CC) $(CFLAGS) -c $*.c

$(PRODUCT): $(OBJECTS)
	$(LD) $(CDEBUG) $(HFLAGS) $(LFLAGS) -o $(PRODUCT) $(OBJECTS) $(LIBS)

$(PRODUCT).exe: $(OBJECTS)
	$(LD) $(LFLAGS) $(OBJECTS), $(PRODUCT).exe,, $(LIBS);

infocom.$O: infocom.c Makefile
	$(CC) $(CFLAGS) $(IFLAGS) -c infocom.c

file.$O: file.c Makefile
	$(CC) $(CFLAGS) $(FFLAGS) -c file.c

$(TERMTYPE).$O: $(TERMTYPE).c Makefile
	$(CC) $(CFLAGS) $(TERMFLAGS) -DESC_CHAR=$(ESC_CHAR) -c $(TERMTYPE).c

readline.$O: readline.c Makefile
	$(CC) $(CFLAGS) $(TERMFLAGS) -DESC_CHAR=$(ESC_CHAR) -c readline.c

amiga_data.o: amiga_data.c amiga_global.h patchlevel.h infocom.h\
		amiga_data.h amiga_protos.h
	$(CC) $(CFLAGS) $(TERMFLAGS) $(FFLAGS) -c amiga_data.c

$(PRODUCT).$(BIN_CHAPTER): pinfo.man
	cat pinfo.man $(MAKEMAN) > $@

pinfo_ti.$(LIB_CHAPTER): pinfo_ti.man
	cat pinfo_ti.man $(MAKEMAN) > $@

man: $(MPAGES)

clean:
	rm -f *.o *~ core $(PRODUCT) $(MPAGES)

install: $(PROGRAM)
	$(INSTALL) $(PROGRAM) $(BINDIR)/$(PROGRAM)

install.man: $(MPAGES)
	$(INSTALL) $(PRODUCT).$(BIN_CHAPTER) $(MANDIR)/$(PRODUCT).$(BIN_CHAPTER)
	$(INSTALL) pinfo_ti.$(LIB_CHAPTER) $(MANDIR)/pinfo_ti.$(LIB_CHAPTER)

.PHONY: all clean man install install.man stream amiga msdos sysv bsd posix

#
# Dependencies generated with gcc -MM *.c
#
pinfo_ti.$(LIB_CHAPTER): pinfo_ti.man
$(PRODUCT).$(BIN_CHAPTER): pinfo.man

file.$O : file.c infocom.h 
funcs.$O : funcs.c infocom.h 
infocom.$O : infocom.c infocom.h patchlevel.h 
init.$O : init.c infocom.h 
input.$O : input.c infocom.h 
interp.$O : interp.c infocom.h 
jump.$O : jump.c infocom.h 
object.$O : object.c infocom.h 
options.$O : options.c infocom.h 
page.$O : page.c infocom.h 
print.$O : print.c infocom.h 
property.$O : property.c infocom.h 
support.$O : support.c infocom.h patchlevel.h 
variable.$O : variable.c infocom.h 

stream.$O : stream.c infocom.h
msdos.$O : msdos.c infocom.h
termcap.o : termcap.c infocom.h
readline.$O : readline.c infocom.h
amiga.o : amiga.c amiga_global.h patchlevel.h infocom.h amiga_data.h\
	  amiga_protos.h
amiga_sound.o : amiga_sound.c amiga_global.h patchlevel.h infocom.h\
		amiga_data.h amiga_protos.h
amiga_console.o : amiga_console.c amiga_global.h patchlevel.h infocom.h\
		  amiga_data.h amiga_protos.h
amiga_clip.o : amiga_clip.c amiga_global.h patchlevel.h infocom.h amiga_data.h\
               amiga_protos.h
amiga_script.o : amiga_script.c amiga_global.h patchlevel.h infocom.h\
		 amiga_data.h amiga_protos.h
amiga_game.o : amiga_game.c amiga_global.h patchlevel.h infocom.h amiga_data.h\
               amiga_protos.h
