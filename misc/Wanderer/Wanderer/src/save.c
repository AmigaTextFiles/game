#include "wand_head.h"
#include <errno.h>

extern char screen[NOOFROWS][ROWLEN+1];
extern int saved_game;

extern void crypt_file();
struct	saved_game	{
	short	num;
	short	score;
	short	bell;
	short	maxmoves;
	short	num_monsters;
};

struct	save_vars	zz;

/* save game and exit - if trouble occurs, return to game */
void
save_game(num, score, bell, maxmoves, start_of_list, tail_of_list)
int	num, *score, *bell, maxmoves;
struct	mon_rec	*start_of_list, *tail_of_list;
{
	char	fname[128], *fp, buffer[40];
	FILE	*fo;
	struct	saved_game	s;
	extern	char	*getenv();
	struct	mon_rec	*mp;

	clear();

	if ((char *)NULL == (fp = getenv("SAVENAME"))) {
		addstr("Saving game.... Filename ? ");
		refresh();
		fp = fname;
		echo(); CBOFF;
		gets(fp);
		CBON; noecho();
	}
	if ((FILE *)NULL == (fo = fopen(fp, W_BIN))) {
		addstr("\nUnable to save game, press any key.");
		refresh();
		getch();
		return;
	}

	s.num = num;
	s.score = *score;
	s.bell = *bell;
	s.maxmoves = maxmoves;
	s.num_monsters = 0;

	mp = start_of_list;		/* first entry is dummy	*/
	while (mp != tail_of_list) {
		mp = mp->next;
		s.num_monsters++;	/* count them monsters	*/
	}

	if ( (1 != fwrite((char *)&s, sizeof(s), 1, fo)) ||
	     (1 != fwrite((char *)screen, sizeof(screen), 1, fo)) ||
	     (1 != fwrite((char *)&zz, sizeof(zz), 1, fo)) )
	{
		goto file_error;
	}

	mp = start_of_list;
	while (mp != tail_of_list) {
		/* save them monsters	*/
		mp = mp->next;
		if (1 != fwrite((char *)mp, sizeof(struct mon_rec), 1, fo)) {
file_error:
			sprintf(buffer, "Write error on '%s', press any key.", fname);
			addstr(buffer);
			refresh();
			fclose(fo);
			unlink(fname);
			getch();
			return;
		}
	}

	fclose(fo);
#ifndef NO_ENCRYPTION
	crypt_file(fp,0);   /* encrpyt the saved game */
#endif
	echo();
	CBOFF;
	endwin();
	exit(0);
}

void
restore_game(num, score, bell, maxmoves, start_of_list, tail_of_list)
int	*num, *score, *bell, *maxmoves;
struct	mon_rec	*start_of_list, **tail_of_list;
{
	FILE	*fi;
	struct	saved_game	s;
	struct	mon_rec	*mp, *tmp, tmp_monst;
	char	fname[128], *fp, buffer[80];
	FILE	*fo;
	extern	char	*getenv();

	if ((char *)NULL == (fp = getenv("SAVENAME"))) {
		move((LINES-1),0);
		addstr("Restore Filename ? ");
		refresh();
		echo(); CBOFF;
		fp = fname;
		gets(fp);
		CBON; noecho();
	}
	clear();
	refresh();
#ifndef NO_ENCRYPTION
 	crypt_file(fp,1);   /*decrypt it*/
#endif
	if ((FILE *)NULL == (fi = fopen(fp, R_BIN))) {
		sprintf(buffer, "Open error on '%s'\n", fp);
		addstr(buffer);
		goto cant_restore;
	}
	if ( (1 != fread((char *)&s, sizeof(s), 1, fi)) ||
	     (1 != fread((char *)screen, sizeof(screen), 1, fi)) ||
	     (1 != fread((char *)&zz, sizeof(zz), 1, fi)) ) {
		sprintf(buffer, "Read error on '%s'\n", fp);
		addstr(buffer);
		fclose(fi);
		goto cant_restore;
	}

	*num = s.num;
	*score = s.score;
	*bell = s.bell;
	*maxmoves = s.maxmoves;

	/* free any monsters already on chain, to start clean */
	mp = start_of_list->next;
	while ((mp != NULL) && (mp != start_of_list)) {
		/* free them monsters	*/
		tmp = mp;
		mp = mp->next;
		free(tmp);
	}

	/* re-initialize the monster list	*/
	/* *start_of_list = {0,0,0,0,0,NULL,NULL}; */
	start_of_list->x = 0;
	start_of_list->y = 0;
	start_of_list->mx = 0;
	start_of_list->my = 0;
	start_of_list->under = 0;
	start_of_list->next = (struct mon_rec *)NULL;
	start_of_list->prev = (struct mon_rec *)NULL;

	*tail_of_list = start_of_list;

	while (s.num_monsters--) {
		/* use make_monster to allocate the monster structures	*/
		/* to get all the linking right without even trying	*/
		if ((struct mon_rec *)NULL == (mp = make_monster(0, 0))) {
			sprintf(buffer,"Monster alloc error on '%s'\n", fp);
			addstr(buffer);
                        addstr("Try again - it might work.\nBut then,pigs might fly...\n");
			fclose(fi);
			goto cant_restore;
		}
		if (1 != fread((char *)&tmp_monst, sizeof(struct mon_rec), 1, fi)) {
			sprintf(buffer,"Monster read error on '%s'\n", fp);
			addstr(buffer);
			fclose(fi);
cant_restore:
			addstr("Cannot restore game --- sorry.\n");
			addstr("Press any key...");
			refresh();
			getch();
			endwin();
			exit(1);
		}
		/* copy info without trashing links	*/
		mp->x     = tmp_monst.x;
		mp->y     = tmp_monst.y;
		mp->mx    = tmp_monst.mx;
		mp->my    = tmp_monst.my;
		mp->under = tmp_monst.under;
	}

	fclose(fi);
	unlink(fp);
	saved_game = 1;
}
