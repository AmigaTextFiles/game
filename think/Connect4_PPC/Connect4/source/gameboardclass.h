#ifndef GAMEBOARDCLASS_H
#define GAMEBOARDCLASS_H

#include "graphics_support.h"
#include <intuition/classes.h>
#include <utility/tagitem.h>
#include <proto/utility.h>
#include <libraries/mui.h>

#ifdef __VBCC__
#define SAVEDS __saveds
#else
#define SAVEDS
#endif

enum {red_player, yellow_player};
enum
{
    MUIA_Gameboard_CurrentPlayer=TAG_USER, MUIA_Gameboard_Inputactive,
    MUIA_Gameboard_Winner, MUIA_Gameboard_Restart, MUIA_Gameboard_Tiegame,
    MUIA_Gameboard_RedPlayer, MUIA_Gameboard_YellowPlayer,
    MUIA_Gameboard_RedDetail, MUIA_Gameboard_YellowDetail,
    MUIM_Gameboard_BeginGame, MUIM_Gameboard_MakeMove
};

/*                   capabilites [ISG]
**
** MUIA_Gameboard_CurrentPlayer  [.SG]
** MUIA_Gameboard_Inputactive    [.S.]
** MUIA_Gameboard_Winner         [.S.]
** MUIA_Gameboard_Restart        [.S.]
** MUIA_Gameboard_Tiegame        [.S.]
** MUIA_Gameboard_RedPlayer      [.SG]
** MUIA_Gameboard_YellowPlayer   [.SG]
** MUIA_Gameboard_RedDetail      [.SG]
** MUIA_Gameboard_YellowDetail   [.SG]
**
** // Methods
** MUIM_Gameboard_MakeMove
**
*/

#define PlayerType_Local    (1<<1)
#define PlayerType_Computer (1<<2)
#define PlayerType_Remote   (1<<3)

struct player
{
    ULONG type;
    ULONG data;  // type dependant contents - see below
};

/*
    PlayerType_Local:       player.data is unused

    PlayerType_Computer:    player.data contains a number specifies the skill level
                            of the computer player

    PlayerType_Remote:      player.data contains a 32 bit IPv4 IP address
*/

#define GAMEBOARD_PENS 512

struct gameboarddata
{
    struct MUI_EventHandlerNode ehnode;

    // Red piece
    UBYTE *red_body;
    ULONG *red_palette;
    struct BitMap *red_bitmap;
    ULONG red_width, red_height;
    ULONG red_depth;

    // Yellow piece
    UBYTE *yellow_body;
    ULONG *yellow_palette;
    struct BitMap *yellow_bitmap;
    ULONG yellow_width, yellow_height;
    ULONG yellow_depth;

    // Mask
    struct BitMap *mask_bitmap;

    // Blank square
    ULONG blank_palette[6];
    struct BitMap *blank_bitmap;
    ULONG blank_width, blank_height;
    ULONG blank_depth;

    struct pen pens[GAMEBOARD_PENS];

    BOOL inputactive;
    BOOL restartgameboard;

    ULONG current_player;    // May be 0 (red) or 1 (yellow)
    int counterx, countery; // Exact window co-ordinates to place piece
    int column, row;        // Column and Row that a piece was placed in

    BYTE filled[7][5];      // 2D array records which holes in the board are filled
                            // NB: -1 denotes an empty hole
    BYTE columntop[7];      // stores a number from 0->4 for each column to say which piece is topmost
                            // NB: -1 denotes a completely empty column i.e. no topmost piece

    BYTE winning_player;    // May be 0 (red) or 1 (yellow)
    BOOL tiegame;

    struct player opponent[2];
};


#ifndef __MORPHOS__
SAVEDS ULONG gameboardDispatcher (REG(a0, struct IClass *cl), REG(a2, Object *obj), REG(a1, Msg msg));
#else
extern struct EmulLibEntry gameboardDispatcher;
#endif

#endif

