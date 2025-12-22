#include "CSystem.hpp"
#include "CGame.hpp"
#include "CCar.hpp"

#include "SDL.h"
#include "SDL_mixer.h"

#include <stdlib.h>
#include <assert.h>

// musika
Mix_Music *music = NULL;


//-----------------------------------------------------------------
/*
 * funkce provedena na konci programu
 */
	void
totalQuit() 
{
	SDL_Quit();
}

//-----------------------------------------------------------------
/*
 * inicializace SDL a videa
 */
	SDL_Surface* 
main_videoInit()
{
	const int plochaWidth = 640;
	const int plochaHeight = 480;

	SDL_Surface *screen;

	CSystem::echo("Inicializuji SDL ...");
	if ( SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) < 0 ) {
		CSystem::problemSDL();
	}
	atexit(totalQuit);

	// title a icona
	SDL_WM_SetCaption("cars OS4 - by jan & ivo", "cars");
	CSystem::setIcon("auta/nakladak.bmp");

	// video
	CSystem::echo("Inicializuji Video mod ...");
	screen = SDL_SetVideoMode(plochaWidth, plochaHeight, 16, SDL_ANYFORMAT);	
	if (screen == NULL) {
		CSystem::problemSDL();
	}

	CSystem::echo("SDL je nyni pripraveno.");
	return screen;
}	

//-----------------------------------------------------------------
/*
 * funkce kterou necham vykonat po skonceni skladby
 */
	void 
musicDone() 
{
	if (music != NULL) {
		Mix_HaltMusic();
		Mix_FreeMusic(music);
	}
	// nahodne vybrani skladby
	switch (CSystem::random(3) /* kolik sladeb */) {
		case 0:	
			music = Mix_LoadMUS("music/mod.apoplexy");
			break;
		case 1:	
			music = Mix_LoadMUS("music/mod.chiptune");
			break;
		case 2:	
			music = Mix_LoadMUS("music/mod.cream_of_the_earth");
			break;
		default:
			assert("blba musika" == NULL);
	}
	// 0 ... znaci bez opakovani
	Mix_PlayMusic(music, 0);
	Mix_HookMusicFinished(musicDone);
}


//-----------------------------------------------------------------
/*
 * zapnuti musiky
 * jestli nekdo pouziva /dev/dsp (`lsof /dev/dsp`)
 * tak sice lze hrat se zvukem, ale je posunuty za obrazem 
 * (system ho jeste jednou mixuje
 */
	void
main_audioInit()
{
	// nastaveni kvality audia
	int audio_rate = 44100;
	Uint16 audio_format = AUDIO_S16; /* 16-bit stereo */
	int audio_channels = 2;
	int audio_buffers = 4096;

	CSystem::echo("Inicializuji SDL_mixer ...");
	if( Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers) < 0 ) {
		CSystem::echo("Unable to open audio!");
		CSystem::problemSDL();
	}
}
//-----------------------------------------------------------------
	int
main()
{
	const int pocetMap = 3;
	char *mapy[pocetMap] = {"mapy/mapa1.bmp", "mapy/mapa2.bmp", "mapy/mapa3.bmp"};
	SDL_Surface *screen;
	CGame *game;
	COvladani player1 = {SDLK_w, SDLK_s, SDLK_a, SDLK_d};
	COvladani player2 = {SDLK_i, SDLK_k, SDLK_j, SDLK_l};
	COvladani player3 = {SDLK_UP, SDLK_DOWN, SDLK_LEFT, SDLK_RIGHT};
	COvladani player4 = {SDLK_KP8, SDLK_KP5, SDLK_KP4, SDLK_KP6};
	CCar *car1, *car2, *car3, *car4;

	// inicializacae SDL (provest co nejdrive)
	screen = main_videoInit();
	main_audioInit();

	// info o podporavem videu
	const SDL_VideoInfo *info = SDL_GetVideoInfo();
	fprintf(stderr, "hw_a: %d, wm_a: %d\n", 
			info->hw_available, info->wm_available);
	fprintf(stderr, "b_hw: %d, b_hw_CC: %d, b_hw_A: %d\n", 
			info->blit_hw, info->blit_hw_CC, info->blit_hw_A);
	fprintf(stderr, "b_sw: %d, b_sw_CC: %d, b_sw_A: %d\n", 
			info->blit_sw, info->blit_sw_CC, info->blit_sw_A);
	fprintf(stderr, "b_fill: %d, v_mem: %d, bpp: %d\n", 
			info->blit_fill, info->video_mem, info->vfmt->BitsPerPixel);


	car1 = new CCar(player1, 75, 280, "auta/porche.bmp");
	car2 = new CCar(player2, 95, 300, "auta/formule.bmp");
	car3 = new CCar(player3, 115, 280, "auta/nakladak.bmp");
	car4 = new CCar(player4, 135, 300, "auta/hummer.bmp");

	for (int i = 0; i < pocetMap; i++) { 
		musicDone();
		game = new CGame(screen, mapy[i]);

		// auta
		game->addCar(car1, 75, 280);
		game->addCar(car2, 95, 300);
		game->addCar(car3, 115, 280);
		game->addCar(car4, 135, 300);

		// herniCyklus
		game->herniCyklus();

		delete game;
	}

	delete car1;
	delete car2;
	delete car3;
	delete car4;
}


