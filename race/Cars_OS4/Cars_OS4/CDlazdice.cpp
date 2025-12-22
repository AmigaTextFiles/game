#include "CDlazdice.hpp"

#include "CSystem.hpp"
#include "CNastaveni.hpp"

#include <math.h>

/*
   path ... soubor s obrazkem dlazdice
   pix_path ... soubor s 1 pixelem 
   checkpoint ... cislo checkpointu (1-6) nebo 0
   zrychleni ... jak ovlivni projizdejici auto
 */
CDlazdice::CDlazdice(const char *path, const char *pix_path, int checkpoint,
		double zrychleni)
{
	SDL_Surface *pix;
	Uint32 colorKey;

	pix = CSystem::loadImageLight(pix_path);
	colorKey = CSystem::getPixelSafe(pix, 0, 0);
	SDL_GetRGB(colorKey, pix->format, &mR, &mG, &mB);
	SDL_FreeSurface(pix);

	mVzhled = CSystem::loadImage(path);
	if (mVzhled->w != CNastaveni::dlazdiceW || mVzhled->h != CNastaveni::dlazdiceH) {
		CSystem::chyba("Neodpovidajici rozmery!");
	}
	mCheckpoint = checkpoint;

	mZrychleni = zrychleni;
}


//-----------------------------------------------------------------
/*
   zjisti zda dany barevny pixel
   odpovida teto dlazdici
 */
	bool
CDlazdice::isColorKey(Uint32 pixel, SDL_PixelFormat *format)
{
	Uint8 r, g, b;

	SDL_GetRGB(pixel, format, &r, &g, &b); 
	if (mR == r && mG == g && mB == b) {
		return true;
	}
	else {
		return false;
	}
}



