#include <stdio.h>

#include "world.h"
#include "loop-action.h"
#include "loop-draw.h"
#include "loop-input.h"

#include "loop.h"

/* meaning of wp->mode[*] for each wp->mode[0]
 * * MODE_WAITING_FOR_ACTION
 *   (none)
 * * MODE_EXAMINE_SURROUNDING
 *   [1] old cursor x
 *   [2] old cursor y
 * * MODE_FULL_SCREEN_LOG
 *   [1] log bottom
 * * MODE_DESCRIBE_CREATURE
 *   [1] creature id
 * * MODE_FULL_SCREEN_MAP
 *   [1] up-left corner x
 *   [2] up-left corner y
 * * MODE_CONFIRM_RESIGN
 *   (none)
 * * MODE_PICKUP_WEAPON
 *   [1] weapon id
 * * MODE_DROP_WEAPON
 *   (none)
 * * MODE_CHANGE_WEAPON_SLOT
 *   (none)
 * * MODE_VIEW_PLAYER
 *   [1] weapon slot
 * * MODE_THROW_WEAPON
 *   [1] weapon id
 * * MODE_POLYMORPH_SELF
 *   (none)
 */

int
main_loop(world *wp)
{
  if (wp == NULL)
  {
    fprintf(stderr, "main_loop: wp is NULL\n");
  }

  /* wp->should_quit must be checked here because loop_input() can
   * set it if the player resigns the game
   */
  while(!(wp->should_quit))
  {
    /* loop_action() must be before loop_draw() or loop_input()
     * so that loop_upkeep_action() can be called at the beginning
     * of the game before the player do anything
     * loop_draw() must be before loop_input() so that the player
     * can see what is happening in its first turn
     */
    if (loop_action(wp) != 0)
      break;

    /* loop_action() can set wp->should_quit
     * if the player saves the game
     */
    if (wp->should_quit)
      break;

    if (loop_draw(wp) != 0)
      break;

    if (loop_input(wp) != 0)
      break;
  }

  return 0;
}
