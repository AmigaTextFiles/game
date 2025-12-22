CC = gcc -mcrt=newlib
DEFINES = -DHAVE_ZIP=1 -DGFXMODULE_SDL=1 -DWORDS_BIGENDIAN=1
CFLAGS = -O2 -ggdb $(DEFINES) -Wall -I../../ -I../ -I. -I../../regex/ -Isdk:local/common/include/SDL -c
#LDFLAGS = #-newlib -o
#LDLIBS = #-lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL -lauto -lpthread

SRC = \
	list/list.c \
	video/vidplayer.c video/videodec.c video/video.c video/vfileins.c video/dukvid.c \
	time/timecommon.c time/sdl/sdltime.c threads/thrcommon.c                    \
	threads/sdl/sdlthreads.c task/tasklib.c strings/unicode.c strings/strings.c  \
	strings/sresins.c strings/sfileins.c strings/getstr.c sound/trackplayer.c     \
	sound/stream.c sound/sound.c sound/sfx.c sound/resinst.c sound/music.c         \
	sound/fileinst.c sound/audiocore.c sound/openal/audiodrv_openal.c               \
	sound/mixer/mixer.c sound/mixer/sdl/audiodrv_sdl.c                               \
	sound/mixer/nosound/audiodrv_nosound.c sound/decoders/wav.c                       \
	sound/decoders/oggaud.c sound/decoders/modaud.c sound/decoders/dukaud.c            \
	sound/decoders/decoder.c sound/decoders/mikmod/virtch_common.c                      \
	sound/decoders/mikmod/virtch2.c sound/decoders/mikmod/virtch.c                       \
	sound/decoders/mikmod/sloader.c sound/decoders/mikmod/npertab.c                       \
	sound/decoders/mikmod/mwav.c sound/decoders/mikmod/munitrk.c                           \
	sound/decoders/mikmod/mplayer.c sound/decoders/mikmod/mmio.c                            \
	sound/decoders/mikmod/mmerror.c sound/decoders/mikmod/mmalloc.c                          \
	sound/decoders/mikmod/mlutil.c sound/decoders/mikmod/mlreg.c                              \
	sound/decoders/mikmod/mloader.c sound/decoders/mikmod/mdriver.c                            \
	sound/decoders/mikmod/mdreg.c sound/decoders/mikmod/load_mod.c                              \
	sound/decoders/mikmod/drv_openal.c sound/decoders/mikmod/drv_nos.c                           \
	resource/stringbank.c resource/mapres.c resource/alist.c \
	resource/resinit.c resource/resdata.c resource/loadres.c resource/getres.c                    \
	resource/filecntl.c resource/direct.c memory/w_memlib.c math/sqrt.c                            \
	math/random.c math/fastrand.c input/input_common.c input/sdl/vcontrol.c                         \
	input/sdl/keynames.c input/sdl/input.c graphics/widgets.c graphics/tfb_prim.c                    \
	graphics/tfb_draw.c graphics/resgfx.c graphics/pixmap.c graphics/loaddisp.c                       \
	graphics/intersec.c graphics/gfx_common.c graphics/frame.c graphics/font.c                         \
	graphics/filegfx.c graphics/drawable.c graphics/context.c graphics/cmap.c                           \
	graphics/clipline.c graphics/boxint.c graphics/sdl/sdluio.c                                          \
	graphics/sdl/sdl_common.c graphics/sdl/rotozoom.c graphics/sdl/rndzoom.c                              \
	graphics/sdl/pure.c graphics/sdl/primitives.c graphics/sdl/opengl.c                                    \
	graphics/sdl/dcqueue.c graphics/sdl/canvas.c graphics/sdl/bbox.c                                        \
	graphics/sdl/3do_getbody.c graphics/sdl/3do_funcs.c graphics/sdl/3do_blt.c                               \
	graphics/sdl/scalers.c graphics/sdl/nearest2x.c graphics/sdl/triscan2x.c \
	graphics/sdl/hq2x.c graphics/sdl/bilinear2x.c graphics/sdl/biadv2x.c \
	graphics/sdl/2xscalers.c file/temp.c file/files.c file/dirs.c decomp/update.c                             \
	decomp/lzencode.c decomp/lzdecode.c uio/utils.c uio/uioutils.c uio/uiostream.c                             \
	uio/physical.c uio/paths.c uio/mounttree.c uio/mount.c uio/memdebug.c                                       \
	uio/match.c uio/ioaux.c uio/io.c uio/hashtable.c uio/gphys.c uio/fstypes.c                                   \
	uio/fileblock.c uio/defaultfs.c uio/debug.c uio/charhashtable.c                                               \
	uio/stdio/stdio.c uio/zip/zip.c  cdp/cdpapi.c cdp/cdp.c

OBJ = $(SRC:%.c=%.o)

liblibs.a: $(OBJ)
	ar -ru $@ $(OBJ)
	ranlib $@

%.o : %.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	delete #?.o
	delete #?/#?.o
	delete #?/#?/#?.o
	delete #?/#?/#?/#?.o
	delete #?/#?/#?/#?/#?.o
	delete liblibs.a

