/*
 * magic/checker.m
 */

/************* Spell Checkers ************/

/** c_lLevel
*Meant for learn check on spell, makes sure you 
*cannot learn  a spell above your level.
**/

define tp_magic proc c_lLevel()status:
  thing me,spell;
  me:=Me();
  spell:=It();
  if me@p_pLevel >= spell@p_sLevel then
    continue
  else
    if IsWizard() then
      Print("You are too low level to do that, but as a wizard, I'll let you off.\n");
      continue
    else
      Print("You are too low level to do that.\n");
      fail
    fi
  fi
corp.


/** c_lWizard
*Meant for learn check on spells, makes sure that
*only wizards can learn this spell.
**/

define tp_magic proc c_lWizard()status:
 if IsProgrammer() then
    continue
  else
    Print("Sorry, this spell is for wizards only.\n");
    fail
  fi
corp.


/** c_rNoMagic
*sc_Magic is meant for room cast checkers.  It prevents all
*magic being cast.
**/

define tp_magic proc c_rNoMagic()status:
  Print("No magic may be cast in this room.\n");
  fail
corp.

/***** Checker stuff (public) ****/
/*** All of this section is under development - not use yet ****/

use tp_base

public proc utility AddCastChecker(thing th; action a; bool front)void:
  addChecker(th, p_sCastChecks, a, front);
corp.
public proc utility DelCastChecker(thing th; action a; bool front)void:
  delChecker(th, p_sCastChecks, a);
corp.

public proc utility AddLearnChecker(thing th; action a; bool front)void:
  addChecker(th, p_sLearnChecks, a, front);
corp.
public proc utility DelLearnChecker(thing th; action a; bool front)void:
  delChecker(th, p_sLearnChecks, a);
corp.

public proc utility AddScribeChecker(thing th; action a; bool front)void:
  addChecker(th, p_sScribeChecks, a, front);
corp.
public proc utility DelScribeChecker(thing th; action a; bool front)void:
  delChecker(th, p_sScribeChecks, a);
corp.

unuse tp_base

/*************  Spell Templates ************/

define tp_magic proc se_Default(thing spell; string arg)bool:
  Print("There is a slight tingling as the magic is released.\n");
  true
corp.

define tp_magic sm_DefaultSpell CreateThing(nil).
sm_DefaultSpell@p_sDesc:="Does nothing".
sm_DefaultSpell@p_sDice:="+0".
sm_DefaultSpell@p_sName:="Default".
sm_DefaultSpell@p_sCost:=0.
sm_DefaultSpell@p_sLevel:=0.
sm_DefaultSpell@p_sEffect:=se_Default.
AddLearnChecker(sm_DefaultSpell, c_lLevel, false).

define tp_magic sm_DefaultWSpell CreateThing(sm_DefaultSpell).
sm_DefaultWSpell@p_sLearnChecks:=CreateActionList().
AddLearnChecker(sm_DefaultWSpell, c_lWizard, false).

