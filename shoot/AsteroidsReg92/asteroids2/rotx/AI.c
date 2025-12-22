#include <exec/types.h>
#include "h/rot.h"

/*
#define MWDEBUG 1
#include "sc:extras/memlib/memwatch.h"
*/

extern struct gameinfo gi;

LONG __asm determineaim(register __d0 LONG dx,
				  	    register __d1 LONG dy,
				  	    register __a0 LONG dxdy,
				  	    register __a1 LONG dydx);

LONG detcomplexheading(n,tarx,tary,x,y,pos)
LONG n,tarx,tary,x,y,pos;
{
SHORT dx,dy,dxdy,dydx,aim,s;


if (tarx-x != 0)
    {
	s = sign(tarx-x);

	if (abs(tarx - x) < abs(s*gi.dx-tarx+x)) dx = tarx - x;
	else								 dx = -s*abs(s*gi.dx-tarx+x);
    }

if (tary-y != 0)
    {
	s = sign(tary-y);

	if (abs(tary - y) < abs(s*gi.dy-tary+y)) dy = tary - y;
	else								 dy = -s*abs(s*gi.dy-tary+y);
    }

if (dx==0) dx=1;
if (dy==0) dy=1;

dxdy = abs((dx*10)/dy);
dydx = abs((dy*10)/dx);

aim = determineaim(dx,dy,dxdy,dydx);		/* assembly routine */

if (aim == pos) return(0);
else
if ( abs(aim-pos) < abs(aim+31-pos) )   
	return(aim-pos);
else
	return(aim+31-pos);
}


LONG determineheading(tarx,tary,x,y,pos)
LONG tarx,tary,x,y,pos;
{
SHORT dx,dy,dxdy,dydx,aim;

dx = tarx - x;
dy = tary - y;

if (dx == 0) dx = 1;
if (dy == 0) dy = 1;

dxdy = abs((dx*10)/dy);
dydx = abs((dy*10)/dx);

aim = determineaim(dx,dy,dxdy,dydx);		/* assembly routine */

if (aim == pos) return(0);
else
if ( abs(aim-pos) < abs(aim+31-pos) )   
	return(aim-pos);
else
	return(aim+31-pos);
}
