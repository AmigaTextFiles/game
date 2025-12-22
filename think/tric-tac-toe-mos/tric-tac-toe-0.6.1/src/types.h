/* 
 * Copyright (C) 2009  Sean McKean
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef TYPES_H
#define TYPES_H

/* structs */

typedef struct Coord_t
{
    int x;
    int y;
} Coord_t;

typedef struct Connect_t
{
    Coord_t *centers[3];
    Coord_t core;
} Connect_t;

typedef struct ComputerCell_t
{
    /* Cell value */
    int value;
    /* Does this node block another player's point? */
    int block;
    /* Does this node seize a point for the computer? */
    int seize;
    /* Does this cell possibly block a future point? */
    int might_block;
    /* Does this cell possibly seize a future point? */
    int might_seize;
    /* Does it align with an opponent's cell on same side? */
    int along_block;
    /* Does it align with player's cell on same side? */
    int along_seize;
    /* total is either (block + seize), or (might_block + might_seize) */
    int total;
} ComputerCell_t;

/* enums */

typedef enum
{
    SAMPLE_CLICK,
    SAMPLE_KCILC,
    SAMPLE_BLIP,
    SAMPLE_BLOOP,
    SAMPLE_CHEER,
    SAMPLE_BOO
} SampleName;

typedef enum
{
    INDEX,
    OFFSET,
    PANNING
} SampleData;

typedef enum
{
    FACE_NONE = -1,
    FACE_RIGHT,
    FACE_LEFT,
    FACE_TOP
} FaceValue;

typedef enum
{
    PAN_NORMAL = -1,
    PAN_TOP,
    PAN_LEFT,
    PAN_RIGHT
} PanSetting;

typedef enum
{
    BLACK = 0,
    RED = 65,
    GREEN,
    BLUE,
    CYAN,
    MAGENTA,
    YELLOW,
    DARK_RED,
    DARK_GREEN,
    DARK_BLUE,
    DARK_CYAN,
    DARK_MAGENTA,
    DARK_YELLOW,
    CUSTOM,
    DARK_GREY = 251,
    MED_GREY = 252,
    GREY = 253,
    LIGHT_GREY = 254,
    WHITE = 255
} PaletteEntry;

typedef enum
{
    HR_NAME = 0,

    HR_RED,
    HR_GREEN,
    HR_BLUE,
    HR_CYAN,
    HR_MAGENTA,
    HR_YELLOW,

    HR_HUMAN,
    HR_CPU_M,
    HR_CPU_H
} MenuHitRect;

typedef enum
{
    BTN_BACKGROUND,
    BTN_TEXT,
    BTN_BORDER,
    MAX_ELEMENTS
} GUIElement;

typedef enum
{
    HUMAN,
    CPU_MED,
    CPU_HARD
} PlayerType;

#endif  /* TYPES_H */
