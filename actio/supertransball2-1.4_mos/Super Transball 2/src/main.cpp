#ifdef _WIN32
#include <windows.h>
#include <windowsx.h>
#else
#include <sys/time.h>
#include <time.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include "SDL/SDL.h"
#include "SDL_mixer.h"
#include "sge.h"

#include "fonts.h"
#include "list.h"

#include "tiles.h"
#include "maps.h"
#include "transball.h"

/*						GLOBAL VARIABLES INITIALIZATION:							*/ 
#ifdef __MORPHOS__
ULONG __stack = 32768UL;
const char *version_tag = "$VER: Super Transball 2 1.4 (2005-02-28)";
#endif

int SCREEN_X=320;
int SCREEN_Y=240;
int COLOUR_DEPTH=32;

#ifdef _WIN32
bool fullscreen=true;
#else
bool fullscreen=false;
#endif

/* Redrawing constant: */ 
const int REDRAWING_PERIOD=18;

/* Frames per second counter: */ 
int frames_per_sec=0;
int frames_per_sec_tmp=0;
int init_time=0;


/* Surfaces: */ 
SDL_Surface *screen_sfc;

TRANSBALL *game=0;

/*						AUXILIAR FUNCTION DEFINITION:							*/ 

bool gamecycle(SDL_Surface *screen,int sx,int sy);


#ifndef _WIN32
struct timeval init_tick_count_value;

void setupTickCount()
{
	gettimeofday(&init_tick_count_value, NULL);
}

long GetTickCount()
{
	struct timeval now;
	gettimeofday(&now, NULL);
	struct timeval diff;
	diff.tv_sec = now.tv_sec - init_tick_count_value.tv_sec;
	diff.tv_usec = now.tv_usec - init_tick_count_value.tv_usec;
	if (diff.tv_usec < 0)
	{
		diff.tv_sec--;
		diff.tv_usec+=1000000;
	}
	return diff.tv_sec*1000 + diff.tv_usec/1000;
}
#endif

void pause(unsigned int time)
{
	unsigned int initt=GetTickCount();

	while((GetTickCount()-initt)<time);
} /* pause */ 


SDL_Surface* initializeSDL(int moreflags)
{
	SDL_Surface *screen;

	//int flags = SDL_HWSURFACE | SDL_DOUBLEBUF | SDL_HWPALETTE;
	int flags = SDL_HWPALETTE|moreflags;
	if (SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO)<0) return 0;
	atexit(SDL_Quit);
	SDL_WM_SetCaption("Super Transball 2 v1.4", 0);
	SDL_ShowCursor(SDL_DISABLE);
	SDL_EnableUNICODE(1);

	screen = SDL_SetVideoMode(SCREEN_X, SCREEN_Y, COLOUR_DEPTH, flags);

	pause(200);

#ifdef __MORPHOS__
	if (Mix_OpenAudio(22050, AUDIO_S16MSB, 2, 1024)) {
#else
	if (Mix_OpenAudio(22050, AUDIO_S16, 2, 1024)) {
#endif
		return 0;
	} /* if */ 

	return screen;
} /* initializeSDL */ 


void finalizeSDL()
{
	Mix_CloseAudio();
	SDL_Quit();
} /* finalizeSDL */ 



#ifdef _WIN32
int PASCAL WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance,
                    LPSTR lpCmdLine, int nCmdShow)
{
#else
int main(int argc, char** argv)
{
	setupTickCount();
#endif

	int time,act_time;
	SDL_Event event;
    bool quit = false;

	time=init_time=GetTickCount();
	screen_sfc = initializeSDL((fullscreen ? SDL_FULLSCREEN : 0));
	if (screen_sfc==0) return 0;

	if (!fonts_initialization()) return 0;

	while (!quit) {
		while( SDL_PollEvent( &event ) ) {
            switch( event.type ) {
                /* Keyboard event */
                case SDL_KEYDOWN:
					if (event.key.keysym.sym==SDLK_F12) quit = true;

					if (event.key.keysym.sym==SDLK_RETURN) {
						SDLMod modifiers;

						modifiers=SDL_GetModState();

						if ((modifiers&KMOD_ALT)!=0) {
							/* Toogle FULLSCREEN mode: */ 
							finalizeSDL();
							if (game!=0) game->free_sounds();
							if (fullscreen) fullscreen=false;
									   else fullscreen=true;
							screen_sfc = initializeSDL((fullscreen ? SDL_FULLSCREEN : 0));
							if (screen_sfc==0) return 0;
							/* Reload: */ 
							if (game!=0) game->load_sounds();
						} /* if */ 
					} /* if */ 
                    break;

                /* SDL_QUIT event (window close) */
                case SDL_QUIT:
                    quit = true;
                    break;
            } /* switch */ 
        } /* while */ 

		act_time=GetTickCount();
		if (act_time-time>=REDRAWING_PERIOD)
		{

			frames_per_sec_tmp+=1;
			if ((act_time-init_time)>=1000) {
				frames_per_sec=frames_per_sec_tmp;
				frames_per_sec_tmp=0;
				init_time=act_time;
			} /* if */ 

			time+=REDRAWING_PERIOD;
			if ((act_time-time)>2*REDRAWING_PERIOD) time=act_time;
		
			if (!gamecycle(screen_sfc,SCREEN_X,SCREEN_Y)) quit=true;	
			SDL_Flip(screen_sfc);
		}
	}

	fonts_termination();

	finalizeSDL();

	return 0;
}
