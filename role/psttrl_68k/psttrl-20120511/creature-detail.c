#include <stdio.h>
/* rand */
#include <stdlib.h>

#include "creature-detail.h"

int
creature_detail_get(int type, struct creature_detail *crd)
{
  if (crd == NULL)
  {
    fprintf(stderr, "creature_detail_get: crd is NULL\n");
    return 1;
  }

  (*crd).type = type;
  switch (type)
  {
  case CR_NOBODY:
    (*crd).name = "nobody";
    (*crd).symbol = "X";
    (*crd).description = "It is only for internal use.";
    (*crd).max_hp = 99;
    (*crd).strength = 0;
    break;
  case CR_SWORD_TESTER:
    (*crd).name = "sword tester";
    (*crd).symbol = "t";
    (*crd).description = "During a combat, if you wield a weapon,\n"
      "add 2 to your DEF and ATK.";
    (*crd).max_hp = 7;
    (*crd).strength = 7;
    break;
  case CR_BEE_SLAYER_SHMUPPER:
    /* shoot-em-up game grandmaster */
    (*crd).name = "bee-slayer shmupper";
    (*crd).symbol = "S";
    (*crd).description = "You dodge an attack to you.";
    (*crd).max_hp = 3;
    (*crd).strength = 5;
    break;
  case CR_SHMUPPER:
    /* shoot-em-up game fan */
    (*crd).name = "shmupper";
    (*crd).symbol = "s";
    (*crd).description = "You dodge an attack to you if opponent ATK is\n"
      "greater than your DEF.";
    (*crd).max_hp = 5;
    (*crd).strength = 7;
    break;
  case CR_ANCIENT_DRAGON:
    (*crd).name = "Ancient Dragon";
    (*crd).symbol = "D";
    (*crd).description = "During a combat, if the opponent wields a weapon,\n"
      "subtract 12 from opponent ATK.\n"
      "When your attack hits, subtract 12 from opponent HP.\n";
    (*crd).max_hp = 11;
    (*crd).strength = 11;
    break;
  case CR_MATURE_DRAGON:
    (*crd).name = "Mature Dragon";
    (*crd).symbol = "D";
    (*crd).description = "During a combat, if the opponent level is "
      "less than your level,\n"
      "subtract 8 from opponent DEF and ATK.";
    (*crd).max_hp = 9;
    (*crd).strength = 9;
    break;
  case CR_BABY_DRAGON:
    (*crd).name = "Baby Dragon";
    (*crd).symbol = "D";
    (*crd).description = "During a combat, if opponent HP is not full,\n"
      "subtract 4 from opponent DEF and ATK.";
    (*crd).max_hp = 7;
    (*crd).strength = 7;
    break;
  case CR_HEISENBUG:
    /* this is not a typo of Heisenberg
     * a bug which can't be reproduced reliably
     */
    (*crd).name = "heisenbug";
    (*crd).symbol = "H";
    (*crd).description = "During a combat, choose an integer from 0 "
      "through 5 randomly.\n"
      "Add it to your DEF and ATK.\n"
      "(0 and 5 can be chosen.)";
    (*crd).max_hp = 5;
    (*crd).strength = 5;
    break;
  case CR_LANGUAGE_LAWYER:
    (*crd).name = "language lawyer";
    (*crd).symbol = "l";
    (*crd).description = "When you attack, ignore the ability of "
      "opponent creature.\n"
      "When you are attacked, ignore the ability of opponent weapon.\n"
      "(The modifier of a weapon is still applied.)";
    (*crd).max_hp = 9;
    (*crd).strength = 6;
    break;
  case CR_RAT:
    (*crd).name = "rat";
    (*crd).symbol = "r";
    (*crd).description = "During a combat, if your HP is 5 or less,\n"
      "add 2 to your ATK.";
    (*crd).max_hp = 5;
    (*crd).strength = 6;
    break;
  case CR_GOBLIN:
    (*crd).name = "goblin";
    (*crd).symbol = "g";
    (*crd).description = "Your attack is critical if the opponent is goblin.";
    (*crd).max_hp = 6;
    (*crd).strength = 5;
    break;
  case CR_MAGE:
    (*crd).name = "mage";
    (*crd).symbol = "m";
    (*crd).description = "Your attack is accurate and critical "
      "if opponent DEF is\n"
      "9, 12 or 15.";
    (*crd).max_hp = 7;
    (*crd).strength = 7;
    break;
  case CR_FULL_STRENGTH_MAGE:
    (*crd).name = "full-strength mage";
    (*crd).symbol = "M";
    (*crd).description = "Your attack is critical.";
    (*crd).max_hp = 5;
    (*crd).strength = 4;
    break;
  case CR_BETRAYING_MASCOT:
    (*crd).name = "betraying mascot";
    (*crd).symbol = "Q";
    (*crd).description = "You dodge an attack to you if opponent ATK is "
      "21 or greater.\n"
      "During a combat, add 8 to opponent ATK.";
    (*crd).max_hp = 5;
    (*crd).strength = 6;
    break;
  case CR_TYRANT:
    (*crd).name = "tyrant";
    (*crd).symbol = "T";
    (*crd).description = "You can do a post-move attack.\n"
      "Your attack is accurate.";
    (*crd).max_hp = 7;
    (*crd).strength = 6;
    break;
  case CR_GRID_BUG:
    (*crd).name = "grid bug";
    (*crd).symbol = "x";
    (*crd).description = "You dodge an attack to you if the opponent is\n"
      "in a diagonal position.";
    (*crd).max_hp = 7;
    (*crd).strength = 7;
    break;
  case CR_OGRE:
    (*crd).name = "ogre";
    (*crd).symbol = "O";
    (*crd).description = "The opponent parries your attack.";
    (*crd).max_hp = 5;
    (*crd).strength = 11;
    break;
  case CR_MONK:
    (*crd).name = "monk";
    (*crd).symbol = "k";
    (*crd).description = "During a combat, if you don't wield a weapon,\n"
      "add 6 to your DEF and ATK.";
    (*crd).max_hp = 8;
    (*crd).strength = 8;
    break;
  case CR_MILLENNIUM_MONK:
    /* a monk who survived the end of the century */
    (*crd).name = "millennium monk";
    (*crd).symbol = "K";
    (*crd).description = "You can do a post-move attack if you don't "
      "wield a weapon.\n"
      "During a combat, if you don't wield a weapon,\n"
      "add 9 to your ATK.";
    (*crd).max_hp = 8;
    (*crd).strength = 8;
    break;
  case CR_GLASS_GOLEM:
    (*crd).name = "glass golem";
    (*crd).symbol = "G";
    (*crd).description = "An attack to you is critical.";
    (*crd).max_hp = 12;
    (*crd).strength = 12;
    break;
  case CR_LEAD_GOLEM:
    (*crd).name = "lead golem";
    (*crd).symbol = "L";
    (*crd).description = "An attack to you can't be critical.\n"
      "Your action takes twice time as usual.";
    (*crd).max_hp = 12;
    (*crd).strength = 12;
    break;
  case CR_HACKER:
    (*crd).name = "hacker";
    (*crd).symbol = "h";
    (*crd).description = "Your attack is accurate.\n"
      "During a combat, if opponent level is 4 or greater,\n"
      "add 4 to your DEF and ATK.";
    (*crd).max_hp = 8;
    (*crd).strength = 8;
    break;
  case CR_BAT:
    (*crd).name = "bat";
    (*crd).symbol = "b";
    (*crd).description = "You can do a post-move attack.";
    (*crd).max_hp = 5;
    (*crd).strength = 5;
    break;
  case CR_BERSERKER:
    (*crd).name = "berserker";
    (*crd).symbol = "B";
    (*crd).description = "You parry an attack to you.\n"
      "During a combat, if your HP is not full,\n"
      "add 3 to your DEF and ATK.";
    (*crd).max_hp = 9;
    (*crd).strength = 7;
    break;
  case CR_SAMURAI:
    (*crd).name = "samurai";
    (*crd).symbol = "I";
    (*crd).description = "Your attack is critical if your STR is\n"
      "equal to or greater than opponent HP.\n"
      "The opponent dodges your attack if the opponent is acid blob.";
    (*crd).max_hp = 8;
    (*crd).strength = 8;
    break;
  case CR_IMP:
    (*crd).name = "imp";
    (*crd).symbol = "i";
    (*crd).description = "During a combat, if you wield a weapon,\n"
      "apply its modifier again.";
    (*crd).max_hp = 6;
    (*crd).strength = 6;
    break;
  case CR_AMULET_RETRIEVER:
    (*crd).name = "amulet retriever";
    (*crd).symbol = "A";
    (*crd).description = "During a combat, add the depth of "
      "the current floor\n"
      "to your DEF and ATK.";
    (*crd).max_hp = 5;
    (*crd).strength = 5;
    break;
  case CR_CAT:
    (*crd).name = "cat";
    (*crd).symbol = "c";
    (*crd).description = "Your attack can't be reflected.";
    (*crd).max_hp = 8;
    (*crd).strength = 8;
    break;
  case CR_ACID_BLOB:
    (*crd).name = "acid blob";
    (*crd).symbol = "a";
    (*crd).description = "At the end of a combat, subtract 1 from "
      "opponent HP.";
    (*crd).max_hp = 10;
    (*crd).strength = 3;
    break;
  case CR_WARLORD:
    (*crd).name = "warlord";
    (*crd).symbol = "W";
    (*crd).description = "You can do a post-move attack.\n"
      "You dodge a post-move attack.\n"
      "You dodge an attack to you if opponent HP is not full.";
    (*crd).max_hp = 7;
    (*crd).strength = 6;
    break;
  case CR_NURUPO:
    /* Japanese personification of NullPointerException in Java */
    (*crd).name = "nurupo";
    (*crd).symbol = "n";
    (*crd).description = "When your attack hits, if the opponent is alive,\n"
      "teleport the opponent to a random position on its current floor.";
    (*crd).max_hp = 8;
    (*crd).strength = 8;
    break;
  case CR_CHARIOT:
    (*crd).name = "chariot";
    (*crd).symbol = "C";
    (*crd).description = "Your attack is accurate if opponent HP is full.\n"
      "During a combat, if opponent HP is not full,\n"
      "subtract 4 from your ATK.";
    (*crd).max_hp = 8;
    (*crd).strength = 10;
    break;
  case CR_VAMPIRE:
    (*crd).name = "vampire";
    (*crd).symbol = "V";
    (*crd).description = "During a combat, add your HP to your DEF and ATK.\n"
      "When your attack hits, add 1 to your HP.";
    (*crd).max_hp = 3;
    (*crd).strength = 6;
    break;
  case CR_WISP:
    (*crd).name = "wisp";
    (*crd).symbol = "w";
    (*crd).description = "You dodge an attack to you if opponent STR is\n"
      "equal to or less than your MHP.";
    (*crd).max_hp = 7;
    (*crd).strength = 7;
    break;
  default:
    (*crd).name = "undefined creature";
    (*crd).symbol = "X";
    (*crd).description = "It indicates this game has a bug.";
    (*crd).max_hp = 99;
    (*crd).strength = 0;
    return 1;
    break;
  }

  return 0;
}
