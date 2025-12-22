CC= lc
CFLAGS= -ba -cw -dDGK

#
OBJ=	action.o amiga.o bill.o config.o create.o data.o diag.o display.o \
	iventory.o fortune.o global.o help.o io.o main.o monster.o \
	moreobj.o movem.o msdos.o nap.o object.o regen.o savelev.o \
	scores.o signal.o spells.o spheres.o store.o \
	tok.o vms.o
#
#


larn: $(OBJ)
	blink with adoslarn.lnk

clean:
	-delete \#?.o TAGS
