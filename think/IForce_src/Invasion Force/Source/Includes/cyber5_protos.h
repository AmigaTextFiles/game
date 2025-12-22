/* Prototypes for functions defined in
cyber5.c
 */

void AI5_set_gov_prod(struct City * , struct GovNode * );

void AI5_get_gov_req(struct GovNode * , struct City * , enum GovType );

void AI5_get_city_req(struct GovNode * , struct City * , enum GovType );

void AI5_get_island_req(struct GovNode * , struct City * , enum GovType );

void AI5_get_transport_req(struct GovNode * , struct City * , enum GovType );

void AI5_get_carrier_req(struct GovNode * , struct City * , enum GovType );

void AI5_get_battleship_req(struct GovNode * , struct City * , enum GovType );

int AI5_select_from_prefs(struct GovPrefs * , short );

void AI5_CalcPath(short , short , short , short , short , int );

long AI5_GetCost(short , short );

long AI5_GetDist(short , short , short , short );

struct PathNode * AI5_OpenListGetBest(void);

void AI5_set_gov_mode(struct GovNode * );

struct Unit * AI5_LocateUnit(struct GovNode * );

void AI5_play_turn(int );

void AI5_do_all_histograms(void);

int AI5_do_unit_actions(void);

int AI5_recommend_action(struct Unit * , int , int );

void AI5_evaluate_hex(struct Unit * , short , short , struct HexReport * );

int AI5_can_attack(short , short , short , short );

int AI5_unit_value(short );

int AI5_evaluate_odds(struct Unit * , short , short , short , int );

double AI5_CalcWinOdds(double , int , int , int , int , double );

double AI5_CalcOddsAdjust(int );

void AI5_give_orders(void);

void AI5_city_orders(struct GovNode * , struct Unit * );

void AI5_port_orders(struct GovNode * , struct Unit * );

void AI5_island_orders(struct GovNode * , struct Unit * );

void AI5_transport_orders(struct GovNode * , struct Unit * );

void AI5_carrier_orders(struct GovNode * , struct Unit * );

void AI5_battleship_orders(struct GovNode * , struct Unit * );

void AI5_default_orders(struct Unit * );

void AI5_command_goto(struct Unit * );

