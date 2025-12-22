# Kludgy makefile
#
# $Lib$
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libcf.a
LIB_OBJS=  \
	$(OBJDIR)/lzw.o $(OBJDIR)/bitio.o $(OBJDIR)/library.o

all: $(LIB) #pslib

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) -O3 -fexpensive-optimizations $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)

#pslib: $(LIB)
#    gcc $(CFLAGS) $(INCLUDES) pslib.c -o pslib -l$(LIB)
