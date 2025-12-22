#include <exec/types.h>
#include <stdio.h>
#include "wsearch.h"

void next();

char *wptr[MAXWORD];
extern int LINK;


int wsearch()
{
	int i,j,ls;
	char *temp;

	for(i=0;i<MAXWORD;i++)
		wptr[i] = word[i];

	ls=MAXWORD-1;
	while(ls>0)
	{
		j=0;
		for(i=0;i<ls;i++)
		{
			if(strlen(wptr[i])<strlen(wptr[i+1]))
			    {
				j=i;
				temp = wptr[i];
				wptr[i] = wptr[i+1];
				wptr[i+1] = temp;
			    }
		}
		ls = j;
	}
	
	w=MAXWORD-1;
     	while((wptr[w])[0]==0 && w!=-1)
        	w--;
     	if(w==-1) return(0);

	open_requestor();

	i = setword(0);
	
	close_requestor();
	
	return(i);
}

int setword(pos)
 int pos;
 {
   char buffer[MAXSIZE+1];
   int x,y,d,x0,y0,d0,s;
   static int error,i;
   int link;		/* indicate position must link with other words */


   link = LINK;

   x = randint(px);
   y = randint(py);
   d = randint(7);
   while((1<<d & filter) == 0)
    {
   d = d + 1;
   if(d>7) d=0;
    }

   s = 0;

   do
    {
      if(Stop_Flag()) return(-1);

      if(link==1)
      {
	error = advance(&x,&y,&d,pos,link);
	if(error!=0)
	{
		link = 0;
		error = advance(&x,&y,&d,pos,link);
	}
      }
      else error = advance(&x,&y,&d,pos,link);
      
      if(error!=0) return(1);
      if(s==0)
       {
         s = 1;
         x0 = x;
         y0 = y;
         d0 = d;
       }

      buffer[strlen((wptr[pos]))] = NULL;
      for(i=0;i<strlen((wptr[pos]));i++)
       {
         if(d==0)
          {
            buffer[i]=Key(x+i,y);
            Key(x+i,y)=(wptr[pos])[i];
          }
         else if(d==1)
          {
            buffer[i]=Key(x+i,y+i);
            Key(x+i,y+i)=(wptr[pos])[i];
          }
         else if(d==2)
          {
            buffer[i]=Key(x,y+i);
            Key(x,y+i)=(wptr[pos])[i];
          }
         else if(d==3)
          {
            buffer[i]=Key(x-i,y+i);
            Key(x-i,y+i)=(wptr[pos])[i];
          }
         else if(d==4)
          {
            buffer[i]=Key(x-i,y);
            Key(x-i,y)=(wptr[pos])[i];
          }
         else if(d==5)
          {
            buffer[i]=Key(x-i,y-i);
            Key(x-i,y-i)=(wptr[pos])[i];
          }
         else if(d==6)
          {
            buffer[i]=Key(x,y-i);
            Key(x,y-i)=(wptr[pos])[i];
          }
         else if(d==7)
          {
            buffer[i]=Key(x+i,y-i);
            Key(x+i,y-i)=(wptr[pos])[i];
          }
       }

      if(pos<w)
         error=setword(pos+1);
      else error = 0;

      if(error==0) return(0);

      for(i=0;i<strlen((wptr[pos]));i++)
       {
         if(d==0)
            Key(x+i,y)=buffer[i];
         else if(d==1)
            Key(x+i,y+i)=buffer[i];
         else if(d==2)
            Key(x,y+i)=buffer[i];
         else if(d==3)
            Key(x-i,y+i)=buffer[i];
         else if(d==4)
            Key(x-i,y)=buffer[i];
         else if(d==5)
            Key(x-i,y-i)=buffer[i];
         else if(d==6)
            Key(x,y-i)=buffer[i];
         else if(d==7)
            Key(x+i,y-i)=buffer[i];
       }
      next(&x,&y,&d);
      advance(&x,&y,&d,pos);
      if(x==x0 && y==y0 && d==d0) return(1);
      
      s = 1;
    }
    while(error!=0);
    
    return(0);
 }

void next(x,y,d)
 int *x,*y,*d;
 {
   *x = *x + 1;
        if(*x>px)
         {
           *x = 0;
           *y = *y + 1;
         }
        if(*y>py)
         {
           *x = 0;
           *y = 0;
      *d = *d + 1;
         }
        if(*d>7)
         {
           *x = 0;
           *y = 0;
           *d = 0;
         }
   while((1<<*d & filter) == 0)
       {
      *d = *d + 1;
      if(*d>7) *d=0;
       }
 }

int advance(x,y,d,pos,link)
 int *x,*y,*d,pos,link;
 {
   int x0,y0,d0,i,x1,y1;

   x0=*x;y0=*y;d0=*d;

   for(i=0;i<strlen(wptr[pos]);)
    {
      if(*d==0||*d==1||*d==7)
         x1=*x+i;
      else if(*d==3||*d==4||*d==5)
         x1=*x-i;
      else
         x1=*x;

      if(*d==1||*d==2||*d==3)
         y1=*y+i;
      else if(*d==5||*d==6||*d==7)
         y1=*y-i;
      else
         y1=*y;

      if((Key(x1,y1)!=' ' && (wptr[pos])[i]!=Key(x1,y1))||
         x1<0 || x1>px || y1<0 || y1>py)
       {
         i = 0;
	 if(link!=0) link=1;
         next(x,y,d);
         if(x0==*x && y0==*y && d0==*d) return(1);
       }
      else
      {
	 if(link==1 && (wptr[pos])[i]==Key(x1,y1)) link = -1;
	 /* the link is used to indicate both if a link was requested (not 0)
	    and if the current position does link (-1)
	  */
         i = i + 1;
      }
 
      if(link==1 && i==strlen(wptr[pos]))	/* finished word but no link */
      {
	 i = 0;
         next(x,y,d);
         if(x0==*x && y0==*y && d0==*d) return(1);
      }
    }
 
   return(0);
 }
