#include "game.h"

game::game(int currentGame,  int depth, int difficulty)
{
   /* Define game type */
   gameType = currentGame;

   /* define game pictures */
   movPiece = IMG_Load("data/game/botaoreversiazul.png");
   redTurn = IMG_Load("data/game/redturn.png");
   greenTurn = IMG_Load("data/game/greenturn.png");
   numbers = IMG_Load("data/game/numbers.png");
   redWin = IMG_Load("data/game/redwin.png");
   greenWin = IMG_Load("data/game/greenwin.png");
   nobodyWin = IMG_Load("data/game/nobodywin.png");
   escText = IMG_Load("data/game/esctext.png");

   /* Load AI infos */
   if(gameType == MENU_OPTION_RED)
   {
      interfaceAI = new miniMax("data/ia/board8x8Values2.brd", depth, difficulty,
                                GREEN_PLAYER);
   }
   else if(gameType == MENU_OPTION_GREEN)
   {
      interfaceAI = new miniMax("data/ia/board8x8Values2.brd", depth, difficulty,
                                RED_PLAYER);
   }
   else
   {
      interfaceAI = NULL;
   }
}

game::~game()
{
   SDL_FreeSurface(movPiece);
   SDL_FreeSurface(redTurn);
   SDL_FreeSurface(greenTurn);
   SDL_FreeSurface(numbers);
   SDL_FreeSurface(redWin);
   SDL_FreeSurface(greenWin);
   SDL_FreeSurface(nobodyWin);
   SDL_FreeSurface(escText);

   if(interfaceAI != NULL)
   {
      delete(interfaceAI);
   }
}

bool game::getUserAction(avaibleMovesList& moves, Uint8 mButton, Uint8* keys)
{
   if( (actualX >= 0) && (actualX <= 7) &&
       (actualY >= 0) && (actualY <= 7))
   {
      if(!moves.isDestinyInList(actualX,actualY))
      {
         actualX = -1;
         actualY = -1;
      }
      else if(mButton & SDL_BUTTON(1))
      {
         /* played */
         moves.doMove(actualX, actualY);
         return(true);
      }
   }
   return(false);
}

void game::nextPlayer()
{
   if(actualPlayer == RED_PLAYER)
   {
      actualPlayer = GREEN_PLAYER;
   }
   else
   {
      actualPlayer = RED_PLAYER;
   }
}

void game::run(SDL_Surface* screen)
{
   actualPlayer = RED_PLAYER;
   Uint8 mButton;
   int x,y;
   Uint8 *keys;
   avaibleMovesList* moves;

   bool userPlayed = false;

   SDL_Delay(100); //TO avoid playing before screen 
   
   SDL_PumpEvents();
   keys = SDL_GetKeyState(NULL);

   moves = new avaibleMovesList(actualPlayer, &gameBoard);
   
   while(!keys[SDLK_ESCAPE])
   {
      userPlayed = false;
      mButton = SDL_GetMouseState(&x,&y);
      actualX = (x / 40)-1;
      actualY = (y / 40)-1;

      if( (gameType == MENU_OPTION_2PLAYERS) ||
          ((gameType == MENU_OPTION_RED) && (actualPlayer == RED_PLAYER)) ||
          ((gameType == MENU_OPTION_GREEN) && (actualPlayer == GREEN_PLAYER)) )
      {
         /* Get User Action */
			gameBoard.gridBackup();
         userPlayed = getUserAction(*moves, mButton, keys);
      }
      else if(actualPlayer != NOBODY)
      {
         /* Get AI Action */
			gameBoard.gridBackup();
         actualX = -1;
         actualY = -1;
         //draw(screen);
         userPlayed = interfaceAI->getAIAction(*moves, gameBoard);
      }

      if(userPlayed)
      {
		   actualX = -1;
			actualY = -1;
			gameBoard.drawAnimation(screen);
         /* Take next user to play */
         nextPlayer();
         
         /* take the avaible moves to make */
         delete(moves);
         moves = new avaibleMovesList(actualPlayer, &gameBoard);
         
         if(moves->isEmpty())
         {
            //oopps, no actions for player, so goes to next
            nextPlayer();
            
            delete(moves);
            moves = new avaibleMovesList(actualPlayer, &gameBoard);
            
            if(moves->isEmpty())
            {
               //the game is over
               actualPlayer = NOBODY;
               actualX = -1;
               actualY = -1;
               draw(screen);
            }
         }
         SDL_Delay(200);
      }
      draw(screen);
      SDL_PumpEvents();
      keys = SDL_GetKeyState(NULL);
   }
   delete(moves);
   SDL_Delay(50);
}

void game::numberRegion(Sint16& x, Sint16& y, Uint16& w, Uint16& h, int n)
{
   x = n*10 +1;
   y = 0;
   w = 8;
   h = 21;
}

void game::draw(SDL_Surface* screen)
{
   SDL_Rect ret;
   SDL_Rect src;

   /* Game Board */
   gameBoard.draw(screen);

   /* Possible Move */
   if( (actualX >= 0) && (actualX <= 7) &&
       (actualY >= 0) && (actualY <= 7) )
   {
      ret.x = 41 + actualX * 40;
      ret.y = 41 + actualY * 40;
      SDL_BlitSurface(movPiece, NULL, screen, &ret);
   }

   /* Turn Information */
   ret.x = 5;
   ret.y = 10;
   if(actualPlayer == RED_PLAYER)
   {
      SDL_BlitSurface(redTurn, NULL, screen, &ret);
   }
   else if(actualPlayer == GREEN_PLAYER)
   {
      SDL_BlitSurface(greenTurn, NULL, screen, &ret);
   }
   else
   {
      //The game is Over
      if(gameBoard.getTotalRed() > gameBoard.getTotalGreen())
      {
         SDL_BlitSurface(redWin, NULL, screen, &ret);
      }
      else if(gameBoard.getTotalRed() < gameBoard.getTotalGreen())
      {
         SDL_BlitSurface(greenWin, NULL, screen, &ret);
      }
      else
      {
         SDL_BlitSurface(nobodyWin, NULL, screen, &ret);
      }
   }

   /* Press Esc Information */
   ret.x = 260;
   ret.y = 22;
   SDL_BlitSurface(escText, NULL, screen, &ret);

   /* Actual Points Information */
   gameBoard.calculateTotals();

   ret.x = 1;
   ret.y = 361;
   SDL_BlitSurface(gameBoard.pieces[9], NULL, screen, &ret);
   ret.x = 41;
   ret.y = 371;
   numberRegion(src.x, src.y, src.w, src.h, gameBoard.getTotalGreen() / 10);
   SDL_BlitSurface(numbers, &src, screen, &ret);
   ret.x = 50;
   numberRegion(src.x, src.y, src.w, src.h, gameBoard.getTotalGreen() % 10);
   SDL_BlitSurface(numbers, &src, screen, &ret);


   ret.x = 361;
   ret.y = 361;
   SDL_BlitSurface(gameBoard.pieces[0], NULL, screen, &ret);
   ret.x = 342;
   ret.y = 371;
   numberRegion(src.x, src.y, src.w, src.h, gameBoard.getTotalRed() / 10);
   SDL_BlitSurface(numbers, &src, screen, &ret);
   ret.x = 351;
   numberRegion(src.x, src.y, src.w, src.h, gameBoard.getTotalRed() % 10);
   SDL_BlitSurface(numbers, &src, screen, &ret);

   
   SDL_Flip(screen);
}

