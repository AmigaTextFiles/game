/* stream.c
 *
 *  ``pinfocom'' -- a portable Infocom Inc. data file interpreter.
 *  Copyright (C) 1987-1992  InfoTaskForce
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to the
 *  Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * $Header: RCS/stream.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>

#include <signal.h>

#include "infocom.h"

#ifndef free
extern void free();
#endif

#ifdef NEED_ERRNO
extern int errno;
#endif

/*
 * Global Variables
 */

/*
 * Variable:    scr_usage
 *
 * Description:
 *      This variable should contain a usage string for any extra
 *      command-line options available through this terminal
 *      interface.
 */
const char *scr_usage       = "";

/*
 * Variable:    scr_long_usage
 *
 * Description:
 *      This variable should contain a more verbose usage string
 *      detailing the command-line options available through this
 *      terminal interface, one option per line.
 */
const char *scr_long_usage  = NULL;

/*
 * Variable:    scr_opt_list
 *
 * Description:
 *      This variable should contain a getopt(3)-style option list for
 *      any command-line options available through this terminal
 *      interface.
 */
const char *scr_opt_list    = "";

/*
 * Local Variables
 */
static FILE *scr_fp=NULL;

static int scr_columns=80, scr_indent=0;
static int scr_lines=24, scr_lineco=0, scr_context=0;


/*
 * Function:    scr_cmdarg()
 *
 * Arguments:
 *      argc        number of original arguments
 *      argvp       pointer to array of strings containing args
 *
 * Returns:
 *      Number of new arguments.
 *
 * Description:
 *      This function is called before any command line parsing is
 *      done.  Any terminal interface-specific arguments should be
 *      pulled out of the argv list and any extra arguments obtained
 *      from resource files or wherever should be added.  Note that
 *      (*argvp)[0] must be the command name and (*argvp)[argc] must
 *      be a null pointer.
 *
 * Notes:
 */
int
scr_cmdarg A2(int, argc, char ***, argvp)
{
    return (argc);
}


/*
 * Function:    scr_getopt()
 *
 * Arguments:
 *      c           option found
 *      arg         option argument (if requested)
 *
 * Description:
 *      This function is called whenever a command-line option
 *      specified in scr_opt_list (above) is found on the command
 *      line.
 */
void
scr_getopt A2(int, c, const char *, arg)
{
}


/*
 * Function:    scr_setup()
 *
 * Arguments:
 *      margin      # of spaces in the right margin.
 *      indent      # of spaces in the left margin.
 *      scr_sz      # of lines on the screen.
 *      context     # of lines of context to keep when scrolling
 *
 * Returns:
 *      Width of screen output for informational printing (not used if
 *      game is to be played).
 *
 * Description:
 *      This function should set up generic items in the screen
 *      interface that may need to be done before *any* output is
 *      done.
 *
 *      If SCR_SZ is not 0, then this function must use SCR_SZ as the
 *      number of lines the screen can hold at once, no matter what it
 *      may infer otherwise.  If SCR_SZ is 0, then the function must
 *      figure the size of the screen as best it can.
 *
 * Notes:
 *      Any terminal initialization needed only for actually playing
 *      the game should go in scr_begin(), not here.
 */
int
scr_setup A4( int, margin,
              int, indent,
              int, scr_sz,
              int, context )
{
    scr_columns -= margin + indent;

    if (scr_sz)
        scr_lines = scr_sz;

    scr_lines  -= context + 2;
    scr_lineco -= context - 1;
    scr_context = context;
    scr_indent  = indent;

    return (scr_columns);
}


/*
 * Function:    scr_shutdown()
 *
 * Description:
 *      This function will be called just before we exit.
 */
void
scr_shutdown()
{
}


/*
 * Function:    scr_begin()
 *
 * Arguments:
 *      game    The game datafile we're about to execute.
 *
 * Description:
 *      This function should perform terminal initializations we need
 *      to actually play the game.
 */
void
scr_begin()
{
    int i;

    /*
     * Scroll enough so that the saved context lines for the very
     * first screen are blank.
     */
    for (i = scr_context; i != 0; --i)
        putchar('\n');
}


/*
 * Function:    scr_end()
 *
 * Description:
 *      This function will be called after the last line is printed
 *      but before we exit, *only* if scr_begin() was called (*not* if
 *      just scr_startup() was called!)
 */
void
scr_end()
{
}

/*
 * This is an internal function to print a buffer.  If flags==0 then
 * print with paging and a final newline.  If flags & 1 then print
 * without paging.  If flags & 2 then print up to but not including
 * the last lineful, and return a pointer to it (a prompt).
 */
#define PB_NO_PAGING    (0x01)
#define PB_PROMPT       (0x02)

static const char *
scr_putbuf A3(FILE *, fp, int, flags, const char *, buf)
{
    const char *sp;
    const char *ep;

    for (sp = buf; ;)
    {
        ep = chop_buf(sp, scr_columns);

        if ((*ep != '\0') || !(flags & PB_PROMPT))
        {
            const char *p;
            int i;

            if (!(flags & PB_NO_PAGING) && (scr_lineco++ >= scr_lines))
            {
                for (p = "--More--"; *p != '\0'; ++p)
                    putchar(*p);
                setbuf(stdin, NULL);

                while (((i = getchar()) != EOF) && (i != '\n'))
                {}

                scr_lineco = 0;
            }

            for (i=scr_indent; i>0; --i)
                putc(' ', fp);

            for (p = sp; p < ep; ++p)
                putc(*p, fp);

            putc('\n', fp);
        }

        if (*ep == '\0')
            break;

        sp = ep + 1;
    }

    return (sp);
}


/*
 * Function:    scr_putline()
 *
 * Arguments:
 *      buffer          Line to be printed.
 *
 * Description:
 *      This function is passed a nul-terminated string and it should
 *      display the string on the terminal.  It will *not* contain a
 *      newline character.
 *
 *      This function should perform whatever wrapping, paging, etc.
 *      is necessary, print the string, and generate a final linefeed.
 *
 *      If the TI supports proportional-width fonts,
 *      F2_IS_SET(B_FIXED_FONT) should be checked as appropriate.
 *
 *      If the TI supports scripting, F2_IS_SET(B_SCRIPTING) should be
 *      checked as appropriate.
 */
void
scr_putline A1(const char *, buffer)
{
    scr_putbuf(stdout, !gflags.paged, buffer);

    if (F2_IS_SET(B_SCRIPTING))
        scr_putbuf(scr_fp, 1, buffer);
}


/*
 * Function:    scr_putscore()
 *
 * Description:
 *      This function prints the ti_location and ti_status strings
 *      if it can and if status line printing is enabled.
 */
void
scr_putscore()
{
}


/*
 * Function:    scr_putsound()
 *
 * Arguments:
 *      number      sound number to play
 *      action      action to perform
 *      volume      volume to play sound at
 *      argc        number of valid arguments
 *
 * Description:
 *      This function plays the sound specified if it can; if not it
 *      prints a line to that effect.
 *
 *      If the `argc' value is 1, then the we play `number' of beeps
 *      (usually the ^G character).
 *
 *      If `argc' >1, the `action' argument is used as follows:
 *
 *          2:  play sound file
 *          3:  stop playing sound file
 *          4:  free sound resources
 *
 *      If `argc' >2, the `volume' argument is between 1 and 8 and is
 *      a volume to play the sound at.
 */
void
scr_putsound A4(int, number, int, action, int, volume, int, argc)
{
    if (argc == 1)
    {
        while (number--)
            putchar('\a');
    }
    else if (argc == 3 && action == 2)
    {
        char buf[81];

        sprintf(buf, "Sound not supported! (number $%02x, volume %d)",
                number, volume);

        scr_putmesg(buf, 0);
    }
}


/*
 * Function:    scr_putmesg()
 *
 * Arguments:
 *      buffer      message string to be printed.
 *      is_err      1 if message is an error message, 0 if it's not.
 *
 * Description:
 *      This function prints out a message from the interpreter, not
 *      from the game itself.  Often these are errors (IS_ERR==1)
 *      but not necessarily.
 */
void
scr_putmesg A2(const char *, buffer, Bool, is_err)
{
    static char *buf = "";
    int blen;

    blen = strlen(buffer);
    if (strlen(buf) < blen + 12)
    {
        if (strlen(buf) == 0)
            buf = xmalloc(blen + 13);
        else
            buf = xrealloc(buf, blen + 13);
    }

    sprintf(buf, " [ %s%s ]",
            is_err ? "ERROR: " : "",
            buffer);

    scr_putline("");
    scr_putline(buf);
    scr_putline("");
}


/*
 * Function:    scr_getstr()
 *
 * Description:
 *      This is an internal function which performs the meat of
 *      reading a string, throwing away the excess, etc.  It returns
 *      the number of characters read.
 *
 * Notes:
 *      This function is *not* a part of the terminal interface; it's
 *      just an interal helper function.
 */
static int
scr_getstr A3(const char *, prompt, int, length, char *, buffer)
{
    int c;

    fputs(prompt, stdout);
    fflush(stdout);

    buffer[0] = '\0';
    buffer[length-2] = '\0';
    fgets(buffer, length, stdin);

    /*
     * If there's more beyond the max length of our buffer, read
     * it in and throw it away...
     */
    if ((buffer[length-2] != '\0')
        && (buffer[length-2] != '\n')
        && ((c = getchar()) != EOF)
        && (c != '\n'))
    {
        fputs(" [ Input line too long.  Flushing: `", stdout);
        do
        {
            putchar(c);
        }
        while (((c = getchar()) != EOF) && (c != '\n'));

        scr_putline("' ]");
    }
    else
    {
        /*
         * Punt the last \n...
         */
        length = strlen(buffer) - 1;
        buffer[length] = '\0';
    }

    return (length);
}


/*
 * Function:    scr_getline()
 *
 * Arguments:
 *      prompt    - prompt to be printed
 *      length    - total size of BUFFER
 *      buffer    - buffer to return nul-terminated response in
 *
 * Returns:
 *      # of chars stored in BUFFER
 *
 * Description:
 *      Reads a line of input and returns it.  Handles all "special
 *      operations" such as readline history support, shell escapes,
 *      etc. invisibly to the caller.  Note that the returned BUFFER
 *      will be at most LENGTH-1 chars long because the last char will
 *      always be the nul character.
 *
 *      If the command begins with ESC_CHAR then it's an interpreter
 *      escape command; call ti_escape() with the rest of the line,
 *      then ask for another command.
 *
 * Notes:
 *      May print the STATUS buffer more than once if necessary (i.e.,
 *      a shell escape messed up the screen, a history listing was
 *      generated, etc.).
 */
int
scr_getline A3( const char *, prompt,
                int,          length,
                char *,       buffer )
{
    const char *pp;
    const char *esc_str = ESC_CHAR;
    int i;

    for (;;)
    {
        scr_lineco = 0;

        /*
         * Print all the prompt except the last line
         */
        pp = scr_putbuf(stdout, PB_PROMPT, prompt);

        i = scr_getstr(pp, length, buffer);

        if (!i || (*buffer != *esc_str))
            break;

        ti_escape(&buffer[1]);
    }

    if (F2_IS_SET(B_SCRIPTING))
    {
        pp = scr_putbuf(scr_fp, PB_NO_PAGING|PB_PROMPT, prompt);
        fputs(pp, scr_fp);
        scr_putbuf(scr_fp, PB_NO_PAGING, buffer);
    }

    return (i);
}


/*
 * Function:    scr_window()
 *
 * Arguments:
 *      size      - 0 to delete, non-0 means create with SIZE.
 *
 * Description:
 *      Causes a status window to be created if supported by the
 *      terminal interface; note this function won't be called unless
 *      F1_SETB(B_STATUS_WIN) is invoked in scr_begin().
 *
 * Notes:
 */
void
scr_window A1(int, size)
{
}


/*
 * Function:    scr_set_win()
 *
 * Arguments:
 *      win       - 0==select text window, 1==select status window
 *
 * Description:
 *      Selects a different window.  This function won't be called
 *      unless call F1_SETB(B_STATUS_WIN) in scr_begin().
 *
 * Notes:
 */
void
scr_set_win A1(int, win)
{
}


/*
 * Function:    scr_open_sf()
 *
 * Arguments:
 *      length    - total size of BUFFER
 *      buffer    - buffer to return nul-terminated filename in
 *      type      - SF_SAVE     opening the file to save into
 *                  SF_RESTORE  opening the file to restore from
 *                  SF_SCRIPT   opening a file for scripting
 *
 * Returns:
 *      FILE* - reference to the opened file, or
 *      NULL  - errno==0: operation cancelled, else error opening file
 *
 * Description:
 *      Obtains the name of the file to be opened for writing (if
 *      TYPE==SF_SAVE or SF_SCRIPT) or reading (if TYPE==SF_RESTORE),
 *      opens the file with fopen(), and returns the FILE*.
 *
 *      The name of the file should be stored in BUFFER.  Upon initial
 *      calling BUFFER contains a possible default filename.
 *
 *      if LENGTH==0 then don't ask the user for a name, just use
 *      BUFFER.  This means, for example, we got the -r option to
 *      restore the file.
 *
 *      If the fopen() fails just return NULL: if errno!=0 then an
 *      error will be printed.
 *
 * Notes:
 *      History is turned off here (why would anyone want it?)
 */
FILE *
scr_open_sf A3( int, length, char *, buffer, int, type )
{
#define FN_PROMPT       "Filename (or q)"
#define MAX_PATH        1024

    FILE *fp;
    char prompt[MAX_PATH+sizeof(FN_PROMPT)+6];
    char *cp, *p;
    int len;

    if (length == 0)
    {
        errno = 0;
        return (fopen(buffer,
                      type==SF_RESTORE ? "rb" : type==SF_SAVE ? "wb" : "w"));
    }

    cp = xmalloc(length);

 retry:
    scr_lineco=0;

    sprintf(prompt, "%s [%s] ? ", FN_PROMPT, buffer);

    len = scr_getstr(prompt, length, cp);

    /*
     * Remove any excess whitespace from the end of the string.
     * If the input is really empty, then use the initial buffer.
     * If not copy over the string into the buffer.
     */
    for (p = &cp[len-1]; len && isspace(*p); --len, --p)
    {}
    p[1] = '\0';

    fp = NULL;
    errno = 0;

    if ((len == 1) && (cp[0] == 'q'))
        goto done;

    if (len)
        strcpy(buffer, cp);

    len = strlen(buffer);

    /*
     * Open the file for reading.  If we're saving and it already
     * exists then ask if the user wants to overwrite it.  If not then
     * ask for another name.
     */
    if (len)
    {
        fp = fopen(buffer, "rb");
        if (type != SF_RESTORE)
        {
            if (fp != NULL)
            {
                char over_p[MAX_PATH+40];

                fclose(fp);
                sprintf(over_p,
                        "File `%s' exists: overwrite (y/n/q)[y]? ",
                        buffer);

                if (scr_getstr(over_p, length, cp))
                    if (cp[0] == 'q')
                    {
                        fp = NULL;
                        goto done;
                    }
                    else if (cp[0] != 'y')
                        goto retry;
            }

            fp = fopen(buffer, type==SF_SAVE ? "wb" : "w");
        }
    }

 done:
    free(cp);

    if (type == SF_SCRIPT)
        scr_fp = fp;

    return (fp);
}


/*
 * Function:    scr_close_sf()
 *
 * Arguments:
 *      filenm    - name of file just processed
 *      fp        - FILE* to open saved file
 *      type      - SF_SAVE     closing a saved game file
 *                  SF_RESTORE  closing a restored game file
 *                  SF_SCRIPT   closing a scripting file
 *
 * Description:
 *      This function will be called immediately after a successful
 *      save or restore of a game file, so that if the interface needs
 *      to perform any actions related to the saved game it may.  It
 *      will also be called when the interpreter notices that
 *      scripting has been turned off.  It should at least close the
 *      file.
 *
 *      This function will only be called if the save/restore of the
 *      game succeeded; if it fails the file will be closed by the
 *      interpreter.
 */
void
scr_close_sf A3( const char *, filenm, FILE *, fp, int, type )
{
    fclose(fp);
}
