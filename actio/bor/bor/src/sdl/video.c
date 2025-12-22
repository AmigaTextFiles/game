#include "types.h"
#include "video.h"
#include "vga.h"

#include <SDL.h>

//s_vram current_videomode;
static SDL_Surface *screen;
static int fullscreen = 1;
static SDL_Color colors[256];

static int inited;

void system_init(void)
{
	printf("SDL init\n");
	if (!inited) {
		inited = 1;
		SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO|SDL_INIT_JOYSTICK);
		SDL_WM_SetCaption("Beats of Rage",NULL);
		atexit(SDL_Quit);
	}
}

// Frees all VESA shit when returning to textmode
int video_set_mode(int width, int height)
{
	if (width==0 && height==0) return 0;

	screen = SDL_SetVideoMode(width,height,8,fullscreen?(SDL_HWSURFACE|SDL_HWPALETTE|SDL_DOUBLEBUF|SDL_FULLSCREEN):0);
	if (screen==NULL) return 0;
	SDL_ShowCursor(SDL_DISABLE);

	return 1;
}

void video_fullscreen_flip()
{
#ifdef __MORPHOS__
	/* hihi, this game sucks anyway... no time to lose on debugging this shit */
	return;
#endif
	fullscreen ^= 1;
	screen = SDL_SetVideoMode(screen->w,screen->h,8,fullscreen?(SDL_HWSURFACE|SDL_HWPALETTE|SDL_DOUBLEBUF|SDL_FULLSCREEN):0);
	SDL_SetColors(screen,colors,0,256);
}

int video_copy_screen(s_screen* src)
{
	char *sp;
	char *dp;

	int width, height;
	int y;

	// Determine width and height
	width = screen->w;
	if(width > src->width) width = src->width;
	height = screen->h;
	if(height > src->height) height = src->height;

	if(!width || !height) return 0;

	// Copy to linear video ram
	
    if ( SDL_MUSTLOCK( screen ) )
    	SDL_LockSurface(screen);

	sp = src->data;
	dp = screen->pixels;
	do{
		asm_copy(dp, sp, width);
		sp += src->width;
		dp += screen->pitch;
	}while(--height);
	
    if ( SDL_MUSTLOCK(screen) )
    	SDL_UnlockSurface(screen);
	
    SDL_Flip(screen);

	return 1;
}

void video_clearscreen(void)
{
    if ( SDL_MUSTLOCK(screen) )
		SDL_LockSurface(screen);

	asm_clear(screen->pixels, screen->pitch*screen->h);
	
    if ( SDL_MUSTLOCK(screen) )
    	SDL_UnlockSurface(screen);
}


void vga_vwait(void)
{
	static int prevtick;

	int now = SDL_GetTicks();
	int wait = 1000/60 - (now - prevtick);
	if (wait>0)
    {
		SDL_Delay(wait);
    }
    else SDL_Delay(1);

	prevtick = now;
}


// Set VGA-type palette
void vga_setpalette(char* palette)
{
	int i;
	for(i=0;i<256;i++){
		colors[i].r=palette[0];
		colors[i].g=palette[1];
		colors[i].b=palette[2];
		palette+=3;
	}
	SDL_SetColors(screen,colors,0,256);
}

