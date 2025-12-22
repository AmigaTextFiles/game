#include <stdio.h>
/* rand */
#include <stdlib.h>

#include "world.h"
#include "judge.h"
#include "combat.h"
#include "creature-detail.h"
#include "dungeon.h"
#include "weapon-detail.h"

#include "creature-effect.h"

static int sword_tester(world *wp, combat_judge *cbtjp, int phase);
static int bee_slayer_shmupper(world *wp, combat_judge *cbtjp, int phase);
static int shmupper(world *wp, combat_judge *cbtjp, int phase);
static int ancient_dragon(world *wp, combat_judge *cbtjp, int phase);
static int mature_dragon(world *wp, combat_judge *cbtjp, int phase);
static int baby_dragon(world *wp, combat_judge *cbtjp, int phase);
static int heisenbug(world *wp, combat_judge *cbtjp, int phase);
static int language_lawyer(world *wp, combat_judge *cbtjp, int phase);
static int rat(world *wp, combat_judge *cbtjp, int phase);
static int goblin(world *wp, combat_judge *cbtjp, int phase);
static int mage(world *wp, combat_judge *cbtjp, int phase);
static int full_strength_mage(world *wp, combat_judge *cbtjp, int phase);
static int betraying_mascot(world *wp, combat_judge *cbtjp, int phase);
static int tyrant(world *wp, combat_judge *cbtjp, int phase);
static int grid_bug(world *wp, combat_judge *cbtjp, int phase);
static int ogre(world *wp, combat_judge *cbtjp, int phase);
static int monk(world *wp, combat_judge *cbtjp, int phase);
static int millennium_monk(world *wp, combat_judge *cbtjp, int phase);
static int glass_golem(world *wp, combat_judge *cbtjp, int phase);
static int lead_golem(world *wp, combat_judge *cbtjp, int phase);
static int hacker(world *wp, combat_judge *cbtjp, int phase);
static int berserker(world *wp, combat_judge *cbtjp, int phase);
static int samurai(world *wp, combat_judge *cbtjp, int phase);
static int imp(world *wp, combat_judge *cbtjp, int phase);
static int amulet_retriever(world *wp, combat_judge *cbtjp, int phase);
static int cat(world *wp, combat_judge *cbtjp, int phase);
static int acid_blob(world *wp, combat_judge *cbtjp, int phase);
static int warlord(world *wp, combat_judge *cbtjp, int phase);
static int nurupo(world *wp, combat_judge *cbtjp, int phase);
static int chariot(world *wp, combat_judge *cbtjp, int phase);
static int vampire(world *wp, combat_judge *cbtjp, int phase);
static int wisp(world *wp, combat_judge *cbtjp, int phase);

static int
sword_tester(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    { 
      my = cbtjp->attacker;
    }
    else
    { 
      my = cbtjp->defender;
    }
    if (my->weapon_which > 0)
    {
      my->defense += 2;
      my->attack += 2;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
bee_slayer_shmupper(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    cbtjp->dodge = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
shmupper(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    my = cbtjp->defender;
    your = cbtjp->attacker;
    if (your->attack > my->defense)
    { 
      cbtjp->dodge = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
ancient_dragon(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    { 
      your = cbtjp->defender;
    }
    else
    { 
      your = cbtjp->attacker;
    }
    if (your->weapon_which > 0)
    {
      your->attack -= 12;
    }
    break;
  case CBT_HIT_ATTACKER:
    your = cbtjp->defender;
    if (!combat_stat_is_dead(your))
    { 
      your->hp -= 12;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
mature_dragon(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
      your = cbtjp->defender;
    }
    else
    {
      my = cbtjp->defender;
      your = cbtjp->attacker;
    }
    if (your->level < my->level)
    {
      your->attack -= 8;
      your->defense -= 8;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
baby_dragon(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      your = cbtjp->defender;
    }
    else
    {
      your = cbtjp->attacker;
    }
    if (your->hp < your->max_hp)
    {
      your->attack -= 4;
      your->defense -= 4;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
heisenbug(world *wp, combat_judge *cbtjp, int phase)
{
  int n;
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
    }
    else
    {
      my = cbtjp->defender;
    }
    n = rand() % 6;
    my->defense += n;
    my->attack += n;
    break;
  default:
    break;
  }

  return 0;
}

static int
language_lawyer(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_VETO_ATTACKER:
    cbtjp->veto_defender_creature = 1;
    break;
  case CBT_VETO_DEFENDER:
    cbtjp->veto_attacker_weapon = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
rat(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
    }
    else
    {
      my = cbtjp->defender;
    }
    if (my->hp <= 5)
    { 
      my->attack += 2;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
goblin(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    your = cbtjp->defender;
    if (your->creature_type == CR_GOBLIN)
    {
      cbtjp->critical = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
mage(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    your = cbtjp->defender;
    if ((your->defense == 9)
        || (your->defense == 12)
        || (your->defense == 15))
    {
      cbtjp->accurate = 1;
      cbtjp->critical = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
full_strength_mage(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    cbtjp->critical = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
betraying_mascot(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      your = cbtjp->defender;
    }
    else
    {
      your = cbtjp->attacker;
    }
    your->attack += 8;
    break;
  case CBT_DODGE_DEFENDER:
    your = cbtjp->attacker;
    if (your->attack >= 21)
    {
      cbtjp->dodge = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
tyrant(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    cbtjp->accurate = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
grid_bug(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    my = cbtjp->defender;
    your = cbtjp->attacker;
    if ((your->z == my->z)
        && (cardinal_direction(your->x, your->y, my->x, my->y) == 1))
    {
      cbtjp->dodge = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
ogre(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    cbtjp->parry = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
monk(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
    }
    else
    {
      my = cbtjp->defender;
    }
    if (my->weapon_which <= 0)
    {
      my->defense += 6;
      my->attack += 6;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
millennium_monk(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
    }
    else
    {
      my = cbtjp->defender;
    }
    if (my->weapon_which <= 0)
    {
      my->attack += 9;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
glass_golem(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    cbtjp->critical = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
lead_golem(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    cbtjp->cannot_critical = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
hacker(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
      your = cbtjp->defender;
    }
    else
    {
      my = cbtjp->defender;
      your = cbtjp->attacker;
    }
    if (your->level >= 4)
    {
      my->defense += 4;
      my->attack += 4;
    }
    break;
  case CBT_DODGE_ATTACKER:
    cbtjp->accurate = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
berserker(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
    }
    else
    {
      my = cbtjp->defender;
    }
    if (my->hp < my->max_hp)
    {
      my->defense += 3;
      my->attack += 3;
    }
    break;
  case CBT_DODGE_DEFENDER:
    cbtjp->parry = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
samurai(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    my = cbtjp->attacker;
    your = cbtjp->defender;
    if (my->strength >= your->hp)
    {
      cbtjp->critical = 1;
    }
    if (your->creature_type == CR_ACID_BLOB)
    {
      cbtjp->dodge = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
imp(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  struct weapon_detail wpd;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
    }
    else
    {
      my = cbtjp->defender;
    }
    if (my->weapon_which > 0)
    {
      weapon_detail_get(my->weapon_which, &wpd);
      my->defense += wpd.defense;
      my->attack += wpd.attack;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
amulet_retriever(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
    }
    else
    {
      my = cbtjp->defender;
    }
    my->defense += my->z;
    my->attack += my->z;
    break;
  default:
    break;
  }

  return 0;
}

static int
cat(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    cbtjp->cannot_reflect = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
acid_blob(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_END_ATTACKER:
  case CBT_END_DEFENDER:
    if (phase == CBT_END_ATTACKER)
    {
      your = cbtjp->defender;
    }
    else
    {
      your = cbtjp->attacker;
    }
    if (!combat_stat_is_dead(your))
    {
      your->hp -= 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
warlord(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    your = cbtjp->attacker;
    if (cbtjp->post_move_attack)
    { 
      cbtjp->dodge = 1;
    }
    if (your->hp < your->max_hp)
    { 
      cbtjp->dodge = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
nurupo(world *wp, combat_judge *cbtjp, int phase)
{
  int dest_x_your;
  int dest_y_your;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_HIT_ATTACKER:
    your = cbtjp->defender;
    if (!combat_stat_is_dead(your))
    {
      find_open_floor(wp, your->z, &dest_x_your, &dest_y_your);
      your->x = dest_x_your;
      your->y = dest_y_your;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
chariot(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
      your = cbtjp->defender;
    }
    else
    {
      my = cbtjp->defender;
      your = cbtjp->attacker;
    }
    if (your->hp < your->max_hp)
    {
      my->attack -= 4;
    }
    break;
  case CBT_DODGE_ATTACKER:
    your = cbtjp->defender;
    if (your->hp >= your->max_hp)
    { 
      cbtjp->accurate = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
vampire(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_BUFF_ATTACKER:
  case CBT_BUFF_DEFENDER:
    if (phase == CBT_BUFF_ATTACKER)
    {
      my = cbtjp->attacker;
    }
    else
    {
      my = cbtjp->defender;
    }
    my->defense += my->hp;
    my->attack += my->hp;
    break;
  case CBT_HIT_ATTACKER:
    my = cbtjp->attacker;
    if (!combat_stat_is_dead(my))
    {
      my->hp += 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
wisp(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    my = cbtjp->defender;
    your = cbtjp->attacker;
    if (your->strength <= my->max_hp)
    {
      cbtjp->dodge = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

int
creature_effect_init(world *wp)
{
  if (wp == NULL)
  {
    fprintf(stderr, "creature_effect_init: wp is NULL\n");
    return 1;
  }

  wp->creature_effect_func[CR_SWORD_TESTER] = &sword_tester;
  wp->creature_effect_func[CR_BEE_SLAYER_SHMUPPER] = &bee_slayer_shmupper;
  wp->creature_effect_func[CR_SHMUPPER] = &shmupper;
  wp->creature_effect_func[CR_ANCIENT_DRAGON] = &ancient_dragon;
  wp->creature_effect_func[CR_MATURE_DRAGON] = &mature_dragon;
  wp->creature_effect_func[CR_BABY_DRAGON] = &baby_dragon;
  wp->creature_effect_func[CR_HEISENBUG] = &heisenbug;
  wp->creature_effect_func[CR_LANGUAGE_LAWYER] = &language_lawyer;
  wp->creature_effect_func[CR_RAT] = &rat;
  wp->creature_effect_func[CR_GOBLIN] = &goblin;
  wp->creature_effect_func[CR_MAGE] = &mage;
  wp->creature_effect_func[CR_FULL_STRENGTH_MAGE] = &full_strength_mage;
  wp->creature_effect_func[CR_BETRAYING_MASCOT] = &betraying_mascot;
  wp->creature_effect_func[CR_TYRANT] = &tyrant;
  wp->creature_effect_func[CR_GRID_BUG] = &grid_bug;
  wp->creature_effect_func[CR_OGRE] = &ogre;
  wp->creature_effect_func[CR_MONK] = &monk;
  wp->creature_effect_func[CR_MILLENNIUM_MONK] = &millennium_monk;
  wp->creature_effect_func[CR_GLASS_GOLEM] = &glass_golem;
  wp->creature_effect_func[CR_LEAD_GOLEM] = &lead_golem;
  wp->creature_effect_func[CR_HACKER] = &hacker;
  wp->creature_effect_func[CR_BERSERKER] = &berserker;
  wp->creature_effect_func[CR_SAMURAI] = &samurai;
  wp->creature_effect_func[CR_IMP] = &imp;
  wp->creature_effect_func[CR_AMULET_RETRIEVER] = &amulet_retriever;
  wp->creature_effect_func[CR_CAT] = &cat;
  wp->creature_effect_func[CR_ACID_BLOB] = &acid_blob;
  wp->creature_effect_func[CR_WARLORD] = &warlord;
  wp->creature_effect_func[CR_NURUPO] = &nurupo;
  wp->creature_effect_func[CR_CHARIOT] = &chariot;
  wp->creature_effect_func[CR_VAMPIRE] = &vampire;
  wp->creature_effect_func[CR_WISP] = &wisp;

  return 0;
}
