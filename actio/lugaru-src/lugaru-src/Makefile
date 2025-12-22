
macosx := false
use_devil := false
use_fmod := false

ifeq ($(strip $(shell uname -s)),Darwin)
	macosx := true
endif

#OPT += -O0
OPT += -O3 -fno-strict-aliasing -falign-loops=16 -fno-math-errno
#OPT += -Os -fno-strict-aliasing

BINDIR := bin
RUNDIR := Data
SRCDIR := Source
GLUDIR := GLU

ifeq ($(strip $(macosx)),true)
	CXX := g++-4.0
	CC := gcc-4.0
	LD := g++-4.0

  	ifeq ($(strip $(use_devil)),true)
        $(error DEVIL isn't supported in the Mac OS X builds right now.)
    endif

  	ifeq ($(strip $(use_fmod)),true)
        $(error FMOD isn't supported in the Mac OS X builds right now.)
    endif

	ifeq ($(strip $(XCODE_DIR)),)
        XCODE_DIR := /Developer
    endif

	ifeq ($(strip $(macosx_arch)),)
	  	macosx_arch := $(shell uname -m)
	endif

	ifeq ($(strip $(macosx_arch)),ppc)
        macosx_arch_okay := true
        macosx_version_min := 10.4
        macosx_version_min_required := 1040
		macosx_sdk_dir := MacOSX10.4u.sdk
		macosx_gcc_dir := powerpc-apple-darwin10/4.0.1
		macosx_gcc_libdir := $(macosx_gcc_dir)
		macosx_cxx_dir := powerpc-apple-darwin8
    endif

	ifeq ($(strip $(macosx_arch)),i386)
        macosx_arch_okay := true
        macosx_version_min := 10.4
        macosx_version_min_required := 1040
		macosx_sdk_dir := MacOSX10.4u.sdk
		macosx_gcc_dir := i686-apple-darwin10/4.0.1
		macosx_gcc_libdir := $(macosx_gcc_dir)
		macosx_cxx_dir := i686-apple-darwin8
    endif

	ifeq ($(strip $(macosx_arch)),x86_64)
        macosx_arch_okay := true
        macosx_version_min := 10.6
        macosx_version_min_required := 1060
		macosx_sdk_dir := MacOSX10.6.sdk
		macosx_gcc_dir := i686-apple-darwin10/4.0.1
		macosx_gcc_libdir := $(macosx_gcc_dir)/x86_64
		macosx_cxx_dir := x86_64-apple-darwin8
    endif

	ifneq ($(strip $(macosx_arch_okay)),true)
        $(error Unknown Mac OS X architecture. Please update the makefile.)
    endif

   	EXEEXT := $(macosx_arch)

    CFLAGS += -arch $(macosx_arch)
    CFLAGS += -mmacosx-version-min=$(macosx_version_min)
    CFLAGS += -DMAC_OS_X_VERSION_MIN_REQUIRED=$(macosx_version_min_required)
    CFLAGS += -nostdinc
    CFLAGS += -F$(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/System/Library/Frameworks
    CFLAGS += -I$(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/usr/lib/gcc/$(macosx_gcc_dir)/include
    CFLAGS += -isystem $(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/usr/include
    CFLAGS += -isystem $(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/usr/include/c++/4.0.0
    CFLAGS += -isystem $(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/usr/include/c++/4.0.0/$(macosx_cxx_dir)
    CFLAGS += -isystem $(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/usr/include/c++/4.0.0/$(macosx_cxx_dir)/bits
    CFLAGS += -isystem $(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/usr/include/c++/4.0.0/backward
  	CFLAGS += -mdynamic-no-pic

    LDFLAGS += -arch $(macosx_arch)
    LDFLAGS += -mmacosx-version-min=$(macosx_version_min)
    LDFLAGS += -F$(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/System/Library/Frameworks
    LDFLAGS += -L$(XCODE_DIR)/SDKs/$(macosx_sdk_dir)/usr/lib/gcc/$(macosx_gcc_libdir)
    LDFLAGS += -Wl,-syslibroot,$(XCODE_DIR)/SDKs/$(macosx_sdk_dir)
  	LDFLAGS += -framework Cocoa -framework OpenGL -framework IOKit -framework CoreFoundation -framework Carbon -framework OpenAL
  	LDFLAGS += ./libSDL-1.2.0.dylib ./libSDLmain-osx.a
else
	CXX := g++
	CC := gcc
	LD := g++

  	CFLAGS += -DPLATFORM_LINUX=1
  	LDFLAGS += -Wl,-rpath,\$$ORIGIN

  	ifeq ($(strip $(use_devil)),true)
    	LDFLAGS += ./libIL.so.1 ./libILU.so.1 ./libILUT.so.1
  	endif

  	ifeq ($(strip $(use_fmod)),true)
    	POSTLDFLAGS += -lpthread ./libfmod-linux-x86.a
  	else
    	LDFLAGS += 
  	endif
endif

DEFINES += \
	-DPLATFORM_UNIX=1 \
	-DUSE_SDL=1 \
	-DTRUE=1 \
	-DFALSE=0 \
	-Dstricmp=strcasecmp \
	-DBinIO_STDINT_HEADER="<stdint.h>" \
        -DBinIO_BYTE_ORDER="BinIO_BIG_ENDIAN_BYTE_ORDER" \

INCLUDES += \
			-I$(SRCDIR) \
			-I/SDK/local/newlib/include/SDL \
			-I./OpenGL/ \
			-I./OpenGL/GL \

ifeq ($(strip $(use_devil)),true)
    DEFINES += -DUSE_DEVIL=1
    INCLUDES += -I$(SRCDIR)/devil/include
else
    DEFINES += -DZ_PREFIX=1
    INCLUDES +=
endif

ifeq ($(strip $(use_fmod)),false)
    DEFINES += -DUSE_OPENAL=1
    INCLUDES +=
endif

CFLAGS += -g -c $(OPT) $(INCLUDES) $(DEFINES) -fsigned-char -w


ifeq ($(strip $(EXEEXT)),)
   	EXEEXT := bin
endif
EXE := lugaru-$(EXEEXT)

CXXFLAGS := $(CFLAGS)

SRCS := \
	Frustum.cpp \
	GameDraw.cpp \
	GameInitDispose.cpp \
	GameTick.cpp \
	Globals.cpp \
	Lights.cpp \
	Models.cpp \
	Objects.cpp \
	pack.c \
	pack_private.c \
	Person.cpp \
	private.c \
	Quaternions.cpp \
	Random.c \
	Skeleton.cpp \
	Skybox.cpp \
	Sprites.cpp \
	Terrain.cpp \
	Text.cpp \
	TGALoader.cpp \
	unpack.c \
	unpack_private.c \
	Weapons.cpp \
	MacCompatibility.cpp \
	WinInput.cpp \
	OpenGL_Windows.cpp \
	openal_wrapper.cpp \

SRCS := $(foreach f,$(SRCS),$(SRCDIR)/$(f))

UNUSED_SRCS := \
	DRIVER.CC \
	MD5.CC \

GLUSRCS := \
	dict.c \
	geom.c \
	memalloc.c \
	mesh.c \
	mipmap.c \
	normal.c \
	priorityq.c \
	render.c \
	sweep.c \
	tess.c \
	tessmono.c \
	util.c \

GLUSRCS := $(foreach f,$(GLUSRCS),$(GLUDIR)/$(f))

ifeq ($(strip $(macosx)),false)
	SRCS += $(GLUSRCS)
endif

OBJS := $(SRCS:.CC=.o)
OBJS := $(OBJS:.cc=.o)
OBJS := $(OBJS:.cpp=.o)
OBJS := $(OBJS:.c=.o)
OBJS := $(OBJS:.m=.o)
OBJS := $(foreach f,$(OBJS),$(BINDIR)/$(f))

.PHONY: clean all

all : $(EXE)

$(BINDIR)/%.o : %.cpp
	@mkdir -p $(dir $@)
	$(CXX) -o $@ $(CXXFLAGS) $<

$(BINDIR)/%.o : %.CC
	@mkdir -p $(dir $@)
	$(CXX) -x c++ -o $@ $(CXXFLAGS) $<

$(BINDIR)/%.o : %.cc
	@mkdir -p $(dir $@)
	$(CXX) -o $@ $(CXXFLAGS) $<

$(BINDIR)/%.o : %.m
	@mkdir -p $(dir $@)
	$(CC) -o $@ $(CFLAGS) $<

$(BINDIR)/%.o : %.c
	@mkdir -p $(dir $@)
	$(CC) -o $@ $(CFLAGS) $<

$(EXE) : $(OBJS) $(APPOBJS)
	@mkdir -p $(dir $@)
	$(LD) -o $@ $(LDFLAGS) $(OBJS) $(APPOBJS) $(POSTLDFLAGS) -lSDL -lopenal -lpthread -lvorbisfile -lvorbisenc -lvorbis -logg -lGL -lpng -ljpeg -lz -lunix

clean:
	rm -f $(BINDIR)/*.o
	rm -f $(BINDIR)/$(SRCDIR)/*.o
	rm -f $(BINDIR)/$(GLUDIR)/*.o
	rm -f $(EXE)

# end of makefile ...

