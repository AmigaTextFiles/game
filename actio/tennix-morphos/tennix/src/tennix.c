
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
#include <time.h>
#include <libgen.h>

#ifdef WIN32
#include <windows.h>
#endif

#ifndef M_PI
#define M_PI		3.14159265358979323846	/* pi */
#endif

#include "tennix.h"
#include "game.h"
#include "graphics.h"
#include "sound.h"
#include "input.h"

SDL_Surface *screen;

static const char* help_text[] = {
    "player 1 moves with <w>, <s> and <d>",
    "player 2 moves with <o>, <l> and <k>",
    "switch court in game with <c>, pause with <p>",
    "" /* joystick help text comes here */,
#ifdef ENABLE_MOUSE
    "press left mouse button to move racket",
    "release left mouse button to swing racket",
#endif
};

/* Number of lines in help_text */
#ifdef ENABLE_MOUSE
  #define HELP_LINES 6
#else
  #define HELP_LINES 4
#endif
/* Height (in pixels) of the help text scroller */
#define HELP_PHASE 85

#ifdef WIN32

/* IDs from the resource file */
#define START_BUTTON 1
#define CHECKBOX_FULLSCREEN 2
#define QUIT_BUTTON 3

BOOL CALLBACK ConfigDialogProc(HWND hwndDlg, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    static int checkbox_is_checked;

    switch (uMsg) {
        case WM_CLOSE:
            EndDialog(hwndDlg, IDCANCEL);
            break;
        case WM_COMMAND:
            switch (wParam) {
                case START_BUTTON:
                    EndDialog(hwndDlg, (checkbox_is_checked)?(IDYES):(IDNO));
                    break;
                case QUIT_BUTTON:
                    EndDialog(hwndDlg, IDCANCEL);
                    break;
                case CHECKBOX_FULLSCREEN:
                    checkbox_is_checked ^= 1;
                    break;
            }
            break;
        default:
            return FALSE;
    }
    return TRUE;
}
#endif

#ifdef WIN32
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, 
    LPSTR lpCmdLine, int nCmdShow) {
#else
int main( int argc, char** argv) {
#endif
    int i;
    int mx, my;
    Uint8 *keys;
    Uint8 mb;
    SDL_Event e;
    int sdl_flags = SDL_SWSURFACE;
    int highlight_y = 0;
    char copyright_line[100];
    int copyright_line_width;
    int help, help_line_widths[HELP_LINES], help_line_height, help_offset;

    Point elektrons[ELEKTRONS];
    int el;

#ifdef WIN32
    int mb_result;
    mb_result = DialogBox(hInstance, "CONFIG", 0, (DLGPROC)ConfigDialogProc);

    switch (mb_result) {
        case IDYES:
            sdl_flags |= SDL_FULLSCREEN;
            break;
        case IDCANCEL:
            return 0;
            break;
        default:
            break;
    }
#else
    fprintf( stderr, "Tennix %s\n%s\n%s\n\n", VERSION, COPYRIGHT, URL);

    bool do_help = false;
    i = 1;
    while (i < argc) {
        /* A poor/lazy man's getopt */
        #define OPTION_SET(longopt,shortopt) \
                (strcmp(argv[i], longopt)==0 || strcmp(argv[i], shortopt)==0)
        #define OPTION_VALUE \
                ((i+1 < argc)?(argv[i+1]):(NULL))
        #define OPTION_VALUE_PROCESSED \
                (i++)
        if (OPTION_SET("--fullscreen", "-f")) {
            sdl_flags |= SDL_FULLSCREEN;
        }
        else if (OPTION_SET("--help", "-h")) {
            do_help = true;
        }
        else if (OPTION_SET("--list-joysticks", "-J")) {
            SDL_Init(SDL_INIT_JOYSTICK);
            joystick_list();
            return 0;
        }
        else if (OPTION_SET("--joystick", "-j")) {
            SDL_Init(SDL_INIT_JOYSTICK);
            if (OPTION_VALUE == NULL) {
                fprintf(stderr, "Error: You need to specify the name of the joystick as parameter.\n");
                do_help = true;
                break;
            }
            if (joystick_open(OPTION_VALUE)==0) {
                fprintf(stderr, "Warning: Cannot find joystick \"%s\" - Ignored.\n", OPTION_VALUE);
                break;
            }
            OPTION_VALUE_PROCESSED;
        }
        else {
            fprintf(stderr, "Ignoring unknown option: %s\n", argv[i]);
        }
        i++;
    }

    if (do_help == true) {
        fprintf(stderr, "Usage: %s [--fullscreen|-f] [--help|-h] [--list-joysticks|-J] [--joystick|-j] [joystick name]\n", argv[0]);
        return 0;
    }
#endif

    sprintf( copyright_line, "Tennix %s -- %s", VERSION, COPYRIGHT);

    srand( (unsigned)time( NULL));

    for( el=0; el<ELEKTRONS; el++) {
        elektrons[el].x = elektrons[el].y = 0;
        elektrons[el].w = 50+(rand()%120);
        elektrons[el].h = 10+(rand()%10);
        elektrons[el].current_x = WIDTH/2;
        elektrons[el].current_y = HEIGHT/2;
        elektrons[el].new_x = rand()%WIDTH;
        elektrons[el].new_y = rand()%HEIGHT;
        elektrons[el].phase = 4*2*PI*((rand()%1000)/1000.0);
        elektrons[el].r = 100+rand()%155;
        elektrons[el].g = 100+rand()%155;
        elektrons[el].b = 0;
        elektrons[el].size = 0;
        elektrons[el].new_size = 5+rand()%10;
    }
   
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_JOYSTICK) == -1) {
        fprintf( stderr, "Can't init SDL:  %s\n", SDL_GetError());
        exit( 1);
    }

    SDL_VideoInfo* vi = (SDL_VideoInfo*)SDL_GetVideoInfo();
    if( (screen = SDL_SetVideoMode( WIDTH, HEIGHT, vi->vfmt->BitsPerPixel, sdl_flags)) == NULL) {
        fprintf( stderr, "Can't set video mode: %s\n", SDL_GetError());
        exit( 1);
    }   

    SDL_WM_SetCaption( "Tennix! SDL", "Tennix");
    SDL_ShowCursor( SDL_DISABLE);
    SDL_EnableKeyRepeat (SDL_DEFAULT_REPEAT_DELAY, 1);

    init_sound();
    init_graphics();
    init_joystick();
    help_text[3] = get_joystick_help();

    play_sample_background(SOUND_BACKGROUND);

    copyright_line_width = font_get_string_width( GR_DKC2_FONT, copyright_line);
    for( help=0; help<HELP_LINES; help++) {
        help_line_widths[help] = font_get_string_width( GR_SMALLISH_FONT, help_text[help]);
    }
    help_line_height = get_image_height( GR_SMALLISH_FONT);

    clear_screen();
    show_image(GR_MENU, WIDTH/2-get_image_width(GR_MENU)/2, 0, 255);
    store_screen();
   
    i = 0;
    while( 1) {
        SDL_PollEvent( &e);
        if( e.type == SDL_QUIT) {
            break;
        }
        keys = SDL_GetKeyState( NULL);
        mb = SDL_GetMouseState( &mx, &my);
   
        if( keys[SDLK_ESCAPE] || keys['q']) {
            break;
        }

        if( keys['f']) {
            SDL_WM_ToggleFullScreen( screen);
        }
   
        if( highlight_y) {
            for( el=0; el<ELEKTRONS; el++) {
                elektrons[el].new_x = WIDTH/2 - ELEKTRONS_WIDTH;
                elektrons[el].new_y = highlight_y;
                if( elektrons[el].new_size >= 5) {
                    elektrons[el].new_size = 1+rand()%4;
                }
            }
        }
        
        for( el=0; el<ELEKTRONS; el++) {
            elektrons[el].current_x += (1.0*(elektrons[el].new_x-elektrons[el].current_x)/ELEKTRON_LAZYNESS);
            elektrons[el].current_y += (1.0*(elektrons[el].new_y-elektrons[el].current_y)/ELEKTRON_LAZYNESS);
            if( i%4==0 && elektrons[el].size < elektrons[el].new_size) {
                elektrons[el].size++;
            }
            if( i%4==0 && elektrons[el].size > elektrons[el].new_size) {
                elektrons[el].size--;
            }
            elektrons[el].phase += 0.02+(rand()%20/100.0);
            elektrons[el].x = elektrons[el].current_x + ELEKTRONS_WIDTH + elektrons[el].w*cosf(elektrons[el].phase/4);
            elektrons[el].y = elektrons[el].current_y + elektrons[el].h*sinf(elektrons[el].phase);
        }

        if( M_POS_START_GAME(mx,my)) {
            highlight_y = HIGHLIGHT_START_GAME;
        } else if( M_POS_START_MULTI(mx,my)) {
            highlight_y = HIGHLIGHT_START_MULTI;
        /*} else if( M_POS_CREDITS(mx,my)) {
            highlight_y = HIGHLIGHT_CREDITS;
        */} else if( M_POS_QUIT(mx,my)) {
            highlight_y = HIGHLIGHT_QUIT;
        } else if( highlight_y == 0) {
            if( i%20 == 0) {
                for( el=0; el<ELEKTRONS; el++) {
                    elektrons[el].new_size = 5+rand()%10;
                }
            }
        } else {
            for( el=0; el<ELEKTRONS; el++) {
                elektrons[el].new_x = rand()%(WIDTH-ELEKTRONS_WIDTH-elektrons[el].w/2);
                elektrons[el].new_y = rand()%HEIGHT;
                elektrons[el].new_size = 5+rand()%10;
            }
            highlight_y = 0;
        }

        for( el=0; el<ELEKTRONS; el++) {
            if( elektrons[el].size > 0) {
                rectangle( elektrons[el].x, elektrons[el].y, elektrons[el].size, elektrons[el].size, elektrons[el].r, elektrons[el].g, elektrons[el].b);
                if( elektrons[el].size > 4) {
                    if( highlight_y != 0 || rand()%10 == 0) {
                        //draw_line_faded( elektrons[el].x+elektrons[el].size/2, elektrons[el].y+elektrons[el].size/2, mx+15, my+24, elektrons[el].r/3, elektrons[el].g/3, 0, 0 ,0 ,0);
                    }
                    rectangle( elektrons[el].x+2, elektrons[el].y+2, elektrons[el].size-4, elektrons[el].size-4, 0, 0, 0);
                }
            }
        }

        font_draw_string( GR_DKC2_FONT, copyright_line, (WIDTH-copyright_line_width)/2, HEIGHT-35, i, ((i/150)%ANIMATION_COUNT));
        for( help=0; help<HELP_LINES; help++) {
            help_offset = (help_line_height*(HELP_LINES-help)+i/3)%HELP_PHASE;
            font_draw_string_alpha( GR_SMALLISH_FONT, help_text[help],
                                    (WIDTH-help_line_widths[help])/2,
                                    HEIGHT/2+45-help_offset,
                                    i, ANIMATION_NONE,
                                    255.0*fabsf( sinf( help_offset/((float)HELP_PHASE)*M_PI))
                                  );
        }
        show_sprite( GR_RACKET, ((mb&SDL_BUTTON( SDL_BUTTON_LEFT))>0)+(((mb&SDL_BUTTON( SDL_BUTTON_RIGHT))>0)*2), 4, mx, my, 255);
        updatescr();

        if( mb & SDL_BUTTON( SDL_BUTTON_LEFT)) {
            if( M_POS_START_GAME(mx,my)) {
                stop_sample(SOUND_BACKGROUND);
                play_sample_loop(SOUND_AUDIENCE);
                start_fade();
                game( true);
                SDL_Delay( 150);
                start_fade();
                while( SDL_PollEvent( &e));
                stop_sample(SOUND_AUDIENCE);
                play_sample_background(SOUND_BACKGROUND);
                clear_screen();
                show_image(GR_MENU, WIDTH/2-get_image_width(GR_MENU)/2, 0, 255);
                store_screen();
            }   
            if( M_POS_START_MULTI(mx,my)) {
                stop_sample(SOUND_BACKGROUND);
                play_sample_loop(SOUND_AUDIENCE);
                start_fade();
                game( false);
                SDL_Delay( 150);
                start_fade();
                while( SDL_PollEvent( &e));
                stop_sample(SOUND_AUDIENCE);
                play_sample_background(SOUND_BACKGROUND);
                clear_screen();
                show_image(GR_MENU, WIDTH/2-get_image_width(GR_MENU)/2, 0, 255);
                store_screen();
            }
            if( M_POS_CREDITS(mx,my)) {
                //introimage( "data/credits.bmp");
            }
            if( M_POS_QUIT(mx,my)) {
                stop_sample(SOUND_BACKGROUND);
                break;
            }
        }
        i++;
        SDL_Delay( 4);
    }

    start_fade();
    store_screen();
    while( is_fading()) {
        clear_screen();
        updatescr();
        SDL_Delay( 10);
    }
   
    uninit_graphics();
    uninit_joystick();

    SDL_Quit();
    return 0;
}

