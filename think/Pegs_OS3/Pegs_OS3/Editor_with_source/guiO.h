// guiO.h - headerfil med klassdefinition
// 04 003 27, av: Fredrik Stridh

#ifndef _guiO_h_
#define _guiO_h_
#include "SDL.h"

class guiO
{
private:

public:

	int xpos;
	int ypos;
	SDL_Surface *image;

	guiO();
	void guiO::setcoords(int x, int y);
	~guiO(){}

};

#endif


