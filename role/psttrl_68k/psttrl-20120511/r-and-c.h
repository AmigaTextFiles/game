#ifndef __PSTTRL_R_AND_C_H__
#define __PSTTRL_R_AND_C_H__

#include "world.h"

/* for connect_more (arg 9) in build_r_and_c() */
#define CONNECT_MIN 0
#define CONNECT_SOME 1
#define CONNECT_DEAD_END 2

int build_r_and_c(world *wp, int z,
                  int corridor_width, int wall_width,
                  int cell_room_max, int cell_between_rooms,
                  int smaller_room, int connect_more);
int build_braid(world *wp, int z,
                int connect_some_loop);

#endif /* not __PSTTRL_R_AND_C_H__ */
