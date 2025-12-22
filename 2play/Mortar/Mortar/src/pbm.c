/*
 * MORTAR
 *
 * -- alloc, read and write uncompressed 8-bit images with a palette
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * NOTES:
 * - the supported formats are binary Portable Graymap (PGM) and my own P8M
 *   variant of it which adds a palette and interprets the 8-bit 'gray
 *   values' as palette indeces.
 * - PPM support is intended only the utilities (and snapshot saving).
 */

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mortar.h"


void
bm_free(m_image_t *bm)
{
  if (!bm) {
fprintf(stderr, "mortar: pbm.c/bm_free() called with NULL image!\n");
    return;
  }

  if (bm->palette) {
    free(bm->palette);
  }
  if (bm->data) {
    free(bm->data);
  }
  free(bm);
}

m_image_t *
bm_alloc(int wd, int ht, int colors)
{
  m_image_t *bm;

  if (!(bm = calloc(1, sizeof(m_image_t)))) {
    msg_print(ERR_ALLOC);
    return NULL;
  }
  if (!(bm->data = malloc(wd * ht))) {
    bm_free(bm);
    msg_print(ERR_ALLOC);
    return NULL;
  }
  if (colors) {
    if (!(bm->palette = malloc(sizeof(m_rgb_t) * colors))) {
      bm_free(bm);
      msg_print(ERR_ALLOC);
      return NULL;
    }
  }
  bm->colors = colors;
  bm->wd = wd;
  bm->ht = ht;
  return bm;
}


/* ----------------- PBM reading utility routines ---------------- */

#define IS_SPACE(ch) (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r')
#define IS_LINE_END(ch) (ch == EOF || ch == '\n' || ch == '\r')

/* read char from file ignoring commented line ends */
static int
pbm_getc(FILE *fp)
{
  int ch;
  ch = fgetc(fp);
  if (ch == '#') {
    /* pass comment */
    do {
      ch = fgetc(fp);
    } while (!IS_LINE_END(ch));
  }
  return ch;
}

/* next no white space nor comment character */
static inline int
pbm_next(FILE *fp)
{
  int ch;
  do {
    ch = pbm_getc(fp);
  } while(IS_SPACE(ch));
  return ch;
}

/* Read a number skipping comments and white space separating numbers.
 * Negative value means an error.
 */
static int
pbm_getint(FILE *fp)
{
  int ch, number = 0;

  ch = pbm_next(fp);
  while (ch >= '0' && ch <= '9') {
    number = number * 10 + ch - '0';
    ch = fgetc(fp);
  }
  if (!IS_SPACE(ch)) {
    number = -1;
  }
  return number;
}

/* ------------- binary PGM (grayscale) format reading ---------------- */

/* no scaling for color values even if they aren't for the full 8-bit range.
 * image might be intentionally dark instead of using less than 8 bits.
 */
static m_image_t *
gray_loader(FILE *fp, int wd, int ht)
{
  m_image_t *bm;
  m_rgb_t *rgb;
  int grays;

  grays = pbm_getint(fp);
  if (grays < 1 || grays > 255) {
    msg_print(ERR_COLORS);
    return NULL;
  }

  bm = bm_alloc(wd, ht, ++grays);
  if (!bm) {
    return NULL;
  }

  rgb = bm->palette + grays;
  while (--grays >= 0) {
    --rgb;
    rgb->r = rgb->g = rgb->b = grays;
  }

  /* no aligning needed so can read it in one go */
  if (fread(bm->data, wd * ht, 1, fp) != 1) {
    bm_free(bm);
    msg_print(ERR_READ);
    return NULL;
  }

  return bm;
}

/* ----------------- binary format with a palette -------------- */

static m_image_t *
color_loader(FILE *fp, int wd, int ht)
{
  m_uchar buf[3];
  m_image_t *bm;
  m_rgb_t *rgb;
  int colors;

  colors = pbm_getint(fp);
  if (colors < 1 || colors > 256) {
    msg_print(ERR_COLORS);
    return NULL;
  }

  bm = bm_alloc(wd, ht, colors);
  if (!bm) {
    return NULL;
  }

  rgb = bm->palette;
  while (--colors >= 0) {

    /* pixel at the time to save memory, speed is no concern
     */
    if (fread(buf, 1, 3, fp) != 3) {
      msg_print(ERR_READ);
      bm_free(bm);
      return NULL;
    }
    rgb->r = buf[0];
    rgb->g = buf[1];
    rgb->b = buf[2];
    rgb++;
  }

  /* no aligning needed so can read it in one go */
  if (fread(bm->data, wd * ht, 1, fp) != 1) {
    bm_free(bm);
    msg_print(ERR_READ);
    return NULL;
  }

  return bm;
}

/* ---------- binary PPM (truecolor) format reading ------------ */

static void
map_24to8 (m_uchar *src, m_uchar *dst, m_image_t *bm)
{
  int closest, rd, gd, bd, idx, colors;
  long dist, mindist;
  m_uchar r, g, b;
  m_rgb_t *rgb;

  r = *src++;
  g = *src++;
  b = *src;

  rgb = bm->palette;
  colors = bm->colors;

  /* is color already in palette?
   */
  for (idx = 0; idx < colors; idx++) {

    if (r == rgb->r && g == rgb->g && b == rgb->b) {
      *dst = idx;
      return;
    }
    rgb++;
  }

  /* do we have an entry for new color?
   */
  if (idx < 256) {

    rgb->r = r;
    rgb->g = g;
    rgb->b = b;
    *dst = bm->colors++;

    return;
  }

  mindist = 0x7fffffff;
  closest = 0;

  /* hope that 256 first colors were distributed evenly enough and
   * find a closest (least square) match from new color to them.
   */
  fprintf(stderr, "More than 256 colors, matchin closest...\n");

  while (--idx) {

    rgb--;
    rd = (int)r - rgb->r;
    gd = (int)g - rgb->g;
    bd = (int)b - rgb->b;
    dist = (long)rd*rd + gd*gd + bd*bd;

    if (dist < mindist) {
      mindist = dist;
      closest = idx;
    }
  }

  *dst = closest;
}

static m_image_t *
truecolor_loader(FILE *fp, int wd, int ht)
{
  m_uchar buf[3], *dst;
  m_image_t *bm;
  int x;

  /* assume maxval = 255 */
  pbm_getint(fp);

  bm = bm_alloc(wd, ht, 256);
  if (!bm) {
    return NULL;
  }

  bm->colors = 0;
  dst = bm->data;
  while (--ht >= 0) {
    x = wd;
    while (--x >= 0) {
      if (fread(buf, 1, 3, fp) != 3) {
        msg_print(ERR_READ);
        bm_free(bm);
        return NULL;
      }
      map_24to8(buf, dst++, bm);
    }
  }
  return bm;
}

/* ----------------- the read function itself ------------------ */

m_image_t *
bm_read(char *path)
{
  int wd, ht;
  m_image_t *(*loader) (FILE *, int, int) = NULL;
  FILE *fp = NULL;
  m_image_t *bm;

  if (path) {
    fp = fopen(path, "rb");
  } else {
    /* for image filters */
    fp = stdin;
  }
  if (!fp) {
    return NULL;
  }

  /* check file format */
  if (fgetc(fp) == 'P') {

    switch(fgetc(fp)) {

      /* PGM */
      case '5':
        loader = gray_loader;
        break;

      /* PPM */
      case '6':
        loader = truecolor_loader;
        break;

      /*  my own binary format with palette */
      case '8':
        loader = color_loader;
        break;
    }
  }

  if (!loader) {
    fclose(fp);
    msg_print(ERR_IMAGE);
    return NULL;
  }

  /* get image size */
  wd = pbm_getint(fp);
  ht = pbm_getint(fp);

  if(wd < 1 || ht < 1) {

    fclose(fp);
    /* well, might have another error message for this */
    msg_print(ERR_READ);
    return NULL;
  }

  bm = (*loader) (fp, wd, ht);
  fclose(fp);
  return bm;
}

/* ------------ image saving ---------------------------- */

/* saves the only kind of images mortar knows of...
 */
void bm_write(char *path, m_image_t *bm)
{
  int index;
  m_uchar buf[3];
  m_rgb_t *rgb;
  FILE *fp;

#ifdef DEBUG
  if (!bm) {
    fprintf(stderr, "pbm.c/bm_write(): no bitmap!\n");
    return;
  }
#endif

  if (path) {
    fp = fopen(path, "wb");
  } else {
    fp = stdout;
  }
  if (!fp) {
    msg_print(ERR_SAVE);
    return;
  }

  fprintf(fp, "P8\n%d %d\n%d\n", bm->wd, bm->ht, bm->colors);

  rgb = bm->palette;
  index = bm->colors;
  while (--index >= 0) {
    /* have to do it this way as structs might be padded
     */
    buf[0] = rgb->r;
    buf[1] = rgb->g;
    buf[2] = rgb->b;
    if (fwrite(buf, 3, 1, fp) != 1) {
      msg_print(ERR_SAVE);
      fclose(fp);
      return;
    }
    rgb++;
  }

  fwrite(bm->data, bm->wd * bm->ht, 1, fp);
  fclose(fp);
}

void ppm_write(char *path, m_image_t *bm)
{
  int x, wd, ht;
  m_uchar buf[3], *src;
  m_rgb_t *rgb;
  FILE *fp;

#ifdef DEBUG
  if (!bm) {
    fprintf(stderr, "pbm.c/ppm_write(): no bitmap!\n");
    return;
  }
#endif

  if (path) {
    fp = fopen(path, "wb");
  } else {
    fp = stdout;
  }
  if (!fp) {
    msg_print(ERR_SAVE);
    return;
  }

  fprintf(fp, "P6\n%d %d\n%d\n", bm->wd, bm->ht, 255);

  wd = bm->wd;
  ht = bm->ht;
  src = bm->data;

  while (--ht >= 0) {

    x = wd;
    while (--x >= 0) {
      rgb = &bm->palette[*src++];
      
      /* have to do it this way as structs might be padded
       */
      buf[0] = rgb->r;
      buf[1] = rgb->g;
      buf[2] = rgb->b;
      if (fwrite(buf, 3, 1, fp) != 1) {
        msg_print(ERR_SAVE);
        fclose(fp);
        return;
      }
    }
  }
  fclose(fp);
}
