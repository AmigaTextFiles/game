# Kludgy makefile
#
# $Log: Makefile,v $
# Revision 1.1.1.1  1998/03/03 15:11:50  nobody
# reimport after crash from backup
#
# Revision 1.2  1998/02/13 23:14:40  hfrieden
# Added ranlib for lib
#
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libcfile.a
LIB_OBJS=  \
	$(OBJDIR)/cfile.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
