/* ==== graphics.c ==== */
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




#include <stdlib.h>
#include "sdl-toms.h"
SDL_Surface *atom_surfaces[8*MAX_PLAYERS];
SDL_Surface *blanked_surf;/* used to be done by elements of atom_surfaces*/
SDL_Surface *main_surf;
SDL_Surface *expl_surf;
/* menu stuff */
SDL_Surface *menu_bg;
SDL_Surface *menu_surface[MENU_LAST];
SDL_Surface *menu_back[MENU_LAST]; /* stores what item replaces, to delete it*/

char *menu_fname[MENU_LAST]= {
   "temparrow.png", /* pointer! */
   "start.png",
   "psetup.png",
   "dsetup.png",
   "quit.png",
   "2p.png",
   "3p.png",
   "4p.png",
   "fs.png",
   "igamma.png",
   "dgamma.png",
   "gammaicon.png",
   "return.png"
};

char fname[20];

void init_graphics() {
   int p,a;
   SDL_Init(SDL_INIT_VIDEO); /* if return is -1, failed */
   atexit(SDL_Quit);
   main_surf=SDL_SetVideoMode(640,480,16,SDL_SWSURFACE|(SDL_FULLSCREEN&&fullscreen));
   SDL_SetGamma(gamma,gamma,gamma); /* Should set from a config file, with widget*/
   expl_surf=IMG_Load("explode.png");
   if(expl_surf==NULL) {
      fprintf(stderr,"Couldn't load explode.png\n");
      exit(1);
   }
   blanked_surf=IMG_Load("blanked.png");
   if(blanked_surf==NULL) {
      fprintf(stderr,"Couldn't load blanked.png\n");
      exit(1);
   }
   menu_bg=IMG_Load("menubg.png");
   if(menu_bg==NULL) {
      fprintf(stderr,"Couldn't load menubg.png\n");
      exit(1);
   }
   /* load menu items (and pointer!)*/
   for(a=0;a<MENU_LAST;a++) {
     menu_surface[a]=IMG_Load(menu_fname[a]);
     if(menu_surface[a]==NULL) {
       fprintf(stderr,"Couldn't load menu graphic %s\n",menu_fname[a]);
       exit(1);
     }
     menu_back[a]=SDL_CreateRGBSurface(menu_surface[a]->flags,
      menu_surface[a]->w,menu_surface[a]->h, 16,
      menu_surface[a]->format->Rmask,menu_surface[a]->format->Gmask,
      menu_surface[a]->format->Bmask,0);
   }
   for(p=1;p<=MAX_PLAYERS;p++) {
      /* We no longer have atom_p?_n0.png=blank space */
      for(a=1;a<8;a++) {
         sprintf(fname,"atom_p%d_n%d.png",p,a);
         atom_surfaces[((p-1)*8)+a]=
         IMG_Load(fname);
         if(atom_surfaces[((p-1)*8)+a]==NULL) {
            fprintf(stderr,"Couldn't load image p%d_n%d.\n",p,a);
         }
      }
   }
   /*
   trect.x=7;trect.y=7;
   trect.w=625;trect.h=391;
   SDL_FillRect(main_surf,&trect,0xFFFF);
   trect.h=38;trect.w=38;
   for(p=0;p<16;p++)
     for(a=0;a<10;a++) {
        GET_RECT(p,a,trect);
        SDL_FillRect(main_surf,&trect,0x0000);
     }
   SDL_Flip(main_surf);
   */
}

void draw_grid() {
   int r,c;
   SDL_Rect trect;
   trect.x=7;trect.y=7;
   trect.w=625;trect.h=391;
   SDL_FillRect(main_surf,&trect,0xFFFF);
   trect.h=38;trect.w=38;
   for(c=0;c<16;c++)
     for(r=0;r<10;r++) {
        GET_RECT(c,r,trect);
        SDL_FillRect(main_surf,&trect,0x0000);
     }
   SDL_Flip(main_surf);
}

void draw_menu_bg() {
   SDL_BlitSurface(menu_bg,NULL,main_surf,NULL);
   SDL_Flip(main_surf);
}

/* Eventually change to a macro, in sdl-toms.h */
SDL_Surface *at_surf(int player, int atoms) {
/* fprintf(stderr,"no atoms: %d\n",atoms); */
   return(atoms?(atom_surfaces[((player-1)*8)+atoms]):blanked_surf);
}

