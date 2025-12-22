/*
 * Amiga MUD
 *
 * Copyright (c) 1995 by Chris Gray
 */

/*
 * build - code to come after the full startup set to set up the commands
 *	which allow simple room-building.
 *	NOTE: most of the code must be 'utility', since we want the rooms,
 *	etc. to be owned by the character issuing the commands.
 */

private tp_build1 CreateTable().
use tp_build1

define tp_build r_playPen CreateThing(r_indoors).

define tp_build p_rPlayPen CreateBoolProp().
define tp_build1 p_pActiveDir CreateIntProp().
define tp_build1 p_pActiveCode CreateStringProp().
define tp_build1 p_pActiveState CreateIntProp().
define tp_build1 p_pSaveState CreateIntProp().
    define tp_build1 st_noState 	0.
    define tp_build1 st_preCondition	1.
    define tp_build1 st_condition	2.
    define tp_build1 st_then		3.
    define tp_build1 st_else		4.
    define tp_build1 st_descTrue	5.
    define tp_build1 st_descFalse	6.
    define tp_build1 st_descResult	7.
    define tp_build1 st_condition2	8.
    define tp_build1 st_then2		9.
    define tp_build1 st_else2		10.
    define tp_build1 STRING_FIRST	20.
    define tp_build1 STRING_OTHER	40.
define tp_build1 p_pHadCondition CreateBoolProp().
define tp_build1 p_pCodeKind CreateIntProp().
    define tp_build1 ck_roomChecker	0.
    define tp_build1 ck_objectChecker	1.
    define tp_build1 ck_roomDesc	2.
    define tp_build1 ck_objectDesc	3.
    define tp_build1 ck_roomVoid	4.
    define tp_build1 ck_objectVoid	5.
define tp_build1 p_pNewName CreateStringProp().
define tp_build1 p_pActiveThing CreateThingProp().
define tp_build1 p_pActiveTable CreateTableProp().
define tp_build1 p_pActiveVerb CreateStringProp().

define tp_build1 wh_character	 0.
define tp_build1 wh_room	 1.
define tp_build1 wh_object	 2.

CharacterThing(SysAdmin)@p_pBuilder := true.

define tp_build1 g_build CreateGrammar().

define tp_build1 proc utility v_build()bool:
    string s;

    if Me()@p_pBuilder or Here()@p_rPlayPen then
	s := GetTail();
	if s = "" then
	    Print("Missing build command - "
		  "see builder's library for details.\n");
	    false
	else
	    Parse(g_build, s) ~= 0
	fi
    else
	Print("Sorry, you have not been enabled for building.\n");
	false
    fi
corp;

VerbTail(G, "@", v_build).
Synonym(G, "@", "b").
Synonym(G, "@", "build").
Synonym(G, "@", "construct").

define tp_build proc utility checkTable(string tableName)table:
    table theTable;

    theTable := LookupTable(nil, tableName);
    if theTable = nil then
	if IsDefined(nil, tableName) then
	    Print("\"" + tableName + "\" is not a table.\n");
	else
	    Print("\"" + tableName + "\" is not defined.\n");
	fi;
	nil
    else
	theTable
    fi
corp;

define tp_build1 proc utility findTable(string tableName; bool readOnly)table:
    table theTable;

    if tableName = "public" then
	if Me()@p_pBuilder or readOnly then
	    PublicTable()
	else
	    Print("Only true builders can change the public symbol table.\n");
	    nil
	fi
    elif tableName = "private" then
	PrivateTable()
    else
	checkTable(tableName)
    fi
corp;

/*****************************************************************************\
*									      *
*		code to implement a 'compiler' for actions		      *
*									      *
\*****************************************************************************/

define tp_build1 proc utility error(string str)void:

    Print("*** " + str + ".\n");
    if not Me()@p_pHidden then
	OPrint(FormatName(Me()@p_pName) +
	    " abruptly stops gesturing and grimaces.\n");
    fi;
corp;

define tp_build1 proc utility stringError(string w, str)void:
    error("'" + w + "' " + str);
corp;

define tp_build1 proc utility notCounter(string w)void:
    stringError(w, "is not a defined counter");
corp;

define tp_build1 proc utility notFlag(string w)void:
    stringError(w, "is not a defined flag");
corp;

define tp_build1 proc utility notString(string w)void:
    stringError(w, "is not a defined string");
corp;

define tp_build1 proc utility notObject(string w)void:
    stringError(w, "is not an object-symbol");
corp;

define tp_build1 proc utility notRoom(string w)void:
    stringError(w, "isnot a room-symbol");
corp;

define tp_build1 proc utility checkWord(string w, nameTail1, nameTail2;
					int kind)bool:

    w == "character" + nameTail1 or w == "character" + nameTail2 or
    w == "room" + nameTail1 or w == "room" + nameTail2 or
    (kind = ck_objectChecker or kind = ck_objectDesc or
	kind = ck_objectVoid) and
	(w == "object" + nameTail1 or w == "object" + nameTail2)
corp;

define tp_build1 proc utility pickWhich(string w, nameTail1, nameTail2)int:

    if w == "character" + nameTail1 or w == "character" + nameTail2 then
	wh_character
    elif w == "room" + nameTail1 or w == "room" + nameTail2 then
	wh_room
    else
	/* do NOT check for "object" + nameTail */
	wh_object
    fi
corp;

define tp_build1 proc utility doWhich(int which)string:

    case which
    incase wh_character:
	"Me()"
    incase wh_room:
	"Here()"
    incase wh_object:
	"It()"
    default:
	"xxx"
    esac
corp;

define tp_build1 proc utility doWhich2(int which)string:

    case which
    incase wh_character:
	"p_pCarrying"
    incase wh_room:
	"p_rContents"
    incase wh_object:
	"p_oContents"
    default:
	"xxx"
    esac
corp;

define tp_build1 proc utility roomToObject(int kind)void:

    Me()@p_pCodeKind :=
	case kind
	incase ck_roomChecker:
	    ck_objectChecker
	incase ck_roomDesc:
	    ck_objectDesc
	incase ck_roomVoid:
	    ck_objectVoid
	default:
	    kind
	esac;
corp;

define tp_build1 proc utility checkStringSpecials(string s; int kind;
						  string code)string:
    int which, len, pos;
    string w;
    property string theString;
    property int theCounter;

    if SubString(s, 0, 1) = "@" then
	SetTail(SubString(s, 1, Length(s) - 1));
	w := GetWord();
	if checkWord(w, "string", "", kind) then
	    which := pickWhich(w, "string", "");
	    w := GetWord();
	    if w = "" then
		error("Missing string-symbol");
	    else
		theString := LookupString(nil, w);
		if theString = nil then
		    notString(w);
		else
		    code := code + "\"+" + doWhich(which) + "@" + w + "+\"";
		fi;
	    fi;
	elif checkWord(w, "counter", "", kind) then
	    which := pickWhich(w, "counter", "");
	    w := GetWord();
	    if w = "" then
		error("Missing counter-symbol");
	    else
		theCounter := LookupCounter(nil, w);
		if theCounter = nil then
		    notCounter(w);
		else
		    code := code + "\"+IntToString(" + doWhich(which) + "@" +
			w + ")+\"";
		fi;
	    fi;
	elif checkWord(w, "name", "", kind) then
	    case pickWhich(w, "name", "")
	    incase wh_character:
		code := code + "\"+FormatName(Me()@p_pName)+\"";
	    incase wh_room:
		code := code + "\"+Here()@p_rName+\"";
	    incase wh_object:
		code := code + "\"+FormatName(It()@p_oName)+\"";
	    esac;
	else
	    stringError(w, "is not a known text escape");
	fi;
    else
	len := Length(s);
	w := "";
	while
	    pos := Index(s, "\"");
	    pos >= 0
	do
	    w := w + SubString(s, 0, pos) + "\\\"";
	    len := len - pos - 1;
	    s := SubString(s, pos + 1, len);
	od;
	code := code + w + s;
    fi;
    code
corp;

define tp_build1 proc utility continuePrompt(int state, kind)void:

    case state
    incase st_preCondition:
	if kind = ck_roomVoid or kind = ck_objectVoid then
	    Print("Continue entering actions:\n");
	    ignore SetPrompt("* actions> ");
	else
	    Print("Continue entering pre-condition actions:\n");
	    ignore SetPrompt("* pre-condition actions> ");
	fi;
    incase st_then:
    incase st_then2:
	Print("Continue entering the true actions:\n");
	ignore SetPrompt("* true actions> ");
    incase st_else:
    incase st_else2:
	Print("Continue entering the false actions:\n");
	ignore SetPrompt("* false actions> ");
    esac;
corp;

define tp_build1 proc utility conditionPrompt()void:
    Print("Now enter the conditions for the test:\n");
    ignore SetPrompt("* condition> ");
corp;

define tp_build1 proc utility truePrompt()void:
    Print("Now enter the actions to do if condition is true:\n");
    ignore SetPrompt("* true actions> ");
corp;

define tp_build1 proc utility falsePrompt()void:
    Print("Now enter the actions to do if condition is false:\n");
    ignore SetPrompt("* false actions> ");
corp;

define tp_build1 proc utility compileCode(string code)void:
    action a;
    thing me;
    string characterName;

    me := Me();
    characterName := FormatName(me@p_pName);
    a := StringToAction(code);
    if a = nil then
	error("Errors in action - not defined");
    else
	if DefineAction(me@p_pActiveTable, me@p_pNewName, a) then
	    Print("Action '" + me@p_pNewName + "' defined.\n");
	fi;
	if not me@p_pHidden then
	    OPrint(characterName + " finishes gesturing.\n");
	fi;
    fi;
corp;

define tp_build1 proc utility bv_actionLineHandler(string s)void:
    thing me, theThing, theRoom;
    int state, kind, value, which;
    string code, w, w2, w3, errMess;
    action a;
    property bool theFlag;
    property int theCounter;
    property string theString;
    bool ending, tf, isNegative;

    ending := false;
    me := Me();
    state := me@p_pActiveState;
    code := me@p_pActiveCode;
    kind := me@p_pCodeKind;
    if s = "." then
	case state
	incase st_preCondition:
	    /* end of pre-condition actions */
	    if kind = ck_roomVoid or kind = ck_objectVoid then
		compileCode(code);
		ending := true;
	    else
		state := st_condition;
		conditionPrompt();
	    fi;
	incase st_condition:
	    /* end of condition */
	    if not me@p_pHadCondition then
		if kind = ck_roomDesc or kind = ck_objectDesc then
		    if code ~= "" then
			code := code + ";";
		    fi;
		    code := code + "\"";
		    state := st_descResult + STRING_FIRST;
		    Print("Now enter the result description:\n");
		    ignore SetPrompt("* description result> ");
		else
		    if kind = ck_objectChecker then
			code := code + ";succeed";
		    else
			code := code + ";continue";
		    fi;
		    compileCode(code);
		    ending := true;
		fi;
	    else
		code := code + " then ";
		state := st_then;
		truePrompt();
	    fi;
	incase st_then:
	    /* end of 'then' actions */
	    if kind = ck_roomDesc or kind = ck_objectDesc then
		code := code + "\"";
		state := st_descTrue + STRING_FIRST;
		Print("Now enter the true description result:\n");
		ignore SetPrompt("* true description result> ");
	    else
		if kind = ck_objectChecker then
		    code := code + "succeed else ";
		else
		    code := code + "continue else ";
		fi;
		state := st_else;
		falsePrompt();
	    fi;
	incase st_else:
	    /* end of 'else' actions */
	    if kind = ck_roomDesc or kind = ck_objectDesc then
		code := code + "\"";
		state := st_descFalse + STRING_FIRST;
		Print("Now enter the false description result:\n");
		ignore SetPrompt("* false description result> ");
	    else
		code := code + "fail fi";
		compileCode(code);
		ending := true;
	    fi;
	incase st_condition2:
	    if not me@p_pHadCondition then
		error("Condition is required on 'if'");
		ending := true;
	    else
		code := code + " then ";
		state := st_then2;
		truePrompt();
	    fi;
	incase st_then2:
	    code := code + "else ";
	    state := st_else2;
	    falsePrompt();
	incase st_else2:
	    code := code + "fi;";
	    state := me@p_pSaveState;
	    me -- p_pSaveState;
	    continuePrompt(state, kind);
	default:
	    /* end of a string */
	    if state >= STRING_OTHER then
		state := state - STRING_OTHER;
	    else
		state := state - STRING_FIRST;
	    fi;
	    case state
	    incase st_preCondition:
	    incase st_then:
	    incase st_else:
	    incase st_then2:
	    incase st_else2:
		code := code + "\\n\");";
		continuePrompt(state, kind);
	    incase st_descTrue:
		/* end of 'then' description result */
		code := code + "\" else ";
		state := st_else;
		falsePrompt();
	    incase st_descFalse:
		/* end of 'else' description result */
		code := code + "\" fi";
		compileCode(code);
		ending := true;
	    incase st_descResult:
		/* end of the description result string */
		code := code + "\"";
		compileCode(code);
		ending := true;
	    esac;
	esac;
    else
	errMess := "Missing flag/counter-symbol";
	SetTail(s);
	w := GetWord();
	if state = st_condition or state = st_condition2 then
	    /* handling conditions */
	    if me@p_pHadCondition then
		code := code + " and ";
	    else
		code := code + "if ";
		me@p_pHadCondition := true;
	    fi;
	    if w == "not" then
		code := code + "not ";
		w := GetWord();
	    fi;
	    if w == "fail" then
		code := code + "false";
	    elif checkWord(w, "flag", "", kind) then
		which := pickWhich(w, "flag", "");
		w := GetWord();
		if w = "" then
		    error(errMess);
		    ending := true;
		else
		    theFlag := LookupFlag(nil, w);
		    if theFlag ~= nil then
			code := code + doWhich(which) + "@" + w;
		    else
			notFlag(w);
			ending := true;
		    fi;
		fi;
	    elif checkWord(w, "counter", "", kind) then
		which := pickWhich(w, "counter", "");
		w := GetWord();
		if w = "" then
		    error(errMess);
		    ending := true;
		else
		    theCounter := LookupCounter(nil, w);
		    if theCounter ~= nil then
			w2 := GetWord();
			isNegative := false;
			if SubString(w2, 0, 1) = "-" then
			    isNegative := true;
			    w2 := SubString(w2, 1, Length(w2) - 1);
			elif SubString(w2, 0, 1) = "+" then
			    w2 := SubString(w2, 1, Length(w2) - 1);
			fi;
			value := StringToPosInt(w2);
			if value < 0 then
			    error("Missing or invalid counter value");
			    ending := true;
			else
			    if isNegative then
				value := -value;
			    fi;
			    code := code + doWhich(which) + "@" + w + "=" +
				IntToString(value);
			fi;
		    else
			notCounter(w);
			ending := true;
		    fi;
		fi;
	    elif checkWord(w, "hasspecific", "", kind) then
		which := pickWhich(w, "hasspecific", "");
		w := GetWord();
		if w = "" then
		    error("Missing object-symbol");
		    ending := true;
		else
		    theThing := LookupThing(nil, w);
		    if theThing ~= nil and theThing@p_oName ~= "" then
			code := code + "FindElement(" + doWhich(which) + "@" +
			    doWhich2(which) + "," + w + ")~=-1";
		    else
			notObject(w);
			ending := true;
		    fi;
		fi;
	    elif checkWord(w, "haschild", "", kind) then
		which := pickWhich(w, "haschild", "");
		w := GetWord();
		if w = "" then
		    error("Missing object child form");
		    ending := true;
		else
		    theThing := LookupThing(nil, w);
		    if theThing ~= nil and theThing@p_oName ~= "" then
			code := code + "FindChildOnList(" + doWhich(which) +
			    "@" + doWhich2(which) + "," + w + ")";
		    else
			notObject(w);
			ending := true;
		    fi;
		fi;
	    elif checkWord(w, "hasname", "", kind) then
		which := pickWhich(w, "hasname", "");
		w := GetWord();
		if w = "" then
		    error("Missing object name form");
		    ending := true;
		else
		    code := code + "FindName(" + doWhich(which) + "@" +
			    doWhich2(which) + ",p_oName,\"" + Strip(w) +
			    "\")~=fail";
		fi;
	    elif checkWord(w, "hasflag", "", kind) then
		which := pickWhich(w, "hasflag", "");
		w := GetWord();
		if w = "" then
		    error(errMess);
		    ending := true;
		else
		    theFlag := LookupFlag(nil, w);
		    if theFlag = nil then
			notFlag(w);
			ending := true;
		    else
			code := code + "FindFlagOnList(" + doWhich(which) +
			    "@" + doWhich2(which) + "," + w + ")";
		    fi;
		fi;
	    elif w == "random" then
		w := GetWord();
		value := StringToPosInt(w);
		if value <= 1 then
		    error("Missing or invalid random range");
		    ending := true;
		else
		    code := code + "Random(" + w + ")=0";
		fi;
	    else
		stringError(w, "is not a known condition");
		ending := true;
	    fi;
	elif state >= STRING_OTHER then
	    /* getting a string - subsequent hunk */
	    if s ~= "" then
		code := checkStringSpecials(s, kind, code + " ");
	    fi;
	elif state >= STRING_FIRST then
	    /* getting a string - first hunk */
	    code := checkStringSpecials(s, kind, code);
	    state := state - STRING_FIRST + STRING_OTHER;
	else
	    /* handling statements */
	    if checkWord(w, "setflag", "clearflag", kind) then
		which := pickWhich(w, "setflag", "clearflag");
		tf := w == "charactersetflag" or w == "roomsetflag" or
		    w == "objectsetflag";
		w := GetWord();
		if w = "" then
		    error(errMess);
		    ending := true;
		else
		    theFlag := LookupFlag(nil, w);
		    if theFlag = nil then
			notFlag(w);
			ending := true;
		    else
			if tf then
			    code := code + doWhich(which) + "@" + w +
				":=true;";
			else
			    code := code + doWhich(which) + "--" + w + ";";
			fi;
		    fi;
		fi;
	    elif checkWord(w, "inccounter", "deccounter", kind) then
		which := pickWhich(w, "inccounter", "deccounter");
		tf := w == "characterinccounter" or w == "roominccounter" or
		    w == "objectinccounter";
		w := GetWord();
		if w = "" then
		    error(errMess);
		    ending := true;
		else
		    theCounter := LookupCounter(nil, w);
		    if theCounter = nil then
			notCounter(w);
			ending := true;
		    else
			w2 := GetWord();
			if w2 ~= "" then
			    value := StringToPosInt(w2);
			    if value < 0 then
				error("Invalid inc/dec value");
				ending := true;
			    fi;
			else
			    value := 1;
			fi;
			w2 := doWhich(which);
			code := code + w2 + "@" + w + ":=" + w2 + "@" + w +
			    if tf then "+" else "-" fi +
			    IntToString(value) + ";";
		    fi;
		fi;
	    elif checkWord(w, "setcounter", "", kind) then
		which := pickWhich(w, "setcounter", "");
		w := GetWord();
		if w = "" then
		    error(errMess);
		    ending := true;
		else
		    theCounter := LookupCounter(nil, w);
		    if theCounter ~= nil then
			w2 := GetWord();
			isNegative := false;
			if SubString(w2, 0, 1) = "-" then
			    isNegative := true;
			    w2 := SubString(w2, 1, Length(w2) - 1);
			elif SubString(w2, 0, 1) = "+" then
			    w2 := SubString(w2, 1, Length(w2) - 1);
			fi;
			value := StringToPosInt(w2);
			if value < 0 then
			    error("Missing or invalid counter value");
			    ending := true;
			else
			    if value = 0 then
				code := code + doWhich(which) + "--" + w + ";";
			    else
				if isNegative then
				    value := -value;
				fi;
				code := code + doWhich(which) + "@" +
				    w + ":=" + IntToString(value) + ";";
			    fi;
			fi;
		    else
			notCounter(w);
			ending := true;
		    fi;
		fi;
	    elif checkWord(w, "setstring", "", kind) then
		which := pickWhich(w, "setstring", "");
		w := GetWord();
		if w = "" then
		    error("Missing string-symbol");
		    ending := true;
		else
		    theString := LookupString(nil, w);
		    if theString = nil then
			notString(w);
			ending := true;
		    elif w = "p_pName" or w = "p_rName" or w = "p_oName" then
			error("Sorry - you can't modify that string");
			ending := true;
		    else
			w3 := GetWord();
			if w3 = "" then
			    error("Missing string identifier");
			    ending := true;
			else
			    if w3 == "date" or w3 == "time" then
				w2 := "Date()";
			    elif w3 == "charactername" then
				w2 := "FormatName(Me()@p_pName)";
			    elif w3 == "roomname" then
				w2 := "Here()@p_rName";
			    elif w3 == "objectname" and
				(kind = ck_objectChecker or
				 kind = ck_objectDesc or
				 kind = ck_objectVoid)
			    then
				w2 := "FormatName(It()@p_oName)";
			    else
				stringError(w3,
				    "is not a known string identifier");
				ending := true;
				w2 := "\"\"";
			    fi;
			    code := code + doWhich(which) + "@" + w + ":=" +
				w2 + ";";
			fi;
		    fi;
		fi;
	    elif checkWord(w, "clearstring", "", kind) then
		which := pickWhich(w, "clearstring", "");
		w := GetWord();
		if w = "" then
		    error("Missing string-symbol");
		    ending := true;
		else
		    theString := LookupString(nil, w);
		    if theString ~= nil then
			code := code + doWhich(which) + "--" + w + ";";
		    else
			notString(w);
			ending := true;
		    fi;
		fi;
	    elif w == "clonehere" or w == "cloneat" then
		if not Me()@p_pBuilder then
		    error("Sorry, only true builders can clone things");
		    ending := true;
		elif w = "cloneat" then
		    w2 := GetWord();
		    if w2 = "" then
			error("Missing room-symbol");
			ending := true;
		    else
			theRoom := LookupThing(nil, w2);
			if theRoom = nil or theRoom@p_rName = "" then
			    notRoom(w2);
			    ending := true;
			fi;
		    fi;
		fi;
		w3 := GetWord();
		if ending or w3 = "" then
		    if not ending then
			error("Missing object-symbol");
			ending := true;
		    fi;
		else
		    theThing := LookupThing(nil, w3);
		    if theThing ~= nil and theThing@p_oName ~= "" then
			code := code + "SetIt(CreateThing(" + w3 +
			    "));AddTail(" +
			    if w == "clonehere" then "Here()" else w2 fi +
			    "@p_rContents,It());" +
			    "SetThingStatus(It(),ts_public);" +
			    "GiveThing(It(),Character(\"SysAdmin\"));" +
			    "It()@p_oCarryer:=Me();" +
			    "It()@p_oCreator:=Me();";
			roomToObject(kind);
		    else
			notObject(w3);
			ending := true;
		    fi;
		fi;
	    elif w == "destruct" and
		(kind = ck_objectChecker or kind = ck_objectDesc or
		 kind = ck_objectVoid)
	    then
		code := code + "ClearThing(It());" +
		    "DelElement(Me()@p_pCarrying,It());";
	    elif w == "drop" and
		(kind = ck_objectChecker or kind = ck_objectDesc or
		 kind = ck_objectVoid)
	    then
		code := code + "ignore DoDrop(Here(),Me(),It());";
	    elif w == "dropto" and
		(kind = ck_objectChecker or kind = ck_objectDesc or
		 kind = ck_objectVoid)
	    then
		w := GetWord();
		if w = "" then
		    error("Missing room-symbol");
		    ending := true;
		else
		    theRoom := LookupThing(nil, w);
		    if theRoom ~= nil and theRoom@p_rName ~= "" then
			code := code + "ignore DoDrop(" + w + ",Me(),It());";
		    else
			notRoom(w);
			ending := true;
		    fi;
		fi;
	    elif w == "setit" then
		w := GetWord();
		if w = "" then
		    error("Missing object kind");
		    ending := true;
		else
		    w2 := GetWord();
		    if w2 = "" then
			error("Missing object-symbol/flag-symbol/string");
			ending := true;
		    else
			if w == "specific" then
			    theThing := LookupThing(nil, w2);
			    if theThing ~= nil and theThing@p_oName ~= "" then
				code := code + "SetIt(" + w2 + ");";
			    else
				notObject(w2);
				ending := true;
			    fi;
			elif checkWord(w, "child", "", kind) then
			    theThing := LookupThing(nil, w2);
			    if theThing ~= nil and theThing@p_oName ~= "" then
				which := pickWhich(w, "child", "");
				code := code + "ignore FindChildOnList(" +
				    doWhich(which) + "@" + doWhich2(which) +
				    "," + w2 + ");SetIt(FindResult());";
			    else
				notObject(w2);
				ending := true;
			    fi;
			elif checkWord(w, "flag", "", kind) then
			    theFlag := LookupFlag(nil, w2);
			    if theFlag ~= nil then
				which := pickWhich(w, "flag", "");
				code := code + "ignore FindFlagOnList(" +
				    doWhich(which) + "@" + doWhich2(which) +
				    "," + w2 + ");SetIt(FindResult());";
			    else
				notFlag(w);
				ending := true;
			    fi;
			elif checkWord(w, "name", "", kind) then
			    which := pickWhich(w, "name", "");
			    code := code + "ignore FindName(" +
				doWhich(which) + "@" + doWhich2(which) +
				",p_oName,\"" + Strip(w2) +
				"\");SetIt(FindResult());";
			else
			    stringError(w, "is not a known object kind");
			    ending := true;
			fi;
			roomToObject(kind);
		    fi;
		fi;
	    elif w == "saycharacter" then
		code := code + "Print(\"";
		state := state + STRING_FIRST;
		Print("Enter the text to be shown to the character:\n");
		ignore SetPrompt("* character text> ");
	    elif w == "sayothers" then
		code := code + "OPrint(\"";
		state := state + STRING_FIRST;
		Print("Enter the text to be shown to others:\n");
		ignore SetPrompt("* others text> ");
	    elif w == "if" then
		if me@p_pSaveState ~= st_noState then
		    error("Sorry, you cannot nest 'if's");
		    ending := true;
		else
		    me@p_pSaveState := state;
		    me@p_pHadCondition := false;
		    state := st_condition2;
		    Print("Enter the condition for the if:\n");
		    ignore SetPrompt("* condition> ");
		fi;
	    else
		stringError(w, "is not a known action");
		ending := true;
	    fi;
	fi;
    fi;
    if ending then
	me -- p_pActiveCode;
	me -- p_pActiveState;
	me -- p_pSaveState;
	me -- p_pHadCondition;
	me -- p_pCodeKind;
	me -- p_pActiveDir;
	me -- p_pNewName;
	me -- p_pActiveTable;
	GetCheckedEnd();
    else
	me@p_pActiveCode := code;
	me@p_pActiveState := state;
    fi;
corp;

define tp_build1 proc utility getAction(table theTable; string name)bool:
    thing me;

    me := Me();
    me@p_pActiveTable := theTable;
    me@p_pNewName := name;
    me@p_pActiveCode := "";
    me@p_pActiveState := st_preCondition;
    me@p_pHadCondition := false;
    if not me@p_pHidden then
	OPrint(FormatName(me@p_pName) + " starts gesturing arcanely.\n");
    fi;
    if me@p_pCodeKind = ck_roomVoid or me@p_pCodeKind = ck_objectVoid then
	Print("Enter the actions:\n");
	GetCheckedDescription("actions> ", bv_actionLineHandler)
    else
	Print("Enter the pre-condition actions:\n");
	GetCheckedDescription("pre-condition actions> ", bv_actionLineHandler)
    fi
corp;

/*****************************************************************************\
*									      *
*		now the actual building subcommands			      *
*									      *
\*****************************************************************************/

/*****************************************************************************\
*									      *
*		first, some generic building subcommands		      *
*									      *
\*****************************************************************************/

define tp_build1 proc utility checkBuilder()bool:

    /* This check is used in @table, @use and @unuse. The most important
       is in @use, since otherwise a character in the PlayPen could
       "@use t_base", and then write actions which increased his money,
       etc.! */
    if Me()@p_pBuilder then
	true
    else
	Print("Sorry, only true builders can use that command.\n");
	false
    fi
corp;

define tp_build1 proc utility bv_showtable(string tableName)bool:
    table theTable;

    if tableName = "" then
	Print("Use is: @showtable <table>\n");
	false
    else
	theTable := findTable(tableName, true);
	if theTable = nil then
	    false
	else
	    ShowTable(theTable);
	    true
	fi
    fi
corp;

Verb1(g_build, "showtable", 0, bv_showtable).

define tp_build1 proc utility bv_describesymbol()bool:
    string tableName, what;
    table theTable;

    tableName := GetWord();
    what := GetWord();
    if tableName = "" or what = "" or GetWord() ~= "" then
	Print("Use is: @describesymbol <table> <symbol>\n");
	false
    else
	theTable := findTable(tableName, true);
	if theTable = nil then
	    false
	else
	    DescribeSymbol(theTable, Strip(what));
	    true
	fi
    fi
corp;

VerbTail(g_build, "describesymbol", bv_describesymbol).
Synonym(g_build, "describesymbol", "describe").
Synonym(g_build, "describesymbol", "d").

define tp_build1 proc utility bv_deletesymbol()bool:
    string tableName, what;
    table theTable;

    tableName := GetWord();
    what := GetWord();
    if tableName = "" or what = "" or GetWord() ~= "" then
	Print("Use is: @deletesymbol <table> <symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	else
	    ignore DeleteSymbol(theTable, Strip(what));
	    true
	fi
    fi
corp;

VerbTail(g_build, "deletesymbol", bv_deletesymbol).
Synonym(g_build, "deletesymbol", "delete").

define tp_build1 proc utility bv_movesymbol()bool:
    string fromTableName, toTableName, what;
    table fromTable, toTable;

    fromTableName := GetWord();
    toTableName := GetWord();
    what := GetWord();
    if fromTableName = "" or toTableName = "" or what = "" or GetWord() ~= ""
    then
	Print("Use is: @movesymbol <from-table> <to-table> <symbol>\n");
	false
    else
	fromTable := findTable(fromTableName, false);
	if fromTable = nil then
	    false
	else
	    toTable := findTable(toTableName, false);
	    if toTable = nil then
		false
	    else
		ignore MoveSymbol(fromTable, toTable, Strip(what));
		true
	    fi
	fi
    fi
corp;

VerbTail(g_build, "movesymbol", bv_movesymbol).
Synonym(g_build, "movesymbol", "move").

define tp_build1 proc utility bv_renamesymbol()bool:
    string tableName, oldName, newName;
    table theTable;

    tableName := GetWord();
    oldName := GetWord();
    newName := GetWord();
    if tableName = "" or oldName = "" or newName = "" or GetWord() ~= "" then
	Print("Use is: @renamesymbol <table> <old-symbol> <new-symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	else
	    RenameSymbol(theTable, Strip(oldName), Strip(newName))
	fi
    fi
corp;

VerbTail(g_build, "renamesymbol", bv_renamesymbol).
Synonym(g_build, "renamesymbol", "rename").

define tp_build1 proc utility bv_flag()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @flag <table> <symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	else
	    DefineFlag(theTable, name, CreateBoolProp())
	fi
    fi
corp;

VerbTail(g_build, "flag", bv_flag).

define tp_build1 proc utility bv_counter()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @counter <table> <symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	else
	    DefineCounter(theTable, name, CreateIntProp())
	fi
    fi
corp;

VerbTail(g_build, "counter", bv_counter).

define tp_build1 proc utility bv_string()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @string <table> <symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	else
	    DefineString(theTable, name, CreateStringProp())
	fi
    fi
corp;

VerbTail(g_build, "string", bv_string).

define tp_build1 proc utility bv_table()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if not checkBuilder() then
	false
    elif tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @table <existing-table-name> <new-table-name>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	else
	    DefineTable(theTable, name, CreateTable())
	fi
    fi
corp;

VerbTail(g_build, "table", bv_table).

define tp_build1 proc utility bv_use(string tableName)bool:
    table theTable;

    if not checkBuilder() then
	false
    elif tableName = "" then
	Print("Use is: @use <table>\n");
	false
    else
	theTable := checkTable(tableName);
	if theTable = nil then
	    false
	else
	    UseTable(theTable)
	fi
    fi
corp;

Verb1(g_build, "use", 0, bv_use).

define tp_build1 proc utility bv_unuse(string tableName)bool:
    table theTable;

    if not checkBuilder() then
	false
    elif tableName = "" then
	Print("Use is: @unuse <table>\n");
	false
    else
	theTable := checkTable(tableName);
	if theTable = nil then
	    false
	else
	    UnUseTable(theTable)
	fi
    fi
corp;

Verb1(g_build, "unuse", 0, bv_unuse).

define tp_build1 proc utility bv_symbolhere()bool:
    string tableName, what;
    table theTable;

    tableName := GetWord();
    what := GetWord();
    if tableName = "" or what = "" or GetWord() ~= "" then
	Print("Use is: @symbolhere <table> <symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	else
	    DefineThing(theTable, what, Here())
	fi
    fi
corp;

VerbTail(g_build, "symbolhere", bv_symbolhere).

define tp_build proc utility bv_poof(string where)bool:
    string err;
    thing room;
    bool privileged;
    action a;

    privileged := Me()@p_pPrivileged;
    err := "Can only POOF between your own rooms.\n";
    if where = "" then
	Print("You must specify where you want to poof to.\n");
	false
    elif not Mine(Here()) and not privileged then
	Print(err);
	false
    else
	room := LookupThing(nil, where);
	if room = nil or room@p_rName = "" then
	    if IsDefined(nil, where) then
		Print("Name '" + where + "' is not a room.\n");
	    else
		Print("Name '" + where + "' is not defined.\n");
	    fi;
	    false
	elif not Mine(room) and not privileged then
	    Print(err);
	    false
	elif room = Here() then
	    Print("That's where you are!\n");
	    false
	else
	    LeaveRoomStuff(room, 0, MOVE_POOF);
	    EnterRoomStuff(room, 0, MOVE_POOF);
	    true
	fi
    fi
corp;

Verb1(g_build, "poof", 0, bv_poof).

/* a couple of utilities */

define tp_build proc utility objNameCheck(string symbol)thing:
    thing th;

    th := LookupThing(nil, symbol);
    if th = nil or th@p_oName = "" then
	if IsDefined(nil, symbol) then
	    Print("'" + symbol + "' is not an object.\n");
	else
	    Print("You have no object named '" + symbol + "'.\n");
	fi;
	nil
    else
	th
    fi
corp;

define tp_build1 proc utility actionNameCheck(string symbol)action:
    action a;

    a := LookupAction(nil, symbol);
    if a = nil then
	if IsDefined(nil, symbol) then
	    Print("'" + symbol + "' is not an action.\n");
	else
	    Print("You have no action named '" + symbol + "'.\n");
	fi;
	nil
    else
	a
    fi
corp;

define tp_build proc utility changeDone(string what)void:

    if Me()@p_pHidden then
	OPrint("Someone has " + what + ".\n");
    else
	OPrint(FormatName(Me()@p_pName) + " has " + what + ".\n");
    fi;
corp;

/*****************************************************************************\
*									      *
*		now some subsubcommands for building rooms		      *
*									      *
\*****************************************************************************/

define tp_build1 g_room CreateGrammar().

define tp_build1 proc utility bv_room()bool:
    thing here;
    string s;

    here := Here();
    s := GetTail();
    if s = "" then
	Print("Missing room command - "
	      "see builder's library for details.\n");
	false
    elif not Mine(here) and (GetThingStatus(here) = ts_readonly or
	GetThingStatus(here) = ts_wizard and not IsWizard()) and
	MeCharacter() ~= SysAdmin
    then
	Print("The owner of this room has not permitted it.\n");
	false
    else
	Parse(g_room, s) ~= 0
    fi
corp;

VerbTail(g_build, "r", bv_room).
Synonym(g_build, "r", "room").

define tp_build proc utility doCreateRoom(int dir, kind; string s)void:
    thing room;

    room := CreateThing(
	case kind
	incase 0:
	    r_indoors
	incase 1:
	    r_outdoors
	incase 2:
	    r_forest
	incase 3:
	    r_field
	incase 4:
	    r_path
	incase 5:
	    r_road
	incase 6:
	    r_sidewalk
	incase 7:
	    r_park
	incase 8:
	    r_tunnel
	default:
	    nil
	esac);
    room@p_rName := s;
    room@p_rContents := CreateThingList();
    SetThingStatus(room, ts_readonly);
    Connect(Here(), room, dir);
    if Here()@p_rPlayPen then
	room@p_rPlayPen := true;
    fi;
    Print("New room created and linked.\n");
    changeDone("created a new room");
corp;

define tp_build1 proc utility brv_new()bool:
    string s, error;
    int dir, kind;

    error := "Use is: @room new <dir> <kind> <room-name>\n";
    s := GetWord();
    if s = "" then
	Print(error);
	false
    else
	dir := DirMatch(s);
	if dir = -1 then
	    Print(error);
	    false
	else
	    s := GetWord();
	    kind := MatchName("indoors.outdoors.forest.field.path.road."
			      "sidewalk.park.tunnel", s);
	    if kind = -1 then
		Print("Unknown room kind. Known kinds are: indoors, outdoors, "
		    "forest, field, path, road, sidewalk, park, tunnel\n");
		false
	    else
		s := Strip(GetTail());
		if s = "" then
		    Print(error);
		    false
		elif Here()@(DirProp(dir)) ~= nil then
		    Print("That direction is already in use.\n");
		    false
		else
		    doCreateRoom(dir, kind, s);
		    true
		fi
	    fi
	fi
    fi
corp;

VerbTail(g_room, "new", brv_new).

define tp_build1 proc utility brv_newname()bool:
    string name;

    name := GetTail();
    if name = "" then
	Print("Use is: @room newname <room-name>\n");
	false
    else
	Here()@p_rName := name;
	Print("Room renamed.\n");
	changeDone("renamed this room");
	true
    fi
corp;

VerbTail(g_room, "newname", brv_newname).

define tp_build1 proc utility brv_hide(string dirName)bool:
    int dir;
    list int exits;

    dir := DirMatch(dirName);
    if dir = -1 then
	Print("Use is: @room hide <dir>\n");
	false
    else
	exits := Here()@p_rExits;
	if Here()@(DirProp(dir)) = nil then
	    Print("That direction is not in use.\n");
	    false
	else
	    if FindElement(exits, dir) = -1 then
		AddTail(exits, dir);
		Print("Link unhidden.\n");
	    else
		DelElement(exits, dir);
		Print("Link hidden.\n");
	    fi;
	    true
	fi
    fi
corp;

Verb1(g_room, "hide", 0, brv_hide).

define tp_build1 proc utility brv_same()bool:
    thing here;
    string error, s;
    int dirOld, dirNew;

    here := Here();
    error := "Use is: @room same <old-dir> <new-dir>\n";
    s := GetWord();
    if s = "" then
	Print(error);
	false
    else
	dirOld := DirMatch(s);
	if dirOld = -1 then
	    Print(error);
	    false
	elif here@(DirProp(dirOld)) = nil then
	    Print("That old direction does not go anywhere.\n");
	    false
	else
	    s := GetWord();
	    if s = "" or GetWord() ~= "" then
		Print(error);
		false
	    else
		dirNew := DirMatch(s);
		if dirNew = -1 then
		    Print(error);
		    false
		elif here@(DirProp(dirNew)) ~= nil then
		    Print("That new direction is already in use.\n");
		    false
		else
		    UniConnect(here, here@(DirProp(dirOld)), dirNew);
		    Print("Link made.\n");
		    changeDone("made a new link");
		    true
		fi
	    fi
	fi
    fi
corp;

VerbTail(g_room, "same", brv_same).

define tp_build1 proc utility brv_scenery()bool:
    string s;
    bool hadOne;

    hadOne := false;
    while
	s := GetWord();
	s ~= ""
    do
	hadOne := true;
	Scenery(Here(), s);
    od;
    if hadOne then
	Print("New scenery words added.\n");
	true
    else
	Print("Use is: @room scenery <word> ... <word>\n");
	false
    fi
corp;

VerbTail(g_room, "scenery", brv_scenery).

define tp_build1 proc utility brv_endNewdesc(string s)void:
    thing here;

    here := Here();
    if Me()@p_pBuilder or here@p_rPlayPen then
	s := Trim(s);
	if s = "" then
	    here -- p_rDesc;
	    Print("Room description deleted.\n");
	else
	    here@p_rDesc := s;
	    Print("Room decorated.\n");
	fi;
	changeDone("decorated this room");
    else
	Print("Description change cancelled.\n");
    fi;
corp;

define tp_build proc utility brv_newdesc()bool:

    GetDocument("new room desc> ", "Enter room description", Here()@p_rDesc,
	brv_endNewdesc, false)
corp;

Verb0(g_room, "newdesc", 0, brv_newdesc).

define tp_build1 proc utility brv_endAdddesc1(string s)void:

    if Me()@p_pBuilder or Here()@p_rPlayPen then
	s := Trim(s);
	if s = "" then
	    Print("Room description not changed.\n");
	else
	    Here()@p_rDesc := s;
	    Print("Room redecorated.\n");
	    changeDone("redecorated this room");
	fi;
    else
	Print("Description change cancelled.\n");
    fi;
corp;

define tp_build1 proc utility brv_endAdddesc2(string s)void:

    if Me()@p_pBuilder or Here()@p_rPlayPen then
	s := Trim(s);
	if s = "" then
	    Print("Room description not changed.\n");
	else
	    ExtendDesc(Here(), s);
	    Print("Room redecorated.\n");
	    changeDone("redecorated this room");
	fi;
    else
	Print("Description change cancelled.\n");
    fi;
corp;

define tp_build1 proc utility brv_adddesc()bool:

    if CanEdit() then
	GetDocument("add room desc> ", "Edit room description", Here()@p_rDesc,
	    brv_endAdddesc1, false)
    else
	GetDocument("add room desc> ", "Edit room description", "",
	    brv_endAdddesc2, false)
    fi
corp;

Verb0(g_room, "adddesc", 0, brv_adddesc).

define tp_build1 proc utility brv_setdescaction(string name)bool:
    action a;

    if name = "" then
	Print("Use is: @room setdescaction <action-symbol>\n");
	false
    else
	if name == "nil" then
	    Here() -- p_rDescAction;
	    Print("Descaction removed.\n");
	    changeDone("altered something here");
	    true
	else
	    a := actionNameCheck(name);
	    if a = nil then
		false
	    else
		Here()@p_rDescAction := a;
		Print("Descaction set.\n");
		changeDone("altered something here");
		true
	    fi
	fi
    fi
corp;

Verb1(g_room, "setdescaction", 0, brv_setdescaction).

define tp_build1 proc utility brv_addspecialaction()bool:
    string name, command;
    action a;

    name := GetWord();
    command := GetWord();
    if name = "" or command = "" or GetWord() ~= "" then
	Print("Use is: @room addspecialaction <action-symbol> <verb-form>\n");
	false
    else
	a := actionNameCheck(name);
	if a = nil then
	    false
	else
	    AddSpecialCommand(Here(), command, a);
	    Print("Special command set.\n");
	    changeDone("altered something here");
	    true
	fi
    fi
corp;

VerbTail(g_room, "addspecialaction", brv_addspecialaction).

define tp_build1 proc utility brv_subspecialaction()bool:
    string name, command;
    action a;

    name := GetWord();
    command := GetWord();
    if name = "" or command = "" or GetWord() ~= "" then
	Print("Use is: @room subspecialaction <action-symbol> <verb-form>\n");
	false
    else
	a := actionNameCheck(name);
	if a = nil then
	    false
	else
	    if RemoveSpecialCommand(Here(), command, a) then
		Print("Special command set.\n");
		changeDone("altered something here");
		true
	    else
		Print("That special command is not set here.\n");
		false
	    fi
	fi
    fi
corp;

VerbTail(g_room, "subspecialaction", brv_subspecialaction).

define tp_build proc utility doMakeLink(string s; int dir)bool:
    thing there;

    there := LookupThing(nil, s);
    if there = nil then
	if IsDefined(nil, s) then
	    Print("Name '" + s + "' is not a room.\n");
	else
	    Print("Name '" + s + "' is not defined.\n");
	fi;
	false
    elif there@p_rName = "" and there@p_rNameAction = nil then
	Print("Name '" + s + "' is not a room.\n");
	false
    elif Here()@p_rPlayPen and not there@p_rPlayPen then
	Print("Cannot link to non-playpen rooms from playpen rooms\n");
	false
    elif not Mine(there) and (GetThingStatus(there) = ts_readonly or
	GetThingStatus(there) = ts_wizard and not IsWizard()) and
	MeCharacter() ~= SysAdmin
    then
	Print("The owner of that room has not permitted it.\n");
	false
    else
	UniConnect(Here(), there, dir);
	Print("Link made.\n");
	changeDone("made a new link");
	true
    fi
corp;

define tp_build1 proc utility brv_linkto()bool:
    thing here;
    string error, s;
    int dir;

    error := "Use is: @room linkto <dir> <room-symbol>\n";
    here := Here();
    s := GetWord();
    if s = "" then
	Print(error);
	false
    else
	dir := DirMatch(s);
	if dir = -1 then
	    Print(error);
	    false
	elif here@(DirProp(dir)) ~= nil then
	    Print("That direction is already in use.\n");
	    false
	else
	    s := GetWord();
	    if s = "" or GetWord() ~= "" then
		Print(error);
		false
	    else
		doMakeLink(s, dir)
	    fi
	fi
    fi
corp;

VerbTail(g_room, "linkto", brv_linkto).

define tp_build proc utility brv_unlink(string dirName)bool:
    int dir;
    list int exits;

    dir := DirMatch(dirName);
    if dir = -1 then
	Print("Use is: @room unlink <dir>\n");
	false
    elif Here()@(DirProp(dir)) = nil then
	Print("There is no link in that direction from here.\n");
	false
    elif dir = D_NORTH and Here() = r_playPen then
	Print("Only a wizard or apprentice can remove the Playpen's exit.\n");
	false
    else
	Here() -- DirProp(dir);
	exits := Here()@p_rExits;
	if exits ~= nil then
	    DelElement(exits, dir);
	fi;
	Print("Connection removed.\n");
	changeDone("removed a link");
	true
    fi
corp;

Verb1(g_room, "unlink", 0, brv_unlink).

define tp_build proc utility brv_dark(string s)bool:
    thing here;

    here := Here();
    if not Mine(here) then
	Print("Can only change the lighting in your own rooms.\n");
	false
    else
	if s = "" then
	    s := "y";
	fi;
	if isYes(s) then
	    here@p_rDark := true;
	    Print("This room is now dark.\n");
	    if Me()@p_pHidden then
		OPrint("The light has gone away.\n");
	    else
		OPrint(FormatName(Me()@p_pName) + " has removed the light.\n");
	    fi;
	    true
	elif isNo(s) then
	    here -- p_rDark;
	    Print("This room is now lighted.\n");
	    if Me()@p_pHidden then
		OPrint("Light has appeared\n");
	    else
		OPrint(FormatName(Me()@p_pName) + " has created light.\n");
	    fi;
	    true
	else
	    Print("Use is: @room dark [y|n]\n");
	    false
	fi
    fi
corp;

Verb1(g_room, "dark", 0, brv_dark).

define tp_build proc utility brv_lock(string s)bool:
    thing here;

    here := Here();
    if not Mine(here) then
	Print("Can only lock/unlock your own rooms.\n");
	false
    else
	if s = "" then
	    s := "y";
	fi;
	if isYes(s) then
	    here@p_rLocked := true;
	    Print("This room is now locked from public access.\n");
	    true
	elif isNo(s) then
	    here -- p_rLocked;
	    Print("This room is now available for public access.\n");
	    true
	else
	    Print("Use is: @room lock [y|n]\n");
	    false
	fi
    fi
corp;

Verb1(g_room, "lock", 0, brv_lock).

define tp_build1 proc utility brv_status(string s)bool:
    string error;
    thing here;

    here := Here();
    if not Mine(here) then
	Print("Can only change the status on your own rooms.\n");
	false
    else
	error := "Use is: @room status {readonly|wizard|public}\n";
	if s = "" then
	    Print(error);
	    false
	else
	    if s == "readonly" then
		SetThingStatus(here, ts_readonly);
		Print("This room is now changeable by its owner only.\n");
		true
	    elif s == "wizard" then
		SetThingStatus(here, ts_wizard);
		Print("This room is now changeable by wizards only.\n");
		true
	    elif s == "public" then
		SetThingStatus(here, ts_public);
		Print(
	"This room is now changeable by wizards, apprentices and builders.\n");
		true
	    else
		Print(error);
		false
	    fi
	fi
    fi
corp;

Verb1(g_room, "status", 0, brv_status).

define tp_build1 proc utility brv_endDirDesc(string s)void:
    thing me, here;

    me := Me();
    here := Here();
    if me@p_pBuilder or here@p_rPlayPen then
	s := Trim(s);
	if s = "" then
	    here -- DirDesc(me@p_pActiveDir);
	    Print("Direction description deleted.\n");
	else
	    here@(DirDesc(me@p_pActiveDir)) := s;
	    Print("Direction decorated.\n");
	fi;
	changeDone("done some detailing");
    else
	Print("Direction description change cancelled.\n");
    fi;
    me -- p_pActiveDir;
corp;

define tp_build1 proc utility brv_dirdesc(string where)bool:
    int dir;

    dir := DirMatch(where);
    if dir = -1 then
	Print("Use is: @room dirdesc <dir>\n");
	false
    else
	Me()@p_pActiveDir := dir;
	GetDocument("room dirdesc> ", "Enter direction description", "",
	    brv_endDirDesc, false)
    fi
corp;

Verb1(g_room, "dirdesc", 0, brv_dirdesc).

define tp_build1 proc utility brv_endDirMessage(string s)void:
    thing me, here;

    me := Me();
    here := Here();
    if me@p_pBuilder or here@p_rPlayPen then
	s := Trim(s);
	if s = "" then
	    if me@p_pActiveDir = 100 then
		here -- p_rNoGoString;
		Print("NoGo string deleted.\n");
	    else
		here -- DirMessage(me@p_pActiveDir);
		Print("Direction message deleted.\n");
	    fi;
	else
	    if me@p_pActiveDir = 100 then
		here@p_rNoGoString := s;
		Print("NoGo message entered.\n");
	    else
		here@(DirMessage(me@p_pActiveDir)) := s;
		Print("Direction message entered.\n");
	    fi;
	fi;
	changeDone("done some detailing");
    else
	Print("Message change cancelled.\n");
    fi;
    me -- p_pActiveDir;
corp;

define tp_build1 proc utility brv_dirmessage(string where)bool:
    int dir;

    if where == "nogo" then
	dir := 100;
    else
	dir := DirMatch(where);
    fi;
    if dir = -1 then
	Print("Use is: @room dirmessage <dir>\n");
	false
    else
	Me()@p_pActiveDir := dir;
	GetDocument("room dirmessage> ", "Enter direction message", "",
	    brv_endDirMessage, false)
    fi
corp;

Verb1(g_room, "dirmessage", 0, brv_dirmessage).

define tp_build1 proc utility brv_endDirOMessage(string s)void:
    thing me, here;

    me := Me();
    here := Here();
    if me@p_pBuilder or here@p_rPlayPen then
	s := Trim(s);
	if s = "" then
	    here -- DirOMessage(me@p_pActiveDir);
	    Print("Direction message deleted.\n");
	else
	    here@(DirOMessage(me@p_pActiveDir)) := s;
	    Print("Direction message entered.\n");
	fi;
	changeDone("done some detailing");
    else
	Print("Message change cancelled.\n");
    fi;
    me -- p_pActiveDir;
corp;

define tp_build1 proc utility brv_diromessage(string where)bool:
    int dir;

    dir := DirMatch(where);
    if dir = -1 then
	Print("Use is: @room diromessage <dir>\n");
	false
    else
	Me()@p_pActiveDir := dir;
	GetDocument("room diromessage> ", "Enter entering direction message",
	    "", brv_endDirOMessage, false)
    fi
corp;

Verb1(g_room, "diromessage", 0, brv_diromessage).

define tp_build1 proc utility brv_endDirEMessage(string s)void:
    thing me, here;

    me := Me();
    here := Here();
    if me@p_pBuilder or here@p_rPlayPen then
	s := Trim(s);
	if s = "" then
	    here -- DirEMessage(me@p_pActiveDir);
	    Print("Direction message deleted.\n");
	else
	    here@(DirEMessage(me@p_pActiveDir)) := s;
	    Print("Direction message entered.\n");
	fi;
	changeDone("done some detailing");
    else
	Print("Message change cancelled.\n");
    fi;
    me -- p_pActiveDir;
corp;

define tp_build1 proc utility brv_diremessage(string where)bool:
    int dir;

    dir := DirMatch(where);
    if dir = -1 then
	Print("Use is: @room diremessage <dir>\n");
	false
    else
	Me()@p_pActiveDir := dir;
	GetDocument("room diremessage> ", "Enter exiting direction message","",
	    brv_endDirEMessage, false)
    fi
corp;

Verb1(g_room, "diremessage", 0, brv_diremessage).

define tp_build1 proc utility brv_adddircheck()bool:
    string dirName, name;
    int dir;
    action a;

    dirName := GetWord();
    name := GetWord();
    if dirName == "anyenter" then
	dir := 100;
    elif dirName == "anyexit" then
	dir := 101;
    else
	dir := DirMatch(dirName);
    fi;
    if dir = -1 or name = "" or GetWord() ~= "" then
	Print("Use is: @room adddircheck <dir> <action-symbol>\n");
	false
    else
	a := actionNameCheck(name);
	if a = nil then
	    false
	else
	    if dir = 100 then
		AddAnyEnterChecker(Here(), a, false);
	    elif dir = 101 then
		AddAnyLeaveChecker(Here(), a, false);
	    else
		AddDirChecker(Here(), dir, a, false);
	    fi;
	    Print("Dircheck entered.\n");
	    changeDone("altered something here");
	    true
	fi
    fi
corp;

VerbTail(g_room, "adddircheck", brv_adddircheck).

define tp_build1 proc utility brv_subdircheck()bool:
    string dirName, name;
    int dir;
    action a;

    dirName := GetWord();
    name := GetWord();
    if dirName == "anyenter" then
	dir := 100;
    elif dirName == "anyexit" then
	dir := 101;
    else
	dir := DirMatch(dirName);
    fi;
    if dir = -1 or name = "" or GetWord() ~= "" then
	Print("Use is: @room subdircheck <dir> <action-symbol>\n");
	false
    else
	a := actionNameCheck(name);
	if a = nil then
	    false
	else
	    if dir = 100 then
		DelAnyEnterChecker(Here(), a);
	    elif dir = 101 then
		DelAnyLeaveChecker(Here(), a);
	    else
		DelDirChecker(Here(), dir, a);
	    fi;
	    Print("Dircheck removed.\n");
	    changeDone("altered something here");
	    true
	fi
    fi
corp;

VerbTail(g_room, "subdircheck", brv_subdircheck).

/* need to steal a couple of private definitions */
use tp_base

define tp_build1 proc utility brv_showdirchecks(string dirName)bool:
    list action la;
    action a;
    int count, dir, i;
    string procName;

    if dirName == "anyenter" then
	dir := 100;
    elif dirName == "anyexit" then
	dir := 101;
    else
	dir := DirMatch(dirName);
    fi;
    if dir = -1 then
	Print("Use is: @room showdirchecks <dir>\n");
	false
    else
	if dir = 100 then
	    la := Here()@p_rAnyEnterChecks;
	elif dir = 101 then
	    la := Here()@p_rAnyLeaveChecks;
	else
	    la := Here()@(DirChecks(dir));
	fi;
	if la = nil then
	    Print("There are no checkers for that direction here.\n");
	else
	    count := Count(la);
	    i := 0;
	    while i ~= count do
		Print("Checker ");
		IPrint(i);
		Print(":");
		procName := FindActionSymbol(nil, la[i]);
		if procName ~= "" then
		    Print(" " + procName + "\n");
		else
		    Print("\n");
		    PrintAction(la[i]);
		fi;
		i := i + 1;
	    od;
	fi;
	true
    fi
corp;

unuse tp_base

Verb1(g_room, "showdirchecks", 0, brv_showdirchecks).

define tp_build1 proc utility brv_checker()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @room checker <table> <action-symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	elif IsDefined(theTable, name) then
	    Print("'" + name + "' is already defined.\n");
	    false
	else
	    Me()@p_pCodeKind := ck_roomChecker;
	    getAction(theTable, name)
	fi
    fi
corp;

VerbTail(g_room, "checker", brv_checker).

define tp_build1 proc utility brv_descaction()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @room descaction <table> <action-symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	elif IsDefined(theTable, name) then
	    Print("'" + name + "' is already defined.\n");
	    false
	else
	    Me()@p_pCodeKind := ck_roomDesc;
	    getAction(theTable, name)
	fi
    fi
corp;

VerbTail(g_room, "descaction", brv_descaction).

define tp_build1 proc utility brv_specialaction()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @room specialaction <table> <action-symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	elif IsDefined(theTable, name) then
	    Print("'" + name + "' is already defined.\n");
	    false
	else
	    Me()@p_pCodeKind := ck_roomVoid;
	    getAction(theTable, name)
	fi
    fi
corp;

VerbTail(g_room, "specialaction", brv_specialaction).

define tp_build proc utility brv_makebank()bool:
    thing here;

    here := Here();
    if not Mine(here) then
	Print("Can only make your own rooms into banks.\n");
	false
    elif IsBank(here) then
	if UnmakeBank(here) = succeed then
	    Print("This room is no longer a bank.\n");
	    true
	else
	    Print("Bank cannot be unmade - it has accounts.\n");
	    false
	fi
    else
	MakeBank(here);
	Print("This room is now a bank.\n");
	true
    fi
corp;

Verb0(g_room, "makebank", 0, brv_makebank).

define tp_build proc utility brv_makestore()bool:
    thing here;

    here := Here();
    if not Mine(here) then
	Print("Can only make your own rooms into stores.\n");
	false
    else
	if IsStore(here) then
	    UnmakeStore(here);
	    Print("This room is no longer a store.\n");
	    false
	else
	    MakeStore(here);
	    Print("This room is now a store.\n");
	    true
	fi
    fi
corp;

Verb0(g_room, "makestore", 0, brv_makestore).

define tp_build1 proc utility brv_addforsale()bool:
    string symbol;
    int price;
    thing here, th;

    here := Here();
    if not Mine(here) then
	Print("Can only modify your own stores.\n");
	false
    elif here@p_rBuyAction ~= StoreBuy then
	Print("This room is not a store.\n");
	false
    else
	symbol := GetWord();
	price := StringToPosInt(GetWord());
	if symbol = "" or price <= 0 or GetWord() ~= "" then
	    Print("Use is: @room addforsale <object-symbol> <price>\n");
	    false
	else
	    th := objNameCheck(symbol);
	    if th ~= nil then
		AddObjectForSale(here, th, price, nil);
		Print(FormatName(th@p_oName) + " is now for sale here.\n");
		true
	    else
		false
	    fi
	fi
    fi
corp;

VerbTail(g_room, "addforsale", brv_addforsale).

define tp_build1 proc utility brv_subforsale()bool:
    string symbol;
    thing here, th;

    here := Here();
    if not Mine(here) then
	Print("Can only modify your own stores.\n");
	false
    elif here@p_rBuyAction ~= StoreBuy then
	Print("This room is not a store.\n");
	false
    else
	symbol := GetWord();
	if symbol = "" or GetWord() ~= "" then
	    Print("Use is: @room subforsale <object-symbol>\n");
	    false
	else
	    th := objNameCheck(symbol);
	    if th ~= nil then
		if SubObjectForSale(here, th) then
		    Print(FormatName(th@p_oName) +
			" is no longer for sale here.\n");
		    true
		else
		    Print(FormatName(th@p_oName) + " is not for sale here.\n");
		    false
		fi
	    else
		false
	    fi
	fi
    fi
corp;

VerbTail(g_room, "subforsale", brv_subforsale).

/*****************************************************************************\
*									      *
*		now some subsubcommands for building objects		      *
*									      *
\*****************************************************************************/

define tp_build1 g_object CreateGrammar().

define tp_build1 proc utility bv_object()bool:
    string s;

    s := GetTail();
    if s = "" then
	Print("Missing object command - "
	      "see builder's library for details.\n");
	true
    else
	Parse(g_object, s) ~= 0
    fi
corp;

VerbTail(g_build, "o", bv_object).
Synonym(g_build, "o", "object").

define tp_build proc utility createNewObject(string name; table theTable;
	string symbol)bool:
    thing me, th;

    me := Me();
    if Count(me@p_pCarrying) >= MAX_CARRY then
	Print("You can't carry anything else.\n");
	false
    else
	th := CreateThing(nil);
	th@p_oName := name;
	th@p_oHome := Here();
	th@p_oCarryer := me;
	th@p_oCreator := me;
	if Here()@p_rPlayPen then
	    th@p_rPlayPen := true;
	fi;
	SetThingStatus(th, ts_public);
	GiveThing(th, SysAdmin);
	AddTail(me@p_pCarrying, th);
	if DefineThing(theTable, symbol, th) then
	    Print("Object created - you are carrying it.\n");
	    changeDone("created something");
	fi;
	true
    fi
corp;

define tp_build1 proc utility bov_new()bool:
    string tableName, symbol, name;
    table theTable;
    thing me, th;

    tableName := GetWord();
    symbol := GetWord();
    name := GetWord();
    if tableName = "" or symbol = "" or name = "" or GetWord() ~= "" then
	Print(
       "Use is: @object new <table> <object-symbol> \"noun[;adj,...,adj]\"\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	elif IsDefined(theTable, symbol) then
	    Print("'" + symbol + "' is already defined.\n");
	    false
	else
	    createNewObject(name, theTable, symbol)
	fi
    fi
corp;

VerbTail(g_object, "new", bov_new).

define tp_build1 proc utility bov_newname()bool:
    string symbol, newName;
    thing th;

    symbol := GetWord();
    newName := GetWord();
    if symbol = "" or newName = "" or GetWord() ~= "" then
	Print(
	   "Use is: @object newname <object-symbol> \"noun[;adj,...,adj]\"\n");
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    th@p_oName := newName;
	    Print("Your object '" + symbol + "' will now be seen as '" +
		  FormatName(newName) + "'.\n");
	    true
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "newname", bov_newname).
Synonym(g_object, "newname", "name").

define tp_build1 proc utility bov_endNewdesc(string s)void:
    thing me;

    me := Me();
    s := Trim(s);
    if s = "" then
	me@p_pActiveThing -- p_oDesc;
	Print("Object description deleted.\n");
    else
	me@p_pActiveThing@p_oDesc := s;
	Print("Object description entered.\n");
    fi;
    me -- p_pActiveThing;
corp;

define tp_build proc utility doObjectDesc(thing th)bool:

    Me()@p_pActiveThing := th;
    GetDocument("new object desc> ", "Enter new description",
	th@p_oDesc, bov_endNewdesc, false)
corp;

define tp_build1 proc utility bov_newdesc(string symbol)bool:
    thing th;

    if symbol = "" then
	Print("Use is: @object newdesc <object-symbol>\n");
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    doObjectDesc(th)
	else
	    false
	fi
    fi
corp;

Verb1(g_object, "newdesc", 0, bov_newdesc).
Synonym(g_object, "newdesc", "desc").

define tp_build1 proc utility bov_endReadstring(string s)void:
    thing me;

    me := Me();
    s := Trim(s);
    if s = "" then
	me@p_pActiveThing -- p_oReadString;
	Print("Object readstring deleted.\n");
    else
	me@p_pActiveThing@p_oReadString := s;
	Print("Object readstring entered.\n");
    fi;
    me -- p_pActiveThing;
corp;

define tp_build proc utility doObjectRead(thing th)bool:

    Me()@p_pActiveThing := th;
    GetDocument("new object readstring> ", "Enter new readstring",
	th@p_oReadString, bov_endReadstring, false)
corp;

define tp_build1 proc utility bov_readstring(string symbol)bool:
    thing th;

    if symbol = "" then
	Print("Use is: @object readstring <object-symbol>\n");
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    doObjectRead(th)
	else
	    false
	fi
    fi
corp;

Verb1(g_object, "readstring", 0, bov_readstring).

define tp_build1 proc utility bov_setdescaction()bool:
    string thingName, name;
    thing th;
    action a;

    thingName := GetWord();
    name := GetWord();
    if thingName = "" or name = "" or GetWord() ~= "" then
	Print(
	    "Use is: @object setdescaction <object-symbol> <action-symbol>\n");
	false
    else
	th := objNameCheck(thingName);
	if th ~= nil then
	    if name == "nil" then
		th -- p_oDescAction;
		Print("Descaction removed.\n");
		true
	    else
		a := actionNameCheck(name);
		if a = nil then
		    false
		else
		    th@p_oDescAction := a;
		    Print("Descaction set.\n");
		    true
		fi
	    fi
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "setdescaction", bov_setdescaction).

define tp_build1 proc utility bov_setreadaction()bool:
    string thingName, name;
    thing th;
    action a;

    thingName := GetWord();
    name := GetWord();
    if thingName = "" or name = "" or GetWord() ~= "" then
	Print(
	    "Use is: @object setreadaction <object-symbol> <action-symbol>\n");
	false
    else
	th := objNameCheck(thingName);
	if th ~= nil then
	    if name == "nil" then
		th -- p_oReadAction;
		Print("Readaction removed.\n");
		true
	    else
		a := actionNameCheck(name);
		if a = nil then
		    false
		else
		    th@p_oReadAction := a;
		    Print("Readaction set.\n");
		    true
		fi
	    fi
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "setreadaction", bov_setreadaction).

define tp_build1 proc utility bov_setactword()bool:
    string symbol, word;
    thing th;

    symbol := GetWord();
    word := GetWord();
    if symbol = "" or word = "" or GetWord() ~= "" then
	Print(
	  "Use is: @object setactword <object-symbol> \"word,synonym,...\"\n");
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    th@p_oActWord := word;
	    Print("Your object '" + symbol + AAn("' will now have", word) +
		  " action.\n");
	    true
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "setactword", bov_setactword).

define tp_build1 proc utility bov_endSetActString(string s)void:
    thing me;

    me := Me();
    s := Trim(s);
    if s = "" then
	me@ p_pActiveThing -- p_oActString;
	Print("Object actstring deleted.\n");
    else
	me@p_pActiveThing@p_oActString := s;
	Print("Object actstring entered.\n");
    fi;
    me -- p_pActiveThing;
corp;

define tp_build proc enterActString(thing th)bool:

    Me()@p_pActiveThing := th;
    GetDocument("action string> ", "Enter action string",
	th@p_oActString, bov_endSetActString, false)
corp;

define tp_build1 proc utility bov_setactstring(string symbol)bool:
    thing th;

    if symbol = "" then
	Print("Use is: @object setactstring <object-symbol>\n");
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    enterActString(th)
	else
	    false
	fi
    fi
corp;

Verb1(g_object, "setactstring", 0, bov_setactstring).

define tp_build1 proc utility bov_setactaction()bool:
    string thingName, name;
    thing th;
    action a;

    thingName := GetWord();
    name := GetWord();
    if thingName = "" or name = "" or GetWord() ~= "" then
	Print(
	    "Use is: @object setactaction <object-symbol> <action-symbol>\n");
	false
    else
	th := objNameCheck(thingName);
	if th ~= nil then
	    if name == "nil" then
		th -- p_oActAction;
		Print("Actaction removed.\n");
		true
	    else
		a := actionNameCheck(name);
		if a = nil then
		    false
		else
		    th@p_oActAction := a;
		    Print("Actaction set.\n");
		    true
		fi
	    fi
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "setactaction", bov_setactaction).

define tp_build1 proc utility bov_gettable()bool:
    string errorMessage, symbol, yesNo;
    thing th;

    errorMessage := "Use is: @object gettable <object-symbol> [yes|no]\n";
    symbol := GetWord();
    if symbol = "" then
	Print(errorMessage);
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    yesNo := GetWord();
	    if yesNo = "" then
		yesNo := "y";
	    fi;
	    if GetWord() ~= "" then
		Print(errorMessage);
		false
	    else
		if isYes(yesNo) then
		    th -- p_oNotGettable;
		    Print(symbol + " marked as gettable.\n");
		    true
		elif isNo(yesNo) then
		    th@p_oNotGettable := true;
		    Print(symbol + " marked as not gettable.\n");
		    true
		else
		    Print(errorMessage);
		    false
		fi
	    fi
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "gettable", bov_gettable).

define tp_build1 proc utility bov_islight()bool:
    string errorMessage, symbol, yesNo;
    thing th;

    errorMessage := "Use is: @object islight <object-symbol> [yes|no]\n";
    symbol := GetWord();
    if symbol = "" then
	Print(errorMessage);
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    yesNo := GetWord();
	    if yesNo = "" then
		yesNo := "y";
	    fi;
	    if GetWord() ~= "" then
		Print(errorMessage);
		false
	    else
		if isYes(yesNo) then
		    th@p_oLight := true;
		    Print(symbol + " marked as emitting light.\n");
		    true
		elif isNo(yesNo) then
		    th -- p_oLight;
		    Print(symbol + " marked as not emitting light.\n");
		    true
		else
		    Print(errorMessage);
		    false
		fi
	    fi
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "islight", bov_islight).
Synonym(g_object, "islight", "light").

define tp_build1 proc utility bov_invisible()bool:
    string errorMessage, symbol, yesNo;
    thing th;

    errorMessage := "Use is: @object invisible <object-symbol> [yes|no]\n";
    symbol := GetWord();
    if symbol = "" then
	Print(errorMessage);
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    yesNo := GetWord();
	    if yesNo = "" then
		yesNo := "y";
	    fi;
	    if GetWord() ~= "" then
		Print(errorMessage);
		false
	    else
		if isYes(yesNo) then
		    th@p_oInvisible := true;
		    Print(symbol + " marked as invisible.\n");
		    true
		elif isNo(yesNo) then
		    th -- p_oInvisible;
		    Print(symbol + " marked as not invisible.\n");
		    true
		else
		    Print(errorMessage);
		    false
		fi
	    fi
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "invisible", bov_invisible).

define tp_build1 proc utility bov_container()bool:
    string symbol, count;
    thing th;
    int n;

    symbol := GetWord();
    count := GetWord();
    n := StringToPosInt(count);
    if symbol = "" or n < 0 or GetWord() ~= "" then
	Print("Use is @object container <object-symbol> <count>\n");
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    if n = 0 then
		th -- p_oContents;
		th -- p_oCapacity;
		Print(symbol + " marked as no longer a container.\n");
	    else
		th@p_oContents := CreateThingList();
		th@p_oCapacity := n;
		Print(symbol + " marked with capacity " + IntToString(n) +
		    ".\n");
	    fi;
	    true
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "container", bov_container).

define tp_build1 proc utility bov_position()bool:
    thing me, th;
    string name, count, verb;
    int n, which;

    name := GetWord();
    count := GetWord();
    verb := Verb();
    n := StringToPosInt(count);
    if name = "" or n < 0 or GetWord() ~= "" then
	Print("Use is @object " + verb + " <object-symbol> <count>\n");
	false
    else
	th := objNameCheck(name);
	if th ~= nil then
	    which := MatchName("sitin.siton.liein.lieon", verb);
	    if n = 0 then
		Print("No-one can now '" + verb + "' '" + name + "'\n");
		case which
		incase 0:
		    th -- p_oCanSitIn;
		incase 1:
		    th -- p_oCanSitOn;
		incase 2:
		    th -- p_oCanLieIn;
		incase 3:
		    th -- p_oCanLieOn;
		esac;
	    else
		Print(IntToString(n) + " can now '" + verb + "' '" + name +
		    "'\n");
		n := n + 1;
		case which
		incase 0:
		    th@p_oCanSitIn := n;
		incase 1:
		    th@p_oCanSitOn := n;
		incase 2:
		    th@p_oCanLieIn := n;
		incase 3:
		    th@p_oCanLieOn := n;
		esac;
	    fi;
	    true
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "sitin", bov_position).
VerbTail(g_object, "siton", bov_position).
VerbTail(g_object, "liein", bov_position).
VerbTail(g_object, "lieon", bov_position).

/* this is NOT utility, so that we are SysAdmin and can do the ClearThing */

define tp_build1 proc localZapObject(thing th)void:
    ClearThing(th);
corp;

define tp_build1 proc utility bov_destroy()bool:
    string tableName, symbol;
    table tb;
    thing me, th;

    tableName := GetWord();
    symbol := GetWord();
    if tableName = "" or symbol = "" or GetWord() ~= "" then
	Print("Use is: @object destroy <table> <object-symbol>\n");
	false
    else
	tb := findTable(tableName, true);
	if tb = nil then
	    false
	else
	    th := objNameCheck(symbol);
	    if th ~= nil then
		me := Me();
		if FindElement(me@p_pCarrying, th) < 0 then
		    Print("You are not carrying '" + symbol + "'.\n");
		    false
		elif th@p_oContents ~= nil and Count(th@p_oContents) ~= 0 then
		    Print("The " + symbol + " is not empty.\n");
		    false
		else
		    localZapObject(th);
		    if DeleteSymbol(tb, symbol) then
			DelElement(me@p_pCarrying, th);
			Print("It should now be gone!\n");
			changeDone("destroyed something");
			true
		    else
			false
		    fi
		fi
	    else
		false
	    fi
	fi
    fi
corp;

VerbTail(g_object, "destroy", bov_destroy).

define tp_build1 proc utility bov_checker()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @object checker <table> <action-symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	elif IsDefined(theTable, name) then
	    Print("'" + name + "' is already defined.\n");
	    false
	else
	    Me()@p_pCodeKind := ck_objectChecker;
	    getAction(theTable, name)
	fi
    fi
corp;

VerbTail(g_object, "checker", bov_checker).

define tp_build1 proc utility bov_descaction()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @object descaction <table> <action-symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	elif IsDefined(theTable, name) then
	    Print("'" + name + "' is already defined.\n");
	    false
	else
	    Me()@p_pCodeKind := ck_objectDesc;
	    getAction(theTable, name)
	fi
    fi
corp;

VerbTail(g_object, "descaction", bov_descaction).
Synonym(g_object, "descaction", "readaction").

define tp_build1 proc utility bov_actaction()bool:
    string tableName, name;
    table theTable;

    tableName := GetWord();
    name := GetWord();
    if tableName = "" or name = "" or GetWord() ~= "" then
	Print("Use is: @object actaction <table> <action-symbol>\n");
	false
    else
	theTable := findTable(tableName, false);
	if theTable = nil then
	    false
	elif IsDefined(theTable, name) then
	    Print("'" + name + "' is already defined.\n");
	    false
	else
	    Me()@p_pCodeKind := ck_objectVoid;
	    getAction(theTable, name)
	fi
    fi
corp;

VerbTail(g_object, "actaction", bov_actaction).

define tp_build1 proc utility bov_endVerbString(string s)void:
    thing me;
    string verb;
    property string theProp;

    me := Me();
    verb := me@p_pActiveVerb;
    theProp := GetVerbStringProp(verb);
    if theProp = nil then
	Print("Oh-oh! bov_endVerbString can't find prop!\n");
    else
	s := Trim(s);
	if s = "" then
	    me@p_pActiveThing -- GetVerbStringProp(verb);
	    Print("Object " + verb + " string deleted.\n");
	else
	    me@p_pActiveThing@(GetVerbStringProp(verb)) := s;
	    Print("Object " + verb + " string entered.\n");
	fi;
    fi;
    me -- p_pActiveThing;
    me -- p_pActiveVerb;
corp;

define tp_build proc utility doSetVerbString(string verb; thing th)bool:

    Me()@p_pActiveVerb := verb;
    Me()@p_pActiveThing := th;
    GetDocument(verb + " string> ", "Enter " + verb + " string",
	th@(GetVerbStringProp(verb)), bov_endVerbString, false)
corp;

define tp_build1 proc utility bov_verbstring(string symbol)bool:
    string verb;
    thing th;

    verb := Verb();
    if symbol = "" then
	Print("Use is: @object " + verb + " <object-symbol>\n");
	false
    else
	th := objNameCheck(symbol);
	if th ~= nil then
	    verb := SubString(verb, 0, Length(verb) - 6);
	    doSetVerbString(verb, th)
	else
	    false
	fi
    fi
corp;

Verb1(g_object, "playstring", 0, bov_verbstring).
Verb1(g_object, "erasestring", 0, bov_verbstring).
Verb1(g_object, "eatstring", 0, bov_verbstring).
Verb1(g_object, "usestring", 0, bov_verbstring).
Verb1(g_object, "activatestring", 0, bov_verbstring).
Verb1(g_object, "deactivatestring", 0, bov_verbstring).
Synonym(g_object, "deactivatestring", "inactivatestring").
Verb1(g_object, "lightstring", 0, bov_verbstring).
Verb1(g_object, "extinguishstring", 0, bov_verbstring).
Verb1(g_object, "wearstring", 0, bov_verbstring).
Verb1(g_object, "touchstring", 0, bov_verbstring).
Verb1(g_object, "smellstring", 0, bov_verbstring).
Verb1(g_object, "listenstring", 0, bov_verbstring).
Verb1(g_object, "openstring", 0, bov_verbstring).
Verb1(g_object, "closestring", 0, bov_verbstring).
Verb1(g_object, "pushstring", 0, bov_verbstring).
Verb1(g_object, "pullstring", 0, bov_verbstring).
Verb1(g_object, "turnstring", 0, bov_verbstring).
Verb1(g_object, "liftstring", 0, bov_verbstring).
Verb1(g_object, "lowerstring", 0, bov_verbstring).
Verb1(g_object, "getstring", 0, bov_verbstring).
Verb1(g_object, "unlockstring", 0, bov_verbstring).

define tp_build1 proc utility bov_verbchecker()bool:
    string verb, objectName, actionName;
    property action theProp;
    action a;
    thing th;

    verb := Verb();
    objectName := GetWord();
    actionName := GetWord();
    if objectName = "" or actionName = "" or GetWord() ~= "" then
	Print(
	    "Use is: @object " + verb + " <object-symbol> <action-symbol>\n");
	false
    else
	th := objNameCheck(objectName);
	if th ~= nil then
	    verb := SubString(verb, 0, Length(verb) - 7);
	    theProp := GetVerbCheckerProp(verb);
	    if theProp = nil then
		Print("Oh-oh! bov_verbchecker can't find prop!\n");
		false
	    else
		if actionName == "nil" then
		    th -- theProp;
		    Print(Capitalize(verb) + "action removed.\n");
		    true
		else
		    a := actionNameCheck(actionName);
		    if a = nil then
			false
		    else
			th@theProp := a;
			Print(Capitalize(verb) + "action set.\n");
			true
		    fi
		fi
	    fi
	else
	    false
	fi
    fi
corp;

VerbTail(g_object, "playchecker", bov_verbchecker).
VerbTail(g_object, "erasechecker", bov_verbchecker).
VerbTail(g_object, "eatchecker", bov_verbchecker).
VerbTail(g_object, "usechecker", bov_verbchecker).
VerbTail(g_object, "activatechecker", bov_verbchecker).
VerbTail(g_object, "inactivatechecker", bov_verbchecker).
Synonym(g_object, "inactivatechecker", "deactivatechecker").
VerbTail(g_object, "lightchecker", bov_verbchecker).
VerbTail(g_object, "extinguishchecker", bov_verbchecker).
VerbTail(g_object, "wearchecker", bov_verbchecker).
VerbTail(g_object, "touchchecker", bov_verbchecker).
VerbTail(g_object, "smellchecker", bov_verbchecker).
VerbTail(g_object, "listenchecker", bov_verbchecker).
VerbTail(g_object, "openchecker", bov_verbchecker).
VerbTail(g_object, "closechecker", bov_verbchecker).
VerbTail(g_object, "pushchecker", bov_verbchecker).
VerbTail(g_object, "pullchecker", bov_verbchecker).
VerbTail(g_object, "turnchecker", bov_verbchecker).
VerbTail(g_object, "liftchecker", bov_verbchecker).
VerbTail(g_object, "lowerchecker", bov_verbchecker).

unuse tp_build1
