# Kludgy makefile
#
# $Log: Makefile,v $
# Revision 1.6  1998/09/26 15:05:47  nobody
# Added Warp3D support
#
# Revision 1.5  1998/08/08 15:52:34  nobody
# Activated the Editor
#
# Revision 1.4  1998/04/02 13:41:55  tfrieden
# *** empty log message ***
#
# Revision 1.3  1998/03/27 00:52:46  tfrieden
# *** empty log message ***
#
# Revision 1.2  1998/03/24 21:48:55  tfrieden
# *** empty log message ***
#
# Revision 1.1.1.1  1998/03/03 15:11:49  nobody
# reimport after crash from backup
#
# Revision 1.2  1998/02/13 23:13:59  hfrieden
# Added ranlib for lib
#
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/lib3d.a
LIB_OBJS=  \
	$(OBJDIR)/clipper.o $(OBJDIR)/horizon.o $(OBJDIR)/matrix.o $(OBJDIR)/rod.o \
	$(OBJDIR)/draw.o $(OBJDIR)/instance.o $(OBJDIR)/points.o $(OBJDIR)/setup.o \
	$(OBJDIR)/globvars.o $(OBJDIR)/interp.o $(OBJDIR)/points_fpu.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/points_fpu.o: points_fpu.c
	gcc  -DWANT_IPX  -O3 -fexpensive-optimizations -m68060 -m68881 $(INCLUDES) -o $(OBJDIR)/points_fpu.o -c points_fpu.c -fbaserel32 -fomit-frame-pointer

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
