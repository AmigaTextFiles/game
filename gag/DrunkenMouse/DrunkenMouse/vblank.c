/* vblank.c */
/* by Alex Livshits */
/* July 1987 */

#include <exec/types.h>
#include <exec/devices.h>
#include <exec/memory.h>
#include <exec/interrupts.h>
#include <hardware/intbits.h>

#define VBINTER     0x00000001
#define SIGNAL      0x00000002


/* =======  EXPORT ======== */
int vblank_start(), vblank_end();
ULONG VBEVENT;
/***/

static int signal;
static APTR MyTask;
static struct Interrupt *VBinter;
static int mask;


int
vbinter()
{
   Signal(MyTask,VBEVENT);
   return(0);
}


int
vblank_start()
{
   mask=0;

   signal = AllocSignal(-1);
   if (signal==-1) {
      vblank_end();
      return(30);
   }
   mask |= SIGNAL;
   VBEVENT = 1L<<signal;
   MyTask = (APTR)FindTask(0);

   VBinter = AllocMem(sizeof(*VBinter),MEMF_PUBLIC|MEMF_CLEAR);
   if (!VBinter) {
      vblank_end();
      return(40);
   }

   VBinter->is_Node.ln_Type=NT_INTERRUPT;
   VBinter->is_Node.ln_Pri=-60;
   VBinter->is_Node.ln_Name = "";
   VBinter->is_Data=0;
   VBinter->is_Code=vbinter;

   AddIntServer(INTB_VERTB,VBinter);
   mask |= VBINTER;
   return(0);
}

int
vblank_end()
{
    if (mask & VBINTER) {
         RemIntServer(INTB_PORTS,VBinter);
         FreeMem(VBinter,sizeof(*VBinter));
    }
    if (mask & SIGNAL) FreeSignal(signal);
    return(0);
}



