/* g_video.h */

#ifndef _G_VIDEO_H
#define _G_VIDEO_H

#include <graphics/gfx.h>
#include <graphics/view.h>
#include <graphics/gfxmacros.h>
#include <graphics/copper.h>

#include "g_ilbm.h"

struct palette_struct
{
	int d;
	struct ColorMap *cm;
	colour_4 c[32];
};

void make_copperlist(struct UCopList *, int, int);
void free_bitmap(struct BitMap*);
int init_display(int, int, int); /* w, h, depth */
void video_exit(void);
void set_to_offscreen(void);
void set_to_onscreen(void);
void set_to_playscreen(void);
void swap_buffers(void);

#endif
