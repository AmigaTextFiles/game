#ifndef CDLAZDICE_H
#define CDLAZDICE_H

#include "SDL.h"

class CDlazdice {
	SDL_Surface *mVzhled;
	Uint8 mR, mG, mB;
	int mCheckpoint;
	double mZrychleni;

	public:
	CDlazdice(const char *path, const char *pix_path, int checkpoint,
			double zrychleni);
	~CDlazdice() {SDL_FreeSurface(mVzhled);};
	// neni to dokonale zapouzdreni
	SDL_Surface *getSurface() {return mVzhled;}
	bool isColorKey(Uint32 pixel, SDL_PixelFormat *format);
	int getCheckPoint() {return mCheckpoint;}
	double getZrychleni() {return mZrychleni;}
};

#endif
