/**
***  childio.c  -- Internal pipe for child process communications
***
*** ------------------------------------------------------------------------
***  This program is free software; you can redistribute it and/or modify
***  it under the terms of the GNU General Public License as published by
***  the Free Software Foundation; either version 2 of the License, or
***  (at your option) any later version.
***
***  This program is distributed in the hope that it will be useful,
***  but WITHOUT ANY WARRANTY; without even the implied warranty of
***  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
***  GNU General Public License for more details.
***
***  You should have received a copy of the GNU General Public License
***  along with this program; if not, write to the Free Software
***  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*** ------------------------------------------------------------------------
***
***
***  Process communication is done using a second Process, which acts as a
***  handler. It would be possible to manage everything with one process,
***  but the increase of speed is not that much and it simplifies things.
***  It would as well be possible to use a separate pipe handler, but there
***  are a few problems:
***
***  - Usual pipes ("PIPE:" for example) don't work interactively. The
***    reading process has to wait until the writing process closes the
***    file.
***  - The first point could be solved by writing an own handler which
***    would do quite the same as our internal handler. But we would
***    need a MountList entry and it would not be possible to remove
***    this handler.
***
***  I recommend chapter 21 of Ralph Babel's "Guru book" for a complete
***  understanding of what's going on here. (And, BTW, thanks, Ralph,
***  for your explanations at IRC!)
**/





/***  Includes section
*/
#include "amyboard.h"

#include <ctype.h>
#include <fcntl.h>

#include <exec/memory.h>
#include <dos/dosextens.h>
#include <dos/dostags.h>
#include <rexx/rexxio.h>

#if defined(__GNUC__)
extern BPTR *__stdfiledes;
#define fdtofh(a) (__stdfiledes[a])
#endif
/**/




/*** Type definitions
*/
typedef struct              /*  Our private extension of the MinNode    */
{ struct Node *succ;
  struct Node *pred;
  ULONG size;
} MyMinNode;

typedef struct              /*  This structure is created for every     */
{ MyMinNode node;           /*  filehandle that is waiting for input,   */
  struct DosPacket *dp;     /*  if no input is available yet.           */
} ReadRequest;

typedef struct              /*  This structure is created, if a filehandle  */
{ MyMinNode node;           /*  wants to write output, but the ReadRequests */
  ULONG numBytes;           /*  available aren't sufficient. numBytes is    */
  ULONG written;            /*  the available number of bytes, written      */
  UBYTE *buffer;            /*  is the number of bytes already written.     */
} WriteRequest;

typedef struct              /*  A pointer to this structure is stored in    */
{ APTR pipe;                /*  the fh_Arg1 entry of the filehandle.        */
} XBoardFileHandle;

typedef struct              /*  This structure implements one pipe.         */
{ MyMinNode node;           /*  Note, that always almost one of the two     */
  struct MinList rreqList;  /*  lists is empty.                             */
  struct MinList wreqList;
  XBoardFileHandle *readFH;
  XBoardFileHandle *writeFH;
} XBoardPipe;

/**/






/***  Macro section
*/
#define RemoveMyMinNode(mmn) \
  { Remove((struct Node *)mmn); \
    LibFreePooled(pipesPool, mmn, (mmn)->size); \
  }
#define CreateMyMinNode(len) LibAllocPooled(pipesPool, (len))
/**/




/*** Variable section
*/
struct Process *handlerProcess  = NULL;
struct MsgPort *pipesPort       = NULL;
struct DosPacket *pipesPacket   = NULL;
APTR pipesPool                  = NULL;
ULONG pipeSignals;
struct MinList inputSourceList;
struct MinList childProcessList;
/**/




/*** xboardPipesHandler function
***
***  This is the equivalent to the handlers main. It is
***  the entry point of the second process and called via
**   CreateNewProc().
**/
#ifdef DEBUG_HANDLER
void kprints(char *buffer, int len)

{ int i;

  kprintf("(%ld bytes, ", len);
  for (i = len;  i;  i--)
  { char c = *buffer++;

    switch(c)
    { case '\n':
	kprintf("\\n");
	break;
      case '\0':
	kprintf("\\0");
	break;
      case '\t':
	kprintf("\\t");
	break;
      case '\r':
	kprintf("\\r");
	break;
      default:
	kprintf("%lc", c);
    }
  }
  kprintf(")\n");
}
#endif
extern VOID xboardPipesHandler(VOID);
_SAVEDS_FUNC(VOID, xboardPipesHandler) (VOID)

{ struct MsgPort *messagePort;
  struct DosPacket *dosPacket;
  struct DosPacket *diePacket = NULL;
  struct MinList xboardPipesList; /*  List of open pipes.             */
  struct Message *currentMessage;

  messagePort = &((struct Process *) FindTask(NULL))->pr_MsgPort;
  NewList((struct List *) &xboardPipesList);

  /**
  ***  Never ending loop to process the incoming packets.
  **/
  for (;;)
  { WaitPort(messagePort);
    while((currentMessage = GetMsg(messagePort)))
    { dosPacket = (struct DosPacket *) currentMessage->mn_Node.ln_Name;
      switch(dosPacket->dp_Type)
      { case ACTION_FINDINPUT:
	case ACTION_FINDOUTPUT:
	case ACTION_FINDUPDATE:
	{ XBoardPipe *xp;
	  XBoardFileHandle *xfh;
	  struct FileHandle *fh;

	  /**
	  ***  Create a FileHandle.
	  **/
	  if ((xfh = CreateMyMinNode(sizeof(*xfh)))  ==  NULL)
	  { ReplyPkt(dosPacket, DOSFALSE, ERROR_NO_FREE_STORE);
#ifdef DEBUG_HANDLER
#define kprinta(type)                         \
	    switch(type)                      \
	    { case ACTION_FINDINPUT:          \
		kprintf("ACTION_FINDINPUT");  \
		break;                        \
	      case ACTION_FINDOUTPUT:         \
		kprintf("ACTION_FINDOUTPUT"); \
		break;                        \
	      case ACTION_FINDUPDATE:         \
		kprintf("ACTION_FINDUPDATE"); \
		break;                        \
	    }
	    kprintf("Handler: ");
	    kprinta(dosPacket->dp_Type);
	    kprintf(" failed, memory error");
#endif
	    break;
	  }

	  if (dosPacket->dp_Type == ACTION_FINDINPUT)
	  { /**
	    ***  If it is a read filehandle: Connect it to the last opened
	    ***  pipe. This would not make much sense in a public handler,
	    ***  but works fine for us.
	    **/
	    xp = (XBoardPipe *) xboardPipesList.mlh_TailPred;
	    xp->readFH = xfh;
	  }
	  else
	  { /**
	    ***  If it is a writing filehandle: Create a new pipe.
	    **/
	    if ((xp = CreateMyMinNode(sizeof(*xp)))  ==  NULL)
	    { ReplyPkt(dosPacket, DOSFALSE, ERROR_NO_FREE_STORE);
	      LibFreePooled(pipesPool, xfh, sizeof(*xfh));
#ifdef DEBUG_HANDLER
	      kprintf("Handler: ");
	      kprinta(dosPacket->dp_Type);
	      kprintf(" failed, memory error");
#endif
	      break;
	    }
	    xp->node.size = sizeof(*xp);
	    xp->writeFH = xfh;
	    xp->readFH = NULL;
	    AddTail((struct List *) &xboardPipesList, (struct Node *) xp);
	    NewList((struct List *) &xp->rreqList);
	    NewList((struct List *) &xp->wreqList);
	  }

	  xfh->pipe = xp;
	  fh = (struct FileHandle *) BADDR(dosPacket->dp_Arg1);
	  fh->fh_Arg1 = (LONG) xfh;
	  fh->fh_Port = (struct MsgPort *) DOSTRUE;
	  if (dosPacket->dp_Type == ACTION_FINDUPDATE)
	  { fh->fh_Type = pipesPort;    /*  Packets will be sent to the */
	  }                             /*  XBoard process immediately. */

	  ReplyPkt(dosPacket, DOSTRUE, 0);

#ifdef DEBUG_HANDLER
	  kprintf("Handler: ");
	  kprinta(dosPacket->dp_Type);
	  kprintf(": Pipe %08lx, FileHandle %08lx created.\n",
		  xp, xfh);
#endif
	  break;
	}
	case ACTION_READ:
	{ XBoardPipe *xp;
	  XBoardFileHandle *xfh;
	  WriteRequest *wreq;
	  ReadRequest *rreq;

	  xfh = (XBoardFileHandle *) dosPacket->dp_Arg1;
	  xp = xfh->pipe;

	  /**
	  ***  Fail, if this is not the reading filehandle.
	  **/
	  if (xfh  !=  xp->readFH)
	  {
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_READ, Pipe %08lx, FileHandle %08lx:\n"
		    "         Not reading filehandle, failed.\n",
		    xp, xfh);
#endif
	    ReplyPkt(dosPacket, 0, ERROR_OBJECT_WRONG_TYPE);
	    break;
	  }

	  /**
	  ***  Check, if a WriteRequest is waiting.
	  **/
	  wreq = (WriteRequest *) xp->wreqList.mlh_Head;
	  if (wreq->node.succ)
	  { ULONG bytesToWrite;

	    bytesToWrite = MIN(wreq->numBytes - wreq->written,
			       dosPacket->dp_Arg3);
	    CopyMem(wreq->buffer + wreq->written,
		    (void *) dosPacket->dp_Arg2,
		    bytesToWrite);
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_READ, Pipe %08lx, FileHandle %08lx:\n"
		    "         Wrote from write request %08lx ",
		    xp, xfh, wreq);
	    kprints((char *) dosPacket->dp_Arg2, bytesToWrite);
#endif
	    ReplyPkt(dosPacket, bytesToWrite, 0);
	    wreq->written += bytesToWrite;

	    if (wreq->written  ==  wreq->numBytes)
	    { RemoveMyMinNode((MyMinNode *) wreq);
	    }
	    break;
	  }


	  /**
	  ***  Return EOF, if the writing filehandle is closed.
	  **/
	  if (!xp->writeFH)
	  {
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_READ, Pipe %08lx, FileHandle %08lx:\n"
		    "         Sent EOF.\n",
		    xp, xfh);
#endif
	    ReplyPkt(dosPacket, 0, 0);
	    break;
	  }

	  /**
	  ***  Otherwise create a ReadRequest.
	  **/
	  if ((rreq = CreateMyMinNode(sizeof(*rreq)))  ==  NULL)
	  {
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_READ, Pipe %08lx, FileHandle %08lx:\n"
		    "         Failed to create read request, memory error.\n",
		    xp, xfh);
#endif
	    ReplyPkt(dosPacket, 0, ERROR_NO_FREE_STORE);
	    break;
	  }
	  rreq->node.size = sizeof(*rreq);
	  rreq->dp = dosPacket;
	  AddTail((struct List *) &xp->rreqList, (struct Node *) rreq);
#ifdef DEBUG_HANDLER
	  kprintf("Handler: ACTION_READ, Pipe %08lx, FileHandle %08lx:\n"
		  "         Created read request %08lx.\n",
		  xp, xfh, rreq);
#endif
	  break;
	}
	case ACTION_WRITE:
	{ XBoardPipe *xp;
	  XBoardFileHandle *xfh;
	  ReadRequest *rreq;
	  ULONG written = 0;
	  ULONG toWrite;

	  xfh = ((XBoardFileHandle *) dosPacket->dp_Arg1);
	  xp = xfh->pipe;
	  toWrite = dosPacket->dp_Arg3;

	  /**
	  ***  Fail, if this is not the writing filehandle.
	  **/
	  if (dosPacket->dp_Arg1  !=  (LONG) xp->writeFH)
	  {
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_WRITE, Pipe %08lx, FileHandle %08lx:\n"
		    "         Not writing filehandle, failed.\n",
		    xp, xfh);
#endif
	    ReplyPkt(dosPacket, 0, ERROR_OBJECT_WRONG_TYPE);
	    break;
	  }

	  /**
	  ***  Fail, if the reading filehandle is closed.
	  **/
	  if (!xp->readFH)
	  {
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_WRITE, Pipe %08lx, FileHandle %08lx:\n"
		    "         Reading filehandle closed, failed.\n",
		    xp, xfh);
#endif
	    ReplyPkt(dosPacket, 0, ERROR_OBJECT_NOT_FOUND);
	    break;
	  }

	  /**
	  ***  Check, if ReadRequests are waiting.
	  **/
	  while (toWrite > 0  &&
		 (rreq = (ReadRequest *) xp->rreqList.mlh_Head)->node.succ)
	  { ULONG bytesToWrite;

	    bytesToWrite = MIN(toWrite, rreq->dp->dp_Arg3);
	    CopyMem((STRPTR) dosPacket->dp_Arg2 + written,
		    (STRPTR) rreq->dp->dp_Arg2,
		    bytesToWrite);

#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_WRITE, Pipe %08lx, FileHandle %08lx:\n"
		    "         Wrote to read request %08lx ",
		    xp, xfh, rreq);
	    kprints((STRPTR) rreq->dp->dp_Arg2, bytesToWrite);
#endif
	    ReplyPkt(rreq->dp, bytesToWrite, 0);
	    written += bytesToWrite;
	    toWrite -= bytesToWrite;
	    RemoveMyMinNode((MyMinNode *) rreq);
	  }

	  /**
	  ***   If bytes are still remaining: Create a write request.
	  **/
	  if (toWrite > 0)
	  { WriteRequest *wreq;

	    if (!(wreq = CreateMyMinNode(sizeof(*wreq) + toWrite)))
	    {
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_WRITE, Pipe %08lx, FileHandle %08lx:\n"
		    "         Failed to create write request, memory error.\n",
		    xp, xfh);
#endif
	      ReplyPkt(dosPacket, written, ERROR_NO_FREE_STORE);
	      break;
	    }
	    wreq->node.size = sizeof(*wreq) + toWrite;
	    wreq->numBytes = toWrite;
	    wreq->buffer = ((UBYTE *) wreq) + sizeof(*wreq);
	    wreq->written = 0;
	    CopyMem((UBYTE *) dosPacket->dp_Arg2 + written,
		    wreq->buffer,
		    toWrite);
	    AddTail((struct List *) &xp->wreqList, (struct Node *) wreq);
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_WRITE, Pipe %08lx, FileHandle %08lx:\n"
		    "         Create write request %08lx ",
		    xp, xfh, wreq);
	    kprints(wreq->buffer, toWrite);
	    kprintf("         write request List:\n");
	    { WriteRequest *wreq;
	      for (wreq = (WriteRequest *) xp->wreqList.mlh_Head;
		   wreq->node.succ;
		   wreq = (WriteRequest *) wreq->node.succ)
	      { kprintf("        %08lx ");
		kprints(wreq->buffer+wreq->written, wreq->numBytes-wreq->written);
	      }
	    }
#endif
	  }

	  ReplyPkt(dosPacket, dosPacket->dp_Arg3, 0);
	  break;
	}
	case ACTION_WAIT_CHAR:
	{ XBoardPipe *xp;
	  XBoardFileHandle *xfh;
	  WriteRequest *wreq;

	  xfh = (XBoardFileHandle *) dosPacket->dp_Arg2;
	  xp = xfh->pipe;

	  /**
	  ***  Fail, if this is not the reading filehandle.
	  **/
	  if (xfh  !=  xp->readFH)
	  {
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_WAIT_CHAR, Pipe %08lx, FileHandle %08lx:\n"
		    "         Not reading filehandle, failed.\n",
		    xp, xfh);
#endif
	    ReplyPkt(dosPacket, 0, ERROR_OBJECT_WRONG_TYPE);
	    break;
	  }

	  /**
	  ***  Fail, if the timeout argument is nonzero.
	  **/
	  if (dosPacket->dp_Arg1)
	  {
#ifdef DEBUG_HANDLER
	    kprintf("Handler: ACTION_WAIT_CHAR, Pipe %08lx, FileHandle %08lx:\n"
		    "         Nonzero timeout argument, failed.\n",
		    xp, xfh);
#endif
	    ReplyPkt(dosPacket, 0, ERROR_ACTION_NOT_KNOWN);
	    break;
	  }

	  /**
	  ***  Check, if a WriteRequest is waiting.
	  **/
	  wreq = (WriteRequest *) xp->wreqList.mlh_Head;
#ifdef DEBUG_HANDLER
	  kprintf("Handler: ACTION_WAIT_CHAR, Pipe %08lx, FileHandle %08lx:\n"
		  "         Returning %s.\n",
		  xp, xfh, wreq->node.succ ? "DOSTRUE" : "DOSFALSE");
#endif
	  ReplyPkt(dosPacket, wreq->node.succ ? DOSTRUE : DOSFALSE, 0);
	  break;
	}
	case ACTION_END:
	{ XBoardPipe *xp;
	  XBoardFileHandle *xfh;


	  xfh = (XBoardFileHandle *) dosPacket->dp_Arg1;
	  xp = xfh->pipe;

	  /**
	  ***  If this is the writing filehandle: Send EOF to the reading
	  ***  filehandle.
	  **/
	  if (xfh == xp->writeFH)
	  { ReadRequest *rreq;

	    xp->writeFH = NULL;
	    while ((rreq = (ReadRequest *) xp->rreqList.mlh_Head)->node.succ)
	    { ReplyPkt(rreq->dp, 0, 0);
	      RemoveMyMinNode((MyMinNode *) rreq);
	    }
	  }
	  /**
	  ***  If it is the reading filehandle: Remove any write requests.
	  **/
	  else
	  { WriteRequest *wreq;

	    xp->readFH = NULL;
	    while((wreq = (WriteRequest *) xp->wreqList.mlh_Head)->node.succ)
	    { RemoveMyMinNode((MyMinNode *) wreq);
	    }
	  }
#ifdef DEBUG_HANDLER
	  kprintf("Handler: ACTION_END, Pipe %08lx, FileHandle %08lx.\n",
		  xp, xfh);
#endif
	  LibFreePooled(pipesPool, xfh, sizeof(*xfh));

	  if (!xp->writeFH  &&  !xp->readFH)
	  { RemoveMyMinNode((MyMinNode *) xp);
	  }

	  ReplyPkt(dosPacket, DOSTRUE, 0);

	  if (!diePacket)
	  { break;
	  }
	}
	case ACTION_DIE:
	  if (!diePacket)
	  { diePacket = dosPacket;
	  }
	  if (!xboardPipesList.mlh_Head->mln_Succ)
	  { ReplyPkt(diePacket, DOSTRUE, 0);
	    CloseLibrary((struct Library *) DOSBase);
#ifdef DEBUG_HANDLER
	    kprintf("Handler: Terminating.\n");
#endif
	    return;
	  }
	  break;
	case ACTION_IS_FILESYSTEM:
#ifdef DEBUG_HANDLER
	  kprintf("Handler: ACTION_IS_FILESYSTEM.\n");
#endif
	  ReplyPkt(dosPacket, DOSFALSE, 0);
	  break;
	case ACTION_SEEK:
#ifdef DEBUG_HANDLER
	  kprintf("Handler: ACTION_SEEK.\n");
#endif
	  ReplyPkt(dosPacket, -1, ERROR_ACTION_NOT_KNOWN);
	  break;
	case ACTION_SET_FILE_SIZE:
#ifdef DEBUG_HANDLER
	  kprintf("Handler: ACTION_SET_FILE_SIZE.\n");
#endif
	  ReplyPkt(dosPacket, -1, ERROR_ACTION_NOT_KNOWN);
	  break;
	default:
#ifdef DEBUG_HANDLER
	  kprintf("Handler: Action %ld.\n", dosPacket->dp_Type);
#endif
	  ReplyPkt(dosPacket, DOSFALSE, ERROR_ACTION_NOT_KNOWN);
	  break;
      }
    }
  }
}
/**/





/*** pipeClose function
***
***  Close() replacement
**/
BOOL pipeClose(BPTR file)

{ struct FileHandle *fh;

  if (file)
  { fh = (struct FileHandle *) BADDR(file);
    fh->fh_Type = &handlerProcess->pr_MsgPort;
    return(Close(file));
  }
  return(TRUE);
}
/**/





/*** pipe function
***
***  Creates a pipe.
***
***  Inputs: fhs - a pointer to an array of BPTR's where to store
***             FileHandle's of the writing (element 0) and the
***             reading end (element 1) of the pipe. These
***             filehandles may be used for calls of Read(), Write()
***             Close() or ReadASync().
***          mode - one of MODE_NEWFILE or MODE_READWRITE, which will
***             be used to create the writing end of the pipe
***
***  Result: TRUE for sucess, FALSE otherwise; you are guaranteed,
***     that no files are open in the latter case.
**/
int pipe(BPTR *fhs, ULONG mode)

{ struct MsgPort *oldconsoletask;
  int result = FALSE;

  oldconsoletask = SetConsoleTask(&handlerProcess->pr_MsgPort);

  fhs[0] = fhs[1] = (BPTR) NULL;

  if ((fhs[0] = Open((STRPTR) "CONSOLE:", mode)))
  { if ((fhs[1] = Open((STRPTR) "CONSOLE:", MODE_OLDFILE)))
    { result = TRUE;
    }
    else
    { pipeClose(fhs[0]);
      fhs[0] = (BPTR) NULL;
    }
  }

  SetConsoleTask(oldconsoletask);
  return(result);
}
/**/






/*** Child communication section
**/
#define CPUser 1
#define CPProc 2
#define CPLoop 3

typedef int CPKind;

typedef struct {
    struct MinNode node;
    CPKind kind;
    BPTR from[2], to[2];
    BPTR msgFileHandle;
    STRPTR name;
    struct Process *proc;
} ChildProc;

void InterruptChildProcess(ProcRef pr)

{ ChildProc *cp = pr;

  if (cp->proc)
  { Signal((struct Task *) cp->proc, SIGBREAKF_CTRL_C);
  }
}

void DestroyChildProcess(ProcRef pr)

{ ChildProc *cp;

  for (cp = (ChildProc *) childProcessList.mlh_Head;
       cp->node.mln_Succ;
       cp = (ChildProc *) cp->node.mln_Succ)
  { if ((cp == (ChildProc *) pr))
    { int error;

      OutputToProcess(cp, "quit\n", 5, &error);
      pipeClose(cp->to[0]);
      pipeClose(cp->from[0]);
      pipeClose(cp->from[1]);
      pipeClose(cp->to[1]);
      Remove((struct Node *) cp);
      if (cp->name)
      { free(cp->name);
      }
      free(cp);
    }
  }
}





/**
***  This function starts a child process.
***
***  Inputs: cmdLine - the command to execute; first word will be
***             treated as binary to load, rest of line will be used
***             as arguments
***          pr - pointer where to store a process reference
***
***  Result: 0, if successful, error number otherwise
**/
int StartChildProcess(char *cmdLine, ProcRef *pr)

{ ChildProc *cp;
  int error = ENOMEM;

  if (appData.debugMode)
  { fprintf(debugFP, "Starting child process \"%s\".\n", cmdLine);
  }

  if ((cp = malloc(sizeof(*cp))))
  { AddTail((struct List *) &childProcessList, (struct Node *) cp);
    cp->kind = CPProc;
    cp->from[0] = cp->from[1] = (BPTR) NULL;
    cp->to[0] = cp->to[1] = (BPTR) NULL;
    cp->name = NULL;
    cp->proc = NULL;

    if ((pipe(cp->from, MODE_READWRITE)))
    { if ((pipe(cp->to, MODE_NEWFILE)))
      { cp->msgFileHandle = ((struct FileHandle *) BADDR(cp->from[0]))->fh_Arg1;

	if ((cp->name = (STRPTR) strdup(cmdLine)))
	{ BPTR lock;
	  STRPTR args, name;

	  /*
	      Let name point to the command name and args to the
	      arguments.
	  */
	  name = cp->name;
	  while (isspace(*name))
	  { name++;
	  }

	  if (*name == '"')
	  { name++;
	    if ((args = (STRPTR) strchr((char *) name, '"')))
	    { *args++ = '\0';
	    }
	    else
	    { args = (STRPTR) "";
	    }
	  }
	  else
	  { args = name;
	    while (*args  &&  !isspace(*args))
	    { ++args;
	    }
	    if (*args)
	    { *args++ = '\0';
	    }
	  }

	  if ((lock = Lock(name, SHARED_LOCK)))
	  { BPTR parentLock;

	    parentLock = ParentDir(lock);
	    UnLock(lock);

	    if (parentLock)
	    { BPTR segList;

	      if ((segList = NewLoadSeg(name, NULL)))
	      { cp->proc = CreateNewProcTags(
				NP_Seglist, segList,
				NP_Input, cp->to[1],
				NP_Output, cp->from[0],
				NP_StackSize, amigaAppData.childStack,
				NP_Name, FilePart(cp->name),
				NP_Priority, amigaAppData.childPriority,
				NP_HomeDir, parentLock,
				NP_CopyVars, FALSE,
				NP_Cli, TRUE,
				NP_CommandName, name,
				NP_Arguments, args,
				TAG_DONE);
		if (cp->proc)
		{
#ifdef DEBUG_HANDLER
		  kprintf("Childprocess `%s' created.\n", cmdLine);
#endif
		  cp->from[0] = (BPTR) NULL;
		  cp->to[1] = (BPTR) NULL;
		  *pr = cp;
		  return(0);
		}
		UnLoadSeg(segList);
	      }
	      UnLock(parentLock);
	    }
	  }
	  else
	  { error = ENOENT;
	  }
	}
      }
    }
  }

  DestroyChildProcess(cp);
  *pr = NULL;
  return(error);
}

int OpenLoopback(ProcRef *pr)

{ ChildProc *cp;
  int error = 0;

  if ((cp = malloc(sizeof(*cp))))
  { cp->kind = CPLoop;
    cp->from[0] = cp->from[1] = (BPTR) NULL;
    cp->to[0] = cp->to[1] = (BPTR) NULL;

    if (pipe(cp->to, MODE_READWRITE))
    { cp->msgFileHandle = cp->to[0];
      cp->from[1] = cp->to[1];
      cp->to[1] = (BPTR) NULL;
    }
    else
    { error = ENOMEM;
    }
  }
  else
  { error = ENOMEM;
  }

  return(error);
}
/**/





/**
***  Child process functions
**/
int OpenTelnet(char *host, char* port, ProcRef *pr)

{ char cmdLine[MSG_SIZ];

  sprintf(cmdLine, "%s %s %s", appData.telnetProgram, host, port);
  return(StartChildProcess(cmdLine, pr));
}

int OpenTCP(char *host, char* port, ProcRef *pr)

{ DisplayFatalError("Socket support is not configured in.", 0, 2);
  return(ENOENT);
}

int OpenCommPort(char *name, ProcRef *pr)

{ DisplayFatalError("Serial line support is not configured in.", 0, 2);
  return(ENOENT);
}

int OpenRcmd(char *host, char *user, char *cmd, ProcRef *pr)

{ DisplayFatalError("Internal rcmd not implemented.", 0, 10);
  return(-1);
}
/**/



/*** Input source section
*/
#define INPUT_SOURCE_BUF_SIZE 4096

typedef struct
{ struct MinNode node;
  CPKind kind;
  int lineByLine;
  InputCallback func;
  ChildProc *cp;
  struct MsgPort *mp;
  LONG cis_Arg1;
  FILE *fp;
  struct MsgPort *cisPort;
  struct DosPacket *dp;
  BOOL dpsent;
  char buf[INPUT_SOURCE_BUF_SIZE];
} InputSource;

void DoInputCallback(ULONG receivedsigs)

{ struct Message *msg;
  struct DosPacket *dp;
  InputSource *is;

  if (receivedsigs & (1 << pipesPort->mp_SigBit))
  { while((msg = GetMsg(pipesPort)))
    { dp = (struct DosPacket *) msg->mn_Node.ln_Name;

      switch (dp->dp_Type)
      { case ACTION_END:
	case ACTION_WRITE:
	  for (is = (InputSource *) inputSourceList.mlh_Head;
	       dp  &&  is->node.mln_Succ;
	       is = (InputSource *) is->node.mln_Succ)
	  { if (is->kind == CPProc  &&  is->cp->msgFileHandle == dp->dp_Arg1)
	    { if (dp->dp_Type == ACTION_END)
	      {
#ifdef DEBUG_HANDLER
		kprintf("DoInputCallback: ACTION_END, Arg1 = %ld.\n"
			"                 Telling frontend and sending to handler.\n",
			dp->dp_Arg1, dp->dp_Arg2, dp->dp_Arg3);
#endif
		PutMsg(&handlerProcess->pr_MsgPort, msg);
		(is->func)((InputSourceRef) is, is->buf, 0, 0);
	      }
	      else
	      { int len = dp->dp_Arg3;

		memcpy(is->buf, (char *) dp->dp_Arg2, len);
		is->buf[len] = NULLCHAR;
#ifdef DEBUG_HANDLER
		kprintf("DoInputCallback: ACTION_WRITE, Arg1 = %ld, Arg2 = %ld, Arg3 = %ld.\n"
			"                 Replying okay. ",
			dp->dp_Type, dp->dp_Arg1, dp->dp_Arg2, dp->dp_Arg3);
		kprints((char *) dp->dp_Arg2, dp->dp_Arg3);
#endif
		ReplyPkt(dp, len, 0);
		(is->func)((InputSourceRef) is, is->buf, len, 0);
	      }
	      dp = NULL;
	      break;
	    }
	  }
	  if (dp)
	  {
#ifdef DEBUG_HANDLER
	    if (dp->dp_Type == ACTION_END)
	    { kprintf("DoInputCallback: ACTION_END, Arg1 = %ld.\n"
		      "                 Sending to handler.\n",
		      dp->dp_Arg1, dp->dp_Arg2, dp->dp_Arg3);
	    }
	    else
	    { kprintf("DoInputCallback: Type = %ld, Arg1 = %ld, Arg2 = %ld, Arg3 = %ld.\n"
		      "                 Pipe unknown, replying okay. ",
		      dp->dp_Type, dp->dp_Arg1, dp->dp_Arg2, dp->dp_Arg3);
	      kprints((char *) dp->dp_Arg2, dp->dp_Arg3);
	    }
#endif
	    PutMsg(&handlerProcess->pr_MsgPort, msg);
	  }
	  break;

	default:
	  /**
	  ***  This is for the handler, redirect it.
	  **/
#ifdef DEBUG_HANDLER
	  kprintf("DoInputCallback: Type = %ld, Arg1 = %ld, Arg2 = %ld, Arg3 = %ld.\n"
		  "                 Redirecting to handler.\n",
		  dp->dp_Type, dp->dp_Arg1, dp->dp_Arg2, dp->dp_Arg3);
#endif
	  PutMsg(&handlerProcess->pr_MsgPort, msg);
	  break;
      }

    }
  }

  for (is = (InputSource *) inputSourceList.mlh_Head;
       is->node.mln_Succ;
       is = (InputSource *) is->node.mln_Succ)
  { if (is->kind == CPUser  &&  (receivedsigs & (1 << is->mp->mp_SigBit)))
    { msg = GetMsg(is->mp);
      dp = (struct DosPacket *) msg->mn_Node.ln_Name;
      if (dp == is->dp)
      { is->dpsent = FALSE;
	if (dp->dp_Res1 > 0)
	{ is->buf[dp->dp_Res1] = '\0';
	}
#ifdef DEBUG_HANDLER
	kprintf("DoInputCallback: ICS Input ");
	kprints((char *) dp->dp_Arg2, dp->dp_Res1);
#endif
	(is->func)((InputSourceRef) is, is->buf, dp->dp_Res1, 0);
	dp->dp_Type = ACTION_READ;
	dp->dp_Arg1 = is->cis_Arg1;
	dp->dp_Arg2 = (ULONG) is->buf;
	dp->dp_Arg3 = sizeof(is->buf)-1;
	SendPkt(dp, is->cisPort, is->mp);
	is->dpsent = TRUE;
      }
    }
  }
}


InputSourceRef AddInputSource(ProcRef pr, int lineByLine, InputCallback func)

{ InputSource *is;
  ChildProc *cp = (ChildProc *) pr;
  ULONG success = FALSE;;

  if ((is = (InputSource *) malloc(sizeof(*is))))
  { AddTail((struct List *) &inputSourceList, (struct Node *) is);
    is->lineByLine = lineByLine;
    is->func = func;
    is->cp = cp;
    is->fp = NULL;
    is->dp = NULL;
    is->mp = NULL;
    if (pr != NoProc)
    { is->kind = cp->kind;
      success = TRUE;
    }
    else
    { ULONG windowOpen = FALSE;

      /**
      ***  Open a window, if required.
      **/
      if (amigaAppData.icsWindow  ||  !Input()  ||  !Output())
      { char *winName;
	BPTR cos;

	if (!(winName = (char *) amigaAppData.icsWindow))
	{ winName = "CON:////ICS";
	}

	if ((is->fp = toUserFP = fopen(winName, "r+")))
	{ if ((cos = (BPTR) fdtofh(fileno(toUserFP))))
	  { is->cis_Arg1 = ((struct FileHandle *) BADDR(cos))->fh_Arg1;
	    is->cisPort = ((struct FileHandle *) BADDR(cos))->fh_Type;
	    windowOpen = TRUE;
	  }
	}
	if (!windowOpen)
	{ DisplayFatalError("Can't open window %s.\nOut of memory?", 0, 10);
	}
      }
      else
      { is->cis_Arg1 = ((struct FileHandle *) BADDR(Input()))->fh_Arg1;
	is->cisPort = ((struct FileHandle *) BADDR(Input()))->fh_Type;
	windowOpen = TRUE;
      }

      if (windowOpen)
      { is->kind = CPUser;
	is->dpsent = FALSE;
	if ((is->dp = AllocDosObject(DOS_STDPKT, NULL)))
	{ if ((is->mp = CreateMsgPort()))
	  { is->dp->dp_Type = ACTION_READ;
	    is->dp->dp_Arg1 = is->cis_Arg1;
	    is->dp->dp_Arg2 = (ULONG) is->buf;
	    is->dp->dp_Arg3 = sizeof(is->buf) - 1;
	    SendPkt(is->dp, is->cisPort, is->mp);
	    is->dpsent = TRUE;
	    success = TRUE;
	    pipeSignals |= (1 << is->mp->mp_SigBit);
	  }
	}
      }
    }
  }

  if (!success)
  { RemoveInputSource(is);
    is = NULL;
  }

  return(is);
}

void RemoveInputSource(InputSourceRef isr)

{ InputSource *is;

  for (is = (InputSource *) inputSourceList.mlh_Head;
       is->node.mln_Succ;
       is = (InputSource *) is->node.mln_Succ)
  { if (is == isr)
    { if (is->kind == CPUser)
      { if (is->dpsent)
	{ DoPkt3(is->cisPort, ACTION_STACK, is->cis_Arg1, (ULONG) "\n", 1);
	  AbortPkt(is->cisPort, is->dp);
	  WaitPort(is->mp);
	  GetMsg(is->mp);
	}
	if (is->mp)
	{ pipeSignals &= ~(1 << is->mp->mp_SigBit);
	  DeleteMsgPort(is->mp);
	}
	if (is->dp)
	{ FreeDosObject(DOS_STDPKT, is->dp);
	}
	if (is->fp)
	{ fclose(is->fp);
	}
      }
      else if (is->kind == CPProc)
      { DestroyChildProcess(is->cp);
      }

      Remove((struct Node *) is);
      free(is);
      break;
    }
  }
}

int OutputToProcess(ProcRef pr, char *message, int count, int *outError)

{ ChildProc *cp;
  int outCount;

  for (cp = (ChildProc *) childProcessList.mlh_Head;
       cp->node.mln_Succ;
       cp = (ChildProc *) cp->node.mln_Succ)
  { if (cp == (ChildProc *) pr)
    { if ((outCount = Write(cp->to[0], message, count))  ==  count)
      { *outError = 0;
      }
      else
      { *outError = ENOMEM;
      }
      return(outCount);
    }
  }
  *outError = ENOENT;
  return(0);
}
/**/




/*** popen function
***
***  *Very* simple replacement
**/
FILE *popen(const char *cmdLine, const char *mode)

{ char buf[L_tmpnam+5];
  FILE *fp = NULL;
  BPTR fileHandle;
  int error = ENOENT;

  strcpy(buf, "PIPE:");
  tmpnam(buf+5);

  if ((fileHandle = Open((STRPTR) buf, MODE_NEWFILE)))
  { if ((fp = fopen(buf, "r")))
    { if (!SystemTags((STRPTR) cmdLine, SYS_Output, fileHandle))
      { error = 0;
      }
      else
      { fclose(fp);
	fp = NULL;
      }
    }
    Close(fileHandle);
  }

  errno = error;
  return(fp);
}

int pclose(FILE *fp)

{ if (fp)
  { return(fclose(fp));
  }
  return(0);
}
/**/





/*** PipesClose function
***
***  Terminates the handler process by sending him
***  an ACTION_DIE packet and waiting for the reply.
***  (This guarantees, that the child process
***  terminates first.
**/
VOID PipesClose(VOID)

{ ChildProc *cp;
  InputSource *is;

  while ((is = (InputSource *) inputSourceList.mlh_Head)->node.mln_Succ)
  { RemoveInputSource((InputSourceRef) is);
  }

  while ((cp = (ChildProc *) childProcessList.mlh_Head)->node.mln_Succ)
  { DestroyChildProcess((ProcRef) cp);
  }

  if (handlerProcess)
  { pipesPacket->dp_Type = ACTION_DIE;
    SendPkt(pipesPacket, &handlerProcess->pr_MsgPort, pipesPort);
  }

  if (pipesPort)
  { ULONG childProcessRunning = TRUE;

    while (childProcessRunning)
    { struct Message *message;

      WaitPort(pipesPort);
      while ((message = GetMsg(pipesPort)))
      { struct DosPacket *dosPacket = (struct DosPacket *) message->mn_Node.ln_Name;

	switch (dosPacket->dp_Type)
	{ case ACTION_DIE:
	    childProcessRunning = FALSE;
	    break;
	  case ACTION_WRITE:
#ifdef DEBUG_HANDLER
	    kprintf("PipesClose: Type = %ld, Arg1 = %ld, Arg2 = %ld, Arg3 = %ld.\n"
		    "            Replying okay. ",
		    dosPacket->dp_Type, dosPacket->dp_Arg1, dosPacket->dp_Arg2, dosPacket->dp_Arg3);
	    kprints((char *) dosPacket->dp_Arg2, dosPacket->dp_Arg3);
#endif
	    ReplyPkt(dosPacket, dosPacket->dp_Arg3, 0);
	    break;
	  default:
#ifdef DEBUG_HANDLER
	    kprintf("PipesClose: Type = %ld, Arg1 = %ld, Arg2 = %ld, Arg3 = %ld.\n"
		    "            Redirecting to handler.\n",
		    dosPacket->dp_Type, dosPacket->dp_Arg1, dosPacket->dp_Arg2, dosPacket->dp_Arg3);
#endif
	    PutMsg(&handlerProcess->pr_MsgPort, message);
	    break;
	}
      }
    }
    DeleteMsgPort(pipesPort);
  }

  if (pipesPool)
  { LibDeletePool(pipesPool);
  }

  if (pipesPacket)
  { FreeDosObject(DOS_STDPKT, pipesPacket);
  }
}
/**/





/*** PpipesInit function
***
***  Initialize the handler.
**/
VOID PipesInit(VOID)

{ NewList((struct List *) &inputSourceList);
  NewList((struct List *) &childProcessList);

  /**
  ***  Allocate a dos packet
  **/
  if ((pipesPacket = AllocDosObject(DOS_STDPKT, NULL)))
  { if ((pipesPort = CreateMsgPort()))
    { pipeSignals = (1 << pipesPort->mp_SigBit);
      if ((pipesPool = LibCreatePool(MEMF_ANY, 4096, 2048)))
      { if ((handlerProcess = CreateNewProcTags(NP_Entry, xboardPipesHandler,
						NP_Name, "AmyBoard pipe handler",
						NP_CopyVars, FALSE,
						TAG_DONE)))
	{ return;
	}
      }

      DeleteMsgPort(pipesPort);
      pipesPort = NULL;
    }
  }
  exit(10);
}
/**/
