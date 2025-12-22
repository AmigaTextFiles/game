/* ==== chain.c ==== */
/* does the chain reactions */
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
#include <stdlib.h>
ulist_t *unstable_list=NULL;
/* any cells that get overloaded atom ranges are appended to
unstable_list. do_chain() steps each time it isn't NULL */

static udlist_t *update_list=NULL; /* Nothing else uses this, so not extern */

int do_chain(int player)
{
    int go_left,go_right,go_up,go_down;
    int i,ir,ic,cellover;
    int dont_find[5],remaining;
    ulist_t *uscan,*next;
    udlist_t *udscan,*udnext;
    SDL_Rect trect;
    trect.w=0;trect.h=0;
/*    trect.w=38;trect.h=38; */
    while(unstable_list!=NULL) {
       SDL_Delay(600);
       /* first, for each cell in unstable_list, show atoms exploding
       (just a cloud). Work out which directions atoms would go to. */
       for(uscan=unstable_list;uscan!=NULL;uscan=uscan->Next) {
          i=uscan->Idx;
          ir=(i/16); /* i>>4? */
          ic=(i&15);
          go_left=(ic>0);
          go_right=(ic<15);
          go_up=(ir>0);
          go_down=(ir<9);

          GET_RECT(ic,ir,trect);
          SDL_BlitSurface(expl_surf,NULL,main_surf,&trect);

          uscan->Gl=go_left;
          uscan->Gr=go_right;
          uscan->Gu=go_up;
          uscan->Gd=go_down;
          cells[i]-=(go_left+go_right+go_up+go_down);
          /* prolly leaves cell with 0 atoms, but not always */
       }
       /* Now update the screen... */
/*     SDL_UpdateRect(main_surf,0,0,640,480);
*/
       SDL_Flip(main_surf);
       SDL_Delay(100);
       /* Show the exploded cells with new number of atoms;
       Show the exploded-into cells with their new number (and colour!)
       of atoms too. */
       for(uscan=unstable_list;uscan!=NULL;next=uscan->Next,free_unstable(uscan),uscan=next) {
          i=uscan->Idx;
          ir=(i/16); /* i>>4 ? */
          ic=(i&15);
          GET_RECT(ic,ir,trect);
          SDL_BlitSurface(at_surf(player,cells[i]),NULL,main_surf,&trect);
          if(uscan->Gl) {
             /*
             cells[i-1]+=1;
             pcell[i-1]=player;
             GET_RECT((ic-1),ir,trect);
             SDL_BlitSurface(at_surf(player,cells[i-1]),NULL,main_surf,&trect);
             */
             new_update(i-1);
          }
          if(uscan->Gr) {
             /*
             cells[i+1]+=1;
             pcell[i+1]=player;
             GET_RECT((ic+1),ir,trect);
             SDL_BlitSurface(at_surf(player,cells[i+1]),NULL,main_surf,&trect);
             */
             new_update(i+1);
          }
          if(uscan->Gu) {
             /*
             cells[i-16]+=1;
             pcell[i-16]=player;
             GET_RECT(ic,(ir-1),trect);
             SDL_BlitSurface(at_surf(player,cells[i-16]),NULL,main_surf,&trect);
             */
             new_update(i-16);
          }
          if(uscan->Gd) {
             /*
             cells[i+16]+=1;
             pcell[i+16]=player;
             GET_RECT(ic,(ir+1),trect);
             SDL_BlitSurface(at_surf(player,cells[i+16]),NULL,main_surf,&trect);
             */
             new_update(i+16);
          }
       }
       /*
       SDL_UpdateRect(main_surf,0,0,640,480); */
       SDL_Flip(main_surf);
       SDL_Delay(100);
       unstable_list=NULL; /* It gets refilled next */
       for(udscan=update_list;udscan!=NULL;udnext=udscan->Next,free_update(),udscan=udnext) {
          i=ic=udscan->Col;
          for(ir=0; ir<10; ir++,i+=16) {
             if(udscan->Extra[ir]) { /* update this */
               /* i=ic+(ir*16); */
               cells[i]+=udscan->Extra[ir];
               pcell[i]=player;
               GET_RECT(ic,ir,trect);
               SDL_BlitSurface(at_surf(player,cells[i]),NULL,main_surf,&trect);
               cellover=(ir>0)+(ir<9)+(ic>0)+(ic<15); /*2 to 4 */
               if(cells[i]>=cellover) new_unstable(i);
             }
          }
          /* end of column */
       }
       SDL_Flip(main_surf);
       update_list=NULL;

       /* That's one iteration. May take several */
    }
    /* end of reaction. This is the *only* point at which we knock out
    players. */
    /* For any players not this player, but still in game, search
    for one index i where cells[i]>0 &&pcell[i]==p.*/

    /* only search for those in game */
    remaining=0;
    for(i=1;i<=4;i++) {
       if(in_game[i]) {
          remaining++;
          dont_find[i]=0;
       } else dont_find[i]=1;
   /*  dont_find[i]=!in_game[i]; */
    }
    /* dont search for player's atoms (must have some!!!) */
    dont_find[player]=1;
    for(i=0;i<160;i++) {
       if(cells[i]==0) continue;
       if(!dont_find[pcell[i]]) {
          dont_find[pcell[i]]=1; /* Accounted for */
          if(dont_find[1]&&dont_find[2]&&dont_find[3]&&dont_find[4]) break;
       }
    }
    for(i=1;i<=4;i++)
      if(!dont_find[i]) {
         remaining--;
         fprintf(stderr,"PLAYER %d IS OUT OF THE GAME!\n",i);
         in_game[i]=0;
      }
    /* Should also check for success!!! */
    return(remaining==1);
}

void new_unstable(int i) {
    ulist_t *new_u=get_unstable();
    new_u->Idx=i;
    new_u->Next=unstable_list;
    unstable_list=new_u;
}

void new_update(int index) {
   int ic=index&15; /* get column */
   int ir=index/16;
   udlist_t *scan=update_list;
   for(scan=update_list;scan!=NULL;scan=scan->Next) {
      if(scan->Col==ic) break; /* This is it! */
   }
   if (scan==NULL) {
      scan=get_update();
      scan->Col=ic;
      scan->Next=update_list;
      update_list=scan;
      /* Could also have an *ordered* list, for some extra access speed?
      Or is it not worth it? */
   }
   scan->Extra[ir]++;
}


#define UAMAX 2
ulist_t uarray[UAMAX];
int utot=0;

ulist_t *get_unstable() {
    ulist_t *new_u;
    if (utot>=UAMAX) {
      new_u=(ulist_t *)malloc(sizeof(ulist_t));
      new_u->Freeit=1;
    }
    else {
      new_u=(uarray+utot);
      new_u->Freeit=0;
    }
    utot++;
    return(new_u);
}
void free_unstable(ulist_t *u) {
    utot--;
    if(utot<0) {
       fprintf(stderr,"free_unstable():Freed too many bits of memory! Crashing\n");
       exit(1);
    }
    if(u->Freeit) free(u); /* otherwise, it's in the array */
}
udlist_t udarray[16];
int udtot=0;

udlist_t *get_update() {
    int i;
    udlist_t *new_u=udarray+udtot;
    if (udtot>16) { /* probably should be >15...*/
       fprintf(stderr,"Allocated too many bits of memory! Crashing\n");
       exit(1);
    }
    udtot++;
    /* clear the array */
    for(i=0;i<10;i++)
      new_u->Extra[i]=0;
    return(new_u);
}
void free_update() {
    if(udtot==0) {
       fprintf(stderr,"free_update():Freed too many bits of memory! Crashing\n");
       exit(1);
    }
    udtot--;
}

/* --- */
