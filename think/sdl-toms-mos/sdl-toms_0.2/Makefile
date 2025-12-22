# NOTE!!
# The compile time DEFINES are now stored in  config.h.
# The advantage of this, is that when you change config.h,
# make will notice that you've done so, and will know to
# remake everything. Previously, you had to do "make clean"
# before it would remake everything.
# Bear in mind that the defines in config.h are done slightly
# differently- but the differences should be described there.
#
# You should now not need to edit this Makefile, except to
# do things like set library names, include paths, etc etc.

INC= -I. `sdl-config --cflags`
#SOPTS= -g
# -g for debuggin, -pg for profiling, -O2 for optimising.
CFLAGS= -Wall --pedantic $(SOPTS) $(INC)


LIBS= `sdl-config --libs` -lSDL_image
MAINOBJS = chain.o\
           globals.o\
           graphics.o\
           main.o\
           menus.o


PROGS = sdl-toms
WINDEST = windist/sdl-toms
WINSTUFF = $(WINDEST)/* windist/sdl_toms.zip
all: Makefile.dep $(PROGS)

# use cross-make win(from *nix, with mingw based cross-compiler),
# *NOT* just make win!!
# Made "dosify.pl" to convert text files
win: Makefile.dep $(PROGS)
	mkdir -p $(WINDEST)
	mv sdl-toms $(WINDEST)/sdl-toms.exe
	cp *.png $(WINDEST)/
	cat GPL|./dosify.pl > $(WINDEST)/GPL.txt
	cat NEWS |./dosify.pl > $(WINDEST)/NEWS.txt
	cat README |./dosify.pl > $(WINDEST)/README.txt
	cat TODO |./dosify.pl > $(WINDEST)/TODO.txt
	cp /usr/local/cross-tools/i386-mingw32msvc/lib/SDL.dll $(WINDEST)/
	cp /usr/local/cross-tools/i386-mingw32msvc/lib/SDL_image.dll $(WINDEST)/
	cd windist&& zip -r sdl_toms sdl-toms

# the programs

sdl-toms: $(MAINOBJS)
	$(CC) -o sdl-toms $(MAINOBJS) $(LIBS)

# Admin functions.
clean:
	# ==== Making clean ====
	rm -f *.o Makefile.dep gmon.out $(WINSTUFF) $(PROGS)
	#  ==== Made clean ====

Makefile.dep depend: *.c
	for i in *.c; do $(CC) $(INC) -MM $$i;done >Makefile.dep


include Makefile.dep

.c.o:
	$(CC) $(CFLAGS) -c $<

