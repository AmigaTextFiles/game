### "sh" build script by Lorence Lombardo.  ;) 
gcc -m68020 -noixemul spacefighter.c -o spacefighter -lpdcurses_ns `sdl-config2 --libs` -lm
strip spacefighter
