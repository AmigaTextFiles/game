EXTERN_LIBS =  -mcrt=newlib  -lsmpeg -lstdc++   -lsdl_image -lm -lsdl -lauto   -lpthread -lpng -ljpeg -lz

all: $(OBJF)
	gcc $(EXTERN_LIBS) -o eremit eremit.c board.c

install: sdlwin
	@echo "No installation, run from this dir"

clean:
	@echo "Cleaning project..."
	@find . -name '*.o' -exec rm "{}" \;
	@if [ -f eremit ]; then rm -f eremit; fi

distclean: clean
	rm -f Makefile




