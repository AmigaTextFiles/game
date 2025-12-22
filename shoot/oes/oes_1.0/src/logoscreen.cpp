///////////////////////////////////////////////
// 
//  Snipe2d ludum dare 48h compo entry
//
//  Jari Komppa aka Sol 
//  http://iki.fi/sol
// 
///////////////////////////////////////////////
// License
///////////////////////////////////////////////
// 
//     This software is provided 'as-is', without any express or implied
//     warranty.    In no event will the authors be held liable for any damages
//     arising from the use of this software.
// 
//     Permission is granted to anyone to use this software for any purpose,
//     including commercial applications, and to alter it and redistribute it
//     freely, subject to the following restrictions:
// 
//     1. The origin of this software must not be misrepresented; you must not
//        claim that you wrote the original software. If you use this software
//        in a product, an acknowledgment in the product documentation would be
//        appreciated but is not required.
//     2. Altered source versions must be plainly marked as such, and must not be
//        misrepresented as being the original software.
//     3. This notice may not be removed or altered from any source distribution.
// 
// (eg. same as ZLIB license)
//
///////////////////////////////////////////////
//
// Houses are taken from a satellite picture of glasgow.
//
// The sources are a mess, as I didn't even try to do anything
// really organized here.. and hey, it's a 48h compo =)
//
#include "snipe2d.h"
extern void fillrect (int x1, int y1, int x2, int y2, int color);

void init_logoscreen()
{
    /*    char path[256];
    printf ("Initializing logo screen\n");

    // Note the lack of error checking.  Bad, bad, bad.
    snprintf (path, 256, "%s/1.png", mediaPath);
    pbut.lv[0] = IMG_Load (path);
    snprintf (path, 256, "%s/2.png", mediaPath);
    pbut.lv[1] = IMG_Load (path);
    snprintf (path, 256, "%s/3.png", mediaPath);
    pbut.lv[2] = IMG_Load (path);
    snprintf (path, 256, "%s/easy.png", mediaPath);
    pbut.easy = IMG_Load (path);
    snprintf (path, 256, "%s/medium.png", mediaPath);
    pbut.med = IMG_Load (path);
    snprintf (path, 256, "%s/hard.png", mediaPath);
    pbut.hard = IMG_Load (path);
    snprintf (path, 256, "%s/audio.png", mediaPath);
    pbut.audio = IMG_Load (path);
    snprintf (path, 256, "%s/fullscreen.png", mediaPath);
    pbut.fullscreen = IMG_Load (path);
    snprintf (path, 256, "%s/newgame.png", mediaPath);
    pbut.newgame = IMG_Load (path);
    snprintf (path, 256, "%s/quit.png", mediaPath);
    pbut.quit = IMG_Load (path);
    snprintf (path, 256, "%s/resumegame.png", mediaPath);
    pbut.resumegame = IMG_Load (path); */
}

#if 0
void logoscreen()
{
    bool vertical_buttons = true;
    const char *logoscreen_img = "logoscreen.png";
    char path[ strlen(mediaPath) + 1 + strlen(logoscreen_img) + 1 ];
    sprintf(path, "%s/%s", mediaPath, logoscreen_img);
 
    SDL_Surface *logoscreen = IMG_Load(path);
    SDL_BlitSurface(logoscreen, NULL, Game.Screen, NULL);

    //fillrect (390, 4, 570, 35, 0x007f00);
    //fillrect (391, 5, 569, 34, 0x003f00);

    SDL_Flip(Game.Screen);
    init();
    int go = 0;
    int startTick = SDL_GetTicks();
    SDL_ShowCursor(1);
    while (!go)
    {
        SDL_Event event;
        while ( SDL_PollEvent(&event) ) 
        {
            switch (event.type) 
            {
            case SDL_KEYUP:
                if (event.key.keysym.sym == SDLK_ESCAPE)
                    exit(0);
		if (event.key.keysym.sym == SDLK_F12)
		    show_hiscores();
                break;
            case SDL_MOUSEBUTTONUP:
                if ((SDL_GetTicks() - startTick) > 500)
		    {
			if (vertical_buttons)
			    {
				if (hovering (456, 166, 174, 24))
				    {
					go = 1;
					SDL_ShowCursor(0);
				    }
				else go = 0;
				SDL_ShowCursor(1);
				if (hovering (456, 328, 174, 24))
				    {
					std::cout<< "Exiting normally\n";
					exit (0);
				    }
				if (hovering (456, 274, 174, 24))
				    {
					show_hiscores();
					vertical_buttons = false;
				    }
				if (hovering (456, 220, 174, 24))
				    {
					prefs();
				    }
			    } else {
				if (hovering (29, 446, 174, 24))
				    {
					go = 1;
					SDL_ShowCursor(0);
				    }
				if (hovering (238, 446, 174, 24))
				    {
					prefs();
				    }
				if (hovering (437, 446, 174, 24))
				    {
					std::cout<<"Exiting normally\n";
					exit (0);
				    }
			    }
		    }
                break;
            case SDL_QUIT:
                exit(0);
            }
	    if (vertical_buttons)
		{
		    if (!hovering (456, 166, 174, 24))
			draw_button (gButton.startgame, 440, 160);
		    else
			draw_button (gButton.startgameh, 440, 160);
		    if (!hovering (456, 220, 174, 24))
			draw_button (gButton.prefs, 440, 214);
		    else
			draw_button (gButton.prefsh, 440, 214);
		    if (!hovering (456, 274, 174, 24))
			draw_button (gButton.hiscores, 440, 268);
		    else
			draw_button (gButton.hiscoresh, 440, 268);
		    if (!hovering (456, 328, 174, 24))
			draw_button (gButton.quit, 440, 322);
		    else
			draw_button (gButton.quith, 440, 322);
		} else {
		    if (!hovering (29, 446, 174, 24))
			draw_button (gButton.startgame, 13, 440);
		    else
			draw_button (gButton.startgameh, 13, 440);
		    if (!hovering (238, 446, 174, 24))
			draw_button (gButton.prefs, 222, 440);
		    else
			draw_button (gButton.prefsh, 222, 440);
		    if (!hovering (437, 446, 174, 24))
			draw_button (gButton.quit, 431, 440);
		    else
			draw_button (gButton.quith, 431, 440);
		}
	    SDL_Flip (Game.Screen);
        }
    }
    SDL_FreeSurface(logoscreen);
}
#endif /* 0 */
