#Linux Lunar Lander Makefile 2003-08-31

CC=gcc
CFLAGS = -newlib -ISDK:local/newlib/include/SDL -Wall -O3 
LIBS = -newlib -lSDL_image -lpng -ljpeg -lSDL -lz -lm -lauto -lpthread
OBJECTS= SFont.o
INSTDIR= 

LSL: $(OBJECTS) LSL.o
	$(CC) $(CFLAGS) -o LSL $(OBJECTS)  LSL.o $(LIBS)

install:
	@cp -f LSL $(INSTDIR)
	@chmod +x $(INSTDIR)/LSL
	@rm -rf /usr/share/games/LSL
	@mkdir -p /usr/share/games/LSL
	@cp -f *.png /usr/share/games/LSL
	@echo "Linux Shuttle Lander installation completed"
		
clean:	
	@rm -f *.o LSL

uninstall:
	@rm -rf $(INSTDIR)/LSL
	@rm -rf /usr/share/games/LSL
	@echo "Linux Shuttle Lander uninstall completed"	
