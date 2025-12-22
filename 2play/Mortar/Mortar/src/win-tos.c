/*
 * MORTAR
 * 
 * -- screen access functions for Atari TOS
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero tamminen (and Torsten Scherer)
 *
 * NOTES
 * - 4-plane chunky to planar code is loaned from Torsten's Wlib sources.
 * - If you want to make this slightly more MiNT friendly, define
 *   USE_SELECT.  Then this won't work with plain TOS though...
 * - Works only in monochrome (uses ordered dithering) and 4/8 bit
 *   interleaved bitmap (planar) modes.  Last one (8-bits) is untested.
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>
#include <termios.h>
#include <osbind.h>
#include <linea.h>
#include "mortar.h"

/* whether to use MiNT select() or read characters with BIOS Bcon* stuff */
#undef USE_SELECT
#ifdef USE_SELECT
static struct termios Termio;
#endif

static m_uchar Grayscale[256];
static void *Graph;
static int Planes;

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


static void win_mono(short x, short y, short w, short h);
static void win_8bits(short x, short y, short w, short h);
static void win_4bits(short x, short y, short w, short h);
static void (*update)(short x, short y, short w, short h);


int win_init(int *wd, int *ht)
{
  m_uchar *map;
  int idx;

  /* get screen information from Line-A *variables*
   */
  linea0();
  *wd = V_X_MAX;
  *ht = V_Y_MAX;

  if (*wd < 320 || *ht < 200) {
    fprintf(stderr, "Strange screen size!\n");
    return 0;
  }
  if (*wd & 31) {
    fprintf(stderr, "Screen width not 32 aligned!\n");
    return 0;
  }

  Planes = VPLANES;
  if (Planes == 1) {
    Makemono = 1;
    /* white on black, clear screen */
    Cconws("\eb0\ec1\eE");
    update = win_mono;
    idx = 256;
  } else {
    /* hopefully there are enough colors for images... */
    switch (Planes) {
      case 4:
        update = win_4bits;
        break;
      case 8:
        update = win_8bits;
        break;
      default:
        fprintf(stderr, "Unsupported number of bitplanes!\n");
        return 0;
    }
    idx = 1 << Planes;
  }

  if (!screen_init(*wd, *ht, idx)) {
    return 0;
  }
  /* use direct mapping */
  map = map_get();
  while (--idx >= 0) {
    map[idx] = idx;
  }

  /* logical screen address */
  Graph = Logbase();

  /* cursor off */
  (void)Cursconf(0, 0);

#ifdef USE_SELECT
  {
    struct termios tt;

    /* store old terminal settings */
    tcgetattr(0, &Termio);

    tt = Termio;
    /* set no echo mode */
    tt.c_lflag &= ~(ECHO|ECHONL);
    tcsetattr(0, TCSANOW, &tt);
  }
#endif
  return 1;
}

void win_exit(void)
{
#ifdef USE_SELECT
  /* restore terminal settings */
  tcsetattr(0, TCSANOW, &Termio);
#endif
  if (Makemono) {
    Cconws("\eb1\ec0\eE");
  } else {
    /* restore some reasonable colors */
    (void)Setcolor(0, 0x0fff);
    (void)Setcolor(1, 0x0);
    (void)Setcolor(15, 0x0);
  }
  /* cursor on */
  (void)Cursconf(1, 0);
}


void win_changecolor(int index, m_rgb_t *rgb)
{
  m_uchar r, g, b;
  short color;

  r = rgb->r;
  g = rgb->g;
  b = rgb->b;

  if (Makemono) {
    Grayscale[index] = (r * 307UL + g * 599UL + b * 118UL) >> 10;
  } else {
    /* 3 MSB ST bits + 1 LSB STe bit */
    color  = (short)((r >> 5) | (r & 8)) << 8;
    color |= (short)((g >> 5) | (g & 8)) << 4;
    color |= (short)((b >> 5) | (b & 8));
    (void)Setcolor(index, color);
  }
  /* have to update for image saving */
  Screen->palette[index] = *rgb;
}


int win_setpalette(int colors, m_rgb_t *palette)
{
  if (colors > Screen->colors) {
    msg_print(ERR_COLORS);
    return 0;
  }

  /* ST doesn't have that many colors so I'll just call above function.
   */
  palette += colors;
  while (--colors >= 0) {
    win_changecolor(colors, --palette);
  }
  return 1;
}


/* ordered dither to monochrome
 */
static void win_mono(register short x, register short y,
         register short w, register short h)
{
  register unsigned short *dst, result;
  register m_uchar *src, *mat, *gray, *line;
  register short ss, dd;
  long off;

  gray = Grayscale;

  off = (long)y * Screen->wd + x;
  src = Screen->data + off;
  dst = (unsigned short *)Graph + (off >> 4);
  ss = Screen->wd - w;
  dd = ss >> 4;
  w >>= 4;

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

/* C2P: chunky to planar
 */
static void win_8bits(register short x, register short y,
          register short w, register short h)
{
  unsigned short buffer[8];
  register unsigned short *dst, *value = buffer, result;
  register m_uchar *src, plane;
  register short ss;
  long off;

  off = (long)y * Screen->wd + x;
  src = Screen->data + off;
  dst = (unsigned short *)Graph + (off >> 1);
  ss = Screen->wd - w;
  y = ss >> 1;
  w >>= 4;

  while (--h >= 0) {

    x = w;
    while (--x >= 0) {

      /* compose colors for 16 pixels on 8 planes
       */
      for (plane = 1; plane; plane += plane) {

        result = 0;
        if (*src++ & plane)  result |= 0x8000u;
        if (*src++ & plane)  result |= 0x4000u;
        if (*src++ & plane)  result |= 0x2000u;
        if (*src++ & plane)  result |= 0x1000u;
        if (*src++ & plane)  result |= 0x800u;
        if (*src++ & plane)  result |= 0x400u;
        if (*src++ & plane)  result |= 0x200u;
        if (*src++ & plane)  result |= 0x100u;
        if (*src++ & plane)  result |= 0x80u;
        if (*src++ & plane)  result |= 0x40u;
        if (*src++ & plane)  result |= 0x20u;
        if (*src++ & plane)  result |= 0x10u;
        if (*src++ & plane)  result |= 0x8u;
        if (*src++ & plane)  result |= 0x4u;
        if (*src++ & plane)  result |= 0x2u;
        if (*src   & plane)  result |= 0x1u;
        *value++ = result;
        src -= 15;
      }
      src += 16;

      /* ...and set them using long accesses at short
       * boundaries
       */
      value -= 8;
      *(unsigned long*)dst++ = *(unsigned long*)value++;
      *(unsigned long*)dst++ = *(unsigned long*)value++;
      *(unsigned long*)dst++ = *(unsigned long*)value++;
      *(unsigned long*)dst++ = *(unsigned long*)value;
      value -= 6;
    }
    src += ss;
    dst += y;
  }
}

static void win_4bits(register short x, short y,
          register short w, register short h)
{
  register unsigned long *dst, d0, d1, bitlo, bithi;
  register m_uchar *src, value;
  short dd, ss;
  long off;

  off = (long)y * Screen->wd + x;
  src = Screen->data + off;
  dst = (unsigned long *)Graph + (off >> 3);
  ss = Screen->wd - w;
  dd = ss >> 3;

  d0 = 0;
  d1 = 0;
  bithi = 0x1u;
  bitlo = 0x10000ul;

  src += 16;

  while (--h >= 0) {

    x = w;
    while (--x >= 0) {

      /* compose colors for 16 pixels on four planes...
       */
      value = *--src;

      if (value & 1u)  d0 |= bitlo;
      if (value & 2u)  d0 |= bithi;
      if (value & 4u)  d1 |= bitlo;
      if (value & 8u)  d1 |= bithi;

      /* add is faster than shift on 68000 */
      bithi += bithi;
      bitlo += bitlo;

      if (!bitlo) {
        bitlo = 0x10000ul;
        bithi = 0x1u;

        *dst++ = d0;
        *dst++ = d1;
        d0 = d1 = 0;

        src += 32;
      }
    }
    src += ss;
    dst += dd;
  }
}

void win_sync(void)
{
  int xx, yy, wd, ht;
  short x, w;

  snd_flush();

  /* get the changed area */
  if (!screen_rect(&xx, &yy, &wd, &ht)) {
    /* nothing to update */
    return;
  }

  /* long align horizontally */
  x = xx;
  w = wd + x;
  x &= ~31;
  w = (w - x + 31) & ~31;

  Vsync();
  (*update)(x, yy, w, ht);
}


/* at least on my STfm and STonX Mortar is so slow that checking for
 * timeouts would be downright ridculous.  Vsync() will in itself already
 * provide 1000/72 ms timeout anyway...
 */
int win_getkey(long timeout)
{
  m_uchar key = 0;
  char *name;

#ifdef USE_SELECT
  struct timeval time;
  fd_set fd;

  /* no time */
  time.tv_sec = 0;  /* timeout / 1000 */
  time.tv_usec = 0; /* timeout % 1000 */

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
#else
  win_sync();

  /* remove extra keypresses */
  while (Bconstat(2)) {
    key = Bconin(2);
  }
#endif

  if (key == 's' || key == 'S') {

    name = get_string("snapshot");
    if (name) {
      bm_write(name, Screen);
    }
    return 0;
  }

  return key;
}
