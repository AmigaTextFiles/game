OBJS =  dllstartup.o dll.o dllimport.o

ARCHIVE = libdll.a

OTHER = 

CC = gcc

AR = ar

RANLIB = ranlib

CODEGEN = -Wall -fomit-frame-pointer
# -s

OPTIMIZE = -O2

CFLAGS= $(CODEGEN) $(OPTIMIZE)

%.o : %.c
	$(CC) $(CFLAGS) -S $< -o $*.s
	$(CC) $(CFLAGS) -c $*.s -o $*.o

ASMS = $(OBJS:.o=.s)

$(ARCHIVE) : $(OBJS)
	$(AR) r $@ $?
	$(RANLIB) $@

depend : 
	makedepend -f Makefile -i / $(OBJS)

clean :
	rm $(ARCHIVE) $(OBJS) $(ASMS) $(OTHER)

#DEPENDENCIES

dllstartup.o: dllstartup.c dll.h

dll.o: dll.c dll.h

dllimport.o: dllimport.c dll.h

