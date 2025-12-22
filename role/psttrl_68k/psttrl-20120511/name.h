#ifndef __PSTTRL_NAME_H__
#define __PSTTRL_NAME_H__

#include "world.h"

char *get_creature_name(world *wp, int creature_id);
char *get_item_name(world *wp, int item_id, int force_identify);

#endif /* not __PSTTRL_NAME_H__ */
