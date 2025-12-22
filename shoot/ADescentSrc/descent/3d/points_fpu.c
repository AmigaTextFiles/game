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
 * $Source: /usr/CVS/descent/3d/points_fpu.c,v $
 * $Revision: 1.1 $
 * $Author: tfrieden $
 * $Date: 1998/03/24 21:47:58 $
 *
 * FPU compiled version of points.c
 *
 * $Log: points_fpu.c,v $
 * Revision 1.1  1998/03/24 21:47:58  tfrieden
 * FPU version of g3_project_point
 *
 */

#include "3d.h"
#include "globvars.h"

void g3_project_point_fpu(g3s_point *p) {

	double fz;

	if ((p->p3_flags & PF_PROJECTED) || (p->p3_codes & CC_BEHIND))
		return;

	if ( p->p3_z <= 0 ) {
		p->p3_flags |= PF_OVERFLOW;
		return;
	}

	fz = f2fl(p->p3_z);
	p->p3_sx = fl2f(fCanv_w2 + (f2fl(p->p3_x)*fCanv_w2 / fz));
	p->p3_sy = fl2f(fCanv_h2 - (f2fl(p->p3_y)*fCanv_h2 / fz));

	p->p3_flags |= PF_PROJECTED;
}

