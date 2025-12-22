# Makefile for popstar
#
# Bill Kendrick
# bill@newbreedsoftware.com
# http://www.newbreedsoftware.com/
#
# June 27, 2006 - June 28, 2006

PREFIX=

DATA_PREFIX=
DOC_PREFIX=

CFLAGS=-Wall -O2 `sdl-config --cflags` -DDATA_PREFIX=\"$(DATA_PREFIX)\"
LIBS=`sdl-config --libs` -lSDL_image -lSDL_mixer -lm

all:	popstar


clean:
	-rm popstar
	-rm *.o

install:
	@echo Installing executable
	cp popstar $(PREFIX)bin/
	chmod a=rx,g=rx,u=rwx $(PREFIX)bin/popstar
	@echo Installing data files
	install -d $(DATA_PREFIX)
	cp -R data/* $(DATA_PREFIX)
	chmod a=rX,g=rX,u=rwX $(DATA_PREFIX)
	@echo Installing documentation
	install -d $(DOC_PREFIX)
	cp -R docs/* $(DOC_PREFIX)
	chmod a=rX,g=rX,u=rwX $(DOC_PREFIX)

uninstall:
	-rm $(PREFIX)bin/popstar
	-rm -r $(DATA_PREFIX)

popstar:	popstar.o
	$(CC) $(CFLAGS) popstar.o -o popstar $(LIBS)

popstar.o:	popstar.c
	$(CC) $(CFLAGS) popstar.c -c -o popstar.o

