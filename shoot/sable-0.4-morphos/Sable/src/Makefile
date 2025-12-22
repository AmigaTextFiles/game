# C options
CC = gcc
FLAGS = -c `sdl-config --cflags` -O2 -Wall -DSABLE_RESOURCEDIR=\"$(INSTALL_RESDIR)/sable/\" $(CFLAGS)

# C++ options.
CXX = g++
CXXFLAGS = $(FLAGS)

# Linker options.
LD = g++
LDFLAGS = 
LIBS = `sdl-config --libs` -lGL -lGLU -lSDL_image -lSDL_mixer

COBJS = vcontrol.o keynames.o bcplrandom.o
CXXOBJS = entity.o entityfarm.o environment.o game.o geometry.o \
       ground.o input.o menu.o models.o obb.o sable.o textures.o \
       sound.o logo.o 
OBJS = $(COBJS) $(CXXOBJS)

sable: $(OBJS)
	$(LD) $(LDFLAGS) -o sable $(OBJS) $(LIBS)

clean:
	rm -f sable *.o

depend:
	makedepend -Y. *.cpp *.c >& /dev/null

$(COBJS): %.o: %.c
	$(CC) $(FLAGS) -o $@ $<

$(CXXOBJS): %.o: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ $<
# DO NOT DELETE

entity.o: sable.h entity.h geometry.h obb.h models.h input.h entityfarm.h
entity.o: sound.h
entityfarm.o: entityfarm.h sable.h entity.h geometry.h obb.h
environment.o: sable.h environment.h logo.h menu.h game.h entity.h geometry.h
environment.o: obb.h entityfarm.h
game.o: sable.h sound.h environment.h game.h entity.h geometry.h obb.h
game.o: entityfarm.h input.h textures.h ground.h
geometry.o: sable.h geometry.h
ground.o: sable.h ground.h textures.h
input.o: input.h vcontrol.h
logo.o: sable.h logo.h environment.h textures.h input.h
menu.o: sable.h menu.h environment.h textures.h models.h geometry.h input.h
menu.o: sound.h
models.o: sable.h models.h geometry.h
obb.o: sable.h obb.h
sable.o: sable.h textures.h geometry.h models.h environment.h input.h sound.h
sound.o: sable.h sound.h
textures.o: sable.h textures.h
keynames.o: keynames.h
vcontrol.o: vcontrol.h keynames.h
