#ifndef CMAPA_H
#define CMAPA_H

#include "CDlazdice.hpp"

class CMapa {
	static CDlazdice *mTrava;
	static CDlazdice *mCesta;
	static CDlazdice *mVoda;
	static CDlazdice *mZed;
	static CDlazdice *mCil1;
	static CDlazdice *mCil2;
	static CDlazdice *mCil3;
	static CDlazdice *mCil4;
	static CDlazdice *mCil5;
	static CDlazdice *mCil6;

	SDL_Surface *mPlan;
	SDL_Surface *mVzhled;
	
	public:
	CMapa(const char *path, const SDL_Surface *screen);
	~CMapa();
	void draw(SDL_Surface *screen);
	CDlazdice *scan(int x, int y);
	private:
	CDlazdice *vyber(Uint32 colorKey);
	SDL_Surface *createSurface(const SDL_Surface *predloha);
};

#endif


