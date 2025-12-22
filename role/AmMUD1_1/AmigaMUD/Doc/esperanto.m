/*
 * Amiga MUD
 *
 * Copyright (c) 1997 by Chris Gray and Don Reble
 */

/*
 * simple.m - a very simple text-only adventure. Mostly just a tutorial.
 */


/* First, define the basic "properties" that we will use in this world */

/* Properties on rooms: */

public north CreateThingProp()$       /* the room to the north (if any) */
public south CreateThingProp()$       /* the room to the south (if any) */
public east CreateThingProp()$	      /* the room to the east (if any) */
public west CreateThingProp()$	      /* the room to the west (if any) */
public desc CreateStringProp()$       /* the description of the room */
public contents CreateThingListProp()$/* the list of stuff in the room */

/* Properties on players: */

public carrying CreateThingListProp()$/* the list of stuff being carried */

/* Properties on objects: */

public name CreateStringProp()$       /* internal-form name of object */


/* use this short name to avoid some typing */

public G CreateGrammar()$


/* The rooms in our world: */
/* First, create them all so we can reference them */

public clearing CreateThing(nil)$
public forestNorth CreateThing(nil)$
public forestSouth CreateThing(nil)$
public dam CreateThing(nil)$
public forestEast CreateThing(nil)$
public forestWest CreateThing(nil)$
public overlook CreateThing(nil)$
public forestNorthWest CreateThing(nil)$
public outsideHut CreateThing(nil)$
public insideHut CreateThing(nil)$

/* Now put in their descriptions and interconnections. Also give each one a
   'contents', so objects can be there. */

clearing@contents := CreateThingList()$
clearing@desc :=
    "Vi staras en maldensejo de arbaro. Vi povas iri al multaj direktoj.\n"$
clearing@north := forestNorth$
clearing@south := forestSouth$
clearing@east := forestEast$
clearing@west := forestWest$

forestNorth@contents := CreateThingList()$
forestNorth@desc :=
    "Vi estas en la arbaro. La maldensejo estas suden. Vi povas iri ankaux "
    "okcidenten, sed la densajxoj baras aliajn vojojn.\n"$
forestNorth@south := clearing$
forestNorth@west := forestNorthWest$

forestSouth@contents := CreateThingList()$
forestSouth@desc :=
    "Vi estas en la arbaro, suda de la maldensejo. Cxi tie, ekzistas vojeto, "
    "irante okcidenten, laux riverbordo.\n"$
forestSouth@north := clearing$
forestSouth@west := dam$

dam@contents := CreateThingList()$
dam@desc :=
    "Vi alvenas cxe barajxo en la rivereto. Pro la roka valeto, vi nur povas "
    "reiri orienten.\n"$
dam@east := forestSouth$

forestEast@contents := CreateThingList()$
forestEast@desc :=
    "Vi estas en la arbaro. La densajxoj kaj arboj baras vin, escepte al "
    "okcidento.\n"$
forestEast@west := clearing$

forestWest@contents := CreateThingList()$
forestWest@desc :=
    "Vi estas en la arbaro. Al okcidento, roka kresto baras vin, sed vi povas "
    "iri tra arboj laux aliaj direktoj.\n"$
forestWest@east := clearing$
forestWest@north := forestNorthWest$
forestWest@south := overlook$

overlook@contents := CreateThingList()$
overlook@desc :=
    "Vi alvenis al limo de klifeto. Sube, vi vidas rokan valeton, kun "
    "rivereto kaj barajxo.\n"$
overlook@north := forestWest$

forestNorthWest@contents := CreateThingList()$
forestNorthWest@desc :=
    "Vi estas en la arbaro. Ne ekzistas vidindajxoj, sed vi povas iri "
    "multajn direktojn tra densaj arbustoj.\n"$
forestNorthWest@east := forestNorth$
forestNorthWest@north := outsideHut$
forestNorthWest@south := forestWest$

outsideHut@contents := CreateThingList()$
outsideHut@desc :=
    "Vi staras ekster sxtipa kabano en la arbaro. Vi povas iri norden en la "
    "kabanon, aux reiri suden.\n"$
outsideHut@south := forestNorthWest$
outsideHut@north := insideHut$

insideHut@contents := CreateThingList()$
insideHut@desc :=
    "Vi estas en la kabano. Sxajnas ke cxasanto logxas cxi tie dum vintro, "
    "sed neniu estas cxi tie nun. La porto estas sude.\n\nSur la planko "
    "estas granda kesto, sekure sxlosita per granda fera seruro.\n"$
insideHut@south := outsideHut$


/* Create the objects in the world: */

public ironKey CreateThing(nil)$
ironKey@name := "sxlosilo;fera"$
AddTail(dam@contents, ironKey)$ 	/* put it at the dam */

public rock CreateThing(nil)$
rock@name := "roko;eta"$
AddTail(overlook@contents, rock)$	/* put it at the overlook */


/* Now create the commands in the world. */

/* First, some handy utilities. */

public proc FormatNameAcc(string name)string:
    string str1, str2;
    int ind;

    str1 := FormatName(name);
    str2 := "";
    while
	ind := Index(str1, " ");
	ind ~= -1
    do
	str2 := str2 + SubString(str1, 0, ind) + "n ";
	str1 := SubString(str1, ind + 1, Length(str1) - ind - 1);
    od;
    str2 + str1 + "n"
corp;

public proc showAgent(thing who)void:

    Print(who@p_pName + " estas cxi tie.\n");
corp;

public proc lookAround()void:
    int n, i;

    Print(Here()@desc);
    n := Count(Here()@contents);
    if n ~= 0 then
	Print("Apude:\n");
	for i from 0 upto n - 1 do
	    Print("    " + FormatName(Here()@contents[i]@name) + "\n");
	od;
    fi;
    ForEachAgent(Here(), showAgent);
corp;

public proc move(thing where)bool:

    if where = nil then
	Print("Vi ne povas iri tiun direkton.\n");
	false
    else
	OPrint(Me()@p_pName + " eliras.\n");
	SetLocation(where);
	OPrint(Me()@p_pName + " eniras.\n");
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

Verb0(G, "norden", 0, goNorth)$
Synonym(G, "norden", "n")$
Verb0(G, "suden", 0, goSouth)$
Synonym(G, "suden", "s")$
Verb0(G, "orienten", 0, goEast)$
Synonym(G, "orienten", "or")$
Verb0(G, "okcidenten", 0, goWest)$
Synonym(G, "okcidenten", "ok")$

/* Now, commands for getting and dropping things. */

public proc get(string what)bool:
    thing object;
    status st;

    if what = "" then
	Print("Bonvole diru kion vi volas preni.\n");
	false
    else
	st := FindName(Here()@contents, name, what);
	if st = fail then
	    Print("Ne ekzistas " + FormatName(what) + " cxi tie.\n");
	    false
	elif st = continue then
	    Print(FormatName(what) + " estas dubasenca.\n");
	    false
	else
	    object := FindResult();
	    AddTail(Me()@carrying, object);
	    DelElement(Here()@contents, object);
	    Print(FormatName(what) + " estas prenita.\n");
	    true
	fi
    fi
corp;

public proc drop(string what)bool:
    thing object;
    status st;

    if what = "" then
	Print("Bonvole diru kion vi volas lasi.\n");
	false
    else
	st := FindName(Me()@carrying, name, what);
	if st = fail then
	    Print("Vi ne havas " + FormatNameAcc(what) + ".\n");
	    false
	elif st = continue then
	    Print(FormatName(what) + " estas dubasenca.\n");
	    false
	else
	    object := FindResult();
	    AddTail(Here()@contents, object);
	    DelElement(Me()@carrying, object);
	    Print(FormatName(what) + " estas lasita.\n");
	    true
	fi
    fi
corp;

Verb1(G, "prenu", 0, get)$
Synonym(G, "prenu", "havigu")$
Verb1(G, "lasu", 0, drop)$

/* A couple of 'utility' commands. */

public proc bye()bool:

    Print("Gxis! Revenu baldaux!\n");
    Quit();
    true
corp;

Verb0(G, "gxis", 0, bye)$
Synonym(G, "gxis", "kvitu")$

public proc help()bool:
    Print("Ordonoj estas:\n"
	  "  helpu/help\n"
	  "  gxis/kvitu\n"
	  "  norden/n\n"
	  "  suden/s\n"
	  "  orienten/or\n"
	  "  okcideten/ok\n"
	  "  prenu/havigu\n"
	  "  lasu\n"
	  "  portajxoj/port\n"
	  "  rigardu/rig\n"
	  "  malfermu/malsxlosu\n");
    true
corp;

Verb0(G, "helpu", 0, help)$
Synonym(G, "helpu", "help")$
Synonym(G, "helpu", "?")$

public proc inventory()bool:
    int n, i;

    n := Count(Me()@carrying);
    if n = 0 then
	Print("Vi havas nenion.\n");
    else
	Print("Vi portas:\n");
	for i from 0 upto n - 1 do
	    Print("    " + FormatNameAcc(Me()@carrying[i]@name) + "\n");
	od;
    fi;
    true
corp;

Verb0(G, "portajxoj", 0, inventory)$
Synonym(G, "portajxoj", "port")$

public proc look()bool:
    lookAround();
    true
corp;

Verb0(G, "rigardu", 0, look)$
Synonym(G, "rigardu", "rig")$

/* And now, the command which lets you win this little game. */

public proc open(string openWhat, withWhat)bool:
    thing object;
    status st;

    if openWhat == "kesto" or openWhat == "kesto;granda" then
	if Here() = insideHut then
	    st := FindName(Me()@carrying, name, withWhat);
	    if st = fail then
		Print("Vi ne havas " + FormatNameAcc(withWhat) + ".\n");
		false
	    elif st = continue then
		Print(FormatName(withWhat) + " estas dubsenca.\n");
		false
	    else
		object := FindResult();
		if object ~= ironKey then
		    Print("Vi ne povas malfermi ajxoj per tio!\n");
		    false
		else
		    Print("Vi malfermas la keston per la fera sxosilo.\n");
		    Print("Gratulojn! Vi solvis la enigmon.\n");
		    true
		fi
	    fi
	else
	    Print("Ne ekzistas kesto cxi tie.\n");
	    false
	fi
    else
	Print("Vi ne povas malfermi tion!\n");
	false
    fi
corp;

Verb2(G, "malfermu", Word(G, "per"), open)$
Synonym(G, "malfermu", "malsxlosu")$


/* The routine needed to get and parse the player's input. */

public proc parseInput(string inputLine)void:

    if SubString(inputLine, 0, 1) = "\"" then
	Say("", SubString(inputLine, 1, Length(inputLine) - 1));
    else
	ignore Parse(G, inputLine);
    fi;
corp;


public proc rawKeyHandler(int whichRawKey)void:

    case whichRawKey
    incase 0x20:	/* HELP key */
	ignore help();
    esac;
corp;

/* And, finally, the startup stuff, where a new player connects. */

public proc newPlayer()void:

    ignore SetPrompt("tajpu> ");
    Me()@carrying := CreateThingList();
    SetLocation(clearing);
    ignore SetCharacterInputAction(parseInput);
    ignore SetCharacterRawKeyAction(rawKeyHandler);
    Print("Bonvenu al la simpla MUK ejo, " + Me()@p_pName +
	"! Ni esperas ke vi gxuas la ludon.\n\n");
    lookAround();
corp;

ignore SetNewCharacterAction(newPlayer)$
