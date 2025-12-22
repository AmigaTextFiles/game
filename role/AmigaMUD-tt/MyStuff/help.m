/*
 * Help.m
 */

/**** Foreward
* In the AmigaMUD 1.0 standard scenario, the help is rather limited.
* This file redefines the help system, so that "help" gives you the
* old help, but you can also "help <word>" to get information on
* that word.  These help texts are defined as action in the t_help
* table.
****/

use t_util
use tp_verbs

DeleteWord(G,"?").
DeleteWord(G,"help").
ignore DeleteSymbol(LookupTable(PrivateTable(),"tp_verbs"),"v_help").

public t_help CreateTable().

define tp_verbs proc v_help()bool:
  string word;
  action a;
  int i;

  word:=GetWord();
  if word="" then
    Print("Standard commands available in this starter dungeon:\n"
    "    [go] north/south.../n/s/...enter/exit/up/down...\n"
    "    look [around]; look at XXX, YYY, ...; examine XXX; look <direction>\n"
    "    inventory/inv/i\n"
    "    pick up XXX, YYY, ...; get/g XXX, YYY, ...\n"
    "    put/p [down] XXX, YYY, ...; drop XXX, YYY, ...\n"
    "    say XXX; \"xxx; smile, wave, ...; quests [who]\n"
    "    quit; verbose; terse; password; prompt; name; who; height; width;\n"
    "    play; erase; eat; use; wear; read; touch; smell; open; close;\n"
    "    push; pull; turn; chat; pose; echo; follow; etc.\n"
    "plus others as the game features require.\n");
    true
  else
    a:=LookupAction(t_help,word);
    if a~=nil then
      call(a, void)();
      true
    else
      i:=FindAnyWord(G,word);
      if i~=0 then
	Print("There is no help on the word "+word+", although it is defined in the grammer.\n");
      else
	Print("The word "+word+", is not defined.\n");
      fi;
      false
    fi
  fi
corp;

VerbTail(G, "help", v_help).
Synonym(G, "help", "?").


/**** Some basic help texts ****/

define t_help proc help()void:
  Paginate("HELP\n"
    "This command can give you more information about other commands.  "
    "If there is no help on a command, it will tell you whether or not "
    "it exists in the grammar."
    "\n\nSynonyms : ?"
    "\n\nSee also : WORDS"
  );
corp.

define t_help proc words()void:
  Paginate("WORDS\n"
    "The words command will display a complete list of standard commands, "
    "but not what they do or how to use them."
    "\n\nSee also : HELP."
  );
corp.

define t_help proc movement()void:
  Paginate("MOVEMENT\n"
    "AmigaMUD has then eight standard compass directions, plus up and "
    "down.  In many locations, you may also be able to go 'in' and 'out'."
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc north()void:
  Paginate("NORTH\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc south()void:
  Paginate("SOUTH\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc east()void:
  Paginate("EAST\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc west()void:
  Paginate("WEST\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc northeast()void:
  Paginate("NORTHEAST\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc southeast()void:
  Paginate("SOUTHEAST\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc southwest()void:
  Paginate("SOUTHWEST\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc northwest()void:
  Paginate("NORTHWEST\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc up()void:
  Paginate("UP\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc down()void:
  Paginate("DOWN\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc in()void:
  Paginate("IN\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.

define t_help proc out()void:
  Paginate("OUT\n"
    " -- type something useful in here --"
    "\n\nSee also : NORTH, SOUTH, EAST, WEST, NORTHEAST, SOUTHEAST, "
    "SOUTHWEST, NORTHWEST, UP, DOWN, IN, OUT"
  );
corp.


/****/

unuse t_util
unuse tp_verbs

/**** End of file ****/

