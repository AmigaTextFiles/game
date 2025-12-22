/*
 *  Twin Distress
 *  Copyright (C) 2003-04 Keith Frampton
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Library General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include <SDL.h>
#include <SDL_image.h>
#ifndef NOAUDIO
#include <SDL_mixer.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

/* used for bmp vs. png support */
#ifndef EXTENSION
#define EXTENSION ".png"
#endif
#ifndef DATA_PREFIX
#define DATA_PREFIX ""
#endif
#ifndef HIGH_SCORE_PREFIX
#define HIGH_SCORE_PREFIX ""
#endif
#define GRIDSTARTX 238
#define GRIDSTARTY 138
/* left & right x coordinates for the menu system */
#define MENULX 222
#define MENURX 578
#define MUSIC_LOOPS 6
/* used for the change volume function */
#define MUSIC 1
#define SOUND 2
/* maximum number of lines in a menu / options in a submenu */
#define MAX_IN_MENU 7
#define MAX_OPTIONS 6
#define EXIT_GAME 2
#define HIGHSCORES 1
/* numbers of options remembered in the .twind.opts/options.dat */
#define NUM_OPTS 11
enum fade_types {FADE_OUT, FADE_IN};
enum block_status {BLOCK_NORM, BLOCK_HIGH, BLOCK_GONE, BLOCK_GOING};
enum directions {DIR_NONE, DIR_UP, DIR_RIGHT, DIR_DOWN, DIR_LEFT};
/* lines used for drawing the path
   UL - upper left, UR - upper right, LR - lower right, LL - lower left */
enum lines {LINE_VER, LINE_HOR, LINE_UL, LINE_UR, LINE_LR, LINE_LL, LINE_NONE};
enum menus {MAIN, NEW_GAME, OPTIONS};
enum sub_menu_items {NO_OPTIONS = -1, SKILL_LEVEL, GRAVITY, BLOCK_SET,
    CORNER_STYLE, PAUSE_MODE, DISPLAY_MODE, FADING_EFFECT, REMEMBER_OPTIONS};
enum skill_levels {KIDS, EASY, NORMAL, HARD, VERYHARD, INSANE, NUM_SKILLS};
enum block_sets {SQUARE_BRICKS, BEVELED_BLOCKS, SNAKE_SKIN_BLOCKS, 
    PYRAMID_BLOCKS, CIRCLES, BRUSHED_METAL, NUM_BLOCK_SETS};
enum corner_styles {SQUARE, ROUNDED};
enum sounds {MENU_OPTION, OPTION_CHOICE, KEYBOARD_CLICK, ELIMINATE_BLOCKS, 
    WRONG_MOVE, APPLY_BONUS, NUM_SOUNDS};
enum music_types {REGULAR, LAST_TEN_SECONDS};
/* used when we are changing volume with either the toggle, or the slider */
enum toggles_used {TOGGLE_YES, TOGGLE_NO};
enum adjust_sliders {MOVE_SLIDER, NO_SLIDER};
enum surfaces {BACKGROUND, BLOCKS, HIGHLIGHT1, HIGHLIGHT2, HIGHLIGHT3,
    HIGHLIGHT4, BLACK_L, WHITE_L, BLACK_R, WHITE_R, PATH_BLOCKS, TIMER_FULL,
    TIMER_FULL_WHITE, TIMER_EMPTY, TIMER_EMPTY_WHITE, TITLE_SMALL, TITLE_BIG,
    VOLUME_BAR, VOLUME_SLIDER, NUM_SURFACES};
enum fonts {SERIFG20, SERIFW20, SERIFG24, SERIFW24, NUM_FONTS};
enum colors {DARKBLUE, GREY, GREEN, RED, BROWN, PURPLE, ORANGE, PINK, LIGHTBLUE,
             YELLOW};
enum in_game_menu_options {NEWGAME, PAUSE, HELP, EXIT, NUM_IN_GAME_MO};
enum pause_modes {PAUSE_ONLY, MINIMIZE};
enum display_modes {WINDOW, FULLSCREEN};

struct path_info {
    int x;
    int y;
    int direction;
    /* current time for 1st, +40ms for next, +20ms for highlighted and destination */
    Uint32 blit_time;
    int block_num;
    int blit_done;
};

struct block {
    int status;
    int color;
    int left_or_right;
};

struct removed_blocks {
    int x, y, x2, y2;
};

struct existing_blocks {
    int x, y;
    int color;
    int left_or_right;
};

struct font_info {
    SDL_Surface *name;
    int pos[95];
    int width[95];
    int height;
};

struct option_info {
    int opt_group[MAX_OPTIONS];
    int opt_num[MAX_OPTIONS];
};

struct highscore_info {
    char name_score[21];
    int score;
    int level;
    char name_time[21];
    int time;
};

/* used for the activation of in game menu options, yes/no questions, etc */
typedef struct highlight_info HIGHLIGHT_INFO;
struct highlight_info {
    int x1, x2, y1, y2;
    char name[9];
};

struct game_info {
    char *score_file, *options_file;
    struct block grid[12][12];
    /* used for the Insane game mode to keep track of removed blocks */
    struct removed_blocks eliminated[50];
    /* currently highlighted block and destination block */
    int highx, highy, destx, desty;
    /* number of turns made to go from one block to the next */
    int turns;
    /* maximum turns we are allowed to make */
    int max_turns;
    /* number of elements in the list of paths to be highlighted */
    int path_count;
    /* if we don't want to add the first path to the list, but
       we want to know that the path was found, set this to 1 */
    int first_block;
    /* next two are used for the last ten seconds of a level */
    int blink;
    Uint32 blink_time;
    /* various timers used during the game */
    Uint32 start_timer, elapsed_time, paused_time, stop_timer, best_time;
    Uint32 temp_time, prev_time, added_time, skipped_time, random_block_time;
    /* all of the graphics + the main screen surface where everything is blitted */
    SDL_Surface *screen;
    SDL_Surface *surface[NUM_SURFACES];
    /* fonts used in the game */
    struct font_info font[NUM_FONTS];
    char player_name[21];
    /* used only when the user ends the game before it's over */
    int exit_game;
    /* if (blit_done) update the screen */
    int blit_done;
    /* should the corners of the bricks be a rounded style */
    int corner_style;
    /* number of groups of skill levels / game modes for the highscore file */
    int num_groups;
    /* used in-game to indicate whether or not the option is highlighted */
    int new_game_highlighted, exit_highlighted, help_highlighted;
    int highlight[4];
    /* used to determine which of the four highlight blocks are to be blitted */
    int block_highlight_num;
    /* current block highlighted time (used in the animation of block highlight) */
    Uint32 block_highlight_time;
    int unpause_msg;
    /* bonus scoring related vars */
    int bonus_score, last_color_removed, current_combos_removed;
    int current_sets_removed, no_matching_colors, no_wrong_moves;
    float highest_combo_removed;
    /* toggle indicating whether or not to use the fading effect */
    int fading_effect;
    /* used to temporarily turn off fading (ie: when changing the block set or
       corner style in the help screen, the fade isn't appropriate) */
    int fading_off_temp;
    /* toggle indicating whether or not to use the gravity */
    int gravity;
    /* when playing the Insane mode, the L & R can either be black or white &
       cal be changed by pressing the number keys */
    char color_l_and_r[11];
    /* window/full screen toggle */
    int score, score_changed;
    int timer_height, block_num, erased;
    int level_start, current_level, not_over, level_time, paused;
    int skill_level, block_set, pause_mode, display_mode, remember_options;
    struct option_info options;
    int menu, menu_option, next_option;
    int menu_item_cnt, sub_menu_item_cnt, last_menu_high;
    /* used for converting a number to a string */
    char *temp_string;
    /* when changing to full screen or window mode;
       set this so we don't hear any sound effect */
    int option_toggle;
    #ifndef NOAUDIO
    Mix_Music *music;
    #endif
    int regular_music, music_loop[MUSIC_LOOPS], sound_volume, music_volume;
    /* used when muting sound/music */
    int old_sound_volume, old_music_volume;
    /* toggle indicating whether or not sound/music is enabled */
    int audio_enabled, music_enabled;
    /* used for switching between the two different music loops for the menu */
    int menu_music;
    #ifndef NOAUDIO
    Mix_Chunk *sound[NUM_SOUNDS];
    #endif
} game;

int rnd(float max);
void initialize_and_load();
void create_random_grid();
void randomize_blocks();
void randomize_music();
void draw_grid_on_screen();
void draw_blocks();
void display_menu(char *menu_items[][MAX_IN_MENU], int menu);
void blank_options();
void create_menu(char *menu_items[][MAX_IN_MENU], char *sub_menu_items[][MAX_OPTIONS]);
int change_option(char *menu_items[][MAX_IN_MENU], char *sub_menu_items[][MAX_OPTIONS], int sub_menu, int option);
int get_input_for_menu(char *menu_items[][MAX_IN_MENU], char *sub_menu_items[][MAX_OPTIONS]);
int move_in_menu(char *menu_items[][MAX_IN_MENU], int current_menu_high, int direction);
int get_input_for_screen(int *screen_num, int max_screens, int screen);
void display_high_scores(int skill_level);
void show_scores_for_skill_level(struct highscore_info highscores[][10], int skill_level);
void display_help();
void show_help_page_number(int page_num);
void blit(SDL_Surface *source, Sint16 srcx, Sint16 srcy, Uint16 srcw, Uint16 srch, Sint16 destx, Sint16 desty);
void fill(Sint16 destx, Sint16 desty, Uint16 destw, Uint16 desth, Uint8 red, Uint8 green, Uint8 blue);
int word_width(char *word, int font);
void blank_screen();
void play_game();
void play_level();
void update_highlighted_block();
void update_score_and_bonus();
void print_score_and_bonus();
void apply_bonus_score();
void update_timer();
struct path_info *get_input_for_level(struct path_info *path);
void change_volume(int volume_type, int volume, int x, int y, int toggle, int adjust_slider);
void change_block_set();
void change_display_mode();
void setup_yes_no_xy(char *word, int destx, int desty, int font, HIGHLIGHT_INFO *highlight);
int get_input_for_yes_no(HIGHLIGHT_INFO *yes_no);
void exit_game(struct path_info *path, int exit_type);
void read_highscore_file(struct highscore_info highscores[][10]);
void write_highscore_file(struct highscore_info highscores[][10]);
void update_highscores();
int game_over();
SDL_Surface *load_image(char *filename, int *loaded);
#ifndef NOAUDIO
Mix_Chunk *load_wav(char *filename, int *loaded);
#endif
void unhighlight_block(int x, int y);
void put_block_back_on_screen(int x, int y);
void eliminate_blocks(int x, int y);
void keep_track_of_removed_blocks(int x, int y, int x2, int y2);
void add_gravity_effect(int x, int *y, int x2, int *y2);
void add_gravity_effect_for_blocks_put_back(int x, int *y, int x2, int *y2);
void setup_array(int dir1, int dir2, int dir3, int dir4, int directions[]);
struct path_info *change_grid(int x, int y, struct path_info *path, int button);
void wrong_move_penalty ();
struct path_info *legal_move(int x, int y, int cur_dir, int prev_dir, struct path_info *path);
struct path_info *add_path_to_list(int x, int y, int direction, struct path_info *path);
int show_path(struct path_info *path);
struct path_info *create_path(struct path_info *path, int cnt);
struct path_info *erase_path(struct path_info *path, int block_num);
void cleanup_and_exit();
void read_options_file();
void write_options_file();
void pause_game(char *message);
void unpause_game();
void print_word(char *word, int destx, int desty, int font);
void print_char(int character, int destx, int desty, int font);
void num_to_str(int num, int max_length);
void print_number(int destx, int desty, int font, int number, int len);
void print_time(int destx, int desty, int font, int number);
void change_corner_style(int x, int y);
Uint32 getpixel(SDL_Surface *surface, int x);
void fade_screen(int fade_type, int time, Uint32 color);

int main(int argc, char *argv[]) {
    
    char *menu_items[3][MAX_IN_MENU] = {{"New Game","Options","High Scores","Help","Exit"},
                                        {"Start Game", "", "Skill Level:","Gravity:", "Player Name: ", "", "Back"},
                                        {"Block Set:", "Corner Style:", "Pause Mode:", "Display Mode:", "Fading Effect:", "Remember Options:", "Back"}};
    
    /* code below was only used for a friend while building the game ... it may
       go back in later on when I implement command line options */
    /*
    if (argc > 1) {
        char *temp = argv[1];
        game.score_file = (char *)malloc(sizeof(char) * (strlen(temp) + 12));
        game.score_file[0] = '\0';
        strcat(game.score_file, temp);*/
        /* add a backslash character if one isn't there already */
        /*if (temp[strlen(temp) - 1] != '\\')
            strcat(game.score_file, "\\");
    }
    else {*/
    game.score_file = (char *)malloc(strlen(HIGH_SCORE_PREFIX) + sizeof(char) * (11));
    game.score_file[0] = '\0';
    /*}*/
    #ifndef LINUX
    strcat(game.score_file, "scores.dat");
    #else
    strcat(game.score_file, HIGH_SCORE_PREFIX "twind.hscr");
    #endif
    /*fprintf(stdout, "Highscore file location: %s\n", game.score_file);*/
    initialize_and_load();
    display_menu(menu_items, MAIN);
    return 0;

}

void display_menu(char *menu_items[][MAX_IN_MENU], int menu) {
    
    int destx, desty, font, hifont;
    char *sub_menu_items[8][MAX_OPTIONS] = {{"Kids", "Easy", "Normal", "Hard", "Very Hard", "Insane"},
                                            {"Off", "On"},
                                            {"Bricks", "Beveled", "Snake Skin", "Pyramids", "Circles", "Brushed Metal"},
                                            {"Square", "Rounded"},
                                            {"Pause Only", "Minimize"},
                                            {"Window", "Full Screen"},
                                            {"Off", "On"},
                                            {"No", "Yes"}};
    #ifndef NOAUDIO
    char *menu_music[2] = {DATA_PREFIX "music/0-0.ogg",
                           DATA_PREFIX "music/0-1.ogg"};
    #endif

    font = SERIFG24;
    hifont = SERIFW24;
    game.menu = menu;
    blank_options();
    /* start up the background music */
    #ifndef NOAUDIO
    if (game.music == NULL && game.audio_enabled) {
        /* switch the music loop */
        game.menu_music = !game.menu_music;
        if (game.music_enabled) {
            game.music = Mix_LoadMUS(menu_music[game.menu_music]);
            Mix_FadeInMusic(game.music, -1, 1000);
        }
    }
    #endif

    /* for each menu in the if statements below, the number of items must be set
       with the game.menu_item_cnt & as well as the options with the 
       game.options.opt_group[i] & game.options.opt_num[i]. 'i' must be the
       index of where the options are located in the menu. ie: skill level is
       the third option, so it has an index of 2. */
    if (menu == MAIN) {
        game.menu_item_cnt = 5;
        create_menu(menu_items, sub_menu_items);
        /* check for input */
        while (1) {
            game.menu_option = get_input_for_menu(menu_items, sub_menu_items);
            switch (game.menu_option) {
                /* New Game */
                case 0:
                    display_menu(menu_items, NEW_GAME);
                    break;
                /* Options */
                case 1:
                    display_menu(menu_items, OPTIONS);
                    break;
                /* High Scores */
                case 2:
                    display_high_scores(NORMAL);
                    break;
                /* Help */
                case 3:
                    display_help();
                    break;
                /* Exit */
                case 4:
                    cleanup_and_exit(game);
                    break;
            }
            game.menu = menu;
            blank_options();
            game.menu_item_cnt = 5;
            create_menu(menu_items, sub_menu_items);
        }
    }
    else if (menu == NEW_GAME) {
        game.options.opt_group[2] = SKILL_LEVEL;
        game.options.opt_num[2] = game.skill_level;
        game.options.opt_group[3] = GRAVITY;
        game.options.opt_num[3] = game.gravity;
        game.menu_item_cnt = 7;
        create_menu(menu_items, sub_menu_items);
        while (1) {
            game.options.opt_num[2] = game.skill_level;
            game.options.opt_num[3] = game.gravity;
            game.menu_option = get_input_for_menu(menu_items, sub_menu_items);
            switch (game.menu_option) {
                /* Start Game */
                case 0:
                    if (strlen(game.player_name) > 0) {
                        /* stop our background music & play the game */
                        #ifndef NOAUDIO
                        if (game.music_enabled) {
                            Mix_HaltMusic();
                            Mix_FreeMusic(game.music);
                        }
                        game.music = NULL;
                        #endif
                        if (game.fading_effect)
                            fade_screen(FADE_OUT, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
                        play_game();
                        return;
                    }
                    else {
                        destx = MENULX + word_width("Player Name: ", font);
                        desty = (600 - game.font[font].height * game.menu_item_cnt) / 2 + 4 * game.font[font].height;
                        print_word("Please enter a name.", destx, desty, font);
                    }
                    break;
                /* Skill Level */
                case 2:
                    game.sub_menu_item_cnt = NUM_SKILLS;
                    game.skill_level = change_option(menu_items, sub_menu_items, SKILL_LEVEL, game.skill_level);
                    if (game.skill_level == EASY)
                        game.max_turns = 3;
                    else
                        game.max_turns = 2;
                    break;
                /* Gravity */
                case 3:
                    game.sub_menu_item_cnt = 2;
                    game.gravity = change_option(menu_items, sub_menu_items, GRAVITY, game.gravity);
                    break;
                /* Player Name */
                case 4:
                    break;
                /* Back */
                case 6:
                    return;
                    break;
            }
        }
    }
    else if (menu == OPTIONS) {
        game.options.opt_group[0] = BLOCK_SET;
        game.options.opt_num[0] = game.block_set;
        game.options.opt_group[1] = CORNER_STYLE;
        game.options.opt_num[1] = game.corner_style;
        game.options.opt_group[2] = PAUSE_MODE;
        game.options.opt_num[2] = game.pause_mode;
        game.options.opt_group[3] = DISPLAY_MODE;
        game.options.opt_num[3] = game.display_mode;
        game.options.opt_group[4] = FADING_EFFECT;
        game.options.opt_num[4] = game.fading_effect;
        game.options.opt_group[5] = REMEMBER_OPTIONS;
        game.options.opt_num[5] = game.remember_options;
        game.menu_item_cnt = 7;
        create_menu(menu_items, sub_menu_items);
        while (1) {
            game.options.opt_num[0] = game.block_set;
            game.options.opt_num[1] = game.corner_style;
            game.options.opt_num[2] = game.pause_mode;
            game.options.opt_num[3] = game.display_mode;
            game.options.opt_num[4] = game.fading_effect;
            game.options.opt_num[5] = game.remember_options;
            game.menu_option = get_input_for_menu(menu_items, sub_menu_items);
            switch (game.menu_option) {
                /* Block Set */
                case 0: {
                    game.sub_menu_item_cnt = NUM_BLOCK_SETS;
                    game.block_set = change_option(menu_items, sub_menu_items, BLOCK_SET, game.block_set);
                    change_block_set();
                    break;
                }
                /* Corner Style */
                case 1: {
                    game.sub_menu_item_cnt = 2;
                    game.corner_style = change_option(menu_items, sub_menu_items, CORNER_STYLE, game.corner_style);
                    break;
                }
                /* Pause Mode */
                case 2: {
                    game.sub_menu_item_cnt = 2;
                    game.pause_mode = change_option(menu_items, sub_menu_items, PAUSE_MODE, game.pause_mode);
                    break;
                }
                /* Display Mode */
                case 3: {
                    game.sub_menu_item_cnt = 2;
                    game.display_mode = change_option(menu_items, sub_menu_items, DISPLAY_MODE, game.display_mode);
                    /* change to window mode */
                    if (game.display_mode == WINDOW)
                        game.screen = SDL_SetVideoMode(800, 600, 0, SDL_SWSURFACE);
                    /* change to full screen mode (if possible) */
                    else {
                        game.screen = SDL_SetVideoMode(800, 600, 0, SDL_FULLSCREEN);
                        if (game.screen == NULL) {
                            game.screen = SDL_SetVideoMode(800, 600, 0, SDL_SWSURFACE);
                            game.display_mode = WINDOW;
                        }
                    }
                    game.options.opt_num[3] = game.display_mode;
                    create_menu(menu_items, sub_menu_items);
                    break;
                }
                /* Fading Effect */
                case 4: {
                    game.sub_menu_item_cnt = 2;
                    game.fading_effect = change_option(menu_items, sub_menu_items, FADING_EFFECT, game.fading_effect);
                    break;
                }
                /* Remember Options */
                case 5: {
                    game.sub_menu_item_cnt = 2;
                    game.remember_options = change_option(menu_items, sub_menu_items, REMEMBER_OPTIONS, game.remember_options);
                    break;
                }
                /* Back */
                case 6:
                    return;
            }
        }
    }

}

void blank_options() {

    int i;
    
    for (i = 0; i < MAX_OPTIONS; i++) {
        game.options.opt_group[i] = NO_OPTIONS;
        game.options.opt_num[i] = NO_OPTIONS;
    }

}

int change_option(char *menu_items[][MAX_IN_MENU], char *sub_menu_items[][MAX_OPTIONS], int sub_menu, int option) {
    
    int new_option, destx, desty, destw, desth, font;
    
    font = SERIFW24;
    destx = MENULX + word_width(menu_items[game.menu][game.menu_option], font);
    desty = (600 - game.font[font].height * game.menu_item_cnt) / 2 + game.font[font].height * (game.menu_option);
    destw = MENURX - destx;
    desth = game.font[font].height;
    fill(destx, desty, destw, desth, 0, 0, 0);
    /* change to the next option */
    if (game.next_option) {
        new_option = option + 1;
        if (new_option == game.sub_menu_item_cnt)
            new_option = 0;
    }
    /* change to the previous option */
    else {
        new_option = option - 1;
        if (new_option < 0)
            new_option = game.sub_menu_item_cnt - 1;
    }
    destx = MENURX - word_width(sub_menu_items[sub_menu][new_option], font);
    print_word(sub_menu_items[sub_menu][new_option], destx, desty, font);
    if (game.blit_done) {
        #ifndef NOAUDIO
        if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
        #endif
        SDL_UpdateRect(game.screen, 0, 0, 0, 0);
        game.blit_done = 0;
    }
    return new_option;
    
}

void create_menu(char *menu_items[][MAX_IN_MENU], char *sub_menu_items[][MAX_OPTIONS]) {
    
    int i, destx, desty, font, hifont;
    
    if (game.fading_effect)
        fade_screen(FADE_OUT, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
    font = SERIFG24;
    hifont = SERIFW24;
    blank_screen();
    blit(game.surface[TITLE_BIG], 0, 0, game.surface[TITLE_BIG]->w, game.surface[TITLE_BIG]->h, 166, 0);
    /* draw the volume meters */
    if (game.audio_enabled) {
        print_word("Sound:", 185, 456, SERIFG24);
        blit(game.surface[VOLUME_BAR], 0, 0, 133, 32, 252, 456);
        blit(game.surface[VOLUME_SLIDER], 0, 0, 5, 32, game.sound_volume + 252, 456);
        if (game.music_enabled) {
            print_word("Music:", 416, 456, SERIFG24);
            blit(game.surface[VOLUME_BAR], 0, 0, 133, 32, 482, 456);
            blit(game.surface[VOLUME_SLIDER], 0, 0, 5, 32, game.music_volume + 482, 456);
        }
    }
    print_word("http://twind.sourceforge.net", 5, 575, SERIFG20);
    print_word("v1.1.0", -800, 575, SERIFG20);
    print_word("(c) 2003-04 Keith Frampton", 800 - word_width("(c) 2003-04 Keith Frampton", SERIFG20) - 5, 575, SERIFG20);
    desty = (600 - game.font[font].height * game.menu_item_cnt) / 2;
    for (i = 0; i < game.menu_item_cnt; i++) {
        if (strchr(menu_items[game.menu][i],':') == NULL) {
            if (i == 0)
                print_word(menu_items[game.menu][i], -800, desty, hifont);
            else
                print_word(menu_items[game.menu][i], -800, desty, font);
        }
        /* special case for player name */
        else if (game.menu == NEW_GAME && i == 4) {
            print_word(menu_items[game.menu][i], MENULX, desty, font);
            print_word(game.player_name, MENULX + word_width("Player Name: ", font), desty, font);
        }
        else {
            if (i == 0) {
                print_word(menu_items[game.menu][i], MENULX, desty, hifont);
                destx = MENURX - word_width(sub_menu_items[game.options.opt_group[i]][game.options.opt_num[i]], font);
                print_word(sub_menu_items[game.options.opt_group[i]][game.options.opt_num[i]], destx, desty, hifont);
            }
            else {
                print_word(menu_items[game.menu][i], MENULX, desty, font);
                destx = MENURX - word_width(sub_menu_items[game.options.opt_group[i]][game.options.opt_num[i]], font);
                print_word(sub_menu_items[game.options.opt_group[i]][game.options.opt_num[i]], destx, desty, font);
            }
        }
        desty += game.font[font].height;
    }
    game.last_menu_high = 0;
    if (game.fading_effect)
        fade_screen(FADE_IN, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
    SDL_UpdateRect(game.screen, 0, 0, 0, 0);
    
}

int get_input_for_menu(char *menu_items[][MAX_IN_MENU], char *sub_menu_items[][MAX_OPTIONS]) {
    
    int current_menu_high, starty, destx, height;
    int destxpn, destxc, destypn, max_word_len;
    int cursor, cursor_blink_time, location;
    int font, hifont;
    SDL_Event event;
    SDL_keysym keysym;
        
    font = SERIFG24;
    hifont = SERIFW24;
    location = strlen(game.player_name);
    cursor = cursor_blink_time = 0;
    max_word_len = 202;
    height = game.font[font].height * game.menu_item_cnt;
    starty = (600 - height) / 2;
    destxpn = MENULX + word_width("Player Name: ", font);
    destxc = destxpn + word_width(game.player_name, font);
    destypn = (600 - game.font[font].height * game.menu_item_cnt) / 2 + 4 * game.font[font].height;
    current_menu_high = game.last_menu_high;
    game.next_option = 1;
    while (1) {
        if (SDL_PollEvent(&event)) {
            switch (event.type) {
                case SDL_MOUSEMOTION:
                    /* are we in the menu? */
                    if (event.button.x >= MENULX && event.button.x < MENURX && event.button.y >= starty && event.button.y < (starty + height)) {
                        current_menu_high = (event.button.y - starty) / game.font[font].height;
                        /* re-assign current_menu_high if blank option */
                        if (menu_items[game.menu][current_menu_high] == "")
                            current_menu_high = game.last_menu_high;
                        if (game.last_menu_high != current_menu_high) {
                            if (menu_items[game.menu][current_menu_high] != "") {
                                #ifndef NOAUDIO
                                if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
                                #endif
                            }
                        }
                    }
                    /* change the sound volume */
                    else if (event.motion.x >= 254 && event.motion.x < 254 + 129 && event.motion.y >= 456 && event.motion.y < 488 && event.motion.state == SDL_BUTTON(1))
                        change_volume(SOUND, event.motion.x - 254, 252, 456, TOGGLE_NO, MOVE_SLIDER);
                    /* change the music volume */
                    else if (event.button.x >= 484 && event.motion.x < 613 && event.motion.y >= 456 && event.motion.y < 488 && event.motion.state == SDL_BUTTON(1) && game.music_enabled)
                        change_volume(MUSIC, event.motion.x - 484, 482, 456, TOGGLE_NO, MOVE_SLIDER);
                    break;
                case SDL_MOUSEBUTTONDOWN:
                    if (event.button.button == SDL_BUTTON_LEFT) {
                        /* see if we are in the menu */
                        if (event.button.x >= MENULX && event.button.x < MENURX && event.button.y >= starty && event.button.y < (starty + height)) {
                            current_menu_high = (event.button.y - starty) / game.font[font].height;
                            /* make sure the option isn't blank */
                            if (menu_items[game.menu][current_menu_high] != "") {
                                #ifndef NOAUDIO
                                if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                                #endif
                                return current_menu_high;
                            }
                        }
                    }
                    /* select the menu option with the middle mouse button */
                    else if (event.button.button == 2) {
                        #ifndef NOAUDIO
                        if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                        #endif
                        return current_menu_high;
                    }
                    /* exit the menu / game with the right mouse button */
                    if (event.button.button == 3) {
                        #ifndef NOAUDIO
                        if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
                        #endif
                        return game.menu_item_cnt - 1;
                    }
                    /* move up in the menu */
                    else if (event.button.button == 4)
                        current_menu_high = move_in_menu(menu_items, current_menu_high, DIR_UP);
                    /* move down in the menu */
                    else if (event.button.button == 5)
                        current_menu_high = move_in_menu(menu_items, current_menu_high, DIR_DOWN);
                    /* change the sound volume */
                    else if (event.button.x >= 254 && event.button.x < 254 + 129 && event.button.y >= 456 && event.button.y < 488)
                        change_volume(SOUND, event.button.x - 254, 252, 456, TOGGLE_NO, MOVE_SLIDER);
                    /* change the music volume */
                    else if (event.button.x >= 484 && event.button.x < 613 && event.button.y >= 456 && event.button.y < 488 && game.music_enabled)
                        change_volume(MUSIC, event.button.x - 484, 482, 456, TOGGLE_NO, MOVE_SLIDER);
                    break;
                case SDL_KEYDOWN:
                    keysym = event.key.keysym;
                    if (game.menu == NEW_GAME && game.last_menu_high == 4) {
                        /* adding a character to the player name */
                        if (keysym.unicode > 31 && keysym.unicode < 127 && location < 20) {
                            if (word_width(game.player_name, hifont) + game.font[font].width[keysym.unicode - 32] <= max_word_len) {
                                #ifndef NOAUDIO
                                if (game.audio_enabled) Mix_PlayChannel(KEYBOARD_CLICK, game.sound[KEYBOARD_CLICK], 0);
                                #endif
                                game.player_name[location] = keysym.unicode;
                                game.player_name[location+1] = '\0';
                                fill(destxpn, destypn, MENURX - destxpn, game.font[font].height, 0, 0, 0);
                                print_word(game.player_name, destxpn, destypn, hifont);
                                location++;
                                destxc += game.font[hifont].width[keysym.unicode - 32];
                            }
                        }
                        /* erase one character from the player name */
                        else if (keysym.sym == SDLK_BACKSPACE && location > 0) {
                            location--;
                            destxc -= game.font[hifont].width[game.player_name[location] - 32];
                            game.player_name[location] = '\0';
                            fill(destxpn, destypn, MENURX - destxpn, game.font[font].height, 0, 0, 0);
                            print_word(game.player_name, destxpn, destypn, hifont);
                            #ifndef NOAUDIO
                            if (game.audio_enabled) Mix_PlayChannel(KEYBOARD_CLICK, game.sound[KEYBOARD_CLICK], 0);
                            #endif
                        }
                        /* highlight the Start Game option */
                        else if (keysym.sym == SDLK_RETURN || keysym.sym == SDLK_KP_ENTER) {
                            current_menu_high = 0;
                            #ifndef NOAUDIO
                            if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
                            #endif
                            break;
                        }                            
                    }
                    /* don't only allow the keys f, m, s & w to be used when 
                       entering a player's name */
                    else {
                        /* needed under Windows to be able to use Alt-F4 to quit */
                        if (keysym.sym == SDLK_F4 && (keysym.mod & KMOD_ALT))
                            cleanup_and_exit();
                        /* toggle between full screen/window mode */
                        else if (keysym.sym == SDLK_f || keysym.sym == SDLK_F4) {
                            change_display_mode();
                            if (game.menu == OPTIONS)
                                game.options.opt_num[3] = game.display_mode;
                            create_menu(menu_items, sub_menu_items);
                        }
                        /* turn the background music on/off */
                        else if (keysym.sym == SDLK_m && game.music_enabled) {
                            if (game.music_volume == 0)
                                change_volume(MUSIC, game.old_music_volume, 482, 456, TOGGLE_YES, MOVE_SLIDER);
                            else {
                                game.old_music_volume = game.music_volume;
                                change_volume(MUSIC, 0, 482, 456, TOGGLE_YES, MOVE_SLIDER);
                            }
                        }
                        /* turn the sound effects on/off */
                        else if (keysym.sym == SDLK_s) {
                            if (game.sound_volume == 0)
                                change_volume(SOUND, game.old_sound_volume, 252, 456, TOGGLE_YES, MOVE_SLIDER);
                            else {
                                game.old_sound_volume = game.sound_volume;
                                change_volume(SOUND, 0, 252, 456, TOGGLE_YES, MOVE_SLIDER);
                            }
                        }
                    }
                    /* exit the menu / game */
                    if (keysym.sym == SDLK_ESCAPE) {
                        #ifndef NOAUDIO
                        if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
                        #endif
                        return game.menu_item_cnt - 1;
                    }
                    /* select the menu option */
                    else if (keysym.sym == SDLK_RETURN || keysym.sym == SDLK_KP_ENTER) {
                        #ifndef NOAUDIO
                        if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                        #endif
                        return current_menu_high;
                    }
                    /* change to next option or move down in menu */
                    else if (keysym.sym == SDLK_RIGHT) {
                        if (strchr(menu_items[game.menu][current_menu_high],':') == NULL)
                            current_menu_high = move_in_menu(menu_items, current_menu_high, DIR_DOWN);
                        else if (game.menu == NEW_GAME && current_menu_high == 3) {
                        }
                        else {
                            #ifndef NOAUDIO
                            if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                            #endif
                            return current_menu_high;
                        }
                    }
                    /* change to previous option or move up in menu */
                    else if (keysym.sym == SDLK_LEFT) {
                        if (strchr(menu_items[game.menu][current_menu_high],':') == NULL)
                            current_menu_high = move_in_menu(menu_items, current_menu_high, DIR_UP);
                        else if (game.menu == NEW_GAME && current_menu_high == 3) {
                        }
                        else {
                            #ifndef NOAUDIO
                            if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                            #endif
                            game.next_option = 0;
                            return current_menu_high;
                        }
                    }
                    /* move up in the menu */
                    else if (keysym.sym == SDLK_UP || keysym.sym == SDLK_KP8 || (keysym.sym == SDLK_TAB && (keysym.mod & KMOD_SHIFT)))
                        current_menu_high = move_in_menu(menu_items, current_menu_high, DIR_UP);
                    /* move down in the menu */
                    else if (keysym.sym == SDLK_DOWN || keysym.sym == SDLK_KP2 || (keysym.sym == SDLK_TAB && !(keysym.mod & KMOD_SHIFT)))
                        current_menu_high = move_in_menu(menu_items, current_menu_high, DIR_DOWN);
                    break;
                case SDL_QUIT:
                    cleanup_and_exit();
            }
        }
        if (game.last_menu_high != current_menu_high) {
            /* unhighlight the last menu item */
            if (strchr(menu_items[game.menu][game.last_menu_high],':') == NULL) {
                print_word(menu_items[game.menu][game.last_menu_high], -800, starty + game.last_menu_high * game.font[font].height, font);
            }
            else {
                print_word(menu_items[game.menu][game.last_menu_high], MENULX, starty + game.last_menu_high * game.font[font].height, font);
                /* special case for player name */
                if (game.menu == NEW_GAME && game.last_menu_high == 4) {
                    fill(destxpn, destypn, MENURX - destxpn, game.font[font].height, 0, 0, 0);
                    print_word(game.player_name, destxpn, destypn, font);
                }
                else {
                    destx = MENURX - word_width(sub_menu_items[game.options.opt_group[game.last_menu_high]][game.options.opt_num[game.last_menu_high]], font);
                    print_word(sub_menu_items[game.options.opt_group[game.last_menu_high]][game.options.opt_num[game.last_menu_high]], destx, starty + game.last_menu_high * game.font[font].height, font);
                }
            }
            /* highlight the curent menu item */
            if (strchr(menu_items[game.menu][current_menu_high],':') == NULL)
                print_word(menu_items[game.menu][current_menu_high], -800, starty + current_menu_high * game.font[font].height, hifont);
            else {
                print_word(menu_items[game.menu][current_menu_high], MENULX, starty + current_menu_high * game.font[font].height, hifont);
                /* special case for player name */
                if (game.menu == NEW_GAME && current_menu_high == 4) {
                    fill(destxpn, destypn, MENURX - destxpn, game.font[font].height, 0, 0, 0);
                    print_word(game.player_name, destxpn, destypn, hifont);
                }
                else {
                    destx = MENURX - word_width(sub_menu_items[game.options.opt_group[current_menu_high]][game.options.opt_num[current_menu_high]], font);
                    print_word(sub_menu_items[game.options.opt_group[current_menu_high]][game.options.opt_num[current_menu_high]], destx, starty + current_menu_high * game.font[font].height, hifont);
                }
            }
            game.last_menu_high = current_menu_high;
        }
        /* blink the cursor */
        if (game.menu == NEW_GAME && game.last_menu_high == 4) {
            if (!cursor && SDL_GetTicks() - cursor_blink_time > 200) {
                cursor_blink_time = SDL_GetTicks();
                cursor = 1;
                print_char('_', destxc, destypn, hifont);
            }
            else if (cursor && SDL_GetTicks() - cursor_blink_time > 200) {
                cursor_blink_time = SDL_GetTicks();
                cursor = 0;
                fill(destxc, destypn, word_width("_", font), game.font[font].height, 0, 0, 0);
            }
        }
        if (game.blit_done) {
            SDL_UpdateRect(game.screen, 0, 0, 0, 0);
            game.blit_done = 0;
        }
        SDL_Delay(10);
    }
    
}

int move_in_menu(char *menu_items[][MAX_IN_MENU], int current_menu_high, int direction) {

    if (direction == DIR_UP) {
        #ifndef NOAUDIO
        if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
        #endif
        current_menu_high--;
        /* if option blank, go to previous */
        while (menu_items[game.menu][current_menu_high] == "")
            current_menu_high--;
        /* wrap around to the bottom entry */
        if (current_menu_high == -1)
            current_menu_high = game.menu_item_cnt - 1;
    }
    /* move down in the menu */
    else if (direction == DIR_DOWN) {
        #ifndef NOAUDIO
        if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
        #endif
        current_menu_high++;
        /* if option blank, go to next */
        while (menu_items[game.menu][current_menu_high] == "")
            current_menu_high++;
        /* wrap around to the top entry */
        if (current_menu_high == game.menu_item_cnt)
            current_menu_high = 0;
    }
    return current_menu_high;
    
}

int get_input_for_screen(int *screen_num, int max_screens, int screen) {

    SDL_Event event;
    SDL_keysym keysym;

    while (1) {
        if (SDL_PollEvent(&event)) {
            switch (event.type) {
                case SDL_MOUSEBUTTONDOWN:
                    /* show the next screen */
                    if (event.button.button == SDL_BUTTON_LEFT || event.button.button == 5) {
                        (*screen_num)++;
                        if (*screen_num == max_screens) *screen_num = 0;
                        return 0;
                    }
                    /* return to the main menu with the right mouse button */
                    else if (event.button.button == 3)
                        return 1;
                    else if (event.button.button == 4) {
                        (*screen_num)--;
                        if (*screen_num < 0) *screen_num = max_screens - 1;
                        return 0;
                    }
                    break;
                case SDL_KEYDOWN:
                    keysym = event.key.keysym;
                    /* needed under Windows to be able to use Alt-F4 to quit */
                    if (keysym.sym == SDLK_F4 && (keysym.mod & KMOD_ALT))
                        cleanup_and_exit();
                    /* toggle between full screen/window mode */
                    else if (keysym.sym == SDLK_f || keysym.sym == SDLK_F4) {
                        change_display_mode();
                        game.option_toggle = 1;
                        return 0;
                    }
                    /* change the color of the l & r */
                    if (keysym.sym >= SDLK_0 && keysym.sym <= SDLK_9 && game.skill_level == INSANE) {
                        game.color_l_and_r[keysym.sym - 48] = !(game.color_l_and_r[keysym.sym - 48] - 48) + 48;
                        game.fading_off_temp = 1;
                        return 0;
                    }
                    /* change the block set */
                    else if (keysym.sym == SDLK_b && *screen_num == 4 && screen == HELP) {
                        game.block_set++;
                        if (game.block_set == NUM_BLOCK_SETS)
                            game.block_set = SQUARE_BRICKS;
                        game.fading_off_temp = 1;
                        change_block_set();
                        return 0;
                    }    
                    /* change the style of the corners of the blocks */
                    else if (keysym.sym == SDLK_c && *screen_num == 4 && screen == HELP) {
                        if (game.corner_style == SQUARE)
                            game.corner_style = ROUNDED;
                        else
                            game.corner_style = SQUARE;
                        game.fading_off_temp = 1;
                        return 0;
                    }
                    /* turn the background music on/off */
                    else if (keysym.sym == SDLK_m && game.music_enabled) {
                        if (game.music_volume == 0)
                            change_volume(MUSIC, game.old_music_volume, 0, 0, TOGGLE_YES, NO_SLIDER);
                        else {
                            game.old_music_volume = game.music_volume;
                            change_volume(MUSIC, 0, 0, 0, TOGGLE_YES, NO_SLIDER);
                        }
                    }
                    /* turn the sound effects on/off */
                    else if (keysym.sym == SDLK_s) {
                        if (game.sound_volume == 0)
                            change_volume(SOUND, game.old_sound_volume, 0, 0, TOGGLE_YES, NO_SLIDER);
                        else {
                            game.old_sound_volume = game.sound_volume;
                            change_volume(SOUND, 0, 0, 0, TOGGLE_YES, NO_SLIDER);
                        }
                    }
                    /* return to the main menu */
                    else if (keysym.sym == SDLK_ESCAPE)
                        return 1;
                    /* show the previous screen */
                    else if (keysym.sym == SDLK_LEFT || keysym.sym == SDLK_UP || keysym.sym == SDLK_KP8 || (keysym.sym == SDLK_TAB && (keysym.mod & KMOD_SHIFT))) {
                        (*screen_num)--;
                        if (*screen_num < 0) *screen_num = max_screens - 1;
                        return 0;
                    }
                    /* show the next screen */
                    else if (keysym.sym == SDLK_RIGHT || keysym.sym == SDLK_DOWN || keysym.sym == SDLK_KP2 || (keysym.sym == SDLK_TAB && !(keysym.mod & KMOD_SHIFT))) {
                        (*screen_num)++;
                        if (*screen_num == max_screens) *screen_num = 0;
                        return 0;
                    }
                    break;
                case SDL_QUIT:
                    cleanup_and_exit();
            }
        }
        SDL_Delay(10);
    }

}

void display_high_scores(int skill_level) {

    struct highscore_info highscores[NUM_SKILLS * 2][10];

    read_highscore_file(highscores);
    show_scores_for_skill_level(highscores, skill_level);
    while (get_input_for_screen(&skill_level, NUM_SKILLS * 2, HIGHSCORES) == 0)
        show_scores_for_skill_level(highscores, skill_level);
    #ifndef NOAUDIO
    if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
    #endif

}

void show_scores_for_skill_level(struct highscore_info highscores[][10], int skill_level) {
    
    int destx, desty, font, x;
    char *skill_levels[NUM_SKILLS * 2] = {"Kids", "Easy", "Normal", "Hard",
                                          "Very Hard", "Insane", "Kids", "Easy",
                                          "Normal", "Hard", "Very Hard", "Insane"};
    
    if (game.audio_enabled && !game.option_toggle) {
        #ifndef NOAUDIO
        Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
        #endif
    }
    else
        game.option_toggle = 0;
    if (game.fading_effect)
        fade_screen(FADE_OUT, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
    font = SERIFG20;
    blank_screen();
    print_word("High Scores", -800, 5, SERIFG24);
    print_word("Skill Level:", 313, 35, SERIFW20);
    print_word("Gravity:", 338, 60, SERIFW20);
    /* uncomment next line to see skill level centered */
    /*print_word("Skill Level:Very Hard   Gravity: Off", -800, 60, SERIFW20);*/
    destx = 313 + word_width("Skill Level:", SERIFW20);
    print_word(skill_levels[skill_level], destx, 35, SERIFW20);
    destx = 338 + word_width("Gravity:", SERIFW20);
    if (skill_level >= NUM_SKILLS)
        print_word("On", destx, 60, SERIFW20);
    else
        print_word("Off", destx, 60, SERIFW20);
    print_word("Best Scores", 100, 85, font);
    print_word("Best Times", 425, 85, font);
    /* horizontal */
    fill(85, 110, 630, 2, 0, 255, 0);
    /* vertical */
    fill(420, 85, 2, 325, 0, 255, 0);
    print_word("Name", 110, 125, font);
    print_word("Score", 318, 125, font);
    print_word("Level", 370, 125, font);
    print_word("Name", 425, 125, font);
    print_word("Time", 635, 125, font);
    desty = 170;
    for (x = 0; x < 10; x++) {
        /* print the position number */
        num_to_str(x + 1, 2);
        destx = 25 - word_width(game.temp_string, font) + 80;
        print_number(destx, desty, font, x + 1, 2);
        print_char('.', 106, desty, font);
        /* name for high score */
        print_word(highscores[skill_level][x].name_score, 110, desty, font);
        /* high score */
        if (highscores[skill_level][x].score > 0) {
            num_to_str(highscores[skill_level][x].score, 5);
            destx = 355 - word_width(game.temp_string, font);
            print_word(game.temp_string, destx, desty, font);
            free(game.temp_string);
            /* level reached for high score */
            num_to_str(highscores[skill_level][x].level, 3);
            destx = 405 - word_width(game.temp_string, font);
            print_word(game.temp_string, destx, desty, font);
            free(game.temp_string);
        }
        /* name for best time */
        print_word(highscores[skill_level][x].name_time, 425, desty, font);
        /* best time */
        if (highscores[skill_level][x].time != 120000) {
            print_time(635, desty, font, highscores[skill_level][x].time);
        }
        desty += game.font[font].height;
    }
    print_word("Use the mouse wheel, left mouse button or arrow keys to change skill level.", -800, 600 - game.font[SERIFG20].height * 2, SERIFW20);
    print_word("Press the right mouse button or Esc to return to the main menu.", -800, 600 - game.font[SERIFG20].height, SERIFW20);
    if (game.fading_effect)
        fade_screen(FADE_IN, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
    SDL_UpdateRect(game.screen, 0, 0, 0, 0);

}

void display_help() {

    int page_num = 0;
    show_help_page_number(page_num);
    while (get_input_for_screen(&page_num, 6, HELP) == 0)
        show_help_page_number(page_num);
    #ifndef NOAUDIO
    if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
    #endif
    
}

void show_help_page_number(int page_num) {

    int desty, color_l_and_r;
    char page_x_of_num[7] = "? of 6";
    
    if (game.audio_enabled && !game.option_toggle) {
        #ifndef NOAUDIO
        Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
        #endif
    }
    else
        game.option_toggle = 0;
    if (game.fading_effect && !game.fading_off_temp)
        fade_screen(FADE_OUT, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
    /* if we have more than 9 pages, this won't work! */
    page_x_of_num[0] = page_num + 49;
    desty = 20;
    blank_screen();
    switch (page_num) {
        /* page one */
        case 0: {
            print_word("How to Play the Game", -800, 0, SERIFW24);
            print_word("The object of the game is to remove all of the blocks from the screen before the time runs out.", 20, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("Two blocks are removed at a time, and must be of the same color. After completing a level, you", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("will be rewarded with a bonus point for every tick left on the clock. For each level thereafter, the", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("time to complete the level will be shorter.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=10;
            print_word("Shortcut Keys Used During the Game", -800, desty+=game.font[SERIFG20].height, SERIFW24);
            desty+=20;
            print_word("b -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("change the block set", 5 + word_width("b - ", SERIFG20), desty, SERIFG20);
            print_word("c -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("change the corner style of the blocks", 5 + word_width("c - ", SERIFG20), desty, SERIFG20);
            print_word("f, F4 -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("toggle between full screen/window mode (can be used anywhere)", 5 + word_width("f, F4 - ", SERIFG20), desty, SERIFG20);
            print_word("h, F1 -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("display the help screen", 5 + word_width("h, F1 - ", SERIFG20), desty, SERIFG20);
            print_word("m -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("turn background music on/off (can be used anywhere)", 5 + word_width("m - ", SERIFG20), desty, SERIFG20);
            print_word("n, F2 -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("start a new game (highscores won't be saved ending a game this way)", 5 + word_width("n, F2 - ", SERIFG20), desty, SERIFG20);
            print_word("p, Pause, F3 -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("pause/unpause the game", 5 + word_width("p, Pause, F3 - ", SERIFG20), desty, SERIFG20);
            print_word("q, Esc -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("quit the game", 5 + word_width("q, Esc - ", SERIFG20), desty, SERIFG20);
            print_word("s -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("turn sound effects on/off (can be used anywhere)", 5 + word_width("s - ", SERIFG20), desty, SERIFG20);
            print_word("0 - 9 -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("toggle the L & R colors on Insane mode (can be used anywhere)", 5 + word_width("0 - 9 - ", SERIFG20), desty, SERIFG20);
            desty+=10;
            print_word("Moving in the Menu", -800, desty+=game.font[SERIFG20].height, SERIFW24);
            desty+=20;
            print_word("To move in the menu, you have several options besides highlighting with the mouse and clicking", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("the menu/option with the left mouse button.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("moving up -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("Up arrow, TAB key or the mouse wheel", 5 + word_width("moving up - ", SERIFG20), desty, SERIFG20);
            break;
        }
        /* page two */
        case 1: {
            print_word("Moving in the Menu", -800, 0, SERIFW24);
            print_word("moving down -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("Down arrow, Shift-TAB or the mouse wheel", 5 + word_width("moving down - ", SERIFG20), desty, SERIFG20);
            print_word("choosing a menu/option -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("Enter or middle mouse button", 5 + word_width("choosing a menu/option - ", SERIFG20), desty, SERIFG20);
            print_word("changing options -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("left or right arrow keys", 5 + word_width("changing options - ", SERIFG20), desty, SERIFG20);
            print_word("exit a menu/sub-menu -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("Esc key or right mouse button", 5 + word_width("exit a menu/sub-menu - ", SERIFG20), desty, SERIFG20);
            desty+=10;
            print_word("Skill Levels", -800, desty+=game.font[SERIFG20].height, SERIFW24);
            desty+=20;
            print_word("Kids -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("Match two blocks of the same color. Where they are doesn't matter.", 5 + word_width("Kids - ", SERIFG20), desty, SERIFG20);
            desty+=20;
            print_word("Easy -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("The path used to connect the blocks can only be up, down, left or right (no moving", 5 + word_width("Easy - ", SERIFG20), desty, SERIFG20);
            print_word("diagonally). As well, you can't go through other blocks to get to the one you are looking for.", 5 + word_width("Easy - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("The path can turn a maximum of three times in this skill. Examples for this (and other skills)", 5 + word_width("Easy - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("are on page 5.", 5 + word_width("Easy - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("Normal -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("This is the standard mode of play. Same rules as Easy, except a path can only take two", 5 + word_width("Normal - ", SERIFG20), desty, SERIFG20);
            print_word("turns to get to the other block.", 5 + word_width("Normal - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("Hard -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("Same rules as Normal, except that when you choose two blocks that can't be removed, you", 5 + word_width("Hard - ", SERIFG20), desty, SERIFG20);
            print_word("will lose a point from your score & one tick of time from the clock. Two blocks already", 5 + word_width("Hard - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("eliminated will also be put back on the screen. If no blocks have been removed yet, you", 5 + word_width("Hard - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("will lose three points and three ticks on the clock. As well, if you click on a location where", 5 + word_width("Hard - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("a block has been removed, and you currently have a block highlighted, it is considered a", 5 + word_width("Hard - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("wrong move.", 5 + word_width("Hard - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            break;
        }
        /* page three */
        case 2: {
            print_word("Skill Levels", -800, 0, SERIFW24);
            print_word("Very Hard -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("Same rules as Hard, except the blocks will randomize in color several times throughout", 5 + word_width("Very Hard - ", SERIFG20), desty, SERIFG20);
            print_word("the game.", 5 + word_width("Very Hard - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("Insane -", 5, desty+=game.font[SERIFW20].height, SERIFW20);
            print_word("Same rules as Very Hard, except you must now use both the left & right mouse buttons to", 5 + word_width("Insane - ", SERIFG20), desty, SERIFG20);
            print_word("remove blocks. The blocks will have an L or an R. It isn't necessary to match two L blocks", 5 + word_width("Insane - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("or two R blocks. All that matters is that you must hit the block with the correct mouse", 5 + word_width("Insane - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("button.", 5 + word_width("Insane - ", SERIFG20), desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=10;
            print_word("Bonus Scoring", -800, desty+=game.font[SERIFG20].height, SERIFW24);
            desty+=20;
            print_word("In addition to receiving a point for every tick left on the clock at the end of a level, there are also", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("two other ways to receive bonus scoring.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("If you remove sets of the same color in a row, you will receive bonus points. For the first two sets,", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("you get 5 points. The third set will get you 10 points, the fourth will be 15 points & all five sets will", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("be 25 points. If you do the same thing again with another set of five, the points will be the same as", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("above, plus an extra 10 points. The third set of five will get you 20 points & so on. Up to 1000", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("points can be received for clearing the whole level this way. Making a wrong move won't erase", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("your bonus, but your chain will be broken.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("If you don't make any wrong moves during the level, you will receive 50 points. Do it again for the", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("next level & you will get 60 points. It will keep increasing by 10 points for every level & will be", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("reset if you make a wrong at any point in a level.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            break;
        }
        /* page four */
        case 3: {
            print_word("Other Options", -800, 0, SERIFW24);
            print_word("There are two unique modes of game play for the game. You can choose to have the gravity either", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("off or on. When two blocks are removed from the screen with gravity on, all the blocks above", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("them will fall into the empty spot. Blocks won't move at all when this is turned off.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("When pausing the game, you can have it minimize the game by changing it in the Options menu.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("By default, the menu system & screen changes will have a fading effect. If you don't like the", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("option or it doesn't work, it can be turned off in the Options menu.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=10;
            print_word("Tips & Notes", -800, desty+=game.font[SERIFG20].height, SERIFW24);
            desty+=20;
            print_word("For Hard, Very Hard and Insane; if you highlight a block and realize that a move can't be made;", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("you can un-highlight the block and you will not be penalized in any way.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("It is possible to have a game that can't be finished in the Normal skill.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("Even though there is plenty of time in the beginning levels to complete it, you are better off trying", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("to finish it as quickly as possible to obtain a higher score with the bonus points.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=20;
            print_word("If you have any ideas for new features for the game, let me know & I'll see if it can be added.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("Several new ideas came from players like you. You'll be given credit for ideas implemented on the", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("last page of the help screen.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            break;
        }
        /* page five */
        /* I know that I could've drawn these examples in the Gimp, rather than
           have so many blits, but then the user wouldn't have the dyanamic help
           screen where they can press 'b' & 'c' to the change the block set &
           corner style & see the results! ;-) */
        case 4: {
            print_word("Examples", -800, 0, SERIFW24);
            blit(game.surface[BLOCKS], DARKBLUE, 0, 32, 32, 5, desty+=game.font[SERIFG20].height);
            change_corner_style(5, desty);
            blit(game.surface[BLOCKS], RED * 32, 0, 32, 32, 37, desty);
            change_corner_style(37, desty);
            blit(game.surface[BLOCKS], GREEN * 32, 0, 32, 32, 69, desty);
            change_corner_style(69, desty);
            blit(game.surface[BLOCKS], YELLOW * 32, 0, 32, 32, 5, desty + 32);
            change_corner_style(5, desty + 32);
            blit(game.surface[BLOCKS], DARKBLUE * 32, 0, 32, 32, 37, desty + 32);
            change_corner_style(37, desty + 32);
            blit(game.surface[BLOCKS], LIGHTBLUE * 32, 0, 32, 32, 69, desty + 32);
            change_corner_style(69, desty + 32);
            blit(game.surface[BLOCKS], PURPLE * 32, 0, 32, 32, 5, desty + 64);
            change_corner_style(5, desty + 64);
            blit(game.surface[BLOCKS], GREY * 32, 0, 32, 32, 37, desty + 64);
            change_corner_style(37, desty + 64);
            blit(game.surface[BLOCKS], BROWN * 32, 0, 32, 32, 69, desty + 64);
            change_corner_style(69, desty + 64);
            print_word("The two blue blocks can only be removed on the Kids skill, since the middle blue one", 115, desty, SERIFG20);
            print_word("is surrounded by other blocks, and we can't move diagonally.", 115, desty+=game.font[SERIFG20].height, SERIFG20);
            desty = 20 + game.font[SERIFG20].height + 96;
            blit(game.surface[PATH_BLOCKS], LINE_LR * 32, 0, 32, 32, 5, desty);
            blit(game.surface[PATH_BLOCKS], LINE_HOR * 32, 0, 32, 32, 37, desty);
            blit(game.surface[PATH_BLOCKS], LINE_LL * 32, 0, 32, 32, 69, desty);
            blit(game.surface[BLOCKS], ORANGE * 32, 0, 32, 32, 5, desty + 32);
            change_corner_style(5, desty + 32);
            blit(game.surface[BLOCKS], PINK * 32, 0, 32, 32, 37, desty + 32);
            change_corner_style(37, desty + 32);
            blit(game.surface[PATH_BLOCKS], LINE_VER * 32, 0, 32, 32, 69, desty + 32);
            blit(game.surface[BLOCKS], RED * 32, 0, 32, 32, 5, desty + 64);
            change_corner_style(5, desty + 64);
            blit(game.surface[BLOCKS], ORANGE * 32, 0, 32, 32, 37, desty + 64);
            change_corner_style(37, desty + 64);
            blit(game.surface[PATH_BLOCKS], LINE_UL * 32, 0, 32, 32, 69, desty + 64);
            print_word("In addition to the Kids skill, the two orange blocks can be removed on the Easy skill", 115, desty+=32, SERIFG20);
            print_word("as well since there are three turns to find the path.", 115, desty+=game.font[SERIFG20].height, SERIFG20);
            desty = 20 + game.font[SERIFG20].height + 192;
            blit(game.surface[PATH_BLOCKS], LINE_LR * 32, 0, 32, 32, 5, desty);
            blit(game.surface[PATH_BLOCKS], LINE_HOR * 32, 0, 32, 32, 37, desty);
            blit(game.surface[PATH_BLOCKS], LINE_HOR * 32, 0, 32, 32, 69, desty);
            blit(game.surface[PATH_BLOCKS], LINE_LL * 32, 0, 32, 32, 101, desty);
            blit(game.surface[BLOCKS], GREEN * 32, 0, 32, 32, 5, desty + 32);
            change_corner_style(5, desty + 32);
            blit(game.surface[BLOCKS], LIGHTBLUE * 32, 0, 32, 32, 37, desty + 32);
            change_corner_style(37, desty + 32);
            blit(game.surface[BLOCKS], GREEN * 32, 0, 32, 32, 101, desty + 32);
            change_corner_style(101, desty + 32);
            blit(game.surface[BLOCKS], RED * 32, 0, 32, 32, 5, desty + 64);
            change_corner_style(5, desty + 32);
            blit(game.surface[PATH_BLOCKS], LINE_UR * 32, 0, 32, 32, 37, desty + 64);
            blit(game.surface[BLOCKS], LIGHTBLUE * 32, 0, 32, 32, 69, desty + 64);
            change_corner_style(69, desty + 32);
            blit(game.surface[BLOCKS], RED * 32, 0, 32, 32, 5, desty + 96);
            change_corner_style(5, desty + 96);
            blit(game.surface[BLOCKS], YELLOW * 32, 0, 32, 32, 37, desty + 96);
            change_corner_style(37, desty + 96);
            blit(game.surface[PATH_BLOCKS], LINE_HOR * 32, 0, 32, 32, 69, desty + 96);
            blit(game.surface[BLOCKS], YELLOW * 32, 0, 32, 32, 101, desty + 96);
            change_corner_style(101, desty + 96);
            print_word("All of the blocks can be removed on any skill level, since they are all between 0", 147, desty+=32, SERIFG20);
            print_word("and 2 turns for the path or next to each other like the red ones.", 147, desty+=game.font[SERIFG20].height, SERIFG20);
            desty = 20 + game.font[SERIFG20].height + 320;
            blit(game.surface[PATH_BLOCKS], LINE_LR * 32, 0, 32, 32, 5, desty);
            blit(game.surface[PATH_BLOCKS], LINE_HOR * 32, 0, 32, 32, 37, desty);
            blit(game.surface[PATH_BLOCKS], LINE_HOR * 32, 0, 32, 32, 69, desty);
            blit(game.surface[PATH_BLOCKS], LINE_LL * 32, 0, 32, 32, 101, desty);
            blit(game.surface[BLOCKS], DARKBLUE * 32, 0, 32, 32, 5, desty + 32);
            color_l_and_r = game.color_l_and_r[DARKBLUE] - 48;
            blit(game.surface[2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, 5, desty + 32);
            change_corner_style(5, desty + 32);
            blit(game.surface[BLOCKS], LIGHTBLUE * 32, 0, 32, 32, 37, desty + 32);
            color_l_and_r = game.color_l_and_r[LIGHTBLUE] - 48;
            blit(game.surface[BLACK_L + color_l_and_r], 0, 0, 32, 32, 37, desty + 32);
            change_corner_style(37, desty + 32);
            blit(game.surface[BLOCKS], GREEN * 32, 0, 32, 32, 69, desty + 32);
            color_l_and_r = game.color_l_and_r[GREEN] - 48;
            blit(game.surface[2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, 69, desty + 32);
            change_corner_style(69, desty + 32);
            blit(game.surface[BLOCKS], DARKBLUE * 32, 0, 32, 32, 101, desty + 32);
            color_l_and_r = game.color_l_and_r[DARKBLUE] - 48;
            blit(game.surface[BLACK_L + color_l_and_r], 0, 0, 32, 32, 101, desty + 32);
            change_corner_style(101, desty + 32);
            blit(game.surface[BLOCKS], PURPLE * 32, 0, 32, 32, 5, desty + 64);
            color_l_and_r = game.color_l_and_r[PURPLE] - 48;
            blit(game.surface[BLACK_L + color_l_and_r], 0, 0, 32, 32, 5, desty + 64);
            change_corner_style(5, desty + 32);
            blit(game.surface[BLOCKS], GREY * 32, 0, 32, 32, 37, desty + 64);
            color_l_and_r = game.color_l_and_r[GREY] - 48;
            blit(game.surface[BLACK_L + color_l_and_r], 0, 0, 32, 32, 37, desty + 64);
            change_corner_style(37, desty + 32);
            blit(game.surface[BLOCKS], RED * 32, 0, 32, 32, 69, desty + 64);
            color_l_and_r = game.color_l_and_r[RED] - 48;
            blit(game.surface[2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, 69, desty + 64);
            change_corner_style(69, desty + 96);
            blit(game.surface[BLOCKS], BROWN * 32, 0, 32, 32, 101, desty + 64);
            color_l_and_r = game.color_l_and_r[BROWN] - 48;
            blit(game.surface[2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, 101, desty + 64);
            change_corner_style(101, desty + 96);
            blit(game.surface[BLOCKS], ORANGE * 32, 0, 32, 32, 5, desty + 96);
            color_l_and_r = game.color_l_and_r[ORANGE] - 48;
            blit(game.surface[BLACK_L + color_l_and_r], 0, 0, 32, 32, 5, desty + 96);
            change_corner_style(5, desty + 96);
            blit(game.surface[BLOCKS], YELLOW * 32, 0, 32, 32, 37, desty + 96);
            color_l_and_r = game.color_l_and_r[YELLOW] - 48;
            blit(game.surface[2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, 37, desty + 96);
            change_corner_style(37, desty + 96);
            blit(game.surface[BLOCKS], RED * 32, 0, 32, 32, 69, desty + 96);
            color_l_and_r = game.color_l_and_r[RED] - 48;
            blit(game.surface[2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, 69, desty + 96);
            change_corner_style(69, desty + 96);
            blit(game.surface[BLOCKS], PINK * 32, 0, 32, 32, 101, desty + 96);
            color_l_and_r = game.color_l_and_r[PINK] - 48;
            blit(game.surface[BLACK_L + color_l_and_r], 0, 0, 32, 32, 101, desty + 96);
            change_corner_style(101, desty + 96);
            print_word("You must hit the left blue block with the right mouse button and right blue one", 147, desty+=32, SERIFG20);
            print_word("with the left mouse button. The two reds must be removed with the right mouse", 147, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("button.", 147, desty+=game.font[SERIFG20].height, SERIFG20);
            desty+=48;
            print_word("Press 'b' or 'c' to see the different block & corner styles.", -800, desty, SERIFW20);
            print_word("Press the number keys to see the different L & R colors.", -800, desty+=game.font[SERIFG20].height, SERIFW20);
            break;
        }
        /* page six */
        case 5: {
            print_word("Credits & Thanks", -800, 0, SERIFW24);
            print_word("Conrad Rotondella at pocketfuel.com - for letting me use his excellent music loops in my game.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty += 20;
            print_word("All sounds are from flashkit.com. Only those with the Freeware license were used for the game.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty += 20;
            print_word("The Snake Skin blocks came from a tutorial by Marin Laetitia (titix) on the Gimp User Group web", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("site (gug.sunsite.dk).", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty += 20;
            print_word("The fading effect for menu/screen changes came from Bernhard Bliem's Wheep game", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("(wheep.sourceforge.net).", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty += 20;
            print_word("Michael Westerlund for the ideas to use the left & right mouse buttons on the Insane mode as well", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("as bonus scoring for multiple pairs of the same color.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty += 20;
            print_word("Iris Bussey for the idea of having gravity as an option similar to Shisen-Sho.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty += 20;
            print_word("S.C. G.M. K.O. & J.T.  - the first four beta testers who provided me with a lot of feedback while", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("they played the game in its earliest stages.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty += 20;
            print_word("Fellow members in the Orbz gaming community (you know who you are!) who expressed a great", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            print_word("deal of interest in seeing me complete this game.", 5, desty+=game.font[SERIFG20].height, SERIFG20);
            desty += 30;
            print_word("I hope you all have as much fun playing this game as I did writing it. Enjoy!", -800, desty+=game.font[SERIFW20].height, SERIFW20);
            break;
        }
    }
    print_word(page_x_of_num, 800 - word_width(page_x_of_num, SERIFG20) - 5, 0, SERIFW20);
    print_word("Use the mouse wheel, left mouse button or arrow keys to change help screens.", -800, 600 - game.font[SERIFG20].height * 2, SERIFW20);
    print_word("Press the right mouse button or Esc to return to the main menu.", -800, 600 - game.font[SERIFG20].height, SERIFW20);
    if (game.fading_effect && !game.fading_off_temp)
        fade_screen(FADE_IN, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
    SDL_UpdateRect(game.screen, 0, 0, 0, 0);
    game.fading_off_temp = 0;
    
}

void blit(SDL_Surface *source, Sint16 srcx, Sint16 srcy, Uint16 srcw, Uint16 srch, Sint16 destx, Sint16 desty) {
    
    SDL_Rect src, dest;
    
    src.x = srcx;
    src.y = srcy;
    src.w = srcw;
    src.h = srch;
    /* if destx or desty is negative, center graphic according to the co-ordinates */
    if (destx < 0)
        dest.x = (abs(destx) - srcw) / 2;
    else
        dest.x = destx;
    if (desty < 0)
        dest.y = (abs(desty) - srch) / 2;
    else
        dest.y = desty;
    SDL_BlitSurface(source, &src, game.screen, &dest);
    game.blit_done = 1;
    
}

void fill(Sint16 destx, Sint16 desty, Uint16 destw, Uint16 desth, Uint8 red, Uint8 green, Uint8 blue) {
    
    SDL_Rect dest;
    
    dest.x = destx;
    dest.y = desty;
    dest.w = destw;
    dest.h = desth;
    SDL_FillRect(game.screen, &dest, SDL_MapRGB(game.screen->format, red, green, blue));
    game.blit_done = 1;

}

void blank_screen() {
    
    fill(0, 0, 800, 600, 0, 0, 0);

}

int word_width(char *word, int font) {

    int i, len, chr;
    
    len = 0;
    for (i = 0; i < strlen(word); i++) {
        chr = word[i];
        len += game.font[font].width[chr - 32];
    }
    return len;
    
}

void play_game() {

    int level_time, start_new_game;
    int times[11] = {770, 690, 620, 560, 500, 450, 410, 370, 340, 310, 290};
    
    start_new_game = 1;
    while (start_new_game) {
        game.best_time = 500000;
        game.elapsed_time = level_time = game.score = game.exit_game = 0;
        game.score = game.no_wrong_moves = game.highx = game.highy = 0;
        game.current_level = game.not_over = 1;
        if (game.music_enabled) randomize_music();
        while (game.not_over) {
            /* save the fastest time for a level */
            if (level_time && game.stop_timer + game.added_time < game.best_time)
                game.best_time = game.stop_timer + game.added_time;
            /* subtract a set amount of time after level 11 */
            if (game.current_level > 11)
                game.level_time -= 10;
            else
                game.level_time = times[level_time];
            play_level();
            if (game.exit_game == NEW_GAME) {
                start_new_game = 1;
                break;
            }
            /* increase time for next level */
            if (level_time != 12)
                level_time++;
        }
        if (game.exit_game != NEW_GAME) {
            start_new_game = game_over();
            #ifndef NOAUDIO
            if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
            #endif
        }
    }
    game.option_toggle = 1;
    display_high_scores(NUM_SKILLS * game.gravity + game.skill_level);

}

void play_level() {
    
    int erase_it, cur_music, time_to_add;
    struct path_info *path;
    #ifndef NOAUDIO
    char *filename[6] = {DATA_PREFIX "music/1-1.ogg",
                         DATA_PREFIX "music/2-1.ogg",
                         DATA_PREFIX "music/3-1.ogg",
                         DATA_PREFIX "music/4-1.ogg",
                         DATA_PREFIX "music/5-1.ogg",
                         DATA_PREFIX "music/6-1.ogg"};
    #endif
    
    cur_music = game.music_loop[game.current_level % MUSIC_LOOPS - 1];
    create_random_grid();
    game.level_start = game.start_timer = game.block_num = game.erased = 0;
    game.paused = game.paused_time = game.path_count = game.skipped_time = 0;
    game.prev_time = game.current_combos_removed = game.bonus_score = 0;
    game.current_sets_removed = game.blink = game.added_time = 0;
    game.no_matching_colors = game.random_block_time = 0;
    game.no_wrong_moves += 10;
    game.blink_time = 10080;
    game.last_color_removed = -1;
    /* we'll randomize the blocks every 20 - 25 seconds */
    time_to_add = 15000;
    draw_grid_on_screen();
    if (game.current_level == 1) {
        if (game.fading_effect)
            fade_screen(FADE_IN, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
        SDL_UpdateRect(game.screen, 0, 0, 0, 0);
    }
	/* main game loop */
    while (1) {
        game.elapsed_time = SDL_GetTicks() - (game.start_timer + game.paused_time);
        /* randomize the blocks for Very Hard & Insane
           if the perscribed time has passed */
        if (game.elapsed_time > game.random_block_time && game.skill_level > HARD && game.level_start) {
            if (game.random_block_time > 0) {
                randomize_blocks();
                draw_grid_on_screen();
            }
            game.random_block_time += time_to_add + rnd(5000);
        }            
        if (game.level_start && !game.paused) {
            /* start playing the music */
            #ifndef NOAUDIO
            if (game.music == NULL && game.audio_enabled) {
                if (game.music_enabled) {
                    game.music = Mix_LoadMUS(filename[cur_music - 1]);
                    Mix_PlayMusic(game.music, -1);
                }
            }
            #endif
            /* don't update timer if all 50 blocks have been found */
            if (game.block_num != 50) {
                update_timer();
            }
            /* level over... */
            if (game.block_num == 50 && game.stop_timer / game.level_time < 156) {
                /*...but don't exit just yet (the path is still being drawn) */
                if (game.erased != 50)
                    game.timer_height = (game.stop_timer + game.skipped_time) / game.level_time + 2;
                /* ...exit, last path has been drawn */
                else {
                    game.timer_height = (game.stop_timer + game.skipped_time) / game.level_time + 2;
                    break;
                }
            }
            /* game over */
            else if (game.elapsed_time / game.level_time > 155) {
                blit(game.surface[TIMER_EMPTY], 0, 0, 160, 32, GRIDSTARTX + 80, 545);
                break;
            }
        }
        /* see if the user does anything besides look in wonder at the graphics ;-) */
        path = get_input_for_level(path);
        /* the user chose to end the current game */
        if (game.exit_game) {
            game.not_over = game.paused = 0;
            #ifndef NOAUDIO
        	if (game.audio_enabled) {
                if (game.music_enabled) {
                    Mix_HaltMusic();
                    Mix_FreeMusic(game.music);
                }
	            game.music = NULL;
            }
            #endif
            return;
        }
        if (game.highx > 0 && !game.paused)
            update_highlighted_block();
        /* check the list to see if any new path should be drawn */
        erase_it = show_path(path);
        if (erase_it != 51) {
            game.erased++;
            path = erase_path(path, erase_it);
        }
        /* update the screen only if something was blitted */
        if (game.blit_done) {
            print_score_and_bonus();
            SDL_UpdateRect(game.screen, 0, 0, 0, 0);
            game.blit_done = 0;
        }
        /* place a small delay so we don't suck up all of the CPU */
        SDL_Delay(10);
    }
    #ifndef NOAUDIO
  	if (game.audio_enabled) {
        game.regular_music = 1;
        if (game.music_enabled) {
            Mix_HaltMusic();
            Mix_FreeMusic(game.music);
        }
	    game.music = NULL;
    }
    #endif
    /* apply bonus score if time hasn't ran out */
    if (game.block_num == 50 && game.stop_timer / game.level_time < 156)
        apply_bonus_score();
    else
        game.not_over = 0;

}

void update_highlighted_block() {

    int destx, desty;
    if (SDL_GetTicks() - game.block_highlight_time >= 80) {
        destx = (game.highx - 1) * 32 + GRIDSTARTX;
        desty = (game.highy - 1) * 32 + GRIDSTARTY;
        game.block_highlight_num++;
        if (game.block_highlight_num > HIGHLIGHT4)
            game.block_highlight_num = HIGHLIGHT1;
        blit(game.surface[game.block_highlight_num], 0, 0, 32, 32, destx, desty);
        game.block_highlight_time = SDL_GetTicks();
    }

}

void update_score_and_bonus() {

    int bonus[5] = {0, 5, 10, 15, 25};
    Uint32 getticks;
    
    game.score++;
    /* if colors don't match, don't apply any bonus */
    if (game.last_color_removed == game.grid[game.highx][game.highy].color) {
        game.current_combos_removed++;
        /* most combos possible removed, start over */
        game.bonus_score = game.bonus_score + bonus[game.current_combos_removed];
        if (game.current_combos_removed == 4) {
            game.current_combos_removed = 0;
            game.no_matching_colors = 0;
            game.bonus_score = game.bonus_score + 10 * (game.current_sets_removed);
            game.current_sets_removed++;
            if (game.block_num != 50)
                game.added_time += game.level_time * 5;
            game.paused_time += game.level_time * 5;
            /* if the player is quick enough, 5 ticks won't be gone from the
               clock when they get a set removed; only put back enough time
               back on to bring the timer to full again, not more than full.
               The second part of the if is in place for when start_timer is
               negative (assumes the game isn't running for more than 40 days
               straight!) */
            getticks = SDL_GetTicks();
            if (getticks < game.start_timer + game.paused_time && game.start_timer < 4 * pow(10, 9)) {
                if (game.block_num != 50)
                    game.added_time -= (game.start_timer + game.paused_time) - getticks;
                game.paused_time -= (game.start_timer + game.paused_time) - getticks;
            }
        }
        game.last_color_removed = game.grid[game.highx][game.highy].color;
    }
    else {
        game.no_matching_colors++;
        /* if this is the second set in a row that a player doesn't remove the
           same color blocks, reset the current sets removed */
        if (game.no_matching_colors > 1)
            game.current_sets_removed = 0;
        game.current_combos_removed = 0;
        game.last_color_removed = game.grid[game.highx][game.highy].color;
    }
    
}

void print_score_and_bonus() {

    int x, centerx, rightx;
    
    num_to_str(game.score, 5);
    centerx = GRIDSTARTX + 224 - word_width(game.temp_string, SERIFG24);
    free(game.temp_string);
    x = GRIDSTARTX + 96 + word_width("Score:", SERIFG24);
    fill(x, 505, (GRIDSTARTX + 224) - x, game.font[SERIFG24].height, 0, 0, 0);
    print_word("Score:", GRIDSTARTX + 96, 505, SERIFG24);
    print_number(centerx, 505, SERIFG24, game.score, 5);
    num_to_str(game.bonus_score, 5);
    rightx = GRIDSTARTX + 361 - word_width(game.temp_string, SERIFG24);
    free(game.temp_string);
    x = GRIDSTARTX + 240 + word_width("Bonus:", SERIFG24);
    fill(x, 505, (GRIDSTARTX + 361) - x, game.font[SERIFG24].height, 0, 0, 0);
    print_word("Bonus:", GRIDSTARTX + 240, 505, SERIFG24);
    print_number(rightx, 505, SERIFG24, game.bonus_score, 5);
    
}

void apply_bonus_score() {
    
    int i, timer_height;
    Uint32 capture_time;
    
    SDL_EventState(SDL_MOUSEMOTION, SDL_IGNORE);
    SDL_EventState(SDL_MOUSEBUTTONDOWN, SDL_IGNORE);
    print_word("Applying time bonus...", -800, -600, SERIFG24);
    SDL_UpdateRect(game.screen, 0, 0, 0, 0);
    capture_time = SDL_GetTicks();
    while (SDL_GetTicks() - capture_time < 200) {
        SDL_PumpEvents();
    }
    timer_height = 160 - game.timer_height;
    for (i = 1; i <= (156 - (game.stop_timer + game.skipped_time) / game.level_time); i++) {
        if (i == 1)
            blit(game.surface[TIMER_FULL], 0, 0, 160, 32, GRIDSTARTX + 80, 545);
        blit(game.surface[TIMER_EMPTY], timer_height - i, 0, 160 - timer_height + i, 32, GRIDSTARTX + 80 + timer_height - i, 545);
        game.score += 1;
        print_score_and_bonus();
        SDL_UpdateRect(game.screen, 0, 0, 0, 0);
        #ifndef NOAUDIO
        if (game.audio_enabled) Mix_PlayChannel(APPLY_BONUS, game.sound[APPLY_BONUS], 0);
        #endif
        capture_time = SDL_GetTicks();
        while (SDL_GetTicks() - capture_time < 70) {
            SDL_PumpEvents();
        }
    }
    if (game.bonus_score > 0) {
        print_word("Applying combo bonus...", -800, -600, SERIFG24);
        SDL_UpdateRect(game.screen, 0, 0, 0, 0);
        capture_time = SDL_GetTicks();
        while (SDL_GetTicks() - capture_time < 200) {
            SDL_PumpEvents();
        }
        while (game.bonus_score != 0) {
            if (game.bonus_score > 20) {
                game.score += 20;
                game.bonus_score -= 20;
            }
            else {
                game.score += game.bonus_score;
                game.bonus_score = 0;
            }
            print_score_and_bonus();
            SDL_UpdateRect(game.screen, 0, 0, 0, 0);
            #ifndef NOAUDIO
            if (game.audio_enabled) Mix_PlayChannel(APPLY_BONUS, game.sound[APPLY_BONUS], 0);
            #endif
            capture_time = SDL_GetTicks();
            while (SDL_GetTicks() - capture_time < 70) {
                SDL_PumpEvents();
            }
        }
    }
    if (game.no_wrong_moves > 0) {
        print_word("Applying no wrong moves bonus...", -800, -600, SERIFG24);
        /* 50 points for the first time making no wrong moves, an extra 10
           points for each thereafter while doing the same */
        game.bonus_score = 40 + game.no_wrong_moves;
        print_score_and_bonus();
        SDL_UpdateRect(game.screen, 0, 0, 0, 0);
        capture_time = SDL_GetTicks();
        while (SDL_GetTicks() - capture_time < 750) {
            SDL_PumpEvents();
        }
        while (game.bonus_score != 0) {
            if (game.bonus_score > 5) {
                game.score += 5;
                game.bonus_score -= 5;
            }
            else {
                game.score += game.bonus_score;
                game.bonus_score = 0;
            }
            print_score_and_bonus();
            SDL_UpdateRect(game.screen, 0, 0, 0, 0);
            #ifndef NOAUDIO
            if (game.audio_enabled) Mix_PlayChannel(APPLY_BONUS, game.sound[APPLY_BONUS], 0);
            #endif
            capture_time = SDL_GetTicks();
            while (SDL_GetTicks() - capture_time < 70) {
                SDL_PumpEvents();
            }
        }
    }
    capture_time = SDL_GetTicks();
    while (SDL_GetTicks() - capture_time < 200) {
        SDL_PumpEvents();
    }
    game.current_level++;
    SDL_EventState(SDL_MOUSEMOTION, SDL_ENABLE);
    SDL_EventState(SDL_MOUSEBUTTONDOWN, SDL_ENABLE);

}

void update_timer() {
    
    int cur_music;
    Uint32 temp_time;
    #ifndef NOAUDIO
    char *filename[6] = {DATA_PREFIX "music/1-2.ogg",
                         DATA_PREFIX "music/2-2.ogg",
                         DATA_PREFIX "music/3-2.ogg",
                         DATA_PREFIX "music/4-2.ogg",
                         DATA_PREFIX "music/5-2.ogg",
                         DATA_PREFIX "music/6-2.ogg"};
    #endif
    
    cur_music = game.music_loop[game.current_level % MUSIC_LOOPS - 1];
    /* the game is soon over... blink the timer for the last 10 seconds */
    if (game.level_time * 156 - game.elapsed_time < 10000) {
        /* change the music to reflect the urgency of the game */
        if (game.regular_music && game.audio_enabled) {
            game.regular_music = 0;
            #ifndef NOAUDIO
            if (game.music_enabled) {
                Mix_HaltMusic();
                Mix_FreeMusic(game.music);
                game.music = Mix_LoadMUS(filename[cur_music - 1]);
                Mix_PlayMusic(game.music, -1);
            }
            #endif
        }
        if (!game.blink && game.elapsed_time - game.blink_time > 80) {
            game.blink_time = game.elapsed_time;
            game.blink = 1;
            blit(game.surface[TIMER_FULL_WHITE], 0, 0, 160, 32, GRIDSTARTX + 80, 545);
            blit(game.surface[TIMER_EMPTY_WHITE], 160 - game.elapsed_time / game.level_time - 2, 0, game.elapsed_time / game.level_time + 2, 32, GRIDSTARTX + 80 + 160 - game.elapsed_time / game.level_time - 2, 545);
        }
        else if (game.blink && game.elapsed_time - game.blink_time > 80) {
            game.blink_time = game.elapsed_time;
            game.blink = 0;
            blit(game.surface[TIMER_FULL], 0, 0, 160, 32, GRIDSTARTX + 80, 545);
            blit(game.surface[TIMER_EMPTY], 160 - game.elapsed_time / game.level_time - 2, 0, game.elapsed_time / game.level_time + 2, 32, GRIDSTARTX + 80 + 160 - game.elapsed_time / game.level_time - 2, 545);
        }
    }
    /* show regular timer */
    else {
        temp_time = game.elapsed_time / game.level_time + 2;
        if (temp_time != game.prev_time) {
            game.prev_time = temp_time;
            blit(game.surface[TIMER_FULL], 0, 0, 160, 32, GRIDSTARTX + 80, 545);
            blit(game.surface[TIMER_EMPTY], 160 - game.elapsed_time / game.level_time - 2, 0, game.elapsed_time / game.level_time + 2, 32, GRIDSTARTX + 80 + 160 - game.elapsed_time / game.level_time - 2, 545);
        }
    }
            
}

struct path_info *get_input_for_level(struct path_info *path) {

    int i, x, y, cnt;
    SDL_Event event;
    SDL_keysym keysym;
    HIGHLIGHT_INFO highlight[NUM_IN_GAME_MO] = 
       {{5, 5 + word_width("New Game", SERIFG24), 5, 5 + game.font[SERIFG24].height, "New Game"},
        {5 + word_width("New Game  ", SERIFG24), 5 + word_width("New Game  Pause", SERIFG24), 5, 5 + game.font[SERIFG24].height, "Pause  "},
        {795 - word_width("Help  Exit", SERIFG24), 795 - word_width("  Exit", SERIFG24), 5, 5 + game.font[SERIFG24].height, "Help"},
        {795 - word_width("Exit", SERIFG24), 795, 5, 5 + game.font[SERIFG24].height, "Exit"}};
    
    if (game.paused) {
        highlight[PAUSE].x2 = 5 + word_width("New Game  Unpause", SERIFG24);
        strcpy(highlight[PAUSE].name, "Unpause");
    }
    if (SDL_PollEvent(&event)) {
        switch (event.type) {
            case SDL_MOUSEBUTTONDOWN:
                if (event.button.button == SDL_BUTTON_LEFT || event.button.button == SDL_BUTTON_RIGHT) {
                    /* see if we are on the grid */
                    if (event.button.x >= GRIDSTARTX && event.button.x < GRIDSTARTX + 320 && event.button.y >= GRIDSTARTY && event.button.y < GRIDSTARTY + 320 && !game.paused) {
                        /* the game is just starting... */
                        if (game.level_start == 0) {
                            game.start_timer = SDL_GetTicks();
                            game.paused_time = 0;
                            game.level_start = 1;
                        }
                        x = (event.button.x - GRIDSTARTX) / 32 + 1;
                        y = (event.button.y - GRIDSTARTY) / 32 + 1;
                        cnt = game.path_count;
                        path = change_grid(x, y, path, event.button.button);
                        /* did we find two blocks that match? */
                        if (cnt != game.path_count) {
                            update_score_and_bonus();
                            game.grid[x][y].status = BLOCK_GOING;
                            game.grid[game.highx][game.highy].status = BLOCK_GOING;
                            game.highx = game.highy = game.turns = 0;
                        }
                    }
                    /* start a new game */
                    else if (event.button.x >= highlight[NEWGAME].x1 && event.button.x < highlight[NEWGAME].x2 && event.button.y >= highlight[NEWGAME].y1 && event.button.y < highlight[NEWGAME].y2) {
                        print_word(highlight[NEWGAME].name, highlight[NEWGAME].x1, highlight[NEWGAME].y1, SERIFG24);
                        game.highlight[NEWGAME] = 0;
                        exit_game(path, NEW_GAME);
                    }
                    /* quit the game */
                    else if (event.button.x >= highlight[EXIT].x1 && event.button.x < highlight[EXIT].x2 && event.button.y >= highlight[EXIT].y1 && event.button.y < highlight[EXIT].y2) {
                        print_word(highlight[EXIT].name, highlight[EXIT].x1, highlight[EXIT].y1, SERIFG24);
                        game.highlight[EXIT] = 0;
                        exit_game(path, EXIT_GAME);
                    }
                    /* pause or unpause game */
                    else if (event.button.x >= highlight[PAUSE].x1 && event.button.x < highlight[PAUSE].x2 && event.button.y >= highlight[PAUSE].y1 && event.button.y < highlight[PAUSE].y2) {
                        if (!game.paused) {
                            #ifndef NOAUDIO
                            if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                            #endif
                            pause_game("Game Paused");
                            if (game.pause_mode == MINIMIZE)
                                SDL_WM_IconifyWindow();
                            print_word("Unpause", highlight[PAUSE].x1, highlight[PAUSE].y1, SERIFG24);
                        }
                        else {
                            #ifndef NOAUDIO
                            if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                            #endif
                            unpause_game();
                            highlight[PAUSE].x2 = 438 + word_width("Pause", SERIFG24);
                            fill(highlight[PAUSE].x1, highlight[PAUSE].y1, word_width("Unpause", SERIFG24), game.font[SERIFG24].height, 0, 0, 0);
                            print_word("Pause", highlight[PAUSE].x1, highlight[PAUSE].y1, SERIFG24);
                        }
                        game.highlight[PAUSE] = 0;
                    }
                    /* display the help screen */
                    else if (event.button.x >= highlight[HELP].x1 && event.button.x < highlight[HELP].x2 && event.button.y >= highlight[HELP].y1 && event.button.y < highlight[HELP].y2) {
                        print_word(highlight[HELP].name, highlight[HELP].x1, highlight[HELP].y1, SERIFG24);
                        game.highlight[HELP] = 0;
                        if (game.level_start) pause_game("Game Paused");
                        display_help();
                        if (game.fading_effect)
                            fade_screen(FADE_OUT, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
                        draw_grid_on_screen();
                        if (game.fading_effect)
                            fade_screen(FADE_IN, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
                    }
                    /* change the sound volume */
                    else if (event.button.x >= 182 && event.button.x < 182 + 129 && event.button.y >= 545 && event.button.y < 577)
                        change_volume(SOUND, event.button.x - 182, 180, 545, TOGGLE_NO, MOVE_SLIDER);
                    /* change the music volume */
                    else if (event.button.x >= 485 + word_width("Music: ", SERIFG24) && event.button.x < 485 + word_width("Music: ", SERIFG24) + 129 && event.button.y >= 545 && event.button.y < 577 && game.music_enabled)
                        change_volume(MUSIC, event.button.x - (485 + word_width("Music: ", SERIFG24)), 483 + word_width("Music: ", SERIFG24), 545, TOGGLE_NO, MOVE_SLIDER);
                }
                break;
            case SDL_MOUSEMOTION:
                /* highlight/unlight in-game menu options */
                for (i = 0; i < 4; i++) {
                    if (event.button.x >= highlight[i].x1 && event.button.x < highlight[i].x2 && event.button.y >= highlight[i].y1 && event.button.y < highlight[i].y2) {
                        if (!game.highlight[i]) {
                            print_word(highlight[i].name, highlight[i].x1, highlight[i].y1, SERIFW24);
                            game.highlight[i] = 1;
                            #ifndef NOAUDIO
                            if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
                            #endif
                        }
                    }
                    else {
                        if (game.highlight[i]) {
                            print_word(highlight[i].name, highlight[i].x1, highlight[i].y1, SERIFG24);
                            game.highlight[i] = 0;
                            #ifndef NOAUDIO
                            if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
                            #endif
                        }
                    }
                }
                /* change the sound volume */
                if (event.motion.x >= 182 && event.motion.x < 182 + 129 && event.motion.y >= 545 && event.motion.y < 577 && event.motion.state == SDL_BUTTON(1))
                    change_volume(SOUND, event.motion.x - 182, 180, 545, TOGGLE_NO, MOVE_SLIDER);
                /* change the music volume */
                else if (event.motion.x >= 485 + word_width("Music: ", SERIFG24) && event.motion.x < 485 + word_width("Music: ", SERIFG24) + 129 && event.motion.y >= 545 && event.motion.y < 577 && event.motion.state == SDL_BUTTON(1) && game.music_enabled)
                    change_volume(MUSIC, event.motion.x - (485 + word_width("Music: ", SERIFG24)), 483 + word_width("Music: ", SERIFG24), 545, TOGGLE_NO, MOVE_SLIDER);
                break;
            case SDL_KEYDOWN:
                keysym = event.key.keysym;
                /* change the color of the l & r for the Insane mode */
                if (keysym.sym >= SDLK_0 && keysym.sym <= SDLK_9 && game.skill_level == INSANE) {
                    game.color_l_and_r[keysym.sym - 48] = !(game.color_l_and_r[keysym.sym - 48] - 48) + 48;
                    draw_blocks();
                }
                /* change the block set */
                else if (keysym.sym == SDLK_b && !game.paused) {
                    game.block_set++;
                    if (game.block_set == NUM_BLOCK_SETS)
                        game.block_set = SQUARE_BRICKS;
                    change_block_set();
                    draw_blocks();
                }
                /* change the style of the corners of the blocks */
                else if (keysym.sym == SDLK_c && !game.paused) {
                    if (game.corner_style == SQUARE)
                        game.corner_style = ROUNDED;
                    else
                        game.corner_style = SQUARE;
                    draw_blocks();
                }
                /* needed under Windows to be able to use Alt-F4 to quit */
                else if (keysym.sym == SDLK_F4 && (keysym.mod & KMOD_ALT)) {
                    if (game.path_count > 0)
                        free(path);
                    cleanup_and_exit();
                }
                /* toggle between full screen/window mode */
                else if (keysym.sym == SDLK_f || keysym.sym == SDLK_F4) {
                    change_display_mode();
                    draw_grid_on_screen();
                }
                /* pause the game and display the help screen */
                else if (keysym.sym == SDLK_h || keysym.sym == SDLK_F1) {
                    if (game.level_start) pause_game("Game Paused");
                    display_help();
                    if (game.fading_effect)
                        fade_screen(FADE_OUT, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
                    draw_grid_on_screen();
                    if (game.fading_effect)
                        fade_screen(FADE_IN, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
                }
                /* turn the background music on/off */
                else if (keysym.sym == SDLK_m && game.music_enabled) {
                    if (game.music_volume == 0)
                        change_volume(MUSIC, game.old_music_volume, 483 + word_width("Music: ", SERIFG24), 545, TOGGLE_YES, MOVE_SLIDER);
                    else {
                        game.old_music_volume = game.music_volume;
                        change_volume(MUSIC, 0, 483 + word_width("Music: ", SERIFG24), 545, TOGGLE_YES, MOVE_SLIDER);
                    }
                }
                /* start a new game */
                else if (keysym.sym == SDLK_n || keysym.sym == SDLK_F2)
                    exit_game(path, NEW_GAME);
                /* pause or unpause game */
                else if (keysym.sym == SDLK_p || keysym.sym == SDLK_PAUSE || keysym.sym == SDLK_F3) {
                    if (!game.paused) {
                        #ifndef NOAUDIO
                        if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                        #endif
                        pause_game("Game Paused");
                        if (game.pause_mode == MINIMIZE)
                            SDL_WM_IconifyWindow();
                    }
                    else {
                        #ifndef NOAUDIO
                        if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
                        #endif
                        unpause_game();
                    }
                }
                /* quit the game */
                else if (keysym.sym == SDLK_ESCAPE || keysym.sym == SDLK_q)
                    exit_game(path, EXIT_GAME);
                /* turn the sound effects on/off */
                else if (keysym.sym == SDLK_s) {
                    if (game.sound_volume == 0)
                        change_volume(SOUND, game.old_sound_volume, 180, 545, TOGGLE_YES, MOVE_SLIDER);
                    else {
                        game.old_sound_volume = game.sound_volume;
                        change_volume(SOUND, 0, 180, 545, TOGGLE_YES, MOVE_SLIDER);
                    }
                }
                break;
            case SDL_QUIT:
                if (game.path_count > 0)
                    free(path);
                cleanup_and_exit();
        }
    }
    return path;

}

void change_volume(int volume_type, int volume, int x, int y, int toggle, int adjust_slider) {
    
    if (!game.audio_enabled) return;
    #ifndef NOAUDIO
    if (volume_type == SOUND) {
        game.sound_volume = volume;
        if (toggle == TOGGLE_NO) game.old_sound_volume = volume;
        Mix_Volume(-1, game.sound_volume);
    }
    else {
        /* music was stopped, start playing it again */
        if (game.music_volume == 0 && volume > 0) {
            Mix_ResumeMusic();
            /* don't play the music if the game is paused! */
            if (game.paused)
                Mix_PauseMusic();
        }
        game.music_volume = volume;
        if (toggle == TOGGLE_NO) game.old_music_volume = volume;
        Mix_VolumeMusic(game.music_volume);
        /* music volume is off, stop playing the music */
        if (game.music_volume == 0)
            Mix_PauseMusic();
    }
    if (adjust_slider == MOVE_SLIDER) {
        blit(game.surface[VOLUME_BAR], 0, 0, 133, 32, x, y);
        blit(game.surface[VOLUME_SLIDER], 0, 0, 5, 32, volume + x, y);
    }
    #endif
    
}

void change_block_set() {

    int loaded;
    
    SDL_FreeSurface(game.surface[BLOCKS]);
    switch (game.block_set) {
        case SQUARE_BRICKS:
            game.surface[BLOCKS] = load_image(DATA_PREFIX "graphics/bricks" EXTENSION, &loaded);
            break;
        case BEVELED_BLOCKS:
            game.surface[BLOCKS] = load_image(DATA_PREFIX "graphics/beveled" EXTENSION, &loaded);
            break;
        case SNAKE_SKIN_BLOCKS:
            game.surface[BLOCKS] = load_image(DATA_PREFIX "graphics/snake_skin" EXTENSION, &loaded);
            break;
        case PYRAMID_BLOCKS:
            game.surface[BLOCKS] = load_image(DATA_PREFIX "graphics/pyramids" EXTENSION, &loaded);
            break;
        case CIRCLES:
            game.surface[BLOCKS] = load_image(DATA_PREFIX "graphics/circles" EXTENSION, &loaded);
            break;
        case BRUSHED_METAL:
            game.surface[BLOCKS] = load_image(DATA_PREFIX "graphics/brushed_metal" EXTENSION, &loaded);
            break;
    }

}

void change_display_mode() {
    
    /* change to window mode */
    if (game.display_mode == FULLSCREEN) {
        game.screen = SDL_SetVideoMode(800, 600, 0, SDL_SWSURFACE);
        game.display_mode = WINDOW;
    }
    /* change to full screen mode (if possible) */
    else {
        game.screen = SDL_SetVideoMode(800, 600, 0, SDL_FULLSCREEN);
        if (game.screen == NULL)
            game.screen = SDL_SetVideoMode(800, 600, 0, SDL_SWSURFACE);
        else
            game.display_mode = FULLSCREEN;
    }

}

void setup_yes_no_xy (char *word, int destx, int desty, int font, HIGHLIGHT_INFO *highlight) {

    int newdestx, newdesty;
    
    /* if destx or desty is negative, center word according to the co-ordinates */
    if (destx < 0)
        newdestx = (abs(destx) - (word_width(word, font) + word_width("yes/no", font))) / 2;
    else
        newdestx = destx;
    if (desty < 0)
        newdesty = (abs(desty) - game.font[font].height) / 2;
    else
        newdesty = desty;
    strcpy(highlight[0].name, "yes");
    strcpy(highlight[1].name, "no");
    highlight[0].x1 = newdestx + word_width(word, font);
    highlight[0].x2 = highlight[0].x1 + word_width("yes", font);
    highlight[1].x1 = highlight[0].x2 + word_width("/", font);
    highlight[1].x2 = highlight[1].x1 + word_width("no", font);
    highlight[0].y1 = highlight[1].y1 = newdesty;
    highlight[0].y2 = highlight[1].y2 = newdesty + game.font[font].height;

}

int get_input_for_yes_no(HIGHLIGHT_INFO *yes_no) {

    int i, yn_highlight[2] = {0, 0};
    SDL_Event event;
    SDL_keysym keysym;

    while (1) {
        if (SDL_PollEvent(&event)) {
            switch (event.type) {
                case SDL_MOUSEBUTTONDOWN:
                    if (event.button.button == SDL_BUTTON_LEFT) {
                        /* yes */
                        if (event.button.x >= yes_no[0].x1 && event.button.x < yes_no[0].x2 && event.button.y >= yes_no[0].y1 && event.button.y < yes_no[0].y2)
                            return 1;
                        /* no */
                        else if (event.button.x >= yes_no[1].x1 && event.button.x < yes_no[1].x2 && event.button.y >= yes_no[1].y1 && event.button.y < yes_no[1].y2)
                            return 0;
                    }
                break;                
                case SDL_MOUSEMOTION:
                    /* highlight/unhighlight yes/no */
                    for (i = 0; i < 2; i++) {
                        if (event.button.x >= yes_no[i].x1 && event.button.x < yes_no[i].x2 && event.button.y >= yes_no[i].y1 && event.button.y < yes_no[i].y2) {
                            if (!yn_highlight[i]) {
                                print_word(yes_no[i].name, yes_no[i].x1, yes_no[i].y1, SERIFG24);
                                SDL_UpdateRect(game.screen, 0, 0, 0, 0);
                                yn_highlight[i] = 1;
                                #ifndef NOAUDIO
                                if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
                                #endif
                            }
                        }
                        else {
                            if (yn_highlight[i]) {
                                print_word(yes_no[i].name, yes_no[i].x1, yes_no[i].y1, SERIFW24);
                                SDL_UpdateRect(game.screen, 0, 0, 0, 0);
                                yn_highlight[i] = 0;
                                #ifndef NOAUDIO
                                if (game.audio_enabled) Mix_PlayChannel(MENU_OPTION, game.sound[MENU_OPTION], 0);
                                #endif
                            }
                        }
                    }
                    break;
                case SDL_KEYDOWN:
                    keysym = event.key.keysym;
                    if (keysym.sym == SDLK_y)
                        return 1;
                    else if (keysym.sym == SDLK_n)
                        return 0;
                    break;
                case SDL_QUIT:
                    return -1;
            }
        }
        SDL_Delay(10);
    }

}

void exit_game(struct path_info *path, int exit_type) {

    int answer;
    HIGHLIGHT_INFO yes_no[2];

    /* the game is already paused, just display the exit game message */
    #ifndef NOAUDIO
    if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
    #endif
    if (game.paused) {
        if (exit_type == EXIT_GAME) {
            print_word("Exit game? yes/no", -800, -600, SERIFW24);
            setup_yes_no_xy ("Exit game? ", -800, -600, SERIFW24, yes_no);
        }
        else {
            print_word("Start a new game? yes/no", -800, -600, SERIFW24);
            setup_yes_no_xy ("Start a new game? ", -800, -600, SERIFW24, yes_no);
        }
        SDL_UpdateRect(game.screen, 0, 0, 0, 0);
    }
    else {
        game.unpause_msg = 0;
        if (exit_type == EXIT_GAME) {
            pause_game("Exit game? yes/no");
            setup_yes_no_xy ("Exit game? ", -800, -600, SERIFW24, yes_no);
        }
        else {
            pause_game("Start a new game? yes/no");
            setup_yes_no_xy ("Start a new game? ", -800, -600, SERIFW24, yes_no);
        }
        game.unpause_msg = 1;
    }
    answer = get_input_for_yes_no(yes_no);
    #ifndef NOAUDIO
    if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
    #endif
    /* yes */
    if (answer == 1)
        game.exit_game = exit_type;
    /* no */
    else if (answer == 0)
        unpause_game();
    /* SDL_QUIT */
    else {
        if (game.path_count > 0)
            free(path);
        cleanup_and_exit();
    }
        
}

void read_highscore_file(struct highscore_info highscores[][10]) {

    FILE *scorefile;
    int i, x, y, pos, corrupt_file, num_groups;
    int num_chars[5] = {20, 5, 3, 20, 6};
    int lower[5] = {31, 47, 47, 31, 47};
    int upper[5] = {127, 58, 58, 127, 58};
    char chr, strng[21];
    
    /* We will read the file one character at a time to ensure each one is
       within range. Each field will be separated with a tab character. I'm only
       using a very basic form of encryption to keep the text editor cheaters
       from changing the file! ;-) */

    /* create an initial blank score file in memory */
    for (x = 0; x < game.num_groups; x++) {
        for (y = 0; y < 10; y++) {
            highscores[x][y].name_score[0] = '\0';
            highscores[x][y].score = 0;
            highscores[x][y].level = 0;
            highscores[x][y].name_time[0] = '\0';
            highscores[x][y].time = 120000;
        }
    }
    if ((scorefile = fopen(game.score_file, "r")) == NULL)
        fprintf(stderr, "Error reading the highscore file: %s\nCreating new one in memory\n", game.score_file);
    else {
        corrupt_file = 0;
        pos = 0;
        /* find out how many groups of high scores there are */
        chr = ~fgetc(scorefile);
        while (!corrupt_file && !feof(scorefile) && pos < 3 && chr != '\t') {
            /* only accept numbers */
            if (chr > 47 && chr < 58) {
                strng[pos] = chr;
                pos++;
            }
            chr = ~fgetc(scorefile);
        }
        if (chr == '\t')
            strng[pos] = '\0';
        else
            corrupt_file = 1;
        num_groups = atoi(strng);
        if (num_groups <= 0)
            corrupt_file = 1;
        for (x = 0; x < num_groups; x++) {
            for (y = 0; y < 10; y++) {
                for (i = 0; i < 5; i++) {
                    pos = 0;
                    chr = ~fgetc(scorefile);
                    while (!corrupt_file && !feof(scorefile) && pos < num_chars[i] && chr != '\t') {
                        /* only accept characters that are in the font file */
                        if (chr > lower[i] && chr < upper[i]) {
                            strng[pos] = chr;
                            pos++;
                        }
                        chr = ~fgetc(scorefile);
                    }
                    if (chr == '\t') {
                        strng[pos] = '\0';
                        /* place what we have read from the file into the highscore structure */
                        switch (i) {
                            case 0:
                                strcpy(highscores[x][y].name_score, strng);
                                break;
                            case 1:
                                highscores[x][y].score = atoi(strng);
                                break;
                            case 2:
                                highscores[x][y].level = atoi(strng);
                                break;
                            case 3:
                                strcpy(highscores[x][y].name_time, strng);
                                break;
                            case 4:
                                highscores[x][y].time = atoi(strng);
                                break;
                        }
                    }
                    else
                        corrupt_file = 1;
                }
            }
        }
        if (corrupt_file) {
            /* scores.dat corrupted... erase what's in memory with a new one */
            fprintf(stderr, "Your highscore file: %s is corrupted\nCreating new one in memory\n", game.score_file);
            for (x = 0; x < game.num_groups; x++) {
                for (y = 0; y < 10; y++) {
                    highscores[x][y].name_score[0] = '\0';
                    highscores[x][y].score = 0;
                    highscores[x][y].level = 0;
                    highscores[x][y].name_time[0] = '\0';
                    highscores[x][y].time = 120000;
                }
            }
        }
        fclose(scorefile);
    }
    
}

void write_highscore_file(struct highscore_info highscores[][10]) {

    FILE *scorefile;
    int i, x, y;
    
    if ((scorefile = fopen(game.score_file, "w")) == NULL)
        fprintf(stderr, "Error writing the highscore file: %s\nDo you have write access to this directory?\n", game.score_file);
    else {
        num_to_str(game.num_groups, 2);
        for (i = 0; i < strlen(game.temp_string); i++)
            fputc(~game.temp_string[i], scorefile);
        free (game.temp_string);
        fputc(~'\t', scorefile);
        for (x = 0; x < game.num_groups; x++) {
            for (y = 0; y < 10; y++) {
                /* name for score */
                for (i = 0; i < strlen(highscores[x][y].name_score); i++)
                    fputc(~highscores[x][y].name_score[i], scorefile);
                fputc(~'\t', scorefile);
                /* score */
                num_to_str(highscores[x][y].score, 5);
                for (i = 0; i < strlen(game.temp_string); i++)
                    fputc(~game.temp_string[i], scorefile);
                free (game.temp_string);
                fputc(~'\t', scorefile);
                /* level */
                num_to_str(highscores[x][y].level, 3);
                for (i = 0; i < strlen(game.temp_string); i++)
                    fputc(~game.temp_string[i], scorefile);
                free (game.temp_string);
                fputc(~'\t', scorefile);
                /* name for time */
                for (i = 0; i < strlen(highscores[x][y].name_time); i++)
                    fputc(~highscores[x][y].name_time[i], scorefile);
                fputc(~'\t', scorefile);
                /* time */
                num_to_str(highscores[x][y].time, 6);
                for (i = 0; i < strlen(game.temp_string); i++)
                    fputc(~game.temp_string[i], scorefile);
                free (game.temp_string);
                fputc(~'\t', scorefile);
            }
        }
        fclose(scorefile);
    }
    
}

void update_highscores() {
    
    int x, y, position;
    int high_score = 1;
    struct highscore_info highscores[NUM_SKILLS * 2][10];

    read_highscore_file(highscores);
    position = NUM_SKILLS * game.gravity + game.skill_level;
    /* see if we have a high score (scores less than 0 won't be added) */
    y = 0;
    while (y<10) {
        if (game.score > highscores[position][y].score) {
            /* we're on the list... move the rest of the scores down */
            for (x = 9; x > y; x--) {
                strcpy(highscores[position][x].name_score, highscores[position][x - 1].name_score);
                highscores[position][x].score = highscores[position][x - 1].score;
                highscores[position][x].level = highscores[position][x - 1].level;
            }
            /* add current game score into position */
            strcpy(highscores[position][y].name_score, game.player_name);
            highscores[position][y].score = game.score;
            highscores[position][y].level = game.current_level;
            break;
        }
        else
            y++;
    }
    if (y==10) high_score = 0;
    /* see if we have a best time */
    y = 0;
    while (y<10) {
        if (game.best_time < highscores[position][y].time) {
            /* we're on the list... move the rest of the times down */
            for (x = 9; x > y; x--) {
                strcpy(highscores[position][x].name_time, highscores[position][x - 1].name_time);
                highscores[position][x].time = highscores[position][x - 1].time;
            }
            /* add current game time into position */
            strcpy(highscores[position][y].name_time, game.player_name);
            highscores[position][y].time = game.best_time;
            break;
        }
        else
            y++;
    }
    if (y<10 || high_score)
        write_highscore_file(highscores);
}

int game_over() {

    int answer, font, start_new;
    int x, y;
    Uint32 capture_time;
    #ifndef NOAUDIO
    char *menu_music[2] = {DATA_PREFIX "music/0-0.ogg",
                           DATA_PREFIX "music/0-1.ogg"};
    #endif
    HIGHLIGHT_INFO yes_no[2];

    char *skill_levels[NUM_SKILLS] = {"Kids", "Easy", "Normal", "Hard", "Very Hard", "Insane"};
    font = SERIFG24;

    SDL_EventState(SDL_KEYDOWN, SDL_IGNORE);
    SDL_EventState(SDL_MOUSEBUTTONDOWN, SDL_IGNORE);
    update_highscores();
    start_new = 0;
    if (game.fading_effect)
        fade_screen(FADE_OUT, 500, SDL_MapRGB(game.screen->format, 0, 0, 0));
    else {
        for (x = 0; x  <20; x++) {
            for (y = 0; y < 600; y += 20)
                fill(0, y + x, 800, 1, 0, 0, 0);
            for (y = 0; y < 800; y += 20)
                fill(y + x, 0, 1, 600, 0, 0, 0);
            SDL_UpdateRect(game.screen, 0, 0, 0, 0);
            capture_time = SDL_GetTicks();
            while (SDL_GetTicks() - capture_time < 30) {
                SDL_PumpEvents();
            }
        }
    }
    print_word("Game Over", 293, 156, font);
    print_word("Level: ", 293, 180, font);
    print_number(293 + word_width("Level: ", font), 180, font, game.current_level, 3);
    print_word("Score: ", 293, 204, font);
    print_number(293 + word_width("Score: ", font), 204, font, game.score, 5);
    print_word("Skill Level: ", 293, 228, font);
    print_word(skill_levels[game.skill_level], 293 + word_width("Skill Level: ", font), 228, font);
    if (game.gravity)
        print_word("Gravity: On", 293, 252, font);
    else
        print_word("Gravity: Off", 293, 252, font);
    if (game.current_level > 1) {
        print_word("Best Time: ", 293, 276, font);
        print_time(293 + word_width("Best Time: ", font), 276, font, game.best_time);
    }
    print_word("Start a new game? yes/no", -800, 324, SERIFW24);
    setup_yes_no_xy("Start a new game? ", -800, 324, SERIFW24, yes_no);
    if (!game.fading_effect)
        SDL_UpdateRect(game.screen, 0, 0, 0, 0);
    else
        fade_screen(FADE_IN, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
    #ifndef NOAUDIO
    if (game.audio_enabled) Mix_PlayChannel(OPTION_CHOICE, game.sound[OPTION_CHOICE], 0);
    #endif
    SDL_EventState(SDL_KEYDOWN, SDL_ENABLE);
    SDL_EventState(SDL_MOUSEBUTTONDOWN, SDL_ENABLE);
    answer = get_input_for_yes_no(yes_no);
    /* yes */
    if (answer == 1)
        return 1;
    /* no */
    else if (answer == 0) {
        #ifndef NOAUDIO
        if (game.music == NULL && game.audio_enabled) {
            game.menu_music = !game.menu_music;
            if (game.music_enabled) {
                game.music = Mix_LoadMUS(menu_music[game.menu_music]);
                Mix_FadeInMusic(game.music, -1, 1000);
            }
        }
        #endif
        return 0;
    }
    /* SDL_QUIT */
    else
        cleanup_and_exit();
    return 0;
    
}

struct path_info *add_path_to_list(int x, int y, int direction, struct path_info *path) {
    
    /* increase the path dynamic array by one */
    if (game.path_count == 0)
        path = (struct path_info*)malloc(sizeof(struct path_info) * (game.path_count + 1));
    else
        path = (struct path_info*)realloc(path, sizeof(struct path_info) * (game.path_count + 1));
    /* store the relevant information to the path structure */
    path[game.path_count].x = x;
    path[game.path_count].y = y;
    path[game.path_count].direction = direction;
    path[game.path_count].blit_time = 0;
    path[game.path_count].block_num = 0;
    path[game.path_count].blit_done = 0;
    game.path_count++;
    return path;
    
}

struct path_info *change_grid(int x, int y, struct path_info *path, int button) {

    int i, cnt;
    Uint32 current_time;
       
    if (game.grid[x][y].status >= BLOCK_GONE) {
        if (game.highx == 0 || game.skill_level < HARD)
            return path;
        else {
            wrong_move_penalty();
            if (game.audio_enabled)
                #ifndef NOAUDIO
                Mix_PlayChannel(WRONG_MOVE, game.sound[WRONG_MOVE], 0);
                #endif
            unhighlight_block(game.highx, game.highy);
            return path;
        }
    }
    if (game.skill_level == INSANE) {
        if ((button == SDL_BUTTON_LEFT && game.grid[x][y].left_or_right == 1) || (button == SDL_BUTTON_RIGHT && game.grid[x][y].left_or_right == 0)) {
            wrong_move_penalty();
            if (game.audio_enabled)
                #ifndef NOAUDIO
                Mix_PlayChannel(WRONG_MOVE, game.sound[WRONG_MOVE], 0);
                #endif
            if (game.highx != 0)
                unhighlight_block(game.highx, game.highy);
            else {
                game.current_combos_removed = game.current_sets_removed = 0;
                game.last_color_removed = -1;
            }
            return path;
        }
    }
    switch (game.highx) {
        case 0: {
            /* highlight current block */
            game.grid[x][y].status = BLOCK_HIGH;
            game.block_highlight_num = HIGHLIGHT1;
            blit(game.surface[HIGHLIGHT1], 0, 0, 32, 32, (x - 1) * 32 + GRIDSTARTX, (y - 1) * 32 + GRIDSTARTY);
            game.highx = x;
            game.highy = y;
            break;
        }
        default: {
            /* if you choose currently highlighted block, 
               or the colors don't match, unhighlight first block */
            if ((x == game.highx && y == game.highy) || (game.grid[x][y].color != game.grid[game.highx][game.highy].color)) {
                if (game.skill_level > NORMAL && game.grid[x][y].color != game.grid[game.highx][game.highy].color)
                    wrong_move_penalty();
                unhighlight_block(x, y);
            }
            /* if the colors match, see if we can make a legal move */
            else if (game.grid[x][y].color == game.grid[game.highx][game.highy].color) {
                /* as long as the colors match, we can eliminate the blocks in Kids mode */
                if (game.skill_level == KIDS) {
                    update_score_and_bonus();
                    if (SDL_GetTicks() < game.start_timer + game.skipped_time + game.paused_time)
                        game.stop_timer = 0;
                    else
                        game.stop_timer = SDL_GetTicks() - (game.start_timer + game.skipped_time + game.paused_time);
                    game.block_num++;
                    game.erased++;
                    eliminate_blocks(x, y);
                }
                /* blocks are next to each other */
                else if (abs(x - game.highx) == 0 && abs(y - game.highy) == 1) {
                    update_score_and_bonus();
                    if (SDL_GetTicks() < game.start_timer + game.skipped_time + game.paused_time)
                        game.stop_timer = 0;
                    else
                        game.stop_timer = SDL_GetTicks() - (game.start_timer + game.skipped_time + game.paused_time);
                    game.block_num++;
                    game.erased++;
                    eliminate_blocks(x, y);
                }
                else if (abs(x - game.highx) == 1 && abs(y - game.highy) == 0) {
                    update_score_and_bonus();
                    if (SDL_GetTicks() < game.start_timer + game.skipped_time + game.paused_time)
                        game.stop_timer = 0;
                    else
                        game.stop_timer = SDL_GetTicks() - (game.start_timer + game.skipped_time + game.paused_time);
                    game.block_num++;
                    game.erased++;
                    eliminate_blocks(x, y);
                }
                /* if either block is blocked by all sides unhighlight */
                else if (game.grid[x-1][y].status < BLOCK_GONE && game.grid[x+1][y].status < BLOCK_GONE && game.grid[x][y-1].status < BLOCK_GONE && game.grid[x][y+1].status < BLOCK_GONE) {
                    if (game.skill_level > NORMAL)
                        wrong_move_penalty();
                    unhighlight_block(x, y);
                }
                else if (game.grid[game.highx-1][game.highy].status < BLOCK_GONE && game.grid[game.highx+1][game.highy].status < BLOCK_GONE && game.grid[game.highx][game.highy-1].status < BLOCK_GONE && game.grid[game.highx][game.highy+1].status < BLOCK_GONE) {
                    if (game.skill_level > NORMAL)
                        wrong_move_penalty();
                    unhighlight_block(x, y);
                }
                /* begin the process of checking for a legal move */
                else {
                    game.destx = x;
                    game.desty = y;
                    cnt = game.path_count;
                    game.first_block = 0;
                    path = legal_move(game.destx, game.desty, DIR_NONE, DIR_NONE, path);
                    if (cnt != game.path_count) {
                        /* add the last block to the list */
                        path = add_path_to_list(game.destx, game.desty, LINE_NONE, path);
                        /* create the path */
                        path = create_path(path, cnt);
                        /* update the list with the correct times for erasing
                           the blocks as well as the block number */
                        current_time = SDL_GetTicks();
                        for (i = cnt + 1; i < game.path_count-1; i++) {
                            path[i].blit_time = current_time;
                            path[i].block_num = game.block_num;
                            if (!game.gravity)
                                current_time = current_time + 40;
                        }
                        if (game.gravity)
                            path[cnt].blit_time = current_time + 70;
                        else
                            path[cnt].blit_time = current_time + 20;
                        path[cnt].block_num = game.block_num;
                        path[game.path_count-1].blit_time = path[cnt].blit_time;
                        path[game.path_count-1].block_num = path[cnt].block_num;
                    }
                    else {
                        if (game.skill_level > NORMAL)
                            wrong_move_penalty();
                        unhighlight_block(x, y);
                    }
                }
            }
        }
    }
    return path;
    
}

void wrong_move_penalty() {
    
    int x, y, x2, y2, newx, newx2, savex, savey, savex2, savey2, savecolor;
    int replacecolor, i;
    
    game.no_wrong_moves = 0;
    game.score--;
    /* penalize the time for making a mistake */
    game.start_timer -= game.level_time;
    game.skipped_time += game.level_time;
    /* put 2 blocks eliminated back on the screen */
    if (game.erased > 0) {
        /* only randomize blocks removed if more than one set gone */
        if (game.erased > 1) {
            for (x = 0; x < game.erased; x++) {
                newx = rnd(game.erased) - 1;
                newx2 = rnd(game.erased) - 1;
                savex = game.eliminated[x].x;
                savey = game.eliminated[x].y;
                savex2 = game.eliminated[x].x2;
                savey2 = game.eliminated[x].y2;
                game.eliminated[x].x = game.eliminated[newx].x;
                game.eliminated[x].y = game.eliminated[newx].y;
                game.eliminated[x].x2 = game.eliminated[newx2].x2;
                game.eliminated[x].y2 = game.eliminated[newx2].y2;
                game.eliminated[newx].x = savex;
                game.eliminated[newx].y = savey;
                game.eliminated[newx2].x2 = savex2;
                game.eliminated[newx2].y2 = savey2;
            }
        }
        x = game.eliminated[game.erased - 1].x;
        y = game.eliminated[game.erased - 1].y;
        x2 = game.eliminated[game.erased - 1].x2;
        y2 = game.eliminated[game.erased - 1].y2;
        /* change the color of the x2,y2 to match x,y */
        savecolor = -1;
        if (game.grid[x][y].color != game.grid[x2][y2].color) {
            savecolor = game.grid[x2][y2].color;
            replacecolor = game.grid[x][y].color;
            game.grid[x2][y2].color = game.grid[x][y].color;
        }
        if (savecolor >= 0) {
            /* since we changed the color of the previous x2,y2 to match 
               the previous x,y color; we will change another x2,y2 color
               to the savecolor */
            i = 0;
            while (i < game.erased) {
                if (game.grid[game.eliminated[i].x2][game.eliminated[i].y2].color == replacecolor) {
                    game.grid[game.eliminated[i].x2][game.eliminated[i].y2].color = savecolor;
                    break;
                }
                else
                    i++;
            }
        }
        add_gravity_effect_for_blocks_put_back(x, &y, x2, &y2);
        /* put the two blocks back on the screen */
        game.grid[x][y].status = BLOCK_NORM;
        game.grid[x2][y2].status = BLOCK_NORM;
        put_block_back_on_screen(x, y);
        put_block_back_on_screen(x2, y2);
        draw_blocks();
        game.erased--;
        game.block_num--;
    }
    /* no blocks have been eliminated, penalize score & time some more! */
    else {
        game.start_timer -= (game.level_time * 2);
        game.skipped_time += (game.level_time * 2);
        game.score -= 2;
    }
    
}

void cleanup_and_exit() {
    
    int x;
    
    if (game.fading_effect)
        fade_screen(FADE_OUT, 200, SDL_MapRGB(game.screen->format, 0, 0, 0));
    for (x = 0; x < NUM_SURFACES; x++)
        SDL_FreeSurface(game.surface[x]);
    for (x = 0; x < NUM_FONTS; x++)
        SDL_FreeSurface(game.font[x].name);
    free(game.score_file);
    write_options_file();
    free(game.options_file);
    exit(0);
    
}

void read_options_file() {
    
    FILE *optionsfile;
    int x, pos, corrupt_file;
    int num_chars[NUM_OPTS] = {20, 1, 1, 1, 1, 1, 3, 3, 1, 1, 10};
    int lower[NUM_OPTS] = {31, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47};
    int upper[NUM_OPTS] = {127, 54, 54, 50, 50, 50, 58, 58, 50, 50, 50};
    char chr, strng[21];
    
    /* We will read the file one character at a time to ensure each one is
       within range. Each field will be separated with a tab character. */

    /* create the initial options in case there is no
       options.dat/.twind.opts or they are corrupt */
    game.remember_options = 0;
    game.player_name[0] = '\0';
    game.skill_level = NORMAL;
    game.block_set = BRUSHED_METAL;
    game.corner_style = SQUARE;
    game.pause_mode = PAUSE_ONLY;
    game.display_mode = WINDOW;
    game.sound_volume = 128;
    game.music_volume = 100;
    game.fading_effect = 1;
    game.gravity = 0;
    strcpy(game.color_l_and_r, "1111111110");
    
    /* open the file & start reading the options */
    if ((optionsfile = fopen(game.options_file, "r")) == NULL) {
        fprintf(stderr, "Error reading the options file: %s\n", game.options_file);
        game.remember_options = 1;
    }
    else {
        corrupt_file = 0;
        pos = 0;
        /* did we remember the options? */
        chr = fgetc(optionsfile);
        while (!corrupt_file && !feof(optionsfile) && pos < 1 && chr != '\t') {
            /* only accept a 0 or 1 */
            if (chr > 47 && chr < 50) {
                game.remember_options = chr - 48;
                pos++;
            }
            chr = fgetc(optionsfile);
        }
        if (chr == '\t')
            strng[pos] = '\0';
        else
            corrupt_file = 1;
        if (game.remember_options && !corrupt_file) {
            for (x = 0; x < NUM_OPTS; x++) {
                pos = 0;
                chr = fgetc(optionsfile);
                while (!corrupt_file && !feof(optionsfile) && pos < num_chars[x] && chr != '\t') {
                    /* only accept characters/numbers according to the array above */
                    if (chr > lower[x] && chr < upper[x]) {
                        strng[pos] = chr;
                        pos++;
                    }
                    chr = fgetc(optionsfile);
                }
                if (chr == '\t') {
                    strng[pos] = '\0';
                    /* place what we have read from the file into the game structure */
                    switch (x) {
                        case 0:
                            strcpy(game.player_name, strng);
                            break;
                        case 1:
                            game.skill_level = atoi(strng);
                            break;
                        case 2:
                            game.block_set = atoi(strng);
                            change_block_set();
                            break;
                        case 3:
                            game.corner_style = atoi(strng);
                            break;
                        case 4:
                            game.pause_mode = atoi(strng);
                            break;
                        case 5:
                            game.display_mode = atoi(strng);
                            break;
                        case 6:
                            game.sound_volume = atoi(strng);
                            break;
                        case 7:
                            game.music_volume = atoi(strng);
                            break;
                        case 8:
                            game.fading_effect = atoi(strng);
                            break;
                        case 9:
                            game.gravity = atoi(strng);
                            break;
                        case 10:
                            strcpy(game.color_l_and_r, strng);
                            break;
                    }
                }
                else
                    corrupt_file = 1;
            }
            if (corrupt_file)
                /* options.dat corrupted... inform user that some saved options could be lost */
                fprintf(stderr, "Your options file: %s is corrupted\nSome or all saved options may be lost.\n", game.options_file);
        }
        if (corrupt_file) game.remember_options = 1;
        fclose(optionsfile);
    }

}

void write_options_file() {

    FILE *optionsfile;
    int i;
    
    if ((optionsfile = fopen(game.options_file, "w")) == NULL)
        fprintf(stderr, "Error writing the options file: %s\nDo you have write access to this directory?\n", game.options_file);
    else {
        /* remember options */
        fputc(game.remember_options + 48, optionsfile);
        fputc('\t', optionsfile);
        if (game.remember_options) {
            /* player name */
            for (i = 0; i < strlen(game.player_name); i++)
                fputc(game.player_name[i], optionsfile);
            fputc('\t', optionsfile);
            /* skill level */
            fputc(game.skill_level + 48, optionsfile);
            fputc('\t', optionsfile);
            /* block set */
            fputc(game.block_set + 48, optionsfile);
            fputc('\t', optionsfile);
            /* corner style */
            fputc(game.corner_style + 48, optionsfile);
            fputc('\t', optionsfile);
            /* pause mode */
            fputc(game.pause_mode + 48, optionsfile);
            fputc('\t', optionsfile);
            /* display mode */
            fputc(game.display_mode + 48, optionsfile);
            fputc('\t', optionsfile);
            /* sound volume */
            num_to_str(game.sound_volume, 3);
            for (i = 0; i < strlen(game.temp_string); i++)
                fputc(game.temp_string[i], optionsfile);
            free (game.temp_string);
            fputc('\t', optionsfile);
            /* music volume */
            num_to_str(game.music_volume, 3);
            for (i = 0; i < strlen(game.temp_string); i++)
                fputc(game.temp_string[i], optionsfile);
            free (game.temp_string);
            fputc('\t', optionsfile);
            /* fading effect */
            fputc(game.fading_effect + 48, optionsfile);
            fputc('\t', optionsfile);
            /* gravity */
            fputc(game.gravity + 48, optionsfile);
            fputc('\t', optionsfile);
            /* colors for l & r in Insane mode */
            for (i = 0; i < strlen(game.color_l_and_r); i++)
                fputc(game.color_l_and_r[i], optionsfile);
            fputc('\t', optionsfile);
        }
        fclose(optionsfile);
    }

}

struct path_info *create_path(struct path_info *path, int cnt) {
    
    int i;
    int directions[5][5] = {{0, 0, 0, 0, 0},
                            {0, LINE_VER, LINE_LR,  0,        LINE_LL},
                            {0, LINE_UL,  LINE_HOR, LINE_LL,  0},
                            {0, 0,        LINE_UR,  LINE_VER, LINE_UL},
                            {0, LINE_UR,  0,        LINE_LR,  LINE_HOR}};
    
    /* assign a direction for the path based on the array from above */
    for (i = game.path_count - 2; i > cnt; i--)
        path[i].direction = directions[path[i-1].direction][path[i].direction];
    path[cnt].direction = LINE_NONE;
    return path;
    
}

void create_random_grid() {
    
    int x, y, newposx, newposy, savecolor;

    srand((unsigned int)time((time_t*)NULL));

    /* setup a 12x12 grid */
    for (x = 0; x < 12; x++) {
        for (y = 0; y < 12; y++) {
            if (x == 0 || y == 0 || x == 11 || y == 11)
                game.grid[x][y].status = BLOCK_GONE;
            else {
                game.grid[x][y].status = BLOCK_NORM;
                game.grid[x][y].color = ((x - 1) * 10 + (y - 1)) / 10 * 32;
                game.grid[x][y].left_or_right = rnd(2) - 1;
            }
        }
    }
    /* randomize the colors */
    for (x = 0; x < 10; x++) {
        for (y = 0; y < 10; y++) {
            newposx = rnd(10) - 1;
            newposy = rnd(10) - 1;
            savecolor = game.grid[x + 1][y + 1].color;
            game.grid[x + 1][y + 1].color = game.grid[newposx + 1][newposy + 1].color;
            game.grid[newposx + 1][newposy + 1].color = savecolor;
        }
    }
    
}

void randomize_blocks() {
    
    struct existing_blocks existing[100];
    int x, y, newx, savecolor, savel_or_r, num_existing;

    srand((unsigned int)time((time_t*)NULL));

    /* initialize the array */
    for (x = 0; x < 100; x++) {
        existing[x].x = 0;
        existing[x].y = 0;
        existing[x].color = 0;
        existing[x].left_or_right = 0;
    }
    /* find all the blocks not gone from the screen */
    num_existing = 0;
    for (x = 1; x < 11; x++) {
        for (y = 1; y < 11; y++) {
            if (game.grid[x][y].status < BLOCK_GONE) {
                existing[num_existing].x = x;
                existing[num_existing].y = y;
                existing[num_existing].color = game.grid[x][y].color;
                existing[num_existing].left_or_right = game.grid[x][y].left_or_right;
                num_existing++;
            }
        }
    }
    /* randomize the blocks */
    for (x = 0; x < num_existing; x++) {
        newx = rnd(num_existing) - 1;
        savecolor = existing[x].color;
        savel_or_r = existing[x].left_or_right;
        existing[x].color = existing[newx].color;
        existing[newx].color = savecolor;
        existing[x].left_or_right = existing[newx].left_or_right;
        existing[newx].left_or_right = savel_or_r;
    }
    /* update the game.grid with the new data */
    for (x = 0; x < num_existing; x++) {
        game.grid[existing[x].x][existing[x].y].color = existing[x].color;
        game.grid[existing[x].x][existing[x].y].left_or_right = existing[x].left_or_right;
    }
    
}

void randomize_music() {
    
    int x, newx, savex;

    srand((unsigned int)time((time_t*)NULL));

    /* setup music array */
    for (x = 0; x < MUSIC_LOOPS; x++)
        game.music_loop[x] = x + 1;

    /* randomize the music array */
    for (x = 0; x < MUSIC_LOOPS; x++) {
        newx = rnd(MUSIC_LOOPS) - 1;
        savex = game.music_loop[x];
        game.music_loop[x] = game.music_loop[newx];
        game.music_loop[newx] = savex;
    }
    /*printf("Music loop order:");
    for (x = 0; x < MUSIC_LOOPS; x++)
        printf(" %d",game.music_loop[x]);
    printf("\n");*/    
}
  
void draw_blocks() {
    
    int x, y, destx, desty, color_l_and_r;
    
    for (x = 1; x < 11; x++) {
        for (y = 1; y < 11; y++) {
            destx = (x - 1) * 32 + GRIDSTARTX;
            desty = (y - 1) * 32 + GRIDSTARTY;
            if (game.grid[x][y].status == BLOCK_NORM) {
                blit(game.surface[BLOCKS], game.grid[x][y].color, 0, 32, 32, destx, desty);
                if (game.skill_level == INSANE) {
                    color_l_and_r = game.color_l_and_r[game.grid[x][y].color / 32] - 48;
                    blit(game.surface[game.grid[x][y].left_or_right * 2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, destx, desty);
                }
                change_corner_style(destx, desty);
            }
            else if (game.grid[x][y].status == BLOCK_HIGH) {
                blit(game.surface[BLOCKS], game.grid[x][y].color, 0, 32, 32, destx, desty);
                if (game.skill_level == INSANE) {
                    color_l_and_r = game.color_l_and_r[game.grid[x][y].color / 32] - 48;
                    blit(game.surface[game.grid[x][y].left_or_right * 2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, destx, desty);
                }
                change_corner_style(destx, desty);
                blit(game.surface[HIGHLIGHT1], 0, 0, 32, 32, destx, desty);
            }
            else
                fill(destx, desty, 32, 32, 0, 0, 0);
        }
    }

}

void draw_grid_on_screen() {
    
    int srch;
    char *skill_levels[NUM_SKILLS] = {"Kids", "Easy", "Normal", "Hard", "Very Hard", "Insane"};
    
    blank_screen();
    /* draw the background */
    blit(game.surface[BACKGROUND], 0, 0, 406, 406, -800, -600);
     
    /* draw the title */
    blit(game.surface[TITLE_SMALL], 0, 0, game.surface[TITLE_SMALL]->w, game.surface[TITLE_SMALL]->h, -800, 0);
    print_word(game.player_name, -800, 45, SERIFG24);
    print_word("Skill:", GRIDSTARTX - 41, 71, SERIFG24);
    print_word(skill_levels[game.skill_level], GRIDSTARTX - 41 + word_width("Skill: ", SERIFG24), 71, SERIFG24);
    print_word("Gravity:", GRIDSTARTX + 361 - word_width("Gravity: Off", SERIFG24), 71, SERIFG24);
    if (game.gravity)
        print_word("On", GRIDSTARTX + 361 - word_width("On", SERIFG24), 71, SERIFG24);
    else
        print_word("Off", GRIDSTARTX + 361 - word_width("Off", SERIFG24), 71, SERIFG24);
    print_word("Level:", GRIDSTARTX - 41, 505, SERIFG24);
    print_number(GRIDSTARTX - 41 + word_width("Level: ", SERIFG24), 505, SERIFG24, game.current_level, 3);
    print_score_and_bonus();
    print_word("New Game", 5, 5, SERIFG24);
    if (game.paused)
        print_word("Unpause", 5 + word_width("New Game  ", SERIFG24), 5, SERIFG24);
    else {
        fill(5 + word_width("New Game  ", SERIFG24), 5, word_width("Unpause", SERIFG24), game.font[SERIFG24].height, 0, 0, 0);
        print_word("Pause", 5 + word_width("New Game  ", SERIFG24), 5, SERIFG24);
    }
    print_word("Help", 795 - word_width("Help  Exit", SERIFG24), 5, SERIFG24);
    print_word("Exit", 795 - word_width("Exit", SERIFG24), 5, SERIFG24);

    /* draw the blocks or display a 'Game Paused' message */
    if (!game.paused)
        draw_blocks();
    else
        print_word("Game Paused", -800, -600, SERIFW24);
    
    /* draw the timer */
    blit(game.surface[TIMER_FULL], 0, 0, 160, 32, GRIDSTARTX + 80, 545);
    if (game.level_start == 1) {
        if (!game.paused)
            srch = (SDL_GetTicks() - (game.start_timer + game.paused_time)) / game.level_time + 2;
        else
            srch = (game.temp_time - (game.start_timer + game.paused_time)) / game.level_time + 2;
        blit(game.surface[TIMER_EMPTY], 160 - srch, 0, srch, 32, GRIDSTARTX + 80 + 160 - srch, 545);
    }
    
    /* draw the volume meters */
    if (game.audio_enabled) {
        print_word("Sound:", GRIDSTARTX + 80 - (138 + word_width("Sound: ", SERIFG24)), 548, SERIFG24);
        blit(game.surface[VOLUME_BAR], 0, 0, 133, 32, GRIDSTARTX + 80 - 138, 545);
        blit(game.surface[VOLUME_SLIDER], 0, 0, 5, 32, game.sound_volume + GRIDSTARTX + 80 - 138, 545);
        if (game.music_enabled) {
            print_word("Music:", GRIDSTARTX + 80 + 165, 548, SERIFG24);
            blit(game.surface[VOLUME_BAR], 0, 0, 133, 32, GRIDSTARTX + 80 + 165 + word_width("Music: ", SERIFG24), 545);
            blit(game.surface[VOLUME_SLIDER], 0, 0, 5, 32, game.music_volume + GRIDSTARTX + 80 + 165 + word_width("Music: ", SERIFG24), 545);
        }
    }

}

void eliminate_blocks(int x, int y) {
    
    /* change the status of the blocks */
    game.grid[x][y].status = BLOCK_GONE;
    game.grid[game.highx][game.highy].status = BLOCK_GONE;
    /* erase them from the screen */
    fill((x - 1) * 32 + GRIDSTARTX, (y - 1) * 32 + GRIDSTARTY, 32, 32, 0, 0, 0);
    fill((game.highx - 1) * 32 + GRIDSTARTX, (game.highy - 1) * 32 + GRIDSTARTY, 32, 32, 0, 0, 0);
    add_gravity_effect(x, &y, game.highx, &game.highy);
    /* in case the player makes a wrong move, keep track of the blocks */
    keep_track_of_removed_blocks(x, y, game.highx, game.highy);
    #ifndef NOAUDIO
    if (game.audio_enabled) Mix_PlayChannel(ELIMINATE_BLOCKS, game.sound[ELIMINATE_BLOCKS], 0);
    #endif
    game.highx = game.highy = game.turns = 0;

}

void keep_track_of_removed_blocks(int x, int y, int x2, int y2) {

    /* store the removed blocks for the Hard, Very Hard & Insane game mode */
    if (game.skill_level >= HARD) {
        game.eliminated[game.erased - 1].x = x;
        game.eliminated[game.erased - 1].y = y;
        game.eliminated[game.erased - 1].x2 = x2;
        game.eliminated[game.erased - 1].y2 = y2;
    }
    
}

struct path_info *erase_path(struct path_info *path, int block_num) {
    
    int i, cnt, block, blit_time, x, y, x2, y2, destx, desty, color_l_and_r;

    cnt = block = 0;
    for (i = 0; i < game.path_count; i++) {
        /* only eliminate the blocks & path we are requesting */
        if (path[i].block_num == block_num) {
            /* used for the wrong move penalty & gravity */
            if (game.skill_level >= HARD || game.gravity) {
                /* 1st block, keep track of it & capture blit_time */
                if (!block) {
                    blit_time = path[i].blit_time;
                    block = 1;
                    x = path[i].x;
                    y = path[i].y;
                }
                /* 2nd block, keep track of it & the 1st block from above */
                else if (blit_time == path[i].blit_time) {
                    x2 = path[i].x;
                    y2 = path[i].y;
                    add_gravity_effect(x, &y, x2, &y2);
                    keep_track_of_removed_blocks(x, y, x2, y2);
                }
            }
            destx = (path[i].x - 1) * 32 + GRIDSTARTX;
            desty = (path[i].y - 1) * 32 + GRIDSTARTY;
            /* erase the path (unless the block was put back on because of 
               a wrong move in the Very Hard or Insane mode) */
            if (game.grid[path[i].x][path[i].y].status == BLOCK_NORM) {
                blit(game.surface[BLOCKS], game.grid[path[i].x][path[i].y].color, 0, 32, 32, destx, desty);
                if (game.skill_level == INSANE) {
                    color_l_and_r = game.color_l_and_r[game.grid[path[i].x][path[i].y].color / 32] - 48;
                    blit(game.surface[game.grid[path[i].x][path[i].y].left_or_right * 2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, destx, desty);
                }
                change_corner_style(destx, desty);
            }
            else {
                if (game.grid[path[i].x][path[i].y].status == BLOCK_GOING)
                    game.grid[path[i].x][path[i].y].status = BLOCK_GONE;
                fill(destx, desty, 32, 32, 0, 0, 0);
            }
            /* count the block being erased */
            cnt++;
            /* once the block is erased, update path structure to indicate it */
            path[i].x = -1;
            #ifndef NOAUDIO
            if (game.audio_enabled) Mix_PlayChannel(ELIMINATE_BLOCKS, game.sound[ELIMINATE_BLOCKS], 0);
            #endif
        }
        /* count the block that has already been erased */
        else if (path[i].x == -1)
            cnt++;
    }
    /* deallocate list if all block have been erased */
    if (cnt == game.path_count) {
        free(path);
        game.path_count = 0;
    }
    return path;
    
}

void add_gravity_effect(int x, int *y, int x2, int *y2) {

    struct block temp;
    int i, cnt, switched, tempx, tempy;
    
    if (game.gravity) {
        if (x == x2 && *y > *y2)
            switched = 1;
        else
            switched = 0;
        cnt = 0;
        while (cnt < 2) {
            if ((cnt == 0 && !switched) || (cnt == 1 && switched)) {
                tempx = x;
                tempy = *y;
            }
            else {
                tempx = x2;
                tempy = *y2;
            }
            /* move all blocks above the highlighted block down */
            temp.color = game.grid[tempx][tempy].color;
            temp.left_or_right = game.grid[tempx][tempy].left_or_right;
            temp.status = game.grid[tempx][tempy].status;
            i = tempy;
            while (i > 1) {
                /* stop moving blocks if the one above is empty */
                if (game.grid[tempx][i-1].status > BLOCK_HIGH)
                    break; 
                game.grid[tempx][i].color = game.grid[tempx][i-1].color;
                game.grid[tempx][i].left_or_right = game.grid[tempx][i-1].left_or_right;
                game.grid[tempx][i].status = game.grid[tempx][i-1].status;
                i--;
            }
            if ((cnt == 0 && !switched) || (cnt == 1 && switched))
                *y = i;
            else
                *y2 = i;
            game.grid[tempx][i].color = temp.color;
            game.grid[tempx][i].left_or_right = temp.left_or_right;
            game.grid[tempx][i].status = temp.status;
            cnt++;
        }
        draw_grid_on_screen();
    }

}

void add_gravity_effect_for_blocks_put_back(int x, int *y, int x2, int *y2) {

    struct block temp;
    int i, j, cnt, switched, tempx, tempy;
    
    if (game.gravity && game.erased > 1) {
        if (x == x2 && *y < *y2)
            switched = 1;
        else
            switched = 0;
        cnt = 0;
        while (cnt < 2) {
            if ((cnt == 0 && !switched) || (cnt == 1 && switched)) {
                tempx = x;
                tempy = *y;
            }
            else {
                tempx = x2;
                tempy = *y2;
            }
            /* move all blocks above the highlighted block down */
            temp.color = game.grid[tempx][tempy].color;
            temp.left_or_right = game.grid[tempx][tempy].left_or_right;
            temp.status = game.grid[tempx][tempy].status;
            i = tempy + 1;
            while (i < 11) {
                /* find the next non-empty block */
                if (game.grid[tempx][i].status < BLOCK_GONE)
                    break;
                i++;
            }
            /* we want the previous block, since the loop above found a block
               on screen */
            i--;
            /* switch it all around */
            game.grid[tempx][tempy].color = game.grid[tempx][i].color;
            game.grid[tempx][tempy].left_or_right = game.grid[tempx][i].left_or_right;
            game.grid[tempx][tempy].status = game.grid[tempx][i].status;
            game.grid[tempx][i].color = temp.color;
            game.grid[tempx][i].left_or_right = temp.left_or_right;
            game.grid[tempx][i].status = temp.status;
            /* we need to update the game.eliminated array as well */
            for (j = 0; j < game.erased - 1; j++) {
                if ((game.eliminated[j].x == tempx && game.eliminated[j].y == i) || (game.eliminated[j].x2 == tempx && game.eliminated[j].y2 == i)) {
                    if (game.eliminated[j].x == tempx && game.eliminated[j].y == i)
                        game.eliminated[j].y = tempy;
                    else
                        game.eliminated[j].y2 = tempy;
                    j = game.erased;
                }
            }
            /* update what block we really want to put back on the screen */
            if ((cnt == 0 && !switched) || (cnt == 1 && switched))
                *y = i;
            else
                *y2 = i;
            game.grid[tempx][i].status = BLOCK_NORM;
            cnt++;
        }
        draw_grid_on_screen();
    }

}
void initialize_and_load() {

    int initvideo, i, j, pos, lastpos, x, loaded;
    SDL_Surface *icon;
    Uint8 r, g, b;
    #ifndef NOAUDIO
    int initaudio;
    int audio_rate = 22050;
    Uint16 audio_format = AUDIO_S16; 
    int audio_channels = 2;
    int audio_buffers = 1024;
    #endif
    #ifdef LINUX
    char *home;
    #endif
    char *image[NUM_SURFACES] = {DATA_PREFIX "graphics/background" EXTENSION,
                               DATA_PREFIX "graphics/brushed_metal" EXTENSION,
                               DATA_PREFIX "graphics/highlight1" EXTENSION,
                               DATA_PREFIX "graphics/highlight2" EXTENSION,
                               DATA_PREFIX "graphics/highlight3" EXTENSION,
                               DATA_PREFIX "graphics/highlight4" EXTENSION,
                               DATA_PREFIX "graphics/black_l" EXTENSION,
                               DATA_PREFIX "graphics/white_l" EXTENSION,
                               DATA_PREFIX "graphics/black_r" EXTENSION,
                               DATA_PREFIX "graphics/white_r" EXTENSION,
                               DATA_PREFIX "graphics/path_blocks" EXTENSION,
                               DATA_PREFIX "graphics/timer_full" EXTENSION,
                               DATA_PREFIX "graphics/timer_full_white" EXTENSION,
                               DATA_PREFIX "graphics/timer_empty" EXTENSION,
                               DATA_PREFIX "graphics/timer_empty_white" EXTENSION,
                               DATA_PREFIX "graphics/title_small" EXTENSION,
                               DATA_PREFIX "graphics/title_big" EXTENSION,
                               DATA_PREFIX "graphics/volume_bar" EXTENSION,
                               DATA_PREFIX "graphics/volume_slider" EXTENSION};
    char *font[NUM_FONTS] = {DATA_PREFIX "graphics/freeserif_green_20" EXTENSION,
                             DATA_PREFIX "graphics/freeserif_white_20" EXTENSION,
                             DATA_PREFIX "graphics/freeserif_green_24" EXTENSION,
                             DATA_PREFIX "graphics/freeserif_white_24" EXTENSION};
    #ifndef NOAUDIO
    char *wav[NUM_SOUNDS] = {DATA_PREFIX "sound/menu_option.wav",
                             DATA_PREFIX "sound/option_choice.wav",
                             DATA_PREFIX "sound/keyboard_click.wav",
                             DATA_PREFIX "sound/eliminate_blocks.wav",
                             DATA_PREFIX "sound/wrong_move.wav",
                             DATA_PREFIX "sound/apply_bonus.wav"};
    #endif

    initvideo = SDL_Init(SDL_INIT_VIDEO);
    if (initvideo) {
        fprintf(stderr, "Unable to initialize SDL: %s\n", SDL_GetError());
        exit(1);
    }
    #ifndef NOAUDIO
    initaudio = SDL_InitSubSystem(SDL_INIT_AUDIO);
    if(Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers) == -1) {
        fprintf(stderr, "Unable to open audio: %s\n", Mix_GetError());
        game.audio_enabled = 0;
    }
    else {
        game.audio_enabled = game.music_enabled = 1;
        /* check to see if ogg music can be played */
        game.music = Mix_LoadMUS(DATA_PREFIX "music/0-0.ogg");
        if (game.music == NULL) {
            fprintf(stderr, "Unable to load %s\n", DATA_PREFIX "music/0-0.ogg");
            fprintf(stderr, "%s\n", Mix_GetError());
            /* 1st file failed, try another */
            game.music = Mix_LoadMUS(DATA_PREFIX "music/1-1.ogg");
            if (game.music == NULL) {
                fprintf(stderr, "Unable to load %s\n", DATA_PREFIX "music/1-1.ogg");
                fprintf(stderr, "%s\n", Mix_GetError());
                fprintf(stderr, "\nDisabling music support... it seems that Ogg Vorbis files can't be played.\n");
                fprintf(stderr, "Please install Ogg Vorbis libraries on your system & rebuild your SDL_mixer\n");
                fprintf(stderr, "if you would like to hear the music.\n");
                game.music_enabled = 0;
            }
        }
        if (game.music_enabled)
            Mix_FreeMusic(game.music);
    }
    #else
        game.audio_enabled = 0;
    #endif
    atexit(SDL_Quit);
    #ifndef NOAUDIO
    if (game.audio_enabled) atexit(Mix_CloseAudio);
    #endif
    SDL_EnableUNICODE(1);
    
    game.screen = SDL_SetVideoMode(800, 600, 0, SDL_SWSURFACE);
    if (game.screen == NULL)
        fprintf(stderr, "Unable to set video mode: %s\n", SDL_GetError());
    loaded = 1;
    /* load all the graphics */
    for (x = 0; x < NUM_SURFACES; x++)
        game.surface[x] = load_image(image[x], &loaded);
    /* set certain blocks to have transparency */
    for (x = HIGHLIGHT1; x <= WHITE_R; x++)
        SDL_SetColorKey(game.surface[x], SDL_SRCCOLORKEY, SDL_MapRGB(game.screen->format, 0, 255, 255));
    /* load the sounds */
    #ifndef NOAUDIO
    if (game.audio_enabled) {
        for (x = 0; x < NUM_SOUNDS; x++)
            game.sound[x] = load_wav(wav[x], &loaded);
    }
    #endif
    /* load the fonts */
    for (x = 0; x < NUM_FONTS; x++)
        game.font[x].name = load_image(font[x], &loaded);
    icon = load_image(DATA_PREFIX "graphics/twind" EXTENSION, &loaded);
    /* set the in-game menu options to unhighlighted */
    for (x = 0; x < NUM_IN_GAME_MO; x++)
        game.highlight[x] = 0;
    if (!loaded)
        exit(2);
    
    SDL_WM_SetCaption("Twin Distress", NULL);
    SDL_WM_SetIcon(icon, NULL);
    SDL_FreeSurface(icon);
    /* initialize game variables */
    game.destx = game.desty = game.turns = game.fading_off_temp = 0;
    game.option_toggle = game.new_game_highlighted = 0;
    game.help_highlighted = 0;
    game.blit_done = game.unpause_msg = game.menu_music = 1;
    game.max_turns = 2;
    game.num_groups = NUM_SKILLS * 2;
    /* height is one less than actual... 1st row will be used below */
    for (i = 0; i < NUM_FONTS; i++)
        game.font[i].height = game.font[i].name->h - 1;
    /* 1st row of font file contains the positions of each character */
    for (i = 0; i < NUM_FONTS; i++) {
        lastpos = 0;
        pos = 1;
        game.font[i].pos[0] = 0;
        SDL_LockSurface(game.font[i].name);
        for (j = 0; j < 95; j++) {
            if (j != 0)
                game.font[i].pos[j] = game.font[i].pos[j] = pos - 1;
            /* find the ending position of the character */
            SDL_GetRGB(getpixel(game.font[i].name, pos), game.font[i].name->format, &r, &g, &b);
            while (1) {
                if (r == 0 && g > 0 && b > 0)
                   break;
                else {
                    pos++;
                    SDL_GetRGB(getpixel(game.font[i].name, pos), game.font[i].name->format, &r, &g, &b);
                }
            }
            game.font[i].width[j] = (pos - lastpos) + 1;
            /* find the start of the next character, if we haven't reached the last one */
            if (j != 94) {
                pos++;
                SDL_GetRGB(getpixel(game.font[i].name, pos), game.font[i].name->format, &r, &g, &b);
                while (1) {
                    if (r == 0 && g > 0 && b > 0)
                       break;
                    else {
                        pos++;
                        SDL_GetRGB(getpixel(game.font[i].name, pos), game.font[i].name->format, &r, &g, &b);
                    }
                }
            lastpos = pos;
            pos++;
            }
        }
        SDL_UnlockSurface(game.font[i].name);
    }
    #ifndef LINUX
    game.options_file = (char *)malloc(sizeof(char) * (12));
    #else
    /* get home directory (from $HOME variable), or use the current directory */
    if (getenv("HOME") != NULL)
        home = getenv("HOME");
    else
        home = ".";
    game.options_file = (char *)malloc(strlen(home) + sizeof(char) * (13));
    #endif
    game.options_file[0] = '\0';
    #ifndef LINUX
    strcat(game.options_file, "options.dat");
    #else
    strcat(game.options_file, home);
    strcat(game.options_file, "/.twind.opts");
    #endif
    read_options_file();
    /* set the options from the options.dat file */
    if (game.display_mode == FULLSCREEN) {
        game.screen = SDL_SetVideoMode(800, 600, 0, SDL_FULLSCREEN);
        if (game.screen == NULL) {
            game.screen = SDL_SetVideoMode(800, 600, 0, SDL_SWSURFACE);
            game.display_mode = WINDOW;
        }
    }
    #ifndef NOAUDIO
    if (game.audio_enabled) {
        game.music = NULL;
        game.regular_music = 1;
        if (game.music_enabled)
            Mix_VolumeMusic(game.music_volume);
        Mix_Volume(-1, game.sound_volume);
    }
    #endif
    
}

Uint32 getpixel(SDL_Surface *surface, int x) {
    
    /* this function was taken directly from the SDL documentation */
    
    int bpp = surface->format->BytesPerPixel;
    int y = 0;
    
    /* Here p is the address to the pixel we want to retrieve */
    Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

    switch(bpp) {
        case 1:
            return *p;
        case 2:
            return *(Uint16 *)p;
        case 3:
            if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
                return p[0] << 16 | p[1] << 8 | p[2];
            else
                return p[0] | p[1] << 8 | p[2] << 16;
        case 4:
            return *(Uint32 *)p;
        default:
            return 0;       /* shouldn't happen, but avoids warnings */
    }
    
}

struct path_info *legal_move(int x, int y, int cur_dir, int prev_dir, struct path_info *path) {
    
    int directions[4];
    int i, cnt;
    
    /* we've changed directions */    
    if (cur_dir != prev_dir && prev_dir != DIR_NONE)
        game.turns++;
    
    /* the block has been found */
    if (x == game.highx && y == game.highy) {
        if (SDL_GetTicks() < game.start_timer + game.skipped_time + game.paused_time)
            game.stop_timer = 0;
        else
            game.stop_timer = SDL_GetTicks() - (game.start_timer + game.skipped_time + game.paused_time);
        game.first_block = 1;
        game.block_num++;
        return path;
    }
    
    /* we've hit a block */
    if (cur_dir != DIR_NONE && game.grid[x][y].status < BLOCK_GONE) {
        if (cur_dir != prev_dir && prev_dir != DIR_NONE)
            game.turns--;
        return path;
    }
    
    /* try to find a path to the block... this WILL NOT always be the shortest
       path... maybe I'll implement a better path finding algorithm like A* or
       Dijkstra's one of these days, but this one will get the job done! */
    
    /* the blocks are in the same horizontal line */
    if (y == game.highy) {
        /* block we are seeking is right */
        if (x < game.highx)
            setup_array(DIR_RIGHT, DIR_UP, DIR_DOWN, DIR_LEFT, directions);
        /* block we are seeking is left */
        else
            setup_array(DIR_LEFT, DIR_UP, DIR_DOWN, DIR_RIGHT, directions);
    }
    /* the blocks are in the same vertical line */
    else if (x == game.highx) {
        /* block we are seeking is down */
        if (y < game.highy)
            setup_array(DIR_DOWN, DIR_LEFT, DIR_RIGHT, DIR_UP, directions);
        /* block we are seeking is up */
        else
            setup_array(DIR_UP, DIR_LEFT, DIR_RIGHT, DIR_DOWN, directions);
    }
    /* block we are seeking is to the upper left */
    else if (x > game.highx && y > game.highy) {
        if (abs(x - game.highx) < abs(y - game.highy))
            setup_array(DIR_LEFT, DIR_UP, DIR_RIGHT, DIR_DOWN, directions);
        else
            setup_array(DIR_UP, DIR_LEFT, DIR_DOWN, DIR_RIGHT, directions);
    }
    /* block we are seeking is to the upper right */
    else if (x < game.highx && y > game.highy) {
        if (abs(x - game.highx) < abs(y - game.highy))
            setup_array(DIR_RIGHT, DIR_UP, DIR_LEFT, DIR_DOWN, directions);
        else
            setup_array(DIR_UP, DIR_RIGHT, DIR_DOWN, DIR_LEFT, directions);
    }
    /* block we are seeking is to the lower right */
    else if (x < game.highx && y < game.highy) {
        if (abs(x - game.highx) < abs(y - game.highy))
            setup_array(DIR_RIGHT, DIR_DOWN, DIR_LEFT, DIR_UP, directions);
        else
            setup_array(DIR_DOWN, DIR_RIGHT, DIR_UP, DIR_LEFT, directions);
    }
    /* block we are seeking is to the lower left */
    else if (x > game.highx && y < game.highy) {
        if (abs(x - game.highx) < abs(y - game.highy))
            setup_array(DIR_LEFT, DIR_DOWN, DIR_RIGHT, DIR_UP, directions);
        else
            setup_array(DIR_DOWN, DIR_LEFT, DIR_UP, DIR_RIGHT, directions);
    }

    /* check for legal moves using recursion */
    for (i = 0; i < 4; i++) {
        switch (directions[i]) {
            case 1:
                /* we are going up, we can't go down*/
                if (cur_dir != DIR_DOWN && y != 0)
                    /* we can't change directions once we reach the maximum turns */
                    if (game.turns != game.max_turns || (game.turns == game.max_turns && cur_dir == DIR_UP)) {
                        cnt = game.path_count;
                        path = legal_move(x, y - 1, DIR_UP, cur_dir, path);
                        if (cnt != game.path_count || game.first_block) {
                            path = add_path_to_list(x, y - 1, DIR_DOWN, path);
                            return path;
                        }
                    }
                break;
            case 2:
                /* we are going right, we can't go left */
                if (cur_dir != DIR_LEFT && x != 11)
                    /* we can't change directions once we reach the maximum turns */
                    if (game.turns != game.max_turns || (game.turns == game.max_turns && cur_dir == DIR_RIGHT)) {
                        cnt = game.path_count;
                        path = legal_move(x + 1, y, DIR_RIGHT, cur_dir, path);
                        if (cnt != game.path_count || game.first_block) {
                            path = add_path_to_list(x + 1, y, DIR_LEFT, path);
                            return path;
                        }
                    }
                break;
            case 3:
                /* we are going down, we can't go up */
                if (cur_dir != DIR_UP && y != 11)
                    /* we can't change directions once we reach the maximum turns */
                    if (game.turns != game.max_turns || (game.turns == game.max_turns && cur_dir == DIR_DOWN)) {
                        cnt = game.path_count;
                        path = legal_move(x, y + 1, DIR_DOWN, cur_dir, path);
                        if (cnt != game.path_count || game.first_block) {
                            path = add_path_to_list(x, y + 1, DIR_UP, path);
                            return path;
                        }
                    }
                break;
            case 4:
                /* we are going left, we can't go right */
                if (cur_dir != DIR_RIGHT && x != 0)
                    /* we can't change directions once we reach the maximum turns */
                    if (game.turns != game.max_turns || (game.turns == game.max_turns && cur_dir == DIR_LEFT)) {
                        cnt = game.path_count;
                        path = legal_move(x - 1, y, DIR_LEFT, cur_dir, path);
                        if (cnt != game.path_count || game.first_block) {
                            path = add_path_to_list(x - 1, y, DIR_RIGHT, path);
                            return path;
                        }
                    }
                break;
        }
    }
    if (cur_dir != prev_dir && prev_dir != DIR_NONE)
        game.turns--;
    return path;
    
}

SDL_Surface *load_image(char *filename, int *loaded) {
    
    SDL_Surface *temp, *surface;
    
    temp = IMG_Load(filename);
    if (temp == NULL) {
        fprintf(stderr, "Unable to load %s\n", filename);
        fprintf(stderr, "%s\n", SDL_GetError());
        surface = NULL;
        *loaded = 0;
    }
    else {
        surface = SDL_DisplayFormat(temp);
        SDL_FreeSurface(temp);
        if (surface == NULL) {
            fprintf(stderr, "Unable to load %s\n", filename);
            fprintf(stderr, "%s\n", SDL_GetError());
            *loaded = 0;
        }
    }
    return surface;

}

#ifndef NOAUDIO
Mix_Chunk *load_wav(char *filename, int *loaded) {
    
    Mix_Chunk *sound;
    
    sound = Mix_LoadWAV(filename);
    if (sound == NULL) {
        fprintf(stderr, "Unable to load %s\n", filename);
        fprintf(stderr, "%s\n", Mix_GetError());
        sound = NULL;
        *loaded = 0;
    }
    return sound;

}
#endif

void pause_game(char *message) {

    game.temp_time = SDL_GetTicks();
    game.paused = 1;
    /* hide all the blocks and update the screen */
    fill(GRIDSTARTX, GRIDSTARTY, 320, 320, 0, 0, 0);
    print_word(message, -800, -600, SERIFW24);
    if (game.unpause_msg)
        print_word("Unpause", 5 + word_width("New Game  ", SERIFG24), 5, SERIFG24);
    SDL_UpdateRect(game.screen, 0, 0, 0, 0);
    #ifndef NOAUDIO
    if (game.audio_enabled)
        if (game.music_enabled)
            Mix_PauseMusic();
    #endif
    
}

void print_char(int character, int destx, int desty, int font) {
    
    blit(game.font[font].name, game.font[font].pos[character - 32], 1, game.font[font].width[character - 32], game.font[font].height, destx, desty);
    
}

void num_to_str(int num, int max_length) {
    
    int i;
    game.temp_string = (char *)malloc(sizeof(char) * (max_length + 1));
    
    if (pow(10, max_length) <= num)
        strcpy(game.temp_string,"-");
    i = sprintf(game.temp_string, "%d", num);
       
}

void print_number(int destx, int desty, int font, int number, int len) {
    
    num_to_str(number, len);
    print_word(game.temp_string, destx, desty, font);
    free (game.temp_string);
    
}

void print_time(int destx, int desty, int font, int number) {

    int i, pos, chr;
    
    pos = 0;
    num_to_str(number, 6);
    for (i = 0; i < strlen(game.temp_string); i++) {
        if (i == 2 && strlen(game.temp_string) == 5) {
            print_char('.', destx + pos, desty, font);
            pos += game.font[font].width['.' - 32];
        }
        else if (i == 3 && strlen(game.temp_string) == 6) {
            print_char('.', destx + pos, desty, font);
            pos += game.font[font].width['.' - 32];
        }
        print_char(game.temp_string[i], destx + pos, desty, font);
        chr = game.temp_string[i];
        pos += game.font[font].width[chr - 32];
    }
    free (game.temp_string);
    
}

void print_word(char *word, int destx, int desty, int font) {
    
    int i, pos, chr, newdestx, newdesty;
    
    pos = 0;
    /* if destx or desty is negative, center word according to the co-ordinates */
    if (destx < 0)
        newdestx = (abs(destx) - word_width(word, font)) / 2;
    else
        newdestx = destx;
    if (desty < 0)
        newdesty = (abs(desty) - game.font[font].height) / 2;
    else
        newdesty = desty;
    for (i = 0; i < strlen(word); i++) {
        print_char(word[i], newdestx + pos, newdesty, font);
        chr = word[i];
        pos += game.font[font].width[chr - 32];
    }
    
}

int rnd(float max) {
    
    /* returns a random number between 1 and max */
    return 1 + (int) (max * rand() / (RAND_MAX + 1.0));
    
}

void setup_array(int dir1, int dir2, int dir3, int dir4, int directions[]) {
    
    directions[0] = dir1;
    directions[1] = dir2;
    directions[2] = dir3;
    directions[3] = dir4;
    
}

int show_path(struct path_info *path) {
    
    int i;
    
    for (i = 0; i < game.path_count; i++) {
        if (SDL_GetTicks() > path[i].blit_time && path[i].x != -1) {
            if (path[i].direction != LINE_NONE) {
                if (!path[i].blit_done) {
                    blit(game.surface[PATH_BLOCKS], path[i].direction * 32, 0, 32, 32, (path[i].x - 1) * 32 + GRIDSTARTX, (path[i].y - 1) * 32 + GRIDSTARTY);
                    path[i].blit_done = 1;
                }
            }
            else
                return path[i].block_num;
        }
    }
    return 51;
        
}

void unhighlight_block(int x, int y) {

    int destx, desty, color_l_and_r;
    
    destx = (game.highx - 1) * 32 + GRIDSTARTX;
    desty = (game.highy - 1) * 32 + GRIDSTARTY;
    game.grid[game.highx][game.highy].status = BLOCK_NORM;
    blit(game.surface[BLOCKS], game.grid[game.highx][game.highy].color, 0, 32, 32, destx, desty);
    if (game.skill_level == INSANE) {
        color_l_and_r = game.color_l_and_r[game.grid[game.highx][game.highy].color / 32] - 48;
        blit(game.surface[game.grid[game.highx][game.highy].left_or_right * 2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, destx, desty);
    }
    change_corner_style(destx, desty);
    if ((x != game.highx) || (y != game.highy)) {
        game.current_combos_removed = game.current_sets_removed = 0;
        game.no_wrong_moves = 0;
        game.last_color_removed = -1;
        #ifndef NOAUDIO
        if (game.audio_enabled) Mix_PlayChannel(WRONG_MOVE, game.sound[WRONG_MOVE], 0);
        #endif
    }
    game.highx = game.highy = game.turns = 0;
    
}

void put_block_back_on_screen(int x, int y) {

    int destx, desty, color_l_and_r;
    
    destx = (x - 1) * 32 + GRIDSTARTX;
    desty = (y - 1) * 32 + GRIDSTARTY;
    game.grid[x][y].status = BLOCK_NORM;
    blit(game.surface[BLOCKS], game.grid[x][y].color, 0, 32, 32, destx, desty);
    if (game.skill_level == INSANE) {
        color_l_and_r = game.color_l_and_r[game.grid[x][y].color / 32] - 48;
        blit(game.surface[game.grid[x][y].left_or_right * 2 + BLACK_L + color_l_and_r], 0, 0, 32, 32, destx, desty);
    }
    change_corner_style(destx, desty);
    
}

void unpause_game() {

    game.paused_time = game.paused_time + SDL_GetTicks() - game.temp_time;
    game.paused = 0;
    draw_blocks();
    fill(5 + word_width("New Game  ", SERIFG24), 5, word_width("Unpause", SERIFG24), game.font[SERIFG24].height, 0, 0, 0);
    print_word("Pause", 5 + word_width("New Game  ", SERIFG24), 5, SERIFG24);
    SDL_UpdateRect(game.screen, 0, 0, 0, 0);
    #ifndef NOAUDIO
    if (game.audio_enabled)
        if (game.music_enabled)
            Mix_ResumeMusic();
    #endif

}

void change_corner_style(int x, int y) {
    
    if (game.corner_style == ROUNDED) {
        /* upper left corner */
        fill(x + 1, y + 1, 2, 1, 0, 0, 0);
        fill(x + 1, y + 2, 1, 1, 0, 0, 0);
        /* upper right corner */
        fill(x + 29, y + 1, 2, 1, 0, 0, 0);
        fill(x + 30, y + 2, 1, 1, 0, 0, 0);
        /* lower left corner */
        fill(x + 1, y + 29, 1, 1, 0, 0, 0);
        fill(x + 1, y + 30, 2, 1, 0, 0, 0);
        /* lower right corner */
        fill(x + 30, y + 29, 1, 1, 0, 0, 0);
        fill(x + 29, y + 30, 2, 1, 0, 0, 0);
    }
    
}

void fade_screen(int fade_type, int time, Uint32 color) {
	
    SDL_Surface *screen_copy, *black_surface;
	Uint32 cur_tick, started_fading;
	
	/* Copy the screen */
	screen_copy = SDL_DisplayFormatAlpha(game.screen);
	/* Make the color surface */
	black_surface = SDL_CreateRGBSurface(game.screen->flags, game.screen->w, game.screen->h, game.screen->format->BitsPerPixel,	game.screen->format->Rmask,	game.screen->format->Gmask,	game.screen->format->Bmask,	game.screen->format->Amask);
	if (fade_type == FADE_IN)
		SDL_SetAlpha(black_surface, SDL_SRCALPHA | SDL_RLEACCEL, 255);
	else
		SDL_SetAlpha(black_surface, SDL_SRCALPHA | SDL_RLEACCEL, 0);
	SDL_FillRect(black_surface, NULL, color);
	/* Now fade in / out */
	for (started_fading = cur_tick = SDL_GetTicks(); cur_tick-started_fading <= (Uint32)time; cur_tick = SDL_GetTicks()) {
		SDL_BlitSurface(screen_copy, NULL, game.screen, NULL);
		SDL_BlitSurface(black_surface, NULL, game.screen, NULL);
		SDL_UpdateRect(game.screen, 0, 0, 0, 0);
		if (fade_type == FADE_IN)
			SDL_SetAlpha(black_surface,	SDL_SRCALPHA | SDL_RLEACCEL, 255 - ((cur_tick - started_fading) * 255) / time);
		else
			SDL_SetAlpha(black_surface,	SDL_SRCALPHA | SDL_RLEACCEL, ((cur_tick - started_fading) * 255) / time);
		SDL_Delay(10);
        SDL_PumpEvents();
	}
	/* Set it to the desired final state */
	if (fade_type == FADE_IN)
		SDL_SetAlpha(black_surface, SDL_SRCALPHA | SDL_RLEACCEL, 0);
	else
		SDL_SetAlpha(black_surface, SDL_SRCALPHA | SDL_RLEACCEL, 255);
	SDL_BlitSurface(screen_copy, NULL, game.screen, NULL);
	SDL_BlitSurface(black_surface, NULL, game.screen, NULL);
	SDL_UpdateRect(game.screen, 0, 0, 0, 0);
	SDL_FreeSurface(screen_copy);
	SDL_FreeSurface(black_surface);
    
}
