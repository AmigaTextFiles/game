/*
 * MORTAR
 * 
 * -- screen access functions for Linux framebuffer devices.
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero tamminen (and Torsten Scherer)
 *
 * NOTES
 * - Most of the code came originally from Torsten Scherer's
 *   W window system m68k-linux graphics initialization code.
 * - The screen width has to be taken from finfo.line_length
 *   instead of vinfo.xres(_virtual).
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
#define BITS    8
#define COLORS    (1<<BITS)

static int FB_fd;
static int Gwidth;
static void *Graph;
static size_t Gsize;
static struct termios Termio;   /* for restore */
static struct fb_var_screeninfo Vinfo;
static int Sleeping = 0;
static int Textmode = 1;
static int sigVt;


static void sigvtswitch(int sig)
{
  struct sigaction sa;

  if ((sig == SIGUSR1) || (sig == SIGUSR2)) {

    /* ignore further signals until this one is served */

    sa.sa_flags = 0;
    sa.sa_handler = SIG_IGN;
    sigaction(SIGUSR1, &sa, NULL);
    sigaction(SIGUSR2, &sa, NULL);

    /* which signal */
    sigVt = sig;
  }
}


static void vtswitch(void)
{
  struct sigaction sa;

  /* this routine will be called at vt-switch by event function
   * when all graphics has been done, therefore we needn't any
   * kind of semaphore for the screen...
   */

  switch(sigVt) {

  case SIGUSR1:
    Sleeping = 1;
    ioctl(0, VT_RELDISP, 1);
    break;

  case SIGUSR2:
    ioctl(0, VT_ACKACQ, 1);
    Sleeping = 0;

    /* reset colors and redraw everything */
    win_setpalette(Screen->colors, Screen->palette);
    screen_dirty(0, 0, Screen->wd, Screen->ht);
    break;

  default:
    win_exit();
    fprintf(stderr, "unknown signal received\n");
    exit(-1);
  }

  /* no signal */
  sigVt = 0;

  /* ready for further signals */
  sa.sa_handler = sigvtswitch;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags = 0;

  sigaction(SIGUSR1, &sa, NULL);
  sigaction(SIGUSR2, &sa, NULL);
}


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

  finfo.id[15] = 0;
  switch(finfo.type) {
  case FB_TYPE_PACKED_PIXELS:
    printf("initializing %s: packed pixels...\n", finfo.id);
    break;
  default:
    fprintf(stderr, "%s: unsupported screen type\n", finfo.id);
    return 0;
  }

  ioctl(FB_fd, FBIOGET_VSCREENINFO, &Vinfo);
  printf("using %ix%i of %ix%i pixels, %i bits per pixel\n",
    Vinfo.xres, Vinfo.yres,
    Vinfo.xres_virtual, Vinfo.yres_virtual,
    Vinfo.bits_per_pixel);
  if ((Vinfo.xres) & 3 || (finfo.line_length & 3)) {
    /* we'd like to output longs */
    fprintf(stderr, "fatal: screen width not 4 aligned\n");
    return 0;
  }
  if (Vinfo.bits_per_pixel != BITS) {
    fprintf(stderr, "unsupported bit depth\n");
    return 0;
  }

  Gwidth = finfo.line_length;
  Gsize = Gwidth * Vinfo.yres;
  *wd = Vinfo.xres;
  *ht = Vinfo.yres;

  idx = COLORS;
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
  struct vt_mode vt;

  printf("mapping %ik videoram to 0x%p\n", Gsize >> 10, Graph);
  Graph = mmap(0, Gsize, PROT_READ | PROT_WRITE, MAP_SHARED, FB_fd, 0);
  if (Graph < 0) {
    perror("mmap() " FB_DEV);
    return 0;
  }

  /* set up signal handlers for vtswitch
   */
  signal(SIGUSR1, sigvtswitch);
  signal(SIGUSR2, sigvtswitch);

  /* disable vty switches
   */
  vt.mode = VT_PROCESS;
  vt.waitv = 0;
  vt.relsig = SIGUSR1;
  vt.acqsig = SIGUSR2;
  if (ioctl(0, VT_SETMODE, &vt)) {
    perror("ioctl(VT_SETMODE)");
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
  static struct fb_cmap c;  /* use static so it's zeroed */
  unsigned short r, g, b;

  /* have to update for image saving */
  Screen->palette[index] = *rgb;
  if (Sleeping) {
    return;
  }

  r = rgb->r << 8;
  g = rgb->g << 8;
  b = rgb->b << 8;

  c.len    = 1;
  c.start  = index;
  c.transp = 0;
  c.red    = &r;
  c.green  = &g;
  c.blue   = &b;
  ioctl(FB_fd, FBIOPUTCMAP, &c);
}


int win_setpalette(int colors, m_rgb_t *palette)
{
  static struct fb_cmap cmap = { 0, 0, NULL, NULL, NULL, NULL };
  unsigned short *r, *g, *b;

  if (colors > COLORS) {
    msg_print(ERR_COLORS);
    return 0;
  }
        /*  store for further reference
   */
  memcpy(Screen->palette, palette, colors * sizeof(m_rgb_t));

  if (Sleeping) {
    return 1;
  }
  if (Textmode) {
    if (!init_graphics()) {
      return 0;
    }
  }

  if (!cmap.len) {
    cmap.red = malloc(COLORS * 3 * sizeof(ushort));
    if (!cmap.red) {
      return 0;
    }
    cmap.green = &cmap.red[COLORS];
    cmap.blue = &cmap.green[COLORS];
    cmap.transp = 0;
    cmap.start = 0;
  }
  cmap.len = colors;

  palette += colors;
  r = cmap.red + colors;
  g = cmap.green + colors;
  b = cmap.blue + colors;
  while (--colors >= 0) {
    palette--;
    *--r = palette->r << 8;
    *--g = palette->g << 8;
    *--b = palette->b << 8;
  }
  ioctl(FB_fd, FBIOPUTCMAP, &cmap);

  return 1;
}


void win_sync(void)
{
  register unsigned long *src, *dst;
  register int x, w, h, off, dif;
  int xx, yy, ww, hh;

  snd_flush();

  /* not on curent console? */
  if (Sleeping) {
    return;
  }

  /* get the changed area */
  if (!screen_rect(&xx, &yy, &ww, &hh)) {
    /* nothing to update */
    return;
  }

  /* long align horizontally */
  w = ww + xx;
  x = xx & ~3;
  w = (w - x + 3) >> 2;
  h = hh;

  dif = Gwidth;
  off = Screen->wd;
  src = (unsigned long *)(Screen->data + (long)yy * off + x);
  dst = (unsigned long *)(Graph + (long)yy * dif + x);
  off = (off >> 2) - w;
  dif = (dif >> 2) - w;

  while (--h >= 0) {

    x = w;
    while (--x >= 0) {
      *dst++ = *src++;
    }
    src += off;
    dst += dif;
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
    if (sigVt) {
      vtswitch();
    }
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
