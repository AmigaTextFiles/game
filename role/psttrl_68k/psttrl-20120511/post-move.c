#include <stdio.h>

#include "world.h"
#include "creature.h"
#include "dungeon.h"
#include "creature-detail.h"
#include "weapon-detail.h"

#include "post-move.h"

int
creature_can_post_move_attack(world *wp, int creature_id)
{
  creature *who = NULL;

  if (wp == NULL)
  {
    fprintf(stderr, "creature_can_post_move_attack: wp is NULL\n");
    return 0;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "creature_can_post_move_attack: strange creature_id "
            "(%d)\n", creature_id);
    return 0;
  }
  if (wp->cr[creature_id] == NULL)
  {
    fprintf(stderr, "creature_can_post_move_attack: wp->cr[%d] "
            "is NULL\n", creature_id);
    return 0;
  }
  who = wp->cr[creature_id];

  if (creature_is_dead(wp, who->id))
    return 0;

  switch (who->type)
  {
  case CR_TYRANT:
  case CR_BAT:
  case CR_WARLORD:
    return 1;
    break;
  case CR_MILLENNIUM_MONK:
    if (!creature_is_wielding_weapon(wp, who->id))
      return 1;
    break;
  default:
    break;
  }

  if (creature_is_wielding_weapon(wp, who->id))
  {
    switch (wp->itm[who->weapon_id]->which)
    {
    case WP_DAGGER:
    case WP_LANCE:
    case WP_POISON_NEEDLE:
    case WP_COSMIC_CONTRACT:
      return 1;
      break;
    case WP_MAGIC_CANDLE:
      if (who->level <= 1)
        return 1;
      break;
    default:
      break;
    }
  }

  return 0;
}
