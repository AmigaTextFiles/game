###############################################################################
#
#   makefile for a SASC project
#
###############################################################################

NAME         = Snipe2d

###############################################################################

WARN =
DEF = 
DEBUG = -DNDEBUG -fno-builtin
DEBUG1 = -DNDEBUG
OPT = -O2 -funsigned-char -fomit-frame-pointer -fstrength-reduce -finline-functions
OPT1 = -O1 -funsigned-char -fomit-frame-pointer -fstrength-reduce -finline-functions
CPU = -mcpu=604e

#INCL= -ISDK:Include/include_h -ISDK:Include
INCL= -Isexpr

CC = gcc
LL = g++

RM  = delete all quiet
MKDIR = makedir

###############################################################################
LIBS = -L. -lsdl_mixer -lvorbisfile -lvorbis -logg -lsdl_image -ljpeg -lpng -lz -lsdl -lauto -lm -lnet

CFLAGS  = $(CPU) $(WARN) $(OPT) $(INCL) $(DEBUG) $(DEF)
CFLAGS1  = $(CPU) $(WARN) $(OPT) $(INCL) $(DEBUG1) $(DEF)

###############################################################################

PROG = 	ai.o binds.o gameover.o highscores.o logoscreen.o petopt.o prefs.o prints.o render_ai.o snipe2d.o target.o ui.o zooms.o \
		faststack.o io.o parser.o sexp.o sexp_ops.o

###############################################################################

all: $(NAME)

$(NAME): $(PROG) $(CC) $(CFLAGS) -o $@ $(PROG) $(LIBS)

link:
	$(LL) -o $(NAME) $(CFLAGS) $(PROG) $(LIBS)

###############################################################################

clean:
	-$(RM) #?.o
	-$(RM) $(NAME)

###############################################################################

ai.o:					snipe2d.h ai.cpp
	$(CC) -c $(CFLAGS) ai.cpp

binds.o:				snipe2d.h binds.h binds.cpp
	$(CC) -c $(CFLAGS) binds.cpp

gameover.o:			snipe2d.h gameover.cpp
	$(CC) -c $(CFLAGS) gameover.cpp

highscores.o:			snipe2d.h highscores.cpp
	$(CC) -c $(CFLAGS) highscores.cpp

logoscreen.o:			snipe2d.h logoscreen.cpp
	$(CC) -c $(CFLAGS) logoscreen.cpp

petopt.o:				snipe2d.h petopt.h petopt.cpp
	$(CC) -c $(CFLAGS) petopt.cpp

prefs.o:				snipe2d.h prefs.cpp
	$(CC) -c $(CFLAGS) prefs.cpp

prints.o:				snipe2d.h prints.cpp
	$(CC) -c $(CFLAGS) prints.cpp

render_ai.o:			snipe2d.h render_ai.cpp
	$(CC) -c $(CFLAGS) render_ai.cpp

target.o:				snipe2d.h target.cpp
	$(CC) -c $(CFLAGS) target.cpp

ui.o:					snipe2d.h ui.h ui.cpp
	$(CC) -c $(CFLAGS) ui.cpp

zooms.o:				snipe2d.h zooms.cpp
	$(CC) -c $(CFLAGS) zooms.cpp

snipe2d.o:			snipe2d.h snipe2d.cpp
	$(CC) -c $(CFLAGS) snipe2d.cpp

faststack.o:			sexpr/faststack.h sexpr/faststack.c
	$(CC) -c $(CFLAGS) sexpr/faststack.c

io.o:					sexpr/io.c
	$(CC) -c $(CFLAGS) sexpr/io.c

parser.o:				sexpr/parser.c
	$(CC) -c $(CFLAGS) sexpr/parser.c

sexp.o:				sexpr/sexp.h sexpr/sexp.c
	$(CC) -c $(CFLAGS) sexpr/sexp.c

sexp_ops.o:			sexpr/sexp_ops.h sexpr/sexp_ops.c
	$(CC) -c $(CFLAGS) sexpr/sexp_ops.c
