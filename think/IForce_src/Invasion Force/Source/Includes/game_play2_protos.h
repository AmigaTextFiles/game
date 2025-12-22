/* Prototypes for functions defined in
game_play2.c
 */

void survey_mode(struct Unit ** );

void production_mode(void);

void survey_hex(int , int );

struct Unit * choose_default_unit(struct Unit * );

int unit_readiness(struct Unit * );

void order_manager(struct Unit * );

void build_airbase(struct Unit * unit);

void mode_manager(void);

int unit_speed(struct Unit * );

void create_player_display(int , int );

void weed_combat_report(void);

BOOL save_game(char * );

BOOL load_game(char * );

void build_pan(char * , char * , char * );

BOOL rt_loadsave_game(int );

void execute_game_turns(void);

BOOL game_overP(void);

BOOL human_still_in_game(void);

BOOL player_still_in_game(void);

void cleanup_game(void);

void play_game(void);

void restore_game(void);

void ToggleAIDataFlag(void);

