/* watcher.c
	vi:ts=3 sw=3:
	
	Watches for civilization saves, stashing them properly (civmap)
	Awaits Civilization death (subtask messaging) to clean up everything
 */

#include <stdio.h>
#include <dos/notify.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <exec/memory.h>
#include "proto.h"

	/* event loop */
static void wait_loop(struct MsgPort *port, struct MsgPort *end)
	{
	struct NotifyMessage *msg;
	ULONG portmask, endmask, sigmask;
	
	endmask = 1 << end->mp_SigBit;
	if (port)
		portmask = 1 << port->mp_SigBit;
	else
		portmask = 0;

	do
	 	{
			
	 	sigmask = Wait(portmask | endmask);
		if (sigmask & portmask)
		 	while (msg = (struct NotifyMessage *)GetMsg(port))
				{
				int i = msg->nm_NReq->nr_UserData;
		   	ReplyMsg((struct Message *)msg);
		   	copy_save_file(i);
				} /* end when subtask signals us */
	 	} while((sigmask & endmask) == 0);
	}

void watcher(struct MsgPort *end_port)
	{
   struct MsgPort *port;
	struct NotifyRequest *nr[10];
   int i;
   static char buffer[10][20];

		/* the other port to watch for: notify requests */
   port = CreateMsgPort();
   if (port)
      {
			/* set up all notify requests */
      for (i = 0; i < 10; i++)
	 		{
			sprintf(buffer[i], "ram:civil%d.sve", i);
	 		nr[i] = AllocVec(sizeof(struct NotifyRequest), MEMF_CLEAR);
	 		if (nr[i])
	    		{
		      ULONG success;

				nr[i]->nr_Name = buffer[i];
	    		nr[i]->nr_UserData = i;
	    		nr[i]->nr_Flags = NRF_SEND_MESSAGE;
	    		nr[i]->nr_stuff.nr_Msg.nr_Port = port;
	    		success = StartNotify(nr[i]);
	    		if (success != DOSTRUE)
	       		{
	       		FreeVec(nr[i]);
	       		nr[i] = NULL;
	       		}
	    		}
	 		}
		}
		
		/* loop until subtask ends and sends a message to end_port */
	wait_loop(port, end_port);
		
			/* stop all existing notify requests */
   for (i = 0; i < 10; i++)
		if (nr[i])
	  		{
	  		EndNotify(nr[i]);
	  		FreeVec(nr[i]);
	  		}
	if (port)
      DeleteMsgPort(port);
   }
