/******************************************/
/***        3DCore Main Include         ***/
/*** v1.26 13/03/98 (c) J.Gregory 96-98 ***/
/******************************************/

/*************************/
/*** Amiga OS Includes ***/
/*************************/

#include <exec/types.h>
#include <exec/memory.h>
#include <exec/interrupts.h>
#include <proto/exec.h>
#include <devices/input.h>
#include <devices/audio.h>
#include <dos/dos.h>
#include <proto/dos.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <graphics/rastport.h>
#include <proto/graphics.h>
#include <libraries/iffparse.h>
#include <proto/iffparse.h>
#include <libraries/diskfont.h>
#include <proto/diskfont.h>
#include <utility/tagitem.h>
#include <hardware/intbits.h>
#include <hardware/dmabits.h>
#include <hardware/custom.h>
#include <intuition/intuition.h>
#include <proto/intuition.h>

#include <myincludes/iff_ilbm.h>
#include <stdio.h>
#include <string.h>

/*******************************/
/*** 3DCore Support Includes ***/
/*******************************/

#include <3D_Core:includes/3DC_GlobProto.h>
#include <3D_Core:includes/3DC_ViewSupport.h>
#include <3D_Core:includes/3DC_ImageSupport.h>
#include <3D_Core:includes/3DC_ChnkScrSupport.h>
#include <3D_Core:includes/3DC_InputSupport.h>
#include <3D_Core:includes/3DC_Interrupts.h>
#include <3D_Core:includes/3DC_AudioSupport.h>
#include <3D_Core:includes/3DC_ObjectSupport.h>
#include <3D_Core:includes/3DC_Handlers.h>
#include <3D_Core:includes/3DC_MiscSupport.h>


/******************************/
/*** Dissable break handler ***/
/******************************/

int CXBRK(void) { return(0); }
int chkabort(void) { return(0); }
  
/******************/
/***            ***/
/*** Initialise ***/
/***            ***/
/******************/

/* Returns -1 if failed otherwise 0 */

WORD C3D_Init(char *resscript) {
  WORD ret;

  C3D_InitLog();                                /* Initialise Debug Log  */
    
  ret=C3D_InitLibs();                           /* Open required libs    */
  if(!ret) ret=C3D_LoadGlobPrefs();             /* Load/Default Prefs    */
  if(!ret) ret=C3D_InitInts();                  /* Init Interupt Stuff   */
  if(!ret) ret=C3D_InitDisplay();               /* Init Low Level Display*/
  if(!ret) ret=C3D_InitChunkyScr(WIDTH,HEIGHT); /* Init Chunky Screen    */
  if(!ret) ret=C3D_InitIHandler();              /* Init Input System     */
  if(!ret) ret=C3D_InitObjects();               /* Init Object System    */
  if(!ret) ret=C3D_InitAudio();                 /* Init Audio System     */
  if(!ret) ret=C3D_InitMisc();                  /* Init Misc Resources   */
  if(!ret) ret=C3D_LoadResource(resscript);     /* Run Resource Script   */

  if(!ret) {
    C3D_EnableIHandler();                       /* Enable Interupts      */
    C3D_LoadView();                             /* Load Custom ViewPort  */
    }  
  else {                                        /* Exit If Init Failed   */
    C3D_Free();
    return -1;
    }
    
  C3D_Task = FindTask(NULL);                    /* Get own task pointer  */
  if(!C3D_Task) return(-1);
     
  return(0);
  }

/*******************************/
/*** Open Required Libraries ***/
/*******************************/

/* Returns -1 if failed otherwise 0 */

WORD C3D_InitLibs(void) {
  IntuitionBase = (struct IntuitionBase *) OpenLibrary("intuition.library",0L);
  if(IntuitionBase == NULL) {
    printf("Could not open intuition.library\n");
    return(-1);
    };    
  
  GfxBase = (struct GfxBase *) OpenLibrary("graphics.library",36L);
  if(GfxBase == NULL) {
    printf("Could not open graphics.library\n");
    return(-1);
    };

  IFFParseBase = OpenLibrary("iffparse.library",0L);
  if(IFFParseBase == NULL) {
    printf("Could not open iffparse.library\n");
    return(-1);
    }

  return(0);
  }

/***************/
/***         ***/
/*** Cleanup ***/
/***         ***/
/***************/

void C3D_Free(void) {
  C3D_FreeView();
  C3D_DissableIHandler();
  C3D_FreeMisc();
  C3D_FreeAudio();
  C3D_FreeObjDefs();
  C3D_FreeObjects();
  C3D_FreeIHandler();
  C3D_FreeImages();
  C3D_FreeChunky();
  C3D_FreeDisplay();
  C3D_FreeInts();
  C3D_SaveGlobPrefs();
  C3D_FreeGlobPrefs();
  C3D_FreeLibs(); 
  }

/**********************************/
/*** Close any opened libraries ***/
/**********************************/

void C3D_FreeLibs(void) {
  if(IFFParseBase   != NULL) CloseLibrary(IFFParseBase);
  if(GfxBase        != NULL) CloseLibrary((struct Library *) GfxBase);
  if(IntuitionBase  != NULL) CloseLibrary((struct Library *) IntuitionBase);
  }

/***********************************/
/**** Main Frame Draw Procedure ****/
/***********************************/

void C3D_DrawMain(void) {
  struct RotateWork rwk;

  C3D_PreMove();

  rwk.Angle    = 1023-VP->Heading;
  rwk.ObjCount = MAXACTOBJ;
  rwk.VPFlags  = VP->Flags;
  rwk.TanTable = HP_TanTab;
  rwk.CosTable = HP_CosTab;

  C3D_MoveALL(LastNMovWOb);
  C3D_InterruptSample(); 
  C3D_CheckWObjRange(VP->Wx,VP->Wy,ActiveRange);
  if(FlrObjDensity>0) C3D_UpdateFlrObj(); 
  ASM_Rotate_World(&rwk, ActObj, DepthList, SinCosTab, VP);

  C3D_DrawBackdrop();
  C3D_PlotDepthList(rwk.ObjCount, VP);
  C3D_DrawHUD();

  if(CurColTran) ASM_ColTrans(ChunkyScr,CurColTran,(WIDTH*HEIGHT)/4);
  ASM_ConvScreen(ChunkyScr,C3D_ActPlane0);
  C3D_SwapView();
  C3D_FrameSync();
  C3D_StartSample();
  }

/***********************/
/*** Load Prefs File ***/
/***********************/

/* Returns 0 on success otherwise -1 */

WORD  C3D_LoadGlobPrefs(void) {
  WORD ret=0;
  LONG len;
  BPTR handle=NULL;
  
  C3DPrefs=AllocVec(sizeof(struct C3DPrefs),MEMF_CLEAR | MEMF_PUBLIC);
  if(C3DPrefs==NULL) {
    printf("Could not allocate RAM for prefs\n");
    return -1;
    }

  /*** Set Defaults Here ***/
  
  C3DPrefs->Magic    = GLOBPREFSMAGIC;
  C3DPrefs->DxOffset = 130;
  C3DPrefs->DyOffset = 35;

  C3DPrefs->KeyFwd  = 0x4C;    /* Up Arrow    */
  C3DPrefs->KeyBak  = 0x4D;    /* Down Arrow  */
  C3DPrefs->KeyLft  = 0x4F;    /* Left Arrow  */
  C3DPrefs->KeyRgt  = 0x4E;    /* Right Arrow */
  C3DPrefs->KeySide = 0x64;    /* Left ALT    */
  C3DPrefs->KeyAct1 = 0x63;    /* CTRL        */
  C3DPrefs->KeyAct2 = 0x60;    /* Left Shift  */

  handle=Open(GLOBPREFSNAME,MODE_OLDFILE);
  if(handle) {
    len=Read(handle,C3DPrefs,sizeof(struct C3DPrefs));
    if(len==sizeof(struct C3DPrefs)) {
      if(C3DPrefs->Magic!=GLOBPREFSMAGIC) ret=-1;
      }
    else {
      ret=-1;
      }
    Close(handle);
    }
    
  if(ret) {
    printf("%s corrupt (Delete to default) !!!\n",GLOBPREFSNAME);
    C3D_FreeGlobPrefs();
    }

  return ret;
  }

/***********************/
/*** Save Prefs File ***/
/***********************/

WORD C3D_SaveGlobPrefs(void) {
  WORD ret=0;
  LONG len;
  BPTR handle=NULL;

  if(!C3DPrefs) return 0;
  
  /*** Update any required prefs fields ***/
  
  C3DPrefs->Magic    = GLOBPREFSMAGIC;
  C3DPrefs->DxOffset = view0.DxOffset;
  C3DPrefs->DyOffset = view0.DyOffset;

  handle=Open(GLOBPREFSNAME,MODE_READWRITE);
  if(handle) {
    len=Write(handle,C3DPrefs,sizeof(struct C3DPrefs));
    if(len!=sizeof(struct C3DPrefs)) ret=-1;
    Close(handle);
    }
  else ret=-1;

  return ret;
  }

/***********************/
/*** Free Prefs Data ***/
/***********************/

void C3D_FreeGlobPrefs(void) {
  if(C3DPrefs) {
    FreeVec(C3DPrefs);
    C3DPrefs=NULL;
    }
  }

/****************************/
/*** Initialise Debuf Log ***/
/****************************/

void C3D_InitLog(void) {
  BPTR handle=NULL;
  
  DeleteFile(DEBUGLOGNAME);

  if(!DEBUGLOGBOOL) return;
  
  handle=Open(DEBUGLOGNAME,MODE_NEWFILE);
  if(handle!=NULL) {
    Write(handle,"New Log Created\n",16);
    Close(handle);
    }
  }

/*********************************/
/*** Write String To Debug Log ***/
/*********************************/

void C3D_WriteLog(char *str) {
  BPTR handle=NULL;
  WORD len=0;

  if(!DEBUGLOGBOOL) return;
  
  while(str[len]!=0) len++;
  
  handle=Open(DEBUGLOGNAME,MODE_OLDFILE);
  if(handle!=NULL) {
    Seek(handle,0,OFFSET_END);
    Write(handle,str,len);
    Close(handle);
    }
  }
