#include <stdio.h>
/* malloc */
#include <stdlib.h>

#include "creature.h"

static int creature_expand_path(creature *who);

creature *
creature_new(void)
{
  int i;
  creature *p = NULL;

  p = (creature *) malloc(sizeof(creature));
  if (p == NULL)
  {
    fprintf(stderr, "creature_new: malloc(p) failed\n");
    return NULL;
  }

  p->id = -1;
  p->type = -1;
  p->z = -1;
  p->x = -1;
  p->y = -1;
  p->level = 0;
  p->hp = 1;
  p->weapon_id = -1;
  /* default is monster */
  p->attitude = ATTITUDE_MONSTER_UNINTERESTED;
  p->timer_attitude = 0;
  p->act = NULL;
  p->path_size = 8;
  p->path_x = NULL;
  p->path_y = NULL;
  p->path_z = -1;
  p->path_num = 0;
  p->path_now = 0;
  p->home_z = -1;
  p->home_x = -1;
  p->home_y = -1;
  p->timer_stuck = 0;
  p->decision_flag = DCSN_NO_MORE_STAIR;

  p->act = (int *) malloc(sizeof(int) * ACT_SIZE);
  if (p->act == NULL)
  {
    fprintf(stderr, "creature_new: malloc(p->act) failed\n");
    creature_delete(p);
    return NULL;
  }
  for (i = 0; i < ACT_SIZE; i++)
    p->act[i] = 0;

  p->path_x = (int *) malloc(sizeof(int) * 8);
  if (p->path_x == NULL)
  {
    fprintf(stderr, "creature_new: malloc(p->path_x) failed\n");
    creature_delete(p);
    return NULL;
  }

  p->path_y = (int *) malloc(sizeof(int) * 8);
  if (p->path_y == NULL)
  {
    fprintf(stderr, "creature_new: malloc(p->path_y) failed\n");
    creature_delete(p);
    return NULL;
  }

  return p;
}

void
creature_delete(creature *p)
{
  if (p == NULL)
    return;

  if (p->act != NULL)
  {
    free(p->act);
    p->act = NULL;
  }

  if (p->path_x != NULL)
  {
    free(p->path_x);
    p->path_x = NULL;
  }
  if (p->path_y != NULL)
  {
    free(p->path_y);
    p->path_y = NULL;
  }
  p->path_size = 0;

  free(p);
  p = NULL;
}

static int
creature_expand_path(creature *who)
{
  int path_size_temp;
  int *path_temp = NULL;

  if (who == NULL)
  {
    fprintf(stderr, "creature_expand_path: who is NULL\n");
    return 1;
  }
  if (who->path_size <= 0)
  {
    fprintf(stderr, "creature_expand_path: who->path_size is non-positive "
            "(%d)\n",
            who->path_size);
    return 1;
  }

  path_size_temp = who->path_size * 2;
  if (path_size_temp <= who->path_size)
  {
    fprintf(stderr, "creature_expand_path: path_size overflowed\n");
    return 1;
  }

  path_temp = (int *) realloc(who->path_x,
                              sizeof(int) * path_size_temp);
  if (path_temp == NULL)
  {
    fprintf(stderr, "creature_expand_path: realloc(path_x) failed\n");
    return 1;
  }
  who->path_x = path_temp;

  path_temp = (int *) realloc(who->path_y,
                              sizeof(int) * path_size_temp);
  if (path_temp == NULL)
  {
    fprintf(stderr, "creature_expand_path: realloc(path_y) failed\n");
    return 1;
  }
  who->path_y = path_temp;

  who->path_size = path_size_temp;

  return 0;
}

int
creature_append_path(creature *who, int x, int y)
{
  if (who == NULL)
  {
    fprintf(stderr, "creature_append_path: who is NULL\n");
    return 1;
  }

  if (who->path_num < 0)
  {
    fprintf(stderr, "creature_append_path: who->path_num is negative "
            "(%d)\n", who->path_num);
    return 1;
  }

  while (who->path_num >= who->path_size)
  {
    if (creature_expand_path(who) != 0)
    {
      fprintf(stderr, "creature_append_path: creature_expand_path failed\n");
      return 1;
    }
  }

  who->path_x[who->path_num] = x;
  who->path_y[who->path_num] = y;
  (who->path_num)++;

  return 0;
}
