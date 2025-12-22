/*
** styx.c
**
** a crash indicator for Apollo 2030 users
**
** Version: see below (version_str)
**
** TODO:
** - Add Menu: About/Options../Quit
** - Add Options requester to set delay & smart flag
** - Add args & tooltypes
*/

/*
** amiga includes
*/
#include <exec/types.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>
#include <dos/dos.h>
#include <graphics/gfxbase.h>

#ifndef __MAXON__

/* 
** generic includes 
*/
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>

#else

/* 
** Maxon/c includes & defs
*/
#include <pragma/exec_lib.h>
#include <pragma/dos_lib.h>
#include <pragma/graphics_lib.h>
#include <pragma/intuition_lib.h>

/* output window for wbmain() */
#define WBWINNAME "CON:0/1/400/100/styx - Output/CLOSE/WAIT/AUTO"
#include <wbstartup.h>

#endif /* __MAXON__ */

/*
** ansi includes
*/
#include <stdio.h>
#include <stdlib.h>



#define MAX_STXP_NUM 1000  /* max. num of points */

#define SIZE_STEP (1<<2)   /* num. of pixels a stick steps */
#define MASK_STEP ((ULONG)-(SIZE_STEP))

#define MIN_WIDTH    48
#define MIN_HEIGHT   48
#define MAX_WIDTH    -1
#define MAX_HEIGHT   -1

/*
** global vars
*/
struct IntuitionBase *IntuitionBase = NULL;
struct GfxBase       *GfxBase = NULL;
struct Window        *StyxWin = NULL;

ULONG width  = 100; /* default window inner size */
ULONG height = 72;  
ULONG ptnum  = 12;  /* number of styx points */
ULONG delay  = 9;   /* 1/50 of second */
ULONG smart  = 1;   /* 1: redraw ALL lines after last line cleared (slow) */
                    /* 0: no redraw after last line erased (ugly&fast) */

ULONG old_width;    /* old window size */
ULONG old_height;

/*
** structure for styx point
*/
typedef struct styx_rec {

    LONG pos_x; /* position */
    LONG pos_y;
    BYTE dir_x;  /* direction */
    BYTE dir_y;

} STXP;

STXP stxp1[ MAX_STXP_NUM ],
     stxp2[ MAX_STXP_NUM ];

struct RastPort *rp = NULL;
BYTE bx = 0; /* border size of window */
BYTE by = 0;


/*
** proto types
*/
BOOL open_libs( VOID );
VOID cleanup( VOID );
VOID draw_styx( VOID );
int get_rand( int max );
VOID inc_stxp( STXP *stxp );
VOID draw_stxpline( LONG num, BYTE pen );


/*
** open_libs
**
** open intuition & graphics library
*/
BOOL open_libs( VOID )
{
    BOOL ok = TRUE;

    IntuitionBase = (struct IntuitionBase *)
        OpenLibrary( "intuition.library", 37L );
    if ( !IntuitionBase ) {

        fprintf( stderr, "Can't open \"Intuition.library\" v37\n" );
        ok = FALSE;

    }
    GfxBase = (struct GfxBase *)
        OpenLibrary( "graphics.library", 37L );
    if ( !GfxBase ) {

        fprintf( stderr, "Can't open \"graphics.library\" v37\n" );
        ok = FALSE;

    }

    return( ok );
}


/*
** cleanup
*/
VOID cleanup( VOID )
{
    if ( IntuitionBase)
        CloseLibrary( (struct Library *) IntuitionBase );
    if ( GfxBase)
        CloseLibrary( (struct Library *) GfxBase );
    if ( StyxWin )
        CloseWindow( StyxWin );
}


/* get_rand */
int get_rand( int max )
{
    int rnd;

    do {
        rnd = rand() & 0xfff;
    } while ( rnd > max );

    rnd = rnd & MASK_STEP;

    return ( rnd );


}

/* inc_stxp */
VOID inc_stxp( STXP *stxp )
{

    /* flip directions if neccessary */
    if ( (stxp->pos_x==0) || (stxp->pos_x==width) )
        stxp->dir_x = (-stxp->dir_x);
    if ( (stxp->pos_y==0) || (stxp->pos_y==height) )
        stxp->dir_y = (-stxp->dir_y);

    /* update position */
    stxp->pos_x += (stxp->dir_x*SIZE_STEP);
    stxp->pos_y += (stxp->dir_y*SIZE_STEP);

#if 0
    printf( "(%d/%d) [%d/%d]\n",
             stxp->pos_x, stxp->pos_y, stxp->dir_x, stxp->dir_y );
#endif

}

VOID draw_stxpline( LONG num, BYTE pen )
{

    SetAPen( rp, pen );
    Move( rp, bx+stxp1[num].pos_x, by+stxp1[num].pos_y );
    Draw( rp, bx+stxp2[num].pos_x, by+stxp2[num].pos_y );
}

/*
** init_styx
*/
VOID init_styx( VOID )
{
    int rndx1, rndx2, rndy1, rndy2;    /* random start position */
    LONG i;                            /* loop var */

    /* adjust width & height */
    width  = width  & MASK_STEP;
    height = height & MASK_STEP;
    old_width = width;
    old_height = height;

    /* compute random start position */
    rndx1 = get_rand( width );
    rndx2 = get_rand( width );
    rndy1 = get_rand( height );
    rndy2 = get_rand( height );

    /* init rastport vars */
    rp = StyxWin->RPort;
    bx = StyxWin->BorderLeft;
    by = StyxWin->BorderTop;

    /* init styx points */
    for ( i=0; i<ptnum; i++ ) {

        stxp1[i].pos_x = rndx1;
        stxp1[i].pos_y = rndy1;
        stxp1[i].dir_x = 1;
        stxp1[i].dir_y = 1;
        stxp2[i].pos_x = rndx2;
        stxp2[i].pos_y = rndy2;
        stxp2[i].dir_x =  1;
        stxp2[i].dir_y = -1;

    }


}

/*
** draw_styx
*/
VOID draw_styx( VOID )
{
    LONG  i;       /* loop vars */
    STXP *stxp;    /* styx-point */

    SetAPen( rp, 1 );

    /* erase last stxp-line*/
    draw_stxpline( ptnum-1, 0 );

    /* erase last styx-position */
    for ( i=ptnum-1; i>0; i-- ) {

        stxp1[i] = stxp1[i-1];
        stxp2[i] = stxp2[i-1];

    }

    /* if smart, redraw all lines */
    /* TODO: only lines that have been overwritten */
    if ( smart )
        for ( i=ptnum-1; i>0; i-- )
            draw_stxpline( i, 1 );

    /* move first styx */
    stxp = &(stxp1[0]);
    inc_stxp( stxp );
    stxp = &(stxp2[0]);
    inc_stxp( stxp );

    /* draw new stxp-line*/
    draw_stxpline( 0, 1 );

}

/*
** resize_styx
*/
VOID refresh_styx( VOID )
{
    struct IntuiMessage *imsg;
    BOOL                 sized = FALSE;
    ULONG                i;

    /* compute new width & height */
    width  = StyxWin->Width - StyxWin->BorderLeft - StyxWin->BorderRight -1;
    height = StyxWin->Height - StyxWin->BorderTop - StyxWin->BorderBottom -1;
    width  = width  & MASK_STEP;
    height = height & MASK_STEP;

#if 0
    printf( "refresh: (%d,%d) old:(%d,%d)\n",
            width, height, old_width, old_height );
#endif

#if 0
    /* wait for IDCMP_CHANGEWINDOW */
    WaitPort( StyxWin->UserPort );
    while ( imsg = (struct IntuiMessage *) GetMsg( StyxWin->UserPort ) ) {

        if ( imsg->Class & IDCMP_CHANGEWINDOW )
            sized = TRUE;
        ReplyMsg( (struct Message *) imsg );

    }
#endif


    /* clear whole styx */
    for ( i=0; i<ptnum; i++ )
        draw_stxpline( i, 0 );

    /* strip styx points */
    /* TODO: improve this */
    if ( (width != old_width) || (height != old_height) )
        init_styx();

}

/*
** open styx window
*/
BOOL open_styx_window( void )
{
    BOOL ok = TRUE;

    struct TagItem SWTags[] = {
        { WA_InnerWidth, (ULONG) 0 },
        { WA_InnerHeight, (ULONG) 0 },
        { WA_MinWidth, (ULONG) MIN_WIDTH },
        { WA_MinHeight, (ULONG) MIN_HEIGHT },
        { WA_MaxWidth, (ULONG) MAX_WIDTH },
        { WA_MaxHeight, (ULONG) MAX_HEIGHT },
        { WA_Left, (ULONG) 599 },
        { WA_Title, (ULONG) "styx" },
        { WA_IDCMP, IDCMP_CLOSEWINDOW | /*IDCMP_SIZEVERIFY | */
                    IDCMP_REFRESHWINDOW },
        { WA_Flags, WFLG_CLOSEGADGET | WFLG_DRAGBAR |
                    WFLG_DEPTHGADGET | WFLG_SIZEGADGET |
                    WFLG_SIZEBBOTTOM | WFLG_SIMPLE_REFRESH },
        { TAG_DONE, NULL }
    };

#if 0
    printf( "STEP:  %d\nMASK  : %x\nwidth : %d\nheight: %d\n",
            SIZE_STEP, MASK_STEP, width, height );
#endif

    SWTags[0].ti_Data = (ULONG) width+1;
    SWTags[1].ti_Data = (ULONG) height+1;

    StyxWin = OpenWindowTagList( NULL, SWTags );
    if ( !StyxWin )
        ok = FALSE;

    return( ok );
}

VOID main( int argc, char *argv[] )
{
    static STRPTR version_str = "$VER: 1.0 styx (19.9.1995)";

    if ( open_libs() && open_styx_window() ) {

        BOOL quit = FALSE;
        struct IntuiMessage *imsg;

        init_styx();

        do {

            /* draw the styx */
            draw_styx();

            /* wait a bit */
            Delay( delay );

            /* get message and check for close */
            imsg = (struct IntuiMessage *) GetMsg( StyxWin->UserPort );
            if ( imsg ) {

                if ( imsg->Class & IDCMP_CLOSEWINDOW )
                    quit = TRUE;

                else if ( imsg->Class & IDCMP_REFRESHWINDOW )
                    refresh_styx();

                ReplyMsg( (struct Message *) imsg );

            }

        } while ( !quit );
    }

    cleanup();
}



