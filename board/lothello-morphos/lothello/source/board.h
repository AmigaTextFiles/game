#ifndef _board_h
#define _board_h

#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

class board
{
   public:
      /* Default Constructor, that loads images and init board to first move */
      board();
      /* Secundary constructor, that not load images, but init the board to
       * the same state as initialBoard. */
      board(board& initialBoard);
      /* Desctructor */
      ~board();

      /* Draws the Board to the screen
       * Param screen -> screen surface.*/
      void draw(SDL_Surface* screen);
      
      /* Return the total red pieces on game */
      int getTotalRed();
      
      /* Return the total green pieces on game */
      int getTotalGreen();
      
      /* Calculate total red and green pieces */
      void calculateTotals();
      
      /* Get owner of the board position
       * Param x,y -> board coordinate
       * Return the owner of the position */
      int getOwner(int x, int y);
      
      /* Set owner of the board position
       * Param x,y -> board coordinate
       * Param player -> player to own the position
       */
      void setOwner(int x, int y, int player);

      /* Verify if position is valid on board
       * Param x,y -> board coordinate
       * Return -> true if x,y is a valid position
       */
      bool isValid(int x, int y);

		/* Makes a backup of the actual grid state */
		void gridBackup();
		
		/* Draws flipping pieces animation */
		void drawAnimation(SDL_Surface* screen);

      //SDL_Surface* greenPiece[10]; /* Images for green pieces :^P */
      //SDL_Surface* redPiece[10];   /* Images for read pieces */
		SDL_Surface* pieces[10]; /* Images for pieces */

   private:
      SDL_Surface* boardImage; /* Image for game board */
		SDL_Surface* flipImage;  /* Flipping Text Image */
      int totalRed;            /* actual Total Red Pieces on game */
      int totalGreen;          /* actual Total Green Pieces on game */
      int grid[8][8];          /* the internal board representation */
		int prevGrid[8][8];      /* the previous board representation */
};

#endif

