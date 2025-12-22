#include "CMapa.hpp"

#include "CSystem.hpp"
#include "CNastaveni.hpp"
#include "CDlazdice.hpp"

CDlazdice *CMapa::mTrava = NULL;
CDlazdice *CMapa::mCesta = NULL;
CDlazdice *CMapa::mVoda = NULL;
CDlazdice *CMapa::mZed = NULL;
CDlazdice *CMapa::mCil1 = NULL;
CDlazdice *CMapa::mCil2 = NULL;
CDlazdice *CMapa::mCil3 = NULL;
CDlazdice *CMapa::mCil4 = NULL;
CDlazdice *CMapa::mCil5 = NULL;
CDlazdice *CMapa::mCil6 = NULL;

//-----------------------------------------------------------------
/*
   vytvori z mPlanu a dlazdic mVzhled
 */
CMapa::CMapa(const char *path, const SDL_Surface *screen)
{
	SDL_Surface *tmp;

	if (mTrava == NULL) { 
		mTrava = new CDlazdice("dlazdice/trava.bmp", "dlazdice/pix_trava.bmp", 
				0, 0.75);
		mCesta = new CDlazdice("dlazdice/cesta.bmp", "dlazdice/pix_cesta.bmp", 
				0, 1);
		mVoda = new CDlazdice("dlazdice/voda.bmp", "dlazdice/pix_voda.bmp", 0, 
				0.5);
		mZed = new CDlazdice("dlazdice/zed.bmp", "dlazdice/pix_zed.bmp", 0, 
				-1);
		mCil1 = new CDlazdice("dlazdice/cil1.bmp", "dlazdice/pix_cil1.bmp", 1,
				// je mozno i aby zrychloval, ale vypnul jsem to
				1.0);
		mCil2 = new CDlazdice("dlazdice/cil2.bmp", "dlazdice/pix_cil2.bmp", 2, 
				1.0);
		mCil3 = new CDlazdice("dlazdice/cil3.bmp", "dlazdice/pix_cil3.bmp", 3, 
				1.0);
		mCil4 = new CDlazdice("dlazdice/cil4.bmp", "dlazdice/pix_cil4.bmp", 4, 
				1.0);
		mCil5 = new CDlazdice("dlazdice/cil5.bmp", "dlazdice/pix_cil5.bmp", 5, 
				1.0);
		mCil6 = new CDlazdice("dlazdice/cil6.bmp", "dlazdice/pix_cil6.bmp", 6, 
				1.0);
	}

	mPlan = CSystem::loadImageLight(path);

	mVzhled = createSurface(screen);
	for (int i = 0; i < mPlan->w; i++) {
		for (int j = 0; j < mPlan->h; j++) {
			Uint32 pixel;
			SDL_Surface *nakres;
			SDL_Rect rect;

			// pokud to bude pomale muzu mPlan zamknout spolecne
			pixel = CSystem::getPixelSafe(mPlan, i, j);
			// nakres neuvolnovat!
			nakres = vyber(pixel)->getSurface();
			rect.x = i * CNastaveni::dlazdiceW;
			rect.y = j * CNastaveni::dlazdiceH;
			SDL_BlitSurface(nakres, NULL, mVzhled, &rect);
		}
	}

	// upravit pro rychlejsi bliting
	tmp = mVzhled;
	mVzhled = SDL_DisplayFormat(tmp);
	SDL_FreeSurface(tmp);

}

//-----------------------------------------------------------------
CMapa::~CMapa()
{
	SDL_FreeSurface(mPlan);
	SDL_FreeSurface(mVzhled);
}

//-----------------------------------------------------------------
/*
   hodi mapu na obrazovku
 */
	void
CMapa::draw(SDL_Surface *screen)
{
	SDL_BlitSurface(mVzhled, NULL, screen, NULL);
}

//-----------------------------------------------------------------
/*
   vrati ukazetel na dlazdici na pozici
 */
	CDlazdice *
CMapa::scan(int x, int y)
{
	Uint32 pixel;

	x /= CNastaveni::dlazdiceW;
	y /= CNastaveni::dlazdiceH;
	if (x < 0 || y < 0 || x >= mPlan->w || y >= mPlan->h) {
		return mZed;
	}	   
	else {
		pixel = CSystem::getPixelSafe(mPlan, x, y);
		return vyber(pixel);
	}
}

//-----------------------------------------------------------------
/*
   vybere podle colorKey, odpovidajici Dlazdici
 */
	CDlazdice *
CMapa::vyber(Uint32 colorKey)
{
	SDL_PixelFormat *format;

	format = mPlan->format;
	if (mTrava->isColorKey(colorKey, format)) {
		return mTrava;
	}
	if (mCesta->isColorKey(colorKey, format)) {
		return mCesta;
	}
	if (mVoda->isColorKey(colorKey, format)) {
		return mVoda;
	}
	if (mZed->isColorKey(colorKey, format)) {
		return mZed;
	}
	if (mCil1->isColorKey(colorKey, format)) {
		return mCil1;
	}
	if (mCil2->isColorKey(colorKey, format)) {
		return mCil2;
	}
	if (mCil3->isColorKey(colorKey, format)) {
		return mCil3;
	}
	if (mCil4->isColorKey(colorKey, format)) {
		return mCil4;
	}
	if (mCil5->isColorKey(colorKey, format)) {
		return mCil5;
	}
	if (mCil6->isColorKey(colorKey, format)) {
		return mCil6;
	}

	// chyba
	CSystem::chyba("Neznamy teren!");

	// pro compiler
	return NULL;
}


//-----------------------------------------------------------------
/*
   vytvori empty Surface podle predlohy
 */
	SDL_Surface *
CMapa::createSurface(const SDL_Surface *predloha)
{
	SDL_Surface *surface;

	surface = SDL_CreateRGBSurface(predloha->flags, predloha->w, predloha->h,
			predloha->format->BitsPerPixel,
			predloha->format->Rmask, predloha->format->Gmask,
		   	predloha->format->Bmask, predloha->format->Amask);
	if(surface == NULL) {
		CSystem::problemSDL();
	}


	// pro spravne barvy
	SDL_Surface *tmp = surface;
	surface = SDL_DisplayFormat(tmp);
	SDL_FreeSurface(tmp);
	return surface;
}



