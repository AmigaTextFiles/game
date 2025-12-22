/* in.c */
/* by Alex Livshits */
/* July 1987 */

#include <exec/types.h>
#include <exec/ports.h>
#include <exec/memory.h>
#include <exec/io.h>
#include <exec/interrupts.h>
#include <devices/input.h>
#include <devices/inputevent.h>

#define DEVPORT   0x00000001
#define REQBLOCK  0x00000002
#define INPUT     0x00000004

static ULONG mask;

/* =======  EXPORT ======== */
int in_start(), in_end(), in_moveptr();
/***/

/* =======  IMPORT ========= */
extern int HandlerInterface();
/***/

static struct Port *inputDevPort;
static struct IOStdReq *inputRequestBlock;
static struct InputEvent phony;
static struct Interrupt handler;


int
in_start()
{
   int retc;

   mask = 0;

   inputDevPort = CreatePort(0,0);
   if (inputDevPort == NULL) return(1);
   mask |= DEVPORT;

   inputRequestBlock = CreateStdIO(inputDevPort);
   if(inputRequestBlock == 0) { in_end(); return(2); }
   mask |= REQBLOCK;

   retc = OpenDevice("input.device",0,inputRequestBlock,0);
   if (retc) { in_end(); return(3); }
   mask |= INPUT;


   handler.is_Data = 0;
   handler.is_Code = HandlerInterface;
   handler.is_Node.ln_Pri = 51;

   inputRequestBlock->io_Command = IND_ADDHANDLER;
   inputRequestBlock->io_Data = &handler;
   DoIO(inputRequestBlock);

   return(0);
}

int
in_moveptr(x,y)
   LONG x,y;
{
   phony.ie_NextEvent=NULL;
   phony.ie_Class = IECLASS_POINTERPOS;
   phony.ie_Code=IECODE_NOBUTTON;
   phony.ie_Qualifier = 0; /* IEQUALIFIER_RELATIVEMOUSE; */
   phony.ie_X=x;
   if (y==-1) phony.ie_Y=100;
   else phony.ie_Y=y;

   inputRequestBlock->io_Command = IND_WRITEEVENT;
   inputRequestBlock->io_Length=sizeof(struct InputEvent);
   inputRequestBlock->io_Data = &phony;
   DoIO(inputRequestBlock);

   return(0);
}


int
in_end()
{
   if (mask & INPUT)
   {
      inputRequestBlock->io_Command = IND_REMHANDLER;
      inputRequestBlock->io_Data = &handler;
      DoIO(inputRequestBlock);
      CloseDevice(inputRequestBlock);
   }
   if (mask & REQBLOCK) DeleteStdIO(inputRequestBlock);
   if (mask & DEVPORT) DeletePort(inputDevPort);
   return(0);
}




