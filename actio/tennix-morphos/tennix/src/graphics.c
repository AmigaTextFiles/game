
/**
 *
 * Tennix! SDL Port
 * Copyright (C) 2003, 2007, 2008 Thomas Perl <thp@perli.net>
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
 * MA  02110-1301, USA.
 *
 **/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "tennix.h"
#include "graphics.h"

static Image* images;

static SDL_Surface *buffer;
static SDL_Surface *background;

static SDL_Rect *rect_update_cache;
static SDL_Rect *rect_update_old;
static int rect_update_cache_current;
static int rect_update_old_count;

static Uint32 fading_start = 0;

#include "data/graphics_data.c"
static const ResourceData graphics[] = {
    RESOURCE(court),
    RESOURCE(shadow),
    RESOURCE(player_racket),
    RESOURCE(ground),
    RESOURCE(ball),
    RESOURCE(menu),
    RESOURCE(smallish_font),
    RESOURCE(dkc2),
    RESOURCE(referee),
    RESOURCE(ctt_hard),
    RESOURCE(ctt_clay),
    RESOURCE(ctt_grass)
};

void init_graphics() {
    int i;
    SDL_Surface* data;
    SDL_Surface* tmp;

#ifndef MACOSX
    tmp = IMG_Load_RW( SDL_RWFromMem( icon, sizeof(icon)), 1);
    if( tmp != NULL) {
        SDL_WM_SetIcon( tmp, NULL);
        SDL_FreeSurface( tmp);
    }
#endif

    rect_update_cache = (SDL_Rect*)calloc(RECT_UPDATE_CACHE, sizeof(SDL_Rect));
    rect_update_old = (SDL_Rect*)calloc(RECT_UPDATE_CACHE, sizeof(SDL_Rect));
    rect_update_cache_current = 0;
    rect_update_old_count = 0;

    images = (Image*)calloc( GR_COUNT, sizeof( Image));

    for( i=0; i<GR_COUNT; i++) {
        tmp = IMG_Load_RW( SDL_RWFromMem( graphics[i].data, graphics[i].size), 1);
        if( !tmp) {
            fprintf( stderr, "Error: %s\n", SDL_GetError());
            continue;
        }

        if( GRAPHICS_IS_FONT(i)) {
            /* Convert to RGB w/ colorkey=black for opacity support */
            SDL_SetColorKey( tmp, SDL_SRCCOLORKEY | SDL_RLEACCEL, SDL_MapRGB( tmp->format, 0, 0, 0));
            data = SDL_ConvertSurface( tmp, screen->format, SDL_SRCCOLORKEY | SDL_RLEACCEL);
        } else {
            /* Convert to RGBA for alpha channel from PNG */
            data = SDL_DisplayFormatAlpha( tmp);
        }
        SDL_FreeSurface( tmp);

        if( !data) {
            fprintf( stderr, "Error: %s\n", SDL_GetError());
            continue;
        }
        images[i].data = data;
    }

    buffer = SDL_CreateRGBSurface(SDL_SWSURFACE, WIDTH, HEIGHT,
                 screen->format->BitsPerPixel,
                 screen->format->Rmask,
                 screen->format->Gmask,
                 screen->format->Bmask,
                 screen->format->Amask);

    background = SDL_CreateRGBSurface(SDL_SWSURFACE, WIDTH, HEIGHT,
                     screen->format->BitsPerPixel,
                     screen->format->Rmask,
                     screen->format->Gmask,
                     screen->format->Bmask,
                     screen->format->Amask);

    if( buffer == NULL) {
        fprintf( stderr, "Cannot create buffer surface: %s\n", SDL_GetError());
    }
}

void uninit_graphics() {
    int i;

    for( i=0; i<GR_COUNT; i++) {
        SDL_FreeSurface( images[i].data);
    }

    if( buffer != NULL) {
        SDL_FreeSurface( buffer);
    }

    if (background != NULL) {
        SDL_FreeSurface(background);
    }

    free(rect_update_cache);
    free(rect_update_old);
    free(images);
}

int get_image_width( image_id id) {
    return images[id].data->w;
}

int get_image_height( image_id id) {
    return images[id].data->h;
}

int get_sprite_width( image_id id, int items) {
    return images[id].data->w / items;
}

void show_sprite( image_id id, int pos, int items, int x_offset, int y_offset, int opacity) {
    SDL_Surface *bitmap;
    SDL_Rect src, dst;

    bitmap = images[id].data;

    if( !bitmap) return;

    SDL_SetAlpha( bitmap, SDL_SRCALPHA | SDL_RLEACCEL, opacity);

    dst.w = src.w = bitmap->w/items;
    dst.h = src.h = bitmap->h;
    src.x = src.w*pos;
    src.y = 0;
    dst.x = x_offset;
    dst.y = y_offset;

    SDL_BlitSurface( bitmap, &src, screen, &dst);
    update_rect2(dst);
}

void fill_image( image_id id, int x, int y, int w, int h) {
    SDL_Surface *bitmap;
    SDL_Rect src, dst;
    int dx = 0, dy = 0, cx, cy;

    if( id >= GR_COUNT) return;

    bitmap = images[id].data;
    src.x = src.y = 0;

    while( dy < h) {
        src.h = dst.h = cy = (h-dy > bitmap->h)?(bitmap->h):(h-dy);
        dst.y = y+dy;

        dx = 0;
        while( dx < w) {
            src.w = dst.w = cx = (w-dx > bitmap->w)?(bitmap->w):(w-dx);
            dst.x = x+dx;

            SDL_BlitSurface( bitmap, &src, screen, &dst);
            update_rect2(dst);

            dx += cx;
        }

        dy += cy;
    }
}

void line_horiz( int y, Uint8 r, Uint8 g, Uint8 b) {
    rectangle(0, y, screen->w, 1, r, g, b);
}

void line_vert( int x, Uint8 r, Uint8 g, Uint8 b) {
    rectangle(x, 0, 1, screen->h, r, g, b);
}

void rectangle( int x, int y, int w, int h, Uint8 r, Uint8 g, Uint8 b) {
    Uint32 color = SDL_MapRGB( screen->format, r, g, b);
    SDL_Rect rect;

    rect.x = x;
    rect.y = y;
    rect.w = w;
    rect.h = h;

    SDL_FillRect( screen, &rect, color);
    update_rect(x, y, w, h);
}

void draw_button( int x, int y, int w, int h, Uint8 r, Uint8 g, Uint8 b, char pressed) {
    float diff = (pressed?1.0-BUTTON_HIGHLIGHT:1.0+BUTTON_HIGHLIGHT);
    int border = BUTTON_BORDER;
    rectangle( x, y, w, h, r*diff, g*diff, b*diff);
    rectangle( x+border, y+border, w-border, h-border, r/diff, g/diff, b/diff);
    rectangle( x+border, y+border, w-2*border, h-2*border, r, g, b);
}

void draw_button_text( char* s, int x, int y, int w, int h, Uint8 r, Uint8 g, Uint8 b, char pressed) {
    int font_x, font_y;
    pressed = pressed?1:0;
    draw_button( x, y, w, h, r, g, b, pressed);
    font_x = x + w/2 - font_get_string_width( GR_SMALLISH_FONT, s)/2 + pressed*BUTTON_BORDER;
    font_y = y + h/2 - get_image_height( GR_SMALLISH_FONT)/2 + pressed*BUTTON_BORDER;
    font_draw_string( GR_SMALLISH_FONT, s, font_x, font_y, 0, 0);
}

void show_image( image_id id, int x_offset, int y_offset, int opacity) {
    show_sprite( id, 0, 1, x_offset, y_offset, opacity);
}

void clear_screen()
{
    SDL_Rect rect;

    rect.x = rect.y = 0;
    rect.w = WIDTH;
    rect.h = HEIGHT;

    SDL_FillRect(screen, &rect, SDL_MapRGB(screen->format, 0, 0, 0));
    store_screen();
}

void store_screen()
{
    SDL_BlitSurface(screen, NULL, background, NULL);
    rect_update_old[0].x = rect_update_old[0].y = 0;
    rect_update_old[0].w = WIDTH;
    rect_update_old[0].h = HEIGHT;
    rect_update_old_count = 1;
    rect_update_cache_current = 0;
}

void reset_screen()
{
    int i;
    SDL_Rect* tmp;
    SDL_BlitSurface(background, NULL, screen, NULL);

    for (i=0; i<rect_update_cache_current; i++) {
        SDL_BlitSurface(background, &rect_update_cache[i], screen, &rect_update_cache[i]);
    }

    /* Save rects I've just updated for redraw later */
    tmp = rect_update_cache;
    rect_update_cache = rect_update_old;
    rect_update_old = tmp;
    rect_update_old_count = rect_update_cache_current;
    rect_update_cache_current = 0;
}

void update_rect(Sint32 x, Sint32 y, Sint32 w, Sint32 h)
{
    //rectangle(x, y, w, h, 50+rand()%200, 50+rand()%200 ,50+rand()%200);

    if (x >= WIDTH || y >= HEIGHT || x+w <= 0 || y+h <= 0) {
        return;
    }

    if (rect_update_cache_current == RECT_UPDATE_CACHE) {
        fprintf(stderr, "Overflow\n");
        rect_update_cache_current = 0;
    }

    SDL_Rect* u = &(rect_update_cache[rect_update_cache_current]);

    if (x < 0 && x+w > 0) {
        w += x;
        x = 0;
    }
    if (y < 0 && y+h > 0) {
        h += y;
        y = 0;
    }

    if (x+w >= WIDTH) {
        w -= (x+w-WIDTH+1);
    }
    
    if (y+h >= HEIGHT) {
        h -= (y+h-HEIGHT+1);
    }

    if (w==0 || h==0) {
        return;
    }

    u->x = x;
    u->y = y;
    u->w = w;
    u->h = h;

    rect_update_cache_current++;
}

void updatescr()
{
    int ticks = SDL_GetTicks();

    static int fading_last_time = 0;
    int fading_now = is_fading();

    if (fading_now) {
        SDL_SetAlpha(buffer, SDL_SRCALPHA | SDL_RLEACCEL, 255-255*(ticks-fading_start)/FADE_DURATION);
        SDL_BlitSurface(buffer, NULL, screen, NULL);
        SDL_UpdateRect(screen, 0, 0, 0, 0);
    } else if (fading_last_time && !fading_now) {
        SDL_UpdateRect(screen, 0, 0, 0, 0);
    } else {
        SDL_UpdateRects(screen, rect_update_old_count, rect_update_old);
        SDL_UpdateRects(screen, rect_update_cache_current, rect_update_cache);
    }

    reset_screen();
    fading_last_time = fading_now;
}

void start_fade() {
    SDL_BlitSurface( screen, NULL, buffer, NULL);
    fading_start = SDL_GetTicks();
}

int is_fading() {
    return SDL_GetTicks() < fading_start+FADE_DURATION;
}

int font_get_metrics( image_id id, char ch, int* xp, int* wp) {
    SDL_Surface *bitmap;
    int pos, x = -1, w = 0;
    int search_pos = 0, search_x = 0;
    Uint8 red, green, blue;

    if( id >= GR_COUNT) return 0;

    pos = toupper( ch) - ' '; /* ' ' = first character in font bitmap */

    bitmap = images[id].data;

    SDL_LockSurface( bitmap);
    while( search_x < bitmap->w) {
        GET_PIXEL_RGB( bitmap, search_x, 0, &red, &green, &blue);

        /* Increase pos counter if we have a "marker" pixel (255,0,255) */
        if( red > 250 && green < 10 && blue > 250) {
            search_pos++;
            if( search_pos == pos) {
                x = search_x;
            } else if( search_pos == pos + 1) {
                w = search_x - x;
                break;
            }
        }

        search_x++;
    }
    SDL_UnlockSurface( bitmap);

    if( wp != NULL) (*wp) = w;
    if( xp != NULL) (*xp) = x;

    return w;
}

int font_draw_char( image_id id, char ch, int x_offset, int y_offset) {
    SDL_Surface *bitmap;
    SDL_Rect src, dst;
    int x = -1, w = 0;

    font_get_metrics( id, ch, &x, &w);
    if( x == -1) return w;

    bitmap = images[id].data;

    dst.w = src.w = w;
    dst.h = src.h = bitmap->h - 1;
    src.x = x;
    src.y = 1;
    dst.x = x_offset;
    dst.y = y_offset;

    SDL_BlitSurface( bitmap, &src, screen, &dst);

    return src.w;
}

void font_draw_string_alpha( image_id id, const char* s, int x_offset, int y_offset, int start, int animation, int opacity) {
    int y = y_offset;
    int x = x_offset;
    int i, additional_x = 0, additional_y = 0;
    float xw = 0.0, xw_diff;
    SDL_Surface *bitmap;

    if( id > GR_COUNT) return;

    bitmap = images[id].data;
    SDL_SetAlpha( bitmap, SDL_SRCALPHA | SDL_RLEACCEL, opacity);

    if( animation & ANIMATION_BUNGEE) {
        xw = (25.0*sinf( start/10.0));
        xw_diff = 0.0;
        x -= xw / 2;
    }

    if( animation & ANIMATION_PENDULUM) {
        x -= (int)(20.0*sinf( start/20.0));
        additional_x += 21;
    }

    for( i=0; i<strlen(s); i++) {
        if( animation & ANIMATION_WAVE) {
            y = y_offset + (int)(3.0*sinf( start/10.0 + x/30.0));
        }
        x += font_draw_char( id, s[i], x, y);
        if( animation & ANIMATION_BUNGEE) {
            xw_diff += xw/strlen(s);
            if( xw_diff > 1.0 || xw_diff < -1.0) {
                x += (int)(xw_diff);
                if( xw_diff > 1.0) {
                    xw_diff -= 1.0;
                } else {
                    xw_diff += 1.0;
                }
            }
        }
    }
    if (animation & ANIMATION_WAVE) {
        additional_y += 4;
    }
    if (animation & ANIMATION_BUNGEE) {
        additional_x += 26;
    }
    update_rect(x_offset-additional_x, y_offset-additional_y, x-x_offset+additional_x*2, get_image_height(id)+additional_y*2);
}

int font_get_string_width( image_id id, const char* s) {
    int w = 0, i;

    for( i=0; i<strlen(s); i++) {
        w += font_get_metrics( id, s[i], NULL, NULL);
    }

    return w;
}

void draw_line_faded( int x1, int y1, int x2, int y2, int r, int g, int b, int r2, int g2, int b2) {
    float step, dx, dy, x = x1, y = y1;
    int i;
    char fade = (r!=r2 || g!=g2 || b!=b2);

    step = (float)(abs(x2-x1)>abs(y2-y1)?abs(x2-x1):abs(y2-y1));
    dx = (float)(x2-x1) / step;
    dy = (float)(y2-y1) / step;

    SDL_LockSurface( screen);
    for( i=0; i<step; i++) {
        x += dx;
        y += dy;
        if( x < 0.0 || x >= WIDTH || y < 0.0 || y >= HEIGHT) {
            continue;
        }
        if( fade) {
            SET_PIXEL_RGB( screen, (int)x, (int)y, (r*(step-i)+r2*i)/step, (g*(step-i)+g2*i)/step, (b*(step-i)+b2*i)/step);
        } else {
            SET_PIXEL_RGB( screen, (int)x, (int)y, r, g, b);
        }
    }
    SDL_UnlockSurface( screen);
}

