## Process this file with automake to produce Makefile.in 

LIB = libtcpmess.a
SRC = \
  CommunicationsChannel.cpp Message.cpp MessageDispatcher.cpp MessageHandler.cpp\
  MessageInflater.cpp

top_srcdir = ../..

INCLUDES = 	-I$(top_srcdir)/Source_Files/CSeries -I$(top_srcdir)/Source_Files/Files \
			-Isdk:local/newlib/include/SDL

OBJ = $(SRC:.cpp=.o)

DEFINES = -DSDL -DHAVE_LUA -DHAVE_SDL_IMAGE_H -DWORDS_BIGENDIAN -DHAVE_SDL_NET

CFLAGS = -O2 -newlib -g -Wall $(DEFINES) $(INCLUDES) -c

all: $(LIB)

$(LIB): $(OBJ)
	ar -ru $(LIB) $(OBJ)
	ranlib $(LIB)

%.o:%.cpp
	g++ $(CFLAGS) $<

clean:
	delete #?.o
	delete $(LIB)
