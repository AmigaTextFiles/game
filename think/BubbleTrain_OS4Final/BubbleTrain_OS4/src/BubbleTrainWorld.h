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
 
 /*
  *   Top level program of the game. God to all.
  */
 
#ifndef BUBBLETRAINWORLD_H
#define BUBBLETRAINWORLD_H

// System includes
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>
#include <SDL/SDL_image.h>

// Game includes
#include "Log.h"
#include "SplashScreen.h"
#include "WindowManager.h"


// Game Constanst
#define APP_NAME "Bubble Train"					// Default the name of the application
#define APP_WIDTH 800							// Default size for the application
#define APP_HEIGHT 600

const Uint32 FRAMES_PS = 25;					// Define the frame rate
const Uint32 FPS_DELAY = 1000/FRAMES_PS;		// Calculate the time for each frame from the frame rate

// Global Variables
SDL_Surface* screen = NULL;						// Main program screen
WindowManager* winman = WindowManager::Instance(); // Global refernce to the window manager

// Methods
void gameInitialise (SDL_Surface** screen);		// Initialise the game i.e. setup sdl
void gameCleanup ();							// Clean up - Free all resources / stop playing sounds	
void lockFrameRate (Uint32 startTime);			// Pause the game until the time has run out for the current frame

#endif
