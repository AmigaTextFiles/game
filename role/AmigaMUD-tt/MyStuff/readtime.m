/*
 * ReadTme.m - Creates a wrist watch object, for sale in the mall,
 * and a town clock, which tells the time.
 * 27/6/96 Tak Tang
 */

use t_base.
use t_util.
use t_streets.
use tp_mall.

/*****
* Create Wrist watch
*****/

define tp_mall proc utility public ReadWatch()string:
  thing me,here;

  me   := Me();
  here := Here();

  if not me@p_pHidden and CanSee(here, me) then
    OPrint(Capitalize(me@p_pName) + " glances at his wrist\n");
  fi;
  "The time is " + Date() + "."
corp

define tp_mall o_watch CreateThing(nil).
o_watch@p_oName := "watch;wrist".
SetThingStatus(o_watch, ts_public).
o_watch@p_oReadAction := ReadWatch.
o_watch@p_oWearString := "You struggle with the cheap strap, and manage to force it on the furthest hole. Loose, but it will stay on.".
o_watch@p_oDesc := "The watch is a cheap mass-produced digital watch. "
  "It is fastened with a tacky black plastic strap with holes too far "
  "apart for a comfortable fit.".
AddObjectForSale(r_mallStore,o_watch,1,nil).
/* Maybe add an alarm feature, and a description */


/*****
* Create Town Clock
*****/

define t_streets proc utility public ReadClock()string:
  thing me,here;

  me   := Me();
  here := Here();

  if not me@p_pHidden and CanSee(here, me) then
    OPrint(Capitalize(me@p_pName) + " looks up at the clock\n");
  fi;

  "The time is " + Date() + "."
corp

define t_streets o_clock CreateThing(nil).
o_clock@p_oName := "clock,face;town".
o_clock@p_oReadAction := ReadClock.
o_clock@p_oInvisible := true.
o_clock@p_oNotGettable := true.
o_clock@p_oDesc := "The town clock is brand new.  Its arms sweep across its face like a ballet in slow motion.  The numerals are clearly readable.".
SetThingStatus(o_clock, ts_public).
AddTail(r_ws1@p_rContents, o_clock).
r_ws1@p_rDesc := "The town clock is here.".
/* Maybe add a chime, and code to show people trying to lift it,
 a la Entry-Exit machine, and a description */

unuse t_base.
unuse t_util.
unuse t_streets.
unuse tp_mall.

