/*
   FILE: Input.c
   PURPOSE: Routines for getting user input.
   AUTHOR: Gregory M. Stelmack
*/

#ifndef GLOBALS_H
#include "Globals.h"
#endif

extern struct Menu *SpadesMenu;

struct EasyStruct    AboutES =
{
   sizeof(struct EasyStruct),
   0,
   "About Spades 2.12",
   "Spades 2.12 by:\nGregory M. Stelmack\n8723 Del Rey Ct. #11-A\nTampa, FL 33617",
   "OK"
};

/**********************************************************
* Function: ReadMouse                                     *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Wait for mouse input, and update the mouse     *
*          variables accordingly.                         *
**********************************************************/
void ReadMouse()
{
   ULONG class,menunum,itemnum,subnum;
   USHORT code,selection,flags;
   BOOL gotmouse;
   BOOL QuitFlag,NewFlag;
   struct IntuiMessage  *Message;
   
   /* Loop until we have a mouse message */

   gotmouse = FALSE;
   QuitFlag = FALSE;
   NewFlag = FALSE;
     
   while(!gotmouse)
   {
      /* Wait for Intuition Message */
      
      Wait(1L<<Wdw->UserPort->mp_SigBit);    
		while(Message=(struct IntuiMessage *) GetMsg(Wdw->UserPort))
		{
         /* Interpret Message */
    
         class = Message->Class;
         code = Message->Code;
         ReplyMsg((struct Message *)Message);

         switch(class)
         {
            case MENUPICK:
               selection = code;
               while (selection != MENUNULL)
               {
                  menunum = MENUNUM(selection);
                  itemnum = ITEMNUM(selection);
                  subnum  = SUBNUM(selection);
                  flags = ((struct MenuItem *)ItemAddress(SpadesMenu,
                           (LONG)selection))->Flags;
                  switch(menunum)
                  {
                     case 0:     /* Project menu */
                        switch(itemnum)
                        {
                           case 0:     /* New Game */
                              NewFlag = TRUE;
                              break;
                           case 1:     /* Save Hand */
                              if (flags&CHECKED)
                                    SaveHand = TRUE;
                              else
                                    SaveHand = FALSE;
                              break;
                           case 2:     /* Print Hand */
                              break;
                           case 3:     /* About */
                              (void)EasyRequest(Wdw,&AboutES,NULL,NULL);
                              break;
                           case 4:     /* Quit */
                              QuitFlag = TRUE;
                              break;
                           default:
                              break;
                        }
                        break;
                     case 1:     /* Game menu */
                        switch(itemnum)
                        {
                           case 0:     /* Bags */
                              if (flags&CHECKED)
                                    BagsRule = TRUE;
                              else
                                    BagsRule = FALSE;
                              break;
                           case 1:     /* Nil */
                              if (flags&CHECKED)
                                    NilRule = TRUE;
                              else
                                    NilRule = FALSE;
                              break;
                           case 2:     /* Suggest */
                              Button = MRIGHT;
                              gotmouse = TRUE;
                              break;
                           default:
                              break;
                        }
                        break;
                     default:
                        break;
                  }
                  selection = ((struct MenuItem *)
                              ItemAddress(SpadesMenu,(LONG)selection))
                              ->NextSelect;
               }
               break;
               
				case MOUSEBUTTONS:
               switch(code)
               {
                  case SELECTUP:
                     Button=MLEFT;
                     gotmouse=TRUE;
                     Mx=((SHORT) Message->MouseX);
                     My=((SHORT) Message->MouseY);
                     break;
                  default:
                     break;
               }
	
            default:
               break;
				
         }  /* end switch */
      }  /* end while message to process */
		
      if (QuitFlag == TRUE)
      {
         WrapUp();
      }
      else if (NewFlag == TRUE)
      {
         Spades();
      }
   }  /* end while not gotmouse */
} 

/**********************************************************
* Function: FinishRoutine                                 *
* Parameters: none                                        *
* Return Values: none                                     *
* Purpose: Display final score, ask to play again.        *
**********************************************************/
void FinishRoutine()
{
   BOOL haveinput;

   SetRast(RP,BLUP);
   SetAPen(RP,WHTP);
   SetBPen(RP,BLUP);

   Move(RP,112,56);
   Text(RP,"FINAL SCORE:",12);
   Move(RP,80,72);
   Text(RP,"YOU:",4);
   Move(RP,184,72);
   Text(RP,"ME:",3);
   SetAPen(RP,YELP);
   itoa(PlayerScore,String);
   Move(RP,116,72);
   Text(RP,String,strlen(String));
   itoa(CompScore,String);
   Move(RP,212,72);
   Text(RP,String,strlen(String));
   
   Move(RP,112,96);
   Text(RP,"PLAY AGAIN ?",12);
   SetAPen(RP,BLKP);
   SetBPen(RP,WHTP);
   Move(RP,112,112);
   Text(RP,"YES",3);
   Move(RP,188,112);
   Text(RP,"NO",2);
   
   haveinput=FALSE;
   while (!haveinput)
   {
      ReadMouse();
      
      /* Check for YES clicked */
      
      if ((Mx>111)&&(Mx<136)&&(My>105)&&(My<114))
         haveinput=TRUE;
         
      /* Check for NO clicked */
      
      if ((Mx>187)&&(Mx<204)&&(My>105)&&(My<114))
         WrapUp();
   }
}

/**********************************************************
* Function: GetPlayerCard                                 *
* Parameters: none                                        *
* Return Values: card picked to play                      *
* Purpose: Allow player to pick card to play.             *
**********************************************************/
int GetPlayerCard()
{
   int i,x,card;
  
   /* Let player know that it's his/her turn */
  
   SetBPen(RP,BLUP);
   SetAPen(RP,YELP);
   Move(RP,200,150);
   Text(RP,"PLAY A CARD",11);
  
   /* Loop until we get a good card */
  
   FOREVER
   {
      ReadMouse();                        /* Wait for mouse click */ 
      if (Button==MRIGHT) SuggestCard();  /* Player wants a suggestion */
      if (Button==MLEFT)                  /* Did player pick a card ? */
      {
         for (i=12 ; i>=0 ; i--)          /* Check from right to left */
         {
            x=(i*10)+21;                  /* Set left corner for card */
        
            /* See if clicked inside this card and if card is
               still unplayed */
        
            if ((My<187)&&(My>144)&&(Mx<(x+42))&&(Mx>=x)&&(Hand[0][i]))
            {
               if (ValidCard(i))  /* Was this a playable card ? */
               {
                  card=Hand[0][i]-1;
                  Hand[0][i]=0;   /* Mark card as played */
                  
                  /* Check to see if Spades were broken */
                  
                  if ((card/13)==SPADES) SpadePlayed=TRUE;
            
                  /* Erase suggestion '*' */
            
                  SetAPen(RP,BLUP);
                  SetOPen(RP,BLUP);
                  RectFill(RP,21,136,170,144);
            
                  DrawCard(CardX[0],CardY[0],card); /* Draw played card */
            
                  /* Erase prompt message */
            
                  SetBPen(RP,BLUP);
                  Move(RP,200,150);
                  Text(RP,"           ",11);
            
                  /* Send back played card */
            
                  return(card);
               }
               else     /* chosen card was not valid, need a new card */
                     i=-1;
            }
         }
      }
   }
}

/**********************************************************
* Function: ValidCard                                     *
* Parameters: card -- card in player's hand to check      *
* Return Values: was card valid or not?                   *
* Purpose: To determine if the card chosen by the player  *
*   was valid or not.                                     *
**********************************************************/
BOOL ValidCard(card)
int card;
{
   int i,suit,leadsuit;
  
   SuitNumber[DIAMONDS]=0;
   SuitNumber[CLUBS]   =0;
   SuitNumber[HEARTS]  =0;
   SuitNumber[SPADES]  =0;
  
   /* Count number of cards player has in each suit */
  
   for (i=0 ; i<13 ; i++)
   {
      if (Hand[0][i]) SuitNumber[(Hand[0][i]-1)/13]++;
   }
  
   suit=(Hand[0][card]-1)/13; /* Find suit of played card */
  
   if (!TrickLead)            /* Player is leading */
   {
      /* If he didn't lead a spade, it was a good play */
      if (suit!=SPADES) return(TRUE);
    
      /* If he only has spades, he has no choice */ 
      if ((!SuitNumber[0])&&(!SuitNumber[1])&&(!SuitNumber[2]))
            return(TRUE);
    
      /* If spades have been played, he can lead anything */
      if (SpadePlayed) return(TRUE);
    
      /* Must have lead a spade when it was illegal to */
      return(FALSE);
   }
  
   /* Player doesn't lead */
  
   leadsuit=Card[TrickLead]/13;       /* Find suit that was lead */
  
   /* If he played the suit that was lead, he is OK */
   if (suit==leadsuit) return(TRUE);
  
   /* If he didn't have any, he's OK */
   if (!SuitNumber[leadsuit]) return(TRUE);
  
   /* Must have had some but didn't play them */
   return(FALSE);
}

/**********************************************************
* Function: GetPlayerBid                                  *
* Parameters: none                                        *
* Return Values: bid -- number of tricks bid              *
* Purpose: Get the human player's bid. Could use gadgets, *
*          but this is easier to program.                 *
**********************************************************/
int GetPlayerBid()
{
   int bid=1,length;
   BOOL havebid=FALSE;

   ShowHand();

   /* Draw input box */
  
   SetAPen(RP,YELP);
   SetBPen(RP,BLKP);
   Move(RP,258,142);
   Text(RP,"BID",3);
   Move(RP,250,150);
   Text(RP,"  +  ",5);
   Move(RP,250,158);
   Text(RP,"   OK",5);
   Move(RP,250,166);
   Text(RP,"  -  ",5);
  
   /* Loop until OK is clicked */
  
   while(!havebid)
   { 
      /* Draw Current Bid */
    
      SetAPen(RP,GRNP);
      SetBPen(RP,BLKP);
      Move(RP,250,158);
      Text(RP,"  ",2);
      itoa(bid,String);
      length=strlen(String);
      Move(RP,(258-(4*length)),158);
      Text(RP,String,length);
    
      /* Wait for Mouse input */
    
      ReadMouse();
      if (Button==MLEFT)   /* Left Button Pressed */
      {
         /* plus sign clicked */
         if ((Mx>265)&&(Mx<274)&&(My>143)&&(My<152)) bid++;
			
         /* OK clicked */
         if ((Mx>273)&&(Mx<290)&&(My>151)&&(My<160)) havebid=TRUE;
         
         /* minus sign clicked */
         if ((Mx>265)&&(Mx<274)&&(My>159)&&(My<168)) bid--;
      }
      if (Button==MRIGHT)  /* Right Button Pressed */
      {
         bid=CalcBid(0);   /* Suggest a Bid */
      }
    
      /* Make sure bid is valid */
    
      if (NilRule)
      {
         if (bid<0) bid=0;
         if (bid>13) bid=13;
      }
      else
      {
         if (bid<1) bid=1;
         if (bid>12) bid=12;
      }
   }
  
   /* Erase Input Box */
  
   SetAPen(RP,BLUP);
   SetOPen(RP,BLUP);
   RectFill(RP,250,135,291,168);
  
   /* Display the bid */
  
   SetAPen(RP,YELP);
   SetBPen(RP,BLUP);
   itoa(bid,String);
   Move(RP,MsgX[0],MsgY[0]);
   Text(RP,String,strlen(String));
  
   /* Send the bid back */
  
   return(bid);
}
