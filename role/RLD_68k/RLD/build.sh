### "sh" build script by Lorence Lombardo.  ;) 
g++ -m68020 roguelikedefense.cpp -o roguelikedefense -lpdcurses_ns `sdl-config2 --libs` -lm
strip roguelikedefense
