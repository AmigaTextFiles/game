CROSS := ppc-amigaos
CC := $(CROSS)-gcc
CXX := $(CROSS)-g++
STRIP := $(CROSS)-strip
RM := rm -f

SDL_CFLAGS := -I/SDK/local/common/include/SDL
CFLAGS := -O2 -g -Wall -Isrc -DSYSTEM_SDL $(SDL_CFLAGS)
CXXFLAGS := $(CFLAGS)
LDFLAGS := -use-dynld
EMBED_LIBS := 
GAME_LIBS := -lSDL_image -ltiff -ljpeg -lpng -lz -lSDL_mixer -lFLAC \
	-lvorbisfile -lvorbis -logg -lsmpeg -lmodplug -lmikmod -lSDL -lpthread \
	-lunix

EMBED_OBJS := src/tools/embed.o
GAME_OBJS := src/freesynd.o src/agent.o src/agentmanager.o src/app.o \
	src/ipastim.o src/map.o src/mapmanager.o src/mapobject.o src/mission.o \
	src/missionmanager.o src/mod.o src/modmanager.o src/ped.o \
	src/pedactions.o src/pedmanager.o src/pedpathfinding.o src/vehicle.o \
	src/vehiclemanager.o src/weapon.o src/weaponmanager.o \
	src/core/gamesession.o src/core/missionbriefing.o src/core/research.o \
	src/core/researchmanager.o src/core/squad.o src/system_sdl.o \
	src/gfx/dirtylist.o src/gfx/fliplayer.o src/gfx/font.o \
	src/gfx/fontmanager.o src/gfx/tile.o src/gfx/tilemanager.o \
	src/gfx/screen.o src/gfx/sprite.o src/gfx/spritemanager.o \
	src/menus/briefmenu.o src/menus/confmenu.o src/menus/debriefmenu.o \
	src/menus/flimenu.o src/menus/gameplaymenu.o src/menus/mainmenu.o \
	src/menus/loadingmenu.o src/menus/loadsavemenu.o src/menus/logoutmenu.o \
	src/menus/mapmenu.o src/menus/menu.o src/menus/menumanager.o \
	src/menus/minimaprenderer.o src/menus/researchmenu.o \
	src/menus/selectmenu.o src/menus/squadselection.o src/menus/widget.o \
	src/model/objectivedesc.o \
	src/sound/audio.o src/sound/musicmanager.o src/sound/sdlmixermusic.o \
	src/sound/sdlmixersound.o src/sound/soundmanager.o src/sound/xmidi.o \
	src/utils/ccrc32.o src/utils/configfile.o src/utils/dernc.o \
	src/utils/file.o src/utils/portablefile.o src/utils/seqmodel.o

.PHONY: all
all: embed freesynd

embed: embed.debug
	$(STRIP) -R.comment -o $@ $<

embed.debug: $(EMBED_OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(EMBED_LIBS)

freesynd: freesynd.debug
	$(STRIP) -R.comment -o $@ $<

freesynd.debug: $(GAME_OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^ $(GAME_LIBS)

src/freesynd.o: src/default_ini.h

src/default_ini.h: freesynd.ini embed
	./embed $< embedded_default_ini $@

.PHONY: clean
clean:
	$(RM) *.debug src/*.o src/*/*.o

