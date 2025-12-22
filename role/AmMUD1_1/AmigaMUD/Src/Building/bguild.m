/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray
 */

/*
 * bguild.m - set up the builder's guild.
 */

private tp_bguild CreateTable()$
use tp_bguild

use t_streets

define tp_bguild BGUILD_ID NextEffectId()$

define tp_bguild proc drawGuild()void:

    if not KnowsEffect(nil, BGUILD_ID) then
	DefineEffect(nil, BGUILD_ID);
	GSetImage(nil, "Town/bguild");
	IfFound(nil);
	    ShowCurrentImage();
	Else(nil);
	    GSetPen(nil, C_TAN);
	    GAMove(nil, 0.386, 0.26);
	    GADraw(nil, 0.386, 0.16);
	    GADraw(nil, 0.448, 0.16);
	    GADraw(nil, 0.448, 0.26);
	    GAMove(nil, 0.0, 0.26);
	    GADraw(nil, 0.495, 0.26);
	    GADraw(nil, 0.495, 0.86);
	    GADraw(nil, 0.0, 0.86);
	    GADraw(nil, 0.0, 0.26);
	    GAMove(nil, 0.158, 0.26);
	    GADraw(nil, 0.158, 0.86);
	    GAMove(nil, 0.158, 0.48);
	    GADraw(nil, 0.339, 0.48);
	    GAMove(nil, 0.158, 0.64);
	    GADraw(nil, 0.339, 0.64);
	    GAMove(nil, 0.248, 0.26);
	    GADraw(nil, 0.248, 0.48);
	    GAMove(nil, 0.248, 0.64);
	    GADraw(nil, 0.248, 0.86);
	    GAMove(nil, 0.339, 0.26);
	    GADraw(nil, 0.339, 0.48);
	    GAMove(nil, 0.339, 0.64);
	    GADraw(nil, 0.339, 0.86);
	
	    GSetPen(nil, C_BROWN);
	    GAMove(nil, 0.186, 0.48);
	    HorizontalDoor();
	    GAMove(nil, 0.277, 0.48);
	    HorizontalDoor();
	    GAMove(nil, 0.186, 0.64);
	    HorizontalDoor();
	    GAMove(nil, 0.277, 0.64);
	    HorizontalDoor();
	    GAMove(nil, 0.402, 0.26);
	    HorizontalDoor();
	    GAMove(nil, 0.158, 0.52);
	    VerticalDoor();
	    GAMove(nil, 0.495, 0.52);
	    VerticalDoor();
	    GAMove(nil, 0.283, 0.86);
	    GADraw(nil, 0.3, 0.86);

	    GSetPen(nil, C_GOLD);
	    GAMove(nil, 0.08, 0.56);
	    GRMovePixels(nil, -12, 3);
	    GText(nil, "LIB");
	    GAMove(nil, 0.204, 0.37);
	    GRMovePixels(nil, -4, 3);
	    GText(nil, "A");
	    GAMove(nil, 0.294, 0.37);
	    GRMovePixels(nil, -4, 3);
	    GText(nil, "B");
	    GAMove(nil, 0.204, 0.75);
	    GRMovePixels(nil, -4, 3);
	    GText(nil, "W");
	    GAMove(nil, 0.294, 0.75);
	    GRMovePixels(nil, -4, 3);
	    GText(nil, "M");
	Fi(nil);
	EndEffect();
    fi;
    CallEffect(nil, BGUILD_ID);
corp;

define tp_bguild GUILD_MAP_GROUP NextMapGroup()$

define tp_bguild r_buildEntry CreateThing(r_indoors)$
SetupRoom(r_buildEntry, "in the foyer of the builder's guild",
    "The floor in here is an expensive-looking black and white tile. Potted "
    "plants abound, as do black leather upholstery and brass fixtures. A long "
    "hallway leads off to the west, a small door half-hidden behind a palm "
    "tree leads north, and the doors out to the street are to the east.")$
r_buildEntry@p_rNoMachines := true$
Connect(r_sw2, r_buildEntry, D_WEST)$
Connect(r_sw2, r_buildEntry, D_ENTER)$
ExtendDesc(r_sw2,
    "There is a fancy entryway here, complete with a somewhat worn red carpet "
    "and overhead marquee. Double glass doors lead into a large entry hall. "
    "There are potted shrubs to either side of the door, and a brass sign "
    "beside the door reads \"Builder's Guild\".")$
RoomGraphics(r_buildEntry, "Foyer", "", GUILD_MAP_GROUP,
	     0.417, 0.56, drawGuild)$
Sign(r_sw2, "sign;brass.door;brass,sign,beside,the",
    "The brass sign is one of those expensive things carved from a hunk of "
    "brass. The resulting raised letters are brass coloured, and the "
    "carved-out areas are painted flat black.",
    "\"Builder's Guild\"")$
Scenery(r_sw2,
    "entryway,entry;fancy."
    "carpet;somewhat,worn,red."
    "marquee;overhead."
    "door;double,glass."
    "hall;large,entry."
    "shrub;potted")$
Scenery(r_buildEntry,
    "floor;expensive,black,and,white,tiled."
    "tile;expensive,black,and,white."
    "plant;potted."
    "upholstery;black,leather."
    "fixture;brass."
    "hallway;long."
    "tree;palm."
    "door;small,wooden")$

define tp_bguild r_buildHall1 CreateThing(r_indoors)$
SetupRoom(r_buildHall1, "in an east-west hallway",
    "On each side of the hall are simple wooden doors. Beside each is a sign "
    "which reads \"Members Only\". The entry hall is to the east.")$
Connect(r_buildEntry, r_buildHall1, D_WEST)$
RoomGraphics(r_buildHall1, "East", "Hallway", GUILD_MAP_GROUP,
	     0.293, 0.56, drawGuild)$
Scenery(r_buildHall1, "door;simple,wooden")$
Sign(r_buildHall1, "sign", "", "\"Members Only\"")$

define tp_bguild r_buildHall2 CreateThing(r_indoors)$
SetupRoom(r_buildHall2, "in an east-west hallway",
    "On each side of the hall are simple wooden doors. Beside each is a sign "
    "which reads \"Members Only\". A set of double doors to the west marks "
    "the end of the hallway. Beside those doors is a sign which reads "
    "\"Library\".")$
Connect(r_buildHall1, r_buildHall2, D_WEST)$
RoomGraphics(r_buildHall2, "West", "Hallway", GUILD_MAP_GROUP,
	     0.202, 0.56, drawGuild)$
Scenery(r_buildHall2, "door;simple,wooden,double")$
Sign(r_buildHall2, "sign", "", "")$
Sign(r_buildHall2, "sign", "", "")$

define tp_bguild r_buildLibrary CreateThing(r_indoors)$
SetupRoom(r_buildLibrary, "in the builder's library",
    "Rows and rows of shelves here are filled to overflowing with plans, "
    "blueprints, permits, announcements, etc. Most of the material is of no "
    "interest, but one set of volumes bears investigation. Double doors lead "
    "out to the east.")$
Connect(r_buildHall2, r_buildLibrary, D_WEST)$
UniConnect(r_buildLibrary, r_buildHall2, D_EXIT)$
RoomGraphics(r_buildLibrary, "Library", "", GUILD_MAP_GROUP,
	     0.079, 0.56, drawGuild)$
Scenery(r_buildLibrary,
    "shelves,shelf;rows,and,of."
    "plan."
    "blueprint."
    "announcement."
    "material")$
Sign(r_buildLibrary, "volume;set,of.set",
    "The volumes you see are the ones you should read.",
    "Read the volumes by name, one at a time.")$

define tp_bguild o_buildBook1 CreateThing(nil)$
SetupObject(o_buildBook1, r_buildLibrary, "introduction,intro;book,of.book",
    "This tattered volume is right at the beginning of the heap. It is "
    "securely attached to the shelf by a brass chain, so you can't take it "
    "out. The text inside describes the miscellaneous building commands.")$
o_buildBook1@p_oNotGettable := true$
o_buildBook1@p_oReadString :=
"The following miscellaneous build (@) commands exist:\n"
"  @showtable <table> - show the symbols defined in the table.\n"
"  @describesymbol <table> <symbol> - describe the given symbol.\n"
"  @deletesymbol <table> <symbol> - delete the given symbol. You must be the\n"
"\towner of the symbol in order to delete it.\n"
"  @movesymbol <fromtable> <totable> <symbol> - move a symbol from one table\n"
"\tto another.\n"
"  @renamesymbol <table> <old-symbol> <new-symbol> - rename a symbol.\n"
"  @flag <table> <symbol> - define a new flag property.\n"
"  @counter <table> <symbol> - define a new counter property.\n"
"  @string <table> <symbol> - define a new string property.\n"
"  @table <table> <symbol> - define a new private table.\n"
"  @use <table> - add table to set used for symbol lookup.\n"
"  @unuse <table> - remove table from set used for symbol lookup.\n"
"  @symbolhere <table> <symbol> - define the given symbol for this room.\n"
"  @poof <symbol> - poof to your given named room.\n"
"Use table name 'private' to refer to your main private symbol table.\n"
"Only an Apprentice or Wizard can make you an official builder."$

define tp_bguild o_buildBook2 CreateThing(nil)$
SetupObject(o_buildBook2, r_buildLibrary, "rooms,room;book,of.book",
    "This book shows much sign of wear. If it wasn't attached to the wall "
    "with an iron chain, it probably wouldn't be here anymore! Inside, it "
    "details the basic methods for building rooms.")$
o_buildBook2@p_oNotGettable := true$
o_buildBook2@p_oReadString :=
"The following forms of the @room (@r) command exist:\n"
"  @room new <dir> <kind> <room-name> - create a new room with a two-way\n"
"\tlink in the indicated direction. <kind> is one of: indoors, forest\n"
"\toutdoors, field, road, path, sidewalk or park. <room-name> is the\n"
"\tstring which will be printed after the 'You are'. E.g.\n"
"\t\t@room new north indoors in a new room\n"
"  @room newname <room-name> - rename the current room.\n"
"  @room same <old-dir> <new-dir> - make a one-way link in direction\n"
"\t<new-dir> which goes the same place as <old-dir> does. E.g.\n"
"\t\t@room same north in\n"
"  @room hide <dir> - toggle the visibility of the given link.\n"
"  @room scenery <word> ... <word> - add scenery words here.\n"
"  @room newdesc - replace the long description of the current room.\n"
"  @room adddesc - append to the long description of the current room.\n"
"  @room setdescaction <action-symbol> - set a descaction proc here.\n"
"  @room linkto <dir> <symbol> - make a one-way link in direction <dir> to\n"
"\tthe room which you have given name <symbol> to.\n"
"  @room unlink <dir> - remove path in the indicated direction.\n"
"  @room dark [ yes | no ] - make the current room dark or light.\n"
"  @room lock [ yes | no ] - lock/unlock the current room for public access.\n"
"  @room status { readonly | wizard | public } - set the status of the\n"
"\tcurrent room with regards to who can build onto it.\n"
"  @room dirdesc <dir> - enter a new direction-specific description for the\n"
"\tcurrent room. This is the message that the character will be shown\n"
"\tif he/she looks in that direction.\n"
"  @room dirmessage <dir> - set the message that the character will see when\n"
"\the/she goes in that direction. <dir> can be 'nogo'.\n"
"  @room diromessage <dir> - set the message that other characters in the\n"
"\tsame room will see when a character goes in the given direction.\n"
"\tThe character's name and a space will be prepended to the message.\n"
"  @room diremessage <dir> - set the message that other characters in the\n"
"\tsame room will see when a character arrives from the given\n"
"\tdirection. Note that the character's name and a space will be\n"
"\tprepended to the message.\n"
"  @room adddircheck <dir> <action-symbol> - enter a new checker procedure\n"
"\tfor going the given direction from the current room. <dir> can also\n"
"\tbe 'anyenter' or 'anyexit'.\n"
"  @room subdircheck <dir> <action-symbol> - remove the checker.\n"
"  @room showdirchecks <dir> - list all checkers for the given direction.\n"
"  @room addspecialaction <action-symbol> <verb-form> - add special action\n"
"\tas in:   @r addspecialaction doSmoogle \"smoogle,grundle\"\n"
"  @room subspecialaction <action-symbol> <verb-form> - remove action.\n"
"  @room checker <table> <action-symbol> - define a checker action.\n"
"  @room descaction <table> <action-symbol> - define a description action.\n"
"  @room specialaction <table> <action-symbol> - define special action.\n"
"  @room makebank - make the current room into a bank.\n"
"  @room makestore - make the current room into a store.\n"
"  @room addforsale <object-symbol> <price> - make object for sale here.\n"
"  @room subforsale <object-symbol> - remove it from sale."$

define tp_bguild o_buildBook3 CreateThing(nil)$
SetupObject(o_buildBook3, r_buildLibrary, "objects,object,obj;book,of.book",
    "This solid volume is tied to the desk with a steel chain, so you can't "
    "check it out of the library. It details the building of objects.")$
o_buildBook3@p_oNotGettable := true$
o_buildBook3@p_oReadString :=
"The following forms of the @object (@o) command exist:\n"
"  @object new <table> <object-symbol> <visible-name> - create a new object\n"
"\twith name <object-symbol> and visible name <visible-name>. E.g.\n"
"\t\t@object new private candle \"candlestick;shiny,brass\"\n"
"  @object newname <object-symbol> <visible-name> - supply new visible name.\n"
"  @object newdesc <object-symbol> - supply new description for the object.\n"
"  @object setdescaction <object-symbol> <action-symbol> - set the action\n"
"\tto be the description action for the object.\n"
"  @object setactword <object-symbol> <word-list> - set the special actions\n"
"\tthat this object can do. E.g.\n"
"\t\t@object setactword candle \"blow,puff,snuff\"\n"
"  @object setactstring <object-symbol> - set the special action string.\n"
"  @object setactaction <object-symbol> <action-symbol> - set special action\n"
"\tprocedure to be triggered by the object's action word.\n"
"  @object gettable <object-symbol> [ yes | no ] - is the object gettable?\n"
"  @object islight <object-symbol> [ yes | no ] - does it emit light?\n"
"  @object invisible <object-symbol> [ yes | no ] - is it seen in room?\n"
"  @object container <object-symbol> <count> - make it a container\n"
"  @object { sitin | siton | liein | lieon | standin | standon }\n"
"\t<object-symbol> <count> - E.g. to make the couch have room for two\n"
"\tpeople to sit on\n"
"\t\t@object siton couch 2\n"
"  @object destroy <table> <object-symbol> - destroy the indicated object.\n"
"  @object checker <table> <action-symbol> - define object checker action.\n"
"  @object descaction <table> <action-symbol> - define a description action.\n"
"  @object actaction <table> <action-symbol> - define a special action.\n"
"XXX := { play | erase | eat | use | activate | deactivate | light |\n"
"\textinguish | wear | read | touch | smell | listen | open | close |\n"
"\tpush | pull | turn | lift | lower }\n"
"  @object XXXstring <object-symbol> - set action string on object.\n"
"\tAlso 'getstring' and 'unlockstring'.\n"
"  @object XXXaction <object-symbol> <action-symbol> - set checker on object."$

define tp_bguild o_buildBook4 CreateThing(nil)$
SetupObject(o_buildBook4, r_buildLibrary, "procedures,procs;book,of.book",
    "This immaterial book is firmly tied to nothing with an intangible chain, "
    "so you cannot remove it from the library. Inside are many words "
    "detailing the building of checker/action/description procedures.")$
o_buildBook4@p_oNotGettable := true$
o_buildBook4@p_oReadString :=
"Checker/action/description procedures are a way of attaching conditions "
"and/or actions to an exit or to an object. "
"They are executed when a character tries to take the exit or do something "
"with the object. "
"They can cause things to happen, such as a message to the character or "
"others, and can conditionally allow the taking of the exit or the "
"completion of the action. "
"They are entered line by line and each line of the procedure is checked for "
"validity against the rules for the kind of procedure being entered. "
"Note that this is NOT full-fledged AmigaMUD programming - wizards and "
"apprentices have access to a much more flexible and powerful programming "
"language.\n\n"
"Checker/action procedures consist of a series (possibly none) of actions to "
"be executed unconditionally; "
"followed by a condition, which is built from none or more simple "
"conditionals; "
"followed by the actions to be executed if the condition succeeds; "
"followed by the actions to be executed if the condition fails. "
"The allowable conditions and actions vary depending on whether the procedure "
"governs a room exit or an object operation. "
"A condition passes only if ALL of its simple conditionals are satisfied. "
"See the books titled 'book of conditionals' and 'book of actions' for "
"details.\n\n"
"Description procedures are used to produce room or object descriptions which "
"vary depending on the state of some variables. "
"They are essentially just a string, as described in the 'book of strings'."$

define tp_bguild o_buildBook5 CreateThing(nil)$
SetupObject(o_buildBook5, r_buildLibrary,
	    "conditionals,cond,condition,conditions,conditional;book,of.book",
    "This book describes the simple conditionals which can be attached to "
    "a checker/action procedure.")$
o_buildBook5@p_oNotGettable := true$
o_buildBook5@p_oReadString :=
"'character' and 'room' values can be tested for either exit or object "
"conditionals, but 'object' values must be used appropriately. "
"The 'XXXhasYYY' tests refer to the object being carried by the character, "
"in the room, or in the main object. "
"Each of these simple conditions can be preceeded by 'not' to reverse its "
"test.\n"
"  characterflag/roomflag/objectflag <flag-symbol> - the conditional is true\n"
"\tif the specified flag is 'true'.\n"
"  charactercounter/roomcounter/objectcounter <counter-symbol>\n"
"\t<counter-value> - the conditional is true if the counter has the\n"
"\tgiven value.\n"
"  characterhasspecific/roomhasspecific/objecthasspecific <object-symbol> -\n"
"\tthe conditional is true if the character has the thing, or it is in\n"
"\tthe room, or it is inside the main object. <object-symbol> is the\n"
"\tdefining character's private symbol name for the object.\n"
"  characterhaschild/roomhaschild/objecthaschild <object-symbol> - the\n"
"\tconditional is true if the character/room/object has/contains an\n"
"\tobject cloned from the indicated one (see 'book of actions').\n"
"  characterhasname/roomhasname/objecthasname <name-string> - the\n"
"\tconditional is true if the character/room/object has/contains an\n"
"\tobject whose name matches the given <name-string>. Note that the\n"
"\t<name-string> is in the standard 'noun;adj,adj' format.\n"
"  characterhasflag/roomhasflag/objecthasflag <flag-symbol> - the\n"
"\tconditional is true if the character/room/object has/contains an\n"
"\tobject so flagged.\n"
"  random <chance> - the conditional passes with '<chance> / 10' percent\n"
"\tlikelihood. E.g. \"random 500\" gives a 50% chance."$

define tp_bguild o_buildBook6 CreateThing(nil)$
SetupObject(o_buildBook6, r_buildLibrary,
	    "actions,action,act,acts;book,of.book",
    "This book describes the actions which can be attached to "
    "a checker/action procedure.")$
o_buildBook6@p_oNotGettable := true$
o_buildBook6@p_oReadString :=
"'character' and 'room' values can be changed for either exit or object "
"procedures, but 'object' values must be used appropriately.\n"
"  charactersetflag/characterclearflag/roomsetflag/roomclearflag/\n"
"    objectsetflag/objectclearflag <flag-symbol> - the given flag is set or\n"
"\tcleared, as appropriate.\n"
"  characterinccounter/characterdeccounter/roominccounter/roomdeccounter/\n"
"    objectinccounter/objectdeccounter <counter-symbol> - the given counter\n"
"\tis incremented or decremented, as appropriate.\n"
"  charactersetcounter/objectsetcounter/roomsetcounter <counter-symbol>\n"
"\t<value> - the given counter is set to the given value.\n"
"  charactersetstring/objectsetstring/roomsetstring <string-symbol>\n"
"\t<s-val> - the given string property is set based on s-val: 'date' or\n"
"\t'time' give the current date/time as in \"Mon Jan 25 19:47:40 1993\";\n"
"\t'charactername' gives the name of the current character; 'roomname'\n"
"\tgives the name of the room, as in \"in the playpen\"; and\n"
"\t'objectname' gives the object name, as in \"delicate blue vase\".\n"
"  characterclearstring/objectclearstring/roomclearstring <string-symbol> -\n"
"\tthe string property is removed from the character/room/object.\n"
"  clonehere <object-symbol> - a clone of the named object is created and\n"
"\tdeposited in this room.\n"
"  cloneat <room-symbol> <object-symbol> - a clone of the named object is\n"
"\tmade and placed in the indicated room.\n"
"  destruct - the object (only valid there) is destroyed.\n"
"  drop - the object is dropped.\n"
"  setit <kind> <object-symbol> - if kind is 'specific' then the named\n"
"\tobject becomes the main object, which is affected by further actions\n"
"\tin this branch of the procedure. If kind is 'characterchild',\n"
"\t'roomchild' or 'objectchild', then the first object being carried,\n"
"\tin the room or in the object is so set. If kind is 'flag', then\n"
"\tthe first object with that flag set becomes the main object. If\n"
"\tkind is 'name', then the object-symbol must be the visible name of\n"
"\tan object to look for.\n"
"  saycharacter - input mode changes to accept a message which is to be\n"
"\tgiven to the character. See the 'book of strings' for details.\n"
"  sayothers - input mode changes to accept a message which is to be given\n"
"\tto other characters in the same room.\n"
"  if - allows a nested condition/true/false sequence to be inserted. These\n"
"\tcannot be further nested."$

define tp_bguild o_buildBook7 CreateThing(nil)$
SetupObject(o_buildBook7, r_buildLibrary, "strings,string;book,of.book",
    "This book describes the special things that can be put in strings in "
    "procedures, both description procedures and as part of others.")$
o_buildBook7@p_oNotGettable := true$
o_buildBook7@p_oReadString :=
"Most input here is just text that is part of the string. Do not attempt to "
"format the text - the system will format it, along with any other text that "
"is part of the relevant output, according to the width of the player's "
"output device. "
"If a line input here starts with an '@', however, it is a special command "
"which causes things to be put in that place in the string when the string "
"is being used during execution. "
"The special string commands are\n"
"  @characterstring/roomstring/objectstring <string-symbol> - the value of\n"
"\tthe indicated string property is inserted.\n"
"  @charactercounter/roomcounter/objectcounter <counter-symbol> - the value\n"
"\tof the indicated counter is inserted in numeric form.\n"
"  @charactername/roomname/objectname - the name of the character/room/\n"
"\tobject is inserted. See the 'book of actions' for the formats used."$

define tp_bguild proc buildCheck()status:

    if Me()@p_pBuilder then
	continue
    else
	Print("Not being a member of the guild, you cannot go through "
		"the door.\n");
	fail
    fi
corp;

define tp_bguild r_buildOffice1 CreateThing(r_indoors)$
SetupRoom(r_buildOffice1, "in a private office",
    "This office is decorated in a traditional British style. Oak panelling "
    "covers the wall, a massive fireplace on the north wall is complete with "
    "a large mantelpiece filled with knick-knacks, and a wool carpet covers "
    "the floor. The furniture consists of a huge oak desk, and several "
    "overstuffed armchairs.")$
Connect(r_buildHall1, r_buildOffice1, D_NORTH)$
UniConnect(r_buildOffice1, r_buildHall1, D_EXIT)$
AddNorthChecker(r_buildHall1, buildCheck, false)$
RoomGraphics(r_buildOffice1, "British", "Office", GUILD_MAP_GROUP,
	     0.293, 0.37, drawGuild)$
Scenery(r_buildOffice1,
    "panelling,panel;oak."
    "wall;oak-panelled,oak,panelled,north."
    "fireplace;massive."
    "mantelpiece;large."
    "knick-knack,knack;knick."
    "carpet;wool."
    "floor."
    "furniture."
    "desk;huge,oak."
    "armchairs,chair;arm,overstuffed")$

define tp_bguild r_buildOffice2 CreateThing(r_indoors)$
SetupRoom(r_buildOffice2, "in a private office",
    "This office sports a distinctly modern look. The desk is of stainless "
    "steel and black plastic, and sports the latest Amiga computer. The "
    "bookcases, shelving, coffee tables, etc. are all of gleaming brass and "
    "glass. Abstract dodads fill much of the shelf space. The couch is much "
    "too low to be comfortable, but is certainly big enough to sleep on.")$
Connect(r_buildHall1, r_buildOffice2, D_SOUTH)$
UniConnect(r_buildOffice2, r_buildHall1, D_EXIT)$
AddSouthChecker(r_buildHall1, buildCheck, false)$
RoomGraphics(r_buildOffice2, "Modern", "Office", GUILD_MAP_GROUP,
	     0.293, 0.755, drawGuild)$
Scenery(r_buildOffice2,
    "desk;stainless,steel,and,black,plastic."
    "computer,keyboard,screen,drive,disk;amiga,disk."
    "shelving,shelves,shelf,table,case;book,coffee,gleaming,brass,and,glass."
    "dodad;abstract."
    "space;shelf."
    "couch;low,big,uncomfortable")$
MakeBulletinBoard(r_buildOffice2)$

define tp_bguild r_buildOffice3 CreateThing(r_indoors)$
SetupRoom(r_buildOffice3, "in a private office",
    "This office would be more appropriate in Nairobi! The furniture is all "
    "cane and bamboo, large tubs of tropical plants fill the walls, and you "
    "can even make out mounted animal heads peering through the greenery. "
    "Display cases hold feathered spears, brightly decorated shields, and "
    "gruesome carved masks. Unfortunately, the cases, like everything else "
    "around here, cannot be opened.")$
Connect(r_buildHall2, r_buildOffice3, D_NORTH)$
UniConnect(r_buildOffice3, r_buildHall2, D_EXIT)$
AddNorthChecker(r_buildHall2, buildCheck, false)$
RoomGraphics(r_buildOffice3, "African", "Office", GUILD_MAP_GROUP,
	     0.202, 0.37, drawGuild)$
Scenery(r_buildOffice3,
    "furniture;cane,and,bamboo."
    "tub,plant;large,tubs,of,tropical."
    "wall."
    "head;mounted,animal."
    "greenery."
    "case;display."
    "spear;feathered."
    "shield;brightly,decorated."
    "mask;gruesome,carved.")$

define tp_bguild r_buildOffice4 CreateThing(r_indoors)$
SetupRoom(r_buildOffice4, "in a private office",
    "This office must belong to someone lost in the past! The walls are "
    "covered with vertical log stakes, held together by large iron bands and "
    "spikes. The furniture is all rough-cut wood with a bit of varnish. The "
    "desk looks massive enough to park a car on. Locked gun-cases can be "
    "seen on one wall, while another is full of small, faded photographs of "
    "someone's distant relatives.")$
Connect(r_buildHall2, r_buildOffice4, D_SOUTH)$
UniConnect(r_buildOffice4, r_buildHall2, D_EXIT)$
AddSouthChecker(r_buildHall2, buildCheck, false)$
RoomGraphics(r_buildOffice4, "Western", "Office", GUILD_MAP_GROUP,
	     0.202, 0.755, drawGuild)$
Scenery(r_buildOffice4,
    "wall;vertical,log,stake."
    "band,spike;large,iron."
    "furniture;rough-cut,rough,cut,wood,wooden,varnished."
    "desk;massive."
    "case,gun-case;gun,locked."
    "photograph,relative;small,faded,someone's,distant")$

define tp_bguild r_buildStairs1 CreateThing(r_indoors)$
SetupRoom(r_buildStairs1, "at the top of some stairs",
    "Concrete block walls enclose a small landing here. A drab steel door "
    "opens on the south wall, and dirty metal stairs head down. You can hear "
    "some strange high-pitched noises coming from below.")$
Connect(r_buildEntry, r_buildStairs1, D_NORTH)$
UniConnect(r_buildStairs1, r_buildEntry, D_EXIT)$
RoomGraphics(r_buildStairs1, "Top of", "Stairs", GUILD_MAP_GROUP,
	     0.417, 0.21, drawGuild)$
Scenery(r_buildStairs1,
    "wall;concrete,block,south."
    "stair;dirty,metal."
    "door;drab,steel")$

define tp_bguild r_buildStairs2 CreateThing(r_indoors)$
SetupRoom(r_buildStairs2, "at the bottom of some stairs",
    "Garbage litters the floor here at the bottom of some rusty metal stairs. "
    "A door in the stained concrete wall leads to the south. You can hear "
    "what sounds like children playing behind it. A sign beside the door "
    "reads \"Playpen - Enter At Own Risk\".")$
Connect(r_buildStairs1, r_buildStairs2, D_DOWN)$
define tp_bguild o_playpenSign CreateThing(nil)$
FakeObject(o_playpenSign, r_buildStairs2, "sign", "")$
o_playpenSign@p_oReadString := "\"Playpen - Enter At Own Risk.\""$
Scenery(r_buildStairs2,
    "garbage,litter,floor,door."
    "wall;stained,concrete."
    "stair;rusty,metal")$
define tp_bguild proc drawStairsBottom()void:
    GSetPen(nil, C_DARK_BROWN);
    GAMove(nil, 0.0, 0.0);
    GRectangle(nil, 0.499, 1.0, true);
    GSetPen(nil, C_BLACK);
    GAMove(nil, 0.205, 0.42);
    GRectangle(nil, 0.092, 0.176, true);
    GSetPen(nil, C_TAN);
    GAMove(nil, 0.205, 0.42);
    GRectangle(nil, 0.092, 0.176, false);
    GSetPen(nil, C_BROWN);
    GAMove(nil, 0.236, 0.59);
    HorizontalDoor();
    DrawUpArrow(C_GOLD);
corp;
AutoGraphics(r_buildStairs2, drawStairsBottom)$
RoomName(r_buildStairs2, "Bottom of", "Stairs")$

define tp_bguild proc enterPlayPen()status:

    if PrivateTable() = nil then
	/* Do not let machines in */
	fail
    else
	if not Me()@p_pBuilder then
	    setupBuild();
	fi;
	continue
    fi
corp;

define tp_bguild proc scanList(list thing lt)void:
    int count, n;
    thing th;

    count := Count(lt);
    n := 0;
    while n < count do
	th := lt[n];
	if th@p_oContents ~= nil then
	    scanList(th@p_oContents);
	fi;
	if th@p_rPlayPen then
	    AddTail(r_playPen@p_rContents, th);
	    DelElement(lt, th);
	    th -- p_oCarryer;
	    th@p_oWhere := r_playPen;
	    Print(FormatName(th@p_oName) + " is dropped.\n");
	    count := count - 1;
	else
	    n := n + 1;
	fi;
    od;
corp;

define tp_bguild proc exitPlayPen()status:
    thing me;

    me := Me();
    if not me@p_pBuilder then
	clearBuild();
    fi;
    scanList(me@p_pCarrying);
    continue
corp;

/* the room 'r_playPen' is created and used in 'build.m' */
SetupRoom(r_playPen, "in the PLAYPEN",
    "This room is the builder's playpen. Anyone can be a builder in here. "
    "This means that you should be careful of any rooms and/or objects you "
    "find in this area, since they may not have been built very carefully! "
    "The way out of the mayhem is to the north.")$
SetThingStatus(r_playPen, ts_public)$
Connect(r_buildStairs2, r_playPen, D_SOUTH)$
Connect(r_buildStairs2, r_playPen, D_ENTER)$
AddSouthChecker(r_buildStairs2, enterPlayPen, false)$
AddEnterChecker(r_buildStairs2, enterPlayPen, false)$
AddNorthChecker(r_playPen, exitPlayPen, false)$
AddExitChecker(r_playPen, exitPlayPen, false)$
r_playPen@p_rPlayPen := true$
AutoGraphics(r_playPen, AutoClosedRoom)$
AutoPens(r_playPen, C_DARK_BROWN, C_CADMIUM_YELLOW, C_BLUE_GREEN, C_ORANGE)$

define tp_bguild proc questPhotoDesc()string:

    "Bring me a photograph of " + Me()@p_pName + "'s whatzit."
corp;

define tp_bguild proc questPhotoGive()status:
    thing photo;

    photo := It();
    if MatchName(photo@p_oName,
	"whatzit;photograph,of," + TrueMe()@p_pName + "'s") ~= -1
    then
	GiveToQuestor(FormatName(photo@p_oName));
	if Parent(photo) = o_photograph then
	    succeed
	else
	    SPrint(TrueMe(), "Questor is not impressed.\n");
	    fail
	fi
    else
	continue
    fi
corp;

define tp_bguild proc questPhotoHint()string:

    "They are impossible to find."
corp;

QuestGive("Whatzit", questPhotoDesc, questPhotoGive, questPhotoHint)$

unuse t_streets
unuse tp_bguild
