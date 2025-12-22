/* msdos.c
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
 * $Header: RCS/msdos.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>

#include <signal.h>
#include <conio.h>
#include <dos.h>

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
 * Variable:	scr_usage
 *
 * Description:
 *	This variable should contain a usage string for any extra
 *	command-line options available through this terminal
 *	interface.
 */
const char *scr_usage	    = "[-C]";

/*
 * Variable:	scr_long_usage
 *
 * Description:
 *	This variable should contain a more verbose usage string
 *	detailing the command-line options available through this
 *	terminal interface, one option per line.
 */
const char *scr_long_usage = "\t-C\tdon't use color";

/*
 * Variable:	scr_opt_list
 *
 * Description:
 *	This variable should contain a getopt(3)-style option list for
 *	any command-line options available through this terminal
 *	interface.
 */
const char *scr_opt_list    = "C";

/*
 * Local Variables
 */
#define ENV_FLAGS	"PI_FLAGS"

/*
 * Options to use standard I/O, allowing redirection to/from files/devices.
 * Using stream output means we can't set scroll windows.  Using stream input
 * means we use DOS's command line editor for input and can't properly erase
 * --More-- prompts.
 */
/* #define STREAM_OUT */
/* #define STREAM_IN */

static FILE *scr_fp=NULL;

static int scr_columns=80, scr_indent=0, stat_size=0;
static int scr_lines=24, scr_lineco=0, scr_lowleft=24;
static int scr_width=80, scr_height=24;

static Bool in_status=0, allow_color=1, use_color=1;



#ifdef STREAM_OUT
#define outstr(s)	fputs(s, stdout)
#define outchar(c)	putchar(c)
#else
#define outstr(s)	cputs(s)
#define outchar(c)	putch(c)
#endif
#define newline()	outchar('\r'),outchar('\n')


#if defined(STREAM_OUT) || !defined(__TURBOC__)
/*
 * The following functions produce ANSI codes to produce generic video
 * effects.
 */

void
term_clreol()
{
    outstr("\033[k");
}

void
term_clrscr()
{
    outstr("\033[2J");
}

void
term_home()
{
    outstr("\033[H");
}

void
term_lowleft()
{
    printf("\033[%d;0H", scr_lowleft);
}

#define term_statwin()

/*
 * In the future, color should be a command line option, and perhaps
 * specific color settings.
 *
 * Some ANSI SGR parameters:
 *	 0  reset
 *	 1  bold
 *	 5  blink
 *	 7  reverse
 *	3x  foreground color
 *	4x  background color
 *	    (0-7: black/red/green/yellow/blue/magenta/cyan/white)
 */

void
term_text_color()
{
    /* white on blue, or reset (to white on black) */
    outstr(use_color ? "\033[0;37;44m" : "\033[0m");
}

void
term_score_color()
{
    /* red on white, or reverse video (black on white) */
    outstr(use_color ? "\033[31;47m" : "\033[7m");
}

#define term_wait_color() term_score_color()

void
term_status_color()
{
    /* white on green, or on black */
    outstr(use_color ? "\033[1;42m" : "\033[1m");
}

void
term_mesg_color()
{
    /* bold red, or just bold (white) */
    outstr(use_color ? "\033[1;31m" : "\033[1m");
}

void
term_input_color()
{
    /* yellow on blue */
    if (use_color)
	outstr("\033[1;33;44m");
}

void
term_termoff()
{
    if (use_color)
	outstr("\033[0m");
}

#define term_termon()

#define term_setscrl(t, b)

#else /* use convenient Turbo C library functions */

#define term_clreol()	clreol()
#define term_clrscr()	clrscr()

void
gotoxy A2(int, col, int, row)
/*
 * Note:
 *	If we used the Turbo C library function, the row and column would be
 *	window relative, but we want absolute.
 */
{
    union REGS regs;

    /* Set Cursor Position */
    regs.x.ax = 0x0200;
    regs.x.bx = 0;
    regs.h.dh = --row;
    regs.h.dl = --col;
    int86(0x10,&regs,&regs);
}

#define term_home()	gotoxy(1,1)
#define term_lowleft()	gotoxy(1,scr_lowleft)

void
term_text_color()
{
    textcolor(LIGHTGRAY);
    textbackground(use_color ? BLUE : BLACK);
}

void
term_score_color()
{
    textcolor(use_color ? RED : BLACK);
    textbackground(LIGHTGRAY);
}

#define term_wait_color() term_score_color()

void
term_status_color()
{
    textcolor(WHITE);
    textbackground(use_color ? GREEN : BLACK);
}

void
term_mesg_color()
{
    textcolor(use_color ? LIGHTRED : WHITE);
}

void
term_input_color()
{
    if (use_color)
	textcolor(YELLOW);
}

void
term_termoff()
{
    textcolor(LIGHTGRAY);
    textbackground(BLACK);
}

#define term_termon()

void
term_setscrl A2(int, top, int, bottom)
{
    window(1, ++top, scr_width, ++bottom);
}

#endif


/*
 * Function:	get_scr_info()
 *
 * Arguments:
 *	rows	    pointer to number of rows variable
 *	cols	    pointer to number of columns variable
 *	color_mode  pointer to boolean in-color variable
 *
 * Description:
 *	This function does the nasty platform-specific BIOS calls to
 *	determine the screen mode and dimensions.  int86() is common
 *	to MS-DOS compilers including MSC and Turbo C.
 */
void
get_scr_info A3(int *, rows, int *, cols, Bool *, color_mode)
{
    union REGS regs;

    /* load default row count, in case no EGA or better */
    regs.h.dl = 24;

    /* Get Font Information, current font - returns rows in DL */
    regs.x.bx = 0;
    regs.x.ax = 0x1130;
    int86(0x10,&regs,&regs);

    /* Get Video Mode - returns columns in AH, mode in AL */
    regs.h.ah = 0x0f;
    int86(0x10,&regs,&regs);

    /* if mode is BW 40x25, BW 80x25, or mono 80x25 */
    *color_mode = !(regs.h.al == 0 || regs.h.al == 2 || regs.h.al == 7);

    /* store row/column counts */
    *rows = regs.h.dl + 1;
    *cols = regs.h.ah;
}


/*
 * Function:	scr_cmdarg()
 *
 * Arguments:
 *	argc	    number of original arguments
 *	argvp	    pointer to array of strings containing args
 *
 * Returns:
 *	New number of arguments.
 *
 * Description:
 *	This function is called before any command line parsing is
 *	done.  If the interface needs to insert any interpreter
 *	options into the command-line list then they should be added
 *	here; otherwise the function should do nothing.  They should be
 *	added between (*argvp)[0] and (*argvp)[1].  Note that
 *	(*argvp)[0] must be the command name and (*argvp)[argc] must
 *	be a null pointer.
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

    return (argc);
}


/*
 * Function:	scr_getopt()
 *
 * Arguments:
 *	c	    option found
 *	arg	    option argument (if requested)
 *
 * Description:
 *	This function is called whenever a command-line option
 *	specified in scr_opt_list (above) is found on the command
 *	line.
 */
void
scr_getopt A2(int, c, const char *, arg)
{
    use_color = 0;
}


/*
 * Function:	scr_setup()
 *
 * Arguments:
 *	margin	    # of spaces in the right margin.
 *	indent	    # of spaces in the left margin.
 *	scr_sz	    # of lines on the screen.
 *	context     # of lines of context to keep when scrolling
 *
 * Returns:
 *	Width of screen output for informational printing (not used if
 *	game is to be played).
 *
 * Description:
 *	This function should set up generic items in the screen
 *	interface that may need to be done before *any* output is
 *	done.
 *
 *	If SCR_SZ is not 0, then this function must use SCR_SZ as the
 *	number of lines the screen can hold at once, no matter what it
 *	may infer otherwise.  If SCR_SZ is 0, then the function must
 *	figure the size of the screen as best it can.
 *
 * Notes:
 *	Any terminal initialization needed only for actually playing
 *	the game should go in scr_begin(), not here.
 */
int
scr_setup A4( int, margin,
	      int, indent,
	      int, scr_sz,
	      int, context )
{
#ifdef __TURBOC__
    directvideo = 0;	/* use BIOS for output */
#endif

    get_scr_info(&scr_height, &scr_width, &allow_color);

    if (!allow_color)
	use_color = 0;

    scr_columns = scr_width;
    scr_columns -= margin + indent;
    scr_lines = scr_height;

    if (scr_sz)
	scr_lines = scr_sz;

    scr_lowleft = scr_lines;
#ifndef STREAM_OUT
    scr_lines  -= context + 3;
    scr_lineco -= context;
#else
    scr_lines  -= context + 2;
    scr_lineco -= context - 1;
#endif
    scr_indent  = indent;

    return (scr_columns);
}


/*
 * Function:	scr_shutdown()
 *
 * Description:
 *	This function will be called just before we exit.
 */
void
scr_shutdown()
{
}


/*
 * Function:	scr_begin()
 *
 * Arguments:
 *	game	The game datafile we're about to execute.
 *
 * Description:
 *	This function should perform terminal initializations we need
 *	to actually play the game.
 */
void
scr_begin()
{
    term_termon();
    term_text_color();
    term_clrscr();

#ifndef STREAM_OUT
    /*
     * Since we have scrolling, tell the interpreter
     * we can handle status windows.
     */
    term_setscrl(gflags.pr_status ? 1 : 0, scr_lowleft-1);
    F1_SETB(B_STATUS_WIN);
#endif

    term_lowleft();
}


static void
scr_wait A1(const char *, prompt)
{
    const char *outp = "\b \b";
    const char *cp;

    /*
     * Print the prompt,  flush the current input buffer of any
     * typeahead (hopefully :-)
     */
    term_wait_color();

    outstr(prompt);

    term_text_color();

    setbuf(stdin, NULL);

    /*
     * Get one character from keyboard, don't echo to screen.
     * If character is '\0', get extended keystroke.
     */
#ifdef STREAM_IN
    if (!fgetc(stdin)) fgetc(stdin);
#else
    if (!getch()) getch();

    /*
     * Erase the prompt, reset the terminal, blah blah blah... we
     * erase the prompt by using backspace/space/backspace chars
     * instead of clear EOL or something because it's safer...
     */
    for (; *outp != '\0'; ++outp)
    {
	for (cp = prompt; *cp != '\0'; ++cp)
	{
	    outchar(*outp);
	}
    }
#endif
}


/*
 * Function:	scr_end()
 *
 * Description:
 *	This function will be called after the last line is printed
 *	but before we exit, *only* if scr_begin() was called (*not* if
 *	just scr_startup() was called!)
 */
void
scr_end()
{
    /*
     * Some games exit without giving you a chance to read the last
     * few lines, so we ask the user to type a char before we clear
     * the screen...
     */
#ifdef PAUSE_AT_END
    scr_wait("--End--");
#endif

    term_setscrl(0, scr_height-1);
    term_lowleft();
    term_termoff();
}


/*
 * This is an internal function to print a buffer.  If flags==0 then
 * print with paging and a final newline.  If flags & 1 then print
 * without paging.  If flags & 2 then print up to but not including
 * the last lineful, and return a pointer to it (a prompt).
 */
#define PB_NO_PAGING	(0x01)
#define PB_PROMPT	(0x02)

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

#ifdef STREAM_OUT
#define scr_putcon(flags, buf, max)	str_putbuf(stdout, flags, buf, max)
#else
static const char *
scr_putcon A3( int, flags, const char *, buf, int, max )
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
		outchar(' ');

	    for (p = sp; p < ep; ++p)
		outchar(*p);

	    newline();
	}

	if (*ep == '\0')
	    break;

	sp = ep + 1;
    }

    return (sp);
}
#endif

/*
 * Function:	scr_putline()
 *
 * Arguments:
 *	buffer		Line to be printed.
 *
 * Description:
 *	This function is passed a nul-terminated string and it should
 *	display the string on the terminal.  It will *not* contain a
 *	newline character.
 *
 *	This function should perform whatever wrapping, paging, etc.
 *	is necessary, print the string, and generate a final linefeed.
 *
 *	If the TI supports proportional-width fonts,
 *	F2_IS_SET(B_FIXED_FONT) should be checked as appropriate.
 *
 *	If the TI supports scripting, F2_IS_SET(B_SCRIPTING) should be
 *	checked as appropriate.
 */
void
scr_putline A1(const char *, buffer)
{
    scr_putcon(in_status || !gflags.paged, buffer, scr_columns);

    if (F2_IS_SET(B_SCRIPTING))
	scr_putbuf(scr_fp, 1, buffer, scr_width);
}


/*
 * Function:	scr_putscore()
 *
 * Description:
 *	This function prints the ti_location and ti_status strings
 *	if it can and if status line printing is enabled.
 */
void
scr_putscore()
{
    if (gflags.pr_status)
    {
	extern char *ti_location;
	extern char *ti_status;

	int	i;

	/*
	 * Go to the "home" position (top left corner) then clear to
	 * the EOL, then go into reverse video mode.
	 */
	term_home();
	term_score_color();
	term_clreol();

	outstr(ti_location);

	i = scr_columns+scr_indent - strlen(ti_location) - strlen(ti_status);
	for (; i != 0; --i)
	    outchar(' ');

	outstr(ti_status);

	/*
	 * Turn off reverse video, then jump back down to the
	 * lower left corner of the screen.
	 */
	term_text_color();
	term_lowleft();
    } else if (stat_size) {
        /*
	 * Leave an empty line where the status line would be.
	 */
	term_home();
	term_score_color();
	term_clreol();
	term_text_color();
	term_lowleft();
    }
}


/*
 * Function:	scr_putsound()
 *
 * Arguments:
 *	number	    sound number to play
 *	action	    action to perform
 *	volume	    volume to play sound at
 *	argc	    number of valid arguments
 *
 * Description:
 *	This function plays the sound specified if it can; if not it
 *	prints a line to that effect.
 *
 *	If the `argc' value is 1, then the we play `number' of beeps
 *	(usually the ^G character).
 *
 *	If `argc' >1, the `action' argument is used as follows:
 *
 *	    2:	play sound file
 *	    3:	stop playing sound file
 *	    4:	free sound resources
 *
 *	If `argc' >2, the `volume' argument is between 1 and 8 and is
 *	a volume to play the sound at.
 */
void
scr_putsound A4(int, number, int, action, int, volume, int, argc)
{
    if (argc == 1)
    {
	while (number--)
	    outchar('\a');
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
 * Function:	scr_putmesg()
 *
 * Arguments:
 *	buffer	    message string to be printed.
 *	is_err	    1 if message is an error message, 0 if it's not.
 *
 * Description:
 *	This function prints out a message from the interpreter, not
 *	from the game itself.  Often these are errors (IS_ERR==1)
 *	but not necessarily.
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

    sprintf(buf, "%s%s",
	    is_err ? "ERROR: " : "",
	    buffer);

    term_mesg_color();

    scr_putline("");
    scr_putline(buf);
    scr_putline("");

    term_text_color();
}


/*
 * Function:	scr_getstr()
 *
 * Description:
 *	This is an internal function which performs the meat of
 *	reading a string, throwing away the excess, etc.  It returns
 *	the number of characters read.
 *
 * Notes:
 *	This function is *not* a part of the terminal interface; it's
 *	just an interal helper function.
 */
static int
scr_getstr A4( const char *, prompt,
	       int, length,
	       char *, buffer,
	       Bool, is_filenm )
{
#ifndef STREAM_IN
    outstr(prompt);

    term_input_color();

    buffer[0] = length > 255 ? 253 : length - 2;
    cgets(buffer);

    length = buffer[1];
    strcpy(buffer, &buffer[2]);

    term_text_color();

    newline();
#else
    int c;

    outstr(prompt);

    term_input_color();

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
	term_mesg_color();

	fputs("[Input line too long.  Flushing: `", stdout);
	do
	{
	    outchar(c);
	}
	while (((c = getchar()) != EOF) && (c != '\n'));

	scr_putline("']");
    }
    else
    {
	/*
	 * Punt the last \n...
	 */
	length = strlen(buffer) - 1;
	buffer[length] = '\0';
    }

    term_text_color();
#endif

    return (length);
}


/*
 * Function:	scr_getline()
 *
 * Arguments:
 *	prompt	  - prompt to be printed
 *	length	  - total size of BUFFER
 *	buffer	  - buffer to return nul-terminated response in
 *
 * Returns:
 *	# of chars stored in BUFFER
 *
 * Description:
 *	Reads a line of input and returns it.  Handles all "special
 *	operations" such as readline history support, shell escapes,
 *	etc. invisibly to the caller.  Note that the returned BUFFER
 *	will be at most LENGTH-1 chars long because the last char will
 *	always be the nul character.
 *
 *	If the command begins with ESC_CHAR then it's an interpreter
 *	escape command; call ti_escape() with the rest of the line,
 *	then ask for another command.
 *
 * Notes:
 *	May print the STATUS buffer more than once if necessary (i.e.,
 *	a shell escape messed up the screen, a history listing was
 *	generated, etc.).
 */
int
scr_getline A3( const char *, prompt,
		int,	      length,
		char *,       buffer )
{
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
	pp = scr_putcon(PB_PROMPT, prompt, scr_columns);

	scr_putscore();
	scr_lineco = 0;

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
	    /*
	     * Adjust scroll region in case the status line was toggled.
	     */
	    if (!stat_size) {
		term_setscrl(gflags.pr_status, scr_lowleft-1);
		term_lowleft();
	    }
            scr_putscore();
	    continue;
	}

	break;
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
 * Function:	scr_window()
 *
 * Arguments:
 *	size	  - 0 to delete, non-0 means create with SIZE.
 *
 * Description:
 *	Causes a status window to be created if supported by the
 *	terminal interface; note this function won't be called unless
 *	F1_SETB(B_STATUS_WIN) is invoked in scr_begin().
 */
void
scr_window A1(int, size)
{
#ifndef STREAM_OUT
    int i;

    if (!size)
    {
	if (!stat_size)
	    return;

	scr_lines += stat_size;
	stat_size = 0;

	term_setscrl(gflags.pr_status, scr_lowleft-1);
	scr_set_win(0);

	return;
    }

    stat_size = size;
    scr_lines -= stat_size;
    term_setscrl(stat_size+1, scr_lowleft-1);

    /*
     * Clean out the window
     */
    scr_set_win(1);
    for (i=stat_size; i != 0; --i)
    {
	term_clreol();
	newline();
    }
    scr_set_win(0);
#endif
}


/*
 * Function:	scr_set_win()
 *
 * Arguments:
 *	win	  - 0==select text window, 1==select status window
 *
 * Description:
 *	Selects a different window.  This function won't be called
 *	unless call F1_SETB(B_STATUS_WIN) in scr_begin().
 *
 * Notes:
 */
void
scr_set_win A1(int, win)
{
#ifndef STREAM_OUT
    /*
     * Select the status window; just move the cursor there
     */
    if (win)
    {
	in_status = 1;

	term_home();
	newline();
	term_status_color();
    }
    else
    {
	in_status = 0;

	term_lowleft();
	term_text_color();
    }
#endif
}


/*
 * Function:	scr_open_sf()
 *
 * Arguments:
 *	length	  - total size of BUFFER
 *	buffer	  - buffer to return nul-terminated filename in
 *	type	  - SF_SAVE	opening the file to save into
 *		    SF_RESTORE	opening the file to restore from
 *		    SF_SCRIPT	opening a file for scripting
 *
 * Returns:
 *	FILE* - reference to the opened file, or
 *	NULL  - errno==0: operation cancelled, else error opening file
 *
 * Description:
 *	Obtains the name of the file to be opened for writing (if
 *	TYPE==SF_SAVE or SF_SCRIPT) or reading (if TYPE==SF_RESTORE),
 *	opens the file with fopen(), and returns the FILE*.
 *
 *	The name of the file should be stored in BUFFER.  Upon initial
 *	calling BUFFER contains a possible default filename.
 *
 *	if TYPE==2 then don't ask the user for a name, just use
 *	BUFFER.  This means we got the -r option to restore the file.
 *	Also note that unless gflags.game_state!=NOT_INIT, scr_begin()
 *	has not been called (we're restoring before printing info).
 *
 *	If the fopen() fails just return NULL: if errno!=0 then an
 *	error will be printed.
 *
 * Notes:
 *	History is turned off here (why would anyone want it?)
 */
FILE *
scr_open_sf A3( int, length, char *, buffer, int, type )
{
#define FN_PROMPT	"Enter file name (or Q to quit)"

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

    sprintf(prompt, "%s [%s]: ", FN_PROMPT, buffer);

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

    if (((len == 1) && (cp[0] == 'q')) || (len && iscntrl(cp[0])))
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
			"File `%s' exists: overwrite (y/n/q) [y]? ",
			buffer);

		if (scr_getstr(over_p, length, cp, 1))
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
 * Function:	scr_close_sf()
 *
 * Arguments:
 *	filenm	  - name of file just processed
 *	fp	  - FILE* to open saved file
 *	type	  - SF_SAVE	closing a saved game file
 *		    SF_RESTORE	closing a restored game file
 *		    SF_SCRIPT	closing a scripting file
 *
 * Description:
 *	This function will be called immediately after a successful
 *	save or restore of a game file, so that if the interface needs
 *	to perform any actions related to the saved game it may.  It
 *	will also be called when the interpreter notices that
 *	scripting has been turned off.	It should at least close the
 *	file.
 *
 *	This function will only be called if the save/restore of the
 *	game succeeded; if it fails the file will be closed by the
 *	interpreter.
 */
void
scr_close_sf A3( const char *, filenm, FILE *, fp, int, type )
{
    fclose(fp);
}
