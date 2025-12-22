/*
 	File:        Menu.cpp
  Description: Menu management
  Program:     BlockOut
  Author:      Jean-Luc PONS

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
*/

#include "Menu.h"
#include <time.h>


// ---------------------------------------------------------------------

BOMenu::BOMenu() {
  
  setupManager = NULL;
  soundManager = NULL;
  InitGraphics();
  CreatePage();
  ToPage(&mainMenuPage);

}

// ---------------------------------------------------------------------

void BOMenu::SetSetupManager(SetupManager *manager) {
  setupManager = manager;
}

// ---------------------------------------------------------------------

SetupManager *BOMenu::GetSetup() {
  return setupManager;
}

// ---------------------------------------------------------------------

void BOMenu::SetSoundManager(SoundManager *manager) {
  soundManager = manager;
}

// ---------------------------------------------------------------------

SoundManager *BOMenu::GetSound() {
  return soundManager;
}

// ---------------------------------------------------------------------

void BOMenu::SetHttp(Http *h) {
  http = h;
}

// ---------------------------------------------------------------------

Http *BOMenu::GetHttp() {
  return http;
}

// ---------------------------------------------------------------------

int BOMenu::Process(BYTE *keys,float fTime) {

  int exitValue = 0;
  ProcessAnim(fTime);

  if( animEnded ) {

     // Limit frame 
    if( selPage != &controlsPage &&  selPage != &creditsPage ) {
      SDL_Delay(50);
    }
    exitValue = selPage->Process(keys,fTime);

  } else {

    // Fast animation ending
    if( keys[SDLK_ESCAPE] ) {
      startMenuTime = fTime - (ANIMTIME + BLLETTER_NB*0.25f);
      menuEscaped = TRUE;
      keys[SDLK_ESCAPE] = 0;
    }

  }

  return exitValue;

}

// ---------------------------------------------------------------------

void BOMenu::ToPage(MenuPage *page) {
  ToPage(page,0,NULL);
}

// ---------------------------------------------------------------------

void BOMenu::ToPage(MenuPage *page,int iParam,void *wParam) {

  selPage = page;
  selPage->Prepare(iParam,wParam);
  FullRepaint();
  if( soundManager )
    soundManager->PlayBlub();

}
