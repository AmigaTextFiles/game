#
# SAS/C 6.51
#
#
CC	= sc
#
#CFLAGS	= 
#
LIBS	= LIB:sc.lib LIB:amiga.lib
#
SRC	= main.c game_time.c weather.c
#
OBJ	= main.o game_time.o weather.o
#

/RoleAid: $(OBJ)
	$(CC) LINK $(OBJ) TO /RoleAid LIB $(LIBS)

main.o: main.c menus.h
game_time.o: game_time.c game_time.h
weather.o: weather.c weather.h
