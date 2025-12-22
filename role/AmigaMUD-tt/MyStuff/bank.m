/*
 * GlobalBank2.m A global banking system
 */

private tp_Bank CreateTable().

use t_util
use t_base
use tp_Bank

define tp_Bank p_bBank     CreateThingProp().
define tp_Bank p_bAccounts CreateThingListProp().
define tp_Bank p_bName     CreateStringProp().
define tp_Bank p_bBranches CreateIntProp().
define tp_Bank p_aValue    CreateIntProp().
define tp_Bank p_aOwner    CreateThingProp().

/**** check ****/

if false=IsDefined(t_util,"FindThingOnList") then
  Print("You should source st:mystuff/utility.m FIRST!\nPrepare for errors...\n");
fi.

/**** Verbs ****/

define tp_Bank proc bankBalance()void:
  list thing lt;
  int i,v;
  thing me,a,bank;

  bank:=Here()@p_bBank;
  if bank~=nil then
    lt:=bank@p_bAccounts;
    if lt~=nil then
      me:=Me();
      i:=FindThingOnList(lt,p_aOwner,me);
      if i < 0 then
	Print("You currently have no money deposited.\n");
      else
	Print("Bank of "+bank@p_bName+"\n");
	a:=lt[i];
	v:=a@p_aValue;
	Print("Your current balance is ");
	if v = 1 then
	  Print("one bluto.\n");
	else
	  IPrint(v);
	  Print(" blutos.\n");
	fi;
      fi;
    else
      Print("Sorry, this bank has ceased trading.\n");
    fi;
  else
    Print("You are not in a bank branch.\n");
  fi;
corp.

define tp_Bank proc bankDeposit()void:
  list thing lt;
  int i,v,value;
  thing me,a,bank;
  string st;

  me:=Me();
  if value > me@p_pMoney then
    Print("You do not have that much money on you.\n");
  else
    bank:=Here()@p_bBank;
    if bank~=nil then
      lt:=bank@p_bAccounts;
      if lt~=nil then
	st:=GetWord();
	if st~="" then
	  value := StringToPosInt(st);
	  if value>0 then
	    Print("Bank of "+bank@p_bName+"\n");
	    i:=FindThingOnList(lt,p_aOwner,me);
	    if -1=i then
	      a:=CreateThing(nil);
	      a@p_aOwner:=me;
	      v:=value;
	      Print("Setting up a new account for \"" + me@p_pName +"\". ");
	      AddTail(lt, a);
	    else
	      a:=lt[i];
	      v:=a@p_aValue+value;
	    fi;
	    a@p_aValue:=v;
	    me@p_pMoney:=me@p_pMoney-value;
	    Print("Thank you for your deposit. Your account now has a balance of ");
	    if v = 1 then
	      Print("one bluto.\n");
	    else
	      IPrint(v);
	      Print(" blutos.\n");
	    fi;
	    if not me@p_pHidden and CanSee(Here(), me) then
	      OPrint(Capitalize(me@p_pName) + " makes a transaction.\n");
	    fi;
	  else
	    Print("Invalid amount - must be a positive number.\n");
	  fi;
	else
	  Print("You must say how many blutos you wish to deposit.\n");
	fi;
      else
	Print("Sorry, this bank has ceased trading.\n");
      fi;
    else
      Print("You are not in a bank branch.\n");
    fi;
  fi;
corp.

define tp_Bank proc bankWithdraw()void:
  list thing lt;
  int i,v,value;
  thing me,a,bank;
  string st;

  bank:=Here()@p_bBank;
  if bank~=nil then
    lt:=bank@p_bAccounts;
    if lt~=nil then
      st:=GetWord();
      if st~="" then
	value := StringToPosInt(st);
	if value>0 then
	  i:=FindThingOnList(lt,p_aOwner,me);
	  me:=Me();
	  if i~=-1 then
	    Print("Bank of "+bank@p_bName+"\n");
	    a:=lt[i];
	    v:=a@p_aValue;
	    if value<=v then
	      me@p_pMoney:=me@p_pMoney+value;
	      v:=v-value;
	      if v= 0 then
		Print("Withdrawal made. Your account is now empty and has been closed.\n");
		ClearThing(a);
		DelElement(lt,a);
	      else
		Print("Withdrawal made. Your account now has a balance of ");
		if v = 1 then
		  Print("one bluto.\n");
		else
		  IPrint(v);
		  Print(" blutos.\n");
		fi;
	      fi;
	      if not me@p_pHidden and CanSee(Here(), me) then
		OPrint(Capitalize(me@p_pName) + " makes a transaction.\n");
	      fi;
	    else
	      Print("I'm sorry, you do not have that much in your account.\n");
	    fi;
	  else
	    Print("Invalid amount - must be a positive number.\n");
	  fi;
	else
	  Print("I'm sorry, this bank has no account for \"" + me@p_pName + "\".\n");
	fi;
      else
	Print("You must say how many blutos you wish to withdraw.\n");
      fi;
    else
      Print("Sorry, this bank has ceased trading.\n");
    fi;
  else
    Print("You are not in a bank branch.\n");
  fi;
corp.

/**** Branch stuff ****/

define t_util proc utility public MakeBranch(thing room;string bankname)void:
  string fullname;
  thing bank;

  if room=nil then
    room:=Here();
  fi;
  if room~=nil then
    if room@p_bBank=nil then
      fullname:="bank_"+bankname;
      bank:=LookupThing(tp_Bank,fullname);
      if bank=nil then
	Print("Sorry, there is no bank named "+bankname+".\n");
      else
	room@p_bBank:=bank;
	bank@p_bBranches:=bank@p_bBranches+1;
	AddSpecialCommand(room, "deposit", bankDeposit);
	AddSpecialCommand(room, "withdraw", bankWithdraw);
	AddSpecialCommand(room, "balance", bankBalance);
      fi;
    else
      Print("This room is already a branch of " + room@p_bBank@p_bName +".\n");
    fi;
  else
    Print("Usage: MakeBranch(room,bankname).\n");
  fi;
corp.

define t_util proc utility public IsBranch(thing room)bool:
  if room=nil then
    room:=Here();
  fi;
  if room~=nil then
    room@p_bBank ~= nil
  else
    false
  fi
corp.

define t_util proc utility public UnMakeBranch(thing room)status:
  thing bank;

  if room=nil then
    room:=Here();
  fi;

  if room~=nil then
    bank:=room@p_bBank;
    if bank~=nil then
      room -- p_bBank;
      bank@p_bBranches:=bank@p_bBranches-1;

      ignore RemoveSpecialCommand(room, "deposit", bankDeposit);
      ignore RemoveSpecialCommand(room, "withdraw", bankWithdraw);
      ignore RemoveSpecialCommand(room, "balance", bankBalance);
      succeed
    else
      note This room is not a branch
      continue
    fi
  else
    note Usage: UnMakeBranch(room).
    fail
  fi
corp.

/**** */

define tp_Bank proc utility public CreateBank(string bankname)void:
  string fullname;
  thing bank;

  fullname:="bank_"+bankname;
  bank:=LookupThing(tp_Bank,fullname);
  if bank~=nil then
    Print("Sorry, there is already a bank named "+bankname+".\n");
  else
    bank:=CreateThing(nil);
    if true=DefineThing(tp_Bank,fullname,bank) then
      Print("Created bank of " + bankname + ".\n");
      bank@p_bAccounts:=CreateThingList();
      bank@p_bName:=bankname;
    else
      Print("Error: CreateBank() failed.\n");
      ClearThing(bank);
    fi;
  fi;
corp.

/***/

unuse t_util
unuse t_base
unuse tp_Bank

/**** End of file ****/

