/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

#include <SDL.h>
#include "ta.h"
#include "modern.h"

void draw_main_menu(SDL_Surface *where, int curloc)
{
    char buf[80];
    draw_graphic(GFX_Main_Menu, 0, 0, where);
    cwriteXE(5,"S t a r B l a z e r   X - I 7 2 3 E", where);
    cwriteXE(25,"M a i n   C o n t r o l   P a n e l", where);
    if(godlike)
	cwriteXE(140,"Commence Grand Tour", where);
    else
	cwriteXE(140,"Engage the Entomorphs", where);
    if(momentumconserved)
	cwriteXE(160,"Momentum: On", where);
    else
	cwriteXE(160,"Momentum: Off", where);
    sprintf(buf, "Difficulty: %s", speeds[speed]);
    cwriteXE(180,buf, where);
    cwriteXE(200,"Display Credits", where);
    cwriteXE(220,"See Best Acquirers", where);
    cwriteXE(240,"Read briefing", where);
    cwriteXE(260,"Graphics Test", where);
    cwriteXE(280,"Exit Target Acquired",where);
    cwriteXE(curloc*20+140, "<                      >", where);
}

int handle_event_main_menu(SDL_Event *event, int *location, int *cheatloc)
{
    if (event->type == SDL_KEYDOWN) {
	switch (event->key.keysym.sym) {
	case SDLK_ESCAPE:
	    *location = 7;  // Exit
	    return 1;			
	case SDLK_KP2:
	case SDLK_DOWN:
	    *cheatloc = 0;
	    if (*location < 7) {
		++(*location);
	    }
	    break;
	case SDLK_KP8:
	case SDLK_UP:
	    *cheatloc = 0;
	    if (*location > 0) {
		--(*location);
	    }		    
	    break;
	case SDLK_KP6:
	case SDLK_RIGHT:
	    if (*location == 2 && speed < 8) {
		++speed;
	    }
	    break;
	case SDLK_KP4:
	case SDLK_LEFT:
	    if (*location == 2 && speed > 0) {
		--speed;
	    }
	    break;
	case SDLK_KP_ENTER:
	case SDLK_RETURN:
	    if (*location == 1) {
		momentumconserved = 1-momentumconserved;
	    } else if (*location == 2) {
		/* Do nothing */
	    } else {
		return 1;
	    }
	    // This controls the secret cheat code.  Hitting the keys in
	    // the right order will move cheatloc from 0 to 6, activating
	    // God Mode!
	case SDLK_r:
	    if ((*cheatloc)==0||(*cheatloc==5)) {
		++(*cheatloc); 
	    } else {
		cheatloc=0;
	    }
	    break;
	case SDLK_h:
	    if (*cheatloc==1) {
		++(*cheatloc); 
	    } else {
		*cheatloc=0; 
	    }
	    break;
	case SDLK_u:
	    if (*cheatloc==2) {
		++(*cheatloc); 
	    } else {
		*cheatloc=0; 
	    }
	    break;
	case SDLK_b:
	    if (*cheatloc==3) {
		*cheatloc=4;
	    } else if (*cheatloc==6) {
		godlike=1; 
		*cheatloc=0;
	    } else {
		*cheatloc=0; 
	    }
	    break;
	case SDLK_a:
	    if (*cheatloc==4) {
		++(*cheatloc); 
	    } else {
		*cheatloc=0; 
	    }
	    break;
	default:
	    *cheatloc = 0;
	    handle_event_top(event);
	}
    } else {
	handle_event_top(event);
    }
    return 0;
}

int do_main_menu()
{
    int done = 0;
    int curloc = 0;
    int cheatloc = 0;
    while (!done) {
	SDL_Event event;
	while (SDL_PollEvent(&event) && !done) {
	    done = handle_event_main_menu(&event, &curloc, &cheatloc);
	}
	draw_main_menu(screen, curloc);
	SDL_Flip(screen);
    }
    return curloc+1;
}
