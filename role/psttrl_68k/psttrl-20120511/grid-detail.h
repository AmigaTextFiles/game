#ifndef __KSMN_GRID_DETAIL_H__
#define __KSMN_GRID_DETAIL_H__

struct grid_detail
{
  int type;
  const char *name;
  const char *symbol;
  int attr;
};

#define GR_FLOOR 0
#define GR_WALL 1
#define GR_GLASS_WALL 2

#define GR_STAIR_DOWN_0 3
#define GR_STAIR_DOWN_1 4
#define GR_STAIR_DOWN_2 5
#define GR_STAIR_DOWN_3 6

#define GR_STAIR_UP_0 7
#define GR_STAIR_UP_1 8
#define GR_STAIR_UP_2 9
#define GR_STAIR_UP_3 10


#define GRID_TERRAIN_MASK 0xf
/* assumes that the map never changes during the game */
#define GRID_PLAYER_SEEN 0x10

int grid_detail_get(int type, struct grid_detail *grd);

#endif /* not __KSMN_GRID_DETAIL_H__ */
