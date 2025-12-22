LIB = libnetwork.a

SRC = \
  network.cpp network_data_formats.cpp network_dialogs.cpp \
  network_dialogs_sdl.cpp network_dialog_widgets_sdl.cpp network_games.cpp \
  network_lookup_sdl.cpp $(NETWORK_MIC) \
  network_microphone_shared.cpp network_speex.cpp network_speaker_sdl.cpp \
  network_speaker_shared.cpp network_star_hub.cpp network_star_spoke.cpp \
  network_udp.cpp RingGameProtocol.cpp \
  SDL_netx.cpp SSLP_limited.cpp StarGameProtocol.cpp network_microphone_sdl_dummy.cpp

top_srcdir = ../..

INCLUDES = -I$(top_srcdir)/Source_Files/CSeries -I$(top_srcdir)/Source_Files/Files \
  -I$(top_srcdir)/Source_Files/GameWorld -I$(top_srcdir)/Source_Files/Input \
  -I$(top_srcdir)/Source_Files/Misc -I$(top_srcdir)/Source_Files/ModelView \
  -I$(top_srcdir)/Source_Files/Pfhortran -I$(top_srcdir)/Source_Files/RenderMain \
  -I$(top_srcdir)/Source_Files/RenderOther -I$(top_srcdir)/Source_Files/Sound \
  -I$(top_srcdir)/Source_Files/TCPMess -I$(top_srcdir)/Source_Files/XML \
  -I$(top_srcdir)/Source_Files/Lua -I$(top_srcdir)/Source_Files \
  -Isdk:local/newlib/include/SDL -I.

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
