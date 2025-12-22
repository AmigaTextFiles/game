CFLAGS = -O3
CXXFLAGS = $(CFLAGS) 

OBJS = attacks.o book.o check.o exmove.o hash.o main.o movelist.o parse.o pcapts.o \
	pmoves.o score.o search.o sort.o

EXChess: $(OBJS)
	g++ -o EXChess $(OBJS) -lm

attacks.o: attacks.cpp chess.h define.h funct.h const.h

book.o: book.cpp chess.h define.h funct.h const.h

check.o: check.cpp chess.h define.h funct.h const.h

exmove.o: exmove.cpp chess.h define.h const.h funct.h hash.h

hash.o: hash.cpp chess.h define.h funct.h const.h hash.h

main.o: main.cpp define.h chess.h const.h funct.h main.h hash.h

movelist.o: movelist.cpp chess.h define.h const.h funct.h

parse.o: parse.cpp chess.h define.h funct.h const.h

pcapts.o: pcapts.cpp chess.h define.h const.h funct.h

pmoves.o: pmoves.cpp chess.h define.h const.h funct.h

score.o: score.cpp chess.h define.h funct.h score.h hash.h

search.o: search.cpp chess.h define.h const.h funct.h search.h hash.h

sort.o: sort.cpp chess.h define.h const.h funct.h


%.o: %.cpp
	g++ -c $(CXXFLAGS) -o $@ $<






