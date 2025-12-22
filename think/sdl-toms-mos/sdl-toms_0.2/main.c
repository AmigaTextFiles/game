/* ==== main.c ==== */
/*  Part of the source of the program "SDL-Toms", a puzzle game.
    Copyright (C) 2002-2003  Tom Barnes-Lawrence
    Current web address: www.angelfire.com/super2/duologue/#sdl-toms
    Current email address: tomble@usermail.com

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */




#include "sdl-toms.h"

int main(int argc,char *argv[]) {
   int i;
   init_graphics();
   while(1) {
     draw_menu_bg();
     main_menu();
     for(i=0;i<=players/*MAX_PLAYERS*/;i++) in_game[i]=1;
     for(i=0;i<160;i++) cells[i]=0; /* dont set up the player numbers */
     draw_grid();
     game_loop();
   }
}

void game_loop() {
   int p,i,cellover;
   int xc,yc,ic,ir;
   SDL_Event event;
   SDL_Rect trect;
/* for(p=0; ;p=(p+1)%MAX_PLAYERS) { */
   for(p=1; ;p=(p%MAX_PLAYERS)+1) {
      if(!in_game[p]) continue;
      GET_RECT(8,11,trect);
      SDL_BlitSurface(at_surf(p,1),NULL,main_surf,&trect);
      SDL_UpdateRect(main_surf,trect.x,trect.y,39,39);
      i=-1;
      /* get a valid click */
      /* it's valid when the cell clicked on EITHER
          -has cells[i]==0, or
          -has pcell[i]==p */
      while(i==-1) {
         if(SDL_PollEvent(&event)) {
            switch(event.type) {
              case SDL_MOUSEBUTTONUP:
               fprintf(stderr,"Button released\n");
               xc=event.button.x;
               yc=event.button.y;
               ic=(xc-8)/39;
               ir=(yc-8)/39;
               fprintf(stderr,"Cellrow:%d. Cellcol:%d\n",ir,ic);
               if(ic>=0&&ic<16&&ir>=0&&ir<10) {
                  i=(ir*16)+ic;
                  if(cells[i]!=0&&pcell[i]!=p) i=-1;
               } /* else i is already -1 anyway */
               break;
              case SDL_KEYDOWN:
               if(event.key.keysym.sym==SDLK_q) {
                  fprintf(stderr," 'q' for quit pressed. So quitting.\n");
                 /* exit(0); */
                  return; /* just back to main menu now */
               }
              default:;/* do nothing */
            }
         } else SDL_Delay(200); /* 1/5 of a second */
      }
      pcell[i]=p;
      cells[i]+=1;
      GET_RECT(ic,ir,trect);
      SDL_BlitSurface(at_surf(p,cells[i]),NULL,main_surf,&trect);
      SDL_UpdateRect(main_surf,trect.x,trect.y,39,39);
     /* SDL_Delay(500); */
      cellover=(ir>0)+(ir<9)+(ic>0)+(ic<15); /* 2 to 4 */
      if (cells[i]>=cellover) { /* explode! */
         fprintf(stderr,"BANG! Unstable cell %d.\n",i);
         if(unstable_list!=NULL) {
           fprintf(stderr,"List of unstable atoms is corrupted!\n");
         }
         new_unstable(i);
         if(do_chain(p)) break; /* We have a winner! */
         fprintf(stderr,"Order returns!\n");
      }
      /* turn done */
   }
   /* game over */
   fprintf(stderr,"PLAYER %d IS THE WINNER!\n",p);
   /*exit(0); */
}
