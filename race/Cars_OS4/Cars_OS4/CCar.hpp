#ifndef CCAR_H
#define CCAR_H

#include "CVector.hpp"
#include "CMapa.hpp"

#include "SDL.h"
#include "SDL_mixer.h"

struct COvladani {
	SDLKey mUp, mDown, mLeft, mRight;
};

class CCar {
	static Mix_Chunk *sCheckSound;
	static const double PI = 3.14159265358979323846;
	static const double PI_PUL = 3.14159265358979323846 / 2;
	// konstanty
	COvladani mOvladani;
	SDL_Surface *mVzhled;
	int mPulW;
	int mPulH;
	Uint32 mColorKey;
	double mMaxRychlost;
	double mZrychleni;
	int mHmotnost;
	int mRadius;
	// promenne parametry
	CVector mRychlost;
	double mX;
	double mY;
	// uhel je v radianech
	double mUhel;
	int mCheckpoint;
	int mKolo;

	public:
	CCar(const COvladani &ovladani, int x, int y, const char *vzhled);
	void reset(int x, int y);
	void drive(const Uint8 *keys, double deltaTime);
	void move(double deltaTime);
	int scan(CMapa *mapa);
	void draw(SDL_Surface *screen);
	void bum(CCar *kolega);
	void vitez(double deltaTime);
	private:
	double plyn(double deltaTime, double soucasna);
	void rotate(SDL_Surface *screen);

};

#endif


