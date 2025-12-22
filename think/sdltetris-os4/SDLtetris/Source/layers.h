#ifndef LAYERS_H
#define LAYERS_H

#include <vector>
#include <string>
#include <SDL.h>

using namespace std;

class layer
{
	public:
	SDL_Surface *surf;
	SDL_Rect rect;
	int x, y;
	bool useClipRect;
	bool changed;
	string name;
	layer (string newName, SDL_Surface *newSurf, int newX, int newY);
	layer (string newName, SDL_Surface *newSurf, int newX, int newY, SDL_Rect newRect);
};

class layerset
{
	public:
	layerset (void);
	bool first;
	vector<layer> layers;
	void add (layer newLayer);
	layer *findByName (string name);
	void blit (SDL_Surface *surf);
};

#endif
