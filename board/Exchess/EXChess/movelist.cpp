/* Move generator functions */
// These basically loop through all the squares, calling the appropriate
// subroutines to generate moves/captures for the given piece.

#include "chess.h"
#include "define.h"
#include "const.h"
#include "funct.h"

/*------------------------- Semi-legal moves generator ---------------------*/

void legalmoves(position *p, move_list *list)
{
  list->count = 0;

  for(int i=0; i < 64 ; i++)
  {
    if (p->sq[i].side == p->wtm)
     {
      switch (p->sq[i].type)
	    {
        case EMPTY:
               break;
        case PAWN:
	       pawn_moves(p, list, i);
               break;
        case KNIGHT:
	       knight_moves(p, list, i);
	       break;
        case BISHOP:
	       bishop_moves(p, list, i);
	       break;
        case ROOK:
	       rook_moves(p, list, i);
	       break;
        case QUEEN:
	       bishop_moves(p, list, i);
	       rook_moves(p, list, i);
          break;
        case KING:
	       king_moves(p, list, i);
	    }
     }
  }
}

/*------------------------- Semi-legal capture generator ---------------------*/

void captures(position *p, move_list *list)
{
  list->count = 0;

  for(int i=0; i < 64 ; i++)
  {
    if (p->sq[i].side == p->wtm)
     {
      switch (p->sq[i].type)
	    {
        case EMPTY:
          break;
        case PAWN:
          pawn_capts(p, list, i);
          break;
        case KNIGHT:
          knight_capts(p, list, i);
	       break;
        case BISHOP:
          bishop_capts(p, list, i);
	       break;
        case ROOK:
          rook_capts(p, list, i);
	       break;
        case QUEEN:
          bishop_capts(p, list, i);
          rook_capts(p, list, i);
          break;
        case KING:
          king_capts(p, list, i);
	    }
     }
  }

}
