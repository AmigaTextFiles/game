#include "types.h"
#include "video.h"
#include "vga.h"

#include "mylib.h"
#include "syscall.h"

//s_vram current_videomode;

static int inited;
static int screen_w,screen_h;
static unsigned short palette[256];

void video_init(void)
{
	if (!inited) {
		inited = 1;
		g_init();
	}
}

// Frees all VESA shit when returning to textmode
int video_set_mode(int width, int height)
{
	if (width==0 && height==0) return 0;

	screen_w = width;
	screen_h = height;
	video_init();

	return 1;
}

int video_copy_screen(s_screen* src)
{
	char *sp;
	unsigned short *dp;

	int width, height;
	int y;

	// Determine width and height
	width = screen_w;
	if(width > src->width) width = src->width;
	height = screen_h;
	if(height > src->height) height = src->height;

	if(!width || !height) return 0;

	// Copy to linear video ram
	sp = src->data;
	dp = g_vramaddr((SCREEN_WIDTH-screen_w)/2,(SCREEN_HEIGHT-screen_h)/2);
	do{
		int x;
		for(x=0;x<width;x++) {
			dp[x] = palette[sp[x]];
		}
		sp += src->width;
		dp += SCREEN_PITCH;
	}while(--height);
//	g_flip();

	return 1;
}

void video_clearscreen(void)
{
	g_clear(0);
}


void vga_vwait(void)
{
	sceDisplayWaitVblankStart();
}


// Set VGA-type palette
void vga_setpalette(char* pal)
{
	int i;
	for(i=0;i<256;i++){
		int r = pal[0];
		int g = pal[1];
		int b = pal[2];
		palette[i] = ((b>>3)<<10) | ((g>>3)<<5) | (r>>3);
		pal+=3;
	}
}

