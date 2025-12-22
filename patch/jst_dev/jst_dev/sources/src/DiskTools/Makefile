CC = sc:c/sc
LINK = sc:c/slink
ASM = sys:commands/phxass
INSTALLDIR = sys:commands

all : boot2file disk2file psydir rippsyfiles ripcorefiles grem2file rob2file #sensidir raw2file ripsensifiles

boot2file : boot2file.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"boot2file.o" TO boot2file LIB LIB:sc.lib LIB:amiga.lib
	copy boot2file $(INSTALLDIR)

boot2file.o : boot2file.c
	$(CC) boot2file.c NOLINK NODEBUG

disk2file : disk2file.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"disk2file.o" TO disk2file LIB LIB:sc.lib LIB:amiga.lib
	copy disk2file $(INSTALLDIR)

raw2file : raw2file.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"raw2file.o" TO raw2file LIB LIB:sc.lib LIB:amiga.lib

rob2file_hard : readrobtrack.o rob2file_hard.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"readrobtrack.o"+"rob2file_hard.o" TO rob2file_hard LIB LIB:sc.lib LIB:amiga.lib

rob2file : robdecode.o rob2file.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"robdecode.o"+"rob2file.o" TO rob2file LIB LIB:sc.lib LIB:amiga.lib
	copy rob2file $(INSTALLDIR)

rippsyfiles : psydecode.o psywfiles.o rippsyfiles.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"psywfiles.o"+"psydecode.o"+"rippsyfiles.o" TO rippsyfiles LIB LIB:sc.lib LIB:amiga.lib
	copy rippsyfiles $(INSTALLDIR)

ripcorefiles : coredecode.o corewfiles.o ripcorefiles.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"corewfiles.o"+"coredecode.o"+"ripcorefiles.o" TO ripcorefiles LIB LIB:sc.lib LIB:amiga.lib

ripsensifiles : readsensitrack.o ripsensifiles.o trackmoves.o
	slink FROM LIB:c.o "trackmoves.o"+"readsensitrack.o"+"ripsensifiles.o" TO ripsensifiles LIB LIB:sc.lib LIB:amiga.lib

psydir : psydecode.o psydir.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"psydecode.o"+"psydir.o" TO psydir LIB LIB:sc.lib LIB:amiga.lib
	copy psydir $(INSTALLDIR)

grem2file : gremdecode.o grem2file.o
	slink FROM LIB:c.o "/jst/readdostrack.o"+"grem2file.o"+"gremdecode.o" TO grem2file LIB LIB:sc.lib LIB:amiga.lib
	copy grem2file $(INSTALLDIR)

sensidir : readsensitrack.o sensidir.o trackmoves.o
	slink FROM LIB:c.o "trackmoves.o"+"readsensitrack.o"+"sensidir.o" TO sensidir LIB LIB:sc.lib LIB:amiga.lib

disk2file.o : disk2file.c
	$(CC) disk2file.c NOLINK NODEBUG

raw2file.o : raw2file.c
	$(CC) raw2file.c NOLINK NODEBUG

rippsyfiles.o : rippsyfiles.c
	$(CC) rippsyfiles.c NOLINK NODEBUG

ripcorefiles.o : ripcorefiles.c
	$(CC) ripcorefiles.c NOLINK NODEBUG

ripsensifiles.o : ripsensifiles.c
	$(CC) ripsensifiles.c NOLINK NODEBUG

psydir.o : psydir.c
	$(CC) psydir.c NOLINK NODEBUG

grem2file.o : grem2file.c
	$(CC) grem2file.c NOLINK NODEBUG

rob2file.o : rob2file.c
	$(CC) rob2file.c NOLINK NODEBUG

rob2file_hard.o : rob2file_hard.c
	$(CC) rob2file_hard.c NOLINK NODEBUG

sensidir.o : sensidir.c
	$(CC) sensidir.c NOLINK NODEBUG

readrobtrack.o : readrobtrack.asm 
	$(ASM) readrobtrack.asm I=sc:include

psydecode.o : psydecode.asm 
	$(ASM) OPT ! psydecode.asm

coredecode.o : coredecode.asm 
	$(ASM) OPT ! coredecode.asm

gremdecode.o : gremdecode.asm 
	$(ASM) OPT ! gremdecode.asm

robdecode.o : robdecode.asm 
	$(ASM) OPT ! robdecode.asm

psywfiles.o : psywfiles.asm 
	$(ASM) OPT ! psywfiles.asm I=sc:include

corewfiles.o : corewfiles.asm 
	$(ASM) OPT ! corewfiles.asm I=sc:include

readsensitrack.o : readsensitrack.asm 
	$(ASM) readsensitrack.asm I=sc:include

clean:;		rm *.o
