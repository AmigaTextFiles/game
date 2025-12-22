//
#include <stdio.h>
#include <stdlib.h>
#include <intuition/intuition.h>
#include <clib/exec_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>
#include <graphics/gfxbase.h>
//#include <clib/asl_protos.h>
#include <exec/types.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <exec/exec.h>
#include <pragmas/intuition_pragmas.h>
#include <pragmas/graphics_pragmas.h>
//#include <proto/asl.h>
#include <workbench/startup.h>
#include <workbench/workbench.h>
#include <workbench/icon.h>
#include <proto/icon.h>
//#include <clib/timer_protos.h>
#include <clib/exec_protos.h>
#include <time.h>
//struct Device* TimerBase;
//static struct IORequest timereq;
#define WIDTH 320
#define HEIGHT 200
//#define DEPTH 8
//#define DEPTH 5
#define RBMWIDTH 320
#define RBMHEIGHT 200
//#define RBMDEPTH 8
//#define RBMDEPTH 5
#define ID_BNG   4
#define ID_BNG2   5
#define ID_BORDER 0

void __asm c2p_020(	register __a0 UBYTE *chunky, register __a1 PLANEPTR raster );

char __stdiowin[] = "CON:20/50/500/130/AWolfenstein";
char __stdiov37[] = "/AUTO/CLOSE/WAIT";
#include "include/wl_def.h"
struct IntuitionBase *IntuitionBase = NULL;
struct GfxBase       *GfxBase = NULL;
//struct AslBase *AslBase = NULL;
byte *gfxbuf = NULL, *gfxbuftmp = NULL;
struct ViewPort *vport;
struct RastPort *rport;
struct Window *window = NULL;
struct Screen *screen = NULL;
struct BitMap **myBitMaps;
struct Library *IconBase = NULL;
struct ScreenBuffer *sb[2];
byte fps=0;
extern void keyboard_handler(int code, int press);
extern boolean InternalKeyboard[NumCodes];
extern struct ExecBase *SysBase;

int myargc=0;
char *myargv[256];

unsigned char colourDepth = 8;

// 32 colour palette
unsigned short palette32[32] = { 0x0002, 0x0232, 0x0431, 0x0721, 0x0206, 0x0616, 0x000c, 0x061d, 0x0073, 0x0763,
									0x00c0, 0x05e2, 0x007a, 0x058b, 0x00cd, 0x05ee, 0x0d22, 0x0e95, 0x0fc8, 0x0ccc,
									0x0b1f, 0x0f1f, 0x0f5f, 0x0eaf, 0x0cf1, 0x0fe2, 0x0ef5, 0x0ef9, 0x0bff, 0x0eff, 0x0fed, 0x0fff};

// to convert from 256 to 32 colours
unsigned char colourTable[256] = { 0, 6, 10, 14, 3, 7, 16, 19, 9, 13, 11, 15, 17, 22, 26, 31, 
								29, 29, 19, 19, 19, 19, 19, 13, 13, 9, 9, 9, 9, 2, 1, 1,
								16, 16, 16, 16, 16, 16, 16, 3, 3, 3, 3, 3, 3, 3, 2, 2, 
								30, 30, 18, 17, 17, 16, 16, 16, 18, 17, 17, 17, 16, 16, 16, 3,
								30, 30, 27, 27, 26, 26, 25, 25, 25, 24, 24, 9, 9, 9, 9, 2,
								26, 26, 24, 24, 24, 11, 11, 9, 29, 27, 27, 27, 11, 11, 11, 10,
								10, 10, 10, 10, 10, 10, 10, 10, 10, 8, 8, 8, 8, 8, 8, 28,
								29, 28, 28, 15, 15, 15, 15, 14, 14, 14, 14, 12, 12, 12, 8, 1,
								15, 15, 14, 14, 14, 12, 12, 12, 29, 23, 23, 13, 13, 7, 7, 6,
								6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 4, 4, 4, 4, 4, 0,
								1, 25, 25, 25, 25, 25, 20, 20, 20, 7, 7, 5, 5, 5, 4, 4,
								31, 23, 23, 22, 22, 22, 21, 21, 21, 21, 20, 5, 5, 5, 5, 4,
								30, 30, 30, 30, 30, 18, 18, 18, 18, 18, 17, 17, 17, 17, 17, 17,
								17, 17, 9, 9, 9, 9, 9, 9, 9, 9, 2, 2, 2, 2, 2, 1,
								5, 12, 8, 0, 0, 2, 5, 5, 0, 1, 9, 9, 2, 1, 2, 29,
								28, 28, 15, 15, 14, 14, 14, 12, 12, 12, 12, 12, 12, 12, 12, 255};


int main (int argc, char *argv[])
{
    struct WBStartup *argmsg;
    struct WBArg *wb_arg;
    struct DiskObject *obj;
    char **toolarray, *s, c;
    int i, p;
    va_list argptr;
    FILE *con;    
	static char *flags[] = {
		"-fps"
	};
	/*
	printf("Wolf3d\nSelect chipset and press enter.\n1 - AGA\n2 - ECS\n");
	c = getchar();
	if(c == '1') colourDepth = 8;
	if(c == '2') colourDepth = 5;
	*/
	colourDepth = 5;
	
	
	SysBase = *(struct ExecBase **)4;
	if (!(SysBase->AttnFlags & AFF_68020))
	{
		printf("This version needs at least 68020!\n");
		return 0;
	}
	
	if(IconBase = (struct IconBase*) OpenLibrary("icon.library",0)) {
		/* parse icon tooltypes and convert them to argc/argv format */
		myargc = argc;
		if(argc == 0) {
			argmsg = (struct WBStartup *)argv;
			wb_arg = argmsg->sm_ArgList;
			if ((myargv[myargc] = malloc(strlen(wb_arg->wa_Name)+1)) != NULL)
			strcpy(myargv[myargc++],(char *)wb_arg->wa_Name);
		}
		if((obj = GetDiskObject (myargv[0])) != NULL) {
			toolarray = obj->do_ToolTypes;
			for(i=0; i < sizeof(flags)/sizeof(flags[0]); i++) {
				if (FindToolType(toolarray, &flags[i][1]) != NULL) {
					myargv[myargc++] = flags[i];
				}
			}
			FreeDiskObject (obj);
		}
		CloseLibrary(IconBase);
	}

	if(strcmp(myargv[1],flags[0])==0) fps=1;
	else if(argc != 0) if(strcmp(argv[1],"-fps")==0) fps = 1;

	return WolfMain(argc, argv);
}

void DisplayTextSplash(byte *text);

/*
==========================
=
= Quit
=
==========================
*/

void Quit(char *error)
{
	memptr screen = NULL;
   
	if (!error || !*error) {
		CA_CacheGrChunk(ORDERSCREEN);
		screen = grsegs[ORDERSCREEN];
		WriteConfig();
	} else if (error) {
		CA_CacheGrChunk(ERRORSCREEN);
		screen = grsegs[ERRORSCREEN];
	}
	
	ShutdownId();
	
	if (screen) {

	}
	
	if (error && *error) {
		fprintf(stderr, "Quit: %s\n", error);
		exit(EXIT_FAILURE);
 	}
	exit(EXIT_SUCCESS);
}

void VL_WaitVBL(int vbls)
{
	//long last = get_TimeCount() + vbls;
	//while (last > get_TimeCount()) ;*/
	return;
	while (vbls--) WaitTOF();
}

struct RastPort temprp;
struct RastPort temprp2;
struct MsgPort *ports[2];
long video_palette_changed=0;
ULONG table[256*3+1+1];
UBYTE toggle=0;



struct RastPort *MakeTempRP( struct RastPort *org )
{
	struct RastPort *rp;

	if( rp = AllocVec(sizeof(*rp), MEMF_ANY) )
	{
		memcpy( rp, org, sizeof(*rp) );
		rp->Layer = NULL;

	    rp->BitMap=AllocBitMap(org->BitMap->BytesPerRow*8,1,org->BitMap->Depth,0,org->BitMap);
//rp->BitMap=myBitMaps[1];
	if( !rp->BitMap )
		{
			FreeVec( rp );
			rp = NULL;
		}
	}

	return rp;
}



void tBitMap()
{
	toggle^=1;
	temprp2.BitMap=myBitMaps[toggle];
}


void VW_UpdateScreen2()
{
	if (video_palette_changed > 0) video_palette_changed--;/* keep it set for 2 frames for doublebuffering */
	else if (video_palette_changed != 0) video_palette_changed=1;
	
	// update the play screen
	c2p_020(gfxbuf, myBitMaps[0]->Planes[0]);
}

void VW_UpdateScreen()
{
	static struct RastPort *trp;
	int xx, yy;
	FILE *file = NULL;

	if (video_palette_changed > 0) video_palette_changed--;/* keep it set for 2 frames for doublebuffering */
	else if (video_palette_changed != 0) video_palette_changed=1;
	
	
	//Forbid();
	memcpy(gfxbuftmp, gfxbuf, 64000);
	c2p_020(gfxbuftmp, myBitMaps[0]->Planes[0]);
	//Permit();
	

	// remove double buffering for now

	//while(!ChangeScreenBuffer(screen,sb[toggle])) WaitTOF();
	//tBitMap();
}

/*
=======================
=
= VL_Startup
=
=======================
*/
VOID freePlanes(struct BitMap *bitMap, LONG depth, LONG width, LONG height)
{
	SHORT plane_num;

	if(bitMap->Planes[0]) FreeRaster(bitMap->Planes[0], width * 8, height * 8);
	/*
	for (plane_num = 0; plane_num < depth; plane_num++)
	{
		if(NULL != bitMap->Planes[plane_num]) FreeRaster(bitMap->Planes[plane_num], width, height);
	}*/
}

LONG setupPlanes(struct BitMap *bitMap, LONG depth, LONG width, LONG height)
{
	SHORT plane_num;
	unsigned int planesize;
	PLANEPTR planeptr;

	// contiguous block of memory

	planesize = (width / 8) * height;
	planeptr = AllocRaster(width * 8, height * 8);
	if(!planeptr) return 0;

	bitMap->Planes[0] = planeptr;
	bitMap->Planes[1] = planeptr + planesize;
	bitMap->Planes[2] = planeptr + planesize*2;
	bitMap->Planes[3] = planeptr + planesize*3;
	bitMap->Planes[4] = planeptr + planesize*4;
	bitMap->Planes[5] = planeptr + planesize*5;
	bitMap->Planes[6] = planeptr + planesize*6;
	bitMap->Planes[7] = planeptr + planesize*7;

	/*
	for (plane_num = 0; plane_num < depth; plane_num++)
	{
		if (NULL != (bitMap->Planes[plane_num]=(PLANEPTR)AllocRaster(width,height)))
			BltClear(bitMap->Planes[plane_num],(width/8)*height,1);
		else
		{
			freePlanes(bitMap, depth, width, height);
			return(0);
		}
	}*/
	return(TRUE);
}

struct BitMap **setupBitMaps(LONG depth, LONG width, LONG height)
{
	static struct BitMap *myBitMaps[3];
	/*
	myBitMaps[0] = (struct BitMap *) AllocMem((LONG)sizeof(struct BitMap), MEMF_CHIP|MEMF_CLEAR);
	InitBitMap(myBitMaps[0], depth, width, height);
	setupPlanes(myBitMaps[0], depth, width, height);
	
	myBitMaps[1] = (struct BitMap *) AllocMem((LONG)sizeof(struct BitMap), MEMF_CHIP|MEMF_CLEAR);
	InitBitMap(myBitMaps[1], depth, width, height);
	setupPlanes(myBitMaps[1], depth, width, height);
	*/
	
	if (NULL != (myBitMaps[0] = (struct BitMap *) AllocMem((LONG)sizeof(struct BitMap), MEMF_CHIP|MEMF_CLEAR))) {
		if (NULL != (myBitMaps[1]=(struct BitMap*)AllocMem((LONG)sizeof(struct BitMap), MEMF_CHIP|MEMF_CLEAR))) {
			if (NULL != (myBitMaps[2]=(struct BitMap*)AllocMem((LONG)sizeof(struct BitMap), MEMF_CHIP|MEMF_CLEAR))) {
				InitBitMap(myBitMaps[0], depth, width, height);
				InitBitMap(myBitMaps[1], depth, width, height);
				InitBitMap(myBitMaps[2], depth, width, height);
				if (0 != setupPlanes(myBitMaps[0], depth, width, height)) {
					if (0 != setupPlanes(myBitMaps[1], depth, width, height)) {
						if (0 != setupPlanes(myBitMaps[2], depth, width, height)) return(myBitMaps);
						freePlanes(myBitMaps[1], depth, width, height);
					}
					freePlanes(myBitMaps[0], depth, width, height);
				}
				FreeMem(myBitMaps[2], (LONG)sizeof(struct BitMap));
			}
			FreeMem(myBitMaps[1], (LONG)sizeof(struct BitMap));
		}
		FreeMem(myBitMaps[0], (LONG)sizeof(struct BitMap));
	}
	
	return(NULL);
}

VOID freeBitMaps(struct BitMap **myBitMaps, LONG depth, LONG width, LONG height)
{
	freePlanes(myBitMaps[0], depth, width, height);
	freePlanes(myBitMaps[1], depth, width, height);
	freePlanes(myBitMaps[2], depth, width, height);
	FreeMem(myBitMaps[0], (LONG)sizeof(struct BitMap));
	FreeMem(myBitMaps[1], (LONG)sizeof(struct BitMap));
	FreeMem(myBitMaps[2], (LONG)sizeof(struct BitMap));
}

void FreeTempRP( struct RastPort *rp )
{
	if( rp )
	{
		if( rp->BitMap )	{
			//if( rev3 )
         //    FreeBitMap( rp->BitMap );
			//else myFreeBitMap( rp->BitMap );
		}

		FreeVec( rp );
	}
}

/*
struct RastPort *MakeTempRP( struct RastPort *org )
{
	struct RastPort *rp;

	if( rp = AllocVec(sizeof(*rp), MEMF_ANY) )
	{
		memcpy( rp, org, sizeof(*rp) );
		rp->Layer = NULL;

	    rp->BitMap=AllocBitMap(org->BitMap->BytesPerRow*8,1,org->BitMap->Depth,0,org->BitMap);
//rp->BitMap=myBitMaps[1];
	if( !rp->BitMap )
		{
			FreeVec( rp );
			rp = NULL;
		}
	}

	return rp;
}
*/
static UWORD __chip emptypointer[] = {
  0x0000, 0x0000,	/* reserved, must be NULL */
  0x0000, 0x0000, 	/* 1 row of image data */
  0x0000, 0x0000	/* reserved, must be NULL */
};
static struct ScreenModeRequester *video_smr = NULL;
int mode = 0;
ULONG propertymask;

void VL_Startup()
{
	vwidth = WIDTH;
	vstride = WIDTH;
	vheight = HEIGHT;

	/* Open intuition.library */
  
	if((IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library",0)) == NULL) {
		printf("No intution library\n");
	//	  closeAll();
	}

	/* Open graphics.library */
	if((GfxBase = (struct GfxBase *) OpenLibrary("graphics.library", 0)) == NULL) {
		printf("No graphics library\n");
	//	  closeAll();
	}

	

	mode = BestModeID (BIDTAG_NominalWidth, 320,
                           BIDTAG_NominalHeight, 200,
                           BIDTAG_Depth, colourDepth,
                           BIDTAG_DIPFMustNotHave, propertymask,
                           TAG_DONE);

	if(NULL!=(myBitMaps=setupBitMaps(colourDepth, 320, 200))) {
		if (screen = OpenScreenTags( NULL,
		    //    SA_Title, "AWolf3D",
			SA_Width, WIDTH,
			SA_Height, HEIGHT,
			SA_Depth, colourDepth,
			SA_DisplayID, mode,
            SA_Quiet, TRUE,
			SA_Type, CUSTOMSCREEN|CUSTOMBITMAP,
		    SA_BitMap,myBitMaps[0],
			TAG_DONE)) 
		{
			vport = &screen->ViewPort;
			sb[0] = AllocScreenBuffer(screen, myBitMaps[0],0);
			sb[1] = AllocScreenBuffer(screen, myBitMaps[1],0);
			/* Open window */

			if(window = OpenWindowTags( NULL,
			//	WA_Title, "AWolf3D",
				WA_CloseGadget, FALSE,
				WA_DepthGadget, FALSE,
				WA_DragBar, FALSE,
				WA_SizeGadget, FALSE,
				WA_Gadgets, FALSE,
                WA_Borderless, TRUE,
                WA_NoCareRefresh, TRUE,
                WA_SimpleRefresh, TRUE,
                WA_RMBTrap, TRUE,
				WA_Activate, TRUE,
				WA_IDCMP, IDCMP_CLOSEWINDOW|IDCMP_MOUSEBUTTONS|IDCMP_RAWKEY,
				WA_Width, WIDTH,/*WIDTH,   */
				WA_Height, HEIGHT,/* HEIGHT,    */
				WA_CustomScreen, screen,
				/*WA_NoCareRefresh, TRUE, */
				TAG_DONE) ) {
					rport = window->RPort;
					gfxbuf= (byte*)AllocMem(sizeof(byte)*vwidth*vheight, MEMF_FAST);
					if(!gfxbuf) {
						printf("Oh no! Chip memory!\n");
						gfxbuf = (byte*)AllocMem(sizeof(byte)*vwidth*vheight, 0L);
					}
					gfxbuftmp= (byte*)AllocMem(sizeof(byte)*vwidth*vheight, MEMF_FAST);
					if(!gfxbuftmp) {
						printf("Oh no! Chip memory!\n");
						gfxbuftmp = (byte*)AllocMem(sizeof(byte)*vwidth*vheight, 0L);
					}
				}
			else printf("Could not open window\n");
		}
		else {
			printf("Unable to open screen\n");
			Quit(0);
		}
	}
	else printf("bitmaps setup\n");

	//OpenDevice("timer.device", 0 ,&timereq, 0);
//	TimerBase = timereq.io_Device;	
	//InitRastPort(&temprp);
	//temprp.Layer=0;
	//temprp.BitMap=myBitMaps[2];
	//InitRastPort(&temprp2);
	//temprp2.Layer=0;
	//temprp2.BitMap=myBitMaps[toggle^1];
	SetPointer(window,emptypointer,1,16,0,0);
	
	if(colourDepth == 5) LoadRGB4(vport, &palette32, 32);
	if(colourDepth == 8) VL_SetPalette(gamepal);
}

/*
=======================
=
= VL_Shutdown
=
=======================
*/

void VL_Shutdown()
{
	if(gfxbuf) {
		FreeMem(gfxbuf, sizeof(byte)*vwidth*vheight);
		//free(gfxbuf);
		gfxbuf = NULL;
	}
	if(gfxbuftmp) {
		FreeMem(gfxbuftmp, sizeof(byte)*vwidth*vheight);
		//free(gfxbuf);
		gfxbuftmp = NULL;
	}

	if (sb[0]) FreeScreenBuffer(screen,sb[0]);
    if (sb[1]) FreeScreenBuffer(screen,sb[1]);
    if (window) ClearPointer(window);
    if (window) CloseWindow(window);
    if (screen) CloseScreen(screen);
    if (myBitMaps) freeBitMaps(myBitMaps, 8/*RBMDEPTH*/,RBMWIDTH,RBMHEIGHT);
	// CloseLibrary(AslBase);
	if (GfxBase) CloseLibrary(GfxBase);
    if (IntuitionBase) CloseLibrary(IntuitionBase);
}

/* ======================================================================== */

/*
=================
=
= VL_SetPalette
=
=================
*/

static void setPalette(struct ViewPort *vport, const byte *palette)
{
	UWORD i;
	table[0]=(256<<16)|0;

	if(colourDepth == 8) {
		for (i = 0; i < 256; i++) {
			table[i*3+1]=(ULONG)palette[i*3+0]<<26;
			table[i*3+2]=(ULONG)palette[i*3+1]<<26;
			table[i*3+3]=(ULONG)palette[i*3+2]<<26;
		}      
    
		LoadRGB32(vport, table);
		video_palette_changed=-1;
	}
}

void VL_SetPalette(const byte *palette)
{
	if(colourDepth == 8) setPalette(vport, palette);
}

/*
=================
=
= VL_GetPalette
=
=================
*/
static void getPalette(struct ViewPort *vport, byte *palette)
{
    UWORD i=0;
    ULONG color[3*256];
	
	if(colourDepth == 8) {
		GetRGB32(vport->ColorMap,0,256L,color);
    
		for (i = 0; i < 256; i++)
		{
    		palette[i*3+0]=color[i*3+0]>>26;
    		palette[i*3+1]=color[i*3+1]>>26;
    		palette[i*3+2]=color[i*3+2]>>26;
		}
	}
}

void VL_GetPalette(byte *palette)
{
    if(colourDepth == 8) getPalette(vport, palette);
}

static int xlate[0x68] = {
  sc_None, sc_1, sc_2, sc_3, sc_4, sc_5, sc_6, sc_7,
  sc_8, sc_9, sc_0, sc_None, sc_None, sc_None, 0, sc_0,
  sc_Q, sc_W, sc_E, sc_R, sc_T, sc_Y, sc_U, sc_I,
  sc_O, sc_P, sc_F11, sc_F12, 0, sc_0, sc_2, sc_3,
  sc_A, sc_S, sc_D, sc_F, sc_G, sc_H, sc_J, sc_K,
  sc_L, sc_None, sc_None, sc_Enter, 0, sc_4, sc_5, sc_6,
  sc_RShift, sc_Z, sc_X, sc_C, sc_V, sc_B, sc_N, sc_M,
  sc_None, sc_None, sc_None, 0, sc_None, sc_7, sc_8, sc_9,
  sc_Space, sc_BackSpace, sc_Tab, sc_Enter, sc_Enter, sc_Escape, sc_F11,
  0, 0, 0, sc_None, 0, sc_UpArrow, sc_DownArrow, sc_RightArrow, sc_LeftArrow,
  sc_F1, sc_F2, sc_F3, sc_F4, sc_F5, sc_F6, sc_F7, sc_F8,
  sc_F9, sc_F10, sc_None, sc_None, sc_None, sc_None, sc_None, 0xe1,
  sc_RShift, sc_RShift, 0, sc_Control, sc_Alt, sc_Alt, 0, sc_Control
};
static int XKeysymToScancode(unsigned int keysym)
{

    if (keysym<0x68) return xlate[keysym];
    else
    return sc_None;
}

static int JoybuttonToScancode(unsigned int keysym)
{
	switch (keysym) {
		case 11: // Start
			return sc_Enter;
		case 10: // Select
			return sc_Escape;
		case 0:	// Triangle
			return sc_Space;
		case 3: // Square
			return sc_BackSpace;
		case 2: // Cross
			return sc_Control;
		
		case 8:	// up
			return sc_UpArrow;
		case 6: // down
			return sc_DownArrow;
		case 7: // left
			return sc_LeftArrow;
		case 9: // right
			return sc_RightArrow;
			
		case 1: // circle
			return sc_Y;
		
		case 4:
			return sc_RShift;
		case 5:
			return sc_Alt;
		case 13:	// Hold?
			return 0xE1;
		default:
			return sc_None;
	}
}

void INL_Update()
{       
    ULONG class;
    UWORD code;
	struct IntuiMessage *msg;
	while ((msg = (struct IntuiMessage *)GetMsg (window->UserPort)) != NULL) 
	{
    	class = msg->Class;
      	code = msg->Code;
        if (class==IDCMP_RAWKEY)
        if ((code & 0x80)!=0)
        {
        	code &= ~0x80;
            keyboard_handler(XKeysymToScancode(code),0);
        }
        else
        {
            keyboard_handler(XKeysymToScancode(code),1);
        }
        ReplyMsg((struct Message*)msg);
    }

	/* ctrl-z for iconify window? */
}

void IN_GetMouseDelta(int *dx, int *dy)
{
    int x, y;
    ULONG class;
    UWORD code;
	struct IntuiMessage *msg;
	   while ((msg = (struct IntuiMessage *)GetMsg (window->UserPort)) != NULL) {
      class = msg->Class;
      code = msg->Code;
      x = msg->MouseX;
      y = msg->MouseY;
      ReplyMsg((struct Message*)msg);
      }
	if (dx)
		*dx = x;
	if (dy)
		*dy = y;
}

byte IN_MouseButtons()
{
/*	  return SDL_GetMouseState(NULL, NULL);*/
}
