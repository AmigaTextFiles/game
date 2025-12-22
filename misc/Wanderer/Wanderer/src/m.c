#include "wand_head.h"

extern char *playscreen();

extern int rscreen();

extern int savescore();

int debug_disp = 0;
int no_passwords = 0;
int maxscreens;
char screen[NOOFROWS][ROWLEN+1];
int edit_mode = 0;
int saved_game = 0;
char *edit_screen;

main(argc,argv)
int  argc;
char *argv[];
{
char (*frow)[ROWLEN+1] = screen;
int num,score,bell = 0,maxmoves,fp,x,y;
char howdead[25],buffer[100],
     *name,*keys,*dead,ch;
char *malloc();

if(argc == 2)
    {
    if(!strcmp(argv[1], "-e"))
	{
	edit_mode = 1;
	edit_screen = NULL;
	}
    else if(!strcmp(argv[1], "-m"))
	{
	initscr();
	erase_scores();
	endwin();
	exit(0);
	}
    else if(!strcmp(argv[1], "-c"))
	{
	/* show credits */
	initscr();
	credits();
	endwin();
	exit(0);
        }
    else if(!strcmp(argv[1], "-s"))
	{
	initscr();
        savescore("-",0,0,"-");
	addstr("press any key");
	getch();
	endwin();
        exit(0);
	}
    else if(!strcmp(argv[1], "-f"))
        {
	debug_disp = 1;
	}
    else
	{
	fprintf(stderr,"Usage: %s [ -e [ file ] | -m | -c | -s | -f ]\n",argv[0]);
	exit(1);
        }
    }
if(argc > 2)
    {
    if(!strcmp(argv[1],"-e"))
	{
	edit_mode = 1;
	edit_screen = argv[2];
	}
    else
	{
        fprintf(stderr,"Usage: %s [ -e [ file ] | -m | -c | -s | -f ]\n",argv[0]);
        exit(1);
	}
    }

/* check for passwords - if file no_pws is in screen dir no pws! */
sprintf(buffer,"%s/no_pws",SCREENPATH);
if((fp = open(buffer,O_RDONLY)) != -1) {
    close(fp);
    no_passwords = 1;
}

/* count available screens */
for(maxscreens = 0;;maxscreens++) {
    sprintf(buffer,"%s/screen.%d",SCREENPATH,(maxscreens+1));
    if((fp = open(buffer, O_RDONLY)) == -1 )
	break;
    close(fp);
}

initscr();

if((name = (char *)getenv("NEWNAME")) == NULL)
    if((name = (char *)getenv("NAME")) == NULL)
        if((name = (char *)getenv("FULLNAME")) == NULL)
            if((name = (char *)getenv("USER")) == NULL)
		if((name = (char *)getenv("LOGNAME")) == NULL)
#ifdef	ASKNAME	/* M001 */
		{
		    name = malloc(80);
		    if (name == NULL) {
			addstr("malloc error\n");
			refresh();
			endwin();
			exit(1);
		    }

		    draw_box(3,10,40,5);
		    move(5,12);
		    setcolor(YELLOW, DK_GREEN);
		    addstr("What is your name? ");
		    refresh();
		    echo(); CBOFF;
		    gets(name);
		    noecho(); CBON;
		    setcolor(TEXT_COLOR, BACK_COLOR);
		    if (name[0] == '\0')
			    name = "noname";
		}
#else
	            name = "noname";
#endif

if((keys = (char *)getenv("NEWKEYS")) == NULL)
    {
    keys = "kjhl";
    }

/* MAIN PROGRAM HERE */

CBON; noecho();

while (1)
{
  num = 1;
  score = 0;
  maxmoves = 0;
  clear();
  if(!edit_mode) {
    for (;;) {
        if (rscreen(num,&maxmoves)) {
	    strcpy(howdead,"a non-existant screen");
	    break;
	    };
        dead = playscreen(&num,&score,&bell,maxmoves,keys);
        if ((dead != NULL) && (*dead == '~')) {
	    num = (int)(dead[1]) - 1;
	    dead = NULL;
	    }
        if (dead != NULL)
	    {
	    strcpy(howdead,dead);
            break;
            }
        num++;
        }

    playSound(DEATH_SOUND);
    clear();
    setcolor(RED, BLACK);
    sprintf(buffer,"%s killed by %s with a score of %d on level %d.\n",name,howdead,score,num);
    addstr(buffer);
    }
  else
    {
    if(rscreen(num,&maxmoves))
	{
	for(x=0;x<ROWLEN;x++)
	    for(y=0;y<NOOFROWS;y++)
		screen[y][x] =  ' ';
	}
    editscreen(num,&score,&bell,maxmoves,keys);
    }
  /* END OF MAIN PROGRAM */

  /* SAVE ROUTINES FOR SCORES */

  if(!edit_mode)
    {
    setcolor(WHITE, BLACK);
    if((savescore(howdead,score,num,name) == 0)&&(score != 0))
        addstr("\nWARNING: score not saved!\n\n");
    }
  setcolor(RED, BLACK);
  addstr("WANDERER (C)1988 S. Shipway.");
#ifdef AMIGA
  addstr("  AMIGA version by Alan Bland.");
#endif

  /* ask if they want to play again - save loading time on floppy-based systems */
  setcolor(LT_GREEN, BLACK);
  addstr("\nDo you want to try again? ");
  refresh();
  while ((ch = getch()) != 'y' && ch != 'n') {}
  if (ch == 'n') break;
}

echo();
CBOFF;
endwin();
exit(0);
}
