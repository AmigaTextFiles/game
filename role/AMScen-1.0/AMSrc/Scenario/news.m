/*
 * Amiga MUD
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * news.m - allow the player to interact with usenet news.
 */

/* NOTE: this current setup is intended for use with Matt Dillon's UUCP
   and news distribution, version 1.16 or later. To use it with other
   forms of news, you will perhaps need to change various things.
   Dependencies: UULIB:NewsGroups, a hierarchical set of news directories
   in UUNEWS:, postnews, T: .

   NOTE: as of UUCP-V1.17b4, the s:UUConfig file allows the UUCP user to
   avoid having as many UUCP-related assigns. This AmigaMUD code does
   not attempt to read that file - it assumes the assigns it needs are
   present: UUNEWS: and UULIB: */

use t_streets

/* The following property is actually added to SysAdmin. It is used as a
   global variable to check whether this MUD allows players to set their
   own realnames. Since mail/news can go all over the world, many sysadmins
   may prefer that everything that originates with their site at least have
   a valid and traceable name attached to it. Set the value to 'true' if
   you want people to be able to change their own realnames. Think seriously
   about it before you do it. */

define tp_news NewsThing CreateThing(nil).
define tp_news p_pCanChangeName CreateBoolProp().
NewsThing@p_pCanChangeName := false.

define tp_news g_news CreateGrammar().

define tp_news p_pNRealName CreateStringProp().
define tp_news p_pNSaveHandler CreateActionProp().
define tp_news p_pNSavePrompt CreateStringProp().
define tp_news p_pNGroupList CreateThingListProp().
define tp_news p_pNCurrentGroup CreateIntProp().
define tp_news p_pNUnreadIndex CreateIntProp().
define tp_news p_pNCurrentArticle CreateIntProp().
define tp_news p_pNFd CreateIntProp().
define tp_news p_pNString CreateStringProp().
define tp_news p_pNString2 CreateStringProp().
define tp_news p_pNSubject CreateStringProp().

define tp_news p_NGroupName CreateStringProp().
define tp_news p_NHighestRead CreateIntProp().
define tp_news p_NLowest CreateIntProp().
define tp_news p_NHighest CreateIntProp().
define tp_news p_NUnread CreateIntListProp().

CharacterThing(SysAdmin)@p_pNRealName := "MUD administrator".

define tp_news proc nv_help()bool:
    Print(
"Commands in the newsroom are:\n\n"
"  info - some additional comments on MUD news\n"
"  groups/newsgroups - print the available groups\n"
"  subscribe/sub - print the groups you are subscribed to\n"
"  subscribe/sub \"group\" - subscribe to the given group\n"
"  unsubscribe/unsub \"group\" - unsubscribe from the given group\n"
"  catchup \"group\" - mark all current articles as read\n"
"  read - start reading news\n"
"  name/realname <name> - set your real name to <name>\n"
"  post \"group\" [subject] - post an article to the given group\n"
    );
    true
corp;

Verb0(g_news, "help", 0, nv_help).
Synonym(g_news, "help", "?").

define tp_news proc nv_info()bool:

    Print(
"Newsgroup names almost always contain periods, so you must enclose them in "
"quotes to prevent MUD's normal parsing from treating e.g.\n"
"    subscribe rec.games.mud.misc\n"
"as 'subscribe rec' followed by 'games' followed by 'mud' followed by 'misc'. "
"The optional subject on the 'post' command can be quoted or not, depending "
"on whether you need to put punctuation in it. Similarly, your real name on "
"the 'name' command can be quoted or not. The MUD newsreader is quite "
"primitive - it doesn't understand message threads, followups, replies, etc. "
"If you need to use usenet news a lot, you should try to get a normal usenet "
"connection.\n"
    );
    true
corp;

Verb0(g_news, "info", 0, nv_info).

define tp_news proc nv_groups()bool:
    int fd, blank;
    string line;
    bool first;

    fd := FileOpenForRead("UULIB:NewsGroups");
    if fd = 0 then
	Print("This MUD is not set up to offer news reading.\n");
    else
	Print("Newsgroups available on this machine:\n");
	first := true;
	while
	    line := FileRead(fd);
	    line ~= ""
	do
	    blank := Index(line, " ");
	    if blank < 0 then
		blank := Index(line, "\t");
	    fi;
	    if blank > 0 then
		line := SubString(line, 0, blank);
	    fi;
	    if not line == "Junk" then
		if first then
		    first := false;
		else
		    Print(", ");
		fi;
		Print(line);
	    fi;
	od;
	Print("\n");
	FileClose(fd);
    fi;
    true
corp;

Verb0(g_news, "groups", 0, nv_groups).
Synonym(g_news, "groups", "group");
Synonym(g_news, "groups", "newsgroups").

define tp_news proc nv_subscribe(string group)bool:
    thing me, th;
    int count, n, fd;
    list thing lt;
    string line;

    me := Me();
    lt := me@p_pNGroupList;
    if group = "" then
	if lt = nil or Count(lt) = 0 then
	    Print("You are not currently subscribed to any groups.\n");
	else
	    Print("You are currently subscribed to the following groups:\n");
	    count := Count(lt);
	    n := 0;
	    while n ~= count do
		Print("  ");
		Print(lt[n]@p_NGroupName);
		Print("\n");
		n := n + 1;
	    od;
	fi;
    else
	fd := FileOpenForRead("UULIB:NewsGroups");
	if fd = 0 then
	    Print("This MUD is not set up to offer news reading.\n");
	else
	    if lt = nil then
		lt := CreateThingList();
		me@p_pNGroupList := lt;
	    fi;
	    while
		line := FileRead(fd);
		if line = "" then
		    false
		else
		    n := Index(line, " ");
		    if n < 0 then
			n := Index(line, "\t");
		    fi;
		    if n > 0 then
			line := SubString(line, 0, n);
		    fi;
		    not line == group
		fi
	    do
	    od;
	    FileClose(fd);
	    if line = "" then
		Print(
		    "This MUD does not have group \"" + group + "\".\n"
		    "You probably need to enclose the group name in quotes.\n"
		);
	    elif FindName(me@p_pNGroupList, p_NGroupName, group) ~= fail then
		Print("You already subscribe to group \"" + group + "\".\n");
	    else
		th := CreateThing(nil);
		th@p_NGroupName := group;
		th@p_NHighestRead := 0;
		th@p_NUnread := CreateIntList();
		th@p_NLowest := 0;
		th@p_NHighest := 0;
		AddTail(lt, th);
		Print("Subscribed to group \"" + group + "\".\n");
	    fi;
	fi;
    fi;
    true
corp;

Verb1(g_news, "subscribe", 0, nv_subscribe).
Synonym(g_news, "subscribe", "sub").

define tp_news proc nv_unsubscribe(string name)bool:
    thing me, group;
    list thing lt;

    if name = "" then
	Print("You must specify a group to unsubscribe from.\n");
	false
    else
	me := Me();
	lt := me@p_pNGroupList;
	if lt = nil or FindName(me@p_pNGroupList, p_NGroupName, name) = fail
	then
	    Print("You are not subscribed to group \"" + name + "\".\n");
	else
	    group := FindResult();
	    DelElement(lt, group);
	    ClearThing(group);
	    Print("Unsubscribed from group \"" + name + "\".\n");
	fi;
	true
    fi
corp;

Verb1(g_news, "unsubscribe", 0, nv_unsubscribe).
Synonym(g_news, "unsubscribe", "unsub").

define tp_news proc newsParse(string input)void: corp;
define tp_news proc newsGroupParse(string line)void: corp;
define tp_news proc newsHeaderParse(string line)void: corp;

define tp_news proc readDotNextFile(string name)int:
    int i;
    string path, line;

    path := name;
    while
	i := Index(path, ".");
	i ~= -1
    do
	path := StringReplace(path, i, "/");
    od;
    i := FileOpenForRead("UUNEWS:" + path + "/.next");
    if i = 0 then
	Print(name + ": no such newsgroup???\n");
    else
	/* Grrr. This was not needed in older UUCP stuff! Note that it WILL
	   work for multiple simultaneous readers, since this whole set of
	   stuff is done atomically for a given client. */
	FileClose(i);
	i := FileOpenForWrite("t:crfile");
	FileWrite(i, "\n");
	FileClose(i);
	Execute("join UUNEWS:" + path + "/.next t:crfile as t:.next");
	i := FileOpenForRead("t:.next");
	if i ~= 0 then
	    line := FileRead(i);
	    FileClose(i);
	    i := StringToPosInt(line);
	    if i <= 0 then
		Print(name + ": something wrong in .next file!\n");
		i := 0;
	    fi;
	fi;
	Execute("delete t:crfile t:.next");
    fi;
    i
corp;

define tp_news proc openArticleFile(string name; int article)int:
    int i;
    string path;

    path := name;
    while
	i := Index(path, ".");
	i ~= -1
    do
	path := StringReplace(path, i, "/");
    od;
    FileOpenForRead("UUNEWS:" + path + "/" + IntToString(article))
corp;

define tp_news proc nv_catchUp(string name)bool:
    thing me, group;
    list thing lt;
    int nextArticle;

    if name = "" then
	Print("You must specify a group to catchup in.\n");
	false
    else
	me := Me();
	lt := me@p_pNGroupList;
	if lt = nil or FindName(me@p_pNGroupList, p_NGroupName, name) = fail
	then
	    Print("You are not subscribed to group \"" + name + "\".\n");
	else
	    group := FindResult();
	    nextArticle := readDotNextFile(name);
	    if nextArticle >= 0 then
		if nextArticle = 1 then
		    Print("No articles to catch up yet!\n");
		else
		    group@p_NHighestRead := nextArticle - 1;
		    Print("Caught up in group \"" + name + "\".\n");
		fi;
	    fi;
	fi;
	true
    fi
corp;

Verb1(g_news, "catchup", 0, nv_catchUp).

define tp_news proc newsFindNextGroup()bool:
    list thing lt;
    thing me, group;
    int which, groupCount, fd, nextArticle, cnt, lo, hi, mid;
    string name, prompt;
    list int li;
    bool gotOne;

    me := Me();
    lt := me@p_pNGroupList;
    groupCount := Count(lt);
    gotOne := false;
    which := me@p_pNCurrentGroup;
    while
	if which >= groupCount then
	    false
	else
	    group := lt[which];
	    name := group@p_NGroupName;
	    nextArticle := readDotNextFile(name);
	    if nextArticle <= 1 then
		true
	    else
		lo := group@p_NHighestRead;
		hi := nextArticle - 1;
		while lo < hi do
		    mid := (lo + hi) / 2;
		    fd := openArticleFile(name, mid);
		    if fd = 0 then
			lo := mid + 1;
		    else
			FileClose(fd);
			hi := mid - 1;
		    fi;
		od;
		/* sometimes miss by one */
		fd := openArticleFile(name, lo);
		if fd = 0 then
		    lo := lo + 1;
		else
		    FileClose(fd);
		fi;
		group@p_NLowest := lo;
		lo := lo - 1;
		if group@p_NHighestRead < lo then
		    group@p_NHighestRead := lo;
		fi;
		hi := nextArticle - 1;
		group@p_NHighest := hi;
		lo := group@p_NHighestRead;
		prompt := "Group " + name + " has ";
		if lo < hi then
		    gotOne := true;
		    prompt := prompt + IntToString(hi - lo) + " new";
		fi;
		li := group@p_NUnread;
		cnt := Count(li);
		mid := 0;
		lo := 0;
		hi := 0;
		while hi < cnt do
		    mid := li[hi];
		    fd := openArticleFile(name, mid);
		    if fd ~= 0 then
			FileClose(fd);
			lo := lo + 1;
		    fi;
		    hi := hi + 1;
		od;
		if lo ~= 0 then
		    if not gotOne then
			gotOne := true;
		    else
			prompt := prompt + " and ";
		    fi;
		    prompt := prompt + IntToString(lo) + " old";
		fi;
		if gotOne then
		    Print(prompt + " unread articles.\n");
		    false
		else
		    true
		fi
	    fi
	fi
    do
	which := which + 1;
    od;
    me@p_pNCurrentGroup := which;
    gotOne
corp;

define tp_news proc newsAllDone()void:

    ignore SetPrompt("newsroom> ");
    ignore SetCharacterInputAction(newsParse);
corp;

define tp_news proc newsReadGroup()void:

    Me()@p_pNUnreadIndex := 0;
    ignore SetPrompt("Rnq? ");
    ignore SetCharacterInputAction(newsGroupParse);
corp;

define tp_news proc newsNextGroup()void:

    Me()@p_pNCurrentGroup := Me()@p_pNCurrentGroup + 1;
    if newsFindNextGroup() then
	newsReadGroup();
    else
	newsAllDone();
    fi;
corp;

define tp_news proc newsFindNextArticle()bool:
    thing me, group;
    int article;
    list int unread;
    string line;

    me := Me();
    group := me@p_pNGroupList[me@p_pNCurrentGroup];
    article := me@p_pNUnreadIndex;
    unread := group@p_NUnread;
    if article >= Count(unread) then
	article := group@p_NHighestRead + 1;
	if article > group@p_NHighest then
	    false
	else
	    me@p_pNCurrentArticle := article;
	    true
	fi
    else
	me@p_pNCurrentArticle := unread[article];
	true
    fi
corp;

define tp_news proc newsShowHeader()bool:
    thing me;
    int article, fd, colon;
    string line, header;

    me := Me();
    fd := openArticleFile(
	    me@p_pNGroupList[me@p_pNCurrentGroup]@p_NGroupName,
	    me@p_pNCurrentArticle);
    if fd ~= 0 then
	while
	    line := FileRead(fd);
	    if line = "" then
		false
	    else
		colon := Index(line, ":");
		if colon <= 0 then
		    false
		else
		    header := SubString(line, 0, colon);
		    Index(header, " ") < 0
		fi
	    fi
	do
	    Print(line);
	    Print("\n");
	od;
	me@p_pNFd := fd;
	if line ~= "" then
	    me@p_pNString := line;
	fi;
	true
    else
	false
    fi
corp;

define tp_news proc newsNextArticle()void:
    thing me, group;
    int index;

    me := Me();
    group := me@p_pNGroupList[me@p_pNCurrentGroup];
    if newsFindNextArticle() then
	if newsShowHeader() then
	    ignore SetPrompt("Rnsq? ");
	    ignore SetCharacterInputAction(newsHeaderParse);
	else
	    Print("Hmm. Article has disappeared!\n");
	fi;
    else
	Print("End of group " + group@p_NGroupName + ".\n");
	newsNextGroup();
    fi;
corp;

define tp_news proc newsDoneArticle()void:
    thing me, group;
    int index;

    me := Me();
    index := me@p_pNUnreadIndex;
    group := me@p_pNGroupList[me@p_pNCurrentGroup];
    if index < Count(group@p_NUnread) then
	RemHead(group@p_NUnread);
    else
	group@p_NHighestRead := group@p_NHighestRead + 1;
    fi;
    newsNextArticle();
corp;

define tp_news proc newsFileClose()void:
    int fd;

    fd := Me()@p_pNFd;
    if fd ~= 0 then
	FileClose(fd);
	Me()@p_pNFd := 0;
    fi;
corp;

define tp_news proc newsUnreadArticle()void:
    thing me, group;

    me := Me();
    group := me@p_pNGroupList[me@p_pNCurrentGroup];
    if me@p_pNUnreadIndex >= Count(group@p_NUnread) then
	AddTail(group@p_NUnread, me@p_pNCurrentArticle);
	me@p_pNUnreadIndex := me@p_pNUnreadIndex + 1;
	group@p_NHighestRead := group@p_NHighestRead + 1;
    fi;
    Print("Marking article as unread.\n");
    newsNextArticle();
corp;

define tp_news proc newsEndParse(string line)void:

    if line = "" or line == "n" then
	newsDoneArticle();
    elif line == "s" then
	newsUnreadArticle();
    elif line == "q" then
	newsNextGroup();
    else
	Print("Options are:\n"
		"  n - go on to next article\n"
		"  s - mark article as unread\n"
		"  q - exit from this group\n"
		"Empty line is equivalent to 'n'\n"
	);
    fi;
corp;

define tp_news proc newsShowPage()bool:
    thing me;
    int fd, length, n, width, len;
    string line;

    me := Me();
    fd := me@p_pNFd;
    length := TextHeight(0);
    width := TextWidth(0);
    line := me@p_pNString;
    me -- p_pNString;
    n := 1;
    while
	if n >= length - 1 then
	    false
	else
	    if line = "" then
		line := FileRead(fd);
	    fi;
	    if line = "" then
		FileClose(fd);
		me@p_pNFd := 0;
		ignore SetPrompt("Nsq? ");
		ignore SetCharacterInputAction(newsEndParse);
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
	line := "";
    od;
    line ~= ""
corp;

define tp_news proc newsBodyParse(string line)void:

    if line = "" or line == "c" then
	ignore newsShowPage();
    elif line == "n" then
	newsFileClose();
	newsDoneArticle();
    elif line == "s" then
	newsFileClose();
	newsUnreadArticle();
    elif line == "q" then
	newsFileClose();
	newsNextGroup();
    else
	Print("Options are:\n"
		"  c - continue with article\n"
		"  n - go on to next article\n"
		"  s - mark article as unread\n"
		"  q - exit from this group\n"
		"Empty line is equivalent to 'c'\n"
	);
    fi;
corp;

replace newsHeaderParse(string line)void:

    if line = "" or line == "r" or line == "y" then
	if newsShowPage() then
	    ignore SetCharacterInputAction(newsBodyParse);
	    ignore SetPrompt("[M O R E] Cnsq? ");
	fi;
    elif line == "n" then
	newsFileClose();
	newsDoneArticle();
    elif line == "s" then
	newsFileClose();
	newsUnreadArticle();
    elif line == "q" then
	newsFileClose();
	newsNextGroup();
    else
	Print("Options are:\n"
		"  r - read the body of this article\n"
		"  n - go on to next article\n"
		"  s - mark article as unread\n"
		"  q - exit from this group\n"
		"Empty line is equivalent to 'r'\n"
	);
    fi;
corp;

replace newsGroupParse(string line)void:

    if line = "" or line == "r" then
	newsNextArticle();
    elif line == "n" then
	newsNextGroup();
    elif line == "q" then
	newsAllDone();
    else
	Print("Options are:\n"
	    "  r - read this group\n"
	    "  n - go to next group with unread articles\n"
	    "  q - exit to top level\n"
	    "Empty line is equivalent to 'r'\n"
	);
    fi;
corp;

define tp_news proc nv_read()bool:
    thing me;

    me := Me();
    if me@p_pNGroupList ~= nil then
	me@p_pNCurrentGroup := 0;
	if newsFindNextGroup() then
	    newsReadGroup();
	else
	    Print("No unread news in subscribed-to groups.\n");
	fi;
    else
	Print("You are not subscribed to any groups.\n");
    fi;
    true
corp;

Verb0(g_news, "read", 0, nv_read).

replace newsParse(string input)void:
    string word;

    SetTail(input);
    word := GetWord();
    if word ~= "" then
	if FindAnyWord(g_news, word) ~= 0 then
	    ignore Parse(g_news, input);
	else
	    ignore Parse(G, input);
	fi;
    fi;
corp;

define tp_news proc newsPostArticle(string s)void:
    int fd;
    thing me;

    me := Me();
    if s = "" then
	Print("Empty article - not posted.\n");
    else
	/* note: server runs atomically, so no conflict over the temp file */
	fd := FileOpenForWrite("T:MUD.article");
	if fd = 0 then
	    Print("Sorry - can't open article file.\n");
	else
	    /* You might be tempted to put a 'Run' in front of the postnews
	       command, so that the player is not hung waiting for an
	       automatic 'batchnews' run. Beware, however, since doing so
	       might allow 'batchnews' to be run twice at the same time, with
	       the resultant news duplication. */
	    Print("Posting article (could take a while) ...\n");
	    OPrint(""); 	/* force a flush */
	    Log("'" + me@p_pName + "' posting article to " + me@p_pNString2 +
		"\n");
	    FileWrite(fd, "Newsgroups: " + me@p_pNString2 + "\n");
	    me -- p_pNString2;
	    if me@p_pNSubject ~= "" then
		FileWrite(fd, "Subject: " + me@p_pNSubject + "\n");
		me -- p_pNSubject;
	    fi;
	    FileWrite(fd, "X-NewsSoftware: AmigaMUD newsroom\n");
	    FileWrite(fd, "\n");
	    FileWrite(fd, s);
	    FileClose(fd);
	    Execute("postnews < T:MUD.article -f \"" + me@p_pName +
		    "\" -r \"" + me@p_pNRealName + "\""
		);
	    Execute("delete T:MUD.article");
	    Print("... done!\n");
	fi;
    fi;
corp;

define tp_news proc nv_post()bool:
    int fd, blank;
    string groupName, line;

    groupName := GetWord();
    if groupName = "" then
	Print("You must specify the name of the newsgroup to post to.\n");
	false
    else
	fd := FileOpenForRead("UULIB:NewsGroups");
	if fd = 0 then
	    Print("This MUD is not set up to offer news reading.\n");
	    false
	elif Me()@p_pNRealName = "" then
	    Print("You cannot post until you have a realname set up.\n");
	    false
	else
	    while
		line := FileRead(fd);
		if line = "" then
		    false
		else
		    blank := Index(line, " ");
		    if blank < 0 then
			blank := Index(line, "\t");
		    fi;
		    if blank > 0 then
			line := SubString(line, 0, blank);
		    fi;
		    not line == groupName
		fi
	    do
	    od;
	    FileClose(fd);
	    if line = "" then
		Print(
		    "This MUD does not have group \"" + groupName + "\".\n"
		    "You probably need to enclose the group name in quotes.\n"
		);
		false
	    else
		Me()@p_pNString2 := groupName;
		groupName := GetTail();
		if groupName ~= "" then
		    if SubString(groupName, 0, 1) = "\"" then
			groupName :=
			    SubString(groupName, 1, Length(groupName) - 2);
		    fi;
		    Me()@p_pNSubject := groupName;
		fi;
		GetDocument("post> ", "Enter news article", "",
			    newsPostArticle, true)
	    fi
	fi
    fi
corp;

VerbTail(g_news, "post", nv_post).

define tp_news proc nv_name()bool:
    thing me;
    string newName;

    if NewsThing@p_pCanChangeName then
	me := Me();
	newName := GetTail();
	if newName = "" then
	    Print(
		"To set up a real name for use with mail and news, use, e.g.\n"
		"   name \"John H. Smith\"\n");
	else
	    if Index(newName, "\"") = 0 then
		newName := SubString(newName, 1, Length(newName) - 2);
	    fi;
	    me@p_pNRealName := newName;
	    Print(
		"Your 'real name' is now '" + newName + "'. "
		"This will be used on news articles you post and on letters "
		"that you mail.\n");
	fi;
	true
    else
	Print(
	    "The sysadmin of this MUD has not allowed you to set your own "
	    "realname. Send a MUD mail message ('write to SysAdmin') to "
	    "him/her with your full name so that it can be set up. You will "
	    "need a pen and a pad (available from the store in the minimall) "
	    "to be able to do this.\n");
	false
    fi
corp;

VerbTail(g_news, "name", nv_name).
Synonym(g_news, "name", "realname").

define tp_news proc newsResetHandler()void:
    thing me;

    newsAllDone();
    me := Me();
    me -- p_pNString;
    me -- p_pNString2;
    me -- p_pNSubject;
    me@p_pNFd := 0;
corp;

define tp_news proc newsIdleHandler()void:

    newsFileClose();
    newsResetHandler();
corp;

define tp_news proc newsEnter()status:
    thing me;

    me := Me();
    if Character(me@p_pName) = nil then
	/* cannot do this stuff with machines! */
	OPrint(Capitalize(me@p_pName) + " will not enter.\n");
	fail
    else
	AddHead(me@p_pExitActions, newsIdleHandler);
	AddHead(me@p_pEnterActions, newsResetHandler);
	me@p_pNSaveHandler := SetCharacterInputAction(newsParse);
	me@p_pNSavePrompt := SetPrompt("newsroom> ");
	continue
    fi
corp;

define tp_news proc newsExit()status:
    thing me;

    me := Me();
    DelElement(me@p_pEnterActions, newsResetHandler);
    DelElement(me@p_pExitActions, newsIdleHandler);
    ignore SetCharacterInputAction(me@p_pNSaveHandler);
    ignore SetPrompt(me@p_pNSavePrompt);
    me -- p_pNSaveHandler;
    me -- p_pNSavePrompt;
    continue
corp;

define tp_news r_newsRoom CreateThing(r_indoors).
SetupRoom(r_newsRoom, "in the news room",
    "In this room, there are additional commands which are used to read and "
    "post news articles. Use 'help' to find out how to use the service "
    "provided here.").
r_newsRoom@p_rNoMachines := true.
Connect(r_ne2, r_newsRoom, D_EAST).
Connect(r_ne2, r_newsRoom, D_ENTER).
UniConnect(r_ne2, r_newsRoom, D_UP).
ExtendDesc(r_ne2,
    "The building here is old, but in good repair. Its exterior finish is "
    "that of smooth sandstone blocks, common in important buildings of the "
    "era. A wide staircase leads up to double wooden doors with diamond-paned "
    "windows. The doors are bordered by a pair of sandstone pillars, which "
    "support a similar cap, carved with a pair of lions rampant. At the very "
    "top of the building, you can see granite gargoyles on each corner. A "
    "plaque by the door reads \"Daily News\".").
AddEastChecker(r_ne2, newsEnter, false).
AddEnterChecker(r_ne2, newsEnter, false).
AddUpChecker(r_ne2, newsEnter, false).
AddWestChecker(r_newsRoom, newsExit, false).
AddExitChecker(r_newsRoom, newsExit, false).
Sign(r_ne2, "plaque.door;plaque,by,the", "", "\"Daily News\"").
Scenery(r_ne2,
    "gargoyle;granite."
    "building;old."
    "block;smooth,sandstone."
    "staircase;wide."
    "door;double,wooden."
    "window;diamond-paned,diamond,paned."
    "pillar;sandstone."
    "cap;sandstone."
    "lion;rampant."
    "rampant;lions,lion").

define tp_news proc drawXXXXRoom(string which)void:
    int i;

    GAMove(nil, 16, 24);
    for i from 0 upto 3 do
	GSetPen(nil, i + 1);
	GRectangle(nil, 128 - 2 * i, 52 - 2 * i, false);
	GRMove(nil, 1, 1);
    od;
    GSetPen(nil, C_GOLD);
    GAMove(nil, 28, 42);
    GText(nil, "Read and post");
    GAMove(nil, 36, 52);
    GText(nil, "usenet ");
    GText(nil, which);
    GAMove(nil, 64, 62);
    GText(nil, "here");
corp;

define tp_news NEWSROOM_ID NextEffectId().
define tp_news proc drawNewsRoom()void:

    if not KnowsEffect(nil, NEWSROOM_ID) then
	DefineEffect(nil, NEWSROOM_ID);
	GSetImage(nil, "Town/newsroom");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    drawXXXXRoom("news");
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, NEWSROOM_ID);
corp;

RoomGraphics(r_newsRoom, "NewsRoom", "", NextMapGroup(), 0, 0, drawNewsRoom).

unuse t_streets
