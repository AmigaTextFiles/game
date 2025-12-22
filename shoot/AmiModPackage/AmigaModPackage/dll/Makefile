EXEOBJS = test1.o test2.o
DLLOBJS = dll1.o dll2.o server.o

OBJS = $(EXEOBJS) $(DLLOBJS)

EXE = $(EXEOBJS:.o=.exe)

DLL = $(DLLOBJS:.o=.dll)

OTHER = 

CC = g++ -V 2.95

CODEGEN = -m68060 -Wall -fno-exceptions -fno-rtti -fomit-frame-pointer -noixemul -s -I./dll -I/ade/m68k-amigaos/include

OPTIMIZE = -O3

CFLAGS= $(CODEGEN) $(OPTIMIZE)

LIBPATH = dll

LIBS = -ldll

%.o : %.c
	$(CC) $(CFLAGS) -S $< -o $*.s
	$(CC) $(CFLAGS) -c $*.s -o $*.o

%.o : %.cpp
	$(CC) $(CFLAGS) -S $< -o $*.s
	$(CC) $(CFLAGS) -c $*.s -o $*.o

ASMS = $(OBJS:.o=.s)

all : $(EXE) $(DLL)

$(EXE) : %.exe : %.o dll/libdll.a
	$(CC) $(CFLAGS) $< -L $(LIBPATH) $(LIBS) -o $@

$(DLL) : %.dll : %.o dll/libdll.a
	$(CC) $(CFLAGS) $< -L $(LIBPATH) $(LIBS) -o $@

depend : 
	makedepend -f Makefile -i / -i dll $(OBJS)

clean :
	rm $(EXE) $(DLL) $(OBJS) $(ASMS) $(OTHER)

#DEPENDENCIES

test1.o: test1.c dll/dll.h

dll1.o: dll1.c dll/dll.h

dll2.o: dll2.c dll/dll.h

