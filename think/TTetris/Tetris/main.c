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
#include <intuition/icclass.h>
#include <clib/macros.h>
#include <stdio.h>
#include "tetris.h"
#include "con_input.h"
/* */
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/intuition.h>

#include "Tetris_protos.h"
#include "TetrisImages_protos.h"

UBYTE *vers = "$VER: Tetris 1.0";

void KeyTask(void);
void JoyTask(void);

#define MAX_PLAYERS 3
#define STACK_SIZE 10000L

void (*TaskEntries[])(void) = { KeyTask, KeyTask, KeyTask, JoyTask };

/* Each switch on a joystick corrosponds to a bit in cd_State */
/* The index of the character in the key string, is the same bit in cd_State */
/* bit   6  5  4  3  2  1  0 */
/*      mb rb lb  u  d  l  r */
char *ControlKeys[] = {
	"\x22\x20\x21\x10\x11", /* and the same for these */
	"\x28\x26\x27\x16\x17", /* ditto */
	"\x2f\x2d\x2e\x1e\x3e", /* These keys are only good for Tetris */
	NULL, /* joystick */
};

char *ControlUsage[] = {
	"keyboard:   w - rotate, a - left, s - down, d - right.",
	"keyboard:   i - rotate, j - left, k - down, l - right.",
	"numberpad:  8 - rotate, 4 - left, 5 - down, 6 - right.",
	"joystick:   up/button - rotate, left - left, down - down, right - right.",
};

struct ControlData Controls[MAX_PLAYERS];

struct Screen       *Screen;
struct Window       *Window;
struct Gadget       *Gadgets;
struct MsgPort      *tetris_MsgPort;
struct MsgPort      *timer_MsgPort;
struct timerequest  *timer_IORequest;
struct MinList Boards    = {(struct MinNode *)&Boards.mlh_Tail, NULL, (struct MinNode *)&Boards};
WORD heights[2];

WORD PWidth = 0;
WORD PHeight = 0;
WORD NumPlayers = 0;
WORD Players  = 1;
WORD Level    = 0;
WORD BSize    = 8;
WORD XSize    = 16;
WORD YSize    = 16;
WORD Depth    = 2;
WORD NoWaitLevel = 0;
WORD Flags = 0;

#define GFLG_QUIT 0x0001

void 
event_handler(void)
{
	struct TBoard *board;
	ULONG signals, signaled;
	ULONG timer_signal, window_signal, tetris_signal;
	WORD paused = 0;
	int i, gameover, nextlevel;

	for (i = 0; i < Players; i++) {
		if (Controls[i].cd_Task) {
			board = Controls[i].cd_Board;
			StartLevel(board, Level);
		}
	}

	tetris_signal = (1 << tetris_MsgPort->mp_SigBit);
	timer_signal = (1 << timer_MsgPort->mp_SigBit);
	window_signal = (1 << Window->UserPort->mp_SigBit);
	signals = tetris_signal | timer_signal | window_signal | SIGBREAKF_CTRL_C | SIGBREAKF_CTRL_F; 

	while (NumPlayers > 0) {
		signaled = Wait(signals);

		if (signaled & SIGBREAKF_CTRL_C)
			Flags |= GFLG_QUIT;

		if (signaled & SIGBREAKF_CTRL_F) { /* Child is done */
			for (i = 0; i < Players; i++) {
				if ((Controls[i].cd_Task != NULL) && (Controls[i].cd_MsgPort == NULL)) {
					FreeBoard(Controls[i].cd_Board);
					DeleteTask(Controls[i].cd_Task);
					Controls[i].cd_Board = NULL;
					Controls[i].cd_Task  = NULL;
					NumPlayers--;
				}
			}
		}

		if (signaled & timer_signal) {
			GetMsg(timer_MsgPort); /* There is only one message -- timer_IORequest */
			timer_IORequest->tr_time.tv_secs  = 0;
			timer_IORequest->tr_time.tv_micro = UPDATE_TIME;
			SendIO((struct IORequest *)timer_IORequest);
			for (i = 0; i < Players; i++) {
				if (Controls[i].cd_Task)
					UpdateTetris(Controls[i].cd_Board);
			}
		}

		if (signaled & tetris_signal) {
			struct ControlMsg *cmsg;
			while (cmsg = (struct ControlMsg *)GetMsg(tetris_MsgPort)) {
				if ((!paused) && (board = cmsg->cm_CData->cd_Board)) {
					int state = cmsg->cm_State;
					if (state & 1)
						MoveTetris(board, COMMAND_RIGHT);
					else if (state & 2)
						MoveTetris(board, COMMAND_LEFT);
					if (state & 4)
						MoveTetris(board, COMMAND_DOWN);
					else if (state & 8)
						MoveTetris(board, COMMAND_ROTATE); /* Two rotates to accomodate joysticks */
					if (state & 0x70) /* Any button */
						MoveTetris(board, COMMAND_ROTATE);
				}
				ReplyMsg((struct Message *)cmsg);
			}
		}

		if (signaled & window_signal) {
			struct IntuiMessage *msg;
			while (msg = (struct IntuiMessage *)GetMsg(Window->UserPort)) {

				switch (msg->Class) {
				case IDCMP_CHANGEWINDOW:
				case IDCMP_ACTIVEWINDOW:
					if (Window->Height != heights[paused]) {
						if (paused) {
							paused = 0;
							for (i = 0; i < Players; i++) {
								if (Controls[i].cd_Task)
									Signal(Controls[i].cd_Task, SIGBREAKF_CTRL_E);
							}
							
							SetWindowTitles(Window, "Tetris", "Tetris");
							if (CheckIO((struct IORequest *) timer_IORequest)) {
								timer_IORequest->tr_time.tv_secs  = 0;
								timer_IORequest->tr_time.tv_micro = UPDATE_TIME;
								SendIO((struct IORequest *)timer_IORequest);
							}
						} else {
				case IDCMP_INACTIVEWINDOW:
							paused = 1;
							for (i = 0; i < Players; i++) {
								if (Controls[i].cd_Task)
									Signal(Controls[i].cd_Task, SIGBREAKF_CTRL_D);
							}
							SetWindowTitles(Window, "Paused", "Tetris");
							if (!CheckIO((struct IORequest *) timer_IORequest)) {
								AbortIO((struct IORequest *) timer_IORequest);
								WaitIO((struct IORequest *) timer_IORequest);
								SetSignal(0, timer_signal);
							}
						}
					}
					break;
				case IDCMP_REFRESHWINDOW:
					BeginRefresh(Window);
					for (i = 0; i < Players; i++) {
						if (Controls[i].cd_Task)
							DrawBoard(Controls[i].cd_Board);
					}
					EndRefresh(Window, TRUE);
					break;

				case IDCMP_CLOSEWINDOW:
					Flags |= GFLG_QUIT;
					break;

				default:
					break;
				}
				ReplyMsg((struct Message *)msg);
			}
		}

		if (Flags & GFLG_QUIT) {
			for (i = 0; i < Players; i++) {
				if (Controls[i].cd_Task)
					Signal(Controls[i].cd_Task, SIGBREAKF_CTRL_C);
			}
			paused = 1;
			if (!CheckIO((struct IORequest *) timer_IORequest)) {
				AbortIO((struct IORequest *) timer_IORequest);
				WaitIO((struct IORequest *) timer_IORequest);
				SetSignal(0, timer_signal);
			}
		}

		if (!paused) {
			nextlevel = gameover = 0;
			for (i = 0; i < Players; i++) {
				if (Controls[i].cd_Task) {
					board = Controls[i].cd_Board;
					if (board->flags & TETF_GAMEOVER)
						gameover++;
					else if (board->flags & TETF_NEXTLEVEL)
						nextlevel++;
				}
			}
			if ((NoWaitLevel) || (nextlevel == (i - gameover))) {
				for (i = 0; i < Players; i++) {
					if (Controls[i].cd_Task) {
						board = Controls[i].cd_Board;
						if (board->flags & TETF_NEXTLEVEL) {
							StartLevel(board, board->clevel + 1);
						}
					}
				}
			}
		} 

	} /* end Wait Loop */
}

#define next event_handler

BOOL
StartOfGame(void)
{
	struct ControlData *c;
	int x, y;
	struct Task *ThisTask = FindTask(NULL);

	for (c = &Controls[0], NumPlayers = 0; NumPlayers < Players; c++, NumPlayers++) {
		c->cd_Board = NULL;
		c->cd_Task = CreateTask("Tetris_ConTask", 0, TaskEntries[NumPlayers], STACK_SIZE);
		if (!c->cd_Task) break;
		c->cd_Board = NewBoard(Window->RPort, Window->BorderLeft + BSize + (PWidth + BSize * 2) * NumPlayers, heights[1]);
		if (!c->cd_Board) {
			DeleteTask(c->cd_Task);
			c->cd_Task = NULL;
			break;
		}
		printf("Player %d uses %s\n", NumPlayers, ControlUsage[NumPlayers]);
		c->cd_Parent  = ThisTask;
		c->cd_MsgPort = tetris_MsgPort;
		c->cd_State   = 0; 
		c->cd_Keys    = ControlKeys[NumPlayers];
		c->cd_Task->tc_UserData = c;
		Signal(c->cd_Task, SIGBREAKF_CTRL_F); /* Signal task, the data is ready */
	}
	if (NumPlayers != Players) {
		x = NumPlayers * (PWidth + BSize * 2) + Screen->WBorLeft + Screen->WBorRight;
		y = heights[0] = PHeight + Screen->WBorBottom + heights[1] + BSize;
		ChangeWindowBox(Window, (Screen->Width - x) / 2, (Screen->Height - y) / 2, x, y);
	}
	return NumPlayers;
}

void 
EndOfGame(void)
{
	int i;
	for (i = 0; i < NumPlayers; i++) { /* Make sure everything is freed */
		if (Controls[i].cd_Board) {
			printf("FreeBoard - this shouldn't have happened.\n");
			FreeBoard(Controls[i].cd_Board);
		}
		if (Controls[i].cd_Task) {
			printf("DeleteTask - this shouldn't have happened.\n");
			DeleteTask(Controls[i].cd_Task);
		}
	}
}

void
tetris(void)
{
	if (InitTetrisImages(Screen->BitMap.Depth, XSize, YSize)) {
		if (StartOfGame()) { /* Add Players */
			next();
			EndOfGame();
		}
		FreeTetrisImages(Screen->BitMap.Depth, XSize, YSize);
	}
}

#undef next
#define next tetris

struct Window *
tetris_window(void)
{
	struct Window *w;
	WORD zoom[4];

	heights[1] = Screen->WBorTop + Screen->Font->ta_YSize + 1 + YSize * 4;
	heights[0] = PHeight + Screen->WBorBottom + heights[1] + BSize;
	zoom[3] = heights[1];
	zoom[2] = Players * (PWidth + (BSize * 2)) + Screen->WBorLeft + Screen->WBorRight;
	zoom[1] = (Screen->Height - heights[0]) / 2;
	zoom[0] = (Screen->Width - zoom[2]) / 2;
	w = OpenWindowTags(NULL,
		WA_Title, "Tetris",
		WA_ScreenTitle, "Tetris",
		WA_Left, zoom[0],
		WA_Top,  zoom[1],
		WA_Width,zoom[2],
		WA_Height,  heights[0],
		WA_Zoom, zoom,
		WA_Gadgets, Gadgets,
		WA_Flags, WFLG_CLOSEGADGET | WFLG_DRAGBAR | WFLG_DEPTHGADGET | WFLG_ACTIVATE,// | WFLG_GIMMEZEROZERO,
		WA_IDCMP, IDCMP_CLOSEWINDOW | IDCMP_IDCMPUPDATE | IDCMP_CHANGEWINDOW | IDCMP_ACTIVEWINDOW | IDCMP_INACTIVEWINDOW | IDCMP_REFRESHWINDOW,
		TAG_DONE
	);
	return w;
}

void
window(void)
{
	Window = tetris_window();
	if (Window) {
		next();
		CloseWindow(Window);
	}
}

#undef next
#define next window

void
screen(void)
{
	Screen = LockPubScreen(NULL);
	if (Screen) {
		next();
		UnlockPubScreen(NULL, Screen);
	}
}

#undef next
#define next screen

void 
timer(void)
{
	timer_MsgPort = CreateMsgPort();
	if (timer_MsgPort) {
		timer_IORequest = (struct timerequest *)CreateIORequest(timer_MsgPort, sizeof(struct timerequest));
		if (timer_IORequest) {
			if (!OpenDevice(TIMERNAME, UNIT_MICROHZ, (struct IORequest *)timer_IORequest, 0L)) {

				timer_IORequest->tr_node.io_Command = TR_ADDREQUEST;
				timer_IORequest->tr_time.tv_secs  = 0;
				timer_IORequest->tr_time.tv_micro = UPDATE_TIME;
				SendIO((struct IORequest *)timer_IORequest);

				next();

				if (!CheckIO((struct IORequest *) timer_IORequest)) {
					AbortIO((struct IORequest *) timer_IORequest);
					WaitIO((struct IORequest *) timer_IORequest);
				}

				CloseDevice((struct IORequest *) timer_IORequest);
			} else printf("No timer.device!\n");

			DeleteIORequest((struct IORequest *) timer_IORequest);
		} else printf("No timer io request!\n");
		DeleteMsgPort(timer_MsgPort);
	} else printf("No timer msg port!\n");
}

#undef next
#define next timer

void
msgport(void)
{
	tetris_MsgPort = CreateMsgPort();
	if (tetris_MsgPort) {
		tetris_MsgPort->mp_Node.ln_Name = TETRIS_PORT;
		next();
		DeleteMsgPort(tetris_MsgPort);
	} else printf("No player msg port!\n");
}

#undef next
#define next msgport

BOOL
ParseArgs(void)
{
	struct RDArgs *RDArgs;
	char Template[] = "PLAYERS/N,LEVEL/N,DEPTH/N,XSIZE/N,YSIZE/N,BORDER/N,NOWAIT/S";
	LONG Args[] = {0, 0, 0, 0, 0, 0, 0};

	RDArgs = ReadArgs(Template, Args, NULL);
	if (RDArgs) {
		if (Args[0]) { Players = *(LONG *)Args[0]; if (Players > MAX_PLAYERS) Players = MAX_PLAYERS; }
		if (Args[1]) Level = *(LONG *)Args[1];
		if (Args[2]) Depth = *(LONG *)Args[2];
		if (Args[3]) XSize = *(LONG *)Args[3];
		if (Args[4]) YSize = *(LONG *)Args[4];
		if (Args[5]) BSize = *(LONG *)Args[5];
		NoWaitLevel = Args[6];
		PWidth  = (PFWIDTH  * XSize);
		PHeight = (PFHEIGHT * YSize);
		FreeArgs(RDArgs);
		return TRUE;
	}
	return FALSE;
}

int 
main(void)
{
	printf("Tetris version 1.0\nCopyright (C) 1992 Trevor Smigiel.\n");
	if (ParseArgs()) {
	    if(!(SetSignal(0L,SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C))
			next();
	} else PrintFault(IoErr(), "ReadArgs");
	return 0;
}

