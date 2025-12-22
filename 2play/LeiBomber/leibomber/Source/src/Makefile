CC = gcc -mcrt=clib2
OBJS = gst_etre.o gst_bombe.o gst_obstacle.o gst_tab_jeu.o gst_directions.o gst_roquette.o gst_sons.o gst_caracteres.o gst_anim.o gst_dialogue.o gst_monstre.o gst_configure.o gst_divers.o
CIBLE = leibomber
CFLAGS = -mcrt=clib2 -I/sdk/local/clib2/include/SDL -I/sdk/local/common/include/SDL -Wall -lSDL_gfx -lSDL_net -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL_ttf -lfreetype -lz -lsdlmain -lsdl -lauto -lpthread -lm -lunix


$(CIBLE) : $(OBJS) $(CIBLE).c
	$(CC) -o $(CIBLE) $(CIBLE).c $(OBJS) -I/usr/local/include $(CFLAGS)

gst_etre.o : gst_etre.c gst_etre.h
gst_bombe.o : gst_bombe.c gst_bombe.h
gst_obstacle.o : gst_obstacle.c gst_obstacle.h 
gst_tab_jeu.o : gst_tab_jeu.c gst_tab_jeu.h gst_obstacle.h
gst_directions.o : gst_directions.c gst_directions.h
gst_roquette.o : gst_roquette.c gst_roquette.h
gst_sons.o : gst_sons.c gst_sons.h
gst_caracteres.o : gst_caracteres.c gst_caracteres.h
gst_anim.o : gst_anim.c gst_anim.h
gst_dialogue.o : gst_dialogue.c gst_dialogue.h
gst_monstre.o : gst_monstre.c gst_monstre.h
gst_configure.o : gst_configure.c gst_configure.h
gst_divers.o : gst_divers.c gst_divers.h

clean :
	rm -f *.o *~ $(CIBLE)