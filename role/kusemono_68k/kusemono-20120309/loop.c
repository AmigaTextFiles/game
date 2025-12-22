#include <stdio.h>
/* free, qsort, rand */
#include <stdlib.h>
#include <pdcurses/curses.h>

#include "world.h"
#include "dungeon.h"
#include "creature.h"
#include "action.h"
#include "monster.h"
#include "creature-detail.h"
#include "grid-detail.h"
#include "enchantment-detail.h"
#include "magic-device.h"

#include "loop.h"

static creature *find_creature_under_cursor(world *wp);
static int cursor_next_target(world *wp);
static int examine_stair_destination(world *wp, int reset_only);
static int loop_input_waiting_for_action(world *wp);
static int loop_input_examine_surroundings(world *wp);
static int loop_input_full_screen_log(world *wp);
static int loop_input_describe_creature(world *wp);
static int loop_input_full_screen_map(world *wp);
static int loop_input_confirm_resign(world *wp);
static int loop_input_quaff(world *wp);
static int loop_input_swap_position(world *wp);
static int loop_input_zap(world *wp);
static int loop_input(world *wp);
static int remove_dead(world *wp);
static int check_victory(world *wp);
static int player_remember_map(world *wp);
static int forget_old_last_known(world *wp);
static int loop_upkeep_action(world *wp);
static int loop_upkeep_turn(world *wp, int creature_id);
static int loop_upkeep_ut(world *wp, int ut);
static int loop_action_iterate(world *wp);
static int loop_action(world *wp);
static int show_multiline(world *wp, int y_top, const char *str);
static int show_log(world *wp, int y_top, int y_bottom, int log_bottom);
static int loop_draw_grid(world *wp);
static int loop_draw_last_known(world *wp);
static int loop_draw_creature(world *wp);
static int loop_draw_stat_player(world *wp);
static int loop_draw_stat_creature(world *wp, creature *who);
static int loop_draw_stat(world *wp);
static int loop_draw_message_waiting_for_action(world *wp);
static int loop_draw_message_examine_surroundings(world *wp);
static int loop_draw_message_confirm_resign(world *wp);
static int loop_draw_message_quaff(world *wp);
static int loop_draw_message_swap_position(world *wp);
static int loop_draw_message_zap(world *wp);
static int loop_draw_message(world *wp);
static int loop_draw_three_part(world *wp);
static int loop_draw_full_screen_log(world *wp);
static int loop_draw_describe_creature(world *wp);
static int loop_draw_full_screen_map(world *wp);
static int loop_draw(world *wp);

/* meaning of wp->mode[*] for each wp->mode[0]
 * * MODE_WAITING_FOR_ACTION
 *   (none)
 * * MODE_EXAMINE_SURROUNDING
 *   (none)
 * * MODE_FULL_SCREEN_LOG
 *   [1] log bottom
 * * MODE_DESCRIBE_CREATURE
 *   [1] creature id
 * * MODE_FULL_SCREEN_MAP
 *   [1] up-left corner x
 *   [2] up-left corner y
 * * MODE_CONFIRM_RESIGN
 *   (none)
 * * MODE_QUAFF
 *   (none)
 * * MODE_SWAP_POSITION
 *   (none)
 */

static creature *
find_creature_under_cursor(world *wp)
{
  int i;
  creature *who = NULL;

  if (wp == NULL)
    return NULL;

  who = NULL;
  for (i = wp->cr_size - 1; i >= 0; i--)
  {
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->z != wp->camera_z)
      continue;
    if (wp->cr[i]->x != wp->cursor_x)
      continue;
    if (wp->cr[i]->y != wp->cursor_y)
      continue;

    who = wp->cr[i];
  }

  return who;
}

static int
cursor_next_target(world *wp)
{
  int i;
  int x;
  int y;
  int n;
  int n0;
  creature *who = NULL;

  if (wp == NULL)
    return 1;

  who = find_creature_under_cursor(wp);
  if (who == NULL)
    n0 = wp->player_id;
  else
    n0 = who->id;

  for (i = 1; i < wp->cr_size; i++)
  {
    n = (n0 + i) % wp->cr_size;
    if (n == wp->player_id)
      continue;
    if (creature_is_dead(wp, n))
      continue;
    if (wp->cr[n]->z != wp->camera_z)
      continue;
    x = wp->cr[n]->x;
    y = wp->cr[n]->y;
    if (distance(x, y, wp->camera_x, wp->camera_y) > 8)
      continue;
    if ((creature_sees_grid(wp, wp->player_id,
                            wp->camera_z, x, y) <= 0)
        && (!player_searches_grid(wp, wp->camera_z, x, y)))
      continue;

    wp->cursor_x = x;
    wp->cursor_y = y;
    break;
  }

  return 0;
}

static int
examine_stair_destination(world *wp, int reset_only)
{
  int dest_z;
  int dest_x;
  int dest_y;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return 1;
  if (wp->cr[wp->player_id] == NULL)
    return 1;
  player = wp->cr[wp->player_id];

  if (wp->camera_z != player->z)
  {
    wp->camera_z = player->z;
    wp->camera_x = player->x;
    wp->camera_y = player->y;
    wp->cursor_x = player->x;
    wp->cursor_y = player->y;
    return 0;
  }

  if (reset_only)
    return 0;

  if (creature_sees_grid(wp, wp->player_id,
                         wp->camera_z, wp->cursor_x, wp->cursor_y) <= 0)
    return 0;
  if (!find_stair_destination(wp,
                              wp->camera_z, wp->cursor_x, wp->cursor_y,
                              &dest_z, &dest_x, &dest_y))
    return 0;

  wp->camera_z = dest_z;
  wp->camera_x = dest_x;
  wp->camera_y = dest_y;
  wp->cursor_x = dest_x;
  wp->cursor_y = dest_y;

  return 0;
}

static int
loop_input_waiting_for_action(world *wp)
{
  int c;
  int scr_size_x;
  int scr_size_y;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  scr_size_x = wp->scr_size_x;
  scr_size_y = wp->scr_size_y;

  c = getch();

  switch (c)
  {
  case 'Q':
    if ((creature_is_dead(wp, wp->player_id))
        || (wp->victory))
    {
      wp->should_quit = 1;
      return 0;
    }
    else
    {
      wp->mode[0] = MODE_CONFIRM_RESIGN;
    }
    break;
  case ' ':
    cursor_next_target(wp);
    break;
  case 'x':
    wp->mode[0] = MODE_EXAMINE_SURROUNDING;
    break;
  case 'p':
    wp->mode[0] = MODE_FULL_SCREEN_LOG;
    wp->mode[1] = 0;
    break;
  case 'm':
    wp->mode[0] = MODE_FULL_SCREEN_MAP;
    wp->mode[1] = wp->camera_x - scr_size_x / 2;
    wp->mode[2] = wp->camera_y - scr_size_y / 2;
    break;
  default:
    break;
  }

  if (creature_is_dead(wp, wp->player_id))
    return 0;
  player = wp->cr[wp->player_id];

  switch (c)
  {
  case '7':
  case 'y':
    player->act[0] = ACTION_WALK;
    player->act[1] = -1;
    player->act[2] = -1;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    player->act[0] = ACTION_WALK;
    player->act[1] = 0;
    player->act[2] = -1;
    break;
  case '9':
  case 'u':
    player->act[0] = ACTION_WALK;
    player->act[1] = 1;
    player->act[2] = -1;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    player->act[0] = ACTION_WALK;
    player->act[1] = -1;
    player->act[2] = 0;
    break;
  case '5':
  case '.':
    if (player->successive_run <= 0)
    {  
      player->act[0] = ACTION_STAY;
    }
    else
    {
      player->act[0] = ACTION_WALK;
      player->act[1] = 0;
      player->act[2] = 0;
    }
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    player->act[0] = ACTION_WALK;
    player->act[1] = 1;
    player->act[2] = 0;
    break;
  case '1':
  case 'b':
    player->act[0] = ACTION_WALK;
    player->act[1] = -1;
    player->act[2] = 1;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    player->act[0] = ACTION_WALK;
    player->act[1] = 0;
    player->act[2] = 1;
    break;
  case '3':
  case 'n':
    player->act[0] = ACTION_WALK;
    player->act[1] = 1;
    player->act[2] = 1;
    break;
  case 'S':
    player->act[0] = ACTION_SAVE;
    break;
  case '<':
  case '>':
    player->act[0] = ACTION_CLIMB_STAIR;
    break;
  case 's':
    player->act[0] = ACTION_TOGGLE_SEARCH_RUN;
    break;
  case 'q':
    wp->mode[0] = MODE_QUAFF;
    break;
  case 'r':
    if (wp->camera_z != player->z)
    {
      wp->camera_z = player->z;
      wp->cursor_x = player->x;
      wp->cursor_y = player->y;
    }
    wp->camera_x = player->x;
    wp->camera_y = player->y;
    wp->mode[0] = MODE_SWAP_POSITION;
    break;
  case 'z':
    wp->mode[0] = MODE_ZAP;
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_examine_surroundings(world *wp)
{
  int c;
  int dx;
  int dy;
  creature *who = NULL;

  if (wp == NULL)
    return 1;

  c = getch();

  switch (c)
  {
  case 'x':
  case 'c':
    examine_stair_destination(wp, 1);
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '.':
  case '5':
    who = find_creature_under_cursor(wp);
    if ((who != NULL)
        && ((creature_sees_grid(wp, wp->player_id,
                                who->z, who->x, who->y) > 0)
            || (player_searches_grid(wp, who->z, who->x, who->y))))
    {
      wp->mode[0] = MODE_DESCRIBE_CREATURE;
      wp->mode[1] = who->id;
    }
    break;
  default:
    break;
  }

  dx = 0;
  dy = 0;
  switch (c)
  {
  case '<':
  case '>':
    examine_stair_destination(wp, 0);
    break;
  case '7':
  case 'y':
    dx = -1;
    dy = -1;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    dx = 0;
    dy = -1;
    break;
  case '9':
  case 'u':
    dx = 1;
    dy = -1;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    dx = -1;
    dy = 0;
    break;
  case '5':
  case '.':
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    dx = 1;
    dy = 0;
    break;
  case '1':
  case 'b':
    dx = -1;
    dy = 1;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    dx = 0;
    dy = 1;
    break;
  case '3':
  case 'n':
    dx = 1;
    dy = 1;
    break;
  case ' ':
    cursor_next_target(wp);
    break;
  default:
    break;
  }

  if (distance(wp->cursor_x + dx, wp->cursor_y + dy,
               wp->camera_x, wp->camera_y) <= 8)
  {
    wp->cursor_x += dx;
    wp->cursor_y += dy;
  }

  return 0;
}

static int
loop_input_full_screen_log(world *wp)
{
  int c;

  if (wp == NULL)
    return 1;

  c = getch();

  switch (c)
  {
  case 'p':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    wp->mode[1] += 1;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    wp->mode[1] -= 1;
    break;
  case '+':
    wp->mode[1] -= 10;
    break;
  case '-':
  case ' ':
    wp->mode[1] += 10;
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_describe_creature(world *wp)
{
  int c;

  if (wp == NULL)
    return 1;

  c = getch();

  switch (c)
  {
  case 'x':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '.':
  case '5':
    wp->mode[0] = MODE_EXAMINE_SURROUNDING;
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_full_screen_map(world *wp)
{
  int c;

  if (wp == NULL)
    return 1;

  c = getch();

  switch (c)
  {
  case 'm':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '7':
  case 'y':
    wp->mode[1] += -1;
    wp->mode[2] += -1;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    wp->mode[1] += 0;
    wp->mode[2] += -1;
    break;
  case '9':
  case 'u':
    wp->mode[1] += 1;
    wp->mode[2] += -1;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    wp->mode[1] += -1;
    wp->mode[2] += 0;
    break;
  case '5':
  case '.':
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    wp->mode[1] += 1;
    wp->mode[2] += 0;
    break;
  case '1':
  case 'b':
    wp->mode[1] += -1;
    wp->mode[2] += 1;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    wp->mode[1] += 0;
    wp->mode[2] += 1;
    break;
  case '3':
  case 'n':
    wp->mode[1] += 1;
    wp->mode[2] += 1;
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_confirm_resign(world *wp)
{
  int c;

  if (wp == NULL)
    return 1;

  c = getch();

  switch (c)
  {
  case 'o':
    if (!creature_is_dead(wp, wp->player_id))
      wp->cr[wp->player_id]->hp = 0;
    wp->should_quit = 1;
    return 0;
    break;
  case 'Q':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_quaff(world *wp)
{
  int c;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  if (creature_is_dead(wp, wp->player_id))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }
  player = wp->cr[wp->player_id];

  c = getch();

  switch (c)
  {
  case '4':
  case 'h':
  case KEY_LEFT:
    if (wp->player_shield > 0)
    { 
      player->act[0] = ACTION_QUAFF_POTION_BAG;
      player->act[1] = POTION_HEALING;
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    }
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    if (wp->player_shield > 0)
    { 
      player->act[0] = ACTION_QUAFF_POTION_BAG;
      player->act[1] = POTION_SPEED;
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    }
    break;
  case 'q':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_swap_position(world *wp)
{
  int c;
  int dx;
  int dy;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  if (creature_is_dead(wp, wp->player_id))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }
  player = wp->cr[wp->player_id];

  c = getch();

  switch (c)
  {
  case 'r':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  default:
    break;
  }

  if (wp->player_shield <= 0)
    return 0;

  dx = 0;
  dy = 0;
  switch (c)
  {
  case '7':
  case 'y':
    dx = -1;
    dy = -1;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    dx = 0;
    dy = -1;
    break;
  case '9':
  case 'u':
    dx = 1;
    dy = -1;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    dx = -1;
    dy = 0;
    break;
  case '5':
  case '.':
    if ((wp->cursor_x != player->x)
        || (wp->cursor_y != player->y))
    {
      player->act[0] = ACTION_READ_SPELLBOOK_SWAP_POTISION;
      player->act[1] = wp->cursor_x;
      player->act[2] = wp->cursor_y;
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
      return 0;
    }
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    dx = 1;
    dy = 0;
    break;
  case '1':
  case 'b':
    dx = -1;
    dy = 1;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    dx = 0;
    dy = 1;
    break;
  case '3':
  case 'n':
    dx = 1;
    dy = 1;
    break;
  case ' ':
    cursor_next_target(wp);
    break;
  default:
    break;
  }

  if (distance(wp->cursor_x + dx, wp->cursor_y + dy,
               wp->camera_x, wp->camera_y) <= 8)
  {
    wp->cursor_x += dx;
    wp->cursor_y += dy;
  }

  return 0;
}

static int
loop_input_zap(world *wp)
{
  int c;
  int dx;
  int dy;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  if (creature_is_dead(wp, wp->player_id))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }
  player = wp->cr[wp->player_id];

  c = getch();
  switch (c)
  {
  case 'z':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
    break;
  default:
    break;
  }

  if (wp->player_shield <= 0)
    return 0;

  dx = 0;
  dy = 0;
  switch (c)
  {
  case '7':
  case 'y':
    dx = -1;
    dy = -1;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    dx = 0;
    dy = -1;
    break;
  case '9':
  case 'u':
    dx = 1;
    dy = -1;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    dx = -1;
    dy = 0;
    break;
  case '5':
  case '.':
    dx = 0;
    dy = 0;
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    dx = 1;
    dy = 0;
    break;
  case '1':
  case 'b':
    dx = -1;
    dy = 1;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    dx = 0;
    dy = 1;
    break;
  case '3':
  case 'n':
    dx = 1;
    dy = 1;
    break;
  default:
    return 0;
    break;
  }

  player->act[0] = ACTION_ZAP_ROD_MANA_BALL;
  player->act[1] = dx;
  player->act[2] = dy;
  wp->mode[0] = MODE_WAITING_FOR_ACTION;

  return 0;
}

static int
loop_input(world *wp)
{
  int i;
  int ret;
  creature *player = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "loop_input: wp is NULL\n");
    return 1;
  }

  switch (wp->mode[0])
  {
  case MODE_WAITING_FOR_ACTION:
    ret = loop_input_waiting_for_action(wp);
    break;
  case MODE_EXAMINE_SURROUNDING:
    ret = loop_input_examine_surroundings(wp);
    break;
  case MODE_FULL_SCREEN_LOG:
    ret = loop_input_full_screen_log(wp);
    break;
  case MODE_DESCRIBE_CREATURE:
    ret = loop_input_describe_creature(wp);
    break;
  case MODE_FULL_SCREEN_MAP:
    ret = loop_input_full_screen_map(wp);
    break;
  case MODE_CONFIRM_RESIGN:
    ret = loop_input_confirm_resign(wp);
    break;
  case MODE_QUAFF:
    ret = loop_input_quaff(wp);
    break;
  case MODE_SWAP_POSITION:
    ret = loop_input_swap_position(wp);
    break;
  case MODE_ZAP:
    ret = loop_input_zap(wp);
    break;
  default:
    ret = 1;
    break;
  }

  if (!creature_is_dead(wp, wp->player_id))
  {
    player = wp->cr[wp->player_id];
    if (!action_check(wp, player->id, player->act))
    {
      for (i = 0; i < 4; i++)
        player->act[i] = 0;
    }
  }

  return ret;
}

static int
remove_dead(world *wp)
{
  int i;

  if (wp == NULL)
    return 1;

  for (i = 0; i < wp->cr_size; i++)
  {
    /* this is necessary because NULL creature is considered dead */
    if (wp->cr[i] == NULL)
      continue;
    if (creature_is_dead(wp, i))
    {
      if (i != wp->player_id)
        remove_creature(wp, i);
    }
  }

  return 0;
}

static int
check_victory(world *wp)
{
  if (wp == NULL)
    return 1;

  if (creature_is_dead(wp, wp->player_id))
    return 0;
  if (wp->victory)
    return 0;

  if (creature_is_dead(wp, wp->queen_id))
  {
    wp->victory = 1;
  }

  return 0;
}

/* optimized under the assumptions that:
 * * the map never changes during the game
 * * the sight of the player is the square of size PLAYER_SIGHT_RANGE
 */
static int
player_remember_map(world *wp)
{
  int z;
  int x;
  int y;
  int dx;
  int dy;
  int dx_min;
  int dx_max;
  int dy_min;
  int dy_max;
  int dest_z;
  int dest_x;
  int dest_y;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return 1;
  if (wp->cr[wp->player_id] == NULL)
    return 1;
  player = wp->cr[wp->player_id];

  z = player->z;
  x = player->x;
  y = player->y;

  if ((z == wp->remember_map_from_z)
      && (x == wp->remember_map_from_x)
      && (y == wp->remember_map_from_y))
    return 0;
  wp->remember_map_from_z = z;
  wp->remember_map_from_x = x;
  wp->remember_map_from_y = y;

  if (grid_is_illegal(wp, z, x, y))
    return 1;

  dx_min = -PLAYER_SIGHT_RANGE;
  dx_max = PLAYER_SIGHT_RANGE;
  dy_min = -PLAYER_SIGHT_RANGE;
  dy_max = PLAYER_SIGHT_RANGE;
  if (x + dx_min < 0)
    dx_min = -x;
  if (x + dx_max >= wp->size_x)
    dx_max = wp->size_x - 1 - x;
  if (y + dy_min < 0)
    dy_min = -y;
  if (y + dy_max >= wp->size_y)
    dy_max = wp->size_y - 1 - y;

  for (dx = dx_min; dx <= dx_max; dx++)
  {
    for (dy = dy_min; dy <= dy_max; dy++)
    {
      /* LOS is expensive and should not be called unless necessary */
      if ((wp->grid[z][x + dx][y + dy] & GRID_PLAYER_SEEN)
          == GRID_PLAYER_SEEN)
        continue;
      if (creature_sees_grid(wp, wp->player_id,
                             z, x + dx, y + dy) <= 0)
        continue;

      wp->grid[z][x + dx][y + dy] |= GRID_PLAYER_SEEN;

      if (grid_is_stair(wp, z, x + dx, y + dy))
      {
        if (find_stair_destination(wp,
                                   z, x + dx, y + dy,
                                   &dest_z, &dest_x, &dest_y))
        {
          wp->grid[dest_z][dest_x][dest_y] |= GRID_PLAYER_SEEN;
        }
      }
    }
  }

  return 0;
}

static int
forget_old_last_known(world *wp)
{
  int i;

  if (wp == NULL)
    return 1;

  if (grid_is_illegal(wp,
                      wp->last_known_z,
                      wp->last_known_x,
                      wp->last_known_y))
    return 0;

  for (i = 0; i < wp->cr_size; i++)
  {
    if (i == wp->player_id)
      continue;
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->attitude == ATTITUDE_MONSTER_ACTIVE)
      return 0;
  }

  /* no active monster found --- probably all of them are killed */
  monster_forget_last_known(wp);

  return 0;
}

/* this must be idempotent; it must not do anything if no new action
 * is done before it is called
 */
static int
loop_upkeep_action(world *wp)
{
  if (wp == NULL)
    return 1;

  player_remember_map(wp);
  check_victory(wp);

  return 0;
}

static int
loop_upkeep_turn(world *wp, int creature_id)
{
  char buf[128];
  struct creature_detail crd;
  creature *who = NULL;

  if (wp == NULL)
    return 1;
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
    return 1;
  if (wp->cr[creature_id] == NULL)
    return 1;
  who = wp->cr[creature_id];

  if (who->id == wp->player_id)
  {    
    wp->player_is_damaged = 0;

    if ((who->attitude == ATTITUDE_PLAYER_SEARCHING)
        && (who->successive_run <= 0))
    {
      (who->timer_attitude)++;
      if (who->timer_attitude > 4)
        who->timer_attitude = 4;
    }
    else
    {
      who->timer_attitude = 0;
    }
  }

  who->successive_run = 0;

  if ((who->enchant_type > 0)
      && (who->enchant_duration > 0))
  {
    creature_detail_get(who->type, &crd);
    switch (who->enchant_type)
    {
    case ENC_POISON:
      creature_take_damage(wp, who->id, (crd.max_hp + 3) / 4,
                           -1, 0, 1);
      break;
    default:
      break;
    }

    (who->enchant_duration)--;
    if (who->enchant_duration <= 0)
    {
      sprintf(buf, "%s no longer has enchantment of %s",
              crd.name, enchantment_name(who->enchant_type));
      add_log(wp, buf);
      who->enchant_type = 0;
      who->enchant_duration = 0;
    }
  }

  return 0;
}

static int
loop_upkeep_ut(world *wp, int ut)
{
  if (wp == NULL)
    return 1;

  remove_dead(wp);
  forget_old_last_known(wp);

  wp->ut += ut;
  /* avoid overflow */
  if (wp->ut > 10000000)
    wp->ut = 10000000;

  return 0;
}

static int
loop_action_iterate(world *wp)
{
  int i;
  int ut;
  int found;

  if (wp == NULL)
    return 1;

  while ((wp->priority_now == NULL)
         || (wp->tor[wp->priority_now->n] == NULL)
         || (wp->tor[wp->priority_now->n]->wait > 0))
  {
    if (wp->priority_now == NULL)
    { 
      found = 0;
      ut = 0;
      for (i = 0; i < wp->tor_size; i++)
      {
        if (wp->tor[i] == NULL)
          continue;
        if ((!found) || (wp->tor[i]->wait < ut))
          ut = wp->tor[i]->wait;
        found = 1;
      }

      if (!found)
        return 1;

      for (i = 0; i < wp->tor_size; i++)
      {
        if (wp->tor[i] == NULL)
          continue;
        wp->tor[i]->wait -= ut;
      }

      loop_upkeep_ut(wp, ut);

      if (wp->priority_first == NULL)
        return 1;
      wp->priority_now = wp->priority_first;
    }
    else
    { 
      wp->priority_now = wp->priority_now->next;
    }
  }

  return 0;
}

/* the turn order handling is optimized under the assumption that
 * most of the entries have the same wait
 */
static int
loop_action(world *wp)
{
  int ut;
  int turn_order_id;
  creature *who = NULL;

  if (wp == NULL)
    return 1;

  if (creature_is_dead(wp, wp->player_id))
    return 0;
  if (wp->victory)
    return 0;

  do
  {
    /* we need a valid entry */
    if (loop_action_iterate(wp) != 0)
      return 1;
    turn_order_id = wp->priority_now->n;

    loop_upkeep_action(wp);

    /* skip the turn of a dead monster */
    if (creature_is_dead(wp, wp->tor[turn_order_id]->which))
    {
      /* don't skip the dead player
       * note that loop_upkeep_action() may kill the player
       */
      if (wp->tor[turn_order_id]->which == wp->player_id)
        return 0;

      wp->tor[turn_order_id]->wait += 9999;
      continue;
    }

    who = wp->cr[wp->tor[turn_order_id]->which];
    if (who == NULL)
    {
      fprintf(stderr, "loop_action: who is NULL\n");
      return 1;
    }

    if (who->id != wp->player_id)
    {
      if (action_decide_monster(wp, who->id) != 0)
      {
        fprintf(stderr, "loop_action: action_decide_monster failed\n");
        return 1;
      }
    }

    ut = action_exec(wp, who->id);
    if (ut > 0)
    {
      loop_upkeep_turn(wp, who->id);
      wp->tor[turn_order_id]->wait += ut;
    }

    /* loop_action_iterate() must be called here again
     * --- the end condition of the loop depends on it
     * turn_order_id must be updated
     */
    if (loop_action_iterate(wp) != 0)
      return 1;
    turn_order_id = wp->priority_now->n;

  } while ((wp->tor[turn_order_id]->type != TURN_ORDER_CREATURE)
           || (wp->tor[turn_order_id]->which != wp->player_id));

  /* call loop_upkeep_action() once more to handle the last action */
  loop_upkeep_action(wp);

  return 0;
}

/* does not wrap at window edge */
static int
show_multiline(world *wp, int y_top, const char *str)
{
  int i;
  int y;

  if (wp == NULL)
    return 1;

  if (str == NULL)
    return 0;

  y = y_top;
  move(y, 0);
  for (i = 0; str[i] != '\0'; i++)
  {
    if (str[i] == '\n')
    {
      y++;
      move(y, 0);
      continue;
    }
    addch(str[i]);
  }

  return 0;
}

static int
show_log(world *wp, int y_top, int y_bottom, int log_bottom)
{
  int i;
  int n;
  int y;
  int attr;

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(7);
  attron(attr);
  for (i = log_bottom; i < wp->log_size; i++)
  {
    y = y_bottom - (i - log_bottom);

    if (y < y_top)
      break;

    n = (wp->log_head - 1 - i + wp->log_size * 2) % wp->log_size;
    if (wp->log[n] == NULL)
      continue;
    mvaddstr(y, 0, wp->log[n]);
  }
  attroff(attr);

  return 0;
}

static int
loop_draw_grid(world *wp)
{
  int i;
  int j;
  int z;
  int x;
  int y;
  int attr;
  struct grid_detail grd;

  if (wp == NULL)
    return 1;

  z = wp->camera_z;
  for (i = -8; i <= 8; i++)
  {
    for (j = -8; j <= 8; j++)
    {
      x = wp->camera_x + i;
      y = wp->camera_y + j;
      if (grid_is_illegal(wp, z, x, y))
        continue;
      grid_detail_get(wp->grid[z][x][y] & GRID_TERRAIN_MASK,
                      &grd);
      attr = grd.attr;

      if (creature_sees_grid(wp, wp->player_id, z, x, y) > 0)
      {
        /* draw in in color */
        if ((wp->grid[z][x][y] & GRID_TERRAIN_MASK) == GR_FLOOR)
        {
          if (cardinal_direction(x, y, wp->camera_x, wp->camera_y) > 0)
          {
            attr = COLOR_PAIR(7);
          }
        }
      }
      else if ((wp->grid[z][x][y] & GRID_PLAYER_SEEN) == GRID_PLAYER_SEEN)
      {
        attr = COLOR_PAIR(8) | A_BOLD;
        if ((x == wp->cursor_x)
            && (y == wp->cursor_y))
        {
          attr = COLOR_PAIR(7);
        }
      }
      else
      {
        continue;
      }

      if ((wp->grid[z][x][y] & GRID_TERRAIN_MASK) == GR_FLOOR)
      {
        if ((creature_is_dead(wp, wp->player_id))
            || ((wp->cr[wp->player_id]->attitude == ATTITUDE_PLAYER_SEARCHING)
                && (distance(x, y, wp->camera_x, wp->camera_y)
                    <= wp->cr[wp->player_id]->timer_attitude * 2)))
        {
          attr |= A_BOLD;
        }
      }

      attron(attr);
      mvaddstr(j + 8, i + 8, grd.symbol);
      attroff(attr);
    }
  }

  return 0;
}

static int
loop_draw_last_known(world *wp)
{
  int attr;

  if (wp == NULL)
    return 1;

  if (grid_is_illegal(wp,
                      wp->last_known_z,
                      wp->last_known_x,
                      wp->last_known_y))
    return 0;
  if (wp->last_known_z != wp->camera_z)
    return 0;
  if (distance(wp->last_known_x, wp->last_known_y,
               wp->camera_x, wp->camera_y) > 8)
    return 0;

  if (creature_is_dead(wp, wp->player_id))
    return 0;

  if (creature_sees_grid(wp, wp->player_id,
                         wp->last_known_z,
                         wp->last_known_x,
                         wp->last_known_y) > 0)
    attr = COLOR_PAIR(1);
  else
    attr = COLOR_PAIR(7);
  attron(attr);
  mvaddstr(wp->last_known_y - wp->camera_y + 8,
           wp->last_known_x - wp->camera_x + 8,
           "&");
  attroff(attr);

  return 0;
}

static int
loop_draw_creature(world *wp)
{
  int i;
  int attr;
  char buf[128];
  creature *who = NULL;
  struct creature_detail crd;

  if (wp == NULL)
    return 1;

  for (i = 0; i < wp->cr_size; i++)
  {
    if (creature_is_dead(wp, i))
      continue;
    who = wp->cr[i];
    if (who->z != wp->camera_z)
      continue;
    if (distance(who->x, who->y,
                 wp->camera_x, wp->camera_y) > 8)
      continue;

    creature_detail_get(who->type, &crd);
    attr = COLOR_PAIR(7);
    sprintf(buf, "%s", crd.symbol);

    if (who->id == wp->player_id)
    {
      attr = COLOR_PAIR(7) | A_BOLD;
      if ((who->z == wp->last_known_z)
          && (who->x == wp->last_known_x)
          && (who->y == wp->last_known_y))
        attr = COLOR_PAIR(1) | A_BOLD;

      if (who->attitude == ATTITUDE_PLAYER_RUNNING)
        sprintf(buf, "%d",
                successive_run_max(wp, who->id) - who->successive_run + 1);
    }
    else
    {
      switch (who->attitude)
      {
      case ATTITUDE_MONSTER_UNINTERESTED:
        attr = COLOR_PAIR(7);
        break;
      case ATTITUDE_MONSTER_CONCERNED:
        attr = COLOR_PAIR(6);
        break;
      case ATTITUDE_MONSTER_ACTIVE:
        attr = COLOR_PAIR(5);
        break;
      case ATTITUDE_MONSTER_LOST:
        attr = COLOR_PAIR(3);
        break;
      default:
        attr = COLOR_PAIR(1) | A_BOLD;
        break;
      }
    }

    if (creature_sees_grid(wp, wp->player_id,
                           who->z, who->x, who->y) <= 0)
    {
      if (!player_searches_grid(wp, who->z, who->x, who->y))
        continue;

      sprintf(buf, "?");
    }

    attron(attr);
    mvaddstr(who->y - wp->camera_y + 8,
             who->x - wp->camera_x + 8,
             buf);
    attroff(attr);
  }

  return 0;
}

static int
loop_draw_stat_player(world *wp)
{
  int attr;
  struct creature_detail crd;
  char buf[128];
  creature *player = NULL;

  if (wp == NULL)
    return 1;
  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return 1;

  player = wp->cr[wp->player_id];
  if (player == NULL)
    return 1;

  creature_detail_get(player->type, &crd);

  attr = COLOR_PAIR(7);
  attron(attr);

  mvaddstr(2, 20, crd.name);

  sprintf(buf, "HP: %2d/%2d", player->hp, crd.max_hp);
  mvaddstr(3, 20, buf);

  sprintf(buf, "shield: %2d/%2d", wp->player_shield, PLAYER_SHIELD_MAX);
  mvaddstr(4, 20, buf);

  sprintf(buf, "power: %2d",
          crd.power_melee);
  mvaddstr(5, 20, buf);

  switch (player->attitude)
  {
  case ATTITUDE_PLAYER_SEARCHING:
    sprintf(buf, "%s (range %d)",
            creature_attitude_name(player->attitude),
            player->timer_attitude * 2);
    break;
  case ATTITUDE_PLAYER_RUNNING:
    sprintf(buf, "%s (%d/%d)",
            creature_attitude_name(player->attitude),
            successive_run_max(wp, player->id) + 1
            - player->successive_run,
            successive_run_max(wp, player->id) + 1);
    break;
  default:
    sprintf(buf, "%s",
            creature_attitude_name(player->attitude));
    break;
  }
  mvaddstr(6, 20, buf);
  
  if ((player->enchant_type > 0)
      && (player->enchant_duration > 0))
  {
    sprintf(buf, "(%d) %s",
            player->enchant_duration,
            enchantment_name(player->enchant_type));
    mvaddstr(7, 20, buf);
  }

  attroff(attr);

  return 0;
}

static int
loop_draw_stat_creature(world *wp, creature *who)
{
  int attr;
  struct creature_detail crd;
  char buf[128];

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  creature_detail_get(who->type, &crd);

  attr = COLOR_PAIR(7);
  attron(attr);
  if (creature_sees_grid(wp, wp->player_id,
                         who->z, who->x, who->y) <= 0)
  {
    mvaddstr(9, 20, "something");

    sprintf(buf, "%s",
            creature_attitude_name(who->attitude));
    mvaddstr(10, 20, buf);
  }
  else
  {
    mvaddstr(9, 20, crd.name);

    sprintf(buf, "HP: %2d/%2d", who->hp, crd.max_hp);
    mvaddstr(10, 20, buf);

    sprintf(buf, "power: %2d",
            crd.power_melee);
    mvaddstr(11, 20, buf);

    sprintf(buf, "%s",
            creature_attitude_name(who->attitude));
    mvaddstr(12, 20, buf);

    if ((who->enchant_type > 0)
        && (who->enchant_duration > 0))
    {
      sprintf(buf, "(%d) %s",
              who->enchant_duration, enchantment_name(who->enchant_type));
      mvaddstr(13, 20, buf);
    }
  }
  attroff(attr);

  return 0;
}

static int
loop_draw_stat(world *wp)
{
  int attr;
  char buf[128];
  creature *who = NULL;

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(7);
  attron(attr);

  sprintf(buf, "B%dF", wp->camera_z);
  mvaddstr(0, 20, buf);

  /* useful for debug */
  if (0)
  {
    if (wp->cr[wp->player_id] != NULL)
    {
      attr = COLOR_PAIR(7);
      attron(attr);
      sprintf(buf, "@=(%d, %d, %d)",
              wp->cr[wp->player_id]->z,
              wp->cr[wp->player_id]->x,
              wp->cr[wp->player_id]->y);
      mvaddstr(0, 26, buf);
      attroff(attr);
    }
  }

  loop_draw_stat_player(wp);

  who = find_creature_under_cursor(wp);
  if ((who != NULL)
      && (who->id != wp->player_id)
      && ((creature_sees_grid(wp, wp->player_id,
                              who->z, who->x, who->y) > 0)
          || (player_searches_grid(wp, who->z, who->x, who->y))))
    loop_draw_stat_creature(wp, who);

  return 0;
}

static int
loop_draw_message_waiting_for_action(world *wp)
{
  int y_bottom;
  int attr;
  int scr_size_y;

  if (wp == NULL)
    return 1;

  scr_size_y = wp->scr_size_y;

  y_bottom = scr_size_y - 2;
  if (wp->victory)
    y_bottom -= 2;
  else if (creature_is_dead(wp, wp->player_id))
    y_bottom -= 2;

  show_log(wp, 18, y_bottom, 0);

  if (wp->victory)
  {
    attr = COLOR_PAIR(6);
    attron(attr);
    mvaddstr(scr_size_y - 3, 0,
             "The Queen is dead.  You win the game!");
    mvaddstr(scr_size_y - 2, 0,
             "([x] examine, [p] log, [m] map, [Q] quit)");
    attroff(attr);
  }
  else if (creature_is_dead(wp, wp->player_id))
  {
    attr = COLOR_PAIR(6);
    attron(attr);
    mvaddstr(scr_size_y - 3, 0, "You die.");
    mvaddstr(scr_size_y - 2, 0,
             "([x] examine, [p] log, [m] map, [Q] quit)");
    attroff(attr);
  }

  return 0;
}

static int
loop_draw_message_examine_surroundings(world *wp)
{
  int z;
  int x;
  int y;
  int attr;
  struct grid_detail grd;

  if (wp == NULL)
    return 1;

  z = wp->camera_z;
  x = wp->cursor_x;
  y = wp->cursor_y;

  attr = COLOR_PAIR(6);
  attron(attr);
  mvaddstr(18, 0, "Move the cursor to exaimine.");
  attroff(attr);

  if ((!grid_is_illegal(wp, z, x, y))
      && (((wp->grid[wp->camera_z][x][y] & GRID_PLAYER_SEEN)
           == GRID_PLAYER_SEEN)
          || (creature_sees_grid(wp, wp->player_id, z, x, y) > 0)))
  {
    grid_detail_get(wp->grid[z][x][y] & GRID_TERRAIN_MASK, &grd);
    attr = COLOR_PAIR(7);
    attron(attr);
    mvaddstr(19, 0, grd.name);
    attroff(attr);
  }

  attr = COLOR_PAIR(6);
  attron(attr);
  mvaddstr(20, 0, "([space] target, [./5] describe monster, [x/c] cancel)");
  attroff(attr);

  if ((wp->player_id >= 0) && (wp->player_id < wp->cr_size)
      && (wp->cr[wp->player_id] != NULL)
      && (wp->cr[wp->player_id]->z != wp->camera_z))
  {
    attr = COLOR_PAIR(6);
    attron(attr);
    mvaddstr(21, 0, "([</>] return to current floor)");
    attroff(attr);
  }
  else if ((creature_sees_grid(wp, wp->player_id, z, x, y) > 0)
           && (find_stair_destination(wp,
                                      z, x, y,
                                      NULL, NULL, NULL)))
  {
    attr = COLOR_PAIR(6);
    attron(attr);
    mvaddstr(21, 0, "([</>] examine stair destination)");
    attroff(attr);
  }

  return 0;
}

static int
loop_draw_message_confirm_resign(world *wp)
{
  int attr;

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(6);
  attron(attr);
  mvaddstr(18, 0, "Do you really want to resign the game?.");
  mvaddstr(19, 0, "([o] confirm SUICIDE, [Q/c] cancel)");
  attroff(attr);

  return 0;
}

static int
loop_draw_message_quaff(world *wp)
{
  int attr;

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(6);
  attron(attr);

  if (wp->player_shield <= 0)
  {
    mvaddstr(18, 0, "You need a shield to use the potion bag.");
    mvaddstr(19, 0, "([q/c] cancel)");
  }
  else
  {    
    mvaddstr(18, 0, "Quaff which potion?");
    mvaddstr(19, 0, "[h/4] healing, [l/6] speed");
    mvaddstr(20, 0, "([q/c] cancel)");
  }

  attroff(attr);

  return 0;
}

static int
loop_draw_message_swap_position(world *wp)
{
  int attr;

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(6);
  attron(attr);

  if (wp->player_shield <= 0)
  {
    mvaddstr(18, 0, "You need a shield to use the spellbook of swap position.");
    mvaddstr(19, 0, "([r/c] cancel)");
  }
  else
  {    
    mvaddstr(18, 0, "Swap position with which monster?");
    mvaddstr(19, 0, "(move the cursor to the monster)");
    mvaddstr(20, 0, "([space] target, [./5] decide, [r/c] cancel)");
  }

  attroff(attr);

  return 0;
}

static int
loop_draw_message_zap(world *wp)
{
  int attr;

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(6);
  attron(attr);

  if (wp->player_shield <= 0)
  {
    mvaddstr(18, 0, "You need a shield to use the rod of mana ball.");
    mvaddstr(19, 0, "([z/c] cancel)");
  }
  else
  {    
    mvaddstr(18, 0, "Zap in which direction?");
    mvaddstr(19, 0, "([z/c] cancel)");
  }

  attroff(attr);

  return 0;
}

static int
loop_draw_message(world *wp)
{
  if (wp == NULL)
    return 1;

  switch (wp->mode[0])
  {
  case MODE_WAITING_FOR_ACTION:
    loop_draw_message_waiting_for_action(wp);
    break;
  case MODE_EXAMINE_SURROUNDING:
    loop_draw_message_examine_surroundings(wp);
    break;
  case MODE_CONFIRM_RESIGN:
    loop_draw_message_confirm_resign(wp);
    break;
  case MODE_QUAFF:
    loop_draw_message_quaff(wp);
    break;
  case MODE_SWAP_POSITION:
    loop_draw_message_swap_position(wp);
    break;
  case MODE_ZAP:
    loop_draw_message_zap(wp);
    break;
  default:
    break;
  }

  return 0;
}

/* surroundings, statistics and messages */
static int
loop_draw_three_part(world *wp)
{
  if (wp == NULL)
    return 1;

  if (distance(wp->cursor_x, wp->cursor_y,
               wp->camera_x, wp->camera_y) > 8)
  {
    if (!creature_is_dead(wp, wp->player_id))
    {
      wp->cursor_x = wp->cr[wp->player_id]->x;
      wp->cursor_y = wp->cr[wp->player_id]->y;
    }
  }
  if (distance(wp->cursor_x, wp->cursor_y,
               wp->camera_x, wp->camera_y) > 8)
  { 
    wp->cursor_x = wp->camera_x;
    wp->cursor_y = wp->camera_y;
  }

  erase();

  loop_draw_grid(wp);
  loop_draw_last_known(wp);
  loop_draw_creature(wp);
  loop_draw_stat(wp);
  loop_draw_message(wp);
  
  move(wp->cursor_y - wp->camera_y + 8,
       wp->cursor_x - wp->camera_x + 8);

  refresh();

  return 0;
}

static int
loop_draw_full_screen_log(world *wp)
{
  int attr;
  int scr_size_y;
  int line_top;
  char buf[128];

  if (wp == NULL)
    return 1;

  scr_size_y = wp->scr_size_y;

  if (wp->mode[1] > wp->log_size - (scr_size_y - 3) - 1)
    wp->mode[1] = wp->log_size - (scr_size_y - 3) - 1;
  if (wp->mode[1] < 0)
    wp->mode[1] = 0;

  erase();

  show_log(wp, 0, scr_size_y - 4, wp->mode[1]);

  attr = COLOR_PAIR(6);
  attron(attr);
  line_top = wp->log_size - wp->mode[1] - (scr_size_y - 3);
  if (line_top < 1)
    line_top = 1;
  sprintf(buf, "message log (line %d -- %d)",
          wp->log_size - wp->mode[1] - (scr_size_y - 3),
          wp->log_size - wp->mode[1]);
  mvaddstr(scr_size_y - 3, 0, buf);
  mvaddstr(scr_size_y - 2, 0,
           "([k/8] -1, [j/2] +1, [-/space] -10, [+] +10, [p/c] cancel)");
  attroff(attr);

  move(scr_size_y - 1, 0);
  refresh();

  return 0;
}

static int
loop_draw_describe_creature(world *wp)
{
  int attr;
  int scr_size_y;
  struct creature_detail crd;
  char buf[128];
  creature *who = NULL;
  const char *description = NULL;

  if (wp == NULL)
    return 1;

  scr_size_y = wp->scr_size_y;

  who = wp->cr[wp->mode[1]];
  creature_detail_get(who->type, &crd);

  erase();

  attr = COLOR_PAIR(7);
  attron(attr);

  if (creature_sees_grid(wp, wp->player_id,
                         who->z, who->x, who->y) <= 0)
  {
    sprintf(buf, "something ('?')");
    mvaddstr(0, 0, buf);
  }
  else
  {
    sprintf(buf, "%s ('%s')", crd.name, crd.symbol);
    mvaddstr(0, 0, buf);

    description = "(nothing special)";
    if ((crd.description != NULL)
        && (crd.description[0] != '\0'))
      description = crd.description;

    show_multiline(wp, 2, description);
  }

  attroff(attr);

  attr = COLOR_PAIR(6);
  attron(attr);
  mvaddstr(scr_size_y - 2, 0, "([./5] continue, [x/c] cancel)");
  attroff(attr);

  move(scr_size_y - 1, 0);
  refresh();

  return 0;
}

static int
loop_draw_full_screen_map(world *wp)
{
  int i;
  int j;
  int z;
  int x;
  int y;
  int scr_size_x;
  int scr_size_y;
  int attr;
  int type;
  struct grid_detail grd;
  struct creature_detail crd;
  char buf[128];
  creature *player = NULL;
  const char *symbol = NULL;

  if (wp == NULL)
    return 1;

  scr_size_x = wp->scr_size_x;
  scr_size_y = wp->scr_size_y;

  if (wp->mode[1] + scr_size_x / 2 > wp->size_x)
    wp->mode[1] = -(scr_size_x / 2) + wp->size_x;
  if (wp->mode[1] + scr_size_x / 2 < 0)
    wp->mode[1] = -(scr_size_x / 2);
  if (wp->mode[2] + scr_size_y / 2 > wp->size_y)
    wp->mode[2] = -(scr_size_y / 2) + wp->size_y;
  if (wp->mode[2] + scr_size_y / 2 < 0)
    wp->mode[2] = -(scr_size_y / 2);

  player = NULL;
  crd.symbol = "X";
  if ((wp->player_id >= 0) && (wp->player_id < wp->cr_size))
  {  
    player = wp->cr[wp->player_id];
    creature_detail_get(player->type, &crd);
  }

  erase();

  z = wp->camera_z;
  for (i = 0; i <= scr_size_x - 2; i++)
  {
    for (j = 0; j <= scr_size_y - 3; j++)
    {
      x = wp->mode[1] + i;
      y = wp->mode[2] + j;
      if ((z < 0) || (z >= wp->size_z))
        continue;
      if ((x < 0) || (x >= wp->size_x))
        continue;
      if ((y < 0) || (y >= wp->size_y))
        continue;

      if ((wp->grid[z][x][y] & GRID_PLAYER_SEEN) != GRID_PLAYER_SEEN)
        continue;

      type = wp->grid[z][x][y] & GRID_TERRAIN_MASK;
      grid_detail_get(type, &grd);

      attr = COLOR_PAIR(7);
      switch (type)
      {
      case GR_STAIR_DOWN_0:
      case GR_STAIR_DOWN_1:
      case GR_STAIR_DOWN_2:
      case GR_STAIR_DOWN_3:
        attr = COLOR_PAIR(2) | A_BOLD;
        break;
      case GR_STAIR_UP_0:
      case GR_STAIR_UP_1:
      case GR_STAIR_UP_2:
      case GR_STAIR_UP_3:
        attr = COLOR_PAIR(2) | A_BOLD;
        break;
      default:
        break;
      }

      symbol = grd.symbol;
      if ((player != NULL)
          && (z == player->z)
          && (x == player->x)
          && (y == player->y))
      {
        symbol = crd.symbol;
      }

      attron(attr);
      mvaddstr(j, i, symbol);
      attroff(attr);
    }
  }

  attr = COLOR_PAIR(6);
  attron(attr);
  sprintf(buf, "B%2dF ([m/c] cancel)", z);
  mvaddstr(scr_size_y - 2, 0, buf);
  attroff(attr);

  move(scr_size_y - 1, 0);
  refresh();

  return 0;
}

static int
loop_draw(world *wp)
{
  if (wp == NULL)
    return 1;

  switch (wp->mode[0])
  {
  case MODE_WAITING_FOR_ACTION:
    return loop_draw_three_part(wp);
    break;
  case MODE_EXAMINE_SURROUNDING:
    return loop_draw_three_part(wp);
    break;
  case MODE_FULL_SCREEN_LOG:
    return loop_draw_full_screen_log(wp);
    break;
  case MODE_DESCRIBE_CREATURE:
    return loop_draw_describe_creature(wp);
    break;
  case MODE_FULL_SCREEN_MAP:
    return loop_draw_full_screen_map(wp);
    break;
  case MODE_CONFIRM_RESIGN:
    return loop_draw_three_part(wp);
    break;
  case MODE_QUAFF:
    return loop_draw_three_part(wp);
    break;
  case MODE_SWAP_POSITION:
    return loop_draw_three_part(wp);
    break;
  case MODE_ZAP:
    return loop_draw_three_part(wp);
    break;
  default:
    return 1;
    break;
  }

  return 1;
}

int
main_loop(world *wp)
{
  if (wp == NULL)
  {
    fprintf(stderr, "main_loop: wp is NULL\n");
  }

  while(!(wp->should_quit))
  {
    /* loop_action() must be before loop_draw() or loop_input()
     * so that loop_upkeep_action() can be called at the beginning
     * of the game before the player do anything
     * loop_draw() must be before loop_input() so that the player
     * can see what is happening in its first turn
     */
    if (loop_action(wp) != 0)
      break;

    /* loop_action() can set wp->should_quit
     * if the player saves the game
     */
    if (wp->should_quit)
      break;

    if (loop_draw(wp) != 0)
      break;

    if (loop_input(wp) != 0)
      break;
  }

  return 0;
}
