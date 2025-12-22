#ifndef __KSMN_ACTION_H__
#define __KSMN_ACTION_H__

#include "world.h"

#define POLYMORPH_SELF_LEVEL_COST 1

/* all ACTION_* must be positive */
#define ACTION_STAY 1
#define ACTION_WALK 2
#define ACTION_SAVE 3
#define ACTION_CLIMB_STAIR 4
#define ACTION_PICKUP_WEAPON 5
#define ACTION_DROP_WEAPON 6
#define ACTION_CHANGE_WEAPON 7
#define ACTION_THROW_WEAPON 8
#define ACTION_POLYMORPH_SELF 9

int action_check(world *wp, int creature_id, int *act);
int action_exec(world *wp, int creature_id);

#endif /* not __KSMN_ACTION_H__ */
