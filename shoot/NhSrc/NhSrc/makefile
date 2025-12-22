OBJS =  q_shared.o g_ai.o p_client.o g_cmds.o g_svcmds.o g_chase.o g_combat.o g_func.o \
	g_items.o g_main.o g_misc.o g_phys.o g_save.o g_spawn.o g_target.o g_trigger.o \
	g_utils.o g_weapon.o p_hud.o p_view.o p_weapon.o nhcommon/flashlight.o nhcommon/g_IRgoggles.o \
	nhcommon/g_cmd_observe.o nhcommon/g_cmd_teleport.o nhcommon/g_cmd_scopetoggle.o nhcommon/g_cmd_misc.o nhcommon/g_flare.o \
	nhcommon/g_ctf.o nhcommon/p_nhmenu.o nhcommon/p_menu.o nhcommon/p_nhscoreboard.o nhcommon/q_devels.o g_monster.o p_trail.o \
	nhcommon/g_cmd_overload.o nhcommon/p_motd.o nhcommon/g_cmd_spotrep.o nhcommon/g_cmd_setup.o  nhcommon/g_safety.o nhcommon/q_model.o \
	nhcommon/g_nh_light.o nhcommon/p_predator.o nhcommon/g_nh.o nhcommon/g_lightning.o nhcommon/g_cvars.o  m_move.o strsep.o

OBJSCPP = 

EXE = gameppc.elf

OTHER = 

CCM68K = gcc -V 2.95 -m68060 -fomit-frame-pointer -I/ade/include -s -noixemul

CC603 = ppc-amigaos-gcc -V 2.95.2 -mcpu=603e -mmultiple -warpup
CC604 = ppc-amigaos-gcc -V 2.95.2 -mcpu=604e -mmultiple -warpup
CC750 = ppc-amigaos-gcc -V 2.95.2 -mcpu=750 -mmultiple -warpup

CC = $(CC604)

CODEGEN = -Inhcommon -I../nh \
		  -D_inline="static __inline" -D__saveds= -D__int64="long long" -DMAX_PATH=255 -DFALSE=0 -DTRUE=1 \
		  -DNDEBUG 

OPTIMIZE = -O3

CFLAGS= $(CODEGEN) $(OPTIMIZE)

LIBS = -lz -ldllppc -lppcamiga

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
