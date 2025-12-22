/*==================================================================*/
/* amigaos.c - Alain Thellier - Paris - France 	2015				*/
/* include MOS port & Full screen mode 								*/
/*==================================================================*/
#include "abbaye.h"
#ifdef __amigaos4__
#define OS4
#else
#define OS3
#endif
/*==================================================================*/
#ifdef OS4
#define __USE_INLINE__
#define __USE_BASETYPE__
#define __USE_OLD_TIMEVAL__
#pragma pack(2)
#endif

#include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>
#include <strings.h>

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/datatypes.h>
#include <proto/timer.h>
#include <proto/utility.h>
#include <proto/cybergraphics.h>
#include <proto/lowlevel.h>
#include <proto/asl.h>

#include <datatypes/datatypes.h>
#include <datatypes/pictureclass.h>
#include <datatypes/soundclass.h>
#include <utility/utility.h>
#include <intuition/classes.h>

#include <exec/io.h>
#include <exec/memory.h>
#include <exec/exec.h>
#include <devices/gameport.h>
#include <devices/inputevent.h>

#include <libraries/lowlevel.h>


#ifdef OS3
#include <cybergraphx/cybergraphics.h>
#endif

#ifdef OS4
#include <graphics/composite.h>
#include <proto/Picasso96API.h>
#include <libraries/Picasso96.h>
#endif

/*==================================================================*/
typedef struct _AB_Screen
{
	struct Screen  *screen;
	struct Window  *window;
	struct BitMap  *bm;
	struct RastPort bufferrastport;
	AB_Rect rect;
	float resizex,resizey;
	UBYTE *pixels;
	ULONG frame;
	ULONG msgframe;
	UBYTE msgname[256];
	UWORD skipframe;
	UWORD filter,volume;
	void *currentmus;
} AB_Screen;
/*==================================================================*/
typedef struct _AB_Texture
{
	AB_Rect rect;
	struct BitMap  *bm;
	UBYTE *pixels;
	UBYTE filename[256];
} AB_Texture;
/*==================================================================*/
typedef struct _AB_Music
{
UBYTE filename[256];
ULONG id,GroupID;								/* id */
APTR  dtobject;								/* Pointer to a datatype object*/
ULONG sampleLength,samplesPerSec,duration,volume,replay;
UBYTE *pixels;
struct dtTrigger dtt;			/* A trigger structure for the DTM_TRIGGER method */
void *next;
}AB_Music;
#define AB_Sound AB_Music
/*==================================================================*/
BOOL debug=FALSE;
/*==================================================================*/
#define ZZ if(debug) printf("ZZ stepping ..\n");
#define REM(message)  if(debug) {printf(#message"\n");}
#define    VAR(var)   if(debug) {printf(" " #var "=" ); printf("%ld\n",  ((ULONG)var)  );}
#define   VARP(var)   if(debug) {if(var!=0) {printf(" " #var "=" ); printf("%ld\n",  ((ULONG)var)  );} else {printf(" " #var "=NULL\n");}}
#define   VARF(var)   if(debug) {pfloat(" " #var "="   , &var,1);}
#define   VARS(var)   if(debug) {printf(" " #var "=<%s>\n",var); }
#define LL            if(debug) {printf("Line:%ld\n",__LINE__);}
#define et  &&
#define MYCLR(x) 	memset(&x,0,sizeof(x));
#define NLOOP(nbre) for(n=0;n<nbre;n++)
#define MLOOP(nbre) for(m=0;m<nbre;m++)
#define XLOOP(nbre) for(x=0;x<nbre;x++)
#define YLOOP(nbre) for(y=0;y<nbre;y++)
#define  MYNEW(obj) (obj*)malloc(sizeof(obj))
#define  RCHECK(obj) if(obj==NULL) return(NULL);
#define  CHECK(obj) if(obj==NULL) return;
/*==================================================================*/
struct IntuitionBase*	IntuitionBase	=NULL;
struct GfxBase*		GfxBase				=NULL;
struct Library*		CyberGfxBase		=NULL;
struct Library*		GadToolsBase		=NULL;
struct Library* 	P96Base 			=NULL;
struct Library*		DataTypesBase		=NULL;
#ifndef __MORPHOS__
struct UtilityBase*	UtilityBase			=NULL;

struct Device *		TimerBase			=NULL;
#else
#ifndef SDTA_Cycles
#define	SDTA_Cycles           (SDTA_Dummy + 6)
#endif
#endif
struct UtilityBase*	__UtilityBase		=NULL;
struct timerequest tr;
struct Library*		LowLevelBase			=NULL;
struct Library*		AslBase			=NULL;
/*==================================================================*/
#ifdef OS4
struct GraphicsIFace*			IGraphics		=NULL;
struct IntuitionIFace*			IIntuition		=NULL;
struct GadToolsIFace*			IGadTools		=NULL;
struct CyberGfxIFace*			ICyberGfx		=NULL;
struct UtilityIFace*			IUtility		=NULL;
struct P96IFace* 				IP96 			=NULL;
struct DataTypesIFace*			IDataTypes		=NULL;
struct TimerIFace*				ITimer			=NULL;
struct LowLevelIFace*			ILowLevel		=NULL;
struct AslIFace*				IAsl 				=NULL;
#endif
/*==================================================================*/
static void printbuttons(ULONG joy)
{
    if (joy & JPF_BUTTON_PLAY)      printf("[PLAY/MMB]");
    if (joy & JPF_BUTTON_REVERSE)   printf("[REVERSE]");
    if (joy & JPF_BUTTON_FORWARD)   printf("[FORWARD]");
    if (joy & JPF_BUTTON_GREEN)     printf("[SHUFFLE]");
    if (joy & JPF_BUTTON_RED)       printf("[SELECT/LMB/FIRE]");
    if (joy & JPF_BUTTON_BLUE)      printf("[STOP/RMB]");
}
/*==================================================================*/
static void printmousedirections(ULONG joy)
{
    printf("[%d,%d]", (joy & JP_MHORZ_MASK), (joy & JP_MVERT_MASK) >> 8);
}
/*==================================================================*/
static void printjoydirections(ULONG joy)
{
    if (joy & JPF_JOY_UP)       printf("[UP]");
    if (joy & JPF_JOY_DOWN)     printf("[DOWN]");
    if (joy & JPF_JOY_LEFT)     printf("[LEFT]");
    if (joy & JPF_JOY_RIGHT)    printf("[RIGHT]");
}
/*==================================================================*/
static void printjoyport(ULONG unit,ULONG joy)
{
    int i;
 
    printf("UNIT%d: ",unit);
    for(i = 31; i >= 0; i--)
    {
    	printf("%d", (joy & (1 << i)) ? 1 : 0);
    }
 
    printf(" - ");
 
    if ((joy & JP_TYPE_MASK) == JP_TYPE_NOTAVAIL) printf("NOT AVAILABLE");
    if ((joy & JP_TYPE_MASK) == JP_TYPE_UNKNOWN)  printf("UNKNOWN");
 
    if ((joy & JP_TYPE_MASK) == JP_TYPE_JOYSTK)
    {
        printf("JOYSTICK - ");
        printjoydirections(joy);
        printbuttons(joy);
    }
 
    if ((joy & JP_TYPE_MASK) == JP_TYPE_GAMECTLR)
    {
        printf("GAME CONTROLLER - ");
        printjoydirections(joy);
        printbuttons(joy);
    }
 
    if ((joy & JP_TYPE_MASK) == JP_TYPE_MOUSE)
    {
        printf("MOUSE - ");
        printmousedirections(joy);
        printbuttons(joy);
    }

    printf("\n");
}
/*==================================================================*/
void OSJoystick(struct game *G)
{
ULONG joy,n;

	NLOOP(4)
	{
	joy = ReadJoyPort(n);
	if(joy)
    if(!((joy & JP_TYPE_MASK) == JP_TYPE_MOUSE) )
    if(!((joy & JP_TYPE_MASK) == JP_TYPE_NOTAVAIL)  )
		break;
	}
	

	G->joystick.right	=(joy & JPF_JOY_RIGHT);
	G->joystick.left	=(joy & JPF_JOY_LEFT);
	G->joystick.down	=(joy & JPF_JOY_DOWN);
	G->joystick.up		=(joy & JPF_JOY_UP);	
	G->joystick.b0		=(joy & JPF_BUTTON_RED);
	G->joystick.b1		=(joy & JPF_BUTTON_PLAY);

	G->joystick.b0		=0;
	G->joystick.b1		=0;
    if (joy & JPF_BUTTON_RED)       G->joystick.b0		=TRUE;
    if (joy & JPF_BUTTON_PLAY)      G->joystick.b1		=TRUE;

	G->key=1;
	if(debug) printjoyport(n,joy);
}
/*==================================================================*/
ULONG MyDoMethodA(Object * obj,Msg msg);
void MySoundFree(AB_Music *M);
AB_Music *MyLoadSound(UBYTE* filename);
void MySoundPlay(struct game *G,AB_Music *M,ULONG replay,ULONG volume);
void MySoundStop(AB_Music *M);
void MySoundVolumeChange(AB_Music *M,LONG volumechange);
/*==================================================================================*/
BOOL OpenAmigaLibraries(void)
{
#define LIBCLOSE(libbase)	 if(libbase!=NULL)	{CloseLibrary( (struct Library  *)libbase );   libbase=NULL; }
#define LIBOPEN(libbase,name,version)  libbase	=(void*)OpenLibrary(#name,version);				if(libbase==NULL) 	return(FALSE);
#ifdef OS4
#define LIBOPEN4(interface,libbase)    interface=(void*)GetInterface((struct Library *)libbase, "main", 1, NULL);	if(interface==NULL)	return(FALSE);
#define LIBCLOSE4(interface) if(interface!=NULL)	{DropInterface((struct Interface*)interface );interface=NULL;}
#else
#define LIBOPEN4(interface,libbase)    ;
#define LIBCLOSE4(interface) ;	
#endif

	LIBOPEN(DOSBase,dos.library,36L)
	LIBOPEN(GfxBase,graphics.library,0L)
	LIBOPEN(IntuitionBase,intuition.library,0L)
	LIBOPEN(UtilityBase,utility.library,36L)
	LIBOPEN(GadToolsBase,gadtools.library,37L)
	LIBOPEN(CyberGfxBase,cybergraphics.library,0L)

	LIBOPEN(DataTypesBase,datatypes.library,39L)
	LIBOPEN(UtilityBase,utility.library,0)
	LIBOPEN(LowLevelBase,lowlevel.library,0)
	LIBOPEN(AslBase,asl.library,37)
	
__UtilityBase=UtilityBase;
#ifdef OS4
	LIBOPEN(P96Base,Picasso96API.library,0L)
#endif
	LIBOPEN4(IExec,SysBase)

	LIBOPEN4(IDOS,DOSBase)
	LIBOPEN4(IGraphics,GfxBase)
	LIBOPEN4(IIntuition,IntuitionBase)
	LIBOPEN4(IUtility,UtilityBase)
	LIBOPEN4(IGadTools,GadToolsBase)
	LIBOPEN4(ICyberGfx,CyberGfxBase)
	LIBOPEN4(IP96,P96Base)
	LIBOPEN4(IDataTypes,DataTypesBase)
	LIBOPEN4(IUtility,UtilityBase)
	LIBOPEN4(ILowLevel,LowLevelBase)
	LIBOPEN4(IAsl,AslBase)

	if (OpenDevice(TIMERNAME, UNIT_MICROHZ, (struct IORequest *)&tr, 0L) != 0)
		return(FALSE);
	TimerBase = (struct Device  *) tr.tr_node.io_Device;
	LIBOPEN4(ITimer,TimerBase);

	return(TRUE);
}
/*======================================================================================*/
void CloseAmigaLibraries()
{

	LIBCLOSE4(IDOS)
	LIBCLOSE4(IGraphics)
	LIBCLOSE4(IIntuition)
	LIBCLOSE4(IGadTools)
	LIBCLOSE4(ICyberGfx)
	LIBCLOSE4(ITimer)
	LIBCLOSE4(IP96)
	LIBCLOSE4(IDataTypes)
	LIBCLOSE4(IUtility)
	LIBCLOSE4(ILowLevel)
	LIBCLOSE4(IAsl)

	LIBCLOSE(DOSBase)
	LIBCLOSE(GfxBase)
	LIBCLOSE(IntuitionBase)
	LIBCLOSE(GadToolsBase)
	LIBCLOSE(UtilityBase)
	LIBCLOSE(CyberGfxBase)
	LIBCLOSE(DataTypesBase)
	LIBCLOSE(UtilityBase)
	LIBCLOSE(LowLevelBase)
	LIBCLOSE(AslBase)
#ifdef OS4
	LIBCLOSE(P96Base)
#endif	

	CloseDevice((struct IORequest *)&tr);
}
/*==========================================================================*/
void MyDrawText(struct game *G,WORD x,WORD y,UBYTE *text)
{
AB_Screen *S=G->screen;

	SetAPen(S->window->RPort,4);
	Move(S->window->RPort,x,y);
	Text(S->window->RPort,(void*)text, strlen(text));	
}
/*==========================================================================*/
void MyTextMsg(struct game *G,UBYTE *text)
{
AB_Screen *S=G->screen;

	strcpy(S->msgname,text);
	S->msgframe=S->frame+100;
}
/*=================================================================*/
void AB_Update(struct game *G)
{
AB_Screen *S=G->screen;
	
	REM(AB_Update)
	VAR(S->frame)

	if(S->frame % S->skipframe)
		Delay(1); 
	
	/* copy the "back buffer" to the window */
#ifdef OS4
	WaitBlit();
	BltBitMapRastPort(S->bufferrastport.BitMap,0,0,S->window->RPort,0,0,S->rect.w,S->rect.h,0xC0);
#endif
	
#ifdef OS3
	WritePixelArray(S->pixels,0,0,S->rect.w*32/8,S->window->RPort,0,0,S->rect.w,S->rect.h,RECTFMT_RGBA);
#endif
	if(S->frame < S->msgframe)
		MyDrawText(G,2,10,S->msgname);
	S->frame++;
}
/*=================================================================*/
BOOL OSOpenScreen(AB_Screen *S,int w,int h,char *name)
{
struct ScreenModeRequester *smr;
ULONG Flags =WFLG_ACTIVATE | WFLG_REPORTMOUSE | WFLG_RMBTRAP | WFLG_SIMPLE_REFRESH | WFLG_GIMMEZEROZERO ;
ULONG IDCMPs=IDCMP_CLOSEWINDOW | IDCMP_VANILLAKEY | IDCMP_RAWKEY | IDCMP_MOUSEMOVE | IDCMP_MOUSEBUTTONS ;
ULONG x,y;

	REM(OSOpenScreen)
    smr = (struct ScreenModeRequester *)AllocAslRequestTags(ASL_ScreenModeRequest,
        ASLSM_TitleText, (ULONG)"Select screenmode else window",
        ASLSM_DoDepth,   TRUE,
        TAG_END);
    if(!smr)
	goto panic;

    if(!AslRequest(smr, NULL))
	goto panic;
    S->screen = OpenScreenTags(NULL,
        SA_Width,		smr->sm_DisplayWidth,
        SA_Height,		smr->sm_DisplayHeight,
        SA_Depth,		smr->sm_DisplayDepth,
        SA_DisplayID,	smr->sm_DisplayID,
//		SA_Title,  		(ULONG)name,
//		SA_ShowTitle, 	TRUE,
//		SA_Draggable, 	TRUE,
	TAG_DONE);
	if(!S->screen) 
		goto panic;

#ifdef OS4
	x=0; y=20;	
	S->rect.w=smr->sm_DisplayWidth;
	S->rect.h=smr->sm_DisplayHeight-20;
	S->resizex=((float)S->rect.w)/((float)w);
	S->resizey=((float)S->rect.h)/((float)h);
	S->filter=TRUE;
#else
	x=(smr->sm_DisplayWidth  - S->rect.w     )/2;
	y=(smr->sm_DisplayHeight - S->rect.h - 20)/2+20;	
#endif	
	
	Flags =WFLG_ACTIVATE | WFLG_REPORTMOUSE |  WFLG_SIMPLE_REFRESH |  WFLG_BACKDROP |  WFLG_BORDERLESS ;	
	S->window = OpenWindowTags(NULL,
		WA_CustomScreen,    (ULONG)S->screen,
		WA_Left,            x,
		WA_Top,				y,
		WA_Width,           S->rect.w,
		WA_Height,			S->rect.h,
		WA_IDCMP,			IDCMPs,
		WA_Flags,			Flags,
		TAG_DONE);
	if(!S->window) 
		goto panic;

	FillPixelArray(&S->screen->RastPort,0,0,smr->sm_DisplayWidth,smr->sm_DisplayHeight,0);
	return(TRUE);
panic:
	printf("Error: Cant open screen\n");	
	return(FALSE);
}
/*=================================================================*/
int AB_InitGame(struct game *G,int w,int h,char *name)
{
AB_Screen *S;
ULONG Flags =WFLG_ACTIVATE | WFLG_REPORTMOUSE | WFLG_RMBTRAP | WFLG_SIMPLE_REFRESH | WFLG_GIMMEZEROZERO ;
ULONG IDCMPs=IDCMP_CLOSEWINDOW | IDCMP_VANILLAKEY | IDCMP_RAWKEY | IDCMP_MOUSEMOVE | IDCMP_MOUSEBUTTONS ;
UWORD screenlarge,screenhigh;
ULONG ModeID,ScreenBits;

/* open a window & a rastport ("back buffer") */	
	OpenAmigaLibraries();
REM(AB_InitGame)
debug=TRUE;
VAR(sizeof(struct game))	
VAR(sizeof(AB_Screen))	
debug=FALSE;	
	S=MYNEW(AB_Screen);
	if(S==NULL) return(FALSE);
	G->screen=S;
	S->frame		=0;
	S->skipframe	=2;
	S->volume		=32;
	S->rect.x		=0;
	S->rect.y		=0;
	S->rect.w		=w;		/* defaults but may change */
	S->rect.h		=h;
	S->screen		=NULL;
	S->window		=NULL;
	S->bm			=NULL;
	S->pixels		=NULL;
	S->msgframe		=0;
	S->msgname[0]	=0;

	if( OSOpenScreen(S,w,h,name)==TRUE ) 
		goto WindowDone;
	
#ifdef OS4
	S->rect.w=w*3;
	S->rect.h=h*3;
	S->resizex=3.0;
	S->resizey=3.0;
	S->filter=TRUE;
#endif	
	
	S->screen 	=LockPubScreen("Workbench") ;
	screenlarge	=S->screen->Width;
 	screenhigh	=S->screen->Height;
	ModeID = GetVPModeID(&S->screen->ViewPort);
	UnlockPubScreen(NULL, S->screen);
	S->screen=NULL;

	S->window = OpenWindowTags(NULL,
	WA_Activate,	TRUE,
	WA_InnerWidth,	S->rect.w,
	WA_InnerHeight,	S->rect.h,
	WA_Left,		(screenlarge - S->rect.w)/2,
	WA_Top,			(screenhigh  - S->rect.h)/2,
	WA_Title,		(ULONG)name,
	WA_DragBar,		TRUE,
	WA_CloseGadget,	TRUE,
	WA_GimmeZeroZero,	TRUE,
	WA_Backdrop,	FALSE,
	WA_Borderless,	FALSE,
	WA_IDCMP,		IDCMPs,
	WA_Flags,		Flags,
	TAG_DONE);
	if (S->window==NULL)
		{printf("Cant open window\n");return(FALSE);}

WindowDone:
#ifdef OS4
	InitRastPort( &S->bufferrastport );				/* allocate an other bitmap/rastport four double buffering */
	ScreenBits  = GetBitMapAttr( S->window->WScreen->RastPort.BitMap, BMA_DEPTH );
	Flags = BMF_DISPLAYABLE|BMF_MINPLANES;
	S->bufferrastport.BitMap = AllocBitMap(S->rect.w,S->rect.h,ScreenBits, Flags, S->window->RPort->BitMap);
	if(S->bufferrastport.BitMap==NULL)
		{printf("No Bitmap\n");return(FALSE);}
	S->bm=S->bufferrastport.BitMap;				/* draw in this back-buffer */
#endif
#ifdef OS3
	S->pixels=malloc(w*h*32/8);
	if(!S->pixels)
		{ free(S); return(FALSE);}
#endif		


	G->tiles=AB_LoadTexture(G,"graphics/tiles.png");
		
	printf("Amiga port - Alain Thellier - 2015 - Paris - France\n");
	printf(" + - s for sound\n");
	printf(" c     for spectrum/sega graphics\n");
	printf(" p     for pixels filtering\n");
		
	return(TRUE);
}
/*=================================================================*/
void AB_CloseGame(struct game *G)
{
AB_Screen *S=G->screen;
	
REM(AB_CloseGame)
	if(S->bm)		FreeBitMap(S->bm);
	if(S->window)	CloseWindow(S->window);
	if(S->pixels)	free(S->pixels);
	if(S->screen)	CloseScreen(S->screen);
	free(S);
	CloseAmigaLibraries();
}
/*=================================================================*/
void AB_Clear(struct game *G)
{
AB_Screen *S=G->screen;
	
#ifdef OS4
	p96RectFill(&S->bufferrastport,0,0,S->rect.w,S->rect.h,0);
#endif

#ifdef OS3
	memset(S->pixels,0,S->rect.w*S->rect.h*4);
#endif	
}	
/*==================================================================*/
ULONG MyDoMethodA(Object * obj,Msg msg)
{
ULONG result=0;
Class * cl;

	if(obj==NULL)
		return(result);
	cl = OCLASS(obj);

	if(cl==NULL)
		return(result);

	result =CallHookPkt(&cl->cl_Dispatcher,obj,msg);
	return(result);
}
/*=================================================================*/
void MySoundFree(AB_Music *M)
{
REM(MySoundFree)
	MySoundStop(M);
	VARS(M->filename)
	if(M->dtobject!=NULL) DisposeDTObject(M->dtobject);
	free(M);
}
/*=================================================================*/
AB_Music *MyLoadSound(UBYTE* filename)
{
ULONG id;
AB_Music *M;
struct VoiceHeader vh;
ULONG result,n;
UBYTE name[256];

REM(MyLoadSound)
	strcpy(name,filename);
	n=strlen(name);
	name[n-3]='w';
	name[n-2]='a';
	name[n-1]='v';
VARS(name)

	M=MYNEW(AB_Music);
	if(!M)
		{REM(error: cant AddIDO); return(NULL);}

		
	strcpy(M->filename,name);
	M->replay		=1;
	M->volume		=64;
	M->dtobject 	=NewDTObject(name, DTA_GroupID, GID_SOUND,SDTA_Volume,M->volume,TAG_END);
	if(!M->dtobject)
		{
		REM(cant load sound)
		MySoundFree(M);
		return(0);
		}
	strcpy(M->filename,name);
	M->GroupID=GID_SOUND;

	memset((void*)&vh,0,sizeof(struct VoiceHeader));
	result=GetDTAttrs(M->dtobject,SDTA_SampleLength,(ULONG)&M->sampleLength,SDTA_VoiceHeader,(ULONG)&vh,TAG_END);
	if(!result)
		{
		REM(cant read sizes)
		MySoundFree(M);
		return(0);
		}

	M->samplesPerSec= vh.vh_SamplesPerSec ;

	if(M->samplesPerSec!=0)
		M->duration	= (50 * M->sampleLength)/M->samplesPerSec ;	/* 50 ticks/sec*/
	else
		M->duration	= 0;

	return(M);
}
/*=================================================================*/
void MySoundPlay(struct game *G,AB_Music *M,ULONG replay,ULONG volume)
{
ULONG result;
BOOL same;
AB_Screen *S=G->screen;

REM(MySoundPlay)	
	if(S->volume==0) return;
	volume=S->volume;
	CHECK(M)
	same=FALSE;
	if(M->volume==volume)
	if(M->replay==replay)
		{same=TRUE;}

	if(!same)
		SetDTAttrs(M->dtobject, NULL, NULL, SDTA_Volume,volume,SDTA_Cycles,replay,TAG_DONE); 

	M->volume=volume;
	M->replay=replay;

	M->dtt.MethodID		= DTM_TRIGGER;
	M->dtt.dtt_GInfo	= NULL;
	M->dtt.dtt_Function	= STM_PLAY;
	M->dtt.dtt_Data		= NULL;
	result = MyDoMethodA(M->dtobject,(Msg) &M->dtt);

	Delay(1) ;			/* Needed but Why ???!? */
}
/*=================================================================*/
void MySoundStop(AB_Music *M)
{
ULONG result;

	CHECK(M)
	if(M->GroupID!=GID_SOUND)
		{REM(error: not a sound); return;}

	M->dtt.MethodID		= DTM_TRIGGER;
	M->dtt.dtt_GInfo	= NULL;
	M->dtt.dtt_Function	= STM_STOP;
	M->dtt.dtt_Data		= NULL;
	result = MyDoMethodA(M->dtobject,(Msg) &M->dtt);
}
/*=================================================================*/
void MySoundVolumeChange(AB_Music *M,LONG volumechange)
{
ULONG result;

	CHECK(M)
	if(volumechange < -64 )
		return( MySoundStop(M) );

	M->volume = M->volume + volumechange;
	if(M->volume > 64)
		M->volume = 64 ;
	if(M->volume < 0 )
		M->volume = 0 ;

	result=SetDTAttrs(M->dtobject,NULL,NULL,SDTA_Volume,M->volume,TAG_END);
}
/*=================================================================*/
void AB_PlayMusic(struct game *G,void* mus,int loops)
{
AB_Screen *S=G->screen;

	S->currentmus=mus;
	MySoundPlay(G,mus,1,S->volume);
}
/*=================================================================*/
void AB_HaltMusic(struct game *G)
{
AB_Screen *S=G->screen;

	MySoundVolumeChange(S->currentmus,-S->volume);	
}
/*=================================================================*/
void AB_PauseMusic(struct game *G)
{
AB_Screen *S=G->screen;

	MySoundVolumeChange(S->currentmus,-S->volume);
}
/*=================================================================*/
void AB_ResumeMusic(struct game *G)
{
AB_Screen *S=G->screen;

	MySoundVolumeChange(S->currentmus,S->volume);	
}
/*=================================================================*/
void AB_PlaySound(struct game *G,void* fx,int loops)
{
AB_Screen *S=G->screen;

	MySoundPlay(G,fx,1,S->volume);
}
/*=================================================================*/
void AB_FreeMusic(struct game *G,void* mus)
{
AB_Screen *S=G->screen;

	S->currentmus=NULL;
	MySoundFree(mus);
}
/*=================================================================*/
void AB_FreeSound(struct game *G,void* fx)
{
	MySoundFree(fx);
}
/*=================================================================*/
void* AB_LoadMusic(struct game *G,char *filename)
{
void *mus;
	
	mus=MyLoadSound(filename);
	return(mus);	
}
/*=================================================================*/
void* AB_LoadSound(struct game *G,char *filename)				
{
void *fx;
	
	fx=MyLoadSound(filename);
	return(fx);	
}
/*=================================================================*/
void ReadWriteGame(struct game *G,UBYTE mode)
{
BPTR fp;
ULONG size;

	if(G->chapter!=2)
		return;
	size=((ULONG)(&G->screen)) -((ULONG)(G));

	if(mode=='R')
	{		
	MyTextMsg(G,"Reading game save");
	fp=Open("abbaye.sav",MODE_OLDFILE);
	if(fp)
	{
	size = Read(fp,G,size);
	Close(fp);
	}
	}
	
	if(mode=='W')
	{		
	MyTextMsg(G,"Writing game save");
	fp=Open("abbaye.sav",MODE_NEWFILE);
	if(fp)
	{
	size = Write(fp,G,size);
	Close(fp);
	}
	}	
}
/*==================================================================================*/
#define RECTFMT_RGB   0
#define RECTFMT_RGBA  1
#define RECTFMT_ARGB  2
#define LBMI_WIDTH       0x84001001
#define LBMI_HEIGHT      0x84001002
/*==================================================================================*/
void BmReadPixelArray(UBYTE  *buf,void *rp,ULONG width,ULONG height)
{
	ReadPixelArray(buf,0,0,(width*24/8),rp,0,0,width,height,RECTFMT_RGB);
}
/*=================================================================*/
void AB_Grab(struct game *G)
{
AB_Screen *S=G->screen;
UBYTE filename[256];	
Object *dto=NULL; 
UBYTE  *buf=NULL;
BPTR 	   fp=0;
struct BitMap   *bm;
struct RastPort *rp;
struct pdtBlitPixelArray bpa; 
struct BitMapHeader *bmhd;
APTR bitMapHandle;
ULONG w,h;
ULONG result;
	
	sprintf(filename,"Abbaye_%ld.iff",G->room);
	rp=S->window->RPort;
	bm=rp->BitMap;
	w=S->rect.w;
	h=S->rect.h;

	dto = NewDTObject(NULL, DTA_SourceType,DTST_RAM, DTA_GroupID,GID_PICTURE, TAG_DONE); 
	if(!dto) goto panic;

	buf = malloc(24/8*w*h);
	if(!buf) goto panic;

	BmReadPixelArray(buf,rp,w,h);

	result=GetDTAttrs(dto, PDTA_BitMapHeader, (ULONG)&bmhd, TAG_DONE);
	bmhd->bmh_Left		= 0; 
	bmhd->bmh_Top		= 0; 
	bmhd->bmh_Width		= bmhd->bmh_PageWidth	= w; 
	bmhd->bmh_Height	= bmhd->bmh_PageHeight	= h; 
	bmhd->bmh_Depth		= 24; 
	bmhd->bmh_Masking	= 0; 	/* =mskHasAlpha; */

	result=SetDTAttrs (dto, NULL, NULL, 
		DTA_ObjName,		(ULONG)"Abbaye des morts grab", 
		DTA_NominalHoriz,	w, 
		DTA_NominalVert,	h, 
		PDTA_SourceMode,	PMODE_V43, 
		TAG_DONE); 

	bpa.MethodID 			= PDTM_WRITEPIXELARRAY; 
	bpa.pbpa_PixelData 		= buf; 
	bpa.pbpa_PixelFormat 	= PBPAFMT_RGB; 
	bpa.pbpa_PixelArrayMod 	= w*24/8; 
	bpa.pbpa_Left 			= 0; 
	bpa.pbpa_Top 			= 0; 
	bpa.pbpa_Height 		= h; 
	bpa.pbpa_Width 			= w; 
	result=MyDoMethodA(dto,(Msg)&bpa);

	result=DoDTMethod(dto,NULL,NULL,DTM_CLEARSELECTED,NULL);

	fp=Open(filename,MODE_NEWFILE);
	result=DoDTMethod(dto,NULL,NULL,DTM_WRITE,NULL,fp,DTWM_IFF,NULL);
	if(result!=1)
		printf("Error: picture.datatype cant save\n");
panic:
	if(fp)	Close(fp);
	if(dto)	DisposeDTObject(dto); 
	if(buf)	free(buf); 
}
/*=================================================================*/
void AB_Events(struct game *G)
{							/* manage the window  */
AB_Screen *S=G->screen;
struct IntuiMessage *imsg;
ULONG key;	
UBYTE name[256];
	

REM(AB_Events)
	OSJoystick(G);
		
	key=0;
	while(imsg = (struct IntuiMessage *)GetMsg(S->window->UserPort) )
	{
	switch (imsg->Class)
		{
			case IDCMP_CLOSEWINDOW:
			key=27;
			break;

			case IDCMP_VANILLAKEY:
			key=imsg->Code;
			break;

			default:
			break;
		}

	if(key=='p') 	S->filter=!S->filter;

	if(key=='t') 	G->trainer=!G->trainer;
	if(key=='l') 	G->jean.lifes++;

	if(key=='d') 	debug=!debug;

	if(key=='s')
	{
	if(S->volume>0)	
			{S->volume=0; MyTextMsg(G,"Sound:OFF");} 
	else  
			{S->volume=0; MyTextMsg(G,"Sound:MAX");} 
	}

	if(key=='R')
		ReadWriteGame(G,'R');	
	if(key=='W')
		ReadWriteGame(G,'W');
	if(key=='g')
		{AB_Grab(G); sprintf(name,"Room %ld Grabbed",G->room);MyTextMsg(G,name);}
	
	if(key=='-')
	if(S->volume>0)	
		{S->volume--;sprintf(name,"Volume:%ld",S->volume); MyTextMsg(G,name);}

	if(key=='+')
	if(S->volume<64)	
		{S->volume++;sprintf(name,"Volume:%ld",S->volume); MyTextMsg(G,name);}

	if (key == 'c') 
			G->grapset=!G->grapset;	/* Change graphic set */

	if (key == 'f') 
			{ 
				G->fullscreen = !G->fullscreen ;	/* Switch fullscreen/windowed */
				MyTextMsg(G,"No Window/Screen change on Amiga");
			}
			
   	if (key == 27)
			G->chapter = 6;

	G->key=key;
	if(imsg)
		{ReplyMsg((struct Message *)imsg);imsg = NULL;}
	}
}
/*==================================================================*/
AB_Texture *CreateTexture(struct game *G,ULONG w,ULONG h)
{
AB_Texture *T;
	
REM(CreateTexture)
	T=MYNEW(AB_Texture);
	RCHECK(T)

	T->rect.x		=0;
	T->rect.y		=0;
	T->rect.w		=w;
	T->rect.h		=h;
#ifdef OS4
	T->bm = p96AllocBitMap(w,h,32,BMF_DISPLAYABLE,NULL,RGBFB_A8R8G8B8);
	if(!T->bm)
		{ free(T); return(NULL);}
#endif 

#ifdef OS3
	T->pixels=malloc(w*h*32/8);
	if(!T->pixels)
		{ free(T); return(NULL);}
#endif
	return(T);
}
/*==================================================================*/
void BlackToAlpha(AB_Texture *T)
{
#ifdef OS4
LONG lock;					/* to directly write to bm */
ULONG x,y;
UBYTE *ARGB;
struct RenderInfo renderInfo;
ULONG xoffset;
ULONG v;

	if(T->bm==NULL) return;
	lock=p96LockBitMap(T->bm, (UBYTE*)&renderInfo, sizeof(renderInfo));
	ARGB=renderInfo.Memory;
	xoffset= p96GetBitMapAttr(T->bm, P96BMA_BYTESPERROW) - (T->rect.w*32/8);
	YLOOP(T->rect.h)
	{
	XLOOP(T->rect.w)
		{
		ARGB[0]=255;
		v=ARGB[1]+ARGB[2]+ARGB[3];
		if(v == 0)			/* if black */
			ARGB[0]=0;						/* then transp alpha */
		ARGB+=4;
		}
	ARGB+=xoffset;
	}

	p96UnlockBitMap(T->bm,lock);
#endif	

#ifdef OS3
ULONG x,y;
UBYTE *RGBA;
UBYTE r,g,b,a;
ULONG v;

	if(T->pixels==NULL) return;
	RGBA=T->pixels;
	YLOOP(T->rect.h)
	{
	XLOOP(T->rect.w)
		{
		a=255;
		r=RGBA[1];
		g=RGBA[2];
		b=RGBA[3];
		v=r+g+b;
		if(v == 0)			/* if black */
			a=0;						/* then transp alpha */
		RGBA[0]=r;
		RGBA[1]=g;
		RGBA[2]=b;
		RGBA[3]=a;			
		RGBA+=4;
		}
	}

#endif	
}
/*==================================================================================*/
void* AB_LoadTexture(struct game *G,char *filename)
{
AB_Texture *T;
#ifdef OS4
struct BitMapHeader *bitMapHeader = NULL;
struct RenderInfo renderInfo;
struct pdtBlitPixelArray bpa;
Object* dto ;
ULONG srcBytesPerRow,lock;
ULONG result,w,h;
	
REM(AB_LoadTexture)
VARS(filename)
	dto= NewDTObject(filename, DTA_SourceType,DTST_FILE, DTA_GroupID, GID_PICTURE,PDTA_DestMode, PMODE_V43,PDTA_Remap, FALSE,TAG_DONE);

	if(!dto)
		REM(ERROR: Could not open texture file)
	
	if(GetDTAttrs(dto,PDTA_BitMapHeader,&bitMapHeader,TAG_DONE) != 1)
	{
		DisposeDTObject(dto);
		REM(Could not obtain the picture objects bitmap header)
	}

	w	=bitMapHeader->bmh_Width;
	h	=bitMapHeader->bmh_Height;
	T	=CreateTexture(G,w,h);
	
	if(T==NULL)
		goto panic;	
	strcpy(T->filename,filename);

	// Extract the bitmap data from the picture object
	// NOTE: For some reason the picture datatype kills the alpha channel unless
	// we extract the pixel data using PDTM_READPIXELARRAY

	lock = p96LockBitMap(T->bm,(UBYTE*)&renderInfo, sizeof(renderInfo));
	srcBytesPerRow = p96GetBitMapAttr(T->bm, P96BMA_BYTESPERROW);
	
	bpa.MethodID		= PDTM_READPIXELARRAY;
	bpa.pbpa_PixelData	= renderInfo.Memory;
	bpa.pbpa_PixelFormat	= PBPAFMT_ARGB;
	bpa.pbpa_PixelArrayMod	= srcBytesPerRow;
	bpa.pbpa_Left		= 0;
	bpa.pbpa_Top		= 0;
	bpa.pbpa_Width		= T->rect.w;
	bpa.pbpa_Height		= T->rect.h;

	result=MyDoMethodA(dto,(Msg)&bpa);
	
	p96UnlockBitMap(T->bm, lock);

	BlackToAlpha(T);
panic:	
	DisposeDTObject(dto);
#endif

#ifdef OS3
struct BitMapHeader *bitMapHeader = NULL;
struct pdtBlitPixelArray bpa;
Object* dto ;
ULONG srcBytesPerRow;
ULONG result,w,h;
	
REM(AB_LoadTexture)
VARS(filename)
	dto= NewDTObject(filename, DTA_SourceType,DTST_FILE, DTA_GroupID, GID_PICTURE,PDTA_DestMode, PMODE_V43,PDTA_Remap, FALSE,TAG_DONE);

	if(!dto)
		REM(ERROR: Could not open texture file)
	
	if(GetDTAttrs(dto,PDTA_BitMapHeader,(ULONG)&bitMapHeader,TAG_DONE) != 1)
	{
		DisposeDTObject(dto);
		REM(Could not obtain the picture objects bitmap header)
	}

	w	=bitMapHeader->bmh_Width;
	h	=bitMapHeader->bmh_Height;
	T	=CreateTexture(G,w,h);
	
	if(T==NULL)
		goto panic;	
	strcpy(T->filename,filename);

	// Extract the bitmap data from the picture object
	// NOTE: For some reason the picture datatype kills the alpha channel unless
	// we extract the pixel data using PDTM_READPIXELARRAY

	srcBytesPerRow = w*4;
	
	bpa.MethodID		= PDTM_READPIXELARRAY;
	bpa.pbpa_PixelData	= T->pixels;
	bpa.pbpa_PixelFormat	= PBPAFMT_ARGB;
	bpa.pbpa_PixelArrayMod	= srcBytesPerRow;
	bpa.pbpa_Left		= 0;
	bpa.pbpa_Top		= 0;
	bpa.pbpa_Width		= T->rect.w;
	bpa.pbpa_Height		= T->rect.h;

	result=MyDoMethodA(dto,(Msg)&bpa);
	
	BlackToAlpha(T);
panic:	
	DisposeDTObject(dto);
#endif
	return(T);
}
/*==================================================================*/
void AB_DestroyTexture(struct game *G,void* tex)
{
AB_Texture *T=tex;
	
REM(AB_DestroyTexture)
VARS(T->filename)
	
#ifdef OS4
	if(T->bm)
	{
      	p96FreeBitMap(T->bm);
      	T->bm = NULL;
	}
	free(T);
#endif
	
#ifdef OS3
	if(T->pixels)
	{
      	free(T->pixels);
      	T->pixels = NULL;
	}
	free(T);
#endif	
}
/*================================================================*/
struct XYSTW_Vertex3D { 
float x, y; 
float s, t, w; 
}; 
/*=================================================================*/
void SetP(struct XYSTW_Vertex3D  *P,float x, float y,float u, float v)
{
	P->x=x; P->y=y;P->s=u; P->t=v;P->w=1.0;
}
/*=================================================================*/
void PrintRect(AB_Rect *r)
{
	if(!debug) return;
	printf("Rect: %ld %ld (%ldX%ld) \n",r->x,r->y,r->w,r->h);
}
/*=================================================================*/
BOOL RectInScreen(AB_Rect *screen,AB_Rect *sprite,AB_Rect *bitmap)
{
WORD sprite_xmax,sprite_ymax,screen_xmax,screen_ymax,cut;

	if(sprite==screen)	return(TRUE);

	sprite_xmax	=sprite->x+sprite->w-1;
	sprite_ymax	=sprite->y+sprite->h-1;
	screen_xmax	=screen->x+screen->w-1;
	screen_ymax	=screen->y+screen->h-1;
	
	if(sprite_xmax < screen->x) {REM(out x   );PrintRect(sprite);return(FALSE);}
	if(sprite_ymax < screen->y) {REM(out y   );PrintRect(sprite);return(FALSE);}
	if(screen_xmax < sprite->x) {REM(out xmax);PrintRect(sprite);return(FALSE);}
	if(screen_ymax < sprite->y) {REM(out ymax);PrintRect(sprite);return(FALSE);}

	if(sprite->x	< screen->x)
		{REM(clip x);PrintRect(sprite);cut=screen->x - sprite->x; sprite->x+=cut; sprite->w-=cut; bitmap->x+=cut; bitmap->w-=cut;VAR(cut)}
	if(sprite->y	< screen->y)
		{REM(clip y);PrintRect(sprite);cut=screen->y - sprite->y; sprite->y+=cut; sprite->h-=cut; bitmap->y+=cut; bitmap->h-=cut;VAR(cut)}
	if(screen_xmax	< sprite_xmax)
		{REM(clip xmax);PrintRect(sprite);cut=sprite_xmax - screen_xmax; sprite->w-=cut; bitmap->w-=cut;VAR(cut)}
	if(screen_ymax	< sprite_ymax)
		{REM(clip ymax);PrintRect(sprite);cut=sprite_ymax - screen_ymax; sprite->h-=cut; bitmap->h-=cut;VAR(cut)}
 
	return(TRUE);
}	
/*==================================================================*/
void AB_DrawSprite(struct game *G,void *tex,AB_Rect *src,AB_Rect *dst)
{
AB_Texture *T=tex;
AB_Screen *S=G->screen;
#ifdef OS4
ULONG CompMode,flags,error;
APTR srcbm,dstbm;
float  rx,ry;

ULONG sx,sy,shigh,slarge;
float x,y,large,high,u,v,su,sv;
struct XYSTW_Vertex3D *P;
struct XYSTW_Vertex3D QUAD[4];
struct XYSTW_Vertex3D TRI[2*3];
#define COPYV(a,b)   { (a)->x=(b)->x; (a)->y=(b)->y; (a)->s=(b)->s; (a)->t=(b)->t; (a)->w=(b)->w;  }
	
	REM(AB_DrawSprite)
	CompMode=COMPOSITE_Src_Over_Dest;
//	flags=COMPFLAG_HardwareOnly | COMPFLAG_SrcFilter|COMPFLAG_IgnoreDestAlpha;
	if(S->filter)
		flags= COMPFLAG_SrcFilter|COMPFLAG_IgnoreDestAlpha;
	else
		flags= COMPFLAG_IgnoreDestAlpha;
	srcbm=T->bm;
	dstbm=S->bm;
	rx=S->resizex;
	ry=S->resizey;

	if(srcbm==NULL)
		{ printf(" bm %ld to %ld  \n",srcbm, dstbm); return; }
	if(dstbm==NULL)
		{ printf(" bm %ld to %ld  \n",srcbm, dstbm); return; }

	if(src==NULL)
		src=&T->rect; 
	if(dst==NULL)
		dst=&S->rect; 

	

		u=src->x;
		v=src->y;
		su=src->w;
		sv=src->h;
		x=dst->x*rx;
		y=dst->y*ry;
		large=dst->w*rx;
		high=dst->h*ry;

	P=QUAD;
	SetP(&P[0],x,y,u,v);
	SetP(&P[1],x,y+high,u,v+sv);
	SetP(&P[2],x+large,y+high,u+su,v+sv);
	SetP(&P[3],x+large,y,u+su,v);

	COPYV( &TRI[0] , &QUAD[0] );
	COPYV( &TRI[1] , &QUAD[1] );
	COPYV( &TRI[2] , &QUAD[2] );
	COPYV( &TRI[3] , &QUAD[0] );
	COPYV( &TRI[4] , &QUAD[2] );
	COPYV( &TRI[5] , &QUAD[3] );

	P=TRI;
	sx		=0;
	sy		=0;
	slarge 	=S->rect.w;
	shigh	=S->rect.h;

	error = CompositeTags(CompMode, 
		srcbm,dstbm,
		COMPTAG_VertexArray, P, 
		COMPTAG_VertexFormat,COMPVF_STW0_Present,
	    	COMPTAG_NumTriangles,2,
		COMPTAG_DestX,sx,
		COMPTAG_DestY,sy,
		COMPTAG_DestWidth ,slarge,
		COMPTAG_DestHeight,shigh,
		COMPTAG_Flags, flags ,
		TAG_DONE);

	if(error != COMPERR_Success)
			printf("CompositeTags error %d\n",error);
#endif

#ifdef OS3
register ULONG *SRGBA;
register ULONG *DRGBA;
register ULONG x,y;
/* register ULONG alpha=0x000000ff; */
register ULONG soffset,doffset;
AB_Rect src2,dst2;
#define AND &

	REM(AB_DrawSprite)
	if(src==NULL)
		src=&T->rect; 
	if(dst==NULL)
		dst=&S->rect; 

	src2.x=src->x;	/*rect local copy for clipping it */
	src2.y=src->y;	
	src2.w=src->w;	
	src2.h=src->h;	

	dst2.x=dst->x;	/*rect local copy for clipping it */
	dst2.y=dst->y;	
	dst2.w=dst->w;	
	dst2.h=dst->h;	

	src=&src2; 
	dst=&dst2; 

	if( RectInScreen(&S->rect,dst,src) == FALSE) return;

	SRGBA=(ULONG*)T->pixels;
	DRGBA=(ULONG*)S->pixels;
	soffset= src->y*T->rect.w+src->x;
	doffset= dst->y*S->rect.w+dst->x;
	SRGBA += soffset;
	DRGBA += doffset;

	soffset= T->rect.w; 
	doffset= S->rect.w; 
	
	YLOOP(dst->h)
	{
	XLOOP(dst->w)
	{
/*		if(SRGBA[x] AND alpha ) not needed as only black(=0) is transparent*/
		if(SRGBA[x])
			DRGBA[x]=SRGBA[x];
	}
	SRGBA+=soffset;
	DRGBA+=doffset;	
	}

#endif
}
/*==================================================================*/
void AB_NewMusicN(struct game *G,int n,int loops)
{
	AB_HaltMusic(G);
	AB_PlayMusic(G,G->bso[n],loops);
}
/*==================================================================*/
void AB_PlaySoundN(struct game *G,int n,int loops)
{
	AB_PlaySound(G,G->fx[n],loops);
}
/*==================================================================*/		
void AB_Drawtexture(struct game *G,char *filename)
{
void* tex;
	tex= AB_LoadTexture(G,filename);
	AB_DrawSprite(G,tex,NULL,NULL);
	AB_DestroyTexture(G,tex);
}
/*==================================================================*/
