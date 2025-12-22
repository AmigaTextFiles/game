OBJS := \
	auxiliar.o           configuration.o     encoder.o \
	enemies.o            fonts.o       	 game.o \
	main.o               maps.o              replays.o \
	state_changepack.o   state_chooseship.o  state_endsequence.o \
	state_game.o         state_gameover.o    state_instructions.o \
	state_interphase.o   state_keyredefinition.o \
	state_levelfinished.o state_logo.o       state_mainmenu.o \
	state_replay.o       state_replaymanager.o \
	state_typetext.o     tiles.o             transball.o \

all: libsge stransball2

%.o: %.cpp
	c++ -newlib -wall -c -g -O3 $< -o $@ -Isdk:local/newlib/include/SDL -Isge

stransball2: $(OBJS) sge/libsge.a
	c++ -newlib -o $@ $(OBJS) -lSDL_image -lpng -ljpeg -lz -lSDL_Mixer -lvorbisfile -lvorbis -logg -Lsge -lSGE -lSDL -lauto -lpthread

libsge:
	make -C sge

clean:
	make -C sge clean
	delete stransball2
	delete #?.o
