/* Prototypes for functions defined in
cyber1.c
 */

struct GovNode * AI1_locate_gov(struct City * );

struct GovNode * AI1_add_gov(struct City * );

void AI1_set_gov_prod(struct City * , struct GovNode * );

void AI1_play_turn(int );

void AI1_setup_area_of_interest(struct GovNode * );

void AI1_do_all_histograms(void);

void AI1_do_one_histogram(struct GovNode * );

void AI1_set_gov_mode(struct GovNode * );

void AI1_clear_all_orders(struct GovNode * );

void AI1_give_orders(void);

struct GovNode * AI1_FindOwner(struct Unit * );

void AI1_computer_give_orders(struct Unit * , int , short , short , short , short , int );

int AI1_do_unit_actions(void);

int AI1_look_around(struct Unit * );

int AI1_calc_dir(enum Direction , short , short , short * , short * );

void AI1_execute_standing_order(struct Unit * );

void AI1_command_random(struct Unit * );

int AI1_command_headto(struct Unit * );

