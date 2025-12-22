# Kludgy makefile
#
# $Lib$
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libtexmap.a
LIB_OBJS=  \
	$(OBJDIR)/ntmap.o $(OBJDIR)/tmapflat.o $(OBJDIR)/scanline.o $(OBJDIR)/scanline_asm.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/scanline_asm.o: scanline.s
	SC CPU=68020 scanline.s ObjectName scanline_asm.o
	hunk2tobj scanline_asm.o
	mv t:obj.o $(OBJDIR)/scanline_asm.o
	rm scanline_asm.o

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) -O3 -fexpensive-optimizations $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
