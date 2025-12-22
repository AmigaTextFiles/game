/* grab some stuff from the scenario: */
use t_util

/* a new table to put new symbols in: */
private tp_frog CreateTable().
use tp_frog

/* the routine which Frog executes on each "step": */
define tp_frog proc frogStep()void:
    int direction;

    if not ClientsActive() then
	After(60, frogStep);
    else
	direction := Random(12);
	if TryToMove(direction) then
	    MachineMove(direction);
	fi;
	After(10 + Random(10), frogStep);
    fi;
corp;

/* the routine used to start up Frog */
define tp_frog proc frogStart()void:

    After(10, frogStep);
corp;

/* the routine used to restart Frog: */
define tp_frog proc frogRestart()void:

    After(10, frogStep);
corp;

/* the routine to handle Frog overhearing normal speech */
define tp_frog proc frogHear(string what)void:
    string speaker, word;

    speaker := SetSay(what);
    /* Frog croaks if he hears his name */
    while
	word := GetWord();
	word ~= ""
    do
	if word == "Frog" then
	    DoSay("Croak!");
	fi;
    od;
corp;

/* the routine to handle someone whispering to Frog: */
define tp_frog proc frogWhispered(string what)void:
    string whisperer, word;

    whisperer := SetWhisperMe(what);
    /* Frog ribbets if he is whispered his name */
    while
	word := GetWord();
	word ~= ""
    do
	if word == "Frog" then
	    DoSay("Ribbet!");
	fi;
    od;
corp;

/* the routine to handle Frog overhearing a whisper: */
define tp_frog proc frogOverhear(string what)void:
    string whisperer, whisperedTo, word;

    whisperer := SetWhisperOther(what);
    whisperedTo := GetWord();
    /* Frog simply blabs out loud whatever he overhears. */
    DoSay(whisperer + " whispered to " + whisperedTo + ": " + GetTail());
corp;

/* the routine to see someone doing a pose: */
define tp_frog proc frogSaw(string what)void:
    string poser, word;

    SetTail(what);
    poser := GetWord();
    /* Frog gets excited if you reference him in a pose. */
    while
	word := GetWord();
	word ~= ""
    do
	if word == "Frog" then
	    Pose("jumps up and down excitedly.");
	fi;
    od;
corp;

/* the function to create the Frog: */
define tp_frog proc createFrog(thing where)void:
    thing frog;

    frog := CreateThing(nil);
    CreateMachine("Frog", frog, where, frogStart);
    ignore SetMachineActive(frog, frogRestart);
    ignore SetMachineSay(frog, frogHear);
    ignore SetMachineWhisperMe(frog, frogWhispered);
    ignore SetMachineWhisperOther(frog, frogOverhear);
    ignore SetMachinePose(frog, frogSaw);
corp;

/* create Frog and start him up: */
createFrog(Here()).
