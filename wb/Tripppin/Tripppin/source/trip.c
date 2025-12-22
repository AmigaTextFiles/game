/* TO ADD:
    choice of aggressive or defensive computer play (aggressive = assume you
		will fuck up if given the chance) ?
    requester to tell you the rules ?
*/


/*
This is sort of the game of TRIPPPLES ® that was marketed by some game
company I forget which, and I can't find it in the stores so this
implementation is based purely on my memory of having played the game years
and years ago ...  the computer opponent uses a straightforward lookahead
strategy of variable depth.  I wrote this mainly for practice with the
graphics.library which I hadn't hardly used much yet, and just to prove I
COULD write an honest-to-god event loop ... most everything else I've been
writing has been CLI utilities ... It was easier than I expected; day 1 got
the board displayed pretty well (the tricky part was keeping everything
proportioned right on both interlaced and non-laced displays), day 2 I made
player tokens that could be moved around with the mouse (took some trial and
error to get the hang of using Bobs), the next evening got it to know all the
rules of the game, and display the game status in the right margin, another
evening got the computer opponent working, including the task synchronization
... after that it was just a matter of adding bells and whistles, like
putting arrowheads on the arrows, adding a menu, flashing X's to show where
the pieces are trying to go, the suggest-a-move and take-back-a-move
features, stuff to make it adapt gracefully to different sized fonts ... 
After the first release users gave me some suggestions which prompted me to
add an option to turn off the prevention of loops, and stifle the sprites
when the window is inactive or the menus are up.  I also found two bugs.

This program is written by Paul Kienitz and is placed in the public domain.
*/


#include <hardware/intbits.h>
#include <exec/interrupts.h>
#include <libraries/dosextens.h>
#include "trip.h"



import void ShowBoard(), TellTurn(), LiftBob(), DropBob(), DrawSquare(),
		DragBob(), Play(), MakePrettyPictures(),
		DropPrettyPictures(), KillAnts(), Ding();


import adr GfxBase, IntuitionBase;


import long startedthinking, Now();


piece oo, bb, *turn;


history ohist, bhist;


ubyte board[8][8];			/* grid of 8 bit masks */

bool won = false, bluefirst = false, looprevent = true;
bool thinking = false, abort_think = false, notadrill;

struct Message *wbs;			/* Workbench startup message */

short difficulty = 3, depth, thinkx, thinky, suggx, suggy, oldpri;


short sigdone = -1, sigkillme = -1;		/* child -> parent */

struct Task *child, *parent;


void VBsignal_func();

struct Interrupt VBsignal = {
    { null, null, NT_INTERRUPT, 6, "Tripppin signaler" },	/* node */
    null,			/* data - will be address of task to signal */
    VBsignal_func		/* code */
};



void Die(s) str s;
{
    if (child) {
	RemIntServer(INTB_VERTB, &VBsignal);
	Signal(child, bit(sigdie));
	Wait(bit(sigkillme));
	DeleteTask(child);
    }
    if (~sigdone)
	FreeSignal((long) sigdone);
    if (~sigkillme)
	FreeSignal((long) sigkillme);
    KillAnts();
    DumpPrettyPictures();
    if (IntuitionBase)
	CloseLibrary(IntuitionBase);
    if (GfxBase)
	CloseLibrary(GfxBase);
    if (s && Output())
	Write(Output(), s, (long) strlen(s));
    if (wbs) {
	Forbid();
	ReplyMsg(wbs);
    } else
	SetTaskPri(parent, (long) oldpri);
    Exit(s ? 20L : 0L);
}



#asm
		public	_VBsignal_func,_LVOSignal

_VBsignal_func:	move.l	#sigf_tof,d0
		move.l	4,a6		; is_Data (task addr) already in a1
		jsr	_LVOSignal(a6)
		moveq	#0,d0		; set the Z bit
		rts			; don't preserve a6 cause pri < 10
#endasm

/* This stupid interrupt server really serves no purpose any more, all it
does could be done as well by IntuiTicks.  But it's here so I'm not going to
bother to take it out. */



void Init()
{
    long d[3];
    void ThinkerTask();

    DateStamp(d);
    srand((int) ((d[0] << 2) + (d[1] << 4) + d[2]));
    if (!(GfxBase = (adr) OpenLibrary("graphics.library", 0L)))
	Die("No graphics!!\n");
    if (!(IntuitionBase = OpenLibrary("intuition.library", 0L)))
	Die("No intuition!!\n");
    MakePrettyPictures();
    if (!~(sigdone = AllocSignal(-1L)) || !~(sigkillme = AllocSignal(-1L)))
	Die("Couldn't allocate signals!\n");
    if (!(child = CreateTask("Thinkin and Trippin", 0L, ThinkerTask, 8000L)))
	Die("Couldn't create subtask!\n");
    parent = FindTask(null);
    VBsignal.is_Data = (adr) parent;
    AddIntServer(INTB_VERTB, &VBsignal);
    oo.hist = &ohist;
    bb.hist = &bhist;
    oo.other = &bb;
    bb.other = &oo;
    oo.machine = false;
    bb.machine = true;
}



void StopThinking()
{
    if (thinking) {
	abort_think = true;
	Wait(bit(sigdone));		/* thinking = false */
	abort_think = false;
    }
}



void StartThinking()
{
    StopThinking();
    suggx = suggy = -1;
    abort_think = false;
    notadrill = turn->machine;
    depth = notadrill ? difficulty : 3;
    /* just an initial value        ^^^        goes up with time */
    startedthinking = Now();
    thinking = true;
    Signal(child, bit(sigthink));
}



short xgoals[6] = { 4, 6, 6, 1, 1, 3 };
short ygoals[6] = { 7, 6, 1, 1, 6, 7 };

void SetGoal(p) piece *p;
{
    short i;
    i = (p == &oo ? p->reached + 1 : 4 - p->reached);
    p->goalx = xgoals[i];
    p->goaly = ygoals[i];
}



short xoffs[8] = { 0, 1, 1, 1, 0, -1, -1, -1 };
short yoffs[8] = { -1, -1, 0, 1, 1, 1, 0, -1 };

#define NX(x, i) ((x) + xoffs[i])
#define NY(y, i) ((y) + yoffs[i])



void Allow(from, tu) piece *from, *tu;
{
    register short i, x , y;
    ubyte r = 0;
    for (i = 0; i < 8; i++) {
	x = NX(tu->x, i);
	y = NY(tu->y, i);
	if (!(x & ~7) && !(y & ~7) && !(x == from->x && y == from->y))
	    r |= 1 << i;
    }
    tu->allowed = r & board[from->x][from->y];
}



void Restart()
{
    Shuffle();
    KillAnts();
    oo.x = 4;
    bb.x = 3;
    oo.y = bb.y = 7;
    Allow(&bb, &oo);
    Allow(&oo, &bb);
    oo.reached = bb.reached = 0;
    SetGoal(&oo);
    SetGoal(&bb);
    ohist.top = bhist.top = HISTORY - 1;
    ohist.count = bhist.count = 0;
    turn = bluefirst ? &bb : &oo;
    bluefirst = !bluefirst;
    won = false;
    StartThinking();
}



void Mooove(who, x, y) piece *who; short x, y;
{
    register history *gh = who->hist;

    if (gh->top < HISTORY - 1)
	gh->top++;
    else gh->top = 0;
    if (gh->count < HISTORY)
	gh->count++;
    gh->hx[gh->top] = who->x;
    gh->hy[gh->top] = who->y;
    gh->madegoal[gh->top] = x == who->goalx && y == who->goaly;
    who->x = x;
    who->y = y;
    Allow(who, who->other);
    if (gh->madegoal[gh->top])
	if (!(won = ++who->reached > 4))
	    SetGoal(who);
}



bool TryMove(who, x, y) piece *who; short x, y;
{
    short i, xd, yd;

    xd = x - who->x;
    yd = y - who->y;
    if (!xd && !yd)
	return true;			/* give player another try */
    if (xd > 1 || xd < -1 || yd > 1 || yd < -1)
	return false;				/* moved too far */
    if (!xd)
	i = yd > 0 ? 4 : 0;
    else if (xd > 0)
	i = 2 + yd;
    else
	i = 6 - yd;
    if (!(who->allowed & (1 << i)))
	return false;				/* forbidden move */
    KillAnts();
    StopThinking();
    Mooove(who, x, y);
    turn = turn->other;
    if (!won)
	StartThinking();
    TellTurn();
    return true;
}



#define max(a, b) ((a) > (b) ? (a) : (b))

#define abs(a) ((a) < 0 ? -(a) : (a))

short WayToGo(p) piece *p;		/* Way To Go, Dexter Riley! */
{
    register short d, dx, dy;

    dx = abs(p->x - p->goalx);
    dy = abs(p->y - p->goaly);
    d = max(dx, dy);
    if (p->reached < 4)
	d += 5 * (4 - p->reached) - 2;
    return d;
}



/* true if p's last move makes a forbidden loop - twice through is okay,
starting on a third time through is forbidden.  Does not detect loops longer
than HISTORY / 2. */

bool Loopin(p) piece *p;
{
    short len, pt, ot, pi, oi, n;
    history *hp = p->hist, *ho = p->other->hist;

    for (len = 2; len <= HISTORY >> 1; len++) {
	if (hp->count < len << 1)
	    break;
	pt = (hp->top + HISTORY + 1 - len) % HISTORY;
	ot = (ho->top + HISTORY + 1 - len) % HISTORY;
	if (p->other->x == ho->hx[ot] && p->other->y == ho->hy[ot]
				&& p->x == hp->hx[pt] && p->y == hp->hy[pt]) {
	    /* possible loop -- confirm: */
	    pi = hp->top;
	    oi = ho->top;
	    for (n = 0; n < len; n++) {
		pt = (pt + HISTORY - 1) % HISTORY;
		ot = (ot + HISTORY - 1) % HISTORY;
		if (hp->hx[pt] != hp->hx[pi] || hp->hy[pt] != hp->hy[pi] ||
			 ho->hx[ot] != ho->hx[oi] || ho->hy[ot] != ho->hy[oi])
		    break;
		pi = (pi + HISTORY - 1) % HISTORY;
		oi = (oi + HISTORY - 1) % HISTORY;
	    }
	    if (n >= len)
		return true;
	}
    }
    return false;
}



/* here we have the recursive lookahead strategy -- this function tries all
the moves available to player "me" against player "it" and sets rx and ry to
the best move available to "me", and returns a number that rates how well off
"me" ends up.  It abandons computation and returns meaningless values if the
global variable abort_think ever becomes true.  It does recursive lookahead
to depth "d". */

#define EXTREME 9999

short PickBestMove(d, me, it, rx, ry) short d; piece *me, *it; short *rx, *ry;
{
    short i, besti, best = -EXTREME, t, go, bgo = 999;
    short otop, ntop, oxx, oyy, oco;
    piece p, *oooth;
    history *h = me->hist;

    if (!me->allowed)
	return -EXTREME;			/* I lose */
    d--;
    if (rx) {
	t = 0;
	for (i = 0; i <= 7; i++)
	    if (me->allowed & (1 << i)) {
		t++;
		*rx = NX(me->x, i);
		*ry = NY(me->y, i);
	    }
	if (t == 1) return 0;     /* only legal move, skip other thinking */
    }

    otop = h->top;
    oco = h->count;
    if (h->count < HISTORY)
	h->count++;
    if (otop < HISTORY - 1)
	ntop = otop + 1;
    else ntop = 0;
    h->top = ntop;
    oxx = h->hx[ntop];
    oyy = h->hy[ntop];
    h->hx[ntop] = me->x;
    h->hy[ntop] = me->y;
    oooth = it->other;
    it->other = &p;

    for (i = 0; i <= 7; i++)
	if (me->allowed & (1 << i)) {
	    if (abort_think)
		return 0;
	    p = *me;
	    p.x = NX(p.x, i);
	    p.y = NY(p.y, i);
	    if (p.x == p.goalx && p.y == p.goaly)
		if (++p.reached > 4) {
		    if (rx)
			*rx = p.x, *ry = p.y;
		    best = EXTREME;		/* I win */
		    break;
		} else SetGoal(&p);
	    if (d <= 0)
		t = WayToGo(it) - WayToGo(&p);
	    else {
		ubyte a = it->allowed;
		Allow(&p, it);
		t = - PickBestMove(d, it, &p, null, null);
		it->allowed = a;
	    }			   /* VVV oops, forgot that! */
	    if (rx && looprevent && notadrill && Loopin(&p))
		t -= EXTREME << 1;
	    go = WayToGo(&p);
	    if (t > best || (t == best && go < bgo)) {
		best = t;
		besti = i;
		bgo = go;
		if (rx)
		    *rx = p.x, *ry = p.y;
	    }
	}

    it->other = oooth;
    h->hx[ntop] = oxx;
    h->hy[ntop] = oyy;
    h->count = oco;
    h->top = otop;
    return best;
}



/* the following is started up as a separate task to calculate the best move.
When it gets the "sigthink" signal it looks in the global variables for what
to think about.  It signals the parent when finished or aborted.  When not
aborted it puts the move that the player whose turn it is should make in the
global vars thinkx and thinky. */

void ThinkerTask()
{
    piece who, whom;
    history wo, wm;

    geta4();
    for (;;) {
	if (Wait(bit(sigthink) | bit(sigdie)) & bit(sigdie)) {
	    Signal(parent, bit(sigkillme));
	    Wait(0L);
	}
	thinking = true;
	who = *turn;
	whom = *who.other;
	who.other = &whom;
	whom.other = &who;
	wo = *who.hist;
	wm = *whom.hist;
	who.hist = &wo;
	whom.hist = &wm;
	PickBestMove(depth, &who, &whom, &thinkx, &thinky);
	Forbid();
	thinking = false;
	Signal(parent, bit(sigdone));
	Permit();
    }
}



void MachineMove()
{
    piece *who;
    short oldx, oldy;

    oldx = turn->x;
    oldy = turn->y;
    Mooove(turn, thinkx, thinky);
    LiftBob(turn);
    DrawSquare(oldx, oldy);		/* erase old image from rastport */
    DropBob(turn);			/* draw in new position */
    turn = turn->other;
    if (!won)
	StartThinking();
    TellTurn();
}



long _main()
{
    struct Process *me = ThisProcess();
    if (!me->pr_CLI) {
	WaitPort(&me->pr_MsgPort);
	wbs = GetMsg(&me->pr_MsgPort);
    }
    Init();
    Restart();
    ShowBoard();
    if (me->pr_Task.tc_Node.ln_Pri <= 0)
	oldpri = SetTaskPri(me, 1L);
    Play();
    Die(null);
}
