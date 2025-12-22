#include <stdio.h>
/* free */
#include <stdlib.h>

#include "world.h"
#include "judge.h"
#include "dungeon.h"
#include "creature-detail.h"
#include "weapon-detail.h"
#include "creature.h"
#include "item.h"
#include "name.h"
#include "monster.h"

#include "combat.h"

static int add_empty_slot_bonus(world *wp, combat_stat *cbtstp, int item_id);
static int combat_stat_to_creature(world *wp, combat_stat *cbtstp);
static int combat_simulate_2(world *wp, combat_judge *cbtjp,
                             int phase_attacker, int phase_defender);
static int combat_simulate_1(world *wp, combat_judge *cbtjp);

static int
add_empty_slot_bonus(world *wp, combat_stat *cbtstp, int item_id)
{
  if (cbtstp == NULL)
    return 1;

  if ((item_id < 0) || (item_id >= wp->itm_size)
      || (item_is_dead(wp, item_id)))
  {
    cbtstp->defense += 1;
    cbtstp->attack += 1;
  }

  return 0;
}

int
creature_to_combat_stat(world *wp, combat_stat *cbtstp, int creature_id)
{
  int i;
  creature *who = NULL;
  item *what = NULL;
  struct creature_detail crd;
  struct weapon_detail wpd;

  if (wp == NULL)
    return 1;
  if (cbtstp == NULL)
    return 1;
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
    return 1;
  if (creature_is_dead(wp, creature_id))
    return 1;

  who = wp->cr[creature_id];
  creature_detail_get(who->type, &crd);

  cbtstp->creature_id = who->id;
  cbtstp->creature_type = who->type;
  cbtstp->z = who->z;
  cbtstp->x = who->x;
  cbtstp->y = who->y;
  cbtstp->level = who->level;
  cbtstp->hp = who->hp;
  cbtstp->max_hp = crd.max_hp;
  cbtstp->strength = crd.strength;

  cbtstp->max_hp += cbtstp->level;
  cbtstp->strength += cbtstp->level;

  cbtstp->defense = cbtstp->hp;
  cbtstp->attack = cbtstp->strength;

  if (creature_is_wielding_weapon(wp, who->id))
  {
    what = wp->itm[who->weapon_id];
    weapon_detail_get(what->which, &wpd);
    cbtstp->weapon_id = what->id;
    cbtstp->weapon_which = what->which;

    cbtstp->defense += wpd.defense;
    cbtstp->attack += wpd.attack;
  }
  else
  {
    cbtstp->weapon_id = -1;
    cbtstp->weapon_which = WP_EMPTY_HAND;
  }

  if (who->id == wp->player_id)
  {
    for (i = 0; i < 4; i++)
    { 
      add_empty_slot_bonus(wp, cbtstp, wp->player_sheath[i]);
    }
  }
  else
  {
    add_empty_slot_bonus(wp, cbtstp, who->weapon_id);
  }

  if (cbtstp->creature_type >= NUM_CREATURE)
  {
    fprintf(stderr, "creature_to_combat_stat: strange creature_type (%d)\n",
            cbtstp->creature_type);
    cbtstp->creature_type = -1;
    return 1;
  }
  if (cbtstp->weapon_which >= NUM_WEAPON)
  {
    fprintf(stderr, "creature_to_combat_stat: strange weapon_which (%d)\n",
            cbtstp->weapon_which);
    cbtstp->weapon_which = -1;
    return 1;
  }

  return 0;
}

static int
combat_stat_to_creature(world *wp, combat_stat *cbtstp)
{
  creature *who = NULL;

  if (wp == NULL)
    return 1;
  if (cbtstp == NULL)
    return 1;
  if ((cbtstp->creature_id < 0) || (cbtstp->creature_id >= wp->cr_size))
    return 1;
  if (wp->cr[cbtstp->creature_id] == NULL)
    return 1;
  who = wp->cr[cbtstp->creature_id];

  who->type = cbtstp->creature_type;
  creature_change_z(wp, who->id, cbtstp->z);
  creature_change_xy(wp, who->id, cbtstp->x, cbtstp->y);
  who->level = cbtstp->level;
  who->hp = cbtstp->hp;
  /* check if HP is greater than MHP */
  creature_heal_hp(wp, who->id, 0, 0);

  return 0;
}

int
combat_stat_is_dead(combat_stat *cbtstp)
{
  if (cbtstp == NULL)
  {
    fprintf(stderr, "combat_stat_is_dead: cbtstp is NULL\n");
    return 1;
  }
  if (cbtstp->hp < 0)
    return 1;

  return 0;
}

static int
combat_simulate_2(world *wp, combat_judge *cbtjp,
                  int phase_attacker, int phase_defender)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  if ((cbtjp->attacker->creature_type > 0)
      && (wp->creature_effect_func[cbtjp->attacker->creature_type] != NULL)
      && (!combat_stat_is_dead(cbtjp->attacker))
      && (!(cbtjp->veto_attacker_creature)))
  {
    (*(wp->creature_effect_func[cbtjp->attacker->creature_type]))
      (wp, cbtjp, phase_attacker);
  }
  if ((cbtjp->defender->creature_type > 0)
      && (wp->creature_effect_func[cbtjp->defender->creature_type] != NULL)
      && (!combat_stat_is_dead(cbtjp->defender))
      && (!(cbtjp->veto_defender_creature)))
  {
    (*(wp->creature_effect_func[cbtjp->defender->creature_type]))
      (wp, cbtjp, phase_defender);
  }
  if ((cbtjp->attacker->weapon_which > 0)
      && (wp->weapon_effect_func[cbtjp->attacker->weapon_which] != NULL)
      && (!combat_stat_is_dead(cbtjp->attacker))
      && (!(cbtjp->veto_attacker_weapon)))
  {
    (*(wp->weapon_effect_func[cbtjp->attacker->weapon_which]))
      (wp, cbtjp, phase_attacker);
  }
  if ((cbtjp->defender->weapon_which > 0)
      && (wp->weapon_effect_func[cbtjp->defender->weapon_which] != NULL)
      && (!combat_stat_is_dead(cbtjp->defender))
      && (!(cbtjp->veto_defender_weapon)))
  {
    (*(wp->weapon_effect_func[cbtjp->defender->weapon_which]))
      (wp, cbtjp, phase_defender);
  }

  return 0;
}

static int
combat_simulate_1(world *wp, combat_judge *cbtjp)
{
  if (wp == NULL)
    return 1;
  if (cbtjp == NULL)
    return 1;

  combat_simulate_2(wp, cbtjp,
                    CBT_VETO_ATTACKER, CBT_VETO_DEFENDER);
  combat_simulate_2(wp, cbtjp,
                    CBT_BUFF_ATTACKER, CBT_BUFF_DEFENDER);
  combat_simulate_2(wp, cbtjp,
                    CBT_SWAP_ATTACKER, CBT_SWAP_DEFENDER);
  combat_simulate_2(wp, cbtjp,
                    CBT_DODGE_ATTACKER, CBT_DODGE_DEFENDER);

  if ((combat_stat_is_dead(cbtjp->attacker))
      || (combat_stat_is_dead(cbtjp->defender)))
    return 0;

  cbtjp->did_blow = 1;

  if ((cbtjp->reflect) && (!(cbtjp->cannot_reflect)))
  {
    if (cbtjp->attacker->attack >= cbtjp->attacker->defense)
    {
      cbtjp->attacker->hp = -99;
    }
    else
    {
      cbtjp->attacker->hp -= 1;
    }
    combat_simulate_2(wp, cbtjp,
                      CBT_MISS_ATTACKER, CBT_MISS_DEFENDER);
    return 0;
  }

  if ((cbtjp->dodge) && (!(cbtjp->accurate)))
  {
    combat_simulate_2(wp, cbtjp,
                      CBT_MISS_ATTACKER, CBT_MISS_DEFENDER);
    return 0;
  }

  if (cbtjp->attacker->attack >= cbtjp->defender->defense)
  {
    cbtjp->defender->hp = -99;
  }
  else
  {
    cbtjp->defender->hp -= 1;
  }

  if ((cbtjp->parry) && (!(cbtjp->accurate)))
  {
    combat_simulate_2(wp, cbtjp,
                      CBT_MISS_ATTACKER, CBT_MISS_DEFENDER);
    return 0;
  }

  if ((cbtjp->critical) && (!(cbtjp->cannot_critical)))
  {
    cbtjp->defender->hp = -99;
  }
  combat_simulate_2(wp, cbtjp,
                    CBT_HIT_ATTACKER, CBT_HIT_DEFENDER);

  return 0;
}

int
combat_simulate(world *wp, combat_judge *cbtjp)
{
  if (wp == NULL)
  {
    fprintf(stderr, "combat_simulate: wp is NULL\n");
    return 1;
  }
  if (cbtjp == NULL)
  {
    fprintf(stderr, "combat_simulate: cbtjp is NULL\n");
    return 1;
  }

  combat_simulate_1(wp, cbtjp);
  combat_simulate_2(wp, cbtjp,
                    CBT_END_ATTACKER, CBT_END_DEFENDER);

  return 0;
}

int
prepare_combat_judge(world *wp, combat_judge *cbtjp,
                     int attacker_id, int defender_id)
{
  if (wp == NULL)
  {
    fprintf(stderr, "prepare_combat_judge: wp is NULL\n");
    return 1;
  }
  if (cbtjp == NULL)
  {
    fprintf(stderr, "prepare_combat_judge: cbtjp is NULL\n");
    return 1;
  }
  if ((attacker_id < 0) || (attacker_id >= wp->cr_size))
  {
    fprintf(stderr, "prepare_combat_judge: strange attacker_id (%d)\n",
            attacker_id);
    return 1;
  }
  if (creature_is_dead(wp, attacker_id))
  {
    fprintf(stderr, "prepare_combat_judge: attacker (%d) is dead\n",
            attacker_id);
    return 1;
  }
  if ((defender_id < 0) || (defender_id >= wp->cr_size))
  {
    fprintf(stderr, "prepare_combat_judge: strange defender_id (%d)\n",
            defender_id);
    return 1;
  }
  if (creature_is_dead(wp, defender_id))
  {
    fprintf(stderr, "prepare_combat_judge: attacker (%d) is dead\n",
            defender_id);
    return 1;
  }

  combat_judge_reset(cbtjp);
  if (creature_to_combat_stat(wp, cbtjp->attacker_orig, attacker_id) != 0)
  {
    fprintf(stderr, "prepare_combat_judge: creature_to_combat_stat(attacker) "
            "failed\n");
    combat_judge_delete(cbtjp);
    cbtjp = NULL;
    return 1;
  }
  if (creature_to_combat_stat(wp, cbtjp->defender_orig, defender_id) != 0)
  {
    fprintf(stderr, "prepare_combat_judge: creature_to_combat_stat(defender) "
            "failed\n");
    combat_judge_delete(cbtjp);
    cbtjp = NULL;
    return 1;
  }
  combat_stat_copy(cbtjp->attacker, cbtjp->attacker_orig);
  combat_stat_copy(cbtjp->defender, cbtjp->defender_orig);
  if (wp->turn_state == TURN_STATE_NORMAL)
    cbtjp->post_move_attack = 0;
  else
    cbtjp->post_move_attack = 1;

  return 0;
}

combat_judge *
combat_check(world *wp, int attacker_id, int defender_id)
{
  combat_judge *cbtjp = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "combat_check: wp is NULL\n");
    return NULL;
  }
  if ((attacker_id < 0) || (attacker_id >= wp->cr_size))
  {
    fprintf(stderr, "combat_check: strange attacker_id (%d)\n",
            attacker_id);
    return NULL;
  }
  if (creature_is_dead(wp, attacker_id))
  {
    fprintf(stderr, "combat_check: attacker (%d) is dead\n", attacker_id);
    return NULL;
  }
  if ((defender_id < 0) || (defender_id >= wp->cr_size))
  {
    fprintf(stderr, "combat_check: strange defender_id (%d)\n",
            defender_id);
    return NULL;
  }
  if (creature_is_dead(wp, defender_id))
  {
    fprintf(stderr, "combat_check: attacker (%d) is dead\n", defender_id);
    return NULL;
  }

  cbtjp = combat_judge_new();
  if (cbtjp == NULL)
  {
    fprintf(stderr, "combat_check: combat_judge_new failed\n");
    return NULL;
  }

  prepare_combat_judge(wp, cbtjp, attacker_id, defender_id);
  combat_simulate(wp, cbtjp);

  return cbtjp;
}

int
combat_exec(world *wp, int attacker_id, int defender_id)
{
  combat_judge *cbtjp = NULL;
  char *attacker_name = NULL;
  char *defender_name = NULL;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "combat_exec: wp is NULL\n");
    return 1;
  }

  cbtjp = combat_check(wp, attacker_id, defender_id);
  if (cbtjp == NULL)
  {
    fprintf(stderr, "combat_exec: combat_check failed\n");
    return 1;
  }

  /* if we are in combat against the player, notice the player */
  if ((attacker_id == wp->player_id)
      || (defender_id == wp->player_id))
  {
    if (attacker_id != wp->player_id)
      monster_set_attitude(wp, wp->cr[attacker_id], ATTITUDE_MONSTER_ACTIVE);
    if (defender_id != wp->player_id)
      monster_set_attitude(wp, wp->cr[defender_id], ATTITUDE_MONSTER_ACTIVE);
  }

  attacker_name = get_creature_name(wp, attacker_id);
  defender_name = get_creature_name(wp, defender_id);

  if (cbtjp->did_blow)
  {
    if ((cbtjp->reflect) && (!(cbtjp->cannot_reflect)))
    {
      if (defender_name == NULL)
      {
        sprintf(buf, "NULL reflects attack of something");
      }
      else if (attacker_name == NULL)
      {
        sprintf(buf, "%s reflects attack of NULL",
                defender_name);
      }
      else
      {
        sprintf(buf, "%s reflects attack of %s",
                defender_name, attacker_name);
      }
      add_log(wp, buf);
    }
    else if ((cbtjp->dodge) && (!(cbtjp->accurate)))
    {
      if (defender_name == NULL)
      {  
        sprintf(buf, "NULL dodges attack of something");
      }
      else if (attacker_name == NULL)
      {  
        sprintf(buf, "%s dodges attack of NULL",
                defender_name);
      }
      else
      {  
        sprintf(buf, "%s dodges attack of %s",
                defender_name, attacker_name);
      }
      add_log(wp, buf);
    }
    else if ((cbtjp->parry) && (!(cbtjp->accurate)))
    {
      if (defender_name == NULL)
      {        
        sprintf(buf, "NULL parries attack of something");
      }
      else if (attacker_name == NULL)
      {        
        sprintf(buf, "%s parries attack of NULL",
                defender_name);
      }
      else
      {        
        sprintf(buf, "%s parries attack of %s",
                defender_name, attacker_name);
      }
      add_log(wp, buf);
    }
    else
    {
      if (defender_name == NULL)
      {  
        sprintf(buf, "NULL hits something");
      }
      else if (defender_name == NULL)
      {  
        sprintf(buf, "%s hits NULL",
                attacker_name);
      }
      else
      {  
        sprintf(buf, "%s hits %s",
                attacker_name, defender_name);
      }
      add_log(wp, buf);

      if ((cbtjp->critical) && (!(cbtjp->cannot_critical)))
      {
        add_log(wp, "it is critical");
      }
    }
  }

  combat_stat_to_creature(wp, cbtjp->attacker);
  combat_stat_to_creature(wp, cbtjp->defender);

  if (creature_is_dead(wp, cbtjp->attacker->creature_id))
  {
    credit_kill(wp,
                cbtjp->attacker->creature_id,
                cbtjp->defender->creature_id);
    creature_die(wp, cbtjp->attacker->creature_id);
  }
  if (creature_is_dead(wp, cbtjp->defender->creature_id))
  {
    credit_kill(wp,
                cbtjp->defender->creature_id,
                cbtjp->attacker->creature_id);
    creature_die(wp, cbtjp->defender->creature_id);
  }

  combat_judge_delete(cbtjp);
  cbtjp = NULL;
  if (attacker_name != NULL)
  {
    free(attacker_name);
    attacker_name = NULL;
  }
  if (defender_name != NULL)
  {
    free(defender_name);
    defender_name = NULL;
  }

  return 0;
}

