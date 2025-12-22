/* Piece captures only */

#include "chess.h"
#include "define.h"
#include "const.h"
#include "funct.h"

/* Add capture function */
// Function to add a capture to the capture list
// The move is also scored for the alpha-beta search
// fsq = from square,  tsq = to square
void add_capt(position *p, int fsq, int tsq, move_list *list, char type)
{
  int i = list->count;      // index of move list

  // add move to list...
  list->mv[i].m.b.from = fsq;
  list->mv[i].m.b.to = tsq;
  list->mv[i].m.b.type = type;
  list->mv[i].m.b.promote = 0;

  // score move with the expected gain ....
  list->mv[i].score = value[p->sq[tsq].type]; //-value[p->sq[fsq].type]/10;

  // if the move also promotes...
  if((tsq > 55 || tsq < 8) && p->sq[fsq].type == PAWN)
  {
    list->mv[i].m.b.type |= PROMOTE; list->mv[i].m.b.promote = QUEEN;
    list->mv[i].score += 1000;
  }

  // if the square is defended, subtract value of moved piece
  if(attacks(tsq, p, p->wtm^1, 1))
   list->mv[i].score -= value[p->sq[fsq].type];

  list->count++;           // increase list count
}

/*---------------------------- Bishop Captures --------------------------*/
void bishop_capts(position *p, move_list *list, int sq)
{
  int mm, nn, ii, self;
  int tsq;                          // to square

  mm = FILE(sq); nn = RANK(sq);     // set rank and file of bishop
  self = p->wtm;                    // set side on move

  ii = 1;
  while (mm + ii <= 7 && nn + ii <= 7)
  {
   tsq = SQR((mm+ii),(nn+ii));                // set to square
   if (!p->sq[tsq].type) { ii++; }            // if empty, move on
   else if (p->sq[tsq].side != self)          // else if other side,
   { add_capt(p, sq, tsq, list, 1); break; }  // add to capture list
   else break;                                // break if our piece
  }

  ii = 1;
  while (mm - ii >= 0 && nn + ii <= 7)
  {
   tsq = SQR((mm-ii),(nn+ii));
   if (!p->sq[tsq].type) { ii++; }
   else if (p->sq[tsq].side != self)
   { add_capt(p, sq, tsq, list, 1); break; }
   else break;
  }

  ii = 1;
  while(mm + ii <= 7 && nn - ii >= 0)
  {
   tsq = SQR((mm+ii),(nn-ii));
   if (!p->sq[tsq].type) { ii++; }
   else if (p->sq[tsq].side != self)
   { add_capt(p, sq, tsq, list, 1); break; }
   else break;
  }

  ii = 1;
  while (mm - ii >= 0 && nn - ii >= 0)
  {
   tsq = SQR((mm-ii),(nn-ii));
   if (!p->sq[tsq].type) { ii++; }
   else if (p->sq[tsq].side != self)
   { add_capt(p, sq, tsq, list, 1); break; }
   else break;
  }

}

/*--------------------------- Rook Captures ---------------------------*/
void rook_capts(position *p, move_list *list, int sq)
{
  int mm, nn, ii, self;
  int tsq;                              // to square

  mm = FILE(sq); nn = RANK(sq);         // set file and rank of rook
  self = p->wtm;                        // set side to move

  ii = 1;
  while (mm + ii <= 7)
  {
   tsq = SQR((mm+ii),nn);                     // set to square
   if (!p->sq[tsq].type) { ii++; }            // if empty, move on
   else if (p->sq[tsq].side != self)          // else if other side,
   { add_capt(p, sq, tsq, list, 1); break; }  // add to capture list
   else break;                                // else if our side, break
  }

  ii = 1;
  while (mm - ii >= 0)
  {
   tsq = SQR((mm-ii),nn);
   if (!p->sq[tsq].type) { ii++; }
   else if (p->sq[tsq].side != self)
   { add_capt(p, sq, tsq, list, 1); break; }
   else break;
  }

  ii = 1;
  while(nn - ii >= 0)
  {
   tsq = SQR(mm,(nn-ii));
   if (!p->sq[tsq].type) { ii++; }
   else if (p->sq[tsq].side != self)
   { add_capt(p, sq, tsq, list, 1); break; }
   else break;
  }

  ii = 1;
  while (nn + ii <= 7)
  {
   tsq = SQR(mm,(nn+ii));
   if (!p->sq[tsq].type) { ii++; }
   else if (p->sq[tsq].side != self)
   { add_capt(p, sq, tsq, list, 1); break; }
   else break;
  }

}

/*--------------------------- Knight Captures ----------------------------*/
void knight_capts(position *p, move_list *list, int sq)
{
  int self = p->wtm;                         // set side to move
  int tsq;                                   // to square

  if(FILE(sq) < 6 && RANK(sq) < 7) {
   tsq = sq + 10;                                         // set to square
   if(p->sq[tsq].side != self) {                          // if occupied by
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);   // other side, add
    }                                                     // to capture list
  }
  if(FILE(sq) < 6 && RANK(sq)) {
   tsq = sq - 6;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) > 1 && RANK(sq) < 7) {
   tsq = sq + 6;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) > 1 && RANK(sq)) {
   tsq = sq - 10;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) < 7 && RANK(sq) < 6) {
   tsq = sq + 17;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) && RANK(sq) < 6) {
   tsq = sq + 15;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) < 7 && RANK(sq) > 1) {
   tsq = sq - 15;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) && RANK(sq) > 1) {
   tsq = sq - 17;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }

}

/*--------------------------- King Captures ----------------------------*/
void king_capts(position *p, move_list *list, int sq)
{
  int self = p->wtm;                     // set side to move
  int tsq;                               // to square

  if(FILE(sq) && RANK(sq) < 7) {
   tsq = sq + 7;                                         // set to square
   if(p->sq[tsq].side != self) {                         // if occupied by
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);  // other side, add
    }                                                    // to capture list
  }
  if(RANK(sq) < 7) {
   tsq = sq + 8;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) < 7 && RANK(sq) < 7) {
   tsq = sq + 9;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq)) {
   tsq = sq - 1;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) < 7) {
   tsq = sq + 1;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) < 7 && RANK(sq)) {
   tsq = sq - 7;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(RANK(sq)) {
   tsq = sq - 8;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
  if(FILE(sq) && RANK(sq)) {
   tsq = sq - 9;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type) add_capt(p, sq, tsq, list, 1);
    }
  }
}

/*------------------------ Pawn Captures ------------------------------*/
// Not including en passant!
// Do include promotions!
void pawn_capts(position *p, move_list *list, int sq)
{
  int self = p->wtm;                  // set side to move

  if(p->wtm) {                        // if it is white's pawn
   if(FILE(sq)) {
    if (p->sq[sq+7].type && p->sq[sq+7].side != self)
      { add_capt(p, sq, sq+7, list, (PAWN_PUSH|1)); }  
   }
   if(FILE(sq) < 7) {
    if (p->sq[sq+9].type && p->sq[sq+9].side != self)
      { add_capt(p, sq, sq+9, list, (PAWN_PUSH|1)); }
   }
   if(RANK(sq) == 6) {
    if (!p->sq[sq+8].type)
      { add_capt(p, sq, sq+8, list, (PAWN_PUSH|PROMOTE)); }
   }
  } else {                           // or if it is black's pawn
   if(FILE(sq)) {
    if (p->sq[sq-9].type && p->sq[sq-9].side != self)
      { add_capt(p, sq, sq-9, list, (PAWN_PUSH|1)); }
   }
   if(FILE(sq) < 7) {
    if (p->sq[sq-7].type && p->sq[sq-7].side != self)
      { add_capt(p, sq, sq-7, list, (PAWN_PUSH|1)); }
   }
   if(RANK(sq) == 1) {
    if (!p->sq[sq-8].type)
      { add_capt(p, sq, sq-8, list, (PAWN_PUSH|PROMOTE)); }
   }
  }
}
























