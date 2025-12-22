CC	= vc +warposdb_wos
CFLAGS	= -DAMIGAVERSION -DAMIGAAUDIO -amiga-align -I:CC/netinclude
LIBS	= -lauto -lppcmath -lm -lgl -lsocket -lamiga

TARGET 	= battalion

OBJ 	= battalion.o audio.o net.o gprim.o graphics.o objects.o \
          text.o update.o tk_amiga.o font.o amigasnd.o


all:	$(TARGET)

$(TARGET): $(OBJ)
	$(CC) -o $(TARGET) $(OBJ) $(LIBS)

battalion.o: battalion.c battalion.h
	$(CC) $(CFLAGS) -c $<

audio.o: audio.c battalion.h amigasnd.h
	$(CC) $(CFLAGS) -c $<

net.o: net.c battalion.h
	$(CC) $(CFLAGS) -c $<

gprim.o: gprim.c battalion.h
	$(CC) $(CFLAGS) -c $<

graphics.o: graphics.c battalion.h
	$(CC) $(CFLAGS) -c $<

objects.o: objects.c battalion.h
	$(CC) $(CFLAGS) -c $<

text.o: text.c battalion.h
	$(CC) $(CFLAGS) -c $<

update.o: update.c battalion.h
	$(CC) $(CFLAGS) -c $<

tk_amiga.o: tk_amiga.c tk_amiga.h
	$(CC) $(CFLAGS) -c $<

font.o: font.c battalion.h
	$(CC) $(CFLAGS) -c $<

amigasnd.o: amigasnd.c amigasnd.h
	$(CC) $(CFLAGS) -c $<
