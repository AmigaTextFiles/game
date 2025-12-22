#include <stdio.h>
#include "wsearch.h"
#include <exec/types.h>
#include <proto/intuition.h>
#include <proto/graphics.h>

/* globals */
int w,px,py,filter,rot;
char word[MAXWORD][MAXSIZE+1];
char *key;

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

int LINK=0;	/* turned off but should work */

void main()
 {
   int i,j,k,error,xs,xt,ys,yt,xi,yi;
   char rotation[10];

    IntuitionBase = (struct IntuitionBase *)
      OpenLibrary("intuition.library",0);
    if(IntuitionBase == NULL) 
    {
	fprintf(stderr,"Couldn't Open Intuition.library\n");
	return;
    }
    
    GfxBase = (struct GfxBase *)
      OpenLibrary("graphics.library",0);
    if(GfxBase == NULL)
    {
	fprintf(stderr,"Couldn't Open Graphics.library\n");
	return;
    }
   
   printf("Enter a filter for valid directions\n");
   scanf("%d",&filter);
   if(filter==0) filter = 255;

   printf("Display Views\n1:(X+,Y+) 2:(X-,Y+) 3:(X+,Y-); 4:(X-,Y-)\n");
   printf("5:(Y+,X+) 6:(Y-,X+) 7:(Y+,X-); 8:(Y-,X-)\n");
   printf("ei. 135 would print 3 puzzles:\n");
   printf(" 1 follows the key,3 flips the y axis,5 transposes xy values\n");

   scanf("%s",&rotation);

   printf("Enter puzzle dimensions (width height)\n");
   scanf("%d %d",&px,&py);
   px = px-1; py=py-1;

   key = (char *)calloc((px+1)*(py+1),sizeof(char));
   if(key<=0)
   {
	fprintf(stderr,"Unable to allocate memory\n");
	exit(0);
   }

   for(i=0;i<=px;i++)
      for(j=0;j<=py;j++)
         Key(i,j) = ' ';

   printf("How many words do you have?\n");
   scanf("%d",&w);
   w = w - 1;

   printf("Enter the words:\n");
   for(i=0;i<=w;i++)
      scanf("%s",word[i]);
   printf("Working\n");

   error = wsearch();
   if(error!=0)
    {
      fprintf(stderr,"Cannot generate puzzle (a word won't fit)\n");
      exit(0);
    }

   printf("Key:\n");
   for(j=0;j<=py;j++)
    {
      for(i=0;i<=px;i++)
            printf("%c",Key(i,j));
      printf("\n");
    }
   printf("\n");

   for(i=0;i<=px;i++)
      for(j=0;j<=py;j++)
         if(Key(i,j) == ' ')
            Key(i,j) = (char)(randint(25)+65);

   printf("The Wordsearch(es):\n");
   k = 0;
   for(k=0;k<strlen(rotation);k++)
    {
      rot = rotation[k]-48;
      if(rot<1||rot>8) continue;

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

      for(j=ys;j!=yt;j=j+yi)
       {
         for(i=xs;i!=xt;i=i+xi)
          if(rot<5)
               printf("%c",Key(i,j));
          else
               printf("%c",Key(j,i));
         printf("\n");
       }
      printf("\n");
    }
   return;
 }

