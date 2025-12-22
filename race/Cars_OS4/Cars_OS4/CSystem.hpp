/*
 * class CSystem
 * pomocne utilitky 
 */
#ifndef CSYSTEM_HPP
#define CSYSTEM_HPP

#include "SDL.h"
#include "SDL_mixer.h"

struct CSRand {
	CSRand();
};

class CSystem {
	// staticky prvek jehoz konstructor nastavi srand
	static CSRand initRandom;

	public:
	static void problemSDL();
	static SDL_Surface *loadImageLight(const char *path);
	static SDL_Surface *loadImage(const char *path);
	static void setIcon(const char *path);
	static Mix_Chunk *loadWav(const char *path);

	static void echo(const char *text);
	static void chyba(const char *text);
	static int random(int mez);
	static Uint32 getPixel(SDL_Surface *surface, int x, int y);
	static void putPixel(SDL_Surface *surface, int x, int y, Uint32 pixel);
	static Uint32 getPixelSafe(SDL_Surface *surface, int x, int y);
	static void putPixelSafe(SDL_Surface *surface, int x, int y, Uint32 pixel);
};

#endif
/* eof */
