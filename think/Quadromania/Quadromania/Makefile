#
# Makefile for SDL stuff, using MorphOS SDK (gcc 2.95.3)
#

CFLAGS =	-c						\
		-pipe						\
		-O2						\
		-Wall						\
								\
		-I gg:include/SDL				\
								\
		-noixemul

PRG =		Quadromania
LIBS =		-noixemul -lSDL_imageshared -lSDL -lpng -ljpeg -lz -s
CC =		gcc
LD =		gcc
OBJDUMP =	objdump
RM =		rm

.c.o:
	${CC} ${CFLAGS} $< -o $@

SRC =	src/SFont.c						\
	src/graphics.c						\
	src/main.c						\
	src/quadromania.c					\
	src/random.c

OBJ =	$(SRC:.c=.o)

$(PRG): $(OBJ)
	${LD} -o $(PRG) $(OBJ) $(LIBS)

dump: $(PRG)
	$(OBJDUMP) --reloc --disassemble-all $(PRG) > $(PRG).s

clean:
	$(RM) -fv $(OBJ) $(PRG) $(PRG).s
