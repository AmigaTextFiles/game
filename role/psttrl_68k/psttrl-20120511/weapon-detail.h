#ifndef __PSTTRL_WEAPON_DETAIL_H__
#define __PSTTRL_WEAPON_DETAIL_H__

struct weapon_detail
{
  int which;
  const char *name;
  const char *description;
  int defense;
  int attack;
};

#define WP_EMPTY_HAND 0
#define WP_IRON_SWORD 1
#define WP_DAGGER 2
#define WP_BUCKLER 3
#define WP_WAND_OF_SUN 4
#define WP_WAND_OF_MOON 5
#define WP_HAMMER_OF_JUSTICE 6
#define WP_SKULL_BOMB 7
#define WP_ROGUE_SLAYER 8
#define WP_BANANA_PEEL 9
#define WP_KATANA 10
#define WP_PARTICLE_CANNON 11
#define WP_BLACKJACK 12
#define WP_IKASAMA_BLADE 13
#define WP_REPULSION_FIELD 14
#define WP_RAPIER 15
#define WP_GOLD_CROWN 16
#define WP_BIKINI_ARMOR 17
#define WP_OILSKIN_CLOAK 18
#define WP_GIANT_SPIKED_CLUB 19
#define WP_LANCE 20
#define WP_SHOTGUN 21
#define WP_ALL_IN_ONE_KNIFE 22
#define WP_PLATE_MAIL 23
#define WP_RING_OF_RAGE 24
#define WP_ASSASSIN_ROBE 25
#define WP_WHIP 26
#define WP_MAGIC_CANDLE 27
#define WP_POISON_NEEDLE 28
#define WP_MACE 29
#define WP_CRYSTAL_SPEAR 30
#define WP_WOOD_STAKE 31
#define WP_BOOMERANG 32
#define WP_TONFA 33
#define WP_BROKEN_HOURGLASS 34
#define WP_BOFH_LART 35
#define WP_SWORD_OF_MIXING 36
#define WP_COSMIC_CONTRACT 37
#define WP_SHOVEL 38

#define NUM_WEAPON 39

int weapon_detail_get(int which, struct weapon_detail *wpd);

#endif /* not __PSTTRL_WEAPON_DETAIL_H__ */
