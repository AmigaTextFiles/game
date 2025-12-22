#include <SDL.h>
#include <stdlib.h>
#include "namedv.h"
#include "prefs_file.h"
#include "menu.h"
#include "tetris.h"

#define PREFS_FILE "prefs.txt"

using namespace std;

bool runPrefsMenu (namedv *prefs);

int main (int argc, char *argv[])
{
	if (SDL_Init(SDL_INIT_VIDEO) != 0)
	{
		printf("Unable to initialize SDL: %s\n", SDL_GetError());
		return 0;
	}
	atexit(SDL_Quit);
	
	namedv prefs;
	if (prefs_file::read(PREFS_FILE, &prefs) != 0)
	{
		printf("couldn't load prefs file\n");
		return 1;
	}
	
	SDL_Surface *screen = SDL_SetVideoMode(prefs.geti("window_w"), prefs.geti("window_h"), 0, SDL_DOUBLEBUF | SDL_HWSURFACE);
	if (screen == NULL)
	{
		printf("couldn't make a window: %s\n", SDL_GetError());
		return 0;
	}
	SDL_WM_SetCaption("SDLtetris", "Tetris");
	
	menu mainMenu(prefs["main_menu"].c_str());
	tetris theGame(&prefs);
	bool exit = false;
	string result;
	while (exit != true && (result = mainMenu.runMenu()) != "quit")
	{
		if (result == "play")
		{
			exit = theGame.gameLoop();
			if (!exit) theGame.reset();
		} else if (result == "prefs") {
			exit = runPrefsMenu(&prefs);
		}
	}
	return 0;
}

bool runPrefsMenu (namedv *prefs)
{
	string result;
	while (1)
	{
		menu prefsMenu( (*prefs)["prefs_menu"].c_str(), prefs);
		result = prefsMenu.runMenu();
		if (result == "back")
		{
			return(false);
		} else if (result == "quit") {
			return(true);
		} else {
			SDL_Event event;
			bool done = false;
			while (SDL_WaitEvent(&event) != 0 && done != true)
			{
				if (event.type == SDL_KEYDOWN)
				{
					(*prefs)[result] = SDL_GetKeyName(event.key.keysym.sym);
					done = true;
					if (prefs_file::save(PREFS_FILE, prefs) == false)
					{
						printf("couldn't save preferences to: %s\n", PREFS_FILE);
					}
				} else if (event.type == SDL_QUIT) {
					return(true);
				}
			}
		}
	}
}
