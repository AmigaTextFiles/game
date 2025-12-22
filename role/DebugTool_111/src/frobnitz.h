/****************************************************************/
/*     Infocom DebugTool                                        */
/*     written in April 1992                                    */
/*     compiled with Aztec-C 5.2a                               */
/*                                                              */
/*        v0.50:  5/ 4/92                                       */
/*        v0.60: 17/ 4/92                                       */
/*        v0.61: 27/ 4/92                                       */
/*        v0.62: 28/ 4/92                                       */
/*        v0.63: 14/ 5/92                                       */
/*        v0.70: 17/ 5/92                                       */
/*        v1.00: 31/ 5/92                                       */
/*        v1.01: 18/ 7/92                                       */
/*        v1.02: 25/ 7/92                                       */
/*        v1.03:  4/ 8/92                                       */
/*        v1.10:  1/11/92                                       */
/*        v1.11:  6/ 5/93                                       */
/*                                                              */
/*     Contact me:                      Paul D. Doherty         */
/*                                      Lindenallee 4           */
/*                                      O-1120 Berlin           */
/*                                      Germany                 */
/*                                                              */
/*     E-mail:  h0142kdd@rz.hu-berlin.de                        */
/*     or       d.doherty@bamp.berlinet.in-berlin.de            */
/****************************************************************/


/****************************************************************/
/*     DEFINES                                                  */
/****************************************************************/

#define VERSTAG "\0$VER: Dave Doherty's Infocom Debugging Tool 1.11 (6.5.93)"
#define STAMP   "Infocom Datafile Debug Tool 1.11"
#define BUGGY   "[That's not a feature - it's a BUG!]"

#define MAXLEN_ENCSTR 1024
#define MAXLEN_DECSTR 1024
#define MAXLEN_INFILE 80
#define MAXLEN_MACRO 30
#define MAXLEN_OBJECT 40
#define MAXNUM_OBJECT 650

#define NUM_PROPS_OLD 31
#define NUM_PROPS_NEW 63


/****************************************************************/
/*     INCLUDES                                                 */
/****************************************************************/

#include <stdio.h>
#include <stdlib.h>


/*****************************************************************/
/*     TYPE DEFINITIONS                                          */
/*****************************************************************/

typedef unsigned char byte;
typedef unsigned short word;
typedef unsigned short z_word;


/*****************************************************************/
/*     HEADER STRUCTURE                                          */
/*****************************************************************/

struct info_header
{
  byte z_version;
  /*
   * 1,2,3:  ZIP ("standard")
   * 4    : EZIP ("plus")
   * 5    : XZIP ("Solid Gold")
   * 6    : YZIP ("graphics")
   */
  byte zip_flags;
  /*
   * flag 0  0x01  byte swapped game           V3/4
   *               ZIP supports colours        V5+
   * flag 1  0x02  TIME Status Line            V3   (not set == SCORE)
   *               ??                          V4+
   * flag 2  0x04  Maximize data area to 64K   V4+
   * flag 3  0x08  Licensed to Tandy           V3
   *               ZIP supports underlines     V4+
   * flag 4  0x10  ZIP has no status line
   * flag 5  0x20  ZIP supports status window  V3
   * flag 6  0x40  ZIP supports PropFonts (??) V3
   */
  z_word release;
  z_word resident_size;
  z_word game_offset;
  z_word vocab_offset;
  z_word object_offset;
  z_word variable_offset;
  z_word save_area_size;

  z_word game_flags;
  /*
   * flag 0  0x01  Scripting is on
   * flag 1  0x02  Use fixed-width fonts       V3
   * flag 2  0x04  Refresh screen after Save/Restore
   * flag 3  0x08  Game has graphics           V5+
   * flag 4  0x10  Game has sound              V3
   *               Game has undo               V5+
   * flag 5  0x20  Game supports mice (??)     V5+
   * flag 6  0x40  Game has colour             V5
   * flag 7  0x80  Game has sound              V5
   * flag 8  0x100 No command line
   */

  char rev_date[6];

  z_word macro_offset;
  z_word verify_length;
  z_word verify_checksum;

  byte zmach_version;
  byte zmach_subversion;

  byte screen_rows;
  byte screen_columns;
  byte screen_left;
  byte screen_right;
  byte screen_top;
  byte screen_bottom;

  byte max_char_width;
  byte max_char_height;

  z_word unknown0;    /* graphix ? */
  z_word unknown1;    /* graphix ? */
  z_word unknown2;    /* COLOURS ? only saved */
  z_word fkey_offset;
  z_word unknown4;    /* not used */
  z_word unknown5;    /* not used */
  z_word alfabet_offset;
  z_word mouse_offset;

  char user_name[8];
};


/*****************************************************************/
/*     GLOBAL VARIABLES                                          */
/*****************************************************************/

/*
 *	extern.c
 */

extern struct info_header header;

extern byte header_level;
extern byte old_header;
extern byte is_savefile;

extern byte game_print;
extern byte header_print;
extern byte alphabet_print;
extern byte macros_print;
extern byte object_print;
extern byte tree_print;
extern byte var_print;
extern byte vocab_print;
extern byte do_check;

extern char EncodedString[MAXLEN_ENCSTR];
extern char DecodedString[MAXLEN_DECSTR];
extern char MacroString[MAXLEN_MACRO];
extern int PrintedChars;

extern byte no_enum;
extern byte no_attr;
extern byte dec_enum;
extern byte no_props;

extern FILE *DatFile;
extern char FilStr[MAXLEN_INFILE];

extern char alphabet[3][26];
extern short int alph_read;

extern char macros[3 * 32][MAXLEN_MACRO];
extern short int macros_read;

extern unsigned char object_table[MAXNUM_OBJECT][14];
extern short int objects_read;
extern long objects_count;


/*****************************************************************/
/*     FUNCTION PROTOTYPES                                       */
/*****************************************************************/

/*
 *	alphabet.c
 */

void ReadAlphabet (void);
void PrintAlphabet (void);

/*
 *	check.c
 */

void PerformCheck (void);

/*
 *	decode.c
 */

void StringDecode (void);
int ExChar (int);
void DecodeReset (void);

/*
 *	header.c
 */

void ReadHeader (void);
void CheckHeader (void);
void PrintHeader (void);
void HeaderLevel (void);
void IsSavefile (void);
void SwapHeader (void);

/*
 *	macros.c
 */

void ReadMacros (void);
void PrintMacros (void);
void PrintMacro (int, int);
int MacroLength (int, int);

/*
 *	main.c
 */

/*
 *	object.c
 */

void ReadObjects (void);
void PrintObjects (void);
void PrintObject (int);
void PrintDefProperties (void);
void PrintProperties (int);

/*
 *	recog.c
 */

int WhichGame (void);
void PrintGame (int);

/*
 *	stuffing.c
 */

void seek_pos (z_word);
void newline (void);
int power (int, int);
void parse (char *);
void parse_opt (char);
void quit (int);
void error (int);
void helptxt (void);
z_word byteswap (z_word);

/*
 *	tree.c
 */

void PrintTree (void);
void ChainObj (unsigned long);

/*
 *	vars.c
 */

void PrintVars (void);

/*
 *	vocab.c
 */

void PrintVocab (void);
