/**************************************************************************
 *
 * serial.h -- Some defines needed for serial communication.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen    (kjetilja@stud.cs.uit.no)
 *
 */

#define SH_THRUSTING  1
#define SH_FIREING    2
#define SH_LEFTTURN   4
#define SH_RIGHTTURN  8
#define SH_SHIELDING  16
#define SH_FUELING    32
#define REMOTE_QUIT   128

typedef struct _ShipData {
  UBYTE flags;       /* Shows what the ship is doing.  */
  BYTE delta_x;      /* With these the coordinates are */
  BYTE delta_y;      /* updated.                       */
  UBYTE chksum;
  WORD xvel;       
  WORD yvel;
} ShipData;
