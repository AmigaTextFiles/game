#include "robot.h"
#include "SDL_ttf.h"

static TTF_Font *font = NULL;
static TTF_Font *smallfont = NULL;

static void shutdownfonts(void);

void setupfonts(void)
{
	if (TTF_Init() < 0)
		error("Font error: %s", TTF_GetError());

	font = TTF_OpenFont(SHAREPATH "font.ttf", 48);
	if (font == NULL)
		error("Font error: %s", TTF_GetError());

	smallfont = TTF_OpenFont(SHAREPATH "font.ttf", 16);
	if (smallfont == NULL)
		error("Font error: %s", TTF_GetError());

	atexit(shutdownfonts);
}

static void shutdownfonts(void)
{
	TTF_CloseFont(font);
	font = NULL;

	TTF_CloseFont(smallfont);
	smallfont = NULL;

	TTF_Quit();
}

static SDL_Color getfontcolor(int r, int g, int b)
{
	SDL_Color col;
	col.r = r;
	col.g = g;
	col.b = b;
	return col;
}

static void displaytext(const char *text, SDL_Color textcolor)
{
	SDL_Surface *textsurface;
	SDL_Rect dest;
	int textwidth, textheight;

	if (TTF_SizeText(font, text, &textwidth, &textheight) < 0)
		error("Font error: %s", TTF_GetError());

	if (textwidth >= 640 || textheight >= 480)
		error("Font is too big (%dx%d)", textwidth, textheight);

	dest.x = 320 - textwidth/2;
	dest.y = 240 - textheight/2;
	dest.w = textwidth;
	dest.h = textheight;

	textsurface = TTF_RenderText_Blended(font, text, textcolor);

	if (!textsurface)
		error("Font error: %s", TTF_GetError());

	SDL_BlitSurface(textsurface, NULL, getscreen(), &dest);
	SDL_FreeSurface(textsurface);
	SDL_UpdateRect(getscreen(), 0, 0, 0, 0);
}

void showpausedtext(void)
{
	displaytext("PAUSED", getfontcolor(0, 168, 224)); /* sad cyan */
}

int showmenu(const int score)
{
	SDL_Color textcolor;
	SDL_Event event;

	textcolor = getfontcolor(0, 168, 224); /* sad cyan */

	if (score == -1)
	{
		clearscreen();
		reblitscreen();
		displaytext("ROBOT ESCAPE", textcolor);
	}
	else if (score == 0)
		displaytext("YOU FAIL IT!", textcolor);
	else
		displaytext("KICKTUSH!", textcolor);

	while (1)
	{
		if (SDL_PollEvent(&event))
		{
			if (event.type == SDL_QUIT)
				return 0;
			if (event.type != SDL_KEYDOWN)
				continue;
			if (score == -1 && event.key.keysym.sym == SDLK_ESCAPE)
				return 0;
			if (event.key.keysym.sym != SDLK_SPACE
				&& event.key.keysym.sym != SDLK_RETURN
				&& event.key.keysym.sym != SDLK_ESCAPE)
			{
				continue;
			}
			break;
		}
		else
			SDL_Delay(10);
	}

	return 1;
}

#define PANEL_WIDTH ((640 - WIDTH*TILE_SIZE)/2)

static void panel_displaystring(const char *text, int right)
{
	SDL_Surface *textsurface;
	SDL_Rect dest;
	int textwidth, textheight;

	if (TTF_SizeText(smallfont, text, &textwidth, &textheight) < 0)
		error("Font error: %s", TTF_GetError());

	if (textwidth >= PANEL_WIDTH || textheight >= 480)
		error("Text %s is too big (%dx%d)",
			text, textwidth, textheight);

	if (!right)
		dest.x = 0;
	else
		dest.x = 640 - PANEL_WIDTH;

	clearregion(dest.x, 24, PANEL_WIDTH, textheight);

	dest.x += (PANEL_WIDTH - textwidth)/2;
	dest.y = 24;
	dest.w = textwidth;
	dest.h = textheight;

	textsurface = TTF_RenderText_Blended(smallfont, text,
		getfontcolor(0, 168, 224)); /* sad cyan */

	if (!textsurface)
		error("Font error: %s", TTF_GetError());

	SDL_BlitSurface(textsurface, NULL, getfakescreen(), &dest);
	SDL_FreeSurface(textsurface);
}

#include <stdarg.h>

void panel_displaytext(int right, const char *text, ...)
{
	va_list argptr;
	char *str;

	va_start(argptr, text);
	if (vasprintf(&str, text, argptr) == -1)
		error("Text too long to print out: %s\n", text);

	panel_displaystring(str, right);
	free(str);

	va_end(argptr);
}
