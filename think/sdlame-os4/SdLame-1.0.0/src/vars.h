#include <SDL.h>
#include <SDL_events.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <SDL_mixer.h>
#include <SDL_thread.h>

SDL_Surface *screen;
TTF_Font    *font;

int field[9][9];   //Field, the players play on
int player;        //Player, which can move a unit
int cursor_x;      //Cursor X postion (1-8)
int cursor_y;      //Cursor Y postion (1-8)
int unit_x;        //Selected Unit X position (1-8)
int unit_y;        //Selected Unit Y position (1-8)
int moved_x;       //Moved Unit X position (1-8)
int moved_y;       //Moved Unit Y position (1-8)
int beat_k;        //Player beat a unit 0=no, 1=yes
int moved_k;       //Player moved a unit 0=no, 1=yes
int player_white;  //Units of White Player
int player_black;  //Units of Black Player
int menu_position; //Position in the menu
int mode;          //1=Singleplayer or 2=Multiplayer

/* Screen info */
int screen_width;
int screen_height;
int screen_depth;
int fullscreen;

/* field info */
int field_start_x;
int field_start_y;
int place_size;

/* menu positions */
int menu_arrow_1_x;
int menu_arrow_1_y;
int menu_arrow_2_x;
int menu_arrow_2_y;
int menu_arrow_3_x;
int menu_arrow_3_y;
int menu_arrow_4_x;
int menu_arrow_4_y;
int menu_arrow_5_x;
int menu_arrow_5_y;
int menu_arrow_6_x;
int menu_arrow_6_y;

/* loading positions */
int loading_y;
int loading_h;
int loading_x;
int loading_w;

/* config positions */
int config_arrow_x_mode;
int config_arrow_y_mode;
int config_arrow_x_resolution;
int config_arrow_y_resolution;
int config_arrow_x_fullscreen;
int config_arrow_y_fullscreen;
int config_arrow_x_exit;
int config_arrow_y_exit;
int config_text_mode_x;
int config_text_mode_y;
int config_text_resolution_x;
int config_text_resolution_y;
int config_text_fullscreen_x;
int config_text_fullscreen_y;
int config_text_player_x;
int config_text_player_y;
int config_text_resolution_info_x;
int config_text_resolution_info_y;
int config_text_fullscreen_info_x;
int config_text_fullscreen_info_y;
int config_text_exit_x;
int config_text_exit_y;

/* ingame textbox */
int info_text_x;
int info_text_w;
int info_text_y;
int info_text_h;
int font_size;
