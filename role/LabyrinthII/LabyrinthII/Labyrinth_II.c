
/* Linking instructions for Aztec C:
 * ln labyrinth_ii.o mod2.o messages.o ps.o ss.o readfile.o input.o console.o
 *    talk.o c.lib */

#define MODE_OLDFILE 1005L	/* System define, easier than using the whole
							 * include file */
#define BOYS 24		/* Number of boys in game */
#define GIRLS 24	/* (sex distinction so program can print right pronoun) */
#define STUDENTS BOYS+GIRLS
#define MEN 18
#define WOMEN 4
#define TEACHERS MEN+WOMEN
#define PLAYERS STUDENTS+TEACHERS
#define OBJECTS 44
#define VERBS 38
#define FAWEAPON 7	/* First offensive weapon */
#define FDWEAPON 2	/* First defensive weapon */
#define FTREASURE 31	/* First valuable object */
#define AWEAPONS 24	/* Number of offensive weapons */
#define DWEAPONS 5	/* Number of defensive weapons */
#define TREASURES 14	/* Number of valuable objects */
#define ROOMS 217
#define NAMELEN 30L		/* Max length of user-defined name */
#define INLEN 60L		/* Max length of input */
#define DESCLEN 40000L 	/* Amount of memory space for location descriptions */
#define NOWHERE -9999	/* If something is NOWHERE, it no longer exists */
#define MAXCARR 10		/* Maximum number of objects that can be carried */
#define DROPZONE 75		/* Where treasures must be dropped to score points */

long OpenLibrary (),Open (),Read (),RangeRand (),start (),checkinput (),input ();
int lockable (),walk (),numobj ();
char *AllocMem ();

#define rnd(x) RangeRand((long)x)
#define MAX(a,b) ((a)>(b)?(a):(b))
#define MIN(a,b) ((a)<(b)?(a):(b))

typedef char flag;	/* For a very small range of possible values */

char *directions[]=
{
	"North.\n",
	"South.\n",
	"East.\n",
	"West.\n",
	"Northeast.\n",
	"Northwest.\n",
	"Southeast.\n",
	"Southwest.\n",
	"Up.\n",
	"Down.\n"
};

char *oname[]=
{
	"",				/* Null is for object 0 (they start at 1) */
	"set of keys",
					/* Defensive weapons */
	"riot shield",
	"dustbin lid",
	"bulletproof vest",
	"crash helmet",
	"suit of armour",
					/* Offensive weapons in order of effectiveness */
	"whip",
	"knuckleduster",
	"cudgel",
	"truncheon",
	"electric drill",
	"baton",
	"broken bottle",
	"stick",
	"sawn-off pool cue",
	"poker",
	"hatchet",
	"bicycle chain",
	"crowbar",
	"knife",
	"club",
	"quarterstaff",
	"dagger",
	"axe",
	"rapier",
	"chainsaw",
	"scimitar",
	"sword",
	"mace",
	"lightsaber",
					/* Valuable objects */
	"diamond ring",
	"silver cup",
	"ten-pound note",
	"Amiga A500",
	"68882 floating-point coprocessor chip",
	"mink coat",
	"gold nugget",
	"Compaq Portable 386",
	"pocket calculator",
	"Van Gogh painting",
	"digital watch",
	"gold watch",
	"T800 transputer",
	"airline ticket"
};

char *verb[]=
{
	"",
	"shut",
	"open",
	"close",
	"n",
	"s",
	"e",
	"w",
	"ne",
	"nw",
	"se",
	"sw",
	"u",
	"d",
	"attack",
	"hit",
	"kill",
	"get",
	"take",
	"drop",
	"wait",
	"spectator",
	"quit",

	"look",
	"inventory",
	"who",
	"information",
	"become",
	"local",
	"global",
	"brief",
	"normal",
	"verbose",
	"tame",
	"gruesome",
	"exits",
	"talk",
	"quiet",
	"help"
};

char *pname[]=
{
	"nobody",
	"Russell Wallace",
	"Bob Gray",
	"Shane Broadberry",
	"Alan Callender",
	"Allen Dunne",
	"Tara Morris",
	"Ian O'Keeffe",
	"Garrett Simons",
	"Nigel Waterhouse",
	"Daragh Fitzpatrick",
	"Naoise Hart",
	"Julian Carr",
	"Shayan Sen",
	"Paul Whelan",
	"David Watchorn",
	"Richard Middleton",
	"Jason O'Brien",
	"Jason Gull",
	"Paul Rimas",
	"Edmund Farrell",
	"Eddy Carroll",
	"Marcus McInnes",
	"Norman Ruddock",
	"Rory Miller",

	"Coralie Burns",
	"Susan Carroll",
	"Ruth Laycock",
	"Ruth Whittaker",
	"Gillian Nother",
	"Sarah Gilliland",
	"Penny Jackson",
	"Lucy Jones",
	"Emma Kelly",
	"Antoinette Uhlar",
	"Suzanne Donegan",
	"Marina Fleeton",
	"Ciara O'Mahony",
	"Swapna Rao",
	"Fiona McDowell",
	"Fiona Reeves",
	"Naomi Varian",
	"Hilary Usher",
	"Lynnea Fitzgerald",
	"Alison Whitty",
	"Tara O'Rourke",
	"Lynne Beamish",
	"Sarah Lessen",
	"Antoinette Harbourne",

	"Mr. Reeves",
	"Mr. Tilson",
	"Mr. Godsil",
	"Mr. Spencer",
	"Mr. Agnew",
	"Mr. Stiobhard",
	"Mr. Allen",
	"Mr. Wilson",
	"Dr. Frewin",
	"Mr. McArdle",
	"Mr. Hosford",
	"Mr. Bradbury",
	"Mr. Duke",
	"Mr. Keegan",
	"Mr. Boyd",
	"Mr. Hamill",
	"Mr. Beere",
	"Mr. Viale",

	"Ms. Parsons",
	"Ms. Symns",
	"Ms. Lee",
	"Ms. Murphy"
};

int defval[]=	/* Defensive value of objects */
{
	10,6,9,5,8
};

int attval[]=	/* Offensive value */
{
	46,48,61,62,62,63,65,65,66,66,67,68,69,69,70,
	77,78,101,104,114,139,141,156,200
};

int value[]=
{
	130,157,10,700,450,190,623,6999,19,2400,12,80,250,232
};

int ownroom[]=
{
	59,60,63,33,29,70,65,64,44,43,42,30,3,32,20,56,66,16,21,68,1,14
};

flag talking;		/* Speech on or off */
flag violence;		/* Tame or gruesome */
flag descriptions;	/* 0 for brief to 2 for verbose */
flag narration;		/* 0/1 ... local/global */
int player;			/* Who is the player? */

int score[PLAYERS+1];	/* +1 is because we're not using element 0 */
int strength[PLAYERS+1];
int power[PLAYERS+1];
int ploc[PLAYERS+1];	/* Location of player */
int pcouldbe[PLAYERS+1];	/* For deciding which is one named in input */

int oloc[OBJECTS+1];	/* Location of object */
int ocouldbe[OBJECTS+1];

int exits[ROOMS+1][10];	/* Exits from rooms */
int oexits[ROOMS+1][10];	/* Original exits from rooms */
flag visited[ROOMS+1];	/* Which rooms have been visited */

int Verb,Noun;			/* Verb,noun input by player */
int oldverb,oldnoun;	/* Previous verb, noun */
int gameover;			/* Is game over? */
long waiting;			/* How many turns still to wait? */
long filehandle;		/* Handle for room description file */
char namebuf[NAMELEN];	/* buffer for user-defined name */
char inbuf[INLEN];		/* buffer for input */
char *descs;			/* Location of room description file in memory */
char *shortdesc[ROOMS+1],*longdesc[ROOMS+1];	/* Location of descriptions */

main ()
{
	int i;
	int sparescore=0;
	setup ();	/* Once-off initialization of global variables etc. */
	print ("Welcome to Labyrinth II by Russell Wallace. Do you want instructions? (Press Y or N):");
	if (yesno ())
	{
		if (readfile ("Labyrinth_II.instructions.doc"))
			print ("Sorry, couldn't get the instructions file.\n");
		print ("\nPress any key to continue.\n");
		do
			i=checkinput ();
		while (i==0);
		if (i==1000)
		{
			finish ();
			FreeMem (descs,DESCLEN);
			exit (0);
		}
	}
REPEATGAME:
	initialize ();	/* Initialize individual game */
	score[player]=sparescore;
REPEATINPUT:
	if (waiting==0)	/* If we're not waiting at the moment, get input */
	{
MISTAKE:
		getinput ();	/* Get player command */
		if (Verb==0)
		{
			print ("Sorry, I don't understand you.\n");
			goto MISTAKE;
		}
		oldverb=Verb;
		oldnoun=Noun;
		if (doinput ())	/* Act on command ... if nonzero, mistake-repeat */
			goto MISTAKE;
	}
		else
		{
			waiting--;	/* If waiting, now one less turn to wait */
			i=(short)checkinput ();
			if (i==1000)			/* If closewindow, finish */
			{
				FreeMem (descs,DESCLEN);
				finish ();
				exit (0);
			}
			if (i)					/* If keypress, stop waiting */
				waiting=0;
		}
	if (gameover)
		goto ENDOFGAME;
	if (Verb>21)			/* If verb doesn't take any game time */
		goto REPEATINPUT;	/* then get next input immediately */
	for (i=1;i<=PLAYERS;i++)
	{
		if (i!=player && ploc[i]!=NOWHERE)
			domobile (i);	/* Do computer-controlled characters */
		if (waiting>1000000)	/* If spectator mode, don't have any */
			resetscroll ();		/* pauses in narration */
	}
	if (gameover)
		goto ENDOFGAME;
	gameover=1;
	for (i=1;i<=PLAYERS;i++)	/* Game over if everyone else dead */
	{
		if (i!=player && ploc[i]!=NOWHERE)
			gameover=0;
		strength[i]+=7;
		if (strength[i]>power[i])
			strength[i]=power[i];
	}
	if (!gameover)
		goto REPEATINPUT;
	print ("\nCongratulations! You've outlasted all the other players!\n");
	sparescore=score[player];
	goto WON;
ENDOFGAME:
	sparescore=0;
WON:
	print ("\nGame over.");
	if (player)		/* If player was actually one of the characters */
	{
		print (" Your score was ");
		printshort (score[player]);
		print (". Your power was ");
		printshort (power[player]);
		writechar ((long)'.');
	}
	print (" Would you like to play again?");
	if (yesno ())
		goto REPEATGAME;
	FreeMem (descs,DESCLEN);
	finish ();	/* Close window etc. */
}

int yesno ()	/* Get yes or no input */
{
	int i;
YNLOOP:
	i=checkinput ();
	if (i==1000)
	{
		FreeMem (descs,DESCLEN);
		finish ();
		exit (0);
	}
	if (i=='y' || i=='Y')
	{
		print (" YES\n");
		return (1);
	}
	if (i=='n' || i=='N')
	{
		print (" NO\n");
		return (0);
	}
	goto YNLOOP;
}

setup ()
{
	int i,j,k;
	char *z,dirbuf[2];
	long Seconds,Micros;
	if (!(descs=AllocMem (DESCLEN,0L)))
	{
		DisplayBeep (0L);
		exit (1);
	}
	if (!(start ()))	/* Open text window */
	{
		FreeMem (descs,DESCLEN);
		DisplayBeep (0L);
		exit (2);
	}
	if (!(filehandle=Open ("Labyrinth_II.descriptions.doc",MODE_OLDFILE)))
	{
		FreeMem (descs,DESCLEN);
		finish ();
		DisplayBeep (0L);
		exit (3);
	}
	(void)Read (filehandle,descs,DESCLEN);	/* Read room descs from file */
	Close (filehandle);						/* then close file */
	z=descs;
	for (;;)	/* Scan through whole text file in memory */
	{
		for (;*z!='{' && *z!='~';z++)
			;
		if (*z=='~')
			break;			/* ~ marks end of file */
		i=scanshort (++z);
		for (;*z!='[';z++)
			;
		shortdesc[i]=++z;	/* Assign short description for room to */
		for (;*z!='[';z++)	/* appropriate place in file */
			;
		*(z-1)='\0';		/* Put zero terminator at end of description */
		longdesc[i]=++z;	/* in place of closing bracket */
		for (;*z!='[';z++)
			;
		*(z-1)='\0';
		z++;
		for (;;)	/* Scan through exit list */
		{
			dirbuf[0]=tolower (*z++);
			dirbuf[1]=tolower (*z++);
			if (*z==' ')
				z++;
					else
						dirbuf[1]='\0';
			k=scanshort (z);
			for (j=4;j<=13;j++)
				if (dirbuf[0]==verb[j][0] && dirbuf[1]==verb[j][1])
					oexits[i][j-4]=k;
			for (;*z!=' ' && *z!=']';z++)
				;
			if (*z==']')
				break;	/* ] marks end of exit list */
			z++;
		}
	}
	talking=0;
	violence=0;
	descriptions=1;
	narration=0;
	player=1;
	oldverb=0;
	for (i=0;i<=ROOMS;i++)
		visited[i]=0;	/* No rooms visited yet */
	CurrentTime (&Seconds,&Micros);
	for (i=0;i<(Micros&1023);i++)	/* Seed random number generator */
		(void)rnd (Seconds|1);
	print ("Enter name you want to use (default is Russell Wallace): ");
	if (input (namebuf,NAMELEN)==-1000)
	{
		finish ();
		FreeMem (descs,DESCLEN);
		exit (0);
	}
	if (namebuf[0]!='\0')		/* If name has been typed, assign it */
		pname[1]=namebuf;
}

initialize ()
{
	int i,j;
	gameover=0;
	waiting=0;
	resetscroll ();
	print ("\fGame now starting...\n\n");
	for (i=1;i<=OBJECTS;i++)
		oloc[i]=rnd (ROOMS)+1;
	for (i=0;i<=PLAYERS;i++)	/* Setting things up for player 0 as well, */
	{							/* in case human player wants to use it */
		strength[i]=300;
		power[i]=300;
		score[i]=0;
		if (i<=STUDENTS)
		{
			do
				ploc[i]=rnd (ROOMS)+1;
			while (lockable (ploc[i]));
		}
			else
				ploc[i]=ownroom[i-49];
	}
	look (ploc[player]);
	for (i=1;i<=ROOMS;i++)
	{
		for (j=0;j<=9;j++)
			exits[i][j]=oexits[i][j];
	}
}

getinput ()
{
	register unsigned int z;
	int i,j,k,closeness;
	Verb=Noun=0;
	writechar ((long)'>');
	if (input (inbuf,INLEN)==-1000)
	{
		FreeMem (descs,DESCLEN);
		finish ();
		exit (0);
	}
	if (inbuf[0]=='\0')		/* If nothing typed, copy stuff from previous */
	{
		Verb=oldverb;
		Noun=oldnoun;
	}
	for (i=0;i<INLEN;i++)
		inbuf[i]=tolower (inbuf[i]);
	i=0;
	while (inbuf[i]==' ')
		i++;
	if (inbuf[i]=='\0')
		return;
	closeness=999;
	for (j=1;j<=VERBS;j++)
	{
		z=(unsigned int)wcomp (verb[j],inbuf+i);
		if (z<closeness)
		{
			closeness=z;
			Verb=j;
		}
	}
	if (Verb==1)				/* Shut=close */
		Verb=3;
	if (Verb==14 || Verb==15)	/* Attack, hit=kill */
		Verb=16;
	if (Verb==17)				/* Get=take */
		Verb=18;
	if (inbuf[i]=='i' && (inbuf[i+1]==' ' || inbuf[i+1]=='\0'))
		Verb=24;
	while (inbuf[i]!=' ' && inbuf[i]!='\0')
		i++;		/* Scan to gap between words */
	if (inbuf[i]=='\0')
		return;		/* If no next word, return */
	while (inbuf[i]==' ')
		i++;		/* Scan to beginning of next word */
	if (Verb==20)	/* If "wait", return following number */
	{
		Noun=scanshort (inbuf+i);
		return;
	}
	if (Verb!=16 && Verb!=18 && Verb!=19 && Verb!=27)
		return;		/* If verb doesn't have object, return */
	closeness=999;
	if (Verb==18 || Verb==19)	/* Take and drop take things as objects */
	{
		for (j=1;j<=OBJECTS;j++)
			ocouldbe[j]=10000;
		for (;;)	/* Do for all remaining words in input */
		{
			for (j=1;j<=OBJECTS;j++)
			{
				k=compare (oname[j],inbuf+i);
				if (k==-1 || ocouldbe[j]==0)
					ocouldbe[j]=0;
						else
							ocouldbe[j]-=k;
			}
			while (inbuf[i]!=' ' && inbuf[i]!='\0')
				i++;
			if (inbuf[i]=='\0')
				break;
			while (inbuf[i]==' ')
				i++;
			if (inbuf[i]=='\0')
				break;
		}
		closeness=1;
		for (j=1;j<=OBJECTS;j++)
			if (ocouldbe[j]>closeness)
				Noun=j;
	}
		else	/* Kill and become take people as objects */
		{
			for (j=1;j<=PLAYERS;j++)
				pcouldbe[j]=10000;
			for (;;)
			{
				for (j=1;j<=PLAYERS;j++)
				{
					k=compare (pname[j],inbuf+i);
					if (k==-1 || pcouldbe[j]==0)
						pcouldbe[j]=0;
							else
								pcouldbe[j]-=k;
				}
				while (inbuf[i]!=' ' && inbuf[i]!='\0')
					i++;
				if (inbuf[i]=='\0')
					break;
				while (inbuf[i]==' ')
					i++;
				if (inbuf[i]=='\0')
					break;
			}
			closeness=1;
			for (j=1;j<=PLAYERS;j++)
				if (pcouldbe[j]>closeness)
					Noun=j;
		}
	return;
}

int wcomp (a,b)
char *a,*b;
{
	int i;
	do
	{
		if (*b==' ' || *b=='\0')
		{
			for (i=0;a[i]!=' ' && a[i]!='\0';i++)
				;
			return (i);
		}
		if (*a==' ' || *a=='\0')
			return (-1);
	}
	while (tolower (*a++)==*b++);
	return (-1);
}

int compare (a,b)
char *a,*b;
{
	unsigned int i,closest;
	i=0;
	closest=-1;
	for (;;)
	{
		closest=MIN (closest,(unsigned int)wcomp (a+i,b));
		while (a[i]!=' ' && a[i]!='\0')
			i++;
		if (a[i]=='\0')
			break;
		while (a[i]==' ')
			i++;
	}
	return (closest);
}

int lockable (r)
int r;
{
	int i;
	for (i=0;i<=9;i++)
		if (oexits[r][i]>0)		/* If unlockable exit from room exists */
			return (0);			/* then room is not lockable */
	return (1);			/* otherwise it is */
}

int numobj (r)		/* Returns number of objects in room r */
int r;
{
	int i,j;
	j=0;
	for (i=1;i<=OBJECTS;i++)
		if (oloc[i]==r)
			j++;
	return (j);
}

oprint (o,cap)
int o,cap;
{
	int i;
	char c,*a;
	a=inbuf+1;
	if (cap)
		inbuf[0]='A';
			else
				inbuf[0]='a';
	c=tolower (oname[o][0]);
	if (c=='a' || c=='e' || c=='i' || c=='o' || c=='u')
		*a++='n';
	*a++=' ';
	for (i=0;oname[o][i]!='\0';i++)
		*a++=oname[o][i];
	*a++='\0';
	print (inbuf);
}

olist (r)
int r;
{
	int i,k;
	flag j=0;
	for (i=1;i<=OBJECTS;i++)
		if (oloc[i]==r)
		{
			if (j)
			{
				writechar ((long)',');
				writechar ((long)' ');
			}
			oprint (i,0);
			j=1;
		}
	print (".\n");
}

look (r)
int r;
{
	int i;
	print (shortdesc[r]);
	writechar ((long)'\n');
	if (((!visited[r]) && descriptions)|| descriptions==2)
	{
		print (longdesc[r]);
		writechar ((long)'\n');
	}
	visited[r]=1;
	if (numobj (r))
	{
		print ("You can also see ");
		olist (r);
	}
	for (i=1;i<=PLAYERS;i++)
		if (ploc[i]==r && i!=player)
		{
			print (pname[i]);
			print (" is here.\n");
			perdesc (i);
		}
}

perdesc (p)
int p;
{
	if (p<=BOYS || (p>STUDENTS && p<=STUDENTS+MEN))
		print ("His");
			else
				print ("Her");
	print (" strength is ");
	printshort (strength[p]);
	print (".\n");
	if (numobj (-p))
	{
		if (p<=BOYS || (p>STUDENTS && p<=STUDENTS+MEN))
			print ("He");
				else
					print ("She");
		print (" is carrying ");
		olist (-p);
	}
}

int walk (p,dir)
int p,dir;
{
	if (exits[ploc[p]][dir]<0)
		return (1);
	if (exits[ploc[p]][dir]==0)
		return (2);
	ploc[p]=exits[ploc[p]][dir];
	if (ploc[p]==ploc[player] && p!=player)
	{
		print (pname[p]);
		print (" arrives.\n");
		perdesc (p);
		if (player)
			waiting=0;
	}
	return (0);
}

get (p,o)
int p,o;
{
	oloc[o]=-p;
	if (ploc[p]==ploc[player])
	{
		print (pname[p]);
		print (" takes the ");
		print (oname[o]);
		print (".\n");
	}
}

drop (p,o)
int p,o;
{
	oloc[o]=ploc[p];
	if (ploc[p]==ploc[player])
	{
		print (pname[p]);
		print (" drops ");
		oprint (o,0);
		print (".\n");
	}
	if (ploc[p]==DROPZONE && o>=FTREASURE && o<FTREASURE+TREASURES)
	{
		score[p]+=value[o-FTREASURE];
		oloc[o]=NOWHERE;
		if (ploc[p]==ploc[player])
			print ("It vanishes in a swirl of light.\n");
	}
}
