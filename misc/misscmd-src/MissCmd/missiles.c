#include "main.h"
#include <math.h>

#define DTYPES 8
#define DMASK 0x7

#define RELOAD_TIME (FREQ*2)

static int32 xlut[DTYPES] = { 76, 115, 156, 199, 245, 294, 349, 480 };
static int32 dxlut[DTYPES], dylut[DTYPES];
static int32 altdxlut[DTYPES], altdylut[DTYPES];

void genspeedlut (int32 sp, int32 *dx, int32 *dy) {
	/* 9°, 13.5°, 18°, 22.5°, 27°, 31.5°, 36°, 45° */
	static const int32 sinlut[DTYPES] = { 10252, 15299, 20252, 25080, 29753, 34242, 38521, 46341 };
	static const int32 coslut[DTYPES] = { 64729, 63725, 62328, 60547, 58393, 55879, 53020, 46341 };
	int i;
	for (i = 0; i < DTYPES; i++) {
		dx[i] = sp*sinlut[i];
		dy[i] = sp*coslut[i];
	}
}

void NextWave () {
	global->mlaunched = 0;
	if (global->wave++ == 0) {
		#if 0
		global->mtotal = 4;
		global->accuracy = 20;
		global->speed = 4;
		global->delay = FREQ*2;
		#else
		global->mtotal = 16;
		global->accuracy = 20;
		global->speed = 3;
		#endif
		genspeedlut(global->speed, dxlut, dylut);
		genspeedlut(32, altdxlut, altdylut);
	} else {
		#if 0
		if (global->speed < 16 && (global->wave & 1) == 0) {
			global->speed++;
			genspeedlut(global->speed, dxlut, dylut);
		}
		if (global->delay > (FREQ >> 1) || (global->wave & 3) == 0) global->delay -= (FREQ >> 4);
		if (global->mtotal < 8 || (global->wave & 1) == 0) global->mtotal++;
		if (global->accuracy > 10 || (global->accuracy > 1 && (global->wave & 1) == 1)) global->accuracy--;
		#else
		global->mtotal += (global->mtotal >> 4);
		if (global->accuracy > 10 || (global->accuracy > 1 && (global->wave & 3) == 1)) global->accuracy--;
		if (global->speed < 5 || (global->wave & 3) == 0) {
			global->speed++;
			genspeedlut(global->speed, dxlut, dylut);
			genspeedlut((global->speed > 32) ? global->speed : 32, altdxlut, altdylut);
		}
		#endif
	}
	#if 1
	global->delay = (FREQ*30)/(global->mtotal+1);
	#endif
}

int LaunchMissile () {
	Missile *m;
	uint16 rnd[1];
	int d;
	int32 acc = global->accuracy, x;

	if (!global->build_left) return FALSE;
	x = RandomTarget();
	if (x < 0) return FALSE; // no targets to shoot at!

	m = CreateNode(sizeof(Missile));
	if (!m) return FALSE;

	AddTail((struct List *)&global->missiles, (struct Node *)m);

	GenEntropy(global->entropy, rnd, 2);

	#ifdef DMASK
	m->dir = d = (rnd[0] & (DMASK << 12)) >> 12;
	#else
	m->dir = d = (rnd[0] >> 12) % DTYPES;
	#endif
	if (x < xlut[0]) {
		m->dx = -dxlut[d];
	} else if ((640 - x) < xlut[0]) {
		m->dx = dxlut[d];
	} else {
		if (x < xlut[d])
			m->dx = -dxlut[d];
		else if ((640 - x) < xlut[d])
			m->dx = dxlut[d];
		else if (rnd[0] & 0x4000)
			m->dx = -dxlut[d];
		else
			m->dx = dxlut[d];
	}
	m->dy = dylut[d];
	if (m->dx < 0)
		x += xlut[d];
	else
		x -= xlut[d];
	x = x - acc + (rnd[0] % (acc << 1));
	if (x < 0) x = 0;
	else if (x > 639) x = 639;
	m->x1.p.i = m->x2.p.i = x;

	return TRUE;
}

void RenderMissile (NODE *node, int dontmove) {
	Missile *m = (Missile *)node;
	display *disp = global->disp;
	switch (m->status) {
		default:
			{
				NODE *b;
				int32 ox, oy, nx, ny;

				if (!dontmove) {
					ox = m->x2.p.i;
					oy = m->y2.p.i;
					m->x2.f += m->dx;
					m->y2.f += m->dy;
					nx = m->x2.p.i;
					ny = m->y2.p.i;
					if (ny >= global->skyline) {
						if (b = IsHit(ox, oy, nx, ny)) {
							Explode(b);
							m->status=1;
							//m->dx <<=2; m->dy <<=2;
							if (m->dx < 0)
								m->dx = -altdxlut[m->dir];
							else
								m->dx = altdxlut[m->dir];
							m->dy = altdylut[m->dir];
							break;
						}
					}
				} else {
					nx = m->x2.p.i;
					ny = m->y2.p.i;
				}
				if (ny > 479 || nx < 0 || nx > 639) {
					m->status=1;
					//m->dx <<=2; m->dy <<=2;
					if (m->dx < 0)
						m->dx = -altdxlut[m->dir];
					else
						m->dx = altdxlut[m->dir];
					m->dy = altdylut[m->dir];
					break;
				}
			}
			break;
		case 1:
			if (!dontmove) {
				m->x1.f += m->dx;
				m->y1.f += m->dy;
				if (m->y1.f >= m->y2.f) {
					Remove((struct Node *)m);
					DeleteNode(m);
					return;
				}
			}
			break;
	}
	DrawMode(disp, DRM_NORMAL, 0x11, 0x7F, 0x11, 0x00);
	DrawLine(disp, m->x1.p.i, m->y1.p.i, m->x2.p.i, m->y2.p.i);
	AddClearLine(&global->dmglist, m->x1.p.i, m->y1.p.i, m->x2.p.i, m->y2.p.i);
}

int LaunchAntiMissile (int32 x, int32 y) {
	Cannon *c = NULL;
	int r_sqr;
	{
		Cannon *c1, *c2;
		int dx, dy, n_r_sqr;
		for (c1 = (Cannon *)global->city.mlh_TailPred; (c2 = (Cannon *)c1->node.node.mln_Pred)
			&& c1->node.special == 1; c1 = c2)
		{
			if (!c1->reload) {
				dx = x - c1->node.exp.x;
				dy = y - c1->node.exp.y;
				n_r_sqr = dx*dx+dy*dy;
				if (!c || n_r_sqr < r_sqr) {
					c = c1;
					r_sqr = n_r_sqr;
				}
			}
		}
	}
	if (c) {
		AntiMissile *m;
		int dx, dy;
		float sc;

		c->reload = RELOAD_TIME;

		m = CreateNode(sizeof(AntiMissile));
		if (!m) return FALSE;	

		AddTail((struct List *)&global->antimissiles, (struct Node *)m);

		m->x1.p.i = c->node.exp.x;
		m->y1.p.i = c->node.exp.y;
		m->x2.p.i = x;
		m->y2.p.i = y;
		dx = m->x2.p.i - m->x1.p.i;
		dy = m->y2.p.i - m->y1.p.i;
		sc = (65536.0*25.0)/sqrt(r_sqr);
		m->dx = (int)(dx*sc);
		m->dy = (int)(dy*sc);

		m->r = m->dr = 2;
	}

	return TRUE;
}

void RenderAntiMissile (NODE *node, int dontmove) {
	AntiMissile *m = (AntiMissile *)node;
	display *disp = global->disp;
	if (m->status == 0) {
		int ox, oy;
		ox = m->x1.p.i; oy = m->y1.p.i;
		m->x1.f += m->dx;
		m->y1.f += m->dy;
		if ( ((m->dx <= 0 && m->x1.f <= m->x2.f) || (m->dx > 0 && m->x1.f >= m->x2.f)) &&
			((m->dy <= 0 && m->y1.f <= m->y2.f) || (m->dy > 0 && m->y1.f >= m->y2.f)) )
		{
			m->x1.f = m->x2.f;
			m->y1.f = m->y2.f;
			m->status = 1;
		}
		DrawMode(disp, DRM_NORMAL, 0xFF, 0xFF, 0xFF, 0x00);
		DrawLine(disp, m->x1.p.i, m->y1.p.i, ox, oy);
		AddClearLine(&global->dmglist, m->x1.p.i, m->y1.p.i, ox, oy);
	} else {
		if (m->dr > 0) {
			if (m->r >= 30) m->dr = -m->dr;
		} else if (m->r <= 0) {
			Remove((struct Node *)m);
			DeleteNode(m);
			return;
		}
		DrawMode(disp, DRM_NORMAL, 0x88, 0x22, 0x88, 0x00);
		DrawCircle(disp, m->x1.p.i, m->y1.p.i, m->r);
		AddClearCircle(&global->dmglist, m->x1.p.i, m->y1.p.i, m->r);
		{
			Missile *t, *t2;
			int32 r_sqr, dx, dy;
			r_sqr = m->r * m->r;
			for (t = (Missile *)global->missiles.mlh_Head; t2 = (Missile *)t->node.mln_Succ; t = t2)
			{
				if (t->status != 0) continue;
				dx = t->x2.p.i - m->x1.p.i;
				dy = t->y2.p.i - m->y1.p.i;
				if ((dx*dx)+(dy*dy) < r_sqr) {
					t->status = 1;
					//t->dx <<=2; t->dy <<=2;
					if (t->dx < 0)
						t->dx = -altdxlut[t->dir];
					else
						t->dx = altdxlut[t->dir];
					t->dy = altdylut[t->dir];
					//if (m->dr < 0) m->dr = -m->dr;
				}
			}
		}
		if (!dontmove) m->r += m->dr;
	}
}

void FreeMissiles() {
	NODE *m;
	while (m = (NODE *)RemHead((struct List *)&global->missiles)) DeleteNode(m);
	while (m = (NODE *)RemHead((struct List *)&global->antimissiles)) DeleteNode(m);
}
