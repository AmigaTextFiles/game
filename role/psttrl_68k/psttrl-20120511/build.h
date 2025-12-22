#ifndef __KSMN_BUILD_H__
#define __KSMN_BUILD_H__

#include "world.h"

int dump_grid(world *wp, int z);
int check_connection(world *wp, int z);

int build_new_game(world *wp);

#endif /* not __KSMN_BUILD_H__ */
