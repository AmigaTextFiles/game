
GRAPHICS=$(wildcard *.png)
SOUNDS=$(wildcard *.ogg)

all: graphics_data.c sounds_data.c

data2csrc: data2csrc.o

graphics_data.c: data2csrc $(GRAPHICS)
	(for i in $(GRAPHICS); do ./data2csrc $$i; done)>graphics_data.c

sounds_data.c: data2csrc $(SOUNDS)
	(for i in $(SOUNDS); do ./data2csrc $$i; done)>sounds_data.c

clean:
	rm -f data2csrc data2csrc.exe *.o graphics_data.c sounds_data.c

.PHONY: clean all
.DEFAULT: all

