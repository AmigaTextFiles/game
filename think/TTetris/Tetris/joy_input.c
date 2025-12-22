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
#include <exec/io.h>
#include <exec/memory.h>
#include <exec/exec.h>
#include <dos/dos.h>
#include <devices/gameport.h>
#include <devices/inputevent.h>
/* */
#include <proto/exec.h>

#include "/GamePort_protos.h"
#include "con_input.h"


#define TIMEOUT 6

void
JoyTask(void)
{
	struct GamePortTrigger joytrigger = {GPTF_UPKEYS | GPTF_DOWNKEYS, TIMEOUT, 1, 1};
	struct IOStdReq *game_io_msg;
	struct MsgPort *game_msg_port;
	struct MsgPort *ReplyPort;
	struct Task    *ThisTask;
	struct ControlData *cd;

	Wait(SIGBREAKF_CTRL_F); /* Wait for parent to tell us to go */

	ThisTask = FindTask(NULL);
	cd = (struct ControlData *) ThisTask->tc_UserData;

	ReplyPort = CreateMsgPort();
	if (ReplyPort) {
		game_msg_port = CreateMsgPort();
		if (game_msg_port) {
			game_io_msg = CreateIORequest(game_msg_port, sizeof(struct IOStdReq));
			if (game_io_msg) {
				game_io_msg->io_Message.mn_Node.ln_Type = NT_UNKNOWN;
				if (!OpenDevice("gameport.device", 1, (struct IORequest *)game_io_msg, 0)) {
					if (set_controller_type(GPCT_ABSJOYSTICK, game_io_msg)) {

						set_trigger_conditions(&joytrigger, game_io_msg);
						flush_buffer(game_io_msg);

						{
							struct InputEvent game_event;		/* where input event
																 * will be stored */
							ULONG           signals,
							                signaled,
							                GameSig,
							                ReplySig;
							WORD            xmove,
							                ymove;
							struct ControlMsg CMsg;

							CMsg.cm_Msg.mn_Node.ln_Type = NT_REPLYMSG;
							CMsg.cm_Msg.mn_ReplyPort = ReplyPort;
							CMsg.cm_Msg.mn_Length = sizeof(struct ControlMsg);
							CMsg.cm_CData = cd;

							GameSig = (1L << game_msg_port->mp_SigBit);
							ReplySig = (1L << ReplyPort->mp_SigBit);
							signals =  GameSig | ReplySig | SIGBREAKF_CTRL_C;
							for (;;) {
								send_read_request(&game_event, game_io_msg);

								signaled = Wait(signals);

								if (signaled & ReplySig) while (GetMsg(ReplyPort));

								if (signaled & SIGBREAKF_CTRL_C) {
									if (signaled & GameSig)
										while (GetMsg(game_msg_port));
									break;
								}

								if (signaled & GameSig) {
									while (GetMsg(game_msg_port)) {
										switch (game_event.ie_Code) {
										case IECODE_LBUTTON:
											cd->cd_State |= 0x10;
											break;
										case IECODE_RBUTTON:
											cd->cd_State |= 0x20;
											break;

										case (IECODE_LBUTTON | IECODE_UP_PREFIX):
											cd->cd_State &= ~0x10;
											break;
										case (IECODE_RBUTTON | IECODE_UP_PREFIX):
											cd->cd_State &= ~0x20;
											break;

										case IECODE_NOBUTTON:
											/* Check for change in position */
											xmove = game_event.ie_X;
											ymove = game_event.ie_Y;

											cd->cd_State &= ~15;
											if (xmove == 1) {
												cd->cd_State |= 1;
											} else if (xmove == -1) {
												cd->cd_State |= 2;
											}
											if (ymove == 1) {
												cd->cd_State |= 4;
											} else if (ymove == -1) {
												cd->cd_State |= 8;
											}
											break;

										default:
											break;
										}
									}
									Forbid();
									if ((cd->cd_State) && (CMsg.cm_Msg.mn_Node.ln_Type == NT_REPLYMSG)) {
										CMsg.cm_State = cd->cd_State;
										PutMsg(cd->cd_MsgPort, (struct Message *)&CMsg);
									}
									Permit();
								}
							}
						}

						if (!CheckIO((struct IORequest *)game_io_msg)) AbortIO((struct IORequest *)game_io_msg);
						WaitIO((struct IORequest *)game_io_msg);
						free_gp_unit(game_io_msg);
					}
					CloseDevice((struct IORequest *)game_io_msg);
				}
				DeleteIORequest(game_io_msg);
			}
			DeleteMsgPort(game_msg_port);
		}
		DeleteMsgPort(ReplyPort);
	}
	Forbid();
	cd->cd_MsgPort = NULL;
	Signal(cd->cd_Parent, SIGBREAKF_CTRL_F);
	Wait(0L);
}
