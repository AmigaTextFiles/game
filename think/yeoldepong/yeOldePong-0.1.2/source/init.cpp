// init.cpp - Contains the functions as outlined in init.h
//            These functions are mostly the SDL initialization
//            function calls aggregated into one function for the
//            main program to call.
//
// Author: Josh Wheeler
// For copyright information, read the file COPYING in the directory.
// 

#include <iostream>
#include "init.h"
#include "SDL.h"

using namespace std;

// Combines all the necessary initalization functions into one
// function for the main program to call.
void initialize(SDL_Surface *screen) {
   // Variables necessary to initialize.
   SDL_Surface *logo;
   SDL_Rect logoArea;

   // Make the cursor invisible.
   SDL_ShowCursor(0);

   // Set the screen to fullscreen for gameplay.
   SDL_WM_ToggleFullScreen(screen);

   // Bring the logo to the memory.
   logo= SDL_LoadBMP("logo.bmp");
   if(logo == NULL) {
      cerr << "Could not open file: logo.bmp." << endl;
   }

   // Set the parameters of the logoArea rectangle.
   logoArea.x = 192;
   logoArea.y = 176;
   logoArea.w = logo->w;
   logoArea.h = logo->h;
   
   // Draw the logo picture to the screen and free up the memory
   // used by the logo.
   if(SDL_BlitSurface(logo, NULL, screen, &logoArea) < 0) {
      cerr << "BlitSurface error: " << SDL_GetError() << endl;
   }
   // Update the entire screen.
   SDL_UpdateRect(screen, 0, 0, 0, 0);
   SDL_FreeSurface(logo);
}

void clearScreen(SDL_Surface *screen) {
   // Set up the black color integer.
   int blackColor = SDL_MapRGB(screen->format, 0x00, 0x00, 0x00);
	
   // Set the screen-blanking rectangle to be black.
   SDL_FillRect(screen, NULL , blackColor);
   
   // Erase the entire screen to prepare it to draw the field of
   // play.
   SDL_UpdateRect(screen, 0, 0, 0, 0);
}
