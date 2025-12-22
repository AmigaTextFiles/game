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
#include "sound.h"

#include "bitmaps.h"
#include "sprites.h"
#include "tiles.h"

#include "mog.h"

extern void DebugReport(void);

int SCREEN_X=640;
int SCREEN_Y=400;
int COLOUR_DEPTH=8;

#define TRANSPARANT_COLOR (0)

#ifdef __MORPHOS__
const char *version_tag = "$VER: The Maze of Galious 0.62 (2005-03-06)";
#endif

#ifdef _WIN32
bool fullscreen=true;
#else
bool fullscreen=false;
#endif

/* Redrawing constant: */ 
int REDRAWING_PERIOD=40;

/* Frames per second counter: */ 
float frames_per_sec=0.0;
int init_time=0;

/* Paths: */ 
char *default_g_path="graphics/original/";
char *default_s_path="sound/original/";
char **g_paths=0;
int n_g_paths=0,act_g_path=0;
char *g_path=0;
char **s_paths=0;
int n_s_paths=0,act_s_path=0;
char *s_path=0;

extern int music_volume,sfx_volume;
extern int fighting_demon;

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



/* Pantalla: */ 

SDL_Surface *screen;


void Render(SDL_Surface *surface);
SDL_Surface* initializeSDL(int flags);
void finalizeSDL();


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
	screen = initializeSDL((fullscreen ? SDL_FULLSCREEN : 0));
	if (screen==0) return 0;

	GameInit(SCREEN_X,SCREEN_Y);

	SDL_FillRect(screen, NULL, 0);
	while (!quit) {
		while( SDL_PollEvent( &event ) ) {
            switch( event.type ) {
                /* Keyboard event */ 
                case SDL_KEYDOWN:
					if (event.key.keysym.sym==SDLK_F12) quit = true;

					if (event.key.keysym.sym==SDLK_RETURN) {

						if (IsAltPressed2()) {
							/* Toogle FULLSCREEN mode: */ 
							if (fullscreen) fullscreen=false;
									   else fullscreen=true;
							SDL_QuitSubSystem(SDL_INIT_VIDEO);
							SDL_InitSubSystem(SDL_INIT_VIDEO);
							if (SDL_WasInit(SDL_INIT_VIDEO)) {
								screen = SDL_SetVideoMode(SCREEN_X, SCREEN_Y, COLOUR_DEPTH, SDL_HWPALETTE|(fullscreen ? SDL_FULLSCREEN : 0));
								
								if (screen == NULL)
							        {
								   fprintf (stderr, "Couldn't set %ix%ix%i", SCREEN_X, SCREEN_Y, COLOUR_DEPTH);
								   if (fullscreen) fprintf(stderr,",fullscreen,");
								   fprintf(stderr," video mode: %s\n",SDL_GetError ());
								   quit=true;
								}
								else
								{
								  fprintf (stderr, "Set the video resolution to: %ix%ix%i",
									   SDL_GetVideoSurface()->w, SDL_GetVideoSurface()->h,
									   SDL_GetVideoSurface()->format->BitsPerPixel);
								  if (fullscreen) fprintf(stderr,",fullscreen");
								  fprintf(stderr,"\n");
								}
								
								SDL_WM_SetCaption("Maze of Galious v0.62", 0);
								get_palette();
							} else {
								quit = true;
							} /* if */ 
						} /* if */ 
					} /* if */ 

					if (event.key.keysym.sym==SDLK_F10) {
						/* Change GRAPHIC set: */ 
						act_g_path++;
						if (act_g_path>=n_g_paths) act_g_path=0;
						g_path=g_paths[act_g_path];
						ReleaseGraphics();
						ReloadGraphics(SCREEN_X,SCREEN_Y);
						guardar_configuracion("MoG.cfg");
						if (fighting_demon!=0) redo_demonintro(fighting_demon,0,SCREEN_X,SCREEN_Y);
					} /* if */ 
					if (event.key.keysym.sym==SDLK_F11) {
						/* Change the SOUND set: */ 
						act_s_path++;
						if (act_s_path>=n_s_paths) act_s_path=0;
						s_path=s_paths[act_s_path];
						ReleaseSound(false);
						ReloadSound();
						music_recovery();
						guardar_configuracion("MoG.cfg");
						Mix_VolumeMusic(music_volume);
						SetSFXVolume(sfx_volume);
					} /* if */ 

					if (event.key.keysym.sym==SDLK_d) {
						write_debug_report("debug-report.txt");
					} /* if */ 
                    break;

                /* SDL_QUIT event (window close) */ 
                case SDL_QUIT:
                    quit = true;
                    break;
            } /* switch */ 
        } /* while */ 

		act_time=GetTickCount();
		if (!quit && act_time-time>=REDRAWING_PERIOD)
		{
			frames_per_sec+=1.0;
			time+=REDRAWING_PERIOD;
			if ((act_time-time)>2*REDRAWING_PERIOD) time=act_time;
		
			Render(screen);

			SDL_Flip(screen);
		}
	}


//  FRAMES PER SECOND REPORT:
//	frames_per_sec=(frames_per_sec*1000)/(act_time-init_time);
//	FILE *fp=fopen("report.txt","w");
//	fprintf(fp,"FPS: %g",frames_per_sec);
//	fclose(fp);
	finalizeSDL();
// 	DebugReport();

	return 0;
}

SDL_Surface* initializeSDL(int moreflags)
{
	char VideoName[256];
	SDL_Surface *screen;

	//int flags = SDL_HWSURFACE | SDL_DOUBLEBUF | SDL_HWPALETTE;
	int flags = SDL_HWPALETTE|moreflags;
	if (SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO)<0) return 0;

	fprintf (stderr, "Initializing SDL video subsystem.\n");
	if ((SDL_Init(SDL_INIT_VIDEO)) == -1)
	{
	  fprintf (stderr, "Couldn't initialize video subsystem: %s\n", SDL_GetError());
	  exit(-1);
	}
	SDL_VideoDriverName (VideoName, sizeof (VideoName));
    fprintf (stderr, "SDL driver used: %s\n", VideoName);
    // Set the environment variable SDL_VIDEODRIVER to override
    // For Linux: x11 (default), dga, fbcon, directfb, svgalib,
    //            ggi, aalib
    // For Windows: directx (default), windib
	fprintf (stderr, "SDL video subsystem initialized.\n");

	fprintf (stderr, "Initializing SDL audio subsystem.\n");
	if ((SDL_InitSubSystem(SDL_INIT_AUDIO)) == -1)
	{
	  fprintf (stderr, "Couldn't initialize audio subsystem: %s\n", SDL_GetError());
	  exit(-1);
	}
	fprintf (stderr, "SDL audio subsystem initialized.\n");


	atexit(SDL_Quit);
	SDL_WM_SetCaption("Maze of Galious v0.62", 0);
	if (fullscreen) SDL_ShowCursor(SDL_DISABLE);
	Sound_initialization();

	pause(1000);

	screen = SDL_SetVideoMode(SCREEN_X, SCREEN_Y, COLOUR_DEPTH, flags);

	if (screen == NULL) {
		fprintf (stderr, "Couldn't set %ix%ix%i", SCREEN_X, SCREEN_Y, COLOUR_DEPTH);
	    if (fullscreen) fprintf(stderr,",fullscreen,");
	    fprintf(stderr," video mode: %s\n",SDL_GetError ());
	    exit(-1);
	} else {
	    fprintf (stderr, "Set the video resolution to: %ix%ix%i",
				 SDL_GetVideoSurface()->w, SDL_GetVideoSurface()->h,
				 SDL_GetVideoSurface()->format->BitsPerPixel);
	    if (fullscreen) fprintf(stderr,",fullscreen");
	    fprintf(stderr,"\n");
    } /* if */ 

	SDL_EnableUNICODE(1);
	
	return screen;
} /* initializeSDL */ 


void finalizeSDL()
{
	ReleaseSound(true);
	ReleaseGraphics();
	Sound_release();
	SDL_Quit();
} /* finalizeSDL */ 
