#ifdef VIRGIN
#include <math.h>
#include <stdio.h>
#include <utility/tagitem.h>
#include <exec/exec.h>
#include <proto/exec.h>
#include <proto/utility.h>
#include <proto/cybergraphics.h>
#include <cybergraphics/cgx3dvirgin.h>
#include <clib/cgx3dvirgin_protos.h>
#include <inline/cgx3dvirgin.h>
#include "virge.h"
#include "texmap.h"
#include "game.h"

extern APTR MyView;
extern struct Library *CGX3DVirginBase;
extern int VirgeFilter;
extern int VirgeModulateLight;

V3DTriangle vtri;


__inline vfloat vAddLight(vfloat component, int add)
{
	vfloat res;
	if (add==0 || VirgeModulateLight==0) return component;
	res = component + (vfloat)(add<<2);
	if (res>255.0) res=255.0;
	return res;
}

void VirgeDrawPolyP(g3ds_tmap *tmap, const APTR texture)
{
	int ll;
	int i;
	vVertex v1,v2,v3;
	vfloat x[10],y[10];//,iz[10];
	vfloat u[10],v[10];
	vfloat l[10];
	int fl1 = 0;
	int fl2 = 0;

	// --- Prepare values
	for (i=0; i<tmap->nv; i++) {
		x[i] =       (vfloat)tmap->verts[i].x2d / 65536.0;
		y[i] =       (vfloat)tmap->verts[i].y2d / 65536.0;
		//iz[i]= 4.0 * (vfloat)tmap->verts[i].z   / 65536.0;
		u[i] =       (vfloat)((tmap->verts[i].u>>14)+256);
		v[i] =       (vfloat)((tmap->verts[i].v>>14)+256);

		// --- Get and correct lighting level.
		ll = tmap->verts[i].l>>8;
		if (ll)         ll--;       // correct level
		if (ll>0xff)    ll=0xff;    // and cut off
		l[i] =          (vfloat)ll;
	}

	for (i=0; i<tmap->nv; i++) {
		if (u[i]<0) fl1=1;
		if (v[i]<0) fl2=1;
	}

	if (fl1) {
		for (i=0; i<tmap->nv; i++) {
			u[i] += 256.f;
		}
	}

	if (fl2) {
		for (i=0; i<tmap->nv; i++) {
			v[i] += 256.f;
		}
	}

	// --- Draw a triangle fan
	//     Common Vertex 0 moved out from inner loop to save time
	//     Move back for perspective correction (p.c. modifies
	//     structure values).
	v1.x = x[0]; v1.y = y[0]; //v1.iz = iz[0];
	v1.u = u[0]; v1.v = v[0];
	v1.r = vAddLight(l[0],PaletteRedAdd); v1.g = vAddLight(l[0], PaletteGreenAdd);
	v1.b = vAddLight(l[0],PaletteBlueAdd);
	if (V3D_LockView(MyView)) {
		for (i=1; i<tmap->nv-1; i++) {

			// Draw a triangle 0 - i - i+1
			v2.x = x[i]; v2.y = y[i]; //v2.iz = iz[i];
			v2.u = u[i]; v2.v = v[i];
			v2.r = vAddLight(l[i],PaletteRedAdd);
			v2.g = vAddLight(l[i],PaletteGreenAdd);
			v2.b = vAddLight(l[i],PaletteBlueAdd);

			v3.x = x[i+1]; v3.y = y[i+1]; //v3.iz = iz[i+1];
			v3.u = u[i+1]; v3.v = v[i+1];
			v3.r = vAddLight(l[i+1], PaletteRedAdd);
			v3.g = vAddLight(l[i+1], PaletteGreenAdd);
			v3.b = vAddLight(l[i+1], PaletteBlueAdd);
			VirgeTriangle(texture, &v1, &v2, &v3);
		}
		V3D_UnLockView(MyView);
	}
}

void VirgeDrawPolyPP(g3ds_tmap *tmap, const APTR texture)
{
	int ll;
	int i;
	vVertex v1,v2,v3;
	vfloat x[10],y[10],iz[10];
	vfloat u[10],v[10];
	vfloat l[10];
	int fl1 = 0;
	int fl2 = 0;

	// --- Prepare values
	for (i=0; i<tmap->nv; i++) {
		x[i] =       (vfloat)tmap->verts[i].x2d / 65536.0;
		y[i] =       (vfloat)tmap->verts[i].y2d / 65536.0;
		iz[i]= 4.0 * (vfloat)tmap->verts[i].z   / 65536.0;
		u[i] =       (vfloat)((tmap->verts[i].u>>14)+256);
		v[i] =       (vfloat)((tmap->verts[i].v>>14)+256);

		// --- Get and correct lighting level.
		ll = tmap->verts[i].l>>8;
		if (ll)         ll--;       // correct level
		if (ll>0xff)    ll=0xff;    // and cut off
		l[i] =          (vfloat)ll;
	}

	for (i=0; i<tmap->nv; i++) {
		if (u[i]<0) fl1=1;
		if (v[i]<0) fl2=1;
	}

	if (fl1) {
		for (i=0; i<tmap->nv; i++) {
			u[i] += 256.f;
		}
	}

	if (fl2) {
		for (i=0; i<tmap->nv; i++) {
			v[i] += 256.f;
		}
	}

	// --- Draw a triangle fan
	//     Common Vertex 0 moved out from inner loop to save time
	//     Move back for perspective correction (p.c. modifies
	//     structure values).
	if (V3D_LockView(MyView)) {
		for (i=1; i<tmap->nv-1; i++) {
			v1.x = x[0]; v1.y = y[0]; v1.iz = iz[0];
			v1.u = u[0]; v1.v = v[0];
			v1.r = vAddLight(l[0],PaletteRedAdd); v1.g = vAddLight(l[0], PaletteGreenAdd);
			v1.b = vAddLight(l[0],PaletteBlueAdd);

			// Draw a triangle 0 - i - i+1
			v2.x = x[i]; v2.y = y[i]; v2.iz = iz[i];
			v2.u = u[i]; v2.v = v[i];
			v2.r = vAddLight(l[i],PaletteRedAdd);
			v2.g = vAddLight(l[i],PaletteGreenAdd);
			v2.b = vAddLight(l[i],PaletteBlueAdd);

			v3.x = x[i+1]; v3.y = y[i+1]; v3.iz = iz[i+1];
			v3.u = u[i+1]; v3.v = v[i+1];
			v3.r = vAddLight(l[i+1], PaletteRedAdd);
			v3.g = vAddLight(l[i+1], PaletteGreenAdd);
			v3.b = vAddLight(l[i+1], PaletteBlueAdd);
			VirgeTriangleP(texture, &v1, &v2, &v3);
		}
		V3D_UnLockView(MyView);
	}
}


void VirgeTriangleP(const APTR texture, vVertex *p1, vVertex *p2, vVertex *p3)
{
	sdword y1, y2, y3, dy2, dy3;
	vVertex *pe1top, *pe1bot, *pe2top, *pe2bot, *pTmp;
	vfloat drdx, dgdx, dbdx, dudx, dvdx, den, dadx = 0;
	vfloat e1idy, e2idy, e3idy, e1dxdy, e2dxdy, e3dxdy;
	vfloat e1drdy, e1dgdy, e1dbdy, e1dudy, e1dvdy, e1dady = 0;
	vfloat dwdx, e1dwdy;
	vfloat r0, g0, b0, u0, v0, w0;
	vfloat e1frac, e2frac, e3frac;
	dword left_to_right, e2scans, e3scans;

		// ViRGE registers to write
	dword dGdX_dBdX, dAdX_dRdX, dGdY_dBdY, dAdY_dRdY, GS_BS, AS_RS; // S8.7
	dword dXdY12, Xend12, dXdY01, Xend01, dXdY02, XS;               // S11.20
	dword YS, LR_Y01_Y12;               // LR (bit 31) == render left to right

	dword US, VS, dUdX, dVdX, dUdY, dVdY;

	dword dWdX, WS, dWdY;

	p1->iz *= 4.f;//096.f;
	p2->iz *= 4.f;//096.f;
	p3->iz *= 4.f;//096.f;
//    printf("(%f %f %f) (%f %f)\n", p1->iz, p2->iz, p3->iz, p2->u, p2->v);

	p1->u = p1->u * p1->iz * 8.f;
	p1->v = p1->v * p1->iz * 8.f;
	p2->u = p2->u * p2->iz * 8.f;
	p2->v = p2->v * p2->iz * 8.f;
	p3->u = p3->u * p3->iz * 8.f;
	p3->v = p3->v * p3->iz * 8.f;

	left_to_right = 0;

		// Find bottom-most pixel
	y1 = floor(p1->y);
	y2 = floor(p2->y);
	y3 = floor(p3->y);

	if (y1 == y2 && y2 == y3)
		return;

		// Calc global d?/dx
	den = (p2->x - p1->x) * (p3->y - p1->y) - (p3->x - p1->x) * (p2->y - p1->y);
	den = 1.0 / den;
	drdx = ((p2->r - p1->r) * (p3->y - p1->y) - (p3->r - p1->r) * (p2->y - p1->y)) * den;
	dgdx = ((p2->g - p1->g) * (p3->y - p1->y) - (p3->g - p1->g) * (p2->y - p1->y)) * den;
	dbdx = ((p2->b - p1->b) * (p3->y - p1->y) - (p3->b - p1->b) * (p2->y - p1->y)) * den;
	dudx = ((p2->u - p1->u) * (p3->y - p1->y) - (p3->u - p1->u) * (p2->y - p1->y)) * den;
	dvdx = ((p2->v - p1->v) * (p3->y - p1->y) - (p3->v - p1->v) * (p2->y - p1->y)) * den;
	dwdx = ((p2->iz - p1->iz) * (p3->y - p1->y) - (p3->iz - p1->iz) * (p2->y - p1->y)) * den;

		// Determine the topology
	if (y1 > y2)
	{
		if (y1 > y3)
		{
			// p1 is bottom-most
			// NO CHANGE
		} else { // if (y3 > y1) {
			// p3 is bottom most
			pTmp = p1;
			p1 = p3;
			p3 = pTmp;
			y1 ^= y3 ^= y1 ^= y3;
		}
	} else if (y2 > y1) {
		if (y2 > y3)
		{
			// p2 is bottom-most
			pTmp = p1;
			p1 = p2;
			p2 = pTmp;
			y1 ^= y2 ^= y1 ^= y2;
		} else {
			// p3 is bottom most
			pTmp = p1;
			p1 = p3;
			p3 = pTmp;
			y1 ^= y3 ^= y1 ^= y3;
		}
	} else if (y3 > y1)
	{
		// p3 is bottom most
		pTmp = p1;
		p1 = p3;
		p3 = pTmp;
		y1 ^= y3 ^= y1 ^= y3;
	}

		// p1 is bottommost now
	dy2 = y1 - y2;
	dy3 = y1 - y3;

	if (dy2 == 0)
	{
		pe1bot = p2;
		pe1top = p3;
		pe2bot = p1;
		pe2top = p3;
		if (pe1bot->x < pe2bot->x)
			left_to_right = (1 << 31);
		e2scans = dy3;
		e3scans = 0;
	}
	else if (dy3 == 0)
	{
		pe1bot = p3;
		pe1top = p2;
		pe2bot = p1;
		pe2top = p2;
		if (pe1bot->x < pe2bot->x)
			left_to_right = (1 << 31);
		e2scans = dy2;
		e3scans = 0;
	} else {
		if (dy2 > dy3)
		{
			pe1bot = p1;
			pe1top = p2;
			pe2bot = p1;
			pe2top = p3;
			e2scans = dy3;
			e3scans = dy2 - dy3;
		} else if (dy3 > dy2) {
			pe1bot = p1;
			pe1top = p3;
			pe2bot = p1;
			pe2top = p2;
			e2scans = dy2;
			e3scans = dy3 - dy2;
		} else {
			pe1bot = p1;
			pe1top = p2;
			pe2bot = p1;
			pe2top = p3;
			e2scans = dy2;
			e3scans = 0;
			if (pe1top->x < pe2top->x)
				left_to_right = (1 << 31);
		}
	}

		// Geometry calcs
	e1idy = 1.0 / (pe1bot->y - pe1top->y);
	e2idy = 1.0 / (pe2bot->y - pe2top->y);
	e1dxdy = (pe1top->x - pe1bot->x) * e1idy;
	e1drdy = (pe1top->r - pe1bot->r) * e1idy;
	e1dgdy = (pe1top->g - pe1bot->g) * e1idy;
	e1dbdy = (pe1top->b - pe1bot->b) * e1idy;
	e1dudy = (pe1top->u - pe1bot->u) * e1idy;
	e1dvdy = (pe1top->v - pe1bot->v) * e1idy;
	e1dwdy = (pe1top->iz - pe1bot->iz) * e1idy;
	e2dxdy = (pe2top->x - pe2bot->x) * e2idy;
	e1frac = pe1bot->y - floor(pe1bot->y);
	e2frac = pe2bot->y - floor(pe2bot->y);

	r0 = pe1bot->r + e1drdy * e1frac;
	g0 = pe1bot->g + e1dgdy * e1frac;
	b0 = pe1bot->b + e1dbdy * e1frac;
	u0 = pe1bot->u + e1dudy * e1frac;
	v0 = pe1bot->v + e1dvdy * e1frac;
	w0 = pe1bot->iz + e1dwdy * e1frac;

	if (e3scans)
	{
		if (e2dxdy > e1dxdy)
		{
			left_to_right = (1 << 31);
		}
		e3idy = 1.0 / (pe2top->y - pe1top->y);
		e3dxdy = (pe1top->x - pe2top->x) * e3idy;
		e3frac = pe2top->y - floor(pe2top->y);
	}

	if (!left_to_right)
	{
		drdx = -drdx;
		dgdx = -dgdx;
		dbdx = -dbdx;
		dudx = -dudx;
		dvdx = -dvdx;
		dwdx = -dwdx;
	}


		// Prepare values for the ViRGE regs
	XS          = (dword) ((pe1bot->x + e1frac * e1dxdy) * TWO_E_20);
	Xend01      = (dword) ((pe2bot->x + e2frac * e2dxdy) * TWO_E_20);

	dXdY01      = (dword) (e2dxdy * TWO_E_20);
	dXdY02      = (dword) (e1dxdy * TWO_E_20);

	if (e3scans)
	{
		dXdY12  = e3dxdy * TWO_E_20;
		Xend12  = (dword) ((pe2top->x + e3frac * e3dxdy) * TWO_E_20);
	}

	YS          = y1;
	LR_Y01_Y12  = left_to_right | (e2scans << 16) | e3scans;

	dGdX_dBdX = (((dword)(dgdx * 128.0)) << 16)
			  | (((dword)(dbdx * 128.0)) & 0xFFFF);
	dAdX_dRdX = (((dword)(dadx * 128.0)) << 16)
			  | (((dword)(drdx * 128.0)) & 0xFFFF);
	dGdY_dBdY = (((dword)(e1dgdy * 128.0)) << 16)
			  | (((dword)(e1dbdy * 128.0)) & 0xFFFF);
	dAdY_dRdY = (((dword)(e1dady * 128.0)) << 16)
			  | (((dword)(e1drdy * 128.0)) & 0xFFFF);

	GS_BS = (((sdword)(g0 * 128.0)) << 16)
		  | ((sdword)(b0 * 128.0));
	AS_RS = (((sdword)(0 * 128.0)) << 16)
		  | ((sdword)(r0 * 128.0));

	US   = (sdword)(u0 * 128.0 * 1.0);
	VS   = (sdword)(v0 * 128.0 * 1.0);
	dUdX = (sdword)(dudx * 128.0 * 1.0);
	dVdX = (sdword)(dvdx * 128.0 * 1.0);
	dUdY = (sdword)(e1dudy * 128.0 * 1.0);
	dVdY = (sdword)(e1dvdy * 128.0 * 1.0);

	WS = (sdword)(w0 * 256.0 * 2048.0);
	dWdX =  (sdword)(dwdx * 256.0 * 2048.0);
	dWdY = (sdword)(e1dwdy * 256.0 * 2048.0);

		// Do!

	bzero(&vtri, sizeof(vtri));
	vtri.T3D_TdWdX = dWdX;
	vtri.T3D_TdWdY = dWdY;
	vtri.T3D_TWS   = WS;
	vtri.T3D_TdDdX = 0x5;
	vtri.T3D_TdVdX = dVdX;
	vtri.T3D_TdUdX = dUdX;
	vtri.T3D_TdDdY = 0x5;
	vtri.T3D_TdVdY = dVdY;
	vtri.T3D_TdUdY = dUdY;
	vtri.T3D_TDS = 0x5;
	vtri.T3D_TVS = VS;
	vtri.T3D_TUS = US;

	vtri.T3D_TdGdX_dBdX = dGdX_dBdX;
	vtri.T3D_TdAdX_dRdX = dAdX_dRdX;
	vtri.T3D_TdGdY_dBdY = dGdY_dBdY;
	vtri.T3D_TdAdY_dRdY = dAdY_dRdY;
	vtri.T3D_TGS_BS = GS_BS;
	vtri.T3D_TAS_RS = AS_RS;

	if (e3scans)
	{
		vtri.T3D_TdXdY12 = dXdY12;
		vtri.T3D_TXEND12 = Xend12;
	}
	vtri.T3D_TdXdY01 = dXdY01;
	vtri.T3D_TXEND01 = Xend01;
	vtri.T3D_TdXdY02 = dXdY02;
	vtri.T3D_TXS = XS;
	vtri.T3D_TYS = YS;
	vtri.T3D_TY01_Y12 = LR_Y01_Y12;

	vtri.T3D_CMD_SET =
				  VIRGE_CS_3D
				| VIRGE_CS_CMD_LITTEXTRI_P
				| VIRGE_CS_BLEND_MODULATE
				| VIRGE_CS_TEXTURE_WRAP
				| ((6<<VIRGE_CS_MIPMAP_SIZE_POS) & VIRGE_CS_MIPMAP_SIZE_MSK)
				| VIRGE_CS_TEXFMT_16_1555
				| VIRGE_CS_HWCLIP
				;
	if (VirgeFilter == 1)
		vtri.T3D_CMD_SET |= VIRGE_CS_TEXFILT_4TPP;
	 else
		vtri.T3D_CMD_SET |= VIRGE_CS_TEXFILT_1TPP;

	V3D_BlitV3DTriangle(MyView, &vtri, texture);
}


#define o(x)
	//printf("%s=%f\n", #x, x)
#define o1(x)
	//printf("%s=0x%X\n", #x, x)

void VirgeTriangle(const APTR texture, vVertex *p1, vVertex *p2, vVertex *p3)
{
	sdword y1, y2, y3, dy2, dy3;
	vVertex *pe1top, *pe1bot, *pe2top, *pe2bot, *pTmp;
	vfloat drdx, dgdx, dbdx, dudx, dvdx, den, dadx = 0;
	vfloat e1idy, e2idy, e3idy, e1dxdy, e2dxdy, e3dxdy;
	vfloat e1drdy, e1dgdy, e1dbdy, e1dudy, e1dvdy, e1dady = 0;
	vfloat r0, g0, b0, u0, v0;
	vfloat e1frac, e2frac, e3frac;
	dword left_to_right, e2scans, e3scans;
	static V3DTriangle vtri;

		// ViRGE registers to write
	dword dGdX_dBdX, dAdX_dRdX, dGdY_dBdY, dAdY_dRdY, GS_BS, AS_RS; // S8.7
	dword dXdY12, Xend12, dXdY01, Xend01, dXdY02, XS;               // S11.20
	dword YS, LR_Y01_Y12;               // LR (bit 31) == render left to right

	dword US, VS, dUdX, dVdX, dUdY, dVdY;


	left_to_right = 0;

		// Find bottom-most pixel
	y1 = floor(p1->y);
	y2 = floor(p2->y);
	y3 = floor(p3->y);

	if (y1 == y2 && y2 == y3)
		return;

		// Calc global d?/dx
	den = (p2->x - p1->x) * (p3->y - p1->y) - (p3->x - p1->x) * (p2->y - p1->y);
	den = 1.0 / den;
	drdx = ((p2->r - p1->r) * (p3->y - p1->y) - (p3->r - p1->r) * (p2->y - p1->y)) * den;
	dgdx = ((p2->g - p1->g) * (p3->y - p1->y) - (p3->g - p1->g) * (p2->y - p1->y)) * den;
	dbdx = ((p2->b - p1->b) * (p3->y - p1->y) - (p3->b - p1->b) * (p2->y - p1->y)) * den;
	dudx = ((p2->u - p1->u) * (p3->y - p1->y) - (p3->u - p1->u) * (p2->y - p1->y)) * den;
	dvdx = ((p2->v - p1->v) * (p3->y - p1->y) - (p3->v - p1->v) * (p2->y - p1->y)) * den;
	o(drdx); o(dgdx); o(dbdx); o(dudx); o(dvdx);

		// Determine the topology
	if (y1 > y2)
	{
		if (y1 > y3)
		{
			// p1 is bottom-most
			// NO CHANGE
		} else { // if (y3 > y1)
			// p3 is bottom most
			pTmp = p1;
			p1 = p3;
			p3 = pTmp;
			y1 ^= y3 ^= y1 ^= y3;
		}
	} else if (y2 > y1) {
		if (y2 > y3)
		{
			// p2 is bottom-most
			pTmp = p1;
			p1 = p2;
			p2 = pTmp;
			y1 ^= y2 ^= y1 ^= y2;
		} else {
			// p3 is bottom most
			pTmp = p1;
			p1 = p3;
			p3 = pTmp;
			y1 ^= y3 ^= y1 ^= y3;
		}
	} else if (y3 > y1)
	{
		// p3 is bottom most
		pTmp = p1;
		p1 = p3;
		p3 = pTmp;
		y1 ^= y3 ^= y1 ^= y3;
	}

		// p1 is bottommost now
	dy2 = y1 - y2;
	dy3 = y1 - y3;

	if (dy2 == 0)
	{
		pe1bot = p2;
		pe1top = p3;
		pe2bot = p1;
		pe2top = p3;
		if (pe1bot->x < pe2bot->x)
			left_to_right = (1 << 31);
		e2scans = dy3;
		e3scans = 0;
	}
	else if (dy3 == 0)
	{
		pe1bot = p3;
		pe1top = p2;
		pe2bot = p1;
		pe2top = p2;
		if (pe1bot->x < pe2bot->x)
			left_to_right = (1 << 31);
		e2scans = dy2;
		e3scans = 0;
	} else {
		if (dy2 > dy3)
		{
			pe1bot = p1;
			pe1top = p2;
			pe2bot = p1;
			pe2top = p3;
			e2scans = dy3;
			e3scans = dy2 - dy3;
		} else if (dy3 > dy2) {
			pe1bot = p1;
			pe1top = p3;
			pe2bot = p1;
			pe2top = p2;
			e2scans = dy2;
			e3scans = dy3 - dy2;
		} else {
			pe1bot = p1;
			pe1top = p2;
			pe2bot = p1;
			pe2top = p3;
			e2scans = dy2;
			e3scans = 0;
			if (pe1top->x < pe2top->x)
				left_to_right = (1 << 31);
		}
	}

		// Geometry calcs
	e1idy = 1.0 / (pe1bot->y - pe1top->y);
	e2idy = 1.0 / (pe2bot->y - pe2top->y);
	e1dxdy = (pe1top->x - pe1bot->x) * e1idy;
	e1drdy = (pe1top->r - pe1bot->r) * e1idy;
	e1dgdy = (pe1top->g - pe1bot->g) * e1idy;
	e1dbdy = (pe1top->b - pe1bot->b) * e1idy;
	e1dudy = (pe1top->u - pe1bot->u) * e1idy;
	e1dvdy = (pe1top->v - pe1bot->v) * e1idy;
	e2dxdy = (pe2top->x - pe2bot->x) * e2idy;
	e1frac = pe1bot->y - floor(pe1bot->y);
	e2frac = pe2bot->y - floor(pe2bot->y);

	r0 = pe1bot->r + e1drdy * e1frac;
	g0 = pe1bot->g + e1dgdy * e1frac;
	b0 = pe1bot->b + e1dbdy * e1frac;
	u0 = pe1bot->u + e1dudy * e1frac;
	v0 = pe1bot->v + e1dvdy * e1frac;

	if (e3scans)
	{
		if (e2dxdy > e1dxdy)
		{
			left_to_right = (1 << 31);
		}
		e3idy = 1.0 / (pe2top->y - pe1top->y);
		e3dxdy = (pe1top->x - pe2top->x) * e3idy;
		e3frac = pe2top->y - floor(pe2top->y);
	}

	if (!left_to_right)
	{
		drdx = -drdx;
		dgdx = -dgdx;
		dbdx = -dbdx;
		dudx = -dudx;
		dvdx = -dvdx;
	}


		// Prepare values for the ViRGE regs
	XS          = (dword) ((pe1bot->x + e1frac * e1dxdy) * TWO_E_20);
	Xend01      = (dword) ((pe2bot->x + e2frac * e2dxdy) * TWO_E_20);

	dXdY01      = (dword) (e2dxdy * TWO_E_20);
	dXdY02      = (dword) (e1dxdy * TWO_E_20);

	if (e3scans)
	{
		dXdY12  = e3dxdy * TWO_E_20;
		Xend12  = (dword) ((pe2top->x + e3frac * e3dxdy) * TWO_E_20);
	}

	YS          = y1;
	LR_Y01_Y12  = left_to_right | (e2scans << 16) | e3scans;

	dGdX_dBdX = (((dword)(dgdx * 128.0)) << 16)
			  | (((dword)(dbdx * 128.0)) & 0xFFFF);
	dAdX_dRdX = (((dword)(dadx * 128.0)) << 16)
			  | (((dword)(drdx * 128.0)) & 0xFFFF);
	dGdY_dBdY = (((dword)(e1dgdy * 128.0)) << 16)
			  | (((dword)(e1dbdy * 128.0)) & 0xFFFF);
	dAdY_dRdY = (((dword)(e1dady * 128.0)) << 16)
			  | (((dword)(e1drdy * 128.0)) & 0xFFFF);

	GS_BS = (((sdword)(g0 * 128.0)) << 16)
		  | ((sdword)(b0 * 128.0));
	AS_RS = (((sdword)(0 * 128.0)) << 16)
		  | ((sdword)(r0 * 128.0));

	US = (sdword)(u0 * 256.0 * 2048.0);
	VS = (sdword)(v0 * 256.0 * 2048.0);
	dUdX = (sdword)(dudx * 256.0 * 2048.0);
	dVdX = (sdword)(dvdx * 256.0 * 2048.0);
	dUdY = (sdword)(e1dudy * 256.0 * 2048.0);
	dVdY = (sdword)(e1dvdy * 256.0 * 2048.0);


	bzero(&vtri, sizeof(vtri));
	vtri.T3D_TdDdX = 0;
	vtri.T3D_TdVdX = dVdX;              o1(dVdX);                     
	vtri.T3D_TdUdX = dUdX;              o1(dUdX);                     
	vtri.T3D_TdDdY = 0;                                               
	vtri.T3D_TdVdY = dVdY;              o1(dVdY);                     
	vtri.T3D_TdUdY = dUdY;              o1(dUdY);                     
	vtri.T3D_TDS = 0;                                                 
	vtri.T3D_TVS = VS;                  o1(VS);                       
	vtri.T3D_TUS = US;                  o1(US);                       
																	  
	vtri.T3D_TdGdX_dBdX = dGdX_dBdX;    o1(dGdX_dBdX);                
	vtri.T3D_TdAdX_dRdX = dAdX_dRdX;    o1(dAdX_dRdX);                
	vtri.T3D_TdGdY_dBdY = dGdY_dBdY;    o1(dGdY_dBdY);                
	vtri.T3D_TdAdY_dRdY = dAdY_dRdY;    o1(dAdY_dRdY);                
	vtri.T3D_TGS_BS = GS_BS;            o1(GS_BS);                    
	vtri.T3D_TAS_RS = AS_RS;            o1(AS_RS);                    
																	  
	if (e3scans)                                                      
	{                                                                 
		vtri.T3D_TdXdY12 = dXdY12;      o1(dXdY12);                   
		vtri.T3D_TXEND12 = Xend12;      o1(Xend12);                   
	}                                                                 
	vtri.T3D_TdXdY01 = dXdY01;          o1(dXdY01);                   
	vtri.T3D_TXEND01 = Xend01;          o1(Xend01);                   
	vtri.T3D_TdXdY02 = dXdY02;          o1(dXdY02);                   
	vtri.T3D_TXS = XS;                  o1(XS);                       
	vtri.T3D_TYS = YS;                  o1(YS);                       
	vtri.T3D_TY01_Y12 = LR_Y01_Y12;     o1(LR_Y01_Y12);               

	vtri.T3D_CMD_SET =
				  VIRGE_CS_3D
				| VIRGE_CS_CMD_LITTEXTRI
				| VIRGE_CS_BLEND_MODULATE
				| VIRGE_CS_TEXTURE_WRAP
				| ((6<<VIRGE_CS_MIPMAP_SIZE_POS) & VIRGE_CS_MIPMAP_SIZE_MSK)
				| VIRGE_CS_TEXFMT_16_1555
				| VIRGE_CS_HWCLIP
				;
	if (VirgeFilter == 1)
		vtri.T3D_CMD_SET |= VIRGE_CS_TEXFILT_4TPP;
	 else
		vtri.T3D_CMD_SET |= VIRGE_CS_TEXFILT_1TPP;


	V3D_BlitV3DTriangle(MyView, &vtri, texture);
}


#endif
