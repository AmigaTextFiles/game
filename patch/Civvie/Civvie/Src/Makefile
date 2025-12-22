CFLAGS=-O2 -Wall
CC=gcc

civvie.ixemul: map.o subtask.o watcher.o civmanager.o public_port.o version.o
	${CC} ${CFLAGS} -o $@ $+
	strip $@

version.o: version.c
	${CC} -c -DCIVVIE=\"civvie.ixemul\" version.c
