/*
    MUI custom class for X-Mines type mine filed
*/

#include "MUIMine.h"
#include "MineField.h"

#ifndef EXEC_EXECBASE_H
#include <exec/execbase.h>
#endif


/*
    Instance data
*/
struct MineFieldData
{
    int    CellSizeX, CellSizeY;     // dimensions of cell in pixels
    int    Width, Height;            // dimensions of the mine field
    int    GameWidth, GameHeight;    // dimensions of the mine field in current game
    int    NumMines;                 // total number of mines in field
    int    GameNumMines;             // total number of mines in current game
    int    MinesLeft;                // number of mines not flagged
    int    CellsUncovered;           // number of cells that are uncovered
    int    TimeTaken;                // time since first click in field
    int    HitCellX, HitCellY;       // cell that mouse is in at last check
    ULONG  Flags;                    // for mouse down and shift (see above)
    int    CellsAllocated;           // number of cells allocated
    USHORT * CellArray;              // allocated array for cell data
    struct Screen * RenderScreen;    // screen bitmap was rendered to
    STRPTR ImageFile;                // name of imagery picture file
    Object * ImageDTObject;          // picture data type object for imagery
    struct BitMap * ImageBM;         // bitmap containing cell imagery
    struct MUI_InputHandlerNode ihn; // input handler node for timer
    int    TimerPrescaler;           // prescale counter for timer
};


/*
    defines for MineFieldData.Flags
*/
#define MFF_INP_LEFTMOUSE     0x00000001L  // left mouse button is down
#define MFF_INP_RIGHTMOUSE    0x00000002L  // right mouse button is down
#define MFF_INP_SHIFT         0x00000008L  // shift key down at LMB down
#define MFF_STATE_INITIALIZED 0x00000100L  // game has been initialized but not started
#define MFF_STATE_RUNNING     0x00000200L  // game has started and is still running
#define MFF_STATE_LOST        0x00000400L  // game was lost
#define MFF_STATE_WON         0x00000800L  // game was won
#define MFF_STATE_PAUSED      0x00001000L  // game paused (window inactive)
#define MFF_STATE_SUSPENDED   0x00008000L  // game is suspended while window closed

/*
    defines for Cell Data - the state of each cell in a mine field is
                            stored in a 16-bit integer as follows


      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |1|1|1|1|1|1|9|8|7|6|5|4|3|2|1|0|
      |5|4|3|2|1|0| | | | | | | | | | |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       | | | | |   | |         \_____/
       | | | | |   | |            |
       | | | | |   | |            +--- # mined neighbors (0 - 8)
       | | | | |   | +---------------- cell needs to be redrawn
       | | | | |   +------------------ cell is highlighted
       | | | | +---------------------- cell incorrectly flagged
       | | | +------------------------ cell is flagged
       | | +-------------------------- cell has expolded
       | +---------------------------- cell is uncovered
       +------------------------------ cell is mined
*/
#define CELLF_MINED      0x8000    // cell is mined
#define CELLF_UNCOVERED  0x4000    // cell has been uncovered
#define CELLF_EXPLODED   0x2000    // cell has been expolded
#define CELLF_FLAGGED    0x1000    // cell is flagged as mined
#define CELLF_FLAGERR    0x0800    // cell was incorrectly flagged
#define CELLF_HIGHLIGHT  0x0200    // cell is currently highlighted
#define CELLF_REDRAW     0x0100    // cell needs to be redrawn

#define CELLM_STATE      0x7800    // mask for state bits
#define CELLM_NEIGHBORS  0x000F    // mask for number of mined neighbors


/*
    defines for defaults 
*/
#define DEFAULT_WIDTH     20
#define DEFAULT_HEIGHT    15
#define DEFAULT_IMAGEFILE (STRPTR)"def_MineFieldImage"
#define DEFAULT_IMAGEDIR  (STRPTR)"Images"


/*
    defines for return from UncoverCell()
*/
#define UNCOVER_NONE      0
#define UNCOVER_REDRAW    1
#define UNCOVER_WIN       2
#define UNCOVER_LOSE      3


/*
    defines for image indexes
*/
#define IMAGEIDX_COVERED     0
#define IMAGEIDX_HIGHLIGHT   1
#define IMAGEIDX_QUESTION    2
#define IMAGEIDX_FLAGGED     3
#define IMAGEIDX_FLAGERR     4
#define IMAGEIDX_MINED       5
#define IMAGEIDX_EXPLODED    6
#define IMAGEIDX_NONEIGHBOR  7

#define IMAGE_COUNT          16


/*
    defines for game timer
*/
#define TIMER_MILLIS    500
#define TIMER_PRESCALE  1

/*
    other defines
*/
#define CELL_IN_FIELD(data, x, y) ((x) >= 0  &&  (x) < (data)->GameWidth  &&  (y) >= 0  &&  (y) < (data)->GameHeight)
#define CELL_INDEX(data, x, y)    ((y) * (data)->GameWidth + (x))



/*
    private function prototypes
*/
BOOL InitImageBM(struct MineFieldData * data, struct Screen * rscreen);
void FreeImageBM(struct MineFieldData * data);

void InitGame(Object * obj, struct MineFieldData * data);
void StartGameRunning(Object * obj, struct MineFieldData * data);
void StopGameRunning(Object * obj, struct MineFieldData * data);

void DoLMBDown  (Object * obj, struct MineFieldData * data, int x, int y, BOOL shift);
void DoLMBUp    (Object * obj, struct MineFieldData * data, int x, int y);
void DoRMBDown  (Object * obj, struct MineFieldData * data, int x, int y);
void DoRMBUp    (Object * obj, struct MineFieldData * data, int x, int y);
void DoMouseMove(Object * obj, struct MineFieldData * data, int x, int y);

BOOL HighlightNeighborhood(struct MineFieldData * data, int x, int y);
BOOL UnhighlightNeighborhood(struct MineFieldData * data, int x, int y);
BOOL HighlightCell(struct MineFieldData * data, int x, int y);
BOOL UnhighlightCell(struct MineFieldData * data, int x, int y);

BOOL CheckMouseMove(struct MineFieldData * data, int x, int y);
int  UncoverCell(struct MineFieldData * data, int x, int y);
int  UncoverCleared(struct MineFieldData * data, int x, int y);

int GetCellImage(USHORT cell);
void DrawAll(Object * obj, struct MineFieldData * data);

void CountMinedNeighbors(struct MineFieldData * data, int x, int y);
void InitRandom(void);
int  RandomInt(int range);



/*
    function :    OM_NEW method handler for MineField class
*/
static ULONG mNew(struct IClass *cl, Object *obj, struct opSet *msg)
{
    int i;
    struct MineFieldData *data;
    STRPTR fname;

    if (!(obj = (Object *)DoSuperMethodA(cl, obj, (APTR)msg)))
    {
        return 0;
    }

//    puts("MineField::New\n");

    InitRandom();    /* initialize random number seed */

    data = INST_DATA(cl, obj);

    data->Width = GetTagData(MUIA_MineField_Width, DEFAULT_WIDTH, msg->ops_AttrList);
    data->Height = GetTagData(MUIA_MineField_Height, DEFAULT_HEIGHT, msg->ops_AttrList);
    data->NumMines = GetTagData(MUIA_MineField_NumMines, (data->Width * data->Height) / 6, msg->ops_AttrList);

    data->CellSizeX = data->CellSizeY = 0;
    data->GameWidth = data->GameHeight = 0;
    data->Flags = 0;
    data->CellsAllocated = 0;
    data->CellArray = NULL;
    data->RenderScreen = NULL;
    data->ImageFile = NULL;
    data->ImageDTObject = NULL;
    data->ImageBM = NULL;

    data->ihn.ihn_Object = obj;
    data->ihn.ihn_Millis = TIMER_MILLIS;
    data->ihn.ihn_Method = MUIM_MineField_TimerTick;
    data->ihn.ihn_Flags = MUIIHNF_TIMER;

    fname = (STRPTR)GetTagData(MUIA_MineField_ImageFile, NULL,
                               msg->ops_AttrList);
    if (fname)
    {
        i = strlen(fname);
        if (data->ImageFile = AllocVec(i + 1, 0))
        {
            strcpy(data->ImageFile, fname);
        }
    }
    return (ULONG)obj;
}


/*
    function :    OM_DELETE method handler for MineField class
*/
static ULONG mDispose(struct IClass *cl, Object *obj, Msg msg)
{
    struct MineFieldData *data = INST_DATA(cl, obj);

//    puts("MineField::Dispose\n");
    FreeImageBM(data);

    if (data->ImageFile)
    {
        FreeVec(data->ImageFile);
    }

    if (data->CellArray)
    {
        FreeVec(data->CellArray);
    }

    return DoSuperMethodA(cl, obj, msg);
}


/*
    function :    MUIM_Setup method handler for MineField class
*/
static ULONG mSetup(struct IClass *cl, Object *obj, struct MUIP_Setup * msg)
{
    struct MineFieldData *data = INST_DATA(cl, obj);

//    puts("MineField::Setup\n");

    if (!(DoSuperMethodA(cl, obj, (APTR)msg)))
    {
        return FALSE;
    }

    if (!InitImageBM(data, msg->RenderInfo->mri_Screen))
    {
        CoerceMethod(cl, obj, MUIM_Cleanup);
        return FALSE;
    }

    MUI_RequestIDCMP(obj, IDCMP_MOUSEBUTTONS | IDCMP_INACTIVEWINDOW | IDCMP_ACTIVEWINDOW);

    if (data->CellArray == NULL  ||  data->Width  != data->GameWidth
                                 ||  data->Height != data->GameHeight)
    {
        InitGame(obj, data);
    }
    else if ((data->Flags & MFF_STATE_SUSPENDED) != 0)
    {
        data->Flags &= ~MFF_STATE_SUSPENDED;
        StartGameRunning(obj, data);
    }

    return TRUE;
}


/*
    function :    MUIM_Cleanup method handler for MineField class
*/
static ULONG mCleanup(struct IClass *cl, Object *obj, Msg msg)
{
    struct MineFieldData *data = INST_DATA(cl, obj);

//    puts("MineField::Cleanup\n");

    if ((data->Flags & MFF_STATE_RUNNING) != 0)
    {
        StopGameRunning(obj, data);
        data->Flags |= MFF_STATE_SUSPENDED;
    }

    MUI_RejectIDCMP(obj, IDCMP_MOUSEBUTTONS | IDCMP_INACTIVEWINDOW | IDCMP_ACTIVEWINDOW);

    return(DoSuperMethodA(cl, obj, msg));
}

/*
    function :    MUIM_AskMinMax method handler for MineField class
*/
static ULONG mAskMinMax(struct IClass *cl, Object *obj, struct MUIP_AskMinMax *msg)
{
    int x, y;
    struct MineFieldData *data = INST_DATA(cl, obj);

//    puts("MineField::AskMinMax");

    /*
    ** let our superclass first fill in what it thinks about sizes.
    ** this will e.g. add the size of frame and inner spacing.
    */

    DoSuperMethodA(cl, obj, (APTR)msg);

    /*
    ** now add the values specific to our object. note that we
    ** indeed need to *add* these values, not just set them!
    */

    if (data->CellArray)
    {
        x = data->GameWidth * data->CellSizeX;
        y = data->GameHeight * data->CellSizeY;
    }
    else
    {
        x = data->Width * data->CellSizeX;
        y = data->Height * data->CellSizeY;
    }

    msg->MinMaxInfo->MinWidth  += x;
    msg->MinMaxInfo->DefWidth  += x;
    msg->MinMaxInfo->MaxWidth  += x;

    msg->MinMaxInfo->MinHeight += y;
    msg->MinMaxInfo->DefHeight += y;
    msg->MinMaxInfo->MaxHeight += y;

    return 0;
}


/*
    function :    MUIM_HandleInput method handler for MineField class
*/
static ULONG mHandleInput(struct IClass *cl, Object *obj, struct MUIP_HandleInput *msg)
{
    struct IntuiMessage *imsg = msg->imsg;
    struct MineFieldData *data = INST_DATA(cl, obj);
    BOOL havecells = (data->CellArray != NULL);

    /*
        make sure RMB trapping for the window is enabled if the game is
        running, it seems that MUI will turn off RMB trapping if the user
        deactivates / activates the window or clicks with either mouse
        button in the window but outside the mine field
    */
    if ((data->Flags & MFF_STATE_RUNNING) != 0)
    {
        Forbid();
        _window(obj)->Flags |= WFLG_RMBTRAP;
        Permit();
    }
    if (imsg)
    {
        int x = (int)imsg->MouseX,
            y = (int)imsg->MouseY;

        x -= (_mleft(obj) + _mright(obj) + 1
              - data->GameWidth * data->CellSizeX) / 2;
        y -= (_mtop(obj) + _mbottom(obj) + 1
              - data->GameHeight * data->CellSizeY) / 2;

        x = (x < 0) ? -1 : x / data->CellSizeX;
        y = (y < 0) ? -1 : y / data->CellSizeY;

        switch (imsg->Class)
        {
            case IDCMP_MOUSEBUTTONS:
            {
                if (havecells)
                {
                    switch (imsg->Code)
                    {
                        case SELECTDOWN:
                        {
                            BOOL shift = (imsg->Qualifier & (IEQUALIFIER_LSHIFT |
                                                             IEQUALIFIER_RSHIFT))
                                                 != 0;
                            DoLMBDown(obj, data, x, y, shift);
                            break;
                        }

                        case SELECTUP:
                        {
                            DoLMBUp(obj, data, x, y);
                            break;
                        }

                        case MENUDOWN:
                        {
                            DoRMBDown(obj, data, x, y);
                            break;
                        }

                        case MENUUP:
                        {
                            DoRMBUp(obj, data, x, y);
                            break;
                        }
                    }
                }
                break;
            }

            case IDCMP_MOUSEMOVE:
            {
                if (havecells)
                {
                    DoMouseMove(obj, data, x, y);
                }
                break;
            }

            case IDCMP_ACTIVEWINDOW:
            {
                data->Flags &= ~MFF_STATE_PAUSED;
                break;
            }

            case IDCMP_INACTIVEWINDOW:
            {
                data->Flags |= MFF_STATE_PAUSED;
                break;
            }
        }
    }

    /* passing MUIM_HandleInput to the super class is only necessary
       if you rely on area class input handling (MUIA_InputMode). */

    return 0;
}


/*
    function :    OM_SET method handler for MineField class
*/
static ULONG mSet(struct IClass *cl, Object *obj, struct opSet * msg)
{
    struct MineFieldData *data = INST_DATA(cl,obj);
    struct TagItem *tags, *tag;

    for (tags = msg->ops_AttrList; tag = NextTagItem(&tags); )
    {
        switch (tag->ti_Tag)
        {
            case MUIA_MineField_Width:
                data->Width = (int)tag->ti_Data;
                break;

            case MUIA_MineField_Height:
                data->Height = (int)tag->ti_Data;
                break;

            case MUIA_MineField_NumMines:
                data->NumMines = (int)tag->ti_Data;
                break;

            case MUIA_MineField_TimeTaken:
                data->TimeTaken = (int)tag->ti_Data;
                break;

            case MUIA_MineField_MinesLeft:
                data->MinesLeft = (int)tag->ti_Data;
                break;

            case MUIA_MineField_GameInitialized:
                if (tag->ti_Data)
                {
                    data->Flags |= MFF_STATE_INITIALIZED;
                }
                else
                {
                    data->Flags &= ~MFF_STATE_INITIALIZED;
                }
                break;

            case MUIA_MineField_GameRunning:
                if (tag->ti_Data)
                {
                    data->Flags |= MFF_STATE_RUNNING;
                }
                else
                {
                    data->Flags &= ~MFF_STATE_RUNNING;
                }
                break;

            case MUIA_MineField_GameWon:
                if (tag->ti_Data)
                {
                    data->Flags |= MFF_STATE_WON;
                }
                else
                {
                    data->Flags &= ~MFF_STATE_WON;
                }
                break;

            case MUIA_MineField_GameLost:
                if (tag->ti_Data)
                {
                    data->Flags |= MFF_STATE_LOST;
                }
                else
                {
                    data->Flags &= ~MFF_STATE_LOST;
                }
                break;

            case MUIA_MineField_LMBDown:
                if (tag->ti_Data)
                {
                    data->Flags |= MFF_INP_LEFTMOUSE;
                }
                else
                {
                    data->Flags &= ~MFF_INP_LEFTMOUSE;
                }
                break;
        }
    }

    return DoSuperMethodA(cl, obj, (APTR)msg);
}


/*
    function :    OM_GET method handler for MineField class
*/
static ULONG mGet(struct IClass *cl, Object *obj, struct opGet * msg)
{
    struct MineFieldData *data = INST_DATA(cl, obj);
    ULONG *store = msg->opg_Storage;

    switch (((struct opGet *)msg)->opg_AttrID)
    {
        case MUIA_MineField_Width:
            *store = (ULONG)data->Width;
            return TRUE;

        case MUIA_MineField_Height:
            *store = (ULONG)data->Height;
            return TRUE;

        case MUIA_MineField_NumMines:
            *store = (ULONG)data->NumMines;
            return TRUE;

        case MUIA_MineField_TimeTaken:
            *store = (ULONG)data->TimeTaken;
            return TRUE;

        case MUIA_MineField_MinesLeft:
            *store = (ULONG)data->MinesLeft;
            return TRUE;

        case MUIA_MineField_GameInitialized:
            *store = (ULONG)((data->Flags & MFF_STATE_INITIALIZED) != 0);

        case MUIA_MineField_GameRunning:
            *store = (ULONG)((data->Flags & MFF_STATE_RUNNING) != 0);
            return TRUE;

        case MUIA_MineField_GameWon:
            *store = (ULONG)((data->Flags & MFF_STATE_WON) != 0);
            return TRUE;

        case MUIA_MineField_GameLost:
            *store = (ULONG)((data->Flags & MFF_STATE_LOST) != 0);
            return TRUE;

        case MUIA_MineField_LMBDown:
            *store = (ULONG)((data->Flags & MFF_INP_LEFTMOUSE) != 0);
            return TRUE;
    }

    return DoSuperMethodA(cl, obj, (APTR)msg);
}


/*
    function :    MUIM_Draw method handler for MineField class
*/
static ULONG mDraw(struct IClass *cl, Object *obj, struct MUIP_Draw *msg)
{
    struct MineFieldData *data = INST_DATA(cl, obj);

    /*
    ** let our superclass draw itself first, area class would
    ** e.g. draw the frame and clear the whole region. What
    ** it does exactly depends on msg->flags.
    */

    DoSuperMethodA(cl,obj,(APTR)msg);

    /*
    ** if MADF_DRAWOBJECT is set then draw the entire mine field
    ** else if MADF_DRAWUPDATE set then just draw those cell with
    ** the redraw bit set
    */

    if (msg->flags & MADF_DRAWOBJECT)
    {
        DrawAll(obj, data);
    }
    else if (msg->flags & MADF_DRAWUPDATE  &&  data->CellArray)
    {
        USHORT cell, * pcell = data->CellArray;
        int i, j;
        WORD rx, ry, rx0, ry0;

        rx0 = (WORD)((_mleft(obj) + _mright(obj) + 1 - data->GameWidth * data->CellSizeX) / 2);
        ry0 = (WORD)((_mtop(obj) + _mbottom(obj) + 1 - data->GameHeight * data->CellSizeY) / 2);

        for (j = data->GameHeight, ry = ry0; j > 0; j--, ry += data->CellSizeY)
        {
            for (i = data->GameWidth, rx = rx0; i > 0; i--, rx += data->CellSizeX)
            {
                cell = *pcell;
                if (cell & CELLF_REDRAW)
                {
                    WORD bx;

                    /*
                        determine the co-ordinates of the image in the bit map
                    */
                    bx = (WORD)(GetCellImage(cell) * data->CellSizeX);

                    /*
                        blit the image from the bitmap to the rastport
                    */
                    BltBitMapRastPort(data->ImageBM, bx, 0, _rp(obj), rx, ry,
                                      (WORD)data->CellSizeX, (WORD)data->CellSizeY,
                                      (UBYTE)0xC0);
                    *pcell &= ~CELLF_REDRAW;
                }
                pcell++;
            }
        }
    }

    return 0;
}


/*
    function :    MUIM_MineField_Init method handler for MineField class
*/
static ULONG mMineFieldInit(struct IClass *cl, Object *obj, Msg msg)
{
    struct MineFieldData *data = INST_DATA(cl, obj);

    /*
        initialize new game
    */
    InitGame(obj, data);

    /*
        redraw the entire mine field
    */
    MUI_Redraw(obj, MADF_DRAWOBJECT);

    return 0;
}


/*
    function :    MUIM_MineField_TimerTick method handler for MineField class
*/
static ULONG mTimerTick(struct IClass *cl, Object *obj, Msg msg)
{
    struct MineFieldData *data = INST_DATA(cl, obj);

    if ((data->Flags & MFF_STATE_RUNNING) != 0  &&
        (data->Flags & MFF_STATE_PAUSED)  == 0)
    {
        if (data->TimerPrescaler == 0)
        {
            SetAttrs(obj, MUIA_MineField_TimeTaken, data->TimeTaken + 1,
                          TAG_DONE);
            data->TimerPrescaler = TIMER_PRESCALE;
        }
        else
        {
            data->TimerPrescaler--;
        }
        /*
            make sure that right mouse trapping is enabled for the window
            it seems that this can be turned off by MUI
        */
        Forbid();
        _window(obj)->Flags |= WFLG_RMBTRAP;
        Permit();
    }

    return 0;
}


SAVEDS ASM ULONG MineFieldDispatcher(
        REG(a0) struct IClass *cl,
        REG(a2) Object *obj,
        REG(a1) Msg msg)
{
    switch (msg->MethodID)
    {
        case OM_NEW             : return            mNew(cl, obj, (APTR)msg);
        case OM_DISPOSE         : return        mDispose(cl, obj, (APTR)msg);
        case OM_SET             : return            mSet(cl, obj, (APTR)msg);
        case OM_GET             : return            mGet(cl, obj, (APTR)msg);
        case MUIM_Setup         : return          mSetup(cl, obj, (APTR)msg);
        case MUIM_Cleanup       : return        mCleanup(cl, obj, (APTR)msg);
        case MUIM_AskMinMax     : return      mAskMinMax(cl, obj, (APTR)msg);
        case MUIM_Draw          : return           mDraw(cl, obj, (APTR)msg);
        case MUIM_HandleInput   : return    mHandleInput(cl, obj, (APTR)msg);
        case MUIM_MineField_Init: return  mMineFieldInit(cl, obj, (APTR)msg);
        case MUIM_MineField_TimerTick: return mTimerTick(cl, obj, (APTR)msg);
    }

    return DoSuperMethodA(cl, obj, msg);
}


/*
    function :    initialize the bitmap used for rendering the cells of the
                  minefield, loads the image file and map to the screen using
                  datatypes and set mine field cell size data

    parameters :  data = pointer to mine field data to initialize bitmap for
                  rscreen = pointer to the screen to render the bitmap to

    return :      TRUE if bitmap initialized ok, FALSE if an error occured
*/
BOOL InitImageBM(struct MineFieldData * data, struct Screen * rscreen)
{
    if (data->RenderScreen == NULL  ||  rscreen != data->RenderScreen)
    {
        struct LoadBitMapData lbmdata;
        int rc;

        FreeImageBM(data);

        lbmdata.FileName = (data->ImageFile) ? data->ImageFile : DEFAULT_IMAGEFILE;
        lbmdata.Screen = rscreen;

        rc = LoadBitMap(&lbmdata);
        if (rc == LBMERR_NONE)
        {
            if ((lbmdata.BitMapHeader->bmh_Width % IMAGE_COUNT) == 0)
            {
                data->CellSizeX = lbmdata.BitMapHeader->bmh_Width / IMAGE_COUNT;
                data->CellSizeY = lbmdata.BitMapHeader->bmh_Height;
                data->RenderScreen = rscreen;
                data->ImageDTObject = lbmdata.DTObject;
                data->ImageBM = lbmdata.BitMap;
                return TRUE;
            }
            else
            {
                DisposeDTObject(lbmdata.DTObject);
            }
        }
        return FALSE;
    }

    return TRUE;
}

/*
    function :    frees bitmap data allocated by InitImageBM()

    parameters :  data = pointer to mine field data to free bitmap for

    return :      none
*/
void FreeImageBM(struct MineFieldData * data)
{
    WaitBlit();
    if (data->ImageDTObject)
    {
        DisposeDTObject(data->ImageDTObject);
        data->ImageDTObject = NULL;
    }
    data->RenderScreen = NULL;
    data->ImageBM = NULL;
}

/*
    function :    initialize a new game

    parameters :  obj = pointer to MineField object
                  data = pointer to MineField object's instance data

    return :      none
*/
void InitGame(Object * obj, struct MineFieldData * data)
{
    USHORT *pcell;
    int i, j;

    /*
        check if game is running and if it is stop it
    */
    if ((data->Flags & MFF_STATE_RUNNING) != 0)
    {
        /*
           the game has finished, remove the timer input handler
           and stop receiving RMB and mouse move events
        */
        StopGameRunning(obj, data);
    }

    /*
        check if cell array needs to be allocated or reallocated
        and if so do so
    */
    if (data->CellArray  !=  NULL)
    {
        if (data->CellsAllocated  !=  data->Width * data->Height)
        {
            FreeVec(data->CellArray);
            data->CellArray = NULL;
            data->CellsAllocated = 0;
            data->GameWidth = data->GameHeight = 0;
        }
    }

    if (data->CellArray  ==  NULL)
    {
        i = data->Width * data->Height;
        data->CellArray = AllocVec(i * sizeof(USHORT), 0);
        if (data->CellArray  ==  NULL)
        {
            return;
        }
        data->CellsAllocated = i;
    }

    /*
        set game variables
    */
    data->GameWidth = data->Width;
    data->GameHeight = data->Height;
    data->GameNumMines = data->NumMines;

    /*
        clear cell array
    */
    for (i = data->CellsAllocated, pcell = data->CellArray;
         i > 0;
         i--, pcell++)
    {
        *pcell = 0;
    }

    /*
        randomly place the mines in the mine field, fisrt make sure
        that there are enough cells in the mine field to take the mines
    */
    if (data->GameNumMines >= data->CellsAllocated)
    {
        data->GameNumMines = data->CellsAllocated / 6;
    }
    for (i = data->GameNumMines; i > 0; )
    {
        j = RandomInt(data->CellsAllocated);
        if ((data->CellArray[j] & CELLF_MINED) == 0)
        {
            data->CellArray[j] |= CELLF_MINED;
            i--;
        }
    }

    /*
        count the number of mined neighbors of any unmined cell
    */
    for (i = 0; i < data->GameWidth; i++)
    {
        for (j = 0; j < data->GameHeight; j++)
        {
            CountMinedNeighbors(data, i, j);
        }
    }

    /*
        set game attributes
    */
    data->CellsUncovered = 0;
    data->Flags = 0;
    SetAttrs(obj, MUIA_MineField_MinesLeft, data->GameNumMines,
                  MUIA_MineField_GameWon, FALSE,
                  MUIA_MineField_GameLost, FALSE,
                  MUIA_MineField_GameInitialized, TRUE,
                  MUIA_MineField_TimeTaken, 0,
                  MUIA_MineField_LMBDown, FALSE,
                  TAG_DONE);
}

/*
    function :    left mouse button down event handler

    parameters :  obj = pointer to MineField object
                  data = pointer to MineField object's instance data
                  x = hit cell's x co-ordinate
                  y = hit cell's y co-ordinate
                  shift = TRUE if either shift key is pressed

    return :      none
*/
void DoLMBDown(Object * obj, struct MineFieldData * data, int x, int y, BOOL shift)
{
    /*
        check if we should take notice of this event, we do not take notice
        if the hit cell is out of range, if the right mouse button is already
        down or the game has ended
    */
    if (CELL_IN_FIELD(data, x, y)  &&
        (data->Flags & (MFF_STATE_INITIALIZED | MFF_STATE_RUNNING)) != 0  &&
        (data->Flags & MFF_INP_RIGHTMOUSE) == 0)
    {
        BOOL redraw;

        /*
            if the game has not already started then perform game start
            initialization including trapping right mouse button events
            and starting the timer
        */
        if ((data->Flags & MFF_STATE_RUNNING) == 0)
        {
            data->TimerPrescaler = TIMER_PRESCALE;
            StartGameRunning(obj, data);
        }

        /*
            set or clear the shift flag
        */
        if (shift)
        {
            data->Flags |= MFF_INP_SHIFT;
        }
        else
        {
            data->Flags &= ~MFF_INP_SHIFT;
        }

        /*
            set the left mouse button down attribute for notification
        */
        SetAttrs(obj, MUIA_MineField_LMBDown, TRUE, TAG_DONE);

        /*
            set the hit cell with the given co-ordinates
        */
        data->HitCellX = x;
        data->HitCellY = y;

        /*
            request that mouse move events be sent to the window
        */
        MUI_RequestIDCMP(obj, IDCMP_MOUSEMOVE);

        /*
            now perform the action for the LMB down, if the shift key is
            not pressed then we highlight the hit cell if it is still
            covered, if the shift key is pressed then we highlight the
            hit cell and its neighbors that are still covered
        */
        if (shift)
        {
            redraw = HighlightNeighborhood(data, x, y);
        }
        else
        {
            redraw = HighlightCell(data, x, y);
        }

        /*
           redraw mine field if its visual apperance has changed
        */
        if (redraw)
        {
            MUI_Redraw(obj, MADF_DRAWUPDATE);
        }
    }
}

/*
    function :    left mouse button up event handler

    parameters :  obj = pointer to MineField object
                  data = pointer to MineField object's instance data
                  x = hit cell's x co-ordinate
                  y = hit cell's y co-ordinate

    return :      none
*/
void DoLMBUp(Object * obj, struct MineFieldData * data, int x, int y)
{
    /*
        we are only interested in LMB up events if the LMB origionally
        went down within the mine field
    */
    if ((data->Flags & MFF_INP_LEFTMOUSE) != 0)
    {
        int i, gamestate;
        BOOL redraw;

        /*
            stop receiving mouse move events
        */
        MUI_RejectIDCMP(obj, IDCMP_MOUSEMOVE);

        /*
            check if the mouse has moved to another cell since the
            last mouse move or LMB down event
        */
        redraw = CheckMouseMove(data, x, y);

        /*
            clear the LMB down attribute
        */
        SetAttrs(obj, MUIA_MineField_LMBDown, FALSE, TAG_DONE);

        /*
            determine what to do with the LMB up event, if the shift key was
            pressed then we unhighlight the neighborhood and uncover any
            covered neighbors if the hit cell is uncovered and has precisely
            the same number of mined neighbors as flagged neighbors otherwise
            if the shift key was not pressed then unhighlight the current hit
            cell (if any) and if the hit cell is covered then uncover the cell
        */
        if ((data->Flags & MFF_INP_SHIFT) != 0)
        {
            if (UnhighlightNeighborhood(data, x, y))
            {
                redraw = TRUE;
            }
            i = UncoverCleared(data, x, y);
        }
        else
        {
            if (UnhighlightCell(data, x, y))
            {
                redraw = TRUE;
            }
            i = UncoverCell(data, x, y);
        }

        /*
            if any cells were uncovered then set the redraw flag
        */
        if (i != UNCOVER_NONE)
        {
            redraw = TRUE;
        }

        /*
            redraw the mine field if necessary
        */
        if (redraw)
        {
            MUI_Redraw(obj, MADF_DRAWUPDATE);
        }

        /*
            check if uncovering cell(s) won or lost the game
        */
        gamestate = 0;
        if (i == UNCOVER_WIN)
        {
            /*
                this move won the game
            */
            gamestate = MUIA_MineField_GameWon;
            /*
                set mines left attribute to zero
            */
            SetAttrs(obj, MUIA_MineField_MinesLeft, 0L, TAG_DONE);
        }
        else if (i == UNCOVER_LOSE)
        {
            /*
                this move lost the game
            */
            gamestate = MUIA_MineField_GameLost;;
        }

        if (gamestate)
        {
            /*
               the game has finished, remove the timer input handler
               and stop receiving RMB and mouse move events
            */
            StopGameRunning(obj, data);
            SetAttrs(obj, gamestate, TRUE, TAG_DONE);
        }
    }
}

/*
    function :    right mouse button down event handler

    parameters :  obj = pointer to MineField object
                  data = pointer to MineField object's instance data
                  x = hit cell's x co-ordinate
                  y = hit cell's y co-ordinate

    return :      none
*/
void DoRMBDown(Object * obj, struct MineFieldData * data, int x, int y)
{
    /*
        we are only interested in RMB down events if the LMB is not down,
        the mouse is within the mine field and the game is running
    */
    if (CELL_IN_FIELD(data, x, y)  &&  (data->Flags & MFF_INP_LEFTMOUSE) == 0
                                   &&  (data->Flags & MFF_STATE_RUNNING) != 0)
    {
        USHORT * pcell;
        BOOL redraw = FALSE;

        /*
            set the RMB down flag
        */
        data->Flags |= MFF_INP_RIGHTMOUSE;

        /*
            check out the hit cell to determine what to do, if the cell is
            covered then flag it and decrement the mines left attribute,
            if the cell is already flagged then unflag it and increment
            the mines left attribute otherwise perform no action
        */
        pcell = &data->CellArray[ CELL_INDEX(data, x, y) ];

        if ((*pcell & CELLM_STATE) == 0)
        {
            /*
                cell is covered
            */
            *pcell |= (CELLF_FLAGGED | CELLF_REDRAW);
            SetAttrs(obj, MUIA_MineField_MinesLeft, data->MinesLeft - 1,
                          TAG_DONE);
            redraw = TRUE;
        }
        else if ((*pcell & CELLF_FLAGGED) != 0)
        {
            /*
                cell is flagged
            */
            *pcell &= ~CELLF_FLAGGED;
            *pcell |= CELLF_REDRAW;
            SetAttrs(obj, MUIA_MineField_MinesLeft, data->MinesLeft + 1,
                          TAG_DONE);
            redraw = TRUE;
        }

        /*
            redraw the mine field if a cell was flagged or unflagged
        */
        if (redraw)
        {
            MUI_Redraw(obj, MADF_DRAWUPDATE);
        }
    }
}

/*
    function :    right mouse button up event handler

    parameters :  obj = pointer to MineField object
                  data = pointer to MineField object's instance data
                  x = hit cell's x co-ordinate
                  y = hit cell's y co-ordinate

    return :      none
*/
void DoRMBUp(Object * obj, struct MineFieldData * data, int x, int y)
{
    /*
        clear the RMB down flag
    */
    data->Flags &= ~MFF_INP_RIGHTMOUSE;
}

/*
    function :    mouse move event handler

    parameters :  obj = pointer to MineField object
                  data = pointer to MineField object's instance data
                  x = hit cell's x co-ordinate
                  y = hit cell's y co-ordinate

    return :      none
*/
void DoMouseMove(Object * obj, struct MineFieldData * data, int x, int y)
{
    /*
        we are interested in mouse move events only if the left mouse
        button went down in the mine field
    */
    if ((data->Flags & MFF_INP_LEFTMOUSE) != 0)
    {
        /*
            check if the mouse has moved to a different cell and update
            the cell display if necessary
        */
        if (CheckMouseMove(data, x, y))
        {
            MUI_Redraw(obj, MADF_DRAWUPDATE);
        }
    }
}


/*
    function :    highlights the hit cell and any of its neighbors that
                  are still covered

    parameters :  data = pointer to the mine field data
                  x, y = cell co-ordinates of the hit cell

    return :      TRUE if the display state of any cell changed
*/
BOOL HighlightNeighborhood(struct MineFieldData * data, int x, int y)
{
    BOOL redraw = FALSE;

    /*
        check if the hit cell is within the mine field
    */
    if (CELL_IN_FIELD(data, x, y))
    {
        int i, j, imin, imax, jmin, jmax;
        USHORT * pcell;

        imin = (x > 0) ? x - 1 : 0;
        imax = (x + 1 < data->GameWidth) ? x + 1 : data->GameWidth - 1;
        jmin = (y > 0) ? y - 1 : 0;
        jmax = (y + 1 < data->GameHeight) ? y + 1 : data->GameHeight- 1;

        for (i = imin; i <= imax; i++)
        {
            for (j = jmin; j <= jmax; j++)
            {
                pcell = &data->CellArray[CELL_INDEX(data, i, j)];
                if ((*pcell & CELLM_STATE) == 0  &&
                    (*pcell & CELLF_HIGHLIGHT) == 0)
                {
                    *pcell |= (CELLF_HIGHLIGHT | CELLF_REDRAW);
                    redraw = TRUE;
                }
            }
        }
    }

    return redraw;
}

/*
    function :    remove highlight from the hit cell and any of its
                  neighbors that are still covered and highlighted

    parameters :  data = pointer to the mine field data
                  x, y = cell co-ordinates of the hit cell

    return :      TRUE if the display state of any cell changed
*/
BOOL UnhighlightNeighborhood(struct MineFieldData * data, int x, int y)
{
    BOOL redraw = FALSE;

    /*
        check if the hit cell is within the mine field
    */
    if (CELL_IN_FIELD(data, x, y))
    {
        int i, j, imin, imax, jmin, jmax;
        USHORT * pcell;

        imin = (x > 0) ? x - 1 : 0;
        imax = (x + 1 < data->GameWidth) ? x + 1 : data->GameWidth - 1;
        jmin = (y > 0) ? y - 1 : 0;
        jmax = (y + 1 < data->GameHeight) ? y + 1 : data->GameHeight - 1;

        for (i = imin; i <= imax; i++)
        {
            for (j = jmin; j <= jmax; j++)
            {
                pcell = &data->CellArray[CELL_INDEX(data, i, j)];
                if ((*pcell & CELLM_STATE) == 0  &&
                    (*pcell & CELLF_HIGHLIGHT) != 0)
                {
                    *pcell &= ~CELLF_HIGHLIGHT;
                    *pcell |= CELLF_REDRAW;
                    redraw = TRUE;
                }
            }
        }
    }

    return redraw;
}

/*
    function :    highlights the cell at the given co-ordinates if
                  it is still covered

    parameters :  data = pointer to the mine field data
                  x, y = cell co-ordinates of the cell to highlight

    return :      TRUE if the mine field needs to be redrawn
*/
BOOL HighlightCell(struct MineFieldData * data, int x, int y)
{
    BOOL redraw = FALSE;

    /*
        check if the cell is within the mine field
    */
    if (CELL_IN_FIELD(data, x, y))
    {
        USHORT * pcell = &data->CellArray[CELL_INDEX(data, x, y)];
        /*
            check if the cell is covered and not highlighted and if so then
            highlight the cell and set the redraw flags
        */
        if ((*pcell & CELLM_STATE) == 0  &&
            (*pcell & CELLF_HIGHLIGHT) == 0)
        {
            *pcell |= (CELLF_HIGHLIGHT | CELLF_REDRAW);
            redraw = TRUE;
        }
    }

    return redraw;
}

/*
    function :    removes highlight from the cell at the given co-ordinates
                  if it is still covered and highlighted

    parameters :  data = pointer to the mine field data
                  x, y = cell co-ordinates of the cell to unhighlight

    return :      TRUE if the mine field needs to be redrawn
*/
BOOL UnhighlightCell(struct MineFieldData * data, int x, int y)
{
    BOOL redraw = FALSE;

    /*
        check if the cell is within the mine field
    */
    if (CELL_IN_FIELD(data, x, y))
    {
        USHORT * pcell = &data->CellArray[CELL_INDEX(data, x, y)];
        /*
            check if the cell is covered and highlighted and if so then
            unhighlight the cell and set the redraw flags
        */
        if ((*pcell & CELLM_STATE) == 0  &&
            (*pcell & CELLF_HIGHLIGHT) != 0)
        {
            *pcell &= ~CELLF_HIGHLIGHT;
            *pcell |= CELLF_REDRAW;
            redraw = TRUE;
        }
    }

    return redraw;
}

/*
    function :    check if the mouse has moved from the previous hit cell
                  and if it has then update the hit cell and the highlighting

    parameters :  data = pointer to the mine field data
                  x, y = cell co-ordinates of the new hit cell

    return :      TRUE if the mine field needs to be redrawn
*/
BOOL CheckMouseMove(struct MineFieldData * data, int x, int y)
{
    BOOL redraw = FALSE;

    /*
        check if the hit cell has changed
    */
    if (x != data->HitCellX  ||  y != data->HitCellY)
    {
        /*
            if the shift key was pressed then we remove the highlight
            from the old hit cell and neighbors and highlight the new
            hit cell and neighbors otherwise if the shift key was not
            pressed then we remove the highlight from the old hit cell
            and highlight the new hit cell
        */
        if ((data->Flags & MFF_INP_SHIFT) != 0)
        {
            if (UnhighlightNeighborhood(data, data->HitCellX, data->HitCellY))
            {
                redraw = TRUE;
            }
            if (HighlightNeighborhood(data, x, y))
            {
                redraw = TRUE;
            }
        }
        else
        {
            if (UnhighlightCell(data, data->HitCellX, data->HitCellY))
            {
                redraw = TRUE;
            }
            if (HighlightCell(data, x, y))
            {
                redraw = TRUE;
            }
        }

        /*
            update the hit cell
        */
        data->HitCellX = x;
        data->HitCellY = y;
    }

    return redraw;
}

/*
    function :    uncovers the given cell in the mine field if it is still
                  covered

    parameters :  data = pointer to the mine field data
                  x, y = cell co-ordinates of cell to uncover

    return :      UNCOVER_NONE   - nothing was changed, cell may be out of
                                   field or the cell is not covered
                  UNCOVER_REDRAW - the visual state of the mine field has
                                   changed and need to be redrawn
                  UNCOVER_WIN    - uncovering this cell won the game, this
                                   implies a redraw
                  UNCOVER_LOSE   - uncovering this cell lost the game, this
                                   implies a redraw
*/
int UncoverCell(struct MineFieldData * data, int x, int y)
{
    int rc;
    USHORT * pcell;

    if (!CELL_IN_FIELD(data, x, y))
    {
        return UNCOVER_NONE;
    }

    pcell = &data->CellArray[CELL_INDEX(data, x, y)];
    if ((*pcell & CELLM_STATE) != 0)
    {
        return UNCOVER_NONE;
    }

    /*
        check if cell is mined, if so then deep shit
    */
    if ((*pcell & CELLF_MINED) != 0)
    {
        int i;

        /*
            set cell exploded and return code to lost
        */
        *pcell |= (CELLF_EXPLODED | CELLF_REDRAW);
        rc = UNCOVER_LOSE;

        /*
            go through the cell array and uncover set any mined cells
            and check if flagged cells were correctly flagged
        */
        for (i = data->CellsAllocated, pcell = data->CellArray;
             i > 0;
             i--, pcell++)
        {
            if ((*pcell & CELLF_MINED) != 0)
            {
                *pcell |= (CELLF_UNCOVERED | CELLF_REDRAW);
            }
            else if ((*pcell & CELLF_FLAGGED) != 0)
            {
                *pcell &= ~CELLF_FLAGGED;
                *pcell |= (CELLF_FLAGERR | CELLF_REDRAW);
            }
        }
    }
    else /* cell not mined */
    {
        /*
            count this uncovered cell, set cell state to uncovered
            and the return code to redraw
        */
        data->CellsUncovered++;
        *pcell |= (CELLF_UNCOVERED | CELLF_REDRAW);
        rc = UNCOVER_REDRAW;

        /*
            check if this ends the game, the game ends when the number
            of uncovered cells equals the mine field size minus the
            number of mines
        */
        if (data->CellsUncovered == data->CellsAllocated - data->GameNumMines)
        {
            int i;

            /*
                set the return code to win
            */
            rc = UNCOVER_WIN;

            /*
                go through the cell array and set any unflagged mined
                cells to flagged
            */
            for ( i = data->CellsAllocated, pcell = data->CellArray;
                  i > 0;
                  i--, pcell++)
            {
                if ((*pcell & CELLF_MINED) != 0  &&
                    (*pcell & CELLF_FLAGGED) == 0)
                {
                    *pcell |= (CELLF_FLAGGED | CELLF_REDRAW);
                }
            }
        }
        /*
            game was not won, check if there are mined neighbors of
            this cell and if not then uncover any covered neighbors
        */
        else if ((*pcell & CELLM_NEIGHBORS) == 0)
        {
            int i, j, rc1;

            for (i = x - 1; i <= x + 1; i++)
            {
                for (j = y - 1; j <= y + 1; j++)
                {
                    rc1 = UncoverCell(data, i, j);
                    /*
                        check if this was an eventful uncover, i.e. did
                        it win or lose, note that if we get a lose here
                        then there must be a bug elsewhere
                    */
                    if (rc1 == UNCOVER_WIN  ||
                        rc1 == UNCOVER_LOSE)
                    {
                        return rc1;
                    }
                }
            }
        }
    }

    return rc;
}

/*
    function :    check if a cell is uncovered and if the number of mined
                  neighbors equals the number of flagged neighbors then
                  uncover any covered neighbors

    parameters :  data = pointer to the mine field data
                  x, y = cell co-ordinates of cell to check

    return :      UNCOVER_NONE   - nothing was changed, cell may be out of
                                   field, the cell may be flagged or covered,
                                   the cell may have no mined neighbors
                  UNCOVER_REDRAW - the visual state of the mine field has
                                   changed and need to be redrawn
                  UNCOVER_WIN    - uncovering this cell won the game, this
                                   implies a redraw
                  UNCOVER_LOSE   - uncovering this cell lost the game, this
                                   implies a redraw
*/
int UncoverCleared(struct MineFieldData * data, int x, int y)
{
    int rc = UNCOVER_NONE;
    USHORT * pcell = &data->CellArray[CELL_INDEX(data, x, y)];

    if (CELL_IN_FIELD(data, x, y)  &&
        (*pcell & CELLF_UNCOVERED) != 0  &&
        (*pcell & CELLM_NEIGHBORS) != 0)
    {
        int i, j, imin, imax, jmin, jmax, n;

        imin = (x > 0) ? x - 1 : 0;
        jmin = (y > 0) ? y - 1 : 0;
        imax = (x + 1 < data->GameWidth)  ? x + 1 : data->GameWidth - 1;
        jmax = (y + 1 < data->GameHeight) ? y + 1 : data->GameHeight - 1;

        /*
            count the number of flagged neighbors
        */
        n = 0;
        for (i = imin; i <= imax; i++)
        {
            for (j = jmin; j <= jmax; j++)
            {
                if ((data->CellArray[CELL_INDEX(data, i, j)]
                           & CELLF_FLAGGED) != 0)
                {
                    n++;
                }
            }
        }

        /*
            check if the number of mined neighbors equals the
            number of flagged neighbors and if they are then
            uncover any covered neighbors
        */
        if ((*pcell & CELLM_NEIGHBORS) == n)
        {
            for (i = imin; i <= imax; i++)
            {
                for (j = jmin; j <= jmax; j++)
                {
                    n = UncoverCell(data, i, j);

                    /*
                        check for eventful uncover
                    */
                    if (n == UNCOVER_WIN  ||
                        n == UNCOVER_LOSE)
                    {
                        return n;
                    }
                    else if (n == UNCOVER_REDRAW)
                    {
                        rc = UNCOVER_REDRAW;
                    }
                }
            }
        }
    }

    return rc;
}


/*
    function :    get the image index for a cell

    parameters :  cell = cell data

    return :      image index for the cell
*/
int GetCellImage(USHORT cell)
{
    int idx = IMAGEIDX_COVERED;

    if ((cell & CELLF_EXPLODED) != 0)
    {
        /*
            cell has exploded
        */
        idx = IMAGEIDX_EXPLODED;
    }
    else if ((cell & CELLF_FLAGGED) != 0)
    {
        /*
            cell is flagged as mined
        */
        idx = IMAGEIDX_FLAGGED;
    }
    else if ((cell & CELLF_FLAGERR) != 0)
    {
        /*
            cell was incorrectly flagged as mined
        */
        idx = IMAGEIDX_FLAGERR;
    }
    else if ((cell & CELLF_UNCOVERED) != 0)
    {
        /*
            cell has been uncovered, show a mine if mined else show the
            number of mined neighbors
        */
        idx = ((cell & CELLF_MINED) != 0) ? IMAGEIDX_MINED
                                          : IMAGEIDX_NONEIGHBOR +
                                                (cell & CELLM_NEIGHBORS);
    }
    else if ((cell & CELLF_HIGHLIGHT) != 0)
    {
        /*
            cell is highlighted
        */
        idx = IMAGEIDX_HIGHLIGHT;
    }
    return idx;
}


void DrawAll(Object * obj, struct MineFieldData * data)
{
    WORD rx, ry, rx0, ry0, bx;
    int i, j;
    struct RastPort * rp = _rp(obj);
    USHORT * pcell = data->CellArray;

    rx0 = (WORD)((_mleft(obj) + _mright(obj) + 1 - data->GameWidth * data->CellSizeX) / 2);
    ry0 = (WORD)((_mtop(obj) + _mbottom(obj) + 1 - data->GameHeight * data->CellSizeY) / 2);

    if (pcell)
    {
        for (j = data->GameHeight, ry = ry0;
             j > 0;
             j--, ry += data->CellSizeY)
        {
            for (i = data->GameWidth, rx = rx0;
                 i > 0;
                 i--, rx += data->CellSizeX)
            {
                bx = GetCellImage(*pcell++) * data->CellSizeX;
                BltBitMapRastPort(data->ImageBM, bx, 0, rp, rx, ry,
                                    (WORD)data->CellSizeX,
                                    (WORD)data->CellSizeY,
                                    (UBYTE)0xC0);
            }
        }
    }
    else
    {
        bx = IMAGEIDX_QUESTION * data->CellSizeX;
        for (j = data->GameHeight, ry = ry0;
             j > 0;
             j--, ry += data->CellSizeY)
        {
            for (i = data->GameHeight, rx = rx0;
                 i > 0;
                 i--, rx += data->CellSizeX)
            {
                BltBitMapRastPort(data->ImageBM, bx, 0, rp, rx, ry,
                                    (WORD)data->CellSizeX,
                                    (WORD)data->CellSizeY,
                                    (UBYTE)0xC0);
            }
        }
    }
}


/*
    function :    if the given cell is not mined then count the number of
                  neighboring cells that are mined

    parameters :  data = pointer to the mine field data
                  x, y = cell co-ordinate of cell to check and count
*/
void CountMinedNeighbors(struct MineFieldData * data, int x, int y)
{
    USHORT * pcell = &data->CellArray[CELL_INDEX(data, x, y)];

    /*
        make sure cell is not mined
    */
    if ((*pcell & CELLF_MINED) == 0)
    {
        int i, n = 0;

        /*
            count mined neighbors in the column to the left of this cell
            if this cell is not in the left most column
        */
        if (x > 0)
        {
            i = x - 1;

            if (y > 0  &&
                (data->CellArray[CELL_INDEX(data, i, y-1)] & CELLF_MINED) != 0)
            {
                n++;
            }

            if ((data->CellArray[CELL_INDEX(data, i, y)] & CELLF_MINED) != 0)
            {
                n++;
            }

            if (y + 1 < data->GameHeight  &&
                (data->CellArray[CELL_INDEX(data, i, y+1)] & CELLF_MINED) != 0)
            {
                n++;
            }
        }

        /*
            count mined neighbors in the same column as this cell
        */
        if (y > 0  &&
            (data->CellArray[CELL_INDEX(data, x, y-1)] & CELLF_MINED) != 0)
        {
            n++;
        }
        if (y + 1 < data->GameHeight  &&
            (data->CellArray[CELL_INDEX(data, x, y+1)] & CELLF_MINED) != 0)
        {
            n++;
        }

        /*
            count mined neighbors in column to the right of this cell
            if this cell is not in the right most column
        */
        if (x + 1 < data->GameWidth)
        {
            i = x + 1;

            if (y > 0  &&
                (data->CellArray[CELL_INDEX(data, i, y-1)] & CELLF_MINED) != 0)
            {
                n++;
            }

            if ((data->CellArray[CELL_INDEX(data, i, y)] & CELLF_MINED) != 0)
            {
                n++;
            }

            if (y + 1 < data->GameHeight  &&
                (data->CellArray[CELL_INDEX(data, i, y+1)] & CELLF_MINED) != 0)
            {
                n++;
            }
        }

        /*
            set count of mined neighbors in cell data
        */
        *pcell &= ~CELLM_NEIGHBORS;
        *pcell |= (USHORT)n;
    }
}

/*
    function :    start the game running, enables right mouse trapping,
                  starts the timer, set game state attributes

    parameters :  obj = pointer to the MineField object
                  data = pointer to the mine field data
*/
void StartGameRunning(Object * obj, struct MineFieldData * data)
{
    struct Window * win = _window(obj);
    Forbid();
    win->Flags |= WFLG_RMBTRAP;
    Permit();

    DoMethod(_app(obj), MUIM_Application_AddInputHandler, &data->ihn);
    SetAttrs(obj, MUIA_MineField_GameInitialized, FALSE,
                  MUIA_MineField_GameLost, FALSE,
                  MUIA_MineField_GameWon, FALSE,
                  MUIA_MineField_GameRunning, TRUE,
                  TAG_DONE);
}

/*
    function :    stops game running, disable right mouse trapping,
                  stops timer, clears the game running state attribute

    parameters :  obj = pointer to the MineField object
                  data = pointer to the mine field data
*/
void StopGameRunning(Object * obj, struct MineFieldData * data)
{
    struct Window * win = _window(obj);

    Forbid();
    win->Flags &= ~WFLG_RMBTRAP;
    Permit();
    DoMethod(_app(obj), MUIM_Application_RemInputHandler,
                        &data->ihn);
    SetAttrs(obj, MUIA_MineField_GameRunning, FALSE, TAG_DONE);
}



#define RANDOM_MULT    241736421

static unsigned int randomseed;

/*
    function :    initialize the random number seed
*/
void InitRandom()
{
    ULONG count1 = (ULONG)SysBase->Elapsed;
    ULONG count2 = SysBase->IdleCount + SysBase->DispCount;
    randomseed = (int)((count1 << 14) ^ (count1 << 4) ^ count2);
}

/*
    function :    generate a zero based random integer

    parameters :  range = range of randum numbers, the generated
                          number will be 0 <= number < range

    return :      the random integer
*/
int RandomInt(int range)
{
    unsigned int i, r;
    r = (range < 0) ? -range : range;
    randomseed = randomseed * RANDOM_MULT + 1;
    i = randomseed % r;
    return (int)i;
}


/*
    function :    creates the MineField MUI custom class

    return :      pointer to the created custom class or NULL
*/
struct MUI_CustomClass * CreateMineFieldClass()
{
    return MUI_CreateCustomClass(NULL, MUIC_Area, NULL,
                                       sizeof(struct MineFieldData),
                                       MineFieldDispatcher);
}

/*
    function :    deletes of the MineField custom class

    parameters :  mcc = pointer to the MineField MUI_CustomClass to delete
*/
void DeleteMineFieldClass(struct MUI_CustomClass * mcc)
{
    MUI_DeleteCustomClass(mcc);
}

