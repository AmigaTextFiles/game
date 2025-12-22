/*
 *  SCOTT FREE
 *
 *  A free Scott Adams style adventure interpreter
 *
 *  Copyright:
 *      This software is placed under the GNU license.
 *
 *  Statement:
 *      Everything in this program has been deduced or obtained solely
 *  from published material. No game interpreter code has been
 *  disassembled, only published BASIC sources (PC-SIG, and Byte Dec
 *  1980) have been used.
 *
 *  ===================================================================
 *
 *  Version History AMIGA:
 *  Ver ,     Date,         Author, Comment
 *  -------------------------------------------------------------------
 *  1.0 , 28/07/96, Andreas Aumayr, First public release
 *  ___________________________________________________________________
 */

  
#define LIGHT_SOURCE    9       /* Always 9 how odd */
#define CARRIED         255     /* Carried */
#define DESTROYED       0       /* Destroyed */
#define DARKBIT         15
#define LIGHTOUTBIT     16      /* Light gone out */

#define MAX_PPR 16
#define MAX_LOG 4
 
typedef struct
{
	short Unknown;
	short NumItems;
	short NumActions;
	short NumWords;     /* Smaller of verb/noun is padded to same size */
	short NumRooms;
	short MaxCarry;
	short PlayerRoom;
	short Treasures;
	short WordLength;
	short LightTime;
	short NumMessages;
	short TreasureRoom;
} Header;

typedef struct
{
	unsigned short Vocab;
	unsigned short Condition[5];
	unsigned short Action[2];
} Action;

typedef struct
{
	char *Text;
	short Exits[6];
} Room;

typedef struct
{
	char *Text;
	/* PORTABILITY WARNING: THESE TWO MUST BE 8 BIT VALUES. */
	unsigned char Location;
	unsigned char InitialLoc;
	char *AutoGet;
} Item;

typedef struct
{
	short Version;
	short AdventureNumber;
	short Unknown;
} Tail;


/* These are used for GFX logic */
typedef struct {
	unsigned char what[MAX_PPR];
	//unsigned char or[MAX_PPR];
	//unsigned char and[MAX_PPR];
	unsigned char loc[MAX_PPR][MAX_LOG];
	unsigned char ppr;
	unsigned char obj[MAX_PPR][MAX_LOG];
	unsigned char pnr[MAX_PPR]; // pic number in sequence
	//unsigned char off[MAX_PPR];
} room_pics;

#define YOUARE      1   /* You are not I am */
#define SCOTTLIGHT  2   /* Authentic Scott Adams light messages */
#define DEBUGGING   4   /* Info from database load */
#define TRS80_STYLE 8   /* Display in style used on TRS-80 */
#define PREHISTORIC_LAMP 16 /* Destroy the lamp (very old databases) */

#define TRUE  1
#define FALSE 0


Header GameHeader;
Tail GameTail;
Item *Items;
Room *Rooms;
char **Verbs;
char **Nouns;
char **Messages;
Action *Actions;
int LightRefill;
char NounText[16];
int Counters[16];   /* Range unknown */
int CurrentCounter;
int SavedRoom;
int RoomSaved[16];  /* Range unknown */
int DisplayUp;      /* Curses up */
void *Top,*Bottom;
int Redraw;     /* Update item window */
int Options;        /* Option flags set */
int Width = 0;      /* Terminal width */
int TopHeight;      /* Height of top window */
int BottomHeight;   /* Height of bottom window */
long BitFlags=0;    /* Might be >32 flags - I haven't seen >32 yet */

#define MyLoc   (GameHeader.PlayerRoom)
#define TRS80_LINE "\n\n<------------------------------------------------------------->"

