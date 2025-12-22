#
# Makefile for Sudominator
#

CC     = gcc
STRIP  = strip
BUILD  = $(shell svnversion)
CFLAGS = -W -Wall -nostartfiles -noixemul -O2 -Wpointer-arith -Wno-parentheses
CFLAGS += -D__NOLIBBASE__ -DUSE_INLINE_STDARG -Ilibvstring
CFLAGS += -D__SVNVERSION__=\"$(BUILD)\"
LDFLAGS = -nostartfiles -nostdlib -noixemul -Llibvstring

#########################################################################

OBJS = start.o main.o application.o sudokuarea.o prefswin.o
EXE = Sudominator
LIBS = -lc -lvstring

#########################################################################

.DEFAULT:
	@echo "Nothing to do."

.PHONY: all clean deps libvstring

all: startmsg libvstring program debug
	@echo "Build finished."
	@list $(EXE) lformat "%n %l %t"

startmsg:
	@echo "Starting build $(BUILD)."

deps:
	$(CC) -MM *.c

clean:
	make -C libvstring clean
	rm -f *.o *.db $(EXE)

program: $(OBJS)
	@echo "Linking release executable..."
	@$(CC) $(LDFLAGS) -s $(OBJS) $(LIBS) -o $(EXE).tmp
	@$(STRIP) --strip-unneeded --remove-section .comment $(EXE).tmp -o $(EXE)
	@delete $(EXE).tmp QUIET
	@protect $(EXE) +E

debug: $(OBJS)
	@echo "Linking debug executable..."
	@$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -o $(EXE).db
	@protect $(EXE).db +E

%.o:
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o $@ $<

libvstring:
	make -C libvstring

application.o: application.c application.h main.h sudokuarea.h prefswin.h
main.o: main.c main.h application.h sudokuarea.h prefswin.h
prefswin.o: prefswin.c prefswin.h
start.o: start.c main.h
sudokuarea.o: sudokuarea.c sudokuarea.h main.h
