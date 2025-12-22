#include "amiga/dos/dos.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "structs.h"
#include "m_swap.h"


#define MAPFILE_MAX_SIZE	500


typedef struct {
	char wad1[9];
	char wad2[9];
} MappingStruct;

MappingStruct ChgWord[MAPFILE_MAX_SIZE];
MappingStruct ChgDir[MAPFILE_MAX_SIZE];


void xucase(unsigned char *s)
{
while(*s)
    {
    if( ((*s >96) && (*s<123)) || (*s >223) )
          *s ^= 32 ;
    s++;
    }
}


void *GetMemory( size_t size)
{
	void *ret = malloc( size);
	if (!ret)
	{
		printf( "\nout of memory (cannot allocate %u bytes)\n", size);
		exit(0);
	}

   return ret;
}


int LoadMapfile (char *filename)
{
	FILE *mapfile;
	int i = 0;
	int j = 0;
	int DirType = 0;
	char Text1[9], Text2[9];

	if ((mapfile = fopen(filename, "rt")) == NULL || feof(mapfile))
	{
		printf ("\nError:  Cannot open %s or empty file\n", filename);
		return (1);
	}

	printf ("loading map file:  %s\n", filename);
	while (!feof(mapfile) && i < (MAPFILE_MAX_SIZE - 1) && j < (MAPFILE_MAX_SIZE - 1))
	{
		if (fscanf (mapfile, "%8s %8s", Text1, Text2) < 2)
			break;

		if (Text1[0] == '[')
		{
			if ( (stricmp (Text1, "[textur1") == 0) ||
			     (stricmp (Text1, "[floor1") == 0)  )
			{
				DirType = 0;
			}
			else if ( (stricmp (Text1, "[level1") == 0) ||
				  (stricmp (Text1, "[patch1") == 0) ||
				  (stricmp (Text1, "[music1") == 0) ||
				  (stricmp (Text1, "[sound1") == 0) ||
				  (stricmp (Text1, "[demo1") == 0) )
			{
				DirType = 1;
			}
		}
		else if (DirType)
		{
			strcpy (ChgDir[j].wad1, Text1);
			xucase(Text2);
			strcpy (ChgDir[j].wad2, Text2);
			j++;
		}
		else
		{
			strcpy (ChgWord[i].wad1, Text1);
			xucase(Text2);
			strcpy (ChgWord[i].wad2, Text2);
			i++;
		}
	}

	strcpy (ChgWord[i].wad1, "");
	strcpy (ChgDir[j].wad1, "");

	fclose (mapfile);
	return (0);
}


void ConvertSideDefs (FILE *wad, long int start, long int entries)
{
	struct SideDef *Side_Def = GetMemory( sizeof( struct SideDef));
	char buf[9] = "\0\0\0\0\0\0\0\0\0";
	long int i, j, k;

	fseek (wad, start, SEEK_SET);

	for (i = 0; i < entries; i++)
	{
		fread (Side_Def, sizeof( struct SideDef), 1, wad);

		strncpy (buf, Side_Def->tex1, 8);
		for (j = 0; strlen (ChgWord[j].wad1); j++)
		{
			if (stricmp (buf, ChgWord[j].wad1) == 0)
			{
				strcpy (buf, ChgWord[j].wad2);
				for (k = strlen(buf); k < 8; k++)
					buf[k] = 0;

				fseek (wad, -26, SEEK_CUR);
				for (k = 0; k < 8; k++)
					putc (buf[k], wad);
				fseek (wad, 18, SEEK_CUR);

				printf ("converting...   %8s --> %-8s\n", ChgWord[j].wad1, buf);
				break;
			}
		}

		strncpy (buf, Side_Def->tex2, 8);
		for (j = 0; strlen (ChgWord[j].wad1); j++)
		{
			if (stricmp (buf, ChgWord[j].wad1) == 0)
			{
				strcpy (buf, ChgWord[j].wad2);
				for (k = strlen(buf); k < 8; k++)
					buf[k] = 0;

				fseek (wad, -18, SEEK_CUR);
				for (k = 0; k < 8; k++)
					putc (buf[k], wad);
				fseek (wad, 10, SEEK_CUR);

				printf ("converting...   %8s --> %-8s\n", ChgWord[j].wad1, buf);
				break;
			}
		}

		strncpy (buf, Side_Def->tex3, 8);
		for (j = 0; strlen (ChgWord[j].wad1); j++)
		{
			if (stricmp (buf, ChgWord[j].wad1) == 0)
			{
				strcpy (buf, ChgWord[j].wad2);
				for (k = strlen(buf); k < 8; k++)
					buf[k] = 0;

				fseek (wad, -10, SEEK_CUR);
				for (k = 0; k < 8; k++)
					putc (buf[k], wad);
				fseek (wad, 2, SEEK_CUR);

				printf ("converting...   %8s --> %-8s\n", ChgWord[j].wad1, buf);
				break;
			}
		}
	}
	free (Side_Def);
	printf ("\n");
}


void ConvertSectors (FILE *wad, long int start, long int entries)
{
	struct Sector *SectorI = GetMemory( sizeof( struct Sector));
	char buf[9] = "\0\0\0\0\0\0\0\0\0";
	long int i, j, k;

	fseek (wad, start, SEEK_SET);

	for (i = 0; i < entries; i++)
	{
		fread (SectorI, sizeof( struct Sector), 1, wad);

		strncpy (buf, SectorI->floort, 8);
		for (j = 0; strlen (ChgWord[j].wad1); j++)
		{
			if (stricmp (buf, ChgWord[j].wad1) == 0)
			{
				strcpy (buf, ChgWord[j].wad2);
				for (k = strlen(buf); k < 8; k++)
					buf[k] = 0;

				fseek (wad, -22, SEEK_CUR);
				for (k = 0; k < 8; k++)
					putc (buf[k], wad);
				fseek (wad, 14, SEEK_CUR);

				printf ("converting...   %8s --> %-8s\n", ChgWord[j].wad1, buf);
				break;
			}
		}

		strncpy (buf, SectorI->ceilt, 8);
		for (j = 0; strlen (ChgWord[j].wad1); j++)
		{
			if (stricmp (buf, ChgWord[j].wad1) == 0)
			{
				strcpy (buf, ChgWord[j].wad2);
				for (k = strlen(buf); k < 8; k++)
					buf[k] = 0;

				fseek (wad, -14, SEEK_CUR);
				for (k = 0; k < 8; k++)
					putc (buf[k], wad);
				fseek (wad, 6, SEEK_CUR);

				printf ("converting...   %8s --> %-8s\n", ChgWord[j].wad1, buf);
				break;
			}
		}
	}
	free (SectorI);
	printf ("\n");
}


void ConvertThings (FILE *wad, long int start, long int entries)
{
	struct Thing *ThingI = GetMemory( sizeof( struct Thing));
	long int i;
	long int s = 0L;

	fseek (wad, start, SEEK_SET);

	for (i = 0; i < entries; i++)
	{
		fread (ThingI, sizeof( struct Thing), 1, wad);

		if (SWAPSHORT(ThingI->type) == 2001)
		{
			fseek (wad, -4, SEEK_CUR);
			putc (0x52, wad);
			putc (0x00, wad);
			fseek (wad, 2, SEEK_CUR);
			s++;
		}

	}
	free (ThingI);
	printf ("converting...   %ld Shotguns\n", s);
}



main (int argc, char *argv[])
{
	FILE *wad1, *wad2;
	struct wad_header *wad2_hdr = GetMemory( sizeof( struct wad_header));
	struct directory *dir_entry = GetMemory( sizeof( struct directory));
	char buf[9] = "\0\0\0\0\0\0\0\0\0";
	long int i, j, k, dir_pos;
	int c;
	char ConvertShotGun = 0;


	for (i = 1; i < argc; i++)
	{
		if (stricmp (argv[i], "-s") == 0)
		{
			ConvertShotGun = 1;
			for (j = i; j < (argc - 1); j++)
			{
				argv[j] = argv[j + 1];
			}
			i--;
			argc--;
		}
	}

	printf ("\n*** DOOM1 to DOOM2 pwad converter v1.01 (c) 1994 Tracy F. Thonn ***\n\n");
	printf ("Amigaversion v1.0 (c) 1998 Anders Bylund\n\n");
	if (argc != 3 && argc != 4)
	{
		printf ("Usage:  WAD1TO2 <doom1.wad> <doom2.wad> {file.map} {-s}\n\n");
		printf ("        doom1.wad ...input DOOM1 pwad file to be converted\n");
		printf ("        doom2.wad ...output pwad file for use with DOOM2\n");
		printf ("         file.map ...optional custom texture mapfile (default WAD1TO2.MAP)\n");
		printf ("               -s ...option to convert Shotguns to Super Shotguns\n\n");
		return (1);
	}

	if (stricmp (argv[1], argv[2]) == 0)
	{
		printf ("\nError:  Output file is same as input file\n");
		return (1);
	}

	if (argc == 4)
	{
		if (LoadMapfile(argv[3]))
			return (1);
	}
	else
	{
		if (LoadMapfile("WAD1TO2.MAP"))
			return (1);
	}


	if (access (argv[2], 0) == 0)
	{
		printf ("\nWarning: %s already exists, Overwrite (y/n)?", argv[2]);
		c = toupper(getchar());
		printf ("\n\n");
		if (c != 'Y')
			return (1);
	}

	if ((wad1 = fopen(argv[1], "rb")) == NULL)
	{
		printf ("\nError:  Cannot open %s\n", argv[1]);
		return (1);
	}

	if ((wad2 = fopen(argv[2], "wb+")) == NULL)
	{
		printf ("\nError:  Cannot create %s\n", argv[2]);
		fclose (wad1);
		return (1);
	}



	printf ("copying:  %s to %s\n", argv[1], argv[2]);
	c = getc(wad1);
	if (c != 'P')
	{
		printf ("\nError:  Input %s is not a pwad file\n", argv[1]);
		fclose (wad1);
		fclose (wad2);
		return (1);
	}
	putc ('P', wad2);
	while ((c = getc(wad1)) != EOF)
		putc (c, wad2);
	fclose (wad1);

	printf ("converting...\n");
	fseek (wad2, 0L, SEEK_SET);
	fread(wad2_hdr, sizeof( struct wad_header), 1, wad2);

	dir_pos = SWAPLONG(wad2_hdr->dir_start);

	for (i = 0; i < SWAPLONG(wad2_hdr->num_entries); i++)
	{
		fseek (wad2, dir_pos, SEEK_SET);
		fread (dir_entry, sizeof( struct directory), 1, wad2);
		dir_pos = ftell (wad2);

		strncpy (buf, dir_entry->name, 8);

		for (j = 0; strlen (ChgDir[j].wad1); j++)
		{
			if (stricmp (buf, ChgDir[j].wad1) == 0)
			{
				strcpy (buf, ChgDir[j].wad2);
				for (k = strlen(buf); k < 8; k++)
					buf[k] = 0;

				fseek (wad2, -8, SEEK_CUR);
				for (k = 0; k < 8; k++)
					putc (buf[k], wad2);

				printf ("converting...   %8s --> %-8s\n", ChgDir[j].wad1, buf);
				break;
			}
		}


		if (stricmp (buf, "SIDEDEFS") == 0)
			ConvertSideDefs (wad2, SWAPLONG(dir_entry->start), (SWAPLONG(dir_entry->length)) / sizeof(struct SideDef));

		if (stricmp (buf, "SECTORS") == 0)
			ConvertSectors (wad2, SWAPLONG(dir_entry->start), (SWAPLONG(dir_entry->length)) / sizeof(struct Sector));

		if (ConvertShotGun && (stricmp (buf, "THINGS") == 0))
			ConvertThings (wad2, SWAPLONG(dir_entry->start), (SWAPLONG(dir_entry->length)) / sizeof(struct Thing));
	}


	fclose (wad2);
	return (0);
}


