/* g_input.c */
#include <exec/types.h>
#include <exec/memory.h>
#include <exec/interrupts.h>
#include <devices/input.h>
#include <devices/inputevent.h>
#include <intuition/intuition.h>
#include <devices/gameport.h>

#include <clib/exec_protos.h>
#include <clib/alib_protos.h>
#include <clib/intuition_protos.h>

#include <stdio.h>
#include "g_input.h"

#define XMOVE 1
#define YMOVE 1

struct MsgPort *InputMP = NULL;
struct IOStdReq *InputIO = NULL;
struct Interrupt InputHandler;

struct input_state ips;

extern void __asm AsmHandler(void);


int init_input()
{
	int i;
	BYTE port = 0;      /* set mouse port to left controller */
	char NameString[] = "g_input_handler";

	if(InputMP = CreatePort(0,0)) {
		if(InputIO = (struct IOStdReq *) CreateExtIO(InputMP,sizeof(struct IOStdReq))) {
			if(OpenDevice("input.device",0L,(struct IORequest *)InputIO,0)) {
				printf("Could not open input.device\n");
				return 0;
			}
		}
	}
	
	/* set the mouse port */
	InputIO->io_Data = &port;
	InputIO->io_Flags = IOF_QUICK;
	InputIO->io_Command = IND_SETMPORT;
	BeginIO((struct IORequest*)InputIO);
	// this is often an error why? who cares, game doesn't use the mouse
	/*
	if(InputIO->io_Error) {
		//printf("error setting the mouse port\n");
		//return 0;
	}*/
	WaitIO((struct IORequest*)InputIO);

	ips.b1 = 0;
	ips.b2 = 0;
	ips.mx = 0;
	ips.my = 0;
	for(i = 0; i < 128; i++) ips.keys[i] = 0;

	// set up out input handler 
	InputHandler.is_Node.ln_Type = NT_INTERRUPT;
	InputHandler.is_Code = AsmHandler;
	InputHandler.is_Data = &ips;               
	InputHandler.is_Node.ln_Pri = 100;        
	InputHandler.is_Node.ln_Name = NameString; 

	InputIO->io_Data=(APTR)&InputHandler;    
	InputIO->io_Command=IND_ADDHANDLER;    
	DoIO((struct IORequest *)InputIO);   
	
	return 1;
}

void set_mouse_pos(WORD x, WORD y)
{
	struct InputEvent ie;

	ie.ie_NextEvent = NULL;
	ie.ie_Class = IECLASS_POINTERPOS;
	ie.ie_X = x * 2;
	ie.ie_Y = y * 2;
	//ie.ie_Qualifier = NULL;

	InputIO->io_Data = (APTR)&ie;
	InputIO->io_Command = IND_WRITEEVENT;    
	DoIO((struct IORequest *)InputIO);   
}



void close_input()
{
	InputIO->io_Data = (APTR)&InputHandler;
	InputIO->io_Command = IND_REMHANDLER;
	DoIO((struct IORequest *)InputIO);

	if(InputIO) CloseDevice((struct IORequest*)InputIO);
	if(InputMP) DeletePort(InputMP);
	if(InputIO) DeleteExtIO((struct IORequest*)InputIO);
}
