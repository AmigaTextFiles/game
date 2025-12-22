#
#
# Makefile 1/18/97

OBJS= Yeah.o Utils.o status.o cyber1.o Sound.o options.o map_grafx.o \
      map_display.o map_editor.o map_editor2.o cyber_data.o titlescreen.o main_menu.o low_smash.o game_play1.o \
      graphics.o game_play2.o Gadgets.o cyber_interface.o Donk.o death_cry.o \
      data_struct.o Boom.o cyber2.o cyber3.o cyber4.o cyber5.o


all:
    smake -f debug.smake
    
    
release:
    smake -f release.smake


clean:
    delete $(OBJS)







