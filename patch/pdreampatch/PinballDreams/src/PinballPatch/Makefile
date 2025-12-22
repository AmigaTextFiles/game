all : PinballHD

PinballHD : pinballhd.o
	phxlnk FROM /lib/utils.o pinballhd.o LIB:amiga.lib TO PinballHD KICK1

pinballhd.o : pinballhd.asm
	phxass pinballhd.asm I=sc:include NOEXE

