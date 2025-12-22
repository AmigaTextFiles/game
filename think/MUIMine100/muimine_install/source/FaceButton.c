/*
    MUI custom class for X-Mines Face Button
*/

#include "MUIMine.h"
#include "FaceButton.h"


/*
    Instance data
*/
struct FaceButtonData
{
    int     Width, Height;          // width and height of button image
    int     ImageIdx;               // index of image to show
    int     SelSaveImageIdx;        // saves the origional index during select
    STRPTR  ImageFile;              // name of imagery picture file
    struct Screen * RenderScreen;   // screen bitmap was rendered to
    Object * ImageDTObject;         // picture data type object for imagery
    struct BitMap * ImageBM;        // bitmap containing face imagery
};

/*
    defines for defaults 
*/
#define DEFAULT_IMAGEFILE (STRPTR)"def_FaceButtonImage"
#define DEFAULT_IMAGEDIR  (STRPTR)"Images"


/*
    defines for image indexes
*/
#define IMAGEIDX_NORMAL     MUIV_FaceButton_ImageIdx_Normal
#define IMAGEIDX_SELECTED   MUIV_FaceButton_ImageIdx_Selected
#define IMAGEIDX_OH         MUIV_FaceButton_ImageIdx_Oh
#define IMAGEIDX_GOOD       MUIV_FaceButton_ImageIdx_Good
#define IMAGEIDX_BAD        MUIV_FaceButton_ImageIdx_Bad

#define IMAGE_COUNT         5


/*
    other defines
*/



/*
    private function prototypes
*/
BOOL InitFaceButtonImageBM(struct FaceButtonData * data, struct Screen * rscreen);
void FreeFaceButtonImageBM(struct FaceButtonData * data);



/*
    function :    OM_NEW method handler for FaceButton class
*/
static ULONG mNew(struct IClass *cl, Object *obj, struct opSet *msg)
{
    int i;
    struct FaceButtonData *data;
    STRPTR fname;

    if (!(obj = (Object *)DoSuperMethodA(cl, obj, (APTR)msg)))
    {
        return 0;
    }

    data = INST_DATA(cl, obj);

    data->Height = data->Width = 0;
    data->ImageIdx = data->SelSaveImageIdx = 0;
    data->RenderScreen = NULL;
    data->ImageFile = NULL;
    data->ImageDTObject = NULL;
    data->ImageBM = NULL;

    fname = (STRPTR)GetTagData(MUIA_FaceButton_ImageFile, NULL,
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
    function :    OM_DELETE method handler for FaceButton class
*/
static ULONG mDispose(struct IClass *cl, Object *obj, Msg msg)
{
    struct FaceButtonData *data = INST_DATA(cl, obj);

    FreeFaceButtonImageBM(data);

    if (data->ImageFile)
    {
        FreeVec(data->ImageFile);
    }

    return DoSuperMethodA(cl, obj, msg);
}


/*
    function :    MUIM_Setup method handler for FaceButton class
*/
static ULONG mSetup(struct IClass *cl, Object *obj, struct MUIP_Setup * msg)
{
    struct FaceButtonData *data = INST_DATA(cl, obj);

    if (!(DoSuperMethodA(cl, obj, (APTR)msg)))
    {
        return FALSE;
    }

    if (!InitFaceButtonImageBM(data, msg->RenderInfo->mri_Screen))
    {
        CoerceMethod(cl, obj, MUIM_Cleanup);
        return FALSE;
    }

    MUI_RequestIDCMP(obj, IDCMP_MOUSEBUTTONS);

    return TRUE;
}


/*
    function :    MUIM_Cleanup method handler for FaceButton class
*/
static ULONG mCleanup(struct IClass *cl, Object *obj, Msg msg)
{
//    struct FaceButtonData *data = INST_DATA(cl, obj);

    MUI_RejectIDCMP(obj, IDCMP_MOUSEBUTTONS);

    return(DoSuperMethodA(cl, obj, msg));
}

/*
    function :    MUIM_AskMinMax method handler for FaceButton class
*/
static ULONG mAskMinMax(struct IClass *cl, Object *obj, struct MUIP_AskMinMax *msg)
{
    struct FaceButtonData *data = INST_DATA(cl, obj);

    /*
    ** let our superclass first fill in what it thinks about sizes.
    ** this will e.g. add the size of frame and inner spacing.
    */

    DoSuperMethodA(cl, obj, (APTR)msg);

    /*
    ** now add the values specific to our object. note that we
    ** indeed need to *add* these values, not just set them!
    */

    msg->MinMaxInfo->MinWidth  += data->Width;
    msg->MinMaxInfo->DefWidth  += data->Width;
    msg->MinMaxInfo->MaxWidth  += data->Width;

    msg->MinMaxInfo->MinHeight += data->Height;
    msg->MinMaxInfo->DefHeight += data->Height;
    msg->MinMaxInfo->MaxHeight += data->Height;

    return 0;
}


/*
    function :    OM_SET method handler for FaceButton class
*/
static ULONG mSet(struct IClass *cl, Object *obj, struct opSet * msg)
{
    struct FaceButtonData *data = INST_DATA(cl,obj);
    struct TagItem *tags, *tag;

    for (tags = msg->ops_AttrList; tag = NextTagItem(&tags); )
    {
        switch (tag->ti_Tag)
        {
            case MUIA_FaceButton_ImageIdx:
                if (data->ImageIdx != (int)tag->ti_Data)
                {
                    data->ImageIdx = (int)tag->ti_Data;
                    MUI_Redraw(obj, MADF_DRAWOBJECT);
                }
                break;
 
            case MUIA_Selected:
                if (tag->ti_Data)
                {
                    data->SelSaveImageIdx = data->ImageIdx;
                    data->ImageIdx = IMAGEIDX_SELECTED;
                }
                else
                {
                    data->ImageIdx = data->SelSaveImageIdx;
                }
                MUI_Redraw(obj, MADF_DRAWOBJECT);
                break;
        }
    }

    return DoSuperMethodA(cl, obj, (APTR)msg);
}


/*
    function :    MUIM_Draw method handler for FaceButton class
*/
static ULONG mDraw(struct IClass *cl, Object *obj, struct MUIP_Draw *msg)
{
    struct FaceButtonData *data = INST_DATA(cl, obj);

    /*
    ** let our superclass draw itself first, area class would
    ** e.g. draw the frame and clear the whole region. What
    ** it does exactly depends on msg->flags.
    */

    DoSuperMethodA(cl,obj,(APTR)msg);

    /*
    ** only re-draw if MADF_DRAWOBJECT is set
    */

    if (msg->flags & MADF_DRAWOBJECT)
    {
        WORD bx;

        /*
            determine the co-ordinates of the image in the bit map
        */
        bx = (WORD)((data->ImageIdx >= 0  && data->ImageIdx <= IMAGE_COUNT)
                            ? data->Width * data->ImageIdx : 0);

        /*
            blit the image from the bitmap to the rastport
        */
        BltBitMapRastPort(data->ImageBM, bx, 0,
                          _rp(obj), (WORD)(_mleft(obj)), (WORD)(_top(obj)),
                          (WORD)data->Width, (WORD)data->Height,
                          (UBYTE)0xC0);
    }

    return 0;
}


SAVEDS ASM ULONG FaceButtonDispatcher(
        REG(a0) struct IClass *cl,
        REG(a2) Object *obj,
        REG(a1) Msg msg)
{
    switch (msg->MethodID)
    {
        case OM_NEW          : return        mNew(cl, obj, (APTR)msg);
        case OM_DISPOSE      : return    mDispose(cl, obj, (APTR)msg);
        case OM_SET          : return        mSet(cl, obj, (APTR)msg);
        case MUIM_Setup      : return      mSetup(cl, obj, (APTR)msg);
        case MUIM_Cleanup    : return    mCleanup(cl, obj, (APTR)msg);
        case MUIM_AskMinMax  : return  mAskMinMax(cl, obj, (APTR)msg);
        case MUIM_Draw       : return       mDraw(cl, obj, (APTR)msg);
    }

    return DoSuperMethodA(cl, obj, msg);
}


/*
    function :    initialize the bitmap used for rendering the button faces

    parameters :  data = pointer to the FaceButton data to initialize bitmap for
                  rscreen = pointer to the screen to render the bitmap to

    return :      TRUE if bitmap initialized ok, FALSE if an error occured
*/
BOOL InitFaceButtonImageBM(struct FaceButtonData * data, struct Screen * rscreen)
{
    if (data->RenderScreen == NULL  ||  rscreen != data->RenderScreen)
    {
        struct LoadBitMapData lbmdata;
        int rc;

        FreeFaceButtonImageBM(data);

        lbmdata.FileName = (data->ImageFile) ? data->ImageFile : DEFAULT_IMAGEFILE;
        lbmdata.Screen = rscreen;

        rc = LoadBitMap(&lbmdata);
        if (rc == LBMERR_NONE)
        {
            if ((lbmdata.BitMapHeader->bmh_Width % IMAGE_COUNT) == 0)
            {
                data->Width  = lbmdata.BitMapHeader->bmh_Width / IMAGE_COUNT;
                data->Height = lbmdata.BitMapHeader->bmh_Height;
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
    function :    frees bitmap data allocated by InitFaceButtonImageBM()

    parameters :  data = pointer to the FaceButton data to free bitmap for

    return :      none
*/
void FreeFaceButtonImageBM(struct FaceButtonData * data)
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
    function :    creates the FaceButton MUI custom class

    return :      pointer to the created custom class or NULL
*/
struct MUI_CustomClass * CreateFaceButtonClass()
{
    return MUI_CreateCustomClass(NULL, MUIC_Area, NULL,
                                       sizeof(struct FaceButtonData),
                                       FaceButtonDispatcher);
}

/*
    function :    deletes of the FaceButton custom class

    parameters :  mcc = pointer to the FaceButton MUI_CustomClass to delete
*/
void DeleteFaceButtonClass(struct MUI_CustomClass * mcc)
{
    MUI_DeleteCustomClass(mcc);
}

