### "sh" build script by Lorence Lombardo.  ;) 
gcc -m68020 -noixemul gocart.c -o gocart -lpdcurses_ns `sdl-config2 --libs` -lm
strip gocart
