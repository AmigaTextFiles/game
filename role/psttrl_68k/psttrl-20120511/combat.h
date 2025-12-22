#ifndef __PSTTRL_COMBAT_H__
#define __PSTTRL_COMBAT_H__

#include "world.h"
#include "judge.h"

#define CBT_VETO_ATTACKER 0
#define CBT_VETO_DEFENDER 1
#define CBT_BUFF_ATTACKER 2
#define CBT_BUFF_DEFENDER 3
#define CBT_SWAP_ATTACKER 4
#define CBT_SWAP_DEFENDER 5
#define CBT_DODGE_ATTACKER 6
#define CBT_DODGE_DEFENDER 7
#define CBT_MISS_ATTACKER 8
#define CBT_MISS_DEFENDER 9
#define CBT_HIT_ATTACKER 10
#define CBT_HIT_DEFENDER 11
#define CBT_END_ATTACKER 12
#define CBT_END_DEFENDER 13

int creature_to_combat_stat(world *wp, combat_stat *cbtstp, int creature_id);
int combat_stat_is_dead(combat_stat *cbtstp);
int combat_simulate(world *wp, combat_judge *cbtjp);
int prepare_combat_judge(world *wp, combat_judge *cbtjp,
                         int attacker_id, int defender_id);
combat_judge *combat_check(world *wp, int attacker_id, int defender_id);
int combat_exec(world *wp, int attacker_id, int defender_id);

#endif /* not __PSTTRL_COMBAT_H__ */
