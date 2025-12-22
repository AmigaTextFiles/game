/* 
 * MORTAR
 * 
 * -- screen access functions for AmigaOS using rtgmaster.library
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1999 by Frank Wille <frank@phoenix.owl.de>
 *
 * NOTES
 * - works with 8-bit modes (all Amiga graphics boards and AGA)
 * - any resolution from 320x200 to 1600x1200 is supported
 */

#include <stdio.h>
#include <stdlib.h>
#include <exec/memory.h>
#include <exec/libraries.h>
#include <exec/io.h>
#include <devices/inputevent.h>
#include <intuition/intuition.h>
#include <rtgmaster/rtgmaster.h>
#include <rtgmaster/rtgsublibs.h>
#include <proto/exec.h>
#include <proto/console.h>
#include <clib/rtgmaster_protos.h>
#include "mortar.h"


extern void usleep(unsigned long);


struct RTGMasterBase *RTGMasterBase = NULL;
struct Library *ConsoleDevice = NULL;
static struct RtgScreen *RtgScreen = NULL;
static APTR fb;
static UWORD *dummypointer = NULL;
static struct IOStdReq *conio;



int win_init(int *wd, int *ht)
{
  static char *fn = "win-rtgm.c/win_init(): ";
  struct TagItem sreqtag[] = {
    smr_MinWidth,320,
    smr_MaxWidth,1600,
    smr_MinHeight,200,
    smr_MaxHeight,1200,
    smr_Buffers,1,
    smr_ChunkySupport,LUT8,
    smr_PlanarSupport,Planar8,
/*    smr_Workbench,1,  @@@ WB-window doesn't work */
    TAG_DONE
  };
  static struct TagItem scrtag[] = {
    rtg_Buffers,1,
    rtg_Workbench,0,
    rtg_ChangeColors,0,
    TAG_DONE
  };
  static struct TagItem gtag[] = {
    grd_BytesPerRow,0,
    grd_Width,0,
    grd_Height,0,
    grd_Depth,0,
    TAG_DONE
  };
  struct ScreenReq *sr;
  struct RDCMPData *rdcmp;
  m_uchar *map;
  struct MsgPort *conport;
  int i;

  if (!(RTGMasterBase = (struct RTGMasterBase *)
      OpenLibrary("rtgmaster.library",30))) {
    fprintf(stderr,"%sCan't open rtgmaster.library\n",fn);
    return 0;
  }

  if (!(sr = RtgScreenModeReq(sreqtag))) {
    fprintf(stderr,"%sNo appropriate screen mode\n",fn);
    return 0;
  }

  scrtag[1].ti_Data = (sr->Flags&sq_WORKBENCH) ? LUT8 : 0;
  if (!(RtgScreen = OpenRtgScreen(sr,scrtag))) {
    fprintf(stderr,"%sUnable to open screen\n",fn);
    return 0;
  }

  GetRtgScreenData(RtgScreen,gtag);
  *wd = (int)gtag[1].ti_Data;
  *ht = (int)gtag[2].ti_Data;
  printf("using rtgmaster.library at %dx%dx8\n",*wd,*ht);

  /* determine frame buffer address */
  LockRtgScreen(RtgScreen);
  fb = GetBufAdr(RtgScreen,0);

  if (!screen_init(*wd, *ht, (int)(1<<gtag[3].ti_Data))) {
    fprintf(stderr,"%sscreen_init() failed\n",fn);
    return 0;
  }

  map = map_get();
  for (i=0; i<256; i++)
    map[i] = i;

  if (!(rdcmp = RtgInitRDCMP(RtgScreen))) {
    fprintf(stderr,"%sCan't init RDCMP\n",fn);
    return 0;
  }

  /* clear mouse pointer */
  if (dummypointer = AllocVec(1024,MEMF_CLEAR|MEMF_PUBLIC))
    RtgSetPointer(RtgScreen,dummypointer,1,1,0,0);

  /* open console.device */
  if (conport = CreateMsgPort()) {
    if (conio = CreateIORequest(conport,sizeof(struct IOStdReq))) {
      if (OpenDevice("console.device",-1,(struct IORequest *)conio,0) == 0) {
        ConsoleDevice = (struct Library *)conio->io_Device;
      }
      else {
        DeleteIORequest(conio);
        DeleteMsgPort(conport);
      }
    }
    else
      DeleteMsgPort(conport);
  }
  else {
    fprintf(stderr,"%sCouldn't open console.device\n",fn);
    return 0;
  }

  return 1;
}


void win_exit(void)
{
  /* close console.device */
  if (ConsoleDevice) {
    CloseDevice((struct IORequest *)conio);
    DeleteMsgPort(conio->io_Message.mn_ReplyPort);
    DeleteIORequest(conio);
    ConsoleDevice = NULL;
  }

  /* close rtgmaster.library */
  if (RTGMasterBase) {
    if (RtgScreen) {
      UnlockRtgScreen(RtgScreen);
      CloseRtgScreen(RtgScreen);
    }
    CloseLibrary((struct Library *)RTGMasterBase);
  }
  if (dummypointer)
    FreeVec(dummypointer);
}


void win_changecolor(int index, m_rgb_t *rgb)
{
  ULONG tab[5];
  ULONG x;

  tab[0] = (1L<<16) | (ULONG)index;
  x = (ULONG)rgb->r;
  tab[1] = (x<<24)|(x<<16)|(x<<8)|x;
  x = (ULONG)rgb->g;
  tab[2] = (x<<24)|(x<<16)|(x<<8)|x;
  x = (ULONG)rgb->b;
  tab[3] = (x<<24)|(x<<16)|(x<<8)|x;
  tab[4] = 0;
  LoadRGBRtg(RtgScreen,tab);

  /* have to update for image saving */
  Screen->palette[index] = *rgb;
}


int win_setpalette(int colors, m_rgb_t *pal)
{
  ULONG rgbtab[3*256+2];
  ULONG *rt = rgbtab;
  ULONG x;
  int i;

  memcpy(Screen->palette, pal, colors * sizeof(m_rgb_t));

  *rt++ = (ULONG)colors<<16;
  for (i=0; i<colors; i++,pal++) {
    x = (ULONG)pal->r;
    *rt++ = (x<<24)|(x<<16)|(x<<8)|x;
    x = (ULONG)pal->g;
    *rt++ = (x<<24)|(x<<16)|(x<<8)|x;
    x = (ULONG)pal->b;
    *rt++ = (x<<24)|(x<<16)|(x<<8)|x;
  }
  *rt = 0;
  LoadRGBRtg(RtgScreen,rgbtab);

  return 1;
}


void win_sync(void)
{
  int x, y, w, h;

  snd_flush();

  if (!screen_rect(&x, &y, &w, &h)) {
    /* nothing to update */
    return;
  }

  w = (x+w+31)&~31;  /* do we need longword alignment? (for AGA-C2P?) */
  x &= ~31;
  w -= x;
  CopyRtgBlit(RtgScreen,fb,(APTR)Screen->data,0,x,y,w,h,
              Screen->wd,Screen->ht,x,y);
}


static int rawkeyconv(char *buf,int bufsize,unsigned char code)
{
  static struct InputEvent ie = {
    NULL,IECLASS_RAWKEY,0,0,0
  };

  if (code & 0x80)
    return (0);
  ie.ie_Code = (UWORD)code;
  ie.ie_Qualifier = 0;
  ie.ie_position.ie_addr = NULL;  /* ??? @@@@ */
  return (RawKeyConvert(&ie,(UBYTE *)buf,(LONG)bufsize,NULL));
}


int win_getkey(long timeout)
{
  m_uchar key = 0;
  char buf[8];
  struct IntuiMessage *imsg;

  win_sync();
  usleep((unsigned long)timeout * 1000);

  if (RtgScreen) {
    while (imsg = (struct IntuiMessage *)RtgGetMsg(RtgScreen)) {
      if (imsg->Class == IDCMP_RAWKEY) {
        if (!(imsg->Code & IECODE_UP_PREFIX)) {
          if (rawkeyconv(buf,8,(unsigned char)(imsg->Code & 0x7f)) != 1) {
            switch (imsg->Code & 0x7f) {
              case 0x4c: key = KEY_UP; break;
              case 0x4d: key = KEY_DOWN; break;
              case 0x4e: key = KEY_RIGHT; break;
              case 0x4f: key = KEY_LEFT; break;
              case 0x3f: key = KEY_PGUP; break;
              case 0x1f: key = KEY_PGDOWN; break;
              case 0x3d: key = KEY_HOME; break;
              case 0x1d: key = KEY_END; break;
            }
          }
          else
            key = (m_uchar)buf[0];
        }
      }
      RtgReplyMsg(RtgScreen,imsg);
    }

    if (key=='s' || key == 'S') {
      char *name = get_string("snapshot");

      if (name)
        bm_write(name,Screen);
      key = 0;
    }        
  }

  return key;
}
