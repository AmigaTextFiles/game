# Kludgy makefile
#
# $Lib$
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libeditor.a
LIB_OBJS=  \
	$(OBJDIR)/med.o $(OBJDIR)/einit.o $(OBJDIR)/eglobal.o \
	$(OBJDIR)/mine.o $(OBJDIR)/curves.o $(OBJDIR)/kcurve.o \
	$(OBJDIR)/khelp.o $(OBJDIR)/ksegsel.o $(OBJDIR)/kbuild.o \
	$(OBJDIR)/kview.o $(OBJDIR)/kmine.o $(OBJDIR)/seguvs.o \
	$(OBJDIR)/ksegsize.o $(OBJDIR)/ksegmove.o $(OBJDIR)/ktmap.o \
	$(OBJDIR)/kfuncs.o $(OBJDIR)/autosave.o $(OBJDIR)/group.o \
	$(OBJDIR)/texture.o $(OBJDIR)/fixseg.o $(OBJDIR)/eobject.o \
	$(OBJDIR)/elight.o $(OBJDIR)/texpage.o $(OBJDIR)/objpage.o \
	$(OBJDIR)/medmisc.o $(OBJDIR)/medsel.o $(OBJDIR)/kgame.o \
	$(OBJDIR)/info.o $(OBJDIR)/medwall.o $(OBJDIR)/eswitch.o \
	$(OBJDIR)/medrobot.o $(OBJDIR)/meddraw.o $(OBJDIR)/segment.o \
	$(OBJDIR)/ehostage.o $(OBJDIR)/centers.o $(OBJDIR)/func.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) $(INCLUDES)/editor -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
