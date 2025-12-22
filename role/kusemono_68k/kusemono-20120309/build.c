#include <stdio.h>
/* rand */
#include <stdlib.h>

#include "world.h"
#include "dungeon.h"
#include "grid-detail.h"
#include "creature-detail.h"
#include "monster.h"
#include "r-and-c.h"

#include "build.h"

static int player_remember_all_map(world *wp);
static int build_grid_surface(world *wp);
static int build_grid_underground(world *wp, int z);
static int build_player_and_queen(world *wp);
static int build_monster_surface(world *wp);
static int build_monster_underground(world *wp, int z);

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
build_grid_surface(world *wp)
{
  int m;
  int x;
  int y;
  int dx;
  int dy;
  int x_max;
  int y_max;

  if (wp == NULL)
    return 1;

  build_maze(wp->grid[0], wp->size_x, wp->size_y,
             2, CONPLAN_BACKTRACK, 0);

  x_max = (wp->size_x / 3) * 3 - 1;
  y_max = (wp->size_y / 3) * 3 - 1;

  /* entrance */
  for (x = 1; x < 12; x++)
  {
    for (y = y_max - 1 - 12; y <= y_max; y++)
    {
      wp->grid[0][x][y] = GR_FLOOR;
    }
  }

  for (x = 2; x <= 4; x++)
    wp->grid[0][x][y_max - 3] = GR_WALL;
  for (y = y_max - 3; y <= y_max - 1; y++)
    wp->grid[0][4][y] = GR_WALL;

  for (x = 3; x <= 9; x++)
  {
    if (x == 6)
      continue;
    wp->grid[0][x][y_max - 11] = GR_WALL;
    wp->grid[0][x][y_max - 5] = GR_WALL;
  }
  for (y = y_max - 11; y <= y_max - 5; y++)
  {
    if (y == y_max - 8)
      continue;
    wp->grid[0][3][y] = GR_WALL;
    wp->grid[0][9][y] = GR_WALL;
  }
  wp->grid[0][5][y_max - 7] = GR_STAIR_DOWN_0;
  wp->grid[0][7][y_max - 7] = GR_STAIR_DOWN_1;
  wp->grid[0][6][y_max - 9] = GR_STAIR_DOWN_2;

  /* explorer gathering */
  for (x = x_max - 1 - 12; x <= x_max; x++)
  {
    for (y = 1; y < 12; y++)
    {
      wp->grid[0][x][y] = GR_FLOOR;
    }
  }

  /* escape hatch */
  x = 0;
  y = 0;
  while (1)
  {
    x = rand() % wp->size_x;
    y = rand() % wp->size_y;
    if ((x <= 12) && (y >= y_max - 13))
      continue;
    if ((x >= x_max - 1 - 13) && (y <= 12))
      continue;
    if ((wp->grid[0][x][y] & GRID_TERRAIN_MASK) != GR_FLOOR)
      continue;
    m = 0;
    for (dx = -1; dx <= 1; dx++)
    {
      for (dy = -1; dy <= 1; dy++)
      {
        if ((dx == 0) && (dy == 0))
          continue;
        if (grid_blocks_creature(wp, 0, x + dx, y + dy))
          continue;
        m++;
      }
    }
    if (m < 4)
      continue;
    break;
  }
  wp->grid[0][x][y] = GR_STAIR_DOWN_3;

  return 0;
}

static int
build_grid_underground(world *wp, int z)
{
  int i;
  int m;
  int n;
  int x;
  int y;
  int dx;
  int dy;

  if (wp == NULL)
    return 1;
  if ((z < 0) || (z >= wp->size_z))
    return 1;

  switch (z)
  {
  case 1:
    build_room_and_corridor(wp->grid[z], wp->size_x, wp->size_y,
                            SEGPLAN_DENSE);
    break;
  case 2:
    build_maze(wp->grid[z], wp->size_x, wp->size_y,
               2, CONPLAN_BACKTRACK, 0);
    break;
  default:
    build_room_and_corridor(wp->grid[z], wp->size_x, wp->size_y,
                            SEGPLAN_SPARSE);
    break;
  }

  x = 0;
  y = 0;

  if (z <= wp->size_z - 2)
  {
    for (i = 0; i < 4; i++)
    {      
      while (1)
      {
        x = rand() % wp->size_x;
        y = rand() % wp->size_y;
        if ((wp->grid[z][x][y] & GRID_TERRAIN_MASK) != GR_FLOOR)
          continue;
        m = 0;
        for (dx = -1; dx <= 1; dx++)
        {
          for (dy = -1; dy <= 1; dy++)
          {
            if ((dx == 0) && (dy == 0))
              continue;
            if (grid_blocks_creature(wp, z, x + dx, y + dy))
              continue;
            m++;
          }
        }
        if (m < 4)
          continue;
        break;
      }

      switch (i)
      {
      case 0:
        n = GR_STAIR_DOWN_0;
        break;
      case 1:
        n = GR_STAIR_DOWN_1;
        break;
      case 2:
        n = GR_STAIR_DOWN_2;
        break;
      default:
        n = GR_STAIR_DOWN_3;
        break;
      }

      wp->grid[z][x][y] = n;
    }
  }

  if (z >= 1)
  {
    for (i = 0; i < 4; i++)
    {      
      while (1)
      {
        x = rand() % wp->size_x;
        y = rand() % wp->size_y;
        if ((wp->grid[z][x][y] & GRID_TERRAIN_MASK) != GR_FLOOR)
          continue;
        m = 0;
        for (dx = -1; dx <= 1; dx++)
        {
          for (dy = -1; dy <= 1; dy++)
          {
            if ((dx == 0) && (dy == 0))
              continue;
            if (grid_blocks_creature(wp, z, x + dx, y + dy))
              continue;
            m++;
          }
        }
        if (m < 4)
          continue;
        break;
      }

      switch (i)
      {
      case 0:
        n = GR_STAIR_UP_0;
        break;
      case 1:
        n = GR_STAIR_UP_1;
        break;
      case 2:
        n = GR_STAIR_UP_2;
        break;
      default:
        n = GR_STAIR_UP_3;
        break;
      }

      wp->grid[z][x][y] = n;
    }
  }

  return 0;
}

static int
build_player_and_queen(world *wp)
{
  int n;
  int x;
  int y;
  int y_max;

  if (wp == NULL)
    return 1;

  y_max = (wp->size_y / 3) * 3 - 1;

  /* add the player character before monsters */
  n = add_new_creature(wp, CR_PLAYER,
                       0, 3, y_max - 2,
                       0);
  if (n < 0)
  {
    fprintf(stderr, "build_player_and_queen: "
            "add_new_creature(player) failed\n");
    return 1;
  }
  wp->player_id = n;
  wp->cr[n]->attitude = ATTITUDE_PLAYER_SEARCHING;
  wp->cr[n]->timer_attitude = 4;  
  wp->camera_z = wp->cr[n]->z;
  wp->camera_x = wp->cr[n]->x;
  wp->camera_y = wp->cr[n]->y;
  wp->cursor_x = wp->cr[n]->x;
  wp->cursor_y = wp->cr[n]->y;

  /* add the Queen */
  x = 0;
  y = 0;
  while (1)
  {
    x = rand() % wp->size_x;
    y = rand() % wp->size_y;
    if ((wp->grid[wp->size_z - 1][x][y] & GRID_TERRAIN_MASK) != GR_FLOOR)
      continue;
    if (grid_has_creature(wp, wp->size_z - 1, x, y))
      continue;
    break;
  }
  n = add_new_creature(wp, CR_QUEEN,
                       wp->size_z - 1, x, y, 0);
  if (n < 0)
  {
    fprintf(stderr, "build_player_and_queen: "
            "add_new_creature(queen) failed\n");
    return 1;
  }
  wp->queen_id = n;

  return 0;
}

static int
build_monster_surface(world *wp)
{
  int i;
  int n;
  int x;
  int y;
  int home_z;
  int home_x;
  int home_y;
  int x_max;
  int y_max;

  if (wp == NULL)
    return 1;

  x_max = (wp->size_x / 3) * 3 - 1;
  y_max = (wp->size_y / 3) * 3 - 1;

  x = 4 + (rand() % 5);
  y = y_max - 10 + (rand() % 5);
  /* this grid should be available */
  n = add_new_creature(wp, CR_SOLDIER,
                       0, x, y, rand() % 2);
  if (n < 0)
  {
    fprintf(stderr, "build_monster_surface: "
            "add_new_creature failed (soldier)\n");
    return 1;
  }
  monster_set_attitude(wp, wp->cr[n], ATTITUDE_MONSTER_UNINTERESTED);

  for (i = 0; i < 16; i++)
  {
    while (1)
    {
      x = x_max - 1 - 12 + (rand() % 13);
      y = 1 + (rand() % 11);
      if ((wp->grid[0][x][y] & GRID_TERRAIN_MASK) != GR_FLOOR)
        continue;
      if (grid_has_creature(wp, 0, x, y))
        continue;
      break;
    }

    home_z = 1 + i / 8;
    while (1)
    {
      home_x = rand() % wp->size_x;
      home_y = rand() % wp->size_y;
      if ((wp->grid[home_z][home_x][home_y] & GRID_TERRAIN_MASK) != GR_FLOOR)
        continue;
      if (grid_has_creature(wp, home_z, home_x, home_y))
        continue;
      break;
    }
  
    n = add_new_creature(wp, CR_EXPLORER,
                         0, x, y, i % 2);
    if (n < 0)
    {
      fprintf(stderr, "build_monster_surface: "
              "add_new_creature failed (i = %d)\n", i);
      return 1;
    }

    wp->cr[n]->home_z = home_z;
    wp->cr[n]->home_x = home_x;
    wp->cr[n]->home_y = home_y;

    wp->cr[n]->attitude = ATTITUDE_MONSTER_UNINTERESTED;
    wp->cr[n]->timer_attitude = 250 + (rand() % 10);
    /* do not call monster_set_attitude() here
     * --- it resets timer_attitude
     */
  }

  return 0;
}

static int
build_monster_underground(world *wp, int z)
{
  int i;
  int n;
  int x;
  int y;

  if (wp == NULL)
    return 1;
  if ((z < 0) || (z >= wp->size_z))
    return 1;

  x = 0;
  y = 0;

  for (i = 0; i < 30; i++)
  {
    while (1)
    {
      x = rand() % wp->size_x;
      y = rand() % wp->size_y;
      if ((wp->grid[z][x][y] & GRID_TERRAIN_MASK) != GR_FLOOR)
        continue;
      if (grid_has_creature(wp, z, x, y))
        continue;
      break;
    }
    n = add_new_creature(wp, CR_SOLDIER,
                         z, x, y, i % 2);
    if (n < 0)
    {
      fprintf(stderr, "build_monster_underground: "
              "add_new_creature failed (z = %d, i = %d)\n", z, i);
      return 1;
    }

    monster_set_attitude(wp, wp->cr[n], ATTITUDE_MONSTER_UNINTERESTED);
  }

  return 0;
}

int
build_new_game(world *wp)
{
  int z;

  if (wp == NULL)
  {
    fprintf(stderr, "build_new_game: wp is NULL");
    return 1;
  }

  world_reset_game(wp);

  build_grid_surface(wp);
  for (z = 1; z < wp->size_z; z++)
    build_grid_underground(wp, z);

  if (build_player_and_queen(wp) != 0)
  {
    fprintf(stderr, "build_new_game: build_player_and_queen failed\n");
    return 1;
  }

  build_monster_surface(wp);
  for (z = 1; z < wp->size_z; z++)
    build_monster_underground(wp, z);

  /* useful for debug */
  if (0)
  {
    player_remember_all_map(wp);
  }

  return 0;
}
