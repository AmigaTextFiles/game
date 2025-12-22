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
 * $Source: /usr/CVS/descent/texmap/tmapflat.c,v $
 * $Revision: 1.7 $
 * $Author: nobody $
 * $Date: 1998/12/21 17:12:41 $
 *
 * Flat shader derived from texture mapper (a little slow)
 *
 * $Log: tmapflat.c,v $
 * Revision 1.7  1998/12/21 17:12:41  nobody
 * *** empty log message ***
 *
 * Revision 1.6  1998/11/09 22:20:45  nobody
 * *** empty log message ***
 *
 * Revision 1.5  1998/09/26 15:13:38  nobody
 * Added Warp3D support
 *
 * Revision 1.4  1998/03/31 17:11:52  hfrieden
 * Added ghost function for cloaking on ViRGE
 *
 * Revision 1.3  1998/03/22 19:22:34  tfrieden
 * white gun tips bug fixed
 *
 * Revision 1.2  1998/03/22 16:21:17  hfrieden
 * Added Flat Mapping for ViRGE
 *
 * Revision 1.1.1.1  1998/03/03 15:12:45  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:21:19  hfrieden
 * Initial Import
 *
 * Revision 1.4  1995/09/04  14:22:26  allender
 * brute force texture points to stay in buffer bounds
 *
 * Revision 1.3  1995/08/10  16:22:43  allender
 * conditional compile NASM being defined
 *
 * Revision 1.2  1995/06/25  21:52:24  allender
 * call c versions of asm routines for now since some asm not
 * implemented yet
 *
 * Revision 1.1  1995/05/04  20:15:55  allender
 * Initial revision
 *
 * Revision 1.13  1995/02/20  18:23:24  john
 * Added new module for C versions of inner loops.
 * 
 * Revision 1.12  1995/02/20  17:09:17  john
 * Added code so that you can build the tmapper with no assembly!
 * 
 * Revision 1.11  1994/11/30  00:58:01  mike
 * optimizations.
 * 
 * Revision 1.10  1994/11/28  13:34:32  mike
 * optimizations.
 * 
 * Revision 1.9  1994/11/19  15:21:46  mike
 * rip out unused code.
 * 
 * Revision 1.8  1994/11/12  16:41:41  mike
 * *** empty log message ***
 * 
 * Revision 1.7  1994/11/09  23:05:12  mike
 * do lighting on texture maps which get flat shaded instead.
 * 
 * Revision 1.6  1994/10/06  19:53:07  matt
 * Added function that takes same parms as draw_tmap(), but renders flat
 * 
 * Revision 1.5  1994/10/06  18:38:12  john
 * Added the ability to fade a scanline by calling gr_upoly_tmap
 * with Gr_scanline_darkening_level with a value < MAX_FADE_LEVELS.
 * 
 * Revision 1.4  1994/05/25  18:46:32  matt
 * Added gr_upoly_tmap_ylr(), which generates ylr's for a polygon
 * 
 * Revision 1.3  1994/04/08  16:25:58  mike
 * Comment out some includes (of header files)
 * call init_interface_vars_to_assembler.
 * 
 * Revision 1.2  1994/03/31  08:33:44  mike
 * Fixup flat shading version of texture mapper (get it?)
 * (Or maybe not, I admit to not testing my code...hahahah!)
 * 
 * Revision 1.1  1993/09/08  17:29:10  mike
 * Initial revision
 * 
 *
 */

#pragma off (unreferenced)
static char rcsid[] = "$Id: tmapflat.c,v 1.7 1998/12/21 17:12:41 nobody Exp $";
#pragma on (unreferenced)


#include <math.h>
// #include <graph.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

// #include "hack3df.h"
#include "fix.h"
#include "mono.h"
#include "gr.h"
#include "grdef.h"
// #include "ui.h"
#include "texmap.h"
#include "texmapl.h"
#include "scanline.h"

#ifdef WARP3D
#include "Warp3D.h"
#include <Warp3D/Warp3D.h>
#include <clib/Warp3D_protos.h>
#include <inline/Warp3D.h>
#endif

//#include "tmapext.h"
#ifdef VIRGIN
#include <cybergraphics/cybergraphics.h>
#include <inline/cybergraphics.h>
#include <exec/exec.h>
#include <inline/exec.h>
#include <cybergraphics/cgx3dvirgin.h>
#include <clib/cgx3dvirgin_protos.h>
#include <inline/cgx3dvirgin.h>
#include "VirgeTexture.h"

extern struct Library *CGX3DVirginBase;

extern Triangle3D tri;

#endif

#ifndef __powerc
#define NASM 1
#endif

#ifdef WARP3D
extern struct Library *Warp3DBase;
extern W3D_Context *WARP_Context;
extern W3D_Texture *WARP_Dummy;
W3D_Triangle tri;
#ifdef POLY_STAT
extern int WARP_stat_tri;
#endif

#endif

extern int PaletteRedAdd;
extern int PaletteGreenAdd;
extern int PaletteBlueAdd;

void (*scanline_func)();

extern void asm_tmap_scanline_shaded(); // In tmapfade.asm

// -------------------------------------------------------------------------------------
//  Texture map current scanline.
//  Uses globals Du_dx and Dv_dx to incrementally compute u,v coordinates
// -------------------------------------------------------------------------------------
void tmap_scanline_flat(int y, fix xleft, fix xright)
{
	if (xright < xleft)
		return;

	// setup to call assembler scanline renderer

	fx_y = y;
	fx_xleft = f2i(xleft);
	fx_xright = f2i(xright);

	if ( Gr_scanline_darkening_level >= GR_FADE_LEVELS )
		#ifdef NASM
			c_tmap_scanline_flat();
		#else
//          asm_tmap_scanline_flat();
			c_tmap_scanline_flat();
		#endif
	else    {
		tmap_flat_shade_value = Gr_scanline_darkening_level;
		#ifdef NASM
			c_tmap_scanline_shaded();
		#else
//          asm_tmap_scanline_shaded();
			c_tmap_scanline_shaded();
		#endif
	}   
}


//--unused-- void tmap_scanline_shaded(int y, fix xleft, fix xright)
//--unused-- {
//--unused--    fix dx;
//--unused-- 
//--unused--    dx = xright - xleft;
//--unused-- 
//--unused--    // setup to call assembler scanline renderer
//--unused-- 
//--unused--    fx_y = y << 16;
//--unused--    fx_xleft = xleft;
//--unused--    fx_xright = xright;
//--unused-- 
//--unused--    asm_tmap_scanline_shaded();
//--unused-- }


// -------------------------------------------------------------------------------------
//  Render a texture map.
// Linear in outer loop, linear in inner loop.
// -------------------------------------------------------------------------------------
void texture_map_flat(g3ds_tmap *t, int color)
{
#if !defined(VIRGIN) && !defined(WARP3D)
	int vlt,vrt,vlb,vrb;    // vertex left top, vertex right top, vertex left bottom, vertex right bottom
	int topy,boty,y, dy;
	fix dx_dy_left,dx_dy_right;
	int max_y_vertex;
	fix xleft,xright;
	fix recip_dy;
	g3ds_vertex *v3d;
#else
#ifdef VIRGIN
	extern View3D MyView;
#endif
#ifdef WARP3D
	int c;
	W3D_Color wcol;
#endif
	extern ULONG palette[800];
	LONG x[15], y[15], z[15],l[15];
	ULONG col = ((palette[1+color*3+0]&0xff000000)>>8)
			  | ((palette[1+color*3+1]&0xff000000)>>16)
			  | ((palette[1+color*3+2]&0xff000000)>>24);
	int nverts = t->nv;
	int i;

	if (color==255 || color==254) col=0x000000;
	for (i=0; i<nverts; i++) {
		x[i] = t->verts[i].x2d>>16;
		y[i] = t->verts[i].y2d>>16;
		if (x[i]<0) return;
		if (y[i]<0) return;
		if (x[i]>grd_curscreen->sc_canvas.cv_bitmap.bm_w) return;
		if (y[i]>grd_curscreen->sc_canvas.cv_bitmap.bm_h) return;
	}

#ifdef VIRGE
	if (V3D_LockView(MyView)) {
		tri.p1.x = x[0];
		tri.p1.y = y[0];
		tri.p1.z = 0;
		tri.p1.color.argbval = col;
		tri.th = NULL;
		for (i=1; i<nverts-1; i++) {
			tri.p2.x = x[i];
			tri.p2.y = y[i];
			tri.p2.z = 0;
			tri.p2.color.argbval = col;

			tri.p3.x = x[i+1];
			tri.p3.y = y[i+1];
			tri.p3.z = 0;
			tri.p3.color.argbval = col;

			V3D_DrawTriangle3D(MyView, &tri, BLENDMD_DECAL);
		}
		V3D_UnLockView(MyView);
	}
#else

	W3D_SetState(WARP_Context, W3D_TEXMAPPING, W3D_DISABLE);
	W3D_SetState(WARP_Context, W3D_GOURAUD, W3D_DISABLE);
	W3D_SetState(WARP_Context, W3D_BLENDING, W3D_DISABLE);

	if (color < 254) {
		wcol.r = (palette[1+color*3+0]>>24)/256.0;
		wcol.g = (palette[1+color*3+1]>>24)/256.0;
		wcol.b = (palette[1+color*3+2]>>24)/256.0;
	} else {
		wcol.r = 0.0;
		wcol.g = 0.0;
		wcol.b = 0.0;
	}
	wcol.a = 1.0;

	if (WARP_Modulate) {
		wcol.r = WARP_AddLight(wcol.r, PaletteRedAdd);
		wcol.g = WARP_AddLight(wcol.g, PaletteGreenAdd);
		wcol.b = WARP_AddLight(wcol.b, PaletteBlueAdd);
	}

	W3D_SetCurrentColor(WARP_Context, &wcol);

	tri.tex = NULL;
	tri.st_pattern = NULL;

	for (i=1; i<nverts-1; i++) {
		tri.v1.x = x[0];
		tri.v1.y = y[0];
		tri.v1.z = 0;
		tri.v1.w = 1.0; //z[0];
		tri.v1.u = 0;
		tri.v1.v = 0;
		tri.v2.x = x[i];
		tri.v2.y = y[i];
		tri.v2.z = 0;
		tri.v2.w = 1.0; //z[i];
		tri.v2.u = i%2;
		tri.v2.v = i%2;

		tri.v3.x = x[i+1];
		tri.v3.y = y[i+1];
		tri.v3.z = 0;
		tri.v3.w = 0.5; //z[i+1];
		tri.v3.u = (i+1)%2;
		tri.v3.v = (i+1)%2;
		W3D_DrawTriangle(WARP_Context, &tri);
#ifdef POLY_STAT
	WARP_stat_tri++;
#endif
	}
	if (WARP_TMap)  {
		W3D_SetState(WARP_Context, W3D_TEXMAPPING, W3D_ENABLE);
	}
	W3D_SetState(WARP_Context, W3D_GOURAUD, W3D_ENABLE);
	W3D_SetState(WARP_Context, W3D_BLENDING, W3D_ENABLE);

	return;
#endif
#endif
#if !defined(VIRGE) && !defined(WARP3D)
	v3d = t->verts;

	if (color==254 || color==255) color=0;
	tmap_flat_color = color;

	// Determine top and bottom y coords.
	compute_y_bounds(t,&vlt,&vlb,&vrt,&vrb,&max_y_vertex);

	// Set top and bottom (of entire texture map) y coordinates.
	topy = f2i(v3d[vlt].y2d);
	boty = f2i(v3d[max_y_vertex].y2d);

	// Set amount to change x coordinate for each advance to next scanline.
	dy = f2i(t->verts[vlb].y2d) - f2i(t->verts[vlt].y2d);
	if (dy < FIX_RECIP_TABLE_SIZE)
		recip_dy = fix_recip[dy];
	else
		recip_dy = F1_0/dy;

	dx_dy_left = compute_dx_dy(t,vlt,vlb, recip_dy);

	dy = f2i(t->verts[vrb].y2d) - f2i(t->verts[vrt].y2d);
	if (dy < FIX_RECIP_TABLE_SIZE)
		recip_dy = fix_recip[dy];
	else
		recip_dy = F1_0/dy;

	dx_dy_right = compute_dx_dy(t,vrt,vrb, recip_dy);

	// Set initial values for x, u, v
	xleft = v3d[vlt].x2d;
	xright = v3d[vrt].x2d;

	// scan all rows in texture map from top through first break.
	// @mk: Should we render the scanline for y==boty?  This violates Matt's spec.

	for (y = topy; y < boty; y++) {

		// See if we have reached the end of the current left edge, and if so, set
		// new values for dx_dy and x,u,v
		if (y == f2i(v3d[vlb].y2d)) {
			// Handle problem of double points.  Search until y coord is different.  Cannot get
			// hung in an infinite loop because we know there is a vertex with a lower y coordinate
			// because in the for loop, we don't scan all spanlines.
			while (y == f2i(v3d[vlb].y2d)) {
				vlt = vlb;
				vlb = prevmod(vlb,t->nv);
			}
			dy = f2i(t->verts[vlb].y2d) - f2i(t->verts[vlt].y2d);
			if (dy < FIX_RECIP_TABLE_SIZE)
				recip_dy = fix_recip[dy];
			else
				recip_dy = F1_0/dy;

			dx_dy_left = compute_dx_dy(t,vlt,vlb, recip_dy);

			xleft = v3d[vlt].x2d;
		}

		// See if we have reached the end of the current left edge, and if so, set
		// new values for dx_dy and x.  Not necessary to set new values for u,v.
		if (y == f2i(v3d[vrb].y2d)) {
			while (y == f2i(v3d[vrb].y2d)) {
				vrt = vrb;
				vrb = succmod(vrb,t->nv);
			}

			dy = f2i(t->verts[vrb].y2d) - f2i(t->verts[vrt].y2d);
			if (dy < FIX_RECIP_TABLE_SIZE)
				recip_dy = fix_recip[dy];
			else
				recip_dy = F1_0/dy;

			dx_dy_right = compute_dx_dy(t,vrt,vrb, recip_dy);

			xright = v3d[vrt].x2d;

		}

		//tmap_scanline_flat(y, xleft, xright);
		(*scanline_func)(y, xleft, xright);

		xleft += dx_dy_left;
		xright += dx_dy_right;

	}
	//tmap_scanline_flat(y, xleft, xright);
	(*scanline_func)(y, xleft, xright);
#endif
}

#if defined(VIRGIN) || defined(WARP3D)
void texture_map_flat_ghost(g3ds_tmap *t, int color)
{
#ifdef VIRGIN
	extern View3D MyView;
#endif
#ifdef WARP3D
	W3D_Float teil;
	W3D_Color wcol;
#endif
	extern ULONG palette[800];
	extern APTR DummyTextureHandle;
	LONG x[15], y[15], l[15];
	ULONG col = ((palette[1+color*3+0]&0xff000000)>>8)
			  | ((palette[1+color*3+1]&0xff000000)>>16)
			  | ((palette[1+color*3+2]&0xff000000)>>24);
	int nverts = t->nv;
	int i;

	if (color==255 || color==254) col=0x000000;
	for (i=0; i<nverts; i++) {
		x[i] = t->verts[i].x2d>>16;
		y[i] = t->verts[i].y2d>>16;
		if (x[i]<0) return;
		if (y[i]<0) return;
		if (x[i]>grd_curscreen->sc_canvas.cv_bitmap.bm_w) return;
		if (y[i]>grd_curscreen->sc_canvas.cv_bitmap.bm_h) return;
	}

#ifdef VIRIGN
	if (V3D_LockView(MyView)) {
		tri.p1.x = x[0];
		tri.p1.y = y[0];
		tri.p1.z = 0;
		tri.p1.color.argbval = col;
		tri.th = DummyTextureHandle;
		for (i=1; i<nverts-1; i++) {
			tri.p2.x = x[i];
			tri.p2.y = y[i];
			tri.p2.z = 0;
			tri.p2.color.argbval = col;

			tri.p3.x = x[i+1];
			tri.p3.y = y[i+1];
			tri.p3.z = 0;
			tri.p3.color.argbval = col;

			V3D_DrawTriangle3D(MyView, &tri, BLENDMD_DECAL);
		}
		V3D_UnLockView(MyView);
	}
#else

	teil = 1.0/256.0;
	wcol.r = (palette[1+color*3+0]>>24) * teil;
	wcol.g = (palette[1+color*3+1]>>24) * teil;
	wcol.b = (palette[1+color*3+2]>>24) * teil;
	wcol.a = 1.0;

//    W3D_SetCurrentColor(WARP_Context, &wcol);

//    W3D_SetState(WARP_Context, W3D_GOURAUD, W3D_DISABLE);
	W3D_SetState(WARP_Context, W3D_TEXMAPPING, W3D_DISABLE);

	tri.tex = WARP_Trans;
	tri.st_pattern = NULL;
	for (i=1; i<nverts-1; i++) {
		tri.v1.x = x[0];
		tri.v1.y = y[0];
		tri.v1.z = 0;
		tri.v1.w = 0.5;
		tri.v1.u = 0;
		tri.v1.v = 0;
		tri.v1.color.a = (double)rand()/65536.0;
		tri.v1.color.r = tri.v1.color.g = tri.v1.color.b = 0.6;
		tri.v2.x = x[i];
		tri.v2.y = y[i];
		tri.v2.z = 0;
		tri.v2.w = 0.5;
		tri.v2.u = i%2;
		tri.v2.v = i%2;
		tri.v2.color.a = (double)rand()/65536.0;
		tri.v2.color.r = tri.v2.color.g = tri.v2.color.b = 0.6;
		tri.v3.x = x[i+1];
		tri.v3.y = y[i+1];
		tri.v3.z = 0;
		tri.v2.w = 0.5;
		tri.v3.u = (i+1)%2;
		tri.v3.v = (i+1)%2;
		tri.v3.color.a = (double)rand()/65536.0;
		tri.v3.color.r = tri.v3.color.g = tri.v3.color.b = 0.6;
		W3D_DrawTriangle(WARP_Context, &tri);
#ifdef POLY_STAT
	WARP_stat_tri++;
#endif
	}

//    W3D_SetState(WARP_Context, W3D_GOURAUD, W3D_ENABLE);
	W3D_SetState(WARP_Context, W3D_TEXMAPPING, W3D_ENABLE);

#endif
	return;
}
#endif

//  -----------------------------------------------------------------------------------------
//  This is the gr_upoly-like interface to the texture mapper which uses texture-mapper compatible
//  (ie, avoids cracking) edge/delta computation.
void gr_upoly_tmap(int nverts, int *vert )
{
	gr_upoly_tmap_ylr(nverts, vert, tmap_scanline_flat);
}

#include "3d.h"
#include "error.h"

typedef struct pnt2d {
	fix x,y;
} pnt2d;

#pragma off (unreferenced)      //bp not referenced

//this takes the same partms as draw_tmap, but draws a flat-shaded polygon
void draw_tmap_flat(grs_bitmap *bp,int nverts,g3s_point **vertbuf)
{
	pnt2d   points[MAX_TMAP_VERTS];
	int i;
	fix average_light;
	int color;

	Assert(nverts < MAX_TMAP_VERTS);

	average_light = vertbuf[0]->p3_l;
	for (i=1; i<nverts; i++)
		average_light += vertbuf[i]->p3_l;

	if (nverts == 4)
		average_light = f2i(average_light * NUM_LIGHTING_LEVELS/4);
	else
		average_light = f2i(average_light * NUM_LIGHTING_LEVELS/nverts);

	if (average_light < 0)
		average_light = 0;
	else if (average_light > NUM_LIGHTING_LEVELS-1)
		average_light = NUM_LIGHTING_LEVELS-1;

	color = gr_fade_table[average_light*256 + bp->avg_color];
	gr_setcolor(color);

	for (i=0;i<nverts;i++) {
		points[i].x = vertbuf[i]->p3_sx;
		points[i].y = vertbuf[i]->p3_sy;
	}

	gr_upoly_tmap(nverts,(int *) points);

}
#pragma on (unreferenced)
#if defined(VIRGIN) || defined(WARP3D)
void draw_tmap_flat_ghost(grs_bitmap *bp,int nverts,g3s_point **vertbuf)
{
	pnt2d   points[MAX_TMAP_VERTS];
	int i;
	fix average_light;
	int color;

	Assert(nverts < MAX_TMAP_VERTS);

	average_light = vertbuf[0]->p3_l;
	for (i=1; i<nverts; i++)
		average_light += vertbuf[i]->p3_l;

	if (nverts == 4)
		average_light = f2i(average_light * NUM_LIGHTING_LEVELS/4);
	else
		average_light = f2i(average_light * NUM_LIGHTING_LEVELS/nverts);

	if (average_light < 0)
		average_light = 0;
	else if (average_light > NUM_LIGHTING_LEVELS-1)
		average_light = NUM_LIGHTING_LEVELS-1;

	color = gr_fade_table[average_light*256 + bp->avg_color];
	gr_setcolor(color);

	for (i=0;i<nverts;i++) {
		points[i].x = vertbuf[i]->p3_sx;
		points[i].y = vertbuf[i]->p3_sy;
	}

	gr_upoly_tmap_ylr_ghost(nverts,(int *) points);

}

void gr_upoly_tmap_ylr_ghost(int nverts, int *vert, void (*ylr_func)() )
{
	g3ds_tmap   my_tmap;
	int         i;

	//--now called from g3_start_frame-- init_interface_vars_to_assembler();

	my_tmap.nv = nverts;

	for (i=0; i<nverts; i++) {
		my_tmap.verts[i].x2d = *vert++;
		my_tmap.verts[i].y2d = *vert++;
		if (my_tmap.verts[i].x2d < 0)
			my_tmap.verts[i].x2d = 0;
		else if (my_tmap.verts[i].x2d > FIX_XLIMIT)
			my_tmap.verts[i].x2d = FIX_XLIMIT;
		if (my_tmap.verts[i].y2d < 0)
			my_tmap.verts[i].y2d = 0;
		else if (my_tmap.verts[i].y2d > FIX_YLIMIT)
			my_tmap.verts[i].y2d = FIX_YLIMIT;
	}

	scanline_func = ylr_func;

	texture_map_flat_ghost(&my_tmap, COLOR);
}

#endif

//  -----------------------------------------------------------------------------------------
//This is like gr_upoly_tmap() but instead of drawing, it calls the specified
//function with ylr values
void gr_upoly_tmap_ylr(int nverts, int *vert, void (*ylr_func)() )
{
	g3ds_tmap   my_tmap;
	int         i;

	//--now called from g3_start_frame-- init_interface_vars_to_assembler();

	my_tmap.nv = nverts;

	for (i=0; i<nverts; i++) {
		my_tmap.verts[i].x2d = *vert++;
		my_tmap.verts[i].y2d = *vert++;
		if (my_tmap.verts[i].x2d < 0)
			my_tmap.verts[i].x2d = 0;
		else if (my_tmap.verts[i].x2d > FIX_XLIMIT)
			my_tmap.verts[i].x2d = FIX_XLIMIT;
		if (my_tmap.verts[i].y2d < 0)
			my_tmap.verts[i].y2d = 0;
		else if (my_tmap.verts[i].y2d > FIX_YLIMIT)
			my_tmap.verts[i].y2d = FIX_YLIMIT;
	}

	scanline_func = ylr_func;

	texture_map_flat(&my_tmap, COLOR);
}

