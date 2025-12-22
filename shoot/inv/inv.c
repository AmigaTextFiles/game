
/* written by yair goldfinger (amigo)
   yairgo@libra.tau.ac.il
*/



#define BUserStuff SHORT
#include <intuition/intuition.h>
/* Include this file since you are using sprites: */
#include <graphics/sprite.h>
#include <exec/ports.h>
#include <exec/types.h>
#include <proto/all.h>
#include <graphics/gels.h>
#include <graphics/collide.h>
#include <stdlib.h>
#include <exec/memory.h>
#include <libraries/dos.h>
#include <stdio.h>

#define MAXBOBS 8

/* They will move one pixel each time: */
#define SPEED 4
VOID quit(int return_code);
VOID bordercheck(struct VSprite *vs,LONG borderflags);
VOID freeBob(struct Bob *bob);
VOID gotit(struct VSprite *gelA,struct VSprite *gelB);
VOID handle_shoot(struct Bob *shoot[],struct Window *win);
VOID bobDrawGlist(struct Window *win);
struct Bob *makeBob(SHORT wordwidth,SHORT lineheight,SHORT x,
                    SHORT y, WORD *imagedata,WORD memask,
                    WORD hitmask,SHORT id);
VOID process_window(struct Window *win , struct Bob *ship_bob,
                    struct Bob *enemy_bobs[] );

struct VSprite *makeVSprite(WORD y , WORD x , WORD flags, WORD width,
                            WORD height, WORD depth , WORD memask,
                            WORD hitmask, WORD *imagedata ,WORD *sprcolors);
struct GelsInfo *setupGelSys(struct RastPort *rPort, BYTE reserved);
VOID cleanupGelSys(struct GelsInfo *gInfo, struct RastPort *rPort);
VOID do_bobs(struct Window *win);
VOID freeVSprite(struct VSprite *vsprite);
VOID main();








/* Declare the functions we are going to use: */

struct IntuitionBase *IntuitionBase = NULL;

struct GfxBase *GfxBase = NULL;

int return_code;
/* Declare and initialize your NewWindow structure: */
struct NewWindow myNewWindow=
{
  20,            /* LeftEdge    x position of the window. */
  25,            /* TopEdge     y positio of the window. */
  320,           /* Width       320 pixels wide. */
  100,           /* Height      100 lines high. */
  0,             /* DetailPen   Text should be drawn with colour reg. 0 */
  1,             /* BlockPen    Blocks should be drawn with colour reg. 1 */
  CLOSEWINDOW|   /* IDCMPFlags  The window will give us a message if the */
  RAWKEY,        /*             user has selected the Close window gad, */
                 /*             or if the user has pressed a key. */
  SMART_REFRESH| /* Flags       Intuition should refresh the window. */
  WINDOWCLOSE|   /*             Close Gadget. */
  WINDOWDRAG|    /*             Drag gadget. */
  WINDOWDEPTH|   /*             Depth arrange Gadgets. */
  ACTIVATE,      /*             The window should be Active when opened. */
  NULL,          /* FirstGadget No Custom gadgets. */
  NULL,          /* CheckMark   Use Intuition's default CheckMark. */
  "space v-0.3 by Yair Goldfinger",  /* Title       Title of the window. */
  NULL,          /* Screen      Connected to the Workbench Screen. */
  NULL,          /* BitMap      No Custom BitMap. */
  80,            /* MinWidth    We will not allow the window to become */
  30,            /* MinHeight   smaller than 80 x 30, and not bigger */
  300,           /* MaxWidth    than 300 x 200. */
  200,           /* MaxHeight */
  WBENCHSCREEN   /* Type        Connected to the Workbench Screen. */
};






/********************************************************/
/* 1. Declare and initialize some sprite graphics data: */
/********************************************************/
/* Sprite data for a ship: */
/* (6 frames, 4 different images: 1 2 3 4 3 2) */
UWORD chip good_ship_data[] =
   {
  0x00F0, 0x0000,
   0x00F0, 0x0000,
   0x03FC, 0x0000,
   0x03FC, 0x0000,
   0x0000, 0x0000,
   0x0000, 0x0000,
   0x0000, 0x0000,
   0x0000, 0x0000,
   /**/
   0x0000, 0x0000,
   0x0000, 0x0000,
   0x03FC, 0x0000,
   0x03FC, 0x0000,
   0xFFFF, 0xF000,
   0xFFFF, 0xF000,
   0xFFFF, 0xF000,
   0xFFFF, 0xF000,
   };


/* for the vsprites */
UWORD chip ship_data[12][72]=
{
  {
  0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x000F, 0x783E, 0x0000,
   0x03EF, 0x7C07, 0x0000,
   0x03EF, 0x7FFF, 0x0000,
   0x006F, 0x7FFE, 0x0000,
   0x0000, 0x7FF8, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x07FF, 0xFE00, 0x0000,
   0x0006, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0xC019, 0xE006, 0x0000,
   0xC7F0, 0x87C1, 0x8000,
   0xFC10, 0x83F8, 0x8000,
   0xC410, 0x8000, 0x8000,
   0xC790, 0x8001, 0x8000,
   0x007F, 0x8006, 0x0000,
   0x0010, 0x7FF8, 0x0000,
   0x0060, 0x0041, 0x8000,
   0x03FF, 0xFFFE, 0x0000, 
  },
  {
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x000F, 0x783E, 0x0000,
   0x03EF, 0x7C07, 0x0000,
   0x03EF, 0x7FFF, 0x0000,
   0x006F, 0x7FFE, 0x0000,
   0x0000, 0x7FF8, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x03FF, 0xFC00, 0x0000,
   0x0006, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x0019, 0xE006, 0x0000,
   0xC7F0, 0x87C1, 0x8000,
   0xFC10, 0x83F8, 0x8000,
   0xC410, 0x8000, 0x8000,
   0x0790, 0x8001, 0x8000,
   0x007F, 0x8006, 0x0000,
   0x0010, 0x7FF8, 0x0000,
   0x0060, 0x0041, 0x8000,
   0x03FF, 0xFFFE, 0x0000,
  },
  {
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x000F, 0x783E, 0x0000,
   0x03EF, 0x7C07, 0x0000,
   0x03EF, 0x7FFF, 0x0000,
   0x006F, 0x7FFE, 0x0000,
   0x0000, 0x7FF8, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x01FF, 0xF800, 0x0000,
   0x0006, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0xC019, 0xE006, 0x0000,
   0xC7F0, 0x87C1, 0x8000,
   0xFC10, 0x83F8, 0x8000,
   0xC410, 0x8000, 0x8000,
   0xC790, 0x8001, 0x8000,
   0x007F, 0x8006, 0x0000,
   0x0010, 0x7FF8, 0x0000,
   0x0060, 0x0041, 0x8000,
   0x03FF, 0xFFFE, 0x0000,
 
  },
  {
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x000F, 0x783E, 0x0000,
   0x03EF, 0x7C07, 0x0000,
   0x03EF, 0x7FFF, 0x0000,
   0x006F, 0x7FFE, 0x0000,
   0x0000, 0x7FF8, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x00FF, 0xF000, 0x0000,
   0x0006, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x0019, 0xE006, 0x0000,
   0xC7F0, 0x87C1, 0x8000,
   0xFC10, 0x83F8, 0x8000,
   0xC410, 0x8000, 0x8000,
   0x0790, 0x8001, 0x8000,
   0x007F, 0x8006, 0x0000,
   0x0010, 0x7FF8, 0x0000,
   0x0060, 0x0041, 0x8000,
   0x03FF, 0xFFFE, 0x0000,

   },
  {   
    0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x000F, 0x783E, 0x0000,
   0x03EF, 0x7C07, 0x0000,
   0x03EF, 0x7FFF, 0x0000,
   0x006F, 0x7FFE, 0x0000,
   0x0000, 0x7FF8, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x01FF, 0xF800, 0x0000,
   0x0006, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0xC019, 0xE006, 0x0000,
   0xC7F0, 0x87C1, 0x8000,
   0xFC10, 0x83F8, 0x8000,
   0xC410, 0x8000, 0x8000,
   0xC790, 0x8001, 0x8000,
   0x007F, 0x8006, 0x0000,
   0x0010, 0x7FF8, 0x0000,
   0x0060, 0x0041, 0x8000,
   0x03FF, 0xFFFE, 0x0000,

  },
  {
    0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x000F, 0x783E, 0x0000,
   0x03EF, 0x7C07, 0x0000,
   0x03EF, 0x7FFF, 0x0000,
   0x006F, 0x7FFE, 0x0000,
   0x0000, 0x7FF8, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x03FF, 0xFC00, 0x0000,
   0x0006, 0x0000, 0x0000,
   0x0006, 0x1FF8, 0x0000,
   0x0019, 0xE006, 0x0000,
   0xC7F0, 0x87C1, 0x8000,
   0xFC10, 0x83F8, 0x8000,
   0xC410, 0x8000, 0x8000,
   0x0790, 0x8001, 0x8000,
   0x007F, 0x8006, 0x0000,
   0x0010, 0x7FF8, 0x0000,
   0x0060, 0x0041, 0x8000,
   0x03FF, 0xFFFE, 0x0000,

  },
 {
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3E0F, 0x7800, 0x0000,
   0x701F, 0x7BE0, 0x0000,
   0x7FFF, 0x7BE0, 0x0000,
   0x3FFF, 0x7B00, 0x0000,
   0x0FFF, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x003F, 0xFFF0, 0x0000,
   0x0000, 0x3000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3003, 0xCC01, 0x8000,
   0xC1F0, 0x87F1, 0x8000,
   0x8FE0, 0x841F, 0x8000,
   0x8000, 0x8411, 0x8000,
   0xC000, 0x84F1, 0x8000,
   0x3000, 0xFF00, 0x0000,
   0x0FFF, 0x0400, 0x0000,
   0xC100, 0x0300, 0x0000,
   0x3FFF, 0xFFE0, 0x0000,
   },
  {
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3E0F, 0x7800, 0x0000,
   0x701F, 0x7BE0, 0x0000,
   0x7FFF, 0x7BE0, 0x0000,
   0x3FFF, 0x7B00, 0x0000,
   0x0FFF, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x001F, 0xFFE0, 0x0000,
   0x0000, 0x3000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3003, 0xCC00, 0x0000,
   0xC1F0, 0x87F1, 0x8000,
   0x8FE0, 0x841F, 0x8000,
   0x8000, 0x8411, 0x8000,
   0xC000, 0x84F0, 0x0000,
   0x3000, 0xFF00, 0x0000,
   0x0FFF, 0x0400, 0x0000,
   0xC100, 0x0300, 0x0000,
   0x3FFF, 0xFFE0, 0x0000,
   },
{
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x07FE, 0x1800, 0x0000,
   0x1F07, 0xBC00, 0x0000,
   0x380F, 0xBDF0, 0x0000,
   0x3FFF, 0xBDF0, 0x0000,
   0x1FFF, 0xBD80, 0x0000,
   0x07FF, 0x8000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x000F, 0xFFE0, 0x0000,
   0x0000, 0x3800, 0x0000,
   0x0FFE, 0x3800, 0x0000,
   0x3801, 0xE601, 0x8000,
   0xE0F8, 0x43F9, 0x8000,
   0xC7F0, 0x420F, 0x8000,
   0xC000, 0x4209, 0x8000,
   0xE000, 0x4279, 0x8000,
   0x3800, 0x7F80, 0x0000,
   0x0FFF, 0x8600, 0x0000,
   0xE180, 0x0380, 0x0000,
   0x3FFF, 0xFFF0, 0x0000,
   },
   {
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3E0F, 0x7800, 0x0000,
   0x701F, 0x7BE0, 0x0000,
   0x7FFF, 0x7BE0, 0x0000,
   0x3FFF, 0x7B00, 0x0000,
   0x0FFF, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x0007, 0xFF80, 0x0000,
   0x0000, 0x3000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3003, 0xCC00, 0x0000,
   0xC1F0, 0x87F1, 0x8000,
   0x8FE0, 0x841F, 0x8000,
   0x8000, 0x8411, 0x8000,
   0xC000, 0x84F0, 0x0000,
   0x3000, 0xFF00, 0x0000,
   0x0FFF, 0x0400, 0x0000,
   0xC100, 0x0300, 0x0000,
   0x3FFF, 0xFFE0, 0x0000,
   },
 {
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3E0F, 0x7800, 0x0000,
   0x701F, 0x7BE0, 0x0000,
   0x7FFF, 0x7BE0, 0x0000,
   0x3FFF, 0x7B00, 0x0000,
   0x0FFF, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x000F, 0xFFC0, 0x0000,
   0x0000, 0x3000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3003, 0xCC01, 0x8000,
   0xC1F0, 0x87F1, 0x8000,
   0x8FE0, 0x841F, 0x8000,
   0x8000, 0x8411, 0x8000,
   0xC000, 0x84F1, 0x8000,
   0x3000, 0xFF00, 0x0000,
   0x0FFF, 0x0400, 0x0000,
   0xC100, 0x0300, 0x0000,
   0x3FFF, 0xFFE0, 0x0000,
   },
   {
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3E0F, 0x7800, 0x0000,
   0x701F, 0x7BE0, 0x0000,
   0x7FFF, 0x7BE0, 0x0000,
   0x3FFF, 0x7B00, 0x0000,
   0x0FFF, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   0x0000, 0x0000, 0x0000,
   /**/
   0x001F, 0xFFE0, 0x0000,
   0x0000, 0x3000, 0x0000,
   0x0FFC, 0x3000, 0x0000,
   0x3003, 0xCC00, 0x0000,
   0xC1F0, 0x87F1, 0x8000,
   0x8FE0, 0x841F, 0x8000,
   0x8000, 0x8411, 0x8000,
   0xC000, 0x84F0, 0x0000,
   0x3000, 0xFF00, 0x0000,
   0x0FFF, 0x0400, 0x0000,
   0xC100, 0x0300, 0x0000,
   0x3FFF, 0xFFE0, 0x0000,
   },

};

WORD chip shoot_image[] = {
   0xF000,
   /**/
   0xF000, 
  };

/* 4. Declare a GelsInfo structure: */
struct GelsInfo *my_ginfo;
struct Window	   *win;
struct Bob  *enemy_bobs[ MAXBOBS ];
struct Bob *ship_bob;
VOID main()
{


return_code = RETURN_OK;

if (NULL == (GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",33L)))
	return_code = RETURN_FAIL;
else
	{
	if (NULL == (IntuitionBase =
			(struct IntuitionBase *)OpenLibrary("intuition.library",33L)))
		return_code = RETURN_FAIL;
	else
		{
		if (NULL == (win = OpenWindow(&myNewWindow)))
			return_code = RETURN_WARN;
		else
			{
			do_bobs(win);

			CloseWindow(win);
			}
		CloseLibrary(IntuitionBase);
		}
	CloseLibrary(GfxBase);
	}
exit(return_code);
}

VOID freeVSprite(struct VSprite *vsprite)
{
LONG	line_size;
LONG	plane_size;

line_size = (LONG)sizeof(WORD) * vsprite->Width;
plane_size = line_size * vsprite->Height;

FreeMem(vsprite->BorderLine, line_size);
FreeMem(vsprite->CollMask, plane_size);

FreeMem(vsprite, (LONG)sizeof(*vsprite));
}




VOID cleanupGelSys(struct GelsInfo *gInfo, struct RastPort *rPort)
{
rPort->GelsInfo = NULL;

FreeMem(gInfo->collHandler, (LONG)sizeof(struct collTable));
FreeMem(gInfo->lastColor, (LONG)sizeof(LONG) * 8);
FreeMem(gInfo->nextLine, (LONG)sizeof(WORD) * 8);
FreeMem(gInfo->gelHead, (LONG)sizeof(struct VSprite));
FreeMem(gInfo->gelTail, (LONG)sizeof(struct VSprite));
FreeMem(gInfo, (LONG)sizeof(*gInfo));
}








struct GelsInfo *setupGelSys(struct RastPort *rPort, BYTE reserved)
{
struct GelsInfo *gInfo;
struct VSprite  *vsHead;
struct VSprite  *vsTail;

if (NULL != (gInfo =
	(struct GelsInfo *)AllocMem((LONG)sizeof(struct GelsInfo), MEMF_CLEAR)))
	{
	if (NULL != (gInfo->nextLine =
		(WORD *)AllocMem((LONG)sizeof(WORD) * 8, MEMF_CLEAR)))
		{
		if (NULL != (gInfo->lastColor =
			(WORD **)AllocMem((LONG)sizeof(LONG) * 8, MEMF_CLEAR)))
			{
			if (NULL != (gInfo->collHandler =
				(struct collTable *)AllocMem((LONG)sizeof(struct collTable),
					MEMF_CLEAR)))
				{
				if (NULL != (vsHead = (struct VSprite *)AllocMem(
					(LONG)sizeof(struct VSprite), MEMF_CLEAR)))
					{
					if (NULL != (vsTail = (struct VSprite *)AllocMem(
						(LONG)sizeof(struct VSprite), MEMF_CLEAR)))
						{
						gInfo->sprRsrvd	  = reserved;
						gInfo->leftmost	  = 1;
						gInfo->rightmost  =
							(rPort->BitMap->BytesPerRow << 3) - 1;
						gInfo->topmost	  = 1;
						gInfo->bottommost = rPort->BitMap->Rows - 1;

						rPort->GelsInfo = gInfo;

						InitGels(vsHead, vsTail, gInfo);

						return(gInfo);
						}
					FreeMem(vsHead, (LONG)sizeof(*vsHead));
					}
				FreeMem(gInfo->collHandler, (LONG)sizeof(struct collTable));
				}
			FreeMem(gInfo->lastColor, (LONG)sizeof(LONG) * 8);
			}
		FreeMem(gInfo->nextLine, (LONG)sizeof(WORD) * 8);
		}
	FreeMem(gInfo, (LONG)sizeof(*gInfo));
	}
return(NULL);
}











struct VSprite *makeVSprite(WORD y , WORD x , WORD flags, WORD width,
                            WORD height, WORD depth , WORD memask,
                            WORD hitmask, WORD *imagedata ,WORD *sprcolors )
{
struct VSprite *vsprite;
LONG			line_size;
LONG			plane_size;

line_size = (LONG)sizeof(WORD) * width;
plane_size = line_size * height;

if (NULL != (vsprite =
	(struct VSprite *)AllocMem((LONG)sizeof(struct VSprite), MEMF_CLEAR)))
	{
	if (NULL != (vsprite->BorderLine =
		(WORD *)AllocMem(line_size, MEMF_CHIP)))
		{
		if (NULL != (vsprite->CollMask =
			(WORD *)AllocMem(plane_size, MEMF_CHIP)))
			{
			vsprite->Y			= y;
			vsprite->X			= x;
			vsprite->Flags		= flags;
			vsprite->Width		= width;
			vsprite->Depth		= depth;
			vsprite->Height		= height;
			vsprite->MeMask		= memask;
			vsprite->HitMask	= hitmask;
			vsprite->ImageData	= imagedata;
			vsprite->SprColors	= sprcolors;
			vsprite->PlanePick	= 0x00;
			vsprite->PlaneOnOff	= 0x00;

			InitMasks(vsprite);
			return(vsprite);
			}
		FreeMem(vsprite->BorderLine, line_size);
		}
	FreeMem(vsprite, (LONG)sizeof(*vsprite));
	}
return(NULL);
}


VOID process_window(struct Window *win , struct Bob *ship_bob,
                    struct Bob *enemy_bobs[] )

{
WORD x = ship_bob->BobVSprite->X ;


/* Direction of the sprite: */
SHORT addit = 0;
WORD x_direction = 0;
UWORD frame = 0; /* Frame 0 */
struct Bob *shoot[10] ;
SHORT borderhit = 0;
SHORT time = 0;
short int beginshoot = 0;
ULONG class; /* IDCMP */
USHORT code; /* Code */
UBYTE loop;
WORD vx_direction = SPEED; 
struct IntuiMessage *my_message;
for(loop = 0;loop<10;loop++)
	shoot[loop] = NULL;
FOREVER
	{
	
    while(my_message = (struct intuiMessage *)GetMsg(win->UserPort))
		{
		class = my_message->Class;
 		code  = my_message->Code;

		switch( class )
			{
			case CLOSEWINDOW:     /* Quit! */
				return;
				break; 

			case RAWKEY:          /* A key was pressed! */
                                 /* Check which key was pressed: */
				switch( code )
					{
					   /* Up Arrow: */
               				case 0x4C:       break; /* Pressed */
               				case 0x4C+0x80:
                                        beginshoot = 1;
                                        shoot[time] =makeBob(1,1,x+7 ,89,shoot_image,8,4,time);
					AddBob(shoot[time],win->RPort);
					bobDrawGlist(win);
					time = (time+1)%10; 
						break; /* Released */
					/* Right Arrow: */
					case 0x4E:      x_direction = 2; break; /* Pressed */
					case 0x4E+0x80: x_direction = 0; break; /* Released */

					/* Left Arrow: */
					case 0x4F:      x_direction = -2; break; /* Pressed */
					case 0x4F+0x80: x_direction = 0;  break; /* Released */
					}
 					break;
			
				
			}
			ReplyMsg((struct Message *)my_message);
		}
if (beginshoot)
	handle_shoot(shoot,win);
DoCollision(win->RPort);     
    /* Change the x/y position: */
	x = x +  x_direction ;
    
 

    			
    /* Check that the sprite does not move outside the screen: */
if( x > win->Width - 21)
	x = win->Width - 21;   
     
if(x< 1)
	x = 1;
    /* Move the sprite: */
    
ship_bob->BobVSprite->X = x;


    /* Change frame: */
    frame++;
      
    /* 6 frames: */
    if( frame > 5 )
      frame = 0;
    
	for( loop = 0; loop < MAXBOBS; loop++ )
		{
		if(enemy_bobs[ loop ])
			{

                        /* Change the x position of the VSprite: */
			if (enemy_bobs[loop]->BobVSprite->Y >=80)
				quit(0);
			enemy_bobs[ loop ]->BobVSprite->X += vx_direction;
       		 	/* Check that the sprite does not move outside the screen: */
			if(enemy_bobs[ loop ]->BobVSprite->X >=win->Width-36 )
				borderhit = 1;
			else
				if(enemy_bobs[ loop ]->BobVSprite->X <= 2)
					borderhit = 1;
				
			


        		
         		/* Change the image of the VSprite: */
         		enemy_bobs[ loop ]->BobVSprite->ImageData = ship_data[ frame + addit];
			InitMasks(enemy_bobs[ loop ]->BobVSprite);
			}
		}  
    bobDrawGlist(win);
    if(borderhit)
		 {
		 for( loop = 0; loop < MAXBOBS; loop++ )
			if(enemy_bobs[ loop ])
				enemy_bobs[ loop ]->BobVSprite->Y +=4;

		 vx_direction = -vx_direction;
	         borderhit = 0;
	         if (vx_direction > 0)
			 addit = 0;
		 else
			 addit = 6;
		 }	 
	}
}







struct Bob *makeBob(SHORT wordwidth,SHORT lineheight,SHORT x,
                    SHORT y, WORD *imagedata,WORD memask,
                    WORD hitmask,SHORT id )
{
struct Bob	   *bob;
struct VSprite	   *vsprite;
LONG	rassize;
WORD flags = SAVEBACK | OVERLAY;
rassize = (LONG)sizeof(UWORD) * wordwidth * lineheight * 2 ;

if (NULL != (bob =
	(struct Bob *)AllocMem((LONG)sizeof(struct Bob), MEMF_CLEAR)))
	{
	if (NULL != (bob->SaveBuffer = (WORD *)AllocMem(rassize, MEMF_CHIP)))
		{
		if ((vsprite =
		makeVSprite(y,x,flags,wordwidth,lineheight,2,memask,hitmask,imagedata,NULL)) != NULL)
			{
			vsprite->PlanePick = 3;
			vsprite->PlaneOnOff = 0;

			vsprite->VSBob	 = bob;
			bob->BobVSprite	 = vsprite;
			bob->ImageShadow = vsprite->CollMask;
			bob->Flags	 = 0;
			bob->Before	 = NULL;
			bob->After	 = NULL;
			bob->BobComp	 = NULL;
			bob->DBuffer	 = NULL;
			bob->BUserExt = id;
			return(bob);
			}

		freeVSprite(vsprite);
		}
	FreeMem(bob, (LONG)sizeof(*bob));
	}
return(NULL);
}
VOID bobDrawGlist(struct Window *win)
{
SortGList(win->RPort);
DrawGList(win->RPort,ViewPortAddress(win));
WaitTOF();
}

VOID handle_shoot(struct Bob *shoot[],struct Window *win)
{
int i;
for(i = 0;i<10;i++)
	{
	if (shoot[i] != NULL )
		{
		if (shoot[i]->BobVSprite->Y <= 12) 
			{
			RemBob(shoot[i]);
			/*freeBob(shoot[i]);*/
			shoot[i] = NULL;
			}
		else 
			shoot[i]->BobVSprite->Y -=3;
		}
	}
/*bobDrawGlist(win);*/

}



VOID gotit(struct VSprite *gelA,struct VSprite *gelB)
{

struct Bob *bb;


bb = gelA->VSBob;
if (gelA->Width == 3)
	enemy_bobs[bb->BUserExt] = NULL;
RemBob(bb);
/*freeBob(bb);*/
bb = gelB->VSBob;
if (gelB->Width == 3)
	enemy_bobs[bb->BUserExt] = NULL;
RemBob(bb);
/*freeBob(bb);*/
bobDrawGlist(win);

}

VOID freeBob(struct Bob *bob)
{
LONG rassize;

rassize = (LONG)sizeof(UWORD) * bob->BobVSprite->Width * bob->BobVSprite->Height * 2;

FreeMem(bob->SaveBuffer,rassize);
freeVSprite(bob->BobVSprite);
FreeMem(bob,(LONG)sizeof(*bob));
}


VOID do_bobs(struct Window *win)
{ 





SHORT loop, i;
SHORT vx = 0,vy =0;     /* X and Y position.                */

if (NULL == (my_ginfo = setupGelSys(win->RPort, 0xfc)))
	return_code = RETURN_WARN;
else
	{
	if(NULL == (ship_bob = makeBob(2,8,20,90,good_ship_data,0,0,0)))
		return_code = RETURN_WARN;
	else
		{
		AddBob(ship_bob,win->RPort);
		for(loop = 0; loop < MAXBOBS ; loop++)
			{
 			if (NULL == (enemy_bobs[ loop ]=makeBob(3,12,20 * vx+4,20 * vy + 13,ship_data[0],4,8,loop )))
				{
				return_code = RETURN_WARN;
				break;
				}
			else
				{
				AddBob(enemy_bobs[ loop ], win->RPort);
				
				vx = vx + 2;				
				if( vx > 7)
					{
					vx = 0;
					vy++;
					}		
				}
			}
		if(loop >= MAXBOBS)
			{
			bobDrawGlist(win);
			SetCollision(2,gotit,win->RPort->GelsInfo);
			SetCollision(3,gotit,win->RPort->GelsInfo);
			process_window(win,ship_bob,enemy_bobs);
			}		
		for(i = 0; i <loop;i++)
			{
			if(enemy_bobs[i])
				{				
				RemBob(enemy_bobs[i]);
				/*freeBob(enemy_bobs[i]);*/
				}
			}
		if(ship_bob)
			{
			RemBob(ship_bob);
			/*freeBob(ship_bob);*/
			}
		bobDrawGlist(win);
		}			
	cleanupGelSys(my_ginfo,win->RPort);
	}
}


VOID bordercheck(struct VSprite *vs,LONG borderflags)
{
printf("yes yes yes yes yes");
}


VOID quit(int return_code)
{
int i;
for(i = 0; i <MAXBOBS;i++)
	{
	if(enemy_bobs[i])
		{				
		RemBob(enemy_bobs[i]);
		/*freeBob(enemy_bobs[i]);*/
		}
	}
if(ship_bob)
	{
	RemBob(ship_bob);
	/*freeBob(ship_bob);*/
	}
bobDrawGlist(win);
	
		
cleanupGelSys(my_ginfo,win->RPort);
CloseWindow(win);
CloseLibrary(IntuitionBase);
CloseLibrary(GfxBase);
exit(return_code);
}
