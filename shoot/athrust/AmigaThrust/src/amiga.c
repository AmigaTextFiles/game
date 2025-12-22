/*
 * amiga.c
 * Amiga specific graphic routines for Thrust.
 * Written by Frank Wille, frank@phoenix.owl.de
 *
 */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#if defined(HAVE_GETOPT_H) && defined(HAVE_GETOPT_LONG_ONLY)
# include <getopt.h>
#elif !defined(HAVE_GETOPT_LONG_ONLY)
# include "getopt.h"
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <exec/types.h>
#include <exec/libraries.h>
#include <intuition/intuition.h>
#include <rtgmaster/rtgmaster.h>
#include <rtgmaster/rtgsublibs.h>
#include <proto/exec.h>
#include <proto/rtgmaster.h>

#include "thrust.h"
#include "fast_gr.h"
#include "gr_drv.h"
#include "options.h"

struct Library *GfxBase = NULL;
struct RTGMasterBase *RTGMasterBase = NULL;
struct RtgScreen *RtgScreen = NULL;
static unsigned char *fb;  /* frame buffer of gfx board */
unsigned char *gfxbuf = NULL;  /* gfx buffer - same dimensions as fb */
unsigned char **ytab = NULL;   /* y buffer addresses */
static ULONG rtgwidth,rtgheight,fbwidth,totalsize;


void clearscr(void)
{
  memset(gfxbuf,0,totalsize);
}


#ifndef __VBCC__ /* inlined */
void putarea(unsigned char *source, int x, int y, int width, int height,
             int bytesperline, int destx, int desty)
{
  int ix;
  unsigned char *s = source+(y*bytesperline)+x;
#ifdef __PPC__
  unsigned char *d = gfxbuf+(desty*rtgwidth)+destx;
#else
  unsigned char *d = *(ytab+desty)+destx;
#endif
  int smod = bytesperline - width;
  int dmod = rtgwidth - width;

  for (; height>0; height--,s+=smod,d+=dmod)
    for (ix=0; ix<width; ix++,*d++=*s++);
}
#endif


#ifndef __VBCC__ /* inlined */
void putpixel(int x, int y, unsigned char color)
{
#ifdef __PPC__
  *(gfxbuf+(y*rtgwidth)+x) = color;
#else
  *(*(ytab+y)+x) = color;
#endif
}
#endif


void syncscreen(void)
{
#if 0
/* @@@ does't work on CV64 anyway... */
/* @@@ better sync with WaitTOF to provide the same speed for all ports */
#ifdef WOS
  PPCRtgWaitTOF(RtgScreen);
#else
  RtgWaitTOF(RtgScreen);
#endif

#else
  WaitTOF();  /* @@@ */
#endif
}


void displayscreen(void)
{
#ifdef WOS
  PPCCopyRtgBlit(RtgScreen,fb,gfxbuf,0,0,0,fbwidth,rtgheight,
                 rtgwidth,rtgheight,0,0);
#else
  CopyRtgBlit(RtgScreen,fb,gfxbuf,0,0,0,fbwidth,rtgheight,
              rtgwidth,rtgheight,0,0);
#endif
}


void fadepalette(int first, int last, unsigned char *RGBtable, int fade, int flag)
{
  static ULONG tmprgb[3*256+2];
  ULONG *p = tmprgb;
  ULONG cnt = (ULONG)(last-first)+1;
  unsigned char *rgb = RGBtable;
  ULONG c;

  *p++ = (cnt<<16) | (ULONG)first;
  cnt *= 3;
  while (cnt--) {
    c = ((((ULONG)*rgb++) * (ULONG)(fade<<2)) >> 8) & 0xff;
    *p++ = (c<<24)|(c<<16)|(c<<8)|c;
  }
  *p = 0;
  if(flag)
#ifdef WOS
    PPCRtgWaitTOF(RtgScreen);
#else
    RtgWaitTOF(RtgScreen);
#endif
  LoadRGBRtg(RtgScreen,tmprgb);
  displayscreen();
}


void fade_in(void)
{
  int i;

  for(i=0; i<=64; i+=4)
    fadepalette(0, 255, bin_colors, i, 1);
}


void fade_out(void)
{
  int i;

  for(i=64; i; i-=4)
    fadepalette(0, 255, bin_colors, i, 1);
  clearscr();
  displayscreen();
  usleep(200000L);
}


void graphics_preinit(void)
{
}


int graphicsinit(int argc, char **argv)
{
  static struct TagItem sreqtag[] = {
    smr_MinWidth,320,
    smr_MinHeight,200,
    smr_MaxWidth,320,
    smr_MaxHeight,256,
    smr_ProgramUsesC2P,TRUE,
    smr_Buffers,1,
    smr_ChunkySupport,LUT8,
    smr_PlanarSupport,Planar8,
    smr_Workbench,0,  /* @@@ WB-support gets wrong colors, deactivated */
    smr_PrefsFileName,(ULONG)"Thrust.prefs",
    TAG_DONE
  };
  static struct TagItem scrtag[] = {
    rtg_Buffers,1,
    rtg_Workbench,0,
/*    rtg_ChangeColors,1, @@@ try this for WB support? */
    TAG_DONE
  };
  static struct TagItem gtag[] = {
    grd_BytesPerRow,0,
    grd_Width,0,
    grd_Height,0,
    grd_Depth,0,
    grd_PixelLayout,0,
    TAG_DONE
  };
  struct ScreenReq *sr;
  unsigned char *p;
  ULONG i;

  if (!(GfxBase = OpenLibrary("graphics.library",36))) {
    printf("Can't open graphics.library V36!\n");
    return (0);
  }
  if (RTGMasterBase = (struct RTGMasterBase *)
      OpenLibrary("rtgmaster.library",27)) {
#if 0
    if (sr = RtgBestSR(sreqtag)) {
#else
    if (sr = RtgScreenModeReq(sreqtag)) {
#endif
      scrtag[1].ti_Data = (sr->Flags&sq_WORKBENCH) ? LUT8 : 0;

      if (RtgScreen = OpenRtgScreen(sr,scrtag)) {
        GetRtgScreenData(RtgScreen, gtag);
        rtgwidth = gtag[1].ti_Data;
        rtgheight = gtag[2].ti_Data;
        fbwidth = gtag[0].ti_Data;
        if (gtag[4].ti_Data == grd_PLANAR)
          fbwidth <<= 3;  /* 1 byte per row = 8 pixels in planar mode */
        if (gfxbuf = malloc(totalsize = rtgheight*rtgwidth)) {
          if (ytab = malloc(rtgheight*sizeof(unsigned char *))) {
            /* init offset table */
            for (i=0,p=gfxbuf; i<rtgheight; i++,p+=rtgwidth)
              ytab[i] = p;
            LockRtgScreen(RtgScreen);
            fb = (unsigned char *)GetBufAdr(RtgScreen,0);
            fadepalette(0, 255, bin_colors, 1, 0);
            return (0);
          }
          else
            printf("Can't allocate y offset table!\n");
          free(gfxbuf);
          gfxbuf = NULL;
        }
        else
          printf("Can't allocate gfx buffer!\n");
        CloseRtgScreen(RtgScreen);
        RtgScreen = NULL;
      }
      else
        printf("Can't open screen!\n");
    }
    else
      printf("Gfx resolution with at least 320x200 and 1 byte per pixel "
             "is not available.\n");
    CloseLibrary((struct Library *)RTGMasterBase);
    RTGMasterBase = NULL;
  }
  else
    printf("Can't open rtgmaster.library V27.\n");
  return (-1);
}


int graphicsclose(void)
{
  if (RTGMasterBase) {
    if (RtgScreen) {
      if (ytab)
        free(ytab);
      if (gfxbuf)
        free(gfxbuf);
      UnlockRtgScreen(RtgScreen);
      CloseRtgScreen(RtgScreen);
    }
    CloseLibrary((struct Library *)RTGMasterBase);
  }
  if (GfxBase)
    CloseLibrary(GfxBase);
  return (0);
}


char *graphicsname(void)
{
  static char name[] = "RTGMaster";

  return name;
}
