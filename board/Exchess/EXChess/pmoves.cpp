/* Piece moves */

#include "chess.h"
#include "define.h"
#include "const.h"
#include "funct.h"

extern unsigned long history[64][64];           // history table
extern move hmove;                              // hash move

/* Add move to move list */
// Function to add move to move list
// Move is scored for alpha-beta algorithm
void add_move(position *p, int fsq, int tsq, move_list *list, char type)
{
  int i = list->count;                 // move list index

  // add move to list
  list->mv[i].m.b.from = fsq;
  list->mv[i].m.b.to = tsq;
  list->mv[i].m.b.type = type;
  list->mv[i].m.b.promote = 0;

  // score move ....
  // if capture, use most valuable victum, least valuable attacker
  // with a 10,000,000 bonus to assure that capture moves get put
  // ahead of non-captures
  if(type&1) {
    list->mv[i].score = 10000000+10*value[p->sq[tsq].type]
                                 - value[p->sq[fsq].type];
  }
  else if(type&4) {                 // else if en passant
    list->mv[i].score = 10000900;
  } else {                          // else any other move, use centrality
    list->mv[i].score = 105 - (2*FILE(tsq)-7)*(2*FILE(tsq)-7) 
                            - (2*RANK(tsq)-7)*(2*RANK(tsq)-7);
    list->mv[i].score = list->mv[i].score>>4;
    // give it a history score
    list->mv[i].score += history[fsq][tsq]*10;
  }

  // if it is a hash_move, score it first
  if(list->mv[i].m.t == hmove.t) list->mv[i].score += 50000000;

  list->count++;                       // increment list count

  // is it a promotion move? if so, generate all types of promotions
  if((tsq > 55 || tsq < 8) && p->sq[fsq].type == PAWN)
   {
     list->mv[i].m.b.type |= PROMOTE; list->mv[i].m.b.promote = QUEEN;
     list->mv[i].score = 20000000;
     list->mv[list->count] = list->mv[i];
     list->mv[list->count].m.b.promote = ROOK;
     list->mv[list->count].score = 10000050; list->count++;
     list->mv[list->count] = list->mv[i];
     list->mv[list->count].m.b.promote = BISHOP;
     list->mv[list->count].score = 10000040; list->count++;
     list->mv[list->count] = list->mv[i];
     list->mv[list->count].m.b.promote = KNIGHT;
     list->mv[list->count].score = 10000030; list->count++;
   }
}

/*------------------------------- Bishop Moves --------------------------*/
void bishop_moves(position *p, move_list *list, int sq)
{
  int mm, nn, ii, self, tsq;

  mm = FILE(sq); nn = RANK(sq);
  self = p->wtm;

  ii = 1;
  while (mm + ii <= 7 && nn + ii <= 7)
  {
   tsq = SQR((mm+ii),(nn+ii));
   if (!p->sq[tsq].type)
   { add_move(p, sq, tsq, list, 0); }
   else if (p->sq[tsq].side != self)
   { add_move(p, sq, tsq, list, 1); break; }
   else break;
   ii++;
  }

  ii = 1;
  while (mm - ii >= 0 && nn + ii <= 7)
  {
   tsq = SQR((mm-ii),(nn+ii));
   if (!p->sq[tsq].type)
   { add_move(p, sq, tsq, list, 0); }
   else if (p->sq[tsq].side != self)
   { add_move(p, sq, tsq, list, 1); break; }
   else break;
   ii++;
  }

  ii = 1;
  while(mm + ii <= 7 && nn - ii >= 0)
  {
   tsq = SQR((mm+ii),(nn-ii));
   if (!p->sq[tsq].type)
   { add_move(p, sq, tsq, list, 0); }
   else if (p->sq[tsq].side != self)
   { add_move(p, sq, tsq, list, 1); break; }
   else break;
   ii++;
  }

  ii = 1;
  while (mm - ii >= 0 && nn - ii >= 0)
  {
   tsq = SQR((mm-ii),(nn-ii));
   if (!p->sq[tsq].type)
   { add_move(p, sq, tsq, list, 0); }
   else if (p->sq[tsq].side != self)
   { add_move(p, sq, tsq, list, 1); break; }
   else break;
   ii++;
  }

}

/*--------------------------- Rook Moves ---------------------------*/

void rook_moves(position *p, move_list *list, int sq)
{
  int mm, nn, ii, self, tsq;

  mm = FILE(sq); nn = RANK(sq);
  self = p->wtm;

  ii = 1;
  while (mm + ii <= 7)
  {
   tsq = SQR((mm+ii),nn);
   if (!p->sq[tsq].type)
   { add_move(p, sq, tsq, list, 0); }
   else if (p->sq[tsq].side != self)
   { add_move(p, sq, tsq, list, 1); break; }
   else break;
   ii++;
  }

  ii = 1;
  while (mm - ii >= 0)
  {
   tsq = SQR((mm-ii),nn);
   if (!p->sq[tsq].type)
   { add_move(p, sq, tsq, list, 0); }
   else if (p->sq[tsq].side != self)
   { add_move(p, sq, tsq, list, 1); break; }
   else break;
   ii++;
  }

  ii = 1;
  while(nn - ii >= 0)
  {
   tsq = SQR(mm,(nn-ii));
   if (!p->sq[tsq].type)
   { add_move(p, sq, tsq, list, 0); }
   else if (p->sq[tsq].side != self)
   { add_move(p, sq, tsq, list, 1); break; }
   else break;
   ii++;
  }

  ii = 1;
  while (nn + ii <= 7)
  {
   tsq = SQR(mm,(nn+ii));
   if (!p->sq[tsq].type)
   { add_move(p, sq, tsq, list, 0); }
   else if (p->sq[tsq].side != self)
   { add_move(p, sq, tsq, list, 1); break; }
   else break;
   ii++;
  }

}

/*--------------------------- Knight Moves ----------------------------*/
void knight_moves(position *p, move_list *list, int sq)
{
  int self = p->wtm;
  int tsq;

  if(FILE(sq) < 6 && RANK(sq) < 7) {
   tsq = sq + 10;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) < 6 && RANK(sq)) {
   tsq = sq - 6;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) > 1 && RANK(sq) < 7) {
   tsq = sq + 6;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) > 1 && RANK(sq)) {
   tsq = sq - 10;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) < 7 && RANK(sq) < 6) {
   tsq = sq + 17;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) && RANK(sq) < 6) {
   tsq = sq + 15;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) < 7 && RANK(sq) > 1) {
   tsq = sq - 15;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) && RANK(sq) > 1) {
   tsq = sq - 17;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }

}

/*--------------------------- King Moves ----------------------------*/
void king_moves(position *p, move_list *list, int sq)
{
  int self = p->wtm;
  int tsq;

  if(FILE(sq) && RANK(sq) < 7) {
   tsq = sq + 7;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(RANK(sq) < 7) {
   tsq = sq + 8;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) < 7 && RANK(sq) < 7) {
   tsq = sq + 9;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq)) {
   tsq = sq - 1;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) < 7) {
   tsq = sq + 1;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) < 7 && RANK(sq)) {
   tsq = sq - 7;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(RANK(sq)) {
   tsq = sq - 8;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }
  if(FILE(sq) && RANK(sq)) {
   tsq = sq - 9;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_move(p, sq, tsq, list, 1);
     else add_move(p, sq, tsq, list, 0);
    }
  }

  // genrating castling moves ...
  if(p->wtm) {
     if (p->castle&1) add_move(p, 4, 6, list, 2);
     if (p->castle&2) add_move(p, 4, 2, list, 2);
  } else {
     if (p->castle&4) add_move(p, 60, 62, list, 2);
     if (p->castle&8) add_move(p, 60, 58, list, 2);
  }
}

/*------------------------ Pawn Moves ------------------------------*/
void pawn_moves(position *p, move_list *list, int sq)
{
  int self = p->wtm;

  if(p->wtm) {                        // if it is white's pawn
   if(!p->sq[sq+8].type) {
     add_move(p, sq, sq+8, list, 16);
     if(RANK(sq) == 1) {
       if(!p->sq[sq+16].type) { add_move(p, sq, sq+16, list, 8|16); }
      }
   }
   if(FILE(sq)) {
    if (p->sq[sq+7].type && p->sq[sq+7].side != self)
      { add_move(p, sq, sq+7, list, (1|PAWN_PUSH)); }
    else if((sq+7) == p->ep && p->ep)
      { add_move(p, sq, sq+7, list, (4|1|PAWN_PUSH)); }
   }
   if(FILE(sq) < 7) {
    if (p->sq[sq+9].type && p->sq[sq+9].side != self)
      { add_move(p, sq, sq+9, list, (1|PAWN_PUSH)); }
    else if((sq+9) == p->ep && p->ep)
      { add_move(p, sq, sq+9, list, (4|1|PAWN_PUSH)); }
   }
  } else {                           // or if it is black's pawn
   if(!p->sq[sq-8].type) {
     add_move(p, sq, sq-8, list, 16);
     if(RANK(sq) == 6) {
       if(!p->sq[sq-16].type) { add_move(p, sq, sq-16, list, 8|16); }
      }
   }
   if(FILE(sq)) {
    if (p->sq[sq-9].type && p->sq[sq-9].side != self)
      { add_move(p, sq, sq-9, list, (1|PAWN_PUSH)); }
    else if((sq-9) == p->ep && p->ep)
      { add_move(p, sq, sq-9, list, (4|1|PAWN_PUSH)); }
   }
   if(FILE(sq) < 7) {
    if (p->sq[sq-7].type && p->sq[sq-7].side != self)
      { add_move(p, sq, sq-7, list, (1|PAWN_PUSH)); }
    else if((sq-7) == p->ep && p->ep)
      { add_move(p, sq, sq-7, list, (4|1|PAWN_PUSH)); }
   }
  }
}
























