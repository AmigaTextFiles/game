CC = gcc
LD = gcc
CFLAGS = -O3 -c -newlib -ISDK:local/newlib/includes/SDL -Dmain=SDLmain
LFLAGS = -newlib -lSDLmain -lSDL -lm -lauto -lpthread

target: game.o main_menu.o modern.o scores.o ta.o gfx_test.o
	$(LD) -o target game.o main_menu.o modern.o scores.o ta.o gfx_test.o $(LFLAGS)

game.o: game.c ta.h modern.h game.h scores.h
	$(CC) $(CFLAGS) game.c

gfx_test.o: gfx_test.c ta.h modern.h
	$(CC) $(CFLAGS) gfx_test.c

main_menu.o: main_menu.c ta.h modern.h
	$(CC) $(CFLAGS) main_menu.c

modern.o: modern.c modern.h ta.h
	$(CC) $(CFLAGS) modern.c

scores.o: scores.c ta.h modern.h
	$(CC) $(CFLAGS) scores.c

ta.o: ta.c ta.h scores.h modern.h game.h
	$(CC) $(CFLAGS) ta.c
