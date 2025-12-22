#ifndef __KSMN_MONSTER_H__
#define __KSMN_MONSTER_H__

#include "world.h"
#include "creature.h"

int monster_shout(world *wp, creature *who);
int monster_set_attitude(world *wp, creature *who, int attitude);
int monster_has_path(world *wp, creature *who,
                     int anywhere,
                     int dest_z, int dest_x, int dest_y);
int monster_update_last_known(world *wp);
int monster_forget_last_known(world *wp);
int action_decide_monster(world *wp, int creature_id);

#endif /* not __KSMN_MONSTER_H__ */
