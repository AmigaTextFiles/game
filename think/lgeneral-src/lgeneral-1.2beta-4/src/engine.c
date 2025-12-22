/***************************************************************************
                          engine.c  -  description
                             -------------------
    begin                : Sat Feb 3 2001
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

#ifdef USE_DL
  #include <dlfcn.h>
#endif
#include <math.h>
#include "lgeneral.h"
#include "date.h"
#include "event.h"
#include "gui.h"
#include "nation.h"
#include "unit.h"
#include "map.h"
#include "scenario.h"
#include "slot.h"
#include "action.h"
#include "strat_map.h"
#include "campaign.h"
#include "ai.h"
#include "engine.h"

/*
====================================================================
Externals
====================================================================
*/
extern Sdl sdl;
extern Config config;
extern int cur_weather; /* used in unit.c to compute weather influence on units; set by set_player() */
extern Nation *nations;
extern int nation_count;
extern int nation_flag_width, nation_flag_height;
extern int hex_w, hex_h;
extern int hex_x_offset, hex_y_offset;
extern Terrain_Icons *terrain_icons;
extern int map_w, map_h;
extern Weather_Type *weather_types;
extern List *players;
extern int turn;
extern List *units;
extern List *reinf;
extern List *avail_units;
extern Scen_Info *scen_info;
extern Map_Tile **map;
extern Mask_Tile **mask;
extern GUI *gui;
extern int camp_loaded;
extern Camp_Entry *camp_cur_scen;
extern Setup setup;
extern int  term_game, sdl_quit;

/*
====================================================================
Engine
====================================================================
*/
int modify_fog = 0;      /* if this is False the fog initiated by
                            map_set_fog() is kept throughout the turn
                            else it's updated with movement mask etc */   
int cur_ctrl = 0;        /* current control type (equals player->ctrl if set else
                            it's PLAYER_CTRL_NOBODY) */
Player *cur_player = 0;  /* current player pointer */
typedef struct {         /* unit move backup */
    int used;
    Unit unit;          /* shallow copy of unit */
    /* used to reset map flag if unit captured one */
    int flag_saved;     /* these to values used? */
    Nation *dest_nation;
    Player *dest_player;
} Move_Backup;
Move_Backup move_backup = { 0 }; /* backup to undo last move */
int fleeing_unit = 0;    /* if this is true the unit's move is not backuped */
int air_mode = 0;        /* air units are primary */
int end_scen = 0;        /* True if scenario is finished or aborted */
List *left_deploy_units = 0; /* list with unit pointers to avail_units of all
                                units that arent placed yet */
Unit *deploy_unit = 0;   /* current unit selected in deploy list */
Unit *surrender_unit = 0;/* unit that will surrender */
Unit *move_unit = 0;     /* currently moving unit */
Unit *surp_unit = 0;     /* if set cur_unit has surprise_contact with this unit if moving */
Unit *cur_unit = 0;      /* currently selected unit (by human) */
Unit *cur_target = 0;    /* target of cur_unit */
Unit *cur_atk = 0;       /* current attacker - if not defensive fire it's
                            identical with cur_unit */
Unit *cur_def = 0;       /* is the current defender - identical with cur_target
                            if not defensive fire (then it's cur_unit) */
List *df_units = 0;      /* this is a list of defensive fire units giving support to 
                            cur_target. as long as this list isn't empty cur_unit
                            becomes the cur_def and cur_atk is the current defensive
                            unit. if this list is empty in the last step
                            cur_unit and cur_target actually do their fight
                            if attack wasn't broken up */
int  defFire = 0;        /* combat is supportive so switch casualties */
Unit *merge_units[MAP_MERGE_UNIT_LIMIT] = { 0, 0, 0, 0, 0, 0 };  /* list of merge partners for cur_unit */
int merge_unit_count = 0;
/* DISPLAY */
enum { 
    SC_NONE = 0,
    SC_VERT,
    SC_HORI
};    
int sc_type = 0, sc_diff = 0;  /* screen copy type. used to speed up complete map updates */   
SDL_Surface *sc_buffer = 0;    /* screen copy buffer */
int *hex_mask = 0;             /* used to determine hex from pointer pos */
int map_x, map_y;              /* current position in map */
int map_sw, map_sh;            /* number of tiles drawn to screen */
int map_sx, map_sy;            /* position where to draw first tile */
int draw_map = 0;              /* if this flag is true engine_update() calls engine_draw_map() */
enum {
    SCROLL_NONE = 0,
    SCROLL_LEFT,
    SCROLL_RIGHT,
    SCROLL_UP,
    SCROLL_DOWN
};
int scroll_hori = 0, scroll_vert = 0; /* scrolling directions if any */
int blind_cpu_turn = 0;        /* if this is true all movements are hidden */
Button *last_button = 0;       /* last button that was pressed. used to clear the down state when button was released */
/* MISC */
int old_mx = -1, old_my = -1;  /* last map tile the cursor was on */
int old_region = -1;           /* region in map tile */
int scroll_block_keys = 0;     /* block keys fro scrolling */
int scroll_block = 0;          /* block scrolling if set used to have a constant
                                  scrolling speed */
int scroll_time = 100;         /* one scroll every 'scroll_time' milliseconds */
Delay scroll_delay;            /* used to time out the remaining milliseconds */
int slot_id;                   /* slot id to which game is saved */
Delay blink_delay;             /* used to blink dots on strat map */
/* ACTION */
enum {
    STATUS_NONE = 0,           /* actions that are divided into different phases
                                  have this status set */
    STATUS_MOVE,               /* move unit along 'way' */
    STATUS_ATTACK,             /* unit attacks cur_target (inclusive defensive fire) */
    STATUS_MERGE,              /* human may merge with partners */
    STATUS_DEPLOY,             /* human may deploy units */
    STATUS_INFO,               /* show full unit infos */
    STATUS_SCEN_INFO,          /* show scenario info */
    STATUS_CONF,               /* run confirm window */
    STATUS_UNIT_MENU,          /* running the unit buttons */
    STATUS_GAME_MENU,          /* game menu */
    STATUS_DEPLOY_INFO,        /* full unit info while deploying */
    STATUS_STRAT_MAP,          /* showing the strategic map */
    STATUS_RENAME,             /* rename unit */
    STATUS_SAVE,               /* running the save edit */
    STATUS_TITLE,              /* show the background */
    STATUS_TITLE_MENU,         /* run title menu */
    STATUS_RUN_SCEN_DLG,       /* run scenario dialogue */
    STATUS_RUN_CAMP_DLG,       /* run campaign dialogue */
    STATUS_RUN_SETUP,          /* run setup of scenario */
    STATUS_RUN_MODULE_DLG      /* select ai module */
};
int status;                    /* statuses defined in engine_tools.h */
enum {
    PHASE_NONE = 0,
    /* COMBAT */
    PHASE_INIT_ATK,             /* initiate attack cross */
    PHASE_SHOW_ATK_CROSS,       /* attacker cross */
    PHASE_SHOW_DEF_CROSS,       /* defender cross */
    PHASE_COMBAT,               /* compute and take damage */
    PHASE_RUGGED_DEF,           /* stop the engine for some time and display the rugged defense message */
    PHASE_PREP_EXPLOSIONS,      /* setup the explosions */
    PHASE_SHOW_EXPLOSIONS,      /* animate both explosions */
    PHASE_FIGHT_MSG,		/* show fight status messages */
    PHASE_CHECK_RESULT,         /* clean up this fight and initiate next if any */
    PHASE_BROKEN_UP_MSG,        /* display broken up message if needed */
    PHASE_SURRENDER_MSG,        /* display surrender message */
    PHASE_END_COMBAT,           /* clear status and redraw */
    /* MOVEMENT */
    PHASE_INIT_MOVE,            /* initiate movement */ 
    PHASE_START_SINGLE_MOVE,    /* initiate movement to next way point from current position */
    PHASE_RUN_SINGLE_MOVE,      /* run single movement and call START_SINGLE_MOVEMENT when done */
    PHASE_CHECK_LAST_MOVE,      /* check last single move for suprise contact, flag capture, scenario end */
    PHASE_END_MOVE              /* finalize movement */
};
int phase;
Way_Point *way = 0;             /* way points for movement */
int way_length = 0;
int way_pos = 0;
int dest_x, dest_y;             /* ending point of the way */
Image *move_image = 0;          /* image that contains the moving unit graphic */
float move_vel = 0.3;           /* pixels per millisecond */
Delay move_time;                /* time a single movement takes */
typedef struct {
    float x,y;
} Vector;
Vector unit_vector;             /* floating position of animation */
Vector move_vector;             /* vector the unit moves along */
int surp_contact = 0;           /* true if the current combat is the result of a surprise contact */
int atk_result = 0;             /* result of the attack */
Delay msg_delay;                /* broken up message delay */
int atk_took_damage = 0;
int def_took_damage = 0;        /* if True an explosion is displayed when attacked */
int atk_damage_delta;		/* damage delta for attacking unit */
int atk_suppr_delta;		/* supression delta for attacking unit */
int def_damage_delta;		/* damage delta for defending unit */
int def_suppr_delta;		/* supression delta for defending unit */

/*
====================================================================
Locals
====================================================================
*/

/*
====================================================================
Forwarded
====================================================================
*/          
static void engine_draw_map();
static void engine_update_info( int mx, int my, int region );
static void engine_goto_xy( int x, int y );
static void engine_set_status( int newstat );
static void engine_show_final_message( void );
static void engine_select_player( Player *player, int skip_unit_prep );
static int engine_capture_flag( Unit *unit );

/*
====================================================================
End the scenario and display final message.
====================================================================
*/
static void engine_finish_scenario()
{
    /* finalize ai turn if any */
    if ( cur_player && cur_player->ctrl == PLAYER_CTRL_CPU )
        (cur_player->ai_finalize)();
    blind_cpu_turn = 0;
    engine_show_final_message();
    group_set_active( gui->base_menu, ID_MENU, 0 );
    draw_map = 1;
    image_hide( gui->cursors, 0 );
    gui_set_cursor( CURSOR_STD );
    engine_select_player( 0, 0 );
    turn = scen_info->turn_limit;
    engine_set_status( STATUS_NONE ); 
    phase = PHASE_NONE;
}

/*
====================================================================
Return the first human player.
====================================================================
*/
static Player *engine_human_player(int *human_count)
{
    Player *human = 0;
    int count = 0;
    int i;
    for ( i = 0; i < players->count; i++ ) {
        Player *player = list_get( players, i );
        if ( player->ctrl == PLAYER_CTRL_HUMAN ) {
            if ( count == 0 )
                human = player;
            count++;
        }
    }
    if (human_count) *human_count = count;
    return human;
}

/*
====================================================================
Set wanted status.
====================================================================
*/
static void engine_set_status( int newstat )
{
    if ( newstat == STATUS_NONE && setup.type == SETUP_RUN_TITLE )
        status = STATUS_TITLE;
    else
        status = newstat;
}

/*
====================================================================
Draw wallpaper and background.
====================================================================
*/
static void engine_draw_bkgnd()
{
    int i, j;
    for ( j = 0; j < sdl.screen->h; j += gui->wallpaper->h )
        for ( i = 0; i < sdl.screen->w; i += gui->wallpaper->w ) {
            DEST( sdl.screen, i, j, gui->wallpaper->w, gui->wallpaper->h );
            SOURCE( gui->wallpaper, 0, 0 );
            blit_surf();
        }
    DEST( sdl.screen, 
          ( sdl.screen->w - gui->bkgnd->w ) / 2,
          ( sdl.screen->h - gui->bkgnd->h ) / 2,
          gui->bkgnd->w, gui->bkgnd->h );
    SOURCE( gui->bkgnd, 0, 0 );
    blit_surf();
}

/*
====================================================================
Display a message on screen (e.g. briefing) and wait for click.
====================================================================
*/
static void engine_show_message( char *msg )
{
    int dummy, i, y, x;
    Text *text = create_text( msg, 40 );
    engine_draw_bkgnd();
    DEST( sdl.screen, 
          ( sdl.screen->w - gui->brief_frame->w ) / 2,
          ( sdl.screen->h - gui->brief_frame->h ) / 2,
          gui->brief_frame->w, gui->brief_frame->h );
    SOURCE( gui->brief_frame, 0, 0 );
    blit_surf();
    gui->font_brief->align = ALIGN_X_LEFT | ALIGN_Y_TOP;
    x = ( sdl.screen->w - gui->brief_frame->w ) / 2 + 20;
    y = ( sdl.screen->h - gui->brief_frame->h ) / 2 + 40;
    for ( i = 0; i < text->count; i++ )
        write_line( sdl.screen, gui->font_brief, text->lines[i], x, &y );
    delete_text( text );
    refresh_screen( 0, 0, 0, 0 );
    /* wait */
    SDL_PumpEvents(); event_clear();
    while ( !event_get_buttonup( &dummy, &dummy, &dummy ) ) { SDL_PumpEvents(); SDL_Delay( 20 ); }
    event_clear();
}

/*
====================================================================
Check menu buttons and enable/disable according to engine status.
====================================================================
*/
static void engine_check_menu_buttons()
{
    /* airmode */
    group_set_active( gui->base_menu, ID_AIR_MODE, 1 );
    /* menu */
    if ( cur_ctrl == PLAYER_CTRL_NOBODY )
        group_set_active( gui->base_menu, ID_MENU, 0 );
    else
        group_set_active( gui->base_menu, ID_MENU, 1 );
    /* info */
    if ( status != STATUS_NONE )
        group_set_active( gui->base_menu, ID_SCEN_INFO, 0 );
    else
        group_set_active( gui->base_menu, ID_SCEN_INFO, 1 );
    /* deploy */
    if ( avail_units->count > 0 && status == STATUS_NONE )
        group_set_active( gui->base_menu, ID_DEPLOY, 1 );
    else
        group_set_active( gui->base_menu, ID_DEPLOY, 0 );
    /* strat map */
    if ( status == STATUS_NONE )
        group_set_active( gui->base_menu, ID_STRAT_MAP, 1 );
    else
        group_set_active( gui->base_menu, ID_STRAT_MAP, 0 );
    /* end turn */
    if ( status != STATUS_NONE )
        group_set_active( gui->base_menu, ID_END_TURN, 0 );
    else
        group_set_active( gui->base_menu, ID_END_TURN, 1 );
    /* victory conditions */
    if ( status != STATUS_NONE )
        group_set_active( gui->base_menu, ID_CONDITIONS, 0 );
    else
        group_set_active( gui->base_menu, ID_CONDITIONS, 1 );
}

/*
====================================================================
Check unit buttons. (use current unit)
====================================================================
*/
static void engine_check_unit_buttons()
{
    char str[128];
    if ( cur_unit == 0 ) return;
    /* rename */
    group_set_active( gui->unit_buttons, ID_RENAME, 1 );
    /* supply */
    if ( unit_check_supply( cur_unit, UNIT_SUPPLY_ANYTHING, 0, 0 ) ) {
        group_set_active( gui->unit_buttons, ID_SUPPLY, 1 );
        /* show supply level */
        sprintf( str, "Supply Level (%i%%)", cur_unit->supply_level );
        strcpy( group_get_button( gui->unit_buttons, ID_SUPPLY )->tooltip, str );
    }
    else
        group_set_active( gui->unit_buttons, ID_SUPPLY, 0 );
    /* merge */
    if ( merge_unit_count > 0 )
        group_set_active( gui->unit_buttons, ID_MERGE, 1 );
    else
        group_set_active( gui->unit_buttons, ID_MERGE, 0 );
    /* undo */
    if ( move_backup.used )
        group_set_active( gui->unit_buttons, ID_UNDO, 1 );
    else
        group_set_active( gui->unit_buttons, ID_UNDO, 0 );
    /* air embark */
    if ( map_check_unit_embark( cur_unit, cur_unit->x, cur_unit->y, EMBARK_AIR ) || 
         map_check_unit_debark( cur_unit, cur_unit->x, cur_unit->y, EMBARK_AIR ) )
        group_set_active( gui->unit_buttons, ID_EMBARK_AIR, 1 );
    else
        group_set_active( gui->unit_buttons, ID_EMBARK_AIR, 0 );
}

/*
====================================================================
Show/Hide full unit info while deploying
====================================================================
*/
static void engine_show_deploy_unit_info( Unit *unit )
{
    status = STATUS_DEPLOY_INFO;
    gui_show_full_info( unit );
    group_set_active( gui->deploy_window, ID_DEPLOY_UP, 0 );
    group_set_active( gui->deploy_window, ID_DEPLOY_DOWN, 0 );
    group_set_active( gui->deploy_window, ID_APPLY_DEPLOY, 0 );
    group_set_active( gui->deploy_window, ID_CANCEL_DEPLOY, 0 );
}
static void engine_hide_deploy_unit_info()
{
    status = STATUS_DEPLOY;
    frame_hide( gui->finfo, 1 );
    old_mx = old_my = -1;
    group_set_active( gui->deploy_window, ID_DEPLOY_UP, 1 );
    group_set_active( gui->deploy_window, ID_DEPLOY_DOWN, 1 );
    group_set_active( gui->deploy_window, ID_APPLY_DEPLOY, 1 );
    group_set_active( gui->deploy_window, ID_CANCEL_DEPLOY, 1 );
}

/*
====================================================================
Show/Hide game menu.
====================================================================
*/
static void engine_show_game_menu( int cx, int cy )
{
    int i;
    if ( setup.type == SETUP_RUN_TITLE ) {
        status = STATUS_TITLE_MENU;
        if ( cy + gui->main_menu->frame->img->img->h >= sdl.screen->h )
            cy = sdl.screen->h - gui->main_menu->frame->img->img->h;
        group_move( gui->main_menu, cx, cy );
        group_hide( gui->main_menu, 0 );
        group_set_active( gui->main_menu, ID_SAVE, 0 );
        group_set_active( gui->main_menu, ID_RESTART, 0 );
    }
    else {
        engine_check_menu_buttons();
        gui_show_menu( cx, cy );
        status = STATUS_GAME_MENU;
        group_set_active( gui->main_menu, ID_SAVE, 1 );
        group_set_active( gui->main_menu, ID_RESTART, 1 );
    }
    /* lock config buttons */
    group_lock_button( gui->opt_menu, ID_C_SUPPLY, config.supply );
    group_lock_button( gui->opt_menu, ID_C_WEATHER, config.weather );
    group_lock_button( gui->opt_menu, ID_C_GRID, config.grid );
    group_lock_button( gui->opt_menu, ID_C_SHOW_CPU, config.show_cpu_turn );
    group_lock_button( gui->opt_menu, ID_C_SHOW_STRENGTH, config.show_bar );
    group_lock_button( gui->opt_menu, ID_C_SOUND, config.sound_on );
    /* videmodes */
    group_lock_button( gui->vmode_menu, ID_FULLSCREEN, sdl.screen->flags & SDL_FULLSCREEN );
    for ( i = ID_640x480; i <= ID_1600x1200; i++ )
        group_lock_button( gui->vmode_menu, i, 0 );
    switch ( sdl.screen->w ) {
        case 640: group_lock_button( gui->vmode_menu, ID_640x480, 1 ); break;
        case 800: group_lock_button( gui->vmode_menu, ID_800x600, 1 ); break;
        case 1024: group_lock_button( gui->vmode_menu, ID_1024x768, 1 ); break;
        case 1280: group_lock_button( gui->vmode_menu, ID_1280x1024, 1 ); break;
        case 1600: group_lock_button( gui->vmode_menu, ID_1600x1200, 1 ); break;
    }
    group_set_active( gui->vmode_menu, ID_APPLY_VMODE, 1 );
    /* loads */
    gui_update_slot_tooltips();
    for ( i = 0; i < SLOT_COUNT; i++ )
        if ( slot_is_valid( i ) )
            group_set_active( gui->load_menu, ID_LOAD_0 + i, 1 );
        else
            group_set_active( gui->load_menu, ID_LOAD_0 + i, 0 );
}
static void engine_hide_game_menu()
{
    if ( setup.type == SETUP_RUN_TITLE ) {
        status = STATUS_TITLE;
        label_hide( gui->label, 1 );
        label_hide( gui->label2, 1 );
    }
    else
        engine_set_status( STATUS_NONE );
    group_hide( gui->base_menu, 1 );
    group_hide( gui->main_menu, 1 );
    group_hide( gui->save_menu, 1 );
    group_hide( gui->load_menu, 1 );
    group_hide( gui->opt_menu, 1 );
    group_hide( gui->vmode_menu, 1 );
    old_mx = old_my = -1;
}

/*
====================================================================
Show/Hide unit menu.
====================================================================
*/
static void engine_show_unit_menu( int cx, int cy )
{
    engine_check_unit_buttons();
    gui_show_unit_buttons( cx, cy );
    status = STATUS_UNIT_MENU;
}
static void engine_hide_unit_menu()
{
    engine_set_status( STATUS_NONE );
    group_hide( gui->unit_buttons, 1 );
    old_mx = old_my = -1;
}

/*
====================================================================
Initiate the confirmation window. (if this returnes ID_CANCEL
the last action stored will be removed)
====================================================================
*/
static void engine_confirm_action( char *text )
{
    gui_show_confirm( text );
    status = STATUS_CONF;
}

/*
====================================================================
Display final scenario message (called when scen_check_result()
returns True).
====================================================================
*/
static void engine_show_final_message()
{
    int dummy;
    event_clear_all_input();
    SDL_FillRect( sdl.screen, 0, 0x0 );
    gui->font_turn_info->align = ALIGN_X_CENTER | ALIGN_Y_CENTER;
    write_text( gui->font_turn_info, sdl.screen, sdl.screen->w / 2, sdl.screen->h / 2, scen_get_result_message(), 255 );
    refresh_screen( 0, 0, 0, 0 );
    SDL_PumpEvents(); event_clear();
    while ( !event_get_buttonup( &dummy, &dummy, &dummy ) ) { SDL_PumpEvents(); SDL_Delay( 20 ); }
    event_clear();
}

/*
====================================================================
Show turn info (done before turn)
====================================================================
*/
static void engine_show_turn_info()
{
    int dummy;
    int text_x, text_y;
    int time_factor;
    char text[400];
    FULL_DEST( sdl.screen );
    fill_surf( 0x0 );
    text_x = sdl.screen->w >> 1;
    text_y = ( sdl.screen->h - 4 * gui->font_turn_info->height ) >> 1;
    gui->font_turn_info->align = ALIGN_X_CENTER | ALIGN_Y_TOP;
    scen_get_date( text );
    write_text( gui->font_turn_info, sdl.screen, text_x, text_y, text, OPAQUE );
    text_y += gui->font_turn_info->height;
    sprintf( text, "Next Player: %s", cur_player->name );
    write_text( gui->font_turn_info, sdl.screen, text_x, text_y, text, OPAQUE );
    text_y += gui->font_turn_info->height;
    if ( turn + 1 < scen_info->turn_limit ) {
        sprintf( text, "Remaining Turns: %i", scen_info->turn_limit - turn );
        write_text( gui->font_turn_info, sdl.screen, text_x, text_y, text, OPAQUE );
        text_y += gui->font_turn_info->height;
    }
    sprintf( text, "Weather: %s", weather_types[scen_get_weather()].name );
    write_text( gui->font_turn_info, sdl.screen, text_x, text_y, text, OPAQUE );
    text_y += gui->font_turn_info->height;
    if ( turn + 1 < scen_info->turn_limit )
        sprintf( text, "Turn: %d", turn + 1 );
    else
        sprintf( text, "Last Turn" );
    write_text( gui->font_turn_info, sdl.screen, text_x, text_y, text, OPAQUE );
    refresh_screen( 0, 0, 0, 0 );
    SDL_PumpEvents(); event_clear();
    time_factor = 3000/20;		/* wait 3 sec */
    while ( !event_get_buttonup( &dummy, &dummy, &dummy ) && time_factor ) {
        SDL_PumpEvents(); SDL_Delay( 20 );
	if (cur_ctrl != PLAYER_CTRL_HUMAN) time_factor--;
    }
    event_clear();
}

/*
====================================================================
Backup data that will be restored when unit move was undone.
(destination flag, spot mask, unit position)
If x != -1 the flag at x,y will be saved.
====================================================================
*/
static void engine_backup_move( Unit *unit, int x, int y )
{
    if ( move_backup.used == 0 ) {
        move_backup.used = 1;
        memcpy( &move_backup.unit, unit, sizeof( Unit ) );
        map_backup_spot_mask();
    }
    if ( x != -1 ) {
        move_backup.dest_nation = map[x][y].nation;
        move_backup.dest_player = map[x][y].player;
        move_backup.flag_saved = 1;
    }
    else
        move_backup.flag_saved = 0;
}
static void engine_undo_move( Unit *unit )
{
    int new_embark;
    if ( !move_backup.used ) return;
    map_remove_unit( unit );
    if ( move_backup.flag_saved ) {
        map[unit->x][unit->y].player = move_backup.dest_player;
        map[unit->x][unit->y].nation = move_backup.dest_nation;
        move_backup.flag_saved = 0;
    }
    /* get stuff before restoring pointer */
    new_embark = unit->embark;
    /* restore */
    memcpy( unit, &move_backup.unit, sizeof( Unit ) );
    /* check debark/embark counters */
    if ( unit->embark == EMBARK_NONE ) {
        if ( new_embark == EMBARK_AIR )
            unit->player->air_trsp_used--;
        if ( new_embark == EMBARK_SEA )
            unit->player->sea_trsp_used--;
    }
    else
        if ( unit->embark == EMBARK_SEA && new_embark == EMBARK_NONE )
            unit->player->sea_trsp_used++;
        else
            if ( unit->embark == EMBARK_AIR && new_embark == EMBARK_NONE )
                unit->player->air_trsp_used++;
    unit_adjust_icon( unit ); /* adjust picture as direction may have changed */
    map_insert_unit( unit );
    map_restore_spot_mask();
    if ( modify_fog ) map_set_fog( F_SPOT );
    move_backup.used = 0;
}
static void engine_clear_backup()
{
    move_backup.used = 0;
    move_backup.flag_saved = 0;
}

/*
====================================================================
Remove unit from map and unit list and clear it's influence.
====================================================================
*/
static void engine_remove_unit( Unit *unit )
{
    if (unit->killed >= 2) return;

    /* check if it's an enemy to the current player; if so the influence must be removed */
    if ( !player_is_ally( cur_player, unit->player ) )
        map_remove_unit_infl( unit );
    map_remove_unit( unit );
    /* from unit list */
    unit->killed = 2;
}

/*
====================================================================
Select this unit and unselect old selection if nescessary.
Clear the selection if NULL is passed as unit.
====================================================================
*/
static void engine_select_unit( Unit *unit )
{
    /* select unit */
    cur_unit = unit;
    if ( cur_unit == 0 ) {
        /* clear view */
        if ( modify_fog ) map_set_fog( F_SPOT );
        engine_clear_backup();
        return;
    }
    /* switch air/ground */
    if ( unit->sel_prop->flags & FLYING )
        air_mode = 1;
    else
        air_mode = 0;
    /* get merge partners and set merge_unit mask */
    map_get_merge_units( cur_unit, merge_units, &merge_unit_count );
    /* moving range */
    map_get_unit_move_mask( unit );
    if ( modify_fog && unit->cur_mov > 0 ) {
        map_set_fog( F_IN_RANGE );
        mask[unit->x][unit->y].fog = 0;
    }
    else
        map_set_fog( F_SPOT );
    return;
}

/*
====================================================================
Initiate player as current player and prepare its turn.
If 'skip_unit_prep' is set scen_prep_unit() is not called.
====================================================================
*/
static void engine_select_player( Player *player, int skip_unit_prep )
{
    Player *human;
    int i, human_count, x, y;
    Unit *unit;
    cur_player = player;
    if ( player )
        cur_ctrl = player->ctrl;
    else
        cur_ctrl = PLAYER_CTRL_NOBODY;
    if ( !skip_unit_prep ) {
        /* available reinforcements */
        list_reset( avail_units );
        while ( avail_units->count > 0 )
            list_transfer( avail_units, reinf, list_first( avail_units ) );
        /* add all units from scen::reinf whose delay <= cur_turn */
        list_reset( reinf );
        for ( i = 0; i < reinf->count; i++ ) {
            unit = list_next( reinf );
            if ( unit->sel_prop->flags & FLYING && unit->player == cur_player && unit->delay <= turn ) {
                list_transfer( reinf, avail_units, unit );
                /* index must be reset if unit was added */
                i--;
            }
        }
        list_reset( reinf );
        for ( i = 0; i < reinf->count; i++ ) {
            unit = list_next( reinf );
            if ( !(unit->sel_prop->flags & FLYING) && unit->player == cur_player && unit->delay <= turn ) {
                list_transfer( reinf, avail_units, unit );
                /* index must be reset if unit was added */
                i--;
            }
        }
        /* prepare units for turn -- fuel, mov-points, entr, weather etc */
        /* delete killed units */
        list_reset( units );
        for ( i = 0; i < units->count; i++ ) {
            unit = list_next( units );
            if ( unit->player == cur_player ) {
                if ( turn == 0 )
                    scen_prep_unit( unit, SCEN_PREP_UNIT_FIRST );
                else
                    scen_prep_unit( unit, SCEN_PREP_UNIT_NORMAL );
            }
            if ( unit->killed ) {
                engine_remove_unit( unit );
                list_delete_item( units, unit );
                i--; /* adjust index */
            }
        }
    }
    /* set fog */
    switch ( cur_ctrl ) {
        case PLAYER_CTRL_HUMAN:
            modify_fog = 1;
            map_set_spot_mask(); 
            map_set_fog( F_SPOT );
            break;
        case PLAYER_CTRL_NOBODY:
            for ( x = 0; x < map_w; x++ )
                for ( y = 0; y < map_h; y++ )
                    mask[x][y].spot = 1;
            map_set_fog( 0 );
            break;
        case PLAYER_CTRL_CPU:
            human = engine_human_player( &human_count );
            if ( human_count == 1 ) {
                modify_fog = 0;
                map_set_spot_mask();
                map_set_fog_by_player( human );
            }
            else {
                modify_fog = 1;
                map_set_spot_mask(); 
                map_set_fog( F_SPOT );
            }
            break;
    }
    /* set influence mask */
    if ( cur_ctrl != PLAYER_CTRL_NOBODY )
        map_set_infl_mask();
    map_get_vis_units();
    if ( !skip_unit_prep) {
        /* supply levels */
        list_reset( units );
        while ( ( unit = list_next( units ) ) )
            if ( unit->player == cur_player )
            {
                scen_adjust_unit_supply_level( unit );
                if (unit->prop.flags&FLYING)
                    unit_supply_intern(unit,UNIT_SUPPLY_ALL);
            }
    }
    /* clear selections/actions */
    cur_unit = cur_target = cur_atk = cur_def = surp_unit = move_unit = deploy_unit = 0;
    merge_unit_count = 0;
    list_clear( df_units );
    actions_clear();
    scroll_block = 0;
}

/*
====================================================================
End turn of current player and select next player.
If 'forced_player' is set the turn is initiated for the forced
player (instead of the next in list). The next player will be the 
one following 'forced_player'.
If 'skip_unit_prep' is set scen_prep_unit() is not called.
====================================================================
*/
static void engine_end_turn( Player *forced_player, int skip_unit_prep )
{
    char text[400];
    int new_turn = 0;
    Player *player = 0;
    /* clear various stuff that be still set from last turn */
    group_set_active( gui->confirm, ID_OK, 1 );
    engine_hide_unit_menu();
    engine_hide_game_menu();
    /* clear undo */
    engine_clear_backup();
    /* finalize ai turn if any */
    if ( cur_player && cur_player->ctrl == PLAYER_CTRL_CPU )
        (cur_player->ai_finalize)();
    if ( cur_ctrl == PLAYER_CTRL_HUMAN ) event_clear_all_input();
    /* get player */
    if ( forced_player == 0 ) {
        /* if turn == scen_info->turn_limit this was a final look */
        if ( turn == scen_info->turn_limit ) {
            end_scen = 1;
            return;
        }
        /* next player and turn */
        player = players_get_next( &new_turn );
        if ( new_turn ) turn++;
        if ( turn == scen_info->turn_limit ) {
            /* use else condition as scenario result */
            /* and take a final look */
            scen_check_result( 1 );
            blind_cpu_turn = 0;
            engine_show_final_message();
            draw_map = 1;
            image_hide( gui->cursors, 0 );
            gui_set_cursor( CURSOR_STD );
            engine_select_player( 0, skip_unit_prep );
            engine_set_status( STATUS_NONE ); 
            phase = PHASE_NONE;
            return;
        }
        else {
            cur_weather = scen_get_weather();
            engine_select_player( player, skip_unit_prep );
        }
    }
    else {
        engine_select_player( forced_player, skip_unit_prep );
        players_set_current( player_get_index( forced_player ) );
    }
    /* init ai turn if any */
    if ( cur_player && cur_player->ctrl == PLAYER_CTRL_CPU )
        (cur_player->ai_init)();
    /* turn info */
    engine_show_turn_info();
    engine_set_status( STATUS_NONE );
    phase = PHASE_NONE;
    /* update screen */
    if ( cur_ctrl != PLAYER_CTRL_CPU || config.show_cpu_turn ) {
        if ( cur_ctrl == PLAYER_CTRL_CPU )
            engine_update_info( 0, 0, 0 );
        else {
            image_hide( gui->cursors, 0 );
        }
        engine_draw_map();
        refresh_screen( 0, 0, 0, 0 );
        blind_cpu_turn = 0;
    }
    else {
        engine_update_info( 0, 0, 0 );
        draw_map = 0;
        FULL_DEST( sdl.screen );
        fill_surf( 0x0 );
        gui->font_turn_info->align = ALIGN_X_CENTER | ALIGN_Y_CENTER;
        sprintf( text, "CPU thinks..." );
        write_text( gui->font_turn_info, sdl.screen, sdl.screen->w >> 1, sdl.screen->h >> 1, text, OPAQUE );
        sprintf( text, "( Enable option 'Show Cpu Turn' if you want to see what it is doing. )" );
        write_text( gui->font_turn_info, sdl.screen, sdl.screen->w >> 1, ( sdl.screen->h >> 1 )+ 20, text, OPAQUE );
        refresh_screen( 0, 0, 0, 0 );
        blind_cpu_turn = 1;
    }
}

/*
====================================================================
Get map/screen position from cursor/map position.
====================================================================
*/
static int engine_get_screen_pos( int mx, int my, int *sx, int *sy )
{
    int x = map_sx, y = map_sy;
    /* this is the starting position if x-pos of first tile on screen is not odd */
    /* if it is odd we must add the y_offset to the starting position */
    if ( ODD( map_x ) )
        y += hex_y_offset;
    /* reduce to visible map tiles */
    mx -= map_x;
    my -= map_y;
    /* check range */
    if ( mx < 0 || my < 0) return 0;
    /* compute pos */
    x += mx * hex_x_offset;
    y += my * hex_h;
    /* if x_pos of first tile is even we must add y_offset to the odd tiles in screen */
    if ( EVEN( map_x ) ) {
        if ( ODD( mx ) )
            y += hex_y_offset;
    }
    else {
        /* we must substract y_offset from even tiles */
        if ( ODD( mx ) )
            y -= hex_y_offset;
    }
    /* check range */
    if ( x >= sdl.screen->w || y >= sdl.screen->h ) return 0;
    /* assign */
    *sx = x;
    *sy = y;
    return 1;
}
enum {
    REGION_GROUND = 0,
    REGION_AIR
};
static int engine_get_map_pos( int sx, int sy, int *mx, int *my, int *region )
{
    int x = 0, y = 0;
    int screen_x, screen_y;
    int tile_x, tile_y;
    int total_y_offset;
    if ( status == STATUS_STRAT_MAP ) {
        /* strategic map */
        if ( strat_map_get_pos( sx, sy, mx, my ) ) {
            if ( *mx < 0 || *my < 0 || *mx >= map_w || *my >= map_h ) 
                return 0;
            return 1;
        }
        return 0;
    }
    /* get the map offset in screen from mouse position */
    x = ( sx - map_sx ) / hex_x_offset;
    /* y value computes the same like the x value but their may be an offset of engine::y_offset */
    total_y_offset = 0;
    if ( EVEN( map_x ) && ODD( x ) )
        total_y_offset = hex_y_offset;
    /* if engine::map_x is odd there must be an offset of engine::y_offset for the start of first tile */
    /* and all odd tiles receive an offset of -engine::y_offset so the result is:
        odd: offset = 0 even: offset = engine::y_offset it's best to draw this ;-D
    */
    if ( ODD( map_x ) && EVEN( x ) )
        total_y_offset = hex_y_offset;
    y = ( sy - total_y_offset - map_sy ) / hex_h;
    /* compute screen position */
    if ( !engine_get_screen_pos( x + map_x, y + map_y, &screen_x, &screen_y ) ) return 0;
    /* test mask with  sx - screen_x, sy - screen_y */
    tile_x = sx - screen_x;
    tile_y = sy - screen_y;
    if ( !hex_mask[tile_y * hex_w + tile_x] ) {
        if ( EVEN( map_x ) ) {
            if ( tile_y < hex_y_offset && EVEN( x ) ) y--;
            if ( tile_y >= hex_y_offset && ODD( x ) ) y++;
        }
        else {
            if ( tile_y < hex_y_offset && ODD( x ) ) y--;
            if ( tile_y >= hex_y_offset && EVEN( x ) ) y++;
        }
        x--;
    }
    /* region */
    if ( tile_y < ( hex_h >> 1 ) )
        *region = REGION_AIR;
    else
        *region = REGION_GROUND;
    /* add engine map offset and assign */
    x += map_x;
    y += map_y;
    *mx = x;
    *my = y;
    /* check range */
    if ( x < 0 || y < 0 || x >= map_w || y >= map_h ) return 0;
    /* ok, tile exists */
    return 1;
}

/*
====================================================================
If x,y is not on screen center this map tile and check if 
screencopy is possible (but only if use_sc is True)
====================================================================
*/
static int engine_focus( int x, int y, int use_sc )
{
    int new_x, new_y;
    if ( x <= map_x + 1 || y <= map_y + 1 || x >= map_x + map_sw - 1 - 2 || y >= map_y + map_sh - 1 - 2 ) {
        new_x = x - ( map_sw >> 1 );
        new_y = y - ( map_sh >> 1 );
        if ( new_x & 1 ) new_x++;
        if ( new_y & 1 ) new_y++;
        engine_goto_xy( new_x, new_y );
        if ( !use_sc ) sc_type = SC_NONE; /* no screencopy */
        return 1;
    }
    return 0;
}
/*
====================================================================
Move to this position and set 'draw_map' if actually moved.
====================================================================
*/
static void engine_goto_xy( int x, int y )
{
    int x_diff, y_diff;
    /* check range */
    if ( x < 0 ) x = 0;
    if ( y < 0 ) y = 0;
    /* if more tiles are displayed then map has ( black space the rest ) no change in position allowed */
    if ( map_sw >= map_w ) x = 0;
    else
        if ( x > map_w - map_sw )
            x = map_w - map_sw;
    if ( map_sh >= map_h ) y = 0;
    else
        if ( y > map_h - map_sh )
            y = map_h - map_sh;
    /* check if screencopy is possible */
    x_diff = x - map_x;
    y_diff = y - map_y;
    /* if one diff is ==0 and one diff !=0 do it! */
    if ( x_diff == 0 && y_diff != 0 ) {
        sc_type = SC_VERT;
        sc_diff = y_diff;
    }
    else
        if ( x_diff != 0 && y_diff == 0 ) {
            sc_type = SC_HORI;
            sc_diff = x_diff;
        }
    /* actually moving? */
    if ( x != map_x || y != map_y ) {
        map_x = x; map_y = y;
        draw_map = 1;
    }
}

/*
====================================================================
Check if mouse position is in scroll region or key is pressed
and scrolling is possible.
If 'by_wheel' is true scroll_hori/vert has been by using
the mouse wheel and checking the keys/mouse must be skipped.
====================================================================
*/
enum {
    SC_NORMAL = 0,
    SC_BY_WHEEL
};
static void engine_check_scroll(int by_wheel)
{
    int region;
    int tol = 3; /* border in which scrolling by mouse */
    int mx, my, cx, cy;
    if ( scroll_block ) return;
    if ( setup.type == SETUP_RUN_TITLE ) return;
    if( !by_wheel ) {
        /* keys */
        scroll_hori = scroll_vert = SCROLL_NONE;
        if ( !scroll_block_keys ) {
            if ( event_check_key( SDLK_UP ) && map_y > 0) 
                scroll_vert = SCROLL_UP;
            else
                if ( event_check_key( SDLK_DOWN ) && map_y < map_h - map_sh )
                    scroll_vert = SCROLL_DOWN;
            if ( event_check_key( SDLK_LEFT ) && map_x > 0 ) 
                scroll_hori = SCROLL_LEFT;
            else
                if ( event_check_key( SDLK_RIGHT ) && map_x < map_w - map_sw )
                    scroll_hori = SCROLL_RIGHT;
        }
        if ( scroll_vert == SCROLL_NONE && scroll_hori == SCROLL_NONE ) {
            /* mouse */
            event_get_cursor_pos( &mx, &my );
            if ( my <= tol && map_y > 0 )
                scroll_vert = SCROLL_UP;
            else
                if ( mx >= sdl.screen->w - tol - 1 && map_x < map_w - map_sw )
                    scroll_hori = SCROLL_RIGHT;
                else
                    if ( my >= sdl.screen->h - tol - 1 && map_y < map_h - map_sh )
                        scroll_vert = SCROLL_DOWN;
                    else
                        if ( mx <= tol && map_x > 0 )
                            scroll_hori = SCROLL_LEFT;
        }
    }
    /* scroll */
    if ( scroll_vert != SCROLL_NONE || scroll_hori != SCROLL_NONE ) {
        if ( scroll_vert == SCROLL_UP )
            engine_goto_xy( map_x, map_y - 2 );
        else
            if ( scroll_hori == SCROLL_RIGHT )
                engine_goto_xy( map_x + 2, map_y );
            else
                if ( scroll_vert == SCROLL_DOWN )
                    engine_goto_xy( map_x, map_y + 2 );
                else
                    if ( scroll_hori == SCROLL_LEFT )
                        engine_goto_xy( map_x - 2, map_y );
        event_get_cursor_pos( &cx, &cy );
        if(engine_get_map_pos( cx, cy, &mx, &my, &region ))
            engine_update_info( mx, my, region );
        if ( !by_wheel )
            scroll_block = 1;
    }
}

/*
====================================================================
Update full map.
====================================================================
*/
static void engine_draw_map()
{
    int x, y, abs_y;
    int i, j;
    int start_map_x, start_map_y, end_map_x, end_map_y;
    int buffer_height, buffer_width, buffer_offset;
    int use_frame = ( cur_ctrl != PLAYER_CTRL_CPU );
    
    /* reset_timer(); */
    
    draw_map = 0;
    
    if ( status == STATUS_STRAT_MAP ) {
        sc_type = SC_NONE;
        strat_map_draw();
        return;
    }
    
    if ( status == STATUS_TITLE ) {
        sc_type = SC_NONE;
        engine_draw_bkgnd();
        return;
    }
    
    /* screen copy? */
    start_map_x = map_x;
    start_map_y = map_y;
    end_map_x = map_x + map_sw;
    end_map_y = map_y + map_sh;
    if ( sc_type == SC_VERT ) {
        /* clear flag */
        sc_type = SC_NONE;
        /* set buffer offset and height */
        buffer_offset = abs( sc_diff ) * hex_h;
        buffer_height = sdl.screen->h - buffer_offset;
        /* going down */
        if ( sc_diff > 0 ) {
            /* copy screen to buffer */
            DEST( sc_buffer, 0, 0, sdl.screen->w, buffer_height );
            SOURCE( sdl.screen, 0, buffer_offset );
            blit_surf();
            /* copy buffer to new pos */
            DEST( sdl.screen, 0, 0, sdl.screen->w, buffer_height );
            SOURCE( sc_buffer, 0, 0 );
            blit_surf();
            /* set loop range to redraw lower lines */
            start_map_y += map_sh - sc_diff - 2;
        }
        /* going up */
        else {
            /* copy screen to buffer */
            DEST( sc_buffer, 0, 0, sdl.screen->w, buffer_height );
            SOURCE( sdl.screen, 0, 0 );
            blit_surf();
            /* copy buffer to new pos */
            DEST( sdl.screen, 0, buffer_offset, sdl.screen->w, buffer_height );
            SOURCE( sc_buffer, 0, 0 );
            blit_surf();
            /* set loop range to redraw upper lines */
            end_map_y = map_y + abs( sc_diff ) + 1;
        }
    }
    else
        if ( sc_type == SC_HORI ) {
            /* clear flag */
            sc_type = SC_NONE;
            /* set buffer offset and width */
            buffer_offset = abs( sc_diff ) * hex_x_offset;
            buffer_width = sdl.screen->w - buffer_offset;
            buffer_height = sdl.screen->h;
            /* going right */
            if ( sc_diff > 0 ) {
                /* copy screen to buffer */
                DEST( sc_buffer, 0, 0, buffer_width, buffer_height );
                SOURCE( sdl.screen, buffer_offset, 0 );
                blit_surf();
                /* copy buffer to new pos */
                DEST( sdl.screen, 0, 0, buffer_width, buffer_height );
                SOURCE( sc_buffer, 0, 0 );
                blit_surf();
                /* set loop range to redraw right lines */
                start_map_x += map_sw - sc_diff - 2;
            }
            /* going left */
            else {
                /* copy screen to buffer */
                DEST( sc_buffer, 0, 0, buffer_width, buffer_height );
                SOURCE( sdl.screen, 0, 0 );
                blit_surf();
                /* copy buffer to new pos */
                DEST( sdl.screen, buffer_offset, 0, buffer_width, buffer_height );
                SOURCE( sc_buffer, 0, 0 );
                blit_surf();
                /* set loop range to redraw right lines */
                end_map_x = map_x + abs( sc_diff ) + 1;
            }
        }
    /* start position for drawing */
    x = map_sx + ( start_map_x - map_x ) * hex_x_offset;
    y = map_sy + ( start_map_y - map_y ) * hex_h;
    /* end_map_xy must not exceed map's size */
    if ( end_map_x >= map_w ) end_map_x = map_w;
    if ( end_map_y >= map_h ) end_map_y = map_h;
    /* loop to draw map tile */
    for ( j = start_map_y; j < end_map_y; j++ ) {
        for ( i = start_map_x; i < end_map_x; i++ ) {
            /* update each map tile */
            if ( i & 1 )
                abs_y = y + hex_y_offset;
            else
                abs_y = y;
            map_draw_terrain( sdl.screen, i, j, x, abs_y );
            x += hex_x_offset;
        }
        y += hex_h;
        x = map_sx + ( start_map_x - map_x ) * hex_x_offset;
    }
    /* start position for drawing */
    x = map_sx + ( start_map_x - map_x ) * hex_x_offset;
    y = map_sy + ( start_map_y - map_y ) * hex_h;
    /* loop again to draw units */
    for ( j = start_map_y; j < end_map_y; j++ ) {
        for ( i = start_map_x; i < end_map_x; i++ ) {
            /* update each map tile */
            if ( i & 1 )
                abs_y = y + hex_y_offset;
            else
                abs_y = y;
            if ( cur_unit && cur_unit->x == i && cur_unit->y == j && status != STATUS_MOVE && mask[i][j].spot )
                map_draw_units( sdl.screen, i, j, x, abs_y, !air_mode, use_frame );
            else
                map_draw_units( sdl.screen, i, j, x, abs_y, !air_mode, 0 );
            x += hex_x_offset;
        }
        y += hex_h;
        x = map_sx + ( start_map_x - map_x ) * hex_x_offset;
    }
    /* printf( "time needed: %i ms\n", get_time() ); */
}

/*
====================================================================
Get primary unit on tile.
====================================================================
*/
static Unit *engine_get_prim_unit( int x, int y, int region )
{
    if ( x < 0 || y < 0 || x >= map_w || y >= map_h ) return 0;
    if ( region == REGION_AIR ) {
        if ( map[x][y].a_unit )
            return map[x][y].a_unit;
        else
            return map[x][y].g_unit;
    }
    else {
        if ( map[x][y].g_unit )
            return map[x][y].g_unit;
        else
            return map[x][y].a_unit;
    }
}

/*
====================================================================
Check if there is a target for current unit on x,y.
====================================================================
*/
static Unit* engine_get_target( int x, int y, int region )
{
    Unit *unit;
    if ( x < 0 || y < 0 || x >= map_w || y >= map_h ) return 0;
    if ( !mask[x][y].spot ) return 0;
    if ( cur_unit == 0 ) return 0;
    if ( ( unit = engine_get_prim_unit( x, y, region ) ) )
        if ( unit_check_attack( cur_unit, unit, UNIT_ACTIVE_ATTACK ) )
            return unit;
    return 0;
/*    if ( region == REGION_AIR ) {
        if ( map[x][y].a_unit && unit_check_attack( cur_unit, map[x][y].a_unit, UNIT_ACTIVE_ATTACK ) )
            return map[x][y].a_unit;
        else
            if ( map[x][y].g_unit && unit_check_attack( cur_unit, map[x][y].g_unit, UNIT_ACTIVE_ATTACK ) )
                return map[x][y].g_unit;
            else
                return 0;
    }
    else {
        if ( map[x][y].g_unit && unit_check_attack( cur_unit, map[x][y].g_unit, UNIT_ACTIVE_ATTACK ) )
            return map[x][y].g_unit;
        else
            if ( map[x][y].a_unit && unit_check_attack( cur_unit, map[x][y].a_unit, UNIT_ACTIVE_ATTACK ) )
                return map[x][y].a_unit;
            else
                return 0;
    }*/
}

/*
====================================================================
Check if there is a selectable unit for current player on x,y
The currently selected unit is not counted as selectable. (though
a primary unit on the same tile may be selected if it's not
the current unit)
====================================================================
*/
static Unit* engine_get_select_unit( int x, int y, int region )
{
    if ( x < 0 || y < 0 || x >= map_w || y >= map_h ) return 0;
    if ( !mask[x][y].spot ) return 0;
    if ( region == REGION_AIR ) {
        if ( map[x][y].a_unit && map[x][y].a_unit->player == cur_player ) {
            if ( cur_unit == map[x][y].a_unit )
                return 0;
            else
                return map[x][y].a_unit;
        }
        else
            if ( map[x][y].g_unit && map[x][y].g_unit->player == cur_player )
                return map[x][y].g_unit;
            else
                return 0;
    }
    else {
        if ( map[x][y].g_unit && map[x][y].g_unit->player == cur_player ) {
            if ( cur_unit == map[x][y].g_unit )
                return 0;
            else
                return map[x][y].g_unit;
        }
        else
            if ( map[x][y].a_unit && map[x][y].a_unit->player == cur_player )
                return map[x][y].a_unit;
            else
                return 0;
    }
}

/*
====================================================================
Update the unit quick info and map tile info if map tile mx,my,
region has the focus. Also update the cursor.
====================================================================
*/
static void engine_update_info( int mx, int my, int region )
{
    Unit *unit1 = 0, *unit2 = 0, *unit;
    char str[256];
    int att_damage, def_damage;
    int fuelCost = 0;
    /* no infos when cpu is acting */
    if ( cur_ctrl == PLAYER_CTRL_CPU ) {
        image_hide( gui->cursors, 1 );
        label_hide( gui->label, 1 );
        label_hide( gui->label2, 1 );
        frame_hide( gui->qinfo1, 1 );
        frame_hide( gui->qinfo2, 1 );
        return;
    }
	if ( cur_unit /*&& unit_check_fuel_usage(cur_unit)*/ && cur_unit->cur_mov 
                  && mask[mx][my].in_range && !mask[mx][my].blocked ) {
        fuelCost = mask[mx][my].distance;
    }
    /* entered a new tile so update the terrain info */
    if (fuelCost>0)
    {
        sprintf( str, "%s (%i,%i) @%d", map[mx][my].name, mx, my, fuelCost );
        label_write( gui->label, gui->font_status, str );
    }
    else
    {
        sprintf( str, "%s (%i,%i)", map[mx][my].name, mx, my );
        label_write( gui->label, gui->font_std, str );
    }
    /* update the unit info */
    if ( !mask[mx][my].spot ) {
        if ( cur_unit )
            gui_show_quick_info( gui->qinfo1, cur_unit );
        else
            frame_hide( gui->qinfo1, 1 );
        frame_hide( gui->qinfo2, 1 );
    }
    else {
        if ( cur_unit && ( mx != cur_unit->x || my != cur_unit->y ) ) {
            unit1 = cur_unit;
            unit2 = engine_get_prim_unit( mx, my, region );
        }
        else {
            if ( map[mx][my].a_unit && map[mx][my].g_unit ) {
                unit1 = map[mx][my].g_unit;
                unit2 = map[mx][my].a_unit;
            }
            else
                if ( map[mx][my].a_unit )
                    unit1 = map[mx][my].a_unit;
                else
                    if ( map[mx][my].g_unit )
                        unit1 = map[mx][my].g_unit;
        } 
        if ( unit1 )
            gui_show_quick_info( gui->qinfo1, unit1 );
        else
            frame_hide( gui->qinfo1, 1 );
        if ( unit2 && status != STATUS_UNIT_MENU )
            gui_show_quick_info( gui->qinfo2, unit2 );
        else
            frame_hide( gui->qinfo2, 1 );
        /* show expected losses? */
        if ( cur_unit && ( unit = engine_get_target( mx, my, region ) ) ) {
            unit_get_expected_losses( cur_unit, unit, &att_damage, &def_damage );
            gui_show_expected_losses( cur_unit, unit, att_damage, def_damage );
        }
/*        if ( unit1 && unit2 ) {
            if ( engine_get_target( mx, my, region ) )
            if ( unit1 == cur_unit && unit_check_attack( unit1, unit2, UNIT_ACTIVE_ATTACK ) ) {
                unit_get_expected_losses( unit1, unit2, map[unit2->x][unit2->y].terrain, &att_damage, &def_damage );
                gui_show_expected_losses( unit1, unit2, att_damage, def_damage );
            }
            else
            if ( unit2 == cur_unit && unit_check_attack( unit2, unit1, UNIT_ACTIVE_ATTACK ) ) {
                unit_get_expected_losses( unit2, unit1, map[unit1->x][unit1->y].terrain, &att_damage, &def_damage );
                gui_show_expected_losses( unit2, unit1, att_damage, def_damage );
            }
        }*/
    }
    if ( cur_player == 0 )
        gui_set_cursor( CURSOR_STD );
    else
    /* cursor */
    switch ( status ) {
        case STATUS_TITLE:
        case STATUS_TITLE_MENU:
        case STATUS_STRAT_MAP:
        case STATUS_GAME_MENU:
        case STATUS_UNIT_MENU:
            gui_set_cursor( CURSOR_STD );
            break;
        case STATUS_MERGE:
            if ( mask[mx][my].merge_unit )
                gui_set_cursor( CURSOR_MERGE );
            else
                gui_set_cursor( CURSOR_STD );
            break;
        case STATUS_DEPLOY:
            if ( deploy_unit && map_check_deploy( deploy_unit, mx, my ) )
                gui_set_cursor( CURSOR_DEPLOY );
            else
                if ( map_get_undeploy_unit( mx, my, region == REGION_AIR ) )
                    gui_set_cursor( CURSOR_UNDEPLOY );
                else
                     gui_set_cursor( CURSOR_STD );
            break;
        default:
            if ( cur_unit ) {
                if ( cur_unit->x == mx && cur_unit->y == my && engine_get_prim_unit( mx, my, region ) == cur_unit )
                     gui_set_cursor( CURSOR_STD );
                else
                /* unit selected */
                if ( engine_get_target( mx, my, region ) )
                    gui_set_cursor( CURSOR_ATTACK );
                else
                    if ( mask[mx][my].in_range && ( cur_unit->x != mx || cur_unit->y != my ) && !mask[mx][my].blocked ) {
                        if ( mask[mx][my].mount )
                            gui_set_cursor( CURSOR_MOUNT );
                        else
                            gui_set_cursor( CURSOR_MOVE );
                    }
                    else
                        if ( mask[mx][my].sea_embark ) {
                            if ( cur_unit->embark == EMBARK_SEA )
                                gui_set_cursor( CURSOR_DEBARK );
                            else
                                gui_set_cursor( CURSOR_EMBARK );
                        }
                        else
                            if ( engine_get_select_unit( mx, my, region ) )
                                gui_set_cursor( CURSOR_SELECT );
                            else
                                gui_set_cursor( CURSOR_STD );
            }
            else {
                /* no unit selected */
                if ( engine_get_select_unit( mx, my, region ) )
                    gui_set_cursor( CURSOR_SELECT );
                else
                    gui_set_cursor( CURSOR_STD );
            }
            break;
    }
    /* new unit info */
    if ( status == STATUS_INFO || status == STATUS_DEPLOY_INFO ) {
        if ( engine_get_prim_unit( mx, my, region ) )
            if ( mask[mx][my].spot )
                gui_show_full_info( engine_get_prim_unit( mx, my, region ) );
    }
}

/*
====================================================================
Hide all animated toplevel windows.
====================================================================
*/
static void engine_begin_frame()
{
    if ( status == STATUS_ATTACK ) {
        anim_draw_bkgnd( terrain_icons->cross );
        anim_draw_bkgnd( terrain_icons->expl1 );
        anim_draw_bkgnd( terrain_icons->expl2 );
    }
    if ( status == STATUS_MOVE && move_image )
        image_draw_bkgnd( move_image );
    gui_draw_bkgnds();
}
/*
====================================================================
Handle all requested screen updates, draw the windows
and refresh the screen.
====================================================================
*/
static void engine_end_frame()
{
    int full_refresh = 0;
//    if ( blind_cpu_turn ) return;
    if ( draw_map ) {
        engine_draw_map();
        full_refresh = 1;
    }
    if ( status == STATUS_ATTACK ) {
        anim_get_bkgnd( terrain_icons->cross );
        anim_get_bkgnd( terrain_icons->expl1 );
        anim_get_bkgnd( terrain_icons->expl2 );
    }
    if ( status == STATUS_MOVE && move_image ) /* on surprise attack this image ain't created yet */
        image_get_bkgnd( move_image );
    gui_get_bkgnds();
    if ( status == STATUS_ATTACK ) {
        anim_draw( terrain_icons->cross );
        anim_draw( terrain_icons->expl1 );
        anim_draw( terrain_icons->expl2 );
    }
    if ( status == STATUS_MOVE && move_image ) {
        image_draw( move_image );
    }
    gui_draw();
    if ( full_refresh )
        refresh_screen( 0, 0, 0, 0 );
    else
        refresh_rects();
}

/*
====================================================================
Handle a button that was clicked.
====================================================================
*/
static void engine_handle_button( int id )
{
    char path[512];
    char str[128];
    int x, y, i;
    Unit *unit;

    switch ( id ) {
        /* loads */
        case ID_LOAD_0:
        case ID_LOAD_1:
        case ID_LOAD_2:
        case ID_LOAD_3:
        case ID_LOAD_4:
        case ID_LOAD_5:
        case ID_LOAD_6:
        case ID_LOAD_7:
        case ID_LOAD_8:
        case ID_LOAD_9:
            engine_hide_game_menu();
            action_queue_load( id - ID_LOAD_0 );
            slot_id = id - ID_LOAD_0;
            sprintf( str, "Load Game '%s'", slot_get_name( slot_id ) );
            engine_confirm_action( str );
            break;
        /* saves */
        case ID_SAVE_0:
        case ID_SAVE_1:
        case ID_SAVE_2:
        case ID_SAVE_3:
        case ID_SAVE_4:
        case ID_SAVE_5:
        case ID_SAVE_6:
        case ID_SAVE_7:
        case ID_SAVE_8:
        case ID_SAVE_9:
            engine_hide_game_menu();
            action_queue_overwrite( id - ID_SAVE_0 );
            if ( slot_is_valid( id - ID_SAVE_0 ) )
                engine_confirm_action( "Overwrite saved game?" );
            break;
        /* video modes */
        case ID_640x480:
        case ID_800x600:
        case ID_1024x768:
        case ID_1280x1024:
        case ID_1600x1200:
            for ( i = ID_640x480; i <= ID_1600x1200; i++ )
                if ( i != id )
                    group_lock_button( gui->vmode_menu, i, 0 );
            break;
        case ID_APPLY_VMODE:
            engine_hide_game_menu();
            x = -1; y = -1;
            if ( group_get_button( gui->vmode_menu, ID_640x480 )->down ) {
                x = 640;
                y = 480;
            }
            else
                if ( group_get_button( gui->vmode_menu, ID_800x600 )->down ) {
                    x = 800;
                    y = 600;
                }
                else
                    if ( group_get_button( gui->vmode_menu, ID_1024x768 )->down ) {
                        x = 1024;
                        y = 768;
                    }
                    else
                        if ( group_get_button( gui->vmode_menu, ID_1280x1024 )->down ) {
                            x = 1280;
                            y = 1024;
                        }
                        else
                            if ( group_get_button( gui->vmode_menu, ID_1600x1200 )->down ) {
                                x = 1600;
                                y = 1200;
                            }
            if ( x!= -1 ) {
                action_queue_set_vmode( x, y, group_get_button( gui->vmode_menu, ID_FULLSCREEN )->down );
                sprintf( str, "Apply %ix%i, ", x, y );
                if ( group_get_button( gui->vmode_menu, ID_FULLSCREEN )->down )
                    strcat( str, "Fullscreen?" );
                else
                    strcat( str, "Window?" );
                engine_confirm_action( str );
            }
            break;
        /* options */
        case ID_C_SOUND:
#ifdef WITH_SOUND            
            config.sound_on = !config.sound_on;
            audio_enable( config.sound_on );
#endif        
            break;
        case ID_C_SOUND_INC:
#ifdef WITH_SOUND            
            config.sound_volume += 16;
            if ( config.sound_volume > 128 )
                config.sound_volume = 128;
            audio_set_volume( config.sound_volume );
#endif        
            break;
        case ID_C_SOUND_DEC:
#ifdef WITH_SOUND            
            config.sound_volume -= 16;
            if ( config.sound_volume < 0 )
                config.sound_volume = 0;
            audio_set_volume( config.sound_volume );
#endif        
            break;
        case ID_C_SUPPLY:
            config.supply = !config.supply;
            break;
        case ID_C_WEATHER:
            config.weather = !config.weather;
            if ( status == STATUS_GAME_MENU ) {
                cur_weather = scen_get_weather();
                draw_map = 1;
            }
            break;
        case ID_C_GRID:
            config.grid = !config.grid;
            draw_map = 1;
            break;
        case ID_C_SHOW_STRENGTH:
            config.show_bar = !config.show_bar;
            draw_map = 1;
            break;
        case ID_C_SHOW_CPU:
            config.show_cpu_turn = !config.show_cpu_turn;
            break;
        case ID_C_VMODE:
            x = gui->opt_menu->frame->img->bkgnd->surf_rect.x + 30 - 1;
            y = gui->opt_menu->frame->img->bkgnd->surf_rect.y + 
                gui->opt_menu->frame->img->bkgnd->surf_rect.h -
                gui->vmode_menu->frame->img->img->h ;
            if ( y + gui->vmode_menu->frame->img->img->h >= sdl.screen->h )
                y = sdl.screen->h - gui->vmode_menu->frame->img->img->h;
            group_move( gui->vmode_menu, x, y );
            group_hide( gui->vmode_menu, 0 );
            break;
        /* main menu */
        case ID_MENU:
            x = gui->base_menu->frame->img->bkgnd->surf_rect.x + 30 - 1;
            y = gui->base_menu->frame->img->bkgnd->surf_rect.y;
            if ( y + gui->main_menu->frame->img->img->h >= sdl.screen->h )
                y = sdl.screen->h - gui->main_menu->frame->img->img->h;
            group_move( gui->main_menu, x, y );
            group_hide( gui->main_menu, 0 );
            break;
        case ID_OPTIONS:
            group_hide( gui->load_menu, 1 );
            group_hide( gui->save_menu, 1 );
            x = gui->main_menu->frame->img->bkgnd->surf_rect.x + 30 - 1;
            y = gui->main_menu->frame->img->bkgnd->surf_rect.y;
            if ( y + gui->opt_menu->frame->img->img->h >= sdl.screen->h )
                y = sdl.screen->h - gui->opt_menu->frame->img->img->h;
            group_move( gui->opt_menu, x, y );
            group_hide( gui->opt_menu, 0 );
            break;
        case ID_RESTART:
            engine_hide_game_menu();
            action_queue_restart();
            engine_confirm_action( "Do you really want to restart this scenario?" );
            break;
        case ID_SCEN:
            engine_hide_game_menu();
            sprintf( path, "%s/scenarios", SRC_DIR );
            fdlg_open( gui->scen_dlg, path );
            group_set_active( gui->scen_dlg->group, ID_SCEN_SETUP, 0 );
            group_set_active( gui->scen_dlg->group, ID_SCEN_OK, 0 );
            group_set_active( gui->scen_dlg->group, ID_SCEN_CANCEL, 1 );
            status = STATUS_RUN_SCEN_DLG;
            break;
        case ID_CAMP:
            engine_hide_game_menu();
            sprintf( path, "%s/campaigns", SRC_DIR );
            fdlg_open( gui->camp_dlg, path );
            group_set_active( gui->camp_dlg->group, ID_CAMP_OK, 0 );
            group_set_active( gui->camp_dlg->group, ID_CAMP_CANCEL, 1 );
            status = STATUS_RUN_CAMP_DLG;
            break;
        case ID_SAVE:
            group_hide( gui->load_menu, 1 );
            group_hide( gui->opt_menu, 1 );
            group_hide( gui->vmode_menu, 1 );
            x = gui->main_menu->frame->img->bkgnd->surf_rect.x + 30 - 1;
            y = gui->main_menu->frame->img->bkgnd->surf_rect.y;
            if ( y + gui->save_menu->frame->img->img->h >= sdl.screen->h )
                y = sdl.screen->h - gui->save_menu->frame->img->img->h;
            group_move( gui->save_menu, x, y );
            group_hide( gui->save_menu, 0 );
            break;
        case ID_LOAD:
            group_hide( gui->save_menu, 1 );
            group_hide( gui->opt_menu, 1 );
            group_hide( gui->vmode_menu, 1 );
            x = gui->main_menu->frame->img->bkgnd->surf_rect.x + 30 - 1;
            y = gui->main_menu->frame->img->bkgnd->surf_rect.y;
            if ( y + gui->load_menu->frame->img->img->h >= sdl.screen->h )
                y = sdl.screen->h - gui->load_menu->frame->img->img->h;
            group_move( gui->load_menu, x, y );
            group_hide( gui->load_menu, 0 );
            break;
        case ID_QUIT:
            engine_hide_game_menu();
            action_queue_quit();
            engine_confirm_action( "Do you really want to quit?" );
            break;
        case ID_AIR_MODE:
            engine_hide_game_menu();
            air_mode = !air_mode;
            draw_map = 1;
            break;
        case ID_END_TURN:
            engine_hide_game_menu();
            action_queue_end_turn();
            group_set_active( gui->base_menu, ID_END_TURN, 0 );
            engine_confirm_action( "Do you really want to end your turn?" );
            break;
        case ID_SCEN_INFO:
            engine_hide_game_menu();
            gui_show_scen_info();
            status = STATUS_SCEN_INFO;
            break;
        case ID_CONDITIONS:
            engine_hide_game_menu();
            gui_show_conds();
            status = STATUS_SCEN_INFO; /* is okay for the engine ;) */
            break;
        case ID_CANCEL:
            /* a confirmation window is run before an action so if cancel
               is hit this action will be removed */
            action_remove_last();
        case ID_OK:
            engine_set_status( STATUS_NONE );
            group_hide( gui->confirm, 1 );
            old_mx = old_my = -1;
            draw_map = 1;
            break;
        case ID_SUPPLY:
            action_queue_supply( cur_unit );
            engine_select_unit( cur_unit );
            draw_map = 1;
            engine_hide_unit_menu();
            break;
        case ID_EMBARK_AIR:
            if ( cur_unit->embark == EMBARK_NONE ) {
                action_queue_embark_air( cur_unit, cur_unit->x, cur_unit->y );
                if ( cur_unit->trsp_prop.id )
                    engine_confirm_action( "Abandon the ground transporter?" );
            }
            else
                action_queue_debark_air( cur_unit, cur_unit->x, cur_unit->y );
            engine_backup_move( cur_unit, -1, -1 );
            draw_map = 1;
            engine_hide_unit_menu();
            break;
        case ID_MERGE:
            map_set_fog( F_MERGE_UNIT );
            engine_hide_unit_menu();
            status = STATUS_MERGE;
            draw_map = 1;
            break;
        case ID_UNDO:
            engine_undo_move( cur_unit );
            engine_select_unit( cur_unit );
            engine_focus( cur_unit->x, cur_unit->y, 0 );
            draw_map = 1;
            engine_hide_unit_menu();
            break;
        case ID_RENAME:
            engine_hide_unit_menu();
            status = STATUS_RENAME;
            edit_show( gui->edit, cur_unit->name );
            scroll_block_keys = 1;
            break;
        case ID_DEPLOY:
            engine_hide_game_menu();
            engine_select_unit( 0 );
            gui_show_deploy_window();
            map_get_deploy_mask( deploy_unit );
            map_set_fog( F_DEPLOY );
            status = STATUS_DEPLOY;
            draw_map = 1;
            break;
        case ID_STRAT_MAP:
            engine_hide_game_menu();
            status = STATUS_STRAT_MAP;
            strat_map_update_terrain_layer();
            strat_map_update_unit_layer();
            set_delay( &blink_delay, 500 );
            draw_map = 1;
            break; 
        case ID_SCEN_CANCEL:
            fdlg_hide( gui->scen_dlg, 1 );
            engine_set_status( STATUS_NONE );
            break;
        case ID_SCEN_OK:
            fdlg_hide( gui->scen_dlg, 1 );
            engine_set_status( STATUS_NONE );
            action_queue_start_scen();
            break;
        case ID_CAMP_CANCEL:
            fdlg_hide( gui->camp_dlg, 1 );
            engine_set_status( STATUS_NONE );
            break;
        case ID_CAMP_OK:
            fdlg_hide( gui->camp_dlg, 1 );
            engine_set_status( STATUS_NONE );
            action_queue_start_camp();
            break;
        case ID_SCEN_SETUP:
            fdlg_hide( gui->scen_dlg, 1 );
            gui_open_scen_setup();
            status = STATUS_RUN_SETUP;
            break;
        case ID_SETUP_OK:
            fdlg_hide( gui->scen_dlg, 0 );
            sdlg_hide( gui->setup, 1 );
            status = STATUS_RUN_SCEN_DLG;
            break;
        case ID_SETUP_SUPPLY:
            config.supply = !config.supply;
            break;
        case ID_SETUP_WEATHER:
            config.weather = !config.weather;
            break;
        case ID_SETUP_FOG:
            config.fog_of_war = !config.fog_of_war;
            break;
        case ID_SETUP_CTRL:
            setup.ctrl[gui->setup->sel_id] = !setup.ctrl[gui->setup->sel_id];
            gui_handle_player_select( gui->setup->list->cur_item );
            break;
        case ID_SETUP_MODULE:
            sdlg_hide( gui->setup, 1 );
            group_set_active( gui->module_dlg->group, ID_MODULE_OK, 0 );
            group_set_active( gui->module_dlg->group, ID_MODULE_CANCEL, 1 );
            sprintf( path, "%s/ai_modules", SRC_DIR );
            fdlg_open( gui->module_dlg, path );
            status = STATUS_RUN_MODULE_DLG;
            break;
        case ID_MODULE_OK:
            if ( gui->module_dlg->lbox->cur_item ) {
                if ( gui->module_dlg->subdir[0] != 0 )
                    sprintf( path, "%s/%s", gui->module_dlg->subdir, (char*)gui->module_dlg->lbox->cur_item );
                else
                    sprintf( path, (char*)gui->module_dlg->lbox->cur_item );
                free( setup.modules[gui->setup->sel_id] );
                setup.modules[gui->setup->sel_id] = strdup( path );
                gui_handle_player_select( gui->setup->list->cur_item );
            }
        case ID_MODULE_CANCEL:
            fdlg_hide( gui->module_dlg, 1 );
            sdlg_hide( gui->setup, 0 );
            status = STATUS_RUN_SETUP;
            break;
        case ID_DEPLOY_UP:
            gui_scroll_deploy_up();
            break;
        case ID_DEPLOY_DOWN:
            gui_scroll_deploy_down();
            break;
        case ID_APPLY_DEPLOY:
            /* transfer all units with x != -1 */
            list_reset( avail_units );
            while ( ( unit = list_next( avail_units ) ) )
                if ( unit->x != -1 )
                    action_queue_deploy( unit, unit->x, unit->y );
            if ( cur_ctrl == PLAYER_CTRL_HUMAN ) {
                action_queue_set_spot_mask();
                action_queue_draw_map();
            }
            engine_set_status( STATUS_NONE );
            group_hide( gui->deploy_window, 1 );
            break;
        case ID_CANCEL_DEPLOY:
            list_reset( avail_units );
            while ( ( unit = list_next( avail_units ) ) )
                if ( unit->x != -1 )
                    map_remove_unit( unit );
            draw_map = 1;
            engine_set_status( STATUS_NONE );
            group_hide( gui->deploy_window, 1 );
            map_set_fog( F_SPOT );
            break;
    }
}

/*
====================================================================
Get actions from input events or CPU and queue them.
====================================================================
*/
static void engine_check_events()
{
    int region;
    int hide_edit = 0;
    SDL_Event event;
    Unit *unit;
    int cx, cy, button = 0;
    int mx, my;
    SDL_PumpEvents(); /* gather events in the queue */
    if ( sdl_quit ) term_game = 1; /* end game by window manager */
    if ( status == STATUS_MOVE || status == STATUS_ATTACK )
        return;
    if ( cur_ctrl == PLAYER_CTRL_CPU ) {
        if ( actions_count() == 0 )
            (cur_player->ai_run)();
    }
    else {
        if ( event_get_motion( &cx, &cy ) ) {
            if ( setup.type != SETUP_RUN_TITLE ) {
                if ( status == STATUS_DEPLOY || status == STATUS_DEPLOY_INFO ) {
                    gui_handle_deploy_motion( cx, cy, &unit );
                    if ( unit ) {
                        if ( status == STATUS_DEPLOY_INFO )
                            gui_show_full_info( unit );
                        /* display info of this unit */
                        gui_show_quick_info( gui->qinfo1, unit );
                        frame_hide( gui->qinfo2, 1 );
                    }
                }
                if ( engine_get_map_pos( cx, cy, &mx, &my, &region ) ) {
                    /* mouse motion */
                    if ( mx != old_mx || my != old_my || region != old_region ) {
                        old_mx = mx; old_my = my, old_region = region;
                        engine_update_info( mx, my, region );
                    }
                }
            }
            gui_handle_motion( cx, cy );
        }
        if ( event_get_buttondown( &button, &cx, &cy ) ) {
            /* click */
            if ( gui_handle_button( button, cx, cy, &last_button ) ) {
                engine_handle_button( last_button->id );
#ifdef WITH_SOUND
                wav_play( gui->wav_click );
#endif                
            }
            else {
                switch ( status ) {
                    case STATUS_TITLE:
                        /* title menu */
                        if ( button == BUTTON_RIGHT )
                            engine_show_game_menu( cx, cy );
                        break;
                    case STATUS_TITLE_MENU:
                        if ( button == BUTTON_RIGHT )
                            engine_hide_game_menu();
                        break;
                    default:
                        if ( setup.type == SETUP_RUN_TITLE ) break;
                        /* checking mouse wheel */
                        if ( status == STATUS_NONE ) {
                            if( button == WHEEL_UP ) {
                                scroll_vert = SCROLL_UP;
                                engine_check_scroll( SC_BY_WHEEL );
                            }
                            else if( button == WHEEL_DOWN ) {
                                scroll_vert = SCROLL_DOWN;
                                engine_check_scroll( SC_BY_WHEEL );
                            }
                        }
                        /* select unit from deploy window */
                        if ( status == STATUS_DEPLOY) {
                            if ( gui_handle_deploy_click(button, cx, cy) ) {
                                if ( button == BUTTON_RIGHT ) {
                                    engine_show_deploy_unit_info( deploy_unit );
                                }
                                map_get_deploy_mask( deploy_unit );
                                map_set_fog( F_DEPLOY );
                                draw_map = 1;
                                break;
                            }
                        }
                        /* selection only from map */
                        if ( !engine_get_map_pos( cx, cy, &mx, &my, &region ) ) break;
                        switch ( status ) {
                            case STATUS_STRAT_MAP:
                                /* switch from strat map to tactical map */
                                if ( button == BUTTON_LEFT )
                                    engine_focus( mx, my, 0 );
                                engine_set_status( STATUS_NONE );
                                old_mx = old_my = -1;
                                /* before updating the map, clear the screen */
                                SDL_FillRect( sdl.screen, 0, 0x0 );
                                draw_map = 1;
                                break;
                            case STATUS_GAME_MENU:
                                if ( button == BUTTON_RIGHT )
                                    engine_hide_game_menu();
                                break;
                            case STATUS_DEPLOY_INFO:    
                                engine_hide_deploy_unit_info();
                                break;
                            case STATUS_DEPLOY:
                                /* deploy/undeploy */
                                if ( button == BUTTON_LEFT ) {
                                    /* deploy */
                                    if ( deploy_unit && map_check_deploy( deploy_unit, mx, my ) ) {
                                        deploy_unit->x = mx; deploy_unit->y = my;
                                        deploy_unit->fresh_deploy = 1;
                                        map_insert_unit( deploy_unit );
                                        gui_remove_deploy_unit( deploy_unit );
                                        if ( deploy_unit ) {
                                            map_get_deploy_mask( deploy_unit );
                                            map_set_fog( F_DEPLOY );
                                        }
                                        else {
                                            map_clear_mask( F_DEPLOY );
                                            map_set_fog( F_DEPLOY );
                                        }
                                        draw_map = 1;
                                    }
                                else
                                    /* undeploy */
                                    if ( ( unit = map_get_undeploy_unit( mx, my, region == REGION_AIR ) ) ) {
                                        map_remove_unit( unit );
                                        unit->x = -1; unit->y = -1;
                                        gui_add_deploy_unit( unit );
                                        map_get_deploy_mask( deploy_unit );
                                        map_set_fog( F_DEPLOY );
                                        draw_map = 1;
                                    }
                                    else 
                                       if ( mask[mx][my].spot && ( unit = engine_get_prim_unit( mx, my, region ) ) ) {
                                           /* info */
                                           engine_show_deploy_unit_info( unit );
                                       }
                                }
                                break;
                            case STATUS_MERGE:
                                if ( button == BUTTON_RIGHT ) {
                                    /* clear status */
                                    engine_set_status( STATUS_NONE );
                                    map_set_fog( F_SPOT );
                                    draw_map = 1;
                                }
                                else 
                                    if ( button == BUTTON_LEFT )
                                        if ( mask[mx][my].merge_unit ) {
                                            action_queue_merge( cur_unit, mask[mx][my].merge_unit );
                                            map_set_fog( F_SPOT );
                                            engine_set_status( STATUS_NONE );
                                            draw_map = 1;
                                        }
                                break;
                            case STATUS_UNIT_MENU:
                                if ( button == BUTTON_RIGHT )
                                    engine_hide_unit_menu();
                                break;
                            case STATUS_SCEN_INFO:
                                engine_set_status( STATUS_NONE );
                                frame_hide( gui->sinfo, 1 );
                                old_mx = old_my = -1;
                                break;
                            case STATUS_INFO:
                                engine_set_status( STATUS_NONE );
                                frame_hide( gui->finfo, 1 );
                                old_mx = old_my = -1;
                                break;
                            case STATUS_NONE:
                                switch ( button ) {
                                    case BUTTON_LEFT:
                                        if ( cur_unit ) {
                                            /* handle current unit */
                                            if ( cur_unit->x == mx && cur_unit->y == my && engine_get_prim_unit( mx, my, region ) == cur_unit )
                                                engine_show_unit_menu( cx, cy );
                                            else
                                            if ( ( unit = engine_get_target( mx, my, region ) ) ) {
                                                action_queue_attack( cur_unit, unit );
                                                frame_hide( gui->qinfo1, 1 );
                                                frame_hide( gui->qinfo2, 1 );
                                            }
                                            else
                                                if ( mask[mx][my].in_range && !mask[mx][my].blocked ) {
                                                    action_queue_move( cur_unit, mx, my );
                                                    frame_hide( gui->qinfo1, 1 );
                                                    frame_hide( gui->qinfo2, 1 );
                                                }
                                                else
                                                    if ( mask[mx][my].sea_embark ) {
                                                        if ( cur_unit->embark == EMBARK_NONE )
                                                            action_queue_embark_sea( cur_unit, mx, my );
                                                        else
                                                            action_queue_debark_sea( cur_unit, mx, my );
                                                        engine_backup_move( cur_unit, mx, my );
                                                        draw_map = 1;
                                                    }
                                                    else
                                                        if ( ( unit = engine_get_select_unit( mx, my, region ) ) && cur_unit != unit ) {
                                                            /* first capture the flag for the human unit */
                                                            if ( cur_ctrl == PLAYER_CTRL_HUMAN ) {
                                                                if ( engine_capture_flag( cur_unit ) ) {
                                                                    /* CHECK IF SCENARIO IS FINISHED */
                                                                    if ( scen_check_result( 0 ) )  {
                                                                        engine_finish_scenario();
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                            engine_select_unit( unit );
                                                            engine_clear_backup();
                                                            engine_update_info( mx, my, region );
                                                            draw_map = 1;
                                                        }
                                        }
                                        else
                                            if ( ( unit = engine_get_select_unit( mx, my, region ) ) && cur_unit != unit ) {
                                                /* select unit */
                                                engine_select_unit( unit );
                                                engine_update_info( mx, my, region );
                                                draw_map = 1;
#ifdef WITH_SOUND
                                                wav_play( terrain_icons->wav_select );
#endif
                                            }
                                        break;
                                    case BUTTON_RIGHT:
                                        if ( cur_unit == 0 ) {
                                            if ( mask[mx][my].spot && ( unit = engine_get_prim_unit( mx, my, region ) ) ) {
                                                /* show unit info */
                                                gui_show_full_info( unit );
                                                status = STATUS_INFO;
                                                gui_set_cursor( CURSOR_STD );
                                            }
                                            else {
                                                /* show menu */
                                                engine_show_game_menu( cx, cy );
                                            }
                                        }
                                        else
                                            if ( cur_unit ) {
                                                /* handle current unit */
                                                if ( cur_unit->x == mx && cur_unit->y == my && engine_get_prim_unit( mx, my, region ) == cur_unit )
                                                    engine_show_unit_menu( cx, cy );
                                                else {
                                                    /* first capture the flag for the human unit */
                                                    if ( cur_ctrl == PLAYER_CTRL_HUMAN ) {
                                                        if ( engine_capture_flag( cur_unit ) ) {
                                                            /* CHECK IF SCENARIO IS FINISHED */
                                                            if ( scen_check_result( 0 ) )  {
                                                                engine_finish_scenario();
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    /* release unit */
                                                    engine_select_unit( 0 );
                                                    engine_update_info( mx, my, region );
                                                    draw_map = 1;
                                                }
                                            }
                                        break;
                                }
                                break;
                        }
                    }
            }
        }
        else
            if ( event_get_buttonup( &button, &cx, &cy ) ) {
                /* if there was a button pressed released it */
                if ( last_button ) {
                    if ( !last_button->lock ) {
                        last_button->down = 0;
                        if ( last_button->active )
                            last_button->button_rect.x = 0;
                    }
                    if ( last_button->button_rect.x == 0 )
                        if ( button_focus( last_button, cx, cy ) )
                            last_button->button_rect.x = last_button->surf_rect.w;
                    last_button = 0;
                }
            }
        if ( status == STATUS_NONE || status == STATUS_INFO ) {
            if ( SDL_PollEvent( &event ) )
                if ( event.type == SDL_KEYDOWN ) {
                    if ( event.key.keysym.sym == SDLK_n ) {
                        /* select next unit that has either movement
                           or attack left */
                        list_reset( units );
                        if ( cur_unit != 0 )
                            while ( ( unit = list_next( units ) ) )
                                if ( cur_unit == unit ) 
                                    break;
                        /* get next unit */
                        while ( ( unit = list_next( units ) ) ) {
                            if ( unit->killed ) continue;
                            if ( unit->player == cur_player )
                                if ( unit->cur_mov > 0 || unit->cur_atk_count > 0 )
                                    break;
                        }
                        if ( unit == 0 ) {
                            /* search again from beginning of list */
                            list_reset( units );
                            while ( ( unit = list_next( units ) ) ) {
                                if ( unit->killed ) continue;
                                if ( unit->player == cur_player )
                                    if ( unit->cur_mov > 0 || unit->cur_atk_count > 0 )
                                        break;
                            }
                        }
                        if ( unit ) {
                            engine_select_unit( unit );
                            engine_focus( cur_unit->x, cur_unit->y, 0 );
                            draw_map = 1;
                            if ( status == STATUS_INFO )
                                gui_show_full_info( unit );
                        }
                    } else
                    if ( event.key.keysym.sym == SDLK_p ) {
                        /* select previous unit that has either movement
                           or attack left */
                        list_reset( units );
                        if ( cur_unit != 0 )
                            while ( ( unit = list_next( units ) ) )
                                if ( cur_unit == unit ) 
                                    break;
                        /* get previous unit */
                        while ( ( unit = list_prev( units ) ) ) {
                            if ( unit->killed ) continue;
                            if ( unit->player == cur_player )
                                if ( unit->cur_mov > 0 || unit->cur_atk_count > 0 )
                                    break;
                        }
                        if ( unit == 0 ) {
                            /* search again from end of list */
                            units->cur_entry = &units->tail;
                            while ( ( unit = list_prev( units ) ) ) {
                                if ( unit->killed ) continue;
                                if ( unit->player == cur_player )
                                    if ( unit->cur_mov > 0 || unit->cur_atk_count > 0 )
                                        break;
                            }
                        }
                        if ( unit ) {
                            engine_select_unit( unit );
                            engine_focus( cur_unit->x, cur_unit->y, 0 );
                            draw_map = 1;
                            if ( status == STATUS_INFO )
                                gui_show_full_info( unit );
                        }
                    }
                }
        }
        if ( status == STATUS_RENAME || status == STATUS_SAVE ) {
            if ( SDL_PollEvent( &event ) ) {
                if ( event.type == SDL_KEYDOWN ) {
                    if ( event.key.keysym.sym == SDLK_RETURN ) {
                        /* apply */
                        switch ( status ) {
                            case STATUS_RENAME:
                                strcpy_lt( cur_unit->name, gui->edit->text, 20 );
                                hide_edit = 1;
                                break;
                            case STATUS_SAVE:
                                slot_save( slot_id, gui->edit->text );
                                hide_edit = 1;
                                printf( "Game saved to slot '%i' as '%s'.\n", slot_id, gui->edit->text );
                                break;
                        }
                    }
                    else
                        if ( event.key.keysym.sym == SDLK_ESCAPE )
                            hide_edit = 1;
                    if ( hide_edit ) {    
                        engine_set_status( STATUS_NONE );
                        edit_hide( gui->edit, 1 );
                        old_mx = old_my = -1;
                        scroll_block_keys = 0;
                    }
                    else {
                        edit_handle_key( gui->edit, event.key.keysym.sym, event.key.keysym.unicode );
#ifdef WITH_SOUND
                        wav_play( gui->wav_edit );
#endif
                    }
                }
            }
        }
        /* scrolling */
        engine_check_scroll( SC_NORMAL );
    }
}

/*
====================================================================
Get next combatants assuming that cur_unit attacks cur_target.
Set cur_atk and cur_def and return True if there are any more
combatants.
====================================================================
*/
static int engine_get_next_combatants()
{
    int fight = 0;
    char str[128];
    /* check if there are supporting units; if so initate fight 
       between attacker and these units */
    if ( df_units->count > 0 ) {
        cur_atk = list_first( df_units );
        cur_def = cur_unit;
        fight = 1;
        defFire = 1;
        /* set message if seen */
        if ( !blind_cpu_turn ) {
            if ( cur_atk->sel_prop->flags & ARTILLERY )
                sprintf( str, "Defensive Fire" );
            else
                if ( cur_atk->sel_prop->flags & AIR_DEFENSE )
                    sprintf( str, "Air-Defense" );
                else
                    sprintf( str, "Interceptors" );
            label_write( gui->label, gui->font_error, str );
        }
    }
    else {
        /* clear info */
        if ( !blind_cpu_turn ) 
            label_hide( gui->label, 1 );
        /* normal attack */
        cur_atk = cur_unit;
        cur_def = cur_target;
        fight = 1;
        defFire = 0;
    }
    return fight;
}

/*
====================================================================
Unit is completely suppressed so check if it
  does nothing
  tries to move to a neighbored tile
  surrenders because it can't move away
====================================================================
*/
enum {
    UNIT_STAYS = 0,
    UNIT_FLEES,
    UNIT_SURRENDERS
};
static void engine_handle_suppr( Unit *unit, int *type, int *x, int *y )
{
    int i, nx, ny;
    *type = UNIT_STAYS;
    if ( unit->sel_prop->mov == 0 ) return;
    /* 80% chance that unit wants to flee */
    if ( RANDOM( 1, 10 ) <= 8 ) {
        unit->cur_mov = 1;
        map_get_unit_move_mask( unit );
        /* get best close hex. if none: surrender */
        for ( i = 0; i < 6; i++ )
            if ( get_close_hex_pos( unit->x, unit->y, i, &nx, &ny ) )
                if ( mask[nx][ny].in_range && !mask[nx][ny].blocked ) {
                    *type = UNIT_FLEES;
                    *x = nx; *y = ny;
                    return;
                }
        /* surrender! */
        *type = UNIT_SURRENDERS;
    }
}

/*
====================================================================
Check if unit stays on top of an enemy flag and capture
it. Return True if the flag was captured.
====================================================================
*/
static int engine_capture_flag( Unit *unit ) {
    if ( !( unit->sel_prop->flags & FLYING ) )
        if ( !( unit->sel_prop->flags & SWIMMING ) )
            if ( map[unit->x][unit->y].nation != 0 )
                if ( !player_is_ally( map[unit->x][unit->y].player, unit->player ) ) {
                    /* capture */
                    map[unit->x][unit->y].nation = unit->nation;
                    map[unit->x][unit->y].player = unit->player;
                    /* a conquered flag looses it's deploy ability */
                    map[unit->x][unit->y].deploy_center = 0;
                    return 1;
                }
    return 0;
}
                                
/*
====================================================================
Deqeue the next action and perform it.
====================================================================
*/
static void engine_handle_next_action( int *reinit )
{
    Action *action = 0;
    int enemy_spotted = 0;
    int depth, flags, i, j;
    /* lock action queue? */
    if ( status == STATUS_CONF || status == STATUS_ATTACK || status == STATUS_MOVE )
        return;
    /* get action */
    if ( ( action = actions_dequeue() ) == 0 ) 
        return;
    /* handle it */
    switch ( action->type ) {
        case ACTION_START_SCEN:
            camp_delete();
            setup.type = SETUP_INIT_SCEN;
            *reinit = 1;
            end_scen = 1;
            break;
        case ACTION_START_CAMP:
            setup.type = SETUP_INIT_CAMP;
            *reinit = 1;
            end_scen = 1;
            break;
        case ACTION_OVERWRITE:
            status = STATUS_SAVE;
            edit_show( gui->edit, slot_get_name( action->id ) );
            scroll_block_keys = 1;
            slot_id = action->id;
            break;
        case ACTION_LOAD:
            setup.type = SETUP_LOAD_GAME;
            strcpy( setup.fname, slot_get_fname( action->id ) );
            setup.slot_id = action->id;
            *reinit = 1;
            end_scen = 1;
            break;
        case ACTION_RESTART:
            strcpy( setup.fname, scen_info->fname );
            setup.type = SETUP_INIT_SCEN;
            *reinit = 1;
            end_scen = 1;
            break;
        case ACTION_QUIT:
            engine_set_status( STATUS_NONE );
            end_scen = 1;
            break;
        case ACTION_SET_VMODE:
            flags = SDL_SWSURFACE;
            if ( action->full ) flags |= SDL_FULLSCREEN;
            depth = SDL_VideoModeOK( action->w, action->h, 32, flags );
            if ( depth == 0 ) {
                fprintf( stderr, "Video Mode: %ix%i, Fullscreen: %i not available\n", 
                         action->w, action->h, action->full );
            }
            else {
                /* videmode */
                SDL_SetVideoMode( action->w, action->h, depth, flags );
                /* adjust windows */
                gui_adjust();
                if ( setup.type != SETUP_RUN_TITLE ) {
                    /* reset engine's map size (number of tiles on screen) */
                    for ( i = map_sx, map_sw = 0; i < sdl.screen->w; i += hex_x_offset )
                        map_sw++;
                    for ( j = map_sy, map_sh = 0; j < sdl.screen->h; j += hex_h )
                        map_sh++;
                    /* reset map pos if nescessary */
                    if ( map_x + map_sw >= map_w )
                        map_x = map_w - map_sw;
                    if ( map_y + map_sh >= map_h )
                        map_y = map_h - map_sh;
                    if ( map_x < 0 ) map_x = 0;
                    if ( map_y < 0 ) map_y = 0;
                    /* recreate strategic map */
                    strat_map_delete();
                    strat_map_create();
                    /* recreate screen buffer */
                    free_surf( &sc_buffer );
                    sc_buffer = create_surf( sdl.screen->w, sdl.screen->h, SDL_SWSURFACE );
                }
                /* redraw map */
                draw_map = 1;
                /* set config */
                config.width = action->w;
                config.height = action->h;
                config.fullscreen = flags & SDL_FULLSCREEN;
            }
            break;
        case ACTION_SET_SPOT_MASK:
            map_set_spot_mask();
            map_set_fog( F_SPOT );
            break;
        case ACTION_DRAW_MAP:
            draw_map = 1;
            break;
        case ACTION_DEPLOY:
            action->unit->delay = 0;
            action->unit->fresh_deploy = 0;
            action->unit->x = action->x;
            action->unit->y = action->y;
            list_transfer( avail_units, units, action->unit );
            if ( cur_ctrl == PLAYER_CTRL_CPU ) /* for human player it is already inserted */
                map_insert_unit( action->unit );
            scen_prep_unit( action->unit, SCEN_PREP_UNIT_FIRST );
            break;
        case ACTION_EMBARK_SEA:
            if ( map_check_unit_embark( action->unit, action->x, action->y, EMBARK_SEA ) ) {
                map_embark_unit( action->unit, action->x, action->y, EMBARK_SEA, &enemy_spotted );
                if ( enemy_spotted ) engine_clear_backup();
                if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                    engine_select_unit( action->unit );
            }
            break;
        case ACTION_DEBARK_SEA:
            if ( map_check_unit_debark( action->unit, action->x, action->y, EMBARK_SEA ) ) {
                map_debark_unit( action->unit, action->x, action->y, EMBARK_SEA, &enemy_spotted );
                if ( enemy_spotted ) engine_clear_backup();
                if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                    engine_select_unit( action->unit );
                /* CHECK IF SCENARIO IS FINISHED (by capturing last flag) */
                if ( scen_check_result( 0 ) )  {
                    engine_finish_scenario();
                    break;
                }
            }
            break;
        case ACTION_MERGE:
            if ( unit_check_merge( action->unit, action->target ) ) {
                unit_merge( action->unit, action->target );
                engine_remove_unit( action->target );
                map_get_vis_units();
                if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                    engine_select_unit( action->unit );
            }
            break;
        case ACTION_EMBARK_AIR:
            if ( map_check_unit_embark( action->unit, action->x, action->y, EMBARK_AIR ) ) {
                map_embark_unit( action->unit, action->x, action->y, EMBARK_AIR, &enemy_spotted );
                if ( enemy_spotted ) engine_clear_backup();
                if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                    engine_select_unit( action->unit );
            }
            break;
        case ACTION_DEBARK_AIR:
            if ( map_check_unit_debark( action->unit, action->x, action->y, EMBARK_AIR ) ) {
                map_debark_unit( action->unit, action->x, action->y, EMBARK_AIR, &enemy_spotted );
                if ( enemy_spotted ) engine_clear_backup();
                if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                    engine_select_unit( action->unit );
                /* CHECK IF SCENARIO IS FINISHED (by capturing last flag) */
                if ( scen_check_result( 0 ) )  {
                    engine_finish_scenario();
                    break;
                }
            }
            break;
        case ACTION_SUPPLY:
            if ( unit_check_supply( action->unit, UNIT_SUPPLY_ANYTHING, 0, 0 ) )
                unit_supply( action->unit, UNIT_SUPPLY_ALL );
            break;
        case ACTION_END_TURN:
            engine_end_turn( 0, 0 );
            break;
        case ACTION_MOVE:
            cur_unit = action->unit;
            move_unit = action->unit;
            if ( move_unit->cur_mov == 0 ) {
                fprintf( stderr, "'%s' has no move points remaining\n", move_unit->name );
                break;
            }
            dest_x = action->x;
            dest_y = action->y;
            status = STATUS_MOVE;
            phase = PHASE_INIT_MOVE;
            if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                image_hide( gui->cursors, 1 );
            break;
        case ACTION_ATTACK:
            if ( !unit_check_attack( action->unit, action->target, UNIT_ACTIVE_ATTACK ) ) {
                fprintf( stderr, "'%s' (%i,%i) can not attack '%s' (%i,%i)\n", 
                         action->unit->name, action->unit->x, action->unit->y,
                         action->target->name, action->target->x, action->target->y );
                break;
            }
            if ( !mask[action->target->x][action->target->y].spot ) {
                fprintf( stderr, "'%s' may not attack unit '%s' (not visible)\n", action->unit->name, action->target->name );
                break;
            }
            cur_unit = action->unit;
            cur_target = action->target;
            unit_get_df_units( cur_unit, cur_target, units, df_units );
            if ( engine_get_next_combatants() ) {
                status = STATUS_ATTACK;
                phase = PHASE_INIT_ATK;
                if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                    image_hide( gui->cursors, 1 );
            }
            break;
    }
    free( action );
}

/*
====================================================================
Update the engine if an action is currently handled.
====================================================================
*/
static void engine_update( int ms )
{
    int cx, cy;
    int old_atk_str, old_def_str;
    int old_atk_suppr, old_def_suppr;
    int old_atk_turn_suppr, old_def_turn_suppr;
    int reset = 0;
    int broken_up = 0;
    int was_final_fight = 0;
    int type = UNIT_STAYS, dx, dy;
    int start_x, start_y, end_x, end_y;
    float len;
    int i;
    int enemy_spotted = 0;
    int surrender = 0;
    /* check status and phase */
    switch ( status ) {
        case STATUS_MOVE:
            switch ( phase ) {
                case PHASE_INIT_MOVE:
                    /* get move mask */
                    map_get_unit_move_mask( move_unit );
                    /* check if tile is in reach */
                    if ( mask[dest_x][dest_y].in_range == 0 ) {
                        fprintf( stderr, "%i,%i out of reach for '%s'\n", dest_x, dest_y, move_unit->name );
                        phase = PHASE_END_MOVE;
                        break;
                    }
                    if ( mask[dest_x][dest_y].blocked ) {
                        fprintf( stderr, "%i,%i is blocked ('%s' wants to move there)\n", dest_x, dest_y, move_unit->name );
                        phase = PHASE_END_MOVE;
                        break;
                    }
                    way = map_get_unit_way_points( move_unit, dest_x, dest_y, &way_length, &surp_unit );
                    if ( way == 0 ) {
                        fprintf( stderr, "There is no way for unit '%s' to move to %i,%i\n", 
                                 move_unit->name, dest_x, dest_y );
                        phase = PHASE_END_MOVE;
                        break;
                    }
                    /* remove unit influence */
                    if ( !player_is_ally( move_unit->player, cur_player ) ) 
                        map_remove_unit_infl( move_unit );
                    /* backup the unit but only if this is not a fleeing unit! */
                    if ( fleeing_unit )
                        fleeing_unit = 0;
                    else
                        engine_backup_move( move_unit, dest_x, dest_y );
                    /* if ground transporter needed mount unit */
                    if ( mask[dest_x][dest_y].mount ) unit_mount( move_unit );
                    /* start at first way point */
                    way_pos = 0;
                    /* unit's used */
                    move_unit->unused = 0;
                    /* artillery looses ability to attack */
                    if ( move_unit->sel_prop->flags & ATTACK_FIRST )
                        move_unit->cur_atk_count = 0;
                    /* decrease moving points */
/*                    if ( ( move_unit->sel_prop->flags & RECON ) && surp_unit == 0 )
                        move_unit->cur_mov = mask[dest_x][dest_y].in_range - 1;
                    else*/
                        move_unit->cur_mov = 0;
                    if ( move_unit->cur_mov < 0 ) 
                        move_unit->cur_mov = 0;
                    /* decrease fuel */
                    if ( unit_check_fuel_usage( move_unit ) && config.supply ) {
                        move_unit->cur_fuel -= way_length - 1;
                        if ( weather_types[scen_get_weather()].flags & DOUBLE_FUEL_COST )
                            move_unit->cur_fuel -= way_length - 1;
                        if ( move_unit->cur_fuel < 0 )
                            move_unit->cur_fuel = 0;
                    }
                    /* no entrenchment */
                    move_unit->entr = 0;
                    /* build up the image */
                    if ( !blind_cpu_turn ) {
                        move_image = image_create( create_surf( move_unit->sel_prop->icon->w, 
                                                                move_unit->sel_prop->icon->h, SDL_SWSURFACE ),
                                                   move_unit->sel_prop->icon_w, move_unit->sel_prop->icon_h,
                                                   sdl.screen, 0, 0 ); 
                        image_set_region( move_image, move_unit->icon_offset, 0, 
                                          move_unit->sel_prop->icon_w, move_unit->sel_prop->icon_h );
                        SDL_FillRect( move_image->img, 0, move_unit->sel_prop->icon->format->colorkey );
                        SDL_SetColorKey( move_image->img, SDL_SRCCOLORKEY, move_unit->sel_prop->icon->format->colorkey );
                        FULL_DEST( move_image->img );
                        FULL_SOURCE( move_unit->sel_prop->icon );
                        blit_surf();
                        if ( mask[move_unit->x][move_unit->y].fog )
                            image_hide( move_image, 1 );
                    }
                    /* remove unit from map */
                    map_remove_unit( move_unit );
                    if ( !blind_cpu_turn ) {
                        engine_get_screen_pos( move_unit->x, move_unit->y, &start_x, &start_y );
                        start_x += ( ( hex_w - move_unit->sel_prop->icon_w ) >> 1 );
                        start_y += ( ( hex_h - move_unit->sel_prop->icon_h ) >> 1 );
                        image_move( move_image, start_x, start_y );
                        draw_map = 1;
                    }
                    /* animate */
                    phase = PHASE_START_SINGLE_MOVE;
                    /* play sound */
#ifdef WITH_SOUND   
                    if ( !mask[move_unit->x][move_unit->y].fog )
                        wav_play( move_unit->sel_prop->wav_move );
#endif
                    break;
                case PHASE_START_SINGLE_MOVE:
                    /* get next start way point */
                    if ( blind_cpu_turn ) {
                        way_pos = way_length - 1;
                        /* quick move unit */
                        for ( i = 1; i < way_length; i++ ) {
                            move_unit->x = way[i].x; move_unit->y = way[i].y;
                            map_update_spot_mask( move_unit, &enemy_spotted );
                        }
                    }
                    else
                        if ( !modify_fog ) {
                            i = way_pos;
                            while ( i + 1 < way_length && mask[way[i].x][way[i].y].fog && mask[way[i + 1].x][way[i + 1].y].fog ) {
                                i++;
                                /* quick move unit */
                                move_unit->x = way[i].x; move_unit->y = way[i].y;
                                map_update_spot_mask( move_unit, &enemy_spotted );
                            }
                            way_pos = i;
                        }
                    /* focus current way point */
                    if ( way_pos < way_length - 1 )
                        if ( !blind_cpu_turn && ( MAP_CHECK_VIS( way[way_pos].x, way[way_pos].y ) || MAP_CHECK_VIS( way[way_pos + 1].x, way[way_pos + 1].y ) ) ) {
                            if ( engine_focus( way[way_pos].x, way[way_pos].y, 1 ) ) {
                                engine_get_screen_pos( way[way_pos].x, way[way_pos].y, &start_x, &start_y );
                                start_x += ( ( hex_w - move_unit->sel_prop->icon_w ) >> 1 );
                                start_y += ( ( hex_h - move_unit->sel_prop->icon_h ) >> 1 );
                                image_move( move_image, start_x, start_y );
                            }
                        }
                    /* units looking direction */
                    unit_adjust_orient( move_unit, way[way_pos].x, way[way_pos].y );
                    if ( !blind_cpu_turn )
                        image_set_region( move_image, move_unit->icon_offset, 0, 
                                          move_unit->sel_prop->icon_w, move_unit->sel_prop->icon_h );
                    /* units position */
                    move_unit->x = way[way_pos].x; move_unit->y = way[way_pos].y;
                    /* update spotting */
                    map_update_spot_mask( move_unit, &enemy_spotted );
                    if ( modify_fog ) map_set_fog( F_SPOT );
                    if ( enemy_spotted ) {
                        /* if you spotted an enemy it's not allowed to undo the turn */
                        engine_clear_backup();
                    }
                    /* determine next step */
                    if ( way_pos == way_length - 1 )
                        phase = PHASE_CHECK_LAST_MOVE;
                    else {
                        /* animate? */
                        if ( MAP_CHECK_VIS( way[way_pos].x, way[way_pos].y ) || MAP_CHECK_VIS( way[way_pos + 1].x, way[way_pos + 1].y ) ) {
                            engine_get_screen_pos( way[way_pos].x, way[way_pos].y, &start_x, &start_y );
                            start_x += ( ( hex_w - move_unit->sel_prop->icon_w ) >> 1 );
                            start_y += ( ( hex_h - move_unit->sel_prop->icon_h ) >> 1 );
                            engine_get_screen_pos( way[way_pos + 1].x, way[way_pos + 1].y, &end_x, &end_y );
                            end_x += ( ( hex_w - move_unit->sel_prop->icon_w ) >> 1 );
                            end_y += ( ( hex_h - move_unit->sel_prop->icon_h ) >> 1 );
                            unit_vector.x = start_x; unit_vector.y = start_y;
                            move_vector.x = end_x - start_x; move_vector.y = end_y - start_y;
                            len = sqrt( move_vector.x * move_vector.x + move_vector.y * move_vector.y );
                            move_vector.x /= len; move_vector.y /= len;
                            image_move( move_image, (int)unit_vector.x, (int)unit_vector.y );
                            set_delay( &move_time, (int)( len / move_vel ) );
                        }
                        else
                            set_delay( &move_time, 0 );
                        phase = PHASE_RUN_SINGLE_MOVE;
                        image_hide( move_image, 0 );
                    }
                    break;
                case PHASE_RUN_SINGLE_MOVE:
                    if ( timed_out( &move_time, ms ) ) {
                        /* next way point */
                        way_pos++;
                        /* next movement */
                        phase = PHASE_START_SINGLE_MOVE;
                    }
                    else {
                        unit_vector.x += move_vector.x * move_vel * ms;
                        unit_vector.y += move_vector.y * move_vel * ms;
                        image_move( move_image, (int)unit_vector.x, (int)unit_vector.y );
                    }
                    break;
                case PHASE_CHECK_LAST_MOVE:
                    /* insert unit */
                    map_insert_unit( move_unit );
                    /* capture flag if there is one */
                    /* NOTE: only do it for AI. For the human player, it will
                     * be done on deselecting the current unit to resemble
                     * original Panzer General behaviour
                     */
                    if ( cur_ctrl == PLAYER_CTRL_CPU ) {
                        if ( engine_capture_flag( move_unit ) ) {
                            /* CHECK IF SCENARIO IS FINISHED */
                            if ( scen_check_result( 0 ) )  {
                                engine_finish_scenario();
                                break;
                            }
                        }
                    }
                    /* add influence */
                    if ( !player_is_ally( move_unit->player, cur_player ) )
                        map_add_unit_infl( move_unit );
                    /* update the visible units list */
                    map_get_vis_units();
                    map_set_vis_infl_mask();
                    /* next phase */
                    phase = PHASE_END_MOVE;
                    break;
                case PHASE_END_MOVE:
                    /* fade out sound */
#ifdef WITH_SOUND         
                    audio_fade_out( 0, 500 ); /* move sound channel */
#endif
                    /* clear move buffer image */
                    if ( !blind_cpu_turn )
                        image_delete( &move_image );
                    /* run surprise contact */
                    if ( surp_unit ) {
                        cur_unit = move_unit;
                        cur_target = surp_unit;
                        surp_contact = 1;
                        surp_unit = 0;
                        if ( engine_get_next_combatants() ) {
                            status = STATUS_ATTACK;
                            phase = PHASE_INIT_ATK;
                            if ( !blind_cpu_turn ) {
                                image_hide( gui->cursors, 1 );
                                draw_map = 1;
                            }
                        }
                        break;
                    }
                    /* reselect unit -- cur_unit may differ from move_unit! */
                    if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                        engine_select_unit( cur_unit );
                    /* status */
                    engine_set_status( STATUS_NONE );
                    phase = PHASE_NONE;
                    /* allow new human/cpu input */
                    if ( !blind_cpu_turn ) {
                        if ( cur_ctrl == PLAYER_CTRL_HUMAN ) {
                            gui_set_cursor( CURSOR_STD );
                            image_hide( gui->cursors, 0 );
                            old_mx = old_my = -1;
                        }
                        draw_map = 1;
                    }
                    break;
            }
            break;
        case STATUS_ATTACK:
            switch ( phase ) {
                case PHASE_INIT_ATK:
#ifdef DEBUG_ATTACK
                    printf( "\n" );
#endif
                    if ( !blind_cpu_turn ) {
                        if ( MAP_CHECK_VIS( cur_atk->x, cur_atk->y ) ) {
                            /* show attacker cross */
                            engine_focus( cur_atk->x, cur_atk->y, 1 );
                            engine_get_screen_pos( cur_atk->x, cur_atk->y, &cx, &cy );
                            anim_move( terrain_icons->cross, cx, cy );
                            anim_play( terrain_icons->cross, 0 );
                        }
                        phase = PHASE_SHOW_ATK_CROSS;
            		    label_hide( gui->label2, 1 );
                    }
                    else
                        phase = PHASE_COMBAT;
                    break;
                case PHASE_SHOW_ATK_CROSS:
                    if ( !terrain_icons->cross->playing ) {
                        if ( MAP_CHECK_VIS( cur_def->x, cur_def->y ) ) {
                            /* show defender cross */
                            engine_focus( cur_def->x, cur_def->y, 1 );
                            engine_get_screen_pos( cur_def->x, cur_def->y, &cx, &cy );
                            anim_move( terrain_icons->cross, cx, cy );
                            anim_play( terrain_icons->cross, 0 );
                        }
                        phase = PHASE_SHOW_DEF_CROSS;
                    }
                    break;
                case PHASE_SHOW_DEF_CROSS:
                    if ( !terrain_icons->cross->playing )
                        phase = PHASE_COMBAT;
                    break;
                case PHASE_COMBAT:
                    /* backup old strength to see who needs and explosion */
                    old_atk_str = cur_atk->str; old_def_str = cur_def->str;
                    /* backup old suppression to calculate delta */
                    old_atk_suppr = cur_atk->suppr; old_def_suppr = cur_def->suppr;
                    old_atk_turn_suppr = cur_atk->turn_suppr;
                    old_def_turn_suppr = cur_def->turn_suppr;
                    /* take damage */
                    if ( surp_contact )
                        atk_result = unit_surprise_attack( cur_atk, cur_def );
                    else {
                        if ( df_units->count > 0 )
                            atk_result = unit_normal_attack( cur_atk, cur_def, UNIT_DEFENSIVE_ATTACK );
                        else
                            atk_result = unit_normal_attack( cur_atk, cur_def, UNIT_ACTIVE_ATTACK );
                    }
                    /* calculate deltas */
                    atk_damage_delta = old_atk_str - cur_atk->str;
		            def_damage_delta = old_def_str - cur_def->str;
                    atk_suppr_delta = cur_atk->suppr - old_atk_suppr;
		            def_suppr_delta = cur_def->suppr - old_def_suppr;
                    atk_suppr_delta += cur_atk->turn_suppr - old_atk_turn_suppr;
                    def_suppr_delta += cur_def->turn_suppr - old_def_turn_suppr;
                    if ( blind_cpu_turn )
                        phase = PHASE_CHECK_RESULT;
                    else {
                        /* if rugged defense add a pause */
                        if ( atk_result & AR_RUGGED_DEFENSE ) {
                            phase = PHASE_RUGGED_DEF;
                            if ( cur_def->sel_prop->flags & FLYING )
                                label_write( gui->label, gui->font_error, "Out Of The Sun!" );
                            else
                                if ( cur_def->sel_prop->flags & SWIMMING )
                                    label_write( gui->label, gui->font_error, "Surprise Contact!" );
                                else
                                    label_write( gui->label, gui->font_error, "Rugged Defense!" );
                            reset_delay( &msg_delay );
                        }
                        else 
                            phase = PHASE_PREP_EXPLOSIONS;
                    }
                    break;
                case PHASE_RUGGED_DEF:
                    if ( timed_out( &msg_delay, ms ) ) {
                        phase = PHASE_PREP_EXPLOSIONS;
                        label_hide( gui->label, 1 );
                    }
                    break;
                case PHASE_PREP_EXPLOSIONS:
                    engine_focus( cur_def->x, cur_def->y, 1 );
                    if (defFire)
                        gui_show_actual_losses( cur_def, cur_atk, def_suppr_delta, def_damage_delta,
                                                atk_suppr_delta, atk_damage_delta );
                    else
                    {
                        if (cur_atk->sel_prop->flags & TURN_SUPPR)
                            gui_show_actual_losses( cur_atk, cur_def, atk_suppr_delta, atk_damage_delta,
                                                    def_suppr_delta, def_damage_delta );
                        else
                            gui_show_actual_losses( cur_atk, cur_def, 0, atk_damage_delta,
                                                    0, def_damage_delta );
                    }
                    /* attacker epxlosion */
                    if ( atk_damage_delta ) {
                        engine_get_screen_pos( cur_atk->x, cur_atk->y, &cx, &cy );
			            if (!cur_atk->str) map_remove_unit( cur_atk );
                        map_draw_tile( sdl.screen, cur_atk->x, cur_atk->y, cx, cy, !air_mode, 0 );
                        anim_move( terrain_icons->expl1, cx, cy );
                        anim_play( terrain_icons->expl1, 0 );
                    }
                    /* defender explosion */
                    if ( def_damage_delta ) {
                        engine_get_screen_pos( cur_def->x, cur_def->y, &cx, &cy );
                        if (!cur_def->str) map_remove_unit( cur_def );
			            map_draw_tile( sdl.screen, cur_def->x, cur_def->y, cx, cy, !air_mode, 0 );
                        anim_move( terrain_icons->expl2, cx, cy );
                        anim_play( terrain_icons->expl2, 0 );
                    }
                    phase = PHASE_SHOW_EXPLOSIONS;
                    /* play sound */
#ifdef WITH_SOUND                    
                    if ( def_damage_delta || atk_damage_delta )
                        wav_play( terrain_icons->wav_expl );
#endif
                    break;
                case PHASE_SHOW_EXPLOSIONS:
		            if ( !terrain_icons->expl1->playing && !terrain_icons->expl2->playing ) {
                        phase = PHASE_FIGHT_MSG;
                        reset_delay( &msg_delay );
			            anim_hide( terrain_icons->expl1, 1 );
			            anim_hide( terrain_icons->expl2, 1 );
		            }
                    break;
		        case PHASE_FIGHT_MSG:
                    if ( timed_out( &msg_delay, ms ) ) {
                        phase = PHASE_CHECK_RESULT;
                    }
                    break;
                case PHASE_CHECK_RESULT:
                    surp_contact = 0;
                    /* check attack result */
                    if ( atk_result & AR_UNIT_KILLED ) {
                        engine_remove_unit( cur_atk );
                        cur_atk = 0;
                    }
                    if ( atk_result & AR_TARGET_KILLED ) {
                        engine_remove_unit( cur_def );
                        cur_def = 0;
                    }
                    /* CHECK IF SCENARIO IS FINISHED DUE TO UNITS_KILLED OR UNITS_SAVED */
                    if ( scen_check_result( 0 ) )  {
                        engine_finish_scenario();
                        break;
                    }
                    reset = 1;
                    if ( df_units->count > 0 ) {
                        if ( atk_result & AR_TARGET_SUPPRESSED || atk_result & AR_TARGET_KILLED ) {
                            list_clear( df_units );
                            if ( atk_result & AR_TARGET_KILLED )
                                cur_unit = 0;
                            else {
                                /* supressed unit looses its actions */
                                cur_unit->cur_mov = 0;
                                cur_unit->cur_atk_count = 0;
                                cur_unit->unused = 0;
                                broken_up = 1;
                            }
                        }
                        else {
                            reset = 0;
                            list_delete_pos( df_units, 0 );
                        }
                    }
                    else
                        was_final_fight = 1;
                    if ( !reset ) {
                        /* continue fights */
                        if ( engine_get_next_combatants() ) {
                            status = STATUS_ATTACK;
                            phase = PHASE_INIT_ATK;
                        }
                        else
                            fprintf( stderr, "Deadlock! No remaining combatants but supposed to continue fighting? How is this supposed to work????\n" );
                    }
                    else {
                        /* clear suppression from defensive fire */
                        if ( cur_atk ) {
                            cur_atk->suppr = 0;
                            cur_atk->unused = 0;
                        }
                        if ( cur_def )
                            cur_def->suppr = 0;
                        /* if this was the final fight between selected unit and selected target
                           check if one of these units was completely suppressed and surrenders
                           or flees */
                        if ( was_final_fight ) {
                            engine_clear_backup(); /* no undo allowed after attack */
                            if ( cur_atk != 0 && cur_def != 0 ) {
                                if ( atk_result & AR_UNIT_ATTACK_BROKEN_UP ) {
                                    /* unit broke up the attack */
                                    broken_up = 1;
                                }
                                else
                                    if ( atk_result & AR_UNIT_SUPPRESSED && !(atk_result & AR_TARGET_SUPPRESSED ) ) {
                                        /* cur_unit is suppressed */
                                        engine_handle_suppr( cur_atk, &type, &dx, &dy );
                                        if ( type == UNIT_FLEES ) {
                                            status = STATUS_MOVE;
                                            phase = PHASE_INIT_MOVE;
                                            move_unit = cur_atk;
                                            fleeing_unit = 1;
                                            dest_x = dx; dest_y = dy;
                                            break;
                                        }
                                        else
                                            if ( type == UNIT_SURRENDERS ) {
                                                surrender = 1;
                                                surrender_unit = cur_atk;
                                            }
                                    }
                                    else
                                        if ( atk_result & AR_TARGET_SUPPRESSED && !(atk_result & AR_UNIT_SUPPRESSED ) ) {
                                            /* cur_target is suppressed */
                                            engine_handle_suppr( cur_def, &type, &dx, &dy );
                                            if ( type == UNIT_FLEES ) {
                                                status = STATUS_MOVE;
                                                phase = PHASE_INIT_MOVE;
                                                move_unit = cur_def;
                                                fleeing_unit = 1;
                                                dest_x = dx; dest_y = dy;
                                                break;
                                            }
                                            else
                                                if ( type == UNIT_SURRENDERS ) {
                                                    surrender = 1;
                                                    surrender_unit = cur_def;
                                                }
                                        }
                            }
                            /* clear pointers */
                            if ( cur_atk == 0 ) cur_unit = 0;
                            if ( cur_def == 0 ) cur_target = 0;
                        }
                        if ( broken_up ) {
                            phase = PHASE_BROKEN_UP_MSG;
                            label_write( gui->label, gui->font_error, "Attack Broken Up!" );
                            reset_delay( &msg_delay );
                            break;
                        }
                        if ( surrender ) {
                            phase = PHASE_SURRENDER_MSG;
                            label_write( gui->label, gui->font_error, "Surrenders!" );
                            reset_delay( &msg_delay );
                            break;
                        }
                        phase = PHASE_END_COMBAT;
                    }
                    break;
                case PHASE_SURRENDER_MSG:
                    if ( timed_out( &msg_delay, ms ) ) {
                        if ( surrender_unit == cur_atk ) { 
                            cur_unit = 0;
                            cur_atk = 0;
                        }
                        if ( surrender_unit == cur_def ) {
                            cur_def = 0;
                            cur_target = 0;
                        }
                        engine_remove_unit( surrender_unit );
                        phase = PHASE_END_COMBAT;
                        label_hide( gui->label, 1 );
                    }
                    break;
                case PHASE_BROKEN_UP_MSG:
                    if ( timed_out( &msg_delay, ms ) ) {
                        phase = PHASE_END_COMBAT;
                        label_hide( gui->label, 1 );
                    }
                    break;
                case PHASE_END_COMBAT:    
#ifdef WITH_SOUND                
                    audio_fade_out( 2, 1500 ); /* explosion sound channel */
#endif
                    /* costs one fuel point for attacker */
                    if ( cur_unit && unit_check_fuel_usage( cur_unit ) && cur_unit->cur_fuel > 0 )
                        cur_unit->cur_fuel--;
                    /* update the visible units list */
                    map_get_vis_units();
                    map_set_vis_infl_mask();
                    /* reselect unit */
                    if ( cur_ctrl == PLAYER_CTRL_HUMAN )
                        engine_select_unit( cur_unit );
                    /* status */
                    engine_set_status( STATUS_NONE );
        		    label_hide( gui->label2, 1 );
                    phase = PHASE_NONE;
                    /* allow new human/cpu input */
                    if ( !blind_cpu_turn ) {
                        if ( cur_ctrl == PLAYER_CTRL_HUMAN ) {
                            image_hide( gui->cursors, 0 );
                            gui_set_cursor( CURSOR_STD );
                        }
                        draw_map = 1;
                    }
                    break;
            }
            break;
    }
    /* update anims */
    if ( status == STATUS_ATTACK ) {
        anim_update( terrain_icons->cross, ms );
        anim_update( terrain_icons->expl1, ms );
        anim_update( terrain_icons->expl2, ms );
    }
    if ( status == STATUS_STRAT_MAP ) {
        if ( timed_out( &blink_delay, ms ) )
            strat_map_blink();
    }
    /* update gui */
    gui_update( ms );
    if ( edit_update( gui->edit, ms ) ) {
#ifdef WITH_SOUND
        wav_play( gui->wav_edit );
#endif
    }
}

/*
====================================================================
Main game loop.
If a restart is nescessary 'setup' is modified and 'reinit'
is set True.
====================================================================
*/
static void engine_main_loop( int *reinit )
{
    int ms;
    if ( status == STATUS_TITLE ) {
        engine_draw_bkgnd();
        refresh_screen( 0, 0, 0, 0 );
    }
    else
        engine_end_turn( cur_player, setup.type == SETUP_LOAD_GAME /* skip unit preps then */ );
    gui_get_bkgnds();
    *reinit = 0;
    reset_timer();
    while( !end_scen && !term_game ) {
        engine_begin_frame();
        /* check input/cpu events and put to action queue */
        engine_check_events();
        /* handle queued actions */
        engine_handle_next_action( reinit );
        /* get time */
        ms = get_time();
        /* delay next scroll step */
        if ( scroll_vert || scroll_hori ) {
            if ( scroll_time > ms ) {
                set_delay( &scroll_delay, scroll_time );
                scroll_block = 1;
                scroll_vert = scroll_hori = SCROLL_NONE;
            }
            else
                set_delay( &scroll_delay, 0 );
        }
        if ( timed_out( &scroll_delay, ms ) ) 
            scroll_block = 0;
        /* update */
        engine_update( ms );
        engine_end_frame();
        /* short delay */
        SDL_Delay( 5 );
    }
    /* hide these windows, so the initial screen looks as original */
    frame_hide(gui->qinfo1, 1);
    frame_hide(gui->qinfo2, 1);
    label_hide(gui->label, 1);
    label_hide( gui->label2, 1 );
}

/*
====================================================================
Publics
====================================================================
*/

/*
====================================================================
Create engine (load resources that are not modified by scenario)
====================================================================
*/
int engine_create()
{
    slots_init();
    gui_load( "default" );
    return 1;
}
void engine_delete()
{
    engine_shutdown();
    scen_clear_setup();
    gui_delete();
}

/*
====================================================================
Initiate engine by loading scenario either as saved game or
new scenario by the global 'setup'.
====================================================================
*/
int engine_init()
{
    int i, j;
    Player *player;
#ifdef USE_DL
    char path[256];
#endif
    end_scen = 0;
    /* build action queue */
    actions_create();
    /* scenario&campaign or title*/
    if ( setup.type == SETUP_RUN_TITLE ) {
        status = STATUS_TITLE;
        return 1;
    }
    if ( setup.type == SETUP_LOAD_GAME ) {
        if ( !slot_load( setup.slot_id ) ) return 0;
    }
    else 
        if ( setup.type == SETUP_INIT_CAMP ) {
            if ( !camp_load( setup.fname ) ) return 0;
            if ( !camp_set_next( 0 ) ) return 0;
            if ( !scen_load( camp_cur_scen->scen ) ) return 0;
            /* select first player */
            cur_player = players_get_first();
            turn = 0;
        }
        else {
            if ( !scen_load( setup.fname ) ) return 0;
            if ( setup.type == SETUP_INIT_SCEN ) {
                /* player control */
                list_reset( players );
                for ( i = 0; i < setup.player_count; i++ ) {
                    player = list_next( players );
                    player->ctrl = setup.ctrl[i];
                    free( player->ai_fname );
                    player->ai_fname = strdup( setup.modules[i] );
                }
            }
            /* select first player */
            cur_player = players_get_first();
        }
    /* store current settings to setup */
    scen_set_setup();
    /* load the ai modules */
    list_reset( players );
    for ( i = 0; i < players->count; i++ ) {
        player = list_next( players );
        /* clear callbacks */
        player->ai_init = 0;
        player->ai_run = 0;
        player->ai_finalize = 0;
        if ( player->ctrl == PLAYER_CTRL_CPU ) {
#ifdef USE_DL
            if ( strcmp( "default", player->ai_fname ) ) {
                sprintf( path, "%s/ai_modules/%s", SRC_DIR, player->ai_fname );
                if ( ( player->ai_mod_handle = dlopen( path, RTLD_GLOBAL | RTLD_NOW ) ) == 0 )
                    fprintf( stderr, "%s\n", dlerror() );
                else {
                    if ( ( player->ai_init = dlsym( player->ai_mod_handle, "ai_init" ) ) == 0 )
                        fprintf( stderr, "%s\n", dlerror() );
                    if ( ( player->ai_run = dlsym( player->ai_mod_handle, "ai_run" ) ) == 0 )
                        fprintf( stderr, "%s\n", dlerror() );
                    if ( ( player->ai_finalize = dlsym( player->ai_mod_handle, "ai_finalize" ) ) == 0 )
                        fprintf( stderr, "%s\n", dlerror() );
                }
                if ( player->ai_init == 0 || player->ai_run == 0 || player->ai_finalize == 0 ) {
                    fprintf( stderr, "%s: AI module '%s' invalid. Use built-in AI.\n", player->name, player->ai_fname );
                    /* use the internal AI */
                    player->ai_init = ai_init;
                    player->ai_run = ai_run;
                    player->ai_finalize = ai_finalize;
                    if ( player->ai_mod_handle ) {
                        dlclose( player->ai_mod_handle ); 
                        player->ai_mod_handle = 0;
                    }
                }
            }
            else {
                player->ai_init = ai_init;
                player->ai_run = ai_run;
                player->ai_finalize = ai_finalize;
            }
#else
            player->ai_init = ai_init;
            player->ai_run = ai_run;
            player->ai_finalize = ai_finalize;
#endif
        }
    }
    /* no unit selected */
    cur_unit = cur_target = cur_atk = cur_def = move_unit = surp_unit = deploy_unit = surrender_unit = 0;
    df_units = list_create( LIST_NO_AUTO_DELETE, LIST_NO_CALLBACK );
    /* engine */
    /* tile mask */
    /*  1 = map tile directly hit
        0 = neighbor */
    hex_mask = calloc( hex_w * hex_h, sizeof ( int ) );
    for ( j = 0; j < hex_h; j++ )
        for ( i = 0; i < hex_w; i++ )
            if ( get_pixel( terrain_icons->fog, i, j ) )
                hex_mask[j * hex_w + i] = 1;
    /* screen copy buffer */
    sc_buffer = create_surf( sdl.screen->w, sdl.screen->h, SDL_SWSURFACE );
    sc_type = 0;
    /* map geometry */
    map_x = map_y = 0;
    map_sx = -hex_x_offset;
    map_sy = -hex_h;
    for ( i = map_sx, map_sw = 0; i < sdl.screen->w; i += hex_x_offset )
        map_sw++;
    for ( j = map_sy, map_sh = 0; j < sdl.screen->h; j += hex_h )
        map_sh++;
    /* reset scroll delay */
    set_delay( &scroll_delay, 0 );
    scroll_block = 0;
    /* message delay */
    set_delay( &msg_delay, 1500 );
    /* hide animations */
    anim_hide( terrain_icons->cross, 1 );
    anim_hide( terrain_icons->expl1, 1 );
    anim_hide( terrain_icons->expl2, 1 );
    /* remaining deploy units list */
    left_deploy_units = list_create( LIST_NO_AUTO_DELETE, LIST_NO_CALLBACK );
    /* build strategic map */
    strat_map_create();
    /* clear status */
    status = STATUS_NONE;
    /* weather */
    cur_weather = scen_get_weather();
    return 1;
}
void engine_shutdown()
{
    engine_set_status( STATUS_NONE );
    modify_fog = 0;
    cur_player = 0; cur_ctrl = 0;
    cur_unit = cur_target = cur_atk = cur_def = move_unit = surp_unit = deploy_unit = surrender_unit = 0;
    memset( merge_units, 0, sizeof( int ) * MAP_MERGE_UNIT_LIMIT );
    merge_unit_count = 0;
    engine_clear_backup();
    scroll_hori = scroll_vert = 0;
    last_button = 0;
    scen_delete();
    if ( df_units ) {
        list_delete( df_units );
        df_units = 0;
    }
    if ( hex_mask ) {
        free( hex_mask );
        hex_mask = 0;
    }
    if ( sc_buffer ) {
        SDL_FreeSurface( sc_buffer );
        sc_buffer = 0;
    }
    sc_type = SC_NONE;
    actions_delete();
    if ( way ) {
        free( way );
        way = 0;
        way_length = 0; way_pos = 0;
    }
    if ( left_deploy_units ) {
        list_delete( left_deploy_units );
        left_deploy_units = 0;
    }
    strat_map_delete();
}

/*
====================================================================
Run the engine (starts with the title screen)
====================================================================
*/
void engine_run()
{
    int reinit = 1;
    setup.type = SETUP_RUN_TITLE;
    while ( 1 ) {
        while ( reinit ) {
            reinit = 0;
            if(engine_init() == 0) {
              /* if engine initialisation is unsuccesful */
              /* stay with the title screen */
              status = STATUS_TITLE;
              setup.type = SETUP_RUN_TITLE;
            }
            if ( turn == 0 && camp_loaded )
                engine_show_message( camp_cur_scen->brief );
            engine_main_loop( &reinit );
            if (term_game) break;
            engine_shutdown();
        }
        if ( scen_done() ) {
            if ( camp_loaded ) {
                /* determine next scenario in campaign */
                if ( !camp_set_next( scen_get_result() ) )
                    break;
                if ( camp_cur_scen->scen == 0 ) {
                    /* final message */
                    engine_show_message( camp_cur_scen->brief );
                    setup.type = SETUP_RUN_TITLE;
                    reinit = 1;
                }
                else {
                    /* next scenario */
                    sprintf( setup.fname, camp_cur_scen->scen );
                    setup.type = SETUP_DEFAULT_SCEN;
                    reinit = 1;
                }
            }
            else {
                setup.type = SETUP_RUN_TITLE;
                reinit = 1;
            }
        }
        else
            break;
        /* clear result before next loop (if any) */
        scen_clear_result();
    }
}
