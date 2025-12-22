#include "robot.h"
#include "SDL_image.h"

static SDL_Surface *screen;
static SDL_Surface *fakescreen;
#ifdef BACKGROUND
static SDL_Surface *background;
#endif
static SDL_Surface *images[T_COUNT];
static Uint32 transcolor;

#define MAXDIRTYRECTS 512
static int numdirtyrects = 0;
static SDL_Rect dirty[MAXDIRTYRECTS];

static SDL_Surface *loadimage(const char *filename, const int transparent)
{
	SDL_Surface *thisimage;
	SDL_Surface *tmp;

	thisimage = IMG_Load(filename);
	if (thisimage == NULL)
		error("Error loading image %s: %s", filename, IMG_GetError());

	if (transparent)
	{
		if (SDL_SetColorKey(thisimage, SDL_SRCCOLORKEY,
			SDL_MapRGB(thisimage->format, 252, 252, 252)) < 0)
		{
			error("Could not make an image transparent: %s",
				SDL_GetError());
		}
	}

	tmp = SDL_DisplayFormat(thisimage);

	if (tmp == NULL)
	{
		error("Could not convert image %s: %s", filename,
			SDL_GetError());
	}

	SDL_FreeSurface(thisimage);
	thisimage = tmp;

	return thisimage;
}

void setupvideo(void)
{
	if (SDL_Init(SDL_INIT_VIDEO) < 0)
		error("SDL error: %s", SDL_GetError());

	atexit(SDL_Quit);

	screen = SDL_SetVideoMode(640, 480, 0, SDL_ANYFORMAT|SDL_FULLSCREEN);
	if (screen == NULL)
		error("SDL error: %s", SDL_GetError());

	SDL_ShowCursor(SDL_DISABLE);

	fakescreen = SDL_CreateRGBSurface(0, 640, 480,
		screen->format->BitsPerPixel,
		screen->format->Rmask,
		screen->format->Gmask,
		screen->format->Bmask,
		screen->format->Amask);

	if (fakescreen == NULL)
		error("SDL error: %s", SDL_GetError());

	SDL_WM_SetCaption("Robot Escape", NULL);

	transcolor = SDL_MapRGB(screen->format, 252, 252, 252);

	images[T_FLOOR   ] = loadimage(SHAREPATH "floor.png",    0);
	images[T_WALL    ] = loadimage(SHAREPATH "wall.png",     0);
	images[T_ROBOT   ] = loadimage(SHAREPATH "robot.png",    1);
	images[T_BALL    ] = loadimage(SHAREPATH "ball.png",     1);
	images[T_DISCUS_H] = loadimage(SHAREPATH "discus-h.png", 1);
	images[T_DISCUS_V] = loadimage(SHAREPATH "discus-v.png", 1);

#ifdef BACKGROUND
	background         = loadimage(SHAREPATH "bg.png",       0);
#endif
}

Uint32 getcolor(int r, int g, int b)
{
	return SDL_MapRGB(screen->format, r, g, b);
}

void clearscreen(void)
{
#ifndef BACKGROUND
	SDL_FillRect(fakescreen, NULL, SDL_MapRGB(screen->format, 0, 255, 192));
#else
	SDL_BlitSurface(background, NULL, fakescreen, NULL);
#endif

	numdirtyrects = 1;
	dirty[0].x = 0;
	dirty[0].y = 0;
	dirty[0].w = 640;
	dirty[0].h = 480;
}

static void addrect(SDL_Rect *rect)
{
	int newrect = numdirtyrects;
	dirty[newrect].x = rect->x;
	dirty[newrect].y = rect->y;
	dirty[newrect].w = rect->w;
	dirty[newrect].h = rect->h;
	numdirtyrects++;
}

void clearregion(int x, int y, int w, int h)
{
	SDL_Rect rect;
	rect.x = x;
	rect.y = y;
	rect.w = w;
	rect.h = h;
#ifndef BACKGROUND
	SDL_FillRect(fakescreen, &rect, SDL_MapRGB(screen->format,
		0, 255, 192));
#else
	SDL_BlitSurface(background, &rect, fakescreen, &rect);
#endif

	addrect(&rect);
}

void puttile(int realx, int realy, int tileindex)
{
	SDL_Rect tile;
	int centeredx, centeredy;

	centeredx = realx + (640 - WIDTH *TILE_SIZE)/2;
	centeredy = realy + (480 - HEIGHT*TILE_SIZE)/2;

	tile.x = centeredx;
	tile.y = centeredy;
	tile.w = TILE_SIZE;
	tile.h = TILE_SIZE;

	SDL_BlitSurface(images[tileindex], NULL, fakescreen, &tile);

	addrect(&tile);
}

void reblitscreen(void)
{
	int i;

	for (i = 0; i < numdirtyrects; i++)
		SDL_BlitSurface(fakescreen, &dirty[i], screen, &dirty[i]);
}

void updatescreen(void)
{
	reblitscreen();
	SDL_UpdateRects(screen, numdirtyrects, dirty);

	numdirtyrects = 0;
}

void restorescreen(void)
{
	numdirtyrects = 1;
	dirty[0].x = 0;
	dirty[0].y = 0;
	dirty[0].w = 640;
	dirty[0].h = 480;
	updatescreen();
}

SDL_Surface *getscreen(void)
{
	return screen;
}

SDL_Surface *getfakescreen(void)
{
	return fakescreen;
}

void screen_save(void)
{
	char filename[] = "xxxxxxxx.bmp";
	int i;

	for (i = 0; i < 8; i++)
		filename[i] = rnd(26) + 'a';

	SDL_SaveBMP(screen, filename);
}

#define TEXTHEIGHT 24
#define PANELVCENTER (24 + (TEXTHEIGHT/2))
#define PANEL_WIDTH ((640 - WIDTH*TILE_SIZE)/2)
#define LIVES_PER_LINE 3

void panel_displaylives(int lives)
{
	SDL_Rect destblk;
	int i;
	int startx;

	destblk.x = 640 - PANEL_WIDTH;
	destblk.x += (PANEL_WIDTH - TILE_SIZE*LIVES_PER_LINE)/2;
	destblk.y = PANELVCENTER + TEXTHEIGHT - TILE_SIZE/2;
	destblk.w = TILE_SIZE*LIVES_PER_LINE;

	startx = destblk.x;

	for (i = 0; i < lives; i++, destblk.x += TILE_SIZE)
	{
		SDL_BlitSurface(images[T_FLOOR], NULL, fakescreen, &destblk);
		SDL_BlitSurface(images[T_BALL],  NULL, fakescreen, &destblk);
		if ((i+1) % LIVES_PER_LINE == 0)
		{
			destblk.y += TILE_SIZE;
			destblk.x = startx - TILE_SIZE;
		}
	}

	for (; i < STARTLIVES; i++, destblk.x += TILE_SIZE)
	{
		SDL_BlitSurface(images[T_FLOOR], NULL, fakescreen, &destblk);
		SDL_BlitSurface(images[T_ROBOT], NULL, fakescreen, &destblk);
		if ((i+1) % LIVES_PER_LINE == 0)
		{
			destblk.y += TILE_SIZE;
			destblk.x = startx - TILE_SIZE;
		}
	}
}
