#include <stdio.h>
/* free */
#include <stdlib.h>
/* strlen */
#include <string.h>
#include <pdcurses/curses.h>

#include "world.h"
#include "dungeon.h"
#include "creature.h"
#include "action.h"
#include "creature-detail.h"
#include "grid-detail.h"
#include "color-pair.h"
#include "item.h"
#include "name.h"
#include "judge.h"
#include "combat.h"
#include "weapon-detail.h"
#include "post-move.h"

#include "loop-draw.h"

/* set to 0 if your symbol should be based your type*/
#define ALWAYS_AT_SIGN 1
/* set to 1 if the last known position should be shown */
#define SHOW_LAST_KNOWN 0

static int player_is_cheating(world *wp);
static int show_multiline(world *wp, int y_top, int y_bottom,
                          int line_start, const char *str);
static int show_log(world *wp, int y_top, int y_bottom, int log_bottom);
static int show_creature_short_stat(world *wp, int creature_id,
                                    int screen_y);
static int show_description(world *wp, int creature_type,
                            int weapon_which);
static int color_by_threat(world *wp, int creature_id);
static int cursor_auto_target(world *wp);
static int loop_draw_grid(world *wp);
static int loop_draw_item(world *wp);
static int loop_draw_last_known(world *wp);
static int loop_draw_creature(world *wp);
static int loop_draw_player_sheath(world *wp, int y, int slot,
                                   int with_label);
static int loop_draw_stat_player(world *wp);
static int loop_draw_stat_creature(world *wp, creature *who);
static int loop_draw_stat(world *wp);
static int loop_draw_message_waiting_for_action(world *wp);
static int loop_draw_message_examine_surroundings(world *wp);
static int loop_draw_message_confirm_resign(world *wp);
static int loop_draw_message_pickup_weapon(world *wp);
static int loop_draw_message_drop_weapon(world *wp);
static int loop_draw_message_change_weapon_slot(world *wp);
static int loop_draw_message_throw_weapon(world *wp);
static int loop_draw_message_polymorph_self(world *wp);
static int loop_draw_message(world *wp);
static int loop_draw_three_part(world *wp);
static int loop_draw_full_screen_log(world *wp);
static int loop_draw_describe_creature(world *wp);
static int loop_draw_full_screen_map(world *wp);
static int loop_draw_view_player(world *wp);

static int
player_is_cheating(world *wp)
{
  if (wp == NULL)
    return 0;

  if (wp->cheat_color_by_threat)
    return 1;

  return 0;
}

/* assumes that every line fits the window */
static int
show_multiline(world *wp, int y_top, int y_bottom,
               int line_start, const char *str)
{
  int i;
  int y;
  int line_num;

  if (wp == NULL)
    return 1;
  if (str == NULL)
    return 0;

  y = y_top;
  move(y, 0);
  line_num = 0;
  for (i = 0; str[i] != '\0'; i++)
  {
    if (str[i] == '\n')
    {
      if (line_num >= line_start)
      { 
        y++;
        if (y > y_bottom)
          break;
        move(y, 0);
      }
      line_num++;
      continue;
    }
    if (line_num >= line_start)
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

  attr = COLOR_PAIR(CPAIR_WHITE);
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
show_creature_short_stat(world *wp, int creature_id,
                         int screen_y)
{
  char *creature_name = NULL;
  combat_stat *cbtstp = NULL;
  char buf[128];

  if (wp == NULL)
    return 1;
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
    return 1;
  if (wp->cr[creature_id] == NULL)
    return 1;

  cbtstp = combat_stat_new();
  if (cbtstp == NULL)
  {
    fprintf(stderr, "show_creature_short_stat: combat_stat_new failed\n");
    return 1;
  }

  creature_name = get_creature_name(wp, creature_id);

  if (creature_name == NULL)
    mvaddstr(screen_y, 20, "NULL");
  else
    mvaddstr(screen_y, 20, creature_name);

  if (!creature_is_dead(wp, creature_id))
  {
    creature_to_combat_stat(wp, cbtstp, creature_id);
    sprintf(buf, "DEF %d (HP %d/%d), ATK %d",
            cbtstp->defense, cbtstp->hp, cbtstp->max_hp, cbtstp->attack);
    mvaddstr(screen_y + 1, 20, buf);
  }

  if (creature_name != NULL)
  {
    free(creature_name);
    creature_name = NULL;
  }
  combat_stat_delete(cbtstp);
  cbtstp = NULL;

  return 0;
}

static int
show_description(world *wp, int creature_type,
                 int weapon_which)
{
  int attr;
  struct creature_detail crd;
  struct weapon_detail wpd;
  char buf[128];

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(CPAIR_WHITE);
  attron(attr);

  if ((creature_type >= 0) && (creature_type <NUM_CREATURE))
  {
    creature_detail_get(creature_type, &crd);

    sprintf(buf, "%s ('%s')", crd.name, crd.symbol);
    mvaddstr(0, 0, buf);

    sprintf(buf, "MHP %d, STR %d", crd.max_hp, crd.strength);
    mvaddstr(1, 0, buf);

    show_multiline(wp, 2, 9,
                   0, crd.description);
  }

  if ((weapon_which >= 0) && (weapon_which < NUM_WEAPON))
  {
    weapon_detail_get(weapon_which, &wpd);

    mvaddstr(10, 0, wpd.name);

    sprintf(buf, "DEF %+d, ATK %+d", wpd.defense, wpd.attack);
    mvaddstr(11, 0, buf);

    show_multiline(wp, 12, 19,
                   0, wpd.description);
  }
  else
  {
    mvaddstr(10, 0, "(nothing)");
  }

  attroff(attr);

  return 0;
}

static int
color_by_threat(world *wp, int creature_id)
{
  int monster_can_kill;
  int monster_can_be_killed;
  combat_judge *cbtjp = NULL;

  if (wp == NULL)
    return COLOR_PAIR(CPAIR_WHITE);
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
    return COLOR_PAIR(CPAIR_WHITE);
  if (creature_is_dead(wp, creature_id))
    return COLOR_PAIR(CPAIR_WHITE);
  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return COLOR_PAIR(CPAIR_WHITE);
  if (creature_is_dead(wp, wp->player_id))
    return COLOR_PAIR(CPAIR_WHITE);

  cbtjp = combat_judge_new();
  if (cbtjp == NULL)
  {
    fprintf(stderr, "color_by_threat: combat_judge_new failed\n");
    return COLOR_PAIR(CPAIR_WHITE);
  }

  monster_can_kill = 0;
  monster_can_be_killed = 0;

  combat_judge_reset(cbtjp);
  prepare_combat_judge(wp, cbtjp, creature_id, wp->player_id);
  cbtjp->post_move_attack = 0;
  combat_simulate(wp, cbtjp);
  if (combat_stat_is_dead(cbtjp->defender))
    monster_can_kill = 1;

  if (creature_can_post_move_attack(wp, creature_id))
  {
    combat_judge_reset(cbtjp);
    prepare_combat_judge(wp, cbtjp, creature_id, wp->player_id);
    cbtjp->post_move_attack = 1;
    combat_simulate(wp, cbtjp);
    if (combat_stat_is_dead(cbtjp->defender))
      monster_can_kill = 1;
  }

  combat_judge_reset(cbtjp);
  prepare_combat_judge(wp, cbtjp, wp->player_id, creature_id);
  cbtjp->post_move_attack = 0;
  combat_simulate(wp, cbtjp);
  if (combat_stat_is_dead(cbtjp->defender))
    monster_can_be_killed = 1;

  if (creature_can_post_move_attack(wp, wp->player_id))
  {
    combat_judge_reset(cbtjp);
    prepare_combat_judge(wp, cbtjp, wp->player_id, creature_id);
    cbtjp->post_move_attack = 1;
    combat_simulate(wp, cbtjp);
    if (combat_stat_is_dead(cbtjp->defender))
      monster_can_be_killed = 1;
  }

  combat_judge_delete(cbtjp);
  cbtjp = NULL;

  if ((monster_can_kill) && (!monster_can_be_killed))
    return COLOR_PAIR(CPAIR_MAGENTA) | A_BOLD;
  if (monster_can_kill)
    return COLOR_PAIR(CPAIR_RED);
  if (!monster_can_be_killed)
    return COLOR_PAIR(CPAIR_YELLOW);

  return COLOR_PAIR(CPAIR_WHITE);
}

static int
cursor_auto_target(world *wp)
{
  int i;
  int z;
  int x;
  int y;
  creature *who_cursor = NULL;
  creature *who_in_sight = NULL;
  creature *who_out_of_sight = NULL;
  creature *player = NULL;

  if (wp == NULL)
    return 1;
  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return 1;
  if (wp->cr[wp->player_id] == NULL)
    return 1;
  player = wp->cr[wp->player_id];

  if (wp->mode[0] != MODE_WAITING_FOR_ACTION)
    return 0;

  who_cursor = find_creature_under_cursor(wp);

  if ((who_cursor == NULL) || (who_cursor->id == wp->player_id))
    wp->force_cursor_target = 0;
  if (wp->force_cursor_target)
    return 0;

  who_in_sight = NULL;
  who_out_of_sight = NULL;
  for (i = 0; i < wp->cr_size; i++)
  {
    if (i == wp->player_id)
      continue;
    if (creature_is_dead(wp, i))
      continue;
    if (wp->cr[i]->z != wp->camera_z)
      continue;
    z = wp->cr[i]->z;
    x = wp->cr[i]->x;
    y = wp->cr[i]->y;
    if (distance(x, y, wp->camera_x, wp->camera_y) > DRAW_SURROUNDINGS_RANGE)
      continue;

    if (creature_sees_grid(wp, wp->player_id,
                           z, x, y) > 0)
    {
      if ((who_in_sight == NULL)
          || (distance(x, y, player->x, player->y)
              < distance(who_in_sight->x, who_in_sight->y,
                         player->x, player->y)))
      {
        who_in_sight = wp->cr[i];
      }
    }
    else if (player_searches_grid(wp, z, x, y))
    {
      if (who_out_of_sight == NULL)
        who_out_of_sight = wp->cr[i];
    }
  }

  if ((who_in_sight != NULL)
      && ((who_cursor == NULL) || (who_cursor->id == wp->player_id)
          || (creature_sees_grid(wp, wp->player_id,
                                 who_cursor->z,
                                 who_cursor->x,
                                 who_cursor->y) <= 0)
          || (distance(who_in_sight->x, who_in_sight->y,
                       player->x, player->y)
              < distance(who_cursor->x, who_cursor->y,
                         player->x, player->y))))
  {
    wp->cursor_x = who_in_sight->x;
    wp->cursor_y = who_in_sight->y;
  }
  else if ((who_out_of_sight != NULL)
           && ((who_cursor == NULL) || (who_cursor->id == wp->player_id)))
  {
    wp->cursor_x = who_out_of_sight->x;
    wp->cursor_y = who_out_of_sight->y;
  }

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
  for (i = -DRAW_SURROUNDINGS_RANGE; i <= DRAW_SURROUNDINGS_RANGE; i++)
  {
    for (j = -DRAW_SURROUNDINGS_RANGE; j <= DRAW_SURROUNDINGS_RANGE; j++)
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
        /* draw in color */
        if ((!creature_is_dead(wp, wp->player_id))
            && (creature_can_post_move_attack(wp, wp->player_id))
            && (wp->cr[wp->player_id]->z == wp->camera_z)
            && (wp->cr[wp->player_id]->x == wp->camera_x)
            && (wp->cr[wp->player_id]->y == wp->camera_y))
        {
          if ((wp->turn_state == TURN_STATE_NORMAL)
              || (distance(x, y, wp->camera_x, wp->camera_y) <= 1))
          {
            attr |= A_BOLD;
          }
        }
      }
      else if ((wp->grid[z][x][y] & GRID_PLAYER_SEEN) == GRID_PLAYER_SEEN)
      {
        attr = COLOR_PAIR(CPAIR_BLACK) | A_BOLD;
        if ((x == wp->cursor_x)
            && (y == wp->cursor_y))
        {
          attr = COLOR_PAIR(CPAIR_WHITE);
        }
      }
      else
      {
        continue;
      }

      attron(attr);
      mvaddstr(j + DRAW_SURROUNDINGS_RANGE,
               i + DRAW_SURROUNDINGS_RANGE,
               grd.symbol);
      attroff(attr);
    }
  }

  return 0;
}

static int
loop_draw_item(world *wp)
{
  int i;
  int attr;
  item *what = NULL;
  const char *symbol = NULL;

  if (wp == NULL)
    return 1;

  for (i = 0; i < wp->itm_size; i++)
  {
    if (item_is_dead(wp, i))
      continue;
    what = wp->itm[i];

    if (what->where != ITEM_FLOOR)
      continue;
    if (what->z != wp->camera_z)
      continue;
    if (distance(what->x, what->y,
                 wp->camera_x, wp->camera_y) > DRAW_SURROUNDINGS_RANGE)
      continue;
    if (creature_sees_grid(wp, wp->player_id,
                           what->z, what->x, what->y) <= 0)
      continue;

    switch (what->type)
    {
    case ITEM_TYPE_WEAPON:
      symbol = "/";
      break;
    case ITEM_TYPE_SCROLL:
      symbol = "-";
      break;
    default:
      symbol = "~";
      break;
    }
    attr = COLOR_PAIR(CPAIR_WHITE);

    attron(attr);
    mvaddstr(what->y - wp->camera_y + DRAW_SURROUNDINGS_RANGE,
             what->x - wp->camera_x + DRAW_SURROUNDINGS_RANGE,
             symbol);
    attroff(attr);
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
               wp->camera_x, wp->camera_y) > DRAW_SURROUNDINGS_RANGE)
    return 0;

  if (creature_is_dead(wp, wp->player_id))
    return 0;

  if (creature_sees_grid(wp, wp->player_id,
                         wp->last_known_z,
                         wp->last_known_x,
                         wp->last_known_y) > 0)
    attr = COLOR_PAIR(CPAIR_RED);
  else
    attr = COLOR_PAIR(CPAIR_WHITE);
  attron(attr);
  mvaddstr(wp->last_known_y - wp->camera_y + DRAW_SURROUNDINGS_RANGE,
           wp->last_known_x - wp->camera_x + DRAW_SURROUNDINGS_RANGE,
           "&");
  attroff(attr);

  return 0;
}

static int
loop_draw_creature(world *wp)
{
  int i;
  int attr;
  creature *who = NULL;
  struct creature_detail crd;
  char buf[128];

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
                 wp->camera_x, wp->camera_y) > DRAW_SURROUNDINGS_RANGE)
      continue;

    creature_detail_get(who->type, &crd);
    attr = COLOR_PAIR(CPAIR_WHITE);
    sprintf(buf, "%s", crd.symbol);

    if (who->id == wp->player_id)
    {
      attr = COLOR_PAIR(CPAIR_WHITE) | A_BOLD;
      if (SHOW_LAST_KNOWN)
      { 
        if ((who->z == wp->last_known_z)
            && (who->x == wp->last_known_x)
            && (who->y == wp->last_known_y))
          attr = COLOR_PAIR(CPAIR_RED) | A_BOLD;
      }
      /* set this to 0 if your symbol should be based your type */
      if (ALWAYS_AT_SIGN)
      { 
        sprintf(buf, "@");
      }
    }
    else
    {
      attr = COLOR_PAIR(CPAIR_WHITE);
      if (wp->cheat_color_by_threat)
      {     
        attr = color_by_threat(wp, who->id);
      }
    }

    if (creature_sees_grid(wp, wp->player_id,
                           who->z, who->x, who->y) <= 0)
    {
      if (!player_searches_grid(wp, who->z, who->x, who->y))
        continue;

      /* assumes that the player can always see oneself */
      sprintf(buf, "?");
      attr = COLOR_PAIR(CPAIR_WHITE);
      if (wp->cheat_color_by_threat)
      {     
        attr = color_by_threat(wp, who->id);
      }
    }

    attron(attr);
    mvaddstr(who->y - wp->camera_y + DRAW_SURROUNDINGS_RANGE,
             who->x - wp->camera_x + DRAW_SURROUNDINGS_RANGE,
             buf);
    attroff(attr);
  }

  return 0;
}

static int
loop_draw_player_sheath(world *wp, int y, int slot, int with_label)
{
  int x;
  int attr;
  char *weapon_name = NULL;

  if (wp == NULL)
    return 1;
  if ((slot < 0) || (slot >= 4))
    return 1;

  attr = COLOR_PAIR(CPAIR_WHITE);
  attron(attr);

  if (slot == wp->player_weapon_slot)
  {
    mvaddstr(y, 20, "*");
  }

  x = 21;
  if (with_label)
  {    
    switch (slot)
    {
    case 0:
      mvaddstr(y, x, "[k/8]");
      break;
    case 1:
      mvaddstr(y, x, "[h/4]");
      break;
    case 2:
      mvaddstr(y, x, "[l/6]");
      break;
    case 3:
      mvaddstr(y, x, "[j/2]");
      break;
    default:
      break;
    }
    x += 5;
  }

  x += 1;
  if ((wp->player_sheath[slot] < 0)
      || (wp->player_sheath[slot] >= wp->itm_size))
  {
    mvaddstr(y, x, "(nothing)");
  }
  else
  {
    weapon_name = get_item_name(wp,
                                wp->player_sheath[slot], 0);
    if (weapon_name == NULL)
    {
      mvaddstr(y, x, "NULL");
    }
    else
    {
      mvaddstr(y, x, weapon_name);
      free(weapon_name);
      weapon_name = NULL;
    }
  }

  attroff(attr);

  return 0;
}

static int
loop_draw_stat_player(world *wp)
{
  int i;
  int with_label;

  if (wp == NULL)
    return 1;
  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
    return 1;
  if (wp->cr[wp->player_id] == NULL)
    return 1;

  show_creature_short_stat(wp, wp->player_id, 3);

  with_label = 0;
  switch (wp->mode[0])
  {
  case MODE_PICKUP_WEAPON:
  case MODE_DROP_WEAPON:
  case MODE_CHANGE_WEAPON_SLOT:
    with_label = 1;
    break;
  case MODE_THROW_WEAPON:
    if ((wp->mode[1] < 0) || (wp->mode[1] >= wp->itm_size))
      with_label = 1;
    break;
  default:
    break;
  }

  for (i = 0; i < 4; i++)
    loop_draw_player_sheath(wp, 5 + i, i, with_label);

  return 0;
}

static int
loop_draw_stat_creature(world *wp, creature *who)
{
  int attr;
  char *item_name = NULL;

  if (wp == NULL)
    return 1;
  if (who == NULL)
    return 1;

  attr = COLOR_PAIR(CPAIR_WHITE);
  attron(attr);
  if (creature_sees_grid(wp, wp->player_id,
                         who->z, who->x, who->y) <= 0)
  {
    mvaddstr(10, 20, "something");
  }
  else
  {
    show_creature_short_stat(wp, who->id, 10);

    mvaddstr(12, 20, "*");

    if ((who->weapon_id < 0) || (who->weapon_id >= wp->itm_size))
    {
      mvaddstr(12, 22, "(nothing)");
    }
    else
    {
      item_name = get_item_name(wp, who->weapon_id, 0);
      if (item_name == NULL)
      {
        mvaddstr(12, 22, "NULL");
      }
      else
      {
        mvaddstr(12, 22, item_name);
        free(item_name);
        item_name = NULL;
      }
    }
  }
  attroff(attr);

  return 0;
}

static int
loop_draw_stat(world *wp)
{
  int attr;
  int type;
  int item_id;
  creature *who = NULL;
  creature *player = NULL;
  char *item_name = NULL;
  struct grid_detail grd;
  char buf[128];
  
  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(CPAIR_WHITE);
  attron(attr);

  sprintf(buf, "B%dF", wp->camera_z);
  mvaddstr(0, 20, buf);

  if ((wp->player_id >= 0) && (wp->player_id < wp->cr_size)
      && (wp->cr[wp->player_id] != NULL)
      && (wp->cr[wp->player_id]->z == wp->camera_z))
  {
    /* assumes that the player character can always see where he/she is */
    player = wp->cr[wp->player_id];

    type = wp->grid[player->z][player->x][player->y] & GRID_TERRAIN_MASK;
    grid_detail_get(type, &grd);

    mvaddstr(1, 20, grd.symbol);

    item_id = find_item_on_floor(wp, player->z, player->x, player->y,
                                 -1, 1, 0);
    if ((item_id >= 0) && (item_id < wp->itm_size))
    {
      item_name = get_item_name(wp, item_id, 0);
      if (item_name == NULL)
      {
        mvaddstr(1, 24, "NULL");
        ;
      }
      else
      {
        mvaddstr(1, 24, item_name);
        free(item_name);
        item_name = NULL;
      }
    }
  }

  attroff(attr);

  /* useful for debug */
  if (0)
  {
    if ((wp->player_id >= 0) && (wp->player_id < wp->cr_size)
        && (wp->cr[wp->player_id] != NULL))
    {
      attr = COLOR_PAIR(CPAIR_WHITE);
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
  int creature_type;
  struct creature_detail crd;
  char buf[128];

  if (wp == NULL)
    return 1;

  scr_size_y = wp->scr_size_y;

  y_bottom = scr_size_y - 2;
  if (wp->victory)
    y_bottom -= 2;
  else if (creature_is_dead(wp, wp->player_id))
    y_bottom -= 2;
  else if (wp->turn_state != TURN_STATE_NORMAL)
    y_bottom -= 2;

  show_log(wp, 18, y_bottom, 0);

  if (wp->victory)
  {
    if ((wp->ancient_dragon_id >= 0)
        && (wp->ancient_dragon_id < wp->cr_size)
        && (creature_is_dead(wp, wp->ancient_dragon_id)))
    {
      creature_type = wp->cr[wp->ancient_dragon_id]->type;
    }
    else if ((wp->mature_dragon_id >= 0)
        && (wp->mature_dragon_id < wp->cr_size)
        && (creature_is_dead(wp, wp->mature_dragon_id)))
    {
      creature_type = wp->cr[wp->mature_dragon_id]->type;
    }
    else if ((wp->baby_dragon_id >= 0)
        && (wp->baby_dragon_id < wp->cr_size)
        && (creature_is_dead(wp, wp->baby_dragon_id)))
    {
      creature_type = wp->cr[wp->baby_dragon_id]->type;
    }
    else
    {
      creature_type = -1;
    }

    attr = COLOR_PAIR(CPAIR_CYAN);
    attron(attr);

    if ((creature_type < 0) || (creature_type >= NUM_CREATURE))
    {
      sprintf(buf, "You are the Something Slayer!  You win the game!");
    }
    else if (player_is_cheating(wp))
    {
      sprintf(buf, "Thank you for playing.  Try without cheating next time.");
    }
    else
    {
      creature_detail_get(creature_type, &crd);
      sprintf(buf, "You are the %s Slayer!  You win the game!",
              crd.name);
    }
    mvaddstr(scr_size_y - 3, 0, buf);

    mvaddstr(scr_size_y - 2, 0,
             "([v] view yourself, [x] examine, [p] log, [m] map, [Q] quit)");
    attroff(attr);
  }
  else if (creature_is_dead(wp, wp->player_id))
  {
    attr = COLOR_PAIR(CPAIR_CYAN);
    attron(attr);
    mvaddstr(scr_size_y - 3, 0, "You die.");
    mvaddstr(scr_size_y - 2, 0,
             "([v] view yourself, [x] examine, [p] log, [m] map, [Q] quit)");
    attroff(attr);
  }
  else if (wp->turn_state != TURN_STATE_NORMAL)
  {
    attr = COLOR_PAIR(CPAIR_CYAN);
    attron(attr);
    mvaddstr(scr_size_y - 3, 0, "Post-move attack in which direction?");
    mvaddstr(scr_size_y - 2, 0,
             "([./5] attack nothing and end your turn)");
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
  int item_id;
  int message_x;
  int attr;
  char *item_name = NULL;
  struct grid_detail grd;

  if (wp == NULL)
    return 1;

  z = wp->camera_z;
  x = wp->cursor_x;
  y = wp->cursor_y;

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);
  mvaddstr(18, 0, "Move the cursor to exaimine.");
  attroff(attr);

  message_x = 0;

  if ((!grid_is_illegal(wp, z, x, y))
      && (((wp->grid[wp->camera_z][x][y] & GRID_PLAYER_SEEN)
           == GRID_PLAYER_SEEN)
          || (creature_sees_grid(wp, wp->player_id, z, x, y) > 0)))
  {
    grid_detail_get(wp->grid[z][x][y] & GRID_TERRAIN_MASK, &grd);
    attr = COLOR_PAIR(CPAIR_WHITE);
    attron(attr);
    mvaddstr(19, message_x, grd.name);
    attroff(attr);
    message_x += strlen(grd.name) + 3;
  }

  if ((!grid_is_illegal(wp, z, x, y))
      && (creature_sees_grid(wp, wp->player_id, z, x, y) > 0))
  {
    item_id = find_item_on_floor(wp, z, x, y,
                                 -1, 1, 0);
    if ((item_id >= 0) && (item_id < wp->itm_size))
    {
      item_name = get_item_name(wp, item_id, 0);

      attr = COLOR_PAIR(CPAIR_WHITE);
      attron(attr);

      if (item_name == NULL)
      {
        mvaddstr(19, message_x, "NULL");
      }
      else
      {
        mvaddstr(19, message_x, item_name);
        free(item_name);
        item_name = NULL;
      }

      attroff(attr);
    }
  }

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);
  mvaddstr(20, 0, "([space] target, [v] describe monster, "
           "[./5] reset cursor, [x/c] cancel)");
  attroff(attr);

  if ((wp->player_id >= 0) && (wp->player_id < wp->cr_size)
      && (wp->cr[wp->player_id] != NULL)
      && (wp->cr[wp->player_id]->z != wp->camera_z))
  {
    attr = COLOR_PAIR(CPAIR_CYAN);
    attron(attr);
    mvaddstr(21, 0, "([</>] return to current floor)");
    attroff(attr);
  }
  else if ((creature_sees_grid(wp, wp->player_id, z, x, y) > 0)
           && (find_stair_destination(wp,
                                      z, x, y,
                                      NULL, NULL, NULL)))
  {
    attr = COLOR_PAIR(CPAIR_CYAN);
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

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);
  mvaddstr(18, 0, "Do you really want to resign the game?");
  mvaddstr(19, 0, "([o] confirm SUICIDE, [Q/c] cancel)");
  attroff(attr);

  return 0;
}

static int
loop_draw_message_pickup_weapon(world *wp)
{
  int order;
  int count;
  int attr;
  char *weapon_name = NULL;
  creature *player = NULL;
  char buf[128];

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);
  if ((wp->mode[1] < 0) || (wp->mode[1] >= wp->itm_size))
  {
    mvaddstr(18, 0, "You can't pick up that buggy item.");
    mvaddstr(19, 0, "([g/,/c] cancel)");
  }
  else
  {
    weapon_name = get_item_name(wp, wp->mode[1], 0);
    if (weapon_name == NULL)
    {
      mvaddstr(18, 0, "Put NULL in which slot?");
    }
    else
    {
      sprintf(buf, "Put %s in which slot?", weapon_name);
      free(weapon_name);
      weapon_name = NULL;
      mvaddstr(18, 0, buf);
    }

    mvaddstr(19, 0, "([g/,/c] cancel)");

    if ((wp->player_id >= 0) && (wp->player_id < wp->cr_size))
    {
      player = wp->cr[wp->player_id];

      order = 0;
      count = count_item_on_floor(wp, player->z, player->x, player->y,
                                  wp->mode[1], &order, 1);
      if (count >= 2)
      {
        sprintf(buf, "%d/%d ([+/space] next, [-] previous)", order, count);
        mvaddstr(20, 0, buf);
      }
    }
  }

  attroff(attr);

  return 0;
}

static int
loop_draw_message_drop_weapon(world *wp)
{
  int i;
  int found;
  int attr;

  if (wp == NULL)
    return 1;

  found = 0;
  for (i = 0; i < 4; i++)
  {
    if (wp->player_sheath[i] >= 0)
    {
      found = 1;
      break;
    }
  }

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);

  if (found)
  { 
    mvaddstr(18, 0, "Drop which weapon?");
  }
  else
  { 
    mvaddstr(18, 0, "You don't have any weapon.");
  }

  mvaddstr(19, 0, "([d/c] cancel)");

  attroff(attr);

  return 0;
}

static int
loop_draw_message_change_weapon_slot(world *wp)
{
  int attr;

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);

  mvaddstr(18, 0, "Choose a weapon slot to wield a weapon.");
  mvaddstr(19, 0, "([./5] choose none, [w/c] cancel)");

  attroff(attr);

  return 0;
}

static int
loop_draw_message_throw_weapon(world *wp)
{
  int attr;
  char *item_name = NULL;
  char buf[128];

  if (wp == NULL)
    return 1;

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);

  if ((wp->mode[1] < 0) || (wp->mode[1] >= wp->itm_size))
  {
    mvaddstr(18, 0, "Throw which weapon?");
  }
  else
  {
    item_name = get_item_name(wp, wp->mode[1], 0);
    if (item_name == NULL)
      sprintf(buf, "Throw NULL in which direction?");
    else
      sprintf(buf, "Throw %s in which direction?", item_name);

    mvaddstr(18, 0, buf);

    if (item_name != NULL)
    {
      free(item_name);
      item_name = NULL;
    }
  }

  mvaddstr(19, 0, "([t/c] cancel)");

  attroff(attr);

  return 0;
}

static int
loop_draw_message_polymorph_self(world *wp)
{
  int attr;
  struct creature_detail crd;
  char buf[128];

  if (wp == NULL)
    return 1;
  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size)
      || (wp->cr[wp->player_id] == NULL))
    return 1;

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);

  if ((wp->last_kill_type < 0) || (wp->last_kill_type >= NUM_CREATURE))
  {
    mvaddstr(18, 0, "You must kill something first to cast the spell of "
             "polymorph self.");
    mvaddstr(19, 0, "([z/c] cancel)");
  }
  else if (wp->cr[wp->player_id]->level < 0)
  {
    mvaddstr(18, 0, "You don't heve enough level to cast the spell of "
             "polymorph self.");
    mvaddstr(19, 0, "([z/c] cancel)");
  }
  else
  {
    creature_detail_get(wp->last_kill_type, &crd);
    sprintf(buf, "Really change into %+d %s?",
            wp->cr[wp->player_id]->level - POLYMORPH_SELF_LEVEL_COST,
            crd.name);
    mvaddstr(18, 0, buf);
    mvaddstr(19, 0, "([o] confirm, [z/c] cancel)");
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
  case MODE_PICKUP_WEAPON:
    loop_draw_message_pickup_weapon(wp);
    break;
  case MODE_DROP_WEAPON:
    loop_draw_message_drop_weapon(wp);
    break;
  case MODE_CHANGE_WEAPON_SLOT:
    loop_draw_message_change_weapon_slot(wp);
    break;
  case MODE_THROW_WEAPON:
    loop_draw_message_throw_weapon(wp);
    break;
  case MODE_POLYMORPH_SELF:
    loop_draw_message_polymorph_self(wp);
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

  cursor_auto_target(wp);

  if (distance(wp->cursor_x, wp->cursor_y,
               wp->camera_x, wp->camera_y) > DRAW_SURROUNDINGS_RANGE)
  {
    if (!creature_is_dead(wp, wp->player_id))
    {
      wp->cursor_x = wp->cr[wp->player_id]->x;
      wp->cursor_y = wp->cr[wp->player_id]->y;
    }
  }
  if (distance(wp->cursor_x, wp->cursor_y,
               wp->camera_x, wp->camera_y) > DRAW_SURROUNDINGS_RANGE)
  { 
    wp->cursor_x = wp->camera_x;
    wp->cursor_y = wp->camera_y;
  }

  erase();

  loop_draw_grid(wp);
  loop_draw_item(wp);
  if (SHOW_LAST_KNOWN)
    loop_draw_last_known(wp);
  loop_draw_creature(wp);
  loop_draw_stat(wp);
  loop_draw_message(wp);
  
  move(wp->cursor_y - wp->camera_y + DRAW_SURROUNDINGS_RANGE,
       wp->cursor_x - wp->camera_x + DRAW_SURROUNDINGS_RANGE);

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

  attr = COLOR_PAIR(CPAIR_CYAN);
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
  int weapon_which;
  int scr_size_y;
  creature *who = NULL;

  if (wp == NULL)
    return 1;
  if ((wp->mode[1] < 0) || (wp->mode[1] >= wp->cr_size)
      || (wp->cr[wp->mode[1]] == NULL))
    return 1;
  who = wp->cr[wp->mode[1]];

  scr_size_y = wp->scr_size_y;

  erase();

  if (creature_sees_grid(wp, wp->player_id,
                         who->z, who->x, who->y) > 0)
  {
    if (creature_is_wielding_weapon(wp, who->id))
    {
      weapon_which = wp->itm[who->weapon_id]->which;
    }
    else
    {
      weapon_which = -1;
    }
    show_description(wp, who->type, weapon_which);
  }

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);
  mvaddstr(scr_size_y - 2, 0, "([v] continue, [x/c] cancel)");
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
  if (ALWAYS_AT_SIGN)
  {
    crd.symbol = "@";
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

      attr = COLOR_PAIR(CPAIR_WHITE);
      switch (type)
      {
      case GR_STAIR_DOWN_0:
      case GR_STAIR_DOWN_1:
      case GR_STAIR_DOWN_2:
      case GR_STAIR_DOWN_3:
        attr = COLOR_PAIR(CPAIR_CYAN) | A_BOLD;
        break;
      case GR_STAIR_UP_0:
      case GR_STAIR_UP_1:
      case GR_STAIR_UP_2:
      case GR_STAIR_UP_3:
        attr = COLOR_PAIR(CPAIR_CYAN) | A_BOLD;
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
        attr |= A_BOLD;
      }

      attron(attr);
      mvaddstr(j, i, symbol);
      attroff(attr);
    }
  }

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);
  sprintf(buf, "B%dF ([m/c] cancel)", z);
  mvaddstr(scr_size_y - 2, 0, buf);
  attroff(attr);

  move(scr_size_y - 1, 0);
  refresh();

  return 0;
}

static int
loop_draw_view_player(world *wp)
{
  int attr;
  int scr_size_y;
  int weapon_which;

  if (wp == NULL)
    return 1;
  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size)
      || (wp->cr[wp->player_id] == NULL))
    return 1;

  scr_size_y = wp->scr_size_y;

  erase();

  if ((wp->mode[1] >= 0) && (wp->mode[1] < 4)
      && (wp->player_sheath[wp->mode[1]] >= 0)
      && (wp->player_sheath[wp->mode[1]] < wp->itm_size)
      && (!item_is_dead(wp, wp->player_sheath[wp->mode[1]]))
      && (wp->itm[wp->player_sheath[wp->mode[1]]]->type == ITEM_TYPE_WEAPON))
  {
    weapon_which = wp->itm[wp->player_sheath[wp->mode[1]]]->which;
  }
  else
  {
    weapon_which = -1;
  }
  show_description(wp, wp->cr[wp->player_id]->type, weapon_which);

  attr = COLOR_PAIR(CPAIR_CYAN);
  attron(attr);

  mvaddstr(scr_size_y - 3, 0, "Press direction keys to view other weapons.");
  if ((creature_is_dead(wp, wp->player_id)) || (wp->victory)
      || (wp->turn_state != TURN_STATE_NORMAL))
    mvaddstr(scr_size_y - 2, 0, "([v/c] cancel)");
  else
    mvaddstr(scr_size_y - 2, 0, "([w] wield, [v/c] cancel)");

  attroff(attr);

  move(scr_size_y - 1, 0);
  refresh();

  return 0;
}

int
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
  case MODE_PICKUP_WEAPON:
    return loop_draw_three_part(wp);
    break;
  case MODE_DROP_WEAPON:
    return loop_draw_three_part(wp);
    break;
  case MODE_CHANGE_WEAPON_SLOT:
    return loop_draw_three_part(wp);
    break;
  case MODE_VIEW_PLAYER:
    return loop_draw_view_player(wp);
    break;
  case MODE_THROW_WEAPON:
    return loop_draw_three_part(wp);
    break;
  case MODE_POLYMORPH_SELF:
    return loop_draw_three_part(wp);
    break;
  default:
    return 1;
    break;
  }

  return 1;
}
