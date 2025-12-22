#/Include/Empire.g
#/Include/Request.g
#EmpPrivate.g
#drinc:util.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

[range(NewsType_t)] ushort NEWS_PAGE = (
    3,1,1,2,2,3,3,3,3,2,1,1,2,1,1,2,1,1,1,1,1,
    3,2,1,1,1,1,1,1,1,1,2,2,1,1,2,1,1,1,1
);
[range(NewsType_t)] short NEWS_GOOD_WILL = (
    0, -3, -3, -1, 1, 3, 2, 1, 0, 2, -2, -2, 0, 0, 0, 0, -2, -2, -2,
    -3, -1, -2, -1, -4, 0, 0, 5, 0, -5, -5, 5, 0, 0, 0, 0, 0, -2, -3, 0, 0
);

uint MAX_LEN = TELEGRAM_MAX - 1;

/***************************************************************\
*								*
* Throughout these mini-editor routines:			*
*								*
* ES*.es_uint1 is the total length in bytes of the message	*
*	This does NOT include the trailing '\e' 		*
* ES*.es_uint2 is the count of lines in the message		*
* ES*.es_uint3 is the length in bytes of the non-editable header*
*								*
\***************************************************************/

/*
 * textAppend - append lines of text to the end of the buffer.
 */

proc textAppend()void:
    register *char pos, inputPos;

    pos := &ES*.es_request.rq_u.ru_telegram.te_data[ES*.es_uint1];
    while
	if ES*.es_uint1 = MAX_LEN then
	    false
	else
	    userN(ES*.es_uint2 + 1);
	    uPrompt(": ");
	    ES*.es_readUser() and
		(ES*.es_textInPos* ~= '.' or
		    (ES*.es_textInPos + sizeof(char))* ~= '\e')
	fi
    do
	inputPos := ES*.es_textInPos;
	while inputPos* ~= '\e' and ES*.es_uint1 ~= MAX_LEN do
	    pos* := inputPos*;
	    pos := pos + sizeof(char);
	    inputPos := inputPos + sizeof(char);
	    ES*.es_uint1 := ES*.es_uint1 + 1;
	od;
	if ES*.es_uint1 = MAX_LEN then
	    (pos - sizeof(char))* := '\n';
	else
	    pos* := '\n';
	    pos := pos + sizeof(char);
	    ES*.es_uint1 := ES*.es_uint1 + 1;
	fi;
	ES*.es_uint2 := ES*.es_uint2 + 1;
    od;
    pos* := '\e';
corp;

/*
 * textList - list the contents of the text buffer.
 */

proc textList()void:
    register *char pos;
    register uint line;
    bool newLine;

    pos := &ES*.es_request.rq_u.ru_telegram.te_data[ES*.es_uint3];
    line := 1;
    newLine := true;
    while pos* ~= '\e' do
	if newLine then
	    newLine := false;
	    userN(line);
	    user(": ");
	fi;
	userC(pos*);
	if pos* = '\n' then
	    newLine := true;
	    line := line + 1;
	fi;
	pos := pos + sizeof(char);
    od;
corp;

/*
 * textFindLine - return the position of the beginning of the selected line.
 */

proc textFindLine(*char errorMessage; bool allowZero)*char:
    register *char pos;
    register uint n, line;

    pos := ES*.es_textInPos + sizeof(char);
    while pos* ~= '\e' and not (pos* >= '0' and pos* <= '9') do
	pos := pos + sizeof(char);
    od;
    if pos* = '\e' then
	user(errorMessage);
	nil
    else
	n := 0;
	while pos* >= '0' and pos* <= '9' do
	    n := n * 10 + (pos* - '0');
	    pos := pos + sizeof(char);
	od;
	if n = 0 and not allowZero or n > ES*.es_uint2 then
	    err("invalid line number");
	    nil
	else
	    while pos* = ' ' do
		pos := pos + sizeof(char);
	    od;
	    ES*.es_textInPos := pos;
	    line := 1;
	    pos := &ES*.es_request.rq_u.ru_telegram.te_data[ES*.es_uint3];
	    while line < n do
		if pos* = '\n' then
		    line := line + 1;
		fi;
		pos := pos + sizeof(char);
	    od;
	    pos
	fi
    fi
corp;

/*
 * findString - part of 'textReplace' - given an input pointer and a string
 *	pointer, return the pointer to the string in the input, else nil.
 */

proc findString(*char pos, sub)*char:
    register *char p, q;

    while
	if pos* = '\n' then
	    pos := nil;
	    false
	else
	    p := pos;
	    q := sub;
	    while p* = q* and q* ~= '\e' do
		p := p + sizeof(char);
		q := q + sizeof(char);
	    od;
	    if q* = '\e' then
		/* found it */
		false
	    else
		true
	    fi
	fi
    do
	pos := pos + sizeof(char);
    od;
    pos
corp;

/*
 * textReplace - do a string replace in the text buffer.
 */

proc textReplace()void:
    *char BAD_REP = "Use is: replace line-\# /oldtext/newtext/\n";
    register *char inputPos, pos;
    *char fromString, toString, buf;
    register uint fromLen, toLen;
    uint bytes, end;
    char delim;

    pos := textFindLine(BAD_REP, false);
    if pos ~= nil then
	inputPos := ES*.es_textInPos;
	if inputPos* = '\e' then
	    user(BAD_REP);
	else
	    delim := inputPos*;
	    inputPos := inputPos + sizeof(char);
	    fromString := inputPos;
	    fromLen := 0;
	    while inputPos* ~= delim and inputPos* ~= '\e' do
		inputPos := inputPos + sizeof(char);
		fromLen := fromLen + 1;
	    od;
	    if inputPos* = delim then
		inputPos* := '\e';
		inputPos := inputPos + sizeof(char);
		toString := inputPos;
		toLen := 0;
		while inputPos* ~= delim and inputPos* ~= '\e' do
		    inputPos := inputPos + sizeof(char);
		    toLen := toLen + 1;
		od;
		if inputPos* = delim then
		    inputPos* := '\e';
		    pos := findString(pos, fromString);
		    if pos = nil then
			user3("** '", fromString, "' not found\n");
		    elif ES*.es_uint1 - fromLen + toLen > MAX_LEN then
			err("not replaced - text too big");
		    else
			/* buf is address of beginning of buffer */
			buf := &ES*.es_request.rq_u.ru_telegram.te_data[0];
			/* bytes is length of stuff after fromString */
			bytes := (ES*.es_uint1 - fromLen + 1) * sizeof(char) -
				    (pos - buf);
			if fromLen > toLen then
			    /* shrinking in place - shuffle tail up */
			    BlockCopy(pos + toLen * sizeof(char),
				      pos + fromLen * sizeof(char), bytes);
			else
			    /* growing - shuffle tail down */
			    end := ES*.es_uint1 + toLen - fromLen;
			    BlockCopyB(buf + end * sizeof(char),
				       buf + ES*.es_uint1 * sizeof(char),
				       bytes);
			fi;
			/* insert toString into buffer */
			BlockCopy(pos, toString, toLen);
			ES*.es_uint1 := ES*.es_uint1 - fromLen + toLen;
		    fi;
		else
		    user(BAD_REP);
		fi;
	    else
		user(BAD_REP);
	    fi;
	fi;
    fi;
corp;

/*
 * textDelete - delete a line from the text buffer.
 */

proc textDelete()void:
    register *char pos, delPos;
    register uint delLen;

    pos := textFindLine("Use is: delete line-\#\n", false);
    if pos ~= nil then
	delPos := pos;
	delLen := 0;
	while delPos* ~= '\n' do
	    delPos := delPos + sizeof(char);
	    delLen := delLen + 1;
	od;
	delPos := delPos + sizeof(char);
	delLen := delLen + 1;
	BlockCopy(pos, delPos,
		  (ES*.es_uint1 + 1) * sizeof(char) -
		  (delPos - &ES*.es_request.rq_u.ru_telegram.te_data[0]));
	ES*.es_uint2 := ES*.es_uint2 - 1;
	ES*.es_uint1 := ES*.es_uint1 - delLen;
    fi;
corp;

/*
 * textInsert - insert a line into the text buffer.
 */

proc textInsert()void:
    register *char pos, inputPos;
    *char toString, buf;
    register uint toLen;

    pos := textFindLine("Use is: insert line-\# <text>\n", true);
    if pos ~= nil then
	inputPos := ES*.es_textInPos;
	toString := inputPos;
	toLen := 0;
	while inputPos* ~= '\e' do
	    inputPos := inputPos + sizeof(char);
	    toLen := toLen + 1;
	od;
	inputPos* := '\n';
	toLen := toLen + 1;
	if ES*.es_uint1 + toLen > MAX_LEN then
	    err("not inserted - text too big");
	else
	    buf := &ES*.es_request.rq_u.ru_telegram.te_data[0];
	    BlockCopyB(buf + (ES*.es_uint1 + toLen) * sizeof(char),
		       buf + ES*.es_uint1 * sizeof(char),
		       (ES*.es_uint1 + 1) * sizeof(char) - (pos - buf));
	    BlockCopy(pos, toString, toLen);
	    ES*.es_uint1 := ES*.es_uint1 + toLen;
	    ES*.es_uint2 := ES*.es_uint2 + 1;
	fi;
    fi;
corp;

/*
 * getText - get a text into the request structure. Return 'false' if abort.
 *	NOTE: fileName MUST be nil for tt_message!
 */

proc getText(TextType_t tt; *char fileName; uint whichFile)bool:
    *char what;
    register *char pos, inputPos;
    bool cancel, abort;

    cancel := false;
    abort := false;
    what :=
	  case tt
	  incase tt_telegram:
	      "telegram"
	  incase tt_message:
	      "message"
	  incase tt_propaganda:
	      "propaganda"
	  incase tt_edit:
	      "edit"
	  default:
	      "????"
	  esac;
    if fileName ~= nil then
	if tt = tt_edit then
	    server(rt_edit, whichFile);
	    if ES*.es_request.rq_whichUnit = TELEGRAM_MAX then
		err("failed to edit file");
		cancel := true;
		abort := true;
	    fi;
	else
	    CharsCopy(&ES*.es_request.rq_u.ru_text[0], fileName);
	    server(rt_readLocal, 0);
	    if ES*.es_request.rq_whichUnit = 0 then
		user3("** can't read file '", fileName, "'\n");
		cancel := true;
	    fi;
	fi;
	ES*.es_uint3 := 0;
	if not cancel then
	    ES*.es_uint1 := ES*.es_request.rq_whichUnit;
	    ES*.es_uint2 := 0;
	    pos := &ES*.es_request.rq_u.ru_telegram.te_data[0];
	    (pos + ES*.es_uint1)* := '\e';
	    while pos* ~= '\e' do
		if pos* = '\n' then
		    ES*.es_uint2 := ES*.es_uint2 + 1;
		fi;
		pos := pos + sizeof(char);
	    od;
	    if ES*.es_uint1 = 0 and tt = tt_edit then
		textAppend();
	    fi;
	fi;
    else
	ES*.es_uint1 := 0;
	pos := &ES*.es_request.rq_u.ru_telegram.te_data[0];
	if tt = tt_message then
	    ES*.es_uint1 := CharsLen(&ES*.es_country.c_name[0]);
	    BlockCopy(pos, &ES*.es_country.c_name[0], ES*.es_uint1);
	    pos := pos + ES*.es_uint1 * sizeof(char);
	    pos* := ':';
	    pos := pos + sizeof(char);
	    pos* := '\n';
	    pos := pos + sizeof(char);
	    ES*.es_uint1 := ES*.es_uint1 + 2;
	fi;
	ES*.es_uint2 := 0;
	ES*.es_uint3 := ES*.es_uint1;
	user3("Enter text of ", what, " (max ");
	userN(MAX_LEN - ES*.es_uint1);
	user(" chars). End with . :\n");
	textAppend();
    fi;
    while
	if cancel then
	    false
	elif ES*.es_uint1 = 0 and tt ~= tt_edit then
	    user3("** empty ", what, " - cancelled\n");
	    cancel := true;
	    false
	else
	    uPrompt("Send, List, Replace, Delete, Insert, Append, Cancel? ");
	    if ES*.es_readUser() and ES*.es_textInPos* ~= '\e' then
		inputPos := skipBlanks();
		if inputPos* = 'c' or inputPos* = 'C' then
		    user3("** ", what, " cancelled\n");
		    cancel := true;
		    false
		elif inputPos* = 's' or inputPos* = 'S' then
		    false
		else
		    true
		fi
	    else
		false
	    fi
	fi
    do
	case inputPos*
	incase 'l':
	incase 'L':
	    textList();
	incase 'r':
	incase 'R':
	    textReplace();
	incase 'd':
	incase 'D':
	    textDelete();
	incase 'i':
	incase 'I':
	    textInsert();
	incase 'a':
	incase 'A':
	    textAppend();
	esac;
    od;
    if tt = tt_edit then
	if not abort then
	    if cancel then
		ES*.es_request.rq_u.ru_telegram.te_length := TELEGRAM_MAX;
	    else
		ES*.es_request.rq_u.ru_telegram.te_length := ES*.es_uint1;
	    fi;
	    server(rt_edit, whichFile);
	fi;
    else
	ES*.es_request.rq_u.ru_telegram.te_data[ES*.es_uint1] := '\e';
	ES*.es_uint1 := ES*.es_uint1 + 1;
	ES*.es_request.rq_u.ru_telegram.te_length := ES*.es_uint1;
    fi;
    not cancel
corp;

proc cmd_telegram()void:
    uint LIST_SIZE = 100;
    [LIST_SIZE] uint targets;
    Telegram_t saveTelegram;
    register uint targetCount, i;
    uint country;
    *char fileName, fileEnd;
    bool cancel, broadCast;

    cancel := false;
    broadCast := false;
    fileName := nil;
    if ES*.es_textInPos* = '*' and ES*.es_country.c_status = cs_deity then
	ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	if skipBlanks()* = '<' then
	    ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	    fileName := skipBlanks();
	    skipWord()* := '\e';
	fi;
	broadCast := true;
    elif not reqCountry(&country, "Country to send telegram to: ", false) then
	cancel := true;
    fi;
    if not cancel then
	if not broadCast then
	    targets[0] := country;
	    targetCount := 1;
	    while skipBlanks()* ~= '\e' and targetCount ~= LIST_SIZE do
		if ES*.es_textInPos* = '<' then
		    ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
		    fileName := skipBlanks();
		    fileEnd := skipWord();
		    ignore skipBlanks();
		    fileEnd* := '\e';
		else
		    if getCountry(&targets[targetCount], false, false) then
			targetCount := targetCount + 1;
		    else
			cancel := true;
		    fi;
		fi;
	    od;
	fi;
	if fileName ~= nil and fileName* = '\e' then
	    fileName := nil;
	fi;
	if not cancel and getText(tt_telegram, fileName, 0) then
	    server(rt_nop, 0);
	    ES*.es_request.rq_u.ru_telegram.te_time := ES*.es_request.rq_time;
	    ES*.es_request.rq_u.ru_telegram.te_from := ES*.es_countryNumber;
	    if broadCast then
		saveTelegram := ES*.es_request.rq_u.ru_telegram;
		for country from 0 upto ES*.es_world.w_currCountries - 1 do
		    server(rt_readCountry, country);
		    if ES*.es_request.rq_u.ru_country.c_status = cs_active or
			ES*.es_request.rq_u.ru_country.c_status = cs_deity
		    then
			ES*.es_request.rq_u.ru_telegram := saveTelegram;
			ES*.es_request.rq_u.ru_telegram.te_to := country;
			server(rt_sendTelegram, country);
		    fi;
		od;
	    else
		for i from 0 upto targetCount - 1 do
		    country := targets[i];
		    ES*.es_request.rq_u.ru_telegram.te_to := country;
		    server(rt_sendTelegram, country);
		od;
		/* have to split up, since both use the message structure */
		for i from 0 upto targetCount - 1 do
		    if ES*.es_country.c_status ~= cs_deity then
			server(rt_readCountry, targets[i]);
			if ES*.es_request.rq_u.ru_country.c_status ~= cs_deity
			then
			    news(n_sent_telegram, ES*.es_countryNumber,
				 targets[i]);
			fi;
		    fi;
		od;
	    fi;
	fi;
    fi;
corp;

/*
 * telegramCheck - called to check for new telegrams at login.
 */

proc telegramCheck()void:

    server(rt_checkMessages, ES*.es_countryNumber);
    if ES*.es_request.rq_u.ru_messageCheck.mc_hasOldTelegrams then
	user("You have old telegrams.\n");
    fi;
    if ES*.es_request.rq_u.ru_messageCheck.mc_hasNewTelegrams then
	user("You have new telegrams.\n");
    fi;
corp;

/*
 * messageCheck - called to check for and print messages after each command.
 */

proc messageCheck()void:
    bool newCountry, messages, telegrams;

    server(rt_checkMessages, ES*.es_countryNumber);
    newCountry := ES*.es_request.rq_u.ru_messageCheck.mc_newCountry;
    messages := ES*.es_request.rq_u.ru_messageCheck.mc_hasMessages;
    telegrams := ES*.es_request.rq_u.ru_messageCheck.mc_hasNewTelegrams;
    if ES*.es_request.rq_u.ru_messageCheck.mc_newWorld then
	server(rt_readWorld, 0);
	ES*.es_world := ES*.es_request.rq_u.ru_world;
    fi;
    if newCountry then
	server(rt_readCountry, ES*.es_countryNumber);
	ES*.es_country := ES*.es_request.rq_u.ru_country;
    fi;
    if messages then
	while
	    server(rt_getMessage, 0);
	    ES*.es_request.rq_u.ru_telegram.te_length ~= 0
	do
	    user(&ES*.es_request.rq_u.ru_telegram.te_data[0]);
	od;
    fi;
    if telegrams then
	user("You have new telegrams.\n");
    fi;
corp;

proc cmd_read()void:
    [TELEGRAM_MAX + 1] char buff;	/* sigh! */
    register uint i, sender;
    bool hadOne, wasDeity;

    hadOne := false;
    while
	server(rt_readTelegram, ES*.es_countryNumber);
	i := ES*.es_request.rq_u.ru_telegram.te_length;
	i ~= 0
    do
	BlockCopy(&buff[0], &ES*.es_request.rq_u.ru_telegram.te_data[0], i);
	uTime(ES*.es_request.rq_u.ru_telegram.te_time);
	if ES*.es_request.rq_u.ru_telegram.te_from = NOBODY then
	    user(": anonymous telegram:\n\n");
	    user(&buff[0]);
	    userNL();
	else
	    sender := ES*.es_request.rq_u.ru_telegram.te_from;
	    server(rt_readCountry, sender);
	    user(": telegram from ");
	    user(&ES*.es_request.rq_u.ru_country.c_name[0]);
	    user(":\n\n");
	    user(&buff[0]);
	    userNL();
	    wasDeity := ES*.es_request.rq_u.ru_country.c_status = cs_deity;
	    if ask("Reply to this telegram? ") and
		getText(tt_telegram, nil, 0)
	    then
		ES*.es_request.rq_u.ru_telegram.te_time :=
		    ES*.es_request.rq_time;
		ES*.es_request.rq_u.ru_telegram.te_from :=
		    ES*.es_countryNumber;
		ES*.es_request.rq_u.ru_telegram.te_to := sender;
		server(rt_sendTelegram, sender);
		if ES*.es_country.c_status ~= cs_deity and not wasDeity then
		    news(n_sent_telegram, ES*.es_countryNumber, sender);
		fi;
	    fi;
	fi;
	hadOne := true;
    od;
    if hadOne then
	if ask("Delete these telegrams? ") then
	    server(rt_readTelegram, TELE_DELETE);
	else
	    server(rt_readTelegram, TELE_KEEP);
	fi;
    else
	user("No telegrams\n");
    fi;
corp;

/*
 * sayHeadLine - report on a headline item.
 */

proc sayHeadLine(register int recent, past; *char actor, victim)void:
    register *char message;

    message :=
	case
	    if | past > | recent then 1 else 0 fi +
	    if past >= 0 then 2 else 0 fi +
	    if recent >= 0 then 4 else 0 fi
	incase 0:
	    "Carnage being wreaked by $ on $ continues unabated!"
	incase 1:
	    if recent < -10 then
		"Further $ agression against $"
	    else
		"Peace talks may succeed between $ & $"
	    fi
	incase 2:
	    if recent < -12 then
		if past > 8 then
		    "! WAR !  A complete reversal of prior $ -- $ relations"
		else
		    if recent < -20 then
			"$ wreaks havoc on $!"
		    else
			"VIOLENCE ERUPTS! -- $ wages war on $"
		    fi
		fi
	    else
		"Breakdown in communication between $ & $"
	    fi
	incase 3:
	    if past > 10 then
		"FLASH!   $ turns on former ally, $"
	    else
		"$ aggravates rift with $"
	    fi
	incase 4:
	    if recent > 10 then
		"$ enters new era of cooperation with $"
	    else
		"$ \"makes friends\" with $"
	    fi
	incase 5:
	    if recent > 5 then
		"$ willing to bury the hatchet with $"
	    else
		if past < -16 then
		    "Tensions ease as $ attacks on $ seem at an end"
		else
		    "$ seems to have forgotten earlier disagreement with $"
		fi
	    fi
	incase 6:
	    "$ good deeds further growing alliance with $"
	incase 7:
	    if recent - past < -20 then
		"Honeymoon appears to be over between $ & $"
	    else
		"Friendly relations between $ & $ have cooled somewhat"
	    fi
	default:
	    "***unknown headline***"
	esac;
    while message* ~= '\e' do
	if message* = '$' then
	    user(actor);
	    actor := victim;
	else
	    userC(message*);
	fi;
	message := message + sizeof(char);
    od;
    userNL();
corp;

/*
 * doHeadLines - generate headlines for the given number of "days" of news.
 */

proc doHeadLines(ulong days)void:
    type
	history_t = struct {
	    int h_past, h_recent;
	};
    ulong now, time, day;
    [COUNTRY_MAX, COUNTRY_MAX] history_t hist;
    [NAME_LEN] char name1, name2;
    register *News_t n;
    register *history_t h;
    register int goodWill, scoop;
    register uint i, j;
    uint scoopI, scoopJ;
    bool hadOne;

    server(rt_nop, 0);
    now := ES*.es_request.rq_time;
    user(
	"\n"
	"              -=[  EMPIRE NEWS  ]=-\n"
	"::::::::::::::::::::::::::::::::::::::::::::::::::\n"
	"!       \"All the news that fits, we print.\"      !\n"
	"::::::::::::::::::::::::::::::::::::::::::::::::::\n"
	"             ");
    uTime(now);
    userNL();
    ignore printFile(BULLETIN_FILE, ft_normal);
    for i from 0 upto COUNTRY_MAX - 1 do
	for j from 0 upto COUNTRY_MAX - 1 do
	    hist[i, j].h_past := 0;
	    hist[i, j].h_recent := 0;
	od;
    od;
    n := &ES*.es_request.rq_u.ru_news;
    time :=
	now - make(days - 1, ulong) * ES*.es_world.w_secondsPerETU * (2 * 24);
    day := 0;
    ES*.es_request.rq_whichUnit := 0;
    hadOne := true;
    while hadOne or day ~= days do
	ES*.es_request.rq_u.ru_news.n_time := time;
	server(rt_readNews, ES*.es_request.rq_whichUnit);
	hadOne := ES*.es_request.rq_whichUnit ~= 0;
	if hadOne then
	    if n*.n_actor ~= n*.n_victim then
		goodWill := NEWS_GOOD_WILL[n*.n_verb];
		if goodWill ~= 0 then
		    h := &hist[n*.n_actor, n*.n_victim];
		    if now - n*.n_time >
			    days * ES*.es_world.w_secondsPerETU * 24
		    then
			h*.h_past := h*.h_past + goodWill;
		    else
			h*.h_recent := h*.h_recent + goodWill;
		    fi;
		fi;
	    fi;
	else
	    day := day + 1;
	    time := time + ES*.es_world.w_secondsPerETU * (2 * 24);
	fi;
    od;
    hadOne := false;
    while
	scoop := 9;
	for i from 0 upto COUNTRY_MAX - 1 do
	    for j from 0 upto COUNTRY_MAX - 1 do
		h := &hist[i, j];
		goodWill := | h*.h_recent / 2;
		if goodWill > scoop then
		    scoop := goodWill;
		    scoopI := i;
		    scoopJ := j;
		fi;
		goodWill := | (h*.h_recent - h*.h_past);
		if goodWill > scoop then
		    scoop := goodWill;
		    scoopI := i;
		    scoopJ := j;
		fi;
	    od;
	od;
	userNL();
	scoop > 9
    do
	hadOne := true;
	h := &hist[scoopI, scoopJ];
	server(rt_readCountry, scoopI);
	name1 := ES*.es_request.rq_u.ru_country.c_name;
	server(rt_readCountry, scoopJ);
	name2 := ES*.es_request.rq_u.ru_country.c_name;
	sayHeadLine(h*.h_recent, h*.h_past, &name1[0], &name2[0]);
	scoop := h*.h_recent;
	h*.h_recent := 0;
	h*.h_past := 0;
	h := &hist[scoopJ, scoopI];
	goodWill := h*.h_recent;
	if scoop < 0 and goodWill >= -scoop / 2 or
	    scoop > 0 and goodWill <= -scoop / 2
	then
	    user(
		    case | goodWill % 4
		    incase 0:
			"        Meanwhile\n"
		    incase 1:
			"        On the other hand\n"
		    incase 2:
			"        At the same time\n"
		    incase 3:
			"        Although\n"
		    esac);
	    sayHeadLine(h*.h_recent, h*.h_past, &name2[0], &name1[0]);
	fi;
	h*.h_recent := 0;
	h*.h_past := 0;
    od;
    if not hadOne then
	user("Relative calm prevails.\n");
    fi;
corp;

proc cmd_headlines()void:
    int i;

    if ES*.es_textInPos* = '\e' then
	doHeadLines(1);
    elif getNumber(&i) and i > 0 then
	doHeadLines(i);
    else
	err("invalid day count");
    fi;
corp;

/*
 * sayNews - report an item of news, and how many times it happened.
 */

proc sayNews(NewsType_t verb; ushort actor, victim;
	     ulong time; uint count)void:
    register *char v;

    server(rt_readCountry, actor);
    uTime(time);
    user3(": ", &ES*.es_request.rq_u.ru_country.c_name[0], " ");
    server(rt_readCountry, victim);
    v := &ES*.es_request.rq_u.ru_country.c_name[0];
    case verb
    incase n_nothing:
	user2("did nothing in particular to ", v);
    incase n_won_sector:
	user2("won a sector from ", v);
    incase n_lost_sector:
	user2("was repulsed by ", v);
    incase n_spy_shot:
	user2("had a spy shot by ", v);
    incase n_sent_telegram:
	user2("sent a telegram to ", v);
    incase n_sign_treaty:
	user2("signed a treaty with ", v);
    incase n_make_loan:
	user2("made a loan to ", v);
    incase n_repay_loan:
	user2("repaid a loan from ", v);
    incase n_make_sale:
	user2("made a sale to ", v);
    incase n_grant_sector:
	user2("granted land to ", v);
    incase n_shell_sector:
	user2("shelled land owned by ", v);
    incase n_shell_ship:
	user2("shelled a ship owned by ", v);
    incase n_took_unoccupied:
	user("took over unoccupied land");
    incase n_torp_ship:
	user("had a ship torpedoed");
    incase n_fire_back:
	user3("fired on ", v, " in self defense");
    incase n_broke_sanctuary:
	user("broke sanctuary");
    incase n_bomb_sector:
	user3("bombed one of ", v, "'s sectors");
    incase n_bomb_ship:
	user2("bombed a ship flying the flag of ", v);
    incase n_board_ship:
	user3("boarded a(n) ", v, " ship");
    incase n_failed_board:
	user3("was repelled by ", v, " while attempting to board a ship");
    incase n_flak:
	user3("fired on ", v, " aircraft");
    incase n_sieze_sector:
	user3("siezed a sector from ", v, " in collecting on a loan");
    incase n_honor_treaty:
	user2("considered an action which would have violated a treaty with",
	      v);
    incase n_violate_treaty:
	user2("violated a treaty with ", v);
    incase n_dissolve:
	user("committed national suicide");
    incase n_hit_mine:
	user("ship hit a mine");
    incase n_decl_ally:
	user2("announced an alliance with ", v);
    incase n_decl_neut:
	user2("declared their neutrality toward ", v);
    incase n_decl_war:
	user2("declared WAR on ", v);
    incase n_disavow_ally:
	user2("disavowed former alliance with ", v);
    incase n_disavow_war:
	user2("disavowed former war with ", v);
    incase n_storm_sector:
	user("sector damaged by hurricane");
    incase n_storm_ship:
	user("navy sufferred hurricane damages");
    incase n_plague_outbreak:
	user("reports outbreak of PLAGUE");
    incase n_plague_die:
	user("citizens killed by PLAGUE");
    incase n_name_change:
	user("went through a name change");
    incase n_drop_sub:
	user3("depth charged a(n) ", v, " submarine");
    incase n_destroyed:
	if actor = victim then
	    user("DESTROYED itself!!!");
	elif actor = 0 then
	    user("has been DESTROYED!!!");
	else
	    user3("DESTROYED ", v, "!!!");
	fi;
    incase n_plague_dest:
	user("wiped out by killer plague!!!");
    incase n_hurricane_dest:
	user("wiped out by killer hurricane!!!");
    default:
	user("***unknown news type***");
    esac;
    if count ~= 1 then
	userN3(" ", count, " times");
    fi;
    userNL();
corp;

proc cmd_newspaper()void:
    [TELEGRAM_MAX + 1] char buff;	/* sigh! */
    register *News_t n;
    News_t saveItem;
    ulong now, timeStep, start, time, prevTime;
    int i;
    register uint day, count;
    uint days, page, item;
    NewsType_t prevVerb;
    ushort prevActor, prevVictim;
    bool quit, hadOne, hadItem;

    quit := false;
    if ES*.es_textInPos* = '\e' then
	days := 1;
    elif getNumber(&i) and i > 0 then
	days := i;
    else
	err("invalid day count");
	quit := true;
    fi;
    n := &ES*.es_request.rq_u.ru_news;
    if not quit then
	doHeadLines(days);
	server(rt_nop, 0);
	timeStep := ES*.es_world.w_secondsPerETU * (2 * 24);
	now := ES*.es_request.rq_time / timeStep * timeStep;
	start := now - make(days - 1, ulong) * timeStep;
	userNL();
	user("The details of Empire news since ");
	uTime(start);
	user("\n\n");
	page := 1;
	while page ~= 5 and not quit do
	    userN3("        === page ", page, " ===\n\n");
	    hadItem := false;
	    prevVerb := n_nothing;
	    prevActor := 0;
	    prevVictim := 0;
	    count := 0;
	    time := start;
	    day := 0;
	    hadOne := false;
	    item := 0;
	    while (hadOne or day ~= days) and not quit do
		if page ~= 4 then
		    ES*.es_request.rq_u.ru_news.n_time := time;
		    server(rt_readNews, item);
		    hadOne := ES*.es_request.rq_whichUnit ~= 0;
		    if hadOne then
			item := item + 1;
			if NEWS_PAGE[n*.n_verb] = page then
			    if n*.n_verb ~= prevVerb or
				n*.n_actor ~= prevActor or
				n*.n_victim ~= prevVictim
			    then
				if count ~= 0 then
				    saveItem := n*;
				    sayNews(prevVerb, prevActor,
					    prevVictim, prevTime, count);
				    hadItem := true;
				    if ES*.es_gotControlC() then
					quit := true;
				    fi;
				    n* := saveItem;
				fi;
				count := 1;
				prevVerb := n*.n_verb;
				prevActor := n*.n_actor;
				prevVictim := n*.n_victim;
				prevTime := n*.n_time;
			    else
				count := count + 1;
			    fi;
			fi;
		    fi;
		else
		    ES*.es_request.rq_u.ru_telegram.te_time := time;
		    server(rt_readPropaganda, 0);
		    count := ES*.es_request.rq_u.ru_telegram.te_length;
		    if count ~= 0 then
			BlockCopy(&buff[0],
				  &ES*.es_request.rq_u.ru_telegram.te_data[0],
				  count);
			buff[count] := '\e';
			prevTime := ES*.es_request.rq_u.ru_telegram.te_time;
			server(rt_readCountry,
			       ES*.es_request.rq_u.ru_telegram.te_from);
			user(&ES*.es_request.rq_u.ru_country.c_name[0]);
			user(" at ");
			uTime(prevTime);
			user(":\n");
			user(&buff[0]);
			userNL();
			hadOne := true;
		    else
			hadOne := false;
		    fi;
		fi;
		if not hadOne then
		    day := day + 1;
		    time := time + timeStep;
		    item := 0;
		fi;
	    od;
	    if day ~= 4 and count ~= 0 and not quit then
		sayNews(prevVerb, prevActor, prevVictim, prevTime, count);
		hadItem := true;
	    fi;
	    page := page + 1;
	    if hadItem then
		userNL();
	    fi;
	od;
    fi;
corp;

proc cmd_propaganda()bool:
    *char fileName;

    fileName := nil;
    if skipBlanks()* = '<' then
	ES*.es_textInPos := ES*.es_textInPos + sizeof(char);
	fileName := skipBlanks();
	skipWord()* := '\e';
	if fileName* = '\e' then
	    fileName := nil;
	fi;
    fi;
    if getText(tt_propaganda, fileName, 0) then
	server(rt_nop, 0);
	ES*.es_request.rq_u.ru_telegram.te_time := ES*.es_request.rq_time;
	ES*.es_request.rq_u.ru_telegram.te_from := ES*.es_countryNumber;
	server(rt_propaganda, 0);
	true
    else
	false
    fi
corp;

proc cmd_message()void:
    register *char p, q;
    register int len;
    uint country;
    bool ok, wasDeity;

    ok := false;
    if ES*.es_textInPos* ~= '\e' then
	if getCountry(&country, true, false) then
	    server(rt_readCountry, country);
	    wasDeity := ES*.es_request.rq_u.ru_country.c_status = cs_deity;
	    p := skipBlanks();
	    if p* = '\e' then
		ok := getText(tt_message, nil, 0);
	    else
		q := &ES*.es_request.rq_u.ru_telegram.te_data[0];
		len := CharsLen(&ES*.es_country.c_name[0]);
		BlockCopy(q, &ES*.es_country.c_name[0], len);
		q := q + len * sizeof(char);
		q* := ':';
		q := q + sizeof(char);
		q* := ' ';
		q := q + sizeof(char);
		len := len + 2;
		while p* ~= '\e' do
		    q* := p*;
		    q := q + sizeof(char);
		    p := p + sizeof(char);
		    len := len + 1;
		od;
		q* := '\n';
		q := q + sizeof(char);
		q* := '\e';
		len := len + 2;
		ES*.es_request.rq_u.ru_telegram.te_length := len;
		ok := true;
	    fi;
	fi;
    elif reqCountry(&country, "Country to send message to: ", true) then
	server(rt_readCountry, country);
	wasDeity := ES*.es_request.rq_u.ru_country.c_status = cs_deity;
	ok := getText(tt_message, nil, 0);
    fi;
    if ok then
	ES*.es_request.rq_u.ru_telegram.te_to := country;
	server(rt_message, country);
	if ES*.es_request.rq_whichUnit = MESSAGE_NO_COUNTRY then
	    if ES*.es_country.c_status = cs_deity or
		ES*.es_country.c_status = cs_active
	    then
		if ask("Not logged in - send as telegram? ") then
		    ES*.es_request.rq_u.ru_telegram.te_time :=
			ES*.es_request.rq_time;
		    ES*.es_request.rq_u.ru_telegram.te_from :=
			ES*.es_countryNumber;
		    server(rt_sendTelegram, country);
		    if ES*.es_country.c_status ~= cs_deity and not wasDeity
		    then
			news(n_sent_telegram, ES*.es_countryNumber, country);
		    fi;
		fi;
	    else
		err("no longer logged in");
	    fi;
	elif ES*.es_request.rq_whichUnit = MESSAGE_FAIL then
	    err("sorry, message send failed - no space in server");
	fi;
    fi;
corp;

/*
 * startChat - ready a header to go into a chat message.
 */

proc startChat(*char m)uint:
    register *char p, q;
    register uint len;

    q := &ES*.es_request.rq_u.ru_telegram.te_data[0];
    len := 0;
    if m ~= nil then
	q* := '*';
	q := q + sizeof(char);
	q* := '*';
	q := q + sizeof(char);
	q* := '*';
	q := q + sizeof(char);
	len := 3;
    fi;
    p := &ES*.es_country.c_name[0];
    while p* ~= '\e' do
	q* := p*;
	q := q + sizeof(char);
	p := p + sizeof(char);
	len := len + 1;
    od;
    q* := ':';
    q := q + sizeof(char);
    q* := ' ';
    q := q + sizeof(char);
    len := len + 2;
    if m ~= nil then
	p := m;
	while p* ~= '\e' do
	    q* := p*;
	    q := q + sizeof(char);
	    p := p + sizeof(char);
	    len := len + 1;
	od;
	q* := '\n';
	q := q + sizeof(char);
	q* := '\e';
	len := len + 2;
    fi;
    len
corp;

/*
 * cmd_chat - go into chat mode.
 */

proc cmd_chat()void:
    register *char p, q;
    register uint len;

    user("Entering chat mode. Eof or . to exit.\n");
    server(rt_setChat, 1);
    ES*.es_request.rq_u.ru_telegram.te_length := startChat("<ENTERED>");
    server(rt_sendChat, 0);
    while
	while
	    server(rt_getMessage, 0);
	    ES*.es_request.rq_u.ru_telegram.te_length ~= 0
	do
	    user(&ES*.es_request.rq_u.ru_telegram.te_data[0]);
	od;
	user2(&ES*.es_country.c_name[0], "> ");
	uFlush();
	p := &ES*.es_textIn[0];
	ES*.es_readUser() and
	    (p* ~= '.' or (p + sizeof(char))* ~= '\e')
    do
	if p* ~= '\e' then
	    len := startChat(nil);
	    q := &ES*.es_request.rq_u.ru_telegram.te_data[len];
	    while p* ~= '\e' do
		q* := p*;
		q := q + sizeof(char);
		p := p + sizeof(char);
		len := len + 1;
	    od;
	    q* := '\n';
	    q := q + sizeof(char);
	    q* := '\e';
	    len := len + 2;
	    ES*.es_request.rq_u.ru_telegram.te_length := len;
	    server(rt_sendChat, 0);
	fi;
    od;
    server(rt_setChat, 0);
    ES*.es_request.rq_u.ru_telegram.te_length := startChat("<EXITED>");
    server(rt_sendChat, 0);
    user("Leaving chat mode.\n");
corp;

/*
 * notify - send the buffered up message, after adding a newline, to the
 *	given country as a telegram or direct print.
 */

proc notify(uint country)void:

    if country = ES*.es_countryNumber then
	userNL();
    else
	ES*.es_textOut[ES*.es_textOutPos] := '\n';
	ES*.es_textOut[ES*.es_textOutPos + 1] := '\e';
	BlockCopy(&ES*.es_request.rq_u.ru_telegram.te_data[0],
		  &ES*.es_textOut[0], ES*.es_textOutPos + 2);
	ES*.es_request.rq_u.ru_telegram.te_time := ES*.es_request.rq_time;
	ES*.es_request.rq_u.ru_telegram.te_from := NOBODY;
	ES*.es_request.rq_u.ru_telegram.te_to := country;
	ES*.es_request.rq_u.ru_telegram.te_length := ES*.es_textOutPos + 2;
	server(rt_sendTelegram, country);
	ES*.es_textOutPos := 0;
    fi;
corp;
