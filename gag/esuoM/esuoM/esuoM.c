/****************************************************************
 *
 *                   esuoM - Backwards Mouse
 *
 *    This program installs an input handler which will reverse
 *    all mouse movements and cause the mouse pointer to move in
 *    the opposite direction of the mouse.
 *
 ****************************************************************/
#include <intuition/intuitionbase.h>
#include <devices/input.h>
#include <proto/exec.h>
#include <proto/intuition.h>

#define PORTNAME "-=+RBE_esuoM+=-"

struct InputEvent *hndcode();    /* input handler function   */
void hndstub();                  /* asm stub for interfacing */

struct Interrupt handlerptr;     /* Interrupt struct for installing handler */
struct MsgPort *inputport;       /* msg port for IO request     */
struct IOStdReq *inputreq;       /* IO request for input device */
struct Message *m;               /* to get Intui messages       */
extern struct IntuitionBase *IntuitionBase;

struct Window *mywindow;           /* opened window  */
struct NewWindow mynewwindow =     /* to create new window - for the  */
{ 150, 50,     /* left, top */     /* sole purpose of getting close   */
  125, 10,     /* width, height */ /* window message                  */
  -1, -1,      /* pens */
  CLOSEWINDOW, /* IDCMP */
  WINDOWDEPTH | WINDOWCLOSE | WINDOWDRAG | SMART_REFRESH | NOCAREREFRESH |
  RMBTRAP,     /* flags */
  NULL, NULL,  /* gadgets, checkmark */
  "esuoM",     /* title */
  NULL, NULL,  /* screen, bitmap */
  0, 0, 0, 0,  /* min, max sizes */
  WBENCHSCREEN /* screen type */
};
 
void _main()       /* _main instead of main to save space (Lattice) */
{
  int waitmask, done;

  if (FindPort(PORTNAME) != NULL)  /* look to see if already installed - */
    exit(99);                      /* will not install more than once    */

  IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library",0);
  inputport = CreatePort(PORTNAME,0);  /* make port for IO req */
  if (IntuitionBase== NULL || inputport==NULL)
    exit(20);                          /* bomb if cannot open  */
  mywindow = OpenWindow(&mynewwindow); /* open new window      */
  if (mywindow == NULL)
    exit (10);                         /* bomb if can't open   */
  inputreq = CreateStdIO(inputport);   /* allocate IO request  */
  if (inputreq == NULL)
     exit(21);                         /* bomb if can't open   */
  if (OpenDevice("input.device",0,(struct IORequest *)inputreq,0) != NULL)
     exit(22);                         /* bomb if can't open device  */

  handlerptr.is_Code = hndstub;    /* set up Interrupt struct - point to  */
  handlerptr.is_Data = NULL;       /* asm stub hndstub()                  */
  handlerptr.is_Node.ln_Pri = 100; /* priority = 100 (max=127, Intui=50)  */

  inputreq->io_Command = IND_ADDHANDLER;  /* set up IO req */
  inputreq->io_Data = (APTR)&handlerptr;
  DoIO((struct IORequest *)inputreq);     /* install input handler */

/*  At this point the input handler is installed and doing its thing.
    We will now wait until we get a CLOSEWINDOW message in the window's
    IDCMP port */

  waitmask = (1 << mywindow->UserPort->mp_SigBit);  /* what to wait for */

  done = FALSE;
  while (!done)             /*  keep looking for messages   */
  {
    Wait(waitmask);         /*  wait for IDCMP message      */
    while ((m=GetMsg(mywindow->UserPort)) != NULL)  /* look at all msgs */
    {
      if (((struct IntuiMessage *)m)->Class == CLOSEWINDOW)
        done = TRUE;        /*  if CLOSEWINDOW, we are done */
      ReplyMsg(m);          /*  reply to all messages       */
    }
  }

/*  We have gotten the CLOSEWINDOW message - time to leave  */

  inputreq->io_Command = IND_REMHANDLER;    /* start packing up     */
  DoIO((struct IORequest *)inputreq);       /* remove input handler */
  CloseDevice((struct IORequest *)inputreq);/* close input device   */
  DeleteStdIO(inputreq);                    /* delete IO request    */
  DeletePort(inputport);                    /* delete message port  */
  CloseWindow(mywindow);                    /* close the window     */
  CloseLibrary((struct Library *)IntuitionBase);
  exit(0);                                  /* Adios, Amigas!       */
   
}

/*  This function is called by the hndstub() assembly code interface
    function, which is called whenever there is an input event.  The
    hndstub() routine merely provides the assembly level interface to
    the input event system, and stacks the data for this C language
    handler.   */

struct InputEvent *hndcode(ie,data)
struct InputEvent *ie;    /* the actual input event we want to examine */
char *data;
{
  register struct InputEvent *e=ie;  /* register variable for speed */

  do    /* we want to modify mouse movement events - they are all  */
  {     /* RAWMOUSE class events with a NOBUTTON code              */

    if (e->ie_Class == IECLASS_RAWMOUSE && e->ie_Code == IECODE_NOBUTTON)
    {
      e->ie_X = -e->ie_X;  /* if mouse movement event, reverse movement */
      e->ie_Y = -e->ie_Y;
    }
    e = e->ie_NextEvent;
  } while (e != NULL);    /* repeat if multiple event list */
  return(ie);             /* pass event on down the line   */
}

void MemCleanup() {}      /* dummy out function to save space (Lattice) */
