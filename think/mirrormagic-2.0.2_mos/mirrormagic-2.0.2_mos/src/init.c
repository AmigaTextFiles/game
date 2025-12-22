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
* init.c                                                   *
***********************************************************/

#include <signal.h>

#include "libgame/libgame.h"

#include "init.h"
#include "events.h"
#include "screens.h"
#include "editor.h"
#include "game.h"
#include "tools.h"
#include "files.h"

static void InitPlayerInfo(void);
static void InitLevelInfo(void);
static void InitSound(void);
static void InitGfx(void);
static void InitGfxBackground(void);
static void InitGadgets(void);
static void InitElementProperties(void);

void OpenAll(void)
{
  InitProgramInfo(UNIX_USERDATA_DIRECTORY,
                  PROGRAM_TITLE_STRING, WINDOW_TITLE_STRING,
                  ICON_TITLE_STRING, X11_ICON_FILENAME, X11_ICONMASK_FILENAME,
                  MSDOS_POINTER_FILENAME);

  InitPlayerInfo();

  InitCounter();
  InitSound();
  InitRND(NEW_RANDOMIZE);

  InitVideoDisplay();
  InitVideoBuffer(&backbuffer, &window, WIN_XSIZE, WIN_YSIZE, DEFAULT_DEPTH,
		  setup.fullscreen);
  InitColor();

  InitEventFilter(FilterMouseMotionEvents);

  InitGfx();
  InitElementProperties();	/* initializes IS_CHAR() for el2gfx() */

  InitLevelInfo();
  InitGadgets();		/* needs to know number of level series */

  InitGfxBackground();
  DrawMainMenu();
}

void InitPlayerInfo()
{
#if 0
  /* choose default local player */
  local_player = &stored_player[0];
#endif

  LoadSetup();					/* global setup info */
}

void InitLevelInfo()
{
  LoadLevelInfo();				/* global level info */
  LoadLevelSetup_LastSeries();			/* last played series info */
  LoadLevelSetup_SeriesInfo();			/* last played level info */
}

void InitSound()
{
  int i;

  OpenAudio();

  for(i=0; i<NUM_SOUNDS; i++)
  {
    if (!LoadSound(sound_name[i]))
    {
      audio.sound_available = FALSE;
      audio.loops_available = FALSE;
      audio.sound_enabled = FALSE;

      return;
    }
  }

  num_bg_loops = LoadMusic();

#ifndef __MORPHOS__
  StartSoundserver();
#endif
}

void InitColor()
{
#if 0
  unsigned long plane_mask[3];
  unsigned long color[3];

  pen_fg = WhitePixel(display, screen);
  pen_bg = BlackPixel(display, screen);

  if (XAllocColorCells(display, cmap, False, plane_mask, 0, color, 3))
  {
    XColor ray_color, magicolor;

    ray_color.pixel = pen_ray = color[0];
    ray_color.flags = DoRed | DoGreen | DoBlue;
    ray_color.red = 0x0000;
    ray_color.green = 0x0000;
    ray_color.blue = 0xFFFF;
    XStoreColor(display, cmap, &ray_color);

    magicolor.pixel = pen_magicolor[0] = color[1];
    magicolor.flags = DoRed | DoGreen | DoBlue;
    magicolor.red = 0x0000;
    magicolor.green = 0xAFFF;
    magicolor.blue = 0x0000;
    XStoreColor(display, cmap, &magicolor);

    magicolor.pixel = pen_magicolor[1] = color[2];
    magicolor.flags = DoRed | DoGreen | DoBlue;
    magicolor.red = 0x0000;
    magicolor.green = 0xFFFF;
    magicolor.blue = 0x0000;
    XStoreColor(display, cmap, &magicolor);

    color_status = DYNAMIC_COLORS;
  }
  else		/* if visual has no read/write colors */
  {
    XColor ray_color;

    ray_color.flags = DoRed | DoGreen | DoBlue;
    ray_color.red = 0x0000;
    ray_color.green = 0x0000;
    ray_color.blue = 0xFFFF;
    XAllocColor(display, cmap, &ray_color);
    pen_ray = ray_color.pixel;

    color_status = STATIC_COLORS;
  }
#else

  pen_fg  = GetPixelFromRGBcompact(backbuffer, 0xFFFFFF);
  pen_bg  = GetPixelFromRGBcompact(backbuffer, 0x000000);
  pen_ray = GetPixelFromRGBcompact(backbuffer, 0x0000FF);

  color_status = STATIC_COLORS;

#endif
}

void InitGfx()
{
  int i;

#if defined(TARGET_X11)
  GC copy_clipmask_gc;
  XGCValues clip_gc_values;
  unsigned long clip_gc_valuemask;
#endif

#if !defined(PLATFORM_MSDOS)
  static char *image_filename[NUM_PICTURES] =
  {
    "MirrorScreen.pcx",
    "MirrorDoor.pcx",
    "MirrorToons.pcx",
    "MirrorDF.pcx",
    "MirrorFont.pcx",
    "MirrorFont2.pcx",
    "MirrorFont3.pcx"
  }; 
#else
  static char *image_filename[NUM_PICTURES] =
  {
    "Screen.pcx",
    "Door.pcx",
    "Toons.pcx",
    "DF.pcx",
    "Font.pcx",
    "Font2.pcx",
    "Font3.pcx"
  }; 
#endif

#if defined(TARGET_X11_NATIVE)
  static struct
  {
    int start;
    int count;
  }
  tile_needs_clipping[] =
  {
    { GFX_EXPLOSION_START, 8 },
    { -1, 0 }
  };
#endif

  /* initialize some global variables */
  global.frames_per_second = 0;
  global.fps_slowdown = FALSE;
  global.fps_slowdown_factor = 1;

  /* initialize screen properties */
  InitGfxFieldInfo(SX, SY, SXSIZE, SYSIZE,
		   REAL_SX, REAL_SY, FULL_SXSIZE, FULL_SYSIZE);
  InitGfxDoor1Info(DX, DY, DXSIZE, DYSIZE);
  InitGfxScrollbufferInfo(FXSIZE, FYSIZE);

  /* create additional image buffers for double-buffering */
  pix[PIX_DB_DOOR] = CreateBitmap(3 * DXSIZE, DYSIZE + VYSIZE, DEFAULT_DEPTH);

  pix[PIX_SMALLFONT] = LoadImage(image_filename[PIX_SMALLFONT]);
  InitFontInfo(NULL, NULL, pix[PIX_SMALLFONT]);

  DrawInitText(WINDOW_TITLE_STRING, 20, FC_YELLOW);
  DrawInitText(WINDOW_SUBTITLE_STRING, 50, FC_RED);
#if defined(PLATFORM_MSDOS)
  DrawInitText(PROGRAM_DOS_PORT_STRING, 210, FC_BLUE);
  rest(200);
#endif
  DrawInitText("Loading graphics:",120,FC_GREEN);

  for(i=0; i<NUM_PICTURES; i++)
  {
    if (i != PIX_SMALLFONT)
    {
      DrawInitText(image_filename[i], 150, FC_YELLOW);
      pix[i] = LoadImage(image_filename[i]);
    }
  }

  InitFontInfo(pix[PIX_BIGFONT], pix[PIX_MEDIUMFONT], pix[PIX_SMALLFONT]);

  /* initialize pixmap array for special X11 tile clipping to Pixmap 'None' */
  for(i=0; i<NUM_TILES; i++)
    tile_clipmask[i] = None;

#if defined(TARGET_X11)
  /* This stuff is needed because X11 (XSetClipOrigin(), to be precise) is
     often very slow when preparing a masked XCopyArea() for big Pixmaps.
     To prevent this, create small (tile-sized) mask Pixmaps which will then
     be set much faster with XSetClipOrigin() and speed things up a lot. */

  /* create graphic context structures needed for clipping */
  clip_gc_values.graphics_exposures = False;
  clip_gc_valuemask = GCGraphicsExposures;
  copy_clipmask_gc =
    XCreateGC(display, pix[PIX_BACK]->clip_mask,
	      clip_gc_valuemask, &clip_gc_values);

  clip_gc_values.graphics_exposures = False;
  clip_gc_valuemask = GCGraphicsExposures;
  tile_clip_gc =
    XCreateGC(display, window->drawable, clip_gc_valuemask, &clip_gc_values);

  for(i=0; i<NUM_BITMAPS; i++)
  {
    if (pix[i]->clip_mask)
    {
      clip_gc_values.graphics_exposures = False;
      clip_gc_values.clip_mask = pix[i]->clip_mask;
      clip_gc_valuemask = GCGraphicsExposures | GCClipMask;
      pix[i]->stored_clip_gc = XCreateGC(display, window->drawable,
					 clip_gc_valuemask,&clip_gc_values);
    }
  }

#if defined(TARGET_X11_NATIVE)
  /* create only those clipping Pixmaps we really need */
  for(i=0; tile_needs_clipping[i].start>=0; i++)
  {
    int j;

    for(j=0; j<tile_needs_clipping[i].count; j++)
    {
      int tile = tile_needs_clipping[i].start + j;
      int graphic = tile;
      int src_x, src_y;
      int pixmap_nr;
      Pixmap src_pixmap;

      getGraphicSource(graphic, &pixmap_nr, &src_x, &src_y);
      src_pixmap = pix[pixmap_nr]->clip_mask;

      tile_clipmask[tile] = XCreatePixmap(display, window->drawable,
					  TILEX, TILEY, 1);

      XCopyArea(display, src_pixmap, tile_clipmask[tile], copy_clipmask_gc,
		src_x, src_y, TILEX, TILEY, 0, 0);
    }
  }
#endif /* TARGET_X11_NATIVE */
#endif /* TARGET_X11 */
}

void InitGfxBackground()
{
  int x, y;

  drawto = backbuffer;
  SetDrawtoField(DRAW_BACKBUFFER);

  BlitBitmap(pix[PIX_BACK], backbuffer, 0,0, WIN_XSIZE,WIN_YSIZE, 0,0);
  ClearRectangle(backbuffer, REAL_SX,REAL_SY, FULL_SXSIZE,FULL_SYSIZE);
  ClearRectangle(pix[PIX_DB_DOOR], 0,0, 3*DXSIZE,DYSIZE+VYSIZE);

  for(x=0; x<MAX_BUF_XSIZE; x++)
    for(y=0; y<MAX_BUF_YSIZE; y++)
      redraw[x][y] = 0;
  redraw_tiles = 0;
  redraw_mask = REDRAW_ALL;
}

void InitGadgets()
{
  CreateLevelEditorGadgets();
  CreateGameButtons();
  CreateToolButtons();
  CreateScreenGadgets();
}

void InitElementProperties()
{
  int i,j;

  static int ep_grid[] =
  {
    EL_GRID_STEEL_00,
    EL_GRID_STEEL_01,
    EL_GRID_STEEL_02,
    EL_GRID_STEEL_03,
    EL_GRID_WOOD_00,
    EL_GRID_WOOD_01,
    EL_GRID_WOOD_02,
    EL_GRID_WOOD_03,
  };
  static int ep_grid_num = sizeof(ep_grid)/sizeof(int);

  static int ep_mcduffin[] =
  {
    EL_MCDUFFIN_RIGHT,
    EL_MCDUFFIN_UP,
    EL_MCDUFFIN_LEFT,
    EL_MCDUFFIN_DOWN,
  };
  static int ep_mcduffin_num = sizeof(ep_mcduffin)/sizeof(int);

  static int ep_rectangle[] =
  {
    EL_EXIT_CLOSED,
    EL_EXIT_OPENING_1,
    EL_EXIT_OPENING_2,
    EL_EXIT_OPEN,
    EL_BLOCK_STONE,
    EL_BLOCK_WOOD,
    EL_GATE_STONE,
    EL_GATE_WOOD
  };
  static int ep_rectangle_num = sizeof(ep_rectangle)/sizeof(int);

  static int ep_mirror[] =
  {
    EL_MIRROR_00,
    EL_MIRROR_01,
    EL_MIRROR_02,
    EL_MIRROR_03,
    EL_MIRROR_04,
    EL_MIRROR_05,
    EL_MIRROR_06,
    EL_MIRROR_07,
    EL_MIRROR_08,
    EL_MIRROR_09,
    EL_MIRROR_10,
    EL_MIRROR_11,
    EL_MIRROR_12,
    EL_MIRROR_13,
    EL_MIRROR_14,
    EL_MIRROR_15,
  };
  static int ep_mirror_num = sizeof(ep_mirror)/sizeof(int);

  static int ep_mirror_fixed[] =
  {
    EL_MIRROR_FIXED_00,
    EL_MIRROR_FIXED_01,
    EL_MIRROR_FIXED_02,
    EL_MIRROR_FIXED_03,
  };
  static int ep_mirror_fixed_num = sizeof(ep_mirror_fixed)/sizeof(int);

  static int ep_polar[] =
  {
    EL_POLAR_00,
    EL_POLAR_01,
    EL_POLAR_02,
    EL_POLAR_03,
    EL_POLAR_04,
    EL_POLAR_05,
    EL_POLAR_06,
    EL_POLAR_07,
    EL_POLAR_08,
    EL_POLAR_09,
    EL_POLAR_10,
    EL_POLAR_11,
    EL_POLAR_12,
    EL_POLAR_13,
    EL_POLAR_14,
    EL_POLAR_15,
  };
  static int ep_polar_num = sizeof(ep_polar)/sizeof(int);

  static int ep_polar_cross[] =
  {
    EL_POLAR_CROSS_00,
    EL_POLAR_CROSS_01,
    EL_POLAR_CROSS_02,
    EL_POLAR_CROSS_03,
  };
  static int ep_polar_cross_num = sizeof(ep_polar_cross)/sizeof(int);

  static int ep_beamer[] =
  {
    EL_BEAMER_00,
    EL_BEAMER_01,
    EL_BEAMER_02,
    EL_BEAMER_03,
    EL_BEAMER_04,
    EL_BEAMER_05,
    EL_BEAMER_06,
    EL_BEAMER_07,
    EL_BEAMER_08,
    EL_BEAMER_09,
    EL_BEAMER_10,
    EL_BEAMER_11,
    EL_BEAMER_12,
    EL_BEAMER_13,
    EL_BEAMER_14,
    EL_BEAMER_15,
  };
  static int ep_beamer_num = sizeof(ep_beamer)/sizeof(int);

  static int ep_reflecting[] =
  {
  };
  static int ep_reflecting_num = sizeof(ep_reflecting)/sizeof(int);

  static int ep_absorbing[] =
  {
  };
  static int ep_absorbing_num = sizeof(ep_absorbing)/sizeof(int);

  static int ep_inactive[] =
  {
  };
  static int ep_inactive_num = sizeof(ep_inactive)/sizeof(int);

  static int ep_wall[] =
  {
  };
  static int ep_wall_num = sizeof(ep_wall)/sizeof(int);

  static int ep_pacman[] =
  {
    EL_PACMAN_RIGHT,
    EL_PACMAN_UP,
    EL_PACMAN_LEFT,
    EL_PACMAN_DOWN,
  };
  static int ep_pacman_num = sizeof(ep_pacman)/sizeof(int);

  static long ep_bit[] =
  {
    EP_BIT_GRID,
    EP_BIT_MCDUFFIN,
    EP_BIT_RECTANGLE,
    EP_BIT_MIRROR,
    EP_BIT_MIRROR_FIXED,
    EP_BIT_POLAR,
    EP_BIT_POLAR_CROSS,
    EP_BIT_BEAMER,
    EP_BIT_REFLECTING,
    EP_BIT_ABSORBING,
    EP_BIT_INACTIVE,
    EP_BIT_WALL,
    EP_BIT_PACMAN,
  };
  static int *ep_array[] =
  {
    ep_grid,
    ep_mcduffin,
    ep_rectangle,
    ep_mirror,
    ep_mirror_fixed,
    ep_polar,
    ep_polar_cross,
    ep_beamer,
    ep_reflecting,
    ep_absorbing,
    ep_inactive,
    ep_wall,
    ep_pacman,
  };
  static int *ep_num[] =
  {
    &ep_grid_num,
    &ep_mcduffin_num,
    &ep_rectangle_num,
    &ep_mirror_num,
    &ep_mirror_fixed_num,
    &ep_polar_num,
    &ep_polar_cross_num,
    &ep_beamer_num,
    &ep_reflecting_num,
    &ep_absorbing_num,
    &ep_inactive_num,
    &ep_wall_num,
    &ep_pacman_num,
  };
  static int num_properties = sizeof(ep_num)/sizeof(int *);

  for(i=0; i<MAX_ELEMENTS; i++)
    Elementeigenschaften[i] = 0;

  for(i=0; i<num_properties; i++)
    for(j=0; j<*(ep_num[i]); j++)
      Elementeigenschaften[(ep_array[i])[j]] |= ep_bit[i];

  for(i=EL_CHAR_START; i<=EL_CHAR_END; i++)
    Elementeigenschaften[i] |= (EP_BIT_CHAR | EP_BIT_INACTIVE);

  for(i=EL_WALL_START; i<=EL_WALL_END; i++)
    Elementeigenschaften[i] |= EP_BIT_WALL;
}

void CloseAllAndExit(int exit_value)
{
  int i;

  StopSounds();
  FreeSounds(NUM_SOUNDS);
  CloseAudio();

  for(i=0; i<NUM_BITMAPS; i++)
    FreeBitmap(pix[i]);
  CloseVideoDisplay();

  ClosePlatformDependantStuff();

  exit(exit_value);
}
