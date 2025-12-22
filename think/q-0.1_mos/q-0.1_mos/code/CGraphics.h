/*
Copyright (C) 2003 Parallel Realities

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

#include <stdarg.h>

class Graphics {

	private:

		Engine *engine;
		SDL_Rect gRect;
		TTF_Font *font[5];
		SDL_Color fontForeground, fontBackground;

		Sprite *spriteHead;
		Sprite *spriteTail;

		int fontSize;
		
		int screenShotNumber;
		char screenshot[100];
		char chatString[1024];

	public:

		bool takeRandomScreenShots;

		SDL_Surface *screen, *background;
		SDL_Surface *tile[MAX_TILES];

		int red, yellow, skyBlue, blue, cyan, white, lightGrey, grey, darkGrey, black;
		int lightestGreen, lightGreen, green, darkGreen, darkestGreen;

	Graphics();
	void free();
	void destroy();
	void mapColors();
	Sprite *getSpriteHead();
	void setTransparent(SDL_Surface *sprite);
	void updateScreen();
	void delay(int time);
	void clearScreen(int color);
	void RGBtoHSV(float r, float g, float b, float *h, float *s, float *v);
	void HSVtoRGB(float *r, float *g, float *b, float h, float s, float v);
	SDL_Surface *loadImage(char *filename);
	SDL_Surface *loadImage(char *filename, int hue, int sat, int value);
	SDL_Surface *quickSprite(char *name, SDL_Surface *image);
	void fade(int amount);
	void fadeToBlack();
	void loadMapTiles(char *baseDir);
	void loadFont(int i, char *filename, int pointSize);
	Sprite *addSprite(char *name);
	Sprite *getSprite(char *name, bool required);
	void animateSprites();
	void loadBackground(char *filename);
	void putPixel(int x, int y, Uint32 pixel, SDL_Surface *dest);
	Uint32 getPixel(SDL_Surface *surface, int x, int y);
	void drawLine(int startX, int startY, int endX, int endY, int color, SDL_Surface *dest);
	void blit(SDL_Surface *image, int x, int y, SDL_Surface *dest, bool centered);
	void drawBackground();
	void drawBackground(SDL_Rect *r);
	void drawRect(int x, int y, int w, int h, int color, SDL_Surface *dest);
	void drawRect(int x, int y, int w, int h, int color, int borderColor, SDL_Surface *dest);
	void setFontColor(int red, int green, int blue, int red2, int green2, int blue2);
	void setFontSize(int size);
	SDL_Surface *getString(bool transparent, char *in, ...);
	void drawString(int x, int y, int alignment, SDL_Surface *dest, char *in, ...);
	void clearChatString();
	void createChatString(char *in);
	void drawChatString();
	void drawWidgetRect(int x, int y, int w, int h);
	SDL_Surface *createSurface(int width, int height);
	SDL_Surface *alphaRect(int width, int height, Uint8 red, Uint8 green, Uint8 blue);
	void colorize(SDL_Surface *image, int red, int green, int blue);
	void lock(SDL_Surface *surface);
	void unlock(SDL_Surface *surface);
	void resetLoading();
	void showLoading(int amount, int max);
	void showErrorAndExit(char *error, char *param);
	
	const void registerEngine(Engine *engine)
	{
		this->engine = engine;
	}

};
