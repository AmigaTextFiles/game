# --- tgcs-car for GP2X makefile
#  rerofumi <rero2@yuumu.org>
#

# --- your build environment

# - Windows with Cygwin
PCCC     = gcc
PCCXX    = g++
PCCFLAGS = -DNOTPSP -D__PSP_SCREEN__
PCLIBS   = -lSDL_mixer -lm -lSDL_image -lpng -lz -lsmpeg -lvorbis -logg -ljpeg
PCINCLUDE = -I/usr/local/mingw32/include
PCSDLCONFIG = /usr/local/mingw32/bin/sdl-config

# - MacOSX
MACCC     = gcc
MACCXX    = g++
MACCFLAGS = -DNOTPSP -D__PSP_SCREEN__ -D__MACOSX__
MACLIBS   = -L/usr/local/lib
MACINCLUDE = -I/usr/local/include -I/usr/local/include/SDL
MACSDLCONFIG = /usr/local/bin/sdl-config

# - GP2X crosscompile with Cygwin
GPTOOLCHAIN = /opt/crosstool/gcc-3.4.1-glibc-2.3.3/arm-linux/bin
GPCC     = $(GPTOOLCHAIN)/arm-linux-gcc
GPCXX    = $(GPTOOLCHAIN)/arm-linux-g++
GPSTRIP  = $(GPTOOLCHAIN)/arm-linux-strip
GPCFLAGS = -DNOTPSP -D__GP2X__ -D__GP2X_SCREEN__
GPLIBS   = -lSDL_mixer -lm -lSDL_image -lpng -lz -ljpeg -lmad -lvorbisidec -lmikmod 
GPINCLUDE = -I/opt/theoddbot-libs-open2x-soft-float/usr/include
GPSDLCONFIG = /opt/theoddbot-libs-open2x-soft-float/usr/bin/sdl-config
GPSTATIC = -static

# - PSPSDK
PSPTOOLCHAIN = /usr/local/pspdev/bin
PSPPRE = $(shell psp-config --psp-prefix)
PSPDEV = $(shell psp-config --pspdev-path)
PSPSDK = $(shell psp-config --pspsdk-path)
PSPCC     = $(PSPTOOLCHAIN)/psp-gcc
PSPCXX    = $(PSPTOOLCHAIN)/psp-gcc
PSPSTRIP  = $(PSPTOOLCHAIN)/psp-strip
PSPMKSFO  = $(PSPTOOLCHAIN)/mksfo
PSPPACKPBP = $(PSPTOOLCHAIN)/pack-pbp
PSPFIXUP = $(PSPTOOLCHAIN)/psp-fixup-imports
PSPSDLCONFIG = /usr/local/pspdev/psp/bin/sdl-config
PSPCFLAGS = -D__PSP__ -D__PSP_SCREEN__ -Dmain=SDL_main
PSPLIBS  = -lSDL_mixer -lm -lSDL_image -lpng -lz -ljpeg -lvorbisidec
PSPINCLUDE = -I$(PSPSDK)/include -I$(PSPDEV)/include -I$(PSPPRE)/include
PSPEXESUFFIX = .elf
PSPOBJSUFFIX = .o
PSP_FINAL_TARGET = EBOOT.PBP
PSP_TARGET       = $(TARGET).elf
PSP_TARGET_STRIP = $(TARGET)_strip.elf
PSP_EBOOT_TITLE  = TCGS-INVADER
PSP_EBOOT_SFO    = PARAM.SFO
PSP_EBOOT_ICON   = icon03.png
PSP_EBOOT_ICON1  = NULL
PSP_EBOOT_UNKPNG = NULL
PSP_EBOOT_PIC1   = NULL
PSP_EBOOT_SND0   = NULL
PSP_EBOOT_PSAR   = NULL


# --- source code target
PCOBJS = bootmain.o debug.o input.o sound.o \
        grp_screen.o grp_texture.o grp_sprite.o

PSPOBJS = bootmain.o psp_debug.o input.o sound.o \
         psp_grp_screen.o grp_texture.o grp_sprite.o

GP2XOBJS = bootmain.o debug.o input.o sound.o \
          gp2x_grp_screen.o grp_texture.o grp_sprite.o

# - your apprication object
APPOBJS = gamemain.o \
         backgroundmanage.o basicsystem.o bonusshipmanage.o \
         bulletbase.o bulletmaker.o bulletmanage.o \
         convoymanage.o enemyobject.o gamedirector.o \
         myshipmanage.o myshotmanage.o panelmanage.o \
         shootingobject.o spriteitem.o titlemanage.o \
         lunamath.o


#
TARGET = shien-so
LIBS =
CFLAGS = -O2 -Wall #-DDEBUG -g
CXXFLAGS = -D__GCC__ -ansi -traditional-cpp -O2 #-g
CXXINCLUDE =

# ----- suffix
%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDE) -c $<

%.o: %.cpp
	$(CPLUSPLUS) $(CFLAGS) $(CINCLUDE) -c $< -o $@


# ----- target
#   (pc) = windows with cygwin
#   psp  = PSP crosscompile with cygwin
#   gp   = GP2X crosscompile with cygwin
#   mac  = MacOSX(tiger)
#
all : pc

pc : CC = $(PCCC)
pc : CPLUSPLUS = $(PCCXX) 
pc : OBJS = $(PCOBJS) $(APPOBJS)
pc : LIBS += $(PCLIBS)
pc : LIBS += $(shell $(PCSDLCONFIG) --libs)
pc : CFLAGS += $(PCCFLAGS)
pc : CFLAGS += $(shell $(PCSDLCONFIG) --cflags)
pc : INCLUDE = $(PCINCLUDE)
pc : CXXINCLUDE = $(PCINCLUDE)
pc : pcobjs
	$(CPLUSPLUS) -o $(TARGET) $(OBJS) $(LIBS)

pcobjs : $(PCOBJS) $(APPOBJS)


gp : CC = $(GPCC)
gp : CPLUSPLUS = $(GPCXX) 
gp : OBJS = $(GP2XOBJS) $(APPOBJS)
gp : LIBS += $(GPLIBS)
gp : LIBS += $(shell $(GPSDLCONFIG) --libs)
gp : CFLAGS += $(GPCFLAGS)
gp : CFLAGS += $(shell $(GPSDLCONFIG) --cflags)
gp : INCLUDE = $(GPINCLUDE)
gp : CXXINCLUDE = $(GPINCLUDE)
gp : gpobjs
	$(GPCXX) $(GPSTATIC) -o $(TARGET).gpe $(OBJS) $(LIBS)
	$(GPSTRIP) $(TARGET).gpe

gpobjs : $(GP2XOBJS) $(APPOBJS)


psp : CC = $(PSPCC)
psp : CPLUSPLUS = $(PSPCXX) 
psp : OBJS = $(PSPOBJS) $(APPOBJS)
psp : LIBS += -lstdc++
psp : LIBS += $(PSPLIBS)
psp : LIBS += $(shell $(PSPSDLCONFIG) --libs)
psp : CFLAGS += $(PSPCFLAGS)
psp : CFLAGS += $(shell $(PSPSDLCONFIG) --cflags)
psp : INCLUDE = $(PSPINCLUDE)
psp : CXXINCLUDE = $(PSPINCLUDE)
psp : $(PSP_FINAL_TARGET)
	mkdir -p "$(TARGET)"
	$(PSPSTRIP) $(TARGET).elf -o $(TARGET)/$(PSP_FINAL_TARGET)
	mkdir -p "$(TARGET)%"
	$(PSPPACKPBP) "$(TARGET)%/$(PSP_FINAL_TARGET)" $(PSP_EBOOT_SFO) $(PSP_EBOOT_ICON)  \
		$(PSP_EBOOT_ICON1) $(PSP_EBOOT_UNKPNG) $(PSP_EBOOT_PIC1)  \
		$(PSP_EBOOT_SND0) NULL $(PSP_EBOOT_PSAR)

$(PSP_FINAL_TARGET) : $(PSP_EBOOT_SFO) $(PSP_TARGET_STRIP)
	$(PSPPACKPBP) $(PSP_FINAL_TARGET) $(PSP_EBOOT_SFO) $(PSP_EBOOT_ICON)  \
		$(PSP_EBOOT_ICON1) $(PSP_EBOOT_UNKPNG) $(PSP_EBOOT_PIC1)  \
		$(PSP_EBOOT_SND0)  $(PSP_TARGET_STRIP) $(PSP_EBOOT_PSAR)

$(PSP_TARGET_STRIP) : $(PSP_TARGET) $(PSP_EBOOT_SFO) 
	$(PSPSTRIP) $(PSP_TARGET) -o $@

$(PSP_EBOOT_SFO) :
	$(PSPMKSFO) '$(PSP_EBOOT_TITLE)' $@

$(PSP_TARGET) : pspobjs
	$(PSPCXX) $(PSPOBJS) $(APPOBJS) $(LIBS) -o $@
	$(PSPFIXUP) $@

pspobjs : $(PSPOBJS) $(APPOBJS)



clean :
	rm -rf *.o $(TARGET) $(TARGET)% $(TARGET).exe $(TARGET).gpe *~ $(PSP_TARGET_STRIP) $(PSP_TARGET) $(PSP_EBOOT_SFO) $(PSP_FINAL_TARGET)

 

bootmain.o : bootmain.cpp bootmain.h debug.h
debug.o : debug.c debug.h
psp_debug.o : psp_debug.c debug.h
grp_screen.o : grp_screen.c grp_screen.h grp_texture.h
psp_grp_screen.o : psp_grp_screen.c grp_screen.h grp_texture.h
input.o : input.c
sound.o : sound.h
grp_texture.o : grp_texture.c grp_texture.h
grp_sprite.o : grp_sprite.c grp_sprite.h
gamemain.o : gamemain.cpp gamemain.h grp_screen.h input.h sound.h debug.h \
             grp_texture.h grp_sprite.h





