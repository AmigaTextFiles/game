#include <stdio.h>
/* malloc, rand, abs */
#include <stdlib.h>

#include "array.h"
#include "grid-detail.h"

#include "r-and-c.h"

/* connected directions
 * these values must be 2^n
 */
/* from (0, 0) to (-1, 0) */
#define DIR_WEST 1
/* from (0, 0) to (1, 0) */
#define DIR_EAST 2
/* from (0, 0) to (0, -1) */
#define DIR_NORTH 4
/* from (0, 0) to (0, 1) */
#define DIR_SOUTH 8

struct _connections
{
  int size_u;
  int size_v;
  int **dir;
};
typedef struct _connections connections;

struct _frontiers
{
  int size_u;
  int size_v;
  int num;
  int *u;
  int *v;
};
typedef struct _frontiers frontiers;

struct _segment
{
  int x;
  int y;
  int size_x;
  int size_y;
};
typedef struct _segment segment;

struct _r_and_c_builder
{
  int size_u;
  int size_v;
  segment ***segp;
  connections *cp;
};
typedef struct _r_and_c_builder r_and_c_builder;

struct _maze_builder
{
  int origin_x;
  int origin_y;
  int stride;
  int size_u;
  int size_v;
  connections *cp;
};
typedef struct _maze_builder maze_builder;

static connections *connections_new(int size_u, int size_v);
static void connections_delete(connections *p);

static frontiers *frontiers_new(int size_u, int size_v);
static void frontiers_delete(frontiers *p);

static segment *segment_new(void);
static void segment_delete(segment *p);

static r_and_c_builder *r_and_c_builder_new(int size_u, int size_v);
static void r_and_c_builder_delete(r_and_c_builder *p);

static maze_builder *maze_builder_new(int size_u, int size_v);
static void maze_builder_delete(maze_builder *p);


static int add_frontier(frontiers *frp, int u, int v);
static int remove_frontier(frontiers *frp, int frontier_id);

static int connect_all_unconnected(int **grid, int size_x, int size_y,
                                   connections *cp,
                                   int connect_plan,
                                   void *data,
                                   int (*connect_func)(int **,
                                                       int,
                                                       int,
                                                       void *,
                                                       int,
                                                       int,
                                                       int,
                                                       int,
                                                       int,
                                                       int));
static int connect_to_unconnected(int **grid, int size_x, int size_y,
                                  connections *cp,
                                  frontiers *frp,
                                  int start_u, int start_v,
                                  void *data,
                                  int (*connect_func)(int **,
                                                      int,
                                                      int,
                                                      void *,
                                                      int,
                                                      int,
                                                      int,
                                                      int,
                                                      int,
                                                      int));
static int connect_to_wall(int **grid, int size_x, int size_y,
                           connections *cp,
                           int connection_needed,
                           int start_u, int start_v,
                           void *data,
                           int (*connect_func)(int **,
                                               int,
                                               int,
                                               void *,
                                               int,
                                               int,
                                               int,
                                               int,
                                               int,
                                               int));

static int add_corridor(int **grid, int size_x, int size_y,
                        int start_x, int start_y,
                        int end_x, int end_y);
static int connect_r_and_c(int **grid, int size_x, int size_y,
                           r_and_c_builder *rcbp,
                           int start_u, int start_v, int start_dir,
                           int end_u, int end_v, int end_dir);
static int connect_maze(int **grid, int size_x, int size_y,
                        maze_builder *mbp,
                        int start_u, int start_v, int start_dir,
                        int end_u, int end_v, int end_dir);
static int fill_with_wall(int **grid, int size_x, int size_y,
                          int allow_hard_wall);
static int **get_random_uv_list(int size_u, int size_v);
static int connect_more_room(int **grid, int size_x, int size_y,
                             r_and_c_builder *rcbp);
static int remove_maze_dead_end(int **grid, int size_x, int size_y,
                                maze_builder *mbp);

static connections *
connections_new(int size_u, int size_v)
{
  int u;
  int v;
  connections *p = NULL;

  if (size_u <= 0)
  {
    fprintf(stderr, "connections_new: size_u is non-positive (%d)\n",
            size_u);
    return NULL;
  }
  if (size_v <= 0)
  {
    fprintf(stderr, "connections_new: size_v is non-positive (%d)\n",
            size_v);
    return NULL;
  }

  p = (connections *) malloc(sizeof(connections));
  if (p == NULL)
  {
    fprintf(stderr, "connections_new: malloc failed\n");
    return NULL;
  }

  p->size_u = size_u;
  p->size_v = size_v;
  p->dir = NULL;

  p->dir = array2_new(p->size_u, p->size_v);
  if (p->dir == NULL)
  {
    fprintf(stderr, "connections_new: array2_new failed\n");
    connections_delete(p);
    p = NULL;
    return NULL;
  }

  for (u = 0; u < p->size_u; u++)
  {
    for (v = 0; v < p->size_v; v++)
    {
      p->dir[u][v] = 0;
    }
  }

  return p;
}

static void
connections_delete(connections *p)
{
  if (p == NULL)
    return;

  if (p->dir != NULL)
  {
    array2_delete(p->dir, p->size_u, p->size_v);
    p->dir = NULL;
  }

  free(p);
  p = NULL;
}

static frontiers *
frontiers_new(int size_u, int size_v)
{
  frontiers *p = NULL;

  if (size_u <= 0)
  {
    fprintf(stderr, "frontiers_new: size_u is non-positive (%d)\n",
            size_u);
    return NULL;
  }
  if (size_v <= 0)
  {
    fprintf(stderr, "frontiers_new: size_u is non-positive (%d)\n",
            size_v);
    return NULL;
  }

  p = (frontiers *) malloc(sizeof(frontiers));
  if (p == NULL)
  {
    fprintf(stderr, "frontiers_new: malloc(p) failed\n");
    return NULL;
  }

  p->size_u = size_u;
  p->size_v = size_v;
  p->num = 0;
  p->u = NULL;
  p->v = NULL;

  p->u = (int *) malloc(sizeof(int) * (p->size_u * p->size_v));
  if (p->u == NULL)
  {
    fprintf(stderr, "frontiers_new: malloc(p->u) failed\n");
    frontiers_delete(p);
    p = NULL;
    return NULL;
  }

  p->v = (int *) malloc(sizeof(int) * (p->size_u * p->size_v));
  if (p->v == NULL)
  {
    fprintf(stderr, "frontiers_new: malloc(p->v) failed\n");
    frontiers_delete(p);
    p = NULL;
    return NULL;
  }

  return p;
}

static void
frontiers_delete(frontiers *p)
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

static segment *
segment_new(void)
{
  segment *p = NULL;

  p = (segment *) malloc(sizeof(segment));
  if (p == NULL)
  {
    fprintf(stderr, "segment_new: malloc failed\n");
    return NULL;
  }

  p->x = -1;
  p->y = -1;
  p->size_x = 0;
  p->size_y = 0;

  return p;
}

static void
segment_delete(segment *p)
{
  if (p == NULL)
    return;

  free(p);
  p = NULL;
}

static r_and_c_builder *
r_and_c_builder_new(int size_u, int size_v)
{
  int u;
  int v;
  r_and_c_builder *p = NULL;

  if (size_u <= 0)
  {
    fprintf(stderr, "r_and_c_builder_new: size_u is non-positive (%d)\n",
            size_u);
    return NULL;
  }
  if (size_v <= 0)
  {
    fprintf(stderr, "r_and_c_builder_new: size_v is non-positive (%d)\n",
            size_v);
    return NULL;
  }

  p = (r_and_c_builder *) malloc(sizeof(r_and_c_builder));
  if (p == NULL)
  {
    fprintf(stderr, "r_and_c_builder_new: malloc(p) failed\n");
    return NULL;
  }

  p->size_u = size_u;
  p->size_v = size_v;
  p->segp = NULL;
  p->cp = NULL;

  p->segp = (segment ***) malloc(sizeof(segment **) * size_u);
  if (p->segp == NULL)
  {
    fprintf(stderr, "r_and_c_builder_new: "
            "malloc(p->segp) failed\n");
    r_and_c_builder_delete(p);
    p = NULL;
    return NULL;
  }
  for (u = 0; u < size_u; u++)
    p->segp[u] = NULL;

  for (u = 0; u < size_u; u++)
  {
    p->segp[u] = (segment **) malloc(sizeof(segment *) * size_v);
    if (p->segp[u] == NULL)
    {
      fprintf(stderr, "r_and_c_builder_new: "
              "malloc(p->segp[%d]) failed\n", u);
      r_and_c_builder_delete(p);
      p = NULL;
      return NULL;
    }
    for (v = 0; v < size_v; v++)
      p->segp[u][v] = NULL;

    for (v = 0; v < size_v; v++)
    {
      p->segp[u][v] = segment_new();
      if (p->segp[u][v] == NULL)
      {
        fprintf(stderr, "r_and_c_builder_new: "
                "malloc(p->segp[%d][%d]) failed\n",
                u, v);
        r_and_c_builder_delete(p);
        p = NULL;
        return NULL;
      }
    }
  }

  p->cp = connections_new(p->size_u, p->size_v);
  if (p->cp == NULL)
  {
    fprintf(stderr, "r_and_c_builder_new: connections_new failed\n");
    r_and_c_builder_delete(p);
    p = NULL;
    return NULL;
  }

  return p;
}

static void
r_and_c_builder_delete(r_and_c_builder *p)
{
  int u;
  int v;

  if (p == NULL)
    return;

  if (p->segp != NULL)
  {
    for (u = 0; u < p->size_u; u++)
    {
      if (p->segp[u] == NULL)
        continue;
      for (v = 0; v < p->size_v; v++)
      {
        if (p->segp[u][v] == NULL)
          continue;
        segment_delete(p->segp[u][v]);
        p->segp[u][v] = NULL;
      }
      free(p->segp[u]);
      p->segp[u] = NULL;
    }
    free(p->segp);
    p->segp = NULL;
  }

  if (p->cp != NULL)
  {
    connections_delete(p->cp);
    p->cp = NULL;
  }

  free(p);
  p = NULL;
}

static maze_builder *
maze_builder_new(int size_u, int size_v)
{
  maze_builder *p = NULL;

  p = (maze_builder *) malloc(sizeof(maze_builder));
  if (p == NULL)
  {
    fprintf(stderr, "maze_builder_new: malloc(p) failed\n");
    return NULL;
  }
  p->origin_x = -1;
  p->origin_y = -1;
  p->stride = 0;
  p->size_u = size_u;
  p->size_v = size_v;
  p->cp = NULL;

  p->cp = connections_new(p->size_u, p->size_v);
  if (p->cp == NULL)
  {
    fprintf(stderr, "maze_builder_new: connections_new failed\n");
    maze_builder_delete(p);
    p = NULL;
    return NULL;
  }

  return p;
}

static void
maze_builder_delete(maze_builder *p)
{
  if (p == NULL)
    return;

  if (p->cp != NULL)
  {
    connections_delete(p->cp);
    p->cp = NULL;
  }

  free(p);
  p = NULL;
}

static int
add_frontier(frontiers *frp, int u, int v)
{
  if (frp == NULL)
    return 1;
  if (frp->num < 0)
    return 1;
  if (frp->num >= frp->size_u * frp->size_v)
    return 1;

  frp->u[frp->num] = u;
  frp->v[frp->num] = v;
  (frp->num)++;

  return 0;
}

/* this does _not_ preserve the order of the frontiers */
static int
remove_frontier(frontiers *frp, int frontier_id)
{
  if (frp == NULL)
    return 1;
  if (frp->num <= 0)
    return 1;
  if ((frontier_id < 0) || (frontier_id >= frp->num))
    return 1;

  frp->u[frontier_id] = frp->u[frp->num - 1];
  frp->v[frontier_id] = frp->v[frp->num - 1];
  (frp->num)--;

  return 0;
}

/* return 0 on success, 1 on error */
static int
connect_all_unconnected(int **grid, int size_x, int size_y,
                        connections *cp,
                        int connect_plan,
                        void *data,
                        int (*connect_func)(int **,
                                            int,
                                            int,
                                            void *,
                                            int,
                                            int,
                                            int,
                                            int,
                                            int,
                                            int))
{
  int frontier_id;
  int start_u;
  int start_v;
  int ret;
  frontiers *frp = NULL;

  frp = frontiers_new(cp->size_u, cp->size_v);
  if (frp == NULL)
  {
    fprintf(stderr, "connect_all_unconnected: frontiers_new failed\n");
    return 1;
  }

  frp->u[0] = rand() % cp->size_u;
  frp->v[0] = rand() % cp->size_v;
  frp->num = 1;

  while (frp->num > 0)
  {
    switch (connect_plan)
    {
    case CONPLAN_BACKTRACK:
      frontier_id = frp->num - 1;
      break;
    case CONPLAN_RANDOM:
      frontier_id = rand() % frp->num;
      break;
    default:
      /* should not happen */
      frontier_id = frp->num - 1;
      break;
    }

    start_u = frp->u[frontier_id];
    start_v = frp->v[frontier_id];

    ret = connect_to_unconnected(grid, size_x, size_y,
                                 cp,
                                 frp,
                                 start_u, start_v,
                                 data,
                                 connect_func);
    if (ret == 2)
    {
      fprintf(stderr, "connect_all_unconnected: "
              "connect_to_unconnected failed\n");
      frontiers_delete(frp);
      frp = NULL;
      return 1;
    }

    if (ret == 1)
    {
      remove_frontier(frp, frontier_id);
      continue;
    }
  }

  frontiers_delete(frp);
  frp = NULL;

  return 0;
}

/* return
 * 0 if connected with a new direction
 * 1 if already connected enough
 * 2 on error
 */
static int
connect_to_unconnected(int **grid, int size_x, int size_y,
                       connections *cp,
                       frontiers *frp,
                       int start_u, int start_v,
                       void *data,
                       int (*connect_func)(int **,
                                           int,
                                           int,
                                           void *,
                                           int,
                                           int,
                                           int,
                                           int,
                                           int,
                                           int))
{
  int n;
  int start_dir;
  int end_u;
  int end_v;
  int end_dir;

  if (grid == NULL)
    return 2;
  if (size_x <= 0)
    return 2;
  if (size_y <= 0)
    return 2;
  if (cp == NULL)
    return 2;

  n = 0;
  end_u = start_u;
  end_v = start_v;
  start_dir = 0;
  end_dir = 0;

  if ((start_u - 1 >= 0)
      && (cp->dir[start_u - 1][start_v] == 0))
  {
    n++;
    if (rand() % n == 0)
    {
      end_u = start_u - 1;
      end_v = start_v;
      start_dir = DIR_WEST;
      end_dir = DIR_EAST;
    }
  }
  if ((start_u + 1 < cp->size_u)
      && (cp->dir[start_u + 1][start_v] == 0))
  {
    n++;
    if (rand() % n == 0)
    {
      end_u = start_u + 1;
      end_v = start_v;
      start_dir = DIR_EAST;
      end_dir = DIR_WEST;
    }
  }
  if ((start_v - 1 >= 0)
      && (cp->dir[start_u][start_v - 1] == 0))
  {
    n++;
    if (rand() % n == 0)
    {
      end_u = start_u;
      end_v = start_v - 1;
      start_dir = DIR_NORTH;
      end_dir = DIR_SOUTH;
    }
  }
  if ((start_v + 1 < cp->size_v)
      && (cp->dir[start_u][start_v + 1] == 0))
  {
    n++;
    if (rand() % n == 0)
    {
      end_u = start_u;
      end_v = start_v + 1;
      start_dir = DIR_SOUTH;
      end_dir = DIR_NORTH;
    }
  }

  if (n <= 0)
    return 1;

  if (connect_func != NULL)
  {
    if ((*connect_func)(grid, size_x, size_y,
                        data,
                        start_u, start_v, start_dir,
                        end_u, end_v, end_dir) != 0)
    {
      fprintf(stderr, "connect_to_unconnected: connect_func failed\n");
      return 2;
    }
  }

  cp->dir[start_u][start_v] |= start_dir;
  cp->dir[end_u][end_v] |= end_dir;

  add_frontier(frp, end_u, end_v);

  return 0;
}

/* return
 * 0 if connected with a new direction
 * 1 if already connected enough
 * 2 on error
 */
static int
connect_to_wall(int **grid, int size_x, int size_y,
                connections *cp,
                int connection_needed,
                int start_u, int start_v,
                void *data,
                int (*connect_func)(int **,
                                    int,
                                    int,
                                    void *,
                                    int,
                                    int,
                                    int,
                                    int,
                                    int,
                                    int))
{
  int num_adjacent;
  int num_wall;
  int end_u;
  int end_v;
  int start_dir;
  int end_dir;

  if (grid == NULL)
    return 2;
  if (size_x <= 0)
    return 2;
  if (size_y <= 0)
    return 2;
  if (cp == NULL)
    return 2;

  if (connection_needed <= 0)
    return 1;

  num_adjacent = 0;
  num_wall = 0;
  end_u = start_u;
  end_v = start_v;
  start_dir = 0;
  end_dir = 0;

  if (start_u - 1 >= 0)
  {
    num_adjacent++;
    if ((cp->dir[start_u][start_v] & DIR_WEST) == 0)
    {
      num_wall++;
      if (rand() % num_wall == 0)
      {
        end_u = start_u - 1;
        end_v = start_v;
        start_dir = DIR_WEST;
        end_dir = DIR_EAST;
      }
    }
  }
  if (start_u + 1 < cp->size_u)
  {
    num_adjacent++;
    if ((cp->dir[start_u][start_v] & DIR_EAST) == 0)
    {
      num_wall++;
      if (rand() % num_wall == 0)
      {
        end_u = start_u + 1;
        end_v = start_v;
        start_dir = DIR_EAST;
        end_dir = DIR_WEST;
      }
    }
  }
  if (start_v - 1 >= 0)
  {
    num_adjacent++;
    if ((cp->dir[start_u][start_v] & DIR_NORTH)== 0)
    {
      num_wall++;
      if (rand() % num_wall == 0)
      {
        end_u = start_u;
        end_v = start_v - 1;
        start_dir = DIR_NORTH;
        end_dir = DIR_SOUTH;
      }
    }
  }
  if (start_v + 1 < cp->size_v)
  {
    num_adjacent++;
    if ((cp->dir[start_u][start_v] & DIR_SOUTH)== 0)
    {
      num_wall++;
      if (rand() % num_wall == 0)
      {
        end_u = start_u;
        end_v = start_v + 1;
        start_dir = DIR_SOUTH;
        end_dir = DIR_NORTH;
      }
    }
  }

  if (num_adjacent - num_wall >= connection_needed)
    return 1;
  if (num_wall <= 0)
    return 1;

  if (connect_func != NULL)
  {
    if ((*connect_func)(grid, size_x, size_y,
                        data,
                        start_u, start_v, start_dir,
                        end_u, end_v, end_dir) != 0)
    {
      fprintf(stderr, "connect_to_wall: connect_func failed\n");
      return 2;
    }
  }

  cp->dir[start_u][start_v] |= start_dir;
  cp->dir[end_u][end_v] |= end_dir;

  return 0;
}

static int
add_corridor(int **grid, int size_x, int size_y,
             int start_x, int start_y,
             int end_x, int end_y)
{
  int x;
  int y;
  int dx;
  int dy;

  if (grid == NULL)
  {
    fprintf(stderr, "add_corridor: grid is NULL\n");
    return 1;
  }
  if (size_x <= 0)
  {
    fprintf(stderr, "add_corridor: size_x is non-positive (%d)\n",
            size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "add_corridor: size_y is non-positive (%d)\n",
            size_y);
    return 1;
  }
  if ((start_x < 0) || (start_x >= size_x))
  {
    fprintf(stderr, "add_corridor: start_x is out of range (%d)\n",
            start_x);
    return 1;
  }
  if ((start_y < 0) || (start_y >= size_y))
  {
    fprintf(stderr, "add_corridor: start_y is out of range (%d)\n",
            start_y);
    return 1;
  }
  if ((end_x < 0) || (end_x >= size_x))
  {
    fprintf(stderr, "add_corridor: end_x is out of range (%d)\n",
            end_x);
    return 1;
  }
  if ((end_y < 0) || (end_y >= size_y))
  {
    fprintf(stderr, "add_corridor: end_y is out of range (%d)\n",
            end_y);
    return 1;
  }

  if ((start_x == end_x) && (start_y == end_y))
    return 0;

  grid[start_x][start_y] = GR_FLOOR;
  x = start_x;
  y = start_y;
  if (start_x <= end_x)
    dx = 1;
  else
    dx = -1;
  if (start_y <= end_y)
    dy = 1;
  else
    dy = -1;

  while ((x != end_x) || (y != end_y))
  {
    if (x == end_x)
      y += dy;
    else if (y == end_y)
      x += dx;
    else if ((x % 2 == 0) && (y % 2 != 0))
      x += dx;
    else if ((y % 2 == 0) && (x % 2 != 0))
      y += dy;
    else if (rand() % abs (x - end_x) >= rand() % abs(y - end_y))
      x += dx;
    else
      y += dy;

    grid[x][y] = GR_FLOOR;
  }

  return 0;
}

static int
connect_r_and_c(int **grid, int size_x, int size_y,
                r_and_c_builder *rcbp,
                int start_u, int start_v, int start_dir,
                int end_u, int end_v, int end_dir)
{
  int min;
  int max;
  int start_x;
  int start_y;
  int end_x;
  int end_y;

  if (grid == NULL)
  {
    fprintf(stderr, "connect_r_and_c: grid is NULL\n");
    return 1;
  }
  if (rcbp == NULL)
  {
    fprintf(stderr, "connect_r_and_c: rcbp is NULL\n");
    return 1;
  }
  if (size_x <= 0)
  {
    fprintf(stderr, "connect_r_and_c: size_x is non-positive "
            "(%d)\n", size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "connect_r_and_c: size_y is non-positive "
            "(%d)\n", size_y);
    return 1;
  }
  if ((start_u < 0) || (start_u >= rcbp->size_u))
  {
    fprintf(stderr, "connect_r_and_c: start_u is out of range (%d)\n",
            start_u);
    return 1;
  }
  if ((start_v < 0) || (start_v >= rcbp->size_v))
  {
    fprintf(stderr, "connect_r_and_c: start_v is out of range (%d)\n",
            start_v);
    return 1;
  }
  if ((end_u < 0) || (end_u >= rcbp->size_u))
  {
    fprintf(stderr, "connect_r_and_c: end_u is out of range (%d)\n",
            end_u);
    return 1;
  }
  if ((end_v < 0) || (end_v >= rcbp->size_v))
  {
    fprintf(stderr, "connect_r_and_c: end_v is out of range (%d)\n",
            end_v);
    return 1;
  }

  if ((start_u == end_u) && (start_v == end_v))
    return 0;

  /* choose start_x */
  min = rcbp->segp[start_u][start_v]->x;
  if (min < 0)
  {
    fprintf(stderr, "connect_r_and_c: "
            "strange rcbp->segp[%d][%d]->x (%d)\n",
            start_u, start_v, rcbp->segp[start_u][start_v]->x);
    return 1;
  }
  if (min % 2 == 0)
    min++;
  max = rcbp->segp[start_u][start_v]->x
    + rcbp->segp[start_u][start_v]->size_x - 1;
  if (max % 2 == 0)
    max--;
  if (min > max)
  {
    fprintf(stderr, "connect_r_and_c: "
            "rcbp->segp[%d][%d]->size_x is too small "
            "(%d)\n",
            start_u, start_v, rcbp->segp[start_u][start_v]->size_x);
    return 1;
  }

  if (max - min <= 1)
    start_x = min;
  else
    start_x = min + (rand() % (((max - min) / 2) + 1)) * 2;

  /* choose start_y */
  min = rcbp->segp[start_u][start_v]->y;
  if (min < 0)
  {
    fprintf(stderr, "connect_r_and_c: "
            "strange rcbp->segp[%d][%d]->y (%d)\n",
            start_u, start_v, rcbp->segp[start_u][start_v]->y);
    return 1;
  }
  if (min % 2 == 0)
    min++;
  max = rcbp->segp[start_u][start_v]->y
    + rcbp->segp[start_u][start_v]->size_y - 1;
  if (max % 2 == 0)
    max--;
  if (min > max)
  {
    fprintf(stderr, "connect_r_and_c: "
            "rcbp->segp[%d][%d]->size_y is too small "
            "(%d)\n",
            start_u, start_v, rcbp->segp[start_u][start_v]->size_y);
    return 1;
  }

  if (max - min <= 1)
    start_y = min;
  else
    start_y = min + (rand() % (((max - min) / 2) + 1)) * 2;

  /* choose end_x */
  min = rcbp->segp[end_u][end_v]->x;
  if (min < 0)
  {
    fprintf(stderr, "connect_r_and_c: "
            "strange rcbp->segp[%d][%d]->x (%d)\n",
            end_u, end_v, rcbp->segp[end_u][end_v]->x);
    return 1;
  }
  if (min % 2 == 0)
    min++;
  max = rcbp->segp[end_u][end_v]->x
    + rcbp->segp[end_u][end_v]->size_x - 1;
  if (max % 2 == 0)
    max--;
  if (min > max)
  {
    fprintf(stderr, "connect_r_and_c: "
            "rcbp->segp[%d][%d]->size_x is too small "
            "(%d)\n",
            end_u, end_v, rcbp->segp[end_u][end_v]->size_x);
    return 1;
  }

  if (max - min <= 1)
    end_x = min;
  else
    end_x = min + (rand() % (((max - min) / 2) + 1)) * 2;

  /* choose end_y */
  min = rcbp->segp[end_u][end_v]->y;
  if (min < 0)
  {
    fprintf(stderr, "connect_r_and_c: "
            "strange rcbp->segp[%d][%d]->y (%d)\n",
            end_u, end_v, rcbp->segp[end_u][end_v]->y);
    return 1;
  }
  if (min % 2 == 0)
    min++;
  max = rcbp->segp[end_u][end_v]->y
    + rcbp->segp[end_u][end_v]->size_y - 1;
  if (max % 2 == 0)
    max--;
  if (min > max)
  {
    fprintf(stderr, "connect_r_and_c: "
            "rcbp->segp[%d][%d]->size_y is too small "
            "(%d)\n",
            end_u, end_v, rcbp->segp[end_u][end_v]->size_y);
    return 1;
  }

  if (max - min <= 1)
    end_y = min;
  else
    end_y = min + (rand() % (((max - min) / 2) + 1)) * 2;

  if (add_corridor(grid, size_x, size_y,
                   start_x, start_y,
                   end_x, end_y) != 0)
  {
    fprintf(stderr, "connect_r_and_c: add_corridor failed "
            "(%d, %d), (%d, %d)\n",
            start_x, start_y, end_x, end_y);
    return 1;
  }

  return 0;
}

static int
connect_maze(int **grid, int size_x, int size_y,
             maze_builder *mbp,
             int start_u, int start_v, int start_dir,
             int end_u, int end_v, int end_dir)
{
  int i;
  int x;
  int y;
  int x0;
  int y0;
  int dx;
  int dy;

  if (grid == NULL)
    return 1;
  if (size_x <= 0)
    return 1;
  if (size_y <= 0)
    return 1;
  if (mbp == NULL)
    return 1;

  if ((start_u == end_u) && (start_v == end_v))
    return 0;

  x0 = start_u * (mbp->stride + 1);
  y0 = start_v * (mbp->stride + 1);
  dx = 0;
  dy = 0;

  switch (start_dir)
  {
  case DIR_WEST:
    if (start_u - 1 < 0)
      return 1;
    x0 = start_u * (mbp->stride + 1);
    y0 = start_v * (mbp->stride + 1) + 1;
    dx = 0;
    dy = 1;
    break;
  case DIR_EAST:
    if (start_u + 1 >= mbp->size_u)
      return 1;
    x0 = (start_u + 1) * (mbp->stride + 1);
    y0 = start_v * (mbp->stride + 1) + 1;
    dx = 0;
    dy = 1;
    break;
  case DIR_NORTH:
    if (start_v - 1 < 0)
      return 1;
    x0 = start_u * (mbp->stride + 1) + 1;
    y0 = start_v * (mbp->stride + 1);
    dx = 1;
    dy = 0;
    break;
  case DIR_SOUTH:
    if (start_v + 1 >= mbp->size_v)
      return 1;
    x0 = start_u * (mbp->stride + 1) + 1;
    y0 = (start_v + 1) * (mbp->stride + 1);
    dx = 1;
    dy = 0;
    break;
  default:
    return 1;
    break;
  }
  x0 += mbp->origin_x;
  y0 += mbp->origin_y;

  x = x0;
  y = y0;
  for (i = 0; i < mbp->stride; i++)
  {
    grid[x][y] = GR_FLOOR;
    x += dx;
    y += dy;
  }

  return 0;
}

/* return 0 on success, 1 on error */
static int
fill_with_wall(int **grid, int size_x, int size_y,
               int allow_hard_wall)
{
  int x;
  int y;

  if (grid == NULL)
  {
    fprintf(stderr, "fill_with_wall: grid is NULL\n");
    return 1;
  }
  if (size_x <= 0)
  {
    fprintf(stderr, "fill_with_wall: size_x is non-positive (%d)\n",
            size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "fill_with_wall: size_y is non-positive (%d)\n",
            size_y);
    return 1;
  }

  for (x = 0; x < size_x; x++)
  {
    for (y = 0; y < size_y; y++)
    {
      if ((x <= 0) || (x >= size_x - 1)
          || (y <= 0) || (y >= size_y - 1))
        grid[x][y] = GR_WALL;
      else if ((x % 2 == 0) && (y % 2 == 0))
        grid[x][y] = GR_WALL;
      else
        grid[x][y] = GR_WALL;
    }
  }

  return 0;
}

/* return 0 on success, 1 on error */
int
build_room_and_corridor(int **grid, int size_x, int size_y,
                        int segment_plan)
{
  int x;
  int y;
  int u;
  int v;
  int size_u;
  int size_v;
  r_and_c_builder *rcbp = NULL;
  segment *seg = NULL;

  if (grid == NULL)
  {
    fprintf(stderr, "build_room_and_corridor: grid is NULL\n");
    return 1;
  }
  if (size_x <= 0)
  {
    fprintf(stderr, "build_room_and_corridor: size_x is non-positive (%d)\n",
            size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "build_room_and_corridor: size_y is non-positive (%d)\n",
            size_y);
    return 1;
  }

  size_u = -1;
  size_v = -1;
  switch (segment_plan)
  {
  case SEGPLAN_SPARSE:
    size_u = (size_x  - 1) / 14;
    size_v = (size_y  - 1) / 14;
    break;
  case SEGPLAN_DENSE:
    size_u = (size_x  - 1) / 8;
    size_v = (size_y  - 1) / 8;
    break;
  default:
    fprintf(stderr, "build_room_and_corridor: unknown segment_plan "
            "when setting size_u/v (%d)\n",
            segment_plan);
    return 1;
    break;
  }

  if (size_u <= 0)
  {
    fprintf(stderr, "build_room_and_corridor: size_x is too small (%d)\n",
            size_x);
    return 1;
  }
  if (size_v <= 0)
  {
    fprintf(stderr, "build_room_and_corridor: size_y is too small (%d)\n",
            size_y);
    return 1;
  }

  rcbp = r_and_c_builder_new(size_u, size_v);
  if (rcbp == NULL)
  {
    fprintf(stderr, "build_room_and_corridor: r_and_c_builder_new failed\n");
    return 1;
  }

  if (fill_with_wall(grid, size_x, size_y, 1) != 0)
  {
    fprintf(stderr, "build_room_and_corridor: "
            "fill_with_wall failed\n");
    return 1;
  }

  for (u = 0; u < rcbp->size_u; u++)
  {
    for (v = 0; v < rcbp->size_v; v++)
    {
      seg = rcbp->segp[u][v];

      switch (segment_plan)
      {
      case SEGPLAN_SPARSE:
        seg->x = u * 14;
        seg->y = v * 14;
        seg->size_x = 9;
        seg->size_y = 9;

        seg->x += (rand() % 4) * 2;
        seg->y += (rand() % 4) * 2;

        switch (rand() % 4)
        {
        case 0:
          seg->x += 2;
          seg->size_x -= 2;
          break;
        case 1:
          seg->size_x -= 2;
          break;
        default:
          break;
        }

        switch (rand() % 4)
        {
        case 0:
          seg->y += 2;
          seg->size_y -= 2;
          break;
        case 1:
          seg->size_y -= 2;
          break;
        default:
          break;
        }

        break;
      case SEGPLAN_DENSE:
        seg->x = u * 8;
        seg->y = v * 8;
        seg->size_x = 9;
        seg->size_y = 9;

        if (rand() % 2 == 0)
        { 
          seg->x += 2;
          seg->size_x -= 2;
        }
        if (rand() % 2 == 0)
        { 
          seg->y += 2;
          seg->size_y -= 2;
        }
        if (rand() % 2 == 0)
          seg->size_x -= 2;
        if (rand() % 2 == 0)
          seg->size_y -= 2;
        break;
      default:
        fprintf(stderr, "build_room_and_corridor: unknown segment_plan "
                "when setting seg (%d)\n",
                segment_plan);
        seg = NULL;

        r_and_c_builder_delete(rcbp);
        rcbp = NULL;
        return 1;
        break;
      }
      
      for (x = seg->x + 1;
           x < seg->x + seg->size_x - 1;
           x++)
      {
        for (y = seg->y + 1;
             y < seg->y + seg->size_y - 1;
             y++)
        {
          grid[x][y] = GR_FLOOR;
        }
      }
    }
  }

  seg = NULL;

  if (connect_all_unconnected(grid, size_x, size_y,
                              rcbp->cp,
                              CONPLAN_BACKTRACK,
                              rcbp,
                              (int (*)(int **,
                                       int,
                                       int,
                                       void *,
                                       int,
                                       int,
                                       int,
                                       int,
                                       int,
                                       int)) (&connect_r_and_c)) != 0)
  {
    fprintf(stderr, "build_room_and_corridor: "
            "connect_all_unconnected failed\n");
    r_and_c_builder_delete(rcbp);
    rcbp = NULL;
    return 1;
  }

  if (connect_more_room(grid, size_x, size_y,
                        rcbp) != 0)
  {
    fprintf(stderr, "build_room_and_corridor: "
            "connect_more_room failed\n");
    r_and_c_builder_delete(rcbp);
    rcbp = NULL;
    return 1;
  }

  r_and_c_builder_delete(rcbp);
  rcbp = NULL;

  return 0;
}

static int **
get_random_uv_list(int size_u, int size_v)
{
  int i;
  int n;
  int temp;
  int **uvp = NULL;

  if (size_u <= 0)
    return NULL;
  if (size_v <= 0)
    return NULL;

  uvp = array2_new(size_u * size_v, 2);
  if (uvp == NULL)
  {
    fprintf(stderr, "get_random_uv_list: array2_new failed\n");
    return NULL;
  }

  for (i = 0; i < size_u * size_v; i++)
  {
    uvp[i][0] = i % size_u;
    uvp[i][1] = i / size_u;
  }
  for (i = 0; i < size_u * size_v - 1; i++)
  {
    n = i + rand() % (size_u * size_v - i);
    if (n == i)
      continue;

    temp = uvp[n][0];
    uvp[n][0] = uvp[i][0];
    uvp[i][0] = temp;

    temp = uvp[n][1];
    uvp[n][1] = uvp[i][1];
    uvp[i][1] = temp;
  }

  return uvp;
}

static int
connect_more_room(int **grid, int size_x, int size_y,
                  r_and_c_builder *rcbp)
{
  int i;
  int num_try;
  int ret;
  int **uvp = NULL;

  if (grid == NULL)
    return 1;
  if (rcbp == NULL)
    return 1;
  if (size_x <= 0)
    return 1;
  if (size_y <= 0)
    return 1;

  uvp = get_random_uv_list(rcbp->size_u, rcbp->size_v);
  if (uvp == NULL)
  {
    fprintf(stderr, "connect_more_room: get_random_uv_list failed\n");
    return 1;
  }

  num_try = rcbp->size_u;
  if (rcbp->size_v < num_try)
    num_try = rcbp->size_v;

  for (i = 0; i < num_try; i++)
  {
    ret = connect_to_wall(grid, size_x, size_y,
                          rcbp->cp,
                          4,
                          uvp[i][0], uvp[i][1],
                          rcbp,
                          (int (*)(int **,
                                   int,
                                   int,
                                   void *,
                                   int,
                                   int,
                                   int,
                                   int,
                                   int,
                                   int)) (&connect_r_and_c));
    if (ret == 2)
    {
      fprintf(stderr, "connect_more_room: connect_to_wall failed\n");
      array2_delete(uvp, rcbp->size_u, rcbp->size_v);
      uvp = NULL;
      return 1;
    }
  }

  array2_delete(uvp, rcbp->size_u, rcbp->size_v);
  uvp = NULL;

  return 0;
}

/* there may be an obvious "dead end" after this function is applied
 *
 * before  after
 * #####   #####
 * #...#   #...#
 * #.#.#   #.#.#
 * #.#.#   #...#
 * #.###   #.###
 *
 */
static int
remove_maze_dead_end(int **grid, int size_x, int size_y,
                     maze_builder *mbp)
{
  int i;
  int ret;
  int **uvp = NULL;

  if (grid == NULL)
    return 1;
  if (size_x <= 0)
    return 1;
  if (size_y <= 0)
    return 1;
  if (mbp == NULL)
    return 1;

  uvp = get_random_uv_list(mbp->size_u, mbp->size_v);
  if (uvp == NULL)
  {
    fprintf(stderr, "remove_maze_dead_end: get_random_uv_list failed\n");
    return 1;
  }

  for (i = 0; i < mbp->size_u * mbp->size_v; i++)
  {
    ret = connect_to_wall(grid, size_x, size_y,
                          mbp->cp,
                          2,
                          uvp[i][0], uvp[i][1],
                          mbp,
                          (int (*)(int **,
                                   int,
                                   int,
                                   void *,
                                   int,
                                   int,
                                   int,
                                   int,
                                   int,
                                   int)) (&connect_maze));

    if (ret == 2)
    {
      fprintf(stderr, "remove_maze_dead_end: connect_to_wall failed\n");
      array2_delete(uvp, mbp->size_u, mbp->size_v);
      uvp = NULL;
      return 1;
    }
  }

  array2_delete(uvp, mbp->size_u, mbp->size_v);
  uvp = NULL;

  return 0;
}

int
build_maze(int **grid, int size_x, int size_y,
           int stride, int connect_plan, int allow_dead_end)
{
  int x;
  int y;
  int size_u;
  int size_v;
  int effective_max_x;
  int effective_max_y;
  maze_builder *mbp = NULL;

  if (grid == NULL)
  {
    fprintf(stderr, "build_maze: grid is NULL\n");
    return 1;
  }
  if (size_x <= 0)
  {
    fprintf(stderr, "build_maze: size_x is non-positive (%d)\n",
            size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "build_maze: size_y is non-positive (%d)\n",
            size_y);
    return 1;
  }
  if (stride <= 0)
  {
    fprintf(stderr, "build_maze: stride is non-positive (%d)\n",
            stride);
    return 1;
  }

  size_u = (size_x - 1) / (stride + 1);
  size_v = (size_y - 1) / (stride + 1);
  if (size_u <= 0)
  {
    fprintf(stderr, "build_maze: size_x is too small (%d)\n",
            size_x);
    return 1;
  }
  if (size_v <= 0)
  {
    fprintf(stderr, "build_maze: size_y is too small (%d)\n",
            size_y);
    return 1;
  }

  mbp = maze_builder_new(size_u, size_v);
  if (mbp == NULL)
  {
    fprintf(stderr, "build_maze: maze_builder_new failed\n");
    return 1;
  }
  mbp->origin_x = 0;
  mbp->origin_y = 0;
  mbp->stride = stride;

  effective_max_x = ((size_x - 1) / (mbp->stride + 1)) * (mbp->stride + 1);
  effective_max_y = ((size_y - 1) / (mbp->stride + 1)) * (mbp->stride + 1);
  for (x = 0; x < size_x; x++)
  {
    for (y = 0; y < size_y; y++)
    {
      if ((x == 0) || (x >= effective_max_x)
          || (y == 0) || (y >= effective_max_y))
        grid[x][y] = GR_WALL;
      else if ((x % (mbp->stride + 1) == 0) && (y % (mbp->stride + 1) == 0))
        grid[x][y] = GR_WALL;
      else if ((x % (mbp->stride + 1) == 0) || (y % (mbp->stride + 1) == 0))
        grid[x][y] = GR_WALL;
      else
        grid[x][y] = GR_FLOOR;
    }
  }

  if (connect_all_unconnected(grid, size_x, size_y,
                              mbp->cp,
                              connect_plan,
                              mbp,
                              (int (*)(int **,
                                       int,
                                       int,
                                       void *,
                                       int,
                                       int,
                                       int,
                                       int,
                                       int,
                                       int)) (&connect_maze)) != 0)
  {
    fprintf(stderr, "build_maze: connect_all_unconnected failed\n");
    maze_builder_delete(mbp);
    mbp = NULL;
    return 1;
  }

  if (!allow_dead_end)
  {
    if (remove_maze_dead_end(grid, size_x, size_y,
                             mbp) != 0)
    {
      fprintf(stderr, "build_maze: connect_maze_dead_end failed\n");
      maze_builder_delete(mbp);
      mbp = NULL;
      return 1;
    }
  }

  maze_builder_delete(mbp);
  mbp = NULL;

  return 0;
}
