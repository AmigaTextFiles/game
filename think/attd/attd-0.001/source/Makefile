# makefile for AddTraction
# see README for everything you may want to know ;)

BITMAP_PATH = bmps/
INSTALL_PATH = /usr/bin
INSTALL_EXEC = cp

all:
	gcc -noixemul -lSDL -I/usr/local/include -DBITMAP_PATH=\"$(BITMAP_PATH)\" -O2 -o addt -lSDL addt.c -lSDL

install:
	mkdir -p $(BITMAP_PATH)
	$(INSTALL_EXEC) bmps/* $(BITMAP_PATH)
	$(INSTALL_EXEC) addt $(INSTALL_PATH)

clean:
	rm addt

uninstall:
	rm $(BITMAP_PATH)/*.bmp
	rmdir $(BITMAP_PATH)
	rm $(INSTALL_PATH)/addt
