# Duke3dw Makefile for GNU Make

# Use colored output
PRETTY_OUTPUT = 0

# SDK locations - adjust to match your setup
DXROOT=dx7

# Engine options
SUPERBUILD = 1
POLYMOST = 1
USE_OPENGL = 1
DYNAMIC_OPENGL = 1
NOASM = 0
LINKED_GTK = 0
USE_A_C = 0

# Debugging options
RELEASE?=1

# build locations
SRC=source
RSRC=rsrc
OBJ=obj_win
EROOT=build
EINC=$(EROOT)/include
EOBJ=eobj_win
INC=$(SRC)
o=o

ifneq (0,$(RELEASE))
  # debugging disabled
  debug=-fomit-frame-pointer -O2
else
  # debugging enabled
  debug=-ggdb -O0
endif

JAUDIOLIBDIR=$(SRC)/jaudiolib
include $(JAUDIOLIBDIR)/Makefile.shared

CC=gcc
CXX=g++
OURCFLAGS=$(debug) -W -Wall -Wimplicit -Wno-char-subscripts -Wno-unused \
	-funsigned-char -fno-strict-aliasing -DNO_GCC_BUILTINS -DNOCOPYPROTECT \
	-I$(INC) -I$(EINC) -I$(SRC)/jmact -I$(JAUDIOLIBDIR)/include
OURCXXFLAGS=-fno-exceptions -fno-rtti
LIBS=-lm
GAMELIBS=
NASMFLAGS=-s #-g
EXESUFFIX=exe

JMACTOBJ=$(OBJ)/util_lib.$o \
	$(OBJ)/file_lib.$o \
	$(OBJ)/control.$o \
	$(OBJ)/keyboard.$o \
	$(OBJ)/mouse.$o \
	$(OBJ)/mathutil.$o \
	$(OBJ)/scriplib.$o

GAMEOBJS=$(OBJ)/game.$o \
	$(OBJ)/actors.$o \
	$(OBJ)/gamedef.$o \
	$(OBJ)/global.$o \
	$(OBJ)/menus.$o \
	$(OBJ)/player.$o \
	$(OBJ)/premap.$o \
	$(OBJ)/sector.$o \
	$(OBJ)/rts.$o \
	$(OBJ)/config.$o \
	$(OBJ)/animlib.$o \
	$(OBJ)/testcd.$o \
	$(OBJ)/osdfuncs.$o \
	$(OBJ)/osdcmds.$o \
	$(OBJ)/grpscan.$o \
	$(OBJ)/sounds.$o \
	$(JMACTOBJ)

EDITOROBJS=$(OBJ)/astub.$o

include $(EROOT)/Makefile.shared

ifeq ($(PLATFORM),LINUX)
	NASMFLAGS+= -f elf
	GAMELIBS+= $(JFAUDIOLIB_LDFLAGS)
endif
ifeq ($(PLATFORM),AROS)
	GAMELIBS+= $(JFAUDIOLIB_LDFLAGS)
	EXESUFFIX=
	NOASM = 1
	USE_A_C = 1
endif
ifeq ($(PLATFORM),WINDOWS)
	OURCFLAGS+= -DUNDERSCORES -I$(DXROOT)/include
	NASMFLAGS+= -DUNDERSCORES -f win32
	GAMEOBJS+= $(OBJ)/gameres.$o $(OBJ)/winbits.$o $(OBJ)/startwin.game.$o
	EDITOROBJS+= $(OBJ)/buildres.$o
	GAMELIBS+= -ldsound \
	       $(JAUDIOLIBDIR)/third-party/mingw32/lib/libvorbisfile.a \
	       $(JAUDIOLIBDIR)/third-party/mingw32/lib/libvorbis.a \
	       $(JAUDIOLIBDIR)/third-party/mingw32/lib/libogg.a
endif

ifeq ($(RENDERTYPE),SDL)
	OURCFLAGS+= $(subst -Dmain=SDL_main,,$(shell sdl-config --cflags))

	ifeq (1,$(HAVE_GTK2))
		OURCFLAGS+= -DHAVE_GTK2 $(shell pkg-config --cflags gtk+-2.0)
		GAMEOBJS+= $(OBJ)/game_banner.$o $(OBJ)/startgtk.game.$o
		EDITOROBJS+= $(OBJ)/editor_banner.$o
	endif
	
	ifeq (1,$(HAVE_MUI))
		GAMEOBJS+= $(OBJ)/startmui.game.$o
	endif

ifneq ($(PLATFORM),AROS)
	GAMEEXEOBJS+= $(OBJ)/game_icon.$o
	EDITOREXEOBJS+= $(OBJ)/build_icon.$o
endif
endif

OURCFLAGS+= $(BUILDCFLAGS)

.PHONY: clean all engine $(EOBJ)/$(ENGINELIB) $(EOBJ)/$(EDITORLIB) $(JAUDIOLIBDIR)/$(JFAUDIOLIB)

# TARGETS

# Invoking Make from the terminal in OSX just chains the build on to xcode
ifeq ($(PLATFORM),DARWIN)
ifeq ($(RELEASE),0)
style=Development
else
style=Deployment
endif
.PHONY: alldarwin
alldarwin:
	cd osx && xcodebuild -target All -buildstyle $(style)
endif

all: Duke3dw$(EXESUFFIX) buildw$(EXESUFFIX)

all:
	$(BUILD_FINISHED)
	@ls -l Duke3dw$(EXESUFFIX)

Duke3dw$(EXESUFFIX): $(GAMEOBJS) $(EOBJ)/$(ENGINELIB) $(JAUDIOLIBDIR)/$(JFAUDIOLIB)
	$(CXX) $(CXXFLAGS) $(OURCXXFLAGS) $(OURCFLAGS) -o $@ $^ $(LIBS) $(GAMELIBS) #-Wl,-Map=$@.map
ifeq ($(RELEASE),1)
	 #strip Duke3dw$(EXESUFFIX)
endif

buildw$(EXESUFFIX): $(EDITOROBJS) $(EOBJ)/$(EDITORLIB) $(EOBJ)/$(ENGINELIB)
	$(CXX) $(CXXFLAGS) $(OURCXXFLAGS) $(OURCFLAGS) -o $@ $^ $(LIBS) -Wl,-Map=$@.map

include Makefile.deps

.PHONY: enginelib editorlib
enginelib editorlib:
	$(MAKE) -C $(EROOT) "OBJ=$(CURDIR)/$(EOBJ)" \
	SUPERBUILD=$(SUPERBUILD) POLYMOST=$(POLYMOST) \
	USE_OPENGL=$(USE_OPENGL) DYNAMIC_OPENGL=$(DYNAMIC_OPENGL) \
	NOASM=$(NOASM) RELEASE=$(RELEASE) $@

$(EOBJ)/$(ENGINELIB): enginelib
$(EOBJ)/$(EDITORLIB): editorlib
$(JAUDIOLIBDIR)/$(JFAUDIOLIB):
	$(MAKE) -C $(JAUDIOLIBDIR)

# RULES
$(OBJ)/%.$o: $(SRC)/%.nasm
	nasm $(NASMFLAGS) $< -o $@

$(OBJ)/%.$o: $(SRC)/%.c
	$(CC) $(CFLAGS) $(OURCFLAGS) -c $< -o $@ 2>&1

$(OBJ)/%.$o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) $(OURCXXFLAGS) $(OURCFLAGS) -c $< -o $@ 2>&1

$(OBJ)/%.$o: $(SRC)/jmact/%.c
	$(CC) $(CFLAGS) $(OURCFLAGS) -c $< -o $@ 2>&1

$(OBJ)/%.$o: $(SRC)/misc/%.rc
	windres -i $< -o $@ --include-dir=$(EINC) --include-dir=$(SRC)

$(OBJ)/%.$o: $(SRC)/util/%.c
	$(CC) $(CFLAGS) $(OURCFLAGS) -c $< -o $@ 2>&1

$(OBJ)/%.$o: $(RSRC)/%.c
	$(CC) $(CFLAGS) $(OURCFLAGS) -c $< -o $@ 2>&1

$(OBJ)/game_banner.$o: $(RSRC)/game_banner.c
$(OBJ)/editor_banner.$o: $(RSRC)/editor_banner.c
$(RSRC)/game_banner.c: $(RSRC)/game.bmp
	echo "#include <gdk-pixbuf/gdk-pixdata.h>" > $@
	gdk-pixbuf-csource --extern --struct --raw --name=startbanner_pixdata $^ | sed 's/load_inc//' >> $@
$(RSRC)/editor_banner.c: $(RSRC)/build.bmp
	echo "#include <gdk-pixbuf/gdk-pixdata.h>" > $@
	gdk-pixbuf-csource --extern --struct --raw --name=startbanner_pixdata $^ | sed 's/load_inc//' >> $@

# PHONIES
clean:
ifeq ($(PLATFORM),DARWIN)
	cd osx && xcodebuild -target All clean
else
	-rm -f $(OBJ)/*
	-rm -f $(EOBJ)/*
    #$(MAKE) -C $(EROOT) clean
	$(MAKE) -C $(JAUDIOLIBDIR) clean
endif

veryclean: clean
ifeq ($(PLATFORM),DARWIN)
else
	-rm -f Duke3dw$(EXESUFFIX) build$(EXESUFFIX) core*
	$(MAKE) -C $(EROOT) veryclean
endif

ifeq ($(PLATFORM),WINDOWS)
.PHONY: datainst
datainst:
	cd datainst && $(MAKE) GAME=Duke3dw
endif
