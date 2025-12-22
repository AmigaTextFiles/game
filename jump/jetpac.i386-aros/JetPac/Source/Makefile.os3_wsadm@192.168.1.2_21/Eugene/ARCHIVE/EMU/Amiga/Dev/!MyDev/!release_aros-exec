#PREFIX= /usr/local#INCLUDES= `sdl-config --cflags`#LIBS= `sdl-config --libs`#CFLAGS= $(INCLUDES) $(LIBS)
CFLAGS = -ISDK:Local/clib2/include/SDL -IUSR:local/include -O2
LIBS = -lSDL_mixer -LSDK:Local/clib2/lib -lSDL_image -lSDLmain -LUSR:local/lib -lpng -ljpeg -lz -lSDL -lvorbisfile -lvorbis -logg -lauto -lm

OBJS= jetpac.o game.o menu.o graphics.o levels.o
CPP= g++


jetpac: $(OBJS)
	@echo 'Linking jetpac'
	$(CPP) -o jetpac $(OBJS) $(CFLAGS) $(LIBS)

%.o: %.cpp
	@echo 'Compiling $<'
	@$(CPP) $(CFLAGS) -c -o $@ $< -Wall

clean:
	@echo 'Removing old object modules'
	rm -f *.o jetpac

install: jetpac
	@echo 'Creating Directory $(PREFIX)/games/lib/jetpac'
	@mkdir -p $(PREFIX)/games/lib/jetpac
	@echo 'Copying Files'
	@cp -r pixmaps jetpac $(PREFIX)/games/lib/jetpac
	@echo 'Creating Link $(PREFIX)/bin/jetpac'
	@echo -e 'cd $(PREFIX)/games/lib/jetpac \n./jetpac' > $(PREFIX)/bin/jetpac
	@chmod +x $(PREFIX)/bin/jetpac

uninstall:
	@echo 'Uninstalling jetpac'
	@rm -rf $(PREFIX)/games/lib/jetpac
	@rm -f $(PREFIX)/bin/jetpac	
