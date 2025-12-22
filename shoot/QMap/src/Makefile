SOURCES = 3d.c bsp.c clippoly.c poly.c render.c surface.c tmap3d.c tm_c.c main.c mode.c \
	readbsp.c

EXE = qmap.elf

OTHER = 

CC = ppc-amigaos-gcc -V egcs-2.90.29

LD = ppc-amigaos-ld

STRIP = ppc-amigaos-strip

CODEGEN = -mcpu=604e -Wall -D__BIG_ENDIAN__ -mmultiple

OPTIMIZE = -O3 -Ipower/ -funroll-loops

CFLAGS= $(CODEGEN) $(OPTIMIZE)

LIBPATH = power

LIBS = -lpower -lgcc -lc

%.o : %.c
	$(CC) $(CFLAGS) -S $< -o $*.s
	$(CC) $(CFLAGS) -c $*.s -o $*.o

OBJS = $(SOURCES:.c=.o)

ASMS = $(SOURCES:.c=.s)

$(EXE) : $(OBJS) power/libpower.a
	$(LD) -r -s /ade/ppc-amigaos/lib/startup.o $(OBJS) -L $(LIBPATH) $(LIBS) /ade/ppc-amigaos/lib/end.o -o $@
	protect $@ e add

depend : 
	mkdepend $(SOURCES) -fMakefile

clean :
	rm $(EXE) $(OBJS) $(ASMS) $(OTHER)

# --- DO NOT MODIFY THIS LINE -- AUTO-DEPENDS FOLLOW ---
3d.o : bspfile.h 3d.h cmdlib.h fix.h s.h

bsp.o : render.h bsp.h 3d.h bspfile.h fix.h s.h cmdlib.h

clippoly.o : 3d.h bspfile.h fix.h s.h cmdlib.h

main.o : poly.h surface.h bsp.h render.h tm.h scr.h fix.h 3d.h mode.h \
    bspfile.h s.h cmdlib.h

mode.o : mode.h s.h

poly.o : surface.h tmap3d.h tm.h 3d.h fix.h bspfile.h s.h cmdlib.h

readbsp.o : mode.h bspfile.h cmdlib.h

render.o : poly.h scr.h bsp.h render.h 3d.h bspfile.h fix.h s.h cmdlib.h

surface.o : tmap3d.h surface.h bspfile.h tm.h s.h cmdlib.h fix.h

tm_c.o : tm.h fix.h s.h

tmap3d.o : tm.h tmap3d.h bspfile.h 3d.h fix.h cmdlib.h s.h

# --- DO NOT MODIFY THIS LINE -- AUTO-DEPENDS PRECEDE ---
