#include "CSystem.hpp"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

// staticky prvek, spusti se konstructor CSRand()
CSRand CSystem::initRandom = CSRand();

//----------------------------------------------------------
CSRand::CSRand() {
	// incializace generatoru nahodnych cisel
	CSystem::echo("Inicializuji generator nahodnych cisel ...");
	srand( static_cast<unsigned>(time(NULL)) );
}

//----------------------------------------------------------
/*
 * ohlaseni SDL_chyby a konec
 */
	void
CSystem::problemSDL() 
{
	fprintf(stderr, "Problem: %s\n", SDL_GetError());
	exit(1);
}

//-----------------------------------------------------------------
/*
   vypsani retezce
 */
	void
CSystem::echo(const char *text) 
{
	fprintf(stderr, "%s\n", text);
}

//-----------------------------------------------------------------
/*
   vypsani reteze a konec
 */
	void 
CSystem::chyba(const char *text)
{
	echo(text);
	exit(1);
}

//-----------------------------------------------------------------
/*
 * nahraje obrazek z BMP souboru (nic vic)
 */
	SDL_Surface *
CSystem::loadImageLight(const char *path)
{
	SDL_Surface *image_bmp;

	printf("Budu nahravat obrazek %s\n", path);

	image_bmp = SDL_LoadBMP(path);
	if (image_bmp == NULL) {
		// vynadani a konec
		CSystem::problemSDL();
	}

	return image_bmp;
}
//-----------------------------------------------------------------
/*
 * nahraje obrazek z BMP souboru
 * a prevede ho do zobrazitelneho stavu
 */
	SDL_Surface *
CSystem::loadImage(const char *path)
{
	SDL_Surface *image_bmp;
	SDL_Surface *surface;

	image_bmp = loadImageLight(path);

	surface = SDL_DisplayFormat(image_bmp);
	SDL_FreeSurface(image_bmp);
	return surface;
}

//-----------------------------------------------------------------
/*
 * Nahraje ikonu z BMP souboru
 * a nastavi u nej colorKey 
 * (nesmi se provest SDL_DisplayFormat, protoze pri nastaveni icony
 * jeste neni inicializovana grafika) 
 */
	void
CSystem::setIcon(const char *path)
{
	SDL_Surface *image_bmp;
	Uint32 colorKey;

	image_bmp = loadImageLight(path);

	// nastaveni transparetni barvy (podle pixelu v [0,0])
	colorKey = getPixelSafe(image_bmp, 0, 0);
	SDL_SetColorKey(image_bmp, SDL_SRCCOLORKEY, colorKey);
	SDL_WM_SetIcon(image_bmp, NULL);

	SDL_FreeSurface(image_bmp);
}
//-----------------------------------------------------------------
/* 
 * nacteni zvuku
 */
	Mix_Chunk *
CSystem::loadWav(const char *path) 
{
	Mix_Chunk *wav;

	printf("Budu nahravat wav %s\n", path);
	wav = Mix_LoadWAV(path);
	if (wav == NULL) {
		CSystem::problemSDL();
	}
	return wav;
}

//-----------------------------------------------------------------
/*
 * vraci nahodne cislo mezi z <0,mez)
 * (bere ho z vyssich bitu)
 */
	int
CSystem::random(int mez) 
{
	return rand() % mez;
}

//-----------------------------------------------------------------
/*
   vrati pixel na [x, y]
   surface musi byt predtim locked
 */
	Uint32
CSystem::getPixel(SDL_Surface *surface, int x, int y)
{
	int bpp = surface->format->BytesPerPixel;
	// v 'p' bude adresa pozadovaneho pixelu 
	Uint8 *p = static_cast<Uint8 *>(surface->pixels) + y * surface->pitch + x * bpp;

	switch(bpp) {
		case 1: // 8bit hloubka
			return *p;

		case 2: // 16bit 
			return *reinterpret_cast<Uint16 *>(p);

		case 3: // 24bit 
			if(SDL_BYTEORDER == SDL_BIG_ENDIAN) {
				return p[0] << 16 | p[1] << 8 | p[2];
			}
			else {
				return p[0] | p[1] << 8 | p[2] << 16;
			}

		case 4: // 32 bit
			return *reinterpret_cast<Uint32 *>(p);

		default:
			echo("Neznama barevna hloubka!");
			exit(1);	
	}
}

//-----------------------------------------------------------------
/*
   vlozi pixel do surface na [x,y]
   surface musi byt locked
 */
	void 
CSystem::putPixel(SDL_Surface *surface, int x, int y, Uint32 pixel)
{
	if ((x >= 0 && y >= 0) && 
			(x < surface->w && y < surface->h)) {
		int bpp = surface->format->BytesPerPixel;
		/* v 'p' bude adresa kam zapiseme */
		Uint8 *p = static_cast<Uint8 *>(surface->pixels) + y * surface->pitch + x * bpp;

		switch(bpp) {
			case 1:
				*p = pixel;
				break;

			case 2:
				*reinterpret_cast<Uint16 *>(p) = pixel;
				break;

			case 3:
				if(SDL_BYTEORDER == SDL_BIG_ENDIAN) {
					p[0] = (pixel >> 16) & 0xff;
					p[1] = (pixel >> 8) & 0xff;
					p[2] = pixel & 0xff;
				} else {
					p[0] = pixel & 0xff;
					p[1] = (pixel >> 8) & 0xff;
					p[2] = (pixel >> 16) & 0xff;
				}
				break;

			case 4:
				*reinterpret_cast<Uint32 *>(p) = pixel;
				break;

			default:
				echo("Neznama barevna hloubka.");
				exit(1);	
		}
	}
}


//-----------------------------------------------------------------
/*
   bezpecny getPixel
   i s uzamknutim surface
 */
	Uint32 
CSystem::getPixelSafe(SDL_Surface *surface, int x, int y)
{
	Uint32 pixel;

	if (SDL_MUSTLOCK(surface)) {
		if (SDL_LockSurface(surface) < 0) {
			CSystem::problemSDL();
		}
	}
	pixel = getPixel(surface, x, y);
	if (SDL_MUSTLOCK(surface)) {
		SDL_UnlockSurface(surface);
	}
	return pixel;
}

//-----------------------------------------------------------------
/*
   bezpecny putPixel
   i s uzamknutim surface
 */
	void 
CSystem::putPixelSafe(SDL_Surface *surface, int x, int y, Uint32 pixel)
{
	if (SDL_MUSTLOCK(surface)) {
		if (SDL_LockSurface(surface) < 0) {
			CSystem::problemSDL();
		}
	}
	putPixel(surface, x, y, pixel);
	if (SDL_MUSTLOCK(surface)) {
		SDL_UnlockSurface(surface);
	}
}
