#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include "defs.h"
#include "board.h"
#include "avaibleMove.h"
#include "minimax.h"

class game
{
   public:
      /* Constructor
       * Param currentGame -> current game type, based on menu selection */
      game(int currentGame, int depth, int difficulty);
      /* Destructor */
      ~game();

      /* Runs the main game loop
       * Param screen -> pointer to the screen surface */
      void run(SDL_Surface* screen);
      
   private:
      SDL_Surface* movPiece;   /* Image of possible move */
      SDL_Surface* redTurn;    /* Image of red Turn text */
      SDL_Surface* greenTurn;  /* Image of green turn text */
      SDL_Surface* greenWin;   /* Image of end game text */
      SDL_Surface* redWin;     /* Image of end game text */
      SDL_Surface* nobodyWin;  /* Image of end game text */
      SDL_Surface* numbers;    /* The number font image */
      SDL_Surface* escText;    /* Image of Press Esc Information */
      board gameBoard;         /* The "real" game board */
      int gameType;            /* Current Game Type */

      int actualX;             /* actual x board coord of mouse */
      int actualY;             /* actual y board coord of mouse */
      int actualPlayer;        /* actual player to move */

      miniMax* interfaceAI;    /* AI interface MINIMAX with Alpha Beta pruning */

      /* Draw the actual state to the screen 
       * Param screen -> pointer to the screen surface */
      void draw(SDL_Surface* screen);

      /* Get the region of the number on the numbers font image */
      void numberRegion(Sint16& x, Sint16& y, Uint16& w, Uint16& h, int n);

      /* Get the user Action to the play. Return true when user played. */
      bool getUserAction(avaibleMovesList& moves, Uint8 mButton, Uint8* keys);

      /* Get next player to act, seting actualPlayer variable */
      void nextPlayer();
};

