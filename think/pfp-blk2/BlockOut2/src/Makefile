#---------------------------------------------------------------------
# Makefile for BlockOut
#
# Need SDL-1.2.12
#      SDL_mixer-1.2.8
#
# Note: Sorry to not have libtoolized this project but i don't have
#       enough time to do that.

#---------------------------------------------------------------------
# All source files needed for the application

SRC = 	BlockOut.cpp         PageChooseSetup.cpp       PageStartGame.cpp \
	EditControl.cpp      PageControls.cpp          Pit.cpp \
	Game.cpp             PageCredits.cpp           PolyCube.cpp \
	Http.cpp             PageHallOfFame.cpp        SetupManager.cpp \
	InitPolyCube.cpp     PageHallOfFameOnLine.cpp  SoundManager.cpp \
	Menu.cpp             PageHttp.cpp              Sprites.cpp \
	MenuGraphics.cpp     PageMainMenu.cpp          Utils.cpp \
	MenuGrid.cpp         PageOptions.cpp           PageChangeSetup.cpp  \
	PageScoreDetails.cpp PageGSOptions.cpp         BotPlayer.cpp \
	GLApp/GLApp.cpp  GLApp/GLFont.cpp  GLApp/GLMatrix.cpp  GLApp/GLSprite.cpp

OBJ=    BlockOut.o         PageChooseSetup.o       PageStartGame.o \
	EditControl.o      PageControls.o          Pit.o \
	Game.o             PageCredits.o           PolyCube.o \
	Http.o             PageHallOfFame.o        SetupManager.o \
	InitPolyCube.o     PageHallOfFameOnLine.o  SoundManager.o \
	Menu.o             PageHttp.o              Sprites.o \
	MenuGraphics.o     PageMainMenu.o          Utils.o \
	MenuGrid.o         PageOptions.o           PageChangeSetup.o  \
	PageScoreDetails.o PageGSOptions.o         BotPlayer.o \
	GLApp/GLApp.o  GLApp/GLFont.o  GLApp/GLMatrix.o  GLApp/GLSprite.o

#---------------------------------------------------------------------

SDL_ROOT	= /users/pons/test/opengl/SDL
IMGLIB_ROOT	= ../ImageLib

CXX		= g++

CXXFLAGS =     -g -D_DEBUG -Dlinux -c \
               -I$(SDL_ROOT)/include/SDL -I$(IMGLIB_ROOT) -I.

LIBS	 =     -L$(SDL_ROOT)/lib -L$(IMGLIB_ROOT)

LFLAGS   =      $(LIBS) -limagelib -lGL -lGLU -lSDL_mixer -lSDL -lpthread -lm -ldl 

#--------------------------------------------------------------------

all: blockout

blockout: $(OBJ)
	@echo Linking...
	@rm -f blockout
	$(CXX) $(OBJ) $(LFLAGS) -o blockout
	@echo Linking OK...

clean:
	@echo Cleaning...
	@rm -f *.o
	@rm -f GLApp/*.o
