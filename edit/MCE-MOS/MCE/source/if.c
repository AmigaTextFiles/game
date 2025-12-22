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
#define GID_IF_LY1  0 // root layout
#define GID_IF_LY2  1 // map
#define GID_IF_LY3  2 // tiles
#define GID_IF_SB1  3 // toolbar
#define GID_IF_SP1  4 // map
#define GID_IF_SP2  5 // tiles
#define GID_IF_SC1  6 // map
#define GID_IF_IN1  7 // level
#define GID_IF_SL1  8 // level
#define GID_IF_BU1  9 // clear level
#define GID_IF_BU2 10 // edit tile graphics

// graphics editor
#define GID_IF_SK1 11 // editor
#define GID_IF_PL1 12 // colour
#define GID_IF_SB2 13 // command bar
#define GID_IF_SB3 14 // paint bar
#define GID_IF_BU3 15 // OK
#define GID_IF_BU4 16 // cancel

#define GIDS_IF    GID_IF_BU4

#define TILEWIDTH   32
#define TILEHEIGHT  20
#define TILESX       5
#define TILESY      22
#define TILESWIDTH   (TILESX * TILEWIDTH ) //  160 pixels
#define TILESHEIGHT  (TILESY * TILEHEIGHT) //  440 pixels
#define TOTALWIDTH   (    10 * TILEWIDTH ) //  320 pixels
#define TOTALHEIGHT  (   409 * TILEHEIGHT) // 8180 pixels
#define MINTALLNESS  (    22 * TILEHEIGHT) //  440 pixels
#define MAXTALLNESS  (    51 * TILEHEIGHT) // 1020 pixels

#define GETOFFSET(a, b, c) (0x91000 + (((c) - 1) * 4096) + ((409 - (b)) * 10) - (a))

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void if_drawmappart(int x, int y);
MODULE void updatetiles(void);
MODULE void if_gfxwindow(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  bu3, bu4, pl1, sb2, sb3, sk1,
                            function,
                            gadmode,
                            loaded,
                            page,
                            penoffset,
                            serializemode,
                            stringextra,
                            tilewidth,
                            tileheight;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT UBYTE                convert[256],
                            IOBuffer[IOBUFFERSIZE],
                            stamp,
                            tileplanes[256];
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT ULONG                fgpen_intable,
                            fgpen_real,
                            offset,
                            showtoolbar;
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

MODULE FLAG                 lmb        = FALSE;
MODULE ULONG                level      = 1;
MODULE int                  scrolly    = 0,
                            tallness   = MINTALLNESS;

MODULE const int tileset[18] =
{ 0, //  1st level
  0, //  2nd
  1, //  3rd
  0, //  4th
  1, //  5th
  2, //  6th
  1, //  7th
  2, //  8th
  2, //  9th
  0, // 10th
  2, // 11th
  1, // 12th
  1, // 13th
  0, // 14th
  2, // 15th
  1, // 16th
  0, // 17th
  2, // 18th
};

/* 7. MODULE STRUCTURES --------------------------------------------------

(none)

8. CODE --------------------------------------------------------------- */

EXPORT void if_main(void)
{   int   i;
    ULONG idcmp1, idcmp2;

    tool_open      = if_open;
    tool_loop      = if_loop;
    tool_save      = if_save;
    tool_close     = if_close;
    tool_exit      = if_exit;
    tool_subgadget = sketchboard_subgadget;

    if (loaded != FUNC_IF)
    {   stamp = 0x3B;
        if (!if_open(TRUE))
        {   function = page = FUNC_MENU;
            return;
        } // implied else
        loaded = FUNC_IF;
    }

    bu3        = GID_IF_BU3;
    bu4        = GID_IF_BU4;
    pl1        = GID_IF_PL1;
    sb2        = GID_IF_SB2;
    sb3        = GID_IF_SB3;
    sk1        = GID_IF_SK1;
    tilewidth  = TILEWIDTH;
    tileheight = TILEHEIGHT;
    for (i = 0; i < 256; i++)
    {   tileplanes[i] = 3;
    }

    make_speedbar_list(GID_IF_SB1);
    load_aiss_images( 9,  9);
    load_aiss_images(18, 18);

    if_getpens();

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WINDOW_LockWidth,                                      TRUE,
        WINDOW_Position,                                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                    gadgets[GID_IF_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            AddToolbar(GID_IF_SB1),
            AddHLayout,
                LAYOUT_VertAlignment,                          LALIGN_CENTER,
                LAYOUT_AddChild,                               gadgets[GID_IF_IN1] = (struct Gadget*)
                IntegerObject,
                    GA_ID,                                     GID_IF_IN1,
                    GA_TabCycle,                               TRUE,
                    GA_RelVerify,                              TRUE,
                    INTEGER_Minimum,                           1,
                    INTEGER_Maximum,                           18,
                    INTEGER_MinVisible,                        2 + 1,
                    INTEGER_Number,                            level,
                IntegerEnd,
                CHILD_WeightedWidth,                           0,
                Label("Level:"),
                LAYOUT_AddChild,                               gadgets[GID_IF_SL1] = (struct Gadget*)
                SliderObject,
                    GA_ID,                                     GID_IF_SL1,
                    GA_RelVerify,                              TRUE,
                    SLIDER_Min,                                1,
                    SLIDER_Max,                                18,
                    SLIDER_KnobDelta,                          1,
                    SLIDER_Orientation,                        SLIDER_HORIZONTAL,
                    SLIDER_Ticks,                              18, // how many ticks to display
                    SLIDER_Level,                              level,
                SliderEnd,
                AddLabel("of 18"),
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                AddVLayout,
                    LAYOUT_BevelStyle,                         BVS_GROUP,
                    LAYOUT_Label,                              "Level",
                    AddHLayout,
                        LAYOUT_AddChild,                       gadgets[GID_IF_LY2] = (struct Gadget*)
                        VLayoutObject,
                            LAYOUT_AddChild,                   gadgets[GID_IF_SP1] = (struct Gadget*)
                            SpaceObject,
                                GA_ID,                         GID_IF_SP1,
                                GA_Width,                      TOTALWIDTH,
                                GA_Height,                     tallness,
                                SPACE_BevelStyle,              BVS_NONE,
                                SPACE_Transparent,             TRUE,
                            SpaceEnd,
                            CHILD_MinWidth,                    TOTALWIDTH,
                            CHILD_MaxWidth,                    TOTALWIDTH,
                            CHILD_MinHeight,                   MINTALLNESS,
                            CHILD_MaxHeight,                   MAXTALLNESS,
                        LayoutEnd,
                        CHILD_WeightedWidth,                   100,
                        CHILD_WeightedHeight,                  100,
                        LAYOUT_AddChild,                       gadgets[GID_IF_SC1] = (struct Gadget*)
                        ScrollerObject,
                            GA_ID,                             GID_IF_SC1,
                            GA_RelVerify,                      TRUE,
                            SCROLLER_Orientation,              SORIENT_VERT,
                            SCROLLER_Arrows,                   TRUE,
                        ScrollerEnd,
                        CHILD_WeightedWidth,                   0,
                        CHILD_WeightedHeight,                  100,
                    LayoutEnd,
                LayoutEnd,
                AddVLayout,
                    LAYOUT_AddChild,                           gadgets[GID_IF_LY3] = (struct Gadget*)
                    VLayoutObject,
                        LAYOUT_Label,                          "Tiles",
                        LAYOUT_SpaceOuter,                     TRUE,
                        LAYOUT_BevelStyle,                     BVS_GROUP,
                        LAYOUT_AddChild,                       gadgets[GID_IF_SP2] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                             GID_IF_SP2,
                            GA_Width,                          TILESWIDTH,
                            GA_Height,                         TILESHEIGHT,
                            SPACE_BevelStyle,                  BVS_NONE,
                            SPACE_Transparent,                 TRUE,
                        SpaceEnd,
                        CHILD_MinWidth,                        TILESWIDTH,
                        CHILD_MinHeight,                       TILESHEIGHT,
                        CHILD_MaxWidth,                        TILESWIDTH,
                        CHILD_MaxHeight,                       TILESHEIGHT,
                    LayoutEnd,
                    CHILD_WeightedHeight,                      0,
                    LAYOUT_AddChild,                           gadgets[GID_IF_BU2] = (struct Gadget*)
                    ZButtonObject,
                        GA_ID,                                 GID_IF_BU2,
                        GA_RelVerify,                          TRUE,
                        GA_Disabled,                           (SketchBoardBase ? FALSE : TRUE),
                        GA_Image,
                        LabelObject,
                            LABEL_Image,                       aissimage[18],
                            CHILD_NoDispose,                   TRUE,
                            LABEL_DrawInfo,                    DrawInfoPtr,
                            LABEL_VerticalAlignment,           LVALIGN_BASELINE,
                            LABEL_Text,                        " _Edit Graphics... ",
                        LabelEnd,
                    ButtonEnd,
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                    AddHLayout,
                        AddSpace,
                        ClearButton(GID_IF_BU1, "Clear Level"),
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
    openwindow(GID_IF_SB1);
    setup_bm(0, TOTALWIDTH, MAXTALLNESS, MainWindowPtr);
    setup_bm(1, TILESWIDTH, TILESHEIGHT, MainWindowPtr);
    if_resize();
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

    readgadgets();
    closewindow();
}

EXPORT void if_loop(ULONG gid, UNUSED ULONG code)
{   UBYTE blank;
    int   xtile, ytile;

    switch (gid)
    {
    case GID_IF_SC1:
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_IF_SC1], (ULONG*) &scrolly);
        if_drawmap();
    acase GID_IF_SL1:
        gadmode = SERIALIZE_READ;
        either_sl(GID_IF_SL1, &level);
        gadmode = SERIALIZE_WRITE;
        either_in(GID_IF_IN1, &level);
        if_drawmap();
    acase GID_IF_IN1:
        gadmode = SERIALIZE_READ;
        either_in(GID_IF_IN1, &level);
        gadmode = SERIALIZE_WRITE;
        either_sl(GID_IF_SL1, &level);
        if_drawmap();
    acase GID_IF_BU1:
        if   (tileset[level - 1] == 0) blank = 0x3B;
        elif (tileset[level - 1] == 1) blank = 0x45;
        else                           blank = 0x54;
        for (ytile = 0; ytile < 409; ytile++)
        {   for (xtile = 0; xtile < 10; xtile++)
            {   IOBuffer[GETOFFSET(xtile, ytile, level)] = blank;
        }   }
        if_drawmap();
    acase GID_IF_BU2:
        if_gfxwindow();
}   }

EXPORT FLAG if_open(FLAG loadas)
{   if (gameopen(loadas))
    {   serializemode = SERIALIZE_READ;
        writegadgets();
        return TRUE;
    } // implied else
    return FALSE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_IF
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    if_drawmap();
}

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
}

EXPORT void if_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    gamesave("#?Disk.1#?", "Insanity Fight", saveas, 901120, FLAG_L, FALSE);
}

EXPORT void if_close(void) { ; }
EXPORT void if_exit(void)  { ; }

EXPORT void if_drawmap(void)
{   UBYTE whichtile;
    int   colour,
          plane,
          x, y,
          xx, yy,
          xtile, ytile;

    for (y = 0; y < tallness; y++)
    {   for (x = 0; x < TOTALWIDTH; x++)
        {   xtile     =            x  / TILEWIDTH;
            ytile     = (scrolly + y) / TILEHEIGHT;
            whichtile = IOBuffer[GETOFFSET(xtile, ytile, level)];
            xx        =            x  % TILEWIDTH;
            yy        = (scrolly + y) % TILEHEIGHT;

            if (whichtile <= 0x6D)
            {   colour = tileset[level - 1] * 8;
                for (plane = 0; plane < 3; plane++)
                {   offset = 0xA3000
                           + (tileset[level - 1] * 26624)
                           + ( plane             *  8800)  // bytes per plane
                           + ((whichtile / 10)   *   800)
                           + ( yy                *    40)  // bytes per pixel row
                           + ((whichtile % 10)   *     4)
                           + ( xx                /     8); // bytes per pixel column
                    if (IOBuffer[offset] & (128 >> (xx % 8)))
                    {   colour += (1 << plane);
            }   }   }
            else
            {   colour = 24; // purple
            }
            *(byteptr1[y] + (xtile * TILEWIDTH) + xx) = pens[colour];
    }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_IF_SP1]->LeftEdge,
        gadgets[GID_IF_SP1]->TopEdge,
        gadgets[GID_IF_SP1]->LeftEdge + TOTALWIDTH - 1,
        gadgets[GID_IF_SP1]->TopEdge  + tallness   - 1,
        display1,
        &wpa8rastport[0]
    );

    DISCARD SetGadgetAttrs
    (   gadgets[GID_IF_SC1], MainWindowPtr, NULL,
        SCROLLER_Top, scrolly,
    TAG_END); // this refreshes automatically

    updatetiles();
}

MODULE void if_drawmappart(int x, int y)
{   int   miny, maxy,
          plane,
          topy,
          xx, yy;
    UBYTE colour,
          whichtile;

    topy = (y * TILEHEIGHT) - scrolly; // top edge of tile in gadget coords
    if (topy              <        0) miny = -topy               ; else miny =              0;
    if (topy + TILEHEIGHT > tallness) maxy = -topy + tallness - 1; else maxy = TILEHEIGHT - 1;

    // assert(miny >=          0);
    // assert(maxy <  TILEHEIGHT);

    whichtile = IOBuffer[GETOFFSET(x, y, level)];
    for (yy = miny; yy <= maxy; yy++)
    {   for (xx = 0; xx < TILEWIDTH; xx++)
        {   if (whichtile <= 0x6D)
            {   colour  = tileset[level - 1] * 8;
                for (plane = 0; plane < 3; plane++)
                {   offset = 0xA3000
                           + (tileset[level - 1] * 26624)
                           + ( plane             *  8800)  // bytes per plane
                           + ((whichtile / 10)   *   800)
                           + ( yy                *    40)  // bytes per pixel row
                           + ((whichtile % 10)   *     4)
                           + ( xx                /     8); // bytes per pixel column
                    if (IOBuffer[offset] & (128 >> (xx % 8)))
                    {   colour += (1 << plane);
            }   }   }
            else
            {   colour = 24; // purple
            }
            *(byteptr1[topy + yy] + (x * TILEWIDTH) + xx) = pens[colour];
    }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_IF_SP1]->LeftEdge,
        gadgets[GID_IF_SP1]->TopEdge  + topy + miny,
        gadgets[GID_IF_SP1]->LeftEdge + TOTALWIDTH -  1,
        gadgets[GID_IF_SP1]->TopEdge  + topy + maxy,
        &display1[GFXINIT(TOTALWIDTH, (topy + miny))],
        &wpa8rastport[0]
    );
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
                    {   colour = 24; // purple
                    } else
                    {   // assert(whichtile <= 0x6D);
                        colour    = tileset[level - 1] * 8;
                        for (plane = 0; plane < 3; plane++)
                        {   offset = 0xA3000
                                   + (tileset[level - 1] * 26624)
                                   + ( plane             *  8800)  // bytes per plane
                                   + ((whichtile / 10)   *   800)
                                   + ( yy                *    40)  // bytes per pixel row
                                   + ((whichtile % 10)   *     4)
                                   + ( xx                /     8); // bytes per pixel column
                            if (IOBuffer[offset] & (128 >> (xx % 8)))
                            {   colour += (1 << plane);
                    }   }   }
                    *(byteptr2[(y * TILEHEIGHT) + yy] + (x * TILEWIDTH) + xx) = pens[colour];
    }   }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_IF_SP2]->LeftEdge,
        gadgets[GID_IF_SP2]->TopEdge,
        gadgets[GID_IF_SP2]->LeftEdge + TILESWIDTH  - 1,
        gadgets[GID_IF_SP2]->TopEdge  + TILESHEIGHT - 1,
        display2,
        &wpa8rastport[1]
    );
}

EXPORT void if_key(UBYTE scancode, UWORD qual)
{   int oldy;

    oldy = scrolly;

    switch (scancode)
    {
    case  SCAN_UP:
    case  SCAN_N8:
    case  NM_WHEEL_UP:
        MOVE_UP(       qual, &scrolly, 1 * TILEHEIGHT, 10 * TILEHEIGHT);
    acase SCAN_DOWN:
    case  SCAN_N5:
    case  SCAN_N2:
    case  NM_WHEEL_DOWN:
        MOVE_DOWN(     qual, &scrolly, 1 * TILEHEIGHT, 10 * TILEHEIGHT, TOTALHEIGHT - tallness);
    acase SCAN_LEFT:
    case  SCAN_N4:
        if (level == 1)
        {   level = 18;
        } else
        {   level--;
        }
        gadmode = SERIALIZE_WRITE;
        either_sl(GID_IF_SL1, &level);
        either_in(GID_IF_IN1, &level);
        if_drawmap();
    acase SCAN_RIGHT:
    case  SCAN_N6:
        if (level == 18)
        {   level = 1;
        } else
        {   level++;
        }
        gadmode = SERIALIZE_WRITE;
        either_sl(GID_IF_SL1, &level);
        either_in(GID_IF_IN1, &level);
        if_drawmap();
    acase SCAN_E:
        if_gfxwindow();
    }

    if (scrolly != oldy)
    {   if_drawmap();
}   }

EXPORT void if_uniconify(void)
{   if_getpens();
    if_drawmap();
}

EXPORT void if_getpens(void)
{   TRANSIENT int i;
PERSIST const UWORD idealcolour[26] =
{ 0x000, 0x0A0, 0x097, 0xF00, 0xB86, 0x865, 0x643, 0xFDA, // 1st tileset
  0x000, 0x0A0, 0x08F, 0x070, 0xDA6, 0x333, 0x642, 0x555, // 2nd tileset
  0x000, 0xBFF, 0x08F, 0x0DF, 0x244, 0x455, 0x689, 0xFFF, // 3rd tileset
  0xF0F,                                                  // editor
};

    lockscreen();
    for (i = 0; i < 25; i++)
    {   pens[i] = FindColor
        (   ScreenPtr->ViewPort.ColorMap,
            ((idealcolour[i] & 0x0F00) >> 8) * 0x11111111,
            ((idealcolour[i] & 0x00F0) >> 4) * 0x11111111,
            ((idealcolour[i] & 0x000F)     ) * 0x11111111,
            -1
        );
        convert[pens[i]] = i;
    }
    unlockscreen();
}

EXPORT void if_resize(void)
{   int y;

    tallness = gadgets[GID_IF_LY2]->Height;
    if (tallness > MAXTALLNESS           ) tallness = MAXTALLNESS;
    if (scrolly  > TOTALHEIGHT - tallness) scrolly  = TOTALHEIGHT - tallness;

    DISCARD SetGadgetAttrs
    (   gadgets[GID_IF_SC1], MainWindowPtr, NULL,
        SCROLLER_Visible, tallness,
        SCROLLER_Top,     scrolly,
        SCROLLER_Total,   TOTALHEIGHT,
    TAG_END); // this refreshes automatically

    for (y = 0; y < tallness; y++)
    {   byteptr1[y] = &display1[GFXINIT(TOTALWIDTH , y)];
    }
    for (y = 0; y < TILESHEIGHT; y++)
    {   byteptr2[y] = &display2[GFXINIT(TILESWIDTH, y)];
}   }

EXPORT void if_mb(SWORD mousex, SWORD mousey, UWORD code)
{   TRANSIENT UBYTE blank,
                    whichtile;
    TRANSIENT int   xtile, ytile;
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

        if (mouseisover(GID_IF_SP1, mousex, mousey))
        {   xtile     = (mousex - gadgets[GID_IF_SP1]->LeftEdge         ) / TILEWIDTH;
            ytile     = (mousey - gadgets[GID_IF_SP1]->TopEdge + scrolly) / TILEHEIGHT;
            whichtile = IOBuffer[GETOFFSET(xtile, ytile, level)];
            if (whichtile != stamp)
            {   IOBuffer[GETOFFSET(xtile, ytile, level)] = stamp;
                if_drawmappart(xtile, ytile);
        }   }
        elif (mouseisover(GID_IF_SP2, mousex, mousey))
        {   xtile     = (mousex - gadgets[GID_IF_SP2]->LeftEdge         ) / TILEWIDTH;
            ytile     = (mousey - gadgets[GID_IF_SP2]->TopEdge          ) / TILEHEIGHT;
            oldsecs   = newsecs;
            oldmicros = newmicros;
            CurrentTime(&newsecs, &newmicros);
            if
            (   stamp % TILESX == xtile
             && stamp / TILESX == ytile
             && DoubleClick(oldsecs, oldmicros, newsecs, newmicros)
             && SketchBoardBase
            )
            {   if_gfxwindow();
                lmb = FALSE;
            } elif ((ytile * TILESX) <= 0x6D) // always true with the current layout
            {   stamp = (ytile * TILESX) + xtile;
                updatetiles();
        }   }
    acase MENUUP: // we don't hear MENUDOWNs
        if (mouseisover(GID_IF_SP1, mousex, mousey))
        {   xtile     = (mousex - gadgets[GID_IF_SP1]->LeftEdge         ) / TILEWIDTH;
            ytile     = (mousey - gadgets[GID_IF_SP1]->TopEdge + scrolly) / TILEHEIGHT;
            whichtile = IOBuffer[GETOFFSET(xtile, ytile, level)];
            if   (tileset[level - 1] == 0) blank = 0x3B;
            elif (tileset[level - 1] == 1) blank = 0x45;
            else                           blank = 0x54;
            if (whichtile != blank)
            {   IOBuffer[GETOFFSET(xtile, ytile, level)] = blank;
                if_drawmappart(xtile, ytile);
}   }   }   }

EXPORT void if_mouse(SWORD mousex, SWORD mousey)
{   UBYTE whichtile;
    int   xtile, ytile;

    if (lmb && mouseisover(GID_IF_SP1, mousex, mousey))
    {   xtile     = (mousex - gadgets[GID_IF_SP1]->LeftEdge         ) / TILEWIDTH;
        ytile     = (mousey - gadgets[GID_IF_SP1]->TopEdge + scrolly) / TILEHEIGHT;
        whichtile = IOBuffer[GETOFFSET(xtile, ytile, level)];
        if (whichtile != stamp)
        {   IOBuffer[GETOFFSET(xtile, ytile, level)] = stamp;
            if_drawmappart(xtile, ytile);
}   }   }

EXPORT void if_tick(SWORD mousex, SWORD mousey)
{   if
    (   mouseisover(GID_IF_SP1, mousex, mousey)
     || mouseisover(GID_IF_SP2, mousex, mousey)
    )
    {   setpointer(TRUE , WinObject, MainWindowPtr, FALSE);
    } else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
}   }

EXPORT void if_realpen_to_table(void)
{   fgpen_real    = convert[fgpen_real];
    fgpen_intable = fgpen_real    - (tileset[level - 1] * 8);
}
EXPORT void if_tablepen_to_real(void)
{   fgpen_real    = fgpen_intable + (tileset[level - 1] * 8);
}

EXPORT void if_readsketchboard(UBYTE* data)
{   int plane,
        x, y;

    for (y = 0; y < tileheight; y++)
    {   for (x = 0; x < tilewidth; x++)
        {   data[(y * tilewidth) + x] = convert[
            data[(y * tilewidth) + x]];
            for (plane = 0; plane < 3; plane++)
            {   offset = 0xA3000
                       + (tileset[level - 1] * 26624)
                       + ( plane             *  8800)  // bytes per plane
                       + ((stamp     / 10)   *   800)
                       + ( y                 *    40)  // bytes per pixel row
                       + ((stamp     % 10)   *     4)
                       + ( x                 /     8); // bytes per pixel column
                if (data[(y * tilewidth) + x] & (1 << plane))
                {   IOBuffer[offset] |=  (0x80 >> (x % 8));
                } else
                {   IOBuffer[offset] &= ~(0x80 >> (x % 8));
}   }   }   }   }

EXPORT UBYTE if_getpixel(int x, int y)
{   UBYTE colour;
    int   plane;

    colour = tileset[level - 1] * 8;

    for (plane = 0; plane < 3; plane++)
    {   offset = 0xA3000
               + (tileset[level - 1] * 26624)
               + ( plane             *  8800)  // bytes per plane
               + ((stamp     / 10)   *   800)
               + ( y                 *    40)  // bytes per pixel row
               + ((stamp     % 10)   *     4)
               + ( x                 /     8); // bytes per pixel column
        if (IOBuffer[offset] & (128 >> (x % 8)))
        {   colour += (1 << plane);
    }   }

    return colour;
}

EXPORT FLAG if_wantrmb(SWORD mousex, SWORD mousey)
{   return mouseisover(GID_IF_SP1, mousex, mousey);
}

MODULE void if_gfxwindow(void)
{   ULONG idcmp1, idcmp2;

    GetAttr(WA_IDCMP, WinObject, &idcmp1);
    idcmp1 &= ~(IDCMP_MENUVERIFY);
    idcmp2 = idcmp1 & ~(IDCMP_NEWSIZE);
    SetAttrs // not ModifyIDCMP()!
    (   WinObject,
        WA_IDCMP,             idcmp1,
        WINDOW_IDCMPHookBits, idcmp2,
    TAG_DONE);

    penoffset = tileset[level - 1] * 8;
    gfxwindow();

    GetAttr(WA_IDCMP, WinObject, &idcmp1);
    idcmp1 |= IDCMP_MENUVERIFY;
    idcmp2 = idcmp1 & ~(IDCMP_NEWSIZE);
    SetAttrs // not ModifyIDCMP()!
    (   WinObject,
        WA_IDCMP,             idcmp1,
        WINDOW_IDCMPHookBits, idcmp2,
    TAG_DONE);
}
