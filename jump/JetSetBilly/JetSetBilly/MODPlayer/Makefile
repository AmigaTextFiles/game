#
ASM = a68k
CC = sc
#CFLAGS =
#DBG=F
#
LIBS = LIB:sc.lib LIB:amiga.lib

all: modplayer.o loadmod.o playtest

modplayer.o: modplayer.a
	$(ASM) modplayer.a

loadmod.o: loadmod.a
	$(ASM) loadmod.a

playtest: playtest.o modplayer.o
	sc LINK SCODE SDATA playtest.o loadmod.o modplayer.o TO playtest

playtest.o: playtest.c
