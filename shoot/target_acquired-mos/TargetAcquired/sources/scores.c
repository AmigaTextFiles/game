/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ta.h"
#include "scores.h"
#include "modern.h"

static hiscorestruct hiscores[10];

void loadhiscores()
{
    FILE *hsfile;
    int i;

    if((hsfile = fopen("ta.his", "rb"))==NULL)
    {
	for(i=0;i<10;i++) {
	    strcpy(hiscores[i].name,"Random High Scoring Dude (None)");
	    hiscores[i].hiscore=(10-i)*2500;
	}
    }
    else
    {
	fread(hiscores,sizeof(hiscorestruct),10,hsfile);
	fclose(hsfile);
    }
}

void savehiscores()
{
    FILE *hsfile;
    if((hsfile = fopen("ta.his", "wb"))!=NULL)
    {
	fwrite(hiscores, sizeof(hiscorestruct),10,hsfile);
	fclose(hsfile);
    }
}

void draw_hi_score_entry(SDL_Surface *where, char *name)
{
    draw_graphic(GFX_Enter_Name, 0, 0, where);

    cwriteXE(10, "Congratulations!  Your score has placed", where);
    cwriteXE(30, "you among the top ten acquirers of all", where);
    cwriteXE(50, "time!  Enter your name below:", where);
    cwriteXE(190, name, where);
}

int handle_event_enter_name(SDL_Event *event, char *name, int *index, int max)
{
    if (event->type == SDL_KEYDOWN) {
	unsigned char c = (unsigned char)((event->key.keysym.unicode) & 0xff);
	SDLKey key = event->key.keysym.sym;
	if (c >= 32 && c < 127 && *index < max) {
	    name[*index] = c;
	    ++(*index);
	    name[*index] = 0;
	} else if (key == SDLK_BACKSPACE) {
	    if (*index > 0) {
		--(*index);
	    }
	    name[*index] = 0;
	} else if (key == SDLK_ESCAPE || key == SDLK_RETURN || key == SDLK_KP_ENTER) {
	    return 1;
	} else {
	    handle_event_top(event);
	}
    } else {
	handle_event_top(event);
    }
    return 0;
}

void updatehiscores(unsigned long tocheck)
{
    int yourplace, i;
    char yourname[21];
    /* Only bother if actually on the high score table */
    if ((tocheck>=hiscores[9].hiscore)&&(!godlike))
    {
	int ready = 0;
	int index = 0;
	yourname[0] = 0;
	SDL_EnableUNICODE(1);
	while (!ready) {
	    SDL_Event event;
	    while(SDL_PollEvent(&event)) {
		if(handle_event_enter_name(&event, yourname, &index, 20)) {
		    ready = 1;
		}
	    }
	    draw_hi_score_entry(screen, yourname);
	    SDL_Flip(screen);
	}
	SDL_EnableUNICODE(0);
	yourplace=9;
	while((hiscores[yourplace-1].hiscore<=tocheck)&&(yourplace>0))
	    yourplace--;
	for(i=9;i>yourplace;i--)
	{
	    strcpy(hiscores[i].name, hiscores[i-1].name);
	    hiscores[i].hiscore=hiscores[i-1].hiscore;
	}
	sprintf(hiscores[yourplace].name, "%s (%s)", yourname, speeds[speed]);
	hiscores[yourplace].hiscore=tocheck;
	savehiscores();
    }
    displayhiscores();
}

void draw_hi_score_table(SDL_Surface *where)
{
    int i;
    char temp[41];

    draw_graphic(GFX_High_Score, 0, 0, screen);
    cwriteXE(5, "Best Acquirers", screen);
    for (i=0; i<10; i++) {
	writeXE(40,i*20+102,hiscores[i].name, screen);
	sprintf(temp, "%07lu", hiscores[i].hiscore);
	writeXE(600-XElen(temp), i*20+102, temp, screen);
    }
    cwriteXE(380,"Press any key", screen);
}

void displayhiscores()
{
    int done = 0;
    while (!done) {
	SDL_Event event;
	while (SDL_PollEvent(&event)) {
	    if (event.type == SDL_KEYDOWN) {
		done = 1;
	    } else {
		handle_event_top(&event);
	    }
	}
	draw_hi_score_table(screen);
	SDL_Flip(screen);
    }
}
