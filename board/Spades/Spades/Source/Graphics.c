/*
   FILE: Graphics.c
   PURPOSE: Spades graphics functions
   AUTHOR: Gregory M. Stelmack
*/

#ifndef GLOBALS_H
#include "Globals.h"
#endif

extern struct Image CardImage;

/**********************************************************
* Function: SetUpScreen                                   *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: gets the screen ready for a new hand.          *
**********************************************************/
void SetUpScreen()
{
   /* Clear the Screen */

   SetRast(RP,BLUP);
   SetAPen(RP,YELP);
   SetBPen(RP,BLKP);

   /* Draw the Score Box */

   Move(RP,215,6);
   Text(RP," YOU   CMP ",11);
   Move(RP,215,14);
   Text(RP,"SCORE SCORE",11);
   Move(RP,215,22);
   Text(RP,"           ",11);
   Move(RP,215,30);
   Text(RP," BID   BID ",11);
   Move(RP,215,38);
   Text(RP,"           ",11);
   Move(RP,215,46);
   Text(RP,"TRICK TRICK",11);
   Move(RP,215,54);
   Text(RP,"           ",11); 
   SetAPen(RP,WHTP);
   Move(RP,215,7);
   Draw(RP,302,7);
   Move(RP,258,0);
   Draw(RP,258,55);
}

/**********************************************************
* Function: ShowHand                                      *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: To display the player's hand.                  *
**********************************************************/
void ShowHand()
{
   int i;
  
   /* Erase old hand */
  
   SetAPen(RP,BLUP);
   SetOPen(RP,BLUP);
   RectFill(RP,21,145,183,186);

   /* Draw each card, overlaying part of the previous one */

   for (i=0 ; i<13 ; i++)
   {
      if (Hand[0][i])   /* Only draw if card hasn't been played */
         DrawCard(((i*10)+21),145,((Hand[0][i])-1));
   }
}

/**********************************************************
* Function: PrintBids                                     *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Display the number of tricks bid by each team  *
*          in the score box.                              *
**********************************************************/
void PrintBids()
{
   int length=0;
  
   SetAPen(RP,GRNP);
   SetBPen(RP,BLKP);
   itoa(PlayerBid,String);
   length=strlen(String);
   Move(RP,(235-(4*length)),38);
   Text(RP,String,length);
   itoa(CompBid,String);
   length=strlen(String);
   Move(RP,(283-(4*length)),38);
   Text(RP,String,length);
}

/**********************************************************
* Function: PrintScore                                    *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Display each team's score in the score box.    *
**********************************************************/
void PrintScore()
{
   int length=0;
  
   SetAPen(RP,GRNP);
   SetBPen(RP,BLKP);
   itoa(PlayerScore,String);
   length=strlen(String);
   Move(RP,(235-(4*length)),22);
   Text(RP,String,length);
   itoa(CompScore,String);
   length=strlen(String);
   Move(RP,(283-(4*length)),22);
   Text(RP,String,length);
}

/**********************************************************
* Function: PrintTricks                                   *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Display the number of tricks taken by each     *
*          team in the score box.                         *
**********************************************************/
void PrintTricks()
{
   int length=0;
  
   SetAPen(RP,GRNP);
   SetBPen(RP,BLKP);
   itoa(PlayerTricks,String);
   length=strlen(String);
   Move(RP,(235-(4*length)),54);
   Text(RP,String,length);
   itoa(CompTricks,String);
   length=strlen(String);
   Move(RP,(283-(4*length)),54);
   Text(RP,String,length);
}

/**********************************************************
* Function: DrawCard                                      *
* Parameters: x -- x coordinate of top left corner        *
*             y -- y coordinate of top left corner        *
*           card -- number of card to draw                *
* Return Values: none                                     *
* Purpose: Draw a card.                                   *
**********************************************************/   
void DrawCard(x, y, card)
int x, y, card;
{
   CardImage.ImageData = (UWORD *)(CardData+card*126*6);
   DrawImage(RP, &CardImage, x, y);
}
