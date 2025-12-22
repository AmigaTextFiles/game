#include <stdio.h>
/* malloc, rand */
#include <stdlib.h>

#include "array.h"
#include "list-int.h"
#include "layer-detail.h"
#include "grid-detail.h"

#include "corridor.h"

static int corridor_builder_expand(corridor_builder *cbp, int size_needed);
static int corridor_builder_connect_1(corridor_builder *cbp,
                                      int *frontier_u,
                                      int *frontier_v,
                                      int strategy);

corridor_builder *
corridor_builder_new(int size_u, int size_v)
{
  int i;
  int u;
  int v;
  corridor_builder *p = NULL;

  if (size_u <= 0)
  {
    fprintf(stderr, "corridor_builder_new: size_u is non-positive (%d)\n",
            size_u);
    return NULL;
  }
  if (size_v <= 0)
  {
    fprintf(stderr, "corridor_builder_new: size_u is non-positive (%d)\n",
            size_v);
    return NULL;
  }

  p = (corridor_builder *) malloc(sizeof(corridor_builder));
  if (p == NULL)
  {
    fprintf(stderr, "corridor_builder_new: malloc(p) failed\n");
    return NULL;
  }

  p->size_u = size_u;
  p->size_v = size_v;
  p->layer = NULL;
  p->mark = NULL;
  p->size_mark = 4;
  p->marked_wall_u = NULL;
  p->marked_wall_v = NULL;
  p->mark_seen = NULL;
  p->mark_dug = NULL;
  p->mark_cache_num = 0;
  p->mark_cache = NULL;
  p->n_mark_max = -1;

  p->layer = array2_new(p->size_u, p->size_v);
  if (p->layer == NULL)
  {
    fprintf(stderr, "corridor_builder_new: array2_new failed\n");
    corridor_builder_delete(p);
    p = NULL;
    return NULL;
  }
  for (u = 0; u < p->size_u; u++)
  {
    for (v = 0; v < p->size_v; v++)
    {
      p->layer[u][v] = LAYER_WALL;
    }
  }

  p->mark = (list_int ***) malloc(sizeof(list_int **) * p->size_u);
  if (p->mark == NULL)
  {
    fprintf(stderr, "corridor_builder_new: malloc(p->mark) failed\n");
    corridor_builder_delete(p);
    p = NULL;
    return NULL;
  }
  for (u = 0; u < p->size_u; u++)
    p->mark[u] = NULL;

  for (u = 0; u < p->size_u; u++)
  {
    p->mark[u] = (list_int **) malloc(sizeof(list_int *) * p->size_v);
    if (p->mark[u] == NULL)
    {
      fprintf(stderr, "corridor_builder_new: malloc(p->mark[%d]) failed\n",
              u);
      corridor_builder_delete(p);
      p = NULL;
      return NULL;
    }
    for (v = 0; v < p->size_v; v++)
      p->mark[u][v] = NULL;
  }

  p->marked_wall_u = (list_int **) malloc(sizeof(list_int *) * p->size_mark);
  if (p->marked_wall_u == NULL)
  {
    fprintf(stderr, "corridor_builder_new: malloc(p->marked_wall_u) failed\n");
    corridor_builder_delete(p);
    p = NULL;
    return NULL;
  }
  for (i = 0; i < p->size_mark; i++)
    p->marked_wall_u[i] = NULL;

  p->marked_wall_v = (list_int **) malloc(sizeof(list_int *) * p->size_mark);
  if (p->marked_wall_v == NULL)
  {
    fprintf(stderr, "corridor_builder_new: malloc(p->marked_wall_v) failed\n");
    corridor_builder_delete(p);
    p = NULL;
    return NULL;
  }
  for (i = 0; i < p->size_mark; i++)
    p->marked_wall_v[i] = NULL;

  p->mark_seen = (int *) malloc(sizeof(int) * p->size_mark);
  if (p->mark_seen == NULL)
  {
    fprintf(stderr, "corridor_builder_new: malloc(p->mark_seen) failed\n");
    corridor_builder_delete(p);
    p = NULL;
    return NULL;
  }
  for (i = 0; i < p->size_mark; i++)
    p->mark_seen[i] = -1;

  p->mark_dug = (int *) malloc(sizeof(int) * p->size_mark);
  if (p->mark_dug == NULL)
  {
    fprintf(stderr, "corridor_builder_new: malloc(p->mark_dug) failed\n");
    corridor_builder_delete(p);
    p = NULL;
    return NULL;
  }
  for (i = 0; i < p->size_mark; i++)
    p->mark_dug[i] = 0;

  p->mark_cache = (int *)  malloc(sizeof(int) * p->size_mark);
  if (p->mark_cache == NULL)
  {
    fprintf(stderr, "corridor_builder_new: malloc(p->mark_cache) failed\n");
    corridor_builder_delete(p);
    p = NULL;
    return NULL;
  }

  return p;
}

void
corridor_builder_delete(corridor_builder *p)
{
  int i;
  int u;
  int v;

  if (p == NULL)
    return;

  if (p->layer != NULL)
  {
    array2_delete(p->layer, p->size_u, p->size_v);
    p->layer = NULL;
  }

  if (p->mark != NULL)
  {
    for (u = 0; u < p->size_u; u++)
    {
      if (p->mark[u] == NULL)
        continue;
      for (v = 0; v < p->size_v; v++)
      {
        if (p->mark[u][v] == NULL)
          continue;
        list_int_delete_all(p->mark[u][v]);
        p->mark[u][v] = NULL;
      }
      free(p->mark[u]);
      p->mark[u] = NULL;
    }
    free(p->mark);
    p->mark = NULL;
  }

  if (p->marked_wall_u != NULL)
  {
    for (i = 0; i < p->size_mark; i++)
    {
      if (p->marked_wall_u[i] == NULL)
        continue;

      list_int_delete_all(p->marked_wall_u[i]);
      p->marked_wall_u[i] = NULL;
    }

    free(p->marked_wall_u);
    p->marked_wall_u = NULL;
  }

  if (p->marked_wall_v != NULL)
  {
    for (i = 0; i < p->size_mark; i++)
    {
      if (p->marked_wall_v[i] == NULL)
        continue;

      list_int_delete_all(p->marked_wall_v[i]);
      p->marked_wall_v[i] = NULL;
    }

    free(p->marked_wall_v);
    p->marked_wall_v = NULL;
  }

  if (p->mark_seen != NULL)
  {
    free(p->mark_seen);
    p->mark_seen = NULL;
  }

  if (p->mark_dug != NULL)
  {
    free(p->mark_dug);
    p->mark_dug = NULL;
  }

  if (p->mark_cache != NULL)
  {
    free(p->mark_cache);
    p->mark_cache = NULL;
  }

  free(p);
  p = NULL;
}

static int
corridor_builder_expand(corridor_builder *cbp, int size_needed)
{
  int i;
  int size_mark_temp;
  list_int **marked_wall_u_temp = NULL;
  list_int **marked_wall_v_temp = NULL;
  int *mark_seen_temp = NULL;
  int *mark_dug_temp = NULL;
  int *mark_cache_temp = NULL;

  if (cbp == NULL)
  {
    fprintf(stderr, "corridor_builder_expand: cbp is NULL\n");
    return 1;
  }
  if (size_needed <= 0)
  {
    fprintf(stderr, "corridor_builder_expand: size_needed is non-positive "
            "(%d)\n", size_needed);
    return 1;
  }

  while (size_needed > cbp->size_mark)
  {
    size_mark_temp = cbp->size_mark * 2;
    if (size_mark_temp <= cbp->size_mark)
    {
      fprintf(stderr, "corridor_builder_expand: size_mark overflowed\n");
      return 1;
    }

    marked_wall_u_temp
      = (list_int **) realloc(cbp->marked_wall_u,
                              sizeof(list_int *) * size_mark_temp);
    if (marked_wall_u_temp == NULL)
    {
      fprintf(stderr, "corridor_builder_expand: "
              "realloc(marked_wall_u) failed\n");
      return 1;
    }
    cbp->marked_wall_u = marked_wall_u_temp;
    for (i = cbp->size_mark; i < size_mark_temp; i++)
      cbp->marked_wall_u[i] = NULL;

    marked_wall_v_temp
      = (list_int **) realloc(cbp->marked_wall_v,
                              sizeof(list_int *) * size_mark_temp);
    if (marked_wall_v_temp == NULL)
    {
      fprintf(stderr, "corridor_builder_expand: "
              "realloc(marked_wall_v) failed\n");
      return 1;
    }
    cbp->marked_wall_v = marked_wall_v_temp;
    for (i = cbp->size_mark; i < size_mark_temp; i++)
      cbp->marked_wall_v[i] = NULL;

    mark_seen_temp = (int *) realloc(cbp->mark_seen,
                                     sizeof(int) * size_mark_temp);
    if (mark_seen_temp == NULL)
    {
      fprintf(stderr, "corridor_builder_expand: realloc(mark_seen) failed\n");
      return 1;
    }
    cbp->mark_seen = mark_seen_temp;
    for (i = cbp->size_mark; i < size_mark_temp; i++)
      cbp->mark_seen[i] = 0;

    mark_dug_temp = (int *) realloc(cbp->mark_dug,
                                    sizeof(int) * size_mark_temp);
    if (mark_dug_temp == NULL)
    {
      fprintf(stderr, "corridor_builder_expand: realloc(mark_dug) failed\n");
      return 1;
    }
    cbp->mark_dug = mark_dug_temp;
    for (i = cbp->size_mark; i < size_mark_temp; i++)
      cbp->mark_dug[i] = 0;

    mark_cache_temp = (int *) realloc(cbp->mark_cache,
                                      sizeof(int) * size_mark_temp);
    if (mark_cache_temp == NULL)
    {
      fprintf(stderr, "corridor_builder_expand: realloc(mark_cache) failed\n");
      return 1;
    }
    cbp->mark_cache = mark_cache_temp;

    cbp->size_mark = size_mark_temp;
  }

  return 0;
}

/* (u, v) must be LAYER_WALL */
int
corridor_builder_add_mark(corridor_builder *cbp,
                          int u, int v, int n_mark)
{
  if (cbp == NULL)
  {
    fprintf(stderr, "corridor_builder_add_mark: cbp is NULL\n");
    return 1;
  }
  if ((u < 0) || (u >= cbp->size_u)
      || (v < 0) || (v >= cbp->size_v))
  {
    fprintf(stderr, "corridor_builder_add_mark: (%d, %d) is out of layer\n",
            u, v);
    return 1;
  }
  if (n_mark < 0)
  {
    fprintf(stderr, "corridor_builder_add_mark: n_mark is negative (%d)\n",
            n_mark);
    return 1;
  }

  if (cbp->layer[u][v] != LAYER_WALL)
  {
    fprintf(stderr, "corridor_builder_add_mark: (%d, %d) is not a wall\n",
            u, v);
    return 1;
  }

  if (corridor_builder_expand(cbp, n_mark + 1) != 0)
  {
    fprintf(stderr, "corridor_builder_add_mark: "
            "corridor_builder_expand failed\n");
    return 1;
  }

  cbp->mark[u][v] = list_int_insert_before(cbp->mark[u][v], n_mark);
  if (cbp->mark[u][v] == NULL)
  {
    fprintf(stderr, "corridor_builder_add_mark: "
            "list_int_insert_before(mark) failed\n");
    return 1;
  }

  cbp->marked_wall_u[n_mark]
    = list_int_insert_before(cbp->marked_wall_u[n_mark], u);
  if (cbp->marked_wall_u[n_mark] == NULL)
  {
    fprintf(stderr, "corridor_builder_add_mark: "
            "list_int_insert_before(marked_wall_u) failed\n");
    return 1;
  }

  cbp->marked_wall_v[n_mark]
    = list_int_insert_before(cbp->marked_wall_v[n_mark], v);
  if (cbp->marked_wall_v[n_mark] == NULL)
  {
    fprintf(stderr, "corridor_builder_add_mark: "
            "list_int_insert_before(marked_wall_v) failed\n");
    return 1;
  }

  cbp->mark_seen[n_mark] = 0;

  if (cbp->n_mark_max < n_mark)
    cbp->n_mark_max = n_mark;

  return 0;
}

static int
corridor_builder_connect_1(corridor_builder *cbp,
                           int *frontier_u,
                           int *frontier_v,
                           int strategy)
{
  int i;
  int temp;
  int n;
  int found;
  int u;
  int v;
  int u0;
  int v0;
  int n_mark;
  int n_mark_temp;
  /* the number of unseen open floors, both in rooms and corridors */
  int num_floor;
  int num_frontier;
  /* start at 1 */
  int num_floodfill;
  list_int *lip = NULL;
  list_int *ulip = NULL;
  list_int *vlip = NULL;

  if (cbp == NULL)
  {
    fprintf(stderr, "corridor_builder_connect_1: cbp is NULL\n");
    return 1;
  }
  if (frontier_u == NULL)
  {
    fprintf(stderr, "corridor_builder_connect_1: frontier_u is NULL\n");
    return 1;
  }
  if (frontier_v == NULL)
  {
    fprintf(stderr, "corridor_builder_connect_1: frontier_v is NULL\n");
    return 1;
  }

  u0 = -1;
  v0 = -1;
  n = 0;
  found = 0;
  num_floor = 0;
  for (u = 0; u < cbp->size_u; u++)
  {
    for (v = 0; v < cbp->size_v; v++)
    {
      if (cbp->layer[u][v] != LAYER_FLOOR)
        continue;

      num_floor++;

      n++;
      found = 1;
      if (rand() % n == 0)
      {
        u0 = u;
        v0 = v;
      }
    }
  }
  if (!found)
  {
    fprintf(stderr, "corridor_builder_connect_1: no floor found\n");
    return 1;
  }

  frontier_u[0] = u0;
  frontier_v[0] = v0;
  num_frontier = 1;
  cbp->layer[u0][v0] = LAYER_FLOOR_SEEN;
  num_floor--;

  num_floodfill = 0;
  cbp->mark_cache_num = 0;
  while (1)
  {
    num_floodfill++;
    while (num_frontier > 0)
    {
      u0 = frontier_u[num_frontier - 1];
      v0 = frontier_v[num_frontier - 1];
      num_frontier--;
      for (i = 0; i < 4; i++)
      {
        switch (i)
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
        case LAYER_CORRIDOR:
          frontier_u[num_frontier] = u;
          frontier_v[num_frontier] = v;
          num_frontier++;
          if (cbp->layer[u][v] == LAYER_FLOOR)
            cbp->layer[u][v] = LAYER_FLOOR_SEEN;
          else
            cbp->layer[u][v] = LAYER_CORRIDOR_SEEN;
          num_floor--;
          break;
        case LAYER_WALL:
          /* search for marks only when we are in a room */
          if (cbp->layer[u0][v0] == LAYER_FLOOR_SEEN)
          {
            for (lip = cbp->mark[u][v]; lip != NULL; lip = lip->next)
            {
              if (cbp->mark_seen[lip->n] == 0)
              {
                cbp->mark_seen[lip->n] = num_floodfill;
                cbp->mark_cache[cbp->mark_cache_num] = lip->n;
                (cbp->mark_cache_num)++;
              }
              else if ((cbp->mark_seen[lip->n] > 0)
                       && (cbp->mark_seen[lip->n] < num_floodfill))
              {
                cbp->mark_seen[lip->n] = -1;
              }
            }
          }
          break;
        case LAYER_FLOOR_SEEN:
        case LAYER_CORRIDOR_SEEN:
          /* do nothing */;
          break;
        default:
          fprintf(stderr, "corridor_builder_connect_1: unknown layer grid "
                  "(%d, %d) = %d\n", u, v, cbp->layer[u][v]);
          return 1;
          break;
        }
      }
    }

    if (num_floor <= 0)
      break;

    n_mark = -1;
    n = 0;
    found = 0;
    for (i = cbp->mark_cache_num - 1; i >= 0; i--)
    {
      if (strategy == STRATEGY_BACKTRACK)
        temp = i;
      else
        temp = rand() % cbp->mark_cache_num;

      n_mark_temp = cbp->mark_cache[temp];

      if ((cbp->mark_seen[n_mark_temp] < 0)
          || (cbp->mark_dug[n_mark_temp]))
      {
        cbp->mark_cache[temp] = cbp->mark_cache[cbp->mark_cache_num - 1];
        (cbp->mark_cache_num)--;
        continue;
      }

      if (strategy == STRATEGY_BACKTRACK)
      {        
        if ((found)
            && (cbp->mark_seen[n_mark_temp] < cbp->mark_seen[n_mark]))
          break;
      }

      n++;
      found = 1;
      if (rand() % n == 0)
      {
        n_mark = n_mark_temp;
      }

      if (strategy != STRATEGY_BACKTRACK)
        break;
    }

    if (!found)
      break;

    ulip = cbp->marked_wall_u[n_mark];
    vlip = cbp->marked_wall_v[n_mark];
    while (1)
    {
      if ((ulip == NULL) || (vlip == NULL))
        break;

      u = ulip->n;
      v = vlip->n;

      if (cbp->layer[u][v] == LAYER_WALL)
      {
        cbp->layer[u][v] = LAYER_CORRIDOR;
        num_floor++;
      }

      ulip = ulip->next;
      vlip = vlip->next;
    }

    cbp->mark_dug[n_mark] = 1;

    ulip = cbp->marked_wall_u[n_mark];
    vlip = cbp->marked_wall_v[n_mark];
    if ((ulip == NULL) || (vlip == NULL))
    {
      /* should not happen */      
      break;
    }

    /* assumes that all grids in cbp->marked_wall_* are/were LAYER_WALL */
    u0 = ulip->n;
    v0 = vlip->n;

    frontier_u[0] = u0;
    frontier_v[0] = v0;
    num_frontier = 1;
    cbp->layer[u0][v0] = LAYER_CORRIDOR_SEEN;
    num_floor--;
  }

  return 0;
}

int
corridor_builder_connect(corridor_builder *cbp,
                         int strategy)
{
  int status;
  int *frontier_u = NULL;
  int *frontier_v = NULL;

  if (cbp == NULL)
  {
    fprintf(stderr, "corridor_builder_connect: cbp is NULL\n");
    return 1;
  }

  frontier_u = (int *) malloc(sizeof(int) * cbp->size_u * cbp->size_v);
  if (frontier_u == NULL)
  {
    fprintf(stderr, "corridor_builder_connect: malloc(frontier_u) failed\n");
    return 1;
  }

  frontier_v = (int *) malloc(sizeof(int) * cbp->size_u * cbp->size_v);
  if (frontier_v == NULL)
  {
    fprintf(stderr, "corridor_builder_connect: malloc(frontier_v) failed\n");
    free(frontier_u);
    frontier_u = NULL;
    return 1;
  }

  status = corridor_builder_connect_1(cbp, frontier_u, frontier_v,
                                      strategy);
  if (status != 0)
  {
    fprintf(stderr, "corridor_builder_connect: "
            "corridor_builder_connect_1 failed\n");
  }

  free(frontier_u);
  frontier_u = NULL;
  free(frontier_v);
  frontier_v = NULL;

  return status;
}
