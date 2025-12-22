#ifndef __KSMN_ACTION_H__
#define __KSMN_ACTION_H__

#include "world.h"

/* all ACTION_* must be positive */
#define ACTION_STAY 1
#define ACTION_WALK 2
#define ACTION_SAVE 3
#define ACTION_CLIMB_STAIR 4
#define ACTION_TOGGLE_SEARCH_RUN 5
#define ACTION_QUAFF_POTION_BAG 6
#define ACTION_READ_SPELLBOOK_SWAP_POTISION 7
#define ACTION_ZAP_ROD_MANA_BALL 8

int successive_run_max(world *wp, int creature_id);

/* creature action */
int action_check(world *wp, int creature_id, int *act);
int action_exec(world *wp, int creature_id);

#endif /* not __KSMN_ACTION_H__ */
