#include <stdio.h>
/* malloc */
#include <stdlib.h>

#include "corridor.h"
#include "list-int.h"
#include "layer-detail.h"

#include "util-corridor.h"

static int connect_dead_end_1(corridor_builder *cbp,
                              int *maybe_unseen_floor_u,
                              int *maybe_unseen_floor_v,
                              int *frontier_u, int *frontier_v);

int
dig_marked_wall(corridor_builder *cbp, int n_mark)
{
  list_int *ulip = NULL;
  list_int *vlip = NULL;

  if (cbp == NULL)
  {
    fprintf(stderr, "dig_marked_wall: cbp is NULL\n");
    return 1;
  }
  if (n_mark > cbp->n_mark_max)
  {
    fprintf(stderr, "dig_marked_wall: n_mark is not used (%d)\n", n_mark);
    return 1;
  }
  if (n_mark >= cbp->size_mark)
  {
    fprintf(stderr, "dig_marked_wall: n_mark is out of memory (%d)\n", n_mark);
    return 1;
  }

  if (cbp->mark_dug[n_mark])
    return 0;

  ulip = cbp->marked_wall_u[n_mark];
  vlip = cbp->marked_wall_v[n_mark];
  while (1)
  {
    if ((ulip == NULL) || (vlip == NULL))
      break;

    cbp->layer[ulip->n][vlip->n] = LAYER_FLOOR;

    ulip = ulip->next;
    vlip = vlip->next;
  }

  cbp->mark_dug[n_mark] = 1;

  return 0;
}

int
connect_some(corridor_builder *cbp, int loop)
{
  int i;
  int j;

  if (cbp == NULL)
  {
    fprintf(stderr, "connect_some: cbp is NULL\n");
    return 1;
  }

  if (cbp->n_mark_max < 0)
    return 0;

  for (i = 0; i < loop; i++)
  {    
    for (j = 0; j * j < cbp->n_mark_max; j++)
    {
      dig_marked_wall(cbp, rand() % (cbp->n_mark_max + 1));
    }
  }

  return 0;
}

static int
connect_dead_end_1(corridor_builder *cbp,
                   int *maybe_unseen_floor_u,
                   int *maybe_unseen_floor_v,
                   int *frontier_u, int *frontier_v)
{
  int i;
  int j;
  int n;
  int u;
  int v;
  int u0;
  int v0;
  int temp;
  int n_mark;
  int num_floor;
  int num_frontier;
  int found;
  /* start at 1 */
  int num_floodfill;
  list_int *lip = NULL;

  if (cbp == NULL)
    return 1;
  if (maybe_unseen_floor_u == NULL)
    return 1;
  if (maybe_unseen_floor_v == NULL)
    return 1;
  if (frontier_u == NULL)
    return 1;
  if (frontier_v == NULL)
    return 1;

  num_floor = 0;
  for (u = 0; u < cbp->size_u; u++)
  {
    for (v = 0; v < cbp->size_v; v++)
    {
      switch (cbp->layer[u][v])
      {
      case LAYER_FLOOR_SEEN:
        cbp->layer[u][v] = LAYER_FLOOR;
        /* fall through */
      case LAYER_FLOOR:
        maybe_unseen_floor_u[num_floor] = u;
        maybe_unseen_floor_v[num_floor] = v;
        num_floor++;
        break;
      default:
        /* do nothing */;
        break;
      }
    }
  }

  for (i = 0; i < cbp->size_mark; i++)
    cbp->mark_seen[i] = 0;

  if (num_floor <= 0)
    return 0;

  for (i = 0; i < num_floor - 1; i++)
  {
    n = i + rand() % (num_floor - i);
    if (n == i)
      continue;

    temp = maybe_unseen_floor_u[n];
    maybe_unseen_floor_u[n] = maybe_unseen_floor_u[i];
    maybe_unseen_floor_u[i] = temp;

    temp = maybe_unseen_floor_v[n];
    maybe_unseen_floor_v[n] = maybe_unseen_floor_v[i];
    maybe_unseen_floor_v[i] = temp;
  }

  num_floodfill = 0;
  for (i = 0; i < num_floor; i++)
  {
    u = maybe_unseen_floor_u[i];
    v = maybe_unseen_floor_v[i];
    if (cbp->layer[u][v] != LAYER_FLOOR)
      continue;

    frontier_u[0] = u;
    frontier_v[0] = v;
    num_frontier = 1;
    cbp->layer[u][v] = LAYER_FLOOR_SEEN;

    num_floodfill++;
    cbp->mark_cache_num = 0;
    while (num_frontier > 0)
    {
      u0 = frontier_u[num_frontier - 1];
      v0 = frontier_v[num_frontier - 1];
      num_frontier--;
      for (j = 0; j < 4; j++)
      {
        switch (j)
        {
        case 0:
          u = u0 + 1;
          v = v0;
          break;
        case 1:
          u = u0;
          v = v0 + 1;
          break;
        case 2:
          u = u0 - 1;
          v = v0;
          break;
        default:
          u = u0;
          v = v0 - 1;
          break;
        }

        if ((u < 0) || (u >= cbp->size_u)
            || (v < 0) || (v >= cbp->size_v))
          continue;

        switch (cbp->layer[u][v])
        {
        case LAYER_FLOOR:
          frontier_u[num_frontier] = u;
          frontier_v[num_frontier] = v;
          num_frontier++;
          cbp->layer[u][v] = LAYER_FLOOR_SEEN;
          break;
        case LAYER_WALL:
        case LAYER_CORRIDOR:
        case LAYER_CORRIDOR_SEEN:
          for (lip = cbp->mark[u][v]; lip != NULL; lip = lip->next)
          {
            if (cbp->mark_seen[lip->n] < num_floodfill)
            {
              cbp->mark_seen[lip->n] = num_floodfill;
              cbp->mark_cache[cbp->mark_cache_num] = lip->n;
              (cbp->mark_cache_num)++;
            }
          }
          break;
        default:
          /* do nothing */;
          break;
        }
      }
    }

    n = 0;
    for (j = 0; j < cbp->mark_cache_num; j++)
    {
      if (cbp->mark_dug[cbp->mark_cache[j]])
        n++;
    }

    if ((n >= 2) || (n >= cbp->mark_cache_num))
      continue;

    /* assumes that each room already has at least 1 open corridor */
    n_mark = -1;
    n = 0;
    found = 0;
    for (j = 0; j < cbp->mark_cache_num; j++)
    {
      if (cbp->mark_dug[cbp->mark_cache[j]])
        continue;

      n++;
      found = 1;
      if (rand() % n == 0)
        n_mark = cbp->mark_cache[j];
    }

    if (!found)
    {
      /* should not happen */
      continue;
    }

    dig_marked_wall(cbp, n_mark);
  }

  return 0;
}

/* dig corridors so that each room will have at least 2 open corridors
 * this function does _NOT_ remove dead ends in rooms
 *
 * this function is biased; large rooms are usually checked first
 *
 * there may be an obvious "dead end" after this function is applied
 *
 * before  after
 * #####   #####
 * #.:.#   #.:.#
 * #:#:#   #:#:#
 * #.#.#   #.:.#
 * #:###   #:###
 *
 * assumes that this function is called after corridor_builder_connect()
 */
int
connect_dead_end(corridor_builder *cbp)
{
  int status;
  int *maybe_unseen_floor_u = NULL;
  int *maybe_unseen_floor_v = NULL;
  int *frontier_u = NULL;
  int *frontier_v = NULL;

  if (cbp == NULL)
  {
    fprintf(stderr, "connect_dead_end: cbp is NULL\n");
    return 1;
  }

  maybe_unseen_floor_u = (int *) malloc(sizeof(int)
                                        * cbp->size_u * cbp->size_v);
  if (maybe_unseen_floor_u == NULL)
  {
    fprintf(stderr, "connect_dead_end: malloc(maybe_unseen_floor_u) "
            "failed\n");
    return 1;
  }

  maybe_unseen_floor_v = (int *) malloc(sizeof(int)
                                        * cbp->size_u * cbp->size_v);
  if (maybe_unseen_floor_v == NULL)
  {
    fprintf(stderr, "connect_dead_end: malloc(maybe_unseen_floor_v) "
            "failed\n");
    free(maybe_unseen_floor_u);
    maybe_unseen_floor_u = NULL;
    return 1;
  }

  frontier_u = (int *) malloc(sizeof(int) * cbp->size_u * cbp->size_v);
  if (frontier_u == NULL)
  {
    fprintf(stderr, "connect_dead_end: malloc(frontier_u) failed\n");
    free(maybe_unseen_floor_u);
    maybe_unseen_floor_u = NULL;
    free(maybe_unseen_floor_v);
    maybe_unseen_floor_v = NULL;
    return 1;
  }

  frontier_v = (int *) malloc(sizeof(int) * cbp->size_u * cbp->size_v);
  if (frontier_v == NULL)
  {
    fprintf(stderr, "connect_dead_end: malloc(frontier_v) failed\n");
    free(maybe_unseen_floor_u);
    maybe_unseen_floor_u = NULL;
    free(maybe_unseen_floor_v);
    maybe_unseen_floor_v = NULL;
    free(frontier_u);
    frontier_u = NULL;
    return 1;
  }

  status = connect_dead_end_1(cbp,
                              maybe_unseen_floor_u,
                              maybe_unseen_floor_v,
                              frontier_u, frontier_v);
  if (status != 0)
  {
    fprintf(stderr, "connect_dead_end: connect_dead_end_1 failed\n");
  }

  free(maybe_unseen_floor_u);
  maybe_unseen_floor_u = NULL;
  free(maybe_unseen_floor_v);
  maybe_unseen_floor_v = NULL;
  free(frontier_u);
  frontier_u = NULL;
  free(frontier_v);
  frontier_v = NULL;

  return 0;
}
