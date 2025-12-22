/*
 * mscio.c
 *
 * Microsoft C specific screen I/O routines for DOS.
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

#include <conio.h>
#include <graph.h>

#define BLUE 1
#define WHITE 7
#define BRIGHT 15
#define RED 4
#define GREEN 2

#ifdef __STDC__
static void delete_char (void);
#else
static void delete_char ();
#endif

static int cursor_saved = OFF;
static struct rccoord rc;

#ifdef __STDC__
void fatal (const char *s)
#else
void fatal (s)
const char *s;
#endif
{

    reset_screen ();
    printf ("\nFatal error: %s (PC = %lx)\n", s, pc);
    exit (1);

}/* fatal */

#ifdef __STDC__
void initialize_screen (void)
#else
void initialize_screen ()
#endif
{

    _setvideomode (_TEXTC80);
    screen_rows = 25;
    screen_cols = 80;
    select_text_window ();
    set_attribute (NORMAL);
    clear_screen ();
    move_cursor (screen_rows / 2, (screen_cols - sizeof ("The story is loading...")) / 2);
    _outtext ("The story is loading...");

}/* initialize_screen */

#ifdef __STDC__
void restart_screen (void)
#else
void restart_screen ()
#endif
{

    select_text_window ();
    set_attribute (NORMAL);
    clear_screen ();
    move_cursor (screen_rows, 1);

}/* restart_screen */

#ifdef __STDC__
void reset_screen (void)
#else
void reset_screen ()
#endif
{

    _setvideomode (_DEFAULTMODE);

}/* reset_screen */

#ifdef __STDC__
void clear_screen (void)
#else
void clear_screen ()
#endif
{

    _clearscreen (_GCLEARSCREEN);

}/* clear_screen */

#ifdef __STDC__
void create_status_window (void)
#else
void create_status_window ()
#endif
{

    if (window == STATUS_WINDOW)
        select_status_window ();
    else {
        select_text_window ();
        restore_cursor_position ();
    }

}/* create_status_window */

#ifdef __STDC__
void delete_status_window (void)
#else
void delete_status_window ()
#endif
{

}/* delete_status_window */

#ifdef __STDC__
void select_status_window (void)
#else
void select_status_window ()
#endif
{

    save_cursor_position ();
    _settextwindow (1, 1, status_size, screen_cols);
    _wrapon (_GWRAPOFF);
    _displaycursor (_GCURSOROFF);
    _settextposition (1, 1);

}/* select_status_window */

#ifdef __STDC__
void select_text_window (void)
#else
void select_text_window ()
#endif
{

    _settextwindow (status_size + 1, 1, screen_rows, screen_cols);
    _wrapon (_GWRAPOFF);
    _displaycursor (_GCURSORON);
    _settextposition (screen_rows, 1);
    restore_cursor_position ();

}/* select_text_window */

#ifdef __STDC__
void clear_line (void)
#else
void clear_line ()
#endif
{
    int i;
    struct rccoord rcc;

    rcc = _gettextposition ();
    for (i = rcc.col - 1; i < screen_cols; i++)
        display_char (' ');
    _settextposition (rcc.row, rcc.col);

}/* clear_line */

#ifdef __STDC__
void clear_text_window (void)
#else
void clear_text_window ()
#endif
{

    set_attribute (NORMAL);
    _clearscreen (_GWINDOW);

}/* clear_text_window */

#ifdef __STDC__
void clear_status_window (void)
#else
void clear_status_window ()
#endif
{

    set_attribute (NORMAL);
    _clearscreen (_GWINDOW);
    move_cursor (1, 1);

}/* clear_status_window */

#ifdef __STDC__
void move_cursor (int row, int col)
#else
void move_cursor (row, col)
int row;
int col;
#endif
{

    _settextposition (row, col);

}/* move_cursor */

#ifdef __STDC__
void save_cursor_position (void)
#else
void save_cursor_position ()
#endif
{

    if (cursor_saved == OFF) {
        rc = _gettextposition ();
        cursor_saved = ON;
    }

}/* save_cursor_position */

#ifdef __STDC__
void restore_cursor_position (void)
#else
void restore_cursor_position ()
#endif
{

    if (cursor_saved == ON) {
        _settextposition (rc.row, rc.col);
        cursor_saved = OFF;
    }

}/* restore_cursor_position */

#ifdef __STDC__
void set_attribute (int attribute)
#else
void set_attribute (attribute)
int attribute;
#endif
{

    switch (attribute) {
        case REVERSE:    _setbkcolor (WHITE); _settextcolor (BLUE); break;
        case BOLD:       _setbkcolor (BLUE);  _settextcolor (BRIGHT); break;
        case BLINK:      _setbkcolor (BLUE);  _settextcolor (GREEN); break;
        case UNDERSCORE: _setbkcolor (BLUE);  _settextcolor (RED); break;

        default:         _setbkcolor (BLUE);  _settextcolor (WHITE);
    }

}/* set_attribute */

#ifdef __STDC__
void display_char (int c)
#else
void display_char (c)
int c;
#endif
{

    _outtext ((char *) &c);

}/* display_char */

#ifdef __STDC__
void input_line (void)
#else
void input_line ()
#endif
{
    char c, *cp;

    input[1] = 0;
    cp = &input[2];
    for ( ; ; ) {
        c = input_character ();
        if (c == '\x00e' || c == '\a')
            output_char ('\007');
        else if (c == '\r') {
            *cp++ = c;
            output_char (c);
            scroll_line ();
            return;
        } else if (c == '\x07f' || c == '\b' || c == '\x00b') {
            if (input[1] == 0)
                output_char ('\007');
            else {
                input[1]--;
                cp--;
                delete_char ();
            }
        } else
            if (input[1] == (input[0] - (char) 2))
                output_char ('\007');
            else {
                input[1]++;
                *cp++ = c;
                output_char (c);
            }
    }

}/* input_line */

#ifdef __STDC__
char input_character (void)
#else
char input_character ()
#endif
{
    int c;

    for ( ; ; ) {
        c = getch () & 0x7f;
        if (c >= ' ' || c == '\b' || c == '\r')
            return ((char) c);
        c = getch ();
        if (c == 'H')
            return ('\x00e');
        if (c == 'K')
            return ('\x00b');
        if (c == 'M')
            return ('\x007');
        if (c == 'P')
            return ('\r');
    }

}/* input_character */

#ifdef __STDC__
static void delete_char (void)
#else
static void delete_char ()
#endif
{
    struct rccoord rcc;

    rcc = _gettextposition ();
    _settextposition (rcc.row, --rcc.col);
    _outtext (" ");
    _settextposition (rcc.row, rcc.col);

}/* delete_char */

#ifdef __STDC__
void scroll_line (void)
#else
void scroll_line ()
#endif
{
    int c = '\n';

    _outtext ((char *) &c);

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
