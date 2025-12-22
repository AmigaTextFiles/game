//
// Sudoku game using Reaction. Written by Roland Florac on july 2006.
// The new game routine is taken from Sudoku (with FLTK) by Michael R Sweet
//
// Compilation :
//	g++ -o AmiSudoku AmiSudoku.cxx -lm
// or
//	g++ -o AmiSudoku AmiSudoku.cxx -O2 -lm
//	strip -s -R.comment AmiSudoku

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

#include <exec/types.h>
#include <intuition/icclass.h>
#include <proto/asl.h>
#include <proto/console.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/gadtools.h>	/* for NewMenus */
#include <proto/graphics.h>
#include <proto/icon.h>
#include <proto/intuition.h>
#include <proto/locale.h>

#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>
#include <reaction/reaction_macros.h>

// To debug the solver, remove the two slashes from the next line
// #define DEBUG_PLAY 1

#define max(a,b) a>b?a:b

#define CATALOG_VERSION 1

#define LEVEL_MIN 1
#define LEVEL_MAX 4

#define CELLSIZE_MIN 0
#define CELLSIZE_MAX 5

#define NCOLORS 10	    /* Number of used colors */
#define RED	0
#define GREEN	1
#define BLUE	2
#define LIGHT_BLUE 3
#define YELLOW	4
#define VIOLET	5
#define GRAY	6
#define WHITE	7
#define BROWN	8
#define BLACK	9

#define AMISUDOKU_VERSION "1.00"
char version[] = "$VER: AmiSudoku "AMISUDOKU_VERSION" by R.Florac (July 2006)";
#define AMISUDOKU_TXT version+6

/* Libraries stuff ***********************************************************/
struct library {
    struct Library ** lib;
    struct Interface ** interface;
    int version;
    char * libname;
};

struct Library * IntuitionBase, * GfxBase, * IconBase, * WindowBase, * LayoutBase,
	    * ButtonBase, * LabelBase, * IntegerBase, * ListBrowserBase,
	    * CheckBoxBase, * ChooserBase, * SpaceBase, * LocaleBase, * AslBase;

struct IntuitionIFace * IIntuition;
struct GraphicsIFace * IGraphics;
struct IconIFace * IIcon;
struct WindowIFace * IWindow;
struct LayoutIFace * ILayout;
struct ButtonIFace * IButton;
struct LabelIFace * ILabel;
struct IntegerIFace * IInteger;
struct ListBrowserIFace * IListBrowser;
struct ChooserIFace * IChooser;
struct SpaceIFace * ISpace;
struct LocaleIFace * ILocale;
struct AslIFace * IAsl;

struct library libs[] = {
    {	&IntuitionBase, (struct Interface **) &IIntuition, 51, "intuition.library" },
    {	&GfxBase, (struct Interface **) &IGraphics, 51, "graphics.library" },
    {	&IconBase, (struct Interface **) &IIcon, 51, "icon.library" },
    {	&WindowBase, (struct Interface **) &IWindow, 51, "window.class" },
    {	&LayoutBase, (struct Interface **) &ILayout, 51, "gadgets/layout.gadget" },
    {	&ButtonBase, (struct Interface **) &IButton, 50, "gadgets/button.gadget" },
    {	&LabelBase, (struct Interface **) &ILabel, 50, "images/label.image" },
    {	&IntegerBase, (struct Interface **) &IInteger, 50, "gadgets/integer.gadget" },
    {	&ListBrowserBase, (struct Interface **) &IListBrowser, 51, "gadgets/listbrowser.gadget" },
    {	&ChooserBase, (struct Interface **) &IChooser, 50, "gadgets/chooser.gadget" },
    {	&SpaceBase, (struct Interface **) &ISpace, 50, "gadgets/space.gadget" },
    {	&LocaleBase, (struct Interface **) &ILocale, 50, "locale.library" },
    {	&AslBase, (struct Interface **) &IAsl, 50, "asl.library" },
    {	0, 0, 0, 0 }
};

/* Strings ID (for locale) ***************************************************/
enum {
    /* Menus */
    PROJECT_MENU_STRING = 0, NEWGAME_MENU_STRING, CHECK_MENU_STRING, RESTART_MENU_STRING,
    SOLVE_MENU_STRING, UNDO_MENU_STRING, SAVE_MEMORY_MENU_STRING, RESTORE_MENU_STRING,
    EDITGAME_MENU_STRING, LOAD_MENU_STRING, SAVE_MENU_STRING, PREFS_MENU_STRING, ABOUT_MENU_STRING, QUIT_MENU_STRING,
    HELP_MENU_STRING, SHOWERRORS_MENU_STRING, AUTOUPDATE_HELP_MENU_STRING, QUICK_HELP_MENU_STRING,
    CELL_TEST_MENU_STRING, INIT_MENU_STRING, VERTICAL_MENU_STRING, HORIZONTAL_MENU_STRING,
    GROUP_MENU_STRING, ALL_MENU_STRING, CHECK_ALL_CELLS_MENU_STRING, SHOW_POSSIBLE_MENU_STRING,
    ONE_MENU_STRING, TWO_MENU_STRING, THREE_MENU_STRING, FOUR_MENU_STRING, FIVE_MENU_STRING,
    SIX_MENU_STRING, SEVEN_MENU_STRING, EIGHT_MENU_STRING, NINE_MENU_STRING, ERASE_MENU_STRING,
    SHOW_EASY_CELLS_MENU_STRING, PLAY_MENU_STRING,

    /* Some button labels */
    ACCEPT_STRING, CANCEL_STRING, OK_STRING, USE_STRING, SAVE_STRING,

    /* Prefs requester */
    CELL_SIZE_STRING, VERY_SMALL_SIZE_STRING, SMALL_SIZE_STRING, MEDIUM_SIZE_STRING, LARGE_SIZE_STRING,
    VERY_LARGE_SIZE_STRING, SUPER_LARGE_SIZE_STRING, SUDOKU_PREFS_STRING,

    /* Messages */
    LEVEL_STRING, SAVING_FILE_STRING, LOADING_FILE_STRING, EDITING_GAME_STRING, EDITED_GAME_STRING,
    AMISUDOKU_MESSAGE_STRING, SOLVING_MESSAGE_STRING, NOTHING_TO_UNDO_STRING,
    NOTHING_TO_RESTORE_STRING, ABOUT_STRING,

    /* Error messages */
    SUDOKU_ERROR_STRING, OPENING_LIBRARY_ERROR_STRING, OPENREQUESTER_ERROR_STRING,
    ALLOCATION_REQUESTER_ERROR_STRING, LOCKSCREEN_ERROR_STRING,
    SAVING_PREFS_ERROR_STRING,
    SAVING_DISKOBJECT_ERROR_STRING, BAD_LEVEL_VALUE_STRING, BAD_CELLSIZE_VALUE_STRING,
    LOADING_DISKOBJECT_ERROR_STRING, SOLVING_ERROR_STRING, STOPSOLVING_ERROR_STRING,
    ERROR_OPENING_FILE_STRING, ERROR_CHECKING_GAME, INCORRECT_GRID_STRING,
    ERROR_READING_FILE, APPPORT_ERROR_STRING,

    /* Must be the last one... */
    STRINGS_NUMBER
};

/* Localized strings (MUST BE in the SAME ORDER than the previous enum) ******/
STRPTR strings[STRINGS_NUMBER] = {
    /* Menus */
    "Project", "New game", "Check", "Restart", "Solve", "Undo", "Save in memory", "Restore",
    "Edit game", "Load file", "Save file",
    "Prefs...", "About", "Quit",
    "Help", "Show errors", "Auto update", "Enable quick help", "Cell test",
    "Init", "+Column", "+Line", "+Group", "+All", "Check all cells",
    "Show possible", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Erase",
    "Show easy cells", "Suggest",

    /* Some button labels */
    "Accept", "Cancel", "OK", "_Use", "_Save",

    /* Prefs requester */
    "Cell size", "Very small", "Small", "Medium", "Large", "Very large", "Super large",
    "AmiSudoku prefs",

    /* Messages */
    "Level", "Saving game", "Loading game", "Editing game. Select New game menu to begin.",
    "Edited game", "AmiSudoku message", "Searching a solution... Press ESC to interrupt",
    "Nothing to undo", "Nothing to restore",
    "AmiSudoku 1.00 (July 2006).\nCompiled with GCC 4.0.2 by R.Florac.",

    /* Error messages */
    "AmiSudoku error", "Error opening library %s version %ld", "Could not open requester",
    "Could not allocate requester", "Could not lock pub screen",
    "Could not save icon file",
    "Could not find AmiSudoku.info file\n   Saving prefs impossible",
    "Bad level value\nin AmiSudoku tooltypes", "Bad cellsize value\nin AmiSudoku tooltypes",
    "Could not find AmiSudoku.info file\n  Loading prefs impossible", "Impossible to solve this game",
    "Searching a solution\ninterrupted by user", "Error opening file", "Game error check",
    "Incorrect grid :\nCorrect it before using it.", "Error reading file", "Error creating app port"
};

/* Definition of the menu entries ********************************************/
enum { PROJECT_MENU=0, HELP_MENU };
// Project menu
enum { NEW_GAME_MENU=0, CHECK_MENU, RESTART_MENU, SOLVE_MENU, UNDO_MENU, SAVE_MEMORY_MENU, RESTORE_MENU,
    EDITGAME_MENU, LOAD_MENU, SAVE_MENU, PREFS_MENU, ABOUT_MENU, QUIT_MENU
};
// Help menu
enum { SHOWERRORS_MENU = 0, AUTOUPDATE_HELP_MENU, QUICK_HELP_MENU, CELL_TEST_MENU,
    ALL_CELLS_MENU, SHOW_POSSIBLE_MENU, SHOW_EASY_CELLS_MENU, PLAY_MENU,
};
// Cell test submenu
enum { INIT_MENU = 0, VERTICAL_MENU, HORIZONTAL_MENU,
    GROUP_MENU, ALL_MENU,
};

struct NewMenu newmenu[] =
{
    { NM_TITLE, 0, 0, 0, 0, (APTR) PROJECT_MENU_STRING },
    { NM_ITEM, 0, "N", 0, 0, (APTR) NEWGAME_MENU_STRING },
    { NM_ITEM, 0, "C", 0, 0, (APTR) CHECK_MENU_STRING },
    { NM_ITEM, 0, "R", 0, 0, (APTR) RESTART_MENU_STRING },
    { NM_ITEM, 0, "W", 0, 0, (APTR) SOLVE_MENU_STRING },
    { NM_ITEM, 0, "U", 0, 0, (APTR) UNDO_MENU_STRING },
    { NM_ITEM, 0, "Y", 0, 0, (APTR) SAVE_MEMORY_MENU_STRING },
    { NM_ITEM, 0, "T", NM_ITEMDISABLED, 0, (APTR) RESTORE_MENU_STRING },
    { NM_ITEM, 0, "E", 0, 0, (APTR) EDITGAME_MENU_STRING },
    { NM_ITEM, 0, "L", 0, 0, (APTR) LOAD_MENU_STRING },
    { NM_ITEM, 0, "S", 0, 0, (APTR) SAVE_MENU_STRING},
    { NM_ITEM, 0, "P", 0, 0, (APTR) PREFS_MENU_STRING},
    { NM_ITEM, 0, "K", 0, 0, (APTR) ABOUT_MENU_STRING},
    { NM_ITEM, 0, "Q", 0, 0, (APTR) QUIT_MENU_STRING },
    { NM_TITLE, 0, 0, 0, 0, (APTR) HELP_MENU_STRING },
    { NM_ITEM, 0, 0, MENUTOGGLE | CHECKIT, 0, (APTR) SHOWERRORS_MENU_STRING },
    { NM_ITEM, 0, 0, MENUTOGGLE | CHECKIT, 0, (APTR) AUTOUPDATE_HELP_MENU_STRING },
    { NM_ITEM, 0, 0, MENUTOGGLE | CHECKIT, 0, (APTR) QUICK_HELP_MENU_STRING },
    { NM_ITEM, 0, 0, 0, 0, (APTR) CELL_TEST_MENU_STRING },
    { NM_SUB, 0, "I", 0, 0, (APTR) INIT_MENU_STRING },
    { NM_SUB, 0, "V", 0, 0, (APTR) VERTICAL_MENU_STRING },
    { NM_SUB, 0, "H", 0, 0, (APTR) HORIZONTAL_MENU_STRING },
    { NM_SUB, 0, "G", 0, 0, (APTR) GROUP_MENU_STRING },
    { NM_SUB, 0, "A", 0, 0, (APTR) ALL_MENU_STRING },
    { NM_ITEM, 0, "O", 0, 0, (APTR) CHECK_ALL_CELLS_MENU_STRING },
    { NM_ITEM, 0, "M", 0, 0, (APTR) SHOW_POSSIBLE_MENU_STRING },
    { NM_SUB, 0, "1", 0, 0, (APTR) ONE_MENU_STRING },
    { NM_SUB, 0, "2", 0, 0, (APTR) TWO_MENU_STRING },
    { NM_SUB, 0, "3", 0, 0, (APTR) THREE_MENU_STRING },
    { NM_SUB, 0, "4", 0, 0, (APTR) FOUR_MENU_STRING },
    { NM_SUB, 0, "5", 0, 0, (APTR) FIVE_MENU_STRING },
    { NM_SUB, 0, "6", 0, 0, (APTR) SIX_MENU_STRING },
    { NM_SUB, 0, "7", 0, 0, (APTR) SEVEN_MENU_STRING },
    { NM_SUB, 0, "8", 0, 0, (APTR) EIGHT_MENU_STRING },
    { NM_SUB, 0, "9", 0, 0, (APTR) NINE_MENU_STRING },
    { NM_SUB, 0, "0", 0, 0, (APTR) ERASE_MENU_STRING },
    { NM_ITEM, 0, "F", 0, 0, (APTR) SHOW_EASY_CELLS_MENU_STRING },
    { NM_ITEM, 0, "Z", 0, 0, (APTR) PLAY_MENU_STRING },

    {  NM_END, NULL, 0, 0, 0, 0}
};

struct Catalog * catalog;

struct graph {
    struct Window * window;
    /* Colors used to render the game */
    int colors[NCOLORS];
};

STRPTR GetLocaleString (int i)
{
    STRPTR defstring = strings[i];
    if (catalog)
	return (STRPTR) ILocale->GetCatalogStr (catalog, i, defstring);
    else
	return defstring;
}

static void init_menus (void)
{
    struct NewMenu * m;

    for (m = newmenu;  m->nm_Type != NM_END;  m++)
    {
	if (m->nm_Label  !=  NM_BARLABEL)
	    m->nm_Label = (STRPTR) GetLocaleString ((ULONG) m->nm_UserData);
    }
}

void SetHelpMenuState (struct graph * graph, UWORD item, BOOL val)
{
    struct MenuItem * menuitem = IIntuition->ItemAddress (graph->window->MenuStrip, SHIFTMENU(HELP_MENU)|SHIFTITEM(item));
    if (val)
	menuitem->Flags |= CHECKED;
    else
	menuitem->Flags &= ~CHECKED;
}

void switchMenu (struct graph * graph, UWORD item, BOOL state)
{
    if (state == TRUE)
	IIntuition->OnMenu (graph->window, SHIFTITEM(item));
    else
	IIntuition->OffMenu (graph->window, SHIFTITEM(item));
}

void alert (int title, CONST_STRPTR message)
{
    struct EasyStruct easy = {
	sizeof(struct EasyStruct), 0, 0, 0, 0
    };

    if (IntuitionBase)
    {
	easy.es_Title = GetLocaleString (title);
	easy.es_Flags = 0;
	easy.es_TextFormat = (STRPTR) message;
	easy.es_GadgetFormat = GetLocaleString (OK_STRING);
	IIntuition->EasyRequest (0, &easy, 0, 0);
    }
    else
	puts (message);
}

void error (int string_ID)
{
    alert (SUDOKU_ERROR_STRING, GetLocaleString (string_ID));
}

void lib_alert (char * lib, int ver)
{
    char m[256];

    sprintf (m, GetLocaleString (OPENING_LIBRARY_ERROR_STRING), lib, ver);
    alert (SUDOKU_ERROR_STRING, m);
}

struct Library * open_lib (char * libname, int version, struct Interface ** interface)
{
    struct Library * lib = IExec->OpenLibrary (libname, version);
    if (lib)
    {
	* interface = IExec->GetInterface (lib, "main", 1, 0);
	if (* interface)
	    return lib;
	IExec->CloseLibrary (lib);
    }
    return 0;
}

static BOOL open_libs (void)
{
    struct library * lib = libs;

    while (lib->lib)
	if (! (*lib->lib = open_lib (lib->libname, lib->version, lib->interface)))
	{
	    lib_alert (lib->libname, lib->version);
	    return 0;
	}
	else
	    lib++;
    catalog = ILocale->OpenCatalog (NULL, "AmiSudoku.catalog", OC_Version, CATALOG_VERSION, TAG_DONE);
    return 1;
}

static void close_libs (void)
{
    struct library * lib = libs;

    if (catalog)                        /* Don't remove ! (ILocale not always initialized) */
	ILocale->CloseCatalog (catalog);
    while (lib->lib)
    {
	IExec->DropInterface (* lib->interface);
	IExec->CloseLibrary (* lib->lib);
	lib++;
    }
}

/* Routines to display score (7 segments like vectorial drawing) *************/
/* Segment flags : 1 vertical, -1 horizontal, 0 nothing; for segments a, b, c, d, e, f, g respectively */
WORD segments [] =
{	-1, 1, 1,-1, 1, 1, 0,	/* 0 */
	 0, 1, 1, 0, 0, 0, 0,	/* 1 */
	-1, 1, 0,-1, 1, 0,-1,	/* 2 */
	-1, 1, 1,-1, 0, 0,-1,	/* 3 */
	 0, 1, 1, 0, 0, 1,-1,	/* 4 */
	-1, 0, 1,-1, 0, 1,-1,	/* 5 */
	-1, 0, 1,-1, 1, 1,-1,	/* 6 */
	-1, 1, 1, 0, 0, 0, 0,	/* 7 */
	-1, 1, 1,-1, 1, 1,-1,	/* 8 */
	-1, 1, 1,-1, 0, 1,-1	/* 9 */
};

WORD coords[] = 	/* Coordinates for each segment (x, y) */
{
	0, 0,		/* a */
	1, 0,		/* b */
	1, 1,		/* c */
	0, 2,		/* d */
	0, 1,		/* e */
	0, 0,		/* f */
	0, 1,		/* g */
};

void display_segment (struct graph * graph, WORD x, WORD y, WORD w, WORD h, int direction)
{
    WORD d = 2;

    IGraphics->SetAPen (graph->window->RPort, graph->colors[BLACK]);
    if (direction < 0)      /* horizontal */
	IGraphics->RectFill (graph->window->RPort, x, y - d, x + w, y + d);
    else		    /* vertical */
	IGraphics->RectFill (graph->window->RPort, x - d, y, x + d, y + h);
}
/*****************************************************************************/

// Sudoku cell class
class SudokuCell {
    BOOL    locked;
    int     value, test_value[9];

    void display_decimal_number (struct graph * g);

public:
    int x, y, size, color;
    Object * object;
    struct IBox * area;

    SudokuCell (int X, int Y);
    void init_cell (int cellsize);
    BOOL mouse_event (int x, int y);
    void draw (struct graph *);
    void draw (struct graph *, int color);
    void set_state (struct graph * g, BOOL r)
    {
	locked = r;
	if (r)
	    color = GRAY;
	else
	    color = WHITE;
	draw (g);
    }
    BOOL    is_locked (void) const { return locked; }
    void    init_test_values () { int i; for (i = 0;  i < 9;  i++) test_value[i] = 0; }
    void    set_test_value (int n, int v) { test_value[n] = v; }
    int     read_test_value (int n) const { return test_value[n]; }
    void    set_value (int v) { value = v; }
    int     read_value() const { return value; }
};

// Create a cell widget
SudokuCell::SudokuCell (int X, int Y)
{
    x = X;
    y = Y;
    value =0;
    color = WHITE;
    locked = 0;
}

// Must be called after cellsize has been defined (can be changed using prefs)
void SudokuCell::init_cell (int cellsize)
{
    object = (Object *) SpaceObject, SPACE_MinHeight, cellsize + 3, SPACE_MinWidth, cellsize + 3, SPACE_BevelStyle, BVS_GROUP, SpaceEnd;
    size = cellsize;
}

/* Check if mouse was pressed on a cell */
BOOL SudokuCell:: mouse_event (int x, int y)
{
    if (x >= area->Left  &&  x < area->Left + size)
	if (y >= area->Top  &&  y < area->Top + size)
	    return 1;
    return 0;
}

void SudokuCell::display_decimal_number (struct graph * g)
{
    WORD * segs = &segments[value * 7], * coord = coords;
    int s, segsize = size * 3 / 8, offset = (size - segsize) / 2;

    if (value >0  &&  value < 10)
	for (s = 0;  s < 7;  s++, segs++, coord += 2)
	    if (*segs)
		display_segment (g, area->Left + offset + * coord * segsize, area->Top + offset/3 + *(coord+1) * segsize , segsize, segsize ,*segs);
}

void SudokuCell::draw (struct graph * g)
{
    IGraphics->SetAPen (g->window->RPort, g->colors[color]);
    IGraphics->RectFill (g->window->RPort, area->Left, area->Top, area->Left + size - 3, area->Top + size - 3);
    display_decimal_number (g);
}

void SudokuCell::draw (struct graph * g, int c)
{
    color = c;
    draw (g);
}

// Sudoku game class
class Sudoku {
    enum {  PLAY = 0, EDIT_BOARD, GAME_FINISHED };	// Modes
    enum {  NORMAL = 0, EDITED	};			// Types

    /* Data and function to handle Undo menu */
    struct memo {   SudokuCell * cell;	int old_value;	} memo[9*9];
    int last_memo;	    // Pointer to previous array (-1 means no possible undo)
    void memo_undo (SudokuCell * cell);

    /* Data and functions to save and restore game */
    struct memo saved_memo[9*9];
    int saved_last_memo, saved_show_possible;
    SudokuCell * saved_cells[9][9], * saved_selection, * saved_test_cells[9];
    BOOL is_saved;
    void save_game_to_memory (void);

    Object * object;
    int cellsize, mode, type, level, show_possible;
    ULONG cellsizegadget;
    BOOL show_errors, autoupdate_help, quick_help;
    char title[100];

public:
    struct MsgPort * AppPort;	/* Used to be able to iconify the window */
    struct Screen * screen;
    struct graph graph;
    struct Hook hook;		/* Used to handle mouse buttons and keys */
    int MouseX, MouseY, event, esc, qualifier;
    time_t seed_;

private:
    char grid_values[9][9];
    SudokuCell * grid_cells[9][9], * selection;
    SudokuCell * test_cells[9];

    Object * horizontal_group (int x, int y);
    Object * group_creation (int x, int y);
    Object * create_requester ();
    void check_tooltypes ();
    void save_prefs (ULONG cellsizegadget);
    ULONG open_prefs_requester ();
    void busy_pointer (void);
    void normal_pointer (void);
    void display_message (int string);
    void close_window ();
    void RedrawGame ();
    void edit_game (void);
    void cancel_selection (void);
    SudokuCell * last_free_cell (SudokuCell * cell, int dx, int dy);
    SudokuCell * free_cell (SudokuCell * cell, int dx, int dy);
    void save_game (char * drawer, char * filename);
    void load_game (char * drawer, char * filename);
    BOOL check_game (int highlight);
    void restart_game (void);
    void convert (void);
    void solve_game (void);
    SudokuCell * suggest (void);
    void play_cell (SudokuCell * cell, int num);
    int play_next ();
    void change_state (SudokuCell * testcell);
    void fill_free_cells (int color);
    BOOL free_cells (void);
    void fill_test_cells (int color);
    void init_test_cells ();
    void draw_test_cells (SudokuCell * cell);
    void colorize_column (int column, int color);
    void check_column (SudokuCell * cell, BOOL draw);
    BOOL test_column (SudokuCell * cell, int num);
    int test_column (SudokuCell * cell);
    void colorize_line (int column, int color);
    void check_line (SudokuCell * cell, BOOL draw);
    BOOL test_line (SudokuCell * cell, int num);
    int test_line (SudokuCell * cell);
    void colorize_group (int column, int line, int color);
    void check_group (SudokuCell * cell, BOOL draw);
    BOOL test_group (SudokuCell * cell, int num);
    int test_group (SudokuCell * cell);
    void check_all (SudokuCell * cell, BOOL draw);
    BOOL test_all (SudokuCell * cell, int num);
    int possibilities (SudokuCell * cell, int * n);
    int possibility (SudokuCell * cell, int n);
    void update_tests ();
    void show_possible_cells (int code);
    void show_easy_cells (void);
    SudokuCell * mousePressEvent (int x, int y);

public:
    BOOL open_window();
    Sudoku();
    ~Sudoku();
    void handle_events (void);
    void load_file (char * filename);
    void new_game (time_t seed);
};

// Create a Sudoku game window...
Sudoku::Sudoku ()
{
    /* Colors used in the game to render cells, game area, and lines (RVB values) */
    ULONG color_levels[NCOLORS*3] = {
	/* Ball colors */
	0xFFFFFFFF, 0, 0,			/* RED */
	0, 0xCFFFFFFF, 0,			/* GREEN */
	0x8FFFFFFF, 0x8FFFFFFF, 0xFFFFFFFF,	/* BLUE (selection) */
	0, 0xBFFFFFFF, 0xFFFFFFFF,		/* LIGHT_BLUE (used for line test) */
	0xDFFFFFFF, 0xDFFFFFFF, 0,		/* YELLOW */
	0xAFFFFFFF, 0, 0xFFFFFFFF,		/* VIOLET (used for column test) */
	0x9FFFFFFF, 0x9FFFFFFF, 0x9FFFFFFF,	/* GRAY (locked cells) */
	/* Game area */
	0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,	/* WHITE (free cells) */
	0xAFFFFFFF, 0x6FFFFFFF, 0,		/* BROWN (used for group test) */
	/* Lines */
	0, 0, 0 				/* BLACK (numbers) */
    };
    int i, j;
    ULONG * color_level;
    SudokuCell * cell;

    level = 2;
    strcpy (title, AMISUDOKU_TXT);
    if (screen = IIntuition->LockPubScreen ("Workbench"))
    {
	show_errors = autoupdate_help = 0;
	object = 0;
	selection = 0;
	show_possible = 0;
	quick_help = 0;
	is_saved = 0;
	cellsizegadget = 4;
	last_memo = -1; 	    // No possible undo at beginning
	cellsize = 22 + cellsizegadget * 10;
	color_level = color_levels;
	for (i = 0;  i < NCOLORS;  i++)
	    graph.colors[i] = IGraphics->ObtainBestPen (screen->ViewPort.ColorMap, *color_level++, *color_level++, *color_level++, TAG_DONE);
	for (i = 0; i < 9; i ++)
	{
	    for (j = 0; j < 9; j ++)
	    {
		cell = new SudokuCell (i, j);
		grid_cells[i][j] = cell;
	    }
	}
	for (i = 0; i < 9; i ++)
	    test_cells[i] = new SudokuCell (-1, i);
	check_tooltypes ();
    }
};

// Destroy the sudoku window...
Sudoku::~Sudoku()
{
    int i, j;

    close_window ();
    IIntuition->UnlockPubScreen (NULL, screen);
    for (i = 0; i < 9; i ++)
	for (j = 0; j < 9; j ++)
	    delete grid_cells[i][j];
    for (i = 0; i < 9; i ++)
	delete test_cells[i];
    if (is_saved)
    {
	for (i = 0; i < 9; i ++)
	    for (j = 0; j < 9; j ++)
		delete saved_cells[i][j];
	for (i = 0; i < 9; i ++)
	    delete saved_test_cells[i];
    }
}

Object * Sudoku::horizontal_group (int x, int y)
{
    return (Object *) HGroupObject,
	LAYOUT_SpaceOuter, TRUE,
	LAYOUT_SpaceInner, TRUE,
	LAYOUT_AddChild, grid_cells[x][y]->object,
	LAYOUT_AddChild, grid_cells[x+1][y]->object,
	LAYOUT_AddChild, grid_cells[x+2][y]->object,
    LayoutEnd;
}

Object * Sudoku::group_creation (int x, int y)
{
    return (Object *) VGroupObject,
	LAYOUT_BevelStyle, BVS_GROUP,
	LAYOUT_SpaceOuter, TRUE,
	LAYOUT_SpaceInner, TRUE,
	LAYOUT_AddChild, horizontal_group (x,y),
	LAYOUT_AddChild, horizontal_group (x,y+1),
	LAYOUT_AddChild, horizontal_group (x,y+2),
    LayoutEnd;
}

/* Reaction Gadgets ID used in requesters */
enum { GADGET_LEVEL=1, GADGET_OK, GADGET_NO, GADGET_SIZE, GADGET_SAVE
};

int handle_request (Object * object)
{
    ULONG signal, end = FALSE, result;
    int code = -1, code2;

    IIntuition->GetAttr (WINDOW_SigMask, object, &signal);
    while (! end)
    {
	IExec->Wait (signal);
	while ((result = RA_HandleInput (object, &code2))  !=  WMHI_LASTMSG)
	{
	    switch (result & WMHI_CLASSMASK)
	    {
		    case WMHI_CLOSEWINDOW:
			end = TRUE;
			code = -1;
			break;

		    case WMHI_GADGETUP:
			code = result & WMHI_GADGETMASK;
			end = TRUE;
			break;

		    case WMHI_RAWKEY:
			code = result & WMHI_KEYMASK;
			if (code == 0x43  ||  code == 0x44)     /* ENTER or RETURN */
			{
			    end = TRUE;
			    code = GADGET_OK;
			}
			else if (code == 0x45)                 /* ESC */
			{
			    end = TRUE;
			    code = -1;
			}
			break;
	    }
	}
    }
    return code;
}

Object * locale_button (int id, int locale)
{
    return (Object *) ButtonObject,
	    GA_ID, id,
	    GA_RelVerify, TRUE,
	    GA_Text, GetLocaleString (locale),
	    BUTTON_SoftStyle, id == GADGET_OK ? FSF_BOLD : 0,
    ButtonEnd;
}

Object * number_gadget (int n, int id)
{
    return (Object *) IntegerObject,
	INTEGER_Number, n,
	GA_RelVerify,	TRUE,
	GA_ID,		id,
	GA_TabCycle,	TRUE,
	STRINGA_Justification, GACT_STRINGCENTER,
	INTEGER_Arrows, TRUE,
    IntegerEnd;
}

void get_number (Object * gadget, ULONG * val)
{
    IIntuition->GetAttr (INTEGER_Number, gadget, val);
}

void set_number (Object * gadget, struct Window * w, int n)
{
    IIntuition->SetGadgetAttrs ((struct Gadget *) gadget, w, NULL, INTEGER_Number, n, TAG_DONE);
}

Object * label_object (int id)
{
    return (Object *) LabelObject, LABEL_Text, GetLocaleString (id), LabelEnd;
}

Object * cycle_object (int id, int selected, char ** labels)
{
    return (Object *) ChooserObject, GA_ID, id, GA_RelVerify, TRUE, CHOOSER_AutoFit, TRUE, CHOOSER_Selected, selected, CHOOSER_Justification, CHJ_CENTER, CHOOSER_LabelArray, labels, ChooserEnd;
}

void get_cycle (Object * object, ULONG * val)
{
    IIntuition->GetAttr (CHOOSER_Selected, object, val);
}

void Sudoku::save_prefs (ULONG cellsizegadget)
{
    struct DiskObject * dobj;
    char levelstring[10], cellsizestring[12];
    STRPTR *  old_tooltypes, tooltypes[3];

    if (dobj = IIcon->GetDiskObject ("AmiSudoku"))
    {
	old_tooltypes = dobj->do_ToolTypes;
	dobj->do_ToolTypes = tooltypes;
	tooltypes[0] = levelstring;
	sprintf (levelstring, "LEVEL=%ld", level);
	tooltypes[1] = cellsizestring;
	sprintf (cellsizestring, "CELLSIZE=%ld", cellsizegadget);
	tooltypes[2] = 0;
	if (IIcon->PutDiskObject ("AmiSudoku", dobj) == FALSE)
	    error (SAVING_PREFS_ERROR_STRING);
	dobj->do_ToolTypes = old_tooltypes;
	IIcon->FreeDiskObject (dobj);
    }
    else
	error (SAVING_DISKOBJECT_ERROR_STRING);
}

ULONG Sudoku::open_prefs_requester ()
{
    int end = FALSE, newlevel = level, code;
    ULONG newcellsizegadget = cellsizegadget;
    Object * o, * level_gadget, * cellsize_gadget;
    struct Window * w;
    char * cellsize_labels[CELLSIZE_MAX + 2];

    IIntuition->SetAttrs (object, WA_BusyPointer, TRUE, TAG_END);
    cellsize_labels[0] = GetLocaleString(VERY_SMALL_SIZE_STRING);
    cellsize_labels[1] = GetLocaleString(SMALL_SIZE_STRING);
    cellsize_labels[2] = GetLocaleString(MEDIUM_SIZE_STRING);
    cellsize_labels[3] = GetLocaleString(LARGE_SIZE_STRING);
    cellsize_labels[4] = GetLocaleString(VERY_LARGE_SIZE_STRING);
    cellsize_labels[5] = GetLocaleString(SUPER_LARGE_SIZE_STRING);
    cellsize_labels[CELLSIZE_MAX + 1] = 0;
    o = (Object *) WindowObject,
	WA_ScreenTitle, AMISUDOKU_TXT,
	WA_Title, GetLocaleString (SUDOKU_PREFS_STRING),
	WA_Activate, TRUE,
	WA_DepthGadget, TRUE,
	WA_DragBar, TRUE,
	WA_PubScreen, screen,
	WA_CloseGadget, TRUE,
	WA_RMBTrap, TRUE,
	WA_IDCMP, IDCMP_MOUSEBUTTONS | IDCMP_CLOSEWINDOW | IDCMP_GADGETUP | IDCMP_RAWKEY,
	WINDOW_RefWindow, graph.window,
	WINDOW_Position,  WPOS_CENTERSCREEN,
	WINDOW_ParentGroup, VGroupObject,
	    LAYOUT_AddChild, level_gadget = number_gadget (level, GADGET_LEVEL),
	    CHILD_Label, label_object (LEVEL_STRING),
	    LAYOUT_AddChild, cellsize_gadget = cycle_object (GADGET_SIZE, newcellsizegadget, cellsize_labels),
	    CHILD_Label, label_object (CELL_SIZE_STRING),
	    LAYOUT_AddChild, HGroupObject,
		LAYOUT_BevelStyle, BVS_GROUP,
		LAYOUT_AddChild, locale_button (GADGET_SAVE, SAVE_STRING),
		LAYOUT_AddChild, locale_button (GADGET_OK, USE_STRING),
		LAYOUT_AddChild, locale_button (GADGET_NO, CANCEL_STRING),
	    LayoutEnd,
	LayoutEnd,
    EndWindow;
    if (o)
    {
	if (w = (struct Window *) RA_OpenWindow (o))
	{
	    do
	    {
		code = handle_request (o);
		switch (code)
		{
		    case GADGET_LEVEL:
			get_number (level_gadget, (ULONG *) &newlevel);
			newlevel = newlevel;
			if (newlevel < LEVEL_MIN  ||  newlevel > LEVEL_MAX)
			{
			    newlevel = (newlevel < LEVEL_MIN ? LEVEL_MIN : LEVEL_MAX);
			    set_number (level_gadget, w, newlevel);
			    IIntuition->DisplayBeep (0);
			}
			break;

		    case GADGET_OK:
			level = newlevel;
			get_cycle (cellsize_gadget, &newcellsizegadget);
			end = TRUE;
			break;

		    case GADGET_SAVE:
			level = newlevel;
			newcellsizegadget = cellsizegadget;
			get_cycle (cellsize_gadget, &cellsizegadget);
			save_prefs (cellsizegadget);
			cellsizegadget = newcellsizegadget;
			get_cycle (cellsize_gadget, &newcellsizegadget);
			end = TRUE;
			break;

		    case GADGET_NO:
		    case -1:		/* CLOSEWINDOW */
			cellsizegadget = newcellsizegadget;
			end = TRUE;
			break;
		}
	    }
	    while (end == FALSE);
	}
	else
	    error (OPENREQUESTER_ERROR_STRING);
	IIntuition->DisposeObject (o);
    }
    else
	error (ALLOCATION_REQUESTER_ERROR_STRING);
    IIntuition->SetAttrs (object, WA_BusyPointer, FALSE, TAG_END);
    return newcellsizegadget;
}

ULONG IDCMP_func (struct Hook * hookPtr, struct SGWork *obj, struct IntuiMessage * message)
{
    Sudoku * game = (Sudoku *) hookPtr->h_Data;

    if (message->Class == IDCMP_MOUSEBUTTONS)
	switch (message->Code)
	{
	    case SELECTDOWN:
	    case MIDDLEDOWN:
		game->event = message->Code;
		game->MouseX = message->MouseX;
		game->MouseY = message->MouseY;
		break;

	    default:
		game->event = 0;
		break;
	}
    else if (message->Class == IDCMP_RAWKEY)
	game->qualifier = message->Qualifier;
    return TRUE;
}

/* Creation of the game window */
Object * Sudoku:: create_requester ()
{
    int i, j;

    for (i = 0;  i < 9;  i++)
	for (j = 0;  j < 9;  j++)
	    grid_cells[i][j]->init_cell (cellsize);
    for (i = 0; i < 9; i ++)
	test_cells[i]->init_cell (cellsize);

    Object * o = (Object *) WindowObject,
	WA_ScreenTitle, AMISUDOKU_TXT,
	WA_Title, title,
	WA_Activate, TRUE,
	WA_DepthGadget, TRUE,
	WA_DragBar, TRUE,
	WA_NewLookMenus, TRUE,
	WINDOW_NewMenu, newmenu,
	WA_PubScreen, screen,
	WA_CloseGadget, TRUE,
	WA_IDCMP, IDCMP_MOUSEBUTTONS | IDCMP_CLOSEWINDOW | IDCMP_VANILLAKEY | IDCMP_RAWKEY | IDCMP_MENUPICK,	   // IDCMP_IDCMPUPDATE |
	WINDOW_IDCMPHook, &hook,
	WINDOW_IDCMPHookBits, IDCMP_MOUSEBUTTONS | IDCMP_RAWKEY,
	WINDOW_IconifyGadget, TRUE,
	WINDOW_IconTitle, "AmiSudoku",
	WINDOW_AppPort, AppPort,
	WINDOW_Position, WPOS_CENTERSCREEN,
	WINDOW_ParentGroup, HGroupObject,
	    LAYOUT_AddChild, VGroupObject,
		LAYOUT_AddChild, HGroupObject,
		    LAYOUT_SpaceOuter, TRUE,
		    LAYOUT_SpaceInner, TRUE,
		    LAYOUT_AddChild, group_creation(0,0),
		    LAYOUT_AddChild, group_creation(3,0),
		    LAYOUT_AddChild, group_creation(6,0),
		LayoutEnd,
		LAYOUT_AddChild, HGroupObject,
		    LAYOUT_SpaceOuter, TRUE,
		    LAYOUT_SpaceInner, TRUE,
		    LAYOUT_AddChild, group_creation(0,3),
		    LAYOUT_AddChild, group_creation(3,3),
		    LAYOUT_AddChild, group_creation(6,3),
		LayoutEnd,
		LAYOUT_AddChild, HGroupObject,
		    LAYOUT_SpaceOuter, TRUE,
		    LAYOUT_SpaceInner, TRUE,
		    LAYOUT_AddChild, group_creation(0,6),
		    LAYOUT_AddChild, group_creation(3,6),
		    LAYOUT_AddChild, group_creation(6,6),
		LayoutEnd,
		CHILD_WeightedWidth, 0,
		// LAYOUT_EvenSize, TRUE,
	    LayoutEnd,
	    CHILD_WeightedHeight, 0,
	    LAYOUT_AddChild, VGroupObject,
		LAYOUT_BevelStyle, BVS_GROUP,
		LAYOUT_SpaceOuter, TRUE,
		LAYOUT_SpaceInner, TRUE,
		LAYOUT_AddChild, test_cells[0]->object,
		LAYOUT_AddChild, test_cells[1]->object,
		LAYOUT_AddChild, test_cells[2]->object,
		LAYOUT_AddChild, test_cells[3]->object,
		LAYOUT_AddChild, test_cells[4]->object,
		LAYOUT_AddChild, test_cells[5]->object,
		LAYOUT_AddChild, test_cells[6]->object,
		LAYOUT_AddChild, test_cells[7]->object,
		LAYOUT_AddChild, test_cells[8]->object,
	    LayoutEnd,
	    CHILD_WeightedHeight, 0,
	LayoutEnd,
    EndWindow;
    return o;
}

BOOL Sudoku:: open_window ()
{
    int i, j;

    if (object == 0)
	object = create_requester ();
    if (object)
    {
	if (graph.window = (struct Window *) RA_OpenWindow (object))
	{
	    for (i = 0;  i < 9;  i++)
	    {
		for (j = 0;  j < 9;  j++)
		    IIntuition->GetAttr (SPACE_AreaBox, grid_cells[i][j]->object, (ULONG *) &grid_cells[i][j]->area);
	    }
	    for (i = 0;  i < 9;  i++)
	    {
		IIntuition->GetAttr (SPACE_AreaBox, test_cells[i]->object, (ULONG *) &test_cells[i]->area);
		test_cells[i]->set_value (i + 1);
	    }
	    RedrawGame ();
	    SetHelpMenuState (&graph, AUTOUPDATE_HELP_MENU, autoupdate_help);
	    SetHelpMenuState (&graph, QUICK_HELP_MENU, quick_help);
	    SetHelpMenuState (&graph, SHOWERRORS_MENU, show_errors);
	    return TRUE;
	}
	else
	    error (OPENREQUESTER_ERROR_STRING);
    }
    return FALSE;
}

void Sudoku::cancel_selection (void)
{
    if (selection)
    {
	selection->draw (&graph, WHITE);
	selection = 0;
	init_test_cells ();
    }
}

void Sudoku:: RedrawGame ()
{
    int x, y;
    SudokuCell * cell;

    for (x = 0;  x < 9;  x++)
    {
	for (y = 0;  y < 9;  y++)
	{
	    cell = grid_cells[x][y];
	    cell->draw (&graph);
	}
    }
    if (selection == 0)
	init_test_cells ();
}

void Sudoku::busy_pointer (void)
{
    if (object)
	IIntuition->SetAttrs (object, WA_BusyPointer, TRUE, TAG_END);
}

void Sudoku::normal_pointer (void)
{
    if (object)
	IIntuition->SetAttrs (object, WA_BusyPointer, FALSE, TAG_END);
}

void Sudoku::display_message (int string)
{
    busy_pointer ();
    alert (AMISUDOKU_MESSAGE_STRING, GetLocaleString(string));
    normal_pointer ();
}

void Sudoku:: close_window ()
{
    IIntuition->DisposeObject (object);
    graph.window = 0;
    object = 0;
}

void Sudoku::restart_game ()
{
    int i, j;
    SudokuCell * cell;

    for (i = 0;  i < 9;  i++)
    {
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->is_locked ())
		continue;
	    cell->set_value (0);
	    cell->draw (&graph, WHITE);
	    cell->init_test_values();
	}
    }
    last_memo = -1;
    switchMenu (&graph, UNDO_MENU, FALSE);
    if (selection)
	selection->draw (&graph, BLUE);
    if (mode == GAME_FINISHED)
	mode = PLAY;
    switchMenu (&graph, SOLVE_MENU, TRUE);
}

/* Initialize all the cells for editing */
void Sudoku::edit_game ()
{
    int i, j;
    SudokuCell * cell;

    for (i = 0;  i < 9;  i++)
    {
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->is_locked ())
		cell->set_state (&graph, 0);
	    cell->draw (&graph, WHITE);
	}
    }
    selection = 0;
    mode = EDIT_BOARD;
    init_test_cells ();
    last_memo = -1;
    sprintf (title, "%s - %s", AMISUDOKU_TXT, GetLocaleString (EDITED_GAME_STRING));
    IIntuition->SetWindowTitles (graph.window, GetLocaleString (EDITING_GAME_STRING), AMISUDOKU_TXT);
    switchMenu (&graph, SOLVE_MENU, FALSE);
    switchMenu (&graph, EDITGAME_MENU, FALSE);
    switchMenu (&graph, SAVE_MENU, FALSE);
    switchMenu (&graph, RESTORE_MENU, FALSE);
}

/* Convert edited values to a playing game */
void Sudoku::convert ()
{
    int i, j;
    SudokuCell * cell;

    cancel_selection ();
    for (i = 0;  i < 9;  i++)
    {
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->read_value ())
		cell->set_state (&graph, 1);
	    cell->init_test_values ();
	}
    }
    mode = PLAY;
    type = EDITED;
    IIntuition->SetWindowTitles (graph.window, title, AMISUDOKU_TXT);
    switchMenu (&graph, SOLVE_MENU, TRUE);
    switchMenu (&graph, EDITGAME_MENU, TRUE);
    switchMenu (&graph, SAVE_MENU, TRUE);
}

// Create a new game (based on Michael R Sweet routine)...
void Sudoku::new_game (time_t seed)
{
    int i, j, k, m, t, count;

    // Generate a new (valid) Sudoku grid...
    seed_ = seed;
    srand (seed);

    memset (grid_values, 0, sizeof(grid_values));

    for (i = 0; i < 9; i += 3)
    {
	for (j = 0; j < 9; j += 3)
	{
	    for (t = 1; t <= 9; t ++)
	    {
		for (count = 0;  count < 20;  count ++)
		{
		    k = i + (rand() % 3);
		    m = j + (rand() % 3);
		    if (!grid_values[k][m])
		    {
			int kk;

			for (kk = 0; kk < k; kk ++)
			    if (grid_values[kk][m] == t)
				break;

			if (kk < k) continue;

			int mm;

			for (mm = 0; mm < m; mm ++)
			    if (grid_values[k][mm] == t)
				break;

			if (mm < m) continue;

			grid_values[k][m] = t;
			break;
		    }
		}
		if (count == 20)
		{
		    // Unable to find a valid puzzle so far, so start over...
		    j = 9;
		    i = -3;
		    memset (grid_values, 0, sizeof(grid_values));
		}
	    }
	}
    }
    // Start by making all cells editable
    SudokuCell * cell;

    for (i = 0; i < 9; i ++)
	for (j = 0; j < 9; j ++)
	{
	    cell = grid_cells[i][j];

	    cell->set_value(0);
	    cell->set_state (&graph, 0);
	    cell->init_test_values ();
	}

    // Show N cells...
    count = 10 * (6 - level);
    sprintf (title, "%s - %s %ld", AMISUDOKU_TXT, GetLocaleString(LEVEL_STRING), level);

    int numbers[9];

    for (i = 0; i < 9; i ++)
	numbers[i] = i + 1;

    while (count > 0)
    {
	for (i = 0;  i < 20;  i ++)
	{
	    k	       = rand() % 9;
	    m	       = rand() % 9;
	    t	       = numbers[k];
	    numbers[k] = numbers[m];
	    numbers[m] = t;
	}
	for (i = 0; count > 0  &&  i < 9;  i++)
	{
	    t = numbers[i];

	    for (j = 0;  count > 0  &&  j < 9;  j++)
	    {
		cell = grid_cells[i][j];

		if (grid_values[i][j] == t  &&  !cell->is_locked())
		{
		    cell->set_value(grid_values[i][j]);
		    cell->set_state (&graph, 1);
		    count --;
		    break;
		}
	    }
	}
    }
    mode = PLAY;
    type = NORMAL;
    IIntuition->SetWindowTitles (graph.window, title, AMISUDOKU_TXT);
    switchMenu (&graph, SOLVE_MENU, TRUE);
    switchMenu (&graph, EDITGAME_MENU, TRUE);
    switchMenu (&graph, RESTORE_MENU, FALSE);
}

void Sudoku::draw_test_cells (SudokuCell * cell)
{
    int i, v;

    for (i = 0;  i < 9;  i++)
    {
	v = cell->read_test_value(i);
	test_cells[i]->draw (&graph, v == -1 ? RED : v== 1 ? GREEN : WHITE);
    }
    show_possible = 0;
}

void Sudoku::fill_test_cells (int color)
{
    int i;

    for (i = 0;  i < 9;  i++)
	test_cells[i]->draw (&graph, color);
}

void Sudoku::init_test_cells ()
{
    fill_test_cells (WHITE);
}

void Sudoku::colorize_column (int column, int color)
{
    int line;
    SudokuCell * cell;

    for (line = 0;  line < 9;  line++)
    {
	cell = grid_cells[column][line];
	if (cell->read_value())
	    continue;
	cell->draw (&graph, color);
    }
    show_possible = -2;
}

void Sudoku::check_column (SudokuCell * cell, BOOL draw)
{
    int x = cell->x, y, v;
    SudokuCell * test, * c;

    for (y = 0;  y < 9;  y++)
    {
	c = grid_cells[x][y];
	if (c == cell)
	    continue;
	v = c->read_value();
	if (v > 0)
	    cell->set_test_value(v-1, -1);
	if (draw)
	{
	    test = test_cells[v-1];
	    test->draw (&graph, v == -1 ? RED : WHITE);
	}
    }
}

/* Return 1 if the num can fit in the column */
BOOL Sudoku::test_column (SudokuCell * cell, int num)
{
    int x = cell->x, y, v;
    SudokuCell * test, * c;

    for (y = 0;  y < 9;  y++)       // Check each line of the column
    {
	c = grid_cells[x][y];
	if (c == cell)
	    continue;
	if (c->read_value() == num)
	    return 0;
    }
    return 1;
}

void Sudoku::colorize_line (int line, int color)
{
    int col;
    SudokuCell * cell;

    for (col = 0;  col < 9;  col++)
    {
	cell = grid_cells[col][line];
	if (cell->read_value())
	    continue;
	cell->draw (&graph, color);
    }
    show_possible = -2;
}

void Sudoku::check_line (SudokuCell * cell, BOOL draw)
{
    int i, x, y = cell->y, v;
    SudokuCell * test, * l;

    for (x = 0;  x < 9;  x++)
    {
	l = grid_cells[x][y];
	if (l == cell)
	    continue;
	v = l->read_value();
	if (v > 0)
	    cell->set_test_value(v-1, -1);
	if (draw)
	{
	    test = test_cells[v-1];
	    test->draw (&graph, v == -1 ? RED : WHITE);
	}
    }
}

/* Return 1 if the num can fit in the line */
BOOL Sudoku::test_line (SudokuCell * cell, int num)
{
    int x, y = cell->y, v;
    SudokuCell * test, * l;

    for (x = 0;  x < 9;  x++)       // Check each line of the line
    {
	l = grid_cells[x][y];
	if (l == cell)
	    continue;
	if (l->read_value() == num)
	    return 0;
    }
    return 1;
}

void Sudoku::colorize_group (int col, int line, int color)
{
    int x, y;
    SudokuCell * cell;

    for (x = 0;  x < 3;  x++)
    {
	for (y = 0;  y < 3;  y++)
	{
	    cell = grid_cells[col + x][line + y];
	    if (cell->read_value())
		continue;
	    cell->draw (&graph, color);
	}
    }
    show_possible = -2;
}

/* Set test values checking the cell group */
void Sudoku::check_group (SudokuCell * cell, BOOL draw)
{
    int i, j, x, y, v;
    SudokuCell * test, * cellgroup;

    x = cell->x < 3 ? 0 : cell->x > 5 ? 6 : 3;
    y = cell->y < 3 ? 0 : cell->y > 5 ? 6 : 3;
    for (i = 0;  i < 3;  i++)
	for (j = 0;  j < 3;  j++)
	{
	    cellgroup = grid_cells[x+i][y+j];
	    if (cellgroup == cell)
		continue;
	    v = cellgroup->read_value();
	    if (v > 0)                          // This number can't be played in this cell
		cell->set_test_value(v-1, -1);
	    if (draw)
	    {
		test = test_cells[v-1];
		test->draw (&graph, v == -1 ? RED : WHITE);
	    }
	}
}

/* Return 1 if the num can fit in the group */
BOOL Sudoku::test_group (SudokuCell * cell, int num)
{
    int i, j, x, y, v;
    SudokuCell * cellgroup;

    x = cell->x < 3 ? 0 : cell->x > 5 ? 6 : 3;
    y = cell->y < 3 ? 0 : cell->y > 5 ? 6 : 3;
    for (i = 0;  i < 3;  i++)
	for (j = 0;  j < 3;  j++)
	{
	    cellgroup = grid_cells[x+i][y+j];
	    if (cellgroup == cell)
		continue;
	    if (cellgroup->read_value() == num)
		return 0;
	}
    return 1;
}

void Sudoku::check_all (SudokuCell * cell, BOOL draw)
{
    check_column (cell, draw);
    check_line (cell, draw);
    check_group (cell, draw);
}

/* Return 1 if the num can fit in the cell checking all rules (line, column, group) */
BOOL Sudoku::test_all (SudokuCell * cell, int num)
{
    if (test_group (cell, num))
	if (test_line (cell, num))
	    return test_column (cell, num);
    return 0;
}

/* Count the number of possible values in a free cell */
int Sudoku::possibilities (SudokuCell * cell, int * n)
{
    int number, possible = 0;

    for (number = 1;  number < 10;  number++)
	if (test_all (cell, number))
	{
	    * n = number;	// Keep a trace of the last number
	    possible++;
	}
    return possible;
}

/* Return the number of order n that can be played in the cell */
int Sudoku::possibility (SudokuCell * cell, int n)
{
    int number;

    for (number = 1;  number < 10;  number++)
	if (test_all (cell, number))
	    if (--n <= 0)
		return number;
    return 0;
}

// Highlight free cells where playing specified num is possible
// If num equal 0 erase all free cells (WHITE)
void Sudoku::show_possible_cells (int num)
{
    int i, j;
    SudokuCell * cell;

    cancel_selection ();
    for (i = 0;  i < 9;  i++)
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->is_locked())
		continue;
	    if (cell->read_value())
	    {
		if (num > 9  ||  num < 1)
		    if (cell->color != WHITE)
			cell->draw (&graph, WHITE);
		continue;
	    }
	    if (num > 9  ||  num < 1)               // Erase cells
		cell->draw (&graph, WHITE);
	    else if (test_all (cell, num))          // Highlight cell if playing num is possible
		cell->draw (&graph, GREEN);
	    else
		cell->draw (&graph, WHITE);
	}
    init_test_cells ();
    if (num > 0  &&  num < 10)
    {
	test_cells[num-1]->draw (&graph, BLUE);
	show_possible = num;
    }
    else
	show_possible = 0;
}

// Calculate if any of the values between 1 and 9 can fit on the column only one time
int Sudoku::test_column (SudokuCell * cell)
{
    int y, num, p, col = cell->x;
    SudokuCell * linecell;

    for (num = 1;  num <= 9;  num++)
    {
	if (test_all (cell, num))
	{
	    p = 0;
	    for (y = 0;  y < 9;  y++)
	    {
		linecell = grid_cells[col][y];
		if (linecell->read_value())
		    continue;
		if (test_all (linecell, num))
		    p++;
	    }
	    if (p == 1)
		return num;
	}
    }
    return 0;
}

// Calculate if any of the values between 1 and 9 can fit on the line only one time
int Sudoku::test_line (SudokuCell * cell)
{
    int col, num, p, y = cell->y;
    SudokuCell * l;

    for (num = 1;  num <= 9;  num++)
    {
	if (test_all (cell, num))
	{
	    p = 0;
	    for (col = 0;  col < 9;  col++)
	    {
		l = grid_cells[col][y];
		if (l->read_value())
		    continue;
		if (test_all (l, num))
		    p++;
	    }
	    if (p == 1)
		return num;
	}
    }
    return 0;
}

// Calculate if the cell group can have a value in this cell only
int Sudoku::test_group (SudokuCell * cell)
{
    int i, j, num, p, x, y, v;
    SudokuCell * g;

    x = cell->x < 3 ? 0 : cell->x > 5 ? 6 : 3;
    y = cell->y < 3 ? 0 : cell->y > 5 ? 6 : 3;
    for (num = 1;  num <= 9;  num++)
    {
	if (test_all (cell, num))
	{
	    p = 0;
	    for (i = 0;  i < 3;  i++)
		for (j = 0;  j < 3;  j++)
		{
		    g = grid_cells[x+i][y+j];
		    if (g->read_value())
			continue;
		    if (test_all (g, num))
			p++;
		}
	    if (p == 1)
		return num;
	}
    }
    return 0;
}

void Sudoku::show_easy_cells (void)
{
    int i, j, k, solutions = 1, cells = 0, num, color;
    SudokuCell * cell;

    if (mode == GAME_FINISHED)
	return;
    if (show_possible)
	show_possible_cells (0);
    cancel_selection ();
    do
    {
	for (i = 0;  i < 9;  i++)
	    for (j = 0;  j < 9;  j++)
	    {
		cell = grid_cells[i][j];
		if (cell->read_value())
		    continue;
		if (possibilities (cell, &k) == solutions)
		{
		    if (solutions > 1)
			if (cell->color != WHITE)
			    continue;
		    cell->draw (&graph, YELLOW);
		    cells++;
		}
		else if (solutions == 1)
		{
		    color = LIGHT_BLUE;
		    num = test_line (cell);
		    if (num == 0)
		    {
			color = VIOLET;
			num = test_column (cell);
			if (num == 0)
			{
			    color = BROWN;
			    num = test_group (cell);
			}
		    }
		    if (num)
		    {
			cell->draw (&graph, color);
			// cells++;
		    }
		}
	    }
	if (cells == 0)
	    solutions++;
	if (solutions > 9)
	    break;
    }
    while (cells == 0);
    if (solutions > 0  &&  solutions < 10)
	test_cells[solutions-1]->draw (&graph, YELLOW);
    // printf("%ld %ld\n", solutions, cells);
    show_possible = -1;
}

void Sudoku::change_state (SudokuCell * testcell)
{
    int num = testcell->read_value();
    int val = selection->read_test_value (num - 1);
    val--;		// Change state of the test cell (0:WHITE, -1:RED, 1:GREEN alternatively)
    if (val == -2)
	val = 1;
    selection->set_test_value (num - 1, val);
    testcell->draw (&graph, val == -1 ? RED : val == 1 ? GREEN : WHITE);
}

// Calculate all test values for each cell of the grid after initializing them
void Sudoku::update_tests ()
{
    int i, j;
    SudokuCell * cell;

    for (i = 0;  i < 9;  i++)
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->is_locked() == 0)
	    {
		cell->init_test_values();
		check_all (cell, 0);
	    }
	}
}

// Mouse events handler
SudokuCell * Sudoku:: mousePressEvent (int xm, int ym)
{
    int color, x, y, i;
    SudokuCell * cell;

    if (mode == GAME_FINISHED)
	return 0;
    for (x = 0;  x < 9;  x++)       // Check for clicks on the test cells (right column)
    {
	cell = test_cells[x];
	if (cell->mouse_event (xm, ym))
	{
	    if (show_possible > 0)
	    {
		i = cell->read_value();
		show_possible_cells (i);
		return 0;
	    }
	    if (selection)
	    {
		if (event == SELECTDOWN  &&  mode != EDIT_BOARD)
		    change_state (cell);
		else if (event == MIDDLEDOWN  ||  event == SELECTDOWN)
		    play_cell (selection, cell->read_value());
	    }
	    return selection;
	}
    }
    for (x = 0;  x < 9;  x++)       // Check for clicks on the grid cells
    {
	for (y = 0;  y < 9;  y++)
	{
	    cell = grid_cells[x][y];
	    if (cell->mouse_event (xm, ym))
	    {
		if (cell->is_locked())
		{
		    if (quick_help)
		    {
			if (event == MIDDLEDOWN)
			    show_possible_cells (0);
			else if (event == SELECTDOWN)
			    show_possible_cells (cell->read_value());
		    }
		    return 0;
		}
		if (event == MIDDLEDOWN)
		{
		    if (show_possible > 0)
		    {
			play_cell (cell, show_possible);
			return cell;
		    }
		    play_cell (cell, 0);
		}
		return cell;
	    }
	}
    }
    return 0;
}

void Sudoku::fill_free_cells (int color)
{
    int i, j;
    SudokuCell * cell;

    for (i = 0;  i < 9;  i++)
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->read_value())
		continue;
	    cell->color = color;
	}
}

/* Return 1 if there is one or more free cell on the grid */
BOOL Sudoku::free_cells (void)
{
    int i, j;
    SudokuCell * cell;

    for (i = 0;  i < 9;  i++)
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->read_value() == 0)
		return 1;
	}
    return 0;
}

/* Recursive routine (attempt to fill all the puzzle) */
/* Return 1 if success, 0 else */
/* This routine stops when the first solution is found */
int Sudoku::play_next ()
{
    int i, j, num, solutions, value[9][9], m, l, k;
    SudokuCell * cell, * c;
    struct Message * message;

    message = IExec->GetMsg (graph.window->UserPort);
    if (message)
    {
	if (((struct IntuiMessage *) message)->Class == IDCMP_CLOSEWINDOW)
	    esc = 1;
	else if (((struct IntuiMessage *) message)->Class == IDCMP_RAWKEY)
	    if (((struct IntuiMessage *) message)->Code == 0x45)
		esc = 1;
	IExec->ReplyMsg (message);
    }
    if (esc)
    {
	#ifdef DEBUG_PLAY
	puts("Esc interrupt");
	#endif
	return 0;
    }

    if (mode == GAME_FINISHED)
    {
	#ifdef DEBUG_PLAY
	puts("Game finished");
	#endif
	return 1;
    }
    if (free_cells() == 0)
    {
	#ifdef DEBUG_PLAY
	puts("No free cell");
	#endif
	mode = GAME_FINISHED;
	return 1;
    }
    /* Look for an easy play (only one value possible in a cell) */
    for (i = 0;  i < 9;  i++)
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->read_value())
		continue;
	    k = possibilities (cell, &num);
	    if (k == 1)
	    {
		cell->set_value (num);
		#ifdef DEBUG_PLAY
		printf ("Play %ld %ld - %ld (1)\n", i, j, num);
		#endif
		return play_next();
	    }
	    else if (k == 0)        // This cell can't get any value, the game can't be solved
		return 0;
	    num = test_line (cell);
	    if (num == 0)
	    {
		num = test_column (cell);
		if (num == 0)
		    num = test_group (cell);
	    }
	    if (num)
	    {
		cell->set_value (num);
		#ifdef DEBUG_PLAY
		printf ("Play %ld %ld - %ld (x)\n", i, j, num);
		#endif
		return play_next();
	    }
	}
    /* No easy play, try different solutions */
    solutions = 2;
    do
    {
	for (i = 0;  i < 9;  i++)
	    for (j = 0;  j < 9;  j++)
	    {
		cell = grid_cells[i][j];
		if (cell->read_value())
		    continue;
		if (possibilities (cell, &k) == solutions)
		{
		    /* Save current state of the game in the stack */
		    for (m = 0;  m < 9;  m++)
			for (l = 0;  l < 9;  l++)
			{
			    c = grid_cells[m][l];
			    value[m][l] = c->read_value();
			}
		    for (num = solutions;  1;  )
		    {
			cell->set_value (k);
			#ifdef DEBUG_PLAY
			printf ("Trying to play %ld %ld - %ld (%ld)\n", i, j, k, num);
			#endif
			if (play_next ())
			    return 1;
			/* Restore original values */
			for (m = 0;  m < 9;  m++)
			    for (l = 0;  l < 9;  l++)
			    {
				c = grid_cells[m][l];
				c->set_value (value[m][l]);
			    }
			if (--num > 0)
			    k = possibility (cell, num);
			else
			    break;
		    }
		}
	    }
	solutions++;
    }
    while (solutions < 9);
    #ifdef DEBUG_PLAY
    puts("No solution");
    #endif
    return 0;
}

// Solve the puzzle...
void Sudoku::solve_game ()
{
    int success, i, j;
    SudokuCell * cell;

    cancel_selection ();
    esc = 0;
    if (check_game (-1) == 0)
    {
	IIntuition->SetWindowTitles (graph.window, GetLocaleString(SOLVING_MESSAGE_STRING), AMISUDOKU_TXT);
	if (is_saved == 0)
	    save_game_to_memory ();
	fill_free_cells (YELLOW);
	success = play_next ();
	IIntuition->SetWindowTitles (graph.window, title, AMISUDOKU_TXT);
	if (success)
	{
	    last_memo = -1;
	    switchMenu (&graph, UNDO_MENU, FALSE);
	    RedrawGame ();
	    fill_test_cells (YELLOW);
	    mode = GAME_FINISHED;
	    switchMenu (&graph, SOLVE_MENU, FALSE);
	    return;
	}
	fill_free_cells (WHITE);
	RedrawGame ();
	check_game (-1);
    }
    if (autoupdate_help)
	update_tests ();
    if (esc)
	display_message (STOPSOLVING_ERROR_STRING);
    else
	display_message (SOLVING_ERROR_STRING);
}

void Sudoku::memo_undo (SudokuCell * cell)
{
    int i;

    if (last_memo >= 80)
    {
	for (i = 0;  i < 80;  i++)
	{
	    memo[i].cell = memo[i+1].cell;
	    memo[i].old_value = memo[i+1].old_value;
	}
    }
    else
	last_memo++;
    memo[last_memo].cell = cell;
    memo[last_memo].old_value = cell->read_value();
    switchMenu (&graph, UNDO_MENU, TRUE);
}

void Sudoku::play_cell (SudokuCell * cell, int num)
{
    memo_undo (cell);
    cancel_selection ();
    if (show_possible)
	show_possible_cells (0);
    cell->set_value (num);
    cell->draw (&graph, BLUE);
    if (autoupdate_help)
	update_tests ();
    selection = cell;
    cell->draw (&graph, BLUE);
    draw_test_cells (selection);
    check_game (show_errors);
}

SudokuCell * Sudoku::suggest ()
{
    int i, j, num, solutions;
    SudokuCell * cell;

    if (mode == GAME_FINISHED)
	return 0;
    /* Look for an easy play (only one value possible) */
    for (i = 0;  i < 9;  i++)
	for (j = 0;  j < 9;  j++)
	{
	    cell = grid_cells[i][j];
	    if (cell->read_value())
		continue;
	    if (possibilities (cell, &num) == 1)
	    {
		play_cell (cell, num);
		return cell;
	    }
	    num = test_line (cell);
	    if (num == 0)
	    {
		num = test_column (cell);
		if (num == 0)
		    num = test_group (cell);
	    }
	    if (num)
	    {
		play_cell (cell, num);
		return cell ;
	    }
	}
    /* No easy play, look for best chance */
    solutions = 2;
    do
    {
	for (i = 0;  i < 9;  i++)
	    for (j = 0;  j < 9;  j++)
	    {
		cell = grid_cells[i][j];
		if (cell->read_value())
		    continue;
		if (possibilities (cell, &num) == solutions)
		{
		    num = rand() % solutions;
		    num = possibility(cell, num + 1);
		    play_cell (cell, num);
		    return cell;
		}
	    }
	solutions++;
    }
    while (solutions < 9);
    return 0;
}

int SelectFile (struct Screen * screen, struct Window * w, CONST_STRPTR title, char * drawer, char * filename)
{
    struct FileRequester * file;
    BOOL success = 0;
    STATIC int high = 0, width = 0, top = 0, left = 0;

    if (high == 0)
    {
	high = screen->Height / 3 * 2;
	top = (screen->Height - high) / 2;
	width = max (320, screen->Width / 3);
	left = (screen->Width - width) / 2;
    }
    file = (FileRequester *) IAsl->AllocAslRequestTags (ASL_FileRequest,
	ASLFR_InitialFile,	filename,	    // ASL_File
	ASLFR_InitialDrawer,	drawer, 	    // ASL_Dir
	ASLFR_InitialHeight,	high,		    // ASL_Height
	ASLFR_InitialWidth,	width,		    // ASL_Width
	ASLFR_InitialTopEdge,	top,		    // ASL_TopEdge
	ASLFR_InitialLeftEdge,	left,		    // ASL_LeftEdge
    TAG_DONE);
    if (file)
    {
	if (IAsl->AslRequestTags (file,
	    ASLFR_TitleText,	title,
	    w ? ASLFR_Window : TAG_IGNORE,  w,
	    ASLFR_SleepWindow,	TRUE,
	    ASLFR_Screen,	screen,
	    ASLFR_PositiveText, GetLocaleString (OK_STRING),
	    ASLFR_NegativeText, GetLocaleString (CANCEL_STRING),
	    ASLFR_Flags1,	(*title == 'S') ? FRF_DOSAVEMODE | FRF_DOPATTERNS : FRF_DOPATTERNS,
	    ASLFR_Flags2,	FRF_REJECTICONS,
	    TAG_DONE
	))
	{
	    strcpy (drawer, file->fr_Drawer);
	    strcpy (filename, file->fr_File);
	    high = file->fr_Height;
	    width = file->fr_Width;
	    top = file->fr_TopEdge;
	    left = file->fr_LeftEdge;
	    success = 1;
	}
	IAsl->FreeAslRequest (file);
    }
    return success;
}

void Sudoku::save_game_to_memory (void)
{
    int i, j;
    SudokuCell * cell;

    if (is_saved == 0)
    {
	for (i = 0; i < 9; i ++)
	{
	    for (j = 0; j < 9; j ++)
	    {
		cell = new SudokuCell (i, j);
		saved_cells[i][j] = cell;
	    }
	}
	for (i = 0; i < 9; i ++)
	    saved_test_cells[i] = new SudokuCell (-1, i);
    }
    is_saved = 1;
    saved_selection = selection;
    for (i = 0; i < 9; i ++)
	for (j = 0; j < 9; j ++)
	    *saved_cells[i][j] = *grid_cells[i][j];
    for (i = 0; i < 9; i ++)
	*saved_test_cells[i] = * test_cells[i];
    saved_show_possible = show_possible;
    for (i = 0;  i < 9*9;  i++)
	saved_memo[i] = memo[i];
    saved_last_memo = last_memo;
    switchMenu (&graph, RESTORE_MENU, TRUE);
}

// Save the current game state in a file selected by the user
void Sudoku::save_game (char * drawer, char * filename)
{
    BPTR file;

    if (SelectFile (screen, graph.window, GetLocaleString(SAVING_FILE_STRING), drawer, filename))
    {
	IDOS->AddPart (drawer, filename, 1024);
	file = IDOS->Open (drawer, MODE_NEWFILE);
	if (file)
	{
	    // Save the current values and state of each cell
	    for (int i = 0; i < 9; i ++)
		for (int j = 0; j < 9; j ++)
		{
		    char name[255];
		    SudokuCell * cell = grid_cells[i][j];

		    sprintf (name, "cell%d.%d=val%d,lock%d,test%d,%d,%d,%d,%d,%d,%d,%d,%d\n", i, j,
			cell->read_value(), cell->is_locked(),
			cell->read_test_value(0), cell->read_test_value(1),
			cell->read_test_value(2), cell->read_test_value(3),
			cell->read_test_value(4), cell->read_test_value(5),
			cell->read_test_value(6), cell->read_test_value(7),
			cell->read_test_value(8)
		    );
		    IDOS->Write (file, name, strlen(name));
		}
	    IDOS->Close (file);
	    * IDOS->PathPart (drawer) = 0;
	    sprintf (title, "%s - %s", AMISUDOKU_TXT, filename);
	    IIntuition->SetWindowTitles (graph.window, title, AMISUDOKU_TXT);
	}
    }
}

// Load the game from the specified file
void Sudoku::load_file (char * filename)
{
    int v, i, j, k, l, val, lock, test[9];
    SudokuCell * cell;
    FILE * file = fopen (filename, "r");

    // Load the current values and state of each cell
    if (file)
    {
	memset (grid_values, 0, sizeof(grid_values));
	for (i = 0; i < 9; i ++)
	    for (j = 0; j < 9; j ++)
	    {
		cell = grid_cells[i][j];

		v = fscanf (file, "cell%d.%d=val%d,lock%d,test%d,%d,%d,%d,%d,%d,%d,%d,%d\n", &k, &l, &val, &lock, &test[0], &test[1], &test[2], &test[3], &test[4], &test[5], &test[6], &test[7], &test[8]);
		if (v != 13  ||  i != k  ||  j != l)
		{
		    // printf ("Error reading values (%ld - %ld %ld -> %ld %ld)\n", v, i, j, k, l);
		    display_message (ERROR_READING_FILE);
		    i = 9;
		    break;
		}
		else
		{
		    cell->set_value (val);
		    cell->set_state (&graph, lock);
		    for (k = 0;  k < 9;  k ++)
			cell->set_test_value (k, test[k]);
		}
	    }
	fclose (file);
	init_test_cells ();
	sprintf (title, "%s - %s", AMISUDOKU_TXT, IDOS->FilePart(filename));
	IIntuition->SetWindowTitles (graph.window, title, AMISUDOKU_TXT);
	switchMenu (&graph, SOLVE_MENU, TRUE);
	switchMenu (&graph, EDITGAME_MENU, TRUE);
	switchMenu (&graph, SAVE_MENU, TRUE);
	switchMenu (&graph, RESTORE_MENU, FALSE);
	last_memo = -1;
	switchMenu (&graph, UNDO_MENU, FALSE);
	if (free_cells() == 0)
	{
	    v = check_game (1);
	    if (v == 1)
	    {
		mode = GAME_FINISHED;
		switchMenu (&graph, SOLVE_MENU, FALSE);
		return;
	    }
	    if (v < 0)
		display_message (ERROR_CHECKING_GAME);
	}
	mode = PLAY;
    }
    else
	display_message (ERROR_OPENING_FILE_STRING);
}

// Load the game from a selected file
void Sudoku::load_game (char * drawer, char * filename)
{
    FILE * file;

    if (SelectFile (screen, graph.window, GetLocaleString(LOADING_FILE_STRING), drawer, filename))
    {
	IDOS->AddPart (drawer, filename, 1024);

	load_file (drawer);
	* IDOS->PathPart (drawer) = 0;
    }
}

// Look for the last free cell to move selection in a given direction
SudokuCell * Sudoku:: last_free_cell (SudokuCell * cell, int dx, int dy)
{
    int x, y;

    x = cell->x;
    y = cell->y;
    if (dx)
	if (dx > 0)
	    x = 9;
	else
	    x = -1;
    if (dy)
	if (dy > 0)
	    y = 9;
	else
	    y = -1;
    while (x-dx >= 0  &&  x-dx < 9  && y-dy >= 0  &&  y-dy < 9)
    {
	cell = grid_cells[x-dx][y-dy];
	if (cell->is_locked() == 0)
	    return cell;
	x = cell->x;
	y = cell->y;
    }
    return 0;
}

// Look for a free cell to move selection in a given direction
SudokuCell * Sudoku:: free_cell (SudokuCell * cell, int dx, int dy)
{
    int x, y;

    if (qualifier & (IEQUALIFIER_LALT | IEQUALIFIER_RALT | IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT | IEQUALIFIER_CONTROL))
	return last_free_cell (cell, dx, dy);
    x = cell->x;
    y = cell->y;
    while (x+dx >= 0  &&  x+dx < 9  && y+dy >= 0  &&  y+dy < 9)
    {
	cell = grid_cells[cell->x+dx][cell->y+dy];
	if (cell->is_locked() == 0)
	    return cell;
	x = cell->x;
	y = cell->y;
    }
    return 0;
}

// Main loop, check keyboard and mouse events
void Sudoku:: handle_events (void)
{
    BOOL end = FALSE;
    ULONG signal, siggot, result;
    int code2, i, j;
    UWORD code;
    SudokuCell * cell;
    static char drawer[1024] = "Games", file[50] = "";

    do
    {
	IIntuition->GetAttr (WINDOW_SigMask, object, &signal);

	siggot = IExec->Wait (signal | SIGBREAKF_CTRL_C);
	if (siggot & SIGBREAKF_CTRL_C)
	    end = TRUE;
	while ((result = RA_HandleInput (object, &code2))  !=  WMHI_LASTMSG)
	{
	    switch (result & WMHI_CLASSMASK)
	    {
		case WMHI_MOUSEBUTTONS:
		    cell = mousePressEvent (MouseX, MouseY);
		    if (cell)
		    {
			if (show_possible  &&  (show_possible > -2))    // -2 means errors
			    show_possible_cells (0);
			if (selection)
			{
			    if (selection->color == RED  &&  show_possible == -2)
				selection = 0;
			    else
				cancel_selection ();
			}
			else
			    init_test_cells ();
			if ((show_possible > -2)  &&  (mode != GAME_FINISHED))
			{
			    selection = cell;
			    selection->draw (&graph, BLUE);
			    draw_test_cells (selection);
			}
			else
			    show_possible = -1;
		    }
		    break;

		case WMHI_ICONIFY:
		    if (RA_Iconify(object))
			graph.window = NULL;
		    break;

		case WMHI_UNICONIFY:
		    open_window ();
		    break;

		case WMHI_CLOSEWINDOW:
		    end = TRUE;
		    break;

		case WMHI_RAWKEY:
		    if (selection)
		    {
			cell = 0;
			code = result & WMHI_KEYMASK;
			switch (code)
			{
			    case 0x4C:
				cell = free_cell (selection, 0, -1);
				break;

			    case 0x4D:
				cell = free_cell (selection, 0, +1);
				break;

			    case 0x4E:
				cell = free_cell (selection, +1, 0);
				break;

			    case 0x4F:
				cell = free_cell (selection, -1, 0);
				break;

			    case 0x46:	    /* Del */
				/* memo_undo (selection);
				selection->set_value(0);
				selection->draw (&graph, BLUE); */
				play_cell (selection, 0);
				break;
			}
			if (cell)
			{
			    cancel_selection ();
			    selection = cell;
			    selection->draw (&graph, BLUE);
			    draw_test_cells (selection);
			}
		    }
		    break;

		case WMHI_VANILLAKEY:
		    code = result & WMHI_KEYMASK;
		    if (code >= '0'  &&  code <= '9')
			if (selection)
			    if (selection->is_locked() == 0)    // Should be always true...
				if (qualifier & (IEQUALIFIER_LALT | IEQUALIFIER_RALT | IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT | IEQUALIFIER_CONTROL))
				{
				    int i, val;
				    if (code == '0')
				    {
					selection->init_test_values ();
					init_test_cells ();
				    }
				    else
				    {
					code -= '0';
					cell = test_cells[code-1];
					change_state (cell);
				    }
				}
				else
				    play_cell (selection, code - '0');
		    /* if (selection)
		    {
			if (code == 'l')
			    printf ("Line %ld : %ld\n", selection->y, test_line(selection));
			if (code == 'c')
			    printf ("Column %ld : %ld\n", selection->x, test_column(selection));
			if (code == 'g')
			    printf ("Group : %ld\n", test_group(selection));
		    } */
		    break;

		case WMHI_MENUPICK:
		    code = result & WMHI_MENUMASK;
		    switch MENUNUM(code)
		    {
			case PROJECT_MENU:
			    switch ITEMNUM(code)
			    {
				case NEW_GAME_MENU:
				    if (mode == EDIT_BOARD)
				    {
					if (check_game (-1) == 0)
					{
					    convert ();
					    esc = 0;
					    IIntuition->SetWindowTitles (graph.window, GetLocaleString(SOLVING_MESSAGE_STRING), AMISUDOKU_TXT);
					    if (play_next ())
					    {
						restart_game ();
						if (autoupdate_help)
						    update_tests ();
						// sprintf (title, "%s - %s", AMISUDOKU_TXT, GetLocaleString (EDITED_GAME_STRING));
						IIntuition->SetWindowTitles (graph.window, title, AMISUDOKU_TXT);
					    }
					    else
					    {
						display_message (SOLVING_ERROR_STRING);
						restart_game ();
						edit_game ();
					    }
					}
					else
					{
					    mode = EDIT_BOARD;
					    display_message (INCORRECT_GRID_STRING);
					}
				    }
				    else
				    {
					new_game (time (NULL));
					if (autoupdate_help)
					    update_tests ();
					init_test_cells ();
				    }
				    break;

				case CHECK_MENU:
				    check_game (1);
				    break;

				case RESTART_MENU:
				    restart_game ();
				    init_test_cells ();
				    if (autoupdate_help)
				    {
					update_tests ();
					if (selection)
					{
					    draw_test_cells (selection);
					    selection->draw (&graph, BLUE);
					}
				    }
				    break;

				case SOLVE_MENU:
				    solve_game ();
				    break;

				case UNDO_MENU:
				    if (last_memo < 0)
					display_message (NOTHING_TO_UNDO_STRING);
				    else
				    {
					cell = memo[last_memo].cell;
					cell->set_value (memo[last_memo].old_value);
					if (--last_memo < 0)
					    switchMenu (&graph, UNDO_MENU, FALSE);
					cell->draw (&graph);
					cancel_selection ();
					if (mode == GAME_FINISHED)
					{
					    mode = PLAY;
					    show_possible = -1;
					}
					if (show_possible)
					    show_possible_cells (0);
					if (autoupdate_help)
					    update_tests ();
					selection = cell;
					selection->draw (&graph, BLUE);
					draw_test_cells (selection);
					switchMenu (&graph, SOLVE_MENU, TRUE);
				    }
				    break;

				case SAVE_MEMORY_MENU:
				    save_game_to_memory ();
				    break;

				case RESTORE_MENU:
				    if (is_saved)
				    {
					for (i = 0; i < 9; i ++)
					    for (j = 0; j < 9; j ++)
						*grid_cells[i][j] = *saved_cells[i][j];
					for (i = 0; i < 9; i ++)
					{
					    *test_cells[i] = *saved_test_cells[i];
					    test_cells[i]->draw (&graph);
					}
					show_possible = saved_show_possible;
					for (i = 0;  i < 9*9;  i++)
					    memo[i] = saved_memo[i];
					last_memo = saved_last_memo;
					RedrawGame ();
					selection = saved_selection;
					if (free_cells())
					{
					    mode = PLAY;
					    IIntuition->SetWindowTitles (graph.window, title, AMISUDOKU_TXT);
					    switchMenu (&graph, SOLVE_MENU, TRUE);
					}
				    }
				    else
					display_message (NOTHING_TO_RESTORE_STRING);
				    break;

				case EDITGAME_MENU:
				    edit_game ();
				    break;

				case LOAD_MENU:
				    load_game (drawer, file);
				    break;

				case SAVE_MENU:
				    save_game (drawer, file);
				    break;

				case PREFS_MENU:
				{
				    ULONG new_size = open_prefs_requester ();
				    if (new_size != cellsizegadget)
				    {
					cellsize = 22 + (cellsizegadget = new_size) * 10;
					close_window ();
					if (open_window ())
					{
					    if (selection)
						draw_test_cells (selection);
					}
					else
					    end = 1;
				    }
				    break;
				}

				case ABOUT_MENU:	/* About */
				    display_message (ABOUT_STRING);
				    break;

				case QUIT_MENU: 	/* Quit */
				    end = 1;;
				    break;
			    }
			    break;

			case HELP_MENU:
			    switch ITEMNUM(code)
			    {
				case SHOWERRORS_MENU:
				    show_errors ^= 1;
				    break;

				case AUTOUPDATE_HELP_MENU:
				    autoupdate_help ^= 1;
				    if (autoupdate_help)
				    {
					update_tests ();
					if (selection)
					{
					    draw_test_cells (selection);
					    selection->draw (&graph, BLUE);
					}
				    }
				    else
				    {
					for (i = 0;  i < 9;  i++)
					    for (j = 0;  j < 9;  j++)
					    {
						cell = grid_cells[i][j];
						if (cell->is_locked() == 0)
						    cell->init_test_values();
					    }
					init_test_cells ();
				    }
				    break;

				case QUICK_HELP_MENU:
				    quick_help ^= 1;
				    break;

				case CELL_TEST_MENU:
				    if (selection)
					switch (SUBNUM(code))
					{
					    case INIT_MENU:
						selection->init_test_values();
						draw_test_cells (selection);
						break;

					    case VERTICAL_MENU:
						check_column (selection, 1);
						draw_test_cells (selection);
						selection->draw (&graph, BLUE);
						break;

					    case HORIZONTAL_MENU:
						check_line (selection, 1);
						draw_test_cells (selection);
						selection->draw (&graph, BLUE);
						break;

					    case GROUP_MENU:
						check_group (selection, 1);
						draw_test_cells (selection);
						selection->draw (&graph, BLUE);
						break;

					    case ALL_MENU:
						check_all (selection, 1);
						draw_test_cells (selection);
						selection->draw (&graph, BLUE);
						break;
					}
				    break;

				case ALL_CELLS_MENU:
				    update_tests ();
				    if (selection)
				    {
					draw_test_cells (selection);
					selection->draw (&graph, BLUE);
				    }
				    break;

				case SHOW_POSSIBLE_MENU:
				    if (mode != GAME_FINISHED)
				    {
					code = SUBNUM(code);
					show_possible_cells (code + 1);
				    }
				    break;

				case SHOW_EASY_CELLS_MENU:
				    show_easy_cells ();
				    break;

				case PLAY_MENU:
				    selection = suggest ();
				    if (selection)
					if (mode != GAME_FINISHED)
					    selection->draw (&graph, BLUE);
				    break;
			    }
			    break;
		    }
	    }
	}
    }
    while (! end);
}

// Check if the game is correct, finished...
BOOL Sudoku::check_game (int highlight)
{
    BOOL empty = false;
    BOOL correct = true;
    int i, j, k, errors = 0;
    SudokuCell * cell;

    if (free_cells() == 0)      // Force highlighting errors if grid is full
	highlight = -1;
    // Check the game for right/wrong answers...
    for (i = 0; i < 9; i ++)
	for (j = 0; j < 9; j ++)
	{
	    cell = grid_cells[i][j];
	    int val = cell->read_value();

	    if (cell->is_locked()) continue;
	    if (!val)
		empty = true;
	    else
	    {
		if (test_all (cell, val) == 0)
		{
		    if (highlight)
		    {
			if (cell == selection)
			    cancel_selection ();
			cell->draw (&graph, RED);
			show_possible = -2;
		    }
		    errors++;
		    correct = false;
		}
		else if (highlight)
		    cell->draw (&graph, WHITE);
	    }
	}

    if (!empty)
    {
	if (correct)
	{
	    // Success!
	    for (i = 0; i < 9; i ++)
	    {
		for (j = 0; j < 9; j ++)
		{
		    cell = grid_cells[i][j];
		    if (cell->is_locked() == 0)
			cell->draw (&graph, GREEN);
		}
	    }
	    fill_test_cells (GREEN);
	    selection = 0;
	    mode = GAME_FINISHED;
	    // last_memo = -1;
	    switchMenu (&graph, SOLVE_MENU, FALSE);
	    return 1;
	}
    }
    else	/* Check for impossible playing */
    {
	for (i = 0; i < 9; i ++)
	    for (j = 0; j < 9; j ++)
	    {
		cell = grid_cells[i][j];
		if (cell->read_value() == 0)
		    if (possibilities (cell, &k) == 0)
		    {
			if (highlight)
			    if ((highlight < 0)  ||  quick_help)
			    {
				if (cell == selection)
				    cancel_selection ();
				cell->draw (&graph, RED);
				show_possible = -2;
			    }
			errors++;
		    }
	    }
	/* Check columns for possible nums */
	int col, line;
	for (col = 0;  col < 9;  col++)
	{
	    for (k = 1;  k <= 9;  k++)
	    {
		for (line = 0;  line < 9;  line++)
		{
		    cell = grid_cells[col][line];
		    if (cell->read_value() == k)
			break;
		    if (cell->read_value() == 0)
			if (test_all (cell, k))
			    break;
		}
		if (line == 9)
		{
		    errors++;
		    if (highlight)
			if ((highlight < 0)  ||  quick_help)
			{
			    test_cells[k-1]->draw (&graph, VIOLET);
			    colorize_column (col, RED);
			    cancel_selection ();
			}
		    k = 9;
		}
	    }
	}
	/* Check lines for possible nums */
	for (line = 0;  line < 9;  line++)
	{
	    for (k = 1;  k <= 9;  k++)
	    {
		for (col = 0;  col < 9;  col++)
		{
		    cell = grid_cells[col][line];
		    if (cell->read_value() == k)
			break;
		    if (cell->read_value() == 0)
			if (test_all (cell, k))
			    break;
		}
		if (col == 9)
		{
		    errors++;
		    if (highlight)
			if ((highlight < 0)  ||  quick_help)
			{
			    test_cells[k-1]->draw (&graph, LIGHT_BLUE);
			    colorize_line (line, RED);
			    cancel_selection ();
			}
		    k = 9;
		}
	    }
	}
	/* Check groups for possible nums */
	for (i = 0;  i < 9;  i += 3)
	    for (j = 0;  j < 9;  j += 3)
		for (k = 1;  k <= 9;  k++)
		{
		    for (col = 0;  col < 3;  col++)
		    {
			for (line = 0;  line < 3;  line++)
			{
			    cell = grid_cells[col + i][line + j];
			    if (cell->read_value() == k)
			    {
				col = 4;
				break;
			    }
			    if (cell->read_value() == 0)
				if (test_all (cell, k))
				{
				    col = 4;
				    break;
				}
			}
		    }
		    if (col == 3)
		    {
			errors++;
			if (highlight)
			    if ((highlight < 0)  ||  quick_help)
			    {
				test_cells[k-1]->draw (&graph, BROWN);
				colorize_group (i, j, RED);
				cancel_selection ();
			    }
			k = 9;
		    }
		}
    }
    if (errors)
	return -1;
    else
	return 0;
}

void Sudoku::check_tooltypes ()
{
    struct DiskObject * dobj;
    int d;

    if (dobj = IIcon->GetDiskObject ("AmiSudoku"))
    {
	STRPTR * toolarray;
	STRPTR s;
	LONG x;

	toolarray = dobj->do_ToolTypes;
	if (s = IIcon->FindToolType (toolarray, "LEVEL"))
	{
	    d = IDOS->StrToLong (s, &x);
	    if (d > 0  &&  x >= LEVEL_MIN  &&  x <= LEVEL_MAX)
		level = x;
	    else
		error (BAD_LEVEL_VALUE_STRING);
	}
	if (s = IIcon->FindToolType (toolarray, "CELLSIZE"))
	{
	    d = IDOS->StrToLong (s, &x);
	    if (d > 0  &&  x >= CELLSIZE_MIN  &&  x <= CELLSIZE_MAX)
	    {
		cellsizegadget = x;
		cellsize = 22 + cellsizegadget * 10;
	    }
	    else
		error (BAD_CELLSIZE_VALUE_STRING);
	}
	IIcon->FreeDiskObject (dobj);
    }
    else
	error (LOADING_DISKOBJECT_ERROR_STRING);
}

// Main entry for the game... /////////////////////////////////////////////////
int main (int argc, char *argv[])
{
    if (open_libs ())
    {
	Sudoku game;

	if (game.screen)
	{
	    init_menus ();
	    game.hook.h_Entry = (ULONG (*)()) IDCMP_func;
	    game.hook.h_Data = &game;
	    if (game.AppPort = IExec->CreateMsgPort())      // For iconify gadget
	    {
		if (game.open_window ())
		{
		    if (argc == 2)
			game.load_file (argv[1]);
		    else
			game.new_game (time (NULL));
		    game.handle_events ();
		}
		IExec->DeleteMsgPort (game.AppPort);
	    }
	    else
		error (APPPORT_ERROR_STRING);
	}
	else
	    error (LOCKSCREEN_ERROR_STRING);
    }
    close_libs ();
    return 0;
}
