/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * chat.m - add a simple chat mode.
 */

private tp_chat CreateTable().
use tp_chat

define tp_chat ChatThing CreateThing(nil).
define tp_chat NoiseAdverbs CreateStringProp().
define tp_chat ActionAdverbs CreateStringProp().
ChatThing@NoiseAdverbs := "".
ChatThing@ActionAdverbs := "".

define tp_chat p_chSaveAction CreateActionProp().
define tp_chat p_chSaveIdle CreateActionProp().
define tp_chat p_chSavePrompt CreateStringProp().
define tp_chat p_chChatting CreateBoolProp().

define tp_chat p_chAliases CreateThingListProp().
define tp_chat p_chKey CreateStringProp().
define tp_chat p_chContents CreateStringProp().

define tp_chat proc chatHandler(string line)void:
    thing me, alias;
    list thing aliases;
    int count;
    string word, contents;
    bool found;

    me := Me();
    if line = "." then
	ignore SetPrompt(me@p_chSavePrompt);
	me -- p_chSavePrompt;
	ignore SetCharacterIdleAction(me@p_chSaveIdle);
	me -- p_chSaveIdle;
	ignore SetCharacterInputAction(me@p_chSaveAction);
	me -- p_chSaveAction;
	me -- p_chChatting;
    elif SubString(line, 0, 1) = "!" then
	call(me@p_chSaveAction, void)(SubString(line, 1, Length(line) - 1));
    else
	aliases := me@p_chAliases;
	SetTail(line);
	word := GetWord();
	if word == "alias" then
	    word := GetWord();
	    if word = "" then
		if aliases = nil then
		    Print("You have no chat aliases.\n");
		else
		    count := Count(aliases);
		    Print("Chat aliases:\n");
		    while count ~= 0 do
			count := count - 1;
			alias := aliases[count];
			Print("  ");
			Print(alias@p_chKey);
			Print(" => ");
			Print(alias@p_chContents);
			Print("\n");
		    od;
		fi;
	    else
		Print("Chat alias '");
		Print(word);
		Print("' ");
		found := false;
		if aliases ~= nil then
		    count := Count(aliases);
		    while count ~= 0 and not found do
			count := count - 1;
			alias := aliases[count];
			if alias@p_chKey == word then
			    found := true;
			fi;
		    od;
		fi;
		contents := GetTail();
		if contents = "" then
		    if found then
			ClearThing(alias);
			DelElement(aliases, alias);
			Print("removed.\n");
		    else
			Print("does not exist.\n");
		    fi;
		else
		    if SubString(contents, 0, 1) = "\"" then
			contents := SubString(contents, 1, Length(contents)-2);
		    fi;
		    if found then
			alias@p_chContents := contents;
			Print("updated.\n");
		    else
			if aliases = nil then
			    aliases := CreateThingList();
			    me@p_chAliases := aliases;
			fi;
			alias := CreateThing(nil);
			alias@p_chKey := word;
			alias@p_chContents := contents;
			AddTail(aliases, alias);
			Print("added.\n");
		    fi;
		fi;
	    fi;
	else
	    alias := nil;
	    if aliases ~= nil then
		count := Count(aliases);
		while count ~= 0 and not found do
		    count := count - 1;
		    alias := aliases[count];
		    if alias@p_chKey == word then
			found := true;
		    fi;
		od;
	    fi;
	    if found then
		DoSay(alias@p_chContents + " " + GetTail());
	    else
		DoSay(line);
	    fi;
	fi;
    fi;
corp;

define tp_chat proc chatIdle()void:
    action a;
    thing me;

    me := Me();
    ignore SetPrompt(me@p_chSavePrompt);
    me -- p_chSavePrompt;
    a := me@p_chSaveIdle;
    ignore SetCharacterIdleAction(a);
    me -- p_chSaveIdle;
    ignore SetCharacterInputAction(me@p_chSaveAction);
    me -- p_chSaveAction;
    me -- p_chChatting;
    if a ~= nil then
	call(a, void)();
    fi;
corp;

define tp_chat proc v_chat()bool:
    thing me;
    action oldAction;
    string tail;

    me := Me();
    if me@p_chChatting then
	Print("You are already in chat mode!\n");
	false
    else
	tail := GetTail();
	if tail = "" then
	    oldAction := SetCharacterInputAction(chatHandler);
	    if oldAction = nil then
		OPrint(FormatName(me@p_pName) + " is confused.\n");
		false
	    else
		me@p_chChatting := true;
		me@p_chSaveAction := oldAction;
		me@p_chSaveIdle := SetCharacterIdleAction(chatIdle);
		me@p_chSavePrompt := SetPrompt("chat> ");
		true
	    fi
	else
	    chatHandler(tail);
	    true
	fi
    fi
corp;

VerbTail(G, "c", v_chat).
Synonym(G, "c", "chat").

define tp_chat proc v_whisper()bool:
    string what, ch;
    character who;
    thing agent;

    what := GetWord();
    if what == "to" then
	what := GetWord();
    fi;
    if what = "" then
	Print("Specify who you want to whisper to.\n");
	false
    else
	ch := SubString(what, Length(what) - 1, 1);
	if ch = "," or ch = ":" then
	    what := SubString(what, 0, Length(what) - 1);
	fi;
	who := Character(what);
	if who = nil then
	    who := Character(Capitalize(what));
	fi;
	if who = nil then
	    agent := FindAgent(what);
	else
	    agent := CharacterThing(who);
	fi;
	if agent = nil then
	    Print("Can't whisper to " + what + ".\n");
	    false
	else
	    what := GetTail();
	    if what = "" then
		Print("Specify what you want to whisper to " +
		    FormatName(agent@p_pName) + ".\n");
		false
	    else
		if Me()@p_pEchoPose then
		    Print("You whisper to " + agent@p_pName + ": " +
			what + "\n");
		fi;
		note - Magic value of 10 is probability of being overheard;
		if Whisper("", what, agent, 10) then
		    true
		else
		    Print(FormatName(agent@p_pName) + " is not here!\n");
		    false
		fi
	    fi
	fi
    fi
corp;

VerbTail(G, "wh", v_whisper).
Synonym(G, "wh", "whisper").

define tp_chat proc v_pose()bool:
    string activity;

    activity := GetTail();
    if activity = "" then
	Print("You must give the pose/emote you want to do.\n");
	false
    elif not CanSee(Here(), Me()) then
	Print("It is dark - no-one could see you " + activity + "!\n");
	false
    elif Me()@p_pHidden then
	Print("You are hidden - no-one could see you " + activity + "!\n");
	false
    else
	Pose("", "=> " + activity);
	if Me()@p_pEchoPose then
	    Print("You => " + activity + ".\n");
	fi;
	true
    fi
corp;

VerbTail(G, "pose", v_pose).
Synonym(G, "pose", "emote").
Synonym(G, "pose", ":").

define tp_chat proc actionAdverb(string s)void:
    ChatThing@ActionAdverbs := ChatThing@ActionAdverbs + s;
corp;

actionAdverb("aimlessly,aimless,aim.").
actionAdverb("awkwardly,awkward,awk.").
actionAdverb("briefly,brief.").
actionAdverb("briskly,brisk.").
actionAdverb("clumsily,clumsy,clu.").
actionAdverb("crazily,crazy,cra.").
actionAdverb("deeply,deep.").
actionAdverb("enthusiastically,enthusiastic,enthuse,ent.").
actionAdverb("exitedly,excited,exc,e.").
actionAdverb("fervently,fervent,fer.").
actionAdverb("firmly,firm.").
actionAdverb("frentically,frentic,fren,fre.").
actionAdverb("furiously,furious,fur.").
actionAdverb("gayly,gay.").
actionAdverb("gracefully,gracefull,gra.").
actionAdverb("happily,happy,h.").
actionAdverb("hesitantly,hesitant,hes.").
actionAdverb("hurriedly,hurry,hur.").
actionAdverb("impatiently,impatient,imp.").
actionAdverb("majestically,majestic,maj.").
actionAdverb("merrily,merry,mer.").
actionAdverb("mischievously,mischievous,mis.").
actionAdverb("mockingly,mocking,mock.").
actionAdverb("mysteriously,mysterious,mys.").
actionAdverb("nastily,nasty,nas.").
actionAdverb("naughtily,naughty,nau.").
actionAdverb("passionately,passionate,pas.").
actionAdverb("patiently,patient,pat.").
actionAdverb("playfully,playfull,pla.").
actionAdverb("pointedly,pointed,poi.").
actionAdverb("politely,polite,pol.").
actionAdverb("quickly,quick,qui,q,f.").
actionAdverb("rapidly,rapid,rap.").
actionAdverb("sadly,sad.").
actionAdverb("sharply,sharp,sha.").
actionAdverb("slowly,slow,slo,s.").
actionAdverb("smoothly,smooth,smo.").
actionAdverb("solemnly,solemn,sol.").
actionAdverb("suddenly,sudden,sud.").
actionAdverb("suggestively,suggest,sug.").
actionAdverb("swiftly,swift,swi.").
actionAdverb("tiredly,tired,tir.").
actionAdverb("unhappily,unhappy,unh.").
actionAdverb("vaguely,vague,vag.").
actionAdverb("vigorously,vigorous,vig.").
actionAdverb("violently,violent,vio.").
actionAdverb("wearily,weary,wea.").
actionAdverb("wildly,wild,wil.").
actionAdverb("wobbly,wobble,wob.").

define tp_chat proc makeAction(string pose)bool:
    string adverb;
    int which;

    adverb := GetWord();
    if adverb ~= "" then
	which := MatchName(ChatThing@ActionAdverbs, adverb);
	if which ~= -1 then
	    adverb := SelectName(ChatThing@ActionAdverbs, which);
	    if not CanSee(Here(), Me()) then
		Print("It is dark - no-one could see you " + pose + "!\n");
		false
	    elif Me()@p_pHidden then
		Print("You are hidden - no-one could see you " + pose + "!\n");
		false
	    else
		Pose("", Pluralize(pose) + " " + SelectWord(adverb, 0) + ".");
		if Me()@p_pEchoPose then
		    Print("You " + pose + " " + SelectWord(adverb, 0) + ".\n");
		fi;
		true
	    fi
	else
	    Print("Unknown action adverb '" + adverb + "'. Known ones:\n");
	    which := 0;
	    while
		adverb := SelectName(ChatThing@ActionAdverbs, which);
		adverb ~= ""
	    do
		Print("  " + adverb + "\n");
		which := which + 1;
	    od;
	    false
	fi
    else
	if not CanSee(Here(), Me()) then
	    Print("It is dark - no-one could see you " + pose + "!\n");
	    false
	elif Me()@p_pHidden then
	    Print("You are hidden - no-one could see you " + pose + "!\n");
	    false
	else
	    Pose("", Pluralize(pose) + ".");
	    if Me()@p_pEchoPose then
		Print("You " + pose + ".\n");
	    fi;
	    true
	fi
    fi
corp;

define tp_chat proc v_blink()bool:
    makeAction("blink")
corp;

define tp_chat proc v_blush()bool:
    makeAction("blush")
corp;

define tp_chat proc v_bow()bool:
    makeAction("bow")
corp;

define tp_chat proc v_cower()bool:
    makeAction("cower")
corp;

define tp_chat proc v_cringe()bool:
    makeAction("cringe")
corp;

define tp_chat proc v_curtsey()bool:
    makeAction("curtsey")
corp;

define tp_chat proc v_dance()bool:
    makeAction("dance")
corp;

define tp_chat proc v_drool()bool:
    makeAction("drool")
corp;

define tp_chat proc v_gesticulate()bool:
    makeAction("gesticulate")
corp;

define tp_chat proc v_glare()bool:
    makeAction("glare")
corp;

define tp_chat proc v_grovel()bool:
    makeAction("grovel")
corp;

define tp_chat proc v_grimace()bool:
    makeAction("grimace")
corp;

define tp_chat proc v_grin()bool:
    makeAction("grin")
corp;

define tp_chat proc v_frown()bool:
    makeAction("frown")
corp;

define tp_chat proc v_hop()bool:
    makeAction("hop")
corp;

define tp_chat proc v_nod()bool:
    makeAction("nod")
corp;

define tp_chat proc v_pout()bool:
    makeAction("pout")
corp;

define tp_chat proc v_shudder()bool:
    makeAction("shudder")
corp;

define tp_chat proc v_shiver()bool:
    makeAction("shiver")
corp;

define tp_chat proc v_shrug()bool:
    makeAction("shrug")
corp;

define tp_chat proc v_smile()bool:
    makeAction("smile")
corp;

define tp_chat proc v_smirk()bool:
    makeAction("smirk")
corp;

define tp_chat proc v_sneer()bool:
    makeAction("sneer")
corp;

define tp_chat proc v_spit()bool:
    makeAction("spit")
corp;

define tp_chat proc v_tremble()bool:
    makeAction("tremble")
corp;

define tp_chat proc v_twitch()bool:
    makeAction("twitch")
corp;

define tp_chat proc v_wave()bool:
    makeAction("wave")
corp;

define tp_chat proc v_wince()bool:
    makeAction("wince")
corp;

define tp_chat proc v_wink()bool:
    makeAction("wink")
corp;

define tp_chat proc v_yawn()bool:
    makeAction("yawn")
corp;

VerbTail(G, "blink", v_blink).
VerbTail(G, "blush", v_blush).
VerbTail(G, "bow", v_bow).
VerbTail(G, "cower", v_cower).
VerbTail(G, "cringe", v_cringe).
VerbTail(G, "curtsey", v_curtsey).
VerbTail(G, "dance", v_dance).
VerbTail(G, "drool", v_drool).
VerbTail(G, "gesticulate", v_gesticulate).
Synonym(G, "gesticulate", "gest").
VerbTail(G, "glare", v_glare).
VerbTail(G, "grovel", v_grovel).
VerbTail(G, "grimace", v_grimace).
VerbTail(G, "grin", v_grin).
VerbTail(G, "frown", v_frown).
VerbTail(G, "hop", v_hop).
VerbTail(G, "nod", v_nod).
VerbTail(G, "pout", v_pout).
VerbTail(G, "shudder", v_shudder).
VerbTail(G, "shiver", v_shiver).
VerbTail(G, "shrug", v_shrug).
VerbTail(G, "smile", v_smile).
VerbTail(G, "smirk", v_smirk).
VerbTail(G, "sneer", v_sneer).
VerbTail(G, "spit", v_spit).
VerbTail(G, "tremble", v_tremble).
VerbTail(G, "twitch", v_twitch).
VerbTail(G, "wave", v_wave).
VerbTail(G, "wince", v_wince).
VerbTail(G, "wink", v_wink).
VerbTail(G, "yawn", v_yawn).

define tp_chat proc noiseAdverb(string s)void:
    ChatThing@NoiseAdverbs := ChatThing@NoiseAdverbs + s;
corp;

noiseAdverb("deeply,deep,dee,d.").
noiseAdverb("embarrassedly,embarrassed,embar,emb.").
noiseAdverb("excitedly,excited,exc,x.").
noiseAdverb("evilly,evil,evi,e.").
noiseAdverb("fitfully,fitfull,fit.").
noiseAdverb("gayly,gay.").
noiseAdverb("happily,happy,hap,h.").
noiseAdverb("hesitantly,hesitant,hes.").
noiseAdverb("hollowly,hollow,hol.").
noiseAdverb("loudly,loud,lou,l.").
noiseAdverb("merrily,merry,mer,m.").
noiseAdverb("nastily,nasty,nas.").
noiseAdverb("nervously,nervous,ner.").
noiseAdverb("politely,polite,pol.").
noiseAdverb("quietly,quiet,qui,q.").
noiseAdverb("sadly,sad,s.").
noiseAdverb("sharply,sharp,sha.").
noiseAdverb("sickly,sick,sic.").
noiseAdverb("suddenly,sudden,sud.").
noiseAdverb("tiredly,tired,tir.").
noiseAdverb("vigorously,vigorous,vig.").

define tp_chat proc makeNoise(string noise)bool:
    string adverb;
    int which;

    adverb := GetWord();
    if adverb ~= "" then
	which := MatchName(ChatThing@NoiseAdverbs, adverb);
	if which ~= -1 then
	    adverb := SelectName(ChatThing@NoiseAdverbs, which);
	    if Me()@p_pHidden or not CanSee(Here(), Me()) then
		OPrint("You hear a " + SelectWord(adverb, 1) +
		    " " + noise + ".\n");
	    else
		Pose("", Pluralize(noise) + " " + SelectWord(adverb, 0) + ".");
	    fi;
	    if Me()@p_pEchoPose then
		Print("You " + noise + " " + SelectWord(adverb, 0) + ".\n");
	    fi;
	    true
	else
	    Print("Unknown noise adverb '" + adverb + "'. Known ones:\n");
	    which := 0;
	    while
		adverb := SelectName(ChatThing@NoiseAdverbs, which);
		adverb ~= ""
	    do
		Print("  " + adverb + "\n");
		which := which + 1;
	    od;
	    false
	fi
    else
	if Me()@p_pHidden or not CanSee(Here(), Me()) then
	    OPrint("You hear a " + noise + ".\n");
	else
	    Pose("", Pluralize(noise) + ".");
	fi;
	if Me()@p_pEchoPose then
	    Print("You " + noise + ".\n");
	fi;
	true
    fi
corp;

define tp_chat proc v_applaud()bool:
    makeNoise("applaud")
corp;

define tp_chat proc v_burp()bool:
    makeNoise("burp")
corp;

define tp_chat proc v_cackle()bool:
    makeNoise("cackle")
corp;

define tp_chat proc v_cheer()bool:
    makeNoise("cheer")
corp;

define tp_chat proc v_chuckle()bool:
    makeNoise("chuckle")
corp;

define tp_chat proc v_clap()bool:
    makeNoise("clap")
corp;

define tp_chat proc v_cough()bool:
    makeNoise("cough")
corp;

define tp_chat proc v_croak()bool:
    makeNoise("croak")
corp;

define tp_chat proc v_cry()bool:
    makeNoise("cry")
corp;

define tp_chat proc v_fart()bool:
    makeNoise("fart")
corp;

define tp_chat proc v_gasp()bool:
    makeNoise("gasp")
corp;

define tp_chat proc v_giggle()bool:
    makeNoise("giggle")
corp;

define tp_chat proc v_groan()bool:
    makeNoise("groan")
corp;

define tp_chat proc v_growl()bool:
    makeNoise("growl")
corp;

define tp_chat proc v_grumble()bool:
    makeNoise("grumble")
corp;

define tp_chat proc v_grunt()bool:
    makeNoise("grunt")
corp;

define tp_chat proc v_hiccup()bool:
    makeNoise("hiccup")
corp;

define tp_chat proc v_hiccough()bool:
    makeNoise("hiccough")
corp;

define tp_chat proc v_hum()bool:
    makeNoise("hum")
corp;

define tp_chat proc v_laugh()bool:
    makeNoise("laugh")
corp;

define tp_chat proc v_moan()bool:
    makeNoise("moan")
corp;

define tp_chat proc v_mutter()bool:
    makeNoise("mutter")
corp;

define tp_chat proc v_purr()bool:
    makeNoise("purr")
corp;

define tp_chat proc v_scream()bool:
    makeNoise("scream")
corp;

define tp_chat proc v_sigh()bool:
    makeNoise("sigh")
corp;

define tp_chat proc v_snarl()bool:
    makeNoise("snarl")
corp;

define tp_chat proc v_sneeze()bool:
    makeNoise("sneeze")
corp;

define tp_chat proc v_snicker()bool:
    makeNoise("snicker")
corp;

define tp_chat proc v_snore()bool:
    makeNoise("snore")
corp;

define tp_chat proc v_sob()bool:
    makeNoise("sob")
corp;

define tp_chat proc v_whine()bool:
    makeNoise("whine")
corp;

define tp_chat proc v_whistle()bool:
    makeNoise("whistle")
corp;

VerbTail(G, "applaud", v_applaud).
VerbTail(G, "burp", v_burp).
VerbTail(G, "cackle", v_cackle).
VerbTail(G, "cheer", v_cheer).
VerbTail(G, "chuckle", v_chuckle).
VerbTail(G, "clap", v_clap).
VerbTail(G, "cough", v_cough).
VerbTail(G, "croak", v_croak).
VerbTail(G, "cry", v_cry).
VerbTail(G, "fart", v_fart).
VerbTail(G, "gasp", v_gasp).
VerbTail(G, "giggle", v_giggle).
VerbTail(G, "groan", v_groan).
VerbTail(G, "growl", v_growl).
VerbTail(G, "grumble", v_grumble).
VerbTail(G, "grunt", v_grunt).
VerbTail(G, "hiccup", v_hiccup).
VerbTail(G, "hiccough", v_hiccough).
VerbTail(G, "hum", v_hum).
VerbTail(G, "laugh", v_laugh).
VerbTail(G, "moan", v_moan).
VerbTail(G, "mutter", v_mutter).
VerbTail(G, "purr", v_purr).
VerbTail(G, "scream", v_scream).
VerbTail(G, "sigh", v_sigh).
VerbTail(G, "snarl", v_snarl).
VerbTail(G, "sneeze", v_sneeze).
VerbTail(G, "snicker", v_snicker).
VerbTail(G, "snore", v_snore).
VerbTail(G, "sob", v_sob).
VerbTail(G, "whine", v_whine).
VerbTail(G, "whistle", v_whistle).

unuse tp_chat
