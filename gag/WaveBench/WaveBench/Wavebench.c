
/*
 * Wavebench.  A display hack & BKDC (Badge Killer Demo Contest) entry by
 * Bryce Nesbitt.  Subtitled, "The Deadline is _WHEN???_"
 *
 * "In the grand tradition of 'Viacom' this display hack is for people
 * who wish to get seasick while using the Amiga."
 *
 * Tested to compile without warnings under Lattice 3.03, Lattice 3.10 and
 * Manx 3.4b compilers.  Lattice 4.0 will be the next compiler to try out.
 * I'm new to this cross compiler stuff, hope its ok.  (Would you believe
 * it is smaller under Lattice 3.03 than Manx 3.4b??  Wierd, but true)
 *
 * Not guaranteed to work on any future versions of the Amiga computer.
 * It is almost guarnteed to fail on an MMU version of the Amiga.
 *
 * Try it before you read the technical desciption at the end of this file,
 * it's more fun that way.
 *
 * Bryce Nesbitt, 1712 Marin Ave., Berkeley, Ca 94707-2206
 * bryce@hoser.berkeley.EDU -or- ucbvax!hoser!bryce
 * bryce@cogsci.berkeley.EDU -or- ucbvax!cogsci!bryce
 */

#define SCAN_FACTOR 8L	    /* Change this to change the effect */
#undef	DEBUG

#include <exec/types.h>
#include <exec/memory.h>
#include <libraries/dos.h>
#include <libraries/dosextens.h>
#include <intuition/intuition.h>
#include <intuition/intuitionbase.h>
#include <hardware/custom.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <functions.h>

       struct IntuitionBase    *IntuitionBase;
       struct GfxBase	       *GfxBase;
       struct Window	       *MyWindowP;
       struct Screen	       *MyScreenP;
       struct ViewPort	       *MyViewPortP;
       struct View	       *MyViewP;
       struct UCopList	       *MyUCopListP;
       struct Process	       *MyProcessP;
       long			wsignals; /* What signals to exit on */
       long			key;	  /* LockIBase() key */

struct NewWindow MyWindow=
    {
    0,11,395,10,    /* Don't obscure drag bar, please! */
    3,1,
    CLOSEWINDOW,
    WINDOWCLOSE|SIMPLE_REFRESH|NOCAREREFRESH|WINDOWDRAG|WINDOWDEPTH,
    0,0,	     /* Don't forget NOCAREREFRESH if you don't    */
		    /* handle type REFRESHWINDOW IntuiMessages!   */
		   /* ACTIVATE is *not* set, since this window	 */
		  /* can't do anything with the keyboard anyway */
    (UBYTE *)"Wavebench by Bryce Nesbitt",
    0,0,
    1,1,-1,-1,	     /* Set maximum window sizes to -1,-1 for */
		    /* for people with big-screen displays   */
    WBENCHSCREEN,
    };



cleanexit(number,dos_code)
int  number;
long dos_code;
{
    if (MyWindowP)	CloseWindow (MyWindowP);
    if (GfxBase)	CloseLibrary(GfxBase);
    if (IntuitionBase)	CloseLibrary(IntuitionBase);
    MyProcessP->pr_Result2=dos_code;	/* Set secondary "why" result code */
    exit(number);
}


/* Set up the user copper list ready to be mangled by the animator portions
 * of the program.  Some wrinkles are needed to work for interlaced screens
 */
setclist()
{
long counter;

    key=LockIBase(0L);
    if (MyViewPortP->UCopIns)
	{ UnlockIBase(key); return(0); }
    MyUCopListP=(struct UCopList *)AllocMem(12L,MEMF_CLEAR+MEMF_PUBLIC);
    /* This allocates the UCopList structure.  The system will be
       responsible for deallocating it.  */

    CINIT( MyUCopListP,(MyScreenP->Height/SCAN_FACTOR<<2L)+2L );
    /* The manuals say that CINIT will allocate a UCopList if passed
       a zero.	This feature does not work, thus the AllocMem() */

#ifdef DEBUG
    printf("# copper instructions is %d\n",(MyScreenP->Height/SCAN_FACTOR<<2L)+2L );
#endif DEBUG

    for (counter=0; counter < MyScreenP->Height; counter+=SCAN_FACTOR)
	{
	CWait(MyUCopListP,counter,17L);   /* 15 is the start of h. blanking */
	CBump(MyUCopListP);
	CMove(MyUCopListP,0xDFF102L,counter&6L);
	CBump(MyUCopListP);
	}
    CEND (MyUCopListP);
    MyViewPortP->UCopIns=MyUCopListP;
    UnlockIBase(key);

    MakeScreen(MyScreenP);
    RethinkDisplay();
    return(1);
}



main()
{
struct CopList *TempDspIns;
struct CopList *TempSprIns;
struct CopList *TempClrIns;

    MyProcessP=(struct Process *)FindTask(0L);

    /* Open libraries with 0L, indicating any version is ok */
    if (!( IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library",0L) ))
	cleanexit(21,0L);
    if (!( GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",0L) ))
	cleanexit(22,0L);
    if (!( MyWindowP=(struct Window *)OpenWindow(&MyWindow) ))
	cleanexit(23,ERROR_NO_FREE_STORE);
    wsignals	= (1L<<MyWindowP->UserPort->mp_SigBit) | SIGBREAKF_CTRL_C;

    if ( GfxBase->LibNode.lib_Version < 33 )
	{				/* If older than Kickstart V1.2... */
	SetWindowTitles(MyWindowP,"Error: Requires Kickstart V1.2!",-1L);
	Wait (wsignals);
	cleanexit(5);
	}
    if ( AvailMem(MEMF_CHIP)<4096L )
	{
	SetWindowTitles(MyWindowP,"Error: Out of chip memory!",-1L);
	Wait (wsignals);
	cleanexit(24,ERROR_NO_FREE_STORE);
	}

    /* The Workbench screen can't close while our window is open! */

    MyScreenP	=MyWindowP->WScreen;
    MyViewP	=(struct View *)ViewAddress();
    MyViewPortP =(struct ViewPort *)ViewPortAddress(MyWindowP);

    if (!setclist())	    /* set up a user copper list on the workbench */
	{
	SetWindowTitles(MyWindowP,"Error: User copperlist in use!",-1L);
	Wait (wsignals);
	cleanexit(5);
	}
#ifdef DEBUG
    printf("\nWindow %lx, Screen %lx, hieght %lx\n",MyWindowP,MyScreenP,(long)MyScreenP->Height);
#endif DEBUG

    SetTaskPri(FindTask(0L),50L);   /* Bump our priority to 50 */
    manglecop(wsignals,MyViewP,GfxBase);
    SetTaskPri(FindTask(0L),0L);    /* Be nice, set our priority back */

    key=LockIBase(0L);	/* Deallocate only the UCopList we added */
    TempDspIns=MyViewPortP->DspIns;
    TempSprIns=MyViewPortP->SprIns;
    TempClrIns=MyViewPortP->ClrIns; /* Did I hear "register coloring?" :-) */
    TempDspIns=TempSprIns=TempClrIns=0;
    FreeVPortCopLists(MyViewPortP);  /* Deallocates the UCopList   */
				    /* and all that hangs from it */
    MyViewPortP->DspIns=TempDspIns;
    MyViewPortP->SprIns=TempSprIns;
    MyViewPortP->ClrIns=TempClrIns;
    UnlockIBase(key);

    MakeScreen(MyScreenP);
    RethinkDisplay();
    cleanexit(0);
}

/*
 * Technical description:
 *
 * The graphics co-processor (copper) is used to shift the horizontal
 * fine scroll bits on the specified scan lines.  This pattern is
 * rotated in a wave.  The range of these registers is 16 low resolution
 * pixels (32 high res).  The choice of the number of scan lines between
 * iterations is arbitrary, and may be as little as 1. (however there is
 * a benign bug in graphics that shows up with real low numbers)
 * The processor speed is not slowed down too much... dragging
 * screens, however, is. (Can you say "MrgCop()"?)
 *
 * The pointer sprite is not affected, since sprites have their own
 * independent scroll registers.
 *
 * This program must be considered "dirty" since it animates the copper list
 * itself (instead of using the hardware independent CINIT,CWAIT,CMOVE
 * facilities).  In general mucking with other people's screens is a rude
 * thing to do anyway.
 *
 * The program can be modified to affect any screen... but what if that
 * screen closes mid mangle?  Think about these things, please.
 *
 * The program is nice about telling the user that it requires Kickstart
 * V1.2, if started under an earlier version.
 */
