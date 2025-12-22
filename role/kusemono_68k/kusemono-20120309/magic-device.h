#ifndef __KSMN_MAGIC_DEVICE_H__
#define __KSMN_MAGIC_DEVICE_H__

#include "world.h"

#define POTION_HEALING 0
#define POTION_SPEED 1

int quaff_potion_bag(world *wp, int type);
int read_spellbook_swap_position(world *wp, int target_x, int target_y);
int zap_rod_mana_ball(world *wp, int dx, int dy);

#endif /* not __KSMN_MAGIC_DEVICE_H__ */
