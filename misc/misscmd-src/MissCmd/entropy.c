#include "entropy.h"
#include <proto/exec.h>

entropy *OpenEntropy (void) {
	#ifdef __amigaos4__
	struct MsgPort *port;
	entropy *io;
	port = CreateMsgPort();
	io = (struct IOStdReq *)CreateIORequest(port, sizeof(struct IOStdReq));
	if (!io) {
		DeleteMsgPort(port);
		return NULL;
	}
	if (OpenDevice("timer.device", UNIT_ENTROPY, (struct IORequest *)io, 0)) {
		io->io_Device = NULL;
		CloseEntropy(io);
		return NULL;
	}
	return io;
	#else
	return (entropy *)0xDEADBEEF;
	#endif
}

void CloseEntropy (entropy *io) {
	#ifdef __amigaos4__
	if (io) {
		struct MsgPort *port;
		port = io->io_Message.mn_ReplyPort;
		if (io->io_Device) CloseDevice((struct IORequest *)io);
		DeleteIORequest((struct IORequest *)io);
		DeleteMsgPort(port);
	}
	#endif
}

void GenEntropy (entropy *io, void *ptr, int32 ln) {
	#ifdef __amigaos4__
	io->io_Command = TR_READENTROPY;
	io->io_Data = (uint8 *)ptr;
	io->io_Length = ln;
	DoIO((struct IORequest *)io);
	#endif
}
