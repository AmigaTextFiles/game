/*
 * status.m
 */

/**** Foreward
*This file attempts to revamp the status system so that you can
*plug in different status reporters for different system parts.
*For instance, you only want combat status to appear if you have been
*initialised for combat, and you only want magic status to appear if
*you have been iniaialised for magic.
*Essentially, it replaces the v_status and showStats routines to
*call the actions on a action list attached to the players.
****/

use t_base
use t_util
use t_fight
use tp_base
use tp_fight

/****
*Delete the st and status verbs,
*and the v_status and showStats routines
****/

DeleteWord(G,"st").
DeleteWord(G,"status").
ignore DeleteSymbol(LookupTable(PrivateTable(),"tp_fight"),"v_status").
ignore DeleteSymbol(LookupTable(PrivateTable(),"tp_fight"),"showStats").


/****
*Create an interface to the p_pStatActions property
****/

define tp_base p_pStatActions   CreateActionListProp().

define t_base proc utility AddStatAction(thing who; action a; bool front)void:
  addChecker(who, p_pStatActions, a, front);
corp;
define t_base proc utility DelStatAction(thing who; action a)void:
  delChecker(who, p_pStatActions, a);
corp;


/****
*Create the new showStats and v_status routines
****/

define tp_base proc showStats(thing who; bool full)void:
  string name;
  int i;
  list action la;

  name := who@p_pName;
  if not who@p_pStandard then
    name := FormatName(name);
  fi;
  Print(name+" status:\n\n");

  la:=who@p_pStatActions;
  if la ~= nil then
    for i from 0 upto Count(la) - 1 do
      call(la[i], void)(who,full);
    od;
  fi;

  Print("Bl: ");
  IPrint(who@p_pMoney);
  Print("\n");
corp.

define tp_base proc v_status(string who)bool:
  thing me;

  me := Me();
  if who=="full" then
    showStats(me, true);
    true
  elif who~="" and IsWizard() then
    me := FindAgent(who);
    if me ~= nil then
      showStats(me, true);
      true
    else
      Print("There is no " + who + " here.\n");
      false
    fi
  else
    showStats(me, false);
    true
  fi
corp.

Verb1(G, "status", 0, v_status).
Synonym(G, "status", "st").


/**** Figher stuff
*This section fixes the fighter code so it uses the
*p_pStatActions list.
****/

define tp_fight proc showStatsFight(thing theCharacter; bool forceLong)void:
  int ac;
  thing th;

  Print("Combat> Hit: ");
  IPrint(theCharacter@p_pHitNow);
  Print("/");
  IPrint(theCharacter@p_pHitMax);
  Print(" Exp: ");
  IPrint(theCharacter@p_pExperience);
  Print(" Lvl: ");
  IPrint(theCharacter@p_pLevel);
  Print(" Str: ");
  IPrint(theCharacter@p_pStrength);
  Print(" Spd: ");
  IPrint(theCharacter@p_pSpeed);
  Print(" AC: ");
  ac := theCharacter@p_pProtection;
  if ac > 0 then
    Print("+");
  fi;
  IPrint(ac);
  Print("\n");
  if forceLong or not theCharacter@p_pFightTerse or theCharacter ~= Me() then
    th := theCharacter@p_pWeapon;
    if th ~= nil then
      Print("Weapon: ");
      Print(FormatName(th@p_oName));
      Print("\n");
    fi;
    th := theCharacter@p_pShield;
    if th ~= nil then
      Print("Shield: ");
      Print(FormatName(th@p_oName));
      Print("\n");
    fi;
    th := theCharacter@p_pArmour;
    if th ~= nil then
      Print("Armour: ");
      Print(FormatName(th@p_oName));
      Print("\n");
    fi;
  fi;
corp.

replace InitFighter(thing fighter)void:
  if not fighter@p_pInited then
    fighter@p_pInited := true;
    fighter@p_pHitMax := 10;
    fighter@p_pHitNow := 10;
    fighter@p_pHitCount := 0;
    fighter@p_pExperience := 0;
    fighter@p_pStrength := 5;       /* "standard" strength */
    fighter@p_pSpeed := 5;          /* "standard" speed */
    fighter@p_pProtection := 9;     /* armour class +9 */
    fighter@p_pLevel := 0;
    fighter@p_pDieNotifyList := CreateActionList();
    AddPlayerEnterChecker(fighter, monsterEnterCheck, false);
    AddPlayerLeaveChecker(fighter, monsterLeaveCheck, false);
    AddStatAction(fighter,showStatsFight,false);
    SPrint(fighter, "\nCombat initialized!\n\n");
  fi;
corp.

/****/

unuse t_base
unuse t_util
unuse t_fight
unuse tp_base
unuse tp_fight

