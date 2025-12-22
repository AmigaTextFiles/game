all: meandmyshadow

AS = m68k-amigaos-as
LD = m68k-amigaos-ld
CC = m68k-amigaos-g++
AR = m68k-amigaos-ar


SDL_CFLAGS = `sdl-config --cflags`
SDL_LIBS = `sdl-config --libs`

CFLAGS = -O3 -mnobitfield -m68060 -Isrc $(SDL_CFLAGS) 
LDFLAGS = -L/usr/local/amiga/lib/gcc/m68k-amigaos/4.5.0 -L/usr/local/amiga/m68k-amigaos/lib

OBJS = \
Addons.cpp       GUIListBox.cpp    Game.cpp          InputManager.cpp  Main.cpp           Settings.cpp      TitleMenu.cpp \
Block.cpp        GUIObject.cpp     GameObjects.cpp   LevelEditor.cpp   Objects.cpp        Shadow.cpp        TreeStorageNode.cpp \
FileManager.cpp  GUIScrollBar.cpp  Globals.cpp       LevelSelect.cpp   POASerializer.cpp  ThemeManager.cpp \
Functions.cpp    GUITextArea.cpp   ImageManager.cpp  Levels.cpp        Player.cpp         Timer.cpp

LIBS= -lSDL_mixer -lsmpeg -lSDL -lstdc++ -lSDL_gfx -lSDL_ttf -lfreetype -larchive -lcurl -lssl -lcrypto -lz  $(SDL_LIBS)

meandmyshadow: $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS) $(CFLAGS) $(LIBS) 

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm $(OBJS)
