CFLAGS=-Wall -ansi -pedantic -I/usr/include/SDL -I/usr/local/include/SDL -I/usr/local/include -D_REENTRANT -DCPU=686 -O6 -m486 -Wall -ffast-math -fomit-frame-pointer -funroll-loops -c
O_FILES=graphics.o apool.o computer.o physics.o creatabl.o

apool: $(O_FILES)
	gcc -o apool $(O_FILES) -Wl,-rpath,/usr/lib -L/usr/lib/GL -L/usr/X11R6/lib/ -L/usr/lib -L/usr/local/lib -lSDL -lpthread -lSDL_gfx -lm
graphics.o: graphics.c apool.h Makefile
	gcc $(CFLAGS) graphics.c -o graphics.o
apool.o: apool.c apool.h Makefile
	gcc $(CFLAGS) apool.c -o apool.o
computer.o: computer.c apool.h Makefile
	gcc $(CFLAGS) computer.c -o computer.o
physics.o: physics.c apool.h Makefile
	gcc $(CFLAGS) physics.c -o physics.o
creatabl.o: creatabl.c Makefile apool.h
	gcc $(CFLAGS) creatabl.c -o creatabl.o

clean:
	rm -f *.o core

mrproper:
	rm -f *.o apool core *~
