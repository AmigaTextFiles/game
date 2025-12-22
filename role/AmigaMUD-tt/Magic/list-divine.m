/*
 * magic/list-divine.m Magic spells form divine characters
 */

use t_quests

/**** Foreward
*Many of these spells are based on those supplied in st:extras/spells.m
*Consequently, they are only intended for use by SysAdmin and Wizards
****/

/*********************** Param 1 ***************************/

/**** find *****
* shows what <who> sees
***************/

define tp_magic proc se_find(thing spell; string name)bool:
  character ch;
  thing where, agent;
  action a;

  agent:=NameToThing(name);
  if agent=nil then
    Print("There is no character or machine called '" + name + "'.\n");
  else
    where := AgentLocation(agent);
    if where = nil then
      Print(name + " is not currently anywhere.\n");
    else
      a := where@p_rNameAction;
      if a = nil then
	Print(name + " is " + where@p_rName + ".\n");
      else
	Print(name + ": " + call(a, string)() + ".\n");
      fi;
      a := where@p_rDescAction;
      if a = nil then
	if where@p_rDesc ~= "" then
	  Print(where@p_rDesc + "\n");
	fi;
	ShowExits(where);
	ignore ShowList(where@p_rContents, "Nearby:\n");
      else
	Print(name + ": " + call(a, string)() + ".\n");
      fi;
    fi;
  fi;
  true
corp;

define tp_magic sm_DFind CreateThing(sm_DefaultWSpell).
sm_DFind@p_sName:="find".
sm_DFind@p_sEffect:=se_find.
sm_DFind@p_sDesc:="find at <who> - show what <who> sees.".
AddMangledName(sm_DFind,langStandard).

/**** poof *****
* poofs to where what <who> is
***************/

define tp_magic proc se_poof(thing spell; string name)bool:
  thing who, where;

  who:=NameToThing(name);
  if who = nil then
    Print("There is no character or machine called '" + name + "'.\n");
  else
    where := AgentLocation(who);
    if where = nil then
      Print(name + " is not currently active or anywhere.\n");
    else
      LeaveRoomStuff(where, 0, MOVE_POOF);
      EnterRoomStuff(where, 0, MOVE_POOF);
    fi;
  fi;
  true
corp;

define tp_magic sm_DPoof CreateThing(sm_DefaultWSpell).
sm_DPoof@p_sName:="poof".
sm_DPoof@p_sEffect:=se_poof.
sm_DPoof@p_sDesc:="poof to <who> - teleport to same location as <who>.".
AddMangledName(sm_DPoof,langStandard).

/**** look *****
* looks at <who>
***************/

define tp_magic proc se_look(thing spell; string name)bool:
  thing who;

  who:=NameToThing(name);
  if who = nil then
    Print("There is no character or machine called '" + name + "'.\n");
  else
    if LookAtCharacter(who) then
      ignore ShowQuests(who, true);
    fi;
  fi;
  true
corp;

define tp_magic sm_DLook CreateThing(sm_DefaultWSpell).
sm_DLook@p_sName:="look".
sm_DLook@p_sEffect:=se_look.
sm_DLook@p_sDesc:="look at <who> - look at <who>, even if not nearby.".
AddMangledName(sm_DLook,langStandard).

/**** heal *****
* heal <who> of all hit points
***************/

define tp_magic proc se_heal(thing spell;string name)bool:
  thing who;
  int max;

  who:=NameToThing(name);
  if who = nil then
    Print("There is no character or machine called '" + name + "'.\n");
  else
    max := who@p_pHitMax;
    if max = 0 then
      Print(name + " has no maximum hitpoints.\n");
    elif who@p_pHitNow = max then
      Print(name + " needs no healing.\n");
    else
      who@p_pHitNow := max;
      Print(name + " healed.\n");
      SPrint(who, "You suddenly feel better!\n");
    fi;
  fi;
  true
corp;

define tp_magic sm_DHeal CreateThing(sm_DefaultWSpell).
sm_DHeal@p_sNull:="me".
sm_DHeal@p_sPotionDesc:="This potion glows bright yellow.".
sm_DHeal@p_sName:="heal".
sm_DHeal@p_sEffect:=se_heal.
sm_DHeal@p_sDesc:="heal on <who> - heal <who> upto max hitpoints.".
AddMangledName(sm_DHeal,langStandard).

/**** Object Clone *****
* ObjectClone <object>
***************/

define tp_magic proc se_ObjectClone(thing spell; string name)bool:
  thing what,me,spare;
  status st;
  list thing lt;

  me:=Me();
  lt:=me@p_pCarrying;
  st:=FindName(lt,p_oName,name);
  if st=fail then
    lt:=Here()@p_rContents;
    st:=FindName(lt,p_oName,name);
  fi;
  if st=succeed then
    what:=FindResult();
    spare:=CreateThing(Parent(what));
    AddTail(lt,spare);
    if what@p_oCarryer~=nil then
      spare@p_oCarryer:=what@p_oCarryer;
    fi;
    if what@p_oWhere~=nil then
      spare@p_oWhere:=what@p_oWhere;
    fi;
    Print("You have cloned the " + FormatName(name));
    true
  elif st=continue then
    Print(name + " is ambiguous.\n");
    false
  else
    Print(AAn("There ","no " + name) + " here.\n");
    false
  fi
corp;

define tp_magic sm_ObjectClone CreateThing(sm_DefaultWSpell).
sm_ObjectClone@p_sName:="object;clone".
sm_ObjectClone@p_sEffect:=se_ObjectClone.
sm_ObjectClone@p_sDesc:="Object Clone on <object>.".
AddMangledName(sm_ObjectClone,langStandard).


/**** Where *****
* Displays a list of where each character/machine is
***************/

define tp_magic proc se_Where_Aux(thing theAgent)void:
  thing where;
  string m;
  m := FormatName(theAgent@p_pName);
  if m="" then
    m:="<noname> is ";
  else
    m:=m+" is ";
  fi;
  where := AgentLocation(theAgent);
  if where = nil then
    m := m + "nowhere";
  else
    m := m + where@p_rName;
  fi;
  Print("  " + m + "\n");
corp;

define tp_magic proc se_DWhere(thing spell; string arg)bool:
  thing agent;

  if arg="all" then
    ForEachClient(se_Where_Aux);
    ForEachAgent(nil, se_Where_Aux);
  elif arg="clients" then
    ForEachClient(se_Where_Aux);
  elif arg="machines" then
    ForEachAgent(nil, se_Where_Aux);
  else
    agent:=NameToThing(arg);
    if agent~=nil then
      se_Where_Aux(agent);
    else
      Print("There is no character or machine called '" + arg + "'.\n");
    fi;
  fi;
  true
corp;

define tp_magic sm_DWhere CreateThing(sm_DefaultWSpell).
sm_DWhere@p_sName:="where".
sm_DWhere@p_sEffect:=se_DWhere.
sm_DWhere@p_sDesc:="Where is [ all | clients | <name> ].".
AddMangledName(sm_DWhere,langStandard).


/******************** Verb 2 *************************************/

/**** sendto *****
* sends a message to <who>
***************/

define tp_magic proc se_send(thing spell; string tail)bool:
  string name,stuff;
  thing who;

  SetTail(FormatName(tail));
  name := GetWord();
  if name = "" then
    Print(spell@p_sDesc + "\n");
    false
  else
    who:=NameToThing(name);
    if who=nil then
      Print("There is no character or machine called '" + name + "'.\n");
    else
      SPrint(who, Me()@p_pName + " mindsends: " + GetTail());
    fi;
    true
  fi
corp;

define tp_magic sm_DSend CreateThing(sm_DefaultWSpell).
sm_DSend@p_sName:="send;mind".
sm_DSend@p_sEffect:=se_send.
sm_DSend@p_sDesc:="mind send to <who> <stuff> - send <stuff> to <who> as mindsend.".
AddMangledName(sm_DSend,langStandard).


/**** force *****
* force <who> sto do something
***************/

define tp_magic p_pForceAction CreateStringProp().

define tp_magic proc doForceAction()void:
  string s;

  s := Me()@p_pForceAction;
  if s ~= "" then
    Me() -- p_pForceAction;
    ignore Parse(G, s);
  fi;
corp;

define tp_magic proc forceAnAction()status:
  After(0, doForceAction);
  continue
corp;

define t_util proc forceCharacter(thing who; string what)void:
  who@p_pForceAction := what;
  ignore ForceAction(who, forceAnAction);
corp;

define tp_magic proc se_force(thing spell; string tail)bool:
  string what,name;
  thing who;

  SetTail(FormatName(tail));

  name := GetWord();
  if name = "" then
    Print(spell@p_sDesc + "\n");
    false
  else
    who:=NameToThing(name);
    if who = nil then
      Print("There is no character or machine called '" + name + "'.\n");
    else
      what := GetTail();
      if what = "" then
	Print("You must say what you want " + name + " to do.\n");
      else
	SPrint(who, "***\n" + Me()@p_pName + " forces you: " + what + "\n***\n");
	forceCharacter(who, what);
      fi;
    fi;
    true
  fi
corp;

define tp_magic sm_DForce CreateThing(sm_DefaultWSpell).
sm_DForce@p_sName:="force".
sm_DForce@p_sEffect:=se_force.
sm_DForce@p_sDesc:="force <who> <what> - force <who> to do <what>.".
AddMangledName(sm_DForce,langStandard).


/**** teleport *****
* move <who> to <location>
***************/

define tp_magic p_pForceMove CreateThingProp().

define tp_magic proc doForceMove()status:
  thing me, dest;
  string name;
  action a;

  me := Me();
  dest := me@p_pForceMove;
  if dest ~= nil then
    me -- p_pForceMove;
    LeaveRoomStuff(dest, 0, MOVE_POOF);
    EnterRoomStuff(dest, 0, MOVE_POOF);
  fi;
  continue
corp;

define tp_magic proc se_teleport(thing spell;string tail)bool:
  string location,name;
  character ch;
  thing me, here, who, where, there;
  action a;
  int dir;
  property thing dirProp;

  SetTail(FormatName(tail));
  name := GetWord();
  location := GetWord();
  if location = "" then
    Print(spell@p_sDesc + "\n");
    false
  else
    me := Me();
    here := Here();
    if name == "me" then
      ch := ThingCharacter(me);
    else
      ch := Character(name);
    fi;
    if ch = nil then
      who := FindMachineIndexed(name, 1);
      if who = nil then
	Print("There is no character or machine called '" + name + "'.\n");
      fi;
    else
      who := CharacterThing(ch);
      if who = nil then
	Print(name + " has no thing????\n");
      fi;
    fi;
    if who ~= nil then
      where := AgentLocation(who);
      if where = nil then
	Print(name + " is not currently active or anywhere.\n");
      else
	dir := DirMatch(location);
	if dir ~= -1 then
	  there := here@DirProp(dir);
	  if there = nil then
	    Print("That direction does not go anywhere.\n");
	  fi;
	else
	  if location == "here" then
	    there := here;
	  else
	    there := LookupThing(nil, location);
	    if there ~= nil then
	      if there@p_rName = "" and
		there@p_rNameAction = nil
	      then
		there := nil;
	      fi;
	    fi;
	    if there = nil then
	      Print(location + " is not a defined location.\n");
	    fi;
	  fi;
	fi;
	if there ~= nil then
	  if who = me then
	    LeaveRoomStuff(there, 0, MOVE_POOF);
	    EnterRoomStuff(there, 0, MOVE_POOF);
	  else
	    SPrint(who, "***\n" + me@p_pName + " teleports you! \n***\n");
	    who@p_pForceMove := there;
	    ignore ForceAction(who, doForceMove);
	  fi;
	fi;
      fi;
    fi;
    true
  fi
corp;

define tp_magic sm_DTeleport CreateThing(sm_DefaultWSpell).
sm_DTeleport@p_sName:="teleport".
sm_DTeleport@p_sEffect:=se_teleport.
sm_DTeleport@p_sDesc:="teleport on <who> {here | <dir> | <roomname>} - teleport <who> ...".
AddMangledName(sm_DTeleport,langStandard).


/**** End of file ****/
unuse t_quests

