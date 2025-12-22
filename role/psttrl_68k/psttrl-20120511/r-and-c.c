#include <stdio.h>
/* malloc, rand, abs */
#include <stdlib.h>

#include "corridor.h"
#include "layer-detail.h"
#include "grid-detail.h"
#include "array.h"
#include "list-int.h"
#include "util-corridor.h"

#include "r-and-c.h"

static int fill_grid_with_wall(int **grid, int size_x, int size_y);
static int dig_with_layer(int **grid, int size_x, int size_y,
                          corridor_builder *cbp, int origin_x, int origin_y,
                          int grid_new_floor);
static int add_corridor(corridor_builder *cbp,
                        int corridor_width, int wall_width,
                        int start_cell_u, int start_cell_v,
                        int end_cell_u, int end_cell_v,
                        int n_mark);
static int cbp_init_r_and_c(corridor_builder *cbp,
                            int corridor_width, int wall_width,
                            int cell_room_max, int cell_between_rooms,
                            int smaller_room,
                            int ***rooms,
                            int room_num_u, int room_num_v);
static int build_r_and_c_1(int **grid, int size_x, int size_y,
                           corridor_builder *cbp,
                           int corridor_width, int wall_width,
                           int cell_room_max, int cell_between_rooms,
                           int smaller_room, int connect_more,
                           int ***rooms,
                           int room_num_u, int room_num_v);
static int cbp_init_braid(corridor_builder *cbp);

static int
fill_grid_with_wall(int **grid, int size_x, int size_y)
{
  int x;
  int y;

  if (grid == NULL)
  {
    fprintf(stderr, "fill_grid_with_wall: grid is NULL\n");
    return 1;
  }
  if (size_x <= 0)
  {
    fprintf(stderr, "fill_grid_with_wall: size_x is non-positive (%d)\n",
            size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "fill_grid_with_wall: size_y is non-positive (%d)\n",
            size_y);
    return 1;
  }

  for (x = 0; x < size_x; x++)
  {
    for (y = 0; y < size_y; y++)
    {
      grid[x][y] = GR_WALL;
    }
  }

  return 0;
}

static int
dig_with_layer(int **grid, int size_x, int size_y,
              corridor_builder *cbp, int origin_x, int origin_y,
              int grid_new_floor)
{
  int u;
  int v;
  int x;
  int y;

  if (grid == NULL)
  {
    fprintf(stderr, "dig_with_layer: grid is NULL\n");
    return 1;
  }
  if (cbp == NULL)
  {
    fprintf(stderr, "dig_with_layer: cbp is NULL\n");
    return 1;
  }
  if (size_x <= 0)
  {
    fprintf(stderr, "dig_with_layer: size_x is non-positive (%d)\n", size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "dig_with_layer: size_y is non-positive (%d)\n", size_y);
    return 1;
  }

  for (u = 0; u < cbp->size_u; u++)
  {
    for (v = 0; v < cbp->size_v; v++)
    {
      x = origin_x + u;
      y = origin_y + v;
      if ((x < 0) || (x >= size_x)
          || (y < 0) || (y >= size_y))
        continue;

      if (cbp->layer[u][v] == LAYER_WALL)
        continue;
      if (grid[x][y] != GR_WALL)
        continue;

      grid[x][y] = grid_new_floor;
    }
  }

  return 0;
}

static int
add_corridor(corridor_builder *cbp,
             int corridor_width, int wall_width,
             int start_cell_u, int start_cell_v,
             int end_cell_u, int end_cell_v,
             int n_mark)
{
  int u;
  int v;
  int cell_u;
  int cell_v;
  int dig_in_u;
  int start_u;
  int end_u;
  int start_v;
  int end_v;

  if (cbp == NULL)
    return 1;

  cell_u = start_cell_u;
  cell_v = start_cell_v;
  while ((cell_u != end_cell_u) || (cell_v != end_cell_v))
  {
    if (cell_u == end_cell_u)
      dig_in_u = 0;
    else if (cell_v == end_cell_v)
      dig_in_u = 1;
    else if (rand() % abs(cell_u - end_cell_u)
             >= rand() % abs(cell_v - end_cell_v))
      dig_in_u = 1;
    else
      dig_in_u = 0;

    if (dig_in_u)
    {
      if (cell_u < end_cell_u)
      {
        start_u = 1 + cell_u * (corridor_width + wall_width)
          + corridor_width;
        end_u = 1 + (cell_u + 1) * (corridor_width + wall_width)
          + corridor_width - 1;
      }
      else
      {
        start_u = 1 + (cell_u - 1) * (corridor_width + wall_width);
        end_u = 1 + cell_u * (corridor_width + wall_width)
          - 1;
      }
      start_v = 1 + cell_v * (corridor_width + wall_width);
      end_v = 1 + cell_v * (corridor_width + wall_width)
        + corridor_width - 1;
    }
    else
    {
      if (cell_v < end_cell_v)
      {
        start_v = 1 + cell_v * (corridor_width + wall_width)
          + corridor_width;
        end_v = 1 + (cell_v + 1) * (corridor_width + wall_width)
          + corridor_width - 1;
      }
      else
      {
        start_v = 1 + (cell_v - 1) * (corridor_width + wall_width);
        end_v = 1 + cell_v * (corridor_width + wall_width)
          - 1;
      }
      start_u = 1 + cell_u * (corridor_width + wall_width);
      end_u = 1 + cell_u * (corridor_width + wall_width)
        + corridor_width - 1;
    }

    for (u = start_u; u <= end_u; u++)
    {
      for (v = start_v; v <= end_v; v++)
      {
        if ((u < 0) || (u >= cbp->size_u)
            || (v < 0) || (v >= cbp->size_v))
        {
          fprintf(stderr, "add_corridor: out of layer (%d, %d)\n",
                  u, v);
          return 1;
        }
        if (cbp->layer[u][v] != LAYER_WALL)
          continue;

        corridor_builder_add_mark(cbp,
                                  u, v, n_mark);
      }
    }

    if (dig_in_u)
    {
      if (cell_u < end_cell_u)
        cell_u++;
      else
        cell_u--;
    }
    else
    {
      if (cell_v < end_cell_v)
        cell_v++;
      else
        cell_v--;
    }
  }

  return 0;
}

static int
cbp_init_r_and_c(corridor_builder *cbp,
                 int corridor_width, int wall_width,
                 int cell_room_max, int cell_between_rooms,
                 int smaller_room,
                 int ***rooms,
                 int room_num_u, int room_num_v)
{
  int i;
  int u;
  int v;
  int ru;
  int rv;
  int start_u;
  int start_v;
  int end_u;
  int end_v;
  int start_cell_u;
  int start_cell_v;
  int end_cell_u;
  int end_cell_v;
  int n_mark;

  if (cbp == NULL)
    return 1;
  if (rooms == NULL)
    return 1;

  for (ru = 0; ru < room_num_u; ru++)
  {
    for (rv = 0; rv < room_num_v; rv++)
    {
      rooms[ru][rv][2] = cell_room_max;
      rooms[ru][rv][3] = cell_room_max;

      for (i = 0; i < smaller_room; i++)
      {
        if (i > cell_room_max - 2)
          break;

        if (rand() % 2 == 0)
          (rooms[ru][rv][2])--;
      }

      for (i = 0; i < smaller_room; i++)
      {
        if (i > cell_room_max - 2)
          break;

        if (rand() % 2 == 0)
          (rooms[ru][rv][3])--;
      }

      rooms[ru][rv][0] = ru * (cell_room_max + cell_between_rooms);
      if (cell_room_max + cell_between_rooms - rooms[ru][rv][2] > 0)
        rooms[ru][rv][0] += rand() % (cell_room_max + cell_between_rooms
                                      - rooms[ru][rv][2] + 1);

      rooms[ru][rv][1] = rv * (cell_room_max + cell_between_rooms);
      if (cell_room_max + cell_between_rooms - rooms[ru][rv][3] > 0)
        rooms[ru][rv][1] += rand() % (cell_room_max + cell_between_rooms
                                      - rooms[ru][rv][3] + 1);
    }
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
      start_u = 1 + rooms[ru][rv][0] * (corridor_width + wall_width);
      end_u = 1 + (rooms[ru][rv][0] + rooms[ru][rv][2] - 1)
        * (corridor_width + wall_width) + corridor_width - 1;

      start_v = 1 + rooms[ru][rv][1] * (corridor_width + wall_width);
      end_v = 1 + (rooms[ru][rv][1] + rooms[ru][rv][3] - 1)
        * (corridor_width + wall_width) + corridor_width - 1;

      for (u = start_u; u <= end_u; u++)
      {
        for (v = start_v; v <= end_v; v++)
        {
          cbp->layer[u][v] = LAYER_FLOOR;
        }
      }
    }
  }

  n_mark = 0;

  for (ru = 0; ru < room_num_u - 1; ru++)
  {
    for (rv = 0; rv < room_num_v; rv++)
    {
      start_cell_u = rooms[ru][rv][0] + rand() % rooms[ru][rv][2];
      start_cell_v = rooms[ru][rv][1] + rand() % rooms[ru][rv][3];

      end_cell_u = rooms[ru + 1][rv][0] + rand() % rooms[ru + 1][rv][2];
      end_cell_v = rooms[ru + 1][rv][1] + rand() % rooms[ru + 1][rv][3];

      add_corridor(cbp,
                   corridor_width, wall_width,
                   start_cell_u, start_cell_v,
                   end_cell_u, end_cell_v,
                   n_mark);

      n_mark++;
    }
  }

  for (ru = 0; ru < room_num_u; ru++)
  {
    for (rv = 0; rv < room_num_v - 1; rv++)
    {
      start_cell_u = rooms[ru][rv][0] + rand() % rooms[ru][rv][2];
      start_cell_v = rooms[ru][rv][1] + rand() % rooms[ru][rv][3];

      end_cell_u = rooms[ru][rv + 1][0] + rand() % rooms[ru][rv + 1][2];
      end_cell_v = rooms[ru][rv + 1][1] + rand() % rooms[ru][rv + 1][3];

      add_corridor(cbp,
                   corridor_width, wall_width,
                   start_cell_u, start_cell_v,
                   end_cell_u, end_cell_v,
                   n_mark);

      n_mark++;
    }
  }

  return 0;
}

static int
build_r_and_c_1(int **grid, int size_x, int size_y,
                corridor_builder *cbp,
                int corridor_width, int wall_width,
                int cell_room_max, int cell_between_rooms,
                int smaller_room, int connect_more,
                int ***rooms,
                int room_num_u, int room_num_v)
{
  if (grid == NULL)
    return 1;
  if (size_x <= 0)
    return 1;
  if (size_y <= 0)
    return 1;
  if (cbp == NULL)
    return 1;
  if (rooms == NULL)
    return 1;
  if (room_num_u <= 0)
    return 1;
  if (room_num_v <= 0)
    return 1;

  fill_grid_with_wall(grid, size_x, size_y);
  cbp_init_r_and_c(cbp,
                   corridor_width, wall_width,
                   cell_room_max, cell_between_rooms,
                   smaller_room,
                   rooms,
                   room_num_u, room_num_v);
  /* room floor */
  dig_with_layer(grid, size_x, size_y,
                 cbp, 0, 0,
                 GR_FLOOR);
  corridor_builder_connect(cbp, STRATEGY_BACKTRACK);

  switch (connect_more)
  {
  case CONNECT_MIN:
    /* do nothing*/;
    break;
  case CONNECT_SOME:
    connect_some(cbp, 1);
    break;
  case CONNECT_DEAD_END:
    connect_dead_end(cbp);
    break;
  default:
    fprintf(stderr, "build_r_and_c_1: unknown connect_more (%d)\n",
            connect_more);
    break;
  }

  /* corridor floor */
  dig_with_layer(grid, size_x, size_y,
                 cbp, 0, 0,
                 GR_FLOOR);

  return 0;
}

int
build_r_and_c(world *wp, int z,
              int corridor_width, int wall_width,
              int cell_room_max, int cell_between_rooms,
              int smaller_room, int connect_more)
{
  int size_x;
  int size_y;
  int status;
  int cell_num_u;
  int cell_num_v;
  int room_num_u;
  int room_num_v;
  /* list of rooms[ru][rv]:
   * [0] u coordinate of up-left cell
   * [1] v coordinate of up-left cell
   * [2] number of cells in the room in the u direction
   * [3] number of cells in the room in the v direction
   */
  int ***rooms = NULL;
  corridor_builder *cbp = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "build_r_and_c: wp is NULL\n");
    return 1;
  }
  if ((z < 0) || (z >= wp->size_z))
  {
    fprintf(stderr, "build_r_and_c: strange z (%d)\n", z);
    return 1;
  }
  if (corridor_width <= 0)
  {
    fprintf(stderr, "build_r_and_c: corridor_width is non-positive (%d)\n",
            corridor_width);
    return 1;
  }
  if (wall_width <= 0)
  {
    fprintf(stderr, "build_r_and_c: wall_width is non-positive (%d)\n",
            wall_width);
    return 1;
  }
  if (cell_room_max <= 0)
  {
    fprintf(stderr, "build_r_and_c: cell_room_max is non-positive (%d)\n",
            cell_room_max);
    return 1;
  }
  if (cell_between_rooms < 0)
  {
    fprintf(stderr, "build_r_and_c: cell_between_rooms is negative "
            "(%d)\n",
            cell_between_rooms);
    return 1;
  }

  size_x = wp->size_x;
  size_y = wp->size_y;
  if (size_x <= 0)
  {
    fprintf(stderr, "build_r_and_c: size_x is non-positive (%d)\n",
            size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "build_r_and_c: size_y is non-positive (%d)\n",
            size_y);
    return 1;
  }

  if ((size_x < corridor_width + 2)
      || (size_y < corridor_width + 2))
  {
    fprintf(stderr, "build_r_and_c: map (%d x %d) is smaller than a cell\n",
            size_x, size_y);
    return 1;
  }

  cell_num_u = size_x - (corridor_width + 2);
  cell_num_u /= corridor_width + wall_width;
  cell_num_u += 1;

  cell_num_v = size_y - (corridor_width + 2);
  cell_num_v /= corridor_width + wall_width;
  cell_num_v += 1;

  if ((cell_num_u < cell_room_max + cell_between_rooms)
      || (cell_num_v < cell_room_max + cell_between_rooms))
  {
    fprintf(stderr, "build_r_and_c: map (%d x %d) is smaller than "
            "a room\n",
            size_x, size_y);
    return 1;
  }

  room_num_u = cell_num_u / (cell_room_max + cell_between_rooms);
  room_num_v = cell_num_v / (cell_room_max + cell_between_rooms);

  rooms = array3_new(room_num_u, room_num_v, 4);
  if (rooms == NULL)
  {
    fprintf(stderr, "build_r_and_c: array3_new failed\n");
    return 1;
  }

  cbp = corridor_builder_new(size_x, size_y);
  if (cbp == NULL)
  {
    fprintf(stderr, "build_r_and_c: corridor_builder_new failed\n");
    array3_delete(rooms, room_num_u, room_num_v, 4);
    rooms = NULL;
    return 1;
  }

  status = build_r_and_c_1(wp->grid[z], size_x, size_y,
                           cbp,
                           corridor_width, wall_width,
                           cell_room_max, cell_between_rooms,
                           smaller_room, connect_more,
                           rooms,
                           room_num_u, room_num_v);
  if (status != 0)
  {
    fprintf(stderr, "build_r_and_c: build_r_and_c_1 failed\n");
  }

  array3_delete(rooms, room_num_u, room_num_v, 4);
  rooms = NULL;
  corridor_builder_delete(cbp);
  cbp = NULL;

  return 0;
}

static int
cbp_init_braid(corridor_builder *cbp)
{
  int i;
  int j;
  int u;
  int v;
  int du;
  int dv;
  int circle_num;
  int center_u;
  int center_v;
  int n_mark;

  if (cbp == NULL)
  {
    fprintf(stderr, "cbp_init_braid: cbp is NULL\n");
    return 1;
  }

  if ((cbp->size_u < 5) || (cbp->size_v < 5))
  {
    fprintf(stderr, "cbp_init_braid: layer (%d, %d) is too small\n",
            cbp->size_u, cbp->size_v);
    return 1;
  }

  circle_num = (cbp->size_u - 5) / 4;
  if (circle_num > (cbp->size_v - 5) / 4)
    circle_num = (cbp->size_v - 5) / 4;

  center_u = 2 * circle_num + 2;
  center_v = 2 * circle_num + 2;

  for (u = 0; u < cbp->size_u; u++)
  {
    for (v = 0; v < cbp->size_v; v++)
    {
      cbp->layer[u][v] = LAYER_WALL;
    }
  }

  for (u = center_u - 1; u <= center_u + 1; u++)
  {
    for (v = center_v - 1; v <= center_v + 1; v++)
    {
      cbp->layer[u][v] = LAYER_FLOOR;
    }
  }

  for (i = 0; i < circle_num; i++)
  {
    for (u = center_u - (3 + i * 2); u <= center_u + (3 + i * 2); u++)
    {
      cbp->layer[u][center_v - (3 + i * 2)] = LAYER_FLOOR;
      cbp->layer[u][center_v + (3 + i * 2)] = LAYER_FLOOR;
    }
    for (v = center_v - (3 + i * 2); v <= center_v + (3 + i * 2); v++)
    {
      cbp->layer[center_u - (3 + i * 2)][v] = LAYER_FLOOR;
      cbp->layer[center_u + (3 + i * 2)][v] = LAYER_FLOOR;
    }
  }

  if (circle_num <= 0)
    return 0;

  n_mark = 0;

  for (du = -1; du <= 1; du += 2)
  {
    for (dv = -1; dv <= 1; dv += 2)
    {
      u = center_u + 1 * du;
      v = center_v + 2 * dv;

      cbp->layer[u][v] = LAYER_WALL;
      corridor_builder_add_mark(cbp, u, v, n_mark);
      n_mark++;
    }
  }

  for (du = -1; du <= 1; du += 2)
  {
    for (dv = -1; dv <= 1; dv += 2)
    {
      u = center_u + 2 * du;
      v = center_v + 1 * dv;

      cbp->layer[u][v] = LAYER_WALL;
      corridor_builder_add_mark(cbp, u, v, n_mark);
      n_mark++;
    }
  }

  /* handle j = 0 in the below loop separately
   * so that only one mark will be added to a wall
   */
  for (i = 0; i < circle_num; i += 2)
  {
    for (dv = -1; dv <= 1; dv += 2)
    {
      u = center_u;
      v = center_v + (3 + i * 2) * dv;

      cbp->layer[u][v] = LAYER_WALL;
      corridor_builder_add_mark(cbp, u, v, n_mark);
      n_mark++;
    }

    for (du = -1; du <= 1; du += 2)
    {
      u = center_u + (3 + i * 2) * du;
      v = center_v;

      cbp->layer[u][v] = LAYER_WALL;
      corridor_builder_add_mark(cbp, u, v, n_mark);
      n_mark++;
    }
  }

  for (i = 0; i < circle_num; i += 2)
  {
    for (j = 4; j <= 3 + i * 2; j += 4)
    {
      for (du = -1; du <= 1; du += 2)
      {
        for (dv = -1; dv <= 1; dv += 2)
        {
          u = center_u + j * du;
          v = center_v + (3 + i * 2) * dv;

          cbp->layer[u][v] = LAYER_WALL;
          corridor_builder_add_mark(cbp, u, v, n_mark);
          n_mark++;
        }
      }

      for (du = -1; du <= 1; du += 2)
      {
        for (dv = -1; dv <= 1; dv += 2)
        {
          u = center_u + (3 + i * 2) * du;
          v = center_v + j * dv;

          cbp->layer[u][v] = LAYER_WALL;
          corridor_builder_add_mark(cbp, u, v, n_mark);
          n_mark++;
        }
      }
    }
  }

  for (i = 1; i < circle_num; i += 2)
  {
    for (j = 2; j <= 3 + i * 2; j += 4)
    {
      for (du = -1; du <= 1; du += 2)
      {
        for (dv = -1; dv <= 1; dv += 2)
        {
          u = center_u + j * du;
          v = center_v + (3 + i * 2) * dv;

          cbp->layer[u][v] = LAYER_WALL;
          corridor_builder_add_mark(cbp, u, v, n_mark);
          n_mark++;
        }
      }

      for (du = -1; du <= 1; du += 2)
      {
        for (dv = -1; dv <= 1; dv += 2)
        {
          u = center_u + (3 + i * 2) * du;
          v = center_v + j * dv;

          cbp->layer[u][v] = LAYER_WALL;
          corridor_builder_add_mark(cbp, u, v, n_mark);
          n_mark++;
        }
      }
    }
  }

  for (i = 1; i < circle_num; i += 2)
  {
    for (j = 1; j < 3 + i * 2; j += 4)
    {
      for (du = -1; du <= 1; du += 2)
      {
        for (dv = -1; dv <= 1; dv += 2)
        {
          u = center_u + j * du;
          v = center_v + (2 + i * 2) * dv;

          corridor_builder_add_mark(cbp, u, v, n_mark);
          n_mark++;
        }
      }

      for (du = -1; du <= 1; du += 2)
      {
        for (dv = -1; dv <= 1; dv += 2)
        {
          u = center_u + (2 + i * 2) * du;
          v = center_v + j * dv;

          corridor_builder_add_mark(cbp, u, v, n_mark);
          n_mark++;
        }
      }
    }
  }

  for (i = 2; i < circle_num; i += 2)
  {
    for (j = 3; j < 3 + i * 2; j += 4)
    {
      for (du = -1; du <= 1; du += 2)
      {
        for (dv = -1; dv <= 1; dv += 2)
        {
          u = center_u + j * du;
          v = center_v + (2 + i * 2) * dv;

          corridor_builder_add_mark(cbp, u, v, n_mark);
          n_mark++;
        }
      }

      for (du = -1; du <= 1; du += 2)
      {
        for (dv = -1; dv <= 1; dv += 2)
        {
          u = center_u + (2 + i * 2) * du;
          v = center_v + j * dv;

          corridor_builder_add_mark(cbp, u, v, n_mark);
          n_mark++;
        }
      }
    }
  }

  return 0;
}

int
build_braid(world *wp, int z,
            int connect_some_loop)
{
  int size_x;
  int size_y;
  corridor_builder *cbp = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "build_braid: wp is NULL\n");
    return 1;
  }
  if ((z < 0) || (z >= wp->size_z))
  {
    fprintf(stderr, "build_braid: strange z (%d)\n", z);
    return 1;
  }

  size_x = wp->size_x;
  size_y = wp->size_y;
  if (size_x <= 0)
  {
    fprintf(stderr, "build_braid: size_x is non-positive (%d)\n", size_x);
    return 1;
  }
  if (size_y <= 0)
  {
    fprintf(stderr, "build_braid: size_y is non-positive (%d)\n", size_y);
    return 1;
  }

  if ((size_x < 5) || (size_y < 5))
  {
    fprintf(stderr, "build_braid: map (%d x %d) is too small\n",
            size_x, size_y);
    return 1;
  }

  cbp = corridor_builder_new(size_x, size_y);
  if (cbp == NULL)
  {
    fprintf(stderr, "build_braid: corridor_builder_new failed\n");
    return 1;
  }

  fill_grid_with_wall(wp->grid[z], size_x, size_y);
  cbp_init_braid(cbp);
  /* room floor */
  dig_with_layer(wp->grid[z], size_x, size_y,
                 cbp, 0, 0,
                 GR_FLOOR);
  corridor_builder_connect(cbp, STRATEGY_BACKTRACK);
  if (connect_some_loop > 0)
    connect_some(cbp, connect_some_loop);
  /* corridor floor */
  dig_with_layer(wp->grid[z], size_x, size_y,
                 cbp, 0, 0,
                 GR_FLOOR);

  corridor_builder_delete(cbp);
  cbp = NULL;

  return 0;
}
