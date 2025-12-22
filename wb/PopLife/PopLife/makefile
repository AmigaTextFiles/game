#:ts=8
#
#	Makefile for PopLife
#

PopLife:	poplife.o simplestartup.o
		ln -m -o PopLife poplife.o simplestartup.o -lc

debug:		poplife.o simplestartup.o
		ln -w -o PopLife poplife.o simplestartup.o -lc

poplife.o:	poplife.c dmp
		cc +idmp poplife.c

simplestartup.o:	simplestartup.c dmp
		cc +idmp simplestartup.c

crash:		crash.o
		ln -w crash.o simplestartup.o -lc

crash.o:	crash.c
		cc +idmp crash.c

dmp:		structures.h
		cc -a +hdmp structures.h
		delete structures.asm
