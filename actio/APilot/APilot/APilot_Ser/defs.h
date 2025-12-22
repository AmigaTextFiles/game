/*************************************************************************
 *
 * defs.h -- General defines and parameters for adjusting APilot
 *           behaviour.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)	
 *
 */

#ifndef __DEFS_H__
#define __DEFS_H__
 
/*
 * General game parameters.
 */
#define PRECS           128     /* Precision for float -> integer        */
                                /* conversion. Should be a power of 2    */
                                /* maximum performance.                  */

#define SHFTPR          7       /* PRECS = 2 ^ SHFTPR             */

#define APILOT_NFR      2       /* How many frames will pass      */
                                /* before each screen update      */

#define MY_BUFFERS      2       /* Not really used yet. But maybe future */
                                /* versions support n-buffering, so far  */
                                /* only double-buffer support:  has to   */
                                /* be 2.                                 */

#define SCR_DEPTH       2       /* Number of colors = SCR_DEPTH ^ 2      */

#define HUDON_TIME       300    /* No. of frames the hud should remain on.  */
#define DEF_GRAVITY      0.02   /* Default gravity.                         */

#define POINT_CHUNK_SIZE 200    /* Max number of points flying around the   */
                                /* screen at the same time.                 */

/*
 * Parameters for shots (or bullets) fired from a ship.
 */
#define BUL_MASS        10     
#define BUL_DIST        14       /* Distance of new bullets from ship center  */
#define BUL_LIFE        90       /* Number of frames the bullets live         */
#define BUL_SPEED       4        /* Speed of bullets in pixels/sec.           */
#define BUL_ANGLE       12       /* The angle at which new bullets            */
                                 /* are added eg. +-BUL_ANGLE                 */
/*
 * Ship parameters.
 */
#define MAXFUEL         5000     /* Fuel, used for everything.                */
#define SHP_MASS        100      /* Mass, used in collisions.                 */
#define SHL_SIZE        12       /* Shield radius.                            */
#define ROT_SPEED       4        /* How much rotation(degrees)/frame          */
#define THR_POWER       0.125    /* Bigger value->better acceleration.        */

#define SHL_ANIM        21       /* Number of shield images in animation      */
                                 /* NOTE: If this value is changed, you need  */
				 /* to change some values in main.c too...    */

/*
 * Explosion parameters.
 */
#define EXP_MASS        20
#define EXP_MAXSIZE     120      /* Max number of points in an explosion.     */
#define EXP_LIFE        40       /* How many 1/50s an average explosion point */
                                 /* lives.                                    */
#define EXP_LIFESPREAD  12       /* How much the avg explosion point lifetime */
                                 /* varies.                                   */

/* 
 * Parameters for ship exhaust.
 * EXH_xxx defines should perhaps be built into the shape of the ship..
 * Maybe later..
 */
#define EXH_MASS        5
#define EXH_COUNT       3        /* Particles / thrustsequence.               */
#define EXH_DIST        12       /* Distance of exhaust from ship center.     */

#define EXH_WIDTH       13       /* The width of the exhaust right at the     */
                                 /* rear of the ship. Must be odd!            */

#define EXH_LIFESPREAD  10       /* How much the exhaust avg life             */
                                 /* varies: +- EXH_LIFESPREAD number          */
                                 /* of frames.                                */

/*
 * Cannon parameters.
 */
#define CAN_HEIGHT MAP_BLOCKSIZE/3 /* Height of cannons.                      */

#define CAN_SHOTMASS    8
#define CAN_SHOTLIFE    90
#define CAN_FIREANGLE   40       /* The max/min angle the cannon can fire.    */
#define CAN_FIREDELAY   90       /* How many frames will pass until cannon    */
                                 /* fires next time. 50 = 1 second.           */
#define CAN_FDSPREAD    20       /* How much the FIREDELAY will vary.         */

#define CAN_DEDTIME     2000     /* How many frames cannon will remain dead.  */

#endif
