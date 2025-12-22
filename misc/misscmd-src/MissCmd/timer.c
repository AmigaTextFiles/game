#include "main.h"

timer * OpenTimer (void) {
	struct MsgPort *port;
	timer *timer;
	port = CreateMsgPort();
	timer = (struct timerequest *)CreateIORequest(port, sizeof(struct timerequest));
	if (!timer) {
		DeleteMsgPort(port);
		return NULL;
	}
	if (OpenDevice("timer.device", UNIT_MICROHZ, (struct IORequest *)timer, 0)) {
		timer->tr_node.io_Device = NULL;
		CloseTimer(timer);
		return NULL;
	}
	return timer;
}

void CloseTimer (timer *timer) {
	if (timer) {
		struct MsgPort *port;
		port = timer->tr_node.io_Message.mn_ReplyPort;
		if (timer->tr_node.io_Device) CloseDevice((struct IORequest *)timer);
		DeleteIORequest((struct IORequest *)timer);
		DeleteMsgPort(port);
	}
}

void SetTimer (timer *timer, uint32 secs, uint32 micro) {
	timer->tr_node.io_Command = TR_ADDREQUEST;
	timer->tr_time.tv_secs = secs;
	timer->tr_time.tv_micro = micro;
	BeginIO((struct IORequest *)timer);
}

void AbortTimer (timer *timer) {
	if (!CheckIO((struct IORequest *)timer)) AbortIO((struct IORequest *)timer);
	WaitIO((struct IORequest *)timer);
}
