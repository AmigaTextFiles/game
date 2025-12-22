/*
   FILE: Globals.h
   PURPOSE: Global variables for the Spades program
   AUTHOR: Gregory M. Stelmack
*/

#ifndef GLOBALS_H
#define GLOBALS_H 1
#endif

#ifndef INCLUDE_H
#include "Include.h"
#endif

/* Structures needed for libraries */

extern struct IntuitionBase *IntuitionBase;
extern struct GfxBase       *GfxBase;
extern struct Library       *DiskfontBase;

/* Intuition Structures */

extern struct Screen       *CustScr;
extern struct Window       *Wdw;
extern struct Viewport     *WVP;

/*************************** Arrays ***************************/

/*   Deck: status of cards.            */
/*    0 = Undealt or played.           */
/*    1 thru 4 = Player who holds card.*/

extern int Deck[52];

/*   Hand: cards in each player's hand. */
/*    0 = Played.                       */
/*    1 thru 52 = Card number.          */

extern int Hand[4][13];

/*    Bid: number of tricks bid by each player. */

extern int Bid[4];

/* Mode: aggressiveness of each player.      */
/*    The number in this array is added to   */
/*    the strength of the hand to determine  */
/*    the number of tricks to bid. Higher    */
/*    number equals more tricks.             */

extern int Mode[4];
  
/* HighCardLeft: the highest unplayed card   */
/*    in each suit.                          */

extern int HighCardLeft[4];

/* Card: the card played in a trick by each  */
/*    player.                                */

extern int Card[4];
  
/* Value: the point value of each card held     */
/*    in a hand. Used by computer to determine  */
/*    which card to play.                       */

extern int Value[13];

/* SuitNumber: the number of cards in each   */
/*    suit held by a player.                 */

extern int SuitNumber[4];

/* CardX & CardY: The X and Y positions for  */
/*    the played card for each player.       */
/* MsgX & MsgY: The X and Y positions for    */
/*    single character messages for each     */
/*    player.                                */

extern int CardX[4];
extern int CardY[4];
  
extern int MsgX[4];
extern int MsgY[4];
  
/* OutOfSuit: Whether or not a player is out */
/*    of a suit.                             */

extern BOOL OutOfSuit[4][4];

/* TricksTaken: How many tricks were won by    */
/*    each player. Used for Nil Bids and Bags. */

extern int TricksTaken[4];

/* TrickLeader: Who led each trick of the hand */

extern int TrickLeader[14];

/* CardPlayed: Which card each player played during the hand */

extern int CardPlayed[4][13];

/******************** Other Global Variables ******************/
extern char *String;          /* Temporary String Storage */

extern int PlayerScore;       /* Player's team score */
extern int CompScore;         /* Computer's team score */
extern int PlayerTricks;      /* Number of tricks taken by Player */
extern int CompTricks;        /* Number of tricks taken by Computer */
extern int HandLead;          /* The Dealer for a hand */
extern int Button;            /* Mouse Button pressed */
extern int TrickLead;         /* Who has the lead for a trick */
extern int PlayerBid;         /* Number of tricks bid by Player */
extern int CompBid;           /* Number of tricks bid by Computer */
extern int ShortSuit;         /* A player's short suit */
extern int LongSuit;          /* A player's long suit */
extern int HighCard;          /* The highest card so far in a trick */
extern int Winner;            /* The player who wins a trick so far */
extern int PlayerBags;        /* Number of Bags for Player */
extern int CompBags;          /* Number of Bags for Computer */
extern BOOL SpadePlayed;      /* Was a spade played in this hand yet? */
extern BOOL AllDone;          /* Are we done with the game ? */
extern BOOL ScreenOpen;       /* Was the Spades screen opened yet ? */
extern BOOL BagsRule;         /* Are we playing with Bags ? */
extern BOOL NilRule;          /* Are NIL bids allowed ? */
extern BOOL SaveHand;         /* Save the hand when its over ? */
extern char *CardData;        /* Memory for Card images */

extern SHORT Mx,My;           /* Mouse Coordinates */
