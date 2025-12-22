/*
 * magic/wand.m
 */


/**** Foreward
*This file contains the stuff required to handle wands.
****/

define tp_magic proc ReadWand()string:
  thing wand,me;

  wand:=It();
  me:=Me();

  if me@p_pLearnt~=nil then
    "The inscription reads '"+wand@p_sDesc+"'"
  else
    if wand@p_sMangled~="" then
      "The inscription reads '"+wand@p_sMangled+"'"
    else
      "The arcane symbols mean nothing to you"
    fi
  fi
corp;

/****
*Spell0ToWand creates a wand based on a spell model.
****/

define tp_magic proc Spell0ToWand(thing spell)thing:
  thing wand;

  wand:=CreateThing(spell);
  wand@p_oIsWand:=true;
  if spell@p_sWandName~="" then
    wand@p_oName:=spell@p_sWandName;
  else
    wand@p_oName:="wand;magic";
  fi;
  if spell@p_sWandDesc~="" then
    wand@p_oDesc:=spell@p_sWandDesc;
  else
    wand@p_oDesc:="The wand is about 6 inches long, and jet black.  It bears an small inscription on one end.";
  fi;
  wand@p_oReadAction:=ReadWand;
  wand@p_sCharges:=10;
  SetThingStatus(wand,ts_public);
  wand
corp;


/****
*SpellToWand() takes a spell found in memory or a grimoire, and
*creates a wand from it.
****/

define tp_magic proc SpellToWand(thing spell)thing:
  Spell0ToWand(Parent(spell))
corp;

/****
* Aim <wand> at <args>
****/

define tp_magic proc utility m_aim(string name, dest)bool:
  thing me,wand;
  string wandName;
  status st;
  action a;

  me:=Me();
  if me@p_pLearnt=nil then
    Print("You are not a mage!\n");
    false
  else
    wandName:=FormatName(name);
    st:=FindName(me@p_pCarrying,p_oName,name);
    if st = succeed then
      wand:=FindResult();
      if wand@p_oIsWand=true then
	if dest="?" then
	  Print(wand@p_sDesc + "\n");
	  false
	else
	  CastSpell(me@p_pLearnt,wand,dest)
	fi
      else
	Print("That is not a wand.\n");
	false
      fi
    elif st=continue then
      Print(wandName + " is ambiguous.\n");
      false
    else
      Print("You do not have that here.\n");
      false
    fi
  fi
corp;

Verb2(G, "aim", FindAnyWord(G, "at"), m_aim).


/**** End of file ****/

