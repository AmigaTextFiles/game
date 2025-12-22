#ifndef __CORRIDOR_H__
#define __CORRIDOR_H__

#include "list-int.h"

/* how to connect rooms */
#define STRATEGY_BACKTRACK 0
#define STRATEGY_RANDOM 1

struct _corridor_builder
{
  int size_u;
  int size_v;
  int **layer;
  /* list of marks added to the wall at (u, v) */
  list_int ***mark;
  int size_mark;
  /* list of coordinates of walls with the given mark */
  list_int **marked_wall_u;
  list_int **marked_wall_v;
  /* zero: not seen
   * positive: seen once
   * negative: seen twice
   */
  int *mark_seen;
  int *mark_dug;
  int mark_cache_num;
  int *mark_cache;
  int n_mark_max;
};
typedef struct _corridor_builder corridor_builder;

corridor_builder *corridor_builder_new(int size_u, int size_v);
void corridor_builder_delete(corridor_builder *p);

int corridor_builder_add_mark(corridor_builder *cbp,
                              int u, int v, int n_mark);
int corridor_builder_connect(corridor_builder *cbp,
                             int strategy);

#endif /* not __CORRIDOR_H__ */
