/* Check functions */

#include "chess.h"
#include "define.h"
#include "funct.h"
#include "const.h"

/* Check to see if we are in check */
// Returns a one if the side specified is in check
// Returns a zero if not.

int check(position *p, int side)
{
  int ksq = p->kingpos[side];     // king's square

  // is it attacked?
  if(attacks(ksq, p, side^1, 1)) return 1;
  else return 0;
}

/* Check to see if this is check-mate */
// Returns 1 if check_mate
// Returns 2 if stale_mate
// Returns 0 if ok

int check_mate(position *p)
{
  int ok = 0;                 // ok flag
  move_list tlist;            // temporary list
  position tpos;              // temporary position

  legalmoves(p, &tlist);       // find the semi-legal moves
  
  for(int i = 0; i < tlist.count; i++)
   {  
     tpos = (*p);
     if(exec_move(&tpos, tlist.mv[i].m, 0))
       { ok = 1; break; }
   }

  if(ok) return 0;                      // ok!
  else
  {
    if(check(p, p->wtm)) return 1;      // check_mate!
    else return 2;                      // stale_mate!
  }

}
