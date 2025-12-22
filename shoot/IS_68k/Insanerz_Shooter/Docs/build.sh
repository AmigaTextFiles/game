### "sh" build script by Lorence Lombardo.  ;) 
g++ -m68020 -m68881 -O2 -Wall -fno-exceptions -fno-rtti main.cpp -o IS.exe -lSDL_ttf -lfreetype -lSDL_mixer_1 -lSDL_image -ljpeg -lpng -lz `sdl-config1a --libs --cflags` -lstdc++
strip IS.exe
