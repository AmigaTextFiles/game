# $@ = Stockfish5_MorphOS

CC = g++
CP = copy clone
RM = delete force
CFLAGS = -noixemul -O3 -Wall -fsigned-char -N
# Stockfish specific
CFLAGS += -Wcast-qual -fno-exceptions -fno-rtti
CFLAGS += -ansi -pedantic -Wno-long-long -Wextra -Wshadow
LIBS = -lpthread -lstdc++

TARGET = Stockfish5_MorphOS
OBJS = benchmark.o bitbase.o bitboard.o book.o endgame.o evaluate.o main.o \
	material.o misc.o movegen.o movepick.o notation.o pawns.o position.o \
	search.o thread.o timeman.o tt.o uci.o ucioption.o

$(TARGET): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LIBS)
	strip -R.comment $@
	protect $@ re

benchmark.o: benchmark.cpp
	$(CC) -c benchmark.cpp -o benchmark.o $(CFLAGS)

bitbase.o: bitbase.cpp
	$(CC) -c bitbase.cpp -o bitbase.o $(CFLAGS)

bitboard.o: bitboard.h bitboard.cpp
	$(CC) -c bitboard.cpp -o bitboard.o $(CFLAGS)

book.o: book.h book.cpp
	$(CC) -c book.cpp -o book.o $(CFLAGS)

endgame.o: endgame.h endgame.cpp
	$(CC) -c endgame.cpp -o endgame.o $(CFLAGS)

evaluate.o: evaluate.h evaluate.cpp
	$(CC) -c evaluate.cpp -o evaluate.o $(CFLAGS)

main.o: main.cpp
	$(CC) -c main.cpp -o main.o $(CFLAGS)

material.o: material.h material.cpp
	$(CC) -c material.cpp -o material.o $(CFLAGS)

misc.o: misc.h misc.cpp
	$(CC) -c misc.cpp -o misc.o $(CFLAGS)

movegen.o: movegen.h movegen.cpp
	$(CC) -c movegen.cpp -o movegen.o $(CFLAGS)

movepick.o: movepick.h movepick.cpp
	$(CC) -c movepick.cpp -o movepick.o $(CFLAGS)

notation.o: notation.h notation.cpp
	$(CC) -c notation.cpp -o notation.o $(CFLAGS)

pawns.o: pawns.h pawns.cpp
	$(CC) -c pawns.cpp -o pawns.o $(CFLAGS)

position.o: position.h position.cpp
	$(CC) -c position.cpp -o position.o $(CFLAGS)

search.o: search.h search.cpp
	$(CC) -c search.cpp -o search.o $(CFLAGS)

thread.o: thread.h thread.cpp
	$(CC) -c thread.cpp -o thread.o $(CFLAGS)

timeman.o: timeman.h timeman.cpp
	$(CC) -c timeman.cpp -o timeman.o $(CFLAGS)

tt.o: tt.h tt.cpp
	$(CC) -c tt.cpp -o tt.o $(CFLAGS)

uci.o: uci.cpp
	$(CC) -c uci.cpp -o uci.o $(CFLAGS)

ucioption.o: ucioption.h ucioption.cpp
	$(CC) -c ucioption.cpp -o ucioption.o $(CFLAGS)



install: $(TARGET)
	$(CP) $(TARGET) /MorphOS/

clean:
	$(RM) $(OBJS) $(TARGET)
