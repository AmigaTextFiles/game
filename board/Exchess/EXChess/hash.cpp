/*
  Functions dealing with the standard hash table and the pawn hash tables.
  The standard hash table is divided into two pieces.  The lower half uses
  a "smart" replace strategy, and the upper half uses an always replace
  strategy.
  The pawn hash is very much like the standard hash - but simpler.  Only
  the hash key and score is stored.  The pawn table is always replace.
*/

#include "chess.h"
#include "define.h"
#include "funct.h"
#include "const.h"
#include "hash.h"

/* hash table variables */
unsigned long TAB_SIZE = 262144, PAWN_SIZE = 65536;  // hash and pawn hash sizes in entries
hash_rec *hash_table;             // pointer to start of hash table
pawn_rec *pawn_table;             // pointer to start of pawn table
h_code wtm, btm, hval[13][64];    // hash code variables
h_code castle_code[16], ep_code[64], stage_code[4];

short h_id = 1;  // hash code id flag for old-current searches

extern int null_hash;  // flag for null move from hash table
extern int max_ply;

/* Function for or'ing two hash codes */
h_code or(h_code A, h_code B)
{
 h_code temp_code;
 temp_code.address = A.address^B.address;
 temp_code.key = A.key^B.key;
 return temp_code;
}

/* Function to set the hash table size */
void set_hash_size(int Mbytes)
{
  unsigned long Tab_entry_size = sizeof(hash_rec);
  unsigned long Pawn_entry_size = sizeof(pawn_rec);
  unsigned long Max_tab_size, Max_pawn_size;

  if(Mbytes >= 8) Max_pawn_size = 2000000/(Pawn_entry_size);
  else Max_pawn_size = Mbytes*1000000/(4*Pawn_entry_size);

  PAWN_SIZE = 2;
  while(2*PAWN_SIZE < Max_pawn_size) { PAWN_SIZE *= 2; }

  Max_tab_size = (Mbytes*1000000 - PAWN_SIZE*Pawn_entry_size)/Tab_entry_size;

  TAB_SIZE = 2;
  while(2*TAB_SIZE < Max_tab_size) { TAB_SIZE *= 2; }

  close_hash();
  open_hash();
}

/* Function with allocates space for the hash tables and generates
   the hash codes */
void open_hash()
{
 start_code();
 hash_table = new hash_rec[TAB_SIZE];
 pawn_table = new pawn_rec[PAWN_SIZE];
}

/* function to close the hash table */
void close_hash()
{
 delete [] hash_table;
 delete [] pawn_table;
}

/* function to stuff a pawn entry into the pawn table */
void put_pawn(h_code h_key, short score, char wfree_pawn, char bfree_pawn)
{
 pawn_rec *p;

 p = pawn_table + (h_key.address&(PAWN_SIZE-1));
 p->key = h_key.key;
 p->score = score;
 p->wfree_pawn = wfree_pawn;
 p->bfree_pawn = bfree_pawn;
}

/* function to stuff a hash entry into the hash table */
void put_hash(h_code h_key, int score, int alpha, int beta,
                            int depth, move hmove, int deep)
{
 hash_rec *h; int flag; int ply = max_ply - depth - 1;

 // is this an upper bound, lower bound, or exact score?
 if (score >= beta) { flag = FLAG_B; score = beta; }
 else if (score <= alpha) { flag = FLAG_A; score = alpha; hmove.t = NOMOVE; }
 else { flag = FLAG_P; }

 // adjust any mate score to be relative to this node.
 if(score >= MATE/2) score += ply;
 else if(score <= -MATE/2) score -= ply;

 // find location in table
 h = hash_table + (h_key.address&(TAB_SIZE/2-1));

 // use "smart" replace strategy if possible
 if ((h->id != h_id) || (h->depth < depth)
     || (h->depth == depth && (flag > h->flag || (flag == h->flag &&
 ((score > h->score && flag==2) || (score < h->score && flag==1) || flag==3)))))
   {
     h->key = h_key.key;
     h->score = score;
     h->flag = (deep > 2) ? flag : -1;
     h->depth = depth;
     h->hmove = hmove;
     h->id = h_id;
   }
 else   // or use always replace in the upper half of table
   {
     h += TAB_SIZE/2;           // move to upper half of table
     h->key = h_key.key;
     h->score = score;
     h->flag = (deep > 1) ? flag : -1;
     h->depth = depth;
     h->hmove = hmove;
     h->id = h_id;
   }
}

/* function to find and return a pawn entry */
int get_pawn(h_code h_key, char *wfree_pawn, char *bfree_pawn)
{
 pawn_rec *p;

 p = pawn_table + (h_key.address&(PAWN_SIZE-1));
 if (p->key != h_key.key) return HASH_MISS;
 (*wfree_pawn) = p->wfree_pawn;
 (*bfree_pawn) = p->bfree_pawn;
 return p->score;
}

/* function to find and return a hash entry */
int get_hash(h_code h_key, int alpha, int beta, int depth,
                           int *hardalpha, int *hardbeta)
{
 hash_rec *h; int ply = max_ply - depth - 1, hscore;

 // find the right location in the table
 h = hash_table + (h_key.address&(TAB_SIZE/2-1));

 // check lower part of table first then upper part
 if (h->key != h_key.key)
  { h += TAB_SIZE/2; if (h->key != h_key.key) return HASH_MISS; }

 // set null-move switch
 if(h->depth >= depth-2 && (h->flag==FLAG_A || h->flag==FLAG_P)
        && h->score < beta) null_hash = 0;

 hscore = h->score;

 // Don't trust draw scores
 if(hscore == 0) return HASH_MISS;

 // adjust any mate score to be relative to this node.
 if(hscore >= MATE/2) hscore -= ply;
 else if(hscore <= -MATE/2) hscore += ply;

 // return hash score if possible, otherwise adjust hardalpha and hardbeta
 if (h->depth < depth) return HASH_MISS; 
 if (h->flag==FLAG_A && hscore <= alpha) return hscore;
 if (h->flag==FLAG_A && depth > -1) (*hardbeta) = hscore;
 if (h->flag==FLAG_B && hscore >= beta) return hscore;
 if (h->flag==FLAG_B && depth > -1) (*hardalpha) = hscore;
 if (h->flag==FLAG_P) return hscore;
 return HASH_MISS;
}

/* function to retrieve the hash move from the table */
int get_move(h_code h_key)
{
 hash_rec *h;
 h = hash_table + (h_key.address&(TAB_SIZE/2-1));
 // if the hit was in the upper half of the table, go there
 // check lower part of table first then upper part
 if (h->key != h_key.key)
  { h += TAB_SIZE/2; if (h->key != h_key.key) return NOMOVE; }

 return h->hmove.t;
}

/* generate the hash code for a given position */
// also calculate material score
h_code gen_code(position *p)
{
  h_code temp_rec = { 0, 0 };
  p->material = 0;
  p->pieces[0] = 0;
  p->pieces[1] = 0;

  for(int i = 0; i < 64; i++)
  {
    temp_rec = or(temp_rec, hval[ID(p->sq[i])][i]);
    if(p->sq[i].side == p->wtm) p->material += value[p->sq[i].type];
    else p->material -= value[p->sq[i].type];
    if(p->sq[i].type > PAWN) p->pieces[p->sq[i].side]++;
  }
  if(p->wtm) temp_rec = or(temp_rec, wtm);
  else temp_rec = or(temp_rec, btm);

  temp_rec = or(temp_rec, castle_code[p->castle]);
  temp_rec = or(temp_rec, ep_code[p->ep]);

  return temp_rec;
}

// random number generator
#define IA 16807
#define IM 2147483647
#define AM (1.0/IM)
#define IQ 127773
#define IR 2836
#define NTAB 32
#define NDIV (1+(IM-1)/NTAB)
#define EPS 1.2e-7
#define RNMX (1.0-EPS)

float ran(long *idum)
{
   int j;
   long k;
   static long iy=0;
   static long iv[NTAB];
   float temp;

   if (*idum <= 0 || !iy) {
       if (-(*idum) < 1) *idum=1;
       else *idum = -(*idum);
       for (j=NTAB+7; j>=0;j--) {
           k=(*idum)/IQ;
           *idum=IA*(*idum-k*IQ)-IR*k;
           if (*idum < 0) *idum += IM;
           if (j < NTAB) iv[j] = *idum;
       }
       iy=iv[0];
   }
   k=(*idum)/IQ;
   *idum=IA*(*idum-k*IQ)-IR*k;
   if (*idum < 0) *idum += IM;
   j=iy/NDIV;
   iy =iv[j];
   iv[j] = *idum;
   if ((temp=AM*iy) > RNMX) return RNMX;
   else return temp;
}

/* function to return a random bit */
unsigned long ibit(long *idum)
{
  if (ran(idum) > 0.5) return 1;
  return 0;
}

/* function to generate hash codes for all pieces/positions */
void start_code()
{
  long seed1 = -1712913483;
  int i, j, k;

  for (i = 0; i < 64; i++)
   { hval[0][i].key = 0; hval[0][i].address = 0; }
  for (j = 1; j < 13; j++)
   {
     for (i = 0; i < 64; i++)
      {
       hval[j][i].key = 0;
       hval[j][i].address = 0;
       for(k = 0; k < 32; k++)
        {
         hval[j][i].key = hval[j][i].key | (ibit(&seed1) << k);
         hval[j][i].address = hval[j][i].address | (ibit(&seed1) << k);
        }
      }
   }
   wtm.address = 0; wtm.key = 0;
   btm.address = 0; btm.key = 0;
   for(k = 0; k < 32; k++) {
    wtm.key = wtm.key | (ibit(&seed1) << k);
    wtm.address = wtm.address | (ibit(&seed1) << k);
    btm.key = btm.key | (ibit(&seed1) << k);
    btm.address = btm.address | (ibit(&seed1) << k);
   }

   for(i = 0; i < 16; i++) {
    castle_code[i].key = 0;
    castle_code[i].address = 0;
    for(k = 0; k < 32; k++) {
     castle_code[i].key = castle_code[i].key | (ibit(&seed1) << k);
     castle_code[i].address = castle_code[i].address | (ibit(&seed1) << k);
    }
   }

   for(i = 0; i < 64; i++) {
    ep_code[i].key = 0;
    ep_code[i].address = 0;
    for(k = 0; k < 32; k++) {
     ep_code[i].key = ep_code[i].key | (ibit(&seed1) << k);
     ep_code[i].address = ep_code[i].address | (ibit(&seed1) << k);
    }
   }

   for(i = 0; i < 4; i++) {
    stage_code[i].key = 0;
    stage_code[i].address = 0;
    for(k = 0; k < 32; k++) {
     stage_code[i].key = stage_code[i].key | (ibit(&seed1) << k);
     stage_code[i].address = stage_code[i].address | (ibit(&seed1) << k);
    }
   }


}
