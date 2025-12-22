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
#include <exec/memory.h>
#include <exec/tasks.h>
#include <devices/inputevent.h>
#include <devices/input.h>
#include <dos/dos.h>
/* */
#include <proto/exec.h>

#include "con_input.h"

struct InputEvent *__asm __interrupt
KeyWatch(
			register __a0 struct InputEvent *inputEvents,
			register __a1 struct ControlData *handlerData
)
{
	struct InputEvent *ie = inputEvents;
	struct InputEvent *pie = (struct InputEvent *)&ie;
	char           *key = handlerData->cd_Keys;
	ULONG           s = 0,
	                b;

	if (key) while (inputEvents) {
		if (inputEvents->ie_Class == IECLASS_RAWKEY) {
			for (b = 1; *key; key++, b <<= 1) {
				if (inputEvents->ie_Code & IECODE_UP_PREFIX) {
					if ((inputEvents->ie_Code & ~IECODE_UP_PREFIX) == *key) {
						pie->ie_NextEvent = inputEvents->ie_NextEvent;
						inputEvents = pie;
						handlerData->cd_State &= ~b;
					}
				} else {
					if (inputEvents->ie_Code == *key) {
						pie->ie_NextEvent = inputEvents->ie_NextEvent;
						inputEvents = pie;
						if (!(handlerData->cd_State & b)) {
							s = 1;
							handlerData->cd_State |= b;
						}
					}
				}
			}
		}
		pie = inputEvents;
		inputEvents = inputEvents->ie_NextEvent;
	}
	if (s)
		Signal(handlerData->cd_Task, SIGBREAKF_CTRL_F);
	return ie;
}

void
KeyTask(void)
{
	struct MsgPort     *ReplyPort;
	struct MsgPort     *timerPort;
	struct MsgPort     *inputPort;
	struct IOStdReq    *inputReqBlk;
	struct Interrupt   *inputHandler;
	struct timerequest *timerReqBlk;
	struct Task        *ThisTask;
	struct ControlData *cd;
	struct ControlMsg  CMsg;
	ULONG signaled, signals, PortSig, tPortSig;
	char *keys;

	Wait(SIGBREAKF_CTRL_F); /* Wait for parent to tell us to go */

	ThisTask = FindTask(NULL);
	cd = (struct ControlData *) ThisTask->tc_UserData;
	keys = cd->cd_Keys;

	ReplyPort = CreateMsgPort();
	if (ReplyPort) {
		inputPort = CreateMsgPort();
		if (inputPort) {
			inputHandler = AllocMem(sizeof(struct Interrupt), MEMF_PUBLIC | MEMF_CLEAR);
			if (inputHandler) {
				inputReqBlk = CreateIORequest(inputPort, sizeof(struct IOStdReq));
				if (inputReqBlk) {
					if (!OpenDevice("input.device", NULL, (struct IORequest *) inputReqBlk, NULL)) {
						inputHandler->is_Code   = (void (*)()) KeyWatch;
						inputHandler->is_Data   = (APTR) cd;		/* Get this info from task */
						inputHandler->is_Node.ln_Pri    = 100;
						inputHandler->is_Node.ln_Name   = "RawKeyHandler";
						inputReqBlk->io_Data    = (APTR) inputHandler;
						inputReqBlk->io_Command = IND_ADDHANDLER;
						DoIO((struct IORequest *) inputReqBlk);

						CMsg.cm_Msg.mn_Node.ln_Type = NT_REPLYMSG;
						CMsg.cm_Msg.mn_ReplyPort = ReplyPort;
						CMsg.cm_Msg.mn_Length = sizeof(struct ControlMsg);
						CMsg.cm_CData = cd;

						timerPort = CreateMsgPort();
						if (timerPort) {
							timerReqBlk = (struct timerequest *) CreateIORequest(ReplyPort, sizeof(struct timerequest));
							if (timerReqBlk) {
								if (!OpenDevice("timer.device", UNIT_MICROHZ, (struct IORequest *)timerReqBlk, 0L)) {

								/*
								 * There should be no reason for a user to
								 * send this task signals, so I figure it is
								 * safe to use the break sigs.
								 */
									tPortSig = (1 << timerPort->mp_SigBit);
									PortSig = (1 << ReplyPort->mp_SigBit);
									signals = SIGBREAKF_CTRL_C | SIGBREAKF_CTRL_D | SIGBREAKF_CTRL_E | SIGBREAKF_CTRL_F | PortSig | tPortSig;
									for (;;) {
										signaled = Wait(signals);

										if (signaled & SIGBREAKF_CTRL_D) cd->cd_Keys = NULL;
										if (signaled & SIGBREAKF_CTRL_E) cd->cd_Keys = keys;

										if (signaled & SIGBREAKF_CTRL_F) {	/* Key pressed */
											if (!CheckIO((struct IORequest *)timerReqBlk)) {
												AbortIO((struct IORequest *)timerReqBlk);
												WaitIO((struct IORequest *)timerReqBlk);
											}
										}

										if (signaled & PortSig)  while (GetMsg(ReplyPort));
										if (signaled & tPortSig) while (GetMsg(timerPort));

										if (signaled & SIGBREAKF_CTRL_C) break;

										if ((CheckIO((struct IORequest *)timerReqBlk)) && (cd->cd_State)) {
											timerReqBlk->tr_node.io_Command = TR_ADDREQUEST;
											timerReqBlk->tr_time.tv_secs  = 0;
											timerReqBlk->tr_time.tv_micro = 100000;
											SendIO((struct IORequest *)timerReqBlk);
											Forbid();
											if (CMsg.cm_Msg.mn_Node.ln_Type == NT_REPLYMSG) {
												CMsg.cm_State = cd->cd_State;
												PutMsg(cd->cd_MsgPort, (struct Message *)&CMsg);
											}
											Permit();
										}
									}

									while (CMsg.cm_Msg.mn_Node.ln_Type != NT_REPLYMSG) {
										while (GetMsg(ReplyPort));
									}
									if (!CheckIO((struct IORequest *)timerReqBlk)) {
										AbortIO((struct IORequest *)timerReqBlk);
										WaitIO((struct IORequest *)timerReqBlk);
									}
									CloseDevice((struct IORequest *) timerReqBlk);
								}
								DeleteIORequest((struct IORequest *) timerReqBlk);
							}
							DeleteMsgPort(timerPort);
						}

						inputReqBlk->io_Data = (APTR) inputHandler;
						inputReqBlk->io_Command = IND_REMHANDLER;
						DoIO((struct IORequest *) inputReqBlk);

						CloseDevice((struct IORequest *) inputReqBlk);
					}
					DeleteIORequest((struct IORequest *) inputReqBlk);
				}
				FreeMem(inputHandler, sizeof(struct Interrupt));
			}
			DeleteMsgPort(inputPort);
		}
		DeleteMsgPort(ReplyPort);
	}
	Forbid();
	cd->cd_MsgPort = NULL;
	Signal(cd->cd_Parent, SIGBREAKF_CTRL_F);
	Wait(0L);
}
