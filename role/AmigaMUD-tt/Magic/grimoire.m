/*
 * magic/grimoire.m - Grimoire items
 */

/****
*SearchGrimoire() determines whether a given spell is available
*in a grimoire.  It returns the found spell.  The reason this is
*a seperate procedure is that in the first relase, grimoires were
*hierarchical.  Later, I decided this was complete nonsense.
****/

define tp_magic proc SearchGrimoire(thing book; string spellName)thing:
  status st;

  st := FindName(book@p_pLearnt,p_sName,spellName);
  if st ~= fail then
    FindResult()
  else
    nil
  fi
corp.


/****
*ReadGrimoire() lists the spells in a grimoire.  This is
*a seperate procedure because grimoires used to be hierarchical.
*Note: this is called via a read checker, rather than a new command.
****/

define tp_magic proc ReadGrimoire()string:
  thing book,spell;
  status st;
  int count, i, sections, nospells;

  if Me()@p_pLearnt=nil then
    "Alas, the arcane language makes no sense to you!"
  else
    book:=It();
    nospells:=0;
    sections:=0;
    if book@p_oIsGrimoire then
      count:=Count(book@p_pLearnt);
      if count>0 then
	Print("The grimoire contains knows the following " + IntToString(count) + " spells :-\n");
	for i from 0 upto count-1 do
	  spell:=book@p_pLearnt[i];
	  if spell@p_sCharges<0 then
	    Print(" ** ");
	  else
	    Print(StringReplace("    ",1,IntToString(spell@p_sCharges)));
	  fi;
	  Print(StringReplace("    ",1,IntToString(spell@p_sLevel)));
	  Print(StringReplace("    ",1,IntToString(spell@p_sCost)));
	  Print(FormatName(spell@p_sName) + "\n");
	od;
	" "
      else
	"The grimoire is empty"
      fi
    else
      "This is not a grimoire"
    fi
  fi
corp.


/****
*MakeGrimoire() creates a new grimoire ready to store spells.
*The new grimoire will only contain spells inherited from
*other "template" grimoires.  You MUST use this procedure
*instead of creating a thing based on the template grimoire
*since grimoires are hierarchical.  You have been warned!
****/

define tp_magic proc MakeGrimoire(thing template)thing:
  thing spare;

  spare:=CreateThing(template);
  spare@p_pLearnt:=CloneThingList(template@p_pLearnt);
  SetThingStatus(spare,ts_public);
  spare
corp.


/****
*"Standard" grimoire templates.  Created for testing purposes.
****/

/* Grimoire template */
define tp_magic o_grimoire CreateThing(nil).
o_grimoire@p_oReadAction:=ReadGrimoire.
o_grimoire@p_pLearnt:=CreateThingList(). note tst this isnt needed anymore
o_grimoire@p_oName:="grimoire,book,tome;magic".
o_grimoire@p_oIsGrimoire:=true.

/* Wizards Grimoire template */
define tp_magic o_grimoire0 CreateThing(o_grimoire).
o_grimoire0@p_pLearnt:=CreateThingList().
o_grimoire0@p_oName:="grimoire,book,tome;powerful,magic".
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_DFind)).
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_DPoof)).
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_DLook)).
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_DHeal)).
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_ObjectClone)).
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_DSend)).
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_DForce)).
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_DTeleport)).
AddTail(o_grimoire0@p_pLearnt,CreateThing(sm_DWhere)).

/* Mortals grimoire template */
define tp_magic o_grimoire1 CreateThing(o_grimoire).
o_grimoire1@p_pLearnt:=CreateThingList().
o_grimoire1@p_oName:="grimoire,book,tome;blue,magic".
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_MinorHeal)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_MajorHeal)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_TrueHeal)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_SetTimer)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Might)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Might2)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Might3)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Speed)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Speed2)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Speed3)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Endurance)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Endurance2)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Endurance3)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Light)).
AddTail(o_grimoire1@p_pLearnt,CreateThing(sm_Light2)).

/* Mana grimoire template */
define tp_magic o_grimoire2 CreateThing(o_grimoire).
o_grimoire2@p_pLearnt:=CreateThingList().
o_grimoire2@p_oName:="grimoire,book,tome;red,magic".
AddTail(o_grimoire2@p_pLearnt,CreateThing(sm_Scroll)).
AddTail(o_grimoire2@p_pLearnt,CreateThing(sm_Potion)).
AddTail(o_grimoire2@p_pLearnt,CreateThing(sm_Wand)).
AddTail(o_grimoire2@p_pLearnt,CreateThing(sm_MemLock)).
AddTail(o_grimoire2@p_pLearnt,CreateThing(sm_GrantMagery)).
AddTail(o_grimoire2@p_pLearnt,CreateThing(sm_RestoreMana)).
AddTail(o_grimoire2@p_pLearnt,CreateThing(sm_RestoreMana2)).


/**** Verbs
*mlearn : commit a spell to memory from a grimoire
*scribe : transfer a spell on a scroll into a grimoire
****/

define tp_magic proc m_learn(string spell, sour)bool:
  string sourName;
  status st;
  thing me, here, item, theSpell,t;
  action act;
  character ch;

  me := Me();
  if me@p_pLearnt=nil then
    false
  else
    here := Here();
    sourName  := FormatName(sour);

    /* locate source */
    st := FindName(me@p_pCarrying, p_oName, sour);
    if st=succeed then
      item := FindResult();
      if item@p_pLearnt ~= nil then
	theSpell:=SearchGrimoire(item,spell);
	if theSpell ~= nil then
	  SetIt(theSpell);
	  if theSpell@p_sLearnChecks~=nil then
	    st := DoChecks(theSpell@p_sLearnChecks);
	  else
	    st := continue;
	  fi;
	  if st=continue then
	    /* check to see if you already have one in memory */
	    if true=FindChildOnList(me@p_pLearnt,Parent(theSpell)) then
	      t:=FindResult();
	      if t@p_sCharges<1 then
		Print("But you already have that spell PERMANENTLY memorized!\n");
		false
	      else
		t@p_sCharges:=t@p_sCharges+1;
		Print("You now have the " + FormatName(theSpell@p_sName) + " spell memorized " + IntToString(t@p_sCharges) + " times.\n");
		true
	      fi
	    else
	      t:=CreateThing(Parent(theSpell));
	      t@p_sCharges:=1;
	      AddTail(me@p_pLearnt,t);
	      Print("You have learnt the " + FormatName(theSpell@p_sName) + " spell.\n");
	      true
	    fi
	  else
	    false
	  fi
	elif st = continue then
	  Print(FormatName(spell) + " is ambiguous.\n");
	  false
	else
	  Print(AAn(sourName + " does not contain",FormatName(spell)) + " spell.\n");
	  false
	fi
      else
	Print(AAn("You can not learn spells from",sourName) +"!\n");
	false
      fi
    elif st=continue then
      Print(sourName + " is ambiguous.\n");
      false
    else
      if MatchName(here@p_rScenery, sour) ~= -1 then
	Print("You can't learn spells from the scenery!\n");
      else
	Print("There is no " + sourName + " here!\n");
     fi;
     false
    fi
  fi
corp.

Verb2(G, "mlearn", FindAnyWord(G, "from"), m_learn).

define tp_magic proc m_scribe(string scrollName, dest)bool:
  thing me,spell,book;
  status st;

  me:=Me();
  if me@p_pLearnt=nil then
    Print("You are not a mage!\n");
    false
  else
    /* look for scroll */
    st:=FindName(me@p_pCarrying,p_oName,scrollName);
    if st = succeed then
      spell:=FindResult();
      if dest="?" then
	Print("Scribe <spell> to <grimoire>.\n");
	false
      else
	/* look for grimoire */
	st:=FindName(me@p_pCarrying,p_oName,dest);
	if st=succeed then
	  book:=FindResult();
	  if book@p_oIsGrimoire=true then
	    AddTail( book@p_pLearnt, CreateThing(Parent(spell)) );
	    ClearThing(spell);
	    DelElement(me@p_pCarrying,spell);
	    Print("You carefully scribe the scroll into your grimoire.\n");
	    true
	  else
	    Print(dest + " is not a grimoire.\n");
	    false
	  fi
	elif st=continue then
	  Print(dest + " is ambiguous.\n");
	  false
	else
	  Print(AAn("You do not have",dest) +"\n");
	  false
	fi
      fi
    elif st=continue then
      Print(scrollName + " is ambiguous.\n");
      false
    else
      Print(AAn("You do not have",scrollName) +"\n");
      false
    fi
  fi
corp.
Verb2(G, "scribe", FindAnyWord(G, "in"), m_scribe).
Verb2(G, "scribe", FindAnyWord(G, "to"), m_scribe).
Verb2(G, "scribe", FindAnyWord(G, "on"), m_scribe).

/**** End of file ****/

