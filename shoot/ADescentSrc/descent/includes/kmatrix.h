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
 * $Source: /usr/CVS/descent/includes/kmatrix.h,v $
 * $Revision: 1.1.1.1 $
 * $Author: nobody $
 * $Date: 1998/03/03 15:11:57 $
 * 
 * Kill matrix.
 * 
 * $Log: kmatrix.h,v $
 * Revision 1.1.1.1  1998/03/03 15:11:57  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:22  hfrieden
 * Initial Import
 *
 * Revision 2.0  1995/02/27  11:28:51  john
 * New version 2.0, which has no anonymous unions, builds with
 * Watcom 10.0, and doesn't require parsing BITMAPS.TBL.
 * 
 * Revision 1.3  1995/02/15  14:47:39  john
 * Added code to keep track of kills during endlevel.
 * 
 * Revision 1.2  1994/12/09  16:19:46  yuan
 * kill matrix stuff.
 * 
 * Revision 1.1  1994/12/09  15:58:33  yuan
 * Initial revision
 * 
 * 
 */



#ifndef _KMATRIX_H
#define _KMATRIX_H

extern int kmatrix_kills_changed;

void kmatrix_view();

#endif
