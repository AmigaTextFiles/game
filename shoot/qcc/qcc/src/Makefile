CC=gcc
CFLAGS = -D__BIG_ENDIAN__ -fomit-frame-pointer -m68030 -m68881 -O3 -s
EXES = qcc

all: $(EXES)

clean:
	rm -f *.o $(EXES)

.c.o: ; gcc -c $(CFLAGS) -o $@ $*.c

QCCFILES = qcc.o pr_lex.o pr_comp.o cmdlib.o
qcc : $(QCCFILES)
	gcc -noixemul $(CFLAGS) -o qcc $(QCCFILES) -lm
