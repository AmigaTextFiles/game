/*
Copyright (c) 1992, Trevor Smigiel.  All rights reserved.

(I hope Commodore doesn't mind that I borrowed their copyright notice.)

The source and executable code of this program may only be distributed in free
electronic form, via bulletin board or as part of a fully non-commercial and
freely redistributable diskette.  Both the source and executable code (including
comments) must be included, without modification, in any copy.  This example may
not be published in printed form or distributed with any commercial product.

This program is provided "as-is" and is subject to change; no warranties are
made.  All use is at your own risk.  No liability or responsibility is assumed.

*/

#include <exec/types.h>
#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <intuition/imageclass.h>
#include <intuition/icclass.h>
#include <clib/macros.h>
#include <dos/rdargs.h>
#include <stdio.h>
/* comment for includesym.ced, puts protos after comment */
#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/dos.h>
#include <proto/graphics.h>

#include "Tetris.h"
#include "TetrisImages_protos.h"


LONG            XSize = 16;
LONG            YSize = 16;
LONG            Depth = 2;
char            Template[] = "DEPTH/N,XSIZE/N,YSIZE/N";
LONG            Args[] = {0, 0, 0};

struct Screen  *Screen;
struct DrawInfo *DInfo;
struct Gadget  *Gadgets = NULL;

void
FreeGList(struct Gadget *Gads, int i)
{
	struct Gadget  *g;
	while (i) {
		g = Gads;
		Gads = Gads->NextGadget;
		if (g->GadgetRender)
			DisposeObject(g->GadgetRender);
		DisposeObject(g);
		i--;
	}
}

LONG map[4] = {GA_ID, ICSPECIAL_CODE, TAG_END, 0};

struct Window  *
waiting_window(void)
{
	struct Window  *W = NULL;
	struct Gadget  *g1, *g2;
	struct Image   *i1, *i2;
	int w, h;

	g1 = NewObject(NULL, "frbuttonclass",
		GA_ID, 1,
		GA_Previous, &Gadgets,
		GA_Left, Screen->WBorLeft + 4,
		GA_Top, Screen->WBorTop + Screen->Font->ta_YSize + 4,
		GA_Text, "Abort",
		GA_Image, i1 = NewObject(NULL, "frameiclass", TAG_END),
		GA_DrawInfo, DInfo,
		GA_RelVerify, TRUE,
		//ICA_TARGET, ICTARGET_IDCMP,
		//ICA_MAP, map,
		TAG_END
		);
	if (g1) {
		g2 = NewObject(NULL, "frbuttonclass",
			GA_ID, 2,
			GA_Previous, &Gadgets,
			GA_Left, Screen->WBorLeft + 4,
			GA_Top, Screen->WBorTop + Screen->Font->ta_YSize * 2 + 10,
			GA_Text, "Play",
			GA_Image, i2 = NewObject(NULL, "frameiclass", TAG_END),
			GA_DrawInfo, DInfo,
			GA_RelVerify, TRUE,
			//ICA_TARGET, ICTARGET_IDCMP,
			//ICA_MAP, map,
			TAG_END
		);
		if (g2) {
			struct IBox dud1;//, dud2;

			//DoMethod((Object *)i1, IM_FRAMEBOX, &g1->LeftEdge, &dud1, DInfo, 0);
			//dud1.Width  += 10; //Screen->Font->ta_YSize * 7;
			//dud1.Height += 2; //Screen->Font->ta_YSize + 24;
			//DoMethod((Object *)i1, IM_FRAMEBOX, &g1->LeftEdge, &dud1, DInfo, FRAMEF_SPECIFY);
			//printf("%d %d %d %d -- ", i1->LeftEdge, i1->TopEdge, i1->Width, i1->Height);

			//DoMethod((Object *)i2, IM_FRAMEBOX, &g2->LeftEdge, &dud2, DInfo, 0);
			//dud2.Width  += 10; //Screen->Font->ta_YSize * 7;
			//dud2.Height += 2; //Screen->Font->ta_YSize + 24;
			//DoMethod((Object *)i2, IM_FRAMEBOX, &g2->LeftEdge, &dud2, DInfo, FRAMEF_SPECIFY);
			//printf("%d %d %d %d\n", i2->LeftEdge, i2->TopEdge, i2->Width, i2->Height);

			dud1.Width = MAX(g1->Width, g2->Width) * 2;
			dud1.Height = MAX(g1->Height, g2->Height);

			SetAttrs(g1, GA_Width, dud1.Width, GA_Height, dud1.Height, TAG_END);
			SetAttrs(g2, GA_Top, g1->TopEdge + g1->Height + 2, GA_Width, dud1.Width, GA_Height, dud1.Height, TAG_END);

			w = Screen->WBorLeft + Screen->WBorRight + MAX(g1->Width, XSize * 4) + 8;
			h = Screen->WBorTop + Screen->WBorBottom + Screen->Font->ta_YSize + MAX(g1->Height + g2->Height, YSize * 4) + 10;
			W = OpenWindowTags(NULL,
				WA_Title, "Waiting for players",
				WA_ScreenTitle, "Tetris",
				WA_Left, (Screen->Width - w) / 2,
				WA_Top, (Screen->Height - h) / 2,
				WA_Width, w,
				WA_Height, h,
				WA_Flags, WFLG_CLOSEGADGET | WFLG_DRAGBAR | WFLG_DEPTHGADGET | WFLG_ACTIVATE,
				WA_IDCMP, IDCMP_CLOSEWINDOW | IDCMP_IDCMPUPDATE | IDCMP_RAWKEY | IDCMP_GADGETUP,
				TAG_END
			);
			if (W) {
				AddGList(W, Gadgets, 2, 2, NULL);
				RefreshGList(Gadgets, W, NULL, 2);
				W->UserData = (char *) 1;
				return W;
			}
			DisposeObject(g2);
		}
		DisposeObject(g1);
	}
	return NULL;
}

int
main(void)
{
	struct RDArgs  *RDArgs;
	struct Window  *w;
	struct IntuiMessage *msg;
	struct BitMap  *bm = &TBitMaps[0];
	int             which = 0,
	                done = 0;
	RDArgs = ReadArgs(Template, Args, NULL);
	if (RDArgs) {
		if (Args[0]) Depth = *(LONG *) Args[0];
		if (Args[1]) XSize = *(LONG *) Args[1];
		if (Args[2]) YSize = *(LONG *) Args[2];
		if (InitTetrisImages(Depth, XSize, YSize)) {
			Screen = LockPubScreen(NULL);
			if (Screen) {
				w = NULL;
				DInfo = GetScreenDrawInfo(Screen);
				if (DInfo) {
					w = waiting_window();
					/*
					 * w = OpenWindowTags(NULL, WA_Left, 200, WA_Top, 50,
					 * WA_Width, 40 + XSize * 4, WA_Height, 40 + YSize *
					 * 4, WA_Flags, WFLG_ACTIVATE | WFLG_CLOSEGADGET |
					 * WFLG_DRAGBAR | WFLG_DEPTHGADGET, WA_IDCMP,
					 * IDCMP_CLOSEWINDOW | IDCMP_RAWKEY, TAG_END );
					 */
					if (w) {
						BltBitMapRastPort(bm, 0, 0, w->RPort, w->BorderLeft + 3, w->BorderTop + 3, TSizes[which].x, TSizes[which].y, 0xee);
						while (!done) {
							WaitPort(w->UserPort);
							while (msg = (struct IntuiMessage *) GetMsg(w->UserPort)) {
								switch (msg->Class) {
								case IDCMP_RAWKEY:
									if (msg->Code & IECODE_UP_PREFIX) {
										BltBitMapRastPort(bm, 0, 0, w->RPort, w->BorderLeft + 3, w->BorderTop + 3, TSizes[which].x, TSizes[which].y, 0x22);
										which++;
										if (which == 20)
											which = 0;
										bm = &TBitMaps[which];
										BltBitMapRastPort(bm, 0, 0, w->RPort, w->BorderLeft + 3, w->BorderTop + 3, TSizes[which].x, TSizes[which].y, 0xee);
									}
									break;
								case IDCMP_IDCMPUPDATE:
									printf("%04x\t", msg->Code);
									printf("%04x\t", msg->Qualifier);
									printf("%08x\t", *(ULONG *)((LONG)msg->IAddress + 4));
									printf("%08x\t", *(ULONG *)((LONG)msg->IAddress + 8));
									printf("%08x\n", *(ULONG *)((LONG)msg->IAddress + 12));
									break;
								case IDCMP_CLOSEWINDOW:
									done = TRUE;
									break;
								}
								ReplyMsg((struct Message *)msg);
							}
						}
						RemoveGList(w, Gadgets, 2);
						FreeGList(Gadgets, 2);
						CloseWindow(w);
					}
					FreeScreenDrawInfo(Screen, DInfo);
				}
				UnlockPubScreen(NULL, Screen);
			}
			FreeTetrisImages(Depth, XSize, YSize);
		}
		FreeArgs(RDArgs);
	} else
		PrintFault(IoErr(), "ReadArgs");
	return 0;
}
