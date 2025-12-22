/**************************************************************************
 *
 * serial.c -- Serial routines.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen    (kjetilja@stud.cs.uit.no)
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <exec/types.h>
#include <devices/serial.h>

#include <proto/dos.h>
#include <proto/exec.h>

#include "common.h"
#include "serial.h"

#include "main_protos.h"
#include "fuelpod_protos.h"
#include "points_protos.h"

extern int sina[];
extern int cosa[];

static BOOL   deviceopen = FALSE; 
static struct MsgPort  *SerialMP = NULL;
static struct IOExtSer *SerialIO = NULL;

extern AWorld World;

/*
 * init_connection -- Opens the serial device and tries to
 *                    agree with the remote site on who should
 *                    be 'host'.
 */
void
init_connection(void)
{
  UBYTE local_randnum  = 0;
  UBYTE remote_randnum = 0;

  /*
   * Set the random seed for determining who will be 'host'.
   */
  srand((unsigned int)time(NULL));

  if ( SerialMP = CreatePort(0,0) ) {
    if ( SerialIO = (struct IOExtSer *)
         CreateExtIO(SerialMP, sizeof(struct IOExtSer)) ) {

      SerialIO->io_SerFlags |= SERF_XDISABLED;

      if ( OpenDevice(prefs.ser_dev, prefs.ser_unitnr, 
                      (struct IORequest *)SerialIO, 0) == 0 ) {
        deviceopen = TRUE;
        printf("Serial device open.\n");
        printf("Sizeof(ShipData) = %d\n", sizeof(ShipData));

        /*
         * Set parameters...
         */
        SerialIO->IOSer.io_Command = SDCMD_SETPARAMS;
        SerialIO->io_Baud          = prefs.ser_bps;
        SerialIO->io_SerFlags     |= SERF_XDISABLED;
        DoIO((struct IORequest *)SerialIO);

        /*
         * Wait a few secs so the other side has time
         * to init.
         */
        Delay(5*50);

        /*
         * Start a loop until both agree who will be the
         * host.
         */
        while (local_randnum == remote_randnum) {       

          local_randnum = (UBYTE)(rand() % 255);

          /*
           * Send the number..
           */
          SerialIO->IOSer.io_Command = CMD_WRITE;
          SerialIO->IOSer.io_Length  = 1;
          SerialIO->IOSer.io_Data    = (APTR)&local_randnum;
          DoIO((struct IORequest *)SerialIO);

          /*
           * Read the number..
           */
          SerialIO->IOSer.io_Command = CMD_READ;
          SerialIO->IOSer.io_Length  = 1;
          SerialIO->IOSer.io_Data    = (APTR)&remote_randnum;
          DoIO((struct IORequest *)SerialIO);
        }

        printf("Local number : %d\n", local_randnum);
        printf("Remote number: %d\n", remote_randnum);

        /*
         * The one with the higher number gets to be host.
         */
        if (local_randnum > remote_randnum) {
          printf("I'm host.\n");
          World.host = TRUE;          
        } else {
          printf("Remote is host.\n");
          World.host = FALSE;
        }
        return;
      }
      cleanExit( RETURN_WARN, "** Unable to open '%s' for communication.\n",
                 prefs.ser_dev );
    }
  }
  cleanExit( RETURN_WARN, "** Unable to init serial device structures.\n" );
}


/*
 * update_remote -- Reads data from the remote player.
 *                  Updates the ship position, angle, fireing and exhaust.
 *
 *         Returns: TRUE if remote side decided to quit.
 */
BOOL
update_remote( UWORD buf, UWORD nframes )
{
  int i;
  int isin, icos;

  ShipData remotedata;
  AShip *ship = World.remote_ship;

  WaitIO((struct IORequest *)SerialIO);

  SerialIO->IOSer.io_Command = CMD_READ;
  SerialIO->IOSer.io_Length  = sizeof(ShipData);
  SerialIO->IOSer.io_Data    = (APTR)&remotedata;
  DoIO((struct IORequest *)SerialIO);

  if (remotedata.chksum != (abs(remotedata.flags + 
                                remotedata.delta_x + remotedata.delta_y + 
                                remotedata.xvel + remotedata.yvel) % 250)) {

    if (remotedata.flags & REMOTE_QUIT)
      return TRUE;

    printf("** Error!! Checksum mismatch!\n");
    return FALSE;
  }

  if (remotedata.flags & REMOTE_QUIT)
    return TRUE;

  ship->thrusting = FALSE;
  ship->fireing   = FALSE;
  ship->shields   = FALSE;
  ship->fueling   = FALSE;

  if (remotedata.flags & SH_THRUSTING)
    ship->thrusting = TRUE;
  if (remotedata.flags & SH_FIREING)
    ship->fireing = TRUE;
  if (ship->turning != YES) {
    ship->turning = NO;
    if (remotedata.flags & SH_LEFTTURN)
      ship->turning = LEFT;
    if (remotedata.flags & SH_RIGHTTURN)
      ship->turning = RIGHT;
  }
  if (remotedata.flags & SH_SHIELDING)
    ship->shields = TRUE;
  if (remotedata.flags & SH_FUELING)
    ship->fueling = TRUE;

  /*
   * Check if ship exploded 
   */
  if (ship->status > 0)
    return FALSE;

  if (ship->turning != NO || ship->thrusting || ship->fireing) {

    if (ship->turning == RIGHT) {
      ship->angle = (ship->angle + ship->rotspeed * nframes) % 360;
    } else if (ship->turning == LEFT) {
      ship->angle = (ship->angle - ship->rotspeed * nframes) % 360;
     }

    if (ship->angle < 0)
      ship->angle = 360 + ship->angle;

    isin = sina[ship->angle];
    icos = cosa[ship->angle];

    if (ship->turning != NO) {
      if (ship->turning == YES) ship->turning = NO;
      /* Rotate the points */
      for(i = 0; i < ship->shapesize; i++) {
        ship->currc[i].x = (ship->shape[i].x * icos - ship->shape[i].y * isin) >> SHFTPR;
        ship->currc[i].y = (ship->shape[i].x * isin + ship->shape[i].y * icos) >> SHFTPR;
      }
    }
  }

  for (i = nframes; i > 0; i--) {
    if (ship->thrusting && ship->fuel > 0) {
      ship->xvel += (isin * ship->power) >> SHFTPR;
      ship->yvel -= (icos * ship->power) >> SHFTPR;
    }
    ship->yvel += World.gravity;
    ship->xcount += ship->xvel;
    ship->ycount += ship->yvel;
  }

  /* Move ship */
  ship->pos.x += remotedata.delta_x;
  ship->pos.y += remotedata.delta_y;

  ship->xvel = remotedata.xvel;
  ship->yvel = remotedata.yvel;

  if (ship->thrusting && ship->fuel > 0) {
    add_exhaust(ship, isin, icos, nframes);
    ship->fuelcount += (nframes << 1);
  }

  if (ship->fireing) {
    ship->fireing = FALSE;
    if (!ship->shields && ship->fuel > 0) {
      /* Every bullet grabs one fuel */
      ship->fuel -= ship->fw_nbul + ship->bw_nbul;
      add_bullets(ship, isin, icos);
    }
  }

  if (ship->shields)
    ship->fuelcount += nframes;
  if (ship->fuelcount >= 50) {
    ship->fuelcount = 0;
    ship->fuel--;
  }
  if (ship->fuel <= 0) {
    ship->shields = FALSE;
    ship->fuel = 0;
  }

  if (ship->fueling)
    fuel_ship(ship);

  return FALSE;
}


void
send_local(UWORD nframes)
{
  int i;
  int isin, icos;
  AShip *ship = World.local_ship;

  /*
   * This data has to be static when using SendIO(), otherwise
   * when this function exits the data disappears before the serial
   * device has had time to send it.
   */
  static ShipData shipdata;

  int xvel = ship->xvel;
  int yvel = ship->yvel;
  int angle = ship->angle;
  int xcount = ship->xcount;
  int ycount = ship->ycount;
  int new_posx = ship->pos.x;
  int new_posy = ship->pos.y;

  if (ship->status > 0) {
    shipdata.xvel = 0;
    shipdata.yvel = 0;
    shipdata.flags = 0;
    shipdata.delta_x = 0;
    shipdata.delta_y = 0;

    shipdata.chksum = (abs(shipdata.flags + 
                           shipdata.delta_x + shipdata.delta_y + 
                           shipdata.xvel + shipdata.yvel) % 255);

    SerialIO->IOSer.io_Command = CMD_WRITE;
    SerialIO->IOSer.io_Length  = sizeof(ShipData);
    SerialIO->IOSer.io_Data    = (APTR)&shipdata;
    SendIO((struct IORequest *)SerialIO);

    return;
  }
    
  /*
   * Precalculate the next position so that we can send it
   * while the screen is updated.
   *
   * This is really kludgy, but I couldn't come up with any
   * other way....
   */
  if (ship->turning != NO || ship->thrusting) {

    if (ship->turning == RIGHT) {
      angle = (angle + ship->rotspeed * nframes) % 360;
    } else if (ship->turning == LEFT) {
      angle = (angle - ship->rotspeed * nframes) % 360;
    }

    if (angle < 0)
      angle = 360 + angle;

    isin = sina[angle];
    icos = cosa[angle];
  }

  for (i = nframes; i > 0; i--) {
    if (ship->thrusting && ship->fuel > 0) {
      xvel += (isin * ship->power) >> SHFTPR;
      yvel -= (icos * ship->power) >> SHFTPR;
    }
    yvel += World.gravity;
    xcount += xvel;
    ycount += yvel;
  }

  /* Move ship */
  new_posx += (xcount < 0) ? -((-xcount) >> SHFTPR) : (xcount >> SHFTPR);
  new_posy += (ycount < 0) ? -((-ycount) >> SHFTPR) : (ycount >> SHFTPR);

  if (new_posx >= MAP_BLOCKSIZE*World.Width) {
    new_posx = MAP_BLOCKSIZE*World.Width-1;
    xvel = -(xvel >> 1);
  } else if (new_posx < 0) {
    new_posx = 0;
    xvel = -(xvel >> 1);
  }
  if (new_posy >= MAP_BLOCKSIZE*World.Height) {
    new_posy = MAP_BLOCKSIZE*World.Height-1;
    yvel = -(yvel >> 1);
  } else if (new_posy < 0) {
    new_posy = 0;
    yvel = -(yvel >> 1);
  }

  /*
   * Calculate the deltas...
   */
  shipdata.delta_x = (BYTE) (new_posx - ship->pos.x);
  shipdata.delta_y = (BYTE) (new_posy - ship->pos.y);

  shipdata.xvel = (WORD)xvel;
  shipdata.yvel = (WORD)yvel;

  shipdata.flags = 0;
  if (ship->thrusting) shipdata.flags |= SH_THRUSTING;
  if (ship->fireing)   shipdata.flags |= SH_FIREING;
  if (ship->shields)   shipdata.flags |= SH_SHIELDING;
  if (ship->fueling)   shipdata.flags |= SH_FUELING;
  if (ship->turning == LEFT)  shipdata.flags |= SH_LEFTTURN;
  if (ship->turning == RIGHT) shipdata.flags |= SH_RIGHTTURN;

  shipdata.chksum = (abs(shipdata.flags + 
                         shipdata.delta_x + shipdata.delta_y + 
                         shipdata.xvel + shipdata.yvel) % 250);

  SerialIO->IOSer.io_Command = CMD_WRITE;
  SerialIO->IOSer.io_Length  = sizeof(ShipData);
  SerialIO->IOSer.io_Data    = (APTR)&shipdata;
  SendIO((struct IORequest *)SerialIO);
}

void
send_quit(void)
{
  ShipData quitpacket;
  
  quitpacket.flags = REMOTE_QUIT;
  quitpacket.delta_x = 0;
  quitpacket.delta_y = 0;
  quitpacket.xvel = 0;
  quitpacket.yvel = 0;
  quitpacket.chksum = REMOTE_QUIT;

  SerialIO->IOSer.io_Command = CMD_WRITE;
  SerialIO->IOSer.io_Length  = sizeof(ShipData);
  SerialIO->IOSer.io_Data    = (APTR)&quitpacket;
  DoIO((struct IORequest *)SerialIO);
}

void
close_connection(void)
{
  if (deviceopen) {
    AbortIO((struct IORequest *)SerialIO);
    WaitIO((struct IORequest *)SerialIO);
    CloseDevice((struct IORequest *)SerialIO);
  }
  if (SerialIO)   DeleteExtIO((struct IORequest *)SerialIO);
  if (SerialMP)   DeletePort(SerialMP);
}
