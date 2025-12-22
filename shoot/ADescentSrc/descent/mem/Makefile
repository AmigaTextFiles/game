# Kludgy makefile
#
# $Lib$
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libmem.a
LIB_OBJS=  \
	$(OBJDIR)/mem.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
