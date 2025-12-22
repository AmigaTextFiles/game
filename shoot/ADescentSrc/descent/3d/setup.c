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
 * $Source: /usr/CVS/descent/3d/setup.c,v $
 * $Revision: 1.8 $
 * $Author: nobody $
 * $Date: 1998/12/21 17:12:18 $
 * 
 * Setup for 3d library
 * 
 * $Log: setup.c,v $
 * Revision 1.8  1998/12/21 17:12:18  nobody
 * *** empty log message ***
 *
 * Revision 1.7  1998/11/09 22:20:14  nobody
 * *** empty log message ***
 *
 * Revision 1.6  1998/09/26 15:06:21  nobody
 * Added Warp3D support
 *
 * Revision 1.5  1998/03/31 17:04:29  hfrieden
 * Removed useless ViRGE statistics stuff
 *
 * Revision 1.4  1998/03/25 21:56:51  tfrieden
 * Added the once powerc specific fCanv stuff
 *
 * Revision 1.3  1998/03/22 15:54:39  hfrieden
 * Double buffering moved out of here
 *
 * Revision 1.2  1998/03/14 13:56:45  hfrieden
 * Preliminary ViRGE support added
 *
 * Revision 1.1.1.1  1998/03/03 15:11:49  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:10  hfrieden
 * Initial Import
 *
 * 
 */


#pragma off (unreferenced)
static char rcsid[] = "$Id: setup.c,v 1.8 1998/12/21 17:12:18 nobody Exp $";
#pragma on (unreferenced)

#include <stdlib.h>

#include "error.h"

#include "3d.h"
#include "globvars.h"
#include "clipper.h"
//#include "div0.h"
#include <cybergraphics/cybergraphics.h>
#include <inline/cybergraphics.h>
#include <exec/exec.h>
#include <proto/exec.h>
#include <inline/exec.h>
#ifdef VIRGIN
#include <cybergraphics/cgx3dvirgin.h>
#include <clib/cgx3dvirgin_protos.h>
#include <inline/cgx3dvirgin.h>
extern struct Library *CGX3DVirginBase;
extern View3D MyView;
extern int BufNum;
#endif
#include <intuition/intuition.h>

#ifdef WARP3D
#include <Warp3D/Warp3D.h>
#include <clib/Warp3D_protos.h>
#include <inline/Warp3D.h>
#endif

#ifdef VIRGIN
#include <stdio.h>
#include <fcntl.h>
APTR th = 0;
int *texels;

int stat_first_encounter = 0;
int stat_transparent = 0;
int stat_compressed = 0;
int stat_super_transparent = 0;
int stat_frames_rendered = 0;
int stat_textures_rendered = 0;

extern void MakeBitValues(void);

#endif

#ifdef WARP3D
extern void WARP_Kludge(void);
extern struct Library *Warp3DBase;
extern W3D_Context *WARP_Context;
extern W3D_Texture *WARP_Dummy;
#endif

#ifdef POLY_STAT
int g3_stat_poly;
int g3_stat_tmap;
int g3_stat_poly_min=10000;
int g3_stat_poly_max=-1;
int g3_stat_tmap_min=10000;
int g3_stat_tmap_max=-1;
#ifdef WARP3D
int WARP_stat_tri;
int WARP_stat_tri_min = 10000;
int WARP_stat_tri_max = 0;
#endif
#endif

extern struct Window *win;
APTR WinLock;

//initialize the 3d system
void g3_init(void)
{
	atexit(g3_close);
}

//close down the 3d system
void g3_close(void)
{
#ifdef POLY_STAT
	printf("3D system polygon statistics:\n-----------------------------\n");
	printf("Minimal flat shaded: %d\nMaximal flat shaded: %d\n", g3_stat_poly_min, g3_stat_poly_max);
	printf("Minimal texture mapped: %d\nMaximal texture mapped: %d\n", g3_stat_tmap_min, g3_stat_tmap_max);
#ifdef WARP3D
	printf("Minimal hardware triangles: %d\nMaximal hardware triangles: %d\n", WARP_stat_tri_min, WARP_stat_tri_max);
#endif
#endif
}

extern void init_interface_vars_to_assembler(void);

//start the frame
void g3_start_frame(void)
{
	fix s;

	//set int w,h & fixed-point w,h/2
	Canv_w2 = (Canvas_width  = grd_curcanv->cv_bitmap.bm_w)<<15;
	Canv_h2 = (Canvas_height = grd_curcanv->cv_bitmap.bm_h)<<15;
//#ifdef __powerc
	fCanv_w2 = f2fl((Canvas_width  = grd_curcanv->cv_bitmap.bm_w)<<15);
	fCanv_h2 = f2fl((Canvas_height = grd_curcanv->cv_bitmap.bm_h)<<15);
//#endif

	//compute aspect ratio for this canvas

	s = fixmuldiv(grd_curscreen->sc_aspect,Canvas_height,Canvas_width);

	if (s <= 0) {       //scale x
		Window_scale.x = s;
		Window_scale.y = f1_0;
	}
	else {
		Window_scale.y = fixdiv(f1_0,s);
		Window_scale.x = f1_0;
	}
	
	Window_scale.z = f1_0;      //always 1

	init_free_points();

	init_interface_vars_to_assembler();     //for the texture-mapper

#ifdef WARP3D
	W3D_LockHardware(WARP_Context);
#ifdef POLY_STAT
	WARP_stat_tri = 0;
#endif
#endif

#ifdef POLY_STAT
	g3_stat_poly = 0;
	g3_stat_tmap = 0;
#endif
//    WinLock = LockBitMapTags(win->RPort->BitMap, TAG_DONE);
}

//this doesn't do anything, but is here for completeness
void g3_end_frame(void)
{
//    UnLockBitMap(WinLock);
//  Assert(free_point_num==0);
#ifdef WARP3D
	W3D_UnLockHardware(WARP_Context);
//    WARP_Kludge();
#endif
	free_point_num = 0;

#ifdef POLY_STAT

	if (g3_stat_poly < g3_stat_poly_min)    g3_stat_poly_min = g3_stat_poly;
	if (g3_stat_poly > g3_stat_poly_max)    g3_stat_poly_max = g3_stat_poly;

	if (g3_stat_tmap < g3_stat_tmap_min)    g3_stat_tmap_min = g3_stat_tmap;
	if (g3_stat_tmap > g3_stat_tmap_max)    g3_stat_tmap_max = g3_stat_tmap;

	if (WARP_stat_tri < WARP_stat_tri_min)  WARP_stat_tri_min = WARP_stat_tri;
	if (WARP_stat_tri > WARP_stat_tri_max)  WARP_stat_tri_max = WARP_stat_tri;

#endif
}



