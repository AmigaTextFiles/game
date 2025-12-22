#include <exec/types.h>
#include <devices/input.h>
#include <exec/execbase.h>
#include <exec/interrupts.h>
#include <exec/io.h>
#include <proto/exec.h>
#include <proto/intuition.h>

long _stack = 4000;
char *_procname = "Intoxicated";
long _priority = 0;
long _BackGroundIO = 0;

extern struct ExecBase *SysBase;
struct IntuitionBase *IntuitionBase;

struct MsgPort *InputPort;
struct IOStdReq *InputReq;
struct Interrupt Handler;

extern struct MsgPort *CreatePort();
extern void DeletePort();
extern struct IOStdReq *CreateStdIO();
extern void DeleteStdIO();

extern struct InputEvent *MHandler();

struct
{
	struct Task *TaskAddr;
	BYTE Signal;
} Common;


int CXBRK()

{
	return(0);
}


void OpenAll()

{
	void CloseAll();
	
	if (!(IntuitionBase = (struct IntuitionBase *) OpenLibrary("intuition.library",0L)))  CloseAll();
	
	if ((Common.Signal = AllocSignal(-1L)) == -1)  CloseAll();
	Common.TaskAddr = SysBase->ThisTask;
	
	if (!(InputPort = CreatePort(NULL,0)))  CloseAll();
	if (!(InputReq = CreateStdIO(InputPort)))  CloseAll();
	if (OpenDevice("input.device",0,(struct IORequest *) InputReq,0))  CloseAll();
	Handler.is_Node.ln_Pri = 51;
	Handler.is_Node.ln_Name = "BrokenMouse_Input_Handler";
	Handler.is_Code = (void (*)) MHandler;
	InputReq->io_Command = IND_ADDHANDLER;
	InputReq->io_Data = (APTR) &Handler;
	SendIO((struct IORequest *) InputReq);
}


void CloseAll()

{
	if (InputReq->io_Command)
	{
		InputReq->io_Command = IND_REMHANDLER;
		InputReq->io_Data = (APTR) &Handler;
		DoIO((struct IORequest *) InputReq);
		CloseDevice((struct IORequest *) InputReq);
	};
	if (InputReq) DeleteStdIO(InputReq);
	if (InputPort) DeletePort(InputPort);
	
	if (Common.Signal)  FreeSignal(Common.Signal);
	
	if (IntuitionBase)  CloseLibrary((struct Library *) IntuitionBase);
	
	exit(0);
}


void _main()

{
	OpenAll();
	DisplayBeep(NULL);
	
	Wait(1 << Common.Signal);
	
	DisplayBeep(NULL);
	CloseAll();	
}

