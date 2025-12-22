#include <stdio.h>

#include "weapon-detail.h"

int
weapon_detail_get(int which, struct weapon_detail *wpd)
{
  if (wpd == NULL)
  {
    fprintf(stderr, "weapon_detail_get: wpd is NULL\n");
    return 1;
  }

  (*wpd).which = which;
  switch (which)
  {
  case WP_EMPTY_HAND:
    (*wpd).name = "empty hand";
    (*wpd).description = "It is only for internal use.";
    (*wpd).defense = 0;
    (*wpd).attack = 0;
    break;
  case WP_IRON_SWORD:
    (*wpd).name = "iron sword";
    (*wpd).description = "During a combat, if you are sword tester,\n"
      "add 1 to your DEF and ATK.";
    (*wpd).defense = 4;
    (*wpd).attack = 4;
    break;
  case WP_DAGGER:
    (*wpd).name = "dagger";
    (*wpd).description = "You can do a post-move attack.";
    (*wpd).defense = 2;
    (*wpd).attack = 3;
    break;
  case WP_BUCKLER:
    (*wpd).name = "buckler";
    (*wpd).description = "You parry an attack to you if your HP is full.";
    (*wpd).defense = 6;
    (*wpd).attack = 3;
    break;
  case WP_WAND_OF_SUN:
    (*wpd).name = "wand of sun";
    (*wpd).description = "Your attack is accurate and critical "
      "if opponent DEF is\n"
      "8, 11, 14 or 17.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_WAND_OF_MOON:
    (*wpd).name = "wand of moon";
    (*wpd).description = "Your attack is accurate and critical "
      "if opponent DEF is\n"
      "7, 10, 13 or 16.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_HAMMER_OF_JUSTICE:
    (*wpd).name = "hammer of justice";
    (*wpd).description = "Your attack is critical if opponent level is\n"
      "greater than your level.\n"
      "You parry an attack to you if opponent level is\n"
      "less than your level.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_SKULL_BOMB:
    (*wpd).name = "skull bomb";
    (*wpd).description = "You dodge an attack to you if opponent ATK is\n"
      "equal to your DEF.";
    (*wpd).defense = 4;
    (*wpd).attack = 4;
    break;
  case WP_ROGUE_SLAYER:
    (*wpd).name = "rogue slayer";
    (*wpd).description = "Your attack is critical if the opponent is "
      "not goblin.";
    (*wpd).defense = 1;
    (*wpd).attack = 1;
    break;
  case WP_BANANA_PEEL:
    (*wpd).name = "banana peel";
    (*wpd).description = "The opponent dodges your attack.";
    (*wpd).defense = 7;
    (*wpd).attack = 7;
    break;
  case WP_KATANA:
    (*wpd).name = "katana";
    (*wpd).description = "During a combat, if opponent MHP is "
      "10 or greater,\n"
      "add 4 to your ATK.";
    (*wpd).defense = 3;
    (*wpd).attack = 5;
    break;
  case WP_PARTICLE_CANNON:
    (*wpd).name = "particle cannon";
    (*wpd).description = "Your attack is accurate if your HP is full.\n"
      "During a combat, add your HP to your ATK.";
    (*wpd).defense = 1;
    (*wpd).attack = 3;
    break;
  case WP_BLACKJACK:
    (*wpd).name = "blackjack";
    (*wpd).description = "You reflect an attack to you if the total of\n"
      "opponent MHP and STR is 22 or greater.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_IKASAMA_BLADE:
    /* this is meant to be absurd */
    (*wpd).name = "ikasama blade";
    (*wpd).description = "Your attack is accurate.\n"
      "When your attack hits, if your ATK is 1 or greater,\n"
      "subtrack your ATK from opponent HP.";
    (*wpd).defense = 8;
    (*wpd).attack = 8;
    break;
  case WP_REPULSION_FIELD:
    (*wpd).name = "repulsion field";
    (*wpd).description = "If an attack to you is accurate and "
      "if there is\n"
      "no attempt to dodge or parry it, you reflect the attack.";
    (*wpd).defense = 4;
    (*wpd).attack = 3;
    break;
  case WP_RAPIER:
    (*wpd).name = "rapier";
    (*wpd).description = "Your attack is accurate.";
    (*wpd).defense = 3;
    (*wpd).attack = 4;
    break;
  case WP_GOLD_CROWN:
    (*wpd).name = "gold crown";
    (*wpd).description = "During a combat, add your level to "
      "your DEF and ATK.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_BIKINI_ARMOR:
    (*wpd).name = "bikini armor";
    (*wpd).description = "An attack to you can't be critical.\n"
      "During a combat, add your HP to your DEF.\n"
      "When an attack to you hits, subtract 1 from your HP.";
    (*wpd).defense = 0;
    (*wpd).attack = 2;
    break;
  case WP_OILSKIN_CLOAK:
    /* it fits very tightly */
    (*wpd).name = "oilskin cloak";
    (*wpd).description = "You dodge an attack to you if opponent ATK is\n"
      "greater than your DEF by 3 or greater.\n"
      "An attack to you can't be critical if opponent ATK is\n"
      "less than your DEF by 3 or greater.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_GIANT_SPIKED_CLUB:
    (*wpd).name = "giant spiked club";
    (*wpd).description = "The opponent dodges your attack if your STR is "
      "10 or less.";
    (*wpd).defense = 4;
    (*wpd).attack = 7;
    break;
  case WP_LANCE:
    (*wpd).name = "lance";
    (*wpd).description = "You can do a post-move attack.\n"
      "During a combat, if the attack is a post-move attack,\n"
      "add 4 to your ATK.";
    (*wpd).defense = 2;
    (*wpd).attack = 1;
    break;
  case WP_SHOTGUN:
    (*wpd).name = "shotgun";
    (*wpd).description = "Your attack is accurate.\n"
      "During a combat, if the attack is not a post-move attack,\n"
      "add 4 to your ATK.";
    (*wpd).defense = 3;
    (*wpd).attack = 2;
    break;
  case WP_ALL_IN_ONE_KNIFE:
    (*wpd).name = "all-in-one knife";
    (*wpd).description = "Your attack is accurate.\n"
      "An attack to you can't be critical.\n"
      "During a combat, if opponent level is equal to your level,\n"
      "add 2 to your DEF and ATK.";
    (*wpd).defense = 1;
    (*wpd).attack = 1;
    break;
  case WP_PLATE_MAIL:
    (*wpd).name = "plate mail";
    (*wpd).description = "During a combat, add your STR to your DEF.";
    (*wpd).defense = 2;
    (*wpd).attack = 3;
    break;
  case WP_RING_OF_RAGE:
    (*wpd).name = "ring of rage";
    (*wpd).description = "You parry an attack to you.\n"
      "During a combat, if your HP is not full, add the difference\n"
      "to your ATK.";
    (*wpd).defense = 6;
    (*wpd).attack = 1;
    break;
  case WP_ASSASSIN_ROBE:
    (*wpd).name = "assassin robe";
    (*wpd).description = "Your attack is critical if opponent HP is odd.\n"
      "You dodge an attack to you if opponent HP is even.";
    (*wpd).defense = 2;
    (*wpd).attack = 2;
    break;
  case WP_WHIP:
    (*wpd).name = "whip";
    (*wpd).description = "You dodge a post-move attack.";
    (*wpd).defense = 3;
    (*wpd).attack = 4;
    break;
  case WP_MAGIC_CANDLE:
    /* "A candle is brightest in its last." --- Japanese proverb */
    (*wpd).name = "magic candle";
    (*wpd).description = "You can do a post-move attack if your level is "
      "1 or less.\n"
      "During a combat, if your level is 3 or less,\n"
      "add 3 to your DEF and ATK.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_POISON_NEEDLE:
    (*wpd).name = "poison needle";
    (*wpd).description = "You can do a post-move attack.\n"
      "Your attack is critical if opponent DEF is\n"
      "greater than your ATK by 5 or greater.";
    (*wpd).defense = 1;
    (*wpd).attack = 0;
    break;
  case WP_MACE:
    (*wpd).name = "mace";
    (*wpd).description = "Your attack can't be reflected.";
    (*wpd).defense = 4;
    (*wpd).attack = 4;
    break;
  case WP_CRYSTAL_SPEAR:
    (*wpd).name = "crystal spear";
    (*wpd).description = "Your attack can't be reflected.\n"
      "During a combat, count the number of walls which are "
      "adjacent to you.\n"
      "Add it to your ATK.";
    (*wpd).defense = 3;
    (*wpd).attack = 2;
    break;
  case WP_WOOD_STAKE:
    (*wpd).name = "wood stake";
    (*wpd).description = "When your attack hits, if the attack "
      "can't be critical,\n"
      "subtract 6 from opponent level and HP.\n"
      "(This level loss is permanent.)";
    (*wpd).defense = 3;
    (*wpd).attack = 4;
    break;
  case WP_BOOMERANG:
    (*wpd).name = "boomerang";
    (*wpd).description = "During a combat, if there is no wall "
      "which is adjacent to you,\n"
      "add 4 to your DEF and ATK.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_TONFA:
    (*wpd).name = "tonfa";
    (*wpd).description = "During a combat, if the attack is "
      "a post-move attack,\n"
      "add 4 to your DEF.  Otherwise, add 4 to your ATK.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_BROKEN_HOURGLASS:
    (*wpd).name = "broken hourglass";
    (*wpd).description = "During a combat, subtract opponent level from "
      "opponent DEF and ATK.\n"
      "During a combat, if opponent level is greater than your level,\n"
      "add opponent level to your DEF and ATK.";
    (*wpd).defense = 2;
    (*wpd).attack = 2;
    break;
  case WP_BOFH_LART:
    /* BOFH: Bastard Operator From Hell
     * LART: Luser Attitude Readjustment Tool
     */
    (*wpd).name = "bofh lart";
    (*wpd).description = "Your attack is critical if opponent DEF is "
      "18 or greater.\n"
      "You dodge an attack to you if opponent ATK is 18 or greater.";
    (*wpd).defense = 3;
    (*wpd).attack = 3;
    break;
  case WP_SWORD_OF_MIXING:
    (*wpd).name = "sword of mixing";
    (*wpd).description = "During a combat, exchange opponent DEF and "
      "opponent ATK.\n"
      "This is applied after other modification of DEF and ATK.";
    (*wpd).defense = 4;
    (*wpd).attack = 4;
    break;
  case WP_COSMIC_CONTRACT:
    (*wpd).name = "cosmic contract";
    (*wpd).description = "You can do a post-move attack.\n"
      "When you attack, exchange your ATK and "
      "opponent ATK.\n"
      "This is applied after other modification of DEF and ATK.";
    (*wpd).defense = 0;
    (*wpd).attack = 0;
    break;
  case WP_SHOVEL:
    (*wpd).name = "shovel";
    (*wpd).description = "During a combat, if the opponent is between\n"
      "you and a wall, add 4 to your DEF and ATK.\n"
      "When your attack hits, if the opponent is alive,\n"
      "exchange your position and opponent position.";
    (*wpd).defense = 4;
    (*wpd).attack = 4;
    break;
  default:
    (*wpd).name = "undefined weapon";
    (*wpd).description = "It indicates this game has a bug.";
    (*wpd).defense = 0;
    (*wpd).attack = 0;
    return 1;
    break;
  }

  return 0;
}

