/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * quests.m - define the quest setup for the starter scenario.
 */

private tp_quests CreateTable().
use tp_quests

/* define some Quest stuff here so that we can refer to it from everywhere */

define t_quests QuestThing CreateThing(nil).
define t_quests p_QuestState CreateIntProp().
define t_quests p_QuestActive CreateActionProp().
define t_quests p_pQuestDoneList CreateThingListProp().
define tp_quests p_sQuestName CreateStringProp().
define tp_quests p_sQuestDesc CreateActionProp().
define tp_quests p_sQuestChecker CreateActionProp().
define tp_quests p_sQuestHint CreateActionProp().
define tp_quests p_sQuestType CreateIntProp().
define tp_quests QUEST_DIRECT	0.
define tp_quests QUEST_GIVE	1.
define tp_quests QUEST_TELL	2.
define tp_quests p_sQuestList CreateThingListProp().

define tp_quests proc dummy()void: corp;
QuestThing@p_QuestState := 0.
QuestThing@p_QuestActive := dummy.
QuestThing@p_sQuestList := CreateThingList().

define t_quests proc QuestDirect(string name; action desc, checker, hint)void:
    thing quest;

    if desc = nil or checker = nil or hint = nil then
	Print("*** Invalid action given to QuestDirect.\n");
    else
	quest := CreateThing(nil);
	quest@p_sQuestName := name;
	quest@p_sQuestDesc := desc;
	quest@p_sQuestChecker := checker;
	quest@p_sQuestHint := hint;
	quest@p_sQuestType := QUEST_DIRECT;
	AddTail(QuestThing@p_sQuestList, quest);
    fi;
corp;

define t_quests proc QuestGive(string name; action desc, checker, hint)void:
    thing quest;

    if desc = nil or checker = nil or hint = nil then
	Print("*** Invalid action given to QuestGive.\n");
    else
	quest := CreateThing(nil);
	quest@p_sQuestName := name;
	quest@p_sQuestDesc := desc;
	quest@p_sQuestChecker := checker;
	quest@p_sQuestHint := hint;
	quest@p_sQuestType := QUEST_GIVE;
	AddTail(QuestThing@p_sQuestList, quest);
    fi;
corp;

define t_quests proc public GiveToQuestor(string what)void:
    thing me;

    me := TrueMe();
    SPrint(me, "You give the " + what + " to Questor.\n");
    ABPrint(AgentLocation(me), me, nil,
	    FormatName(me@p_pName) + AAn(" gives", what) + " to Questor.\n");
corp;

define t_quests proc QuestTell(string name; action desc, checker, hint)void:
    thing quest;

    if desc = nil or checker = nil or hint = nil then
	Print("*** Invalid action given to QuestTell.\n");
    else
	quest := CreateThing(nil);
	quest@p_sQuestName := name;
	quest@p_sQuestDesc := desc;
	quest@p_sQuestChecker := checker;
	quest@p_sQuestHint := hint;
	quest@p_sQuestType := QUEST_TELL;
	AddTail(QuestThing@p_sQuestList, quest);
    fi;
corp;

define t_quests proc public DoQuest(action checker)void:
    list thing quests, lt;
    thing me, quest;
    int i;

    me := Me();
    quests := QuestThing@p_sQuestList;
    for i from 0 upto Count(quests) - 1 do
	quest := quests[i];
	if quest@p_sQuestChecker = checker then
	    lt := me@p_pQuestDoneList;
	    if lt = nil then
		lt := CreateThingList();
		me@p_pQuestDoneList := lt;
	    fi;
	    if FindElement(lt, quest) ~= -1 then
		Print("You have already completed the " +
		    quest@p_sQuestName + " quest!\n");
	    else
		AddTail(lt, quest);
		APrint("\n" + FormatName(me@p_pName) +
		    " has completed a quest!!\n\n");
	    fi;
	fi;
    od;
corp;

define t_quests proc public DoneQuest(action checker)bool:
    list thing lt;
    int i;
    bool found;

    found := false;
    lt := Me()@p_pQuestDoneList;
    if lt ~= nil then
	for i from 0 upto Count(lt) - 1 do
	    if lt[i]@p_sQuestChecker = checker then
		found := true;
	    fi;
	od;
    fi;
    found
corp;

define t_util proc ShowQuests(thing who)bool:
    list thing lt;
    int count;

    lt := who@p_pQuestDoneList;
    if lt = nil then
	false
    else
	count := Count(lt);
	if count = 0 then
	    false
	else
	    Print(who@p_pName + " has completed ");
	    if count = 1 then
		Print("one quest.\n");
	    else
		IPrint(count);
		Print(" quests.\n");
	    fi;
	    true
	fi
    fi
corp;

define tp_quests Questor CreateThing(nil).
define tp_quests p_rQuestUser CreateThingProp().
define tp_quests p_pSaveIdle CreateActionProp().

define tp_quests QUESTROOM_ID NextEffectId().
define tp_quests proc drawQuestRoom()void:
    int i;

    if not KnowsEffect(nil, QUESTROOM_ID) then
	DefineEffect(nil, QUESTROOM_ID);
	GSetImage(nil, "questRoom");
	IfFound(nil);
	    GShowImage(nil, "", 0, 0, 160, 100, 0, 0);
	Else(nil);
	    for i from 0 upto 3 do
		GSetPen(nil, i + 1);
		GAMove(nil, 16 + i, 24 + i);
		GRectangle(nil, 128 - 2 * i, 52 - 2 * i, false);
	    od;
	    GSetPen(nil, C_GOLD);
	    GAMove(nil, 28, 48);
	    GText(nil, "Complete your");
	    GAMove(nil, 36, 56);
	    GText(nil, "quests here");
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, QUESTROOM_ID);
corp;

define tp_quests r_questRoom CreateThing(nil).
SetupRoom(r_questRoom, "in Questor's office",
    "The office is old-fashioned, but quite opulent in its way. The walls "
    "are lined with shelves and racks containing all sorts of trophies. "
    "There are fine collections of Bushman spears, Watusi shields, "
    "Aborigine horns, Iroquois pipes, samurai swords, Malay masks, "
    "modern skateboards, Meershaum pipes, etc. One large case contains "
    "a zoo of live-looking animals, many of which you cannot classify. "
    "A shelf contains jars, each filled with smaller, very dead-looking "
    "animals. Many appear to have faces and hands. Questor's desk is a "
    "large construction of red-swirled marble. It is quite neat and tidy, "
    "with a couple of piles of papers, a fine onyx pen-stand and a trio "
    "of Faberge eggs. Behind the desk is a matching marble chair with "
    "purple velvet cushions and a pair of huge gems as handrests. Arching "
    "over Questor's head (for he is sitting in the chair watching you as "
    "you stare around) is a cobra with flaring hood, carved from pure "
    "white marble. The cobra's eyes are deep red and it seems to be watching "
    "you.").
r_questRoom@p_rNoMachines := true.
Scenery(r_questRoom,
    "wall,shelf,shelves,rack,trophy,trophies,collection,case;fine,large."
    "spear;Bushman."
    "shield;Watusi."
    "horn;Aborigine."
    "pipe;Iroquois."
    "sword;samurai."
    "mask;Malay."
    "skateboard,board;skate,modern."
    "pipe;Meerschaum."
    "zoo."
    "animal;live-looking,live,looking,dead-looking,dead."
    "jar."
    "face,hand."
    "desk;large,red-swirled,red,swirled,marble."
    "paper,pile;piles,of."
    "pen-stand,stand;pen,fine,onyx."
    "egg;Faberge,trio,of."
    "chair;matching,marble."
    "cushion;purple,velvet."
    "gem,handrest,rest;hand,pair,of,huge,gem."
    "cobra,hood;with,flaring,hood,pure,white,marble."
    "eye;cobra's,cobra,deep,red."
    "beard,mustache,eyebrow,brow;eye,long,flowing,massive,white."
    "cloak,satin;long,flowing,jet-black,jet,black,satin."
    "pendant;extremely,large,ugly."
    "q,'q';letter."
    "chain,link;chain,of,iron.").
RoomGraphics(r_questRoom, "Questor's", "Office", NextMapGroup(), 0, 0,
	     drawQuestRoom).
FakeObject(CreateThing(nil), r_questRoom, "eye;Questor's,Questor",
    "Questor's eyes are not something you want to stare at.").
FakeObject(CreateThing(nil), r_questRoom, "eye;cobra's,snake's,cobra,snake",
    "The stone cobra's eyes seem to be watching you.").

/*
 * Just in case some wise-guy wizard tries to force him out.
 */

define tp_quests proc questorExit()status:

    if Me() = Questor then
	fail
    else
	continue
    fi
corp;
AddAnyLeaveChecker(r_questRoom, questorExit, false).

define tp_quests proc emptyQuestor()void:
    list thing lt;
    int i;
    thing th;

    lt := Questor@p_pCarrying;
    i := Count(lt);
    while i ~= 0 do
	i := i - 1;
	th := lt[i];
	ZapObject(th);
	DelElement(lt, th);
    od;
corp;

define tp_quests proc questIdle()void:
    action a;

    emptyQuestor();
    a := Me()@p_pSaveIdle;
    ignore SetCharacterIdleAction(a);
    Me() -- p_pSaveIdle;
    SetLocation(r_questRoom@p_rExit);
    Questor -- p_rQuestUser;
    if a ~= nil then
	call(a, void)();
    fi;
corp;

define tp_quests proc questEnter()status:
    thing who;
    action a;

    who := Questor@p_rQuestUser;
    if who = nil then
	if Me()@p_pName ~= "Packrat" then
	    Questor@p_rQuestUser := Me();
	    Print(
		"The huge door opens easily, and you enter Questor's office.\n"
		"NOTE: no-one else can enter the office while you are in it - "
		"please keep your stay as short as possible. Thank-you.\n");
	    a := SetCharacterIdleAction(questIdle);
	    if a ~= nil then
		Me()@p_pSaveIdle := a;
	    fi;
	fi;
	continue
    else
	Print("The huge door will not open - you cannot enter. Questor is "
	    "currently in conference with " + FormatName(who@p_pName) + ".\n");
	fail
    fi
corp;

define tp_quests proc questExit()status:
    action a;

    emptyQuestor();
    Questor -- p_rQuestUser;
    ignore SetCharacterIdleAction(Me()@p_pSaveIdle);
    Me() -- p_pSaveIdle;
    Print("You open the huge door and go outside. "
	"Questor can now deal with other players.\n");
    QuestThing@p_QuestState := 0;
    continue
corp;

define tp_quests proc showQuests()string:
    list thing lt;
    int count, i, oldIndent;
    thing quest;
    string result;

    lt := QuestThing@p_sQuestList;
    count := Count(lt);
    if count = 0 then
	result := "There are no quests yet.";
    else
	result := "The current quests are:";
	oldIndent := GetIndent();
	for i from 0 upto count - 1 do
	    quest := lt[i];
	    result := result + "\n  " + quest@p_sQuestName + " quest: " +
		call(quest@p_sQuestDesc, string)();
	od;
	result := result + "\nIf you need a hint on a quest, just ask.";
    fi;
    result
corp;

define tp_quests proc questHint(string what)bool:
    list thing lt;
    thing quest;
    int count, i;
    bool found;

    if what = "" then
	Print("Use 'hint <quest-name>' to get a hint for a given quest.\n");
	false
    else
	lt := QuestThing@p_sQuestList;
	count := Count(lt);
	if count = 0 then
	    Print("There are no quests yet!\n");
	    false
	else
	    if SubString(what, 0, 6) = "quest;" then
		what := SubString(what, 6, Length(what) - 6);
	    fi;
	    found := false;
	    for i from 0 upto count - 1 do
		quest := lt[i];
		if quest@p_sQuestName == what then
		    Print(call(quest@p_sQuestHint, string)() + "\n");
		    found := true;
		fi;
	    od;
	    if not found then
		Print("There is no '" + what + "' quest.\n");
		false
	    else
		true
	    fi
	fi
    fi
corp;

define tp_quests proc questorStep()void:
corp;

define tp_quests proc questorSay(string what)void:
    list thing lt;
    thing quest, player;
    int count, i;
    bool found, foundSpecial;
    string who, word, specialWord;

    player := Questor@p_rQuestUser;
    SetIt(player);
    who := SetSay(what);
    found := false;
    specialWord := "";
    while
	word := GetWord();
	word ~= "" and not found
    do
	lt := QuestThing@p_sQuestList;
	count := Count(lt);
	i := 0;
	while i ~= count and not found do
	    quest := lt[i];
	    if quest@p_sQuestType = QUEST_TELL and
		call(quest@p_sQuestChecker, bool)(word)
	    then
		found := true;
		i := count;
		lt := player@p_pQuestDoneList;
		if lt = nil then
		    lt := CreateThingList();
		    player@p_pQuestDoneList := lt;
		fi;
		if FindElement(lt, quest) ~= -1 then
		    SPrint(player, "You have already completed the " +
			quest@p_sQuestName + " quest!\n");
		else
		    SPrint(player,
			"Questor smiles warmly and says: Congratulations " +
			who +  ", you have completed the " +
			quest@p_sQuestName + " quest!\n");
		    AddTail(lt, quest);
		    APrint("\n" + who + " has completed a quest!!\n\n");
		fi;
	    else
		if word == "quest" or word == "quests" or
		    word == "info" or word == "information" or
		    word == "help" or word == "hint" or word == "hints"
		then
		    specialWord := word;
		fi;
		i := i + 1;
	    fi;
	od;
    od;
    if not found then
	if specialWord ~= "" then
	    if specialWord == "hint" or specialWord == "hints" then
		DoSay("Go outside and ask - don't bother me!");
	    else
		DoSay("To find out about quests, read the sign outside!");
	    fi;
	elif who ~= "Packrat" then
	    DoSay("Quit gabbing and get down to it!");
	fi;
    fi;
corp;

define tp_quests proc questorWhisperMe(string what)void:

    if SetWhisperMe(what) ~= "" then
	DoSay("Don't try to get familiar with me!");
    fi;
corp;

define tp_quests proc questorOverhear(string what)void:

    DoSay("Whispering is impolite!");
corp;

define tp_quests proc questorSaw(string what)void:

    DoSay("Stop messing around!");
corp;

define tp_quests proc questorNoNo()status:

    Print("Questor glares at you, and so does the cobra!\n");
    fail
corp;

define tp_quests proc questorCreate()void:

    Questor@p_pStandard := true;
    SetupMachine(Questor);
    Questor@p_pDesc :=
	"Questor is a tall, skinny man with a long, flowing white beard and "
	"an equally long and flowing mustache. His massive white eyebrows "
	"don't flow quite as much. He wears a long, flowing (naturally) cloak "
	"of jet-black satin with no decorations. His head is bare (and a "
	"little bit bald on top), but on his chest is an extremely large "
	"and ugly pendant in the shape of the letter 'Q'. It is supported on "
	"a massive chain of iron links. Wearing this may account for his "
	"perpetual look of annoyance. All of these things you notice only "
	"briefly, before you look at his eyes, which are bright grey, and "
	"seem to penetrate to your very core.";
    CreateMachine("Questor", Questor, r_questRoom, questorStep);
    ignore SetMachineActive(Questor, questorStep);
    ignore SetMachineSay(Questor, questorSay);
    ignore SetMachineWhisperMe(Questor, questorWhisperMe);
    ignore SetMachineWhisperOther(Questor, questorOverhear);
    ignore SetMachinePose(Questor, questorSaw);
    GNewIcon(Questor, makeQuestorIcon());
    Questor@p_oTouchChecker := questorNoNo;
    Questor@p_oSmellChecker := questorNoNo;
    Questor@p_oPushChecker := questorNoNo;
    Questor@p_oPullChecker := questorNoNo;
    Questor@p_oTurnChecker := questorNoNo;
    Questor@p_oLiftChecker := questorNoNo;
    Questor@p_oLowerChecker := questorNoNo;
    Questor@p_oEatChecker := questorNoNo;
corp;
questorCreate();
ignore DeleteSymbol(tp_quests, "questorCreate").

define tp_quests proc questorPre()status:
    list thing lt;
    thing me, item, quest;
    string name;
    int count, i;
    status st;
    bool found;

    me := TrueMe();
    item := It();
    name := FormatName(me@p_pName);
    lt := QuestThing@p_sQuestList;
    count := Count(lt);
    found := false;
    i := 0;
    while i ~= count do
	quest := lt[i];
	if quest@p_sQuestType = QUEST_GIVE then
	    st := call(quest@p_sQuestChecker, status)();
	    if st ~= continue then
		found := true;
		i := count;
		lt := me@p_pQuestDoneList;
		if lt = nil then
		    lt := CreateThingList();
		    me@p_pQuestDoneList := lt;
		fi;
		if st = succeed then
		    if FindElement(lt, quest) ~= -1 then
			SPrint(me,
			       "Questor frowns and says: " + name +
			       ", you have already completed the " +
			       quest@p_sQuestName + " quest!\n");
		    else
			SPrint(me,
			    "Questor smiles warmly and says: Congratulations "+
			      name +  ", you have completed the " +
			      quest@p_sQuestName + " quest!\n");
			AddTail(lt, quest);
			APrint("\n" + name + " has completed a quest!!\n\n");
		    fi;
		fi;
		ZapObject(item);
		DelElement(me@p_pCarrying, item);
	    else
		i := i + 1;
	    fi;
	else
	    i := i + 1;
	fi;
    od;
    if found then succeed else continue fi
corp;

Questor@p_pGivePre := questorPre.

define tp_quests questSign CreateThing(nil).

/*
 * SetupQuestorOffice - set things up so that the given direction from the
 *	given location leads to Questor's office.
 */

define t_quests proc SetupQuestorOffice(thing where; int dir)void:

    Connect(where, r_questRoom, dir);
    Connect(where, r_questRoom, D_ENTER);
    AddDirChecker(where, dir, questEnter, false);
    AddDirChecker(r_questRoom, DirBack(dir), questExit, false);
    AddEnterChecker(where, questEnter, false);
    AddExitChecker(r_questRoom, questExit, false);
    ExtendDesc(where,
	"The building here appears to be constructed from solid granite "
	"blocks and is quite featureless. The door is a large one of foot-"
	"thick oak beams strengthed with iron straps. There are no windows. "
	"In the center of the door is the letter 'Q', pounded out of thick "
	"iron. Beside the door, a discreet sign labelled \"Quests\" has a "
	"list of some kind.");
    Scenery(where,
	"block;solid,granite."
	"building;featureless."
	"door,beam;foot-thick,foot,thick,oak."
	"strap;iron."
	"q,'q',letter;letter,thick,pounded,iron");
    FakeObject(questSign, where,
	"sign;discreet.sign,list,quest;discreet,quest,quests", "");
    questSign@p_oReadAction := showQuests;
    where@p_rHintAction := questHint;
corp;

/* setup the 'quests' verb */

define tp_quests proc v_quests()bool:
    string name;
    thing who;

    name := GetWord();
    if name = "" then
	if not ShowQuests(Me()) then
	    Print("You have not yet completed any quests.\n");
	fi;
	true
    else
	who := FindAgent(name);
	if who ~= nil then
	    if not ShowQuests(who) then
		Print(name + " has not yet completed any quests.\n");
	    fi;
	    true
	else
	    Print("There is no " + name + " here.\n");
	    false
	fi
    fi
corp;

VerbTail(G, "quests", v_quests).

unuse tp_quests
