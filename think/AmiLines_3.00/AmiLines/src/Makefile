
EXE = AmiLines
FLAGS =
LIBS = -lm

OBJS = AmiLines.o

all: AmiLines

AmiLines.o: AmiLines.c gtlayout_internal.h gtlayout_global.h gtlayout.h
	gcc $(FLAGS) -newlib -c -o AmiLines.o AmiLines.c

AmiLines: $(OBJS)
	gcc -newlib -o $(EXE).debug $(OBJS) $(LIBS) -Wl,-Ttext,0
	strip $(EXE).debug -R.comment -o $(EXE)

clean:
	-delete #?.o
	-delete AmiLines


