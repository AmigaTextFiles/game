/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "modern.h"

#define NUM_GFX 131

graphic gfx[NUM_GFX];
graphic *technofont;

graphic *GFX_Main_Menu, *GFX_High_Score, *GFX_Enter_Name;
graphic *GFX_Credits, *GFX_Briefing, *GFX_End_Credits;

SDL_Surface *screen;

static Uint32 random_seed = 0;

void load_raw(int gfx_index, byte *pal, byte *data, int w, int h, Uint32 *buffer, byte alpha, byte collision)
{
    int i, y, x;
    SDL_Surface *init, *result;
    i=0;
    for(y=0;y<h;++y) {
	for(x=0;x<w;++x) {
	    byte index = data[i];
	    Uint32 r = pal[index * 3];
	    Uint32 g = pal[index * 3 + 1];
	    Uint32 b = pal[index * 3 + 2];
	    Uint32 a = alpha ? (index ? 0xff : 0x00) : 0x00;
	    Uint32 value = r | (g << 8) | (b << 16) | (a << 24);
	    buffer[((y*w*2)+x)*2]=value;
	    buffer[((y*w*2)+x)*2+1]=value;
	    buffer[((y*w*2)+x)*2+w*2]=value;
	    buffer[((y*w*2)+x)*2+w*2+1]=value;
	    ++i;
	}
    }

    init = SDL_CreateRGBSurfaceFrom(buffer, w*2, h*2, 32, w*8, 
				    (Uint32)0xff, (Uint32)0xff00, (Uint32)0xff0000, 
				    (alpha ? (Uint32)0xff000000 : (Uint32)0));
    if (init) {
	result = alpha ? SDL_DisplayFormatAlpha(init) : SDL_DisplayFormat(init);
	SDL_FreeSurface(init);
	gfx[gfx_index].valid = result ? 1 : 0;
	gfx[gfx_index].surface = result;
	if (collision && result) {
	    byte *col_data = malloc(w*h);
	    if (col_data) {
		int j;
		for(j=0; j<w*h;++j)
		    col_data[j]=data[j];
		gfx[gfx_index].outline=col_data;
	    } else {
		printf("Ack!  Couldn't allocate collision matrix for graphic #%i!\n", gfx_index);
		gfx[gfx_index].valid = 0;
		SDL_FreeSurface(gfx[gfx_index].surface);
		gfx[gfx_index].surface=NULL;
		gfx[gfx_index].outline=NULL;
	    }
	} else {
	    gfx[gfx_index].outline=NULL;
	}
    } else {
	gfx[gfx_index].valid = 0;
	gfx[gfx_index].surface=NULL;
	gfx[gfx_index].outline=NULL;
    }
}

void load_graphics(int fullscreen) 
{
    FILE *source;
    byte *file;
    byte *pal, *file_index;
    int gfx_index;
    Uint32 *gfxbuffer;
    int i;
    byte font_h;

    if (fullscreen) {
	screen = SDL_SetVideoMode(640,400,32,SDL_HWSURFACE|SDL_DOUBLEBUF|SDL_ANYFORMAT|SDL_FULLSCREEN);
    } else {
	screen = SDL_SetVideoMode(640,400,32,SDL_HWSURFACE|SDL_DOUBLEBUF|SDL_ANYFORMAT);
    }
    if( !screen ) {
	printf("Unable to set 640x400 video: %s\n", SDL_GetError());
	exit(1);
    }
    SDL_WM_SetCaption("Target Acquired", "Target Acquired");

    gfxbuffer = malloc(sizeof(Uint32) * 256000);
    file = malloc(278606);
    if ((!gfxbuffer)||(!file)) {
	printf("Ludicrous lack of memory!  Aborting.\n");
	exit(1);
    }

    if((source=fopen("graphics.dat", "rb"))==NULL) {
	printf("Your version of TARGET ACQUIRED is not complete.\nThe file graphics.dat is missing.\n");
	exit(1);
    } else {
	fread(file, 1, 278606, source);
	fclose(source);
    }

    for (i = 0; i < 768*6; i++)
	file[i] *= 4;

    pal = file;
    file_index = file+(768*6);
    gfx_index = 0;

    /* Load the backgrounds into gfx locations 0-5 */
    load_raw(gfx_index++, pal+768*1, file_index, 320, 200, gfxbuffer, 0, 0);
    load_raw(gfx_index++, pal+768*4, file_index, 320, 200, gfxbuffer, 0, 0);
    load_raw(gfx_index++, pal+768*5, file_index, 320, 200, gfxbuffer, 0, 0);
    file_index += 64000;
    load_raw(gfx_index++, pal+768*2, file_index, 320, 200, gfxbuffer, 0, 0);
    file_index += 64000;
    load_raw(gfx_index++, pal+768*3, file_index, 320, 200, gfxbuffer, 0, 0);
    file_index += 64000;
    load_raw(gfx_index++, pal+768*5, file_index, 320, 200, gfxbuffer, 0, 0);
    file_index += 64000;

    /* Load all the sprites. */
    for (i = 0; i < 30; ++i) {
	byte w = file_index[0];
	byte h = file_index[1];
	load_raw(gfx_index++, pal, file_index+2, w, h, gfxbuffer, 1, 1);
	file_index += w*h+2;
    }

    /* Load the technofont. */

    technofont = gfx+gfx_index; 

    font_h = file_index[0];
    ++file_index;
    for (i = 0; i < 95; i++) {
	byte w = file_index[0];
	++file_index;
	load_raw(gfx_index++, pal, file_index, w, font_h, gfxbuffer, 1, 0);
	file_index += w*font_h;
    }

    free(gfxbuffer);
    free(file);

    /* Bind the backgrounds to their symbolic names */
    GFX_High_Score = gfx;
    GFX_Enter_Name = gfx+1;
    GFX_Main_Menu = gfx+2;
    GFX_Briefing = gfx+3;
    GFX_Credits = gfx+4;
    GFX_End_Credits = gfx+5;
}

void verify_graphics()
{
    int i;
    for (i = 0; i < NUM_GFX; i++) {
	if (!gfx[i].valid) {
	    printf("Ack!  Graphic #%i is invalid!\n", i);
	    clean_exit(1);
	}
    }
}

void init_SDL_layer(int fullscreen)
{
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
	printf("Unable to init SDL: %s\n", SDL_GetError());
	exit(1);
    }
    atexit(SDL_Quit);

    load_graphics(fullscreen);
    verify_graphics();
}

void cleanup_SDL_layer()
{
    int i;
    for (i = 0; i < NUM_GFX; i++) {
	if (gfx[i].valid) {
	    SDL_FreeSurface(gfx[i].surface);
	    if (gfx[i].outline) {
		free(gfx[i].outline);
	    }
	}
    }
}

void clean_exit(int code) 
{
    cleanup_SDL_layer();
    exit(code);
}

void draw_graphic(graphic *pic, int x, int y, SDL_Surface *where)
{
    SDL_Rect target;
    target.x = x;
    target.y = y;
    SDL_BlitSurface(pic->surface, NULL, where, &target);
}

void clear_graphic(SDL_Surface *where)
{
    SDL_FillRect(where, NULL, SDL_MapRGB(where->format, 0, 0, 0));
}

void writeXE(int x, int y, char *mess, SDL_Surface *where)
{
    while(*mess) {
	byte c = (*mess)-32;
	if (c < 96) {
	    graphic *letter = technofont+c;
	    draw_graphic(letter, x, y, where);
	    x += letter->surface->w;
	}
	mess++;
    }
}

void cwriteXE(int y, char *mess, SDL_Surface *where)
{
    writeXE(320-(XElen(mess)>>1), y, mess, where);
}


int XElen(char *message)
{
    int result=0;
    while (*message) {
	byte c = (*message)-32;
	if (c < 96) {
	    result += technofont[c].surface->w;
	}
	message++;
    }
    return(result);
}

void draw_scroll_text_slice(graphic *bg, int line, int offset, scrollingtext *text)
{
    int y, i;
    draw_graphic(bg, 0, 0, screen);
    y = -offset;
    for (i = 0; i < 22; i++) {
	int index = line+i;
	if (index >= 0 && index < text->length) {
	    cwriteXE(y, text->lines[index], screen);
	}
	y += 20;
	if (y > 400)
	    break;
    }
    SDL_Flip(screen);
}

void scroll_text (graphic *bg, scrollingtext *text, Uint32 timing)
{
    Uint32 now = SDL_GetTicks();
    Uint32 target = now;
    int i, j, done;
    done = 0;
    for (i = -20; i < text->length+1; i++) {
	for(j = 0; j < 20; j++) {
	    SDL_Event event;
	    target += timing;
	    now = SDL_GetTicks();
	    if (now < target) {
#ifdef DELAY_DEBUG
		printf("Delaying %i\n", target-now);
#endif
		SDL_Delay(target - now);
#ifdef DELAY_DEBUG
	    } else {
		printf("Delaying 0\n");
#endif
	    }
	    while (SDL_PollEvent(&event)) {
		if (event.type == SDL_KEYDOWN) {
		    if (event.key.keysym.sym == SDLK_ESCAPE) {
			done = 1;
		    }
		} else {
		    handle_event_top(&event);
		}
	    }
	    if (done) break;
	    draw_scroll_text_slice(bg, i, j, text);
	}
	if (done) break;
    }
}

/* Random number generators, because the ANSI C ones are terrible
   and what we were using wasn't portable.  This implements the
   BCPL random number generator, which was reasonably OK. */

void seed_random(Uint32 seed) 
{
    random_seed = seed;
}


int get_random(int range)
{
    random_seed *= 0x9010836d;
    random_seed += 0x2aa01d31;
    return (int)(random_seed % range);
}

/* Highest-level event handler.  Deals with window events. */

void handle_event_top(SDL_Event *event)
{
    if (event->type == SDL_QUIT) {
	clean_exit(0);
    }
}
