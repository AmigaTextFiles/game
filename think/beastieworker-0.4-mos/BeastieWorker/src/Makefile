CPP=c++
MOVE=mv
DEL=rm

LFLAGS=      -O2 -pthread
INCS=        -I/usr/local/include/SDL11 -I/usr/X11R6/include/
LIBS=        -L/usr/local/lib -lSDL-1.1 -L/usr/X11R6/lib -lGL -lGLU
OBJS=        cursor.o font.o main.o matrixmath.o menu.o model3d.o player.o scene.o sound.o strings.o texture.o sky.o
MAIN=        BeastieWorker

$(MAIN):  $(OBJS)
	       $(CPP) -o $(MAIN) $(LIBS) $(LFLAGS) $(OBJS)
	       ${MOVE} $(MAIN) ../$(MAIN)


main.o:
	       $(CPP) $(INCS) -c main.cpp
     
cursor.o:
	       $(CPP) $(INCS) -c cursor.cpp

font.o:
	       $(CPP) $(INCS) -c font.cpp

matrixmath.o:
	       $(CPP) $(INCS) -c matrixmath.cpp

menu.o:
	       $(CPP) $(INCS) -c menu.cpp
     
model3d.o:
	       $(CPP) $(INCS) -c model3d.cpp
     
player.o:
	       $(CPP) $(INCS) -c player.cpp

scene.o:
	       $(CPP) $(INCS) -c scene.cpp

sound.o:
	       $(CPP) $(INCS) -c sound.cpp

strings.o:
	       $(CPP) $(INCS) -c strings.cpp

texture.o:
	       $(CPP) $(INCS) -c texture.cpp

sky.o:
	       ${CPP} ${INCS} -c sky.cpp

clean:
	       ${DEL} $(OBJS)
