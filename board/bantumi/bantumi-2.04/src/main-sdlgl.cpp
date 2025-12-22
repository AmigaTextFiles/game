/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>
#include <SDL_opengl.h>
#include <math.h>
#include <string.h>
#include <time.h>
#include "bantumigl.h"
#include "bantumi.h"
#include "glfont.h"
#ifdef __APPLE__
#include <CoreFoundation/CoreFoundation.h>
#endif
#include "tcpip.h"
#include "gui.h"

int width = 640;
int height = 480;

void makeScreenShot() {
	SDL_Surface *screen = SDL_GetVideoSurface();
#if SDL_BYTEORDER == SDL_LIL_ENDIAN
	SDL_Surface *surfc = SDL_CreateRGBSurface(SDL_SWSURFACE, screen->w, screen->h, 32, 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000);
	SDL_Surface *surfa = SDL_CreateRGBSurface(SDL_SWSURFACE, screen->w, screen->h, 32, 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000);
#else
	SDL_Surface *surfc = SDL_CreateRGBSurface(SDL_SWSURFACE, screen->w, screen->h, 32, 0xFF000000, 0x00FF0000, 0x0000FF00, 0x000000FF);
	SDL_Surface *surfa = SDL_CreateRGBSurface(SDL_SWSURFACE, screen->w, screen->h, 32, 0xFF000000, 0x00FF0000, 0x0000FF00, 0x000000FF);
#endif
	for (int y = 0; y < surfc->h; y++) {
		glReadPixels(0, surfc->h - 1 - y, surfc->w, 1, GL_RGBA, GL_UNSIGNED_BYTE, ((Uint8*)surfc->pixels) + y*surfc->pitch);
		for (int x = 0; x < surfc->w; x++) {
			Uint8 *c = (Uint8*)surfc->pixels + y*surfc->pitch + x*surfc->format->BytesPerPixel;
			Uint8 *a = (Uint8*)surfa->pixels + y*surfa->pitch + x*surfa->format->BytesPerPixel;
			a[0] = a[1] = a[2] = c[3];
			a[3] = c[3] = 255;
		}
	}
	SDL_SaveBMP(surfc, "sshot.bmp");
	SDL_SaveBMP(surfa, "sshot-alpha.bmp");
	SDL_FreeSurface(surfc);
	SDL_FreeSurface(surfa);
}

static BantumiGL *fe;
static int lasttime;

void redraw() {
	fe->draw(lasttime);
	SDL_GL_SwapBuffers();
}

int main(int argc, char *argv[]) {
	if (SDL_Init(SDL_INIT_VIDEO|SDL_INIT_NOPARACHUTE)<0) {
		fprintf(stderr,"%s\n",SDL_GetError());
		return 1;
	}
	if (atexit(SDL_Quit)) {
		fprintf(stderr,"atexit(...)\n");
		SDL_Quit();
		return 1;
	}
//	width = 176;
//	height = 208;
#ifdef SCREENSHOT
	width = 1024;
	height = 1280;
	SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE, 1);
#endif
	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
	SDL_WM_SetCaption("Bantumi GL", "Bantumi GL");
	bool fullscreen = false;
	int flags = SDL_OPENGL | SDL_RESIZABLE | (fullscreen ? SDL_FULLSCREEN : 0);
	SDL_Surface *screen = SDL_SetVideoMode(width, height, 0, flags);
	if (screen == NULL) {
		fprintf(stderr,"%s\n",SDL_GetError());
		return 1;
	}

	srand(time(NULL));
	initSockets();
	initGui();

	fe = new BantumiGL(screen->w, screen->h);
	GLFont *textFont, *numFont;
	char *fontname = "Vera.ttf";
#ifdef __APPLE__
	char fontPath[250];
	CFURLRef url = CFBundleCopyResourcesDirectoryURL(CFBundleGetMainBundle());
	CFURLGetFileSystemRepresentation(url, true, (UInt8*) fontPath, sizeof(fontPath));
	CFRelease(url);
	strcat(fontPath, "/");
	strcat(fontPath, fontname);
	fontname = fontPath;
#endif
	
#define makeSetFonts() \
	numFont = makeGLFont(fontname, 26, 64, 64, '0', '9');		\
	textFont = makeGLFont(fontname, 30, 256, 256, ' ', 'ö', 'z'+1, 'ö'-1);	\
	fe->setTextFont(textFont);					\
	fe->setNumFont(numFont);
	makeSetFonts();
	Bantumi *b = new Bantumi(fe);

#ifdef SCREENSHOT
	fe->draw(0);
	fe->draw(10000);
	fe->draw(20000);
	fe->draw(30000);
	makeScreenShot();
#endif

	bool active = true;
	int frames = 0;
	int starttime = SDL_GetTicks();
	lasttime = starttime;
	while (true) {
		SDL_Event event;
		bool done = false;
		while (SDL_PollEvent(&event)) {
			if (event.type == SDL_VIDEORESIZE) {
				screen = SDL_SetVideoMode(event.resize.w, event.resize.h, screen->format->BitsPerPixel, flags);
				if (screen == NULL) {
					fprintf(stderr, "%s\n", SDL_GetError());
					return 1;
				}
				delete numFont;
				delete textFont;
				makeSetFonts();
				fe->reinitGL(screen->w, screen->h);
			} else if (event.type == SDL_KEYDOWN) {
				switch (event.key.keysym.sym) {
				case SDLK_ESCAPE:
					b->pressed(ESCAPE);
					break;
/*				case SDLK_F1:
					fullscreen = !fullscreen;
					if (fullscreen) flags |= SDL_FULLSCREEN;
					else flags &= ~SDL_FULLSCREEN;
					screen = SDL_SetVideoMode(screen->w, screen->h, screen->format->BitsPerPixel, flags);
					if (screen == NULL) {
						fprintf(stderr,"%s\n",SDL_GetError());
						return 1;
					}
					delete numFont;
					delete textFont;
					makeSetFonts();
					fe->reinitGL(screen->w, screen->h);
					break;
*/				case SDLK_LEFT:
					b->pressed(LEFT);
					break;
				case SDLK_RIGHT:
					b->pressed(RIGHT);
					break;
				case SDLK_UP:
					b->pressed(UP);
					break;
				case SDLK_DOWN:
					b->pressed(DOWN);
					break;
				case SDLK_SPACE:
				case SDLK_RETURN:
					b->pressed(SELECT);
					break;
				default:
					break;
				}
			} else if (event.type == SDL_QUIT) {
				done = true;
			} else if (event.type == SDL_ACTIVEEVENT) {
				if (event.active.state == SDL_APPACTIVE)
					active = event.active.gain;
			} else if (event.type == SDL_MOUSEBUTTONDOWN) {
				if (event.button.button == SDL_BUTTON_RIGHT)
					b->pressed(ESCAPE);
				else
					b->click(event.button.x, event.button.y);
			} else if (event.type == SDL_MOUSEBUTTONUP) {
			} else if (event.type == SDL_MOUSEMOTION) {
			}
		}
		if (done) break;
		if (b->exit()) break;


		b->update();

		int time = SDL_GetTicks() - starttime;
		int difftime = time - lasttime;
		lasttime = time;
		if (difftime < 15)
			SDL_Delay(10);

		fe->draw(time);
		SDL_GL_SwapBuffers();
		frames++;
		if (active) {
			SDL_Delay(1);
		} else SDL_Delay(50);
//		SDL_Delay(500);

	}
//	printf("%d fps\n", 1000*frames/(SDL_GetTicks() - starttime));

	delete b;
	delete fe;
	delete textFont;
	delete numFont;

	closeSockets();

	return 0;
}


