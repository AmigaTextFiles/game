# Makefile for `bvalanche' game

objects = src/GameOver.o src/RectangularCollision.o src/bvalanche.o src/crate_object.o src/framerate.o src/graphics.o src/lava.o src/main.o src/require.o 

bvalanche: $(objects)
	gcc -o bvalanche $(objects) `sdl-config --cflags --libs`

clean:
	rm $(objects)

$(objects): src/GameOver.h src/RectangularCollision.h src/bool.h src/bvalanche.h src/constants.h src/crate_object.h src/framerate.h src/graphics.h src/lava.h src/require.h  
