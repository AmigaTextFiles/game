# Kludgy makefile
#
# $Log: Makefile,v $
# Revision 1.2  1998/09/26 15:06:50  nobody
# Added Warp3D support
#
# Revision 1.1.1.1  1998/03/03 15:11:49  nobody
# reimport after crash from backup
#
# Revision 1.2  1998/02/13 23:14:24  hfrieden
# Added ranlib for lib
#
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libbios.a
LIB_OBJS=  \
	$(OBJDIR)/key.o $(OBJDIR)/mono.o \
	$(OBJDIR)/pcm.o $(OBJDIR)/joyc.o $(OBJDIR)/ipx.o \
	$(OBJDIR)/mouse.o $(OBJDIR)/timer.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
