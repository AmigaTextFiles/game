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
 * $Source: /usr/CVS/descent/includes/serial.h,v $
 * $Revision: 1.1.1.1 $
 * $Author: nobody $
 * $Date: 1998/03/03 15:12:02 $
 * 
 * .
 * 
 * $Log: serial.h,v $
 * Revision 1.1.1.1  1998/03/03 15:12:02  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:27  hfrieden
 * Initial Import
 *
 * Revision 2.0  1995/02/27  11:32:33  john
 * New version 2.0, which has no anonymous unions, builds with
 * Watcom 10.0, and doesn't require parsing BITMAPS.TBL.
 * 
 * Revision 1.2  1994/07/21  21:31:33  john
 * First cheapo version of VictorMaxx tracking.
 * 
 * Revision 1.1  1994/07/21  18:40:47  john
 * Initial revision
 * 
 * 
 */



#ifndef _SERIAL_H
#define _SERIAL_H

extern void serial_test();
extern void serial_open(int number, long speed, char parity, int data,	int stopbits );
extern void serial_close();
extern int serial_putc( unsigned char c );
extern int serial_getc();

#endif

