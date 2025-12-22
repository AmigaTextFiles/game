#ifndef AMICHESS_CATALOG_H
#define AMICHESS_CATALOG_H 1

/* Locale Catalog Source File
 *
 * Automatically created by SimpleCat V2
 * Do NOT edit by hand!
 *
 * SimpleCat (C)1992-2006 Guido Mersmann
 *
 */



/****************************************************************************/


#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif

#ifdef CATCOMP_ARRAY
#undef CATCOMP_NUMBERS
#undef CATCOMP_STRINGS
#define CATCOMP_NUMBERS
#define CATCOMP_STRINGS
#endif

#ifdef CATCOMP_BLOCK
#undef CATCOMP_STRINGS
#define CATCOMP_STRINGS
#endif



/****************************************************************************/


#ifdef CATCOMP_NUMBERS

#define MSG_MENU_PROJECT 0
#define MSG_MENU_NEW 1
#define MSG_MENU_OPENEPD 2
#define MSG_MENU_OPENPGN 3
#define MSG_MENU_SAVEEPD 4
#define MSG_MENU_SAVEPGN 5
#define MSG_MENU_QUIT 6
#define MSG_MENU_GAME 7
#define MSG_MENU_AUTOPLAY 8
#define MSG_MENU_SUPERVISOR 9
#define MSG_MENU_SWAP 10
#define MSG_MENU_SWITCH 11
#define MSG_MENU_UNDO 12
#define MSG_MENU_REMOVE 13
#define MSG_MENU_BOOK 14
#define MSG_MENU_BOOKADD 15
#define MSG_MENU_BOOKOFF 16
#define MSG_MENU_BOOKON 17
#define MSG_MENU_BOOKBEST 18
#define MSG_MENU_BOOKWORST 19
#define MSG_MENU_BOOKRANDOM 20
#define MSG_MENU_DEPTH 21
#define MSG_MENU_DEPTH0 22
#define MSG_MENU_TIME 23
#define MSG_MENU_SHOWTHINKING 24
#define MSG_MENU_NULL 25
#define MSG_MENU_USEHASH 26
#define MSG_MENU_DISPLAY 27
#define MSG_MENU_BOARDSIZE 28
#define MSG_MENU_BOARDSMALL 29
#define MSG_MENU_BOARDMEDIUM 30
#define MSG_MENU_BOARDLARGE 31
#define MSG_MENU_BOARDDESIGN 32
#define MSG_MENU_PIECES 33
#define MSG_MENU_EDITBOARD 34
#define MSG_MENU_REVERSEBOARD 35
#define MSG_MENU_VOICE 36
#define MSG_MENU_HIDEMOVES 37
#define MSG_MENU_EXTRAS 38
#define MSG_MENU_EVALUATE 39
#define MSG_MENU_STATISTICS 40
#define MSG_END 41
#define MSG_MYMOVE 42
#define MSG_BESTLINE 43
#define MSG_WHITE 44
#define MSG_BLACK 45
#define MSG_TIMESETTINGS 46
#define MSG_MOVESIN 47
#define MSG_MINUTES 48
#define MSG_SEARCHITIME 49
#define MSG_PROMOTEPAWN 50
#define MSG_STATISTICS 51
#define MSG_STAT_INIT0 52
#define MSG_STAT_INIT1 53
#define MSG_STAT_INIT2 54
#define MSG_STAT_FORM0 55
#define MSG_STAT_FORM1 56
#define MSG_STAT_FORM2 57
#define MSG_POSEVAL 58
#define MSG_POSEVAL_INIT1 59
#define MSG_POSEVAL_INIT2 60
#define MSG_POSEVAL_INIT3 61
#define MSG_POSEVAL_FORM1 62
#define MSG_POSEVAL_FORM2 63
#define MSG_POSEVAL_FORM3 64
#define MSG_POSEVAL_FORM4 65
#define MSG_BOOK_OPENED 66
#define MSG_BOOK_NOTCONFORM 67
#define MSG_BOOK_READPOS 68
#define MSG_BOOK_NOTCREATE 69
#define MSG_BOOK_NOTWRITE 70
#define MSG_BOOK_CREATENEW 71
#define MSG_BOOK_NOTREAD 72
#define MSG_BOOK_GOTCOLLISIONS 73
#define MSG_BOOK_READING 74
#define MSG_BOOK_COLLISIONS 75
#define MSG_COMP_LOSEBLACK 76
#define MSG_COMP_LOSEWHITE 77
#define MSG_COMP_WINBLACK 78
#define MSG_COMP_WINWHITE 79
#define MSG_STALEMATE 80
#define MSG_DRAW 81
#define MSG_FROMBOOK 82
#define MSG_BOARDWRONG 83
#define MSG_NOTPOSSIBLE 84
#define MSG_SEARCHTIMESET 85
#define MSG_TIMECONTROL 86
#define MSG_EDITBOARD 87
#define MSG_EDITBOARD_CLEAR 88
#define MSG_OK 89

#endif /* CATCOMP_NUMBERS */


/****************************************************************************/


#ifdef CATCOMP_STRINGS

#define MSG_MENU_PROJECT_STR "Project"
#define MSG_MENU_NEW_STR "N\0New game"
#define MSG_MENU_OPENEPD_STR "Open EPD ..."
#define MSG_MENU_OPENPGN_STR "Open PGN ..."
#define MSG_MENU_SAVEEPD_STR "Save as EPD ..."
#define MSG_MENU_SAVEPGN_STR "Save as PGN ..."
#define MSG_MENU_QUIT_STR "Q\0Quit"
#define MSG_MENU_GAME_STR "Game"
#define MSG_MENU_AUTOPLAY_STR "A\0Autoplay"
#define MSG_MENU_SUPERVISOR_STR "V\0Supervisor"
#define MSG_MENU_SWAP_STR "W\0Swap sides"
#define MSG_MENU_SWITCH_STR "Switch sides"
#define MSG_MENU_UNDO_STR "U\0Undo"
#define MSG_MENU_REMOVE_STR "R\0Remove"
#define MSG_MENU_BOOK_STR "Book"
#define MSG_MENU_BOOKADD_STR "Add ..."
#define MSG_MENU_BOOKOFF_STR "Off"
#define MSG_MENU_BOOKON_STR "On"
#define MSG_MENU_BOOKBEST_STR "Best"
#define MSG_MENU_BOOKWORST_STR "Worst"
#define MSG_MENU_BOOKRANDOM_STR "Random"
#define MSG_MENU_DEPTH_STR "Search depth"
#define MSG_MENU_DEPTH0_STR "Use time settings"
#define MSG_MENU_TIME_STR "I\0Time settings"
#define MSG_MENU_SHOWTHINKING_STR "T\0Show thinking"
#define MSG_MENU_NULL_STR "Null moves"
#define MSG_MENU_USEHASH_STR "Use hashtable"
#define MSG_MENU_DISPLAY_STR "Display"
#define MSG_MENU_BOARDSIZE_STR "Board size"
#define MSG_MENU_BOARDSMALL_STR "1\0Small"
#define MSG_MENU_BOARDMEDIUM_STR "2\0Medium"
#define MSG_MENU_BOARDLARGE_STR "3\0Large"
#define MSG_MENU_BOARDDESIGN_STR "Board design"
#define MSG_MENU_PIECES_STR "Pieces"
#define MSG_MENU_EDITBOARD_STR "E\0Edit board ..."
#define MSG_MENU_REVERSEBOARD_STR "+\0Reverse board"
#define MSG_MENU_VOICE_STR "Voice"
#define MSG_MENU_HIDEMOVES_STR "#\0Hide move history"
#define MSG_MENU_EXTRAS_STR "Extras"
#define MSG_MENU_EVALUATE_STR "Evaluate"
#define MSG_MENU_STATISTICS_STR "Statistics"
#define MSG_END_STR "Dummy - END marker of menu"
#define MSG_MYMOVE_STR "My move"
#define MSG_BESTLINE_STR "Best line"
#define MSG_WHITE_STR "White"
#define MSG_BLACK_STR "Black"
#define MSG_TIMESETTINGS_STR "Time settings"
#define MSG_MOVESIN_STR "moves in"
#define MSG_MINUTES_STR "minutes"
#define MSG_SEARCHITIME_STR "Searchtime in sec"
#define MSG_PROMOTEPAWN_STR "Promote pawn to ..."
#define MSG_STATISTICS_STR "Statistics"
#define MSG_STAT_INIT0_STR "Nodes: 0 -> 0 per sec"
#define MSG_STAT_INIT1_STR "Moves: 0 -> 0 per sec"
#define MSG_STAT_INIT2_STR "Score: 0 <-> 0"
#define MSG_STAT_FORM0_STR "Nodes: %u -> %u per sec"
#define MSG_STAT_FORM1_STR "Moves: %u -> %u per sec"
#define MSG_STAT_FORM2_STR "Score: %d <-> %d"
#define MSG_POSEVAL_STR "Position evaluation"
#define MSG_POSEVAL_INIT1_STR "Material: 0/0  Development: 0"
#define MSG_POSEVAL_INIT2_STR "Pawn: 0  Knight: 0  Bishop: 0"
#define MSG_POSEVAL_INIT3_STR "Rook: 0  Queen: 0  King: 0"
#define MSG_POSEVAL_FORM1_STR "Material: %4d/%4d  Development: %d"
#define MSG_POSEVAL_FORM2_STR "Pawn: %d  Knight: %d  Bishop: %d"
#define MSG_POSEVAL_FORM3_STR "Rook: %d  Queen: %d  King: %d"
#define MSG_POSEVAL_FORM4_STR "Score: %d"
#define MSG_BOOK_OPENED_STR "Opened existing book!"
#define MSG_BOOK_NOTCONFORM_STR "Book does not conform to the current format. Consider rebuilding your book."
#define MSG_BOOK_READPOS_STR "Read %d book positions. Got %d hash collisions."
#define MSG_BOOK_NOTCREATE_STR "Couldn't create book."
#define MSG_BOOK_NOTWRITE_STR "Couldn't write to book."
#define MSG_BOOK_CREATENEW_STR "Created new book!"
#define MSG_BOOK_NOTREAD_STR "Couldn't open book for reading"
#define MSG_BOOK_GOTCOLLISIONS_STR "Got %d hash collisions."
#define MSG_BOOK_READING_STR "Reading opening book ..."
#define MSG_BOOK_COLLISIONS_STR "%d hash collisions..."
#define MSG_COMP_LOSEBLACK_STR "1-0: Computer loses as black"
#define MSG_COMP_LOSEWHITE_STR "0-1: Computer loses as white"
#define MSG_COMP_WINBLACK_STR "0-1: Computer wins as black"
#define MSG_COMP_WINWHITE_STR "1-0: Computer wins as white"
#define MSG_STALEMATE_STR "1/2-1/2: Stalemate"
#define MSG_DRAW_STR "1/2-1/2: Draw"
#define MSG_FROMBOOK_STR "From book."
#define MSG_BOARDWRONG_STR "Board is wrong!"
#define MSG_NOTPOSSIBLE_STR "Not possible in supervisor mode!"
#define MSG_SEARCHTIMESET_STR "Searchtime set to %.1f secs."
#define MSG_TIMECONTROL_STR "Time control: %d moves in %.1f secs."
#define MSG_EDITBOARD_STR "Edit board"
#define MSG_EDITBOARD_CLEAR_STR "Clear board"
#define MSG_OK_STR "Ok"

#endif /* CATCOMP_STRINGS */


/****************************************************************************/


#ifdef CATCOMP_ARRAY

struct CatCompArrayType
{
    LONG   cca_ID;
    STRPTR cca_Str;
};

static const struct CatCompArrayType CatCompArray[] =
{
    {MSG_MENU_PROJECT,(STRPTR)MSG_MENU_PROJECT_STR},
    {MSG_MENU_NEW,(STRPTR)MSG_MENU_NEW_STR},
    {MSG_MENU_OPENEPD,(STRPTR)MSG_MENU_OPENEPD_STR},
    {MSG_MENU_OPENPGN,(STRPTR)MSG_MENU_OPENPGN_STR},
    {MSG_MENU_SAVEEPD,(STRPTR)MSG_MENU_SAVEEPD_STR},
    {MSG_MENU_SAVEPGN,(STRPTR)MSG_MENU_SAVEPGN_STR},
    {MSG_MENU_QUIT,(STRPTR)MSG_MENU_QUIT_STR},
    {MSG_MENU_GAME,(STRPTR)MSG_MENU_GAME_STR},
    {MSG_MENU_AUTOPLAY,(STRPTR)MSG_MENU_AUTOPLAY_STR},
    {MSG_MENU_SUPERVISOR,(STRPTR)MSG_MENU_SUPERVISOR_STR},
    {MSG_MENU_SWAP,(STRPTR)MSG_MENU_SWAP_STR},
    {MSG_MENU_SWITCH,(STRPTR)MSG_MENU_SWITCH_STR},
    {MSG_MENU_UNDO,(STRPTR)MSG_MENU_UNDO_STR},
    {MSG_MENU_REMOVE,(STRPTR)MSG_MENU_REMOVE_STR},
    {MSG_MENU_BOOK,(STRPTR)MSG_MENU_BOOK_STR},
    {MSG_MENU_BOOKADD,(STRPTR)MSG_MENU_BOOKADD_STR},
    {MSG_MENU_BOOKOFF,(STRPTR)MSG_MENU_BOOKOFF_STR},
    {MSG_MENU_BOOKON,(STRPTR)MSG_MENU_BOOKON_STR},
    {MSG_MENU_BOOKBEST,(STRPTR)MSG_MENU_BOOKBEST_STR},
    {MSG_MENU_BOOKWORST,(STRPTR)MSG_MENU_BOOKWORST_STR},
    {MSG_MENU_BOOKRANDOM,(STRPTR)MSG_MENU_BOOKRANDOM_STR},
    {MSG_MENU_DEPTH,(STRPTR)MSG_MENU_DEPTH_STR},
    {MSG_MENU_DEPTH0,(STRPTR)MSG_MENU_DEPTH0_STR},
    {MSG_MENU_TIME,(STRPTR)MSG_MENU_TIME_STR},
    {MSG_MENU_SHOWTHINKING,(STRPTR)MSG_MENU_SHOWTHINKING_STR},
    {MSG_MENU_NULL,(STRPTR)MSG_MENU_NULL_STR},
    {MSG_MENU_USEHASH,(STRPTR)MSG_MENU_USEHASH_STR},
    {MSG_MENU_DISPLAY,(STRPTR)MSG_MENU_DISPLAY_STR},
    {MSG_MENU_BOARDSIZE,(STRPTR)MSG_MENU_BOARDSIZE_STR},
    {MSG_MENU_BOARDSMALL,(STRPTR)MSG_MENU_BOARDSMALL_STR},
    {MSG_MENU_BOARDMEDIUM,(STRPTR)MSG_MENU_BOARDMEDIUM_STR},
    {MSG_MENU_BOARDLARGE,(STRPTR)MSG_MENU_BOARDLARGE_STR},
    {MSG_MENU_BOARDDESIGN,(STRPTR)MSG_MENU_BOARDDESIGN_STR},
    {MSG_MENU_PIECES,(STRPTR)MSG_MENU_PIECES_STR},
    {MSG_MENU_EDITBOARD,(STRPTR)MSG_MENU_EDITBOARD_STR},
    {MSG_MENU_REVERSEBOARD,(STRPTR)MSG_MENU_REVERSEBOARD_STR},
    {MSG_MENU_VOICE,(STRPTR)MSG_MENU_VOICE_STR},
    {MSG_MENU_HIDEMOVES,(STRPTR)MSG_MENU_HIDEMOVES_STR},
    {MSG_MENU_EXTRAS,(STRPTR)MSG_MENU_EXTRAS_STR},
    {MSG_MENU_EVALUATE,(STRPTR)MSG_MENU_EVALUATE_STR},
    {MSG_MENU_STATISTICS,(STRPTR)MSG_MENU_STATISTICS_STR},
    {MSG_END,(STRPTR)MSG_END_STR},
    {MSG_MYMOVE,(STRPTR)MSG_MYMOVE_STR},
    {MSG_BESTLINE,(STRPTR)MSG_BESTLINE_STR},
    {MSG_WHITE,(STRPTR)MSG_WHITE_STR},
    {MSG_BLACK,(STRPTR)MSG_BLACK_STR},
    {MSG_TIMESETTINGS,(STRPTR)MSG_TIMESETTINGS_STR},
    {MSG_MOVESIN,(STRPTR)MSG_MOVESIN_STR},
    {MSG_MINUTES,(STRPTR)MSG_MINUTES_STR},
    {MSG_SEARCHITIME,(STRPTR)MSG_SEARCHITIME_STR},
    {MSG_PROMOTEPAWN,(STRPTR)MSG_PROMOTEPAWN_STR},
    {MSG_STATISTICS,(STRPTR)MSG_STATISTICS_STR},
    {MSG_STAT_INIT0,(STRPTR)MSG_STAT_INIT0_STR},
    {MSG_STAT_INIT1,(STRPTR)MSG_STAT_INIT1_STR},
    {MSG_STAT_INIT2,(STRPTR)MSG_STAT_INIT2_STR},
    {MSG_STAT_FORM0,(STRPTR)MSG_STAT_FORM0_STR},
    {MSG_STAT_FORM1,(STRPTR)MSG_STAT_FORM1_STR},
    {MSG_STAT_FORM2,(STRPTR)MSG_STAT_FORM2_STR},
    {MSG_POSEVAL,(STRPTR)MSG_POSEVAL_STR},
    {MSG_POSEVAL_INIT1,(STRPTR)MSG_POSEVAL_INIT1_STR},
    {MSG_POSEVAL_INIT2,(STRPTR)MSG_POSEVAL_INIT2_STR},
    {MSG_POSEVAL_INIT3,(STRPTR)MSG_POSEVAL_INIT3_STR},
    {MSG_POSEVAL_FORM1,(STRPTR)MSG_POSEVAL_FORM1_STR},
    {MSG_POSEVAL_FORM2,(STRPTR)MSG_POSEVAL_FORM2_STR},
    {MSG_POSEVAL_FORM3,(STRPTR)MSG_POSEVAL_FORM3_STR},
    {MSG_POSEVAL_FORM4,(STRPTR)MSG_POSEVAL_FORM4_STR},
    {MSG_BOOK_OPENED,(STRPTR)MSG_BOOK_OPENED_STR},
    {MSG_BOOK_NOTCONFORM,(STRPTR)MSG_BOOK_NOTCONFORM_STR},
    {MSG_BOOK_READPOS,(STRPTR)MSG_BOOK_READPOS_STR},
    {MSG_BOOK_NOTCREATE,(STRPTR)MSG_BOOK_NOTCREATE_STR},
    {MSG_BOOK_NOTWRITE,(STRPTR)MSG_BOOK_NOTWRITE_STR},
    {MSG_BOOK_CREATENEW,(STRPTR)MSG_BOOK_CREATENEW_STR},
    {MSG_BOOK_NOTREAD,(STRPTR)MSG_BOOK_NOTREAD_STR},
    {MSG_BOOK_GOTCOLLISIONS,(STRPTR)MSG_BOOK_GOTCOLLISIONS_STR},
    {MSG_BOOK_READING,(STRPTR)MSG_BOOK_READING_STR},
    {MSG_BOOK_COLLISIONS,(STRPTR)MSG_BOOK_COLLISIONS_STR},
    {MSG_COMP_LOSEBLACK,(STRPTR)MSG_COMP_LOSEBLACK_STR},
    {MSG_COMP_LOSEWHITE,(STRPTR)MSG_COMP_LOSEWHITE_STR},
    {MSG_COMP_WINBLACK,(STRPTR)MSG_COMP_WINBLACK_STR},
    {MSG_COMP_WINWHITE,(STRPTR)MSG_COMP_WINWHITE_STR},
    {MSG_STALEMATE,(STRPTR)MSG_STALEMATE_STR},
    {MSG_DRAW,(STRPTR)MSG_DRAW_STR},
    {MSG_FROMBOOK,(STRPTR)MSG_FROMBOOK_STR},
    {MSG_BOARDWRONG,(STRPTR)MSG_BOARDWRONG_STR},
    {MSG_NOTPOSSIBLE,(STRPTR)MSG_NOTPOSSIBLE_STR},
    {MSG_SEARCHTIMESET,(STRPTR)MSG_SEARCHTIMESET_STR},
    {MSG_TIMECONTROL,(STRPTR)MSG_TIMECONTROL_STR},
    {MSG_EDITBOARD,(STRPTR)MSG_EDITBOARD_STR},
    {MSG_EDITBOARD_CLEAR,(STRPTR)MSG_EDITBOARD_CLEAR_STR},
    {MSG_OK,(STRPTR)MSG_OK_STR},
};

#endif /* CATCOMP_ARRAY */


/****************************************************************************/


#ifdef CATCOMP_BLOCK

static const char CatCompBlock[] =
{
    "\x00\x00\x00\x00\x00\x08"
    MSG_MENU_PROJECT_STR "\x00"
    "\x00\x00\x00\x01\x00\x0C"
    MSG_MENU_NEW_STR "\x00\x00"
    "\x00\x00\x00\x02\x00\x0E"
    MSG_MENU_OPENEPD_STR "\x00\x00"
    "\x00\x00\x00\x03\x00\x0E"
    MSG_MENU_OPENPGN_STR "\x00\x00"
    "\x00\x00\x00\x04\x00\x10"
    MSG_MENU_SAVEEPD_STR "\x00"
    "\x00\x00\x00\x05\x00\x10"
    MSG_MENU_SAVEPGN_STR "\x00"
    "\x00\x00\x00\x06\x00\x08"
    MSG_MENU_QUIT_STR "\x00\x00"
    "\x00\x00\x00\x07\x00\x06"
    MSG_MENU_GAME_STR "\x00\x00"
    "\x00\x00\x00\x08\x00\x0C"
    MSG_MENU_AUTOPLAY_STR "\x00\x00"
    "\x00\x00\x00\x09\x00\x0E"
    MSG_MENU_SUPERVISOR_STR "\x00\x00"
    "\x00\x00\x00\x0A\x00\x0E"
    MSG_MENU_SWAP_STR "\x00\x00"
    "\x00\x00\x00\x0B\x00\x0E"
    MSG_MENU_SWITCH_STR "\x00\x00"
    "\x00\x00\x00\x0C\x00\x08"
    MSG_MENU_UNDO_STR "\x00\x00"
    "\x00\x00\x00\x0D\x00\x0A"
    MSG_MENU_REMOVE_STR "\x00\x00"
    "\x00\x00\x00\x0E\x00\x06"
    MSG_MENU_BOOK_STR "\x00\x00"
    "\x00\x00\x00\x0F\x00\x08"
    MSG_MENU_BOOKADD_STR "\x00"
    "\x00\x00\x00\x10\x00\x04"
    MSG_MENU_BOOKOFF_STR "\x00"
    "\x00\x00\x00\x11\x00\x04"
    MSG_MENU_BOOKON_STR "\x00\x00"
    "\x00\x00\x00\x12\x00\x06"
    MSG_MENU_BOOKBEST_STR "\x00\x00"
    "\x00\x00\x00\x13\x00\x06"
    MSG_MENU_BOOKWORST_STR "\x00"
    "\x00\x00\x00\x14\x00\x08"
    MSG_MENU_BOOKRANDOM_STR "\x00\x00"
    "\x00\x00\x00\x15\x00\x0E"
    MSG_MENU_DEPTH_STR "\x00\x00"
    "\x00\x00\x00\x16\x00\x12"
    MSG_MENU_DEPTH0_STR "\x00"
    "\x00\x00\x00\x17\x00\x10"
    MSG_MENU_TIME_STR "\x00"
    "\x00\x00\x00\x18\x00\x10"
    MSG_MENU_SHOWTHINKING_STR "\x00"
    "\x00\x00\x00\x19\x00\x0C"
    MSG_MENU_NULL_STR "\x00\x00"
    "\x00\x00\x00\x1A\x00\x0E"
    MSG_MENU_USEHASH_STR "\x00"
    "\x00\x00\x00\x1B\x00\x08"
    MSG_MENU_DISPLAY_STR "\x00"
    "\x00\x00\x00\x1C\x00\x0C"
    MSG_MENU_BOARDSIZE_STR "\x00\x00"
    "\x00\x00\x00\x1D\x00\x08"
    MSG_MENU_BOARDSMALL_STR "\x00"
    "\x00\x00\x00\x1E\x00\x0A"
    MSG_MENU_BOARDMEDIUM_STR "\x00\x00"
    "\x00\x00\x00\x1F\x00\x08"
    MSG_MENU_BOARDLARGE_STR "\x00"
    "\x00\x00\x00\x20\x00\x0E"
    MSG_MENU_BOARDDESIGN_STR "\x00\x00"
    "\x00\x00\x00\x21\x00\x08"
    MSG_MENU_PIECES_STR "\x00\x00"
    "\x00\x00\x00\x22\x00\x12"
    MSG_MENU_EDITBOARD_STR "\x00\x00"
    "\x00\x00\x00\x23\x00\x10"
    MSG_MENU_REVERSEBOARD_STR "\x00"
    "\x00\x00\x00\x24\x00\x06"
    MSG_MENU_VOICE_STR "\x00"
    "\x00\x00\x00\x25\x00\x14"
    MSG_MENU_HIDEMOVES_STR "\x00"
    "\x00\x00\x00\x26\x00\x08"
    MSG_MENU_EXTRAS_STR "\x00\x00"
    "\x00\x00\x00\x27\x00\x0A"
    MSG_MENU_EVALUATE_STR "\x00\x00"
    "\x00\x00\x00\x28\x00\x0C"
    MSG_MENU_STATISTICS_STR "\x00\x00"
    "\x00\x00\x00\x29\x00\x1C"
    MSG_END_STR "\x00\x00"
    "\x00\x00\x00\x2A\x00\x08"
    MSG_MYMOVE_STR "\x00"
    "\x00\x00\x00\x2B\x00\x0A"
    MSG_BESTLINE_STR "\x00"
    "\x00\x00\x00\x2C\x00\x06"
    MSG_WHITE_STR "\x00"
    "\x00\x00\x00\x2D\x00\x06"
    MSG_BLACK_STR "\x00"
    "\x00\x00\x00\x2E\x00\x0E"
    MSG_TIMESETTINGS_STR "\x00"
    "\x00\x00\x00\x2F\x00\x0A"
    MSG_MOVESIN_STR "\x00\x00"
    "\x00\x00\x00\x30\x00\x08"
    MSG_MINUTES_STR "\x00"
    "\x00\x00\x00\x31\x00\x12"
    MSG_SEARCHITIME_STR "\x00"
    "\x00\x00\x00\x32\x00\x14"
    MSG_PROMOTEPAWN_STR "\x00"
    "\x00\x00\x00\x33\x00\x0C"
    MSG_STATISTICS_STR "\x00\x00"
    "\x00\x00\x00\x34\x00\x16"
    MSG_STAT_INIT0_STR "\x00"
    "\x00\x00\x00\x35\x00\x16"
    MSG_STAT_INIT1_STR "\x00"
    "\x00\x00\x00\x36\x00\x10"
    MSG_STAT_INIT2_STR "\x00\x00"
    "\x00\x00\x00\x37\x00\x18"
    MSG_STAT_FORM0_STR "\x00"
    "\x00\x00\x00\x38\x00\x18"
    MSG_STAT_FORM1_STR "\x00"
    "\x00\x00\x00\x39\x00\x12"
    MSG_STAT_FORM2_STR "\x00\x00"
    "\x00\x00\x00\x3A\x00\x14"
    MSG_POSEVAL_STR "\x00"
    "\x00\x00\x00\x3B\x00\x1E"
    MSG_POSEVAL_INIT1_STR "\x00"
    "\x00\x00\x00\x3C\x00\x1E"
    MSG_POSEVAL_INIT2_STR "\x00"
    "\x00\x00\x00\x3D\x00\x1C"
    MSG_POSEVAL_INIT3_STR "\x00\x00"
    "\x00\x00\x00\x3E\x00\x24"
    MSG_POSEVAL_FORM1_STR "\x00\x00"
    "\x00\x00\x00\x3F\x00\x22"
    MSG_POSEVAL_FORM2_STR "\x00\x00"
    "\x00\x00\x00\x40\x00\x1E"
    MSG_POSEVAL_FORM3_STR "\x00"
    "\x00\x00\x00\x41\x00\x0A"
    MSG_POSEVAL_FORM4_STR "\x00"
    "\x00\x00\x00\x42\x00\x16"
    MSG_BOOK_OPENED_STR "\x00"
    "\x00\x00\x00\x43\x00\x4C"
    MSG_BOOK_NOTCONFORM_STR "\x00"
    "\x00\x00\x00\x44\x00\x30"
    MSG_BOOK_READPOS_STR "\x00"
    "\x00\x00\x00\x45\x00\x16"
    MSG_BOOK_NOTCREATE_STR "\x00"
    "\x00\x00\x00\x46\x00\x18"
    MSG_BOOK_NOTWRITE_STR "\x00"
    "\x00\x00\x00\x47\x00\x12"
    MSG_BOOK_CREATENEW_STR "\x00"
    "\x00\x00\x00\x48\x00\x20"
    MSG_BOOK_NOTREAD_STR "\x00\x00"
    "\x00\x00\x00\x49\x00\x18"
    MSG_BOOK_GOTCOLLISIONS_STR "\x00"
    "\x00\x00\x00\x4A\x00\x1A"
    MSG_BOOK_READING_STR "\x00\x00"
    "\x00\x00\x00\x4B\x00\x16"
    MSG_BOOK_COLLISIONS_STR "\x00"
    "\x00\x00\x00\x4C\x00\x1E"
    MSG_COMP_LOSEBLACK_STR "\x00\x00"
    "\x00\x00\x00\x4D\x00\x1E"
    MSG_COMP_LOSEWHITE_STR "\x00\x00"
    "\x00\x00\x00\x4E\x00\x1C"
    MSG_COMP_WINBLACK_STR "\x00"
    "\x00\x00\x00\x4F\x00\x1C"
    MSG_COMP_WINWHITE_STR "\x00"
    "\x00\x00\x00\x50\x00\x14"
    MSG_STALEMATE_STR "\x00\x00"
    "\x00\x00\x00\x51\x00\x0E"
    MSG_DRAW_STR "\x00"
    "\x00\x00\x00\x52\x00\x0C"
    MSG_FROMBOOK_STR "\x00\x00"
    "\x00\x00\x00\x53\x00\x10"
    MSG_BOARDWRONG_STR "\x00"
    "\x00\x00\x00\x54\x00\x22"
    MSG_NOTPOSSIBLE_STR "\x00\x00"
    "\x00\x00\x00\x55\x00\x1E"
    MSG_SEARCHTIMESET_STR "\x00\x00"
    "\x00\x00\x00\x56\x00\x26"
    MSG_TIMECONTROL_STR "\x00\x00"
    "\x00\x00\x00\x57\x00\x0C"
    MSG_EDITBOARD_STR "\x00\x00"
    "\x00\x00\x00\x58\x00\x0C"
    MSG_EDITBOARD_CLEAR_STR "\x00"
    "\x00\x00\x00\x59\x00\x04"
    MSG_OK_STR "\x00\x00"
};

#endif /* CATCOMP_BLOCK */


/****************************************************************************/



struct LocaleInfo
{
    APTR li_LocaleBase;
    APTR li_Catalog;
};





#ifdef CATCOMP_CODE

#include <libraries/locale.h>
#include <proto/locale.h>


STRPTR GetString(struct LocaleInfo *li, LONG stringNum)
{
LONG   *l;
UWORD  *w;
STRPTR  builtIn;

    l = (LONG *)CatCompBlock;

    while (*l != stringNum)
    {
        w = (UWORD *)((ULONG)l + 4);
        l = (LONG *)((ULONG)l + (ULONG)*w + 6);
    }
    builtIn = (STRPTR)((ULONG)l + 6);

#undef LocaleBase
#define LocaleBase li->li_LocaleBase
    
    if (LocaleBase)
        return(GetCatalogStr(li->li_Catalog,stringNum,builtIn));
#undef LocaleBase

    return(builtIn);
}


#endif /* CATCOMP_CODE */



/****************************************************************************/



#endif /* AMICHESS_CATALOG_H */

