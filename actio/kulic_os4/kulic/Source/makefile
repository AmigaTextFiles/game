
CC = @gcc
LD = @g++
CFLAGS = -c -Wall -char -Wextra -Wwrite-strings
IFLAGS = -ISDK:Local/newlib/include/allegro -Iinclude
LFLAGS = -use-dynld -lallegro -ljpeg -lauto

ifdef DEBUG
	OBJ = Debug
	CFLAGS += -ggdb -D_DEBUG -DDEBUGMODE=1
else
	OBJ = Release
	CFLAGS += -O2
endif

EXECUTABLE = $(OBJ)/Kulic

OBJECTS = $(OBJ)/GAI.o $(OBJ)/GFONT.o $(OBJ)/GMAP.o $(OBJ)/GMENU.o $(OBJ)/GMenuBack.o \
	$(OBJ)/GMenuBackFading.o $(OBJ)/GMenuMulti.o $(OBJ)/GMENUSET.o $(OBJ)/GMenuSingle.o \
	$(OBJ)/GPOWERUP.o $(OBJ)/GRUN.o $(OBJ)/GSOLDIER.o $(OBJ)/GSShoots.o $(OBJ)/GSTRELA.o \
	$(OBJ)/GVIEW.o $(OBJ)/HAntiAlias.o $(OBJ)/Hcollight.o $(OBJ)/HFader.o $(OBJ)/HGFX.o \
	$(OBJ)/HLIGHTS.o $(OBJ)/Hload_JPG.o $(OBJ)/Hmaskblit.o $(OBJ)/HScreen.o $(OBJ)/HScreenFader.o \
	$(OBJ)/HWarping.o $(OBJ)/main.o $(OBJ)/stdh.o

All: $(OBJ) $(EXECUTABLE)

$(OBJ):
	@MakeDir $(OBJ)

$(EXECUTABLE): $(OBJECTS)
	@echo Linking $@...
	$(LD) $(OBJECTS) $(LFLAGS) -o $@.debug
	@strip -S --strip-unneeded $@.debug -o $@

$(OBJ)/%.o: src/%.cpp
	@echo Compiling $<...
	$(CC) $(CFLAGS) $(IFLAGS) -o $(OBJ)/$*.o $<

clean:
	@rm -fr $(OBJ)
