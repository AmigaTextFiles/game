#ifndef __KSMN_PLAYER_CACHE_H__
#define __KSMN_PLAYER_CACHE_H__

struct _player_cache
{
  int z;
  int x;
  int y;
  int map_fov_radius;
  int **map_fov;
};
typedef struct _player_cache player_cache;

player_cache *player_cache_new(int fov_radius);
void player_cache_delete(player_cache *p);

#endif /* not __KSMN_PLAYER_CACHE_H__ */
