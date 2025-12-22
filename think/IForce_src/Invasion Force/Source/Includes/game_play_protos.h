/* Prototypes for functions defined in
game_play.c
 */

extern int control_flag;

extern char game_filepath[108];

extern char game_filename[108];

extern struct Menu * move_menu_strip;

extern struct Menu * vey_menu_strip;

extern struct Menu * prod_menu_strip;

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

void set_display_offsets(int col,
                         int row);

int count_units_at(int col,
                   int row);

void add_city_to_player_map(int player,
                            struct City * metro);

void add_icon_to_player_map(int player,
                            struct Unit * unit);

BOOL seenby_subP(int player,
                 struct Unit * targ);

BOOL sub_seenP(int player,
               struct Unit * sub);

void recon(struct City * metro);

void explore_hex(int player,
                 int col,
                 int row,
                 int visible,
                 int forced);

void explore_at_hex(int player,
                    int col,
                    int row,
                    int visible,
                    int forced);

void conquer_city(struct City * taken_city);

int hex_owner(int col,
              int row);

struct Unit * choose_defender(struct Unit * attacker,
                              int targx,
                              int targy);

int attack_hex(struct Unit * attacker,
                int targx,
                int targy);

void jumpstart_player(void);
void create_initial_city(void);

void unit_name_request(struct City * metro,
                       struct Unit * unit);

int do_cities_production(void);

void unit_status_bar(struct Unit * unit);

void hex_status_bar(int col,
                    int row);

BOOL board_ship(struct Unit * cargo,
                int col,
                int row);

int cargo_capacity(struct Unit * ship);

void load_ship(struct Unit * ship);

void move_unit_dir(struct Unit * unit,
                   enum Direction dir);

void move_unit_xy(struct Unit * unit,
                  int targx,
                  int targy);

int speed_of(struct Unit * unit);

void build_move_menu(void);

void build_survey_menu(void);

void build_production_menu(void);

void give_orders(struct Unit * unit,
                 int token,
                 int destx,
                 int desty,
                 int etc);

struct Unit * shuffle_units(struct Unit * topunit,
                            BOOL survey);

void start_blinking_unit(struct Unit * unit);

void movement_mode(struct Unit ** current_unit);

void plot_cursor(int x,
                 int y);

void move_cursor_dir(int dir);

void survey_mode(struct Unit ** current_unit);

void production_mode(void);

void survey_hex(int col,
                int row);

struct Unit * choose_default_unit(struct Unit * exclude);

int unit_readiness(struct Unit * unit);

void order_manager(struct Unit * unit);

void mode_manager(void);

int unit_speed(struct Unit * unit);

void create_player_display(int col,
                           int row);

void weed_combat_report(void);

BOOL save_game(char * filename);

BOOL load_game(char * filename);

void build_pan(char * string,
               char * path,
               char * file);

BOOL rt_loadsave_game(int save);

void execute_game_turns(void);

void cleanup_game(void);

void play_game(void);

void restore_game(void);

