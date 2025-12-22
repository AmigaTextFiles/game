/* inputhandler.c */
#include <exec/types.h>
#include <exec/ports.h>
#include <exec/memory.h>
#include <exec/tasks.h>
#include <devices/input.h>
#include <devices/inputevent.h>
#include <intuition/intuitionbase.h>

/* ====  EXPORT  ==== */
extern struct InputEvent *InputHandler();
extern struct IntuitionBase *IntuitionBase;
/*****/

/* ==== IMPORT ===== */
extern APTR MyTask;
extern ULONG INPUTEVENT;
extern SHORT PosX,PosY;
/***/


struct InputEvent 
*InputHandler(ev, data)
   struct InputEvent *ev;
   struct MemEntry *data[];

{
   struct InputEvent *curr;

   curr = ev;
   while(curr)
   {

      switch(curr->ie_Class)
      {
         case IECLASS_POINTERPOS:
         case IECLASS_RAWMOUSE:
            PosX = IntuitionBase->MouseX;
            PosY = IntuitionBase->MouseY;
            Signal(MyTask,INPUTEVENT);
            break;
         default:
            break;
      }
/*
      if (curr->ie_Class==IECLASS_POINTERPOS)
      {
         PosX = curr->ie_X;
         PosY = curr->ie_Y;
         Signal(MyTask,INPUTEVENT);

      }
      else if (curr->ie_Class==IECLASS_RAWMOUSE)
      {
         if (curr->ie_Code==IECODE_NOBUTTON)
         {
            PosX += curr->ie_X;
            PosY += curr->ie_Y;
            Signal(MyTask,INPUTEVENT);
         }
      }

*/
      curr=curr->ie_NextEvent;
   }
   return(ev);
}

