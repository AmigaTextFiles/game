#include "frobnitz.h"

/*****************************************************************/
/*     ONLY GLOBAL VARIABLES !                                   */
/*****************************************************************/

struct info_header header;

byte header_level;
byte old_header;
byte is_savefile;

byte game_print;
byte header_print;
byte alphabet_print;
byte macros_print;
byte object_print;
byte tree_print;
byte var_print;
byte vocab_print;
byte do_check;

char EncodedString[MAXLEN_ENCSTR];
char DecodedString[MAXLEN_DECSTR];
char MacroString[MAXLEN_MACRO];
int PrintedChars;

byte no_enum;
byte no_attr;
byte dec_enum;
byte no_props;

/*
 *	for file:
 */

FILE *DatFile;
char FilStr[MAXLEN_INFILE];

/*
 *	for alphabet:
 */

char alphabet[3][26];
short int alph_read;

/*
 *	for macros:
 */

char macros[3 * 32][MAXLEN_MACRO];
short int macros_read;

/*
 *	for objects:
 */

unsigned char object_table[MAXNUM_OBJECT][14];
short int objects_read;
long objects_count;
