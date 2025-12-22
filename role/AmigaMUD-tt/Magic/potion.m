/*
 * magic/potion.m
 */

/**** Foreward
*This file contains the stuff required to handle potions.
*So far, this is DrinkPotion, and two SpellToPotion procedures.
****/

/****
* DrinkPotion() : The drink checker, that calls the spell effect.
****/

define tp_magic proc DrinkPotion()status:
  thing potion;
  bool b;
  list thing lt;

  potion:=It();
  if potion@p_sEffect ~= nil then
    b:=call(potion@p_sEffect, bool)(potion,potion@p_sNull);
    if b=true then
      lt:=Me()@p_pCarrying;
      if FindElement(lt,potion) = -1 then
	lt:=Here()@p_rContents;
	if FindElement(lt,potion) =-1 then
	  lt:=nil;
	fi;
      fi;
      if lt~=nil then
	ClearThing(potion);
	DelElement(lt,potion);
      fi;
    fi;
  fi;
  succeed
corp;


/****
*Spell0ToPotion creates a potion based on a spell model.
*It also checks to see that the spell does have a potion form,
*and modifies the descriptions accordingly.  This procedure is
*likely to expand to give more descriptions, such as taste etc...
*This procedure should usually be called from SpellToPotion, but
*has been provided to save SysAdmin the trouble of creating a
*descendant of a spell model to create a potion.
*Compare to Spell0ToScroll
****/

define tp_magic proc Spell0ToPotion(thing spell)thing:
  thing potion;
  note : if a spell has no PotionDesc, it cannot be turned into a potion
  if spell@p_sPotionDesc~="" then
    potion:=CreateThing(spell);
    potion@p_oEatChecker:=DrinkPotion;
    potion@p_oIsPotion:=true;
    if spell@p_sPotionName="" then
      potion@p_oName:="potion;magic";
    else
      potion@p_oName:=spell@p_sPotionName;
    fi;
    potion@p_oDesc:=spell@p_sPotionDesc;
    SetThingStatus(potion,ts_public);
    potion
  else
    nil
  fi
corp;


/****
*SpellToPotion() takes a spell found in memory or a grimoire, and
*creates a potion from it.  The spells found in memory or a grimoire
*are just empty things with a spell model as an ancestor, so
*I just cheat, and call Spell0ToPotion on the parent.
*Compare to SpellToScroll
****/

define tp_magic proc SpellToPotion(thing spell)thing:
  Spell0ToPotion(Parent(spell))
corp;

/**** End of file ****/

