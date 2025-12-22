/* Header for main.cpp */

position game_pos;                      // board position
position temp_pos;                      // temporary position
position last_pos;                      // last position

move game_history[600];                 // game move history
h_code p_list[600];                     // game position list
move_list movelist;                     // game move list ...

int T = 1;                              // Turn number
int p_side = 1;                         // player's side
int game_over = 0;
int book = 1;                           // book flag
int both = 0;                           // human plays both sides

move best;                              // best move - will be made
extern move pc[MAXD+1][MAXD+1];         // principle continuation

char response[60];                      // human response to prompt

// Starting position
char i_pos[60] = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR";

