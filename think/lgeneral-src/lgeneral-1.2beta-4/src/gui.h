/***************************************************************************
                          gui.h  -  description
                             -------------------
    begin                : Sun Mar 31 2002
    copyright            : (C) 2001 by Michael Speck
    email                : kulkanie@gmx.net
 ***************************************************************************/

/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef __GUI_H
#define __GUI_H

#include "unit.h"
#include "windows.h"

/*
====================================================================
Button ids
====================================================================
*/
enum {
    ID_INTERN_UP = -1000,
    ID_INTERN_DOWN,
    ID_MENU = 0,
    ID_SCEN_INFO,
    ID_AIR_MODE,
    ID_DEPLOY,
    ID_STRAT_MAP,
    ID_END_TURN,
    ID_CONDITIONS,
    ID_PURCHASE,
    ID_OK,
    ID_CANCEL,
    ID_SUPPLY,
    ID_EMBARK_AIR,
    ID_MERGE,
    ID_UNDO,
    ID_RENAME,
    ID_APPLY_DEPLOY,
    ID_CANCEL_DEPLOY,
    ID_DEPLOY_UP,
    ID_DEPLOY_DOWN,
    ID_SAVE,
    ID_LOAD,
    ID_RESTART,
    ID_CAMP,
    ID_SCEN,
    ID_OPTIONS,
    ID_QUIT,
    ID_LOAD_0,
    ID_LOAD_1,
    ID_LOAD_2,
    ID_LOAD_3,
    ID_LOAD_4,
    ID_LOAD_5,
    ID_LOAD_6,
    ID_LOAD_7,
    ID_LOAD_8,
    ID_LOAD_9,
    ID_SAVE_0,
    ID_SAVE_1,
    ID_SAVE_2,
    ID_SAVE_3,
    ID_SAVE_4,
    ID_SAVE_5,
    ID_SAVE_6,
    ID_SAVE_7,
    ID_SAVE_8,
    ID_SAVE_9,
    ID_C_SUPPLY,
    ID_C_WEATHER,
    ID_C_SHOW_CPU,
    ID_C_SHOW_STRENGTH,
    ID_C_SOUND,
    ID_C_SOUND_INC,
    ID_C_SOUND_DEC,
    ID_C_MUSIC,
    ID_C_GRID,
    ID_C_VMODE,
    ID_640x480,
    ID_800x600,
    ID_1024x768,
    ID_1280x1024,
    ID_1600x1200,
    ID_FULLSCREEN,
    ID_APPLY_VMODE,
    ID_SCEN_OK,
    ID_SCEN_CANCEL,
    ID_SCEN_SETUP,
    ID_CAMP_OK,
    ID_CAMP_CANCEL,
    ID_SETUP_OK,
    ID_SETUP_FOG,
    ID_SETUP_SUPPLY,
    ID_SETUP_WEATHER,
    ID_SETUP_CTRL,
    ID_SETUP_MODULE,
    ID_MODULE_OK,
    ID_MODULE_CANCEL
};

/*
====================================================================
GUI graphics, fonts and windows.
====================================================================
*/
typedef struct {
    char *name;         /* directory name of gui */
    Font *font_std;
    Font *font_status;
    Font *font_error;
    Font *font_turn_info;
    Font *font_brief;
    Image *cursors;
    Label *label, *label2;
    Frame *qinfo1, *qinfo2; /* unit quick infos */
    Frame *finfo; /* full unit info */
    Frame *sinfo; /* scenario information */
    Group *unit_buttons; /* unit action buttons */
    Group *confirm; /* confirmation window */
    Group *deploy_window;
    Edit *edit;
    Group *base_menu; /* basic menu (switch airmode, deploy, end turn, menu ...) */
    Group *main_menu; /* main game menu */
    Group *opt_menu;  /* options */
    Group *load_menu;
    Group *save_menu;
    Group *vmode_menu;
    FDlg *scen_dlg;    /* scenario selection */
    FDlg *camp_dlg;    /* campaign selection */
    SDlg *setup;       /* scenario setup (controls and ai modules) */
    FDlg *module_dlg;  /* ai module selection */
    /* frame tiles */
    SDL_Surface *fr_luc, *fr_llc, *fr_ruc, *fr_rlc, *fr_hori, *fr_vert;
    SDL_Surface *brief_frame;   /* briefing window */
    SDL_Surface *bkgnd;         /* background for briefing window and main menu */
    SDL_Surface *wallpaper;     /* wallpaper used if background doesn't fill the whole screen */
    SDL_Surface *folder_icon;   /* folder icon for file list */
    /* sounds */
#ifdef WITH_SOUND
    Wav *wav_click;
    Wav *wav_edit;
#endif
} GUI;

/*
====================================================================
Create the gui and use the graphics in gfx/themes/path
====================================================================
*/
int gui_load( char *path );
void gui_delete();

/*
====================================================================
Move all windows to there proper position according to screen's
measurements.
====================================================================
*/
void gui_adjust();

/*
====================================================================
Change all GUI graphics to the one found in gfx/theme/path.
====================================================================
*/
int gui_change( char *path );

/*
====================================================================
Hide/draw from/to screen or get backgrounds
====================================================================
*/
void gui_get_bkgnds();
void gui_draw_bkgnds();
void gui_draw();

/*
====================================================================
Set cursor.
====================================================================
*/
enum {
    CURSOR_STD = 0,
    CURSOR_SELECT,
    CURSOR_ATTACK,
    CURSOR_MOVE,
    CURSOR_MOUNT,
    CURSOR_DEBARK,
    CURSOR_EMBARK,
    CURSOR_MERGE,
    CURSOR_DEPLOY,
    CURSOR_UNDEPLOY,
    CURSOR_UP,
    CURSOR_DOWN,
    CURSOR_LEFT,
    CURSOR_RIGHT,
    CURSOR_COUNT
};
void gui_set_cursor( int type );

/*
====================================================================
Handle events.
====================================================================
*/
int gui_handle_motion( int cx, int cy );
int  gui_handle_button( int button_id, int cx, int cy, Button **button );
void gui_update( int ms );

/*
====================================================================
Set quick info frame with information on this unit and set hide = 0.
====================================================================
*/
void gui_show_quick_info( Frame *qinfo, Unit *unit );

/*
====================================================================
Draw the expected losses to the label.
====================================================================
*/
void gui_show_expected_losses( Unit *att, Unit *def, int att_dam, int def_dam );

/*
====================================================================
Draw the actual losses to the label.
====================================================================
*/
void gui_show_actual_losses( Unit *att, Unit *def, 
    int att_suppr, int att_dam, int def_suppr, int def_dam );
    
/*
====================================================================
Draw the given unit's strength or suppression to the given label
====================================================================
*/
void gui_show_unit_results( Unit *unit, Label *label, int is_str, int dam );

/*
====================================================================
Show full info window.
====================================================================
*/
void gui_show_full_info( Unit *unit );

/*
====================================================================
Show scenario info window.
====================================================================
*/
void gui_show_scen_info();

/*
====================================================================
Show explicit victory conditions and use scenario info window for
this.
====================================================================
*/
void gui_show_conds();

/*
====================================================================
Show confirmation window.
====================================================================
*/
void gui_show_confirm( char *text );

/*
====================================================================
Show unit buttons at screen x,y (does not include the button check)
====================================================================
*/
void gui_show_unit_buttons( int x, int y );

/*
====================================================================
Show deploy window and select first unit as 'deploy_unit'.
====================================================================
*/
void gui_show_deploy_window();

/*
====================================================================
Handle deploy window.
  gui_handle_deploy_motion: 'unit' is the unit the cursor is 
      currently above
  gui_handle_deploy_click: 'new_unit' is set True if a new unit was
      selected (which is 'deploy_unit' ) else False
      return True if something happended
====================================================================
*/
int gui_handle_deploy_click( int button, int cx, int cy );
void gui_handle_deploy_motion( int cx, int cy, Unit **unit );

/*
====================================================================
Scroll deploy list up/down.
====================================================================
*/
void gui_scroll_deploy_up();
void gui_scroll_deploy_down();

/*
====================================================================
Update deploy list. Unit is either removed or added to 
left_deploy_units and the deploy window is updated.
====================================================================
*/
void gui_remove_deploy_unit( Unit *unit );
void gui_add_deploy_unit( Unit *unit );

/*
====================================================================
Show base menu at screen x,y (does not include the button check)
====================================================================
*/
void gui_show_menu( int x, int y );

/*
====================================================================
Update save slot names.
====================================================================
*/
void gui_update_slot_tooltips();

/*
====================================================================
Render the file name to surface. (directories start with an
asteriks)
====================================================================
*/
void gui_render_file_name( void *item, SDL_Surface *buffer );

/*
====================================================================
Handle the selection of a scenario file (display info and 
load scen_info from full path)
====================================================================
*/
void gui_render_scen_info( char *path, SDL_Surface *buffer );

/*
====================================================================
Handle the selection of a campaign file (display info and 
load scen_info from full path)
====================================================================
*/
void gui_render_camp_info( char *path, SDL_Surface *buffer );

/*
====================================================================
Open scenario setup and set first player as selected.
====================================================================
*/
void gui_open_scen_setup();

/*
====================================================================
Render the player name in the scenario setup
====================================================================
*/
void gui_render_player_name( void *item, SDL_Surface *buffer );

/*
====================================================================
Handle the selection of a player in setup.
====================================================================
*/
void gui_handle_player_select( void *item );

/*
====================================================================
Load a module's info
====================================================================
*/
void gui_render_module_info( char *path, SDL_Surface *buffer );

#endif
