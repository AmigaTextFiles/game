/*
* magic/Character.m
*/

/****
*This defines everything needed to deal with the player side
*of magic.  i.e. mana recovery, casting spells etc...
****/

/****
*recoverManaCheck() is the magic counterpart to MonsterEnterCheck()
*for fighting.  It handles recovery of mana.
*
*Note: IMHO, recovery of mana and hp should be time based,
*not step based, but I've implemented it like this for consistency.
****/

define tp_magic proc recoverManaCheck()status:
  thing me;
  int i;

  me := Me();
  i := 1+me@p_pManaAux;
  if i >= STEPS_PER_REGAINED_MANA_POINT then
    i := me@p_pManaNow;
    if i < me@p_pManaMax then
      me@p_pManaNow := i + 1;
    fi;
    i := 0;
  fi;
  me@p_pManaAux := i;
  continue
corp;

/****
*showStatsMage() displays the current mana and max mana points
****/

define tp_magic proc showStatsMage(thing theCharacter; bool forceLong)void:
  Print("Magic> Mana: ");
  IPrint(theCharacter@p_pManaNow);
  Print("/");
  IPrint(theCharacter@p_pManaMax);
  Print("\n");
corp.


/****
*InitMage() is the magic equivalent to InitFighter() for combat.
*It sets up the character with 10 mana points, installs the mana
*recovery checker, and gives them a fresh spell list (with no
*spells memorized)
*
*When cast on an object, it just sets up en empty spell list.
*This feature is not yet used.
****/

define tp_magic proc InitMage(thing mage)void:
  string name;
  thing me;

  if mage@p_pLearnt = nil then
    me:=Me();
    mage@p_pLearnt  := CreateThingList();
    if mage@p_pTextColours~=nil then    /* is a machine/character */
      mage@p_pManaMax := 10;
      mage@p_pManaNow := 10;
      mage@p_pManaAux := 0;
      AddPlayerEnterChecker(mage, recoverManaCheck, false);
      AddStatAction(mage, showStatsMage, false);
      SPrint(mage,"You feel your head rush.  Your heart begins to race.  "
	    "Your mind is filled with voices, talking, testing.  Your "
	    "skin tingles with electricity.  A distant gateway opens, "
	    "releasing a wave of arcane lore, striking your puny body, "
	    "crashing, coursing through your body, invading your very "
	    "essence.\n\nAnd when the assault finally subsides, you open "
	    "your eyes to see the world in a new light.  You are a mage.\n");
      if me~=mage then
	SPrint(mage,"Somewhere, someone smiles.\n");
	Print(FormatName(mage@p_pName) + " is now ready to learn spells.\n");
      fi;
    else    /* is an object */
      Print("The " + FormatName(mage@p_oName) + " is now ready to store magic spells.\n");
    fi;
  else
    Print("But " + FormatName(mage@p_pName) + " is already a mage!\n");
  fi;
corp;


/****
*GrantSpellRaw() adds a spell to a spell list (in memory, or on an object)
*It was an early version, and has been superceeded by the learn verb.
*I'll delete it when I'm sure its no longer needed.  For now, dont use it.
****/

define tp_magic proc GrantSpellRaw(thing who; string name;
      action effect; int cost, level; int charges)bool:
  thing spell;
  if who@p_pLearnt = nil then
    Print(who@p_pName + " cannot learn spells\n");
    false
  else
    spell:=CreateThing(nil);
    spell@p_sName    := name;
    if effect ~= nil then
      spell@p_sEffect  := effect;
    fi;
    spell@p_sCost    := cost;
    spell@p_sLevel   := level;
    spell@p_sCharges := charges;
    if charges<0 then
      AddHead(who@p_pLearnt,spell);
    else
      AddTail(who@p_pLearnt,spell);
    fi;
    Print(who@p_pName + " now knows the spell '" + FormatName(spell@p_sName) + "'.\n");
    true
  fi
corp;

/****
*GrantSpell() adds a spell to a spell list.  It differs from
*GrantSpellRaw by using predefined spell models.  I am thinking
*of using this as a model for a "Teacher" spell which will allow
*one mage to give a spell directly to another player.
*This might be useful for a SysAdmin or wizard who wants to pass
*on a spell without placing it in a grimoire.  Alternatively,
*in some magic systems, grimoires do not exists, and spells must
*be handed from player to player, master to apprentice...
****/

define tp_magic proc GrantSpell(thing who, spell)bool:
  if who@p_pLearnt = nil then
    Print(who@p_pName + " cannot learn spells\n");
    false
  else
    if spell@p_sCharges<0 then
      AddHead(who@p_pLearnt,CreateThing(spell));
    else
      AddTail(who@p_pLearnt,CreateThing(spell));
    fi;
    Print(who@p_pName + " now knows the spell '" + FormatName(spell@p_sName) + "'.\n");
    true
  fi
corp;


/****
*RevokeSpell() is the opposite of GrantSpell.  It removes one
*occurrance of a spell from someone elses memory.  It was used
*in the early stages of development, but might resurface as a
*spell later.  See GrantSpell above.
****/

define tp_magic proc RevokeSpell(thing who; string name)bool:
  thing spell;
  string spellName;
  status st;

  if who@p_pLearnt = nil then
    Print(who@p_pName + " cannot learn spells\n");
    false
  else
    spellName:=FormatName(name);
    st:=FindName(who@p_pLearnt,p_sName,spellName);
    if st=fail then
      Print(who@p_pName + " does not know that spell\n");
      false
    else
      spell:=FindResult();
      ClearThing(spell);
      DelElement(who@p_pLearnt,spell);
      if st=succeed then
	Print("Spell removed\n");
      else
	Print("First spell removed\n");
      fi;
      true
    fi
  fi
corp;


/****
*ListSpells displays the spells in someones memory.
*Originally, I wanted to have the same procedure for players, and
*grimoires, but grimoires are now hierarchical, so its only used
*on players.  I may inline it into the v_mlist verb routine.  Not
*done yet, as I may need it for staves and wands...
****/

define tp_magic proc ListSpells(thing who)status:
  thing spell;
  int count,i;

  if who@p_pLearnt = nil then
    Print(who@p_pName + " cannot learn spells.\n");
    fail
  else
    count:=Count(who@p_pLearnt);

    if count>0 then
      Print(who@p_pName + " knows the following " + IntToString(count) + " spells :-\n");
      for i from 0 upto count-1 do
	spell:=who@p_pLearnt[i];
	if spell@p_sCharges<0 then
	  Print(" ** ");
	else
	  Print(StringReplace("    ",1,IntToString(spell@p_sCharges)));
	fi;
	Print(StringReplace("    ",1,IntToString(spell@p_sLevel)));
	Print(StringReplace("    ",1,IntToString(spell@p_sCost)));
	Print(FormatName(spell@p_sName) + "\n");
      od;
      succeed
    else
      Print("You have no spells memorized\n");
      continue
    fi
  fi
corp;


/****
*CastSpell() does lots of checks prior to casting a spell;
*calls the spell effect routine; decrements mana level;
*and removes it from memory if necessary.
****/

define tp_magic proc CastSpell(list thing lt; thing spell; string dest)bool:
  bool b;
  thing me,here;
  int charges;
  status st;

  me:=Me();
  here:=Here();
  b:=false;

  SetIt(spell);

  if here@p_sCastChecks~=nil then
    st:=DoChecks(here@p_sCastChecks);
  else
    st:=continue;
  fi;

  if st=continue and me@p_sCastChecks~=nil then
    st:=DoChecks(me@p_sCastChecks);
  fi;

  if st=continue then
    if spell@p_sCost > me@p_pManaNow then
      Print("You do not have enough mana to cast that spell\n");
      st:=fail;
    fi;
  fi;

  if st=continue then
    if spell@p_sCharges=0 then
      Print("There are no charges remaining.\n");
      st:=fail;
    fi;
  fi;

  if st=continue then
    if me@p_sCastChecks~=nil then
      st:=DoChecks(here@p_sCastChecks);
    fi;
  fi;

  if st=continue then
    if spell@p_sEffect ~= nil then
      b:=call(spell@p_sEffect, bool)(spell,dest);
      if b=true then
	me@p_pManaNow := me@p_pManaNow-spell@p_sCost;
	charges:=spell@p_sCharges;
	if charges>0 then
	  charges:=charges-1;
	  if charges=0 and lt~=nil then
	    ClearThing(spell);
	    DelElement(lt,spell);
	  else
	    spell@p_sCharges:=charges;
	  fi;
	fi;
      else
	b:=true;
      fi;
    fi;
  fi;

  b
corp;

/**** Verbs
*mlist : displays memorized spells
*mcast : cast a spell from memory
*see other files for other verbs
****/

define tp_magic proc m_list()bool:
  ignore ListSpells(Me());
  true
corp;
VerbTail(G, "mlist", m_list).


define tp_magic proc utility m_cast(string name, dest)bool:
  thing me,spell;
  string spellName;
  status st;
  action a;

  me:=Me();
  if me@p_pLearnt=nil then
    Print("You are not a mage!\n");
    false
  else
    spellName:=FormatName(name);
    st:=FindName(me@p_pLearnt,p_sName,name);
    if st = succeed then
      spell:=FindResult();
      if dest="?" then
	Print(spell@p_sDesc + "\n");
	false
      else
	CastSpell(me@p_pLearnt,spell,dest)
      fi
    elif st=continue then
      Print(spellName + " is ambiguous.\n");
      false
    else
      if IsProgrammer()=true then
	a := LookupAction(nil, name);
	if a ~= nil then
	  SetTail(dest);
	  call(a, void)();
	  true
	else
	  Print(AAn("You do not have",spellName)+" spell memorized.\n");
	  false
	fi
      else
	Print("You do not know any spell called " + spellName + ".\n");
	false
      fi
    fi
  fi
corp;

Verb2(G, "mcast", FindAnyWord(G, "at"), m_cast).
Verb2(G, "mcast", FindAnyWord(G, "to"), m_cast).
Verb2(G, "mcast", FindAnyWord(G, "on"), m_cast).

/* To replace the standard CAST verb with mine, uncomment the lines below */
/*
DeleteWord(G,"cast").
DeleteSymbol(LookupTable(PrivateTable(),"tp_verbs"),"v_cast").
Verb2(G, "cast", FindAnyWord(G, "at"), m_cast).
Verb2(G, "cast", FindAnyWord(G, "to"), m_cast).
Verb2(G, "cast", FindAnyWord(G, "on"), m_cast).
DeleteWord(G,"mcast").  note : alternatively, remove the three Verb2 commands!
*/


