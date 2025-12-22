## Makefile for 'Orm'
## Torsten Poulin 12-Oct-93
##
## The source code for 'Orm' can be compiled without change
## using either DICE or SAS/C.

## Uncomment the following three lines to use SAS/C 5.10
#CC = lc
#LOPTS = -Lvcdn
#COPTS = -v -cis -rr -O -ms $(LOPTS)
## Uncomment the following three lines to use DICE
CC = dcc
LOPTS = -l locales.lib
COPTS = $(LOPTS) -o Orm

Orm: orm.c orm.h
	$(CC) $(COPTS) Orm.c

orm.h: orm.cd
	catcomp orm.cd cfile Orm.h

archive:
	-delete orm.lha quiet > nil:
	lha -r a orm.lha #?

orm.man: orm.6
	nroff -man orm.6 > orm.man

clean:
	-delete orm.lnk quiet
	-delete orm.o quiet

## Uncomment the following lines if you use Ben Eng's BMake;
## leave them commented out if you use SAS lmk:
orm.cd: .NEVER
orm.6: .NEVER

