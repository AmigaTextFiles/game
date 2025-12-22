/* TimerDevice.c ************************************************************
*
*	TimerDevice ---	Some useful timer.device control routines.
*
*	Author --------	Olaf Barthel, ED Electronic Design Hannover
*			Brabeckstrasse 35
*			D-3000 Hannover 71
*
*			Federal Republic of Germany
*
****************************************************************************/

#include <exec/types.h>
#include <devices/timer.h>
#include <exec/memory.h>

	/* Structures we need, these don't need to be visible to
	 * other modules.
	 */

struct timerequest	*tr_TimerRequest= NULL,*AllocMem();
struct MsgPort		*tr_TimerPort	= NULL,*CreatePort();

	/* CloseTimerDevice() :
	 *
	 *	Deallocate the control structures.
	 */

void
CloseTimerDevice()
{
	if(tr_TimerRequest)
	{
		CloseDevice(tr_TimerRequest);
		FreeMem(tr_TimerRequest,sizeof(struct timerequest));
	}

	if(tr_TimerPort)
		DeletePort(tr_TimerPort);
}

	/* OpenTimerDevice() :
	 *
	 *	Initialize the precision timer.
	 */

BOOL
OpenTimerDevice()
{
	if(!(tr_TimerPort = (struct MsgPort *)CreatePort(NULL,0)))
		return(FALSE);

	if(!(tr_TimerRequest = (struct timerequest *)AllocMem(sizeof(struct timerequest),MEMF_PUBLIC | MEMF_CLEAR)))
	{
		DeletePort(tr_TimerPort);
		return(FALSE);
	}

	if(OpenDevice(TIMERNAME,UNIT_VBLANK,tr_TimerRequest,0))
	{
		FreeMem(tr_TimerRequest,sizeof(struct timerequest));
		DeletePort(tr_TimerPort);
		return(FALSE);
	}

	tr_TimerRequest -> tr_node . io_Message . mn_ReplyPort	= tr_TimerPort;
	tr_TimerRequest -> tr_node . io_Command			= TR_ADDREQUEST;
	tr_TimerRequest -> tr_node . io_Flags			= 0;
	tr_TimerRequest -> tr_node . io_Error			= 0;

	return(TRUE);
}

	/* WaitTime(Seconds,Micros) :
	 *
	 *	Wait a period of time.
	 */

void
WaitTime(Seconds,Micros)
register ULONG Seconds,Micros;
{
	tr_TimerRequest -> tr_time . tv_secs	= Seconds;
	tr_TimerRequest -> tr_time . tv_micro	= Micros;

	DoIO(tr_TimerRequest);
}
