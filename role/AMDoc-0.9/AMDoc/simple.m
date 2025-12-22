/*
 * Amiga MUD
 *
 * Copyright (c) 1994 by Chris Gray
 */

/*
 * simple.m - a very simple text-only adventure. Mostly just a tutorial.
 */


/* First, define the basic "properties" that we will use in this world */

/* Properties on rooms: */

public north CreateThingProp().       /* the room to the north (if any) */
public south CreateThingProp().       /* the room to the south (if any) */
public east CreateThingProp().	      /* the room to the east (if any) */
public west CreateThingProp().	      /* the room to the west (if any) */
public desc CreateStringProp().       /* the description of the room */
public contents CreateThingListProp()./* the list of stuff in the room */

/* Properties on players: */

public carrying CreateThingListProp()./* the list of stuff being carried */

/* Properties on objects: */

public name CreateStringProp().       /* internal-form name of object */


/* use this short name to avoid some typing */

public G CreateGrammar().


/* The rooms in our world: */
/* First, create them all so we can reference them */

public clearing CreateThing(nil).
public forestNorth CreateThing(nil).
public forestSouth CreateThing(nil).
public dam CreateThing(nil).
public forestEast CreateThing(nil).
public forestWest CreateThing(nil).
public overlook CreateThing(nil).
public forestNorthWest CreateThing(nil).
public outsideHut CreateThing(nil).
public insideHut CreateThing(nil).

/* Now put in their descriptions and interconnections. Also give each one a
   'contents', so objects can be there. */

clearing@contents := CreateThingList().
clearing@desc :=
    "You are standing in a small clearing in a forest. You can go in several "
    "directions from here.\n".
clearing@north := forestNorth.
clearing@south := forestSouth.
clearing@east := forestEast.
clearing@west := forestWest.

forestNorth@contents := CreateThingList().
forestNorth@desc :=
    "You are in the forest. The clearing is to your south. You can also go "
    "to the west, but other directions are blocked by the undergrowth.\n".
forestNorth@south := clearing.
forestNorth@west := forestNorthWest.

forestSouth@contents := CreateThingList().
forestSouth@desc :=
    "You are in the forest, south of the clearing. There is a small path "
    "here, leading west by a small stream.\n".
forestSouth@north := clearing.
forestSouth@west := dam.

dam@contents := CreateThingList().
dam@desc :=
    "You have come to a dam on the stream. The rocky gully here prevents you "
    "from going anywhere but back to the east.\n".
dam@east := forestSouth.

forestEast@contents := CreateThingList().
forestEast@desc :=
    "You are in the forest. Thick bushes and trees prevent you from going "
    "anywhere except back west.\n".
forestEast@west := clearing.

forestWest@contents := CreateThingList().
forestWest@desc :=
    "You are in the forest. A rocky ridge to the west prevents you from going "
    "further in that direction, but you can wander through the trees in the "
    "other directions.\n".
forestWest@east := clearing.
forestWest@north := forestNorthWest.
forestWest@south := overlook.

overlook@contents := CreateThingList().
overlook@desc :=
    "You have come to the edge of a small cliff. You can see down into a "
    "rocky gully here, where there is a dam across a small stream.\n".
overlook@north := forestWest.

forestNorthWest@contents := CreateThingList().
forestNorthWest@desc :=
    "You are in the forest. You can't see much here, but you can go in "
    "several directions through the thick bushes.\n".
forestNorthWest@east := forestNorth.
forestNorthWest@north := outsideHut.
forestNorthWest@south := forestWest.

outsideHut@contents := CreateThingList().
outsideHut@desc :=
    "You are standing outside a log hut in the forest. You can go north into "
    "the hut, or back south into the forest.\n".
outsideHut@south := forestNorthWest.
outsideHut@north := insideHut.

insideHut@contents := CreateThingList().
insideHut@desc :=
    "You are inside a small hut. It looks like a trapper or hunter uses this "
    "hut during the winter, but there is no-one here now. The door out is "
    "to the south.\n\nSitting on the floor here is a large chest, securely "
    "locked with an iron padlock.\n".
insideHut@south := outsideHut.


/* Create the objects in the world: */

public ironKey CreateThing(nil).
ironKey@name := "key;iron".
AddTail(dam@contents, ironKey). 	/* put it at the dam */

public rock CreateThing(nil).
rock@name := "rock;small".
AddTail(overlook@contents, rock).	/* put it at the overlook */


/* Now create the commands in the world. */

/* First, some handy utilities. */

public proc showAgent(thing who)void:

    Print(who@p_pName + " is here.\n");
corp;

public proc lookAround()void:
    int n, i;

    Print(Here()@desc);
    n := Count(Here()@contents);
    if n ~= 0 then
	Print("Nearby:\n");
	for i from 0 upto n - 1 do
	    Print("    " + FormatName(Here()@contents[i]@name) + "\n");
	od;
    fi;
    ForEachAgent(Here(), showAgent);
corp;

public proc move(thing where)bool:

    if where = nil then
	Print("You can't go that direction.\n");
	false
    else
	OPrint(Me()@p_pName + " leaves.\n");
	SetLocation(where);
	OPrint(Me()@p_pName + " arrives.\n");
	lookAround();
	true
    fi
corp;

/* Next, the commands for moving. */

public proc goNorth()bool:
    move(Here()@north)
corp;

public proc goSouth()bool:
    move(Here()@south)
corp;

public proc goEast()bool:
    move(Here()@east)
corp;

public proc goWest()bool:
    move(Here()@west)
corp;

Verb0(G, "north", 0, goNorth).
Synonym(G, "north", "n").
Verb0(G, "south", 0, goSouth).
Synonym(G, "south", "s").
Verb0(G, "east", 0, goEast).
Synonym(G, "east", "e").
Verb0(G, "west", 0, goWest).
Synonym(G, "west", "w").

/* Now, commands for getting and dropping things. */

public proc get(string what)bool:
    thing object;
    status st;

    if what = "" then
	Print("You must say what you want to get.\n");
	false
    else
	st := FindName(Here()@contents, name, what);
	if st = fail then
	    Print("There is no " + FormatName(what) + " here.\n");
	    false
	elif st = continue then
	    Print(FormatName(what) + " is ambiguous.\n");
	    false
	else
	    object := FindResult();
	    AddTail(Me()@carrying, object);
	    DelElement(Here()@contents, object);
	    Print(FormatName(what) + " taken.\n");
	    true
	fi
    fi
corp;

public proc drop(string what)bool:
    thing object;
    status st;

    if what = "" then
	Print("You must say what you want to drop.\n");
	false
    else
	st := FindName(Me()@carrying, name, what);
	if st = fail then
	    Print(AAn("You are not carrying", FormatName(what)) + ".\n");
	    false
	elif st = continue then
	    Print(FormatName(what) + " is ambiguous.\n");
	    false
	else
	    object := FindResult();
	    AddTail(Here()@contents, object);
	    DelElement(Me()@carrying, object);
	    Print(FormatName(what) + " dropped.\n");
	    true
	fi
    fi
corp;

Verb1(G, "get", 0, get).
Synonym(G, "get", "take").
Verb1(G, "drop", 0, drop).

/* A couple of 'utility' commands. */

public proc bye()bool:

    Print("Bye-bye! Come again soon!\n");
    Quit();
    true
corp;

Verb0(G, "bye", 0, bye).
Synonym(G, "bye", "quit").

public proc inventory()bool:
    int n, i;

    n := Count(Me()@carrying);
    if n = 0 then
	Print("You are not carrying anything.\n");
    else
	Print("You are carrying:\n");
	for i from 0 upto n - 1 do
	    Print("    " + FormatName(Me()@carrying[i]@name) + "\n");
	od;
    fi;
    true
corp;

Verb0(G, "inventory", 0, inventory).
Synonym(G, "inventory", "i").

public proc look()bool:
    lookAround();
    true
corp;

Verb0(G, "look", 0, look).
Synonym(G, "look", "l").

/* And now, the command which lets you win this little game. */

public proc open(string openWhat, withWhat)bool:
    thing object;
    status st;
    string name2;

    name2 := FormatName(withWhat);
    if openWhat == "chest" or openWhat == "chest;large" then
	if Here() = insideHut then
	    st := FindName(Me()@carrying, name, withWhat);
	    if st = fail then
		Print(AAn("You are not carrying", name2) + ".\n");
		false
	    elif st = continue then
		Print(name2 + " is ambiguous.\n");
		false
	    else
		object := FindResult();
		if object ~= ironKey then
		    Print("You can't open things with that!\n");
		    false
		else
		    Print("You open the chest with the iron key.\n");
		    Print("Congratulations! You have solved the puzzle.\n");
		    true
		fi
	    fi
	else
	    Print("There is no chest here.\n");
	    false
	fi
    else
	Print("You can't open that!\n");
	false
    fi
corp;

Verb2(G, "open", Word(G, "with"), open).
Synonym(G, "open", "unlock").


/* The routine needed to get and parse the player's input. */

public proc parseInput(string inputLine)void:

    if SubString(inputLine, 0, 1) = "\"" then
	Say(SubString(inputLine, 1, Length(inputLine) - 1));
    else
	ignore Parse(G, inputLine);
    fi;
corp;


/* And, finally, the startup stuff, where a new player connects. */

public proc newPlayer()void:

    Me()@carrying := CreateThingList();
    SetLocation(clearing);
    ignore SetCharacterInputAction(parseInput);
    Print("Welcome to the simple MUD world, " + Me()@p_pName +
	"! We hope you have fun with MUD.\n\n");
    lookAround();
corp;

ignore SetNewCharacterAction(newPlayer).
