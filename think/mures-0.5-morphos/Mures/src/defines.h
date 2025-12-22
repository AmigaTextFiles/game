/*

Mures
Copyright (C) 2001 Adam D'Angelo

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#ifndef DEFINES_H

#define DEFINES_H

#define NUM_BLOCKS_X 12
#define NUM_BLOCKS_Y 9

#define MAX_CREATURE 220
#define MAX_MOUSE 200

#define MAX_CAT 4 /* used in cat attack */

#define MAX_ARROW 16
#define BATTLE_MAX_ARROW 3 /* per player */
#define ARROW_TOUGHNESS 2

#define MAX_PLAYER 4

#define MAX_GENERATOR MAX_PLAYER
#define GENERATION_FREQ 800

#define MOUSE50_FREQ 100
#define MOUSEQ_FREQ 40

#define MAX_SCORE 999

#define BATTLE_LENGTH (3*60) /* seconds */

#define POST_GAME_LENGTH 10000 /* ms */

#define ARROW_DURATION 10 /* seconds */

#define INPUT_QUEUE_SIZE 10

#define MAX_STEP_SIZE 100 /* ms */

#define SCORE_CHANGE_L 800

#endif
