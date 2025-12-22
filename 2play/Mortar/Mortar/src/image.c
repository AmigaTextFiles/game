/* 
 * MORTAR
 * 
 * -- game image loading, palette negotiations and image blitting
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * TODO
 * - ground dropping
 */

#include <stdio.h>
#include <string.h>
#include "mortar.h"

/* pointers to background (sky), forground (ground), mask */
static m_image_t *Image[IMAGE_COUNT];


/* compose game palette and set it on
 */
static int init_palette(m_image_t *font, m_image_t *hilite, m_image_t *shot)
{
  m_rgb_t *c, *rgb, palette[256];
  int offset, count, idx, colors;
  m_image_t *bm;

  offset = hilite->colors;

  /* grays / highlight colors + font colors
   */
  colors = 2 * offset - 1 + font->colors - 1;

  /* colors for rest of the images */
  count = IMAGE_COUNT;
  while (--count >= 0) {
    if (count != HIT_MASK) {
      colors += Image[count]->colors - 1;
    }
  }

  /* shot / color cycling color */
  colors++;

  if (colors > Screen->colors) {
    msg_print(ERR_COLORS);
    return 0;
  }
  Screen->colors = colors;

  /* grayscales for tanks etc, these need not to be offset.
   */
  c = hilite->palette;
  rgb = palette;
  idx = offset;
  while (--idx >= 0) {
    rgb->r = c->r;
    rgb->g = c->g;
    rgb->b = c->b;
    rgb++;
    c++;
  }

  /* shot and tank highlight colors (are set later) */
  map_offset(shot, offset-1);
  map_offset(hilite, offset-1);
  color_init(1, offset, offset-1);
  offset += offset-1;

  /* font colors
   */
  rgb = &palette[offset];
  c = font->palette + 1;
  map_offset(font, offset - 1);
  idx = font->colors - 1;
  offset += idx;

  while (--idx >= 0) {
    rgb->r = c->r;
    rgb->g = c->g;
    rgb->b = c->b;
    rgb++;
    c++;
  }

  /* palettes for rest of the images
   */
  count = IMAGE_COUNT;
  while (--count >= 0) {

    if (count == HIT_MASK) {
      continue;
    }
    bm = Image[count];
    c = bm->palette + 1;
    map_offset(bm, offset - 1);
    idx = bm->colors - 1;
    offset += idx;
    bm++;

    while (--idx >= 0) {
      rgb->r = c->r;
      rgb->g = c->g;
      rgb->b = c->b;
      rgb++;
      c++;
    }
  }

  return win_setpalette(colors, palette);
}


static m_image_t *img_get(char *var)
{
  char *path;

  path = get_string(var);
  if (!path) {
    msg_print(ERR_VARS);
  }
  return bm_read(path);
}

/* load & initialize game images and palette
 */
int img_init(int wd, int ht)
{
  m_image_t *hilite, *tank, *shot, *font, *bm;
  m_rgb_t *rgb;

  msg_print(MSG_READ);

  Image[HIT_BG] = bm_scale(img_get("sky"), wd, ht);
  if (!Image[HIT_BG]) {
    return 0;
  }

  Image[HIT_GROUND] = bm_scale(img_get("ground"), wd, ht);
  if (!Image[HIT_GROUND]) {
    return 0;
  }

  Image[HIT_MASK] = bm_alloc(wd, ht, 0);
  if (!Image[HIT_MASK]) {
    return 0;
  }

  shot = img_get("shot");
  if (!(shot && shot_init(shot))) {
    return 0;
  }

  tank = img_get("player");
  hilite = bm_copy(tank);
  if (!(tank && hilite && tank_init(tank, hilite))) {
    return 0;
  }

  font = img_get("font");
  if (!(font && font_init(font))) {
    return 0;
  }

  if (Makemono) {
    int idx;

    /* black background */
    bm = Image[HIT_BG];
    memset(bm->data, 1, wd * ht);
    rgb = bm->palette + 1;
    rgb->r = 0;
    rgb->g = 0;
    rgb->b = 0;
    bm->colors = 2;

    /* mostly white font */
    idx = font->colors / 2;
    rgb = font->palette + idx;
    memset(rgb, 0xff, sizeof(m_rgb_t) * (font->colors - idx));
  }

  if (!init_palette(font, hilite, shot)) {
    return 0;
  }

  /* leave this much free on top */
  range_offset(2 * font_height() + tank_height());

  /* if were running on a palettized window system, the palettes
   * might need to be mapped...
   */
  map_colors(hilite);
  map_colors(tank);
  map_colors(shot);
  map_colors(font);
  map_colors(Image[HIT_BG]);
  map_colors(Image[HIT_GROUND]);

  CycleColor = map_get()[Screen->colors-1];

  msg_print(MSG_DONE);
  return 1;
}


/* parses players first as they are more important (other code also slightly
 * relies on that
 */
static m_hit_t *parse_hits(int *hit)
{
  static m_hit_t type[MAX_HITS+1];
  int hits, idx;

  hits = 0;
  idx = MAX_HITS;
  while (--idx >= 0) {
    if (hit[idx]) {
      type[hits].type = idx;
      type[hits++].count = hit[idx];
    }
  }
  type[hits].type = NO_HIT;
  return type;
}


/* returns a m_hit_t array, terminating either in NO_HIT or HIT_OUT, which
 * tells what the blitted image hit against.  If array entry index >=
 * HIT_PLAYER, decrease it by that value to get the player index.
 */
m_hit_t *
img_blit(m_image_t *bm, int soff, int doff, int sw, int sh, int x, int y)
{
  long offset;
  static m_hit_t clipped[2];
  int idx, dh, hits[MAX_HITS];
  register m_uchar *src, *dst, *mask;
  register int dw, *hit = hits;

#ifdef DEBUG
  if (soff < 0 || doff < 0 || sw <= 0 || sh <= 0 ||
      soff + sw > bm->wd || doff + sh > bm->ht) {
    win_exit();
    fprintf(stderr,
      "image.c/img_blit(): illegal blit offset!\n");
    exit(1);
      }
#endif

  /* do clipping */

  src = bm->data + bm->wd * doff + soff;

  if (y < 0) {
    sh += y;
    if (sh <= 0) {
      /* up on the sky... */
      clipped[0].type = HIT_BG;
      clipped[1].type = NO_HIT;
      return clipped;
    }
    src -= y * sw;
    y = 0;
  }

  if (x < 0) {
    sw += x;
    if (sw <= 0) {
      clipped[0].type = HIT_OUT;
      clipped[0].count = -sw;
      clipped[1].type = NO_HIT;
      return clipped;
    }
    src -= x;
    x = 0;
  }

  dw = Screen->wd - x;
  dh = Screen->ht - y;

  if (dw <= 0) {
    clipped[0].type = HIT_OUT;
    clipped[0].count = -dw;
    clipped[1].type = NO_HIT;
    return clipped;
  }

  if (dh <= 0) {
    clipped[0].type = HIT_GROUND;
    clipped[0].count = 1 << (8 * sizeof(int) - 2);
    clipped[1].type = NO_HIT;
    return clipped;
  }

  if (sh > dh) {
    sh = dh;
  }
  if (sw > dw) {
    sw = dw;
  }

  /* do copying / checking */
  screen_dirty(x, y, sw, sh);

  idx = MAX_HITS;
  while (--idx >= 0) {
    hit[idx] = 0;
  }

  offset = Screen->wd * y + x;
  dst = Screen->data + offset;
  mask = Image[HIT_MASK]->data + offset;

  doff = Screen->wd - sw;
  soff = bm->wd - sw;

  while (--sh >= 0) {

    dw = sw;
    while (--dw >= 0) {

      if (*src) {
        hit[*mask]++;
        *dst = *src;
      }
      mask++;
      src++;
      dst++;
    }

    mask += doff;
    dst += doff;
    src += soff;
  }

  return parse_hits(hit);
}

m_hit_t *img_copy(m_image_t *bm, int x, int y)
{
  return img_blit(bm, 0, 0, bm->wd, bm->ht, x, y);
}


/* clear image of the screen (ie restore background)
 */
void img_clblit(m_image_t *bm, int soff, int doff, int sw, int sh, int x, int y)
{
  register m_uchar *src, *dst, *mask;
  register m_image_t **image;
  register long offset;
  register int dw;
  int dh;

  /* do clipping */

  src = bm->data + bm->wd * doff + soff;

  if (y < 0) {
    sh += y;
    if (sh <= 0) {
      return;
    }
    src -= y * sw;
    y = 0;
  }

  if (x < 0) {
    sw += x;
    if (sw <= 0) {
      return;
    }
    src -= x;
    x = 0;
  }

  dw = Screen->wd - x;
  dh = Screen->ht - y;

  if (dw <= 0) {
    return;
  }
  if (dh <= 0) {
    return;
  }
  if (sh > dh) {
    sh = dh;
  }
  if (sw > dw) {
    sw = dw;
  }

  /* do copying / checking */
  screen_dirty(x, y, sw, sh);

  offset = Screen->wd * y + x;
  dst = Screen->data + offset;
  doff = Screen->wd - sw;
  soff = bm->wd - sw;

  image = Image;
  mask = image[HIT_MASK]->data + offset;

  while (--sh >= 0) {

    dw = sw;
    while (--dw >= 0) {

      /* pixel needs clearing and is part of background
       * (ie. garanteed to be of same size as mask and
       * screen)?
       */
      if (*src++ && *mask < IMAGE_COUNT) {
        *dst = image[*mask]->data[offset];
      }
      offset++;
      mask++;
      dst++;
    }

    offset += doff;
    mask += doff;
    dst += doff;
    src += soff;
  }
}

void img_clear(m_image_t *bm, int x, int y)
{
  img_clblit(bm, 0, 0, bm->wd, bm->ht, x, y);
}


/* draw a (clipped) circle of given color (index)
 */
m_hit_t *img_circle(int x, int y, int r,
        register m_uchar value, register m_uchar masked)
{
  m_uchar *mask, *screen;
  int dx, dy, off, start, count, wd, ht, hits[MAX_HITS];
  register m_uchar *mptr, *sptr;
  register int idx, *hit = hits;

  screen_dirty(x-r, y-r, 2*r+1, 2*r);

  mask = Image[HIT_MASK]->data;
  screen = Screen->data;

  wd = Screen->wd;
  ht = Screen->ht;

  idx = MAX_HITS;
  while (--idx >= 0) {
    hit[idx] = 0;
  }

  dx = r;
  r *= r;
  for (dy = 1; dx >= 0; dy++) {

    while (dx*dx + dy*dy > r) {
      dx--;
    }

    if (y - dy >= ht || y + dy < 0) {
      /* line out of screen */
      continue;
    }

    /* clip horizontally */
    count = 2 * dx;
    start = x - dx;
    if (start < 0) {
      count += start;
      start = 0;
    }
    if (start + count >= wd) {
      count = wd - start;
    }

    if (y - dy >= 0) {

      off = (y - dy) * wd + start;
      sptr = &screen[off];
      mptr = &mask[off];

      idx = count;
      while (--idx >= 0) {
        hit[*mptr]++;
        *mptr++ = masked;
        *sptr++ = value;
      }
    }

    if (y + dy <= ht) {

      off = (y + dy - 1) * wd + start;
      sptr = &screen[off];
      mptr = &mask[off];

      idx = count;
      while (--idx >= 0) {
        hit[*mptr]++;
        *mptr++ = masked;
        *sptr++ = value;
      }
    }
  }

  return parse_hits(hit);
}

/* clear circle to background pixels
 */
void img_nocircle(int x, int y, int r)
{
  int start, wd, ht, count, dx, dy;
  m_uchar *mask, *screen;

  register m_uchar *mptr, *sptr;
  register m_image_t **image;
  register long off;
  register int idx;

  screen_dirty(x-r, y-r, 2*r+1, 2*r);

  image = Image;
  mask = image[HIT_MASK]->data;
  screen = Screen->data;

  wd = Screen->wd;
  ht = Screen->ht;

  dx = r;
  r *= r;
  for (dy = 1; dx >= 0; dy++) {

    while (dx*dx + dy*dy > r) {
      dx--;
    }

    if (y - dy >= ht || y + dy < 0) {
      /* line out of screen */
      continue;
    }

    /* clip horizontally */
    count = 2 * dx;
    start = x - dx;
    if (start < 0) {
      count += start;
      start = 0;
    }
    if (start + count >= wd) {
      count = wd - start;
    }

    if (y - dy >= 0) {

      off = (y - dy) * wd + start;
      sptr = &screen[off];
      mptr = &mask[off];

      idx = count;
      while (--idx >= 0) {

        /* pixel needs clearing and is part of
         * background (ie.  garanteed to be of same
         * size as mask and screen)?
         */
        if (*mptr < IMAGE_COUNT) {
          *sptr = image[*mptr]->data[off];
        }
        mptr++;
        sptr++;
        off++;
      }
    }

    if (y + dy <= ht) {

      off = (y + dy - 1) * wd + start;
      sptr = &screen[off];
      mptr = &mask[off];

      idx = count;
      while (--idx >= 0) {

        if (*mptr < IMAGE_COUNT) {
          *sptr = image[*mptr]->data[off];
        }
        mptr++;
        sptr++;
        off++;
      }
    }
  }
}


/* above function set screen pixels, this will set also mask
 * so that drawn object can be hit and drawing functions get
 * the index for stuff which drawed object hit
 */
void img_setmask(m_image_t *bm, int soff, int doff, int sw, int sh,
    int x, int y, register int value)
{
  register m_uchar *src, *mask;
  register int dw;
  int dh;

  /* do clipping */

  src = bm->data + bm->wd * doff + soff;

  if (y < 0) {
    sh += y;
    if (sh <= 0) {
      return;
    }
    src -= y * sw;
    y = 0;
  }

  if (x < 0) {
    sw += x;
    if (sw <= 0) {
      return;
    }
    src -= x;
    x = 0;
  }

  dw = Screen->wd - x;
  dh = Screen->ht - y;

  if (dw <= 0) {
    return;
  }
  if (dh <= 0) {
    return;
  }
  if (sh > dh) {
    sh = dh;
  }
  if (sw > dw) {
    sw = dw;
  }

  /* this should be accompanied with normal drawing,
   * so 'dirty rectangle' shouldn't need updating.
   */
  mask = Image[HIT_MASK]->data + Screen->wd * y + x;
  doff = Screen->wd - sw;
  soff = bm->wd - sw;

  while (--sh >= 0) {

    dw = sw;
    while (--dw >= 0) {

      if (*src++) {
        *mask = value;
      }
      mask++;
    }

    mask += doff;
    src += soff;
  }
}


/* set horizontal are on given y of given height to background
 * pixels (used to clear text / menus)
 */
void img_bg(int y, int ht)
{
  m_uchar *dst, *mask;
  long offset, size;
  m_image_t **image;
  int wd;

#ifdef DEBUG
  if (y + ht > Screen->ht) {
    win_exit();
    fprintf(stderr, "img.c/img_bg(): illegal height!\n");
    exit(-1);
  }
#endif

  wd = Screen->wd;
  screen_dirty(0, y, wd, ht);

  offset = y * wd;
  dst = Screen->data + offset;

  image = &Image[0];
  mask = image[HIT_MASK]->data + offset;

  size = ht * wd;
  while (--size >= 0) {
#ifdef DEBUG
    if (*mask >= IMAGE_COUNT) {
      win_exit();
      fprintf(stderr, "img.c/img_bg(): called for non-bg area!\n");
      exit(-1);
    }
#endif
    *dst++ = image[*mask++]->data[offset++];
  }
}

/* clear whole screen to background image
 */
void img_cls(void)
{
  int wd, ht;
  long size;

  wd = Screen->wd;
  ht = Screen->ht;
  size = ht * wd;

  screen_dirty(0, 0, wd, ht);
  memset(Image[HIT_MASK]->data, HIT_BG, size);
  memcpy(Screen->data, Image[HIT_BG]->data, size);
}


/* draw generated hill (ground) to screen and mask
 */
int img_ground(void)
{
  register int wd, h;
  register m_uchar *src, *dst, *mask;
  m_uchar *screen_data, *bg_data, *ground_data, *mask_data;
  int level, idx, ht;
  short *ground;

  ht   = Screen->ht;
  wd   = Screen->wd;

  ground = range_ground();

  screen_data = Screen->data;
  bg_data = Image[HIT_BG]->data;
  mask_data = Image[HIT_MASK]->data;
  ground_data = Image[HIT_GROUND]->data;

  idx = wd;
  while (--idx >= 0) {

    mask = mask_data + idx;
    dst = screen_data + idx;
    src = bg_data + idx;

    h = level = ground[idx];
    while (--h >= 0) {
      *mask = HIT_BG;
      mask += wd;

      *dst = *src;
      src += wd;
      dst += wd;
    }

    src = ground_data + level * wd + idx;

    h = ht - level;
    while (--h >= 0) {
      *mask = HIT_GROUND;
      mask += wd;

      *dst = *src;
      src += wd;
      dst += wd;
    }
  }

  screen_dirty(0, 0, wd, ht);
  return 1;
}


/* level given strip of ground (for player),
 * y, x0 and x1 should be already clipped
 */
static void level_ground(int y0, int x0, int x1)
{
  m_uchar *mask, *pos;
  int x, y, wd, top;

  wd = Screen->wd;
  pos = Image[HIT_MASK]->data + y0 * wd + x0;
  top = y0;

  for (x = x1 - x0; --x >= 0; pos++) {
    mask = pos;
    y = y0;

    while (y >= 0 && *mask == HIT_GROUND) {
      *mask = HIT_BG;
      mask -= wd;
      y--;
    }
    if (y < top) {
      top = y + 1;
    }
  }

  screen_dirty(x0, top, x1, y0);
}

/* Checks whether given position is on the ground.  Returns immedietly if
 * HIT_OUT.  For HIT_EDGE counts how many 'hits' there are and modifies move
 * to avoid them.
 */
int img_drop(int x, int y, int r, m_pos_t *speed, m_pos_t *move)
{
  int count, wd, ht, a, b, dx;
  m_uchar *mask;

  wd = Screen->wd;
  ht = Screen->ht;

  x += move->x;
  if (x > r) {
    a = x - r;
  } else {
    if (x < 0) {
      /* more than half out of screen */
      return HIT_OUT;
    }
    a = 0;
  }
  if (x + r < wd) {
    b = x + r;
  } else {
    if (x >= wd) {
      /* more than half out of screen */
      return HIT_OUT;
    }
    b = wd - 1;
  }

  y += move->y;
  if (y >= ht) {
    /* drop off the bottom */
    return HIT_OUT;
  }

  mask = Image[HIT_MASK]->data + y * wd + x;

  /* middle */
  if (*mask == HIT_GROUND) {
    level_ground(y, a, b);
    return HIT_GROUND;
  }
  dx = 0;

  /* left side */
  count = x - a;
  mask -= count;
  while (--count >= 0) {
    if (*mask++ == HIT_GROUND) {
      dx++;
    }
  }

  /* right side */
  count = b - x;
  mask += count;
  while (--count >= 0) {
    if (*mask-- == HIT_GROUND) {
      if (dx > 0) {
        level_ground(y, a, b);
        return HIT_GROUND;
      }
      dx--;
    }
  }
  if (!dx) {
    /* free fall */
    return HIT_BG;
  }
  move->x += dx;
  a += dx;
  b += dx;

  /* check whether bounced against supporting ground */
  if (dx < 0) {

    mask -= x - a;
    count = -dx;
    while (--count >= 0) {
      if (*mask++ == HIT_GROUND) {
        level_ground(y, a, b);
        return HIT_GROUND;
      }
    }
  } else {

    mask += b - x;
    count = dx;
    while (--count >= 0) {
      if (*mask-- == HIT_GROUND) {
        level_ground(y, a, b);
        return HIT_GROUND;
      }
    }
  }

  /* just bounced sidewise */
  speed->x = dx;
  return HIT_EDGE;
}
