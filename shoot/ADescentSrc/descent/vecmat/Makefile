# Kludgy makefile
#
# $Lib$
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libvecmat.a
LIB_OBJS=  \
	$(OBJDIR)/vecmat.o $(OBJDIR)/vecmat_asm.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/vecmat_asm.o: vecmat.s
	SC CPU=68020 math=8 vecmat.s ObjectName tmp.o
	hunk2tobj tmp.o
	mv t:obj.o $(OBJDIR)/vecmat_asm.o
	rm tmp.o

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) -O3 -fexpensive-optimizations $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
