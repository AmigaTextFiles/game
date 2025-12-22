# gcc 4.x
AR				=	ar
CC				=	gcc -m68020 -m68881 #-noixemul
CHMOD			=	chmod
CXX			=	g++ -m68020 -m68881 #-noixemul
RANLIB		=	ranlib
RM				=	rm -f
STRIP			=	strip

#------------------------------------------------------------------------------#

DIR_DATA		=	PROGDIR:data
VERSION		=	1.1.0

#------------------------------------------------------------------------------#

CFLAGS		=	-g -O2 -Wall `sdl-config2 --cflags` -DDATADIR=\"$(DIR_DATA)\" -D_VER=\"$(VERSION)\" -D__MORPHOS__

LDFLAGS		=	-lSDL_ttf -lfreetype -lz -lSDL_mixer `sdl-config2 --libs` -lm

#------------------------------------------------------------------------------#

SRC			=	gfx.cpp \
					hex_puzzzle.cpp \
					i18n.cpp \
					sfx.cpp \
					system-directory.c \
					system-relative.c \
					text.cpp


OBJ			=	$(patsubst %.c,%.o, $(filter %c, $(SRC)))
OBJ			+=	$(patsubst %.cpp,%.o, $(filter %cpp, $(SRC)))


BIN			=	Hex-a-Hop

#------------------------------------------------------------------------------#

all:		$(BIN)



$(BIN):		$(OBJ)
			$(CXX) $(OBJ) -o $@.db $(LDFLAGS)
			$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
			$(CHMOD) u+x $@


%.o:			%.c
			$(CC) $(CFLAGS) -c $< -o $@

%.o:			%.cpp
			$(CXX) $(CFLAGS) -c $< -o $@

#------------------------------------------------------------------------------#

clean:
		$(RM) $(BIN) $(BIN).db $(OBJ)
