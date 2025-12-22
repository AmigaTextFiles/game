#ifndef __KSMN_CREATURE_DETAIL_H__
#define __KSMN_CREATURE_DETAIL_H__

struct creature_detail
{
  int type;
  const char *name;
  const char *symbol;
  const char *description;
  int max_hp;
  int strength;
};

#define CR_NOBODY 0
#define CR_SWORD_TESTER 1
#define CR_BEE_SLAYER_SHMUPPER 2
#define CR_SHMUPPER 3
#define CR_ANCIENT_DRAGON 4
#define CR_MATURE_DRAGON 5
#define CR_BABY_DRAGON 6
#define CR_HEISENBUG 7
#define CR_LANGUAGE_LAWYER 8
#define CR_RAT 9
#define CR_GOBLIN 10
#define CR_MAGE 11
#define CR_FULL_STRENGTH_MAGE 12
#define CR_BETRAYING_MASCOT 13
#define CR_TYRANT 14
#define CR_GRID_BUG 15
#define CR_OGRE 16
#define CR_MONK 17
#define CR_MILLENNIUM_MONK 18
#define CR_GLASS_GOLEM 19
#define CR_LEAD_GOLEM 20
#define CR_HACKER 21
#define CR_BAT 22
#define CR_BERSERKER 23
#define CR_SAMURAI 24
#define CR_IMP 25
#define CR_AMULET_RETRIEVER 26
#define CR_CAT 27
#define CR_ACID_BLOB 28
#define CR_WARLORD 29
#define CR_NURUPO 30
#define CR_CHARIOT 31
#define CR_VAMPIRE 32
#define CR_WISP 33

#define NUM_CREATURE 34

int creature_detail_get(int type, struct creature_detail *crd);

#endif /* not __KSMN_CREATURE_DETAIL_H__ */
