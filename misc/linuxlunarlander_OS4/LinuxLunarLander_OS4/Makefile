#Linux Lunar Lander Makefile

CC=gcc
CFLAGS = -newlib -ISDK:local/newlib/include/SDL -Wall -O3 
LIBS =  -newlib -lSDL_image -lpng -ljpeg -lSDL -lz -lm -lauto -lpthread
OBJECTS= SFont.o
INSTDIR= 

LLL: $(OBJECTS) LLL.o
	$(CC) $(CFLAGS) -o LLL $(OBJECTS)  LLL.o $(LIBS)
	@echo "The executable is called LLL"

install:
	@cp -f LLL $(INSTDIR)
	@chmod +x $(INSTDIR)/LLL
	@rm -rf /usr/share/games/LLL
	@mkdir -p /usr/share/games/LLL
	@cp -f *.png /usr/share/games/LLL
	@echo "Linux Lunar Lander installation completed"
	
clean:	
	@rm -f *.o LLL

uninstall:
	@rm -rf $(INSTDIR)/LLL
	@rm -rf /usr/share/games
	@echo "Linux Lunar Lander uninstall completed"
	
