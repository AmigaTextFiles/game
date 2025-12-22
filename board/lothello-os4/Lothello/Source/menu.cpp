#include "menu.h"

menu::menu()
{
   /* Load all Menu Images */
   menuImages[MENU_OPTION_NONE] = IMG_Load("data/menu/none.png");
   menuImages[MENU_OPTION_2PLAYERS] = IMG_Load("data/menu/twoplayers.png");
   menuImages[MENU_OPTION_RED] = IMG_Load("data/menu/sred.png");
   menuImages[MENU_OPTION_GREEN] = IMG_Load("data/menu/sgreen.png");
   menuImages[MENU_OPTION_EXIT] = IMG_Load("data/menu/exit.png");

   menuDepths[0] = IMG_Load("data/menu/depth3.png");
   menuDepths[1] = IMG_Load("data/menu/depth5.png");
   menuDepths[2] = IMG_Load("data/menu/depth7.png");

   menuDifficulty[0] = IMG_Load("data/menu/dif_easy.png");
   menuDifficulty[1] = IMG_Load("data/menu/dif_normal.png");
   menuDifficulty[2] = IMG_Load("data/menu/dif_hard.png");

   back = IMG_Load("data/menu/fundo.png");

   state = MENU_OPTION_NONE;
   difficulty = MENU_NORMAL;
   depth = 1;
}

menu::~menu()
{
   int i;
   /* Delete All Images */
   for(i=0; i < TOTAL_OPTIONS; i++)
   {
      SDL_FreeSurface(menuImages[i]);
   }
   for(i=0; i<3; i++)
   {
      SDL_FreeSurface(menuDepths[i]);
      SDL_FreeSurface(menuDifficulty[i]);
   }
   SDL_FreeSurface(back);
}

int menu::run(SDL_Surface* screen, int& selDepth, int& selDifficulty)
{
   bool selected = false;
   Uint8 mButton;
   int x,y;
   Uint8 *keys;
   int curState = MENU_OPTION_NONE;
   state = MENU_OPTION_NONE;

   draw(screen);
   
   while(!selected)
   {
      SDL_PumpEvents();
      keys = SDL_GetKeyState(NULL);
      mButton = SDL_GetMouseState(&x,&y);

      /* Verify Mouse State */
      if( (x >= 115+18) && (x <= 115+155) &&
          (y >= 150+4) && (y <= 150+16))
      {
         curState = MENU_OPTION_2PLAYERS;
      }
      else if( (x >= 115+11) && (x <= 115+162) &&
          (y >= 150+26) && (y <= 150+38))
      {
         curState = MENU_OPTION_RED;
      }
      else if( (x >= 115+1) && (x <= 115+172) &&
          (y >= 150+48) && (y <= 150+60))
      {
         curState = MENU_OPTION_GREEN;
      }
      else if( (x >= 115+72) && (x <= 115+103) &&
          (y >= 150+70) && (y <= 150+82))
      {
         curState = MENU_OPTION_EXIT;
      }
      else
      {
         curState = MENU_OPTION_NONE;
      }

      if( (x >= 95+96) && (x <= 95+105) &&
          (y >= 280+4) && (y <= 280+22) && 
          (mButton & SDL_BUTTON(1)) &&
          (depth > 0))
      {
         depth--;
         draw(screen);
         SDL_Delay(100);
      }
      else if( (x >= 95+208) && (x <= 95+217) &&
          (y >= 280+4) && (y <= 280+22) && 
          (mButton & SDL_BUTTON(1)) && 
          (depth < 2))
      {
         depth++;
         draw(screen);
         SDL_Delay(100);
      }

      if( (x >= 145+1) && (x <= 145+10) &&
          (y >= 250+0) && (y <= 250+18) && 
          (mButton & SDL_BUTTON(1)) &&
          (difficulty > MENU_EASY))
      {
         difficulty--;
         draw(screen);
         SDL_Delay(100);
      }
      else if( (x >= 145+113) && (x <= 145+122) &&
          (y >= 250+0) && (y <= 250+18) && 
          (mButton & SDL_BUTTON(1)) && 
          (difficulty < MENU_HARD))
      {
         difficulty++;
         draw(screen);
         SDL_Delay(100);
      }


      /* Verify Keyboard State */
      if(keys[SDLK_ESCAPE])
      {
         //quit game
         selected = true;
         curState = MENU_OPTION_EXIT;
      }

      /* Update Screen, if needed */
      if(curState != state)
      {
         state = curState;
         draw(screen);
      }

      /* Verify if choosed by mouse click */
      if( (state != MENU_OPTION_NONE) && (mButton & SDL_BUTTON(1)))
      {
         selected = true;
      }

      SDL_Delay(40); // to not 100% use of CPU
   }
   selDifficulty = difficulty;
   selDepth = (depth*2)+3;
   return(state);
}

void menu::draw(SDL_Surface* screen)
{
   SDL_Rect ret;

   /* Put Background image */
   SDL_BlitSurface(back,NULL,screen,NULL);
  
   /* Put Actual Menu Images */
   ret.x = 115;
   ret.y = 150;
   SDL_BlitSurface(menuImages[state],NULL,screen,&ret);
   ret.x = 145;
   ret.y = 250;
   SDL_BlitSurface(menuDifficulty[difficulty],NULL,screen,&ret);
   ret.x = 95;
   ret.y = 280;
   SDL_BlitSurface(menuDepths[depth],NULL,screen,&ret);

   SDL_Flip(screen);
}

