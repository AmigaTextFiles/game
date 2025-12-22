# Kludgy makefile
#
# $Log: Makefile,v $
# Revision 1.2  1998/08/08 15:52:22  nobody
# Activated the Editor
#
# Revision 1.1.1.1  1998/03/03 15:11:46  nobody
# reimport after crash from backup
#
# Revision 1.2  1998/02/13 23:13:49  hfrieden
# Added ranlib for lib
#
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libgr.a
LIB_OBJS=  \
	$(OBJDIR)/palette.o $(OBJDIR)/gr.o $(OBJDIR)/canvas.o \
	$(OBJDIR)/pixel.o $(OBJDIR)/rect.o $(OBJDIR)/2dsline.o $(OBJDIR)/line.o \
	$(OBJDIR)/box.o $(OBJDIR)/poly.o $(OBJDIR)/disc.o $(OBJDIR)/gpixel.o \
	$(OBJDIR)/font.o $(OBJDIR)/bitmap.o $(OBJDIR)/bitblt.o $(OBJDIR)/pcx.o \
	$(OBJDIR)/rle.o $(OBJDIR)/scale.o $(OBJDIR)/ibitblt.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/scale.o: scale.c
	gcc $(CFLAGS) -O3 -fexpensive-optimizations $(INCLUDES) -o $@ -c $<

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
