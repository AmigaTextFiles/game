/* Global constants used all over the program */

// Piece value, indexed by type
extern int value[7];

// Lazy eval cutoff during search
extern int lazy[4];

// Piece names for output routines
const char name[7] = { ' ', 'P', 'N', 'B', 'R', 'Q', 'K' };

// Castle mask as suggested by Tom Kerrigan's Simple Chess Program
// The basic idea is to speed up change of castle rights by AND
// operations.
const int castle_mask[64] = {
               13, 15, 15, 15, 12, 15, 15, 14,
               15, 15, 15, 15, 15, 15, 15, 15,
               15, 15, 15, 15, 15, 15, 15, 15,
               15, 15, 15, 15, 15, 15, 15, 15,
               15, 15, 15, 15, 15, 15, 15, 15,
               15, 15, 15, 15, 15, 15, 15, 15,
               15, 15, 15, 15, 15, 15, 15, 15,
                7, 15, 15, 15,  3, 15, 15, 11,
};

// default square
const square empty = { 0, -1 };



