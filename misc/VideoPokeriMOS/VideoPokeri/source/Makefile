STRIP		= strip
CC			= gcc -noixemul
CDEFS 	= -DUSE_INLINE_STDARG
CFLAGS	= $(CDEFS) -O3 -ffast-math -finline-functions -funroll-loops -fstrict-aliasing -mcpu=750 -mmultiple -mstring -Wall -Wno-missing-braces
TARGET	= VideoPokeri

OBJS  = GraphicsDATA.o SoundInit.o VideoPokeri_102.o

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

GraphicsDATA.o		: GraphicsDATA.c
SoundInit.o			: SoundInit.c
VideoPokeri_102.o	: VideoPokeri_102.c Poker.h/Screen.h Poker.h/Window.h Poker.h/Graphics.h Poker.h/Gadgets.h Poker.h/Sheets.h

$(TARGET): $(OBJS)
	$(LINKING)
	@$(CC) $(OBJS) -o $@.db
	$(STRIPPING)
	@$(STRIP) --remove-section=.comment $@.db -o $@

clean: 
	@rm -f *.o $(TARGET)
