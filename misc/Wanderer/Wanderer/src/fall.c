#include "wand_head.h"

extern void draw_symbol();
extern int debug_disp;
extern char screen[NOOFROWS][ROWLEN+1];

int check(mx,my,x,y,dx,dy,sx,sy,howdead)
/* check for any falling caused by something moving out of x,y along
   vector dx,dy. All the others are constant and should really have
   been global... 						    */
int x,y,sx,sy,dx,dy, *mx, *my;
char howdead[25];
{
int ret=0;
ret+=fall(mx,my,x,y,sx,sy,howdead);
ret+=fall(mx,my,x-dx,y-dy,sx,sy,howdead);
ret+=fall(mx,my,x-dy,y-dx,sx,sy,howdead);
ret+=fall(mx,my,x+dy,y+dx,sx,sy,howdead);
ret+=fall(mx,my,x-dx-dy,y-dy-dx,sx,sy,howdead);
ret+=fall(mx,my,x-dx+dy,y-dy+dx,sx,sy,howdead);
return ret;
}

int fall(mx,my,x,y,sx,sy,howdead)  /* recursive function for falling */
				   /* boulders and arrows */
int  x,y,sx,sy, *mx, *my;
char howdead[25];
{
int nx = x,nxu = x,nyl = y,nyr = y,retval = 0, makesound = 0;
if ((y>(NOOFROWS-1))||(y<0)||(x<0)||(x>(ROWLEN-1)))
    return(0);
if((screen[y][x] != 'O') && (screen[y][x] != ' ') && (screen[y][x] != 'M') &&
   (screen[y][x] !='\\') && (screen[y][x] != '/') && (screen[y][x] != '@') &&
   (screen[y][x] != '^'))
    return(0);
if(screen[y][x] == 'O')
    {
    if((screen[y][x-1] == ' ') && (screen[y-1][x-1] == ' '))
        nx--;
    else
	{
        if((screen[y][x+1] == ' ') && (screen[y-1][x+1] == ' '))
            nx++;
	else
	    nx = -1;
	}
    if((screen[y][x-1] == ' ') && (screen[y+1][x-1] == ' '))
        nxu--;
    else
	{
        if((screen[y][x+1] == ' ') && (screen[y+1][x+1] == ' '))
            nxu++;
	else
	    nxu = -1;
	}
    if((screen[y-1][x] == ' ') && (screen[y-1][x+1] == ' '))
        nyr--;
    else
	{
        if((screen[y+1][x] == ' ') && (screen[y+1][x+1] == ' '))
            nyr++;
	else
	    nyr = -1;
	}
    if((screen[y-1][x] == ' ') && (screen[y-1][x-1] == ' '))
        nyl--;
    else
	{
        if((screen[y+1][x] == ' ') && (screen[y+1][x-1] == ' '))
            nyl++;
	else
	    nyl = -1;
	}
    }
if(screen[y][x] == '\\')
    {
    if(screen[y-1][++nx] != ' ')
	nx = -1;
    if(screen[y+1][--nxu] != ' ')
        nxu = -1;
    if(screen[--nyr][x+1] != ' ')
        nyr = -1;
    if(screen[++nyl][x-1] != ' ')
        nyl = -1;
    }
if(screen[y][x] == '/')
    {
    if(screen[y-1][--nx] != ' ')
	nx = -1;
    if(screen[y+1][++nxu] != ' ')
        nxu = -1;
    if(screen[++nyr][x+1] != ' ')
	nyr = -1;
    if(screen[--nyl][x-1] != ' ')
	nyl = -1;
    }
if((screen[y][nx] != ' ') && (screen[y][nx] != 'M'))
    nx = -1;
if((screen[y-1][x] == 'O') && (nx >= 0) && (y > 0) &&
   (screen[y][nx] != '^')) /* boulder falls ? */
    {
    screen[y-1][x] = ' ';
    if(screen[y][nx] == '@')
        {
	makesound = 1;
    	strcpy(howdead,"a falling boulder");
    	retval=1;
    	}
    if(screen[y][nx] == 'M')
        {
	makesound = 1;
    	*mx = *my = -2;
	screen[y][nx] = ' ';
    	}
    screen[y][nx] = 'O';
    if(!debug_disp)
	{
        if((y<(sy+5)) && (y>(sy-3)) && (x>(sx-6)) && (x<(sx+6)))
            draw_symbol((x-sx+5)*3,(y-sy+2)*2,' ');
        if((y<(sy+4)) && (y>(sy-4)) && (nx>(sx-6)) && (nx<(sx+6)))
            draw_symbol((nx-sx+5)*3,(y-sy+3)*2,'O');
	}
    else
	{
	move(y,x+1);
	draw_map_symbol(' ');
	move(y+1,nx+1);
	draw_map_symbol('O');
    }
    refresh();

#ifdef BOULDER_SOUND
    {
	int w,e,s,sw,se;

	/* try to predict if boulder has stopped falling */
	/* so we know when to trigger the sound */
	w = screen[y][nx-1];
	e = screen[y][nx+1];
	s = screen[y+1][nx];
	sw = screen[y+1][nx-1];
	se = screen[y+1][nx+1];

	if (s != ' ' && s != '/' && s != '\\' && s != 'O')
		makesound = 1;
	else if (s == 'O')
	     {
		if (w != ' ' && e != ' ')
			makesound = 1;
		else if (w != ' ' && e == ' ' && se != ' ')
			makesound = 1;
		else if (w == ' ' && e != ' ' && sw != ' ')
			makesound = 1;
		else if (w == ' ' && sw != ' ' && e == ' ' && se != ' ')
			makesound = 1;
	     }
	else if (s == '/' && sw != ' ')
		makesound = 1;
	else if (s == '\\' && se != ' ')
		makesound = 1;

	if (makesound) playSound(BOULDER_SOUND);
    }
#endif

    retval+=fall(mx,my,nx ,y+1,sx,sy,howdead);
    retval+=check(mx,my,x,y-1,0,1,sx,sy,howdead);
    if(screen[y+1][nx] == '@')
        {
	if (!makesound) playSound(BOULDER_SOUND);
    	strcpy(howdead,"a falling boulder");
    	return(1);
    	}
    if(screen[y+1][nx] == 'M')
        {
	if (!makesound) playSound(BOULDER_SOUND);
    	*mx = *my = -2;
	screen[y+1][nx] = ' ';
    	}
    }
if((screen[nyr][x] != '^')&&(screen[nyr][x] != ' ')&&(screen[nyr][x] != 'M'))
    nyr = -1;
if((screen[y][x+1] == '<')&&(nyr>=0)&&(x+1<ROWLEN)) /* arrow moves ( < ) ? */
    {
    screen[y][x+1] = ' ';
    if(screen[nyr][x] == '@')
        {
	playSound(ARROW_SOUND);
    	strcpy(howdead,"a speeding arrow");
    	retval = 1;
    	}
    if(screen[nyr][x] == 'M')
        {
	playSound(ARROW_SOUND);
    	*mx = *my = -2;
	screen[nyr][x] = ' ';
    	}
    screen[nyr][x] = '<';
    if(!debug_disp)
	{
        if((y<(sy+4)) && (y>(sy-4)) && (x<(sx+5)) && (x>(sx-7)))
            draw_symbol((x-sx+6)*3,(y-sy+3)*2,' ');
        if((nyr<(sy+4)) && (nyr>(sy-4)) && (x<(sx+6)) && (x>(sx-6)))
            draw_symbol((x-sx+5)*3,(nyr-sy+3)*2,'<');
	}
    else
	{
	move(y+1,x+2);
	draw_map_symbol(' ');
	move(nyr+1,x+1);
	draw_map_symbol('<');
	}
    refresh();
    retval+=fall(mx,my,x-1,nyr,sx,sy,howdead);
    retval+=check(mx,my,x+1,y,-1,0,sx,sy,howdead);
    if(screen[nyr][x-1] == '@')
        {
	playSound(ARROW_SOUND);
    	strcpy(howdead,"a speeding arrow");
    	return(1);
    	}
    if(screen[nyr][x-1] == 'M')
        {
	playSound(ARROW_SOUND);
    	*mx = *my = -2;
	screen[nyr][x-1] = ' ';
    	}
    }
if((screen[nyl][x] != ' ')&&(screen[nyl][x] != '^')&&(screen[nyl][x] != 'M'))
    nyl = -1;
if((screen[y][x-1] == '>')&&(nyl>=0)&&(x>0))       /* arrow moves ( > ) ? */
    {
    screen[y][x-1] = ' ';
    if(screen[nyl][x] == '@')
        {
	playSound(ARROW_SOUND);
    	strcpy(howdead,"a speeding arrow");
    	retval = 1;
    	}
    if(screen[nyl][x] == 'M')
        {
	playSound(ARROW_SOUND);
    	*mx = *my = -2;
	screen[nyl][x] = ' ';
    	}
    screen[nyl][x] = '>';
    if(!debug_disp)
	{
        if((y<(sy+4)) && (y>(sy-4)) && (x<(sx+7)) && (x>(sx-5)))
            draw_symbol((x-sx+4)*3,(y-sy+3)*2,' ');
        if((nyl<(sy+4)) && (nyl>(sy-4)) && (x<(sx+6)) && (x>(sx-6)))
            draw_symbol((x-sx+5)*3,(nyl-sy+3)*2,'>');
	}
    else
	{
	move(y+1,x);
	draw_map_symbol(' ');
	move(nyl+1,x+1);
	draw_map_symbol('>');
	}
    refresh();
    retval+=fall(mx,my,x+1,nyl,sx,sy,howdead);
    retval+=check(mx,my,x-1,y,1,0,sx,sy,howdead);
    if(screen[nyl][x+1] == '@')
        {
	playSound(ARROW_SOUND);
    	strcpy(howdead,"a speeding arrow");
    	return(1);
    	}
    if(screen[nyl][x+1] == 'M')
        {
	playSound(ARROW_SOUND);
    	*mx = *my = -2;
	screen[nyl][x+1] = ' ';
    	}
    }
if(screen[y][nxu] != ' ')
    nxu = -1;
if((screen[y+1][x] == '^') && (nxu >= 0) && (y < NOOFROWS) &&
   (screen[y][x] != '^')) /* balloon rises? */
    {
    screen[y+1][x] = ' ';
    screen[y][nxu] = '^';
    if(!debug_disp)
	{
        if((y<(sy+3)) && (y>(sy-5)) && (x>(sx-6)) && (x<(sx+6)))
            draw_symbol((x-sx+5)*3,(y-sy+4)*2,' ');
        if((y<(sy+4)) && (y>(sy-4)) && (nxu>(sx-6)) && (nxu<(sx+6)))
            draw_symbol((nxu-sx+5)*3,(y-sy+3)*2,'^');
	}
    else
	{
	move(y+2,x+1);
	draw_map_symbol(' ');
	move(y+1,nxu+1);
	draw_map_symbol('^');
    }
    refresh();
    retval+=fall(mx,my,nxu ,y-1,sx,sy,howdead);
    retval+=check(mx,my,x,y+1,0,-1,sx,sy,howdead);
    }
if(retval>0)
    return(1);
return(0);
}
