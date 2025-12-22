/***************************************************************************
                          sdl.c  -  description
                             -------------------
    begin                : Thu Apr 20 2000
    copyright            : (C) 2000 by Michael Speck
    email                : kulkanie@gmx.net
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <SDL.h>
#include <stdlib.h>
#include <string.h>
#include "sdl.h"

extern int  term_game;

Sdl sdl;
SDL_Cursor *empty_cursor = 0, *std_cursor = 0;

/* timer */
int cur_time, last_time;

/* sdl surface */

/* return full path of bitmap */
inline void get_full_bmp_path( char *full_path, char *file_name )
{
    sprintf(full_path,  "%s/gfx/%s", SRC_DIR, file_name );
}

/*
    load a surface from file putting it in soft or hardware mem
*/
SDL_Surface* load_surf(char *fname, int f)
{
    SDL_Surface *buf;
    SDL_Surface *new_sur;
    char path[ 512 ];
    SDL_PixelFormat *spf;

    get_full_bmp_path( path, fname );

    buf = SDL_LoadBMP( path );

    if ( buf == 0 ) {
        fprintf( stderr, "%s: %s\n", fname, SDL_GetError() );
        if ( f & SDL_NONFATAL )
            return 0;
        else
            exit( 1 );
    }
/*    if ( !(f & SDL_HWSURFACE) ) {

        SDL_SetColorKey( buf, SDL_SRCCOLORKEY, 0x0 );
        return buf;

    }
    new_sur = create_surf(buf->w, buf->h, f);
    SDL_BlitSurface(buf, 0, new_sur, 0);
    SDL_FreeSurface(buf);*/
    spf = SDL_GetVideoSurface()->format;
    new_sur = SDL_ConvertSurface( buf, spf, f );
    SDL_FreeSurface( buf );
    SDL_SetColorKey( new_sur, SDL_SRCCOLORKEY, 0x0 );
    SDL_SetAlpha( new_sur, 0, 0 ); /* no alpha */
    return new_sur;
}

/*
    create an surface
    MUST NOT BE USED IF NO SDLSCREEN IS SET
*/
SDL_Surface* create_surf(int w, int h, int f)
{
    SDL_Surface *sur;
    SDL_PixelFormat *spf = SDL_GetVideoSurface()->format;
    if ((sur = SDL_CreateRGBSurface(f, w, h, spf->BitsPerPixel, spf->Rmask, spf->Gmask, spf->Bmask, spf->Amask)) == 0) {
        fprintf(stderr, "ERR: ssur_create: not enough memory to create surface...\n");
        exit(1);
    }
/*    if (f & SDL_HWSURFACE && !(sur->flags & SDL_HWSURFACE))
        fprintf(stderr, "unable to create surface (%ix%ix%i) in hardware memory...\n", w, h, spf->BitsPerPixel);*/
    SDL_SetColorKey(sur, SDL_SRCCOLORKEY, 0x0);
    SDL_SetAlpha(sur, 0, 0); /* no alpha */
    return sur;
}

void free_surf( SDL_Surface **surf )
{
    if ( *surf ) {
        SDL_FreeSurface( *surf );
        *surf = 0;
    }
}
/*
    return display format
*/
int disp_format(SDL_Surface *sur)
{
    if ((sur = SDL_DisplayFormat(sur)) == 0) {
        fprintf(stderr, "ERR: ssur_displayformat: convertion failed\n");
        return 1;
    }
    return 0;
}

/*
    lock surface
*/
inline void lock_surf(SDL_Surface *sur)
{
    if (SDL_MUSTLOCK(sur))
        SDL_LockSurface(sur);
}

/*
    unlock surface
*/
inline void unlock_surf(SDL_Surface *sur)
{
    if (SDL_MUSTLOCK(sur))
        SDL_UnlockSurface(sur);
}

/*
    blit surface with destination DEST and source SOURCE using it's actual alpha and color key settings
*/
void blit_surf(void)
{
    SDL_BlitSurface(sdl.s.s, &sdl.s.r, sdl.d.s, &sdl.d.r);
}

/*
    do an alpha blit
*/
void alpha_blit_surf(int alpha)
{
    SDL_SetAlpha(sdl.s.s, SDL_SRCALPHA, alpha);
    SDL_BlitSurface(sdl.s.s, &sdl.s.r, sdl.d.s, &sdl.d.r);
    SDL_SetAlpha(sdl.s.s, 0, 0);
}

/*
    fill surface with color c
*/
void fill_surf(int c)
{
    SDL_FillRect(sdl.d.s, &sdl.d.r, SDL_MapRGB(sdl.d.s->format, c >> 16, (c >> 8) & 0xFF, c & 0xFF));
}

/* set clipping rect */
void set_surf_clip( SDL_Surface *surf, int x, int y, int w, int h )
{
    SDL_Rect rect = { x, y, w, h };
    if ( w == h || h == 0 )
        SDL_SetClipRect( surf, 0 );
    else
        SDL_SetClipRect( surf, &rect );
}

/* set pixel */
Uint32 set_pixel( SDL_Surface *surf, int x, int y, int pixel )
{
    int pos = 0;

    pos = y * surf->pitch + x * surf->format->BytesPerPixel;
    memcpy( surf->pixels + pos, &pixel, surf->format->BytesPerPixel );
    return pixel;
}

/* get pixel */
Uint32 get_pixel( SDL_Surface *surf, int x, int y )
{
    int pos = 0;
    Uint32 pixel = 0;

    pos = y * surf->pitch + x * surf->format->BytesPerPixel;
    memcpy( &pixel, surf->pixels + pos, surf->format->BytesPerPixel );
    return pixel;
}

/* sdl font */

/* return full font path */
void get_full_font_path( char *path, char *file_name )
{
    strcpy( path, file_name );
/*    sprintf(path, "./gfx/fonts/%s", file_name ); */
}

/*
    load a font using the width values in the file
*/
Font* load_font(char *fname)
{
    Font    *fnt = 0;
    FILE    *file = 0;
    char    path[512];
    int     i;

    get_full_font_path( path, fname );

    fnt = malloc(sizeof(Font));
    if (fnt == 0) {
        fprintf(stderr, "ERR: sfnt_load: not enough memory\n");
        exit(1);
    }

    if ((fnt->pic = load_surf(path, SDL_HWSURFACE)) == 0)
        exit(1);
    /* use very first pixel as transparency key */
    SDL_SetColorKey( fnt->pic, SDL_SRCCOLORKEY, get_pixel( fnt->pic, 0, 0 ) );		
		
    fnt->align = ALIGN_X_LEFT | ALIGN_Y_TOP;
    fnt->color = 0x00FFFFFF;
    fnt->height = fnt->pic->h;
	
    /* table */
    file = fopen(path, "r");
    fseek(file, -1, SEEK_END);
    fread(&fnt->offset, 1, 1, file);
#ifdef SDL_DEBUG
    printf("offset: %i\n", fnt->offset);
#endif
    fseek(file, -2, SEEK_END);
    fread(&fnt->length, 1, 1, file);
#ifdef SDL_DEBUG
    printf("number: %i\n", fnt->length);
#endif
    fseek(file, -2 - fnt->length, SEEK_END);
    fread(fnt->char_width, 1, fnt->length, file);
#ifdef SDL_DEBUG
    printf("letter width: %i\n", fnt->length);
    for (i = 0; i < fnt->length; i++)
        printf("%i ", fnt->char_width[i]);
    printf("\n");
#endif
    fclose(file);

    /* letter offsets */
    fnt->char_offset[0] = 0;
    for (i = 1; i < fnt->length; i++)	
        fnt->char_offset[i] = fnt->char_offset[i - 1] + fnt->char_width[i - 1];
	
    /* allowed keys */
    memset(fnt->keys, 0, 256);
    for (i = 0; i < fnt->length; i++) {
        fnt->keys[i + fnt->offset] = 1;
    }
	
    fnt->last_x = fnt->last_y = fnt->last_width = fnt->last_height = 0;
    return fnt;
}

/*
    load a font with fixed size
*/
Font* load_fixed_font(char *f, int off, int len, int w)
{
    int     i;
    Font    *fnt;
    char    path[512];

    get_full_font_path( path, f );

    fnt = malloc(sizeof(Font));
    if (fnt == 0) {
        fprintf(stderr, "ERR: sfnt_load: not enough memory\n");
        exit(1);
    }

    if ((fnt->pic = load_surf(path, SDL_HWSURFACE)) == 0)
        exit(1);
    /* use very first pixel as transparency key */
    SDL_SetColorKey( fnt->pic, SDL_SRCCOLORKEY, get_pixel( fnt->pic, 0, 0 ) );		

    fnt->align = ALIGN_X_LEFT | ALIGN_Y_TOP;
    fnt->color = 0x00FFFFFF;
    fnt->height = fnt->pic->h;
	
	fnt->offset = off;
	fnt->length = len;
	
	for (i = 0; i < len; i++)
	    fnt->char_width[i] = w;
	
    /* letter offsets */
    fnt->char_offset[0] = 0;
    for (i = 1; i < fnt->length; i++)	
        fnt->char_offset[i] = fnt->char_offset[i - 1] + w;
	
    /* allowed keys*/
    memset(fnt->keys, 0, 256);
    for (i = 0; i < fnt->length; i++) {
        fnt->keys[i + fnt->offset] = 1;
    }
	
    fnt->last_x = fnt->last_y = fnt->last_width = fnt->last_height = 0;
    return fnt;
}

/*
    free memory
*/
void free_font(Font **fnt)
{
    if ( *fnt ) {
        if ((*fnt)->pic) SDL_FreeSurface((*fnt)->pic);
        free(*fnt);
        *fnt = 0;
    }
}

/*
    write something with transparency
*/
int write_text(Font *fnt, SDL_Surface *dest, int x, int y, char *str, int alpha)
{
    int	c_abs;
    int len = strlen(str);
    int pix_len = 0;
    int px = x, py = y;
    int i;
    SDL_Surface *spf = SDL_GetVideoSurface();
	
    pix_len = text_width(fnt, str);
	for (i = 0; i < len; i++)
	    if (!fnt->keys[(int)str[i]])
	        str[i] = ' ';

    /* alignment */
    if (fnt->align & ALIGN_X_CENTER)
        px -= pix_len >> 1;
    else
        if (fnt->align & ALIGN_X_RIGHT)
            px -= pix_len;
    if (fnt->align & ALIGN_Y_CENTER)
        py -= (fnt->height >> 1 ) + 1;
    else
        if (fnt->align & ALIGN_Y_BOTTOM)
            py -= fnt->height;

    fnt->last_x = px; if (fnt->last_x < 0) fnt->last_x = 0;
    fnt->last_y = py; if (fnt->last_y < 0) fnt->last_y = 0;
    fnt->last_width = pix_len; if (fnt->last_x + fnt->last_width >= spf->w) fnt->last_width = spf->w - fnt->last_x;
    fnt->last_height = fnt->height; if (fnt->last_y + fnt->last_height >= spf->h) fnt->last_height = spf->h - fnt->last_y;

    if (alpha != 0)
        SDL_SetAlpha(fnt->pic, SDL_SRCALPHA, alpha);
    else
        SDL_SetAlpha(fnt->pic, 0, 0);
    for (i = 0; i < len; i++) {
       	c_abs = str[i] - fnt->offset;
       	DEST(dest, px, py, fnt->char_width[c_abs], fnt->height);
       	SOURCE(fnt->pic, fnt->char_offset[c_abs], 0);
       	blit_surf();
        px += fnt->char_width[c_abs];
    }
	
    return 0;
}

/*
====================================================================
Write string to x, y and modify y so that it draws to the 
next line.
====================================================================
*/
void write_line( SDL_Surface *surf, Font *font, char *str, int x, int *y )
{
    write_text( font, surf, x, *y, str, 255 );
    *y += font->height;
}

/*
    lock font surface
*/
inline void lock_font(Font *fnt)
{
    if (SDL_MUSTLOCK(fnt->pic))
        SDL_LockSurface(fnt->pic);
}

/*
    unlock font surface
*/
inline void unlock_font(Font *fnt)
{
    if (SDL_MUSTLOCK(fnt->pic))
        SDL_UnlockSurface(fnt->pic);
}
	
/*
    return last update region
*/
SDL_Rect last_write_rect(Font *fnt)
{
    SDL_Rect    rect={fnt->last_x, fnt->last_y, fnt->last_width, fnt->last_height};
    return rect;
}

/*
    return the text width in pixels
*/
int text_width(Font *fnt, char *str)
{
    unsigned int i;
    int pix_len = 0;
    for (i = 0; i < strlen(str); i++)
        pix_len += fnt->char_width[str[i] - fnt->offset];
    return pix_len;
}

int  char_width(Font *fnt, char c)
{
    return fnt->char_width[c - fnt->offset];
}

/* sdl */

/*
    initialize sdl
*/
void init_sdl( int f )
{
    /* check flags: if SOUND is not enabled flag SDL_INIT_AUDIO musn't be set */
#ifndef WITH_SOUND
    if ( f & SDL_INIT_AUDIO )
        f = f & ~SDL_INIT_AUDIO;
#endif

    sdl.screen = 0;
    if (SDL_Init(f) < 0) {
        fprintf(stderr, "ERR: sdl_init: %s", SDL_GetError());
        exit(1);
    }
    SDL_EnableUNICODE(1);
    atexit(SDL_Quit);
    /* create empty cursor */
    empty_cursor = create_cursor( 16, 16, 8, 8,
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                "
                                  "                " );
    std_cursor = SDL_GetCursor();
}

/*
    free screen
*/
void quit_sdl()
{
    if (sdl.screen) SDL_FreeSurface(sdl.screen);
    if ( empty_cursor ) SDL_FreeCursor( empty_cursor );
}

/*
====================================================================
Switch to passed video mode.
====================================================================
*/
int set_video_mode( int width, int height, int fullscreen )
{
#ifdef SDL_DEBUG
    SDL_PixelFormat	*fmt;
#endif
    int depth = 32;
    int flags = SDL_SWSURFACE;
    /* if screen does exist check if this is mayby exactly the same resolution */
    if ( sdl.screen ) {
        if ( sdl.screen->w == width && sdl.screen->h == height )
            if ( ( sdl.screen->flags & SDL_FULLSCREEN ) == fullscreen )
                return 1;
    }
    /* free old screen */
    if (sdl.screen) SDL_FreeSurface( sdl.screen ); sdl.screen = 0;
    /* set video mode */
    if ( fullscreen ) flags |= SDL_FULLSCREEN;
    if ( ( depth = SDL_VideoModeOK( width, height, depth, flags ) ) == 0 ) {
        fprintf( stderr, "Requested mode %ix%i, Fullscreen: %i unavailable\n",
                 width, height, fullscreen );
        sdl.screen = SDL_SetVideoMode( 640, 480, 16, SDL_SWSURFACE );
    }
    else
        if ( ( sdl.screen = SDL_SetVideoMode( width, height, depth, flags ) ) == 0 ) {
            fprintf(stderr, "%s", SDL_GetError());
            return 1;
        }

#ifdef SDL_DEBUG				
    if (f & SDL_HWSURFACE && !(sdl.screen->flags & SDL_HWSURFACE))
       	fprintf(stderr, "unable to create screen in hardware memory...\n");
    if (f & SDL_DOUBLEBUF && !(sdl.screen->flags & SDL_DOUBLEBUF))
        fprintf(stderr, "unable to create double buffered screen...\n");
    if (f & SDL_FULLSCREEN && !(sdl.screen->flags & SDL_FULLSCREEN))
        fprintf(stderr, "unable to switch to fullscreen...\n");

    fmt = sdl.screen->format;
    printf("video mode format:\n");
    printf("Masks: R=%i, G=%i, B=%i\n", fmt->Rmask, fmt->Gmask, fmt->Bmask);
    printf("LShft: R=%i, G=%i, B=%i\n", fmt->Rshift, fmt->Gshift, fmt->Bshift);
    printf("RShft: R=%i, G=%i, B=%i\n", fmt->Rloss, fmt->Gloss, fmt->Bloss);
    printf("BBP: %i\n", fmt->BitsPerPixel);
    printf("-----\n");
#endif    		
		
    return 0;
}

/*
    show hardware capabilities
*/
void hardware_cap()
{
    const SDL_VideoInfo	*vi = SDL_GetVideoInfo();
    char *ny[2] = {"No", "Yes"};

    printf("video hardware capabilities:\n");
    printf("Hardware Surfaces: %s\n", ny[vi->hw_available]);
    printf("HW_Blit (CC, A): %s (%s, %s)\n", ny[vi->blit_hw], ny[vi->blit_hw_CC], ny[vi->blit_hw_A]);
    printf("SW_Blit (CC, A): %s (%s, %s)\n", ny[vi->blit_sw], ny[vi->blit_sw_CC], ny[vi->blit_sw_A]);
    printf("HW_Fill: %s\n", ny[vi->blit_fill]);
    printf("Video Memory: %i\n", vi->video_mem);
    printf("------\n");
}

/*
    update rectangle (0,0,0,0)->fullscreen
*/
void refresh_screen(int x, int y, int w, int h)
{
    SDL_UpdateRect(sdl.screen, x, y, w, h);
    sdl.rect_count = 0;
}

/*
    draw all update regions
*/
void refresh_rects()
{
    if (sdl.rect_count == RECT_LIMIT)
        SDL_UpdateRect(sdl.screen, 0, 0, sdl.screen->w, sdl.screen->h);
    else
        if ( sdl.rect_count > 0 )
            SDL_UpdateRects(sdl.screen, sdl.rect_count, sdl.rect);
    sdl.rect_count = 0;
}

/*
    add update region/rect
*/
void add_refresh_region( int x, int y, int w, int h )
{
    if (sdl.rect_count == RECT_LIMIT) return;
    if (x < 0) {
        w += x;
        x = 0;
    }
    if (y < 0) {
        h += y;
        y = 0;
    }
    if (x + w > sdl.screen->w)
        w = sdl.screen->w - x;
    if (y + h > sdl.screen->h)
        h = sdl.screen->h - y;
    if (w <= 0 || h <= 0)
        return;
    sdl.rect[sdl.rect_count].x = x;
    sdl.rect[sdl.rect_count].y = y;
    sdl.rect[sdl.rect_count].w = w;
    sdl.rect[sdl.rect_count].h = h;
    sdl.rect_count++;
}
void add_refresh_rect( SDL_Rect *rect )
{
    if ( rect )
        add_refresh_region( rect->x, rect->y, rect->w, rect->h );
}

/*
    fade screen to black
*/
void dim_screen(int steps, int delay, int trp)
{
#ifndef NODIM
    SDL_Surface    *buffer;
    int per_step = trp / steps;
    int i;
    if (term_game) return;
    buffer = create_surf(sdl.screen->w, sdl.screen->h, SDL_SWSURFACE);
    SDL_SetColorKey(buffer, 0, 0);
    FULL_DEST(buffer);
    FULL_SOURCE(sdl.screen);
    blit_surf();
    for (i = 0; i <= trp; i += per_step) {
        FULL_DEST(sdl.screen);
        fill_surf(0x0);
        FULL_SOURCE(buffer);
        alpha_blit_surf(i);
        refresh_screen( 0, 0, 0, 0);
        SDL_Delay(delay);
    }
    if (trp == 255) {
        FULL_DEST(sdl.screen);
        fill_surf(0x0);
        refresh_screen( 0, 0, 0, 0);
    }
    SDL_FreeSurface(buffer);
#else
    refresh_screen( 0, 0, 0, 0);
#endif
}

/*
    undim screen
*/
void undim_screen(int steps, int delay, int trp)
{
#ifndef NODIM
    SDL_Surface    *buffer;
    int per_step = trp / steps;
    int i;
    if (term_game) return;
    buffer = create_surf(sdl.screen->w, sdl.screen->h, SDL_SWSURFACE);
    SDL_SetColorKey(buffer, 0, 0);
    FULL_DEST(buffer);
    FULL_SOURCE(sdl.screen);
    blit_surf();
    for (i = trp; i >= 0; i -= per_step) {
        FULL_DEST(sdl.screen);
        fill_surf(0x0);
        FULL_SOURCE(buffer);
        alpha_blit_surf(i);
        refresh_screen( 0, 0, 0, 0);
        SDL_Delay(delay);
    }
    FULL_DEST(sdl.screen);
    FULL_SOURCE(buffer);
    blit_surf();
    refresh_screen( 0, 0, 0, 0);
    SDL_FreeSurface(buffer);
#else
    refresh_screen( 0, 0, 0, 0);
#endif
}

/*
    wait for a key
*/
int wait_for_key()
{
    /* wait for key */
    SDL_Event event;
    while (1) {
        SDL_WaitEvent(&event);
        if (event.type == SDL_QUIT) {
            term_game = 1;
            return 0;
        }
        if (event.type == SDL_KEYUP)
            return event.key.keysym.sym;
    }
}

/*
    wait for a key or mouse click
*/
void wait_for_click()
{
    /* wait for key or button */
    SDL_Event event;
    while (1) {
        SDL_WaitEvent(&event);
        if (event.type == SDL_QUIT) {
            term_game = 1;
            return;
        }
        if (event.type == SDL_KEYUP || event.type == SDL_MOUSEBUTTONUP)
            return;
    }
}

/*
    lock surface
*/
inline void lock_screen()
{
    if (SDL_MUSTLOCK(sdl.screen))
        SDL_LockSurface(sdl.screen);
}

/*
    unlock surface
*/
inline void unlock_screen()
{
    if (SDL_MUSTLOCK(sdl.screen))
        SDL_UnlockSurface(sdl.screen);
}

/*
    flip hardware screens (double buffer)
*/
inline void flip_screen()
{
    SDL_Flip(sdl.screen);
}

/* cursor */

/* creates cursor */
SDL_Cursor* create_cursor( int width, int height, int hot_x, int hot_y, char *source )
{
    char *mask = 0, *data = 0;
    SDL_Cursor *cursor = 0;
    int i, j, k;
    char data_byte, mask_byte;
    int pot;

    /* meaning of char from source:
        b : black, w: white, ' ':transparent */

    /* create mask&data */
    mask = malloc( width * height * sizeof ( char ) / 8 );
    data = malloc( width * height * sizeof ( char ) / 8 );

    k = 0;
    for (j = 0; j < width * height; j += 8, k++) {

        pot = 1;
        data_byte = mask_byte = 0;
        /* create byte */
        for (i = 7; i >= 0; i--) {

            switch ( source[j + i] ) {

                case 'b':
                    data_byte += pot;
                case 'w':
                    mask_byte += pot;
                    break;

            }
            pot *= 2;

        }
        /* add to mask */
        data[k] = data_byte;
        mask[k] = mask_byte;

    }

    /* create and return cursor */
    cursor = SDL_CreateCursor( data, mask, width, height, hot_x, hot_y );
    free( mask );
    free( data );
    return cursor;
}

/*
    get milliseconds since last call
*/
int get_time()
{
    int ms;
    cur_time = SDL_GetTicks();
    ms = cur_time - last_time;
    last_time = cur_time;
    if (ms == 0) {
        ms = 1;
        SDL_Delay(1);
    }
    return ms;
}

/*
    reset timer
*/
void reset_timer()
{
    last_time = SDL_GetTicks();
}
