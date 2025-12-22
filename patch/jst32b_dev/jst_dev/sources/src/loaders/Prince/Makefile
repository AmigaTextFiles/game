all : rippopdisk PrinceHD

PrinceHD : PrinceHD.asm
	phxass PrinceHD.asm I=include:

rippopdisk: rippopdisk.o princeread.o
	slink FROM LIB:c.o "rippopdisk.o"+"princeread.o"+"/disklib_hard/trackmoves.o" TO "rippopdisk" LIB LIB:sc.lib LIB:amiga.lib

rippopdisk.o : rippopdisk.c
	sc rippopdisk.c NOLINK NODEBUG

princeread.o: princeread.asm
	phxass princeread.asm I=sc:include NOEXE
