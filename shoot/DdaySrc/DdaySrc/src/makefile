#
# Quake2 pball beta4 gamesparc.so Makefile for Solaris 2.5
#
# Mar '98 by Zoid <zoid@idsoftware.com>
#
# Probably requires GNU make
#

ARCH=i386
CC=gcc
BASE_CFLAGS=-Dstricmp=strcasecmp

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

GAME_OBJS =	\
	g_ai.o \
	g_arty.o \
	g_cmds.o \
	g_combat.o \
	g_dll.linux.o \
	g_ents.o \
	g_func.o \
	g_items.o \
	g_main.o \
	g_maps.o \
	g_misc.o \
	g_monster.o \
	g_objectives.o \
	g_phys.o \
	g_save.o \
	g_spawn.o \
	g_svcmds.o \
	g_target.o \
	g_trigger.o \
	g_turret.o \
	g_utils.o \
	g_weapon.o \
	m_actor.o \
	m_flash.o \
	m_insane.o \
	m_move.o \
	p_classes.o \
	p_client.o \
	p_generic_wep.o \
	p_hud.o \
	p_menu.o \
	p_observer.o \
	p_trail.o \
	p_view.o \
	p_weapon.o \
	q_shared.o \
	u_entmgr.o \
	u_findfunc.o \
	x_fbomb.o \
	x_fire.o \
	z_removed.o

#	g_so.o # this file is a shared library thingie needed for Solaris

game$(ARCH).$(SHLIBEXT) : $(GAME_OBJS)
	$(MAKE) usa$(ARCH).$(SHLIBEXT) -C usa
	$(MAKE) grm$(ARCH).$(SHLIBEXT) -C grm
	$(CC) $(CFLAGS) $(SHLIBLDFLAGS) -o $@ $(GAME_OBJS) $(LDFLAGS)



#############################################################################
# MISC
#############################################################################

clean:
	-rm -f $(GAME_OBJS)
	$(MAKE) clean -C usa
	$(MAKE) clean -C grm

depend:
	gcc -MM $(GAME_OBJS:.o=.c)
g_ai.o: g_ai.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_arty.o: g_arty.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_cmds.o: g_cmds.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h m_player.h g_cmds.h
g_combat.o: g_combat.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
g_dll.linux.o: g_dll.linux.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h g_dll.h u_findfunc.h u_entmgr.h
g_ents.o: g_ents.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_feeder.o: g_feeder.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
g_func.o: g_func.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_items.o: g_items.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_main.o: g_main.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h g_dll.h
g_maps.o: g_maps.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_misc.o: g_misc.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h x_fire.h
g_monster.o: g_monster.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h x_fire.h
g_objectives.o: g_objectives.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
g_phys.o: g_phys.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_save.o: g_save.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_spawn.o: g_spawn.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_svcmds.o: g_svcmds.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
g_target.o: g_target.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
g_trigger.o: g_trigger.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
g_turret.o: g_turret.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h x_fire.h
g_utils.o: g_utils.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
g_weapon.o: g_weapon.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
m_actor.o: m_actor.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h m_actor.h
m_flash.o: m_flash.c q_shared.h
m_insane.o: m_insane.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h m_insane.h
m_move.o: m_move.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
p_classes.o: p_classes.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h p_classes.h
p_client.o: p_client.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h m_player.h g_cmds.h x_fire.h
p_generic_wep.o: p_generic_wep.c g_local.h g_defines.h q_shared.h \
 game.h p_menu.h g_maps.h m_player.h
p_hud.o: p_hud.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
p_menu.o: p_menu.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
p_observer.o: p_observer.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
p_trail.o: p_trail.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
p_view.o: p_view.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h m_player.h
p_weapon.o: p_weapon.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h m_player.h x_fbomb.h x_fire.h
q_shared.o: q_shared.c q_shared.h
removed.o: removed.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h
u_entmgr.o: u_entmgr.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h u_entmgr.h
u_findfunc.o: u_findfunc.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h u_findfunc.h allfuncs.h funcarry.h
x_fbomb.o: x_fbomb.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h x_fbomb.h x_fire.h
x_fire.o: x_fire.c g_local.h g_defines.h q_shared.h game.h p_menu.h \
 g_maps.h x_fire.h
z_removed.o: z_removed.c g_local.h g_defines.h q_shared.h game.h \
 p_menu.h g_maps.h
