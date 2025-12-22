#ifndef __UTIL_CORRIDOR_H__
#define __UTIL_CORRIDOR_H__

#include "corridor.h"

int dig_marked_wall(corridor_builder *cbp, int n_mark);
int connect_some(corridor_builder *cbp, int loop);
int connect_dead_end(corridor_builder *cbp);

#endif /* not __UTIL_CORRIDOR_H__ */
