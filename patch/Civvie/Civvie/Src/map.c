/* map.c
   vi:ts=3 sw=3:
	
	Save files moving around, and conversions.
	Reads civilization headers to maintain proper filenames
	(such as "civ:saves/Emperor Caesar of the Romans/3800 BC")
 */
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <sys/stat.h>
#include "proto.h"


/* max number of saves for a given year */
#define GENSAVES 20

struct civinfo
   {
   char pad1[3];
   unsigned char civ_index;
   char pad2[4];
   short civ_date;
   char pad3;
   unsigned char civ_level;
   char pad4[4];
   char leaders[8][14];
   char people[8][12];
   };

#define MAPSIZE 40000
#define IOBUFSIZE (MAPSIZE+1)

char *iobuf;

void setup_iobuf(void)
	{
	iobuf = malloc(IOBUFSIZE);
	if (!iobuf)
		exit(10);
	}

/* `string' is file name: built from civdate, plus copy number */
static char *date2string(short date, int number)
   {
   static char buffer[20];
   
	if (number)
		{
		if (date > 0)
			sprintf(buffer, "%d AD.%d", date, number);
		else
			sprintf(buffer, "%d BC.%d", -date, number);
		}
	else
		/* first (#0) copy doesn't need any extension */
		{
	   if (date > 0)
   	   sprintf(buffer, "%d AD", date);
	   else
   	   sprintf(buffer, "%d BC", -date);
		}
   return buffer;
   }

static char *level[] = {"Chieftain", "Lord", "Prince", "King", "Emperor"};
static char *shlev[] = {"Chf.", "Lord", "Pr.", "King", "Emp."};

static void copy_file2file(FILE *g, FILE *f)
	{
	int n;
	
	do 
		{
		n = fread(iobuf, 1, IOBUFSIZE, f);
		if (n > 0)
			{
			(void)fwrite(iobuf, 1, n, g);
			}
		} while (n == IOBUFSIZE);
	}

static void copy_name2file(FILE *g, char *srcname)
	{
	FILE *f;
	
	f = fopen(srcname, "r");
	if (f)
		{
		copy_file2file(g, f);
		fclose(f);
		}
	else
		{
		fprintf(stderr, "File %s does not exist\n", srcname);
		return;
		}
	}
	
	
void copy_save_file(int i)
   {
   FILE *f;
	struct civinfo civ;
	int res;
   char buffer[50];
	static time_t check_last = 0;
	struct stat stat_buf;
	BPTR dirlock;
   
   sprintf(buffer, "ram:civil%d.sve", i);

		/* check this is really a new save, that does exist */
	if (stat(buffer, &stat_buf) != 0)
		return;
	if (stat_buf.st_mtime == check_last)
		return;
	
   f = fopen(buffer, "r");
   if (!f)
		{
      fprintf(stderr, "Strange notification %d\n", i);
		return;
		}
   res = fread(&civ, sizeof(civ), 1, f);
   if (res != 1 || civ.civ_level > 4 || civ.civ_index > 7)
      {
		fprintf(stderr, "Invalid save %d\n", i);
		fclose(f);
		return;
		}
   fclose(f);
		/* build directory name from save file */
	sprintf(buffer, "%s/%s %s of the %s", BASEDIR, 
   	level[civ.civ_level], 
		civ.leaders[civ.civ_index], 
		civ.people[civ.civ_index]);
		
	if (strlen(buffer) > (31 + strlen(BASEDIR)) )
		sprintf(buffer, "%s/%s %s(%s)", BASEDIR,
			shlev[civ.civ_level],
			civ.leaders[civ.civ_index], 
			civ.people[civ.civ_index]);

		/* ensure directory exists */
	dirlock = Lock(buffer, SHARED_LOCK);
	if (!dirlock)
		{
		dirlock = CreateDir(buffer);
		}
	
	if (dirlock)
		{
		FILE *g;
		BPTR olddir, fl;
		int savenumber;
			/* enter right dir */	
		olddir = CurrentDir(dirlock);
		for (savenumber = 0; savenumber < GENSAVES; savenumber++)
			{
				/* get correct file name: up to GENSAVES generations of the same year */
			if (fl = Lock(date2string(civ.civ_date, savenumber), SHARED_LOCK))
				UnLock(fl);
			else
				{
				g = fopen(date2string(civ.civ_date, savenumber), "w");
				if (g)
					{
						/* build save file by concatenating map (fixed size) + sve */
					sprintf(buffer, "ram:civil%d.map", i);
					copy_name2file(g, buffer);
					sprintf(buffer, "ram:civil%d.sve", i);
					copy_name2file(g, buffer);
					fclose(g);
					check_last = stat_buf.st_mtime;
					break;
					}
				}
			}
		(void)CurrentDir(olddir);
		}
	UnLock(dirlock);
	}


void restaure_file(char *name)
	{
	FILE *f, *g;
	int n;
	struct civinfo civ;

		/* check concatenated save file for existence */
	f = fopen(name, "r");
	if (!f)
		{
		fprintf(stderr, "bad file name %s\n", name);
		return;
		}

		/* restaure map: fixed size file */
	g = fopen("ram:civil0.map", "w");
	if (!g)
		{
		fprintf(stderr, "Can't open output file map\n");
		return;
		}
	n = fread(iobuf, MAPSIZE, 1, f);
	if (n != 1)
		{
		fprintf(stderr, "Bad save file");
		return;
		}
	fwrite(iobuf, MAPSIZE, 1, g);
	fclose(g);
			
		/* restaure save file `proper */
	g = fopen("ram:civil0.sve", "w");
	if (!g)
		{
		fprintf(stderr, "Can't open output file save\n");
		return;
		}
	
		/* check that the header looks normal */
	n = fread(&civ, sizeof(civ), 1, f);
	if (n != 1 || civ.civ_level > 4 || civ.civ_index > 7)
		{
		fprintf(stderr, "Bad save file");
		return;
		}
		/* and output file information as failsafe */
	printf("Restauring %s %s of the %s, year %s\n", 
	  	level[civ.civ_level], 
		civ.leaders[civ.civ_index], 
		civ.people[civ.civ_index],
		date2string(civ.civ_date, 0));
		
		/* restaure header */
	fwrite(&civ, sizeof(civ), 1, g);
		/* restaure end of file */
	copy_file2file(g, f);
	fclose(g);
	
	fclose(f);
	}
				

