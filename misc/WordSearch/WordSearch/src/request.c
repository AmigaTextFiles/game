#include <exec/types.h>
#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/dos.h>
#include <intuition/intuition.h>
#include <graphics/display.h>

struct Window *Requestor_Window;
struct message *m=NULL;

struct IntuiText chip Body_Text =
   {0, 1, JAM1, 5, 10, NULL, (UBYTE *) "Click to abort New Key", NULL};

struct IntuiText chip Abort_Text =
   {0, 1, JAM1, 5, 3, NULL, (UBYTE *) "Abort", NULL};

void open_requestor()
   {
   Requestor_Window = BuildSysRequest
             (NULL, &Body_Text, NULL, &Abort_Text, GADGETUP, 280L, 60L);
   }

void close_requestor()
{
	while(m!=NULL)
	{
		ReplyMsg(m);
		m = GetMsg(Requestor_Window->UserPort);
	}
	
        FreeSysRequest (Requestor_Window);
}

BOOL Stop_Flag()
{
	if(m==NULL)
		m = GetMsg(Requestor_Window->UserPort);
	if(m==NULL)
		return(FALSE);
	else
		return(TRUE);	
}	 
