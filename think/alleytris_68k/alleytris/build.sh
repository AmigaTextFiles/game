### "sh" build script by Lorence Lombardo.  ;) 
gcc -m68020 -m68881 -noixemul alleytris.c -o alleytris.fpu -lpdcurses_ns `sdl-config2 --libs` -lm
strip alleytris.fpu
