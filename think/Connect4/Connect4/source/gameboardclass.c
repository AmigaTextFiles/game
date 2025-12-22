#include "gameboardclass.h"
#include "graphics_support.h"
#include "computer_player.h"
#include <hardware/blit.h>
#include <clib/graphics_protos.h>
#include <stdio.h>
#include <SDI_compiler.h>

// Uncomment these to debug
//#define GAMEBOARDCLASS_DEBUG
//#define GRID_DEBUG


SAVEDS ULONG gameboardNew (struct IClass *cl, Object *obj, Msg *msg)
{
    struct gameboarddata *gb_data;

    if (!(obj=(Object *)DoSuperMethodA(cl, obj, msg)))
        return 0;

    gb_data=INST_DATA(cl, obj);

    // Initialise the columntop[] and filled[][] arrays to -1
    {
        int i, j;

        for (i=0; i<7; i++)
        {
            gb_data->columntop[i]=-1;
            for (j=0; j<5; j++)
                gb_data->filled[i][j]=-1;
        }
    }
    
    gb_data->current_player=red_player; // red player goes first

    gb_data->inputactive=FALSE;         // Can't play until this is TRUE
    gb_data->restartgameboard=FALSE;

    loadiff("PROGDIR:gfx/red_counter",    &gb_data->red_width,    &gb_data->red_height,    &gb_data->red_depth,    NULL, &gb_data->red_body,    &gb_data->red_palette);
    loadiff("PROGDIR:gfx/yellow_counter", &gb_data->yellow_width, &gb_data->yellow_height, &gb_data->yellow_depth, NULL, &gb_data->yellow_body, &gb_data->yellow_palette);
   
    return ((ULONG)obj);
}

SAVEDS ULONG gameboardDispose (struct IClass *cl, Object *obj, Msg *msg)
{
    struct gameboarddata *gb_data=INST_DATA(cl, obj);
    
    // Free everything that loadiff() allocated for us
    free(gb_data->red_palette);
    free(gb_data->red_body);

    free(gb_data->yellow_palette);
    free(gb_data->yellow_body);

    return (DoSuperMethodA(cl, obj, msg));
}


SAVEDS ULONG gameboardSet (struct IClass *cl, Object *obj, struct opSet *msg)
{
    {
        struct TagItem *ti, *tstate;
        struct gameboarddata *gb_data=INST_DATA(cl, obj);

        ti=msg->ops_AttrList;
        tstate=ti;
    
        while (ti = NextTagItem(&tstate))
        {
            switch (ti->ti_Tag)
            {
                case MUIA_Gameboard_CurrentPlayer:
                        gb_data->current_player=ti->ti_Data;
                        /*
                        ** FOR SOME REASON, THIS IS A BIG NO-NO!!!!!!!!!!!
                        **
                        // Build a message and send it to the Notify class (our superclass)
                        {
                            struct TagItem tt[2];

                            tt[0].ti_Tag=ti->ti_Tag;
                            tt[1].ti_Data=ti->ti_Data;
                            tt[2].ti_Tag=TAG_DONE;

                            DoSuperMethod(cl, obj, OM_NOTIFY, tt, msg->ops_GInfo, 0L);
                        }
                        */
                        break;

                case MUIA_Gameboard_Inputactive:
                        gb_data->inputactive=ti->ti_Data;
                        break;

                case MUIA_Gameboard_Winner:
                        gb_data->winning_player=ti->ti_Data;
                        break;

                case MUIA_Gameboard_Restart:
                        gb_data->restartgameboard=ti->ti_Data;
                        MUI_Redraw(obj, MADF_DRAWUPDATE);
                        break;

                case MUIA_Gameboard_Tiegame:
                        gb_data->tiegame=ti->ti_Data;
                        break;

                case MUIA_Gameboard_RedPlayer:
                        gb_data->opponent[red_player].type=ti->ti_Data;
                        break;

                case MUIA_Gameboard_YellowPlayer:
                        gb_data->opponent[yellow_player].type=ti->ti_Data;
                        break;

                case MUIA_Gameboard_RedDetail:
                        gb_data->opponent[red_player].data=ti->ti_Data;
                        break;

                case MUIA_Gameboard_YellowDetail:
                        gb_data->opponent[yellow_player].data=ti->ti_Data;
                        break;
            }
        }
    }
    return (DoSuperMethodA(cl, obj, (Msg)msg));
}

SAVEDS ULONG gameboardGet (struct IClass *cl, Object *obj, struct opGet *msg)
{
    struct gameboarddata *gb_data=INST_DATA(cl, obj);

    switch (msg->opg_AttrID)
    {
        case MUIA_Gameboard_CurrentPlayer:
            *(msg->opg_Storage)=gb_data->current_player;
            return TRUE;

        case MUIA_Gameboard_RedPlayer:
            *(msg->opg_Storage)=gb_data->opponent[red_player].type;
            return TRUE;

        case MUIA_Gameboard_YellowPlayer:
            *(msg->opg_Storage)=gb_data->opponent[yellow_player].type;
            return TRUE;

        case MUIA_Gameboard_RedDetail:
            *(msg->opg_Storage)=gb_data->opponent[red_player].data;
            return TRUE;

        case MUIA_Gameboard_YellowDetail:
            *(msg->opg_Storage)=gb_data->opponent[yellow_player].data;
            return TRUE;
    }

    return(DoSuperMethodA(cl, obj, (Msg)msg));
}


SAVEDS ULONG gameboardDraw (struct IClass *cl, Object *obj, struct MUIP_Draw *msg)
{
    DoSuperMethodA(cl, obj, (Msg)msg);

    if (msg->flags & MADF_DRAWOBJECT)
    {
        struct gameboarddata *gb_data=INST_DATA(cl, obj);
        int column, row;

        for (column=0; column<7; column++)
        {
            for (row=0; row<5; row++)
            {
                if (gb_data->filled[column][row]==red_player)
                {
                    BltMaskBitMapRastPort(gb_data->red_bitmap, 0, 0, _rp(obj),
                                          _mleft(obj)+13+(column*60)+7, _mtop(obj)+12+((4-row)*60)+7,
                                          gb_data->red_width, gb_data->red_height,
                                          (ABC|ABNC|ANBC), gb_data->mask_bitmap->Planes[0]);
                }
                else if (gb_data->filled[column][row]==yellow_player)
                {
                    BltMaskBitMapRastPort(gb_data->yellow_bitmap, 0, 0, _rp(obj),
                                          _mleft(obj)+13+(column*60)+7, _mtop(obj)+12+((4-row)*60)+7,
                                          gb_data->yellow_width, gb_data->yellow_height,
                                          (ABC|ABNC|ANBC), gb_data->mask_bitmap->Planes[0]);
                }
            }
        }
    }
    else if (msg->flags & MADF_DRAWUPDATE)
    {
        struct gameboarddata *gb_data=INST_DATA(cl, obj);
        
        if (gb_data->restartgameboard)
        {
            // Initialise the columntop[] and filled[][] arrays to -1
            {
                int i, j;

                for (i=0; i<7; i++)
                {
                    gb_data->columntop[i]=-1;
                    for (j=0; j<5; j++)
                        gb_data->filled[i][j]=-1;
                }
            }

            gb_data->current_player=red_player; // red player goes first
            gb_data->inputactive=FALSE;         // Can't play until this is TRUE
            gb_data->restartgameboard=FALSE;

            // Clear all the pieces
            {
                int column, row;

                for (column=0; column<7; column++)
                {
                    for (row=0; row<5; row++)
                    {
                        BltMaskBitMapRastPort(gb_data->blank_bitmap, 0, 0, _rp(obj),
                                              _mleft(obj)+13+(column*60)+7, _mtop(obj)+12+((4-row)*60)+7,
                                              gb_data->blank_width, gb_data->blank_height,
                                              (ABC|ABNC|ANBC), gb_data->mask_bitmap->Planes[0]);
                    }
                }
            }
        }
        else
        {
            if (gb_data->current_player==red_player)
            {
                BltMaskBitMapRastPort(gb_data->red_bitmap, 0, 0, _rp(obj),
                                      gb_data->counterx, gb_data->countery,
                                      gb_data->red_width, gb_data->red_height,
                                      (ABC|ABNC|ANBC), gb_data->mask_bitmap->Planes[0]);
            }
            else
            {
                BltMaskBitMapRastPort(gb_data->yellow_bitmap, 0, 0, _rp(obj),
                                      gb_data->counterx, gb_data->countery,
                                      gb_data->yellow_width, gb_data->yellow_height,
                                      (ABC|ABNC|ANBC), gb_data->mask_bitmap->Planes[0]);
            }
        }
    }

    return 0;
}

SAVEDS ULONG gameboardHandleInput (struct IClass *cl, Object *obj, struct MUIP_HandleInput *msg)
{
    #define _isbetween(a, x, b) ((x)>=(a) && (x)<=(b))
    #define _isinobject(x, y) (_isbetween(_mleft(obj), (x), _mright(obj))  \
                            && _isbetween(_mtop(obj), (y), _mbottom(obj)))

    struct gameboarddata *gb_data=INST_DATA(cl, obj);

    if (gb_data->inputactive)
    {
        if (msg->imsg)
        {
            if (msg->imsg->Class==IDCMP_MOUSEBUTTONS)
            {
                if (msg->imsg->Code==SELECTDOWN)
                {
                    if (_isinobject(msg->imsg->MouseX, msg->imsg->MouseY))
                    {
                        int column;

                        if ((column=msg->imsg->MouseX-_mleft(obj)-13)>=0)
                        {
                            column=column/60;

                            if (column>=0 && column<=6)
                            {
                                if (gb_data->columntop[column]<4)
                                {
                                    gb_data->column=column;
                                    DoMethod(obj, MUIM_Gameboard_MakeMove);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    return 0;
}

SAVEDS ULONG gameboardSetup (struct IClass *cl, Object *obj, struct MUIP_Setup *msg)
{
    if (!(DoSuperMethodA(cl, obj, (Msg)msg)))
        return (FALSE);

    {
        struct gameboarddata *gb_data=INST_DATA(cl, obj);
        struct BitMap *planar_blank_bitmap;
        UBYTE mask_body[270] =
        {
            /* Plane 0 */
            0x00, 0x00, 0x3F, 0xE0, 0x00, 0x00, 0x00, 0x01, 0xFF, 0xFC, 0x00, 0x00, 0x00, 0x0F, 0xFF, 0xFF,
            0x80, 0x00, 0x00, 0x1F, 0xFF, 0xFF, 0xC0, 0x00, 0x00, 0x7F, 0xFF, 0xFF, 0xF0, 0x00, 0x00, 0xFF,
            0xFF, 0xFF, 0xF8, 0x00, 0x01, 0xFF, 0xFF, 0xFF, 0xFC, 0x00, 0x03, 0xFF, 0xFF, 0xFF, 0xFE, 0x00,
            0x07, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x0F, 0xFF, 0xFF, 0xFF, 0xFF, 0x80, 0x0F, 0xFF, 0xFF, 0xFF,
            0xFF, 0x80, 0x1F, 0xFF, 0xFF, 0xFF, 0xFF, 0xC0, 0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0x3F, 0xFF,
            0xFF, 0xFF, 0xFF, 0xE0, 0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0,
            0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF8,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xF8, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, 0x7F, 0xFF,
            0xFF, 0xFF, 0xFF, 0xF0, 0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0,
            0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0x1F, 0xFF, 0xFF, 0xFF, 0xFF, 0xC0, 0x0F, 0xFF, 0xFF, 0xFF,
            0xFF, 0x80, 0x0F, 0xFF, 0xFF, 0xFF, 0xFF, 0x80, 0x07, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x03, 0xFF,
            0xFF, 0xFF, 0xFE, 0x00, 0x01, 0xFF, 0xFF, 0xFF, 0xFC, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xF8, 0x00,
            0x00, 0x7F, 0xFF, 0xFF, 0xF0, 0x00, 0x00, 0x1F, 0xFF, 0xFF, 0xC0, 0x00, 0x00, 0x0F, 0xFF, 0xFF,
            0x80, 0x00, 0x00, 0x01, 0xFF, 0xFC, 0x00, 0x00, 0x00, 0x00, 0x3F, 0xE0, 0x00, 0x00
        };

        UBYTE blank_body[270] =
        {
            /*Plane 0*/
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
        };

        // Create red counter bitmap
        gb_data->red_bitmap=bodytobitmap(gb_data->red_width, gb_data->red_height, gb_data->red_depth, gb_data->red_body);

        // Create yellow counter bitmap
        gb_data->yellow_bitmap=bodytobitmap(gb_data->yellow_width, gb_data->yellow_height, gb_data->yellow_depth, gb_data->yellow_body);

        // Create counter mask bitmap
        gb_data->mask_bitmap=bodytobitmap(45, 45, 1, mask_body);

        // Create blank square bitmap
        gb_data->blank_width=45;
        gb_data->blank_height=45;
        gb_data->blank_depth=1;
        planar_blank_bitmap=bodytobitmap(gb_data->blank_width, gb_data->blank_height, gb_data->blank_depth, blank_body);
        // and set up its palette
        {
            int i;
            for (i=0; i<3; i++)
            {
                gb_data->blank_palette[i]  =0x00000000;
                gb_data->blank_palette[i+3]=0xFFFFFFFF;
            }
        }

        {
            struct Screen *screen=_screen(obj);
            int i;

            // Initialise allocated pen array
            for (i=0; i<GAMEBOARD_PENS; i++)
            {
                gb_data->pens[i].number=-1;
                gb_data->pens[i].red=0;
                gb_data->pens[i].green=0;
                gb_data->pens[i].blue=0;
            }

            // Remap colours in red and yellow counter bitmaps
            #ifdef GRAPHICS_SUPPORT_DEBUG
            puts("##red bitmap");
            #endif
            remapbitmap(gb_data->red_bitmap, screen->ViewPort.ColorMap, gb_data->red_palette, gb_data->pens, GAMEBOARD_PENS);

            #ifdef GRAPHICS_SUPPORT_DEBUG
            puts("##yellow bitmap");
            #endif
            remapbitmap(gb_data->yellow_bitmap, screen->ViewPort.ColorMap, gb_data->yellow_palette, gb_data->pens, GAMEBOARD_PENS);

            #ifdef GRAPHICS_SUPPORT_DEBUG
            puts("##blank bitmap");
            #endif
            remapbitmap(planar_blank_bitmap, screen->ViewPort.ColorMap, gb_data->blank_palette, gb_data->pens, GAMEBOARD_PENS);

            // Make a copy of the blank_bitmap using the screen->RastPort.BitMap as friend bitmap
            // On chunky displays this will give a faster refresh when the board is cleared
            gb_data->blank_bitmap=AllocBitMap(gb_data->blank_width, gb_data->blank_height, 8, BMF_CLEAR | BMF_MINPLANES, screen->RastPort.BitMap);
            BltBitMap(planar_blank_bitmap, 0, 0, gb_data->blank_bitmap, 0, 0, gb_data->blank_width, gb_data->blank_height, 0xC0, 0xFF, NULL);
            FreeBitMap(planar_blank_bitmap);
        }

    }

    MUI_RequestIDCMP(obj, IDCMP_MOUSEBUTTONS);

    return (TRUE);
}


SAVEDS ULONG gameboardCleanup (struct IClass *cl, Object *obj, struct MUIP_CleanUp *msg)
{
    struct gameboarddata *gb_data=INST_DATA(cl, obj);
    struct Screen *screen=_screen(obj);

    freeallocatedpens(screen->ViewPort.ColorMap, gb_data->pens, GAMEBOARD_PENS);

    FreeBitMap(gb_data->red_bitmap);
    FreeBitMap(gb_data->yellow_bitmap);
    FreeBitMap(gb_data->mask_bitmap);
    FreeBitMap(gb_data->blank_bitmap);

    MUI_RejectIDCMP(obj, IDCMP_MOUSEBUTTONS);

    return (DoSuperMethodA(cl, obj, (Msg)msg));
}

/* Test from current position->South
**
**                               +
**                               |
**
** RESULT:
**          red_player or yellow_player, or -1 if no-one has won
*/
char testS (struct gameboarddata *gb_data, int column, int row)
{
    if (row>=3)
    {
        char total, i;

        total=0;
        for (i=row; i>=(row-3); i--)
            total+=gb_data->filled[column][i];

        if (total==0)
            return red_player;
        else if (total==4)
            return yellow_player;
        else
            return -1;
    }
    else
        return -1;
}

/* Test from current position->West and from current position->East
**
**                             --+--
**
** RESULT:
**          red_player or yellow_player, or -1 if no-one has won
*/
char testWE (struct gameboarddata *gb_data, int column, int row)
{
    char total, i;

    total=0;
    for (i=0; i<7; i++)
    {
        if (gb_data->filled[i][row]==gb_data->current_player)
            total++;
        else if (total>=4)
            break;
        else
            total=0;
        #ifdef GAMEBOARDCLASS_DEBUG
        printf("WE total=%d\n", total);
        #endif
    }

    if (total>=4)
        return gb_data->current_player;
    else
        return -1;
}

/* Test from current position->NorthEast and from current position->SouthWest
**
**                                /
**                               +
**                              /
**
** RESULT:
**          red_player or yellow_player, or -1 if no-one has won
*/
char testNESW(struct gameboarddata *gb_data, int column, int row)
{
    char diagrow=0;
    char total=0;
    char diagcolumn;

    for (diagcolumn=column-row; diagrow<5; diagcolumn++)
    {
        if (diagcolumn>=0 && diagcolumn<=6)
        {
            if (gb_data->filled[diagcolumn][diagrow]==gb_data->current_player)
                total++;
            else if (total>=4)
                break;
            else
                total=0;
            #ifdef GAMEBOARDCLASS_DEBUG
            printf("NESW total=%d\n", total);
            #endif
        }

        diagrow++;
    }

    if (total>=4)
        return gb_data->current_player;
    else
        return -1;
}

/* Test from current position->NorthWest and from current position->SouthEast
**
**                              \
**                               +
++                                \
**
** RESULT:
**          red_player or yellow_player, or -1 if no-one has won
*/
char testNWSE(struct gameboarddata *gb_data, int column, int row)
{
    char diagrow=0;
    char total=0;
    char diagcolumn;

    for (diagcolumn=column+row; diagrow<5; diagcolumn--)
    {
        if (diagcolumn>=0 && diagcolumn<=6)
        {
            if (gb_data->filled[diagcolumn][diagrow]==gb_data->current_player)
                total++;
            else if (total>=4)
                break;
            else
                total=0;
            #ifdef GAMEBOARDCLASS_DEBUG
            printf("NWSE total=%d\n", total);
            #endif
        }

        diagrow++;
    }

    if (total>=4)
        return gb_data->current_player;
    else
        return -1;

}


BOOL fullboard(struct gameboarddata *gb_data)
{
    char i;

    for (i=0; i<7; i++)
    {
        if (gb_data->filled[i][4]==-1)
            return FALSE;
    }
    return TRUE;    // If we get to this, the board is full!
}


BOOL testwinordraw (Object *obj, struct gameboarddata *gb_data)
{
    char result, winner=-1;
    if ((result=testS(gb_data, gb_data->column, gb_data->row))>=0)
        winner=result;

    if ((result=testWE(gb_data, gb_data->column, gb_data->row))>=0)
        winner=result;

    if ((result=testNESW(gb_data, gb_data->column, gb_data->row))>=0)
        winner=result;

    if ((result=testNWSE(gb_data, gb_data->column, gb_data->row))>=0)
        winner=result;

    if (winner>=0)
    {
        SetAttrs(obj, MUIA_Gameboard_Winner, winner, TAG_DONE);
        return TRUE;
    }
    else if (fullboard(gb_data))
    {
        SetAttrs(obj, MUIA_Gameboard_Tiegame, TRUE, TAG_DONE);
        return TRUE;
    }

    return FALSE;
}


SAVEDS ULONG gameboardMakeMove (struct IClass *cl, Object *obj, Msg *msg)
{
    struct gameboarddata *gb_data=INST_DATA(cl, obj);
    int row, column=gb_data->column;

    // Overide the imported column number if the current player is non-local
    if (gb_data->opponent[gb_data->current_player].type==PlayerType_Computer)
    {
        gb_data->column=computer_player(gb_data->opponent[gb_data->current_player].data, gb_data->filled, gb_data->columntop, gb_data->current_player, FALSE);  
        if (gb_data->column==-1)    // Possible error if user enters out of range value for computer skill level...
            gb_data->column=0;      // ...in which case the characteristic response will be to always go in the first column ie. pretty shitty AI !!!
        column=gb_data->column;
    }

    row=gb_data->columntop[column]+1;
    gb_data->columntop[column]++;

    gb_data->filled[column][row]=gb_data->current_player;

    #ifdef GRID_DEBUG
    {
        char i, j;

        for (i=4; i>=0; i--)
        {
            for (j=0; j<7; j++)
                printf("%2.d ", gb_data->filled[j][i]);
            printf("\n");
        }
        printf("\n");
    }
    #endif


    gb_data->row=row;
    gb_data->counterx=_mleft(obj)+13+(column*60)+7;
    gb_data->countery=_mtop(obj)+12+((4-row)*60)+7;
    MUI_Redraw(obj, MADF_DRAWUPDATE);
    if (!testwinordraw(obj, gb_data))   // if the game isn't over, change player
    {
        if (gb_data->current_player==red_player)
            SetAttrs(obj, MUIA_Gameboard_CurrentPlayer, yellow_player, TAG_DONE);
        else
            SetAttrs(obj, MUIA_Gameboard_CurrentPlayer, red_player, TAG_DONE);
    }

    return 0;
}


SAVEDS ULONG gameboardDispatcher (REG(a0, struct IClass *cl),
                                  REG(a2, Object *obj),
                                  REG(a1, Msg msg))
{
    switch (msg->MethodID)
    {
        case OM_NEW             : return(gameboardNew           (cl, obj, msg));
        case OM_DISPOSE         : return(gameboardDispose       (cl, obj, msg));
        case OM_SET             : return(gameboardSet           (cl, obj, (struct opSet *)msg));
        case OM_GET             : return(gameboardGet           (cl, obj, (struct opGet *)msg));
        case MUIM_Draw          : return(gameboardDraw          (cl, obj, (struct MUIP_Draw *)msg));
        case MUIM_HandleInput   : return(gameboardHandleInput   (cl, obj, (struct MUIP_HandleInput *)msg));
        case MUIM_Setup         : return(gameboardSetup         (cl, obj, (struct MUIP_Setup *)msg));
        case MUIM_Cleanup       : return(gameboardCleanup       (cl, obj, (struct MUIP_CleanUp *)msg));
        case MUIM_Gameboard_MakeMove  : return(gameboardMakeMove (cl,obj, msg));
    }

    return (DoSuperMethodA(cl, obj, msg));
}


