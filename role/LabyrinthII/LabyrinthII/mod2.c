
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

long openmouth (),Open (),Read (),RangeRand (),start (),checkinput (),input ();
int lockable (),walk (),numobj ();

#define rnd(x) RangeRand((long)x)
#define MAX(a,b) ((a)>(b)?(a):(b))
#define MIN(a,b) ((a)<(b)?(a):(b))

typedef char flag;	/* For a very small range of possible values */

extern char *directions[],*oname[],*verb[],*pname[];
extern int defval[],attval[],value[],ownroom[];

extern flag talking;
extern flag violence;		/* Tame or gruesome */
extern flag descriptions;	/* 0 for brief to 2 for verbose */
extern flag narration;		/* 0/1 ... local/global */
extern int player;			/* Who is the player? */

extern int score[PLAYERS+1];	/* +1 is because we're not using element 0 */
extern int strength[PLAYERS+1];
extern int power[PLAYERS+1];
extern int ploc[PLAYERS+1];	/* Location of player */
extern int pcouldbe[PLAYERS+1];	/* For deciding which is one named in input */

extern int oloc[OBJECTS+1];	/* Location of object */
extern int ocouldbe[OBJECTS+1];

extern int exits[ROOMS+1][10];	/* Exits from rooms */
extern int oexits[ROOMS+1][10];	/* Original exits from rooms */
extern flag visited[ROOMS+1];	/* Which rooms have been visited */

extern int Verb,Noun;			/* Verb,noun input by player */
extern int oldverb,oldnoun;	/* Previous verb, noun */
extern int gameover;			/* Is game over? */
extern long waiting;			/* How many turns still to wait? */
extern long filehandle;		/* Handle for room description file */
extern char namebuf[NAMELEN];	/* buffer for user-defined name */
extern char inbuf[INLEN];		/* buffer for input */
extern char *descs;			/* Location of room description file in memory */
extern char *shortdesc[ROOMS+1],*longdesc[ROOMS+1];	/* Location of descriptions */

int doinput ()
{
	int i,j,k;
	char *a;
	if (Verb>3 && Verb<14)	/* A direction */
	{
		i=walk (player,Verb-4);
		if (i==1)
			print ("The door's locked.\n");
		if (i==2 && Verb<12)
			print ("You can't go that way.\n");
		if (i==2 && Verb==12)
			print ("You seem to have got a bit out of practice at the levitation lately.\n");
		if (i==2 && Verb==13)
			print ("There seems to be a big hard flat thing called the ground in the way.\n");
		if (i==0)					/* Successful! */
			look (ploc[player]);	/* so describe new location */
		return (0);	/* Anyway, return to main program */
	}
	switch (Verb)
	{
		case (2):	/* Open */
			if (oloc[1]!=-player)
			{
				print ("You can't open anything without keys!\n");
				return (1);
			}
			for (i=0;i<=9;i++)
				if (exits[ploc[player]][i]<0)
				{
					print ("The door opens to the ");
					print (directions[i]);
					exits[ploc[player]][i]=-exits[ploc[player]][i];
					for (j=0;j<=9;j++)
						if (exits[exits[ploc[player]][i]][j]==-ploc[player])
							exits[exits[ploc[player]][i]][j]=ploc[player];
					return (0);
				}
			print ("There's no locked door here to open.\n");
			return (1);
		case (3):	/* Close */
			if (oloc[1]!=-player)
			{
				print ("You can't close anything without keys!\n");
				return (1);
			}
			for (i=0;i<=9;i++)
				if (oexits[ploc[player]][i]<0 && exits[ploc[player]][i]>0)
				{
					print ("You close and lock the door.\n");
					for (j=0;j<=9;j++)
						if (exits[exits[ploc[player]][i]][j]==ploc[player])
							exits[exits[ploc[player]][i]][j]=-ploc[player];
					exits[ploc[player]][i]=-exits[ploc[player]][i];
					return (0);
				}
			print ("I see no open door here which may be locked.\n");
			return (1);
		case (16):	/* Kill */
			if (Noun==0)
			{
				print ("You have to enter the name of a player you wish to attack.\n");
				return (1);
			}
			if (ploc[Noun]!=ploc[player])
			{
				print (pname[Noun]);
				print (" isn't here.\n");
				return (1);
			}
			if (Noun==player)
			{
				print ("Suicide is not the answer!\n");
				return (1);
			}
			j=40;
			k=0;
			for (i=0;i<AWEAPONS;i++)
				if (attval[i]>j && oloc[i+FAWEAPON]==-player)
				{
					j=attval[i];
					k=i+FAWEAPON;
				}
			print ("You attack ");
			print (pname[Noun]);
			if (k)
			{
				print (" with ");
				oprint (k,0);
			}
			print (".\n");
			for (k=0;k<DWEAPONS;k++)
				if (oloc[k+FDWEAPON]==-Noun)
					j-=defval[k];
			strength[Noun]-=j;
			if (strength[Noun]<1)
			{
				ploc[Noun]=NOWHERE;
				power[player]+=(power[Noun]/4);
				if (violence)
				{
					switch (rnd(4))
					{
						case (0):
							print ("With one well-placed blow, you cleave ");
							print (pname[Noun]);
							print ("'s skull. Pinkish-grey brain tissue spatters all over the walls.\n");
							break;
						case (1):
							print ("You get past your exhausted enemy's guard and sever the carotid artery. A bright red stream of ");
							print ("blood spurts out, drenching the room.\n");
							break;
						case (2):
							print ("Your attack succeeds in slicing open ");
							print (pname[Noun]);
							print ("'s belly. A pile of steaming guts spills out onto the floor.\n");
							break;
						case (3):
							print ("You lop ");
							print (pname[Noun]);
							print ("'s head clean off. It bounces to the floor and the decapitated corpse collapses, jetting a");
							print (" stream of blood from the stump of the neck.\n");
					}
				}
					else
					{
						print (pname[Noun]);
						print (" dies.\n");
					}
				for (i=1;i<=OBJECTS;i++)
					if (oloc[i]==-Noun)
					{
						oloc[i]=ploc[player];
						oprint (i,1);
						print (" falls to the ground.\n");
					}
			}
			break;
		case (18):	/* Take */
			if (Noun==0)
			{
				print ("I don't understand what you're referring to.\n");
				return (1);
			}
			if (oloc[Noun]==-player)
			{
				print ("You already have the ");
				print (oname[Noun]);
				print (".\n");
				return (1);
			}
			if (oloc[Noun]!=ploc[player])
			{
				print ("I don't see any ");
				print (oname[Noun]);
				print (" here.\n");
				return (1);
			}
			if (numobj (-player)>=MAXCARR)
				print ("You can't carry any more.\n");
					else
					{
						print ("Taken.\n");
						oloc[Noun]=-player;
					}
			break;
		case (19):	/* Drop */
			if (Noun==0)
			{
				print ("I don't understand what you want to drop.\n");
				return (1);
			}
			if (oloc[Noun]!=-player)
			{
				print ("You're not holding any ");
				print (oname[Noun]);
				print (".\n");
				return (1);
			}
			if (ploc[player]==DROPZONE && Noun>=FTREASURE && Noun<FTREASURE+TREASURES)
			{
				print ("The ");
				print (oname[Noun]);
				print (" vanishes in a swirl of light and your score is incremented by ");
				printshort (value[Noun-FTREASURE]);
				print (" points.\n");
				score[player]+=value[Noun-FTREASURE];
				oloc[Noun]=NOWHERE;
			}
				else
				{
					print ("Dropped.\n");
					oloc[Noun]=ploc[player];
				}
			break;
		case (20):	/* Wait */
			if (Noun)
				waiting=Noun-1;
					else
						waiting=0;
			break;
		case (21):	/* Spectator */
			waiting=2000000000;
			print ("Entering spectator mode. Press any key to stop.\n");
			break;
		case (22):	/* Quit */
			print ("Are you sure you want to stop playing? (Y/N)");
			if (yesno ())
				gameover=1;
			break;
		case (23):	/* Look */
			i=descriptions;
			descriptions=2;
			look (ploc[player]);
			descriptions=i;
			break;
		case (24):	/* Inventory */
			print ("You are ");
			print (pname[player]);
			print (".\n");
			print ("Your power is ");
			printshort (power[player]);
			print (".\n");
			print ("Your strength is ");
			printshort (strength[player]);
			print (".\n");
			print ("Your score is ");
			printshort (score[player]);
			print (".\n");
			if (numobj (-player)==0)
				print ("You are emptyhanded.\n");
					else
					{
						print ("You are carrying ");
						olist (-player);
					}
			break;
		case (25):	/* Who */
			j=0;
			print ("The following players are still around:");
			for (i=1;i<=PLAYERS;i++)
				if (ploc[i]!=NOWHERE && i!=player)
				{
					a=inbuf;
					if (j)
						*a++=',';
					*a++=' ';
					for (k=0;pname[i][k]!='\0';k++)
						a[k]=pname[i][k];
					a[k++]='\0';
					print (inbuf);
					j=1;
				}
			print (".\n");
			break;
		case (26):	/* Information */
			print ("The following players are still around:\n");
			for (i=1;i<=PLAYERS;i++)
				if (ploc[i]!=NOWHERE && i!=player)
				{
					a=pname[i];
					for (j=0;a[j]!='\0';j++)
						inbuf[j]=a[j];
					for (;j<30;j++)
						inbuf[j]=' ';
					inbuf[j++]=' ';
					inbuf[j]='\0';
					print (inbuf);
					a=shortdesc[ploc[i]];
					for (j=0;a[j]!='\0';j++)
						inbuf[j]=a[j];
					for (;j<30;j++)
						inbuf[j]=' ';
					inbuf[j++]=' ';
					inbuf[j]='\0';
					print (inbuf);
					printshort (strength[i]);
					writechar ((long)'\n');
				}
			break;
		case (27):	/* Become */
			if (Noun==0)
				ploc[0]=ploc[player];
			if (ploc[Noun]==NOWHERE)
			{
				print ("That person is dead!\n");
				return (1);
			}
			player=Noun;
			print ("You are ");
			print (pname[player]);
			print (".\n");
			break;
		case (28):	/* Local */
			narration=0;
			print ("Local narration only.\n");
			break;
		case (29):	/* Global */
			narration=1;
			print ("Global narration.\n");
			break;
		case (30):	/* Brief */
			descriptions=0;
			print ("Brief descriptions only.\n");
			break;
		case (31):	/* Normal */
			descriptions=1;
			print ("Long descriptions only in unvisited rooms.\n");
			break;
		case (32):	/* Verbose */
			descriptions=2;
			print ("Long descriptions all the time.\n");
			break;
		case (33):	/* Tame */
			violence=0;
			print ("Tame deaths only.\n");
			break;
		case (34):	/* Gruesome */
			violence=1;
			print ("Gruesome deaths selected.\n");
			break;
		case (35):	/* Exits */
			j=0;
			print ("You can go:\n");
			for (i=0;i<=9;i++)
				if (exits[ploc[player]][i]>0)
				{
					print (directions[i]);
					j=1;
				}
			if (j==0)
				print ("nowhere...\n");
			break;
		case (36):	/* Talk */
			if (talking==0)
				if (openmouth ())
				{
					talkerror ();
					return (1);
				}
			talking=1;
			print ("Speech on.\n");
			break;
		case (37):	/* Quiet */
			if (talking==1)
			{
				talking=2;
				print ("Speech off.\n");
			}
				else
					alreadyquiet ();
			break;
		default:	/* 38=Help */
			print ("These are the verbs I understand:\n");
			for (i=1;i<=VERBS;i++)
			{
				print (verb[i]);
				if (i<VERBS)
					writechar ((long)',');
			}
			print (".\n");
	}
	return (0);		/* Input understood and acted on */
}

domobile (p)
int p;
{
	register int i;
	int l,carried,numcarr,j,target;
	int pmaxpower,pmostpower;	/* Most powerful offensive weapons carried */
	int pminpower,pleastpower;	/* Least powerful */
	int lmaxpower,lmostpower;	/* Most powerful in room */
	int lmaxdef,lmostdef;		/* Most powerful defensive weapons */
	int pmaxval,pmostval;		/* Most valuable thing carried */
	int pminval,pleastval;		/* Least valuable */
	int lmaxval,lmostval;		/* Most valuable in room */
	carried=-p;
	l=ploc[p];
	numcarr=numobj (carried);

			/* Get more powerful offensive weapon? */

	pmaxpower=lmaxpower=40;
	for (i=0;i<AWEAPONS;i++)
	{
		if (oloc[i+FAWEAPON]==carried && attval[i]>pmaxpower)
		{
			pmaxpower=attval[i];
			pmostpower=i;
		}
		if (oloc[i+FAWEAPON]==l && attval[i]>lmaxpower)
		{
			lmaxpower=attval[i];
			lmostpower=i;
		}
	}
	if (lmaxpower>pmaxpower && numcarr<MAXCARR)
	{
		get (p,lmostpower+FAWEAPON);
		return;
	}

			/* Get defensive weapon? */

	lmaxdef=0;
	for (i=0;i<DWEAPONS;i++)
		if (oloc[i+FDWEAPON]==l && defval[i]>lmaxdef)
		{
			lmaxdef=defval[i];
			lmostdef=i;
		}
	if (lmaxdef && numcarr<MAXCARR)
	{
		get (p,lmostdef+FDWEAPON);
		return;
	}

			/* Fight? */

	target=0;
	for (i=PLAYERS;i>0;i--)
		if (ploc[i]==l && i!=p)
			target=i;
	if (target)
	{
		if (narration && l!=ploc[player])
		{
			writechar (27L);
			nprint ("[32m");
		}
		if (narration || l==ploc[player])
		{
			print (pname[p]);
			print (" attacks ");
			if (target!=player)
				print (pname[target]);
					else
						print ("you");
			if (pmaxpower>40)
			{
				print (" with ");
				oprint (pmostpower+FAWEAPON,0);
			}
			print (".\n");
		}
		for (i=0;i<DWEAPONS;i++)
			if (oloc[i+FDWEAPON]==-target)
				pmaxpower-=defval[i];
		strength[target]-=pmaxpower;
		if (strength[target]<1)
		{
			ploc[target]=NOWHERE;
			power[p]+=(power[target]/4);
			if ((narration || l==ploc[player])&& target!=player)
			{
				print (pname[target]);
				print (" dies.\n");
			}
			if (target==player)
			{
				print ("You die.\n");
				gameover=1;
			}
			for (i=1;i<=OBJECTS;i++)
				if (oloc[i]==-target)
				{
					oloc[i]=l;
					if (l==ploc[player])
					{
						oprint (i,1);
						print (" falls to the ground.\n");
					}
				}
		}
		writechar (27L);
		nprint ("[0m");
		return;
	}

			/* Drop treasure? */

	if (l==DROPZONE)
	{
		pmaxval=0;
		for (i=0;i<TREASURES;i++)
			if (oloc[i+FTREASURE]==carried && value[i]>pmaxval)
			{
				pmaxval=value[i];
				pmostval=i;
			}
		if (pmaxval)
		{
			drop (p,pmostval+FTREASURE);
			return;
		}
	}

			/* Drop excess weight? */

	if (numcarr>=MAXCARR)
	{
		pminpower=9999;
		for (i=0;i<AWEAPONS;i++)
			if (attval[i]<pminpower && oloc[i+FAWEAPON]==carried)
			{
				pminpower=attval[i];
				pleastpower=i;
			}
		if (pminpower<pmaxpower)
		{
			drop (p,pleastpower+FAWEAPON);
			return;
		}
		pminval=32767;
		for (i=0;i<TREASURES;i++)
			if (value[i]<pminval && oloc[i+FTREASURE]==carried)
			{
				pminval=value[i];
				pleastval=i;
			}
		if (pminval<32767)
		{
			drop (p,pleastval+FTREASURE);
			return;
		}
	}

			/* Get keys? */

	if (oloc[1]==l && numcarr<MAXCARR)
	{
		get (p,1);
		return;
	}

			/* Get treasure? */

	lmaxval=0;
	pminval=32767;
	for (i=0;i<TREASURES;i++)
	{
		if (oloc[i+FTREASURE]==l && value[i]>lmaxval)
		{
			lmaxval=value[i];
			lmostval=i;
		}
		if (oloc[i+FTREASURE]==carried && value[i]<pminval)
		{
			pminval=value[i];
			pleastval=i;
		}
	}
	if (lmaxval && (((numcarr+1)<MAXCARR) || (numcarr<MAXCARR && pminval<lmaxval)))
	{
		get (p,lmostval+FTREASURE);
		return;
	}

			/* Open door? */

	if (strength[p]==power[p] && oloc[1]==carried)
	{
		for (i=0;i<=9;i++)
			if (exits[l][i]<0)
			{
				exits[l][i]=-exits[l][i];
				for (j=0;j<=9;j++)
					if (exits[exits[l][i]][j]==-l)
						exits[exits[l][i]][j]=l;
				if (l==ploc[player])
				{
					print (pname[p]);
					print (" opens a door leading ");
					print (directions[i]);
				}
				return;
			}
	}

			/* Walk in a random direction */

	i=rnd (10);
	(void)walk (p,i);
}
