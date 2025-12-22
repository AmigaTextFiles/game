#define DEBUG

#define NIL     0
#define TRUE    1
#define FALSE   0

#define nil     NIL
#define true    TRUE
#define false   FALSE

#define MAX_BOARD_SIZE 15
#define BOARD_X_SIZE   MAX_BOARD_SIZE
#define BOARD_Y_SIZE   MAX_BOARD_SIZE
#define bdsize  MAX_BOARD_SIZE
#define I_COST          3
#define i_cost  I_COST
#define MAX_VELOCITY   12
#define MAX_VEL        MAX_VELOCITY
#define max_vel MAX_VEL
#define MAX_RANGE      bdsize
#define MAX_WEAPONS    10
#define INIT_UNITS     35
#define initunit INIT_UNITS
#define INIT_MONEY     30
#define initmoney INIT_MONEY
#define MB_COST         8
#define mb_cost MB_COST
#define C_COST         16
#define c_cost C_COST
#define S_COST          6
#define s_cost S_COST
#define AMB_COST       35
#define amb_cost AMB_COST
#define B_COST         70
#define b_cost B_COST
#define C_GUNS          7
#define c_guns C_GUNS
#define B_GUNS         40
#define b_guns B_GUNS
#define S_DEF           2
#define s_def S_DEF
#define T_DEF           1
#define t_def T_DEF
#define MAX_NUM_STARS  21
#define NUM_STARS      conf.num_stars
#define nstars NUM_STARS
#define MAX_FLEETS     26
#define INIT_VEL        1
#define initvel INIT_VEL
#define INIT_RANGE      5
#define initrange INIT_RANGE
#define INIT_WEAPONS    3
#define initweap INIT_WEAPONS
#define IU_RATIO        2
#define iu_ratio IU_RATIO
#define BLANK_LINE       "                              "
#define blank_line BLANK_LINE
#define T_E_PROB        10.0
#define t_e_prob T_E_PROB
#define T_E_VAR          5
#define t_e_var T_E_VAR
#define S_E_PROB        70.0
#define s_e_prob S_E_PROB
#define S_E_VAR         10
#define s_e_var S_E_VAR
#define C_E_PROB        90
#define c_e_prob C_E_PROB
#define C_E_VAR         10
#define c_e_var C_E_VAR
#define B_E_PROB        97.0
#define b_e_prob B_E_PROB
#define B_E_VAR         3
#define b_e_var B_E_VAR

#define  MIN(x,y) ((x < y) ? x : y)
#define OTHER_PLAYER(team) (1-(team))
