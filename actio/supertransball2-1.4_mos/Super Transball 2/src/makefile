SDL_CFLAGS = `sdl-config --cflags`
SDL_LIBS = `sdl-config --libs`
LIBS = -lm $(SDL_LIBS) -lSDL_mixer -lSDL_image -lSGE
OBJS=auxiliar.o configuration.o encoder.o enemies.o fonts.o game.o main.o maps.o replays.o tiles.o transball.o
TARGET=supertransball2

all: $(TARGET)

$(TARGET): $(OBJS)
        $(CC) -o $(TARGET) $(OBJS) $(LIBS)

clean:
        rm $(OBJS) $(TARGET)