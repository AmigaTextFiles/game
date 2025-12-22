#ifndef MENU_H
#define MENU_H

#include <SDL.h>
#include <SDL_ttf.h>
#include <vector>
#include <map>
#include <string>

#include "namedv.h"
#include "layers.h"

using namespace std;

class menu
{
	namedv menuInfo;
	layerset ls;
	vector<SDL_Rect> button_rects;
	map<string, SDL_Surface*> surfs;
	map<string, TTF_Font*> fonts;
	SDL_Surface *screen, *background;
	public:
	menu (const char *filename, namedv *data = NULL);
	~menu (void);
	string runMenu (void);
	string strInt (int n);
	bool hitTest (int x, int y, SDL_Rect *rect);
	bool handleMouseMove (int x, int y);
	SDL_Color makeColor (string str);
	void init_ttf (void);
	string addVars (string str, namedv *data);
};

#endif
