# Makefile AmigaSetup for Duke3D (AmigaOS with GCC)

NAME		= AmigaSetup
CC		= gcc
CFLAGS		= -O2 -W 
LIBRARIES 	= -lnix

## Files
OBJS	=	src/main.o src/dukesetupgui.o src/mainsetup.o src/soundsetup.o \
		src/screensetup.o src/kbsetup.o src/mousesetup.o
 
$(NAME):	$(OBJS)
		$(CC) $(CFLAGS) -s -noixemul -o $@ $(OBJS) $(LIBRARIES)

all: $(NAME)

clean:
	@-delete $(OBJS)
	@-delete -f $(NAME)


src/main.o:		src/main.c src/dukesetupgui.h src/mainsetup.h src/soundsetup.h \
			src/screensetup.h src/kbsetup.h src/mousesetup.h src/amigasetupstructs.h
src/dukesetupgui.o:	src/dukesetupgui.c src/dukesetupgui.h src/amigasetupstructs.h
src/mainsetup.o:	src/mainsetup.c src/mainsetup.h src/dukesetupgui.h src/amigasetupstructs.h
src/soundsetup.o:	src/soundsetup.c src/soundsetup.h src/dukesetupgui.h src/amigasetupstructs.h
src/screensetup.o:	src/screensetup.c src/screensetup.h src/dukesetupgui.h src/amigasetupstructs.h
src/kbsetup.o:		src/kbsetup.c src/kbsetup.h src/dukesetupgui.h src/amigasetupstructs.h
src/mousesetup.o:	src/mousesetup.c src/mousesetup.h src/dukesetupgui.h src/amigasetupstructs.h
