/**
*** time.c -- AmyBoard clock functions
***
*** ------------------------------------------------------------------------
*** This program is free software; you can redistribute it and/or modify
*** it under the terms of the GNU General Public License as published by
*** the Free Software Foundation; either version 2 of the License, or
*** (at your option) any later version.
***
*** This program is distributed in the hope that it will be useful,
*** but WITHOUT ANY WARRANTY; without even the implied warranty of
*** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*** GNU General Public License for more details.
***
*** You should have received a copy of the GNU General Public License
*** along with this program; if not, write to the Free Software
*** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*** ------------------------------------------------------------------------
***
**/

/*** Includes section
*/
#include "amyboard.h"

#include <exec/io.h>
#include <devices/timer.h>
/**/





/*** Variable section
*/
struct timerequest *clockRequest    = NULL;
struct MsgPort *clockPort           = NULL;
BOOL clockRequestSent               = FALSE;
ULONG clockSignal;

struct timerequest *loadRequest     = NULL;
struct MsgPort *loadPort            = NULL;
BOOL loadRequestSent                = FALSE;
ULONG loadSignal;

ULONG timeSignals;
/**/





/*** AbortTimer function
*/
void AbortTimer(struct timerequest *tr)

{ AbortIO((struct IORequest *) tr);
  WaitIO((struct IORequest *) tr);
  SetSignal(0, 1 << tr->tr_node.io_Message.mn_ReplyPort->mp_SigBit);
}
/**/





/*** TimeClose function
***
***  time module termination
**/
VOID TimeClose(VOID)

{ if (clockRequestSent)
  { AbortTimer(clockRequest);
  }
  if (loadRequestSent)
  { AbortTimer(loadRequest);
  }
  if (clockRequest)
  { CloseDevice((struct IORequest *) clockRequest);
    DeleteIORequest(clockRequest);
  }
  if (clockPort)
  { DeleteMsgPort(clockPort);
  }
  if (loadRequest)
  { CloseDevice((struct IORequest *) loadRequest);
    DeleteIORequest(loadRequest);
  }
  if (loadPort)
  { DeleteMsgPort(loadPort);
  }
}
/**/





/*** TimeInit function
***
***  Time module initialization
**/
ULONG CreateTimeRequest(struct MsgPort **port, struct timerequest **req)

{ ULONG signal = 0;

  if ((*port = CreateMsgPort()))
  { signal = 1 << (*port)->mp_SigBit;
    if ((*req = CreateIORequest(*port, sizeof(**req))))
    { if (OpenDevice((STRPTR) "timer.device", UNIT_MICROHZ,
		     (struct IORequest *) *req, 0))
      { DeleteIORequest(*req);
	*req = NULL;
      }
    }
  }
  return signal;
}
VOID TimeInit(VOID)

{ clockSignal = CreateTimeRequest(&clockPort, &clockRequest);
  loadSignal = CreateTimeRequest(&loadPort, &loadRequest);

  if (!clockRequest  ||  !loadRequest)
  { exit(10);
  }

  timeSignals = clockSignal | loadSignal;
}
/**/





/*** TimeCallback function
***
*** Called when one of the timers gets triggered.
**/
void TimeCallback(ULONG signals)

{ if (signals & clockSignal)
  { WaitIO((struct IORequest *) clockRequest);
    clockRequestSent = FALSE;
    DecrementClocks();
  }
  if (signals & loadSignal)
  { WaitIO((struct IORequest *) loadRequest);
    loadRequestSent = FALSE;
    LoadGameLoop();
  }
}
/**/





/*** StartAnyTimer function
*/
void StartAnyTimer(struct timerequest *tr, long millisec)

{
  /**
  ***  No real need for this "if", just to avoid one
  ***  division, if possible.
  **/
  if (millisec > 999)
  { tr->tr_time.tv_secs = millisec / 1000;
    tr->tr_time.tv_micro = (millisec % 1000) * 1000;
  }
  else
  { tr->tr_time.tv_secs = 0;
    tr->tr_time.tv_micro = millisec * 1000;
  }
  tr->tr_node.io_Command = TR_ADDREQUEST;
  SendIO((struct IORequest *) tr);
}
/**/






/*** StartClockTimer function
*/
void StartClockTimer(long millisec)

{
  if (clockRequestSent)
  { DisplayFatalError("Internal error: Time request already sent.\n", 0, 10);
  }
  StartAnyTimer(clockRequest, millisec);
  clockRequestSent = TRUE;
}
/**/





/*** StopClockTimer function
*/
int StopClockTimer(void)

{
  if (clockRequestSent)
  { AbortTimer(clockRequest);
    clockRequestSent = FALSE;
    return(TRUE);
  }
  else
  { return(FALSE);
  }
}
/**/





/*** StartLoadGameTimer function
*/
void StartLoadGameTimer(long millisec)

{ if (loadRequestSent)
  { DisplayFatalError("Internal error: Time request already sent.\n", 0, 10);
  }
  StartAnyTimer(loadRequest, millisec);
  loadRequestSent = TRUE;
}
/**/





/*** StopLoadGameTimer function
*/
int StopLoadGameTimer(void)

{ if (loadRequestSent)
  { AbortTimer(loadRequest);
    loadRequestSent = FALSE;
    return(TRUE);
  }
  else
  { return(FALSE);
  }
}
/**/
