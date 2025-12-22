# BubleTrain Makefile.
# Copyright Adam Child (c) 2005, All rights reserved.

TARGET = bubbletrain

# build tools
GPP = g++ 

#INCLUDE = -I. `sdl-config --cflags` `xml2-config --cflags`
#LIBS = `xml2-config --libs` `sdl-config --libs` -lSDL_image -lSDL_mixer

INCLUDE = -newlib -O3 -Wall -c -fmessage-length=0 -Isdk:local/newlib/include/SDL -ISDK:local/newlib/include/libxml2
LIBS = -newlib -lsdlmain -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL_image -ljpeg -lpng -lSDL -lxml2 -lz -lunix -lauto -lpthread

SRCS = \
  AboutUs.o \
  Bubble.o \
  BubbleTrainWorld.o \
  Bullet.o \
  BulletFactory.o \
  Button.o \
  Cannon.o \
  Carriage.o \
  CarriageFactory.o \
  CheckBox.o \
  Control.o \
  ExplodingBubble.o \
  FastestTime.o \
  FastestTimeScreen.o \
  FastestTimeText.o \
  FileLoadSaveBox.o \
  Font.o \
  Game.o \
  GameEnd.o \
  GameSelect.o \
  General.o \
  Label.o \
  Level.o \
  LevelEditor.o \
  LevelTimer.o \
  ListBox.o \
  Log.o \
  MainMenu.o \
  MessageBox.o \
  Options.o \
  OptionsScreen.o \
  Slider.o \
  SplashScreen.o \
  TextBox.o \
  TextExplodingBubble.o \
  Theme.o \
  Track.o \
  TrackArc.o \
  TrackLine.o \
  TrackSpiral.o \
  Train.o \
  TrainStation.o \
  Window.o \
  WindowManager.o

all: $(TARGET)

$(TARGET): $(SRCS)
	$(GPP) -o $(TARGET) $(SRCS) $(LIBS)

clean:
	$(RM) -f bubbletrain *.o

.cpp.o:
	$(GPP) $(INCLUDE) -c $< -o $@ 
