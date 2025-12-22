/***************************************************************************
 *
 * Vertb.c -- Initializes my vertical blank server
 *
 * This server counts frames on a global variable vb_counter.
 * Using vb_counter the game could very easily be made framerate
 * independant so that lower framerates doesn't make the ship
 * move any slower on screen. Just a few small changes in main()
 * are needed, but I still elected not to use it..Perhaps it's
 * a matter of taste..
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */
 
#include <exec/memory.h>
#include <exec/interrupts.h>
#include <dos/dos.h>
#include <hardware/custom.h>
#include <hardware/intbits.h>
#include <stdio.h>

#include <proto/exec.h>

#include "main_protos.h"
#include "defs.h"
#include "vertb.h"

/*--------------------------------------------------------------------------*/

extern void VertBServer();  /* proto for asm interrupt server */

struct VertBData vertbdata;
static struct Interrupt vbint;
static BYTE   mainsignum = -1;
UWORD  vb_counter = 0;

/*--------------------------------------------------------------------------*/

ULONG init_VertBServer( void )
{
  /* Allocate a signal so handler can signal main */
  if (-1 == (mainsignum = AllocSignal(-1)))
    cleanExit( RETURN_WARN, "** Could not allocate signal for vblank-server.\n" );

  /* Init vertbdata structure */    
  vertbdata.maintask = FindTask(NULL);
  vertbdata.mainsig  = 1L << mainsignum;
  vertbdata.sigframe = APILOT_NFR;
  vertbdata.nframes  = &vb_counter;

  vbint.is_Node.ln_Type = NT_INTERRUPT;         /* Initialize the node. */
  vbint.is_Node.ln_Pri = 20;
  vbint.is_Node.ln_Name = "VertB-APilot";
  vbint.is_Data = (APTR)&vertbdata;
  vbint.is_Code = VertBServer;

  AddIntServer(INTB_VERTB, &vbint); /* Kick this interrupt server to life. */

  return vertbdata.mainsig;
}

/*--------------------------------------------------------------------------*/

void
remove_VertBServer( void )
{
  if (mainsignum != -1) {
    RemIntServer(INTB_VERTB, &vbint);
    FreeSignal(mainsignum);
  }
}
