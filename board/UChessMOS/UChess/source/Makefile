STRIP		= strip
CC			= gcc -noixemul
CDEFS 	= -DUSE_INLINE_STDARG -DGDX -DSEMIQUIETBOOKGEN -DDEEPNULL -DQUIETBACKGROUND -DNOSCORESPACE -DNONDSP -DCACHE -DKILLT -DHISTORY -DLANGFILE='"PROGDIR:uchess.lang"' -DBOOK='"PROGRID:uchess.book"'
CFLAGS	= $(CDEFS) -O3 -ffast-math -finline-functions -funroll-loops -fstrict-aliasing -mcpu=750 -mmultiple -mstring -Wall -I. -Wno-missing-braces
TARGET	= uchess

OBJS  = ataks.o book.o dspcom.o eval.o genmoves.o init.o main.o nondsp.o search.o util.o

ECHO = echo
ECHE = echo -e
BOLD = \033[1m
NRML = \033[22m

COMPILING = @$(ECHE) "compiling $(BOLD)$@$(NRML)..."
LINKING = @$(ECHE) "linking $(BOLD)$@$(NRML)..."
STRIPPING = @$(ECHE) "stripping $(BOLD)$@$(NRML)..."
ARCHIVING = @$(ECHE) "archiving $(BOLD)$@$(NRML)..."

%.o: %.c
	$(COMPILING)
	@$(CC) $(CFLAGS) -o $@ -c $*.c

all: $(TARGET)

ataks.o		: ataks.c		gnuchess.h
book.o		: book.c			gnuchess.h
dspcom.o		: dspcom.c		gnuchess.h
eval.o		: eval.c			gnuchess.h ataks.h
genmoves.o	: genmoves.c	gnuchess.h
init.o		: init.c			gnuchess.h
main.o		: main.c			gnuchess.h
nondsp.o		: nondsp.c		gnuchess.h
search.o		: search.c		gnuchess.h ttable.c
util.o		: util.c			gnuchess.h

$(TARGET): $(OBJS)
	$(LINKING)
	@$(CC) $(OBJS) -o $@.db
	$(STRIPPING)
	@$(STRIP) --remove-section=.comment $@.db -o $@

clean: 
	@rm -f *.o $(TARGET)
