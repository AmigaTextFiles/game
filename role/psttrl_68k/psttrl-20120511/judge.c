#include <stdio.h>
/* malloc */
#include <stdlib.h>

#include "judge.h"

static int combat_stat_reset(combat_stat *p);

combat_stat *
combat_stat_new(void)
{
  combat_stat *p = NULL;

  p = (combat_stat *) malloc(sizeof(combat_stat));
  if (p == NULL)
  {
    fprintf(stderr, "combat_stat_new: malloc failed\n");
    return NULL;
  }

  p->creature_id = -1;
  p->creature_type = -1;
  p->weapon_id = -1;
  p->weapon_which = -1;
  p->z = -1;
  p->x = -1;
  p->y = -1;
  p->level = 0;
  p->hp = -1;
  p->max_hp = -1;
  p->strength = -1;
  p->defense = -1;
  p->attack = -1;

  return p;
}

void
combat_stat_delete(combat_stat *p)
{
  if (p == NULL)
    return;

  free(p);
  p = NULL;
}

static int
combat_stat_reset(combat_stat *p)
{
  if (p == NULL)
    return 1;

  p->creature_id = -1;
  p->creature_type = -1;
  p->weapon_id = -1;
  p->weapon_which = -1;
  p->z = -1;
  p->x = -1;
  p->y = -1;
  p->level = 0;
  p->hp = -1;
  p->max_hp = -1;
  p->strength = -1;
  p->defense = -1;
  p->attack = -1;

  return 0;
}

combat_judge *
combat_judge_new(void)
{
  combat_judge *p = NULL;

  p = (combat_judge *) malloc(sizeof(combat_judge));
  if (p == NULL)
  {
    fprintf(stderr, "combat_judge_new: malloc failed\n");
    return NULL;
  }

  p->attacker_orig = NULL;
  p->defender_orig = NULL;
  p->attacker = NULL;
  p->defender = NULL;
  p->post_move_attack = 0;
  p->veto_attacker_creature = 0;
  p->veto_defender_creature = 0;
  p->veto_attacker_weapon = 0;
  p->veto_defender_weapon = 0;
  p->dodge = 0;
  p->parry = 0;
  p->accurate = 0;
  p->reflect = 0;
  p->cannot_reflect = 0;
  p->critical = 0;
  p->cannot_critical = 0;
  p->did_blow = 0;

  p->attacker_orig = combat_stat_new();
  if (p->attacker_orig == NULL)
  {
    fprintf(stderr, "combat_judge_new: combat_stat_new(attacker_orig) "
            "failed\n");
    combat_judge_delete(p);
    p = NULL;
    return NULL;
  }

  p->defender_orig = combat_stat_new();
  if (p->defender_orig == NULL)
  {
    fprintf(stderr, "combat_judge_new: combat_stat_new(defender_orig) "
            "failed\n");
    combat_judge_delete(p);
    p = NULL;
    return NULL;
  }

  p->attacker = combat_stat_new();
  if (p->attacker == NULL)
  {
    fprintf(stderr, "combat_judge_new: combat_stat_new(attacker) failed\n");
    combat_judge_delete(p);
    p = NULL;
    return NULL;
  }

  p->defender = combat_stat_new();
  if (p->defender == NULL)
  {
    fprintf(stderr, "combat_judge_new: combat_stat_new(defender) failed\n");
    combat_judge_delete(p);
    p = NULL;
    return NULL;
  }

  return p;
}

void
combat_judge_delete(combat_judge *p)
{
  if (p == NULL)
    return;

  if (p->attacker_orig != NULL)
  {
    combat_stat_delete(p->attacker_orig);
    p->attacker_orig = NULL;
  }
  if (p->defender_orig != NULL)
  {
    combat_stat_delete(p->defender_orig);
    p->defender_orig = NULL;
  }
  if (p->attacker != NULL)
  {
    combat_stat_delete(p->attacker);
    p->attacker = NULL;
  }
  if (p->defender != NULL)
  {
    combat_stat_delete(p->defender);
    p->defender = NULL;
  }

  free(p);
  p = NULL;
}

int
combat_judge_reset(combat_judge *p)
{
  if (p == NULL)
  {
    fprintf(stderr, "combat_judge_reset: p is NULL\n");
    return 1;
  }

  combat_stat_reset(p->attacker_orig);
  combat_stat_reset(p->defender_orig);
  combat_stat_reset(p->attacker);
  combat_stat_reset(p->defender);
  p->post_move_attack = 0;
  p->veto_attacker_creature = 0;
  p->veto_defender_creature = 0;
  p->veto_attacker_weapon = 0;
  p->veto_defender_weapon = 0;
  p->dodge = 0;
  p->parry = 0;
  p->accurate = 0;
  p->reflect = 0;
  p->cannot_reflect = 0;
  p->critical = 0;
  p->cannot_critical = 0;
  p->did_blow = 0;

  return 0;
}

int
combat_stat_copy(combat_stat *cmbstp_to, combat_stat *cmbstp_from)
{
  if (cmbstp_to == NULL)
  {
    fprintf(stderr, "combat_stat_copy: cmbstp_to is NULL\n");
    return 1;
  }
  if (cmbstp_from == NULL)
  {
    fprintf(stderr, "combat_stat_copy: cmbstp_from is NULL\n");
    return 1;
  }

  cmbstp_to->creature_id = cmbstp_from->creature_id;
  cmbstp_to->creature_type = cmbstp_from->creature_type;
  cmbstp_to->weapon_id = cmbstp_from->weapon_id;
  cmbstp_to->weapon_which = cmbstp_from->weapon_which;
  cmbstp_to->z = cmbstp_from->z;
  cmbstp_to->x = cmbstp_from->x;
  cmbstp_to->y = cmbstp_from->y;
  cmbstp_to->level = cmbstp_from->level;
  cmbstp_to->hp = cmbstp_from->hp;
  cmbstp_to->max_hp = cmbstp_from->max_hp;
  cmbstp_to->strength = cmbstp_from->strength;
  cmbstp_to->defense = cmbstp_from->defense;
  cmbstp_to->attack = cmbstp_from->attack;

  return 0;
}

int
combat_judge_copy(combat_judge *cbtjp_to, combat_judge *cbtjp_from)
{
  if (cbtjp_to == NULL)
  {
    fprintf(stderr, "combat_judge_copy: cbtjp_to is NULL\n");
    return 1;
  }
  if (cbtjp_from == NULL)
  {
    fprintf(stderr, "combat_judge_copy: cbtjp_from is NULL\n");
    return 1;
  }

  combat_stat_copy(cbtjp_to->attacker_orig, cbtjp_from->attacker_orig);
  combat_stat_copy(cbtjp_to->defender_orig, cbtjp_from->defender_orig);
  combat_stat_copy(cbtjp_to->attacker, cbtjp_from->attacker);
  combat_stat_copy(cbtjp_to->defender, cbtjp_from->defender);
  cbtjp_to->post_move_attack = cbtjp_from->post_move_attack;
  cbtjp_to->veto_attacker_creature
    = cbtjp_from->veto_attacker_creature;
  cbtjp_to->veto_defender_creature
    = cbtjp_from->veto_defender_creature;
  cbtjp_to->veto_attacker_weapon
    = cbtjp_from->veto_attacker_weapon;
  cbtjp_to->veto_defender_weapon
    = cbtjp_from->veto_defender_weapon;
  cbtjp_to->dodge = cbtjp_from->dodge;
  cbtjp_to->parry = cbtjp_from->parry;
  cbtjp_to->accurate = cbtjp_from->accurate;
  cbtjp_to->reflect = cbtjp_from->reflect;
  cbtjp_to->cannot_reflect = cbtjp_from->cannot_reflect;
  cbtjp_to->critical = cbtjp_from->critical;
  cbtjp_to->cannot_critical = cbtjp_from->cannot_critical;
  cbtjp_to->did_blow = cbtjp_from->did_blow;

  return 0;
}
