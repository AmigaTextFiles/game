BIN=../bin/
CFLAGS=-ansi -W -Wundef -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wcast-qual -Wwrite-strings
EXECUTABLE=mapinfo
SOURCES=mapinfo.c buffer.c index.c list.c parse.c output.c

all:
	gcc $(SOURCES) -o mapinfo

debug:
	gcc $(CFLAGS) $(SOURCES) -o mapinfo

Debug: debug

Release:
	gcc $(SOURCES) -o mapinfo
	
Release: release