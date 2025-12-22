/*
 * dosio.c
 *
 * Generic DOS screen I/O functions. Uses ANSI.SYS
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

#ifdef __STDC__
static int dos_getch (void);
static void bios_scroll (unsigned char, unsigned char, unsigned char,
                         unsigned char, unsigned char, unsigned char);
#else
static int dos_getch ();
static void bios_scroll ();
#endif

static int cursor_saved = OFF;

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

    screen_rows = 25;
    screen_cols = 80;
    set_attribute (NORMAL);
    clear_screen ();
    move_cursor (screen_rows, 1);
    move_cursor (screen_rows / 2, (screen_cols - sizeof ("The story is loading...")) / 2);
    fputs ("The story is loading...", stdout);

}/* initialize_screen */

#ifdef __STDC__
void restart_screen (void)
#else
void restart_screen ()
#endif
{

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

    set_attribute (NONE);

}/* reset_screen */

#ifdef __STDC__
void create_status_window (void)
#else
void create_status_window ()
#endif
{

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
    move_cursor (1, 1);

}/* select_status_window */

#ifdef __STDC__
void select_text_window (void)
#else
void select_text_window ()
#endif
{

    restore_cursor_position ();

}/* select_text_window */

#ifdef __STDC__
void clear_screen (void)
#else
void clear_screen ()
#endif
{

    fputs ("\033[2J", stdout);

}/* clear_screen */

#ifdef __STDC__
void clear_line (void)
#else
void clear_line ()
#endif
{

    fputs ("\033[K", stdout);

}/* clear_line */

#ifdef __STDC__
void clear_text_window (void)
#else
void clear_text_window ()
#endif
{
    unsigned char ur, uc, lr, lc;

    ur = (unsigned char) (status_size + 1);
    uc = 1;
    lr = (unsigned char) screen_rows;
    lc = (unsigned char) screen_cols;
    bios_scroll (0, ur, uc, lr, lc, 0x17);

}/* clear_text_window */

#ifdef __STDC__
void clear_status_window (void)
#else
void clear_status_window ()
#endif
{
    unsigned char ur, uc, lr, lc;

    ur = 1;
    uc = 1;
    lr = (unsigned char) status_size;
    lc = (unsigned char) screen_cols;
    bios_scroll (0, ur, uc, lr, lc, 0x17);

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

    printf ("\033[%d;%dH", row, col);

}/* move_cursor */

#ifdef __STDC__
void save_cursor_position (void)
#else
void save_cursor_position ()
#endif
{

    if (cursor_saved == OFF) {
        fputs ("\033[s", stdout);
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
        fputs ("\033[u", stdout);
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
        case NORMAL:     fputs ("\033[0m\033[37;44m", stdout); break;
        case REVERSE:    fputs ("\033[0m\033[34;47m", stdout); break;
        case BOLD:       fputs ("\033[0m\033[37;44m\033[1m", stdout); break;
        case BLINK:      fputs ("\033[0m\033[37;44m", stdout); break;
        case UNDERSCORE: fputs ("\033[0m\033[31;47m", stdout); break;

        default:         fputs ("\033[0m", stdout);
    }

}/* set_attribute */

#ifdef __STDC__
void display_char (int c)
#else
void display_char (c)
int c;
#endif
{

    putchar (c);

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
            sound (1);
        else if (c == '\r') {
            *cp++ = c;
            output_char (c);
            scroll_line ();
            return;
        } else if (c == '\x07f' || c == '\b' || c == '\x00b') {
            if (input[1] == 0)
                sound (1);
            else {
                input[1]--;
                cp--;
                fputs ("\b \b", stdout);
            }
        } else
            if (input[1] == (input[0] - (char) 2))
                sound (1);
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
        c = dos_getch () & 0x7f;
        if (c >= ' ' || c == '\b' || c == '\r')
            return ((char) c);
        c = dos_getch ();
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
void scroll_line (void)
#else
void scroll_line ()
#endif
{
    unsigned char ur, uc, lr, lc;

    ur = (unsigned char) status_size;
    uc = 0;
    lr = (unsigned char) (screen_rows - 1);
    lc = (unsigned char) (screen_cols - 1);
    bios_scroll (1, ur, uc, lr, lc, 0x17);
    putchar ('\r');

}/* scroll_line */

#ifdef __STDC__
static void bios_scroll (unsigned char num_lines,
                         unsigned char upper_row,
                         unsigned char left_col,
                         unsigned char lower_row,
                         unsigned char right_col,
                         unsigned char filler)
#else
static void bios_scroll (num_lines,
                         upper_row,
                         left_col,
                         lower_row,
                         right_col,
                         filler)
unsigned char num_lines;
unsigned char upper_row;
unsigned char left_col;
unsigned char lower_row;
unsigned char right_col;
unsigned char filler;
#endif
{

    _asm {
        mov     al,num_lines;
        mov     ch,upper_row;
        mov     cl,left_col;
        mov     dh,lower_row;
        mov     dl,right_col;
        mov     bh,filler;

        mov     ah,06H
        int     10H
    }

#if 0
TITLE   Access to scroll BIOS call from C
.MODEL  COMPACT
.CODE
;_TEXT   SEGMENT WORD PUBLIC 'CODE'
        PUBLIC  _bios_scroll
;    ASSUME  CS:_TEXT,DS:NOTHING,ES:NOTHING,SS:NOTHING
_bios_scroll PROC

        push    bp
        mov     bp,sp

        mov     al,[bp+04]
        mov     ch,[bp+06]
        mov     cl,[bp+08]
        mov     dh,[bp+10]
        mov     dl,[bp+12]
        mov     bh,[bp+14]

        mov     ah,06H
        int     10H

        pop     bp
        ret

_bios_scroll ENDP
;_TEXT   ENDS
        END
#endif /* 0 */

}/* bios_scroll */

#ifdef __STDC__
static int dos_getch (void)
#else
static int dos_getch ()
#endif
{

    _asm {
        mov     ah,07h
        int     21h

        mov     ah,00h
    }

#if 0
TITLE   Access to getch DOS call from C
.MODEL  COMPACT
.CODE
;_TEXT   SEGMENT WORD PUBLIC 'CODE'
        PUBLIC  _dos_getch
;    ASSUME  CS:_TEXT,DS:NOTHING,ES:NOTHING,SS:NOTHING
_dos_getch PROC

        push    bp
        mov     bp,sp

        mov     ah,07h
        int     21h

        mov     ah,00h

        pop     bp
        ret

_dos_getch ENDP
;_TEXT   ENDS
        END
#endif /* 0 */

}/* dos_getch */

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
