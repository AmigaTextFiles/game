
#
#	Makefile fuer ZIP
#

.c.o:
	cc $(CFLAGS) $*.c

OBJS		= control.o extern.o fileio.o input.o interpre.o \
		  math.o memory.o object.o operand.o property.o \
		  screen.o text.o variable.o zip.o
LIBS		= -lc

TERM		= amiga

CFLAGS		= -ms -wrunc -so
LFLAGS		= -m +q

all:		zip

zip:		$(OBJS) $(TERM)io.o
		ln -o $@ $(LFLAGS) $(OBJS) $(TERM)io.o $(LIBS)

amigaio.o:	amigaio.c ztypes.h 
control.o:	control.c ztypes.h 
extern.o:	extern.c ztypes.h 
fileio.o:	fileio.c ztypes.h 
input.o:	input.c ztypes.h 
interpre.o:	interpre.c ztypes.h 
math.o:		math.c ztypes.h 
memory.o:	memory.c ztypes.h 
object.o:	object.c ztypes.h 
operand.o:	operand.c ztypes.h 
osdepend.o:	osdepend.c ztypes.h 
property.o:	property.c ztypes.h 
screen.o:	screen.c ztypes.h 
text.o:		text.c ztypes.h 
variable.o:	variable.c ztypes.h 
zip.o:		zip.c ztypes.h 

