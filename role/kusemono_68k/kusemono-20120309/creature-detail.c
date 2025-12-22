#include <stdio.h>
/* rand */
#include <stdlib.h>

#include "util.h"

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
  case CR_PLAYER:
    (*crd).name = "player";
    (*crd).symbol = "@";
    (*crd).description = "It can stab unnoticed enemies.";
    (*crd).max_hp = 18;
    (*crd).power_melee = 4;
    break;
  case CR_SOLDIER:
    (*crd).name = "soldier";
    (*crd).symbol = "s";
    (*crd).description = "(It is a general-purpose low-cost worker.)";
    (*crd).max_hp = 11;
    (*crd).power_melee = 4;
    break;
  case CR_QUEEN:
    (*crd).name = "Queen";
    (*crd).symbol = "Q";
    (*crd).description = "Kill it to win the game.";
    (*crd).max_hp = 40;
    (*crd).power_melee = 7;
    break;
  case CR_EXPLORER:
    (*crd).name = "explorer";
    (*crd).symbol = "e";
    (*crd).description = "(It usually works outside.\n"
      "Now it is returning to the hive.)";
    (*crd).max_hp = 15;
    (*crd).power_melee = 5;
    break;
  default:
    (*crd).name = "undefined creature";
    (*crd).symbol = "X";
    (*crd).description = "It indicates this game has a bug.";
    (*crd).max_hp = 99;
    (*crd).power_melee = 0;
    return 1;
    break;
  }

  return 0;
}
