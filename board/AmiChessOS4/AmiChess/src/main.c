#define __NOLIBBASE__

#include <proto/exec.h>
#include <proto/datatypes.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#include <proto/locale.h>
#include <proto/muimaster.h>
#include <proto/asyncio.h>
#include <datatypes/pictureclass.h>
#include <datatypes/soundclass.h>
#include <dos/dostags.h>
#include <graphics/scale.h>
#include <workbench/startup.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "common.h"

/* external references */
extern struct MUI_CustomClass *MUI_Chess_Class;
extern struct Library *SysBase, *DOSBase;

extern void INIT_6_MUI_Chess_Class(void);
extern void INIT_6_MUI_Board_Class(void);
extern void INIT_6_MUI_Field_Class(void);
extern void INIT_6_MUI_Edit_Class(void);
extern void EXIT_6_MUI_Chess_Class(void);
extern void EXIT_6_MUI_Board_Class(void);
extern void EXIT_6_MUI_Field_Class(void);
extern void EXIT_6_MUI_Edit_Class(void);

extern void init_catalog( void );
extern void close_catalog( void );

Object *mui_app;

struct Library
 *AsyncIOBase,
 *IntuitionBase,
 *GfxBase,
 *DataTypesBase,
 *IconBase,
 *LocaleBase,
 *MUIMasterBase,
 *TimerBase,
 *UtilityBase;

#if defined(__amigaos4__)

struct AsyncIOIFace 	*IAsyncIO 		= NULL;
struct IntuitionIFace *IIntuition 	= NULL;
struct GraphicsIFace 	*IGraphics 		= NULL;
struct DataTypesIFace *IDataTypes 	= NULL;
struct IconIFace 			*IIcon 				= NULL;
struct LocaleIFace 		*ILocale 			= NULL;
struct MUIMasterIFace *IMUIMaster 	= NULL;
struct TimerIFace 		*ITimer 			= NULL;
extern struct UtilityIFace 	 *IUtility; // 		 = NULL;

#define GETINTERFACE(iface, base)	(iface = (APTR)GetInterface((struct Library *)(base), "main", 1L, NULL))
#define DROPINTERFACE(iface)			(DropInterface((struct Interface *)iface), iface = NULL)

#else

void
	*IAsyncIO 		= NULL,
	*IIntuition 	= NULL,
	*IGraphics 		= NULL,
	*IDataTypes 	= NULL,
	*IIcon 				= NULL,
	*ILocale 			= NULL,
	*IMUIMaster 	= NULL,
	*ITimer 			= NULL,
	*IUtility 	  = NULL;

#define GETINTERFACE(iface, base)	TRUE
#define DROPINTERFACE(iface)

#endif

struct timerequest *TimeReq;
struct MsgPort *TimePort;

struct DiskObject *PrgIcon;
struct Screen *wbscreen;
ULONG pix_x;
ULONG col_white,col_black;
Object *piecesgfx;
struct BitMap *pieces_bm;
APTR pieces_mask;
char *pieces_folder;
Object *board_light;
struct BitMap *board_light_bm;
Object *board_dark;
struct BitMap *board_dark_bm;

Object *piecesedit;
struct BitMap *pieces_edit_bm;
APTR pieces_edit_mask;

ULONG snd_signal,snd_sigmask;
Object *snd_move;
Object *snd_mate;
Object *snd_smate;
Object *snd_draw;
Object *snd_takes,*snd_hit;
Object *snd_check;
Object *snd_00,*snd_000,*snd_castle;
Object *snd_P;
Object *snd_N;
Object *snd_B;
Object *snd_R;
Object *snd_Q;
Object *snd_K;
Object *snd_fielda[8],*snd_field1[8];

BOOL SoundOn;   /* sound is enabled if sound.datatype 50.18 or newer is detected */

ULONG voice,promotepiece;

struct
{
  char *pubscreen;
} args;

BOOL InitTimer(void)
{
  if ((TimePort = CreateMsgPort()))
  {
		if ((TimeReq = (struct timerequest *)CreateIORequest(TimePort, sizeof(struct timerequest))))
    {
      if (OpenDevice("timer.device", UNIT_MICROHZ, &TimeReq->tr_node, 0) == 0)
      {
        TimerBase = (struct Library*)TimeReq->tr_node.io_Device;
				GETINTERFACE(ITimer, TimerBase);
        return TRUE;
      }
    }
  }
  return FALSE;
}

void CloseTimer(void)
{
	if (TimerBase){ CloseDevice((struct IORequest*)TimeReq); DROPINTERFACE(ITimer);}
  if (TimeReq) DeleteIORequest((struct IORequest*)TimeReq);
  if (TimePort) DeleteMsgPort(TimePort);
}

void CheckSoundDt(void)
{

	SoundOn = TRUE;

	struct Library *sndbase;

  if ((sndbase = OpenLibrary("datatypes/sound.datatype", 50)))
  {
    if ((sndbase->lib_Version > 50) || (sndbase->lib_Revision > 17)) SoundOn = TRUE;
    else
    {
      SoundOn = FALSE;
      MUI_Request(NULL, NULL, 0, "AmiChess", "OK", "sound.datatype is older than 50.18.\nIn game sounds are disabled.");
    }
    CloseLibrary(sndbase);
  }

}

BOOL OpenLibs(void)
{
	if (!(IntuitionBase = OpenLibrary("intuition.library", 50 ))) return FALSE;
	if (!(DOSBase = OpenLibrary("dos.library", 50 ))) return FALSE;
	if (!(GfxBase = OpenLibrary("graphics.library", 50 ))) return FALSE;
	if (!(DataTypesBase = OpenLibrary("datatypes.library", 50 ))) return FALSE;
	if (!(IconBase = OpenLibrary("icon.library", 41 ))) return FALSE;
	if (!(LocaleBase = OpenLibrary("locale.library", 50 ))) return FALSE;
	if (!(MUIMasterBase = OpenLibrary("muimaster.library", 20 ))) return FALSE;
	if (!(AsyncIOBase = OpenLibrary("asyncio.library", 40 ))) return FALSE;
	if (!(UtilityBase = OpenLibrary("utility.library", 50 ))) return FALSE;

	GETINTERFACE(IIntuition, IntuitionBase);
	GETINTERFACE(IDOS, DOSBase);
	GETINTERFACE(IGraphics, GfxBase);
	GETINTERFACE(IDataTypes, DataTypesBase);
	GETINTERFACE(IIcon, IconBase);
	GETINTERFACE(ILocale, LocaleBase);
	GETINTERFACE(IMUIMaster, MUIMasterBase);
	GETINTERFACE(IAsyncIO, AsyncIOBase);
	GETINTERFACE(IUtility, UtilityBase);
	
	if (!(InitTimer())) return FALSE;
  INIT_6_MUI_Chess_Class();
  INIT_6_MUI_Board_Class();
  INIT_6_MUI_Field_Class();
  INIT_6_MUI_Edit_Class();
  CheckSoundDt();
  return TRUE;
}

void CloseLibs(void)
{
  EXIT_6_MUI_Chess_Class();
  EXIT_6_MUI_Board_Class();
  EXIT_6_MUI_Field_Class();
  EXIT_6_MUI_Edit_Class();
	CloseTimer();                                                       

	if (UtilityBase){ CloseLibrary(UtilityBase); }
	if (AsyncIOBase){ CloseLibrary(AsyncIOBase); }
	if (MUIMasterBase){ CloseLibrary(MUIMasterBase); }
	if (LocaleBase){ CloseLibrary(LocaleBase); }
	if (IconBase){ CloseLibrary(IconBase); }
	if (DataTypesBase){ CloseLibrary(DataTypesBase); }
	if (GfxBase){ CloseLibrary(GfxBase); }
	if (DOSBase){ CloseLibrary(DOSBase); }
	if (IntuitionBase){ CloseLibrary(IntuitionBase); }

	if (IUtility){ DROPINTERFACE(IUtility); }
	if (IAsyncIO){ DROPINTERFACE(IAsyncIO); }
	if (IMUIMaster){ DROPINTERFACE(IMUIMaster); }
	if (ILocale){ DROPINTERFACE(ILocale); }
	if (IIcon){ DROPINTERFACE(IIcon); }
	if (IDataTypes){ DROPINTERFACE(IDataTypes); }
	if (IGraphics){ DROPINTERFACE(IGraphics); }
	if (IDOS){ DROPINTERFACE(IDOS); }

}

void FreePieces(void)
{
  if(piecesgfx)
  {
    DisposeDTObject(piecesgfx);
    piecesgfx=0;
    pieces_bm=0;
    pieces_mask=0;
  }
}

void LoadPieces(STRPTR name)
{
  BPTR lock;

  FreePieces();
  if((lock=Lock(pieces_folder, SHARED_LOCK)))
  {
    BPTR oldlock=CurrentDir(lock);
    if ((piecesgfx=NewDTObject((APTR)name,
     DTA_GroupID, GID_PICTURE,
     PDTA_DestMode, PMODE_V43,
     PDTA_Remap, TRUE,
     PDTA_Screen, wbscreen,
     PDTA_FreeSourceBitMap, TRUE,
     PDTA_UseFriendBitMap, TRUE,
    TAG_END)))
    {
      if(DoDTMethod(piecesgfx, 0, 0, DTM_PROCLAYOUT, 0, 1))
      {
        GetDTAttrs(piecesgfx,
         PDTA_DestBitMap, &pieces_bm,
         PDTA_MaskPlane, &pieces_mask,
        TAG_END);
      }
    }
    CurrentDir(oldlock);
    UnLock(lock);
  }
}

void FreeEdit(void)
{
  if (piecesedit)
  {
    DisposeDTObject(piecesedit);
    piecesedit=0;
  }
}

BOOL LoadEdit(void)
{
  if ((piecesedit = NewDTObject("PROGDIR:Pieces/640/Default",
   DTA_GroupID, GID_PICTURE,
   PDTA_DestMode, PMODE_V43,
   PDTA_Remap, TRUE,
   PDTA_Screen, wbscreen,
   PDTA_FreeSourceBitMap, TRUE,
   PDTA_UseFriendBitMap, TRUE,
  TAG_END)))
  {
    if (DoDTMethod(piecesedit, 0, 0, DTM_PROCLAYOUT, 0, 1))
    {
      GetDTAttrs(piecesedit,
       PDTA_DestBitMap, &pieces_edit_bm,
       PDTA_MaskPlane, &pieces_edit_mask,
      TAG_END);
      return TRUE;
    }
  }
  return FALSE;
}

static void ScaleBitMaps(struct BitMap *src,UWORD srcw,UWORD srch,struct BitMap *dest,UWORD destw,UWORD desth)
{
	struct BitScaleArgs bsa;
	bsa.bsa_SrcX=0;
	bsa.bsa_SrcY=0;
	bsa.bsa_SrcWidth=srcw;
	bsa.bsa_SrcHeight=srch;
	bsa.bsa_XSrcFactor=srcw;
	bsa.bsa_YSrcFactor=srch;
	bsa.bsa_DestX=0;
	bsa.bsa_DestY=0;
	bsa.bsa_DestWidth=destw;
	bsa.bsa_DestHeight=desth;
	bsa.bsa_XDestFactor=destw;
	bsa.bsa_YDestFactor=desth;
	bsa.bsa_SrcBitMap=src;
	bsa.bsa_DestBitMap=dest;
	bsa.bsa_Flags=0;
	bsa.bsa_XDDA=0;
	bsa.bsa_YDDA=0;
	bsa.bsa_Reserved1=0;
	bsa.bsa_Reserved2=0;
	BitMapScale(&bsa);
}

static void FreeBoard(void)
{
	if(board_light)
	        {
	        DisposeDTObject(board_light);
	        board_light=0;
	        }
	if(board_light_bm)
	        {
	        FreeBitMap(board_light_bm);
	        board_light_bm=0;
	        }
	if(board_dark)
	        {
	        DisposeDTObject(board_dark);
	        board_dark=0;
	        }
	if(board_dark)
	        {
	        FreeBitMap(board_dark_bm);
	        board_dark_bm=0;
	        }
}

void LoadBoard(char *name)
{
	BPTR lock1;
	FreeBoard();
	if((lock1=Lock("PROGDIR:Boards",SHARED_LOCK)))
	        {
	        BPTR oldlock=CurrentDir(lock1);
	        BPTR lock2;
	        if((lock2=Lock(name,SHARED_LOCK)))
	                {
	                struct BitMap *bm,*wbm=wbscreen->RastPort.BitMap;
	                struct BitMapHeader *bh;
	                CurrentDir(lock2);
	                if((board_light=NewDTObject("Light",DTA_GroupID,GID_PICTURE,PDTA_DestMode,PMODE_V43,PDTA_Remap,1,PDTA_Screen,wbscreen,PDTA_FreeSourceBitMap,1,PDTA_UseFriendBitMap,1,TAG_END)))
	                        {
	                        if(DoDTMethod(board_light,0,0,DTM_PROCLAYOUT,0,1))
	                                {
	                                GetDTAttrs(board_light,PDTA_BitMapHeader,&bh,PDTA_DestBitMap,&bm,TAG_END);
	                                if((board_light_bm=AllocBitMap(pix_x,pix_x,GetBitMapAttr(wbm,BMA_DEPTH),BMF_MINPLANES,wbm))) ScaleBitMaps(bm,bh->bmh_Width,bh->bmh_Height,board_light_bm,pix_x,pix_x);
	                                }
	                        }
	                if((board_dark=NewDTObject("Dark",DTA_GroupID,GID_PICTURE,PDTA_DestMode,PMODE_V43,PDTA_Remap,1,PDTA_Screen,wbscreen,PDTA_FreeSourceBitMap,1,PDTA_UseFriendBitMap,1,TAG_END)))
	                        {
	                        if(DoDTMethod(board_dark,0,0,DTM_PROCLAYOUT,0,1))
	                                {
	                                GetDTAttrs(board_dark,PDTA_BitMapHeader,&bh,PDTA_DestBitMap,&bm,TAG_END);
	                                if((board_dark_bm=AllocBitMap(pix_x,pix_x,GetBitMapAttr(wbm,BMA_DEPTH),BMF_MINPLANES,wbm))) ScaleBitMaps(bm,bh->bmh_Width,bh->bmh_Height,board_dark_bm,pix_x,pix_x);
	                                }
	                        }
	                UnLock(lock2);
	                }
	        CurrentDir(oldlock);
	        UnLock(lock1);
	        }
}

static void FreeSound(void)
{
	ULONG i;
	DisposeDTObject(snd_move);
	DisposeDTObject(snd_mate);
	DisposeDTObject(snd_smate);
	DisposeDTObject(snd_draw);
	DisposeDTObject(snd_takes);
	DisposeDTObject(snd_hit);
	DisposeDTObject(snd_check);
	DisposeDTObject(snd_00);
	DisposeDTObject(snd_000);
	DisposeDTObject(snd_castle);
	DisposeDTObject(snd_P);
	DisposeDTObject(snd_N);
	DisposeDTObject(snd_B);
	DisposeDTObject(snd_R);
	DisposeDTObject(snd_Q);
	DisposeDTObject(snd_K);
	for(i=0;i<8;i++)
	        {
	        DisposeObject(snd_fielda[i]);
	        DisposeObject(snd_field1[i]);
	        }
	if(snd_signal!=~0) FreeSignal(snd_signal);
}

static void LoadSound(void)
{
	BPTR lock;
	
	if ( (lock = Lock("PROGDIR:Sounds",SHARED_LOCK)) )
	{
    ULONG i;
    BPTR oldlock=CurrentDir(lock);
    struct TagItem tags[5];
    char text[10];

    tags[0].ti_Tag=DTA_GroupID;
    tags[0].ti_Data=GID_SOUND;
    tags[1].ti_Tag=SDTA_SignalTask;
    tags[1].ti_Data=(ULONG)FindTask(0);
    tags[2].ti_Tag=SDTA_SignalBit;
    tags[2].ti_Data=snd_sigmask;
    tags[3].ti_Tag=SDTA_Volume;
    tags[3].ti_Data=64;
    tags[4].ti_Tag=TAG_END;
		
		snd_move=NewDTObjectA("Tap",tags);
    snd_mate=NewDTObjectA("Mate",tags);
    snd_smate=NewDTObjectA("Stalemate",tags);
    snd_draw=NewDTObjectA("Draw",tags);
    snd_takes=NewDTObjectA("Takes",tags);
    snd_hit=NewDTObjectA("Hit",tags);
    snd_check=NewDTObjectA("Check",tags);
    snd_00=NewDTObjectA("O-O",tags);
    snd_000=NewDTObjectA("O-O-O",tags);
    snd_castle=NewDTObjectA("Castling",tags);
		
		snd_P=NewDTObjectA("Pawn",tags);
    snd_N=NewDTObjectA("Knight",tags);
    snd_B=NewDTObjectA("Bishop",tags);
    snd_R=NewDTObjectA("Rook",tags);
    snd_Q=NewDTObjectA("Queen",tags);
    snd_K=NewDTObjectA("King",tags);

    for(i=0;i<8;i++)
		{
			sprintf(text, "%lc", (int)('a'+i) );
			snd_fielda[i]=NewDTObjectA(text,tags);
			sprintf(text, "%lc", (int)('1'+i) );
			snd_field1[i]=NewDTObjectA(text,tags);
		}
		
		CurrentDir(oldlock);
    UnLock(lock);
	}
}

void PlaySound(Object *snd,BOOL wait)
{
  if (SoundOn)
  {
    if (snd)
    {
      if (wait)
      {
        SetAttrs(snd,
         SDTA_SignalTask, FindTask(NULL),
         SDTA_SignalBit, snd_sigmask,
        TAG_END);
      }
      else
      {
        SetAttrs(snd,
         SDTA_SignalTask, NULL,
         SDTA_SignalBit, 0,
        TAG_END);
      }

      DoDTMethod(snd,0,0,DTM_TRIGGER,0,STM_PLAY,0);

      if (wait) Wait(snd_sigmask);
    }
  }
}

void MoveSound(char *move)
{
if(voice)
        {
        PlaySound(snd_move,0);
        Delay(5);
        if(!strcmp(move,"O-O")) PlaySound(snd_00,1);
        else if(!strcmp(move,"O-O-O")) PlaySound(snd_000,1);
        else
                {
                ULONG i=0;
                char c;
                while((c=*move))
                        {
                        if(c=='N') PlaySound(snd_N,1);
                        else if(c=='B') PlaySound(snd_B,1);
                        else if(c=='R') PlaySound(snd_R,1);
                        else if(c=='Q') PlaySound(snd_Q,1);
                        else if(c=='K') PlaySound(snd_K,1);
                        else if(c>='a'&&c<='h')
                                {
                                if(!i) PlaySound(snd_P,1);
                                PlaySound(snd_fielda[c-'a'],1);
                                }
                        else if(c>='1'&&c<='8') PlaySound(snd_field1[c-'1'],1);
                        else if(c=='x') PlaySound(snd_takes,1);
                        else if(c=='+') PlaySound(snd_check,1);
                        else if(c=='#') PlaySound(snd_mate,1);
                        move++;
                        i++;
                        }
                }
        }
else
        {
        if(strstr(move,"O-O")) PlaySound(snd_castle,1);
        else if(strstr(move,"x")) PlaySound(snd_hit,1);
        else
                {
                PlaySound(snd_move,0);
                Delay(5);
                }
        if(strstr(move,"+")) PlaySound(snd_check,1);
        }
}

void Ende(void)
{

  Object *snd;

  if ((snd = NewDTObject("PROGDIR:Sounds/End",
   DTA_GroupID, GID_SOUND,
   SDTA_SignalTask, FindTask(NULL),
   SDTA_SignalBit, snd_sigmask,
  TAG_END))) PlaySound(snd, 1);

  if (mui_app) MUI_DisposeObject(mui_app);
  ReleasePen(wbscreen->ViewPort.ColorMap,col_white);
  ReleasePen(wbscreen->ViewPort.ColorMap,col_black);
	
	FreeEdit();
  FreeBoard();
  FreePieces();
	
	if (SoundOn) FreeSound();
  if (PrgIcon) FreeDiskObject(PrgIcon);
  if (snd) DisposeDTObject(snd);
	close_catalog( );
}

BOOL InitGUI(void)
{
  mui_app = NewObject(MUI_Chess_Class->mcc_Class, 0, TAG_END);
  if (mui_app) return TRUE;
  return FALSE;
}

int main(int argc,char *argv[])
{
  ULONG signals=0;
  time_t now;
  Object *snd = NULL;

  if (OpenLibs())
  {
    if ((wbscreen = LockPubScreen(NULL)))
    {
      BOOL running = TRUE;
      if (wbscreen->Width >= 1024) {pieces_folder="PROGDIR:Pieces/1024"; pix_x=72; }
      else if (wbscreen->Width >= 800) {pieces_folder="PROGDIR:Pieces/800"; pix_x=56; }
      else { pieces_folder="PROGDIR:Pieces/640"; pix_x=45; }

			init_catalog();

      snd_signal = AllocSignal(-1);
      snd_sigmask = 1 << snd_signal;
      if ((snd = NewDTObject("PROGDIR:Sounds/Chess",
       DTA_GroupID, GID_SOUND,
       SDTA_SignalTask, FindTask(NULL),
       SDTA_SignalBit, snd_sigmask,
      TAG_END)))
      {
        DoDTMethod(snd, 0, 0, DTM_TRIGGER, 0, STM_PLAY, 0);
      }

      col_white=ObtainBestPen(wbscreen->ViewPort.ColorMap,0xFFFFFFFF,0xFFFFFFFF,0xB0B0B0B0,0);
      col_black=ObtainBestPen(wbscreen->ViewPort.ColorMap,0x90909090,0x48484848,0x00000000,0);
      LoadBoard("Default");
      LoadPieces("Default");
      LoadEdit();
      if (SoundOn) LoadSound();
      InitGUI();

      time(&now);
      srand((unsigned)now);

      flags=0;
      SET(flags,POST);
      Initialize();

      bookmode=BOOKPREFER;
      bookfirstlast=3;
      SET(flags,USEHASH);
      SET(flags,USENULL);
      SearchTime=5;

			DoMethod(mui_app, MUIM_Application_Load, "PROGDIR:AmiChess.prefs" );
      DoMethod(mui_app,MUIM_Chess_WinOpen);
      DoMethod(mui_app,MUIM_Chess_ShowBoard);

      if (snd)
      {
        Wait(snd_sigmask);
        DisposeDTObject(snd);
      }

      while (running)
      {
        if (DoMethod(mui_app, MUIM_Application_NewInput, &signals) ==
         MUIV_Application_ReturnID_Quit) running = FALSE;

        if (flags & AUTOPLAY)
        {
          DoMethod(mui_app, MUIM_Chess_SwapSides);
          signals = CheckSignal(signals);
        }
        else if (signals) signals = Wait(signals);
      }
      UnlockPubScreen(NULL, wbscreen);
    }
		DoMethod(mui_app, MUIM_Application_Save, "PROGDIR:AmiChess.prefs" );
    Ende();
  }
  CloseLibs();
  return 0;
}

void wbmain(struct WBStartup *w)
{
	main(0,(char **)w);
}

#if defined(__AMIGAOS4__)
Object * STDARGS VARARGS68K DoSuperNew(struct IClass *cl, Object *obj, ...)
{
  Object *rc;
  VA_LIST args;

  VA_START(args, obj);
  rc = (Object *)DoSuperMethod(cl, obj, OM_NEW, VA_ARG(args, ULONG), NULL);
  VA_END(args);

  return rc;
}
#endif

