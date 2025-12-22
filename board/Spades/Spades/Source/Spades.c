/**********************************************************
* PROGRAM: Spades                                         *
* AUTHOR: Copyright 1992 Gregory M. Stelmack              *
* COMPILER: SAS/C 5.10b                                   *
*      Copyright (C) 1988 Lattice, Inc.                   *
*      Copyright (C) 1990 SAS Institute, Inc.             *
* VESRION DATES:                                          *
*      Version 1.0  -- February 5, 1990                   *
*      Version 1.1  -- April 28, 1990                     *
*           Images used for cards -- file "Spades.images" *
*           must be in current directory to run.          *
*           Title graphics added. New routine for         *
*           choosing dealer.                              *
*      Version 1.11 -- August 23, 1990                    *
*           Fixed memory freeing bug. Added some prompts. *
*      Version 1.12 -- October 3, 1990                    *
*           Removed LIBRARY_VERSION from OpenLibrary()    *
*           calls, replacing it with zero. An attempt to  *
*           let it run under pre-1.3.                     *
*      Version 1.20 -- April 4, 1991                      *
*           Error messages now pause. Revised strategy.   *
*           Window can be sized and dragged, and screen   *
*           moved to back to allow other things to be     *
*           done.                                         *
*      Version 2.00 -- January 26, 1992                   *
*           Window is now a backdrop, and the screen      *
*           gadgets are visible. Menus now used to select *
*           most options, and rules for NIL bids and Bags *
*           have been added as optional. Computer players *
*           do not yet take these rules into account. Due *
*           to use of EasyRequest() for About, Spades now *
*           requires V36 of Intuition Library (meaning    *
*           you need AmigaDOS 2.xx).                      *
*      Version 2.10 -- February 3, 1992                   *
*           Code clean up. Source broken up into multiple *
*           modules to allow for expansion room. Option to*
*           Save a Hand implemented. Computer strategy    *
*           now accounts for optional rules. More use of  *
*           V36 Library functions (including GadTools).   *
*      Version 2.11 -- March 14, 1992                     *
*           Removed call for EasyRequest() in error       *
*           routine if Intuition did not open. This is to *
*           clean up the GURU if run under 1.3.           *
*      Version 2.12 -- April 2, 1992                      *
*           When a game was started by selecting NewGame, *
*           the game would not quit except from the menu  *
*           (the final screen always continued the game). *
*           Bug fixed.                                    *
**********************************************************/

/* Include files */

#ifndef INCLUDE_H
#include "Include.h"
#endif

#include "Graphics.h"

/* Structures needed for libraries */

struct IntuitionBase *IntuitionBase;
struct GfxBase       *GfxBase;
struct Library       *DiskfontBase;
struct Library       *GadToolsBase;

/* OS Structures */

struct Screen       *CustScr;
struct Window       *Wdw;
struct Viewport     *WVP;
APTR                VI;          /* VisualInfo for GadTools */

/*************************** Arrays ***************************/
int Deck[52];
int Hand[4][13];
int Bid[4];
int Mode[4];
int HighCardLeft[4];
int Card[4] = {0,0,0,0};
int Value[13];
int SuitNumber[4];
int CardX[4] = {100,1,100,209};
int CardY[4] = {99,60,1,60};
int MsgX[4] = {116,45,116,195};
int MsgY[4] = {96,84,50,84};
BOOL OutOfSuit[4][4];
int TricksTaken[4];
int TrickLeader[14];
int CardPlayed[4][13];

/******************** Other Global Variables ******************/
static char *VersionString = "$VER: Spades 2.12 (2-Apr-92)";

char *String = "      ";   /* Temporary String Storage */

int PlayerScore=0, CompScore=0, PlayerTricks=0, CompTricks=0;
int HandLead=0, Button=0, TrickLead=0, PlayerBid=0, CompBid=0;
int ShortSuit=0, LongSuit=0, HighCard=0, Winner=0;
int PlayerBags=0, CompBags=0;
BOOL SpadePlayed=FALSE, ScreenOpen=FALSE;
BOOL BagsRule=FALSE, NilRule=FALSE, SaveHand=FALSE;
char *CardData;

SHORT Mx=0, My=0;        /* Mouse Coordinates */

/**************** Module Local Variables and Structures **********/

struct EasyStruct    ErrorES =
{
   sizeof(struct EasyStruct),
   0,
   "Spades Error",
   NULL,
   "QUIT"
};

/********************* Program Begins Here ********************/

/**********************************************************
* Function: main                                          *
* Purpose: Open everything, play the game, close          *
*          everything.                                    *
**********************************************************/
main()
{
   /* Initialize the Amiga */
   
   OpenAll();
   
   /* Start Game */

   Spades();
	
   /* Close Everything */

   WrapUp();
}

/**********************************************************
* Function: OpenAll                                       *
* Parameters: None                                        *
* Return Values: None                                     *
* Purpose: Handle the Amiga initialization                *
**********************************************************/
void OpenAll()
{
   BPTR fh;
   LONG count=0;
   BOOL success;
   
   /* Open the required libraries. */
   
   IntuitionBase = (struct IntuitionBase *) 
      OpenLibrary("intuition.library", 36L);
   if (IntuitionBase == NULL) 
      PError("Can't open Intuition Library");

   GfxBase = (struct GfxBase *) OpenLibrary("graphics.library",0);
   if (GfxBase == NULL)
      PError("Can't open Graphics Library");

   GadToolsBase = OpenLibrary("gadtools.library", 36L);
   if (GadToolsBase == NULL)
      PError("Can't open GadTools Library");
      
	/* Load Graphic Images */

   CardData = (char *)AllocMem(CARDMEMSIZE,MEMF_CHIP);
   if (!CardData)
      PError("Could not allocate image memory!");
   fh = Open("Spades.images",MODE_OLDFILE);
   if (fh==NULL)
      PError("Can't open images file!");
   count = Read(fh,CardData,CARDMEMSIZE);
   (void)Close(fh);
   if (count==-1)
      PError("Error reading images file!");

	/* Open the screen and window */
	
   if ((NewWindowStructure1.Screen = CustScr =
      (struct Screen *)OpenScreen(&NewScreenStructure)) == NULL)
      PError("Can't open new screen");
  	
   if (( Wdw = (struct Window *)OpenWindow(&NewWindowStructure1)) == NULL)
   {
      CloseScreen(CustScr);
      PError("Can't open new window");
   }
   
   ScreenOpen = TRUE;
  	
	/* Find the viewport and load color map */

   WVP = (struct ViewPort *)ViewPortAddress(Wdw);
   LoadRGB4(WVP,&Palette[0],PENS);

   /* Create and attach the menu */

   VI = GetVisualInfo(CustScr,NULL);
   if (VI == NULL)
      PError("Could not get VisualInfo");
   SpadesMenu = CreateMenus(&SpadesNewMenu[0],GTMN_FrontPen,BLKP);
   if (SpadesMenu == NULL)
      PError("Could not create Menu");
   success = LayoutMenus(SpadesMenu,VI,NULL);
   if (success == FALSE)
      PError("Could not layout Menu");
   SetMenuStrip(Wdw,SpadesMenu);

   /* Seed random number generator with TIMER */

   srand(time(NULL));
}

/**********************************************************
* Function: PError                                        *
* Parameters: s -- pointer to string to print             *
* Return Values: None                                     *
* Purpose: Handle a fatal error                           *
**********************************************************/
void PError(s)
char *s;
{
   ErrorES.es_TextFormat = s;
   
   if (IntuitionBase)
   {
      if (ScreenOpen)
            (void)EasyRequest(Wdw,&ErrorES,NULL,NULL);
      else
            (void)EasyRequest(NULL,&ErrorES,NULL,NULL);
   }
   
   WrapUp();
}

/**********************************************************
* Function: WrapUp                                        *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: close everything and exit                      *
**********************************************************/
void WrapUp()
{
   if (CardData)      FreeMem((char *)CardData,CARDMEMSIZE);
   if (SpadesMenu)    FreeMenus(SpadesMenu);
   if (Wdw)           CloseWindow(Wdw);
   if (VI)            FreeVisualInfo(VI);
   if (CustScr)       CloseScreen(CustScr);
   if (GfxBase)       CloseLibrary(GfxBase);
   if (IntuitionBase) CloseLibrary(IntuitionBase);
   exit(0);
}

/**********************************************************
* Function: Spades                                        *
* Parameters: None                                        *
* Return Values: None                                     *
* Purpose: Play a game of spades. Loop until someone      *
*          scores 500.                                    *
**********************************************************/
void Spades()
{
   /* Loop until player no longer wants to play. */
  
   FOREVER
   {
      PlayerScore=CompScore=0;
      HandLead=FindDealer();
      PlayerBags=CompBags=0;
      
      /* Loop until someone reaches 500 and there is no tie. */

      while (((PlayerScore<500)&&(CompScore<500))||
            (PlayerScore==CompScore))
      {
         SetUpScreen();
         InitVars();
         PrintScore();
         DealCards();
         GetBids();
         PrintBids();
         PlayHand();
      }

      FinishRoutine();
   }
}

/**********************************************************
* Function: FindDealer                                    *
* Parameters: none                                        *
* Return Values: the player determined to initially deal. *
* Purpose: find out who deals first in a game.            *
**********************************************************/
int FindDealer()
{
   int player=0, card=0, i;
   BOOL done=FALSE;

   SetRast(RP,BLUP);	/* Clear Screen */
   SetAPen(RP,YELP);
   SetBPen(RP,BLUP);

   for (i=0 ; i<52 ; i++) Deck[i]=0;   /* Set deck to undealt */

	Move(RP,70,70);         /* Warn player of what's happening */
   Text(RP,"Ace of Spades",13);
   Move(RP,98,78);
   Text(RP,"deals",5);

   while(!done)            /* Loop until dealer found */
   {
      while(Deck[card=rand()%52]) ;    /* Find undealt card  */
      Deck[card]=1;                    /* Mark card as dealt */
      DrawCard(CardX[player],CardY[player],card);  /* Draw card */
      Delay(10);           /* Pause */
      if (card==51)        /* Ace of Spades */
      {
         done=TRUE;
         Move(RP,MsgX[player],MsgY[player]);
         Text(RP,"*",1);
      }
      player=(++player)%4;    /* Increment player */
   }
  
   Move(RP,200,150);          /* Wait for player */
   Text(RP,"Click mouse",11);
   ReadMouse();

   SetRast(RP,BLUP);
   return((++player)%4);   /* Must return player 2 to left of
                              dealer. Program will later
                              decrement player to find new dealer
                              who should be to left of current dealer */
}
  
/**********************************************************
* Function: InitVars                                      *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Initialize variables and arrays for a new hand.*
**********************************************************/
void InitVars()
{
   int i;

   /* Set Leader */

   HandLead=(--HandLead+4)%4;
   TrickLead=HandLead;

   /* Reset HighCardLeft */

   HighCardLeft[0]=12;
   HighCardLeft[1]=12;
   HighCardLeft[2]=12;
   HighCardLeft[3]=12;
   
   /* Reset OutOfSuit */
  
   for (i=0 ; i<4 ; i++)
   {
      OutOfSuit[i][DIAMONDS]=FALSE;
      OutOfSuit[i][CLUBS]   =FALSE;
      OutOfSuit[i][HEARTS]  =FALSE;
      OutOfSuit[i][SPADES]  =FALSE;
   }
  
   /* Determine Modes */
   
   for (i=0 ; i<4 ; i++)
   {
      Mode[i]=0;
      if (i==HandLead) Mode[i]+=2;  /* Leader should bid higher */
      if (i==0||i==2)               /* Human players -- check score */
      {
         if ((PlayerScore>400)&&(CompScore<350)) Mode[i]-=1;
         if (PlayerScore<(CompScore-100)) Mode[i]+=1;
         if (PlayerScore<(CompScore-200)) Mode[i]+=1;
         if (PlayerScore>(CompScore+100)) Mode[i]-=1;
      }
      if (i==1||i==3)               /* Computer players -- check score */
      {
         if ((CompScore>400)&&(PlayerScore<350)) Mode[i]-=1;
         if (CompScore<(PlayerScore-100)) Mode[i]+=1;
         if (CompScore<(PlayerScore-200)) Mode[i]+=1;
         if (CompScore>(PlayerScore+100)) Mode[i]-=1;
      }
   }
}

/**********************************************************
* Function: DealCards                                     *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Shuffle & deal the deck to the players.        *
**********************************************************/
void DealCards()
{
   int i,j,player,cardnum[4];
  
   for (i=0 ; i<4 ; i++) cardnum[i]=0; /* Reset cards for each player */
   for (i=0 ; i<52 ; i++) Deck[i]=0;   /* Set whole deck to undealt   */
  
   /* Shuffle and Deal Deck */
  
   for (i=0 ; i<52 ; i++)
   {
      while(Deck[j=rand()%52]) ;    /* Find undealt card */
      Deck[j]=((i/13)+1);           /* Store owning player */
   }
  
   /* Transfer cards to player hands */

   for (i=0 ; i<52 ; i++)
   {
      player=Deck[i]-1;                    /* Get owning player */
      Hand[player][cardnum[player]++]=i+1; /* Store card, increment counter */
   }
}

/**********************************************************
* Function: itoa                                          *
* Parameters: n -- number to convert                      *
*             s -- pointer to result string               *
* Return Values: none                                     *
* Purpose: Convert an integer to a string so it can be    *
*          used by the Text function. Lattice does not    *
*          have one.                                      *
**********************************************************/
void itoa(n,s)
char *s;
int n;
{
   int i=0;
   BOOL sign=FALSE;
  
   if (n<0)
   {
      sign=TRUE;
      n=-n;
   }

   do
   {
      s[i++]=n%10+'0';
   } while((n/=10)>0);

   if (sign) s[i++]='-';
   s[i]='\0';
   strrev(s);
}
