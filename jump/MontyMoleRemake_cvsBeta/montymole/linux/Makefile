
# where our headers are
INC = -I../src/
OBJPATH = objects/
SRCPATH = ../src/
EXE = montymole
VPATH = ../src:objects
cc = g++

# SDL
SDL_CFLAGS := $(shell sdl-config --cflags)
SDL_LDFLAGS := $(shell sdl-config --libs)

files = KFile KPtrArray KJText\
	KSurface KScreen \
	MontyMap MontyScreen \
	MMMonty MMObject MMRoom MMRoomTests MMCrusher MMKiller MMSlider MMCoal MMHelper\
	main

#source =KFile.cpp KPtrArray.cpp KJText.cpp\
#	KSurface.cpp KScreen.cpp \
#	MontyMap.cpp MontyScreen.cpp \
#	MMMonty.cpp \
#	main.cpp

#objects= KFile.o KPtrArray.o KJText.o \
#	KSurface.o KScreen.o \
#	MontyMap.o MontyScreen.o\
#	MMMonty.o \
#	main.o

source:= $(addsuffix .cpp, $(files))
src=$(addprefix $(SRCPATH), $(source) )
obj=$(addsuffix .o, $(files) )
#obj=$(addprefix $(OBJPATH), $obj))


CFLAGS= -ansi -Wall -O2 $(SDL_CFLAGS)
LDFLAGS = -o $(EXE) $(SDL_LDFLAGS)

$.o : $.c
	$(cc) $(INC) -c $(CFLAGS) $< -o$(OBJPATH)$@

	
# MAIN LINKER
$(EXE) : $(obj)
	$(cc) -o$(EXE) $(INC) $(LDFLAGS) $(src)
	$(shell, "cp ./montymole ../.")
	
all : $(EXE)

.PHONY : clean
clean :
	rm -f ../$(EXE) $(OBJPATH)*.o *.o
