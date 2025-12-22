/*
 * trashcan.m - defines a magic trashcan which acts like the garbage room
 */

use t_util.
use t_base.
use Characters.

private proc TrashcanPutIn(thing what, trashcan)status:
  thing carryer;
  string name,tname;

  carryer := Me();

  if carryer ~= nil then
    CancelAllDoAfters(what);
    name := FormatName(what@p_oName);
    tname:= FormatName(trashcan@p_oName);
    ZapObject(what);
    if not carryer@p_pHidden then
      OPrint(Capitalize(carryer@p_pName) + AAn(" drops", name) + " into the " + tname + ", which flashes brightly for a moment!\n");
    else
      OPrint(Capitalize(AAn("", name)) + " appears, descends into the " + tname + ", which flashes brightly for a moment!\n");
    fi;
    Print("You put the " + name + " into the " + tname + ", which flashes brightly for a moment!\n");
    DelElement(carryer@p_pCarrying, what);
    succeed
  else
    continue
  fi
corp

private o_Trashcan CreateThing(nil).
o_Trashcan@p_oName := "trashcan;magic".
o_Trashcan@p_oContents := CreateThingList().
o_Trashcan@p_Image := "Trashcan".
o_Trashcan@p_oNotGettable:=true.
o_Trashcan@p_oPutInMeChecker:=TrashcanPutIn.

/****/

unuse t_util.
unuse t_base.
unuse Characters.

/**** End of file ****/



