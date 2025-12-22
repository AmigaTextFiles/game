#
# Snakee makefile...
#

CC    =	gcc
APP   =	Snakee
OBJ   =	$(APP).c
FLAGS =	-noixemul -Wall


$(APP):	$(OBJ)
	$(CC) $(OBJ) -o $(APP) $(FLAGS)
	strip $@

clean:
	rm -f $(APP) *.o
