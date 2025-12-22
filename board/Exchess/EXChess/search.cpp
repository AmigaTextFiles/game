/* Search Functions */
#define TIME_FLAG 123456

#include <time.h>
#include <iostream.h>
#include <fstream.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "chess.h"
#include "define.h"
#include "const.h"
#include "funct.h"
#include "search.h"
#include "hash.h"

/*----------------------- Search function ---------------------*/
// Driver for the search process.  1st initialize important data
// structures, the do iterative deeping until time runs out.
move search(position p, int time_limit, int T)
{
  char outstring[60], mstring[10];
  int g, g_last = 0, max_limit, elapsed, done;
  move old_pc1, old_pc2;
  nomove.t = NOMOVE; turn = T;

#if DEBUG
 outfile.open("search.log");
#endif

  // setting counts to zero
  node_count = 0; eval_count = 0; time_count = 0;
  phash_count = 0; hash_count = 0; hmove_count = 0; q_count = 0;
  null_cutoff = 0; extensions = 0; internal_iter = 0;

  time_check_interval = 12500;

  // setup some search parameter - for recursive null move
  // and old hash entries
  nullm = 1; recur = 0;
  if(h_id > 1000 || h_id < 0) h_id = 1;
  h_id++;

  // is this a pondering session, if so - make the move from the pv
  if(ponder) {
   time_check_interval = time_check_interval/5;
   if(book && !pc[0][1].t) ponder_move = opening_book(p.hcode, &p);
   else ponder_move = pc[0][1];
   print_move(p, ponder_move, mstring);
   if(ponder_move.t) {
     if(!exec_move(&p, ponder_move, 0)) { ponder_time = 0; return nomove; }
   } else { ponder_time = 0; return nomove; }
   if(!ALLEG && post) cout << "Hint: " << mstring << "\n";
   turn++;
   cout.flush();
  }

  // add ponder move to position list
  if(ponder) p_list[T-2] = p.hcode;

  // initializing eval
  init_score(&p, T);

  // checking book
  if(book && !ponder) {
    bookm = opening_book(p.hcode, &p);
    if(bookm.t) { pc[0][0] = bookm; return pc[0][0]; }
    else if(stage) book = 0;
  }

  // if last search was a ponder and if user made expected move and
  // if ponder time is greater than limit, return best move
  if(last_ponder && ponder_time > time_limit &&
     p.last.t == ponder_move.t && pc[0][0].t) {
   if(ics) cout << "tellics whisper Guessed last move!\n";
   return pc[0][0];
  }
  if(last_ponder && p.last.t == ponder_move.t) {
   h_id--; // reset hash id to mark entries as current
   if(ics) cout << "tellics whisper Guessed last move, searching deeper...\n";
  }

  ponder_time = 0;

  // adjusting hash code for game stage
  p.hcode = or(p.hcode, stage_code[stage]);

  // initialize history table
  for(int i = 0; i < 64; i++)
   for(int j = 0; j < 64; j++) history[i][j] = 0;
  
  // Set time parameters
  limit = time_limit;  max_limit = 4*limit;
  start_time = time(NULL);

  // Main search loop for iterative deeping
  for(max_ply = 1; max_ply <= MAXD; max_ply++)
  {
    sp[0] = p;
    node_count++;

    if(max_ply == 1)
      { root_alpha = score_pos(&p) - 25;  root_beta = root_alpha + 50; }
    else { root_alpha = g_last-25; root_beta = g_last+25; }

    done = 0;

    while(done < 10) {
     fail = 0;
     g = pvs(root_alpha, root_beta, max_ply-1);
      if((inter() || g == -TIME_FLAG) && max_ply != 1) break;
     if(g >= root_beta) {
      root_alpha = root_beta-1;
      root_beta = MATE;
      done++;
      if(done > 1) root_alpha = -MATE;
     } else if(g <= root_alpha) {
      root_beta = root_alpha+1;
      root_alpha = -MATE;
      done++;
      if(done > 1) root_beta = MATE;
     } else done = 10;
    }

    if(fail == -1 && max_ply > 1) { pc[0][0] = old_pc1; pc[0][1] = old_pc2; }

    // panic mode - don't end a search on a fail low 
    if(!ponder && fail == -1 && limit < timeleft/2 && !tsuite
        && !analysis_mode)
    {
      limit *= 3;
      max_ply--;
      if(limit > timeleft/2) limit = int(timeleft/2);
      max_limit = limit;
      continue;
    }

    old_pc1 = pc[0][0]; old_pc2 = pc[0][1];

    if(post && !ics && g != -TIME_FLAG)
      search_display(g, start_time, node_count, max_ply);

    // if time is up, or we found a mate... break
    if(inter() || g == -TIME_FLAG ||
        ((g > MATE/2 || g < -MATE/2) && max_ply > 2)) break;
    // if 1/2 time is up, check score against last iteration
    // if score changes by more than a 1/2 pawn, double the time...
    // if score changes by less than a 1/2 pawn, break
    if((time(NULL) - start_time)*2 >= limit && max_ply > 1
        && !tsuite && limit < max_limit && limit < timeleft/2) {
      if((g-g_last) < -50 || (g-g_last) > 50) limit *= 2;
    }
    g_last = g;
  }

  elapsed = time(NULL) - start_time;  if(!elapsed) elapsed = 1;

  if(ponder) {
   last_ponder = 1; ponder_time = elapsed;
   if(fail == -1) ponder_time = -1; // if we ended on a fail low
  }

  // adjusting hash code for game stage
  p.hcode = or(p.hcode, stage_code[stage]);

  if(!xboard && !ALLEG && post) {
   cout << "\nnode_count = " << node_count
        << " quiescent nodes = " << q_count
        << " eval_count = " << eval_count << "\n";
   cout << "hash hits = " << hash_count
        << " hash moves = " << hmove_count
        << " pawn hash hits = " << phash_count << "\n";
   cout << "node_rate = " << int(node_count/elapsed)
        << " null cuts = " << null_cutoff
        << " exten = " << extensions
        << " int_iter = " << internal_iter << "\n";
  }

  // Kibitz the search results to ics server
  if(ics && !ALLEG && !ponder) {
   if(xboard) sprintf(outstring, "tellics whisper ");
   else sprintf(outstring, "\n Search summary: ");
   cout << outstring;
   if(wbest > MATE/2) {
     sprintf(outstring, "MATE+(%i) ", MATE-wbest);
   } else if(wbest < -MATE/2) {
     sprintf(outstring, "MATE-(%i) ", MATE+wbest);
   } else if(wbest >= 0) {
     sprintf(outstring, "+%.2f, ", float(wbest)/value[PAWN]);
   } else {
     sprintf(outstring, "%.2f, ", float(wbest)/value[PAWN]);
   }
   cout << outstring;
   if (elapsed >= 5)
    sprintf(outstring, "%i ply, nps: %.0f ",
             wply, float(node_count)/elapsed);
   else sprintf(outstring, "%i ply ", wply);
   cout << outstring;
   cout << "\n";
  }

#if DEBUG
 outfile.close();
#endif

  // learning if applicable
  if(!ponder && learn_bk) {
    if(!book && learn_count > 0 && wbest > +LEARN_SCORE)
      { book_learn(1); learned = learn_count; learn_count = -1; }
    else if(!book && learn_count > 0 && wbest < -LEARN_SCORE)
      { book_learn(0); learn_count = -1; }
    else if(learned && wbest < -LEARN_SCORE)
      { learn_count = learned; book_learn(-1);
        learned = 0; learn_count = -1; }
   }

  return pc[0][0];

}

// Special sort to shuffle best move to the top of the list

inline void QSort(move_rec *Lb, move_rec *Ub)
{
  move_rec V, *I, *J;

   V = *Lb; J = Lb;
   I = Lb + 1;
   for(I = Lb+1; I <= Ub; I++) {
       if (I->score > J->score) { J = I; }
   }
   *Lb = *J;
   *J = V;
}

/*-------------------- Principle variation function --------------------*/
// This function uses the improvement on the
// alpha-beta scheme called "principle variation search".
// After the first node, which is searched with the full alpha-beta window,
// the rest of the nodes are searched with a "null" window: alpha,alpha+1.

int pvs(int alpha, int beta, int depth)
{
 int ply = max_ply - depth - 1, talpha = alpha;
 int best = -MATE + ply, ex_flag = 0, old_extend, mate_ext = 0, hscore;
 int in_pv = 0, pv_extend = 0, rep_count;
 int legalmove = 0;
 int hardalpha, hardbeta;
 if(!ply) { hardalpha = -MATE; hardbeta = MATE; }
 else { hardalpha = dummy1; hardbeta = dummy2; }
 int score = 0, mcount = 0, first = 1, bm = -1, nbest, razor = 0;
 move smove;

#if DEBUG
// Debug archiving of search to a file
char space_string[50] = "\0";
char last_move_string[10];
for(int si = 0; si < ply; si++) strcat(space_string," ");
print_move(sp[ply], sp[ply].last, last_move_string);

outfile << space_string << "->Ply: " << ply << ", max_ply: "
        << max_ply << ", depth: " << depth << ", alpha: " << alpha
        << ", beta: " << beta << ", last: " << last_move_string << "\n";

#endif

 // check time and keyboard interrupt
 if(ply && time_count > time_check_interval)
  { if (time(NULL) - start_time >= limit || (inter()))
      return -TIME_FLAG;
    time_count = 0; }

 // add hash code for this position to position list
 p_list[turn+ply-1] = sp[ply].hcode;

 // Recursive null move...
 if(!(nullm)) recur++; if(recur > 1) nullm = 1;

 if (nullm && ply && !sp[ply].check && null_hash
      && sp[ply].pieces[0] > 1 && sp[ply].pieces[1] > 1)
   {
     node_count++;
     nullm = 0; recur = 0; max_ply -= R;
     dummy1 = -MATE; dummy2 = MATE;
     sp[ply+1] = sp[ply]; sp[ply+1].wtm ^= 1;
     sp[ply+1].hcode = or(or(sp[ply+1].hcode,wtm),btm);
     sp[ply+1].last.t = NOMOVE; sp[ply+1].ep = 0;
     sp[ply+1].material = -sp[ply+1].material;
     if(depth > R) {
      nbest = -pvs(-beta, -alpha, depth-1-R);
     } else nbest = -qsearch(ply+1, -beta, -alpha);
     nullm = 1; max_ply += R;
     if(nbest == TIME_FLAG) return -TIME_FLAG;
     if (nbest >= beta) {
      null_cutoff++;
      pc[ply][ply].t = NOMOVE;
      put_hash(sp[ply].hcode, nbest, talpha, beta, depth, nomove, max_ply);
      if(nbest < hardalpha) { return hardalpha; }
      if(nbest > hardbeta) { return hardbeta; }
      return nbest;
     }
     // bruce moreland's mate extension idea
     if(nbest <= -MATE/2) mate_ext = 1;
   }

 // check the hash table for a hash move
 hmove.t = get_move(sp[ply].hcode);
 if(hmove.t) hmove_count++;

 // Are we in the PV?
 if(((!(ply&1) && alpha == root_alpha && beta == root_beta) ||
     ((ply&1) && alpha == -root_beta && beta == -root_alpha))) {

   // internal iterative deepening - idea taken from crafty
  if(!hmove.t && depth > 2) {
    internal_iter++; null_hash = 1;
    dummy1 = -MATE; dummy2 = MATE;
    max_ply -= 1; sp[ply+1] = sp[ply];
    score = pvs(alpha, beta, depth-2);
    if(score == TIME_FLAG) { max_ply += 1; return -TIME_FLAG; }
    if(score <= alpha) {
     score = pvs(-MATE, beta, depth-2);
     if(score == TIME_FLAG) { max_ply += 1; return -TIME_FLAG; }
    }
    max_ply += 1;
    hmove.t = pc[ply+1][ply+1].t;
   }

  in_pv = 1;
   // PV extension
  if(depth < 2) pv_extend = 1;
 }

 if(!ply) extend = INIT_EXT;      // set initial extension var. at zero ply

 old_extend = extend;

 // find the semi-legal moves for this position
 legalmoves(&sp[ply], &slist[ply]);

 if(best > alpha) alpha = best;  // only works when window is wide open
                                 // - for depth of mate detection.
 if(alpha > best) best = alpha;  // don't return values below alpha

 // set razoring of uninteresting moves if material is low enough
 if(depth <= RAZOR_DEPTH && alpha > sp[ply].material+lazy[stage]
     && !sp[ply].check && max_ply > 2)
   { razor = 1; }

 while (mcount < slist[ply].count && best < beta)
 {
   // increase node counts
   node_count++;  time_count++;

   // shuffle highest scored move to top of list
   QSort(&slist[ply].mv[mcount], &slist[ply].mv[slist[ply].count-1]);

   smove = slist[ply].mv[mcount].m;

   // making move
   sp[ply+1] = sp[ply];
   if(!exec_move(&sp[ply+1], smove, ply)) {
    mcount++;
    continue;
   }

#if DEBUG
 print_move(sp[ply+1], smove, last_move_string);
 outfile << space_string << "Move: " << last_move_string << "\n";
#endif

   legalmove++;

   // Set the extensions
   while(1) {
     // if we caused a check, extend
     if(sp[ply+1].check) { extend += CHECK_EXT; break; }
     // if last move was a capture
     if(sp[ply+1].last.b.type&CAPTURE) {
      // if last move was a re-capture, extend
      if(sp[ply].last.b.type&CAPTURE && ply
         && sp[ply-1].material == sp[ply+1].material      // even exchange
         && value[sp[ply].sq[sp[ply+1].last.b.to].type] > 100)
        { extend += RE_CAPT_EXT; break; }
     }
     // pv extension
     if(pv_extend) { extend += PV_EXT; break; }
     // if last move was a pawn push and endgame, extend
     if(sp[ply+1].last.b.type&PAWN_PUSH && stage >= 3)
       { extend += PAWN_EXT; break; }
     // if mate_extension
     if(mate_ext) { extend += MATE_EXT; break; }
     break;
   }

   // extend if extend variable is greater than theshold
   if(max_ply < MAXD-2 && extend >= THRESHOLD) {
     max_ply++; depth++; ex_flag = 1; extensions++;
     extend -= THRESHOLD;
   }

   // razoring if possible, e.g. the current move is uninteresting
   // This is basically just a negative extension.
   if(razor && !ex_flag && extend == old_extend
      && !(smove.b.type&CAPTURE) && depth) {
     max_ply--; depth--; ex_flag = -1;
   }

   dummy1 = -MATE; dummy2 = MATE;  // setting default values for the dummy
                                   // variables which will carry bound info
                                   // from the hash table to the next node
   null_hash = 1;  // switch for null move from hash table

   // fifty move rule
   score = 1;
   if(sp[ply+1].fifty >= 100) score = 0;

   // avoid repeating a position if possible
  rep_count = 0;
  if(score) {
   for(int ri = turn+ply-sp[ply+1].fifty; ri < turn+ply; ri++) {
    if(p_list[ri].key == (sp[ply+1].hcode.key^stage_code[stage].key)
       && p_list[ri].address == (sp[ply+1].hcode.address^stage_code[stage].address))
      { rep_count++; if(rep_count > 1) score = 0; }
   }
  }

   // check hash table
   if(ply)
    hscore = get_hash(sp[ply+1].hcode,-beta,-alpha,depth-1, &dummy1, &dummy2);
   else hscore = HASH_MISS;

   if(hscore > HASH_MISS && score) {
     score = -hscore;
#if DEBUG
 outfile << space_string << "Hash hit: " << score << "\n";
#endif
     if(score > alpha) pc[ply+1][ply+1].t = NOMOVE;
     hash_count++;
   // goto qsearch if depth = 0
   } else if (!depth && score) {
     score = -qsearch(ply+1, -beta, -alpha);
#if DEBUG
 outfile << space_string << "Returned value: " << score << "\n";
#endif
     put_hash(sp[ply+1].hcode, -score, -beta, -alpha, -1, nomove, max_ply);
   } else if(score) {
     if (first) {
       score = -pvs(-beta, -alpha, depth-1);
#if DEBUG
 outfile << space_string << "Returned value: " << score << "\n";
#endif
       if (score == TIME_FLAG) return -TIME_FLAG;
     } else {
       score = -pvs(-alpha-1, -alpha, depth-1);
#if DEBUG
 outfile << space_string << "Returned value: " << score << "\n";
#endif
       if (score == TIME_FLAG) return -TIME_FLAG;
       if (score > alpha && score < beta) {
         score = -pvs(-beta, -alpha, depth-1);
#if DEBUG
 outfile << space_string << "Returned value: " << score << "\n";
#endif
         if (score == TIME_FLAG) return -TIME_FLAG;
       }
     }
   }

   first = 0;

   if (score > alpha) {
     alpha = score;
     best = score;
     pc_update(smove, ply);
     bm = mcount;
     if(!ply) {
      if(score >= beta) fail = 1;                // if this is a fail high
      wbest = score; wply = max_ply;             // whisper variables
      if(post && !ics)
        search_display(score, start_time, node_count, max_ply-ex_flag);
     }
     // update history list
     history[smove.b.from][smove.b.to] += depth;
   }

   // undo any extension
   if(ex_flag == 1) { max_ply--; depth--; ex_flag = 0; }
   else if(ex_flag == -1) { max_ply++; depth++; ex_flag = 0; }
   extend = old_extend;

   mcount++;
 }

 // if it is stalemate; the score is even
 if (!legalmove && ply && !sp[ply].check) best = 0;

 if(best <= talpha && !ply)  // if this is a fail low
  { fail = -1; if(post) search_display(score, start_time, node_count, max_ply); }

 // storing position in the hash table
 if(bm != -1) {
   put_hash(sp[ply].hcode, best, talpha, beta, depth, slist[ply].mv[bm].m, max_ply);
 } else if(ply) {
   put_hash(sp[ply].hcode, best, talpha, beta, depth, nomove, max_ply);
   pc_update(nomove, ply);
 }

 // hardalpha and hardbeta are returned by hash table in the search node
 // above this one.  They insure consistency in the search, because the hash
 // table has some information about score bounds.
 if (best < hardalpha && ply) { return hardalpha; }
 if (best > hardbeta && ply) { return hardbeta; }

 return best;
}

/*--------------------- Quiescent search ---------------------*/
// This searches only non-losing captures.  Futility cut-offs
// are made if the capture is not likely to bring us up back
// above alpha.   A straight alpha-beta algorithm is used here.
int qsearch(int ply, int alpha, int beta)
{
  int best, score, delta;        // best score, score for current move
                                 // and delta - below which captures are futile
  int material = sp[ply].material;
  move_rec qmove;                // Move record for current move to search

  // lazy eval if positional scores can't bring us near beta or alpha
  // otherwise score position fully.
  if (material < beta+lazy[stage]
      && material > alpha-lazy[stage] && !sp[ply].check) {
    best = score_pos(&sp[ply]); eval_count++;
  }
  else if(!sp[ply].check) {
    best = material;
  } else {
    best = material - value[KING];
  }

  // Don't allow a 0 score.. this is reserved for draws
  if(best == 0) best = 1;

  if(ply >= MAXD-2  || best >= beta) return best;   // break if best > beta
                                                  //  or we are too deep
  if(best > alpha) alpha = best;
  delta = alpha - best - 100;           // set futility cutoff
  if(alpha > best) best = alpha;

  // if not in check generate captures, else generate full moves
  if(!sp[ply].check) captures(&sp[ply], &slist[ply]);
  else legalmoves(&sp[ply], &slist[ply]);

  // loop trough possible captures, trying them in turn
  for (int qi = 0; qi < slist[ply].count; qi++)
  {
    // shuffle highest scored move to top of list
    QSort(&slist[ply].mv[qi], &slist[ply].mv[slist[ply].count-1]);
    qmove = slist[ply].mv[qi];

    // if we are at the end of useful moves, exit loop
    if (qmove.score < delta && !sp[ply].check) break;

    // increase node counts
    node_count++; q_count++; time_count++;

    // execute move
    sp[ply+1] = sp[ply];
    if (!exec_move(&sp[ply+1], qmove.m, ply)) continue;

    // call next iteration
    score = -qsearch(ply+1, -beta, -alpha);

    if (score > alpha) {
     alpha = score;
     best = score;
    }

    // exit if we are over beta
    if (best >= beta) break;
  }

  return best;
}

/* Function to update principle continuation */
// The principle continuation is stored as a "triangular" array.
// It is updated by doing a mem-copy of the principle continuation
// found at deeper depths to this depth + the move at this depth
// is stuffed in first.
void pc_update(move pcmove, int ply)
{
 int pci;
 pc[ply][ply].t = pcmove.t;
 for (pci = ply+1; ; pci++)
 {
  if(ply+1 < max_ply && pci >= max_ply)
   { if(!(pc[ply+1][pci].t)) break; }
  else if (pci >= max_ply) break;
  pc[ply][pci].t = pc[ply+1][pci].t;
 }
 pc[ply][pci].t = NOMOVE;
}


