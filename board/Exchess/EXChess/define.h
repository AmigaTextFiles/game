/* Pre-processor definitions to make the code more
   readable and easy to modify */

#define VERS  2.45              // program version number
#define MAXD  46                // max search depth
#define MATE 10000000           // mate score

// Compiler flags for different systems
#define BORLAND  0      // Selects a win95/NT compiler if set to 1
                        //   this should work with MSVC and others as
                        //   well
#define DEC      0      // Set to 1 for certain DEC Unix systems, not
                        //   all will need it - some other unixes may
                        //   need this if there are errors in "book.cpp"
#define UNIX     1      // Set to 1 for all Unix systems

#define DEBUG    0      // Set to 1 to debug mode... quite slow


// define book file
#define BOOK_FILE "open_bk.dat"

// book learning threshold..
#define LEARN_SCORE    500
#define LEARN_FACTOR     5

// Color flags
#define WHITE 1
#define BLACK 0

/* Piece definitions */

#define EMPTY        0
#define PAWN         1
#define KNIGHT       2
#define BISHOP       3
#define ROOK         4
#define QUEEN        5
#define KING         6

/* Piece id numbers for certain kinds of indicies */

#define BPAWN        1
#define BKNIGHT      2
#define BBISHOP      3
#define BROOK        4
#define BQUEEN       5
#define BKING        6
#define WPAWN        7
#define WKNIGHT      8
#define WBISHOP      9
#define WROOK       10
#define WQUEEN      11
#define WKING       12

/* Types of moves */

#define CAPTURE      1
#define CASTLE       2
#define EP           4
#define PAWN_PUSH2   8
#define PAWN_PUSH   16
#define PROMOTE     32

/* macros */
#define RANK(x)    ((x)>>3)        // Find the rank associated with square x
#define FILE(x)    ((x)&7)         // Find the file associated with square x
#define SQR(x,y)   ((x)+8*(y))       // Find square from rank x and file y

#define CHAR_FILE(x) (int(x)-97)  // convert letter character to a file
#define CHAR_ROW(x)  (int(x)-49)  // convert number character to a row

// find the id number of the piece
#define ID(x) (((x.side) > 0) ? ((x.type)+6) : (x.type) )

#define NOMOVE       0           // no move

