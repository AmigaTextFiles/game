/*

sc DATA=NEAR NMINC STRMERGE NOSTKCHK SAVEDS bob
slink from LIB:c.o bob.o animtools.o LIB lib:sc.lib to bob

 *
 */

#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gels.h>
#include <exec/memory.h>
#include <libraries/dos.h>

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <stdlib.h>

#include "animtools.h"

void bobDrawGList(struct RastPort *rp, struct ViewPort *vp);
void process_window(struct Window *win, struct Bob *mybob);
void do_Bob(struct Window *win);

struct GfxBase *GfxBase = NULL;
struct IntuitionBase *IntuitionBase = NULL;

int return_code;

#define GEL_SIZE 4

UWORD __chip bob_data1[2 * 2 * GEL_SIZE] =
{
  0xffff, 0x0003, 0xfff0, 0x0003, 0xfff0, 0x0003, 0xffff, 0x0003,
  0x3fff, 0xfffc, 0x3ff0, 0x0ffc, 0x3ff0, 0x0ffc, 0x3fff, 0xfffc
};

UWORD __chip bob_data2[2 * 2 * GEL_SIZE] =
{
  0xc000, 0xffff, 0xc000, 0x0fff, 0xc000, 0x0fff, 0xc000, 0xffff,
  0x3fff, 0xfffc, 0x3ff0, 0x0ffc, 0x3ff0, 0x0ffc, 0x3fff, 0xfffc
};

NEWBOB mynewbob =
{
	bob_data2, 2, GEL_SIZE, 2, 3, 0, SAVEBACK | OVERLAY, 0, 2, 160, 100
};

struct NewWindow mynewwindow =
{
	80, 20, 400, 150, -1, -1, CLOSEWINDOW | INTUITICKS,
	ACTIVATE | WINDOWCLOSE | WINDOWDEPTH | RMBTRAP,
	NULL, NULL, "Bob", NULL, NULL, 0, 0, 0, 0, WBENCHSCREEN
};

void
bobDrawGList(struct RastPort *rp, struct ViewPort *vp)
{
	SortGList(rp);
	DrawGList(rp, vp);
	WaitTOF();
}

void
process_window(struct Window *win, struct Bob *mybob)
{
	struct IntuiMessage *msg;

	for(;;) {
		Wait(1L << win->UserPort->mp_SigBit);

		while(NULL != (msg = (struct IntuiMessage *)GetMsg(win->UserPort)))
		{
			if (msg->Class == CLOSEWINDOW) {
				ReplyMsg((struct Message *)msg);
				return;
			}

			mybob->BobVSprite->X = msg->MouseX + 20;
			mybob->BobVSprite->Y = msg->MouseY + 1;
			ReplyMsg((struct Message *)msg);
		}

		mybob->BobVSprite->ImageData =
			(mybob->BobVSprite->ImageData == bob_data1 ?
			bob_data2 : bob_data1);

		InitMasks(mybob->BobVSprite);
		bobDrawGList(win->RPort, ViewPortAddress(win));
	}
}

void
do_Bob(struct Window *win)
{
	struct Bob *mybob;
	struct GelsInfo *my_ginfo;

	if (NULL == (my_ginfo = setupGelSys(win->RPort, 0xfc)))
		return_code = RETURN_WARN;
	else {
		if (NULL == (mybob = makeBob(&mynewbob)))
			return_code = RETURN_WARN;
		else {
			AddBob(mybob, win->RPort);
			bobDrawGList(win->RPort, ViewPortAddress(win));

			process_window(win, mybob);

			RemBob(mybob);
			bobDrawGList(win->RPort, ViewPortAddress(win));

			freeBob(mybob, mynewbob.nb_RasDepth);
		}
		cleanupGelSys(my_ginfo, win->RPort);
	}
}

void
main(int argc, char **argv)
{
	struct Window *win;

	if (NULL == (GfxBase = (struct GfxBase *)OpenLibrary("graphics.library", 33L)))
		return_code = RETURN_FAIL;
	else {
		if (NULL == (IntuitionBase = (struct IntuitionBase *)
			OpenLibrary("intuition.library", 33L)))
			return_code = RETURN_FAIL;
		else {
			if (NULL == (win = OpenWindow(&mynewwindow)))
				return_code = RETURN_FAIL;
			else {
				do_Bob(win);
				CloseWindow(win);
			}
			CloseLibrary((struct Library *)IntuitionBase);
		}
		CloseLibrary((struct Library *)GfxBase);
	}
	exit(return_code);
}
