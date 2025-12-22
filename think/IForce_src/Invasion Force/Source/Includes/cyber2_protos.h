/* Prototypes for functions defined in
cyber2.c
 */

void AI2_set_gov_prod(struct City * , struct GovNode * );

void AI2_get_gov_req(struct GovNode * , struct City * );

int AI2_calc_distance(short , short , short , short );

void AI2_play_turn(int );

struct GovNode * AI2_locate_gov(struct City * );

void AI2_setup_area_of_interest(struct GovNode * );

void AI2_do_all_histograms(void);

void AI2_set_gov_mode(struct GovNode * );

void AI2_give_orders(void);

struct MapIcon * AI2_FindClosestEnemyUnit(short , short , int );

int AI2_do_unit_actions(void);

void AI2_computer_give_orders(struct Unit * , int , short , short , short , short , int );

int AI2_look_around(struct Unit * );

void AI2_execute_standing_order(struct Unit * );

int AI2_command_hunt(struct Unit * );

