LIBDIR=../lib
OBJDIR=../objects

LIB=$(LIBDIR)/libkali.a
LIB_OBJS=  \
	$(OBJDIR)/ipx_kali.o $(OBJDIR)/linuxnet.o $(OBJDIR)/getextip.o \
	$(OBJDIR)/kali_serv.o

all: $(LIB)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)
	ranlib $(LIB)

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(LIB) $(LIB_OBJS)
