/*
 * simple curses emulation for the Amiga
 *
 * Alan Bland
 */
#ifdef AMIGA
#include <intuition/intuition.h>

extern struct Window *W;
extern struct Screen *S;
extern struct RastPort *R;

#define LINES	23
#define COLUMNS	80

#define echo()
#define noecho()
#define cbreak()
#define nocbreak()
#define refresh()
#define printw	addstr

#define BLACK		0
#define WHITE		1
#define DK_RED		2
#define RED		3
#define LT_RED		4
#define DK_GREEN	5	
#define GREEN		6
#define LT_GREEN	7	
#define YELLOW		8
#define BLUE		9
#define LT_BLUE		10
#define ORANGE		11
#define BROWN		12
#define LT_GRAY		13
#define MED_GRAY	14
#define DK_GRAY		15

/* default colors */
#define TEXT_COLOR	YELLOW
#define INPUT_COLOR	WHITE
#define BACK_COLOR	BLACK

#define setcolor(fg,bg)	SetAPen(R, fg); SetBPen(R, bg)

#define MOUSE (-3)
#endif
