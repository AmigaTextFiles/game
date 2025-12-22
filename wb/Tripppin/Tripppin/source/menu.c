/* this file is got the menu stuff for the game Trippin. */


#include <intuition/intuition.h>
#include "trip.h"


#define MENWID 188
#define SUBWID 154


import struct Image olabel, blabel;

import void TellTurn(), Restart(), ShowBoard(), MakeAnts(), StartThinking(),
		StopThinking(), DrawSquare(), LiftBob(), DropBob(),
		TellTurn(), Ding();

import bool thinking, abort_think, lace, won, looprevent;

import short difficulty, sigdone, suggx, suggy, thite;

import piece bb, oo, *turn;

import struct Window *win;

import struct Task *child;



private struct IntuiText xquit = {
    0, 1, JAM2, 4, 1, null, (ubyte *) "Quit the game", null
};


private struct MenuItem mlast = {
    null, 0, (IMHITE << 1) + 64, MENWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP, 0L, (APTR) &xquit, null, 0, null, 0
};


private struct IntuiText xrestart = {
    0, 1, JAM2, 4, 1, null, (ubyte *) "Start a new game", null
};


private struct MenuItem m7 = {
    &mlast, 0, (IMHITE << 1) + 44, MENWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP, 0L, (APTR) &xrestart, null, 0, null, 0
};


private struct IntuiText xtakeback = {
    0, 1, JAM2, 4, 1, null, (ubyte *) "Take back move", null
};


private struct MenuItem m6 = {
    &m7, 0, (IMHITE << 1) + 34, MENWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | COMMSEQ,
    0L, (APTR) &xtakeback, null, 'T', null, 0
};


private struct IntuiText xsuggest = {
    0, 1, JAM2, 4, 1, null, (ubyte *) "Suggest move", null
};


private struct MenuItem m5 = {
    &m6, 0, (IMHITE << 1) + 24, MENWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | COMMSEQ,
    0L, (APTR) &xsuggest, null, 'S', null, 0
};


private struct IntuiText xprevent = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "Prevent loops", null
};


private struct MenuItem m4 = {
    &m5, 0, (IMHITE << 1) + 14, MENWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT | CHECKED | MENUTOGGLE,
    0L, (APTR) &xprevent, null, 0, null, 0
};


private struct IntuiText xd9 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "9  ( zzz...)", null
};


private struct IntuiText xd8 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "8  (savage)", null
};


private struct IntuiText xd7 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "7  (brutal)", null
};


private struct IntuiText xd6 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "6  (mean)", null
};


private struct IntuiText xd5 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "5  (tough)", null
};


private struct IntuiText xd4 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "4  (slick)", null
};


private struct IntuiText xd3 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "3  (wary)", null
};


private struct IntuiText xd2 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "2  (sloppy)", null
};


private struct IntuiText xd1 = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "1  (duuh...)", null
};


private struct IntuiText xdifficulty = {
    0, 1, JAM2, 4, 1, null, (ubyte *) "Difficulty level:", null
};


private struct MenuItem m3i = {
    null, MENWID - 26, 40, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT,
    0xfffffeffL, (APTR) &xd9, null, 0, null, 0
};


private struct MenuItem m3h = {
    &m3i, MENWID - 26, 30, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT,
    0xffffff7fL, (APTR) &xd8, null, 0, null, 0
};


private struct MenuItem m3g = {
    &m3h, MENWID - 26, 20, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT,
    0xffffffbfL, (APTR) &xd7, null, 0, null, 0
};


private struct MenuItem m3f = {
    &m3g, MENWID - 26, 10, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT,
    0xffffffdfL, (APTR) &xd6, null, 0, null, 0
};


private struct MenuItem m3e = {
    &m3f, MENWID - 26, 0, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT,
    0xffffffefL, (APTR) &xd5, null, 0, null, 0
};


private struct MenuItem m3d = {
    &m3e, MENWID - 26, -10, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT,
    0xfffffff7L, (APTR) &xd4, null, 0, null, 0
};


private struct MenuItem m3c = {
    &m3d, MENWID - 26, -20, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT | CHECKED,
    0xfffffffbL, (APTR) &xd3, null, 0, null, 0
};


private struct MenuItem m3b = {
    &m3c, MENWID - 26, -30, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT,
    0xfffffffdL, (APTR) &xd2, null, 0, null, 0
};


private struct MenuItem m3a = {
    &m3b, MENWID - 26, -40, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT,
    0xfffffffeL, (APTR) &xd1, null, 0, null, 0
};


private struct MenuItem m3 = {
    &m4, 0, (IMHITE << 1) + 4, MENWID, 10, ITEMTEXT | ITEMENABLED | HIGHNONE,
    0L, (APTR) &xdifficulty, null, 0, &m3a, 0
};


private struct IntuiText xcomputer = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "Computer", null
};


private struct IntuiText xhuman = {
    0, 1, JAM2, 24, 1, null, (ubyte *) "Human", null
};


private struct IntuiText xplayedby = {
    0, 1, JAM2, 38, 3, null, (ubyte *) "is played by:", null
};


private struct MenuItem m2b = {
    null, MENWID - 26, 10, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT | CHECKED, bit(0),
    (APTR) &xcomputer, null, 0, null, 0
};


private struct MenuItem m2a = {
    &m2b, MENWID - 26, 0, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT, bit(1),
    (APTR) &xhuman, null, 0, null, 0
};


private struct MenuItem m1b = {
    null, MENWID - 26, 10, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT, bit(0),
    (APTR) &xcomputer, null, 0, null, 0
};


private struct MenuItem m1a = {
    &m1b, MENWID - 26, 0, SUBWID, 10,
    ITEMTEXT | ITEMENABLED | HIGHCOMP | CHECKIT | CHECKED, bit(1),
    (APTR) &xhuman, null, 0, null, 0
};


private struct MenuItem m2i = {
    &m3, 6, IMHITE + 3, 32, IMHITE, ITEMENABLED | HIGHNONE, 0L,
    (APTR) &blabel, null, 0, null, 0
};


private struct MenuItem m2 = {
    &m2i, 0, IMHITE + 2, MENWID, IMHITE + 2, ITEMTEXT | ITEMENABLED | HIGHNONE,
    0L, (APTR) &xplayedby, null, 0, &m2a, 0
};


private struct MenuItem m1i = {
    &m2, 6, 1, 32, IMHITE, ITEMENABLED | HIGHNONE, 0L,
    (APTR) &olabel, null, 0, null, 0
};


private struct MenuItem m1 = {
    &m1i, 0, 0, MENWID, IMHITE + 2, ITEMTEXT | ITEMENABLED | HIGHNONE, 0L,
    (APTR) &xplayedby, null, 0, &m1a, 0
};



PUBLIC struct Menu manyou = {
    null, 210, 0, MENWID, 10, MENUENABLED, "Tripppin out!", &m1, 0, 0, 0, 0
};

/* ------------------ JEEZ!  All that for just ONE menu?! ------------ */



private void Spread(m, h) struct MenuItem *m; short h;
{
    short t;
    for (t = 0; m; m = m->NextItem) {
	m->TopEdge += t;
	m->Height = thite + 1;
	t += h;
    }
}



void ShoveMenus()		/* compensate for lace and/or tall font */
{
    struct MenuItem *mi;
    short t = (IMHITE << 2) + 8, h = thite - 9;

    if (lace) {
	m1.Height = m2.Height = m2.TopEdge = (IMHITE << 1) + 4;
	xplayedby.TopEdge = (IMHITE >> 1) + 3;
	m2i.TopEdge = (IMHITE << 1) + 5;
	m1i.Height = m2i.Height = IMHITE << 2;
	for (mi = &m3; mi; mi = mi->NextItem) {
	    mi->TopEdge = t;
	    t += 10;
	}
	mlast.TopEdge += 10;
    }
    if (h > 0) {
	Spread(&m3, h);			/* main items below imaged ones */
	Spread(&m3a, h);		/* difficulty subitems */
	manyou.Height = thite + 1;
	Spread(&m1a, h);
	Spread(&m2a, h);
    }
    /* this function assumes that thite < IMHITE + 2 */
}



private void Suck(who) piece *who;
{
    history *h = who->hist;
    if (!h->count)
	return;
    turn = turn->other;
    LiftBob(who);
    DrawSquare(who->x, who->y);
    who->x = h->hx[h->top];
    who->y = h->hy[h->top];
    if (h->madegoal[h->top]) {
	--who->reached;
	SetGoal(who);
    }
    if (!h->top)
	h->top = HISTORY - 1;
    else --h->top;
    --h->count;
    DropBob(who);
}



private void TakeBack()
{
    piece *oldturn = turn;

    if ((oo.machine && bb.machine) || !turn->other->hist->count) {
	Ding();
	return;
    }
    StopThinking();
    KillAnts(); 
    won = false;
    Suck(turn->other);
    if (oldturn->other->machine)
	Suck(oldturn);
    Allow(turn->other, turn);
    TellTurn();
    StartThinking();
}



bool DoMenu(c) short c;
{
    struct MenuItem *eye;
    short i;

    switch (c) {
	case 0:		/* orange player */
	    if ((oo.machine ? m1a.Flags : m1b.Flags) & CHECKED) {
		oo.machine = !oo.machine;
		if (turn == &oo) {
		    KillAnts();
		    StartThinking();
		    TellTurn();
		}
	    }
	    break;
	case 2:		/* blue player */
	    if ((bb.machine ? m2a.Flags : m2b.Flags) & CHECKED) {
		bb.machine = !bb.machine;
		if (turn == &bb) {
		    KillAnts();
		    StartThinking();
		    TellTurn();
		}
	    }
	    break;
	case 4:		/* difficulty level */
	    for (i = 1, eye = &m3a; eye; eye = eye->NextItem, i++)
		if (eye->Flags & CHECKED) {
		    difficulty = i;
		    break;
		}
		/* do *NOT* trust SUBITEM to be same as the one now checked! */
	    break;
	case 6:		/* suggest a move */
	    if (suggx >= 0)
		MakeAnts(suggx, suggy);
	    break;
	case 7:		/* take back a move */
	    TakeBack();
	    break;
	case 8:		/* restart the game */
	    Restart();
	    ShowBoard();
	    break;
	case 9:		/* quit the game */
	    abort_think = true;
	    return true;
    }
    looprevent = !!(m4.Flags & CHECKED);
    return false;
}
