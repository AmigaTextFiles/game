SOURCES = test2.c julia.c test24.c

EXE = $(SOURCES:.c=.elf)

OTHER = 

CC = ppc-amigaos-gcc -V egcs-2.90.29

LD = ppc-amigaos-ld

CODEGEN = -mcpu=604e -Wall -mmultiple -I../

OPTIMIZE = -O3 -funroll-loops

CFLAGS= $(CODEGEN) $(OPTIMIZE)

LIBPATH = ../

LIBS = -lpower -lgcc -lc

%.o : %.c
	$(CC) $(CFLAGS) -S $< -o $*.s
	$(CC) $(CFLAGS) -c $*.s -o $*.o

OBJS = $(SOURCES:.c=.o)

ASMS = $(SOURCES:.c=.s)

all : $(EXE)

$(EXE) : %.elf : %.o ../libpower.a
	$(LD) -r -s /ade/ppc-amigaos/lib/startup.o $< -L $(LIBPATH) $(LIBS) /ade/ppc-amigaos/lib/end.o -o $@
	protect $@ e add

depend : 
	mkdepend $(SOURCES) -fMakefile

clean :
	rm $(EXE) $(OBJS) $(ASMS) $(OTHER)
# --- DO NOT MODIFY THIS LINE -- AUTO-DEPENDS FOLLOW ---
julia.o :

test2.o :

test24.o :

# --- DO NOT MODIFY THIS LINE -- AUTO-DEPENDS PRECEDE ---
