#include "avaibleMove.h"
#include "defs.h"
#include <stdlib.h>
#include <stdio.h>

/****************************************************************
 *                          avaibleMove                         *
 ****************************************************************/

avaibleMove::avaibleMove(int dx, int dy, int ox, int oy, int odirection)
{
   x = dx;
   y = dy;
   next = NULL;
   previous = NULL;
   from = new(origin);
   from->x = ox;
   from->y = oy;
   from->direction = odirection;
   from->next = NULL;
   from->previous = NULL;
}

avaibleMove::~avaibleMove()
{
   origin* aux;
   while(from != NULL)
   {
      aux = from;
      from = from->next;
      delete(aux);
   }
}

void avaibleMove::insertOrigin(int ox, int oy, int odirection)
{
   origin* aux;
   aux = new(origin);
   aux->x = ox;
   aux->y = oy;
   aux->direction = odirection;

   aux->next = from;
   aux->previous = NULL;
   from->previous = aux;
   from = aux;
}

void avaibleMove::getCoordinate(int& dx, int& dy)
{
   dx = x;
   dy = y;
}

void avaibleMove::doMove(int player, board& realBoard)
{
   int ax, ay;
   origin* aux = from;
   while(aux)
   {
      if(aux->direction == DIRECTION_EAST)
      {
         ax = aux->x-1;
         ay = aux->y;
         while(ax >= x)
         {
            realBoard.setOwner(ax,ay,player);
            ax--;
         }
      }
      else if(aux->direction == DIRECTION_WEST)
      {
         ax = aux->x+1;
         ay = aux->y;
         while(ax <= x)
         {
            realBoard.setOwner(ax,ay,player);
            ax++;
         }
      }
      else if(aux->direction == DIRECTION_NORTH)
      {
         ax = aux->x;
         ay = aux->y-1;
         while(ay >= y)
         {
            realBoard.setOwner(ax,ay,player);
            ay--;
         }
      }
      else if(aux->direction == DIRECTION_SOUTH)
      {
         ax = aux->x;
         ay = aux->y+1;
         while(ay <= y)
         {
            realBoard.setOwner(ax,ay,player);
            ay++;
         }
      }
      else if(aux->direction == DIRECTION_NORTHEAST)
      {
         ax = aux->x-1;
         ay = aux->y-1;
         while( (ax >= x) && (ay >= y))
         {
            realBoard.setOwner(ax,ay,player);
            ax--;
            ay--;
         }
      }
      else if(aux->direction == DIRECTION_NORTHWEST)
      {
         ax = aux->x+1;
         ay = aux->y-1;
         while( (ax <= x) && (ay >= y))
         {
            realBoard.setOwner(ax,ay,player);
            ax++;
            ay--;
         }
      }
      else if(aux->direction == DIRECTION_SOUTHEAST)
      {
         ax = aux->x-1;
         ay = aux->y+1;
         while( (ax >= x) && (ay <= y))
         {
            realBoard.setOwner(ax,ay,player);
            ax--;
            ay++;
         }
      }
      else if(aux->direction == DIRECTION_SOUTHWEST)
      {
         ax = aux->x+1;
         ay = aux->y+1;
         while( (ax <= x) && (ay <= y))
         {
            realBoard.setOwner(ax,ay,player);
            ax++;
            ay++;
         }
      }

      aux = aux->next;
   }
}

void avaibleMove::undoMove(int player, board& realBoard)
{
   int ax, ay;
   int other;

   if(player == RED_PLAYER)
   {
      other = GREEN_PLAYER;
   }
   else
   {
      other = RED_PLAYER;
   }
   
   origin* aux = from;
   while(aux)
   {
      if(aux->direction == DIRECTION_EAST)
      {
         ax = aux->x-1;
         ay = aux->y;
         while(ax > x)
         {
            realBoard.setOwner(ax,ay,other);
            ax--;
         }
         realBoard.setOwner(ax, ay, NOBODY);
      }
      else if(aux->direction == DIRECTION_WEST)
      {
         ax = aux->x+1;
         ay = aux->y;
         while(ax < x)
         {
            realBoard.setOwner(ax,ay,other);
            ax++;
         }
         realBoard.setOwner(ax, ay, NOBODY);
      }
      else if(aux->direction == DIRECTION_NORTH)
      {
         ax = aux->x;
         ay = aux->y-1;
         while(ay > y)
         {
            realBoard.setOwner(ax,ay,other);
            ay--;
         }
         realBoard.setOwner(ax, ay, NOBODY);
      }
      else if(aux->direction == DIRECTION_SOUTH)
      {
         ax = aux->x;
         ay = aux->y+1;
         while(ay < y)
         {
            realBoard.setOwner(ax,ay,other);
            ay++;
         }
         realBoard.setOwner(ax, ay, NOBODY);
      }
      else if(aux->direction == DIRECTION_NORTHEAST)
      {
         ax = aux->x-1;
         ay = aux->y-1;
         while( (ax > x) && (ay > y))
         {
            realBoard.setOwner(ax,ay,other);
            ax--;
            ay--;
         }
         realBoard.setOwner(ax, ay, NOBODY);
      }
      else if(aux->direction == DIRECTION_NORTHWEST)
      {
         ax = aux->x+1;
         ay = aux->y-1;
         while( (ax < x) && (ay > y))
         {
            realBoard.setOwner(ax,ay,other);
            ax++;
            ay--;
         }
         realBoard.setOwner(ax, ay, NOBODY);
      }
      else if(aux->direction == DIRECTION_SOUTHEAST)
      {
         ax = aux->x-1;
         ay = aux->y+1;
         while( (ax > x) && (ay < y))
         {
            realBoard.setOwner(ax,ay,other);
            ax--;
            ay++;
         }
         realBoard.setOwner(ax, ay, NOBODY);
      }
      else if(aux->direction == DIRECTION_SOUTHWEST)
      {
         ax = aux->x+1;
         ay = aux->y+1;
         while( (ax < x) && (ay < y))
         {
            realBoard.setOwner(ax,ay,other);
            ax++;
            ay++;
         }
         realBoard.setOwner(ax, ay, NOBODY);
      }

      aux = aux->next;
   }
}

/****************************************************************
 *                        avaibleMovesList                      *
 ****************************************************************/

avaibleMovesList::avaibleMovesList(int playerToMove, board* realBoard)
{
   /* Initialize the things */
   movePlayer = playerToMove;
   first = NULL;

   actualBoard = realBoard;//new board(realBoard);

   /* Now, get all avaible Moves to the player, puting them on list */
   constructList();
   
}

avaibleMovesList::~avaibleMovesList()
{
   avaibleMove* aux;
   while(first != NULL)
   {
      aux = first;
      first = first->next;
      delete(aux);
   }
   //delete(actualBoard);
}

void avaibleMovesList::insertMove(int dx, int dy, int ox, int oy, 
                                  int odirection)
{
   avaibleMove* move = getDestiny(dx,dy);
   if(move)
   {
      /* The moviment exists, so it's another way to go to it */
      move->insertOrigin(ox,oy,odirection);
   }
   else
   {
      /* if first not exist, create it */
      if(first == NULL)
      {
         first = new avaibleMove(dx, dy, ox, oy, odirection);
         first->next = NULL;
         first->previous = NULL;
      }
      else //else, insert before it
      {
         move = new avaibleMove(dx, dy, ox, oy, odirection);
         move->next = first;
         move->previous = NULL;
         first->previous = move;
         first = move;
      }
   }
}

avaibleMove* avaibleMovesList::getDestiny(int x, int y)
{
   avaibleMove* aux = first;
   int dx, dy;
   
   /* Search on list for destiny */
   while(aux != NULL)
   {
      aux->getCoordinate(dx, dy);
      if( (dx == x) && (dy == y))
      {
         return(aux);
      }
      aux = aux->next;
   }
   return(NULL);
}

bool avaibleMovesList::isDestinyInList(int x, int y)
{
   return(getDestiny(x, y) != NULL);
}

bool avaibleMovesList::isEmpty()
{
   return(first == NULL);
}

void avaibleMovesList::constructList()
{
   int x,y;
   int aux,aux2;
   bool verified;

   for(x=0; x<8; x++)
   {
      for(y=0; y<8; y++)
      {
         if(actualBoard->getOwner(x,y) == movePlayer)
         {
            //Verify on all directions
            //first east
            if( (x-1 > 0) && ( actualBoard->getOwner(x-1,y) != movePlayer ) &&
                (actualBoard->getOwner(x-1,y) != NOBODY))
            {
               //maybe can move to east. Verify.
               aux = x-2;
               verified = false;
               while( (aux >= 0) && (!verified))
               {
                  if((actualBoard->getOwner(aux,y) == NOBODY))
                  {
                     //Can Move!
                     insertMove(aux, y, x, y, DIRECTION_EAST);
                     verified = true;
                  }
                  else if(actualBoard->getOwner(aux,y) == movePlayer)
                  {
                     //Can't move
                     verified = true;
                  }
                  //otherwise, continue with enemy pieces
                  aux--;
               }
            }

            //next west
            if( (x+1 < 7) && ( actualBoard->getOwner(x+1,y) != movePlayer ) &&
                (actualBoard->getOwner(x+1,y) != NOBODY))
            {
               //maybe can move to west. Verify.
               aux = x+2;
               verified = false;
               while( (aux <= 7) && (!verified))
               {
                  if((actualBoard->getOwner(aux,y) == NOBODY))
                  {
                     //Can Move!
                     insertMove(aux, y, x, y, DIRECTION_WEST);
                     verified = true;
                  }
                  else if(actualBoard->getOwner(aux,y) == movePlayer)
                  {
                     //Can't move
                     verified = true;
                  }
                  //otherwise, continue with enemy pieces
                  aux++;
               }
            }

            //next south
            if( (y+1 < 7) && ( actualBoard->getOwner(x,y+1) != movePlayer ) &&
                (actualBoard->getOwner(x,y+1) != NOBODY))
            {
               //maybe can move to south. Verify.
               aux = y+2;
               verified = false;
               while( (aux <= 7) && (!verified))
               {
                  if((actualBoard->getOwner(x,aux) == NOBODY))
                  {
                     //Can Move!
                     insertMove(x, aux, x, y, DIRECTION_SOUTH);
                     verified = true;
                  }
                  else if(actualBoard->getOwner(x,aux) == movePlayer)
                  {
                     //Can't move
                     verified = true;
                  }
                  //otherwise, continue with enemy pieces
                  aux++;
               }
            }

            //next north
            if( (y-1 > 0) && ( actualBoard->getOwner(x,y-1) != movePlayer ) &&
                (actualBoard->getOwner(x,y-1) != NOBODY))
            {
               //maybe can move to north. Verify.
               aux = y-2;
               verified = false;
               while( (aux >= 0) && (!verified))
               {
                  if((actualBoard->getOwner(x,aux) == NOBODY))
                  {
                     //Can Move!
                     insertMove(x, aux, x, y, DIRECTION_NORTH);
                     verified = true;
                  }
                  else if(actualBoard->getOwner(x,aux) == movePlayer)
                  {
                     //Can't move
                     verified = true;
                  }
                  //otherwise, continue with enemy pieces
                  aux--;
               }
            }

            //next northeast
            if( (y-1 > 0) && (x-1 > 0) && 
                (actualBoard->getOwner(x-1,y-1) != movePlayer ) &&
                (actualBoard->getOwner(x-1,y-1) != NOBODY))
            {
               //maybe can move to northeast. Verify.
               aux = y-2;
               aux2 = x-2;
               verified = false;
               while( (aux2>=0) && (aux >= 0) && (!verified))
               {
                  if((actualBoard->getOwner(aux2,aux) == NOBODY))
                  {
                     //Can Move!
                     insertMove(aux2, aux, x, y, DIRECTION_NORTHEAST);
                     verified = true;
                  }
                  else if(actualBoard->getOwner(aux2,aux) == movePlayer)
                  {
                     //Can't move
                     verified = true;
                  }
                  //otherwise, continue with enemy pieces
                  aux--;
                  aux2--;
               }
            }

            //next northwest
            if( (y-1 > 0) && (x+1 < 7) && 
                (actualBoard->getOwner(x+1,y-1) != movePlayer ) &&
                (actualBoard->getOwner(x+1,y-1) != NOBODY))
            {
               //maybe can move to northwest. Verify.
               aux = y-2;
               aux2 = x+2;
               verified = false;
               while( (aux2<=7) && (aux >= 0) && (!verified))
               {
                  if((actualBoard->getOwner(aux2,aux) == NOBODY))
                  {
                     //Can Move!
                     insertMove(aux2, aux, x, y, DIRECTION_NORTHWEST);
                     verified = true;
                  }
                  else if(actualBoard->getOwner(aux2,aux) == movePlayer)
                  {
                     //Can't move
                     verified = true;
                  }
                  //otherwise, continue with enemy pieces
                  aux--;
                  aux2++;
               }
            }

            //next southwest
            if( (y+1 < 7) && (x+1 < 7) && 
                (actualBoard->getOwner(x+1,y+1) != movePlayer ) &&
                (actualBoard->getOwner(x+1,y+1) != NOBODY))
            {
               //maybe can move to southwest. Verify.
               aux = y+2;
               aux2 = x+2;
               verified = false;
               while( (aux2<=7) && (aux <= 7) && (!verified))
               {
                  if((actualBoard->getOwner(aux2,aux) == NOBODY))
                  {
                     //Can Move!
                     insertMove(aux2, aux, x, y, DIRECTION_SOUTHWEST);
                     verified = true;
                  }
                  else if(actualBoard->getOwner(aux2,aux) == movePlayer)
                  {
                     //Can't move
                     verified = true;
                  }
                  //otherwise, continue with enemy pieces
                  aux++;
                  aux2++;
               }
            }

            //next southeast
            if( (y+1 < 7) && (x-1 > 0) && 
                (actualBoard->getOwner(x-1,y+1) != movePlayer ) &&
                (actualBoard->getOwner(x-1,y+1) != NOBODY))
            {
               //maybe can move to southeast. Verify.
               aux = y+2;
               aux2 = x-2;
               verified = false;
               while( (aux2 >= 0) && (aux <= 7) && (!verified))
               {
                  if((actualBoard->getOwner(aux2,aux) == NOBODY))
                  {
                     //Can Move!
                     insertMove(aux2, aux, x, y, DIRECTION_SOUTHEAST);
                     verified = true;
                  }
                  else if(actualBoard->getOwner(aux2,aux) == movePlayer)
                  {
                     //Can't move
                     verified = true;
                  }
                  //otherwise, continue with enemy pieces
                  aux++;
                  aux2--;
               }
            }

            
         }
      }
   }
}


void avaibleMovesList::doMove(int x, int y)
{
   avaibleMove* move = getDestiny(x,y);
   if(move != NULL)
   {
      move->doMove(movePlayer, *actualBoard);
   }
   else
   {
      printf("Error: Move invalid!\n");
   }
}

void avaibleMovesList::undoMove(int x, int y)
{
   avaibleMove* move = getDestiny(x,y);
   if(move != NULL)
   {
      move->undoMove(movePlayer, *actualBoard);
   }
   else
   {
      printf("Error: Move invalid!\n");
   }
}

void avaibleMovesList::getTotals(int& redTotals, int& greenTotals)
{
   actualBoard->calculateTotals();
   redTotals = actualBoard->getTotalRed();
   greenTotals = actualBoard->getTotalGreen();
}

board* avaibleMovesList::getInternalBoard()
{
   return(actualBoard);
}

avaibleMove* avaibleMovesList::getFirst()
{
   return(first);
}

