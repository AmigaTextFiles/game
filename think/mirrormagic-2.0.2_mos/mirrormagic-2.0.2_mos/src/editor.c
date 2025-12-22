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
* editor.c                                                 *
***********************************************************/

#include <math.h>

#include "libgame/libgame.h"

#include "editor.h"
#include "screens.h"
#include "tools.h"
#include "files.h"
#include "game.h"

/* positions in the level editor */
#define ED_WIN_MB_LEFT_XPOS		7
#define ED_WIN_MB_LEFT_YPOS		154
#define ED_WIN_MB_MIDDLE_XPOS		42
#define ED_WIN_MB_MIDDLE_YPOS		ED_WIN_MB_LEFT_YPOS
#define ED_WIN_MB_RIGHT_XPOS		77
#define ED_WIN_MB_RIGHT_YPOS		ED_WIN_MB_LEFT_YPOS

/* other constants for the editor */
#define ED_SCROLL_NO			0
#define ED_SCROLL_LEFT			1
#define ED_SCROLL_RIGHT			2
#define ED_SCROLL_UP			4
#define ED_SCROLL_DOWN			8

/* screens in the level editor */
#define ED_MODE_DRAWING			0
#define ED_MODE_INFO			1
#define ED_MODE_PROPERTIES		2

/* how many steps can be cancelled */
#define NUM_UNDO_STEPS			(10 + 1)

/* values for elements with score */
#define MIN_SCORE			0
#define MAX_SCORE			255

/* values for the control window */
#define ED_CTRL_BUTTONS_GFX_YPOS 	178
#define ED_CTRL_BUTTONS_ALT_GFX_YPOS 	118

#define ED_CTRL1_BUTTONS_HORIZ		4
#define ED_CTRL1_BUTTONS_VERT		3
#define ED_CTRL1_BUTTON_XSIZE		22
#define ED_CTRL1_BUTTON_YSIZE		20
#define ED_CTRL1_BUTTONS_XPOS		6
#define ED_CTRL1_BUTTONS_YPOS		0
#define ED_CTRL2_BUTTONS_HORIZ		3
#define ED_CTRL2_BUTTONS_VERT		2
#define ED_CTRL2_BUTTON_XSIZE		30
#define ED_CTRL2_BUTTON_YSIZE		16
#define ED_CTRL2_BUTTONS_XPOS		5
#define ED_CTRL2_BUTTONS_YPOS		65
#define ED_NUM_CTRL1_BUTTONS   (ED_CTRL1_BUTTONS_HORIZ * ED_CTRL1_BUTTONS_VERT)
#define ED_NUM_CTRL2_BUTTONS   (ED_CTRL2_BUTTONS_HORIZ * ED_CTRL2_BUTTONS_VERT)
#define ED_NUM_CTRL_BUTTONS    (ED_NUM_CTRL1_BUTTONS + ED_NUM_CTRL2_BUTTONS)

/* values for the element list */
#define ED_ELEMENTLIST_XPOS		5
#define ED_ELEMENTLIST_YPOS		26
#define ED_ELEMENTLIST_XSIZE		20
#define ED_ELEMENTLIST_YSIZE		20
#define ED_ELEMENTLIST_BUTTONS_HORIZ	4
#define ED_ELEMENTLIST_BUTTONS_VERT	6
#define ED_NUM_ELEMENTLIST_BUTTONS	(ED_ELEMENTLIST_BUTTONS_HORIZ * \
					 ED_ELEMENTLIST_BUTTONS_VERT)

/* values for the drawing element buttons */
#define ED_DRAWING_ELEMENT_XPOS		5
#define ED_DRAWING_ELEMENT_YPOS		152
#define ED_DRAWING_ELEMENT_XSIZE	ED_ELEMENTLIST_XSIZE
#define ED_DRAWING_ELEMENT_YSIZE	ED_ELEMENTLIST_YSIZE
#define ED_DRAWING_ELEMENT_XDISTANCE	35
#define ED_NUM_DRAWING_ELEMENT_BUTTONS	3

/* values for the setting windows */
#define ED_SETTINGS_XPOS		(MINI_TILEX + 8)
#define ED_SETTINGS2_XPOS		MINI_TILEX
#define ED_SETTINGS_YPOS		MINI_TILEY
#define ED_SETTINGS2_YPOS		(ED_SETTINGS_YPOS + 12 * TILEY - 2)

/* values for counter gadgets */
#define ED_COUNT_ELEM_SCORE_XPOS	ED_SETTINGS_XPOS
#define ED_COUNT_ELEM_SCORE_YPOS	(14 * MINI_TILEY)
#define ED_COUNT_ELEM_CONTENT_XPOS	ED_SETTINGS_XPOS
#define ED_COUNT_ELEM_CONTENT_YPOS	(19 * MINI_TILEY)

#define ED_COUNTER_YSTART		(ED_SETTINGS_YPOS + 2 * TILEY)
#define ED_COUNTER_YDISTANCE		(3 * MINI_TILEY)
#define ED_COUNTER_YPOS(n)		(ED_COUNTER_YSTART + \
					 n * ED_COUNTER_YDISTANCE)
#define ED_COUNTER2_YPOS(n)		(ED_COUNTER_YSTART + \
					 n * ED_COUNTER_YDISTANCE - 2)
/* standard distances */
#define ED_BORDER_SIZE			3
#define ED_GADGET_DISTANCE		2

/* values for element content drawing areas */
#define ED_AREA_ELEM_CONTENT_XPOS	( 2 * MINI_TILEX)
#define ED_AREA_ELEM_CONTENT_YPOS	(22 * MINI_TILEY)

/* values for random placement background drawing area */
#define ED_AREA_RANDOM_BACKGROUND_XPOS	(29 * MINI_TILEX)
#define ED_AREA_RANDOM_BACKGROUND_YPOS	(31 * MINI_TILEY)

/* values for scrolling gadgets for drawing area */
#define ED_SCROLLBUTTON_XPOS		24
#define ED_SCROLLBUTTON_YPOS		0
#define ED_SCROLLBAR_XPOS		24
#define ED_SCROLLBAR_YPOS		64

#define ED_SCROLLBUTTON_XSIZE		16
#define ED_SCROLLBUTTON_YSIZE		16

#define ED_SCROLL_UP_XPOS		(SXSIZE - ED_SCROLLBUTTON_XSIZE)
#define ED_SCROLL_UP_YPOS		(0)
#define ED_SCROLL_DOWN_XPOS		ED_SCROLL_UP_XPOS
#define ED_SCROLL_DOWN_YPOS		(SYSIZE - 3 * ED_SCROLLBUTTON_YSIZE)
#define ED_SCROLL_LEFT_XPOS		(0)
#define ED_SCROLL_LEFT_YPOS		(SYSIZE - 2 * ED_SCROLLBUTTON_YSIZE)
#define ED_SCROLL_RIGHT_XPOS		(SXSIZE - 2 * ED_SCROLLBUTTON_XSIZE)
#define ED_SCROLL_RIGHT_YPOS		ED_SCROLL_LEFT_YPOS
#define ED_SCROLL_HORIZONTAL_XPOS (ED_SCROLL_LEFT_XPOS + ED_SCROLLBUTTON_XSIZE)
#define ED_SCROLL_HORIZONTAL_YPOS	ED_SCROLL_LEFT_YPOS
#define ED_SCROLL_HORIZONTAL_XSIZE	(SXSIZE - 3 * ED_SCROLLBUTTON_XSIZE)
#define ED_SCROLL_HORIZONTAL_YSIZE	ED_SCROLLBUTTON_YSIZE
#define ED_SCROLL_VERTICAL_XPOS		ED_SCROLL_UP_XPOS
#define ED_SCROLL_VERTICAL_YPOS	  (ED_SCROLL_UP_YPOS + ED_SCROLLBUTTON_YSIZE)
#define ED_SCROLL_VERTICAL_XSIZE	ED_SCROLLBUTTON_XSIZE
#define ED_SCROLL_VERTICAL_YSIZE	(SYSIZE - 4 * ED_SCROLLBUTTON_YSIZE)

/* values for scrolling gadgets for element list */
#define ED_SCROLLBUTTON2_XPOS		50
#define ED_SCROLLBUTTON2_YPOS		0
#define ED_SCROLLBAR2_XPOS		50
#define ED_SCROLLBAR2_YPOS		20

#define ED_SCROLLBUTTON2_XSIZE		10
#define ED_SCROLLBUTTON2_YSIZE		10

#define ED_SCROLL2_UP_XPOS		85
#define ED_SCROLL2_UP_YPOS		26
#define ED_SCROLL2_DOWN_XPOS		ED_SCROLL2_UP_XPOS
#define ED_SCROLL2_DOWN_YPOS		(ED_SCROLL2_UP_YPOS + \
					 ED_ELEMENTLIST_BUTTONS_VERT * \
					 ED_ELEMENTLIST_YSIZE - \
					 ED_SCROLLBUTTON2_YSIZE)
#define ED_SCROLL2_VERTICAL_XPOS	ED_SCROLL2_UP_XPOS
#define ED_SCROLL2_VERTICAL_YPOS	(ED_SCROLL2_UP_YPOS + \
					 ED_SCROLLBUTTON2_YSIZE)
#define ED_SCROLL2_VERTICAL_XSIZE	ED_SCROLLBUTTON2_XSIZE
#define ED_SCROLL2_VERTICAL_YSIZE	(ED_ELEMENTLIST_BUTTONS_VERT * \
					 ED_ELEMENTLIST_YSIZE - \
					 2 * ED_SCROLLBUTTON2_YSIZE)

/* values for checkbutton gadgets */
#define ED_CHECKBUTTON_XSIZE		ED_BUTTON_COUNT_XSIZE
#define ED_CHECKBUTTON_YSIZE		ED_BUTTON_COUNT_YSIZE
#define ED_CHECKBUTTON_UNCHECKED_XPOS	ED_BUTTON_MINUS_XPOS
#define ED_CHECKBUTTON_CHECKED_XPOS	ED_BUTTON_PLUS_XPOS
#define ED_CHECKBUTTON_YPOS		(ED_BUTTON_MINUS_YPOS + 22)
#define ED_RADIOBUTTON_YPOS		(ED_BUTTON_MINUS_YPOS + 44)
#define ED_STICKYBUTTON_YPOS		(ED_BUTTON_MINUS_YPOS + 66)

/* some positions in the editor control window */
#define ED_BUTTON_ELEM_XPOS	6
#define ED_BUTTON_ELEM_YPOS	30
#define ED_BUTTON_ELEM_XSIZE	22
#define ED_BUTTON_ELEM_YSIZE	22

/* some values for text input and counter gadgets */
#define ED_BUTTON_COUNT_YPOS	60
#define ED_BUTTON_COUNT_XSIZE	20
#define ED_BUTTON_COUNT_YSIZE	20
#define ED_WIN_COUNT_XPOS	(2 + ED_BUTTON_COUNT_XSIZE + 2)
#define ED_WIN_COUNT_YPOS	ED_BUTTON_COUNT_YPOS
#define ED_WIN_COUNT_XSIZE	52
#define ED_WIN_COUNT_YSIZE	ED_BUTTON_COUNT_YSIZE
#define ED_WIN_COUNT2_XPOS	27
#define ED_WIN_COUNT2_YPOS	3
#define ED_WIN_COUNT2_XSIZE	46
#define ED_WIN_COUNT2_YSIZE	ED_BUTTON_COUNT_YSIZE

#define ED_BUTTON_MINUS_XPOS	2
#define ED_BUTTON_MINUS_YPOS	ED_BUTTON_COUNT_YPOS
#define ED_BUTTON_MINUS_XSIZE	ED_BUTTON_COUNT_XSIZE
#define ED_BUTTON_MINUS_YSIZE	ED_BUTTON_COUNT_YSIZE
#define ED_BUTTON_PLUS_XPOS	(ED_WIN_COUNT_XPOS + ED_WIN_COUNT_XSIZE + 2)
#define ED_BUTTON_PLUS_YPOS	ED_BUTTON_COUNT_YPOS
#define ED_BUTTON_PLUS_XSIZE	ED_BUTTON_COUNT_XSIZE
#define ED_BUTTON_PLUS_YSIZE	ED_BUTTON_COUNT_YSIZE

/* editor gadget identifiers */

/* drawing toolbox buttons */
#define GADGET_ID_NONE			-1
#define GADGET_ID_SINGLE_ITEMS		0
#define GADGET_ID_LINE			1
#define GADGET_ID_WRAP_UP		2
#define GADGET_ID_ARC			3
#define GADGET_ID_FLOOD_FILL		4
#define GADGET_ID_WRAP_LEFT		5
#define GADGET_ID_GRAB_BRUSH		6
#define GADGET_ID_WRAP_RIGHT		7
#define GADGET_ID_RECTANGLE		8
#define GADGET_ID_FILLED_BOX		9
#define GADGET_ID_WRAP_DOWN		10
#define GADGET_ID_PICK_ELEMENT		11
#define GADGET_ID_UNDO			12
#define GADGET_ID_INFO			13
#define GADGET_ID_SAVE			14
#define GADGET_ID_CLEAR			15
#define GADGET_ID_TEST			16
#define GADGET_ID_EXIT			17

/* counter button identifiers */
#define GADGET_ID_LEVEL_COLLECT_DOWN	18
#define GADGET_ID_LEVEL_COLLECT_TEXT	19
#define GADGET_ID_LEVEL_COLLECT_UP	20
#define GADGET_ID_LEVEL_TIMELIMIT_DOWN	21
#define GADGET_ID_LEVEL_TIMELIMIT_TEXT	22
#define GADGET_ID_LEVEL_TIMELIMIT_UP	23
#define GADGET_ID_SELECT_LEVEL_DOWN	24
#define GADGET_ID_SELECT_LEVEL_TEXT	25
#define GADGET_ID_SELECT_LEVEL_UP	26

/* drawing area identifiers */
#define GADGET_ID_DRAWING_LEVEL		27

/* text input identifiers */
#define GADGET_ID_LEVEL_NAME		28
#define GADGET_ID_LEVEL_AUTHOR		29

/* gadgets for scrolling element list */
#define GADGET_ID_SCROLL_LIST_UP	30
#define GADGET_ID_SCROLL_LIST_DOWN	31
#define GADGET_ID_SCROLL_LIST_VERTICAL	32

/* buttons for level settings */
#define GADGET_ID_AUTO_COUNT		33
#define GADGET_ID_LASER_RED		34
#define GADGET_ID_LASER_GREEN		35
#define GADGET_ID_LASER_BLUE		36

/* gadgets for drawing element buttons */
#define GADGET_ID_DRAWING_ELEMENT_LEFT	 37
#define GADGET_ID_DRAWING_ELEMENT_MIDDLE 38
#define GADGET_ID_DRAWING_ELEMENT_RIGHT	 39

/* gadgets for buttons in element list */
#define GADGET_ID_ELEMENTLIST_FIRST	40
#define GADGET_ID_ELEMENTLIST_LAST	(GADGET_ID_ELEMENTLIST_FIRST +	\
					 ED_NUM_ELEMENTLIST_BUTTONS - 1)

#define NUM_EDITOR_GADGETS		(GADGET_ID_ELEMENTLIST_LAST + 1)

/* radio button numbers */
#define RADIO_NR_NONE			0
#define RADIO_NR_DRAWING_TOOLBOX	1
#define RADIO_NR_RANDOM_ELEMENTS	2

/* values for counter gadgets */
#define ED_COUNTER_ID_LEVEL_COLLECT	0
#define ED_COUNTER_ID_LEVEL_TIMELIMIT	1
#define ED_COUNTER_ID_SELECT_LEVEL	2

#define ED_NUM_COUNTERBUTTONS		3

#define ED_COUNTER_ID_LEVEL_FIRST	ED_COUNTER_ID_LEVEL_COLLECT
#define ED_COUNTER_ID_LEVEL_LAST	ED_COUNTER_ID_SELECT_LEVEL

/* values for scrollbutton gadgets */
#define ED_SCROLLBUTTON_ID_LIST_UP	0
#define ED_SCROLLBUTTON_ID_LIST_DOWN	1

#define ED_NUM_SCROLLBUTTONS		2

/* values for additional counter graphics */
#define ED_DUMMYBUTTON_ID_LEVEL_LEFT	0
#define ED_DUMMYBUTTON_ID_LEVEL_RIGHT	1

#define ED_NUM_DUMMYBUTTONS		2

#define ED_SCROLLBUTTON_ID_AREA_FIRST	ED_SCROLLBUTTON_ID_AREA_UP
#define ED_SCROLLBUTTON_ID_AREA_LAST	ED_SCROLLBUTTON_ID_AREA_RIGHT

/* values for scrollbar gadgets */
#define ED_SCROLLBAR_ID_LIST_VERTICAL	0

#define ED_NUM_SCROLLBARS		1

#define ED_SCROLLBAR_ID_AREA_FIRST	ED_SCROLLBAR_ID_AREA_HORIZONTAL
#define ED_SCROLLBAR_ID_AREA_LAST	ED_SCROLLBAR_ID_AREA_VERTICAL

/* values for text input gadgets */
#define ED_TEXTINPUT_ID_LEVEL_NAME	0
#define ED_TEXTINPUT_ID_LEVEL_AUTHOR	1

#define ED_NUM_TEXTINPUT		2

#define ED_TEXTINPUT_ID_LEVEL_FIRST	ED_TEXTINPUT_ID_LEVEL_NAME
#define ED_TEXTINPUT_ID_LEVEL_LAST	ED_TEXTINPUT_ID_LEVEL_AUTHOR

/* values for checkbutton gadgets */
#define ED_CHECKBUTTON_ID_AUTO_COUNT		0
#define ED_CHECKBUTTON_ID_LASER_RED		1
#define ED_CHECKBUTTON_ID_LASER_GREEN		2
#define ED_CHECKBUTTON_ID_LASER_BLUE		3

#define ED_NUM_CHECKBUTTONS			4

#define ED_CHECKBUTTON_ID_LEVEL_FIRST	ED_CHECKBUTTON_ID_AUTO_COUNT
#define ED_CHECKBUTTON_ID_LEVEL_LAST	ED_CHECKBUTTON_ID_LASER_BLUE

/* values for CopyLevelToUndoBuffer() */
#define UNDO_IMMEDIATE			0
#define UNDO_ACCUMULATE			1

/* values for ClearEditorGadgetInfoText() and HandleGadgetInfoText() */
#define INFOTEXT_XPOS			SX
#define INFOTEXT_YPOS			(SY + SYSIZE - MINI_TILEX + 2)
#define INFOTEXT_XSIZE			SXSIZE
#define INFOTEXT_YSIZE			MINI_TILEX
#define MAX_INFOTEXT_LEN		(SXSIZE / FONT2_XSIZE)

static struct
{
  char shortcut;
  char *text;
} control_info[ED_NUM_CTRL_BUTTONS] =
{
  { 's', "draw single items" },
  { 'l', "draw lines" },
  { '\0', "wrap (rotate) level up" },
  { 'a', "draw arcs" },

  { 'f', "flood fill" },
  { '\0', "wrap (rotate) level left" },
  { 'b', "grab brush" },
  { '\0', "wrap (rotate) level right" },

  { 'r', "draw outline rectangles" },
  { 'R', "draw filled rectangles" },
  { '\0', "wrap (rotate) level down" },
  { ',', "pick drawing element" },

  { 'U', "undo last operation" },
  { 'I', "level properties" },
  { 'S', "save level" },

  { 'C', "clear level" },
  { 'T', "test level" },
  { 'E', "exit level editor" }
};

static struct
{
  int x, y;
  int min_value, max_value;
  int gadget_id_down, gadget_id_up;
  int gadget_id_text;
  int *value;
  char *infotext_above, *infotext_right;
} counterbutton_info[ED_NUM_COUNTERBUTTONS] =
{
  {
    ED_SETTINGS_XPOS,			ED_COUNTER_YPOS(3),
    0,					999,
    GADGET_ID_LEVEL_COLLECT_DOWN,	GADGET_ID_LEVEL_COLLECT_UP,
    GADGET_ID_LEVEL_COLLECT_TEXT,
    &level.kettles_needed,
    "number of kettles to collect",	NULL
  },
  {
    ED_SETTINGS_XPOS,			ED_COUNTER_YPOS(4),
    0,					MAX_LASER_ENERGY,
    GADGET_ID_LEVEL_TIMELIMIT_DOWN,	GADGET_ID_LEVEL_TIMELIMIT_UP,
    GADGET_ID_LEVEL_TIMELIMIT_TEXT,
    &level.time,
    "time available to solve level",	"(0 => no time limit)"
  },
  {
    DX + 5 - SX,			DY + 3 - SY,
    1,					100,
    GADGET_ID_SELECT_LEVEL_DOWN,	GADGET_ID_SELECT_LEVEL_UP,
    GADGET_ID_SELECT_LEVEL_TEXT,
    &level_nr,
    NULL,				NULL
  }
};

static struct
{
  int x, y;
  int gadget_id;
  int size;
  char *value;
  char *infotext;
} textinput_info[ED_NUM_TEXTINPUT] =
{
  {
    ED_SETTINGS_XPOS,			ED_COUNTER_YPOS(0),
    GADGET_ID_LEVEL_NAME,
    MAX_LEVEL_NAME_LEN,
    level.name,
    "Title"
  },
  {
    ED_SETTINGS_XPOS,			ED_COUNTER_YPOS(1),
    GADGET_ID_LEVEL_AUTHOR,
    MAX_LEVEL_AUTHOR_LEN,
    level.author,
    "Author"
  }
};

static struct
{
  int xpos, ypos;
  int x, y;
  int gadget_id;
  char *infotext;
} scrollbutton_info[ED_NUM_SCROLLBUTTONS] =
{
  {
    ED_SCROLLBUTTON2_XPOS,  ED_SCROLLBUTTON2_YPOS + 0 * ED_SCROLLBUTTON2_YSIZE,
    ED_SCROLL2_UP_XPOS,     ED_SCROLL2_UP_YPOS,
    GADGET_ID_SCROLL_LIST_UP,
    "scroll element list up ('Page Up')"
  },
  {
    ED_SCROLLBUTTON2_XPOS,  ED_SCROLLBUTTON2_YPOS + 1 * ED_SCROLLBUTTON2_YSIZE,
    ED_SCROLL2_DOWN_XPOS,    ED_SCROLL2_DOWN_YPOS,
    GADGET_ID_SCROLL_LIST_DOWN,
    "scroll element list down ('Page Down')"
  }
}, dummybutton_info[ED_NUM_DUMMYBUTTONS] =
{
  {
    ED_SCROLLBUTTON_XPOS,   ED_SCROLLBUTTON_YPOS + 2 * ED_SCROLLBUTTON_YSIZE,
    ED_SCROLL_LEFT_XPOS,    ED_SCROLL_LEFT_YPOS,
    GADGET_ID_NONE,
    "[dummy level down]"
  },
  {
    ED_SCROLLBUTTON_XPOS,   ED_SCROLLBUTTON_YPOS + 3 * ED_SCROLLBUTTON_YSIZE,
    ED_SCROLL_RIGHT_XPOS,   ED_SCROLL_RIGHT_YPOS,
    GADGET_ID_NONE,
    "[dummy level up]"
  },
}
;

static struct
{
  int xpos, ypos;
  int x, y;
  int width, height;
  int type;
  int gadget_id;
  char *infotext;
} scrollbar_info[ED_NUM_SCROLLBARS] =
{
  {
    ED_SCROLLBAR2_XPOS,			ED_SCROLLBAR2_YPOS,
    DX + ED_SCROLL2_VERTICAL_XPOS,	DY + ED_SCROLL2_VERTICAL_YPOS,
    ED_SCROLL2_VERTICAL_XSIZE,		ED_SCROLL2_VERTICAL_YSIZE,
    GD_TYPE_SCROLLBAR_VERTICAL,
    GADGET_ID_SCROLL_LIST_VERTICAL,
    "scroll element list vertically"
  }
};

static struct
{
  int x, y;
  int gadget_id;
  boolean *value;
  char *text, *infotext;
} checkbutton_info[ED_NUM_CHECKBUTTONS] =
{
  {
    ED_SETTINGS_XPOS + 160,		ED_COUNTER_YPOS(3),
    GADGET_ID_AUTO_COUNT,
    &level.auto_count_kettles,
    "auto count kettles",		"set counter to number of kettles"
  },
  {
    ED_SETTINGS_XPOS,			ED_COUNTER_YPOS(5),
    GADGET_ID_LASER_RED,
    &level.laser_red,
    "red",				"use red color component in laser"
  },
  {
    ED_SETTINGS_XPOS + 120,		ED_COUNTER_YPOS(5),
    GADGET_ID_LASER_GREEN,
    &level.laser_green,
    "green",				"use green color component in laser"
  },
  {
    ED_SETTINGS_XPOS + 240,		ED_COUNTER_YPOS(5),
    GADGET_ID_LASER_BLUE,
    &level.laser_blue,
    "blue",				"use blue color component in laser"
  }
};

/* maximal size of level editor drawing area */
#define MAX_ED_FIELDX		(2 * SCR_FIELDX)
#define MAX_ED_FIELDY		(2 * SCR_FIELDY)

/* actual size of level editor drawing area */
static int ed_fieldx = MAX_ED_FIELDX, ed_fieldy = MAX_ED_FIELDY;

/* actual position of level editor drawing area in level playfield */
static int level_xpos = 0, level_ypos = 0;

#define IN_ED_FIELD(x,y)  ((x)>=0 && (x)<ed_fieldx && (y)>=0 &&(y)<ed_fieldy)

/* drawing elements on the three mouse buttons */
static int new_drawing_element[4] =
{
  0,			/* dummy for convenient access by 1, 2 and 3 */
  EL_MIRROR_START,
  EL_EMPTY,
  EL_WALL_WOOD
};

#define BUTTON_ELEMENT(button) ((button) >= 1 && (button) <= 3 ?	\
				new_drawing_element[button] : EL_EMPTY)
#define BUTTON_STEPSIZE(button) ((button) == 1 ? 1 : (button) == 2 ? 5 : 10)

/* forward declaration for internal use */
static void ModifyEditorCounter(int, int);
static void ModifyEditorCounterLimits(int, int, int);
static void DrawDrawingWindow();
static void DrawLevelInfoWindow();
static void CopyLevelToUndoBuffer(int);
static void HandleDrawingAreas(struct GadgetInfo *);
static void HandleCounterButtons(struct GadgetInfo *);
static void HandleTextInputGadgets(struct GadgetInfo *);
static void HandleCheckbuttons(struct GadgetInfo *);
static void HandleControlButtons(struct GadgetInfo *);
static void HandleDrawingAreaInfo(struct GadgetInfo *);

static struct GadgetInfo *level_editor_gadget[NUM_EDITOR_GADGETS];

static int drawing_function = GADGET_ID_SINGLE_ITEMS;
static int last_drawing_function = GADGET_ID_SINGLE_ITEMS;
static boolean draw_with_brush = FALSE;

static short FieldBackup[MAX_LEV_FIELDX][MAX_LEV_FIELDY];
static short UndoBuffer[NUM_UNDO_STEPS][MAX_LEV_FIELDX][MAX_LEV_FIELDY];
static int undo_buffer_position = 0;
static int undo_buffer_steps = 0;

static int edit_mode;

static int counter_xsize = DXSIZE + FONT2_XSIZE - 2 * ED_GADGET_DISTANCE;

int element_shift = 0;

int editor_element[] =
{
  EL_CHAR('M'),
  EL_CHAR('I'),
  EL_CHAR('N'),
  EL_CHAR('D'),

  EL_CHAR('B'),
  EL_CHAR('E'),
  EL_CHAR('N'),
  EL_CHAR('-'),

  EL_CHAR('D'),
  EL_CHAR('E'),
  EL_CHAR('R'),
  EL_EMPTY,

  EL_MCDUFFIN_RIGHT,
  EL_MCDUFFIN_UP,
  EL_MCDUFFIN_LEFT,
  EL_MCDUFFIN_DOWN,

  EL_MIRROR_START,
  EL_MIRROR_FIXED_START,
  EL_POLAR_START,
  EL_POLAR_CROSS_START,

  EL_BEAMER_RED_START,
  EL_BEAMER_YELLOW_START,
  EL_BEAMER_GREEN_START,
  EL_BEAMER_BLUE_START,

  EL_PRISM,
  EL_FUSE_ON,
  EL_PACMAN_RIGHT,
  EL_EXIT_CLOSED,

  EL_KETTLE,
  EL_BOMB,
  EL_KEY,
  EL_FUEL_FULL,

  EL_LIGHTBULB_OFF,
  EL_LIGHTBULB_ON,
  EL_BALL_GRAY,
  EL_LIGHTBALL,

  EL_WALL_STEEL,
  EL_WALL_WOOD,
  EL_WALL_ICE,
  EL_WALL_AMOEBA,

  EL_GATE_STONE,
  EL_GATE_WOOD,
  EL_BLOCK_STONE,
  EL_BLOCK_WOOD,

  EL_GRID_STEEL_00,
  EL_GRID_STEEL_01,
  EL_GRID_STEEL_02,
  EL_GRID_STEEL_03,

  EL_GRID_WOOD_00,
  EL_GRID_WOOD_01,
  EL_GRID_WOOD_02,
  EL_GRID_WOOD_03,

  EL_CHAR('D'),
  EL_CHAR('E'),
  EL_CHAR('-'),
  EL_EMPTY,

  EL_CHAR('F'),
  EL_CHAR('L'),
  EL_CHAR('E'),
  EL_CHAR('K'),

  EL_CHAR('T'),
  EL_CHAR('O'),
  EL_CHAR('R'),
  EL_EMPTY,

  EL_LASER_UP,
  EL_RECEIVER_UP,
  EL_DF_MIRROR_START,
  EL_DF_MIRROR_AUTO_START,

  EL_FIBRE_OPTIC_00,
  EL_FIBRE_OPTIC_02,
  EL_FIBRE_OPTIC_04,
  EL_FIBRE_OPTIC_06,

  EL_GRID_STEEL_FIXED_START,
  EL_GRID_STEEL_AUTO_START,
  EL_GRID_WOOD_FIXED_START,
  EL_GRID_WOOD_AUTO_START,

  EL_DF_WALL_STEEL,
  EL_DF_WALL_WOOD,
  EL_REFRACTOR,
  EL_EMPTY,

  EL_CELL,
  EL_MINE,
  EL_EMPTY,
  EL_EMPTY,

  EL_EMPTY,
  EL_EMPTY,
  EL_EMPTY,
  EL_EMPTY,

  EL_CHAR(' '),
  EL_CHAR('!'),
  EL_CHAR('"'),
  EL_CHAR('#'),

  EL_CHAR('$'),
  EL_CHAR('%'),
  EL_CHAR('&'),
  EL_CHAR('\''),

  EL_CHAR('('),
  EL_CHAR(')'),
  EL_CHAR('*'),
  EL_CHAR('+'),

  EL_CHAR(','),
  EL_CHAR('-'),
  EL_CHAR('.'),
  EL_CHAR('/'),

  EL_CHAR('0'),
  EL_CHAR('1'),
  EL_CHAR('2'),
  EL_CHAR('3'),

  EL_CHAR('4'),
  EL_CHAR('5'),
  EL_CHAR('6'),
  EL_CHAR('7'),

  EL_CHAR('8'),
  EL_CHAR('9'),
  EL_CHAR(':'),
  EL_CHAR(';'),

  EL_CHAR('<'),
  EL_CHAR('='),
  EL_CHAR('>'),
  EL_CHAR('?'),

  EL_CHAR('@'),
  EL_CHAR('A'),
  EL_CHAR('B'),
  EL_CHAR('C'),

  EL_CHAR('D'),
  EL_CHAR('E'),
  EL_CHAR('F'),
  EL_CHAR('G'),

  EL_CHAR('H'),
  EL_CHAR('I'),
  EL_CHAR('J'),
  EL_CHAR('K'),

  EL_CHAR('L'),
  EL_CHAR('M'),
  EL_CHAR('N'),
  EL_CHAR('O'),

  EL_CHAR('P'),
  EL_CHAR('Q'),
  EL_CHAR('R'),
  EL_CHAR('S'),

  EL_CHAR('T'),
  EL_CHAR('U'),
  EL_CHAR('V'),
  EL_CHAR('W'),

  EL_CHAR('X'),
  EL_CHAR('Y'),
  EL_CHAR('Z'),
  EL_CHAR('Ä'),

  EL_CHAR('Ö'),
  EL_CHAR('Ü'),
  EL_CHAR('^'),
  EL_CHAR(' ')
};
int elements_in_list = sizeof(editor_element)/sizeof(int);

static char *getElementInfoText(int element)
{
  char *info_text = "unknown";

  if (element < num_element_info)
    info_text = element_info[element];
  else
    Error(ERR_WARN, "no element description for element %d", element);

  return info_text;
}

static void CreateControlButtons()
{
  Bitmap *gd_bitmap = pix[PIX_DOOR];
  struct GadgetInfo *gi;
  unsigned long event_mask;
  int i;

  /* create toolbox buttons */
  for (i=0; i<ED_NUM_CTRL_BUTTONS; i++)
  {
    int id = i;
    int width, height;
    int gd_xoffset, gd_yoffset;
    int gd_x1, gd_x2, gd_y1, gd_y2;
    int button_type;
    int radio_button_nr;
    boolean checked;

    if (id == GADGET_ID_SINGLE_ITEMS ||
	id == GADGET_ID_LINE ||
	id == GADGET_ID_ARC ||
	id == GADGET_ID_RECTANGLE ||
	id == GADGET_ID_FILLED_BOX ||
	id == GADGET_ID_FLOOD_FILL ||
	id == GADGET_ID_GRAB_BRUSH ||
	id == GADGET_ID_PICK_ELEMENT)
    {
      button_type = GD_TYPE_RADIO_BUTTON;
      radio_button_nr = RADIO_NR_DRAWING_TOOLBOX;
      checked = (id == drawing_function ? TRUE : FALSE);
      event_mask = GD_EVENT_PRESSED;
    }
    else
    {
      button_type = GD_TYPE_NORMAL_BUTTON;
      radio_button_nr = RADIO_NR_NONE;
      checked = FALSE;

      if (id == GADGET_ID_WRAP_LEFT ||
	  id == GADGET_ID_WRAP_RIGHT ||
	  id == GADGET_ID_WRAP_UP ||
	  id == GADGET_ID_WRAP_DOWN)
	event_mask = GD_EVENT_PRESSED | GD_EVENT_REPEATED;
      else
	event_mask = GD_EVENT_RELEASED;
    }

    if (id < ED_NUM_CTRL1_BUTTONS)
    {
      int x = i % ED_CTRL1_BUTTONS_HORIZ;
      int y = i / ED_CTRL1_BUTTONS_HORIZ;

      gd_xoffset = ED_CTRL1_BUTTONS_XPOS + x * ED_CTRL1_BUTTON_XSIZE;
      gd_yoffset = ED_CTRL1_BUTTONS_YPOS + y * ED_CTRL1_BUTTON_YSIZE;
      width = ED_CTRL1_BUTTON_XSIZE;
      height = ED_CTRL1_BUTTON_YSIZE;
    }
    else
    {
      int x = (i - ED_NUM_CTRL1_BUTTONS) % ED_CTRL2_BUTTONS_HORIZ;
      int y = (i - ED_NUM_CTRL1_BUTTONS) / ED_CTRL2_BUTTONS_HORIZ;

      gd_xoffset = ED_CTRL2_BUTTONS_XPOS + x * ED_CTRL2_BUTTON_XSIZE;
      gd_yoffset = ED_CTRL2_BUTTONS_YPOS + y * ED_CTRL2_BUTTON_YSIZE;
      width = ED_CTRL2_BUTTON_XSIZE;
      height = ED_CTRL2_BUTTON_YSIZE;
    }

    gd_x1 = DOOR_GFX_PAGEX8 + gd_xoffset;
    gd_x2 = DOOR_GFX_PAGEX7 + gd_xoffset;
    gd_y1  = DOOR_GFX_PAGEY1 + ED_CTRL_BUTTONS_GFX_YPOS + gd_yoffset;
    gd_y2  = DOOR_GFX_PAGEY1 + ED_CTRL_BUTTONS_ALT_GFX_YPOS + gd_yoffset;

    gi = CreateGadget(GDI_CUSTOM_ID, id,
		      GDI_CUSTOM_TYPE_ID, i,
		      GDI_INFO_TEXT, control_info[i].text,
		      GDI_X, EX + gd_xoffset,
		      GDI_Y, EY + gd_yoffset,
		      GDI_WIDTH, width,
		      GDI_HEIGHT, height,
		      GDI_TYPE, button_type,
		      GDI_STATE, GD_BUTTON_UNPRESSED,
		      GDI_RADIO_NR, radio_button_nr,
		      GDI_CHECKED, checked,
		      GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y1,
		      GDI_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y1,
		      GDI_ALT_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y2,
		      GDI_ALT_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y2,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
		      GDI_CALLBACK_ACTION, HandleControlButtons,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    level_editor_gadget[id] = gi;
  }

  /* create buttons for scrolling of drawing area and element list */
  for (i=0; i<ED_NUM_SCROLLBUTTONS; i++)
  {
    int id = scrollbutton_info[i].gadget_id;
    int x, y, width, height;
    int gd_x1, gd_x2, gd_y1, gd_y2;

    x = scrollbutton_info[i].x;
    y = scrollbutton_info[i].y;

    event_mask = GD_EVENT_PRESSED | GD_EVENT_REPEATED;

    x += DX;
    y += DY;
    width = ED_SCROLLBUTTON2_XSIZE;
    height = ED_SCROLLBUTTON2_YSIZE;
    gd_x1 = DOOR_GFX_PAGEX8 + scrollbutton_info[i].xpos;
    gd_y1 = DOOR_GFX_PAGEY1 + scrollbutton_info[i].ypos;
    gd_x2 = gd_x1 - ED_SCROLLBUTTON2_XSIZE;
    gd_y2 = gd_y1;

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
		      GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
		      GDI_CALLBACK_ACTION, HandleControlButtons,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    level_editor_gadget[id] = gi;
  }

  /* create buttons for element list */
  for (i=0; i<ED_NUM_ELEMENTLIST_BUTTONS; i++)
  {
    Bitmap *deco_bitmap;
    int deco_x, deco_y, deco_xpos, deco_ypos;
    int gd_xoffset, gd_yoffset;
    int gd_x1, gd_x2, gd_y;
    int x = i % ED_ELEMENTLIST_BUTTONS_HORIZ;
    int y = i / ED_ELEMENTLIST_BUTTONS_HORIZ;
    int id = GADGET_ID_ELEMENTLIST_FIRST + i;
    int element = editor_element[i];

    event_mask = GD_EVENT_RELEASED;

    gd_xoffset = ED_ELEMENTLIST_XPOS + x * ED_ELEMENTLIST_XSIZE;
    gd_yoffset = ED_ELEMENTLIST_YPOS + y * ED_ELEMENTLIST_YSIZE;

    gd_x1 = DOOR_GFX_PAGEX6 + ED_ELEMENTLIST_XPOS + ED_ELEMENTLIST_XSIZE;
    gd_x2 = DOOR_GFX_PAGEX6 + ED_ELEMENTLIST_XPOS;
    gd_y  = DOOR_GFX_PAGEY1 + ED_ELEMENTLIST_YPOS;

    getMiniGraphicSource(el2gfx(element), &deco_bitmap, &deco_x, &deco_y);
    deco_xpos = (ED_ELEMENTLIST_XSIZE - MINI_TILEX) / 2;
    deco_ypos = (ED_ELEMENTLIST_YSIZE - MINI_TILEY) / 2;

    gi = CreateGadget(GDI_CUSTOM_ID, id,
		      GDI_CUSTOM_TYPE_ID, i,
		      GDI_INFO_TEXT, getElementInfoText(element),
		      GDI_X, DX + gd_xoffset,
		      GDI_Y, DY + gd_yoffset,
		      GDI_WIDTH, ED_ELEMENTLIST_XSIZE,
		      GDI_HEIGHT, ED_ELEMENTLIST_YSIZE,
		      GDI_TYPE, GD_TYPE_NORMAL_BUTTON,
		      GDI_STATE, GD_BUTTON_UNPRESSED,
		      GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y,
		      GDI_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y,
		      GDI_DECORATION_DESIGN, deco_bitmap, deco_x, deco_y,
		      GDI_DECORATION_POSITION, deco_xpos, deco_ypos,
		      GDI_DECORATION_SIZE, MINI_TILEX, MINI_TILEY,
		      GDI_DECORATION_SHIFTING, 1, 1,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
		      GDI_CALLBACK_ACTION, HandleControlButtons,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    level_editor_gadget[id] = gi;
  }

  /* create buttons for drawing element buttons */
  for (i=0; i<ED_NUM_DRAWING_ELEMENT_BUTTONS; i++)
  {
    Bitmap *deco_bitmap;
    int deco_x, deco_y, deco_xpos, deco_ypos;
    int gd_xoffset, gd_yoffset;
    int gd_x1, gd_x2, gd_y;
    int id = GADGET_ID_DRAWING_ELEMENT_LEFT + i;
    int element = BUTTON_ELEMENT(i + 1);

    event_mask = GD_EVENT_PRESSED | GD_EVENT_REPEATED;

    gd_xoffset = ED_DRAWING_ELEMENT_XPOS + i * ED_DRAWING_ELEMENT_XDISTANCE;
    gd_yoffset = ED_DRAWING_ELEMENT_YPOS;

    gd_x1 = DOOR_GFX_PAGEX6 + ED_ELEMENTLIST_XPOS + ED_ELEMENTLIST_XSIZE;
    gd_x2 = DOOR_GFX_PAGEX6 + ED_ELEMENTLIST_XPOS;
    gd_y  = DOOR_GFX_PAGEY1 + ED_ELEMENTLIST_YPOS;

    getMiniGraphicSource(el2gfx(element), &deco_bitmap, &deco_x, &deco_y);
    deco_xpos = (ED_DRAWING_ELEMENT_XSIZE - MINI_TILEX) / 2;
    deco_ypos = (ED_DRAWING_ELEMENT_YSIZE - MINI_TILEY) / 2;

    gi = CreateGadget(GDI_CUSTOM_ID, id,
		      GDI_CUSTOM_TYPE_ID, i,
		      GDI_INFO_TEXT, getElementInfoText(element),
		      GDI_X, DX + gd_xoffset,
		      GDI_Y, DY + gd_yoffset,
		      GDI_WIDTH, ED_ELEMENTLIST_XSIZE,
		      GDI_HEIGHT, ED_ELEMENTLIST_YSIZE,
		      GDI_TYPE, GD_TYPE_NORMAL_BUTTON,
		      GDI_STATE, GD_BUTTON_UNPRESSED,
		      GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y,
		      GDI_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y,
		      GDI_DECORATION_DESIGN, deco_bitmap, deco_x, deco_y,
		      GDI_DECORATION_POSITION, deco_xpos, deco_ypos,
		      GDI_DECORATION_SIZE, MINI_TILEX, MINI_TILEY,
		      GDI_DECORATION_SHIFTING, 1, 1,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
		      GDI_CALLBACK_ACTION, HandleControlButtons,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    level_editor_gadget[id] = gi;
  }
}

static void CreateCounterButtons()
{
  int i;

  for (i=0; i<ED_NUM_COUNTERBUTTONS; i++)
  {
    int j;
    int xpos = SX + counterbutton_info[i].x;	/* xpos of down count button */
    int ypos = SY + counterbutton_info[i].y;

    for (j=0; j<2; j++)
    {
      Bitmap *gd_bitmap = pix[PIX_DOOR];
      struct GadgetInfo *gi;
      int id = (j == 0 ?
		counterbutton_info[i].gadget_id_down :
		counterbutton_info[i].gadget_id_up);
      int gd_xoffset;
      int gd_x, gd_x1, gd_x2, gd_y;
      int x_size, y_size;
      unsigned long event_mask;
      char infotext[MAX_INFOTEXT_LEN + 1];

      event_mask = GD_EVENT_PRESSED | GD_EVENT_REPEATED;

      if (i == ED_COUNTER_ID_SELECT_LEVEL)
      {
	int sid = (j == 0 ?
		   ED_DUMMYBUTTON_ID_LEVEL_LEFT :
		   ED_DUMMYBUTTON_ID_LEVEL_RIGHT);

	event_mask |= GD_EVENT_RELEASED;

	if (j == 1)
	  xpos += 2 * ED_GADGET_DISTANCE;
	ypos += ED_GADGET_DISTANCE;

	gd_x1 = DOOR_GFX_PAGEX8 + dummybutton_info[sid].xpos;
	gd_x2 = gd_x1 - ED_SCROLLBUTTON_XSIZE;
	gd_y  = DOOR_GFX_PAGEY1 + dummybutton_info[sid].ypos;
	x_size = ED_SCROLLBUTTON_XSIZE;
	y_size = ED_SCROLLBUTTON_YSIZE;
      }
      else
      {
	gd_xoffset = (j == 0 ? ED_BUTTON_MINUS_XPOS : ED_BUTTON_PLUS_XPOS);
	gd_x1 = DOOR_GFX_PAGEX4 + gd_xoffset;
	gd_x2 = DOOR_GFX_PAGEX3 + gd_xoffset;
	gd_y  = DOOR_GFX_PAGEY1 + ED_BUTTON_COUNT_YPOS;
	x_size = ED_BUTTON_COUNT_XSIZE;
	y_size = ED_BUTTON_COUNT_YSIZE;
      }

      sprintf(infotext, "%s counter value by 1, 5 or 10",
	      (j == 0 ? "decrease" : "increase"));

      gi = CreateGadget(GDI_CUSTOM_ID, id,
			GDI_CUSTOM_TYPE_ID, i,
			GDI_INFO_TEXT, infotext,
			GDI_X, xpos,
			GDI_Y, ypos,
			GDI_WIDTH, x_size,
			GDI_HEIGHT, y_size,
			GDI_TYPE, GD_TYPE_NORMAL_BUTTON,
			GDI_STATE, GD_BUTTON_UNPRESSED,
			GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y,
			GDI_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y,
			GDI_EVENT_MASK, event_mask,
			GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
			GDI_CALLBACK_ACTION, HandleCounterButtons,
			GDI_END);

      if (gi == NULL)
	Error(ERR_EXIT, "cannot create gadget");

      level_editor_gadget[id] = gi;
      xpos += gi->width + ED_GADGET_DISTANCE;	/* xpos of text count button */

      if (j == 0)
      {
	int font_type = FC_YELLOW;
	int gd_width = ED_WIN_COUNT_XSIZE;

	id = counterbutton_info[i].gadget_id_text;
	event_mask = GD_EVENT_TEXT_RETURN | GD_EVENT_TEXT_LEAVING;

	if (i == ED_COUNTER_ID_SELECT_LEVEL)
	{
	  font_type = FC_SPECIAL3;

	  xpos += 2 * ED_GADGET_DISTANCE;
	  ypos -= ED_GADGET_DISTANCE;

	  gd_x = DOOR_GFX_PAGEX6 + ED_WIN_COUNT2_XPOS;
	  gd_y = DOOR_GFX_PAGEY1 + ED_WIN_COUNT2_YPOS;
	  gd_width = ED_WIN_COUNT2_XSIZE;
	}
	else
	{
	  gd_x = DOOR_GFX_PAGEX4 + ED_WIN_COUNT_XPOS;
	  gd_y = DOOR_GFX_PAGEY1 + ED_WIN_COUNT_YPOS;
	}

	gi = CreateGadget(GDI_CUSTOM_ID, id,
			  GDI_CUSTOM_TYPE_ID, i,
			  GDI_INFO_TEXT, "enter counter value",
			  GDI_X, xpos,
			  GDI_Y, ypos,
			  GDI_TYPE, GD_TYPE_TEXTINPUT_NUMERIC,
			  GDI_NUMBER_VALUE, 0,
			  GDI_NUMBER_MIN, counterbutton_info[i].min_value,
			  GDI_NUMBER_MAX, counterbutton_info[i].max_value,
			  GDI_TEXT_SIZE, 3,
			  GDI_TEXT_FONT, font_type,
			  GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x, gd_y,
			  GDI_DESIGN_PRESSED, gd_bitmap, gd_x, gd_y,
			  GDI_BORDER_SIZE, ED_BORDER_SIZE,
			  GDI_TEXTINPUT_DESIGN_WIDTH, gd_width,
			  GDI_EVENT_MASK, event_mask,
			  GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
			  GDI_CALLBACK_ACTION, HandleCounterButtons,
			  GDI_END);

	if (gi == NULL)
	  Error(ERR_EXIT, "cannot create gadget");

	level_editor_gadget[id] = gi;
	xpos += gi->width + ED_GADGET_DISTANCE;	/* xpos of up count button */
      }
    }
  }
}

static void CreateDrawingArea()
{
  struct GadgetInfo *gi;
  unsigned long event_mask;
  int id;

  event_mask =
    GD_EVENT_PRESSED | GD_EVENT_RELEASED | GD_EVENT_MOVING |
    GD_EVENT_OFF_BORDERS;

  /* create level drawing area */
  id = GADGET_ID_DRAWING_LEVEL;
  gi = CreateGadget(GDI_CUSTOM_ID, id,
		    GDI_X, SX,
		    GDI_Y, SY,
		    GDI_TYPE, GD_TYPE_DRAWING_AREA,
		    GDI_AREA_SIZE, ed_fieldx, ed_fieldy,
		    GDI_ITEM_SIZE, MINI_TILEX, MINI_TILEY,
		    GDI_EVENT_MASK, event_mask,
		    GDI_CALLBACK_INFO, HandleDrawingAreaInfo,
		    GDI_CALLBACK_ACTION, HandleDrawingAreas,
		    GDI_END);

  if (gi == NULL)
    Error(ERR_EXIT, "cannot create gadget");

  level_editor_gadget[id] = gi;
}

static void CreateTextInputGadgets()
{
  int i;

  for (i=0; i<ED_NUM_TEXTINPUT; i++)
  {
    Bitmap *gd_bitmap = pix[PIX_DOOR];
    int gd_x, gd_y;
    struct GadgetInfo *gi;
    unsigned long event_mask;
    char infotext[1024];
    int id = textinput_info[i].gadget_id;

    event_mask = GD_EVENT_TEXT_RETURN | GD_EVENT_TEXT_LEAVING;

    gd_x = DOOR_GFX_PAGEX4 + ED_WIN_COUNT_XPOS;
    gd_y = DOOR_GFX_PAGEY1 + ED_WIN_COUNT_YPOS;

    sprintf(infotext, "Enter %s", textinput_info[i].infotext);
    infotext[MAX_INFOTEXT_LEN] = '\0';

    gi = CreateGadget(GDI_CUSTOM_ID, id,
		      GDI_CUSTOM_TYPE_ID, i,
		      GDI_INFO_TEXT, infotext,
		      GDI_X, SX + textinput_info[i].x,
		      GDI_Y, SY + textinput_info[i].y,
		      GDI_TYPE, GD_TYPE_TEXTINPUT_ALPHANUMERIC,
		      GDI_TEXT_VALUE, textinput_info[i].value,
		      GDI_TEXT_SIZE, textinput_info[i].size,
		      GDI_TEXT_FONT, FC_YELLOW,
		      GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x, gd_y,
		      GDI_DESIGN_PRESSED, gd_bitmap, gd_x, gd_y,
		      GDI_BORDER_SIZE, ED_BORDER_SIZE,
		      GDI_TEXTINPUT_DESIGN_WIDTH, ED_WIN_COUNT_XSIZE,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
		      GDI_CALLBACK_ACTION, HandleTextInputGadgets,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    level_editor_gadget[id] = gi;
  }
}

static void CreateScrollbarGadgets()
{
  int i;

  for (i=0; i<ED_NUM_SCROLLBARS; i++)
  {
    int id = scrollbar_info[i].gadget_id;
    Bitmap *gd_bitmap = pix[PIX_DOOR];
    int gd_x1, gd_x2, gd_y1, gd_y2;
    struct GadgetInfo *gi;
    int items_max, items_visible, item_position;
    unsigned long event_mask;

    if (i == ED_SCROLLBAR_ID_LIST_VERTICAL)
    {
      items_max = elements_in_list / ED_ELEMENTLIST_BUTTONS_HORIZ;
      items_visible = ED_ELEMENTLIST_BUTTONS_VERT;
      item_position = 0;
    }
    else
    {
      /* never reached (only one scrollbar) -- only to make gcc happy ;-) */
      items_max = 0;
      items_visible = 0;
      item_position = 0;
    }

    event_mask = GD_EVENT_MOVING | GD_EVENT_OFF_BORDERS;

    gd_x1 = DOOR_GFX_PAGEX8 + scrollbar_info[i].xpos;
    gd_x2 = (gd_x1 - (scrollbar_info[i].type == GD_TYPE_SCROLLBAR_HORIZONTAL ?
		      scrollbar_info[i].height : scrollbar_info[i].width));
    gd_y1 = DOOR_GFX_PAGEY1 + scrollbar_info[i].ypos;
    gd_y2 = DOOR_GFX_PAGEY1 + scrollbar_info[i].ypos;

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
		      GDI_BORDER_SIZE, ED_BORDER_SIZE,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
		      GDI_CALLBACK_ACTION, HandleControlButtons,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    level_editor_gadget[id] = gi;
  }
}

static void CreateCheckbuttonGadgets()
{
  Bitmap *gd_bitmap = pix[PIX_DOOR];
  struct GadgetInfo *gi;
  unsigned long event_mask;
  int gd_x1, gd_x2, gd_x3, gd_x4, gd_y;
  int i;

  event_mask = GD_EVENT_PRESSED;

  gd_x1 = DOOR_GFX_PAGEX4 + ED_CHECKBUTTON_UNCHECKED_XPOS;
  gd_x2 = DOOR_GFX_PAGEX3 + ED_CHECKBUTTON_UNCHECKED_XPOS;
  gd_x3 = DOOR_GFX_PAGEX4 + ED_CHECKBUTTON_CHECKED_XPOS;
  gd_x4 = DOOR_GFX_PAGEX3 + ED_CHECKBUTTON_CHECKED_XPOS;
  gd_y  = DOOR_GFX_PAGEY1 + ED_RADIOBUTTON_YPOS;

  for (i=0; i<ED_NUM_CHECKBUTTONS; i++)
  {
    int id = checkbutton_info[i].gadget_id;

    gd_y  = DOOR_GFX_PAGEY1 + ED_CHECKBUTTON_YPOS;

    gi = CreateGadget(GDI_CUSTOM_ID, id,
		      GDI_CUSTOM_TYPE_ID, i,
		      GDI_INFO_TEXT, checkbutton_info[i].infotext,
		      GDI_X, SX + checkbutton_info[i].x,
		      GDI_Y, SY + checkbutton_info[i].y,
		      GDI_WIDTH, ED_CHECKBUTTON_XSIZE,
		      GDI_HEIGHT, ED_CHECKBUTTON_YSIZE,
		      GDI_TYPE, GD_TYPE_CHECK_BUTTON,
		      GDI_CHECKED, *checkbutton_info[i].value,
		      GDI_DESIGN_UNPRESSED, gd_bitmap, gd_x1, gd_y,
		      GDI_DESIGN_PRESSED, gd_bitmap, gd_x2, gd_y,
		      GDI_ALT_DESIGN_UNPRESSED, gd_bitmap, gd_x3, gd_y,
		      GDI_ALT_DESIGN_PRESSED, gd_bitmap, gd_x4, gd_y,
		      GDI_EVENT_MASK, event_mask,
		      GDI_CALLBACK_INFO, HandleEditorGadgetInfoText,
		      GDI_CALLBACK_ACTION, HandleCheckbuttons,
		      GDI_END);

    if (gi == NULL)
      Error(ERR_EXIT, "cannot create gadget");

    level_editor_gadget[id] = gi;
  }
}

void CreateLevelEditorGadgets()
{
  CreateControlButtons();
  CreateCounterButtons();
  CreateDrawingArea();
  CreateTextInputGadgets();
  CreateScrollbarGadgets();
  CreateCheckbuttonGadgets();
}

static void MapCounterButtons(int id)
{
  MapGadget(level_editor_gadget[counterbutton_info[id].gadget_id_down]);
  MapGadget(level_editor_gadget[counterbutton_info[id].gadget_id_text]);
  MapGadget(level_editor_gadget[counterbutton_info[id].gadget_id_up]);
}

static void MapControlButtons()
{
  int counter_id;
  int i;

  /* map toolbox buttons */
  for (i=0; i<ED_NUM_CTRL_BUTTONS; i++)
    MapGadget(level_editor_gadget[i]);

  /* map buttons to select elements */
  for (i=0; i<ED_NUM_ELEMENTLIST_BUTTONS; i++)
    MapGadget(level_editor_gadget[GADGET_ID_ELEMENTLIST_FIRST + i]);

  MapGadget(level_editor_gadget[GADGET_ID_DRAWING_ELEMENT_LEFT]);
  MapGadget(level_editor_gadget[GADGET_ID_DRAWING_ELEMENT_MIDDLE]);
  MapGadget(level_editor_gadget[GADGET_ID_DRAWING_ELEMENT_RIGHT]);

  MapGadget(level_editor_gadget[GADGET_ID_SCROLL_LIST_VERTICAL]);
  MapGadget(level_editor_gadget[GADGET_ID_SCROLL_LIST_UP]);
  MapGadget(level_editor_gadget[GADGET_ID_SCROLL_LIST_DOWN]);

  /* map buttons to select level */
  counter_id = ED_COUNTER_ID_SELECT_LEVEL;
  ModifyEditorCounterLimits(counter_id,
			    leveldir_current->first_level,
			    leveldir_current->last_level);
  ModifyEditorCounter(counter_id, *counterbutton_info[counter_id].value);
  MapCounterButtons(counter_id);
}

static void MapDrawingArea(int id)
{
  MapGadget(level_editor_gadget[id]);
}

static void MapTextInputGadget(int id)
{
  MapGadget(level_editor_gadget[textinput_info[id].gadget_id]);
}

static void MapCheckbuttonGadget(int id)
{
  MapGadget(level_editor_gadget[checkbutton_info[id].gadget_id]);
}

static void MapMainDrawingArea()
{
  MapDrawingArea(GADGET_ID_DRAWING_LEVEL);
}

void UnmapLevelEditorWindowGadgets()
{
  int i;

  for (i=0; i<NUM_EDITOR_GADGETS; i++)
    if (level_editor_gadget[i]->x < SX + SXSIZE)
      UnmapGadget(level_editor_gadget[i]);
}

void UnmapLevelEditorGadgets()
{
  int i;

  for (i=0; i<NUM_EDITOR_GADGETS; i++)
    UnmapGadget(level_editor_gadget[i]);
}

static void ResetUndoBuffer()
{
  undo_buffer_position = -1;
  undo_buffer_steps = -1;
  CopyLevelToUndoBuffer(UNDO_IMMEDIATE);
}

static void DrawEditModeWindow()
{
  if (edit_mode == ED_MODE_INFO)
    DrawLevelInfoWindow();
  else	/* edit_mode == ED_MODE_DRAWING */
    DrawDrawingWindow();
}

static int getHiResLevelElement(int sx, int sy)
{
  int lx = sx / 2;
  int ly = sy / 2;
  int sx_offset = sx - 2 * lx;
  int sy_offset = sy - 2 * ly;
  int element = Feld[lx][ly];
  unsigned int bitmask = (sx_offset + 1) << (sy_offset * 2);

  if (IS_WALL(element))
  {
    if (element & bitmask)
      return WALL_BASE(element);
    else
      return EL_EMPTY;
  }
  else
    return element;
}

static void PutHiResLevelElement(int sx, int sy, int hires_element,
				 boolean change_level)
{
  int lx = sx / 2;
  int ly = sy / 2;
  int sx_offset = sx - 2 * lx;
  int sy_offset = sy - 2 * ly;
  int old_element = Feld[lx][ly];
  int new_element = hires_element;
  unsigned int old_bitmask = WALL_BITS(old_element);
  unsigned int new_bitmask = (sx_offset + 1) << (sy_offset * 2);

  if (new_element == EL_WALL_EMPTY)
    new_element = EL_EMPTY;

  if (IS_WALL(new_element))
  {
    new_element |= new_bitmask;

    if (IS_WALL(old_element))
      new_element |= old_bitmask;
  }
  else if (IS_WALL(old_element) && new_element == EL_EMPTY)
  {
    int new_element_changed = old_element & ~new_bitmask;

    if (WALL_BITS(new_element_changed) != 0)
      new_element = new_element_changed;
  }

  if (hires_element == EL_EMPTY && IS_WALL(old_element) && !change_level)
    DrawMiniElement(sx, sy, EL_EMPTY);
  else
    DrawElement(lx, ly, new_element);

  if (change_level)
    Feld[lx][ly] = new_element;
}

static void WriteHiResLevelElement(int sx, int sy, int new_element)
{
  PutHiResLevelElement(sx, sy, new_element, TRUE);
}

#if 0
static void DrawHiResLevelElement(int sx, int sy, int new_element)
{
  PutHiResLevelElement(sx, sy, new_element, FALSE);
}
#endif

static boolean LevelChanged()
{
  boolean level_changed = FALSE;
  int x, y;

  for(y=0; y<lev_fieldy; y++) 
    for(x=0; x<lev_fieldx; x++)
      if (Feld[x][y] != Ur[x][y])
	level_changed = TRUE;

  return level_changed;
}

static boolean LevelContainsPlayer()
{
  boolean player_found = FALSE;
  int x, y;

  for(y=0; y<lev_fieldy; y++) 
    for(x=0; x<lev_fieldx; x++)
      if (IS_MCDUFFIN(Feld[x][y]) || IS_LASER(Feld[x][y]))
	player_found = TRUE;

  return player_found;
}

static void DrawEditorLevel()
{
  DrawLevel();
}

void DrawLevelEd()
{
  CloseDoor(DOOR_CLOSE_ALL);
  OpenDoor(DOOR_OPEN_2 | DOOR_NO_DELAY);

  if (level_editor_test_game)
  {
    int x, y;

    for(x=0; x<lev_fieldx; x++)
      for(y=0; y<lev_fieldy; y++)
	Feld[x][y] = Ur[x][y];

    for(x=0; x<lev_fieldx; x++)
      for(y=0; y<lev_fieldy; y++)
	Ur[x][y] = FieldBackup[x][y];

    level_editor_test_game = FALSE;
  }
  else
  {
    edit_mode = ED_MODE_DRAWING;

    ResetUndoBuffer();
    level_xpos = 0;
    level_ypos = 0;
  }

  /* copy default editor door content to main double buffer */
  BlitBitmap(pix[PIX_DOOR], drawto,
	     DOOR_GFX_PAGEX6, DOOR_GFX_PAGEY1, DXSIZE, DYSIZE, DX, DY);

#if 0
  /* draw mouse button brush elements */
  DrawMiniGraphicExt(drawto, gc,
		     DX + ED_WIN_MB_LEFT_XPOS, DY + ED_WIN_MB_LEFT_YPOS,
		     el2gfx(new_drawing_element[MB_LEFTBUTTON]));
  DrawMiniGraphicExt(drawto, gc,
		     DX + ED_WIN_MB_MIDDLE_XPOS, DY + ED_WIN_MB_MIDDLE_YPOS,
		     el2gfx(new_drawing_element[MB_MIDDLEBUTTON]));
  DrawMiniGraphicExt(drawto, gc,
		     DX + ED_WIN_MB_RIGHT_XPOS, DY + ED_WIN_MB_RIGHT_YPOS,
		     el2gfx(new_drawing_element[MB_RIGHTBUTTON]));
#endif

#if 0
  /* draw new control window */
  BlitBitmap(pix[PIX_DOOR], drawto,
	     DOOR_GFX_PAGEX8, 236, EXSIZE, EYSIZE, EX, EY);
#endif

  redraw_mask |= REDRAW_ALL;

  MapControlButtons();

  /* copy actual editor door content to door double buffer for OpenDoor() */
  BlitBitmap(drawto, pix[PIX_DB_DOOR],
	     DX, DY, DXSIZE, DYSIZE, DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1);

  DrawEditModeWindow();

  /*
  FadeToFront();
  */


  OpenDoor(DOOR_OPEN_1);

  /*
  OpenDoor(DOOR_OPEN_1 | DOOR_OPEN_2);
  */
}

static void ModifyEditorTextInput(int textinput_id, char *new_text)
{
  int gadget_id = textinput_info[textinput_id].gadget_id;
  struct GadgetInfo *gi = level_editor_gadget[gadget_id];

  ModifyGadget(gi, GDI_TEXT_VALUE, new_text, GDI_END);
}

static void ModifyEditorCounter(int counter_id, int new_value)
{
  int *counter_value = counterbutton_info[counter_id].value;
  int gadget_id = counterbutton_info[counter_id].gadget_id_text;
  struct GadgetInfo *gi = level_editor_gadget[gadget_id];

  ModifyGadget(gi, GDI_NUMBER_VALUE, new_value, GDI_END);

  if (counter_value != NULL)
    *counter_value = gi->text.number_value;
}

static void ModifyEditorCounterLimits(int counter_id, int min, int max)
{
  int gadget_id = counterbutton_info[counter_id].gadget_id_text;
  struct GadgetInfo *gi = level_editor_gadget[gadget_id];

  ModifyGadget(gi, GDI_NUMBER_MIN, min, GDI_NUMBER_MAX, max, GDI_END);
}

static void PickDrawingElement(int button, int element)
{
  int id = GADGET_ID_DRAWING_ELEMENT_LEFT + button - 1;
  struct GadgetInfo *gi = level_editor_gadget[id];
  struct GadgetDesign *gd = &gi->deco.design;

  if (button < 1 || button > 3)
    return;

  new_drawing_element[button] = element;

  getMiniGraphicSource(el2gfx(element), &gd->bitmap, &gd->x, &gd->y);
  ModifyGadget(gi, GDI_INFO_TEXT, getElementInfoText(element), GDI_END);

#if 0
  if (button == 1)
  {
    new_element1 = element;
    DrawMiniGraphicExt(drawto, gc,
		       DX + ED_WIN_MB_LEFT_XPOS, DY + ED_WIN_MB_LEFT_YPOS,
		       el2gfx(new_element1));
  }
  else if (button == 2)
  {
    new_element2 = element;
    DrawMiniGraphicExt(drawto, gc,
		       DX + ED_WIN_MB_MIDDLE_XPOS, DY + ED_WIN_MB_MIDDLE_YPOS,
		       el2gfx(new_element2));
  }
  else
  {
    new_element3 = element;
    DrawMiniGraphicExt(drawto, gc,
		       DX + ED_WIN_MB_RIGHT_XPOS, DY + ED_WIN_MB_RIGHT_YPOS,
		       el2gfx(new_element3));
  }
#endif

  redraw_mask |= REDRAW_DOOR_1;
}

static void DrawDrawingWindow()
{
  ClearWindow();
  UnmapLevelEditorWindowGadgets();
  DrawEditorLevel(ed_fieldx, ed_fieldy, level_xpos, level_ypos);
  MapMainDrawingArea();
}

static void DrawLevelInfoWindow()
{
  char infotext[1024];
  int xoffset_above = 0;
  int yoffset_above = -(MINI_TILEX + ED_GADGET_DISTANCE);
  int xoffset_right = counter_xsize;
  int yoffset_right = ED_BORDER_SIZE;
  int xoffset_right2 = ED_CHECKBUTTON_XSIZE + 2 * ED_GADGET_DISTANCE;
  int yoffset_right2 = ED_BORDER_SIZE;
  int font_color = FC_GREEN;
  int i, x, y;

  if (level.auto_count_kettles)
  {
    level.kettles_needed = 0;

    for (y=0; y<lev_fieldy; y++)
      for(x=0; x<lev_fieldx; x++)
	if (Feld[x][y] == EL_KETTLE)
	  level.kettles_needed++;
  }

  ClearWindow();
  UnmapLevelEditorWindowGadgets();

  DrawText(SX + ED_SETTINGS2_XPOS, SY + ED_SETTINGS_YPOS,
	   "Level Settings", FS_BIG, FC_YELLOW);
  DrawText(SX + ED_SETTINGS2_XPOS, SY + ED_SETTINGS2_YPOS,
	   "Editor Settings", FS_BIG, FC_YELLOW);

  DrawTextF(ED_SETTINGS_XPOS, ED_COUNTER_YPOS(5) + yoffset_above,
	    font_color, "Choose color components for laser:");

  /* draw counter gadgets */
  for (i=ED_COUNTER_ID_LEVEL_FIRST; i<=ED_COUNTER_ID_LEVEL_LAST; i++)
  {
    if (counterbutton_info[i].infotext_above)
    {
      x = counterbutton_info[i].x + xoffset_above;
      y = counterbutton_info[i].y + yoffset_above;

      sprintf(infotext, "%s:", counterbutton_info[i].infotext_above);
      infotext[MAX_INFOTEXT_LEN] = '\0';
      DrawTextF(x, y, font_color, infotext);
    }

    if (counterbutton_info[i].infotext_right)
    {
      x = counterbutton_info[i].x + xoffset_right;
      y = counterbutton_info[i].y + yoffset_right;

      sprintf(infotext, "%s", counterbutton_info[i].infotext_right);
      infotext[MAX_INFOTEXT_LEN] = '\0';
      DrawTextF(x, y, font_color, infotext);
    }

    ModifyEditorCounter(i, *counterbutton_info[i].value);
    MapCounterButtons(i);
  }

  /* draw text input gadgets */
  for (i=ED_TEXTINPUT_ID_LEVEL_FIRST; i<=ED_TEXTINPUT_ID_LEVEL_LAST; i++)
  {
    x = textinput_info[i].x + xoffset_above;
    y = textinput_info[i].y + yoffset_above;

    sprintf(infotext, "%s:", textinput_info[i].infotext);
    infotext[MAX_INFOTEXT_LEN] = '\0';

    DrawTextF(x, y, font_color, infotext);
    ModifyEditorTextInput(i, textinput_info[i].value);
    MapTextInputGadget(i);
  }

  /* draw checkbutton gadgets */
  for (i=ED_CHECKBUTTON_ID_LEVEL_FIRST; i<=ED_CHECKBUTTON_ID_LEVEL_LAST; i++)
  {
    x = checkbutton_info[i].x + xoffset_right2;
    y = checkbutton_info[i].y + yoffset_right2;

    DrawTextF(x, y, font_color, checkbutton_info[i].text);
    ModifyGadget(level_editor_gadget[checkbutton_info[i].gadget_id],
		 GDI_CHECKED, *checkbutton_info[i].value, GDI_END);
    MapCheckbuttonGadget(i);
  }
}

static void DrawBrushElement(int lx, int ly, int element, boolean change_level)
{
  /* if element is "empty" wall, fill it with its wall type */
  if (IS_WALL(element) && WALL_BITS(element) == 0)
    element |= 0x0f;

  DrawElement(lx, ly, (element < 0 ? Feld[lx][ly] : element));

  if (change_level)
    Feld[lx][ly] = element;
}

static void DrawLineElement(int sx, int sy, int element, boolean change_level)
{
  int lx = sx / 2;
  int ly = sy / 2;
  int old_lores_element = Feld[lx][ly];

#if 0
  int lx = sx + level_xpos;
  int ly = sy + level_ypos;

  DrawMiniElement(sx, sy, (element < 0 ? Feld[lx][ly] : element));

  if (change_level)
    Feld[lx][ly] = element;
#endif

  int old_element = getHiResLevelElement(sx, sy);
  int new_element = (element < 0 ? old_element : element);

  if ((IS_WALL(new_element) || IS_WALL(old_element)) && !change_level &&
      new_element != EL_WALL_EMPTY)
    editor.draw_walls_masked = TRUE;

  if (element < 0)
    DrawElement(lx, ly, old_lores_element);
  else
    PutHiResLevelElement(sx, sy, new_element, change_level);

  editor.draw_walls_masked = FALSE;
}

static void DrawLine(int from_x, int from_y, int to_x, int to_y,
		     int element, boolean change_level)
{
  if (from_y == to_y)			/* horizontal line */
  {
    int x;
    int y = from_y;

    if (from_x > to_x)
      swap_numbers(&from_x, &to_x);

    for (x=from_x; x<=to_x; x++)
      DrawLineElement(x, y, element, change_level);
  }
  else if (from_x == to_x)		/* vertical line */
  {
    int x = from_x;
    int y;

    if (from_y > to_y)
      swap_numbers(&from_y, &to_y);

    for (y=from_y; y<=to_y; y++)
      DrawLineElement(x, y, element, change_level);
  }
  else					/* diagonal line */
  {
    int len_x = ABS(to_x - from_x);
    int len_y = ABS(to_y - from_y);
    int x, y;

    if (len_y < len_x)			/* a < 1 */
    {
      float a = (float)len_y / (float)len_x;

      if (from_x > to_x)
	swap_number_pairs(&from_x, &from_y, &to_x, &to_y);

      for (x=0; x<=len_x; x++)
      {
	y = (int)(a * x + 0.5) * (to_y < from_y ? -1 : +1);
	DrawLineElement(from_x + x, from_y + y, element, change_level);
      }
    }
    else				/* a >= 1 */
    {
      float a = (float)len_x / (float)len_y;

      if (from_y > to_y)
	swap_number_pairs(&from_x, &from_y, &to_x, &to_y);

      for (y=0; y<=len_y; y++)
      {
	x = (int)(a * y + 0.5) * (to_x < from_x ? -1 : +1);
	DrawLineElement(from_x + x, from_y + y, element, change_level);
      }
    }
  }
}

static void DrawRectangle(int from_x, int from_y, int to_x, int to_y,
			  int element, boolean change_level)
{
  DrawLine(from_x, from_y, from_x, to_y, element, change_level);
  DrawLine(from_x, to_y, to_x, to_y, element, change_level);
  DrawLine(to_x, to_y, to_x, from_y, element, change_level);
  DrawLine(to_x, from_y, from_x, from_y, element, change_level);
}

static void DrawFilledBox(int from_x, int from_y, int to_x, int to_y,
			  int element, boolean change_level)
{
  int y;

  if (from_y > to_y)
    swap_number_pairs(&from_x, &from_y, &to_x, &to_y);

  for (y=from_y; y<=to_y; y++)
    DrawLine(from_x, y, to_x, y, element, change_level);
}

static void DrawArcExt(int from_x, int from_y, int to_x2, int to_y2,
		       int element, boolean change_level)
{
  int to_x = to_x2 - (to_x2 > from_x ? +1 : -1);
  int to_y = to_y2 - (to_y2 > from_y ? +1 : -1);
  int len_x = ABS(to_x - from_x);
  int len_y = ABS(to_y - from_y);
  int radius, x, y;

  radius = (int)(sqrt((float)(len_x * len_x + len_y * len_y)) + 0.5);

  /* not optimal (some points get drawn twice) but simple,
     and fast enough for the few points we are drawing */

  for (x=0; x<=radius; x++)
  {
    int sx, sy, lx, ly;

    y = (int)(sqrt((float)(radius * radius - x * x)) + 0.5);

    sx = from_x + x * (from_x < to_x2 ? +1 : -1);
    sy = from_y + y * (from_y < to_y2 ? +1 : -1);
    lx = sx / 2 + level_xpos;
    ly = sy / 2 + level_ypos;

    if (IN_ED_FIELD(sx, sy) && IN_LEV_FIELD(lx, ly))
      DrawLineElement(sx, sy, element, change_level);
  }

  for (y=0; y<=radius; y++)
  {
    int sx, sy, lx, ly;

    x = (int)(sqrt((float)(radius * radius - y * y)) + 0.5);

    sx = from_x + x * (from_x < to_x2 ? +1 : -1);
    sy = from_y + y * (from_y < to_y2 ? +1 : -1);
    lx = sx / 2 + level_xpos;
    ly = sy / 2 + level_ypos;

    if (IN_ED_FIELD(sx, sy) && IN_LEV_FIELD(lx, ly))
      DrawLineElement(sx, sy, element, change_level);
  }
}

static void DrawArc(int from_x, int from_y, int to_x, int to_y,
		    int element, boolean change_level)
{
  int to_x2 = to_x + (to_x < from_x ? -1 : +1);
  int to_y2 = to_y + (to_y > from_y ? +1 : -1);

  DrawArcExt(from_x, from_y, to_x2, to_y2, element, change_level);
}

#define DRAW_CIRCLES_BUTTON_AVAILABLE	0
#if DRAW_CIRCLES_BUTTON_AVAILABLE
static void DrawCircle(int from_x, int from_y, int to_x, int to_y,
		       int element, boolean change_level)
{
  int to_x2 = to_x + (to_x < from_x ? -1 : +1);
  int to_y2 = to_y + (to_y > from_y ? +1 : -1);
  int mirror_to_x2 = from_x - (to_x2 - from_x);
  int mirror_to_y2 = from_y - (to_y2 - from_y);

  DrawArcExt(from_x, from_y, to_x2, to_y2, element, change_level);
  DrawArcExt(from_x, from_y, mirror_to_x2, to_y2, element, change_level);
  DrawArcExt(from_x, from_y, to_x2, mirror_to_y2, element, change_level);
  DrawArcExt(from_x, from_y, mirror_to_x2, mirror_to_y2, element,change_level);
}
#endif

static void round_to_lores_grid(int *from_x, int *from_y, int *to_x, int *to_y)
{
  if (*from_x > *to_x)
    swap_numbers(from_x, to_x);

  if (*from_y > *to_y)
    swap_numbers(from_y, to_y);

  *from_x = (*from_x / 2) * 2;
  *from_y = (*from_y / 2) * 2;
  *to_x = (*to_x / 2) * 2 + 1;
  *to_y = (*to_y / 2) * 2 + 1;
}

static void DrawAreaBorder(int from_x, int from_y, int to_x, int to_y)
{
  int from_sx, from_sy;
  int to_sx, to_sy;

  round_to_lores_grid(&from_x, &from_y, &to_x, &to_y);

  from_sx = SX + from_x * MINI_TILEX;
  from_sy = SY + from_y * MINI_TILEY;
  to_sx = SX + to_x * MINI_TILEX + MINI_TILEX - 1;
  to_sy = SY + to_y * MINI_TILEY + MINI_TILEY - 1;

  DrawSimpleWhiteLine(drawto, from_sx, from_sy, to_sx, from_sy);
  DrawSimpleWhiteLine(drawto, to_sx, from_sy, to_sx, to_sy);
  DrawSimpleWhiteLine(drawto, to_sx, to_sy, from_sx, to_sy);
  DrawSimpleWhiteLine(drawto, from_sx, to_sy, from_sx, from_sy);

  if (from_x == to_x && from_y == to_y)
    MarkTileDirty(from_x/2, from_y/2);
  else
    redraw_mask |= REDRAW_FIELD;
}

static void SelectArea(int from_x, int from_y, int to_x, int to_y,
		       int element, boolean change_level)
{
  round_to_lores_grid(&from_x, &from_y, &to_x, &to_y);

  if (element == -1 || change_level)
    DrawRectangle(from_x, from_y, to_x, to_y, -1, FALSE);
  else
    DrawAreaBorder(from_x, from_y, to_x, to_y);
}

/* values for CopyBrushExt() */
#define CB_AREA_TO_BRUSH	0
#define CB_BRUSH_TO_CURSOR	1
#define CB_BRUSH_TO_LEVEL	2
#define CB_DELETE_OLD_CURSOR	3

static void CopyBrushExt(int from_x, int from_y, int to_x, int to_y,
			 int button, int mode)
{
  static short brush_buffer[MAX_ED_FIELDX][MAX_ED_FIELDY];
  static int brush_width, brush_height;
  static int last_cursor_x = -1, last_cursor_y = -1;
  static boolean delete_old_brush;
  int new_element = BUTTON_ELEMENT(button);
  int x, y;

  if (mode == CB_DELETE_OLD_CURSOR && !delete_old_brush)
    return;

  if (mode == CB_AREA_TO_BRUSH)
  {
    int from_lx, from_ly;

    round_to_lores_grid(&from_x, &from_y, &to_x, &to_y);

    brush_width = to_x - from_x + 1;
    brush_height = to_y - from_y + 1;

    from_lx = from_x / 2 + level_xpos;
    from_ly = from_y / 2 + level_ypos;

    for (y=0; y<brush_height/2; y++)
    {
      for (x=0; x<brush_width/2; x++)
      {
	brush_buffer[x][y] = Feld[from_lx + x][from_ly + y];

	if (button != 1)
	  DrawBrushElement(from_lx + x, from_ly + y, new_element, TRUE);
#if 0
	  DrawLineElement(from_x + x, from_y + y, new_element, TRUE);
#endif
      }
    }

    if (button != 1)
      CopyLevelToUndoBuffer(UNDO_IMMEDIATE);

    delete_old_brush = FALSE;
  }
  else if (mode == CB_BRUSH_TO_CURSOR || mode == CB_DELETE_OLD_CURSOR ||
	   mode == CB_BRUSH_TO_LEVEL)
  {
    int from_x2 = (from_x / 2) * 2;
    int from_y2 = (from_y / 2) * 2;
    int cursor_x = (mode == CB_DELETE_OLD_CURSOR ? last_cursor_x : from_x2);
    int cursor_y = (mode == CB_DELETE_OLD_CURSOR ? last_cursor_y : from_y2);
    int cursor_from_x = cursor_x - (brush_width / 4) * 2;
    int cursor_from_y = cursor_y - (brush_height / 4) * 2;
    int border_from_x = cursor_x, border_from_y = cursor_y;
    int border_to_x = cursor_x, border_to_y = cursor_y;

    if (mode != CB_DELETE_OLD_CURSOR && delete_old_brush)
      CopyBrushExt(0, 0, 0, 0, 0, CB_DELETE_OLD_CURSOR);

    if (!IN_ED_FIELD(cursor_x, cursor_y) ||
	!IN_LEV_FIELD(cursor_x / 2 + level_xpos, cursor_y / 2 + level_ypos))
    {
      delete_old_brush = FALSE;
      return;
    }

    for (y=0; y<brush_height/2; y++)
    {
      for (x=0; x<brush_width/2; x++)
      {
	int sx = cursor_from_x + x * 2;
	int sy = cursor_from_y + y * 2;
	int lx = sx / 2 + level_xpos;
	int ly = sy / 2 + level_ypos;
	boolean change_level = (mode == CB_BRUSH_TO_LEVEL);
	int element = (mode == CB_DELETE_OLD_CURSOR ? -1 :
		       mode == CB_BRUSH_TO_CURSOR || button == 1 ?
		       brush_buffer[x][y] : new_element);

	if (IN_ED_FIELD(sx, sy) && IN_LEV_FIELD(lx, ly))
	{
	  if (sx < border_from_x)
	    border_from_x = sx;
	  else if (sx > border_to_x)
	    border_to_x = sx;
	  if (sy < border_from_y)
	    border_from_y = sy;
	  else if (sy > border_to_y)
	    border_to_y = sy;

	  DrawBrushElement(lx, ly, element, change_level);
#if 0
	  DrawLineElement(sx, sy, element, change_level);
#endif
	}
      }
    }

    if (mode != CB_DELETE_OLD_CURSOR)
      DrawAreaBorder(border_from_x, border_from_y, border_to_x, border_to_y);

    last_cursor_x = cursor_x;
    last_cursor_y = cursor_y;
    delete_old_brush = TRUE;
  }
}

static void CopyAreaToBrush(int from_x, int from_y, int to_x, int to_y,
			    int button)
{
  CopyBrushExt(from_x, from_y, to_x, to_y, button, CB_AREA_TO_BRUSH);
}

static void CopyBrushToLevel(int x, int y, int button)
{
  CopyBrushExt(x, y, 0, 0, button, CB_BRUSH_TO_LEVEL);
}

static void CopyBrushToCursor(int x, int y)
{
  CopyBrushExt(x, y, 0, 0, 0, CB_BRUSH_TO_CURSOR);
}

static void DeleteBrushFromCursor()
{
  CopyBrushExt(0, 0, 0, 0, 0, CB_DELETE_OLD_CURSOR);
}

static void FloodFillExt(short FillFeld[MAX_ED_FIELDX][MAX_ED_FIELDY],
			 int from_x, int from_y, int fill_element)
{
  int i,x,y;
  int old_element;
  static int check[4][2] = { {-1,0}, {0,-1}, {1,0}, {0,1} };
  static int safety = 0;

  /* check if starting field still has the desired content */
  if (FillFeld[from_x][from_y] == fill_element)
    return;

  safety++;

  if (safety > MAX_ED_FIELDX * MAX_ED_FIELDY)
    Error(ERR_EXIT, "Something went wrong in 'FloodFillExt()'. Please debug.");

  old_element = FillFeld[from_x][from_y];
  FillFeld[from_x][from_y] = fill_element;

  for(i=0;i<4;i++)
  {
    x = from_x + check[i][0];
    y = from_y + check[i][1];

    if (x >= 0 && x < MAX_ED_FIELDX && y >= 0 && y < MAX_ED_FIELDY &&
	FillFeld[x][y] == old_element)
      FloodFillExt(FillFeld, x, y, fill_element);
  }

  safety--;
}

static void FloodFill(int from_x, int from_y, int fill_element)
{
  short FillFeld[MAX_ED_FIELDX][MAX_ED_FIELDY];
  int x, y;

  for (x=0; x<MAX_ED_FIELDX; x++) for (y=0; y<MAX_ED_FIELDY; y++)
    FillFeld[x][y] = getHiResLevelElement(x, y);

  FloodFillExt(FillFeld, from_x, from_y, fill_element);

  for (x=0; x<MAX_ED_FIELDX; x++) for (y=0; y<MAX_ED_FIELDY; y++)
    if (FillFeld[x][y] == fill_element)
      PutHiResLevelElement(x, y, FillFeld[x][y], TRUE);
}

#if 0
static void OLD_FloodFill(int from_x, int from_y, int fill_element)
{
  int i;
  int old_hires_element = getHiResLevelElement(from_x, from_y);
  int old_lores_element = Feld[from_x / 2][from_y / 2];
  static int check[4][2] = { {-1,0}, {0,-1}, {1,0}, {0,1} };
  static int safety = 0;

  /* check if starting field already has the desired content */
  if (old_hires_element == fill_element)
    return;

  safety++;

  if (safety > ed_fieldx * ed_fieldy)
    Error(ERR_EXIT, "Something went wrong in 'FloodFill()'. Please debug.");

  if (IS_WALL(fill_element) ||
      (fill_element == EL_EMPTY && IS_WALL(old_hires_element)))
  {
    if (IS_WALL(old_hires_element))
      PutHiResLevelElement(from_x, from_y, fill_element, TRUE);
    else
      Feld[from_x / 2][from_y / 2] = fill_element | 0x0f;

    /* do flood fill for all four possible fields */
    for(i=0;i<4;i++)
    {
      int from_xx = (from_x / 2) * 2 + i/2;
      int from_yy = (from_y / 2) * 2 + i%2;
      int j;

      if ((fill_element != EL_EMPTY &&
	   getHiResLevelElement(from_xx, from_yy) == fill_element &&
	   (getHiResLevelElement(from_xx, from_y) != EL_EMPTY ||
	    getHiResLevelElement(from_x, from_yy) != EL_EMPTY)) ||
	  (fill_element == EL_EMPTY && from_xx == from_x && from_yy == from_y))
      {
	for(j=0;j<4;j++)
	{
	  int next_x = from_xx + check[j][0];
	  int next_y = from_yy + check[j][1];

	  if (IN_ED_FIELD(next_x, next_y) &&
	      getHiResLevelElement(next_x, next_y) == old_hires_element)
	    FloodFill(next_x, next_y, fill_element);
	}
      }
    }
  }
  else
  {
    int lx = from_x / 2;
    int ly = from_y / 2;

    Feld[lx][ly] = fill_element;

    if (!IS_WALL(old_lores_element) || WALL_BITS(old_lores_element) == 0x0f)
    {
      for(i=0;i<4;i++)
      {
	int next_lx = lx + check[i][0];
	int next_ly = ly + check[i][1];
	int next_x = next_lx * 2;
	int next_y = next_ly * 2;

	if (IN_LEV_FIELD(next_lx, next_ly) &&
	    Feld[next_lx][next_ly] == old_lores_element)
	  FloodFill(next_x, next_y, fill_element);
      }
    }
  }

#if 0
  PutHiResLevelElement(from_x, from_y, fill_element, TRUE);

  for(i=0;i<4;i++)
  {
    int sx = from_x + check[i][0];
    int sy = from_y + check[i][1];
    int lx, ly;

    if (!IS_WALL(fill_element) && sx/2 == from_x/2 && sy/2 == from_y/2)
    {
      sx = from_x + 2 * check[i][0];
      sy = from_y + 2 * check[i][1];
    }

    lx = sx / 2;
    ly = sy / 2;

    /*
    printf("%d,%d\n", sx, sy);
    */

    if (IN_LEV_FIELD(lx, ly) && getHiResLevelElement(sx, sy) == old_element)
      FloodFill(sx, sy, fill_element);
  }
#endif

  safety--;
}
#endif

static void CopyLevelToUndoBuffer(int mode)
{
  static boolean accumulated_undo = FALSE;
  boolean new_undo_buffer_position = TRUE;
  int x, y;

  switch (mode)
  {
    case UNDO_IMMEDIATE:
      accumulated_undo = FALSE;
      break;

    case UNDO_ACCUMULATE:
      if (accumulated_undo)
	new_undo_buffer_position = FALSE;
      accumulated_undo = TRUE;
      break;

    default:
      break;
  }

  if (new_undo_buffer_position)
  {
    /* new position in undo buffer ring */
    undo_buffer_position = (undo_buffer_position + 1) % NUM_UNDO_STEPS;

    if (undo_buffer_steps < NUM_UNDO_STEPS - 1)
      undo_buffer_steps++;
  }

  for(x=0; x<lev_fieldx; x++)
    for(y=0; y<lev_fieldy; y++)
      UndoBuffer[undo_buffer_position][x][y] = Feld[x][y];

#if 0
#ifdef DEBUG
  printf("level saved to undo buffer %d\n", undo_buffer_position);
#endif
#endif
}

void WrapLevel(int dx, int dy)
{
  int wrap_dx = lev_fieldx - dx;
  int wrap_dy = lev_fieldy - dy;
  int x, y;

  for(x=0; x<lev_fieldx; x++)
    for(y=0; y<lev_fieldy; y++)
      FieldBackup[x][y] = Feld[x][y];

  for(x=0; x<lev_fieldx; x++)
    for(y=0; y<lev_fieldy; y++)
      Feld[x][y] =
	FieldBackup[(x + wrap_dx) % lev_fieldx][(y + wrap_dy) % lev_fieldy];

  DrawEditorLevel(ed_fieldx, ed_fieldy, level_xpos, level_ypos);
  CopyLevelToUndoBuffer(UNDO_ACCUMULATE);
}

static void HandleDrawingAreas(struct GadgetInfo *gi)
{
  static boolean started_inside_drawing_area = FALSE;
  int id = gi->custom_id;
  boolean button_press_event;
  boolean button_release_event;
  boolean inside_drawing_area = !gi->event.off_borders;
  boolean draw_level = (id == GADGET_ID_DRAWING_LEVEL);
  int actual_drawing_function;
  int button = gi->event.button;
  int new_element = BUTTON_ELEMENT(button);
  int sx = gi->event.x, sy = gi->event.y;
  int min_sx = 0, min_sy = 0;
  int max_sx = gi->drawing.area_xsize - 1, max_sy = gi->drawing.area_ysize - 1;
  int lx = 0, ly = 0;
  int min_lx = 0, min_ly = 0;
  int max_lx = lev_fieldx - 1, max_ly = lev_fieldy - 1;
  int x, y;

  /* handle info callback for each invocation of action callback */
  gi->callback_info(gi);

  button_press_event = (gi->event.type == GD_EVENT_PRESSED);
  button_release_event = (gi->event.type == GD_EVENT_RELEASED);

  /* make sure to stay inside drawing area boundaries */
  sx = (sx < min_sx ? min_sx : sx > max_sx ? max_sx : sx);
  sy = (sy < min_sy ? min_sy : sy > max_sy ? max_sy : sy);

  if (draw_level)
  {
    /* get positions inside level field */
    lx = sx / 2;
    ly = sy / 2;

    if (!IN_LEV_FIELD(lx, ly))
      inside_drawing_area = FALSE;

    /* make sure to stay inside level field boundaries */
    lx = (lx < min_lx ? min_lx : lx > max_lx ? max_lx : lx);
    ly = (ly < min_ly ? min_ly : ly > max_ly ? max_ly : ly);

#if 0
    /* correct drawing area positions accordingly */
    sx = lx - level_xpos;
    sy = ly - level_ypos;
#endif
  }

  if (button_press_event)
    started_inside_drawing_area = inside_drawing_area;

  if (!started_inside_drawing_area)
    return;

  if (!button && !button_release_event)
    return;

  /* automatically switch to 'single item' drawing mode, if needed */
  actual_drawing_function =
    (draw_level ? drawing_function : GADGET_ID_SINGLE_ITEMS);

  switch (actual_drawing_function)
  {
    case GADGET_ID_SINGLE_ITEMS:
      if (button_release_event)
      {
	CopyLevelToUndoBuffer(UNDO_IMMEDIATE);

	if (edit_mode == ED_MODE_DRAWING && draw_with_brush &&
	    !inside_drawing_area)
	  DeleteBrushFromCursor();
      }

      if (!button)
	break;

      if (draw_with_brush)
      {
	if (!button_release_event)
	  CopyBrushToLevel(sx, sy, button);
      }
      else if (new_element != Feld[lx][ly])
      {
	if (IS_MCDUFFIN(new_element) || IS_LASER(new_element))
	{
	  /* remove player at old position */
	  for(y=0; y<lev_fieldy; y++)
	  {
	    for(x=0; x<lev_fieldx; x++)
	    {
	      if (IS_MCDUFFIN(Feld[x][y]) || IS_LASER(Feld[x][y]))
	      {
		Feld[x][y] = EL_EMPTY;
		if (x - level_xpos >= 0 && x - level_xpos < ed_fieldx &&
		    y - level_ypos >= 0 && y - level_ypos < ed_fieldy)
		  DrawElement(x - level_xpos, y - level_ypos, EL_EMPTY);
	      }
	    }
	  }
	}

	WriteHiResLevelElement(sx, sy, new_element);
      }
      break;

    case GADGET_ID_LINE:
    case GADGET_ID_ARC:
    case GADGET_ID_RECTANGLE:
    case GADGET_ID_FILLED_BOX:
    case GADGET_ID_GRAB_BRUSH:
      {
	static int last_sx = -1;
	static int last_sy = -1;
	static int start_sx = -1;
	static int start_sy = -1;
	void (*draw_func)(int, int, int, int, int, boolean);

	if (drawing_function == GADGET_ID_LINE)
	  draw_func = DrawLine;
	else if (drawing_function == GADGET_ID_ARC)
	  draw_func = DrawArc;
	else if (drawing_function == GADGET_ID_RECTANGLE)
	  draw_func = DrawRectangle;
	else if (drawing_function == GADGET_ID_FILLED_BOX)
	  draw_func = DrawFilledBox;
	else /* (drawing_function == GADGET_ID_GRAB_BRUSH) */
	  draw_func = SelectArea;

	if (button_press_event)
	{
	  draw_func(sx, sy, sx, sy, new_element, FALSE);
	  start_sx = last_sx = sx;
	  start_sy = last_sy = sy;
	}
	else if (button_release_event)
	{
	  draw_func(start_sx, start_sy, sx, sy, new_element, TRUE);
	  if (drawing_function == GADGET_ID_GRAB_BRUSH)
	  {
	    CopyAreaToBrush(start_sx, start_sy, sx, sy, button);
	    CopyBrushToCursor(sx, sy);
	    ClickOnGadget(level_editor_gadget[GADGET_ID_SINGLE_ITEMS],
			  MB_LEFTBUTTON);
	    draw_with_brush = TRUE;
	  }
	  else
	    CopyLevelToUndoBuffer(UNDO_IMMEDIATE);
	}
	else if (last_sx != sx || last_sy != sy)
	{
#if 0
	  draw_func(start_sx, start_sy, last_sx, last_sy, -1, FALSE);
	  draw_func(start_sx, start_sy, sx, sy, EL_EMPTY, FALSE);
	  draw_func(start_sx, start_sy, sx, sy, new_element, FALSE);
#else
	  draw_func(start_sx, start_sy, last_sx, last_sy, -1, FALSE);
	  if (IS_WALL(new_element))	/* clear wall background */
	    draw_func(start_sx, start_sy, sx, sy, EL_WALL_EMPTY, FALSE);
	  draw_func(start_sx, start_sy, sx, sy, new_element, FALSE);
#endif
	  last_sx = sx;
	  last_sy = sy;
	}
      }
      break;

    case GADGET_ID_FLOOD_FILL:
      if (button_press_event && Feld[lx][ly] != new_element)
      {
	FloodFill(sx, sy, new_element);
	DrawEditorLevel(ed_fieldx, ed_fieldy, level_xpos, level_ypos);
	CopyLevelToUndoBuffer(UNDO_IMMEDIATE);
      }
      break;

    case GADGET_ID_PICK_ELEMENT:
      if (button_release_event)
	ClickOnGadget(level_editor_gadget[last_drawing_function],
		      MB_LEFTBUTTON);
      else
	PickDrawingElement(button, getHiResLevelElement(sx, sy));
      break;

    default:
      break;
  }
}

static void HandleCounterButtons(struct GadgetInfo *gi)
{
  int gadget_id = gi->custom_id;
  int counter_id = gi->custom_type_id;
  int button = gi->event.button;
  int *counter_value = counterbutton_info[counter_id].value;
  int step = BUTTON_STEPSIZE(button) *
    (gadget_id == counterbutton_info[counter_id].gadget_id_down ? -1 : +1);

  if (counter_id == ED_COUNTER_ID_SELECT_LEVEL)
  {
    boolean pressed = (gi->event.type == GD_EVENT_PRESSED);
    boolean released = (gi->event.type == GD_EVENT_RELEASED);
    boolean level_changed = LevelChanged();

    if ((level_changed && pressed) || (!level_changed && released))
      return;

    if (level_changed && !Request("Level has changed! Discard changes ?",
				  REQ_ASK))
    {
      if (gadget_id == counterbutton_info[counter_id].gadget_id_text)
	ModifyEditorCounter(counter_id, *counter_value);
      return;
    }
  }

  if (gadget_id == counterbutton_info[counter_id].gadget_id_text)
    *counter_value = gi->text.number_value;
  else
    ModifyEditorCounter(counter_id, *counter_value + step);

  switch (counter_id)
  {
    case ED_COUNTER_ID_SELECT_LEVEL:
      LoadLevel(level_nr);
      ResetUndoBuffer();
      DrawEditModeWindow();
      break;

    default:
      break;
  }
}

static void HandleTextInputGadgets(struct GadgetInfo *gi)
{
  strcpy(textinput_info[gi->custom_type_id].value, gi->text.value);
}

static void HandleCheckbuttons(struct GadgetInfo *gi)
{
  *checkbutton_info[gi->custom_type_id].value ^= TRUE;

  if (gi->custom_id == GADGET_ID_AUTO_COUNT && level.auto_count_kettles)
  {
    int x, y;

    level.kettles_needed = 0;

    for (y=0; y<lev_fieldy; y++)
      for(x=0; x<lev_fieldx; x++)
	if (Feld[x][y] == EL_KETTLE)
	  level.kettles_needed++;
    
    ModifyEditorCounter(ED_COUNTER_ID_LEVEL_COLLECT, level.kettles_needed);
  }
}

static void HandleControlButtons(struct GadgetInfo *gi)
{
  int id = gi->custom_id;
  int button = gi->event.button;
  int step = BUTTON_STEPSIZE(button);
  int new_element = BUTTON_ELEMENT(button);
  int i, x, y;

  switch (id)
  {
    case GADGET_ID_SCROLL_LIST_UP:
    case GADGET_ID_SCROLL_LIST_DOWN:
    case GADGET_ID_SCROLL_LIST_VERTICAL:
      if (id == GADGET_ID_SCROLL_LIST_VERTICAL)
	element_shift = gi->event.item_position * ED_ELEMENTLIST_BUTTONS_HORIZ;
      else
      {
	step *= (id == GADGET_ID_SCROLL_LIST_UP ? -1 : +1);
	element_shift += step * ED_ELEMENTLIST_BUTTONS_HORIZ;

	if (element_shift < 0)
	  element_shift = 0;
	if (element_shift > elements_in_list - ED_NUM_ELEMENTLIST_BUTTONS)
	  element_shift = elements_in_list - ED_NUM_ELEMENTLIST_BUTTONS;

	ModifyGadget(level_editor_gadget[GADGET_ID_SCROLL_LIST_VERTICAL],
		     GDI_SCROLLBAR_ITEM_POSITION,
		     element_shift / ED_ELEMENTLIST_BUTTONS_HORIZ, GDI_END);
      }

      for (i=0; i<ED_NUM_ELEMENTLIST_BUTTONS; i++)
      {
	int gadget_id = GADGET_ID_ELEMENTLIST_FIRST + i;
	struct GadgetInfo *gi = level_editor_gadget[gadget_id];
	struct GadgetDesign *gd = &gi->deco.design;
	int element = editor_element[element_shift + i];

	UnmapGadget(gi);
	getMiniGraphicSource(el2gfx(element), &gd->bitmap, &gd->x, &gd->y);
	ModifyGadget(gi, GDI_INFO_TEXT, getElementInfoText(element), GDI_END);
	MapGadget(gi);
      }
      break;

    case GADGET_ID_WRAP_LEFT:
      WrapLevel(-step, 0);
      break;

    case GADGET_ID_WRAP_RIGHT:
      WrapLevel(step, 0);
      break;

    case GADGET_ID_WRAP_UP:
      WrapLevel(0, -step);
      break;

    case GADGET_ID_WRAP_DOWN:
      WrapLevel(0, step);
      break;

    case GADGET_ID_SINGLE_ITEMS:
    case GADGET_ID_LINE:
    case GADGET_ID_ARC:
    case GADGET_ID_RECTANGLE:
    case GADGET_ID_FILLED_BOX:
    case GADGET_ID_FLOOD_FILL:
    case GADGET_ID_GRAB_BRUSH:
    case GADGET_ID_PICK_ELEMENT:
      last_drawing_function = drawing_function;
      drawing_function = id;
      draw_with_brush = FALSE;
      break;

    case GADGET_ID_UNDO:
      if (undo_buffer_steps == 0)
      {
	Request("Undo buffer empty !", REQ_CONFIRM);
	break;
      }

      undo_buffer_position =
	(undo_buffer_position - 1 + NUM_UNDO_STEPS) % NUM_UNDO_STEPS;
      undo_buffer_steps--;

      for(x=0; x<lev_fieldx; x++)
	for(y=0; y<lev_fieldy; y++)
	  Feld[x][y] = UndoBuffer[undo_buffer_position][x][y];
      DrawEditorLevel(ed_fieldx, ed_fieldy, level_xpos,level_ypos);

#if 0
#ifdef DEBUG
  printf("level restored from undo buffer %d\n", undo_buffer_position);
#endif
#endif
      break;

    case GADGET_ID_INFO:
      if (edit_mode != ED_MODE_INFO)
      {
	DrawLevelInfoWindow();
	edit_mode = ED_MODE_INFO;
      }
      else
      {
	DrawDrawingWindow();
	edit_mode = ED_MODE_DRAWING;
      }
      break;

    case GADGET_ID_CLEAR:
      for(x=0; x<MAX_LEV_FIELDX; x++) 
	for(y=0; y<MAX_LEV_FIELDY; y++) 
	  Feld[x][y] = (button == 1 ? EL_EMPTY : new_element);
      CopyLevelToUndoBuffer(GADGET_ID_CLEAR);

      DrawEditorLevel(ed_fieldx, ed_fieldy, level_xpos, level_ypos);
      break;

    case GADGET_ID_SAVE:
      if (leveldir_current->readonly)
      {
	Request("This level is read only !", REQ_CONFIRM);
	break;
      }

      if (!LevelContainsPlayer)
	Request("No Level without Gregor Mc Duffin please !", REQ_CONFIRM);
      else
      {
	if (Request("Save this level and kill the old ?", REQ_ASK))
	{
	  for(x=0; x<lev_fieldx; x++)
	    for(y=0; y<lev_fieldy; y++) 
	      Ur[x][y] = Feld[x][y];
	  SaveLevel(level_nr);
	}
      }
      break;

    case GADGET_ID_TEST:
      if (!LevelContainsPlayer)
	Request("No Level without Gregor Mc Duffin please !", REQ_CONFIRM);
      else
      {
	for(x=0; x<lev_fieldx; x++)
	  for(y=0; y<lev_fieldy; y++)
	    FieldBackup[x][y] = Ur[x][y];

	for(x=0; x<lev_fieldx; x++)
	  for(y=0; y<lev_fieldy; y++)
	    Ur[x][y] = Feld[x][y];

	UnmapLevelEditorGadgets();

	CloseDoor(DOOR_CLOSE_ALL);

	level_editor_test_game = TRUE;
	game_status = PLAYING;

	InitGame();
      }
      break;

    case GADGET_ID_EXIT:
      if (!LevelChanged() ||
	  Request("Level has changed! Exit without saving ?",
		  REQ_ASK | REQ_STAY_OPEN))
      {
	CloseDoor(DOOR_CLOSE_1);

	/*
	CloseDoor(DOOR_CLOSE_ALL);
	*/

	game_status = MAINMENU;
	DrawMainMenu();
      }
      else
      {
	CloseDoor(DOOR_CLOSE_1);
	BlitBitmap(pix[PIX_DB_DOOR], pix[PIX_DB_DOOR],
		   DOOR_GFX_PAGEX2, DOOR_GFX_PAGEY1, DXSIZE,DYSIZE,
		   DOOR_GFX_PAGEX1, DOOR_GFX_PAGEY1);
	OpenDoor(DOOR_OPEN_1);
      }
      break;

    case GADGET_ID_DRAWING_ELEMENT_LEFT:
    case GADGET_ID_DRAWING_ELEMENT_MIDDLE:
    case GADGET_ID_DRAWING_ELEMENT_RIGHT:
    {
      int new_element_nr = id - GADGET_ID_DRAWING_ELEMENT_LEFT + 1;
      int rotated_element =
	get_rotated_element(new_drawing_element[new_element_nr],
			    BUTTON_ROTATION(button));

      PickDrawingElement(new_element_nr, rotated_element);
      HandleEditorGadgetInfoText(gi);
      break;
    }

    default:
      if (id >= GADGET_ID_ELEMENTLIST_FIRST &&
	  id <= GADGET_ID_ELEMENTLIST_LAST)
      {
	int element_position = id - GADGET_ID_ELEMENTLIST_FIRST;
	int new_element = editor_element[element_position + element_shift];

	PickDrawingElement(button, new_element);

	if (drawing_function == GADGET_ID_PICK_ELEMENT)
	  ClickOnGadget(level_editor_gadget[last_drawing_function],
			MB_LEFTBUTTON);
      }
#ifdef DEBUG
      else if (gi->event.type == GD_EVENT_PRESSED)
	printf("default: HandleControlButtons: GD_EVENT_PRESSED(%d)\n", id);
      else if (gi->event.type == GD_EVENT_RELEASED)
	printf("default: HandleControlButtons: GD_EVENT_RELEASED(%d)\n", id);
      else if (gi->event.type == GD_EVENT_MOVING)
	printf("default: HandleControlButtons: GD_EVENT_MOVING(%d)\n", id);
      else
	printf("default: HandleControlButtons: ? (id == %d)\n", id);
#endif
      break;
  }
}

void HandleLevelEditorKeyInput(Key key)
{
  char letter = getCharFromKey(key);
  int button = MB_LEFTBUTTON;

  if (button_status == MB_RELEASED)
  {
    int i, id;

    switch (key)
    {
      case KSYM_Page_Up:
	id = GADGET_ID_SCROLL_LIST_UP;
	button = MB_RIGHTBUTTON;
	break;
      case KSYM_Page_Down:
	id = GADGET_ID_SCROLL_LIST_DOWN;
	button = MB_RIGHTBUTTON;
	break;

      default:
	id = GADGET_ID_NONE;
	break;
    }

    if (id != GADGET_ID_NONE)
      ClickOnGadget(level_editor_gadget[id], button);
    else if (letter == '.')
      ClickOnGadget(level_editor_gadget[GADGET_ID_SINGLE_ITEMS], button);
    else if (key == KSYM_space || key == KSYM_Return)
      ClickOnGadget(level_editor_gadget[GADGET_ID_TEST], button);
    else
      for (i=0; i<ED_NUM_CTRL_BUTTONS; i++)
	if (letter && letter == control_info[i].shortcut)
	  if (!anyTextGadgetActive())
	    ClickOnGadget(level_editor_gadget[i], button);
  }
}

void ClearEditorGadgetInfoText()
{
  int x;

  if (edit_mode == ED_MODE_DRAWING)
    for (x=0; x<lev_fieldx; x++)
      DrawElement(x, lev_fieldy-1, Feld[x][lev_fieldy-1]);
  else
    ClearRectangle(drawto,
		   INFOTEXT_XPOS, INFOTEXT_YPOS,
		   INFOTEXT_XSIZE, INFOTEXT_YSIZE);

  redraw_mask |= REDRAW_FIELD;
}

void HandleEditorGadgetInfoText(void *ptr)
{
  struct GadgetInfo *gi = (struct GadgetInfo *)ptr;
  char infotext[MAX_INFOTEXT_LEN + 1];
  char shortcut[MAX_INFOTEXT_LEN + 1];

  ClearEditorGadgetInfoText();

  /* misuse this function to delete brush cursor, if needed */
  if (edit_mode == ED_MODE_DRAWING && draw_with_brush)
    DeleteBrushFromCursor();

  if (gi == NULL || gi->info_text == NULL)
    return;

  strncpy(infotext, gi->info_text, MAX_INFOTEXT_LEN);
  infotext[MAX_INFOTEXT_LEN] = '\0';

  if (gi->custom_id < ED_NUM_CTRL_BUTTONS)
  {
    int key = control_info[gi->custom_id].shortcut;

    if (key)
    {
      if (gi->custom_id == GADGET_ID_SINGLE_ITEMS)	/* special case 1 */
	sprintf(shortcut, " ('.' or '%c')", key);
      else if (gi->custom_id == GADGET_ID_TEST)		/* special case 2 */
	sprintf(shortcut, " ('Enter' or 'Shift-%c')", key);
      else						/* normal case */
	sprintf(shortcut, " ('%s%c')",
		(key >= 'A' && key <= 'Z' ? "Shift-" : ""), key);

      if (strlen(infotext) + strlen(shortcut) <= MAX_INFOTEXT_LEN)
	strcat(infotext, shortcut);
    }
  }

  DrawText(INFOTEXT_XPOS, INFOTEXT_YPOS, infotext, FS_SMALL, FC_YELLOW);
}

static void HandleDrawingAreaInfo(struct GadgetInfo *gi)
{
#if 0
  static int start_lx, start_ly;
  char *infotext;
#endif
  int id = gi->custom_id;
  int sx = gi->event.x;
  int sy = gi->event.y;
  int lx = sx / 2 + level_xpos;
  int ly = sy / 2 + level_ypos;
  int min_sx = 0, min_sy = 0;
  int max_sx = gi->drawing.area_xsize - 1;
  int max_sy = gi->drawing.area_ysize - 1;

  ClearEditorGadgetInfoText();

  /* make sure to stay inside drawing area boundaries */
  sx = (sx < min_sx ? min_sx : sx > max_sx ? max_sx : sx);
  sy = (sy < min_sy ? min_sy : sy > max_sy ? max_sy : sy);

  if (id == GADGET_ID_DRAWING_LEVEL)
  {
    if (button_status)
    {
      int min_lx = 0, min_ly = 0;
      int max_lx = lev_fieldx - 1, max_ly = lev_fieldy - 1;

      /* get positions inside level field */
      lx = sx / 2 + level_xpos;
      ly = sy / 2 + level_ypos;

      /* make sure to stay inside level field boundaries */
      lx = (lx < min_lx ? min_lx : lx > max_lx ? max_lx : lx);
      ly = (ly < min_ly ? min_ly : ly > max_ly ? max_ly : ly);

#if 0
      /* correct drawing area positions accordingly */
      sx = lx - level_xpos;
      sy = ly - level_ypos;
#endif
    }

#if 0
    if (IN_ED_FIELD(sx,sy) && IN_LEV_FIELD(lx, ly))
    {
      if (button_status)	/* if (gi->state == GD_BUTTON_PRESSED) */
      {
	if (gi->event.type == GD_EVENT_PRESSED)
	{
	  start_lx = lx;
	  start_ly = ly;
	}

	switch (drawing_function)
	{
	  case GADGET_ID_SINGLE_ITEMS:
	    infotext = "Drawing single items";
	    break;
      	  case GADGET_ID_LINE:
	    infotext = "Drawing line";
	    break;
      	  case GADGET_ID_ARC:
	    infotext = "Drawing arc";
	    break;
      	  case GADGET_ID_RECTANGLE:
	    infotext = "Drawing rectangle";
	    break;
      	  case GADGET_ID_FILLED_BOX:
	    infotext = "Drawing filled box";
	    break;
      	  case GADGET_ID_FLOOD_FILL:
	    infotext = "Flood fill";
	    break;
      	  case GADGET_ID_GRAB_BRUSH:
	    infotext = "Grabbing brush";
	    break;
      	  case GADGET_ID_PICK_ELEMENT:
	    infotext = "Picking element";
	    break;

	  default:
	    infotext = "Drawing position";
	    break;
	}

	if (drawing_function == GADGET_ID_PICK_ELEMENT)
	  DrawTextF(INFOTEXT_XPOS - SX, INFOTEXT_YPOS - SY, FC_YELLOW,
		    "%s: %d, %d", infotext, lx, ly);
	else
	  DrawTextF(INFOTEXT_XPOS - SX, INFOTEXT_YPOS - SY, FC_YELLOW,
		    "%s: %d, %d", infotext,
		    ABS(lx - start_lx) + 1, ABS(ly - start_ly) + 1);
      }
      else if (drawing_function == GADGET_ID_PICK_ELEMENT)
	DrawTextF(INFOTEXT_XPOS - SX, INFOTEXT_YPOS - SY, FC_YELLOW,
		  "%s", getElementInfoText(Feld[lx][ly]));
      else
	DrawTextF(INFOTEXT_XPOS - SX, INFOTEXT_YPOS - SY, FC_YELLOW,
		  "Level position: %d, %d", lx, ly);
    }
#endif

    /* misuse this function to draw brush cursor, if needed */
    if (edit_mode == ED_MODE_DRAWING && draw_with_brush && !button_status)
    {
      if (IN_ED_FIELD(sx, sy) && IN_LEV_FIELD(lx, ly))
	CopyBrushToCursor(sx, sy);
      else
	DeleteBrushFromCursor();
    }
  }
}
