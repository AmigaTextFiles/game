/*
 * screen.c
 *
 * Generic screen manipulation routines. Most of these routines call the machine
 * specific routines to do the actual work.
 *
 */

#include "ztypes.h"

/*
 * select_window
 *
 * Put the cursor in the text or status window. The cursor is free to move in
 * the status window, but is fixed to the input line in the text window.
 *
 */

#ifdef __STDC__
void select_window (zword_t w)
#else
void select_window (w)
zword_t w;
#endif
{

    window = w;
    if (w == STATUS_WINDOW) {

        /* Status window: disable scripting, select the status window and
           home the cursor */

        scripting_disable = ON;
        select_status_window ();
        if (h_type == V3 && status_size > 1)
            move_cursor (2, 1);
    } else {

        /* Text window: enable scripting and select text window */

        scripting_disable = OFF;
        select_text_window ();
    }

    /* Force text attribute to normal rendition */

    set_attribute (NORMAL);

}/* select_window */

/*
 * set_status_size
 *
 * Set the size of the status window. The default size for the status window is
 * zero lines for both type 3 and 4 games. The status line is handled specially
 * for type 3 games and always occurs the line immediately above the status
 * window.
 *
 */

#ifdef __STDC__
void set_status_size (zword_t lines)
#else
void set_status_size (lines)
zword_t lines;
#endif
{
    int i;

    /* Maximum status window size is 255 */

    lines &= 0xff;
    if (lines) {

        /* If size is non zero the turn on the status window */

        status_active = ON;

        /* Bound the status size to one line less than the total screen height */

        if (lines > (zword_t) (screen_rows - 1))
            status_size = (zword_t) (screen_rows - 1);
        else
            status_size = lines;

        /* Create the status window, or resize it */

        create_status_window ();

        /* Need to clear the status window for type 3 games */

        if (h_type == V3 && lines >= 2) {
            status_size++;
            select_status_window ();
            for (i = status_size; i > 1; i--) {
                move_cursor (i, 1);
                clear_line ();
            }
            select_text_window ();
        }
    } else {

        /* Lines are zero so turn off the status window */

        status_active = OFF;

        /* Reset the lines written counter */

        lines_written = 0;

        /* Always leave room for the status line if a type 3 game */

        if (h_type == V3)
            status_size = 1;
        else {
            status_size = 0;

            /* Delete the status window */

            delete_status_window ();
        }

        /* Return cursor to text window */

        select_text_window ();
    }

}/* set_status_size */

/*
 * erase_window
 *
 * Clear one or all windows on the screen.
 *
 */

#ifdef __STDC__
void erase_window (zword_t w)
#else
void erase_window (w)
zword_t w;
#endif
{

    if ((zbyte_t) w == (zbyte_t) RESET) {
        set_status_size (0);
        restart_screen ();
    } else if ((zbyte_t) w == TEXT_WINDOW)
        clear_text_window ();
    else if ((zbyte_t) w == STATUS_WINDOW)
        clear_status_window ();
    else
        return;

}/* erase_window */

/*
 * erase_line
 *
 * Clear one line on the screen.
 *
 */

#ifdef __STDC__
void erase_line (zword_t flag)
#else
void erase_line (flag)
zword_t flag;
#endif
{

    if (flag == TRUE)
        clear_line ();

}/* erase_line */

/*
 * set_cursor_position
 *
 * Set the cursor position in the status window only.
 *
 */

#ifdef __STDC__
void set_cursor_position (zword_t row, zword_t column)
#else
void set_cursor_position (row, column)
zword_t row;
zword_t column;
#endif
{

    /* Can only move cursor if format mode is off and in status window */

    if (format_mode == OFF && window == STATUS_WINDOW)
        move_cursor (row, column);

}/* set_cursor_position */

/*
 * pad_line
 *
 * Pad the status line with spaces up to a column position.
 *
 */

#ifdef __STDC__
static void pad_line (int column)
#else
static void pad_line (column)
int column;
#endif
{
    int i;

    for (i = status_pos; i < column; i++)
        write_char (' ');
    status_pos = column;

}/* pad_line */

/*
 * display_status_line
 *
 * Format and output the status line for type 3 games only.
 *
 */

#ifdef __STDC__
void display_status_line (void)
#else
void display_status_line ()
#endif
{
    int i, count = 0, end_of_string[3];
    char *status_part[3];

    /* Redirect output to the status line buffer */

    set_print_modes (3, 0);

    /* Print the object description for global variable 16 */

    pad_line (1);
    status_part[count] = &status_line[status_pos];
    print_object (load_variable (16));
    end_of_string[count++] = status_pos;
    status_line[status_pos++] = '\0';

    if (get_byte (H_CONFIG) & CONFIG_TIME) {

        /* If a time display print the hours and minutes from global
           variables 17 and 18 */

        pad_line (screen_cols - 21);
        status_part[count] = &status_line[status_pos];
        write_string (" Time: ");
        print_time (load_variable (17), load_variable (18));
        end_of_string[count++] = status_pos;
        status_line[status_pos++] = '\0';
    } else {

        /* If a moves/score display print the score and moves from global
           variables 17 and 18 */

        pad_line (screen_cols - 31);
        status_part[count] = &status_line[status_pos];
        write_string (" Score: ");
        print_number (load_variable (17));
        end_of_string[count++] = status_pos;
        status_line[status_pos++] = '\0';

        pad_line (screen_cols - 15);
        status_part[count] = &status_line[status_pos];
        write_string (" Moves: ");
        print_number (load_variable (18));
        end_of_string[count++] = status_pos;
        status_line[status_pos++] = '\0';
    }

    /* Pad the end of status line with spaces then disable output redirection */

    pad_line (screen_cols);
    set_print_modes ((zword_t) -3, 0);

    /* Move the cursor to the top line of the status window, set the reverse
       rendition and print the status line */

    select_window (STATUS_WINDOW);
    move_cursor (1, 1);
    set_attribute (REVERSE);

    /* Try and print the status line for a proportional font screen. If this
       fails then remove embedded nulls in status line buffer and just output
       it to the screen */

    if (print_status (count, status_part) == FALSE) {
        for (i = 0; i < count; i++)
            status_line[end_of_string[i]] = ' ';
        status_line[status_pos] = '\0';
        output_string (status_line);
    }

    set_attribute (NORMAL);
    select_window (TEXT_WINDOW);

}/* display_status_line */

/*
 * blank_status_line
 *
 * Output a blank status line for type 3 games only.
 *
 */

#ifdef __STDC__
void blank_status_line (void)
#else
void blank_status_line ()
#endif
{

    /* Redirect output to the status line buffer and pad the status line with
       spaces then disable output redirection */

    set_print_modes (3, 0);
    pad_line (screen_cols);
    status_line[status_pos] = '\0';
    set_print_modes ((zword_t) -3, 0);

    /* Move the cursor to the top line of the status window, set the reverse
       rendition and print the status line */

    select_window (STATUS_WINDOW);
    move_cursor (1, 1);
    set_attribute (REVERSE);
    output_string (status_line);
    set_attribute (NORMAL);
    select_window (TEXT_WINDOW);

}/* blank_status_line */

/*
 * output_string
 *
 * Output a string of characters.
 *
 */

#ifdef __STDC__
void output_string (const char *s)
#else
void output_string (s)
const char *s;
#endif
{

    while (*s)
        output_char (*s++);

}/* output_string */

/*
 * output_string
 *
 * Output a string of characters followed by a new line.
 *
 */

#ifdef __STDC__
void output_stringnl (const char *s)
#else
void output_stringnl (s)
const char *s;
#endif
{

    while (*s)
        output_char (*s++);
    output_nl ();

}/* output_stringnl */

/*
 * output_char
 *
 * Output a character and rendition selection. This routine also handles
 * selecting rendition attributes such as bolding and reverse. There are
 * five attributes distinguished by ascii codes 0 to 4. The attributes are:
 * all attributes off (normal), reverse, bold, blink and underline.
 *
 */

#ifdef __STDC__
void output_char (char c)
#else
void output_char (c)
char c;
#endif
{

    /* Script character if scripting is enabled */

    if (scripting_disable == OFF)
        script_char (c);

    /* If output is enabled then either select the rendition attribute
       or just display the character */

    if (output_enable == ON)
        if (c >= 1 && c <= 5)
            set_attribute (--c);
        else
            display_char (c);

}/* output_char */

/*
 * output_nl
 *
 * Scroll the text window up one line and pause the window if it is full.
 *
 */

#ifdef __STDC__
void output_nl (void)
#else
void output_nl ()
#endif
{
    int saved_scripting_disable;

    /* If scripting is enabled then print a new line */

    if (scripting_disable == OFF)
        script_nl ();

    /* Don't print if output is disabled */

    if (output_enable == ON) {
        if (window == TEXT_WINDOW) {

            /* If this is the text line then scroll it up one line */

            scroll_line ();

            /* See if we have filled the screen */

            if (++lines_written >= ((screen_rows - TOP_MARGIN) - status_size)) {

                /* Display the new status line while the screen in paused */

                if (h_type == V3)
                    display_status_line ();

                /* Reset the line count and display the more message */

                lines_written = 0;
                saved_scripting_disable = scripting_disable;
                scripting_disable = ON;
                save_cursor_position ();
                output_string ("[MORE]");
                (void) input_character ();
                restore_cursor_position ();
                clear_line ();
                scripting_disable = saved_scripting_disable;
            }
        } else

            /* If this is the status window then just output a new line */

            output_string ("\n");
    }

}/* output_nl */
