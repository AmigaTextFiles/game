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
 * $Source: /usr/CVS/descent/main/netmisc.c,v $
 * $Revision: 1.2 $
 * $Author: tfrieden $
 * $Date: 1998/04/03 14:01:29 $
 * 
 * Misc routines for network.
 * 
 * $Log: netmisc.c,v $
 * Revision 1.2  1998/04/03 14:01:29  tfrieden
 * Removed comments
 *
 * Revision 1.1.1.1  1998/03/03 15:12:26  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:21:01  hfrieden
 * Initial Import
 */

#pragma off (unreferenced)
static char rcsid[] = "$Id: netmisc.c,v 1.2 1998/04/03 14:01:29 tfrieden Exp $";
#pragma on (unreferenced)

#include <string.h>

#include "types.h"
#include "mono.h"

// Calculates the checksum of a block of memory.
ushort netmisc_calc_checksum( void * vptr, int len )
{
	ubyte * ptr = (ubyte *)vptr;
	unsigned int sum1,sum2;

	sum1 = sum2 = 0;

	while(len--)    {
		sum1 += *ptr++;
		if (sum1 >= 255 ) sum1 -= 255;
		sum2 += sum1;
	}
	sum2 %= 255;
	
	return ((sum1<<8)+ sum2);
}

