#include "CCar.hpp"

#include "CSystem.hpp"
#include "CDlazdice.hpp"
#include "CNastaveni.hpp"

#include <math.h>

// zvuk checkpointu
Mix_Chunk *CCar::sCheckSound = NULL;

CCar::CCar(const COvladani &ovladani, int x, int y, const char *vzhled) :
mOvladani(ovladani),
mRychlost(0, 0)
{
	if (sCheckSound == NULL) {
		sCheckSound = CSystem::loadWav("zvuk/dobry.wav");
	}
	// nacteni obrazku
	mVzhled = CSystem::loadImage(vzhled);
	mPulW = mVzhled->w / 2;
	mPulH = mVzhled->h / 2;

	// defaltni nstaveni konstant
	mMaxRychlost = 100;
	// polomer auta, pouziji minimum 
	mRadius = mPulW < mPulH ? mPulW : mPulH;
	// udelame hmotnost a zrychleni zavisle na vzhledu
	mHmotnost = mPulW * mPulH / 10;
	mZrychleni = 120 - mHmotnost; 

	// pruhledna barva, vzorek je vzdy v levem hornim rohu
	mColorKey = CSystem::getPixelSafe(mVzhled, 0, 0);

	// pocatecni nastaveni
	reset(x, y);
}

//-----------------------------------------------------------------
/*
   postavi auto znovu na start
 */
	void
CCar::reset(int x, int y)
{
	mRychlost = CVector(0, 0);
	mUhel = PI_PUL;
	mX = x;
	mY = y;
	mKolo = 0;
	mCheckpoint = 1;
}

//-----------------------------------------------------------------
/*
   vypocte na zaklade mZrychleni, deltaTime,
   mMaxRychlost a soucasne velikosti
   velikost prirustku rychlosti
 */
	double
CCar::plyn(double deltaTime, double soucasna)
{
	double zbytek;
	double zt;

	zbytek = mMaxRychlost - soucasna;
	if (zbytek <= 0) {
		return 0;
	}
	zt = mZrychleni * deltaTime;
	if (zt > zbytek) {
		return zbytek;
	}
	else {
		return zt;
	}
}

//-----------------------------------------------------------------
/*
   rizeni auta podle stisknutych klaves
 */
	void
CCar::drive(const Uint8 *keys, double deltaTime)
{
	double soucasna;

	soucasna = mRychlost.veSmeru(mUhel);
	if (keys[mOvladani.mUp]) {
		mRychlost.add(mUhel, plyn(deltaTime, soucasna));
	}
	if (keys[mOvladani.mDown]) {
		mRychlost.add(mUhel + PI, plyn(deltaTime, -soucasna));
	}
	if (keys[mOvladani.mLeft]) {
		mUhel += deltaTime;
	}
	if (keys[mOvladani.mRight]) {
		mUhel -= deltaTime;
	}

	// zataceni
	mRychlost.add(mUhel + PI_PUL, mRychlost.veSmeru(mUhel - PI_PUL) 
			* deltaTime);
}

//-----------------------------------------------------------------
/*
   pohne autem o tolik, kolik ujede za 'deltaTime'
 */
	void
CCar::move(double deltaTime)
{
	double sX,sY;
	sX = mRychlost.getX() * deltaTime;
	sY = mRychlost.getY() * deltaTime;
	mX += sX; 
	// Y ma opacne souradnice
	mY -= sY; 
}

//-----------------------------------------------------------------
/* 
   oscenuje a zareaguje na povrch pod autem
 */
	int
CCar::scan(CMapa *mapa)
{
	CDlazdice *podklad;
	int checkpoint;
	double zrychleni;

	podklad = mapa->scan(static_cast<int>(mX), static_cast<int>(mY));
	// !!! efekt zavisi na timeIntervalu
	zrychleni = podklad->getZrychleni();
	mRychlost.krat(zrychleni);

	checkpoint = podklad->getCheckPoint();
	if (checkpoint == mCheckpoint) {
		// prehrani zvuku
		Mix_PlayChannel(-1, sCheckSound, 0);

		if (checkpoint == 1) {
			mKolo++;
		}
		mCheckpoint++; 
		if (mCheckpoint == CNastaveni::pocetCheckPointu + 1) {
			mCheckpoint = 1;
		}
		//test
		fprintf(stderr, "checkpoint: %d, kolo: %d\n", mCheckpoint, mKolo);
	}

	return mKolo;
}


//-----------------------------------------------------------------
/*
   vykresleni auta
   otaceni obrazkem podle uhlu
 */
	void
CCar::draw(SDL_Surface *screen)
{

	// zamknuti surfaces
	if (SDL_MUSTLOCK(mVzhled)) {
		if (SDL_LockSurface(mVzhled) < 0) {
			CSystem::problemSDL();
		}
	}
	if (SDL_MUSTLOCK(screen)) {
		if (SDL_LockSurface(screen) < 0) {
			CSystem::problemSDL();
		}
	}
	rotate(screen);
	// odemknuti surfaces
	if (SDL_MUSTLOCK(mVzhled)) {
		SDL_UnlockSurface(mVzhled);
	}
	if (SDL_MUSTLOCK(screen)) {
		SDL_UnlockSurface(screen);
	}
}

//-----------------------------------------------------------------
/*
   otoceni surface kolem stredu o uhel a 
   vykresleni na screen se stredem v [x, y]

   screen a mVzhled musi byt uzamceny
 */
	void
CCar::rotate(SDL_Surface *screen) 
{
	// projdeme a otocime vsechny pixely v mVzhled
	/*
	   alfa = atan2(y, x) + uhel
	   newY = V * sin(alfa)
	   newY = V * sin(alfa)
	 */
	for (int i = 0; i < mVzhled->w; i++) {
		for (int j = 0; j < mVzhled->h; j++) {			
			Uint32 pixel;
			double alfa;
			double velikost;
			int x, y;
			double newX, newY;
			int newI, newJ;

			pixel = CSystem::getPixel(mVzhled, i, j);

			// test pruhlednosti
			if (pixel != mColorKey) {
				x = i - mPulW;
				y = mPulH - j;
				alfa = atan2(y, x) + mUhel;
				velikost = hypot(x, y);
				newX = velikost * cos(alfa);
				newY = velikost * sin(alfa);
				// zaokrouhleni
				newI = static_cast<int>(mX + newX + 0.5); 
				newJ = static_cast<int>(mY - newY + 0.5);

				CSystem::putPixel(screen, newI, newJ, pixel);
			}
		}
	}
}

//-----------------------------------------------------------------
/*
   resi narazy a aut a nasledne zmeny rychlosti
   nove rychlosti (speed) se vypoctou podle vztahu:

   s1 = v1(m1-m2)/(m1+m2) + v2(2*m2)/(m1+m2)
   s2 = v2(m2-m1)/(m1+m2) + v1(2*m1)/(m1+m2)
 */
	void
CCar::bum(CCar *kolega)
{
	double vzdalenost;

	vzdalenost = hypot(mX - kolega->mX, mY - kolega->mY);

	if (vzdalenost < mRadius + kolega->mRadius) {
		CVector v1 = mRychlost;
		CVector v2 = kolega->mRychlost;
		int m1 = mHmotnost;
		int m2 = kolega->mHmotnost;

		// pomocne castecne vypocty
		double m1m2 = m1 + m2;
		double m2MM = m2 / m1m2;
		double m1MM = m1 / m1m2;
		double rozdil = m1MM - m2MM;

		// pozor, funkce krat() a soucet() meni vektor!
		// proto dojde k pozmeneni pomocnych v1 a v2
		mRychlost.krat(rozdil);
		v2.krat(2 * m2MM);
		mRychlost.soucet(v2); 

		kolega->mRychlost.krat(-rozdil);
		v1.krat(2 * m1MM);
		kolega->mRychlost.soucet(v1); 
	}
}
//-----------------------------------------------------------------
/*
   gratulacky vitezi
 */
	void
CCar::vitez(double deltaTime)
{
	mUhel += deltaTime;
}

