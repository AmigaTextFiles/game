/*
 * cursesio.c
 *
 * Curses based screen I/O. This is an operating system specific screen I/O
 * module that should work for VMS and UNIX systems. Some UNIX systems may 
 * need cursesX.h instead of curses.h.
 *
 * The Z machine screen handling is based on a VT100, hey don't blame me, blame
 * Infocom ;-). If you know how a VT100 behaves and think you can emulate it
 * then you stand a good chance of porting this to some other type of display.
 * If not read this source for inspiration.
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"
#include <curses.h>

/* Local variables */

static int windows_started = FALSE;
static int cursor_saved = OFF;
static int saved_row = 0;
static int saved_col = 0;

/*
 * initialise_screen
 *
 * Do any screen initialisation including setting the global variables
 * screen_rows and screen_cols.
 *
 */

#ifdef __STDC__
void initialize_screen (void)
#else
void initialize_screen ()
#endif
{

    /* Start curses */

    initscr ();
    windows_started = TRUE;

    /* Set screen_rows and screen_cols from curses */

    screen_rows = LINES;
    screen_cols = COLS;

    /* Clear screen and display banner */

    clear_screen ();
    move_cursor (screen_rows / 2, (screen_cols - sizeof ("The story is loading...")) / 2);
    addstr ("The story is loading...");
    refresh ();

}/* initialize_screen */

/*
 * restart_screen
 *
 * Reset the screen back the to its state after initialise_screen.
 *
 */

#ifdef __STDC__
void restart_screen (void)
#else
void restart_screen ()
#endif
{

    /* Reset attributes, clear display and put cursor in bottom left corner */

    set_attribute (NORMAL);
    clear_screen ();
    move_cursor (screen_rows, 1);

}/* restart_screen */

/*
 * reset_screen
 *
 * Reset the screen before exiting program.
 *
 */

#ifdef __STDC__
void reset_screen (void)
#else
void reset_screen ()
#endif
{

    /* Turn off curses */

    if (windows_started == TRUE) {
#ifdef VMS
        output_string ("[Hit any key to continue.]");
        (void) input_character ();
#endif /* VMS */
        endwin ();
    }
    windows_started = FALSE;

}/* reset_screen */

/*
 * clear_screen
 *
 * Clear the whole screen.
 *
 */

#ifdef __STDC__
void clear_screen (void)
#else
void clear_screen ()
#endif
{

    clear ();

}/* clear_screen */

/*
 * select_status_window
 *
 * Put the cursor in the status window. The cursor position from the test window
 * should be saved and the cursor moved to the home position.
 *
 */

#ifdef __STDC__
void select_status_window (void)
#else
void select_status_window ()
#endif
{

    save_cursor_position ();
    refresh ();
    move_cursor (1, 1);

}/* select_status_window */

/*
 * select_text_window
 *
 * Restore the cursor in the text window after it has been moved to the status
 * window.
 *
 */

#ifdef __STDC__
void select_text_window (void)
#else
void select_text_window ()
#endif
{

    restore_cursor_position ();
    refresh ();

}/* select_text_window */

/*
 * create_status_window
 *
 * Create a window of size status_size x screen_cols at the top of the screen.
 * This routine is also called if the status window needs to be resized.
 * Basically this is a set scrolling region request. The text window is the
 * scrolling region, and the status reagion is fixed.
 *
 */

#ifdef __STDC__
void create_status_window (void)
#else
void create_status_window ()
#endif
{

}/* create_status_window */

/*
 * delete_status_window
 *
 * Delete any previously created status window. Do not erase contents.
 *
 */

#ifdef __STDC__
void delete_status_window (void)
#else
void delete_status_window ()
#endif
{

}/* delete_status_window */

/*
 * clear_line
 *
 * Clear the line from the current cursor position to the end of the line.
 *
 */

#ifdef __STDC__
void clear_line (void)
#else
void clear_line ()
#endif
{

    clrtoeol ();

}/* clear_line */

/*
 * clear_text_window
 *
 * Clear the text window, leaving the cursor in the bottom left corner.
 *
 */

#ifdef __STDC__
void clear_text_window (void)
#else
void clear_text_window ()
#endif
{
    int i;

    for (i = status_size + 1; i <= screen_rows; i++) {
        move_cursor (i, 1);
        clear_line ();
    }

}/* clear_text_window */

/*
 * clear_status_window
 *
 * Clear the status window, leaving the cursor in the top left corner.
 *
 */

#ifdef __STDC__
void clear_status_window (void)
#else
void clear_status_window ()
#endif
{
    int i;

    for (i = status_size; i; i--) {
        move_cursor (i, 1);
        clear_line ();
    }

}/* clear_status_window */

/*
 * move_cursor
 *
 * Move the cursor position. Top left corner = (1, 1).
 *
 */

#ifdef __STDC__
void move_cursor (int row, int col)
#else
void move_cursor (row, col)
int row;
int col;
#endif
{

    move (row - 1, col - 1);

}/* move_cursor */

/*
 * save_cursor_position
 *
 * Save the position of the cursor. Cannot be called recursively.
 *
 */

#ifdef __STDC__
void save_cursor_position (void)
#else
void save_cursor_position ()
#endif
{

    if (cursor_saved == OFF) {
        getyx (stdscr, saved_row, saved_col);
        cursor_saved = ON;
    }

}/* save_cursor_position */

/*
 * restore_cursor_position
 *
 * Restore the position of the cursor. Cannot be called recursively.
 *
 */

#ifdef __STDC__
void restore_cursor_position (void)
#else
void restore_cursor_position ()
#endif
{

    if (cursor_saved == ON) {
        move (saved_row, saved_col);
        cursor_saved = OFF;
    }

}/* restore_cursor_position */

/*
 * set_attribute
 *
 * Set a video attribute. The attributes required are normal, reverse, bold,
 * blink and underscore. The minimum set of attributes is normal and reverse.
 *
 */

#ifdef __STDC__
void set_attribute (int attribute)
#else
void set_attribute (attribute)
int attribute;
#endif
{

    switch (attribute) {
#ifdef VMS
        case REVERSE:    setattr (_REVERSE); break;
        case BOLD:       setattr (_BOLD); break;
        case BLINK:      setattr (_BLINK); break;
        case UNDERSCORE: setattr (_UNDERLINE); break;

        default:         clrattr (_REVERSE | _BOLD | _BLINK | _UNDERLINE);
#else /* !VMS */
        case REVERSE:
        case BOLD:
        case BLINK:
        case UNDERSCORE: standout (); break;

        default:         standend ();
#endif /* VMS */
    }

}/* set_attribute */

/*
 * display_char
 *
 * Write a character at the current cursor position.
 *
 */

#ifdef __STDC__
void display_char (int c)
#else
void display_char (c)
int c;
#endif
{

    addch (c);

}/* display_char */

/*
 * fatal
 *
 * Display a fatal error message and exit.
 *
 */

#ifdef __STDC__
void fatal (const char *s)
#else
void fatal (s)
const char *s;
#endif
{

    reset_screen ();
    printf ("\nFatal error: %s (PC = %lx)\n", s, pc);
    exit (EXIT_SUCCESS);

}/* fatal */

/*
 * input_character
 *
 * Read one character without echo.
 *
 */

#ifdef __STDC__
char input_character (void)
#else
char input_character ()
#endif
{
    int c;

    refresh ();
    noecho ();
    crmode ();
    c = getch ();
    nocrmode ();
    echo ();

    return (c);

}/* input_character */

/*
 * input_line
 *
 * Read a line into the global buffer input. This buffer is allocated
 * screen_cols space. input[0] contains the maximum number of characters to
 * read. input[1] should be set to the actual number of characters read. The
 * characters start at position input[2]. Do not overrun the buffer!
 *
 */

#ifdef __STDC__
void input_line (void)
#else
void input_line ()
#endif
{

    refresh ();
    input[1] = 0;
    input[2] = '\0';
    getstr (&input[2]);
    input[1] = strlen (&input[2]);
    if (input[1] > input[0])
        input[1] = input[0];
    scroll_line ();

}/* input_line */

/*
 * scroll_line
 *
 * This routine does the equivalent of putc('\n') in the text window.
 *
 */

#ifdef __STDC__
void scroll_line (void)
#else
void scroll_line ()
#endif
{

    move_cursor (status_size + 1, 1);
    deleteln ();
    move_cursor (screen_rows, 1);
    refresh ();

}/* scroll_line */

/*
 * fit_line
 *
 * This routine determines whether a line of text will still fit
 * on the screen.
 *
 * line : Line of text to test.
 * pos  : Length of text line (in characters).
 * max  : Maximum number of characters to fit on the screen.
 *
 */

#ifdef __STDC__
int fit_line (const char *line, int pos, int max)
#else
int fit_line (line, pos, max)
const char *line;
int pos;
int max;
#endif
{

    return (pos < max);

}/* fit_line */

/*
 * print_status
 *
 * Print the status line (type 3 games only).
 *
 * argv[0] : Location name
 * argv[1] : Moves/Time
 * argv[2] : Score
 *
 * Depending on how many arguments are passed to this routine
 * it is to print the status line. The rendering attributes
 * and the status line window will be have been activated
 * when this routine is called. It is to return FALSE if it
 * cannot render the status line in which case the interpreter
 * will use display_char() to render it on its own.
 *
 * This routine has been provided in order to support
 * proportional-spaced fonts.
 *
 */

#ifdef __STDC__
int print_status (int argc, char *argv[])
#else
int print_status (argc, argv)
int argc;
char *argv[];
#endif
{

    return (FALSE);

}/* print_status */
