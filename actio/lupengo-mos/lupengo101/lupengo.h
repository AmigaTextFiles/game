///////////////////////////////////////////////////////////////////////////////
// File         : lupengo.h
// Info         : Main header file
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <ctype.h>

#include <SDL.h>
#include <SDL_timer.h>

#define _(S) (S)

#define BX0	1
#define BY0	1
#define BX1	15
#define BY1	17

#define BLANK		0
#define CARLONID	1
#define CARLONIL	2
#define CARLONIR	3
#define CARLONIU	4
#define PIGD		5
#define PIGL		6
#define PIGR		7
#define PIGU		8
#define LUPONED		9
#define LUPONEL		10
#define LUPONER		11
#define LUPONEU		12
#define DEAD		13
#define DEAD2		14
#define DOWN		15
#define HALFDOWN	16
#define BLACK		17
#define ICEX		18
#define ICEY		19
#define EGG		20
#define WALL		21
#define TRIS		22
#define BORDER		23
#define EGGWALL		24
#define MONSTER		25
#define LITFLAG		26
#define BIGFLAG		27
#define LITEGG		28
#define BIGEGG		29
#define EGGBREAK1	30
#define EGGBREAK2	31
#define EGGCRASH	32
#define MYCRASH		33
#define ENCRASH		34
#define W400		35
#define W1600		36
#define W6400		37
#define W25600		38
#define T1		39
#define T2		40
#define T3		41
#define T4		42
#define FADE1		43
#define FADE2		44
#define CIRCLE1		45
#define CIRCLE2		46
#define CIRCLE3		47
#define CIRCLE4		48
#define BRICKS		49
#define C0		50
#define C9		59
#define CA		60
#define CZ		85
#define CSPACE		86
#define TITLESCR	87

#define CIRCLEMIN	CIRCLE1
#define CIRCLEMAX	CIRCLE4

#define CHARMIN		C0
#define CHARMAX		CSPACE

#define NPICS		88
#define PICSIZEX	36
#define PICSIZEY	20

#define MAXNAMELEN	16

#define MAXPLAYERS	2

#define GAMETYPES		2
#define GAMETYPE_SINGLE	0
#define GAMETYPE_TEAM	1

#define STATUS_ATTRACT		0
#define STATUS_PLAYING		1
#define STATUS_DISPLAY		2
#define STATUS_PLAYDEMO		3
#define STATUS_ENTER_NAME	4
#define STATUS_TITLE_SCR	5

#define DEMO_NULL		0
#define DEMO_READING	1
#define DEMO_WRITING	2

// Flags for PictureDisplayText
#define DF_NOWAIT	0x01
#define DF_BOTTOM	0x02

// Flags for PictureWriteString
#define WSF_RIGHTALIGN	0x01
#define WSF_CENTERALIGN	0x02

extern char
	strpaused[], strscore[], strlevel[], strnobody[], stranon[], strpoints[],
	strgameover[], strgofornext[],
	strnomoreroom[], strendofdemo[], strnodemofile[],
	strcrushen[], strstunen[], str3inarow[], str2better[] ;

extern char scorename[] ;
extern char *gametypenames[] ;

extern int joyx, joyy, fire;

extern int ExtraLifeEvery, FlashTime;

extern SDL_Surface *MainScreen ;

extern int CurrentStatus ;
extern int SavedStatus ;
extern int CurrentGameType ;
extern int StartLives[ GAMETYPES ] ;
extern int AutoFire ;

// From main.c
void GoTitleScreen( void ) ;
void Quit( int Argument ) ;
void DisplayMenuItems( void ) ;

// From topten.c
void TopTenInit( void ) ;
void TopTenAddScore( int gametype, long lastscore, int lastlevel ) ;
void TopTenDisplay( int gametype, int hilight );
void TopTenSetName( char *Name ) ;

// From play.c
void PlayNewGame( int gametype ) ;
int PlayMainLoop( void ) ;

// From util.c
void DemoRecord( void ) ;
void DemoPlay( void ) ;
void DemoStop( void ) ;
int DemoGetStatus( void ) ;
void readjoy( int Player ) ;

// From joy.c
void TrueReadJoy( int Player ) ;
int ReadKey( void ) ;
int FunctionKey( void ) ;
int EscPressed( void ) ;
int SpacePressed( void ) ;

// From pics.c
int PictureInit( void ) ;
void PictureSetRefresh( int Flag ) ;
void PictureRefreshScreen( void ) ;
void PictureClearAll( void ) ;
void PictureClearBottom( void ) ;
void PictureReset( void ) ;
int PictureDraw( int x, int y, int shp ) ;
void PictureRefreshAll( void ) ;
void PictureShow( int x, int y, int shp ) ;
void PictureRefresh( int x, int y ) ;
void PicturePutScreen( int x, int y, int shp ) ;
void PicturePutScreenNoSave( int x, int y, int shp ) ;
int PictureReadScreen( int x, int y ) ;
void PictureWriteString( int x, int y, char *s, int Flags ) ;
void PictureDisplayText( char *msg, int flags ) ;
void InputAt( int x, int y, char *Buffer, int BufSize ) ;

// From attract.c
void AttractStart( void ) ;
int DoAttractMode( int TimeQuantum ) ;

// From bdscoretab.c (linked only for special purposes)
void CreateScoreTab( void ) ;

// From sounds.c
int SoundsInit( void ) ;
void SoundsClose( void ) ;
void PlaySound( char *file ) ;
