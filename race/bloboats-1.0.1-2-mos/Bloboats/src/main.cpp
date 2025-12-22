/*
    Bloboats - a boat racing game by Blobtrox
    Copyright (C) 2006  Markus "MakeGho" Kettunen

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

#include "SDL.h"
#include "SDL_opengl.h"

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#ifdef __WIN32__
#include <windows.h>
#endif

#include "keyboard.h"
#include "window.h"
#include "graphics.h"
#include "mouse.h"
#include "font.h"

#include "menu.h"
#include "config.h"
#include "water.h"
#include "sound.h"
#include "path.h"
#include "media.h"

#ifdef __MORPHOS__
const char *version_tag = "$VER: Bloboats 1.0.1-2 (01.09.2006)";
#endif


mouse Mouse;
graphics Graphics;
window Window;
keyboard Keyboard;
config Config;
path *Path;
media Media;
water Water;


//SDL_Surface *screen;



// this system uses metric system, positive y means upwards, positive x means right


font Font;
font Font_bl; // no outline

Uint32 flags = SDL_OPENGL;

int main(int argc, char*argv[]) {

	printf("Bloboats version 1.0.1-2, Copyright (C) 2006 Markus Kettunen\n");
	printf("Bloboats comes with ABSOLUTELY NO WARRANTY; for details check\n");
	printf("file \"copying.txt\".\n");
	printf("This is free software, and you are welcome to redistribute it\n");
	printf("under certain conditions; check file \"copying.txt\" for details.\n");
	printf("\n");

	if (SDL_Init(SDL_INIT_VIDEO)==-1) {
		fprintf (stderr, "Couldn't init SDL: %s\n", SDL_GetError());
		exit(1);
	}

	atexit(SDL_Quit);

	// On Windows, chdir to binary dir
#ifdef __WIN32__
	char binbuf[200];
	if (!GetModuleFileName( NULL, binbuf, 200 ) ) {
		fprintf (stderr, "GetModuleFileName failed (%d). \n", GetLastError() );
	}
	// cut until get the last '\' :-P
	for (int i = strlen(binbuf)-1; i>=0; i--) {
		if (binbuf[i]=='\\' || binbuf[i]=='/') break;
		binbuf[i] = '\0';
	}
	chdir(binbuf);
#endif



	// config directories
	Path = new path();


	Config.load();

	char *replay = 0;

	int reswidth=0, resheight=0;
	bool manualres=false;

	if (argc >= 2) {
		for (int i=1; i<argc; i++) {
			if (strcmp(argv[i], "--nosound")==0) {
				Config.sounds=0;
			} else 
			if (strcmp(argv[i], "--sound")==0) {
				Config.sounds=1;
			} else
			if (strcmp(argv[i], "--fullscreen")==0 || strcmp(argv[i], "-f")==0) {
				Config.fullscreen = 1;
			} else
			if (strcmp(argv[i], "--windowed")==0 || strcmp(argv[i], "-w")==0) {
				Config.fullscreen = 0;
			} else 
			if (strcmp(argv[i], "--nolimit")==0) {
				Config.nolimit=true;
			} else
			if (strncmp(argv[i], "--resolution=", 13)==0) {
				if ( sscanf(argv[i], "--resolution=%dx%d", &reswidth, &resheight)
					!= 2 )
				{
					printf ("Resolution flag takes two integer parameters: --resolutiuon=NxM\n");
					printf ("Example: --resolution=1280x800\n");
					exit(1);
				}
				if (reswidth <= 0 || resheight <= 0 || reswidth > 2048
					|| resheight > 1536)
				{
					printf ("Please choose a width between 1 and 2048 and height between 1 and 1536.\n");
					exit(1);
				}
				manualres=true;

				// Configs
				if (reswidth == 640 && resheight == 480) Config.resolution = 1;
				else if (reswidth == 800 && resheight == 600) Config.resolution = 2;
				else if (reswidth == 1024 && resheight == 768) Config.resolution = 3;
				else if (reswidth == 1280 && resheight == 960) Config.resolution = 4;
				else if (reswidth == 1280 && resheight == 1024) Config.resolution = 5;


			} else
			if (strcmp(argv[i], "--help")==0 || strcmp(argv[i], "-h")==0 ||
				strcmp(argv[i], "-?")==0 || strcmp(argv[i], "?")==0 ||
				strcmp(argv[i], "/?")==0 || strcmp(argv[i], "/h")==0)
			{
				printf("Bloboats\n");
				printf("By Markus Kettunen <makegho@mbnet.fi>\n");
				printf("\n");
				printf("Distributed under GNU GPL version 2. See \"copying.txt\".\n");
				printf("\n");
				printf("Possible flags:\n");
				printf("  --nosound disables sounds\n");
				printf("  --sound enables sounds\n");
				printf("  --windowed or -w enables windowed mode\n");
				printf("  --fullscreen or -f enables fullscreen mode\n");
				printf("  --resolution=NxM changes resolution to NxM\n");
				printf("  --nolimit disables some speed limitations\n");
				printf("  --help prints this help\n");

				return 0;
			} else {		
				// Test existence
				FILE *fp = fopen(argv[i], "rb");
				if (!fp) {
					fprintf (stderr, "Couldn't open file \"%s\". Critical.\n", argv[i]);
					exit(1);
				}
				fclose(fp);

				delete[] replay;
				replay = new char[strlen(argv[i])+1];
				strcpy(replay, argv[i]);

			}
		}
	}

	// Start sound system 
#if SOUND == 1
	if (Config.sounds) {
		sound::Start();
		Media.LoadStuff();
		sound::SetChannels(16);
	}
#endif


	if (Config.fullscreen) flags |= SDL_FULLSCREEN;

	SDL_Surface *s;

	if (!manualres) {
		switch(Config.resolution) {
			case 1:
				s = Window.OpenWindow(640, 480, 32, flags);
			break;
			case 2:
				s = Window.OpenWindow(800, 600, 32, flags);
			break;
			case 3:
				s = Window.OpenWindow(1024, 768, 32, flags);
			break;
			case 4:
				s = Window.OpenWindow(1280, 960, 32, flags);
			break;
			case 5:
				s = Window.OpenWindow(1280, 1024, 32, flags);
			break;
			default:
				s = Window.OpenWindow(640, 480, 32, flags);
			break;
		}
	} else {
		s = Window.OpenWindow(reswidth, resheight, 32, flags);
	}

	if (!s) {
		fprintf (stderr, "Couldn't set screenmode: %s\n", SDL_GetError());
		exit(1);
	}

	SDL_Surface *icon = Graphics.LoadPicture( Path->data("images/icon.png") );
	SDL_WM_SetIcon(icon, NULL);


	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);

	int doublebuffer;
	SDL_GL_GetAttribute(SDL_GL_DOUBLEBUFFER, &doublebuffer);
	if (doublebuffer != 1) {
		fprintf (stderr, "No double buffer support!\n");
		exit(1);
	}


	// done graphics initialization

	SDL_EnableUNICODE(1);

	// fonts
	Font.Initialize(FONT_BIG);
	Font_bl.Initialize(FONT_BL);

	Keyboard.ResetAll();

	Window.SetTitle("Bloboats", "Bloboats");

	if (replay) { // replay
		menu Menu;
		Menu.loadtimes_public(); // parses level names
		Menu.simulate(0, replay);
	} else {
		menu Menu;
		Menu.mainmenu();
		Config.save();
	}

#if SOUND == 1
	if (Config.sounds) {
		Media.FreeStuff();
		sound::Stop();
	}
#endif

	SDL_FreeSurface (icon);

	delete Path;
	delete[] replay;

}
