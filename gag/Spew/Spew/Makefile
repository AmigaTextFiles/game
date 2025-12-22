# Simple Makefile for spew (Lattice C 3.10 on Amiga)

HEADLNS =	"SPEW:headline"

CFLAGS =	-L -dDEFFILE=$(HEADLNS)

spew:		spew.c
		lc $(CFLAGS) spew.c

install:	spew
		assign SPEW: s:
		copy spew c:
		copy headline SPEW:
