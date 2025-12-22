/*  Main functions controlling program */

#include <iostream.h>
#include <iomanip.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdio.h>
#include <signal.h>
#include <fstream.h>

#include "define.h"

#if UNIX
 #include <sys/types.h>
 #include <sys/time.h>
#else
 #include <time.h>
 #include <windows.h>
 #undef BLACK
 #undef WHITE
 #include <conio.h>
 #define BLACK 0
 #define WHITE 1
#endif

// Custom headers, defining external functions and struct types for
// board, piece and moves.  And defining global variables.

#include "chess.h"
#include "const.h"
#include "funct.h"
#include "main.h"
#include "hash.h"

// moves to time control, base time, increment, time left;
int omttc = 0, mttc = 0, inc = 0; float base = 30, timeleft = 30;

int display_board = 0;
int analysis_mode = 0;
extern int fail;   // flag for fail high/fail low from search
extern move ponder_move;

// xboard flag
int xboard, post, ics, ALLEG = 0, hintflag = 0, count = 1;
int ponder_flag = 1, learn_bk, shout_book;
extern int ponder, last_ponder, learn_count, learned, TAB_SIZE, PAWN_SIZE;

// executable directory
char exec_path[100];

#if UNIX
 fd_set read_fds;
 struct timeval timeout = { 0, 0 };
#endif

/*------------------------- Main Function ---------------------------*/
//  Main control function that interacts with the User

int main(int argc, char *argv[])
{
  char mstring[10];
  move hint;
  xboard = 0; ponder = 0; ics = 0;
  learn_count = 0; learned = 0; learn_bk = 1; shout_book = 0;

   strcpy(exec_path, argv[0]);
   // parsing exec path
   int last_slash = 0;
   for(int j = 0; j < 100; j++) {
     if(exec_path[j] == '\0') break;
     if(exec_path[j] == '\\') last_slash = j;
     if(exec_path[j] == '/') last_slash = j;
   }

   exec_path[last_slash+1] = '\0';
  

  open_hash(); gen_check_table(); set_score_param();

  if(argc > 1) {
    if(!strcmp(argv[1], "xb")) xboard = 1;
    if(!strcmp(argv[1], "hash")) set_hash_size(atoi(argv[2]));
    if(argc > 2)
      if(!strcmp(argv[2], "hash")) set_hash_size(atoi(argv[3]));
  }

  if(!xboard) {
    cout << "\nExperimental Chess Program (EXchess) version " << VERS << ","
         << "\nCopyright (C) 1997-98 Daniel C. Homan, Waltham MA, USA"
         << "\nEXchess comes with ABSOLUTELY NO WARRANTY. This is free"
         << "\nsoftware, and you are welcome to redistribute it under"
         << "\ncertain conditions. This program is distributed under the"
         << "\nGNU public license.  See the files license.txt and readme.txt"
         << "\nfor more information.\n\n";

    cout << "Hash size = " << TAB_SIZE << " entries, "
         << TAB_SIZE*sizeof(hash_rec) << " bytes\n";
    cout << "Pawn size = " << PAWN_SIZE << " entries, "
         << PAWN_SIZE*sizeof(pawn_rec) << " bytes\n\n";
    cout << "Type 'help' for a list of commands.\n";
  }

  setboard(i_pos, 'w', 1);             // set up the board

  while (count > 0)
   {

    // find a hint move, check book first then look in pv
    if(hintflag) {
      hint.t = 0;
      if(last_ponder) hint = ponder_move;
      else if(book) hint = opening_book(game_pos.hcode, &game_pos);
      if(!hint.t) hint = pc[0][1];
      if(hint.t) {
       print_move(game_pos, hint, mstring);
       cout << "Hint: " << mstring << "\n";
      }
      hintflag = 0;
    }

    signal(SIGINT, SIG_IGN);

    // pondering if possible
    if(T > 2 && p_side == game_pos.wtm
       && !both && !last_ponder && ponder_flag)
    {
      if(!xboard) cout << "pondering... (press any key to interrupt)\n";
      cout.flush();
      ponder = 1;
      search(game_pos, 10000, T+1);
      ponder = 0;
      last_ponder = 1;
    }

    // if analysis_mode, do some analysis
    if(analysis_mode) {
      search(game_pos, 360000, T);
    }
   
    if(!game_pos.wtm)                        // if it is black's turn
    {
     if(both) p_side = 0;
     if(!xboard) cout << "Black-To-Move[" << ceil(T/2) << "]: ";
    }
    else                                         // or if it is white's
    {
     if(both) p_side = 1;
     if(!xboard) cout << "White-To-Move[" << (ceil(T/2) + 1) << "]: ";
    }

    cout.flush();

    legalmoves(&game_pos, &movelist);     // find legal moves

    if(p_side == game_pos.wtm || game_over) {
      cin >> response;      // get the command
      if((last_ponder || analysis_mode) && UNIX) cout << "\n";
      parse_command();      // parse it
    } else {
      if(!xboard) cout << "Thinking ...\n";
      cout.flush();
      make_move();
      last_ponder = 0;
      T++;
    }

    cout.flush();
   }

  close_hash();
  return 0;
}

// Function to takeback moves
// tm is the number of moves to take back.
// 1 or 2 with current setup
void takeback(int tm)
{
 int temp_turn = T;
 setboard(i_pos, 'w', 1);
 T = temp_turn; if(!(T % 2)) p_side = 0;
 if(p_side == 0 && tm == 1) p_side = 1;
 for (int ip = 0; ip <= T-2-tm; ip++)
 {
  exec_move(&game_pos, game_history[ip], 0);
 }
 if(!xboard) drawboard();
 T = T - tm;
}


// Function to make the next move... If it is the computer's turn, this
// function calls the search algorithm, takes the best move given by that
// search, and makes the move - unless it is a check move: then it flagges
// stale-mate.....
// The function also looks to see if this move places the opponent in check
// or check-mate.

void make_move()
{
   time_t mtime = time(NULL); int time_limit, legal;
   char mstring[10];

   // If it is not the player's turn, figure out how much time to use,
   // execute the search algorithm to start the search process and return
   // the best move.

   if(mttc && mttc < 25)
    { time_limit = int(timeleft/(mttc+1)) + inc; }
   else if (mttc >= 25 || xboard) { time_limit = int(timeleft/25) + inc; }
   else { time_limit = int(timeleft); }

   if (p_side != game_pos.wtm)
   {
    best = search(game_pos, time_limit, T);
    timeleft -= time(NULL) - mtime; timeleft += inc;
    if(mttc) { mttc--; if(!mttc) { timeleft += base; mttc = omttc; } }
    if(mttc <= 0 && !xboard) { timeleft = base; mttc = omttc; }
   }

   // execute the move....
   temp_pos = game_pos;
   legal = exec_move(&temp_pos, best, 0);

   // Is the move legal? if not Error ....
   if (legal)
    {
     // if it is the computer's turn - echo the move
     if(p_side != game_pos.wtm)
      {
       if(game_pos.wtm) { 
         cout << (ceil(T/2) + 1) << ". ";  if(xboard) cout << "... ";
       }
       else { cout << ceil(T/2) << ". ... "; }
       print_move(game_pos, best, mstring);
       cout << mstring;
       cout << "\n";
      }

     last_pos = game_pos;        // Save last position
     game_pos = temp_pos;        // actually execute move

     // Check if we have, check_mate, stale_mate, or a continuing game...
     switch (check_mate(&game_pos))
     {
      case 0:
        if(game_pos.fifty >= 100)
         { cout << "1/2-1/2 {50 moves}\n";
           if(ics) cout << "tellics draw\n"; }
        else if(check(&game_pos, game_pos.wtm) && !xboard)
         { cout << "Check!\n"; }
        break;
      case 1:
        game_over = 1;
        if(!game_pos.wtm) cout << "1-0 {White Mates}\n";
        else cout << "0-1 {Black Mates}\n";
        break;
      case 2:
        game_over = 1;
        cout << "1/2-1/2 {Stalemate}\n";
     }

     game_history[T-1] = best; // record the move in the history list
     p_list[T-1] = game_pos.hcode;
     if(!xboard && display_board) drawboard();  // draw the resulting board
    }
   else { game_over = 1; cout << "Error - please reset"; }

}



// This function sets up the board from EPD format

void setboard(char inboard[60], char ms, int castle)
{
  int rx = 0, ry = 7, i;  // control variables

  // no book learning yet
  learn_count = 0; learned = 0;

  // game is not over
  game_over = 0;
  // initializing castling status if necessary
  if (castle) { game_pos.castle = 15; } else { game_pos.castle = 0; }
  // Side to move
  if (ms == 'b') { T = 2; p_side = 0; game_pos.wtm = 0; }
  else { T = 1; p_side = 1; game_pos.wtm = 1; }
  // Other game parameters
  game_pos.ep = 0; game_pos.fifty = 0; game_pos.last.t = NOMOVE;

  // clear the board
  for(int ci = 0; ci < 64; ci++) { game_pos.sq[ci] = empty; }

  // Setting up the board
  for (int ri = 0; ri < 60; ri++)
  {
    switch (inboard[ri])
    {
      case '/': ry--; rx = 0; break;
      case '1': game_pos.sq[SQR(rx,ry)] = empty; rx++; break;
      case '2': for(i=1;i<=2;i++) { game_pos.sq[SQR(rx,ry)] = empty; rx++; } break;
      case '3': for(i=1;i<=3;i++) { game_pos.sq[SQR(rx,ry)] = empty; rx++; } break;
      case '4': for(i=1;i<=4;i++) { game_pos.sq[SQR(rx,ry)] = empty; rx++; } break;
      case '5': for(i=1;i<=5;i++) { game_pos.sq[SQR(rx,ry)] = empty; rx++; } break;
      case '6': for(i=1;i<=6;i++) { game_pos.sq[SQR(rx,ry)] = empty; rx++; } break;
      case '7': for(i=1;i<=7;i++) { game_pos.sq[SQR(rx,ry)] = empty; rx++; } break;
      case '8': for(i=1;i<=8;i++) { game_pos.sq[SQR(rx,ry)] = empty; rx++; } break;
      case 'p': game_pos.sq[SQR(rx,ry)].side = 0;
           game_pos.sq[SQR(rx,ry)].type = PAWN; rx++; break;
      case 'n': game_pos.sq[SQR(rx,ry)].side = 0;
           game_pos.sq[SQR(rx,ry)].type = KNIGHT; rx++; break;
      case 'b': game_pos.sq[SQR(rx,ry)].side = 0;
           game_pos.sq[SQR(rx,ry)].type = BISHOP; rx++; break;
      case 'r': game_pos.sq[SQR(rx,ry)].side = 0;
           game_pos.sq[SQR(rx,ry)].type = ROOK; rx++; break;
      case 'q': game_pos.sq[SQR(rx,ry)].side = 0;
           game_pos.sq[SQR(rx,ry)].type = QUEEN; rx++; break;
      case 'k': game_pos.sq[SQR(rx,ry)].side = 0;
           game_pos.sq[SQR(rx,ry)].type = KING;
           game_pos.kingpos[0] = SQR(rx,ry); rx++; break;
      case 'P': game_pos.sq[SQR(rx,ry)].side = 1;
           game_pos.sq[SQR(rx,ry)].type = PAWN; rx++; break;
      case 'N': game_pos.sq[SQR(rx,ry)].side = 1;
           game_pos.sq[SQR(rx,ry)].type = KNIGHT; rx++; break;
      case 'B': game_pos.sq[SQR(rx,ry)].side = 1;
           game_pos.sq[SQR(rx,ry)].type = BISHOP; rx++; break;
      case 'R': game_pos.sq[SQR(rx,ry)].side = 1;
           game_pos.sq[SQR(rx,ry)].type = ROOK; rx++; break;
      case 'Q': game_pos.sq[SQR(rx,ry)].side = 1;
           game_pos.sq[SQR(rx,ry)].type = QUEEN; rx++; break;
      case 'K': game_pos.sq[SQR(rx,ry)].side = 1;
           game_pos.sq[SQR(rx,ry)].type = KING;
           game_pos.kingpos[1] = SQR(rx,ry); rx++; break;
    }
   if(ry <= 0 && rx >= 8) break;
   if(inboard[ri] == '\0') break;
  }
  // generate the hash_code for this position
  game_pos.hcode = gen_code(&game_pos);
  game_pos.has_castled[0] = 0;
  game_pos.has_castled[1] = 0;
  game_pos.check = check(&game_pos, game_pos.wtm);
}

// This function is a special edit mode for xboard/winboard
void board_edit()
{
   char edcom[4];    // edit command
   int edside = 1;   // side being edited
   int ex, ey;       // edit coordinates

   game_pos.castle = 0;

   // no book learning yet
   learn_count = 0; learned = 0;

   while(edside > -1) {
     cin >> edcom;
     if(edcom[0] == '#') {
       // clear the board
       for(int ci = 0; ci < 64; ci++) { game_pos.sq[ci] = empty; }
     } else if(edcom[0] == 'c') {
       edside ^= 1;           // change side to edit
       continue;
     } else if(edcom[0] == '.') {
       // generate the hash_code for this position
       game_pos.hcode = gen_code(&game_pos);
       game_pos.has_castled[0] = 0;
       game_pos.has_castled[1] = 0;
       game_pos.check = check(&game_pos, game_pos.wtm);
       return;
     } else {
       ex = CHAR_FILE(edcom[1]);
       ey = CHAR_ROW(edcom[2]);
       game_pos.sq[SQR(ex,ey)].side = edside;
       switch(edcom[0]) {
          case 'P':
            game_pos.sq[SQR(ex,ey)].type = PAWN; break;
          case 'N':
            game_pos.sq[SQR(ex,ey)].type = KNIGHT; break;
          case 'B':
            game_pos.sq[SQR(ex,ey)].type = BISHOP; break;
          case 'R':
            game_pos.sq[SQR(ex,ey)].type = ROOK; break;
          case 'Q':
            game_pos.sq[SQR(ex,ey)].type = QUEEN; break;
          case 'K':
            game_pos.sq[SQR(ex,ey)].type = KING; 
            game_pos.kingpos[edside] = SQR(ex,ey);
            break;
          case 'X':
            game_pos.sq[SQR(ex,ey)] = empty; break;
       }
     }
   }
}


// This function draws the graphical board in a very simple way
void drawboard()
{
  char mstring[10];     // character string to hold move

 // the following for loop steps through the board and paints each square
  for (int j = 7; j >= 0; j--)
  {
   cout << "\n  +---+---+---+---+---+---+---+---+\n" << (j+1) << " | ";
   for (int i = 0; i <= 7; i++)
   {
    if(!game_pos.sq[SQR(i,j)].side) cout << "\b<" << name[game_pos.sq[SQR(i,j)].type] << ">| ";
    else if(game_pos.sq[SQR(i,j)].side == 1) cout << name[game_pos.sq[SQR(i,j)].type] << " | ";
    else if(!((i+j)&1)) cout << "\b:::| ";
    else cout << "  | ";
   }
   if(j==7) { if(game_pos.wtm) cout << "   White to move";
                          else cout << "   Black to move"; }
   if(j==6) {
     cout << "   castle: ";
     if(game_pos.castle&1) cout << "K";
     if(game_pos.castle&2) cout << "Q";
     if(game_pos.castle&4) cout << "k";
     if(game_pos.castle&8) cout << "q";
     if(!game_pos.castle)  cout << "-";
   }
   if(j==5 && game_pos.ep)
     cout << "   ep: " << char(FILE(game_pos.ep) + 97) << (RANK(game_pos.ep) + 1);
   if(j==4 && game_pos.last.t) {
     cout << "   last: ";
     print_move(last_pos, game_pos.last, mstring);
     cout << mstring;
    }
   if(j==3) cout << "   fifty: " << ceil(game_pos.fifty/2);
   if(j==2) cout << "   Computer time: " << timeleft << " seconds";
  }
   cout << "\n  +---+---+---+---+---+---+---+---+";
   cout << "\n    a   b   c   d   e   f   g   h  \n\n";
}


// Help function
void help()
{
 char ch;   // dummy character

 cout <<   "\n Commands ........ ";
 cout << "\n\n   Enter a move in standard algebraic notation,";
 cout <<   "\n      Nf3, e4, O-O, d8=Q, Bxf7, Ned7, etc....";
 cout <<   "\n      Other notation's like: g1f3, e2e4, etc... are also ok.";
 cout << "\n\n   new            -> start a new game";
 cout <<   "\n   quit           -> end EXchess";
 cout <<   "\n   save           -> save the game to a text file";
 cout <<   "\n   go             -> computer takes side on move";
 cout <<   "\n   white          -> white to move, EXchess takes black";
 cout <<   "\n   black          -> black to move, EXchess takes white";
 cout <<   "\n   book           -> toggle opening book";
 cout <<   "\n   post           -> turn on display of computer thinking";
 cout <<   "\n   nopost         -> turn off display of computer thinking";
 cout <<   "\n   setboard rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w";
 cout <<   "\n                  -> set board using EPD notation";
 cout <<   "\n   level 40 5 0   -> set level of play:";
 cout <<   "\n                       1st number is the number of move till time control";
 cout <<   "\n                       2nd number is the base time control in minutes";
 cout <<   "\n                       3rd number is the increment in seconds";
 cout <<   "\n   takeback       -> takeback last move";
 cout <<   "\n   hint           -> get a hint from the program";
 cout <<   "\n   testsuite      -> run a testsuite";
 cout <<   "\n   display        -> display the board";
 cout <<   "\n------------ Enter 'n' for remaining commands: ";
 cin >> ch;
 if(ch == 'n') {
  cout <<   "\n   nodisplay      -> turn off board display";
  cout <<   "\n   list           -> list the legal moves";
  cout <<   "\n   clist          -> list the legal captures";
  cout <<   "\n   score          -> score the current position";
  cout <<   "\n   analyze        -> enter analysis mode";
  cout <<   "\n   exit           -> exit analysis mode";
  cout <<   "\n   ponder         -> toggle pondering";
  cout <<   "\n   hash n         -> set hash table size to n Mbytes";
  cout <<   "\n   build          -> build a new opening book from a pgn file,";
  cout <<   "\n                      it will replace the old one.";
 }
 cout << "\n\n";
}

/* Function to print the possible moves to the screen */
// Useful for debugging
void type_moves()
{
  int j = 0;   // dummy count variable to determine when to
               // send a newline character
  char mstring[10]; // character string for the move

  for(int i = 0; i < movelist.count; i++) {
      temp_pos = game_pos;
      // if it is legal, print it!
      if(exec_move(&temp_pos, movelist.mv[i].m, 0)) {
         if(!(j%6) && j) cout << "\n";    // newline if we have printed
                                          // 6 moves on a line
         else if(j) cout << ", ";         // comma to separate moves
         print_move(game_pos, movelist.mv[i].m, mstring); // print the move
                                                            // to the string
         cout << mstring;
         j++;                              // increment printed moves variable
      }
  }
  cout << "\n";
}

/* Function to print out the possible captures to the screen */
// Useful for debugging
void type_capts()
{
  int j = 0;              // dummy variable for counting printed moves
  char mstring[10];       // character string to hold move
  move_list clist;        // capture list

  captures(&game_pos, &clist);
  for(int i = 0; i < clist.count; i++) {
      temp_pos = game_pos;
      // if it is legal, print it!
      if(exec_move(&temp_pos, clist.mv[i].m, 0)) {
         if(!(j%6) && j) cout << "\n";    // newline if we have printed
                                          // 6 moves on a line
         else if(j) cout << ", ";         // comma to separate moves
         print_move(game_pos, clist.mv[i].m, mstring); // print the move
                                                            // to the string
         cout << mstring;
         j++;                              // increment printed moves variable
      }
  }
  cout << "\n";
}

/* Function to parse the command from the user */
// Some of these commands are xboard/winboard specific

void parse_command()
{
  char inboard[60], ms, basestring[5];
  int timeleft2, Mbytes;

  // if the command is an instruction
  if(!strcmp(response, "level"))
   { cin >> mttc >> basestring >> inc; base = atof(basestring)*60;
     omttc = mttc; timeleft = base; }
  else if(!strcmp(response, "time")) { cin >> timeleft; timeleft = timeleft/100; }
  else if(!strcmp(response, "otim")) { cin >> timeleft2; timeleft2 = timeleft2/100; }
  else if(!strcmp(response, "display"))
   { display_board = 1; drawboard(); }
  else if(!strcmp(response, "nodisplay"))
   { display_board = 0; }
  else if(!strcmp(response, "force")) { both = 1; }
  else if(!strcmp(response, "black"))
   { game_pos.wtm = 0; p_side = 0; both = 0;
     game_pos.hcode = gen_code(&game_pos);
     game_pos.check = check(&game_pos, game_pos.wtm); }
  else if(!strcmp(response, "white"))
   { game_pos.wtm = 1; p_side = 1; both = 0;
     game_pos.hcode = gen_code(&game_pos);
     game_pos.check = check(&game_pos, game_pos.wtm); }
  else if(!strcmp(response, "go"))
   { p_side = game_pos.wtm^1; both = 0; analysis_mode = 0; }
  else if(!strcmp(response, "edit")) { board_edit(); }
  else if(!strcmp(response, "testsuite")) { test_suite(); }
  else if(!strcmp(response, "analyze"))
   { post = 1; learn_bk = 0; analysis_mode = 1; book = 0; both = 1;
     if(!xboard) cout << "Analysis mode: Enter commands/moves as ready.\n\n"; }
  else if(!strcmp(response, "exit"))
   { analysis_mode = 0; }
  else if(!strcmp(response, "new"))
   { p_side = 1; if(!analysis_mode) { both = 0; book = 1; learn_bk = 1; }
     T = 1; mttc = omttc; learn_count = 0; learned = 0;
     game_over = 0; setboard(i_pos, 'w', 1); timeleft = base; }
  else if(!strcmp(response, "remove")) { takeback(2); }
  else if(!strcmp(response, "undo")) { takeback(1); }
  else if(!strcmp(response, "bk") || !strcmp(response, "book"))
   { if(book) { book = 0; cout << " Book off\n\n"; }
     else { book = 1; cout << " Book on\n\n"; } }
  else if(!strcmp(response, "hint")) { hintflag = 1; }
  else if(!strcmp(response, "shout")) { shout_book = 1; }
  else if(!strcmp(response, "post")) { post = 1; }
  else if(!strcmp(response, "xboard")) { xboard = 1; }
  else if(!strcmp(response, "build")) { build_book(game_pos); }
  else if(!strcmp(response, "hash"))
   { cin >> Mbytes; set_hash_size(Mbytes);
     cout << " Hash size = " << TAB_SIZE << " entries, "
          << TAB_SIZE*sizeof(hash_rec) << " bytes\n";
     cout << " Pawn size = " << PAWN_SIZE << " entries, "
          << PAWN_SIZE*sizeof(pawn_rec) << " bytes\n\n"; }
  else if(!strcmp(response, "name") || !strcmp(response, "sum") ||
           !strcmp(response, "ics"))
   { ics = 1; if(!xboard) cout << " Search summary is on\n\n"; }
  else if(!strcmp(response, "ponder"))
   { if(ponder_flag) { ponder_flag = 0; cout << " Pondering off\n\n"; }
     else { ponder_flag = 1; cout << " Pondering on\n\n"; } }
  else if(!strcmp(response, "easy")) // pondering off in xboard/winboard
   { ponder_flag = 0; }
  else if(!strcmp(response, "hard")) // pondering on in xboard/winboard
   { ponder_flag = 1; }
  else if(!strcmp(response, "list")) { type_moves(); }
  else if(!strcmp(response, "clist")) { type_capts(); }
  else if(!strcmp(response, "score"))
    { init_score(&game_pos, T);
      cout << "score = " << score_pos(&game_pos) << "\n";
      cout << "material = " << game_pos.material << "\n"; }
  else if(!xboard && !strcmp(response, "help")) { help(); }
  else if(!strcmp(response, "nopost")) { post = 0; }
  else if(!strcmp(response, "save")) { save_game(); }
  else if(!strcmp(response, "quit")) { game_over = 1; count = 0; }
  else if(!strcmp(response, "setboard"))
   { cin >> inboard >> ms; mttc = omttc; game_over = 0;
     setboard(inboard, ms, 0); }
  // if command is a move
  else { best = parse_move(game_pos, response);
         if(best.t) { make_move(); T++; }
         else cout << "Error(" << response << ")\n";
       }
}

// Function to run a test suite.  The following variables are
// designed to work with the search_display function to determine
// when the best move was first found and held on to.

int soltime, bmcount, tsuite = 0; move bmoves[10];

void test_suite()
{
  char testpos[60], ms, bookm[10], h1[4], h2, h3[2], h4[7], id[12];
  char reply = 'n', testfile[] = "testsuit.txt", resfile[] = "results1.txt";
  char mstring[10];
  int testtime = 180, cst[4], inter = 0, correct = 0, total = 0;
  int total_time_sq = 0;
  bmcount = 0; tsuite = 1; int bmexit;

  cout << "\nEnter file name for test suite in EPD format: ";
  cin >> testfile;

  cout << "\nEnter file name for test results: ";
  cin >> resfile;

  cout << "\nInteractive run? (y/n): "; cin >> reply;
  if (reply == 'y') inter = 1;
  else { cout << "\nEnter search time per move: "; cin >> testtime; }

  ifstream infile(testfile);
  ofstream outfile(resfile);
  if (!(infile)) { cout << "\nUnable to open file. "; return; }
  if (!(outfile)) { cout << "\nUnable to open results file. "; return; }

  do
   {
    soltime = -1;
    if (reply != 's') {
      for(int j = 0; j < 4; j++) { h1[j] = '*'; cst[j] = 0; }
      infile >> testpos >> ms >> h1 >> h2 >> h3;
      bmcount = 0;
      setboard(testpos, ms, 0);

      do {
       infile >> bookm;
       bmexit = 0;
       for(int d = 0; d < 10; d++) {
        if(bookm[d] == '\0') break;
        if(bookm[d] == ';')
         { bookm[d] = '\0'; bmexit = 1; break; }
       }
       bmoves[bmcount] = parse_move(game_pos, bookm);
       bmcount++;
      } while(!bmexit);

      infile >> h4;
      infile >> id;
      if(testpos[0] == '*') break;

      for(int i = 0; i < 4; i++)  {
        switch (h1[i]) {
          case 'K':
           game_pos.castle = game_pos.castle^1; break;
          case 'Q':
           game_pos.castle = game_pos.castle^2; break;
          case 'k':
           game_pos.castle = game_pos.castle^4; break;
          case 'q':
           game_pos.castle = game_pos.castle^8; break;
      } }

      if(inter) drawboard(); else cout << "\n";
      if (ms == 'w') { cout << "\nWhite to Move"; } else { cout << "\nBlack to Move"; }
      cout << "  Book Move: " << bookm << "\n ";
      cout << "  Test Position: " << id << "\b ";

      if (inter) {
        cout << "\n\nPress 's' to search, 'n' for the next position, 'q' to exit: ";
        cin >> reply;
        if(reply == 'n') continue;
        if(reply == 'q') break;
        cout << "Please enter a search time (in seconds): ";
        cin >> testtime;
      }
    }

    if(!inter) cout << "\n";

    best = search(game_pos, testtime, 1);

    for(int e = 0; e < bmcount; e++) {
     if(best.t == bmoves[e].t)
     { correct++; if(soltime < 0) soltime = 0; break; }
    }
    total++;

    print_move(game_pos, best, mstring);
    print_move(game_pos, bmoves[0], bookm);

    cout << "\nSearched Move: " << mstring << "\n";
    cout << "Right = " << correct << "/" << total;
    cout << " Stime = " << soltime;

    cout.flush();

    if(soltime > -1) total_time_sq += soltime*soltime;

    if(correct)
     { cout << " <time_sq> = "
            << setprecision(3) << float(total_time_sq)/float(correct); }

    outfile << "\n" << id << " Smove: " << mstring;
    outfile << " Stime = " << soltime;
    outfile << " Right = " << correct << "/" << total;
    if(correct)
     { outfile << " <time_sq> = "
              << setprecision(3) << float(total_time_sq)/float(correct); }

    if (inter) {
      cout << "\n\nPress 's' to search again, 'n' for the next position, 'q' to exit: ";
      cin >> reply;
    }

   } while (reply != 'q');

  outfile.close();
  infile.close();
  if(testpos[0] == '*') cout << "\nNo more test positions.\n";
  setboard(testpos, ms, 0);
  tsuite = 0;
  return;
}

// Save game function to save the game to a text file
void save_game()
{
  int TURN; TURN = T;
  char gname[] = "lastgame.gam";
  char resp, mstring[10];
  char Event[30], White[30], Black[30], Date[30], result[30];

  cout << "\nFile Name : ";
  cin >> gname;
  cout << "Custom Header? (y/n): ";
  cin >> resp;

  if(resp == 'y' || resp == 'Y')
  {
    cout << "Event: ";  cin >> Event;
    cout << "Date: "; cin >> Date;
    cout << "White: ";  cin >> White;
    cout << "Black: ";  cin >> Black;
  } else {
    strcpy(Event, "Chess Match");
    strcpy(Date, "??.??.????");
    if (p_side)
     { strcpy(White, "Human"); strcpy(Black, "EXchess"); }
    else
     { strcpy(White, "EXchess"); strcpy(Black, "Human"); }
  }

  ofstream outfile(gname);

  outfile <<   "[Event: " << Event << " ]";
  outfile << "\n[Date: " << Date << " ]";
  outfile << "\n[White: " << White << " ]";
  outfile << "\n[Black: " << Black << " ]";

  // set the result string
  switch (check_mate(&game_pos))
   {
    case 0:
     if(game_pos.fifty >= 100)
      { strcpy(result, " 1/2-1/2 {50 moves}"); }
     else strcpy(result, " adjourned");
      break;
    case 1:
     if(!game_pos.wtm) strcpy(result, " 1-0 {White Mates}");
     else strcpy(result, " 0-1 {Black Mates}");
     break;
    case 2:
     strcpy(result, " 1/2-1/2 {Stalemate}");
   }

  outfile << "\n[Result: " << result << " ]\n\n";

  // set the board up from the starting position
  setboard(i_pos, 'w', 1);

  // play through the game and record the moves in a file
  for(int i = 1; i < TURN; i++)
   {
    print_move(game_pos, game_history[i-1], mstring);
    if (game_pos.wtm) outfile << (ceil(i/2) + 1) << ". " << mstring;
    else outfile << mstring;
    outfile << " ";
    if(!(T%8)) outfile << "\n";
    exec_move(&game_pos, game_history[i-1], 0);
    T++;
   }

   outfile << result;

}

// Function returns a 1 if a pondering session should be interrupted
int inter()
{
 if(!ponder && !analysis_mode && !xboard) return 0;

 if(cin.rdbuf() -> in_avail() > 1) return 1;
#if UNIX
 FD_ZERO(&read_fds);
 FD_SET(0,&read_fds);
 timeout.tv_sec = timeout.tv_usec = 0;
 select(1,&read_fds,NULL,NULL,&timeout);
 if((ponder || analysis_mode) && FD_ISSET(0,&read_fds)) return 1;
 else return 0;
#else
 static int init = 0, pipe;
 static HANDLE inh;
 DWORD dw;
 if(xboard) {     // winboard interrupt code taken from crafty
  if (!init) {
       init = 1;
       inh = GetStdHandle(STD_INPUT_HANDLE);
       pipe = !GetConsoleMode(inh, &dw);
       if (!pipe) {
         SetConsoleMode(inh, dw & ~(ENABLE_MOUSE_INPUT|ENABLE_WINDOW_INPUT));
         FlushConsoleInputBuffer(inh);
         FlushConsoleInputBuffer(inh);
       }
     }
  if(pipe) {
    if(!PeekNamedPipe(inh, NULL, 0, NULL, &dw, NULL)) return 1;
    return dw;
  } else {
    GetNumberOfConsoleInputEvents(inh, &dw);
    return dw <= 1 ? 0 : dw;
  }
 }
 if(kbhit()) return 1; else return 0;
#endif
}



/* Function to write search output */
// very simple and self-explanatory
void search_display(int score, int start_time, int node_count, int max_ply)
{
 char outstring[40], mstring[10];
 position p = game_pos;
 if(ponder) exec_move(&p, ponder_move, 0);

if(!xboard) {
 if(fail == 1) { cout << "  " << max_ply << ".   ++   ";  }
 if(fail == -1) { cout << "  " << max_ply << ".   --   \n"; return; }

 if(score < MATE/2 && score > -MATE/2) {
  sprintf(outstring, " %2i.  %5i ", max_ply, score);
 } else if (score >= MATE/2) {
  sprintf(outstring, " %2i.  MATE+ ", max_ply);
 } else {
  sprintf(outstring, " %2i.  MATE- ", max_ply);
 }
 if(!fail) cout << outstring;
 sprintf(outstring, " %4i %8d  ", time(NULL) - start_time, node_count);
 cout << outstring;
} else {
 if (fail == 1) {cout << "++\n"; return; }
 if (fail == -1) {cout << "--\n"; return; }

 sprintf(outstring, "  %2i  %5i ", max_ply, score);
 cout << outstring;
 sprintf(outstring, "%7i %6d ", (time(NULL) - start_time)*100, node_count);
 cout << outstring;
}

 int j = 0;
 if(!p.wtm && pc[0][0].t) {
  cout << " 1. ...";
  j++;
 }

 for (int i = 0; j < 24; i++, j++)
 {
   if (!(pc[0][i].t)) break;
   print_move(p, pc[0][i], mstring);
   if(!exec_move(&p,pc[0][i],0)) break;
   if((j == 8 || j == 16) && !xboard)
    cout << "\n                            ";
   if(!(j&1)) cout << " " << (j/2 + 1) << ".";
   cout << " " << mstring;
 }
 cout << "\n";
 cout.flush();

 if(tsuite) {
  int correct = 0;
  for(int e = 0; e < bmcount; e++) {
   if(pc[0][0].t == bmoves[e].t) { correct = 1; break; }
  }
  if(!correct) soltime = -1;
  if(correct && soltime == -1) soltime = time(NULL) - start_time;
 }

}


