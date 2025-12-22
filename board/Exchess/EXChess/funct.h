/* Functions */

/* main.cpp */
void drawboard();          // draw game board and info
void takeback(int tm);
void type_moves();             // print possible moves
void type_capts();             // print possible captures
void parse_command();          // parse user's command
void make_move();              // find and make move
void test_suite();             // run a test suite
void save_game();
void help();
int inter();                   // interrupt function
void search_display(int score, int start_time, int node_count, int max_ply);
void setboard(char inboard[60], char ms, int castle);    // setup the board

/* parse.cpp */
void print_move(position p, move pmove, char mstring[10]); // print a given move
move parse_move(position p, char mstring[10]);

/* open.cpp */
move opening_book(h_code hash_code, position *p);

/* search.cpp */
move search(position p, int time_limit, int T);
void pc_update(move pcmove, int ply);
int pvs(int alpha, int beta, int depth);
int qsearch(int ply, int alpha, int beta);

/* emove.cpp */
int exec_move(position *p, move emove, int ply);
void gen_check_table();
// int undo_move(position *p, move emove, int ply);

/* movelist.cpp */
void legalmoves(position *p, move_list *list);
void captures(position *p, move_list *list);

/* pmoves.cpp */
void pawn_moves(position *p, move_list *list, int sq);
void king_moves(position *p, move_list *list, int sq);
void knight_moves(position *p, move_list *list, int sq);
void bishop_moves(position *p, move_list *list, int sq);
void rook_moves(position *p, move_list *list, int sq);

/* pcapts.cpp */
void pawn_capts(position *p, move_list *list, int sq);
void king_capts(position *p, move_list *list, int sq);
void knight_capts(position *p, move_list *list, int sq);
void bishop_capts(position *p, move_list *list, int sq);
void rook_capts(position *p, move_list *list, int sq);

/* attacks.cpp */
int attacks(int sq, position *p, int side, int one);

/* check.cpp */
int check_mate(position *p);
int check(position *p, int side);

/* score.cpp */
int score_pos(position *p);
void init_score(position *p, int T);
void set_score_param();

/* sort.cpp */
void Sort(move_rec *Lb, move_rec *Ub);
void QSort(move_rec *Lb, move_rec *Ub);

/* book.cpp */
void build_book(position ipos);
void book_learn(int flag);
