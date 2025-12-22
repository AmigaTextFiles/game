/*
   FILE: Play.c
   PURPOSE: Handle the play of the hand (taking tricks)
   AUTHOR: Gregory M. Stelmack
*/

#ifndef GLOBALS_H
#include "Globals.h"
#endif

/**********************************************************
* Function: PlayHand                                      *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Play out a hand until all 13 tricks are taken. *
**********************************************************/
void PlayHand()
{
   int i,j;
   int TrickNumber;
  
   /* Initialize */
  
   PlayerTricks=CompTricks=0;
   SpadePlayed=FALSE;
   TrickNumber=0;
   PrintTricks();
   for (i=0 ; i<4 ; i++) TricksTaken[i] = 0;
     
   /* Loop through all 13 tricks */
  
   for (i=0 ; i<13 ; i++)
   {
      TrickLeader[i] = TrickLead;           /* Save Trick Leader */
      TrickLead=TakeTrick();                /* Play a trick */
      TricksTaken[TrickLead]++;
      if ((TrickLead==0)||(TrickLead==2))   /* Who won? */
            PlayerTricks++;
      else
            CompTricks++;
      PrintTricks();         /* Display new trick total */
      
      /* Store Cards */
      
      for (j=0 ; j<4 ; j++)
         CardPlayed[j][TrickNumber] = Card[j];
      TrickNumber++;
    
      /* Indicate who won with an '*' */
    
      SetAPen(RP,YELP);
      SetBPen(RP,BLUP);
      Move(RP,MsgX[TrickLead],MsgY[TrickLead]);
      Text(RP,"*",1);
    
      /* Pause for click */

      SetAPen(RP,YELP);
      Move(RP,200,150);
      Text(RP,"Click mouse",11);
      ReadMouse();
      Move(RP,200,150);
      Text(RP,"           ",11);
    
      /* Erase winner indicator */
    
      Move(RP,MsgX[TrickLead],MsgY[TrickLead]);
      Text(RP," ",1);
   }

   /* Store last trick winner for Save routine */
   
   TrickLeader[13] = TrickLead;
     
   /* Calculate new score */
  
   if (PlayerTricks<PlayerBid)
         PlayerScore-=(10*PlayerBid);
   if (CompTricks<CompBid)
         CompScore-=(10*CompBid);
   if (PlayerTricks>=PlayerBid)
   {
      PlayerScore+=((10*PlayerBid)+(PlayerTricks-PlayerBid));
      PlayerBags+=(PlayerTricks-PlayerBid);
   }
   if (CompTricks>=CompBid)
   {
      CompScore+=((10*CompBid)+(CompTricks-CompBid));
      CompBags+=(CompBags-CompBid);
   }
   
   /* Handle Bags */
   
   if (BagsRule==TRUE)
   {
      while(PlayerBags>9)
      {
         PlayerScore-=100;
         PlayerBags-=10;
      }
      while(CompBags>9)
      {
         CompScore-=100;
         CompBags-=10;
      }
   }
   
   /* Handle Nil Bids */
   
   if (NilRule)
   {
      for (i=0 ; i<4 ; i+=2)
      {
         if (Bid[i]==0)
         {
            if (TricksTaken[i]==0)
               PlayerScore+=100;
            else
               PlayerScore-=100;
         }
      }
      for (i=1 ; i<4 ; i+=2)
      {
         if (Bid[i]==0)
         {
            if (TricksTaken[i]==0)
               CompScore+=100;
            else
               CompScore-=100;
         }
      }
   }
   
   /* See if hand is to be saved */
   if (SaveHand == TRUE)
      WriteHand();

   /* Pause for click */

   SetAPen(RP,YELP);
   Move(RP,200,150);
   Text(RP,"Click mouse",11);
   ReadMouse();
   Move(RP,200,150);
   Text(RP,"           ",11);
}

/**********************************************************
* Function: TakeTrick                                     *
* Parameters: none                                        *
* Return Values: winner of trick                          *
* Purpose: Each player plays a card, then determine trick *
*          winner.                                        *
**********************************************************/
int TakeTrick()
{
   int i,j,leadsuit,suit,value;
  
   /* Clear previously played cards */
  
   SetAPen(RP,BLUP);
   SetOPen(RP,BLUP);
   for (i=0 ; i<4 ; i++)
      RectFill(RP,CardX[i],CardY[i],(CardX[i]+41),(CardY[i]+41));
  
   /* Get played cards */
  
   i=TrickLead;
   do
   {
      if (!i)
            Card[i]=GetPlayerCard();
      else
            Card[i]=GetCompCard(i);
      
      if (i==TrickLead)      /* First card played wins so far */
      {
         HighCard=Card[i];
         leadsuit=Card[i]/13;
         Winner=i;
      }
      else
      {
         suit=Card[i]/13;
      
         /* See if this card is the new winner */
      
         if (((suit==leadsuit)||(suit==SPADES))&&(Card[i]>HighCard))
         {
            HighCard=Card[i];
            Winner=i;
         }
      
         /* Was player out of the lead suit ? */
      
         if (suit!=leadsuit) OutOfSuit[i][leadsuit]=TRUE;
      }
      i=(++i)%4;
   } while (i!=TrickLead);
  
   ShowHand();
  
   /* Set highest card played in each suit */
  
   for (i=0 ; i<4 ; i++)
   {
      for (j=0 ; j<4 ; j++)    /* Need two loops to make sure we get all */
      {
         value=Card[j]%13;
         suit=Card[j]/13;
         if (value==HighCardLeft[suit]) HighCardLeft[suit]=value-1;
      }
   }
  
   /* Send back trick winner */
  
   return(Winner);
}

/**********************************************************
* Function: CountCards                                    *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Count cards in each suit for a player.         *
*   Determine short and long suits.                       *
**********************************************************/
void CountCards(player)
int player;
{
   int i,card,suit,maximum,minimum;
  
   /* Initialization */
  
   SuitNumber[DIAMONDS]=0;
   SuitNumber[CLUBS]   =0;
   SuitNumber[HEARTS]  =0;
   SuitNumber[SPADES]  =0;
  
   /* Loop through all cards in the player's hand */
  
   for (i=0 ; i<13 ; i++)
   {
      if (Hand[player][i])    /* Make sure card hasn't been played */
      {
         card=Hand[player][i]-1;
         suit=card/13;
         Value[i]=13-card;    /* Give lower cards a slight priority */
         SuitNumber[suit]++;  /* Count Number of Suit held */
      }
      else
         Value[i]=-50000;     /* Don't throw previously played cards */
   }
  
   /* Find short and long suits */
  
   minimum=14;
   maximum=0;
   ShortSuit=LongSuit=3;
   for (i=DIAMONDS ; i<SPADES ; i++)
   {
      if ((SuitNumber[i]<minimum)&&(SuitNumber[i]>0))
      {
         minimum=SuitNumber[i];
         ShortSuit=i;
      }
      if (SuitNumber[i]>maximum)
      {
         maximum=SuitNumber[i];
         LongSuit=i;
      }
   }
}
  
/**********************************************************
* Function: SuggestCard                                   *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Suggest a card for player to play.             *
**********************************************************/
void SuggestCard()
{
   int i,pick,maximum;
  
   CountCards(0);

   /* Go to appropriate point calculating routine */
  
   if (!TrickLead)
         CalcLead(0);
   else
         CalcFollow(0);
  
   /* Find best card (the one with the most points) */
  
   pick=0;
   maximum=Value[0];
   for (i=1 ; i<13 ; i++)
   {
      if (Value[i]>maximum)
      {
         maximum=Value[i];
         pick=i;
      }
   }
  
   /* Display an '*' over suggested card */
  
   SetAPen(RP,YELP);
   SetBPen(RP,BLUP);
   Move(RP,((pick*10))+22,142);
   Text(RP,"*",1);
}

/**********************************************************
* Function: GetCompCard                                   *
* Parameters: player -- player to play                    *
* Return Values: card played                              *
* Purpose: Determine which card a computer-controlled     *
*   player will play.                                     *
**********************************************************/
int GetCompCard(player)
int player;
{
   int i,pick,card,maximum;
  
   CountCards(player);

   /* Go to appropriate point calculating routine */
  
   if (player==TrickLead)
         CalcLead(player);
   else
         CalcFollow(player);
  
   /* Find best card (the one with the most points) */
  
   pick=0;
   maximum=Value[0];
   for (i=1 ; i<13 ; i++)
   {
      if (Value[i]>maximum)
      {
         maximum=Value[i];
         pick=i;
      }
   }
  
   card=Hand[player][pick]-1;
   if ((card/13)==3)       /* Mark that spades have been broken */
         SpadePlayed = TRUE;
   Hand[player][pick]=0;   /* Card has now been played */
   DrawCard(CardX[player],CardY[player],card);  /* Draw the played card */
   return(card);           /* Send the played card back */
}

/**********************************************************
* Function: CalcLead                                      *
* Parameters: player -- whose hand to calculate           *
* Return Values: none                                     *
* Purpose: To calculate the value of each card in a hand  *
*          to determine which card should be played if    *
*          the hand is leading.                           *
**********************************************************/
void CalcLead(player)
int player;
{
   int i,card,suit,value;
   BOOL opponentsout=FALSE, partnerout=FALSE;
   BOOL WantToTake=FALSE;
   
   /* See if we want to take this trick */
   
   WantToTake = FigureTake(player);
   
   /* Loop through all cards in hand */
  
   for (i=0 ; i<13 ; i++)
   {
      if (Hand[player][i])   /* Make sure card hasn't been played */
      {
         /* Find suit and face value */
      
         card=Hand[player][i]-1;
         suit=card/13;
         value=card%13;
      
         if ((OutOfSuit[(player+1)%4][suit])||
             (OutOfSuit[(player+3)%4][suit]))
               opponentsout=TRUE;
        
         if (OutOfSuit[(player+2)%4][suit])
               partnerout=TRUE;
      
         if (value==HighCardLeft[suit]) /* Card is highest left in a suit */
         {
            if (!WantToTake)  /* Don't throw high card if we don't want to
                                 take. */
                  Value[i]-=100;
            else
            {
               if (suit==SPADES)    /* Spades don't matter if someone is */
                  Value[i]+=50;     /* out. */
               else
               {  
                  /* If opponents are out (or likely to be), don't waste */
                  if ((opponentsout)||(value<11))     /* high cards.     */
                       Value[i]-=50;
                  else
                        Value[i]+=500;
               }  
            }
         }
      
         /* If player holds spades, get rid of short suit */
         if ((SuitNumber[SPADES])&&(suit==ShortSuit)) Value[i]+=250;
      
         /* If player doesn't hold spades, get rid of long suit */
         if ((!SuitNumber[SPADES])&&(suit==LongSuit)) Value[i]+=250;
      
         /* If spades aren't broken, they can't be lead */
         if ((suit==SPADES)&&(!SpadePlayed)) Value[i]-=5000;
      
         /* Lead suits your partner is out of */
         if ((suit!=SPADES)&&(partnerout)&&(!opponentsout)) Value[i]+=100;
      }
   }
}

/**********************************************************
* Function: CalcFollow                                    *
* Parameters: player -- whose hand to calculate           *
* Return Values: none                                     *
* Purpose: To calculate the value of each card in a hand  *
*          to determine which card should be played if    *
*          the hand is not leading.                       *
**********************************************************/
void CalcFollow(player)
int player;
{
   int i,card,suit,value,leadsuit;
   BOOL alreadywon,WantToTake,PartnerTake;
  
   leadsuit=Card[TrickLead]/13;  /* Calculate the suit that was lead */
  
   /* See if partner has already won the trick */
  
   alreadywon=FALSE;
   
   /* See if win is guaranteed (player is last to play) */
   if ((Winner==((player+2)%4))&&(TrickLead==((player+1)%4)))
         alreadywon=TRUE;  
    
   /* See if win is probable (player is next to last to play) */
   if ((Winner==TrickLead)&&(TrickLead==((player+2)%4)))
   {
      value=Card[TrickLead]%13;
      if ((value==HighCardLeft[leadsuit])&&(value>9)&&
         !OutOfSuit[(player+3)%4][leadsuit])
            alreadywon=TRUE;
   }
   
   /* See if we want to take the trick */
   
   WantToTake = FigureTake(player);
   
   /* See if partner should take trick */
   
   PartnerTake = FigureTake((player+2)%4);
   
   /* If our partner has taken the trick so far, but shouldn't, set the
      alreadywon flag to FALSE so that we can try to take the trick */
      
   if ((alreadywon==TRUE)&&(PartnerTake==FALSE))
         alreadywon=FALSE;

   /* Loop through all cards in hand */
  
   for (i=0 ; i<13 ; i++)
   {
      if (Hand[player][i])  /* Make sure card hasn't been played */
      {
         /* Find suit and face value of card */
      
         card=Hand[player][i]-1;
         suit=card/13;
         value=card%13;
      
         if (suit==leadsuit)   /* Card is of lead suit */
         { 
            Value[i]+=5000;
        
            /* If it is the highest one left in that suit, and we want to
               take the trick, throw it. */
            if ((value==HighCardLeft[suit])&&
                (TrickLead!=((player+1)%4))&&
                (card>HighCard)&&!OutOfSuit[(player+1)%4][suit]&&
                (WantToTake==TRUE)&&
                (alreadywon==FALSE))
            {
                  Value[i]+=70;
            }
          
            /* See if card will beat those previously played */
            if (card>HighCard)
            {
               /* If we don't want to take, or our partner has it, DON'T */
               if ((WantToTake==FALSE)||(alreadywon==TRUE))
                     Value[i]-=500;
               else
                     Value[i]+=100;
            }
        
            /* If we don't want to win, throw low cards */
            if ((card<HighCard)&&((WantToTake==FALSE)||(alreadywon==TRUE)))
                  Value[i]+=75;
         }
      
         /* If player is going to throw a spade, make sure it has
            a chance of winning (and that we want to take it */
         if ((suit==SPADES)&&(card>HighCard))
         {
            if ((WantToTake==TRUE)&&(alreadywon==FALSE))
                  Value[i]+=100; /* If team hasn't won, throw the spade */
            else
                  Value[i]-=1000; /* If team has won, hold high spades */
         }
         if ((suit==SPADES)&&(card<HighCard))
         {
            if (WantToTake==FALSE)
                  Value[i]+=1000;   /* If we don't want to take trick,
                                      get rid of Spades */
            else
                  Value[i]-=500;    /* Don't waste a Spade */
         }
      
         /* If player is out of the lead suit, don't throw important cards
            in other suits (unless we don't want to take) */
         if ((suit!=leadsuit)&&(value==HighCardLeft[suit]))
         {
            if (WantToTake==FALSE)
               Value[i]+=500;
            else
               Value[i]-=100;
         }
      
         /* If player is out of lead suit, let's see about trumping */
         if ((!SuitNumber[leadsuit])&&(suit==SPADES))
         {
            if ((WantToTake==TRUE)&&(alreadywon==FALSE))
                  Value[i]+=100;  /* If team hasn't won, trump */
            else
                  Value[i]-=1000; /* If team has won, no need to trump */
         }
      
         /* If player is out of lead suit and out of spades, throw the long
            suit left (keep as many suits as possible in hand) */
         if ((!SuitNumber[leadsuit])&&
             (!SuitNumber[SPADES])&&
             (suit==LongSuit))
         {
            Value[i]+=100;
         }
      
         /* Give short suit a priority */
         if (suit==ShortSuit) Value[i]+=45;
      }
   }
}

/*************************************************
* Function: FigureTake                           *
* Parameters: player -- player to deal with.     *
* Return Values: BOOL -- TRUE if player should   *
*     try to take trick.                         *
* Purpose: See if a player should take or give a *
*     trick.                                     *
*************************************************/
BOOL FigureTake(player)
int player;
{
   BOOL ShouldTake;
   
   ShouldTake = TRUE;
   
   if ((NilRule==TRUE)&&(Bid[player]==0))
         ShouldTake = FALSE;
   else
   {
      if ((TricksTaken[player]+TricksTaken[(player+2)%4]) <
          (Bid[player]+Bid[(player+2)%4]))
            ShouldTake = TRUE;
      else if (BagsRule==TRUE)
            ShouldTake = FALSE;
   }
   
   return(ShouldTake);
}
