#

# Quake2 pball beta4 gamesparc.so Makefile for Solaris 2.5

#

# Mar '98 by Zoid <zoid@idsoftware.com>

#

# Probably requires GNU make

#



ARCH=i386

CC=gcc

BASE_CFLAGS=-Dstricmp=strcasecmp -I..



# Uncomment following for release build

#CFLAGS=$(BASE_CFLAGS) -g -mpentiumpro -O6 -ffast-math -funroll-loops \

#	-fomit-frame-pointer -fexpensive-optimizations



# Uncomment following for debug build

CFLAGS=$(BASE_CFLAGS) -g



# Always uncommented

LDFLAGS=-ldl -lm

SHLIBEXT=so



SHLIBCFLAGS=-fPIC

SHLIBLDFLAGS=-shared



DO_CC=$(CC) $(CFLAGS) $(SHLIBCFLAGS) -o $@ -c $<



#############################################################################

# SETUP AND BUILD

# GAME

#############################################################################



.c.o:

	$(DO_CC)



GAME_OBJS = rus_item.o rus_spawn.o rus_guninfo.o rus_weapon.o rus_main.o

#	g_so.o # this file is a shared library thingie needed for Solaris



rus$(ARCH).$(SHLIBEXT) : $(GAME_OBJS)

	$(CC) $(CFLAGS) $(SHLIBLDFLAGS) -o $@ $(GAME_OBJS) $(LDFLAGS)





#############################################################################

# MISC

#############################################################################



clean:

	-rm -f $(GAME_OBJS)



depend:

	gcc -MM $(GAME_OBJS:.o=.c)

rus_item.o: rus_item.c rus_main.h rus_defines.h ../g_local.h ../g_defines.h \

 ../q_shared.h ../game.h ../p_menu.h ../g_cmds.h ../g_dll.h

rus_spawn.o: rus_spawn.c rus_main.h rus_defines.h ../g_local.h ../g_defines.h \

 ../q_shared.h ../game.h ../p_menu.h ../g_cmds.h ../g_dll.h

rus_guninfo.o: rus_guninfo.c rus_main.h rus_defines.h ../g_local.h ../g_defines.h \

 ../q_shared.h ../game.h ../p_menu.h ../g_cmds.h ../g_dll.h

rus_weapon.o: rus_weapon.c rus_main.h rus_defines.h ../g_local.h ../g_defines.h \

 ../q_shared.h ../game.h ../p_menu.h ../g_cmds.h ../g_dll.h

rus_main.o: rus_main.c rus_main.h rus_defines.h ../g_local.h ../g_defines.h ../q_shared.h \

 ../game.h ../p_menu.h ../g_cmds.h ../g_dll.h ../p_classes.h

