/* constants.bas - constants for use with MazezaM.bas
 *
 * Copyright (C) 2002 Malcolm Tyrrell
 * tyrrelmr@cs.tcd.ie
 *
 * This code may be used and distributed under the terms of the GNU General
 * Public Licence.
 */

#define SIZE_OF_PROGRAM 15000

/* default keys as ASCII values
 */
#define UP_KEY 107
#define DOWN_KEY 109
#define LEFT_KEY 122
#define RIGHT_KEY 120
#define RETRY_KEY 114
#define QUIT_KEY 113

/* If the macro DEBUG_KEYS is defined, the following commands are defined:
 * "n" - skip to next level
 * "p" - skip to previous level
 * "l" - sets lives to 99
 */
#define NEXT_KEY 110
#define PREVIOUS_KEY 112
#define EXTRALIVES_KEY 108

/* If the macro BLACK_AND_WHITE is defined, then the mazezam rows will appear
 * white. This allows me to test the program on my black and white palmtop
 * computer.
 */

#ifdef BLACK_AND_WHITE
#define ROW_COLOUR 7
#else
#define ROW_COLOUR i-INT ((i-1)/6)*6
#endif

/* Values for the entrance & exit animations
 */
#define ANIMATION_DELAY 6
#define ENDANIMATION_DELAY 4
#define HURRAY_DELAY 13 

#define GAMEOVER_LOOPDELAY 200
