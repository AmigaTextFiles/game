/*
   FILE: Files.c
   PURPOSE: Handles all File I/O operations (saving and printing)
   AUTHOR: Gregory M. Stelmack
*/

#ifndef GLOBALS_H
#include "Globals.h"
#endif

#define EOF (-1)     /* since I don't use stdio */

/**********************************************
* Function: WriteHand                         *
* Parameters: None                            *
* Return Values: None                         *
* Purpose: Save the hand just played to disk. *
**********************************************/
void WriteHand()
{
   BPTR fh;
   char buffer[55];
   int  i,j,k;
   LONG error;
   char *SuitString = "DCHS";
   char *CardString = "23456789TJQKA";
   int  EastPos, WestPos;
   int  player;
   
   /* Open save file, position at end */
   
   fh = Open("Spades.save",MODE_READWRITE);
   if (!fh)
      PError("Could not open save file Spades.save");
   (void)Seek(fh,0L,OFFSET_END);
   
   /* Mark beginning */
   
   error = FPuts(fh,"\n*****************************************\n\n");
   if (error!=0)
      PError("Error writing save file");
   
   /* Write out the rules */

   if (NilRule==TRUE)
   {
      error = FPuts(fh,"NIL Rule in effect\n");
      if (error!=0)
         PError("Error writing save file");
   }
   if (BagsRule==TRUE)
   {
      error = FPuts(fh,"Bags Rule in effect\n");
      if (error!=0)
         PError("Error writing save file");
   } 
   
   if ((NilRule==TRUE)||(BagsRule==TRUE))
   {
      error = FPutC(fh,'\n');
      if (error==EOF)
         PError("Error writing save file");
   }
   
   /* Write the dealer */
   
   error = FPuts(fh,"Dealer = ");
   if (error!=0)
      PError("Error writing save file");
   switch(HandLead)
   {
      case 0:
         error = FPuts(fh,"South\n");
         break;
      case 1:
         error = FPuts(fh,"West\n");
         break;
      case 2:
         error = FPuts(fh,"North\n");
         break;
      case 3:
         error = FPuts(fh,"East\n");
         break;
   }
   if (error!=0)
      PError("Error writing save file");
   
   /* Write North's hand */
   
   for (i=3 ; i>=0 ; i--)   /* loop through suits */
   {
      error = FPuts(fh,"               ");
      if (error!=0)
         PError("Error writing save file");
      error = FPutC(fh,*(SuitString+i));
      if (error==EOF)
         PError("Error writing save file");
      error = FPutC(fh,':');
      if (error==EOF)
         PError("Error writing save file");
      for (j=12 ; j>=0 ; j--)
      {
         if (Deck[i*13+j]==3)
         {
            error = FPutC(fh,*(CardString+j));
            if (error==EOF)
               PError("Error writing save file");
         }
      }
      error = FPutC(fh,'\n');
      if (error==EOF)
         PError("Error writing save file");
   }
   
   /* Write West and East's hand */
   
   buffer[53] = '\n';
   buffer[54] = '\0';
   
   for (i=3 ; i>=0 ; i--)   /* loop through suits */
   {
      for (k=0 ; k<53 ; k++) buffer[k] = ' ';
      buffer[0] = buffer[35] = *(SuitString+i);
      buffer[1] = buffer[36] = ':';
      WestPos = 2; EastPos = 37;
      
      for (j=12 ; j>=0 ; j--)
      {
         if (Deck[i*13+j]==2)
         {
            buffer[WestPos] = *(CardString+j);
            WestPos++;
         }
         else if (Deck[i*13+j]==4)
         {
            buffer[EastPos] = *(CardString+j);
            EastPos++;
         }
      }
      
      error = FPuts(fh,&buffer[0]);
      if (error!=0)
         PError("Error writing save file");
   }
   
   /* Write South's hand */
   
   for (i=3 ; i>=0 ; i--)   /* loop through suits */
   {
      error = FPuts(fh,"               ");
      if (error!=0)
         PError("Error writing save file");
      error = FPutC(fh,*(SuitString+i));
      if (error==EOF)
         PError("Error writing save file");
      error = FPutC(fh,':');
      if (error==EOF)
         PError("Error writing save file");
      for (j=12 ; j>=0 ; j--)
      {
         if (Deck[i*13+j]==1)
         {
            error = FPutC(fh,*(CardString+j));
            if (error==EOF)
               PError("Error writing save file");
         }
      }
      error = FPutC(fh,'\n');
      if (error==EOF)
         PError("Error writing save file");
   }
   
   /* Write Bids */
   
   error = FPuts(fh,"\nBIDS:   West: ");
   if (error!=0)
      PError("Error writing save file");
   itoa(Bid[1],String);
   error = FPuts(fh,String);
   if (error!=0)
      PError("Error writing save file");
   error = FPuts(fh,"   North: ");
   if (error!=0)
      PError("Error writing save file");
   itoa(Bid[2],String);
   error = FPuts(fh,String);
   if (error!=0)
      PError("Error writing save file");
   error = FPuts(fh,"   East: ");
   if (error!=0)
      PError("Error writing save file");
   itoa(Bid[3],String);
   error = FPuts(fh,String);
   if (error!=0)
      PError("Error writing save file");
   error = FPuts(fh,"   South: ");
   if (error!=0)
      PError("Error writing save file");
   itoa(Bid[0],String);
   error = FPuts(fh,String);
   if (error!=0)
      PError("Error writing save file");
   FPutC(fh,'\n');

   /* Print the play of the hand */
   
   for (i=0 ; i<4 ; i++)
   {
      error = FPutC(fh,'\n');
      if (error==EOF)
         PError("Error writing save file");
      player = (i+1)%4;    /* Adjust to start with West */
      switch(player)
      {
         case 0:
            error = FPuts(fh,"S: ");
            if (error!=0)
               PError("Error writing save file");
            break;
         case 1:
            error = FPuts(fh,"W: ");
            if (error!=0)
               PError("Error writing save file");
            break;
         case 2:
            error = FPuts(fh,"N: ");
            if (error!=0)
               PError("Error writing save file");
            break;
         case 3:
            error = FPuts(fh,"E: ");
            if (error!=0)
               PError("Error writing save file");
            break;
      }
      
      for (j=0 ; j<13 ; j++)  /* Loop through the tricks */
      {
         if (TrickLeader[j]==player)
         {
            error = FPutC(fh,'*');
            if (error==EOF)
               PError("Error writing save file");
         }
         else
         {
            error = FPutC(fh,' ');
            if (error==EOF)
               PError("Error writing save file");
         }
         error = FPutC(fh,*(SuitString+(CardPlayed[player][j]/13)));
         if (error==EOF)
            PError("Error writing save file");
         error = FPutC(fh,*(CardString+(CardPlayed[player][j]%13)));
         if (error==EOF)
            PError("Error writing save file");
      }  /* end loop through tricks */
      
      if (TrickLeader[13]==player)  /* See if player won last trick */
      {
         error = FPutC(fh,'*');
         if (error==EOF)
            PError("Error writing save file");
      }
      
   }  /* end loop through players */
   
   error = FPutC(fh,'\n');
   if (error==EOF)
      PError("Error writing save file");
   
   /* Close save file */
   
   (void)Close(fh);
}
