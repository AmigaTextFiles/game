all : xout2file XoutHD

XoutHD : XoutHD.asm
	phxass XoutHD.asm I=include:


xout2file: xout2file.o decode.o
	slink FROM LIB:c.o "xout2file.o"+"/lib/readdostrack.o"+"decode.o" TO "xout2file" LIB lib:sc.lib lib:amiga.lib


decode.o : decode.asm
	phxass decode.asm NOEXE I=include:


xout2file.o: xout2file.c
	sc xout2file.c NOLINK NODEBUG

