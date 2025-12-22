CC=	gcc
CXX=	g++

FLAGS=	-mcrt=newlib -Wall -O2 -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL 
LIBS=	-mcrt=newlib -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL_ttf -lfreetype -lsdlmain -lsdl -lauto -lpthread -lm

FILES=	audio.cpp cursor.cpp font.cpp highscore.cpp input.cpp photon.cpp player.cpp refrax.cpp scrolltext.cpp trail.cpp 
TARGET=	Refrax.exe

ALL:
	$(CXX) $(FLAGS) $(FILES) $(INCLUDES) -o $(TARGET) $(LIBS)
	Strip $(TARGET)
