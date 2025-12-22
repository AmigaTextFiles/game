CC = gcc
CFLAGS = -O2 -Iglk -Iglk/bn
PRODUCT = AROSGlulxe

GLKSRC = glk/gi_blorb.c glk/gi_dispa.c glk/cgunicod.c glk/gtblorb.c \
         glk/gtevent.c glk/gtfref.c glk/gtgestal.c glk/gtinput.c \
         glk/gtmessag.c glk/gtmessin.c glk/gtmisc.c glk/gtschan.c \
         glk/gtstream.c glk/gtstyle.c glk/gtw_blnk.c glk/gtw_buf.c \
         glk/gtw_grid.c glk/gtw_pair.c glk/gtwindow.c glk/amiga.c
GLKOBJ = $(GLKSRC:.c=.o)

BNSRC = glk/bn/bn_asm.c glk/bn/bn_lib.c glk/bn/bn_shift.c glk/bn/bn_word.c
BNOBJ = $(BNSRC:.c=.o)

GLULXSRC = glulxe/accel.c glulxe/exec.c glulxe/files.c glulxe/float.c \
           glulxe/funcs.c glulxe/gestalt.c glulxe/glkop.c glulxe/heap.c \
           glulxe/main.c glulxe/operand.c glulxe/profile.c glulxe/search.c \
           glulxe/serial.c glulxe/string.c glulxe/vm.c glulxe/amiga.c
GLULXOBJ = $(GLULXSRC:.c=.o)

$(PRODUCT) : $(GLULXOBJ) $(GLKOBJ) $(BNOBJ)
	$(CC) -o $(PRODUCT) $(GLULXOBJ) $(GLKOBJ) $(BNOBJ) $(LDFLAGS)

clean :
	rm -f $(GLULXOBJ) $(GLKOBJ) $(BNOBJ)
