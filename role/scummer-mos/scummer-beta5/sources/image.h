#ifndef image_h
#define image_h

#include "SDL.h"
#include "graphics.h"

class image
{
	Uint16 width;
	Uint16 height;
	SDL_Color pal[256];
	SDL_RWops *f;
	Uint32 *offsets;
	Uint32 palette[256];
	Uint8 xscroll;
	Uint8 transp;
		
	/* Strip decompression routines */
	void decode_uncompressed(SDL_Surface *strip, Uint16 height);
	void decode_horiz(SDL_Surface *strip, Uint16 height, Uint8 compr);
	void decode_vert(SDL_Surface *strip, Uint16 height, Uint8 compr);
	void decode_horiz_transp(SDL_Surface *strip, Uint16 height, Uint8 compr);
	void decode_vert_transp(SDL_Surface *strip, Uint16 height, Uint8 compr);
	void decode2(SDL_Surface *strip, Uint16 height, Uint8 compr);
	void decode2transp(SDL_Surface *strip, Uint16 height, Uint8 compr);
	
public:
	image(SDL_RWops *f, Uint32 offset);
	~image();
	SDL_Surface *GetStrip(Uint8 pos);
	Uint8 Scroll(Uint8 direction);
	Uint16 GetHeight() { return height ; };
	Uint16 GetWidth() { return width ; };
};

#define SCROLL_RIGHT 0
#define SCROLL_LEFT 1

#endif
