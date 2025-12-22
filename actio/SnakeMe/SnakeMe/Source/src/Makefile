.SUFFIXES: .cpp.o

CC=gcc -mcrt=newlib
LINK=$(CC)
LFLAGS= ../SGU/src/lib/libSGU.a -L. -lSDL_gfx -lSDL_net -lSDL_image -ltiff -lpng -ljpeg -lz -lSDL_mixer -lsmpeg -lm -lvorbisfile -lvorbis -logg -lstdc++ -lSDL_ttf -lfreetype -lz -lsdlmain -lsdl -lauto -lpthread -lm -lunix 
CFLAGS= -O2 -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL -I../SGU/include 

OBJ_FILES=SnakeMe.o SnakeUI.o CSnakePowerUp.o CSnakeEngine.o StringTable.o \
	CSnakeLevelEditor.o CSnakeArray.o CSnake.o CDeadSnake.o CAliveSnake.o

snakeme: $(OBJ_FILES)
	 $(LINK) -o SnakeMe.exe $(OBJ_FILES) $(LFLAGS)

clean:
	rm *.o

.cpp.o:
	$(CC) $(CFLAGS) -c $< 
