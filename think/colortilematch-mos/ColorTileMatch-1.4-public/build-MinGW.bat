windres -i src/WindowsRes.rc -o WindowsRes.o
gcc src/*.c WindowsRes.o -lmingw32 -lSDLmain -lSDL -o bin/ColorTileMatch.exe
pause