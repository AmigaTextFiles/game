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

#ifdef __MORPHOS__
#define GETCOLOR_GetClass() LP0(30, Class*, GETCOLOR_GetClass, , \
GetColorBase, 0, 0, 0, 0, 0, 0)
//Class* GETCOLOR_GetClass();
#define GetColorObject         NewObject(GETCOLOR_GetClass(), NULL
#define GetColorEnd            TAG_END)
#define GCOLOR_REQUEST         (0x630001)
#define GETCOLOR_Dummy         (REACTION_Dummy + 0x43000)
#define GETCOLOR_Screen        (GETCOLOR_Dummy +  2)
#define GETCOLOR_Color         (GETCOLOR_Dummy +  3)
#define GETCOLOR_ShowRGB       (GETCOLOR_Dummy + 17)
#define GETCOLOR_ShowHSB       (GETCOLOR_Dummy + 18)
#else
#include <gadgets/getcolor.h>
#include <proto/getcolor.h>
#endif

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
#define GID_SW_LY1   0 // root layout
#define GID_SW_LY2   1 // map
#define GID_SW_LY3   2 // tiles
#define GID_SW_SB1   3 // toolbar
#define GID_SW_SP1   4 // map
#define GID_SW_SP2   5 // tiles
#define GID_SW_SC1   6 // map
#define GID_SW_BU1   7 // clear level
#define GID_SW_BU2   8 // edit tile graphics
#define GID_SW_BU5   9 // edit title screen
#define GID_SW_GC1  10
#define GID_SW_GC32 41
#define GID_SW_CH1  42 // game

// graphics editor
#define GID_SW_SB2  43
#define GID_SW_SB3  44
#define GID_SW_SK1  45
#define GID_SW_PL1  46
#define GID_SW_BU3  47
#define GID_SW_BU4  48

#define GIDS_SW     GID_SW_BU4

#define DOUBLESIZE
// whether to double size of tiles on map for sw2
// changing from sw1 to sw2 and vice versa won't work properly without DOUBLESIZE

#define TILEWIDTH   16
#define TILEHEIGHT  16
#define TILESX      16
#define TILESY      16
#define TILESWIDTH   (TILESX * TILEWIDTH ) //  256 pixels
#define TILESHEIGHT  (TILESY * TILEHEIGHT) //  256 pixels

#define TOTALWIDTH1  (    26 * TILEWIDTH ) //  416 pixels
#define TOTALWIDTH2  (    13 * TILEWIDTH ) //  208 pixels
#define TOTALHEIGHT1 (   228 * TILEHEIGHT) // 3648 pixels
#define TOTALHEIGHT2 (   240 * TILEHEIGHT) // 3840 pixels

#define MINTALLNESS  (    16 * TILEHEIGHT) //  256 pixels
#define MAXTALLNESS  (    64 * TILEHEIGHT) // 1024 pixels

#define GETOFFSET(a, b, c) (((c) == SIDEWINDER1) ? (((b) * 26) + (a)) : (((b) * 13) + (a)))

#define AddColour(x) LAYOUT_AddChild, gadgets[GID_SW_GC1 + x] = (struct Gadget*) GetColorObject, \
    GA_ID,            GID_SW_GC1 + x, \
    GA_RelVerify,     TRUE,           \
    GETCOLOR_Screen,  ScreenPtr,      \
    GETCOLOR_ShowRGB, TRUE,           \
    GETCOLOR_ShowHSB, TRUE,           \
GetColorEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void updatetiles(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT FLAG                 titlemode;
IMPORT int                  bu3, bu4, pl1, sb2, sb3, sk1,
                            function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra,
                            tilewidth,
                            tileheight;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT UBYTE                convert[256],
                            IOBuffer[IOBUFFERSIZE],
                            ScrnData[64000],
                            stamp,
                            tileplanes[256];
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT ULONG                fgpen_intable,
                            fgpen_real,
                            game,
                            offset,
                            showtoolbar;
IMPORT __aligned UBYTE      scrndisplay[GFXINIT(320, 200)];
IMPORT UBYTE*               scrnbyteptr[200];
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct RastPort      sketchrastport,
                            wpa8rastport[2],
                            wpa8tilerastport;
IMPORT UBYTE               *byteptr1[DISPLAY1HEIGHT],
                           *byteptr2[DISPLAY2HEIGHT];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE],
                            display2[DISPLAY2SIZE];
IMPORT struct Library      *GetColorBase,
                           *SketchBoardBase;

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE FLAG                 gotallpens = FALSE,
                            gotpen[32],
                            lmb        = FALSE;
MODULE TEXT                 Gfx_Pathname[MAX_PATH + 1];
MODULE UBYTE                Gfx_Buffer[41024];
MODULE UWORD                Title_Buffer[16033];
MODULE ULONG                gadcolour[32];
MODULE int                  magnifier,
                            scrolly    = 0,
                            tallness   = MINTALLNESS;

MODULE const STRPTR GameOptions[2 + 1] =
{ "SideWinder 1",
  "SideWinder 2",
  NULL
};

MODULE const UBYTE blank[     2] = {           41,            0 };
MODULE const int   gamewidth[ 2] = { TOTALWIDTH1 , TOTALWIDTH2  },
                   gameheight[2] = { TOTALHEIGHT1, TOTALHEIGHT2 },
                   mapwidth[  2] = {           26,           13 },
                   mapheight[ 2] = {          228,          240 },
                   planes[    2] = {            5,            4 };

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void sw_main(void)
{   TRANSIENT int     i;
    TRANSIENT Object* PaletteGroup = NULL;
    PERSIST   FLAG    first        = TRUE;

    if (first)
    {   first = FALSE;

        // sw_preinit()
        for (i = 0; i < 32; i++)
        {   gotpen[i] = FALSE;
    }   }

    tool_open      = sw_open;
    tool_loop      = sw_loop;
    tool_save      = sw_save;
    tool_close     = sw_close;
    tool_exit      = sw_exit;
    tool_subgadget = sketchboard_subgadget;

    if (loaded != FUNC_SIDEWINDER)
    {   stamp = 41;
        if (!sw_open(TRUE))
        {   function = page = FUNC_MENU;
            return;
        } // implied else
        loaded = FUNC_SIDEWINDER;
    }

    sb2        = GID_SW_SB2;
    sb3        = GID_SW_SB3;
    sk1        = GID_SW_SK1;
    pl1        = GID_SW_PL1;
    bu3        = GID_SW_BU3;
    bu4        = GID_SW_BU4;
    tilewidth  = TILEWIDTH;
    tileheight = TILEHEIGHT;

    make_speedbar_list(GID_SW_SB1);
    load_aiss_images( 9,  9);
    load_aiss_images(18, 18);
    sw_getpens();
    if (GetColorBase)
    {   PaletteGroup =
        VLayoutObject,
            LAYOUT_Label,                                      "Colours",
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_BevelStyle,                                 BVS_GROUP,
            AddHLayout,
                AddColour(0),
                AddColour(1),
                AddColour(2),
                AddColour(3),
            LayoutEnd,
            AddHLayout,
                AddColour(4),
                AddColour(5),
                AddColour(6),
                AddColour(7),
            LayoutEnd,
            AddHLayout,
                AddColour(8),
                AddColour(9),
                AddColour(10),
                AddColour(11),
            LayoutEnd,
            AddHLayout,
                AddColour(12),
                AddColour(13),
                AddColour(14),
                AddColour(15),
            LayoutEnd,
            AddHLayout,
                AddColour(16),
                AddColour(17),
                AddColour(18),
                AddColour(19),
            LayoutEnd,
            AddHLayout,
                AddColour(20),
                AddColour(21),
                AddColour(22),
                AddColour(23),
            LayoutEnd,
            AddHLayout,
                AddColour(24),
                AddColour(25),
                AddColour(26),
                AddColour(27),
            LayoutEnd,
            AddHLayout,
                AddColour(28),
                AddColour(29),
                AddColour(30),
                AddColour(31),
            LayoutEnd,
        LayoutEnd;
    }

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_LockWidth,                                      TRUE,
        WINDOW_Position,                                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                    gadgets[GID_SW_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            AddHLayout,
                AddToolbar(GID_SW_SB1),
                AddSpace,
                CHILD_WeightedWidth,                           50,
                AddHLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    LAYOUT_AddChild,                           gadgets[GID_SW_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_SW_CH1,
                        GA_Disabled,                           TRUE,
                        CHOOSER_LabelArray,                    &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddSpace,
                CHILD_WeightedWidth,                           50,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                         BVS_GROUP,
                    LAYOUT_Label,                              "Level",
                    AddHLayout,
                        LAYOUT_AddChild,                       gadgets[GID_SW_LY2] = (struct Gadget*)
                        VLayoutObject,
                            LAYOUT_AddChild,                   gadgets[GID_SW_SP1] = (struct Gadget*)
                            SpaceObject,
                                GA_ID,                         GID_SW_SP1,
                                GA_Width,                      gamewidth[game] * magnifier,
                                GA_Height,                     tallness,
                                SPACE_BevelStyle,              BVS_NONE,
                                SPACE_Transparent,             TRUE,
                            SpaceEnd,
                            CHILD_MinWidth,                    gamewidth[game] * magnifier,
                            CHILD_MaxWidth,                    gamewidth[game] * magnifier,
                            CHILD_MinHeight,                   MINTALLNESS,
                            CHILD_MaxHeight,                   MAXTALLNESS,
                        LayoutEnd,
                        CHILD_WeightedWidth,                   100,
                        CHILD_WeightedHeight,                  100,
                        LAYOUT_AddChild,                       gadgets[GID_SW_SC1] = (struct Gadget*)
                        ScrollerObject,
                            GA_ID,                             GID_SW_SC1,
                            GA_RelVerify,                      TRUE,
                            SCROLLER_Orientation,              SORIENT_VERT,
                            SCROLLER_Arrows,                   TRUE,
                        ScrollerEnd,
                        CHILD_WeightedWidth,                   0,
                        CHILD_WeightedHeight,                  100,
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_AddChild,                           gadgets[GID_SW_LY3] = (struct Gadget*)
                    VLayoutObject,
                        LAYOUT_Label,                          "Tiles",
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_AddChild,                       gadgets[GID_SW_SP2] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                             GID_SW_SP2,
                            GA_Width,                          TILESWIDTH,
                            GA_Height,                         TILESHEIGHT,
                            SPACE_BevelStyle,                  BVS_NONE,
                            SPACE_Transparent,                 TRUE,
                        SpaceEnd,
                        CHILD_MinWidth,                        TILESWIDTH,
                        CHILD_MinHeight,                       TILESHEIGHT,
                        CHILD_MaxWidth,                        TILESWIDTH,
                        CHILD_MaxHeight,                       TILESHEIGHT,
                        LAYOUT_AddChild,                       gadgets[GID_SW_BU2] = (struct Gadget*)
                        ZButtonObject,
                            GA_ID,                             GID_SW_BU2,
                            GA_RelVerify,                      TRUE,
                            GA_Disabled,                       (SketchBoardBase ? FALSE : TRUE),
                            GA_Image,
                            LabelObject,
                                LABEL_Image,                   aissimage[18],
                                CHILD_NoDispose,               TRUE,
                                LABEL_DrawInfo,                DrawInfoPtr,
                                LABEL_VerticalAlignment,       LVALIGN_BASELINE,
                                LABEL_Text,                    " Edit Tile _Graphics... ",
                            LabelEnd,
                        ButtonEnd,
                        CHILD_WeightedHeight,                  0,
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                    PaletteGroup ? LAYOUT_AddChild : TAG_IGNORE, PaletteGroup,
                    LAYOUT_AddChild,                           gadgets[GID_SW_BU5] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                                 GID_SW_BU5,
                        GA_RelVerify,                          TRUE,
                        GA_Disabled,                           (SketchBoardBase ? FALSE : TRUE),
                        GA_Image,
                        LabelObject,
                            LABEL_Image,                       aissimage[18],
                            CHILD_NoDispose,                   TRUE,
                            LABEL_DrawInfo,                    DrawInfoPtr,
                            LABEL_VerticalAlignment,           LVALIGN_BASELINE,
                            LABEL_Justification,               LJ_CENTRE,
                            LABEL_Text,                        " Edit Title _Screen...",
                         LabelEnd,
                    ButtonEnd,
                    CHILD_WeightedHeight,                      0,
                    AddHLayout,
                        AddSpace,
                        ClearButton(GID_SW_BU1, "Clear Level"),
                        CHILD_WeightedWidth,                   0,
                        AddSpace, // to keep it away from sizing gadget
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_SW_SB1);

    setup_bm(0, gamewidth[game] * magnifier, MAXTALLNESS, MainWindowPtr);
    setup_bm(1, TILESWIDTH                  , TILESHEIGHT, MainWindowPtr);

    sw_resize();
    writegadgets();
    lmb = FALSE;
    loop();
    readgadgets();
    closewindow();
}

EXPORT void sw_loop(ULONG gid, UNUSED ULONG code)
{   UBYTE red, green, blue;
    int   xtile, ytile;

    switch (gid)
    {
    case GID_SW_SC1:
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_SW_SC1], (ULONG*) &scrolly);
        sw_drawmap(0, 0, TRUE);
    acase GID_SW_BU1:
        for (ytile = 0; ytile < mapheight[game]; ytile++)
        {   for (xtile = 0; xtile < mapwidth[game]; xtile++)
            {   IOBuffer[GETOFFSET(xtile, ytile, game)] = blank[game];
        }   }
        sw_drawmap(0, 0, TRUE);
    acase GID_SW_BU2:
        gfxwindow();
    acase GID_SW_BU5:
        titlemode = TRUE;
        gfxwindow();
        titlemode = FALSE;
    adefault:
        if (gid >= GID_SW_GC1 && gid <= GID_SW_GC32)
        {   // assert(GetColorBase);
            if (DoMethod((Object*) gadgets[gid], GCOLOR_REQUEST, MainWindowPtr))
            {   GetAttr(GETCOLOR_Color, (Object*) gadgets[gid], &gadcolour[gid - GID_SW_GC1]);
                switch (game)
                {
                case SIDEWINDER1:
                    Gfx_Buffer[ (gid - GID_SW_GC1) * 2     ] = ((gadcolour[(gid - GID_SW_GC1)] & 0x00F00000) >> 20);
                    Gfx_Buffer[((gid - GID_SW_GC1) * 2) + 1] = ((gadcolour[(gid - GID_SW_GC1)] & 0x0000F000) >>  8)
                                                             | ((gadcolour[(gid - GID_SW_GC1)] & 0x000000F0) >>  4);
                acase SIDEWINDER2:
                    red   = ((gadcolour[(gid - GID_SW_GC1)] & 0x00E00000) >> 21);
                    green = ((gadcolour[(gid - GID_SW_GC1)] & 0x0000E000) >> 13);
                    blue  = ((gadcolour[(gid - GID_SW_GC1)] & 0x000000E0) >>  5);
                    Title_Buffer[1 + gid - GID_SW_GC1] = (red   << 8)
                                                       | (green << 4)
                                                       |  blue;
                }
                sw_getpens();
                sw_drawmap(0, 0, TRUE);
}   }   }   }

EXPORT FLAG sw_open(FLAG loadas)
{   TRANSIENT FLAG   ok;
    TRANSIENT UBYTE  colour;
    TRANSIENT ULONG  oldgame;
    TRANSIENT BPTR   FileHandle /* = ZERO */ ;
    TRANSIENT int    i,
                     where,
                     x, xx,
                     y;
PERSIST const struct
{   const STRPTR first,
                 second;
} ch_names[6] = {
{ "level1.m", "level1.ch" },
{ "level2.m", "level2.ch" },
{ "level3.m", "level3.ch" },
{ "level4.m", "level4.ch" },
{ "level5.m", "level5.ch" },
{ "level6.m", "level5.ch" }, // this is no mistake
};

    oldgame = game;
    serializemode = SERIALIZE_READ;

    if (!gameopen(loadas))
    {   return FALSE;
    } // implied else

    switch (gamesize)
    {
    case 5928:
        game = SIDEWINDER1;

        ok = FALSE;
        for (i = 0; i < 6; i++)
        {   if (!stricmp(ch_names[i].first, FilePart(pathname)))
            {   zstrncpy(Gfx_Pathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
                if (!(AddPart(Gfx_Pathname, ch_names[i].second, MAX_PATH)))
                {   printf("Can't assemble pathname \"%s\"!\n", Gfx_Pathname);
                    return FALSE;
                }
                if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_OLDFILE)))
                {   printf("Can't open file \"%s\" for reading!\n", Gfx_Pathname);
                    return FALSE;
                }
                if (Read(FileHandle, Gfx_Buffer, 41024) != (LONG) 41024)
                {   DISCARD Close(FileHandle);
                    // FileHandle = ZERO;
                    printf("Can't read file \"%s\"!\n", Gfx_Pathname);
                    return FALSE;
                }
                DISCARD Close(FileHandle);
                // FileHandle = ZERO;
                ok = TRUE;
                break;
        }   }
        if (!ok)
        {   printf("Unrecognized filename \"%s\"!\n", FilePart(pathname));
            writegadgets();
            return FALSE;
        }

        magnifier = 1;
    acase 3120:
    case  3121:
        game = SIDEWINDER2;

        zstrncpy(Gfx_Pathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        if (!(AddPart(Gfx_Pathname, "block.dat", MAX_PATH)))
        {   printf("Can't assemble pathname \"%s\"!\n", Gfx_Pathname);
            return FALSE;
        }
        if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_OLDFILE)))
        {   printf("Can't open file \"%s\" for reading!\n", Gfx_Pathname);
            return FALSE;
        }
        if (Read(FileHandle, Gfx_Buffer, 32768) != (LONG) 32768)
        {   DISCARD Close(FileHandle);
            // FileHandle = ZERO;
            printf("Can't read file \"%s\"!\n", Gfx_Pathname);
            return FALSE;
        }
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;

        zstrncpy(Gfx_Pathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        if (!(AddPart(Gfx_Pathname, "title.pi1", MAX_PATH)))
        {   printf("Can't assemble pathname \"%s\"!\n", Gfx_Pathname);
            return FALSE;
        }
        if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_OLDFILE)))
        {   printf("Can't open file \"%s\" for reading!\n", Gfx_Pathname);
            return FALSE;
        }
        if (Read(FileHandle, Title_Buffer, 32066) != (LONG) 32066)
        {   DISCARD Close(FileHandle);
            // FileHandle = ZERO;
            printf("Can't read file \"%s\"!\n", Gfx_Pathname);
            return FALSE;
        }
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;

        for (y = 0; y < 200; y++)
        {   for (x = 0; x < 320; x++)
            {   where = 17              // header, palette
                      + (y * 80)        // 80 words, 160 bytes, 320 pixels per row
                      + ((x / 16) * 4); // fucked up Atari ST format
                xx = x % 16;
                colour = 0;
                if (Title_Buffer[where    ] & (0x8000 >> xx)) colour |= 1;
                if (Title_Buffer[where + 1] & (0x8000 >> xx)) colour |= 2;
                if (Title_Buffer[where + 2] & (0x8000 >> xx)) colour |= 4;
                if (Title_Buffer[where + 3] & (0x8000 >> xx)) colour |= 8;
                ScrnData[(y * 320) + x] = colour;
        }   }

#ifdef DOUBLESIZE
        magnifier = 2;
#else
        magnifier = 1;
#endif
    adefault:
        DisplayBeep(NULL);
        return FALSE;
    }

    for (i = 0; i < 256; i++)
    {   tileplanes[i] = planes[game];
    }
    sw_getpens();
    if (loaded == FUNC_SIDEWINDER && game != oldgame)
    {   sw_resize();
    }
    writegadgets();

    return TRUE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_SIDEWINDER
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;

    either_ch(GID_SW_CH1, &game);
    for (i = 16; i < 32; i++)
    {   DISCARD SetGadgetAttrs
        (   gadgets[GID_SW_GC1 + i], MainWindowPtr, NULL,
            GA_Disabled, (game == SIDEWINDER1) ? FALSE : TRUE,
        TAG_END); // this refreshes automatically
    }
    ghost(GID_SW_BU5, game != SIDEWINDER2);

    sw_drawmap(0, 0, TRUE);
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
}

EXPORT void sw_save(FLAG saveas)
{   UBYTE colour;
    int   where,
          x, xx,
          y;
    BPTR  FileHandle /* = ZERO */ ;

    readgadgets();
    serializemode = SERIALIZE_WRITE;

    switch (game)
    {
    case SIDEWINDER1:
        if (!gamesave("level?.m"  , "SideWinder 1", saveas,     5928, FLAG_G | FLAG_L, TRUE))
        {   return;
        }

        if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_NEWFILE)))
        {   printf("Can't open file \"%s\" for writing!\n", Gfx_Pathname);
            return;
        }
        DISCARD Write(FileHandle, Gfx_Buffer, 41024);
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;
    acase SIDEWINDER2:
        if (!gamesave("level?.dat", "SideWinder 2", saveas, gamesize, FLAG_G | FLAG_L, TRUE)) // 3120 or 3121
        {   return;
        }

        zstrncpy(Gfx_Pathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        if (!(AddPart(Gfx_Pathname, "block.dat", MAX_PATH)))
        {   printf("Can't assemble pathname %s!\n", Gfx_Pathname);
            return;
        }
        if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_NEWFILE)))
        {   printf("Can't open file \"%s\" for writing!\n", Gfx_Pathname);
            return;
        }
        DISCARD Write(FileHandle, Gfx_Buffer, 32768);
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;

        memset(&Title_Buffer[17], 0, 32000);
        for (y = 0; y < 200; y++)
        {   for (x = 0; x < 320; x++)
            {   colour = ScrnData[(y * 320) + x];
                where  = 17              // header, palette
                       + (y * 80)        // 80 words, 160 bytes, 320 pixels per row
                       + ((x / 16) * 4); // fucked up Atari ST format
                xx     = x % 16;
                if (colour & 1) Title_Buffer[where    ] |= (0x8000 >> xx);
                if (colour & 2) Title_Buffer[where + 1] |= (0x8000 >> xx);
                if (colour & 4) Title_Buffer[where + 2] |= (0x8000 >> xx);
                if (colour & 8) Title_Buffer[where + 3] |= (0x8000 >> xx);
        }   }

        zstrncpy(Gfx_Pathname, pathname, (size_t) (PathPart((STRPTR) pathname) - (STRPTR) pathname));
        if (!(AddPart(Gfx_Pathname, "title.pi1", MAX_PATH)))
        {   printf("Can't assemble pathname %s!\n", Gfx_Pathname);
            return;
        }
        if (!(FileHandle = (BPTR) Open(Gfx_Pathname, MODE_NEWFILE)))
        {   printf("Can't open file \"%s\" for writing!\n", Gfx_Pathname);
            return;
        }
        DISCARD Write(FileHandle, Title_Buffer, 32066);
        DISCARD Close(FileHandle);
        // FileHandle = ZERO;
    }

    say("Saved files.", REQIMAGE_INFO);
}

EXPORT void sw_close(void) { ; }

EXPORT void sw_exit(void)
{   sw_freepens();
}

EXPORT void sw_drawmap(int xtile, int ytile, FLAG full)
{   int   i,
          plane,
          x, y,
          xguest, yguest,
          minx, maxx,
          miny, maxy;
    UBYTE colour,
          whichtile;

    if (full)
    {   minx =
        miny = 0;
        maxx = (gamewidth[game] * magnifier) - 1;
        maxy = tallness                       - 1;
    } else
    {   minx = (xtile * TILEWIDTH  * magnifier);
        maxx =  minx + (TILEWIDTH  * magnifier) - 1;
        miny = (ytile * TILEHEIGHT * magnifier) - scrolly;
        maxy =  miny + (TILEHEIGHT * magnifier) - 1;
        if (miny <         0) miny = 0;
        if (maxy >= tallness) maxy = tallness - 1;
    }

    for (y = miny; y <= maxy; y++)
    {   for (x = minx; x <= maxx; x++)
        {   xtile  =             x  / (TILEWIDTH  * magnifier);
            ytile  =  (scrolly + y) / (TILEHEIGHT * magnifier);
            xguest =            (x  % (TILEWIDTH  * magnifier)) / magnifier;
            yguest = ((scrolly + y) % (TILEHEIGHT * magnifier)) / magnifier;
            whichtile = IOBuffer[GETOFFSET(xtile, ytile, game)];

            colour = (game == SIDEWINDER1) ? 0 : 16;
            for (plane = 0; plane < planes[game]; plane++)
            {   switch (game)
                {
                case SIDEWINDER1:
                    offset = 64
                           + (whichtile * 160)
                           + (yguest    *  10)
                           + (plane     *   2)
                           + (xguest    /   8);
                acase SIDEWINDER2:
                    offset = (whichtile * 128)
                           + (yguest    *   8)
                           + (plane     *   2)
                           + (xguest    /   8);
                }
                if (Gfx_Buffer[offset] & (128 >> (xguest % 8)))
                {   colour += (1 << plane);
            }   }
            *(byteptr1[y] + x) = pens[colour];
    }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_SW_SP1]->LeftEdge,
        gadgets[GID_SW_SP1]->TopEdge  + miny,
        gadgets[GID_SW_SP1]->LeftEdge + (gamewidth[game] * magnifier) - 1,
        gadgets[GID_SW_SP1]->TopEdge  + maxy,
        &display1[GFXINIT((gamewidth[game] * magnifier), miny)],
        &wpa8rastport[0]
    );

    if (!full)
    {   return;
    }

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SW_SC1], MainWindowPtr, NULL,
        SCROLLER_Top, scrolly,
    TAG_END); // this refreshes automatically

    if (GetColorBase)
    {   for (i = 0; i < 32; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_SW_GC1 + i], MainWindowPtr, NULL,
                GETCOLOR_Color, gadcolour[i],
            TAG_DONE);
            RefreshGadgets((struct Gadget*) gadgets[GID_SW_GC1 + i], MainWindowPtr, NULL); // this might autorefresh
    }   }

    updatetiles();
}

EXPORT UBYTE sw_getpixel(int x, int y)
{   UBYTE colour = 0;
    int   plane;

    for (plane = 0; plane < planes[game]; plane++)
    {   switch (game)
        {
        case SIDEWINDER1:
            offset = 64
                   + (stamp * 160)
                   + (y     *  10)
                   + (plane *   2)
                   + (x     /   8);
        acase SIDEWINDER2:
            offset = (stamp * 128)
                   + (y     *   8)
                   + (plane *   2)
                   + (x     /   8);
        }
        if (Gfx_Buffer[offset] & (128 >> (x % 8)))
        {   colour += (1 << plane);
    }   }

    return colour;
}

MODULE void updatetiles(void)
{   UBYTE whichtile;
    int   colour,
          plane,
          x,  y,
          xx, yy;

    for (y = 0; y < TILESY; y++)
    {   for (x = 0; x < TILESX; x++)
        {   whichtile = (y * TILESX) + x;
            for (yy = 0; yy < TILEHEIGHT; yy++)
            {   for (xx = 0; xx < TILEWIDTH; xx++)
                {   if (stamp == whichtile && (xx <= 1 || xx >= TILEWIDTH - 2 || yy <= 1 || yy >= TILEHEIGHT - 2))
                    {   colour = 32; // purple
                    } else
                    {   colour = (game == SIDEWINDER1) ? 0 : 16;
                        for (plane = 0; plane < planes[game]; plane++)
                        {   switch (game)
                            {
                            case SIDEWINDER1:
                                offset = 64
                                       + (whichtile * 160)
                                       + (yy        *  10)
                                       + (plane     *   2)
                                       + (xx        /   8);
                            acase SIDEWINDER2:
                                offset = (whichtile * 128)
                                       + (yy        *   8)
                                       + (plane     *   2)
                                       + (xx        /   8);
                            }
                            if (Gfx_Buffer[offset] & (128 >> (xx % 8)))
                            {   colour += (1 << plane);
                    }   }   }
                    *(byteptr2[(y * TILEHEIGHT) + yy] + (x * TILEWIDTH) + xx) = pens[colour];
    }   }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_SW_SP2]->LeftEdge,
        gadgets[GID_SW_SP2]->TopEdge,
        gadgets[GID_SW_SP2]->LeftEdge + TILESWIDTH  - 1,
        gadgets[GID_SW_SP2]->TopEdge  + TILESHEIGHT - 1,
        display2,
        &wpa8rastport[1]
    );
}

EXPORT void sw_key(UBYTE scancode, UWORD qual)
{   int oldy;

    oldy = scrolly;

    if
    (   scancode == SCAN_UP
     || scancode == SCAN_N8
     || scancode == NM_WHEEL_UP
    )
    {   MOVE_UP(  qual, &scrolly, 1 * TILEHEIGHT * magnifier, 10 * TILEHEIGHT * magnifier);
    } elif
    (   scancode == SCAN_DOWN
     || scancode == SCAN_N5
     || scancode == SCAN_N2
     || scancode == NM_WHEEL_DOWN
    )
    {   MOVE_DOWN(qual, &scrolly, 1 * TILEHEIGHT * magnifier, 10 * TILEHEIGHT * magnifier, (gameheight[game] * magnifier) - tallness);
    }

    if (scrolly != oldy)
    {   sw_drawmap(0, 0, TRUE);
}   }

EXPORT void sw_uniconify(void)
{   sw_getpens();
    sw_drawmap(0, 0, TRUE);
}

EXPORT void sw_getpens(void)
{   TRANSIENT UBYTE red, green, blue;
    TRANSIENT int i;
PERSIST const UWORD idealcolour[17] = {
0x000,
0x048,
0x28C,
0x6CE,
0xEE0,
0xEEE,
0x000,
0x444,
0x666,
0x888,
0xAAA,
0xCCC,
0x800,
0xE00,
0xE60,
0xE80,
0xF0F, // purple
};

    sw_freepens();
    lockscreen();
    gotallpens = TRUE;

    switch (game)
    {
    case SIDEWINDER1:
        for (i = 0; i < 32; i++)
        {   pens[i] = (LONG) ObtainPen
            (   ScreenPtr->ViewPort.ColorMap,
                (ULONG) -1,
                ( Gfx_Buffer[ i * 2     ] & 0x0F      ) * 0x11111111,
                ((Gfx_Buffer[(i * 2) + 1] & 0xF0) >> 4) * 0x11111111,
                ( Gfx_Buffer[(i * 2) + 1] & 0x0F      ) * 0x11111111,
                PEN_EXCLUSIVE
            );
            if (pens[i] >= 0 && pens[i] <= 255)
            {   gotpen[i] = TRUE;
                convert[pens[i]] = i;
            } else
            {   gotallpens = FALSE;
                pens[i] = FindColor
                (   ScreenPtr->ViewPort.ColorMap,
                    ( Gfx_Buffer[ i * 2     ] & 0x0F      ) * 0x11111111,
                    ((Gfx_Buffer[(i * 2) + 1] & 0xF0) >> 4) * 0x11111111,
                    ( Gfx_Buffer[(i * 2) + 1] & 0x0F      ) * 0x11111111,
                    -1
                );
            }

            // 0RGB -> 00RRGGBB
            gadcolour[i] = ((Gfx_Buffer[ i * 2     ] & 0x0F) << 20)  // R
                         | ((Gfx_Buffer[ i * 2     ] & 0x0F) << 16)  //  R
                         | ((Gfx_Buffer[(i * 2) + 1] & 0xF0) <<  8)  //   G
                         | ((Gfx_Buffer[(i * 2) + 1] & 0xF0) <<  4)  //    G
                         | ((Gfx_Buffer[(i * 2) + 1] & 0x0F) <<  4)  //     B
                         | ( Gfx_Buffer[(i * 2) + 1] & 0x0F       ); //      B
        }
    acase SIDEWINDER2:
        for (i = 0; i < 16; i++)
        {   // convert from 3-bit to 8-bit colour
            red   = ((Title_Buffer[1 + i] & 0x700) >> 3);
            if (red & 0x20)
            {   red |= 0x1F;
            }
            green = ((Title_Buffer[1 + i] & 0x070) << 1);
            if (green & 0x20)
            {   green |= 0x1F;
            }
            blue  = ((Title_Buffer[1 + i] & 0x007) << 5);
            if (blue & 0x20)
            {   blue |= 0x1F;
            }

            pens[i] = (LONG) ObtainPen
            (   ScreenPtr->ViewPort.ColorMap,
                (ULONG) -1,
                red   * 0x01010101,
                green * 0x01010101,
                blue  * 0x01010101,
                PEN_EXCLUSIVE
            );
            if (pens[i] >= 0 && pens[i] <= 255)
            {   gotpen[i] = TRUE;
            } else
            {   gotallpens = FALSE;
                pens[i] = FindColor
                (   ScreenPtr->ViewPort.ColorMap,
                    red   * 0x01010101,
                    green * 0x01010101,
                    blue  * 0x01010101,
                    -1
                );
            }
            convert[pens[i]] = i;

            gadcolour[     i] = (red   << 16)
                              | (green <<  8)
                              |  blue;

            // convert from 4-bit to 8-bit colour
            red   = ((idealcolour[i] & 0xF00) >> 4);
            if (red & 0x10)
            {   red |= 0x0F;
            }
            green =  (idealcolour[i] & 0x0F0);
            if (green & 0x10)
            {   green |= 0x0F;
            }
            blue  = ((idealcolour[i] & 0x00F) << 4);
            if (blue & 0x10)
            {   blue |= 0x0F;
            }

            gadcolour[16 + i] = (red   << 16)
                              | (green <<  8)
                              |  blue;
    }   }

    unlockscreen();
    if (!gotallpens)
    {   sw_freepens();
    }

    lockscreen();
    for (i = ((game == SIDEWINDER2) ? 0 : 16); i < 17; i++)
    {   pens[16 + i] = FindColor
        (   ScreenPtr->ViewPort.ColorMap,
            ((idealcolour[i] & 0x0F00) >> 8) * 0x11111111,
            ((idealcolour[i] & 0x00F0) >> 4) * 0x11111111,
             (idealcolour[i] & 0x000F)       * 0x11111111,
            -1
        );
    }
    unlockscreen();
}

EXPORT void sw_freepens(void)
{   int i;

    lockscreen();
    for (i = 0; i < 32; i++) // always do all 32 colours
    {   if (gotpen[i])
        {   ReleasePen(ScreenPtr->ViewPort.ColorMap, (ULONG) pens[i]);
            gotpen[i] = FALSE;
    }   }
    unlockscreen();
    gotallpens = FALSE;
}

EXPORT void sw_resize(void)
{   int y;

    tallness = gadgets[GID_SW_LY2]->Height;
    if (tallness >  MAXTALLNESS                             ) tallness =  MAXTALLNESS;
    if (scrolly  > (gameheight[game] * magnifier) - tallness) scrolly  = (gameheight[game] * magnifier) - tallness;

    DISCARD SetGadgetAttrs
    (   gadgets[GID_SW_SC1], MainWindowPtr, NULL,
        SCROLLER_Visible, tallness,
        SCROLLER_Top,     scrolly,
        SCROLLER_Total,   gameheight[game] * magnifier,
    TAG_END); // this refreshes automatically

    for (y = 0; y < tallness; y++)
    {   byteptr1[y] = &display1[GFXINIT((gamewidth[game] * magnifier), y)];
    }
    for (y = 0; y < TILESHEIGHT; y++)
    {   byteptr2[y] = &display2[GFXINIT(TILESWIDTH, y)];
}   }

EXPORT void sw_lmb(SWORD mousex, SWORD mousey, UWORD code)
{   TRANSIENT UBYTE whichtile;
    TRANSIENT int   xtile, ytile;
    PERSIST   ULONG oldsecs,
                    oldmicros,
                    newsecs   = 0,
                    newmicros = 0;

    if (code == SELECTUP)
    {   lmb = FALSE;
    } elif (code == SELECTDOWN) // this doesn't repeat
    {   lmb = TRUE;

        if (mouseisover(GID_SW_SP1, mousex, mousey))
        {   xtile     = (mousex - gadgets[GID_SW_SP1]->LeftEdge         ) / (TILEWIDTH  * magnifier);
            ytile     = (mousey - gadgets[GID_SW_SP1]->TopEdge + scrolly) / (TILEHEIGHT * magnifier);
            whichtile = IOBuffer[GETOFFSET(xtile, ytile, game)];
            if (whichtile != stamp)
            {   IOBuffer[GETOFFSET(xtile, ytile, game)] = stamp;
                sw_drawmap(xtile, ytile, FALSE);
        }   }
        elif (mouseisover(GID_SW_SP2, mousex, mousey))
        {   xtile     = (mousex - gadgets[GID_SW_SP2]->LeftEdge         ) / TILEWIDTH;
            ytile     = (mousey - gadgets[GID_SW_SP2]->TopEdge          ) / TILEHEIGHT;
            oldsecs   = newsecs;
            oldmicros = newmicros;
            CurrentTime(&newsecs, &newmicros);

            if
            (   xtile == stamp % TILESX
             && ytile == stamp / TILESX
             && DoubleClick(oldsecs, oldmicros, newsecs, newmicros)
             && SketchBoardBase
             && gotallpens
            )
            {   gfxwindow();
                lmb = FALSE;
            } else
            {   stamp = (ytile * TILESX) + xtile;
                updatetiles();
}   }   }   }

EXPORT void sw_mouse(SWORD mousex, SWORD mousey)
{   UBYTE whichtile;
    int   xtile, ytile;

    if (lmb && mouseisover(GID_SW_SP1, mousex, mousey))
    {   xtile     = (mousex - gadgets[GID_SW_SP1]->LeftEdge         ) / (TILEWIDTH  * magnifier);
        ytile     = (mousey - gadgets[GID_SW_SP1]->TopEdge + scrolly) / (TILEHEIGHT * magnifier);
        whichtile = IOBuffer[GETOFFSET(xtile, ytile, game)];
        if (whichtile != stamp)
        {   IOBuffer[GETOFFSET(xtile, ytile, game)] = stamp;
            sw_drawmap(xtile, ytile, FALSE);
}   }   }

EXPORT void sw_tick(SWORD mousex, SWORD mousey)
{   if
    (   mouseisover(GID_SW_SP1, mousex, mousey)
     || mouseisover(GID_SW_SP2, mousex, mousey)
    )
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
}   }

EXPORT void sw_realpen_to_table(void)
{   fgpen_real    = convert[fgpen_real];
    fgpen_intable = fgpen_real;
}
EXPORT void sw_tablepen_to_real(void)
{   fgpen_real = fgpen_intable;
}

EXPORT void sw_readtitlescreen(void)
{   int x, y;

    for (y = 0; y < 200; y++)
    {   ReadPixelLine8
        (   &sketchrastport,
            0, y,
            320 - 1,
            &ScrnData[y * 320],
            &wpa8tilerastport
        );
        for (x = 0; x < 320; x++)
        {   ScrnData[(y * 320) + x] = convert[
            ScrnData[(y * 320) + x]          ];
}   }   }

EXPORT void sw_readsketchboard(UBYTE* data)
{   int plane,
        x, y;

    for (y = 0; y < tileheight; y++)
    {   for (x = 0; x < tilewidth; x++)
        {   data[(y * tilewidth) + x] = convert[
            data[(y * tilewidth) + x]];
            for (plane = 0; plane < planes[game]; plane++)
            {   switch (game)
                {
                case SIDEWINDER1:
                    offset = 64
                           + (stamp * 160)
                           + (y     *  10)
                           + (plane *   2)
                           + (x     /   8);
                acase SIDEWINDER2:
                    offset = (stamp * 128)
                           + (y     *   8)
                           + (plane *   2)
                           + (x     /   8);
                }
                if (data[(y * tilewidth) + x] & (1 << plane))
                {   Gfx_Buffer[offset] |= (0x80 >> (x % 8));
                } else
                {   Gfx_Buffer[offset] &= ~(0x80 >> (x % 8));
}   }   }   }   }
