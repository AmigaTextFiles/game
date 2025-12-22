#include <stdio.h>
#include <exec/types.h>
#include <exec/libraries.h>
#include "interface.h"
#include <libraries/reqbase.h>
#include <proto/req.h>
#include "wsearch.h"
#include "funcs.h"

extern BOOL DispKey;

BOOL AllocDims()
{
   char *tkey, *tpuzzle, *tdisplay;
   
   tkey = key;
   tpuzzle = puzzle;
   tdisplay = display;

   key = (char *)calloc((px+1)*(py+1),sizeof(char));
   if(key<=0)
   {
	SimpleRequest("Unable to Allocate Memory for new Key");
	key = tkey;
	return(FALSE);
   }
   puzzle = (char *)calloc((px+1)*(py+1),sizeof(char));
   if(puzzle<=0)
   {
	SimpleRequest("Unable to Allocate Memory for new Puzzle");
	puzzle = tpuzzle;
	free(key);
	key = tkey;
	return(FALSE);
   }
   display = (char *)calloc((max(px,py)+1)*(max(px,py)+2),sizeof(char));
   if(display<=0)
   {
	SimpleRequest("Unable to Allocate Memory for new Display");
	display = tdisplay;
	free(key);
	key = tkey;
	free(puzzle);
	puzzle = tpuzzle;
	return(FALSE);
   }
   	
   if(tkey!=NULL)
	free(tkey);
   if(tpuzzle!=NULL)
	free(tpuzzle);
   if(tdisplay!=NULL)
	free(tdisplay);
   return(TRUE);
}

BOOL Dimensions()
{
   struct GetLongStruct GLS;
   
   GLS.minlimit = 2;
   GLS.maxlimit = MAXPUZ;
   GLS.versionnumber = REQVERSION;
   GLS.flags = 0;
   GLS.rfu2 = 0;
   GLS.window = DPWin;
   
   GLS.titlebar = "Enter Width of Puzzle";
   GLS.defaultval = px+1;
   if(GetLong(&GLS)==FALSE) return(FALSE);
   px = GLS.result-1;
   GLS.titlebar = "Enter Height of Puzzle";
   GLS.defaultval = py+1;
   if(GetLong(&GLS)==FALSE) return(FALSE);
   py = GLS.result-1;
/*   printf("Enter puzzle dimensions (width height)\n");
   scanf("%d %d",&px,&py);
   px = px-1; py=py-1;
 */
   if(AllocDims()==FALSE)
   	return(FALSE);
   else
   	return(TRUE);
}

void NewKey()
{
    int i,j,error;

    for(i=0;i<=px;i++)
        for(j=0;j<=py;j++)
            Key(i,j) = ' ';

     error = wsearch();
     if(error!=0 && error!=-1)
     {
        SimpleRequest("Cannot generate Key (a word won't fit)");
     }
}

void NewPuzzle()
{
     int i,j;

     for(i=0;i<=px;i++)
        for(j=0;j<=py;j++)
            if(Key(i,j) == ' ')
                Puzzle(i,j) = (char)(randint(25)+65);
            else
                Puzzle(i,j) = Key(i,j);
}

void NewDisplay()
{
      int xs,xt,xi,ys,yt,yi;
      int i,j,k,l;
      char *ptr;
      
      if(DispKey==TRUE)
      	ptr = &Key(0,0);
      else
      	ptr = &Puzzle(0,0);

      switch(rot)
       {
         case 1:xs=0 ;ys=0 ;xt=px+1;yt=py+1;xi= 1;yi= 1;break;
         case 2:xs=px;ys=0 ;xt=-1  ;yt=py+1;xi=-1;yi= 1;break;
         case 3:xs=0 ;ys=py;xt=px+1;yt=-1  ;xi= 1;yi=-1;break;
         case 4:xs=px;ys=py;xt=-1  ;yt=-1  ;xi=-1;yi=-1;break;
         case 5:xs=0 ;ys=0 ;xt=py+1;yt=px+1;xi= 1;yi= 1;break;
         case 6:xs=0 ;ys=px;xt=py+1;yt=-1  ;xi= 1;yi=-1;break;
         case 7:xs=py;ys=0 ;xt=-1  ;yt=px+1;xi=-1;yi= 1;break;
         case 8:xs=py;ys=px;xt=-1  ;yt=-1  ;xi=-1;yi=-1;break;
       }

      l = 0;

      for(j=ys;j!=yt;j=j+yi)
       {
         k = 0;
         for(i=xs;i!=xt;i=i+xi)
         {
          if(rot<5)
               Display(l,k) = *(ptr + i*(py+1) + j);
          else
               Display(l,k) = *(ptr + j*(py+1) + i);
          k++;
         }
         Display(l,k)=0;
         l++;
       }
}

