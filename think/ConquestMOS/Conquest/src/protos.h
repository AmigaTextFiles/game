/* Prototypes for all the functions */

/* Combat.c */
void playerattack(int starnum);
void tf_battle(int starnum);
void withdraw(int starnum, int plnum);
void blast(tplanet *planet, int factors);
void fire_salvo(tteam att_team, int tfnum, struct stplanet *planet, boolean first_time);
boolean play_salvo(int starnum);
void battle();

/* Commands.c */
void blast_planet(); /* -> Combat */
void inputplayer();
void land();
void quit();
void send_tf();
void inv_player(int x, int y, struct stplanet *planet);

/* Config.c */
char *next_config_token(FILE *f);
int get_config_value(char *text);
int get_config_handle(char *text);
bool read_config(char *filename);

/* Display.c */
boolean display_forces(int ennum, int plnum, float *Enodds, float *Plodds);
void disp_tf(struct sttf *taskf);
void printmap();
void print_col();
void starsum();
void tfsum();
void clear_field();
void clear_left();
void clear_screen();
void error(char *fmt, ...);
void error_message();
void print_tf(int i);
void print_star(int stnum);

/* Enemy.c */
boolean best_withdraw_plan(int Starnum, float odds);
void enemy_attack(int starnum);
void depart(int starnum);
int eval_bc_col(struct stplanet *planet);
int eval_t_col(struct stplanet *planet, float range);
void inputmach();
void move_bc(struct sttf *task, float slist[]);
void send_transports(float slist[], struct sttf *task);
/* Maybe this send4t has a meaning? */
void send_t_tf(struct sttf *task, float slist[], int dest_star);
void send_scouts(float slist[], struct sttf *task);
boolean underdefended(int starnum);
void wander_bc(struct sttf *task, float slist[]);
void inv_enemy(int x, int y, struct stplanet *planet);

/* Init.c */
void startup(void);
void assign_planets(tstar *Ustar0, int starnum);
void initconst();
void init_player();

/* Input.c */
char get_char();
void get_line(char *iline);
float dist(int star1, int star2);
int get_stars(int s_star, float slist[]); /* -> utils? misc? */
char get_token(char *line, int *Value);

/* Main.c */
int main();

/* Misc.c */
void help(int which);
void on_board(int x, int y);
void pause();

/* Movement.c */
void lose_q(int *Ships, char typ, float percent);
boolean lose(int *Ships, int typ, float percent); /* -> Combat */
void move_ships();
boolean set_des(int tf_num);

/* Research.c */
void ressum();
void print_res(char field);
int research_limited(int team, char field, int max_amt);
void research(int team, char field, int amt);
void new_research();

/* Taskforce.c */
void make_tf();
int split_tf(int tf_num);
void join_tf();
int get_tf(tteam tm, int starnum);
void joinsilent(tteam team, struct sttf *parent, struct sttf *child);

/* Update.c */
void update_board(int x, int y, toption option);
void up_year();
void zero_tf(tteam tm, int tf_num);
void check_game_over();
void revolt(int starnum);
void invest();

/* Utils.c */
double fmin(double a, double b);
void point(int col, int row);
void move(int cols, int rows);
int rnd(int i);
int round(float x);
int min(int x1, int x2);
int max(int x1, int x2);
boolean any_bc(tteam team, int starnum);
double fact(int k);
void swap(int *a, int *b);
int conv_bcd(int nibble, char byte);

/* Some other functions that we need */
double exp();
double log();
double sqrt();
