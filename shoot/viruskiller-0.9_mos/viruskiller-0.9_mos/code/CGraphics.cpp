/*
Copyright (C) 2004 Parallel Realities

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/


#include "headers.h"

Graphics::Graphics()
{
	background = NULL;

	spriteHead = new Sprite;
	spriteTail = spriteHead;

	fontSize = 0;

	screenShotNumber = 0;
	
	for (int i = 0 ; i < 100 ; i++)
		tile[i] = NULL;
}

void Graphics::free()
{
	debug(("graphics.free: Background\n"));
	if (background != NULL)
		SDL_FreeSurface(background);

	background = NULL;

	debug(("graphics.free: sprites\n"));
	Sprite *sprite;

	for (sprite = (Sprite*)spriteHead->next ; sprite != NULL ; sprite = (Sprite*)sprite->next)
		sprite->free();

	spriteHead->next = NULL; spriteTail = spriteHead;
}

void Graphics::destroy()
{
	free();

	for (int i = 0 ; i < 5 ; i++)
		if (font[i])
			TTF_CloseFont(font[i]);

	delete spriteHead;

	for (int i = 0 ; i < 100 ; i++)
		if (tile[i] != NULL)
			SDL_FreeSurface(tile[i]);
}

void Graphics::mapColors()
{
	red = SDL_MapRGB(screen->format, 0xff, 0x00, 0x00);
	yellow = SDL_MapRGB(screen->format, 0xff, 0xff, 0x00);
	lightestGreen = SDL_MapRGB(screen->format, 0x00, 0xff, 0x00);
	lightGreen = SDL_MapRGB(screen->format, 0x00, 0xdd, 0x00);
	green = SDL_MapRGB(screen->format, 0x00, 0xbb, 0x00);
	darkGreen = SDL_MapRGB(screen->format, 0x00, 0x77, 0x00);
	darkestGreen = SDL_MapRGB(screen->format, 0x00, 0x33, 0x00);
	skyBlue = SDL_MapRGB(screen->format, 0x66, 0x66, 0xff);
	blue = SDL_MapRGB(screen->format, 0x00, 0x00, 0xff);
	cyan = SDL_MapRGB(screen->format, 0x00, 0x99, 0xff);
	white = SDL_MapRGB(screen->format, 0xff, 0xff, 0xff);
	lightGrey = SDL_MapRGB(screen->format, 0xcc, 0xcc, 0xcc);
	grey = SDL_MapRGB(screen->format, 0x88, 0x88, 0x88);
	darkGrey = SDL_MapRGB(screen->format, 0x33, 0x33, 0x33);
	black = SDL_MapRGB(screen->format, 0x00, 0x00, 0x00);

	fontForeground.r = fontForeground.g = fontForeground.b = 0xff;
	fontBackground.r = fontBackground.g = fontBackground.b = 0x00;

	fontForeground.unused = fontBackground.unused = 0;
	
	fadeBlack = alphaRect(SCREENWIDTH, SCREENHEIGHT, 0x00, 0x00, 0x00);
	infoBar = alphaRect(SCREENWIDTH, 35, 0x00, 0x00, 0x00);

	for (int i = 0 ; i < 100 ; i++)
		tile[i] = createSurface(80, 60);
}

Sprite *Graphics::getSpriteHead()
{
	return spriteHead;
}

void Graphics::setTransparent(SDL_Surface *sprite)
{
	SDL_SetColorKey(sprite, (SDL_SRCCOLORKEY|SDL_RLEACCEL), SDL_MapRGB(sprite->format, 0, 0, 0));
}

void Graphics::updateScreen()
{
	SDL_Flip(screen);
	animateSprites();
	SDL_Delay((int)engine->getTimeDifference());

	if (engine->keyState[SDLK_F10])
	{
		SDL_WM_ToggleFullScreen(screen);
		engine->fullScreen = !engine->fullScreen;

		engine->keyState[SDLK_F10] = 0;
	}
	
	if (engine->keyState[SDLK_F12])
	{
		sprintf(screenshot, "screenshots/screenshot%.3d.bmp", screenShotNumber);
		SDL_SaveBMP(screen, screenshot);
		screenShotNumber++;

		engine->keyState[SDLK_F12] = 0;
	}
}

void Graphics::delay(int time)
{
	unsigned long then = SDL_GetTicks();

	engine->keyState[SDLK_ESCAPE] = 0;

	while (true)
	{
		updateScreen();
		if (SDL_GetTicks() >= then + time)
			break;

		engine->getInput();
	}
}

void Graphics::clearScreen(int color)
{
	SDL_FillRect(screen, NULL, color);
}

void Graphics::RGBtoHSV(float r, float g, float b, float *h, float *s, float *v)
{
	float mn, mx, delta;
	mn = min(min(r, g), b);
	mx = max(max(r, g), b);
	*v = mx;
	delta = mx - mn;

	if (mx != 0)
	{
		*s = delta / mx;
	}
	else
	{
		*s = 0;
		*h = -1;
		return;
	}

	if (r == mx)
	{
		*h = (g - b) / delta;
	}
	else if (g == mx)
	{
		*h = 2 + (b - r) / delta;
	}
	else
	{
		*h = 4 + (r - g) / delta;
	}

	*h *= 60;

	if (*h < 0)
		*h += 360;
}

void Graphics::HSVtoRGB(float *r, float *g, float *b, float h, float s, float v)
{
	int i;
	float f, p, q, t;
	if (s == 0)
	{
		*r = *g = *b = v;
		return;
	}

	h /= 60;
	i = (int)(h);
	f = h - i;
	p = v * (1 - s);
	q = v * (1 - s * f);
	t = v * (1 - s * (1 - f));

	switch (i)
	{
		case 0:
			*r = v;
			*g = t;
			*b = p;
			break;

		case 1:
			*r = q;
			*g = v;
			*b = p;
			break;

		case 2:
			*r = p;
			*g = v;
			*b = t;
			break;

		case 3:
			*r = p;
			*g = q;
			*b = v;
			break;

		case 4:
			*r = t;
			*g = p;
			*b = v;
			break;

		default:
			*r = v;
			*g = p;
			*b = q;
			break;
	}
}

SDL_Surface *Graphics::loadImage(char *filename)
{
	SDL_Surface *image, *newImage;

	#if USEPAK
		if (!engine->unpack(filename, PAK_IMG))
			showErrorAndExit(ERR_FILE, filename);
		image = IMG_Load_RW(engine->sdlrw, 1);
	#else
		image = IMG_Load(filename);
	#endif

	if (!image)
		showErrorAndExit(ERR_FILE, filename);

	newImage = SDL_DisplayFormat(image);

	if (newImage)
	{
		SDL_FreeSurface(image);
	}
	else
	{
		// This happens when we are loading the window icon image
		newImage = image;
	}

	setTransparent(newImage);

	return newImage;
}

SDL_Surface *Graphics::loadImage(char *filename, int hue, int sat, int value)
{
	SDL_Surface *image, *newImage;

	#if USEPAK
		if (!engine->unpack(filename, PAK_IMG))
			showErrorAndExit(ERR_FILE, filename);
		image = IMG_Load_RW(engine->sdlrw, 1);
	#else
		image = IMG_Load(filename);
	#endif

	if (!image)
		showErrorAndExit(ERR_FILE, filename);

	if ((hue != 0) || (sat != 0) || (value != 0))
	{
		if (image->format->BitsPerPixel != 8)
		{
			debug(("WARNING: Could not set Hue for '%s'! Not an 8 bit image!\n", filename));
		}
		else
		{
			SDL_Color *color;
			float r, g, b, h, s, v;

			if (image->format->palette->colors != NULL)
			{
				for (int i = 1 ; i < image->format->palette->ncolors ; i++)
				{
					color = &image->format->palette->colors[i];

					r = (int)color->r;
					g = (int)color->g;
					b = (int)color->b;

					RGBtoHSV(r, g, b, &h, &s, &v);

					h += hue;
					s += sat;
					v += value;

					HSVtoRGB(&r, &g, &b, h, s, v);

					color->r = (int)r;
					color->g = (int)g;
					color->b = (int)b;

				}
			}
		}
	}

	newImage = SDL_DisplayFormat(image);

	if (newImage)
	{
		SDL_FreeSurface(image);
	}
	else
	{
		// This happens when we are loading the window icon image
		newImage = image;
	}

	setTransparent(newImage);

	return newImage;
}

SDL_Surface *Graphics::quickSprite(char *name, SDL_Surface *image)
{
	Sprite *sprite = addSprite(name);
	sprite->setFrame(0, image, 60);

	return sprite->getCurrentFrame();
}

void Graphics::fade(int amount)
{
	SDL_SetAlpha(fadeBlack, SDL_SRCALPHA|SDL_RLEACCEL, amount);
	blit(fadeBlack, 0, 0, screen, false);
}

void Graphics::fadeToBlack()
{
	int start = 0;

	while (start < 50)
	{
		SDL_SetAlpha(fadeBlack, SDL_SRCALPHA|SDL_RLEACCEL, start);
		blit(fadeBlack, 0, 0, screen, false);
		delay(60);
		start++;
	}
}

void Graphics::loadFont(int i, char *filename, int pointSize)
{
	if (font[i])
	{
		debug(("Freeing Font %d first...\n", i));
		TTF_CloseFont(font[i]);
	}

	#if USEPAK
		font[i] = TTF_OpenFont(TEMPDIR"font.ttf", pointSize);
	#else
		font[i] = TTF_OpenFont("data/vera.ttf", pointSize);
	#endif

	if (!font[i])
		engine->reportFontFailure();

	TTF_SetFontStyle(font[i], TTF_STYLE_NORMAL);
}

Sprite *Graphics::addSprite(char *name)
{
	Sprite *sprite = new Sprite;
	strcpy(sprite->name, name);

	spriteTail->next = sprite;
	spriteTail = sprite;

	return sprite;
}

Sprite *Graphics::getSprite(char *name, bool required)
{
	Sprite *sprite = spriteHead;

	while (sprite->next != NULL)
	{
		sprite = (Sprite*)sprite->next;

		if (strcmp(sprite->name, name) == 0)
			return sprite;
	}

	if (required)
		showErrorAndExit("The requested sprite '%s' does not exist", name);

	return NULL;
}

void Graphics::animateSprites()
{
	Sprite *sprite = spriteHead;

	while (sprite->next != NULL)
	{
		sprite = (Sprite*)sprite->next;

		sprite->animate((int)(1 * engine->getTimeDifference()));
	}
}

void Graphics::loadBackground(char *filename)
{
	if (background != NULL)
		SDL_FreeSurface(background);

	if (strcmp(filename, "@none@") == 0)
		return;

	background = loadImage(filename);

	SDL_SetColorKey(background, 0, SDL_MapRGB(background->format, 0, 0, 0));
}

void Graphics::putPixel(int x, int y, Uint32 pixel, SDL_Surface *dest)
{
	if ((x < 0) || (x > SCREENWIDTH - 1) || (y < 0) || (y > SCREENHEIGHT - 1))
		return;

	int bpp = dest->format->BytesPerPixel;
	/* Here p is the address to the pixel we want to set */
	Uint8 *p = (Uint8 *)dest->pixels + y * dest->pitch + x * bpp;

	switch(bpp)
	{
		case 1:
			*p = pixel;
			break;

		case 2:
			*(Uint16 *)p = pixel;
			break;

		case 3:
			if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
			{
				p[0] = (pixel >> 16) & 0xff;
				p[1] = (pixel >> 8) & 0xff;
				p[2] = pixel & 0xff;
			}
			else
			{
				p[0] = pixel & 0xff;
				p[1] = (pixel >> 8) & 0xff;
				p[2] = (pixel >> 16) & 0xff;
			}
			break;

		case 4:
			*(Uint32 *)p = pixel;
			break;
	}
}

Uint32 Graphics::getPixel(SDL_Surface *surface, int x, int y)
{
	if ((x < 0) || (x > (surface->w - 1)) || (y < 0) || (y > (surface->h - 1)))
		return 0;

	int bpp = surface->format->BytesPerPixel;
	Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

	switch(bpp) {
	case 1:
		return *p;

	case 2:
		return *(Uint16 *)p;

	case 3:
		if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
				return p[0] << 16 | p[1] << 8 | p[2];
		else
				return p[0] | p[1] << 8 | p[2] << 16;

	case 4:
		return *(Uint32 *)p;

	default:
		return 0;       /* shouldn't happen, but avoids warnings */
	}
}

void Graphics::drawLine(float startX, float startY, float endX, float endY, int color, SDL_Surface *dest)
{
	lock(screen);
	
	float dx, dy;
	
	Math::calculateSlope(startX, startY, endX, endY, &dx, &dy);

	while (true)
	{
		putPixel((int)startX, (int)startY, color, dest);

		if ((int)startX == (int)endX)
			break;

		startX -= dx;
		startY -= dy;
	}

	unlock(screen);
}

void Graphics::blit(SDL_Surface *image, int x, int y, SDL_Surface *dest, bool centered)
{
	if (!image)
		showErrorAndExit("graphics::blit() - NULL pointer", "");

	if ((x < -image->w) || (x > SCREENWIDTH + image->w))
		return;

	if ((y < -image->h) || (y > SCREENHEIGHT + image->h))
		return;

	// Set up a rectangle to draw to
	gRect.x = x;
	gRect.y = y;
	if (centered)
	{
		gRect.x -= (image->w / 2);
		gRect.y -= (image->h / 2);
	}

	gRect.w = image->w;
	gRect.h = image->h;

	/* Blit onto the screen surface */
	if (SDL_BlitSurface(image, NULL, dest, &gRect) < 0)
		showErrorAndExit("graphics::blit() - %s", SDL_GetError());
}

void Graphics::drawBackground()
{
	if (background != NULL)
		blit(background, 0, 0, screen, false);
	else
		SDL_FillRect(screen, NULL, black);
}

void Graphics::drawBackground(SDL_Rect *r)
{
	if (r->x < 0) r->x = 0;
	if (r->y < 0) r->y = 0;
	if (r->x + r->w > 639) r->w = 640 - r->x;
	if (r->y + r->h > 639) r->h = 480 - r->y;

	if (SDL_BlitSurface(background, r, screen, r) < 0)
		showErrorAndExit("graphics::blit() - %s", SDL_GetError());
}

void Graphics::drawRect(int x, int y, int w, int h, int color, SDL_Surface *dest)
{
	gRect.x = x;
	gRect.y = y;
	gRect.w = w;
	gRect.h = h;

	SDL_FillRect(dest, &gRect, color);
}

void Graphics::drawRect(int x, int y, int w, int h, int color, int borderColor, SDL_Surface *dest)
{
	drawRect(x - 1, y - 1, w + 2, h + 2, borderColor, dest);
	drawRect(x, y, w, h, color, dest);
}

void Graphics::setFontColor(int red, int green, int blue, int red2, int green2, int blue2)
{
	fontForeground.r = red;
	fontForeground.g = green;
	fontForeground.b = blue;

	fontBackground.r = red2;
	fontBackground.g = green2;
	fontBackground.b = blue2;

	fontForeground.unused = fontBackground.unused = 0;
}

void Graphics::setFontSize(int size)
{
	fontSize = size;
	Math::limitInt(&fontSize, 0, 4);
}

SDL_Surface *Graphics::getString(bool transparent, char *in, ...)
{
	va_list argp;
	va_start(argp, in);
	vsprintf(textstring, in, argp);
	va_end(argp);

	SDL_Surface *text = TTF_RenderText_Shaded(font[fontSize], textstring, fontForeground, fontBackground);

	if (!text)
	{
		printf("getString : Font Rendering Error (%s)\n", textstring);
		exit(1);
	}

	if (transparent)
		setTransparent(text);

	return text;
}

void Graphics::drawString(int x, int y, int alignment, SDL_Surface *dest, char *in, ...)
{
	va_list argp;
	va_start(argp, in);
	vsprintf(textstring, in, argp);
	va_end(argp);

	bool center = false;

	SDL_Surface *text = TTF_RenderText_Shaded(font[fontSize], textstring, fontForeground, fontBackground);

	if (!text)
	{
		printf("drawString : Font Rendering Error (%s)\n", textstring);
		exit(1);
	}

	if (alignment == TXT_RIGHT) x -= text->w;
	if (alignment == TXT_CENTERED) center = true;

	setTransparent(text);
	blit(text, x, y, dest, center);
	SDL_FreeSurface(text);
}

void Graphics::drawWidgetRect(int x, int y, int w, int h)
{
	x -= 4;
	y -= 4;
	w += 8;
	h += 8;

	drawRect(x, y, w, h, green, screen);
	drawLine(x, y, x + w, y, white, screen);
	drawLine(x, y, x, y + h, white, screen);
	drawLine(x, y + h, x + w, y + h, darkGreen, screen);
	drawLine(x + w, y + 1, x + w, y + h, darkGreen, screen);
}

SDL_Surface *Graphics::createSurface(int width, int height)
{
	SDL_Surface *surface, *newImage;
	Uint32 rmask, gmask, bmask, amask;

	/* SDL interprets each pixel as a 32-bit number, so our masks must depend
	on the endianness (byte order) of the machine */
	#if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
		rmask = 0xff000000;
		gmask = 0x00ff0000;
		bmask = 0x0000ff00;
		amask = 0x000000ff;
	#else
		rmask = 0x000000ff;
		gmask = 0x0000ff00;
		bmask = 0x00ff0000;
		amask = 0xff000000;
	#endif

	surface = SDL_CreateRGBSurface(SDL_SWSURFACE, width, height, 32, rmask, gmask, bmask, amask);

	if (surface == NULL)
		showErrorAndExit("CreateRGBSurface failed: %s\n", SDL_GetError());

	newImage = SDL_DisplayFormat(surface);

	SDL_FreeSurface(surface);

	return newImage;
}

SDL_Surface *Graphics::alphaRect(int width, int height, Uint8 red, Uint8 green, Uint8 blue)
{
	SDL_Surface *surface = createSurface(width, height);

	SDL_FillRect(surface, NULL, SDL_MapRGB(surface->format, red, green, blue));

	SDL_SetAlpha(surface, SDL_SRCALPHA|SDL_RLEACCEL, 128);

	return surface;
}

void Graphics::colorize(SDL_Surface *image, int red, int green, int blue)
{
	SDL_Surface *alpha = alphaRect(image->w, image->h, red, green, blue);

	blit(alpha, 0, 0, image, false);

	SDL_SetColorKey(image, (SDL_SRCCOLORKEY|SDL_RLEACCEL), SDL_MapRGB(image->format, red / 2, green / 2, blue / 2));
}

void Graphics::lock(SDL_Surface *surface)
{
	/* Lock the screen for direct access to the pixels */
	if (SDL_MUSTLOCK(surface))
	{
		if (SDL_LockSurface(surface) < 0 )
		{
			showErrorAndExit("Could not lock surface", "");
		}
	}
}

void Graphics::unlock(SDL_Surface *surface)
{
	if (SDL_MUSTLOCK(surface))
	{
		SDL_UnlockSurface(surface);
	}
}

void Graphics::showErrorAndExit(char *error, char *param)
{
	clearScreen(black);

	char message[256];
	sprintf(message, error, param);

	setFontSize(3); setFontColor(0xff, 0x00, 0x00, 0x00, 0x00, 0x00);
	drawString(400, 50, true, screen, "An unforseen error has occurred");
	setFontSize(1); setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
	drawString(400, 90, true, screen, message);

	drawString(130, 150, false, screen, "You may wish to try the following,");

	setFontSize(0);
	drawString(155, 190, false, screen, "1) Try reinstalling the game.");
	drawString(155, 210, false, screen, "2) Ensure you have SDL 1.2.5 or greater installed.");
	drawString(155, 230, false, screen, "3) Ensure you have the latest versions of additional required SDL libraries.");
	drawString(155, 250, false, screen, "4) Install using an RPM if you originally built the game from source");
	drawString(155, 270, false, screen, "or try building from source if you installed using an RPM.");
	drawString(155, 290, false, screen, "5) Visit http://www.parallelrealities.co.uk/virusKiller.php and check for updates.");

	setFontSize(1);

	drawString(400, 360, true, screen, "If problems persist contact Parallel Realities. Please be aware however that we will not");
	drawString(400, 380, true, screen, "be able to assist in cases where the code or data has been modified.");

	drawString(400, 420, true, screen, "Virus Killer will now exit");
	drawString(400, 450, true, screen, "Press Escape to continue");

	engine->flushInput();

	while (true)
	{
		updateScreen();
		engine->getInput();
		if (engine->keyState[SDLK_ESCAPE])
			exit(1);
	}
}
