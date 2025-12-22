/*
*	SDL Graphics Extension
*	Basic drawing functions
*
*	Started 990815
*
*	License: LGPL v2+ (see the file LICENSE)
*	(c)1999-2001 Anders Lindström
*/

/*********************************************************************
 *  This library is free software; you can redistribute it and/or    *
 *  modify it under the terms of the GNU Library General Public      *
 *  License as published by the Free Software Foundation; either     *
 *  version 2 of the License, or (at your option) any later version. *
 *********************************************************************/

/*
*	Some of this code is taken from the "Introduction to SDL" and
*	John Garrison's PowerPak	
*/

#include <SDL/SDL.h>
#include <math.h>
#include <string.h>
#include <stdarg.h>
#include "sge_draw.h"


/* Hacks to get SDL 1.1.5+ working */

#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) >= \
    SDL_VERSIONNUM(1, 1, 5)
	#define clip_xmin(pnt) pnt->clip_rect.x
	#define clip_xmax(pnt) pnt->clip_rect.x + pnt->clip_rect.w-1
	#define clip_ymin(pnt) pnt->clip_rect.y
	#define clip_ymax(pnt) pnt->clip_rect.y + pnt->clip_rect.h-1
#else
	#define clip_xmin(pnt) pnt->clip_minx
	#define clip_xmax(pnt) pnt->clip_maxx
	#define clip_ymin(pnt) pnt->clip_miny
	#define clip_ymax(pnt) pnt->clip_maxy
#endif


Uint8 _sge_update=1;
Uint8 _sge_lock=1;


/**********************************************************************************/
/**                            Misc. functions                                   **/
/**********************************************************************************/

//==================================================================================
// Turns off automatic update (to avoid tearing).
//==================================================================================
void sge_Update_OFF(void)
{
	_sge_update=0;	
}

//==================================================================================
// Turns on automatic update (default)
//==================================================================================
void sge_Update_ON(void)
{
	_sge_update=1;	
}

//==================================================================================
// Turns off automatic locking of surfaces
//==================================================================================
void sge_Lock_OFF(void)
{
	_sge_lock=0;	
}

//==================================================================================
// Turns on automatic locking (default)
//==================================================================================
void sge_Lock_ON(void)
{
	_sge_update=1;	
}


//==================================================================================
// SDL_UpdateRect does nothing if any part of the rectangle is outside the surface
// --- This version always work
//==================================================================================
void sge_UpdateRect(SDL_Surface *screen, Sint16 x, Sint16 y, Uint16 w, Uint16 h)
{
	if(_sge_update!=1 || screen != SDL_GetVideoSurface()){return;}
	
	if(x>=screen->w || y>=screen->h){return;}
	
	Sint16 a,b;

	a=w; b=h;

	
	if(x < 0){x=0;}
	if(y < 0){y=0;}
	
	if(a+x > screen->w){a=screen->w-x;}
	if(b+y > screen->h){b=screen->h-y;}

	SDL_UpdateRect(screen,x,y,a,b);
}


//==================================================================================
// Creates a 32bit (8/8/8/8) alpha surface
// Map colors with sge_MapAlpha() and then use the Uint32 color versions of
// SGEs routines
//==================================================================================
SDL_Surface *sge_CreateAlphaSurface(Uint32 flags, int width, int height)
{
	return SDL_CreateRGBSurface(flags,width,height,32, 0xFF000000, 0x00FF0000, 0x0000FF00, 0x000000FF);
}


//==================================================================================
// Returns the Uint32 color value for a 32bit (8/8/8/8) alpha surface
//==================================================================================
Uint32 sge_MapAlpha(Uint8 R, Uint8 G, Uint8 B, Uint8 A)
{
	Uint32 color=0;
	
	color|=R<<24;
	color|=G<<16;
	color|=B<<8;
	color|=A;
	
	return color;
}


//==================================================================================
// Sets an SDL error string
// Accepts formated argument - like printf()
// SDL_SetError() also does this, but it does not use standard syntax (why?)
//==================================================================================
void sge_SetError(const char *format, ...)
{
	char buf[256];

	va_list ap;
	
	#ifdef __WIN32__
	va_start((va_list*)ap, format); //Stupid w32 crosscompiler
	#else
	va_start(ap, format);
	#endif
	
	vsprintf(buf, format, ap);
	va_end(ap);

	SDL_SetError(buf);
}



/**********************************************************************************/
/**                            Pixel functions                                   **/
/**********************************************************************************/

//==================================================================================
// Fast put pixel
//==================================================================================
void _PutPixel(SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color)
{

	//if(x>=surface->clip_minx && x<=surface->clip_maxx && y>=surface->clip_miny && y<=surface->clip_maxy){
	if(x>=clip_xmin(surface) && x<=clip_xmax(surface) && y>=clip_ymin(surface) && y<=clip_ymax(surface)){
		switch (surface->format->BytesPerPixel) {
			case 1: { /* Assuming 8-bpp */
				*((Uint8 *)surface->pixels + y*surface->pitch + x) = color;
			}
			break;

			case 2: { /* Probably 15-bpp or 16-bpp */
				*((Uint16 *)surface->pixels + y*surface->pitch/2 + x) = color;
			}
			break;

			case 3: { /* Slow 24-bpp mode, usually not used */
				Uint8 *pix;
  				int shift;

  				/* Gack - slow, but endian correct */
  				pix = (Uint8 *)surface->pixels + y * surface->pitch + x*3;
  				shift = surface->format->Rshift;
  				*(pix+shift/8) = color>>shift;
  				shift = surface->format->Gshift;
  				*(pix+shift/8) = color>>shift;
  				shift = surface->format->Bshift;
  				*(pix+shift/8) = color>>shift;
			}
			break;

			case 4: { /* Probably 32-bpp */
				*((Uint32 *)surface->pixels + y*surface->pitch/4 + x) = color;
			}
			break;
		}
	}

}


//==================================================================================
// Fast put pixel (RGB)
//==================================================================================
void _PutPixel(SDL_Surface *surface, Sint16 x, Sint16 y, Uint8 R, Uint8 G, Uint8 B)
{
	_PutPixel(surface,x,y, SDL_MapRGB(surface->format, R, G, B));
}


//==================================================================================
// Fastest put pixel functions (don't mess up indata, thank you)
//==================================================================================
void _PutPixel8(SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color)
{
	*((Uint8 *)surface->pixels + y*surface->pitch + x) = color;
}
void _PutPixel16(SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color)
{
	*((Uint16 *)surface->pixels + y*surface->pitch/2 + x) = color;
}
void _PutPixel24(SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color)
{
	Uint8 *pix;
 	int shift;

 	/* Gack - slow, but endian correct */
 	pix = (Uint8 *)surface->pixels + y * surface->pitch + x*3;
 	shift = surface->format->Rshift;
 	*(pix+shift/8) = color>>shift;
 	shift = surface->format->Gshift;
 	*(pix+shift/8) = color>>shift;
 	shift = surface->format->Bshift;
 	*(pix+shift/8) = color>>shift;
}
void _PutPixel32(SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color)
{
	*((Uint32 *)surface->pixels + y*surface->pitch/4 + x) = color;
}
void _PutPixelX(SDL_Surface *dest,Sint16 x,Sint16 y,Uint32 color)
{
	switch ( dest->format->BytesPerPixel ) {
	case 1:
		*((Uint8 *)dest->pixels + y*dest->pitch + x) = color;
		break;
	case 2:
		*((Uint16 *)dest->pixels + y*dest->pitch/2 + x) = color;
		break;
	case 3:
		_PutPixel24(dest,x,y,color);
		break;
	case 4:
		*((Uint32 *)dest->pixels + y*dest->pitch/4 + x) = color;
		break;
	}
}


//==================================================================================
// Safe put pixel
//==================================================================================
void sge_PutPixel(SDL_Surface *surface, Sint16 x, Sint16 y, Uint32 color)
{

	if ( SDL_MUSTLOCK(surface) && _sge_lock ) {
		if ( SDL_LockSurface(surface) < 0 ) {
			return;
		}
	}

	_PutPixel(surface, x, y, color);

	if ( SDL_MUSTLOCK(surface) && _sge_lock ) {
		SDL_UnlockSurface(surface);
	}

	if(_sge_update!=1){return;}
	SDL_UpdateRect(surface, x, y, 1, 1);
}


//==================================================================================
// Safe put pixel (RGB)
//==================================================================================
void sge_PutPixel(SDL_Surface *surface, Sint16 x, Sint16 y, Uint8 R, Uint8 G, Uint8 B)
{
  sge_PutPixel(surface,x,y, SDL_MapRGB(surface->format, R, G, B));
}


//==================================================================================
// Calculate y pitch offset
// (the y pitch offset is constant for the same y coord and surface)
//==================================================================================
Sint32 sge_CalcYPitch(SDL_Surface *dest,Sint16 y)
{
  //if(y>=dest->clip_miny && y<=dest->clip_maxy){
	if(y>=clip_ymin(dest) && y<=clip_ymax(dest)){
		switch ( dest->format->BytesPerPixel ) {
		case 1:
			return y*dest->pitch;
			break;
		case 2:
			return y*dest->pitch/2;
			break;
		case 3:
			return y*dest->pitch;
			break;
		case 4:
			return y*dest->pitch/4;
			break;
		}
	}
	
	return -1;
}


//==================================================================================
// Put pixel with precalculated y pitch offset
//==================================================================================
void sge_pPutPixel(SDL_Surface *surface, Sint16 x, Sint32 ypitch, Uint32 color)
{

	//if(x>=surface->clip_minx && x<=surface->clip_maxx && ypitch>=0){
	if(x>=clip_xmin(surface) && x<=clip_xmax(surface) && ypitch>=0){
		switch (surface->format->BytesPerPixel) {
			case 1: { /* Assuming 8-bpp */
				*((Uint8 *)surface->pixels + ypitch + x) = color;
			}
			break;

			case 2: { /* Probably 15-bpp or 16-bpp */
				*((Uint16 *)surface->pixels + ypitch + x) = color;
			}
			break;

			case 3: { /* Slow 24-bpp mode, usually not used */
				Uint8 *pix;
  			int shift;

  			/* Gack - slow, but endian correct */
  			pix = (Uint8 *)surface->pixels + ypitch + x*3;
  			shift = surface->format->Rshift;
  			*(pix+shift/8) = color>>shift;
  			shift = surface->format->Gshift;
  			*(pix+shift/8) = color>>shift;
  			shift = surface->format->Bshift;
  			*(pix+shift/8) = color>>shift;
			}
			break;

			case 4: { /* Probably 32-bpp */
				*((Uint32 *)surface->pixels + ypitch + x) = color;
			}
			break;
		}
	}
}


//==================================================================================
// Get pixel
//==================================================================================
Uint32 sge_GetPixel(SDL_Surface *surface, Sint16 x, Sint16 y)
{
	switch (surface->format->BytesPerPixel) {
			case 1: { /* Assuming 8-bpp */
				return *((Uint8 *)surface->pixels + y*surface->pitch + x);
			}
			break;

			case 2: { /* Probably 15-bpp or 16-bpp */
				return *((Uint16 *)surface->pixels + y*surface->pitch/2 + x);
			}
			break;

			case 3: { /* Slow 24-bpp mode, usually not used */
				Uint8 *pix;
				int shift;
				Uint32 color=0;

				/* Does this work? */
				pix = (Uint8 *)surface->pixels + y * surface->pitch + x*3;
				shift = surface->format->Rshift;
				color = *(pix+shift/8)>>shift;
				shift = surface->format->Gshift;
				color|= *(pix+shift/8)>>shift;
				shift = surface->format->Bshift;
				color|= *(pix+shift/8)>>shift;
				return color;
			}
			break;

			case 4: { /* Probably 32-bpp */
				return *((Uint32 *)surface->pixels + y*surface->pitch/4 + x);
			}
			break;
		}
	return 0;
}



/**********************************************************************************/
/**                            Block functions                                   **/
/**********************************************************************************/

//==================================================================================
// The sge_write_block* functions copies the given block (a surface line) directly
// to the surface. This is *much* faster then using the put pixel functions to
// update a line. The block consist of Surface->w (the width of the surface) numbers
// of color values. Note the difference in byte size for the block elements for
// different color dephts. 24 bpp is slow and not included!
//==================================================================================
void sge_write_block8(SDL_Surface *Surface, Uint8 *block, Sint16 y)
{
	memcpy(	(Uint8 *)Surface->pixels + y*Surface->pitch, block, sizeof(Uint8)*Surface->w );
}
void sge_write_block16(SDL_Surface *Surface, Uint16 *block, Sint16 y)
{
	memcpy(	(Uint16 *)Surface->pixels + y*Surface->pitch/2, block, sizeof(Uint16)*Surface->w );
}
void sge_write_block32(SDL_Surface *Surface, Uint32 *block, Sint16 y)
{
	memcpy(	(Uint32 *)Surface->pixels + y*Surface->pitch/4, block, sizeof(Uint32)*Surface->w );
}


//==================================================================================
// ...and get
//==================================================================================
void sge_read_block8(SDL_Surface *Surface, Uint8 *block, Sint16 y)
{
	memcpy(	block,(Uint8 *)Surface->pixels + y*Surface->pitch, sizeof(Uint8)*Surface->w );
}
void sge_read_block16(SDL_Surface *Surface, Uint16 *block, Sint16 y)
{
	memcpy(	block,(Uint16 *)Surface->pixels + y*Surface->pitch/2, sizeof(Uint16)*Surface->w );
}
void sge_read_block32(SDL_Surface *Surface, Uint32 *block, Sint16 y)
{
	memcpy(	block,(Uint32 *)Surface->pixels + y*Surface->pitch/4, sizeof(Uint32)*Surface->w );
}



/**********************************************************************************/
/**                             Line functions                                   **/
/**********************************************************************************/

//==================================================================================
// Draw hor. line
//==================================================================================
void sge_HLine(SDL_Surface *Surface, Sint16 x1, Sint16 x2, Sint16 y, Uint32 Color)
{
	if ( SDL_MUSTLOCK(Surface) && _sge_lock) {
		if ( SDL_LockSurface(Surface) < 0 ) {
			return;
		}
	}

	if(x1>x2){Sint16 tmp=x1; x1=x2; x2=tmp;}
	
	//Do the clipping
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if(y<Surface->clip_miny || y>Surface->clip_maxy || x1>Surface->clip_maxx || x2<Surface->clip_minx)
		return;
	if(x1<Surface->clip_minx)
		x1=Surface->clip_minx;
	if(x2>Surface->clip_maxx)
		x2=Surface->clip_maxx;
	#endif
	
	SDL_Rect l;
	l.x=x1; l.y=y; l.w=x2-x1+1; l.h=1;
	
	SDL_FillRect(Surface, &l, Color);

	if ( SDL_MUSTLOCK(Surface) && _sge_lock) {
		SDL_UnlockSurface(Surface);
	}

	sge_UpdateRect(Surface, x1, y, x2-x1+1, 1);
}


//==================================================================================
// Draw hor. line (RGB)
//==================================================================================
void sge_HLine(SDL_Surface *Surface, Sint16 x1, Sint16 x2, Sint16 y, Uint8 R, Uint8 G, Uint8 B)
{
	sge_HLine(Surface,x1,x2,y, SDL_MapRGB(Surface->format, R, G, B));
}


//==================================================================================
// Internal draw hor. line
//==================================================================================
void _HLine(SDL_Surface *Surface, Sint16 x1, Sint16 x2, Sint16 y, Uint32 Color)
{
	if(x1>x2){Sint16 tmp=x1; x1=x2; x2=tmp;}

	//Do the clipping
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if(y<Surface->clip_miny || y>Surface->clip_maxy || x1>Surface->clip_maxx || x2<Surface->clip_minx)
		return;
	if(x1<Surface->clip_minx)
		x1=Surface->clip_minx;
	if(x2>Surface->clip_maxx)
		x2=Surface->clip_maxx;
	#endif
	
	SDL_Rect l;
	l.x=x1; l.y=y; l.w=x2-x1+1; l.h=1;
	
	SDL_FillRect(Surface, &l, Color);
}


//==================================================================================
// Draw ver. line
//==================================================================================
void sge_VLine(SDL_Surface *Surface, Sint16 x, Sint16 y1, Sint16 y2, Uint32 Color)
{
	if ( SDL_MUSTLOCK(Surface) && _sge_lock) {
		if ( SDL_LockSurface(Surface) < 0 ) {
			return;
		}
	}

	if(y1>y2){Sint16 tmp=y1; y1=y2; y2=tmp;}
	
	//Do the clipping
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if(x<Surface->clip_minx || x>Surface->clip_maxx || y1>Surface->clip_maxy || y2<Surface->clip_miny)
		return;
	if(y1<Surface->clip_miny)
		y1=Surface->clip_miny;
	if(y2>Surface->clip_maxy)
		y2=Surface->clip_maxy;
	#endif
	
	SDL_Rect l;
	l.x=x; l.y=y1; l.w=1; l.h=y2-y1+1;
	
	SDL_FillRect(Surface, &l, Color);

	if ( SDL_MUSTLOCK(Surface) && _sge_lock) {
		SDL_UnlockSurface(Surface);
	}

	sge_UpdateRect(Surface, x, y1, 1, y2-y1+1);
}


//==================================================================================
// Draw ver. line (RGB)
//==================================================================================
void sge_VLine(SDL_Surface *Surface, Sint16 x, Sint16 y1, Sint16 y2, Uint8 R, Uint8 G, Uint8 B)
{
	sge_VLine(Surface,x,y1,y2, SDL_MapRGB(Surface->format, R, G, B));
}


//==================================================================================
// Internal draw ver. line
//==================================================================================
void _VLine(SDL_Surface *Surface, Sint16 x, Sint16 y1, Sint16 y2, Uint32 Color)
{
	if(y1>y2){Sint16 tmp=y1; y1=y2; y2=tmp;}

	//Do the clipping
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if(x<Surface->clip_minx || x>Surface->clip_maxx || y1>Surface->clip_maxy || y2<Surface->clip_miny)
		return;
	if(y1<Surface->clip_miny)
		y1=Surface->clip_miny;
	if(y2>Surface->clip_maxy)
		y2=Surface->clip_maxy;
	#endif
	
	SDL_Rect l;
	l.x=x; l.y=y1; l.w=1; l.h=y2-y1+1;
	
	SDL_FillRect(Surface, &l, Color);
}


//==================================================================================
// Performs Callback at each line point. (From PowerPak)
//==================================================================================
void sge_DoLine(SDL_Surface *Surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 Color, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color))
{
	Sint16 dx, dy, sdx, sdy, x, y, px, py;

 	dx = x2 - x1;
 	dy = y2 - y1;

 	sdx = (dx < 0) ? -1 : 1;
 	sdy = (dy < 0) ? -1 : 1;

 	dx = sdx * dx + 1;
 	dy = sdy * dy + 1;

 	x = y = 0;

 	px = x1;
 	py = y1;

 	if (dx >= dy){
  	for (x = 0; x < dx; x++){
    	Callback(Surface, px, py, Color);
	
	  	y += dy;
	  	if (y >= dx){
	    	y -= dx;
	    	py += sdy;
	   	}
	  	px += sdx;
		}
	}
	else{
  	for (y = 0; y < dy; y++){
    	Callback(Surface, px, py, Color);

	  	x += dx;
	  	if (x >= dy){
	    	x -= dy;
	    	px += sdx;
	   	}
	  	py += sdy;
		}
	}

}


//==================================================================================
// Performs Callback at each line point. (RGB)
//==================================================================================
void sge_DoLine(SDL_Surface *Surface, Sint16 X1, Sint16 Y1, Sint16 X2, Sint16 Y2, Uint8 R, Uint8 G, Uint8 B, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color))
{
	sge_DoLine(Surface,X1,Y1,X2,Y2, SDL_MapRGB(Surface->format, R, G, B),Callback);
}


//==================================================================================
// Draws a line
//==================================================================================
void sge_Line(SDL_Surface *Surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 Color)
{
	//Uint32 Color = SDL_MapRGB(Surface->format, R, G, B);

   if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      if (SDL_LockSurface(Surface) < 0)
         return;
   }

   /* Draw the line */
   sge_DoLine(Surface, x1, y1, x2, y2, Color, _PutPixel);

   /* unlock the display */
   if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      SDL_UnlockSurface(Surface);
   }

	sge_UpdateRect(Surface, (x1 < x2)? x1 : x2, (y1 < y2)? y1 : y2, ((x2-x1)<0)? (x1-x2+1) : (x2-x1+1), ((y2-y1)<0)? (y1-y2+1) : (y2-y1+1));

}


//==================================================================================
// Draws a line (RGB)
//==================================================================================
void sge_Line(SDL_Surface *Surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint8 R, Uint8 G, Uint8 B)
{
	sge_Line(Surface,x1,y1,x2,y2, SDL_MapRGB(Surface->format, R, G, B));
}



/**********************************************************************************/
/**                           Figure functions                                   **/
/**********************************************************************************/

//==================================================================================
// Draws a rectangle
//==================================================================================
void sge_Rect(SDL_Surface *Surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color)
{
	//Uint32 color = SDL_MapRGB(Surface->format, R, G, B);
	
	if ( SDL_MUSTLOCK(Surface) && _sge_lock) {
		if ( SDL_LockSurface(Surface) < 0 ) {
			return;
		}
	}

	_HLine(Surface,x1,x2,y1,color);
	_HLine(Surface,x1,x2,y2,color);
	_VLine(Surface,x1,y1,y2,color);
	_VLine(Surface,x2,y1,y2,color);

	if (SDL_MUSTLOCK(Surface) && _sge_lock) {
  	SDL_UnlockSurface(Surface);
	}

	sge_UpdateRect(Surface, x1, y1, x2-x1, 1);
	sge_UpdateRect(Surface, x1, y2, x2-x1+1, 1); /* Hmm? */
	sge_UpdateRect(Surface, x1, y1, 1, y2-y1);
	sge_UpdateRect(Surface, x2, y1, 1, y2-y1);
}


//==================================================================================
// Draws a rectangle (RGB)
//==================================================================================
void sge_Rect(SDL_Surface *Surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint8 R, Uint8 G, Uint8 B)
{
	sge_Rect(Surface,x1,y1,x2,y2, SDL_MapRGB(Surface->format, R, G, B));
}


//==================================================================================
// Draws a filled rectangle
//==================================================================================
void sge_FilledRect(SDL_Surface *Surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color)
{
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if(x2<Surface->clip_minx || x1>Surface->clip_maxx || y2<Surface->clip_miny || y1>Surface->clip_maxy)
		return;

	if (x1 < Surface->clip_minx)
  	x1=Surface->clip_minx;
	if (x2 > Surface->clip_maxx)
  	x2=Surface->clip_maxx;
	if (y1 < Surface->clip_miny)
  	y1=Surface->clip_miny;
	if (y2 > Surface->clip_maxy)
  	y2=Surface->clip_maxy;
	#endif

	SDL_Rect area;
	area.x=x1; area.y=y1;
	area.w=x2-x1+1; area.h=y2-y1+1;

	SDL_FillRect(Surface,&area,color);

	sge_UpdateRect(Surface, x1, y1, x2-x1+1, y2-y1+1);
}

//==================================================================================
// Draws a filled rectangle (RGB)
//==================================================================================
void sge_FilledRect(SDL_Surface *Surface, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint8 R, Uint8 G, Uint8 B)
{
	sge_FilledRect(Surface,x1,y1,x2,y2, SDL_MapRGB(Surface->format, R, G, B));	
}


//==================================================================================
// Performs Callback at each ellipse point.
// (from Allegro)
//==================================================================================
void sge_DoEllipse(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color) )
{
	int ix, iy;
	int h, i, j, k;
	int oh, oi, oj, ok;

	if (rx < 1)
		rx = 1;

	if (ry < 1)
  	ry = 1;

	h = i = j = k = 0xFFFF;

	if (rx > ry) {
  	ix = 0;
   	iy = rx * 64;

 		do {
			oh = h;
	 		oi = i;
	 		oj = j;
			ok = k;

	 		h = (ix + 32) >> 6;
	 		i = (iy + 32) >> 6;
	 		j = (h * ry) / rx;
	 		k = (i * ry) / rx;

	 		if (((h != oh) || (k != ok)) && (h < oi)) {
	  		Callback(Surface, x+h, y+k, color);
	   		if (h)
	    		Callback(Surface, x-h, y+k, color);
	   		if (k) {
	    		Callback(Surface, x+h, y-k, color);
	     		if (h)
		  			Callback(Surface, x-h, y-k, color);
	  		}
			}

	 		if (((i != oi) || (j != oj)) && (h < i)) {
	   		Callback(Surface, x+i, y+j, color);
	  		if (i)
	    		Callback(Surface, x-i, y+j, color);
	  		if (j) {
	   			Callback(Surface, x+i, y-j, color);
	   			if (i)
		  			Callback(Surface, x-i, y-j, color);
	 			}
	 		}

			ix = ix + iy / rx;
	 		iy = iy - ix / rx;

		} while (i > h);
  }
	else {
  	ix = 0;
   	iy = ry * 64;

  	do {
	 		oh = h;
	 		oi = i;
	 		oj = j;
	 		ok = k;

	 		h = (ix + 32) >> 6;
	 		i = (iy + 32) >> 6;
	 		j = (h * rx) / ry;
	 		k = (i * rx) / ry;

	 		if (((j != oj) || (i != oi)) && (h < i)) {
	    	Callback(Surface, x+j, y+i, color);
	    	if (j)
	      	Callback(Surface, x-j, y+i, color);
	    	if (i) {
	       	Callback(Surface, x+j, y-i, color);
	       	if (j)
		  			Callback(Surface, x-j, y-i, color);
	    	}
	 		}

	 		if (((k != ok) || (h != oh)) && (h < oi)) {
	    	Callback(Surface, x+k, y+h, color);
	   		if (k)
	     		Callback(Surface, x-k, y+h, color);
	    	if (h) {
	      	Callback(Surface, x+k, y-h, color);
	    		if (k)
		  			Callback(Surface, x-k, y-h, color);
	    	}
	 		}

	 		ix = ix + iy / ry;
	 		iy = iy - ix / ry;

  	} while(i > h);
	}
}

//==================================================================================
// Performs Callback at each ellipse point. (RGB)
//==================================================================================
void sge_DoEllipse(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint8 R, Uint8 G, Uint8 B, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color) )
{
	sge_DoEllipse(Surface,x,y,rx,ry,SDL_MapRGB(Surface->format, R, G, B),Callback);
}

//==================================================================================
// Draws an ellipse
//==================================================================================
void sge_Ellipse(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color)
{
	if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      if (SDL_LockSurface(Surface) < 0)
         return;
   }

   sge_DoEllipse(Surface, x, y, rx, ry, color, _PutPixel);

   if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      SDL_UnlockSurface(Surface);
   }

	sge_UpdateRect(Surface, x-rx, y-ry, 2*rx+1, 2*ry+1);
	
}


//==================================================================================
// Draws an ellipse (RGB)
//==================================================================================
void sge_Ellipse(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint8 R, Uint8 G, Uint8 B)
{
	sge_Ellipse(Surface,x,y,rx,ry,SDL_MapRGB(Surface->format, R, G, B));
}


//==================================================================================
// Draws a filled ellipse
//==================================================================================
void sge_FilledEllipse(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color)
{
	if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      if (SDL_LockSurface(Surface) < 0)
         return;
	}

  int ix, iy;
	int h, i, j, k;
	int oh, oi, oj, ok;

	if (rx < 1)
		rx = 1;

	if (ry < 1)
  	ry = 1;

	h = i = j = k = 0xFFFF;

	if (rx > ry) {
  	ix = 0;
   	iy = rx * 64;

 		do {
			oh = h;
	 		oi = i;
	 		oj = j;
			ok = k;

	 		h = (ix + 32) >> 6;
	 		i = (iy + 32) >> 6;
	 		j = (h * ry) / rx;
	 		k = (i * ry) / rx;

	 		if (((h != oh) || (k != ok)) && (h < oi)) {
	 		  _HLine(Surface,x-h,x+h,y+k,color);
	   		if (k) {
	   		  _HLine(Surface,x-h,x+h,y-k,color);
	  		}
			}

	 		if (((i != oi) || (j != oj)) && (h < i)) {
	 			_HLine(Surface,x-i,x+i,y+j,color);
	  		if (j) {
	  		 	_HLine(Surface,x-i,x+i,y-j,color);
	 			}
	 		}

			ix = ix + iy / rx;
	 		iy = iy - ix / rx;

		} while (i > h);
  }
	else {
  	ix = 0;
   	iy = ry * 64;

  	do {
	 		oh = h;
	 		oi = i;
	 		oj = j;
	 		ok = k;

	 		h = (ix + 32) >> 6;
	 		i = (iy + 32) >> 6;
	 		j = (h * rx) / ry;
	 		k = (i * rx) / ry;

	 		if (((j != oj) || (i != oi)) && (h < i)) {
	 			_HLine(Surface,x-j,x+j,y+i,color);
	    	if (i) {
	    		_HLine(Surface,x-j,x+j,y-i,color);
	    	}
	 		}

	 		if (((k != ok) || (h != oh)) && (h < oi)) {
	 			_HLine(Surface,x-k,x+k,y+h,color);
	    	if (h) {
	    		_HLine(Surface,x-k,x+k,y-h,color);
	    	}
	 		}

	 		ix = ix + iy / ry;
	 		iy = iy - ix / ry;

  	} while(i > h);
	}

	if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      SDL_UnlockSurface(Surface);
   }

	sge_UpdateRect(Surface, x-rx, y-ry, 2*rx+1, 2*ry+1);
				
}


//==================================================================================
// Draws a filled ellipse (RGB)
//==================================================================================
void sge_FilledEllipse(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint8 R, Uint8 G, Uint8 B)
{
	sge_FilledEllipse(Surface,x,y,rx,ry,SDL_MapRGB(Surface->format, R, G, B));
}


//==================================================================================
// Performs Callback at each circle point.
//==================================================================================
void sge_DoCircle(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 r, Uint32 color, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color))
{
	Sint16 cx = 0;
 	Sint16 cy = r;
 	Sint16 df = 1 - r;
 	Sint16 d_e = 3;
 	Sint16 d_se = -2 * r + 5;

 	do {
 		Callback(Surface, x+cx, y+cy, color);
		Callback(Surface, x-cx, y+cy, color);
	 	Callback(Surface, x+cx, y-cy, color);
	 	Callback(Surface, x-cx, y-cy, color);
	 	Callback(Surface, x+cy, y+cx, color);
	  Callback(Surface, x+cy, y-cx, color);
	  Callback(Surface, x-cy, y+cx, color);
	  Callback(Surface, x-cy, y-cx, color);

		if (df < 0)  {
	 		df += d_e;
	 		d_e += 2;
	 		d_se += 2;
 		}
   	else {
	 		df += d_se;
	 		d_e += 2;
	 		d_se += 4;
	 		cy--;
   	}

  	cx++;

	}while(cx <= cy);
	
}


//==================================================================================
// Performs Callback at each circle point. (RGB)
//==================================================================================
void sge_DoCircle(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 r, Uint8 R, Uint8 G, Uint8 B, void Callback(SDL_Surface *Surf, Sint16 X, Sint16 Y, Uint32 Color))
{
	sge_DoCircle(Surface,x,y,r,SDL_MapRGB(Surface->format, R, G, B),Callback);
}


//==================================================================================
// Draws a circle
//==================================================================================
void sge_Circle(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 r, Uint32 color)
{
	if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      if (SDL_LockSurface(Surface) < 0)
         return;
   }

   sge_DoCircle(Surface, x, y, r, color, _PutPixel);

   if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      SDL_UnlockSurface(Surface);
   }

	sge_UpdateRect(Surface, x-r, y-r, 2*r+1, 2*r+1);
	
}


//==================================================================================
// Draws a circle (RGB)
//==================================================================================
void sge_Circle(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 r, Uint8 R, Uint8 G, Uint8 B)
{
	sge_Circle(Surface,x,y,r,SDL_MapRGB(Surface->format, R, G, B));
}


//==================================================================================
// Draws a filled circle
//==================================================================================
void sge_FilledCircle(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 r, Uint32 color)
{
	if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      if (SDL_LockSurface(Surface) < 0)
         return;
   }


  Sint16 cx = 0;
 	Sint16 cy = r;
 	Sint16 df = 1 - r;
 	Sint16 d_e = 3;
 	Sint16 d_se = -2 * r + 5;

 	do {
 		_HLine(Surface,x-cx,x+cx,y+cy,color);
		_HLine(Surface,x-cx,x+cx,y-cy,color);
	 	_HLine(Surface,x-cy,x+cy,y-cx,color);
	 	_HLine(Surface,x-cy,x+cy,y+cx,color);

		if (df < 0)  {
	 		df += d_e;
	 		d_e += 2;
	 		d_se += 2;
 		}
   	else {
	 		df += d_se;
	 		d_e += 2;
	 		d_se += 4;
	 		cy--;
   	}

  	cx++;

	}while(cx <= cy);

	if (SDL_MUSTLOCK(Surface) && _sge_lock) {
      SDL_UnlockSurface(Surface);
   }

	sge_UpdateRect(Surface, x-r, y-r, 2*r+1, 2*r+1);
				
}


//==================================================================================
// Draws a filled circle (RGB)
//==================================================================================
void sge_FilledCircle(SDL_Surface *Surface, Sint16 x, Sint16 y, Sint16 r, Uint8 R, Uint8 G, Uint8 B)
{
	sge_FilledCircle(Surface,x,y,r,SDL_MapRGB(Surface->format, R, G, B));
}



/**********************************************************************************/
/**                       Blitting/surface functions                             **/
/**********************************************************************************/

//==================================================================================
// Clear surface to color
//==================================================================================
void sge_ClearSurface(SDL_Surface *Surface, Uint32 color)
{

	SDL_FillRect(Surface,NULL, color);

	if(_sge_update!=1){return;}
	SDL_UpdateRect(Surface, 0,0,0,0);
}


//==================================================================================
// Clear surface to color (RGB)
//==================================================================================
void sge_ClearSurface(SDL_Surface *Surface, Uint8 R, Uint8 G, Uint8 B)
{
	sge_ClearSurface(Surface,SDL_MapRGB(Surface->format, R, G, B));
}


//==================================================================================
// Blit from one surface to another
// Warning! Alpha and color key is lost (=0) on Src surface
//==================================================================================
int sge_BlitTransparent(SDL_Surface *Src, SDL_Surface *Dest, Sint16 SrcX, Sint16 SrcY, Sint16 DestX, Sint16 DestY, Sint16 W, Sint16 H, Uint32 Clear, Uint8 Alpha)
{
 	SDL_Rect src, dest;
	int ret;

	/* Dest clipping */
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	int flag=0;
		
	if (DestX < Dest->clip_minx){
		SrcX += Dest->clip_minx-DestX;
		W -= Dest->clip_minx-DestX-1;
  	DestX=Dest->clip_minx;
 	}
	if (DestY < Dest->clip_miny){
		SrcY +=Dest->clip_miny-DestY;
		H -= Dest->clip_miny-DestY-1;
 		DestY=Dest->clip_miny;
 	}
	if ((DestX + W) > Dest->clip_maxx){
   	W = W - ((DestX + W) - Dest->clip_maxx)+1;
		if(W<=0){SDL_SetError("SGE - Blit error");return -1;}
 	}
 	if ((DestY + H) > Dest->clip_maxy){
  	H = H - ((DestY + H) - Dest->clip_maxy)+1;
		if(H<=0){SDL_SetError("SGE - Blit error");return -1;}
 	}
	#endif

 	/* Initialize our rectangles */
 	src.x = SrcX;
 	src.y = SrcY;
 	src.w = W;
 	src.h = H;

 	dest.x = DestX;
 	dest.y = DestY;
 	dest.w = W;
 	dest.h = H;

	/* We don't care about src clipping, only dest! */
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if ( (Src->flags & SDL_SRCCLIPPING) == SDL_SRCCLIPPING){
		Src->flags &= ~SDL_SRCCLIPPING; flag=1;
	}
	#endif

 	/* Set the color to be transparent */
 	SDL_SetColorKey(Src, SDL_SRCCOLORKEY|SDL_RLEACCEL, Clear);

 	/* Set the alpha value */
 	SDL_SetAlpha(Src, SDL_SRCALPHA, Alpha);

	/* Blit */	
 	ret=SDL_BlitSurface(Src, &src, Dest, &dest);

	/* Set the correct flag */
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if (flag==1){
		Src->flags |= SDL_SRCCLIPPING;
	}
	#endif

	/* Set normal levels */
	SDL_SetAlpha(Src,0,0);
	SDL_SetColorKey(Src,0,0);

	return ret;
}


//==================================================================================
// Blit from one surface to another (not touching alpha or color key -
// use SDL_SetColorKey and SDL_SetAlpha)
//==================================================================================
int sge_Blit(SDL_Surface *Src, SDL_Surface *Dest, Sint16 SrcX, Sint16 SrcY, Sint16 DestX, Sint16 DestY, Sint16 W, Sint16 H)
{
	SDL_Rect src, dest;
	int ret;

	/* Dest clipping */
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	int flag=0;
		
	if (DestX < Dest->clip_minx){
		SrcX += Dest->clip_minx-DestX;
		W -= Dest->clip_minx-DestX -1;
  	DestX=Dest->clip_minx;
 	}
	if (DestY < Dest->clip_miny){
		SrcY +=Dest->clip_miny-DestY;
		H -= Dest->clip_miny-DestY -1;
 		DestY=Dest->clip_miny;
 	}
	if ((DestX + W) > Dest->clip_maxx){
  	W = W - ((DestX + W) - Dest->clip_maxx)+1;
		if(W<=0){SDL_SetError("SGE - Blit error");return -1;}
  }
 	if ((DestY + H) > Dest->clip_maxy){
  	H = H - ((DestY + H) - Dest->clip_maxy)+1;
		if(H<=0){SDL_SetError("SGE - Blit error");return -1;}
 	}
	#endif

 	/* Initialize our rectangles */
 	src.x = SrcX;
 	src.y = SrcY;
 	src.w = W;
 	src.h = H;

 	dest.x = DestX;
 	dest.y = DestY;
 	dest.w = W;
 	dest.h = H;

	/* We don't care about src clipping, only dest! */
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if ( (Src->flags & SDL_SRCCLIPPING) == SDL_SRCCLIPPING){
		Src->flags &= ~SDL_SRCCLIPPING; flag=1;
	}
	#endif

  /* Blit */
 	ret=SDL_BlitSurface(Src, &src, Dest, &dest);

	/* Set the correct flag */
	#if SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL) < \
    SDL_VERSIONNUM(1, 1, 5)
	if (flag==1){
		Src->flags |= SDL_SRCCLIPPING;
	}
	#endif

	return ret;
}


//==================================================================================
// Copies a surface to a new...
//==================================================================================
SDL_Surface *sge_copy_surface(SDL_Surface *src)
{
	return SDL_ConvertSurface(src, src->format,SDL_SWSURFACE);
}



/**********************************************************************************/
/**                            Palette functions                                 **/
/**********************************************************************************/
//==================================================================================
// Fill in a palette entry with R, G, B componenets
//==================================================================================
SDL_Color sge_FillPaletteEntry(Uint8 R, Uint8 G, Uint8 B)
{
   SDL_Color color;

   color.r = R;
   color.g = G;
   color.b = B;

   return color;
}


//==================================================================================
// Get the RGB of a color value (from PowerPak)
//==================================================================================
SDL_Color sge_GetRGB(SDL_Surface *Surface, Uint32 Color)
{
   SDL_PixelFormat *fmt;
   SDL_Color rgb;

   fmt = Surface->format;

   if ( fmt->palette == NULL ) {
      rgb.r = (((Color&fmt->Rmask)>>fmt->Rshift)<<fmt->Rloss);
      rgb.g = (((Color&fmt->Gmask)>>fmt->Gshift)<<fmt->Gloss);
      rgb.b = (((Color&fmt->Bmask)>>fmt->Bshift)<<fmt->Bloss);
   } else {
      rgb.r = fmt->palette->colors[Color].r;
      rgb.g = fmt->palette->colors[Color].g;
      rgb.b = fmt->palette->colors[Color].b;
   }

   return(rgb);
}


//==================================================================================
// Fades from (sR,sG,sB) to (dR,dG,dB), puts result in ctab[start] to ctab[stop]
//==================================================================================
void sge_Fader(SDL_Surface *Surface, Uint8 sR,Uint8 sG,Uint8 sB, Uint8 dR,Uint8 dG,Uint8 dB,Uint32 *ctab,int start, int stop)
{
	// (sR,sG,sB) and (dR,dG,dB) are two points in space (the RGB cube). 	

	/* The vector for the straight line */
	int v[3];
	v[0]=dR-sR; v[1]=dG-sG; v[2]=dB-sB;

	/* Ref. point */
	int x0=sR, y0=sG, z0=sB;

	// The line's equation is:
	// x= x0 + v[0] * t
	// y= y0 + v[1] * t
	// z= z0 + v[2] * t
	//
	// (x,y,z) will travel between the two points when t goes from 0 to 1.

	int i=start;
 	double step=1.0/((stop+1)-start);

	for(double t=0.0; t<=1.0 && i<=stop ; t+=step){
		ctab[i++]=SDL_MapRGB(Surface->format, (Uint8)(x0+v[0]*t), (Uint8)(y0+v[1]*t), (Uint8)(z0+v[2]*t) );
	}			
}


//==================================================================================
// Fades from (sR,sG,sB,sA) to (dR,dG,dB,dA), puts result in ctab[start] to ctab[stop]
//==================================================================================
void sge_AlphaFader(Uint8 sR,Uint8 sG,Uint8 sB,Uint8 sA, Uint8 dR,Uint8 dG,Uint8 dB,Uint8 dA, Uint32 *ctab,int start, int stop)
{
	// (sR,sG,sB,sA) and (dR,dG,dB,dA) are two points in hyperspace (the RGBA hypercube). 	

	/* The vector for the straight line */
	int v[4];
	v[0]=dR-sR; v[1]=dG-sG; v[2]=dB-sB; v[3]=dA-sA;

	/* Ref. point */
	int x0=sR, y0=sG, z0=sB, w0=sA;

	// The line's equation is:
	// x= x0 + v[0] * t
	// y= y0 + v[1] * t
	// z= z0 + v[2] * t
	// w= w0 + v[3] * t
	//
	// (x,y,z,w) will travel between the two points when t goes from 0 to 1.

	int i=start;
 	double step=1.0/((stop+1)-start);

	for(double t=0.0; t<=1.0 && i<=stop ; t+=step)
		ctab[i++]=sge_MapAlpha((Uint8)(x0+v[0]*t), (Uint8)(y0+v[1]*t), (Uint8)(z0+v[2]*t), (Uint8)(w0+v[3]*t));
					
}


//==================================================================================
// Copies a nice rainbow palette to the color table (ctab[start] to ctab[stop]).
// You must also set the intensity of the palette (0-bright 255-dark)
//==================================================================================
void sge_SetupRainbowPalette(SDL_Surface *Surface,Uint32 *ctab,int intensity, int start, int stop)
{
	int slice=(int)((stop-start)/6);

	/* Red-Yellow */
	sge_Fader(Surface, 255,intensity,intensity, 255,255,intensity, ctab, start,slice);
 	/* Yellow-Green */
	sge_Fader(Surface, 255,255,intensity, intensity,255,intensity, ctab, slice+1, 2*slice);
 	/* Green-Turquoise blue */
	sge_Fader(Surface, intensity,255,intensity, intensity,255,255, ctab, 2*slice+1, 3*slice);
 	/* Turquoise blue-Blue */
	sge_Fader(Surface, intensity,255,255, intensity,intensity,255, ctab, 3*slice+1, 4*slice);
 	/* Blue-Purple */
	sge_Fader(Surface, intensity,intensity,255, 255,intensity,255, ctab, 4*slice+1, 5*slice);	
 	/* Purple-Red */
	sge_Fader(Surface, 255,intensity,255, 255,intensity,intensity, ctab, 5*slice+1, stop);	
}


//==================================================================================
// Copies a B&W palette to the color table (ctab[start] to ctab[stop]).
//==================================================================================
void sge_SetupBWPalette(SDL_Surface *Surface,Uint32 *ctab,int start, int stop)
{
	sge_Fader(Surface, 0,0,0, 255,255,255, ctab,start,stop);
}

