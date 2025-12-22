#include "main.h"
#include <string.h>

#ifndef __texture_h_
#define __texture_h_

class class_texture
{
	protected:

	GLuint texture[1];
	SDL_Surface *textureImage[1];
	SDL_Surface *fileBMP (char *);

	public:

	class_texture ();
	~class_texture ();
	int loadBMP (char *);
	int use ();
	int del ();
};

#endif
