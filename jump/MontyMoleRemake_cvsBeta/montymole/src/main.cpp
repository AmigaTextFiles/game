/***************************************************************************
*

	NAME		: Monty Mole the remake
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	main function....
						

	CREATED	:	03/12/01
	UPDATES	:	


 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *


*****************************************************************************/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif


#include <stdlib.h>
#include <SDL/SDL.h>
#include "KFile.h"
#include "MontyScreen.h"
#include "KSurface.h"

#define		TIME_FRAME		0x18



#include "MontyMap.h"

/*****************************************************************************

		NAME	: Sort 

		DESCR.: Convert original 8-bit data into something the PC can use

		ENTRY	: 

		EXIT	: 

	*****************************************************************************/

void Sort()
{
	MontyMap	lpMap;

#ifdef	CREAT_BITMAPS
	lpMap.ConvertSpectrumSpritesToBMP(0x813B, "ascii.bmp", 0x30, 0x01, 0x08, 0x08);
	lpMap.ConvertRoomTilesToBMP("tiles.bmp");
	lpMap.ConvertSpectrumSpritesToBMP(0x7A00, "helpers.bmp",
																	 0x10, 1, 0x10, 0x10);
	lpMap.ConvertSpectrumSpritesToBMP(0x6000, "killers.bmp",
																	  48, 0x04, 0x10, 0x10);
	lpMap.ConvertSpectrumSpritesToBMP(0x8E7A, "crusher1.bmp", 1, 1, 0x18, 0x09);
	lpMap.ConvertSpectrumSpritesToBMP(0x849C, "monty.bmp", 4, 4, 0x10, 0x10);
#endif
	lpMap.ExpandLayout();
	lpMap.InitRoom2C();
	lpMap.Save();
}






#ifdef ISS_OS
  void game_main(int argc, char argv[])
#else
  int main( int argc, char* argv[] )
#endif

{
	SDL_Event		event;
  bool				keyDn = false;
	int					t=0;
	Uint32			lastTime = 0,		
							currentTime = 0;
	Uint32			mode = SDL_HWSURFACE | SDL_DOUBLEBUF | SDL_FULLSCREEN;


	KFile		file;
	MontyScreen	screen;
	bool		gameRunning;


#ifdef ISS_OS
       // Mount root filesystem
	mountRoot(&rootDir);
        /* init the graphics system */
	//ADL_GraphicsInitialise();

  printf("Running Monty Mole....");

#endif



	// Initialize defaults, Video and Audio 
	if((SDL_Init(SDL_INIT_VIDEO)==-1))
#ifdef ISS_OS
		return;
#else
		return -1;
#endif


//	Sort();


	gameRunning = screen.Create();
	printf("Created screen object.\n");
	screen.NewGame();

	// Clean up on exit
  atexit(SDL_Quit);
	printf("SDL_Quit set\n");
  // Initialize the display

  /* Poll for events. SDL_PollEvent() returns 0 when there are no  */
  /* more events on the event queue, our while loop will exit when */
  /* that occurs.                                                  */

  while( keyDn == false )
	{
    SDL_PollEvent( &event );
		/* We are only worried about SDL_KEYDOWN and SDL_KEYUP events */
    switch( event.type )
		{
      case SDL_KEYDOWN:
        if(event.key.keysym.sym == SDLK_ESCAPE)
					keyDn = true;
        break;

      case SDL_KEYUP:
        break;

      default:
        break;
    }


		/*
		currentTime = SDL_GetTicks();
		if(currentTime-lastTime >= TIME_FRAME)
		{
			lastTime = currentTime;
			frame.y +=frame.h;
			if(frame.y>500)
				frame.y=0;
		}
		*/

		if(gameRunning)
		{
			screen.HandleEvent(&event);
			currentTime = SDL_GetTicks();
			if(currentTime-lastTime >= TIME_FRAME)
			{
				lastTime = currentTime;
			  screen.cls();
				screen.Update();
			}
		}
		else
		{
		  screen.cls();
		  screen.UpdateError();
		}


	}

	/* Shutdown all subsystems */
	SDL_Quit();

	return
#ifndef ISS_OS
				0
#endif
					;
}

