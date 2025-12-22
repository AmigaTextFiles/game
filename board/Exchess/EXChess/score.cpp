/* score.cpp */
#include <math.h>
#include <iostream.h>
#include <fstream.h>
#include <stdlib.h>
#include <string.h>

#include "chess.h"
#include "define.h"
#include "funct.h"
#include "score.h"
#include "hash.h"

#define MAX(x,y) (((x) > (y)) ? (x) : (y) ) 

int stage;  // game stage
int taxi_cab[64][64];
extern h_code wtm, btm, hval[13][64], stage_code[4];
extern unsigned long phash_count;
extern int p_side;

extern char exec_path[100];

int absl(int j)
{
  if (j < 0) return -j;
  else return j;
}

/*------------------------ Initialize Score Routine ---------------------*/
// This routine initializes the piece square tables for the current search.
// Game stage is also determined

void init_score(position *p, int T)
{
  int wpawns = 0, bpawns = 0, wpieces = 0, bpieces = 0;
  int i,j;

  // scan the board and count pieces and find kings
  // setup open file bonus for rooks/queens
  for(j = 0; j < 64; j++) {
     if(p->sq[j].type == 1 && p->sq[j].side == WHITE)
      { wpawns++; }
     if(p->sq[j].type == 1 && p->sq[j].side == BLACK)
      { bpawns++; }
     if(p->sq[j].type > 1  && p->sq[j].side == WHITE)
      { wpieces++; }
     if(p->sq[j].type > 1  && p->sq[j].side == BLACK)
      { bpieces++; }
  }

  // determine game stage
  if((bpawns + wpawns) > 13 && (wpieces+bpieces) > 13) stage = 0;
  else if((bpawns + wpawns > 8 && wpieces+bpieces > 8)) stage = 1;  // 12, 12
  else if(bpawns + wpawns > 6 && (wpieces+bpieces) > 6) stage = 2;
  else stage = 3;

  for(i = 0; i < 64; i++) {
    piece_sq[1][PAWN][i] =
       proto_piece_sq[stage][PAWN][whitef[i]];
    piece_sq[1][KNIGHT][i] =
       proto_piece_sq[stage][KNIGHT][whitef[i]];
    piece_sq[1][BISHOP][i] =
       proto_piece_sq[stage][BISHOP][whitef[i]];
    piece_sq[1][ROOK][i] =
       proto_piece_sq[stage][ROOK][whitef[i]];
    piece_sq[1][QUEEN][i] =
       proto_piece_sq[stage][QUEEN][whitef[i]];
    piece_sq[1][KING][i] =
       proto_piece_sq[stage][KING][whitef[i]];

    piece_sq[0][PAWN][i] =
       proto_piece_sq[stage][PAWN][i];
    piece_sq[0][KNIGHT][i] =
       proto_piece_sq[stage][KNIGHT][i];
    piece_sq[0][BISHOP][i] =
       proto_piece_sq[stage][BISHOP][i];
    piece_sq[0][ROOK][i] =
       proto_piece_sq[stage][ROOK][i];
    piece_sq[0][QUEEN][i] =
       proto_piece_sq[stage][QUEEN][i];
    piece_sq[0][KING][i] =
       proto_piece_sq[stage][KING][i];
  }

}

/*--------------------------- Score position ------------------------*/
// Position is scored from point of view of white to move.  Score is
// currently based on a number of factors: Open files, king proximity,
// good/bad bishops, bishop pairs, pawn structure, king safety, etc....
int score_pos(position *p)
{
   int score = 0, pscore = 0, opawn_count = 0, dpawn_count = 0;
   int opawn[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };          // pawn arrays
   int dpawn[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
   int orook[6] = { 0, 0, 0, 0, 0, 0 }, orook_count = 0;
   int drook[6] = { 0, 0, 0, 0, 0, 0 }, drook_count = 0;
   int olsp = 0, dlsp = 0, odsp = 0, ddsp = 0;  // light and dark sq. pawns
   int olsb = 0, dlsb = 0, odsb = 0, ddsb = 0;  // light and dark sq. bishops
   int file_bonus[8] = { FILE_BONUS, FILE_BONUS, FILE_BONUS, FILE_BONUS,
                         FILE_BONUS, FILE_BONUS, FILE_BONUS, FILE_BONUS };
   int oksq, dksq;   // offensive and defensive king squares
   int i, pi, pj, ri, rj;       // pawn index variables
   char wfree_pawn = 0, bfree_pawn = 0;   // free passed pawns
   h_code pawn_code = stage_code[stage];  // pawn hash code

   if(stage < 2 && p->has_castled[1]) score += HAS_CASTLED;
   if(stage < 2 && p->has_castled[0]) score -= HAS_CASTLED;

   // record king positions
   oksq = p->kingpos[1];
   pawn_code = or(pawn_code, hval[WKING][oksq]);
   dksq = p->kingpos[0];
   pawn_code = or(pawn_code, hval[BKING][dksq]);

// count over board, adding up piece-square tables
// and setting up pawn arrays
   for(i = 0; i < 64; i++) {
     if(p->sq[i].type) {
       if(p->sq[i].side) {
          score += piece_sq[1][p->sq[i].type][i];
          score += king_proximity[stage][p->sq[i].type][taxi_cab[i][dksq]];
          if(p->sq[i].type == PAWN) {
            if(stage > 2)
             score -= king_proximity[stage][PAWN][taxi_cab[i][oksq]];
            opawn[opawn_count] = i; opawn_count++;
            pawn_code = or(pawn_code, hval[WPAWN][i]);
            // is it light square or dark square?
            if((RANK(i)+FILE(i))&1) olsp++; else odsp++;
            if(file_bonus[FILE(i)]) file_bonus[FILE(i)] -= HALF_FILE_BONUS;
          } else if(p->sq[i].type == BISHOP) {
            score -= taxi_cab[i][oksq];
            // is it light square or dark square?
            if((RANK(i)+FILE(i))&1) olsb = 1; else odsb = 1;
            // evaluate bishop trap
            if(i == 48 && ID(p->sq[41]) == BPAWN && ID(p->sq[50]) == BPAWN)
             score -= value[BISHOP] + 100;
            if(i == 55 && ID(p->sq[46]) == BPAWN && ID(p->sq[53]) == BPAWN)
             score -= value[BISHOP] + 100;
          } else if(p->sq[i].type == ROOK || p->sq[i].type == QUEEN) {
            score -= taxi_cab[i][oksq];
            orook[orook_count] = i; orook_count++;
          } else score -= taxi_cab[i][oksq];
       } else {
          score -= piece_sq[0][p->sq[i].type][i];
          score -= king_proximity[stage][p->sq[i].type][taxi_cab[i][oksq]];
          if(p->sq[i].type == PAWN) {
            if(stage > 2)
             score += king_proximity[stage][PAWN][taxi_cab[i][dksq]];
            dpawn[dpawn_count] = i; dpawn_count++;
            pawn_code = or(pawn_code, hval[BPAWN][i]);
            // is it light square or dark square?
            if((RANK(i)+FILE(i))&1) dlsp++; else ddsp++;
            if(file_bonus[FILE(i)]) file_bonus[FILE(i)] -= HALF_FILE_BONUS;
          } else if(p->sq[i].type == BISHOP) {
            score += taxi_cab[i][dksq];
            // is it light square or dark square?
            if((RANK(i)+FILE(i))&1) dlsb = 1; else ddsb = 1;
            // evaluate bishop trap
            if(i == 8 && ID(p->sq[17]) == WPAWN && ID(p->sq[10]) == WPAWN)
             score += value[BISHOP] - 100;
            if(i == 15 && ID(p->sq[22]) == WPAWN && ID(p->sq[13]) == WPAWN)
             score += value[BISHOP] - 100;
          } else if(p->sq[i].type == ROOK || p->sq[i].type == QUEEN) {
            score += taxi_cab[i][dksq];
            drook[drook_count] = i; drook_count++;
          } else score += taxi_cab[i][dksq];
       }
     }
    }

// include material score
   if(p->wtm) score += p->material; else score -= p->material;

// include a tempo score, moving side is assumed to have tempo
// because this is at the end of the quiescent search
//   if(p->wtm) score += 5*(3-stage); else score -= 5*(3-stage);

// Light and Dark square bishop scoring
 // for the offensive side
   if((olsp > odsp) && olsb) score -= BAD_BISHOP*(olsp-odsp);
   else if(odsb) score -= BAD_BISHOP*(odsp-olsp);
 // do the same for the defender
   if((dlsp > ddsp) && dlsb) score += BAD_BISHOP*(dlsp-ddsp);
   else if(ddsb) score += BAD_BISHOP*(ddsp-dlsp);

// Bishop pair bonus
 // if endgame, double the bonus
   if (stage >= 2) {
     if(olsb && odsb) score += 2*BISHOP_PAIR;
     if(dlsb && ddsb) score -= 2*BISHOP_PAIR;
   } else {
     if(olsb && odsb) score += BISHOP_PAIR;
     if(dlsb && ddsb) score -= BISHOP_PAIR;
   }

// Connected ROOK and QUEEN scoring
   for(ri = 0; ri < orook_count; ri++) {
    score += file_bonus[FILE(orook[ri])];
    if(stage < 3
        && (FILE(orook[ri]) == FILE(dksq) || FILE(orook[ri]) == FILE(dksq)+1 ||
            FILE(orook[ri]) == FILE(dksq)-1))
     score += ROOK_KING_FILE*file_bonus[FILE(orook[ri])];
    for(rj = ri+1; rj < orook_count; rj++) {
     if(RANK(orook[ri]) == RANK(orook[rj])
         && RANK(orook[ri])) score += ROOK_CONN;
     else if(FILE(orook[ri]) == FILE(orook[rj])) score += ROOK_CONN;
    }
   }

   for(ri = 0; ri < drook_count; ri++) {
    score -= file_bonus[FILE(drook[ri])];
    if(stage < 3
        && (FILE(drook[ri]) == FILE(oksq) || FILE(drook[ri]) == FILE(oksq)+1 ||
            FILE(drook[ri]) == FILE(oksq)-1))
     score -= ROOK_KING_FILE*file_bonus[FILE(drook[ri])];
    for(rj = ri+1; rj < drook_count; rj++) {
     if(RANK(drook[ri]) == RANK(drook[rj])
         && RANK(drook[ri]) < 7) score -= ROOK_CONN;
     else if(FILE(drook[ri]) == FILE(drook[rj])) score -= ROOK_CONN;
    }
   }

// Pawn scoring
  // check pawn hash table first
  if((pscore = get_pawn(pawn_code,&wfree_pawn,&bfree_pawn)) != HASH_MISS)
  { phash_count++; }
  else
  {
    pscore = 0;
    int file, rank;
    int weak, isle, passed;  // flags for weak, island, and passed pawns
    int last_passed;  // square of last passed pawn, useful for detecting
                      // connected passed pawns, although not perfect.

    // Loop through pawns for white
    last_passed = 0;
    for(pi = 0; pi < opawn_count; pi++) {
      file = FILE(opawn[pi]); rank = RANK(opawn[pi]);
      isle = 1; passed = 1; weak = 1;      // flags
      // look at my own pawns to see if we are doubled or have an island
      // also look for weak pawns and check if they are backward
      for(pj = 0; pj < opawn_count; pj++) {
       // look for doubled pawns and pawn island
       if(pj > pi) {
        if(FILE(opawn[pj]) == file) { pscore -= DOUBLED_PAWN; }
        else if(file < 7 && FILE(opawn[pj]) == file+1) isle = 0;
       }
       // look for weak pawns
       if(pj != pi && weak) {
         if(RANK(opawn[pj]) <= rank &&
            (FILE(opawn[pj]) == file-1 || FILE(opawn[pj]) == file+1)) weak = 0;
       }
      }
      // if the pawn is weak, score it and see if it is backward
      if(weak) {
       pscore -= WEAK_PAWN;
       if(p->sq[opawn[pi]+8].type != BPAWN && rank < 6) {
        if(file && ID(p->sq[opawn[pi]+15]) == BPAWN)
            pscore -= BACKWARD_PAWN;
        if(file < 7 && ID(p->sq[opawn[pi]+17]) == BPAWN)
            pscore -= BACKWARD_PAWN;
       }
      }
      // if we have a pawn island - score it
      if(isle) pscore -= PAWN_ISLAND;
      // look at enemy pawns to see if this pawn is passed
      for(pj = 0; pj < dpawn_count; pj++) {
         if(RANK(dpawn[pj]) > rank && (FILE(dpawn[pj]) == file ||
             FILE(dpawn[pj]) == file-1 || FILE(dpawn[pj]) == file+1))
           { passed = 0; pj = dpawn_count; }
      }
      // if the pawn is passed; give a bonus
      if(passed) {
        pscore += PASSED_PAWN*stage*(rank-1);
        // detect connected passers
        if(stage > 1) {
          if(rank > 4) {
           if(last_passed) {
             if(FILE(last_passed) == FILE(opawn[pi])+1 ||
                FILE(last_passed) == FILE(opawn[pi])-1)
               pscore += CON_PASSED_PAWNS;
           }
           last_passed = opawn[pi];
          }
         // detect outside passed pawns
         if(file > FILE(dksq)+3) pscore += PASSED_PAWN*stage*(rank-1)/2;
         else if(file < FILE(dksq)-3) pscore += PASSED_PAWN*stage*(rank-1)/2;
         // detect free passed-pawns
         if(7-rank < taxi_cab[file+56][dksq]+1 && stage > 2)
           wfree_pawn += PASSED_PAWN*stage*(rank-1);
        }
      }
    }

    // Loop through pawns on black side
    last_passed = 0;
    for(pi = 0; pi < dpawn_count; pi++) {
      file = FILE(dpawn[pi]); rank = RANK(dpawn[pi]);
      isle = 1; passed = 1; weak = 1; // flags
      // look at my own pawns to see if we are doubled or have an island
      // also look for weak pawns and check if they are backward
      for(pj = 0; pj < dpawn_count; pj++) {
       // look for doubled pawns and pawn island
       if(pj > pi) {
        if(FILE(dpawn[pj]) == file) { pscore += DOUBLED_PAWN; }
        else if(file < 7 && FILE(dpawn[pj]) == file+1) isle = 0;
       }
       // look for weak pawns
       if(pj != pi && weak) {
         if(RANK(dpawn[pj]) >= rank &&
            (FILE(dpawn[pj]) == file-1 || FILE(dpawn[pj]) == file+1)) weak = 0;
       }
      }
      // if the pawn is weak, score it and see if it is backward
      if(weak) {
       pscore += WEAK_PAWN;
       if(p->sq[dpawn[pi]-8].type != WPAWN && rank > 1) {
        if(file && ID(p->sq[dpawn[pi]-17]) == WPAWN)
           pscore += BACKWARD_PAWN;
        if(file < 7 && ID(p->sq[dpawn[pi]-15]) == WPAWN)
           pscore += BACKWARD_PAWN;
       }
      }
      // if we have a pawn island - score it
      if(isle) pscore += PAWN_ISLAND;

      // look at white pawns to see if this pawn is passed
      for(pj = 0; pj < opawn_count; pj++) {
         if(RANK(opawn[pj]) < rank && (FILE(opawn[pj]) == file ||
             FILE(opawn[pj]) == file-1 || FILE(opawn[pj]) == file+1))
           { passed = 0; pj = opawn_count; }
      }
      // if the pawn is passed; give a bonus
      if(passed) {
        pscore -= PASSED_PAWN*stage*(6-rank);
        // detect connected passers
        if(stage > 1) {
          if(rank < 3) {
           if(last_passed) {
             if(FILE(last_passed) == FILE(dpawn[pi])+1 ||
                FILE(last_passed) == FILE(dpawn[pi])-1)
               pscore -= CON_PASSED_PAWNS;
           }
           last_passed = dpawn[pi];
          }
         // detect outside passed pawns
         if(file > FILE(oksq)+3) pscore -= PASSED_PAWN*stage*(6-rank)/2;
         else if(file < FILE(oksq)-3) pscore -= PASSED_PAWN*stage*(6-rank)/2;
         // detect free passed-pawns
         if(rank < taxi_cab[file][oksq]+1 && stage > 2)
           bfree_pawn -= PASSED_PAWN*stage*(6-rank);
        }
      }
    }

  // King Safety from Pawn shield and preventing pawn storms

  // for white side
  if(stage < 2 && oksq < 16) {
    if(!((p->sq[oksq+8].type == PAWN && p->sq[oksq+8].side)
        || (p->sq[oksq+16].type == PAWN && p->sq[oksq+16].side)))
      pscore -= 2*PAWN_SHIELD;
    pscore -= 2*file_bonus[FILE(oksq)];
    if(FILE(oksq)) {
     if(!((p->sq[oksq+7].type == PAWN && p->sq[oksq+7].side)
         || (p->sq[oksq+15].type == PAWN && p->sq[oksq+15].side)))
      pscore -= PAWN_SHIELD;
     pscore -= 2*file_bonus[FILE(oksq)-1];
    }
    if(FILE(oksq) < 7) {
     if(!((p->sq[oksq+9].type == PAWN && p->sq[oksq+9].side)
         || (p->sq[oksq+17].type == PAWN && p->sq[oksq+17].side)))
      pscore -= PAWN_SHIELD;
     pscore -= 2*file_bonus[FILE(oksq)+1];
    }
   }
  // for black side
  if(stage < 2 && dksq > 47) {
    if(!((p->sq[dksq-8].type == PAWN && !p->sq[dksq-8].side)
        || (p->sq[dksq-16].type == PAWN && !p->sq[dksq-16].side)))
     pscore += 2*PAWN_SHIELD;
    pscore += 2*file_bonus[FILE(dksq)];
    if(FILE(dksq)) {
     if(!((p->sq[dksq-9].type == PAWN && !p->sq[dksq-9].side)
         || (p->sq[dksq-17].type == PAWN && !p->sq[dksq-17].side)))
      pscore += PAWN_SHIELD;
     pscore += 2*file_bonus[FILE(dksq)-1];
    }
    if(FILE(dksq) < 7) {
     if(!((p->sq[dksq-7].type == PAWN && !p->sq[dksq-7].side)
         || (p->sq[dksq-15].type == PAWN && !p->sq[dksq-15].side)))
      pscore += PAWN_SHIELD;
     pscore += 2*file_bonus[FILE(dksq)+1];
    }
   }

   put_pawn(pawn_code, pscore, wfree_pawn, bfree_pawn);
  }

   // trade pieces when ahead, pawns when behind

   if(score+pscore > 2*value[PAWN] && stage > 1) {
    score += (8-p->pieces[0])*(8-p->pieces[0])*TRADE_PIECES;
    score -= (8-opawn_count)*(8-opawn_count)*KEEP_PAWNS;
   } else if(score+pscore < -2*value[PAWN] && stage > 1) {
    score -= (8-p->pieces[1])*(8-p->pieces[1])*TRADE_PIECES;
    score += (8-dpawn_count)*(8-dpawn_count)*KEEP_PAWNS;
   }

   if(p->pieces[1] < 3 && !orook_count && !opawn_count
       && score+pscore > 0) return 0;
   if(p->pieces[0] < 3 && !drook_count && !dpawn_count
       && score+pscore < 0) return 0;

   if(p->pieces[1] == 1) score += wfree_pawn;
   if(p->pieces[0] == 1) score += bfree_pawn;

   if(p->wtm) return (score+pscore);
   else return -(score+pscore);

}

/*--------------------- Function to Read Scoring Parameters from a File -------------------- */
void set_score_param()
{

 char dummy[50], line[200], parameter_file[100];

 // setup the taxi-cab table
 for(int i = 0; i < 64; i++) {
  for(int j = 0; j < 64; j++) {
    taxi_cab[i][j] = MAX((absl(FILE(i)-FILE(j))),(absl(RANK(i)-RANK(j))));
  }
 }

 strcpy(parameter_file, exec_path);
 strcat(parameter_file, "search.par");
 
 ifstream parfile(parameter_file);

 if(!parfile) parfile.open("search.par");
 
 if(!parfile) { cout << "Error(NoScoreFile)"; return; }


 while(!parfile.eof()) {
  parfile >> dummy;
  if(dummy[0] == '#') {
    parfile.getline(line, 199);
    continue;
  }

  if(!strcmp(dummy,"BAD_BISHOP")) {
    parfile >> BAD_BISHOP;
  } else if(!strcmp(dummy, "DOUBLED_PAWN")) {
    parfile >> DOUBLED_PAWN;
  } else if(!strcmp(dummy, "WEAK_PAWN")) {
    parfile >> WEAK_PAWN;
  } else if(!strcmp(dummy, "BACKWARD_PAWN")) {
    parfile >> BACKWARD_PAWN;
  } else if(!strcmp(dummy, "PAWN_ISLAND")) {
    parfile >> PAWN_ISLAND;
  } else if(!strcmp(dummy, "PASSED_PAWN")) {
    parfile >> PASSED_PAWN;
  } else if(!strcmp(dummy, "BISHOP_PAIR")) {
    parfile >> BISHOP_PAIR;
  } else if(!strcmp(dummy, "CONNECTED_ROOKS")) {
    parfile >> ROOK_CONN;
  } else if(!strcmp(dummy, "CONNECTED_PASSED_PAWNS")) {
    parfile >> CON_PASSED_PAWNS;
  } else if(!strcmp(dummy, "OPEN_FILE_BONUS")) {
    parfile >> FILE_BONUS;
  } else if(!strcmp(dummy, "HALF_OPEN_FILE_BONUS")) {
    parfile >> HALF_FILE_BONUS;
  } else if(!strcmp(dummy, "CASTLING_BONUS")) {
    parfile >> HAS_CASTLED;
  } else if(!strcmp(dummy, "ROOK_ON_OPEN_FILE_NEAR_KING")) {
    parfile >> ROOK_KING_FILE;
  } else if(!strcmp(dummy, "PAWN_VALUE")) {
    parfile >> value[PAWN];
  } else if(!strcmp(dummy, "KNIGHT_VALUE")) {
    parfile >> value[KNIGHT];
  } else if(!strcmp(dummy, "BISHOP_VALUE")) {
    parfile >> value[BISHOP];
  } else if(!strcmp(dummy, "ROOK_VALUE")) {
    parfile >> value[ROOK];
  } else if(!strcmp(dummy, "QUEEN_VALUE")) {
    parfile >> value[QUEEN];
  } else if(!strcmp(dummy, "KING_VALUE")) {
    parfile >> value[KING];
  } else if(!strcmp(dummy, "LAZY_EVAL_CUTOFF_OPENING")) {
    parfile >> lazy[0];
  } else if(!strcmp(dummy, "LAZY_EVAL_CUTOFF_EARLY_MID")) {
    parfile >> lazy[1];
  } else if(!strcmp(dummy, "LAZY_EVAL_CUTOFF_LATE_MID")) {
    parfile >> lazy[2];
  } else if(!strcmp(dummy, "LAZY_EVAL_CUTOFF_ENDGAME")) {
    parfile >> lazy[3];
  } else if(!strcmp(dummy, "EXTENSION_THRESHOLD")) {
    parfile >> THRESHOLD;
  } else if(!strcmp(dummy, "CHECK_EXTENSION")) {
    parfile >> CHECK_EXT;
  } else if(!strcmp(dummy, "PAWN_PUSH_EXTENSION")) {
    parfile >> PAWN_EXT;
  } else if(!strcmp(dummy, "RECAPTURE_EXTENSION")) {
    parfile >> RE_CAPT_EXT;
  } else if(!strcmp(dummy, "INITIAL_EXTENSION")) {
    parfile >> INIT_EXT;
  } else if(!strcmp(dummy, "MATE_EXTENSION")) {
    parfile >> MATE_EXT;
  } else if(!strcmp(dummy, "PV_EXTENSION")) {
    parfile >> PV_EXT;
  } else if(!strcmp(dummy, "NULL_MOVE_REDUCTION")) {
    parfile >> R; if(R < 0) R = 0;
  } else if(!strcmp(dummy, "RAZORING_DEPTH")) {
    parfile >> RAZOR_DEPTH;
  } else if(!strcmp(dummy, "TRADE_PIECES")) {
    parfile >> TRADE_PIECES;
  } else if(!strcmp(dummy, "KEEP_PAWNS")) {
    parfile >> KEEP_PAWNS;
  } else parfile.getline(line, 199);

 }


}






