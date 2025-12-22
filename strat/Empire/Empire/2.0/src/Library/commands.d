#/Include/Empire.g
#/Include/Request.g
#EmpPrivate.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

[76] bool INACTIVE_ALLOWED = (
    false, false, false, false, false, false, false, true , false, true ,
    false, false, true , false, true , false, false, false, false, false,
    false, false, false, false, false, false, false, true , true , false,
    false, true , false, false, false, false, false, false, false, true ,
    false, true , false, false, false, false, false, false, false, false,
    false, false, false, false, true , false, false, false, false, true ,
    true , true , true , false, false, false, false, false, false, false,
    false, true , false, false, true , true
);

/*
 * list - print one string as part of the three-column help listing.
 */

proc list(register *char p)void:
    uint LIST_WIDTH = 25;

    user(p);
    if ES*.es_textOutPos > LIST_WIDTH * 2 then
	userNL();
    else
	while ES*.es_textOutPos % LIST_WIDTH ~= 0 do
	    userSp();
	od;
    fi;
corp;

/*
 * cmd_list - print a list of currently implemented commands.
 */

proc cmd_list()void:

    user("Empire commands are:\n\n");
    list("accept - 2 BTU's");
    list("assault - 2 BTU's");
    list("attack - 2 BTU's");
    list("board - 2 BTU's");
    list("build - 2 BTU's");
    list("buy - 2 BTU's");
    list("bye");
    list("census");
    list("change");
    list("chat");
    list("checkpoint - 2 BTU's");
    list("collect - 2 BTU's");
    list("contract - 2 BTU's");
    list("country");
    list("declare - 2 BTU's");
    list("defend - 2 BTU's");
    list("deliver - 1 BTU");
    list("designate - 1 BTU");
    list("dissolve");
    list("doc");
    list("drop - 2 BTU's");
    list("dump");
    list("enlist - 2 BTU's");
    list("enumerate");
    list("fire - 2 BTU's");
    list("fleet - 1 BTU");
    list("fly - 2 BTU's");
    list("forecast - 1 BTU");
    list("grant - 1 BTU");
    list("headlines");
    list("info");
    list("ledger");
    list("lend - 2 BTU's");
    list("load - 2 BTU's");
    list("log");
    list("lookout - 2 BTU's");
    list("map - 1 BTU");
    list("message");
    list("mine - 2 BTU's");
    list("move - 2 BTU's");
    list("nation");
    list("navigate - 2 BTU's");
    list("newspaper");
    list("power");
    list("price - 2 BTU's");
    list("propaganda - 5 BTU's");
    list("radar - 2 BTU's");
    list("read");
    list("realm");
    list("refurb - 2 BTU's");
    list("repay - 2 BTU's");
    list("report - 2 BTU's");
    list("route - 1 BTU");
    list("ships");
    list("spy - 1 BTU");
    list("telegram");
    list("tend - 2 BTU's");
    list("torpedo - 2 BTU's");
    list("unload - 2 BTU's");
    list("update - 1 BTU");
    list("weather");
    if ES*.es_textOutPos ~= 0 then
	userNL();
    fi;
    user("\nUse 'help <command>' to get help on a particular command.\n"
	 "See also the 'doc' command.\n");
corp;

/*
 * cmd_help - try to print a help or doc file on a given subject.
 */

proc cmd_help(bool isHelp)void:
    register *char inputPos, wordStart;
    *char wordEnd;

    inputPos := ES*.es_textInPos;
    if inputPos* = '\e' then
	cmd_list();
    else
	while inputPos* ~= '\e' do
	    wordStart := inputPos;
	    wordEnd := skipWord();
	    inputPos := skipBlanks();
	    wordEnd* := '\e';
	    if not printFile(wordStart, if isHelp then ft_help else ft_doc fi)
	    then
		user3(
		    if isHelp then
			"No help for topic \""
		    else
			"No doc for topic \""
		    fi,
		    wordStart, "\"\n");
	    fi;
	od;
    fi;
corp;

/*
 * chargeCommand - try a command, if user can afford it. Add the BTU's back
 *	if the command returns 'false'.
 */

proc chargeCommand(proc()bool command; uint cost)void:

    if ES*.es_country.c_status = cs_deity then
	pretend(command(), void);
    else
	if ES*.es_country.c_btu < cost then
	    user("You don't have enough BTU's remaining!\n");
	else
	    ES*.es_country.c_btu := ES*.es_country.c_btu - cost;
	    if not command() then
		ES*.es_country.c_btu := ES*.es_country.c_btu + cost;
	    fi;
	    server(rt_lockCountry, ES*.es_countryNumber);
	    ES*.es_request.rq_u.ru_country.c_btu := ES*.es_country.c_btu;
	    server(rt_unlockCountry, ES*.es_countryNumber);
	    ES*.es_country := ES*.es_request.rq_u.ru_country;
	fi;
    fi;
corp;

/*
 * doCommand - attempt to execute the given single command.
 */

proc doCommand(uint cmd; *char command)void:

    if ES*.es_country.c_status ~= cs_deity and
	ES*.es_country.c_status ~= cs_active and
	not INACTIVE_ALLOWED[cmd]
    then
	user("You are not allowed to use that command.\n");
    else
	case cmd
	incase 2:
	    chargeCommand(cmd_accept, 2);
	incase 3:
	    chargeCommand(cmd_assault, 2);
	incase 4:
	    chargeCommand(cmd_attack, 2);
	incase 5:
	    chargeCommand(cmd_board, 2);
	incase 6:
	    chargeCommand(cmd_build, 2);
	incase 8:
	    ES*.es_quietUpdate := false;
	    cmd_census();
	incase 9:
	    cmd_change();
	incase 10:
	    chargeCommand(cmd_checkpoint, 2);
	incase 11:
	    chargeCommand(cmd_collect, 2);
	incase 12:
	    cmd_list();
	incase 13:
	    chargeCommand(cmd_contract, 2);
	incase 14:
	    cmd_country();
	incase 15:
	    cmd_fleet();
	incase 16:
	    chargeCommand(cmd_defend, 2);
	incase 17:
	    chargeCommand(cmd_deliver, 1);
	incase 18:
	    chargeCommand(cmd_declare, 2);
	incase 19:
	    /* this costs 1 BTU, but is free if the country has no BTU's and
	       no active capital */
	    cmd_designate();
	incase 20:
	    cmd_dissolve();
	incase 21:
	    chargeCommand(cmd_enlist, 2);
	incase 22:
	    chargeCommand(cmd_buy, 2);
	incase 23:
	    chargeCommand(cmd_fire, 2);
	incase 24:
	    chargeCommand(cmd_fly, 2);
	incase 25:
	    chargeCommand(cmd_forecast, 1);
	incase 26:
	    chargeCommand(cmd_grant, 1);
	incase 27:
	    cmd_headlines();
	incase 28:
	    cmd_info();
	incase 29:
	    cmd_ledger();
	incase 30:
	    chargeCommand(cmd_lend, 2);
	incase 31:
	    cmd_list();
	incase 32:
	    chargeCommand(cmd_load, 2);
	incase 33:
	    chargeCommand(cmd_lookout, 2);
	incase 34:
	    chargeCommand(cmd_map, 1);
	incase 35:
	    chargeCommand(cmd_mine, 2);
	incase 36:
	    chargeCommand(cmd_move, 2);
	incase 37:
	    cmd_nation();
	incase 38:
	    chargeCommand(cmd_navigate, 2);
	incase 39:
	    cmd_newspaper();
	incase 41:
	    cmd_power();
	incase 42:
	    chargeCommand(cmd_radar, 2);
	incase 43:
	    cmd_read();
	incase 44:
	    cmd_realm();
	incase 45:
	    chargeCommand(cmd_repay, 2);
	incase 46:
	    chargeCommand(cmd_route, 1);
	incase 47:
	    chargeCommand(cmd_price, 2);
	incase 48:
	    chargeCommand(cmd_drop, 2);
	incase 49:
	    chargeCommand(cmd_ships, 0);
	incase 50:
	    chargeCommand(cmd_spy, 1);
	incase 51:
	    cmd_telegram();
	incase 52:
	    chargeCommand(cmd_tend, 2);
	incase 53:
	    chargeCommand(cmd_torpedo, 2);
	incase 54:
	    chargeCommand(cmd_report, 2);
	incase 56:
	    chargeCommand(cmd_unload, 2);
	incase 57:
	    ES*.es_quietUpdate := false;
	    chargeCommand(cmd_update, 1);
	incase 59:
	    cmd_weather();
	incase 60:
	    cmd_message();
	incase 61:
	    cmd_help(true);
	incase 62:
	    cmd_list();
	incase 63:
	    cmd_examine();
	incase 64:
	    cmd_dump();
	incase 65:
	    cmd_edit();
	incase 66:
	    cmd_translate();
	incase 67:
	    chargeCommand(cmd_refurb, 2);
	incase 68:
	    chargeCommand(cmd_propaganda, 5);
	incase 69:
	    cmd_enumerate();
	incase 70:
	    cmd_untranslate();
	incase 71:
	    cmd_chat();
	incase 72:
	    cmd_flush();
	incase 73:
	    cmd_tickle();
	incase 74:
	    cmd_log();
	incase 75:
	    cmd_help(false);
	default:
	    user3("Unimplemented Empire command: ", command, "\n");
	esac;
    fi;
corp;

/*
 * processCommands - loop, getting commands and parsing them.
 */

proc processCommands()void:
    *char COMMAND_LIST =
		/*  2 */ "accept\e"
		/*  3 */ "assault\e"
		/*  4 */ "attack\e"
		/*  5 */ "board\e"
		/*  6 */ "build\e"
		/*  7 */ "bye\e"
		/*  8 */ "census\e"
		/*  9 */ "change\e"
		/* 10 */ "checkpoint\e"
		/* 11 */ "collect\e"
		/* 12 */ "commands\e"
		/* 13 */ "contract\e"
		/* 14 */ "country\e"
		/* 15 */ "fleet\e"
		/* 16 */ "defend\e"
		/* 17 */ "deliver\e"
		/* 18 */ "declare\e"
		/* 19 */ "designate\e"
		/* 20 */ "dissolve\e"
		/* 21 */ "enlist\e"
		/* 22 */ "buy\e"
		/* 23 */ "fire\e"
		/* 24 */ "fly\e"
		/* 25 */ "forecast\e"
		/* 26 */ "grant\e"
		/* 27 */ "headlines\e"
		/* 28 */ "info\e"
		/* 29 */ "ledger\e"
		/* 30 */ "lend\e"
		/* 31 */ "list\e"
		/* 32 */ "load\e"
		/* 33 */ "lookout\e"
		/* 34 */ "map\e"
		/* 35 */ "mine\e"
		/* 36 */ "move\e"
		/* 37 */ "nation\e"
		/* 38 */ "navigate\e"
		/* 39 */ "newspaper\e"
		/* 40 */ "offer\e"
		/* 41 */ "power\e"
		/* 42 */ "radar\e"
		/* 43 */ "read\e"
		/* 44 */ "realm\e"
		/* 45 */ "repay\e"
		/* 46 */ "route\e"
		/* 47 */ "price\e"
		/* 48 */ "drop\e"
		/* 49 */ "ships\e"
		/* 50 */ "spy\e"
		/* 51 */ "telegram\e"
		/* 52 */ "tend\e"
		/* 53 */ "torpedo\e"
		/* 54 */ "report\e"
		/* 55 */ "treaty\e"
		/* 56 */ "unload\e"
		/* 57 */ "update\e"
		/* 58 */ "vote\e"
		/* 59 */ "weather\e"
		/* 60 */ "message\e"
		/* 61 */ "help\e"
		/* 62 */ "?\e"
		/* 63 */ "examine\e"
		/* 64 */ "dump\e"
		/* 65 */ "edit\e"
		/* 66 */ "translate\e"
		/* 67 */ "refurb\e"
		/* 68 */ "propaganda\e"
		/* 69 */ "enumerate\e"
		/* 70 */ "untranslate\e"
		/* 71 */ "chat\e"
		/* 72 */ "flush\e"
		/* 73 */ "tickle\e"
		/* 74 */ "log\e"
		/* 75 */ "doc\e";
    *char command, p;
    long income;
    uint cmd;
    bool quit;

    quit := false;
    while not quit do
	userC('[');
	userN(ES*.es_country.c_btu);
	userC(':');
	userN(ES*.es_country.c_timeLeft);
	uPrompt("] Command: ");
	if not ES*.es_readUser() then
	    userNL();
	    quit := true;
	else
	    command := skipBlanks();
	    if command* ~= '\e' then
		p := skipWord();
		ignore skipBlanks();
		p* := '\e';
		ES*.es_quietUpdate := true;
		ES*.es_verboseUpdate := false;
		ES*.es_contractEarnings := 0;
		ES*.es_interestEarnings := 0;
		ES*.es_improvementCost := 0;
		ES*.es_militaryCost := 0;
		ES*.es_utilitiesCost := 0;
		cmd := lookupCommand(COMMAND_LIST, command);
		if cmd = 0 then
		    user3("Unknown Empire command: ", command, "\n");
		elif cmd = 1 then
		    user3("Ambiguous Empire command: ", command, "\n");
		elif cmd = 7 then
		    /* bye */
		    quit := true;
		else
		    doCommand(cmd, command);
		    ignore ES*.es_gotControlC();
		fi;
		if ES*.es_contractEarnings ~= 0 then
		    userN3("You earned $", ES*.es_contractEarnings,
			   " from contracted production.\n");
		fi;
		if ES*.es_interestEarnings ~= 0 then
		    userN3("You earned $", ES*.es_interestEarnings,
			   " interest from bank deposits.\n");
		fi;
		if ES*.es_improvementCost ~= 0 then
		    userN3("You paid $", ES*.es_improvementCost,
			   " for sector improvements.\n");
		fi;
		if ES*.es_militaryCost ~= 0 then
		    userN3("You paid $", ES*.es_militaryCost,
			   " for military supplies.\n");
		fi;
		if ES*.es_utilitiesCost ~= 0 then
		    userN3("You paid $", ES*.es_utilitiesCost,
			   " for utilities.\n");
		fi;
		income := ES*.es_contractEarnings + ES*.es_interestEarnings -
			ES*.es_improvementCost - ES*.es_militaryCost -
			ES*.es_utilitiesCost;
		if income ~= 0 then
		    server(rt_lockCountry, ES*.es_countryNumber);
		    ES*.es_request.rq_u.ru_country.c_money :=
			ES*.es_request.rq_u.ru_country.c_money + income;
		    server(rt_unlockCountry, ES*.es_countryNumber);
		    /* The money was already put here by 'updateSector', but
		       doing it again will reflect changes from any other
		       simultaneous players */
		    ES*.es_country.c_money :=
			ES*.es_request.rq_u.ru_country.c_money;
		fi;
	    fi;
	    if cmd ~= 9 then		/* kludge! */
		messageCheck();
	    fi;
	    if updateTimer() then
		/* user's timer has expired! Log him out! */
		user("You've run out of time! Call back tomorrow.\n");
		quit := true;
	    fi;
	fi;
    od;
corp;
