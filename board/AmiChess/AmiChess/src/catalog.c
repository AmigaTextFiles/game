#include <clib/locale_protos.h>
#include "catalog.h"

extern struct Catalog *catalog;

static char *english[]=
{
"Project", /* MSG_MENU_PROJECT */
"N\0New game", /* MSG_MENU_NEW */
"Open EPD ...", /* MSG_MENU_OPENEPD */
"Open PGN ...", /* MSG_MENU_OPENPGN */
"Save as EPD ...", /* MSG_MENU_SAVEEPD */
"Save as PGN ...", /* MSG_MENU_SAVEPGN */
"Q\0Quit", /* MSG_MENU_QUIT */
"Game", /* MSG_MENU_GAME */
"A\0Autoplay", /* MSG_MENU_AUTOPLAY */
"V\0Supervisor", /* MSG_MENU_SUPERVISOR */
"W\0Swap sides", /* MSG_MENU_SWAP */
"Switch sides", /* MSG_MENU_SWITCH */
"U\0Undo", /* MSG_MENU_UNDO */
"R\0Remove", /* MSG_MENU_REMOVE */
"Book", /* MSG_MENU_BOOK */
"Add ...", /* MSG_MENU_BOOKADD */
"Off", /* MSG_MENU_BOOKOFF */
"On", /* MSG_MENU_BOOKON */
"Best", /* MSG_MENU_BOOKBEST */
"Worst", /* MSG_MENU_BOOKWORST */
"Random", /* MSG_MENU_BOOKRANDOM */
"Search depth", /* MSG_MENU_DEPTH */
"Use time settings", /* MSG_MENU_DEPTH0 */
"Time settings", /* MSG_MENU_TIME */
"T\0Show thinking", /* MSG_MENU_SHOWTHINKING */
"Null moves", /* MSG_MENU_NULL */
"Use hashtable", /* MSG_MENU_USEHASH */
"Display", /* MSG_MENU_DISPLAY */
"Board size", /* MSG_MENU_BOARDSIZE */
"1\0Small", /* MSG_MENU_BOARDSMALL */
"2\0Medium", /* MSG_MENU_BOARDMEDIUM */
"3\0Large", /* MSG_MENU_BOARDLARGE */
"Board design", /* MSG_MENU_BOARDDESIGN */
"Pieces", /* MSG_MENU_PIECES */
"E\0Edit board ...", /* MSG_MENU_EDITBOARD */
"+\0Reverse board", /* MSG_MENU_REVERSEBOARD */
"Voice", /* MSG_MENU_VOICE */
"Extras", /* MSG_MENU_EXTRAS */
"Evaluate", /* MSG_MENU_EVALUATE */
"Statistics", /* MSG_MENU_STATISTICS */
0,
"My move", /* MSG_MYMOVE */
"Best line", /* MSG_BESTLINE */
"White", /* MSG_WHITE */
"Black", /* MSG_BLACK */
"Time settings", /* MSG_TIMESETTINGS */
"moves in", /* MSG_MOVESIN */
"minutes", /* MSG_MINUTES */
"Searchtime in sec", /* MSG_SEARCHITIME */
"Promote pawn to ...", /* MSG_PROMOTEPAWN */
"Statistics", /* MSG_STATISTICS */
"Nodes: 0 -> 0 per sec", /* MSG_STAT_INIT0 */
"Moves: 0 -> 0 per sec", /* MSG_STAT_INIT1 */
"Score: 0 <-> 0", /* MSG_STAT_INIT2 */
"Nodes: %u -> %u per sec", /* MSG_STAT_FORM0 */
"Moves: %u -> %u per sec", /* MSG_STAT_FORM1 */
"Score: %d <-> %d", /* MSG_STAT_FORM2 */
"Position evaluation", /* MSG_POSEVAL */
"Material: 0/0  Development: 0", /* MSG_POSEVAL_INIT1 */
"Pawn: 0  Knight: 0  Bishop: 0", /* MSG_POSEVAL_INIT2 */
"Rook: 0  Queen: 0  King: 0", /* MSG_POSEVAL_INIT3 */
"Material: %4d/%4d  Development: %d", /* MSG_POSEVAL_FORM1 */
"Pawn: %d  Knight: %d  Bishop: %d", /* MSG_POSEVAL_FORM2 */
"Rook: %d  Queen: %d  King: %d", /* MSG_POSEVAL_FORM3 */
"Score: %d", /* MSG_POSEVAL_FORM4 */
"Opened existing book!", /* MSG_BOOK_OPENED */
"Book does not conform to the current format. Consider rebuilding your book.", /* MSG_BOOK_NOTCONFORM */
"Read %d book positions. Got %d hash collisions.", /* MSG_BOOK_READPOS */
"Couldn't create book.", /* MSG_BOOK_NOTCREATE */
"Couldn't write to book.",/* MSG_BOOK_NOTWRITE */
"Created new book!", /* MSG_BOOK_CREATENEW */
"Couldn't open book for reading", /* MSG_BOOK_NOTREAD */
"Got %d hash collisions.", /* MSG_BOOK_GOTCOLLISIONS */
"Reading opening book ...", /* MSG_BOOK_READING */
"%d hash collisions...", /* MSG_BOOK_COLLISIONS */
"1-0: Computer loses as black", /* MSG_COMP_LOSEBLACK */
"0-1: Computer loses as white", /* MSG_COMP_LOSEWHITE */
"0-1: Computer wins as black", /* MSG_COMP_WINBLACK */
"1-0: Computer wins as white", /* MSG_COMP_WINWHITE */
"1/2-1/2: Stalemate", /* MSG_STALEMATE */
"1/2-1/2: Draw", /* MSG_DRAW */
"From book.", /* MSG_FROMBOOK */
"Board is wrong!", /* MSG_BOARDWRONG */
"Not possible in supervisor mode!", /* MSG_NOTPOSSIBLE */
"Searchtime set to %.1f secs.", /* MSG_SEARCHTIMESET */
"Time control: %d moves in %.1f secs." /* MSG_TIMECONTROL */
};

char *getstr(unsigned long num)
{
return GetCatalogStr(catalog,num,english[num]);
}

