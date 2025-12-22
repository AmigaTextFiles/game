/*
 * /utility.m - utilites
 */

/**** foreward
*This file contains some routines used in the magic code, but
*really belong in t_util
****/

/****
*NametoThing() finds the thing of a character or machine anywhere
*in the mud.  It was hacked from spells.m, and is used in the
*divine magic list.
****/

define t_util proc NameToThing(string name)thing:
  character ch;
  thing agent;

  if name="me" then
    agent:=Me();
  else
    ch := Character(name);
    if ch = nil then
      agent := FindMachineIndexed(name, 1);
    else
      agent := CharacterThing(ch);
    fi;
  fi;
  agent
corp;


/****
*ParseDiceString() generates random numbers based on rolls of 'dice'.
*Each character is a "dice" to roll.  If the string ends in a "+<number>"
*then that number is addedon at the end.
*example:  "666+3" generates numbers from 3 to 18
*I will probably write a better version to take strings in the
*more standard <# dice> D <dice> + <bonus>" form. eg 3D6+2
****/

define t_util proc utility public parseDiceString(string s)int:
  int l,i,dice,acc;
  string v;

  acc:=0;
  l:=Length(s)-1;
  i:=0;
  while i<l do
    v:=SubString(s,i,1);
    if v="+" then
      v:=SubString(s,i+1,l-i);
      acc:=acc+StringToInt(v);
      i:=l;
    else
      dice:=StringToInt(v);
      acc:=acc+Random(dice);
      i:=i+1;
    fi;
  od;

  acc
corp;

/****
*FindThingOnList
****/

define t_util proc FindThingOnList(list thing lt; property thing prop; thing target)int:
  int i,count,rc;

  rc:=-1;
  count:=Count(lt);
  i:=0;

  while i<count do
    if lt[i]@prop=target then
      rc:=i;
      i:=count;
    else
      i:=i+1;
    fi;
  od;
  rc
corp.


/****
* CloneThingList() makes another list containing the SAME things
* Compare to CloneThingListSibling()
****/

define t_util proc CloneThingList(list thing lt)list thing:
  list thing clone;
  thing th;
  int i,count;

  clone:=CreateThingList();
  if lt~=nil then
    count:=Count(lt);
    for i from 0 upto count-1 do
      AddTail(clone,lt[i]);
    od;
  fi;

  clone
corp.


/****
* CloneThingListSibling() makes another list containing the sibling things
* Compare to CloneThingList()
****/

define t_util proc CloneListSibling(list thing lt)list thing:
  list thing clone;
  thing th;
  int i,count;

  clone:=CreateThingList();
  if lt~=nil then
    count:=Count(lt);
    for i from 0 upto count-1 do
      AddTail(clone,CreateThing(Parent(lt[i])));
    od;
  fi;

  clone
corp.


/****
* ListMap() calls an action for each element on a thing list.
****/

define t_util proc utility public ListMap(action a; list thing l)void:
  thing th;
  int count,i;

  count:=Count(l);
  for i from 0 upto count-1 do
    th:=l[i];
    call(a, void)(th);
  od;
corp;


/****
* ListAll() calls an action for each element on a thing list,
* and returns true if all of them return true, false otherwise
****/

define t_util proc utility public ListAll(action a; list thing l)bool:
  thing th;
  bool st;
  int count,i;

  st:=true;
  count:=Count(l);
  for i from 0 upto count-1 do
    th:=l[i];
    st:=st and call(a, bool)(th);
  od;
  st
corp;


/**** End of file ****/

