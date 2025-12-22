#include "main.h"
#include <math.h>

typedef struct {
	int8 probability;
	int8 max, amount;
	int16 points;
} BuildingInfo;

#if 0
#define BTYPES 6
#define CANNONS 4

static const char * gfx_files[BTYPES+1] = {
	"gfx/cannon",
	"gfx/b01",
	"gfx/b02",
	"gfx/b03",
	"gfx/b04",
	"gfx/b05",
	NULL
};

static BuildingInfo gfx_infos[BTYPES] = {
	{ 0,	0,	0,	0	},
	{ 30,	4,	0,	100 },
	{ 20,	-1,	0,	200 },
	{ 20,	-1,	0,	300 },
	{ 30,	2,	0,	200 },
	{ 50,	1,	0,	500 },
};
#else
#define BTYPES 5
#define CANNONS 4

static const char * gfx_files[BTYPES+1] = {
	"gfx/altc",
	"gfx/altc2",
	"gfx/test",
	"gfx/test2",
	"gfx/test3",
	NULL
};

static BuildingInfo gfx_infos[BTYPES] = {
	{ 0,	0,	0,	0	},
	{ 0,	0,	0,	0	},
	{ 60,	-1,	0,	100 },
	{ 50,	6,	0,	100 },
	{ 40,	3,	0,	100 },
};
#endif

int GenerateCity (int32 num) {
	int32 i, t, mprb, fprb;
	Building *b;
	BuildingInfo *info;
	LIST *city = &global->city;
	uint16 rnd[2];

	global->build_left = 0;

	while (b = (Building *)RemHead((struct List *)city)) DeleteNode(b);

	if (num < 0) {
		FreeGfxArray(global->citygfx);
		return FALSE;
	}

	if (!global->citygfx) {
		if (!(global->citygfx = LoadGfxArray(gfx_files))) {
			return FALSE;
		}
	}


	info = gfx_infos;
	mprb = 0;
	for (t = 0; t < BTYPES; t++) {
		mprb += info->probability;
		info->amount = 0;
		info++;
	}

	global->skyline = 480;
	for (i = 0; i < num; i++) {
		b = CreateNode(sizeof(Building));
		if (!b) return FALSE;

		AddHead((struct List *)city, (struct Node *)b);
		global->build_left++;

		GenEntropy(global->entropy, rnd, 4);

		fprb = rnd[0] % mprb;
		info = gfx_infos;
		for (t = 0; t < BTYPES; t++) {
			if (info->max < 0 || info->amount < info->max) {
				if ((fprb -= info->probability) < 0)
					break;
			}
			info++;
		}
		if (t == BTYPES) info = gfx_infos;
		info->amount++;
		if (info->amount == info->max) mprb -= info->probability;

		b->gfx = global->citygfx[t];
		b->points = info->points;
		b->x = rnd[1] % (640 - b->gfx->width);
		b->y = 480 - b->gfx->height;

		b->exp.x = b->x + (b->gfx->width >> 1);
		b->exp.y = 479;
		//b->exp.max_r = 3*(int32)sqrt((b->gfx->width*b->gfx->height) / 3.1416);
		b->exp.max_r = sqrt((b->gfx->width*b->gfx->width)+(b->gfx->height*b->gfx->height));
		b->exp.dr = (b->exp.max_r+9)/10;

		if (b->y < global->skyline) global->skyline = b->y;
	}

	for (i = 0; i < CANNONS; i++) {
		b = CreateNode(sizeof(Cannon));
		if (!b) return FALSE;

		AddTail((struct List *)city, (struct Node *)b);

		GenEntropy(global->entropy, rnd, 2);

		b->gfx = global->citygfx[0];
		b->special = 1;
		b->x = rnd[0] % (640 - b->gfx->width);
		b->y = 480 - b->gfx->height;

		b->exp.x = b->x + (b->gfx->width >> 1);
		b->exp.y = 479;
		//b->exp.max_r = 3*(int32)sqrt((b->gfx->width*b->gfx->height) / 3.1416);
		b->exp.max_r = sqrt((b->gfx->width*b->gfx->width)+(b->gfx->height*b->gfx->height));
		b->exp.dr = (b->exp.max_r+9)/10;
	}

	return TRUE;
}

void RenderBuilding (NODE *node, int dontmove) {
	Building *b = (Building *)node;
	display *disp = global->disp;
	int32 r;
	switch (b->status) {
		default:
			if (b->special == 1) {
				#if 0
				int mx, my;
				int dx, dy, sc;
				mx = disp->win->MouseX;
				my = disp->win->MouseY;
				if (mx > 639) mx = 639; else if (mx < 0) mx = 0;
				if (my > global->skyline) my = global->skyline;
				else if (my < 0) my = 0;
				dx = mx - b->exp.x;
				dy = my - b->exp.y;
				sc = (int)sqrt(dx*dx+dy*dy)/10;
				dx /= sc;
				dy /= sc;
				DrawMode(disp, DRM_NORMAL, 0x8F, 0x8F, 0xBF, 0x00);
				DrawLine(disp, b->exp.x, b->exp.y, b->exp.x+dx, b->exp.y+dy);
				#endif
				if (((Cannon *)b)->reload) {
					((Cannon *)b)->reload--;
					b->gfx = global->citygfx[1];
				} else
					b->gfx = global->citygfx[0];
			}
			BlitGfx(disp, b->gfx, b->x, b->y);
			//AddClearGfx(&global->dmglist, b->x, b->y, b->gfx);
			break;
		case 1:
			if (!dontmove) {
				b->exp.r += b->exp.dr;
				b->y++;
			}
			if (b->exp.dr > 0) {
				BlitGfx(disp, b->gfx, b->x, b->y);
				//AddClearGfx(&global->dmglist, b->x, b->y, b->gfx);
				if (b->exp.r >= b->exp.max_r)
					b->exp.dr = -b->exp.dr;
			}
			else if (b->exp.r <= 0) {
				if (b->special != 1) global->build_left--;
				Remove((struct Node *)b);
				DeleteNode(b);
				return;
			}
			r = b->exp.r;
			DrawMode(disp, DRM_BLEND, 0x9F, 0x33, 0x33, 0x88);
			DrawCircle(disp, b->exp.x, b->exp.y, r);
			//AddClearCircle(&global->dmglist, b->exp.x, b->exp.y, r);
			if (r -= 6) {
				DrawMode(disp, DRM_BLEND, 0x9F, 0x7F, 0x33, 0x33);
				DrawCircle(disp, b->exp.x, b->exp.y, r);
				if (r -= 6) {
					DrawMode(disp, DRM_BLEND, 0x9F, 0x7F, 0x33, 0x55);
					DrawCircle(disp, b->exp.x, b->exp.y, r);
					if (r -= 6) {
						DrawMode(disp, DRM_NORMAL, 0x9F, 0x7F, 0x33, 0x00);
						DrawCircle(disp, b->exp.x, b->exp.y, r);
					}
				}
			}
			break;
	}
}

int32 RandomTarget () {
	LIST *city = &global->city;
	Building *b, *b2;
	int16 n, rnd, i;
	if (!GetHead((struct List *)city)) return -1;
	for (n = 0, b = (Building *)city->mlh_TailPred; b2 = (Building *)b->node.mln_Pred; b = b2) n++;
	GenEntropy(global->entropy, &rnd, 2);
	n = rnd % n;
	for (i = 0, b = (Building *)city->mlh_TailPred; i < n; i++) b = (Building *)b->node.mln_Pred;
	return b->x + (b->gfx->width >> 1);
}

NODE *IsHit (int32 x1, int32 y1, int32 x2, int32 y2) {
	LIST *city = &global->city;
	Building *b, *b2;
	for (b = (Building *)city->mlh_TailPred; b2 = (Building *)b->node.mln_Pred; b = b2) {
		if (b->status == 0 && LineGfxColl(x1, y1, x2, y2, b->x, b->y, b->gfx)) {
			return (NODE *)b;
		}
	}
	return NULL;
}

void Explode (NODE *node) {
	Building *b;
	b = (Building *)node;
	b->status=1;
	global->score -= b->points;
	PlaySnd(global->sounds[0], 0x04000, 0x08000);
}

int32 CalcScore (LIST *city) {
	int32 score = 0;
	Building *b, *b2;
	for (b = (Building *)city->mlh_TailPred; b2 = (Building *)b->node.mln_Pred; b = b2)
		if (b->status == 0) score += b->points;
	return score;
}
