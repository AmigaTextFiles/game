#include "CGame.hpp"

#include "CNastaveni.hpp"
#include "CSystem.hpp"

Mix_Chunk *CGame::sWinnerSound = NULL;

//-----------------------------------------------------------------
CGame::CGame(SDL_Surface *screen, const char *mapa) : mVozidla()
{
	if (sWinnerSound == NULL) {
		sWinnerSound = CSystem::loadWav("zvuk/winner.wav");
	}

	mScreen = screen;
	mNext = 0;


	mKeys = SDL_GetKeyState(NULL);
	// testovaci
	mMapa = new CMapa(mapa, mScreen);
}

//-----------------------------------------------------------------
/*
   uvolnime 'mVozidla'
   mKeys a mScreen jsou vnitrni struktury SDL a nemaji byt uvolnovany
 */
CGame::~CGame()
{
	delete mMapa;
	// auta nemazat, pouziji se znovu v dalsim kole
}

//-------------------------------------------------------------------
/* 
 * pridani auta
 */
	void
CGame::addCar(CCar *car, int x, int y)
{
	car->reset(x, y);
	mVozidla.push_back(car);
}

//-----------------------------------------------------------------
/*
 * moje obsluha stisknute klavesy
 * vraci zda ma program skoncit ci ne
 */
	bool	
CGame::keyEvent(SDLKey sym)
{
	// zda mame fullscreen
	static bool fullScreen = false;

	switch (sym) {
		case SDLK_ESCAPE:
			return true;
		case SDLK_f:
			// 'f' zapne fullscreen
			//SDL_WM_ToggleFullScreen(mScreen);
			//fullScreen = !fullScreen;
			// pri fullScreenu schovame cursor
			if (fullScreen) {
				SDL_ShowCursor(SDL_DISABLE);
			} else {
				SDL_ShowCursor(SDL_ENABLE);
			}
			break;
		default:
			break;
	}	
	return false;
}

//-----------------------------------------------------------------
/*
 *  osetri globalni klavesy 
 *	vraci parametr done ... zda skoncit, ci ne
 */
	bool	
CGame::updateKeys()
{
	SDL_Event event;
	bool done = false;

	while (SDL_PollEvent(&event)) {
		switch (event.type) {
			case SDL_QUIT:
				// konec
				exit(0);
				break;
			case SDL_KEYDOWN:
				// osetreni stisknuti klavesy
				done = keyEvent(event.key.keysym.sym);

				// neni break !
			case SDL_KEYUP:
				// update pole se stisknutymi klavesy
				mKeys = SDL_GetKeyState(NULL);
				break;
		}
	}
	return done;
}


//-----------------------------------------------------------------
/*
   zajisti trvani kola podle mCNastaveni::timeInterval
 */
	void
CGame::cekani()
{
	Uint32 now;

	now = SDL_GetTicks();
	if (now < mNext) {
		SDL_Delay(mNext - now);
	}
	mNext += CNastaveni::timeInterval;
}

//-----------------------------------------------------------------
/*
   hlavni herni cyklus
 */
	void
CGame::herniCyklus()
{
	bool done = false;

	mNext = SDL_GetTicks() + CNastaveni::timeInterval;
	while (done == false) {
		done = updateKeys();
		done |= moveCars();
		draw();
		cekani();
	}
}
//-----------------------------------------------------------------
/*
   pohnuti vsemi auty
 */
	bool
CGame::moveCars()
{
	int kolo;
	for (vehicles_t::iterator i = mVozidla.begin(); i != mVozidla.end(); i++) {
		strkani(i);
		kolo = (*i)->scan(mMapa);
		if (kolo > CNastaveni::pocetKol) {
			vitez(*i);
			return true;
		}
		(*i)->move(CNastaveni::timeInterval / 1000.0);
		(*i)->drive(mKeys, CNastaveni::timeInterval / 1000.0);
	}
	return false;
}

//-----------------------------------------------------------------
/*
   strkani do ostatnich
 */	
	void
CGame::strkani(vehicles_t::iterator i)
{
	vehicles_t::iterator j = i;
	CCar *kolega = (*i);

	for (j++; j != mVozidla.end(); j++) {
		kolega->bum(*j);
	}
}
//-----------------------------------------------------------------
/*
   gratulacka vitezi
 */
	void
CGame::vitez(CCar *winner)
{
	// prehraj zvuk
	Mix_PlayChannel(-1, sWinnerSound, 0);
	for (int i = 0; i < 50; i++) {
		draw();
		cekani();
		winner->vitez(CNastaveni::timeInterval / 1000.0);
	}
}


//-----------------------------------------------------------------
/*
   vykresleni vsech aut (i pozadi)
 */
	void
CGame::draw()
{
	// smazani obrazovky
	/*	static const Uint32 pozadi = SDL_MapRGB(mScreen->format, 0, 255, 0);
		SDL_FillRect(mScreen, NULL, pozadi);
	 */

	// vykresleni mapy
	mMapa->draw(mScreen);

	for (vehicles_t::iterator i = mVozidla.begin(); i != mVozidla.end(); i++) {
		(*i)->draw(mScreen);
	}

	SDL_Flip(mScreen);
}

