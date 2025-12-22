/*
 * magic/scroll.m
 */

/**** Foreward
*This file contains all the stuff required to deal with scrolls,
*except copying spells from a scroll to a grimoire (handled by
*the scribe command in grimoire.m).  The creation code is called
*by the 'Scroll' spell in lists-mana.m.
****/

/****
*ReadScroll() tells you what spell is written on a scroll.  It
*is called by a read checker, when you type : read <scroll>
*To actually cast it, see the read verb below.
****/

define tp_magic proc ReadScroll()string:
  thing spell;

  spell:=It();
  if Me()@p_pLearnt=nil then
    if spell@p_sMangled~="" then
      "The scroll is entitled '"+spell@p_sMangled+"'."
    else
      "The arcane symbols make no sense to you"
    fi
  else
    if spell@p_sEffect=nil then
      "The scroll is blank"
    else
      "This is a scroll of '" + FormatName(spell@p_sName) + "'.\nUsage : " + spell@p_sDesc
    fi
  fi
corp;


/****
*Spell0ToScroll creates a scroll based on a spell model.
*This procedure is likely to expand to give more descriptions.
*This procedure should usually be called from SpellToScroll, but
*has been provided to save SysAdmin the trouble of creating a
*descendant of a spell model to create a scroll.
*Compare to Spell0ToPotion.
****/


define tp_magic proc Spell0ToScroll(thing spell)thing:
  thing scroll;
  scroll:=CreateThing(spell);
  scroll@p_oIsScroll:=true;
  scroll@p_oReadAction:=ReadScroll;
  scroll@p_oName:="scroll;magic";
  scroll@p_oDesc:="The scroll is made of some brown fiberous material.";
  SetThingStatus(scroll,ts_public);
  scroll
corp;


/****
*SpellToScroll() takes a spell found in memory or a grimoire, and
*creates a scrollfrom it.  The spells found in memory or a grimoire
*are just empty things with a spell model as an ancestor, so
*I just cheat, and call Spell0ToScroll on the parent.
*Compare to SpellToPotion
****/

define tp_magic proc SpellToScroll(thing spell)thing:
  Spell0ToScroll(Parent(spell))
corp;

/**** Verbs
*This read verb is used when casting the spell on a scroll.
*It takes the form : read <scroll> ( at | to | on ) <target> [other args]
****/

define tp_magic proc m_read(string scrollName, dest)bool:
  thing me,spell;
  string fScrollName;
  status st;
  action a;

  me:=Me();
  if me@p_pLearnt=nil then
    Print("You are not a mage!\n");
    false
  else
    fScrollName:=FormatName(scrollName);
    st:=FindName(me@p_pCarrying,p_oName,scrollName);
    if st = succeed then
      spell:=FindResult();
      if dest="?" then
	Print(spell@p_sDesc + "\n");
	false
      else
	CastSpell(me@p_pCarrying,spell,dest)
      fi
    elif st=continue then
      Print(scrollName + " is ambiguous.\n");
      false
    else
      Print(AAn("You do not have",scrollName) +"\n");
      false
    fi
  fi
corp;
Verb2(G, "read", FindAnyWord(G, "at"), m_read).
Verb2(G, "read", FindAnyWord(G, "to"), m_read).
Verb2(G, "read", FindAnyWord(G, "on"), m_read).

/**** End of file ****/

