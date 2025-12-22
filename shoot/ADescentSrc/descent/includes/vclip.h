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
 * $Source: /usr/CVS/descent/includes/vclip.h,v $
 * $Revision: 1.2 $
 * $Author: tfrieden $
 * $Date: 1998/03/22 01:52:04 $
 * 
 * Stuff for video clips.
 * 
 * $Log: vclip.h,v $
 * Revision 1.2  1998/03/22 01:52:04  tfrieden
 * Bugfixes (missing voids)
 *
 * Revision 1.1.1.1  1998/03/03 15:12:05  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:29  hfrieden
 * Initial Import
 */

#ifndef _VCLIP_H
#define _VCLIP_H

#include "gr.h"
#include "object.h"
#include "piggy.h"

#define VCLIP_SMALL_EXPLOSION       2
#define VCLIP_PLAYER_HIT            1
#define VCLIP_MORPHING_ROBOT        10
#define VCLIP_PLAYER_APPEARANCE 61
#define VCLIP_POWERUP_DISAPPEARANCE 62
#define VCLIP_VOLATILE_WALL_HIT 5

#define VCLIP_MAXNUM            70
#define VCLIP_MAX_FRAMES    30

//vclip flags
#define VF_ROD      1       //draw as a rod, not a blob

typedef struct {
	fix             play_time   __attribute__ ((packed));           //total time (in seconds) of clip
	int             num_frames  __attribute__ ((packed));
	fix             frame_time  __attribute__ ((packed));           //time (in seconds) of each frame
	int             flags       __attribute__ ((packed));
	short               sound_num   __attribute__ ((packed));
	bitmap_index    frames[VCLIP_MAX_FRAMES]    __attribute__ ((packed));
	fix             light_value __attribute__ ((packed));
} vclip;

extern int Num_vclips;
extern vclip Vclip[VCLIP_MAXNUM];

//draw an object which renders as a vclip.
void draw_vclip_object(object *obj,fix timeleft,int lighted, int vclip_num);
extern void draw_weapon_vclip(object *obj);

#endif
