ifeq (0,$(RELEASE))
 OPTLEVEL=-O0
else
 OPTLEVEL=-O2
endif

CC=gcc
SRC=src
OBJ=obj_win
DXROOT=../../dx7

CFLAGS=-g $(OPTLEVEL) -Wall
CPPFLAGS=-Iinclude -I$(SRC) 
#-DHAVE_VORBIS

USE_SDLMIXER=1

include Makefile.shared

OBJECTS=$(OBJ)/drivers.o \
		$(OBJ)/fx_man.o \
		$(OBJ)/cd.o \
		$(OBJ)/multivoc.o \
		$(OBJ)/mix.o \
		$(OBJ)/mixst.o \
		$(OBJ)/pitch.o \
		$(OBJ)/vorbis.o \
		$(OBJ)/driver_nosound.o

ifeq ($(findstring AROS,$(shell uname -s)),AROS)		
OBJECTS+= $(OBJ)/wildmidi.o
CPPFLAGS+= -DHAVE_WILDMIDI
else		
OBJECTS+= $(OBJ)/music.o \
		$(OBJ)/midi.o \
		$(OBJ)/asssys.o
endif

ifeq (1,$(JFAUDIOLIB_HAVE_SDL))
 CPPFLAGS+= -DHAVE_VORBIS 
 #$(shell pkg-config --cflags vorbisfile)
endif

#ifeq ($(findstring AROS,$(shell uname -s)),AROS)
#  CPPFLAGS+= -DHAVE_SDL
#  OBJECTS+= $(OBJ)/driver_sdl.o
#  ifeq (1,$(USE_SDLMIXER))
#   CPPFLAGS+= -DUSE_SDLMIXER
#  endif
#endif

ifneq (,$(findstring MINGW,$(shell uname -s)))
 CPPFLAGS+= -I$(DXROOT)/include -Ithird-party/mingw32/include
 OBJECTS+= $(OBJ)/driver_directsound.o $(OBJ)/driver_winmm.o
else
 ifeq (1,$(JFAUDIOLIB_HAVE_SDL))
  CPPFLAGS+= -DHAVE_SDL $(shell sdl-config --cflags)
  OBJECTS+= $(OBJ)/driver_sdl.o
  ifeq (1,$(USE_SDLMIXER))
   CPPFLAGS+= -DUSE_SDLMIXER
  endif
 endif
 ifeq (1,$(JFAUDIOLIB_HAVE_ALSA))
  CPPFLAGS+= -DHAVE_ALSA $(shell pkg-config --cflags alsa)
  OBJECTS+= $(OBJ)/driver_alsa.o
 endif
 ifeq (1,$(JFAUDIOLIB_HAVE_FLUIDSYNTH))
  CPPFLAGS+= -DHAVE_FLUIDSYNTH $(shell pkg-config --cflags fluidsynth)
  OBJECTS+= $(OBJ)/driver_fluidsynth.o
 endif
endif

$(JFAUDIOLIB): $(OBJECTS)
	ar cr $@ $^

$(OBJECTS): $(OBJ)/%.o: $(SRC)/%.c
	$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@

.PHONY: clean
clean:
	-rm -f $(OBJECTS) $(JFAUDIOLIB)
