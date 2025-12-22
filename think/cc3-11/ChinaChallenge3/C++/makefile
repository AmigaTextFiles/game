
CC		= gcc

CFLAGS		= -O2 -msmall-code -fbaserel -fno-builtin

CXXFLAGS	= -V2.3.3 $(CFLAGS)

LFLAGS		= -noixemul -fbaserel

LDLIBS		= -lamiga -lmath

OBJS		= cc3.o stubs.o ../c/img.o ../c/alias.o

# the game :)

CC3:		$(OBJS)
		$(CC) $(LFLAGS) -o $@ $(OBJS) $(LDLIBS)
