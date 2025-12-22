PROG = viruskiller
PAKNAME = viruskiller.pak
DOCS = doc/*
ICONS = icons/

VERSION = 1.0
RELEASE = 1
USEPAK = 1

PREFIX=
BINDIR =
DATADIR = gamedata/
DOCDIR = doc/$(PROG)-$(VERSION)-$(RELEASE)/
ICONDIR = icons/
KDE = $(PREFIX)/share/applnk/Games/Arcade/
GNOME = $(PREFIX)/share/gnome/apps/Games/

SAFEDIR = env:

CFLAGS += -newlib -Isdk:local/newlib/include/SDL -DVERSION=$(VERSION) -DRELEASE=$(RELEASE) -DUSEPAK=$(USEPAK) -DDEBUG
CFLAGS += -DPAKNAME=\"$(PAKNAME)\" -DPAKLOCATION=\"$(DATADIR)\" -DSAFEDIR=\"$(SAFEDIR)\" -DGAMEPLAYMANUAL=\"$(DOCDIR)manual.html\" -Wall
LIBS = -newlib -lSDL_mixer -lvorbisfile -lvorbis -lsmpeg -logg -lSDL_image -ljpeg -lpng -lSDL_ttf -lfreetype -lSDL -lz -lm -lauto -lpthread
#LIBS = -newlib -LSDK:local/freetype2/ -lSDL_mixer -lsmpeg -lSDL_image -lSDL_ttf -lSDL -lSDLmain -ljpeg -lpng -lz -lpthread -lvorbisfile -lvorbis -logg -lfreetype -lm -lauto

OBJS += CAudio.o 
OBJS += CBase.o
OBJS += CCollision.o 
OBJS += CData.o CDirectory.o 
OBJS += CEngine.o 
OBJS += CFile.o CFileData.o 
OBJS += CGameData.o CGameObject.o CGraphics.o 
OBJS += CHighScore.o 
OBJS += CItem.o 
OBJS += CList.o 
OBJS += CMath.o 
OBJS += CPak.o CParticle.o
OBJS += CSprite.o 
OBJS += CVirus.o 
OBJS += CWidget.o

OBJS += filesAndDirectories.o 
OBJS += game.o
OBJS += init.o items.o 
OBJS += highscores.o 
OBJS += main.o 
OBJS += particles.o
OBJS += resources.o 
OBJS += title.o 
OBJS += viruses.o 
OBJS += widgets.o

PAKOBJS = CFileData.o pak.o

# top-level rule to create the program.
all: $(PROG) pak

# compiling other source files.
%.o: src/%.cpp src/%.h src/defs.h src/headers.h
	$(CXX) $(CFLAGS) -c $<

# linking the program.
$(PROG): $(OBJS)
	$(CXX) -o $(PROG) $(OBJS) $(LIBS)
	
pak: $(PAKOBJS)
	$(CXX)  -mcrt=newlib $(PAKOBJS) -o pak $(LIBS)

# cleaning everything that can be automatically recreated with "make".
clean:
	$(RM) $(OBJS)

buildpak:
	pak data gfx music sound $(PAKNAME)

# install
install:

	pak data gfx music sound $(PAKNAME)
	mkdir -p $(BINDIR)
	mkdir -p $(DATADIR)
	mkdir -p $(DOCDIR)
	mkdir -p $(ICONDIR)
	mkdir -p $(ICONDIR)mini
	mkdir -p $(ICONDIR)large
	mkdir -p $(KDE)
	mkdir -p $(GNOME)

	strip $(PROG)
	install -o root -g games -m 755 $(PROG) $(BINDIR)$(PROG)
	install -o root -g games -m 644 $(PAKNAME) $(DATADIR)$(PAKNAME)
	cp $(DOCS) $(DOCDIR)
	cp $(ICONS)$(PROG).png $(ICONDIR)
	cp $(ICONS)$(PROG)-mini.png $(ICONDIR)mini/$(PROG).png
	cp $(ICONS)$(PROG)-large.png $(ICONDIR)large/$(PROG).png
	cp $(ICONS)$(PROG).desktop $(KDE)
	cp $(ICONS)$(PROG).desktop $(GNOME)
