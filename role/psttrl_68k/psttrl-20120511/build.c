#include <stdio.h>
/* rand, malloc, abs */
#include <stdlib.h>

#include "world.h"
#include "dungeon.h"
#include "grid-detail.h"
#include "creature-detail.h"
#include "monster.h"
#include "array.h"
#include "weapon-detail.h"
#include "r-and-c.h"
#include "cave.h"
#include "dungeon-add-remove.h"

#include "build.h"

static int player_remember_all_map(world *wp);
static int player_remember_surface_map(world *wp);

static int random_creature_type(int z);
static int random_weapon_which(void);
static int add_weapon_to_monster(world *wp, int creature_id,
                                 int weapon_which);

static int build_player_and_dragon(world *wp);

static int build_grid_entrance(world *wp);
static int build_grid(world *wp);
static int build_floor_item_entrance(world *wp);
static int build_floor_item(world *wp);
static int build_monster(world *wp);

static int
player_remember_all_map(world *wp)
{
  int z;
  int x;
  int y;

  if (wp == NULL)
    return 1;

  for (z = 0; z < wp->size_z; z++)
  {
    for (x = 0; x < wp->size_x; x++)
    {
      for (y = 0; y < wp->size_y; y++)
      {
        wp->grid[z][x][y] |= GRID_PLAYER_SEEN;
      }
    }
  }

  return 0;
}

static int
player_remember_surface_map(world *wp)
{
  int x;
  int y;

  if (wp == NULL)
    return 1;

  for (x = 0; x < wp->size_x; x++)
  {
    for (y = 0; y < wp->size_y; y++)
    {
      /* player_remember_map() in loop.c doesn't remember the destination of
       * a stair if the stair is marked as seen
       */
      if (grid_is_stair(wp, 0, x, y))
        continue;

      wp->grid[0][x][y] |= GRID_PLAYER_SEEN;
    }
  }

  return 0;
}

int
dump_grid(world *wp, int z)
{
  int x;
  int y;
  struct grid_detail grd;

  if (wp == NULL)
  {
    fprintf(stderr, "dump_grid: wp is NULL\n");
    return 1;
  }
  if ((z < 0) || (z >= wp->size_z))
  {
    fprintf(stderr, "dump_grid: strange z (%d)\n", z);
    return 1;
  }

  for (y = 0; y < wp->size_y; y++)
  {
    for (x = 0; x < wp->size_x; x++)
    {
      grid_detail_get(wp->grid[z][x][y] & GRID_TERRAIN_MASK, &grd);
      /* assumes that each grid has only one character */
      putc(grd.symbol[0], stderr);
    }
    putc('\n', stderr);
  }

  return 0;
}

int
check_connection(world *wp, int z)
{
  int x;
  int y;
  int x0;
  int y0;
  int dx;
  int dy;
  int found;
  int num_frontier;
  int *frontier_x = NULL;
  int *frontier_y = NULL;
  int **flood = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "check_connection: wp is NULL\n");
    return 1;
  }
  if ((z < 0) || (z >= wp->size_z))
  {
    fprintf(stderr, "check_connection: strange z (%d)\n", z);
    return 1;
  }

  frontier_x = (int *) malloc(sizeof(int) * wp->size_x * wp->size_y);
  if (frontier_x == NULL)
  {
    fprintf(stderr, "check_connection: malloc(frontier_x) failed\n");
    return 1;
  }
  frontier_y = (int *) malloc(sizeof(int) * wp->size_x * wp->size_y);
  if (frontier_y == NULL)
  {
    fprintf(stderr, "check_connection: malloc(frontier_y) failed\n");
    free(frontier_x);
    frontier_x = NULL;
    return 1;
  }
  flood = array2_new(wp->size_x, wp->size_y);
  if (flood == NULL)
  {
    fprintf(stderr, "check_connection: array2_new() failed\n");
    free(frontier_x);
    frontier_x = NULL;
    free(frontier_y);
    frontier_y = NULL;
    return 1;
  }

  for (x = 0; x < wp->size_x; x++)
  {
    for (y = 0; y < wp->size_y; y++)
    {
      flood[x][y] = 0;
    }
  }

  num_frontier = 0;
  found = 0;
  for (x = 0; x < wp->size_x; x++)
  {
    if (found)
      break;
    for (y = 0; y < wp->size_y; y++)
    {
      if (grid_blocks_creature(wp, z, x, y))
        continue;
      found = 1;
      frontier_x[0] = x;
      frontier_y[0] = y;
      num_frontier = 1;
      flood[x][y] = 1;
      break;
    }
  }

  if (!found)
  {
    fprintf(stderr, "check_connection: the map has no open grid\n");
    free(frontier_x);
    frontier_x = NULL;
    free(frontier_y);
    frontier_y = NULL;
    array2_delete(flood, wp->size_x, wp->size_y);
    flood = NULL;
    return 1;
  }

  while (num_frontier > 0)
  {
    x0 = frontier_x[num_frontier - 1];
    y0 = frontier_y[num_frontier - 1];
    num_frontier--;
    for (dx = -1; dx <= 1; dx++)
    {
      for (dy = -1; dy <= 1; dy++)
      {
        x = x0 + dx;
        y = y0 + dy;

        if ((dx == 0) && (dy == 0))
          continue;
        if ((x < 0) || (x >= wp->size_x))
          continue;
        if ((y < 0) || (y >= wp->size_y))
          continue;

        if (grid_blocks_creature(wp, z, x, y))
          continue;
        if (flood[x][y] != 0)
          continue;

        flood[x][y] = 1;
        frontier_x[num_frontier] = x;
        frontier_y[num_frontier] = y;
        num_frontier++;
      }
    }
  }

  found = 0;
  for (x = 0; x < wp->size_x; x++)
  {
    if (found)
      break;
    for (y = 0; y < wp->size_y; y++)
    {
      if (grid_blocks_creature(wp, z, x, y))
        continue;
      if (flood[x][y] == 0)
      {
        fprintf(stderr, "check_connection: the map is not connected\n");
        found = 1;
        break;
      }
    }
  }

  free(frontier_x);
  frontier_x = NULL;
  free(frontier_y);
  frontier_y = NULL;
  array2_delete(flood, wp->size_x, wp->size_y);
  flood = NULL;

  return found;
}

static int
random_creature_type(int z)
{
  int table1[] =
    {
      CR_RAT,
      CR_GOBLIN
    };
  int table2[] =
    {
      CR_RAT,
      CR_GOBLIN,
      CR_MAGE,
      CR_GRID_BUG,
      CR_OGRE, /* 5 */
      CR_BAT
    };
  int table4[] =
    {
      CR_SHMUPPER,
      CR_MAGE,
      CR_GRID_BUG,
      CR_OGRE,
      CR_MONK, /* 5 */
      CR_GLASS_GOLEM,
      CR_HACKER,
      CR_BAT,
      CR_BERSERKER,
      CR_IMP, /* 10 */
      CR_CAT,
      CR_CHARIOT,
      CR_WISP
    };
  int table6[] =
    {
      CR_SHMUPPER,
      CR_MAGE,
      CR_TYRANT,
      CR_GRID_BUG,
      CR_OGRE, /* 5 */
      CR_MONK,
      CR_GLASS_GOLEM,
      CR_LEAD_GOLEM,
      CR_HACKER,
      CR_BERSERKER, /* 10 */
      CR_SAMURAI,
      CR_IMP,
      CR_CAT,
      CR_ACID_BLOB,
      CR_CHARIOT, /* 15 */
      CR_VAMPIRE,
      CR_WISP
    };
  int table8[] =
    {
      CR_BEE_SLAYER_SHMUPPER,
      CR_HEISENBUG,
      CR_LANGUAGE_LAWYER,
      CR_FULL_STRENGTH_MAGE,
      CR_TYRANT, /* 5 */
      CR_MILLENNIUM_MONK,
      CR_LEAD_GOLEM,
      CR_HACKER,
      CR_BERSERKER,
      CR_SAMURAI, /* 10 */
      CR_AMULET_RETRIEVER,
      CR_CAT,
      CR_ACID_BLOB,
      CR_WARLORD,
      CR_NURUPO, /* 15 */
      CR_VAMPIRE,
      CR_WISP
    };
  
  if (z < 2)
    return table1[rand() % 2];
  else if (z < 4)
    return table2[rand() % 6];
  else if (z < 6)
    return table4[rand() % 13];
  else if (z < 8)
    return table6[rand() % 17];

  return table8[rand() % 17];
}

static int
random_weapon_which(void)
{
  int table[] = 
    {
      WP_IRON_SWORD,
      WP_DAGGER,
      WP_BUCKLER,
      WP_WAND_OF_SUN,
      WP_WAND_OF_MOON, /* 5 */
      WP_HAMMER_OF_JUSTICE,
      WP_SKULL_BOMB,
      WP_BANANA_PEEL,
      WP_KATANA,
      WP_BLACKJACK, /* 10 */
      WP_REPULSION_FIELD,
      WP_RAPIER,
      WP_GOLD_CROWN,
      WP_BIKINI_ARMOR,
      WP_OILSKIN_CLOAK, /* 15 */
      WP_GIANT_SPIKED_CLUB,
      WP_LANCE,
      WP_SHOTGUN,
      WP_ALL_IN_ONE_KNIFE,
      WP_PLATE_MAIL, /* 20 */
      WP_RING_OF_RAGE,
      WP_ASSASSIN_ROBE,
      WP_WHIP,
      WP_MAGIC_CANDLE,
      WP_POISON_NEEDLE, /* 25 */
      WP_MACE,
      WP_CRYSTAL_SPEAR,
      WP_WOOD_STAKE,
      WP_BOOMERANG,
      WP_TONFA, /* 30 */
      WP_BROKEN_HOURGLASS,
      WP_BOFH_LART,
      WP_SWORD_OF_MIXING,
      WP_SHOVEL
    };
  
  return table[rand() % 34];
}

static int
add_weapon_to_monster(world *wp, int creature_id,
                      int weapon_which)
{
  int item_id;

  if (wp == NULL)
    return 1;
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
    return 1;
  if (wp->cr[creature_id] == NULL)
    return 1;
  if ((weapon_which < 0) || (weapon_which >= NUM_WEAPON))
    return 1;

  item_id = add_new_item(wp, ITEM_TYPE_WEAPON,
                         weapon_which, 1);
  move_item(wp, item_id, ITEM_SHEATH, creature_id,
            -1, -1, -1, -1,
            0);

  return 0;
}

static int
build_player_and_dragon(world *wp)
{
  int z;
  int x;
  int y;
  int creature_id;
  int weapon_which;

  if (wp == NULL)
    return 1;

  x = wp->size_x / 2;
  y = wp->size_y / 2;
  
  /* add the player character before monsters */
  creature_id = add_new_creature(wp, CR_SWORD_TESTER,
                                 0, x, y, 0,
                                 0);
  if (creature_id < 0)
  {
    fprintf(stderr, "build_player_and_dragon: "
            "add_new_creature(player) failed\n");
    return 1;
  }
  wp->player_id = creature_id;
  wp->cr[creature_id]->attitude = ATTITUDE_PLAYER;
  wp->camera_z = wp->cr[creature_id]->z;
  wp->camera_x = wp->cr[creature_id]->x;
  wp->camera_y = wp->cr[creature_id]->y;
  wp->cursor_x = wp->cr[creature_id]->x;
  wp->cursor_y = wp->cr[creature_id]->y;

  wp->player_weapon_slot = 0;

  /* add dragons */
  z = 9;
  find_open_floor(wp, z, &x, &y);
  creature_id = add_new_creature(wp, CR_ANCIENT_DRAGON,
                                 z, x, y, 9,
                                 rand() % 2);
  if (creature_id < 0)
  {
    fprintf(stderr, "build_player_and_dragon: "
            "add_new_creature(ancient dragon) failed\n");
    return 1;
  }
  wp->ancient_dragon_id = creature_id;
  do
  {
    weapon_which = random_weapon_which();
  } while (weapon_which == WP_BANANA_PEEL);
  add_weapon_to_monster(wp, creature_id,
                        weapon_which);

  z = 6;
  find_open_floor(wp, z, &x, &y);
  creature_id = add_new_creature(wp, CR_MATURE_DRAGON,
                                 z, x, y, 6,
                                 rand() % 2);
  if (creature_id < 0)
  {
    fprintf(stderr, "build_player_and_dragon: "
            "add_new_creature(mature dragon) failed\n");
    return 1;
  }
  wp->mature_dragon_id = creature_id;
  do
  {
    weapon_which = random_weapon_which();
  } while (weapon_which == WP_BANANA_PEEL);
  add_weapon_to_monster(wp, creature_id,
                        weapon_which);

  z = 3;
  find_open_floor(wp, z, &x, &y);
  creature_id = add_new_creature(wp, CR_BABY_DRAGON,
                                 z, x, y, 3,
                                 rand() % 2);
  if (creature_id < 0)
  {
    fprintf(stderr, "build_player_and_dragon: "
            "add_new_creature(baby dragon) failed\n");
    return 1;
  }
  wp->baby_dragon_id = creature_id;
  do
  {
    weapon_which = random_weapon_which();
  } while ((weapon_which == WP_BANANA_PEEL)
           || (weapon_which == WP_GIANT_SPIKED_CLUB));
  add_weapon_to_monster(wp, creature_id,
                        weapon_which);

  return 0;
}

static int
build_grid_entrance(world *wp)
{
  int x;
  int y;

  if (wp == NULL)
    return 1;

  for (x = 0; x < wp->size_x; x++)
  {
    for (y = 0; y < wp->size_y; y++)
    {
      wp->grid[0][x][y] = GR_WALL;
    }
  }

  for (x = 1; x < wp->size_x - 1; x++)
  {
    for (y = 1; y < wp->size_y - 1; y++)
    {
      wp->grid[0][x][y] = GR_FLOOR;
    }
  }

  wp->grid[0][wp->size_x / 2 - 2][wp->size_y / 2 - 2] = GR_STAIR_DOWN_0;
  wp->grid[0][wp->size_x / 2 + 0][wp->size_y / 2 - 2] = GR_STAIR_DOWN_1;
  wp->grid[0][wp->size_x / 2 + 2][wp->size_y / 2 - 2] = GR_STAIR_DOWN_2;

  return 0;
}

static int
build_grid(world *wp)
{
  int i;
  int z;
  int x;
  int y;
  int n;

  if (wp == NULL)
    return 1;

  for (z = 1; z < wp->size_z; z++)
  {
    for (x = 0; x < wp->size_x; x++)
    {
      for (y = 0; y < wp->size_y; y++)
      {
        wp->grid[z][x][y] = GR_WALL;
      }
    }
  }

  build_grid_entrance(wp);

  for (z = 1; z < wp->size_z; z++)
  {
    if (z < 4)
    {
      build_r_and_c(wp, z,
                    1, 1,
                    4, 2,
                    1, CONNECT_SOME);
    }
    else if (z == 4)
    {
      build_r_and_c(wp, z,
                    1, 1,
                    4, 0,
                    2, CONNECT_SOME);
    }
    else if (z == 5)
    {
      build_r_and_c(wp, z,
                    2, 1,
                    1, 0,
                    0, CONNECT_DEAD_END);
    }
    else if (z == 6)
    {
      build_r_and_c(wp, z,
                    2, 1,
                    3, 1,
                    1, CONNECT_SOME);
    }
    else if (z < 10)
    {
      build_cave(wp, z, 45);
    }
    else
    {      
      build_braid(wp, z, 3);
    }

    if (z < wp->size_z - 1)
    {    
      for (i = 0; i < 3; i++)
      {
        switch (i)
        {
        case 0:
          n = GR_STAIR_DOWN_0;
          break;
        case 1:
          n = GR_STAIR_DOWN_1;
          break;
        default:
          n = GR_STAIR_DOWN_2;
          break;
        }
        find_open_floor(wp, z, &x, &y);
        
        wp->grid[z][x][y] = n;
      }
    }

    if (z >= 1)
    {    
      for (i = 0; i < 3; i++)
      {
        switch (i)
        {
        case 0:
          n = GR_STAIR_UP_0;
          break;
        case 1:
          n = GR_STAIR_UP_1;
          break;
        default:
          n = GR_STAIR_UP_2;
          break;
        }
        find_open_floor(wp, z, &x, &y);
        wp->grid[z][x][y] = n;
      }
    }
  }

  return 0;
}

static int
build_floor_item_entrance(world *wp)
{
  int item_id;

  if (wp == NULL)
    return 1;

  item_id = add_new_item(wp, ITEM_TYPE_WEAPON, WP_IRON_SWORD, 1);
  move_item(wp, item_id, ITEM_FLOOR, -1,
            0, wp->size_x / 2, wp->size_y / 2 - 1, -1,
            0);

  item_id = add_new_item(wp, ITEM_TYPE_WEAPON, WP_DAGGER, 1);
  move_item(wp, item_id, ITEM_FLOOR, -1,
            0, wp->size_x / 2 - 1, wp->size_y / 2, -1,
            0);

  item_id = add_new_item(wp, ITEM_TYPE_WEAPON, WP_RAPIER, 1);
  move_item(wp, item_id, ITEM_FLOOR, -1,
            0, wp->size_x / 2 + 1, wp->size_y / 2, -1,
            0);

  item_id = add_new_item(wp, ITEM_TYPE_WEAPON, WP_BUCKLER, 1);
  move_item(wp, item_id, ITEM_FLOOR, -1,
            0, wp->size_x / 2, wp->size_y / 2 + 1, -1,
            0);

  return 0;
}

static int
build_floor_item(world *wp)
{
  int i;
  int z;
  int x;
  int y;
  int item_id;
  int item_which;
  int num_item;

  if (wp == NULL)
    return 1;

  build_floor_item_entrance(wp);

  for (z = 1; z < wp->size_z; z++)
  {
    num_item = 10;

    for (i = 0; i < num_item; i++)
    {
      find_open_floor(wp, z, &x, &y);
      item_which = random_weapon_which();

      item_id = add_new_item(wp, ITEM_TYPE_WEAPON,
                             item_which, 1);
      move_item(wp, item_id, ITEM_FLOOR, -1,
                z, x, y, -1,
                0);
    }
  }

  z = 10;
  x = 24;
  y = 24;
  item_which = WP_IKASAMA_BLADE;
  item_id = add_new_item(wp, ITEM_TYPE_WEAPON,
                         item_which, 1);
  move_item(wp, item_id, ITEM_FLOOR, -1,
            z, x, y, -1,
            0);

  return 0;
}

static int
build_monster(world *wp)
{
  int i;
  int z;
  int x;
  int y;
  int creature_id;
  int creature_type;
  int creature_level;
  int weapon_which;
  int num_creature;
  int chance_weapon;

  if (wp == NULL)
    return 1;

  for (z = 1; z < wp->size_z; z++)
  {
    if (z < 4)
      num_creature = 10;
    else if (z < 7)
      num_creature = 12;
    else
      num_creature = 15;

    for (i = 0; i < num_creature; i++)
    {
      find_open_floor(wp, z, &x, &y);
      creature_type = random_creature_type(z);
      if (z < 2)
        creature_level = -1 + (rand() % 3);
      else if (z < 4)
        creature_level = rand() % 3;
      else if (z < 7)
        creature_level = rand() % 4;
      else
        creature_level = (rand() % 4) + (rand() % 3) + (rand() % 2);

      creature_id = add_new_creature(wp, creature_type,
                                     z, x, y, creature_level,
                                     i % 2);
      if (creature_id < 0)
      {
        fprintf(stderr, "build_monster: "
                "add_new_creature failed\n");
        return 1;
      }
      monster_set_attitude(wp, wp->cr[creature_id],
                       ATTITUDE_MONSTER_UNINTERESTED);

      if (z < 2)
        chance_weapon = 2;
      else if (z < 4)
        chance_weapon = 5;
      else
        chance_weapon = 7;

      switch (creature_type)
      {
      case CR_MONK:
      case CR_MILLENNIUM_MONK:
        chance_weapon = 1;
      default:
        break;
      }

      if (rand() % 8 < chance_weapon)
      {
        weapon_which = random_weapon_which();

        add_weapon_to_monster(wp, creature_id,
                              weapon_which);
      }
    }
  }

  z = 10;
  find_open_floor(wp, z, &x, &y);
  creature_type = CR_BETRAYING_MASCOT;
  creature_level = 0;
  creature_id = add_new_creature(wp, creature_type,
                                 z, x, y, creature_level,
                                 rand() % 2);
  weapon_which = WP_COSMIC_CONTRACT;
  add_weapon_to_monster(wp, creature_id,
                        weapon_which);

  z = 8 + (rand() % 2);
  find_open_floor(wp, z, &x, &y);
  creature_type = CR_FULL_STRENGTH_MAGE;
  creature_level = 6;
  creature_id = add_new_creature(wp, creature_type,
                                 z, x, y, creature_level,
                                 rand() % 2);
  weapon_which = WP_PARTICLE_CANNON;
  add_weapon_to_monster(wp, creature_id,
                        weapon_which);

  z = 5 + (rand() % 2);
  find_open_floor(wp, z, &x, &y);
  creature_type = CR_GOBLIN;
  creature_level = 0;
  creature_id = add_new_creature(wp, creature_type,
                                 z, x, y, creature_level,
                                 rand() % 2);
  weapon_which = WP_ROGUE_SLAYER;
  add_weapon_to_monster(wp, creature_id,
                        weapon_which);

  return 0;
}

int
build_new_game(world *wp)
{
  if (wp == NULL)
  {
    fprintf(stderr, "build_new_game: wp is NULL");
    return 1;
  }

  world_reset_game(wp);

  build_grid(wp);

  if (build_player_and_dragon(wp) != 0)
  {
    fprintf(stderr, "build_new_game: build_player_and_dragon failed\n");
    return 1;
  }

  build_floor_item(wp);
  build_monster(wp);

  player_remember_surface_map(wp);
  /* useful for debug */
  if (0)
  {
    player_remember_all_map(wp);
  }

  return 0;
}
