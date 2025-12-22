/* Prototypes for functions defined in
cyber4.c
 */

void AI4_set_gov_prod(struct City * , struct GovNode * );

void AI4_get_gov_req(struct GovNode * , struct City * );

struct GovNode * AI4_locate_gov(struct City * );

void AI4_play_turn(int );

int AI4_do_unit_actions(void);

int AI4_look_around(struct Unit * );

void AI4_execute_standing_order(struct Unit * );

void AI4_give_orders(void);

void AI4_orders_for_unit(struct Unit * );

void AI4_taken_orders(struct Unit * , struct GovNode * );

void AI4_defend_orders(struct Unit * , struct GovNode * );

void AI4_computer_give_orders(struct Unit * , int , short , short , short , short , int );

int AI4_command_walk_coastline(struct Unit * );

int AI4_command_goto(struct Unit * );

