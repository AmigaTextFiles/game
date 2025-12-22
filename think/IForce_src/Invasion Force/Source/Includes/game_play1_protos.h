/* Prototypes for functions defined in
game_play1.c
 */

extern int control_flag;

extern char game_filepath[108];

extern char game_filename[108];

extern struct Menu * move_menu_strip;

extern struct Menu * vey_menu_strip;

extern struct Menu * prod_menu_strip;

extern int PathCost;

extern struct PLayer roster[9];

extern int player;

extern int turn;

extern BOOL display;

extern int cursx;

extern int cursy;

extern char id_filetag[5];

extern struct MinList unit_list;

extern struct BattleRecord battle;

extern char * prefix;

void set_display_offsets(int , int );

int count_units_at(int , int );

void add_city_to_player_map(int , struct City * );

void add_icon_to_player_map(int , struct Unit * );

BOOL seenby_subP(int , struct Unit * );

BOOL sub_seenP(int , struct Unit * );

void recon(struct City * );

void explore_hex(int , int , int , int , int );

void explore_at_hex(int , int , int , int , int );

void conquer_city(struct City * );

int hex_owner(int , int );

struct Unit * choose_defender(struct Unit * , int , int );

void attack_hex(struct Unit * , int , int );

void NCS_combat_mods(struct Unit * , struct Unit * , int * , int * );

void get_attack_values(short , int , int , short , int , int , int * , int * );

void create_initial_city(void);

void jumpstart_player(void);

void unit_name_request(struct City * , struct Unit * );

int do_cities_production(void);

void unit_status_bar(struct Unit * );

void hex_status_bar(int , int );

BOOL board_ship(struct Unit * , int , int );

int cargo_capacity(struct Unit * );

int cargo_weight(int );

void load_ship(struct Unit * );

void do_goto(struct Unit * );

int move_unit_dir(struct Unit * , enum Direction );

int move_unit_xy(struct Unit * , int , int );

void build_move_menu(void);

void build_survey_menu(void);

void build_production_menu(void);

void give_orders(struct Unit * , int , int , int , int );

struct Unit * shuffle_units(struct Unit * , BOOL );

void start_blinking_unit(struct Unit * );

void movement_mode(struct Unit ** );

void plot_cursor(int , int );

void move_cursor_dir(int );

