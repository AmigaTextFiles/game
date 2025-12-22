#include "wand_head.h"

extern int debug_disp;

/* This function is used to draw a symbol on the map, and when running
 * in full-screen display mode.  Added by Alan Bland for the AMIGA to
 * allow the map characters to use a color graphics font.
 */
void draw_map_symbol(ch)
int ch;
{
#ifdef AMIGA
	int color;
	switch (ch)
	{
	case 'M':	color = BLUE;		break;
	case 'S':	color = ORANGE;		break;
	case ' ':	color = DK_GREEN;	break;
	case '#':	color = DK_GRAY;	break;
	case '<':	color = ORANGE;		break;
	case '>':	color = ORANGE;		break;
	case 'O':	color = DK_GRAY;	break;
	case ':':	color = BROWN;		break;
	case '/':	color = BROWN;		break;
	case '\\':	color = BROWN;		break;
	case '*':	color = WHITE;		break;
	case '=':	color = DK_GRAY;	break;
	case '@':	color = RED;		break;
	case 'T':	color = YELLOW;		break;
	case 'X':	color = RED;		break;
	case '!':	color = BLACK;		break;
	case 'C':	color = LT_GRAY;	break;
	case '+':	color = LT_BLUE;	break;
	case 'A':	color = RED;		break;
	case '^':	color = ORANGE;		break;
	default:	ch='?';color = DK_GRAY;	break;
	}
	set_map_font(1);
	setcolor(color, DK_GREEN);
	addch(ch);
	setcolor(TEXT_COLOR, BACK_COLOR);
	set_map_font(0);
#else
	addch(ch);
#endif
}

/* draw a box at the specified row,column,width,height */
void draw_box(r,c,w,h)
int r,c,w,h;
{
#ifdef AMIGA
	/* white rectangle with dark green interior */
	/* note: coordinates are text coords, must adjust for graphics */
	int x1=c*8+8;
	int y1=r*8+8;
	int x2=x1+(w-2)*8;
	int y2=y1+(h-2)*8;

	SetAPen(R, DK_GREEN);
	RectFill(R, x1, y1, x2, y2);
	SetAPen(R, WHITE);
	Move(R, x1-1, y1-1);
	Draw(R, x1-1, y2+1);
	Draw(R, x2+1, y2+1);
	Draw(R, x2+1, y1-1);
	Draw(R, x1-1, y1-1);

	SetAPen(R, TEXT_COLOR);
#else
	char buf1[80], buf2[80];
	int x,y;
	buf1[0] = '+';
	buf2[0] = '|';
	for (x=1;x<w-1;++x) {
		buf1[x] = '-';
		buf2[x] = ' ';
	}
	buf1[x] = '+';
	buf2[x] = '|';
	buf1[x+1] = '\0';
	buf2[x+1] = '\0';

	move(r,c);
	addstr(buf1);
	for (y=1;y<h-1;++y) {
		move(r+y,c);
		addstr(buf2);
	}
	move(r+h-1,c);
	addstr(buf1);
#endif
}

void map(row_ptr)
char (*row_ptr)[ROWLEN+1];
{
int  x,y;
int  ch;
draw_box(0,0,ROWLEN+2,NOOFROWS+2);
for(y = 0;y < NOOFROWS; y++)
    {
    for(x = 0; x < ROWLEN; x++)
	{
	ch = (*row_ptr)[x];
	if(!debug_disp)
	    {
	    if((ch == 'M')||(ch == 'S'))
		ch = ' ';
	    }
	else
	    {
            if( !(ch==' '||ch=='#'||ch=='<'||ch=='>'||ch=='O'||ch==':'||
	          ch=='/'||ch=='\\'||ch=='*'||ch=='='||ch=='@'||ch=='T'||
	          ch=='X'||ch=='!'||ch=='M'||ch=='S'||ch=='C'||ch=='+'||
                  ch=='A'||ch=='^') )
		ch = '"';
	    }
	/* don't bother drawing spaces - speeds up non-smart curses */
	if (ch != ' ')
	    {
	    move(y+1,x+1);
	    draw_map_symbol(ch);
	    }
	}
    row_ptr++;
    }
if(!debug_disp)
    {
    move(18,0);
    addstr("Press any key to return to the game.");
    refresh();
    (void) getchar();
    for(y=0;y<=(NOOFROWS+2);y++)
        {
        move(y,0);
	addstr("                                            ");
	}
    }
else
    refresh();
}

/* called by scroll() and display() to actually draw the game display */
void rdisplay(cx,cy,row_ptr,score)
char (*row_ptr)[ROWLEN+1];
int  cx,cy,score;
{
    int  x,y = 0,
         x_coord,y_coord;
    char ch;
    while(y<(cy-3))
    {
        y++;
        row_ptr++;
    };
    for(y=(cy-3);y<=(cy+3);y++)
    {
        y_coord = (y+3-cy)*2;
        if ((y<0) || (y>=NOOFROWS))
        {
#ifdef AMIGA
	    /* this makes sure graphics are done right */
	    int i, ax;
	    for (ax=0,i=0; i<11; ax+=3,++i)
		{
		    draw_symbol(ax,y_coord,'#');
		}
#else
            move(y_coord+1,1);
            addstr("#################################");
            move(y_coord+2,1);
            addstr("#################################");
#endif
        }
        else
	{
            for(x=(cx-5);x<=(cx+5);x++)
            {
                x_coord = (x+5-cx)*3;
                if ((x<0) || (x>ROWLEN-1))
                    draw_symbol(x_coord,y_coord,'#');
                else
                {
                    ch = (*row_ptr)[x];
                    draw_symbol(x_coord,y_coord,ch);
                }
            };
	    row_ptr++;
        }                   /*   end if   */
    }                       /* end y loop */
    move(16,0);
    refresh();
}

/* draw the game display, doing intelligent scrolling if possible */
/* actually, all this does is draw the display contents without */
/* erasing the previous contents or redrawing the border */
/* (looks better on machines that don't have intelligent curses) */
/* should be possible to do nifty scrolling routines here at some point */
void scroll(cx,cy,row_ptr,score)
char (*row_ptr)[ROWLEN+1];
int  cx,cy,score;
{
    /* assume border is there, just draw game display contents */
    rdisplay(cx,cy,row_ptr,score);
}

/* draw the game display, erasing the current contents first */
void display(cx,cy,row_ptr,score)
char (*row_ptr)[ROWLEN+1];
int  cx,cy,score;
{
    /* draw the border and erase current contents of display region */
    draw_box(0,0,35,16);
    /* now do the actual display */
    rdisplay(cx,cy,row_ptr,score);
}

void redraw_screen(maxmoves,num,score,nf,diamonds,mx,sx,sy,frow)
int maxmoves,num,score,nf,diamonds,mx,sx,sy;
char **frow;
{
char buffer[50];
clear();
move(0,48);
(void) addstr("Score\t   Diamonds");
move(1,48);
(void) addstr("\tFound\tTotal");
move(3,48);
(void) sprintf(buffer,"%d\t %d\t %d  ",score,nf,diamonds);
(void) addstr(buffer);
move(6,48);
(void) sprintf(buffer,"Current screen %d",num);
(void) addstr(buffer);
if(maxmoves != 0)
(void) sprintf(buffer,"Moves remaining = %d   ",maxmoves);
else
{
    (void) strcpy(buffer,"     Unlimited moves     ");
    maxmoves = -1;
};
move(15,48);
(void) addstr(buffer);
show_monster(mx != -1);           /* tell player if monster exists */

if(!debug_disp)
    display(sx,sy,frow,score);
else
    map(frow);
}
