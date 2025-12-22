// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #ifndef __USE_INLINE__
        #define __USE_INLINE__ // define this as early as possible
    #endif
#endif
#ifdef __LCLINT__
    typedef char* STRPTR;
    typedef char* CONST_STRPTR;
    typedef char  TEXT;
    #define ASM
    #define REG(x)
    #define __inline
#endif

#include <exec/types.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <intuition/intuition.h>
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>

#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <clib/alib_protos.h>

#include <ctype.h>
#include <stdio.h>             // FILE, printf()
#include <stdlib.h>            // EXIT_SUCCESS, EXIT_FAILURE
#include <string.h>
#include <assert.h>

#ifdef LATTICE
    #include <dos.h>           // geta4()
#endif

#include "mce.h"

// 2. DEFINES ------------------------------------------------------------

// main window
#define GID_LOR_LY1     0 // root layout
#define GID_LOR_SB1     1 // toolbar
#define GID_LOR_BU1     2 //   1st board square
#define GID_LOR_BU121 122 // 121st board square
#define GID_LOR_BU122 123 // clear board
#define GID_LOR_BU123 124 // reset board
#define GID_LOR_CH1   125 // type
#define GID_LOR_CB1   126 // animations
#define GID_LOR_CB2   127 // sound effects
#define GIDS_LOR      GID_LOR_CB2

#define BoardSquare(x, y) \
LAYOUT_AddChild, gadgets[GID_LOR_BU1 + (y * 11) + x] = (struct Gadget*) \
ZButtonObject,                                       \
    GA_ID,               GID_LOR_BU1 + (y * 11) + x, \
    GA_RelVerify,        TRUE,                       \
    GA_Text,             " ",                        \
    BUTTON_PushButton,   TRUE,                       \
    BUTTON_DomainString, "#",                        \
ButtonEnd

#define BoardRow(y)     \
AddHLayout,             \
    BoardSquare( 0, y), \
    BoardSquare( 1, y), \
    BoardSquare( 2, y), \
    BoardSquare( 3, y), \
    BoardSquare( 4, y), \
    BoardSquare( 5, y), \
    BoardSquare( 6, y), \
    BoardSquare( 7, y), \
    BoardSquare( 8, y), \
    BoardSquare( 9, y), \
    BoardSquare(10, y), \
LayoutEnd

#define IEQUALIFIER_SHIFT (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT)

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void drawboard(void);
MODULE void move_piece(int destx, int desty);
MODULE void resetboard(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SexList,
                            SpeedBarList;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Library*      TickBoxBase;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE TEXT                 boardtext[11][11][1 + 1];
MODULE UBYTE                ordinal;
MODULE UWORD                board[11][11];
MODULE ULONG                anims,
                            sound;
MODULE int                  sel_x = -1,
                            sel_y = -1;
MODULE struct List          PiecesList;

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE const STRPTR PieceOptions[16] = {
"Odin"      , // $0280
"Einherjar" , // $0240
"Vidar"     , // $0220
"Tyr"       , // $0210
"Heimdall"  , // $0208
"Thor"      , // $0204
"Valkries"  , // $0202
"Frey"      , // $0201
"Giant"     , // $0140
"Hyrm"      , // $0120
"Garm"      , // $0110
"Surt"      , // $0108
"Surmangand", // $0104
"Fenrir"    , // $0102
"Loki"      , // $0101
"None"        // $0000
// no NULL is needed
};

MODULE const UWORD ordinal_to_board[16] = {
0x0280, //  0 Odin
0x0240, //  1 Einherjar
0x0220, //  2 Vidar
0x0210, //  3 Tyr
0x0208, //  4 Heimdall
0x0204, //  5 Thor
0x0202, //  6 Valkries
0x0201, //  7 Frey
0x0140, //  8 Giant
0x0120, //  9 Hyrm
0x0110, // 10 Garm
0x0108, // 11 Surt
0x0104, // 12 Surmangand
0x0102, // 13 Fenrir
0x0101, // 14 Loki
0x0000  // 15 None
};

// 8. CODE ---------------------------------------------------------------

EXPORT void lor_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // lor_preinit()
        NewList(&PiecesList);
    }

    tool_open  = lor_open;
    tool_loop  = lor_loop;
    tool_save  = lor_save;
    tool_close = lor_close;
    tool_exit  = lor_exit;

    if (loaded != FUNC_RAGNAROK && !lor_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_RAGNAROK;

    ch_load_images(532, 547, PieceOptions, &PiecesList);
    make_speedbar_list(GID_LOR_SB1);
    load_aiss_images( 9,  9);
    load_aiss_images(17, 17);

    lor_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);

    lockscreen();
    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                 TRUE,
        WA_ThinSizeGadget,                             TRUE,
        WINDOW_Position,                               WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                            gadgets[GID_LOR_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                         TRUE,
            LAYOUT_DeferLayout,                        TRUE,
            AddToolbar(GID_LOR_SB1),
            AddHLayout,
                LAYOUT_AddChild,                       gadgets[GID_LOR_CB1] = (struct Gadget*)
                TickOrCheckBoxObject,
                    GA_ID,                             GID_LOR_CB1,
                    GA_Text,                           "Conflict animations?",
                End,
                LAYOUT_AddChild,                       gadgets[GID_LOR_CB2] = (struct Gadget*)
                TickOrCheckBoxObject,
                    GA_ID,                             GID_LOR_CB2,
                    GA_Text,                           "Sound effects?",
                End,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddVLayout,
                LAYOUT_BevelStyle,                     BVS_GROUP,
                LAYOUT_SpaceOuter,                     TRUE,
                LAYOUT_Label,                          "Board",
                BoardRow( 0),
                BoardRow( 1),
                BoardRow( 2),
                BoardRow( 3),
                BoardRow( 4),
                BoardRow( 5),
                BoardRow( 6),
                BoardRow( 7),
                BoardRow( 8),
                BoardRow( 9),
                BoardRow(10),
            LayoutEnd,
            LAYOUT_AddChild,                           gadgets[GID_LOR_CH1] = (struct Gadget*)
            PopUpObject,
                GA_ID,                                 GID_LOR_CH1,
                CHOOSER_Labels,                        &PiecesList,
                CHOOSER_Selected,                      (WORD) ordinal,
                CHOOSER_MaxLabels,                     16,
            PopUpEnd,
            Label("Selected Piece:"),
            CHILD_WeightedHeight,                      0,
            AddHLayout,
                AddSpace,
                AddLabel("Use the cursor keys to move the selected piece."),
                CHILD_WeightedWidth,                   0,
                AddSpace,
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
            AddHLayout,
                ClearButton(GID_LOR_BU122, "Clear Board"),
                ResetButton(GID_LOR_BU123, "Reset Board"),
            LayoutEnd,
            CHILD_WeightedHeight,                      0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_LOR_SB1);
    writegadgets();
    loop();
    readgadgets();
    closewindow();
}

EXPORT void lor_loop(ULONG gid, UNUSED ULONG code)
{   TRANSIENT       int   x, y;
    PERSIST   const UWORD ord_to_val[] = {
0x0280, //  0 Odin
0x0240, //  1 Einherjar
0x0220, //  2 Vidar
0x0210, //  3 Tyr
0x0208, //  4 Heimdall
0x0204, //  5 Thor
0x0202, //  6 Valkries
0x0201, //  7 Frey
0x0140, //  8 Giant
0x0120, //  9 Hyrm
0x0110, // 10 Garm
0x0108, // 11 Surt
0x0104, // 12 Surmangand
0x0102, // 13 Fenrir
0x0101, // 14 Loki
0x0000  // 15 None
};

    switch (gid)
    {
    case GID_LOR_CH1:
        if (sel_x != -1)
        {   // assert(sel_y != -1;
            board[sel_y][sel_x] = ord_to_val[code];
            drawboard();
        }
    acase GID_LOR_BU122:
        for (x = 0; x < 11; x++)
        {   for (y = 0; y < 11; y++)
            {   board[y][x] = 0;
        }   }
        writegadgets();
    acase GID_LOR_BU123:
        resetboard();
        writegadgets();
    adefault:
        if (gid >= GID_LOR_BU1 && gid <= GID_LOR_BU121)
        {   if (sel_x != -1)
            {   // assert(sel_y != -1);
                SetGadgetAttrs
                (   gadgets[GID_LOR_BU1 + sel_x + (sel_y * 11)], MainWindowPtr, NULL,
                    GA_Selected, FALSE,
                TAG_DONE); // this autorefreshes
            }

            sel_x = (gid - GID_LOR_BU1) % 11;
            sel_y = (gid - GID_LOR_BU1) / 11;
            writegadgets();
}   }   }

EXPORT FLAG lor_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        serialize();
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_RAGNAROK
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   int i;

    if (gadmode == SERIALIZE_WRITE)
    {   drawboard();

        if (sel_x == -1)
        {   ordinal = 15;
        } else
        {   for (i = 0; i < 16; i++)
            {   if (board[sel_y][sel_x] == ordinal_to_board[i])
                {   ordinal = i;
                    break; // for speed
        }   }   }

        DISCARD SetGadgetAttrs
        (   gadgets[GID_LOR_CH1], MainWindowPtr, NULL,
            CHOOSER_Selected, ordinal,
        TAG_DONE); // we must explicitly refresh
        RefreshGadgets((struct Gadget*) gadgets[GID_LOR_CH1], MainWindowPtr, NULL);
    }

    either_cb(GID_LOR_CB1, &anims);
    either_cb(GID_LOR_CB2, &sound);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int x, y;

    offset = 4;
    for (y = 0; y < 11; y++)
    {   for (x = 0; x < 11; x++)
        {   serialize2uword(&board[y][x]);
        }
        offset += 10;
    }

    offset = 0x406;
    anims = anims ? 0x00  : 0x01;
    serialize1(&anims); // $406
    anims = anims ? FALSE : TRUE;
    sound = sound ? 0x00  : 0x01;
    serialize1(&sound); // $407
    sound = sound ? FALSE : TRUE;
}

EXPORT void lor_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    gamesave("#?.save", "Legend of Ragnarok", saveas, 5120, FLAG_S, FALSE);
}

MODULE void drawboard(void)
{   int x, y;

    for (y = 0; y < 11; y++)
    {   for (x = 0; x < 11; x++)
        {   switch (board[y][x])
            {
            case  0x280:             boardtext[x][y][0] = 'O'; // white Odin
            acase 0x240:             boardtext[x][y][0] = 'E'; // white Einherjar
            acase 0x140:             boardtext[x][y][0] = 'G'; //                   black Giant
            acase 0x120: case 0x220: boardtext[x][y][0] = '1'; // white Vidar    or black Hyrm
            acase 0x110: case 0x210: boardtext[x][y][0] = '2'; // white Tyr      or black Garm
            acase 0x108: case 0x208: boardtext[x][y][0] = '3'; // white Heimdall or black Surt
            acase 0x104: case 0x204: boardtext[x][y][0] = '4'; // white Thor     or black Surmangand
            acase 0x102: case 0x202: boardtext[x][y][0] = '5'; // white Valkries or black Fenrir
            acase 0x101: case 0x201: boardtext[x][y][0] = '6'; // white Frey     or black Loki
            adefault:                boardtext[x][y][0] = ' '; // empty
            }
            boardtext[x][y][1] = EOS;
            DISCARD SetGadgetAttrs
            (   gadgets[GID_LOR_BU1 + (y * 11) + x], MainWindowPtr, NULL,
                GA_Text,              boardtext[x][y],
                GA_Selected,          (sel_x == x && sel_y == y) ? TRUE : FALSE,
                BUTTON_BackgroundPen, pens[(board[y][x] & 0xFF00) >> 8],
                BUTTON_TextPen,       pens[3],
            TAG_DONE); // this autorefreshes
}   }   }

EXPORT void lor_getpens(void)
{   lockscreen();

    pens[0] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x77777777, 0x88888888, 0x99999999, -1); // grey
    pens[1] = FindColor(ScreenPtr->ViewPort.ColorMap, 0x44444444, 0x33333333, 0x00000000, -1); // green
    pens[2] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xBBBBBBBB, 0x66666666, 0x00000000, -1); // yellow
    pens[3] = FindColor(ScreenPtr->ViewPort.ColorMap, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, -1); // white
    unlockscreen();
}

EXPORT void lor_uniconify(void)
{   lor_getpens();
}

MODULE void move_piece(int destx, int desty)
{   if (board[sel_y][sel_x] != 0x0000 && board[desty][destx] == 0x0000)
    {   board[desty][destx] = board[sel_y][sel_x];
        board[sel_y][sel_x] = 0x0000;
    }
    sel_x = destx;
    sel_y = desty;
    writegadgets();
}

EXPORT void lor_key(UBYTE scancode, UWORD qual)
{   if (sel_x == -1)
    {   return;
    }
    // assert(sel_x != -1);

    switch (scancode)
    {
    case SCAN_BACKSPACE:
    case SCAN_DEL:
    case SCAN_SPACEBAR:
        board[sel_y][sel_x] = 0;
        writegadgets();
    acase SCAN_MI:
        if (ordinal ==  0) ordinal = 15; else ordinal--;
        board[sel_y][sel_x] = ordinal_to_board[ordinal];
        writegadgets();
    acase SCAN_PL:
        if (ordinal == 15) ordinal =  0; else ordinal++;
        board[sel_y][sel_x] = ordinal_to_board[ordinal];
        writegadgets();
    acase SCAN_LEFT:
    case SCAN_N4:
        if (sel_x > 0)
        {   if (qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))
            {   move_piece(0, sel_y);
            } else
            {   move_piece(sel_x - 1, sel_y);
        }   }
    acase SCAN_RIGHT:
    case SCAN_N6:
        if (sel_x < 10)
        {   if (qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))
            {   move_piece(10 - 1, sel_y);
            } else
            {   move_piece(sel_x + 1, sel_y);
        }   }
    acase SCAN_UP:
    case SCAN_N8:
    case NM_WHEEL_UP:
        if (sel_y > 0)
        {   if (qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))
            {   move_piece(sel_x, 0);
            } else
            {   move_piece(sel_x, sel_y - 1);
        }   }
    acase SCAN_DOWN:
    case SCAN_N5:
    case SCAN_N2:
    case NM_WHEEL_DOWN:
        if (sel_y < 10)
        {   if (qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))
            {   move_piece(sel_x, 10 - 1);
            } else
            {   move_piece(sel_x, sel_y + 1);
        }   }
    acase SCAN_N1:
        move_piece
        (   (sel_x >  0 && !(qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))) ? (sel_x - 1) :  0,
            (sel_y < 10 && !(qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))) ? (sel_y + 1) : 10
        );
    acase SCAN_N3:
        move_piece
        (   (sel_x < 10 && !(qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))) ? (sel_x + 1) : 10,
            (sel_y < 10 && !(qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))) ? (sel_y + 1) : 10
        );
    acase SCAN_N7:
        move_piece
        (   (sel_x >  0 && !(qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))) ? (sel_x - 1) :  0,
            (sel_y >  0 && !(qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))) ? (sel_y - 1) :  0
        );
    acase SCAN_N9:
        move_piece
        (   (sel_x < 10 && !(qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))) ? (sel_x + 1) : 10,
            (sel_y >  0 && !(qual & (IEQUALIFIER_SHIFT | IEQUALIFIER_CONTROL))) ? (sel_y - 1) :  0
        );
}   }

EXPORT void lor_exit(void)
{   ch_clearlist(&PiecesList);
}

EXPORT void lor_close(void) { ; }

MODULE void resetboard(void)
{   int   i,
          x, y;
    UWORD piece;

    for (x = 0; x < 11; x++)
    {   for (y = 0; y < 11; y++)
        {   board[y][x] = 0;
    }   }

    serializemode = SERIALIZE_READ;
    offset = 0x10B7;

    for (i = 0; i < 37; i++)
    {   serialize1((ULONG*) &x); // $10B7
        offset++;                // $10B8
        serialize1((ULONG*) &y); // $10B9
        serialize2uword(&piece); // $10BA..$10BB
        board[y][x] = piece;
        offset++;                // $10BC
    }

    writegadgets();
}
