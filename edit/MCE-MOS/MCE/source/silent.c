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
#include <datatypes/datatypesclass.h>
#include <datatypes/pictureclass.h>
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>

#include <proto/datatypes.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <clib/alib_protos.h>

#include <ctype.h>
#include <stdio.h>                           /* FILE, printf() */
#include <stdlib.h>                          /* EXIT_SUCCESS, EXIT_FAILURE */
#include <string.h>
#include <assert.h>

#ifdef LATTICE
    #include <dos.h>                         // geta4()
#endif

#include "mce.h"

// 2. DEFINES ------------------------------------------------------------

// main window
#define GID_SS_LY1  0 // root layout
#define GID_SS_SB1  1 // toolbar
#define GID_SS_BU1  2 // clear level
#define GID_SS_BU2  3 // edit graphics
#define GID_SS_SP1  4 // map
#define GID_SS_SP2  5 // tiles
#define GID_SS_SC1  6 // map   horizontal scroller
#define GID_SS_SC2  7 // map   vertical   scroller
#define GID_SS_SC3  8 // tiles horizontal scroller
#define GID_SS_LY3  9 // map
#define GID_SS_LY4 10 // tiles
#define GID_SS_CH1 11 // game
#define GID_SS_CH2 12 // colour

// graphics editor
#define GID_SS_SK1 13 // editor
#define GID_SS_PL1 14 // colour
#define GID_SS_SB2 15 // command bar
#define GID_SS_SB3 16 // paint bar
#define GID_SS_BU3 17 // OK
#define GID_SS_BU4 18 // cancel

#define GIDS_SS    GID_SS_BU4

// DISPLAY1WIDTH/DISPLAY1HEIGHT/DISPLAY1SIZE will need to increase if you increase these
#define MAXWIDENESS   (16 * 64)
#define MAXTALLNESS   (16 * 64)
#define MINWIDENESS   ( 8 * 64)
#define MINTALLNESS   ( 4 * 64)

#define COMMAND_CUT          0
#define COMMAND_COPY         1
#define COMMAND_PASTE        2
#define COMMAND_ERASE        3
#define COMMAND_UNDO         4
#define COMMAND_REDO         5
#define COMMANDNODES         6 // 0.. 5

#define PAINT_FREEHANDDOT    0
#define PAINT_FREEHANDLINE   1
#define PAINT_LINE           2
#define PAINT_RECT           3
#define PAINT_FILLEDRECT     4
#define PAINT_ELLIPSE        5
#define PAINT_FILLEDELLIPSE  6
#define PAINT_FLOODFILL      7
#define PAINT_SELECTCOLOUR   8
#ifdef __amigaos4__
#define PAINT_GRID           9
#define PAINTNODES          10 // 0..10
#else
#define PAINT_MARK           9
#define PAINT_MOVE          10
#define PAINT_GRID          11
#define PAINTNODES          12 // 0..11
#endif

#define NUMTILES            50 // 45 for Turbo, 50 for Firepower

#define BROWN                0
#define GREEN                1
#define GREY                 2

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void ss_updatetiles(void);
MODULE void ss_drawmappart(int x, int y);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(None)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT FLAG                 crosshair;
IMPORT int                  bu3, bu4, pl1, sb2, sb3, sk1,
                            function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            tilewidth,
                            tileheight;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT ULONG                fgpen_intable,
                            fgpen_real,
                            game,
                            offset,
                            redoable,
                            showgrid,
                            showtoolbar,
                            undoable;
IMPORT UBYTE                convert[256],
                            IOBuffer[IOBUFFERSIZE],
                            stamp,
                            TileData[NUMTILES][64][64], // [tiles][height][width]
                            tileplanes[256];
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Window       *MainWindowPtr,
                           *GfxWindowPtr;
IMPORT Object*              WinObject;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT UBYTE               *byteptr1[DISPLAY1HEIGHT],
                           *byteptr2[DISPLAY2HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE],
                            display2[DISPLAY2SIZE];
IMPORT struct Library*      SketchBoardBase;

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE FLAG                 gotallpens         = FALSE,
                            gotpen[32],
                            lmb;
MODULE TEXT                 Gfx_Pathname[MAX_PATH + 1];
MODULE ULONG                gfxsize,
                            stampmode          = BROWN;
MODULE int                  numtiles,
                            scrollx            = 0,
                            scrolly            = 0,
                            tallness           = MINTALLNESS,
                            tilex              = 0,
                            wideness           = MINWIDENESS;
MODULE UBYTE*               Gfx_Buffer         = NULL;

MODULE const STRPTR ColourOptions[2 + 1] =
{ "Brown",
  "Green",
  NULL
}, GameOptions[2 + 1] =
{ "Firepower",
  "Turbo",
  NULL
};

// 7. MODULE STRUCTURES --------------------------------------------------

PERSIST const struct
{   const SBYTE filetovar;
    const UBYTE colour;
} tileinfo[92 + 1] = {
{  0, GREY  }, //  0 dirt
{  1, GREY  }, //  1 dirt
{  2, GREY  }, //  2 tree
{  3, GREY  }, //  3 tree
{  4, GREY  }, //  4 tree
{  5, GREY  }, //  5 road
{  6, GREY  }, //  6 road
{  7, GREY  }, //  7 road
{  8, GREY  }, //  8 road
{ -1, GREY  }, //  9 4-way fort
{ 10, GREY  }, // 10 road
{ 11, GREY  }, // 11 road
{ 12, GREY  }, // 12 road
{ 13, GREY  }, // 13 road
{ 14, GREY  }, // 14 helipad
{ 15, GREY  }, // 15 road
{ 16, GREY  }, // 16 road
{ 17, BROWN }, // 17 officer building
{ 18, BROWN }, // 18 utility building
{ 19, BROWN }, // 19 prison
{ 20, BROWN }, // 20 garage
{ -1, GREY  }, // 21
{ 23, BROWN }, // 22 brownhouse
{ -1, GREY  }, // 23
{ 25, BROWN }, // 24 medic building
{ 27, BROWN }, // 25 fuel depot
{ -1, GREY  }, // 26
{ 29, BROWN }, // 27 standalone fort
{ -1, GREY  }, // 28
{ 17, GREEN }, // 29 officer building
{ 18, GREEN }, // 30 utility building
{ 19, GREEN }, // 31 prison
{ 21, GREEN }, // 32 garage
{ -1, GREY  }, // 33
{ 23, GREEN }, // 34 greenhouse
{ -1, GREY  }, // 35
{ 25, GREEN }, // 36 medic building
{ 27, GREEN }, // 37 fuel depot
{ -1, GREY  }, // 38
{ 29, GREEN }, // 39 standalone fort
{ -1, GREY  }, // 40
{ 31, BROWN }, // 41 top left
{ 32, BROWN }, // 42 horizontal wall
{ 33, BROWN }, // 43 top right
{ 34, BROWN }, // 44 vertical gate
{ -1, GREY  }, // 45
{ -1, GREY  }, // 46
{ 36, BROWN }, // 47 vertical wall
{ 37, BROWN }, // 48 bottom left
{ -1, GREY  }, // 49
{ 38, BROWN }, // 50 bottom right
{ -1, GREY  }, // 51
{ -1, GREY  }, // 52
{ -1, GREY  }, // 53
{ -1, GREY  }, // 54
{ -1, GREY  }, // 55
{ -1, GREY  }, // 56
{ -1, GREY  }, // 57
{ -1, GREY  }, // 58
{ -1, GREY  }, // 59
{ -1, GREY  }, // 60
{ -1, GREY  }, // 61
{ -1, GREY  }, // 62
{ -1, GREY  }, // 63
{ 31, GREEN }, // 64 top left
{ 32, GREEN }, // 65 horizontal wall
{ 33, GREEN }, // 66 top right
{ 34, GREEN }, // 67 vertical gate
{ -1, GREY  }, // 68
{ -1, GREY  }, // 69
{ 36, GREEN }, // 70 vertical wall
{ 37, GREEN }, // 71 bottom left
{ -1, GREY  }, // 72
{ 38, GREEN }, // 73 bottom right
{ -1, GREY  }, // 74
{ -1, GREY  }, // 75
{ -1, GREY  }, // 76
{ -1, GREY  }, // 77
{ -1, GREY  }, // 78
{ -1, GREY  }, // 79
{ -1, GREY  }, // 80
{ -1, GREY  }, // 81
{ -1, GREY  }, // 82
{ -1, GREY  }, // 83
{ -1, GREY  }, // 84
{  9, BROWN }, // 85 4-way fort
{ -1, GREY  }, // 86
{  9, GREEN }, // 87 4-way fort
{ -1, GREY  }, // 88
{ 35, BROWN }, // 89 flag building
{ -1, GREY  }, // 90
{ -1, GREY  }, // 91
{ 35, GREEN }, // 92 flag building
};

MODULE const SBYTE stampinfo[50][2] = {
{  0,  0 }, //  0 dirt
{  1,  1 }, //  1 dirt
{  2,  2 }, //  2 tree
{  3,  3 }, //  3 tree
{  4,  4 }, //  4 tree
{  5,  5 }, //  5 road
{  6,  6 }, //  6 road
{  7,  7 }, //  7 road
{  8,  8 }, //  8 road
{ 85, 87 }, //  9 4-way fort
{ 10, 10 }, // 10 road
{ 11, 11 }, // 11 road
{ 12, 12 }, // 12 road
{ 13, 13 }, // 13 road
{ 14, 14 }, // 14 helipad
{ 15, 15 }, // 15 road
{ 16, 16 }, // 16 road
{ 17, 29 }, // 17 officer building
{ 18, 30 }, // 18 utility building
{ 19, 31 }, // 19 prison
{ 20, 20 }, // 20 brown home garage
{ 32, 32 }, // 21 green home garage
{ -1, -1 }, // 22 destroyed building
{ 22, 34 }, // 23 brown/greenhouse
{ -1, -1 }, // 24 destroyed brown/greenhouse
{ 24, 36 }, // 25 medic building
{ -1, -1 }, // 26 dirt
{ 25, 37 }, // 27 fuel depot
{ -1, -1 }, // 28 destroyed fuel depot
{ 27, 39 }, // 29 standalone fort
{ -1, -1 }, // 30 destroyed standalone fort
{ 41, 64 }, // 31 top left
{ 42, 65 }, // 32 horizontal wall
{ 43, 66 }, // 33 top right
{ 44, 67 }, // 34 vertical gate
{ 89, 92 }, // 35 flag building
{ 47, 70 }, // 36 vertical wall
{ 48, 71 }, // 37 bottom left
{ 50, 73 }, // 38 bottom right
{ -1, -1 }, // 39 destroyed top left
{ -1, -1 }, // 40 destroyed horizontal wall
{ -1, -1 }, // 41 destroyed top right
{ -1, -1 }, // 42 destroyed vertical gate
{ -1, -1 }, // 43 damaged flag building
{ -1, -1 }, // 44 destroyed flag building
{ -1, -1 }, // 45 destroyed vertical wall
{ -1, -1 }, // 46 destroyed bottom left
{ -1, -1 }, // 47 destroyed bottom right
{ -1, -1 }, // 48 open vertical gate
{ -1, -1 }, // 49 destroyed 4-way fort
};

// 8. CODE ---------------------------------------------------------------

EXPORT void ss_main(void)
{   TRANSIENT ULONG idcmp1, idcmp2;
    TRANSIENT int   i;
    PERSIST   FLAG  first = TRUE;

    if (first)
    {   first = FALSE;

        // ss_preinit()
        for (i = 0; i < 32; i++)
        {   gotpen[i] = FALSE;
    }   }

    tool_open      = ss_open;
    tool_loop      = ss_loop;
    tool_save      = ss_save;
    tool_close     = ss_close;
    tool_exit      = ss_exit;
    tool_subgadget = sketchboard_subgadget;

    if (loaded != FUNC_SS)
    {   stamp = 0;
        if (!ss_open(TRUE))
        {   function = page = FUNC_MENU;
            return;
        }
        loaded = FUNC_SS;
    }

    sb2        = GID_SS_SB2;
    sb3        = GID_SS_SB3;
    sk1        = GID_SS_SK1;
    pl1        = GID_SS_PL1;
    bu3        = GID_SS_BU3;
    bu4        = GID_SS_BU4;
    tilewidth  =
    tileheight = 64;

    make_speedbar_list(GID_SS_SB1);
    load_aiss_images( 9,  9);
    load_aiss_images(18, 18);
    ss_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                gadgets[GID_SS_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            AddHLayout,
                AddToolbar(GID_SS_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_SS_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_SS_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_Label,                              "Map Editor",
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                AddVLayout,
                    LAYOUT_AddChild,                       gadgets[GID_SS_LY3] = (struct Gadget*)
                    VLayoutObject,
                        LAYOUT_BevelStyle,                 BVS_NONE,
                        LAYOUT_AddChild,                   gadgets[GID_SS_SP1] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                         GID_SS_SP1,
                            GA_Width,                      wideness,
                            GA_Height,                     tallness,
                            SPACE_BevelStyle,              BVS_NONE,
                            SPACE_Transparent,             TRUE,
                        SpaceEnd,
                        CHILD_MinWidth,                    MINWIDENESS,
                        CHILD_MinHeight,                   MINTALLNESS,
                        CHILD_MaxWidth,                    MAXWIDENESS,
                        CHILD_MaxHeight,                   MAXTALLNESS,
                    LayoutEnd,
                    CHILD_WeightedWidth,                   100,
                    CHILD_WeightedHeight,                  100,
                    LAYOUT_AddChild,                       gadgets[GID_SS_SC1] = (struct Gadget*)
                    ScrollerObject,
                        GA_ID,                             GID_SS_SC1,
                        GA_RelVerify,                      TRUE,
                        SCROLLER_Orientation,              SORIENT_HORIZ,
                        SCROLLER_Arrows,                   TRUE,
                    ScrollerEnd,
                    CHILD_WeightedWidth,                   100,
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                LAYOUT_AddChild,                           gadgets[GID_SS_SC2] = (struct Gadget*)
                ScrollerObject,
                    GA_ID,                                 GID_SS_SC2,
                    GA_RelVerify,                          TRUE,
                    SCROLLER_Orientation,                  SORIENT_VERT,
                    SCROLLER_Arrows,                       TRUE,
                ScrollerEnd,
                CHILD_WeightedWidth,                       0,
                CHILD_WeightedHeight,                      100,
            LayoutEnd,
            AddVLayout,
                LAYOUT_Label,                              "Tiles",
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                AddHLayout,
                    LAYOUT_ShrinkWrap,                     TRUE,
                    LAYOUT_AddChild,                       gadgets[GID_SS_LY4] = (struct Gadget*)
                    VLayoutObject,
                        AddVLayout,
                            LAYOUT_BevelStyle,             BVS_NONE,
                            LAYOUT_AddChild,               gadgets[GID_SS_SP2] = (struct Gadget*)
                            SpaceObject,
                                GA_ID,                     GID_SS_SP2,
                                GA_Width,                  wideness,
                                SPACE_BevelStyle,          BVS_NONE,
                                SPACE_Transparent,         TRUE,
                            SpaceEnd,
                            CHILD_MinWidth,                MINWIDENESS,
                            CHILD_MinHeight,               64,
                            CHILD_MaxWidth,                MAXWIDENESS,
                            CHILD_MaxHeight,               64,
                        LayoutEnd,
                        CHILD_WeightedHeight,              100,
                        LAYOUT_AddChild,                   gadgets[GID_SS_SC3] = (struct Gadget*)
                        ScrollerObject,
                            GA_ID,                         GID_SS_SC3,
                            GA_RelVerify,                  TRUE,
                            SCROLLER_Orientation,          SORIENT_HORIZ,
                            SCROLLER_Arrows,               TRUE,
                        ScrollerEnd,
                        CHILD_WeightedHeight,              0,
                    LayoutEnd,
                    CHILD_WeightedWidth,                   100,
                    AddHLayout,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedWidth,                   0,
                    CHILD_MinWidth,                        13, // this is only an approximation unfortunately
                LayoutEnd,
                LAYOUT_AddChild,                           gadgets[GID_SS_CH2] = (struct Gadget*)
                PopUpObject,
                    GA_ID,                                 GID_SS_CH2,
                    GA_RelVerify,                          TRUE,
                    CHOOSER_LabelArray,                    &ColourOptions,
                ChooserEnd,
                Label("_Colour:"),
            LayoutEnd,
            CHILD_WeightedWidth,                           100,
            CHILD_WeightedHeight,                          0,
            AddHLayout,
                LAYOUT_AddChild,                           gadgets[GID_SS_BU2] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                 GID_SS_BU2,
                    GA_RelVerify,                          TRUE,
                    GA_Disabled,                           (SketchBoardBase ? FALSE : TRUE),
                    GA_Image,
                    LabelObject,
                        LABEL_Image,                       aissimage[18],
                        CHILD_NoDispose,                   TRUE,
                        LABEL_DrawInfo,                    DrawInfoPtr,
                        LABEL_VerticalAlignment,           LVALIGN_BASELINE,
                        LABEL_Text,                        " _Edit Tile Graphics... ",
                    LabelEnd,
                ButtonEnd,
                ClearButton(GID_SS_BU1, "Clear Level"),
                CHILD_WeightedWidth,                       0,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_SS_SB1);
    setup_bm(0, MAXWIDENESS, MAXTALLNESS, MainWindowPtr);
    setup_bm(1, MAXWIDENESS, 64         , MainWindowPtr);
    ss_resize();
    writegadgets();
    lmb = FALSE;
    GetAttr(WA_IDCMP, WinObject, &idcmp1);
    idcmp1 |= IDCMP_MENUVERIFY;
    idcmp2 = idcmp1 & ~(IDCMP_NEWSIZE);
    SetAttrs // not ModifyIDCMP()!
    (   WinObject,
        WA_IDCMP,             idcmp1,
        WINDOW_IDCMPHookBits, idcmp2,
    TAG_DONE);

    loop();

    closewindow();
}

EXPORT void ss_loop(ULONG gid, UNUSED ULONG code)
{   int x, y;

    switch (gid)
    {
    case GID_SS_BU1:
        for (y = 0; y < 256; y++)
        {   for (x = 0; x < 16; x++)
            {   IOBuffer[((game == TURBO) ? 8 : 0) + (y * 16) + x] = 0;
        }   }
        ss_drawmap(FALSE);
    acase GID_SS_BU2:
        gfxwindow();
    acase GID_SS_SC1:
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_SS_SC1], (ULONG*) &scrollx);
        ss_drawmap(FALSE);
    acase GID_SS_SC2:
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_SS_SC2], (ULONG*) &scrolly);
        ss_drawmap(FALSE);
    acase GID_SS_SC3:
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_SS_SC3], (ULONG*) &tilex);
        ss_updatetiles();
    acase GID_SS_CH2:
        DISCARD GetAttr(CHOOSER_Selected, (Object*) gadgets[GID_SS_CH2], (ULONG*) &stampmode);
        ss_updatetiles();
}   }

EXPORT FLAG ss_open(FLAG loadas)
{   TRANSIENT ULONG oldgame;
    TRANSIENT BPTR  FileHandle /* = ZERO */ ;
    TRANSIENT int   i, j,
                    start,
                    x, y;
    PERSIST   TEXT  tempstring[MAX_PATH + 1]; // these are PERSISTent so as not to blow the stack
    PERSIST   UBYTE IOBufferCopy[2048];

    memcpy(IOBufferCopy, IOBuffer, 2048);

    if (gameopen(loadas))
    {   oldgame = game;
        switch (gamesize)
        {
        case 2048:
            game = FIREPOWER;
            gfxsize = 106784;
            numtiles = 50;
            if (ask("Load into which side?", "Left|Right") == 0) // left
            {   if (oldgame != FIREPOWER)
                {   memset(&IOBuffer[2048], 0, 2048); // clear right side
            }   }
            else // right
            {   memcpy(&IOBuffer[2048], &IOBuffer[0], 2048); // copy left side to right side
                if (oldgame == FIREPOWER)
                {   memcpy(&IOBuffer[   0], IOBufferCopy, 2048); // copy left side from backup
                } else
                {   memset(&IOBuffer[   0], 0, 2048); // clear left  side
            }   }
            gamesize = 4096;
        acase 4096:
            game = FIREPOWER;
            gfxsize = 106784;
            numtiles = 50;
        acase 4104:
            game = TURBO;
            gfxsize = 93904;
            numtiles = 45;
        adefault:
            DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    serializemode = SERIALIZE_READ;
    serialize();

    if (Gfx_Buffer)
    {   FreeVec(Gfx_Buffer);
        // Gfx_Buffer = NULL;
    }
    if (!(Gfx_Buffer = AllocVec(gfxsize, MEMF_ANY)))
    {   rq("Out of memory!");
    }

    // first look in /gr/
    zstrncpy(tempstring,   pathname,   (size_t) (PathPart((STRPTR) pathname  ) - (STRPTR) pathname  ));
    zstrncpy(Gfx_Pathname, tempstring, (size_t) (PathPart((STRPTR) tempstring) - (STRPTR) tempstring));
    if
    (   !AddPart(Gfx_Pathname, "gr/tiles", MAX_PATH)
     || !(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_OLDFILE))
    )
    {   // try current directory
        strcpy(Gfx_Pathname, tempstring);
        if (!AddPart(Gfx_Pathname, "tiles", MAX_PATH))
        {   printf("Can't assemble pathname %s!\n", Gfx_Pathname);
            return FALSE;
        }
        if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_OLDFILE)))
        {   printf("Can't open file %s for reading!\n", Gfx_Pathname);
            return FALSE;
    }   }

    if (Read(FileHandle, Gfx_Buffer, gfxsize) != (LONG) gfxsize)
    {   DISCARD Close(FileHandle);
        // FileHandle = ZERO;
        printf("Can't read file %s!\n", Gfx_Pathname);
        return FALSE;
    }
    DISCARD Close(FileHandle);
    // FileHandle = ZERO;

    start = 0;
    for (i = 0; i < numtiles; i++)
    {   tileplanes[i] = Gfx_Buffer[start + 5];
        start += 16;

        for (y = 0; y < 64; y++)
        {   for (x = 0; x < 64; x++)
            {   TileData[i][y][x] = (game == FIREPOWER && tileplanes[i] == 1) ? 1 : 0;
        }   }

        if (tileplanes[i])
        {   for (j = 0; j < tileplanes[i]; j++)
            {   for (y = 0; y < 64; y++)
                {   for (x = 0; x < 64; x++)
                    {   if (Gfx_Buffer[start + (y * 8) + (x / 8)] & (0x80 >> (x % 8)))
                        {   if (game == FIREPOWER && (i == 32 || i == 36))
                            {   TileData[i][y][x] |= ((j == 2) ? 16 : (1 << j));
                            } elif (tileplanes[i] == 4)
                            {   TileData[i][y][x] |= ((j == 3) ? 16 : (1 << j));
                            } elif (tileplanes[i] == 1)
                            {   TileData[i][y][x] |= ((game == FIREPOWER) ? 3 : 2);
                            } else
                            {   TileData[i][y][x] |= (1 << j);
                }   }   }   }
                start += 512;
    }   }   }

    if (loaded == FUNC_SS && game != oldgame)
    {   ss_freepens();
        ss_getpens();
        ss_resize();
    }

    writegadgets();
    return TRUE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_SS
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    ss_drawmap(TRUE);

    either_ch(GID_SS_CH1, &game);

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SS_CH2], MainWindowPtr, NULL,
        GA_Disabled,      (game == TURBO) ? TRUE : FALSE,
        CHOOSER_Selected, stampmode,
    TAG_END); // this refreshes automatically
}

EXPORT void ss_save(FLAG saveas)
{   int   count,
          i, j,
          start,
          x, y;
    UBYTE srcmask;
    BPTR  FileHandle /* = ZERO */ ;

    if (game == FIREPOWER)
    {   count = 0;
        for (x = 0; x < 64; x++)
        {   for (y = 0; y < 64; y++)
            {   if (IOBuffer[(x * 64) + y] == 20) // brown garage
                {   count++;
        }   }   }
        if (count != 1)
        {   say("Must have 1 (only) brown garage!", REQIMAGE_WARNING);
            return;
        }

        count = 0;
        for (x = 0; x < 64; x++)
        {   for (y = 0; y < 64; y++)
            {   if (IOBuffer[(x * 64) + y] == 32) // green garage
                {   count++;
        }   }   }
        if (count >= 2)
        {   say("Must have 0 or 1 green garages!", REQIMAGE_WARNING);
            return;
        }

        count = 0;
        for (x = 0; x < 64; x++)
        {   for (y = 0; y < 64; y++)
            {   if (IOBuffer[(x * 64) + y] == 92) // green flag building
                {   count++;
                    break; // for speed
        }   }   }
        if (count == 0)
        {   say("Must have at least 1 green flag building!", REQIMAGE_WARNING);
            return;
    }   }

    serializemode = SERIALIZE_WRITE;
    serialize();
    if (!gamesave("#?", (game == TURBO) ? "Turbo" : "Firepower", saveas, gamesize, FLAG_G | FLAG_L, TRUE))
    {   return;
    }

    start = 0;
    for (i = 0; i < numtiles; i++)
    {   // tileplanes[i] = Gfx_Buffer[start + 5];
        start += 16;

        switch (tileplanes[i])
        {
        case 0:
            ;
        acase 1:
            for (y = 0; y < 64; y++)
            {   for (x = 0; x < 64; x++)
                {   if (TileData[i][y][x] == ((game == FIREPOWER) ? 3 : 2))
                    {   Gfx_Buffer[start + (y * 8) + (x / 8)] |=  (0x80 >> (x % 8));
                    } else
                    {   Gfx_Buffer[start + (y * 8) + (x / 8)] &= ~(0x80 >> (x % 8));
            }   }   }
            start += 512;
        acase 3:
            // assert(game == FIREPOWER);
            for (j = 0; j < tileplanes[i]; j++)
            {   if ((i == 32 || i == 36) && j == 2)
                {   srcmask = (1 << 4); // ie. 16
                } else
                {   srcmask = (1 << j);
                }
                for (y = 0; y < 64; y++)
                {   for (x = 0; x < 64; x++)
                    {   if (TileData[i][y][x] & srcmask)
                        {   Gfx_Buffer[start + (y * 8) + (x / 8)] |=  (0x80 >> (x % 8));
                        } else
                        {   Gfx_Buffer[start + (y * 8) + (x / 8)] &= ~(0x80 >> (x % 8));
                }   }   }
                start += 512;
            }
        acase 4:
            // assert(game == FIREPOWER);
            for (j = 0; j < tileplanes[i]; j++)
            {   if (j == 3)
                {   srcmask = (1 << 4); // ie. 16
                } else
                {   srcmask = (1 << j);
                }
                for (y = 0; y < 64; y++)
                {   for (x = 0; x < 64; x++)
                    {   if (TileData[i][y][x] & srcmask)
                        {   Gfx_Buffer[start + (y * 8) + (x / 8)] |=  (0x80 >> (x % 8));
                        } else
                        {   Gfx_Buffer[start + (y * 8) + (x / 8)] &= ~(0x80 >> (x % 8));
                }   }   }
                start += 512;
            }
        adefault:
            for (j = 0; j < tileplanes[i]; j++)
            {   for (y = 0; y < 64; y++)
                {   for (x = 0; x < 64; x++)
                    {   if (TileData[i][y][x] & (1 << j))
                        {   Gfx_Buffer[start + (y * 8) + (x / 8)] |=  (0x80 >> (x % 8));
                        } else
                        {   Gfx_Buffer[start + (y * 8) + (x / 8)] &= ~(0x80 >> (x % 8));
                }   }   }
                start += 512;
    }   }   }

    if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_NEWFILE)))
    {   printf("Can't open file \"%s\" for writing!\n", Gfx_Pathname);
        return;
    }
    DISCARD Write(FileHandle, Gfx_Buffer, gfxsize);
    DISCARD Close(FileHandle);
    // FileHandle = ZERO;

    say("Saved files.", REQIMAGE_INFO);
}

MODULE void serialize(void)     { ; }
EXPORT void ss_close(void)      { ; }

EXPORT void ss_exit(void)
{   ss_freepens();

    if (Gfx_Buffer)
    {   FreeVec(Gfx_Buffer);
        Gfx_Buffer = NULL;
}   }

EXPORT void ss_resize(void)
{   int y;

    wideness = gadgets[GID_SS_LY3]->Width;
    tallness = gadgets[GID_SS_LY3]->Height;
    if (wideness >        16 * 64            ) wideness =        16 * 64;
    if (tallness >        16 * 64            ) tallness =        16 * 64;

    switch (game)
    {
    case FIREPOWER:
        if (scrollx  > (  64 * 64) - wideness) scrollx  = (      64 * 64) - wideness;
        if (scrolly  > (  64 * 64) - tallness) scrolly  = (      64 * 64) - tallness;
    acase TURBO:
        if (scrollx  > (  16 * 64) - wideness) scrollx  = (      16 * 64) - wideness;
        if (scrolly  > ( 256 * 64) - tallness) scrolly  = (     256 * 64) - tallness;
    }
    if (tilex    > (numtiles * 64) - wideness) tilex    = (numtiles * 64) - wideness;
    if (stamp    >= numtiles     )             stamp    =  numtiles       -        1;

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SS_SC1], MainWindowPtr, NULL,
        SCROLLER_Visible, wideness,
        SCROLLER_Top,     scrollx,
        SCROLLER_Total,   ((game == FIREPOWER) ? 64 :  16) * 64,
    TAG_END); // this refreshes automatically
    DISCARD SetGadgetAttrs
    (   gadgets[GID_SS_SC2], MainWindowPtr, NULL,
        SCROLLER_Visible, tallness,
        SCROLLER_Top,     scrolly,
        SCROLLER_Total,   ((game == FIREPOWER) ? 64 : 256) * 64,
    TAG_END); // this refreshes automatically
    DISCARD SetGadgetAttrs
    (   gadgets[GID_SS_SC3], MainWindowPtr, NULL,
        SCROLLER_Visible, wideness,
        SCROLLER_Top,     tilex,
        SCROLLER_Total,   numtiles * 64,
    TAG_END);

    for (y = 0; y < tallness; y++)
    {   byteptr1[y] = &display1[GFXINIT(wideness, y)];
    }
    for (y = 0; y <       64; y++)
    {   byteptr2[y] = &display2[GFXINIT(wideness, y)];
}   }

EXPORT void ss_drawmap(FLAG all)
{   int   x, xx,
          y, yy;
    UBYTE colour,
          whichtile,
          whichtile2;

    switch (game)
    {
    case FIREPOWER:
        for (y = 0; y < tallness; y++)
        {   for (x = 0; x < wideness; x++)
            {   whichtile = IOBuffer[    (((scrollx + x) / 64) * 64) + ((scrolly + y) / 64)];
                xx = (scrollx + x) % 64;
                yy = (scrolly + y) % 64;
                // assert(whichtile <= 92);
                if (whichtile <= 92 && tileinfo[whichtile].filetovar != -1)
                {   whichtile2 = tileinfo[whichtile].filetovar;
                } else
                {   whichtile2 = 0; // dirt
                }
                // assert(whichtile2 < numtiles);
                colour = TileData[whichtile2][yy][xx];
                if (tileinfo[whichtile].colour == GREEN && colour >= 28)
                {   colour -= 8;
                }
                *(byteptr1[y] + x) = pens[colour];
        }   }
    acase TURBO:
        for (y = 0; y < tallness; y++)
        {   for (x = 0; x < wideness; x++)
            {   whichtile = IOBuffer[8 + (((scrolly + y) / 64) * 16) + ((scrollx + x) / 64)];
                xx = (scrollx + x) % 64;
                yy = (scrolly + y) % 64;
                *(byteptr1[y] + x) = pens[(whichtile >= numtiles) ? 0 : TileData[whichtile][yy][xx]];
    }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_SS_SP1]->LeftEdge,
        gadgets[GID_SS_SP1]->TopEdge,
        gadgets[GID_SS_SP1]->LeftEdge + wideness - 1,
        gadgets[GID_SS_SP1]->TopEdge  + tallness - 1,
        display1,
        &wpa8rastport[0]
    );

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SS_SC1], MainWindowPtr, NULL,
        SCROLLER_Top, scrollx,
    TAG_END); // this refreshes automatically
    DISCARD SetGadgetAttrs
    (   gadgets[GID_SS_SC2], MainWindowPtr, NULL,
        SCROLLER_Top, scrolly,
    TAG_END); // this refreshes automatically

    if (all)
    {   ss_updatetiles();
}   }

MODULE void ss_drawmappart(int x, int y)
{   int   leftx,
          minx, miny,
          maxx, maxy,
          topy,
          xx,
          yy;
    UBYTE colour,
          whichtile,
          whichtile2 = 0; // initialized to avoid a spurious SAS/C warning

    leftx = (x * 64) - scrollx; // left edge of tile in gadget coords
    topy  = (y * 64) - scrolly; // top  edge of tile in gadget coords
    if (game == FIREPOWER)
    {   whichtile = IOBuffer[(x * 64) + y];
        if (whichtile <= 92 && tileinfo[whichtile].filetovar != -1)
        {   whichtile2 = tileinfo[whichtile].filetovar;
        } else
        {   whichtile2 = 0; // dirt
        }
        // assert(whichtile2 < numtiles);
    } else
    {   // assert(game == TURBO);
        whichtile = IOBuffer[8 + (y * 16) + x];
    }

    if (leftx      <        0) minx = -leftx               ; else minx =  0;
    if (topy       <        0) miny = -topy                ; else miny =  0;
    if (leftx + 64 > wideness) maxx = -leftx + wideness - 1; else maxx = 63;
    if (topy  + 64 > tallness) maxy = -topy  + tallness - 1; else maxy = 63;

    // assert(minx >=  0);
    // assert(miny >=  0);
    // assert(maxx <  64);
    // assert(maxy <  64);

    switch (game)
    {
    case FIREPOWER:
        for (yy = miny; yy <= maxy; yy++)
        {   for (xx = minx; xx <= maxx; xx++)
            {   colour = TileData[whichtile2][yy][xx];
                if (tileinfo[whichtile].colour == GREEN && colour >= 28)
                {   colour -= 8;
                }
                *(byteptr1[topy + yy] + leftx + xx) = pens[colour];
        }   }
    acase TURBO:
        for (yy = miny; yy <= maxy; yy++)
        {   for (xx = minx; xx <= maxx; xx++)
            {   *(byteptr1[topy + yy] + leftx + xx) = pens[(whichtile >= numtiles) ? 0 : TileData[whichtile][yy][xx]];
    }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_SS_SP1]->LeftEdge,
        gadgets[GID_SS_SP1]->TopEdge  + topy + miny,
        gadgets[GID_SS_SP1]->LeftEdge + wideness - 1,
        gadgets[GID_SS_SP1]->TopEdge  + topy + maxy,
        &display1[GFXINIT(wideness, (topy + miny))],
        &wpa8rastport[0]
    );
}

MODULE void ss_updatetiles(void)
{   int   x, y,
          xx;
    UBYTE colour,
          whichtile;

    switch (game)
    {
    case FIREPOWER:
        for (y = 0; y < 64; y++)
        {   for (x = 0; x < wideness; x++)
            {   whichtile = (tilex + x) / 64;
                xx        = (tilex + x) % 64;
                if (stamp == whichtile && (xx < 4 || xx >= 60 || y < 4 || y >= 60))
                {   if (stampinfo[stamp][stampmode] == -1)
                    {   *(byteptr2[y] + x) = pens[2]; // red
                    } elif (stampinfo[stamp][0] == stampinfo[stamp][1])
                    {   *(byteptr2[y] + x) = pens[0]; // black
                    } else
                    {   *(byteptr2[y] + x) = pens[stampmode ? 23 : 31]; // green or brown
                }   }
                else
                {   colour = TileData[whichtile][y][xx];
                    if (stampmode == GREEN && colour >= 28 && stampinfo[whichtile][0] != stampinfo[whichtile][1])
                    {   colour -= 8;
                    }
                    *(byteptr2[y] + x) = pens[colour];
        }   }   }
    acase TURBO:
        for (y = 0; y < 64; y++)
        {   for (x = 0; x < wideness; x++)
            {   whichtile = (tilex + x) / 64;
                xx        = (tilex + x) % 64;
                if (stamp == whichtile && (xx < 4 || xx >= 60 || y < 4 || y >= 60))
                {   *(byteptr2[y] + x) = pens[tileplanes[stamp] ? 3 : 22]; // black or red
                } else
                {   *(byteptr2[y] + x) = pens[TileData[whichtile][y][xx]];
    }   }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_SS_SP2]->LeftEdge,
        gadgets[GID_SS_SP2]->TopEdge,
        gadgets[GID_SS_SP2]->LeftEdge + wideness - 1,
        gadgets[GID_SS_SP2]->TopEdge  +       64 - 1,
        display2,
        &wpa8rastport[1]
    );

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SS_SC3], MainWindowPtr, NULL,
        SCROLLER_Top, tilex,
    TAG_END); // this refreshes automatically

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SS_BU2], MainWindowPtr, NULL,
        GA_Disabled, ((SketchBoardBase && gotallpens && tileplanes[stamp]) ? FALSE : TRUE),
    TAG_END); // this refreshes automatically
}

EXPORT void ss_getpens(void)
{   TRANSIENT int i;
PERSIST const struct
{   const ULONG red, blue, green;
} idealcolour[2][32] = { {
// Firepower
{ 0x00000000, 0x00000000, 0x00000000 }, //  0
{ 0xFFFFFFFF, 0xCCCCCCCC, 0x88888888 },
{ 0xFFFFFFFF, 0x00000000, 0x00000000 },
{ 0xBBBBBBBB, 0x99999999, 0x66666666 },
{ 0xBBBBBBBB, 0x00000000, 0x00000000 },
{ 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000 },
{ 0x88888888, 0x88888888, 0x88888888 },
{ 0x55555555, 0x55555555, 0x55555555 },
{ 0xFFFFFFFF, 0x00000000, 0x00000000 },
{ 0xFFFFFFFF, 0xFFFFFFFF, 0x55555555 },
{ 0x00000000, 0x00000000, 0x00000000 }, // 10
{ 0x88888888, 0xEEEEEEEE, 0x00000000 },
{ 0x33333333, 0xAAAAAAAA, 0x00000000 },
{ 0x00000000, 0x55555555, 0x00000000 },
{ 0x88888888, 0x88888888, 0x88888888 },
{ 0x55555555, 0x55555555, 0x55555555 },
{ 0x88888888, 0x88888888, 0x88888888 },
{ 0x55555555, 0x55555555, 0x55555555 },
{ 0x00000000, 0x00000000, 0x00000000 },
{ 0x88888888, 0xEEEEEEEE, 0x00000000 },
{ 0x44444444, 0xAAAAAAAA, 0x77777777 }, // 20
{ 0x22222222, 0x88888888, 0x55555555 },
{ 0x11111111, 0x55555555, 0x44444444 },
{ 0x00000000, 0x33333333, 0x22222222 },
{ 0x44444444, 0xAAAAAAAA, 0x77777777 },
{ 0x22222222, 0x88888888, 0x55555555 },
{ 0x00000000, 0x00000000, 0x00000000 },
{ 0x88888888, 0xEEEEEEEE, 0x00000000 },
{ 0xDDDDDDDD, 0x88888888, 0x33333333 },
{ 0xAAAAAAAA, 0x77777777, 0x33333333 },
{ 0x88888888, 0x55555555, 0x22222222 }, // 30
{ 0x55555555, 0x33333333, 0x11111111 }, // 31
}, {
// Turbo
{ 0xAAAAAAAA, 0xAAAAAAAA, 0xAAAAAAAA }, //  0
{ 0x44444444, 0x55555555, 0x55555555 },
{ 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF },
{ 0x00000000, 0x00000000, 0x00000000 },
{ 0x99999999, 0x55555555, 0x33333333 },
{ 0x77777777, 0x44444444, 0x22222222 },
{ 0x66666666, 0x33333333, 0x22222222 },
{ 0x44444444, 0x22222222, 0x11111111 },
{ 0xEEEEEEEE, 0xEEEEEEEE, 0xEEEEEEEE },
{ 0x77777777, 0x88888888, 0x88888888 },
{ 0x33333333, 0x55555555, 0x55555555 }, // 10
{ 0x00000000, 0x11111111, 0x11111111 },
{ 0x33333333, 0x55555555, 0x55555555 },
{ 0x00000000, 0x11111111, 0x11111111 },
{ 0x33333333, 0x55555555, 0x55555555 },
{ 0x00000000, 0x11111111, 0x11111111 },
{ 0x88888888, 0xFFFFFFFF, 0x00000000 },
{ 0x00000000, 0x88888888, 0x00000000 },
{ 0x00000000, 0x77777777, 0xCCCCCCCC },
{ 0x00000000, 0x00000000, 0xFFFFFFFF },
{ 0xFFFFFFFF, 0xEEEEEEEE, 0x00000000 }, // 20
{ 0xAAAAAAAA, 0x99999999, 0x00000000 },
{ 0xEEEEEEEE, 0x00000000, 0x00000000 },
{ 0xAAAAAAAA, 0x00000000, 0x00000000 },
{ 0xEEEEEEEE, 0xEEEEEEEE, 0xEEEEEEEE },
{ 0x77777777, 0x88888888, 0x88888888 },
{ 0x33333333, 0x55555555, 0x55555555 },
{ 0x00000000, 0x11111111, 0x11111111 },
{ 0x00000000, 0x99999999, 0x55555555 },
{ 0x00000000, 0x55555555, 0x33333333 },
{ 0xDDDDDDDD, 0x66666666, 0xFFFFFFFF }, // 30
{ 0x77777777, 0x44444444, 0x77777777 }, // 31
} };

    lockscreen();

    gotallpens = TRUE;
    for (i = 0; i < 32; i++)
    {   pens[i] = (LONG) ObtainPen
        (   ScreenPtr->ViewPort.ColorMap,
            (ULONG) -1,
            idealcolour[game][i].red,
            idealcolour[game][i].blue,
            idealcolour[game][i].green,
            PEN_EXCLUSIVE
        );
        if (pens[i] >= 0 && pens[i] <= 255)
        {   gotpen[i] = TRUE;
            convert[pens[i]] = i;
        } else
        {   gotallpens = FALSE;
            pens[i] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                idealcolour[game][i].red,
                idealcolour[game][i].blue,
                idealcolour[game][i].green,
                -1
            );
    }   }

    unlockscreen();

    if (!gotallpens)
    {   ss_freepens();
}   }
EXPORT void ss_freepens(void)
{   int i;

    lockscreen();
    for (i = 0; i < 32; i++)
    {   if (gotpen[i])
        {   ReleasePen(ScreenPtr->ViewPort.ColorMap, (ULONG) pens[i]);
            gotpen[i] = FALSE;
    }   }
    unlockscreen();
    gotallpens = FALSE;
}

EXPORT void ss_uniconify(void)
{   ss_freepens();
    ss_getpens();
    ss_resize();
    ss_drawmap(TRUE);
}

EXPORT void ss_tick(SWORD mousex, SWORD mousey)
{   if
    (   mouseisover(GID_SS_SP1, mousex, mousey)
     || mouseisover(GID_SS_SP2, mousex, mousey)
    )
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
}   }

EXPORT void ss_mouse(SWORD mousex, SWORD mousey)
{   int whichtile,
        x, y;

    if (lmb && mouseisover(GID_SS_SP1, mousex, mousey))
    {   x = ((mousex - gadgets[GID_SS_SP1]->LeftEdge + scrollx) / 64);
        y = ((mousey - gadgets[GID_SS_SP1]->TopEdge  + scrolly) / 64);

        switch (game)
        {
        case  FIREPOWER:
            whichtile =     (x * 64) + y;
            if (stampinfo[stamp][stampmode] != -1 && IOBuffer[whichtile] != stampinfo[stamp][stampmode])
            {   IOBuffer[whichtile] = stampinfo[stamp][stampmode];
                ss_drawmappart(x, y);
            }
        acase TURBO:
            whichtile = 8 + (y * 16) + x;
            if (IOBuffer[whichtile] != stamp)
            {   IOBuffer[whichtile] = stamp;
                ss_drawmappart(x, y);
}   }   }   }

EXPORT void ss_mb(SWORD mousex, SWORD mousey, UWORD code)
{   TRANSIENT int   x, y;
    PERSIST   ULONG oldsecs,
                    oldmicros,
                    newsecs   = 0,
                    newmicros = 0;

    switch (code)
    {
    case SELECTUP:
        lmb = FALSE;
    acase SELECTDOWN: // this doesn't repeat
        lmb = TRUE;

        if (mouseisover(GID_SS_SP1, mousex, mousey))
        {   x = (mousex - gadgets[GID_SS_SP1]->LeftEdge + scrollx) / 64;
            y = (mousey - gadgets[GID_SS_SP1]->TopEdge  + scrolly) / 64;

            switch (game)
            {
            case FIREPOWER:
                if (stampinfo[stamp][stampmode] != -1 && IOBuffer[(x * 64) + y] != stampinfo[stamp][stampmode])
                {   IOBuffer[(x * 64) + y] = stampinfo[stamp][stampmode];
                    ss_drawmappart(x, y);
                }
            acase TURBO:
                if (IOBuffer[8 + (y * 16) + x] != stamp)
                {   IOBuffer[8 + (y * 16) + x] = stamp;
                    ss_drawmappart(x, y);
        }   }   }
        elif (mouseisover(GID_SS_SP2, mousex, mousey))
        {   x = (mousex - gadgets[GID_SS_SP2]->LeftEdge + tilex  ) / 64;

            oldsecs   = newsecs;
            oldmicros = newmicros;
            CurrentTime(&newsecs, &newmicros);

            if
            (   stamp == x
             && DoubleClick(oldsecs, oldmicros, newsecs, newmicros)
             && SketchBoardBase
             && gotallpens
             && tileplanes[stamp]
            )
            {   gfxwindow();
                lmb = FALSE;
            } else
            {   stamp = x;
                ss_updatetiles();
        }   }
    acase MENUUP: // we don't hear MENUDOWNs
        if (mouseisover(GID_SS_SP1, mousex, mousey))
        {   x = (mousex - gadgets[GID_SS_SP1]->LeftEdge + scrollx) / 64;
            y = (mousey - gadgets[GID_SS_SP1]->TopEdge  + scrolly) / 64;

            switch (game)
            {
            case FIREPOWER:
                if (stampinfo[0][stampmode] != -1 && IOBuffer[(x * 64) + y] != stampinfo[0][stampmode])
                {   IOBuffer[(x * 64) + y] = stampinfo[0][stampmode];
                    ss_drawmappart(x, y);
                }
            acase TURBO:
                if (IOBuffer[8 + (y * 16) + x] != 9)
                {   IOBuffer[8 + (y * 16) + x] = 9;
                    ss_drawmappart(x, y);
}   }   }   }   }

EXPORT void ss_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey)
{   int oldx, oldy,
        oldtilex;

    if (scancode == SCAN_E)
    {   if (SketchBoardBase && gotallpens && tileplanes[stamp])
        {   gfxwindow();
        }
        return;
    }

    oldx     = scrollx;
    oldy     = scrolly;
    oldtilex = tilex;

    if
    (   scancode == SCAN_UP
     || scancode == SCAN_N7
     || scancode == SCAN_N8
     || scancode == SCAN_N9
     || scancode == NM_WHEEL_UP
    )
    {   MOVE_UP(       qual, &scrolly, 1 * 64, 160);
    } elif
    (   scancode == SCAN_DOWN
     || scancode == SCAN_N5
     || scancode == SCAN_N1
     || scancode == SCAN_N2
     || scancode == SCAN_N3
     || scancode == NM_WHEEL_DOWN
    )
    {   switch (game)
        {
        case  FIREPOWER: MOVE_DOWN(     qual, &scrolly, 1 * 64, 160, ( 64 * 64) - tallness);
        acase TURBO:     MOVE_DOWN(     qual, &scrolly, 1 * 64, 160, (256 * 64) - tallness);
    }   }

    if
    (   mouseisover(GID_SS_SP2, mousex, mousey)
     || mouseisover(GID_SS_SC3, mousex, mousey)
    )
    {   if
        (   scancode == SCAN_LEFT
         || scancode == SCAN_N7
         || scancode == SCAN_N4
         || scancode == SCAN_N1
        )
        {   MOVE_LEFT( qual, &tilex  , 1 * 64, 160);
        } elif
        (   scancode == SCAN_RIGHT
         || scancode == SCAN_N9
         || scancode == SCAN_N6
         || scancode == SCAN_N3
        )
        {   MOVE_RIGHT(qual, &tilex  , 1 * 64, 160, (numtiles * 64) - wideness);
    }   }
    else
    {   if
        (   scancode == SCAN_LEFT
         || scancode == SCAN_N7
         || scancode == SCAN_N4
         || scancode == SCAN_N1
        )
        {   MOVE_LEFT( qual, &scrollx, 1 * 64, 160);
        } elif
        (   scancode == SCAN_RIGHT
         || scancode == SCAN_N9
         || scancode == SCAN_N6
         || scancode == SCAN_N3
        )
        {   switch (game)
            {
            case  FIREPOWER: MOVE_RIGHT(qual, &scrollx, 1 * 64,    160, ( 64 * 64) - wideness);
            acase TURBO:     MOVE_RIGHT(qual, &scrollx, 1 * 64,    160, ( 16 * 64) - wideness);
    }   }   }

    if (scrollx != oldx || scrolly != oldy)
    {   ss_drawmap(FALSE);
    }
    if (tilex != oldtilex)
    {   ss_updatetiles();
}   }

EXPORT void ss_realpen_to_table(void)
{   fgpen_real    = convert[fgpen_real];
    fgpen_intable = fgpen_real;

    switch (tileplanes[stamp])
    {
    case 1:
        if (game == FIREPOWER)
        {   fgpen_intable--; // 0 or 2
        }
        fgpen_intable /= 2; // 0 or 1
    acase 3:
        // assert(game == FIREPOWER);
        if ((stamp == 32 || stamp == 36) && fgpen_intable >= 16)
        {   fgpen_intable -= 12;
        }
    acase 4:
        // assert(game == FIREPOWER);
        if (fgpen_intable >= 16)
        {   fgpen_intable -= 8;
}   }   }
EXPORT void ss_tablepen_to_real(void)
{   fgpen_real = fgpen_intable;

    switch (tileplanes[stamp])
    {
    case 1:
        fgpen_real *= 2; // 0 or 2
        if (game == FIREPOWER)
        {   fgpen_real++; // 1 or 3
        }
    acase 3:
        // assert(game == FIREPOWER);
        if ((stamp == 32 || stamp == 36) && fgpen_real >= 4)
        {   fgpen_real += 12;
        }
    acase 4:
        // assert(game == FIREPOWER);
        if (fgpen_real >= 8)
        {   fgpen_real += 8;
}   }   }

EXPORT FLAG ss_wantrmb(SWORD mousex, SWORD mousey)
{   return mouseisover(GID_SS_SP1, mousex, mousey);
}
