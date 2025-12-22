/*
 * money.m - MUD code for dropping piles of money on the floor
 */

use t_util
use t_base
use tp_verbs

private proc utility MoneyGet(thing money)status:
  thing me,here;

  me:=Me();
  here:=Here();

  me@p_pMoney := me@p_pMoney + money@p_pMoney;
  Print("You pick up " + IntToString(money@p_pMoney) + " blutos.\n");
  if not me@p_pHidden and CanSee(here, me) then
    OPrint(Capitalize(me@p_pName) + " picks up the pile of money.\n");
  else
    OPrint("The pile of money rises and vanishes from view!.\n");
  fi;

  DelElement(here@p_rContents, money);
  money -- p_oWhere;
  money -- p_pMoney;
  ClearThing(money);

  succeed
corp


private proc utility MoneyLook()string:
  thing it;

  it:=It();
  "The pile of " + IntToString(it@p_pMoney) + " coins glitters enticeingly."
corp


private o_fakeMoney CreateThing(nil).
o_fakeMoney@p_oGetChecker := MoneyGet.
o_fakeMoney@p_oName := "money,coins;pile of".
/*o_fakeMoney@p_oDesc := "The pile of coins glitters enticeingly.".*/
o_fakeMoney@p_oDescAction:=MoneyLook.


private proc utility MoneyDrop()status:
  string a,b;
  int amount;
  thing me, here, bag;

  a:=GetWord();
  b:=GetWord();
  if b=="blutos" or b=="bluto" or b=="coins" or b=="coin" then
    amount:=StringToInt(a);
    if amount>0 then
      me:=Me();
      here:=Here();
      if me@p_pMoney<amount then
	Print("You only have " + IntToString(me@p_pMoney) + " bluto(s)\n");
	fail
      else
	me@p_pMoney :=me@p_pMoney-amount;
	bag:=CreateThing(o_fakeMoney);
	bag@p_pMoney:=amount;
	bag@p_oWhere:=here;
	AddTail(here@p_rContents,bag);
	Print("You drop " + IntToString(amount) + " blutos into a tidy pile on the floor.\n");
	if not me@p_pHidden and CanSee(here, me) then
	  OPrint(Capitalize(me@p_pName) + " drops some money on the floor.\n");
	else
	  OPrint("A handful of money appear out of thin air and drops on the floor.\n");
	fi;
	succeed
      fi
    else
      Print("You must drop at least one bluto\n");
      fail
    fi
  else
    continue
  fi
corp

/* replace the v_drop procedure in verbs.m with mine */

replace v_drop(string what)bool:
  thing me, object;
  string whatName;
  status st;

  me := Me();
  if what = "" then
    Print("You must specify what you want to drop.\n");
    false
  elif what == "all" then
    st := DoAll(me@p_pCarrying, dropAllStub);
    if st = fail then
      Print("You are not carrying anything obvious to drop.\n");
      false
    else
      st = continue
    fi
  else
    whatName := FormatName(what);
    st := FindName(me@p_pCarrying, p_oName, what);
    if st = succeed then
      object := FindResult();
      DoDrop(Here(), me, object) ~= fail
    elif st = continue then
      Print(whatName + " is ambiguous.\n");
      false
    else
      st := MoneyDrop();
      if st=succeed then
	true
      elif st=continue then
	Print(AAn("You are not carrying", whatName) + ".\n");
	false
      else
	false
      fi
    fi
  fi
corp;

/****/

unuse t_util
unuse t_base
unuse tp_verbs

/**** End of file ****/

