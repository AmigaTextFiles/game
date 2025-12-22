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
 * $Source: /usr/CVS/descent/includes/config.h,v $
 * $Revision: 1.2 $
 * $Author: tfrieden $
 * $Date: 1998/04/13 17:50:26 $
 * 
 * prototype definitions for descent.cfg reading/writing
 * 
 * $Log: config.h,v $
 * Revision 1.2  1998/04/13 17:50:26  tfrieden
 * Kali stuff added
 *
 * Revision 1.1.1.1  1998/03/03 15:11:53  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:18  hfrieden
 * Initial Import
 *
 * Revision 2.0  1995/02/27  11:32:48  john
 * New version 2.0, which has no anonymous unions, builds with
 * Watcom 10.0, and doesn't require parsing BITMAPS.TBL.
 * 
 * Revision 1.4  1995/02/11  16:20:06  john
 * Added code to make the default mission be the one last played.
 * 
 * Revision 1.3  1994/12/08  10:01:41  john
 * Changed the way the player callsign stuff works.
 * 
 * Revision 1.2  1994/11/14  17:53:17  allender
 * extern definitions for ReadConfigFile and WriteConfigFile
 * 
 * Revision 1.1  1994/11/14  16:56:17  allender
 * Initial revision
 * 
 * 
 */



#ifndef _CONFIG_H
#define _CONFIG_H

#include "player.h"

extern int ReadConfigFile(void);
extern int WriteConfigFile(void);

extern char config_last_player[CALLSIGN_LEN+1];

extern char config_last_mission[];

#define SERVER_NAME_LEN 64
extern char config_kali_server[];

#endif
