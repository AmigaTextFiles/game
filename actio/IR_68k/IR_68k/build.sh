### "sh" build script by Lorence Lombardo.  ;) 
gcc -m68020 -noixemul inputrevolution.c -o inputrevolution -lpdcurses_ns `sdl-config2 --libs` -lm
strip inputrevolution
