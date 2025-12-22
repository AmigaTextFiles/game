
# $VER: makefile 50.1 (16.6.2003)
 
OUTPUT = AmiChessMOS

CFLAGS = -O2 -noixemul -Wall
OBJS = atak.o book.o catalog.o epd.o eval.o genmove.o hash.o hung.o init.o iterate.o \
main.o move.o mui_board.o mui_chess.o mui_edit.o mui_field.o null.o \
output.o pgn.o quiesce.o random.o repeat.o search.o solve.o sort.o swap.o ttable.o \
util.o vars.o


###.PHONY: all clean

all: $(OUTPUT)

clean:
	-rm -f $(OBJS) *.bak *.s *.db $(OUTPUT)

###########################################################################
###########################################################################

$(OUTPUT).db: $(OBJS)
	gcc $(CFLAGS) -o $@ $(OBJS) -lsyscall

$(OUTPUT): $(OUTPUT).db
	ppc-morphos-strip -o $@ --remove-section .comment $<
	protect $(OUTPUT) +e

###########################################################################
###########################################################################

atak.o: atak.c common.h

book.o: book.c book.h catalog.h common.h

catalog.o: catalog.c catalog.h

epd.o: epd.c common.h

eval.o: eval.c eval.h common.h

genmove.o: genmove.c common.h

hash.o: hash.c common.h

hung.o: hung.c common.h

init.o: init.c common.h

iterate.o: iterate.c common.h catalog.h

main.o: main.c common.h

move.o: move.c common.h

mui_board.o: mui_board.c common.h

mui_chess.o: mui_chess.c common.h catalog.h

mui_edit.o: mui_edit.c common.h

mui_field.o: mui_field.c common.h

null.o: null.c common.h

output.o: output.c common.h

pgn.o: pgn.c common.h book.h

quiesce.o: quiesce.c common.h

random.o: random.c common.h

repeat.o: repeat.c common.h

search.o: search.c common.h

solve.o: solve.c common.h

sort.o: sort.c common.h

swap.o: swap.c common.h

ttable.o: ttable.c common.h

util.o: util.c common.h

vars.o: vars.c common.h




