/*
 * bully - push all open screens around. This is designed for showing off
 *	more than one demo at a time.
 *
 * Copyright (c) 1987, Mike Meyer
 * This program can be redistributed freely, under two conditions:
 *	1) The source must be part of the distribution.
 *	2) All copyright notices must stay in the source as is.
 *
 * usage: bully [scriptname]
 *
 *	scriptname, if provided, will be executed before bully actually
 *		starts. It should "run" demos (or some equivalent thing)
 *		and exit, at which time bully proper will start.
 *
 * Note: this started as a hack to push windows around, but that doesn't
 *	seem to want to work reliably. So I blew it off, and made it a
 *	screen bully. The code still shows some of this, and hopefully
 *	someone will figure out what I did wrong and fix the window
 *	part of it.
 */

#include <stdio.h>
#include <string.h>
#include <libraries/dos.h>
#include <exec/types.h>
#include <exec/lists.h>
#include <intuition/intuitionbase.h>

/*
 * Declare names for the error returns.
 */
#define	OK		0
#define ARG_ERROR	100
#define NO_INTUITION	200
#define NO_MEMORY	300
#define	NO_WINDOW	400
#define ONEXIT_BROKE	500

/*
 * Things for the world to use.
 */
struct IntuitionBase	*IntuitionBase;
static char		*my_name ;
static struct Screen	*work_bench ;

/*
 * playground holds a screen descriptor. Screens just go up and down, so
 * we only need one velocity component. There are multiple windows per
 * screen, so we add a pointer to the new ones each time around.
 */
struct playground {
	struct Screen	*p_screen ;
	short		p_y_delta ;
	} ;
/*
 * bullied holds a window pointer, and the velocity of the window. It also
 * has an indicator for the playground the victim is in.
 */
struct bully {
	struct Node		b_node ;
	struct Window		*b_window ;
	struct playground	*b_playground ;
	short			b_x_delta, b_y_delta ;
	} ;

/*
 * Now, we have a fake bully to insure that each window is
 * looked at at least once.
 */

/*
 * Declare all our functions!
 */
struct bully	*bully_init(struct Window *, struct Screen *, struct List *) ;
void		move_window(struct bully *, int) ;
void		barf(int, char *) ;
int		catch_break(void) ;

void
main(argc, argv) char **argv; {
	register short			length, screen_count = 0 ;
	register struct Window		*w ;
	register struct Screen		*s ;
	register struct bully		*b ;
	char				command[128] ;
	struct List			windows ;
	long				lock ;

/*
 * Save my name for the outside world.
 */
	my_name = argv[0] ;
/*
 * First, make sure we have either 0, or 1 arguments.
 */
	if (argc > 2) barf(ARG_ERROR, "usage: %s [ scriptname ]\n") ;
/*
 * Just make sure that user aborts exit correctly! If we can't set it, we
 *	really don't care, so ignore the return value.
 */
	(void) onbreak(&catch_break) ;

/*
 * Now, get IntuitionBase so we can find the window we need.
 */
	if ((IntuitionBase = (struct IntuitionBase *)
	    OpenLibrary("intuition.library", 0)) == NULL)
		barf(NO_INTUITION, "%s: Can't open intuition\n") ;
/*
 * If we have an argument, go execue the script.
 */
	if (argc == 2) {
		sprintf(command, "execute %s", argv[1]) ;
		Execute(command, 0, 0) ;
		}
/*
 * Tell the world who we are, and how to get out of us!
 */
	WBenchToFront() ;
	printf("%s Copyright (c) 1987, Mike Meyer\n", my_name) ;
	puts("This program catchs Control-C to exit. If the window it") ;
	puts("is running in isn't active, you should activate it NOW.") ;
	puts("\nOnce again, that's Control-C to exit!") ;
	fflush(stdout) ;
	Delay(TICKS_PER_SECOND * 30) ;
/*
 * Initialize the list header for the window list.
 */
	NewList(&windows) ;
#ifdef	notdef
/*
 * If we don't have any arguments, then do things to all windows, on all
 * screens.
 */
	if (argc == 1) {
#endif
		lock = LockIBase(0L) ;
		for (s = IntuitionBase -> FirstScreen; s; s = s -> NextScreen) {
/*
 * If it's the workbench screen, save it, then scan all the windows.
 */
			if ((s -> Flags & SCREENTYPE) == WBENCHSCREEN)
				work_bench = s ;
#ifdef	notdef
			for (w = s -> FirstWindow; w; w = w -> NextWindow)
				AddHead(&windows, bully_init(w, s, &windows)) ;
#endif
			screen_count += 1 ;
/*
 * Make sure this screen is on the list.
 */
			AddHead(&windows, bully_init(NULL, s, &windows)) ;
			}
		UnlockIBase(lock) ;
#ifdef	notdef
		}
/*
 * Otherwise, we have one argument, so we'll chase down all windows that
 * have that as a prefix of their name, and move them.
 */
	else {
/*
 * We want the length of the argument so we no how much to check for.
 */
		length = strlen(argv[1]) ;
/*
 * Now, scan all the windows until we find it, complaining if we don't.
 */
		lock = LockIBase(0L) ;
		for (s = IntuitionBase->FirstScreen; s; s = s->NextScreen)
			for (w = s->FirstWindow; w; w = w->NextWindow)
				if (strncmp(w->Title, argv[1], length) ==  0)
					AddHead(&windows,
						bully_init(w, s, &windows)) ;
/*
 * Really ought to do something about having similarly named windows on
 * multiple screens, but we'll forget it for now.
 */
		UnlockIBase(lock) ;
/*
 * If we never found any windows. Clean up, and go tell the user.
 * go.
 */
		if (windows . lh_Head -> ln_Succ == 0)
			barf(NO_WINDOW, "%s: Couldn't find window!\n") ;
		}
#endif
/*
 * Now, loop forever moving the windows around, taking care to bounce off the
 *	screen edges. But first, shove the workbench to the back!
 */
	WBenchToBack() ;
	for (;;) {
		for (b = (struct bully *) windows . lh_Head ;
		    b -> b_node . ln_Succ ;
		    b = (struct bully *) b -> b_node . ln_Succ)
			move_window(b, screen_count > 1) ;
		chkabort() ;
		RemakeDisplay() ;
		}
/*
 * And clean up and exit.
 */
	exit(OK) ;
	}
/*
 * bully_init just plugs in the velocity on a window.
 */
struct bully *
bully_init(w, s, list) struct Window *w; struct Screen *s; struct List *list; {
	register struct bully		*b, *xb ;
	register struct playground	*p ;
	register short			x_delta, y_delta ;
	void				*malloc(int) ;

/*
 * Get me a bully for this window.
 */
	if ((b = (struct bully *) malloc(sizeof(struct bully))) == NULL)
		barf(NO_MEMORY, "%s: Can't allocate bully\n") ;
/*
 * If window is NULL, we're just adding this screen to the list so that
 * it gets pushed. So we skip the bully init code. But we need to put the
 * window in place anyway.
 */
	if ((b -> b_window = w) == NULL) {
/*
 * Now, get a velocity for this window. Take care to make sure we've got
 * room to move it back and forth in.
 */
		x_delta = y_delta = 0 ;
		if (s -> Width - w -> Width > 13)
			while (x_delta == 0)
				x_delta = (rand() >> 4) % 13 - 6 ;
		if (s -> Height - w -> Height > 9)
			while (y_delta == 0)
				y_delta = (rand() >> 4) % 9 - 4 ;
/*
 * And install everything for the window in place.
 */
		b -> b_x_delta = x_delta ;
		b -> b_y_delta = y_delta ;
		}
/*
 * phase two - set up the playground for this bully, if needed.
 */
	for (xb = (struct bully *) list -> lh_Head ;
	    xb -> b_node . ln_Succ ;
	    xb = (struct bully *) xb -> b_node . ln_Succ)
		if (xb -> b_playground -> p_screen == s) {
			b -> b_playground = xb -> b_playground ;
			return b ;
			}
/*
 * No playground in place, so we've gotta make a new playground for this thing.
 */
	if ((p = (struct playground *)
	    malloc(sizeof(struct playground))) == NULL)
		barf(NO_MEMORY, "%s: Can't allocate playground!\n") ;
	p -> p_screen = s ;
	y_delta = 0 ;
	while (y_delta == 0)
		y_delta = (rand() >> 4) % 21 - 10 ;
	p -> p_y_delta = y_delta ;
	b -> b_playground = p ;
	return b ;
	}
/*
 * move_window - actually push the little beggar around.
 */
void
move_window(b, move_screen) struct bully *b; int move_screen; {
	register short		x_delta = b -> b_x_delta ;
	register short		y_delta = b -> b_y_delta ;
	register struct Window	*w = b -> b_window ;
	register struct Screen	*s = b -> b_playground -> p_screen ;

/* Sigh. Moving windows doesn't work.... */
#ifdef	notdef
/*
 * If we have a window to move...
 */
	if (w != NULL) {
/*
 * Make sure we don't run off the edge of the screen.
 */
		if (w -> LeftEdge + x_delta + w -> Width >= s -> Width
		||  w -> LeftEdge + x_delta <= 0)
			b -> b_x_delta = x_delta = -x_delta ;
		if (w -> TopEdge + y_delta + w -> Height >= s -> Height
		||  w -> TopEdge + y_delta <= 0)
			b -> b_y_delta = y_delta = -y_delta ;
/*
 * Now, move the beggar.
 */
		MoveWindow(w, x_delta, y_delta) ;
		}
#endif
/*
 * And maybe move the screen while we're at it...
 */
	if (move_screen) {
		y_delta = b -> b_playground -> p_y_delta ;
		if (s -> TopEdge + y_delta > s -> Height
		||  s -> TopEdge + y_delta < 0) {
/*
 * To many patterns here. Need to do something to let the user specify which
 * of the 9 patterns they want.
 */
			if (y_delta < 0) ScreenToBack(s) ;
			if (y_delta > 0) ScreenToFront(s) ;
			b -> b_playground -> p_y_delta = y_delta = -y_delta ;
			}
		MoveScreen(s, 0, y_delta) ;
		}
	}
/*
 * barf - print a message, adding my name to it, then exit.
 */
void
barf(how, why) int how; char *why; {

	fprintf(stderr, why, my_name) ;
	(void) exit(how) ;
	}
/*
 * The routine to make user breaks work cleanly.
 */
catch_break() {

/*
 * Put the workbench back.
 */
	MoveScreen(work_bench, 0, -(work_bench -> TopEdge)) ;
	WBenchToFront() ;
/*
 * Now, warn the user that things may still be running.
 */
	puts("Ok, I'm all through. But other demos you left running may") ;
	puts("still be out there. You'll have to kill them by hand.") ;
/*
 * Now, close up everything and exit.
 */
	if (IntuitionBase != NULL) CloseLibrary(IntuitionBase) ;
	exit(0) ;
	return 0 ;	/* Sigh */
	}

