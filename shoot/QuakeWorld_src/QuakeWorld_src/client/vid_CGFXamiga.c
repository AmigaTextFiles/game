/* 
Copyright (C) 1996-1997 Id Software, Inc. 
 
This program is free software; you can redistribute it and/or 
modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation; either version 2 
of the License, or (at your option) any later version. 
 
This program is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   
 
See the GNU General Public License for more details. 
 
You should have received a copy of the GNU General Public License 
along with this program; if not, write to the Free Software 
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. 
 
*/ 

/*
** vid_CGFXamiga.c
**
** cybergraphics.library
**
** Written by Frank Wille <frank@phoenix.owl.de>
**
*/

#pragma amiga-align
#include <exec/types.h>
#include <exec/libraries.h>
#include <exec/memory.h>
#include <graphics/gfx.h>
#include <graphics/gfxbase.h>
#include <intuition/intuition.h>
#include <cybergraphics/cybergraphics.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/cybergraphics.h>
#pragma default-align

#include "quakedef.h"
#include "amigacompiler.h"

extern byte *vid_buffer;
extern unsigned char rawkeyconv[];

extern struct GfxBase *GfxBase;
extern struct Library *CyberGfxBase;
extern struct Screen *QuakeScreen;

static struct Window *Window = NULL;
static struct RastPort TempRP;
static unsigned short *dummypointer;
static int BytesPerRow;
static byte *GfxAddr;
static int turbogfx=TRUE;

#ifdef __PPC__
extern void TurboUpdatePPC(byte *vid_buffer,byte *GfxAddr,int BytesPerRow,
                           int x,int y,int width,int height);
#else
#ifndef _68881 /* 040/060 only */
extern void ASM TurboUpdate68k(REG(a0,byte *) vid_buffer,
                               REG(a1,byte *) GfxAddr,
                               REG(d4,int) BytesPerRow,
                               REG(d0,int) x, REG(d1,int) y,
                               REG(d2,int) width, REG(d3,int) height);
#endif
#endif


void VID_SetPalette_CGFX (unsigned char *palette)
{
  ULONG rgbtab[3*256+2];
  ULONG *rt = rgbtab;
  ULONG x;
  int i;

  *rt++ = 256<<16;
  for (i=0; i<256; i++) {
    x = (ULONG)*palette++;
    *rt++ = (x<<24)|(x<<16)|(x<<8)|x;
    x = (ULONG)*palette++;
    *rt++ = (x<<24)|(x<<16)|(x<<8)|x;
    x = (ULONG)*palette++;
    *rt++ = (x<<24)|(x<<16)|(x<<8)|x;
  }
  *rt = 0;
  LoadRGB32(&(QuakeScreen->ViewPort),rgbtab);
}


void VID_Init_CGFX (unsigned char *palette)
{
  char *module = "CGfx_Init: ";
  int DispID, ScrWidth, ScrHeight, i;
  static const short ColorModel[] = {PIXFMT_LUT8,-1};
  struct TagItem CyberModeTags[] =
  {
    CYBRMREQ_CModelArray,(ULONG)ColorModel,
    TAG_DONE,0
  };

#ifndef _68881 /* 040/060/PPC only */
  if (COM_CheckParm("-forcewpa8"))
    turbogfx = FALSE;
#endif
  if (!(GfxBase = (struct GfxBase *) OpenLibrary("graphics.library",36)))
    Sys_Error("%sCan't open graphics.library V36",module);
  if (!(CyberGfxBase = (struct Library *)
      OpenLibrary("cybergraphics.library",0)))
    Sys_Error("%sCan't open cybergraphics.library",module);
  if (!(DispID = CModeRequestTagList(NULL,CyberModeTags)))
    Sys_Error("%sCan't open the screenmode requester",module);
  if (DispID==-1)
    Sys_Error("%sScreenmode requester aborted",module);

  ScrWidth = GetCyberIDAttr(CYBRIDATTR_WIDTH,DispID);
  ScrHeight = GetCyberIDAttr(CYBRIDATTR_HEIGHT,DispID);
  if (!(QuakeScreen = OpenScreenTags(NULL,
                                     SA_Quiet,TRUE,
                                     SA_Width,ScrWidth,
                                     SA_Height,ScrHeight,
                                     SA_Depth,8,
                                     SA_DisplayID,DispID,
                                     TAG_DONE)))
    Sys_Error("%sCan't open the screen",module);
  BytesPerRow = GetCyberMapAttr(QuakeScreen->RastPort.BitMap,CYBRMATTR_XMOD);
  GfxAddr = (byte *)GetCyberMapAttr(QuakeScreen->RastPort.BitMap,CYBRMATTR_DISPADR);
  vid.maxwarpwidth = vid.width = vid.conwidth = ScrWidth;
  vid.maxwarpheight = vid.height = vid.conheight = ScrHeight;
  vid.rowbytes = vid.conrowbytes = ScrWidth;
  vid.aspect = 1.0;
  vid.numpages = 1;
  VID_SetPalette(palette);

  if (!(Window = OpenWindowTags(NULL,
              WA_Left,0,
              WA_Top,0,
              WA_Width,ScrWidth,
              WA_Height,ScrHeight,
              WA_Activate,TRUE,
              WA_Borderless,TRUE,
              WA_RMBTrap,TRUE,
              WA_IDCMP, IDCMP_MOUSEBUTTONS|IDCMP_RAWKEY,
              WA_CustomScreen,QuakeScreen,
              TAG_DONE,0)))
    Sys_Error("%sCan't open the window",module);

  if (dummypointer = AllocVec(16,MEMF_CLEAR))
    SetPointer(Window,dummypointer,1,1,0,0);
  InitRastPort(&TempRP);
  if ((GfxBase->LibNode.lib_Version)>=39)
    if (!(TempRP.BitMap = AllocBitMap(ScrWidth,1,8,BMF_MINPLANES,
              QuakeScreen->RastPort.BitMap)))
      Sys_Error("%sCan't allocate temporary bitmap",module);
  else
  {
    InitBitMap(TempRP.BitMap,8,ScrWidth,1);
    for (i=0;i<8;i++)
        if (!(TempRP.BitMap->Planes[i]=AllocRaster(ScrWidth,1)))
      Sys_Error("%sCan't allocate temporary bitmap",module);
  }
  Con_Printf("cybergraphics.library %d x %d x %d\n",ScrWidth,ScrHeight,8);
  Con_Printf(" %dbpr chunky CLUT\n",BytesPerRow);
}


void VID_Shutdown_CGFX (void)
{
  int i;

  if ((GfxBase->LibNode.lib_Version)>=39) {
    if (TempRP.BitMap)
      FreeBitMap(TempRP.BitMap);
  }
  else {
    for (i=0;i<8;i++)
      if (TempRP.BitMap->Planes[i])
        FreeRaster(TempRP.BitMap->Planes[i],vid.width,1);
  }
  if (dummypointer)
    FreeVec(dummypointer);
  if (Window)
    CloseWindow(Window);
  if (QuakeScreen)
    CloseScreen(QuakeScreen);
  if (CyberGfxBase)
    CloseLibrary((struct Library *)CyberGfxBase);
  if (GfxBase)
    CloseLibrary((struct Library *)GfxBase);
}


void VID_Update_CGFX (vrect_t *rects)
{
  int xstop,ystop;

  while (rects) {
    xstop = rects->x+rects->width-1;
    ystop = rects->y+rects->height-1;

#ifdef _68881 /* 030/88x */
    WritePixelArray8(&(QuakeScreen->RastPort),rects->x,rects->y,
                     xstop,ystop,vid_buffer,&TempRP);

#else
    if (!turbogfx)
      WritePixelArray8(&(QuakeScreen->RastPort),rects->x,rects->y,
                       xstop,ystop,vid_buffer,&TempRP);
    else
#ifdef __PPC__
      TurboUpdatePPC(vid_buffer,GfxAddr,BytesPerRow,
                     rects->x,rects->y,rects->width,rects->height);
#else
      TurboUpdate68k(vid_buffer,GfxAddr,BytesPerRow,
                     rects->x,rects->y,rects->width,rects->height);
#endif
#endif

    rects = rects->pnext;
  }
}


void Sys_SendKeyEvents_CGFX (void)
{
  struct IntuiMessage *imsg;
  int kn;

  if (Window) {
    while (imsg = (struct IntuiMessage *)GetMsg(Window->UserPort)) {
      if (imsg->Class==IDCMP_RAWKEY || imsg->Class==IDCMP_MOUSEBUTTONS) {
        kn = (int)rawkeyconv[imsg->Code & 0x7f];
        if (imsg->Code & IECODE_UP_PREFIX)
          Key_Event(kn,false);
        else
          Key_Event(kn,true);
      }
      ReplyMsg((struct Message *)imsg);
    }
  }
}
