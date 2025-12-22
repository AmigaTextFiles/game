OBJS =  g_ai.c g_chase.c g_cmds.c g_combat.c g_func.c g_items.c g_main.c g_misc.c \
      g_monster.c g_phys.c g_save.c g_spawn.c g_svcmds.c g_target.c g_trigger.c \
      g_turret.c g_utils.c g_weapon.c m_actor.c m_berserk.c m_boss2.c m_boss3.c \
      m_boss31.c m_boss32.c m_brain.c m_chick.c m_flash.c m_flipper.c m_float.c \
      m_flyer.c m_gladiator.c m_gunner.c m_hover.c m_infantry.c m_insane.c m_medic.c \
      m_move.c m_mutant.c m_parasite.c m_soldier.c m_supertank.c m_tank.c p_client.c \
      p_hud.c p_trail.c p_view.c p_weapon.c q_shared.c
	

OBJSCPP = 

EXE = gameppc.elf

OTHER = 

CCM68K = gcc -V 2.95 -m68060 -fomit-frame-pointer -I/ade/include -s -noixemul

CC603 = ppc-amigaos-gcc -V 2.95.2 -mcpu=603e -mmultiple -warpup
CC604 = ppc-amigaos-gcc -V 2.95.2 -mcpu=604e -mmultiple -warpup
CC750 = ppc-amigaos-gcc -V 2.95.2 -mcpu=750 -mmultiple -warpup

CC = $(CC604)

CODEGEN = -D_inline="static __inline" -DFALSE=0 -DTRUE=1 -DNDEBUG

OPTIMIZE = -O3

CFLAGS= $(CODEGEN) $(OPTIMIZE)

LIBS = -ldllppc -lppcamiga

%.o : %.c
	$(CC) $(CFLAGS) -S $< -o $*.s
	$(CC) $(CFLAGS) -c $*.s -o $*.o

%.o : %.cpp
	$(CC) $(CFLAGS) -fno-exceptions -fno-rtti -S $< -o $*.s
	$(CC) $(CFLAGS) -c $*.s -o $*.o

ASMS = $(OBJS:.o=.s) $(OBJSCPP:.o=.s)

$(EXE) : $(OBJS) $(OBJSCPP)
	$(CC) $(OBJS) $(OBJSCPP) $(LIBS) -o $@
	elf2exe2 $@ gameppc.dll

depend : 
	$(CC) $(CFLAGS) -MM $(OBJS:.o=.c) $(OBJSCPP:.o=.cpp) >depend

clean :
	rm $(EXE) $(OBJS) $(OBJSCPP) $(ASMS) $(OTHER) depend

#DEPENDENCIES

#include depend
