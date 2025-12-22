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
#include "fix.h"
#include "game.h"

extern APTR MyView;
extern struct Library *CGX3DVirginBase;
extern int VirgeFilter;
extern VertexV3Dtex vertex[20];
extern void _drawpoly(VertexV3Dtex **vertex, int nverts, APTR texh);
extern int VirgeModulateLight;

V3DTriangle vtri;
Triangle3D tri;

LONG AddLight(LONG l)
{
	LONG r,g,b;
	if (l) l--;
	r=l+(PaletteRedAdd<<2);      if (r>0xff) r=0xff; if (r<0) r=0;
	g=l+(PaletteGreenAdd<<2);    if (g>0xff) g=0xff; if (g<0) g=0;
	b=l+(PaletteBlueAdd<<2);     if (b>0xff) b=0xff; if (b<0) b=0;
	return (r<<16) | (g<<8) | b;
}


void VirgeDrawPolyI(g3ds_tmap *tmap, const APTR texture)
{
	int i;
	LONG us[15];
	LONG vs[15];
	LONG umin=0, vmin=0;
	LONG x[15], y[15], l[15];
	int lr, lg, lb;

	if (VirgeModulateLight == 0) {
		PaletteRedAdd = PaletteGreenAdd = PaletteBlueAdd = 0;
	}

	for (i=0; i<tmap->nv; i++) {
		us[i] = ((tmap->verts[i].u)>>14)+10240;
		vs[i] = ((tmap->verts[i].v)>>14)+10240;
		l [i] = AddLight((LONG)((tmap->verts[i].l)>>8));
		x [i] = (tmap->verts[i].x2d)>>16;
		y [i] = (tmap->verts[i].y2d)>>16;
	}
	if (V3D_LockView(MyView)) {
		tri.p1.x = x[0];
		tri.p1.y = y[0];
		tri.p1.z = 0;
		tri.p1.u = us[0];
		tri.p1.v = vs[0];
		tri.p1.color.argbval = l[0];
		for (i=1; i<tmap->nv-1; i++) {
			tri.p2.x = x[i];
			tri.p2.y = y[i];
			tri.p2.z = 0;
			tri.p2.u = us[i];
			tri.p2.v = vs[i];
			tri.p2.color.argbval = l[i];

			tri.p3.x = x[i+1];
			tri.p3.y = y[i+1];
			tri.p3.z = 0;
			tri.p3.u = us[i+1];
			tri.p3.v = vs[i+1];
			tri.p3.color.argbval = l[i+1];

			tri.th = texture;
			V3D_DrawTriangle3D(MyView, &tri, BLENDMD_MODULATE);
		}
		V3D_UnLockView(MyView);
	}
}

void oldVirgeDrawPolyI(g3ds_tmap *tmap, const APTR texture)
{
	int ll;
	int i;
	iVertex v1,v2,v3;
	fix x[10],y[10];//,iz[10];
	fix u[10],v[10];
	fix l[10];
	int fl1 = 0;
	int fl2 = 0;

	// --- Prepare values
	for (i=0; i<tmap->nv; i++) {
		x[i] =       tmap->verts[i].x2d;
		y[i] =       tmap->verts[i].y2d;
		u[i] =       (tmap->verts[i].u<<2) + i2f(256L);
		v[i] =       (tmap->verts[i].v<<2) + i2f(256L);

		// --- Get and correct lighting level.
		ll = tmap->verts[i].l>>8;
		if (ll)         ll--;       // correct level
		if (ll>0xff)    ll=0xff;    // and cut off
		l[i] =          ll<<16;
	}

	for (i=0; i<tmap->nv; i++) {
		if (u[i]<0) fl1=1;
		if (v[i]<0) fl2=1;
	}

	if (fl1) {
		for (i=0; i<tmap->nv; i++) {
			u[i] += i2f(256);
		}
	}

	if (fl2) {
		for (i=0; i<tmap->nv; i++) {
			v[i] += i2f(256);
		}
	}

	// --- Draw a triangle fan
	//     Common Vertex 0 moved out from inner loop to save time
	//     Move back for perspective correction (p.c. modifies
	//     structure values).
	v1.x = x[0]; v1.y = y[0]; //v1.iz = iz[0];
	v1.u = u[0]; v1.v = v[0];
	v1.r = l[0]; v1.g = l[0]; v1.b = l[0];
	if (V3D_LockView(MyView)) {
		for (i=1; i<tmap->nv-1; i++) {

			// Draw a triangle 0 - i - i+1
			v2.x = x[i]; v2.y = y[i]; //v2.iz = iz[i];
			v2.u = u[i]; v2.v = v[i];
			v2.r = l[i]; v2.g = l[i]; v2.b = l[i];

			v3.x = x[i+1]; v3.y = y[i+1]; //v3.iz = iz[i+1];
			v3.u = u[i+1]; v3.v = v[i+1];
			v3.r = l[i+1]; v3.g = l[i+1]; v3.b = l[i+1];
			VirgeTriangleI(texture, &v1, &v2, &v3);
		}
		V3D_UnLockView(MyView);
	}
}

#define o(x)\
	printf("%s=%f\n", #x, x/65536.f)
#define o1(x)\
	printf("%s=0x%x\n", #x, x)

void VirgeTriangleI(const APTR texture, iVertex *p1, iVertex *p2, iVertex *p3)
{
	sdword y1, y2, y3, dy2, dy3;
	iVertex *pe1top, *pe1bot, *pe2top, *pe2bot, *pTmp;
	fix drdx, dgdx, dbdx, dudx, dvdx, den, dadx = 0;
	fix e1idy, e2idy, e3idy, e1dxdy, e2dxdy, e3dxdy;
	fix e1drdy, e1dgdy, e1dbdy, e1dudy, e1dvdy, e1dady = 0;
	fix r0, g0, b0, u0, v0;
	fix e1frac, e2frac, e3frac;
	fix tmp1, tmp2;
	dword left_to_right, e2scans, e3scans;
	static V3DTriangle vtri;

		// ViRGE registers to write
	dword dGdX_dBdX, dAdX_dRdX, dGdY_dBdY, dAdY_dRdY, GS_BS, AS_RS; // S8.7
	dword dXdY12, Xend12, dXdY01, Xend01, dXdY02, XS;               // S11.20
	dword YS, LR_Y01_Y12;               // LR (bit 31) == render left to right

	dword US, VS, dUdX, dVdX, dUdY, dVdY;


	left_to_right = 0;

		// Find bottom-most pixel
	y1 = (p1->y)&0xffff0000;
	y2 = (p2->y)&0xffff0000;
	y3 = (p3->y)&0xffff0000;

	if (y1 == y2 && y2 == y3)
		return;

		// Calc global d?/dx
	den = fixmul((p2->x - p1->x), (p3->y - p1->y)) - fixmul((p3->x - p1->x), (p2->y - p1->y));
	den = fixdiv(F1_0, den);
	tmp1 = p3->y - p1->y;
	tmp2 = p2->y - p1->y;
	drdx = fixmul((fixmul((p2->r - p1->r) , tmp1) - fixmul((p3->r - p1->r) , tmp2)),den);
	dgdx = fixmul((fixmul((p2->g - p1->g) , tmp1) - fixmul((p3->g - p1->g) , tmp2)),den);
	dbdx = fixmul((fixmul((p2->b - p1->b) , tmp1) - fixmul((p3->b - p1->b) , tmp2)),den);
	dudx = fixmul((fixmul((p2->u - p1->u) , tmp1) - fixmul((p3->u - p1->u) , tmp2)),den);
	dvdx = fixmul((fixmul((p2->v - p1->v) , tmp1) - fixmul((p3->v - p1->v) , tmp2)),den);

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
		e2scans = dy3>>16;
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
		e2scans = dy2>>16;
		e3scans = 0;
	} else {
		if (dy2 > dy3)
		{
			pe1bot = p1;
			pe1top = p2;
			pe2bot = p1;
			pe2top = p3;
			e2scans = dy3>>16;
			e3scans = (dy2 - dy3)>>16;
		} else if (dy3 > dy2) {
			pe1bot = p1;
			pe1top = p3;
			pe2bot = p1;
			pe2top = p2;
			e2scans = dy2>>16;
			e3scans = (dy3 - dy2)>>16;
		} else {
			pe1bot = p1;
			pe1top = p2;
			pe2bot = p1;
			pe2top = p3;
			e2scans = dy2>>16;
			e3scans = 0;
			if (pe1top->x < pe2top->x)
				left_to_right = (1 << 31);
		}
	}

		// Geometry calcs
	e1idy = fixdiv(F1_0,(pe1bot->y - pe1top->y));
	e2idy = fixdiv(F1_0,(pe2bot->y - pe2top->y));
	e1dxdy = fixmul((pe1top->x - pe1bot->x),e1idy);
	e1drdy = fixmul((pe1top->r - pe1bot->r),e1idy);
	e1dgdy = fixmul((pe1top->g - pe1bot->g),e1idy);
	e1dbdy = fixmul((pe1top->b - pe1bot->b),e1idy);
	e1dudy = fixmul((pe1top->u - pe1bot->u),e1idy);
	e1dvdy = fixmul((pe1top->v - pe1bot->v),e1idy);
	e2dxdy = fixmul((pe2top->x - pe2bot->x),e2idy);
	e1frac = pe1bot->y - ((pe1bot->y)&0xffff0000);
	e2frac = pe2bot->y - ((pe2bot->y)&0xffff0000);

	r0 = pe1bot->r + fixmul(e1drdy,e1frac);
	g0 = pe1bot->g + fixmul(e1dgdy,e1frac);
	b0 = pe1bot->b + fixmul(e1dbdy,e1frac);
	u0 = pe1bot->u + fixmul(e1dudy,e1frac);
	v0 = pe1bot->v + fixmul(e1dvdy,e1frac);

	if (e3scans)
	{
		if (e2dxdy > e1dxdy)
		{
			left_to_right = (1 << 31);
		}
		e3idy = fixdiv(F1_0,(pe2top->y - pe1top->y));
		e3dxdy = fixmul((pe1top->x - pe2top->x),e3idy);
		e3frac = pe2top->y - ((pe2top->y)&0xFFFF0000);
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
	XS          = (dword) ((pe1bot->x + fixmul(e1frac,e1dxdy))<<4);
	Xend01      = (dword) ((pe2bot->x + fixmul(e2frac,e2dxdy))<<4);

	dXdY01      = (dword) (e2dxdy<<4);
	dXdY02      = (dword) (e1dxdy<<4);

	if (e3scans)
	{
		dXdY12  = e3dxdy<<4;
		Xend12  = (dword) ((pe2top->x + fixmul(e3frac,e3dxdy))<<4);
	}

	YS          = y1>>16;
	LR_Y01_Y12  = left_to_right | (e2scans << 16) | e3scans;

	dGdX_dBdX = (dword)(dgdx     << 7)
			  | ((dword)(dbdx    >> 9) & 0xFFFF);
	dAdX_dRdX = (dword)(dadx     << 7)
			  | ((dword)(drdx    >> 9) & 0xFFFF);
	dGdY_dBdY = (dword)(e1dgdy   << 7)
			  | ((dword)(e1dbdy  >> 9) & 0xFFFF);
	dAdY_dRdY = (dword)(e1dady   << 7)
			  | ((dword)(e1drdy  >> 9) & 0xFFFF);

	GS_BS = (sdword)(g0 << 7)
		  | (sdword)(b0 >> 9);
	AS_RS = (sdword)(0  << 7)
		  | (sdword)(r0 >> 9);

	US = (sdword)(u0 << 3);
	VS = (sdword)(v0 << 3);
	dUdX = (sdword)(dudx << 3);
	dVdX = (sdword)(dvdx << 3);
	dUdY = (sdword)(e1dudy << 3);
	dVdY = (sdword)(e1dvdy << 3);


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
