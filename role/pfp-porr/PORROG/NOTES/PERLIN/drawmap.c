/* ==== drawmap.c ==== */
/* Takes a d2byte, draws the whole thing in an X window. */

#include <SDL_image.h>
#include "C-2darray.h"

void drawmap(d2byte *map)
{
   int wid,hgt, x,y;
   Uint8 val;

   SDL_Surface *mainwindow;
   SDL_PixelFormat *fmt;
   SDL_Rect destrect;


   /* Body */

   hgt=map->Ysize; wid=map->Xsize;
   SDL_Init(SDL_INIT_VIDEO);
   printf("SDL initialised.\n");

   /* Create our window */
   printf("Opening SDL display...\n");
   mainwindow=SDL_SetVideoMode(wid,hgt,16,SDL_SWSURFACE);
   if (NULL==mainwindow)
   {
      printf("ARGH! Window not allocated.\n");
      exit(1);
   }
   fmt=mainwindow->format;
   destrect.w=1;destrect.h=1;
   printf("Got window OK.\n");
   for (y=0;y<hgt;y++)
     for (x=0;x<wid;x++)
     {
        destrect.x=x;
        destrect.y=y;
        val=2.55*get_d2byte(map,y,x);
        SDL_FillRect(mainwindow,&destrect,SDL_MapRGB(fmt,val,val,val) );
     }
   SDL_UpdateRect(mainwindow,0,0,0, 0);
   for (x=0;x<32700;x++)
     for (y=0;y<32700;y++)
     {
       val=destrect.x;destrect.x=destrect.y;destrect.y=val;
     }
   SDL_Quit();

}
