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
* screens.c                                                *
***********************************************************/

#include "libgame/libgame.h"

#include "screens.h"
#include "events.h"
#include "game.h"
#include "tools.h"
#include "editor.h"
#include "files.h"
#include "cartoons.h"
#include "init.h"

/* for DrawSetupScreen(), HandleSetupScreen() */
#define SETUP_SCREEN_POS_START		2
#define SETUP_SCREEN_POS_END		(SCR_FIELDY - 1)
#define SETUP_SCREEN_POS_EMPTY1		(SETUP_SCREEN_POS_END - 2)
#define SETUP_SCREEN_POS_EMPTY2		(SETUP_SCREEN_POS_END - 2)

/* for HandleChooseLevel() */
#define MAX_LEVEL_SERIES_ON_SCREEN	(SCR_FIELDY - 2)

/* buttons and scrollbars identifiers */
#define SCREEN_CTRL_ID_SCROLL_UP	0
#define SCREEN_CTRL_ID_SCROLL_DOWN	1
#define SCREEN_CTRL_ID_SCROLL_VERTICAL	2

#define NUM_SCREEN_SCROLLBUTTONS	2
#define NUM_SCREEN_SCROLLBARS		1
#define NUM_SCREEN_GADGETS		3

/* forward declaration for internal use */
static void HandleScreenGadgets(struct GadgetInfo *);

static struct GadgetInfo *screen_gadget[NUM_SCREEN_GADGETS];

void DrawHeadline()
{
  int x = SX + (SXSIZE - strlen(PROGRAM_TITLE_STRING) * FONT1_XSIZE) / 2;

  DrawText(x, SY + 8, PROGRAM_TITLE_STRING, FS_BIG, FC_YELLOW);
  DrawTextFCentered(46, FC_RED, WINDOW_SUBTITLE_STRING);
}

static void ToggleFullscreenIfNeeded()
{
  if (setup.fullscreen != video.fullscreen_enabled)
  {
    /* save old door content */
    BlitBitmap(backbuffer, pix[PIX_DB_DOOR],
	       DX, DY, DXSIZE, DYSIZE, DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1);

    /* toggle fullscreen */
    ChangeVideoModeIfNeeded(setup.fullscreen);
    setup.fullscreen = video.fullscreen_enabled;

    /* redraw background to newly created backbuffer */
    BlitBitmap(pix[PIX_BACK], backbuffer, 0,0, WIN_XSIZE,WIN_YSIZE, 0,0);

    /* restore old door content */
    BlitBitmap(pix[PIX_DB_DOOR], backbuffer,
	       DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1, DXSIZE, DYSIZE, DX, DY);

    redraw_mask = REDRAW_ALL;
  }
}

void DrawMainMenu()
{
  static struct LevelDirInfo *leveldir_last_valid = NULL;
  int i;

#if 0
  BlitBitmap(drawto,window,0,0,WIN_XSIZE,WIN_YSIZE,0,0);
  Delay(4000);
#endif


  UnmapAllGadgets();
  FadeSounds();
  KeyboardAutoRepeatOn();

  /* needed if last screen was the playing screen, invoked from level editor */
  if (level_editor_test_game)
  {
    game_status = LEVELED;
    DrawLevelEd();
    return;
  }


#if 0
  /* needed if last screen was the editor screen */
  UndrawSpecialEditorDoor();
#endif


#if 0
  FadeToFront();
  return;
#endif


  /* needed if last screen was the setup screen and fullscreen state changed */
  ToggleFullscreenIfNeeded();

#ifdef TARGET_SDL
  SetDrawtoField(DRAW_BACKBUFFER);
#endif

  /* leveldir_current may be invalid (level group, parent link) */
  if (!validLevelSeries(leveldir_current))
    leveldir_current = getFirstValidLevelSeries(leveldir_last_valid);

  /* store valid level series information */
  leveldir_last_valid = leveldir_current;

  /* level_nr may have been set to value over handicap with level editor */
  if (setup.handicap && level_nr > leveldir_current->handicap_level)
    level_nr = leveldir_current->handicap_level;

  GetPlayerConfig();
  LoadLevel(level_nr);

  ClearWindow();
  DrawHeadline();
  DrawText(SX + 32,    SY + 2*32, "Name:", FS_BIG, FC_GREEN);
  DrawText(SX + 6*32,  SY + 2*32, setup.player_name, FS_BIG, FC_RED);
  DrawText(SX + 32,    SY + 3*32, "Level:", FS_BIG, FC_GREEN);
  DrawText(SX + 11*32, SY + 3*32, int2str(level_nr,3), FS_BIG,
	   (leveldir_current->readonly ? FC_RED : FC_YELLOW));
  DrawText(SX + 32,    SY + 4*32, "Hall Of Fame", FS_BIG, FC_GREEN);
  DrawText(SX + 32,    SY + 5*32, "Level Creator", FS_BIG, FC_GREEN);
  DrawText(SY + 32,    SY + 6*32, "Info Screen", FS_BIG, FC_GREEN);
  DrawText(SX + 32,    SY + 7*32, "Start Game", FS_BIG, FC_GREEN);
  DrawText(SX + 32,    SY + 8*32, "Setup", FS_BIG, FC_GREEN);
  DrawText(SX + 32,    SY + 9*32, "Quit", FS_BIG, FC_GREEN);

  DrawMicroLevel(MICROLEV_XPOS, MICROLEV_YPOS, TRUE);

  DrawTextF(7*32 + 6, 3*32 + 9, FC_RED, "%d-%d",
	    leveldir_current->first_level,
	    leveldir_current->last_level);

#if 0
  if (leveldir_current->readonly)
  {
    DrawTextF(15*32 + 6, 3*32 + 9 - 7, FC_RED, "READ");
    DrawTextF(15*32 + 6, 3*32 + 9 + 7, FC_RED, "ONLY");
  }
#endif

  for(i=2; i<10; i++)
    DrawGraphic(0, i, GFX_KUGEL_BLAU);
  DrawGraphic(10, 3, GFX_ARROW_BLUE_LEFT);
  DrawGraphic(14, 3, GFX_ARROW_BLUE_RIGHT);

  DrawText(SX + 40, SY + 326, "A Game by Artsoft Entertainment",
	   FS_SMALL, FC_RED);

  if (leveldir_current->name)
  {
    int len = strlen(leveldir_current->name);
#if 0
    int lxpos = SX + (SXSIZE - len * FONT4_XSIZE) / 2;
    int lypos = SY + 352;
#endif
    int lxpos = SX + SXSIZE - len * FONT4_XSIZE;
    int lypos = SY + 9 * 32 + 8;

    DrawText(lxpos, lypos, leveldir_current->name, FS_SMALL, FC_SPECIAL2);
  }

  FadeToFront();
  InitAnimation();
  HandleMainMenu(0,0, 0,0, MB_MENU_INITIALIZE);

  OpenDoor(DOOR_CLOSE_1 | DOOR_OPEN_2);

#if 0
  ClearEventQueue();
#endif

}

static void gotoTopLevelDir()
{
  /* move upwards to top level directory */
  while (leveldir_current->node_parent)
  {
    /* write a "path" into level tree for easy navigation to last level */
    if (leveldir_current->node_parent->node_group->cl_first == -1)
    {
      int num_leveldirs = numLevelDirInfoInGroup(leveldir_current);
      int leveldir_pos = posLevelDirInfo(leveldir_current);
      int num_page_entries;
      int cl_first, cl_cursor;

      if (num_leveldirs <= MAX_LEVEL_SERIES_ON_SCREEN)
	num_page_entries = num_leveldirs;
      else
	num_page_entries = MAX_LEVEL_SERIES_ON_SCREEN - 1;

      cl_first = MAX(0, leveldir_pos - num_page_entries + 1);
      cl_cursor = leveldir_pos - cl_first + 3;

      leveldir_current->node_parent->node_group->cl_first = cl_first;
      leveldir_current->node_parent->node_group->cl_cursor = cl_cursor;
    }

    leveldir_current = leveldir_current->node_parent;
  }
}

void HandleMainMenu(int mx, int my, int dx, int dy, int button)
{
  static int choice = 3;
  static int redraw = TRUE;
  int x = (mx + 32 - SX) / 32, y = (my + 32 - SY) / 32;

  if (redraw || button == MB_MENU_INITIALIZE)
  {
    DrawGraphic(0, choice - 1, GFX_KUGEL_ROT);
    redraw = FALSE;
  }

  if (button == MB_MENU_INITIALIZE)
    return;

  if (dx || dy)
  {
    if (dx && choice == 4)
    {
      x = (dx < 0 ? 11 : 15);
      y = 4;
    }
    else if (dy)
    {
      x = 1;
      y = choice + dy;
    }
    else
      x = y = 0;

    if (y < 3)
      y = 3;
    else if (y > 10)
      y = 10;
  }

  if (!mx && !my && !dx && !dy)
  {
    x = 1;
    y = choice;
  }

  if (y == 4 && ((x == 11 && level_nr > leveldir_current->first_level) ||
		 (x == 15 && level_nr < leveldir_current->last_level)) &&
      button)
  {
    static unsigned long level_delay = 0;
    int step = (button == 1 ? 1 : button == 2 ? 5 : 10);
    int new_level_nr, old_level_nr = level_nr;
    int font_color = (leveldir_current->readonly ? FC_RED : FC_YELLOW);

    new_level_nr = level_nr + (x == 11 ? -step : +step);
    if (new_level_nr < leveldir_current->first_level)
      new_level_nr = leveldir_current->first_level;
    if (new_level_nr > leveldir_current->last_level)
      new_level_nr = leveldir_current->last_level;

    if (setup.handicap && new_level_nr > leveldir_current->handicap_level)
      new_level_nr = leveldir_current->handicap_level;

    if (old_level_nr == new_level_nr ||
	!DelayReached(&level_delay, GADGET_FRAME_DELAY))
      goto out;

    level_nr = new_level_nr;

    DrawTextExt(drawto, SX + 11 * 32, SY + 3 * 32,
		int2str(level_nr, 3), FS_BIG, font_color);
    DrawTextExt(window, SX + 11 * 32, SY + 3 * 32,
		int2str(level_nr, 3), FS_BIG, font_color);

    LoadLevel(level_nr);
    DrawMicroLevel(MICROLEV_XPOS, MICROLEV_YPOS, TRUE);

    /* needed because DrawMicroLevel() takes some time */
    BackToFront();
    SyncDisplay();
    DelayReached(&level_delay, 0);	/* reset delay counter */
  }
  else if (x == 1 && y >= 3 && y <= 10)
  {
    if (button)
    {
      if (y != choice)
      {
	DrawGraphic(0, y - 1, GFX_KUGEL_ROT);
	DrawGraphic(0, choice - 1, GFX_KUGEL_BLAU);
	choice = y;
      }
    }
    else
    {
      if (y == 3)
      {
	game_status = TYPENAME;
	HandleTypeName(strlen(setup.player_name), 0);
      }
      else if (y == 4)
      {
	if (leveldir_first)
	{
	  game_status = CHOOSELEVEL;
	  SaveLevelSetup_LastSeries();
	  SaveLevelSetup_SeriesInfo();

	  gotoTopLevelDir();

	  DrawChooseLevel();
	}
      }
      else if (y == 5)
      {
	game_status = HALLOFFAME;
	DrawHallOfFame(-1);
      }
      else if (y == 6)
      {
	if (leveldir_current->readonly &&
	    strcmp(setup.player_name, "Artsoft") != 0)
	  Request("This level is read only !", REQ_CONFIRM);
	game_status = LEVELED;
	DrawLevelEd();
      }
      else if (y == 7)
      {
	game_status = HELPSCREEN;
	DrawHelpScreen();
      }
      else if (y == 8)
      {
	game_status = PLAYING;
	StopAnimation();
	InitGame();
      }
      else if (y == 9)
      {
	game_status = SETUP;
	DrawSetupScreen();
      }
      else if (y == 10)
      {
	SaveLevelSetup_LastSeries();
	SaveLevelSetup_SeriesInfo();
        if (Request("Do you really want to quit ?", REQ_ASK | REQ_STAY_CLOSED))
	  game_status = EXITGAME;
      }

      redraw = TRUE;
    }
  }
  BackToFront();

  out:

  if (game_status == MAINMENU)
  {
    DrawMicroLevel(MICROLEV_XPOS, MICROLEV_YPOS, FALSE);
    DoAnimation();
  }
}

#define MAX_HELPSCREEN_ELS	10
#define HA_NEXT			-999
#define HA_END			-1000

static long helpscreen_state;
static int helpscreen_step[MAX_HELPSCREEN_ELS];
static int helpscreen_frame[MAX_HELPSCREEN_ELS];
static int helpscreen_delay[MAX_HELPSCREEN_ELS];
static int helpscreen_action[] =
{
  GFX_EMPTY,1,100,						HA_NEXT,
  GFX_BOMB,1,50, GFX_EXPLOSION_START,8,1, GFX_EMPTY,1,10,	HA_NEXT,
  GFX_PACMAN+0,1,3, GFX_PACMAN+4,1,2, GFX_PACMAN+0,1,3,
  GFX_PACMAN+1,1,3, GFX_PACMAN+5,1,2, GFX_PACMAN+1,1,3,
  GFX_PACMAN+2,1,3, GFX_PACMAN+6,1,2, GFX_PACMAN+2,1,3,
  GFX_PACMAN+3,1,3, GFX_PACMAN+7,1,2, GFX_PACMAN+3,1,3,		HA_NEXT,
  HA_END
};
static char *helpscreen_eltext[][2] =
{
 {"Empty field:",			"You can walk through it"},
 {"Bomb: You can move it, but be",	"careful when dropping it"},
 {"Pacman: Eats the amoeba and you,",	"if you're not careful"},
};
static int num_helpscreen_els = sizeof(helpscreen_eltext)/(2*sizeof(char *));

static char *helpscreen_music[][3] =
{
  { "Alchemy",			"Ian Boddy",		"Drive" },
  { "The Chase",		"Propaganda",		"A Secret Wish" },
  { "Network 23",		"Tangerine Dream",	"Exit" },
  { "Czardasz",			"Robert Pieculewicz",	"Czardasz" },
  { "21st Century Common Man",	"Tangerine Dream",	"Tyger" },
  { "Voyager",			"The Alan Parsons Project","Pyramid" },
  { "Twilight Painter",		"Tangerine Dream",	"Heartbreakers" }
};
static int helpscreen_musicpos;

void DrawHelpScreenElAction(int start)
{
  int i = 0, j = 0;
  int frame, graphic;
  int xstart = SX+16, ystart = SY+64+2*32, ystep = TILEY+4;

  while(helpscreen_action[j] != HA_END)
  {
    if (i>=start+MAX_HELPSCREEN_ELS || i>=num_helpscreen_els)
      break;
    else if (i<start || helpscreen_delay[i-start])
    {
      if (i>=start && helpscreen_delay[i-start])
	helpscreen_delay[i-start]--;

      while(helpscreen_action[j] != HA_NEXT)
	j++;
      j++;
      i++;
      continue;
    }

    j += 3*helpscreen_step[i-start];
    graphic = helpscreen_action[j++];

    if (helpscreen_frame[i-start])
    {
      frame = helpscreen_action[j++] - helpscreen_frame[i-start];
      helpscreen_frame[i-start]--;
    }
    else
    {
      frame = 0;
      helpscreen_frame[i-start] = helpscreen_action[j++]-1;
    }

    helpscreen_delay[i-start] = helpscreen_action[j++] - 1;

    if (helpscreen_action[j] == HA_NEXT)
    {
      if (!helpscreen_frame[i-start])
	helpscreen_step[i-start] = 0;
    }
    else
    {
      if (!helpscreen_frame[i-start])
	helpscreen_step[i-start]++;
      while(helpscreen_action[j] != HA_NEXT)
	j++;
    }
    j++;

    DrawGraphicExt(drawto, xstart, ystart+(i-start)*ystep, graphic+frame);
    i++;
  }

  for(i=2;i<16;i++)
  {
    MarkTileDirty(0,i);
    MarkTileDirty(1,i);
  }
}

void DrawHelpScreenElText(int start)
{
  int i;
  int xstart = SX + 56, ystart = SY + 65 + 2 * 32, ystep = TILEY + 4;
  int ybottom = SYSIZE - 20;

  ClearWindow();
  DrawHeadline();

  DrawTextFCentered(100, FC_GREEN, "The game elements:");

  for(i=start; i < start + MAX_HELPSCREEN_ELS && i < num_helpscreen_els; i++)
  {
    DrawText(xstart,
	     ystart + (i - start) * ystep + (*helpscreen_eltext[i][1] ? 0 : 8),
	     helpscreen_eltext[i][0], FS_SMALL, FC_YELLOW);
    DrawText(xstart, ystart + (i - start) * ystep + 16,
	     helpscreen_eltext[i][1], FS_SMALL, FC_YELLOW);
  }

  DrawTextFCentered(ybottom, FC_BLUE, "Press any key or button for next page");
}

void DrawHelpScreenMusicText(int num)
{
  int ystart = 150, ystep = 30;
  int ybottom = SYSIZE - 20;

  FadeSounds();
  ClearWindow();
  DrawHeadline();

  DrawTextFCentered(100, FC_GREEN, "The game background music loops:");

  DrawTextFCentered(ystart + 0 * ystep, FC_YELLOW,
		    "Excerpt from");
  DrawTextFCentered(ystart + 1 * ystep, FC_RED, "\"%s\"",
		    helpscreen_music[num][0]);
  DrawTextFCentered(ystart + 2 * ystep, FC_YELLOW,
		    "by");
  DrawTextFCentered(ystart + 3 * ystep, FC_RED,
		    "%s", helpscreen_music[num][1]);
  DrawTextFCentered(ystart + 4 * ystep, FC_YELLOW,
		    "from the album");
  DrawTextFCentered(ystart + 5 * ystep, FC_RED, "\"%s\"",
		    helpscreen_music[num][2]);

  DrawTextFCentered(ybottom, FC_BLUE, "Press any key or button for next page");

#if 0
  PlaySoundLoop(background_loop[num]);
#endif
}

void DrawHelpScreenCreditsText()
{
  int ystart = 150, ystep = 30;
  int ybottom = SYSIZE - 20;

  FadeSounds();
  ClearWindow();
  DrawHeadline();

  DrawTextFCentered(100, FC_GREEN,
		    "Credits:");
  DrawTextFCentered(ystart + 0 * ystep, FC_YELLOW,
		    "DOS port based on code by:");
  DrawTextFCentered(ystart + 1 * ystep, FC_RED,
		    "Guido Schulz");

  DrawTextFCentered(ystart + 3 * ystep, FC_YELLOW,
		    "If you have created new levels,");
  DrawTextFCentered(ystart + 4 * ystep, FC_YELLOW,
		    "send them to me to include them!");
  DrawTextFCentered(ystart + 5 * ystep, FC_YELLOW,
		    ":-)");

  DrawTextFCentered(ybottom, FC_BLUE, "Press any key or button for next page");
}

void DrawHelpScreenContactText()
{
  int ystart = 150, ystep = 30;
  int ybottom = SYSIZE - 20;

  ClearWindow();
  DrawHeadline();

  DrawTextFCentered(100, FC_GREEN, "Program information:");

  DrawTextFCentered(ystart + 0 * ystep, FC_YELLOW,
		    "This game is Freeware!");
  DrawTextFCentered(ystart + 1 * ystep, FC_YELLOW,
		    "If you like it, send e-mail to:");
  DrawTextFCentered(ystart + 2 * ystep, FC_RED,
		    "info@artsoft.org");
  DrawTextFCentered(ystart + 3 * ystep, FC_YELLOW,
		    "or SnailMail to:");
  DrawTextFCentered(ystart + 4 * ystep + 0, FC_RED,
		    "Holger Schemel");
  DrawTextFCentered(ystart + 4 * ystep + 20, FC_RED,
		    "Detmolder Strasse 189");
  DrawTextFCentered(ystart + 4 * ystep + 40, FC_RED,
		    "33604 Bielefeld");
  DrawTextFCentered(ystart + 4 * ystep + 60, FC_RED,
		    "Germany");

  DrawTextFCentered(ybottom, FC_BLUE, "Press any key or button for main menu");
}

void DrawHelpScreen()
{
  int i;

  UnmapAllGadgets();

  for(i=0;i<MAX_HELPSCREEN_ELS;i++)
    helpscreen_step[i] = helpscreen_frame[i] = helpscreen_delay[i] = 0;
  helpscreen_musicpos = 0;
  helpscreen_state = 0;
  DrawHelpScreenElText(0);
  DrawHelpScreenElAction(0);

  FadeToFront();
  InitAnimation();
  PlaySoundLoop(SND_RHYTHMLOOP);
}

void HandleHelpScreen(int button)
{
  static unsigned long hs_delay = 0;
  int num_helpscreen_els_pages =
    (num_helpscreen_els + MAX_HELPSCREEN_ELS-1) / MAX_HELPSCREEN_ELS;
  int button_released = !button;
  int i;

  if (button_released)
  {
    if (helpscreen_state < num_helpscreen_els_pages - 1)
    {
      for(i=0;i<MAX_HELPSCREEN_ELS;i++)
	helpscreen_step[i] = helpscreen_frame[i] = helpscreen_delay[i] = 0;
      helpscreen_state++;
      DrawHelpScreenElText(helpscreen_state*MAX_HELPSCREEN_ELS);
      DrawHelpScreenElAction(helpscreen_state*MAX_HELPSCREEN_ELS);
    }
    else if (helpscreen_state < num_helpscreen_els_pages + num_bg_loops - 1)
    {
      helpscreen_state++;
      DrawHelpScreenMusicText(helpscreen_state - num_helpscreen_els_pages);
    }
    else if (helpscreen_state == num_helpscreen_els_pages + num_bg_loops - 1)
    {
      helpscreen_state++;
      DrawHelpScreenCreditsText();
    }
    else if (helpscreen_state == num_helpscreen_els_pages + num_bg_loops)
    {
      helpscreen_state++;
      DrawHelpScreenContactText();
    }
    else
    {
      FadeSounds();
      DrawMainMenu();
      game_status = MAINMENU;
    }
  }
  else
  {
    if (DelayReached(&hs_delay,GAME_FRAME_DELAY * 2))
    {
      if (helpscreen_state<num_helpscreen_els_pages)
	DrawHelpScreenElAction(helpscreen_state*MAX_HELPSCREEN_ELS);
    }
    DoAnimation();
  }

  BackToFront();
}

void HandleTypeName(int newxpos, Key key)
{
  static int xpos = 0, ypos = 2;

  if (newxpos)
  {
    xpos = newxpos;
    DrawText(SX + 6*32, SY + ypos*32, setup.player_name, FS_BIG, FC_YELLOW);
    if (xpos + 6 < SCR_FIELDX)
      DrawGraphic(xpos + 6, ypos, GFX_KUGEL_ROT);
    return;
  }

  if (((key >= KSYM_A && key <= KSYM_Z) ||
       (key >= KSYM_a && key <= KSYM_z)) && 
      xpos < MAX_PLAYER_NAME_LEN)
  {
    char ascii;

    if (key >= KSYM_A && key <= KSYM_Z)
      ascii = 'A' + (char)(key - KSYM_A);
    else
      ascii = 'a' + (char)(key - KSYM_a);

    setup.player_name[xpos] = ascii;
    setup.player_name[xpos + 1] = 0;
    xpos++;
    DrawTextExt(drawto, SX + 6*32, SY + ypos*32,
		setup.player_name, FS_BIG, FC_YELLOW);
    DrawTextExt(window, SX + 6*32, SY + ypos*32,
		setup.player_name, FS_BIG, FC_YELLOW);
    if (xpos + 6 < SCR_FIELDX)
      DrawGraphic(xpos + 6, ypos, GFX_KUGEL_ROT);
  }
  else if ((key == KSYM_Delete || key == KSYM_BackSpace) && xpos > 0)
  {
    xpos--;
    setup.player_name[xpos] = 0;
    DrawGraphic(xpos + 6, ypos, GFX_KUGEL_ROT);
    if (xpos + 7 < SCR_FIELDX)
      DrawGraphic(xpos + 7, ypos, GFX_EMPTY);
  }
  else if (key == KSYM_Return && xpos > 0)
  {
    DrawText(SX + 6*32, SY + ypos*32, setup.player_name, FS_BIG, FC_RED);
    if (xpos + 6 < SCR_FIELDX)
      DrawGraphic(xpos + 6, ypos, GFX_EMPTY);

    SaveSetup();
    game_status = MAINMENU;
  }

  BackToFront();
}

static void drawCursorExt(int ypos, int color, int graphic)
{
  static int cursor_array[SCR_FIELDY];

  if (graphic)
    cursor_array[ypos] = graphic;

  graphic = cursor_array[ypos];

  if (color == FC_RED)
    graphic = (graphic == GFX_ARROW_BLUE_LEFT  ? GFX_ARROW_RED_LEFT  :
	       graphic == GFX_ARROW_BLUE_RIGHT ? GFX_ARROW_RED_RIGHT :
	       GFX_KUGEL_ROT);

  DrawGraphic(0, ypos, graphic);
}

static void initCursor(int ypos, int graphic)
{
  drawCursorExt(ypos, FC_BLUE, graphic);
}

static void drawCursor(int ypos, int color)
{
  drawCursorExt(ypos, color, 0);
}

void DrawChooseLevel()
{
  UnmapAllGadgets();

  ClearWindow();
  HandleChooseLevel(0,0, 0,0, MB_MENU_INITIALIZE);
  MapChooseLevelGadgets();

  FadeToFront();
  InitAnimation();
}

static void AdjustChooseLevelScrollbar(int id, int first_entry)
{
  struct GadgetInfo *gi = screen_gadget[id];
  int items_max, items_visible, item_position;

  items_max = numLevelDirInfoInGroup(leveldir_current);
  items_visible = MAX_LEVEL_SERIES_ON_SCREEN - 1;
  item_position = first_entry;

  if (item_position > items_max - items_visible)
    item_position = items_max - items_visible;

  ModifyGadget(gi, GDI_SCROLLBAR_ITEMS_MAX, items_max,
	       GDI_SCROLLBAR_ITEM_POSITION, item_position, GDI_END);
}

static void drawChooseLevelList(int first_entry, int num_page_entries)
{
  int i;
  char buffer[SCR_FIELDX * 2];
  int max_buffer_len = (SCR_FIELDX - 2) * 2;
  int num_leveldirs = numLevelDirInfoInGroup(leveldir_current);

  ClearRectangle(backbuffer, SX, SY, SXSIZE - 32, SYSIZE);
  redraw_mask |= REDRAW_FIELD;

  DrawText(SX, SY, "Level Series", FS_BIG, FC_GREEN);

  for(i=0; i<num_page_entries; i++)
  {
    struct LevelDirInfo *node, *node_first;
    int leveldir_pos = first_entry + i;
    int ypos = i + 2;

    node_first = getLevelDirInfoFirstGroupEntry(leveldir_current);
    node = getLevelDirInfoFromPos(node_first, leveldir_pos);

    strncpy(buffer, node->name , max_buffer_len);
    buffer[max_buffer_len] = '\0';

    DrawText(SX + 32, SY + ypos * 32, buffer, FS_MEDIUM, node->color);

    if (node->parent_link)
      initCursor(ypos, GFX_ARROW_BLUE_LEFT);
    else if (node->level_group)
      initCursor(ypos, GFX_ARROW_BLUE_RIGHT);
    else
      initCursor(ypos, GFX_KUGEL_BLAU);
  }

  if (first_entry > 0)
    DrawGraphic(0, 1, GFX_ARROW_BLUE_UP);

  if (first_entry + num_page_entries < num_leveldirs)
    DrawGraphic(0, MAX_LEVEL_SERIES_ON_SCREEN + 1, GFX_ARROW_BLUE_DOWN);
}

static void drawChooseLevelInfo(int leveldir_pos)
{
  struct LevelDirInfo *node, *node_first;
  int x, last_redraw_mask = redraw_mask;

  node_first = getLevelDirInfoFirstGroupEntry(leveldir_current);
  node = getLevelDirInfoFromPos(node_first, leveldir_pos);

  ClearRectangle(drawto, SX + 32, SY + 32, SXSIZE - 64, 32);

  if (node->parent_link)
    DrawTextFCentered(40, FC_RED, "leave group \"%s\"", node->class_desc);
  else if (node->level_group)
    DrawTextFCentered(40, FC_RED, "enter group \"%s\"", node->class_desc);
  else
    DrawTextFCentered(40, FC_RED, "%3d levels (%s)",
		      node->levels, node->class_desc);

  /* let BackToFront() redraw only what is needed */
  redraw_mask = last_redraw_mask | REDRAW_TILES;
  for (x=0; x<SCR_FIELDX; x++)
    MarkTileDirty(x, 1);
}

void HandleChooseLevel(int mx, int my, int dx, int dy, int button)
{
  static unsigned long choose_delay = 0;
  static int redraw = TRUE;
  int x = (mx + 32 - SX) / 32, y = (my + 32 - SY) / 32;
  int step = (button == 1 ? 1 : button == 2 ? 5 : 10);
  int num_leveldirs = numLevelDirInfoInGroup(leveldir_current);
  int num_page_entries;

  if (num_leveldirs <= MAX_LEVEL_SERIES_ON_SCREEN)
    num_page_entries = num_leveldirs;
  else
    num_page_entries = MAX_LEVEL_SERIES_ON_SCREEN - 1;

  if (button == MB_MENU_INITIALIZE)
  {
    int leveldir_pos = posLevelDirInfo(leveldir_current);

    if (leveldir_current->cl_first == -1)
    {
      leveldir_current->cl_first = MAX(0, leveldir_pos - num_page_entries + 1);
      leveldir_current->cl_cursor =
	leveldir_pos - leveldir_current->cl_first + 3;
    }

    if (dx == 999)	/* first entry is set by scrollbar position */
      leveldir_current->cl_first = dy;
    else
      AdjustChooseLevelScrollbar(SCREEN_CTRL_ID_SCROLL_VERTICAL,
				 leveldir_current->cl_first);

    drawChooseLevelList(leveldir_current->cl_first, num_page_entries);
    drawChooseLevelInfo(leveldir_pos);
    redraw = TRUE;
  }

  if (redraw)
  {
    drawCursor(leveldir_current->cl_cursor - 1, FC_RED);
    redraw = FALSE;
  }

  if (button == MB_MENU_INITIALIZE)
    return;

  if (dx || dy)
  {
    if (dy)
    {
      x = 1;
      y = leveldir_current->cl_cursor + dy;
    }
    else
      x = y = 0;	/* no action */

    if (ABS(dy) == SCR_FIELDY)	/* handle KSYM_Page_Up, KSYM_Page_Down */
    {
      dy = SIGN(dy);
      step = num_page_entries - 1;
      x = 1;
      y = (dy < 0 ? 2 : num_page_entries + 3);
    }
  }

  if (x == 1 && y == 2)
  {
    if (leveldir_current->cl_first > 0 &&
	(dy || DelayReached(&choose_delay, GADGET_FRAME_DELAY)))
    {
      leveldir_current->cl_first -= step;
      if (leveldir_current->cl_first < 0)
	leveldir_current->cl_first = 0;

      drawChooseLevelList(leveldir_current->cl_first, num_page_entries);
      drawChooseLevelInfo(leveldir_current->cl_first +
			  leveldir_current->cl_cursor - 3);
      drawCursor(leveldir_current->cl_cursor - 1, FC_RED);
      AdjustChooseLevelScrollbar(SCREEN_CTRL_ID_SCROLL_VERTICAL,
				 leveldir_current->cl_first);
      return;
    }
  }
  else if (x == 1 && y > num_page_entries + 2)
  {
    if (leveldir_current->cl_first + num_page_entries < num_leveldirs &&
	(dy || DelayReached(&choose_delay, GADGET_FRAME_DELAY)))
    {
      leveldir_current->cl_first += step;
      if (leveldir_current->cl_first + num_page_entries > num_leveldirs)
	leveldir_current->cl_first = MAX(0, num_leveldirs - num_page_entries);

      drawChooseLevelList(leveldir_current->cl_first, num_page_entries);
      drawChooseLevelInfo(leveldir_current->cl_first +
			  leveldir_current->cl_cursor - 3);
      drawCursor(leveldir_current->cl_cursor - 1, FC_RED);
      AdjustChooseLevelScrollbar(SCREEN_CTRL_ID_SCROLL_VERTICAL,
				 leveldir_current->cl_first);
      return;
    }
  }

  if (!mx && !my && !dx && !dy)
  {
    x = 1;
    y = leveldir_current->cl_cursor;
  }

  if (dx == 1)
  {
    struct LevelDirInfo *node_first, *node_cursor;
    int leveldir_pos =
      leveldir_current->cl_first + leveldir_current->cl_cursor - 3;

    node_first = getLevelDirInfoFirstGroupEntry(leveldir_current);
    node_cursor = getLevelDirInfoFromPos(node_first, leveldir_pos);

    if (node_cursor->node_group)
    {
      node_cursor->cl_first = leveldir_current->cl_first;
      node_cursor->cl_cursor = leveldir_current->cl_cursor;
      leveldir_current = node_cursor->node_group;
      DrawChooseLevel();
    }
  }
  else if (dx == -1 && leveldir_current->node_parent)
  {
    leveldir_current = leveldir_current->node_parent;
    DrawChooseLevel();
  }

  if (x == 1 && y >= 3 && y <= num_page_entries + 2)
  {
    if (button)
    {
      if (y != leveldir_current->cl_cursor)
      {
	drawCursor(y - 1, FC_RED);
	drawCursor(leveldir_current->cl_cursor - 1, FC_BLUE);
	drawChooseLevelInfo(leveldir_current->cl_first + y - 3);
	leveldir_current->cl_cursor = y;
      }
    }
    else
    {
      struct LevelDirInfo *node_first, *node_cursor;
      int leveldir_pos = leveldir_current->cl_first + y - 3;

      node_first = getLevelDirInfoFirstGroupEntry(leveldir_current);
      node_cursor = getLevelDirInfoFromPos(node_first, leveldir_pos);

      if (node_cursor->node_group)
      {
	node_cursor->cl_first = leveldir_current->cl_first;
	node_cursor->cl_cursor = leveldir_current->cl_cursor;
	leveldir_current = node_cursor->node_group;

	DrawChooseLevel();
      }
      else if (node_cursor->parent_link)
      {
	leveldir_current = node_cursor->node_parent;

	DrawChooseLevel();
      }
      else
      {
	node_cursor->cl_first = leveldir_current->cl_first;
	node_cursor->cl_cursor = leveldir_current->cl_cursor;
	leveldir_current = node_cursor;

	LoadLevelSetup_SeriesInfo();

	SaveLevelSetup_LastSeries();
	SaveLevelSetup_SeriesInfo();

	game_status = MAINMENU;
	DrawMainMenu();
      }
    }
  }

  BackToFront();

  if (game_status == CHOOSELEVEL)
    DoAnimation();
}

void DrawHallOfFame(int highlight_position)
{
  UnmapAllGadgets();
  FadeSounds();

  if (highlight_position < 0) 
    LoadScore(level_nr);

  FadeToFront();
  InitAnimation();
  HandleHallOfFame(highlight_position,0, 0,0, MB_MENU_INITIALIZE);
  PlaySound(SND_HALLOFFAME);
}

static void drawHallOfFameList(int first_entry, int highlight_position)
{
  int i;

  ClearWindow();
  DrawText(SX + 80, SY + 8, "Hall Of Fame", FS_BIG, FC_YELLOW);
  DrawTextFCentered(46, FC_RED, "HighScores of Level %d", level_nr);

  for(i=0; i<MAX_LEVEL_SERIES_ON_SCREEN; i++)
  {
    int entry = first_entry + i;
    int color = (entry == highlight_position ? FC_RED : FC_GREEN);

#if 0
    DrawText(SX, SY + 64 + i * 32, "................", FS_BIG, color);
    DrawText(SX, SY + 64 + i * 32, highscore[i].Name, FS_BIG, color);
    DrawText(SX + 12 * 32, SY + 64 + i * 32,
	     int2str(highscore[i].Score, 5), FS_BIG, color);
#else
    DrawText(SX, SY + 64 + i * 32, "................................",
	     FS_MEDIUM, FC_YELLOW);
    DrawText(SX, SY + 64 + i * 32, int2str(entry + 1, 3),
	     FS_MEDIUM, FC_YELLOW);
    DrawText(SX + 64, SY + 64 + i * 32, highscore[entry].Name, FS_BIG, color);
    DrawText(SX + 13 * 32 + 16, SY + 64 + i * 32,
	     int2str(highscore[entry].Score, 5), FS_MEDIUM, color);
#endif
  }
}

void HandleHallOfFame(int mx, int my, int dx, int dy, int button)
{
  static int first_entry = 0;
  static int highlight_position = 0;
  int step = (button == 1 ? 1 : button == 2 ? 5 : 10);
  int button_released = !button;

  if (button == MB_MENU_INITIALIZE)
  {
    first_entry = 0;
    highlight_position = mx;
    drawHallOfFameList(first_entry, highlight_position);
    return;
  }

  if (ABS(dy) == SCR_FIELDY)	/* handle KSYM_Page_Up, KSYM_Page_Down */
    step = MAX_LEVEL_SERIES_ON_SCREEN - 1;

  if (dy < 0)
  {
    if (first_entry > 0)
    {
      first_entry -= step;
      if (first_entry < 0)
	first_entry = 0;

      drawHallOfFameList(first_entry, highlight_position);
      return;
    }
  }
  else if (dy > 0)
  {
    if (first_entry + MAX_LEVEL_SERIES_ON_SCREEN < MAX_SCORE_ENTRIES)
    {
      first_entry += step;
      if (first_entry + MAX_LEVEL_SERIES_ON_SCREEN > MAX_SCORE_ENTRIES)
	first_entry = MAX(0, MAX_SCORE_ENTRIES - MAX_LEVEL_SERIES_ON_SCREEN);

      drawHallOfFameList(first_entry, highlight_position);
      return;
    }
  }

  if (button_released)
  {
    FadeSound(SND_HALLOFFAME);
    game_status = MAINMENU;
    DrawMainMenu();
  }

  BackToFront();

  if (game_status == HALLOFFAME)
    DoAnimation();
}

void DrawSetupScreen()
{
  int i;
  static struct setup
  {
    boolean *value;
    char *text;
  } setup_info[] =
  {
    { &setup.sound,		"Sound:",	},
    { &setup.sound_loops,	"Sound Loops:"	},
    { &setup.sound_music,	"Game Music:"	},
    { &setup.fullscreen,	"Fullscreen:"	},
    { &setup.quick_doors,	"Quick Doors:"	},
    { &setup.handicap,		"Handicap:"	},
    { &setup.time_limit,	"Timelimit:"	},
    { NULL,			""		},
    { NULL,			"Exit"		},
    { NULL,			"Save and exit"	}
  };

  UnmapAllGadgets();
  ClearWindow();

  DrawText(SX + 16, SY + 16, "SETUP",FS_BIG,FC_YELLOW);

  for(i=SETUP_SCREEN_POS_START;i<=SETUP_SCREEN_POS_END;i++)
  {
    int base = i - SETUP_SCREEN_POS_START;

    if (!(i >= SETUP_SCREEN_POS_EMPTY1 && i <= SETUP_SCREEN_POS_EMPTY2))
    {
      DrawText(SX+32,SY+i*32, setup_info[base].text, FS_BIG,FC_GREEN);

      if (strcmp(setup_info[base].text, "Input Devices") == 0)
	initCursor(i, GFX_ARROW_BLUE_RIGHT);
      else
	initCursor(i, GFX_KUGEL_BLAU);
    }

    if (setup_info[base].value)
    {
      int setting_value = *setup_info[base].value;

      DrawText(SX+13*32, SY+i*32, (setting_value ? "on" : "off"),
	       FS_BIG, (setting_value ? FC_YELLOW : FC_BLUE));
    }
  }

  FadeToFront();
  InitAnimation();
  HandleSetupScreen(0,0,0,0,MB_MENU_INITIALIZE);
}

void HandleSetupScreen(int mx, int my, int dx, int dy, int button)
{
  static int choice = 3;
  static int redraw = TRUE;
  int x = (mx+32-SX)/32, y = (my+32-SY)/32;
  int pos_start  = SETUP_SCREEN_POS_START  + 1;
  int pos_empty1 = SETUP_SCREEN_POS_EMPTY1 + 1;
  int pos_empty2 = SETUP_SCREEN_POS_EMPTY2 + 1;
  int pos_end    = SETUP_SCREEN_POS_END    + 1;

  if (button == MB_MENU_INITIALIZE)
    redraw = TRUE;

  if (redraw)
  {
    drawCursor(choice - 1, FC_RED);
    redraw = FALSE;
  }

  if (button == MB_MENU_INITIALIZE)
    return;

  if (dx || dy)
  {
    if (dy)
    {
      x = 1;
      y = choice+dy;
    }
    else
      x = y = 0;

    if (y >= pos_empty1 && y <= pos_empty2)
      y = (dy > 0 ? pos_empty2 + 1 : pos_empty1 - 1);

    if (y < pos_start)
      y = pos_start;
    else if (y > pos_end)
      y = pos_end;
  }

  if (!mx && !my && !dx && !dy)
  {
    x = 1;
    y = choice;
  }

  if (x==1 && y >= pos_start && y <= pos_end &&
      !(y >= pos_empty1 && y <= pos_empty2))
  {
    if (button)
    {
      if (y!=choice)
      {
	drawCursor(y - 1, FC_RED);
	drawCursor(choice - 1, FC_BLUE);
      }
      choice = y;
    }
    else
    {
      int yy = y-1;

      if (y==3 && audio.sound_available)
      {
	if (setup.sound)
	{
	  DrawText(SX+13*32, SY+yy*32,"off",FS_BIG,FC_BLUE);
	  DrawText(SX+13*32, SY+(yy+1)*32,"off",FS_BIG,FC_BLUE);
	  DrawText(SX+13*32, SY+(yy+2)*32,"off",FS_BIG,FC_BLUE);
	  setup.sound_loops = FALSE;
	  setup.sound_music = FALSE;
	}
	else
	  DrawText(SX+13*32, SY+yy*32,"on ",FS_BIG,FC_YELLOW);
	setup.sound = !setup.sound;
      }
      else if (y==4 && audio.loops_available)
      {
	if (setup.sound_loops)
	  DrawText(SX+13*32, SY+yy*32,"off",FS_BIG,FC_BLUE);
	else
	{
	  DrawText(SX+13*32, SY+yy*32,"on ",FS_BIG,FC_YELLOW);
	  DrawText(SX+13*32, SY+(yy-1)*32,"on ",FS_BIG,FC_YELLOW);
	  setup.sound = TRUE;
	}
	setup.sound_loops = !setup.sound_loops;
      }
      else if (y==5 && audio.loops_available)
      {
	if (setup.sound_music)
	  DrawText(SX+13*32, SY+yy*32,"off",FS_BIG,FC_BLUE);
	else
	{
	  DrawText(SX+13*32, SY+yy*32,"on ",FS_BIG,FC_YELLOW);
	  DrawText(SX+13*32, SY+(yy-2)*32,"on ",FS_BIG,FC_YELLOW);
	  setup.sound = TRUE;
	}
	setup.sound_music = !setup.sound_music;
      }
      else if (y==6 && video.fullscreen_available)
      {
	if (setup.fullscreen)
	  DrawText(SX+13*32, SY+yy*32,"off",FS_BIG,FC_BLUE);
	else
	  DrawText(SX+13*32, SY+yy*32,"on ",FS_BIG,FC_YELLOW);
	setup.fullscreen = !setup.fullscreen;
      }
      else if (y==7)
      {
	if (setup.quick_doors)
	  DrawText(SX+13*32, SY+yy*32,"off",FS_BIG,FC_BLUE);
	else
	  DrawText(SX+13*32, SY+yy*32,"on ",FS_BIG,FC_YELLOW);
	setup.quick_doors = !setup.quick_doors;
      }
      else if (y==8)
      {
	if (setup.handicap)
	  DrawText(SX+13*32, SY+yy*32,"off",FS_BIG,FC_BLUE);
	else
	  DrawText(SX+13*32, SY+yy*32,"on ",FS_BIG,FC_YELLOW);
	setup.handicap = !setup.handicap;
      }
      else if (y==9)
      {
	if (setup.time_limit)
	  DrawText(SX+13*32, SY+yy*32,"off",FS_BIG,FC_BLUE);
	else
 	  DrawText(SX+13*32, SY+yy*32,"on ",FS_BIG,FC_YELLOW);
	setup.time_limit = !setup.time_limit;
      }
      else if (y==pos_end-1 || y==pos_end)
      {
        if (y==pos_end)
	  SaveSetup();

	game_status = MAINMENU;
	DrawMainMenu();
	redraw = TRUE;
      }
    }
  }
  BackToFront();

  if (game_status==SETUP)
    DoAnimation();
}

void HandleGameActions()
{
#if 0
  unsigned long delay;
#endif

  if (game_status != PLAYING)
    return;

  /*
  if (local_player->LevelSolved)
    GameWon();
  */

  /*
  printf("TEST 2: %ld\n", Counter());
  */

  /*
  printf(".");
  */

#if 1
  if (!button_status)
    ClickElement(0, 0, MB_NOT_PRESSED);
  GameActions();

  if (game.game_over)
  {
    char *request_text = "";

    StopSound(SND_WARNTON);

    switch(game.game_over_cause)
    {
      case GAME_OVER_NO_ENERGY:
	request_text = "Out of magic energy ! Play it again ?";
	break;

      case GAME_OVER_OVERLOADED:
	request_text = "Magic spell hit Mc Duffin ! Play it again ?";
	break;

      case GAME_OVER_BOMB:
	request_text = "Bomb killed Mc Duffin ! Play it again ?";
	break;

      default:
	request_text = "Game Over ! Play it again ?";
	break;
    }

    if (Request(request_text, REQ_ASK | REQ_STAY_CLOSED))
      InitGame();
    else
    {
      game_status = MAINMENU;
      DrawMainMenu();
    }
  }
  else if (game.level_solved)
  {
    StopSound(SND_WARNTON);

    GameWon();
  }
#endif


#if 0
   delay=Counter();
   ClickElement(0,0,MB_NOT_PRESSED);
   if (WN)
     GameWon();
      else
      {
        switch(GameActions(0,0,MB_NOT_PRESSED))
        {
	case ACT_GAME_OVER:
	  game_status=MAINMENU;
	  DrawMainMenu();
	  BackToFront();
	  break;
	case ACT_NEW_GAME:
	  game_status=PLAYING;
	  InitGame();
	  break;
	case ACT_GO_ON:
	  break;
	default:
	  break;
        }
      }
   if (!OL && delay<=Counter())
     WaitUntilDelayReached(&delay, 50);
#endif





  BackToFront();

#if 0
  /* !!! */
  Delay(10);
  /* !!! */
#endif

}

/* ---------- new screen button stuff -------------------------------------- */

/* graphic position and size values for buttons and scrollbars */
#define SC_SCROLLBUTTON_XPOS		64
#define SC_SCROLLBUTTON_YPOS		0
#define SC_SCROLLBAR_XPOS		0
#define SC_SCROLLBAR_YPOS		64

#define SC_SCROLLBUTTON_XSIZE		32
#define SC_SCROLLBUTTON_YSIZE		32

#define SC_SCROLL_UP_XPOS		(SXSIZE - SC_SCROLLBUTTON_XSIZE)
#define SC_SCROLL_UP_YPOS		SC_SCROLLBUTTON_YSIZE
#define SC_SCROLL_DOWN_XPOS		SC_SCROLL_UP_XPOS
#define SC_SCROLL_DOWN_YPOS		(SYSIZE - SC_SCROLLBUTTON_YSIZE)
#define SC_SCROLL_VERTICAL_XPOS		SC_SCROLL_UP_XPOS
#define SC_SCROLL_VERTICAL_YPOS	  (SC_SCROLL_UP_YPOS + SC_SCROLLBUTTON_YSIZE)
#define SC_SCROLL_VERTICAL_XSIZE	SC_SCROLLBUTTON_XSIZE
#define SC_SCROLL_VERTICAL_YSIZE	(SYSIZE - 3 * SC_SCROLLBUTTON_YSIZE)

#define SC_BORDER_SIZE			14

static struct
{
  int xpos, ypos;
  int x, y;
  int gadget_id;
  char *infotext;
} scrollbutton_info[NUM_SCREEN_SCROLLBUTTONS] =
{
  {
    SC_SCROLLBUTTON_XPOS + 0 * SC_SCROLLBUTTON_XSIZE,   SC_SCROLLBUTTON_YPOS,
    SC_SCROLL_UP_XPOS,					SC_SCROLL_UP_YPOS,
    SCREEN_CTRL_ID_SCROLL_UP,
    "scroll level series up"
  },
  {
    SC_SCROLLBUTTON_XPOS + 1 * SC_SCROLLBUTTON_XSIZE,   SC_SCROLLBUTTON_YPOS,
    SC_SCROLL_DOWN_XPOS,				SC_SCROLL_DOWN_YPOS,
    SCREEN_CTRL_ID_SCROLL_DOWN,
    "scroll level series down"
  }
};

static struct
{
  int xpos, ypos;
  int x, y;
  int width, height;
  int type;
  int gadget_id;
  char *infotext;
} scrollbar_info[NUM_SCREEN_SCROLLBARS] =
{
  {
    SC_SCROLLBAR_XPOS,			SC_SCROLLBAR_YPOS,
    SX + SC_SCROLL_VERTICAL_XPOS,	SY + SC_SCROLL_VERTICAL_YPOS,
    SC_SCROLL_VERTICAL_XSIZE,		SC_SCROLL_VERTICAL_YSIZE,
    GD_TYPE_SCROLLBAR_VERTICAL,
    SCREEN_CTRL_ID_SCROLL_VERTICAL,
    "scroll level series vertically"
  }
};

static void CreateScreenScrollbuttons()
{
  Bitmap *gd_bitmap = pix[PIX_BACK];
  struct GadgetInfo *gi;
  unsigned long event_mask;
  int i;

  for (i=0; i<NUM_SCREEN_SCROLLBUTTONS; i++)
  {
    int id = scrollbutton_info[i].gadget_id;
    int x, y, width, height;
    int gd_x1, gd_x2, gd_y1, gd_y2;

    x = scrollbutton_info[i].x;
    y = scrollbutton_info[i].y;

    event_mask = GD_EVENT_PRESSED | GD_EVENT_REPEATED;

    x += SX;
    y += SY;
    width = SC_SCROLLBUTTON_XSIZE;
    height = SC_SCROLLBUTTON_YSIZE;
    gd_x1 = scrollbutton_info[i].xpos;
    gd_y1 = scrollbutton_info[i].ypos;
    gd_x2 = gd_x1;
    gd_y2 = gd_y1 + SC_SCROLLBUTTON_YSIZE;

    gi = CreateGadget(GDI_CUSTOM_ID, id,
		      GDI_CUSTOM_TYPE_ID, i,
		      GDI_INFO_TEXT, scrollbutton_info[i].infotext,
		      GDI_X, x,
		      GDI_Y, y,
		      GDI_WIDTH, width,
		      GDI_HEIGHT, height,
		      GDI_TYPE, GD_TYPE_NORMAL_BUTTON,
		      GDI_STATE, GD_BUTTON_UNPRESSED,
		      GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y1,
		      GDI_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y2,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_ACTION, HandleScreenGadgets,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    screen_gadget[id] = gi;
  }
}

static void CreateScreenScrollbars()
{
  int i;

  for (i=0; i<NUM_SCREEN_SCROLLBARS; i++)
  {
    int id = scrollbar_info[i].gadget_id;
    Bitmap *gd_bitmap = pix[PIX_BACK];
    int gd_x1, gd_x2, gd_y1, gd_y2;
    struct GadgetInfo *gi;
    int items_max, items_visible, item_position;
    unsigned long event_mask;
    int num_page_entries = MAX_LEVEL_SERIES_ON_SCREEN - 1;

#if 0
    if (num_leveldirs <= MAX_LEVEL_SERIES_ON_SCREEN)
      num_page_entries = num_leveldirs;
    else
      num_page_entries = MAX_LEVEL_SERIES_ON_SCREEN - 1;

    items_max = MAX(num_leveldirs, num_page_entries);
    items_visible = num_page_entries;
    item_position = 0;
#else
    items_max = num_page_entries;
    items_visible = num_page_entries;
    item_position = 0;
#endif

    event_mask = GD_EVENT_MOVING | GD_EVENT_OFF_BORDERS;

    gd_x1 = scrollbar_info[i].xpos;
    gd_x2 = gd_x1 + scrollbar_info[i].width;
    gd_y1 = scrollbar_info[i].ypos;
    gd_y2 = scrollbar_info[i].ypos;

    gi = CreateGadget(GDI_CUSTOM_ID, id,
		      GDI_CUSTOM_TYPE_ID, i,
		      GDI_INFO_TEXT, scrollbar_info[i].infotext,
		      GDI_X, scrollbar_info[i].x,
		      GDI_Y, scrollbar_info[i].y,
		      GDI_WIDTH, scrollbar_info[i].width,
		      GDI_HEIGHT, scrollbar_info[i].height,
		      GDI_TYPE, scrollbar_info[i].type,
		      GDI_SCROLLBAR_ITEMS_MAX, items_max,
		      GDI_SCROLLBAR_ITEMS_VISIBLE, items_visible,
		      GDI_SCROLLBAR_ITEM_POSITION, item_position,
		      GDI_STATE, GD_BUTTON_UNPRESSED,
		      GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y1,
		      GDI_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y2,
		      GDI_BORDER_SIZE, SC_BORDER_SIZE,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_ACTION, HandleScreenGadgets,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    screen_gadget[id] = gi;
  }
}

void CreateScreenGadgets()
{
  CreateScreenScrollbuttons();
  CreateScreenScrollbars();
}

void MapChooseLevelGadgets()
{
  int num_leveldirs = numLevelDirInfoInGroup(leveldir_current);
  int i;

  if (num_leveldirs <= MAX_LEVEL_SERIES_ON_SCREEN)
    return;

  for (i=0; i<NUM_SCREEN_GADGETS; i++)
    MapGadget(screen_gadget[i]);
}

void UnmapChooseLevelGadgets()
{
  int i;

  for (i=0; i<NUM_SCREEN_GADGETS; i++)
    UnmapGadget(screen_gadget[i]);
}

static void HandleScreenGadgets(struct GadgetInfo *gi)
{
  int id = gi->custom_id;

  if (game_status != CHOOSELEVEL)
    return;

  switch (id)
  {
    case SCREEN_CTRL_ID_SCROLL_UP:
      HandleChooseLevel(SX,SY + 32, 0,0, MB_MENU_MARK);
      break;

    case SCREEN_CTRL_ID_SCROLL_DOWN:
      HandleChooseLevel(SX,SY + SYSIZE - 32, 0,0, MB_MENU_MARK);
      break;

    case SCREEN_CTRL_ID_SCROLL_VERTICAL:
      HandleChooseLevel(0,0, 999,gi->event.item_position, MB_MENU_INITIALIZE);
      break;

    default:
      break;
  }
}
