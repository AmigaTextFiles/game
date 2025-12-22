/* FILE, rename */
#include <stdio.h>
/* free */
#include <stdlib.h>
/* stat */
#include <sys/stat.h>
/* errno */
#include <errno.h>

#include "world.h"
#include "int-loader.h"
#include "creature.h"
#include "util.h"
#include "dungeon-add-remove.h"

#include "save.h"

#define SAVE_FILE_NAME "psttrl-save.txt"
#define OLD_SAVE_FILE_NAME "psttrl-save-old.txt"
#define TERMINATE_MARKER 0xdead
/* history of SAVE_FILE_VERSION:
 * 1: Fri, 11 May 2012 release
 *    Tue, 10 Apr 2012 release
 *    Fri, 23 Mar 2012 release
 * 0: Sat, 17 Mar 2012 release (the 7DRL version)
 */
#define SAVE_FILE_VERSION 1

static int save_creature(world *wp, FILE *fp);
static int save_turn_order(world *wp, FILE *fp);
static int save_priority(world *wp, FILE *fp);
static int save_item(world *wp, FILE *fp);
static int save_grid(world *wp, FILE *fp);

static void load_creature(world *wp, int_loader *ilp);
static void load_turn_order(world *wp, int_loader *ilp);
static void load_priority(world *wp, int_loader *ilp);
static void load_item(world *wp, int_loader *ilp);
static void load_grid(world *wp, int_loader *ilp);

static int
save_creature(world *wp, FILE *fp)
{
  int i;
  int j;
  int error_found;
  int num_creature;
  creature *who = NULL;

  if (wp == NULL)
    return 1;
  if (fp == NULL)
    return 1;

  error_found = 0;

  num_creature = 0;
  for (i = 0; i < wp->cr_size; i++)
  {
    if (wp->cr[i] == NULL)
      continue;
    num_creature++;
  }

  if (fprintf(fp, "# creature\n") < 0)
    error_found = 1;

  if (fprintf(fp, "## number of creatures\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", num_creature) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  for (i = 0; i < wp->cr_size; i++)
  {
    who = wp->cr[i];
    if (who == NULL)
      continue;

    if (fprintf(fp, "## creature %d\n", who->id) < 0)
      error_found = 1;

    if (fprintf(fp, "%d\n", who->id) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->type) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->z) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->x) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->y) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->level) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->hp) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->weapon_id) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->attitude) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->timer_attitude) < 0)
      error_found = 1;
    for (j = 0; j < ACT_SIZE; j++)
    {
      if (fprintf(fp, "%d\n", who->act[j]) < 0)
        error_found = 1;
    }
    /* path_num must be before path_x/y */
    if (fprintf(fp, "%d\n", who->path_num) < 0)
      error_found = 1;
    for (j = 0; j < who->path_num; j++)
    {
      if (fprintf(fp, "%d\n", who->path_x[j]) < 0)
        error_found = 1;
      if (fprintf(fp, "%d\n", who->path_y[j]) < 0)
        error_found = 1;
    }
    if (fprintf(fp, "%d\n", who->path_z) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->path_now) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->home_z) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->home_x) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->home_y) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->timer_stuck) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", who->decision_flag) < 0)
      error_found = 1;
  }

  if (fprintf(fp, "# creature end\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%#x\n", TERMINATE_MARKER) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  return error_found;
}

static int
save_turn_order(world *wp, FILE *fp)
{
  int i;
  int error_found;
  int num_turn_order;
  turn_order *what = NULL;

  if (wp == NULL)
    return 1;
  if (fp == NULL)
    return 1;

  error_found = 0;

  num_turn_order = 0;
  for (i = 0; i < wp->tor_size; i++)
  {
    if (wp->tor[i] == NULL)
      continue;
    num_turn_order++;
  }

  if (fprintf(fp, "# turn order\n") < 0)
    error_found = 1;

  if (fprintf(fp, "## number of turn orders\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", num_turn_order) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  for (i = 0; i < wp->tor_size; i++)
  {
    what = wp->tor[i];
    if (what == NULL)
      continue;

    if (fprintf(fp, "## turn order %d\n", what->id) < 0)
      error_found = 1;

    if (fprintf(fp, "%d\n", what->id) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->type) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->which) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->wait) < 0)
      error_found = 1;
  }

  if (fprintf(fp, "# turn order end\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%#x\n", TERMINATE_MARKER) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  return error_found;
}

static int
save_priority(world *wp, FILE *fp)
{
  int n;
  int error_found;
  list_int *pri = NULL;

  if (wp == NULL)
    return 1;
  if (fp == NULL)
    return 1;

  error_found = 0;

  if (fprintf(fp, "# priority\n") < 0)
    error_found = 1;

  n = 0;
  for (pri = wp->priority_first; pri != NULL; pri = pri->next)
    n++;

  if (fprintf(fp, "## number of priority\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", n) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  for (pri = wp->priority_first; pri != NULL; pri = pri->next)
  {
    if (fprintf(fp, "%d\n", pri->n) < 0)
      error_found = 1;
  }

  n = 0;
  for (pri = wp->priority_first;
       (pri != NULL) && (pri != wp->priority_now); pri = pri->next)
  {  
    n++;
  }
  
  if (fprintf(fp, "## index of priority_now\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", n) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  if (fprintf(fp, "# priority end\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%#x\n", TERMINATE_MARKER) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  return error_found;
}

static int
save_item(world *wp, FILE *fp)
{
  int i;
  int error_found;
  int num_item;
  item *what = NULL;

  if (wp == NULL)
    return 1;
  if (fp == NULL)
    return 1;

  error_found = 0;

  num_item = 0;
  for (i = 0; i < wp->itm_size; i++)
  {
    if (wp->itm[i] == NULL)
      continue;
    num_item++;
  }

  if (fprintf(fp, "# item\n") < 0)
    error_found = 1;

  if (fprintf(fp, "## number of items\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", num_item) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  for (i = 0; i < wp->itm_size; i++)
  {
    what = wp->itm[i];
    if (what == NULL)
      continue;

    if (fprintf(fp, "## item %d\n", what->id) < 0)
      error_found = 1;

    if (fprintf(fp, "%d\n", what->id) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->type) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->which) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->quantity) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->where) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->owner) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->z) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->x) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->y) < 0)
      error_found = 1;
    if (fprintf(fp, "%d\n", what->thrown) < 0)
      error_found = 1;
  }

  if (fprintf(fp, "# item end\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%#x\n", TERMINATE_MARKER) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  return error_found;
}

static int
save_grid(world *wp, FILE *fp)
{
  int z;
  int x;
  int y;
  int error_found;

  if (wp == NULL)
    return 1;
  if (fp == NULL)
    return 1;

  error_found = 0;

  if (fprintf(fp, "# grid\n") < 0)
    error_found = 1;

  if (fprintf(fp, "## size\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n",
              wp->size_z) < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n",
              wp->size_x) < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n",
              wp->size_y) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  for (z = 0; z < wp->size_z; z++)
  {
    for (x = 0; x < wp->size_x; x++)
    {
      if (fprintf(fp, "## grid (%d, %d, y)\n", z, x) < 0)
        error_found = 1;

      for (y = 0; y < wp->size_y; y++)
      {
        if (fprintf(fp, "%d\n", wp->grid[z][x][y]) < 0)
          error_found = 1;
      }
    }
  }


  if (fprintf(fp, "# grid end\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%#x\n", TERMINATE_MARKER) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  return error_found;
}

static void
load_creature(world *wp, int_loader *ilp)
{
  int i;
  int j;
  int x;
  int y;
  int num_creature;
  int path_num;
  creature *who = NULL;

  if (wp == NULL)
    return;
  if (ilp == NULL)
    return;

  num_creature = int_loader_get(ilp);
  for (i = 0; i < num_creature; i++)
  {
    who = creature_new();
    if (who == NULL)
    {
      ilp->error_found = 1;
      break;
    }

    who->id = int_loader_get(ilp);
    who->type = int_loader_get(ilp);
    who->z = int_loader_get(ilp);
    who->x = int_loader_get(ilp);
    who->y = int_loader_get(ilp);
    who->level = int_loader_get(ilp);
    who->hp = int_loader_get(ilp);
    who->weapon_id = int_loader_get(ilp);
    who->attitude = int_loader_get(ilp);
    who->timer_attitude = int_loader_get(ilp);
    for (j = 0; j < ACT_SIZE; j++)
      who->act[j] = int_loader_get(ilp);
    /* wp->path_num is set by creature_append_path() below */
    path_num = int_loader_get(ilp);
    for (j = 0; j < path_num; j++)
    {
      x = int_loader_get(ilp);
      y = int_loader_get(ilp);
      if (creature_append_path(who, x, y) != 0)
      {
        ilp->error_found = 1;
        break;
      }
    }
    who->path_z = int_loader_get(ilp);
    who->path_now = int_loader_get(ilp);
    who->home_z = int_loader_get(ilp);
    who->home_x = int_loader_get(ilp);
    who->home_y = int_loader_get(ilp);
    who->timer_stuck = int_loader_get(ilp);
    who->decision_flag = int_loader_get(ilp);

    if (add_creature_here(wp, who, who->id) < 0)
    {
      ilp->error_found = 1;
      creature_delete(who);
      who = NULL;
      break;
    }
  }

  if (int_loader_get(ilp) != TERMINATE_MARKER)
  {
    ilp->error_found = 1;
  }
}

static void
load_turn_order(world *wp, int_loader *ilp)
{
  int i;
  int num_turn_order;
  turn_order *what = NULL;

  if (wp == NULL)
    return;
  if (ilp == NULL)
    return;

  num_turn_order = int_loader_get(ilp);
  for (i = 0; i < num_turn_order; i++)
  {
    what = turn_order_new();
    if (what == NULL)
    {
      ilp->error_found = 1;
      break;
    }

    what->id = int_loader_get(ilp);
    what->type = int_loader_get(ilp);
    what->which = int_loader_get(ilp);
    what->wait = int_loader_get(ilp);

    if (add_turn_order_here(wp, what, what->id) < 0)
    {
      ilp->error_found = 1;
      turn_order_delete(what);
      what = NULL;
      break;
    }
  }

  if (int_loader_get(ilp) != TERMINATE_MARKER)
  {
    ilp->error_found = 1;
  }
}

static void
load_priority(world *wp, int_loader *ilp)
{
  int i;
  int n;

  if (wp == NULL)
    return;
  if (ilp == NULL)
    return;

  n = int_loader_get(ilp);
  for (i = 0; i < n; i++)
    add_priority_last(wp, int_loader_get(ilp));

  wp->priority_now = wp->priority_first;
  n = int_loader_get(ilp);
  for (i = 0; i < n; i++)
  {
    if (wp->priority_now == NULL)
    {
      ilp->error_found = 1;
      break;
    }

    wp->priority_now = wp->priority_now->next;
  }

  if (int_loader_get(ilp) != TERMINATE_MARKER)
  {
    ilp->error_found = 1;
  }
}

static void
load_item(world *wp, int_loader *ilp)
{
  int i;
  int num_creature;
  item *what = NULL;

  if (wp == NULL)
    return;
  if (ilp == NULL)
    return;

  num_creature = int_loader_get(ilp);
  for (i = 0; i < num_creature; i++)
  {
    what = item_new();
    if (what == NULL)
    {
      ilp->error_found = 1;
      break;
    }

    what->id = int_loader_get(ilp);
    what->type = int_loader_get(ilp);
    what->which = int_loader_get(ilp);
    what->quantity = int_loader_get(ilp);
    what->where = int_loader_get(ilp);
    what->owner = int_loader_get(ilp);
    what->z = int_loader_get(ilp);
    what->x = int_loader_get(ilp);
    what->y = int_loader_get(ilp);
    what->thrown = int_loader_get(ilp);

    if (add_item_here(wp, what, what->id) < 0)
    {
      ilp->error_found = 1;
      item_delete(what);
      what = NULL;
      break;
    }
  }
  
  if (int_loader_get(ilp) != TERMINATE_MARKER)
  {
    ilp->error_found = 1;
  }
}

static void
load_grid(world *wp, int_loader *ilp)
{
  int z;
  int x;
  int y;

  if (wp == NULL)
    return;
  if (ilp == NULL)
    return;

  if (int_loader_get(ilp) != wp->size_z)
  {
    ilp->error_found = 1;
  }
  if (int_loader_get(ilp) != wp->size_x)
  {
    ilp->error_found = 1;
  }
  if (int_loader_get(ilp) != wp->size_y)
  {
    ilp->error_found = 1;
  }

  for (z = 0; z < wp->size_z; z++)
  {
    for (x = 0; x < wp->size_x; x++)
    {
      for (y = 0; y < wp->size_y; y++)
      {
        wp->grid[z][x][y] = int_loader_get(ilp);
      }
    }
  }

  if (int_loader_get(ilp) != TERMINATE_MARKER)
  {
    ilp->error_found = 1;
  }
}


/* return 0 on success, 1 on error */
int
save_game(world *wp)
{
  int i;
  int error_found;
  char *save_path = NULL;
  FILE *fp = NULL;

  if (wp == NULL)
    return 1;

  if (wp->save_dir != NULL)
  {
    save_path = concat_string(3, wp->save_dir, "/", SAVE_FILE_NAME);
  }
  else
  {  
    save_path = concat_string(1, SAVE_FILE_NAME);
  }
  if (save_path == NULL)
    return 1;

  fp = fopen(save_path, "w");
  if (fp == NULL)
  {
    free(save_path);
    save_path = NULL;
    return 1;
  }

  error_found = 0;

  if (fprintf(fp, "# psttrl save file\n") < 0)
    error_found = 1;
  if (fprintf(fp, "# DO NOT EDIT\n") < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  if (fprintf(fp, "# save file version\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", SAVE_FILE_VERSION) < 0)
    error_found = 1;
  if (fprintf(fp, "\n") < 0)
    error_found = 1;

  /* creature */
  if (save_creature(wp, fp) != 0)
    error_found = 1;

  /* turn order */
  if (save_turn_order(wp, fp) != 0)
    error_found = 1;

  /* priority */
  if (save_priority(wp, fp) != 0)
    error_found = 1;

  /* item */
  if (save_item(wp, fp) != 0)
    error_found = 1;

  /* grid */
  if (save_grid(wp, fp) != 0)
    error_found = 1;

  /* the rest */
  if (fprintf(fp, "# player_id\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->player_id) < 0)
    error_found = 1;

  if (fprintf(fp, "# ancient_dragon_id\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->ancient_dragon_id) < 0)
    error_found = 1;

  if (fprintf(fp, "# mature_dragon_id\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->mature_dragon_id) < 0)
    error_found = 1;

  if (fprintf(fp, "# baby_dragon_id\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->baby_dragon_id) < 0)
    error_found = 1;

  if (fprintf(fp, "# player_sheath\n") < 0)
    error_found = 1;
  for (i = 0; i < 4; i++)
  {
    if (fprintf(fp, "%d\n", wp->player_sheath[i]) < 0)
      error_found = 1;
  }

  if (fprintf(fp, "# player_weapon_slot\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->player_weapon_slot) < 0)
    error_found = 1;

  if (fprintf(fp, "# last_kill_type\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->last_kill_type) < 0)
    error_found = 1;

  if (fprintf(fp, "# player_z_max\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->player_z_max) < 0)
    error_found = 1;

  if (fprintf(fp, "# turn_state \n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->turn_state) < 0)
    error_found = 1;

  if (fprintf(fp, "# camera_z\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->camera_z) < 0)
    error_found = 1;

  if (fprintf(fp, "# camera_x\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->camera_x) < 0)
    error_found = 1;

  if (fprintf(fp, "# camera_y\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->camera_y) < 0)
    error_found = 1;

  if (fprintf(fp, "# last_known_z\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->last_known_z) < 0)
    error_found = 1;

  if (fprintf(fp, "# last_known_x\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->last_known_x) < 0)
    error_found = 1;

  if (fprintf(fp, "# last_known_y\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->last_known_y) < 0)
    error_found = 1;

  if (fprintf(fp, "# remember_map_from_z\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->remember_map_from_z) < 0)
    error_found = 1;

  if (fprintf(fp, "# remember_map_from_x\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->remember_map_from_x) < 0)
    error_found = 1;

  if (fprintf(fp, "# remember_map_from_y\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->remember_map_from_y) < 0)
    error_found = 1;

  if (fprintf(fp, "# victory\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->victory) < 0)
    error_found = 1;

  if (fprintf(fp, "# ut\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->ut) < 0)
    error_found = 1;

  if (fprintf(fp, "# cheat_color_by_threat\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%d\n", wp->cheat_color_by_threat) < 0)
    error_found = 1;


  if (fprintf(fp, "\n") < 0)
    error_found = 1;
  if (fprintf(fp, "# save file end\n") < 0)
    error_found = 1;
  if (fprintf(fp, "%#x\n", TERMINATE_MARKER) < 0)
    error_found = 1;

  if (fclose(fp) != 0)
    error_found = 1;
  fp = NULL;

  free(save_path);
  save_path = NULL;

  if (error_found != 0)
    return 1;

  return 0;
}

/* return
 * 0 if a saved game is successfully loaded
 * 1 if no saved game is found
 * 2 on error
 */
int
load_game(world *wp)
{
  int i;
  int error_found;
  struct stat buf_stat;
  char *save_path = NULL;
  char *old_save_path = NULL;
  int_loader *ilp = NULL;
  creature *who = NULL;

  if (wp == NULL)
    return 2;

  world_reset_game(wp);

  if (wp->save_dir != NULL)
  {
    save_path = concat_string(3, wp->save_dir, "/", SAVE_FILE_NAME);
  }
  else
  {
    save_path = concat_string(1, SAVE_FILE_NAME);
  }

  if (save_path == NULL)
    return 2;

  errno = 0;
  if (stat(save_path, &buf_stat) != 0)
  {
    free(save_path);
    save_path = NULL;

    if (errno == ENOENT)
      return 1;
    return 2;
  }

  ilp = int_loader_new(save_path);
  if (ilp == NULL)
  {
    free(save_path);
    save_path = NULL;

    return 2;
  }

  /* save file version */
  if (int_loader_get(ilp) != SAVE_FILE_VERSION)
  {
    ilp->error_found = 1;
  }

  /* creature */
  load_creature(wp, ilp);

  /* turn order */
  load_turn_order(wp, ilp);

  /* priority */
  load_priority(wp, ilp);

  /* item */
  load_item(wp, ilp);

  /* grid */
  load_grid(wp, ilp);

  /* the rest */
  wp->player_id = int_loader_get(ilp);
  if ((wp->player_id < 0) || (wp->player_id >= wp->cr_size))
  {
    ilp->error_found = 1;
  }
  if (wp->cr[wp->player_id] == NULL)
  {
    ilp->error_found = 1;
  }

  wp->ancient_dragon_id = int_loader_get(ilp);
  wp->mature_dragon_id = int_loader_get(ilp);
  wp->baby_dragon_id = int_loader_get(ilp);

  for (i = 0; i < 4; i++)
    wp->player_sheath[i] = int_loader_get(ilp);

  wp->player_weapon_slot = int_loader_get(ilp);
  wp->last_kill_type = int_loader_get(ilp);
  wp->player_z_max = int_loader_get(ilp);
  wp->turn_state = int_loader_get(ilp);
  wp->camera_z = int_loader_get(ilp);
  wp->camera_x = int_loader_get(ilp);
  wp->camera_y = int_loader_get(ilp);
  wp->last_known_z = int_loader_get(ilp);
  wp->last_known_x = int_loader_get(ilp);
  wp->last_known_y = int_loader_get(ilp);
  wp->remember_map_from_z = int_loader_get(ilp);
  wp->remember_map_from_x = int_loader_get(ilp);
  wp->remember_map_from_y = int_loader_get(ilp);
  wp->victory = int_loader_get(ilp);
  wp->ut = int_loader_get(ilp);
  wp->cheat_color_by_threat = int_loader_get(ilp);

  /* save file end */
  if (int_loader_get(ilp) != TERMINATE_MARKER)
  {
    ilp->error_found = 1;
  }

  if (ilp->error_found)
  {
    fprintf(stderr, "load error: ");
    if (ilp->error_message != NULL)
    {
      fprintf(stderr, "%s ", ilp->error_message);
    }
    fprintf(stderr, "at line %d\n", ilp->line_number);
  }

  error_found = ilp->error_found;
  int_loader_delete(ilp);
  ilp = NULL;

  /* the "save game" action in the previous game is done */
  who = wp->cr[wp->player_id];
  for (i = 0; i < ACT_SIZE; i++)
    who->act[i] = 0;

  wp->cursor_x = wp->camera_x;
  wp->cursor_y = wp->camera_y;

  /* rename the old save file if possible */
  if (wp->save_dir != NULL)
  {
    old_save_path = concat_string(3, wp->save_dir, "/", OLD_SAVE_FILE_NAME);
  }
  else
  {
    old_save_path = concat_string(1, OLD_SAVE_FILE_NAME);
  }

  if (old_save_path != NULL)
  {
    rename(save_path, old_save_path);
    free(old_save_path);
    old_save_path = NULL;
  }

  free(save_path);
  save_path = NULL;

  if (error_found != 0)
    return 2;

  return 0;
}
