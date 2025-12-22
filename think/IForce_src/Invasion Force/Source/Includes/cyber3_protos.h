/* Prototypes for functions defined in
cyber3.c
 */

extern short Destx;

extern short Desty;

extern short Type;

extern int FirstPath;

extern long Bounds;

extern int Breakout;

void AI3_set_gov_prod(struct City * , struct GovNode * );

void AI3_get_gov_req(struct GovNode * , struct City * );

int AI3_calc_path(short , short , short , short , short , int , int );

long sub_calc_move(short , short , long );

struct GovNode * AI3_locate_gov(struct City * );

struct GovNode * AI3_add_gov(struct City * );

void AI3_setup_area_of_interest(struct GovNode * , int , int );

void AI3_play_turn(int );

void AI3_do_all_histograms(void);

void AI3_set_gov_mode(struct GovNode * );

void AI3_give_orders(void);

void AI3_orders_for_unit(struct Unit * );

void AI3_taken_orders(struct Unit * , struct GovNode * );

void AI3_defend_orders(struct Unit * , struct GovNode * );

void AI3_search_orders(struct Unit * , struct GovNode * );

void AI3_default_orders(struct Unit * , struct GovNode * );

struct MapIcon * AI3_FindClosestEnemyCity(struct Unit * , int );

struct GovNode * AI3_FindClosestCityGov(struct Unit * , int );

int AI3_do_unit_actions(void);

void AI3_computer_give_orders(struct Unit * , int , short , short , short , short , int );

void AI3_select_recon_hex(struct Unit * , struct GovNode * );

int AI3_look_around(struct Unit * );

void AI3_execute_standing_order(struct Unit * );

void AI3_command_random(struct Unit * );

int AI3_command_recon(struct Unit * );

int AI3_AssertUnit(struct Unit * );

void AI3_Add_Lib(struct Unit * );

