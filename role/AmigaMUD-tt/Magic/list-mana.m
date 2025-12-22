/*
 * magic/list-mana.m Magic spells about magic
 */

/**** Foreward
*This contains spells that handle magic and magic items, such
*as the Scroll spell, and the Grant Magery spell.  Some of these
*are currently wizard only (eg. Grant Magery).  Treat these with care.
****/


/***** Scroll Spells *****
* Create Scroll <spell>
**************************/

define tp_magic proc se_Scroll(thing spellMe; string spellName)bool:
  thing me, scroll, spell;
  string fSpellName;
  status st;
  int charges;

  me:=Me();
  fSpellName:=FormatName(spellName);
  st:=FindName(me@p_pLearnt,p_sName,spellName);
  if st = succeed then
    spell:=FindResult();
    if spellName="?" then
      Print(spellMe@p_sDesc + "\n");
      false
    else
      scroll:=SpellToScroll(spell);
      charges:=spell@p_sCharges;
      if charges=1 then
	DelElement(me@p_pLearnt,spell);
      elif charges>1 then
	spell@p_sCharges:=charges-1;
      fi;
      scroll@p_oCarryer:=me;
      AddTail(me@p_pCarrying,scroll);
      Print("You are now carrying a new scroll\n");
      true
    fi
  elif st=continue then
    Print(spellName + " is ambiguous.\n");
    false
  else
    Print("You do not know any spells named "+spellName+".\n");
    false
  fi
corp;

define tp_magic sm_Scroll CreateThing(sm_DefaultSpell).
sm_Scroll@p_sDesc:="Create Scroll on <spell>.".
sm_Scroll@p_sName:="scroll;create".
sm_Scroll@p_sCost:=2.
sm_Scroll@p_sLevel:=2.
sm_Scroll@p_sEffect:=se_Scroll.
AddMangledName(sm_Scroll,langStandard).

/***** Potion Spell *****
* Create Potion <spell>
**************************/

define tp_magic proc se_Potion(thing spellMe; string spellName)bool:
  thing me, potion, spell;
  string fSpellName;
  status st;
  int charges;

  me:=Me();
  fSpellName:=FormatName(spellName);
  st:=FindName(me@p_pLearnt,p_sName,spellName);
  if st = succeed then
    spell:=FindResult();
    if spellName="?" then
      Print(spellMe@p_sDesc + "\n");
      false
    else
      potion:=SpellToPotion(spell);
      if potion~=nil then
	charges:=spell@p_sCharges;
	if charges=1 then
	  DelElement(me@p_pLearnt,spell);
	elif charges>1 then
	  spell@p_sCharges:=charges-1;
	fi;
	if CarryItem(potion) then
	  Print(AAn("You are now carrying",FormatName(potion@p_oName)) + ".\n");
	  if not me@p_pHidden and CanSee(Here(),me) then
	    OPrint(FormatName(me@p_pName)+AAn(" guestures arcanely, and creates",FormatName(potion@p_oName)) + ".\n");
	  fi;
	else
	  AddTail(Here()@p_rContents,potion);
	  Print(AAn("You have created" , FormatName(potion@p_oName)) + " and dropped it.\n");
	  if not me@p_pHidden and CanSee(Here(),me) then
	    OPrint(FormatName(me@p_pName)+AAn(" guestures arcanely, and creates", FormatName(potion@p_oName)) + " on the floor.\n");
	  else
	    OPrint(AAn("",FormatName(potion@p_oName)) + " appears on the floor.\n");
	  fi;
	fi;
	true
      else
	Print("The " + FormatName(spell@p_sName) + " spell does not have a potion form.\n");
	false
      fi
    fi
  elif st=continue then
    Print(spellName + " is ambiguous.\n");
    false
  else
    Print("You do not know any spells named "+spellName+".\n");
    false
  fi
corp;

define tp_magic sm_Potion CreateThing(sm_DefaultSpell).
sm_Potion@p_sDesc:="create potion on <spell>.".
sm_Potion@p_sName:="potion;create".
sm_Potion@p_sCost:=6.
sm_Potion@p_sLevel:=6.
sm_Potion@p_sEffect:=se_Potion.
AddMangledName(sm_Potion,langStandard).


/***** Wand Spells *****
* Create Wand <spell>
**************************/

define tp_magic proc se_Wand(thing spellMe; string spellName)bool:
  thing me, Wand, spell;
  string fSpellName;
  status st;
  int charges;

  me:=Me();
  fSpellName:=FormatName(spellName);
  st:=FindName(me@p_pLearnt,p_sName,spellName);
  if st = succeed then
    spell:=FindResult();
    if spellName="?" then
      Print(spellMe@p_sDesc + "\n");
      false
    else
      Wand:=SpellToWand(spell);
      charges:=spell@p_sCharges;
      if charges=1 then
	DelElement(me@p_pLearnt,spell);
      elif charges>1 then
	spell@p_sCharges:=charges-1;
      fi;
      Wand@p_oCarryer:=me;
      AddTail(me@p_pCarrying,Wand);
      Print("You are now carrying a new Wand\n");
      true
    fi
  elif st=continue then
    Print(spellName + " is ambiguous.\n");
    false
  else
    Print("You do not know any spells named "+spellName+".\n");
    false
  fi
corp;

define tp_magic sm_Wand CreateThing(sm_DefaultSpell).
sm_Wand@p_sDesc:="Create Wand on <spell>.".
sm_Wand@p_sName:="Wand;create".
sm_Wand@p_sCost:=20.
sm_Wand@p_sLevel:=8.
sm_Wand@p_sEffect:=se_Wand.
AddMangledName(sm_Wand,langStandard).


/**** grant magery *****
* enables magic for <who|what>
***************/

define tp_magic proc se_GrantMagery(thing spell; string name)bool:
  thing who;

  who:=NameToThing(name);
  if who = nil then
    Print("There is no character or machine called '" + name + "'.\n");
  else
    InitMage(who);
  fi;
  true
corp;

define tp_magic sm_GrantMagery CreateThing(sm_DefaultWSpell).
sm_GrantMagery@p_sName:="magery;grant".
sm_GrantMagery@p_sEffect:=se_GrantMagery.
sm_GrantMagery@p_sDesc:="grant magery to <who>".
sm_GrantMagery@p_sNull:="me".
sm_GrantMagery@p_sPotionDesc:="This potion is mostly clear, except for the "
    "numerous colored bubbles that appear, and rise to the surface.\n".
AddMangledName(sm_GrantMagery,langStandard).


/***** MemLock Spell *****
* Mem Lock <spell>
**************************/

define tp_magic proc se_MemLock(thing spellMe; string spellName)bool:
  thing me, scroll, spell;
  string fSpellName;
  status st;
  int charges;

  me:=Me();
  fSpellName:=FormatName(spellName);
  st:=FindName(me@p_pLearnt,p_sName,spellName);
  if st = succeed then
    spell:=FindResult();
    if spellName="?" then
      Print(spellMe@p_sDesc + "\n");
      false
    else
      charges:=spell@p_sCharges;
      if charges<0 then
	spell@p_sCharges:=1;
	Print(fSpellName + " is now unlocked - you have one charge\n");
      else
	spell@p_sCharges:=-1;
	Print(fSpellName + " is now locked\n");
      fi;
      true
    fi
  elif st=continue then
    Print(spellName + " is ambiguous.\n");
    false
  else
    Print("You do not know any spells named "+spellName+".\n");
    false
  fi
corp;

define tp_magic sm_MemLock CreateThing(sm_DefaultWSpell).
sm_MemLock@p_sDesc:="Mem Lock on <spell>.".
sm_MemLock@p_sName:="lock;mem".
sm_MemLock@p_sCost:=0.
sm_MemLock@p_sLevel:=0.
sm_MemLock@p_sEffect:=se_MemLock.
AddMangledName(sm_MemLock,langStandard).


/***** Restore Mana Spells *****
* Restore Mana <who>
**************************/

define tp_magic proc se_RestoreMana(thing spell; string name)bool:
  thing who;
  int m,n,d;

  who:=NameToThing(name);
  if who = nil then
    Print("There is no character or machine called '" + name + "'.\n");
  else
    m:=who@p_pManaMax;
    if m=0 then
      Print(FormatName(who@p_pName) + " has no mana.\n");
    else
      n:=who@p_pManaNow;
      d:=spell@p_sPower;
      if d+n>m then
	d:=m-n;
      fi;
      who@p_pManaNow:=n+d;
      if who=Me() then
	Print("You have regained " + IntToString(d) + " Mana Points.\n");
      else
	SPrint(who,FormatName(Me()@p_pName) + " has restored " + IntToString(d) + " Mana Points to you.\n");
	Print("You have restored " + IntToString(d) + " Mana Points to " + FormatName(who@p_pName) + ".\n");
      fi;
    fi;
  fi;
  true
corp;

define tp_magic sm_RestoreMana CreateThing(sm_DefaultWSpell).
sm_RestoreMana@p_sEffect:=se_GrantMagery.
sm_RestoreMana@p_sNull:="me".
sm_RestoreMana@p_sPotionDesc:="This translucent potion contains many multi "
    "coloured streaks which seem to dance and intertwine.".
sm_RestoreMana@p_sDesc:="restore mana to <who>; restores some mana.".
sm_RestoreMana@p_sName:="mana;lesser,restore".
sm_RestoreMana@p_sPower:=5.
AddMangledName(sm_RestoreMana,langStandard).
define tp_magic sm_RestoreMana2 CreateThing(sm_RestoreMana).
sm_RestoreMana2@p_sName:="mana;greater,restore".
sm_RestoreMana2@p_sPower:=10.
AddMangledName(sm_RestoreMana2,langStandard).


/**** End of file */

