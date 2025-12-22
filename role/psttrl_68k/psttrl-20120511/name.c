#include <stdio.h>

#include "dungeon.h"
#include "util.h"
#include "creature-detail.h"
#include "creature.h"
#include "weapon-detail.h"

#include "name.h"

char *
get_creature_name(world *wp, int creature_id)
{
  char buf[128];
  creature *who = NULL;
  struct creature_detail crd;

  if (wp == NULL)
  {
    fprintf(stderr, "get_creature_name: wp is NULL\n");
    return NULL;
  }
  if ((creature_id < 0) || (creature_id >= wp->cr_size))
  {
    fprintf(stderr, "get_creature_name: strange creature_id (%d)\n",
            creature_id);
    return NULL;
  }

  if (wp->cr[creature_id] == NULL)
  {
    sprintf(buf, "NULL creature id=%d", creature_id);
  }
  else
  {
    who = wp->cr[creature_id];
    creature_detail_get(who->type, &crd);
    sprintf(buf, "%+d %s%s", who->level, crd.name,
            (who->id == wp->player_id) ? " (you)" : "");
  }

  return concat_string(1, buf);
}

char *
get_item_name(world *wp, int item_id, int force_identify)
{
  struct weapon_detail wpd;
  char buf[128];

  if (wp == NULL)
  {
    fprintf(stderr, "get_item_name: wp is NULL\n");
    return NULL;
  }
  if ((item_id < 0) || (item_id >= wp->itm_size))
  {
    fprintf(stderr, "get_item_name: strange item_id (%d)\n", item_id);
    return NULL;
  }

  if (wp->itm[item_id] == NULL)
  {
    sprintf(buf, "NULL item id=%d", item_id);
  }
  else
  {
    switch (wp->itm[item_id]->type)
    {
    case ITEM_TYPE_WEAPON:
      weapon_detail_get(wp->itm[item_id]->which, &wpd);
      sprintf(buf, "%s", wpd.name);
      break;
    case ITEM_TYPE_SCROLL:
      sprintf(buf, "scroll which=%d", wp->itm[item_id]->which);
      break;
    default:
      sprintf(buf, "undefined item type=%d", wp->itm[item_id]->type);
      break;
    }
  }

  return concat_string(1, buf);
}
