/***************************************************************************
                          manager.c  -  description
                             -------------------
    begin                : Thu Sep 20 2001
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

/* Added Slow-Mode, Edgar Schwan, eds@rz-online.de, Mar 08 2005 */

#ifdef HAVE_CONFIG_H
#include "../config.h"
#endif

#include "ltris.h"
#include "manager.h"
#include "chart.h"
#include "event.h"
#include "hint.h"

#ifdef _1
#include "levels.h"
#endif

extern Sdl sdl;
extern Config config;
extern List *menus; /* list of menus from menu.c */
int menu_x = 30, menu_y = 180, menu_w = 260, menu_h = 280, menu_border = 16; /* default region where menu is displayed centered */
int cx = 350, cy = 190, cw = 260, ch = 200; /* center charts here */
int vx = 350, vy = 420, vw = 260, vh = 30; /* version number of url */
Menu *cur_menu; /* current menu */
SDL_Surface *mbkgnd = 0; /* menu background */
Font *mfont = 0, *mhfont = 0, *mcfont = 0; /* font, highlight font, caption font */
int gap_height = 2;
#ifdef _1
extern char **levelset_names;
extern int levelset_count;
extern char **levelset_home_names;
extern int levelset_home_count;
#endif
extern int term_game;
#ifdef SOUND
Sound_Chunk *wav_menu_click = 0;
Sound_Chunk *wav_menu_motion = 0;
#endif
/* some items we need to know to assign name lists later */
Item *item_levelset, *item_set;
extern List *charts;
int chart_id = 0; /* current chart displayed */
extern char *gametype_names[7];

/*
====================================================================
Hint strings for the menu.
====================================================================
*/
#define HINT_ 0
#define HINT_QHELP "Enable/disable these quick hints."
#define HINT_CTRLS "Set player controls and horizontal speed."
#define HINT_GFX   "Here you may customize the graphical appearance of LTris."
#define HINT_AUDIO "Audio Settings."
#define HINT_QUIT "Get back to nasty work."
#define HINT_NEWGAME "Setup and run a cool game!"
#define HINT_ANIM "If animations disturb you you may turn them off."
#define HINT_DISPLAY "You may play LTris either in window of fullscreen mode."
#define HINT_FPS "If you don't want LTris to consume all of your CPU limit the frame rate."
#define HINT_SMOOTHHORI "Horizontally move block either tile-by-tile or smooth. This is just eye-candy and doesn't effect the moving speed at all."
#define HINT_SMOOTHVERT "Drop block tile-by-tile or smooth.##NOTE: While tile-by-tile allows you to move a block below a tile multiple times you'll only be able to do so one time when choosing 'smooth'!#See 'Advanced Options/Collision Check' to improve this."
#define HINT_HORIDEL "The less delay you take the faster the block will horizontally move and the more sensitive the input is handled."
#define HINT_CONTROLS "Each control value needs a unique key for handling.##Left/Right: horizontal movement#Rotate Left/Right: block rotation#Down: faster Dropping#Drop: INSTANT drop"
#define HINT_START "Let's get it on!!!!"
#define HINT_NAME "Human player names. If you play against CPU it will be named as CPU-x."
#define HINT_STARTLEVEL "This is your starting level which will be ignored for game 'Figures' (you'll always start at level 0 there).##Each starting level up adds you 1.5% score in the end!"
#define HINT_PREVIEW "Enable/Disable block preview.##If disabled you'll gain 15% score in the end!"
#define HINT_HELP "Shows guiding lines or a shadow of the currently dropping block so you see where it'll hit the ground.##This option has no malus/bonus."
#define HINT_MPMENU "Some multiplayer and CPU settings."
#define HINT_HOLES "A line send to your oppponent's bowl will have this number of holes in it. The more holes the harder it will be to remove this line so you should choose a low value (e.g. 1 or 2) for long multiplayer games."
#define HINT_SENDALL "You'll have to complete more than one line to send any lines to your opponent. If this option is enabled all lines will be send else one will be substracted.##If disabled:#3 Line send -> 2 lines received##If enabled:#3 lines send -> 3lines received"
#define HINT_SENDTETRIS "You this option is enabled your opponent will receive all four lines of your tetris ignoring the 'Send All' setting."
#define HINT_CPUDROP "This is the delay in milliseconds the CPU waits before dropping a block."
#define HINT_CPUAGGR "The more aggressive the style is the more priority is put on completing multiple lines at the expense of a balanced bowl contents."
#define HINT_ADV "Some advanced options."
#define HINT_CPUALG "Test the CPU analyze algorithm in cpu.c and give an average score for a number of games."
#define HINT_VIS "If you turn visualization off the results will be computed faster. If you turn them on you can see a general game behaviour and judge the algorithm by this behaviour."
#define HINT_GAME "There are basically three different game types:##CLASSIC:#The classic tetris game. Starts with an empty bowl and goes "\
                  "as long as you make it.#FIGURES:#Each level a nice figure will be added to the ground of you bowl. From level "\
                  "7-12 there will be randomly appearing single tiles and from level 13-... there will be whole lines appearing at the "\
                  "bottom of your bowl. Fun!#TWO/THREE-PLAYER:#Either play against other humans or CPU. If you complete multiple lines they'll "\
                  "be send to your opponents according to the multiplayer settings you made.##"\
                  "And in DEMO you can see your CPU do the work. So relax! ;-)"
#define HINT_BKGND "If you turn this on the background will change every level else it's always the same."
#define HINT_KEYSTATE "If you enable this option the keystate of the 'Down' key is cleared so you can't accidently move the next block."
#define HINT_CENTERPREVIEW "If this is enabled the preview in Two-Player is centered in the middle of the screen instead that one is drawn at the bottom and one at the top."
#define HINT_COL_CHECK "This option is only useful when 'Graphics/Drop' is 'Smooth'#"\
                       "(In opposite to 'Tile-By-Tile' the block is inserted as soon as it "\
                       "hits the ground giving no possibility to move the block below another "\
                       "one.)#If you set this option to 'Async' you may move the block below others but "\
                       "on the cost of slight graphical errors."
#define HINT_EXPERT "In expert mode the propabilities for the next blocks are uneven to give a " \
		       "block that is most likely difficult to fit anywhere. The game becomes " \
		       "really hard by this so all score is doubled in the end."
#define HINT_SAME "If ON all players will get exactly the same blocks. So there is no disadvantage to any player due to random blocks. This does not work in expert mode as the block selection depends on your actions there."
#ifdef SLOW_MODE
#define HINT_SLOW "If you set this option to 'On', the speed increases less fast."
#endif /* SLOW_MODE */

/*
====================================================================
Callbacks of menu items.
====================================================================
*/
/* Disable/enable sound */
void cb_sound() {
#ifdef SOUND
    sound_enable( config.sound );
#endif
}
/* set volume */
void cb_volume() {
#ifdef SOUND
    sound_volume( config.volume * 16 );
#endif
}
/* toggle fullscreen */
void cb_fullscreen() {
    manager_show();
}
#ifdef _1
/* delete set */
void cb_delete_set()
{
    char fname[512];
    /* do not delete <CREATE SET> file */
    if ( strequal( "<CREATE SET>", levelset_home_names[config.levelset_home_id] ) ) {
        printf( "You cannot delete '<CREATE SET>'!\n" );
        return;
    }
    /* get file name + path */
    snprintf( fname, sizeof(fname)-1, "%s/%s/levels/%s", getenv( "HOME" ), CONFIG_DIR_NAME, levelset_home_names[config.levelset_home_id] );
    remove( fname );
    levelsets_load_names(); /* reinit name lists and configs indices */
    /* reassign these name lists as position in memory has changed */
    value_set_new_names( item_levelset->value, levelset_names, levelset_count );
    value_set_new_names( item_set->value, levelset_home_names, levelset_home_count );
}
/* adjust set list */
void cb_adjust_set_list()
{
    /* reinit name lists and configs indices */
    levelsets_load_names();
    /* reassign these name lists as position in memory has changed */
    value_set_new_names( item_levelset->value, levelset_names, levelset_count );
    value_set_new_names( item_set->value, levelset_home_names, levelset_home_count );
}
/* set cpu difficulty stuff */
void cb_cpu_diff()
{
    switch ( config.cpu_diff ) {
        case 0: 
            config.cpu_delay = 3500;
            config.cpu_rot_delay = 100;
            break;
        case 1: 
            config.cpu_delay = 2000;
            config.cpu_rot_delay = 100;
            break;
        case 2:
            config.cpu_delay = 1000;
            config.cpu_rot_delay = 100;
            break;
        case 3:
            config.cpu_delay = 500;
            config.cpu_rot_delay = 100;
            break;
        case 4:
            config.cpu_delay = 0;
            config.cpu_rot_delay = 100;
            break;
        case 5:
            config.cpu_delay = 0;
            config.cpu_rot_delay = 100;
            break;
    }
}
#endif
/* if hints where disabled hide actual hint */
void cb_hints()
{
    if ( !config.quick_help )
        hint_set( 0 );
}

/*
====================================================================
Load/delete background and create and link all menus
====================================================================
*/
void manager_create()
{
    Item *keys[3][6];
    Item *item;
    int filter[SDLK_LAST]; /* key filter */
    /* constant contence of switches */
    char *str_fps[] = { "No Limit", "50 FPS", "100 FPS", "200 FPS" };
    char *str_cpu_aggr[] = { "Defensive", "Normal", "Aggressive", "Kamikaze" };
    char *str_help[] = { "Off", "Shadow", "Lines" };
    char aux[128];
    int i, j, k, l;

    Menu *_main = 0;
#ifdef _1
    Menu *options = 0;
#endif
    Menu *adv = 0;
#ifdef SOUND
    Menu *audio = 0;
#endif
    Menu *gfx = 0;
    Menu *game = 0;
    Menu *cont = 0;
    Menu *cont_player1 = 0, *cont_player2 = 0, *cont_player3 = 0;
    Menu *twoplayer = 0;
    
    /* load graphics and sounds */
    mbkgnd = load_surf( "menuback.bmp", SDL_SWSURFACE );
    SDL_SetColorKey( mbkgnd, 0, 0 );
    draw_3dframe( mbkgnd, menu_x, menu_y, menu_w, menu_h, 5 );
    draw_3dframe( mbkgnd, cx, cy, cw, ch, 5 );
    draw_3dframe( mbkgnd, vx, vy, vw, vh, 5 );
    mfont = load_fixed_font( "f_small_yellow.bmp", 32, 96, 8 );
    mhfont = load_fixed_font( "f_white.bmp", 32, 96, 10 );
    mcfont = load_fixed_font( "f_yellow.bmp", 32, 96, 10 );
#ifdef SOUND
    wav_menu_click = sound_chunk_load( "click.wav" );
    wav_menu_motion = sound_chunk_load( "motion.wav" );
#endif
    /* add version to background */
    mfont->align = ALIGN_X_LEFT | ALIGN_Y_CENTER;
    write_text( mfont, mbkgnd, vx + 10, vy + vh / 2, "http://lgames.sf.net", OPAQUE );
    mfont->align = ALIGN_X_RIGHT | ALIGN_Y_CENTER;
    sprintf( aux, "v%s", VERSION );
    write_text( mfont, mbkgnd, vx + vw - 10, vy + vh / 2, aux, OPAQUE );

    /* hints will be displayed on menu background */
    hint_set_bkgnd( mbkgnd );
    
    /* setup filter */
    filter_clear( filter );
    filter_set( filter, SDLK_a, SDLK_z, 1 );
    filter_set( filter, SDLK_0, SDLK_9, 1 );
    filter_set( filter, SDLK_KP0, SDLK_KP9, 1 );
    filter_set( filter, SDLK_UP, SDLK_PAGEDOWN, 1 );
    filter[SDLK_SPACE] = 1;
    filter[SDLK_ESCAPE] = 0;
    filter[SDLK_RETURN] = 0;
    filter[SDLK_q] = 0;
    filter[SDLK_p] = 0;
    filter[SDLK_f] = 0;
    
    /* menus are added to this list for deleting later */
    menus = list_create( LIST_AUTO_DELETE, menu_delete );
    /* create menus */
    _main   = menu_create( "Menu", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
    gfx     = menu_create( "Graphics", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
    game    = menu_create( "New Game", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
    cont    = menu_create( "Controls", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
    cont_player1 = menu_create( "Player1", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
    cont_player2 = menu_create( "Player2", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
    cont_player3 = menu_create( "Player3", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
    twoplayer = menu_create( "Multiplayer Options", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
    adv     = menu_create( "Advanced Options", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
#ifdef _1    
    options = menu_create( "Options", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
#endif    
#ifdef SOUND
    audio = menu_create( "Audio", MENU_LAYOUT_CENTERED, menu_x, menu_y, menu_w, menu_h, menu_border );
#endif
    /* create items */
    /* main menu */
    menu_add( _main, item_create_link    ( "New Game", HINT_NEWGAME, game ) );
    menu_add( _main, item_create_separator  ( "" ) );
#ifdef _1
    menu_add( _main, item_create_link       ( "Options", HINT_, options ) );
#endif
    menu_add( _main, item_create_link       ( "Controls", HINT_CTRLS, cont ) );
    menu_add( _main, item_create_link       ( "Graphics", HINT_GFX, gfx ) );
#ifdef SOUND
    menu_add( _main, item_create_link       ( "Audio", HINT_AUDIO, audio ) );
#else
    menu_add( _main, item_create_separator  ( "Audio" ) );
#endif
    menu_add( _main, item_create_separator  ( "" ) );
    menu_add( _main, item_create_link       ( "Advanced Options", HINT_ADV, adv ) );
    menu_add( _main, item_create_separator  ( "" ) );
    menu_add( _main, item_create_action     ( "Quit", HINT_QUIT, ACTION_QUIT ) );
#ifdef _1
    /* options */
    menu_add( options, item_create_link( "Controls", HINT_, cont ) );
    menu_add( options, item_create_link( "Graphics", HINT_, gfx ) );
    menu_add( options, item_create_link( "Audio", HINT_, audio ) );
    menu_add( options, item_create_separator( "Audio" ) );
    menu_add( options, item_create_separator( "" ) );
    menu_add( options, item_create_link( "Back", _main ) );
#endif
    /* audio */
#ifdef SOUND
    item = item_create_switch( "Sound:", HINT_, &config.sound, "Off", "On" );
    item->callback = cb_sound;
    menu_add( audio, item );
    item = item_create_range( "Volume:", HINT_, &config.volume, 1, 8, 1 );
    item->callback = cb_volume;
    menu_add( audio, item );
    menu_add( audio, item_create_separator( "" ) );
    menu_add( audio, item_create_link( "Back", HINT_, _main ) );
#endif
    /* gfx */
    menu_add( gfx, item_create_switch( "Animations:", HINT_ANIM, &config.anim, "Off", "On" ) );
    menu_add( gfx, item_create_switch( "Move:", HINT_SMOOTHHORI, &config.smooth_hori, "Tile By Tile", "Smooth" ) );
    menu_add( gfx, item_create_switch( "Drop:", HINT_SMOOTHVERT, &config.block_by_block, "Smooth", "Tile By Tile" ) );
    menu_add( gfx, item_create_switch( "Change Background:", HINT_BKGND, &config.keep_bkgnd, "Yes", "No" ) );
    menu_add( gfx, item_create_separator( "" ) );
    item = item_create_switch( "Display:", HINT_DISPLAY, &config.fullscreen, "Window", "Fullscreen" );
    item->callback = cb_fullscreen;
    menu_add( gfx, item );
    menu_add( gfx, item_create_switch_x( "Frame Rate:", HINT_FPS, &config.fps, str_fps, 4 ) );
    menu_add( gfx, item_create_separator( "" ) );
    menu_add( gfx, item_create_link( "Back", HINT_, _main ) );
    /* game */
    menu_add( game, item_create_action( "Start Game", HINT_START, ACTION_PLAY ) );
#ifndef SLOW_MODE
    menu_add( game, item_create_separator( "" ) );
#endif /* !SLOW_MODE */
    menu_add( game, item_create_edit( "1st Player:", HINT_NAME, config.player1.name, 12 ) );
    menu_add( game, item_create_edit( "2nd Player:", HINT_NAME, config.player2.name, 12 ) );
    menu_add( game, item_create_edit( "3rd Player:", HINT_NAME, config.player3.name, 12 ) );
    menu_add( game, item_create_separator( "" ) );
    menu_add( game, item_create_switch_x( "Game:", HINT_GAME, &config.gametype, gametype_names, 8 ) );
    menu_add( game, item_create_range( "Starting Level:", HINT_STARTLEVEL, &config.starting_level, 0, 9, 1 ) );
    menu_add( game, item_create_switch( "Preview:", HINT_PREVIEW, &config.preview, "Off", "On" ) );
    menu_add( game, item_create_switch_x( "Help:", HINT_HELP, &config.help, str_help, 3 ) );
    menu_add( game, item_create_switch( "Expert Mode:", HINT_EXPERT, &config.expert, "Off", "On" ) );
#ifdef _1
    menu_add( game, item_create_switch( "Slow:", HINT_, &config.slow, "Off", "On" ) );
#endif
#ifdef SLOW_MODE
    menu_add( game, item_create_switch( "Slow:", HINT_SLOW, &config.slow, "Off", "On" ) );
#endif /* SLOW_MODE */

    //menu_add( game, item_create_separator( "" ) );
    menu_add( game, item_create_link( "Multiplayer Options", HINT_MPMENU, twoplayer ) );
    menu_add( game, item_create_separator( "" ) );
    menu_add( game, item_create_link( "Back", HINT_, _main ) );
    /* twoplayer options */
    menu_add( twoplayer, item_create_switch( "Same Blocks For All:", HINT_SAME, &config.same_blocks_for_all, "Off", "On" ) );
    menu_add( twoplayer, item_create_separator( "" ) );
    menu_add( twoplayer, item_create_range( "Holes:", HINT_HOLES, &config.holes, 1, 9, 1 ) );
    menu_add( twoplayer, item_create_switch( "Send All Lines:", HINT_SENDALL, &config.send_all, "Off", "On" ) );
    menu_add( twoplayer, item_create_switch( "Always Send Tetris:", HINT_SENDTETRIS, &config.send_tetris, "Off", "On" ) );
    menu_add( twoplayer, item_create_separator( "" ) );
    menu_add( twoplayer, item_create_switch_x( "CPU Style:", HINT_CPUAGGR, &config.cpu_aggr, str_cpu_aggr, 4 ) );
    menu_add( twoplayer, item_create_range( "CPU Drop Delay:", HINT_CPUDROP, &config.cpu_delay, 0, 2000, 100 ) );
    menu_add( twoplayer, item_create_separator( "" ) );
    menu_add( twoplayer, item_create_link( "Back", HINT_, game ) );
    /* controls */
    menu_add( cont, item_create_link( "Player1", HINT_CONTROLS, cont_player1 ) );
    menu_add( cont, item_create_link( "Player2", HINT_CONTROLS, cont_player2 ) );
    menu_add( cont, item_create_link( "Player3", HINT_CONTROLS, cont_player3 ) );
    menu_add( cont, item_create_separator( "" ) );
    menu_add( cont, item_create_range( "Horizontal Delay:",  HINT_HORIDEL,&config.hori_delay, 0, 5, 1 ) );
    menu_add( cont, item_create_separator( "" ) );
    menu_add( cont, item_create_link( "Back", HINT_, _main ) );
    /* all keys used */
    keys[0][0] = item_create_key( "Left:", HINT_CONTROLS, &config.player1.controls.left, filter );
    keys[0][1] = item_create_key( "Right:", HINT_CONTROLS, &config.player1.controls.right, filter );
    keys[0][2] = item_create_key( "Rotate Left:", HINT_CONTROLS, &config.player1.controls.rot_left, filter );
    keys[0][3] = item_create_key( "Rotate Right:", HINT_CONTROLS, &config.player1.controls.rot_right, filter );
    keys[0][4] = item_create_key( "Down:", HINT_CONTROLS, &config.player1.controls.down, filter );
    keys[0][5] = item_create_key( "Drop:", HINT_CONTROLS, &config.player1.controls.drop, filter );
    keys[1][0] = item_create_key( "Left:", HINT_CONTROLS, &config.player2.controls.left, filter );
    keys[1][1] = item_create_key( "Right:", HINT_CONTROLS, &config.player2.controls.right, filter );
    keys[1][2] = item_create_key( "Rotate Left:", HINT_CONTROLS, &config.player2.controls.rot_left, filter );
    keys[1][3] = item_create_key( "Rotate Right:", HINT_CONTROLS, &config.player2.controls.rot_right, filter );
    keys[1][4] = item_create_key( "Down:", HINT_CONTROLS, &config.player2.controls.down, filter );
    keys[1][5] = item_create_key( "Drop:", HINT_CONTROLS, &config.player2.controls.drop, filter );
    keys[2][0] = item_create_key( "Left:", HINT_CONTROLS, &config.player3.controls.left, filter );
    keys[2][1] = item_create_key( "Right:", HINT_CONTROLS, &config.player3.controls.right, filter );
    keys[2][2] = item_create_key( "Rotate Left:", HINT_CONTROLS, &config.player3.controls.rot_left, filter );
    keys[2][3] = item_create_key( "Rotate Right:", HINT_CONTROLS, &config.player3.controls.rot_right, filter );
    keys[2][4] = item_create_key( "Down:", HINT_CONTROLS, &config.player3.controls.down, filter );
    keys[2][5] = item_create_key( "Drop:", HINT_CONTROLS, &config.player3.controls.drop, filter );
    /* for each key all others are restricted */
    for ( k = 0; k < 3; k++ )
        for ( l = 0; l < 6; l++ ) {
            /* restrict all other keys for key( k, l ) */
            for ( i = 0; i < 3; i++ )
                for ( j = 0; j < 6; j++ ) 
                    if ( k != i || l != j )
                        value_add_other_key( keys[k][l]->value, keys[i][j]->value );
        }
    /* controls player 1 */
    for ( k = 0; k < 6; k++ )
        menu_add( cont_player1, keys[0][k] );
    menu_add( cont_player1, item_create_separator( "" ) );
    menu_add( cont_player1, item_create_link( "Back", HINT_,cont ) );
    /* controls player 2 */
    for ( k = 0; k < 6; k++ )
        menu_add( cont_player2, keys[1][k] );
    menu_add( cont_player2, item_create_separator( "" ) );
    menu_add( cont_player2, item_create_link( "Back", HINT_, cont ) );
    /* controls player 3 */
    for ( k = 0; k < 6; k++ )
        menu_add( cont_player3, keys[2][k] );
    menu_add( cont_player3, item_create_separator( "" ) );
    menu_add( cont_player3, item_create_link( "Back", HINT_, cont ) );
    /* advanced options */
    item = item_create_switch  ( "Quick Help:", HINT_QHELP, &config.quick_help, "Off", "On" );
    item->callback = cb_hints;
    menu_add( adv, item );
    menu_add( adv, item_create_switch  ( "Clear Keystate:", HINT_KEYSTATE, &config.clear_keystate, "Off", "On" ) );
    menu_add( adv, item_create_switch  ( "Center Preview:", HINT_CENTERPREVIEW, &config.center_preview, "Off", "On" ) );
    menu_add( adv, item_create_switch  ( "Collision Check:", HINT_COL_CHECK, &config.async_col_check, "Sync", "Async" ) );
#ifdef DEVELOPMENT    
    menu_add( adv, item_create_separator( "" ) );
    menu_add( adv, item_create_action( "Test CPU Algorithm", HINT_CPUALG, ACTION_MAKE_STAT ) );
    menu_add( adv, item_create_switch( "Visualization", HINT_VIS, &config.visualize, "Off", "On" ) );
#endif    
    menu_add( adv, item_create_separator( "" ) );
    menu_add( adv, item_create_link( "Back", HINT_, _main ) );

    /* adjust all menus */
    menu_adjust( _main );
#ifdef _1
    menu_adjust( options );
#endif
    menu_adjust( adv );
#ifdef SOUND
    menu_adjust( audio );
#endif
    menu_adjust( gfx );
    menu_adjust( game );
    menu_adjust( cont );
    menu_adjust( cont_player1 );
    menu_adjust( cont_player2 );
    menu_adjust( cont_player3 );
    menu_adjust( twoplayer );
    /* set main menu as current */
    menu_select( _main );
}
void manager_delete()
{
    list_delete( menus );
    free_surf( &mbkgnd );
    free_font( &mfont );
    free_font( &mhfont );
    free_font( &mcfont );
#ifdef SOUND
    if ( wav_menu_click ) sound_chunk_free( wav_menu_click ); wav_menu_click = 0;
    if ( wav_menu_motion ) sound_chunk_free( wav_menu_motion ); wav_menu_motion = 0;
#endif
}
/*
====================================================================
Run menu until request sent
====================================================================
*/
int manager_run()
{
    SDL_Event event;
    int event_polled = 0; /* event occured? */
    int result = ACTION_NONE;
    int ms;
    /* draw highscores */
    chart_show( chart_set_query_id( chart_id ), cx, cy, cw, ch );
    /* loop */
    reset_timer();
    while ( result == ACTION_NONE && !term_game ) {
        if ( event_poll( &event ) ) event_polled = 1;
        if ( event_polled && event.type == SDL_QUIT ) {
            result = ACTION_QUIT;
            term_game = 1;
        }
		/* fullscreen if no item selected */
		if ( event_polled ) {
			if ( cur_menu->cur_item == 0 || ( cur_menu->cur_item->type != ITEM_EDIT && cur_menu->cur_item->type != ITEM_KEY ) )
				if ( event.type == SDL_KEYUP )
					if ( event.key.keysym.sym == SDLK_f ) {
						config.fullscreen = !config.fullscreen;
						set_video_mode( std_video_mode( config.fullscreen ) );
						FULL_DEST( sdl.screen ); FULL_SOURCE( mbkgnd ); blit_surf();
					    chart_show( chart_set_query_id( chart_id ), cx, cy, cw, ch );
						refresh_screen( 0, 0 ,0, 0 );
					}
			/* check if clicked on highscore */
			if ( event.type == SDL_MOUSEBUTTONUP ) 
				if ( event.button.x >= cx && event.button.y >= cy )
					if ( event.button.x < cx + cw && event.button.y < cy + ch ) {
#ifdef SOUND
						sound_play( wav_menu_click );
#endif
						/* set chart id */
						if ( event.button.button == LEFT_BUTTON ) {
							chart_id++;
							if ( chart_id == charts->count ) chart_id = 0;
						}
						else {
							chart_id--;
							if ( chart_id == -1 ) chart_id = charts->count - 1;
						}
						/* redraw */
						FULL_DEST( sdl.screen ); FULL_SOURCE( mbkgnd ); blit_surf();
					    chart_show( chart_set_query_id( chart_id ), cx, cy, cw, ch );
						refresh_screen( cx, cy, cw, ch );
					}
		}			
        ms = get_time();
        menu_hide( cur_menu );
        hint_hide();
        if ( event_polled )
            result = menu_update( cur_menu, &event, ms );
        else
            result = menu_update( cur_menu, 0, ms );
        hint_update( ms );
        menu_show( cur_menu );
        chart_show( chart_set_query_id( chart_id ), cx, cy, cw, ch );
        hint_show();
        refresh_rects();
        event_polled = 0;
        SDL_Delay( 5 );
    }
    return result;
}
/*
====================================================================
Fade in/out background of menu
====================================================================
*/
void manager_fade( int type )
{
    if ( type == FADE_IN ) {
        FULL_DEST( sdl.screen ); FULL_SOURCE( mbkgnd ); blit_surf();
    }
    fade_screen( type, FADE_DEF_TIME );
}
/*
====================================================================
Update screen without menu itself as this is shown next frame.
====================================================================
*/
void manager_show()
{
    set_video_mode( std_video_mode( config.fullscreen ) );
    FULL_DEST( sdl.screen ); FULL_SOURCE( mbkgnd ); blit_surf();
    chart_show( chart_set_query_id( chart_id ), cx, cy, cw, ch );
    add_refresh_rect( 0, 0, sdl.screen->w, sdl.screen->h );
}

/*
====================================================================
Update set list when creating a new file for editor.
====================================================================
*/
void manager_update_set_list()
{
#ifdef _1    
    cb_adjust_set_list(); /* hacky but shiiiit how cares? */
#endif    
}
