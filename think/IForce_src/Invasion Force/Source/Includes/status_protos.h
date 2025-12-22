/* Prototypes for functions defined in
status.c
 */

extern char * lv_text[11];

extern int high_text;

extern int now_text;

void draw_listview(void);

void update_listview(int );

void examine_city(struct City * );

void status_report(int );

void end_of_player(int );

void context_sound(int );

void tell_player(char * );

void player_preferences(void);

void prop_delay(int , int , BOOL );

void tell_user(char * , BOOL , int );

void tell_user2(char * , BOOL , int );

void show_battle(void);

void show_combat_report(BOOL );

void ME_world_view(void);

void GP_world_view(void);

void sector_survey(int , int );

void unit_survey(int , int );

