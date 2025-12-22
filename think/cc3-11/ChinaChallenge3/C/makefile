
CC		= gcc

CFLAGS		= -V2.3.3 -O2 -msmall-code -fbaserel -fno-builtin

LFLAGS		= -noixemul -fbaserel

LDLIBS		= -lamiga -lmath

OBJS		= cc3.o img.o alias.o

# the game :)

CC3:		$(OBJS)
		$(CC) $(LFLAGS) -o $@ $(OBJS) $(LDLIBS)
