#ifndef _avaibleMove_h
#define _avaibleMove_h

#include "board.h"

/* Origin of a move */
typedef struct _origin
{
   int x,y;            /* Position coordinate */
   int direction;      /* What direction to take */
   _origin* next;      /* Next Origin Position */
   _origin* previous;  /* Previous Origin Position */
}origin;

/* An avaible Move to be done, from one or more origins */
class avaibleMove
{
   public:
      /* Constructor
       * Param dx,dy -> destiny coordinates
       * Param ox, oy -> origin coordinate
       * Param odirection -> origin direction to go to destiny*/
      avaibleMove(int dx, int dy, int ox, int oy, int odirection);
      ~avaibleMove();

      /* Insert another origin to the move 
       * Param dx,dy -> destiny coordinates
       * Param ox, oy -> origin coordinate
       * Param odirection -> origin direction to go to destiny*/
      void insertOrigin(int ox, int oy, int odirection);

      /* getDestinyCoordinate of the Move
       * Param -> dx,dy -> variables that will have the coordinates */
      void getCoordinate(int& dx, int& dy);

      /* do the move on the real Board
       * Param player -> player who moved
       * Param realBoard -> the board where move will be done*/
      void doMove(int player, board& realBoard);

      /* undo the move on the real Board
       * Param player -> player who moved
       * Param realBoard -> the board where move will be done*/
      void undoMove(int player, board& realBoard);

      avaibleMove* next;     /* Next Avaible Move */
      avaibleMove* previous; /* Previous Avaible Move */

   private:
      int x,y;               /* Destiny Coordinate */
      origin* from;          /* Origins Positions to the move */
};

/* A list of avaible moves to the player */
class avaibleMovesList
{
   public:
      /* Constructor
       * Param playerToMove -> actual player to move
       * Param realBoard -> the realBoard of the game */
      avaibleMovesList(int playerToMove, board* realBoard);
      /* Desctructor */
      ~avaibleMovesList();

      /* Verify if the move list is empty 
       * return -> true if is empty, false otherwise */
      bool isEmpty();

      /* Verify if a destiny position is in list 
       * param x,y -> coordinates of the destiny 
       * return -> true if is in list, false otherwise */
      bool isDestinyInList(int x, int y);

      /* Do the move to the player, on the board */
      void doMove(int x, int y);

      /* undo the move to the player, on board */
      void undoMove(int x, int y);

      /* Get Totals for actual internal board */
      void getTotals(int& redTotals, int& greenTotals);

      /* Get the internal Board */
      board* getInternalBoard();

      /* Get The first avaible move */
      avaibleMove* getFirst();

   private:
      int movePlayer;       /* The actual Player to Move */
      board* actualBoard;   /* The actual Grid Status */
      avaibleMove* first;   /* First avaible Move */

      /* Constructs the list of avaible Moves */
      void constructList();

      /* Inset the Move on the list (or add origin if already exists) */
      void insertMove(int dx, int dy, int ox, int oy, int odirection);

      /* Get the avaibleMove to the destiny x,y, if exists. */
      avaibleMove* getDestiny(int x, int y);

};

#endif

