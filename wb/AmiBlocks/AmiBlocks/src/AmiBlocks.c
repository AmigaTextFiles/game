/*  AmiBlocks 0.9 - The Puzzle Game for Amiga
 *  © Juha Niemimäki, 2002-2003
 *  jniemima@mail.student.oulu.fi
 */


/*
    Requires:   Amiga OS 3.x (you need ReAction or ClassAction installed)

                Please install MedPlayer, OctaPlayer and OctaMix libraries, v7,
                freely available from SoundStudio or player packages

    Compiling:  Use the latest NDK (3.9 recommended)
                Compiles with VBCC

                Get the OcSS_src.lha package from Aminet and create linker libs
                from .fd files by using fd2pragma with SPECIAL 12.

    Note:       I have noticed some buggy behaviour in ClassAction gadgets (Sliders),
                so please get most up-to-date package you can find!
*/



/* TODO:

    - AHI support for sounds
    - background picture / GFX tiles, support via datatypes???
    - Explosion pieces, bonus pieces, morphing pieces...
    - 2PL?
    - Your ideas
    - OS 4 compile...btw: did anyone tried this with MorphOS?

*/


/* System includes: */
#include <stdio.h>

#include <exec/types.h>
#include <exec/lists.h>
//#include <exec/nodes.h>

#include <intuition/intuition.h>
#include <graphics/gfxbase.h>

#include <libraries/gadtools.h>

#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/exec.h>

/* ReAction includes */
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>

#ifdef MUSIC
    #include "proplayer.h"
    #include "med.h"
#endif

#define XSIZE 10
#define YSIZE 10

#define NEWBLOCKS 4

#define HISCORESIZE 5

#define HSFILE "HiScores.data"

#define MUSICFILES 20

const UBYTE versionString[] = "$VER: AmiBlocks 0.9 (22.1.2003) by Juha Niemimäki";

/* Colour IDs*/
enum
{
    COL_NONE = 0,
    COL_BLACK,
    COL_RED,
    COL_GREEN,
    COL_BLUE,
    COL_YELLOW,
    COL_JOKER
};

/* Gadget IDs */
enum
{
    GID_MAIN=0,
    GID_LAYOUT,
    GID_TURN,
    GID_SCORE,
    GID_BEVEL,
    GID_UNDO,
    GID_NEWGAME,
    GID_GAMEOVER,
    GID_HISCORES,
    GID_PREFS,
    GID_PREFERENCES,
    
    GID_ABOUT,
    GID_ABOUTBTN,

    GID_CONFIRMATION,
    GID_MSG,
    GID_YES,
    GID_NO,

    GID_LIST,
    GID_MUS,
    GID_FREQSLIDER,
    GID_FREQ,
    GID_FREQGROUP,

    GID_BUTTONGROUP,
    GID_PALETTE,
    GID_BLACK,
    GID_RED,
    GID_GREEN,
    GID_BLUE,
    GID_YELLOW,

    GID_HSNAME1,
    GID_HSNAME2,
    GID_HSNAME3,
    GID_HSNAME4,
    GID_HSNAME5,

    GID_HSSCORE1,
    GID_HSSCORE2,
    GID_HSSCORE3,
    GID_HSSCORE4,
    GID_HSSCORE5,

    GID_NAMEENTRY,
    GID_NAME,
    
    GID_OK,

    GID_LAST
};

/* Window IDs */
enum
{
    WID_MAIN=0,
    WID_HISCORES,
    WID_GAMEOVER,
    WID_NAMEENTRY,
    WID_PREFS,
    WID_ABOUT,
    WID_CONFIRMATION,
    WID_LAST
};

/* Object IDs */
enum
{
    OID_MAIN=0,
    OID_HISCORES,
    OID_GAMEOVER,
    OID_NAMEENTRY,
    OID_PREFS,
    OID_ABOUT,
    OID_CONFIRMATION,
    OID_LAST
};

struct Library *WindowBase;
struct Library *LayoutBase;
struct Library *ButtonBase;
struct Library *CheckBoxBase;
struct Library *LabelBase;
struct Library *BevelBase;
struct Library *SliderBase;
struct Library *StringBase;
struct Library *SpaceBase;
struct Library *ChooserBase;
struct Library *PaletteBase;

#ifdef MUSIC
    struct Library *MEDPlayerBase, *OctaPlayerBase, *OctaMixPlayerBase;

    struct List songList;

    struct MMD0 *sng;
#endif

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

struct Hook idcmpHook;

struct ColorMap *cm;

struct Coords {
    UBYTE x;
    UBYTE y;
    UBYTE color;
};

/* We keep track of all free pieces to help the random block placing */
struct Coords freePieces[ XSIZE * YSIZE ];

struct Coords lastMoves[ NEWBLOCKS ], undoLastMoves[ NEWBLOCKS ];

struct HiScore {
    UWORD score;
    UBYTE name[11]; /* 10 + '\0' */
    UBYTE scoreText[4];
};

struct OldHiScore {
    UWORD score;
    UBYTE name[4]; /* 3 + '\0' */
    UBYTE scoreText[4];
};

/* We are going to save this to a hiscores.dat file, too */
struct HiScore hiScores[ HISCORESIZE ] = {
    { 0, "----------", "   " },
    { 0, "----------", "   " },
    { 0, "----------", "   " },
    { 0, "----------", "   " },
    { 0, "----------", "   " },
};

struct OldHiScore oldHiScores[ HISCORESIZE ] = {
    { 0, "---", "   " },
    { 0, "---", "   " },
    { 0, "---", "   " },
    { 0, "---", "   " },
    { 0, "---", "   " },
};


const STRPTR name = "AmiBlocks";

/* X and Y steps for table grid */
WORD x, y, moves, undoMoves, turn, undoTurn, score, undoScore, emptyLeft;

/* Yes, it's the game board :) */
BYTE table[ XSIZE ][ YSIZE ], undoTable[ XSIZE ][ YSIZE ];

UWORD maxColours = 16;

/* Game area */
ULONG innerLeft, innerTop, innerWidth, innerHeight;

/* Other parameters */
ULONG initialBlocks = 8, movesPerTurn = 1, inmovable = 1;

#ifdef MUSIC
    ULONG music = 1, initialFreq = 2150;
#endif

/* Colours */
LONG bgPen, blackPen, redPen, greenPen, bluePen, yellowPen, whitePen;

/* Keeps the game's main event loop running */
BOOL done = FALSE;

/* Hiscores will be saved if there has been a change */
BOOL newHiScore = FALSE;

/**/
BOOL blackReleased = FALSE, redReleased = FALSE, greenReleased = FALSE, blueReleased = FALSE, yellowReleased = FALSE;

/* Stores our gadgets, windows etc */
struct Gadget *gadgets[GID_LAST];
struct Window *windows[WID_LAST];
struct Object *objects[OID_LAST];

/* This application's message port */
struct MsgPort *AppPort;

/* Numbers must be shown in text, clumsy bit of ReAction? Try Button instead of Label? */
STRPTR turnBuf   = "Turn:     ";
STRPTR scoreBuf  = "Score:     ";
STRPTR turnBonusBuf = "Turn Bonus :     ";

/* Some protos, not all...keeps compiler happy :) */
void gameOver(void);
void showHiScores(void);
void checkHiScores(void);
void saveSituation(void);


/* Open all we need */
BOOL openLibs(void)
{

    GfxBase = (struct GfxBase *)OpenLibrary("graphics.library", 39);
    IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library", 39);
    WindowBase = OpenLibrary("window.class", 39);
    LayoutBase = OpenLibrary("gadgets/layout.gadget", 39);
    ButtonBase = OpenLibrary("gadgets/button.gadget", 39);
    CheckBoxBase = OpenLibrary("gadgets/checkbox.gadget", 39);
    LabelBase = OpenLibrary("images/label.image", 39);
    BevelBase = OpenLibrary("images/bevel.image", 39);
    SliderBase = OpenLibrary("gadgets/slider.gadget", 39);
    StringBase = OpenLibrary("gadgets/string.gadget", 39);
    SpaceBase = OpenLibrary("gadgets/space.gadget", 39);
    ChooserBase = OpenLibrary("gadgets/chooser.gadget", 39);
    PaletteBase = OpenLibrary("gadgets/palette.gadget", 39);

    #ifdef MUSIC
        MEDPlayerBase = OpenLibrary("medplayer.library", 7);
        OctaPlayerBase = OpenLibrary("octaplayer.library", 7);
        OctaMixPlayerBase = OpenLibrary("octamixplayer.library", 7);
    #endif

    if (!ButtonBase || !CheckBoxBase || !WindowBase || !LayoutBase || !LabelBase || !IntuitionBase || !BevelBase || !SliderBase || !StringBase || !SpaceBase || !ChooserBase || !PaletteBase )
        return FALSE;
    else return TRUE;

}

/* Close the gadgets and libraries */
void closeLibs(void)
{
    /* Close the classes. */
    CloseLibrary(PaletteBase);
    CloseLibrary(ChooserBase);
    CloseLibrary(SpaceBase);
    CloseLibrary(StringBase);
    CloseLibrary(SliderBase);
    CloseLibrary(BevelBase);
    CloseLibrary(LabelBase);
    CloseLibrary(CheckBoxBase);
    CloseLibrary(ButtonBase);
    CloseLibrary(LayoutBase);
    CloseLibrary(WindowBase);
    CloseLibrary((struct Library *)IntuitionBase);
    CloseLibrary((struct Library *)GfxBase);
    
    #ifdef MUSIC
        CloseLibrary(MEDPlayerBase);
        CloseLibrary(OctaPlayerBase);
        CloseLibrary(OctaMixPlayerBase);
    #endif
}


/* Update the array of the free pieces*/
WORD findFree() {
    UWORD index = 0;
    UBYTE i, j;

    for ( i = 0; i < YSIZE; i++ ) {
        for ( j = 0; j < XSIZE; j++ ) {
            if ( table[j][i] == COL_NONE ) {
                freePieces[index].x = j;
                freePieces[index].y = i;
                freePieces[index].color = COL_NONE;
                index++;
            }
        }
    }
    /* End mark */
    freePieces[index].x = XSIZE;
    freePieces[index].y = YSIZE;
    freePieces[index].color = COL_BLACK;

    return index;
}

/* Insert new block */
BOOL markAtWith( UBYTE xCoord, UBYTE yCoord, UBYTE c ) {

    if ( xCoord < XSIZE && yCoord < YSIZE  ) {
        table[xCoord][yCoord] = c;
        return TRUE;
    } else printf("Board overflow: [%d, %d]\n", (WORD)xCoord, (WORD)yCoord );

    return FALSE;
}


/* Clear the table */
void resetBoard(void) {
    BYTE i, j;

    for ( i = 0; i < YSIZE; i++ ) {
        for ( j = 0; j < XSIZE; j++ ) {
            markAtWith( j, i, COL_NONE );
        }
    }
}


/* Random number generator */
UBYTE getRnd( UBYTE min, UBYTE max ) {
    LONG secs, msecs;
    UBYTE number;

    Delay(3);
    CurrentTime( &secs, &msecs );
    srand( (ULONG) ( msecs)  );

    number = (UBYTE)(rand()%(max-min)+min);

    //number = (UBYTE)(FastRand( msecs * secs )%(max-min)+min);

    return number;
}


/* This function keeps trace of lately added blocks and marks them... */
void markLastAdded( struct RastPort *rp ) {

    UBYTE i;

    for ( i = 0; i < 4 ; i++ ){

        if ( table[ lastMoves[i].x ][ lastMoves[i].y ] != COL_NONE ) {
            
            if ( lastMoves[i].color != COL_BLACK )
                SetAPen( rp, blackPen ); /* If it's not a black, draw black rect */
            else
                SetAPen( rp, redPen );   /* Ok, it was black, draw red then */
            
            Move( rp, innerLeft+lastMoves[i].x*x+2, innerTop+lastMoves[i].y*y+2 );
            Draw( rp, innerLeft+lastMoves[i].x*x+x-2, innerTop+lastMoves[i].y*y+2 );
            Draw( rp, innerLeft+lastMoves[i].x*x+x-2, innerTop+lastMoves[i].y*y+y-2 );
            Draw( rp, innerLeft+lastMoves[i].x*x+2, innerTop+lastMoves[i].y*y+y-2 );
            Draw( rp, innerLeft+lastMoves[i].x*x+2, innerTop+lastMoves[i].y*y+3 );
        }
    }
}


/* Redraw board */
void refreshGame(struct RastPort *rp) {
    ULONG colour;
    BYTE i, j;

    BOOL joker;

    SetAPen( rp, blackPen );

    for ( i = 0; i < XSIZE; i++ ) {
        Move( rp, innerLeft+i*x, innerTop );
        Draw( rp, innerLeft+i*x, innerTop+innerHeight );    
    }

    Move( rp, innerLeft+innerWidth, innerTop );
    Draw( rp, innerLeft+innerWidth, innerTop+innerHeight );


    for ( i = 0; i < YSIZE; i++ ) {
        Move( rp, innerLeft, innerTop+i*y );
        Draw( rp, innerLeft+innerWidth, innerTop+i*y );
    }

    Move( rp, innerLeft, innerTop+innerHeight );
    Draw( rp, innerLeft+innerWidth, innerTop+innerHeight );

    /* Draw game marks */

    /* y */
    for ( i = 0; i < YSIZE; i++ ) {
        
        /* x */
        for ( j = 0; j < XSIZE; j++ ) {

            joker = FALSE;

            switch ( table[j][i] ) {
                
                case COL_NONE:
                    colour = 0; // ? backGroundPen?
                    break;

                case COL_BLACK:
                    colour = blackPen;
                    break;
                    
                case COL_RED:
                    colour = redPen;
                    break;
                    
                case COL_GREEN:
                    colour = greenPen;
                    break;
                    
                case COL_BLUE:
                    colour = bluePen;
                    break;
                    
                case COL_YELLOW:
                    colour = yellowPen;
                    break;

                case COL_JOKER:
                    joker = TRUE;
                    break;

                default:
                    printf("Error: unknown colour!\n");
                    colour = 0;
                    break;
                
            }

            if ( !joker ) { /* Draw the solid coloured blocks */
                SetAPen( rp, colour );
                RectFill( rp, innerLeft+j*x+1, innerTop+i*y+1, innerLeft+x*j+x-1, innerTop+i*y+y-1 );
            } else { /* Render the Joker block here */
                SetAPen( rp, bluePen );
                RectFill( rp, innerLeft+j*x+1, innerTop+i*y+1, innerLeft+x*j+x/2, innerTop+i*y+y/2 );
                SetAPen( rp, redPen );
                RectFill( rp, innerLeft+j*x+x/2, innerTop+i*y+1, innerLeft+x*j+x-1, innerTop+i*y+y/2 );
                SetAPen( rp, yellowPen );
                RectFill( rp, innerLeft+j*x+1, innerTop+i*y+y/2+1, innerLeft+x*j+x/2, innerTop+i*y+y-1 );
                SetAPen( rp, greenPen );
                RectFill( rp, innerLeft+j*x+x/2, innerTop+i*y+y/2+1, innerLeft+x*j+x-1, innerTop+i*y+y-1 );
            }
        }


    }

    markLastAdded( rp );

}


/* Watch the boundaries */
BOOL checkLimits( WORD xCoord, WORD yCoord ) {

    //printf("Entering checkLimits\n");
    
    if ( yCoord > innerTop && yCoord < innerTop+innerHeight ) {
        if ( xCoord > innerLeft && xCoord < innerLeft+innerWidth ) {
    
            return TRUE;

        } /*else printf("Out of X area\n");*/
    } /*else printf("Out of Y area\n");*/
    
    return FALSE;
}


/* Return the color from a physical coordinate */
UBYTE getPiece( WORD xCoord, WORD yCoord ) {

    UBYTE piece;

    //printf("Square: %d, %d\n", (WORD) (xCoord-innerLeft)/x , (WORD)(yCoord-innerTop)/y );
    piece = table[ (xCoord-innerLeft)/x ][ (yCoord-innerTop)/y ];

    return ( piece );
}



/* Find the amount of the same colours */
UBYTE howManySame( UBYTE j, UBYTE i ) {
    UBYTE reds = 0, greens = 0, blues = 0, yellows = 0, blacks = 0, empties = 0;
    UBYTE most, xIndex, yIndex;

    for ( yIndex = i; yIndex <= ( i + 1 ); yIndex++ ) {
        for ( xIndex = j; xIndex <= ( j + 1 ); xIndex++ ) {
            
            switch ( table[xIndex][yIndex] ) {
                case COL_RED:
                    reds++;
                    break;

                case COL_GREEN:
                    greens++;
                    break;

                case COL_BLUE:
                    blues++;
                    break;

                case COL_YELLOW:
                    yellows++;
                    break;

                case COL_BLACK:
                    blacks++;
                    break;

                case COL_NONE:
                    empties++;
                break;
            }
        }
    }

    /* Return the highest amount MINUS possible empty blocks */
    most = reds;

    if ( greens > most )
        most = greens;

    if ( blues > most )
        most = blues;
    
    if ( yellows > most )
        most = yellows;

    if ( blacks > most )
        most = blacks;

    return (most - empties);
}



/* Find the amount of Joker blocks */
UBYTE findJokers( UBYTE j, UBYTE i ) {
    UBYTE jokers = 0;

    if ( table[j][i] == COL_JOKER )
        jokers++;

    if ( table[j+1][i] == COL_JOKER )
        jokers++;

    if ( table[j][i+1] == COL_JOKER )
        jokers++;
    
    if ( table[j+1][i+1] == COL_JOKER )
        jokers++;

    return jokers;
}



/* Find connected blocks */
void checkBoard( struct RastPort *rp ) {
    BYTE i, j, k;

    for ( i = 0 ; i < YSIZE-1 ; i++ )
    {
        for ( j = 0; j < XSIZE-1 ; j++ )
        {

            if ( ( findJokers(j, i) == 4 ) ||
                ( ( findJokers(j, i) == 3 ) && ( howManySame(j, i) == 1 ) ) ||
                ( ( findJokers(j, i) == 2 ) && ( howManySame(j, i) == 2 ) ) ||
                ( ( findJokers(j, i) == 1 ) && ( howManySame(j, i) == 3 ) ) ||
                ( ( findJokers(j, i) == 0 ) && ( howManySame(j, i) == 4 ) ) )
                {

                    score += 10;

                    /* Explosion animation :) */
                    
                    SetAPen( rp, COL_NONE );

                    for ( k = 3; k >= 0; k--) {

                        RectFill( rp, innerLeft+j*x+(2*k)+1, innerTop+i*y+(2*k)+1, innerLeft+j*x+x-(2*k)-1, innerTop+i*y+y-(2*k)-1 );
                        Delay(2);
                        RectFill( rp, innerLeft+j*x+x+(2*k)+1, innerTop+i*y+(2*k)+1, innerLeft+j*x+2*x-(2*k)-1, innerTop+i*y+y-(2*k)-1 );
                        Delay(2);
                        RectFill( rp, innerLeft+j*x+(2*k)+1, innerTop+i*y+y+(2*k)+1, innerLeft+j*x+x-(2*k)-1, innerTop+i*y+(2*y)-(2*k)-1 );
                        Delay(2);
                        RectFill( rp, innerLeft+j*x+x+(2*k)+1, innerTop+i*y+y+(2*k)+1, innerLeft+j*x+(2*x)-(2*k)-1, innerTop+i*y+(2*y)-(2*k)-1 );
                        Delay(2);
                    }

                    /* Destroy blocks */
                    table[j][i] = COL_NONE;
                    table[j+1][i] = COL_NONE;
                    table[j][i+1] = COL_NONE;
                    table[j+1][i+1] = COL_NONE;

                }
            
        }
    }

    emptyLeft = 0;
    for ( i = 0 ; i < YSIZE; i++ ) {
        for ( j = 0 ; j < XSIZE; j++ )
        {
            if ( table[j][i] == COL_NONE ) {
                emptyLeft++;
            }
        }    
    }

    //printf("Empty Space Left: %d\n", emptyLeft);

}


/* Have a lottery for the new blocks */
void nextTurn( struct RastPort *rp ) {
    BOOL ok;
    UBYTE tryX, tryY, tryCol;
    BYTE i, blocks;
    WORD index;

    if ( /*findFree()*/ emptyLeft > 3 )
        blocks = NEWBLOCKS;
    else
        blocks = /*findFree()*/ emptyLeft;

    for ( i = 0; i < blocks; i++ ){
    
        index = getRnd( 0, findFree() );

        tryX = freePieces[index].x;
        tryY = freePieces[index].y;

        if ( (BOOL)inmovable )
            tryCol = getRnd( 1, 7 );
        else
            tryCol = getRnd( 2, 7 );

        markAtWith( tryX, tryY, tryCol );

        lastMoves[i].x = tryX;
        lastMoves[i].y = tryY;
        lastMoves[i].color = tryCol;

    }

}


/* Refresh info tables */
void updateStats() {
    sprintf( turnBuf, "Turn: %3d ", turn );
    sprintf( scoreBuf, "Score: %3d ", score );

    RethinkLayout(gadgets[GID_LAYOUT], windows[WID_MAIN], NULL, TRUE );
}


/* Don't allow moving too far */
UBYTE checkRange( WORD fromX, WORD fromY, WORD toX, WORD toY ) {

    UBYTE xRange, yRange;

    if ( ( xRange = abs ( (UBYTE)((fromX-innerLeft)/x) - (UBYTE)((toX-innerLeft)/x) ) ) <= 1 /*(movesPerTurn - moves)*/ ) {
        if ( ( yRange = abs ( (UBYTE)((fromY-innerTop)/y) - (UBYTE)((toY-innerTop)/y) ) ) <= 1 /*(movesPerTurn - moves)*/ ) {
            if ( xRange >= yRange )
                return xRange;
            else
                return yRange;
        }
    }
    return 0;
}


/* Handle an IDCMP event here... */
ULONG hookFunc(struct Hook *hook, struct Window *window, struct IntuiMessage *msg) {

    struct RastPort *rp = msg->IDCMPWindow->RPort;

    ULONG class = msg->Class;

    if ( class == IDCMP_REFRESHWINDOW ) {
        refreshGame( rp );
    }

    return 0;
}


/* Define the Hook's entry */
ULONG hookEntry( __reg("a0") struct Hook *hook, __reg("a2") APTR object, __reg("a1") APTR message ) {

    return( (*hook->h_SubEntry)(hook, object, message) );
}


/* Prepare the Hook function*/
void initHook( struct Hook *hook, ULONG(*code)() ) {
    hook->h_Entry = hookEntry;
    hook->h_SubEntry = code;
    hook->h_Data = 0;
}


/* Load old HiScores */
void loadHS(void) {

    struct FileInfoBlock fib;
    BPTR file;
    LONG loaded = 0;
    BYTE i;

    if ( ! ( file = Open( HSFILE, MODE_OLDFILE ) ) ) {

        printf("HiScore file not found.\n");

    } else {

        ExamineFH( file, &fib );

        if ( fib.fib_Size == 50 ) { /* It's an old hi-score file */

            if ( ( loaded = FRead( file, oldHiScores, sizeof( struct OldHiScore ), HISCORESIZE ) ) == HISCORESIZE ) {
                printf("Old version of HiScores loaded\n");
            }
        
            /* Conversion: */

            for ( i = 0; i < 5; i++ ) {
                hiScores[i].score = oldHiScores[i].score;
                strncpy( hiScores[i].name, oldHiScores[i].name, 3 );
                strncpy( hiScores[i].scoreText, oldHiScores[i].scoreText, 3 );
            }

        } else { /* Probably a new hi-score file: */
        
            if ( ( loaded = FRead( file, hiScores, sizeof( struct HiScore ), HISCORESIZE ) ) == HISCORESIZE ) {
                printf("HiScores loaded\n");
            }    
        
        }

        Close( file );
    
    }
}


/* Put the HiScores into the file */
void saveHS(void) {

    BPTR file;
    LONG written;

    if ( ! ( file = Open( HSFILE, MODE_NEWFILE ) ) ) {

        printf("Cannot create the HiScores file.\n");

    } else {

        if ( ( written = FWrite( file, hiScores, sizeof( struct HiScore ), HISCORESIZE ) ) == HISCORESIZE ) {
                //printf("HiScores written to the file\n");
        }

        Close( file );
    }

}


/* Game Over */
void gameOver(void) {

    SetGadgetAttrs( gadgets[GID_UNDO], windows[WID_MAIN], NULL, GA_Disabled, TRUE, TAG_DONE );

    sprintf( turnBonusBuf, "Turn Bonus : %3d ", turn );

    if (windows[WID_GAMEOVER] = (struct Window *) RA_OpenWindow(objects[OID_GAMEOVER]))
    {
        ULONG wait, signal, app = (1L << AppPort->mp_SigBit);
        ULONG result;
        UWORD code;
        BOOL doneGO = FALSE;

        /* Obtain the window wait signal mask */
        GetAttr(WINDOW_SigMask, objects[OID_GAMEOVER], &signal);

        /* Input Event Loop */
        while (!doneGO)
        {
            wait = Wait( signal | SIGBREAKF_CTRL_C | app );

            if ( wait & SIGBREAKF_CTRL_C )
            {
                doneGO = TRUE;
            }
            else
            {
                while ( (result = RA_HandleInput(objects[OID_GAMEOVER], &code) ) != WMHI_LASTMSG )
                {

                    switch (result & WMHI_CLASSMASK)
                    {

                        case WMHI_CLOSEWINDOW:
                            windows[WID_GAMEOVER] = NULL;
                            doneGO = TRUE;
                            break;

                        case WMHI_CHANGEWINDOW:
                            refreshGame( windows[WID_MAIN]->RPort );
                            break;

                        case WMHI_GADGETUP:
                            if ( (result & WMHI_GADGETMASK) == GID_OK ) {
                                windows[WID_GAMEOVER] = NULL;
                                doneGO = TRUE;
                            }
                            break;
                 
                       case WMHI_VANILLAKEY:
                            if ( code == 196 ) {
                                windows[WID_GAMEOVER] = NULL;
                                doneGO = TRUE;
                            }
                            break;

                    }

                }
            }
        }

        RA_CloseWindow(objects[WID_GAMEOVER]);

    }
}


/* Take the player's initials */
STRPTR nameEntry(void) {

    ULONG pName = 0;

    refreshGame( windows[WID_MAIN]->RPort );

    if (windows[WID_NAMEENTRY] = (struct Window *) RA_OpenWindow(objects[OID_NAMEENTRY]))
    {
        ULONG wait, signal, app = (1L << AppPort->mp_SigBit);
        ULONG result;
        UWORD code;
        BOOL doneNE = FALSE;

        ActivateGadget( gadgets[GID_NAME], windows[WID_NAMEENTRY], NULL );

        /* Obtain the window wait signal mask */
        GetAttr(WINDOW_SigMask, objects[OID_NAMEENTRY], &signal);

        /* Input Event Loop */
        while (!doneNE)
        {
            wait = Wait( signal | SIGBREAKF_CTRL_C | app );

            if ( wait & SIGBREAKF_CTRL_C )
            {
                doneNE = TRUE;
            }
            else
            {
                while ( (result = RA_HandleInput(objects[OID_NAMEENTRY], &code) ) != WMHI_LASTMSG )
                {

                    switch (result & WMHI_CLASSMASK)
                    {

                        case WMHI_CLOSEWINDOW:
                            windows[WID_NAMEENTRY] = NULL;
                            doneNE = TRUE;
                            break;

                        case WMHI_CHANGEWINDOW:
                            refreshGame( windows[WID_MAIN]->RPort );
                            break;

                        case WMHI_GADGETUP:
                            switch (result & WMHI_GADGETMASK)
                            {
                                case GID_NAME:
                                case GID_OK:
                                    windows[WID_NAMEENTRY] = NULL;
                                    doneNE = TRUE;
                                break;

                            }
                        break;

                        case WMHI_VANILLAKEY:
                            if ( code == 196 ) {
                                windows[WID_NAMEENTRY] = NULL;
                                doneNE = TRUE;
                            }
                            break;

                    }

                }
            }
        }

        GetAttr( STRINGA_TextVal, gadgets[GID_NAME], &pName );

        RA_CloseWindow(objects[WID_NAMEENTRY]);

    }

    return (STRPTR)pName;

}



/* Rearrange the HS list */
void updateHiScores( UBYTE index ) {
    BYTE i, j;
    
    STRPTR pName = nameEntry();

    for ( i = (HISCORESIZE - 1) ; i >= 0; i-- ) {

        if ( index == i ) {

            switch ( index ) {

                case (HISCORESIZE-1):
                    strcpy( hiScores[HISCORESIZE-1].name, pName );
                    hiScores[HISCORESIZE-1].score = score;
                    sprintf( hiScores[HISCORESIZE-1].scoreText, "%3d", score );
                    break;

                default:
                    for ( j = HISCORESIZE-1; j > i; j-- ) {
                        strcpy( hiScores[j].name, hiScores[j-1].name );
                        hiScores[j].score = hiScores[j-1].score;
                        strcpy( hiScores[j].scoreText, hiScores[j-1].scoreText );
                    }

                    strcpy( hiScores[index].name, pName );
                    hiScores[index].score = score;
                    sprintf( hiScores[index].scoreText, "%3d", score );
                    break;
            
            }
        
            break;

        }
    
    }

}



/* Go through the list and check for a new hiscore */
void checkHiScores(void) {
    UBYTE i;

    for ( i = 0; i < HISCORESIZE; i++ ) {
        if ( score > hiScores[i].score ) {
            
            updateHiScores( i );
            newHiScore = TRUE;

            break;
        }
    
    }

    showHiScores();

}


/* Show High Scores */
void showHiScores(void) {

    refreshGame( windows[WID_MAIN]->RPort );

    if (windows[WID_HISCORES] = (struct Window *) RA_OpenWindow(objects[OID_HISCORES]))
    {
        ULONG wait, signal, app = (1L << AppPort->mp_SigBit);
        ULONG result;
        UWORD code;
        BOOL doneHS = FALSE;

        RethinkLayout(gadgets[GID_HISCORES], windows[WID_HISCORES], NULL, TRUE );

        /* Obtain the window wait signal mask */
        GetAttr(WINDOW_SigMask, objects[OID_HISCORES], &signal);

        /* Input Event Loop */
        while (!doneHS)
        {
            wait = Wait( signal | SIGBREAKF_CTRL_C | app );

            if ( wait & SIGBREAKF_CTRL_C )
            {
                doneHS = TRUE;
            }
            else
            {
                while ( (result = RA_HandleInput(objects[OID_HISCORES], &code) ) != WMHI_LASTMSG )
                {

                    switch (result & WMHI_CLASSMASK)
                    {

                        case WMHI_CLOSEWINDOW:
                            windows[WID_HISCORES] = NULL;
                            doneHS = TRUE;
                            break;

                        case WMHI_CHANGEWINDOW:
                            refreshGame( windows[WID_MAIN]->RPort );
                            break;

                        case WMHI_GADGETUP:
                            if ( (result & WMHI_GADGETMASK) == GID_OK ) {
                                windows[WID_HISCORES] = NULL;
                                doneHS = TRUE;
                            }
                            break;

                        case WMHI_VANILLAKEY:
                            if ( code == 196 ) {
                                windows[WID_HISCORES] = NULL;
                                doneHS = TRUE;
                            }
                            break;

                    }

                }
            }
        }

        RA_CloseWindow(objects[WID_HISCORES]);

    }
}



/* Show About Box */
void about(void) {

    refreshGame( windows[WID_MAIN]->RPort );

    if (windows[WID_ABOUT] = (struct Window *) RA_OpenWindow(objects[OID_ABOUT]))
    {
        ULONG wait, signal, app = (1L << AppPort->mp_SigBit);
        ULONG result;
        UWORD code;
        BOOL doneA = FALSE;

        RethinkLayout(gadgets[GID_ABOUT], windows[WID_ABOUT], NULL, TRUE );

        /* Obtain the window wait signal mask */
        GetAttr(WINDOW_SigMask, objects[OID_ABOUT], &signal);

        /* Input Event Loop */
        while (!doneA)
        {
            wait = Wait( signal | SIGBREAKF_CTRL_C | app );

            if ( wait & SIGBREAKF_CTRL_C )
            {
                doneA = TRUE;
            }
            else
            {
                while ( (result = RA_HandleInput(objects[OID_ABOUT], &code) ) != WMHI_LASTMSG )
                {

                    switch (result & WMHI_CLASSMASK)
                    {

                        case WMHI_CLOSEWINDOW:
                            windows[WID_ABOUT] = NULL;
                            doneA = TRUE;
                            break;

                        case WMHI_CHANGEWINDOW:
                            refreshGame( windows[WID_MAIN]->RPort );
                            break;

                        case WMHI_GADGETUP:
                            if ( (result & WMHI_GADGETMASK) == GID_OK ) {
                                windows[WID_ABOUT] = NULL;
                                doneA = TRUE;
                            }
                            break;

                        case WMHI_VANILLAKEY:
                            if ( code == 196 ) {
                                windows[WID_ABOUT] = NULL;
                                doneA = TRUE;
                            }
                            break;

                    }

                }
            }
        }

        RA_CloseWindow(objects[WID_ABOUT]);

    }
}


/* Ask confirmation to the question from user */
/*BOOL confirmation( STRPTR msg ) {

    struct EasyStruct easyStruct = {
        sizeof (struct EasyStruct),
        0,
        "Please Confirm the Following Action:",
        "",
        "Yes|No",
    };

    easyStruct.es_TextFormat = msg;

    if ( EasyRequest( windows[WID_MAIN], &easyStruct, NULL, "" ) != 0 ) {
        return TRUE;
    }

    return FALSE;
}*/


/* Ask user to confirm */
BOOL confirmation( /*STRPTR msg*/ ) {
    BOOL confirm = TRUE;

    refreshGame( windows[WID_MAIN]->RPort );

    //SetAttrs( gadgets[GID_MSG], LABEL_Text, msg, TAG_DONE );

    if (windows[WID_CONFIRMATION] = (struct Window *) RA_OpenWindow(objects[OID_CONFIRMATION]))
    {
        ULONG wait, signal, app = (1L << AppPort->mp_SigBit);
        ULONG result;
        UWORD code;
        BOOL doneC = FALSE;

        RethinkLayout(gadgets[GID_CONFIRMATION], windows[WID_CONFIRMATION], NULL, TRUE );

        /* Obtain the window wait signal mask */
        GetAttr(WINDOW_SigMask, objects[OID_CONFIRMATION], &signal);

        /* Input Event Loop */
        while (!doneC)
        {
            wait = Wait( signal | SIGBREAKF_CTRL_C | app );

            if ( wait & SIGBREAKF_CTRL_C )
            {
                doneC = TRUE;
            }
            else
            {
                while ( (result = RA_HandleInput(objects[OID_CONFIRMATION], &code) ) != WMHI_LASTMSG )
                {

                    switch (result & WMHI_CLASSMASK)
                    {

                        case WMHI_CLOSEWINDOW:
                            windows[WID_CONFIRMATION] = NULL;
                            doneC = TRUE;
                            confirm = FALSE;
                            break;

                        case WMHI_CHANGEWINDOW:
                            refreshGame( windows[WID_MAIN]->RPort );
                            break;

                        case WMHI_GADGETUP:
                            if ( (result & WMHI_GADGETMASK) == GID_YES ) {
                                windows[WID_CONFIRMATION] = NULL;
                                doneC = TRUE;
                                confirm = TRUE;
                            }
                        
                            if ( (result & WMHI_GADGETMASK) == GID_NO ) {
                                windows[WID_CONFIRMATION] = NULL;
                                doneC = TRUE;
                                confirm = FALSE;
                            }
                            break;

                        case WMHI_VANILLAKEY:
                            if ( code == 196 ) {
                                windows[WID_CONFIRMATION] = NULL;
                                doneC = TRUE;
                                confirm = TRUE;
                            }
                            break;

                    }

                }
            }
        }

        RA_CloseWindow(objects[WID_CONFIRMATION]);

    }

    return confirm;
}


/* We have to back up the board every turn to enable UNDO...*/
void saveSituation( void ) {

    UBYTE i, j;

    undoMoves = moves;
    undoTurn = turn;
    undoScore = score;

    for ( i = 0; i < YSIZE; i++ ) {
    
        for ( j = 0; j < XSIZE; j++ ) {

            undoTable[j][i] = table[j][i];
        
        }    
    }

    for ( i = 0; i < NEWBLOCKS; i++ ) {

        undoLastMoves[i] = lastMoves[i];

    }

}


/* Retrieve the old board */
void undoMove( struct RastPort *rp ) {

    UBYTE i, j;

    moves = undoMoves;
    turn = undoTurn;
    score = undoScore;

    for ( i = 0; i < YSIZE; i++ ) {
    
        for ( j = 0; j < XSIZE; j++ ) {

            table[j][i] = undoTable[j][i];
        
        }    
    }

    for ( i = 0; i < NEWBLOCKS; i++ ) {

        lastMoves[i] = undoLastMoves[i];

    }

    refreshGame( rp );
    updateStats();
}


/* Init a new game */
void newGame( void ) {

    UBYTE i, tryX, tryY, tryCol;
    BOOL ok;

    /* Get the dimension of the game area */
    GetAttr( BEVEL_InnerLeft, gadgets[GID_BEVEL], &innerLeft );
    GetAttr( BEVEL_InnerTop, gadgets[GID_BEVEL], &innerTop );
    GetAttr( BEVEL_InnerWidth, gadgets[GID_BEVEL], &innerWidth );
    GetAttr( BEVEL_InnerHeight, gadgets[GID_BEVEL], &innerHeight );

    if ( ( (innerWidth % XSIZE) != 0 ) || ( (innerHeight % YSIZE) != 0 ) ) {
        innerWidth = innerWidth - (innerWidth % XSIZE);
        innerHeight = innerHeight - (innerHeight % YSIZE);
    }

    x = innerWidth / XSIZE;
    y = innerHeight / YSIZE;

    resetBoard();

    for ( i = 0; i < initialBlocks; i++ ) {
        ok = FALSE;
        while ( !ok ) {
            tryX = getRnd( 0, 10 );

            /* Note that there are never black pieces placed at the first round */
            tryCol = getRnd( 2, 7 );

            tryY = getRnd( 0, 10 );

            if ( table[tryX][tryY] == COL_NONE ) {
                markAtWith( tryX, tryY, tryCol );
                ok = TRUE;
            }
        }
    }

    moves = 0;
    turn = 1;
    score = 0;

    updateStats();

    checkBoard( windows[WID_MAIN]->RPort );

    refreshGame( windows[WID_MAIN]->RPort );

}


/* Unselect all but the selected colour buttons */
void unselect( ULONG selectedID ) {

    if ( selectedID != GID_BLACK )
        SetAttrs(gadgets[GID_BLACK], GA_Selected, FALSE, TAG_DONE );
    
    if ( selectedID != GID_RED )
        SetAttrs(gadgets[GID_RED], GA_Selected, FALSE, TAG_DONE );
    
    if ( selectedID != GID_GREEN )
        SetAttrs(gadgets[GID_GREEN], GA_Selected, FALSE, TAG_DONE );
    
    if ( selectedID != GID_BLUE )
        SetAttrs(gadgets[GID_BLUE], GA_Selected, FALSE, TAG_DONE );
    
    if ( selectedID != GID_YELLOW )
        SetAttrs(gadgets[GID_YELLOW], GA_Selected, FALSE, TAG_DONE );

    RethinkLayout(gadgets[GID_BUTTONGROUP], windows[WID_PREFS], NULL, TRUE );

}


/* Open the preferences window */
void prefs( void ) {

    refreshGame( windows[WID_MAIN]->RPort );

    SetAttrs(gadgets[GID_BLACK], BUTTON_BackgroundPen, blackPen, TAG_DONE );
    SetAttrs(gadgets[GID_BLACK], BUTTON_FillPen, blackPen, TAG_DONE );
    
    SetAttrs(gadgets[GID_RED], BUTTON_BackgroundPen, redPen, TAG_DONE );
    SetAttrs(gadgets[GID_RED], BUTTON_FillPen, redPen, TAG_DONE );
    
    SetAttrs(gadgets[GID_GREEN], BUTTON_BackgroundPen, greenPen, TAG_DONE );
    SetAttrs(gadgets[GID_GREEN], BUTTON_FillPen, greenPen, TAG_DONE );
    
    SetAttrs(gadgets[GID_BLUE], BUTTON_BackgroundPen, bluePen, TAG_DONE );
    SetAttrs(gadgets[GID_BLUE], BUTTON_FillPen, bluePen, TAG_DONE );
    
    SetAttrs(gadgets[GID_YELLOW], BUTTON_BackgroundPen, yellowPen, TAG_DONE );
    SetAttrs(gadgets[GID_YELLOW], BUTTON_FillPen, yellowPen, TAG_DONE );

    SetAttrs(gadgets[GID_PALETTE], PALETTE_NumColours, maxColours, TAG_DONE );

    if (windows[WID_PREFS] = (struct Window *) RA_OpenWindow(objects[OID_PREFS]))
    {
        ULONG wait, selected, signal, app = (1L << AppPort->mp_SigBit);
        ULONG result;
        UWORD code;
        BOOL doneP = FALSE;

        LONG pen;

        static LONG selection = 0;

        RethinkLayout(gadgets[GID_PREFERENCES], windows[WID_PREFS], NULL, TRUE );

        /* Obtain the window wait signal mask */
        GetAttr(WINDOW_SigMask, objects[OID_PREFS], &signal);

        /* Input Event Loop */
        while (!doneP)
        {
            wait = Wait( signal | SIGBREAKF_CTRL_C | app );

            if ( wait & SIGBREAKF_CTRL_C )
            {
                doneP = TRUE;
            }
            else
            {
                while ( (result = RA_HandleInput(objects[OID_PREFS], &code) ) != WMHI_LASTMSG )
                {

                    switch (result & WMHI_CLASSMASK)
                    {

                        case WMHI_CLOSEWINDOW:
                            windows[WID_PREFS] = NULL;
                            doneP = TRUE;
                            break;

                        case WMHI_CHANGEWINDOW:
                            refreshGame( windows[WID_MAIN]->RPort );
                            break;

                        case WMHI_MOUSEMOVE:
                            #ifdef MUSIC
                                GetAttr( SLIDER_Level, gadgets[GID_FREQSLIDER], &initialFreq );
                                SetAttrs(gadgets[GID_FREQ], BUTTON_Integer, initialFreq*10, TAG_DONE );
                                RethinkLayout(gadgets[GID_FREQGROUP], windows[WID_PREFS], NULL, TRUE );
                            #endif
                            break;

                        case WMHI_GADGETUP:
                            switch (result & WMHI_GADGETMASK) {

                                #ifdef MUSIC

                                case GID_LIST:
                                    GetAttr( CHOOSER_Selected, gadgets[GID_LIST], &selection );
                                    if ( music )
                                        playSong( (WORD) selection );
                                break;

                                case GID_MUS:
                                    GetAttr( GA_Selected, gadgets[GID_MUS], &music );

                                    if ( !music ) {
                                        closePlayer(sng);
                                    } else {
                                        playSong( (WORD)selection );
                                    }
                                    break;

                                case GID_FREQSLIDER:

                                    GetAttr( SLIDER_Level, gadgets[GID_FREQSLIDER], &initialFreq );

                                    GetAttr( SLIDER_Level, gadgets[GID_FREQSLIDER], &initialFreq );
                                    SetAttrs(gadgets[GID_FREQ], BUTTON_Integer, initialFreq*10, TAG_DONE );
                                    RethinkLayout(gadgets[GID_FREQGROUP], windows[WID_PREFS], NULL, TRUE );

                                    if (OctaMixPlayerBase)
                                        SetMixingFrequency( initialFreq );
                                break;

                                #endif

                                case GID_OK:
                                    windows[WID_PREFS] = NULL;
                                    doneP = TRUE;
                                    break;

                                case GID_BLACK:
                                    unselect( GID_BLACK );
                                    break;

                                case GID_RED:
                                    unselect( GID_RED );
                                    break;

                                case GID_GREEN:
                                    unselect( GID_GREEN );
                                    break;

                                case GID_BLUE:
                                    unselect( GID_BLUE );
                                    break;

                                case GID_YELLOW:
                                    unselect( GID_YELLOW );
                                    break;

                                case GID_PALETTE:

                                    /* Get the chosen colour */
                                    GetAttr( PALETTE_Colour, gadgets[GID_PALETTE], &pen );

                                    /* If some of the colour buttons are active, change the colour! */
                                    GetAttr( GA_Selected, gadgets[GID_BLACK], (LONG *)&selected );
                                    if ( selected ) {

                                        /* We can not allow the player to choose 2 same colours... */
                                        if ( (pen != redPen) && (pen != greenPen ) && (pen != bluePen ) && (pen != yellowPen) ) {

                                            if (!blackReleased) {
                                                ReleasePen(cm, blackPen );
                                                blackReleased = TRUE;
                                            }

                                            blackPen = pen;
                                            SetAttrs(gadgets[GID_BLACK], BUTTON_BackgroundPen, pen, TAG_DONE );
                                            SetAttrs(gadgets[GID_BLACK], BUTTON_FillPen, pen, TAG_DONE );
                                            RethinkLayout(gadgets[GID_BUTTONGROUP], windows[WID_PREFS], NULL, TRUE );
                                    
                                        }
                                    }

                                    GetAttr( GA_Selected, gadgets[GID_RED], (LONG *)&selected );
                                    if ( selected ) {

                                        /* We can not allow the player to choose 2 same colours... */
                                        if ( (pen != blackPen) && (pen != greenPen ) && (pen != bluePen ) && (pen != yellowPen) ) {

                                            if (!redReleased) {
                                                ReleasePen(cm, redPen );
                                                redReleased = TRUE;
                                            }

                                            redPen = pen;
                                            SetAttrs(gadgets[GID_RED], BUTTON_BackgroundPen, pen, TAG_DONE );
                                            SetAttrs(gadgets[GID_RED], BUTTON_FillPen, pen, TAG_DONE );
                                            RethinkLayout(gadgets[GID_BUTTONGROUP], windows[WID_PREFS], NULL, TRUE );
                                        }
                                    }

                                    GetAttr( GA_Selected, gadgets[GID_GREEN], (LONG *)&selected );
                                    if ( selected ) {

                                        /* We can not allow the player to choose 2 same colours... */
                                        if ( (pen != redPen) && (pen != blackPen ) && (pen != bluePen ) && (pen != yellowPen) ) {

                                            if (!greenReleased) {
                                                ReleasePen(cm, greenPen );
                                                greenReleased = TRUE;
                                            }

                                            greenPen = pen;
                                            SetAttrs(gadgets[GID_GREEN], BUTTON_BackgroundPen, pen, TAG_DONE );
                                            SetAttrs(gadgets[GID_GREEN], BUTTON_FillPen, pen, TAG_DONE );
                                            RethinkLayout(gadgets[GID_BUTTONGROUP], windows[WID_PREFS], NULL, TRUE );
                                        }
                                    }

                                    GetAttr( GA_Selected, gadgets[GID_BLUE], (LONG *)&selected );
                                    if ( selected ) {

                                        /* We can not allow the player to choose 2 same colours... */
                                        if ( (pen != redPen) && (pen != greenPen ) && (blackPen != pen ) && (pen != yellowPen) ) {

                                            if (!blueReleased) {
                                                ReleasePen(cm, bluePen );
                                                blueReleased = TRUE;
                                            }

                                            bluePen = pen;
                                            SetAttrs(gadgets[GID_BLUE], BUTTON_BackgroundPen, pen, TAG_DONE );
                                            SetAttrs(gadgets[GID_BLUE], BUTTON_FillPen, pen, TAG_DONE );
                                            RethinkLayout(gadgets[GID_BUTTONGROUP], windows[WID_PREFS], NULL, TRUE );
                                        }
                                    }

                                    GetAttr( GA_Selected, gadgets[GID_YELLOW], (LONG *)&selected );
                                    if ( selected ) {

                                        /* We can not allow the player to choose 2 same colours... */
                                        if ( (pen != redPen) && (pen != greenPen ) && (pen != bluePen ) && (blackPen != pen) ) {

                                            if (!yellowReleased) {
                                                ReleasePen(cm, yellowPen );
                                                yellowReleased = TRUE;
                                            }

                                            yellowPen = pen;
                                            SetAttrs(gadgets[GID_YELLOW], BUTTON_BackgroundPen, pen, TAG_DONE );
                                            SetAttrs(gadgets[GID_YELLOW], BUTTON_FillPen, pen, TAG_DONE );
                                            RethinkLayout(gadgets[GID_BUTTONGROUP], windows[WID_PREFS], NULL, TRUE );
                                        }
                                    }

                                break;

                            }
                        break;

                    }

                }
            }
        }

        RA_CloseWindow(objects[WID_PREFS]);

    }

}


/* Define user interfaces */
BOOL initObjects(void) {

    /* Use the Hook function to catch some IDCMP events */
    initHook( &idcmpHook, hookFunc );


    objects[OID_CONFIRMATION] = WindowObject,
        WA_ScreenTitle, name,
        WA_Title, "Confirmation",
        WA_Activate, TRUE,
        WA_DepthGadget, TRUE,
        WA_DragBar, TRUE,
        WA_IDCMP, IDCMP_CHANGEWINDOW | IDCMP_VANILLAKEY,
        WA_CloseGadget, TRUE,
        WINDOW_AppPort, AppPort,
        WINDOW_Position, WPOS_CENTERMOUSE,
        WINDOW_ParentGroup, gadgets[GID_CONFIRMATION] = VGroupObject,
            LAYOUT_SpaceOuter, TRUE,
            LAYOUT_DeferLayout, TRUE,
            LAYOUT_HorizAlignment, LALIGN_CENTER,
            LAYOUT_HorizAlignment, LALIGN_CENTER,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_HorizAlignment, LALIGN_CENTER,
                LAYOUT_BevelStyle, BVS_FIELD,
                GA_BackFill, NULL,

                LAYOUT_AddImage, LabelObject,
                    LABEL_Justification, LJ_CENTRE,
                    LABEL_Text, "Please Confirm the Following Action:\n\n",
                    LABEL_Text, "New Game?",
                LabelEnd,
            LayoutEnd,

            LAYOUT_AddChild, HGroupObject,

                LAYOUT_AddChild, ButtonObject,
                    GA_ID, GID_YES,
                    GA_RelVerify, TRUE,
                    GA_Text,"_Yes",
                ButtonEnd,
                CHILD_WeightedHeight, 0,

                LAYOUT_AddChild, SpaceObject,
                    SPACE_MinWidth, 80,
                SpaceEnd,

                LAYOUT_AddChild, ButtonObject,
                    GA_ID, GID_NO,
                    GA_RelVerify, TRUE,
                    GA_Text,"_No",
                ButtonEnd,
                CHILD_WeightedHeight, 0,

            LayoutEnd,

        EndGroup,
    EndWindow;


    objects[OID_ABOUT] = WindowObject,
        WA_ScreenTitle, name,
        WA_Title, "About",
        WA_Activate, TRUE,
        WA_DepthGadget, TRUE,
        WA_DragBar, TRUE,
        WA_IDCMP, IDCMP_CHANGEWINDOW | IDCMP_VANILLAKEY,
        WA_CloseGadget, TRUE,
        WINDOW_AppPort, AppPort,
        WINDOW_Position, WPOS_CENTERMOUSE,
        WINDOW_ParentGroup, gadgets[GID_ABOUT] = VGroupObject,
            LAYOUT_SpaceOuter, TRUE,
            LAYOUT_DeferLayout, TRUE,
            LAYOUT_HorizAlignment, LALIGN_CENTER,

            LAYOUT_AddImage, LabelObject,
                LABEL_Justification, LJ_CENTRE,
                LABEL_Text, versionString,
                LABEL_Text, "\n",
                LABEL_Text, "November.med by Niko Silvennoinen",
            LabelEnd,

            LAYOUT_AddChild, ButtonObject,
                GA_ID, GID_OK,
                GA_RelVerify, TRUE,
                GA_Text,"_OK",
            ButtonEnd,
            CHILD_WeightedHeight, 0,

        EndGroup,
    EndWindow;


    objects[OID_PREFS] = WindowObject,
        WA_ScreenTitle, name,
        WA_Title, "Preferences",
        WA_Activate, TRUE,
        WA_DepthGadget, TRUE,
        WA_DragBar, TRUE,
        WA_IDCMP, IDCMP_CHANGEWINDOW | IDCMP_MOUSEMOVE,
        WA_CloseGadget, TRUE,
        WINDOW_AppPort, AppPort,
        WINDOW_Position, WPOS_CENTERSCREEN,
        WINDOW_ParentGroup, gadgets[GID_PREFERENCES] = VGroupObject,
            LAYOUT_SpaceOuter, TRUE,
            LAYOUT_DeferLayout, TRUE,
            LAYOUT_HorizAlignment, LALIGN_CENTER,

            LAYOUT_AddImage, LabelObject,
                LABEL_Justification, LJ_CENTRE,
                LABEL_Text, "AmiBlocks Preferences\n\n",
            LabelEnd,

            #ifdef MUSIC

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_VertAlignment, LALIGN_CENTER,
                LAYOUT_HorizAlignment, LALIGN_CENTER,

                LAYOUT_AddChild, gadgets[GID_MUS] = CheckBoxObject,
                    GA_ID, GID_MUS,
                    GA_RelVerify, TRUE,
                    GA_Text, "_Music ON/OFF",
                    GA_Selected, music,
                    CHECKBOX_TextPlace, PLACETEXT_LEFT,
                CheckBoxEnd,

                LAYOUT_AddChild, gadgets[GID_LIST] = ChooserObject,
                    GA_ID, GID_LIST,
                    GA_RelVerify, TRUE,
                    CHOOSER_DropDown, TRUE,
                    CHOOSER_Title, "--- Song List ---",
                    CHOOSER_Labels, &songList,
                    CHOOSER_MaxLabels, MUSICFILES,
                    CHOOSER_AutoFit, TRUE,
                ChooserEnd,

            LayoutEnd,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_VertAlignment, LALIGN_CENTER,
                LAYOUT_HorizAlignment, LALIGN_CENTER,

                LAYOUT_AddImage, LabelObject,
                    LABEL_Text, "Freq: ",
                LabelEnd,

                LAYOUT_AddChild, gadgets[GID_FREQSLIDER] = SliderObject,
                    SLIDER_Min, 800,
                    SLIDER_Max, 4800,
                    SLIDER_Level, initialFreq,
                    SLIDER_Orientation, SLIDER_HORIZONTAL,
                    GA_RelVerify, TRUE,
                    GA_Immediate, TRUE,
                    GA_FollowMouse, TRUE,
                    GA_ID, GID_FREQSLIDER,
                SliderEnd,
                CHILD_MinWidth, 100,
                CHILD_WeightedWidth, 0,

                LAYOUT_AddChild, gadgets[GID_FREQGROUP] = VGroupObject,
                    LAYOUT_VertAlignment, LALIGN_CENTER,
                    LAYOUT_HorizAlignment, LALIGN_CENTER,

                    LAYOUT_AddChild, gadgets[GID_FREQ] = ButtonObject,
                        BUTTON_Integer, initialFreq*10,
                        BUTTON_BevelStyle, BVS_NONE,
                        BUTTON_Transparent, TRUE,
                        GA_ReadOnly, TRUE,
                        GA_ID, GID_FREQ,
                    ButtonEnd,
                LayoutEnd,

            LayoutEnd,

            #endif

            LAYOUT_AddChild, gadgets[GID_BUTTONGROUP] = HGroupObject,
                LAYOUT_VertAlignment, LALIGN_CENTER,
                LAYOUT_HorizAlignment, LALIGN_CENTER,

                LAYOUT_AddChild, gadgets[GID_BLACK] = ButtonObject,
                    GA_ID, GID_BLACK,
                    GA_RelVerify, TRUE,
                    BUTTON_PushButton, TRUE,
                ButtonEnd,

                LAYOUT_AddChild, gadgets[GID_RED] = ButtonObject,
                    GA_ID, GID_RED,
                    GA_RelVerify, TRUE,
                    BUTTON_PushButton, TRUE,
                ButtonEnd,

                LAYOUT_AddChild, gadgets[GID_GREEN] = ButtonObject,
                    GA_ID, GID_GREEN,
                    GA_RelVerify, TRUE,
                    BUTTON_PushButton, TRUE,
                ButtonEnd,

                LAYOUT_AddChild, gadgets[GID_BLUE] = ButtonObject,
                    GA_ID, GID_BLUE,
                    GA_RelVerify, TRUE,
                    BUTTON_PushButton, TRUE,
                ButtonEnd,

                LAYOUT_AddChild, gadgets[GID_YELLOW] = ButtonObject,
                    GA_ID, GID_YELLOW,
                    GA_RelVerify, TRUE,
                    BUTTON_PushButton, TRUE,
                ButtonEnd,

            LayoutEnd,

            LAYOUT_AddChild, gadgets[GID_PALETTE] = PaletteObject,
                GA_ID, GID_PALETTE,
                GA_RelVerify, TRUE,
                PALETTE_Colour, 0,
                PALETTE_NumColours, maxColours,
            PaletteEnd,
            CHILD_MinWidth, 256,
            CHILD_MinHeight, 64,

            LAYOUT_AddChild, ButtonObject,
                GA_ID, GID_OK,
                GA_RelVerify, TRUE,
                GA_Text,"_OK",
            ButtonEnd,
            CHILD_WeightedHeight, 0,

        EndGroup,
    EndWindow;


    objects[OID_GAMEOVER] = WindowObject,
        WA_ScreenTitle, name,
        WA_Title, "Game Over",
        WA_Activate, TRUE,
        WA_DepthGadget, TRUE,
        WA_DragBar, TRUE,
        WA_IDCMP, IDCMP_CHANGEWINDOW | IDCMP_VANILLAKEY,
        WA_CloseGadget, TRUE,
        WINDOW_AppPort, AppPort,
        WINDOW_Position, WPOS_CENTERSCREEN,
        WINDOW_ParentGroup, gadgets[GID_GAMEOVER] = VGroupObject,
            LAYOUT_SpaceOuter, TRUE,
            LAYOUT_DeferLayout, TRUE,
            LAYOUT_HorizAlignment, LALIGN_CENTER,

            LAYOUT_AddImage, LabelObject,
                LABEL_Justification, LJ_CENTRE,
                LABEL_Text, "\nNo More Moves...\n\n",
            LabelEnd,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_VertAlignment, LALIGN_CENTER,
                LAYOUT_HorizAlignment, LALIGN_CENTER,
                LAYOUT_BevelStyle, BVS_FIELD,
                GA_BackFill, NULL,
                LAYOUT_AddImage, LabelObject,
                    LABEL_Text, turnBonusBuf,
                LabelEnd,
            LayoutEnd,

            LAYOUT_AddChild, ButtonObject,
                GA_ID, GID_OK,
                GA_RelVerify, TRUE,
                GA_Text,"_OK",
            ButtonEnd,
            CHILD_WeightedHeight, 0,

        EndGroup,
    EndWindow;


    objects[OID_NAMEENTRY] = WindowObject,
        WA_ScreenTitle, name,
        WA_Title, "New High Score",
        WA_Activate, TRUE,
        WA_DepthGadget, TRUE,
        WA_DragBar, TRUE,
        WA_IDCMP, IDCMP_CHANGEWINDOW | IDCMP_VANILLAKEY,
        WA_CloseGadget, TRUE,
        WINDOW_AppPort, AppPort,
        WINDOW_Position, WPOS_CENTERSCREEN,
        WINDOW_ParentGroup, gadgets[GID_NAMEENTRY] = VGroupObject,
            LAYOUT_SpaceOuter, TRUE,
            LAYOUT_DeferLayout, TRUE,
            LAYOUT_HorizAlignment, LALIGN_CENTER,

            LAYOUT_AddImage, LabelObject,
                LABEL_Justification, LJ_CENTRE,
                LABEL_Text, "Congratulations!\n",
                LABEL_Text, "Please Enter Your Name:\n",
            LabelEnd,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_HorizAlignment, LALIGN_CENTER,
                LAYOUT_VertAlignment, LALIGN_CENTER,

                LAYOUT_AddChild, SpaceObject,
                    SPACE_MinWidth, 20,
                SpaceEnd,

                LAYOUT_AddChild, gadgets[GID_NAME] = StringObject,
                    STRINGA_TextVal, "",
                    STRINGA_MaxChars, 11,
                    GA_RelVerify, TRUE,
                    GA_ID, GID_NAME,
                LayoutEnd,

                LAYOUT_AddChild, SpaceObject,
                    SPACE_MinWidth, 20,
                SpaceEnd,
            LayoutEnd,

            LAYOUT_AddChild, ButtonObject,
                GA_ID, GID_OK,
                GA_RelVerify, TRUE,
                GA_Text,"_OK",
            ButtonEnd,
            CHILD_WeightedHeight, 0,

        EndGroup,
    EndWindow;


    objects[OID_HISCORES] = WindowObject,
        WA_ScreenTitle, name,
        WA_Title, "Hi-Scores",
        WA_Activate, TRUE,
        WA_DepthGadget, TRUE,
        WA_DragBar, TRUE,
        WA_IDCMP, IDCMP_CHANGEWINDOW | IDCMP_VANILLAKEY,
        WA_CloseGadget, TRUE,
        WINDOW_AppPort, AppPort,
        WINDOW_Position, WPOS_CENTERSCREEN,
        WINDOW_ParentGroup, gadgets[GID_HISCORES] = VGroupObject,
            LAYOUT_SpaceOuter, TRUE,
            LAYOUT_DeferLayout, TRUE,
            LAYOUT_HorizAlignment, LALIGN_CENTER,

            LAYOUT_AddImage, LabelObject,
                LABEL_Justification, LJ_CENTRE,
                LABEL_Text, "> > > Top Five < < <",
            LabelEnd,

            LAYOUT_AddChild, VGroupObject,
                LAYOUT_BevelStyle, BVS_SBAR_VERT,
                LAYOUT_VertAlignment, LALIGN_CENTER,
            LayoutEnd,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_AddImage, LabelObject,
                    LABEL_Text, " 1 ",
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSNAME1] = LabelObject,
                    LABEL_Text, hiScores[0].name,
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSSCORE1] = LabelObject,
                    LABEL_Text, hiScores[0].scoreText,
                LabelEnd,
            LayoutEnd,
            CHILD_WeightedHeight, 0,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_AddImage, LabelObject,
                    LABEL_Text, " 2 ",
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSNAME2] = LabelObject,
                    LABEL_Text, hiScores[1].name,
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSSCORE2] = LabelObject,
                    LABEL_Text, hiScores[1].scoreText,
                LabelEnd,
            LayoutEnd,
            CHILD_WeightedHeight, 0,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_AddImage, LabelObject,
                    LABEL_Text, " 3 ",
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSNAME3] = LabelObject,
                    LABEL_Text, hiScores[2].name,
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSSCORE3] = LabelObject,
                    LABEL_Text, hiScores[2].scoreText,
                LabelEnd,
            LayoutEnd,
            CHILD_WeightedHeight, 0,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_AddImage, LabelObject,
                    LABEL_Text, " 4 ",
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSNAME4] = LabelObject,
                    LABEL_Text, hiScores[3].name,
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSSCORE4] = LabelObject,
                    LABEL_Text, hiScores[3].scoreText,
                LabelEnd,
            LayoutEnd,
            CHILD_WeightedHeight, 0,

            LAYOUT_AddChild, HGroupObject,
                LAYOUT_AddImage, LabelObject,
                    LABEL_Text, " 5 ",
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSNAME5] = LabelObject,
                    LABEL_Text, hiScores[4].name,
                LabelEnd,

                LAYOUT_AddImage, gadgets[GID_HSSCORE5] = LabelObject,
                    LABEL_Text, hiScores[4].scoreText,
                LabelEnd,
            LayoutEnd,
            CHILD_WeightedHeight, 0,

            LAYOUT_AddChild, ButtonObject,
                GA_ID, GID_OK,
                GA_RelVerify, TRUE,
                GA_Text,"_OK",
            ButtonEnd,
            CHILD_WeightedHeight, 0,

        EndGroup,
    EndWindow;


    /* Create the main window object */
    objects[OID_MAIN] = WindowObject,
        WA_ScreenTitle, name,
        WA_Title, name,
        WA_Activate, TRUE,
        WA_DepthGadget, TRUE,
        WA_DragBar, TRUE,
        WA_CloseGadget, TRUE,
        WA_SizeGadget, TRUE,
        WA_IDCMP, IDCMP_NEWSIZE|IDCMP_REFRESHWINDOW|IDCMP_MOUSEBUTTONS,
        WA_SimpleRefresh, TRUE,
        WINDOW_IDCMPHookBits, IDCMP_REFRESHWINDOW,
        WINDOW_IDCMPHook, &idcmpHook,
        WINDOW_IconifyGadget, TRUE,
        WINDOW_IconTitle, name,
        WINDOW_AppPort, AppPort,
        WINDOW_Position, WPOS_CENTERSCREEN,
        WINDOW_ParentGroup, gadgets[GID_MAIN] = VGroupObject,
            LAYOUT_SpaceOuter, TRUE,
            LAYOUT_DeferLayout, TRUE,
            LAYOUT_HorizAlignment, LALIGN_CENTER,

            LAYOUT_AddChild, gadgets[GID_LAYOUT] = HGroupObject,
                LAYOUT_HorizAlignment, LALIGN_CENTER,
                LAYOUT_VertAlignment, LALIGN_CENTER,
                LAYOUT_AddChild, HGroupObject,
                    LAYOUT_VertAlignment, LALIGN_CENTER,
                    LAYOUT_HorizAlignment, LALIGN_CENTER,
                    LAYOUT_SpaceInner, TRUE,

                    GA_BackFill, NULL,

                    LAYOUT_AddImage, gadgets[GID_TURN] = (struct Gadget *) LabelObject,
                        LABEL_Text, turnBuf,
                    LabelEnd,
                    LAYOUT_BevelStyle, BVS_FIELD,
                LayoutEnd,

                LAYOUT_AddChild, HGroupObject,

                    LAYOUT_AddChild, VGroupObject,

                        LAYOUT_VertAlignment, LALIGN_CENTER,
                        LAYOUT_HorizAlignment, LALIGN_CENTER,

                        LAYOUT_AddImage, LabelObject,
                            LABEL_Justification, LJ_CENTRE,
                            LABEL_Text, "--- AmiBlocks ---\n\n",
                            LABEL_Text, "© JON 2002-2003\n",
                        LabelEnd,

                        LAYOUT_AddChild, /*gadgets[GID_ABOUTBTN] = (struct Gadget *)*/ ButtonObject,
                            GA_ID, GID_ABOUTBTN,
                            GA_RelVerify, TRUE,
                            GA_Text,"_About",
                        ButtonEnd,
                        CHILD_WeightedWidth, 0,
                        CHILD_WeightedHeight, 0,

                    LayoutEnd,

                LayoutEnd,


                LAYOUT_AddChild, HGroupObject,
                    LAYOUT_VertAlignment, LALIGN_CENTER,
                    LAYOUT_HorizAlignment, LALIGN_CENTER,
                    LAYOUT_SpaceInner, TRUE,

                    GA_BackFill, NULL,

                    LAYOUT_AddImage, gadgets[GID_SCORE] = (struct Gadget *) LabelObject,
                        LABEL_Text, scoreBuf,
                    LabelEnd,
                    LAYOUT_BevelStyle, BVS_FIELD,
                LayoutEnd,

            LayoutEnd,
            CHILD_WeightedHeight, 0,

            LAYOUT_AddChild, VGroupObject,
                GA_BackFill, NULL,
                LAYOUT_SpaceOuter, TRUE,
                LAYOUT_VertAlignment, LALIGN_CENTER,
                LAYOUT_HorizAlignment, LALIGN_CENTER,
                LAYOUT_BevelStyle, BVS_FIELD,

                LAYOUT_AddImage, gadgets[GID_BEVEL] = BevelObject,
                    GA_ID, GID_BEVEL,
                    BEVEL_Transparent, TRUE,
                    BEVEL_Style, BVS_NONE,
                LayoutEnd,

                CHILD_MinWidth, 200,
                CHILD_MinHeight, 200,

            LayoutEnd,

            LAYOUT_AddChild, HGroupObject,

                LAYOUT_AddChild, gadgets[GID_UNDO] = ButtonObject,
                    GA_ID, GID_UNDO,
                    GA_RelVerify, TRUE,
                    GA_Text,"_Undo Move",
                    GA_Disabled, TRUE,
                ButtonEnd,
                CHILD_WeightedHeight, 0,

                LAYOUT_AddChild, SpaceObject,
                    SPACE_MinWidth, 20,
                SpaceEnd,

                LAYOUT_AddChild, ButtonObject,
                    GA_ID, GID_PREFS,
                    GA_RelVerify, TRUE,
                    GA_Text,"_?",
                ButtonEnd,
                CHILD_WeightedHeight, 0,

                LAYOUT_AddChild, SpaceObject,
                    SPACE_MinWidth, 20,
                SpaceEnd,

                LAYOUT_AddChild, ButtonObject,
                    GA_ID, GID_NEWGAME,
                    GA_RelVerify, TRUE,
                    GA_Text,"_New Game",
                ButtonEnd,
                CHILD_WeightedHeight, 0,

            LayoutEnd,
            CHILD_WeightedHeight, 0,

        EndGroup,
    EndWindow;

    if ( objects[OID_MAIN] && objects[OID_GAMEOVER]
        && objects[OID_HISCORES] && objects[OID_NAMEENTRY]
        && objects[OID_PREFS] && objects[OID_ABOUT]
        && objects[OID_CONFIRMATION] )
    {
        return TRUE;
    } else return FALSE;

}


/* Main event loop */
void play(void) {

    struct RastPort *rp = windows[WID_MAIN]->RPort;

    ULONG wait, signal, app = (1L << AppPort->mp_SigBit);
    ULONG result;
    UWORD code;

    /* Obtain the window wait signal mask */
    GetAttr(WINDOW_SigMask, objects[OID_MAIN], &signal);

    /* Input Event Main Loop */
    while (!done)
    {
        wait = Wait( signal | SIGBREAKF_CTRL_C | app );

        if ( wait & SIGBREAKF_CTRL_C )
        {
            done = TRUE;
        }
        else
        {
            while ( (result = RA_HandleInput(objects[OID_MAIN], &code) ) != WMHI_LASTMSG )
            {

                switch (result & WMHI_CLASSMASK)
                {

                    case WMHI_NEWSIZE:
                        /* Get the dimension of the game area */
                        GetAttr( BEVEL_InnerLeft, gadgets[GID_BEVEL], &innerLeft );
                        GetAttr( BEVEL_InnerTop, gadgets[GID_BEVEL], &innerTop );
                        GetAttr( BEVEL_InnerWidth, gadgets[GID_BEVEL], &innerWidth );
                        GetAttr( BEVEL_InnerHeight, gadgets[GID_BEVEL], &innerHeight );

                        if ( ( (innerWidth % XSIZE) != 0 ) || ( (innerHeight % YSIZE) != 0 ) ) {
                            innerWidth = innerWidth - (innerWidth % XSIZE);
                            innerHeight = innerHeight - (innerHeight % YSIZE);
                        }

                        x = innerWidth / XSIZE;
                        y = innerHeight / YSIZE;

                        refreshGame( rp );
                        break;

                    case WMHI_CLOSEWINDOW:
                        windows[WID_MAIN] = NULL;
                        done = TRUE;
                        break;

                    case WMHI_MOUSEBUTTONS: {

                        static WORD fromX, fromY, toX, toY;
                        static BYTE c;
                        UBYTE range;

                        /* Mouse down.. */
                        if ( code == SELECTDOWN ) {
                            fromX = windows[WID_MAIN]->MouseX;
                            fromY = windows[WID_MAIN]->MouseY;

                            if ( checkLimits( fromX, fromY) ) {
                                c = getPiece( fromX, fromY );

                                /* If the black pieces are in the game, treat them as empty squares.. */
                                if ( ( c == COL_BLACK ) && (inmovable) )
                                    c = COL_NONE;

                            }

                        }

                        /* Mouse up.. */
                        if ( code == SELECTUP ) {
                            toX = windows[WID_MAIN]->MouseX;
                            toY = windows[WID_MAIN]->MouseY;

                            /* if empty space, we can move */
                            if ( checkLimits( fromX, fromY ) && checkLimits( toX, toY) ) {
                                if ( ( c != COL_NONE ) && ( getPiece( toX, toY ) == COL_NONE ) ) {

                                    if ( range = checkRange( fromX, fromY, toX, toY) ) {

                                        saveSituation(); /* for Undo */

                                        markAtWith( (UBYTE)((fromX-innerLeft)/x), (UBYTE)((fromY-innerTop)/y), COL_NONE );
                                        markAtWith( (UBYTE)((toX-innerLeft)/x), (UBYTE)((toY-innerTop)/y), c );

                                        moves = moves + range;

                                        refreshGame( rp );
                                        checkBoard( rp );

                                        /* When there's no more moves left, take next turn */
                                        if ( ( (ULONG)moves % movesPerTurn ) == 0) {
                                            nextTurn( rp );
                                            refreshGame( rp );

                                            checkBoard( rp );

                                            if (findFree() > 0)
                                            turn++;

                                            //printf("Next Turn\n");
                                            moves = 0;
                                            refreshGame( rp );
                                        }

                                        /* Board full -> Game Over ? */
                                        if ( emptyLeft == 0 ) {
                                            score = score + turn; /* give turn bonus ! */
                                            updateStats();
                                            gameOver();
                                            checkHiScores();
                                        }

                                        updateStats();

                                    }
                                }
                            }

                        }
                    } break;

                    case WMHI_GADGETUP:
                        switch (result & WMHI_GADGETMASK)
                        {

                            case GID_ABOUTBTN:
                                about();
                                break;

                            case GID_UNDO:

                                if ( (emptyLeft > 0) && (turn > 1) ) {
                                    SetGadgetAttrs( gadgets[GID_UNDO], windows[WID_MAIN], NULL, GA_Disabled, TRUE, TAG_DONE );
                                    undoMove( windows[WID_MAIN]->RPort );
                                }
                                break;

                            case GID_PREFS:
                                prefs();
                                break;

                            case GID_NEWGAME:
                                if ( turn > 1 ) {
                                    if ( findFree() == 0 ) {
                                        SetGadgetAttrs( gadgets[GID_UNDO], windows[WID_MAIN], NULL, GA_Disabled, FALSE, TAG_DONE );
                                        newGame();
                                    } else if ( confirmation(/*"New Game?"*/) ) {
                                        SetGadgetAttrs( gadgets[GID_UNDO], windows[WID_MAIN], NULL, GA_Disabled, FALSE, TAG_DONE );
                                        newGame();
                                    }
                                } else {
                                    SetGadgetAttrs( gadgets[GID_UNDO], windows[WID_MAIN], NULL, GA_Disabled, FALSE, TAG_DONE );
                                    newGame();
                                }
                            break;

                        }
                        break;

                    case WMHI_ICONIFY:
                        RA_Iconify(objects[OID_MAIN]);
                        windows[WID_MAIN] = NULL;
                        break;

                    case WMHI_UNICONIFY:
                        windows[WID_MAIN] = (struct Window *) RA_OpenWindow(objects[OID_MAIN]);

                        if (windows[WID_MAIN])
                        {
                            GetAttr(WINDOW_SigMask, objects[OID_MAIN], &signal);
                        }
                        else
                        {
                            done = TRUE;    /* Error... */
                        }
                        break;
                }

            }
        }
    }

} /* play() */


/* The Main Loop */
int main(void)
{

    /* Make sure our classes opened... */
    if ( !openLibs() ) {
        printf("Error while opening libraries or classes!\n");
        closeLibs();
        return(30);
    } else if ( AppPort = CreateMsgPort() ) {

        #ifdef MUSIC
            /* Construct list of OctaMED songs */
            NewList( &songList );
            buildListOfSongs("music");
        #endif

        /*  If the object creation was successful, let's play then */
        if ( initObjects() )
        {
            #ifdef MUSIC
                BOOL error = FALSE;

                error = playSong( 0 );
            #endif

            /*  Open the window */
            if (windows[WID_MAIN] = (struct Window *) RA_OpenWindow(objects[OID_MAIN]))
            {

                struct Screen *sc = windows[WID_MAIN]->WScreen;
                struct ViewPort *vp =  &(sc->ViewPort);

                struct DrawInfo *drawInfo;
                
                if ( drawInfo = GetScreenDrawInfo(sc) ) {

                    UBYTE depth = drawInfo->dri_Depth;

                    if ( depth > 7 ) {
                        maxColours = 256;
                    } else {
                        maxColours = 2 << depth;
                    }

                    cm = vp->ColorMap;

                    /* Get some pens.. */
                    blackPen = ObtainBestPen( cm, (ULONG)0L, (ULONG)0L, (ULONG)0L, TAG_DONE );
                    redPen = ObtainBestPen( cm, (ULONG)0xf3000000, (ULONG)0x43000000, (ULONG)0xaf000000, TAG_DONE );
                    greenPen = ObtainBestPen( cm, (ULONG)0, (ULONG)0xbd000000, (ULONG)0x89000000, TAG_DONE );
                    bluePen = ObtainBestPen( cm, (ULONG)0x77000000, (ULONG)0x8f000000, (ULONG)0xce000000, TAG_DONE );
                    yellowPen = ObtainBestPen( cm, (ULONG)0xf1000000, (ULONG)0xff000000, (ULONG)0x8b000000, TAG_DONE );

                    /* Load high scores */
                    loadHS();

                    /* Initialize statistics */
                    updateStats();

                    /* Go to the main loop */
                    play();

                    /* Save new high scores */
                    
                    if ( newHiScore )
                        saveHS();

                    /* Release allocated pens */
                    if ( !blackReleased )
                        ReleasePen(cm, blackPen );
                    if ( !greenReleased )
                        ReleasePen(cm, greenPen );
                    if ( !redReleased )
                        ReleasePen(cm, redPen );
                    if ( !blueReleased )
                        ReleasePen(cm, bluePen );
                    if ( !yellowReleased )
                        ReleasePen(cm, yellowPen );

                    FreeScreenDrawInfo(sc, drawInfo);
                }
            }

            #ifdef MUSIC
                /* Shut down the player */
                if ( (sng != NULL) ) {
                    closePlayer( (struct MMD0 *)sng);
                }
            #endif

            /* Destroy window Objects and their contents */
            DisposeObject(objects[OID_MAIN]);
            DisposeObject(objects[OID_GAMEOVER]);
            DisposeObject(objects[OID_HISCORES]);
            DisposeObject(objects[OID_NAMEENTRY]);
            DisposeObject(objects[OID_PREFS]);
            DisposeObject(objects[OID_ABOUT]);
            DisposeObject(objects[OID_CONFIRMATION]);

        }

        #ifdef MUSIC
            /* Release the song list */
            destroyList();
        #endif

        DeleteMsgPort(AppPort);
    }
    closeLibs();

    return(0);

} /* Still reading ?-) */
