#include "minimax.h"
#include "defs.h"
#include <iostream>
#include <fstream>

/************************************************************************
 *                        Constructor                                   *
 ************************************************************************/
miniMax::miniMax(string valuesFileName, int depth, int difficulty, int aiPlayer)
{
   int y;
   string strBuffer;
    
   ifstream file;
   file.open(valuesFileName.c_str(), ios::in | ios::binary);
   if(!file)
   {
      cerr << "Failed to open '" << valuesFileName << "'." << std::endl;
   }
   else
   {
      for(y=0;y<8;y++)
      {
         getline(file, strBuffer);
         sscanf(strBuffer.c_str(),"%d %d %d %d %d %d %d %d",&values[0][y],
                &values[1][y],&values[2][y],&values[3][y],&values[4][y],
                &values[5][y],&values[6][y],&values[7][y]);
      }
      file.close();
      /*printf("Opened:\n");
      for(y=0;y<8;y++)
      {
         printf("%d %d %d %d %d %d %d %d\n",values[0][y], values[1][y],
                values[2][y], values[3][y], values[4][y], values[5][y],
                values[6][y], values[7][y]);
      }*/
   }
   maxDepth = depth;
   difficultyLevel = difficulty;
   playerColor = aiPlayer;
   if(aiPlayer == RED_PLAYER)
   {
       userColor = GREEN_PLAYER;
   }
   else
   {
       userColor = RED_PLAYER;
   }
   bonus = 1000;
}

/************************************************************************
 *                       Destructor                                     *
 ************************************************************************/
miniMax::~miniMax()
{
}

/************************************************************************
 *                      cornerCounter                                   *
 ************************************************************************/
void miniMax::cornerCounter(board state, int& playerCnt, int& userCnt, 
                            int x, int y)
{
   if(state.getOwner(x, y) == playerColor)
   {
      playerCnt++;
   }
   else if(state.getOwner(x, y) ==   userColor)
   {
      userCnt++;
   }
}

/************************************************************************
 *                      evalCornerCounter                               *
 ************************************************************************/
int miniMax::evalCornerCounter(int playerCnt, int userCnt)
{
   if((playerCnt > 0) && (userCnt == 0))
      return(playerCnt*bonus);
   else if((playerCnt == 0) && (userCnt > 0))
      return(-userCnt*bonus);
   return(0);   
}

/************************************************************************
 *                      evalCornerLines                                 *
 ************************************************************************/
int miniMax::evalCornerLines(board state)
{
   int playerCntL0 = 0, userCntL0 = 0;
   int playerCntL7 = 0, userCntL7 = 0;
   int playerCntC0 = 0, userCntC0 = 0;   
   int playerCntC7 = 0, userCntC7 = 0;
   int i, sum = 0;
   
   for(i=0; i<8; i++)
   {
      cornerCounter(state, playerCntL0, userCntL0, 0, i);
      cornerCounter(state, playerCntL7, userCntL7, 7, i);
      cornerCounter(state, playerCntC0, userCntC0, i, 0);
      cornerCounter(state, playerCntC7, userCntC7, i, 7);
   }
   sum += evalCornerCounter(playerCntL0, userCntL0);
   sum += evalCornerCounter(playerCntL7, userCntL7);
   sum += evalCornerCounter(playerCntC0, userCntC0);
   sum += evalCornerCounter(playerCntC7, userCntC7);
   
   return(sum);
}

/************************************************************************
 *                           evalPosition                               *
 ************************************************************************/
int miniMax::evalPosition(board& state)
{
   int sum = 0;
   int x,y;

   for(x=0; x<8; x++)
   {
      for(y=0; y<8;   y++)
      {
         if(state.getOwner(x,y) == playerColor)
         {
            sum += values[x][y];
         }
         else if(state.getOwner(x,y) == userColor)
         {
            sum -= values[x][y];
         }
      }
   }
   if(difficultyLevel == MENU_HARD)
   {
      sum += evalCornerLines(state);
   }
   
   return(sum);
}

/************************************************************************
 *                               evalLeaf                                *
 ************************************************************************/
int miniMax::evalLeaf(avaibleMovesList&   movesList)
{
   int redTotals, greenTotals;
   movesList.getTotals(redTotals, greenTotals);
   if( playerColor ==   RED_PLAYER)
   {
      if(redTotals - greenTotals > 0)
      {
         return(3276700);
      }
      else if(redTotals - greenTotals == 0)
      {
         return(0);
      }
      else
      {
         return(-3276700);
      }
   }
   else
   {
      if(redTotals - greenTotals < 0)
      {
         return(3276700);
      }
      else if(redTotals - greenTotals == 0)
      {
         return(0);
      }
      else
      {
         return(-3276700);
      }
   }
}

/************************************************************************
 *                           getAIActon                                 *
 ************************************************************************/
bool miniMax::getAIAction(avaibleMovesList& movesList, board& gameBoard)
{
   int alpha = - 3276800;   //alpha = -infinity
   int beta  =  + 3276800;  //beta  = +infinity
   int destX, destY;
   if(movesList.isEmpty())
   {
       //Don't   have any moves to   make
       return(true);
   }
   else
   {
       if(difficultyLevel >= MENU_NORMAL)
       {
          //Verify   if can take   extreme   positions
          if(movesList.isDestinyInList(0,0))
          {
           	 movesList.doMove(0, 0);
             return(true);
          }
          else if(movesList.isDestinyInList(0,7))
          {
             movesList.doMove(0, 7);
             return(true);
          }
          else if(movesList.isDestinyInList(7,0))
          {
             movesList.doMove(7, 0);
             return(true);
          }
          else if(movesList.isDestinyInList(7, 7))
          {
             movesList.doMove(7, 7);
             return(true);
          }
      }
      //do miniMax
      /*int m =*/
      maxValue(movesList, alpha, beta, 0, destX, destY, true);
      //printf("Max: %d x: %d y: %d\n", m, destX, destY);
      movesList.doMove(destX, destY);
      return(true);
   }
   return(false);
}

/************************************************************************
 *                             gameEnded                                *
 ************************************************************************/
bool miniMax::gameEnded(avaibleMovesList& movesList, bool previousPlayed)
{
   return((!previousPlayed) && (movesList.isEmpty()));
}

/************************************************************************
 *                             maxValue                                 *
 ************************************************************************/
int miniMax::maxValue(avaibleMovesList& movesList, int alpha, int beta,   
                                 int curDepth, int& destX, int& destY,   
                                 bool previousPlayed)
{
   if(gameEnded(movesList, previousPlayed))
   {
      return(evalLeaf(movesList));
   }
   else if(movesList.isEmpty())
   {
      //AI can't play
      destX = -1;
      destY = -1;
      int auX, auY;
      return(minValue(movesList, alpha, beta, curDepth+1, auX, auY, false));
    }
    else if(curDepth == maxDepth+1)
    {
        board* br   =   movesList.getInternalBoard();
        return(evalPosition(*br));
    }
    else
    {
       avaibleMove* movAux   =   movesList.getFirst();
       //board* fictionalBoard;
       avaibleMovesList*   fictionalList;
       int dx, dy;
       int auX, auY;
       destX = -1;
       destY = -1;
       int value;
       int max = -3276800;
       
       while(movAux != NULL)
       {
          //do move on fictional board
          //fictionalBoard = new board(*movesList.getInternalBoard());
          movAux->getCoordinate(dx, dy);
          movesList.doMove(dx,dy);
          //Create new list of moves to the fictional state
          fictionalList = new avaibleMovesList(userColor, 
                                               movesList.getInternalBoard());
          value = minValue(*fictionalList,alpha,beta,curDepth+1, auX, auY,true);

          movesList.undoMove(dx, dy);
          delete(fictionalList);

          if(max <= value)
          {
              max = value;
              destX = dx;
              destY = dy;
              if(max >= beta)
              {
                  //the max of mins is greater than the min already found
                  //printf("max >= beta : %d   >= %d\n",   max, beta);
                  return(max);
              }
              else if(max > alpha)
              {
                  //the max of mins is greater than the max already found
                  alpha = max;
              }
          }
          movAux = movAux->next;
       }
       return(max);
   }
}

/************************************************************************
 *                               minValue                               *
 ************************************************************************/
int miniMax::minValue(avaibleMovesList& movesList, int alpha, int beta,   
                                 int curDepth, int& destX, int& destY,
                                 bool previousPlayed)
{
    if(gameEnded(movesList, previousPlayed))
    {
       return(evalLeaf(movesList));
    }
    else if(movesList.isEmpty())
    {
       //User can't play   :^P
       destX = -1;
       destY = -1;
       int auX, auY;
       return(maxValue(movesList, alpha, beta, curDepth+1, auX, auY, false));
    }
    else if(curDepth == maxDepth+1)
    {
       board* br = movesList.getInternalBoard();
       return(evalPosition(*br));
    }
    else
    {
       avaibleMove* movAux = movesList.getFirst();
       //board* fictionalBoard;
       avaibleMovesList* fictionalList;
       int dx, dy;
       int auX, auY;
       destX = -1;
       destY = -1;
       int value;
       int min = 3276800;
        
       while(movAux != NULL)
       {
          //do   move on   fictional   board
          movAux->getCoordinate(dx, dy);
          movesList.doMove(dx,dy);
          //Create   new   list of   moves   to the fictional state
          fictionalList = new avaibleMovesList(playerColor, 
                                          movesList.getInternalBoard());
          value = maxValue(*fictionalList,   alpha, beta, curDepth+1, auX,
                           auY, true);

          movesList.undoMove(dx, dy); 
          delete(fictionalList);

          if(min >= value)
          {
             min = value;
             destX = dx;
             destY = dy;
             if(min <= alpha)
             {
                 //the min of maxs is lesser than the max already found
                 //printf("min <= alpha : %d >= %d\n", min, alpha);
                 return(min);
             }
             else if(min < beta)
             {
                 //the min of maxs is lesser than the min already found
                 beta   =   min;
              }
          }

          movAux = movAux->next;
       }
      return(min);
   }
}

