#define GD_SCORE		0
#define GD_HUMAN		1
#define GD_AMIGA		2
#define MAXBOARDSIZE	31
#define BOXSIZE			16
#define EMPTY			0
#define HUMAN			1
#define AMIGA			2
#define LEVEL5			0
#define LEVEL4			0.05
#define LEVEL3			0.15
#define LEVEL2			0.25
#define LEVEL1			0.35
#define LEVELTEXT5		"FiveInLine - (Level 5 - A winner)"
#define LEVELTEXT4		"FiveInLine - (Level 4 - Good)"
#define LEVELTEXT3		"FiveInLine - (Level 3 - Average)"
#define LEVELTEXT2		"FiveInLine - (Level 2 - Poor)"
#define LEVELTEXT1		"FiveInLine - (Level 1 - Born loser)"

int		setupscreen ( void );
void 	closedownscreen ( void );

int 	openreqtools ( void );
void 	closereqtools ( void );
BOOL 	reqbegin ( void );
void 	showresult ( char * );
int 	showabout ( void );

int		setupwindow ( void );
void 	drawboard ( void );
int 	handleidcmp ( int * , int, BOOL *, FLOAT * );
int 	handlemousebuttons ( struct IntuiMessage * , int *, int );
void 	closedownwindow ( BOOL * );

int 	initnewgame ( void );
int 	amigamove ( int *, int * , FLOAT );
int 	checkdrawgame ( void );
void 	findmove ( int *, int *, FLOAT );
void 	makemove ( int, int, BOOL * );
