MAKE = make
CC = gcc
TARGET = netpong 

CFLAGS = -I/include: -I/include:SDL -g -D_REENTRANT
LIBS = -lthread -lSDL  -lm

OFILES = qdupong.c 
#HEADERS = 

%.o:%.c $(HEADERS)
	$(CC) $(CFLAGS) -c $*.c

$(TARGET): $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OFILES) $(LIBS) 

clean:
	rm -f *.o core $(TARGET)
