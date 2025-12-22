/*
 * lockers.m - create locker code
 */

private tp_locker CreateTable().

use t_util.
use t_base.
use tp_verbs
use tp_locker.


define tp_locker p_rLockers CreateThingListProp().
define tp_locker p_oLockerContents CreateThingListProp().
define tp_locker p_oLockerOwner CreateThingProp().


define tp_locker proc lockerGetList(thing me, here)thing:
  list thing lt;
  int count, i;
  thing locker;

  lt := here@p_rLockers;
  if lt = nil then
    locker:=nil;
  else
    count := Count(lt);
    i := 0;
    while
      if i = count then
	false
      else
	locker := lt[i];
	locker@p_oLockerOwner ~= me
      fi
    do
      i := i + 1;
    od;
    if i = count then
      locker:=nil;
    fi;
  fi;
  locker
corp


define tp_locker proc lockerPut()void:
  thing me,here,locker,what;
  string whatName,s,fname;
  status st;

  me:=Me();
  here:=Here();

  s:=GetTail();
  if s="" then
    Print("You must specify what you want to checkin.\n");
  else
    whatName := GetNounPhrase(G,s,0);
    st := FindName(me@p_pCarrying, p_oName, whatName);
    if st = succeed then
      what := FindResult();

      locker:=lockerGetList(me,here);
      if locker = nil then
	locker:=CreateThing(nil);
	locker@p_oLockerOwner:=me;
	locker@p_oLockerContents:=CreateThingList();
	AddTail(here@p_rLockers,locker);
	Print("Allocating a new locker for \"" + me@p_pName + "\".\n");
      fi;

      AddTail(locker@p_oLockerContents, what);
      DelElement(me@p_pCarrying, what);
      what -- p_oCarryer;
      what@p_oWhere := here;
      fname:=FormatName(what@p_oName);
      Print("You deposit the " + fname + " safely in your locker\n");
      if not me@p_pHidden and CanSee(here, me) then
	OPrint(Capitalize(me@p_pName) + AAn(" stores ",fname) + " in a locker.\n");
      fi;
    elif st = continue then
      Print(whatName + " is ambiguous.\n");
    else
      Print(AAn("You are not carrying", s) + ".\n");
    fi
  fi;
corp


define tp_locker proc lockerGet()void:
  thing me, here, locker, what;
  string whatName, tail, noun;
  list thing lt;
  list thing carrying;
  status st;
  bool bo;

  me:=Me();
  here:=Here();

  locker:=lockerGetList(me,here);
  if locker ~= nil then
    lt:=locker@p_oLockerContents;
    tail := GetTail();
    noun := GetNounPhrase(G,tail,0);
    st := FindName(lt, p_oName, noun);
    if st=succeed then
      what := FindResult();
      bo:=CarryItem(what);
      if bo=true then
	whatName := FormatName(what@p_oName);
	Print(whatName + ": taken.\n");
	 if not me@p_pHidden and CanSee(here, me) then
	  OPrint(Capitalize(me@p_pName) + AAn(" takes ",whatName) + " from a locker.\n");
	fi;
	what -- p_oWhere;
	DelElement(lt, what);
      fi
    elif st = continue then
      Print(tail + " is ambiguous here.\n");
    else
      Print("There is no " + tail + " in your locker\n");
    fi;
  else
    Print("I'm sorry, this locker room does not have a locker for \"" + me@p_pName + "\".\n");
  fi;
corp


define tp_locker proc lockerLook()void:
  thing me,locker;

  me:=Me();
  locker:=lockerGetList(me,Here());

  if locker ~= nil then
    ignore ShowList(locker@p_oLockerContents, "In your locker, you have the following items:\n");
    if not me@p_pHidden and CanSee(Here(), me) then
      OPrint(Capitalize(me@p_pName) + " peers inside a locker.\n");
    fi;
  else
    Print("I'm sorry, this locker room does not have a locker for \"" + me@p_pName + "\".\n");
  fi;
corp;


define tp_locker proc lockerHelp()void:
  Print("The additional commands for this locker room are:\n" +
	"  CHECK    : Shows you whats in your locker\n"       +
	"  CHECKIN  : Stores an object in your locker\n"      +
	"  CHECKOUT : Retrieves an object from your locker\n");
corp;

/*
 * make this one utility, so people can only do it to their own rooms.
 */

define t_util proc utility MakeLocker(thing room)void:
  if room=nil then
    room:=Here();
  fi;
  room@p_rLockers := CreateThingList();
  AddSpecialCommand(room, "check", lockerLook);
  AddSpecialCommand(room, "checkout", lockerGet);
  AddSpecialCommand(room, "checkin", lockerPut);
  AddSpecialCommand(room, "help", lockerHelp);
corp;


define t_util proc Islocker(thing room)bool:
  if room=nil then
    room:=Here();
  fi;
  room@p_rLockers ~= nil
corp;


define t_util proc utility Unmakelocker(thing room)status:
  list thing lockers;

  if room=nil then
    room:=Here();
  fi;

  lockers := room@p_rLockers;
  if lockers = nil then
    continue
  elif Count(lockers) ~= 0 then
    fail
  else
    ignore RemoveSpecialCommand(room, "check", lockerLook);
    ignore RemoveSpecialCommand(room, "checkin", lockerPut);
    ignore RemoveSpecialCommand(room, "checkout", lockerGet);
    ignore RemoveSpecialCommand(room, "help", lockerHelp);
    room -- p_rLockers;
    succeed
  fi
corp;

unuse tp_locker.
unuse t_util.
unuse t_base.
unuse tp_verbs

/**** End of file ****/

