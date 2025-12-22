/*
 * input.c -- Functions handling the input from the user to the program
 *
 */

#include <exec/types.h>
#include <intuition/intuition.h>    /* Intuition data strucutres, etc.    */
#include <libraries/dos.h>          /* Official return codes defined here */

#ifdef LATTICE
  #include <proto/exec.h>
#else
  #include <clib/exec_protos.h>
#endif

#include "points_protos.h"

#include "common.h"
#include "defs.h"

#include "input.h"

/*
 * handleIDCMP -- Reads keyboard events and does what the user tells it
 *                to do.
 */

BOOL handleIDCMP( struct Window *win, AShip *aShip, 
                    struct timerequest *iRB, ULONG oldrd )
{
  BOOL done = FALSE;
  BOOL keyup;
  struct IntuiMessage *message;    
  ULONG class;
  USHORT code;
  USHORT qual;

  /* Examine pending messages */
  while( message = (struct IntuiMessage *)GetMsg(win->UserPort) )
  {
    class = message->Class;  /* get all data we need from message */
    code  = message->Code;
    qual  = message->Qualifier;

    /* When we're through with a message, reply */
    ReplyMsg( (struct Message *)message);

    /* See what events occurred */
    keyup = (code & 0x80);

    switch( class ) {
      case IDCMP_RAWKEY:
        if(qual & IEQUALIFIER_RSHIFT)
          aShip->thrusting = TRUE;
        else
          aShip->thrusting = FALSE;

        switch( 0x7F & code )
        {
          case RAWKEY_A:
            if (keyup)
              aShip->rotspeed = 0;
            else
              aShip->rotspeed = -ROT_SPEED;
            break;
          case RAWKEY_S:
            if (keyup)
              aShip->rotspeed = 0;
            else
              aShip->rotspeed = ROT_SPEED;
            break;
          case RAWKEY_ENTER:
            if (!keyup)
              aShip->fireing = TRUE;
            break;
          case RAWKEY_T:
            if (!keyup)
              add_explosion( 320, 256 );
            break;
          case RAWKEY_Q:  
            iRB->tr_time.tv_secs = oldrd;
            DoIO((struct IORequest *) iRB);
            done = TRUE;
            break;
          default:
            break;
        }
        break;
      case IDCMP_ACTIVEWINDOW:
        iRB->tr_time.tv_secs = 1000;  /* Should be enough to prevent */
                                              /* repeat.                     */
        DoIO((struct IORequest *) iRB);
        break;
      case IDCMP_INACTIVEWINDOW:
        iRB->tr_time.tv_secs = oldrd;
        DoIO((struct IORequest *) iRB);
        break;
      default:
         break;
    }
  }
  return(done);
}

