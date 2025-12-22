CC:=gcc

OBJS := \
	main.o \
	CCarObject.o \
	CEnemyCarObject.o \
	CEnemyFastCarObject.o \
	CEnemyNormalCarObject.o \
	CEnemyRacerCarObject.o \
	CEnemySlidderCarObject.o \
	CEnemyTruckObject.o \
	CExplosionObject.o \
	CFuelObject.o \
	CGame.o \
	CObject.o \
	configuration.o \
	CPlayerCarObject.o \
	CRoadFighter.o \
	CSemaphoreObject.o \
	CTile.o \
	gameover_state.o \
	interlevel_state.o \
	konami_state.o \
	loadmg2.o \
	menu_state.o \
	playing_state.o \
	presentation_state.o \
	quick_tables.o \
	sound.o \
	auxiliar.o

all: rf

%.o: %.cpp
	$(CC) -c -O3 $< -o $@ `sdl-config --cflags` -I/usr/local/include/SDL

# dynamically linked binary:
rf: $(OBJS)
	$(CC) $^ -o $@ `sdl-config --libs` -lSDL_image -lSDL_mixer -lSDL_sound -I/usr/local/include/SDL -lSDL_ttf -lSGE

# static binary: (DOES NOT WORK)
rfs: $(OBJS)
	c++ -static $^ -o $@ -lSDL_image -lSDL_mixer -lSDL_sound -lpng -ljpeg -lz `sdl-config --static-libs` -I/usr/local/include/SDL -lSDL_ttf -lSGE

clean:
	rm -f rf rfs
	rm -f *.o
