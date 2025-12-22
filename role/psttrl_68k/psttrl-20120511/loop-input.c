#include <stdio.h>
#include <pdcurses/curses.h>

#include "world.h"
#include "dungeon.h"
#include "creature.h"
#include "action.h"
#include "creature-detail.h"
#include "post-move.h"
#include "loop-action.h"

#include "loop-input.h"

static int examine_stair_destination(world *wp, int reset_only);
static int end_examine_surroundings(world *wp);
static int cursor_manual_target(world *wp);
static int loop_input_waiting_for_action(world *wp);
static int loop_input_examine_surroundings(world *wp);
static int loop_input_full_screen_log(world *wp);
static int loop_input_describe_creature(world *wp);
static int loop_input_full_screen_map(world *wp);
static int loop_input_confirm_resign(world *wp);
static int loop_input_pickup_weapon(world *wp);
static int loop_input_drop_weapon(world *wp);
static int loop_input_change_weapon_slot(world *wp);
static int loop_input_view_player(world *wp);
static int loop_input_throw_weapon(world *wp);
static int loop_input_polymorph_self(world *wp);

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
end_examine_surroundings(world *wp)
{
  creature *who = NULL;

  if (wp == NULL)
    return 1;
  if ((wp->mode[0] != MODE_EXAMINE_SURROUNDING)
      && (wp->mode[0] != MODE_DESCRIBE_CREATURE))
    return 1;

  if ((wp->cursor_x != wp->mode[1]) || (wp->cursor_y != wp->mode[2]))
  {
    who = find_creature_under_cursor(wp);
    if ((who != NULL) && (who->id != wp->player_id))
      wp->force_cursor_target = 1;
  }

  examine_stair_destination(wp, 1);

  wp->mode[0] = MODE_WAITING_FOR_ACTION;

  return 0;
}

static int
cursor_manual_target(world *wp)
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
    if (distance(x, y, wp->camera_x, wp->camera_y) > DRAW_SURROUNDINGS_RANGE)
      continue;
    if ((creature_sees_grid(wp, wp->player_id,
                            wp->camera_z, x, y) <= 0)
        && (!player_searches_grid(wp, wp->camera_z, x, y)))
      continue;

    if ((wp->cursor_x != x) || (wp->cursor_y != y))
      wp->force_cursor_target = 1;

    wp->cursor_x = x;
    wp->cursor_y = y;

    break;
  }

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
    cursor_manual_target(wp);
    break;
  case 'x':
    wp->mode[0] = MODE_EXAMINE_SURROUNDING;
    wp->mode[1] = wp->cursor_x;
    wp->mode[2] = wp->cursor_y;
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
  case 'v':
    wp->mode[0] = MODE_VIEW_PLAYER;
    wp->mode[1] = wp->player_weapon_slot;
    break;
  default:
    break;
  }

  if (creature_is_dead(wp, wp->player_id))
    return 0;
  player = wp->cr[wp->player_id];

  if (wp->victory)
    return 0;

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
    if (wp->turn_state == TURN_STATE_NORMAL)
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
  default:
    break;
  }

  if (wp->turn_state != TURN_STATE_NORMAL)
    return 0;

  switch (c)
  {
  case '<':
  case '>':
    player->act[0] = ACTION_CLIMB_STAIR;
    break;
  case 'g':
  case ',':
    wp->mode[0] = MODE_PICKUP_WEAPON;
    wp->mode[1] = find_item_on_floor(wp, player->z, player->x, player->y,
                                     -1, 1, 1);
    if (wp->mode[1] < 0)
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case 'd':
    wp->mode[0] = MODE_DROP_WEAPON;
    break;
  case 'w':
    wp->mode[0] = MODE_CHANGE_WEAPON_SLOT;
    break;
  case 't':
    wp->mode[0] = MODE_THROW_WEAPON;
    wp->mode[1] = -1;
    break;
  case 'z':
    wp->mode[0] = MODE_POLYMORPH_SELF;
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
    end_examine_surroundings(wp);
    break;
  case 'v':
    who = find_creature_under_cursor(wp);
    if ((who != NULL)
        && (creature_sees_grid(wp, wp->player_id,
                               who->z, who->x, who->y) > 0))
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
    if ((wp->player_id >= 0)
        && (wp->player_id < wp->cr_size)
        && (wp->cr[wp->player_id] != NULL))
    {
      examine_stair_destination(wp, 1);
      wp->cursor_x = wp->cr[wp->player_id]->x;
      wp->cursor_y = wp->cr[wp->player_id]->y;
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
    cursor_manual_target(wp);
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
    end_examine_surroundings(wp);
    break;
  case 'v':
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
loop_input_pickup_weapon(world *wp)
{
  int c;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  c = getch();

  if (creature_is_dead(wp, wp->player_id))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }
  player = wp->cr[wp->player_id];

  if (wp->victory)
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }

  switch (c)
  {
  case 'g':
  case ',':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    player->act[0] = ACTION_PICKUP_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 0;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    player->act[0] = ACTION_PICKUP_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 1;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    player->act[0] = ACTION_PICKUP_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 2;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    player->act[0] = ACTION_PICKUP_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 3;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '+':
  case ' ':
    wp->mode[1] = find_item_on_floor(wp, player->z, player->x, player->y,
                                     wp->mode[1], 1, 1);
    break;
  case '-':
    wp->mode[1] = find_item_on_floor(wp, player->z, player->x, player->y,
                                     wp->mode[1], -1, 1);
    break;
  default:
    break;
  }
  
  return 0;
}

static int
loop_input_drop_weapon(world *wp)
{
  int c;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  c = getch();

  if (creature_is_dead(wp, wp->player_id))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }
  player = wp->cr[wp->player_id];

  if (wp->victory)
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }

  switch (c)
  {
  case 'd':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    if (wp->player_sheath[0] >= 0)
    { 
      player->act[0] = ACTION_DROP_WEAPON;
      player->act[1] = wp->player_sheath[0];
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    }
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    if (wp->player_sheath[1] >= 0)
    { 
      player->act[0] = ACTION_DROP_WEAPON;
      player->act[1] = wp->player_sheath[1];
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    }
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    if (wp->player_sheath[2] >= 0)
    { 
      player->act[0] = ACTION_DROP_WEAPON;
      player->act[1] = wp->player_sheath[2];
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    }
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    if (wp->player_sheath[3] >= 0)
    { 
      player->act[0] = ACTION_DROP_WEAPON;
      player->act[1] = wp->player_sheath[3];
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_change_weapon_slot(world *wp)
{
  int i;
  int c;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  c = getch();

  if (creature_is_dead(wp, wp->player_id))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }
  player = wp->cr[wp->player_id];

  if (wp->victory)
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }

  switch (c)
  {
  case 'w':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    player->act[0] = ACTION_CHANGE_WEAPON;
    player->act[1] = 0;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    player->act[0] = ACTION_CHANGE_WEAPON;
    player->act[1] = 1;
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    player->act[0] = ACTION_CHANGE_WEAPON;
    player->act[1] = 2;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    player->act[0] = ACTION_CHANGE_WEAPON;
    player->act[1] = 3;
    break;
  case '5':
  case '.':
    player->act[0] = ACTION_CHANGE_WEAPON;
    player->act[1] = -1;
    break;
  default:
    break;
  }

  if (action_check(wp, player->id, player->act))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
  }
  else
  {
    for (i = 0; i < ACT_SIZE; i++)
      player->act[i] = 0;
  }

  return 0;
}

static int
loop_input_view_player(world *wp)
{
  int c;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  c = getch();

  switch (c)
  {
  case 'v':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    wp->mode[1] = 0;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    wp->mode[1] = 1;
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    wp->mode[1] = 2;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    wp->mode[1] = 3;
    break;
  case '5':
  case '.':
    wp->mode[1] = -1;
    break;
  default:
    break;
  }

  if (creature_is_dead(wp, wp->player_id))
    return 0;
  player = wp->cr[wp->player_id];

  if (wp->victory)
    return 0;

  switch (c)
  {
  case 'w':
    if (wp->turn_state == TURN_STATE_NORMAL)
    { 
      player->act[0] = ACTION_CHANGE_WEAPON;
      player->act[1] = wp->mode[1];
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    }
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_throw_weapon(world *wp)
{
  int c;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  c = getch();

  if ((creature_is_dead(wp, wp->player_id)))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }
  player = wp->cr[wp->player_id];

  if (wp->victory)
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }

  if ((wp->mode[1] < 0) || (wp->mode[1] >= wp->itm_size))
  {  
    switch (c)
    {
    case 't':
    case 'c':
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
      break;
    case '8':
    case 'k':
    case KEY_UP:
      wp->mode[1] = wp->player_sheath[0];
      break;
    case '4':
    case 'h':
    case KEY_LEFT:
      wp->mode[1] = wp->player_sheath[1];
      break;
    case '6':
    case 'l':
    case KEY_RIGHT:
      wp->mode[1] = wp->player_sheath[2];
      break;
    case '2':
    case 'j':
    case KEY_DOWN:
      wp->mode[1] = wp->player_sheath[3];
      break;
    case '5':
    case '.':
      wp->mode[1] = wp->player_sheath[4];
      break;
    default:
      break;
    }

    return 0;
  }

  switch (c)
  {
  case 't':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '7':
  case 'y':
    player->act[0] = ACTION_THROW_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = -1;
    player->act[3] = -1;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '8':
  case 'k':
  case KEY_UP:
    player->act[0] = ACTION_THROW_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 0;
    player->act[3] = -1;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '9':
  case 'u':
    player->act[0] = ACTION_THROW_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 1;
    player->act[3] = -1;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '4':
  case 'h':
  case KEY_LEFT:
    player->act[0] = ACTION_THROW_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = -1;
    player->act[3] = 0;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '6':
  case 'l':
  case KEY_RIGHT:
    player->act[0] = ACTION_THROW_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 1;
    player->act[3] = 0;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '1':
  case 'b':
    player->act[0] = ACTION_THROW_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = -1;
    player->act[3] = 1;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '2':
  case 'j':
  case KEY_DOWN:
    player->act[0] = ACTION_THROW_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 0;
    player->act[3] = 1;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case '3':
  case 'n':
    player->act[0] = ACTION_THROW_WEAPON;
    player->act[1] = wp->mode[1];
    player->act[2] = 1;
    player->act[3] = 1;
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  default:
    break;
  }

  return 0;
}

static int
loop_input_polymorph_self(world *wp)
{
  int c;
  creature *player = NULL;

  if (wp == NULL)
    return 1;

  c = getch();

  if ((creature_is_dead(wp, wp->player_id)))
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }
  player = wp->cr[wp->player_id];

  if (wp->victory)
  {
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    return 0;
  }

  switch (c)
  {
  case 'z':
  case 'c':
    wp->mode[0] = MODE_WAITING_FOR_ACTION;
    break;
  case 'o':
    if ((wp->last_kill_type >= 0) && (wp->last_kill_type < NUM_CREATURE)
        && (player->level >= 0))
    { 
      player->act[0] = ACTION_POLYMORPH_SELF;
      wp->mode[0] = MODE_WAITING_FOR_ACTION;
    }
    break;
  default:
    break;
  }

  return 0;
}

int
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
  case MODE_PICKUP_WEAPON:
    ret = loop_input_pickup_weapon(wp);
    break;
  case MODE_DROP_WEAPON:
    ret = loop_input_drop_weapon(wp);
    break;
  case MODE_CHANGE_WEAPON_SLOT:
    ret = loop_input_change_weapon_slot(wp);
    break;
  case MODE_VIEW_PLAYER:
    ret = loop_input_view_player(wp);
    break;
  case MODE_THROW_WEAPON:
    ret = loop_input_throw_weapon(wp);
    break;
  case MODE_POLYMORPH_SELF:
    ret = loop_input_polymorph_self(wp);
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
      for (i = 0; i < ACT_SIZE; i++)
        player->act[i] = 0;
    }
  }

  return ret;
}
