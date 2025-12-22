/* header file for hash functions */

#define FLAG_A 1
#define FLAG_B 2
#define FLAG_P 3
#define HASH_MISS -21000
#define HASH_MOVE -21001
#define PROBES 3

/* standard hash record - 16 bytes long */
struct hash_rec
{
  unsigned long key;
  int score;
  char flag;
  char depth;
  move hmove;
  short id;
};

/* pawn hash record - 6 bytes long */
struct pawn_rec
{
  unsigned long key;
  short score;
  char wfree_pawn;
  char bfree_pawn;
};

/* Number of hash related functions */
void open_hash();
void close_hash();
void set_hash_size(int Mbytes);
void put_pawn(h_code h_key, short score, char wfree_pawn, char bfree_pawn);
void put_hash(h_code h_key, int score, int alpha, int beta, int depth, move hmove, int deep);
int get_pawn(h_code h_key, char *wfree_pawn, char *bfree_pawn);
int get_hash(h_code h_key, int alpha, int beta, int depth, int *hardalpha, int *hardbeta);
int get_move(h_code h_key);
h_code or(h_code A, h_code B);
h_code gen_code(position *p);
void start_code();
float ran(long *idum);


