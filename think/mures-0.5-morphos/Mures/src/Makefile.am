bin_PROGRAMS = mures

mures_LDADD = \
	-llua -L./lua
	$(STATIC_LIBS)

SUBDIRS = lua gui images maps sounds textures

EXTRA_DIST = input.lua load_maps.lua 

mures_SOURCES = \
SDL_rotozoom.c \
SDL_rotozoom.h \
ai.c \
ai.h \
anim.c \
anim.h \
audio.c \
audio.h \
audio_sdl.c \
audio_sdl.h \
client.c \
client.h \
defines.h \
game.c \
game.h \
game_input.c \
game_input.h \
game_output.c \
game_output.h \
gi_sdl.c \
gi_sdl.h \
go_gl.c \
go_gl.h \
go_sdl.c \
go_sdl.h \
gui.c \
gui.h \
input_queue.c \
input_queue.h \
lib.c \
lib.h \
lua.c \
lua.h \
lua_keys.h \
main.c \
main.h \
map.c \
map.h \
menu.c \
menu.h \
net_common.c \
net_common.h \
output.c \
output.h \
pregame.c \
pregame.h \
protocol.h \
root.h \
server.c \
server.h \
sim.c \
sim.h \
types.h
