/* termcap.c
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
 * $Header: RCS/termcap.c,v 3.0 1992/10/21 16:56:19 pds Stab $
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
 * Terminal Capability Setup --
 *
 * Set up the terminal capability style to use.  Possibilities are
 * TERMCAP, which almost every UNIX system has or TERMINFO, which
 * newer systems have.
 *
 * Terminal capability is used to move the cursor around on the screen
 * (to print the status line), to clear the screen, and to turn on and
 * off standout mode(highlighting).
 */
#ifdef USE_TERMCAP
#define TTY_PUT(_s)         tputs(_s,1,scr_putp)
#define TTY_GOTO(_s,_c,_r)  tgoto(_s,_c,_r)
#define TTY_PARM(_s,_1,_2)  tgoto(_s,_2,_1)

/*
 * In newer systems these are defined in <term.h>, but I got a number
 * of reports that many UNIX systems don't have a <term.h>, so I
 * removed the #include and declare them here...
 */
extern int tgetent P((char*, char*));
extern int tgetnum P((char*));
extern int tputs P((char*, int, int(*) P((int))));
extern char *tgoto P((char*, int, int));
extern int ioctl P((int, int, ...));

static int
scr_putp A1(int, c)
{
    return (putchar(c));
}
#endif


#ifdef USE_TERMINFO
#include <curses.h>
#include <term.h>

#define TTY_PUT(_s)         putp(_s)
#define TTY_GOTO(_s,_c,_r)  tparm(_s,_r,_c)
#define TTY_PARM(_s,_1,_2)  tparm(_s,_1,_2)

extern int ioctl P((int, int, ...));
#endif

/*
 * Line Discipline Setup --
 *
 * Set up the line discipline to use.  TERMIOS is for POSIX-compliant
 * systems, TERMIO is for SysVR3 and SysVR4 systems, and SGTTY is for
 * BSD systems.  If none of these are set, then no line discipline
 * manipulation is done.  The only thing line discipline is used for
 * is for waiting for a character in "--More--" mode without printing
 * it or waiting for a newline to read it.
 */
#ifdef USE_TERMIOS
#include <termios.h>

#define TTY_TYPE        struct termios
#define TTY_GET(_t)     tcgetattr(1, _t)
#define TTY_SET(_t)     tcsetattr(1, TCSANOW, _t)
#endif


#ifdef USE_TERMIO
#include <termio.h>

#define TTY_TYPE        struct termio
#define TTY_GET(_t)     ioctl(1, TCGETA, _t)
#define TTY_SET(_t)     ioctl(1, TCSETA, _t)
#endif


#ifdef USE_SGTTY
#include <sgtty.h>

#define TTY_TYPE        struct sgttyb
#define TTY_GET(_t)     gtty(1, _t)
#define TTY_SET(_t)     stty(1, _t)
#endif


#ifndef TTY_TYPE
#define TTY_TYPE        int
#define TTY_GET(_t)
#define TTY_SET(_t)
#endif

extern char *getenv();

/*
 * Global variables:
 */
#ifndef USE_READLINE

const char *scr_opt_list    = "";
const char *scr_usage       = "";
const char *scr_long_usage  = NULL;

#else

extern int tcrl_cmdarg P((int, char ***));
extern void tcrl_getopt P((int, const char *));
extern void tcrl_begin P((void));
extern void tcrl_end P((void));
extern void tcrl_pr_escape P((void));
extern int scr_getstr P((const char *prompt,
                         int length,
                         char *buffer,
                         Bool is_filenm));

const char *scr_opt_list    = "H:C:";
const char *scr_usage       = "[-H file] [-C file]";
const char *scr_long_usage  = "\
\t-H file\tread/store command history in file\n\
\t-C file\tread/store user command completions in file\n";

#endif


/*
 * Local variables:
 */
#define ENV_FLAGS       "PI_FLAGS"

#define CLREOL  (0)                         /* Clear to EOL */
#define CLRSCR  (1)                         /* Clear screen */
#define CURMOV  (2)                         /* Move cursor to position */
#define HOME    (3)                         /* Home cursor */
#define LOWLEF  (4)                         /* Mover cursor to lower-left */
#define STDON   (5)                         /* Begin standout mode */
#define STDOFF  (6)                         /* End standout mode */
#define TERMON  (7)                         /* Begin termcap mode */
#define TERMOFF (8)                         /* End termcap mode */
#define SETSCRL (9)                         /* Set the scrolling region */
#define MAX_OPS (10)


static FILE *scr_fp=NULL;

static char *ops[MAX_OPS] = { "", "", "", "", "", "", "", "", "", "" };
static char tbuffer[200];

static int scr_columns=80, scr_indent=0, stat_size=0, scr_width=80;
static int scr_lines=24, scr_lineco=0, scr_lowleft=23;

static Bool allow_status=1, in_status=0;


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
 *      done.  If the interface needs to insert any interpreter
 *      options into the command-line list then they should be added
 *      here; otherwise the function should do nothing.  The should be
 *      added between (*argvp)[0] and (*argvp)[1].  Note that
 *      (*argvp)[0] must be the command name and (*argvp)[argc] must
 *      be a null pointer.
 *
 * Notes:
 */
int
scr_cmdarg A2(int, argc, char ***, argvp)
{
    char *envp;

    /*
     * If we find an ENV_FLAGS environment variable then add the flags
     * into the command line.
     */
    if ((envp = getenv(ENV_FLAGS)) != NULL)
    {
        char **newv;
        char *cp;
        int i, newc=0;

        /*
         * Count the number of args in the cmd line
         */
        cp = envp;
        do
        {
            while ((*cp != '\0') && isspace(*cp))
                ++cp;

            if (*cp != '\0')
                ++newc;

            while ((*cp != '\0') && !isspace(*cp))
                ++cp;
        }
        while (*cp != '\0');

        /*
         * Allocate enough space for the old and new args
         */
        newv = (char **)xmalloc(sizeof(char *) * (argc+newc+1));
        argc += newc;

        /*
         * Copy the arguments into their proper places.
         */
        newv[0] = (*argvp)[0];
        for (i=1, cp=envp; i<=newc; ++i)
        {
            while ((*cp != '\0') && isspace(*cp))
                ++cp;

            newv[i] = cp;

            while ((*cp != '\0') && !isspace(*cp))
                ++cp;
            *(cp++) = '\0';
        }

        for (; i<argc; ++i)
            newv[i] = (*argvp)[i-newc];
        newv[i] = NULL;

        *argvp = newv;
    }

#ifdef USE_READLINE
    argc = tcrl_cmdarg(argc, argvp);
#endif

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
#ifdef USE_READLINE
    tcrl_getopt(c, arg);
#endif
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
    char *term, termbuf[1024];

    if ((term = getenv("TERM")) == NULL)
    {
        term = "dumb";
    }

#ifdef USE_TERMCAP
    if (tgetent(termbuf, term) == 1)
    {
        extern char *tgetstr P((char*, char**));
        char *cp = tbuffer;

        if (((ops[STDON] = tgetstr("so", &cp)) == NULL) ||
           ((ops[STDOFF] = tgetstr("se", &cp)) == NULL))
            ops[STDON] = ops[STDOFF] = "";

        if (((ops[TERMON] = tgetstr("ti", &cp)) == NULL) ||
           ((ops[TERMOFF] = tgetstr("te", &cp)) == NULL))
            ops[TERMON] = ops[TERMOFF] = "";

        if ((ops[CLRSCR] = tgetstr("cl", &cp)) == NULL) ops[CLRSCR] = "";
        if ((ops[CLREOL] = tgetstr("ce", &cp)) == NULL) ops[CLREOL] = "";
        if ((ops[CURMOV] = tgetstr("cm", &cp)) == NULL) ops[CURMOV] = "";
        if ((ops[HOME]   = tgetstr("ho", &cp)) == NULL) ops[HOME] = "";
        if ((ops[LOWLEF] = tgetstr("ll", &cp)) == NULL) ops[LOWLEF] = "";
        if ((ops[SETSCRL]= tgetstr("cs", &cp)) == NULL) ops[SETSCRL] = "";

        if ((scr_lines = tgetnum("li")) == -1) scr_lines=24;
        if ((scr_columns = tgetnum("co")) == -1) scr_columns=80;
    }
#endif

#ifdef USE_TERMINFO
    setupterm(term, 1, NULL);

    if (((ops[STDON] = tigetstr("smso")) == NULL) ||
       ((ops[STDOFF] = tigetstr("rmso")) == NULL))
        ops[STDON] = ops[STDOFF] = "";

    if ((ops[CLRSCR] = tigetstr("clear")) == NULL)  ops[CLRSCR] = "";
    if ((ops[CLREOL] = tigetstr("el")) == NULL)     ops[CLREOL] = "";
    if ((ops[CURMOV] = tigetstr("cup")) == NULL)    ops[CURMOV] = "";
    if ((ops[HOME]   = tigetstr("home")) == NULL)   ops[HOME] = "";
    if ((ops[LOWLEF] = tigetstr("ll")) == NULL)     ops[LOWLEF] = "";
    if ((ops[SETSCRL]= tigetstr("csr")) == NULL)    ops[SETSCRL] = "";

    ops[TERMON] = enter_ca_mode;
    ops[TERMOFF] = exit_ca_mode;
    scr_lines = lines;
    scr_columns = columns;
#endif

    /*
     * We must have either CURMOV or both HOME and LOWLEF in order to
     * do status lines.  Since the pr_status flag can be changed, keep
     * a local note that we can't do them regardless.
     */
    if ((*ops[CURMOV] == '\0')
        && ((*ops[HOME] == '\0') || (*ops[LOWLEF] == '\0')))
    {
        gflags.pr_status = 0;
        allow_status = 0;
    }

    scr_columns -= margin + indent;
    scr_width -= margin + indent;
    scr_lowleft = scr_lines - 1;

    if (scr_sz)
        scr_lines = scr_sz;

    scr_lines  -= context + (*ops[SETSCRL] != '\0') + 2;
    scr_lineco -= context + (*ops[SETSCRL] != '\0') - 1;
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
    TTY_PUT(ops[TERMON]);
    TTY_PUT(ops[CLRSCR]);

    /*
     * If we have scrolling regions then set it and tell the
     * interpreter we can handle status windows.
     */
    if (*ops[SETSCRL])
    {
        TTY_PUT(TTY_PARM(ops[SETSCRL], 1, scr_lowleft));
        F1_SETB(B_STATUS_WIN);
    }

    if (*ops[LOWLEF])
        TTY_PUT(ops[LOWLEF]);
    else if (*ops[CURMOV])
        TTY_PUT(TTY_GOTO(ops[CURMOV], 0, scr_lowleft));
    else
        putchar('\n');

#ifdef USE_TERMINFO
    reset_prog_mode();
#endif

#ifdef USE_READLINE
    tcrl_begin();
#endif
}


static void
scr_wait A1(const char *, prompt)
{
    TTY_TYPE orig;
    TTY_TYPE new;
    const char *outp = "\b \b";
    const char *cp;

    /*
     * Print the prompt,  flush the current input buffer of any
     * typeahead (hopefully :-)
     */
    TTY_PUT(ops[STDON]);

    for (cp = prompt; *cp != '\0'; ++cp)
        putchar(*cp);

    TTY_PUT(ops[STDOFF]);

    setbuf(stdin, NULL);

    /*
     * Store the current terminal settings, then set up for no echo,
     * one char at a time read.
     */
    TTY_GET(&orig);
    new = orig;

#ifdef USE_SGTTY
    new.sg_flags |= CBREAK;
    new.sg_flags &= ~ECHO;
#endif
#if defined(USE_TERMIO) || defined(USE_TERMIOS)
    new.c_lflag &= ~ICANON;
    new.c_lflag &= ~ECHO;
    new.c_cc[VMIN] = 1;
    new.c_cc[VTIME] = 0;
#endif

    signal(SIGINT, SIG_IGN);
    TTY_SET(&new);

    /*
     * Wait for a char...
     */
    getchar();

    /*
     * Erase the prompt, reset the terminal, blah blah blah... we
     * erase the prompt by using backspace/space/backspace chars
     * instead of clear EOL or something because it's safer...
     */
    for (; *outp != '\0'; ++outp)
    {
        for (cp = prompt; *cp != '\0'; ++cp)
        {
            putchar(*outp);
        }
    }

    TTY_SET(&orig);
    signal(SIGINT, askq);
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
#ifdef USE_READLINE
    tcrl_end();
#endif

    /*
     * Some games exit without giving you a chance to read the last
     * few lines, so we ask the user to type a char before we clear
     * the screen...
     */
    scr_wait("--End--");

    if (*ops[SETSCRL])
        TTY_PUT(TTY_PARM(ops[SETSCRL], 0, scr_lowleft));

#ifdef USE_TERMINFO
    TTY_PUT(ops[CLRSCR]);
#endif

    if (*ops[LOWLEF])
        TTY_PUT(ops[LOWLEF]);
    else if (*ops[CURMOV])
        TTY_PUT(TTY_GOTO(ops[CURMOV], 0, scr_lowleft));
    else
        putchar('\n');

#ifdef USE_TERMINFO
    reset_shell_mode();
#endif

    TTY_PUT(ops[TERMOFF]);
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
scr_putbuf A4( FILE *, fp, int, flags, const char *, buf, int, max )
{
    const char *sp;
    const char *ep;

    for (sp = buf; ;)
    {
        ep = chop_buf(sp, max);

        if ((*ep != '\0') || !(flags & PB_PROMPT))
        {
            const char *p;
            int i;

            if (!(flags & PB_NO_PAGING) && (scr_lineco++ >= scr_lines))
            {
                scr_wait("--More--");
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
    scr_putbuf(stdout, in_status || !gflags.paged, buffer, scr_columns);

    if (F2_IS_SET(B_SCRIPTING))
        scr_putbuf(scr_fp, 1, buffer, scr_width);
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
    if (allow_status && gflags.pr_status)
    {
        extern char *ti_location;
        extern char *ti_status;

        char    *ptr;
        int     i;

        /*
         * Go to the "home" position (top left corner) then clear to
         * the EOL, then go into reverse video mode.
         */
        if (*ops[HOME])
            TTY_PUT(ops[HOME]);
        else if (*ops[CURMOV])
            TTY_PUT(TTY_GOTO(ops[CURMOV], 0, 0));
        else
            putchar('\n');

        TTY_PUT(ops[CLREOL]);
        TTY_PUT(ops[STDON]);

        for (ptr = ti_location; *ptr != '\0'; ++ptr)
            putchar(*ptr);

        i = scr_columns+scr_indent - strlen(ti_location) - strlen(ti_status);
        for (; i > 0; --i)
            putchar(' ');

        for (ptr = ti_status; *ptr != '\0'; ++ptr)
            putchar(*ptr);

        /*
         * Turn of reverse video, then jump back down to the
         * lower left corner of the screen.
         */
        TTY_PUT(ops[STDOFF]);
        if (*ops[LOWLEF])
            TTY_PUT(ops[LOWLEF]);
        else if (*ops[CURMOV])
            TTY_PUT(TTY_GOTO(ops[CURMOV], 0, scr_lowleft));
        else
            putchar('\n');
    }
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


#ifndef USE_READLINE
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
scr_getstr A4( const char *, prompt,
               int, length,
               char *, buffer,
               Bool, is_filenm )
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
#endif


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
    extern int  system P((const char *));

    const char *pp;
    int len;

    /*
     * Loop until we've read a line.  Note that shell commands don't
     * count, so if we get one then read another line.
     */
    for (;;)
    {
        /*
         * Print all the prompt except the last line
         */
        pp = scr_putbuf(stdout, PB_PROMPT, prompt, scr_columns);

        scr_putscore();
        scr_lineco=0;

        buffer[0] = '\0';
        buffer[length-1] = '\0';
        buffer[length-2] = '\0';

        if ((len = scr_getstr(pp, length, buffer, 0)) == -1)
            continue;

        if (!len)
            break;

        /*
         * If it's an interpreter escape, call the function then try
         * again.
         */
        if (buffer[0] == ESC_CHAR[0])
        {
            ti_escape(&buffer[1]);
#ifdef USE_READLINE
            if (len == 1)
                tcrl_pr_escape();
#endif
            scr_putscore();
            continue;
        }

#ifdef NO_SHELL_ESC
        break;
#else
        /*
         * If it's not a shell escape, we've got a valid string so
         * quit.
         */
        if (buffer[0] != '!')
        {
            break;
        }

        /*
         * Otherwise execute the shell command: if no command was
         * given invoke the user's $SHELL (or /bin/sh if $SHELL is not
         * found).
         */
        if (len == 1)
        {
            char *cp;

            strncpy(&buffer[1],
                    (cp=getenv("SHELL"))==0 || *cp=='\0' ? "/bin/sh" : cp,
                    length-2);
        }

#ifdef USE_TERMINFO
        reset_shell_mode();
        TTY_PUT(ops[TERMOFF]);
#endif

        system(&buffer[1]);

#ifdef USE_TERMINFO
        TTY_PUT(ops[TERMON]);
        reset_prog_mode();
#endif
        putchar('\n');

#endif  /* !NO_SHELL_ESC */
    }

    if (F2_IS_SET(B_SCRIPTING))
    {
        pp = scr_putbuf(scr_fp, PB_NO_PAGING|PB_PROMPT, prompt, scr_width);
        fputs(pp, scr_fp);
        scr_putbuf(scr_fp, PB_NO_PAGING, buffer, scr_width);
    }

    return (len);
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
    char *p;
    int i;

    if (!size)
    {
        if (!stat_size)
            return;

        scr_lines += stat_size;
        stat_size = 0;

        p = TTY_PARM(ops[SETSCRL], 1, scr_lowleft);
        TTY_PUT(p);
        scr_set_win(0);

        return;
    }

    stat_size = size;
    scr_lines -= stat_size;
    p = TTY_PARM(ops[SETSCRL], stat_size+1, scr_lowleft);
    TTY_PUT(p);

    /*
     * Clean out the window
     */
    scr_set_win(1);
    for (i=stat_size; i>0; --i)
    {
        if (*ops[CLREOL])
            TTY_PUT(ops[CLREOL]);
        else
        {
            int j;

            for (j=scr_columns; j>0; --j)
                putchar(' ');
        }
        putchar('\n');
    }
    scr_set_win(0);
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
    /*
     * Select the status window; just move the cursor there
     */
    if (win)
    {
        in_status = 1;

        if (*ops[CURMOV])
            TTY_PUT(TTY_GOTO(ops[CURMOV], 0, 1));
        else if (*ops[HOME])
        {
            TTY_PUT(ops[HOME]);
            putchar('\n');
        }
    }
    else
    {
        in_status = 0;

        if (*ops[LOWLEF])
            TTY_PUT(ops[LOWLEF]);
        else if (*ops[CURMOV])
            TTY_PUT(TTY_GOTO(ops[CURMOV], 0, scr_lowleft));
    }
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

    FILE *fp;
    char prompt[MAXPATHLEN+sizeof(FN_PROMPT)+6];
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
    scr_putscore();
    scr_lineco=0;

    sprintf(prompt, "%s [%s] ? ", FN_PROMPT, buffer);

    len = scr_getstr(prompt, length, cp, 1);

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
                char over_p[MAXPATHLEN+40];

                fclose(fp);
                sprintf(over_p,
                        "File `%s' exists: overwrite (y/n/q)[y]? ",
                        buffer);

                if (scr_getstr(over_p, 81, cp, 1))
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
