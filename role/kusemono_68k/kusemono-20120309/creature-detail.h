#ifndef __KSMN_CREATURE_DETAIL_H__
#define __KSMN_CREATURE_DETAIL_H__

struct creature_detail
{
  int type;
  const char *name;
  const char *symbol;
  const char *description;
  int max_hp;
  int power_melee;
};

#define CR_PLAYER 0
#define CR_SOLDIER 1
#define CR_QUEEN 2
#define CR_EXPLORER 3

#define NUM_CREATURE 4

int creature_detail_get(int type, struct creature_detail *crd);

#endif /* not __KSMN_CREATURE_DETAIL_H__ */
