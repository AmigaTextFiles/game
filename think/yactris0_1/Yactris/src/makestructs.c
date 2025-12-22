/*
    YacTris v0.0
    Copyright ©1993 Jonathan P. Springer

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 1, or (at your option)
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    For more details see the files README and COPYING, which should have
    been included in this distribution.

    The author can be reached during the school year at these E-Mail addresses:

	springjp@screech.alfred.edu	    (Internet)
	springjp@ceramics.bitnet	    (Bitnet)

    And can be reached by paper mail year-round at the following address:

	Jonathan Springer
	360 W. Main St.
	Dallastown, PA	17313-2014
	USA

*/


/*
**
**  MakeStructs.c
**
**  All the MakeStructs for the various pieces.
**
*/

#include "yactris.h"

const struct MakeStruct LineM0[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    1,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  4,-2,   0,0},
    {MOVE,  0,1,    1,-2},
    {DRAW,  0,1,    0,1},
    {PEN,   SHADOW},
    {MOVE,  4,-1,   0,0},
    {DRAW,  4,-1,   1,-1},
    {DRAW,  0,1,    1,-1},
    {MOVE,  4,-2,   0,1},
    {DRAW,  4,-2,   1,-2},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct LineM1[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    4,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  1,-2,   0,0},
    {MOVE,  0,1,    4,-1},
    {DRAW,  0,1,    0,1},
    {PEN,   SHADOW},
    {MOVE,  1,-1,   0,0},
    {DRAW,  1,-1,   4,-1},
    {DRAW,  0,1,    4,-1},
    {MOVE,  1,-2,   0,1},
    {DRAW,  1,-2,   4,-2},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct BlockM[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    2,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  2,-2,   0,0},
    {MOVE,  0,1,    2,-2},
    {DRAW,  0,1,    0,1},
    {PEN,   SHADOW},
    {MOVE,  2,-1,   0,0},
    {DRAW,  2,-1,   2,-1},
    {DRAW,  0,1,    2,-1},
    {MOVE,  2,-2,   0,1},
    {DRAW,  2,-2,   2,-2},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct TeeM0[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    2,-1},
    {DRAW,  0,0,    1,0},
    {DRAW,  1,0,    1,0},
    {DRAW,  1,0,    0,0},
    {DRAW,  2,-2,   0,0},
    {MOVE,  0,1,    2,-2},
    {DRAW,  0,1,    1,1},
    {MOVE,  1,1,    1,0},
    {DRAW,  1,1,    0,1},
    {MOVE,  2,-1,   1,0},
    {DRAW,  3,-2,   1,0},
    {PEN,   SHADOW},
    {MOVE,  0,1,    2,-1},
    {DRAW,  3,-1,   2,-1},
    {DRAW,  3,-1,   1,0},
    {MOVE,  3,-2,   1,1},
    {DRAW,  3,-2,   2,-2},
    {MOVE,  2,-1,   0,0},
    {DRAW,  2,-1,   1,-1},
    {MOVE,  2,-2,   1,0},
    {DRAW,  2,-2,   0,1},
    {PEN,   FILL},
    {FLOOD, 1,4,    0,4},
    {STOP}
};

const struct MakeStruct TeeM1[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    3,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  1,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    3,-2},
    {MOVE,  1,-1,   1,0},
    {DRAW,  2,-2,   1,0},
    {PEN,   SHADOW},
    {MOVE,  0,1,    3,-1},
    {DRAW,  1,-1,   3,-1},
    {DRAW,  1,-1,   2,-1},
    {DRAW,  2,-1,   2,-1},
    {DRAW,  2,-1,   1,0},
    {MOVE,  2,-2,   1,1},
    {DRAW,  2,-2,   2,-2},
    {MOVE,  1,-2,   2,-1},
    {DRAW,  1,-2,   3,-2},
    {MOVE,  1,-1,   0,0},
    {DRAW,  1,-1,   1,-1},
    {MOVE,  1,-2,   0,1},
    {DRAW,  1,-2,   1,0},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct TeeM2[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    1,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  3,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    1,-1},
    {MOVE,  1,0,    1,0},
    {DRAW,  1,0,    2,-1},
    {MOVE,  1,1,    2,-2},
    {DRAW,  1,1,    1,-1},
    {PEN,   SHADOW},
    {MOVE,  1,1,    2,-1},
    {DRAW,  2,-1,   2,-1},
    {DRAW,  2,-1,   1,-1},
    {DRAW,  3,-1,   1,-1},
    {DRAW,  3,-1,   0,0},
    {MOVE,  3,-2,   0,1},
    {DRAW,  3,-2,   1,-2},
    {MOVE,  2,-2,   1,-1},
    {DRAW,  2,-2,   2,-2},
    {MOVE,  0,1,    1,-1},
    {DRAW,  1,0,    1,-1},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct TeeM3[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    2,-1},
    {DRAW,  0,0,    1,0},
    {DRAW,  1,0,    1,0},
    {DRAW,  1,0,    0,0},
    {DRAW,  2,-2,   0,0},
    {MOVE,  1,1,    0,1},
    {DRAW,  1,1,    1,0},
    {MOVE,  0,1,    1,1},
    {DRAW,  0,1,    2,-2},
    {MOVE,  1,0,    2,0},
    {DRAW,  1,0,    3,-1},
    {MOVE,  1,1,    2,-1},
    {DRAW,  1,1,    3,-2},
    {PEN,   SHADOW},
    {MOVE,  1,1,    3,-1},
    {DRAW,  2,-1,   3,-1},
    {DRAW,  2,-1,   0,0},
    {MOVE,  2,-2,   0,1},
    {DRAW,  2,-2,   3,-2},
    {MOVE,  0,1,    2,-1},
    {DRAW,  1,0,    2,-1},
    {PEN,   FILL},
    {FLOOD, 1,4,    0,4},
    {STOP}
};

const struct MakeStruct ZigM0[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    1,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  2,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    1,-2},
    {MOVE,  1,0,    1,0},
    {DRAW,  1,0,    2,-1},
    {MOVE,  1,1,    1,-1},
    {DRAW,  1,1,    2,-2},
    {MOVE,  2,-1,   1,0},
    {DRAW,  3,-1,   1,0},
    {PEN,   SHADOW},
    {MOVE,  1,0,    2,-1},
    {DRAW,  3,-1,   2,-1},
    {DRAW,  3,-1,   1,0},
    {MOVE,  3,-2,   1,1},
    {DRAW,  3,-2,   2,-2},
    {MOVE,  2,-1,   0,0},
    {DRAW,  2,-1,   1,-2},
    {MOVE,  2,-2,   0,1},
    {DRAW,  2,-2,   1,0},
    {MOVE,  0,1,    1,-1},
    {DRAW,  1,0,    1,-1},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct ZigM1[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    3,-1},
    {DRAW,  0,0,    1,0},
    {DRAW,  1,0,    1,0},
    {DRAW,  1,0,    0,0},
    {DRAW,  2,-2,   0,0},
    {MOVE,  0,1,    1,1},
    {DRAW,  0,1,    3,-2},
    {MOVE,  1,1,    0,1},
    {DRAW,  1,1,    1,1},
    {PEN,   SHADOW},
    {MOVE,  0,1,    3,-1},
    {DRAW,  1,-1,   3,-1},
    {DRAW,  1,-1,   2,-1},
    {DRAW,  2,-1,   2,-1},
    {DRAW,  2,-1,   0,0},
    {MOVE,  2,-2,   0,1},
    {DRAW,  2,-2,   2,-2},
    {MOVE,  1,-2,   2,-1},
    {DRAW,  1,-2,   3,-2},
    {PEN,   FILL},
    {FLOOD, 1,4,    0,4},
    {STOP}
};

const struct MakeStruct ZagM0[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    2,-1},
    {DRAW,  0,0,    1,0},
    {DRAW,  1,0,    1,0},
    {DRAW,  1,0,    0,0},
    {DRAW,  3,-2,   0,0},
    {MOVE,  0,1,    1,1},
    {DRAW,  0,1,    2,-2},
    {MOVE,  1,1,    0,1},
    {DRAW,  1,1,    1,0},
    {PEN,   SHADOW},
    {MOVE,  3,-1,   0,0},
    {DRAW,  3,-1,   1,-1},
    {DRAW,  2,-1,   1,-1},
    {DRAW,  2,-1,   2,-1},
    {DRAW,  0,1,    2,-1},
    {MOVE,  3,-2,   0,1},
    {DRAW,  3,-2,   1,-2},
    {MOVE,  2,-2,   1,-1},
    {DRAW,  2,-2,   2,-2},
    {PEN,   FILL},
    {FLOOD, 1,4,    0,4},
    {STOP}
};

const struct MakeStruct ZagM1[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    2,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  1,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    2,-2},
    {MOVE,  1,0,    2,0},
    {DRAW,  1,0,    3,-1},
    {MOVE,  1,1,    2,-1},
    {DRAW,  1,1,    3,-2},
    {MOVE,  1,-1,   1,0},
    {DRAW,  2,-2,   1,0},
    {PEN,   SHADOW},
    {MOVE,  2,-1,   1,0},
    {DRAW,  2,-1,   3,-1},
    {DRAW,  1,1,    3,-1},
    {MOVE,  2,-2,   1,1},
    {DRAW,  2,-2,   3,-2},
    {MOVE,  1,-1,   0,0},
    {DRAW,  1,-1,   1,-1},
    {MOVE,  1,-2,   0,1},
    {DRAW,  1,-2,   1,0},
    {MOVE,  0,1,    2,-1},
    {DRAW,  1,0,    2,-1},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct EllM0[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    2,-1},
    {DRAW,  0,0,    1,0},
    {DRAW,  2,0,    1,0},
    {DRAW,  2,0,    0,0},
    {DRAW,  3,-2,   0,0},
    {MOVE,  0,1,    1,1},
    {DRAW,  0,1,    2,-2},
    {MOVE,  2,1,    0,1},
    {DRAW,  2,1,    1,0},
    {PEN,   SHADOW},
    {MOVE,  0,1,    2,-1},
    {DRAW,  3,-1,   2,-1},
    {DRAW,  3,-1,   0,0},
    {MOVE,  3,-2,   0,1},
    {DRAW,  3,-2,   2,-2},
    {PEN,   FILL},
    {FLOOD, 0,4,    1,4},
    {STOP}
};

const struct MakeStruct EllM1[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    3,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  1,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    3,-2},
    {MOVE,  1,-1,   2,0},
    {DRAW,  2,-2,   2,0},
    {PEN,   SHADOW},
    {MOVE,  0,1,    3,-1},
    {DRAW,  2,-1,   3,-1},
    {DRAW,  2,-1,   2,0},
    {MOVE,  2,-2,   2,1},
    {DRAW,  2,-2,   3,-2},
    {MOVE,  1,-1,   0,0},
    {DRAW,  1,-1,   2,-1},
    {MOVE,  1,-2,   0,1},
    {DRAW,  1,-2,   2,0},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct EllM2[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    2,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  3,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    2,-2},
    {PEN,   SHADOW},
    {MOVE,  0,1,    2,-1},
    {DRAW,  1,-1,   2,-1},
    {DRAW,  1,-1,   1,-1},
    {DRAW,  3,-1,   1,-1},
    {DRAW,  3,-1,   0,0},
    {MOVE,  3,-2,   0,1},
    {DRAW,  3,-2,   1,-2},
    {MOVE,  1,-2,   1,-1},
    {DRAW,  1,-2,   2,-2},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct EllM3[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    1,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  2,-1,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    1,-2},
    {MOVE,  1,0,    1,0},
    {DRAW,  1,0,    3,-1},
    {MOVE,  1,1,    1,-1},
    {DRAW,  1,1,    3,-2},
    {PEN,   SHADOW},
    {MOVE,  1,1,    3,-1},
    {DRAW,  2,-1,   3,-1},
    {DRAW,  2,-1,   0,0},
    {MOVE,  2,-2,   0,1},
    {DRAW,  2,-2,   3,-2},
    {MOVE,  0,1,    1,-1},
    {DRAW,  1,0,    1,-1},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct LeeM0[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    2,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  1,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    2,-1},
    {MOVE,  1,-1,   1,0},
    {DRAW,  3,-2,   1,0},
    {PEN,   SHADOW},
    {MOVE,  0,1,    2,-1},
    {DRAW,  3,-1,   2,-1},
    {DRAW,  3,-1,   1,0},
    {MOVE,  3,-2,   1,1},
    {DRAW,  3,-2,   2,-2},
    {MOVE,  1,-1,   0,0},
    {DRAW,  1,-1,   1,-1},
    {MOVE,  1,-2,   0,1},
    {DRAW,  1,-2,   1,0},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct LeeM1[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    3,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  2,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    3,-2},
    {PEN,   SHADOW},
    {MOVE,  0,1,    3,-1},
    {DRAW,  1,-1,   3,-1},
    {DRAW,  1,-1,   1,-1},
    {DRAW,  2,-1,   1,-1},
    {DRAW,  2,-1,   0,0},
    {MOVE,  2,-2,   0,1},
    {DRAW,  2,-2,   1,-2},
    {MOVE,  1,-2,   1,-1},
    {DRAW,  1,-2,   3,-2},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct LeeM2[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    1,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  3,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    1,-2},
    {MOVE,  2,0,    1,0},
    {DRAW,  2,0,    2,-1},
    {MOVE,  2,1,    1,-1},
    {DRAW,  2,1,    2,-2},
    {PEN,   SHADOW},
    {MOVE,  2,1,    2,-1},
    {DRAW,  3,-1,   2,-1},
    {DRAW,  3,-1,   0,0},
    {MOVE,  3,-2,   0,1},
    {DRAW,  3,-2,   2,-2},
    {MOVE,  0,1,    1,-1},
    {DRAW,  2,0,    1,-1},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};

const struct MakeStruct LeeM3[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    3,-1},
    {DRAW,  0,0,    2,0},
    {DRAW,  1,0,    2,0},
    {DRAW,  1,0,    0,0},
    {DRAW,  2,-2,   0,0},
    {MOVE,  1,1,    0,1},
    {DRAW,  1,1,    2,0},
    {MOVE,  0,1,    2,1},
    {DRAW,  0,1,    3,-2},
    {PEN,   SHADOW},
    {MOVE,  0,1,    3,-1},
    {DRAW,  2,-1,   3,-1},
    {DRAW,  2,-1,   0,0},
    {MOVE,  2,-2,   0,1},
    {DRAW,  2,-2,   3,-2},
    {PEN,   FILL},
    {FLOOD, 1,4,    0,4},
    {STOP}
};

const struct MakeStruct Sq[] = {
    {PEN,   SHINE},
    {MOVE,  0,0,    1,-1},
    {DRAW,  0,0,    0,0},
    {DRAW,  1,-2,   0,0},
    {MOVE,  0,1,    0,1},
    {DRAW,  0,1,    1,-2},
    {PEN,   SHADOW},
    {MOVE,  1,-1,   0,0},
    {DRAW,  1,-1,   1,-1},
    {DRAW,  0,1,    1,-1},
    {MOVE,  1,-2,   0,1},
    {DRAW,  1,-2,   1,-2},
    {PEN,   FILL},
    {FLOOD, 0,4,    0,4},
    {STOP}
};
