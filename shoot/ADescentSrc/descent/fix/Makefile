# Kludgy makefile
#
# $Lib$
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libfix.a
LIB_OBJS=  \
	$(OBJDIR)/fix.o $(OBJDIR)/tables.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) -O3 -fexpensive-optimizations $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
