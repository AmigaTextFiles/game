/* 
 * MORTAR
 * 
 * -- screen access functions for DOS
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero tamminen
 *
 * NOTES:
 * - win_sync() expects screen width to be long aligned (divisable by 4).
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/farptr.h>
#include <go32.h>
#include <dpmi.h>
#include <pc.h>
#include "mortar.h"


static int Textmode = 1, Vesa = 0;
static unsigned long Graph;


/* VBE info structure */
typedef struct {
  unsigned  ModeAttributes;
  unsigned  granularity, startseg, farfunc;
  short   bscanline;
  short   XResolution;
  short   YResolution;
  short   charpixels;
  unsigned  bogus1, bogus2, bogus3, bogus4;
  unsigned  PhysBasePtr;
  char    bogus[228];
} ModeInfoBlock;


static ModeInfoBlock *get_mode_info(int mode)
{
  static ModeInfoBlock info;
  __dpmi_regs r;

  memset(&r, 0, sizeof(r));

  /* Use the transfer buffer to store the results of VBE call */
  r.x.ax = 0x4F01;
  r.x.cx = mode;
  r.x.es = __tb / 16;
  r.x.di = 0;

  __dpmi_int(0x10, &r);
  if(r.h.ah) {
    return 0;
  }
  dosmemget(__tb, sizeof(ModeInfoBlock), &info);
  return &info;
}


int win_init(int *width, int *height)
{
  __dpmi_meminfo info;
  ModeInfoBlock *mb;
  int wd, ht, idx;
  m_uchar *map;

  mb = get_mode_info(0x101);

  /* request doesn't fit to one page (=VGA) and we got
   * VESA and linear buffer support?
   */
  if ((*width > 320 || *height > 200) &&
      mb && (mb->ModeAttributes & 0x80)) {

    wd = mb->XResolution;
    ht = mb->YResolution;

    info.size = wd * ht;
    info.address = mb->PhysBasePtr;

    if(__dpmi_physical_address_mapping(&info) < 0) {
      fprintf(stderr,
        "Physical mapping of address 0x%lx failed!\n",
              Graph);
      exit(-1);
    }
    Graph = info.address;   /* Updated by above call */

    fprintf(stdout, "VESA mode 0x101: %d x %d\n", wd, ht);
    Vesa = 1;
  } else {

    wd = 320;
    ht = 200;

    fprintf(stdout, "VESA linear frame buffer request failed, using VGA.\n");
    Vesa = 0;
  }
  fflush(stdout);

  /* we're still in text mode */
  Textmode = 1;

  if (!screen_init(wd, ht, 256)) {
    return 0;
  }
  idx = 256;

  /* use direct mapping */
  map = map_get();
  while (--idx >= 0) {
    map[idx] = idx;
  }

  *height = ht;
  *width = wd;
  return 1;
}

/* this is called from win_setpalette() instead of win_init() so that user
 * can read previous error messages in case something went wrong.
 */
static void init_graphics(void)
{
  __dpmi_regs regs;
  int video_ds;

  memset(&regs, 0, sizeof(regs));

  if (Vesa) {

    /* mode plus linear enable bit */
    regs.x.bx = 0x4101;
    regs.x.ax = 0x4f02;

    /* set the mode */
    __dpmi_int(0x10, &regs);
    if(regs.h.al != 0x4f || regs.h.ah) {
      fprintf(stderr, "VESA mode setting failed!\n");
      exit(-1);
    }

    video_ds = __dpmi_allocate_ldt_descriptors(1);
    __dpmi_set_segment_base_address(video_ds, Graph);

    Graph = 0;  /* base is now zero */

    __dpmi_set_segment_limit(video_ds,
      (Screen->wd * Screen->ht) | 0xfff);

    _farsetsel(video_ds);
  } else {

    /* 320x200 VGA */
    regs.x.ax = 0x13;
    __dpmi_int(0x10, &regs);

    _farsetsel(_dos_ds);
    Graph = 0xa0000;
  }

  Textmode = 0;
}

void win_exit(void)
{
  __dpmi_regs regs;

  if (!Textmode) {
    memset(&regs, 0, sizeof(regs));

    /* 80x25 text mode */
    regs.x.ax = 0x03;
    __dpmi_int(0x10, &regs);
  }
}


void win_changecolor(int index, m_rgb_t *rgb)
{
  /* write starting from color 'index' */
  outportb(0x3c8, (m_uchar)index);

  /* VGA palette values are 0-63, mortar 0-255
   */
  outportb(0x3c9, rgb->r >> 2);
  outportb(0x3c9, rgb->g >> 2);
  outportb(0x3c9, rgb->b >> 2);

  /* have to update for image saving */
  Screen->palette[index] = *rgb;
}


int win_setpalette(int colors, m_rgb_t *pal)
{
  int idx;

  /* store for further reference
   */
  memcpy(Screen->palette, pal, colors * sizeof(m_rgb_t));


  if (Textmode) {
    init_graphics();
  }

  outportb(0x3c8, 0);

  idx = colors;
  while (--idx >= 0) {
    outportb(0x3c9, pal->r >> 2);
    outportb(0x3c9, pal->g >> 2);
    outportb(0x3c9, pal->b >> 2);
    pal++;
  }

  return 1;
}


void win_sync(void)
{
  register unsigned long *src, dst;
  register int x, w, h, off;
  int xx, yy, ww, hh;
  long size;

  snd_flush();

  /* get the changed area */
  if (!screen_rect(&xx, &yy, &ww, &hh)) {
    /* nothing to update */
    return;
  }

  /* long align horizontally */
  w = ww + xx;
  x = xx & ~3;
  w = (w - x + 3) & ~3;
  h = hh;

  off = Screen->wd;
  size = yy * off + x;
  off -= w;

  src = (unsigned long *)(Screen->data + size);
  dst = Graph + size;

  w >>= 2;
  while (--h >= 0) {

    x = w;
    while (--x >= 0) {
      _farnspokel(dst, *src++);
      dst += sizeof(long);
    }
    src += off >> 2;
    dst += off;
  }
}


int win_getkey(long timeout)
{
  char *name;
  int key = 0;

  win_sync();

  do {
    /* timeout is in milliseconds */
    usleep(1000UL * (timeout % TimeInput));
    timeout -= TimeInput;

    if (kbhit()) {
      key = getkey();

      /* try to prevent keyboard buffer overflow */
      while (kbhit()) {
        getkey();
      }

      if (key == 's' || key == 'S') {

        name = get_string("snapshot");
        if (name) {
          bm_write(name, Screen);
        }
        continue;
      }
      return key;
    }
  } while (timeout > 0);

  return 0;
}
