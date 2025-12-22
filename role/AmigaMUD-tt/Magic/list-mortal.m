/*
 * magic/list-mortal.m Magic spells for mortals
 */

use tp_util2

/**** Foreward
*This file contains some basic spells meant for use by normal players.
*I need to expand this list considerably, and to put some thought into
*play balance (i.e. level, cost, power etc...).
*Some of these spells are based on the potions found in the
*proving grounds.
****/

/***** Healing Spells *****
* MinorHeal  1- 6
* MajorHeal  4-20
* TrueHeal   100
**************************/

define tp_magic proc se_Heal(thing spell; string name)bool:
  thing who;
  int max,now,heal;

  who := FindAgent(name);
  if who = nil then
    Print("There is no one here called '" + name + "'.\n");
  else
    max := who@p_pHitMax;
    now := who@p_pHitNow;
    if max = 0 then
      Print(name + " has no maximum hitpoints.\n");
    elif now = max then
      Print(name + " needs no healing.\n");
    else
      heal := parseDiceString(spell@p_sDice);
      if heal + now > max then
	heal := max - now;
      fi;
      who@p_pHitNow := now+heal;
      Print(name + " healed " + IntToString(heal)+ " hit points.\n");
      SPrint(who, FormatName(Me()@p_pName) + " has healed " + IntToString(heal)+ " hit points!\n");
    fi;
  fi;
  true
corp;

define tp_magic smm_Heal CreateThing(sm_DefaultSpell).
smm_Heal@p_sEffect:=se_Heal.
smm_Heal@p_sNull:="me".

define tp_magic sm_MinorHeal CreateThing(smm_Heal).
sm_MinorHeal@p_sDesc:="minor heal at <who> - heal <who> 1-6 hitpoints.".
sm_MinorHeal@p_sDice:="6+1".
sm_MinorHeal@p_sName:="heal;minor".
sm_MinorHeal@p_sCost:=2.
sm_MinorHeal@p_sLevel:=1.
sm_MinorHeal@p_sPotionDesc:="This potion is dark yellow.".
AddMangledName(sm_MinorHeal,langStandard).

define tp_magic sm_MajorHeal CreateThing(smm_Heal).
sm_MajorHeal@p_sDesc:="major heal at <who> - heal <who> 4-20 hitpoints.".
sm_MajorHeal@p_sDice:="5555+4".
sm_MajorHeal@p_sName:="heal;major".
sm_MajorHeal@p_sCost:=5.
sm_MajorHeal@p_sLevel:=2.
sm_MajorHeal@p_sPotionDesc:="This potion is yellow.".
AddMangledName(sm_MajorHeal,langStandard).

define tp_magic sm_TrueHeal CreateThing(smm_Heal).
sm_TrueHeal@p_sDesc:="true heal at <who> - heal <who> 100 hitpoints.".
sm_TrueHeal@p_sDice:="+100".
sm_TrueHeal@p_sName:="heal;true".
sm_TrueHeal@p_sCost:=10.
sm_TrueHeal@p_sLevel:=3.
sm_TrueHeal@p_sPotionDesc:="This potion is light yellow.".
AddMangledName(sm_TrueHeal,langStandard).

/***** Timer Spells *****
* SetTimer <seconds>
**************************/

define tp_magic proc TimerRing(thing spellCopy)void:
  thing who;

  who := spellCopy@p_sTarget;
  ClearThing(spellCopy);
  DelElement(who@p_pHiddenList, spellCopy);
  SPrint(who, "** BEEP BEEP BEEP **\n");
corp;

define tp_magic proc se_SetTimer(thing spell; string ta)bool:
  thing me,spare;
  int ti;

  ti := StringToInt(ta);
  me := Me();
  spare:=CreateThing(Parent(spell));
  spare@p_sTarget := me;
  DoAfter(ti, spare, TimerRing);
  AddTail(me@p_pHiddenList,spare);
  Print("You hear something ticking in your head.\n");
  true
corp;

define tp_magic sm_SetTimer CreateThing(sm_DefaultSpell).
sm_SetTimer@p_sDesc:="Set Timer on <seconds>.".
sm_SetTimer@p_sName:="timer;set".
sm_SetTimer@p_sCost:=1.
sm_SetTimer@p_sLevel:=1.
sm_SetTimer@p_sEffect:=se_SetTimer.
AddMangledName(sm_SetTimer,langStandard).


/***** Might Spells *****
* Might1 <who>
* Might2 <who>
**************************/

define tp_magic proc MightCancel(thing th)void:
  thing who;

  who := th@p_sTarget;
  who@p_pStrength := who@p_pStrength - th@p_sPower;
  ClearThing(th);
  DelElement(who@p_pHiddenList, th);
  SPrint(who, "You suddenly feel let down.\n");
corp;

define tp_magic proc se_Might(thing spell; string name)bool:
  thing who,spare;

  who := FindAgent(name);
  if who = nil then
    Print("There is no one here called '" + name + "'.\n");
  else
    spare:=CreateThing(Parent(spell));
    spare@p_sTarget := who;
    who@p_pStrength := who@p_pStrength + spare@p_sPower;
    SPrint(who,"You feel full of strength.\n");
    DoAfter(spare@p_sDuration, spare, MightCancel);
    AddTail(who@p_pHiddenList,spare);
  fi;
  true
corp;

define tp_magic sm_Might CreateThing(sm_DefaultSpell).
sm_Might@p_sEffect:=se_Might.
sm_Might@p_sNull:="me".
sm_Might@p_sDesc:="Might at <who>, enhances <who>'s strength for a short time.".
sm_Might@p_sName:="might;lesser".
sm_Might@p_sCost:=1.
sm_Might@p_sLevel:=1.
sm_Might@p_sPower:=1.
sm_Might@p_sDuration:=60.
sm_Might@p_sPotionDesc:="This potion is dark red.".
AddMangledName(sm_Might,langStandard).
define tp_magic sm_Might2 CreateThing(sm_Might).
sm_Might2@p_sName:="might2;lesser".
sm_Might2@p_sCost:=2.
sm_Might2@p_sLevel:=2.
sm_Might2@p_sDuration:=120.
sm_Might2@p_sPotionDesc:="This potion is red.".
AddMangledName(sm_Might2,langStandard).
define tp_magic sm_Might3 CreateThing(sm_Might2). /* inherit from Might2 */
sm_Might3@p_sName:="might;greater".
sm_Might3@p_sPower:=2.
sm_Might3@p_sCost:=5.
sm_Might3@p_sLevel:=3.
sm_Might3@p_sPotionDesc:="This potion is light red.".
AddMangledName(sm_Might3,langStandard).


/***** Speed Spells *****
* Speed  <who>
* Speed2 <who>
**************************/

define tp_magic proc SpeedCancel(thing th)void:
  thing who;

  who := th@p_sTarget;
  who@p_pSpeed := who@p_pSpeed - th@p_sPower;
  ClearThing(th);
  DelElement(who@p_pHiddenList, th);
  SPrint(who, "The world seems to speed up slightly.\n");
corp;

define tp_magic proc se_Speed(thing spell; string name)bool:
  thing who,spare;

  who := FindAgent(name);
  if who = nil then
    Print("There is no one here called '" + name + "'.\n");
  else
    spare:=CreateThing(Parent(spell));
    spare@p_sTarget := who;
    who@p_pSpeed := who@p_pSpeed + spare@p_sPower;
    SPrint(who,"You notice the world slow down slightly.\n");
    DoAfter(spare@p_sDuration, spare, SpeedCancel);
    AddTail(who@p_pHiddenList,spare);
  fi;
  true
corp;

define tp_magic sm_Speed CreateThing(sm_DefaultSpell).
sm_Speed@p_sNull:="me".
sm_Speed@p_sEffect:=se_Speed.
sm_Speed@p_sDesc:="speed at <who>, enhances <who>'s speed for a short time.".
sm_Speed@p_sName:="speed;lesser".
sm_Speed@p_sCost:=2.
sm_Speed@p_sLevel:=1.
sm_Speed@p_sPower:=1.
sm_Speed@p_sDuration:=60.
sm_Speed@p_sPotionDesc:="This potion is dark green.".
AddMangledName(sm_Speed,langStandard).
define tp_magic sm_Speed2 CreateThing(sm_Speed).
sm_Speed2@p_sName:="speed2;lesser".
sm_Speed2@p_sCost:=4.
sm_Speed2@p_sLevel:=2.
sm_Speed2@p_sDuration:=120.
sm_Speed2@p_sPotionDesc:="This potion is green.".
AddMangledName(sm_Speed2,langStandard).
define tp_magic sm_Speed3 CreateThing(sm_Speed2). /* inherit from Speed2 */
sm_Speed3@p_sName:="speed;greater".
sm_Speed3@p_sPower:=2.
sm_Speed3@p_sCost:=5.
sm_Speed3@p_sLevel:=4.
sm_Speed3@p_sPotionDesc:="This potion is light green.".
AddMangledName(sm_Speed3,langStandard).

/***** Endurance Spells *****
* Endurance <who>
* Endurance2 <who>
**************************/

define tp_magic proc EnduranceCancel(thing th)void:
  thing who;
  int m;

  who := th@p_sTarget;
  m:=who@p_pHitMax - th@p_sPower;
  who@p_pHitMax:=m;
  if who@p_pHitNow>m then
    who@p_pHitNow:=m;
  fi;
  ClearThing(th);
  DelElement(who@p_pHiddenList, th);
  SPrint(who, "The healthy glow vanishes.\n");
corp;

define tp_magic proc se_Endurance(thing spell; string name)bool:
  thing who,spare;

  who := FindAgent(name);
  if who = nil then
    Print("There is no one here called '" + name + "'.\n");
  else
    spare:=CreateThing(Parent(spell));
    spare@p_sTarget := who;
    who@p_pHitMax := who@p_pHitMax + spare@p_sPower;
    who@p_pHitNow := who@p_pHitNow + spare@p_sPower;
    SPrint(who,"You feel much more healthy.\n");
    DoAfter(spare@p_sDuration, spare, EnduranceCancel);
    AddTail(who@p_pHiddenList,spare);
  fi;
  true
corp;

define tp_magic sm_Endurance CreateThing(sm_DefaultSpell).
sm_Endurance@p_sNull:="me".
sm_Endurance@p_sEffect:=se_Endurance.
sm_Endurance@p_sDesc:="Endurance at <who>, enhances <who>'s endurance for a short time.".
sm_Endurance@p_sName:="endurance;lesser".
sm_Endurance@p_sCost:=2.
sm_Endurance@p_sLevel:=1.
sm_Endurance@p_sPower:=10.
sm_Endurance@p_sDuration:=60.
sm_Endurance@p_sPotionDesc:="This potion is dark blue.".
AddMangledName(sm_Endurance,langStandard).
define tp_magic sm_Endurance2 CreateThing(sm_Endurance).
sm_Endurance2@p_sName:="endurance2;lesser".
sm_Endurance2@p_sCost:=4.
sm_Endurance2@p_sLevel:=2.
sm_Endurance2@p_sDuration:=120.
sm_Endurance2@p_sPotionDesc:="This potion is blue.".
AddMangledName(sm_Endurance2,langStandard).
define tp_magic sm_Endurance3 CreateThing(sm_Endurance2). /* inherit from Endurance2 */
sm_Endurance3@p_sName:="endurance;greater".
sm_Endurance3@p_sPower:=20.
sm_Endurance3@p_sCost:=5.
sm_Endurance3@p_sLevel:=4.
sm_Endurance3@p_sPotionDesc:="This potion is light blue.".
AddMangledName(sm_Endurance3,langStandard).



/***** Light Spells *****
* Light  <what>
* Light2 <what>
**************************/

define tp_magic proc LightCancel(thing th)void:
  thing who;

  PassiveUnLightObject(th@p_sTarget);

  who := th@p_sCaster;
  ClearThing(th);
  DelElement(who@p_pHiddenList, th);
corp;

define tp_magic proc se_Light(thing spell; string name)bool:
  thing who,spare, me;
  status st;

  me:=Me();
  st:=FindName(me@p_pCarrying,p_oName,name);
  if st=fail then
    st:=FindName(Here()@p_rContents,p_oName,name);
  fi;
  if st=succeed then
    who:=FindResult();
    SetIt(who);
    st:=ActiveLightObject();
    if st=succeed then
      spare:=CreateThing(Parent(spell));
      spare@p_sTarget := who;
      spare@p_sCaster := me;
      DoAfter(spare@p_sDuration, spare, LightCancel);
      AddTail(me@p_pHiddenList,spare);
    fi;
    true
  elif st=continue then
    Print(name + " is ambiguous.\n");
    false
  else
    Print(AAn("There ","no " + name) + " here.\n");
    false
  fi
corp;

define tp_magic sm_Light CreateThing(sm_DefaultSpell).
sm_Light@p_sEffect:=se_Light.
sm_Light@p_sDesc:="Light on <what>, causes <what> to emit light for a short time.".
sm_Light@p_sName:="object;lesser,light".
sm_Light@p_sCost:=2.
sm_Light@p_sLevel:=1.
sm_Light@p_sDuration:=60.
AddMangledName(sm_Light,langStandard).
define tp_magic sm_Light2 CreateThing(sm_Light).
sm_Light2@p_sName:="object2;lesser,light".
sm_Light2@p_sCost:=6.
sm_Light2@p_sLevel:=3.
sm_Light2@p_sDuration:=120.
AddMangledName(sm_Light2,langStandard).


/**** End of file */
unuse tp_util2

