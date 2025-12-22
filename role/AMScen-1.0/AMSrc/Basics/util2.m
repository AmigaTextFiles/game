/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * util2.m - more utility stuff. These are a bunch of small modules.
 */

private tp_util2 CreateTable().
use tp_util2

/***************************************************************************/

/*
 * AddLight - introduce a source of light to the current room.
 */

define t_util proc public AddLight()void:
    if not CanSee(Here(), Me()) then
	ignore ShowRoomToMe(false);
	ForEachAgent(Here(), ShowRoomToAgent);
    fi;
corp;

/*
 * ActiveLightObject - an object is made to now emit light.
 */

define t_util proc public ActiveLightObject()status:
    thing it;
    string name;

    it := It();
    name := FormatName(it@p_oName);
    if it@p_oLight then
	Print("The " + name + " is already lit.\n");
	fail
    else
	Print("You light the " + name + ".\n");
	OPrint(Capitalize(Me()@p_pName) + AAn(" lights", name) + ".\n");
	AddLight();
	it@p_oLight := true;
	/* want these to be succeed to allow proper use with VerbHere, etc. */
	succeed
    fi
corp;

/*
 * RemoveLight - remove a source of light from the current room.
 */

define t_util proc public RemoveLight()void:
    if not CanSee(Here(), Me()) then
	UnShowRoomFromMe();
	ForEachAgent(Here(), UnShowRoomFromAgent);
    fi;
corp;

/*
 * ActiveUnLightObject - an object is made to no longer emit light.
 */

define t_util proc public ActiveUnLightObject()status:
    thing it;
    string name;

    it := It();
    name := FormatName(it@p_oName);
    if not it@p_oLight then
	Print("The " + name + " is not lit.\n");
	fail
    else
	Print("You extinguish the " + name + ".\n");
	it@p_oLight := false;
	RemoveLight();
	succeed
    fi
corp;

/*
 * PassiveUnLightObject - an object is going out, independent of any player.
 */

define t_util proc public PassiveUnLightObject(thing object)void:
    thing who, where;
    character ch;

    object@p_oLight := false;
    who := object@p_oCarryer;
    where := object@p_oWhere;
    if who ~= nil then
	SPrint(who, "Your " + FormatName(object@p_oName) + " has gone out.\n");
	ch := Character(who@p_pName);
	if ch ~= nil and CharacterThing(ch) = who then
	    where := CharacterLocation(ch);
	    if not LightAt(where) then
		ForEachAgent(where, UnShowRoomFromAgent);
	    fi;
	fi;
    elif where ~= nil and not LightAt(where) then
	ForEachAgent(where, UnShowRoomFromAgent);
    fi;
corp;


/***************************************************************************/

/*
 * GetDocument - get a long document - e.g. description, letter, etc.
 *	Callable by player or machine - will do nothing for a machine.
 *	There are some things to watch out for here. We want these routines
 *	to be 'utility' so that they can be used properly by the build code.
 */

define tp_util2 p_pOldDoc CreateStringProp().
define tp_util2 p_pEndAction CreateActionProp().
define tp_util2 p_pRawDocument CreateBoolProp().
define tp_util2 p_pTempString CreateStringProp().
define tp_util2 p_pSavePrompt CreateStringProp().
define tp_util2 p_pSaveAction CreateActionProp().

/* 'docReset' is replaced later, when its references can be satisfied */
define tp_util2 proc docReset()void: corp;

/* Append the given string to the document being built up. This was
   originally set up for the line-by-line mode, but is also used for
   its handling of the end-of-input condition (s = ".") */
define tp_util2 proc utility appendToDocument(string line)void:
    action endAction;
    thing me, letter;
    string s;
    int len;

    me := Me();
    s := me@p_pTempString;
    len := Length(s);
    if line = "." then
	if len >= 4000 then
	    Print("*** Warning - input may have been truncated. ***\n");
	fi;
	endAction := me@p_pEndAction;
	docReset();
	/* call this so that, e.g. a normal person using the build code can
	   modify his own objects that are ts_readonly */
	call(endAction, void)(s);
    else
	if len >= 4000 then
	    Print("*** Warning - input has been truncated. ***\n");
	else
	    if me@p_pRawDocument then
		me@p_pTempString := s + line + "\n";
	    else
		if line ~= "" then
		    if s ~= "" then
			s := s + " ";
		    fi;
		    me@p_pTempString := s + line;
		fi;
	    fi;
	fi;
    fi;
corp;

/* Called when the player exits MUD while still entering a document. */
define tp_util2 proc utility docIdleAction()void:

    Me()@p_pTempString := Me()@p_pOldDoc;
    appendToDocument(".");
corp;

/* Called by 'activeAction' if the database was saved while the player
   was entering a document, and the server was later restarted from that
   saved database. */
define tp_util2 proc docActiveAction()void:

    Print("\n* You were editing/entering something when the last backup "
	  "was made. That text change has been lost. *\n\n");
    docIdleAction();
corp;

/* We can now define the full body of this. Basically, just clean up after
   doing a GetDocument. */
replace docReset()void:
    thing me;

    me := Me();
    DelElement(me@p_pEnterActions, docActiveAction);
    DelElement(me@p_pExitActions, docIdleAction);
    if me@p_pSaveAction ~= nil then
	/* not setup if using 'EditString' */
	ignore SetCharacterInputAction(me@p_pSaveAction);
	me -- p_pSaveAction;
	ignore SetPrompt(me@p_pSavePrompt);
	me -- p_pSavePrompt;
    fi;
    me -- p_pTempString;
    me -- p_pOldDoc;
    me -- p_pEndAction;
    me -- p_pRawDocument;
corp;

/* Called when the user finished editting the document, as part of
   'EditString'. */
define tp_util2 proc utility docEndAction(string s; bool ok)void:
    thing me;

    me := Me();
    if ok then
	me@p_pTempString := s;
    else
	me@p_pTempString := me@p_pOldDoc;
    fi;
    appendToDocument(".");
corp;

/* Set things up so that user input will be accumulated into a document
   of some kind, which will then be passed to 'endAction'. Also handle
   cases of input not completed when player exits, or when a backup is
   made and later used. */
define t_util proc utility GetDocument(string prompt, intro, oldDoc;
	action endAction; bool isRaw)bool:
    thing me;
    action oldAction;

    me := Me();
    if CanEdit() then
	if Editing() then
	    Print("You are alreadying editing something!\n");
	    false
	else
	    me@p_pTempString := "";
	    me@p_pEndAction := endAction;
	    me@p_pRawDocument := isRaw;
	    me@p_pOldDoc := oldDoc;
	    AddHead(me@p_pEnterActions, docActiveAction);
	    AddHead(me@p_pExitActions, docIdleAction);
	    EditString(oldDoc, docEndAction, isRaw, intro);
	    true
	fi
    else
	oldAction := SetCharacterInputAction(appendToDocument);
	if oldAction = nil then
	    /* must have been a machine! */
	    OPrint(Capitalize(me@p_pName) + " is confused.\n");
	    false
	else
	    me@p_pTempString := "";
	    me@p_pEndAction := endAction;
	    me@p_pRawDocument := isRaw;
	    me@p_pOldDoc := oldDoc;
	    AddHead(me@p_pEnterActions, docActiveAction);
	    AddHead(me@p_pExitActions, docIdleAction);
	    me@p_pSavePrompt := SetPrompt("* " + prompt);
	    me@p_pSaveAction := oldAction;
	    Print(intro +
		". End with a line containing only a single period.\n");
	    true
	fi
    fi
corp;

/*
 * GetCheckedDescription - variant which lets a routine of the callers handle
 *	each of the input lines. Note that since we need line-by-line
 *	processing, there is no 'EditString' variation here.
 */

define t_util proc utility GetCheckedEnd()void: corp;	/* replaced later */

define tp_util2 proc checkedActiveAction()void:

    Print("\n* You were entering something when the last backup "
	  "was made. Those changes have been lost. *\n\n");
    GetCheckedEnd();
corp;

/*
 * GetCheckedEnd - this can be called by other code (e.g. the handler for
 *	this checked description) to terminate this input mode, e.g.
 *	because of erroneous user input.
 */

replace GetCheckedEnd()void:
    thing me;

    me := Me();
    ignore SetCharacterInputAction(me@p_pSaveAction);
    me -- p_pSaveAction;
    ignore SetPrompt(me@p_pSavePrompt);
    me -- p_pSavePrompt;
    DelElement(me@p_pEnterActions, checkedActiveAction);
    DelElement(me@p_pExitActions, GetCheckedEnd);
corp;

define t_util proc utility GetCheckedDescription(string prompt;
	action lineHandler)bool:
    thing me;
    action oldAction;

    me := Me();
    oldAction := SetCharacterInputAction(lineHandler);
    if oldAction = nil then
	/* must have been a machine! */
	OPrint(Capitalize(me@p_pName) + " is confused.\n");
	false
    else
	me@p_pSaveAction := oldAction;
	me@p_pSavePrompt := SetPrompt("* " + prompt);
	AddHead(me@p_pEnterActions, checkedActiveAction);
	AddHead(me@p_pExitActions, GetCheckedEnd);
	true
    fi
corp;


/***************************************************************************/

/*
 * Paginate - paginate a string within the output screen size.
 */

define tp_util2 p_pPaginateSetup CreateBoolProp().
define tp_util2 p_pPaginateString CreateStringProp().
define tp_util2 p_pPaginateLen CreateIntProp().
define tp_util2 p_pPaginatePrompt CreateStringProp().
define tp_util2 p_pPaginateHandler CreateActionProp().

define tp_util2 proc paginateReset()void:
    thing me;

    me := Me();
    me -- p_pPaginateString;
    me -- p_pPaginateLen;
    if me@p_pPaginateSetup then
	me -- p_pPaginateSetup;
	DelElement(me@p_pEnterActions, paginateReset);
	DelElement(me@p_pExitActions, paginateReset);
	ignore SetPrompt(me@p_pPaginatePrompt);
	me -- p_pPaginatePrompt;
	ignore SetCharacterInputAction(me@p_pPaginateHandler);
	me -- p_pPaginateHandler;
    fi;
corp;

define tp_util2 proc paginateParse(string line)void: corp;

define tp_util2 proc paginateShowPage()void:
    thing me;
    string s;
    int len, i, line, height, width;

    me := Me();
    s := me@p_pPaginateString;
    len := me@p_pPaginateLen;
    height := TextHeight(0) - 1;
    width := TextWidth(0);
    line := 1;
    while len > 0 and line <= height do
	i := Index(s, "\n");
	if i = -1 then
	    Print(s);
	    Print("\n");
	    len := 0;
	else
	    Print(SubString(s, 0, i + 1));
	    s := SubString(s, i + 1, len - i - 1);
	    len := len - i - 1;
	    if i <= width then
		line := line + 1;
	    else
		line := line + (i + width - 4) / (width - 9);
	    fi;
	fi;
    od;
    if len = 0 then
	paginateReset();
    else
	me@p_pPaginateString := s;
	me@p_pPaginateLen := len;
	if not me@p_pPaginateSetup then
	    me@p_pPaginateSetup := true;
	    me@p_pPaginatePrompt := SetPrompt("[M O R E] ");
	    me@p_pPaginateHandler := SetCharacterInputAction(paginateParse);
	    AddHead(me@p_pEnterActions, paginateReset);
	    AddHead(me@p_pExitActions, paginateReset);
	fi;
    fi;
corp;

replace paginateParse(string line)void:

    if line = "" then
	paginateShowPage();
    elif line == "q" then
	paginateReset();
    else
	Print("Options are:\n  q - quit\n  empty line - next page\n");
    fi;
corp;

define t_util proc Paginate(string s)void:
    thing me;

    me := Me();
    if GType(nil) == "amiga" then
	/* using full MUD client - no reason to paginate */
	Print(s);
    elif Character(me@p_pName) = nil then
	OPrint(Capitalize(me@p_pName) + " is confused.\n");
    else
	me@p_pPaginateString := s;
	me@p_pPaginateLen := Length(s);
	paginateShowPage();
    fi;
corp;


/***************************************************************************/

/* code, etc. to assist/handle buying things in stores */

/* pre-create the lost and found room, so that we can set the 'home' of
   things that people buy */

define tp_misc r_lostAndFound CreateThing(r_indoors).
SetupRoom(r_lostAndFound, "in the lost and found room",
    "Things lost often end up here.").

/*
 * AddForSale - add an item for sale at the given location.
 *	Note: we WANT this one 'utility' so that it does not execute with
 *	SysAdmin privileges.
 */

define t_util proc utility public AddForSale(thing room; string name, desc;
	int price; action doBuy)thing:
    thing model;
    list thing lt;

    model := CreateThing(nil);
    SetThingStatus(model, ts_readonly);
    /* other players need to read it when shopping or buying */
    model@p_oName := name;
    if desc ~= "" then
	model@p_oDesc := desc;
    fi;
    model@p_oPrice := price;
    if doBuy ~= nil then
	model@p_oBuyChecker := doBuy;
    fi;
    model@p_oHome := r_lostAndFound;
    lt := room@p_rBuyList;
    if lt = nil then
	lt := CreateThingList();
	room@p_rBuyList := lt;
    fi;
    if FindElement(lt, model) = -1 then
	AddTail(lt, model);
    fi;
    model
corp;

/*
 * AddObjectForSale - make an already defined object be for sale.
 */

define t_util proc utility public AddObjectForSale(thing room, model;
	int price; action doBuy)void:
    list thing lt;

    model@p_oPrice := price;
    if doBuy ~= nil then
	model@p_oBuyChecker := doBuy;
    fi;
    lt := room@p_rBuyList;
    if lt = nil then
	lt := CreateThingList();
	room@p_rBuyList := lt;
    fi;
    if FindElement(lt, model) = -1 then
	AddTail(lt, model);
    fi;
corp;

/*
 * SubObjectForSale - make an object no longer for sale.
 */

define t_util proc utility public SubObjectForSale(thing room, model)bool:
    list thing lt;

    lt := room@p_rBuyList;
    if lt ~= nil then
	if FindElement(lt, model) ~= -1 then
	    DelElement(lt, model);
	    model -- p_oPrice;
	    model -- p_oBuyChecker;
	    true
	else
	    false
	fi
    else
	false
    fi
corp;

/*
 * ShowForSale - show the things for sale at a player's current location.
 */

define t_util proc public ShowForSale()void:
    list thing lt;
    int count, n, price;
    thing model;

    lt := Here()@p_rBuyList;
    if lt = nil then
	Print("There is nothing for sale here.\n");
    else
	if not Me()@p_pHidden then
	    OPrint(Capitalize(Me()@p_pName) + " examines the merchandise.\n");
	fi;
	Print("For sale here:\n");
	count := Count(lt);
	n := 0;
	while n ~= count do
	    model := lt[n];
	    Print(FormatName(model@p_oName));
	    Print(" - ");
	    price := model@p_oPrice;
	    if price = 0 then
		Print("free");
	    elif price = 1 then
		Print("1 bluto");
	    else
		IPrint(price);
		Print(" blutos");
	    fi;
	    Print("\n");
	    n := n + 1;
	od;
    fi;
corp;

/*
 * StoreBuy - let the user buy something at a store. This is used as the
 *	'buy' action at the store location.
 *	Note: this is NOT a utility proc, since we want the object to
 *	      be owned by SysAdmin, and since we use OPrint.
 *	Note: intended only to be called by the player doing the buy.
 *	      Looks like it would work for machines too, however.
 */

define t_util proc public StoreBuy(string what)bool:
    thing here, model, me, th;
    string name;
    int price, money;
    action buyAction;
    status st;

    here := Here();
    if here@p_rBuyList = nil then
	Print("There is nothing for sale here.\n");
	false
    else
	name := FormatName(what);
	st := FindName(here@p_rBuyList, p_oName, what);
	if st = fail then
	    Print(AAn("You cannot buy", name) + " here.\n");
	    false
	elif st = continue then
	    Print(name + " is ambiguous here.\n");
	    false
	else
	    model := FindResult();
	    me := Me();
	    price := model@p_oPrice;
	    money := me@p_pMoney;
	    name := FormatName(model@p_oName);
	    if price > money and not me@p_pPrivileged then
		Print(AAn("You cannot afford", name) + ".\n");
		false
	    else
		/* Skip past one level of inheritance if that is there. This
		   allows using the same model, with different price, in
		   different stores. */
		th := Parent(model);
		if th ~= nil and th@p_oPrice ~= 0 then
		    th := CreateThing(th);
		else
		    th := CreateThing(model);
		fi;
		/* We want the thing public so that anyone can do things to
		   it. ts_readonly would work not bad, but that prevents
		   a builder from modifying it. We want it owned by SysAdmin
		   so that all the code that is setuid SysAdmin has no
		   trouble with it. We have to do the SetThingStatus BEFORE
		   we give it away, else we will not have access to do so. */
		SetThingStatus(th, ts_public);
		GiveThing(th, SysAdmin);
		if model@p_oContents ~= nil then
		    th@p_oContents := CreateThingList();
		fi;
		th@p_oCreator := me;
		buyAction := model@p_oBuyChecker;
		st := continue;
		if buyAction ~= nil then
		    SetIt(th);
		    st := call(buyAction, status)();
		fi;
		if st = continue and not CarryItem(th) then
		    st := fail;
		fi;
		if st ~= fail and not me@p_pPrivileged then
		    me@p_pMoney := money - price;
		fi;
		if st = continue then
		    Print(AAn("You have just bought", name) + ".\n");
		    if not me@p_pHidden then
			OPrint(Capitalize(me@p_pName) +
			       " makes a purchase.\n");
		    fi;
		else
		    ClearThing(th);
		fi;
		true
	    fi
	fi
    fi
corp;

/*
 * MakeStore - make a room a store.
 */

define t_util proc utility public MakeStore(thing room)void:

    room@p_rBuyAction := StoreBuy;
corp;

/*
 * IsStore - ask if room is a store.
 */

define t_util proc utility public IsStore(thing room)bool:

    room@p_rBuyAction = StoreBuy
corp;

/*
 * UnmakeStore - make a room no longer a store.
 */

define t_util proc utility public UnmakeStore(thing room)void:

    room -- p_rBuyList;
    room -- p_rBuyAction;
corp;


/***************************************************************************/

/* Some stuff to implement banks. Note that these properties are private,
   so no-one else can change bank accounts. Note also that the routines are
   NOT utility routines, since we want the things created to represent the
   accounts to not be owned by the player. */

define tp_util2 p_rBankAccounts CreateThingListProp().	/* bank account list */
define tp_util2 p_oAccountValue CreateIntProp().	 /* value in account */
define tp_util2 p_oAccountOwner CreateThingProp().	 /* who owns account */

define tp_util2 proc bankDeposit()void:
    list thing lt;
    int money, amount, count, i;
    thing me, account;
    string st;

    st := GetWord();
    if st = "" then
	Print("You must say how many blutos you wish to deposit.\n");
    else
	amount := StringToPosInt(st);
	if amount < 0 then
	    Print("Invalid amount - must be a number.\n");
	else
	    lt := Here()@p_rBankAccounts;
	    if lt = nil then
		Print("*** no account list found ***\n");
	    else
		me := Me();
		money := me@p_pMoney;
		if amount > money then
		    Print("You do not have that much money on you.\n");
		else
		    count := Count(lt);
		    i := 0;
		    while
			if i = count then
			    false
			else
			    account := lt[i];
			    account@p_oAccountOwner ~= me
			fi
		    do
			i := i + 1;
		    od;
		    if i = count then
			Print("Setting up a new account for \"" + me@p_pName +
			    "\". ");
			account := CreateThing(nil);
			account@p_oAccountOwner := me;
			AddTail(lt, account);
			i := 0;
		    else
			i := account@p_oAccountValue;
		    fi;
		    me@p_pMoney := money - amount;
		    amount := amount + i;
		    account@p_oAccountValue := amount;
		    Print("Thank you for your deposit. Your account now has "
			"a balance of ");
		    if amount = 1 then
			Print("one bluto.\n");
		    else
			IPrint(amount);
			Print(" blutos.\n");
		    fi;
		    if not me@p_pHidden and CanSee(Here(), me) then
			OPrint(Capitalize(me@p_pName) +
			    " makes a transaction.\n");
		    fi;
		fi;
	    fi;
	fi;
    fi;
corp;

define tp_util2 proc bankWithdraw()void:
    list thing lt;
    int amount, count, i;
    thing me, account;
    string st;

    st := GetWord();
    if st = "" then
	Print("You must say how many blutos you wish to withdraw.\n");
    else
	amount := StringToPosInt(st);
	if amount < 0 then
	    Print("Invalid amount - must be a number.\n");
	else
	    lt := Here()@p_rBankAccounts;
	    if lt = nil then
		Print("*** no account list found ***\n");
	    else
		me := Me();
		count := Count(lt);
		i := 0;
		while
		    if i = count then
			false
		    else
			account := lt[i];
			account@p_oAccountOwner ~= me
		    fi
		do
		    i := i + 1;
		od;
		if i = count then
		    Print("I'm sorry, this bank has no account for \"" +
			me@p_pName + "\".\n");
		else
		    i := account@p_oAccountValue;
		    if amount > i then
			Print("I'm sorry, you do not have that much in "
			    "your account.\n");
		    else
			me@p_pMoney := me@p_pMoney + amount;
			amount := i - amount;
			account@p_oAccountValue := amount;
			if amount = 0 then
			    Print("Withdrawal made. Your account is now "
				  "empty and has been closed.\n");
			    ClearThing(account);
			    DelElement(lt, account);
			else
			    Print("Withdrawal made. Your account now has a "
				"balance of ");
			    if amount = 1 then
				Print("one bluto.\n");
			    else
				IPrint(amount);
				Print(" blutos.\n");
			    fi;
			fi;
		    fi;
		    if not me@p_pHidden and CanSee(Here(), me) then
			OPrint(Capitalize(me@p_pName) +
			    " makes a transaction.\n");
		    fi;
		fi;
	    fi;
	fi;
    fi;
corp;

define tp_util2 proc bankBalance()void:
    list thing lt;
    int amount, count, i;
    thing me, account;

    lt := Here()@p_rBankAccounts;
    if lt = nil then
	Print("*** no account list found ***\n");
    else
	me := Me();
	count := Count(lt);
	i := 0;
	while
	    if i = count then
		false
	    else
		account := lt[i];
		account@p_oAccountOwner ~= me
	    fi
	do
	    i := i + 1;
	od;
	if i = count then
	    Print("I'm sorry, this bank has no account for \"" + me@p_pName +
		"\".\n");
	else
	    amount := account@p_oAccountValue;
	    Print("Your account has a balance of ");
	    if amount = 1 then
		Print("one bluto.\n");
	    else
		IPrint(amount);
		Print(" blutos.\n");
	    fi;
	    if not me@p_pHidden and CanSee(Here(), me) then
		OPrint(Capitalize(me@p_pName) + " makes a transaction.\n");
	    fi;
	fi;
    fi;
corp;

/*
 * make this one utility, so people can only do it to their own rooms.
 */

define t_util proc utility public MakeBank(thing room)void:

    room@p_rBankAccounts := CreateThingList();
    AddSpecialCommand(room, "deposit", bankDeposit);
    AddSpecialCommand(room, "withdraw", bankWithdraw);
    AddSpecialCommand(room, "balance", bankBalance);
corp;

define t_util proc utility public IsBank(thing room)bool:

    room@p_rBankAccounts ~= nil
corp;

define t_util proc utility public UnmakeBank(thing room)status:
    list thing accounts;

    accounts := room@p_rBankAccounts;
    if accounts = nil then
	continue
    elif Count(accounts) ~= 0 then
	fail
    else
	room -- p_rBankAccounts;
	ignore RemoveSpecialCommand(room, "deposit", bankDeposit);
	ignore RemoveSpecialCommand(room, "withdraw", bankWithdraw);
	ignore RemoveSpecialCommand(room, "balance", bankBalance);
	succeed
    fi
corp;


/***************************************************************************/

/* Some general routines for setting up verbs that do things to things.
   'VerbCarry' requires that the player be carrying the object in order to
   do whatever to it. 'VerbHere' allows it to be either carried or in the
   room the player is in. It would also be possible to look at things that
   are carried by other players/machines, but I chose not to. Note that
   I check the player, then the room, then the specific object.
   Return 'false' if we were not able to do the action on the requested
   thing, because the thing is not available, or the action fails.
*/

/* A problem has cropped up with the drinking monsters. The code below
   looks for the same properties on the player, the room and the object.
   So, if you try to drink the drinking troll, it will execute the drink
   action on the troll and say that you shouldn't do that. Unfortunately,
   that action is also done when the troll's special action gets the troll
   to 'drink water'. Proper solution is two more properties, sigh. This
   has been done for the indirect case with 'actorCheck'. Thus we do not
   allow the case of attaching a string to the player which is the entire
   result of trying to do that action. */

define t_util proc public commonVerbTail(property string direct;
	property action indirect, actorCheck; thing object;
	string failHeader, verbName, name)bool:
    thing me, here;
    action a;
    string directString;
    status st;
    bool doneOne;

    /* Note: the status values returned by the handler routines are
       interpreted as follows:
	  continue - nothing special - keep looking for something special
	  succeed - successfully handled this case
	  fail - this case is handled, but cease cases and parsing
       The presence of a 'direct' string property is taken to be the same
       as a routine which prints that string and returns 'succeed', with
       the exception that something on a given object will override a
       direct string on a location.
    */

    me := Me();
    here := Here();
    doneOne := false;
    if actorCheck ~= nil then
	a := me@actorCheck;
	if a ~= nil then
	    SetIt(object);
	    st := call(a, status)();
	    if st ~= continue then
		doneOne := true;
	    fi;
	fi;
    fi;
    if not doneOne and indirect ~= nil then
	a := here@indirect;
	if a ~= nil then
	    SetIt(object);
	    st := call(a, status)();
	    if st ~= continue then
		doneOne := true;
	    fi;
	fi;
    fi;
    if not doneOne and direct ~= nil then
	directString := here@direct;
	if directString ~= "" and
	    (object = nil or object@direct = "" and object@indirect = nil)
	then
	    doneOne := true;
	    Print(directString + "\n");
	    st := continue;
	fi;
    fi;
    if not doneOne and object ~= nil and indirect ~= nil then
	a := object@indirect;
	if a ~= nil then
	    SetIt(object);
	    st := call(a, status)();
	    if st ~= continue then
		doneOne := true;
	    fi;
	fi;
    fi;
    if not doneOne and object ~= nil and direct ~= nil then
	directString := object@direct;
	if directString ~= "" then
	    doneOne := true;
	    Print(directString + "\n");
	    st := continue;
	fi;
    fi;
    if doneOne then
	st ~= fail
    elif object = nil then
	Print("You must specify what you want to " + verbName + ".\n");
	false
    else
	Print(failHeader + " the " + name + ".\n");
	true
    fi
corp;

define t_util proc public VerbCarry(string verbName; property string direct;
	property action indirect, actorCheck; string failHeader, what)bool:
    thing object;
    string name;
    status st;
    bool done, ok;
    list thing lt;
    int i, count, oldCount;

    done := false;
    if what = "" then
	object := nil;
    elif what == "all" then
	lt := Me()@p_pCarrying;
	count := Count(lt);
	i := 0;
	ok := true;
	while ok and i ~= count do
	    object := lt[i];
	    if not object@p_oInvisible then
		done := true;
		if commonVerbTail(direct, indirect, actorCheck,
		    object, failHeader, verbName, FormatName(object@p_oName))
		then
		    oldCount := count;
		    count := Count(lt);
		    i := i - (oldCount - count) + 1;
		else
		    ok := false;
		fi;
	    else
		i := i + 1;
	    fi;
	od;
	if not done then
	    done := true;
	    Print("You are not carrying anything obvious to " + verbName +
		  ".\n");
	    ok := false;
	fi;
    else
	name := FormatName(what);
	st := FindName(Me()@p_pCarrying, p_oName, what);
	if st = fail then
	    Print(AAn("You are not carrying", name) + ".\n");
	    ok := false;
	    done := true;
	elif st = continue then
	    Print(name + " is ambiguous here.\n");
	    ok := false;
	    done := true;
	else
	    object := FindResult();
	fi;
    fi;
    if done then
	ok
    else
	commonVerbTail(direct, indirect, actorCheck,
		       object, failHeader, verbName, name)
    fi
corp;

define t_util proc public VerbHere(string verbName; property string direct;
	property action indirect, actorCheck; string failHeader, what)bool:
    thing here, object;
    list thing lt;
    int count, i, oldCount;
    string ambig, name;
    status st;
    bool done, ok;

    here := Here();
    done := false;
    object := nil;
    if what == "all" then
	lt := Me()@p_pCarrying;
	count := Count(lt);
	i := 0;
	ok := true;
	while ok and i ~= count do
	    object := lt[i];
	    if not object@p_oInvisible then
		done := true;
		if commonVerbTail(direct, indirect, actorCheck, object,
		    failHeader, verbName, FormatName(object@p_oName))
		then
		    oldCount := count;
		    count := Count(lt);
		    i := i - (oldCount - count) + 1;
		else
		    ok := false;
		fi;
	    else
		i := i + 1;
	    fi;
	od;
	lt := here@p_rContents;
	count := Count(lt);
	i := 0;
	while ok and i ~= count do
	    object := lt[i];
	    if not object@p_oInvisible then
		done := true;
		if commonVerbTail(direct, indirect, actorCheck,
		    object, failHeader, verbName, FormatName(object@p_oName))
		then
		    oldCount := count;
		    count := Count(lt);
		    i := i - (oldCount - count) + 1;
		else
		    ok := false;
		fi;
	    else
		i := i + 1;
	    fi;
	od;
	if not done then
	    done := true;
	    Print("There is nothing obvious here to " + verbName + ".\n");
	    ok := false;
	fi;
    elif what ~= "" then
	name := FormatName(what);
	ambig := " is ambiguous here.\n";
	st := FindName(Me()@p_pCarrying, p_oName, what);
	if st = fail then
	    st := FindName(here@p_rContents, p_oName, what);
	    if st = fail then
		object := FindAgent(what);
		if object = nil then
		    if here@p_rBuyList ~= nil and
			FindName(here@p_rBuyList, p_oName, what) ~= fail
		    then
			done := true;
			ok := false;
			Print("You should buy the " + name +
			    " before you try to " + verbName + " it.\n");
		    elif MatchName(here@p_rScenery, what) ~= -1 then
			done := true;
			ok := false;
			Print(failHeader + " the " + name + ".\n");
		    fi;
		fi;
	    elif st = continue then
		Print(name);
		Print(ambig);
		ok := false;
		done := true;
	    else
		object := FindResult();
	    fi;
	elif st = continue then
	    Print(name);
	    Print(ambig);
	    ok := false;
	    done := true;
	else
	    object := FindResult();
	fi;
	if object = nil and not done then
	    Print(IsAre("There", "no", name, "here.\n"));
	    done := true;
	    ok := false;
	fi;
    fi;
    if done then
	ok
    else
	commonVerbTail(direct, indirect, actorCheck,
		       object, failHeader, verbName, name)
    fi
corp;

unuse tp_util2
