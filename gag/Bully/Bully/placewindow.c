/*
 * placewindow - starts a program, and make the window look like you want it
 * to, not like the person who wrote the program wants it to.
 *
 * Copyright (c) 1987, Mike Meyer
 * This program can be redistributed freely, under two conditions:
 *	1) The source must be part of the distribution.
 *	2) This copyright notice must stay attached to the source.
 *
 * usage: placewindow windowname geometry [ command ]
 *
 *	windowname is a proper prefix of the title for the window
 *		that we're going to change.
 *
 *	geometry describes where the window should be, and how it should
 *		look. This is an enhanced version of the con: syntax for
 *		specifying where a window should go. The full spec is
 *		X/Y/W/H/e. Postive X (Y) specifies the offset from the
 *		left (top) edge of the screen to the left (top) edge of
 *		the window. Negative X (Y) specifes the offset from the
 *		right (bottom) edge of the screen to the right (bottom)
 *		edge of the window. W and H are the width and height of
 *		the window, respectively. Zero values for those means to
 *		make the window as long as possible in that direction.
 *		Obviously, you can't specify -X and 0 W, or -Y and 0 H.
 *		The "e", if present, means that the maximum sizes for the
 *		window should be set to -1 (any value you can mouse to).
 *		Nearly any piece of this can be left off. If the value is
 *		not specified (i.e., you didn't put in enough geometry to
 *		reach it) then it is left unmodified. If you actually put
 *		in the gemoetry specification, but don't put in a number
 *		(i.e. "////") then the missing values are treated as zero.
 *
 *		Simple examples: "////", "////e" and "-////" all specify
 *		max-sized windows. The "e" makes the max-sized window the
 *		screen size, and makes the window that big. "-" positions the
 *		window against the right edge of the screen if it's smaller
 *		than the screen. '10////', '10////', '10////e' and '10////e'
 *		all specify windows that are max-height, and stretch as far
 *		as they can from 10 pixels to the right of the left edge of
 *		the screen. The two with the "e" make the max-size window
 *		the screen size. The first two are synonyms, as are the
 *		last two. '10//100e' will be a window that start 10 pixels
 *		to the right of the left edge of the screen, is 100 pixels
 *		wide, and stretches from the top to the bottom of the
 *		screen. '10/10//100e' will be a window with it's upper left
 *		corner at 10, 10, is 100 pixels high, and stretches from
 *		the left to the right edge of the screen. '10/10/100/100e'
 *		and '10/10/100/100/e' both describe a 100 by 100 window with
 *		it's upper left corner at 10, 10 that has had it's maximum
 *		window sizes changed to the screen sizes. For leaving things
 *		off, '3/10' and '3/10e' would be a window the same size as
 *		the default, at location 3, 10. Note that '///' and '///e' are
 *		windows at 0, 0 with max-size X, and Y left alone, but '////'
 *		and '////e' are full-screen windows. Finally, a lone "e" will
 *		leave the window alone, but change it's maximum size but
 *		otherwise leave it alone.
 *
 *	command consists of all following arguments, and is a command to be
 *		executed before we try resizing the window. If command is
 *		given, we'll try to find the window at 1-second intervals
 *		one minute (roughly), so that command can create the window.
 *		If command isn't specified, we just look for the window
 *		once.
 *
 *	Warning: Negative W and H values in the geometry aren't supported,
 *		and I ain't going to say what happens if you use them.
 *		Sanity checks are done on the size/position. Rather than
 *		abort and have you try again, it trys to do something
 *		sane. Improvements on this code are welcome.
 */

#include <stdio.h>
#ifndef AZTEC
#include <string.h>
#include <dos.h>
#else
#include <ctype.h>
#endif
#include <libraries/dos.h>
#include <exec/types.h>
#include <intuition/intuitionbase.h>

/*
 * Declare names for the error returns.
 */
#define	OK		0
#define ARG_ERROR	100
#define NO_INTUITION	200
#define NO_MEMORY	300
#define COMMAND_ERROR	400
#define	NO_WINDOW	500
#define	BAD_ARGS	600

struct IntuitionBase *IntuitionBase;

void
main(argc, argv) char **argv; {
	register short		counter, length, width, height, x, y ;
	register char		*out, *in, *geometry ;
	register struct Window	*w ;
	register struct Screen	*s ;
	long			lock ;
	short			xminusp, yminusp ;
	char			*command ;

/*
 * Error processing - we need at least two args + our name
 */
	if (argc < 3) {
		fprintf(stderr,
			"usage: %s windowname geometry [ command ... ]\n",
			argv[0]) ;
		exit(ARG_ERROR) ;
		}
/*
 * If only have two arguments, then it's a window name and a geomtry.
 * We're only going to try once, so set the counter for one try.
 * Otherwise, we need to run the command, and retry 60 times (for up
 * to a minute.
 */
	if (argc == 3) counter = 1 ;
	else {
/*
 * We want to run the command first, so that it has as much time as possible
 * to get the window open before we go looking for it. To do that, we need to
 * turn the args list into a string for execution. Step one is to count
 * the total number of characters, with one extra for pad.
 */
		for (length = 0, counter = 3; counter < argc; counter++)
			length += strlen(argv[counter]) + 1 ;
/*
 * Step two is to get space for the command to reside in.
 */
		if ((command = (char *) malloc(length + 4)) == NULL) {
			fprintf(stderr,
				"%s: Couldn't get %d bytes", argv[0], length) ;
			exit(NO_MEMORY) ;
			}
/*
 * Step three is to put the "run " into the buffer.
 */
		(void) strcpy(command, "run ") ;
/*
 * And step four is to copy the strings into it. 
 */
		for (out = &command[4], counter = 3; counter < argc; counter++){
			for (in = argv[counter]; *in;)
				*out++ = *in++ ;
			*out++ = ' ' ;
			}
		*out = '\0' ;
/*
 * Now, just execute the rest of the args as a command.
 */
		if (!Execute(command, 0, 0)) {
			fprintf(stderr, "%s: %s failed\n", argv[0], argv[3]) ;
			exit(COMMAND_ERROR) ;
			}
		counter = 60 ;
		}
/*
 * Parsing the geometry turned out to be the nasty part of this program,
 * probably because I tried to do it ad hoc. It took almost no time after
 * I sat down and wrote out the bnf. Which is:
 *
 *	geometry ::= spec flag
 *	flag ::= 'e' | '/' 'e' | nil
 *	spec ::=  pos_spec
 *		| pos_spec '/' pos_spec
 *		| pos_spec '/' pos_spec '/' dim_spec
 *		| pos_spec '/' pos_spec '/' dim_spec '/' dim_spec
 *	pos_spec ::= number | '-' | '-' number | nil
 *	dim_spec ::= number | nil
 *	number ::= a string of digits, of course.
 *	nil ::= an empty string
 *
 * Following that, parsing is easy. First, set up the defaults values
 * if things are missing. Then, for the two pos_spec pieces, check
 * for a minus sign. If it's there, bump the pointer and note that this
 * is a negative value. For all the pieces, you then check to see
 * if you've come to the flags part (end of string or a 'e'), and
 * drop to finished parsing if so. Otherwise, you translate the string
 * of digits to a number (an empty string is 0), and check to see if
 * there's a trailing '/' that needs to be skipped. Then on to the
 * next piece. At the end of all of this, the pointer is left pointing
 * to any 'e' that may be there.
 */
	geometry = argv[2] ;
	x = y = width = height = -1 ;
	xminusp = yminusp = FALSE ;

/* X */	if (*geometry == '-') {
		geometry += 1 ;
		xminusp = TRUE ;
		}
	if (*geometry == '\0' || *geometry == 'e' || *geometry == 'E')
		goto parse_over ;
	x = atoi(geometry) ;
#ifndef AZTEC
	geometry += strspn(geometry, "0123456789") ;
#else
	while (isdigit(*geometry))
		++geometry;
#endif
	if (*geometry == '/') geometry += 1 ;

/* Y */	if (*geometry == '-') {
		geometry += 1 ;
		yminusp = TRUE ;
		}
	if (*geometry == '\0' || *geometry == 'e' || *geometry == 'E')
		goto parse_over ;
	y = atoi(geometry) ;
#ifndef AZTEC
	geometry += strspn(geometry, "0123456789") ;
#else
	while (isdigit(*geometry))
		++geometry;
#endif
	if (*geometry == '/') geometry += 1 ;

/* W */	if (*geometry == '\0' || *geometry == 'e' || *geometry == 'E')
		goto parse_over ;
	width = atoi(geometry) ;
#ifndef AZTEC
	geometry += strspn(geometry, "0123456789") ;
#else
	while (isdigit(*geometry))
		++geometry;
#endif
	if (*geometry == '/') geometry += 1 ;

/* H */	if (*geometry == '\0' || *geometry == 'e' || *geometry == 'E')
		goto parse_over ;
	height = atoi(geometry) ;
#ifndef AZTEC
	geometry += strspn(geometry, "0123456789") ;
#else
	while (isdigit(*geometry))
		++geometry;
#endif
	if (*geometry == '/') geometry += 1 ;

parse_over:
/*
 * Fix the case on the flag.
 */
	if (*geometry == 'E') *geometry = 'e' ;
/*
 * Now, verify that we didn't get both negative offsets & unspecified
 * dimensions.
 */
	if ((xminusp && width == 0) || (yminusp && height == 0)) {
		fprintf(stderr, "%s: Bad geometry %s, to many defaults!\n",
			argv[0], argv[2]) ;
		exit(BAD_ARGS) ;
		}
/*
 * Now, get IntuitionBase so we can find the window we need.
 */
	if ((IntuitionBase = (struct IntuitionBase *)
	    OpenLibrary("intuition.library", 0)) == NULL) {
		fprintf(stderr, "%s: Can't open intuition\n", argv[0]) ;
		exit(NO_INTUITION) ;
		}
/*
 * We need to know how much of the window title to check.
 */
	length = strlen(argv[1]) ;
/*
 * Now, until we find the window, or have tried for over a minute,
 * keep trying to find the window we're looking for.
 */
	for (;;) {
		lock = LockIBase(0L) ;
		for (s = IntuitionBase->FirstScreen; s; s = s->NextScreen)
			for (w = s->FirstWindow; w; w = w->NextWindow)
				if (strncmp(w->Title, argv[1], length) ==  0)
					goto found_it ;
		UnlockIBase(lock) ;
		if (--counter) Delay(TICKS_PER_SECOND) ;
		else break ;
		} ;
/*
 * We never found the window. Clean up, and go tell the user.
 * go.
 */
	fprintf(stderr, "%s: Couldn't find window %s\n", argv[0], argv[1]) ;
	CloseLibrary(IntuitionBase) ;
	exit(NO_WINDOW) ;
/*
 * Find it. The rest of this block deals with fixing the window sizing
 * to be reasonable, and actually doing the sizing.
 */
found_it:
	if (*geometry == 'e') WindowLimits(w, 0, 0, -1, -1) ;
/*
 * Get absolute width & height values.
 */
	if (width == 0) width = s->Width - x ;
	else if (width == -1) width = w->Width ;
	if (height == 0) height = s->Height - y ;
	else if (height == -1) height = w->Height ;
/*
 * and sanity check them.
 */
	if (width > w->MaxWidth) width = w->MaxWidth ;
	if (width > s->Width) width = s->Width ;
	if (width < w->MinWidth) width = w->MinWidth ;
	if (height > w->MaxHeight) height = w->MaxHeight ;
	if (height > s->Height) height = s->Height ;
	if (height < w->MinHeight) height = w->MinHeight ;
/*
 * find absolute x & y values.
 */
	if (xminusp) x = s->Width - width - x ;
	else if (x == -1) x = w->LeftEdge ;
	if (yminusp) y = s->Height - height - y ;
	else if (y == -1) y = w->TopEdge ;
/*
 * now sanity check them.
 */
	if (x >= s->Width || x < 0) x = 0 ;
	if (y >= s->Height || y < 0) y = 0 ;
/*
 * Now sanity check the whole
 * package.
 */
	if (x + width > s->Width) x = s->Width - width ;
	if (y + height > s->Height) y = s->Height - height ;
/*
 * Now we can set the sizes.
 */
	SizeWindow(w, width - w->Width, height - w->Height) ;
	MoveWindow(w, x - w->LeftEdge, y - w->TopEdge) ;
/*
 * And clean up and exit.
 */
	UnlockIBase(lock) ;
	CloseLibrary(IntuitionBase) ;
	exit(OK) ;
	}
