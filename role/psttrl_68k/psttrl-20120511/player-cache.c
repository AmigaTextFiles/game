#include <stdio.h>
/* malloc */
#include <stdlib.h>

#include "array.h"

#include "player-cache.h"

player_cache *
player_cache_new(int fov_radius)
{
  int n;
  player_cache *p = NULL;

  if (fov_radius < 0)
  {
    fprintf(stderr, "player_cache_new: fov_radius is negative (%d)\n",
            fov_radius);
    return NULL;
  }

  p = (player_cache *) malloc(sizeof(player_cache));
  if (p == NULL)
  {
    fprintf(stderr, "player_cache_new: malloc failed\n");
    return NULL;
  }

  p->z = -1;
  p->x = -1;
  p->y = -1;
  p->map_fov_radius = fov_radius;
  p->map_fov = NULL;

  n = 2 * p->map_fov_radius + 1;
  p->map_fov = array2_new(n, n);
  if (p->map_fov == NULL)
  {
    fprintf(stderr, "player_cache_new: array2_new failed\n");
    player_cache_delete(p);
    p = NULL;
    return NULL;
  }

  return p;
}

void
player_cache_delete(player_cache *p)
{
  int n;

  if (p == NULL)
    return;

  n = 2 * p->map_fov_radius + 1;

  if (p->map_fov != NULL)
  {
    array2_delete(p->map_fov, n, n);
    p->map_fov = NULL;
    p->map_fov_radius = -1;
    n = -1;
  }

  free(p);
  p = NULL;
}
