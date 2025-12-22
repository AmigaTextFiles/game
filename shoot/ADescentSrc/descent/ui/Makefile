# Kludgy makefile
#
# $Lib$
#

LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libui.a
LIB_OBJS=  \
	$(OBJDIR)/ui.o $(OBJDIR)/ui_mouse.o $(OBJDIR)/window.o \
	$(OBJDIR)/uidraw.o $(OBJDIR)/button.o \
	$(OBJDIR)/gadget.o $(OBJDIR)/listbox.o $(OBJDIR)/message.o \
	$(OBJDIR)/popup.o $(OBJDIR)/scroll.o \
	$(OBJDIR)/radio.o $(OBJDIR)/checkbox.o $(OBJDIR)/inputbox.o \
	$(OBJDIR)/userbox.o $(OBJDIR)/ui_menu.o \
	$(OBJDIR)/file.o $(OBJDIR)/keytrap.o $(OBJDIR)/icon.o \
	$(OBJDIR)/keypress.o $(OBJDIR)/menubar.o $(OBJDIR)/keypad.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
