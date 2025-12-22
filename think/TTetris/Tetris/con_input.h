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

/* This struct is used to pass data from main task to key task, */
/* and also from key task to input handler. */
struct ControlData { 
	struct Task    *cd_Parent;
	struct Task    *cd_Task;
	struct MsgPort *cd_MsgPort;		/* points to port to send msg to on key/timer/quit events */
	ULONG           cd_State;		/* Pointer to a var which holds the State of keys in cd_Keys */
	char           *cd_Keys;		/* Raw key codes to act upon */
	struct TBoard  *cd_Board;
};

struct ControlMsg {
	struct Message cm_Msg;
	struct ControlData *cm_CData; /* Which task is this message coming from */
	ULONG cm_State;
};
