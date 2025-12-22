#
# Ping-0.1 makefile
# Author: Josh Wheeler
# #
# Let the compiler know what kind of filename extension we're going
# to be using.
#

.SUFFIXES:
.SUFFIXES: .cpp $(SUFFIXES)

#
# Set the variables so the compiler will know where SDL
# can be found.
#

CC       = g++ -noixemul
SDL_CFLAGS := $(shell sdl-config --cflags)
SDL_LDFLAGS := $(shell sdl-config --libs)

#
# Tell the compiler to include from the location specified above.
#

CPPFLAGS=$(SDL_CFLAGS)

#
# Tell the compiler from where to get the library files.
#

LDFLAGS=$(SDL_LDFLAGS)

#
# Tell the compiler what files need to be precompiled in order to
# link the final product together. 
#

OBJS=ping.o init.o paddle.o ball.o

#
# Set up the target for the makefile to create.
#

pong: 	$(OBJS)
	$(CC) -o oldePong $(OBJS) $(LDFLAGS)

#
# This explains to make how to handle files with the cpp extension.
#

.cpp.o:
	$(CC) $(CPPFLAGS) -c $< 

#
# Another target to clean the directory of all the compiled
# files created by the compiler/
#

clean:
	rm -f *.o *~ oldePong
