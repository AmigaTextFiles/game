#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <stdlib.h>
#include "menu.h"
#include "defs.h"
#include "game.h"


int initSDL(SDL_Surface **screen)
{
   if ( SDL_Init(SDL_INIT_VIDEO) < 0 ) 
   {
      printf("Argh! Can't init SDL!\n");
      return(0);
   }
   atexit(SDL_Quit);

   *screen = SDL_SetVideoMode(400, 400, 24, SDL_HWSURFACE | SDL_DOUBLEBUF);
   SDL_WM_SetCaption("lothello","");

   /* Disable Unused Events */
   SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY,SDL_DEFAULT_REPEAT_INTERVAL);
   SDL_EventState(SDL_ACTIVEEVENT, SDL_IGNORE);
   SDL_EventState(SDL_MOUSEMOTION, SDL_IGNORE);
   SDL_EventState(SDL_MOUSEBUTTONDOWN, SDL_IGNORE);
   SDL_EventState(SDL_MOUSEBUTTONUP, SDL_IGNORE);
   SDL_EventState(SDL_JOYAXISMOTION, SDL_IGNORE);
   SDL_EventState(SDL_JOYBALLMOTION, SDL_IGNORE);
   SDL_EventState(SDL_JOYHATMOTION, SDL_IGNORE);
   SDL_EventState(SDL_JOYBUTTONDOWN, SDL_IGNORE);
   SDL_EventState(SDL_JOYBUTTONUP, SDL_IGNORE);
   SDL_EventState(SDL_SYSWMEVENT, SDL_IGNORE);
   SDL_EventState(SDL_VIDEORESIZE, SDL_IGNORE);
   SDL_EventState(SDL_VIDEOEXPOSE, SDL_IGNORE);
   SDL_EventState(SDL_USEREVENT, SDL_IGNORE);

   return(1);
}

int main(int argc, char* argv[])
{
   menu mainMenu;
   int option;
   int depth;
   int difficulty;
   SDL_Surface* screen; /* SDL screen surface */
   if(initSDL(&screen))
   {
      option = mainMenu.run(screen, depth, difficulty);
      while(option != MENU_OPTION_EXIT)
      {
         game gameLoop(option, depth, difficulty);
         gameLoop.run(screen);
         SDL_Delay(100); //To avoid double read of key state
         option = mainMenu.run(screen, depth, difficulty);
      }
   }
   return(1);
}

