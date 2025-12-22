/*
 * Quadromania
 * (c) 2002/2003 by Matthias Arndt <marndt@asmsoftware.de> / ASM Software
 *
 * File: graphics.c - implements the graphics API
 * last Modified: 14.12.2003 : 11:41
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 *
 * THIS SOFTWARE IS SUPPLIED AS IT IS WITHOUT ANY WARRANTY!
 *
 */

#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <stdio.h>
#include <stdlib.h>

#include "graphics.h"
#include "SFont.h"

#if defined(__MORPHOS__)
#include "config.h"
#else
#include "../config.h"
#endif

static SDL_Surface *textures,*frame,*dots,*font,*titel,*copyright;

/* texture the complete screen with 1 out of 10 textures... */
void drawbackground(SDL_Surface *screen,Uint8 texture)
{
    Uint8 i,j;
    SDL_Rect src,dest;

    /* draw the textured background... */
    for(j=0;j<6;j++)
        for(i=0;i<8;i++)
        {
            src.x=(texture%10)*80;
            src.y=0;
            src.w=80;
            src.h=80;
            dest.x=i*80;
            dest.y=j*80;
            dest.w=0;
            dest.h=0;
            SDL_BlitSurface(textures,&src,screen,&dest);
        }
}

/* draw one of the coloured dots for the playfield... */
void drawdot(SDL_Surface *screen,Uint16 x,Uint16 y,Uint8 number)
{
    SDL_Rect src,dest;

    src.x=(number%5)*32;
    src.y=0;
    src.w=32;
    src.h=32;
    dest.x=x;
    dest.y=y;
    dest.w=0;
    dest.h=0;
    SDL_BlitSurface(dots,&src,screen,&dest);
}

/* draw the titel string */
void drawtitel(SDL_Surface *screen)
{
    SDL_Rect src,dest;

    src.x=0;
    src.y=0;
    src.w=titel->w;
    src.h=titel->h;
    dest.x=((screen->w/2)-(titel->w/2));
    dest.y=32;
    dest.w=0;
    dest.h=0;
    SDL_BlitSurface(titel,&src,screen,&dest);
    src.x=0;
    src.y=0;
    src.w=copyright->w;
    src.h=copyright->h;
    dest.x=((screen->w/2)-(copyright->w/2));
    dest.y=120;
    dest.w=0;
    dest.h=0;
    SDL_BlitSurface(copyright,&src,screen,&dest);
}


/* draw the outer frame... */
void drawframe(SDL_Surface *screen)
{
    SDL_Rect src,dest;

    src.x=0;
    src.y=0;
    src.w=frame->w;
    src.h=frame->h;
    dest.x=0;
    dest.y=0;
    dest.w=frame->w;
    dest.h=frame->h;
    SDL_BlitSurface(frame,&src,screen,&dest);
}

/* write some text with the default font on the screen... */
void text(SDL_Surface *screen,int x, int y, char *text)
{
    PutString(screen,x,y,text);
}

/* draws the instructions screen */
void drawinstructions(SDL_Surface *screen)
{
    SDL_Rect src,dest;

    drawbackground(screen,0);
    drawframe(screen);
    /* draw logo */
    src.x=0;
    src.y=0;
    src.w=titel->w;
    src.h=titel->h;
    dest.x=((screen->w/2)-(titel->w/2));
    dest.y=32;
    dest.w=0;
    dest.h=0;
    SDL_BlitSurface(titel,&src,screen,&dest);
    XCenteredString(screen, 120, "Instructions");

    text(screen,32,150,"Quadromania is a board game.");
    text(screen,32,170,"Your task is to restore the originating board filled with");
    text(screen,32,190,"red stones. The computer will pick a named amount of");
    text(screen,32,210,"3x3 tile sets and will flip the colours of the selected");
    text(screen,32,230,"tiles.");
    text(screen,32,250,"This means a red tile will become green, a green one the");
    text(screen,32,270,"next colour in the amount of colours, red again in the");
    text(screen,32,290,"simplest case.");
    text(screen,32,320,"You select the amount of colours to use and the amount of");
    text(screen,32,340,"initial rotations.");
    text(screen,32,360,"In the running game click on the center point of a 3x3 tile");
    text(screen,32,380,"set to exchange that selected set following the rules above.");
    text(screen,32,400,"Restore the board full of red stones before you reach the");
    text(screen,32,420,"limit of maximum turns.");

    text(screen,400,460,"Click here to continue!");
    SDL_Flip(screen);
}


/* to be able to use the graphics module, initialize it first... */
void initgraphics()
{
    char fname[512];

    sprintf(fname,"%s/%s",DATADIR,"texture.png");
    if((textures=IMG_Load(fname))==NULL)
        textures=IMG_Load("../data/texture.png");

    sprintf(fname,"%s/%s",DATADIR,"frame.png");
    if((frame=IMG_Load(fname))==NULL)
        frame=IMG_Load("../data/frame.png");

    sprintf(fname,"%s/%s",DATADIR,"dots.png");
    if((dots=IMG_Load(fname))==NULL)
        dots=IMG_Load("../data/dots.png");

    sprintf(fname,"%s/%s",DATADIR,"font.png");
    if((font=IMG_Load(fname))==NULL)
        font=IMG_Load("../data/font.png");

    sprintf(fname,"%s/%s",DATADIR,"titel.png");
    if((titel=IMG_Load(fname))==NULL)
        titel=IMG_Load("../data/titel.png");

    sprintf(fname,"%s/%s",DATADIR,"copyright.png");
    if((copyright=IMG_Load(fname))==NULL)
        copyright=IMG_Load("../data/copyright.png");

#ifdef _DEBUG
    fprintf(stderr,"images loaded....\n");
#endif
    InitFont(font);
#ifdef _DEBUG
    fprintf(stderr,"font ready...\n");
#endif
    /* did our graphics load properly? (remember NULL pointers for surfaces means "no valid surface data loaded" */
    if((textures==NULL)||(frame==NULL)||(dots==NULL)||(titel==NULL)||(copyright==NULL))
    {
        fprintf (stderr, "%s initgraphics(): One or more image files failed to load properly!\n\n",PACKAGE);
        exit(2);
    }

    /* hookup cleanup call */
    atexit(exitgraphics);
}

/* at exit clean up the graphics module... */
void exitgraphics()
{
    SDL_FreeSurface(copyright);
    SDL_FreeSurface(textures);
    SDL_FreeSurface(frame);
    SDL_FreeSurface(dots);
    SDL_FreeSurface(font);

#ifdef _DEBUG
    fprintf(stderr,"image surfaces successfully freed....\n");
#endif

}
