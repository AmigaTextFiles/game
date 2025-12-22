#DESTDIR=/home/guigui/install

CFLAGS  = -g -Wall $$(sdl-config --cflags) -DHAVE_OPENGL# -pg # pour gprof
LDFLAGS = -O2# -pg
LDLIBS  = $$(sdl-config --libs) -lSDL_image -lSDL_mixer -lSDL_ttf

OBJS =  graphics.o font.o list.o sprite.o events.o editor_texts.o \
	Splayer.o Sother.o \
	mixer.o level_file.o level.o worldmap.o edit_keys.o menu.o

EXEOB = MoleInvasion
EDTOB = editor

LINEXE = ../lin/MoleInvasion
LINEDT = ../lin/editor

WINEXE = ../win/MoleInvasion.exe
WINEDT = ../win/editor.exe

FINALEXEDIR=$(DESTDIR)/usr/games
FINALDATADIR=$(DESTDIR)/usr/share/games/moleinvasion

CFLAGS+=-DDATADIR='"$(FINALDATADIR)"'

all: linux

linux : $(LINEXE) $(LINEDT)

mgwin : $(WINEXE) $(WINEDT)

install:
	echo moo
	cp $(LINEXE) $(FINALEXEDIR)/moleinvasion
	cp $(LINEDT) $(FINALEXEDIR)/moleinvasion-editor

install-data:
	mkdir -p $(FINALDATADIR)/gfx
	mkdir -p $(FINALDATADIR)/snd
	mkdir -p $(FINALDATADIR)/lvl
	mkdir -p $(FINALDATADIR)/txt
	mkdir -p $(FINALDATADIR)/font
	cp -rf ../gfx ../font ../lvl ../snd ../txt $(FINALDATADIR)/
	find $(FINALDATADIR)/ -name "*.*g" -exec chmod -x {} \;
	-find $(FINALDATADIR)/ -name ".xvpics" -exec rm -rf {} \;

clean:; rm -f *.o $(LINEXE) $(LINEDT) $(WINEXE) $(WINEDT)	

$(WINEXE): $(OBJS) $(EXEOB).o
	$(CC) $(LDFLAGS) $+ $(LOADLIBES) $(LDLIBS) -o $@
$(WINEDT): $(OBJS) $(EDTOB).o
	$(CC) $(LDFLAGS) $+ $(LOADLIBES) $(LDLIBS) -o $@

$(LINEXE): $(OBJS) $(EXEOB).o
	$(CC) $(LDFLAGS) $+ $(LOADLIBES) $(LDLIBS) -o $@
$(LINEDT): $(OBJS) $(EDTOB).o
	$(CC) $(LDFLAGS) $+ $(LOADLIBES) $(LDLIBS) -o $@
