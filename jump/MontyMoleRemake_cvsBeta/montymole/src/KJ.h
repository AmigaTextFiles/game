/**********************************************************************************

	TITLE		:	KJ
	AUTHOR	:	Kevan Thurstans
	VERSION	:	0.1
	CREATED	:	05/05/01
						KJ headers, object sizes etc

	UPDATES	:	11/10/01	-	changed structure names to more consistant names.


************************************************************************************/

#ifndef	__KJ_H

#define	__KJ_H


#include <SDL/SDL.h>

#define		__USE_KJTEXT		0x01


typedef struct
{
	Uint16		x,
						y;
} KJPos;


typedef struct	
{
	Uint16		w,		// width & height of object
						h;
} KJSize;


typedef struct
{
	Uint16	x,			// position x,y
					y;
} KJPoint;


typedef struct		// define two points (x1,y1)-(x2,y2)
{
	Sint16	x1,y1,
					x2,y2;
} KJLine;

#endif
