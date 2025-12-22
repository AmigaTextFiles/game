#ifndef _menu_h
#define _menu_h

#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include "defs.h"

class menu
{
   public:
      menu();
      ~menu();

      /* Runs the initial menu
       * Param screen-> SDL_Surface pointer to the screen
       * Return -> menu option choosed*/
      int run(SDL_Surface* screen, int& selDepth, int& selDifficulty );

   private:
      int state;      /* the current state of the menu */
      int difficulty; /* the current difficulty */
      int depth;      /* the current depth */

      
      SDL_Surface* menuImages[TOTAL_OPTIONS]; /* all game selection images */
      SDL_Surface* menuDepths[3];             /* all depth selection images */
      SDL_Surface* menuDifficulty[3];         /* all difficulty images */
      SDL_Surface* back;                      /* background image */

      /* Draw the Menu to the screen
       * screen -> pointer to screen surface */
      void draw(SDL_Surface* screen);

};

#endif
