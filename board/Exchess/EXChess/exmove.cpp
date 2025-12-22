/* Execute move function */

#include "chess.h"
#include "define.h"
#include "const.h"
#include "funct.h"
#include "hash.h"
#include "iostream.h"

/* Hash code variables */
extern hash_rec *hash_table;    // pointer to hash_table
extern pawn_rec *pawn_table;    // pointer to pawn_table
extern h_code wtm, btm, hval[13][64];
extern h_code castle_code[16], ep_code[64];

int check_table[64][64];
int rook_check_table[64][64];
int bishop_check_table[64][64];
int knight_check_table[64][64];

int simple_check(position *p, int side, int move_sq);
int knt_attacks(int sq, position *p, int side, int one);
int dia_attacks(int sq, position *p, int side, int one);
int hor_attacks(int sq, position *p, int side, int one);

// Function to execute the move.
// If the move is legal, the function returns a 1, otherwise 0.
// Note that the move is made, regardless - so proper precautions
// need to be taken, if the move might need to be undone
int exec_move(position *p, move emove, int ply)
{
  // if this is a castle, check that it is legal then
  // move the rook, the king move is given below
  if(emove.b.type&2) {
       if(p->check) return 0;
       switch(emove.b.to) {
           case 6:
              if(p->sq[5].type || p->sq[6].type ||
                  attacks(5,p,p->wtm^1,1))
                { return 0; }
              p->sq[5] = p->sq[7];
              p->sq[7] = empty;
              p->hcode = or(hval[WROOK][5], or(p->hcode, hval[WROOK][7]));
              p->has_castled[1] = 1;
              break;
           case 2:
              if(p->sq[1].type || p->sq[2].type || p->sq[3].type ||
                  attacks(3,p,p->wtm^1,1))
                { return 0; }
              p->sq[3] = p->sq[0];
              p->sq[0] = empty;
              p->hcode = or(hval[WROOK][3], or(p->hcode, hval[WROOK][0]));
              p->has_castled[1] = 1;
              break;
           case 62:
              if(p->sq[61].type || p->sq[62].type ||
                  attacks(61,p,p->wtm^1,1))
                { return 0; }
              p->sq[61] = p->sq[63];
              p->sq[63] = empty;
              p->hcode = or(hval[BROOK][61], or(p->hcode, hval[BROOK][63]));
              p->has_castled[0] = 1;
              break;
           case 58:
              if(p->sq[57].type || p->sq[58].type || p->sq[59].type ||
                  attacks(59,p,p->wtm^1,1))
                { return 0; }
              p->sq[59] = p->sq[56];
              p->sq[56] = empty;
              p->hcode = or(hval[BROOK][59], or(p->hcode, hval[BROOK][56]));
              p->has_castled[0] = 1;
              break;
           }
  }

  // simple sanity checks on the move....
  if(p->sq[emove.b.from].side != p->wtm || p->sq[emove.b.to].side == p->wtm)
   return 0; 

  // make the move - updating hash code as well
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.to])][emove.b.to]);
  p->material += value[p->sq[emove.b.to].type];
  if(p->sq[emove.b.to].type > PAWN) p->pieces[p->wtm^1]--;
  p->sq[emove.b.to] = p->sq[emove.b.from];
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.from])][emove.b.from]);
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.from])][emove.b.to]);
  p->sq[emove.b.from] = empty;

  // if this moved the king, adjust king position
  if(p->sq[emove.b.to].type == KING)
    p->kingpos[p->wtm] = emove.b.to;

  // if move is en-passant, finish it
  if(emove.b.type&EP) {
    if(p->wtm) {
      p->sq[emove.b.to-8] = empty;
      p->hcode = or(p->hcode, hval[BPAWN][emove.b.to-8]);
    } else {
      p->sq[emove.b.to+8] = empty;
      p->hcode = or(p->hcode, hval[WPAWN][emove.b.to+8]);
    }
    p->material += 100;
  }

  // if we are in check, move isn't legal
  // return 0
  if(p->check || emove.b.type&EP || p->sq[emove.b.to].type == KING)
  {
    if(check(p, p->wtm)) return 0;
  } else if(check_table[emove.b.from][p->kingpos[p->wtm]]) {
    if(simple_check(p, p->wtm, emove.b.from)) return 0;
  }

  // if the move is a promotion, promote it
  if(emove.b.type&PROMOTE) {
    p->sq[emove.b.to].type = emove.b.promote;
    p->material += value[emove.b.promote] - 100;
    if(p->wtm) {
      p->hcode = or(p->hcode, hval[WPAWN][emove.b.to]);
    } else {
      p->hcode = or(p->hcode, hval[BPAWN][emove.b.to]);
    }
    p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.to])][emove.b.to]);
    p->pieces[p->wtm]++;
  }

  // update position characteristics
  p->wtm = p->wtm^1;
  p->material = -p->material;
  p->hcode = or(wtm, or(p->hcode, btm));

  // undo hash code for en-passant and castling status
  p->hcode = or(castle_code[p->castle], or(p->hcode, ep_code[p->ep]));

  // if move is a pawn push 2 spaces, set en passant flag
  if(emove.b.type&PAWN_PUSH2)
   { p->ep = (emove.b.from+emove.b.to)/2; } else { p->ep = 0; }
  // if move is not a capture or a pawn move, increase fifty count
  if(emove.b.type&1 || emove.b.type&8 || emove.b.type&16)
   { p->fifty = 0; } else { p->fifty++; }
  // update castling status
  p->castle = p->castle&castle_mask[emove.b.from];
  p->castle = p->castle&castle_mask[emove.b.to];
  p->last = emove;

  // update hash code for en-passant and castling status
  p->hcode = or(castle_code[p->castle], or(p->hcode, ep_code[p->ep]));

  int ptype = p->sq[emove.b.to].type; p->check = 0;
  int ksq = p->kingpos[p->wtm];

  // check whether other side is placed in check
  if(((ptype == BISHOP || ptype == QUEEN)
      && bishop_check_table[emove.b.to][ksq])
     || ((ptype == ROOK || ptype == QUEEN)
         && rook_check_table[emove.b.to][ksq]))
    p->check = simple_check(p, p->wtm, emove.b.to);
  if(ptype == PAWN && bishop_check_table[emove.b.to][ksq])
    if(p->wtm && (emove.b.to == ksq+9 || emove.b.to == ksq+7))
      p->check = 1;
    else if(p->wtm^1 && (emove.b.to == ksq-9 || emove.b.to == ksq-7))
      p->check = 1;
  if(check_table[emove.b.from][ksq] && p->check^1)
    p->check = simple_check(p, p->wtm, emove.b.from);
  if(emove.b.type&EP && p->check^1)
    p->check = check(p, p->wtm);
  if(emove.b.type&CASTLE && p->check^1)
    p->check = hor_attacks(ksq, p, p->wtm^1, 1);
  if(ptype == KNIGHT && knight_check_table[emove.b.to][ksq]
      && p->check^1) p->check = 1;

  return 1;
}

/* Function to do a simple look to see if we are in check */
int simple_check(position *p, int side, int move_sq)
{
  int ksq = p->kingpos[side];  // king-square

  if(rook_check_table[move_sq][ksq])
    return hor_attacks(ksq, p, side^1, 1);
  else 
    return dia_attacks(ksq, p, side^1, 1);
}


/* Function to generate a check table */

void gen_check_table()
{

  int i, j;
  for(i = 0; i < 64; i++) {
   for(j = 0; j < 64; j++) {
     if(FILE(i)==FILE(j) || RANK(i)==RANK(j)) {
      rook_check_table[i][j] = 1;
      check_table[i][j] = 1;
     } else { 
      rook_check_table[i][j] = 0;
      check_table[i][j] = 0;
     }
     bishop_check_table[i][j] = 0;
     knight_check_table[i][j] = 0;
   }
  }

  for(i = 0; i < 64; i++) {
    j = i; while(RANK(j) && FILE(j))
            { j -= 9; bishop_check_table[i][j] = 1; check_table[i][j] = 1; }
    j = i; while(RANK(j) && FILE(j) < 7)
            { j -= 7; bishop_check_table[i][j] = 1; check_table[i][j] = 1; }
    j = i; while(RANK(j) < 7 && FILE(j))
            { j += 7; bishop_check_table[i][j] = 1; check_table[i][j] = 1; }
    j = i; while(RANK(j) < 7 && FILE(j) < 7)
            { j += 9; bishop_check_table[i][j] = 1; check_table[i][j] = 1; }
    if(FILE(i) < 6 && RANK(i) < 7) { knight_check_table[i][i+10] = 1; }
    if(FILE(i) < 6 && RANK(i)) { knight_check_table[i][i-6] = 1; }
    if(FILE(i) > 1 && RANK(i) < 7) { knight_check_table[i][i+6] = 1; }
    if(FILE(i) > 1 && RANK(i)) { knight_check_table[i][i-10] = 1; }
    if(FILE(i) < 7 && RANK(i) < 6) { knight_check_table[i][i+17] = 1; }
    if(FILE(i) && RANK(i) < 6) { knight_check_table[i][i+15] = 1; }
    if(FILE(i) < 7 && RANK(i) > 1) { knight_check_table[i][i-15] = 1; }
    if(FILE(i) && RANK(i) > 1) { knight_check_table[i][i-17] = 1; }
  }

}

/* Failed experiment on using an exec-move function with a undo-move
   function.  I am keeping the code here.  It goes with the file
   search2.c++.  The exec-move function above should be commented
   out if the functions below are used.

// undo information
int ep[MAXD], fifty[MAXD], castle[MAXD], smove[MAXD];
square sqr[MAXD];

// Function to execute the move.
// If the move is legal, the function returns a 1, otherwise 0.
// Note that the move is made, regardless - so proper precautions
// need to be taken, if the move might need to be undone
int exec_move(position *p, move emove, int ply)
{
  // if this is a castle, check that it is legal then
  // move the rook, the king move is given below
  if(emove.b.type&2) {
       switch(emove.b.to) {
           case 6:
              if(p->sq[5].type || p->sq[6].type ||
                  attacks(5,p,p->wtm^1,1) || attacks(4,p,p->wtm^1,1))
                { return 0; }
              p->sq[5] = p->sq[7];
              p->sq[7] = empty;
              p->hcode = or(hval[WROOK][5], or(p->hcode, hval[WROOK][7]));
              p->has_castled[1] = 1;
              break;
           case 2:
              if(p->sq[1].type || p->sq[2].type || p->sq[3].type ||
                  attacks(3,p,p->wtm^1,1) || attacks(4,p,p->wtm^1,1))
                { return 0; }
              p->sq[3] = p->sq[0];
              p->sq[0] = empty;
              p->hcode = or(hval[WROOK][3], or(p->hcode, hval[WROOK][0]));
              p->has_castled[1] = 1;
              break;
           case 62:
              if(p->sq[61].type || p->sq[62].type ||
                  attacks(61,p,p->wtm^1,1) || attacks(60,p,p->wtm^1,1))
                { return 0; }
              p->sq[61] = p->sq[63];
              p->sq[63] = empty;
              p->hcode = or(hval[BROOK][61], or(p->hcode, hval[BROOK][63]));
              p->has_castled[0] = 1;
              break;
           case 58:
              if(p->sq[57].type || p->sq[58].type || p->sq[59].type ||
                  attacks(59,p,p->wtm^1,1) || attacks(60,p,p->wtm^1,1))
                { return 0; }
              p->sq[59] = p->sq[56];
              p->sq[56] = empty;
              p->hcode = or(hval[BROOK][59], or(p->hcode, hval[BROOK][56]));
              p->has_castled[0] = 1;
              break;
           }
  }

  // make the move - updateing hash code as well
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.to])][emove.b.to]);
  sqr[ply] = p->sq[emove.b.to];
  p->sq[emove.b.to] = p->sq[emove.b.from];
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.from])][emove.b.from]);
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.from])][emove.b.to]);
  p->sq[emove.b.from] = empty;

  // if move is en-passant, finish it
  if(emove.b.type&4) {
    if(p->wtm) {
      p->sq[emove.b.to-8] = empty;
      p->hcode = or(p->hcode, hval[BPAWN][emove.b.to-8]);
    } else {
      p->sq[emove.b.to+8] = empty;
      p->hcode = or(p->hcode, hval[WPAWN][emove.b.to+8]);
    }
  }

  // if the move is a promotion, promote it
  if(emove.b.type&32) {
    p->sq[emove.b.to].type = emove.b.promote;
    if(p->wtm) {
      p->hcode = or(p->hcode, hval[WPAWN][emove.b.to]);
    } else {
      p->hcode = or(p->hcode, hval[BPAWN][emove.b.to]);
    }
    p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.to])][emove.b.to]);
  }

  // update position characteristics
  p->wtm = p->wtm^1;
  p->hcode = or(wtm, or(p->hcode, btm));

  // restore flags
  ep[ply] = p->ep;
  fifty[ply] = p->fifty;
  castle[ply] = p->castle;
  smove[ply] = p->last.t;

  // if move is a pawn push 2 spaces, set en passant flag
  if(emove.b.type&8)
   { p->ep = (emove.b.from+emove.b.to)/2; } else { p->ep = 0; }
  // if move is not a capture or a pawn move, increase fifty count
  if(emove.b.type&1 || emove.b.type&8 || emove.b.type&16)
   { p->fifty = 0; } else { p->fifty++; }
  // update castling status
  p->castle = p->castle&castle_mask[emove.b.from];
  p->last = emove;

  // if we are in check, move isn't legal
  // undo what we have done and return 0
  if(check(p, p->wtm^1)) {
    undo_move(p, emove, ply);
    return 0;
  }

  return 1;
}


int undo_move(position *p, move emove, int ply)
{
  // update position characteristics
  p->wtm = p->wtm^1;
  p->hcode = or(wtm, or(p->hcode, btm));

  // if this is a castle
  if(emove.b.type&2) {
       switch(emove.b.to) {
           case 6:
              p->sq[7] = p->sq[5];
              p->sq[5] = empty;
              p->hcode = or(hval[WROOK][5], or(p->hcode, hval[WROOK][7]));
              p->has_castled[1] = 0;
              break;
           case 2:
              p->sq[0] = p->sq[3];
              p->sq[3] = empty;
              p->hcode = or(hval[WROOK][3], or(p->hcode, hval[WROOK][0]));
              p->has_castled[1] = 0;
              break;
           case 62:
              p->sq[63] = p->sq[61];
              p->sq[61] = empty;
              p->hcode = or(hval[BROOK][61], or(p->hcode, hval[BROOK][63]));
              p->has_castled[0] = 0;
              break;
           case 58:
              p->sq[56] = p->sq[59];
              p->sq[59] = empty;
              p->hcode = or(hval[BROOK][59], or(p->hcode, hval[BROOK][56]));
              p->has_castled[0] = 0;
              break;
           }
  }

  // unmake the move - updating hash code as well
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.to])][emove.b.to]);
  p->sq[emove.b.from] = p->sq[emove.b.to];
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.from])][emove.b.from]);
  p->sq[emove.b.to] = sqr[ply];
  p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.to])][emove.b.to]);

  // if move was en-passant, undo it
  if(emove.b.type&4) {
    if(p->wtm) {
      p->sq[emove.b.to-8].type = PAWN;
      p->sq[emove.b.to-8].side = BLACK;
      p->hcode = or(p->hcode, hval[BPAWN][emove.b.to-8]);
    } else {
      p->sq[emove.b.to+8].type = PAWN;
      p->sq[emove.b.to+8].side = WHITE;
      p->hcode = or(p->hcode, hval[WPAWN][emove.b.to+8]);
    }
  }

  // if the move was a promotion, un-promote it
  if(emove.b.type&32) {
    if(p->wtm) {
      p->hcode = or(p->hcode, hval[WPAWN][emove.b.from]);
    } else {
      p->hcode = or(p->hcode, hval[BPAWN][emove.b.from]);
    }
    p->hcode = or(p->hcode, hval[ID(p->sq[emove.b.from])][emove.b.from]);
    p->sq[emove.b.from].type = PAWN;
  }

  // restore flags
  p->ep = ep[ply];
  p->fifty = fifty[ply];
  p->castle = castle[ply];
  p->last.t = smove[ply];

  return 1;
}

*/
