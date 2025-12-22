/*
    X-Mines / Minesweeper type game for MUI
*/

#include "MUIMine.h"
#include "MFWindow.h"
#include "MFStrings.h"


#define MUIMINE_TITLE       (STRPTR)"MUIMine"
#define MUIMINE_VERSION     (STRPTR)"$VER: MUIMine 1.0 (28.11.98)"
#define MUIMINE_COPYRIGHT   (STRPTR)"©1998, Geoffrey Whaite"
#define MUIMINE_AUTHOR      (STRPTR)"Geoffrey Whaite"
#define MUIMINE_DESCRIPTION (STRPTR)"Clear the mine field game."
#define MUIMINE_BASE        (STRPTR)"MUIMINE"


#ifndef _DCC

struct Library *MUIMasterBase = NULL;
struct Library *DataTypesBase = NULL;

#endif /* _DCC */


/*************************/
/* Init & Fail Functions */
/*************************/

static void fail(APTR app, char *str)
{
    if (app)
    {
        MUI_DisposeObject(app);
    }

#ifndef _DCC

    if (MUIMasterBase)
    {
        CloseLibrary(MUIMasterBase);
    }

    if (DataTypesBase)
    {
        CloseLibrary(DataTypesBase);
    }

#endif

    CloseStrings();

    if (str)
    {
        puts(str);
        exit(20);
    }

    exit(0);
}


#ifdef _DCC

int brkfunc(void) { return(0); }

int wbmain(struct WBStartup *wb_startup)
{
        extern int main(int argc, char *argv[]);
        return (main(0, (char **)wb_startup));
}

#endif


#ifdef __SASC
int CXBRK(void) { return(0); }
int _CXBRK(void) { return(0); }
void chkabort(void) {}
#endif


static VOID init(VOID)
{
#ifdef _DCC

    onbreak(brkfunc);

#endif

#ifndef _DCC

    if (!(MUIMasterBase = OpenLibrary(MUIMASTER_NAME,MUIMASTER_VMIN)))
    {
        fail(NULL, "Failed to open "MUIMASTER_NAME".");
    }

    if (!(DataTypesBase = OpenLibrary("datatypes.library", 0)))
    {
        fail(NULL, "Failed to open datatypes.library.");
    }

#endif

    OpenStrings();
}


#ifndef __SASC
static VOID stccpy(char *dest,char *source,int len)
{
    strncpy(dest,source,len);
    dest[len-1]='\0';
}
#endif


LONG __stack = 20000;



int main(int argc, char *argv[])
{
    APTR app, window /*, minesString, timeString, startButton, minefield */;
    struct MUI_CustomClass *mccMFWindow;

    init();

    if (!(mccMFWindow = CreateMFWindowClass()))
    {
        fail(NULL,"Could not create MFWindow class.");
    }

    app = ApplicationObject,
        MUIA_Application_Title      , MUIMINE_TITLE,
        MUIA_Application_Version    , MUIMINE_VERSION,
        MUIA_Application_Copyright  , MUIMINE_COPYRIGHT,
        MUIA_Application_Author     , MUIMINE_AUTHOR,
        MUIA_Application_Description, MUIMINE_DESCRIPTION,
        MUIA_Application_Base       , MUIMINE_BASE,

        SubWindow, window = NewObject(mccMFWindow->mcc_Class,NULL, TAG_DONE),

        End;

    if (!app)
    {
        fail(app,"Failed to create Application.");
    }

    DoMethod(window, MUIM_Notify,MUIA_Window_CloseRequest, TRUE,
                app, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);

/*
** This is the ideal input loop for an object oriented MUI application.
** Everything is encapsulated in classes, no return ids need to be used,
** we just check if the program shall terminate.
** Note that MUIM_Application_NewInput expects sigs to contain the result
** from Wait() (or 0). This makes the input loop significantly faster.
*/

    SetAttrs(window, MUIA_Window_Open, TRUE, TAG_DONE);

    {
        ULONG sigs = 0;

        while (DoMethod(app, MUIM_Application_NewInput, &sigs)
                        != MUIV_Application_ReturnID_Quit)
        {
            if (sigs)
            {
                sigs = Wait(sigs | SIGBREAKF_CTRL_C);
                if (sigs & SIGBREAKF_CTRL_C) break;
            }
        }
    }

    SetAttrs(window, MUIA_Window_Open, FALSE, TAG_DONE);


/*
** Shut down...
*/

    MUI_DisposeObject(app);             /* dispose all objects. */
    DeleteMFWindowClass(mccMFWindow);  /* delete the custom class. */
    fail(NULL,NULL);                    /* exit, app is already disposed. */
}

/****************************************************************************

    support functions

****************************************************************************/


ULONG __stdargs DoSuperNew(struct IClass *cl,Object *obj,ULONG tag1,...)
{
        return(DoSuperMethod(cl,obj,OM_NEW,&tag1,NULL));
}



/*
    function :    loads a picture file and remap for a screen using datatypes

    parameters :  data = pointer to struct LoadBitMapData which has its
                         FileName field initialized to the picture file
                         name and its Screen field initialized to the
                         screen the bitmap is to be remapped to

    return :      LBMERR_NONE if the function succeded, error code otherwise

                    If the function succedes the DTObject, BitMapHeader
                    and BitMap fields of data are set to the picture data

                    If the function fails the DTObject, BitMapHeader and
                    BitMap fields of the struct LoadBitMapData are set to
                    NULL
*/
#define PROG_DIR            "PROGDIR:"
#define DEFAULT_IMAGE_DIR   "PROGDIR:Images"
int LoadBitMap(struct LoadBitMapData * data)
{
    int ret = LBMERR_NONE;

    BPTR lock;
    STRPTR fname, afname = NULL;

    /*
        check for correctly initialized parameters
    */
    if (data == NULL  ||  data->FileName == NULL  ||  data->Screen == NULL)
    {
        return LBMERR_PARAM;
    }

    /*
        initialize return fields
    */
    data->DTObject = NULL;
    data->BitMapHeader = NULL;
    data->BitMap = NULL;

    fname = data->FileName;

    /*
        try to locate the file, first try the file name as given and if that
        fails and the file name specifies a name only then look for a file
        with that name in the 'PROGDIR:Images' sub-drectory
    */
    lock = Lock(fname, ACCESS_READ);
    if (lock == NULL)
    {
        /*
            could not locate the file name as given, check if only file name
            given
        */
        STRPTR fpart;

        fpart = FilePart(fname);
        if (fpart == fname)
        {
            /*
                file name only, try in PROGDIR: and then in "PROGDIR:Images"
            */
            int l = strlen(fname) + strlen(PROG_DIR) + 8;
            afname = AllocVec(l, 0);
            if (afname)
            {
                strcpy(afname, PROG_DIR);
                if (AddPart(afname, fname, l))
                {
                    lock = Lock(afname, ACCESS_READ);
                    if (lock == NULL)
                    {
                        FreeVec(afname);
                        afname = NULL;
                    }
                }
            }
            if (lock == NULL)
            {
                l = strlen(fname) + strlen(DEFAULT_IMAGE_DIR) + 8;
                afname = AllocVec(l, 0);
                if (afname)
                {
                    strcpy(afname, DEFAULT_IMAGE_DIR);
                    if (AddPart(afname, fname, l))
                    {
                        lock = Lock(afname, ACCESS_READ);
                        if (lock == NULL)
                        {
                            FreeVec(afname);
                            afname = NULL;
                        }
                    }
                }
                else
                {
                    ret = LBMERR_ALLOC;
                }
            }
        }
    }

    /*
        check if the picture file was found, if it was NOT then set the
        return error code
    */
    if (lock == NULL)
    {
        /*
            if the error code was not set then set it to a 'no file' error
        */
        if (ret == LBMERR_NONE)
        {
            ret = LBMERR_NOFILE;
        }
    }
    else
    {
        UnLock(lock);   // release lock now that the file has been found

        /*
            try to load the file as a picture datatype
        */
        if (data->DTObject = NewDTObject((afname) ? afname : fname,
                                                DTA_SourceType       ,DTST_FILE,
                                                DTA_GroupID          ,GID_PICTURE,
                                                PDTA_Remap           ,TRUE,
                                                PDTA_Screen          ,data->Screen,
                                                PDTA_FreeSourceBitMap,TRUE,
                                                PDTA_DestMode        ,MODE_V43,
                                                PDTA_UseFriendBitMap ,TRUE,
                                                OBP_Precision        ,PRECISION_IMAGE,
                                                TAG_DONE))
        {
            /*
                picture datatype loaded ok, now layout to screen
            */
            if (DoMethod(data->DTObject, DTM_PROCLAYOUT, NULL, 1))
            {
                /*
                    get the bit map header and the bit map from the datatype
                */
                GetDTAttrs(data->DTObject,
                                PDTA_BitMapHeader, &data->BitMapHeader,
                                TAG_DONE);
                if (data->BitMapHeader)
                {
                    GetDTAttrs(data->DTObject, PDTA_DestBitMap, &data->BitMap, TAG_DONE);
                    if (!data->BitMap)
                    {
                        GetDTAttrs(data->DTObject, PDTA_BitMap, &data->BitMap, TAG_DONE);
                        if (!data->BitMap)
                        {
                            data->BitMapHeader = NULL;
                            ret = LBMERR_BITMAP;
                        }
                    }
                }
                else
                {
                    ret = LBMERR_BITMAPHEADER;
                }
            }
            else
            {
                ret = LBMERR_LAYOUT;
            }

            /*
                dispose of the datatype object if an error occured
            */
            if (ret != LBMERR_NONE)
            {
                DisposeDTObject(data->DTObject);
                data->DTObject = NULL;
            }
        }
        else
        {
            ret = LBMERR_DTLOAD;
        }
    }

    /*
        free the file name if allocated
    */
    if (afname)
    {
        FreeVec(afname);
    }

    return ret;
}


