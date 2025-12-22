SOURCES = init.c display.c input.c c2p.c c2p24.c mem.c fileio.c

ARCHIVE = libpower.a

OTHER = 

CC = ppc-amigaos-gcc -V egcs-2.90.29

LD = ppc-amigaos-ld

AR = ppc-amigaos-ar

RANLIB = ppc-amigaos-ranlib

CODEGEN = -mcpu=604e -Wall -I/ade/os-includeppc -mmultiple

OPTIMIZE = -O3 -funroll-loops -ffast-math

CFLAGS= $(CODEGEN) $(OPTIMIZE)

LIBS =

%.o : %.c
	$(CC) $(CFLAGS) -S $< -o $*.s
	$(CC) $(CFLAGS) -c $*.s -o $*.o

OBJS = $(SOURCES:.c=.o)

ASMS = $(SOURCES:.c=.s)

$(ARCHIVE) : $(OBJS)
	$(AR) r $@ $?
	$(RANLIB) $@

depend : 
	mkdepend $(SOURCES) -fMakefile

clean :
	rm $(ARCHIVE) $(OBJS) $(ASMS) $(OTHER)
# --- DO NOT MODIFY THIS LINE -- AUTO-DEPENDS FOLLOW ---
c2p.o : c2p.h display.h

c2p24.o : c2p.h display.h

display.o : display.h c2p.h power.h

fileio.o : power.h

init.o : power.h

input.o : display.h power.h

mem.o : power.h

# --- DO NOT MODIFY THIS LINE -- AUTO-DEPENDS PRECEDE ---
