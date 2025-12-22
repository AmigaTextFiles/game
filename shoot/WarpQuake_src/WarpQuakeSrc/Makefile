# Makefile for WarpQuake

CC = ppc-amigaos-gcc -warpup

OPT = -mcpu=603e -O3 -ffast-math -mmultiple -fomit-frame-pointer \
			-funroll-loops -fforce-mem -fforce-addr

CFLAGS = -g

DEFS = -DPPCTCP -Didppc #-DDEBUG

LIBS = -lmoto -lamiga

MAKEDEPEND = -MM

VERSION = 0.7

SOURCES = cd_amiga.c chase.c cl_demo.c cl_input.c cl_main.c cl_parse.c cl_tent.c cmd.c \
common.c console.c crc.c cvar.c d_edge.c d_fill.c d_init.c d_modech.c \
d_part.c d_polyse.c d_scan.c d_sky.c d_sprite.c d_surf.c d_vars.c d_zpoint.c \
draw.c host.c host_cmd.c in_amiga.c keys.c menu.c model.c \
net_dgrm.c net_loop.c net_main.c mathlib.c net_bsd.c net_amigaudp.c net_vcr.c nonintel.c pr_cmds.c \
pr_edict.c pr_exec.c r_aclip.c r_alias.c r_bsp.c r_draw.c r_edge.c r_efrag.c \
r_light.c r_main.c r_misc1.c r_misc2.c r_part.c r_sky.c r_sprite.c \
r_surf.c r_vars.c sbar.c screen.c snd_dma.c snd_mem.c snd_mix.c snd_amiga.c \
sv_main.c sv_move.c sv_phys.c sv_user.c sys_amiga.c vid_amiga.c view.c wad.c \
world.c zone.c

ASMSOURCES = amiga_ppc_c2p.s amiga_ppc_mathlib.s amiga_ppc_d_scan.s

DEP = $(SOURCES:.c=.d)
OBJS = $(SOURCES:.c=.o)
ASMOBJS = $(ASMSOURCES:.s=.o)

DISTBIN = WarpQuake WarpQuake.readme chunkyppc.library
DISTSRC = *.c *.s *.h progdefs.q1 WarpQuake_src.readme Makefile

all: WarpQuake.elf WarpQuake_debug.elf

WarpQuake.elf: $(OBJS) $(ASMOBJS) WarpQuake_debug.elf
	ppc-amigaos-strip -o $@ -S WarpQuake_debug.elf
	elf2exe2 $@ WarpQuake

WarpQuake_debug.elf: $(OBJS) $(ASMOBJS)
	date -u '+const char amigaversion[]="$$VER: WarpQuake $(VERSION) (%d.%m.%y)";' >version.c
	$(CC) $(CFLAGS) -c $(OPT) $(DEFS) version.c
	$(CC) $(CFLAGS) -o $@ version.o $(OBJS) $(ASMOBJS) $(LIBS)
	elf2exe2 $@ WarpQuake_debug

%.o: %.c
	$(CC) $(CFLAGS) -c $(OPT) $(DEFS) $<

%.o: %.s
	pasm $<

%.d: %.c
	$(SHELL) -ec '$(CC) $(CFLAGS) $(OPT) $(DEFS) $(MAKEDEPEND) $< | sed '\''s;$*.c;& $@;g'\'' > $@'

net_amigaudp.o: net_amigaudp.c net_amigaudp.d quakedef.h common.h bspfile.h vid.h \
	sys.h zone.h mathlib.h wad.h draw.h cvar.h screen.h net.h protocol.h \
	cmd.h sbar.h sound.h render.h client.h progs.h pr_comp.h progdefs.h \
	progdefs.q1 server.h model.h modelgen.h spritegn.h d_iface.h input.h \
	world.h keys.h console.h view.h menu.h crc.h cdaudio.h net_udp.h
	$(CC) $(CFLAGS) -c $(OPT) $(DEFS) -I/gg/os-includeppc/netinclude $<

pr_exec.o:
	$(CC) $(CFLAGS) -c -mcpu=603e -mmultiple -ffast-math -funroll-loops \
	-fforce-mem -fforce-addr $(DEFS) $<

amiga_ppc_c2p.o: amiga_ppc_c2p.s

amiga_ppc_mathlib.o: amiga_ppc_mathlib.s

amiga_ppc_d_scan.o: amiga_ppc_d_scan.s

clean:
	rm -f $(OBJS) $(ASMOBJS)
	rm -f WarpQuake.elf WarpQuake_debug.elf WarpQuake WarpQuake_debug

cleanmore:
	rm -f $(OBJS) $(ASMOBJS) $(DEP)
	rm -f WarpQuake.elf WarpQuake_debug.elf WarpQuake WarpQuake_debug

dist:
	rm -f WarpQuake.lha
	rm -f WarpQuake_src.lha
	-mkdir /ram/WarpQuake /ram/WarpQuakeSrc
	cp -R $(DISTBIN) /ram/WarpQuake
	cp -R $(DISTSRC) /ram/WarpQuakeSrc
	/c/lha a -r WarpQuake.lha ram:WarpQuake/*
	/c/lha a -r WarpQuake_src.lha ram:WarpQuakeSrc/*
	rm -fr /ram/WarpQuake/* /ram/WarpQuakeSrc/*
	rm -fd /ram/WarpQuake /ram/WarpQuakeSrc
	/c/lha t WarpQuake.lha
	/c/lha t WarpQuake_src.lha

-include $(DEP)
