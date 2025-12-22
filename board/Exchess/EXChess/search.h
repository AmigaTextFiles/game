// search.h header file for search.cpp

/* extensions */
// These values can be modified by the search.par text file.
// The code to read the search.par file is in score.cpp.
int THRESHOLD =   12;
int CHECK_EXT =   12;
int PAWN_EXT =     9;
int RE_CAPT_EXT = 12;
int INIT_EXT =     3;
int MATE_EXT =    12;
int PV_EXT =       0;

// Null move reduction factor
int R = 2;

// Razoring depth
int RAZOR_DEPTH = 2;

position sp[MAXD];                  // array of search positions

move_list slist[MAXD+1];            // array of search lists
move pc[MAXD+1][MAXD+1];            // triangular array for search
                                    // principle continuation

int max_ply;                        // max ply of current search
int start_time;                     // start time of current search
int limit;                          // time limit of search
int ponder = 0;                     // flag for pondering
int last_ponder = 0;                // flag for did we ponder last move?
int ponder_time = 0;                // record of time used on last pondering
int wbest, wply;                    // whisper variables for search summary
int nullm, recur;                   // flags to control null moves
int learned;                        // has book learning already happened?
int turn;                           // Current game turn
int fail;                           // flag for fail-high or fail-low in search
int root_alpha, root_beta;          // starting values for alpha and beta
int extend;                         // counter that keeps track of extensions
int null_hash;                      // flag from hash table for null move
int dummy1, dummy2;                 // flags from hash table to limit alpha/beta

move hmove;                         // move from hash table
move bookm;                         // move from opening book
move nomove;                        // no-move move, for initialization
move ponder_move;                   // move we are pondering

unsigned long history[64][64];      // table for history scores

// These are a collection of counters that keep track of search
// statistics and timing checks.
unsigned long node_count, eval_count, time_count, extensions;
unsigned long phash_count, hash_count, hmove_count, q_count;
unsigned long null_cutoff, internal_iter;
// define how many nodes between time checks.
unsigned long time_check_interval = 12500;

// hash codes for side to move, piece types, stage of game, castling status,
//   and en passant rights
extern h_code wtm, btm, hval[13][64], stage_code[4];
extern h_code castle_code[16], ep_code[64];

extern h_code p_list[600];     // list of position hash codes in game so far

// counter to tell the hash table how old the entries are
extern short h_id;

extern int stage;                  // stage of the game, defined in score.cpp

extern int xboard, post;           // xboard flag, posting flag
extern int book, ALLEG, ics;       // flags from main.cpp to control the book
                                   // and playing modes
extern int learn_count, learn_bk;  // flag to control learning and keep track
                                   // of how many book moves have been played
extern int tsuite, analysis_mode;  // flags to determine whether we are in
                                   // analysis mode or a test suite
extern float timeleft;             // total time left in the game

#if DEBUG
 ofstream outfile;
#endif











