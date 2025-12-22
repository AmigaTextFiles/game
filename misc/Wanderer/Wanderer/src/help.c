/* From jason@uucp.aeras */

#include "wand_head.h"

/* this help text structure allows graphic icons to be displayed along
 * with the help text.  if your machine doesn't do graphics, it still
 * works ok with the text representation.
 */
struct {
	char *text;	/* text for this line */
	short col;	/* column position for graphic icon, -1 for none */
	short offrow;	/* row offset, fakes multiple icons per row */
	char icon;	/* icon character to display */
} help[]={
"      **  W A N D E R E R  **      ", -1,0,0,	/* 0 */
"    ===========================    ", -1,0,0,	/* 1 */
"        by Steven Shipway          ", -1,0,0,	/* 2 */
"How to play:                       ", -1,0,0,	/* 3 */
" Collect all the treasure:         ", 30,0,'*',/* 4 */
"                                   ", -1,0,0,	/* 5 */
" Then go through the exit:         ", 30,0,'X',/* 6 */
"                                   ", -1,0,0,	/* 7 */
#ifdef AMIGA
"  Use mouse, cursor keys or        ", -1,0,0,	/* 8 */
"  h,j,k,l keys move around.        ", -1,0,0,	/* 9 */
"                  ESC Quit game    ", -1,0,0,	/* 10 */
"                  F10 Look at map  ", -1,0,0,	/* 11 */
"    F6 Save game   F7 Restore Game ", -1,0,0,	/* 12 */
"  HELP Help mode   F3 Center screen", -1,0,0,	/* 13 */
"    F1 Jump level  F2 Switch mode  ", -1,0,0,	/* 14 */
#else
"  h  Left       j  Down            ", -1,0,0,	/* 8 */
"  k  Up         l  Right           ", -1,0,0,	/* 9 */
"  1  Loud       q  Quit game       ", -1,0,0,	/* 10 */
"  0  Quiet      !  Look at map     ", -1,0,0,	/* 11 */
"  S  Save game  R  Restore Game    ", -1,0,0,	/* 12 */
"  ?  Help mode  @  Center screen   ", -1,0,0,	/* 13 */
"  ~  Jump level #  Switch mode     ", -1,0,0,	/* 14 */
#endif
" nb: No level bonus for jumping.   ", -1,0,0,	/* 15 */

#ifdef AMIGA
"This is you:                       ", -1,0,0,	/* 0 */
"                                   ", 5,0,'@',	/* 1 */
"                                   ", -1,0,0,	/* 2 */
#else
"This is you:  You are a spider.    ", -1,0,0,	/* 0 */
"              (At least, that's    ", 5,0,'@',	/* 1 */
"              what you look like)  ", -1,0,0,	/* 2 */
#endif
"                                   ", -1,0,0,	/* 3 */
"The other items you will find are: ", -1,0,0,	/* 4 */
"                                   ", -1,0,0,	/* 5 */
"                                   ", 1,0,'#',	/* 6 */
"      and        Solid rock        ", 10,-1,'=',/* 7 */
"                                   ", -1,0,0,	/* 8 */
"        Time capsule (5 points,    ", 2,0,'C',	/* 9 */
"        +250 extra moves)          ", -1,0,0,	/* 10 */
"                                   ", -1,0,0,	/* 11 */
"        Passable earth (one point) ", 2,0,':',	/* 12 */
"                                   ", -1,0,0,	/* 13 */
"       Teleport  (50 points for    ", 1,0,'T',	/* 14 */
"                  using it)        ", -1,0,0,	/* 15 */

"        Boulder (falls down, other ", 2,0,'O',	/* 0 */
"        boulders and arrows fall   ", -1,0,0,	/* 1 */
"        off of it)                 ", -1,0,0,	/* 2 */
"                                   ", -1,0,0,	/* 3 */
"               Arrows              ", 1,0,'<',	/* 4 */
"      and      (run left and right)", 10,-1,'>',/* 5 */
"                                   ", -1,0,0,	/* 6 */
"        Cage - holds baby monsters ", 2,0,'=',	/* 7 */
"        and changes into diamonds  ", -1,0,0,	/* 8 */
"                                   ", -1,0,0,	/* 9 */
"         (10 points)               ", 2,0,'*',	/* 10 */
"         Money  (collect it)       ", -1,0,0,	/* 11 */
"                                   ", -1,0,0,	/* 12 */
"       Baby monster (kills you)    ", 2,0,'S',	/* 13 */
"                                   ", -1,0,0,	/* 14 */
"                                   ", -1,0,0,	/* 15 */

"When a baby monster hits a cage it ", -1,0,0,	/* 0 */
"is captured and you get 50 points. ", -1,0,0,	/* 1 */
"The cage also becomes a diamond.   ", -1,0,0,	/* 2 */
"                                   ", -1,0,0,	/* 3 */
"      Instant annihilation         ", 1,0,'!',	/* 4 */
"                                   ", -1,0,0,	/* 5 */
"                                   ", -1,0,0,	/* 6 */
"               Slopes (boulders    ", 1,0,'\\',/* 7 */
"     and       and etc slide off)  ", 9,-1,'/',/* 8 */
"                                   ", -1,0,0,	/* 9 */
"      Monster  (eats you up whole. ", 1,0,'M',	/* 10 */
"      Yum Yum yum..) (100 points)  ", -1,0,0,	/* 11 */
"      (kill with a rock or arrow)  ", -1,0,0,	/* 12 */
"                                   ", -1,0,0,	/* 13 */
"      Exit -- Must Collect all the ", 1,0,'X',	/* 14 */
"      treasure first. (250 bonus)  ", -1,0,0,	/* 15 */

"      A new addition for version   ", 1,0,'^',	/* 0 */
"      2.2M . The balloon rises,    ", -1,0,0,	/* 1 */
"      and is popped by arrows. It  ", -1,0,0,	/* 2 */
"      does *not* kill you.         ", -1,0,0,	/* 3 */
"                                   ", -1,0,0,	/* 4 */
"      Unrecognised symbol in map.  ", 1,0,'-',	/* 5 */
"      This is probably a **bug** ! ", -1,0,0,	/* 6 */
"                                   ", -1,0,0,	/* 7 */
" ENVIRONMENT VARIABLES:            ", -1,0,0,	/* 8 */
"                                   ", -1,0,0,	/* 9 */
"   NEWNAME,NAME : Checked in that  ", -1,0,0,	/* 10 */
"       order for the hiscore table ", -1,0,0,	/* 11 */
"   NEWKEYS : Redefine movement keys", -1,0,0,	/* 12 */
"       eg- 'hlkj' for default      ", -1,0,0,	/* 13 */
"   SAVENAME : File used for saved  ", -1,0,0,	/* 14 */
"       games.                      ", -1,0,0	/* 15 */
};



void
helpme()	/* routine to show help menu. */
{
	int i = 0, i1 = 0, i2 = 0;  /* loop counters */
	char ch;

	draw_box(0,0,43,19);
	for(i1 = 0; i1 < 5; i1++)  /* times to show loop. */
	{
		setcolor(WHITE, DK_GREEN);
		for(i = 0; i < 16; i++)	/* show one menu. */
		{
			move(i+1,1);  /* move to start of line. */
			addstr(help[i2+i].text);
		}
		/* now go back and draw any icon images */
		for(i = 0; i < 16; i++)	/* show one menu. */
		{
			if (help[i2+i].col >= 0)
			{
			    /* draw the beastie */
			    draw_symbol(help[i2+i].col+1,i+help[i2+i].offrow,help[i2+i].icon);
			}
		}

		i2 += 16;

		move(i+1,1);  /* move to start of line. */
		setcolor(YELLOW, DK_GREEN);
		addstr("<return> to continue, <space> to exit");
		refresh();	/* show on screen. */
		ch = (char) getchar();	/* just for now, get anything. */
		if(ch == ' ') /* if return or what ever.. */
			break;  /* exit routine now. */
	}
	setcolor(TEXT_COLOR, BACK_COLOR);
	for (i=0; i<19; i++)
	{
		move(i,0);  /* move to start of line. */
		addstr("                                              ");
	}
}

credits()
{
	char buffer[512];
	FILE *fp;
	int i;
	clear();
	sprintf(buffer,"%s/credits",SCREENPATH);
	if((fp = fopen(buffer,"r")) == NULL) {
            addstr(" Sorry - credits unavailable!\n");
	    }
	else {
	    i = 0;
	    while(fgets(buffer,512,fp) != NULL) {
	        addstr(buffer);
		if (++i == LINES-2) {
		    addstr("Press any key.");
		    refresh();
		    getch();
		    i = 0;
		    clear();
		}
	    }
	}
	addstr("Press any key.");
	refresh();
	getch();
}
