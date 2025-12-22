#include <stdio.h>
/* malloc, atexit */
#include <stdlib.h>

#include <pdcurses/curses.h>

#include "creature.h"
#include "array.h"
#include "turn-order.h"
#include "list-int.h"

#include "world.h"

static void curses_cleanup(void);

static
void curses_cleanup(void)
{
  clear();
  refresh();
  nocbreak();
  echo();
  endwin();
}

world *
world_new(void)
{
  int i;
  int j;
  int k;
  world *wp = NULL;

  wp = (world *) malloc(sizeof(world));
  if (wp == NULL)
  {
    fprintf(stderr, "world_new: malloc(wp) failed\n");
    return NULL;
  }

  wp->cr_size = 0;
  wp->cr = NULL;
  wp->size_z = 0;
  wp->size_x = 0;
  wp->size_y = 0;
  wp->grid = NULL;
  wp->tor_size = 0;
  wp->tor = NULL;
  wp->priority_first = NULL;
  wp->priority_last = NULL;
  wp->priority_now = NULL;
  wp->player_id = -1;
  wp->queen_id = -1;
  wp->camera_z = -1;
  wp->camera_x = -1;
  wp->camera_y = -1;
  wp->last_known_z = -1;
  wp->last_known_x = -1;
  wp->last_known_y = -1;
  wp->global_decision_flag = 0;
  wp->player_shield = PLAYER_SHIELD_MAX;
  wp->player_is_damaged = 0;
  wp->remember_map_from_z = -1;
  wp->remember_map_from_x = -1;
  wp->remember_map_from_y = -1;
  wp->victory = 0;
  /* Unit of Time */
  wp->ut = 0;
  wp->scr = NULL;
  wp->save_dir = NULL;
  wp->should_quit = 0;
  wp->mode = NULL;
  wp->cursor_x = -1;
  wp->cursor_y = -1;
  wp->log_size = 0;
  wp->log = NULL;
  wp->log_head = 0;
  wp->pcache = NULL;

  wp->cr_size = 4;
  wp->cr = (creature **) malloc(sizeof(creature *) * (wp->cr_size));
  if (wp->cr == NULL)
  {
    fprintf(stderr, "world_new: malloc(wp->cr) failed\n");
    world_delete(wp);
    wp = NULL;
    return NULL;
  }
  for (i = 0; i < wp->cr_size; i++)
    wp->cr[i] = NULL;

  wp->size_z = 4;
  wp->size_x = 50;
  wp->size_y = 50;
  wp->grid = array3_new(wp->size_z, wp->size_x, wp->size_y);
  if (wp->grid == NULL)
  {
    fprintf(stderr, "world_new: array3_new(wp->grid) failed\n");
    world_delete(wp);
    wp = NULL;
    return NULL;
  }
  for (i = 0; i < wp->size_z; i++)
  {
    for (j = 0; j < wp->size_x; j++)
    {
      for (k = 0; k < wp->size_y; k++)
      {
        wp->grid[i][j][k] = -1;
      }
    }
  }

  wp->tor_size = wp->cr_size;
  wp->tor = (turn_order **) malloc(sizeof(turn_order *) * wp->tor_size);
  if (wp->tor == NULL)
  {
    fprintf(stderr, "world_new: malloc(wp->tor) failed\n");
    world_delete(wp);
    wp = NULL;
    return NULL;
  }
  for (i = 0; i < wp->tor_size; i++)
    wp->tor[i] = NULL;

  wp->mode = (int *) malloc(sizeof(int) * 4);
  if (wp->mode == NULL)
  {
    fprintf(stderr, "world_new: malloc(wp->mode) failed\n");
    world_delete(wp);
    wp = NULL;
    return NULL;
  }
  wp->mode[0] = MODE_WAITING_FOR_ACTION;
  for (i = 1; i < 4; i++)
    wp->mode[i] = 0;

  wp->log_size = 50;
  wp->log = (char **) malloc(sizeof(char *) * wp->log_size);
  if (wp->log == NULL)
  {
    fprintf(stderr, "world_new: malloc(wp->log) failed\n");
    world_delete(wp);
    wp = NULL;
    return NULL;
  }
  for (i = 0; i < wp->log_size; i++)
    wp->log[i] = NULL;

  /* should not be less than PLAYER_SIGHT_RANGE in dungeon.h
   * (do not include dungeon.h here because it makes circular dependency)
   */
  wp->pcache = player_cache_new(8);
  if (wp->pcache == NULL)
  {
    fprintf(stderr, "world_new: player_cache_new failed\n");
    world_delete(wp);
    wp = NULL;
    return NULL;
  }
  wp->pcache->z = -1;
  wp->pcache->x = -1;
  wp->pcache->y = -1;

  return wp;
}

void
world_delete(world *wp)
{
  int i;

  if (wp == NULL)
    return;

  if (wp->cr != NULL)
  {
    for (i = 0; i < wp->cr_size; i++)
    {
      if (wp->cr[i] != NULL)
      {
        creature_delete(wp->cr[i]);
        wp->cr[i] = NULL;
      }
    }
    free(wp->cr);
    wp->cr = NULL;
    wp->cr_size = 0;
  }

  if (wp->grid != NULL)
  {
    array3_delete(wp->grid, wp->size_z, wp->size_x, wp->size_y);
    wp->grid = NULL;
  }
  wp->size_z = 0;
  wp->size_x = 0;
  wp->size_y = 0;

  if (wp->tor != NULL)
  {
    for (i = 0; i < wp->tor_size; i++)
    {
      if (wp->tor[i] != NULL)
      {
        turn_order_delete(wp->tor[i]);
        wp->tor[i] = NULL;
      }
    }
    free(wp->tor);
    wp->tor = NULL;
    wp->tor_size = 0;
  }

  if (wp->priority_first != NULL)
  {
    list_int_delete_all(wp->priority_first);
    wp->priority_first = NULL;
    wp->priority_last = NULL;
  }
  if (wp->priority_last != NULL)
  {
    /* should not happen */
    list_int_delete_all(wp->priority_last);
    wp->priority_first = NULL;
    wp->priority_last = NULL;
  }
  wp->priority_now = NULL;

  if (wp->save_dir != NULL)
  {
    free(wp->save_dir);
    wp->save_dir = NULL;
  }

  if (wp->mode != NULL)
  {
    free(wp->mode);
    wp->mode = NULL;
  }

  if (wp->log != NULL)
  {
    for (i = 0; i < wp->log_size; i++)
    {
      if (wp->log[i] != NULL)
      {
        free(wp->log[i]);
        wp->log[i] = NULL;
      }
    }
    free(wp->log);
    wp->log = NULL;
    wp->log_size = 0;
  }

  if (wp->pcache != NULL)
  {
    player_cache_delete(wp->pcache);
    wp->pcache = NULL;
  }

  free(wp);
  wp = NULL;
}

int
world_init_curses(world *wp)
{
  if (wp == NULL)
  {
    fprintf(stderr, "world_init_curses: wp is NULL\n");
    return 1;
  }

  wp->scr = initscr();
  if (wp->scr == NULL)
  {
    fprintf(stderr, "world_init_curses: initscr failed\n");
    return 1;
  }
  if (atexit(&curses_cleanup) != 0)
  {
    fprintf(stderr, "world_init_curses: atexit failed\n");
    curses_cleanup();
    return 1;
  }

  start_color();
  noecho();
  cbreak();
  keypad(wp->scr, TRUE);

  init_pair(1, COLOR_RED, COLOR_BLACK);
  init_pair(2, COLOR_GREEN, COLOR_BLACK);
  init_pair(3, COLOR_YELLOW, COLOR_BLACK);
  init_pair(4, COLOR_BLUE, COLOR_BLACK);
  init_pair(5, COLOR_MAGENTA, COLOR_BLACK);
  init_pair(6, COLOR_CYAN, COLOR_BLACK);
  init_pair(7, COLOR_WHITE, COLOR_BLACK);
  init_pair(8, COLOR_BLACK, COLOR_BLACK);

  getmaxyx(wp->scr, wp->scr_size_y, wp->scr_size_x);

  return 0;
}

void
world_reset_game(world *wp)
{
  int i;
  int j;
  int k;

  if (wp == NULL)
  {
    fprintf(stderr, "world_reset_game: wp is NULL\n");
    return;
  }

  for (i = 0; i < wp->cr_size; i++)
  {
    if (wp->cr[i] != NULL)
    {
      creature_delete(wp->cr[i]);
      wp->cr[i] = NULL;
    }
  }

  for (i = 0; i < wp->size_z; i++)
  {
    for (j = 0; j < wp->size_x; j++)
    {
      for (k = 0; k < wp->size_y; k++)
      {
        wp->grid[i][j][k] = -1;
      }
    }
  }

  for (i = 0; i < wp->tor_size; i++)
  {
    if (wp->tor[i] != NULL)
    {
      turn_order_delete(wp->tor[i]);
      wp->tor[i] = NULL;
    }
  }
  if (wp->priority_first != NULL)
  {
    list_int_delete_all(wp->priority_first);
    wp->priority_first = NULL;
    wp->priority_last = NULL;
  }
  if (wp->priority_last != NULL)
  {
    /* should not happen */
    list_int_delete_all(wp->priority_last);
    wp->priority_first = NULL;
    wp->priority_last = NULL;
  }
  wp->priority_now = NULL;

  wp->player_id = -1;
  wp->queen_id = -1;
  wp->camera_z = -1;
  wp->camera_x = -1;
  wp->camera_y = -1;
  wp->last_known_z = -1;
  wp->last_known_x = -1;
  wp->last_known_y = -1;
  wp->global_decision_flag = 0;
  wp->player_shield = PLAYER_SHIELD_MAX;
  wp->player_is_damaged = 0;
  wp->remember_map_from_z = -1;
  wp->remember_map_from_x = -1;
  wp->remember_map_from_y = -1;
  wp->victory = 0;
  wp->ut = 0;
  wp->should_quit = 0;

  wp->mode[0] = MODE_WAITING_FOR_ACTION;
  for (i = 1; i < 4; i++)
    wp->mode[i] = 0;

  wp->cursor_x = -1;
  wp->cursor_y = -1;

  for (i = 0; i < wp->log_size; i++)
  {
    if (wp->log[i] != NULL)
    {
      free(wp->log[i]);
      wp->log[i] = NULL;
    }
  }
  wp->log_head = 0;

  wp->pcache->z = -1;
  wp->pcache->x = -1;
  wp->pcache->y = -1;
}

int
world_expand_cr(world *wp)
{
  int i;
  int cr_size_temp;
  creature **cr_temp = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "world_expand_cr: wp is NULL\n");
    return 1;
  }
  if (wp->cr_size <= 0)
  {
    fprintf(stderr, "world_expand_cr: wp-cr_size is non-positive (%d)\n",
            wp->cr_size);
    return 1;
  }

  cr_size_temp = wp->cr_size * 2;
  if (cr_size_temp <= wp->cr_size)
  {
    fprintf(stderr, "world_expand_cr: cr_size overflowed\n");
    return 1;
  }
  cr_temp = (creature **) realloc(wp->cr, sizeof(creature *) * cr_size_temp);
  if (cr_temp == NULL)
  {
    fprintf(stderr, "world_expand_cr: realloc failed\n");
    return 1;
  }

  wp->cr = cr_temp;
  for (i = wp->cr_size; i < cr_size_temp; i++)
    wp->cr[i] = NULL;
  wp->cr_size = cr_size_temp;

  return 0;
}

int
world_expand_tor(world *wp)
{
  int i;
  int tor_size_temp;
  turn_order **tor_temp = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "world_expand_tor: wp is NULL\n");
    return 1;
  }
  if (wp->tor_size <= 0)
  {
    fprintf(stderr, "world_expand_tor: wp->tor_size is non-positive (%d)\n",
            wp->tor_size);
    return 1;
  }

  tor_size_temp = wp->tor_size * 2;
  if (tor_size_temp <= wp->tor_size)
  {
    fprintf(stderr, "world_expand_tor: tor_size overflowed\n");
    return 1;
  }
  tor_temp = (turn_order **) realloc(wp->tor,
                                     sizeof(turn_order *) * tor_size_temp);
  if (tor_temp == NULL)
  {
    fprintf(stderr, "world_expand_tor: realloc failed\n");
    return 1;
  }

  wp->tor = tor_temp;
  for (i = wp->tor_size; i < tor_size_temp; i++)
    wp->tor[i] = NULL;
  wp->tor_size = tor_size_temp;

  return 0;
}
