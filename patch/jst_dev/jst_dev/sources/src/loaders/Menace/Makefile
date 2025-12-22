all : MenaceHD readmndisk

MenaceHD : MenaceHD.asm
	phxass MenaceHD.asm I=include:

readmndisk: readmndisk.o decode.o
	slink FROM LIB:c.o "readmndisk.o"+"/jst/readdostrack.o"+"decode.o" TO "readmndisk" LIB lib:sc.lib lib:amiga.lib

decode.o : decode.asm
	phxass decode.asm NOEXE I=include:


readmndisk.o : readmndisk.c
	sc readmndisk.c NOLINK NODEBUG
