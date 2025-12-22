
#ifdef _WIN32
#else
#include <stddef.h>
#include <sys/types.h>
#include <dirent.h>
#include "ctype.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "SDL/SDL.h"
#include "SDL_image.h"

#include "auxiliar.h"


#ifndef _WIN32
char *strupr(char *ptr)
{
    if (ptr!=0) {
        char *p=new char[strlen(ptr)+1];
        
        while(*p!=0) {
            *p=toupper(*p);
            p++;
        } /* while */ 
    } /* if */
    
    return ptr;
} 

#endif


SDL_Surface *load_maskedimage(char *imagefile,char *maskfile,char *path)
{
	char name[256];

	SDL_Surface *res;
    SDL_Surface *tmp;
	SDL_Surface *mask;

	sprintf(name,"%s%s",path,imagefile);
	tmp=IMG_Load(name);
	sprintf(name,"%s%s",path,imagefile);
	mask=IMG_Load(name);

    if (tmp==0 ||
		mask==0) return false;

	res=SDL_DisplayFormatAlpha(tmp);

	/* Aplicar la máscara: */ 
	{
		int x,y;
		Uint8 r,g,b,a;
		Uint32 v;

		for(y=0;y<mask->h;y++) {
			for(x=0;x<mask->w;x++) {
				v=getpixel(res,x,y);
				SDL_GetRGBA(v,res->format,&r,&g,&b,&a);
				v=getpixel(mask,x,y);
				if (v!=0) a=255;
					 else a=0;
				v=SDL_MapRGBA(res->format,r,g,b,a);
				putpixel(res,x,y,v);
			} /* for */ 
		} /* for */ 
	}

	SDL_FreeSurface(tmp);
	SDL_FreeSurface(mask);

	return res;
} /* load_maskedimage */ 


void putpixel(SDL_Surface *surface, int x, int y, Uint32 pixel)
{
	SDL_Rect clip;
    int bpp = surface->format->BytesPerPixel;

	SDL_GetClipRect(surface,&clip);

	if (x<clip.x || x>=clip.x+clip.w ||
		y<clip.y || y>=clip.y+clip.h) return;

	if (x<0 || x>=surface->w ||
		y<0 || y>=surface->h) return;

    Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

    switch(bpp) {
    case 1:
        *p = pixel;
        break;

    case 2:
        *(Uint16 *)p = pixel;
        break;

    case 3:
        if(SDL_BYTEORDER == SDL_BIG_ENDIAN) {
            p[0] = (pixel >> 16) & 0xff;
            p[1] = (pixel >> 8) & 0xff;
            p[2] = pixel & 0xff;
        } else {
            p[0] = pixel & 0xff;
            p[1] = (pixel >> 8) & 0xff;
            p[2] = (pixel >> 16) & 0xff;
        }
        break;

    case 4:
        *(Uint32 *)p = pixel;
        break;
    }
}


Uint32 getpixel(SDL_Surface *surface, int x, int y)
{
    int bpp = surface->format->BytesPerPixel;

	if (x<0 || x>=surface->w ||
		y<0 || y>=surface->h) return 0;

    Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

    switch(bpp) {
    case 1:
        return *p;

    case 2:
        return *(Uint16 *)p;

    case 3:
        if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
            return p[0] << 16 | p[1] << 8 | p[2];
        else
            return p[0] | p[1] << 8 | p[2] << 16;

    case 4:
        return *(Uint32 *)p;

    default:
        return 0;
    }
}


void surface_fader(SDL_Surface *surface,float r_factor,float g_factor,float b_factor)
{
	int i,x,y,offs;
	Uint8 rtable[256],gtable[256],btable[256];
	Uint8 *pixels = (Uint8 *)(surface->pixels);

	if (surface->format->BytesPerPixel!=4) return;

	for(i=0;i<256;i++) {
		rtable[i]=(Uint8)(i*r_factor);
		gtable[i]=(Uint8)(i*g_factor);
		btable[i]=(Uint8)(i*b_factor);
	} /* for */ 

	for(y=0;y<surface->h;y++) {
		for(x=0,offs=y*surface->pitch;x<surface->w;x++,offs+=4) {
#ifdef _WIN32
			pixels[offs]=rtable[pixels[offs]];
			pixels[offs+1]=gtable[pixels[offs+1]];
			pixels[offs+2]=btable[pixels[offs+2]];
#else                        
                        pixels[offs+3]=rtable[pixels[offs+3]];
                        pixels[offs+2]=gtable[pixels[offs+2]];
                        pixels[offs+1]=btable[pixels[offs+1]];
#endif
		} /* for */ 

	} /* for */ 

} /* surface_fader */ 


void rectangle(SDL_Surface *surface, int x, int y, int w, int h, Uint32 pixel)
{
	int i;

	for(i=0;i<w;i++) {
		putpixel(surface,x+i,y,pixel);
		putpixel(surface,x+i,y+h,pixel);
	} /* for */ 
	for(i=0;i<=h;i++) {
		putpixel(surface,x,y+i,pixel);
		putpixel(surface,x+w,y+i,pixel);
	} /* for */ 
} /* rectangle */ 
