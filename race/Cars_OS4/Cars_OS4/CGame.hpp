#ifndef CGAME_H
#define CGAME_H

#include "CCar.hpp"
#include "CMapa.hpp"

#include "SDL.h"
#include "SDL_mixer.h"

#include <vector>

// std:vector ... dynamicke pole
typedef std::vector<class CCar *> vehicles_t;

class CGame {
	static Mix_Chunk *sWinnerSound;
	// promenne
	vehicles_t mVozidla;
	SDL_Surface *mScreen;
	CMapa *mMapa;
	Uint8 *mKeys;
	Uint32 mNext;

	public:
	CGame(SDL_Surface *screen, const char *mapa);
	void herniCyklus();
	void addCar(CCar *car, int x, int y);
	~CGame();
	private:
	bool keyEvent(SDLKey sym);
	bool updateKeys();
	void cekani();
	bool moveCars();
	void draw();
	void strkani(vehicles_t::iterator i);
	void vitez(CCar *winner);
};
#endif

