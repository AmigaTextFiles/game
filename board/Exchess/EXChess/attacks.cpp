/* Attack functions */

#include "chess.h"
#include "define.h"
#include "funct.h"
#include "const.h"

int knt_attacks(int sq, position *p, int side, int one);
int dia_attacks(int sq, position *p, int side, int one);
int hor_attacks(int sq, position *p, int side, int one);

/*---------------- Driver to calculate Attacks --------------*/
// If the "one" parameter is true, this means we only need
// to find one attack, then exit.  "side" is the side which
// is doing the attacking.
int attacks(int sq, position *p, int side, int one)
{
  int attacks = 0;

  attacks += dia_attacks(sq, p, side, one);
  if(attacks && one) return 1;
  attacks += hor_attacks(sq, p, side, one);
  if(attacks && one) return 1;
  attacks += knt_attacks(sq, p, side, one);

  return attacks;
}

/*----------------- Calculate diagonal attacks ------------------*/

int dia_attacks(int sq, position *p, int side, int one)
{
  int attacks = 0, other = side^1, mm = FILE(sq), nn = RANK(sq), tsq;

  int ii = 1;
  while (mm + ii <= 7 && nn + ii <= 7)
  {
   tsq = SQR((mm+ii),(nn+ii));
   if (p->sq[tsq].side == side)
   {
    if (ii == 1 && ID(p->sq[tsq]) == BPAWN)
    { if(one) return 1; attacks++; }
    else if (ii == 1 && p->sq[tsq].type == KING)
    { if(one) return 1; attacks++; }
    else if (p->sq[tsq].type == QUEEN || p->sq[tsq].type == BISHOP)
    { if(one) return 1; attacks++; }
    break;
   }
   if (p->sq[tsq].side == other) break;
   ii++;
  }

  ii = 1;
  while ((mm - ii) >= 0 && nn + ii <= 7)
  {
   tsq = SQR((mm-ii),(nn+ii));
   if (p->sq[tsq].side == side)
   {
    if (ii == 1 && ID(p->sq[tsq]) == BPAWN)
    { if(one) return 1; attacks++; }
    else if (ii == 1 && p->sq[tsq].type == KING)
    { if(one) return 1; attacks++; }
    else if (p->sq[tsq].type == QUEEN || p->sq[tsq].type == BISHOP)
    { if(one) return 1; attacks++; }
    break;
   }
   if (p->sq[tsq].side == other) break;
   ii++;
  }

  ii = 1;
  while ((mm - ii) >= 0 && (nn - ii) >= 0)
  {
   tsq = SQR((mm-ii),(nn-ii));
   if (p->sq[tsq].side == side)
   {
    if (ii == 1 && ID(p->sq[tsq]) == WPAWN)
    { if(one) return 1; attacks++; }
    else if (ii == 1 && p->sq[tsq].type == KING)
    { if(one) return 1; attacks++; }
    else if (p->sq[tsq].type == QUEEN || p->sq[tsq].type == BISHOP)
    { if(one) return 1; attacks++; }
    break;
   }
   if (p->sq[tsq].side == other) break;
   ii++;
  }

  ii = 1;
  while (mm + ii <= 7 && nn - ii >= 0)
  {
   tsq = SQR((mm+ii),(nn-ii));
   if (p->sq[tsq].side == side)
   {
    if (ii == 1 && ID(p->sq[tsq]) == WPAWN)
    { if(one) return 1; attacks++; }
    else if (ii == 1 && p->sq[tsq].type == KING)
    { if(one) return 1; attacks++; }
    else if (p->sq[tsq].type == QUEEN || p->sq[tsq].type == BISHOP)
    { if(one) return 1; attacks++; }
    break;
   }
   if (p->sq[tsq].side == other) break;
   ii++;
  }


  return attacks;
}

/*----------------- Calculate Horizontal attacks ------------------*/

int hor_attacks(int sq, position *p, int side, int one)
{
  int attacks = 0, other = side^1, mm = FILE(sq), nn = RANK(sq), tsq;

  int ii = 1;
  while (mm + ii <= 7)
  {
   tsq = SQR((mm+ii), nn);
   if (p->sq[tsq].side == side)
   {
    if (ii == 1 && p->sq[tsq].type == KING)
    { if(one) return 1; attacks++; }
    else if (p->sq[tsq].type == QUEEN || p->sq[tsq].type == ROOK)
    { if(one) return 1; attacks++; }
    break;
   }
   if (p->sq[tsq].side == other) break;
   ii++;
  }

  ii = 1;
  while ((mm - ii) >= 0)
  {
   tsq = SQR((mm-ii), nn);
   if (p->sq[tsq].side == side)
   {
    if (ii == 1 && p->sq[tsq].type == KING)
    { if(one) return 1; attacks++; }
    else if (p->sq[tsq].type == QUEEN || p->sq[tsq].type == ROOK)
    { if(one) return 1; attacks++; }
    break;
   }
   if (p->sq[tsq].side == other) break;
   ii++;
  }

  ii = 1;
  while (nn - ii >= 0)
  {
   tsq = SQR((mm),(nn-ii));
   if (p->sq[tsq].side == side)
   {
    if (ii == 1 && p->sq[tsq].type == KING)
    { if(one) return 1; attacks++; }
    else if (p->sq[tsq].type == QUEEN || p->sq[tsq].type == ROOK)
    { if(one) return 1; attacks++; }
    break;
   }
   if (p->sq[tsq].side == other) break;
   ii++;
  }

  ii = 1;
  while (nn + ii <= 7)
  {
   tsq = SQR((mm),(nn+ii));
   if (p->sq[tsq].side == side)
   {
    if (ii == 1 && p->sq[tsq].type == KING)
    { if(one) return 1; attacks++; }
    else if (p->sq[tsq].type == QUEEN || p->sq[tsq].type == ROOK)
    { if(one) return 1; attacks++; }
    break;
   }
   if (p->sq[tsq].side == other) break;
   ii++;
  }


  return attacks;
}

/*------------------------ Knight Attacks Counted -------------------*/
int knt_attacks(int sq, position *p, int side, int one)
{
  int self = side^1;
  int tsq, attacks = 0;

  if(FILE(sq) < 6 && RANK(sq) < 7) {
   tsq = sq + 10;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type == KNIGHT) { if(one) return 1; attacks++; }
    }
  }
  if(FILE(sq) < 6 && RANK(sq)) {
   tsq = sq - 6;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type == KNIGHT) { if(one) return 1; attacks++; }
    }
  }
  if(FILE(sq) > 1 && RANK(sq) < 7) {
   tsq = sq + 6;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type == KNIGHT) { if(one) return 1; attacks++; }
    }
  }
  if(FILE(sq) > 1 && RANK(sq)) {
   tsq = sq - 10;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type == KNIGHT) { if(one) return 1; attacks++; }
    }
  }
  if(FILE(sq) < 7 && RANK(sq) < 6) {
   tsq = sq + 17;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type == KNIGHT) { if(one) return 1; attacks++; }
    }
  }
  if(FILE(sq) && RANK(sq) < 6) {
   tsq = sq + 15;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type == KNIGHT) { if(one) return 1; attacks++; }
    }
  }
  if(FILE(sq) < 7 && RANK(sq) > 1) {
   tsq = sq - 15;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type == KNIGHT) { if(one) return 1; attacks++; }
    }
  }
  if(FILE(sq) && RANK(sq) > 1) {
   tsq = sq - 17;
   if(p->sq[tsq].side != self) {
     if(p->sq[tsq].type == KNIGHT) { if(one) return 1; attacks++; }
    }
  }
 
 return attacks;
}

