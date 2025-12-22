/***********************************************************
* Mirror Magic -- McDuffin's Revenge                       *
*----------------------------------------------------------*
* (c) 1994-2001 Artsoft Entertainment                      *
*               Holger Schemel                             *
*               Detmolder Strasse 189                      *
*               33604 Bielefeld                            *
*               Germany                                    *
*               e-mail: info@artsoft.org                   *
*----------------------------------------------------------*
* tools.c                                                  *
***********************************************************/

#include <stdarg.h>

#ifdef __FreeBSD__
#include <machine/joystick.h>
#endif

#include "libgame/libgame.h"

#include "tools.h"
#include "game.h"
#include "events.h"
#include "cartoons.h"

#ifdef MSDOS
extern boolean wait_for_vsync;
#endif

/* tool button identifiers */
#define TOOL_CTRL_ID_YES	0
#define TOOL_CTRL_ID_NO		1
#define TOOL_CTRL_ID_CONFIRM	2

#define NUM_TOOL_BUTTONS	3

/* forward declaration for internal use */
static int getGraphicAnimationPhase(int, int, int);
static void UnmapToolButtons();
static void HandleToolButtons(struct GadgetInfo *);

static struct GadgetInfo *tool_gadget[NUM_TOOL_BUTTONS];
static int request_gadget_id = -1;

void SetDrawtoField(int mode)
{
  /* DRAW_DIRECT, DRAW_BACKBUFFER */

  FX = SX;
  FY = SY;
  BX1 = 0;
  BY1 = 0;
  BX2 = SCR_FIELDX - 1;
  BY2 = SCR_FIELDY - 1;
  redraw_x1 = 0;
  redraw_y1 = 0;

  drawto_field = backbuffer;
}

void BackToFront()
{
  int x,y;
  DrawBuffer *buffer = drawto_field;

  if (redraw_mask & REDRAW_TILES && redraw_tiles > REDRAWTILES_THRESHOLD)
    redraw_mask |= REDRAW_FIELD;

  if (redraw_mask & REDRAW_FIELD)
    redraw_mask &= ~REDRAW_TILES;

  if (!redraw_mask)
    return;

  if (global.fps_slowdown && game_status == PLAYING)
  {
    static boolean last_frame_skipped = FALSE;
    boolean skip_even_when_not_scrolling = TRUE;
    boolean just_scrolling = (ScreenMovDir != 0);
    boolean verbose = FALSE;

    if (global.fps_slowdown_factor > 1 &&
	(FrameCounter % global.fps_slowdown_factor) &&
	(just_scrolling || skip_even_when_not_scrolling))
    {
      redraw_mask &= ~REDRAW_MAIN;

      last_frame_skipped = TRUE;

      if (verbose)
	printf("FRAME SKIPPED\n");
    }
    else
    {
      if (last_frame_skipped)
	redraw_mask |= REDRAW_FIELD;

      last_frame_skipped = FALSE;

      if (verbose)
	printf("frame not skipped\n");
    }
  }

  /* synchronize X11 graphics at this point; if we would synchronize the
     display immediately after the buffer switching (after the XFlush),
     this could mean that we have to wait for the graphics to complete,
     although we could go on doing calculations for the next frame */

  SyncDisplay();

  if (redraw_mask & REDRAW_ALL)
  {
    BlitBitmap(backbuffer, window, 0, 0, WIN_XSIZE, WIN_YSIZE, 0, 0);
    redraw_mask = 0;
  }

  if (redraw_mask & REDRAW_FIELD)
  {
    BlitBitmap(backbuffer, window,
	       REAL_SX, REAL_SY, FULL_SXSIZE, FULL_SYSIZE, REAL_SX, REAL_SY);

    redraw_mask &= ~REDRAW_MAIN;
  }

  if (redraw_mask & REDRAW_DOORS)
  {
    if (redraw_mask & REDRAW_DOOR_1)
      BlitBitmap(backbuffer, window, DX, DY, DXSIZE, DYSIZE, DX, DY);
    redraw_mask &= ~REDRAW_DOORS;
  }

  if (redraw_mask & REDRAW_MICROLEVEL)
  {
    BlitBitmap(backbuffer, window,
	       MICROLEV_XPOS, MICROLEV_YPOS, MICROLEV_XSIZE, MICROLEV_YSIZE,
	       MICROLEV_XPOS, MICROLEV_YPOS);

    redraw_mask &= ~REDRAW_MICROLEVEL;
  }

  if (redraw_mask & REDRAW_MICROLABEL)
  {
    BlitBitmap(backbuffer, window,
	       MICROLABEL_XPOS, MICROLABEL_YPOS,
	       MICROLABEL_XSIZE, MICROLABEL_YSIZE,
	       MICROLABEL_XPOS, MICROLABEL_YPOS);

    redraw_mask &= ~REDRAW_MICROLABEL;
  }

  if (redraw_mask & REDRAW_TILES)
  {
    for(x=0; x<SCR_FIELDX; x++)
      for(y=0; y<SCR_FIELDY; y++)
	if (redraw[redraw_x1 + x][redraw_y1 + y])
	  BlitBitmap(buffer, window,
		     FX + x * TILEX, FX + y * TILEY, TILEX, TILEY,
		     SX + x * TILEX, SY + y * TILEY);
  }

  if (redraw_mask & REDRAW_FPS)		/* display frames per second */
  {
    char text[100];
    char info1[100];

    sprintf(info1, " (only every %d. frame)", global.fps_slowdown_factor);
    if (!global.fps_slowdown)
      info1[0] = '\0';

    sprintf(text, "%.1f fps%s", global.frames_per_second, info1);
    DrawTextExt(window, SX, SY, text, FS_SMALL, FC_YELLOW);
  }

  FlushDisplay();

  for(x=0; x<MAX_BUF_XSIZE; x++)
    for(y=0; y<MAX_BUF_YSIZE; y++)
      redraw[x][y] = 0;
  redraw_tiles = 0;
  redraw_mask = 0;
}

void FadeToFront()
{
#if 0
  long fading_delay = 300;

  if (setup.fading && (redraw_mask & REDRAW_FIELD))
  {
#endif

#if 0
    int x,y;

    ClearRectangle(window, REAL_SX,REAL_SY,FULL_SXSIZE,FULL_SYSIZE);
    FlushDisplay();

    for(i=0;i<2*FULL_SYSIZE;i++)
    {
      for(y=0;y<FULL_SYSIZE;y++)
      {
	BlitBitmap(backbuffer, window,
		   REAL_SX,REAL_SY+i, FULL_SXSIZE,1, REAL_SX,REAL_SY+i);
      }
      FlushDisplay();
      Delay(10);
    }
#endif

#if 0
    for(i=1;i<FULL_SYSIZE;i+=2)
      BlitBitmap(backbuffer, window,
		 REAL_SX,REAL_SY+i, FULL_SXSIZE,1, REAL_SX,REAL_SY+i);
    FlushDisplay();
    Delay(fading_delay);
#endif

#if 0
    SetClipOrigin(clip_gc[PIX_FADEMASK], 0, 0);
    BlitBitmapMasked(backbuffer, window,
		     REAL_SX,REAL_SY, FULL_SXSIZE,FULL_SYSIZE,
		     REAL_SX,REAL_SY);
    FlushDisplay();
    Delay(fading_delay);

    SetClipOrigin(clip_gc[PIX_FADEMASK], -1, -1);
    BlitBitmapMasked(backbuffer, window,
		     REAL_SX,REAL_SY, FULL_SXSIZE,FULL_SYSIZE,
		     REAL_SX,REAL_SY);
    FlushDisplay();
    Delay(fading_delay);

    SetClipOrigin(clip_gc[PIX_FADEMASK], 0, -1);
    BlitBitmapMasked(backbuffer, window,
		     REAL_SX,REAL_SY, FULL_SXSIZE,FULL_SYSIZE,
		     REAL_SX,REAL_SY);
    FlushDisplay();
    Delay(fading_delay);

    SetClipOrigin(clip_gc[PIX_FADEMASK], -1, 0);
    BlitBitmapMasked(backbuffer, window,
		     REAL_SX,REAL_SY, FULL_SXSIZE,FULL_SYSIZE,
		     REAL_SX,REAL_SY);
    FlushDisplay();
    Delay(fading_delay);

    redraw_mask &= ~REDRAW_MAIN;
  }
#endif

  BackToFront();
}

void ClearWindow()
{
  ClearRectangle(backbuffer, REAL_SX, REAL_SY, FULL_SXSIZE, FULL_SYSIZE);

  SetDrawtoField(DRAW_BACKBUFFER);

  redraw_mask |= REDRAW_FIELD;
}

void MarkTileDirty(int x, int y)
{
  int xx = redraw_x1 + x;
  int yy = redraw_y1 + y;

  if (!redraw[xx][yy])
    redraw_tiles++;

  redraw[xx][yy] = TRUE;
  redraw_mask |= REDRAW_TILES;
}

static int getGraphicAnimationPhase(int frames, int delay, int mode)
{
  int phase;

  if (mode == ANIM_OSCILLATE)
  {
    int max_anim_frames = 2 * frames - 2;
    phase = (FrameCounter % (delay * max_anim_frames)) / delay;
    phase = (phase < frames ? phase : max_anim_frames - phase);
  }
  else
    phase = (FrameCounter % (delay * frames)) / delay;

  if (mode == ANIM_REVERSE)
    phase = -phase;

  return(phase);
}

void DrawGraphicAnimationExt(int x, int y, int graphic,
			     int frames, int delay, int mode, int mask_mode)
{
  int phase = getGraphicAnimationPhase(frames, delay, mode);

  if (!(FrameCounter % delay) && IN_SCR_FIELD(SCREENX(x), SCREENY(y)))
  {
    if (mask_mode == USE_MASKING)
      DrawGraphicThruMask(SCREENX(x), SCREENY(y), graphic + phase);
    else
      DrawGraphic(SCREENX(x), SCREENY(y), graphic + phase);
  }
}

void DrawGraphicAnimation(int x, int y, int graphic,
			  int frames, int delay, int mode)
{
  DrawGraphicAnimationExt(x, y, graphic, frames, delay, mode, NO_MASKING);
}

void DrawGraphicAnimationThruMask(int x, int y, int graphic,
				  int frames, int delay, int mode)
{
  DrawGraphicAnimationExt(x, y, graphic, frames, delay, mode, USE_MASKING);
}

void getGraphicSource(int graphic, int *bitmap_nr, int *x, int *y)
{
  if (graphic >= GFX_START_MIRRORSCREEN && graphic <= GFX_END_MIRRORSCREEN)
  {
    graphic -= GFX_START_MIRRORSCREEN;
    *bitmap_nr = PIX_BACK;
    *x = SX + (graphic % GFX_PER_LINE) * TILEX;
    *y = SY + (graphic / GFX_PER_LINE) * TILEY;
  }
  else if (graphic >= GFX_START_MIRRORFONT && graphic <= GFX_END_MIRRORFONT)
  {
    graphic -= GFX_START_MIRRORFONT;
    *bitmap_nr = PIX_BIGFONT;
    *x = (graphic % FONT_CHARS_PER_LINE) * TILEX;
    *y = ((graphic / FONT_CHARS_PER_LINE) * TILEY +
	  FC_SPECIAL1 * FONT_LINES_PER_FONT * TILEY);
  }
  else if (graphic >= GFX_START_MIRRORDF && graphic <= GFX_END_MIRRORDF)
  {
    graphic -= GFX_START_MIRRORDF;
    *bitmap_nr = PIX_DF;
    *x = (graphic % DF_PER_LINE) * TILEX;
    *y = (graphic / DF_PER_LINE) * TILEY;
  }
  else
  {
    *bitmap_nr = PIX_BIGFONT;
    *x = 0;
    *y = 0;
  }
}

void DrawGraphic(int x, int y, int graphic)
{
#if DEBUG
  if (!IN_SCR_FIELD(x,y))
  {
    printf("DrawGraphic(): x = %d, y = %d, graphic = %d\n",x,y,graphic);
    printf("DrawGraphic(): This should never happen!\n");

#if 1
    {
      int i=0;
      i=i/i;
    }
#endif

    return;
  }
#endif

  DrawGraphicExt(drawto_field, FX + x*TILEX, FY + y*TILEY, graphic);
  MarkTileDirty(x, y);
}

void DrawGraphicExt(DrawBuffer *d, int x, int y, int graphic)
{
  int bitmap_nr;
  int src_x, src_y;

  getGraphicSource(graphic, &bitmap_nr, &src_x, &src_y);
  BlitBitmap(pix[bitmap_nr], d, src_x, src_y, TILEX, TILEY, x, y);
}

void DrawGraphicThruMask(int x, int y, int graphic)
{
#if DEBUG
  if (!IN_SCR_FIELD(x,y))
  {
    printf("DrawGraphicThruMask(): x = %d,y = %d, graphic = %d\n",x,y,graphic);
    printf("DrawGraphicThruMask(): This should never happen!\n");
    return;
  }
#endif

  DrawGraphicThruMaskExt(drawto_field, FX + x*TILEX, FY + y*TILEY, graphic);
  MarkTileDirty(x,y);
}

void DrawGraphicThruMaskExt(DrawBuffer *d, int dest_x, int dest_y, int graphic)
{
  int tile = graphic;
  int bitmap_nr;
  int src_x, src_y;
  Bitmap *src_bitmap;
  GC drawing_gc;

  if (graphic == GFX_EMPTY)
    return;

  getGraphicSource(graphic, &bitmap_nr, &src_x, &src_y);
  src_bitmap = pix[bitmap_nr];
  drawing_gc = pix[bitmap_nr]->stored_clip_gc;

  if (tile_clipmask[tile] != None)
  {
    SetClipMask(src_bitmap, tile_clip_gc, tile_clipmask[tile]);
    SetClipOrigin(src_bitmap, tile_clip_gc, dest_x, dest_y);
    BlitBitmapMasked(src_bitmap, d,
		     src_x, src_y, TILEX, TILEY, dest_x, dest_y);
  }
  else
  {
#if DEBUG
#ifndef TARGET_SDL
    printf("DrawGraphicThruMask(): tile '%d' needs clipping!\n", tile);
#endif
#endif

    SetClipOrigin(src_bitmap, drawing_gc, dest_x-src_x, dest_y-src_y);
    BlitBitmapMasked(src_bitmap, d,
		     src_x, src_y, TILEX, TILEY, dest_x, dest_y);
  }
}

void DrawMiniGraphic(int x, int y, int graphic)
{
  DrawMiniGraphicExt(drawto, SX + x*MINI_TILEX, SY + y*MINI_TILEY, graphic);
  MarkTileDirty(x/2, y/2);
}

void getMiniGraphicSource(int graphic, Bitmap **bitmap, int *x, int *y)
{
  if (graphic >= GFX_START_MIRRORSCREEN && graphic <= GFX_END_MIRRORSCREEN)
  {
    graphic -= GFX_START_MIRRORSCREEN;
    *bitmap = pix[PIX_BACK];
    *x = MINI_GFX_STARTX + (graphic % MINI_GFX_PER_LINE) * MINI_TILEX;
    *y = MINI_GFX_STARTY + (graphic / MINI_GFX_PER_LINE) * MINI_TILEY;
  }
  else if (graphic >= GFX_START_PSEUDO && graphic <= GFX_END_PSEUDO)
  {
    if (graphic == GFX_DF_WALL_STEEL || graphic == GFX_DF_WALL_WOOD)
    {
      int graphic2 = GFX_DF_WALL_SEVERAL - GFX_START_MIRRORDF;
      *bitmap = pix[PIX_DF];
      *x = (graphic2 % DF_PER_LINE) * TILEX;
      *y = (graphic2 / DF_PER_LINE) * TILEY;

      if (graphic == GFX_DF_WALL_WOOD)
	*x += MINI_TILEX;
    }
    else
    {
      int graphic2 = GFX_WALL_SEVERAL - GFX_START_MIRRORSCREEN;
      *bitmap = pix[PIX_BACK];
      *x = GFX_STARTX + (graphic2 % GFX_PER_LINE) * TILEX;
      *y = GFX_STARTY + (graphic2 / GFX_PER_LINE) * TILEY;

      if (graphic == GFX_WALL_WOOD || graphic == GFX_WALL_AMOEBA)
	*x += MINI_TILEX;
      if (graphic == GFX_WALL_ICE || graphic == GFX_WALL_AMOEBA)
	*y += MINI_TILEY;
    }
  }
  else if (graphic >= GFX_START_MIRRORFONT && graphic <= GFX_END_MIRRORFONT)
  {
    graphic -= GFX_START_MIRRORFONT;
    *bitmap = pix[PIX_SMALLFONT];
    *x = (graphic % FONT_CHARS_PER_LINE) * FONT4_XSIZE;
    *y = ((graphic / FONT_CHARS_PER_LINE) * FONT4_YSIZE +
	      FC_SPECIAL2 * FONT2_YSIZE * FONT_LINES_PER_FONT);
  }
  else if (graphic >= GFX_START_MIRRORDF && graphic <= GFX_END_MIRRORDF)
  {
    graphic -= GFX_START_MIRRORDF;
    *bitmap = pix[PIX_DF];
    *x = MINI_DF_STARTX + (graphic % MINI_DF_PER_LINE) * MINI_TILEX;
    *y = MINI_DF_STARTY + (graphic / MINI_DF_PER_LINE) * MINI_TILEY;
  }
  else
  {
    *bitmap = pix[PIX_BIGFONT];
    *x = 0;
    *y = 0;
  }
}

void getMicroGraphicSource(int graphic, Bitmap **bitmap, int *x, int *y)
{
  if (graphic >= GFX_START_MIRRORSCREEN && graphic <= GFX_END_MIRRORSCREEN)
  {
    graphic -= GFX_START_MIRRORSCREEN;
    *bitmap = pix[PIX_BACK];
    *x = MICRO_GFX_STARTX + (graphic % MICRO_GFX_PER_LINE) * MICRO_TILEX;
    *y = MICRO_GFX_STARTY + (graphic / MICRO_GFX_PER_LINE) * MICRO_TILEY;
  }
  else if (graphic >= GFX_START_PSEUDO && graphic <= GFX_END_PSEUDO)
  {
    if (graphic == GFX_DF_WALL_STEEL || graphic == GFX_DF_WALL_WOOD)
    {
      int graphic2 = GFX_DF_WALL_SEVERAL - GFX_START_MIRRORDF;
      *bitmap = pix[PIX_DF];
      *x = MICRO_DF_STARTX + (graphic2 % MICRO_DF_PER_LINE) * MICRO_TILEX;
      *y = MICRO_DF_STARTY + (graphic2 / MICRO_DF_PER_LINE) * MICRO_TILEY;

      if (graphic == GFX_DF_WALL_WOOD)
	*x += MICRO_WALLX;
    }
    else
    {
      int graphic2 = GFX_WALL_SEVERAL - GFX_START_MIRRORSCREEN;
      *bitmap = pix[PIX_BACK];
      *x = MICRO_GFX_STARTX + (graphic2 % MICRO_GFX_PER_LINE) * MICRO_TILEX;
      *y = MICRO_GFX_STARTY + (graphic2 / MICRO_GFX_PER_LINE) * MICRO_TILEY;

      if (graphic == GFX_WALL_WOOD || graphic == GFX_WALL_AMOEBA)
	*x += MICRO_WALLX;
      if (graphic == GFX_WALL_ICE || graphic == GFX_WALL_AMOEBA)
	*y += MICRO_WALLY;
    }
  }
  else if (graphic >= GFX_START_MIRRORFONT && graphic <= GFX_END_MIRRORFONT)
  {
    graphic -= GFX_START_MIRRORFONT;
    *bitmap = pix[PIX_DF];
    *x = MICRO_FONT_STARTX + (graphic % MICRO_FONT_PER_LINE) * MICRO_TILEX;
    *y = MICRO_FONT_STARTY + (graphic / MICRO_FONT_PER_LINE) * MICRO_TILEY;
  }
  else if (graphic >= GFX_START_MIRRORDF && graphic <= GFX_END_MIRRORDF)
  {
    graphic -= GFX_START_MIRRORDF;
    *bitmap = pix[PIX_DF];
    *x = MICRO_DF_STARTX + (graphic % MICRO_DF_PER_LINE) * MICRO_TILEX;
    *y = MICRO_DF_STARTY + (graphic / MICRO_DF_PER_LINE) * MICRO_TILEY;
  }
  else
  {
    *bitmap = pix[PIX_BIGFONT];
    *x = 0;
    *y = 0;
  }
}

void DrawMiniGraphicExt(DrawBuffer *d, int x, int y, int graphic)
{
  Bitmap *bitmap;
  int src_x, src_y;

  getMiniGraphicSource(graphic, &bitmap, &src_x, &src_y);
  BlitBitmap(bitmap, d, src_x, src_y, MINI_TILEX, MINI_TILEY, x, y);
}

void DrawGraphicShifted(int x,int y, int dx,int dy, int graphic,
			int cut_mode, int mask_mode)
{
  int width = TILEX, height = TILEY;
  int cx = 0, cy = 0;
  int src_x, src_y, dest_x, dest_y;
  int tile = graphic;
  int bitmap_nr;
  Bitmap *src_bitmap;
  GC drawing_gc;

  if (graphic < 0)
  {
    DrawGraphic(x, y, graphic);
    return;
  }

  if (dx || dy)			/* Verschiebung der Grafik? */
  {
    if (x < BX1)		/* Element kommt von links ins Bild */
    {
      x = BX1;
      width = dx;
      cx = TILEX - dx;
      dx = 0;
    }
    else if (x > BX2)		/* Element kommt von rechts ins Bild */
    {
      x = BX2;
      width = -dx;
      dx = TILEX + dx;
    }
    else if (x==BX1 && dx < 0)	/* Element verl‰ﬂt links das Bild */
    {
      width += dx;
      cx = -dx;
      dx = 0;
    }
    else if (x==BX2 && dx > 0)	/* Element verl‰ﬂt rechts das Bild */
      width -= dx;
    else if (dx)		/* allg. Bewegung in x-Richtung */
      MarkTileDirty(x + SIGN(dx), y);

    if (y < BY1)		/* Element kommt von oben ins Bild */
    {
      if (cut_mode==CUT_BELOW)	/* Element oberhalb des Bildes */
	return;

      y = BY1;
      height = dy;
      cy = TILEY - dy;
      dy = 0;
    }
    else if (y > BY2)		/* Element kommt von unten ins Bild */
    {
      y = BY2;
      height = -dy;
      dy = TILEY + dy;
    }
    else if (y==BY1 && dy < 0)	/* Element verl‰ﬂt oben das Bild */
    {
      height += dy;
      cy = -dy;
      dy = 0;
    }
    else if (dy > 0 && cut_mode == CUT_ABOVE)
    {
      if (y == BY2)		/* Element unterhalb des Bildes */
	return;

      height = dy;
      cy = TILEY - dy;
      dy = TILEY;
      MarkTileDirty(x, y + 1);
    }				/* Element verl‰ﬂt unten das Bild */
    else if (dy > 0 && (y == BY2 || cut_mode == CUT_BELOW))
      height -= dy;
    else if (dy)		/* allg. Bewegung in y-Richtung */
      MarkTileDirty(x, y + SIGN(dy));
  }

  getGraphicSource(graphic, &bitmap_nr, &src_x, &src_y);
  src_bitmap = pix[bitmap_nr];
  drawing_gc = pix[bitmap_nr]->stored_clip_gc;

  src_x += cx;
  src_y += cy;

  dest_x = FX + x * TILEX + dx;
  dest_y = FY + y * TILEY + dy;

#if DEBUG
  if (!IN_SCR_FIELD(x,y))
  {
    printf("DrawGraphicShifted(): x = %d, y = %d, graphic = %d\n",x,y,graphic);
    printf("DrawGraphicShifted(): This should never happen!\n");
    return;
  }
#endif

  if (mask_mode == USE_MASKING)
  {
    if (tile_clipmask[tile] != None)
    {
      SetClipMask(src_bitmap, tile_clip_gc, tile_clipmask[tile]);
      SetClipOrigin(src_bitmap, tile_clip_gc, dest_x, dest_y);
      BlitBitmapMasked(src_bitmap, drawto_field,
		       src_x, src_y, TILEX, TILEY, dest_x, dest_y);
    }
    else
    {
#if DEBUG
#ifndef	TARGET_SDL
      printf("DrawGraphicShifted(): tile '%d' needs clipping!\n", tile);
#endif
#endif

      SetClipOrigin(src_bitmap, drawing_gc, dest_x - src_x, dest_y - src_y);
      BlitBitmapMasked(src_bitmap, drawto_field,
		       src_x, src_y, width, height, dest_x, dest_y);
    }
  }
  else
    BlitBitmap(pix[bitmap_nr], drawto_field,
	       src_x, src_y, width, height, dest_x, dest_y);

  MarkTileDirty(x,y);
}

void DrawGraphicShiftedThruMask(int x,int y, int dx,int dy, int graphic,
				int cut_mode)
{
  DrawGraphicShifted(x,y, dx,dy, graphic, cut_mode, USE_MASKING);
}

void DrawScreenElementExt(int x, int y, int dx, int dy, int element,
			  int cut_mode, int mask_mode)
{
  int ux = LEVELX(x), uy = LEVELY(y);
  int graphic = el2gfx(element);
  int phase8 = ABS(MovPos[ux][uy]) / (TILEX / 8);
  int phase2  = phase8 / 4;
  int dir = MovDir[ux][uy];

  if (element == EL_PACMAN)
  {
    graphic += 4 * !phase2;

    if (dir == MV_UP)
      graphic += 1;
    else if (dir == MV_LEFT)
      graphic += 2;
    else if (dir == MV_DOWN)
      graphic += 3;
  }

  if (dx || dy)
    DrawGraphicShifted(x, y, dx, dy, graphic, cut_mode, mask_mode);
  else if (mask_mode == USE_MASKING)
    DrawGraphicThruMask(x, y, graphic);
  else
    DrawGraphic(x, y, graphic);
}

void DrawLevelElementExt(int x, int y, int dx, int dy, int element,
			 int cut_mode, int mask_mode)
{
  if (IN_LEV_FIELD(x, y) && IN_SCR_FIELD(SCREENX(x), SCREENY(y)))
    DrawScreenElementExt(SCREENX(x), SCREENY(y), dx, dy, element,
			 cut_mode, mask_mode);
}

void DrawScreenElementShifted(int x, int y, int dx, int dy, int element,
			      int cut_mode)
{
  DrawScreenElementExt(x, y, dx, dy, element, cut_mode, NO_MASKING);
}

void DrawLevelElementShifted(int x, int y, int dx, int dy, int element,
			     int cut_mode)
{
  DrawLevelElementExt(x, y, dx, dy, element, cut_mode, NO_MASKING);
}

void DrawScreenElementThruMask(int x, int y, int element)
{
  DrawScreenElementExt(x, y, 0, 0, element, NO_CUTTING, USE_MASKING);
}

void DrawLevelElementThruMask(int x, int y, int element)
{
  DrawLevelElementExt(x, y, 0, 0, element, NO_CUTTING, USE_MASKING);
}

void DrawLevelFieldThruMask(int x, int y)
{
  DrawLevelElementExt(x, y, 0, 0, Feld[x][y], NO_CUTTING, USE_MASKING);
}

void DrawScreenElement(int x, int y, int element)
{
  DrawScreenElementExt(x, y, 0, 0, element, NO_CUTTING, NO_MASKING);
}

void DrawLevelElement(int x, int y, int element)
{
  if (IN_LEV_FIELD(x, y) && IN_SCR_FIELD(SCREENX(x), SCREENY(y)))
    DrawScreenElement(SCREENX(x), SCREENY(y), element);
}

void DrawScreenField(int x, int y)
{
  int element = Feld[x][y];

  if (!IN_LEV_FIELD(x, y))
    return;

  if (IS_MOVING(x, y))
  {
    int horiz_move = (MovDir[x][y] == MV_LEFT || MovDir[x][y] == MV_RIGHT);

    DrawScreenElement(x, y, EL_EMPTY);

    if (horiz_move)
      DrawScreenElementShifted(x, y, MovPos[x][y], 0, element, NO_CUTTING);
    else
      DrawScreenElementShifted(x, y, 0, MovPos[x][y], element, NO_CUTTING);
  }
  else if (IS_BLOCKED(x, y))
  {
    int oldx, oldy;
    int sx, sy;
    int horiz_move;

    Blocked2Moving(x, y, &oldx, &oldy);
    sx = SCREENX(oldx);
    sy = SCREENY(oldy);
    horiz_move = (MovDir[oldx][oldy] == MV_LEFT ||
		  MovDir[oldx][oldy] == MV_RIGHT);

    DrawScreenElement(x, y, EL_EMPTY);
    element = Feld[oldx][oldy];

    if (horiz_move)
      DrawScreenElementShifted(sx,sy, MovPos[oldx][oldy],0,element,NO_CUTTING);
    else
      DrawScreenElementShifted(sx,sy, 0,MovPos[oldx][oldy],element,NO_CUTTING);
  }
  else if (IS_DRAWABLE(element))
    DrawScreenElement(x, y, element);
  else
    DrawScreenElement(x, y, EL_EMPTY);
}

void DrawLevelField(int x, int y)
{
  DrawScreenField(x, y);
}

void DrawMiniElement(int x, int y, int element)
{
  int graphic;

  if (!element)
  {
    DrawMiniGraphic(x, y, GFX_EMPTY);
    return;
  }

  graphic = el2gfx(element);
  DrawMiniGraphic(x, y, graphic);
}

void DrawMiniElementOrWall(int sx, int sy, int scroll_x, int scroll_y)
{
  int x = sx + scroll_x, y = sy + scroll_y;

  if (x < -1 || x > lev_fieldx || y < -1 || y > lev_fieldy)
    DrawMiniElement(sx, sy, EL_EMPTY);
  else if (x > -1 && x < lev_fieldx && y > -1 && y < lev_fieldy)
    DrawMiniElement(sx, sy, Feld[x][y]);
}


#if 0
void DrawMicroElement(int xpos, int ypos, int element)
{
  int graphic;

  if (element == EL_LEERRAUM)
    return;

  graphic = el2gfx(element);

  BlitBitmap(pix[PIX_BACK], drawto,
	     MICRO_GFX_STARTX + (graphic % MICRO_GFX_PER_LINE) * MICRO_TILEX,
	     MICRO_GFX_STARTY + (graphic / MICRO_GFX_PER_LINE) * MICRO_TILEY,
	     MICRO_TILEX, MICRO_TILEY, xpos, ypos);
}

void DrawLevel()
{
  int x,y;

  ClearWindow();

  for(x=BX1; x<=BX2; x++)
    for(y=BY1; y<=BY2; y++)
      DrawScreenField(x, y);

  redraw_mask |= REDRAW_FIELD;
}
#endif

void DrawField(int x, int y)
{
  int element = Feld[x][y];

  DrawElement(x, y, element);
}

void DrawLevel()
{
  int x,y;

  ClearWindow();

  for (x=0; x<lev_fieldx; x++)
    for (y=0; y<lev_fieldy; y++)
      DrawField(x, y);

  redraw_mask |= REDRAW_FIELD;
}

void DrawWallsExt(int x, int y, int element, int draw_mask)
{
  Bitmap *bitmap;
  int graphic = el2gfx(WALL_BASE(element));
  int gx, gy;
  int i;

  getMiniGraphicSource(graphic, &bitmap, &gx, &gy);

  if (game_status != LEVELED || !editor.draw_walls_masked)
    DrawGraphic(x, y, GFX_EMPTY);

  /*
  if (IS_WALL_WOOD(element) || IS_WALL_AMOEBA(element) ||
      IS_DF_WALL_WOOD(element))
    gx += MINI_TILEX;
  if (IS_WALL_ICE(element) || IS_WALL_AMOEBA(element))
    gy += MINI_TILEY;
  */

  for(i=0; i<4; i++)
  {
    int dest_x = SX + x * TILEX + MINI_TILEX * (i % 2);
    int dest_y = SY + y * TILEY + MINI_TILEY * (i / 2);

    if (!((1 << i) & draw_mask))
      continue;

    if (element & (1 << i))
      BlitBitmap(bitmap, drawto, gx, gy, MINI_TILEX, MINI_TILEY,
		 dest_x, dest_y);
    else if (!editor.draw_walls_masked)
      ClearRectangle(drawto, dest_x, dest_y, MINI_TILEX, MINI_TILEY);
  }

  MarkTileDirty(x, y);
}

void DrawWalls(int x, int y, int element)
{
  DrawWallsExt(x, y, element, HIT_MASK_ALL);
}

void DrawWallsAnimation(int x, int y, int element, int phase, int bit_mask)
{
  int graphic = GFX_WALL_SEVERAL;
  int graphic_anim = graphic + (phase + 1) / 2;
  int dx = (IS_WALL_AMOEBA(element) ? MINI_TILEX : 0);
  int dy = MINI_TILEY;
  int dx_anim = dx;
  int dy_anim = ((phase + 1) % 2) * MINI_TILEY;
  int i;
  
  if (phase == 0) 
  {
    DrawWalls(x, y, element);
    return;
  }

  for(i=0; i<4; i++)
  {
    if (element & (1 << i))
    {
      int dest_x = SX + x * TILEX + MINI_TILEX * (i % 2);
      int dest_y = SY + y * TILEY + MINI_TILEY * (i / 2);
      int gx, gy;

      if (bit_mask & (1 << i)) 
      {
	gx = SX + ((graphic_anim) % GFX_PER_LINE) * TILEX + dx_anim;
	gy = SY + ((graphic_anim) / GFX_PER_LINE) * TILEY + dy_anim;
      }
      else
      {
	gx = SX + (graphic % GFX_PER_LINE) * TILEX + dx;
	gy = SY + (graphic / GFX_PER_LINE) * TILEY + dy;
      }

      BlitBitmap(pix[PIX_BACK], drawto, gx, gy, MINI_TILEX, MINI_TILEY,
		 dest_x, dest_y);
    }
  }

  MarkTileDirty(x, y);
}

void DrawElement(int x, int y, int element)
{
  if (element == EL_EMPTY)
    DrawGraphic(x, y, GFX_EMPTY);
  else if (IS_WALL(element))
    DrawWalls(x, y, element); 
#if 0
  else if (IS_WALL_CHANGING(element) && IS_WALL_CHANGING(Feld[x][y]))
  {
    int wall_element = Feld[x][y] - EL_WALL_CHANGING + Store[x][y];

    DrawWalls(x, y, wall_element); 
  }
#endif
  else if (element == EL_PACMAN)
    DrawLevelField(x, y); 
  else
    DrawGraphic(x, y, el2gfx(element));
}

void DrawMicroWalls(int x, int y, int element)
{
  Bitmap *bitmap;
  int graphic = el2gfx(WALL_BASE(element));
  int gx, gy;
  int i;

  getMicroGraphicSource(graphic, &bitmap, &gx, &gy);

  for (i=0; i<4; i++)
  {
    int xpos = MICROLEV_XPOS + x * MICRO_TILEX + MICRO_WALLX * (i % 2);
    int ypos = MICROLEV_YPOS + y * MICRO_TILEY + MICRO_WALLY * (i / 2);

    if (element & (1 << i))
      BlitBitmap(bitmap, drawto, gx, gy, MICRO_WALLX, MICRO_WALLY, xpos, ypos);
    else
      ClearRectangle(drawto, xpos, ypos, MICRO_WALLX, MICRO_WALLY);
  }
}

void DrawMicroElement(int x, int y, int element)
{
  Bitmap *bitmap;
  int graphic = el2gfx(element);
  int gx, gy;

  if (element == EL_EMPTY)
    return;

  if (IS_WALL(element))
  {
    DrawMicroWalls(x, y, element); 
    return; 
  }

  getMicroGraphicSource(graphic, &bitmap, &gx, &gy);

  BlitBitmap(bitmap, drawto, gx, gy, MICRO_TILEX, MICRO_TILEY,
	     MICROLEV_XPOS + x * MICRO_TILEX, MICROLEV_YPOS + y * MICRO_TILEY);
}

void DrawMicroLevelExt(int xpos, int ypos)
{
  int x,y;

  ClearRectangle(drawto, xpos, ypos, MICROLEV_XSIZE, MICROLEV_YSIZE);

  for (x=0; x<STD_LEV_FIELDX; x++)
    for (y=0; y<STD_LEV_FIELDY; y++)
      DrawMicroElement(x, y, Ur[x][y]);

  redraw_mask |= REDRAW_MICROLEVEL;
}

void DrawMiniLevel(int size_x, int size_y, int scroll_x, int scroll_y)
{
  int x,y;

  for(x=0; x<size_x; x++)
    for(y=0; y<size_y; y++)
      DrawMiniElementOrWall(x, y, scroll_x, scroll_y);

  redraw_mask |= REDRAW_FIELD;
}

#define MICROLABEL_EMPTY		0
#define MICROLABEL_LEVEL_NAME		1
#define MICROLABEL_CREATED_BY		2
#define MICROLABEL_LEVEL_AUTHOR		3
#define MICROLABEL_IMPORTED_FROM	4
#define MICROLABEL_LEVEL_IMPORT_INFO	5

#define MAX_MICROLABEL_SIZE		(SXSIZE / FONT4_XSIZE)

static void DrawMicroLevelLabelExt(int mode)
{
  char label_text[MAX_MICROLABEL_SIZE + 1];

  ClearRectangle(drawto, SX, MICROLABEL_YPOS, SXSIZE, FONT4_YSIZE);

  strncpy(label_text, (mode == MICROLABEL_LEVEL_NAME ? level.name :
		       mode == MICROLABEL_CREATED_BY ? "created by" :
		       mode == MICROLABEL_LEVEL_AUTHOR ? level.author :
		       mode == MICROLABEL_IMPORTED_FROM ? "imported from" :
		       mode == MICROLABEL_LEVEL_IMPORT_INFO ?
		       leveldir_current->imported_from : ""),
	  MAX_MICROLABEL_SIZE);
  label_text[MAX_MICROLABEL_SIZE] = '\0';

  if (strlen(label_text) > 0)
  {
    int lxpos = SX + (SXSIZE - strlen(label_text) * FONT4_XSIZE) / 2;
    int lypos = MICROLABEL_YPOS;

    DrawText(lxpos, lypos, label_text, FS_SMALL, FC_SPECIAL2);
  }

  redraw_mask |= REDRAW_MICROLABEL;
}

void DrawMicroLevel(int xpos, int ypos, boolean restart)
{
  static unsigned long scroll_delay = 0;
  static unsigned long label_delay = 0;
  static int label_state, label_counter;

  if (restart)
  {
    label_state = 1;
    label_counter = 0;

    DrawMicroLevelExt(xpos, ypos);
    DrawMicroLevelLabelExt(label_state);

    /* initialize delay counters */
    DelayReached(&scroll_delay, 0);
    DelayReached(&label_delay, 0);

    return;
  }

  /* redraw micro level label, if needed */
  if (strcmp(level.name, NAMELESS_LEVEL_NAME) != 0 &&
      strcmp(level.author, ANONYMOUS_NAME) != 0 &&
      strcmp(level.author, leveldir_current->name) != 0 &&
      DelayReached(&label_delay, MICROLEVEL_LABEL_DELAY))
  {
    int max_label_counter = 23;

    if (leveldir_current->imported_from != NULL)
      max_label_counter += 14;

    label_counter = (label_counter + 1) % max_label_counter;
    label_state = (label_counter >= 0 && label_counter <= 7 ?
		   MICROLABEL_LEVEL_NAME :
		   label_counter >= 9 && label_counter <= 12 ?
		   MICROLABEL_CREATED_BY :
		   label_counter >= 14 && label_counter <= 21 ?
		   MICROLABEL_LEVEL_AUTHOR :
		   label_counter >= 23 && label_counter <= 26 ?
		   MICROLABEL_IMPORTED_FROM :
		   label_counter >= 28 && label_counter <= 35 ?
		   MICROLABEL_LEVEL_IMPORT_INFO : MICROLABEL_EMPTY);
    DrawMicroLevelLabelExt(label_state);
  }
}

int REQ_in_range(int x, int y)
{
  if (y > DY+249 && y < DY+278)
  {
    if (x > DX+1 && x < DX+48)
      return 1;
    else if (x > DX+51 && x < DX+98) 
      return 2;
  }
  return 0;
}

boolean Request(char *text, unsigned int req_state)
{
  int mx, my, ty, result = -1;
  unsigned int old_door_state;

  old_door_state = GetDoorState();

  UnmapAllGadgets();

  CloseDoor(DOOR_CLOSE_1);

  /* save old door content */
  BlitBitmap(pix[PIX_DB_DOOR], pix[PIX_DB_DOOR],
	     DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1, DXSIZE, DYSIZE,
	     DOOR_GFX_PAGEX2, DOOR_GFX_PAGEY1);

  /* clear door drawing field */
  ClearRectangle(drawto, DX, DY, DXSIZE, DYSIZE);

  /* write text for request */
  for(ty=0; ty<13; ty++)
  {
    int tx, tl, tc;
    char txt[256];

    if (!*text)
      break;

    for(tl=0,tx=0; tx<7; tl++,tx++)
    {
      tc = *(text + tx);
      if (!tc || tc == 32)
	break;
    }
    if (!tl)
    { 
      text++; 
      ty--; 
      continue; 
    }
    sprintf(txt, text); 
    txt[tl] = 0;
    DrawTextExt(drawto,
		DX + 51 - (tl * 14)/2, DY + 8 + ty * 16,
		txt, FS_SMALL, FC_YELLOW);
    text += tl + (tc == 32 ? 1 : 0);
  }

  if (req_state & REQ_ASK)
  {
    MapGadget(tool_gadget[TOOL_CTRL_ID_YES]);
    MapGadget(tool_gadget[TOOL_CTRL_ID_NO]);
  }
  else if (req_state & REQ_CONFIRM)
  {
    MapGadget(tool_gadget[TOOL_CTRL_ID_CONFIRM]);
  }

  /* copy request gadgets to door backbuffer */
  BlitBitmap(drawto, pix[PIX_DB_DOOR],
	     DX, DY, DXSIZE, DYSIZE,
	     DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1);

  OpenDoor(DOOR_OPEN_1);

#if 0
  ClearEventQueue();
#endif

  if (!(req_state & REQUEST_WAIT_FOR))
    return(FALSE);

  if (game_status != MAINMENU)
    InitAnimation();

  button_status = MB_RELEASED;

  request_gadget_id = -1;

  while(result < 0)
  {
    if (PendingEvent())
    {
      Event event;

      NextEvent(&event);

      switch(event.type)
      {
	case EVENT_BUTTONPRESS:
	case EVENT_BUTTONRELEASE:
	case EVENT_MOTIONNOTIFY:
	{
	  if (event.type == EVENT_MOTIONNOTIFY)
	  {
	    if (!PointerInWindow(window))
	      continue;	/* window and pointer are on different screens */

	    if (!button_status)
	      continue;

	    motion_status = TRUE;
	    mx = ((MotionEvent *) &event)->x;
	    my = ((MotionEvent *) &event)->y;
	  }
	  else
	  {
	    motion_status = FALSE;
	    mx = ((ButtonEvent *) &event)->x;
	    my = ((ButtonEvent *) &event)->y;
	    if (event.type == EVENT_BUTTONPRESS)
	      button_status = ((ButtonEvent *) &event)->button;
	    else
	      button_status = MB_RELEASED;
	  }

	  /* this sets 'request_gadget_id' */
	  HandleGadgets(mx, my, button_status);

	  switch(request_gadget_id)
	  {
	    case TOOL_CTRL_ID_YES:
	      result = TRUE;
	      break;
	    case TOOL_CTRL_ID_NO:
	      result = FALSE;
	      break;
	    case TOOL_CTRL_ID_CONFIRM:
	      result = TRUE | FALSE;
	      break;

	    default:
	      break;
	  }

	  break;
	}

	case EVENT_KEYPRESS:
	  switch(GetEventKey((KeyEvent *)&event, TRUE))
	  {
	    case KSYM_Return:
	      result = 1;
	      break;

	    case KSYM_Escape:
	      result = 0;
	      break;

	    default:
	      break;
	  }
	  break;

	case EVENT_KEYRELEASE:
	  key_joystick_mapping = 0;
	  break;

	default:
	  HandleOtherEvents(&event);
	  break;
      }
    }

    DoAnimation();

    /* don't eat all CPU time */
    Delay(10);
  }

  if (game_status != MAINMENU)
    StopAnimation();

  UnmapToolButtons();

  if (!(req_state & REQ_STAY_OPEN))
  {
    CloseDoor(DOOR_CLOSE_1);

    if (!(req_state & REQ_STAY_CLOSED) && (old_door_state & DOOR_OPEN_1))
    {
      BlitBitmap(pix[PIX_DB_DOOR], pix[PIX_DB_DOOR],
		 DOOR_GFX_PAGEX2,DOOR_GFX_PAGEY1, DXSIZE,DYSIZE,
		 DOOR_GFX_PAGEX1,DOOR_GFX_PAGEY1);
      OpenDoor(DOOR_OPEN_1);
    }
  }

  RemapAllGadgets();

  return(result);
}

unsigned int OpenDoor(unsigned int door_state)
{
  unsigned int new_door_state;

  if (door_state & DOOR_COPY_BACK)
  {
    BlitBitmap(pix[PIX_DB_DOOR], pix[PIX_DB_DOOR],
	       DOOR_GFX_PAGEX2, DOOR_GFX_PAGEY1, DXSIZE, DYSIZE + VYSIZE,
	       DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1);
    door_state &= ~DOOR_COPY_BACK;
  }

  new_door_state = MoveDoor(door_state);

  return(new_door_state);
}

unsigned int CloseDoor(unsigned int door_state)
{
  unsigned int new_door_state;

  BlitBitmap(backbuffer, pix[PIX_DB_DOOR],
	     DX, DY, DXSIZE, DYSIZE, DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1);

  new_door_state = MoveDoor(door_state);

  return(new_door_state);
}

unsigned int GetDoorState()
{
  return(MoveDoor(DOOR_GET_STATE));
}

unsigned int MoveDoor(unsigned int door_state)
{
  static int door1 = DOOR_OPEN_1;
  static int door2 = DOOR_CLOSE_2;
  static unsigned long door_delay = 0;
  int x, start, stepsize = 2;
  unsigned long door_delay_value = stepsize * 5;

  /* there is no second door */
  door_state &= ~DOOR_ACTION_2;

  if (door_state == DOOR_GET_STATE)
    return(door1 | door2);

  if (door1 == DOOR_OPEN_1 && door_state & DOOR_OPEN_1)
    door_state &= ~DOOR_OPEN_1;
  else if (door1 == DOOR_CLOSE_1 && door_state & DOOR_CLOSE_1)
    door_state &= ~DOOR_CLOSE_1;
  if (door2 == DOOR_OPEN_2 && door_state & DOOR_OPEN_2)
    door_state &= ~DOOR_OPEN_2;
  else if (door2 == DOOR_CLOSE_2 && door_state & DOOR_CLOSE_2)
    door_state &= ~DOOR_CLOSE_2;

  if (setup.quick_doors)
  {
    stepsize = 20;
    door_delay_value = 0;
    StopSound(SND_OEFFNEN);
  }

  if (door_state & DOOR_ACTION)
  {
    if (door_state & DOOR_ACTION_1)
    {
      if (door_state & DOOR_OPEN_1)
      {
	BlitBitmap(pix[PIX_DOOR], pix[PIX_DOOR], 104,136, 8,8, 146,136);
	BlitBitmap(pix[PIX_DOOR], window, 104,136, 8,8, DX + 46,DY + 136);
	redraw_mask &= ~REDRAW_DOOR_1;

	if (!setup.quick_doors)
	{
#if 0
	  int i;

	  for (i=0; i<30; i++)
	  {
	    ColorCycling();
	    if (game_status == MAINMENU)
	      DoAnimation();
	    Delay(10);
	  }
#else
	  Delay(100);
#endif
	}

      }
      else
	BlitBitmap(pix[PIX_DOOR], pix[PIX_DOOR], 88,136, 8,8, 146,136);

      if (!(door_state & DOOR_NO_DELAY))
	PlaySoundStereo(SND_OEFFNEN, PSND_MAX_RIGHT);
    }

    start = ((door_state & DOOR_NO_DELAY) ? DXSIZE : 0);

    for(x=start; x<=DXSIZE; x+=stepsize)
    {
      Bitmap *bitmap = pix[PIX_DOOR];
      GC gc = bitmap->stored_clip_gc;

      WaitUntilDelayReached(&door_delay, door_delay_value);

      if (door_state & DOOR_ACTION_1)
      {
	int i = (door_state & DOOR_OPEN_1 ? DXSIZE-x : x);

	if (x < DXSIZE || door_state & DOOR_OPEN_1)
	{
	  BlitBitmap(pix[PIX_DB_DOOR], drawto,
		     DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1 + i/2,
		     DXSIZE,DYSIZE - i/2, DX, DY);

	  ClearRectangle(drawto, DX, DY + DYSIZE - i/2, DXSIZE, i/2);
	}
	else
	  ClearRectangle(drawto, DX, DY, DXSIZE, DYSIZE);

	SetClipOrigin(bitmap, gc, DX - DXSIZE + i, DY);
	BlitBitmapMasked(bitmap, drawto,
			 DXSIZE - i, DOOR_GFX_PAGEY1, i, 30,
			 DX, DY);
	BlitBitmapMasked(bitmap, drawto,
			 DXSIZE - i, DOOR_GFX_PAGEY1 + DYSIZE - 30, i, 30,
			 DX, DY + DYSIZE - 30);
	SetClipOrigin(bitmap, gc, DX - i, DY);
	BlitBitmapMasked(bitmap, drawto,
			 DXSIZE, DOOR_GFX_PAGEY1, i, 30,
			 DX + DXSIZE - i, DY);
	BlitBitmapMasked(bitmap, drawto,
			 DXSIZE, DOOR_GFX_PAGEY1 + DYSIZE - 30, i, 30,
			 DX + DXSIZE - i, DY + DYSIZE - 30);

	if (i > 14)
	{
	  SetClipOrigin(bitmap, gc, DX - i, DY);
	  BlitBitmapMasked(bitmap, drawto,
			   DXSIZE + 14, DOOR_GFX_PAGEY1 + 30,
			   i - 14, DYSIZE - 60,
			   DX + DXSIZE + 14 - i, DY + 30);
	  SetClipOrigin(bitmap, gc, DX - DXSIZE + i, DY);
	  BlitBitmapMasked(bitmap, drawto,
			   DXSIZE - i, DOOR_GFX_PAGEY1 + 30,
			   i - 14, DYSIZE - 60,
			   DX, DY + 30);
	}

	redraw_mask |= REDRAW_DOOR_1;
      }

      BackToFront();

      if (game_status == MAINMENU)
	DoAnimation();
    }
  }

  if (setup.quick_doors)
    StopSound(SND_OEFFNEN);

  if (door_state & DOOR_ACTION_1)
    door1 = door_state & DOOR_ACTION_1;
  if (door_state & DOOR_ACTION_2)
    door2 = door_state & DOOR_ACTION_2;

  return (door1 | door2);
}


#if 0
void DrawSpecialEditorDoor()
{
  /* draw bigger toolbox window */
  BlitBitmap(pix[PIX_DOOR], drawto,
	     DOOR_GFX_PAGEX7, 0, 108, 56, EX - 4, EY - 12);

  redraw_mask |= REDRAW_ALL;
}

void UndrawSpecialEditorDoor()
{
  /* draw normal tape recorder window */
  BlitBitmap(pix[PIX_BACK], drawto,
	     562, 344, 108, 56, EX - 4, EY - 12);

  redraw_mask |= REDRAW_ALL;
}
#endif

Pixel ReadPixel(DrawBuffer *bitmap, int x, int y)
{
#if defined(TARGET_SDL) || defined(TARGET_ALLEGRO)
  return GetPixel(bitmap, x, y);
#else
  /* GetPixel() does also work for X11, but we use some optimization here */
  unsigned long pixel_value;

  if (bitmap == pix[PIX_BACK])
  {
    /* when reading pixel values from images, it is much faster to use
       client side images (XImage) than server side images (Pixmap) */
    static XImage *client_image = NULL;

    if (client_image == NULL)	/* init image cache, if not existing */
      client_image = XGetImage(display, bitmap->drawable,
			       0,0, WIN_XSIZE,WIN_YSIZE, AllPlanes, ZPixmap);

    pixel_value = XGetPixel(client_image, x, y);
  }
  else
  {
    XImage *pixel_image;

    pixel_image = XGetImage(display, bitmap->drawable, x, y, 1, 1,
			    AllPlanes, ZPixmap);
    pixel_value = XGetPixel(pixel_image, 0, 0);

    XDestroyImage(pixel_image);
  }

  return pixel_value;
#endif
}

void SetRGB(unsigned long pixel, 
	    unsigned short red, unsigned short green, unsigned short blue)
{
  return;

#if 0
  XColor color;

  if (color_status==STATIC_COLORS)
    return;

  color.pixel = pixel;
  color.red = red;
  color.green = green;
  color.blue = blue;
  color.flags = DoRed | DoGreen | DoBlue;
  XStoreColor(display, cmap, &color);
  XFlush(display);
#endif
}

/* ---------- new tool button stuff ---------------------------------------- */

/* graphic position values for tool buttons */
#define TOOL_BUTTON_YES_XPOS		2
#define TOOL_BUTTON_YES_YPOS		250
#define TOOL_BUTTON_YES_GFX_YPOS	0
#define TOOL_BUTTON_YES_XSIZE		46
#define TOOL_BUTTON_YES_YSIZE		28
#define TOOL_BUTTON_NO_XPOS		52
#define TOOL_BUTTON_NO_YPOS		TOOL_BUTTON_YES_YPOS
#define TOOL_BUTTON_NO_GFX_YPOS		TOOL_BUTTON_YES_GFX_YPOS
#define TOOL_BUTTON_NO_XSIZE		TOOL_BUTTON_YES_XSIZE
#define TOOL_BUTTON_NO_YSIZE		TOOL_BUTTON_YES_YSIZE
#define TOOL_BUTTON_CONFIRM_XPOS	TOOL_BUTTON_YES_XPOS
#define TOOL_BUTTON_CONFIRM_YPOS	TOOL_BUTTON_YES_YPOS
#define TOOL_BUTTON_CONFIRM_GFX_YPOS	30
#define TOOL_BUTTON_CONFIRM_XSIZE	96
#define TOOL_BUTTON_CONFIRM_YSIZE	TOOL_BUTTON_YES_YSIZE

static struct
{
  int xpos, ypos;
  int x, y;
  int width, height;
  int gadget_id;
  char *infotext;
} toolbutton_info[NUM_TOOL_BUTTONS] =
{
  {
    TOOL_BUTTON_YES_XPOS,	TOOL_BUTTON_YES_GFX_YPOS,
    TOOL_BUTTON_YES_XPOS,	TOOL_BUTTON_YES_YPOS,
    TOOL_BUTTON_YES_XSIZE,	TOOL_BUTTON_YES_YSIZE,
    TOOL_CTRL_ID_YES,
    "yes"
  },
  {
    TOOL_BUTTON_NO_XPOS,	TOOL_BUTTON_NO_GFX_YPOS,
    TOOL_BUTTON_NO_XPOS,	TOOL_BUTTON_NO_YPOS,
    TOOL_BUTTON_NO_XSIZE,	TOOL_BUTTON_NO_YSIZE,
    TOOL_CTRL_ID_NO,
    "no"
  },
  {
    TOOL_BUTTON_CONFIRM_XPOS,	TOOL_BUTTON_CONFIRM_GFX_YPOS,
    TOOL_BUTTON_CONFIRM_XPOS,	TOOL_BUTTON_CONFIRM_YPOS,
    TOOL_BUTTON_CONFIRM_XSIZE,	TOOL_BUTTON_CONFIRM_YSIZE,
    TOOL_CTRL_ID_CONFIRM,
    "confirm"
  }
};

static void DoNotDisplayInfoText(void *ptr)
{
  return;
}

void CreateToolButtons()
{
  int i;

  for (i=0; i<NUM_TOOL_BUTTONS; i++)
  {
    Bitmap *gd_bitmap = pix[PIX_DOOR];
    Bitmap *deco_bitmap = None;
    int deco_x = 0, deco_y = 0, deco_xpos = 0, deco_ypos = 0;
    struct GadgetInfo *gi;
    unsigned long event_mask;
    int gd_xoffset, gd_yoffset;
    int gd_x1, gd_x2, gd_y;
    int id = i;

    event_mask = GD_EVENT_RELEASED;

    gd_xoffset = toolbutton_info[i].xpos;
    gd_yoffset = toolbutton_info[i].ypos;
    gd_x1 = DOOR_GFX_PAGEX4 + gd_xoffset;
    gd_x2 = DOOR_GFX_PAGEX3 + gd_xoffset;
    gd_y = DOOR_GFX_PAGEY1 + gd_yoffset;

    gi = CreateGadget(GDI_CUSTOM_ID, id,
		      GDI_INFO_TEXT, toolbutton_info[i].infotext,
		      GDI_X, DX + toolbutton_info[i].x,
		      GDI_Y, DY + toolbutton_info[i].y,
		      GDI_WIDTH, toolbutton_info[i].width,
		      GDI_HEIGHT, toolbutton_info[i].height,
		      GDI_TYPE, GD_TYPE_NORMAL_BUTTON,
		      GDI_STATE, GD_BUTTON_UNPRESSED,
		      GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y,
		      GDI_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y,
		      GDI_DECORATION_DESIGN, deco_bitmap, deco_x, deco_y,
		      GDI_DECORATION_POSITION, deco_xpos, deco_ypos,
		      GDI_DECORATION_SIZE, MINI_TILEX, MINI_TILEY,
		      GDI_DECORATION_SHIFTING, 1, 1,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_ACTION, HandleToolButtons,
		      GDI_CALLBACK_INFO, DoNotDisplayInfoText,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    tool_gadget[id] = gi;
  }
}

static void UnmapToolButtons()
{
  int i;

  for (i=0; i<NUM_TOOL_BUTTONS; i++)
    UnmapGadget(tool_gadget[i]);
}

static void HandleToolButtons(struct GadgetInfo *gi)
{
  request_gadget_id = gi->custom_id;
}

/* ------------------------------------------------------------------------- */

int get_base_element(int element)
{
  if (IS_MIRROR(element))
    return EL_MIRROR_START;
  else if (IS_MIRROR_FIXED(element))
    return EL_MIRROR_FIXED_START;
  else if (IS_POLAR(element))
    return EL_POLAR_START;
  else if (IS_POLAR_CROSS(element))
    return EL_POLAR_CROSS_START;
  else if (IS_BEAMER(element))
    return EL_BEAMER_RED_START + BEAMER_NR(element) * 16;
  else if (IS_FIBRE_OPTIC(element))
    return EL_FIBRE_OPTIC_START + FIBRE_OPTIC_NR(element) * 2;
  else if (IS_MCDUFFIN(element))
    return EL_MCDUFFIN_START;
  else if (IS_LASER(element))
    return EL_LASER_START;
  else if (IS_RECEIVER(element))
    return EL_RECEIVER_START;
  else if (IS_DF_MIRROR(element))
    return EL_DF_MIRROR_START;
  else if (IS_DF_MIRROR_AUTO(element))
    return EL_DF_MIRROR_AUTO_START;
  else if (IS_PACMAN(element))
    return EL_PACMAN_START;
  else if (IS_GRID_STEEL(element))
    return EL_GRID_STEEL_START;
  else if (IS_GRID_WOOD(element))
    return EL_GRID_WOOD_START;
  else if (IS_GRID_STEEL_FIXED(element))
    return EL_GRID_STEEL_FIXED_START;
  else if (IS_GRID_WOOD_FIXED(element))
    return EL_GRID_WOOD_FIXED_START;
  else if (IS_GRID_STEEL_AUTO(element))
    return EL_GRID_STEEL_AUTO_START;
  else if (IS_GRID_WOOD_AUTO(element))
    return EL_GRID_WOOD_AUTO_START;
  else if (IS_WALL_STEEL(element))
    return EL_WALL_STEEL_START;
  else if (IS_WALL_WOOD(element))
    return EL_WALL_WOOD_START;
  else if (IS_WALL_ICE(element))
    return EL_WALL_ICE_START;
  else if (IS_WALL_AMOEBA(element))
    return EL_WALL_AMOEBA_START;
  else if (IS_DF_WALL_STEEL(element))
    return EL_DF_WALL_STEEL_START;
  else if (IS_DF_WALL_WOOD(element))
    return EL_DF_WALL_WOOD_START;
  else if (IS_CHAR(element))
    return EL_CHAR_START;
  else
    return element;
}

int get_element_phase(int element)
{
  return element - get_base_element(element);
}

int get_num_elements(int element)
{
  if (IS_MIRROR(element) ||
      IS_POLAR(element) ||
      IS_BEAMER(element) ||
      IS_DF_MIRROR(element) ||
      IS_DF_MIRROR_AUTO(element))
    return 16;
  else if (IS_GRID_STEEL_FIXED(element) ||
	   IS_GRID_WOOD_FIXED(element) ||
	   IS_GRID_STEEL_AUTO(element) ||
	   IS_GRID_WOOD_AUTO(element))
    return 8;
  else if (IS_MIRROR_FIXED(element) ||
	   IS_POLAR_CROSS(element) ||
	   IS_MCDUFFIN(element) ||
	   IS_LASER(element) ||
	   IS_RECEIVER(element) ||
	   IS_PACMAN(element) ||
	   IS_GRID_STEEL(element) ||
	   IS_GRID_WOOD(element))
    return 4;
  else
    return 1;
}

int get_rotated_element(int element, int step)
{
  int base_element = get_base_element(element);
  int num_elements = get_num_elements(element);
  int element_phase = element - base_element;

  return base_element + (element_phase + step + num_elements) % num_elements;
}

int el2gfx(int element)
{
  switch(element)
  {
    case EL_EMPTY:		return -1;
    case EL_GRID_STEEL_00:	return GFX_GRID_STEEL_00;
    case EL_GRID_STEEL_01:	return GFX_GRID_STEEL_01;
    case EL_GRID_STEEL_02:	return GFX_GRID_STEEL_02;
    case EL_GRID_STEEL_03:	return GFX_GRID_STEEL_03;
    case EL_MCDUFFIN_RIGHT:	return GFX_MCDUFFIN_RIGHT;
    case EL_MCDUFFIN_UP:	return GFX_MCDUFFIN_UP;
    case EL_MCDUFFIN_LEFT:	return GFX_MCDUFFIN_LEFT;
    case EL_MCDUFFIN_DOWN:	return GFX_MCDUFFIN_DOWN;
    case EL_EXIT_CLOSED:	return GFX_EXIT_CLOSED;
    case EL_EXIT_OPENING_1:	return GFX_EXIT_OPENING_1;
    case EL_EXIT_OPENING_2:	return GFX_EXIT_OPENING_2;
    case EL_EXIT_OPEN:		return GFX_EXIT_OPEN;
    case EL_KETTLE:		return GFX_KETTLE;
    case EL_BOMB:		return GFX_BOMB;
    case EL_PRISM:		return GFX_PRISM;
    case EL_BLOCK_WOOD:		return GFX_BLOCK_WOOD;
    case EL_BALL_GRAY:		return GFX_BALL_GRAY;
    case EL_FUSE_ON:		return GFX_FUSE_ON;
    case EL_PACMAN_RIGHT:	return GFX_PACMAN_RIGHT;
    case EL_PACMAN_UP:		return GFX_PACMAN_UP;
    case EL_PACMAN_LEFT:	return GFX_PACMAN_LEFT;
    case EL_PACMAN_DOWN:	return GFX_PACMAN_DOWN;
    case EL_POLAR_CROSS_00:	return GFX_POLAR_CROSS_00;
    case EL_POLAR_CROSS_01:	return GFX_POLAR_CROSS_01;
    case EL_POLAR_CROSS_02:	return GFX_POLAR_CROSS_02;
    case EL_POLAR_CROSS_03:	return GFX_POLAR_CROSS_03;
    case EL_MIRROR_FIXED_00:	return GFX_MIRROR_FIXED_00;
    case EL_MIRROR_FIXED_01:	return GFX_MIRROR_FIXED_01;
    case EL_MIRROR_FIXED_02:	return GFX_MIRROR_FIXED_02;
    case EL_MIRROR_FIXED_03:	return GFX_MIRROR_FIXED_03;
    case EL_GATE_STONE:		return GFX_GATE_STONE;
    case EL_KEY:		return GFX_KEY;
    case EL_LIGHTBULB_ON:	return GFX_LIGHTBULB_ON;
    case EL_LIGHTBULB_OFF:	return GFX_LIGHTBULB_OFF;
    case EL_LIGHTBALL:		return GFX_BALL_RED + RND(3);;
    case EL_BLOCK_STONE:	return GFX_BLOCK_STONE;
    case EL_GATE_WOOD:		return GFX_GATE_WOOD;
    case EL_FUEL_FULL:		return GFX_FUEL_FULL;
    case EL_GRID_WOOD_00:	return GFX_GRID_WOOD_00;
    case EL_GRID_WOOD_01:	return GFX_GRID_WOOD_01;
    case EL_GRID_WOOD_02:	return GFX_GRID_WOOD_02;
    case EL_GRID_WOOD_03:	return GFX_GRID_WOOD_03;
    case EL_FUEL_EMPTY:		return GFX_FUEL_EMPTY;
    case EL_FUSE_OFF:		return GFX_FUSE_OFF;
    case EL_PACMAN:		return GFX_PACMAN;
    case EL_REFRACTOR:		return GFX_REFRACTOR;
    case EL_CELL:		return GFX_CELL;
    case EL_MINE:		return GFX_MINE;

    /* pseudo-graphics; will be mapped to other graphics */
    case EL_WALL_STEEL:		return GFX_WALL_STEEL;
    case EL_WALL_WOOD:		return GFX_WALL_WOOD;
    case EL_WALL_ICE:		return GFX_WALL_ICE;
    case EL_WALL_AMOEBA:	return GFX_WALL_AMOEBA;
    case EL_DF_WALL_STEEL:	return GFX_DF_WALL_STEEL;
    case EL_DF_WALL_WOOD:	return GFX_DF_WALL_WOOD;

    default:
    {
      boolean ed = (game_status == LEVELED);
      int base_element = get_base_element(element);
      int element_phase = element - base_element;
      int base_graphic;

      if (IS_BEAMER(element))
	element_phase = element - EL_BEAMER_RED_START;
      else if (IS_FIBRE_OPTIC(element))
	element_phase = element - EL_FIBRE_OPTIC_START;

      if (IS_MIRROR(element))
	base_graphic = GFX_MIRROR_START;
      else if (IS_BEAMER_OLD(element))
	base_graphic = GFX_BEAMER_START;
      else if (IS_POLAR(element))
	base_graphic = GFX_POLAR_START;
      else if (IS_CHAR(element))
	base_graphic = GFX_CHAR_START;
      else if (IS_GRID_WOOD_FIXED(element))
	base_graphic = GFX_GRID_WOOD_FIXED_00;
      else if (IS_GRID_STEEL_FIXED(element))
	base_graphic = GFX_GRID_STEEL_FIXED_00;
      else if (IS_DF_MIRROR(element))
	base_graphic = GFX_DF_MIRROR_00;
      else if (IS_LASER(element))
	base_graphic = GFX_LASER_RIGHT;
      else if (IS_RECEIVER(element))
	base_graphic = GFX_RECEIVER_RIGHT;
      else if (IS_DF_MIRROR(element))
	base_graphic = GFX_DF_MIRROR_00;
      else if (IS_FIBRE_OPTIC(element))
	base_graphic = (ed ? GFX_FIBRE_OPTIC_ED_00 : GFX_FIBRE_OPTIC_00);
      else if (IS_GRID_WOOD_AUTO(element))
	base_graphic = (ed ? GFX_GRID_WOOD_AUTO_00 : GFX_GRID_WOOD_FIXED_00);
      else if (IS_GRID_STEEL_AUTO(element))
	base_graphic = (ed ? GFX_GRID_STEEL_AUTO_00 : GFX_GRID_STEEL_FIXED_00);
      else if (IS_DF_MIRROR_AUTO(element))
	base_graphic = (ed ? GFX_DF_MIRROR_AUTO_00 : GFX_DF_MIRROR_00);
      else if (IS_BEAMER(element))
	base_graphic = GFX_BEAMER_RED_START;
      else
	return GFX_EMPTY;

      return base_graphic + element_phase;
    }
  }
}
