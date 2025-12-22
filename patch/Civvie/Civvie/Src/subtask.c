/* subtask.c
	vi:ts=3 sw=3:
	
	Civilization launcher
	Handles assigns, and communication with the main task to quit
	everything properly
 */

	/* to access AbsExecBase, as we're running free 
	 * (simpler than to pass SysBase around) */
#define _USEOLDEXEC_

#include <proto/dos.h>
#include <proto/exec.h>
#include <exec/memory.h>
#include <utility/tagitem.h>
#include <dos/dostags.h>
#include "proto.h"


	/* signal main task (sends a message) and die */
static void die(void)
	{
	struct MsgPort *p;
	struct Message *die_message;
		
		/* need cooperation: we don't stick around. The main task will
		 * free that message */
	die_message = AllocVec(sizeof(struct Message), MEMF_PUBLIC | MEMF_CLEAR);
	if (die_message)
		{
		die_message->mn_Node.ln_Type = NT_MESSAGE;
		die_message->mn_Length = sizeof(struct Message);
		die_message->mn_ReplyPort = 0;
		
		Forbid();
		
		p = FindPort(PORTNAME);
			/* in fact, we should always find p, as the main task never dies */
		if (p)
			PutMsg(p, die_message);
			/* note that we NEVER Permit(), since we're dead */
		}
	}

void civ_and_die(void)
	{
	struct Library *DOSBase;
		/* need to do everything ourselves, as we are running `free' */
	DOSBase = OpenLibrary("dos.library", 37);
	if (DOSBase)
		{
		BPTR lock;
			/* check for civ */
		lock = Lock("civ:", SHARED_LOCK);
		if (lock)
			{
				/* set up proper assigns, just note DupLocks */
			AssignLock("civ1", DupLock(lock));
			AssignLock("civ2", DupLock(lock));
			AssignLock("civ3", DupLock(lock));
			AssignLock("civ4", lock);
				
				/* this is simple-minded and assumes everything will work */
			AssignAdd("Fonts", Lock("civ:fonts", SHARED_LOCK));
			
				/* civ just needs a rather big stack */
			SystemTags("civ:civilization.exe", NP_StackSize, 30000, TAG_DONE);
			}
		CloseLibrary(DOSBase);
		}
	
		/* the dying part */
	die();
	}

	/* cooperation with subtask: once it's dead, it can't free its dying message */
void cleanup_subtask(struct MsgPort *port)
	{
	struct Message *msg;
	
	while (msg = GetMsg(port))
		FreeVec(msg);
	}
