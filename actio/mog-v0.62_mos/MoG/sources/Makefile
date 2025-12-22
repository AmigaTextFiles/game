OBJS := \
	main.o gametiles.o bitmaps.o gameaux.o gamecycle.o render.o \
	ingamecycle.o passwords.o shrines.o demons.o gameinteractions.o \
	line_clip.o path.o sound.o drawing.o gameobjects.o loadpcx.o \
	roomchange.o debug-report.o keyboard.o

all: mog

%.o: %.cpp
	c++ -c -g3 -O0 $< -o $@ `sdl-config --cflags` -I/usr/local/include/SDL

# dynamically linked binary:
mog: $(OBJS)
	c++ $^ -o $@ `sdl-config --libs` -lSDL_image -lSDL_mixer -lSDL_sound -lSDL_sound -I/usr/local/include/SDL

# static binary:
mogs: $(OBJS)
	c++ -static $^ -o $@ -lSDL_image -lSDL_mixer -lSDL_sound -lpng -ljpeg -lz `sdl-config --static-libs`

clean:
	rm -f mog mogs
	rm -f *.o 