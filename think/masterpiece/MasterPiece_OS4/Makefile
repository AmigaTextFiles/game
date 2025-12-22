 all: mxsdl

sfont.o: SFont.c
	g++ -g -c -Isdk:local/newlib/include/SDL SFont.c

main.o: main.cpp
	g++ -g -c -Isdk:local/newlib/include/SDL main.cpp

mxsdl: main.o sfont.o
	g++ -g -Isdk:local/newlib/include/SDL main.o SFont.o -o mpsdl.exe -lSDL_image

clean:
	rm -rf *.o mpsdl.exe
