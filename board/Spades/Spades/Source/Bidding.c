/*
   FILE: Bidding.c
   PURPOSE: Contains the routines for bidding a hand of Spades
   AUTHOR: Gregory M. Stelmack
*/

#ifndef GLOBALS_H
#include "Globals.h"
#endif

/**********************************************************
* Function: GetBids                                       *
* Parameters: none                                        *
* Return values: none                                     *
* Purpose: Get each player's bid.                         *
**********************************************************/
void GetBids()
{
   int i;
  
   for (i=0 ; i<4 ; i++) Bid[i]=0;  /* Reset bids for each player */
  
   /* Loop through each player */
  
   i=HandLead;
   do
   {
      if (i)
         Bid[i]=CalcBid(i);      /* Computer Player */
      else 
         Bid[i]=GetPlayerBid();  /* Human Player */
      i=(++i)%4;
   }  while (i!=HandLead);
  
   /* Calculate team contracts */
  
   PlayerBid=Bid[0]+Bid[2];
   CompBid=Bid[1]+Bid[3];
  
   /* Pause for click */

   SetAPen(RP,YELP);
   Move(RP,200,150);
   Text(RP,"Click mouse",11);
   ReadMouse();
   Move(RP,200,150);
   Text(RP,"           ",11);
       
   /* Erase Bids */
  
   SetBPen(RP,BLUP);
   for (i=0 ; i<4 ; i++)
   {
      Move(RP,MsgX[i],MsgY[i]);
      Text(RP," ",1);
   }
}

/**********************************************************
* Function: CalcBid                                       *
* Parameters: player -- number of player to calculate for *
* Return Values: bid -- number of tricks                  *
* Purpose: To calculate the number of tricks bid by a     *
*          player.                                        *
**********************************************************/
int CalcBid(player)
int player;
{
   int i,j,numsuit,points,suit,bid;
   int k,numspades;
        
   points=0;

   /* Calculate spades */
  
   numspades=0;
    
   /* Count Spades */
    
   for (j=39 ; j<52 ; j++)
      if (Deck[j]==player+1) numspades++;

   numsuit = numspades;
        
   /* Add points for Spades -- if enough to cover, count it */

   for (j=51 ; j>38 ; j--)
   {
      k = 12-(j%13);
      if ((Deck[j]==player+1)&&(numsuit>k))
      {
         points+=4;
         numspades=numsuit-k;    /* Used to make sure we don't count tricks
                                    twice for short-suitedness */
      }
   }

   /* Add up points for the non-spades suits */
  
   for (i=DIAMONDS ; i<SPADES ; i++)   /* Loop thru suits */
   {
      numsuit=0;
      suit=i*13;
    
      /* Count cards for suit */
    
      for (j=0 ; j<13 ; j++)
         if (Deck[suit+j]==player+1) numsuit++;
                
      /* Short-Suitedness */

      if (numspades>2)
      {
         if (numsuit==0)      points+=8;
         else if (numsuit==1) points+=4;
         else if (numsuit==2) points+=2;
      }
      else if (numspades==2)
      {
         if (numsuit==0)      points+=5;
         else if (numsuit==1) points+=2;
      }
      else if (numspades==1)
      {
         if (numsuit==0)      points+=3;
      }
                
      /* Add points for face cards */
    
      if (Deck[suit+12]==player+1)    /* Ace   */
      {
         if (numsuit<6)       points+=4;
         else if (numsuit<8)  points+=2;
         else                 points+=1;
      }
      if (Deck[suit+11]==player+1)    /* King  */
      {
         if ((numsuit<5)&&(numsuit>1))       points+=4;
         else if ((numsuit<6)&&(numsuit>1))  points+=2;
         else if ((numsuit<7)&&(numsuit>1))  points+=1;
      }
      if (Deck[suit+10]==player+1)    /* Queen */
      {
         if (numsuit==3) points+=2;
      }
   }

   points+=Mode[player];        /* Adjust for aggressiveness */
   if (NilRule==FALSE)          /* If not playing NIL rule, make sure bid
                                   is at least one */
   {
      if (points<4) points = 4;
   }
   bid=points/4;                /* Find Bid */
  
   /* Make sure total team bid not greater than 13 */
  
   i=(player+2)%4;              /* Find partner */
   if ((bid+Bid[i])>13) bid=13-Bid[i];
  
   /* Display Bid */
  
   itoa(bid,String);
   SetAPen(RP,YELP);
   SetBPen(RP,BLUP);
   Move(RP,MsgX[player],MsgY[player]);
   Text(RP,String,strlen(String));
  
   /* Send bid back */
  
   return(bid);
}
