/*
 * MORTAR
 * 
 * -- screen access functions for ucLinux/Pilot framebuffer.
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero tamminen
 *
 * NOTES
 * - composed of win-lfb.c and win-tos.c code.
 * - NOT TESTED!
 */

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <unistd.h>
#include <termios.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/fb.h>
#include <linux/vt.h>
#include <linux/kd.h>

#include "mortar.h"

#define FB_DEV  "/dev/fb0"

static int FB_fd;
static int Gwidth;
static void *Graph;
static size_t Gsize;
static struct termios Termio;   /* for restore */
static struct fb_var_screeninfo Vinfo;
static m_uchar Grayscale[256];
static int Textmode = 1;


/* ordered dither matrix for monochrome */
static m_uchar DMatrix[16][16] = {
  {0x14, 0xc3, 0xd3, 0x83, 0x1f, 0xce, 0xdd, 0x8e,
   0x20, 0xcf, 0xde, 0x8f, 0x1b, 0xca, 0xd9, 0x8a},
  {0xf2, 0x63, 0x34, 0xa3, 0xfd, 0x6e, 0x3f, 0xae,
   0xfe, 0x6f, 0x40, 0xaf, 0xf9, 0x6a, 0x3b, 0xaa},
  {0x44, 0x93, 0xff, 0x54, 0x4f, 0x9e, 0xff, 0x5e,
   0x50, 0x9f, 0xff, 0x5f, 0x4b, 0x9a, 0xff, 0x5a},
  {0xe2, 0x73, 0x24, 0xb3, 0xed, 0x7e, 0x2f, 0xbe,
   0xee, 0x7f, 0x30, 0xbf, 0xe9, 0x7a, 0x2b, 0xba},
  {0x22, 0xd1, 0xe0, 0x91, 0x19, 0xc8, 0xd7, 0x88,
   0x16, 0xc5, 0xd4, 0x85, 0x1d, 0xcc, 0xdb, 0x8c},
  {0xff, 0x71, 0x42, 0xb1, 0xf7, 0x68, 0x39, 0xa8,
   0xf4, 0x65, 0x36, 0xa5, 0xfb, 0x6c, 0x3d, 0xac},
  {0x52, 0xa1, 0xff, 0x61, 0x49, 0x98, 0xff, 0x58,
   0x46, 0x95, 0xff, 0x55, 0x4d, 0x9c, 0xff, 0x5c},
  {0xf0, 0x81, 0x32, 0xc1, 0xe7, 0x78, 0x29, 0xb8,
   0xe4, 0x75, 0x26, 0xb5, 0xeb, 0x7c, 0x2d, 0xbc},
  {0x17, 0xc6, 0xd5, 0x86, 0x1c, 0xcb, 0xda, 0x8b,
   0x23, 0xd2, 0xe1, 0x92, 0x18, 0xc7, 0xd6, 0x87},
  {0xf5, 0x66, 0x37, 0xa6, 0xfa, 0x6b, 0x3c, 0xab,
   0xff, 0x72, 0x43, 0xb2, 0xf6, 0x67, 0x38, 0xa7},
  {0x47, 0x96, 0xff, 0x56, 0x4c, 0x9b, 0xff, 0x5b,
   0x53, 0xa2, 0xff, 0x62, 0x48, 0x97, 0xff, 0x57},
  {0xe5, 0x76, 0x27, 0xb6, 0xea, 0x7b, 0x2c, 0xbb,
   0xf1, 0x82, 0x33, 0xc2, 0xe6, 0x77, 0x28, 0xb7},
  {0x21, 0xd0, 0xdf, 0x90, 0x1a, 0xc9, 0xd8, 0x89,
   0x15, 0xc4, 0xd3, 0x84, 0x1e, 0xcd, 0xdc, 0x8d},
  {0xff, 0x70, 0x41, 0xb0, 0xf8, 0x69, 0x3a, 0xa9,
   0xf3, 0x64, 0x35, 0xa4, 0xfc, 0x6d, 0x3e, 0xad},
  {0x51, 0xa0, 0xff, 0x60, 0x4a, 0x99, 0xff, 0x59,
   0x45, 0x94, 0xff, 0x54, 0x4e, 0x9d, 0xff, 0x5d},
  {0xef, 0x80, 0x31, 0xc0, 0xe8, 0x79, 0x2a, 0xb9,
   0xe3, 0x74, 0x25, 0xb4, 0xec, 0x7d, 0x2e, 0xbd}
};


int win_init(int *wd, int *ht)
{
  struct fb_fix_screeninfo finfo;
  m_uchar *map;
  int idx;

  if ((FB_fd = open(FB_DEV, O_RDWR)) < 0) {
    perror("open() " FB_DEV);
    return 0;
  }
  if (ioctl(FB_fd, FBIOGET_FSCREENINFO, &finfo)) {
    perror("ioctl()" FB_DEV);
    return 0;
  }

  ioctl(FB_fd, FBIOGET_VSCREENINFO, &Vinfo);
  printf("using %ix%i of %ix%i pixels, %i bits per pixel\n",
    Vinfo.xres, Vinfo.yres,
    Vinfo.xres_virtual, Vinfo.yres_virtual,
    Vinfo.bits_per_pixel);

  if (Vinfo.bits_per_pixel != 1) {
    fprintf(stderr, "unsupported bit depth (not monochrome)\n");
    return 0;
  }
  if ((Vinfo.xres) & 15 || (finfo.line_length & 15)) {
    /* we'd like to output longs */
    fprintf(stderr, "fatal: screen width not short aligned\n");
    return 0;
  }

  Gwidth = finfo.line_length;
  Gsize = Gwidth * Vinfo.yres;
  *wd = Vinfo.xres;
  *ht = Vinfo.yres;

  idx = 256;
    if (!screen_init(*wd, *ht, idx)) {
    return 0;
  }
  /* use direct palette mapping */
  map = map_get();
  while (--idx >= 0) {
    map[idx] = idx;
  }

  /* store old terminal settings */
  tcgetattr(0, &Termio);

  return 1;
}


/* this is called from init_palette instead of win_init() so that
 * user sees the message printed onto console.
 */
static int init_graphics(void)
{
  struct termios tt;

  printf("mapping %ik videoram to 0x%p\n", Gsize >> 10, Graph);
  Graph = mmap(0, Gsize, PROT_READ | PROT_WRITE, MAP_SHARED, FB_fd, 0);
  if (Graph < 0) {
    perror("mmap() " FB_DEV);
    return 0;
  }

  tt = Termio;
  /* set no echo / no buffer mode */
  tt.c_lflag &= ~(ECHO|ECHONL|ICANON);
  tcsetattr(0, TCSAFLUSH, &tt);

  /* disable text mode (stdio, screensaver?) */
  ioctl(0, KDSETMODE, KD_GRAPHICS);
  sleep(1);

  /* pan to start of fb */
  Vinfo.xoffset = 0;
  Vinfo.yoffset = 0;
  ioctl(FB_fd, FBIOPAN_DISPLAY, &Vinfo);

  Textmode = 0;
  return 1;
}


void win_exit(void)
{
  if (Textmode) {
    return;
  }
  ioctl(0, KDSETMODE, KD_TEXT);

  /* close frame buffer */
  munmap(Graph, Gsize);
  close(FB_fd);

  /* restore terminal settings */
  tcsetattr(0, TCSANOW, &Termio);
  Textmode = 1;
}


void win_changecolor(int index, m_rgb_t *rgb)
{
  /* have to update for image saving */
  Screen->palette[index] = *rgb;

  Grayscale[index] = (rgb->r * 307UL + rgb->g * 599UL + rgb->b * 118UL) >> 10;
}


int win_setpalette(int colors, m_rgb_t *palette)
{
  if (colors > Screen->colors) {
    msg_print(ERR_COLORS);
    return 0;
  }
  if (Textmode) {
    if (!init_graphics()) {
      return 0;
    }
  }

  palette += colors;
  while (--colors >= 0) {
    win_changecolor(colors, --palette);
  }
  return 1;
}


void win_sync(void)
{
  unsigned short *dst, result;
  m_uchar *src, *mat, *gray, *line;
  short x, y, w, h, ss, dd;
  int xx, yy, ww, hh;

  snd_flush();

  /* get the changed area */
  if (!screen_rect(&xx, &yy, &ww, &hh)) {
    /* nothing to update */
    return;
  }
  /* short align horizontally */
  x = xx;
  w = ww + x;
  x &= ~15;
  w = (w - x + 15) & ~15;
  /* yy can't be in register as above we take it's pointer */
  y = yy;
  h = hh;

  gray = Grayscale;

  /* 1 pixel / byte */
  ss = Screen->wd - w;
  src = Screen->data + (long)yy * Screen->wd + x;
  /* 8 pixels / byte */ 
  dst = Graph + (long)yy * Gwidth + (x >> 3);
  /* shorts */
  w >>= 4;
  dd = (Gwidth >> 1) - w;

  while (--h >= 0) {

    line = DMatrix[y++ & 15];

    x = w;
    while (--x >= 0) {

      mat = line;
      result = 0;

      if (gray[*src++] < *mat++)  result |= 0x8000u;
      if (gray[*src++] < *mat++)  result |= 0x4000u;
      if (gray[*src++] < *mat++)  result |= 0x2000u;
      if (gray[*src++] < *mat++)  result |= 0x1000u;
      if (gray[*src++] < *mat++)  result |= 0x800u;
      if (gray[*src++] < *mat++)  result |= 0x400u;
      if (gray[*src++] < *mat++)  result |= 0x200u;
      if (gray[*src++] < *mat++)  result |= 0x100u;
      if (gray[*src++] < *mat++)  result |= 0x80u;
      if (gray[*src++] < *mat++)  result |= 0x40u;
      if (gray[*src++] < *mat++)  result |= 0x20u;
      if (gray[*src++] < *mat++)  result |= 0x10u;
      if (gray[*src++] < *mat++)  result |= 0x8u;
      if (gray[*src++] < *mat++)  result |= 0x4u;
      if (gray[*src++] < *mat++)  result |= 0x2u;
      if (gray[*src++] < *mat++)  result |= 0x1u;

      *dst++ = result;
    }
    src += ss;
    dst += dd;
  }
}


int win_getkey(long timeout)
{
  fd_set fd;
  struct timeval time;
  m_uchar key = 0;
  char *name;

  /* no time */
  time.tv_sec = timeout / 1000;
  time.tv_usec = timeout % 1000;

  win_sync();

  /* read all pending keys */
  for (;;) {
    FD_ZERO(&fd);
    FD_SET(0, &fd);   /* stdin */

    select(1, &fd, NULL, NULL, &time);
    if (FD_ISSET(0, &fd)) {
      read(0, &key, 1);
      continue;
    }
    break;
  }

  if (key == 's' || key == 'S') {

    name = get_string("snapshot");
    if (name) {
      bm_write(name, Screen);
    }
    return 0;
  }
  return key;
}
