/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * email.m - allow the player to interact with usenet electronic mail.
 */

/* NOTE: this current setup is intended for use with Matt Dillon's UUCP
   and mail distribution, version 1.13D or later. To use it with other
   forms of mail, you will perhaps need to change various things.
   Dependencies: UUMAIL: for mail files, T:, sendmail, uuxqt. Note that
   lately, the UUCP package has been owned by Michael B. Smith. As of
   this writing, the latest release of it is UUCP-V1.17b4. The code here
   makes no attempt to read the Config file for UUCP, so it uses only
   the default locations for things, and assumes the needed commands will
   be in the path for MUDServ. */

/* NOTE: this file currently depends on news.m for some player values */

/* NOTE: the code here uses the normal place for mail files, i.e. the
   UUMAIL: assign. Thus, you should create a MUD character whose name is
   the same as any names that normally use your system for mail, otherwise
   someone could create them and then would get the outside-of-MUD mail
   intended for that person, and could send out mail seemingly from that
   person. */

use t_streets

private tp_email CreateTable()$
use tp_email

define tp_email p_pRunUUXQT CreateBoolProp()$
NewsThing@p_pRunUUXQT := true$

define tp_email p_pEmailAliases CreateThingListProp()$
define tp_email p_alName CreateStringProp()$
define tp_email p_alAddress CreateStringProp()$

define tp_email p_pEmailTo CreateStringProp()$
define tp_email p_pEmailSubject CreateStringProp()$
define tp_email p_pEmailString CreateStringProp()$

define tp_email g_email CreateGrammar()$

define tp_email proc mv_help()bool:
    Print(
"Commands in the telegram office are:\n\n"
"  info - some additional comments on MUD email\n"
"  read - read your mail\n"
"  name/realname <name> - set your real name to <name>\n"
"  mail <person> [subject] - send a new letter to the given person\n"
"  delete - delete all of your mail\n"
"  alias <name> <address> - create an alias for use with 'mail'\n"
"  alias <name> - delete an alias\n"
"  alias - list all aliases\n"
    );
    true
corp;

Verb0(g_email, "help", 0, mv_help)$
Synonym(g_email, "help", "?")$

define tp_email proc mv_info()bool:

    Print(
"Your name in the 'name' command can be quoted or not, it doesn't matter. "
"<person> in the 'mail' command must be quoted if the name contains "
"characters other than letters. Remember that the basic parser in use was "
"designed to parse English-language-like input, so it will interpret, e.g.\n"
"   mail fred@big.company.COM\n"
"as 'mail fred @ big' followed by 'company' followed by 'COM'. This is not "
"what you intended. The optional subject on the 'mail' command can be either "
"quoted or not - it depends on whether you put punctuation characters in. "
"You will soon find that using email via MUD is a chore - if you need to do "
"it a lot, you should try to get a normal email connection.\n"
    );
    true
corp;

Verb0(g_email, "info", 0, mv_info)$

VerbTail(g_email, "name", nv_name)$
Synonym(g_email, "name", "realname")$

define tp_email proc emailSendLetter(string s)void:
    int fd;
    string cmd;
    thing me;

    me := Me();
    if s = "" then
	Print("Empty letter - not sent.\n");
    else
	/* note: server runs atomically, so no conflict over the temp file */
	fd := FileOpenForWrite("T:MUD.letter");
	if fd = 0 then
	    Print("Sorry - can't open letter file.\n");
	else
	    Log("'" + me@p_pName + "' mailing to " + me@p_pEmailTo + "\n");
	    FileWrite(fd, "X-MailSoftware: AmigaMUD telegram office\n");
	    FileWrite(fd, "\n");
	    FileWrite(fd, s);
	    FileClose(fd);
	    cmd := "sendmail < T:MUD.letter -f \"" + me@p_pName +
		"\" -t " + me@p_pEmailTo;
	    if me@p_pEmailSubject ~= "" then
		cmd := cmd + " -s \"" + me@p_pEmailSubject + "\"";
	    fi;
	    cmd := cmd + " -R \"" + me@p_pNRealName + "\"";
	    Execute(cmd);
	    Execute("delete T:MUD.letter");
	    /* do this so that local mail, as in name@here, will work */
	    if NewsThing@p_pRunUUXQT then
		Execute("uuxqt");
	    fi;
	fi;
    fi;
    me -- p_pEmailTo;
    me -- p_pEmailSubject;
corp;

define tp_email proc mv_mail()bool:
    thing me, alias;
    string target;
    list thing aliases;
    int count;
    string subject;

    target := GetWord();
    if target = "" then
	Print("You must specify an address to mail to.\n");
	false
    else
	me := Me();
	if me@p_pNRealName = "" then
	    Print("You cannot email until you have a realname set up.\n");
	    false
	else
	    aliases := me@p_pEmailAliases;
	    if aliases ~= nil then
		count := Count(aliases);
		while count ~= 0 do
		    count := count - 1;
		    alias := aliases[count];
		    if alias@p_alName == target then
			target := alias@p_alAddress;
		    fi;
		od;
	    fi;
	    if target = "" or Index(target, " ") >= 0 then
		Print("Invalid mail target.\n");
		false
	    else
		me@p_pEmailTo := target;
		if not CanEdit() then
		    Print("To: " + target + "\n");
		fi;
		subject := GetTail();
		if subject ~= "" then
		    if SubString(subject, 0, 1) = "\"" then
			subject :=
			    SubString(subject, 1, Length(subject) - 2);
		    fi;
		    me@p_pEmailSubject := subject;
		    if not CanEdit() then
			Print("Subject: ");
			Print(subject);
			Print("\n");
		    fi;
		fi;
		GetDocument("email> ", "Enter email letter", "",
			    emailSendLetter, true)
	    fi
	fi
    fi
corp;

VerbTail(g_email, "mail", mv_mail)$

define tp_email proc emailParse(string input)void: corp;
define tp_email proc emailLetterParse(string line)void: corp;

define tp_email proc emailAllDone()void:
    thing me;
    int fd;

    me := Me();
    fd := me@p_pNFd;
    if fd ~= 0 then
	FileClose(fd);
	me@p_pNFd := 0;
    fi;
    me -- p_pEmailString;
    me -- p_pEmailTo;
    me -- p_pEmailSubject;
    ignore SetPrompt("telegram office> ");
    ignore SetCharacterInputAction(emailParse);
corp;

define tp_email proc emailFindLetter()bool:
    thing me;
    int fd, colon;
    string line, header;

    me := Me();
    if me@p_pEmailString ~= "" then
	true
    else
	fd := me@p_pNFd;
	while
	    line := FileRead(fd);
	    line ~= "" and Index(line, "From ") ~= 0
	do
	od;
	if line ~= "" then
	    me@p_pEmailString := line;
	    true
	else
	    false
	fi
    fi
corp;

define tp_email proc emailShowPage()bool:
    thing me;
    int fd, length, n, width, len;
    string line;
    bool moreLetter;

    me := Me();
    fd := me@p_pNFd;
    length := TextHeight(0);
    width := TextWidth(0);
    n := 1;
    line := me@p_pEmailString;
    if line ~= "" then
	me -- p_pEmailString;
	Print(line);
	Print("\n");
	n := 2;
    fi;
    moreLetter := true;
    while
	if n >= length then
	    false
	else
	    line := FileRead(fd);
	    if line = "" then
		moreLetter := false;
		false
	    elif Index(line, "From ") = 0 then
		me@p_pEmailString := line;
		moreLetter := false;
		false
	    else
		true
	    fi
	fi
    do
	Print(line);
	Print("\n");
	len := Length(line);
	if len <= width then
	    n := n + 1;
	else
	    n := n + (len + width - 4) / (width - 9);
	fi;
	if Index(line, "From: ") = 0 then
	    line := SubString(line, 6, Length(line) - 6);
	    len := Index(line, " (");
	    if len > 0 then
		line := SubString(line, 0, len);
	    fi;
	    me@p_pEmailTo := line;
	elif Index(line, "Subject: ") = 0 then
	    line := SubString(line, 9, Length(line) - 9);
	    if line ~= "" then
		me@p_pEmailSubject := "Re: " + line;
	    fi;
	fi;
    od;
    moreLetter
corp;

define tp_email proc emailSetLetter()void:

    ignore SetPrompt("Nrq? ");
    ignore SetCharacterInputAction(emailLetterParse);
corp;

define tp_email proc emailMoreParse(string line)void:

    if line = "" or line == "c" then
	if not emailShowPage() then
	    emailSetLetter();
	fi;
    elif line == "n" then
	if emailFindLetter() then
	    if not emailShowPage() then
		emailSetLetter();
	    fi;
	else
	    emailAllDone();
	fi;
    elif line == "q" then
	emailAllDone();
    else
	Print("Options are:\n"
		"  c - continue reading this letter\n"
		"  n - go on to next letter\n"
		"  q - quit reading mail\n"
		"Empty line is equivalent to 'r'\n"
	);
    fi;
corp;

define tp_email proc emailSetMore()void:

    ignore SetPrompt("[M O R E] Cnq? ");
    ignore SetCharacterInputAction(emailMoreParse);
corp;

replace emailLetterParse(string line)void:
    thing me;

    me := Me();
    if line == "r" then
	if me@p_pNRealName = "" then
	    Print("You cannot email until you have a realname set up.\n");
	else
	    if not CanEdit() then
		Print("To: " + me@p_pEmailTo + "\n");
		if me@p_pEmailSubject ~= "" then
		    Print("Subject: ");
		    Print(me@p_pEmailSubject);
		    Print("\n");
		fi;
	    fi;
	    ignore GetDocument("reply> ", "Enter email reply", "",
			       emailSendLetter, true);
	fi;
    elif line = "" or line == "n" then
	if emailFindLetter() then
	    if emailShowPage() then
		emailSetMore();
	    fi;
	else
	    emailAllDone();
	fi;
    elif line == "q" then
	emailAllDone();
    else
	Print("Options are:\n\n"
		"  r - reply to this letter\n"
		"  n - read next letter\n"
		"  q - quit reading mail\n"
		"Empty line is equivalent to 'n'\n"
	);
    fi;
corp;

define tp_email proc emailResetHandler()void:

    Me()@p_pNFd := 0;
    emailAllDone();
corp;

define tp_email proc mv_read()bool:
    thing me;
    int fd;
    action a;

    me := Me();
    fd := FileOpenForRead("UUMAIL:" + me@p_pName);
    if fd = 0 then
	Print("No mail for " + me@p_pName + "\n");
    else
	me@p_pNFd := fd;
	if emailFindLetter() then
	    if emailShowPage() then
		emailSetMore();
	    else
		emailSetLetter();
	    fi;
	else
	    Print("Mailbox is invalid - no header found!\n");
	fi;
    fi;
    true
corp;

Verb0(g_email, "read", 0, mv_read)$

replace emailParse(string input)void:
    string word;

    SetTail(input);
    word := GetWord();
    if word ~= "" then
	if FindAnyWord(g_email, word) ~= 0 then
	    ignore Parse(g_email, input);
	else
	    ignore Parse(G, input);
	fi;
    fi;
corp;

define tp_email proc mv_delete()bool:

    Execute("delete \"UUMAIL:" + Me()@p_pName + "\"");
    Print("All mail deleted.\n");
    true
corp;

Verb0(g_email, "delete", 0, mv_delete)$

define tp_email proc mv_alias()bool:
    int count;
    list thing aliases;
    thing alias;
    string name, address;
    bool found;

    aliases := Me()@p_pEmailAliases;
    name := GetWord();
    if name = "" then
	if aliases = nil then
	    Print("You currently have no email aliases set up.\n");
	else
	    Print("Current aliases:\n");
	    count := Count(aliases);
	    while count ~= 0 do
		count := count - 1;
		alias := aliases[count];
		Print("  ");
		Print(alias@p_alName);
		Print(" => ");
		Print(alias@p_alAddress);
		Print("\n");
	    od;
	fi;
    else
	address := GetTail();
	found := false;
	if aliases ~= nil then
	    count := Count(aliases);
	    while count ~= 0 and not found do
		count := count - 1;
		alias := aliases[count];
		if alias@p_alName == name then
		    found := true;
		fi;
	    od;
	fi;
	Print("Alias \"");
	Print(name);
	Print("\" ");
	if address = "" then
	    if found then
		DelElement(aliases, alias);
		Print("removed.\n");
	    else
		Print("does not exist.\n");
	    fi;
	else
	    if SubString(address, 0, 1) = "\"" then
		address := SubString(address, 1, Length(address) - 2);
	    fi;
	    if found then
		alias@p_alAddress := address;
		Print("updated.\n");
	    else
		if aliases = nil then
		    aliases := CreateThingList();
		    Me()@p_pEmailAliases := aliases;
		fi;
		alias := CreateThing(nil);
		alias@p_alName := name;
		alias@p_alAddress := address;
		AddTail(aliases, alias);
		Print("added.\n");
	    fi;
	fi;
    fi;
    true
corp;

VerbTail(g_email, "alias", mv_alias)$

define tp_email proc emailEnter()status:
    thing me;

    me := Me();
    if Character(me@p_pName) = nil then
	/* cannot do this stuff with machines! */
	OPrint(Capitalize(CharacterNameS(me)) + " will not enter.\n");
	fail
    else
	AddHead(me@p_pEnterActions, emailResetHandler);
	AddHead(me@p_pExitActions, emailAllDone);
	me@p_pNSaveHandler := SetCharacterInputAction(emailParse);
	me@p_pNSavePrompt := SetPrompt("telegram office> ");
	continue
    fi
corp;

define tp_email proc emailExit()status:
    thing me;

    me := Me();
    DelElement(me@p_pEnterActions, emailResetHandler);
    DelElement(me@p_pExitActions, emailAllDone);
    ignore SetCharacterInputAction(me@p_pNSaveHandler);
    ignore SetPrompt(me@p_pNSavePrompt);
    me -- p_pEmailTo;
    me -- p_pEmailSubject;
    continue
corp;

define tp_email r_emailRoom CreateThing(r_indoors)$
SetupRoom(r_emailRoom, "in the telegram office",
    "In this room, there are additional commands which are used to read, "
    "reply to, and send electronic mail letters. Use 'help' to find out "
    "how to use the service provided here.")$
r_emailRoom@p_rNoMachines := true$
Connect(r_ne1, r_emailRoom, D_EAST)$
Connect(r_ne1, r_emailRoom, D_ENTER)$
ExtendDesc(r_ne1,
    "To the east is a modest brick building of simple, but functional "
    "architecture. A single wooden door without any windows opens directly "
    "onto the sidewalk. Hanging by the door is a sign which reads \"Telegram "
    "Office\". Small windows on each side of the door are firmly shut, and "
    "each is covered by a green pull-down roller blind.")$
AddEastChecker(r_ne1, emailEnter, false)$
AddEnterChecker(r_ne1, emailEnter, false)$
AddWestChecker(r_emailRoom, emailExit, false)$
AddExitChecker(r_emailRoom, emailExit, false)$
Sign(r_ne1, "sign;hanging.door;sign,hanging,by,the", "","\"Telegram Office\"")$
Scenery(r_ne1,
    "building;modest,brick."
    "brick."
    "door;wooden,windowless."
    "blind;green,pull-down,pull,down,roller")$

define tp_email TELEGRAM_OFFICE_ID NextEffectId()$
define tp_email proc drawEMailRoom()void:

    if not KnowsEffect(nil, TELEGRAM_OFFICE_ID) then
	DefineEffect(nil, TELEGRAM_OFFICE_ID);
	GSetImage(nil, "Town/telegramOffice");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    TextBox("Read and post", "usenet mail", "here");
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, TELEGRAM_OFFICE_ID);
corp;

RoomGraphics(r_emailRoom, "Telegram", "Office", NextMapGroup(), 0.0, 0.0,
	     drawEMailRoom)$

unuse tp_email
unuse t_streets
