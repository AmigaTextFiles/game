#include <stdio.h>
/* malloc, rand, abs */
#include <stdlib.h>

#include "array.h"
#include "layer-detail.h"
#include "grid-detail.h"
#include "corridor.h"
#include "util-corridor.h"

#include "cave.h"

struct _frontier
{
  int size;
  int *u;
  int *v;
  int num;
};
typedef struct _frontier frontier;

static frontier *frontier_new(int size);
static void frontier_delete(frontier *p);

static int add_line_mark(corridor_builder *cbp,
                         int au, int av, int bu, int bv,
                         int n_mark);
static int cave_init_maze(corridor_builder *cbp);
static int cave_init_dig(corridor_builder *cbp);

static int search_adjacent(corridor_builder *cbp,
                           int u0, int v0,
                           frontier *frp, frontier *frp_hard);

static frontier *
frontier_new(int size)
{
  frontier *p = NULL;

  if (size <= 0)
  {
    fprintf(stderr, "frontier_new: size is non-positive (%d)\n", size);
    return NULL;
  }

  p = (frontier *) malloc(sizeof(frontier));
  if (p == NULL)
  {
    fprintf(stderr, "frontier_new: malloc(p) failed\n");
    return NULL;
  }

  p->size = size;
  p->u = NULL;
  p->v = NULL;
  p->num = 0;

  p->u = (int *) malloc(sizeof(int) * p->size);
  if (p->u == NULL)
  {
    fprintf(stderr, "frontier_new: malloc(p->u) failed\n");
    frontier_delete(p);
    return NULL;
  }

  p->v = (int *) malloc(sizeof(int) * p->size);
  if (p->v == NULL)
  {
    fprintf(stderr, "frontier_new: malloc(p->v) failed\n");
    frontier_delete(p);
    return NULL;
  }

  return p;
}

static void
frontier_delete(frontier *p)
{
  if (p == NULL)
    return;

  if (p->u != NULL)
  {
    free(p->u);
    p->u = NULL;
  }

  if (p->v != NULL)
  {
    free(p->v);
    p->v = NULL;
  }

  free(p);
  p = NULL;
}

static int
add_line_mark(corridor_builder *cbp,
              int au, int av, int bu, int bv,
              int n_mark)
{
  int s;
  int t;
  /* r = 2 * target_s * (t - t_real_line)
   * note that r can be negative; r must be signed
   */
  int r;
  int u0;
  int v0;
  int u1;
  int v1;
  int du;
  int dv;
  int du_abs;
  int dv_abs;
  int dir;
  int temp;
  int target_s;
  int target_t;

  if (cbp == NULL)
  {
    fprintf(stderr, "add_line_mark: \n");
    return 1;
  }
  if (n_mark < 0)
  {    
    return 1;
  }
  if ((au == bu) && (av == bv))
  {
    return 1;
  }

  du = bu - au;
  dv = bv - av;
  du_abs = abs(du);
  dv_abs = abs(dv);

  if (du >= 0)
  {
    if (dv >= 0)
    {
      if (du_abs >= dv_abs)
        dir = 0;
      else
        dir = 1;
    }
    else
    {
      if (du_abs >= dv_abs)
        dir = 7;
      else
        dir = 6;
    }
  }
  else
  {
    if (dv >= 0)
    {
      if (du_abs >= dv_abs)
        dir = 3;
      else
        dir = 2;
    }
    else
    {
      if (du_abs >= dv_abs)
        dir = 4;
      else
        dir = 5;
    }
  }

  if (du_abs >= dv_abs)
  {
    target_s = du_abs;
    target_t = dv_abs;
  }
  else
  {
    target_s = dv_abs;
    target_t = du_abs;
  }

  /* the Bresenham algorithm */
  t = 0;
  r = 0;
  for (s = 0; s <= target_s; s++)
  {
    u0 = s;
    v0 = t;
    u1 = s;
    v1 = t + 1;

    if ((dir & 1) == 1)
    {
      temp = u0;
      u0 = v0;
      v0 = temp;

      temp = u1;
      u1 = v1;
      v1 = temp;
    }
    if ((dir & 2) == 2)
    {
      temp = u0;
      u0 = -v0;
      v0 = temp;

      temp = u1;
      u1 = -v1;
      v1 = temp;
    }
    if ((dir & 4) == 4)
    {
      u0 = -u0;
      v0 = -v0;

      u1 = -u1;
      v1 = -v1;
    }

    u0 += au;
    v0 += av;
    u1 += au;
    v1 += av;

    /* if t - t_real_line >= (1 / 2) */
    if (r >= target_s)
    {
      if ((s != 0) && (s != target_s))
      {
        if ((u1 >= 0) && (u1 < cbp->size_u)
            && (v1 >= 0) && (v1 < cbp->size_v))
        {
          corridor_builder_add_mark(cbp,
                                    u1, v1, n_mark);
        }

        if ((u0 >= 0) && (u0 < cbp->size_u)
            && (v0 >= 0) && (v0 < cbp->size_v))
        {
          corridor_builder_add_mark(cbp,
                                    u0, v0, n_mark);
        }
      }

      r -= 2 * target_s;
      t++;
    }
    else
    {
      if ((s != 0) && (s != target_s))
      {
        if ((u0 >= 0) && (u0 < cbp->size_u)
            && (v0 >= 0) && (v0 < cbp->size_v))
        {
          corridor_builder_add_mark(cbp,
                                    u0, v0, n_mark);
        }
      }
    }

    r += 2 * target_t;
  }

  if (t != target_t)
  {
    fprintf(stderr, "a:(%d, %d) b:(%d, %d) t = %d, target_t = %d, "
            "n_mark = %d\n",
            au, av, bu, bv, t, target_t, n_mark);
  }

  return 0;
}

static int
cave_init_maze(corridor_builder *cbp)
{
  int u;
  int v;
  int au;
  int av;
  int bu;
  int bv;
  int ru;
  int rv;
  int n_mark;
  int origin_u;
  int origin_v;
  int stride_u;
  int stride_v;
  int room_num_u;
  int room_num_v;
  /* list of rooms[ru][rv]:
   * [0] u
   * [1] v
   */
  int ***rooms = NULL;

  if (cbp == NULL)
  {
    fprintf(stderr, "cave_init_maze: cbp is NULL\n");
    return 1;
  }

  if ((cbp->size_u < 21) || (cbp->size_v < 21))
  {
    fprintf(stderr, "cave_init_maze: layer (%d x %d) is too small\n",
            cbp->size_u, cbp->size_v);
    return 1;
  }

  room_num_u = 1 + (cbp->size_u - 21) / 11;
  room_num_v = 1 + (cbp->size_v - 21) / 11;

  rooms = array3_new(room_num_u, room_num_v, 2);
  if (rooms == NULL)
  {
    fprintf(stderr, "cave_init_maze: array3_new failed\n");
    return 1;
  }

  if (room_num_u <= 1)
  {
    origin_u = 9 + (cbp->size_u - 21) / 2;
    stride_u = 0;
  }
  else
  {
    origin_u = 9;
    stride_u = (cbp->size_u - 21) / (room_num_u - 1);
  }
  if (room_num_v <= 1)
  {
    origin_v = 9 + (cbp->size_v - 21) / 2;
    stride_v = 0;
  }
  else
  {
    origin_v = 9;
    stride_v = (cbp->size_v - 21) / (room_num_v - 1);
  }

  for (u = 0; u < cbp->size_u; u++)
  {
    for (v = 0; v < cbp->size_v; v++)
    {
      cbp->layer[u][v] = LAYER_WALL;
    }
  }

  for (ru = 0; ru < room_num_u; ru++)
  {
    for (rv = 0; rv < room_num_v; rv++)
    {
      u = origin_u + stride_u * ru + (rand() % 3);
      v = origin_v + stride_v * rv + (rand() % 3);

      rooms[ru][rv][0] = u;
      rooms[ru][rv][1] = v;

      cbp->layer[u][v] = LAYER_FLOOR;
    }
  }

  n_mark = 0;

  for (ru = 0; ru < room_num_u - 1; ru++)
  {
    for (rv = 0; rv < room_num_v; rv++)
    {
      au = rooms[ru][rv][0];
      av = rooms[ru][rv][1];
      bu = rooms[ru + 1][rv][0];
      bv = rooms[ru + 1][rv][1];

      add_line_mark(cbp,
                    au, av, bu, bv,
                    n_mark);
      n_mark++;
    }
  }
  
  for (ru = 0; ru < room_num_u; ru++)
  {
    for (rv = 0; rv < room_num_v - 1; rv++)
    {
      au = rooms[ru][rv][0];
      av = rooms[ru][rv][1];
      bu = rooms[ru][rv + 1][0];
      bv = rooms[ru][rv + 1][1];

      add_line_mark(cbp,
                    au, av, bu, bv,
                    n_mark);
      n_mark++;
    }
  }


  array3_delete(rooms, room_num_u, room_num_v, 2);
  rooms = NULL;

  return 0;
}

static int
cave_init_dig(corridor_builder *cbp)
{
  int u;
  int v;
  int some_u;
  int some_v;

  if (cbp == NULL)
    return 1;

  some_u = rand() % 8;
  some_v = rand() % 8;

  for (u = 0; u < cbp->size_u; u++)
  {
    for (v = 0; v < cbp->size_v; v++)
    {
      switch (cbp->layer[u][v])
      {
      case LAYER_FLOOR:
      case LAYER_CORRIDOR:
      case LAYER_FLOOR_SEEN:
      case LAYER_CORRIDOR_SEEN:
        cbp->layer[u][v] = LAYER_FLOOR;
        break;
      default:
        if ((u < 5) || (u >= cbp->size_u - 5)
            || (v < 5) || (v >= cbp->size_v - 5))
          cbp->layer[u][v] = LAYER_HARD_WALL;
        else if (((u + some_u + v + some_v) % 8 < 6)
                 && ((u + some_u + cbp->size_u + 8 - (v + some_v)) % 8 < 6))
          cbp->layer[u][v] = LAYER_HARD_WALL;
        else
          cbp->layer[u][v] = LAYER_WALL;
        break;
      }
    }
  }

  return 0;
}

static int
search_adjacent(corridor_builder *cbp,
                int u0, int v0,
                frontier *frp, frontier *frp_hard)
{
  int i;
  int u;
  int v;

  if (cbp == NULL)
    return 1;
  if (frp == NULL)
    return 1;
  if (frp_hard == NULL)
    return 1;

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

    if ((u < 1) || (u >= cbp->size_u - 1)
        || (v < 1) || (v >= cbp->size_v - 1))
      continue;

    /* add only unseen walls */
    switch (cbp->layer[u][v])
    {
    case LAYER_WALL:
      frp->u[frp->num] = u;
      frp->v[frp->num] = v;
      (frp->num)++;
      cbp->layer[u][v] = LAYER_WALL_SEEN;
      break;
    case LAYER_HARD_WALL:
      frp_hard->u[frp_hard->num] = u;
      frp_hard->v[frp_hard->num] = v;
      (frp_hard->num)++;
      cbp->layer[u][v] = LAYER_HARD_WALL_SEEN;
      break;
    default:
      /* do nothing */;
      break;
    }
  }

  return 0;
}

int
build_cave(world *wp, int z,
           int floor_percent)
{
  int size_x;
  int size_y;
  int n;
  int u;
  int v;
  int u0;
  int v0;
  int x;
  int y;
  int num_floor;
  corridor_builder *cbp = NULL;
  frontier *frp = NULL;
  frontier *frp_hard = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "build_cave: wp is NULL\n");
    return 1;
  }
  if ((z < 0) || (z >= wp->size_z))
  {
    fprintf(stderr, "build_cave: strange z (%d)\n", z);
    return 1;
  }
  if (floor_percent < 0)
  {
    fprintf(stderr, "build_cave: floor_percent is negative (%d)\n",
            floor_percent);
    return 1;
  }

  size_x = wp->size_x;
  size_y = wp->size_y;
  if (size_x <= 0)
  {
    fprintf(stderr, "build_cave: size_x is non-positive (%d)\n", size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "build_cave: size_y is non-positive (%d)\n", size_y);
    return 1;
  }

  if ((size_x < 21) || (size_y < 21))
  {
    fprintf(stderr, "build_cave: map (%d x %d) is too small\n",
            size_x, size_y);
    return 1;
  }

  cbp = corridor_builder_new(size_x, size_y);
  if (cbp == NULL)
  {
    fprintf(stderr, "build_cave: corridor_builder_new failed\n");
    return 1;
  }

  frp = frontier_new(cbp->size_u * cbp->size_v);
  if (frp == NULL)
  {
    fprintf(stderr, "build_cave: frontier_new(frp) failed\n");
    corridor_builder_delete(cbp);
    cbp = NULL;
    return 1;
  }

  frp_hard = frontier_new(cbp->size_u * cbp->size_v);
  if (frp_hard == NULL)
  {
    fprintf(stderr, "build_cave: frontier_new(frp_hard) failed\n");
    corridor_builder_delete(cbp);
    cbp = NULL;
    frontier_delete(frp);
    frp = NULL;
    return 1;
  }
  
  cave_init_maze(cbp);
  corridor_builder_connect(cbp, STRATEGY_BACKTRACK);
  connect_some(cbp, 1);

  cave_init_dig(cbp);

  num_floor = 0;
  frp->num = 0;
  frp_hard->num = 0;
  for (u = 0; u < cbp->size_u; u++)
  {
    for (v = 0; v < cbp->size_v; v++)
    {
      if (cbp->layer[u][v] != LAYER_FLOOR)
        continue;

      num_floor++;
      search_adjacent(cbp,
                      u, v,
                      frp, frp_hard);
    }
  }

  while (((frp->num > 0) || (frp_hard->num > 0))
         && (num_floor * 100 < cbp->size_u * cbp->size_v * floor_percent))
  {
    if (rand() % (frp->num * 6 + frp_hard->num) >= frp_hard->num)
    {
      n = rand() % frp->num;
      u0 = frp->u[n];
      v0 = frp->v[n];

      frp->u[n] = frp->u[frp->num - 1];
      frp->v[n] = frp->v[frp->num - 1];
      (frp->num)--;
    }
    else
    {
      n = rand() % frp_hard->num;
      u0 = frp_hard->u[n];
      v0 = frp_hard->v[n];

      frp_hard->u[n] = frp_hard->u[frp_hard->num - 1];
      frp_hard->v[n] = frp_hard->v[frp_hard->num - 1];
      (frp_hard->num)--;
    }

    cbp->layer[u0][v0] = LAYER_FLOOR;
    num_floor++;

    search_adjacent(cbp,
                    u0, v0,
                    frp, frp_hard);
  }

  for (x = 0; x < size_x; x++)
  {
    for (y = 0; y < size_y; y++)
    {
      wp->grid[z][x][y] = GR_WALL;
    }
  }

  for (u = 0; u < cbp->size_u; u++)
  {
    for (v = 0; v < cbp->size_v; v++)
    {
      x = u + 0;
      y = v + 0;
      if ((x < 0) || (x >= size_x)
          || (y < 0) || (y >= size_y))
        continue;

      if (cbp->layer[u][v] == LAYER_FLOOR)
        wp->grid[z][x][y] = GR_FLOOR;
    }
  }

  corridor_builder_delete(cbp);
  cbp = NULL;
  frontier_delete(frp);
  frp = NULL;
  frontier_delete(frp_hard);
  frp_hard = NULL;

  return 0;
}
