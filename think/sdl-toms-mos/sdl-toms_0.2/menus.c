/* ==== setup.c ==== */
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
#define DRAW_MENUITEM(sline,l,subj) (trect.y=sline+(l*48)),(SDL_BlitSurface(main_surf,&trect,menu_back[subj],NULL)),(SDL_BlitSurface(menu_surface[subj],NULL,main_surf,&trect))
#define DELETE_MENUITEM(sline,l,subj) (trect.y=sline+(l*48)),(SDL_BlitSurface(menu_back[subj],NULL,main_surf,&trect))

void psetup_menu();
void dsetup_menu();

void main_menu() {
   /* menu options:
    -start game
    -choose number of players
    -choose player colours? TODO!
    -setup display (gamma, fullscreen)
    -quit game */
   int i;
   SDL_Rect trect;
   menuitem_t menuitem[4]={MENU_START,MENU_PSETUP,MENU_DSETUP,MENU_QUIT};
   trect.x=112; /* 80+32
   trect.w=100;trect.h=32; */
   for(i=0;i<4;i++)
       DRAW_MENUITEM(100,i,menuitem[i]);
   /*
   DRAW_MENUITEM(100,0,MENU_START);
   DRAW_MENUITEM(100,1,MENU_PSETUP);
   DRAW_MENUITEM(100,2,MENU_DSETUP);
   DRAW_MENUITEM(100,3,MENU_QUIT);
   */
   SDL_UpdateRect(main_surf,0,0,0,0);
/*   SDL_Flip(main_surf);
*/

   while(1) {
       switch(get_menu_choice(100,4,0)) {
         case 0: /* start */
           return; /* to main menu! */
         case 1: /* setup players */
           for(i=0;i<4;i++)
              DELETE_MENUITEM(100,i,menuitem[i]);
           psetup_menu();
           for(i=0;i<4;i++)
              DRAW_MENUITEM(100,i,menuitem[i]);
           SDL_UpdateRect(main_surf,0,0,0,0);
           break;
         case 2: /* setup display */
           for(i=0;i<4;i++)
              DELETE_MENUITEM(100,i,menuitem[i]);
           dsetup_menu();
           for(i=0;i<4;i++)
              DRAW_MENUITEM(100,i,menuitem[i]);
           SDL_UpdateRect(main_surf,0,0,0,0);
           break;
         case 3: /* quit */
           exit(0);
       }
   }
}

void psetup_menu() {
   /*
   -item 1: choose number of players
   -item 2: choose player colours
   -item 3: return to main menu
   */
   int i;
   SDL_Rect trect;
   menuitem_t menuitem[3]={MENU_P2,MENU_P3,MENU_P4};
   trect.x=112;
   /* just these, currently */
   for (i=0;i<3;i++)
      DRAW_MENUITEM(100,i,menuitem[i]);
/* DRAW_MENUITEM(100,3,MENU_RETURN); */
   SDL_UpdateRect(main_surf,0,0,0,0);
   switch(get_menu_choice(100,3,players-2)) {
      case 0:
        players=2;
        return;
      case 1:
        players=3;
        return;
      case 2:
        players=4;
        return;
   }
}

void dsetup_menu() {
   /* display setup options:
   -item 1: fullscreen/windowed mode
   -item 2: set gamma level
   -item 3: return to main menu */
   int i,choice=0;
   SDL_Rect trect;
   menuitem_t menuitem[5]={MENU_FS,MENU_IGAMMA,MENU_DGAMMA,MENU_RETURN,MENU_GAMMAICON};
   trect.x=112;
   for(i=0;i<5;i++)
     DRAW_MENUITEM(100,i,menuitem[i]);
   SDL_UpdateRect(main_surf,0,0,0,0);
   while(1) {
     switch(choice=get_menu_choice(100,4,choice)) { /* final one isn't a choice */
        case 0:
           fullscreen=!fullscreen;
/*           SDL_SetThingy(); I think this requires getting a new video
           surface??? */
           break;
        case 1:
           gamma+=0.1;
           SDL_SetGamma(gamma,gamma,gamma);
           break;
        case 2:
           gamma-=0.1;
           SDL_SetGamma(gamma,gamma,gamma);
           break;
        case 3:
           for(i=0;i<5;i++)
             DELETE_MENUITEM(100,i,menuitem[i]);
           return;
     }
   }

}

int get_menu_choice(int sline,int choices,int dchoice) {
   SDL_Event event;
   SDL_Rect trect;
   int choice=dchoice,k=0,dc=0,chg;

   trect.x=80;
   while(k==0) {
     DRAW_MENUITEM(sline,choice,MENU_ARROW);
     SDL_UpdateRect(main_surf,trect.x,trect.y,32,32);
     chg=0;
     while(!chg) {
       if(SDL_PollEvent(&event))
        switch(event.type) {
           case SDL_KEYUP:
              /* switch on key */
              switch(event.key.keysym.sym) {
                 case SDLK_UP:
                   dc=choices-1;
                   chg=1;
                   break;
                 case SDLK_DOWN:
                   dc=1;
                   chg=1;
                   break;
                 case SDLK_RETURN:
                 case SDLK_SPACE:
                 case SDLK_RIGHT:
                   dc=0;
                   k=1;
                   chg=1;
                   break;
                 default:;
              }
              break;
           default:;
        }
       else SDL_Delay(100);
     }
     DELETE_MENUITEM(sline,choice,MENU_ARROW);
     SDL_UpdateRect(main_surf,trect.x,trect.y,32,32);
     choice=(choice+dc)%choices;
   }
   return choice;
}

/* --- */
