/* Prototypes for functions defined in
cyber_interface.c
 */

void set_automated_production(struct City * );

int do_computer_city_production(void);

void make_new_unit(struct City * );

void computer_player_moves(void);

void cleanup_computer(void);

int SaveAIPlayers(BPTR , char * );

int LoadAIPlayers(BPTR , char * );

