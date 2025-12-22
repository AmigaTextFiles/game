/* General definition file for structures */

// move structure to encapsulate several important move parameters
// note: The char used below is treated like an integer.

struct move_t {
  char from;                   // from square
  char to;                     // to square
  char type;                   // type of move (defined below)
  char promote;                // type of piece to promote to (defined below)
};

/*   Type of move  */
//     1 = capture
//     2 = castle
//     4 = en passant
//     8 = 2 square pawn advance (could leave an en passant square)
//    16 = pawn push 
//    32 = promotion

/*   Type of piece to promote to */
//     2 = Knight
//     3 = Bishop   
//     4 = Rook
//     5 = Queen 

// union of move_t and an integer to make comparison of 
// moves easier.  (as suggested in Tom Kerrigans simple chess program)

union move {
  move_t b;
  int t;           // assuming a 32 bit integer
};

// Add a score for sorting purposes to the move record

struct move_rec {
  move m;
  int score; 
};

// Define a move_list structure to carry these move records

struct move_list {
  short count;
  move_rec mv[256];
};

// Structure for a square

struct square {
  char type;             // type of piece (0 - 6)
  char side;                  // side which owns square (1 = white)
};

// Structure for hash code and key of a position

struct h_code
{
  unsigned long key;
  unsigned long address;
};

// Structure for current board position.

struct position {
  square sq[64];               // array of board squares
  char wtm;                   // flag for white to move
  char castle;                // castling status
  char ep;                    // location of an en-passant square (if any)
  char fifty;                 // fifty move count
  char has_castled[2];        // flag that side has castled
  char kingpos[2];            // location of kings
  char check;                 // is the side to move in check?
  char pieces[2];             // # of pieces(non-pawns)
  short material;              // material value from point of view of
                              // side to move
  move last;                  // last move made
  h_code hcode;               // hash code
};
