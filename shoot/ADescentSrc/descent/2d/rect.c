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
 * $Source: /usr/CVS/descent/2d/rect.c,v $
 * $Revision: 1.1.1.1 $
 * $Author: nobody $
 * $Date: 1998/03/03 15:11:47 $
 *
 * Graphical routines for drawing rectangles.
 *
 * $Log: rect.c,v $
 * Revision 1.1.1.1  1998/03/03 15:11:47  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:21:22  hfrieden
 * Initial Import
 *
 * Revision 1.1  1995/03/09  09:22:22  allender
 * Initial revision
 *
 *
 * --- PC RCS information ---
 * Revision 1.3  1994/11/18  22:50:19  john
 * Changed shorts to ints in parameters.
 * 
 * Revision 1.2  1993/10/15  16:23:27  john
 * y
 * 
 * Revision 1.1  1993/09/08  11:44:22  john
 * Initial revision
 * 
 *
 */

#include "mem.h"

#include "gr.h"
#include "grdef.h"

void gr_urect(int left,int top,int right,int bot)
{
	int i;

	for ( i=top; i<=bot; i++ )
		gr_uscanline( left, right, i );
}

void gr_rect(int left,int top,int right,int bot)
{
	int i;

	for ( i=top; i<=bot; i++ )
		gr_scanline( left, right, i );
}
