# univerzalni Makefile

# g++ ma jine pravidla pro pojmenovavani funkci
CC = g++
CFLAGS = -newlib -Isdk:local/newlib/include/SDL -g # -pg # -DNDEBUG

# Warning flags for C programs
WARNCFLAGS = -Wall -Wshadow -Wpointer-arith \
	-Wcast-qual -Wcast-align -Wmissing-prototypes \
	-Wold-style-cast -Woverloaded-virtual # -W

# varovani pro linker
WARNLD = -Wbad-function-cast -Wstrict-prototypes -Wmissing-declarations 


# The linker flags
LDFLAGS = #

# Knihovny se musi davat jako posledni parametry,
# protoze se napred musi vedet co v nich hledat
LOADLIBES = -newlib -lSDL_mixer -lvorbisfile -lvorbis -logg -lsmpeg -lSDL -lm -lauto -lpthread

# zapnout pro staticke linkovani
# LDSTATIC = -static -L/lib $(LOADLIBES) -lvorbisfile -lvorbis -logg -lsmpeg

# The program to build
PROGRAMS = cars

# All the .cpp files
SOURCES = $(wildcard *.cpp)
# And the corresponding .o files
OBJECTS = $(SOURCES:.cpp=.o)


# The first target in the makefile is the default target. It's usually called
# "all".
all: $(PROGRAMS)


# We assume we have one program (`ourprogram') to build, from all the object
# files derived from .cpp files in the current directory.
$(PROGRAMS): $(OBJECTS) Makefile
	$(CC) $(WARNCFLAGS) $(WARNLD) $(CFLAGS) $(LDFLAGS) -o $(PROGRAMS) $(OBJECTS) $(LOADLIBES) $(LDSTATIC)

# zavislosti vygenerovane -MMD
-include $(OBJECTS:.o=.d)

# pravodla pro vytvareni *.o souboru
%.o: %.cpp
	$(CC) -MMD $(WARNCFLAGS) $(CFLAGS) -c $<

# "clean" removes files not needed after a build.
clean:
	rm -f $(OBJECTS) *.d tags

