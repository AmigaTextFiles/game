#ifndef __PSTTRL_JUDGE_H__
#define __PSTTRL_JUDGE_H__

struct _combat_stat
{
  int creature_id;
  int creature_type;
  int weapon_id;
  int weapon_which;
  int z;
  int x;
  int y;
  int level;
  int hp;
  int max_hp;
  int strength;
  int defense;
  int attack;
};
typedef struct _combat_stat combat_stat;

struct _combat_judge
{
  combat_stat *attacker_orig;
  combat_stat *defender_orig;
  combat_stat *attacker;
  combat_stat *defender;
  int post_move_attack;
  int veto_attacker_creature;
  int veto_defender_creature;
  int veto_attacker_weapon;
  int veto_defender_weapon;
  int dodge;
  int parry;
  int accurate;
  int reflect;
  int cannot_reflect;
  int critical;
  int cannot_critical;
  int did_blow;
};
typedef struct _combat_judge combat_judge;

combat_stat *combat_stat_new(void);
void combat_stat_delete(combat_stat *p);

combat_judge *combat_judge_new(void);
void combat_judge_delete(combat_judge *p);
int combat_judge_reset(combat_judge *p);

int combat_stat_copy(combat_stat *cbtstp_to, combat_stat *cbtstp_from);
int combat_judge_copy(combat_judge *cbtjp_to, combat_judge *cbtjp_from);

#endif /* not __PSTTRL_JUDGE_H__ */
