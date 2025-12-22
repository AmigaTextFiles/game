#include "wand_head.h"

extern char *playscreen();

extern int debug_disp;
extern char *edit_screen;
extern char screen[NOOFROWS][ROWLEN+1];

static char *inst[] = { "O   Boulder",
			"< > Arrows",
			"^   Balloon",
			":   Earth",
			"!   Landmine",
			"*   Treasure",
			"/ \\ Deflectors",
			"+   Cage",
			"= # Rock",
			"T   Teleport",
			"A   Arrival (1 max)",
			"X   Exit (always 1)",
			"@   Start (always 1)",
			"M   Big Monster (1 max)",
			"S   Baby Monster",
			"-   Alternative space",
			"C   Time Capsule",
			NULL };
/* Print instructions around the screen */
void instruct()
{
int loop;
for(loop = 0; inst[loop] ; loop++)
    {
    move(loop+1,55);
    addstr(inst[loop]);
    }
move(20,0);
addstr("Use wanderer keys to move. m = change no. of moves, p = play game\n");
addstr("n = play game with full screen, q = quit, x = quit without save.");
}

void noins()
{
int loop;
for(loop =0; inst[loop] ; loop++)
    {
    move(loop+1,55);
    addstr("                       ");
    }
move(20,0);
addstr("                                                                            \n");
addstr("                                                                            ");
}

/* Actual edit function */

void editscreen(num,score,bell,maxmoves,keys)
int  num, maxmoves,
     *bell,
     *score;
char keys[10];
{
int  x,y,sx=0,sy=0,quit=0,nx,ny,nosave =0;
char (*frow)[ROWLEN+1] = screen,
     ch;
char buffer[50];
char *howdead;

for(x=0;x<=ROWLEN;x++)
    for(y=0;y<NOOFROWS;y++)
	{
        if(screen[y][x] == '@')
	    {
	    sx = x;
	    sy = y;
	    }
        if(screen[y][x] == '-')
        	screen[y][x] = ' ';
        };
x=sx;
y=sy;
if(maxmoves != 0)
(void) sprintf(buffer,"Moves remaining = %d   ",maxmoves);
else
(void) strcpy(buffer,"     Unlimited moves     ");
debug_disp=1;
map(frow);
move(18,0);
addstr(buffer);

/* ACTUAL EDIT FUNCTION */

instruct();
while(!quit)
{
move(y+1,x+1);
refresh();
cursor(1);
ch = (char)getchar();
cursor(0);

nx=x;
ny=y;

if(ch == keys[3]||ch == keys[2]||ch == keys[1]||ch == keys[0])
    {
    if(ch == keys[3])
	    nx++;
    if(ch == keys[2])
	    nx--;
    if(ch == keys[1])
	    ny++;
    if(ch == keys[0])
            ny--;
    }
else if(ch == 'q')
    {
    noins();
    break;
    }
else if(ch == 'x')
    {
    noins();
    move(20,0);
    addstr("You will lose any changes made this session - are you sure? (y/n)");
    refresh();
    ch = getch();
    if(ch != 'y')
	{
	noins();
	instruct();
	refresh();
    	}
    else
	{
	nosave = 1;
	addstr("\n");
	refresh();
	break;
    	}
    }
else if(ch == 'm')              /* change to number of moves for the screen */
    {
    move(19,0);
    addstr("How many moves for this screen? :");
    refresh();echo();
    gets(buffer);
    noecho();
    maxmoves = atoi(buffer);
    if(maxmoves < 0 ) maxmoves = 0;
    move(19,0);
    addstr("                                           ");
    if(maxmoves != 0)
        (void) sprintf(buffer,"Moves remaining = %d   ",maxmoves);
    else
        (void) strcpy(buffer,"     Unlimited moves     ");
    move(18,0);
    addstr(buffer);
    refresh();            /* for some reason, this seems to add a '.' to */
			  /* the map... Ive no idea why yet... */
    }
else if(ch == 'p' || ch == 'n')       /* play the game (test) */
    {
	noins();
        wscreen(num,maxmoves);
	if(ch == 'p')
	    {
	    debug_disp = 0;
	    clear();
	    }
	*score = 0;
	howdead = playscreen(&num,score,bell,maxmoves,keys);
	move(20,0);
	if(howdead!=0)
	    addstr(howdead);
	else
	    addstr("DONE!");
	printw("; hit any key to continue\n");
	refresh();
	ch = (char)getchar();
	clear();
	rscreen(num,&maxmoves);
	debug_disp = 1;
	map(frow);
	instruct();
    }
else
    {
    if(ch >= 'a' && ch <= 'z') ch = ch - 'a' + 'A';
    if(ch < ' ' || ch == (char)127) ch = '.';  /* no ctrl codes, thankyou */
    if(ch == '"') ch = (char)getchar();
    screen[y][x] = ch;
    move(y+1,x+1);
    draw_map_symbol(ch);
    nx++;
    }
if(nx < 0)
    {
    nx = ROWLEN-1;
    ny--;
    }
if(nx >= ROWLEN)
    {
    nx = 0;
    ny++;
    }
if(ny < 0) ny = NOOFROWS-1;
if(ny >= NOOFROWS) ny = 0;
move(ny+1,nx+1);
x=nx;
y=ny;
}

if(! nosave)
    {
    for(y = 0; y<=NOOFROWS;y++) /* certain editors - eg ded - have a */
                                /* habit of truncating trailing spaces*/
            	    		/* so this should stop them! */
        if(screen[y][ROWLEN-1] == ' ')
	    screen[y][ROWLEN-1] = '-';
    wscreen(num,maxmoves);
    }
noins();
move(20,0);
refresh();
}

