EXTERN_LIBS = `sdl-config --libs --cflags` -lSDL_image 
CC = gcc -ggdb 

all: $(OBJF)
	$(CC) $(EXTERN_LIBS) -o eremit src/eremit.c src/board.c

install: sdlwin
	@echo "No installation, run from this dir"

clean:
	@echo "Cleaning project..."
	@find . -name '*.o' -exec rm "{}" \;
	@if [ -f eremit ]; then rm -f eremit; fi

distclean: clean
	rm -f Makefile




