/*
 *  AMIGA Libs & Functions for Scott-Free
 *
 *  ===================================================================
 *
 *  Version History AMIGA:
 *  Ver ,     Date,     Author, Comment
 *  -------------------------------------------------------------------
 *  1.91 e precedenti: Andreas Aumayr
 *  1.92, 28/10/2002 Betori Alessandro, italian version 
 *  ___________________________________________________________________
 */

#define  MAX_HIST 20
#define  MAX_LL   40
#define  PIC       8
#define  COC       7
#define  OVL       6
#define  ANI       5
#define  GOT       4
#define  MOVE      0xc0
#define  FILL      0xc1
#define  NEWPIC    0xff
#define  custom    (*((struct Custom *) 0xDFF000L))

#include <exec/memory.h>
#include <pragma/exec_lib.h>
#include <intuition/intuition.h>
#include <graphics/GfxBase.h>
#include <graphics/rpattr.h>
#include <graphics/gfxmacros.h>
#include <graphics/gfx.h>
#include <hardware/dmabits.h>
#include <hardware/custom.h>
#include <workbench/workbench.h>
#include <libraries/dos.h>
#include <libraries/dosextens.h>
#include <dos/exall.h>
#include <utility/tagitem.h>
#include <libraries/asl.h>
#include <libraries/gadtools.h>
#include <workbench/startup.h>
#include <libraries/amigaguide.h>
#include <datatypes/pictureclass.h>
#include <devices/inputevent.h>
#include <exec/types.h>
#include <devices/narrator.h>
#include <libraries/translator.h>
#include "gui.c"


extern void *indirizzo_puntatore[1024];//Betori
int contatore;//Betori

room_pics *rp;
extern struct MsgPort *CreatePort();
extern struct IORequest *CreateExtIO();

 



struct MsgPort *narratorPort;
struct RastPort *rastPort;
struct TmpRas tmp;


struct narrator_rb *request;



STRPTR nartrans[1024];
ULONG  narBuf;
BYTE   channels[4] = {3,5,10,12};

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;


struct Library* DiskfontBase=NULL;//NULL by Betori
struct Library* IconBase=NULL;//NULL by Betori
struct Library* Dos_Base=NULL;//NULL by Betori
struct Library* UtilityBase=NULL;//NULL by Betori
struct Library* AslBase=NULL;//NULL by Betori
struct Library* GadToolsBase=NULL;//NULL by Betori
struct Library* AmigaGuideBase=NULL;//NULL by Betori
struct Library* DataTypesBase=NULL;//NULL by Betori
struct Library* TranslatorBase=NULL;//NULL by Betori

struct Screen *WBscreen = NULL;
struct Screen *ScottScreen = NULL;
ULONG  old_pubmode;
struct Window *act_w_hdl=NULL;//NULL by Betori
struct Window *pic_w_hdl = NULL;
APTR   WBvisinfo = NULL;
struct TextFont *textfont = NULL;
char   save_game[32] = "";
char   data_file[32] = "",data_dir[256] = "";
char   save_dir[256] = "";
char   gfx_file[256] = "";
char   FFP[256];

char   hist[MAX_HIST][MAX_LL+1];
int    hist_pos=0,hist_fill=0;

struct Menu *menu = NULL;
char   Version[] = "$VER: AMIGA SCOTT-Free V1.92 (italiana), 2002";
char   GameInfoStr[256] = "";

struct WBStartup *WBMessage;
struct MsgPort *OldUserPort;
BOOL   WBSTART  = FALSE;
BOOL   RESTART  = TRUE;
BOOL   LINEWRAP = TRUE;
BOOL   GFX      = TRUE;
BOOL   SPEECH   = FALSE;
ULONG  Disp_ID;
BOOL   FASTCOLOURS = FALSE;
BOOL   LDP;
//BOOL   NOGFXPOS = FALSE;
//BOOL   INIT = FALSE;
//BOOL   GFXDOUBLE = FALSE;
char   restart_file[42] = "RAM:";
BPTR   restart_lock;

struct NewAmigaGuide scott_guide = {NULL};
int    last_pic = -128;
ULONG  *go = NULL;//NULL Betori era 0
LONG   Pens[16] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
UBYTE  NumColours = 0;
UBYTE  planesN = 0;
struct ColorRegister CR[16];
struct BitMap bitmapN;
int    gfx_width = 0,gfx_height = 0;
WORD   win_pos_ver,win_pos_hor;
int    win_width = -1,win_height;
BYTE   ScreenAspect;
UBYTE  *picture = NULL,*rle_dat = NULL,*overlay = NULL;//Betori erano tutti e tre =0
WORD   w_top;
int    nroom;
LONG   Rmem = 0;
UBYTE  border_width, bar_height;
char    **font_name=NULL;//NULL Betori
char    **cscreen=NULL;//NULL Betori

FILE   *gfx_in_file=NULL;//NULL Betori

/// Make_FFP
void Make_FFP(char *file, char *dir)
{
  strcpy(FFP,dir);
  AddPart(FFP,file,256);
}///

/// GFX_Off
void GFX_Off(void)
{
    GFX = FALSE;
    OffMenu(act_w_hdl,63491);
}///

///CountPlanes
UBYTE CountPlanes(UBYTE Cols)
{
    UBYTE i;

    Cols--;
    for (i=0;i<8;i++) {
        if (Cols & (128>>i)) break;
    }
    return((UBYTE) (8-i));
}
///



/// NoSpeech
void NoSpeech(BYTE status)
{
    switch(status) {
        case 0:
            CloseDevice((IORequest*)request);
        case 1:
            DeleteExtIO(request);
        case 2:
            DeletePort(narratorPort);
        case 3:
            CloseLibrary(TranslatorBase);
            TranslatorBase = 0;
            SPEECH = FALSE;
    }
}///

/// close_libs
void close_libs(void)
{
        if (TranslatorBase) NoSpeech(0);
        if (AmigaGuideBase) CloseLibrary(AmigaGuideBase);
        if (GadToolsBase) CloseLibrary(GadToolsBase);
        if (AslBase) CloseLibrary(AslBase);
        if (UtilityBase) CloseLibrary(UtilityBase);
        if (Dos_Base) CloseLibrary(Dos_Base);
        if (IconBase) CloseLibrary(IconBase);
        if (DiskfontBase) CloseLibrary(DiskfontBase);
        if (GfxBase) CloseLibrary((struct Library*)GfxBase);
        if (IntuitionBase) CloseLibrary((struct Library*)IntuitionBase);
}///

/// open_libs
BOOL open_libs(void)
{
                IntuitionBase = (struct IntuitionBase *) OpenLibrary("intuition.library",37);
                if (IntuitionBase == NULL) {
                        printf("Problemi aprendo Intuition-Lib!\n");
                        return(FALSE);
                }
                GfxBase = (struct GfxBase *) OpenLibrary("graphics.library",37);
                if (GfxBase == NULL) {
                        printf("Problemi aprendo GFX-Lib!\n");
                        return(FALSE);
                }
                DiskfontBase = (struct Library *) OpenLibrary("diskfont.library",0);
                if (DiskfontBase == 0) {
                        EasyRequest(NULL,&Library,NULL,"DiskFont");
                        return(FALSE);
                }
                IconBase = (struct Library *)OpenLibrary("icon.library",0);
                if (IconBase == 0) {
                        printf("Problemi aprendo Icon-Lib!\n");
                        return(FALSE);
                }
                Dos_Base = (struct Library *)OpenLibrary("dos.library",0);
                if (Dos_Base == 0) {
                        printf("Problemi aprendo DOS-Lib!\n");
                        return(FALSE);
                }
                UtilityBase = (struct Library *)OpenLibrary("utility.library",0);
                if (UtilityBase == 0) {
                        printf("Problemi aprendo Utility-Lib!\n");
                        return(FALSE);
                }
                AslBase = (struct Library *)OpenLibrary("asl.library",0);
                if (AslBase == 0) {
                        EasyRequest(NULL,&Library,NULL,"ASL");
                        return(FALSE);
                }
                GadToolsBase = (struct Library *)OpenLibrary("gadtools.library",36);
                if (GadToolsBase == 0) {
                        printf("Problemi aprendo GadTools-Lib!\n");
                        return(FALSE);
                }
                AmigaGuideBase = (struct Library *)OpenLibrary("amigaguide.library",0);
                     if (AmigaGuideBase == 0) {//Betori
                        printf("Problemi aprendo AmigaGuide-Lib!\n");
                        return(FALSE);
                }
                TranslatorBase = (struct Library *)OpenLibrary("translator.library",0);
                if (TranslatorBase == 0) {//Betori
                        printf("Problemi aprendo Translator-Lib!\n");
                        return(FALSE);
                }
                    else {
                    narratorPort = (struct MsgPort *) CreatePort(0,0);
                    if (narratorPort == NULL) NoSpeech(3);
                    else {
                        request = (struct narrator_rb *) CreateExtIO(narratorPort, sizeof(struct narrator_rb));
                        if (request == NULL) NoSpeech(2);
                        else if (OpenDevice("narrator.device",0,(struct IORequest*)request,0)) NoSpeech(1);
                    }
                }
                return(TRUE);
}///

///FreeGFXRes
void FreeGFXRes(void)
{
    int     i;

    if (gfx_in_file) fclose(gfx_in_file);
    
    if (rp) free(rp);
    if (go) free(go);

    if (FASTCOLOURS) for (i=0;i<NumColours;i++) SetRGB4(&WBscreen->ViewPort,i,(Pens[i]&0x0F00)>>8,(Pens[i]&0x00F0)>>4,Pens[i]&0x000F);
    else {
        for (i=0; i<NumColours; i++) {
            if (Pens[i] > 0) ReleasePen(WBscreen->ViewPort.ColorMap,Pens[i]);
            else break;
        }
    }

    if (LDP) if (Rmem) FreeRaster((PLANEPTR)Rmem,gfx_width+1,gfx_height+1);
    else {
        for (i=0; i<planesN; i++) {
            if (bitmapN.Planes[i]) FreeRaster(bitmapN.Planes[i],gfx_width,gfx_height);
            else break;
        }
        //Betori, ci pensa la routine close_all a liberare tutta la memoria allocata
        //if (picture) FreeMem(picture,gfx_width*gfx_height);
        //if (rle_dat) FreeMem(rle_dat,gfx_width*gfx_height);
        //if (overlay) FreeMem(overlay,gfx_width*gfx_height);
    }
}///

/// close_all
void close_all(void)
{
    int i;
    //{ Betori
    for (i=0;i<1024;i++){
       if (indirizzo_puntatore[i]!=NULL)
          FreeVec(indirizzo_puntatore[i]);
    }//}
    if (restart_lock) UnLock(restart_lock);
    DeleteFile(restart_file);
    if (menu) FreeMenus(menu);
    if (WBvisinfo) FreeVisualInfo(WBvisinfo);
    if (WBscreen) UnlockPubScreen(NULL,WBscreen);
    if (textfont) CloseFont(textfont);
    if (pic_w_hdl) CloseWindow(pic_w_hdl);
    if (act_hdl) {
        act_w_hdl->UserPort = OldUserPort;
        Close((LONG)act_hdl);
    }
    if (env_hdl)
       Close((LONG)env_hdl);
    if (GFX) FreeGFXRes();
    SetPubScreenModes(old_pubmode);
    if (ScottScreen) {
        while (CloseScreen(ScottScreen) == FALSE) EasyRequest(NULL,&ClosePub,NULL,NULL);
    }
    close_libs();
}///

/// MemAlloc
void * MemAlloc(int size)
{
    void *t;
    //{
    indirizzo_puntatore[contatore]=t=(void *) AllocVec(size,MEMF_FAST|MEMF_CLEAR);
      if (t == NULL) {
        printf("\nMemoria esaurita!\nUscita dal programma.\n");
        EasyRequest(NULL,&NoMem,NULL,NULL);
        close_all();
        exit(128);
    }
    contatore++; 
    if (contatore>1024){
        printf("\nAllocazione memoria corrotta!\nUscita dal programma.\n");
        EasyRequest(NULL,&NoMem,NULL,NULL);
        close_all();
        exit(128);
    }
    //}Betori
    return(t);
}///

/// Open_CON
struct FileHandle *Open_CON(char *type, int left_off, int top_off, int width, int height, char *title, char *flags, char *cscreen)
{
    sprintf(str_buf,"%s:%d/%d/%d/%d/%s/%s/SCREEN %s",type,left_off,top_off,width,height,title,flags,cscreen);
    CON_handle = (struct FileHandle *) Open(str_buf,MODE_NEWFILE);//Betori
    if (!CON_handle) {
        printf("Fallita apertura della finestra di console '%s'!\n",title);
        EasyRequest(NULL,&ConFail,NULL,title);
        close_all();
        exit(99);
    }
    else return(CON_handle);
}///

///dyn_strings
void * dyn_strings(char *cont, BYTE add)
{
        void *mem_ptr;
        if (cont && strlen(cont)) {
                mem_ptr = MemAlloc(strlen(cont)+1+add);
                strcpy(mem_ptr,cont);
                //printf("MemPtr: |%s| at %ld\n",mem_ptr,mem_ptr);
                return(mem_ptr);
        }
        return(NULL);
}///

///Get_TT
BOOL Get_TT(char *file_name, UWORD *font_size, char **font_name, char *data_file, char *data_dir, char **cscreen)
{
    UBYTE    **tt_base,*fn,file_dir[256] = "";
    struct  DiskObject *diskobj;
    BOOL    tandy = FALSE;
    BYTE    lw;

    if (WBSTART) {
        NameFromLock(WBMessage->sm_ArgList->wa_Lock,file_dir,255);
        Make_FFP(file_name,file_dir);
    }
    else strcpy(FFP,file_name);

    if ((diskobj = (struct DiskObject *) GetDiskObject(FFP))) {
        tt_base = (UBYTE **)diskobj->do_ToolTypes;
        fn = (char *) FindToolType(tt_base,"FONT_NAME");
        if (fn) {
            *font_name = dyn_strings(fn,5);
            strcat(*font_name,".font");
            *font_size = (UWORD) abs(atoi((char *) FindToolType(tt_base,"FONT_SIZE")));
        }
        *cscreen = dyn_strings((char *) FindToolType(tt_base,"PUBLICSCREEN"),0);
        if (FindToolType(tt_base,"ADV_DATAFILE")) strncpy(data_file,(char *) FindToolType(tt_base,"ADV_DATAFILE"),31);
        if (FindToolType(tt_base,"ADV_DIR")) {
            Make_FFP((char *) FindToolType(tt_base,"ADV_DIR"),file_dir);
            strncpy(data_dir,FFP,255);
        }
        if (FindToolType(tt_base,"SAVE_GAME")) strncpy(save_game,(char *) FindToolType(tt_base,"SAVE_GAME"),31);
        if (FindToolType(tt_base,"SAVE_DIR")) {
            Make_FFP((char *) FindToolType(tt_base,"SAVE_DIR"),file_dir);
            strncpy(save_dir,FFP,255);
        }
        lw = (BYTE) abs(atoi((char *) FindToolType(tt_base,"LINEWIDTH")));
        if ((lw > 0) && (lw <= 99)) Width = lw;
        if (Strnicmp(FindToolType(tt_base,"TANDYFLAG"),"ON",2) == 0) tandy = TRUE;
        if (Strnicmp(FindToolType(tt_base,"FASTCOLOURS"),"ON",2) == 0) FASTCOLOURS = TRUE;
        if (Strnicmp(FindToolType(tt_base,"LINEWRAP"),"OFF",3) == 0) LINEWRAP = FALSE;
        Disp_ID = strtoul((char *) FindToolType(tt_base,"DISPLAY"),NULL,0);
        //printf("|%s|, |%s|, |%s|, |%s|, |%s,%d|, |%s|\n",save_game,save_dir,data_file,data_dir,*font_name,*font_size,*cscreen);
        if (FindToolType(tt_base,"SPEECH") && TranslatorBase) SPEECH = TRUE;
        FreeDiskObject(diskobj);
    }
    else {
        *font_name = dyn_strings("",0);
        *cscreen   = dyn_strings("",0);
    }
    return(tandy);
}///

/// Get_Font
void Get_Font(UWORD font_ysize, char *font_name)
{
    struct TextAttr textattr;

    textattr.ta_Name =  font_name;
    textattr.ta_YSize = font_ysize;
    textattr.ta_Style = FS_NORMAL;
    textattr.ta_Flags = FPF_DISKFONT|FPF_DESIGNED;
    if ((textfont = (struct TextFont *) OpenDiskFont(&textattr))) {
        if (textfont->tf_Flags & FPF_PROPORTIONAL) {
            EasyRequest(NULL,&NoProp,NULL,textfont->tf_Message.mn_Node.ln_Name);
            close_all();
            Exit(50);
        }
    }
}///

/// Set_NewFont
void Set_NewFont(void)
{
        struct Window *win, *env_w_hdl = NULL;

        win = WBscreen->FirstWindow;
        do {
                if (strncmp(win->Title,"Environment",11) == 0) env_w_hdl = win;
                if (strncmp(win->Title,"SCOTT-Free AMIGA",16) == 0) act_w_hdl = win;
                if ((env_w_hdl) && (act_w_hdl)) break;
        } while ((win = win->NextWindow));

        if (textfont) {
            SetFont(act_w_hdl->RPort,textfont);
            SetFont(env_w_hdl->RPort,textfont);
        }
}///



///Init_GFX
void Init_GFX(void)
{
    int i;
    LONG maxPen=0;

    fseek(gfx_in_file,go[1],SEEK_SET);
    NumColours = fgetc(gfx_in_file); // how many colours
    //printf("Screen %d, Cols %d\n",1<<WBscreen->RastPort.BitMap->Depth,NumColours);
    if ((1<<WBscreen->RastPort.BitMap->Depth) < NumColours) {
        GFX_Off();
        //NOGFXPOS = TRUE;
        EasyRequest(act_w_hdl,&NoGFX,NULL,"Lo schermo ha pochi colori.\nGFX verrà esclusa.");
        return;
    }

    border_width = (UBYTE) WBscreen->WBorLeft;
    bar_height = (UBYTE) WBscreen->WBorTop + WBscreen->Font->ta_YSize + 1;
    win_width = (int) (border_width + (BYTE) WBscreen->WBorRight + gfx_width);
    win_height = (int) (bar_height + (UBYTE) WBscreen->WBorBottom + gfx_height);
    win_pos_hor = w_top - win_height;
    if (win_pos_hor < (WBscreen->BarHeight + 1)) win_pos_hor = (WORD) WBscreen->BarHeight + 1;
    win_pos_ver = (WORD) ((WBscreen->Width - win_width) / 2);
    if (FASTCOLOURS) {
        if (!LDP) planesN = CountPlanes(NumColours);
        //printf("Planes, Cols, Scrn: %d,%d,%d\n",planesN,NumColours,WBscreen->RastPort.BitMap->Depth);
        for (i=0;i<NumColours;i++) Pens[i] = GetRGB4(WBscreen->ViewPort.ColorMap,i);
    } // El Brutalo colours 0 through 15
    else {
        for (i=0;i<NumColours;i++) {
            if ((Pens[i] = ObtainPen(WBscreen->ViewPort.ColorMap,-1,0,0,0,PEN_EXCLUSIVE)) == -1) break;
            if (Pens[i] > maxPen) maxPen = Pens[i];
        }
        if (i != NumColours) {
            NumColours = i;
            GFX_Off();
            //NOGFXPOS = TRUE;
            EasyRequest(act_w_hdl,&NoPens,NULL,NULL);
            return;
        }
        if (!LDP) planesN = CountPlanes(maxPen);
        //printf("Planes, Cols, Scrn: %d,%d,%d\n",planesN,NumColours,WBscreen->RastPort.BitMap->Depth);
    }

    if (LDP) {
        for (i=0; i<NumColours; i++) { //maybe check for NumColours == 8 should be done
            CR[i].red = fgetc(gfx_in_file)>>4;
            CR[i].green = fgetc(gfx_in_file)>>4;
            CR[i].blue = fgetc(gfx_in_file)>>4;
            //printf("LDP-Pen%2d: %3d %3d %3d\n",i+4,CR[i].red,CR[i].green,CR[i].blue);
            if (FASTCOLOURS) SetRGB4(&WBscreen->ViewPort,i+4,CR[i].red,CR[i].green,CR[i].blue); //except syscolors 0-3
            else SetRGB4(&WBscreen->ViewPort,Pens[i],CR[i].red,CR[i].green,CR[i].blue);
        }
        Rmem = (ULONG)AllocRaster(gfx_width+1,gfx_height+1);
    }
    else {
        //if (GFXDOUBLE) fac = 2;
        InitBitMap(&bitmapN,planesN,gfx_width,gfx_height);
        for (i=0; i<planesN; i++) {
            if ((bitmapN.Planes[i] = (PLANEPTR) AllocRaster(gfx_width,gfx_height)) == NULL) {
                planesN = i;
                GFX_Off();
                //NOGFXPOS = TRUE;
                EasyRequest(act_w_hdl,&NoGFX,NULL,"Non posso allocare la bitmap.\nGFX sarà esclusa.");
                return;
            }
        }
        picture = (UBYTE *) MemAlloc(gfx_width * gfx_height);
        rle_dat = (UBYTE *) MemAlloc(gfx_width * gfx_height);
        overlay = (UBYTE *) MemAlloc(gfx_width * gfx_height);
    }
    //INIT = TRUE;
}
///


///Speak
void Speak(char *original)
{
    LONG tlres;

    if (SPEECH) {
        if ((tlres = Translate((STRPTR) original,strlen(original),(STRPTR)nartrans,narBuf)) == 0) {
            //printf("Speaking: %d: |%s|\n%d: |%s|\n",tlres,original,strlen(nartrans),nartrans);
            request->message.io_Length = 1024;
            DoIO((struct IORequest*)request);
            //Delay(50);
        }
    }
}
///


/// Get_FileList
/*
void Get_FileList(char *dir, char **dfile_names, BYTE *cnt, BYTE mode)
{
    BPTR    dir_lock;
    struct  FileInfoBlock *dfib;
    APTR    pat;
    char    dname[256];
    static  BYTE cc = 0;

    if ((dir_lock = Lock(dir,SHARED_LOCK))) {
        if ((dfib = (struct FileInfoBlock *) AllocDosObject(DOS_FIB,NULL))) {
            if (Examine(dir_lock,dfib)) {
                pat = MemAlloc(12);
                ParsePatternNoCase("#?.dat",pat,12);
                while(ExNext(dir_lock,dfib)) {
                    if (dfib->fib_DirEntryType == ST_USERDIR) {
                        strcpy(dname,dir);
                        AddPart(dname,dfib->fib_FileName,256);
                        switch (mode) {
                          case 0:
                            Get_FileList(dname,NULL,cnt,0);
                            break;
                          case 1:
                            Get_FileList(dname,dfile_names,NULL,1);
                            break;
                          default:
                            break;
                        }
                    }
                    if (dfib->fib_DirEntryType == ST_FILE && MatchPatternNoCase(pat,dfib->fib_FileName)) {
                        switch (mode) {
                          case 0:
                            (*cnt)++;
                            break;
                          case 1:
                            Make_FFP(dfib->fib_FileName,dir);
                            dfile_names[cc++] = dyn_strings(FFP,0);
                            break;
                          default:
                            break;
                        }
                    }
                }
                free(pat);
            }
            FreeDosObject(DOS_FIB,dfib);
        }
        UnLock(dir_lock);
    }
}*/
///

///Open_ASL
BOOL Open_ASL(char *file_name, char *dir_name, UBYTE mode)
{
   struct TagItem *ASLTags;
   struct FileRequester *FileRequester;
   LONG   areq;

   FileRequester = (struct FileRequester *) AllocAslRequest(ASL_FileRequest,NULL);
   if (FileRequester == NULL) return(FALSE);
   ASLTags = (struct TagItem *) AllocateTagItems(8);
   if (ASLTags == NULL) {
           FreeFileRequest(FileRequester);
           return(FALSE);
   }
   ASLTags[0].ti_Tag = ASLFR_InitialPattern;
   ASLTags[0].ti_Data = (ULONG) "#?.save";
   if (mode == 2) ASLTags[0].ti_Data = (ULONG) "#?.dat";
   ASLTags[1].ti_Tag = ASLFR_Flags1;
   ASLTags[1].ti_Data = FRF_DOPATTERNS;
   if (mode == 1) ASLTags[1].ti_Data = FRF_DOPATTERNS|FRF_DOSAVEMODE;
   ASLTags[2].ti_Tag = ASLFR_TitleText; // 0: Restore Game, 1: Save Game, 2: Choose Adventure
   ASLTags[2].ti_Data = (ULONG) "Ricarica gioco memorizzato";
   if (mode == 1) ASLTags[2].ti_Data = (ULONG) "Memorizza gioco come ...";
   if (mode == 2) ASLTags[2].ti_Data = (ULONG) "Scegli il data file Avventura";
   ASLTags[3].ti_Tag = ASLFR_InitialFile;
   ASLTags[3].ti_Data = (ULONG) file_name;
   ASLTags[4].ti_Tag = ASLFR_InitialDrawer;
   ASLTags[4].ti_Data = (ULONG) dir_name;
   ASLTags[5].ti_Tag = ASLFR_PositiveText; // 0: Restore Game, 1: Save Game, 2: Choose Adventure
   ASLTags[5].ti_Data = (ULONG) "Carica";
   if (mode == 1) ASLTags[5].ti_Data = (ULONG) "Memorizza";
   if (mode == 2) ASLTags[5].ti_Data = (ULONG) "Gioca";
   ASLTags[6].ti_Tag = ASLFR_Window;
   ASLTags[6].ti_Data = (ULONG) act_w_hdl;
   ASLTags[7].ti_Tag = TAG_DONE;
   if ((areq = AslRequest(FileRequester,ASLTags))) {
                strcpy(file_name,FileRequester->fr_File);
                strcpy(dir_name,FileRequester->fr_Drawer);
                //printf("Dir, File: %s, %s\n",FileRequester->fr_File,FileRequester->fr_Drawer);
   }
   FreeTagItems(ASLTags);
   FreeFileRequest(FileRequester);
   if (areq) return(TRUE);
   return(FALSE); // Cancel pressed or ASL-problem
}///

/// Get_FileSize
/*
LONG Get_FileSize(BPTR file_lock)
{
        struct  FileInfoBlock *ffib;

        if ((ffib = (struct FileInfoBlock *) AllocDosObject(DOS_FIB,NULL))) {
                if (Examine(file_lock,ffib)) {
                        printf("Nome: %s\nDimensione: %d\n",ffib->fib_FileName,ffib->fib_Size);
                }
                FreeDosObject(DOS_FIB,ffib);
                return(ffib->fib_Size);
        }
        return(0);
} */
///

/// Show_FileList
/*
void Show_FileList(char *dir)
{
        char **dfile_names;
        BYTE i,cnt = 0;

        Get_FileList(dir,NULL,&cnt,0);
        dfile_names = (char **) MemAlloc(sizeof(char *) * cnt);
        Get_FileList(dir,dfile_names,NULL,1);
        for (i=0;i<=cnt-1;i++) {
                printf("%2d: %10.*s [%s]\n",i,(int)strlen(FilePart(dfile_names[i]))-4,FilePart(dfile_names[i]),dfile_names[i]);
        }
        if (cnt > 0) for (i=0;i<=cnt-1;i++) free(dfile_names[cnt]);
        free(dfile_names);
}*/
///

/// Open_File
FILE * Open_File(char * file_name)
{
    FILE    *f;

    if ((f = fopen(file_name,"r")) == NULL) {
        perror(file_name);
        EasyRequest(NULL,&FError,NULL,file_name);
        close_libs();
        exit(1);
    }
    strcat(restart_file,(char *)FilePart(file_name));
    strcat(restart_file,".res");
    return(f);
}///

/// Get_AdvFile
FILE * Get_AdvFile(char *data_file, char *data_dir)
{
    BPTR    lock;

    if (strcmp(data_file,"") == 0) strcpy(data_file,".dat");
    Make_FFP(data_file,data_dir);
    while ((lock = Lock(FFP,SHARED_LOCK)) == NULL) {
        if (Open_ASL(data_file,data_dir,2) == FALSE) return(NULL);
        //    close_all();
        //    exit(64);
        //}
        Make_FFP(data_file,data_dir);
    }
    UnLock(lock);
    return(Open_File(FFP));
}///

///Get_GFXSize
void Get_GFXSize(void)
{
    gfx_in_file = fopen(gfx_file,"rb");
    if (gfx_in_file == NULL) {
        //printf("No GFX\n");
        GFX = FALSE;
        return;
    }
    // Fetch GFX size from binary file
    gfx_width = fgetc(gfx_in_file)*256 + fgetc(gfx_in_file);
    gfx_height = fgetc(gfx_in_file)*256 + fgetc(gfx_in_file);
    //printf("GFX-Size: %d x %d Pixel.\n",gfx_width,gfx_height);

}///

///Get_PicLog
void Get_PicLog(void)
{
    int           i,j = 0,k,kk,rnum,count,nac89;
    unsigned char in_dat[1024];

    nroom = fgetc(gfx_in_file); // Number of rooms (maybe +1 if showPIC starts with 0 and not 1 !!!)
    nac89 = fgetc(gfx_in_file); // Number of Action89 pics
    fgetc(gfx_in_file); // Number of extended room pics
    
    // Read pic offset in bytes/room
    count = fgetc(gfx_in_file);
    //printf("\n%d Offsets\n",count);
    //if (count != npics) printf("Serio problema in gfx file\n. Aspettati un GURU :-)\n");
    //printf("Speicher1: %ld\n",*go);
    go = malloc(sizeof(unsigned long)  * count);
    //printf("Speicher2: %ld\n",*go);
    fread(&in_dat[0],1,count*3,gfx_in_file);
    for (i=0; i<count; i++) {
        go[i] = (unsigned long) in_dat[i*3]*256*256 + (unsigned long) in_dat[i*3+1]*256 + in_dat[i*3+2];
        //printf("GFX-OFF%d: %7ld\n",i,go[i]);
    }
    if (go[0] == 0) LDP = TRUE; //use darkness pic offset as LDP Flag
    else LDP = FALSE;
    //printf("Offset0/LDP: %d/%d\n",go[0],LDP);
    rp = malloc(sizeof(room_pics) * (nroom+nac89+1)); //pic0 is black (darkness)
    for (i=0; i<=nroom+nac89; i++) rp[i].ppr = 0;

    count = fgetc(gfx_in_file)*256 + fgetc(gfx_in_file); // how many BYTES!!! for room logic
    //printf("%d Logic Bytes\n",count);
    fread(&in_dat[0],1,count,gfx_in_file);
    while (j<count) {
        rnum = in_dat[j++];
        rp[rnum].ppr = in_dat[j++];
        if (rp[rnum].ppr > MAX_PPR) { // Byte 2: How many pics/room (except default pic)
            GFX_Off();
            EasyRequest(act_w_hdl,&NoGFX,NULL,"GFX datafile corrotto\o errato datafile (PPR).\nGFX sarà esclusa.");
            return;
        }
        //printf("\nRoom: %2d (%2d Pics)\n ",rnum,rp[rnum].ppr);
        for (i=0; i<rp[rnum].ppr; i++) {
            rp[rnum].what[i] = in_dat[j++];
            kk = rp[rnum].what[i]-80;
            while (kk < 0) kk += 10;
            if (kk > MAX_LOG) {
                GFX_Off();
                EasyRequest(act_w_hdl,&NoGFX,NULL,"GFX datafile corrotto\o errato datafile (LOG).\nGFX sarà esclusa.");
                return;
            }
            for (k=0; k<kk; k++) {
                rp[rnum].loc[i][k] = in_dat[j++];
                rp[rnum].obj[i][k] = in_dat[j++];
                //printf("Ob%d|%d: %2d,Loc%d: %d - ",i,k,rp[rnum].obj[i][k],i,rp[rnum].loc[i][k]);
            }
            rp[rnum].pnr[i] = in_dat[j++]; // picture number to display if condition is TRUE
        }
    }
    //close_all();
    //exit(0);
}
///

/// Init_Win
void Init_Win(struct FileHandle *win, BYTE fg, BYTE bg)
{
        CON_handle = win;
        clrsys();
        background(bg);
        textcolor(fg,bg);
        cursor(FALSE);
}///

/// Open_Wins
void Open_Wins(UWORD fy_size, char **font_name, char *cscreen)
{
        WORD    w_height_gfx,w_height_env,w_height_act,w_width,w_left;
        UWORD   fx_size;
        struct  Screen *DefPubScr;
        //char    DefPubScrName[256];

        if (fy_size) Get_Font(fy_size,*font_name);
        //free(*font_name);Betori vengono deallocate in chiusura
        //free(font_name);Betori
        if (textfont) fx_size = (UWORD) textfont->tf_XSize;
        else {
            DefPubScr = (struct Screen *) LockPubScreen("Workbench");
            fx_size = DefPubScr->FirstWindow->IFont->tf_XSize;
            fy_size = DefPubScr->FirstWindow->IFont->tf_YSize;
            //printf("X: %d, Y: %d (%s)\n",fx_size,fy_size,DefPubScr->FirstWindow->IFont->tf_Message.mn_Node.ln_Name);
            if (DefPubScr) UnlockPubScreen("Workbench",NULL);
        }
        w_width = (WORD) (Width * fx_size + /*(BYTE)*/ WBscreen->WBorLeft + /*(BYTE)*/ WBscreen->WBorRight);
        w_height_env = (WORD) (TopHeight * fy_size + /*(BYTE)*/ WBscreen->WBorTop + WBscreen->Font->ta_YSize + WBscreen->WBorBottom + 1);
        w_height_act = (WORD) (BottomHeight * fy_size + /*(BYTE)*/ WBscreen->WBorTop + WBscreen->Font->ta_YSize + WBscreen->WBorBottom + 2);
        w_height_gfx = (WORD) (gfx_height + /*(BYTE)*/ WBscreen->WBorTop + WBscreen->Font->ta_YSize + WBscreen->WBorBottom + 1);
        w_left = (WORD) (WBscreen->Width - w_width) / 2;
        w_top = (WORD) (WBscreen->Height - w_height_env - w_height_act - w_height_gfx) / 2 + w_height_gfx;
        if ((w_top + w_height_env + w_height_act) > WBscreen->Height) w_top = WBscreen->Height - w_height_env - w_height_act;
        if ((w_width > WBscreen->Width) || ((w_height_env+w_height_act) > WBscreen->Height)) {
            EasyRequest(NULL,&BigWins,NULL,NULL);
            close_all();
            exit(20);
        }
        env_hdl = Open_CON("RAW",w_left,w_top,w_width,w_height_env,"Ambiente","NOSIZE",cscreen);
        act_hdl = Open_CON("CON",w_left,w_top+w_height_env,w_width,w_height_act,"SCOTT-Free AMIGA","NOSIZE",cscreen);
        Set_NewFont();
        Init_Win(env_hdl,WHITE,BLUE);
        Init_Win(act_hdl,BLACK,GREY);
        scott_guide.nag_Screen = act_w_hdl->WScreen;
        OldUserPort = act_w_hdl->UserPort;
        act_w_hdl->UserPort = 0;
        ModifyIDCMP(act_w_hdl,MENUPICK|RAWKEY|VANILLAKEY|CLOSEWINDOW|NEWSIZE);
        menu = (struct Menu *) CreateMenus(newmenu,TAG_DONE);
        LayoutMenus(menu,WBvisinfo,TAG_DONE);
        SetMenuStrip(act_w_hdl,menu);
}///

/// Size_Wins
void Size_Wins(BOOL tandy)
{
        if (tandy) {
                Width = 64;
                TopHeight = 11;
                BottomHeight = 13;
                Options|=TRS80_STYLE;
        }
        else {
                if (Width == 0) Width = 80;
                TopHeight = 10;
                BottomHeight = 15;
        }
}///

/// copyright
void copyright(void)
{
    OutReset();
    OutBuf("AMIGA SCOTT-Free v1.92 italiana, di Betori Alessandro\n");
    Speak("AMIGA SCOTT-Free versione 1.92 italiana, di Betori Alessandro");
    OutBuf("Basata su SCOTT-Free Amiga v1.91 inglese,\n\n © Andreas Aumayr, anden@gmx.at\n\n");
    Speak("Basata su SCOTT-Free Amiga versione inglese 1.91, copyright Andreas Aumayr, anden at g m x point a t");
    OutBuf("Basata su SCOTT-Free UNIX/DOS v1.14b, © Alan Cox\n\n");
    Speak("Basata su SCOTT-Free UNIX/DOS versione 1.14b, copyright Alan Cox");
}///

/// FirstOfAll
void FirstOfAll(FILE *f)
{
    copyright();
    OutBuf("Caricamento avventura data file ...  ");
    Speak("Caricamento avventura data file");
    LoadDatabase(f,(Options&DEBUGGING)?1:0);
    fclose(f);
    OutBuf("Finito.\n\n");
    Speak("Finito.");
    if (SaveRestart()) {
        OffMenu(act_w_hdl,63649);
        RESTART = FALSE;
    }
} ///

/// Restart
void Restart(void)
{
    WriteCON(CLRSCR);
    BitFlags = 0;
    LoadRestart();
    WriteCON("Ricomincio ...\n\n");
    Speak("Ricomincio.");
    Delay(20);
    copyright();
    PerformActions(0,0);
    Look();
    //strcpy(command,"");
} ///

/// Init
void Init(char *prog_name, char *adv_file, char *save_file)
{
    UWORD   fy_size = 0;
    FILE    *f;  
    font_name = (char **) MemAlloc(sizeof(char *));
    cscreen = (char **) MemAlloc(sizeof(char *));


    if (open_libs() == FALSE) {
        close_libs();
        exit(255);
    }

    Size_Wins(Get_TT(prog_name,&fy_size,font_name,data_file,data_dir,cscreen));
    if (Options & TRS80_STYLE) Size_Wins(TRUE);

    old_pubmode = SetPubScreenModes(POPPUBSCREEN);

    if (strcmp(adv_file,"") != NULL) {
        strcpy(data_file,adv_file);
        strcat(data_file,".dat");
        f = Open_File(data_file);
        strcat(strncpy(gfx_file,data_file,strlen(data_file)-4),".gfx");
    }
    else {
        strcat(data_file,".dat");
        if ((f = Get_AdvFile(data_file,data_dir)) == NULL) {
            close_all();
            exit(64);
        }
        strcat(strncpy(gfx_file,data_file,strlen(data_file)-4),".gfx");
        Make_FFP(gfx_file,data_dir);
        strcpy(gfx_file,FFP);
    }
    //printf("\n%s (%s - %s)\n",gfx_file,data_file,data_dir);

    if (Disp_ID) {
        WORD D3Pens[] = {-1};
        ScottScreen = (struct Screen *) OpenScreenTags(0,SA_Pens,D3Pens,SA_Depth,4,SA_DisplayID,Disp_ID,
        SA_Type,PUBLICSCREEN,SA_Overscan,OSCAN_TEXT,SA_Title,"SCOTT-Free",SA_SysFont,1,
        SA_PubName,"SCOTT-Free", SA_PubSig,0,SA_PubTask,NULL,TAG_DONE);
        //SA_Interleaved,1, --> V39+
        if (ScottScreen) {
            PubScreenStatus(ScottScreen,0);
            //if (*cscreen) FreeMem(*cscreen,sizeof(cscreen));
            *cscreen = dyn_strings("SCOTT-Free",0);
        }
        else EasyRequest(NULL,&NoScreen,NULL,NULL);
    }

    if ((WBscreen = (struct Screen *) LockPubScreen(*cscreen)) == NULL) WBscreen = (struct Screen *) LockPubScreen("Workbench");
    if (WBscreen) {
        if ((WBvisinfo  = (APTR) GetVisualInfo(WBscreen,NULL))) {
            
            //Show_FileList(data_dir);
            
            Get_GFXSize();

            //if ((WBscreen->Width / WBscreen->Height) > 1) GFXDOUBLE = TRUE;

            Open_Wins(fy_size,font_name,*cscreen);

            //if (*cscreen) FreeMem(*cscreen,sizeof(*cscreen));
            //FreeMem(cscreen,sizeof(cscreen));
            
            if (GFX) Get_PicLog();
            else OffMenu(act_w_hdl,63491);
            if (GFX) Init_GFX();

            if (TranslatorBase) {
                narBuf = sizeof(nartrans);
                request->message.io_Message.mn_ReplyPort = narratorPort;
                request->message.io_Command = CMD_WRITE;
                request->message.io_Data = (APTR) nartrans;
                request->rate = 160;
                request->pitch = DEFPITCH;
                request->sex = FEMALE;
                request->ch_masks = channels;
                request->nm_masks = sizeof(channels);
                request->volume = 64;
            }
            else OffMenu(act_w_hdl,63523);
            if (SPEECH) ((struct MenuItem *) ItemAddress(menu,63523))->Flags |= CHECKED;

            FirstOfAll(f);

            if (strcmp(save_file,"") != NULL) LoadGame(save_file);
            else if (strcmp(save_game,"") != NULL) {
                Make_FFP(save_game,save_dir);
                LoadGame(FFP);
            }
            else {
                strncpy(save_game,data_file,strlen(data_file)-4);
                strcat(save_game,".save");
            }

            if (AmigaGuideBase) scott_guide.nag_Name = "Scott.guide";

            return;
        }
        printf("\nProblemi nel prendere informazioni visuali per lo schermo '%s'!\n",*cscreen);
        close_all();
    }
    printf("\nProblemi nel lock del custom screen '%s'\n",*cscreen);
    close_libs();
}///

/// NewGame
BOOL NewGame(void)
{
    FILE    *f;

    strcpy(data_file,".dat");
    if ((f = Get_AdvFile(data_file,data_dir)) == NULL) return(FALSE);
    strncpy(gfx_file,data_file,strlen(data_file)-4);
    gfx_file[strlen(data_file)-4] = 0;
    strcat(gfx_file,".gfx");
    Make_FFP(gfx_file,data_dir);
    strcpy(gfx_file,FFP);
    //printf("%s\n",gfx_file);

    if (restart_lock) UnLock(restart_lock);
    DeleteFile(restart_file);

    if (GFX) {
        if (pic_w_hdl) {
            CloseWindow(pic_w_hdl);
            pic_w_hdl = 0;
        }
        FreeGFXRes();
    }

    //printf("Get New GFX File\n");
    GFX = TRUE;
    OnMenu(act_w_hdl,63491);
    Get_GFXSize();
    if (!GFX) OffMenu(act_w_hdl,63491);
    else Get_PicLog();
    if (GFX) Init_GFX();

    BitFlags = 0;
    strcpy(GameInfoStr,"");

    WriteCON(CLRSCR);
    FirstOfAll(f);

    strncpy(save_game,data_file,strlen(data_file)-4);
    save_game[strlen(data_file)-4] = 0;
    strcat(save_game,".save");
    //printf("%s\n",save_game);

    srand(time(NULL));
    return(TRUE);
}///

/// Menu_Handle
BOOL Menu_Handle(int code, char *command)
{
    //strcpy(command,"");
    //printf("Packed, Menu, Item, SubItem, Address: %d, %d, %d, %d, %d\n",code,MENUNUM(code),ITEMNUM(code),SUBNUM(code),(struct MenuItem *) ItemAddress(menu,code));
    if (MENUNUM(code) != MENUNULL) {
        switch(MENUNUM(code)) {
            case 0:
                switch(ITEMNUM(code)) {
                    case 0:
                        EasyRequest(act_w_hdl,&About,NULL,NULL);
                        return(FALSE);
                        break;
                    case 2:
                        if (NewGame()) {
                            PerformActions(0,0);
                            Look();
                            strcpy(command,"");
                            return(TRUE);
                        }
                        else return(FALSE);
                        break;
                    case 4:
                        if (AmigaGuideBase) {
                            CloseAmigaGuide(OpenAmigaGuide(&scott_guide,NULL));
                        }
                        return(FALSE);
                        break;
                    case 6:
                        if (EasyRequest(act_w_hdl,&Quit,NULL,"")) {
                            close_all();
                            exit(0);
                        }
                        return(FALSE);
                        break;
                }
                break;
            case 1:
                switch(ITEMNUM(code)) {
                    case 0:
                        EasyRequest(act_w_hdl,&GameInfo,NULL,GameInfoStr);
                        return(FALSE);
                        break;
                    case 2:
                        strcpy(command,"!RICARICA");
                        WriteCON("!RICARICA\n");
                        return(TRUE);
                        break;
                    case 3:
                        strcpy(command,"MEMORIZZA GIOCO");
                        WriteCON("MEMORIZZA GIOCO\n");
                        return(TRUE);
                        break;
                    case 5:
                        Restart();
                        strcpy(command,"");
                        return(TRUE);
                        break;
                }
                break;
            case 2:
                switch(ITEMNUM(code)) {
                    case 0:
                        strcpy(command,"GUARDA");
                        WriteCON("GUARDA\n");
                        return(TRUE);
                        break;
                    case 1:
                        strcpy(command,"INVENTARIO");
                        WriteCON("INVENTARIO\n");
                        return(TRUE);
                        break;
                    case 2:
                        strcpy(command,"PRENDI TUTTO");
                        WriteCON("PRENDI TUTTO\n");
                        return(TRUE);
                        break;
                    case 4:
                        strcpy(command,"PUNTEGGIO");
                        WriteCON("PUNTEGGIO\n");
                        return(TRUE);
                        break;
                }
                break;
            case 3:
                switch(ITEMNUM(code)) {
                    case 0:
                        GFX = (GFX)?FALSE:TRUE;
                        if (GFX == FALSE) {
                            WriteCON("\n- La grafica è esclusa ora.\nCosa devo fare ? ");

                            if (pic_w_hdl) {
                                win_pos_ver = pic_w_hdl->LeftEdge;
                                win_pos_hor = pic_w_hdl->TopEdge;
                                CloseWindow(pic_w_hdl);
                                pic_w_hdl = 0;
                            }
                        }
                        else {
                            WriteCON("\n- La grafica è attiva ora.\nCosa devo fare ? ");
                            last_pic = -128;
                            Look();
                        }
                        return(FALSE);
                        break;
                    case 1:
                        SPEECH = (SPEECH)?FALSE:TRUE;
                        if (SPEECH == FALSE) WriteCON("\n- Il parlato è disattivato ora.\nCosa devo fare ? ");
                        else {
                            WriteCON("\n- Il parlato è attivo ora.\nCosa devo fare ? ");
                            Speak("Il parlato è attivo ora.\nCosa devo fare ? ");
                        }
                        return(FALSE);
                        break;
                }
        }
    }
    return(FALSE);
}///

/// LineInput2
void LineInput2(char *command)
{
    UWORD       code,qual;
    ULONG       class;
    struct      IntuiMessage *mess;
    char        buf[MAX_LL+1],ncom[MAX_LL+1];
    int         len=0,c_pos=0,h_pos;

    h_pos = hist_pos;
    do {
        WaitPort(act_w_hdl->UserPort);
        while ((mess = (struct IntuiMessage *) GT_GetIMsg(act_w_hdl->UserPort))) {
            class = mess->Class;
            code  = mess->Code;
            qual  = mess->Qualifier;
            GT_ReplyIMsg(mess);
            switch (class) {
                case IDCMP_VANILLAKEY:
                    if ((code >=32) && (code <=126)) {
                        if (len < MAX_LL) {
                            if (len != c_pos) {
                                strcpy(buf,&hist[hist_pos][c_pos]);
                                hist[hist_pos][c_pos] = code;
                                hist[hist_pos][c_pos+1] = 0;
                                strcat(&hist[hist_pos][0],buf);
                                sprintf(buf,"%s%c",INS_CHAR,code);
                                WriteCON(buf);
                            }
                            else {
                                hist[hist_pos][c_pos] = code;
                                sprintf(buf,"%c",code);
                                WriteCON(buf);
                            }
                            len++;
                            c_pos++;
                        }
                        break;
                    }
                    switch (code) {
                        case 8: //Backspace
                            if (c_pos > 0) {
                                WriteCON(CURSOR_LEFT);
                                WriteCON(DEL_CHAR);
                                if (len != c_pos) {
                                    strcpy(buf,&hist[hist_pos][c_pos]);
                                    hist[hist_pos][c_pos-1] = 0;
                                    strcat(&hist[hist_pos][0],buf);
                                }
                                c_pos--;
                                len--;
                            }
                            break;
                        case 27: //Escape
                            c_pos = len = 0;
                            strcpy(ncom,"");
                            gotoxy(18,BottomHeight);
                            WriteCON(CLREOL);
                            break;
                        case 127: //Delete
                            if (c_pos < len) {
                                WriteCON(DEL_CHAR);
                                if (len != c_pos+1) {
                                    strcpy(buf,&hist[hist_pos][c_pos+1]);
                                    hist[hist_pos][c_pos] = 0;
                                    strcat(&hist[hist_pos][0],buf);
                                }
                                len--;
                            }
                            break;
                    }

                case IDCMP_RAWKEY:
                    switch (code) {
                        case 10:
                        case 13:
                            hist[hist_pos][len] = 0;
                            strcpy(command,&hist[hist_pos][0]);
                            hist_pos++;
                            if (hist_pos >= MAX_HIST) hist_pos = 0;
                            if (hist_fill < MAX_HIST-1) hist_fill++;
                            WriteCON("\n");
                            return;
                            break;
                        case 76:
                            h_pos--;
                            if (h_pos < 0) h_pos = hist_fill;
                            if (h_pos != hist_pos) strcpy(ncom,&hist[h_pos][0]);
                            else strcpy(ncom,"");
                            c_pos = len = strlen(ncom);
                            gotoxy(18,BottomHeight);
                            sprintf(buf,"%s%s",CLREOL,ncom);
                            WriteCON(buf);
                            strcpy(&hist[hist_pos][0],ncom);
                            break;
                        case 77:
                            h_pos++;
                            if (h_pos > hist_fill) h_pos = 0;
                            if (h_pos != hist_pos) strcpy(ncom,&hist[h_pos][0]);
                            else strcpy(ncom,"");
                            c_pos = len = strlen(ncom);
                            gotoxy(18,BottomHeight);
                            sprintf(buf,"%s%s",CLREOL,ncom);
                            WriteCON(buf);
                            strcpy(&hist[hist_pos][0],ncom);
                            break;
                        case 78:
                            if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT)) {
                                c_pos = len;
                                gotoxy(18+len,BottomHeight);
                            }
                            else if (c_pos < len) {
                                WriteCON(CURSOR_RIGHT);
                                c_pos++;
                            }
                            break;
                        case 79:
                            if ((qual & IEQUALIFIER_LSHIFT) || (qual & IEQUALIFIER_RSHIFT)) {
                                c_pos = 0;
                                gotoxy(18,BottomHeight);
                            }
                            else if (c_pos > 0) {
                                WriteCON(CURSOR_LEFT);
                                c_pos--;
                            }
                            break;
                        case 95: //Help
                            if (AmigaGuideBase) {
                                CloseAmigaGuide(OpenAmigaGuide(&scott_guide,NULL));
                            }
                            break;
                        default:
                            break;
                    }
                    break;

                case IDCMP_MENUPICK:
                    if (Menu_Handle(code,command)) {
                        strcpy(&hist[hist_pos][0],command);
                        WriteCON(command);
                        hist_pos++;
                        if (hist_pos >= MAX_HIST) hist_pos = 0;
                        if (hist_fill < MAX_HIST-1) hist_fill++;
                        return;
                    }
                    break;

                case IDCMP_CLOSEWINDOW:
                    if (EasyRequest(act_w_hdl,&Quit,NULL,NULL)) {
                        close_all();
                        exit(0);
                        return;
                    }
                    break;
            }
        }
    } while (1);
}///

///KeyInput
USHORT KeyInput(void)
{
    USHORT      code;
    ULONG       class;
    struct      IntuiMessage *mess;

    do {
        WaitPort(act_w_hdl->UserPort);
        while ((mess = (struct IntuiMessage *) GT_GetIMsg(act_w_hdl->UserPort))) {
            class = mess->Class;
            code  = mess->Code;
            GT_ReplyIMsg(mess);
            switch (class) {
                case IDCMP_VANILLAKEY:
                    if (((code >=32) && (code <=126)) || (code == 13)) return(code);
            }
        }
    } while (1);
}///






/// rle_decode
void rle_decode(int size)
{
    int j,i;
    int repeat,count;

    fread(&rle_dat[0],1,size,gfx_in_file);
    j = i = 0;
    while (j<size) {
        while (rle_dat[j] < 128) {
            picture[i++] = rle_dat[j++];
            if (j>=size) return;
        }
        repeat = rle_dat[j++]-128;
        for (count=0; count < repeat; count++) picture[i++] = rle_dat[j];
        j++;
    }
}///

/// rle_decodeOvl
void rle_decodeOvl(int size)
{
    int j,i;
    int repeat,count;

    fread(&rle_dat[0],1,size,gfx_in_file);
    j = i = 0;
    while (j<size) {
        while (rle_dat[j] < 128) {
            overlay[i++] = rle_dat[j++];
            if (j>=size) return;
        }
        repeat = rle_dat[j++]-128;
        for (count=0; count < repeat; count++) overlay[i++] = rle_dat[j];
        j++;
    }
}///

/// Pixel2BitmapFast
void Pixel2BitmapFast(void)
{
    int x,y,plane,byte,lbyte,pen;
    unsigned int lbit;

    for (plane=0; plane<planesN; plane++) BltClear(bitmapN.Planes[plane],RASSIZE(gfx_width,gfx_height),0);
    for (y = 0; y < gfx_height; y++) {
        lbyte = y * bitmapN.BytesPerRow;
        lbit = lbyte << 3;
        for (x = 0; x < gfx_width; x++) {
            pen = picture[lbit + x];
            byte = lbyte + (x>>3);
            for (plane = 0; plane < planesN; plane++) {
                if (pen & (1<<plane)) *(bitmapN.Planes[plane] + byte) |= 128>>(x&7);
            }
        }
    }
}
///

/*
/// Pixel2BitmapFastDouble
void Pixel2BitmapFastDouble(void)
{
    int x,y,plane,byte,lbyte,pen;
    unsigned int lbit;

    for (plane=0; plane<planesN; plane++) BltClear(bitmapN.Planes[plane],RASSIZE(gfx_width,gfx_height),0);
    for (y = 0; y < gfx_height; y++) {
        lbyte = y * bitmapN.BytesPerRow;
        lbit = lbyte << 3;
        for (x = 0; x < gfx_width; x++) {
            pen = picture[lbit + x];
            byte = lbyte + (x>>3);
            for (plane = 0; plane < planesN; plane++) {
                if (pen & (1<<plane)) *(bitmapN.Planes[plane] + byte) |= 192>>((x<<2)&7);
            }
        }
    }
}
///
*/

/// Pixel2BitmapFastOvl
void Pixel2BitmapFastOvl(void)
{
    int x,y,plane,byte,lbyte,pen;
    unsigned int lbit;

    for (plane=0; plane<planesN; plane++) BltClear(bitmapN.Planes[plane],RASSIZE(gfx_width,gfx_height),0);
    for (y = 0; y < gfx_height; y++) {
        lbyte = y * bitmapN.BytesPerRow;
        lbit = lbyte << 3;
        for (x = 0; x < gfx_width; x++) {
            pen = overlay[lbit + x];
            if (pen > 15) pen = picture[lbit + x];
            byte = lbyte + (x>>3);
            for (plane = 0; plane < planesN; plane++) {
                if (pen & (1<<plane)) *(bitmapN.Planes[plane] + byte) |= 128>>(x&7);
            }
        }
    }
}
///

/// Pixel2BitmapPens
void Pixel2BitmapPens(void)
{
    int x,y,plane,byte,lbyte,pen;
    unsigned int lbit;

    for (plane=0; plane<planesN; plane++) BltClear(bitmapN.Planes[plane],RASSIZE(gfx_width,gfx_height),0);
    for (y = 0; y < gfx_height; y++) {
        lbyte = y * bitmapN.BytesPerRow;
        lbit = lbyte << 3;
        for (x = 0; x < gfx_width; x++) {
            pen = Pens[picture[lbit + x]];
            byte = lbyte + (x>>3);
            for (plane = 0; plane < planesN; plane++) {
                if (pen & (1<<plane)) *(bitmapN.Planes[plane] + byte) |= 128>>(x&7);
            }
        }
    }
}
///

/// Pixel2BitmapPensOvl
void Pixel2BitmapPensOvl(void)
{
    int x,y,plane,byte,lbyte,pen;
    unsigned int lbit;

    for (plane=0; plane<planesN; plane++) BltClear(bitmapN.Planes[plane],RASSIZE(gfx_width,gfx_height),0);
    for (y = 0; y < gfx_height; y++) {
        lbyte = y * bitmapN.BytesPerRow;
        lbit = lbyte << 3;
        for (x = 0; x < gfx_width; x++) {
            pen = Pens[overlay[lbit + x]];
            if (pen > 15) pen = Pens[picture[lbit + x]];
            byte = lbyte + (x>>3);
            for (plane = 0; plane < planesN; plane++) {
                if (pen & (1<<plane)) *(bitmapN.Planes[plane] + byte) |= 128>>(x&7);
            }
        }
    }
}
///

/// Check_Win
void Check_Win(void)
{
    if (pic_w_hdl == NULL) {
        pic_w_hdl = (struct Window *) OpenWindowTags(NULL,WA_Title,"Graphics",WA_Left,win_pos_ver,WA_Top,win_pos_hor,
        WA_Width,win_width,WA_Height,win_height,WA_CloseGadget,FALSE,WA_DepthGadget,TRUE,WA_DragBar,TRUE,
        WA_IDCMP,IDCMP_CLOSEWINDOW,WA_CustomScreen,WBscreen,TAG_DONE);
        if (LDP) {
            rastPort = pic_w_hdl->RPort;
            rastPort->TmpRas = (struct TmpRas *) InitTmpRas(&tmp,(PLANEPTR)Rmem,RASSIZE(gfx_width,gfx_height));
        }
    }
} ///

/// Show_Overlay
void Show_Overlay(void)
{
    rle_decodeOvl(fgetc(gfx_in_file)*256 + fgetc(gfx_in_file));
    if (FASTCOLOURS) Pixel2BitmapFastOvl();
    else Pixel2BitmapPensOvl();
    BltBitMapRastPort(&bitmapN,0,0,pic_w_hdl->RPort,WBscreen->WBorLeft,
    WBscreen->WBorTop + WBscreen->Font->ta_YSize + 1,gfx_width,gfx_height,0xC0);
}///

/// Show_Anim
/*
void Show_Anim(void)
{
    Check_Win();
}*/
///

/// Show_Pic
void Show_Pic(void)
{
    int     i;

    Check_Win();
    if (pic_w_hdl) {
        NumColours = fgetc(gfx_in_file); // how many colours
        if (NumColours > 16) {
            //printf("Cols: %d\n",NumColours);
            GFX_Off();
            EasyRequest(act_w_hdl,&NoGFX,NULL,"GFX datafile corrotto\o errato datafile (COL).\nGFX sarà esclusa.");
            if (pic_w_hdl) CloseWindow(pic_w_hdl);
            pic_w_hdl = 0;
            return;
        }
        for (i=0; i<NumColours; i++) {
            CR[i].red = fgetc(gfx_in_file)>>4;
            CR[i].green = fgetc(gfx_in_file)>>4;
            CR[i].blue = fgetc(gfx_in_file)>>4;
            //printf("Pen%2d: %3d %3d %3d\n",i+4,CR[i].red,CR[i].green,CR[i].blue);
            if (FASTCOLOURS) SetRGB4(&WBscreen->ViewPort,i,CR[i].red,CR[i].green,CR[i].blue);
            else SetRGB4(&WBscreen->ViewPort,Pens[i],CR[i].red,CR[i].green,CR[i].blue);
        }

        rle_decode(fgetc(gfx_in_file)*256 + fgetc(gfx_in_file));
        if (FASTCOLOURS) Pixel2BitmapFast();
        else Pixel2BitmapPens();
        BltBitMapRastPort(&bitmapN,0,0,pic_w_hdl->RPort,WBscreen->WBorLeft,
        WBscreen->WBorTop + WBscreen->Font->ta_YSize + 1,gfx_width,gfx_height,0xC0);
    }
}///

/// SetPen
void SetPen(UBYTE pen)
{
    if (FASTCOLOURS) SetAPen(rastPort,pen+4);
    else SetAPen(rastPort,Pens[pen]);
}///

/// DrawPicFrame
void DrawPicFrame(void)
{
    Move(rastPort,border_width-1,bar_height-1); //draw frame as border for fill
    Draw(rastPort,gfx_width+border_width,bar_height-1);
    Draw(rastPort,gfx_width+border_width,gfx_height+bar_height);
    Draw(rastPort,border_width-1,gfx_height+bar_height);
    Draw(rastPort,border_width-1,bar_height-1);
}///

/// DrawPic
void Draw_Pic(UBYTE pic_nr, UBYTE mode)
{
    UBYTE    command,col;
    UWORD    x,y;

    Check_Win();
    if (pic_w_hdl) {
        //OFF_DISPLAY;
        if (mode) {
            if ((fgetc(gfx_in_file)  != NEWPIC) || (fgetc(gfx_in_file) != pic_nr)) {
                //printf("NewPic/PicNum: %d/%d (%d/%d)\n",dat1,dat2,NEWPIC,pic_nr);
                GFX_Off();
                EasyRequest(act_w_hdl,&NoGFX,NULL,"GFX datafile corrotto\o errato datafile (NEWPIC/COL).\nGFX sarà esclusa.");
                if (pic_w_hdl) CloseWindow(pic_w_hdl);
                pic_w_hdl = 0;
                return;
            }
            col = fgetc(gfx_in_file);
            //printf("BackCol: %d\n",col);
            //if (col==7) col=1; //avoid white with UAE
            SetPen(col);
            RectFill(rastPort,border_width,bar_height,gfx_width-1+border_width,gfx_height-1+bar_height);
            col=(col==0)?7:0;
            SetPen(col);
            DrawPicFrame(); //in zeichenfarbe
            /*if (FASTCOLOURS) {
                SafeSetOutlinePen(rastPort,col+4);
            }
            else {
                SafeSetOutlinePen(rastPort,Pens[col]); //set bordercolor for FLOOD 0
            } */
            command = fgetc(gfx_in_file);
            while (command != NEWPIC) {
                switch (command) {
                    case MOVE:
                        y = fgetc(gfx_in_file) + bar_height;
                        x = fgetc(gfx_in_file) + border_width;
                        //printf("MOVE: %d, %d - ",x,y);
                        Move(rastPort,x,y);
                        //getchar();
                        break;
                    case FILL:
                        col = fgetc(gfx_in_file);
                        y = fgetc(gfx_in_file) + bar_height;
                        x = fgetc(gfx_in_file) + border_width; //- 1;
                        SetPen(col);
                        //printf("FILL [%d]: %d, %d - ",col,x,y);
                        Flood(rastPort,1,x,y);
                        break;
                    default:  //DRAW
                        x = fgetc(gfx_in_file) + border_width;
                        //printf("DRAW: %d, %d - ",x,command + bar_height);
                        Draw(rastPort,x,command + bar_height);
                        break;
                }
                command = fgetc(gfx_in_file);
            }
            RefreshWindowFrame(pic_w_hdl);
            //printf("\n");
        }
        else { //it's dark out there
            SetPen(0); //black
            RectFill(rastPort,border_width,bar_height,gfx_width-1+border_width,gfx_height-1+bar_height);
            //DrawPicFrame(); //just to be on the safe side
        }
        //ON_DISPLAY;
    }
}///

/// Open_Pic
void Open_Pic(UBYTE pic_nr, UBYTE how)
{
    //printf("Showing Pic %d (%d)...\n",pic_nr,last_pic);
    if (go[pic_nr] != 0) { // there is definitely a picture for this room
        last_pic = pic_nr;
        fseek(gfx_in_file,go[pic_nr],SEEK_SET);
        switch (how) {
            case PIC:
                if (LDP) { //LineDrawPic for Mysterious Adventures
                    if (pic_nr == 1) fseek(gfx_in_file,NumColours*3+1,SEEK_CUR); //BEFORE pic 1 is color-table --> ignore it for now
                    Draw_Pic(pic_nr,1);
                }
                else Show_Pic();
                break;
            case COC:
                break;
            case OVL:
                Show_Overlay();
                break;
            case ANI:
                break;
            case GOT:
                break;
            default:
                break;
        }
    }
    else {
        //printf("Nessuna grafica per questa stanza!\n");
        if (pic_w_hdl) {
            win_pos_ver = pic_w_hdl->LeftEdge;
            win_pos_hor = pic_w_hdl->TopEdge;
            CloseWindow(pic_w_hdl);
            pic_w_hdl = 0;
            //if (LDP && Rmem) FreeRaster(Rmem,gfx_width,gfx_height);
        }
        last_pic = -128;
    }
}///

///Handle_Pic
BOOL Handle_Pic(int Room)
{
    int i,j,yes,ii;

    //printf("%d Grafica(s) per Stanza %d.\n",rp[Room].ppr+1,MyLoc);
    if (rp[Room].ppr) {
        for (j=0; j<rp[Room].ppr; j++) {
            ii = rp[Room].what[j]-80;
            while (ii < 0) ii += 10;
            yes = 0;
            for (i=0; i<ii; i++) {
                //printf("Switching to case %d!\n",rp[Room].loc[j][i]);
                switch (rp[Room].loc[j][i]) {
                    case 1: // in room
                        if (Items[rp[Room].obj[j][i]].Location == MyLoc) yes++;
                        break;
                    case 2: // in inventory
                        if (Items[rp[Room].obj[j][i]].Location == 255) yes++;
                        break;
                    case 4: // in room or inventory
                        if ((Items[rp[Room].obj[j][i]].Location == 255) || (Items[rp[Room].obj[j][i]].Location == MyLoc)) yes++;
                        break;
                    case 81: // NOT in room
                        if (Items[rp[Room].obj[j][i]].Location != MyLoc) yes++;
                        break;
                    case 82: // NOT in inventory
                        if (Items[rp[Room].obj[j][i]].Location != 255) yes++;
                        break;
                    case 84: // NOT in room and NOT in inventory
                        if ((Items[rp[Room].obj[j][i]].Location != 255) && (Items[rp[Room].obj[j][i]].Location != MyLoc)) yes++;
                        break;
                    default:
                        break;
                }
            }
            if (yes >= ii) {
                if (rp[Room].pnr[j] == 0) { // no picture
                    //printf("Logic says: No Pic!\n");
                    if (pic_w_hdl) {
                        win_pos_ver = pic_w_hdl->LeftEdge;
                        win_pos_hor = pic_w_hdl->TopEdge;
                        CloseWindow(pic_w_hdl);
                        pic_w_hdl = 0;
                    }
                    last_pic = -128;
                    return(FALSE);
                }
                if (rp[Room].pnr[j] == 255) return(FALSE); // 255 = do nothing
                if (last_pic >= 0) {
                    if ((go[last_pic] == go[rp[Room].pnr[j]])) return(FALSE);
                }
                //printf("Yes: %d, Last: %d - %d\n",yes,last_pic,rp[Room].pnr[j]);
                switch ((int)(rp[Room].what[j]/10)) {
                    case PIC: // Show Pic
                        Open_Pic(rp[Room].pnr[j],PIC);
                        return(TRUE);
                    case COC: // colour cycling
                        //printf("Colour Cycling: %d\n",rp[Room].pnr[j]);
                        //return(TRUE);
                        break;
                    case OVL: // overlay picture
                        //printf("Overlay: %d\n",rp[Room].pnr[j]);
                        yes = 1;
                        if (last_pic != Room) {
                            for (i=0; i<rp[Room].ppr; i++) {
                                if (last_pic == rp[Room].pnr[i]) {
                                    yes = 0;
                                    break;
                                }
                            }
                        }
                        else yes = 0;
                        //printf("OVL [old pic too]: %d\n",yes);
                        if (yes) Open_Pic(Room,PIC); // basis pic is not already displayed
                        Open_Pic(rp[Room].pnr[j],OVL);
                        return(TRUE);
                        break;
                    case ANI: // animation
                        //printf("Animation: %d\n",rp[Room].pnr[j]);
                        //return(TRUE);
                        break;
                    case GOT: // GO_TREE for "Robin of Sherwood"
                        //printf("GO_TREE: %d\n",rp[Room].pnr[j]);
                        //return(TRUE);
                        break;
                    default:
                        //return(FALSE);
                        break;
                }
            }
        }
    }
    if (last_pic >= 0) { // yes, last pic exits
        if (go[last_pic] == go[Room]) return(FALSE);
    }
    //printf("Std->Room: %d [%d is last]\n",Room,last_pic);
    Open_Pic(Room,PIC);
    return(TRUE);
}///


///SpeakNum
void SpeakNum(int number)
{
    sprintf(str_buf,"%d",number);
    Speak(str_buf);
}
///
