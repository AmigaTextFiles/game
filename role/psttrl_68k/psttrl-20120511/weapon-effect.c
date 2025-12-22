#include <stdio.h>

#include "world.h"
#include "judge.h"
#include "combat.h"
#include "weapon-detail.h"
#include "creature-detail.h"
#include "grid-detail.h"
#include "dungeon.h"

#include "weapon-effect.h"

static int grid_is_wall(world *wp, int z, int x, int y);

static int iron_sword(world *wp, combat_judge *cbtjp, int phase);
static int buckler(world *wp, combat_judge *cbtjp, int phase);
static int wand_of_sun(world *wp, combat_judge *cbtjp, int phase);
static int wand_of_moon(world *wp, combat_judge *cbtjp, int phase);
static int hammer_of_justice(world *wp, combat_judge *cbtjp, int phase);
static int skull_bomb(world *wp, combat_judge *cbtjp, int phase);
static int rogue_slayer(world *wp, combat_judge *cbtjp, int phase);
static int banana_peel(world *wp, combat_judge *cbtjp, int phase);
static int katana(world *wp, combat_judge *cbtjp, int phase);
static int particle_cannon(world *wp, combat_judge *cbtjp, int phase);
static int blackjack(world *wp, combat_judge *cbtjp, int phase);
static int ikasama_blade(world *wp, combat_judge *cbtjp, int phase);
static int repulsion_field(world *wp, combat_judge *cbtjp, int phase);
static int rapier(world *wp, combat_judge *cbtjp, int phase);
static int gold_crown(world *wp, combat_judge *cbtjp, int phase);
static int bikini_armor(world *wp, combat_judge *cbtjp, int phase);
static int oilskin_cloak(world *wp, combat_judge *cbtjp, int phase);
static int giant_spiked_club(world *wp, combat_judge *cbtjp, int phase);
static int lance(world *wp, combat_judge *cbtjp, int phase);
static int shotgun(world *wp, combat_judge *cbtjp, int phase);
static int all_in_one_knife(world *wp, combat_judge *cbtjp, int phase);
static int plate_mail(world *wp, combat_judge *cbtjp, int phase);
static int ring_of_rage(world *wp, combat_judge *cbtjp, int phase);
static int assassin_robe(world *wp, combat_judge *cbtjp, int phase);
static int whip(world *wp, combat_judge *cbtjp, int phase);
static int magic_candle(world *wp, combat_judge *cbtjp, int phase);
static int poison_needle(world *wp, combat_judge *cbtjp, int phase);
static int mace(world *wp, combat_judge *cbtjp, int phase);
static int crystal_spear(world *wp, combat_judge *cbtjp, int phase);
static int wood_stake(world *wp, combat_judge *cbtjp, int phase);
static int boomerang(world *wp, combat_judge *cbtjp, int phase);
static int tonfa(world *wp, combat_judge *cbtjp, int phase);
static int broken_hourglass(world *wp, combat_judge *cbtjp, int phase);
static int bofh_lart(world *wp, combat_judge *cbtjp, int phase);
static int sword_of_mixing(world *wp, combat_judge *cbtjp, int phase);
static int cosmic_contract(world *wp, combat_judge *cbtjp, int phase);
static int shovel(world *wp, combat_judge *cbtjp, int phase);

static int
grid_is_wall(world *wp, int z, int x, int y)
{
  if (wp == NULL)
    return 0;
  if (grid_is_illegal(wp, z, x, y))
    return 0;

  switch (wp->grid[z][x][y] & GRID_TERRAIN_MASK)
  {
  case GR_WALL:
  case GR_GLASS_WALL:
    return 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
iron_sword(world *wp, combat_judge *cbtjp, int phase)
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
    if (my->creature_type == CR_SWORD_TESTER)
    {
      my->defense += 1;
      my->attack += 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
buckler(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;
  
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    my = cbtjp->defender;
    if (my->hp >= my->max_hp)
    {
      cbtjp->parry = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
wand_of_sun(world *wp, combat_judge *cbtjp, int phase)
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
    if ((your->defense == 8)
        || (your->defense == 11)
        || (your->defense == 14)
        || (your->defense == 17))
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
wand_of_moon(world *wp, combat_judge *cbtjp, int phase)
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
    if ((your->defense == 7)
        || (your->defense == 10)
        || (your->defense == 13)
        || (your->defense == 16))
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
hammer_of_justice(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->level > my->level)
    {
      cbtjp->critical = 1;
    }
    break;
  case CBT_DODGE_DEFENDER:
    my = cbtjp->defender;
    your = cbtjp->attacker;
    if (your->level < my->level)
    {
      cbtjp->parry = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
skull_bomb(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->attack == my->defense)
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
rogue_slayer(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->creature_type != CR_GOBLIN)
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
banana_peel(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    cbtjp->dodge = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
katana(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->max_hp >= 10)
    {
      my->attack += 4;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
particle_cannon(world *wp, combat_judge *cbtjp, int phase)
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
    my->attack += my->hp;
    break;
  case CBT_DODGE_ATTACKER:
    my = cbtjp->attacker;
    if (my->hp >= my->max_hp)
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
blackjack(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->max_hp + your->strength >= 22)
    {
      cbtjp->reflect = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
ikasama_blade(world *wp, combat_judge *cbtjp, int phase)
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
    cbtjp->accurate = 1;
    break;
  case CBT_HIT_ATTACKER:
    my = cbtjp->attacker;
    your = cbtjp->defender;
    if ((!combat_stat_is_dead(your))
        && (my->attack >= 1))
    {
      your->hp -= my->attack;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
repulsion_field(world *wp, combat_judge *cbtjp, int phase)
{

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    if ((cbtjp->accurate)
        && (!(cbtjp->dodge))
        && (!(cbtjp->parry)))
    {
      cbtjp->reflect = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
rapier(world *wp, combat_judge *cbtjp, int phase)
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
gold_crown(world *wp, combat_judge *cbtjp, int phase)
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
    my->defense += my->level;
    my->attack += my->level;
    break;
  default:
    break;
  }

  return 0;
}

static int
bikini_armor(world *wp, combat_judge *cbtjp, int phase)
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
    break;
  case CBT_DODGE_DEFENDER:
    cbtjp->cannot_critical = 1;
    break;
  case CBT_HIT_DEFENDER:
    my = cbtjp->defender;
    if (!combat_stat_is_dead(my))
    {
      my->hp -= 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
oilskin_cloak(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->attack - my->defense >= 3)
    {
      cbtjp->dodge = 1;
    }
    if (your->attack - my->defense <= -3)
    {
      cbtjp->cannot_critical = 1;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
giant_spiked_club(world *wp, combat_judge *cbtjp, int phase)
{
  combat_stat *my = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_ATTACKER:
    my = cbtjp->attacker;
    if (my->strength <= 10)
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
lance(world *wp, combat_judge *cbtjp, int phase)
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
    if (cbtjp->post_move_attack)
    {
      my->attack += 4;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
shotgun(world *wp, combat_judge *cbtjp, int phase)
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
    if (!(cbtjp->post_move_attack))
    {
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
all_in_one_knife(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->level == my->level)
    {
      my->defense += 2;
      my->attack += 2;
    }
    break;
  case CBT_DODGE_ATTACKER:
    cbtjp->accurate = 1;
    break;
  case CBT_DODGE_DEFENDER:
    cbtjp->cannot_critical = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
plate_mail(world *wp, combat_judge *cbtjp, int phase)
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
    my->defense += my->strength;
    break;
  default:
    break;
  }

  return 0;
}

static int
ring_of_rage(world *wp, combat_judge *cbtjp, int phase)
{
  int hp_lost;
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
    hp_lost = my->max_hp - my->hp;
    if (hp_lost > 0)
    {
      my->attack += hp_lost;
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
assassin_robe(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->hp % 2 != 0)
    {
      cbtjp->critical = 1;
    }
    break;
  case CBT_DODGE_DEFENDER:
    your = cbtjp->attacker;
    if (your->hp % 2 == 0)
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
whip(world *wp, combat_judge *cbtjp, int phase)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_DODGE_DEFENDER:
    if (cbtjp->post_move_attack)
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
magic_candle(world *wp, combat_judge *cbtjp, int phase)
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
    if (my->level <= 3)
    {
      my->defense += 3;
      my->attack += 3;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
poison_needle(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->defense - my->attack >= 5)
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
mace(world *wp, combat_judge *cbtjp, int phase)
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
crystal_spear(world *wp, combat_judge *cbtjp, int phase)
{
  int x;
  int y;
  int dx;
  int dy;
  int count;
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
    count = 0;
    for (dx = -1; dx <= 1; dx++)
    {
      for (dy = -1; dy <= 1; dy++)
      {
        x = my->x + dx;
        y = my->y + dy;
        if ((dx == 0) && (dy == 0))
          continue;
        if (grid_is_illegal(wp, my->z, x, y))
          continue;

        if (grid_is_wall(wp, my->z, x, y))
        { 
          count++;
        }
      }
    }
    my->attack += count;
    break;
  case CBT_DODGE_ATTACKER:
    cbtjp->cannot_reflect = 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
wood_stake(world *wp, combat_judge *cbtjp, int phase)
{
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
      if (cbtjp->cannot_critical)
      { 
        your->level -= 6;
        your->hp -= 6;
      }
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
boomerang(world *wp, combat_judge *cbtjp, int phase)
{
  int x;
  int y;
  int dx;
  int dy;
  int count;
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
    count = 0;
    for (dx = -1; dx <= 1; dx++)
    {
      for (dy = -1; dy <= 1; dy++)
      {
        x = my->x + dx;
        y = my->y + dy;
        if ((dx == 0) && (dy == 0))
          continue;
        if (grid_is_illegal(wp, my->z, x, y))
        {
          /* a valid non-wall grid is required here */
          count++;
          continue;
        }

        if (grid_is_wall(wp, my->z, x, y))
          count++;
      }
    }
    if (count <= 0)
    {
      my->defense += 4;
      my->attack += 4;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
tonfa(world *wp, combat_judge *cbtjp, int phase)
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
    if (cbtjp->post_move_attack)
    {
      my->defense += 4;
    }
    else
    {
      my->attack += 4;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
broken_hourglass(world *wp, combat_judge *cbtjp, int phase)
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
    your->defense -= your->level;
    your->attack -= your->level;
    if (your->level > my->level)
    { 
      my->defense += your->level;
      my->attack += your->level;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
bofh_lart(world *wp, combat_judge *cbtjp, int phase)
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
    if (your->defense >= 18)
    {
      cbtjp->critical = 1;
    }
    break;
  case CBT_DODGE_DEFENDER:
    your = cbtjp->attacker;
    if (your->attack >= 18)
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
sword_of_mixing(world *wp, combat_judge *cbtjp, int phase)
{
  int temp;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_SWAP_ATTACKER:
  case CBT_SWAP_DEFENDER:
    if (phase == CBT_SWAP_ATTACKER)
    {
      your = cbtjp->defender;
    }
    else
    {
      your = cbtjp->attacker;
    }
    temp = your->defense;
    your->defense = your->attack;
    your->attack = temp;
    break;
  default:
    break;
  }

  return 0;
}

static int
cosmic_contract(world *wp, combat_judge *cbtjp, int phase)
{
  int temp;
  combat_stat *my = NULL;
  combat_stat *your = NULL;

  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  switch (phase)
  {
  case CBT_SWAP_ATTACKER:
    my = cbtjp->attacker;
    your = cbtjp->defender;

    temp = my->attack;
    my->attack = your->attack;
    your->attack = temp;
    break;
  default:
    break;
  }

  return 0;
}

static int
shovel(world *wp, combat_judge *cbtjp, int phase)
{
  int x;
  int y;
  int dx;
  int dy;
  int temp;
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

    if (your->x > my->x)
      dx = 1;
    else if (your->x < my->x)
      dx = -1;
    else
      dx = 0;

    if (your->y > my->y)
      dy = 1;
    else if (your->y < my->y)
      dy = -1;
    else
      dy = 0;

    x = your->x + dx;
    y = your->y + dy;

    if ((your->z == my->z)
        && (!grid_is_illegal(wp, your->z, x, y))
        && (grid_is_wall(wp, your->z, x, y)))
    {
      my->defense += 4;
      my->attack += 4;
    }
    break;
  case CBT_HIT_ATTACKER:
    my = cbtjp->attacker;
    your = cbtjp->defender;
    if ((!combat_stat_is_dead(my))
        && (!combat_stat_is_dead(your)))
    {
      temp = my->z;
      my->z = your->z;
      your->z = temp;

      temp = my->x;
      my->x = your->x;
      your->x = temp;

      temp = my->y;
      my->y = your->y;
      your->y = temp;
    }
    break;
  default:
    break;
  }

  return 0;
}

int
weapon_effect_init(world *wp)
{
  if (wp == NULL)
  {
    fprintf(stderr, "weapon_effect_init: wp is NULL\n");
    return 1;
  }

  wp->weapon_effect_func[WP_IRON_SWORD] = &iron_sword;
  wp->weapon_effect_func[WP_BUCKLER] = &buckler;
  wp->weapon_effect_func[WP_WAND_OF_SUN] = &wand_of_sun;
  wp->weapon_effect_func[WP_WAND_OF_MOON] = &wand_of_moon;
  wp->weapon_effect_func[WP_HAMMER_OF_JUSTICE] = &hammer_of_justice;
  wp->weapon_effect_func[WP_SKULL_BOMB] = &skull_bomb;
  wp->weapon_effect_func[WP_ROGUE_SLAYER] = &rogue_slayer;
  wp->weapon_effect_func[WP_BANANA_PEEL] = &banana_peel;
  wp->weapon_effect_func[WP_KATANA] = &katana;
  wp->weapon_effect_func[WP_PARTICLE_CANNON] = &particle_cannon;
  wp->weapon_effect_func[WP_BLACKJACK] = &blackjack;
  wp->weapon_effect_func[WP_IKASAMA_BLADE] = &ikasama_blade;
  wp->weapon_effect_func[WP_REPULSION_FIELD] = &repulsion_field;
  wp->weapon_effect_func[WP_RAPIER] = &rapier;
  wp->weapon_effect_func[WP_GOLD_CROWN] = &gold_crown;
  wp->weapon_effect_func[WP_BIKINI_ARMOR] = &bikini_armor;
  wp->weapon_effect_func[WP_OILSKIN_CLOAK] = &oilskin_cloak;
  wp->weapon_effect_func[WP_GIANT_SPIKED_CLUB] = &giant_spiked_club;
  wp->weapon_effect_func[WP_LANCE] = &lance;
  wp->weapon_effect_func[WP_SHOTGUN] = &shotgun;
  wp->weapon_effect_func[WP_ALL_IN_ONE_KNIFE] = &all_in_one_knife;
  wp->weapon_effect_func[WP_PLATE_MAIL] = &plate_mail;
  wp->weapon_effect_func[WP_RING_OF_RAGE] = &ring_of_rage;
  wp->weapon_effect_func[WP_ASSASSIN_ROBE] = &assassin_robe;
  wp->weapon_effect_func[WP_WHIP] = &whip;
  wp->weapon_effect_func[WP_MAGIC_CANDLE] = &magic_candle;
  wp->weapon_effect_func[WP_POISON_NEEDLE] = &poison_needle;
  wp->weapon_effect_func[WP_MACE] = &mace;
  wp->weapon_effect_func[WP_CRYSTAL_SPEAR] = &crystal_spear;
  wp->weapon_effect_func[WP_WOOD_STAKE] = &wood_stake;
  wp->weapon_effect_func[WP_BOOMERANG] = &boomerang;
  wp->weapon_effect_func[WP_TONFA] = &tonfa;
  wp->weapon_effect_func[WP_BROKEN_HOURGLASS] = &broken_hourglass;
  wp->weapon_effect_func[WP_BOFH_LART] = &bofh_lart;
  wp->weapon_effect_func[WP_SWORD_OF_MIXING] = &sword_of_mixing;
  wp->weapon_effect_func[WP_COSMIC_CONTRACT] = &cosmic_contract;
  wp->weapon_effect_func[WP_SHOVEL] = &shovel;

  return 0;
}
