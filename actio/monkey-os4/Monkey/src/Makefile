NAME   = sdlmonkey.gpe
O      = o
RM     = rm -f
CC     = arm-linux-gcc
CXX    = arm-linux-g++
STRIP  = arm-linux-strip
SDL_BASE = C:/devkitGP2X/bin/arm-linux-

PROG   = $(NAME)

all: $(PROG)

#FAME_CORE=1

DEFAULT_CFLAGS = `$(SDL_BASE)sdl-config --cflags`
LDFLAGS        = `$(SDL_BASE)sdl-config --libs` -lSDL_mixer -lSDL -lm -lc -lmikmod -static 


MORE_CFLAGS = -O3  -Isrc/ -Isrc/include/ -Isrc/menu -Isrc/vkbd -fomit-frame-pointer  -Wno-unused -Wno-format -DUSE_SDL -DGCCCONSTFUNC="__attribute__((const))" -DUSE_UNDERSCORE -fno-exceptions -DUNALIGNED_PROFITABLE -DREGPARAM="__attribute__((regparm(3)))" -DOPTIMIZED_FLAGS -D__inline__=__inline__ -DSHM_SUPPORT_LINKS=0 -DOS_WITHOUT_MEMORY_MANAGEMENT -DVKBD_ALWAYS



CFLAGS  = $(DEFAULT_CFLAGS) $(MORE_CFLAGS)

OBJS =	\
	background.o \
	ball.o \
	game.o \
	graphics.o \
	main.o


CPPFLAGS  = $(CFLAGS)

$(PROG): $(OBJS) 
	$(CXX) $(CFLAGS) -o $(PROG) $(OBJS) $(LDFLAGS)
	$(STRIP) $(PROG)


run: $(PROG)
	./$(PROG)

clean:
	$(RM) $(PROG) $(OBJS)


