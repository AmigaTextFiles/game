#ifdef AMIGA
  
#include <intuition/intuition.h>
  
/*
 *
 *    Author : Simon J Raybould.    (sie@fulcrum.bt.co.uk).
 *
 *    Date   : 25th January 1991.
 *
 *    Desc   : Amiga specific code for Larn
 *
 */
  
  
struct NewWindow nw = {
  0, 0, 640, 200, -1,-1, NULL, SMART_REFRESH|ACTIVATE|BORDERLESS, NULL,
  NULL, NULL, NULL, NULL, 0,0, 0,0, WBENCHSCREEN
};


/* Opens/allocations we'll need to clean up */
struct Library  *IntuitionBase = NULL;
struct Window   *win = NULL, *OpenWindow();
struct IOStdReq *writeReq = NULL;    /* I/O request block pointer */
struct MsgPort  *writePort = NULL;   /* replyport for writes      */   
struct IOStdReq *readReq = NULL;     /* I/O request block pointer */
struct MsgPort  *readPort = NULL;    /* replyport for reads       */   
struct MsgPort  *CreatePort();
BOOL OpenedConsole = FALSE;

#define AM_ECHO    1
#define AM_CBREAK  2

void CloseConsole(), ConPuts(), QueueRead(), AmEnd();
BYTE OpenConsole();
UBYTE ibuf, GetchFlags = AM_ECHO;

void AmInit()
{
  ULONG conreadsig, windowsig;
  BYTE error;
  
  if(!(IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library",0))) {
    printf("Can't open intuition\n");
    AmEnd();
    exit(10);
  }
  
  /* Create reply port and io block for writing to console */
  if(!(writePort = CreatePort("LARN.console.write",0))) {
    printf("Can't create write port\n");
    AmEnd();
    exit(10);
  }
  
  if(!(writeReq = (struct IOStdReq *)
       CreateExtIO(writePort,(LONG)sizeof(struct IOStdReq)))) {
    printf("Can't create write request\n");
    AmEnd();
    exit(10);
  }
  
  /* Create reply port and io block for reading from console */
  if(!(readPort = CreatePort("LARN.console.read",0))) {
    printf("Can't create read port\n");
    AmEnd();
    exit(10);
  }
  
  if(!(readReq = (struct IOStdReq *)
       CreateExtIO(readPort,(LONG)sizeof(struct IOStdReq)))) {
    printf("Can't create read request\n");
    AmEnd();
    exit(10);
  }
  /* Open a window */
  if(!(win = OpenWindow(&nw))) {
    printf("Can't open window\n");
    AmEnd();
    exit(10);
  }
  
  /* Now, attach a console to the window */
  if(error = OpenConsole(writeReq,readReq,win)) {
    printf("Can't open console.device\n");
    AmEnd();
    exit(10);
  } else
    OpenedConsole = TRUE;

  QueueRead(readReq,&ibuf); /* send the first console read request */
  conreadsig = 1 << readPort->mp_SigBit;
  windowsig = 1 << win->UserPort->mp_SigBit;
}

void AmEnd()
{
  if(OpenedConsole) {
    if(!(CheckIO(readReq))) AbortIO(readReq);
    WaitIO(readReq);
    CloseConsole(writeReq);
  }
  if(readReq)       DeleteExtIO(readReq);
  if(readPort)      DeletePort(readPort);
  if(writeReq)      DeleteExtIO(writeReq);
  if(writePort)     DeletePort(writePort);
  if(win)           CloseWindow(win);
  if(IntuitionBase) CloseLibrary(IntuitionBase);
}


/* Attach console device to an open Intuition window.
 * This function returns a value of 0 if the console 
 * device opened correctly and a nonzero value (the error
 * returned from OpenDevice) if there was an error.
 */
BYTE OpenConsole(writereq, readreq, window)
     struct IOStdReq *writereq;
     struct IOStdReq *readreq;
     struct Window *window;
{
  BYTE error;
  
  writereq->io_Data = (APTR) window;
  writereq->io_Length = sizeof(struct Window);
  error = OpenDevice("console.device", 0, writereq, 0);
  readreq->io_Device = writereq->io_Device; /* clone required parts */
  readreq->io_Unit   = writereq->io_Unit;
  return(error);   
}

void CloseConsole(struct IOStdReq *writereq)
{
  CloseDevice(writereq);
}

/* Output a single character to a specified console 
 */ 
void ConPutChar(struct IOStdReq *writereq, UBYTE character)
{
  writereq->io_Command = CMD_WRITE;
  writereq->io_Data = (APTR)&character;
  writereq->io_Length = 1;
  DoIO(writereq);
  /* command works because DoIO blocks until command is done
   * (otherwise ptr to the character could become invalid)
   */
}


/* Output a stream of known length to a console 
 */ 
void ConWrite(struct IOStdReq *writereq, UBYTE *string, LONG length)
{
  writereq->io_Command = CMD_WRITE;
  writereq->io_Data = (APTR)string;
  writereq->io_Length = length; 
  DoIO(writereq);
  /* command works because DoIO blocks until command is done
   * (otherwise ptr to string could become invalid in the meantime)
   */
}


/* Output a NULL-terminated string of characters to a console 
 */ 
void ConPuts(struct IOStdReq *writereq,UBYTE *string)
{
  writereq->io_Command = CMD_WRITE;
  writereq->io_Data = (APTR)string;
  writereq->io_Length = -1;  /* means print till terminating null */
  DoIO(writereq);
}

/* Queue up a read request to console, passing it pointer
 * to a buffer into which it can read the character
 */
void QueueRead(struct IOStdReq *readreq, UBYTE *whereto)
{
  readreq->io_Command = CMD_READ;
  readreq->io_Data = (APTR)whereto;
  readreq->io_Length = 1;
  SendIO(readreq);
}

/* Check if a character has been received.
 * If none, return -1 
 */
LONG ConMayGetChar(struct MsgPort *msgport, UBYTE *whereto)
{
  register temp;
  struct IOStdReq *readreq;
  
  if (!(readreq = (struct IOStdReq *)GetMsg(msgport))) return(-1);
  temp = *whereto;                /* get the character */
  QueueRead(readreq,whereto);     /* then re-use the request block */
  return(temp);
}

/* Wait for a character
 */
UBYTE ConGetChar(struct MsgPort *msgport, UBYTE *whereto)
{
  register temp;
  struct IOStdReq *readreq;
  
  WaitPort(msgport);
  readreq = (struct IOStdReq *)GetMsg(msgport);
  temp = *whereto;               /* get the character */
  QueueRead(readreq,whereto);    /* then re-use the request block*/
  return((UBYTE)temp);
}

sleep(int n)
{
  Delay(50*n);
  return 0;
}

DoShell()
{
  printf("DoShell() - NOT IMPLEMENTED\n");
}

void WriteConsole(char *Ptr, int Len)
{
  ConWrite(writeReq, Ptr, Len);
}

char AmGetch()
{
  static char Buffer[256];
  static int WPos = 0, RPos = 0;

  if(GetchFlags & AM_CBREAK) {
    RPos = WPos = 0;
    *Buffer = ConGetChar(readPort, &ibuf);
    return *Buffer;
  } else {
    if(RPos>=WPos) {
      /* Reset buffer markers */
      RPos = WPos = 0;
      /* Buffer up till CR spotted */
      do
	Buffer[WPos] = ConGetChar(readPort, &ibuf);
      while(Buffer[WPos++] != '\r');
    }
    return Buffer[RPos++];
  }
}

AmCBreak(int Flag)
{
  if(Flag)
    GetchFlags |= AM_CBREAK;
  else
    GetchFlags &= ~AM_CBREAK;
}

AmEcho(int Flag)
{
  if(Flag)
    GetchFlags |= AM_ECHO;
  else
    GetchFlags &= ~AM_ECHO;
}

FlushKBD()
{
  /* TODO */
}

/*
 * Missing unix system calls.
 */

fork()
{
  return -1;
}

getpid()
{
  return FindTask(0L);
}

kill()
{
  return 0;
}

#endif /* AMIGA */
