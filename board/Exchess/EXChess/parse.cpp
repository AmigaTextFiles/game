/* Parse.cpp  - functions for parsing moves */

#include "chess.h"
#include "define.h"
#include "funct.h"
#include "const.h"
#include <iostream.h>
#include <stdio.h>
#include <string.h>

extern int ics;
// Function to parse a move from the human player
// This move is checked then checked to see if it is legal
move parse_move(position p, char mstring[10])
{
  int legal = 0, piece, to_sq = -1, from_sq = -1, promote = QUEEN;
  int from_file = -1, from_row = -1, match_count = 0;
  move play, mplay[4], nomove; nomove.t = 0;
  mplay[0].t = 0; mplay[1].t = 0; mplay[2].t = 0; mplay[3].t = 0;
  position t_pos;
  move_list list;

  // generate the legal moves
  legalmoves(&p, &list);

  // Examining input move from a human player - checking for
  // errors and the legality of the move....

  // First resolve the first character - what piece is it?
  switch(mstring[0]) {
    case 'N': piece = KNIGHT; break;
    case 'B': piece = BISHOP; break;
    case 'R': piece = ROOK; break;
    case 'Q': piece = QUEEN; break;
    case 'K': piece = KING; break;
    case 'P': piece = PAWN; break;
    case 'O': piece = 10; break;        // if it is a castle
    case '0': piece = 10; break;
    case 'o': piece = 10; break;
    default : piece = PAWN;
  }

  if (piece != 10) {  // if is not a castle

    // Now cycle throught the rest of the characters looking
    // for move squares, capture signals, or promotion signals
    for(int i = 0; i < 10; i++) {
      if(!i && piece != PAWN) i++;
      switch(mstring[i]) {
        case '\0': i = 10; break;
        case 'x':
          if(CHAR_FILE(mstring[i+1]) <= 7 && CHAR_FILE(mstring[i+1]) >= 0
             && CHAR_ROW(mstring[i+2]) <= 7 && CHAR_ROW(mstring[i+2]) >= 0) {
           from_sq = to_sq;
           to_sq = SQR(CHAR_FILE(mstring[i+1]), CHAR_ROW(mstring[i+2]));
           i += 2; break;
          } else { i += 1; break; }
        case '-':
          if(CHAR_FILE(mstring[i+1]) <= 7 && CHAR_FILE(mstring[i+1]) >= 0
             && CHAR_ROW(mstring[i+2]) <= 7 && CHAR_ROW(mstring[i+2]) >= 0) {
           from_sq = to_sq;
           to_sq = SQR(CHAR_FILE(mstring[i+1]), CHAR_ROW(mstring[i+2]));
           i += 2; break;
          } else { i+= 1; break; }
        case '=':
          switch(mstring[i+1]) {
            case 'N': promote = KNIGHT; break;
            case 'B': promote = BISHOP; break;
            case 'R': promote = ROOK; break;
            case 'Q': promote = QUEEN; break;
          }
          i = 10;
          break;
        case '+': i = 10; break;
        default:
          if (to_sq == -1 && CHAR_ROW(mstring[i+1]) <= 7
               && CHAR_ROW(mstring[i+1]) >=0 && CHAR_FILE(mstring[i]) >= 0
               && CHAR_FILE(mstring[i]) <= 7) {
            to_sq = SQR(CHAR_FILE(mstring[i]), CHAR_ROW(mstring[i+1]));
            i += 1;
          } else {
            if (CHAR_ROW(mstring[i+1]) <= 7 && CHAR_ROW(mstring[i+1]) >= 0
                && CHAR_FILE(mstring[i]) <= 7 && CHAR_FILE(mstring[i]) >= 0) {
              from_sq = to_sq;
              to_sq = SQR(CHAR_FILE(mstring[i]), CHAR_ROW(mstring[i+1]));
              switch (mstring[i+2]) {
                case 'q': promote = QUEEN; i++; break;
                case 'n': promote = KNIGHT; i++; break;
                case 'b': promote = BISHOP; i++; break;
                case 'r': promote = ROOK; i++; break;
              }
              i += 1;
            } else {
             if(CHAR_FILE(mstring[i]) <= 7 && CHAR_FILE(mstring[i]) >= 0)
              from_file = CHAR_FILE(mstring[i]);
             else
              from_row = CHAR_ROW(mstring[i]);
            }
          }
          break;
      }
    }
    play.b.from = from_sq;  play.b.to = to_sq;

  } else {    // if it is a castle

    if (!strcmp(mstring, "O-O") || !strcmp(mstring, "0-0")
        || !strcmp(mstring, "o-o") || !strcmp(mstring, "O-O+")
        || !strcmp(mstring, "0-0+") || !strcmp(mstring, "o-o+")) {
      if (p.wtm) { play.b.from = 4; play.b.to = 6; }
      else { play.b.from = 60; play.b.to = 62; }
    } else if (!strcmp(mstring, "O-O-O") || !strcmp(mstring, "0-0-0")
               || !strcmp(mstring, "o-o-o") || !strcmp(mstring, "O-O-O+")
               || !strcmp(mstring, "0-0-0+") || !strcmp(mstring, "o-o-o+")) {
      if (p.wtm) { play.b.from = 4; play.b.to = 2; }
      else { play.b.from = 60; play.b.to = 58; }
    }
  }


  // Match up the move in the move list
  for (int z = 0; z < list.count; z++)
  {
   if (match_count > 2) break;
   if (list.mv[z].m.b.to == play.b.to &&
        (promote == list.mv[z].m.b.promote || !list.mv[z].m.b.promote))
    {
     if (list.mv[z].m.b.from == play.b.from) {
       mplay[match_count] = list.mv[z].m;
       match_count++;
     } else if (FILE(list.mv[z].m.b.from) == from_file &&
                 p.sq[list.mv[z].m.b.from].type == piece) {
       mplay[match_count] = list.mv[z].m;
       match_count++;
     } else if (RANK(list.mv[z].m.b.from) == from_row &&
                 p.sq[list.mv[z].m.b.from].type == piece) {
       mplay[match_count] = list.mv[z].m;
       match_count++;
     } else if (from_sq == -1 && from_file == -1 && from_row == -1 &&
                 p.sq[list.mv[z].m.b.from].type == piece) {
       mplay[match_count] = list.mv[z].m;
       match_count++;
     }
    }
  }

  // check the case where there are two matches but one might
  // lead to check so is illegal... the other is then a valid move
  while (match_count <= 2 && match_count) {
    t_pos = p;
    legal = exec_move(&t_pos, mplay[0], 0);   // tenatively making the move...
    if(match_count == 1) break;
    t_pos = p;
    if(legal && exec_move(&t_pos, mplay[1], 0))
      { legal = 0; break; }
    else if(legal) break;
    t_pos = p;
    legal = exec_move(&t_pos, mplay[1], 0);
    mplay[0] = mplay[1];
    break;
  }

  // if it is not legal
  if (!legal || !match_count) {
    return nomove;
  }

  return mplay[0];
}

/* Function to print a single move */
// to a string in long algebraic format
// This function works by simply adding the appropriate
// characters to the move string;
void print_move(position p, move pmove, char mstring[10])
{
  char dummy[10];             // dummy character string
  int ptype, pfrom, pto, ppiece;

  strcpy(mstring, "");
  strcpy(dummy, "");

  if(pmove.b.type&CASTLE) {           // if it is a castle
    if(pmove.b.from > pmove.b.to) sprintf((mstring), "O-O-O");
    else sprintf((mstring), "O-O");
  } else {
    ppiece = p.sq[pmove.b.from].type;
    pfrom = pmove.b.from;
    pto = pmove.b.to;
    ptype = pmove.b.type;

    if (ppiece > PAWN)
     { sprintf(mstring, "%c", name[ppiece]); }
    switch(ppiece) {
      case PAWN:
        if(ptype&CAPTURE)
         sprintf(dummy,"%c", char(FILE(pfrom)+97));
        break;
      case KING:
        strcpy(dummy, ""); break;
      default:
        move_list list;
        int add_file = 0;

        // generate the legal moves
        legalmoves(&p, &list);
        // Match up the move in the move list
        for (int z = 0; z < list.count; z++) {
         if (list.mv[z].m.b.to == pto && list.mv[z].m.b.from != pfrom &&
              ppiece == p.sq[list.mv[z].m.b.from].type) {
           if(!add_file) { 
             sprintf(dummy,"%c", char(FILE(pfrom)+97));
             add_file = 1;
           }
           if(FILE(pfrom) == FILE(list.mv[z].m.b.from)) {
             char dummy2[2];
             sprintf(dummy2,"%i", (RANK(pfrom)+1));
             strcat(dummy,dummy2);
             z = list.count;
           }             
         }        
        }        
    }
    if(ptype&CAPTURE) strcat(dummy,"x");      
    strcat(mstring, dummy);
    sprintf(dummy, "%c%i", char(FILE(pmove.b.to)+97), (RANK(pmove.b.to)+1));
    strcat(mstring, dummy);
    if (pmove.b.type&PROMOTE) {
      strcat(mstring, "="); sprintf(dummy, "%c", name[pmove.b.promote]);
      strcat(mstring, dummy);
    }
  }

  // now execute the move and see if it leads to check or check-mate...
  exec_move(&p, pmove, 0); 
  if(check(&p, p.wtm) && !ics) {
    if(check_mate(&p)) strcat(mstring, "#");
    else strcat(mstring, "+");
  }
}
