SRC = \
	Audio.cpp         FlyingChars.cpp  MortalNetworkImpl.cpp       sge_primitives.cpp \
	Backend.cpp       Game.cpp         OnlineChat.cpp              sge_surface.cpp \
	Background.cpp    GameOver.cpp     PlayerSelectController.cpp  sge_tt_text.cpp \
	Chooser.cpp       gfx.cpp          PlayerSelect.cpp            State.cpp \
	common.cpp        Joystick.cpp     PlayerSelectView.cpp        TextArea.cpp \
	Demo.cpp          main.cpp         RlePack.cpp \
	FighterStats.cpp  menu.cpp         sge_bm_text.cpp

OBJ = $(SRC:.cpp=.o)

INC = -Isdk:local/clib2/include/SDL -I../ -Isdk:Local/clib2/lib/perl5/5.8.5/ppc-amigaos/CORE -Isdk:Local/freetype/include/
CFLAGS = -O3 -Wall $(INC) -DDATADIR="/PROGDIR/data" -c

LIBS = -lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL_Image -lpng -ljpeg -lz -lSDL_ttf -lfreetype \
 	-lSDL_net -lSDL -lpthread -Lsdk:local/clib2/lib/perl5/5.8.5/ppc-amigaos/CORE -lperl -lnet -lauto -lunix

OpenMortal : $(OBJ)
	g++ -o $@ $(OBJ) $(LIBS)

%.o : %.cpp
	g++ $(CFLAGS) $< -o $@

clean:
	delete #?.o
	delete OpenMortal
