#! /bin/sh

OBJECTS	= ../objs/Engine.o ../objs/bonus.o ../objs/highscore.o ../objs/launcher.o ../objs/son.o ../objs/Param.o ../objs/brick.o ../objs/intro.o ../objs/main.o ../objs/terrain.o ../objs/balle.o ../objs/figure.o ../objs/jeu.o ../objs/menu.o
TARGET	=	../2H4U
LIBS	= -mcrt=newlib -lSDL_gfx -lSDL_net -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL_ttf -lfreetype -lz -lsdlmain -lsdl -lauto -lpthread -lm -lunix

all: dirs $(OBJECTS)
	g++ -mcrt=newlib -o $(TARGET) $(OBJECTS) $(LIBS)

dirs:
	mkdir -p ../objs

../objs/Engine.o: ../sources/Engine.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/bonus.o: ../sources/bonus.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/highscore.o: ../sources/highscore.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/launcher.o: ../sources/launcher.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/son.o: ../sources/son.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/Param.o: ../sources/Param.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/brick.o: ../sources/brick.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/intro.o: ../sources/intro.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/main.o: ../sources/main.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/terrain.o: ../sources/terrain.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/balle.o: ../sources/balle.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/figure.o: ../sources/figure.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/jeu.o: ../sources/jeu.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
../objs/menu.o: ../sources/menu.cpp
	g++ -mcrt=newlib -o $@ -c $<
	
rebuild:
	superclean
	all
	
clean:
	rm -rf $(OBJECTS)

superclean : clean
	rm -rf $(TARGET)
