/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/includes/types.h,v $
 * $Revision: 1.2 $
 * $Author: nobody $
 * $Date: 1998/08/08 15:38:45 $
 *
 * Common types for use in Miner
 *
 * $Log: types.h,v $
 * Revision 1.2  1998/08/08 15:38:45  nobody
 * Activated the Editior
 *
 * Revision 1.1.1.1  1998/03/03 15:12:04  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:14  hfrieden
 * Initial Import
 *
 * Revision 1.2  1993/09/14  12:12:30  matt
 * Added #define for NULL
 * 
 * Revision 1.1  1993/08/24  12:50:40  matt
 * Initial revision
 * 
 *
 */

#ifndef _DTYPES_H
#define _DTYPES_H

#include <sys/types.h>

typedef signed char byte;
typedef unsigned char ubyte;
typedef ubyte bool;
typedef unsigned long ulong;

#ifndef NULL
#define NULL 0
#endif

#define __pack__ __attribute__ ((packed))

#endif

