/***************************************************************************
                          main.c  -  description
                             -------------------
    begin                : Mit Jan 17 16:03:18 CET 2001
    copyright            : (C) 2001 by Michael Speck
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

#ifdef HAVE_CONFIG_H
#include "../config.h"
#endif

#include "lgeneral.h"
#include "parser.h"
#include "event.h"
#include "date.h"
#include "nation.h"
#include "unit.h"
#include "file.h"
#include "map.h"
#include "scenario.h"
#include "campaign.h"
#include "engine.h"

int term_game = 0;
extern Sdl sdl;
extern Config config;
extern SDL_Cursor *empty_cursor;
extern Setup setup;

static void show_title()
{
    int dummy;
    Font *font = 0;
    SDL_Surface *back = 0;
    if ( ( back = load_surf( "title.bmp", SDL_SWSURFACE ) ) ) {
        FULL_DEST( sdl.screen );
        FULL_SOURCE( back );
        blit_surf();
    }
    if ( ( font = load_fixed_font( "font_credit.bmp", 32, 96, 8 ) ) ) {
        font->align = ALIGN_X_RIGHT | ALIGN_Y_BOTTOM;
        write_text( font, sdl.screen, sdl.screen->w - 2, sdl.screen->h - 2, "(C) 2001-2004 Michael Speck", 255 );
        font->align = ALIGN_X_LEFT | ALIGN_Y_BOTTOM;
        write_text( font, sdl.screen, 2, sdl.screen->h - 2, "http://lgames.sf.net", 255 );
    }
    refresh_screen( 0, 0, 0, 0 );
    /* wait */
    SDL_PumpEvents(); event_clear();
    while ( !event_get_buttonup( &dummy, &dummy, &dummy ) ) { SDL_PumpEvents(); SDL_Delay( 20 ); }
    event_clear();
}

int main(int argc, char *argv[])
{
    char window_name[32];
            
    /* display some credits */
    printf( "LGeneral %s\nCopyright 2001-2005 Michael Speck\nPublished under GNU GPL\n---\n", VERSION );
    printf( "Looking up data in: %s\n", SRC_DIR );
#ifndef WITH_SOUND
    printf( "Compiled without sound and music\n" );
#endif

    /* check config directory path and load config */
    check_config_dir_name();
    load_config();

    /* init sdl */
    init_sdl( SDL_INIT_VIDEO | SDL_INIT_TIMER | SDL_INIT_AUDIO );
    set_video_mode( 640, 480, 0 );
    sprintf( window_name, "LGeneral %s", VERSION );
    SDL_WM_SetCaption( window_name, 0 );
    event_enable_filter();
    
    /* show lgeneral title */
    show_title();
    
    /* switch to configs resolution */
    set_video_mode( config.width, config.height, config.fullscreen );

#ifdef WITH_SOUND
    /* initiate audio device */
    audio_open();
    audio_enable( config.sound_on );
    audio_set_volume( config.sound_volume );
#endif

    /* set random seed */
    set_random_seed();
    
    engine_create();
    SDL_SetCursor( empty_cursor );
    engine_run();
    engine_delete();

#ifdef WITH_SOUND
    /* close audio device */
    audio_close();
#endif

    /* save settings */
    save_config();

    event_disable_filter();
    
    return 0;
}
