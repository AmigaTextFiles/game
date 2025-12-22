#
# GLQuake-SDL Makefile
#
# Aug '98 by Zoid <zoid@idsoftware.com>
# Modified by Joergen Scheibengruber <mfcn AT gmx.de>
# SDLified by Szila'rd Biro' <col.lawrence AT gmail DOT com>
#

BUILD_RELEASE_DIR=obj

BASE_CFLAGS=-Dstricmp=strcasecmp
CFLAGS=$(BASE_CFLAGS) -O2
LDFLAGS=-lm

GLLDFLAGS=$(shell sdl-config --libs) -lGL
GLCFLAGS=-DGLQUAKE $(shell sdl-config --cflags)

CC=gcc
 
DO_GL_CC=$(CC) $(CFLAGS) $(GLCFLAGS) -o $@ -c $<
#DO_GL_DEBUG_CC=$(CC) $(DEBUG_CFLAGS) $(GLCFLAGS) -o $@ -c $<
DO_GL_AS=$(CC) $(CFLAGS) $(GLCFLAGS) -DELF -x assembler-with-cpp -o $@ -c $<

#############################################################################
# SETUP AND BUILD
#############################################################################

TARGETS=bin/glquake-sdl

build_release:	
	@-mkdir bin \
		$(BUILD_RELEASE_DIR)/
	$(MAKE) targets BUILDDIR=$(BUILD_RELEASE_DIR) CFLAGS="$(CFLAGS)"

all: build_release

targets: $(TARGETS)

#############################################################################
# GLQuake
#############################################################################

GLQUAKE_OBJS= \
	$(BUILDDIR)/cl_demo.o \
	$(BUILDDIR)/cl_input.o \
	$(BUILDDIR)/cl_main.o \
	$(BUILDDIR)/cl_parse.o \
	$(BUILDDIR)/cl_tent.o \
	$(BUILDDIR)/chase.o \
	$(BUILDDIR)/cmd.o \
	$(BUILDDIR)/common.o \
	$(BUILDDIR)/console.o \
	$(BUILDDIR)/crc.o \
	$(BUILDDIR)/cvar.o \
	\
	$(BUILDDIR)/gl_draw.o \
	$(BUILDDIR)/gl_mesh.o \
	$(BUILDDIR)/gl_model.o \
	$(BUILDDIR)/gl_refrag.o \
	$(BUILDDIR)/gl_rlight.o \
	$(BUILDDIR)/gl_rmain.o \
	$(BUILDDIR)/gl_rmisc.o \
	$(BUILDDIR)/gl_rsurf.o \
	$(BUILDDIR)/gl_screen.o \
	$(BUILDDIR)/gl_test.o \
	$(BUILDDIR)/gl_warp.o \
	\
	$(BUILDDIR)/host.o \
	$(BUILDDIR)/host_cmd.o \
	$(BUILDDIR)/keys.o \
	$(BUILDDIR)/menu.o \
	$(BUILDDIR)/mathlib.o \
	$(BUILDDIR)/net_loop.o \
	$(BUILDDIR)/net_main.o \
	$(BUILDDIR)/net_vcr.o \
	$(BUILDDIR)/net_udp.o \
	$(BUILDDIR)/net_bsd.o \
	$(BUILDDIR)/pr_cmds.o \
	$(BUILDDIR)/pr_edict.o \
	$(BUILDDIR)/pr_exec.o \
	$(BUILDDIR)/r_part.o \
	$(BUILDDIR)/sbar.o \
	$(BUILDDIR)/sv_main.o \
	$(BUILDDIR)/sv_phys.o \
	$(BUILDDIR)/sv_move.o \
	$(BUILDDIR)/sv_user.o \
	$(BUILDDIR)/zone.o	\
	$(BUILDDIR)/view.o	\
	$(BUILDDIR)/wad.o \
	$(BUILDDIR)/world.o \
	$(BUILDDIR)/cd_sdl.o \
	$(BUILDDIR)/sys_sdl.o \
	$(BUILDDIR)/snd_dma.o \
	$(BUILDDIR)/snd_mem.o \
	$(BUILDDIR)/snd_mix.o \
	$(BUILDDIR)/snd_sdl.o \
	\
	$(BUILDDIR)/math.o \
	$(BUILDDIR)/worlda.o \
	$(BUILDDIR)/snd_mixa.o \
	$(BUILDDIR)/sys_dosa.o

SGL_OBJS=$(BUILDDIR)/gl_vidsdl.o

bin/glquake-sdl : $(GLQUAKE_OBJS) $(SGL_OBJS)
	$(CC) $(CFLAGS) -o $@ $(GLQUAKE_OBJS) $(SGL_OBJS) $(GLLDFLAGS) $(LDFLAGS)

$(BUILDDIR)/cl_demo.o :      ./cl_demo.c
	$(DO_GL_CC)

$(BUILDDIR)/cl_input.o :     ./cl_input.c
	$(DO_GL_CC)

$(BUILDDIR)/cl_main.o :      ./cl_main.c
	$(DO_GL_CC)

$(BUILDDIR)/cl_parse.o :     ./cl_parse.c
	$(DO_GL_CC)

$(BUILDDIR)/cl_tent.o :      ./cl_tent.c
	$(DO_GL_CC)

$(BUILDDIR)/chase.o :        ./chase.c
	$(DO_GL_CC)

$(BUILDDIR)/cmd.o :          ./cmd.c
	$(DO_GL_CC)

$(BUILDDIR)/common.o :       ./common.c
	$(DO_GL_CC)

$(BUILDDIR)/console.o :      ./console.c
	$(DO_GL_CC)

$(BUILDDIR)/crc.o :          ./crc.c
	$(DO_GL_CC)

$(BUILDDIR)/cvar.o :         ./cvar.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_draw.o :      ./gl_draw.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_mesh.o :      ./gl_mesh.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_model.o :     ./gl_model.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_refrag.o :    ./gl_refrag.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_rlight.o :    ./gl_rlight.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_rmain.o :     ./gl_rmain.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_rmisc.o :     ./gl_rmisc.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_rsurf.o :     ./gl_rsurf.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_screen.o :    ./gl_screen.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_test.o :      ./gl_test.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_vidsdl.o :  ./gl_vidsdl.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_vidlinuxglx.o :  ./gl_vidlinuxglx.c
	$(DO_GL_CC)

$(BUILDDIR)/gl_warp.o :      ./gl_warp.c
	$(DO_GL_CC)

$(BUILDDIR)/host.o :         ./host.c
	$(DO_GL_CC)

$(BUILDDIR)/host_cmd.o :     ./host_cmd.c
	$(DO_GL_CC)

$(BUILDDIR)/keys.o :         ./keys.c
	$(DO_GL_CC)

$(BUILDDIR)/menu.o :         ./menu.c
	$(DO_GL_CC)

$(BUILDDIR)/mathlib.o :      ./mathlib.c
	$(DO_GL_CC)

$(BUILDDIR)/net_dgrm.o :     ./net_dgrm.c
	$(DO_GL_CC)

$(BUILDDIR)/net_loop.o :     ./net_loop.c
	$(DO_GL_CC)

$(BUILDDIR)/net_main.o :     ./net_main.c
	$(DO_GL_CC)

$(BUILDDIR)/net_vcr.o :      ./net_vcr.c
	$(DO_GL_CC)

$(BUILDDIR)/net_udp.o :      ./net_udp.c
	$(DO_GL_CC)

$(BUILDDIR)/net_bsd.o :      ./net_bsd.c
	$(DO_GL_CC)

$(BUILDDIR)/net_none.o :     ./net_none.c
	$(DO_GL_CC)

$(BUILDDIR)/pr_cmds.o :      ./pr_cmds.c
	$(DO_GL_CC)

$(BUILDDIR)/pr_edict.o :     ./pr_edict.c
	$(DO_GL_CC)

$(BUILDDIR)/pr_exec.o :      ./pr_exec.c
	$(DO_GL_CC)

$(BUILDDIR)/r_part.o :       ./r_part.c
	$(DO_GL_CC)

$(BUILDDIR)/sbar.o :         ./sbar.c
	$(DO_GL_CC)

$(BUILDDIR)/sv_main.o :      ./sv_main.c
	$(DO_GL_CC)

$(BUILDDIR)/sv_phys.o :      ./sv_phys.c
	$(DO_GL_CC)

$(BUILDDIR)/sv_move.o :      ./sv_move.c
	$(DO_GL_CC)

$(BUILDDIR)/sv_user.o :      ./sv_user.c
	$(DO_GL_CC)

$(BUILDDIR)/zone.o	:        ./zone.c
	$(DO_GL_CC)

$(BUILDDIR)/view.o	:        ./view.c
	$(DO_GL_CC)

$(BUILDDIR)/wad.o :          ./wad.c
	$(DO_GL_CC)

$(BUILDDIR)/world.o :        ./world.c
	$(DO_GL_CC)

$(BUILDDIR)/cd_sdl.o :     ./cd_sdl.c
	$(DO_GL_CC)

$(BUILDDIR)/sys_sdl.o :    ./sys_sdl.c
	$(DO_GL_CC)

$(BUILDDIR)/snd_dma.o :      ./snd_dma.c
	$(DO_GL_CC)

$(BUILDDIR)/snd_mem.o :      ./snd_mem.c
	$(DO_GL_CC)

$(BUILDDIR)/snd_mix.o :      ./snd_mix.c
	$(DO_GL_CC)

$(BUILDDIR)/snd_sdl.o :    ./snd_sdl.c
	$(DO_GL_CC)

$(BUILDDIR)/math.o :         ./math.s
	$(DO_GL_AS)

$(BUILDDIR)/worlda.o :       ./worlda.s
	$(DO_GL_AS)

$(BUILDDIR)/snd_mixa.o :     ./snd_mixa.s
	$(DO_GL_AS)

$(BUILDDIR)/sys_dosa.o :     ./sys_dosa.s
	$(DO_GL_AS)

#############################################################################
# MISC
#############################################################################

clean: 
	rm -rf bin $(BUILD_RELEASE_DIR)
