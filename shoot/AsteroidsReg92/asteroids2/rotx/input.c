#include <exec/types.h>
#include <dos/dos.h>
#include <exec/memory.h>
#include <intuition/intuition.h>
#include <devices/gameport.h>
#include <devices/input.h>
#include <exec/interrupts.h>
#include <h/rot.h>
#include <h/extern.h>

struct MsgPort *timeport = NULL;
struct MsgPort *tport = NULL;
struct timerequest *timereq;
struct timerequest tr;

struct MsgPort *gameport = NULL;
struct IOStdReq *gamereq;
struct GamePortTrigger gpt = { GPTF_DOWNKEYS | GPTF_UPKEYS,30000,1,1 };
struct InputEvent joyevent;

struct MsgPort *inputDevPort;
struct IOStdReq *inputRequestBlock;
struct Interrupt handler;

ULONG class,code,qual;
ULONG gameportmask, timermask;


struct InputEvent *__saveds __asm __interrupt inputhandlercode(register __a0 struct InputEvent *);



HandleInput(player,type)
LONG player,type;
{

if (in.FIUP[type] == FALSE)
	if (--control.firecount[player] < 0)
	    {
		in.FI[type] = TRUE;
		control.firecount[player] = control.firedelay[player];
	    }

if (in.RT[type] == TRUE)
    {
	if (++ship[player].pos > 31)
		ship[player].pos= 0;
    }
if (in.LT[type] == TRUE)
    {
	if (--ship[player].pos <  0)
		ship[player].pos=31;
    }
if (in.TH[type] == TRUE) IncVelocity(player);
if (in.THUP[type] == TRUE)
    {
	FlushSound(1);
	in.THUP[type] = FALSE;
    }
if (in.FI[type] == TRUE)
    {
	control.firecount[player] = control.firedelay[player];

	if (control.fire[player] == 0) InitFire(player);
	else
	if (control.fire[player] == 1) InitDoubleFire(player);
	else
	if (control.fire[player] == 2) InitSuperFire(player);
	else						 InitBarrageFire(player);
    }

if (in.HY[type] == TRUE)
    {
	Hyperspace(player);
	in.HY[type] = FALSE;
    }
}


struct InputEvent *__asm __saveds __interrupt
inputhandlercode(register __a0 struct InputEvent *keyevent)
{

Forbid();
class = keyevent->ie_Class;
code = keyevent->ie_Code;
qual = keyevent->ie_Qualifier;

if ((class == IECLASS_RAWKEY) && ((qual&0xF00) != IEQUALIFIER_REPEAT))
    {
	in.KEY = code;

	if (code == k.fire)
	    {
		in.FI[0] = TRUE;
		in.FIUP[0] = FALSE;
	    }
	else
	if (code == k.fire+0x80) in.FIUP[0] = TRUE;
	else
	if (code == k.hyperspace) in.HY[0] = TRUE;
	else
	if (code == k.left+0x80)
	    {
		in.LT[0] = FALSE;
	    }
	else
	if (code == k.right+0x80)
	    {
		in.RT[0] = FALSE;
	    }
	else
	if (code == k.right)
	    {
		in.RT[0]=TRUE;
		in.LT[0]=FALSE;
	    }
	else
	if (code == k.left)
	    {
		in.LT[0]=TRUE;
		in.RT[0]=FALSE;
	    }
	else
	if (code == k.thrust) in.TH[0] = TRUE;
	else
	if (code == k.thrust+0x80)
	    {
		in.TH[0] = FALSE;
		in.THUP[0] = TRUE;
	    }
	else
	if (code == ESC) in.EXIT=TRUE;
	else
	if (code == k.pause) in.PAUSE=TRUE;
	else
	if (code == RET) in.NEXT = TRUE;
    }
Permit();

return(keyevent);
}


getjoystickinput()
{
LONG code,xx,yy;

if (GetMsg(gameport) != NULL)
{
code = joyevent.ie_Code;

gamereq->io_Command = GPD_READEVENT;
gamereq->io_Flags	= NULL;
gamereq->io_Data = (APTR)&joyevent;
gamereq->io_Length = (LONG)sizeof(struct InputEvent);
SendIO(gamereq);

if (code == IECODE_LBUTTON)
    {
	in.FI[1] = TRUE;
	in.FIUP[1] = FALSE;
    }
else
if (code == (IECODE_LBUTTON | IECODE_UP_PREFIX))
    {
	in.FIUP[1] = TRUE;
    }

xx = joyevent.ie_X;
yy = joyevent.ie_Y;

if (xx == 0)
    {
	in.LT[1] = FALSE;
	in.RT[1] = FALSE;
	in.HY[1] = FALSE;
    }
else
if (xx == 1)
    {
	in.RT[1] =TRUE;
	in.LT[1] =FALSE;
    }
else
if (xx == -1)
    {
	in.LT[1]=TRUE;
	in.RT[1]=FALSE;
    }

if (yy == -1) in.TH[1] = TRUE;
else
if (yy ==  1) 
    {
	if (in.HY[1] == FALSE) in.HY[1] = TRUE;
    }
else
if (yy ==  0)
    {
	in.TH[1] = FALSE;
	in.THUP[1] = TRUE;
    }
}
}



addgameport()
{
LONG error;
UBYTE joystick = GPCT_ABSJOYSTICK;
UBYTE type = 0;

gameport = (struct MsgPort *)CreatePort("test",NULL);
if (gameport == NULL)
    {
	makerequest("Gameport Error");
	Cleanup();
    }

gamereq = (struct IOStdReq *)CreateExtIO(gameport,sizeof(struct IOStdReq));
if (gamereq == NULL)
    {
	makerequest("Gameport IOStdReq Error");
	Cleanup();
    }

error = OpenDevice("gameport.device",1,(struct IORequest *)gamereq,NULL);
if (error != NULL)
    {
	makerequest("gameport.device Error");
	Cleanup();
    }

gamereq->io_Command = GPD_ASKCTYPE;
gamereq->io_Flags = IOF_QUICK;
gamereq->io_Length = 1;
gamereq->io_Data = (APTR)&type;
DoIO(gamereq);

if (type == GPCT_NOCONTROLLER)
    {
	gamereq->io_Command = GPD_SETCTYPE;
	gamereq->io_Flags = IOF_QUICK;
	gamereq->io_Data = (APTR)&joystick;
	gamereq->io_Length = 1;
	DoIO(gamereq);

	gamereq->io_Command = GPD_SETTRIGGER;
	gamereq->io_Flags = IOF_QUICK;
	gamereq->io_Data = (APTR)&gpt;
	gamereq->io_Length = (LONG)sizeof(struct GamePortTrigger);
	DoIO(gamereq);

	gamereq->io_Command = CMD_CLEAR;
	gamereq->io_Flags = IOF_QUICK;
	gamereq->io_Data	= NULL;
	gamereq->io_Length	= 0;
	DoIO(gamereq);

	gamereq->io_Command = GPD_READEVENT;
	gamereq->io_Flags	= NULL;
	gamereq->io_Data = (APTR)&joyevent;
	gamereq->io_Length = (LONG)sizeof(struct InputEvent);
	SendIO(gamereq);

	gameportmask = 1L << gameport->mp_SigBit;
    }
else
    {
	printf ("couldnt lock joystick port 1\n");
    }
}


removegameport()
{
UBYTE joystick = GPCT_NOCONTROLLER;

if (gamereq)
    {
	AbortIO(gamereq);
	WaitIO(gamereq);

	gamereq->io_Command = GPD_SETCTYPE;
	gamereq->io_Flags = IOF_QUICK;
	gamereq->io_Data = (APTR)&joystick;
	gamereq->io_Length = 1;
	DoIO(gamereq);

	CloseDevice((struct IORequest *)gamereq);
	DeleteExtIO((struct IORequest *)gamereq);
    }

if (gameport) DeletePort(gameport);
}


addhandler()
{
LONG error;

inputDevPort = (struct MsgPort *)CreatePort(NULL,NULL);
if (inputDevPort == NULL)
    {
	makerequest("Input Device Port Error");
	Cleanup();
    }

inputRequestBlock = (struct IOStdReq *)CreateExtIO(inputDevPort,sizeof(struct IOStdReq));
if (inputRequestBlock == NULL)
    {
	makerequest("Input IOStdReq Error");
	Cleanup();
    }

error = OpenDevice("input.device",NULL,(struct IORequest *)inputRequestBlock,NULL);
if (error != NULL)
    {
	makerequest("input.device Error");
	Cleanup();
    }

handler.is_Code = (void(*)())inputhandlercode;
handler.is_Data = (APTR)NULL;
handler.is_Node.ln_Pri = 60;

inputRequestBlock->io_Data = (APTR)&handler;
inputRequestBlock->io_Command= IND_ADDHANDLER;
DoIO((struct IORequest *)inputRequestBlock);
}



removehandler()
{

if (inputRequestBlock)
    {
	inputRequestBlock->io_Command= IND_REMHANDLER;
	inputRequestBlock->io_Data = (APTR)&handler;
	DoIO((struct IORequest *)inputRequestBlock);

	CloseDevice((struct IORequest *)inputRequestBlock);
	DeleteExtIO((struct IORequest *)inputRequestBlock);
    }

if (inputDevPort) DeletePort(inputDevPort);
}

addtimer()
{
LONG error;

timeport = (struct MsgPort *)CreatePort(NULL,NULL);
if (timeport == NULL)
    {
	makerequest("Timerport Error");
	Cleanup();
    }
timermask = 1L << timeport->mp_SigBit;

timereq = (struct timerequest *)CreateExtIO(timeport,sizeof(struct timerequest));
if (timereq == NULL)
    {
	makerequest("timerequest Error");
	Cleanup();
    }

error = OpenDevice(TIMERNAME,UNIT_MICROHZ,(struct IORequest *)timereq,NULL);
if (error != NULL)
    {
	makerequest("Cant Open Timer Devicer");
	Cleanup();
    }
}



removetimer()
{
if (timereq)
    {
	CloseDevice((struct IORequest *)timereq);
	DeleteExtIO((struct IORequest *)timereq);
    }

if (timeport) DeletePort(timeport);
}


timedelay(msecs)
LONG msecs;
{
timereq->tr_time.tv_secs = 0;
timereq->tr_time.tv_micro = msecs;
timereq->tr_node.io_Command = TR_ADDREQUEST;
SendIO((struct IORequest *)timereq);
}


waitfortimer()
{
ULONG actual=NULL;

while (!(actual & timermask))
    {
	actual = Wait(gameportmask | timermask);
	if (actual & gameportmask)
	    {
		getjoystickinput();
	    }
    }
WaitIO(timereq);
}
