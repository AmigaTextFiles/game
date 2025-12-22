#ifndef _minimax_h
#define _minimax_h

/* This class implement minimax search with alpha-beta prunning */

#include "avaibleMove.h"
#include <string>
using namespace std;
#include "board.h"

class miniMax
{
   public:
      miniMax(string valuesFileName, int depth, int difficulty, int aiPlayer);
      ~miniMax();

      /* Gets AI Action to the turn. 
       * Param movesList -> actual moves list
       * Return true when finished. */
      bool getAIAction(avaibleMovesList& movesList, board& gameBoard);

      
   private:
      int maxDepth;                /* max search depth */
      int difficultyLevel;         /* current level of difficulty */
      int values[8][8];            /* Values to the evalute function */
      int playerColor;             /* The AI player color */
      int userColor;               /* The Human player color */
      int bonus;                   /* The corner Bonus */

      /* Evalute function to take X, Y position on actual state */
      int evalPosition(board& state);

      /* Eval Leafs */
      int evalLeaf(avaibleMovesList& movesList);
      
      /* Get maxValue in state */
      int maxValue(avaibleMovesList& movesList, int alpha, int beta, 
                   int curDepth,int& destX, int& destY, bool previousPlayed);

      /* Get minValue in state */
      int minValue(avaibleMovesList& movesList, int alpha, int beta, 
                   int curDepth, int& destX, int& destY, bool previousPlayed);

      /* Verify if game ended */
      bool gameEnded(avaibleMovesList& movesList, bool previousPlayed);

      void cornerCounter(board state, int& playerCnt, int& userCnt, int x,int y);
      int evalCornerCounter(int playerCnt, int userCnt);
      int evalCornerLines(board state);
};

#endif

