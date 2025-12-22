#include "layers.h"
#include <vector>
#include <string>
#include <SDL.h>

using namespace std;

layer::layer (string newName, SDL_Surface *newSurf, int newX, int newY)
{
	name = newName;
	surf = newSurf;
	x = newX;
	y = newY;
	useClipRect = true;
	changed = true;
}

layer::layer (string newName, SDL_Surface *newSurf, int newX, int newY, SDL_Rect newRect)
{
	name = newName;
	surf = newSurf;
	x = newX;
	y = newY;
	useClipRect = false;
	rect = newRect;
	changed = true;
}

void layerset::add (layer newLayer)
{
	layers.push_back(newLayer);
}

void layerset::blit (SDL_Surface *surf)
{
	int timer = SDL_GetTicks();
	vector<SDL_Rect> changedRects;
	SDL_Rect rect;
	if (!first)
	{
		for (unsigned int i = 0; i < layers.size(); i++)
		{
			if (layers[i].changed)
			{
				if (layers[i].useClipRect) SDL_GetClipRect(layers[i].surf, &layers[i].rect);
				rect = layers[i].rect;
				rect.x += layers[i].x;
				rect.y += layers[i].y;
				changedRects.push_back(rect);
				layers[i].changed = false;
			}
		}
	} else {
		SDL_GetClipRect(surf, &rect);
		changedRects.push_back(rect);
		for (unsigned int i = 0; i < layers.size(); i++) layers[i].changed = false;
	}
	//printf("generated %i rects in %i miliseconds\n", changedRects.size(), SDL_GetTicks()-timer);
	if (changedRects.size() == 0) return;
	timer = SDL_GetTicks();
	int blited = 0;
	SDL_Rect dest, oldDestClip;
	SDL_GetClipRect(surf, &oldDestClip);
	for (unsigned int i = 0; i < layers.size(); i++)
	{
		if (layers[i].surf != NULL)
		{
			for (unsigned int r = 0; r < changedRects.size(); r++)
			{
				dest = changedRects[r];
				if (first || dest.x < layers[i].x+layers[i].rect.w && dest.y < layers[i].y+layers[i].rect.h && dest.x+dest.w > layers[i].x && dest.y+dest.h > layers[i].y)
				{
					//printf("%i,%i,%i,%i : %i,%i,%i,%i\n", dest.x, dest.y, dest.w, dest.h, src.x, src.y, src.w, src.h);
					if (layers[i].useClipRect) SDL_GetClipRect(layers[i].surf, &layers[i].rect);
					dest = layers[i].rect;
					dest.x = layers[i].x;
					dest.y = layers[i].y;
					SDL_SetClipRect(surf, &(changedRects[r]));
					SDL_BlitSurface(layers[i].surf, &layers[i].rect, surf, &dest);
					blited++;
				}
			}
		}
	}
	SDL_SetClipRect(surf, &oldDestClip);
	if (first) first = false;
	//printf("blitted %i rects in %i miliseconds\n", blited, SDL_GetTicks()-timer);
}

layerset::layerset (void)
{
	first = true;
}

layer *layerset::findByName (string name)
{
	for (unsigned int i = 0; i < layers.size(); i++)
	{
		if (layers[i].name == name) return &layers[i];
	}
	return(NULL);
}
