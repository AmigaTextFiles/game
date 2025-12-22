#include <stdio.h>
#include <string.h>
#include "common.h"

void TTPut (int side, int depth, int ply, int alpha, int beta, 
	    int score, int move)
/****************************************************************************
 *
 *  Uses a two-tier depth-based transposition table.  The criteria for 
 *  replacement is as follows.
 *  1.  The first element is replaced whenever we have a position with
 *      at least the same depth. In that case the element is moved to
 *      the second slot.
 *  2.  The second slot is otherwise always replaced.
 *  Problem may be that the first elements eventually get filled with
 *  outdated entries. Might add an age counter later.
 *  The & ~1 is a trick to clear the last bit making the offset even. 
 *
 ****************************************************************************/
{
   HashSlot *t;

   depth = depth/DEPTH;
   t = HashTab[side] + ((HashKey & TTHashMask) & ~1); 
   if (depth < t->depth)
      t++;
   else if (t->flag)
      *(t+1) = *t;

   t->move = move;
   t->key = HashKey;
   t->depth = depth;
   if (t->depth == 0)
      t->flag = QUIESCENT;
   else if (score >= beta)
      t->flag = LOWERBOUND;         
   else if (score <= alpha)
      t->flag = UPPERBOUND;
   else  
      t->flag = EXACTSCORE;

   if (MATESCORE(score))
      t->score = score + ( score > 0 ? ply : -ply);
   else
      t->score = score;
}


int TTGet (int side, int depth, int ply, 
	       int *score, int *move)
/*****************************************************************************
 *
 *  Probe the transposition table.  There are 2 entries to be looked at as
 *  we are using a 2-tier transposition table.
 *
 *****************************************************************************/
{
   HashSlot *t;

   t = HashTab[side] + ((HashKey & TTHashMask) & ~1);  
   if (HashKey != t->key && HashKey != (++t)->key)
      return (0);

   depth = depth/DEPTH;
   *move = t->move;
   *score = t->score;
   if (t->depth == 0)
      return (QUIESCENT);
   if (t->depth < depth && !MATESCORE (t->score))
      return (POORDRAFT);
   if (MATESCORE(*score))
      *score -= (*score > 0 ? ply : -ply);
   return (t->flag);
}


int TTGetPV (int side, int ply, int score, int *move)
/*****************************************************************************
 *
 *  Probe the transposition table.  There are 2 entries to be looked at as
 *  we are using a 2-tier transposition table.  This routine merely wants to
 *  get the PV from the hash, nothing else.
 *
 *****************************************************************************/
{
   HashSlot *t;
   int s;

   t = HashTab[side] + ((HashKey & TTHashMask) & ~1);  
   s = t->score;
   if (MATESCORE(s))
      s -= (s > 0 ? ply : -ply);
   if (HashKey == t->key && ((ply & 1 && score == s)||(!(ply & 1) && score == -s)))
   {
      *move = t->move;
      return (1);
   }
   t++;
   s = t->score;
   if (MATESCORE(s))
      s -= (s > 0 ? ply : -ply);
   if (HashKey == t->key && ((ply & 1 && score == s)||(!(ply & 1) && score == -s)))
   {
      *move = t->move;
      return (1);
   }
   return (0); 
}


void TTClear (void)
/****************************************************************************
 *   
 *  Zero out the transposition table.
 *
 ****************************************************************************/
{
   memset (HashTab[white], 0, HashSize * sizeof (HashSlot));
   memset (HashTab[black], 0, HashSize * sizeof (HashSlot));
}


void PTClear (void)
/****************************************************************************
 *   
 *  Zero out the pawn transposition table.
 *
 ****************************************************************************/
{
   memset (PawnTab[white], 0, PAWNSLOTS * sizeof (PawnSlot));
   memset (PawnTab[black], 0, PAWNSLOTS * sizeof (PawnSlot));
}
