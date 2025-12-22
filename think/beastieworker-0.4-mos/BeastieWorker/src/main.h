#define _WIN32_ 0

//--------------------------//
#if _WIN32_

#include <windows.h>
#include <SDL/SDL.h>

#else

#include <SDL.h>

#endif
//--------------------------//

#include <GL/gl.h>
#include <GL/glu.h>
#include <stdlib.h>
#include <stdio.h>

#define _OK_  0
#define _ERR_ 1

#define _PLAYER_QUIETNESS_ 0
#define _PLAYER_STEP_      1
#define _PLAYER_LEFT_      2
#define _PLAYER_RIGHT_     3
#define _PLAYER_PUSH_      4
#define _PLAYER_STATE_     5

#define _LEVEL_FIRST_   0
#define _LEVEL_RESTART_ 1
#define _LEVEL_NEXT_    2
#define _LEVEL_PREV_    3
