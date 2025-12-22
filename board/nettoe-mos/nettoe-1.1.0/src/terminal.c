/* netToe Version 1.1.0
 * Release date: 22 July 2001
 * Copyright 2000,2001 Gabriele Giorgetti <g.gabriele@europe.com>
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include <stdio.h>
#include <stdlib.h>

#include "terminal.h"
#include "game.h"


void nettoe_term_clear (void)
{
   system("clear");
}


/* same as nettoe_term_reset_color ( void ) */
void nettoe_term_set_default_color (void)
{
   if (NO_COLORS != 1)
     nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_RESET);

   return;
}


void nettoe_term_reset_color ( void )
{
   if (NO_COLORS != 1)
     nettoe_term_set_color (COLOR_WHITE, COLOR_BLACK, ATTRIB_RESET);

   return;
}


void nettoe_term_set_color (int fg, int bg, int attrib)
{
   char cmd_str[13];

   if (NO_COLORS != 1)
     {
        // cmd_str is the control command to the terminal
        sprintf(cmd_str, "%c[%d;%d;%dm", 0x1B, attrib, fg + 30, bg + 40);

        printf("%s", cmd_str);
     }

   return;
}

