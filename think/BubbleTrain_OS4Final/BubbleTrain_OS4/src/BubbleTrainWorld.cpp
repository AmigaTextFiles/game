/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 

#include "BubbleTrainWorld.h"

int main(int argc, char *argv[])
{

	// Randomise the random num generator	
	srand( (unsigned)time( NULL ) );

	Uint32 startTime = 0;	// Used for locking the frame rate
	bool active = true;	// Defines if the animation is active
	int done = 0;		// Used to break out of the infinite processing loop

	gameInitialise(&screen);

	while (!done)
	{
		startTime = SDL_GetTicks();
		
		// static so that we don't have to recreate it every loop
		static SDL_Event event;

		// Check for events 
		while (SDL_PollEvent (&event))
		{
			switch (event.type)
			{
				case SDL_QUIT:
				{
					done = 1;
					break;
				}
				case SDL_ACTIVEEVENT:
				{
					// Pause the game if we loose focus
					if (event.active.state != SDL_APPMOUSEFOCUS)
					{
						Log::Instance()->log("Paused: because of active event");
						active = event.active.gain;
						winman->setActive(active);
						if (!active)
							Theme::Instance()->pauseSounds(!active);
					}
					break;
				}
				case SDL_MOUSEBUTTONDOWN:
				{
					winman->mouseDown(event.button.x, event.button.y);
					break;
				}
				case SDL_KEYDOWN:
					break;
				case SDL_KEYUP:
				{
					// Process keys
					if (event.key.keysym.sym == SDLK_F11)
					{
						SDL_WM_ToggleFullScreen(SDL_GetVideoSurface());
						break;
					}
					winman->keyPress(event.key.keysym.sym, event.key.keysym.mod, 0);
					break;
				}
				default:
					break;
			}
		}

		// Animate and draw all of the windows
		winman->processFrame(screen);

		// Swap the double buffer surfaces
		SDL_Flip(screen);

		// Pause the game until we are ready to start processing the next frame.
		lockFrameRate(startTime);
	}

	gameCleanup();

	return 0;
}


void gameInitialise (SDL_Surface** screen)
{
	// Initialize SDL
	if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_AUDIO) < 0)
		Log::Instance()->die(1, SV_FATALERROR, "Couldn't initialize SDL: %s\n", SDL_GetError());

	// Set up quiting so that it automatically runs on exit.
	atexit (SDL_Quit);

	// Set the window icon
	//SDL_Surface* icon = Theme::Instance()->loadTransparentBitmap("../gfx/icon.png");
	SDL_Surface* icon = IMG_Load("../gfx/icon.png");
	//SDL_Surface* icon_mask = IMG_Load("../gfx/icon_mask.png");
	if (icon)
	{
		SDL_WM_SetIcon(icon, NULL);//(Uint8*)icon_mask->pixels);
		SDL_FreeSurface(icon);
	}
	else
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Couldn't find the icon ../gfx/icon.png");

	// --------------------------------------------------------------------------
	// Initialise screen
	// --------------------------------------------------------------------------
	// Find out what hardware is available on the current system
	const SDL_VideoInfo * VideoInfo = SDL_GetVideoInfo();     // query SDL for SV_INFORMATION about our video hardware
	if(VideoInfo == NULL)                                     // if this query fails
		Log::Instance()->die(1, SV_FATALERROR, "Failed getting Video info: %s\n", SDL_GetError());

	Uint32 videoFlags = 0;
	if(VideoInfo->hw_available)// is it a hardware surface
		videoFlags = SDL_SWSURFACE | SDL_DOUBLEBUF;
	else
		videoFlags = SDL_SWSURFACE;

	// Blitting is fast copying / moving /swapping of contiguous sections of memory
	// for more about blitting check out : http://www.csc.liv.ac.uk/~fish/HTML/blitzman/bm_blitter.html
	if(VideoInfo->blit_hw)                            // is hardware blitting available
		videoFlags |= SDL_SWSURFACE;

	// Check the video mode supports what we want and get the best bpp for this screen res
	Uint32 bpp=SDL_VideoModeOK(APP_WIDTH, APP_HEIGHT, 32, videoFlags);
	if(!bpp)
		Log::Instance()->die(1, SV_FATALERROR, "Video Mode %d, %d, 32 not supported", APP_WIDTH, APP_HEIGHT);

	// Set 800x600 16-bits video mode
	*screen = SDL_SetVideoMode (APP_WIDTH, APP_HEIGHT, bpp, videoFlags); //SDL_SWSURFACE | SDL_DOUBLEBUF);
	if (*screen == NULL)
		Log::Instance()->die(2, SV_FATALERROR, "Couldn't set 800x600x16 video mode: %s\n", SDL_GetError());

	// --------------------------------------------------------------------------
	// Initialise Audio / Music
	// --------------------------------------------------------------------------
	// Open the audio channels
	// open 44.1KHz, signed 16bit, system byte order,
	//      stereo audio, using 2048 byte chunks
	if(Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 4096)==-1)
		Log::Instance()->die(2, SV_FATALERROR, "Mix_OpenAudio: [FAILED INITIALISE] %s\n", Mix_GetError());

	Mix_VolumeMusic(MIX_MAX_VOLUME/2);

	// allocate 16 mixing channels
	Mix_AllocateChannels(16);

	// Set the window caption
	#ifdef DEBUG
		SDL_WM_SetCaption (APP_NAME " DEBUG", NULL);
	#else
		SDL_WM_SetCaption (APP_NAME, NULL);
	#endif
	
	// --------------------------------------------------------------------------
	// Start the game with the splash screen
	// --------------------------------------------------------------------------
	
	// set up the theme to the default one for the menus
	Theme::Instance()->load("", "default");
    
	// Start the app with the splash screen    
	winman->push(new SplashScreen(*screen));
}

void gameCleanup ()
{
	// free music
	Mix_HaltMusic();

	// Free up the audio resources
	Mix_CloseAudio();
	
	// Clear up all of the windows
	winman->clear();
}

void lockFrameRate (Uint32 startTime)
{
	// Lock the frame rate by checking how much time
	// has passed since the start of the frame and the compare
	// this to the time for each frame.
	Uint32 differenceTime = SDL_GetTicks() - startTime;
	if (differenceTime < FPS_DELAY)
		SDL_Delay(FPS_DELAY - differenceTime);
}
