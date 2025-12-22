NAME	= map8edit
CC	= vc
COPTS	= -O1
AS	= vasmm68k_mot
ASOBJ	= -Fhunk
ASBIN	= -Fbin
ASOPTS	= -quiet -x -I :SDK/NDK_3.9/Include/include_i
LD	= vlink
LDOPTS  = -bamigahunk -s -x
RM	= delete force quiet

DO_AS	= $(AS) $(ASOBJ) $(ASOPTS) -o $@ $<

OBJ	= startup.o os.o init.o interrupt.o display.o input.o \
          main.o end.o


all: $(NAME)

clean:
	$(RM) $(NAME) $(OBJ) gfx/numbers.bin gfx/bmptoraw

$(NAME): $(OBJ)
	$(LD) $(LDOPTS) -o $@ $(OBJ)


# program sources

startup.o: startup.asm custom.i
	$(DO_AS)

os.o: os.asm custom.i
	$(DO_AS)

init.o: init.asm custom.i cia.i interrupt.i
	$(DO_AS)

interrupt.o: interrupt.asm custom.i interrupt.i macros.i
	$(DO_AS)

display.o: display.asm custom.i display.i map.i view.i macros.i
	$(DO_AS)

main.o: main.asm custom.i display.i map.i main.i view.i macros.i \
        gfx/numbers.bin
	$(DO_AS)

input.o: input.asm custom.i
	$(DO_AS)

end.o: end.asm
	$(DO_AS)


# graphics

gfx/numbers.bin: gfx/numbers.bmp gfx/bmptoraw
	gfx/bmptoraw gfx/numbers.bmp 16 16 5 MASK > $@

gfx/bmptoraw: gfx/bmptoraw.c
	$(CC) $(COPTS) -o $@ gfx/bmptoraw.c
